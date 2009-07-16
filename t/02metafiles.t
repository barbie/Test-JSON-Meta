#!/usr/bin/perl -w
use strict;

use Test::More  tests => 76;
use Test::JSON::Meta::Version;
use IO::File;
use JSON;

my $vers = '1.3';
my @tests = (
    { file => 't/samples/00-META.json', fail => 0, errors => 0, bad => 0, faults => 0 },
    { file => 't/samples/01-META.json', fail => 0, errors => 0, bad => 0, faults => 0 },
    { file => 't/samples/02-META.json', fail => 1, errors => 2, bad => 1, faults => 1 },
    { file => 't/samples/03-META.json', fail => 0, errors => 0, bad => 0, faults => 0 },
    { file => 't/samples/04-META.json', fail => 1, errors => 1, bad => 1, faults => 1 },
    { file => 't/samples/05-META.json', fail => 0, errors => 0, bad => 0, faults => 0 },
    { file => 't/samples/06-META.json', fail => 1, errors => 3, bad => 1, faults => 3 },
    { file => 't/samples/07-META.json', fail => 0, errors => 0, bad => 0, faults => 0 },
    { file => 't/samples/08-META.json', fail => 0, errors => 0, bad => 0, faults => 0 },
    { file => 't/samples/09-META.json', fail => 1, errors => 1, bad => 1, faults => 1 },
    { file => 't/samples/10-META.json', fail => 1, errors => 1, bad => 1, faults => 1 },
    { file => 't/samples/11-META.json', fail => 1, errors => 2, bad => 1, faults => 1 },
    { file => 't/samples/12-META.json', fail => 1, errors => 1, bad => 0, faults => 0 },
    { file => 't/samples/13-META.json', fail => 1, errors => 1, bad => 0, faults => 0 },
    { file => 't/samples/14-META.json', fail => 1, errors => 1, bad => 0, faults => 0 },
    { file => 't/samples/15-META.json', fail => 1, errors => 1, bad => 0, faults => 0 },
    { file => 't/samples/16-META.json', fail => 0, errors => 0, bad => 0, faults => 0 },
    { file => 't/samples/multibyte.json', fail => 0, errors => 0, bad => 0, faults => 0 },
    { file => 't/samples/Template-Provider-Unicode-Japanese.json', fail => 0, errors => 0, bad => 0, faults => 0 },
);

for my $test (@tests) {
    my $meta = _readdata($test->{file});

    unless($meta) {
        ok(0,"Cannot load file - $test->{file}");
        ok(0,"Cannot load file - $test->{file}");
        next;
    }

    my $spec = Test::JSON::Meta::Version->new(spec => $vers, data => $meta);

    my $result = $spec->parse();
    my @errors = $spec->errors();

    is($result,         $test->{fail},   "check result for $test->{file}");
    is(scalar(@errors), $test->{errors}, "check errors for $test->{file}");

    if(scalar(@errors) != $test->{errors}) {
        print STDERR "# failed: $test->{file}\n";
        print STDERR "# errors: $_\n"  for(@errors);
    }
}

for my $test (@tests) {
    my $meta = _readdata($test->{file});
    unless($meta) {
        ok(0,"Cannot load file - $test->{file}");
        ok(0,"Cannot load file - $test->{file}");
        next;
    }

    my $spec = Test::JSON::Meta::Version->new(data => $meta);

    my $result = $spec->parse();
    my @errors = $spec->errors();

    is($result,         $test->{bad},    "check result for $test->{file}");
    is(scalar(@errors), $test->{faults}, "check errors for $test->{file}");

    if(scalar(@errors) != $test->{faults}) {
        print STDERR "# failed: $test->{file}\n";
        print STDERR "# errors: $_\n"  for(@errors);
    }
}

sub _readdata {
    my $file = shift;
    my $data;
    my $fh = IO::File->new($file,'r') or die "Cannot open file [$file]: $!";
    while(<$fh>) { $data .= $_ }
    $fh->close;
    return decode_json($data);
}

