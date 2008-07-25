use Test::Dependencies
    exclude => [qw( Test::Dependencies Email::Address::JP::Mobile )],
    style => 'light';

ok_dependencies();
