variable "micro" {
  description = "instance type"
  type        = string
  default     = "t2.small"
}

variable "ami" {
  description = "ami"
  type        = string
  default     = "ami-01816d07b1128cd2d" // "ami-0fd05997b4dff7aac"
}