provider "aws" {
  region = "eu-west-1"
}

locals {
  common_tags = {
    Project     = "RCE-52"
    Repo        = "aws-infrastructure-architectures"
    ManagedBy   = "Terraform"
    Owner       = "titoiunit"
    Environment = "lab"
  }
}

resource "random_password" "db_password" {
  length  = 20
  special = false
}

module "network" {
  source = "./modules/network"

  common_tags = local.common_tags
}

module "fargate_app" {
  source = "./modules/fargate_app"

  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  common_tags       = local.common_tags
}

module "data" {
  source = "./modules/data"

  vpc_id                     = module.network.vpc_id
  private_subnet_ids         = module.network.private_subnet_ids
  ecs_task_security_group_id = module.fargate_app.ecs_task_security_group_id
  db_password                = random_password.db_password.result
  bucket_name                = "titoiunit-428516841589-rce52-static-assets-euw1"
  common_tags                = local.common_tags
}
