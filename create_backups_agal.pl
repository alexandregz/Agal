##############################################################################
# Backup de BDs de MySQL
#
# Usso: perl create_backups_agal.pl 2>&1 |tee logs/log_create_2013-10-17.txt
#
# Alexandre Espinosa Menor <aemenor@gmail.com>
##############################################################################

use strict;
use File::Basename;
use lib dirname(__FILE__);

use Config::Databases;

# segundos nos que paramos se ja estamos fazendo backup de bd
my $SECONDS_TO_SLEEP = 5;

my $mysqldump = &Databases::getBinMysqldump;
my $compressbin = &Databases::getCompress;

my $usr = $ENV{"LOGNAME"};

#debug
#$usr = 'estraviz';

print &Databases::dateNow." Comezo com user [$usr]...\n";

my @dbs = &Databases::getUserDbs($usr);

my $pidfile;
foreach my $db (@dbs) {
    my ($userDB, $passwordDB) = &Databases::getConfigDb($usr, $db);

    my $backupName = &Databases::getBackupName($db);

    while(-e $db.'.pid') {
	print &Databases::dateNow." Existe processo de backup de [$db]. Agardamos 5 seg.\n";
	sleep($SECONDS_TO_SLEEP);
    }
    
    print &Databases::dateNow." Fazendo backup de $db em $backupName\n";

    open FILE, '> '.$db.'.pid' or die $!;
    print FILE $$; 
    `$mysqldump --password=$passwordDB --user=$userDB $db | $compressbin > "$backupName"`;
    #print "$mysqldump --password=$passwordDB --user=$userDB $db | $compressbin > '$backupName'";
    close FILE;
    unlink $db.'.pid';
}

print &Databases::dateNow." Fim\n";

1;
