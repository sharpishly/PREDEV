#!/bin/bash

sudo ufw allow 1966

sudo ufw status

# Set permissions
sudo chmod -R u+rwX SharpishlyApp/src/View/www

# Stop Nginx
sudo systemctl stop nginx
sudo service nginx stop
# sudo systemctl status nginx
# or
# sudo service nginx status


ls -l SharpishlyApp/src/View/www

cd SharpishlyApp/build

cmake ..

make

./SharpishlyApp
