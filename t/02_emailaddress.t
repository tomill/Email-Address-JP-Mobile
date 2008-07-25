use strict;
use Test::More tests => 2;

use Email::Address;
use Email::Address::JP::Mobile;

my ($email) = Email::Address->parse('Taro <docomo.taro@docomo.ne.jp>');
isa_ok $email->carrier, 'Email::Address::JP::Mobile::DoCoMo';
is $email->carrier->name, 'DoCoMo';
