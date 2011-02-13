use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'			=> 'Test::JSON::Meta',
    'VERSION_FROM'	=> 'lib/Test/JSON/Meta.pm',
    'PREREQ_PM'		=> {
		Test::More	            => 0.62,	# for testing
		Test::CPAN::Meta::JSON  => 0.10,
	},
	NO_META			=> 1,

    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT	=> 'CPAN META.json testing module',
       AUTHOR	=> 'Barbie <barbie@cpan.org>') : ()),
);
