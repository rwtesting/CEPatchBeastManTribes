#!/usr/bin/perl
use strict;
use warnings;

use lib $ENV{RWPATCHER_LIB};
use RWPatcher::Races::AlienRaces;

my $SOURCEMOD = qq(Beast Man Tribes);
my @SOURCEFILES = (
    "../../1119191638/Defs/Alien Race/BearManRace.xml",
    "../../1119191638/Defs/Alien Race/CamelManRace.xml",
    "../../1119191638/Defs/Alien Race/ElephantManRace.xml",
    "../../1119191638/Defs/Alien Race/ElkManRace.xml",
    "../../1119191638/Defs/Alien Race/FoxManRace.xml",
    "../../1119191638/Defs/Alien Race/GazelleManRace.xml",
    "../../1119191638/Defs/Alien Race/LynxManRace.xml",
    "../../1119191638/Defs/Alien Race/PigManRace.xml",
    "../../1119191638/Defs/Alien Race/RaccoonManRace.xml",
    "../../1119191638/Defs/Alien Race/WolfManRace.xml",
);

my $patcher;
foreach my $sourcefile (@SOURCEFILES)
{
    $patcher = new RWPatcher::Races::AlienRaces(
        #sourcemod  => $SOURCEMOD,
        sourcefile  => $sourcefile,
        cedata      => {},
        expected_parents => "BasePawn",
    ) or die("ERR: Failed new RWPatcher::Races::AlienRaces: $!\n");

    $patcher->generate_patches();
}

exit(0);

__END__

