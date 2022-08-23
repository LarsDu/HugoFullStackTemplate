# Extract key file from terraform.tfvars
GCP_KEY_FILENAME := $(shell sed -n 's/^ *gcp_key_file.*=.*"\([^"]*\)".*/\1/p' ../terraform/prod/terraform.tfvars)
DEPLOYMENT_TARGET=deployment_target


# Makes sure vars are read properly from config.toml and ../terraform/prod/terraform.tfvars
echo_vars:
	@ echo "Key file located at "$(GCP_KEY_FILENAME)'

build:
	hugo --gc --minify

local: build
	hugo -D server


# Used by CI/CD
deploy: build
	hugo deploy --target=$(DEPLOYMENT_TARGET)

deploy_from_local: build
	# Note: https://developers.google.com/accounts/docs/application-default-credentials
	GOOGLE_APPLICATION_CREDENTIALS=$(LOCAL_CREDENTIALS) hugo deploy --target=$(DEPLOYMENT_TARGET)
