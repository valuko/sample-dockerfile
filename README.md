# README #

DigitalOcean apps project customized to use PHP docker image which would allow changing the PHP version for the DigitalOcean app_platform. The default PHP version for DigitalOcean app platform is 7.4 which is not suitable for some clients

## Usage

* Fork this repo into your open Github account.
* Register DigitalOcean app platform. See https://github.com/digitalocean/sample-dockerfile for detailed guide on doing that
* Change the PHP verison docker image inside the Dockerfile. Current version is `php:7.1.20-apache`. Refer to https://hub.docker.com/_/php?tab=tags for more available PHP images
* Change the ioncube version in the Dockerfile to match the PHP image version. See line 31 of the Dockerfile
* Deploy to DigitalOcean using the button below:

 [![Deploy to DO](https://mp-assets1.sfo2.digitaloceanspaces.com/deploy-to-do/do-btn-blue.svg)](https://cloud.digitalocean.com/apps/new?repo=https://github.com/valuko/sample-dockerfile/tree/main)

## Customization

You can app custom PHP extensions by adding them in the Dockerfile build steps. Add a new extension by adding the following line: `RUN docker-php-ext-install <extension-name>`

You can also customize the php.ini by editing the php.ini file in config/php. This custom php.ini will be loaded when the project is deployed

### Enabling SSL

You can enable SSL by adding the SSL vhost configuration in the file `config/php/vhosts/default.conf`. You will need to configure a vhost to listen on port 443 and configure the SSL certificates.

I advise that you consider using Cloudflare instead for SSL proxying to your project

## Extra notes

When deploying your project to DigitalOcean, select `main` as the branch instead of `master`. `master` branches are being replaced by `main` going forward
