/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_la_amb.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\_ambientpackage;

main() {
  array_thread(getEntArray("advertisement", "targetname"), ::advertisements);
}

advertisements() {
  self playLoopSound("amb_" + self.script_noteworthy + "_ad");
  self waittill("damage");
  self stoploopsound();
  self playLoopSound("amb_" + self.script_noteworthy + "_damaged_ad");
}