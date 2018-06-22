#!/bin/bash
current=$(pwd)
directory=${1%.*}
leftover=$current/$directory
patch=$(echo "$directory" | sed 's/.*\(....\)/\1/')
patchdir=patch$patch
home=/opt/wso2/apimanager/
cat << "EOF"
       _,.
     ,` -.)
    '( _/'-\\-.
   /,|`--._,-^|            ,
   \_| |`-._/||          ,'|
     |  `-, / |         /  /
     |     || |        /  /
      `r-._||/   __   /  /
  __,-<_     )`-/  `./  /
 '  \   `---'   \   /  /
     |           |./  /
     /           //  /
 \_/' \         |/  /
  |    |   _,^-'/  /
  |    , ``  (\/  /_
   \,.->._    \X-=/^
   (  /   `-._//^`
    `Y-.____(__}
     |     {__)
           ()'
PATCHLORD:
EOF


if [[ $# -eq 0 ]] ; then
	echo -e "\e[1;31mYou must select a patch zip to run this script, else terrible, terrible things happen. Try again.\e[0m"
	exit 0
fi

unzip $1
cp -rv $directory/* $home
cd $home
mkdir -v $directory
mv -v ./README.txt ./LICENSE.txt $home$directory
cp -rv $home$patchdir /opt/wso2/apimanager/repository/components/patches/
rm -rfv $patchdir
rm -rfv "$leftover"

echo "----------------------------------------------------------------"
echo -e "\e[1;31mTo keep this directory tidy, make sure you remove the $directory directory when you have finished reading the notes.\e[0m"
echo -e "\e[1;34mPatching complete - please see $home$directory for installation notes!\e[0m"
