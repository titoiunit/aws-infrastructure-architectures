output "bucket_name" {
  value = aws_s3_bucket.files.id
}

output "upload_prefix" {
  value = "uploads/"
}

output "processed_prefix" {
  value = "processed/"
}

output "lambda_function_name" {
  value = aws_lambda_function.processor.function_name
}

output "queue_url" {
  value = aws_sqs_queue.processed_results.id
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.lambda.name
}
