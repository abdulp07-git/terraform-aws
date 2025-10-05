module "vpc" {
  source = "./module-aws-vpc"
  cidr = var.vpc-config-map["hub-vpc"].vpc-cidr
  tag = "${local.hub}-vpc"
}

module "igw" {
  source  = "./module-aws-igw"
  vpc-id  = module.vpc.vpc-id
  tag     = "${local.hub}-igw"
}

module "route-table-public" {
  source = "./module-aws-pubrt"
  igw-id = module.igw.igw-id
  vpc-id = module.vpc.vpc-id
  tag = "${local.hub}-public-rt"
}

module "route-table-private" {
  source = "./module-aws-pvtrt"
  vpc-id = module.vpc.vpc-id
  tag = "${local.hub}-private-rt"
}

module "subnets" {
  source = "./module-aws-subnet"
  vpc-id = module.vpc.vpc-id
  private-route-id  = module.route-table-private.routeid
  public-route-id  = module.route-table-public.routeid
  subnet-map = var.vpc-config-map["hub-vpc"].subnets
  tag = "${local.hub}"
}
