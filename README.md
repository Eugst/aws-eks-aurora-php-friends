# aws-eks-aurora-php-friends

`make infra` - terraform build AWS: VPC, RDS Aurora, EKS, ECR
`make app` - docker build app image and push to ECR and deploy to EKS
`make test-app` - port-forward to k8s service and open URL in browser
`make destroy` - destroying k8s resources and terraform destroys AWS infrastructure
