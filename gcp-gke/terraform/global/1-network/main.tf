module "network" {
    source          = "../../../tfm/1-network/" #github.com/genesys/multicloud-platform.git//gcp-gke/tfm/1-network?ref=master
    provision_vpc   = true
    project_id      = "gts-multicloud-pe-dmitry"
    network_name    = "network01"
    environment     = "environment01" #For naming conventions; can be the same as project name.
    region          = ["us-west2"]
    fqdn            = "cluster01.gcp.demo.genesys.com."

    subnets = [
        {
            subnet_name           = "environment01-us-west2-subnet"
            subnet_ip             = "10.168.0.0/22"
            subnet_region         = "us-west2"
        },
        {
            subnet_name           = "environment01-us-west2-vm-subnet"
            subnet_ip             = "10.168.8.0/22"
            subnet_region         = "us-west2"
        },
        {
            subnet_name           = "environment01-us-west2-privateep-subnet"
            subnet_ip             = "10.168.4.0/22"
            subnet_region         = "us-west2"
        }
    ]
}

provider "google" {
  project = "gts-multicloud-pe-dmitry"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.52.0"
    }
  }

  required_version = "= 1.0.11"
}

terraform {
  backend "gcs" {
    bucket = "gts-multicloud-pe-dmitry-tf-statefiles" #Replace with the name of the bucket created above
    prefix = "network-state" #creates a new folder
  }
}