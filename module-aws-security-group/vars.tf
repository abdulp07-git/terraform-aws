variable "vpc-id" {
  type        = string
  description = "VPC ID where security group will be created"
}

variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "description" {
  type        = string
  default     = "Managed by Terraform"
  description = "Security group description"
}

variable "ingress-rules" {
  type = list(object({
    description              = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks             = optional(list(string))
    source_security_group_id = optional(string)
  }))
  default     = []
  description = "List of ingress rules"
}

variable "egress-rules" {
  type = list(object({
    description                   = string
    from_port                     = number
    to_port                       = number
    protocol                      = string
    cidr_blocks                  = optional(list(string))
    destination_security_group_id = optional(string)
  }))
  default = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      destination_security_group_id = null
    }
  ]
  description = "List of egress rules"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for the security group"
}
