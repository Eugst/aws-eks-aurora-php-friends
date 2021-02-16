.PHONY: all infra image build push deploy destroy version_upgrade
profile="eugene.st"
region=eu-west-1
aws_cred_file="~/.aws/credentials"
aws_account_id=$(shell aws sts get-caller-identity  --profile=$(profile) |jq -r ".Account")
app_version=$(shell cat ./version | awk -F. '{$$NF = $$NF + 1;} 1' | sed 's/ /./g')
kubeconfig=$(shell ls ./aws/kubeconfig_eugene-eks-*)

all: infra app

infra:
	cd aws && \
	terraform init && \
	terraform apply -var "aws_cred_profile=$(profile)" -var "aws_cred_file=$(aws_cred_file)" -auto-approve && \
	cd ..

app: image deploy version_upgrade

version_upgrade:
	echo $(app_version) > ./version

image: build push

build:
	docker build -t $(aws_account_id).dkr.ecr.$(region).amazonaws.com/eugene-app:$(app_version) .

push:
	aws ecr get-login-password --region eu-west-1 --profile=$(profile) | docker login --username AWS --password-stdin $(aws_account_id).dkr.ecr.$(region).amazonaws.com
	docker push $(aws_account_id).dkr.ecr.$(region).amazonaws.com/eugene-app:$(app_version)

deploy:
	cat "deployment.yaml.template" | sed "s/{{APP_VERSION}}/$(app_version)/g" | sed "s/{{AWS_ACCOUNT_ID}}/$(aws_account_id)/g" | sed "s/{{REGION}}/$(region)/g" | AWS_PROFILE=$(profile) KUBECONFIG=$(kubeconfig) kubectl apply -f -

test-app:
	(sleep 2 && python -m webbrowser "http://localhost:8088") & \
	AWS_PROFILE=$(profile) KUBECONFIG=$(kubeconfig) kubectl port-forward service/app-service 8088:80

destroy:
	cat "deployment.yaml.template" | sed "s/{{APP_VERSION}}/$(app_version)/g" | sed "s/{{AWS_ACCOUNT_ID}}/$(aws_account_id)/g" | sed "s/{{REGION}}/$(region)/g" | AWS_PROFILE=$(profile) KUBECONFIG=$(kubeconfig) kubectl delete -f - && echo "success!" || echo "failure!"
	cd aws && terraform destroy -auto-approve && rm -f $(kubeconfig) && cd ..
	echo "0.0.0" > ./version
