#!/usr/bin/perl
use strict;
use warnings;

my @RACES = qw(
    BearMan
    CamelMan
    ElephantMan
    ElkMan
    FoxMan
    GazelleMan
    LynxMan
    PigMan
    RaccoonMan
    WolfMan
);

# Generate one patch file per listed race
my($outfile);
foreach my $race (@RACES)
{
    # Check file, overwrite any existing
    $outfile = "./Races/" . $race . "-Race-CE-patch.xml";
    if (!open(OUTFILE, ">", $outfile))
    {
	warn("WARN: open($outfile): $!.  Skipping.\n");
        next;
    }
    print("Generating patch file: $outfile\n");

    # Generate patch contents
    print OUTFILE (<<EOF);
<?xml version="1.0" encoding="utf-8" ?>
<Patch>

	<Operation Class="PatchOperationAddModExtension">
		<xpath>*/AlienRace.ThingDef_AlienRace[defName="$race"]</xpath>
		<value>
			<li Class="CombatExtended.RacePropertiesExtensionCE">
				<bodyShape>Humanoid</bodyShape>
			</li>
		</value>
	</Operation>

	<!-- tools melee specifications - Add tools node if it doesn't exist -->
	<Operation Class="PatchOperationSequence">
  	<success>Always</success>
  	<operations>
    	<li Class="PatchOperationTest">
      	<xpath>*/AlienRace.ThingDef_AlienRace[defName="$race"]/tools</xpath>
      	<success>Invert</success>
    	</li>
    	<li Class="PatchOperationAdd">
      	<xpath>*/AlienRace.ThingDef_AlienRace[defName="$race"]</xpath>
      	<value>
        	<tools />
      	</value>
    	</li>
  	</operations>
	</Operation>

	<Operation Class="PatchOperationAdd">
		<xpath>*/AlienRace.ThingDef_AlienRace[defName="$race"]/tools</xpath>
		<value>
				<li Class="CombatExtended.ToolCE">
					<label>left fist</label>
					<capacities>
						<li>Blunt</li>
					</capacities>
					<power>7</power>
					<cooldownTime>1.65</cooldownTime>
					<linkedBodyPartsGroup>LeftHand</linkedBodyPartsGroup>
					<armorPenetration>0.095</armorPenetration>
				</li>
				<li Class="CombatExtended.ToolCE">
					<label>right fist</label>
					<capacities>
						<li>Blunt</li>
					</capacities>
					<power>7</power>
					<cooldownTime>1.65</cooldownTime>
					<linkedBodyPartsGroup>RightHand</linkedBodyPartsGroup>
					<armorPenetration>0.095</armorPenetration>
				</li>
				<li Class="CombatExtended.ToolCE">
					<label>head</label>
					<capacities>
						<li>Blunt</li>
					</capacities>
					<power>5</power>
					<cooldownTime>1.85</cooldownTime>
					<linkedBodyPartsGroup>HeadAttackTool</linkedBodyPartsGroup>
					<commonality>0.2</commonality>
					<armorPenetration>0.079</armorPenetration>
				</li>
		</value>
	</Operation>

	<!-- Add comps node if it doesn't exist -->
	<Operation Class="PatchOperationSequence">
  	<success>Always</success>
  	<operations>
    	<li Class="PatchOperationTest">
      	<xpath>*/AlienRace.ThingDef_AlienRace[defName="$race"]/comps</xpath>
      	<success>Invert</success>
    	</li>
    	<li Class="PatchOperationAdd">
      	<xpath>*/AlienRace.ThingDef_AlienRace[defName="$race"]</xpath>
      	<value>
        	<comps />
      	</value>
    	</li>
  	</operations>
	</Operation>

	<Operation Class="PatchOperationAdd">
		<xpath>*/AlienRace.ThingDef_AlienRace[defName="$race"]/comps</xpath>
		<value>
			<li>
			  <compClass>CombatExtended.CompPawnGizmo</compClass>
			</li>
			<li Class="CombatExtended.CompProperties_Suppressable" />
		</value>
	</Operation>
</Patch>

EOF

    close(OUTFILE) or warn("WARN: close($outfile): $!\n");
}

exit(0);

__END__

