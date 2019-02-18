//-------------------------------------------------//
// MoreBlood  2010 - Mr.Loathsome                  //
// Players & Monsters bleed where they take damage //
//-------------------------------------------------//
class MB expands Mutator;

var bool bRandomMode;
var bool bBloodPool;
var bool bDeathEffect;
var int MaxBleeders;
var float BleedTime;
var float BDLifeSpan;
var float BDDrawScale;
var float SpurtLevel;
var int MaxBleedersRV;
var int BleedTimeRV;
var float BDLifeSpanRV;
var float BDDrawScaleRV;
var float SpurtLevelRV;
var float SpawnRate;
var int MBdefHealth;

var bool bInitialized, bDoSpawn;

function PostBeginPlay()
{
	if (bInitialized) return;
	else bInitialized = True;
	Level.Game.RegisterDamageMutator(Self);
	SpawnRate = class'MoreBloodConfig'.Default.SpawnRate;
	SpawnRate = FClamp(SpawnRate, 0.025, 2.0);
	bRandomMode = class'MoreBloodConfig'.Default.bRandomMode;
	bBloodPool = class'MoreBloodConfig'.Default.bBloodPool;
	bDeathEffect = class'MoreBloodConfig'.Default.bDeathEffect;
	MaxBleeders = class'MoreBloodConfig'.Default.MaxBleeders;
	BleedTime = class'MoreBloodConfig'.Default.BleedTime;
	BDLifeSpan = class'MoreBloodConfig'.Default.BDLifeSpan;
	BDDrawScale = class'MoreBloodConfig'.Default.BDDrawScale;
	SpurtLevel = class'MoreBloodConfig'.Default.SpurtLevel;
	MBdefHealth = class'MoreBloodConfig'.Default.MBdefHealth;
	if (bRandomMode)
	{
		MaxBleedersRV = class'MoreBloodConfig'.Default.MaxBleedersRV;
		BleedTimeRV = class'MoreBloodConfig'.Default.BleedTimeRV - (class'MoreBloodConfig'.Default.BleedTimeRV / 5);
		BDLifeSpanRV = class'MoreBloodConfig'.Default.BDLifeSpanRV - (class'MoreBloodConfig'.Default.BDLifeSpanRV / 5);
		BDDrawScaleRV = class'MoreBloodConfig'.Default.BDDrawScaleRV - (class'MoreBloodConfig'.Default.BDDrawScaleRV / 5);
		SpurtLevelRV = class'MoreBloodConfig'.Default.SpurtLevelRV - (class'MoreBloodConfig'.Default.SpurtLevelRV / 5);
		MaxBleeders = (FRand() * MaxBleedersRV) + 1;
		BleedTime = (FRand() * (BleedTimeRV - (BleedTimeRV / 5))) + (BleedTimeRV / 5);
		BDLifeSpan = (FRand() * (BDLifeSpanRV - (BDLifeSpanRV / 5))) + (BDLifeSpanRV / 5);
		BDDrawScale = (FRand() * (BDDrawScaleRV - (BDDrawScaleRV / 5))) + (BDDrawScaleRV / 5);
		SpurtLevel = (FRand() * (SpurtLevelRV - (SpurtLevelRV / 5))) + (SpurtLevelRV / 5);
		if (MaxBleeders > 80) MaxBleeders = 80;
		if (BleedTime > 80.0) BleedTime = 80.0;
		if (BDLifeSpan > 255) BDLifeSpan = 255;
		if (BDDrawScale > 2) BDDrawScale = 2;
		class'MoreBloodConfig'.Default.MaxBleeders = MaxBleeders;
		class'MoreBloodConfig'.Default.BleedTime = BleedTime;
		class'MoreBloodConfig'.Default.BDLifeSpan = BDLifeSpan;
		class'MoreBloodConfig'.Default.BDDrawScale = BDDrawScale;
		class'MoreBloodConfig'.Default.SpurtLevel = SpurtLevel;
		class'MoreBloodConfig'.static.StaticSaveConfig();				
		log("MaxBleeders = "$MaxBleeders$"  BleedTime = "$BleedTime$"  BDLifeSpan = "$BDLifeSpan$"  BDDrawScale = "$BDDrawScale$"  SpurtLevel = "$SpurtLevel);

	}
	else
	{
		if (MaxBleeders > 80) MaxBleeders = 80;
		if (BleedTime > 80.0) BleedTime = 80.0;
		if (BDLifeSpan > 255) BDLifeSpan = 255;
		if (BDDrawScale > 2) BDDrawScale = 2;
	}
	bDoSpawn = True;
	Super.PostBeginPlay();
}

function Timer()
{
	bDoSpawn = True;
}

function MutatorTakeDamage(out int ActualDamage, Pawn Victim, Pawn InstigatedBy, out Vector HitLocation, out Vector Momentum, name DamageType)
{
	local BleederEffectSpawner BES;
	local class<Effects> EffS;
	local int j, nb, rv;

	if ((Victim.Health - ActualDamage) <= 0)
		{
		 if (((bBloodPool) || (bDeathEffect)) && (ActualDamage < 30) && (ScriptedPawn(Victim) == None))
			{
				if (bBloodPool) BPool(Victim);
				if (bDeathEffect) DeathEffect(Victim);
			}
		}
	else
	{
	if ((ActualDamage > 0) && (bDoSpawn))
		{
			nb = NumBleeders(Victim);
			if ((nb < MaxBleeders) && (nb <= (Victim.health * 0.10)))
			{
				BES = Spawn(class'BleederEffectSpawner', Victim, , HitLocation, Victim.Rotation);
				if (BES != None)
				{
					j = ActualDamage * BleedTime;
					BES.InitSpawner();
					if ((ScriptedPawn(Victim) != None) && (ScriptedPawn(Victim).bGreenBlood))
					{
						rv = (FRand()*5);
						Switch(rv)
						{
							case 4:
								EffS = class'UTB_GBloodDrop'; j = j * 2;
								break;
							case 3:
								EffS = class'UTB_GBloodDrop';
								break;
							case 2:
								EffS = class'GreenBlob';
								break;
							case 1:
								EffS = class'GreenBloodPuff';
								break;
							case 0:
								EffS = class'GreenBloodSpray';
								break;
						}
					}
					else
					{
						rv = (FRand()*13);
						Switch(rv)
						{
							case 12:
								EffS = class'UTB_BloodDrop3';
								break;
							case 11:
								EffS = class'UTB_BloodDrop3';
								break;
							case 10:
								EffS = class'UT_BigBloodPuff';
								break;
							case 9:
								EffS = class'UT_BigBloodHit';
								break;
							case 8:
								EffS = class'UT_BloodBurst';
								break;
							case 7:
								EffS = class'UT_BloodHit';
								break;
							case 6:
								EffS = class'UT_BloodPuff';
								break;
							case 5:
								EffS = class'UTB_BloodDrop2'; j = j * 2;
								break;
							case 4:
								EffS = class'UTB_BloodDrop2';
								break;
							case 3:
								EffS = class'BloodSpurt';
								break;
							case 2:
								EffS = class'BloodPuff';
								break;
							case 1:
								EffS = class'BloodBurst';
								break;
							case 0:
								EffS = class'BloodSpray';
								break;
						}
					}
					BES.SetSpawnProperties(((FRand() * SpawnRate) + 0.5), FMin(j, 255), EffS, MBdefHealth);
					BES = None;
					SetTimer(SpawnRate, False);
					bDoSpawn = False;
				}
			}
		}
	}
		Super.MutatorTakeDamage(ActualDamage, Victim, InstigatedBy, HitLocation, Momentum, DamageType);
}

function int NumBleeders(Pawn Other)
{
	local BleederEffectSpawner BES;
	local int nb;

	nb = 0;
	foreach Other.ChildActors(class'BleederEffectSpawner', BES)
	{
		nb++;
	}
	return nb;
}

function BPool(Pawn Other)
{
	local DeathEffectSpawner DES;

	DES = Spawn(class'DeathEffectSpawner', Other, , , );
	DES.InitSpawner();
	DES.SetSpawnProperties(1, 1, class'UTB_BloodPool');
	DES = None;
}

function DeathEffect(Pawn Other)
{
	local DeathEffectSpawner DES;
	local class<Effects> EffS;
	local float sdtime;

	sdtime = (FRand() * SpawnRate) + 0.5;

	DES = Spawn(class'DeathEffectSpawner', Other, , Other.Location, Other.Rotation);
	DES.InitSpawner();
	EffS = class'UTB_BloodDrop3';
	DES.SetSpawnProperties(sdtime, 15, EffS);

	DES = Spawn(class'DeathEffectSpawner', Other, , Other.Location, Other.Rotation);
	DES.InitSpawner();
	EffS = class'UTB_BloodDrop2';
	DES.SetSpawnProperties(sdtime, 15, EffS);

	DES = Spawn(class'DeathEffectSpawner', Other, , Other.Location, Other.Rotation);
	DES.InitSpawner();
	EffS = class'UT_BlackSmoke';
	DES.SetSpawnProperties(sdtime, 7, EffS);

	DES = Spawn(class'DeathEffectSpawner', Other, , Other.Location, Other.Rotation);
	DES.InitSpawner();
	EffS = class'UTB_BloodTrail';
	DES.SetSpawnProperties(sdtime, 1, EffS);

	DES = Spawn(class'DeathEffectSpawner', Other, , , Other.Rotation);
	DES.InitSpawner();
	EffS = class'UTB_BloodTrail';
	DES.SetSpawnProperties(sdtime, 1, EffS);

}

defaultproperties
{
	bRandomMode=True
	bBloodPool=True
	bDeathEffect=False
	MaxBleeders=5
	BleedTime=2.5
	BDLifeSpan=32.0
	BDDrawScale=0.35000
	SpurtLevel=64
	MaxBleedersRV=8
	BleedTimeRV=3.0
	BDLifeSpanRV=64.0
	BDDrawScaleRV=0.40000
	SpurtLevelRV=128
	SpawnRate=0.25
	MBdefHealth=100
	bHidden=True
}
