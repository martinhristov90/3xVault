provider "aws" {
  region = var.clusters.us.region
  alias  = "hq_provider"
}

provider "aws" {
  region = var.clusters.eu.region
  alias  = "dr_provider"
}

provider "aws" {
  region = var.clusters.ap.region
  alias  = "pr_provider"
}