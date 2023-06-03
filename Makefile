MK_GIT_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
MK_NAMESPACE = $(shell echo ${MK_GIT_BRANCH} | cut -d'_' -f1)

tfInit:
	cd infra/K8S && terraform init -backend-config="address=${TF_VAR_backend_address}"; cd ../../
.PHONY: tfInit

tfPlan:
	cd infra/K8S && terraform plan -var name_space=${MK_GIT_BRANCH}; cd ../../
.PHONY: tfPlan

tfDeploy:
	cd infra/K8S && terraform apply --auto-approve -var name_space=${MK_GIT_BRANCH}; cd ../../
.PHONY: tfDeploy
