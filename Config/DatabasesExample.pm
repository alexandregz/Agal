##################################################################################
# config para creaçom de backups (see create_backups_agal.pl)
# This file must be into .gitignore!!!! and into "Config" directory
#
# Alexandre Espinosa Menor <aemenor@gmail.com>
###################################################################################
package Databases;

use strict;
use File::Basename;

#my $WHICH_BIN='/bin/which';

# config
my $DATE_BACKUP = `date +%Y%m%d`;
chomp($DATE_BACKUP);
#$DATE_BACKUP .= "_".`date +%H%M`;
#chomp($DATE_BACKUP);

my $MYSQLDUMP_BIN =  '/usr/local/mysql/bin/mysqldump';
chomp($MYSQLDUMP_BIN);
$MYSQLDUMP_BIN.= ' --opt';

my $COMPRESS_BIN = '/bin/bzip2';
#my $COMPRESS_BIN = `$WHICH_BIN bzip2`;
#chomp($COMPRESS_BIN);
my $BACKUP_NAME = 'DB_$db_'.$DATE_BACKUP.'.sql.bz2'; 

# diretorio a gardar
my $PATH_BACKUPS = dirname($0).'/backups/';

# para restore
my $BZCAT_BIN = '/bin/bzcat';
my $MYSQL_BIN = '/usr/local/mysql/bin/mysql';




# debug
$MYSQLDUMP_BIN = '/Applications/MAMP/Library/bin/mysqldump --opt' if(-f '/Applications/MAMP/Library/bin/mysqldump');
$BZCAT_BIN = '/opt/local/bin/bzcat' if(-f '/opt/local/bin/bzcat');;
$MYSQL_BIN = '/Applications/MAMP/Library/bin/mysql' if(-f '/Applications/MAMP/Library/bin/mysql');


# para engadir databases 
# 	formato: user => { db => dsn }
my $DATABASES = {
	# estraviz.org
	'estraviz' => {
		'estraviz' => 'mysql://estraviz:password@localhost/estraviz',
	},
	# agal-gz.org
	'agal-gz' => {
		'agal' => 'mysql://user:password@localhost/db'
	},
    
   # debug
   'aespinosa' => {
        proba1 => 'mysql://root:root@localhost/proba1',
        proba2 => 'mysql://root:root@localhost/proba2',
   }
};


# returns user dbs
sub getUserDbs{
	my $user = $_[0];

	foreach($DATABASES->{$user}) {
		return keys(%{$_});
	}

	return undef;
}


# returns user, passwd, db
sub getConfigDb{
	my $user = $_[0];
	my $db = $_[1];

	return ($1, $2, $3) if($DATABASES->{$user}->{$db} =~ /^\w+\:\/\/(\w+)\:(\w+)\@\w+\/(\w+)$/);

	return undef;
}

sub getBinMysqldump{
	return $MYSQLDUMP_BIN;
}

sub getCompress{
    return $COMPRESS_BIN;
}

sub getBackupName{
    my $db = $_[0];
    
    my $BACKUP_NAME_TMP = $PATH_BACKUPS.$BACKUP_NAME;
    $BACKUP_NAME_TMP =~ s/\$db/$db/;
    return $BACKUP_NAME_TMP;
}


sub dateNow{
    my $date = `date`;
    chomp($date);
    return "[$date]";
}

1;


#package Main;
#my ($user, $password, $db) = &Databases::getConfigDb('estraviz', 'estraviz');
#my $dbs = &Databases::getUserDbs('estraviz');
