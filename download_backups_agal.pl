##################################################################################
# Script para baixar backups de BDs empregados no server da AGAL.
#
# Para deixar todo num mesmo lado, desde o hosting baixamos os backups. 
# Necessario exportar a key publica do user ao hosting
#
# Usso: perl download_backups_agal.pl 2>&1 |tee logs/log_download_2013-10-17.txt
#
# Alexandre Espinosa Menor <aemenor@gmail.com>
###################################################################################

use strict;
use File::Basename;
use lib dirname(__FILE__);

# see DownloadExample.pm
use Config::Download;

print &Databases::dateNow." Comezo\n";

my $server = &Download::getServer;
my $serverOptions = &Download::getServerOptions;

# comodim para ficheiros de backup
my $wildcard = &Databases::getBackupName('*');


# get all files from today 
print &Databases::dateNow." Recolhendo Backups de hoje em ".&Download::getPathBackups."\n"; 
my @backups = `du -h $wildcard`;
map { chomp($_); } @backups;

my $pathBackupsLocal = &Download::getPathBackupsLocal;
#print &Databases::dateNow. " Server:path download: $server:$pathBackupsLocal\n";
foreach my $l (@backups) {
 	my ($size, $file) = split(/\s+/, $l);
	print &Databases::dateNow." Baixando $file [$size]...\n";
	`scp $serverOptions $file $server:$pathBackupsLocal`;
	#print "scp $serverOptions $file $server:$pathBackupsLocal\n";
}

print &Databases::dateNow." Fim\n";

1;
