#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use Data::Dumper;


my ,Ry;

die("WIP");

my @remotes = split ' ', `git remote`;

say "remotes @remotes";
say "dump remotes ". Dumper(@remotes);


