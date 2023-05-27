MK_GIT_BRANCH = $(shell git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
MK_NAMESPACE = $(shell echo ${MK_GIT_BRANCH} | cut -d'_' -f1)

tfInit:
	cd infra/K8S && terraform init -backend-config="address=${TF_VAR_backend_address}"
.PHONY: tfInit

tfPlan:
	cd infra/K8S && terraform plan
.PHONY: tfPlan
