package Email::Address::JP::Mobile::NonMobile;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::Base';

sub matches {
    1;
}

sub name { 'NonMobile' }

sub carrier_letter { 'N' }

sub is_mobile { 0 }

sub mime_encoding {
    Encode::find_encoding('MIME-Header-ISO_2022_JP');
}

sub send_encoding {
    Encode::find_encoding('iso-2022-jp');
}

sub parse_encoding {
    Encode::find_encoding('iso-2022-jp');
}

1;
