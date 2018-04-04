# Docker image for Magento 2 with installed Fact Finder module

This repository is based on [docker-magento2 image](https://github.com/alexcheng1982/docker-magento2) repository.

## Requirements
* Docker 17.12.0-ce and newer
* Docker-compose 1.19.0 and newer
* Ensure that Jenkins can run `docker-compose` command has root privileges

## Quick start
Find `/etc/hosts` file and add new host:
~~~
127.0.0.1 local.magento
~~~

For admin username and password, please refer to the file `env`. You can also update the file `env` to update those configurations. Below are the default configurations.

~~~
MYSQL_HOST=db
MYSQL_ROOT_PASSWORD=myrootpassword
MYSQL_USER=magento
MYSQL_PASSWORD=magento
MYSQL_DATABASE=magento

MAGENTO_LANGUAGE=en_GB
MAGENTO_TIMEZONE=Pacific/Auckland
MAGENTO_DEFAULT_CURRENCY=NZD
MAGENTO_URL=http://local.magento

MAGENTO_ADMIN_FIRSTNAME=Admin
MAGENTO_ADMIN_LASTNAME=MyStore
MAGENTO_ADMIN_EMAIL=amdin@example.com
MAGENTO_ADMIN_USERNAME=admin
MAGENTO_ADMIN_PASSWORD=magentorocks1
~~~

For example, if you want to change the default currency, just update the variable `MAGENTO_DEFAULT_CURRENCY`, e.g. `MAGENTO_DEFAULT_CURRENCY=USD`.


Go to the Jenkins server and create a new job. Use this repository url as source code. 

You can now run the job. If it ends with success you can try to open the browser and visit http://local.magento. You should be able to see the main page of Magento 2 shop.
