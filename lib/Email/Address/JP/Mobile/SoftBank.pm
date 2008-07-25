package Email::Address::JP::Mobile::SoftBank;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::Base';

my $regex = qr/^(?:
jp\-[dhtckrnsq]\.ne\.jp|
[dhtckrnsq]\.vodafone\.ne\.jp|
softbank\.ne\.jp|
disney.ne.jp
)$/x;

sub matches {
    $_[1]->host =~ $regex  ? 10 : 0;
}

sub name { 'SoftBank' }

sub carrier_letter { 'V' }

sub is_mobile { 1 }

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

L<http://mb.softbank.jp/mb/service/3G/mail/s_mail/>, L<http://disneymobile.jp/mail/>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
