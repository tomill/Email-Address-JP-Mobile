package Email::Address::JP::Mobile::SoftBank;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::Base';

my $regex = qr/^(?:
jp\-[dhtckrnsq]\.ne\.jp|
[dhtckrnsq]\.vodafone\.ne\.jp|
softbank\.ne\.jp|
disney.ne.jp
)$/x;

sub matches {
    $_[1]->host =~ $regex;
}

sub name { 'SoftBank' }

sub carrier_letter { 'V' }

sub is_mobile { 1 }

1;
