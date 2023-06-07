MK_GIT_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
MK_NAMESPACE = $(shell echo ${MK_GIT_BRANCH} | sed -e 's/\(.*\)/\L\1/')

infraInit:
	cd infra/K8S && terraform init -backend-config="address=${TF_VAR_backend_address}"; cd ../../
.PHONY: infraInit

infraPlan:
	cd infra/K8S && terraform plan -var name_space=${MK_NAMESPACE}; cd ../../
.PHONY: infraPlan

infraDeploy:
	cd infra/K8S && terraform apply --auto-approve -var name_space=${MK_NAMESPACE}; cd ../../
.PHONY: infraDeploy

serviceInit:
	cd K8S-Services && terraform init --reconfigure -backend-config="endpoint=${TF_VAR_backend_endpoint}"
	cd K8S-Services && terraform workspace select ${MK_NAMESPACE}
.PHONY: serviceInit

servicePlan:
	cd K8S-Services && terraform plan -var name_space=${MK_NAMESPACE}
.PHONY: servicePlan

serviceDeploy:
	cd K8S-Services && terraform apply --auto-approve -var name_space=${MK_NAMESPACE}
.PHONY: serviceDeploy

serviceDestroy:
	cd K8S-Services && terraform destroy --auto-approve -var name_space=${MK_NAMESPACE}
.PHONY: serviceDestroy
