Vagrant.configure("2") do |config|

  config.vm.box = "bento/centos-7.2"
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
   config.vm.provision "shell", path: "provision.sh", privileged: false
end
