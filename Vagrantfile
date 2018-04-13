Vagrant.configure("2") do |config|
  config.vm.box = 'ubuntu/xenial64'
  config.vm.hostname = 'devbox'
  ENV['LC_ALL']="en_US.UTF-8"

  config.vm.network :private_network, ip: '192.168.50.50'
  config.vm.synced_folder '.', '/vagrant', nfs: true

  10.times do |n|
    config.vm.network 'forwarded_port',
                      guest: 3000 + n,
                      host: 4000 + n
  end

  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"

  config.vm.provision :shell,
                      path: 'bootstrap.sh',
                      keep_color: true,
                      privileged: false
end
