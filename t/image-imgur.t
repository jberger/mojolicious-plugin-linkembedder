use t::App;
use Test::More;

plan skip_all => 'GOT_INTERNET=1 need to be set' unless $ENV{GOT_INTERNET};

$t->get_ok('/embed?url=http://imgur.com/2lXFJK0')->status_is(200);
my $dom = $t->tx->res->dom->at('img');
is $dom->{src}, 'http://i.imgur.com/2lXFJK0.png', 'correct src';
like $dom->{alt}, qr/\QYay Mojo!/, 'correct title';

$t->get_ok('/embed.json?url=http://imgur.com/2lXFJK0')
  ->json_is('/media_id', '2lXFJK0')
  ;

done_testing;
