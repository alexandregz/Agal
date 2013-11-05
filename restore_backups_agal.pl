##################################################################################
# Script para restaurar backups de BDs empregados no server da AGAL.
#
# Usso: perl restore_backups_agal.pl 2>&1 |tee logs/log_restore.txt
#
# Alexandre Espinosa Menor <aemenor@gmail.com>
###################################################################################

use strict;
use File::Basename;
use lib dirname(__FILE__);

use Config::Download;

my $BZCAT_PATH = '/bin/bzcat';
#my $BZCAT_PATH = '/opt/local/bin/bzcat';

my $MYSQL_PATH = '/usr/local/mysql/bin/mysql';
#my $MYSQL_PATH = '/Applications/MAMP/Library/bin/mysql';

my $usr = $ENV{"LOGNAME"};
#debug
#$usr = 'estraviz';


print &Databases::dateNow." Comezo\n";

my $wildcard = &Databases::getBackupName('*');

my @dbs = &Databases::getUserDbs($usr);

foreach my $db (@dbs) {
        my ($userDB, $passwordDB) = &Databases::getConfigDb($usr, $db);

        my $backupName = &Databases::getBackupName($db);
        print &Databases::dateNow." Restaurando $backupName...\n";
        `$BZCAT_PATH $backupName | $MYSQL_PATH -u $userDB -p$passwordDB $db`;
}

print &Databases::dateNow." Fim\n";

1;
