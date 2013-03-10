# Some neat package 
%w{ debconf git-core htop screen curl }.each do |a_package|
  package a_package
end

# Create Grouptopics Database
execute "clone-groutopics" do
    command "git clone git://github.com/sdphp/grouptopics.org.git /vagrant/site/grouptopics/"
    action :run
    ignore_failure true
end

include_recipe "apt"
include_recipe "apache2"
include_recipe "mysql::server"
include_recipe "php::php5"
include_recipe "composer"

# get phpmyadmin conf
cookbook_file "/tmp/phpmyadmin.deb.conf" do
  source "phpmyadmin.deb.conf"
end
bash "debconf_for_phpmyadmin" do
  code "debconf-set-selections /tmp/phpmyadmin.deb.conf"
end
package "phpmyadmin"

s = "sdphp-grouptopics"
site = {
  :name => s,
  :host => "www.#{s}.com", 
  :aliases => ["#{s}.com", "dev.#{s}-static.com"]
}

# Configure the development site
web_app site[:name] do
  template "sites.conf.erb"
  server_name site[:host]
  server_aliases site[:aliases]
  docroot "/vagrant/site/grouptopics/public/"
end  

# Add site info in /etc/hosts
bash "info_in_etc_hosts" do
  code "echo 127.0.0.1 #{site[:host]} #{site[:aliases]} >> /etc/hosts"
end

# Add an admin user to mysql
execute "add-admin-user" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
      "CREATE USER 'sdphp'@'localhost' IDENTIFIED BY 'sdphp';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'sdphp'@'localhost' WITH GRANT OPTION;" +
      "CREATE USER 'sdphp'@'%' IDENTIFIED BY 'sdphp';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'sdphp'@'%' WITH GRANT OPTION;\" " +
      "mysql"
  action :run
  only_if { `/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -D mysql -r -N -e \"SELECT COUNT(*) FROM user where user='sdphp' and host='localhost'"`.to_i == 0 }
  ignore_failure true
end

# Create Grouptopics Database
execute "add-groutopics-db" do
    command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
        "CREATE DATABASE grouptopics ;\""
    action :run
    ignore_failure true
end

execute "apache-cleanup" do
    command "a2dissite default && /etc/init.d/apache2 reload"
    action :run
    ignore_failure true
end
