#!/bin/bash

#sudo ufw allow 1966
#sudo ufw status

chmod -R u+rwX SharpishlyApp/src/View/www

ls -l SharpishlyApp/src/View/www

cd SharpishlyApp/build

cmake ..

make

./SharpishlyApp
