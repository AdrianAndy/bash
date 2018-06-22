#!/bin/bash -e
home=/opt/wso2/apimanager/
tmp=/opt/wso2/apimanager/tmp/*
releasetar=$1

#argument check
if [ $# -eq 0 ]; then
    echo "No release tar selected. Please select a release tar. Exiting."
    exit 1
fi

cat << "EOF"
             .
           .d$ .
           d$$  :
          .$$$
          :$$$   :
          $$$$   :
          $$$$   :
         .$$$$
         :$$$$    :
         :$$$$    :
         $$$$$    :
         $$$$$    :
         :    $$$$$
         :    $$$$$
         :    $$$$$
        .:    $$$$$.
       / :    $$$$: \
      /  :    $$$$:  \
     '        $$$$`   '
     |    :   $$$$    |
     |   /:   $$$$\   |
     |  /     $$$` \  |
     |_/   :__$$P   \_|
***REST Release Rocket V1***
Commencing launch sequence.
Enjoy your flight.
------------------------
EOF

#check user is running as root
printf "Checking user is root. If you are not root, you will be prompted for your password.\n Failure to authenticate will exit the script.\n"
(( EUID != 0 )) && exec sudo -- "$0" "$@"

#Drop node from LB using iptables
#give skip option
while true; do
    read -p "Release time. Ready to drop this node from the load balancer? (Y/N/S)?" answer
    case $answer in
        [Yy]* ) echo "Running IP tables on ports 8280, 8243 and 9443...";
        /sbin/iptables -A INPUT -p TCP --dport 8280 -j DROP;
        /sbin/iptables -A INPUT -p TCP --dport 8243 -j DROP;
        /sbin/iptables -A INPUT -p TCP --dport 9443 -j DROP;
        break;;
        [Nn]* ) printf 'You are clearly not ready to do this release, then.\n Take a long, hard look at yourself, friend. Exiting. \n';  exit
        break;;
        [Ss]* ) printf 'Skipping... \n'
        break;;
        * ) echo "Please answer (y)es, (n)o, or (s)kip.";;
    esac
  done

#stop WSO2 and clean temp folder
#give skip option
while true; do
  read -p "Kill WSO2 APIM and empty "$home"tmp/? (Y/N/S)?" answer
    case $answer in
      [Yy]* ) sh /etc/init.d/wso2am stop;
      echo "Cleaning "$home"tmp/"
      rm -rfv $tmp
      break;;
      [Ss]* ) printf 'Skipping... \n';
      break;;
      * ) printf "Please answer (y)es, (n)o, or (s)kip, buddy. I'm waiting...";;
    esac
done

#backup process
while true; do
  read -p "Ready to backup "$home"repository/deployment/ (Y/N/S)?" answer
    case $answer in
      [Yy]* ) printf "Backing up to /tmp/backup_$(date +%Y%m%d%H%M).tar.gz \n"
      backuptime=$(date +%Y%m%d%H%M)
      tar -zcvf backup_$backuptime.tar.gz "$home"repository/deployment
      mv -v backup_$backuptime.tar.gz /tmp/
      break;;
      [Ss]* ) printf 'Skipping... \n'
      break;;
      * ) echo "Please answer (y)es, (n)o, or (s)kip, friend. I'm waiting...";;
    esac
done

## delete files section - UNTESTED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
while true; do
  read -p "Do you have any files to delete? (Y/N)" answer
    case $answer in
      [Nn]* ) printf 'Skipping... \n'
      break;;
      [Yy]* ) echo 'Please enter a filename to delete followed by enter, the file will be deleted. Leave blank once complete to go to the next step.';
        while read -r file;
          do [[ $file ]] || break;
            find /opt/wso2/apimanager -name "$file" -type f -delete
            echo "Finding and deleting all instances of $file nested in $home"
          done
    esac
done


## delete files section

#unzip release and fix permissions so files are owned by root and dtuser group can access but not execute
while true; do
  read -p 'Your release tarball should have been created with the new files in their parent folders. Ready to extract? (Y/N/S)' answer
    case $answer in
      [Yy]* ) echo "Extracting release...";
      tar -zxvf $releasetar -C /opt/
      echo "Cleaning up - adjusting permissions back to dtuser group...";
      chown -R aws198-rest-admin:dtuser /opt/*;
      chmod -R g+rx /opt/*;
      break;;
      [Ss]* ) printf 'Skipping... \n'
      break;;
      * ) echo "Please answer (y)es, (n)o, or (s)kip, guy. I'm waiting...";;
    esac
done

#start wso2
while true; do
  read -p "Ready to start WSO2 API Manager? (Y/N/S)" answer
    case $answer in
      [Yy]* ) echo "Starting WSO2....";
      sh /etc/init.d/wso2am start;
      break;;
      [Ss]* ) printf 'Skipping... \n'
      break;;
      * ) echo "Please answer (y)es, (n)o, or (s)kip, gringo. I'm waiting...";;
    esac
done

#display launch log or display success message.
while true; do
  read -p "Would you like to view the launch log? (Y) to view, any other key to skip." answer
    case $answer in
      [Yy]* )
      less +F "$home"repository/logs/wso2carbon.log
      break;;
      * ) echo "Jumping to the next step."; break;;
    esac
done

cat << "EOF"

                                            ,:
                                          ,' |
                                         /   :
                                      --'   /
                                      \/ /:/
                                      / ://_\
                                   __/   /
                                   )'-. /
                                   ./  :\
                                    /.' '
                                  '/'
                                  +
                                 '
                               `.
                           .-"-
                          (    |
                       . .-'  '.
                      ( (.   )8:
                  .'    / (_  )
                   _. :(.   )8P  `
               .  (  `-' (  `.   .
                .  :  (   .a8a)
               /_`( "a `a. )"'
           (  (/  .  ' )=='
          (   (    )  .8"   +
            (`'8a.( _(   (
         ..-. `8P    ) `  )  +
       -'   (      -ab:  )
     '    _  `    (8P"Ya
   _(    (    )b  -`.  ) +
  ( 8)  ( _.aP" _a   \( \   *
+  )/    (8P   (88    )  )
   (a:f   "     `"`'

GROUND CONTROL: We have liftoff!
---------------------------------
EOF


#echo "Ready to flush IP tables and put this node back into the LB?"
while true; do
  read -p "Launch complete. Ready to flush iptables and put this node back into the LB? (Y/N)" answer
    case $answer in
      [Yy]* ) echo "Flushing iptables...";
      iptables -F;
      break;;
      [Ss]* ) printf 'Skipping... \n'
      break;;
      * ) echo "Please answer (y)es, (n)o, or (s)kip, cumpari. I'm waiting...";;
    esac
done

cat << "EOF"

                           *     .--.
                                / /  `
               +               | |
                      '         \ \__,
                  *          +   '--'  *
                      +   /\
         +              .'  '.   *
                *      /======\      +
                      ;:.  _   ;
                      |:. (_)  |
                      |:.  _   |
            +         |:. (_)  |          *
                      ;:.      ;
                    .' \:.    / `.
                   / .-'':._.'`-. \
                   |/    /||\    \|
                 _..--"""````"""--.._
           _.-'``                    ``'-._
         -'                                '-
                  GROUND CONTROL:
      The REST Release Rocket has successfully landed.
Move on to the next node, tiger, otherwise see you for the next launch.
------------------------------------------------------------------------
EOF

# end
