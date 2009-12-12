package Test::JSON::Meta;

use warnings;
use strict;

use vars qw($VERSION);
$VERSION = '0.03';

#----------------------------------------------------------------------------

=head1 NAME

Test::JSON::Meta - Validation of the META.json file in a CPAN distribution.

=head1 SYNOPSIS

There are two forms this module can be used.

The first is a standalone test of your distribution's META.json file:

  use Test::More;
  eval "use Test::JSON::Meta";
  plan skip_all => "Test::JSON::Meta required for testing META.json" if $@;
  meta_json_ok();

Note that you may provide an optional label/comment/message/etc to the
function, or one will be created automatically.

The second form allows you to test other META.json files, or specify a specific
version you wish to test against:

  use Test::More test => 6;
  use Test::JSON::Meta;

  # specify a file and specification version
  meta_spec_ok('META.json','1.3',$msg);

  # specify the specification version to validate the local META.json
  meta_spec_ok(undef,'1.3',$msg);

  # specify a file, where the specification version is deduced
  # from the file itself
  meta_spec_ok('META.json',undef,$msg);

Note that this form requires you to specify the number of tests you will be
running in your test script. Also note that each 'meta_spec_ok' is actually 2
tests under the hood.

Also note that the version you are testing against, is the version of the 
META.yml specification, which forms the basis for the contents of a META.json 
file.

L<http://www.nntp.perl.org/group/perl.module.build/2008/06/msg1360.html>

=head1 DESCRIPTION

This module was written to ensure that a META.json file, provided with a
standard distribution uploaded to CPAN, meets the specifications that are
slowly being introduced to module uploads, via the use of package makers and
installers such as L<ExtUtils::MakeMaker>, L<Module::Build> and
L<Module::Install>.

=head1 ABSTRACT

A test module to validate a CPAN META.json file.

=cut

#----------------------------------------------------------------------------

#############################################################################
#Library Modules															#
#############################################################################

use IO::File;
use JSON;
use Test::Builder;
use Test::JSON::Meta::Version;

#----------------------------------------------------------------------------

my $Test = Test::Builder->new();

sub import {
    my $self = shift;
    my $caller = caller;
    no strict 'refs';
    *{$caller.'::meta_json_ok'}   = \&meta_json_ok;
    *{$caller.'::meta_spec_ok'}   = \&meta_spec_ok;

    $Test->exported_to($caller);
    $Test->plan(@_);
}

#############################################################################
#Interface Functions														#
#############################################################################

=head1 FUNCTIONS

=over

=item * meta_json_ok([$msg])

Basic META.json wrapper around meta_spec_ok.

Returns a hash reference to the contents of the parsed META.json

=cut

sub meta_json_ok {
    $Test->plan( tests => 2 );
    return meta_spec_ok(undef,undef,@_);
}

=item * meta_spec_ok($file, $version [,$msg])

Validates the named file against the given specification version. Both $file
and $version can be undefined.

Returns a hash reference to the contents of the given file, after it has been
parsed.

=back

=cut

sub meta_spec_ok {
	my ($file, $vers, $msg) = @_;
    $file ||= 'META.json';

    unless($msg) {
        $msg = "$file meets the designated specification";
        $msg .= " ($vers)"   if($vers);
    }

    my $data = _readdata($file);

    unless($data) {
        $Test->ok(0,"$file contains valid JSON");
        $Test->ok(0,$msg);
        return;
    } else {
        $Test->ok(1,"$file contains valid JSON");
    }

    my %hash;
    $hash{spec} = $vers if($vers);
    $hash{data} = $data;

    my $spec = Test::JSON::Meta::Version->new(%hash);
    if(my $result = $spec->parse()) {
        $Test->ok(0,$msg);
        $Test->diag("  ERR: $_") for($spec->errors);
    } else {
        $Test->ok(1,$msg);
    }

    return $data;
}

sub _readdata {
    my $file = shift;
    my $data;
    my $fh = IO::File->new($file,'r') or die "Cannot open file [$file]: $!";
    while(<$fh>) { $data .= $_ }
    $fh->close;
    return decode_json($data);
}

q( Currently Listening To: Joy Division - "Transmission" from 'Heart And Soul');

__END__

#----------------------------------------------------------------------------

=head1 BUGS, PATCHES & FIXES

There are no known bugs at the time of this release. However, if you spot a
bug or are experiencing difficulties that are not explained within the POD
documentation, please send an email to barbie@cpan.org or submit a bug to the
RT system (http://rt.cpan.org/Public/Dist/Display.html?Name=Test-JSON-Meta).
However, it would help greatly if you are able to pinpoint problems or even
supply a patch.

Fixes are dependant upon their severity and my availablity. Should a fix not
be forthcoming, please feel free to (politely) remind me.

=head1 SEE ALSO

  JSON

=head1 DSLIP

  b - Beta testing
  d - Developer
  p - Perl-only
  O - Object oriented
  p - Standard-Perl: user may choose between GPL and Artistic

=head1 AUTHOR

Barbie, <barbie@cpan.org>
for Miss Barbell Productions, L<http://www.missbarbell.co.uk>

=head1 COPYRIGHT AND LICENSE

  Copyright (C) 2009-2010 Barbie for Miss Barbell Productions

  This module is free software; you can redistribute it and/or
  modify it under the same terms as Perl itself.

=cut
