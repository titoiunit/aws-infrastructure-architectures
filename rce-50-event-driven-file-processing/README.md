# RCE-50 - Event-Driven File Processing

## Overview

This project demonstrates an event-driven file processing architecture on AWS using S3, Lambda, and messaging concepts such as SNS / SQS.

The goal was to understand how cloud systems can react automatically when a file is uploaded.

This project helped me practice how storage events, serverless compute, event triggers, and Terraform work together in an event-driven cloud architecture.

## What I built

- S3 bucket for file uploads
- Event trigger for new uploaded files
- AWS Lambda function for file processing logic
- Terraform-based infrastructure setup
- Basic event-driven workflow
- Foundation for asynchronous cloud processing

## Architecture

```text
File upload
→ S3 Bucket
→ Lambda Trigger
→ File processing logic
→ Optional notification / queue
```

A more practical cloud flow:

```text
User uploads a file
→ S3 stores the file
→ S3 event triggers Lambda
→ Lambda processes the file
→ Result can be logged, stored, queued, or sent as a notification
```

## Tech stack

- AWS
- Terraform
- S3
- Lambda
- SNS / SQS concepts
- Python
- Event-driven architecture
- Infrastructure as Code

## Why this architecture matters

Event-driven architecture is useful when a system needs to react automatically to something that happens.

Instead of constantly checking for new files, the system can wait for an event and then trigger the correct processing logic.

This pattern is common in cloud systems such as:

- image processing
- document processing
- log processing
- data pipelines
- automation workflows
- file upload systems

This project helped me understand how AWS services can work together without requiring a constantly running server.

## Key learning areas

### S3 for file storage

S3 acts as the storage layer for uploaded files.

This helped me understand:

- how files can be stored in cloud object storage
- how S3 can trigger events
- why object storage is useful for file-based workflows

### Lambda for processing

Lambda runs the processing logic when a file event happens.

This helped me understand:

- how serverless functions can react to events
- how backend logic can run only when needed
- how event triggers can replace manual or scheduled checks

### Event-driven workflow

The system is built around events instead of direct user requests.

This helped me understand:

- how cloud services can react automatically
- how event-driven systems reduce manual work
- how asynchronous workflows can improve scalability

### SNS / SQS concepts

Messaging services can be used to send notifications or queue work for later processing.

This helped me understand:

- how notifications can be sent after an event
- how queues can decouple services
- why asynchronous processing is useful in cloud systems

### Terraform and Infrastructure as Code

Terraform was used to define the infrastructure in code.

This helped me understand:

- how event-driven infrastructure can be created repeatably
- how storage, compute, and messaging resources connect together
- how Infrastructure as Code supports documentation and version control

## What I learned

Through this project, I practiced:

- how S3 events can trigger Lambda functions
- how event-driven systems work in AWS
- how serverless compute can process uploaded files
- how SNS / SQS concepts support asynchronous architecture
- how Terraform can define event-driven cloud infrastructure
- how to explain an event-driven architecture clearly

## Cost and cleanup

This project is built for learning and portfolio purposes.

Important cleanup principle:

```text
Destroy AWS resources after testing to avoid unnecessary cost.
```

Storage buckets, Lambda functions, queues, topics, and related resources should be removed after testing.

## Future improvements

Possible next improvements:

- add screenshots of file upload testing
- add example input and output files
- add CloudWatch log screenshots
- add SNS notification example
- add SQS queue processing example
- add better architecture diagrams
- add a full cleanup proof section

## Status

Completed hands-on AWS architecture project for learning S3, Lambda, event-driven workflows, Terraform, and asynchronous cloud processing.
