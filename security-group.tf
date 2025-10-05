# Example 1: Web Server Security Group
module "sg-web" {
  source      = "./module-aws-security-group"
  vpc-id      = module.vpc.vpc-id
  name        = "${local.hub}-web-sg"
  description = "Security group for web servers"

  ingress-rules = [
    {
      description              = "HTTP from internet"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
    },
    {
      description              = "HTTPS from internet"
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
    },
    {
      description              = "SSH from specific IP only"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      #cidr_blocks              = ["203.0.113.0/24"]  # Your office IP
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
    }
  ]

  tags = {
    Environment = "production"
    Tier        = "web"
  }
}

# Example 2: Application Server Security Group
module "sg-app" {
  source      = "./module-aws-security-group"
  vpc-id      = module.vpc.vpc-id
  name        = "${local.hub}-app-sg"
  description = "Security group for application servers"

  ingress-rules = [
    {
      description              = "App port from web tier only"
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
      #source_security_group_id = module.sg-web.sg-id  # Only from web SG
    },
    {
      description              = "SSH from bastion only"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0"]
      #source_security_group_id = module.sg-bastion.sg-id
      source_security_group_id = null
    }
  ]

  tags = {
    Environment = "production"
    Tier        = "application"
  }
}

# Example 3: Database Security Group
module "sg-database" {
  source      = "./module-aws-security-group"
  vpc-id      = module.vpc.vpc-id
  name        = "${local.hub}-db-sg"
  description = "Security group for databases"

  ingress-rules = [
    {
      description              = "MySQL from app tier only"
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
      #source_security_group_id = module.sg-app.sg-id  # Only from app SG
    }
  ]

  egress-rules = [
    {
      description                   = "Allow outbound to app tier only"
      from_port                     = 0
      to_port                       = 65535
      protocol                      = "tcp"
      cidr_blocks                   = ["0.0.0.0/0"]
      source_security_group_id      = null
      #destination_security_group_id = module.sg-app.sg-id
    }
  ]

  tags = {
    Environment = "production"
    Tier        = "database"
  }
}

# Example 4: Bastion Host Security Group
module "sg-bastion" {
  source      = "./module-aws-security-group"
  vpc-id      = module.vpc.vpc-id
  name        = "${local.hub}-bastion-sg"
  description = "Security group for bastion host"

  ingress-rules = [
    {
      description              = "SSH from specific IP range"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0"]  # Your office/VPN IP
      source_security_group_id = null
    }
  ]

  tags = {
    Environment = "production"
    Tier        = "management"
  }
}

# Example 5: Simple setup with VPC CIDR only
module "sg-internal" {
  source      = "./module-aws-security-group"
  vpc-id      = module.vpc.vpc-id
  name        = "${local.hub}-internal-sg"
  description = "Security group for internal resources"

  ingress-rules = [
    {
      description              = "All traffic from VPC"
      from_port                = 0
      to_port                  = 65535
      protocol                 = "-1"
      cidr_blocks              = ["10.0.0.0/16"]  # Your VPC CIDR
      source_security_group_id = null
    }
  ]

  tags = {
    Environment = "production"
  }
}
