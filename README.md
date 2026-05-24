# AWS Infrastructure Architectures

Hands-on AWS infrastructure architecture projects built with Terraform, covering static websites, web apps, serverless backends, event-driven systems, auto scaling, and containerized deployments.

## Overview

This repository is a portfolio of practical AWS cloud architecture projects.

The goal is to understand how different AWS services work together in real infrastructure patterns and to document those patterns clearly using Terraform and Infrastructure as Code.

This repository focuses on architecture thinking, not just individual AWS services.

## What this repository demonstrates

- AWS infrastructure architecture patterns
- Terraform-based cloud infrastructure
- Infrastructure as Code
- serverless backend design
- event-driven architecture
- scalable compute architecture
- containerized cloud deployment
- documentation of hands-on cloud projects

## Projects included

```text
rce-48-web-app-ec2-rds
rce-49-serverless-api-backend
rce-50-event-driven-file-processing
rce-51-ec2-auto-scaling
rce-52-fargate-architecture
website
```

## Architecture projects

### 1. Web App with EC2 and RDS

A traditional web application architecture using compute and relational database services.

Focus areas:

- EC2
- RDS
- networking basics
- security groups
- Terraform infrastructure
- web application hosting

What this project shows:

- how a basic web application can be hosted on AWS
- how compute and database services connect
- how infrastructure can be described with Terraform

---

### 2. Serverless API Backend

A serverless backend architecture using managed AWS services.

Focus areas:

- API Gateway
- Lambda
- DynamoDB
- serverless application design
- request and response flow

What this project shows:

- how to build backend logic without managing servers
- how serverless services can work together
- how API requests can trigger cloud functions

---

### 3. Event-Driven File Processing

An event-driven cloud architecture where file uploads trigger backend processing.

Focus areas:

- S3
- Lambda
- SNS / SQS concepts
- event-driven workflows
- asynchronous processing

What this project shows:

- how cloud systems can react to events
- how file uploads can trigger automation
- how event-driven architecture helps decouple services

---

### 4. EC2 Auto Scaling

A scalable compute architecture using EC2 Auto Scaling.

Focus areas:

- EC2
- Auto Scaling Groups
- launch templates
- scaling concepts
- high availability basics

What this project shows:

- how infrastructure can scale based on demand
- how multiple instances can support availability
- how AWS can help reduce manual capacity management

---

### 5. Fargate Architecture

A containerized cloud application architecture using serverless containers.

Focus areas:

- Docker
- ECS / Fargate concepts
- container deployment
- scalable application hosting
- managed container infrastructure

What this project shows:

- how containers can run in AWS without managing servers directly
- how containerized applications fit into cloud architecture
- how Fargate supports modern deployment patterns

---

### 6. Static Website

A simple static website architecture.

Focus areas:

- static hosting
- basic website deployment
- cloud storage / hosting concepts
- simple frontend delivery

What this project shows:

- how static content can be hosted in the cloud
- how simple cloud architectures can be cost-effective
- how small projects can still demonstrate real infrastructure thinking

## Tech stack

- AWS
- Terraform
- HCL
- Python
- Shell
- HTML
- Infrastructure as Code
- Cloud architecture

## Why this project matters

Cloud engineers need to understand how services connect together.

It is not enough to know only one service at a time. Real cloud systems are built from multiple parts that work together:

```text
user request
→ networking / entry point
→ compute
→ data storage
→ automation
→ monitoring / operations
```

This repository helps me practice that architecture mindset through hands-on projects.

## What I learned

Through these projects, I practiced:

- how to compare different AWS architecture patterns
- when traditional compute makes sense
- when serverless makes sense
- when containers make sense
- how event-driven systems work
- how auto scaling supports availability
- how Terraform helps document and repeat infrastructure
- how to explain cloud architecture in a clear and practical way

## Security and cost notes

These projects are built for learning and portfolio purposes.

Important principles:

- do not commit secrets
- do not commit Terraform state files
- avoid committing generated local files
- use least privilege where possible
- destroy cloud resources after testing to avoid unnecessary cost
- document cleanup steps when possible

## Future improvements

Possible next improvements:

- add simple architecture diagrams for each project
- add screenshots or proof of deployment
- add cleanup proof for each lab
- improve each project README
- add cost notes per architecture
- add AWS-to-Azure comparison notes later

## Status

Active hands-on AWS architecture portfolio.
