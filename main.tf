locals {

  instances = flatten([
    for instance in var.instances: {
      instance_name = instance.instance_name
      private_ip = null
      hostname = instance.hostname == null || instance.hostname == "" ? null : instance.hostname
      instance_charge_type = instance.instance_charge_type == null || instance.instance_charge_type == "" ? "POSTPAID_BY_HOUR" : instance.instance_charge_type
      instance_charge_type_prepaid_period = instance.instance_charge_type_prepaid_period == null || instance.instance_charge_type_prepaid_period == 0 ? 1 : instance.instance_charge_type_prepaid_period
      instance_charge_type_prepaid_renew_flag = instance.instance_charge_type_prepaid_renew_flag == null || instance.instance_charge_type_prepaid_renew_flag == "" ? "NOTIFY_AND_AUTO_RENEW" : instance.instance_charge_type_prepaid_renew_flag
      vpc_id = instance.vpc_id
      subnet_id = instance.subnet_id
      instance_type = instance.instance_type
      os_name = instance.os_name
      image_id = instance.image_id
      key_id = instance.key_id
      system_disk_type = instance.system_disk_type == null || instance.system_disk_type == "" ? "CLOUD_PREMIUM" : instance.system_disk_type
      system_disk_size = instance.system_disk_size == null || instance.system_disk_size == 0 ? 50 : instance.system_disk_size
      data_disks = instance.data_disks == null ? [] : instance.data_disks
      project_id = instance.project_id == null ? 0 : instance.project_id
      allocate_public_ip = instance.allocate_public_ip == null ? false : instance.allocate_public_ip
      internet_max_bandwidth_out = instance.internet_max_bandwidth_out == null || instance.internet_max_bandwidth_out == 0 ? 1 : instance.internet_max_bandwidth_out
      security_groups = instance.security_groups
      enis = instance.enis == null ? [] : instance.enis
      eips = instance.eips == null ? [] : instance.eips
      tags = instance.tags == null ? {} : instance.tags

    }
  ])

  instance_map = { for instance in local.instances: format("%s.%s", instance.vpc_id, instance.instance_name) => instance }
  instance_id_map = { for key, instance in module.instances: key => instance.id}

}

module instances {
  for_each = local.instance_map
  source = "./modules/instance"

  instance_name = each.value.instance_name
  hostname = each.value.hostname
  instance_charge_type = each.value.instance_charge_type
  instance_charge_type_prepaid_period = each.value.instance_charge_type_prepaid_period
  instance_charge_type_prepaid_renew_flag = each.value.instance_charge_type_prepaid_renew_flag
  project_id = each.value.project_id
  instance_type = each.value.instance_type
  os_name = each.value.os_name
  image_id = each.value.image_id
  system_disk_type = each.value.system_disk_type
  system_disk_size = each.value.system_disk_size
  vpc_id = each.value.vpc_id
  subnet_id = each.value.subnet_id
  private_ip = each.value.private_ip
  allocate_public_ip = each.value.allocate_public_ip
  internet_max_bandwidth_out = each.value.internet_max_bandwidth_out
  security_groups = each.value.security_groups
  key_id = each.value.key_id
  data_disks = each.value.data_disks

  eips = each.value.eips
  enis = each.value.enis
  tags = each.value.tags
}