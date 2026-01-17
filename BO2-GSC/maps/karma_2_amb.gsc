/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_2_amb.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_music;

main() {
  array_thread(getEntArray("advertisement", "targetname"), ::advertisements);
}

advertisements() {
  self playLoopSound("amb_" + self.script_noteworthy + "_ad");
  self waittill("damage");
  self stoploopsound();
  self playLoopSound("amb_" + self.script_noteworthy + "_damaged_ad");
}