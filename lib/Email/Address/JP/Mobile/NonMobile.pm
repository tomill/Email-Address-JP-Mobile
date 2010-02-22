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

1;
