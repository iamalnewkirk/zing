package Zing::Process;

use 5.014;

use strict;
use warnings;

use registry 'Zing::Types';
use routines;

use Data::Object::Class;
use Data::Object::ClassHas;

use FlightRecorder;
use POSIX;

use Zing::Channel;
use Zing::Data;
use Zing::Fork;
use Zing::Logic;
use Zing::Loop;
use Zing::Mailbox;
use Zing::Node;
use Zing::Registry;
use Zing::Term;

# VERSION

# ATTRIBUTES

has 'cleanup' => (
  is => 'ro',
  isa => 'Bool',
  def => 1,
);

has 'data' => (
  is => 'ro',
  isa => 'Data',
  new => 1,
);

fun new_data($self) {
  Zing::Data->new(process => $self)
}

has 'journal' => (
  is => 'ro',
  isa => 'Channel',
  new => 1,
);

fun new_journal($self) {
  Zing::Channel->new(name => '$journal')
}

has 'log' => (
  is => 'ro',
  isa => 'Logger',
  new => 1,
);

fun new_log($self) {
  FlightRecorder->new(auto => undef, level => 'info')
}

has 'logic' => (
  is => 'ro',
  isa => 'Logic',
  new => 1,
);

fun new_logic($self) {
  Zing::Logic->new(process => $self);
}

has 'loop' => (
  is => 'ro',
  isa => 'Loop',
  new => 1,
);

fun new_loop($self) {
  Zing::Loop->new(flow => $self->logic->flow)
}

has 'mailbox' => (
  is => 'ro',
  isa => 'Mailbox',
  new => 1,
);

fun new_mailbox($self) {
  Zing::Mailbox->new(process => $self)
}

has 'name' => (
  is => 'ro',
  isa => 'Str',
  new => 1,
);

fun new_name($self) {
  $self->node->identifier
}

has 'node' => (
  is => 'ro',
  isa => 'Node',
  new => 1,
);

fun new_node($self) {
  Zing::Node->new
}

has 'parent' => (
  is => 'ro',
  isa => 'Maybe[Process]',
  opt => 1,
);

has 'registry' => (
  is => 'ro',
  isa => 'Registry',
  new => 1,
);

fun new_registry($self) {
  Zing::Registry->new
}

has 'server' => (
  is => 'ro',
  isa => 'Server',
  new => 1,
);

fun new_server($self) {
  Zing::Server->new
}

has 'signals' => (
  is => 'ro',
  isa => 'Map[Interupt, Str|CodeRef]',
  new => 1,
);

fun new_signals($self) {
  $self->logic->signals
}

has 'started' => (
  is => 'rw',
  isa => 'Int',
  def => 0,
);

has 'stopped' => (
  is => 'rw',
  isa => 'Int',
  def => 0,
);

has 'tag' => (
  is => 'rw',
  isa => 'Str',
  opt => 1,
);

# SHIMS

sub _kill {
  CORE::kill(shift, shift)
}

# METHODS

method defer(HashRef $data) {
  $self->mailbox->send($self->mailbox->term, $data);

  return $self;
}

method destroy() {
  return $self if !$self->cleanup;

  $self->data->drop;
  $self->mailbox->drop;
  $self->registry->drop($self);

  return $self;
}

method exercise() {
  $self->started(time);

  my $signals = $self->signals;

  local $SIG{CHLD} = $signals->{CHLD} if $signals->{CHLD};
  local $SIG{HUP}  = $signals->{HUP}  if $signals->{HUP};
  local $SIG{INT}  = $signals->{INT}  if $signals->{INT};
  local $SIG{QUIT} = $signals->{QUIT} if $signals->{QUIT};
  local $SIG{TERM} = $signals->{TERM} if $signals->{TERM};
  local $SIG{USR1} = $signals->{USR1} if $signals->{USR1};
  local $SIG{USR2} = $signals->{USR2} if $signals->{USR2};

  $self->loop->exercise($self);

  $self->destroy;

  $self->stopped(time);

  return $self;
}

method execute() {
  $self->started(time);

  my $signals = $self->signals;

  local $SIG{CHLD} = $signals->{CHLD} if $signals->{CHLD};
  local $SIG{HUP}  = $signals->{HUP}  if $signals->{HUP};
  local $SIG{INT}  = $signals->{INT}  if $signals->{INT};
  local $SIG{QUIT} = $signals->{QUIT} if $signals->{QUIT};
  local $SIG{TERM} = $signals->{TERM} if $signals->{TERM};
  local $SIG{USR1} = $signals->{USR1} if $signals->{USR1};
  local $SIG{USR2} = $signals->{USR2} if $signals->{USR2};

  $self->loop->execute($self);

  $self->destroy;

  $self->stopped(time);

  return $self;
}

method metadata() {
  {
    name => $self->name,
    data => $self->data->term,
    mailbox => $self->mailbox->term,
    node => $self->node->name,
    parent => ($self->parent ? $self->parent->node->pid : undef),
    process => $self->node->pid,
    server => $self->server->name,
    tag => $self->tag,
  }
}

method ping(Int $pid) {
  return _kill 0, $pid;
}

method shutdown() {
  $self->loop->stop(1);

  return $self;
}

method signal(Int $pid, Str $type = 'kill') {
  return _kill uc($type), $pid;
}

method spawn(Scheme $scheme) {
  my $size = $scheme->[2];
  my $fork = Zing::Fork->new(parent => $self, scheme => $scheme);

  $SIG{CHLD} = 'IGNORE';

  $fork->execute for 1..($size || 1);

  return $fork;
}

method term() {
  return Zing::Term->new($self)->process;
}

method winddown() {
  $self->loop->last(1);

  return $self;
}

1;
