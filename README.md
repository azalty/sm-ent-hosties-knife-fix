# sm-ent-hosties-knife-fix
Fixes a bug in ENT_Hosties that causes players to have 2 knives at spawn, breaking the player's inventory

### Bug? I never saw any problem!
Problems will start to be seen when a plugin tries to strip to weapons of the player.\
Weapons are stored in weapon slots, and the knife slots are used for both the knife and the taser.

The problem is that ENT_Hosties seems to register a second invisible knife with the same ID (so it is basically the same knife, but referenced twice) in the weapon slot.

Thus, some plugins will think that the second weapon is actually a taser, when it is the same knife registered twice in reality.

### What does this plugin do?
The plugin acts 1 frame after a player spawns and removes every weapon in their knife weapon slot.\
If a taser is found, it will be given back.\
If a knife is found, it will be given back.

What you end up is a cleared weapon inventory with only 1 knife and only 1 taser (if you had any).

### Warning
I think fists share the same slot. This plugin is only intended for knives and tasers, and having fists at spawn will break it.\
If you use this option in ENT_Hosties, please don't use this fix (you don't need it anyway!)
