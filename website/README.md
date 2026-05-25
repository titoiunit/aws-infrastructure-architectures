# RCE-47 - Static Website Hosting

## Overview

This project demonstrates a simple static website hosting architecture on AWS.

The goal was to understand how static website files can be hosted in the cloud using AWS services and how a simple frontend project can be documented as part of a cloud infrastructure portfolio.

This project helped me practice the basic flow of hosting static content, organizing project files, and thinking about simple cloud delivery architecture.

## What I built

- Static website project structure
- Basic HTML / frontend files
- Cloud hosting architecture foundation
- Documentation for static website deployment
- Foundation for S3 and CloudFront style hosting
- Simple portfolio-ready website example

## Architecture

```text
User
→ Static website endpoint
→ HTML / CSS / frontend files
→ Website displayed in browser
```

A more practical AWS cloud flow:

```text
User request
→ CloudFront / website endpoint
→ S3 static website files
→ Browser renders the website
```

## Tech stack

- AWS
- S3 concepts
- CloudFront concepts
- HTML
- CSS
- Static website hosting
- Cloud infrastructure basics

## Why this architecture matters

Static website hosting is one of the simplest and most useful cloud architecture patterns.

It is commonly used for:

- portfolio websites
- landing pages
- documentation sites
- simple frontend projects
- marketing pages
- static web applications

This project helped me understand how cloud storage and content delivery can be used to host simple websites without running a traditional server.

## Key learning areas

### Static website hosting

Static websites do not need a backend server for every request.

This helped me understand:

- how HTML, CSS, and frontend files can be served directly
- why static hosting is simple and cost-effective
- how cloud storage can be used for website delivery

### S3 concepts

S3 can be used to store static website files such as HTML, CSS, JavaScript, and images.

This helped me understand:

- how object storage works
- how files can be organized for website hosting
- why S3 is useful for static content

### CloudFront concepts

CloudFront can be used as a content delivery layer in front of static website files.

This helped me understand:

- how content delivery networks improve performance
- how users can access website content through an edge network
- why CloudFront is often paired with S3 for static websites

### Simple cloud architecture thinking

Even a small static website can demonstrate real cloud architecture thinking.

This helped me understand:

- how user requests flow through cloud services
- how simple architectures can be documented clearly
- why cost-effective solutions matter in cloud design

## What I learned

Through this project, I practiced:

- how static websites can be hosted in the cloud
- how S3 and CloudFront concepts support frontend delivery
- how to think about simple web hosting architecture
- how to document a small cloud project clearly
- how static website hosting differs from server-based hosting

## Cost and cleanup

This project is built for learning and portfolio purposes.

Important cleanup principle:

```text
Delete cloud resources after testing to avoid unnecessary cost.
```

S3 storage is usually low-cost, but CloudFront distributions, storage usage, and related resources should still be reviewed and cleaned up after testing.

## Future improvements

Possible next improvements:

- add deployment screenshots
- add S3 bucket setup notes
- add CloudFront distribution notes
- add custom domain notes
- add HTTPS / certificate notes
- add Terraform version
- add full cleanup proof section

## Status

Completed hands-on AWS static website project for learning static hosting, S3 concepts, CloudFront concepts, and simple cloud delivery architecture.
