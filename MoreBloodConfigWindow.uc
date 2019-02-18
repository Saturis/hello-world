//=============================================================================
// MoreBloodConfigWindow.
//=============================================================================
class MoreBloodConfigWindow expands UWindowFramedWindow;

function BeginPlay()
{
Super.BeginPlay();
//Set the title of the Framed Window
WindowTitle = "Configure MoreBlood";

//The class of the content
ClientClass = class'MoreBloodConfig';
//Make the Framed Window resizable
bSizable = true;
}

function Created()
{
	Super.Created();
	SetSize(420, 370);
	WinLeft = (Root.WinWidth - WinWidth) / 2;
	WinTop = (Root.WinHeight - WinHeight) / 2;
}

defaultproperties
{
}
