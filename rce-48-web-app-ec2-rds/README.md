# RCE-48 - Web App with EC2 and RDS

## Overview

This project demonstrates a traditional AWS web application architecture using EC2 for compute and RDS for relational database storage.

The goal was to understand how a web application can run on a virtual server while connecting to a managed database service inside AWS.

This project helped me practice how compute, database, networking, security groups, and Terraform work together in a real cloud architecture.

## What I built

- EC2-based web application infrastructure
- RDS database foundation
- Terraform-based infrastructure setup
- Security group configuration
- Basic networking structure
- Separation between application and database layers

## Architecture

```text
User
→ EC2 Web Server
→ RDS Database
```

A more practical cloud flow:

```text
User request
→ Public EC2 instance / web server
→ Private database layer with RDS
→ Application response back to user
```

## Tech stack

- AWS
- Terraform
- EC2
- RDS
- Security Groups
- VPC basics
- Linux
- Infrastructure as Code

## Why this architecture matters

This is one of the most common basic cloud architecture patterns.

Many real applications need:

- a compute layer to run application code
- a database layer to store data
- network rules to control access
- infrastructure that can be recreated consistently

Using EC2 and RDS helped me understand how a traditional web application can be deployed in AWS and how the application layer connects to the database layer.

## Key learning areas

### EC2 for compute

EC2 represents the server layer of the application.

This helped me understand:

- how virtual machines are used in cloud environments
- how applications can run on cloud compute resources
- how access to servers should be controlled

### RDS for database

RDS represents the managed relational database layer.

This helped me understand:

- why databases should be separated from application servers
- how managed database services reduce operational work
- why database access should be restricted

### Security groups

Security groups control which traffic is allowed between resources.

This helped me understand:

- how to allow web traffic to the application
- how to restrict database access
- why cloud networking rules are important for security

### Terraform and Infrastructure as Code

Terraform was used to define the infrastructure in code.

This helped me understand:

- how infrastructure can be version controlled
- how cloud resources can be created repeatedly
- how documentation and code can support each other

## What I learned

Through this project, I practiced:

- how EC2 and RDS work together in a web application architecture
- how to separate application and database layers
- how security groups control access between resources
- how Terraform can define cloud infrastructure
- how to explain a traditional cloud architecture clearly

## Cost and cleanup

This project is built for learning and portfolio purposes.

Important cleanup principle:

```text
Destroy AWS resources after testing to avoid unnecessary cost.
```

Resources such as EC2 instances and RDS databases can create ongoing cost if left running.

## Future improvements

Possible next improvements:

- add an Application Load Balancer
- place the database in private subnets
- add better architecture diagrams
- add deployment screenshots
- add monitoring with CloudWatch
- add backup and recovery notes
- add a full cleanup proof section

## Status

Completed hands-on AWS architecture project for learning EC2, RDS, Terraform, and traditional web application infrastructure.
