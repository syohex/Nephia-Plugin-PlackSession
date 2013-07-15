package Nephia::Setup::PlackSession;
use strict;
use warnings;

sub required_modules {
    'Nephia::Plugin::PlackSession' => '0',
    'Plack::Middleware::Session'   => '0',
}

1;
__DATA__

psgi_file
---
use strict;
use warnings;
use FindBin;
use Config::Micro;
use File::Spec;
use Plack::Builder;

use lib ("$FindBin::Bin/lib", "$FindBin::Bin/extlib/lib/perl5");
use $appname;
my $config = require( Config::Micro->file( dir => File::Spec->catdir('etc','conf') ) );

builder {
    enable 'Plack::Middleware::Session';
    $appname->run( $config );
}
===

