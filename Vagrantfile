# -*- mode: ruby -*-
# vi: set ft=ruby :

vagrant_dir = File.expand_path(File.dirname(__FILE__))

Vagrant.configure(2) do |config|
  vagrant_version = Vagrant::VERSION.sub(/^v/, '')
  config.env.enable
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.binary = true
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Disable default synced folder
  config.vm.synced_folder ".", "/vagrant", disabled: true

  if vagrant_version >= "1.3.0"
    config.vm.synced_folder "./", "/vagrant", create: true, :owner => "vagrant", :mount_options => [ "dmode=775", "fmode=774" ]
  else
    config.vm.synced_folder "./", "/vagrant", create: true, :owner => "vagrant", :extra => 'dmode=775,fmode=774'
  end

  config.ssh.forward_agent = true

  # Customfile - POSSIBLY UNSTABLE
  #
  # Use this to insert your own (and possibly rewrite) Vagrant config lines. Helpful
  # for mapping additional drives. If a file 'Customfile' exists in the same directory
  # as this Vagrantfile, it will be evaluated as ruby inline as it loads.
  #
  # Note that if you find yourself using a Customfile for anything crazy or specifying
  # different provisioning, then you may want to consider a new Vagrantfile entirely.
  if File.exists?(File.join(vagrant_dir,'Customfile')) then
    eval(IO.read(File.join(vagrant_dir,'Customfile')), binding)
  end


  config.vm.provision :shell, path: ".provision/provision.sh", privileged: false, binary: true
  config.vm.provision :shell, path: ".provision/install-rvm.sh", args: "stable", privileged: false
  config.vm.provision :shell, path: ".provision/install-ruby.sh", args: "2.2.2 rails bundler", privileged: false
  config.vm.provision :shell, path: ".provision/install-jekyll.sh", privileged: false
  config.vm.provision :shell, path: ".provision/install-tools.sh", privileged: false
  config.vm.provision :shell, path: ".provision/project.sh", privileged: false, binary: true



end
