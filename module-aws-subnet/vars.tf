variable "vpc-id" {
  type = string
}

variable "subnet-map" {
  default = {}
}

variable "public-route-id" {
  type = string
}

variable "private-route-id" {
  type = string
}

variable "tag" {
  type = string
}
