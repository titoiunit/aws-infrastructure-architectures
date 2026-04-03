output "asg_name" {
  value = aws_autoscaling_group.main.name
}

output "launch_template_id" {
  value = aws_launch_template.main.id
}

output "cpu_high_alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}

output "cpu_low_alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_low.alarm_name
}

output "vpc_id" {
  value = aws_vpc.main.id
}
