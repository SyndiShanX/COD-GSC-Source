/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_ffotd.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;

main_start() {
  if(getDvar(#"mapname") != "zombie_moon") {
    level.zombie_additionalprimaryweapon_machine_origin = undefined;
  }
}
main_end() {}
nazizombies_checking_for_cheats() {
  return false;
}