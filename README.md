# Terraform_poc

This code will create below resources:

1) S3 bucket with default encryption and blocked public access. (bucket policy which allows Read and Write access via Cloudfront only)
2) Objects/Files will be uploaded to S3( Sample Index.html is set as default file for the domain)
3) Cloudfront distribution with S3 origin
4) Lambda function to invalidate cache (Created lambda function in Python to invalidate cache to be able to get latest object as terraform do not have any function to invalidate cache in cloudfront.)
5) IAM resources required for Lambda execution.

Module have below required parameter values( to be updated in main.tf):

1) bucket_name
2) ACCOUNT_NUMBER (required creating IAM policies and roles for Lambda)

Module has optional parameters( to be updated in main.tf):
1) region - Default set to us-east-1
2) STAGE  - Default set to "dev"
3) DEFAULT_TAGS  - Default set to CreatedBy = "Terraform",    STAGE = "prod",    Project     = "POC"
4) object_dir - This is the directory path to upload the static website files to S3 and Default set to "module/files_to_upload/"


Please run below commands and going in the code folder.

terraform init
terraform plan  -- To check what resources will be created
terraform apply --auto-approve  (This will create the objects and give cloudfront domain name as output)

Update existing index.html file and run "terraform apply --auto-approve" again , 
This will update the file index.html in S3 and trigger a lambda which will invalidate cache for cloudfront distribution.


terraform destroy --auto-approve  
(Run this command to delete all the resources created from this terraform code, 
If destroy fails Please run the same command again as terraform creates/destroys objects in parallel and there might be some conflicts while destroying the resources)
