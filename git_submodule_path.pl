#!/usr/bin/env perl

use warnings;
use strict;
use FindBin;
use lib "$FindBin::Bin";
#push @INC, $FindBin::Bin
use Essent_v2;
use feature qw(say);
use Cwd qw(abs_path cwd);
use File::Basename;
use Data::Dumper;


my $abspath = abs_path(cwd());
my $startdir = $ARGV[0] || $abspath;

## TODO: make faster

my %finallist;
die("$startdir does not exist. $!") unless -d $startdir;
my $exec = "git remote";
`$exec`;
die("$startdir is not a git repo (no .git as subdir) $!") if $? || ! -d "$startdir/.git";
$finallist{$startdir} = 1;

recurse($startdir);

sub recurse {
  my @queue = @_;
  my @gitstatuslist = ();

  while (@queue) {
    my $path = shift @queue;
    @gitstatuslist = (gitstatuslist($path));
    my $abspath = abs_path(cwd());
    if (@gitstatuslist) {
      # _git submodule status_ always returns relative paths
      my @paths = sm_paths(@gitstatuslist);
      # convert into absolute paths
      @paths = map {$abspath ."/". $_} @paths;
      foreach (@paths) {
        $finallist{$_} = 1;
      }
      recurse(@paths);
    } else {
      $finallist{$path} = 1;
    }
  }
}

my @finallist;
foreach my $path (keys %finallist) {
  push @finallist, $path;
}

print "@finallist";
## END

sub gitstatuslist {
  my $dir = shift;
  chdir($dir);
  my $exec = "git submodule status";
  my @statuslist = `$exec`;
  @statuslist = map {Data::remove_outerspace($_)} @statuslist;
  return @statuslist;
}

sub sm_paths {
  my @gitstatus = @_;
  my @sm_paths;
  foreach my $sm (@gitstatus) {
    my $path = (split(/\s/, $sm))[1];
    push @sm_paths, $path;
  }
  return @sm_paths;
}

