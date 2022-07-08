module "remote_state" {
  source      = "../../../tfm/0-remotestate/" #github.com/genesys/multicloud-platform.git//gcp-gke/tfm/0-remotestate?ref=master
  name        = "gts-multicloud-pe-dmitry-tf-statefiles"
  location    = "us-west2" 
}

#Comment out the below block
terraform {
  backend "gcs" {
    bucket = "gts-multicloud-pe-dmitry-tf-statefiles" #Replace with the name of the bucket created above
    prefix = "base-state" #creates a new folder
  }
}
#Commenting ends

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