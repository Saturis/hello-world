//=============================================================================
// UTB_BloodPool.
//=============================================================================
class UTB_BloodPool extends Effects;

simulated function PostBeginPlay()
{
	LifeSpan = (FRand() * 40) + 8.0;
	DrawScale = (Frand() * 0.6) + 0.2;
	if (Level.NetMode != NM_DedicatedServer)
	{
		PlayAnim ( 'Explo', 0.005 );
	}
}

simulated function SpawnPool()
{
	local Actor A;

	if (Level.NetMode != NM_DedicatedServer)
	{
		A = spawn(class'BloodPool');
	}
}

defaultproperties
{
     bHighDetail=True
     Physics=PHYS_Falling
     LifeSpan=18.00000
     DrawScale=0.40000
     AmbientGlow=180
     RemoteRole=ROLE_SimulatedProxy
     AnimSequence=Explo
     DrawType=DT_Mesh
     Mesh=LodMesh'UnrealShare.BSpot'
     bCollideWorld=True
     bBounce=False
     NetPriority=2.000000
}
