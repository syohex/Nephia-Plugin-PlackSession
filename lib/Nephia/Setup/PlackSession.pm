package Nephia::Setup::PlackSession;
use strict;
use warnings;

sub required_modules {
    'Nephia::Plugin::PlackSession' => '0',
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
use Plack::Session::State::Cookie;

use lib ("$FindBin::Bin/lib", "$FindBin::Bin/extlib/lib/perl5");
use $appname;
my $config = require( Config::Micro->file( dir => File::Spec->catdir('etc','conf') ) );

builder {
    enable 'Plack::Middleware::Session',
        state => Plack::Session::State::Cookie->new(
            httponly => 1,
        );
    $appname->run( $config );
}
===
