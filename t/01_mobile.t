use strict;
use Test::More 'no_plan';

use Email::Address::Loose;
use Email::Address::JP::Mobile;

my @non_mobile = (
    'foo@example.com',
    'foo@dxx.pdx.ne.jp',
    'foo <foo@doo.com>',
);

my @docomo = (
    'foo@docomo.ne.jp',
    'rfc822.@docomo.ne.jp',
    '-everyone..-_-..annoyed-@docomo.ne.jp',
);

my @kddi = (
    'foo@ezweb.ne.jp',
    'foo@hoge.ezweb.ne.jp',
);

my @softbank = (
    'foo@jp-d.ne.jp',
    'foo@d.vodafone.ne.jp',
    'foo@softbank.ne.jp',
    'foo@disney.ne.jp',
);

my @willcom = (
    'foo@pdx.ne.jp',
    'foo@di.pdx.ne.jp',
    'foo@dj.pdx.ne.jp',
    'foo@dk.pdx.ne.jp',
    'foo@dx.pdx.ne.jp',
);

my @is_mobile = (
    @docomo,
    @kddi,
    @softbank,
    @willcom,
    'foo@mnx.ne.jp',
    'foo@bar.mnx.ne.jp',
    'foo@dct.dion.ne.jp',
    'foo@sky.tu-ka.ne.jp',
    'foo@bar.sky.tkc.ne.jp',
    'foo@em.nttpnet.ne.jp',
    'foo@bar.em.nttpnet.ne.jp',
    'foo@phone.ne.jp',
    'foo@bar.mozio.ne.jp',
    'foo@p1.foomoon.com',
    'foo@x.i-get.ne.jp',
    'foo@ez1.ido.ne.jp',
    'foo@cmail.ido.ne.jp',
    'foo <foo@p1.foomoon.com>',
);

for my $address (@non_mobile) {
    my ($email) = Email::Address::Loose->parse($address);
    ok $email->is_non_mobile($address), $address;
    ok ! $email->is_mobile($address), $address;
    ok ! $email->is_docomo($address), $address;
    ok ! $email->is_kddi($address), $address;
    ok ! $email->is_softbank($address), $address;
    ok ! $email->is_willcom($address), $address;
    is $email->carrier_name, 'NonMobile', $address;
    is $email->carrier_name_aka, 'NonMobile', $address;
    is $email->carrier, 'N', $address;
    is $email->carrier_letter, 'N', $address;
    is $email->encoding_name, 'iso-2022-jp';
}

for my $address (@is_mobile) {
    my ($email) = Email::Address::Loose->parse($address);
    ok $email->is_mobile($address), $address;
    ok ! $email->is_non_mobile($address), $address;
}

for my $address (@docomo) {
    my ($email) = Email::Address::Loose->parse($address);
    ok $email->is_docomo($address), $address;
    ok $email->is_imode($address), $address;
    ok $email->is_mobile($address), $address;
    ok ! $email->is_non_mobile($address), $address;
    ok ! $email->is_kddi($address), $address;
    ok ! $email->is_softbank($address), $address;
    ok ! $email->is_willcom($address), $address;
    is $email->carrier_name, 'DoCoMo', $address;
    is $email->carrier_name_aka, 'DoCoMo', $address;
    is $email->carrier, 'D', $address;
    is $email->carrier_letter, 'D', $address;
    is $email->encoding_name, 'x-sjis-docomo';
}

for my $address (@kddi) {
    my ($email) = Email::Address::Loose->parse($address);
    ok $email->is_kddi($address), $address;
    ok $email->is_ezweb($address), $address;
    ok $email->is_mobile($address), $address;
    ok ! $email->is_non_mobile($address), $address;
    ok ! $email->is_docomo($address), $address;
    ok ! $email->is_softbank($address), $address;
    ok ! $email->is_willcom($address), $address;
    is $email->carrier_name, 'EZweb', $address;
    is $email->carrier_name_aka, 'EZweb', $address;
    is $email->carrier, 'E', $address;
    is $email->carrier_letter, 'E', $address;
    is $email->encoding_name, 'x-sjis-kddi-auto';
}

for my $address (@softbank) {
    my ($email) = Email::Address::Loose->parse($address);
    ok $email->is_softbank($address), $address;
    ok $email->is_thirdforce($address), $address;
    ok $email->is_vodafone($address), $address;
    ok $email->is_j_phone($address), $address;
    ok $email->is_mobile($address), $address;
    ok ! $email->is_non_mobile($address), $address;
    ok ! $email->is_docomo($address), $address;
    ok ! $email->is_kddi($address), $address;
    ok ! $email->is_willcom($address), $address;
    is $email->carrier_name, 'ThirdForce', $address;
    is $email->carrier_name_aka, 'Vodafone', $address;
    is $email->carrier, 'V', $address;
    is $email->carrier_letter, 'V', $address;
    is $email->encoding_name, 'x-utf8-softbank';
}

for my $address (@willcom) {
    my ($email) = Email::Address::Loose->parse($address);
    ok $email->is_willcom($address), $address;
    ok $email->is_airh($address), $address;
    ok $email->is_airhphone($address), $address;
    ok $email->is_mobile($address), $address;
    ok ! $email->is_non_mobile($address), $address;
    ok ! $email->is_docomo($address), $address;
    ok ! $email->is_kddi($address), $address;
    ok ! $email->is_softbank($address), $address;
    is $email->carrier_name, 'AirHPhone', $address;
    is $email->carrier_name_aka, 'AirH', $address;
    is $email->carrier, 'H', $address;
    is $email->carrier_letter, 'H', $address;
    is $email->encoding_name, 'x-sjis-docomo';
}
