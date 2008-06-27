package Email::Address::JP::Mobile;
use strict;
use warnings;
our $VERSION = '0.01';

use Mail::Address::MobileJp;

our $carrier_list = [
    {
        name     => 'DoCoMo',
        letter   => 'D',
        detector => \&is_imode,
        encoding => 'x-sjis-docomo',
    },
    {
        name     => 'EZweb',
        letter   => 'E',
        detector => \&is_ezweb,
        encoding => 'x-sjis-kddi-auto',
    },
    {
        name     => 'ThirdForce',
        letter   => 'V',
        detector => \&is_vodafone,
        encoding => 'x-utf8-softbank',
    },
    {
        name     => 'AirHPhone',
        letter   => 'H',
        detector => sub {
            my $email = shift;
            is_mobile_jp($email) && $email =~ /pdx\.ne\.jp$/ ? 1 : 0; # need Mail::Address::MobileJp::is_willcom?
        },
        encoding => 'x-sjis-docomo', # XXX x-sjis-airh ??
    },
    {
        name     => 'NonMobile',
        letter   => 'N',
        detector => sub { not is_mobile_jp(shift) },
        encoding => 'iso-2022-jp',
    },
];
    
sub Email::Address::is_mobile {
    my $self = shift;
    is_mobile_jp($self->address) ? 1 : 0;
}

sub Email::Address::carrier_name {
    my $self = shift;
    my $carrier = __carrier($self->address);
    $carrier->{name};
}

sub Email::Address::carrier_letter {
    my $self = shift;
    my $carrier = __carrier($self->address);
    $carrier->{letter};
}

sub Email::Address::encoding_name {
    my $self = shift;
    my $carrier = __carrier($self->address);
    $carrier->{encoding};
}

sub __carrier {
    my $address = shift;
    
    for my $carrier (@$carrier_list) {
        return $carrier if $carrier->{detector}->($address);
    }
    
    return { # dummy
        name     => '',
        oldname  => '',
        letter   => '',
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Email::Address::JP::Mobile - Extends Email::Address for Japanese cellphone

=head1 SYNOPSIS

  use Email::Address::JP::Mobile;

  my ($email) = Email::Address->parse('docomo.taro@docomo.ne.jp');
  
  $email->is_mobile;      # 1
  $email->carrier_name;   # DoCoMo
  $email->carrier_letter; # D
  $email->encoding_name;  # x-sjis-docomo

=head1 DESCRIPTION

Email::Address::JP::Mobile extends L<Email::Address> object for Japanese
carrier information.

B<CAUTION:> This module is still alpha, its possible the API will change.

=head1 METHODS

=over 4

=item is_mobile

These return 1 or 0.

=item carrier_letter

Returns L<HTTP::MobileAgent> (and L<HTTP::MobileAttribute>) 's carrier() value
like "V".

=item carrier_name

Returns L<HTTP::MobileAttribute>'s carrier_longname() value like "ThirdForce".

=item encoding_name

絵文字を残して送信できる L<Encode::JP::Mobile> のエンコーディング名を返します。
例えば "x-sjis-docomo".

=back

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=head1 DEVELOPMENT

L<http://coderepos.org/share/browser/lang/perl/Email-Address-JP-Mobile>

#mobilejp on irc.freenode.net (I've joined as "tomi-ru")

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Email::Address>, L<Email::Address::Loose>, L<Mail::Address::MobileJp>

=cut
