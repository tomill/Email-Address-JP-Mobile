package Email::Address::JP::Mobile::Base;
use strict;
use warnings;

use Encode;

sub new {
    bless {}, shift;
}

sub matches { 0 }

sub name { '' }

sub DESTROY { }

sub AUTOLOAD {
    my ($self, @args) = @_;
    my $method = our $AUTOLOAD;
       $method =~ s/.+:://;
    
    {
        no strict 'refs'; ## no critic
        *$AUTOLOAD = sub { undef };
    }
    
    goto &$AUTOLOAD;
}

1;
