# ASG Module

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of target group ARNs"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "min_size" {
  description = "Minimum size of ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum size of ASG"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of ASG"
  type        = number
}

variable "harbor_registry" {
  description = "Harbor registry hostname without protocol (example: harbor.example.com)"
  type        = string
}

variable "harbor_project" {
  description = "Harbor project that stores the application image"
  type        = string
}

variable "harbor_image" {
  description = "Harbor repository / image name"
  type        = string
  default     = "dptweb"
}

variable "harbor_image_tag" {
  description = "Image tag to pull from Harbor"
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
  description = "Allow HTTP / self-signed Harbor registry on EC2 Docker daemon"
  type        = bool
  default     = false
}

variable "db_endpoint" {
  description = "RDS endpoint host:port"
  type        = string
}

variable "db_name" {
  description = "Application database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
