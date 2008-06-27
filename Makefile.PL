use inc::Module::Install;

name 'Email-Address-JP-Mobile';
all_from 'lib/Email/Address/JP/Mobile.pm';

requires 'Mail::Address::MobileJp';
requires 'Email::Address::Loose';

build_requires 'Test::More';
build_requires 'Email::Address::Loose';

auto_include;

WriteAll;
