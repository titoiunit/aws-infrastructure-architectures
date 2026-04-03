provider "aws" {
  region = "eu-west-1"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_src/app.py"
  output_path = "${path.module}/lambda_src/app.zip"
}

locals {
  bucket_name      = "titoiunit-428516841589-rce50-file-events-euw1"
  upload_prefix    = "uploads/"
  processed_prefix = "processed/"

  common_tags = {
    Project     = "RCE-50"
    Repo        = "aws-infrastructure-architectures"
    ManagedBy   = "Terraform"
    Owner       = "titoiunit"
    Environment = "lab"
  }
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_custom_access" {
  statement {
    sid    = "AllowReadUploads"
    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.files.arn}/${local.upload_prefix}*"
    ]
  }

  statement {
    sid    = "AllowWriteProcessed"
    effect = "Allow"

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.files.arn}/${local.processed_prefix}*"
    ]
  }

  statement {
    sid    = "AllowSendMessageToQueue"
    effect = "Allow"

    actions = [
      "sqs:SendMessage"
    ]

    resources = [
      aws_sqs_queue.processed_results.arn
    ]
  }
}

resource "aws_s3_bucket" "files" {
  bucket        = local.bucket_name
  force_destroy = true

  tags = merge(local.common_tags, {
    Name = "rce50-files-bucket"
  })
}

resource "aws_s3_bucket_public_access_block" "files" {
  bucket = aws_s3_bucket.files.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "files" {
  bucket = aws_s3_bucket.files.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "files" {
  bucket = aws_s3_bucket.files.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_sqs_queue" "processed_results" {
  name                       = "rce50-processed-results-queue"
  visibility_timeout_seconds = 30

  tags = merge(local.common_tags, {
    Name = "rce50-processed-results-queue"
  })
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/rce50-file-processor"
  retention_in_days = 7

  tags = local.common_tags
}

resource "aws_iam_role" "lambda_exec" {
  name               = "rce50-file-processor-execution-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_custom_access" {
  name   = "rce50-file-processor-custom-access"
  role   = aws_iam_role.lambda_exec.id
  policy = data.aws_iam_policy_document.lambda_custom_access.json
}

resource "aws_lambda_function" "processor" {
  function_name = "rce50-file-processor"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "app.handler"
  runtime       = "python3.13"
  filename      = data.archive_file.lambda_zip.output_path

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  timeout          = 30
  memory_size      = 128

  environment {
    variables = {
      BUCKET_NAME      = aws_s3_bucket.files.id
      QUEUE_URL        = aws_sqs_queue.processed_results.id
      UPLOAD_PREFIX    = local.upload_prefix
      PROCESSED_PREFIX = local.processed_prefix
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.lambda,
    aws_iam_role_policy_attachment.lambda_basic_execution,
    aws_iam_role_policy.lambda_custom_access
  ]

  tags = merge(local.common_tags, {
    Name = "rce50-file-processor"
  })
}

resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id   = "AllowS3Invoke"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.processor.function_name
  principal      = "s3.amazonaws.com"
  source_arn     = aws_s3_bucket.files.arn
  source_account = "428516841589"
}

resource "aws_s3_bucket_notification" "uploads_to_lambda" {
  bucket = aws_s3_bucket.files.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.processor.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = local.upload_prefix
    filter_suffix       = ".txt"
  }

  depends_on = [
    aws_lambda_permission.allow_s3_invoke
  ]
}
