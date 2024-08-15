variable "ec2_app" {
  type = map(object({
    ami_id          = string
    instance_choice = string
  }))
}