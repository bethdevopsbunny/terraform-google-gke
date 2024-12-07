terraform {
  required_version = "~> v1.10.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.12.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}