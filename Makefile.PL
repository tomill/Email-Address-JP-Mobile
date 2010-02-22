use inc::Module::Install;
name 'Email-Address-JP-Mobile';
all_from 'lib/Email/Address/JP/Mobile.pm';

auto_set_repository;

requires 'Email::Address::Loose';

test_requires 'Test::More';
test_requires 'Email::Address';
author_tests 'xt';

auto_install;
auto_include_deps;
WriteAll;
