package Test::JSON::Meta;

use warnings;
use strict;

use vars qw($VERSION);
$VERSION = '0.11';

use base 'Test::CPAN::Meta::JSON';

q( "Before software can be reusable it first has to be usable." - Ralph Johnson );

__END__

#----------------------------------------------------------------------------

=head1 NAME

Test::JSON::Meta - Validation of the META.json file in a CPAN distribution.

=head1 DESCRIPTION

This module has now been replaced by L<Test::CPAN::Meta::JSON>. Please see
that distribution for further details.

=head1 ABSTRACT

A test module to validate a CPAN META.json file.

=head1 BUGS, PATCHES & FIXES

There are no known bugs at the time of this release. However, if you spot a
bug or are experiencing difficulties that are not explained within the POD
documentation, please send an email to barbie@cpan.org or submit a bug to the
RT system (http://rt.cpan.org/Public/Dist/Display.html?Name=Test-JSON-Meta).
However, it would help greatly if you are able to pinpoint problems or even
supply a patch.

Fixes are dependent upon their severity and my availability. Should a fix not
be forthcoming, please feel free to (politely) remind me.

=head1 SEE ALSO

L<Test::CPAN::Meta::JSON>.

=head1 AUTHOR

Barbie, <barbie@cpan.org>
for Miss Barbell Productions, L<http://www.missbarbell.co.uk>

=head1 COPYRIGHT AND LICENSE

  Copyright (C) 2009-2013 Barbie for Miss Barbell Productions

  This distribution is free software; you can redistribute it and/or
  modify it under the Artistic Licence v2.

=cut
