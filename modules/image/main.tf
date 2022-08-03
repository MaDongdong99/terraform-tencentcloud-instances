locals {
  os_name = var.image_id == null || var.image_id == "" ? var.os_name : null
}
data "tencentcloud_images" "this" {
  os_name = local.os_name
  image_type = var.image_id == null || var.image_id == "" ? var.image_type : []
  image_id = var.image_id
}



