locals {
  hq_vault_region = var.clusters.us.region
}

locals {
  dr_vault_region = var.clusters.eu.region
}

locals {
  pr_vault_region = var.clusters.ap.region
}