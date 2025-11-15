/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\frontend_art.gsc
*******************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  level.tweakfile = 1;
  setdvar("r_rimIntensity_debug", 1);
  setdvar("r_rimIntensity", 15);
  flag_wait("level.player");
  level.do_not_use_dof = 1;
}

dof_frontend() {
}

run_war_room_mixers() {
  clientnotify("dim_cic_lights");
  clientnotify("holo_table_flicker");
  setdvar("r_exposureTweak", 1);
  level thread lerp_dvar("r_exposureValue", 3.75, 0.1);
  level waittill("frontend_reset_mixers");
  level thread lerp_dvar("r_exposureValue", 2.5, 0.1);
  setdvar("r_exposureTweak", 0);
  clientnotify("dim_cic_lights");
  clientnotify("holo_table_flicker");
}