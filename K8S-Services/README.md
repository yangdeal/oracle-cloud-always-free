# oracle-cloud-always-free

# before start
Need have below env setup in .zshrc or .bashrc:
```bash
export TF_VAR_tenancy_ocid="SOMETHING"
export TF_VAR_user_ocid="SOMETHING"
export TF_VAR_fingerprint="SOMETHING"
export TF_VAR_private_key_path="SOMETHING"
export TF_VAR_backend_address="SOMETHING"
export TF_VAR_backend_endpoint="SOMETHING"
```

# terraform init
```bash
terraform init -backend-config="endpoint=${TF_VAR_backend_endpoint}"
```

# Reference
- [Oracle terraform guide](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformgettingstarted.htm)

