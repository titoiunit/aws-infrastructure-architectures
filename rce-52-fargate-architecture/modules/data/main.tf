variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_task_security_group_id" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "bucket_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = merge(var.common_tags, {
    Name = "rce52-static-assets"
  })
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_security_group" "rds" {
  name        = "rce52-rds-sg"
  description = "Allow PostgreSQL from ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow PostgreSQL only from ECS tasks"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_task_security_group_id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "rce52-rds-sg"
  })
}

resource "aws_db_subnet_group" "this" {
  name       = "rce52-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.common_tags, {
    Name = "rce52-db-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier                 = "rce52-postgres-db"
  engine                     = "postgres"
  instance_class             = "db.t3.micro"
  allocated_storage          = 20
  db_name                    = "appdb"
  username                   = "appadmin"
  password                   = var.db_password
  port                       = 5432
  db_subnet_group_name       = aws_db_subnet_group.this.name
  vpc_security_group_ids     = [aws_security_group.rds.id]
  publicly_accessible        = false
  multi_az                   = false
  storage_encrypted          = true
  backup_retention_period    = 0
  skip_final_snapshot        = true
  delete_automated_backups   = true
  apply_immediately          = true
  auto_minor_version_upgrade = true
  deletion_protection        = false

  tags = merge(var.common_tags, {
    Name = "rce52-postgres-db"
  })
}

output "s3_bucket_name" {
  value = aws_s3_bucket.this.id
}

output "rds_endpoint" {
  value = aws_db_instance.this.address
}
