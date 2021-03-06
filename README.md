# NAME

Email::Address::JP::Mobile - Japanese carrier email class

# SYNOPSIS

    use Email::Address::JP::Mobile;
    
    my $carrier = Email::Address::JP::Mobile->new('docomo.taro.@docomo.ne.jp');
    $carrier->is_mobile;      # => true
    $carrier->name;           # => "DoCoMo"
    $carrier->carrier_letter; # => "I"
    
    $body    = $carrier->send_encoding->encode($body);
    $subject = $carrier->mime_encoding->encode($subject);

or, via Email::Address object

    use Email::Address;
    use Email::Address::Loose -override;
    use Email::Address::JP::Mobile;
    
    my ($email) = Email::Address->parse('docomo.taro.@docomo.ne.jp');
    my $carrier = $email->carrier;
    $carrier->is_mobile; # => true

# DESCRIPTION

Email::Address::JP::Mobile is for Japanese web developers.

このモジュールは要するに [HTTP::MobileAgent](https://metacpan.org/pod/HTTP%3A%3AMobileAgent) のメール版です。
メールアドレスから、それがどのキャリアで発行されたメールアドレスかを判別します。

同様のことができるモジュールに [Mail::Address::MobileJp](https://metacpan.org/pod/Mail%3A%3AAddress%3A%3AMobileJp) があります。
Email::Address::JP::Mobile は [Email::Address](https://metacpan.org/pod/Email%3A%3AAddress) オブジェクトを拡張する点や、
`is_mobile($email)` ではなく `$carrier->is_mobile()` というインターフェースである点が違います。

# USAGE

- $carrier = Email::Address::JP::Mobile->new( $address )

    メールアドレスから、Email::Address::JP::Mobile::\* の対応したクラスを返します。

        my $carrier = Email::Address::JP::Mobile->new('docomo.taro.@docomo.ne.jp');
        # $carrier is a Email::Address::JP::Mobile::DoCoMo
        $carrier->is_mobile;      # => true
        $carrier->name;           # => "DoCoMo"
        $carrier->carrier_letter; # => "I"

    携帯のメールアドレスではないと判断した場合は Email::Address::JP::Mobile::NonMobile クラスを返します。

- $carrier = $email->carrier()

    Email::Address::JP::Mobile は [Email::Address](https://metacpan.org/pod/Email%3A%3AAddress) オブジェクトに、対応したクラスを返す
    `carrier()` というメソッドを拡張します。

        use Email::Address;
        use Email::Address::Loose -override;
        use Email::Address::JP::Mobile;
        my ($email) = Email::Address->parse('docomo.taro@docomo.ne.jp');
        $email->carrier->carrier_letter; # "I"

    ご存知のように日本の携帯は変なアドレスが許可されている期間が長かったので、
    携帯アドレスをパースする可能性があるのであれば [Email::Address::Loose](https://metacpan.org/pod/Email%3A%3AAddress%3A%3ALoose) を
    併用した方がよいです。

# CARRIER CLASS METHODS

- $carrier->is\_mobile()
- $carrier->name()
- $carrier->carrier\_letter()

    各メソッドが返す値は以下のとおりです。

                   is_mobile  name         carrier_letter
        -------------------------------------------------
        DoCoMo     true       "DoCoMo"     "I"
        au         true       "EZweb"      "E"
        SoftBank   true       "SoftBank"   "V"
        WILLCOM    true       "AirH"       "H"
        NonMobile  false      "NonMobile"  "N"

    `carrier_letter()` が返す値は [HTTP::MobileAgent](https://metacpan.org/pod/HTTP%3A%3AMobileAgent) の `carrier()` が返す値と同じです。ただし、このモジュールが返す `name()` の値は [HTTP::MobileAgent](https://metacpan.org/pod/HTTP%3A%3AMobileAgent) の `carrier_longname()` が返す値とは少し異なりますので注意してください。

- $carrier->mime\_encoding()

        $subject = $carrier->mime_encoding->encode($subject);
        $subject = $carrier->mime_encoding->decode($subject);

    そのキャリア向けにメールを送信する際、絵文字を含んだ Subject を MIME encode するためのエンコーディングを返します。何を返すかは ["ENCODINGS"](#encodings) を参照してください。

    携帯の場合は、そのキャリアの端末から受信したメールの Subject を MIME decode するためにも利用できます。ただし DoCoMo や SoftBank からの場合絵文字は最初からゲタになっているため取れないでしょう。

    NonMobile の場合には `MIME-Header-ISO_2022_JP` エンコーディングを返しますが、これは現状 decode に対応していません。代わりに `MIME-Header` というエンコーディングで decode する必要があるので注意してください。

- $carrier->send\_encoding()

        $body = $carrier->send_encoding->encode($body);

    そのキャリア向けにメールを送信する際、絵文字を含んだメール本文を encode するためのエンコーディングを返します。何を返すかは ["ENCODINGS"](#encodings) を参照してください。

- $carrier->parse\_encoding()

        $body = $carrier->parse_encoding->decode($body);

    そのキャリアから受信したメールの絵文字を含んだメール本文を decode するためのエンコーディングを返します。が、これはメール本文の `Content-Type` をチェックしているわけではなく、そのキャリアの場合このエンコーディングで送ってくるだろうというものを返しているだけである点に留意してください。また、DoCoMo や SoftBank からの場合絵文字は最初からゲタになり取れないため、`iso-2022-jp` を返します。

    そのため、受信の場合は絵文字のことは忘れて [Email::MIME](https://metacpan.org/pod/Email%3A%3AMIME) の `header()` や `body_str()` を使って decode すると良いでしょう。

## ENCODINGS

上記の各メソッドが返すエンコーディングは以下のとおりです。（返すのは文字列ではなく [Encode::Encoding](https://metacpan.org/pod/Encode%3A%3AEncoding) です）

               mime_encoding                   send_encoding     parse_encoding
    ------------------------------------------------------------------------------------
    DoCoMo     MIME-Header-JP-Mobile-DoCoMo    x-sjis-docomo     iso-2022-jp
    au         MIME-Header-JP-Mobile-KDDI      x-sjis-kddi-auto  x-iso-2022-jp-kddi-auto
    SoftBank   MIME-Header-JP-Mobile-SoftBank  x-utf8-softbank   iso-2022-jp
    WILLCOM    MIME-Header-JP-Mobile-AirH      x-sjis-airh       x-iso-2022-jp-airh
    NonMobile  MIME-Header-ISO_2022_JP         iso-2022-jp       iso-2022-jp

MIME-Header-JP-Mobile-\* や x-\* のエンコーディングは [Encode::JP::Mobile](https://metacpan.org/pod/Encode%3A%3AJP%3A%3AMobile) が提供するエンコーディングです。

- $Email::Address::JP::Mobile::NonMobile::Encoding

        local $Email::Address::JP::Mobile::NonMobile::Encoding = 'utf-8';

        my $carrier = Email::Address::JP::Mobile->new('tomita@example.com');
        $carrier->mime_encoding;  # MIME-Header encoding
        $carrier->send_encoding;  # utf-8 encoding
        $carrier->parse_encoding; # utf-8 encoding

    NonMobile の場合のデフォルトエンコーディングは `iso-2022-jp` ですが、この変数で `utf-8` を指定すると上記のようなエンコーディングを返します。

# SEE ALSO

[http://coderepos.org/share/wiki/Mobile/Encoding](http://coderepos.org/share/wiki/Mobile/Encoding)

[Email::Address::Loose](https://metacpan.org/pod/Email%3A%3AAddress%3A%3ALoose), [Encode::JP::Mobile](https://metacpan.org/pod/Encode%3A%3AJP%3A%3AMobile)

[Email::MIME::MobileJP](https://metacpan.org/pod/Email%3A%3AMIME%3A%3AMobileJP) - 具体的な利用例

\#mobilejp on irc.freenode.net (I've joined as "tomi-ru")

# AUTHOR

Naoki Tomita <tomita@cpan.org>

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
