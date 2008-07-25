package Email::Address::JP::Mobile::IsMobile;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::Base';

use Encode;
use Encode::JP::Mobile;
use Mail::Address::MobileJp ();

sub matches {
    Mail::Address::MobileJp::is_mobile_jp($_[1]) ? 9 : 0;
}

sub name { 'IsMobile' }

sub carrier_letter { '' }

sub is_mobile { 1 }

sub mime_encoding {
    Encode::find_encoding('MIME-Header-ISO_2022_JP');
}

sub mail_encoding {
    Encode::find_encoding('iso-2022-jp');
}

1;
__END__

=encoding utf-8

=head1 NAME

Email::Address::JP::Mobile::IsMobile - Base class for Japanese mobile address

=head1 DESCRIPTION

DoCoMo でも au でも SoftBank でも AirH でもないけど
C<Mail::Address::MobileJp::is_mobile_jp> の場合このクラスになります。

=head1 METHODS

=over 4

=item name

  $carrier->name; # ""

=item carrier_letter

  $carrier->carrier_letter; # ""

=item is_mobile

  $carrier->is_mobile; # 1

=item mime_encoding

  $carrier->mime_encoding; # 'MIME-Header-ISO_2022_JP' encoding object
  $carrier->mime_encoding->encode("foo");

=item mail_encoding

  $carrier->mail_encoding; # 'iso-2022-jp' encoding object
  $carrier->mail_encoding->encode('foo');

=back

=head1 SEE ALSO

L<Mail::Address::MobileJp>, L<Encode::JP::Mobile>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
