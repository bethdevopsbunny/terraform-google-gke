

resource "google_binary_authorization_policy" "default" {

  count = local.binaryauthorizationcount
  # admission_whitelist_patterns allow you to select entire registries or specific digests that you wish to approve
  # https://github.com/hashicorp/terraform-provider-google/issues/4090 explains the duplication.

  admission_whitelist_patterns {
    name_pattern = "gcr.io/google_containers/*"
  }
  admission_whitelist_patterns {
    name_pattern = "docker.io/nginx@sha256:3f98abd1c64fd7217ee90cf0bef47aa0396686a2a8bda7ecb23ee6cc0bcc0369"
  }

  # default rules apply outside of clusters
  default_admission_rule {
    evaluation_mode  = "ALWAYS_DENY"
    enforcement_mode = "ENFORCED_BLOCK_AND_AUDIT_LOG"
    # This enforcement mode does not prevent images being deployed
    # but logs that they were used. great for a first step.
    # enforcement_mode = "DRYRUN_AUDIT_LOG_ONLY"
  }

  # Kubernetes specific rules
  cluster_admission_rules {
    cluster                 = "${var.region}.${google_container_cluster.default.name}"
    evaluation_mode         = "REQUIRE_ATTESTATION"
    enforcement_mode        = "ENFORCED_BLOCK_AND_AUDIT_LOG"
    require_attestations_by = [google_binary_authorization_attestor.default[count.index].name]
  }
}

resource "google_container_analysis_note" "default-note" {
  count = local.binaryauthorizationcount
  name  = "test-attestor-note"
  attestation_authority {
    hint {
      human_readable_name = "My attestor"
    }
  }
}


data "google_kms_crypto_key_version" "default-version" {
  count      = local.binaryauthorizationcount
  crypto_key = google_kms_crypto_key.image-auth-asymmetric-sign-key.id
}


resource "google_binary_authorization_attestor" "default" {
  count = local.binaryauthorizationcount
  name  = "test-attestor"

  attestation_authority_note {
    note_reference = google_container_analysis_note.default-note[count.index].name
    public_keys {
      id = data.google_kms_crypto_key_version.default-version[count.index].id
      pkix_public_key {
        public_key_pem      = data.google_kms_crypto_key_version.default-version[count.index].public_key[0].pem
        signature_algorithm = data.google_kms_crypto_key_version.default-version[count.index].public_key[0].algorithm
      }
    }
  }
}
