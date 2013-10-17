##################################################################################
# config para creaçom de backups (see create_backups_agal.pl)
# This file must be into .gitignore!!!! and into "Config" directory
#
# Alexandre Espinosa Menor <aemenor@gmail.com>
###################################################################################
package Databases;

use strict;

# config
my $DATE_BACKUP = `date +%Y%m%d`;
chomp($DATE_BACKUP);
#$DATE_BACKUP .= "_".`date +%H%M`;
#chomp($DATE_BACKUP);

my $MYSQLDUMP_BIN = '/path/to/mysqldump --opt';
my $COMPRESS_BIN = '/path/to/bzip2';
my $BACKUP_NAME = 'DB_$db_'.$DATE_BACKUP.'.sql.bz2'; 


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
    
    my $BACKUP_NAME_TMP = $BACKUP_NAME;
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
