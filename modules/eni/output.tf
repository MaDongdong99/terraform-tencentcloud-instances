output "id" {
  value = tencentcloud_eni.this.id
}
output "private_ip" {
  value = tencentcloud_eni.this.ipv4_info[0].ip
}