# NAME

Zing - Multi-Process Management System

# ABSTRACT

Actor Toolkit and Multi-Process Management System

# SYNOPSIS

    use Zing;

    my $zing = Zing->new(scheme => ['MyApp', [], 1]);

    # $zing->execute;

# DESCRIPTION

This distribution includes an actor-model architecture toolkit and
Redis-powered multi-process management system which provides primatives for
building powerful, reactive, concurrent, distributed, and resilient
message-driven applications in Perl 5. If you're unfamiliar with this
architectural pattern, learn more about ["the actor
model"](https://en.wikipedia.org/wiki/Actor_model).

# INHERITS

This package inherits behaviors from:

[Zing::Watcher](https://metacpan.org/pod/Zing%3A%3AWatcher)

# LIBRARIES

This package uses type constraints from:

[Zing::Types](https://metacpan.org/pod/Zing%3A%3ATypes)

# ATTRIBUTES

This package has the following attributes:

## scheme

    scheme(Scheme)

This attribute is read-only, accepts `(Scheme)` values, and is required.

# METHODS

This package implements the following methods:

## start

    start() : Kernel

The start method builds a [Zing::Kernel](https://metacpan.org/pod/Zing%3A%3AKernel) and executes its event-loop.

- start example #1

        # given: synopsis

        $zing->start;

# FEATURES

While this is, at present, a proof-of-concept, the API is not expected to
change. The documentation is a work-in-progress. Please see the examples
included for demonstrations of the objects in action. The following is a list
of features currently supported by the framework:

- parallel processing
- asynchronous programming
- event-driven applications
- actor-model based framework
- process (actor) mailboxes
- distributed processes (actors)
- erlang-style supervision trees
- hot-reloadable processes (actors)
- automated multi-process management
- atomicity without lock management
- multitasking processes (event-loop actors)
- chainable/extendable process (actor) event-loops
- none-blocking yieldable routines
- high performance message queues
- high performance message channels
- high performance message passing
- built-in high performance log shipping
- operable as a cluster or single-node
- resilient to memory leaks
- no new funcs/idioms
- no callbacks, futures or promises
- no zombie processes

# SEE ALSO

[The Actor Model](https://en.wikipedia.org/wiki/Actor_model)

[Concurrent Computation](https://www.amazon.com/Actors-Concurrent-Computation-Distributed-Systems/dp/026251141X)

[Concurrency in Go/Erlang](https://www.youtube.com/watch?v=2yiKUIDFc2I)

[The Akka Project](https://github.com/akka/akka)

[The Actorkit Project](https://github.com/influx6/actorkit)

[The Orleans Project](http://dotnet.github.io/orleans)

[The Pyakka Project](https://github.com/jodal/pykka)

[The Reactive Manifesto](http://www.reactivemanifesto.org)

# AUTHOR

Al Newkirk, `awncorp@cpan.org`

# LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the ["license
file"](https://github.com/iamalnewkirk/zing/blob/master/LICENSE).

# PROJECT

[Wiki](https://github.com/iamalnewkirk/zing/wiki)

[Project](https://github.com/iamalnewkirk/zing)

[Initiatives](https://github.com/iamalnewkirk/zing/projects)

[Milestones](https://github.com/iamalnewkirk/zing/milestones)

[Contributing](https://github.com/iamalnewkirk/zing/blob/master/CONTRIBUTE.md)

[Issues](https://github.com/iamalnewkirk/zing/issues)
