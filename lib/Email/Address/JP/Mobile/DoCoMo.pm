package Email::Address::JP::Mobile::DoCoMo;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::Base';

my $regex = qr/^(?:
docomo\.ne\.jp
)$/x;

sub matches {
    $_[1]->host =~ $regex  ? 10 : 0;
}

sub name { 'DoCoMo' }

sub carrier_letter { 'I' }

sub is_mobile { 1 }

sub mime_encoding {
    Encode::find_encoding('MIME-Header-JP-Mobile-DoCoMo');
}

sub mail_encoding {
    Encode::find_encoding('x-sjis-docomo');
}

1;
__END__

=encoding utf-8

=head1 NAME

Email::Address::JP::Mobile::DoCoMo - Email class for Japanese carrier DoCoMo

=head1 METHODS

=over 4

=item name

  $carrier->name; # "DoCoMo"

=item carrier_letter

  $carrier->carrier_letter; # "I"

=item is_mobile

  $carrier->is_mobile; # 1

=item mime_encoding

  $carrier->mime_encoding; # 'MIME-Header-JP-Mobile-DoCoMo' encoding object
  $carrier->mime_encoding->encode("foo");

=item mail_encoding

  $carrier->mail_encoding; # 'x-sjis-docomo' encoding object
  $carrier->mail_encoding->encode('foo');

=back

=head1 SEE ALSO

L<Mail::Address::MobileJp>, L<Encode::JP::Mobile>, L<HTTP::MobileAgent::DoCoMo>,
L<http://www.nttdocomo.co.jp/>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
