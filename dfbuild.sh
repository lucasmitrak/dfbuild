#!/usr/bin/env bash

# Meant to be run within cygwin

set -ex

rm -rfv build
mkdir -v build

# DF
unzip df_47_05_win.zip -d build

# dfhack
# Follows instructions at:
# https://github.com/DFHack/dfhack/releases/tag/0.47.05-r8
unzip dfhack-0.47.05-r8-Windows-64bit.zip -d build
# Remove the blueprints
rm -rfv build/blueprints/*

# Phoebus
# Follows instructions at:
# https://github.com/DFgraphics/Phoebus/tree/master
rm -rfv Phoebus-47.05/
unzip Phoebus-47.05.zip
cp -rv Phoebus-47.05/data/art/* build/data/art/
cp -rv Phoebus-47.05/data/init/* build/data/init/
cp -rv Phoebus-47.05/raw/objects/* build/raw/objects/
cp -rv Phoebus-47.05/raw/graphics/* build/raw/graphics/
# all twbt content
cp -rv Phoebus-47.05/data/twbt_art/* build/data/art/
cp -rv Phoebus-47.05/data/twbt_init/* build/data/init/
cp -rv Phoebus-47.05/raw/twbt_graphics/* build/raw/graphics/
cp -rv Phoebus-47.05/raw/twbt_objects/* build/raw/objects/
cp -rv Phoebus-47.05/raw/onLoad_gfx_Phoebus.init build/raw/
rm -rfv Phoebus-47.05/

# TWBT
# Follows instructions at:
# https://github.com/thurin/df-twbt/releases/tag/0.47.05-r8
rm -rfv twbt
mkdir -v twbt
unzip twbt-6.xx-win64-0.47.05-r8.zip -d twbt
cp -rv twbt/0.47.05-r8/twbt.plug.dll build/hack/plugins/
cp -rv twbt/transparent1px.png build/data/art/
cp -rv twbt/white1px.png build/data/art/
cp -rv twbt/shadows.png build/data/art/
rm -rfv twbt

# d_init settings
sed -e 's/AUTOSAVE:NONE/AUTOSAVE:SEASONAL/'	 -i build/data/init/d_init.txt
sed -e 's/AUTOSAVE_PAUSE:NO/AUTOSAVE_PAUSE:YES/' -i build/data/init/d_init.txt
sed -e 's/INITIAL_SAVE:NO/INITIAL_SAVE:YES/'	 -i build/data/init/d_init.txt
sed -e 's/TEMPERATURE:YES/TEMPERATURE:NO/'	 -i build/data/init/d_init.txt
sed -e 's/WEATHER:YES/WEATHER:NO/'		 -i build/data/init/d_init.txt

# init settings
sed -e 's/SOUND:YES/SOUND:NO/'		  -i build/data/init/init.txt
sed -e 's/INTRO:YES/INTRO:NO/'		  -i build/data/init/init.txt
sed -e 's/FONT:Jecobus_10x16.png/FONT:curses_640x300.png/' \
	-i build/data/init/init.txt
sed -e 's/FULLFONT:Jecobus_10x16.png/FULLFONT:curses_640x300.png/' \
	-i build/data/init/init.txt
sed -e 's/FPS:NO/FPS:YES/'		  -i build/data/init/init.txt
sed -e 's/PRIORITY:NORMAL/PRIORITY:HIGH/' -i build/data/init/init.txt
sed -e 's/MACRO_MS:15/MACRO_MS:0/'	  -i build/data/init/init.txt

# Aquifers
sed -e 's/\[AQUIFER\]/!AQUIFER!/g' -i build/raw/objects/inorganic_stone_*.txt

# Dwarf Therapist
# https://github.com/Dwarf-Therapist/Dwarf-Therapist/releases/tag/v41.2.5
unzip DwarfTherapist-v41.2.5-win64.zip -d build

# SoundSense
# Homepage: https://df.zweistein.cz/soundsense/
# Needs java: https://www.java.com/en/download/
unzip soundSense_2016-1_196.zip -d build

# Should be standard bugfixes and keybindings
./cpfixes.sh

# This is my personal customizations
# Copy custom content (settings, blueprints, etc) to df
# Need to copy over dwarftherapist.ini using
# DT's "Open data directory" option under File
# Also import grid views and custom professions
./cpcustom.sh