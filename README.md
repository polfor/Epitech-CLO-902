# CLO-902 Kubernetes Cluster

This repository contains the configuration files and documentation for the CLO-902 Kubernetes cluster. The cluster is hosted on Azure and is provisioned using Terraform and configured using Ansible.

## Introduction

The CLO-902 Kubernetes cluster is designed to provide a scalable and reliable platform for running containerized applications. It leverages the power of Kubernetes to manage and orchestrate containers, allowing for efficient deployment, scaling, and management of applications.

## Infrastructure Provisioning

The infrastructure for the cluster is provisioned using Terraform. Terraform allows us to define and manage the infrastructure as code, making it easy to create and update the necessary resources on Azure. The Terraform configuration files can be found in the `terraform` directory.

## Cluster Configuration

Once the infrastructure is provisioned, the cluster is configured using Ansible. Ansible is an open-source automation tool that allows us to define and manage the desired state of the cluster. The Ansible playbooks and roles can be found in the `ansible` directory.

## Virtual Environment (venv) Setup

To ensure a clean and isolated development environment, we recommend using a virtual environment (venv) for managing the dependencies of your project. A virtual environment allows you to install project-specific packages without interfering with the system-wide Python installation.

To set up a virtual environment, follow these steps:

1. Open a terminal and navigate to the root directory of your project.
2. Create a new virtual environment by running the following command:

   ```bash
   python3 -m venv venv
   ```

3. Activate the virtual environment by running the appropriate command for your operating system:

   - For macOS and Linux:

     ```bash
     source venv/bin/activate
     ```

   - For Windows:

     ```bash
     venv\Scripts\activate
     ```

4. Once the virtual environment is activated, you can install the required dependencies using `pip`. For example:

   ```bash
   pip install -r requirements.txt
   ```

5. You're now ready to start developing within the virtual environment!

Remember to always activate the virtual environment before working on your project to ensure that you're using the correct dependencies.

TO IMPLEMENT :

KUBESPRAY
TELEGRAF + ELK
ENV HPROD + PROD
COMPARTIMENTER
CREER USERS (1 HPROD, 1 ADMIN)
