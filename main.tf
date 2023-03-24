terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}


# Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  #api_url = "https://us5.datadoghq.com/"
}


module "nz_browser_test"{
  source = "../terraform-flyr-saas/datadog/syntetcis_test_browser_module"
  target_url = "https://nz.cirrus.ai"
  client = "nz"
  env = "prod"
}
