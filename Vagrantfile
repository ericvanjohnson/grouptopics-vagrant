Vagrant::Config.run do |config|
  config.vm.box = "lucid32"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
  config.vm.host_name = "sdphp"
  #config.vm.share_folder("www", "/var/www", "./www", :extra => 'dmode=777,fmode=777')
  #config.vm.provision :shell, :inline => "mkdir -p /srv/grouptopics/sdphp-repo/config /srv/grouptopics/sdphp-repo/log /srv/grouptopics/sdphp-repo/web"
  #config.vm.provision :shell, :inline => "git clone git://github.com/sdphp/grouptopics.org.git /vagrant/site/grouptopics/"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "my-recipes/cookbooks"
    chef.add_recipe("vagrant_main")
    chef.json.merge!({
    :mysql => {
      :server_root_password => "root"
    }
  })
  end

  config.vm.forward_port(80, 8080)
  config.vm.forward_port(3306, 3306)
end
