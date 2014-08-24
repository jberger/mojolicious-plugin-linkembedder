use t::App;
use Test::More;

plan skip_all => 'GOT_INTERNET=1 need to be set' unless $ENV{GOT_INTERNET};

$t->get_ok('/embed?url=http://cheezburger.com/8294012928')->status_is(200);
my $dom = $t->tx->res->dom->at('img');
is $dom->{src}, 'https://i.chzbgr.com/original/8294012928/CC304B14/1', 'correct src';
is $dom->{alt}, q(You're Asking for it!), 'correct title';

done_testing;
