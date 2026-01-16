/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_2_amb.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_music;

main() {
  array_thread(getentarray("advertisement", "targetname"), ::advertisements);
}

advertisements() {
  self playloopsound("amb_" + self.script_noteworthy + "_ad");
  self waittill("damage");
  self stoploopsound();
  self playloopsound("amb_" + self.script_noteworthy + "_damaged_ad");
}