#!/usr/bin/perl
use strict;
use warnings;

my @PAWNKINDS = qw(
    BearManWarrior
    BearManTrader
    BearManArcher
    BearManChief
    CamelManWarrior
    CamelManTrader
    CamelManArcher
    CamelManChief
    ElephantManWarrior
    ElephantManTrader
    ElephantManArcher
    ElephantManChief
    ElkManWarrior
    ElkManTrader
    ElkManArcher
    ElkManChief
    FoxManWarrior
    FoxManTrader
    FoxManArcher
    FoxManChief
    GazelleManWarrior
    GazelleManTrader
    GazelleManArcher
    GazelleManChief
    LynxManWarrior
    LynxManTrader
    LynxManArcher
    LynxManChief
    PigManWarrior
    PigManTrader
    PigManArcher
    PigManChief
    RaccoonManWarrior
    RaccoonManTrader
    RaccoonManArcher
    RaccoonManChief
    WolfManWarrior
    WolfManTrader
    WolfManArcher
    WolfManChief
);

my $OUTFILE = "./PawnKinds/Pawnkinds-CE-patch.xml";
open(OUTFILE, ">", $OUTFILE) or die("ERR: open/write $OUTFILE: $!\n");
print("Generating patch file: $OUTFILE\n");

print OUTFILE (<<EOF);
<?xml version="1.0" encoding="utf-8" ?>
<Patch>

EOF

foreach my $pawnkind (@PAWNKINDS)
{
    print OUTFILE (<<EOF);
  <Operation Class="PatchOperationAddModExtension">
    <xpath>Defs/PawnKindDef[defName="$pawnkind"]</xpath>
    <value>
      <li Class="CombatExtended.LoadoutPropertiesExtension">
        <primaryMagazineCount>
          <min>30</min>  <!-- single arrow count, not packs of arrows -->
          <max>50</max>
        </primaryMagazineCount>
      </li>
    </value>
  </Operation>

EOF
}

print OUTFILE (<<EOF);
</Patch>

EOF

close(OUTFILE) or warn("WARN: close $OUTFILE: $!\n");

exit(0);

__END__

