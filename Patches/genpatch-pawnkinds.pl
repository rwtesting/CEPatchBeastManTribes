#!/usr/bin/perl
use strict;
use warnings;

use lib $ENV{RWPATCHER_LIB};
use RWPatcher::Pawnkinds;

# Generate CE patches for pawnkind files.

my $SOURCEMOD = "Beast Man Tribes";

my @SOURCEFILES = qw(
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_BearManTribe.xml
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_CamelManTribe.xml
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_ElephantManTribe.xml
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_ElkManTribe.xml
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_FoxManTribe.xml
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_GazelleManTribe.xml
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_LynxManTribe.xml
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_PigManTribe.xml
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_RaccoonManTribe.xml
    ../../1119191638/Defs/PawnKindDefs_Humanlikes/PawnKinds_WolfManTribe.xml
);

# exceptions to default ammo counts
my %CEDATA = (
    BearManArcher	=> {AmmoMin => 30, AmmoMax => 50},
    CamelManArcher	=> {AmmoMin => 30, AmmoMax => 50},
    ElephantManArcher	=> {AmmoMin => 30, AmmoMax => 50},
    ElkManArcher	=> {AmmoMin => 30, AmmoMax => 50},
    FoxManArcher	=> {AmmoMin => 30, AmmoMax => 50},
    GazelleManArcher	=> {AmmoMin => 30, AmmoMax => 50},
    LynxManArcher	=> {AmmoMin => 30, AmmoMax => 50},
    PigManArcher	=> {AmmoMin => 30, AmmoMax => 50},
    RaccoonManArcher	=> {AmmoMin => 30, AmmoMax => 50},
    WolfManArcher	=> {AmmoMin => 30, AmmoMax => 50},
);

my $patcher;
foreach my $sourcefile (@SOURCEFILES)
{
    $patcher = new RWPatcher::Pawnkinds(
	AmmoMin    => 20,  # number of arrows, not ammo packs
	AmmoMax    => 30,
        #sourcemod  => $SOURCEMOD,
        sourcefile => $sourcefile,
        cedata     => \%CEDATA,
        expected_parents => [ qw(
            BearManBase
            BearManWarrior
            CamelManBase
            CamelManWarrior
            ElephantManBase
            ElephantManWarrior
            ElkManBase
            ElkManWarrior
            FoxManBase
            FoxManWarrior
            GazelleManBase
            GazelleManWarrior
            LynxManBase
            LynxManWarrior
            PigManBase
            PigManWarrior
            RaccoonManBase
            RaccoonManWarrior
            WolfManBase
            WolfManWarrior
	) ],
    ) or die("ERR: Failed new RWPatcher::Pawnkinds: $!\n");

    $patcher->generate_patches();
}

exit(0);

__END__

