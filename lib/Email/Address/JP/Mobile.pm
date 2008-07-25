package Email::Address::JP::Mobile;
use strict;
use warnings;
our $VERSION = '0.01';

use Email::Address::Loose;
use Module::Pluggable(
    search_path => __PACKAGE__,
    except      => __PACKAGE__.'::Base',
    instantiate => 'new'
);

sub new {
    my $self = bless {}, shift;
    my $address = shift;
    
    if (! ref($address) || ! $address->isa('Email::Address')) {
        ($address) = Email::Address::Loose->parse($address);
    }
    
    return unless $address;
     
    my @module =
        sort { $b->matches($address) <=> $a->matches($address) }
        grep { $_->matches($address) > 0 }
        grep { $_->isa('Email::Address::JP::Mobile::Base') }
        $self->plugins;
    
    shift @module;
}

sub Email::Address::carrier {
    __PACKAGE__->new(shift->address);
}

1;
__END__

=encoding utf-8

=head1 NAME

Email::Address::JP::Mobile - Email feature differences by the carrier

=head1 SYNOPSIS

  use Email::Address::JP::Mobile;

  my $carrier = Email::Address::JP::Mobile->new('docomo.taro.@docomo.ne.jp');
  $carrier->is_mobile; # 1
  $carrier->name; # "DoCoMo"
  $carrier->carrier_letter; # "I"
  $carrier->mime_encoding->encode("\x{E63E}です"); # "=?SHIFT_JIS?B?+J+CxYK3?="
  $carrier->mail_encoding->encode("\x{E63E}です"); # "\xF8\x9F\x82\xC5\x82\xB7"
  
  # or,
  
  use Email::Address;
  use Email::Address::Loose -override;
  use Email::Address::JP::Mobile;

  my ($email) = Email::Address->parse('docomo.taro.@docomo.ne.jp');
  my $carrier = $email->carrier;

=head1 DESCRIPTION

Email::Address::JP::Mobile is 日本の携帯電話のキャリアによる違いに
対応するためのモジュールです。キャリアの判別やメール送信する際の適した
エンコーディングを返します。

=head1 METHODS

=over 4

=item new( $email )

  my $carrier = Email::Address::JP::Mobile->new('docomo.taro.@docomo.ne.jp');
  $carrier->carrier_letter; # "I"
  $carrier->mime_encoding;  # 'MIME-Header-JP-Mobile-DoCoMo' Encode::Encoding object
  $carrier->mail_encoding;  # 'x-sjis-docomo' Encode::Encoding object

$carrier のメソッドについては各クラスの POD を参照してください。
(L<http://search.cpan.org/dist/Email-Address-JP-Mobile>)
 
=item Email::Address::carrier

  my ($email) = Email::Address->parse('docomo.taro.@docomo.ne.jp');
  $email->carrier->carrier_letter; # "I"

Email::Address::JP::Mobile は Email::Address オブジェクトに
carrier というメソッドを拡張します。

ご存知のように日本の携帯は変なアドレスが許可されているので
L<Email::Address::Loose> を併用した方がいいです。

=back

=head1 SEE ALSO

L<Encode::JP::Moible>, L<Email::Address>, L<Email::Address::Loose>

L<http://coderepos.org/share/browser/lang/perl/Email-Address-JP-Mobile> (repository)

#mobilejp on irc.freenode.net (I've joined as "tomi-ru")

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
