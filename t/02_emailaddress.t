use strict;
use Test::More tests => 4;

use Email::Address;
use Email::Address::JP::Mobile;

my ($email) = Email::Address->parse('Taro <docomo.taro@docomo.ne.jp>');
isa_ok $email->carrier, 'Email::Address::JP::Mobile::DoCoMo';
is $email->carrier->name, 'DoCoMo';

my $carrier = Email::Address::JP::Mobile->new($email);
isa_ok $carrier, 'Email::Address::JP::Mobile::DoCoMo';
is $carrier->name, 'DoCoMo';

