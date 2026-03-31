provider "aws" {
  region = "eu-west-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

locals {
  project_name = "rce48-web-app"

  vpc_cidr             = "10.48.0.0/16"
  public_subnet_cidr   = "10.48.1.0/24"
  private_subnet_a_cidr = "10.48.11.0/24"
  private_subnet_b_cidr = "10.48.12.0/24"

  db_name     = "appdb"
  db_username = "appadmin"

  common_tags = {
    Project     = "RCE-48"
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

resource "aws_vpc" "main" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "rce48-vpc"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "rce48-igw"
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "rce48-public-subnet"
  })
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnet_a_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(local.common_tags, {
    Name = "rce48-private-subnet-a"
  })
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnet_b_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(local.common_tags, {
    Name = "rce48-private-subnet-b"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "rce48-public-rt"
  })
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "rce48-private-rt"
  })
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "ec2" {
  name        = "rce48-ec2-sg"
  description = "Allow HTTP to EC2"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "rce48-ec2-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "ec2_http_ipv4" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP from anywhere"
}

resource "aws_vpc_security_group_ingress_rule" "ec2_http_ipv6" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv6         = "::/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP from anywhere over IPv6"
}

resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound_ipv4" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound IPv4"
}

resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound_ipv6" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound IPv6"
}

resource "aws_security_group" "rds" {
  name        = "rce48-rds-sg"
  description = "Allow PostgreSQL only from EC2"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "rce48-rds-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "rds_postgres_from_ec2" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.ec2.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "Allow PostgreSQL only from EC2 security group"
}

resource "aws_vpc_security_group_egress_rule" "rds_all_outbound_ipv4" {
  security_group_id = aws_security_group.rds.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound IPv4"
}

resource "aws_db_subnet_group" "main" {
  name       = "rce48-db-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = merge(local.common_tags, {
    Name = "rce48-db-subnet-group"
  })
}

resource "aws_db_instance" "postgres" {
  identifier                   = "rce48-postgres-db"
  engine                       = "postgres"
  instance_class               = "db.t3.micro"
  allocated_storage            = 20
  db_name                      = local.db_name
  username                     = local.db_username
  password                     = random_password.db_password.result
  db_subnet_group_name         = aws_db_subnet_group.main.name
  vpc_security_group_ids       = [aws_security_group.rds.id]
  publicly_accessible          = false
  multi_az                     = false
  storage_encrypted            = true
  skip_final_snapshot          = true
  backup_retention_period      = 0
  delete_automated_backups     = true
  apply_immediately            = true
  auto_minor_version_upgrade   = true

  tags = merge(local.common_tags, {
    Name = "rce48-postgres-db"
  })
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_ssm_role" {
  name               = "rce48-ec2-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_core" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "rce48-ec2-instance-profile"
  role = aws_iam_role.ec2_ssm_role.name
}

resource "aws_instance" "web" {
  ami                         = data.aws_ssm_parameter.al2023_ami.value
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  associate_public_ip_address = true

  credit_specification {
    cpu_credits = "standard"
  }

  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    db_host     = aws_db_instance.postgres.address
    db_name     = local.db_name
    db_user     = local.db_username
    db_password = random_password.db_password.result
  })

  tags = merge(local.common_tags, {
    Name = "rce48-web-ec2"
  })
}
