/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_amb.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_music;

main() {
  level thread bunker_music_watcher();
}

bunker_music_watcher() {
  level waittill_any("bunker_1stroom_alerted", "bunker_2ndroom_alerted");
  setmusicstate("NIC_RAID_BUNKER_ALERTED");
}