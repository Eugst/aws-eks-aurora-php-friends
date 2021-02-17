# PHP method finding a shortest path between 2 members via their friends

## Requirements:
1. [AWS cli](https://aws.amazon.com/cli/)  
2. [Terraform](https://www.terraform.io/)  
3. [Docker](https://www.docker.com/)  
4. [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)  


## Before usage:
check and update variables [in Makefile](Makefile):
1. `profile`  
2. `region`  
3. `aws_cred_file`

## Usage:
`make infra`    - terraform build AWS: VPC, RDS Aurora, EKS, ECR  
`make build`    - build docker image  
`make push`     - push docker image to ECR  
`make deploy`   - deploy k8s resources to EKS  
`make app`      - include previous 3 makes: docker build app image and push to ECR and deploy to EKS  
`make all`      - include all above: creating AWS infrastructure, build and deploy app  
`make test-app` - port-forward to k8s service and open URL in browser  
`make destroy`  - destroy k8s resources and by terraform destroy AWS infrastructure  

## Structure:
[aws](aws)  
\- [db_backup.sql](aws/db_backup.sql) contain DB creation and fixtures.   
\- terraform files: [main.tf](aws/main.tf), [output.tf](aws/output.tf), [variables.tf](aws/variables.tf)  
[composer.json](composer.json) contain PHP dependencies  
[Dockerfile](Dockerfile) declare Apps  
[index.php](index.php) contain business logic for search shortest friendship between 2 users  
[k8s.yaml.template](k8s.yaml.template) contain templated kubernetes resources   
[Makefile](Makefile) main orchestrator for creation infrastructure, build and deploy App  
