//=============================================================================
// utb_BloodDrop2.   Bouncy drops
//=============================================================================
class UTB_BloodDrop2 extends Blood2;

var int r, g;
var vector prevloc;

simulated function PostBeginPlay()
{
	g = (128 * FRand()) + 10;
	r = (class'MoreBloodConfig'.default.SpurtLevel * FRand()) + 1;
	Velocity.x = r;
	r = (class'MoreBloodConfig'.default.SpurtLevel * FRand()) + 1;
	Velocity.y = r;
	r = (class'MoreBloodConfig'.default.SpurtLevel * FRand()) + 1;
	Velocity.z = r;
	Texture = MultiSkins[(FRand()*7)];
	Drawscale = (FRand()*class'MoreBloodConfig'.default.BDDrawScale) + 0.0125;
	LifeSpan = class'MoreBloodConfig'.default.BDLifeSpan;
	prevloc = Self.Location;
	if (Level.NetMode != NM_DedicatedServer)
	{
		SpawnDrop();
	}
}

simulated function SpawnDrop()
{
	local Actor A;

	A = spawn(class'UT_BloodDrop');
	A.RemoteRole = ROLE_SimulatedProxy;
}

simulated function HitWall( vector HitNormal, actor Wall )
{
   if (Level.NetMode != NM_DedicatedServer)
      {
	if ((prevloc.x != Self.Location.x) && (prevloc.y != Self.Location.y))
	{
	  	if (Velocity.z >= -255.0)
		{
			Velocity.z += g;
			g = g + g;
			Velocity.z *= -1;
		}
		prevloc = Self.Location;
	}
      }
}

defaultproperties
{
     bHighDetail=True
     Physics=PHYS_Falling
     bStatic=False
     LifeSpan=3.500000
     DrawType=DT_Sprite
     Style=STY_Masked
     Texture=Texture'Botpack.Blood.BD3'
     DrawScale=0.250000
     AmbientGlow=180
     MultiSkins(0)=Texture'Botpack.Blood.BD3'
     MultiSkins(1)=Texture'Botpack.Blood.BD4'
     MultiSkins(2)=Texture'Botpack.Blood.BD6'
     MultiSkins(3)=Texture'Botpack.Blood.BD9'
     MultiSkins(4)=Texture'Botpack.Blood.BD10'
     MultiSkins(5)=Texture'Botpack.Blood.BD3'
     MultiSkins(6)=Texture'Botpack.Blood.BD4'
     MultiSkins(7)=Texture'Botpack.Blood.BD6'
     bCollideWorld=True
     bBounce=True
     NetPriority=2.000000
}
