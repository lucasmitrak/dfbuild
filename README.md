# dfbuild
## Description
dfbuild is a bash script that installs and configures the following components:
* Dwarf Fortress v47.05
* DFHack 47.05
* Phoebus 47.05
* twbt 47.05
* Dwarf Therapist 41.2.5
* SoundSense r2016-1

The last Lazy Newb Pack has bugs of its own and outdated components (like dfhack 47.05 r7).  This script is meant to replace it.  This script is meant to be run inside [Cygwin](https://www.cygwin.com/) or Linux.

## How to run it
It is a simple bash script with all the components included, so it can be run like this:
```
cd dfbuild
./dfbuild.sh
```
Make sure it is executed from inside the dfbuild directory.  It will install everything into the **build** subdirectory, which is where all components can be run.

## Changes to d_init.txt and init.txt
These changes can either be commented out in the script or changed back in the resulting build directory.

### d_init.txt
The following settings were changed in d_init:
* AUTOSAVE:NONE     -> AUTOSAVE:SEASONAL
* AUTOSAVE_PAUSE:NO -> AUTOSAVE_PAUSE:YES/
* INITIAL_SAVE:NO   -> INITIAL_SAVE:YES
* TEMPERATURE:YES   -> TEMPERATURE:NO
* WEATHER:YES       -> WEATHER:NO

These changes were made to [save FPS](https://dwarffortresswiki.org/index.php/DF2014:Maximizing_framerate) and enable more frequent saving.

### init.txt
The following changes were made in init.txt:
* SOUND:YES       -> SOUND:NO
* INTRO:YES       -> INTRO:NO
* FPS:NO          -> FPS:YES
* PRIORITY:NORMAL -> PRIORITY:HIGH

These changes were made to disable the default soundtrack in favor of SoundSense, show and potentially increase the FPS, and disable the default intro.
In addition, the default font and fullfont were changed for Phoebus.

## Bugfixes/Automation
Several bugfixes and automation scripts/plugins are included.
### LNP Originating
Lazy Newb Pack includes the following:
`multicmd autonestbox start; repeat -time 7 -timeUnits days -command [ burial ] -name burial`
This command enables [autonestbox](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/autonestbox.html) and [burial](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/burial.html)
`multicmd tweak fast-heat 100; repeat -time 1 -timeUnits months -command [ multicmd cleanowned X ; clean all ]`
This command [improves temperature update performance](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/tweak.html), [dumps worn items](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/cleanowned.html), and [cleans everything that can be cleaned (except mud and snow)](https://docs.dfhack.org/en/latest/docs/tools/cleaners.html).

These are DFHack fixes to run regularly, changes the game a little but helps a lot on old or slow hardware.

### More Bugfixes/Automation
[`fix/blood-del`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/fix/blood-del.html) ensures future caravans won’t bring barrels full of blood, ichor, or goo.
`fix/civil-war` is a script from the [bay12forums](https://www.bay12forums.com/smf/index.php?topic=173306.0) that fixes civil wars
`repeat -name fix-corrupt-equipment -time 100 -timeUnits ticks -command [ fix/corrupt-equipment ]` has been commented out, but enable it if you have dwarves coming back from raids
`fix/corrupt-jobs` is a backported fix from [newer DFHacks](https://docs.dfhack.org/en/stable/docs/tools/fix/corrupt-jobs.html).  It cleans up corrupt jobs so they don’t cause crashes.
[`fix/dead-units`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/fix/dead-units.html) removes uninteresting units from the dead units list.
`fix/empty-wheelbarrows` is a backported fix from [newer DFHacks](https://docs.dfhack.org/en/stable/docs/tools/fix/empty-wheelbarrows.html) that fixes [Bug 6074](https://dwarffortressbugtracker.com/view.php?id=6074).  This works around the issue encountered with Bug 6074 where wheelbarrows lie around with rocks in them that aren't being used in a task.
`fix/general-strike` is a backported fix from [newer DFHacks](https://docs.dfhack.org/en/stable/docs/tools/fix/general-strike.html) that attempts to fix known causes of the “general strike bug”, where dwarves just stop accepting work and stand around with “No job”.
[`fix/item-occupancy`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/fix/item-occupancy.html) diagnoses and fixes issues with nonexistent ‘items occupying site’, usually caused by hacking mishaps with items being improperly moved about.
[`fix/loyaltycascade`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/fix/loyaltycascade.html) aborts loyalty cascades by fixing units who consider their own civilization to be the enemy.
`fix/stuck-instruments` is a backported fix from [newer DFHacks](https://docs.dfhack.org/en/stable/docs/tools/fix/stuck-instruments.html) that fixes [Bug 9485](https://dwarffortressbugtracker.com/view.php?id=9485) instruments that were picked up for a performance, but were instead simulated and are now stuck permanently in a job that no longer exists.
[`fix/stuckdoors`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/fix/stuckdoors.html) can fix doors that are stuck open due to incorrect map occupancy flags.
[`enable fix-unit-occupancy`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/fix-unit-occupancy.html) helps [Bug 3499](https://www.bay12games.com/dwarves/mantisbt/view.php?id=3499) where there are “unit blocking tile” messages that you can’t account for.
[`enable dwarfvet`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/dwarfvet.html) enables injured animals to be treated at an animal hospital, which is simply a hospital that is also an animal training zone.
[`enable workflow`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/workflow.html) enables the workflow plugin.  Its drybuckets and auto-melt features are also enabled for bug fixing and convience.
[`on-new-fortress ban-cooking booze oil tallow thread`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/ban-cooking.html) provides a far more convenient way to ban cooking categories of foods than the native kitchen interface.  It runs once every new fortress.
[`deteriorate start --types corpses --freq 0.1,days`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/deteriorate.html) will deteriorate corpses quickly.
[`starvingdead start`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/starvingdead.html) will cause all undead that have been on the map for one month gradually decay, losing strength, speed, and toughness. After six months, they collapse upon themselves, never to be reanimated.
[`enable nestboxes`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/nestboxes.html) will automatically scan for and forbid fertile eggs incubating in a nestbox so that dwarves won’t come to collect them for eating. The eggs will hatch normally, even when forbidden.
[`autounsuspend start`](https://docs.dfhack.org/en/0.47.05-r8/docs/tools/autounsuspend.html) will unsuspend jobs that have become suspended due to inaccessible materials, items in the way, or worker dwarves getting scared by wildlife.

## Other
Some keybindings were added:
* __Ctrl-A@dwarfmode/Default "revtoggle"__ for avoiding mistakes and opening the caverns which costs FPS
* __Alt-Q@dwarfmode/LookAround "quickfort gui"__ for selecting quickfort blueprints
* __Ctrl-Alt-Q "gui/quantum"__ and __Ctrl-Alt-W "assign-minecarts all"__ for ease of implementing quantum stockpiles.
