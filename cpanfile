requires 'perl', '5.008001';
requires 'Nephia', '0.32';
requires 'Plack::Middleware::Session';
requires 'Plack::Builder';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::Requires';
    requires 'Test::WWW::Mechanize::PSGI';
};

