
init:
	terraform init -backend-config=config.s3.tfbackend
    
plan:
	terraform plan -var-file=sensitive.tfvars

apply:
	terraform apply -var-file="sensitive.tfvars" -auto-approve

destroy:
	terraform destroy -var-file="sensitive.tfvars" -auto-approve
    
