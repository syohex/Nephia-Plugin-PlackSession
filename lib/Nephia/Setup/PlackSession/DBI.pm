package Nephia::Setup::PlackSession::DBI;
use strict;
use warnings;

sub required_modules {
    'Nephia::Plugin::PlackSession' => '0',
}

sub additional_methods {
    'sql_file',
}

sub sql_file {
    my $self = shift;

    $self->mkpath($self->approot, 'db');
    $self->mkpath($self->approot, 'sql');

    my $body = $self->templates->{sql_file};
    for (qw/ sqlite.sql mysql.sql /) {
        my $file = File::Spec->catfile($self->approot, 'sql', $_);
        $self->spew($file, $body);
    }
}

1;
__DATA__

psgi_file
---
use strict;
use warnings;
use FindBin;
use Config::Micro;
use DBI;
use File::Spec;
use Plack::Builder;
use Plack::Session::Store::DBI;
use Plack::Session::State::Cookie;

use lib ("$FindBin::Bin/lib", "$FindBin::Bin/extlib/lib/perl5");
use $appname;
my $config = require( Config::Micro->file( dir => File::Spec->catdir('etc','conf') ) );
my $db_config = $config->{DBI} || die "Missing configuration for DBI";

builder {
    enable 'Plack::Middleware::Session',
        store => Plack::Session::Store::DBI->new(
            get_dbh => sub {
                DBI->connect( @$db_config )
                    or die $DBI::errstr;
            }
        ),
        state => Plack::Session::State::Cookie->new(
            httponly => 1,
        );
    $appname->run( $config );
}
===

conf_file
---
### environment specific config
use utf8;
use File::Spec;
use File::Basename 'dirname';
my $basedir = File::Spec->rel2abs(
    File::Spec->catdir( dirname(__FILE__), '..', '..' )
);
my $dbpath = File::Spec->catfile($basedir, 'db', '$envname.db' );
+{
    %{ do(File::Spec->catfile($basedir, 'etc', 'conf', 'common.pl')) },
    envname => '$envname',
    DBI => [
        "dbi:SQLite:dbname=$dbpath", '', '',
        +{
            sqlite_unicode => 1,
        }
    ],
};
===

sql_file
---
CREATE TABLE IF NOT EXISTS sessions (
    id           CHAR(72) PRIMARY KEY,
    session_data TEXT
);
===
