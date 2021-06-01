variable "bucket_name" {
  type    = string
  description = "Name of S3 bucket"
  default = "cloudfronttotests3website"
}

variable "DEFAULT_TAGS" { 
	type = map(any)
	default = {
    CreatedBy = "Terraform"
    STAGE = "prod"
    Project     = "POC"
   }
 }

variable "STAGE" {
  type    = string
  default = "dev"
  description = "Name of env"
}

variable "region" {
  type    = string
  description = "Name of env"
  default = "us-east-1"
}

variable "object_dir" {
  type    = string
  description = "Directory of index.html and other objects"
  default = "module/files_to_upload/"
}

variable "ACCOUNT_NUMBER" {
  type    = string
  description = "Account no"
  }

variable "s3_origin" {
  type    = string
  description = "S3 origin id"
  default = "myS3Origin"
}


variable "role_name" {
  type    = string
  description = "Iam role name"
  default = "iam_for_lambda"
}

variable "lambda_basic_policy_name" {
  type    = string
  description = "Policy name for lambda"
  default = "lambda_basic_policy"
}
