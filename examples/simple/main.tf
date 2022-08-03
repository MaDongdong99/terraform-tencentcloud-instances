
module "instances" {
  source = "../.."
  instances = [
    {
      instance_name = "cvm-test-1"
      hostname = "test-1"
      vpc_id = "vpc-oql42gb9"
      subnet_id = "subnet-a5mmb49u"
      instance_type = "S6.MEDIUM2"
      os_name = "CentOS 7.9"
      key_id = "skey-mv18fja7"
      security_groups = ["sg-42y1hyfa"]
    },


  ]
}