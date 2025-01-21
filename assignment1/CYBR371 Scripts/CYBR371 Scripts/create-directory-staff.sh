#!/bin/bash

sudo groupadd doctors
sudo groupadd nurses
sudo groupadd admins

cd / 
cd opt
mkdir -p WellingtonClinic
cd WellingtonClinic
mkdir -p patients

sudo useradd -m -d /home/BenM/ -g admins -p admin123 BenM
sudo useradd -m -d /home/DrMaryT/ -g doctors -p asdf123 DrMaryT
sudo useradd -m -d /home/DrMandyS/ -g doctors -p asdf123 DrMandyS
sudo useradd -m -d /home/DrEliM/ -g doctors -p asdf123 DrEliM
sudo useradd -m -d /home/LuciaB/ -g nurses -p asdf123 LuciaB
sudo useradd -m -d /home/PhilM -g nurses -p asdf123 PhilM

