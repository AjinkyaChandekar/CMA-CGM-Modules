module "ec2" {
  source = "./Modules/EC2/"

  for_each = var.ec2_app

  ami_id = each.value["ami_id"]
  i_type = each.value["instance_choice"]

}