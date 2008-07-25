use strict;
use Test::More 'no_plan';

use Email::Address::JP::Mobile;

my @non_mobile = (
    'foo@example.com',
    'foo@dxx.pdx.ne.jp',
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

my @is_mobile_but_old = (
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
);

my @is_mobile = (
    @docomo,
    @kddi,
    @softbank,
    @willcom,
    @is_mobile_but_old,
);

for my $address (@non_mobile) {
    my $carrier = Email::Address::JP::Mobile->new($address);
    ok ! $carrier->is_mobile, $address;
    is $carrier->name, 'NonMobile', $address;
    is $carrier->carrier_letter, 'N', $address;
    
    ok $carrier->mime_encoding->can('encode');
    ok $carrier->mail_encoding->can('encode');

    is $carrier->mime_encoding->name, 'MIME-Header';
    is $carrier->mail_encoding->name, 'utf-8-strict';
    
    local $Email::Address::JP::Mobile::NonMobile::Encoding = 'iso-2022-jp';
    is $carrier->mime_encoding->name, 'MIME-Header-ISO_2022_JP';
    is $carrier->mail_encoding->name, 'iso-2022-jp';
}

for my $address (@is_mobile) {
    my $carrier = Email::Address::JP::Mobile->new($address);
    ok $carrier->is_mobile, $address;
}

for my $address (@is_mobile_but_old) {
    my $carrier = Email::Address::JP::Mobile->new($address);
    ok $carrier->is_mobile, $address;
    
    is $carrier->name, 'IsMobile', $address;
    is $carrier->carrier_letter, '', $address;
    
    ok $carrier->mime_encoding->can('encode');
    ok $carrier->mail_encoding->can('encode');
    is $carrier->mime_encoding->name, 'MIME-Header-ISO_2022_JP';
    is $carrier->mail_encoding->name, 'iso-2022-jp';
}

for my $address (@docomo) {
    my $carrier = Email::Address::JP::Mobile->new($address);
    ok $carrier->is_mobile, $address;
    
    is $carrier->name, 'DoCoMo', $address;
    is $carrier->carrier_letter, 'I', $address;
    
    ok $carrier->mime_encoding->can('encode');
    ok $carrier->mail_encoding->can('encode');
    is $carrier->mime_encoding->name, 'MIME-Header-JP-Mobile-DoCoMo-SJIS';
    is $carrier->mail_encoding->name, 'x-sjis-docomo';
}

for my $address (@kddi) {
    my $carrier = Email::Address::JP::Mobile->new($address);
    ok $carrier->is_mobile, $address;
    
    is $carrier->name, 'EZweb', $address;
    is $carrier->carrier_letter, 'E', $address;
    
    ok $carrier->mime_encoding->can('encode');
    ok $carrier->mail_encoding->can('encode');
    is $carrier->mime_encoding->name, 'MIME-Header-JP-Mobile-KDDI-SJIS';
    is $carrier->mail_encoding->name, 'x-sjis-kddi-auto';
}

for my $address (@softbank) {
    my $carrier = Email::Address::JP::Mobile->new($address);
    ok $carrier->is_mobile, $address;
    
    is $carrier->name, 'SoftBank', $address;
    is $carrier->carrier_letter, 'V', $address;
    
    ok $carrier->mime_encoding->can('encode');
    ok $carrier->mail_encoding->can('encode');
    is $carrier->mime_encoding->name, 'MIME-Header-JP-Mobile-SoftBank-UTF8';
    is $carrier->mail_encoding->name, 'x-utf8-softbank';
}

for my $address (@willcom) {
    my $carrier = Email::Address::JP::Mobile->new($address);
    ok $carrier->is_mobile, $address;

    is $carrier->name, 'AirH', $address;
    is $carrier->carrier_letter, 'H', $address;

    ok $carrier->mime_encoding->can('encode');
    ok $carrier->mail_encoding->can('encode');
    is $carrier->mime_encoding->name, 'MIME-Header-JP-Mobile-AirH-SJIS';
    is $carrier->mail_encoding->name, 'x-sjis-airh';
}
