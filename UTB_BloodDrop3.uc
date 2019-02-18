//=============================================================================
// utb_BloodDrop3.   Bouncy drops with decal finish
//=============================================================================
class UTB_BloodDrop3 extends UTB_BloodDrop2;

simulated function HitWall( vector HitNormal, actor Wall )
{
   if (Level.NetMode != NM_DedicatedServer)
	if ((prevloc.x != Self.Location.x) && (prevloc.y != Self.Location.y))
	{
	  	if (Velocity.z >= -255.0)
		{
			Velocity.z += g++;
			g = g + g;
			Velocity.z *= -1;
		}
		prevloc = Self.Location;
	}
	else
	{
		Spawn(class'BloodSplat',,,Self.Location,rotator(HitNormal));
		Destroy();
	}

}

simulated function Landed( vector HitNormal )
{
   if (Level.NetMode != NM_DedicatedServer)
	{
		Spawn(class'BloodSplat',,,Self.Location,rotator(HitNormal));
		Destroy();
	}
}

defaultproperties
{
}
