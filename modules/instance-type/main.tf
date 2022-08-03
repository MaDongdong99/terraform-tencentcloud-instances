locals {
  is_instance_type_set = var.instance_type == null ||  var.instance_type == "" ? false : true
  instance_type = local.is_instance_type_set ? var.instance_type : data.tencentcloud_instance_types.these[0].instance_types[0].instance_type
}

locals {
  filters = {
    zone            = var.availability_zone
    instance-family = var.instance_family == null ? "" : var.instance_family
  }

}

data "tencentcloud_instance_types" "these" {
  count  = local.is_instance_type_set ? 0 : 1
  dynamic "filter" {
    for_each = {for k, v in local.filters : k => v if v != ""}
    content {
      name   = filter.key
      values = [filter.value]
    }
  }
  cpu_core_count   = var.cpu_core_count
  memory_size      = var.memory_size
  gpu_core_count   = var.gpu_core_count
  exclude_sold_out = true
}