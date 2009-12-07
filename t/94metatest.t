use Test::More;

# Skip if doing a regular install
plan skip_all => "Author tests not required for installation"
    unless ( $ENV{AUTOMATED_TESTING} );

eval "use Test::JSON::Meta";
plan skip_all => "Test::JSON::Meta required for testing META.yml" if $@;

plan no_plan;

my $meta = meta_spec_ok(undef,undef,@_);

use Test::JSON::Meta;
my $version = $Test::JSON::Meta::VERSION;

is($meta->{version},$version,
    'META.yml distribution version matches');

if($meta->{provides}) {
    for my $mod (keys %{$meta->{provides}}) {
        is($meta->{provides}{$mod}{version},$version,
            "META.yml entry [$mod] version matches");
    }
}
