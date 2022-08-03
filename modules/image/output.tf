
output "id" {
  value = data.tencentcloud_images.this.images[0].image_id
}

output "image" {
  value = data.tencentcloud_images.this.images[0]
}

output "debug" {
  value = local.os_name
}

output "debug_var" {
  value = var.image_id
}

output "images" {
  value = data.tencentcloud_images.this.images
}