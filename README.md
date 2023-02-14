# PORTFOLIO-TERRAFORM
Is a repository created by Yotam Halperin, and designed to create a EKS cluster ifrastructure in Amazon Web Services.

### The cluster will contain:
- network module:
VPC, Subnets, IGW, Routing Table

- ekscluster module:
EKS Cluster, Node group, Helm, ArgoCD Helm chart,  

prerequisites:
1. aws cli installed - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
2. terraform installed - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

to create the infrastructure you first need to authenticate with AWS with the following command:
<aws configure>

- enter your AWS access key && secret access key

now let's apply the enviroment to the cloud with-
<terraform apply --auto-approve>

* you can also change the the default variables that placed in variables.tf


When installed you can get cluster info by running the init.sh script with:
<bash init.sh>