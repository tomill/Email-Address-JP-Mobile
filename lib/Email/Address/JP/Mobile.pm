package Email::Address::JP::Mobile;
use strict;
use warnings;
use 5.008000;
our $VERSION = '0.02';
use Email::Address::Loose;

sub _carriers { qw(
    DoCoMo
    EZweb
    AirH
    SoftBank
    NonMobile
) }

BEGIN {
    for (_carriers) {
        eval "use Email::Address::JP::Mobile::$_;";
        die $@ if $@;
    }
};

sub new {
    my ($class, $address) = @_;
    my ($email) = Email::Address::Loose->parse($address);
    return unless $email;
     
    my ($carrier) =
        grep { $_->matches($email) }
            map { "Email::Address::JP::Mobile::$_" }
                _carriers;

    $carrier->new;
}

sub Email::Address::carrier {
    __PACKAGE__->new(shift->address);
}

1;
__END__

=encoding utf-8

=head1 NAME

Email::Address::JP::Mobile - Japanese carrier email class

=head1 SYNOPSIS
  
  use Email::Address::JP::Mobile;

  my $carrier = Email::Address::JP::Mobile->new('docomo.taro.@docomo.ne.jp');
  $carrier->is_mobile; # => true
  $carrier->name; # => "DoCoMo"
  $carrier->carrier_letter; # => "I"

or

  use Email::Address::Loose;
  use Email::Address::JP::Mobile;
  
  my ($email) = Email::Address::Loose->parse('docomo.taro.@docomo.ne.jp');
  $email->carrier->is_mobile; # => true

=head1 DESCRIPTION

Email::Address::JP::Mobile is a module for Japanese web developers.

このモジュールは要するに L<HTTP::MobileAgent> のメール版です。

同様のことができるモジュールに L<Mail::Address::MobileJp> があります。
Email::Address::JP::Mobile は L<Email::Address> オブジェクトを拡張する点や
C<is_mobile($email)> ではなく C<< $email->carrier->is_mobile >> という
インターフェースである点が違います。

=head1 METHODS

=over 4

=item $carrier = Email::Address::JP::Mobile->new( $email )

メールアドレスから、対応したクラスを返します。

  my $carrier = Email::Address::JP::Mobile->new('docomo.taro.@docomo.ne.jp');
  # $carrier is a Email::Address::JP::Mobile::DoCoMo
  $carrier->is_mobile; # => true
  $carrier->name; # => "DoCoMo"
  $carrier->carrier_letter; # => "I"

携帯メアドではない場合は Email::Address::JP::Mobile::NonMobile クラスを返します。

=item $carrier = $email->carrier()

  my ($email) = Email::Address->parse('docomo.taro@docomo.ne.jp');
  $email->carrier->carrier_letter; # "I"

Email::Address::JP::Mobile は L<Email::Address> オブジェクトに C<carrier()>
というメソッドを拡張します。

ご存知のように日本の携帯は変なアドレスが許可されている期間が長かったので、
携帯アドレスをパースする可能性があるのであれば L<Email::Address::Loose> を
利用もしくは併用した方がよいです。

=back

=head1 EMAIL CLASS METHODS

=over 4

=item $carrier->is_mobile

=item $carrier->name

=item $carrier->carrier_letter

各メソッドが返す値は以下のとおりです。

             is_mobile  name         carrier_letter
  -------------------------------------------------
  DoCoMo     true       "DoCoMo"     "I"
  au         true       "EZweb"      "E"
  SoftBank   true       "SoftBank"   "V"
  WILLCOM    true       "AirH"       "H"
  NonMobile  false      "NonMobile"  "N"

=back

=head1 ROADMAP

メールの解析、送信時用のエンコーディングを返すメソッドを追加予定。

=head1 SEE ALSO

L<Email::Address::Loose>, L<Mail::Address::MobileJp>

#mobilejp on irc.freenode.net (I've joined as "tomi-ru")

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
