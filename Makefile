all: format init validate lint secure documentation

AWS_DEFAULT_REGION ?= us-east-1

validate:
	@export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION}"; \
	terraform validate -no-color

format:
	@terraform fmt -no-color

documentation:
	@terraform-docs markdown . > README.md

init:
	@terraform init -no-color

lint:
	@tflint -c .tflint.hcl

secure:
	@tfsec
