require 'yaml'

configs = YAML.load_file("./config.yaml")
domain  = configs['domain']
ip_ptfe = configs['ip_ptfe']
ip_gitlab = configs['ip_gitlab']

Vagrant.configure("2") do |config|

  # PTFE server
  config.vm.define "ptfe", autostart: true do |s|
    s.ssh.insert_key = false
    s.vm.box = "bento/ubuntu-16.04"
    s.vm.box_check_update = false
    s.vm.hostname = "ptfe"
    s.vm.network "private_network", ip: "#{ip_ptfe}"
    s.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 2
      vb.memory = 4096
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    s.vm.provision "shell" do |sh|
       sh.path = "./scripts/install_ptfe.sh"
       sh.args = "#{domain} #{ip_ptfe}"
     end
  end

  # Gitlab Server
  config.vm.define "gitlab", autostart: true do |s|
    s.ssh.insert_key = false
    s.vm.box = "bento/ubuntu-16.04"
    s.vm.box_check_update = false
    s.vm.hostname = "gitlab"
    s.vm.network "private_network", ip: "#{ip_gitlab}"
    s.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 1
      vb.memory = 2048
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
    s.vm.provision "shell" do |sh|
       sh.path = "./scripts/install_gitlab.sh"
       sh.args = "#{domain}"
     end
  end

end
