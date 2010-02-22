package Email::Address::JP::Mobile::EZweb;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::Base';

my $regex = qr/^(?:
ezweb\.ne\.jp|
.*\.ezweb\.ne\.jp
)$/x;

sub matches {
    $_[1]->host =~ $regex;
}

sub name { 'EZweb' }

sub carrier_letter { 'E' }

sub is_mobile { 1 }

1;
