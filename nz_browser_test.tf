resource "datadog_synthetics_test" "test_browser" {
  type = "browser"

  request_definition {
    method = "GET"
    url    = "https://nz.cirrus.ai"
  }

  device_ids = ["laptop_large"]
  locations  = ["aws:eu-central-1"]

  options_list {
    tick_every = 3600
  }

  name    = "[NZ PROD] Page Load"
  message = "@slack-dd-synthetic-tests-monitor "
  tags    = ["env:prod", "client:nz"]

  status = "live"

  browser_step {
    name = "Check current url"
    type = "assertCurrentUrl"
    params {
      check = "contains"
      value = "cirrus"
    }
  }
}
