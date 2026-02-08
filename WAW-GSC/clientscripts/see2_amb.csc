/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\see2_amb.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;

main() {
  declareAmbientPackage("see2_base_pkg");

  declareAmbientPackage("see2_interior_pkg");

  declareAmbientRoom("see2_outdoor");

  setAmbientRoomReverb("see2_outdoor", "FOREST", 1, 1);

  declareAmbientRoom("see2_interior_room");

  activateAmbientPackage(0, "see2_base_pkg", 0);
  activateAmbientRoom(0, "see2_outdoor", 0);

  declareMusicState("INTRO");
  musicAlias("mx_intro", 0);
  musicwaittilldone();

  declareMusicState("FIRST_FIGHT");
  musicAliasloop("mx_battle_loop", 0, 2);

  declareMusicState("LEVEL_END");
  musicAlias("mx_level_end", 1);

  declareBusState("TANKS");
  busFadeTime(.25);
  busVolumesExcept("music", "full_vol", "voice", "ui", "vehicle_mp", "explosion", 0.8);
}