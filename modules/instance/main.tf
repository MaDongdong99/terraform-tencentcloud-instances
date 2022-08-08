locals {
  instance_type = module.instance_type.instance_type
  zone = data.tencentcloud_vpc_subnets.subnets.instance_list[0].availability_zone
  image_id = module.image.id
}


data "tencentcloud_vpc_subnets" "subnets" {
  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id
}

module "instance_type" {
  source            = "../instance-type"
  availability_zone = local.zone
  cpu_core_count    = var.cpu_core_count
  memory_size       = var.memory_size
  gpu_core_count    = var.gpu_core_count
  instance_family   = var.instance_family
  instance_type  =  var.instance_type
}

module "image" {
  source  = "../image"
  os_name = var.os_name == null ? "centos" : var.os_name
  image_type = var.image_type
  image_name = var.image_name
  image_id = var.image_id
}

resource "tencentcloud_instance" "this" {
  instance_name                           = var.instance_name
  hostname                                = var.hostname == "" ? var.instance_name : var.hostname
  instance_charge_type                    = var.instance_charge_type
  instance_charge_type_prepaid_period     = var.instance_charge_type == "PREPAID" ? var.instance_charge_type_prepaid_period : null
  instance_charge_type_prepaid_renew_flag = var.instance_charge_type == "PREPAID" ? var.instance_charge_type_prepaid_renew_flag : null
  project_id                              = var.project_id
  availability_zone                       = local.zone
  instance_type                           = local.instance_type
  image_id                                = local.image_id
  system_disk_type                        = var.system_disk_type
  system_disk_size                        = var.system_disk_size
  vpc_id                                  = var.vpc_id
  subnet_id                               = var.subnet_id
  private_ip                              = var.private_ip == null ? null : var.private_ip
  allocate_public_ip                      = var.allocate_public_ip
  internet_max_bandwidth_out              = var.allocate_public_ip ? var.internet_max_bandwidth_out : null
  security_groups                         = var.security_groups
  key_name = var.key_id == "" ? null : var.key_id

  tags = var.tags

  dynamic "data_disks" {
    for_each = toset(var.data_disks)
    content {
      data_disk_type = data_disks.value.type
      data_disk_size = data_disks.value.size
    }
  }
}

module "eip" {
  count                      = length(var.eips)
  source                     = "../eip"
  associate_to               = var.eips[count.index].associate_eni ? "ENI" : "INSTANCE"
  eni_private_ip             = var.eips[count.index].eni_private_ip
  internet_charge_type       = var.eips[count.index].internet_charge_type
  internet_max_bandwidth_out = var.eips[count.index].internet_max_bandwidth_out
  instance_id                = tencentcloud_instance.this.id
  vpc_id                     = var.vpc_id
  subnet_id                  = var.subnet_id
  internet_service_provider  = var.eips[count.index].internet_service_provider == null ? "BGP": var.eips[count.index].internet_service_provider
}

module "eni" {
  count       = length(var.enis)
  source      = "../eni"
  vpc_id      = var.vpc_id
  subnet_id   = var.subnet_id
  instance_id = tencentcloud_instance.this.id
  attach      = true
  ipv4s       = [
    {
      ip      = var.enis[count.index].ip
      primary = true
    }
  ]
}