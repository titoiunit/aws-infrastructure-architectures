output "alb_dns_name" {
  value = module.fargate_app.alb_dns_name
}

output "ecs_cluster_name" {
  value = module.fargate_app.ecs_cluster_name
}

output "task_definition_arn" {
  value = module.fargate_app.task_definition_arn
}

output "ecs_service_name" {
  value = module.fargate_app.ecs_service_name
}

output "s3_bucket_name" {
  value = module.data.s3_bucket_name
}

output "rds_endpoint" {
  value = module.data.rds_endpoint
}
