#!/bin/sh
# engade downloads e creaçom de backups a crontab

# para MAILTO de crontab
MAILTO='aemenor@gmail.com';


PERLPATH=$(which perl)
TEEPATH=$(which tee)
TMPFILECONTRAB=$PWD/crontab$USER

if [ -f $TMPFILECONTRAB ];
then
	rm $TMPFILECONTRAB
fi

# backup
DIA=$(date +%Y%m%d)
TEMPO=$(date +%H%M)
crontab -l > ./crontab_backup_$DIA\_$TEMPO


# add to crontab
echo "MAILTO=$MAILTO" >> $TMPFILECONTRAB
echo "05 03 * * * $PERLPATH $PWD/create_backups_agal.pl 2>&1 |$TEEPATH $PWD/logs/log_create.txt" >> $TMPFILECONTRAB
echo "35 03 * * * $PERLPATH $PWD/download_backups_agal.pl 2>&1 |$TEEPATH $PWD/logs/log_download.txt" >> $TMPFILECONTRAB

crontab $TMPFILECONTRAB
