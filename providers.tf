provider "aws" {
  region = var.clusters.us.region
  alias  = "us-provider"
}

provider "aws" {
  region = var.clusters.eu.region
  alias  = "eu-provider"
}

provider "aws" {
  region = var.clusters.ap.region
  alias  = "ap-provider"
}