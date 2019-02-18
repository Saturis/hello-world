//-----------------------//
// BleederEffectSpawner  //
//-----------------------//

class BleederEffectSpawner extends Actor;

var float SpawnDelay;
var int SpawnsLeft, PDHealth;
var vector RelLocation;
var class<Effects> EffectToSpawn;

function InitSpawner()
{
	RelLocation = Location - Owner.Location;
}

function SetSpawnProperties(optional float SD, optional int SL, optional class<Effects> E, optional int defH)
{
	if ((Location.Z != 0.0) && (RelLocation.Z != 0.0))
	{
		SpawnDelay = FMin(SD, 5.0);
		SpawnsLeft = Min(SL, 512);
		EffectToSpawn = E;
		PDHealth = defH;
		SetTimer(SpawnDelay, true);
	}
}

function Timer()
{
	if (Owner != None)
	{
		SpawnsLeft--;
		if ((SpawnsLeft <= 0) || (Pawn(Owner).health == PDHealth))
		{
			SetTimer(0.0, false);
			Destroy();
		}
		else
			Spawn(EffectToSpawn, Self, , RelLocation + Owner.Location, Owner.Rotation);
	}
}

defaultproperties
{
	bHidden=True
}
