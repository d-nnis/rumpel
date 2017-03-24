#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

my $stdin = "";
while (<>) {
  $stdin.= $_;
}

my @modules = split /\s/, $stdin;

foreach my $module (@modules) {
  chdir($module);
  say "Entering $module";
  my $exec = "git push -v && git push -v gitspace master";
  my $ret = `$exec`;
  my $err = $?;
  die("Something wrong in repo $module. $ret $err") if $err;
}
