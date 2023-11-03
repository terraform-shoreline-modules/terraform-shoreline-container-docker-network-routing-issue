terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "docker_network_routing_issue" {
  source    = "./modules/docker_network_routing_issue"

  providers = {
    shoreline = shoreline
  }
}