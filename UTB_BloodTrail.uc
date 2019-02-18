//=============================================================================
// utb_BloodTrail.
//=============================================================================
class UTB_BloodTrail extends UT_Blood2;

#exec MESH IMPORT MESH=UTBloodTrl ANIVFILE=MODELS\Blood2_a.3D DATAFILE=MODELS\Blood2_d.3D X=0 Y=0 Z=0 ZEROTEX=1
#exec MESH ORIGIN MESH=UTBloodTrl X=0 Y=0 Z=0 YAW=128
#exec MESH SEQUENCE MESH=UTBloodTrl SEQ=All       STARTFRAME=0   NUMFRAMES=45
#exec MESH SEQUENCE MESH=UTBloodTrl SEQ=Spray     STARTFRAME=0   NUMFRAMES=6
#exec MESH SEQUENCE MESH=UTBloodTrl SEQ=Still     STARTFRAME=6   NUMFRAMES=1
#exec MESH SEQUENCE MESH=UTBloodTrl SEQ=GravSpray STARTFRAME=7   NUMFRAMES=5
#exec MESH SEQUENCE MESH=UTBloodTrl SEQ=Stream    STARTFRAME=12  NUMFRAMES=11
#exec MESH SEQUENCE MESH=UTBloodTrl SEQ=Trail     STARTFRAME=23  NUMFRAMES=11
#exec MESH SEQUENCE MESH=UTBloodTrl SEQ=Burst     STARTFRAME=34  NUMFRAMES=2
#exec MESH SEQUENCE MESH=UTBloodTrl SEQ=GravSpray2 STARTFRAME=36 NUMFRAMES=7

#exec MESHMAP SCALE MESHMAP=UTBloodTrl X=0.11 Y=0.055 Z=0.11 YAW=128
#exec MESHMAP SETTEXTURE MESHMAP=UTBloodTrl NUM=0  TEXTURE=BloodSpot

simulated function PostBeginPlay()
{
	local int rv;

	Texture = MultiSkins[(FRand()*5)];
	DrawScale = (FRand()*class'MoreBloodConfig'.default.BDDrawScale) + 0.0125;
	LifeSpan = (FRand()*9) + 2.5;
	if (Level.NetMode != NM_DedicatedServer)
	{
		rv = (FRand()*6);
		Switch(rv)
		{
			case 5:
				LoopAnim('Spray');
				break;
			case 4:
				LoopAnim('GravSpray');
				break;
			case 3:
				LoopAnim('Stream');
				break;
			case 2:
				LoopAnim('Trail');
				break;
			case 1:
				LoopAnim('Burst');
				break;
			case 0:
				LoopAnim('GravSpray2');
				break;
		}
		bRandomFrame = !Level.bDropDetail;
	}
}

simulated function AnimEnd()
{
}

defaultproperties
{
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=5.000000
     AnimSequence=trail
     Texture=Texture'Botpack.Blood.BD6'
     MultiSkins(0)=Texture'Botpack.Blood.BD3'
     MultiSkins(1)=Texture'Botpack.Blood.BD4'
     MultiSkins(2)=Texture'Botpack.Blood.BD6'
     MultiSkins(3)=Texture'Botpack.Blood.BD9'
     MultiSkins(4)=Texture'Botpack.Blood.BD10'
     Mesh=LodMesh'Botpack.UTBloodTrl'
     DrawScale=0.200000
     AmbientGlow=180
     NetPriority=2.000000
     bCollideWorld=False
}
