package Email::Address::JP::Mobile::NonMobile;
use strict;
use warnings;
use base 'Email::Address::JP::Mobile::Base';

sub matches {
    $_[1] =~ /.+\@.+/ ? 1 : 0;
}

sub name { 'NonMobile' }

sub carrier_letter { 'N' }

sub is_mobile { 0 }

our $Encoding = 'utf-8';

sub mime_encoding {
    Encode::find_encoding(
        $Encoding =~ /iso-2022-jp/i ? 'MIME-Header-ISO_2022_JP' : 'MIME-Header'
    );
}

sub mail_encoding {
    Encode::find_encoding($Encoding);
}

1;
__END__

=encoding utf-8

=head1 NAME

Email::Address::JP::Mobile::NonMobile - NonMobile email class

=head1 METHODS

=over 4

=item name

  $carrier->name; # "NonMobile"

=item name

  $carrier->carrire_letter; # "N"

=item mime_encoding

  $carrier->mime_encoding; # 'MIME-Header' encoding object
  $carrier->mime_encoding->encode("foo");

If C<$Email::Address::JP::Mobile::NonMobile::Encoding = 'iso-2022-jp';>,
return C<MIME-Header-ISO_2022_JP> encoding object.

=item mail_encoding

  $carrier->mail_encoding; # $Email::Address::JP::Mobile::NonMobile::Encoding encoding object
  $carrier->mail_encoding->encode('foo');

=item is_mobile

  $carrier->is_mobile; # 0

=back

=head1 SEE ALSO

L<Encode>, L<HTTP::MobileAgent::NonMobile>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
