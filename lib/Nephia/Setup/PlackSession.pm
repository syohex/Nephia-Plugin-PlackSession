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

=encoding utf-8

=head1 NAME

Nephia::Setup::Bootstrap - Template for Nephia

=head1 SYNOPSIS

    % nephia-setup MyApp --flavor=Bootstrap

=head1 DESCRIPTION

Nephia::Setup::Bootstrap is a adding flavor for Nephia.
This flavor prepares the Twitter Bootstrap and jQuery.
This module is developed in reference to Amon2::Setup::Basic.

=head1 LICENSE

Copyright (C) papix.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

papix E<lt>mail@papix.netE<gt>

=cut





