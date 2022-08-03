resource "tencentcloud_eni" "this" {
  name       = var.name
  vpc_id     = var.vpc_id
  subnet_id  = var.subnet_id
  ipv4_count = var.ipv4_count
  dynamic "ipv4s" {
    for_each = toset(var.ipv4s)
    content {
      ip      = ipv4s.value.ip
      primary = ipv4s.value.primary
    }
  }
}

resource "tencentcloud_eni_attachment" "attachment" {
  count       = var.attach ? 1 : 0
  eni_id      = tencentcloud_eni.this.id
  instance_id = var.instance_id
}