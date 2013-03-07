# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :grouptopics do |gt_config|
      gt_config.vm.box = "precise32"
      gt_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
      gt_config.vm.customize ["modifyvm", :id, "--rtcuseutc", "on"]
      gt_config.ssh.max_tries = 10
      gt_config.vm.forward_port 80, 8888
      gt_config.vm.forward_port 81, 8887
      gt_config.vm.forward_port 3306, 8889
      gt_config.vm.host_name = "sdphp"
      gt_config.vm.provision :shell, :inline => "mkdir -p /srv/grouptopics/sdphp-repo/config /srv/grouptopics/sdphp-repo/log /srv/grouptopics/sdphp-repo/web"
      gt_config.vm.share_folder("servers", "/srv/grouptopics", "./servers", :extra => 'dmode=777,fmode=777')

      gt_config.vm.provision :chef_solo do |chef|
          chef.cookbooks_path = "my-recipes/cookbooks"
          #chef.roles_path = "my-recipes/roles"
          #chef.data_bags_path = "my-recipes/data_bags"
          chef.add_recipe "apache2"
          chef.add_recipe "mysql"
          #chef.add_role "web"

          # You may also specify custom JSON attributes:
          chef.json = { :mysql_password => "foo" }
      end
  end
end
