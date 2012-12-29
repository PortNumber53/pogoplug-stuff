pogoplug-stuff
==============

Instructions for backup:
------------------------

To use backup-mediatemple.sh, first you need to make a copy of backup-variables.sh

cp ./custom/backup-variables.sh.sample ./custom/backup-variables.sh

You need to customize your .ssh/config so you can "ssh *host*" to a specific host using SSH keys.
Then you can run (from the command line, or a crond entry)

project=*host* ./pogoplug-stuff/templates/backup-mediatemple.sh


Instruction for poking:
-----------------------

To use templates/poke_monitor.sh, first you need to make a copy of poke_monitor.sh.sample

cp ./poke_monitor.sh.sample ./poke_monitor.sh

Customize the variables *node* and *hash* to uniquely identity your pogo.
Then you can run (from the command line, or a crond entry)

./pogoplug-stuff/poke_monitor.sh

Now you need to make a PHP script to receive the poke, and then present the information on a dashboard (sample: http://portnumber53.com/monitor/)


Dependencies:
-------------

If you want to use the SSH reverse tunnel you need to install jshon.sh

http://kmkeen.com/jshon/

for ArchLinux:

pacman -S jshon
