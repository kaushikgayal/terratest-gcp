# Managing infrastructure as code with Terraform and testing using Terraform test in GCP
This is a repo to provide a quick demo on using Terraform test released in 1.6.x version of Terraform.
This repo is using GCP to create a VM in a subnet and testing the html page accessibility from Internet.

## Configuring your **dev** environment

Just for demostration, this step will:
 1. Configure an apache2 http server on network '**dev**' and subnet '**dev**-subnet-01'
 2. Open port 80 on firewall for this http server 

```bash
cd ../environments/dev
terraform init
terraform plan
terraform apply
terraform destroy
```
## Testing the http_server module

The http_server.tftest.hcl file contains all the tests to run which uses main.tf terraform code to use as a helper. Helper module is used to provide the data objects of already created resources (Apache server).

Step to run tests:
Execute below command to get GCP Token
```bash
export MYTOKEN=$(gcloud auth print-access-token)
```
Copy the token value and paste it in http_server.tftest.hcl variables section

```bash
cd ../environments/dev
terraform init
terraform test
```