variable "instances" {
  type = list(object({
    instance_name = string
    private_ip = optional(string)
    hostname = optional(string)
    instance_charge_type = optional(string)
    instance_charge_type_prepaid_period = optional(number)
    instance_charge_type_prepaid_renew_flag = optional(string)
    vpc_id = string
    subnet_id = string
    instance_type = string
    os_name = optional(string)
    image_name = optional(string)
    image_type = optional(list(string))
    image_id = optional(string)
    key_id = string
    system_disk_type = optional(string)
    system_disk_size = optional(number)
    data_disks = optional(list(object({
      # CLOUD_PREMIUM, CLOUD_SSD
      type = string
      # If disk type is CLOUD_SSD, the size range is [100, 16000], and the others are [10-16000]
      size = number
    })))
    project_id = optional(number)
    allocate_public_ip = optional(bool)
    internet_max_bandwidth_out = optional(number)
    security_groups = list(string)
    enis = optional(list(object({
      # IPv4 address of the ENI
      ip = optional(string)
    })))
    eips = optional(list(object({
      # whether to associate this EIP to ENI. if false the EIP will be associated to the main interface
      # if true an ENI will be created and the ENI will be associated to it
      associate_eni              = optional(bool)
      # if associate_eni is true, this argument assign a private IP to the newly created ENI
      eni_private_ip             = optional(string)
      # charge type: BANDWIDTH_PACKAGE BANDWIDTH_POSTPAID_BY_HOUR TRAFFIC_POSTPAID_BY_HOUR
      internet_charge_type       = optional(string)
      # max bandwidth
      internet_max_bandwidth_out = optional(number)
    })))
    tags = optional(map(string))
  }))
  default = []
}
