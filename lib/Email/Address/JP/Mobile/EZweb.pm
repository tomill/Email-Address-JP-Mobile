package Email::Address::JP::Mobile::EZweb;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::IsMobile';

sub matches {
    Mail::Address::MobileJp::is_ezweb($_[1]) ? 10 : 0;
}

sub name { 'EZweb' }

sub carrier_letter { 'E' }

sub mime_encoding {
    Encode::find_encoding('MIME-Header-JP-Mobile-EZweb');
}

sub mail_encoding {
    Encode::find_encoding('x-sjis-ezweb-auto');
}

1;
__END__

=encoding utf-8

=head1 NAME

Email::Address::JP::Mobile::EZweb - Email class for Japanese carrier KDDI

=head1 METHODS

=over 4

=item name

  $carrier->name; # "EZweb"

=item carrier_letter

  $carrier->carrier_letter; # "E"

=item is_mobile

  $carrier->is_mobile; # 1

=item mime_encoding

  $carrier->mime_encoding; # 'MIME-Header-JP-Mobile-EZweb' encoding object
  $carrier->mime_encoding->encode("foo");

=item mail_encoding

  $carrier->mail_encoding; # 'x-sjis-ezweb-auto' encoding object
  $carrier->mail_encoding->encode('foo');

=back

=head1 SEE ALSO

L<Mail::Address::MobileJp>, L<Encode::JP::Mobile>, L<HTTP::MobileAgent::EZweb>,
L<http://au.kddi.com/>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
