#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

die("Usage: $0 webm-inputfile [audio-quality](default:4, higher is better(?)") unless @ARGV;

my $input = pop @ARGV;
# TODO: deal with options by way of Getopt::long
#my $aq = pop @ARGV || 4;  # audio quality;
my $aq = 4;  # audio quality;

$input =~ /(.+)\.\w+$/;
my $output;
if ($1) {
  $output = $1;
} else {
  # no dot in file name found
  $output = $input;
}
$output .= ".mp3";

say "Inside Perl";
my $exec = "ffmpeg -i '$input' -acodec libmp3lame -aq $aq '$output'";

my $ec = `$exec`;
say "errorcode:-$?-";

if ($ec) {
  say "There was an error:$ec";
  say "not removing $input";
} else {
  say "remove $input";
  unlink $input;
}

say "Done.";
