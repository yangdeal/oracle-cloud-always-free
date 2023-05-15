# For
This is to create 2 x e2.1.micro and ALB

# before start
Need have below env setup in .zshrc or .bashrc:
```bash
export TF_VAR_tenancy_ocid="SOMETHING"
export TF_VAR_user_ocid="SOMETHING"
export TF_VAR_fingerprint="SOMETHING"
export TF_VAR_private_key_path="SOMETHING"
export TF_VAR_backend_address="SOMETHING"
```

# terraform init
```bash
terraform init -backend-config="address=${TF_VAR_backend_address}"
```

# Reference
- [Oracle terraform guide](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformgettingstarted.htm)

