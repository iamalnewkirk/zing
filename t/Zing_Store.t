use 5.014;

use strict;
use warnings;
use routines;

use lib 't/app';
use lib 't/lib';

use Test::Auto;
use Test::More;
use Test::Zing;

=name

Zing::Store

=cut

=tagline

Storage Interface

=cut

=abstract

Data Storage Interface

=cut

=includes

method: args
method: drop
method: dump
method: keys
method: pop
method: pull
method: push
method: load
method: recv
method: send
method: size
method: slot
method: term
method: test

=cut

=synopsis

  use Zing::Store;

  my $store = Zing::Store->new;

  # $store->drop;

=cut

=libraries

Zing::Types

=cut

=description

This package provides a data persistence interface to be implemented by data
storage abstractions.

=cut

=method args

The args method parses strings with key/value data (typically from an
environment variable) meant to be used in object construction.

=signature args

args(Str $env) : (Any)

=example-1 args

  # given: synopsis

  [$store->args('port=0001,debug=0')]

=example-2 args

  # given: synopsis

  [$store->args('ports=0001|0002,debug=0')]

=cut

=method drop

The drop method should remove items from the datastore by key.

=signature drop

drop(Str $key) : Int

=example-1 drop

  # given: synopsis

  $store->drop('model');

=cut

=method dump

The dump method should encode and return the data provided in a format suitable
for the underlying storage mechanism.

=signature dump

dump(HashRef $data) : Str

=example-1 dump

  # given: synopsis

  $store->dump({ status => 'ok' });

=cut

=method keys

The keys method should return a list of keys under the namespace provided
including itself.

=signature keys

keys(Str @keys) : ArrayRef[Str]

=example-1 keys

  # given: synopsis

  my $keys = $store->keys('nodel');

=example-2 keys

  # given: synopsis

  # $store->send('model', { status => 'ok' });

  my $keys = $store->keys('model');

=cut

=method pop

The pop method should pop data off of the bottom of a list in the datastore.

=signature pop

pop(Str $key) : Maybe[HashRef]

=example-1 pop

  # given: synopsis

  $store->pop('collection');

=example-2 pop

  # given: synopsis

  # $store->push('collection', { status => 1 });
  # $store->push('collection', { status => 2 });

  $store->pop('collection');

=cut

=method pull

The pull method should pop data off of the top of a list in the datastore.

=signature pull

pull(Str $key) : Maybe[HashRef]

=example-1 pull

  # given: synopsis

  $store->pull('collection');

=example-2 pull

  # given: synopsis

  # $store->push('collection', { status => 'ok' });

  $store->pull('collection');

=cut

=method push

The push method should push data onto the bottom of a list in the datastore.

=signature push

push(Str $key, HashRef $val) : Int

=example-1 push

  # given: synopsis

  $store->push('collection', { status => 'ok' });

=cut

=method load

The load method should decode the data provided and returns the data as a
hashref.

=signature load

load(Str $data) : HashRef

=example-1 load

  # given: synopsis

  $store->load('{"status":"ok"}');

=cut

=method recv

The recv method should fetch and return data from the datastore by its key.

=signature recv

recv(Str $key) : Maybe[HashRef]

=example-1 recv

  # given: synopsis

  $store->recv('model');

=example-2 recv

  # given: synopsis

  # $store->send('model', { status => 'ok' });

  $store->recv('model');

=cut

=method send

The send method should commit data to the datastore with its key and return
truthy (or falsy if not).

=signature send

send(Str $key, HashRef $val) : Str

=example-1 send

  # given: synopsis

  $store->send('model', { status => 'ok' });

=cut

=method size

The size method should return the size of a list in the datastore.

=signature size

size(Str $key) : Int

=example-1 size

  # given: synopsis

  my $size = $store->size('collection');

=example-2 size

  # given: synopsis

  # $store->push('collection', { status => 'ok' });

  my $size = $store->size('collection');

=cut

=method slot

The slot method should return the data from a list in the datastore by its
position in the list.

=signature slot

slot(Str $key, Int $pos) : Maybe[HashRef]

=example-1 slot

  # given: synopsis

  my $model = $store->slot('collection', 0);

=example-2 slot

  # given: synopsis

  # $store->push('collection', { status => 'ok' });

  my $model = $store->slot('collection', 0);

=cut

=method term

The term method generates a term (safe string) for the datastore. This method
doesn't need to be implemented.

=signature term

term(Str @keys) : Str

=example-1 term

  # given: synopsis

  $store->term('model');

=cut

=method test

The test method should return truthy if the specific key exists in the
datastore.

=signature test

test(Str $key) : Int

=example-1 test

  # given: synopsis

  # $store->push('collection', { status => 'ok' });

  $store->test('collection');

=example-2 test

  # given: synopsis

  # $store->drop('collection');

  $store->test('collection');

=cut

package main;

my $test = testauto(__FILE__);

my $subs = $test->standard;

$subs->synopsis(fun($tryable) {
  ok my $result = $tryable->result;

  $result
});

$subs->example(-1, 'args', 'method', fun($tryable) {
  ok my $result = $tryable->result;
  is_deeply $result, ['port', '0001', 'debug', 0];

  (@$result)
});

$subs->example(-2, 'args', 'method', fun($tryable) {
  ok my $result = $tryable->result;
  is_deeply $result, ['ports', ['0001', '0002'], 'debug', 0];

  (@$result)
});

$subs->example(-1, 'drop', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"drop" not implemented/;
  });
  ok my $result = $tryable->result;

  1
});

$subs->example(-1, 'dump', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"dump" not implemented/;
  });
  ok my $result = $tryable->result;

  ''
});

$subs->example(-1, 'keys', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"keys" not implemented/;
  });
  ok my $result = $tryable->result;

  []
});

$subs->example(-2, 'keys', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"keys" not implemented/;
  });
  ok my $result = $tryable->result;

  []
});

$subs->example(-1, 'pop', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"pop" not implemented/;
  });
  ok my $result = $tryable->result;

  {}
});

$subs->example(-2, 'pop', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"pop" not implemented/;
  });
  ok my $result = $tryable->result;

  {}
});

$subs->example(-1, 'pull', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"pull" not implemented/;
  });
  ok my $result = $tryable->result;

  {}
});

$subs->example(-2, 'pull', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"pull" not implemented/;
  });
  ok my $result = $tryable->result;

  {}
});

$subs->example(-1, 'push', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"push" not implemented/;
  });
  ok my $result = $tryable->result;

  1
});

$subs->example(-1, 'load', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"load" not implemented/;
  });
  ok my $result = $tryable->result;

  {}
});

$subs->example(-1, 'recv', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"recv" not implemented/;
  });
  ok my $result = $tryable->result;

  {}
});

$subs->example(-2, 'recv', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"recv" not implemented/;
  });
  ok my $result = $tryable->result;

  {}
});

$subs->example(-1, 'send', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"send" not implemented/;
  });
  ok my $result = $tryable->result;

  ''
});

$subs->example(-1, 'size', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"size" not implemented/;
  });
  ok my $result = $tryable->result;

  1
});

$subs->example(-2, 'size', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"size" not implemented/;
  });
  ok my $result = $tryable->result;

  1
});

$subs->example(-1, 'slot', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"slot" not implemented/;
  });
  ok my $result = $tryable->result;

  {}
});

$subs->example(-2, 'slot', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"slot" not implemented/;
  });
  ok my $result = $tryable->result;

  {}
});

$subs->example(-1, 'term', 'method', fun($tryable) {
  ok my $result = $tryable->result;
  like $result, qr/^model$/;

  $result
});

$subs->example(-1, 'test', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"test" not implemented/;
  });
  ok my $result = $tryable->result;

  1
});

$subs->example(-2, 'test', 'method', fun($tryable) {
  $tryable->default(fun ($error) {
    like $error, qr/"test" not implemented/;
  });
  ok my $result = $tryable->result;

  1
});

ok 1 and done_testing;
