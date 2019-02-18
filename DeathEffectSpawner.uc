//-----------------------//
// DeathEffectSpawner    //
//-----------------------//

class DeathEffectSpawner extends Actor;

var float SpawnDelay;
var int SpawnsLeft;
var vector RelLocation;
var class<Effects> EffectToSpawn;

function InitSpawner()
{
	if (Location.Z != 0.0) RelLocation = Location - Owner.Location;
}

function SetSpawnProperties(optional float SD, optional int SL, optional class<Effects> E)
{
	SpawnDelay = FMin(SD, 5.0);
	SpawnsLeft = Min(SL, 50);
	EffectToSpawn = E;
	SetTimer(SpawnDelay, true);
}

function Timer()
{
	if (Owner != None)
	{
		Spawn(EffectToSpawn, Self, , RelLocation + Owner.Location, Owner.Rotation);
		SpawnsLeft--;
		if ((SpawnsLeft <= 0) || (Pawn(Owner).health > 0))
		{
			SetTimer(0.0, false);
			Destroy();
		}
	}
}

defaultproperties
{
	bHidden=True
}
