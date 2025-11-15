/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\sniper_amb.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;

main() {
  declareAmbientPackage("outdoors_pkg");
  addAmbientElement("outdoors_pkg", "amb_flies", 15, 45, 250, 700);
  declareAmbientRoom("outdoors_room");
  setAmbientRoomTone("outdoors_room", "bgt_wind");
  setAmbientRoomReverb("outdoors_room", "city_high_reflections", 1, 1);
  declareAmbientRoom("sniper_city_fountain");
  setAmbientRoomReverb("sniper_city_fountain", "city_high_reflections", 1, 1);
  declareAmbientRoom("sniper_wood_interior");
  setAmbientRoomTone("sniper_wood_interior", "bgt_wind");
  setAmbientRoomReverb("sniper_wood_interior", "padded_cell", 1, 1);
  declareAmbientRoom("sniper_city_street");
  setAmbientRoomTone("sniper_city_street", "bgt_wind");
  setAmbientRoomReverb("sniper_city_street", "city_alley", 1, 1);
  declareAmbientRoom("sniper_stone_room");
  setAmbientRoomTone("sniper_stone_room", "bgt_wind");
  setAmbientRoomReverb("sniper_stone_room", "stoneroom", 1, 0.75);
  declareAmbientPackage("outdoors_room");
  addAmbientElement("outdoors_room", "amb_raven_dist", 10, 20, 800, 2500);
  declareAmbientPackage("sniper_wood_interior");
  declareAmbientPackage("sniper_city_street");
  addAmbientElement("sniper_city_street", "amb_raven_dist", 4, 8, 500, 1800);
  declareAmbientPackage("sniper_stone_room");
  declareAmbientPackage("sniper_city_fountain");
  addAmbientElement("sniper_city_fountain", "amb_raven_dist", 10, 20, 400, 2500);
  activateAmbientRoom(0, "outdoors_room", 0);
  activateAmbientPackage(0, "outdoors_pkg", 0);
  declareMusicState("INTRO");
  musicAlias("mx_fountain", 0);
  musicWaitTillDone();
  declareMusicState("BOMBERS");
  musicAliasloop("mx_underscore", 0, 4);
  declareMusicState("DOG");
  musicAlias("mx_dogs_stg", 1);
  declareMusicState("DOG_KILLED");
  musicAliasloop("mx_underscore", 4, 4);
  declareMusicState("STORY");
  musicAlias("mx_run_run_run", 2);
  musicAliasloop("mx_underscore_amb", 2, 2);
  musicStinger("mx_pre_sniper_stg", 0);
  declareMusicState("SNIPER");
  musicAliasloop("mx_sniper_loop", 0, 2);
  musicStinger("mx_post_sniper_stg", 0);
  musicWaitTillDone();
  declareMusicState("SNIPER_DEAD");
  musicAliasloop("mx_underscore_amb", 2, 2);
  musicStinger("mx_dog_fire_intro", 14);
  musicWaitTillDone();
  declareMusicState("FIRE");
  musicAliasloop("mx_dog_loop_a", 0, 2);
  musicStinger("mx_dog_fire_celing_stg", 12);
  declareMusicState("CELING");
  musicAliasloop("mx_dog_loop_b", 0, 4);
  musicStinger("mx_dog_fire_exp_stg", 20);
  musicWaitTillDone();
  declareMusicState("EXPLOSION");
  musicAliasloop("mx_underscore", 3, 6);
  declareMusicState("PRE_SNIPE_FLAMEGUY");
  musicAliasloop("mx_stress_loop", 4, 2);
  declareMusicState("LAST_BATTLE_PHASE_1");
  musicAliasloop("mx_dog_fire_long_loop", 0, 1);
  musicStinger("mx_dog_fire_long_stg", 1);
  declareMusicState("CLEAR_ESCAPE");
  musicAliasloop("mx_underscore_amb", 4, 2);
  declareMusicState("SURPRISED_AGAIN");
  musicAliasloop("mx_underscore_amb", 4, 2);
  declareMusicState("VANTAGE_POINT");
  musicAlias("mx_post_outdoor_battle", 4);
  declareMusicState("AMSEL_IS_DOOMED");
  musicAliasloop("mx_general_dead_loop", 4, 2);
  declareMusicState("AMSEL_IS_DEAD");
  musicAlias("mx_general_dead_stg", 0);
  declareMusicState("CHASE");
  musicAliasloop("mx_end_chase", 0, 4);
  declareMusicState("ENDLEVEL");
  musicAlias("mx_sniper_end", 0);
  declareMusicState("BROKE_STEALTH");
  musicAliasloop("mx_sniper_loop", 0, 3);
  declareMusicState("SURVIVED_BROKEN_STEALTH");
  musicAliasloop("mx_underscore", 3, 6);
  declareBusState("intro");
  busFadeTime(.1);
  busvolume("rfl_1st", 0.75);
  busvolume("decay", 0.5);
  busvolume("vehicle", 0.4);
  declareBusState("return_default");
  busFadeTime(2);
  busVolumeAll(1);
  thread set_intro_bus();
  thread set_postintro_bus();
}

set_intro_bus() {
  level waittill("INTRO_BUS");
  setbusstate("intro");
}

set_postintro_bus() {
  level waittill("POST_INTRO_BUS");
  setbusstate("return_default");
}