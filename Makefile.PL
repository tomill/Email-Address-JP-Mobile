use inc::Module::Install;

name 'Email-Address-JP-Mobile';
all_from 'lib/Email/Address/JP/Mobile.pm';

requires 'Encode';
requires 'Encode::JP::Mobile', 0.26;
requires 'Mail::Address::MobileJp';
requires 'Module::Pluggable';

build_requires 'Test::More';
build_requires 'Email::Address';

auto_include;

WriteAll;
