use Test::More;
plan skip_all => "Test::Dependencies is not installed." unless eval { require Test::Dependencies; 1 };
Test::Dependencies->import(
    exclude => [qw( Test::Dependencies Email::Address::JP::Mobile )],
    style => 'light',
);
ok_dependencies();
