package Email::Address::JP::Mobile::AirH;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::Base';

my $regex = qr/^(?:
pdx\.ne\.jp|
d.\.pdx\.ne\.jp|
wm\.pdx\.ne\.jp
)$/x;

sub matches {
    $_[1]->host =~ $regex;
}

sub name { 'AirH' }

sub carrier_letter { 'H' }

sub is_mobile { 1 }

1;
