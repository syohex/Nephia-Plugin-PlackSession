use strict;
use warnings;
use utf8;
use Test::More;
use Test::Requires 'Test::WWW::Mechanize::PSGI', 'Plack::Session';
use Plack::Middleware::Session;
use Plack::Builder;

{
    package MyApp;
    use Nephia plugins => qw/ PlackSession /;

    path '/' => sub {
        my $req = shift;
        my $cnt = session->get('cnt') || 0;
        ++$cnt;
        session->set('cnt' => $cnt);
        return [ 200, [], [$cnt] ];
    };
}

my $app = builder {
    enable 'Session';
    MyApp->run();
};

my $mech = Test::WWW::Mechanize::PSGI->new( app => $app );
$mech->get_ok('/');
is $mech->content(), '1';
$mech->get_ok('/');
is $mech->content(), '2';

done_testing;
