//=============================================================================
// MoreBloodModMenuItem.
//=============================================================================
class MoreBloodModMenuItem expands UMenuModMenuItem;

function Execute()
{ 
	MenuItem.Owner.Root.CreateWindow(class'MoreBloodConfigWindow',10,10,150,100);
}

defaultproperties
{
     MenuCaption="&MoreBlood RC3 Setup"
     MenuHelp="Configure MoreBlood Options"
}
