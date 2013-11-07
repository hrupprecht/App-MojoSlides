use Mojolicious::Lite;

plugin 'App::MojoSlides::MoreTagHelpers';

any '/'  => 'index';
any '/s' => 'selector';
any '/i' => 'incremental';

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new;
$t->get_ok('/')
  ->text_is('h2' => 'Hello World')
  ->text_is('div.find #me' => 'Gotcha');

$t->get_ok('/s')
  ->text_is('#foo' => 'hi')
  ->text_is('.baz' => 'hi')
  ->text_is('.bat' => 'hi')
  ->text_is('#foo.baz.bat' => 'hi')
  ->element_exists_not('#bar');

$t->get_ok('/i')
  ->text_is('li[ms_overlay="1-"]' => 'One')
  ->text_is('li[ms_overlay="2-"]' => 'Two');

done_testing;

__DATA__

@@ index.html.ep

%= h2 'Hello World'

%= div class => 'find' => begin
  %= p id => 'me' => 'Gotcha'
% end

@@ selector.html.ep

%= div '#foo#bar.baz.bat' => 'hi'

@@ incremental.html.ep

%= incremental ul begin
  %= li 'One'
  %= li 'Two'
% end
