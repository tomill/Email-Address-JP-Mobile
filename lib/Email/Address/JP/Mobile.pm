package Email::Address::JP::Mobile;
use strict;
use warnings;
our $VERSION = '0.01';

use Mail::Address::MobileJp;

our $carrier_list = [
    {
        newname  => 'NonMobile',
        oldname  => 'NonMobile',
        letter   => 'N',
        methods  => [qw( is_non_mobile )],
        detector => sub { not is_mobile_jp(shift) },
        encoding => 'iso-2022-jp',
    },
    {
        newname  => 'DoCoMo',
        oldname  => 'DoCoMo',
        letter   => 'D',
        methods  => [qw( is_docomo is_imode )],
        detector => \&is_imode,
        encoding => 'x-sjis-docomo',
    },
    {
        newname  => 'EZweb',
        oldname  => 'EZweb',
        letter   => 'E',
        methods  => [qw( is_kddi is_ezweb )],
        detector => \&is_ezweb,
        encoding => 'x-sjis-kddi-auto',
    },
    {
        newname  => 'ThirdForce',
        oldname  => 'Vodafone',
        letter   => 'V',
        methods  => [qw( is_softbank is_thirdforce is_vodafone is_j_phone )],
        detector => \&is_vodafone,
        encoding => 'x-utf8-softbank',
    },
    {
        newname  => 'AirHPhone',
        oldname  => 'AirH',
        letter   => 'H',
        methods  => [qw( is_willcom is_airhphone is_airh )],
        detector => sub {
            my $email = shift;
            is_mobile_jp($email) && $email =~ /pdx\.ne\.jp$/ ? 1 : 0; # need Mail::Address::MobileJp::is_willcom?
        },
        encoding => 'x-sjis-docomo', # XXX x-sjis-airh ??
    },
];
    
# make is_* method
for my $carrier (@$carrier_list) {
    no strict 'refs'; ## no critic
    for my $method (@{ $carrier->{methods} }) {
        *{'Email::Address::'.$method} = sub {
            my $self = shift;
            $carrier->{detector}->($self->address) ? 1 : 0;
        };
    }
}

sub Email::Address::is_mobile {
    my $self = shift;
    is_mobile_jp($self->address) ? 1 : 0;
}

sub Email::Address::carrier_name {
    my $self = shift;
    my $carrier = __carrier($self->address);
    $carrier->{newname};
}

sub Email::Address::carrier_name_aka {
    my $self = shift;
    my $carrier = __carrier($self->address);
    $carrier->{oldname};
}

*Email::Address::carrier = \&Email::Address::carrier_letter;

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
        newname  => '',
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
  $email->is_non_mobile;  # 0
  $email->is_docomo;      # 1
  $email->is_ezweb;       # 0
  $email->is_softbank;    # 0
  $email->carrier_name;   # DoCoMo
  $email->carrier_letter; # D
  ...

=head1 DESCRIPTION

Email::Address::JP::Mobile extends L<Email::Address> object for Japanese
carrier information.

B<CAUTION:> This module is still alpha, its possible the API will change.

=head1 METHODS

=over 4

=item is_mobile

=item is_non_mobile

=item is_docomo, is_imode

=item is_kddi, is_ezweb

=item is_softbank, is_thirdforce, is_j_phone, is_vodafone

=item is_willcom, is_airhphone, is_airh

These return 1 or 0.

=item carrier, carrier_letter

Returns L<HTTP::MobileAgent> (and L<HTTP::MobileAttribute>) 's carrier() value
like "V".

=item carrier_name

Returns L<HTTP::MobileAttribute>'s carrier_longname() value like "ThirdForce".

=item carrier_name_aka

Returns L<HTTP::MobileAgent>'s carrier_longname() value like "Vodafone".

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
