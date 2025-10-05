locals {
  hub = "jc-hub"
  spoke1 = "jc-dev"
}

variable "vpc-config-map" {
    default = {
        hub-vpc = {
            vpc-cidr = "10.0.0.0/16"
            enable_dns_hostnames = true
            enable_dns_support   = true
            subnets = {
                public-subnet-1 = {
                    cidr-block = "10.0.16.0/20"
                    availability_zone = "ap-south-1a"
                    is_public         = true
                    map_public_ip     = true
                    create_security_group = true
                    security_group_rules  = []
                    tags = {
                        Type = "Public"
                        Tier = "Web"
                    }

                }

                public-subnet-2 = {
                    cidr-block = "10.0.32.0/20"
                    availability_zone = "ap-south-1a"
                    is_public         = true
                    map_public_ip     = true
                    create_security_group = true
                    security_group_rules  = []
                    tags = {
                        Type = "Public"
                        Tier = "Web"
                    }

                }

                private-subnet-1 = {
                    cidr-block = "10.0.48.0/20"
                    availability_zone = "ap-south-1a"
                    is_public         = false
                    map_public_ip     = false
                    create_security_group = true
                    security_group_rules  = []
                    tags = {
                        Type = "Private"
                        Tier = "Web"
                    }
                }
            }
        }
    }
}
