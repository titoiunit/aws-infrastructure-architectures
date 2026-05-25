# RCE-51 - EC2 Auto Scaling

## Overview

This project demonstrates a scalable AWS compute architecture using EC2 Auto Scaling.

The goal was to understand how cloud infrastructure can automatically adjust compute capacity based on demand.

This project helped me practice how EC2 instances, launch templates, Auto Scaling Groups, load balancing concepts, and Terraform work together in a scalable cloud architecture.

## What I built

- EC2 Auto Scaling architecture
- Launch template foundation
- Auto Scaling Group configuration
- Terraform-based infrastructure setup
- Basic scalable compute structure
- Foundation for high availability and demand-based scaling

## Architecture

```text
User request
→ Load balancing layer
→ Auto Scaling Group
→ EC2 instances
→ Application response
```

A more practical cloud flow:

```text
User traffic increases
→ Load balancing layer distributes requests
→ Auto Scaling Group manages EC2 capacity
→ New EC2 instances can be added when needed
→ Application remains more available under changing demand
```

## Tech stack

- AWS
- Terraform
- EC2
- Auto Scaling Groups
- Launch Templates
- Load Balancing concepts
- Security Groups
- Infrastructure as Code

## Why this architecture matters

Auto Scaling is important because cloud applications should not depend on only one manually managed server.

A scalable architecture can help applications handle changing traffic more reliably.

This project helped me understand how AWS can manage compute capacity more automatically instead of requiring manual server management.

Common use cases include:

- web applications with changing traffic
- applications that need better availability
- systems that should recover from instance failure
- infrastructure that should scale based on demand
- production-style compute environments

## Key learning areas

### EC2 for compute

EC2 represents the virtual machine layer of the application.

This helped me understand:

- how cloud servers run application workloads
- how compute resources support application hosting
- why one server is often not enough for production-style systems

### Launch Templates

Launch templates define how new EC2 instances should be created.

This helped me understand:

- how instance configuration can be reused
- how Auto Scaling Groups know what type of instances to launch
- why repeatable server configuration matters

### Auto Scaling Groups

Auto Scaling Groups manage the number of EC2 instances.

This helped me understand:

- how AWS can add or remove compute capacity
- how infrastructure can respond to changing demand
- how scaling supports availability and reliability

### Load balancing concepts

A load balancing layer helps distribute traffic across multiple instances.

This helped me understand:

- why traffic should not depend on one server
- how requests can be shared across multiple instances
- how load balancing supports scalable architecture

### Terraform and Infrastructure as Code

Terraform was used to define the infrastructure in code.

This helped me understand:

- how scalable infrastructure can be created repeatably
- how EC2, launch templates, and Auto Scaling Groups connect together
- how Infrastructure as Code supports documentation and version control

## What I learned

Through this project, I practiced:

- how EC2 Auto Scaling works
- how launch templates support repeatable instance creation
- how Auto Scaling Groups manage compute capacity
- how scalable cloud architecture improves reliability
- how Terraform can define scaling infrastructure
- how to explain an auto scaling architecture clearly

## Cost and cleanup

This project is built for learning and portfolio purposes.

Important cleanup principle:

```text
Destroy AWS resources after testing to avoid unnecessary cost.
```

EC2 instances, Auto Scaling Groups, load balancers, and related resources can create ongoing cost if left running.

## Future improvements

Possible next improvements:

- add an Application Load Balancer
- add scaling policies based on CPU usage
- add CloudWatch metrics and alarms
- add deployment screenshots
- add health check configuration notes
- add better architecture diagrams
- add a full cleanup proof section

## Status

Completed hands-on AWS architecture project for learning EC2 Auto Scaling, launch templates, Terraform, and scalable compute infrastructure.
