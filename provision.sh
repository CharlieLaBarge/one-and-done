#!/bin/bash

set -e
set -x


echo "provisioning!"

sudo apt-get update -y
sudo apt-get install -y python-pip python-dev nginx

sudo pip install virtualenv

mkdir /home/vagrant/myproject
cd /home/vagrant/myproject

virtualenv myprojectenv

source myprojectenv/bin/activate

pip install gunicorn flask

cp /vagrant/hello.py /home/vagrant/myproject/myproject.py
cp /vagrant/wsgi.py /home/vagrant/myproject/wsgi.py

deactivate

sudo cp /vagrant/myproject.service /etc/systemd/system/
sudo systemctl start myproject
sudo systemctl enable myproject

sudo cp /vagrant/myproject /etc/nginx/sites-available/myproject
sudo rm -rf /etc/nginx/sites-enabled/default

sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
sudo systemctl restart nginx

sudo ufw allow 'Nginx Full'

# TODO your code here

echo "provisioning complete!"
