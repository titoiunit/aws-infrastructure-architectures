# RCE-49 - Serverless API Backend

## Overview

This project demonstrates a serverless backend architecture on AWS using API Gateway, Lambda, and DynamoDB.

The goal was to understand how a backend API can be built without managing servers directly.

This project helped me practice how API requests, serverless compute, database storage, and Terraform work together in a cloud-native backend architecture.

## What I built

- API Gateway entry point
- AWS Lambda function for backend logic
- DynamoDB table for data storage
- Terraform-based infrastructure setup
- Basic serverless request flow
- Lightweight backend API architecture

## Architecture

```text
Client request
→ API Gateway
→ Lambda
→ DynamoDB
→ JSON response
```

A more practical cloud flow:

```text
User / client
→ API Gateway receives HTTP request
→ Lambda runs backend logic
→ DynamoDB stores or reads data
→ Lambda returns response
→ API Gateway sends response back to client
```

## Tech stack

- AWS
- Terraform
- API Gateway
- Lambda
- DynamoDB
- Python
- Serverless architecture
- Infrastructure as Code

## Why this architecture matters

Serverless architecture is useful when an application needs backend functionality without managing traditional servers.

Instead of provisioning and maintaining virtual machines, the backend can use managed AWS services that scale based on demand.

This project helped me understand how cloud-native APIs can be built using smaller managed components that work together.

## Key learning areas

### API Gateway

API Gateway acts as the public entry point for the backend API.

This helped me understand:

- how HTTP requests enter a serverless backend
- how routes can connect to backend logic
- why an API entry point is needed before Lambda

### Lambda

Lambda runs the backend logic without requiring a server to be managed manually.

This helped me understand:

- how serverless functions work
- how code can run only when triggered
- how backend logic can be separated into small functions

### DynamoDB

DynamoDB provides a serverless NoSQL database layer.

This helped me understand:

- how data can be stored without managing a database server
- how serverless applications can use managed databases
- why DynamoDB fits well with event-driven and serverless systems

### Terraform and Infrastructure as Code

Terraform was used to define the infrastructure in code.

This helped me understand:

- how serverless resources can be created repeatably
- how API, compute, and database resources can be managed together
- how Infrastructure as Code supports documentation and version control

## What I learned

Through this project, I practiced:

- how API Gateway, Lambda, and DynamoDB work together
- how serverless APIs are structured
- how backend logic can run without managing servers
- how Terraform can define serverless infrastructure
- how to explain a serverless request flow clearly

## Cost and cleanup

This project is built for learning and portfolio purposes.

Important cleanup principle:

```text
Destroy AWS resources after testing to avoid unnecessary cost.
```

Serverless services can be cost-efficient, but resources should still be cleaned up after testing.

## Future improvements

Possible next improvements:

- add API request examples
- add screenshots of API testing
- add better architecture diagrams
- add error handling examples
- add authentication with Cognito or IAM
- add CloudWatch logging notes
- add a full cleanup proof section

## Status

Completed hands-on AWS architecture project for learning API Gateway, Lambda, DynamoDB, Terraform, and serverless backend design.
