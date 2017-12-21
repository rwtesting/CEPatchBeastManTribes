#!/usr/bin/perl
use strict;
use warnings;

# Pawnkinds, one group per xml file in original mod.
# Will use 1 patch sequence per file for faster load times.
my @PAWNKINDS = (
    [ qw(
    BearManWarrior
    BearManTrader
    BearManArcher
    BearManChief
    ) ],
    [ qw(
    CamelManWarrior
    CamelManTrader
    CamelManArcher
    CamelManChief
    ) ],
    [ qw(
    ElephantManWarrior
    ElephantManTrader
    ElephantManArcher
    ElephantManChief
    ) ],
    [ qw(
    ElkManWarrior
    ElkManTrader
    ElkManArcher
    ElkManChief
    ) ],
    [ qw(
    FoxManWarrior
    FoxManTrader
    FoxManArcher
    FoxManChief
    ) ],
    [ qw(
    GazelleManWarrior
    GazelleManTrader
    GazelleManArcher
    GazelleManChief
    ) ],
    [ qw(
    LynxManWarrior
    LynxManTrader
    LynxManArcher
    LynxManChief
    ) ],
    [ qw(
    PigManWarrior
    PigManTrader
    PigManArcher
    PigManChief
    ) ],
    [ qw(
    RaccoonManWarrior
    RaccoonManTrader
    RaccoonManArcher
    RaccoonManChief
    ) ],
    [ qw(
    WolfManWarrior
    WolfManTrader
    WolfManArcher
    WolfManChief
    ) ],
);

my $OUTFILE = "./PawnKinds/Pawnkinds-CE-patch.xml";
open(OUTFILE, ">", $OUTFILE) or die("ERR: open/write $OUTFILE: $!\n");
print("Generating patch file: $OUTFILE\n");

print OUTFILE (<<EOF);
<?xml version="1.0" encoding="utf-8" ?>
<Patch>

  <!-- One patch sequence per original xml file (for reduced load times) -->

EOF

my($pawngroup, $pawnkind, $pawngroupname);
foreach $pawngroup (@PAWNKINDS)
{
    ($pawngroupname = $pawngroup->[0]) =~ s/Man.*$/Man/;
    print OUTFILE (<<EOF);
  <!-- ========== $pawngroupname (group) ========== -->

  <Operation Class="PatchOperationSequence">
  <success>Always</success>
  <operations>

EOF
    foreach $pawnkind (@$pawngroup)
    {
        print OUTFILE (<<EOF);
  <li Class="PatchOperationAddModExtension">
    <xpath>Defs/PawnKindDef[defName="$pawnkind"]</xpath>
    <value>
      <li Class="CombatExtended.LoadoutPropertiesExtension">
        <primaryMagazineCount>
          <min>30</min>  <!-- single arrow count, not packs of arrows -->
          <max>50</max>
        </primaryMagazineCount>
      </li>
    </value>
  </li>

EOF
    }

    # closer for this group
    print OUTFILE (<<EOF);
  </operations>  <!-- End sequence: $pawngroupname -->
  </Operation>   <!-- End sequence: $pawngroupname -->

EOF
}

print OUTFILE (<<EOF);
</Patch>

EOF

close(OUTFILE) or warn("WARN: close $OUTFILE: $!\n");

exit(0);

__END__

