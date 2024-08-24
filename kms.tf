

resource "google_kms_key_ring" "image-auth-keyring" {
  name     = "${var.key_stuff_name}-${random_string.random.result}-ring"
  location = "global"
}

resource "random_string" "random" {
  length           = 6
  special          = false
  override_special = "/@£$"
}

resource "google_kms_crypto_key" "image-auth-asymmetric-sign-key" {
  name     = "${var.key_stuff_name}-${random_string.random.result}-key"
  key_ring = google_kms_key_ring.image-auth-keyring.id
  purpose  = "ASYMMETRIC_SIGN"

  version_template {
    algorithm = "EC_SIGN_P256_SHA256"
  }

  lifecycle {
    prevent_destroy = true
  }
}
