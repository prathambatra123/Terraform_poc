module "s3_cf_website" {
  source = "./module/s3_static_website/"
  bucket_name = "mytestbucketformodulespoc"
  STAGE = "prod"
  DEFAULT_TAGS = {
    CreatedBy = "Terraform"
    STAGE = "prod"
    Project = "POC"
   }
  object_dir = "module/files_to_upload/"
  ACCOUNT_NUMBER = "959334371552"
}
