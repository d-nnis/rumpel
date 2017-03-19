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
my $output = $1;
$output .= ".mp3";

say "Inside Perl";
my $exec = "ffmpeg -i '$input' -acodec libmp3lame -aq $aq '$output'";
say $exec;

my $el = `$exec`;

say "Done.";
