package Zing::Store;

use 5.014;

use strict;
use warnings;

use registry 'Zing::Types';
use routines;

use Data::Object::Class;
use Data::Object::ClassHas;

use Carp ();

# VERSION

# ATTRIBUTES

has 'encoder' => (
  is => 'ro',
  isa => 'Encoder',
  new => 1,
);

fun new_encoder($self) {
  require Zing::Encoder; Zing::Encoder->new;
}

# METHODS

sub args {
  map +($$_[0], $#{$$_[1]} ? $$_[1] : $$_[1][0]),
  map [$$_[0], [split /\|/, $$_[1]]],
  map [split /=/], split /,\s*/,
  $_[1] || ''
}

sub drop {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "drop" not implemented);
}

sub encode {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "encode" not implemented);
}

sub keys {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "keys" not implemented);
}

sub decode {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "decode" not implemented);
}

sub lpull {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "lpull" not implemented);
}

sub lpush {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "lpush" not implemented);
}

sub recv {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "recv" not implemented);
}

sub rpull {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "rpull" not implemented);
}

sub rpush {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "rpush" not implemented);
}

sub send {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "send" not implemented);
}

sub size {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "size" not implemented);
}

sub slot {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "slot" not implemented);
}

sub term {
  shift; return join(':', @_);
}

sub test {
  Carp::croak qq(Error in Store: (@{[ref$_[0]]}) method "test" not implemented);
}

1;
