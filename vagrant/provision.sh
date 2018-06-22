#!/bin/bash
#install wget and unzip
wso2am=/opt/wso2am-2.1.0
wso2ei=/opt/wso2ei-6.1.1
sudo yum -y install wget unzip kernel-devel
#sudo yum -y install unzip
#sudo yum -y install kernel-devel
#sudo yum -y install gcc*
#sudo yum -y install epel-release

#cd /opt
#sudo wget -c http://download.virtualbox.org/virtualbox/5.1.26/VBoxGuestAdditions_5.1.26.iso \
#-O VBoxGuestAdditions_5.1.26.iso
#sudo mount VBoxGuestAdditions_4.2.8.iso -o loop /mnt
#cd /mnt
#sudo sh VBoxLinuxAdditions.run --nox11
#cd /opt

#install java 1.8 and set Java Home

if ! rpm -qa | grep jdk1.8.0_144-1.8.0_144-fcs.x86_64; then
  sudo rpm -Uvh /vagrant/jdk-8u144-linux-x64.rpm
else echo "Java 1.8 is already installed, bud. This isn't your first rodeo..."
fi

#unzip the wso2 installs
if [ ! -d "$wso2ei" ]; then
  echo "Extracting WSO2 Integrator 6.1.1..."
  sudo unzip /vagrant/wso2ei-6.1.1.zip -d /opt
  echo "Extracted WSO2 Integrator. Enjoy."
else echo "You have already extracted WSO2 Integrator. Well done, you."
fi

if [ ! -d "$wso2am" ]; then
  echo "Extracting WSO2 API Manager 2.1.0..."
  sudo unzip /vagrant/wso2am-2.1.0.zip -d /opt
  echo "Extracted WSO2 API Manager 2.1.0. Enjoy."
else echo "You have already extracted WSO2 API Manager. Aren't you special?"
fi

sudo echo -e "############ WELCOME FROM THE VAGRANT VICTORY VIKINGS ############# \n \n Execute the following commands... \n \n sudo su \n sh /opt/wso2am-2.1.0/bin/wso2server.sh --start \n sh /opt/wso2ei-6.1.1/bin/integrator.sh --start \n \n ..to launch the servers when you are ready. The servers will be on 127.0.0.1 9443 by default. Bless bless. \n \n ###################################################################\n" > /etc/motd

#To run the servers at the end of the provisoner...or put this in your vagrantfile, can't say I recommend it, though.
#sh /opt/wso2am-2.1.0/bin/wso2server.sh --start
#sh /opt/wso2ei-6.1.1/bin/integrator.sh --start

cat << "EOF"

                                   ||`-.___
                                   ||    _.>
                                   ||_.-'
               ==========================================
                `.:::::::.       `:::::::.       `:::::::.
                  \:::::::.        :::::::.        :::::::\
                   L:::::::         :::::::         :::::::L
                   J::::::::        ::::::::        :::::::J
                    F:::::::        ::::::::        ::::::::L
                    |:::::::        ::::::::        ::::::::|
                    |:::::::        ::::::::        ::::::::|     .---.
                    |:::::::        ::::::::        ::::::::|    /(@  o`.
                    |:::::::        ::::::::        ::::::::|   |    /^^^
     __             |:::::::        ::::::::        ::::::::|    \ . \vvv
   .'_ \            |:::::::        ::::::::        ::::::::|     \ `--'
   (( ) |           |:::::::        ::::::::        ::::::::|      \ `.
    `/ /            |:::::::        ::::::::        ::::::::|       L  \
    / /             |:::::::        ::::::::        ::::::::|       |   \
   J J              |:::::::        ::::::::        ::::::::|       |    L
   | |              |:::::::        ::::::::        ::::::::|       |    |
   | |              |:::::::        ::::::::        ::::::::|       F    |
   | J\             F:::::::        ::::::::        ::::::::F      /     |
   |  L\           J::::::::       .::::::::       .:::::::J      /      F
   J  J `.     .   F:::::::        ::::::::        ::::::::F    .'      J
    L  \  `.  //  /:::::::'      .::::::::'      .::::::::/   .'        F
    J   `.  `//_..---.   .---.   .---.   .---.   .---.   <---<         J
     L    `-//_=/  _  \=/  _  \=/  _  \=/  _  \=/  _  \=/  _  \       /
     J     /|  |  (_)  |  (_)  |  (_)  |  (_)  |  (_)  |  (_)  |     /
      \   / |   \     //\     //\     //\     //\     //\     /    .'
       \ / /     `---//  `---//  `---//  `---//  `---//  `---'   .'
________/_/_________//______//______//______//______//_________.'_________
##########################################################################
VAGRANT VICTORY VIKINGS:
------------------------
EOF
echo -e "\e[1;31mVagrant, Allfather of VMs, has setup your environment and installed WSO2 API-M and API-EI. Praise be to Vagrant. \n To access this environment, type 'vagrant ssh' and remember that you'll need to be root to boot the servers. \n If you need to move any files over, place them in the Vagrant project folder, and on your local machine type 'vagrant rsync'. \n They'll then be moved to '/vagrant/'. \e[0m"
echo -e "\e[1;34m Execute the following commands... \n sh /opt/wso2am-2.1.0/bin/wso2server.sh --start \n  sh /opt/wso2ei-6.1.1/bin/integrator.sh --start \n ..to launch the servers when you're ready. Bless bless.\e[0m"
