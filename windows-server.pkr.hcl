variable "region" {
  type    = string
  default = "us-east-1"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source.
source "amazon-ebs" "windows" {
  ami_name      = "packer-windows-example-${local.timestamp}"
  instance_type = "t3.medium"
  region        = "${var.region}"
  source_ami_filter {
    filters = {
      name                = "Windows_Server-2019-English-Full-Base-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  user_data_file = "./bootstrap_win.txt"
  
  communicator = "winrm"
  winrm_username = "Administrator"
  winrm_insecure = true
  winrm_use_ssl = true
}


# a build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.windows"]

  
  provisioner "ansible" {
    playbook_file = "win-playbook.yaml"
    user = "Administrator"
    use_proxy = false
    extra_arguments = [
      "-e", "ansible_winrm_server_cert_validation=ignore",
      "-vvv"
    ]
  }
}