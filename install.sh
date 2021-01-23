export VER="1.6.6"

wget https://releases.hashicorp.com/packer/${VER}/packer_${VER}_linux_amd64.zip

unzip packer_${VER}_linux_amd64.zip

sudo mv packer /usr/local/bin

rm packer_${VER}_linux_amd64.zip

echo 'Successfully instsalled packer version:'
packer --version