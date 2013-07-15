package Nephia::Plugin::PlackSession;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

use Plack::Session;
our @EXPORT = qw/ session /;

sub session (@){
    my $caller = caller;
    return Plack::Session->new($caller->req->env);
}

1;
__END__

=encoding utf-8

=head1 NAME

Nephia::Plugin::PlackSession - It's new $module

=head1 SYNOPSIS

    use Nephia::Plugin::PlackSession;

=head1 DESCRIPTION

Nephia::Plugin::PlackSession is ...

=head1 LICENSE

Copyright (C) papix.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

papix E<lt>mail@papix.netE<gt>

=cut

