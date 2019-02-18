

	OLDSKOOL MODELS for Unreal Tournament
		http://www.unreality.dk/usaar33
	Coded by UsAaR33 and Psychic_313
	Skins by Psychic_313, based on the Unreal I skins by Epic Games

Mod description
===============

This mod provides a complete set of Unreal I models for Unreal Tournament, as follows:

* 6 models - 3 male humans (Kurgan, Ash, Dante), 2 female humans (Gina, Sonya), and the Skaarj Trooper
* 5 default skins (one for each human) with Epic's original team colours
* 20 extra skins (all the remaining Unreal I skins) using my recoloured versions for team colours
* 9 "hidden skins" from UnrealI.u, not normally available in Unreal I, also with my team colours
* A menu option to switch the Skaarj Trooper from human-like (like any other UT player) to Skaarj-like
  (a 30% bigger target, 30% more health, can jump higher than humans) - the server's setting for this
  takes effect, and the default is for the Skaarj to be human-like in the interests of fairness.

The U and UTX files supplied are, needless to say, rather big. For public servers, you can choose to
disable my extra team colours, which reduces the size considerably, by altering the ServerPackages.
In this case, all team colours will use the default team skins supplied with Unreal I (and UT, since
UT includes almost all Unreal I content).

The Skaarj Trooper never actually had full team skins. If the Skaarj's extra team skins are removed
from the server packages, OldModels will substitute the best built-in skins it can find. In the
interests of team gameplay, the Red and Green team skins are replaced by lava and slime textures
respectively, so you can always see what team the Skaarj is on - it'll just look a bit stupid unless
the server admin has used the extra skins.

Installation
============

Windows users: unzip and double-click the UMOD.
If you have problems with UMOD files, try these pages:
	http://www.planetunreal.com/umodwizard/umodfaq.htm
	http://www.pseudorandom.co.uk/paradox/unreal/utmodsfaq.htm
There is no non-UMOD version of this mod. This is deliberate. If you can't install it, there
are two possibilities:
2) UMODs are generally broken on your computer. Try the web pages mentioned above to fix UMODs.
3) The UMOD or zip file might be corrupted. Download it again and try again.

Linux and Mac users: unzip with InfoZip or similar, then install the UMOD with UMODPack
(you'll need Perl to run UMODPack) or some other UMOD reader (is there an official Mac one?)

Known Issues - any reviewers, please read
============

* Our issues *
- If you have Oldskool Amp'd 2.x, you will see two versions of each model in the Class list.
Select the one whose name appears in the format "Unreal I Male One - Kurgan". The old versions
will go away when you upgrade to Oldskool 3, which no longer includes models.
- Male 1/Carter, Male 1/Curtis and Female 2/Cholerae use their default skin as one of the team
skins (Carter=gold, Curtis=green, Cholerae=green). This is by design (the skins are coloured enough
for team games already).

* Other people's issues *
- Some skin names (particularly the Gibbed skins) look a bit cryptic in Player Setup. This is an issue
with Epic's UMenu.u - the texture name is used and the name supplied in the INT file is ignored. The
forthcoming menu system mod 'EnhancedUT' by UsAaR33 and Psychic_313 will fix this.
- Some or all versions may not show up in the bot class list due to a hard-coded limit for this list
(32 classes) in UT. The mod XBots fixes this by allowing twice as many bot classes (64). EnhancedUT
will allow a user-configurable number of bot classes (64 by default, but this can be increased).

Server installation
===================

The OldModels UMOD does not add these to the serverpackages, so you must do it manually:
Under the "[Engine.GameEngine]" heading, you should have a list of "ServerPackages="
lines including the following lines. If any are not present, add them at the end:

ServerPackages=OldModels
ServerPackages=Female1Skins
ServerPackages=Female2Skins
ServerPackages=Male1Skins
ServerPackages=Male2Skins
ServerPackages=Male3Skins
ServerPackages=SkTrooperSkinsUT

To use my added team colours for the normal Unreal I skins, you'll also need these:

ServerPackages=Male1SkinsUT
ServerPackages=Male2SkinsUT
ServerPackages=Male3SkinsUT
ServerPackages=Female1SkinsUT
ServerPackages=Female2SkinsUT

and to use my added team colours for the hidden Unreal I skins, you'll also need:

ServerPackages=Male1SkinsUTHiddenUnrealI
ServerPackages=Female2SkinsUTHiddenUnrealI

OldModelsMenus is a client-side-only package used to display the OldModels configuration menus and
the versions of the models seen in Player Setup. It doesn't need to go in the server packages, but
is required to select the models yourself (you must also have the INT files).

FAQ
===

-- Why does the Skaarj look wrong in maps with mirrors (like DM-Oblivion)?
The Skaarj Trooper mesh is left-handed. Set your Weapon Hand to Left and it'll look less strange.

-- I installed Old Models, but they won't work in multiplayer! Why?
To let players use any mod online (this includes models, skins, voices and Advanced Model
Support) the server admin must have added them to their server's ServerPackages list.
Unfortunately, anyone joining a game will be forced to download any of the ServerPackages
they don't have, even if nobody is currently using that mod! This is frustrating for the
players, and takes up bandwidth from the server (leaving less for the actual gameplay),
so admins are reluctant to do this except for certain very popular models (Bonus Pack 1 is
installed on about 50% of servers, in my experience, and BP 4 on about 10%).

UsAaR33 is currently working on a mod to make model and skin support act a bit more like
Quake-engine games (Q3, Half-Life) where any model or skin you don't have appears as some
default model, so server admins will only need to install this mod and players will be able
to use any skin or model (of course, the less popular your skin, the more likely the other
players are to not have it and see you as a default model like Male Soldier anyway). Look out
for a mod called "Valhalla Avatar".

Credits and copyright
=====================

Coding
	This version coded by Simon "Psychic_313" McVittie
	Based on models code in Oldskool Amp'd by UsAaR33. Used with permission
Models/Animations
	Copyright (C) Epic Games, 1998ish?
Skins
	Original skins made by the Epic artists for Unreal I, copyright (C) Epic Games, 1998ish?
	Team colours (except Kurgan, Ash, Dante, Gina, Sonya) adapted by Psychic_313

Big thanks to UsAaR33, who started the Oldskool project.

Permissions
===========

This modification may be distributed under the following conditions:
 - All distribution must be on a not-for-profit basis (charging for this content is not allowed)
 - The entire *unmodified* ZIP file must be distributed, including this file and the complete
   UMOD file
 - Large-scale distributors (mirror downloads, CDs) must inform psychic_313@bigfoot.com