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
    $_[1]->host =~ $regex  ? 10 : 0;
}

sub name { 'AirH' }

sub carrier_letter { 'H' }

sub is_mobile { 1 }

sub mime_encoding {
    Encode::find_encoding('MIME-Header-JP-Mobile-AirH');
}

sub mail_encoding {
    Encode::find_encoding('x-sjis-airh');
}

1;
__END__

=encoding utf-8

=head1 NAME

Email::Address::JP::Mobile::AirH - Email class for Japanese carrier Willcom

=head1 METHODS

=over 4

=item name

  $carrier->name; # "AirH"

=item carrier_letter

  $carrier->carrier_letter; # "H"

=item is_mobile

  $carrier->is_mobile; # 1

=item mime_encoding

  $carrier->mime_encoding; # 'MIME-Header-JP-Mobile-AirH' encoding object
  $carrier->mime_encoding->encode("foo");

=item mail_encoding

  $carrier->mail_encoding; # 'x-sjis-airh' encoding object
  $carrier->mail_encoding->encode('foo');

=back

=head1 SEE ALSO

L<Mail::Address::MobileJp>, L<Encode::JP::Mobile>, L<HTTP::MobileAgent::AirHPhone>,
L<http://www.willcom-inc.com/>

L<http://www.willcom-inc.com/ja/service/e_mail/spec/index.html>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
