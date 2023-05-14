terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.65.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
    utils = {
      source  = "cloudposse/utils"
      version = "~> 1.8.0"
    }
  }

  required_version = "~> 1.4.0"
}