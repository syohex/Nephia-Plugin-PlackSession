# NAME

Nephia::Plugin::PlackSession - Session Plugin for Nephia

# SYNOPSIS

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

# DESCRIPTION

Nephia::Plugin::PlackSession is plugin that provides session management using Plack::Session

# LICENSE

Copyright (C) papix.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

papix <mail@papix.net>
