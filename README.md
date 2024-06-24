# S208: Deploying a Highly Available & Scalable Wordpress Server on AWS

## Overview

This module focuses on deploying a highly available and scalable Wordpress server using AWS Cloud infrastructure and services. 

key Components are:

> - VPC
> - Subnets (Public & Private)
> - Nat gateway
> - Internet Gateway
> - Security Groups
> - Route Tables
> - Application load balancer
> - Target group
> - Autoscailing group
> - AWS Certificate Manager
> - Route 53
> - Launch configuration

## Learning Outcomes

> - Learning about Terraform and best practices for using terraform.
> - Creating a Virtual Private Cloud
> - Creating subnets, Internet gateway and security groups in the vpc.
> - Using Route 53 and ACM to generate and validate SSL certificates.
> - Creating a Launch Configuration and Autoscaling Group ( Scalability )
> - Creating an Application Load Balancer and Target Group  ( Availability )

### Installation Instructions

You need to install the following tools:

> - [Terraform](https://www.terraform.io/downloads)
> - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
> - [Terraform docs](https://terraform-docs.io/user-guide/installation/)
> - [AWS IAM User Account](https://aws.amazon.com/console/)  
> - [Wordpress](https://wordpress.org/download/)

## Getting Started

1.  To initialize the working directory and download the required provider and modules, run the following command:

		`terraform init` 

2.  To see the changes Terraform will make to your AWS environment, run the following command:

		`terraform plan` 

3.  If the plan looks good, run the following command to create the resources:

		`terraform apply` 

4.  To delete the resources, run the following command:

		`terraform destroy` 

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | ./modules/acm | n/a |
| <a name="module_loadbalancer"></a> [alb](#module\_loadbalancer) | ./modules/alb | n/a |
| <a name="module_webserver"></a> [asg](#module\_webserver) | ./modules/asg | n/a |
| <a name="module_route53"></a> [route53](#module\_route53) | ./modules/route53 | n/a |
| <a name="module_subnet"></a> [vpc](#module\_subnet) | ./modules/vpc | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arn"></a> [acm](#output\acm\certificate_arn) | n/a |
| <a name="output_target_group_arn"></a> [loadbalancer](#output\loadbalancer\target_group_arn) | n/a |
| <a name="output_zone_id"></a> [loadbalancer](#output\loadbalancer\zone_id) | n/a |
| <a name="output_dns_name"></a> [loadbalancer](#output\loadbalancer\dns_name) | n/a |
| <a name="output_route53_zone_id"></a> [route53](#output\route53\route53_zone_id) | n/a |
| <a name="output_private_subnet_ids"></a> [subnet](#output\subnet\private_subnet_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [subnet](#output\subnet\public_subnet_ids) | n/a |
| <a name="output_security_group_id"></a> [webserver](#output\webserver\security_group_id) | n/a |

## Outputs

| Name | Description |
|------|-------------|
| [wordpress_url] | URL of Wordpress server |
| [rds_endpoint]  | RDS database endpoint |
| [alb_endpoint]  | Load balancer endpoint for the Wordpress Server |

## Getting Started
