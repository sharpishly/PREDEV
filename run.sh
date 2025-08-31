#!/bin/bash

sudo ufw allow 1966
sudo ufw status

cd SharpishlyApp/build

cmake ..

make

./SharpishlyApp
