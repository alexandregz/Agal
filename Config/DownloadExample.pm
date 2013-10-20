##################################################################################
# config para download de backups (see download_backups_agal.pl)
# This file must be into .gitignore!!!! and into "Config" directory
#
# Alexandre Espinosa Menor <aemenor@gmail.com>
###################################################################################
package Download;

use File::Basename;
use Config::Databases;

#my $SERVER = 'agal.dinaserver.com';
my $SERVER = 'localhost.dyndns.org';
my $USER = 'Alexandre';
my $SERVER_OPTIONS = '-P 22';

#my $HAVE_WOL_HOST = undef;
my $HAVE_WOL_HOST = 1;
my $MAC_WOL = 'aa:bb:cc:dd:ee:ff';
my $PORT_WOL = 7;

# path donde atopamos os backups
my $PATH_INICIAL = dirname($0);
my $PATH_BACKUPS_LOCAL = '/Volumes/Datos/backups_AGAL/';


sub getConfig{
	return $HOSTINGS;
}


sub getServer{
	return $USER.'@'.$SERVER;
}

sub getServerOptions{
	return $SERVER_OPTIONS;
}

sub getPathBackups{
	return $PATH_INICIAL;
}

sub getPathBackupsLocal{
	return $PATH_BACKUPS_LOCAL;
}

# use ./wakeonlan perl script (http://gsd.di.uminho.pt/jpo/software/wakeonlan/)
sub getCommandWakeonlan{
	return "wakeonlan -p $PORT_WOL -i $SERVER $MAC_WOL" if($HAVE_WOL_HOST);

	return undef;
}

1;
