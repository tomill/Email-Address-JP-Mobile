use inc::Module::Install;
name 'Email-Address-JP-Mobile';
all_from 'lib/Email/Address/JP/Mobile.pm';

auto_set_repository;

requires 'Email::Address::Loose';
requires 'Encode';
requires 'Encode::JP::Mobile' => 0.27;

test_requires 'Test::More' => 0.94; # subtest
test_requires 'Email::Address';
author_tests 'xt';

auto_install;
auto_include_deps;
WriteAll;
