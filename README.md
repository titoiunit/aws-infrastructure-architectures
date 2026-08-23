# AWS Infrastructure Architectures

Implementation-level AWS architecture labs built with Terraform.

This repository is organized around a simple question: **which AWS pattern best fits the workload, and what are the security, operations and cost trade-offs?** Each lab contains real infrastructure code rather than a service-by-service checklist.

## Architecture portfolio

| Lab | Pattern | Engineering signals |
|---|---|---|
| [RCE-47 — Static delivery](./website) | Private S3 origin + CloudFront + Origin Access Control | HTTPS redirect, private origin, cache behavior and least-privilege bucket access |
| [RCE-48 — Web app + database](./rce-48-web-app-ec2-rds) | EC2 in a public subnet + PostgreSQL RDS in private subnets | VPC design, security-group references, encrypted database storage and SSM-based host access |
| [RCE-49 — Serverless API](./rce-49-serverless-api-backend) | API Gateway + Lambda + DynamoDB | API routes, least-privilege IAM, VPC-attached Lambda, CloudWatch logs and DynamoDB gateway endpoint |
| [RCE-50 — Event-driven files](./rce-50-event-driven-file-processing) | S3 upload → Lambda → processed S3 object + SQS result message | Event filters, scoped IAM, encrypted S3, asynchronous hand-off and log retention |
| [RCE-51 — EC2 Auto Scaling](./rce-51-ec2-auto-scaling) | Launch template + Auto Scaling Group + CloudWatch alarms | Multi-AZ capacity, health checks, scale-out/in policies and alarm-driven operations |
| [RCE-52 — Container platform](./rce-52-fargate-architecture) | ECS Fargate with reusable network, application and data modules | Container workload design, module boundaries and private data-layer thinking |

## How to read a lab

Each completed lab should answer:

1. **What problem is this architecture solving?**
2. **Why were these services selected over alternatives?**
3. **Where are the trust and network boundaries?**
4. **How is the important path validated and observed?**
5. **What would change before production?**
6. **What must be destroyed after a learning run?**

The portfolio standard is documented in the main [Cloud & DevOps Portfolio](https://github.com/titoiunit/cloud-engineering-portfolio/tree/main/lab-standards).

## Common engineering practices

- Terraform is used to make infrastructure repeatable and reviewable.
- Resources are tagged by project, owner, environment and management method.
- Public access is blocked on S3 labs unless the architecture explicitly requires an edge service.
- Data layers are isolated behind dedicated security groups or private subnets.
- CloudWatch logs and alarms are introduced where the workload needs operational visibility.
- Temporary resources are destroyed after validation to control spend.

## Scope and honesty

These are hands-on portfolio labs, not claims that every control is production-complete. When a lab uses a simplified choice for learning speed or cost, the README identifies the next hardening step. That distinction is intentional: it shows both implementation skill and engineering judgment.

## Next depth-building work

- blue/green ECS deployments and rollback validation
- recovery, RTO/RPO and Multi-AZ trade-offs
- endpoint policies and private service access
- secrets rotation, monitoring runbooks and backup testing

## Tech

AWS · Terraform · Python · Docker · Linux · IAM · VPC · CloudWatch · CI/CD
