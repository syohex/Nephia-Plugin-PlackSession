package Nephia::Plugin::PlackSession;
use 5.008005;
use strict;
use warnings;
use Plack::Session;

our $VERSION = "0.01";
our @EXPORT = qw/ session /;
our $APP_CLASS;

sub load {
    my ($class, $app, $opts) = @_;
    $APP_CLASS = $app;
}

sub session (@){
    return Plack::Session->new($APP_CLASS->req->env);
}

1;
__END__

=encoding utf-8

=head1 NAME

Nephia::Plugin::PlackSession - Session Plugin for Nephia

=head1 SYNOPSIS

    # create project
    % nephia-setup MyApp --flavor=PlackSession

    # app.psgi
    builder {
        enable 'Plack::Middleware::Session';
        MyApp->run( $config );
    }

    # MyApp.pm
    package MyApp.pm;
    use strict;
    use warnings;
    use Nephia plugins => qw/
    	PlackSession
    /;

    path '/' => sub {
        session->get($key);
        session->set($key, $value);
        session->remove($key);
        session->keys;
        session->expire;
    }

=head1 DESCRIPTION

Nephia::Plugin::PlackSession is plugin that provides session management using Plack::Session

=head1 LICENSE

Copyright (C) papix.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

papix E<lt>mail@papix.netE<gt>

=cut
