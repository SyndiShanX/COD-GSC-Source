/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\ber3_amb.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;

main() {
  declareAmbientPackage("ber3_outdoors_pkg");
  declareAmbientPackage("ber3_stone_room_pkg");
  declareAmbientPackage("ber3_wood_room_pkg");
  declareAmbientPackage("ber3_rodent_pkg");
  declareAmbientPackage("ber3_large_tunnel_pkg");
  declareAmbientPackage("ber3_small_tunnel_pkg");
  declareAmbientRoom("ber3_outdoors_room");
  setAmbientRoomReverb("ber3_outdoors_room", "auditorium", 1, 0.3);
  declareAmbientRoom("ber3_hallway_room");
  declareAmbientRoom("ber3_partial_room");
  setAmbientRoomReverb("ber3_partial_room", "STONEROOM", 1, 0.3);
  declareAmbientRoom("ber3_big_room");
  declareAmbientRoom("ber3_small_tunnel");
  setAmbientRoomTone("ber3_small_tunnel", "bgt_small_tunnel");
  declareAmbientRoom("ber3_large_tunnel");
  setAmbientRoomTone("ber3_large_tunnel", "bgt_large_tunnel");
  activateAmbientPackage(0, "ber3_outdoors_pkg", 0);
  activateAmbientRoom(0, "ber3_outdoors_room", 0);
  declareMusicState("INTRO");
  musicAlias("mx_intro", 0);
  musicWaitTillDone();
  declareMusicState("WAKE_UP");
  musicAliasLoop("mx_underscore", 0, 3);
  declareMusicState("FIRST_FIGHT");
  musicAliasLoop("mx_first_fight", 0, 6);
  musicStinger("mx_first_fight_stg", 2);
  declareMusicState("POST_LIBRARY");
  musicAliasLoop("mx_underscore", 0, 6);
  declareMusicState("LAST_FIGHT");
  musicAlias("mx_last_fight", 0);
  musicAliasLoop("mx_underscore_stag", 0, 6);
  declareMusicState("STAG_DOORSTEP");
  musicAliasloop("mx_first_fight", 3, 4);
  declareMusicState("PILLAR");
  musicAlias("mx_chernov_died");
  musicAliasLoop("mx_underscore_stag", 0, 6);
  declareBusState("INTRO");
  busFadeTime(0.25);
  busVolumesExcept("music", "voice", "ui", "full_vol", 0.50);
  declareBusState("RESET");
  busFadeTime(2);
  busVolumeAll(1);
  declareBusState("PILLAR");
  busFadeTime(5);
  busVolumesExcept("music", "voice", "full_vol", "ui", 0.25);
}