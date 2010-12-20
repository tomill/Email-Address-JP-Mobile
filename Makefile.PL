use inc::Module::Install;
all_from 'lib/Email/Address/JP/Mobile.pm';

requires 'Email::Address::Loose';
requires 'Encode';
requires 'Encode::JP::Mobile' => 0.27; # mime encodings

test_requires 'Test::More' => 0.94; # subtest
test_requires 'Email::Address';
author_tests 'xt';

readme_from 'lib/Email/Address/JP/Mobile.pm';

resources(
    repository => 'http://github.com/tomi-ru/Email-Address-JP-Mobile',
    bugtracker => 'http://github.com/tomi-ru/Email-Address-JP-Mobile/issues',
);

WriteAll;
