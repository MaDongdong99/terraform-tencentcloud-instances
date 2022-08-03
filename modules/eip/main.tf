resource "tencentcloud_eip" "this" {
  internet_charge_type       = var.internet_charge_type
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  type                       = "EIP"
  internet_service_provider = var.internet_service_provider
}

resource "tencentcloud_eip_association" "ins_association" {
  count       = var.associate_to == "INSTANCE" ? 1 : 0
  eip_id      = tencentcloud_eip.this.id
  instance_id = var.instance_id
}

module "eni" {
  count       = var.associate_to == "ENI" ? 1 : 0
  source      = "../eni"
  vpc_id      = var.vpc_id
  subnet_id   = var.subnet_id
  ipv4_count  = var.eni_private_ip == null ? 1 : null
  ipv4s       = var.eni_private_ip == null ? [] : [
    {
      ip      = var.eni_private_ip
      primary = true
    }
  ]
  attach      = true
  instance_id = var.instance_id
}

resource "tencentcloud_eip_association" "eni_association" {
  count                = var.associate_to == "ENI" ? 1 : 0
  eip_id               = tencentcloud_eip.this.id
  network_interface_id = module.eni[0].id
  private_ip           = module.eni[0].private_ip
}
