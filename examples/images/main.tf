
data "tencentcloud_images" "this" {
  image_type = ["PUBLIC_IMAGE", "PRIVATE_IMAGE", "SHARED_IMAGE", "MARKET_IMAGE"]
}

output "images" {
  value = data.tencentcloud_images.this
}