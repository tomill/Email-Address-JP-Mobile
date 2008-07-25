package Email::Address::JP::Mobile::SoftBank;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::IsMobile';

sub matches {
    Mail::Address::MobileJp::is_vodafone($_[1]) ? 10 : 0;
}

sub name { 'SoftBank' }

sub carrier_letter { 'V' }

sub mime_encoding {
    Encode::find_encoding('MIME-Header-JP-Mobile-SoftBank');
}

sub mail_encoding {
    Encode::find_encoding('x-utf8-softbank');
}

1;
__END__

=encoding utf-8

=head1 NAME

Email::Address::JP::Mobile::SoftBank - Email class for Japanese carrier SoftBank

=head1 METHODS

=over 4

=item name

  $carrier->name; # "SoftBank"

=item carrier_letter

  $carrier->carrier_letter; # "V"

=item is_mobile

  $carrier->is_mobile; # 1

=item mime_encoding

  $carrier->mime_encoding; # 'MIME-Header-JP-Mobile-SoftBank' encoding object
  $carrier->mime_encoding->encode("foo");

=item mail_encoding

  $carrier->mail_encoding; # 'x-utf8-softbank' encoding object
  $carrier->mail_encoding->encode('foo');

=back

=head1 SEE ALSO

L<Mail::Address::MobileJp>, L<Encode::JP::Mobile>, L<HTTP::MobileAgent::Vodafone>,
L<http://mb.softbank.jp/>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
