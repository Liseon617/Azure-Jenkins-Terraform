# Terraform_for_Azure_Template
This repository serves as a template for setting up terraform in any environment to deploy Azure VMs.

This repository serves as a template for deploying a FastAPI application with Prometheus monitoring and Grafana dashboards, all containerized with Docker.

## Overview

This template provides a ready-to-use setup for deploying a VM with Azure alongside other needed resources, based on prior configuration solution, with Terraform.

## Features

- **Terraform**: Pre-configured Terraform application setup **(The provided Template is just a basic example, do replace it with your own Template)**.


## Table of Contents

- [Prerequisites](#prerequisites)
- [Quickstart](#quickstart)
- [VM Configuration](#vmconfiguration)
- [Host OS Configuration](#hostosconfiguration)
- [Documentation](#documentation)
- [Authors](#authors)


## Prerequisites

Ensure you have the following software tools installed:

### Terraform 
**Installation**: Follow the Terraform [installation guide](https://developer.hashicorp.com/terraform/install?product_intent=terraform).\
**Learning**: If unfamiliar with Terraform, consider this getting started [guide](https://developer.hashicorp.com/terraform/install?product_intent=terraform#next-steps).

### Azure Account
**Setup**: You will need a Microsoft Azure account. If you don't have an Azure account, create one [here](https://azure.microsoft.com/en-us/free/).

## Quickstart

1.  Clone the repository
```shell
git clone https://github.com/hiverlab-brian/Terraform_for_Azure_Template.git
```
2. Initiate Terraform
```shell
terraform init
```
3. Review and apply Terraform plan
```shell
terraform plan
terraform apply
```
4. Approve terraform plan by inputting 'yes' when prompted for approval

## VMconfiguration
To customize the VM on creation, change the jenkins/customdata.tpl file for your specific needs, consider the following modifications:

1. Consolidated sudo apt-get install Commands: Grouped package installations to reduce the number of apt-get commands, improving efficiency.
2. Removed Redundant Commands: Combined update commands and reduced multiple executions where possible.
3. Added Variables for Versioning: Used a variable for the Terraform version to make it easier to update in the future.
4. Removed Unnecessary Wait Times: If wait times are required for specific reasons, they can be adjusted. Here, they're kept for clarity but can be reduced or removed based on actual requirements.
5. Added Final Echo for Completion: Indicated the end of the setup process for clarity.

You can further customize the VM configuration in your /jenkins/customdata.tpl file based on specific needs not covered in this script.

## HostOSConfiguration
Ensure the appropriate SSH script for the host OS is available in the /jenkins directory. This script should be named according to the pattern \${var.host_os}-ssh-script.tpl. Verify that the host_os variable is correctly set in the terraform.tfvars file to match the OS of the current user.


## Documentation
[Documentation(set up and configuration)](https://docs.google.com/document/d/1V13yVvlGjnnr_MeRa6ydn9yeDXzCmYuBqHHFOziYqHw/edit#heading=h.hnstmjjlgnbw)

## Authors

* Brian Lim (AI/Backend Engineer Intern)
