resource "datadog_monitor" "total_host" {
  name               = "total_host"
  type               = "query alert"
  message            = "Monitor triggered.  @ulises.olvera@flyrlabs.com "
  #escalation_message = "Escalation message @pagerduty"

  query = "avg(last_5m):count_not_null(avg:system.cpu.user{*} by {host}) > 55"

  monitor_thresholds {
    critical = 55
  }

  tags = ["Costs", "GCP_Updates"]
}