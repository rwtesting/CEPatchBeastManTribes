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

    <!-- ========== $race ========== -->

    <Operation Class="PatchOperationSequence">
    <success>Always</success>
    <operations>

	<li Class="PatchOperationAddModExtension">
		<xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]</xpath>
		<value>
			<li Class="CombatExtended.RacePropertiesExtensionCE">
				<bodyShape>Humanoid</bodyShape>
			</li>
		</value>
	</li>

	<!-- Delete old a17 verbs node. Causes armor pen errors during melee. -->
	<li Class="PatchOperationSequence">
  	<success>Always</success>
  	<operations>
    	<li Class="PatchOperationTest">
      		<xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]/verbs</xpath>
      		<success>Normal</success>
    	</li>
    	<li Class="PatchOperationRemove">
      		<xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]/verbs</xpath>
    	</li>
  	</operations>
	</li>

	<!-- Add tools melee specifications - Add tools node if it doesn't exist -->
	<li Class="PatchOperationSequence">
  	<success>Always</success>
  	<operations>
    	<li Class="PatchOperationTest">
      	<xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]/tools</xpath>
      	<success>Invert</success>
    	</li>
    	<li Class="PatchOperationAdd">
      	<xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]</xpath>
      	<value>
        	<tools />
      	</value>
    	</li>
  	</operations>
	</li>

	<!-- All BM races define LeftHand+RightHand (no head definition) -->
	<li Class="PatchOperationAdd">
		<xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]/tools</xpath>
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
		</value>
	</li>

	<!-- Add comps node if it doesn't exist -->
	<li Class="PatchOperationSequence">
  	<success>Always</success>
  	<operations>
    	<li Class="PatchOperationTest">
      	<xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]/comps</xpath>
      	<success>Invert</success>
    	</li>
    	<li Class="PatchOperationAdd">
      	<xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]</xpath>
      	<value>
        	<comps />
      	</value>
    	</li>
  	</operations>
	</li>

	<li Class="PatchOperationAdd">
		<xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]/comps</xpath>
		<value>
			<li>
			  <compClass>CombatExtended.CompPawnGizmo</compClass>
			</li>
			<li Class="CombatExtended.CompProperties_Suppressable" />
		</value>
	</li>

    </operations>  <!-- end sequence -->
    </Operation>   <!-- end sequence -->

</Patch>

EOF

    close(OUTFILE) or warn("WARN: close($outfile): $!\n");
}

exit(0);

__END__


TESTING

	<!-- Combat tab should be in BasePawn but BMT defines BasePawn without it, so add it -->
	<li Class="PatchOperationSequence">
  	<success>Always</success>
  	<operations>
    	    <li Class="PatchOperationTest">
      	        <xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]/inspectorTabs/ITab_Pawn_Combat</xpath>
      	        <success>Invert</success>
    	    </li>
    	    <li Class="PatchOperationAdd">
      	        <xpath>/Defs/AlienRace.ThingDef_AlienRace[defName="$race"]/inspectorTabs</xpath>
      	        <value>
	            <li>ITab_Pawn_Combat</li>
      	        </value>
    	    </li>
  	</operations>
	</li>

