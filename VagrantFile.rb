# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  
  # Box Settings
  config.vm.box      = 'ubuntu/zesty64' # 17.04
  config.vm.hostname = 'dev-box'
  config.vm.post_up_message  = 'Engines on maximum power!'
  
  # Shell script to install developer enviroment
  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true
  
  # Set Ruby on Rails
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.synced_folder "src/", "/rails"
  config.vm.provision :shell, path: 'rails.sh', keep_color: true
  
  # Set Elastic Search Stack
  config.vm.provision :shell, path: 'elk.sh', keep_color: true

  # Set Angular cli
  config.vm.network "private_network", ip: "192.168.100.100"
  config.vm.network "forwarded_port", guest: 4200, host: 4200
  config.vm.network "forwarded_port", guest: 49152, host: 49152
  config.vm.synced_folder "src/", "/ng2"

  # Settings for provider
  config.vm.provider 'virtualbox' do |v|
    vb.gui = false
    v.memory = 2048
    v.cpus = 2
  end
end