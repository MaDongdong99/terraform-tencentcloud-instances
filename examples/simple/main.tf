
module "instances" {
  source = "../.."
  instances = [
    {
      instance_name = "cvm-test-1"
      hostname = "test-1"
      vpc_id = "vpc-oql42gb9"
      subnet_id = "subnet-a5mmb49u"
      instance_type = "S6.MEDIUM2"
//      image_id = "img-06pt2w24"
      image_type = ["PUBLIC_IMAGE"]
      image_name="zmx-test",
//      os_name = "",
      key_id="skey-mv18fja7",security_groups=["sg-42y1hyfa"]
      allocate_public_ip = true
      internet_max_bandwidth_out = 50
      system_disk_size = 60
      data_disks = [
//        {type="CLOUD_SSD", size=70}
      ]
//      eips = [{
//        associate_eni = false, internet_max_bandwidth_out = 50,
//      }]
    },
  ]
}