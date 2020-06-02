# EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

See that guide for additional information.

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes master servers. Feel free to replace this as necessary.

»Prerequisites
The guide assumes some basic familiarity with Kubernetes and kubectl but does not assume any pre-existing deployment.

It also assumes that you are familiar with the usual Terraform plan/apply workflow. If you're new to Terraform itself, refer first to the Getting Started guide.

For this guide, you will need:

an AWS account,
a configured AWS CLI
AWS IAM Authenticator
kubectl
wget (required for the eks module)
