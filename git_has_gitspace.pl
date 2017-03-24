#!/usr/bin/env perl

use warnings;
use strict;
use feature qw(say);
use FindBin;
use lib "$FindBin::Bin";
use Essent_v2;

#my $paramstring = $ARGV[0];

my $stdin = "";
while (<>) {
  $stdin.= $_;
}

my @modules = split /\s/, $stdin;

my @has;
foreach my $module (@modules) {
  push @has, has_gitspace($module);
}

print "@has";

sub has_gitspace {
  my $module_dir = shift;
  chdir($module_dir);
  my $exec = "git remote show";
  my @remotes = `$exec`;
  @remotes = map {Data::remove_outerspace($_)} @remotes;
  my $has_gitspace = 0;
  foreach my $remote (@remotes) {
    $has_gitspace = 1 if $remote eq "gitspace";
  }
  if ($has_gitspace) {
    return $module_dir;
  } else {
    return;
  }
}


