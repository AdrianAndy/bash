#!/bin/bash -ex
uatbas=uat-bas
prodbas=prod-bas
uat01=8.8.8.9
uat02=8.8.8.10
prod01=9.9.9.10
prod02=9.9.9.11
user=$(whoami)


cat << EOF


 ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄               ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄          ▄▄▄▄         ▄▄▄▄▄▄▄▄▄
▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌             ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌       ▄█░░░░▌       ▐░░░░░░░░░▌
▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌             ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀       ▐░░▌▐░░▌      ▐░█░█▀▀▀▀▀█░▌
▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌             ▐░▌          ▐░▌       ▐░▌     ▐░▌            ▀▀ ▐░░▌      ▐░▌▐░▌    ▐░▌
▐░▌          ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄▄▄▄▄▄▄▄ ▐░▌          ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌               ▐░░▌      ▐░▌ ▐░▌   ▐░▌
▐░▌          ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌          ▐░░░░░░░░░░░▌     ▐░▌               ▐░░▌      ▐░▌  ▐░▌  ▐░▌
▐░▌          ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀  ▀▀▀▀█░█▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ ▐░▌          ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌               ▐░░▌      ▐░▌   ▐░▌ ▐░▌
▐░▌          ▐░▌       ▐░▌▐░▌               ▐░▌                  ▐░▌          ▐░▌       ▐░▌     ▐░▌               ▐░░▌      ▐░▌    ▐░▌▐░▌
▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░▌               ▐░▌                  ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌     ▐░▌           ▄▄▄▄█░░█▄▄▄  ▄▐░█▄▄▄▄▄█░█░▌
▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌               ▐░▌                  ▐░░░░░░░░░░░▌▐░▌       ▐░▌     ▐░▌          ▐░░░░░░░░░░░▌▐░▌▐░░░░░░░░░▌
 ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀                 ▀                    ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀       ▀            ▀▀▀▀▀▀▀▀▀▀▀  ▀  ▀▀▀▀▀▀▀▀▀



                  *     ,MMM8&&&.            *
                       MMMM88&&&&&    .
                      MMMM88&&&&&&&
          *           MMM88&&&&&&&&
                      MMM88&&&&&&&&
                      'MMM88&&&&&&'
                        'MMM8&&&'      *
              |\___/|
              )     (             .              '
             =\     /=
               )===(       *
              /     \
              |     |
             /       \
             \       /
      _/\_/\_/\__  _/_/\_/\_/\_/\_/\_/\_/\_/\_/\_
      |  |  |  |( (  |  |  |  |  |  |  |  |  |  |
      |  |  |  | ) ) |  |  |  |  |  |  |  |  |  |
      |  |  |  |(_(  |  |  |  |  |  |  |  |  |  |
      |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
      |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
-------------------------------------------------------------------
Welcome to Copy-Cat 1.0
EOF

#Where are you patching to? UAT or Prod bastion?
read -p "Where would you like to copy to? (P)rod or (U)AT bastion?" answer
    case $answer in
      [Pp]* ) selection=$prodbas;;
      [Uu]* ) selection=$uatbas;;
    esac
printf "You have selected $selection."

#select files to be copied
while true; do
  read -p "Do you have any files to copy to the bastion? (Y)es, (N)o, (Q)uit." answer
    case $answer in
      [Nn]* ) printf 'Moving on, then...';
      break;;
      [Qq]* ) printf 'Get the hell outta here!'; exit
      break;;
      [Yy]* ) echo 'Please enter the file name. Leave blank once complete to go to the next step.';
        while read -r file;
          do [[ $file ]] || break;
            echo "Copying file to bastion...";
              scp $file $user@$selection:~/
            break;
          done
    esac
  done

#SSH to selected bastion
echo "Connecting to $selection..."
ssh $user@$selection /bin/bash << EOF

#Create folders
function create() {
  while true; do
    read -p "Would you like to create the directories so you can tar the files? (Y)es, (N)o, (Quit)." answer
    case $answer in
      [Nn]* ) printf 'Moving on, then...'
      break;;
      [Qq]* ) printf 'Get the hell outta here!'; exit
      break;;
      [Yy]* ) echo "Please enter the full path of where you'd like the files to be extracted to";
        while read -r path;
          do [[ $path ]] || break;
            echo "Creating tree $path"
            mkdir -p $path break;
          done
      esac
    done }
create
EOF


#place files in directory...really not sure on how this should work...

#tar directory
#clean up
#scp to nodes - 1) node 1, 2) node 2, 3) both


#exit:
