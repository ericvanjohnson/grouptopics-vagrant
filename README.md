# SDPHP Grouptopics w/ Vagrant

A basic Ubuntu 10.04 Vagrant setup for [SDPHP Grouptopics](https://github.com/sdphp/grouptopics.org) and PHP 5.4.

## Requirements

* VirtualBox - Free virtualization software [Downloads](https://www.virtualbox.org/wiki/Downloads)
* Vagrant - Tool for working with virtualbox images [Vagrant Home](https://www.vagrantup.com), click on 'download now link'
* Git - Source Control Management [Downloads](http://git-scm.com/downloads)

## Setup

* Clone this repository 
* run `vagrant up` inside the newly created directory
* (the first time you run vagrant it will need to fetch the virtual box image which is ~300mb so depending on your download speed this could take some time)
* Vagrant will then use puppet to provision the base virtual box with our LAMP stack (this could take a few minutes) also note that composer will need to fetch all of the packages defined in the app's composer.json which will add some more time to the first provisioning run
* You can verify that everything was successful by opening http://localhost:8888 in a browser

### Using Vagrant

Vagrant is [very well documented](http://vagrantup.com/v1/docs/index.html) but here are a few common commands:

* `vagrant up` starts the virtual machine and provisions it
* `vagrant suspend` will essentially put the machine to 'sleep' with `vagrant resume` waking it back up
* `vagrant halt` attempts a graceful shutdown of the machine and will need to be brought back with `vagrant up`
* `vagrant ssh` gives you shell access to the virtual machine


##### Virtual Machine Specifications #####

* OS     - Ubuntu 10.04
* Apache - 2.2.22
* PHP    - 5.4.9
* MySQL  - 5.5.28

Phpmyadmin is available [http://localhost:8080/phpmyadmin/](http://localhost:8080/phpmyadmin/). User `sdphp`, Password `sdphp`
