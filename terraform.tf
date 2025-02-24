terraform {
  backend "s3" {
    bucket         = "demo-terraform-sm1"  
    key            = "terraform/state.tfstate" 
    region         = "us-east-1"               
    encrypt        = true                      
  }
}
