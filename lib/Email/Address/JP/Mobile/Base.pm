package Email::Address::JP::Mobile::Base;
use strict;
use warnings;

sub new {
    bless {}, shift;
}

sub matches { 0 }

sub name { '' }

sub carrier_letter { '' }

sub is_mobile { 0 }

1;
