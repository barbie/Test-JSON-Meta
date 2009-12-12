use Test::More;

# Skip if doing a regular install
plan skip_all => "Author tests not required for installation"
    unless ( $ENV{AUTOMATED_TESTING} );

eval "use Test::JSON::Meta";
plan skip_all => "Test::JSON::Meta required for testing META.json files" if $@;

plan no_plan;

my $meta = meta_spec_ok(undef,undef,@_);

use Test::JSON::Meta;                           # enter your module name here
my $version = $Test::JSON::Meta::VERSION;       # enter your module name here

is($meta->{version},$version,
    'META.json distribution version matches');

if($meta->{provides}) {
    for my $mod (keys %{$meta->{provides}}) {
        is($meta->{provides}{$mod}{version},$version,
            "META.json entry [$mod] version matches");
    }
}