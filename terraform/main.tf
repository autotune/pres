# Configure AWS provider

provider "aws" {
   region = "ap-southeast-1"
}

provider "aws" {
   alias = "ap-southeast-1"
   region = "ap-southeast-1"
}

provider "aws" {
   alias = "ap-southeast-2"
   region = "ap-southeast-2"
}
