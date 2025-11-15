/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\monsoon_amb.gsc
**************************************/

#include maps\_music;
#include maps\_utility;
#include common_scripts\utility;

main() {
  level thread flag_watch_base();
  level thread music_for_swing();
}

flag_watch_base() {
  wait 0.5;
  level waittill("ruins_stealth_over");
  setmusicstate("MONSOON_BATTLE_1");
}

music_for_swing() {
  level waittill("bpgm");
  setmusicstate("MONSOON_SWING");
}