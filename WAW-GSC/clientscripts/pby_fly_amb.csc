/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pby_fly_amb.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;

main() {
  declareAmbientPackage("default");

  addAmbientElement("default", "amb_metal", 1, 5, 50, 300);

  declareAmbientPackage("at_sea");

  declareAmbientRoom("default");
  setAmbientRoomTone("default", "plane_interor");
  setAmbientRoomReverb("default", "forest", 1, 1);

  declareAmbientRoom("at_sea");
  setAmbientRoomTone("at_sea", "at_sea");
  setAmbientRoomReverb("at_sea", "forest", 1, 1);

  activateAmbientRoom(0, "default", 0);
  activateAmbientPackage(0, "default", 0);

  declareMusicState("INTRO");
  musicAlias("mx_intro", 3);

  declareMusicState("MERCH_FIRST_PASS");
  musicAliasloop("mx_merch_loop_a", 0, 1);

  declareMusicState("FLAK_BURST");
  musicAlias("mx_merch_stg_a", 0);

  declareMusicState("TURNING_1");
  musicAlias("mx_turning_1", 0);

  declareMusicState("MERCH_SECOND_PASS");
  musicAliasloop("mx_merch_loop_b", 0, 4);

  declareMusicState("MERCH_LAST_PASS");
  musicAliasloop("mx_merch_loop_c", 0, 1);
  musicStinger("mx_merch_stg_c", 5);

  declareMusicState("MERCH_DONE");
  musicAlias("mx_mid_igc", 0);

  declareMusicState("ZEROS_ONE");
  musicAliasloop("mx_zeros_a", 6, 6);

  declareMusicState("LANDING");
  musicAlias("mx_landing_a", 0);

  declareMusicState("RESCUE_A");
  musicAliasloop("mx_rescue_a", 0, 2);

  declareMusicState("TAKE_OFF");
  musicAliasloop("mx_zeros_a", 6, 2);

  declareMusicState("LEVEL_END");
  musicAlias("mx_level_end", 0);

  declareBusState("SHHH_PROJECTILES");
  busFadeTime(.25);
  busVolume("projectile", 0.5);
  busVolume("music", 0.9);
  busVolume("hvy_wpn", 0.92);
  busVolume("ambience", 0.5);
}