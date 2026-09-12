variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["192.168.3.0/24", "192.168.4.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "UserDB"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 6
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "allowed_ssh_cidr_blocks" {
  description = "List of CIDR blocks allowed to SSH to bastion host"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "harbor_registry" {
  description = "Harbor registry hostname without protocol (example: harbor.example.com)"
  type        = string
}

variable "harbor_project" {
  description = "Harbor project name"
  type        = string
  default     = "java-login-app"
}

variable "harbor_image" {
  description = "Harbor image/repository name"
  type        = string
  default     = "dptweb"
}

variable "harbor_image_tag" {
  description = "Harbor image tag to deploy"
  type        = string
  default     = "1.0"
}

variable "harbor_username" {
  description = "Harbor username or robot account"
  type        = string
  sensitive   = true
}

variable "harbor_password" {
  description = "Harbor password or robot token"
  type        = string
  sensitive   = true
}

variable "harbor_insecure" {
  description = "Set true if Harbor is HTTP or uses a self-signed certificate"
  type        = bool
  default     = false
} 