//=============================================================================
// utb_GBloodDrop.
//=============================================================================
class UTB_GBloodDrop extends UTB_BloodDrop2;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	Texture=Texture'BloodSGrn';
	Drawscale = ((FRand()*class'MoreBloodConfig'.default.BDDrawScale) / 5) + 0.025;
}

defaultproperties
{
}
