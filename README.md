# Windows packer example (with ansible)
Example for creating a new windows AMI. Largerly based on this [example](https://learn.hashicorp.com/tutorials/packer/getting-started-build-image) by hashi corp.

# Dependencies

1. The following is already installed:
    - Packer version 1.6.6
    - Ansible
2. Your AWS credentials are configured with correct permissions for EC2 

# Creating a new server

Run build command:

`packer build windows-server.pkr.hcl`

This does the following:

1. Find and lanuches a windows AMI
2. Bootstrap EC2 with user-data. Our user-data is bootstrap_win.ps1.
3. Run our Ansible playbook the newly created EC2  