resource "datadog_synthetics_test" "test_api" {
  type    = "api"
  subtype = "http"
  request_definition {
    method = "GET"
    url    = "https://b6.cirrus.ai/"
  }
  request_headers = {
    Content-Type   = "application/json"
  }
  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }
  locations = ["aws:eu-central-1"]
  options_list {
    tick_every = 3600

    #investigate more
    #retry {
    #  count    = 2
    #  interval = 300
    #}

    monitor_options {
      renotify_interval = 120
    }
  }
  name    = "[B6 PROD] b6.cirrus.ai test"
  message = "Notify @slack-dd-synthetic-tests-monitor "
  tags    = ["env:prd", "client:b6"]

  status = "live"
}