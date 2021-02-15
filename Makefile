profile="eugene.st"
region="eu-west-1"
aws_cred_file="~/.aws/credentials"
AWS_ACCOUNT_ID=$(shell aws sts get-caller-identity  --profile=${profile} |jq -r ".Account")
app_version="1"

all: infra image

infra:
	cd aws && \
	terraform init && \
	terraform apply -var 'aws_cred_profile=${profile}' -var 'aws_cred_file=${aws_cred_file}' -auto-approve && \
	cd ..

image: build push
build:
	docker build -t $(AWS_ACCOUNT_ID).dkr.ecr.${region}.amazonaws.com/eugene-app:${app_version} .

push:
	aws ecr get-login-password --region eu-west-1 --profile=${profile} | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.${region}.amazonaws.com
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.${region}.amazonaws.com/eugene-app:${app_version}

deploy:
	cat "deployment.yaml.template" | sed "s/{{APP_VERSION}}/${app_version}/g" | sed "s/{{AWS_ACCOUNT_ID}}/$(AWS_ACCOUNT_ID)/g" | sed "s/{{REGION}}/${region}/g" | kubectl apply -f -


destroy:
	kubectl delete deployment app-deployment && echo "success!" || echo "failure!"
	cd aws && terraform destroy -auto-approve && cd ..
