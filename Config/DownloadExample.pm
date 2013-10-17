##################################################################################
# config para download de backups (see download_backups_agal.pl)
# This file must be into .gitignore!!!! and into "Config" directory
#
# Alexandre Espinosa Menor <aemenor@gmail.com>
###################################################################################
package Download;

use Config::Databases;

#my $SERVER = 'agal.dinaserver.com';
my $SERVER = 'Alexandre@localhost';
my $SERVER_OPTIONS = '-P 22';

# path donde atopamos os backups
#my $PATH_DOWNLOAD = '$HOME/path_download/';
my $PATH_DOWNLOAD = '.';
my $PATH_BACKUPS_LOCAL = '/Volumes/Datos/backups_AGAL/';


sub getConfig{
	return $HOSTINGS;
}


sub getServer{
	return $SERVER;
}

sub getServerOptions{
	return $SERVER_OPTIONS;
}

sub getPathBackups{
	return $PATH_DOWNLOAD;
}

sub getPathBackupsLocal{
	return $PATH_BACKUPS_LOCAL;
}

1;
