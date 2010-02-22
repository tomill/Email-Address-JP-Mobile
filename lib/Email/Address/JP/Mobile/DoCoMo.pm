package Email::Address::JP::Mobile::DoCoMo;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::Base';

my $regex = qr/^(?:
docomo\.ne\.jp
)$/x;

sub matches {
    $_[1]->host =~ $regex;
}

sub name { 'DoCoMo' }

sub carrier_letter { 'I' }

sub is_mobile { 1 }

1;
