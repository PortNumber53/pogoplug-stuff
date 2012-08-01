pogoplug-stuff
==============

Instructions:
-------------

To use backup-mediatemple.sh, first you need to make a copy of backup-variables.sh

cp ./custom/backup-variables.sh.sample ./custom/backup-variables.sh

You need to customize your .ssh/config so you can "ssh *host*" to a specific host using SSH keys.
Then you can run (from the command line, or a crond entry)

project=*host* /home/httpd/pogoplug-stuff/templates/backup-mediatemple.sh

