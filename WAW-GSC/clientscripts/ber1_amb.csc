/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\ber1_amb.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;
#include clientscripts\_busing;

main() {
  declareAmbientPackage("ber1_outdoors_pkg");
  addAmbientElement("ber1_outdoors_pkg", "amb_stone_small", 10, 20, 100, 500);
  addAmbientElement("ber1_outdoors_pkg", "amb_stone_med", 10, 20, 100, 500);
  addAmbientElement("ber1_outdoors_pkg", "bomb_far", 2, 15, 10, 200);
  declareAmbientPackage("ber1_stone_room_pkg");
  addAmbientElement("ber1_stone_room_pkg", "amb_stone_small", 10, 20, 100, 200);
  addAmbientElement("ber1_stone_room_pkg", "bomb_far", 2, 15, 10, 200);
  addAmbientElement("ber1_stone_room_pkg", "bomb_medium", 15, 30, 100, 500);
  declareAmbientPackage("ber1_wood_room_pkg");
  addAmbientElement("ber1_wood_room_pkg", "amb_wood_small", 10, 20, 100, 200);
  addAmbientElement("ber1_wood_room_pkg", "amb_wood_boards", 20, 40, 100, 500);
  addAmbientElement("ber1_wood_room_pkg", "amb_wood_creak", 20, 40, 100, 500);
  addAmbientElement("ber1_wood_room_pkg", "bomb_far", 2, 15, 10, 200);
  addAmbientElement("ber1_wood_room_pkg", "bomb_medium", 15, 30, 100, 500);
  declareAmbientPackage("ber1_asylum_pkg");
  addAmbientElement("ber1_asylum_pkg", "amb_rodents", 5, 35, 100, 500);
  addAmbientElement("ber1_asylum_pkg", "amb_spooky_2d", 5, 12, 100, 500);
  declareAmbientPackage("ber1_asylum_entrance");
  declareAmbientPackage("ber1_train_station_pkg");
  addAmbientElement("ber1_train_station_pkg", "amb_water_drips", 0.05, 0.8, 10, 100);
  declareAmbientRoom("ber1_outdoors_room");
  setAmbientRoomReverb("ber1_outdoors_room", "CITY", 1, 1);
  declareAmbientRoom("ber1_closed_room");
  setAmbientRoomTone("ber1_closed_room", "closed_room_wind");
  setAmbientRoomReverb("ber1_outdoors_room", "wooden_structure", 1, 1);
  declareAmbientRoom("ber1_partial_room");
  setAmbientRoomTone("ber1_partial_room", "partial_room_wind");
  setAmbientRoomReverb("ber1_outdoors_room", "wooden_structure", 1, 1);
  declareAmbientRoom("ber1_asylum");
  setAmbientRoomReverb("ber1_asylum", "HALLWAY", 1, 1);
  declareAmbientRoom("ber1_asylum_entrance");
  setAmbientRoomReverb("ber1_asylum_entrance", "stonecorridor", 1, 1);
  declareAmbientRoom("ber1_asylum_bathroom");
  setAmbientRoomReverb("ber1_asylum_bathroom", "BATHROOM", 1, 1);
  declareAmbientRoom("ber1_train_station");
  setAmbientRoomTone("ber1_train_station", "train_station_wind");
  activateAmbientPackage(0, "ber1_outdoors_pkg", 0);
  activateAmbientRoom(0, "ber1_outdoors_room", 0);
  declareMusicState("INTRO");
  musicAlias("mx_intro", 3);
  declareMusicState("FIRST_FIGHT");
  musicAliasloop("mx_burst_loop", 0, 20);
  musicStinger("mx_tank_stg", 30);
  declareMusicState("TANK_ROLLS_IN");
  musicAliasloop("mx_underscore", 0, 4);
  musicStinger("mx_tank_destroyed", 3);
  declareMusicState("TANK_HIT");
  musicAliasloop("mx_burst_drum_loop", 0, 6);
  declareMusicState("ASYLUM");
  musicAliasloop("mx_asylum", 6, 6);
  declareMusicState("FINAL_PUSH");
  musicAlias("mx_final_push", 0);
  thread train_ride();
  thread train_quake();
  thread house_collapse();
  thread tank_wall_sound();
  declarebusstate("STREET");
  busFadeTime(6);
  busVolumesExcept("music", "voice", "ui", "explosion", "full_vol", 0.50);
  declarebusstate("LEVEL_END");
  busFadeTime(4);
  busVolumesExcept("music", "voice", "ui", "smg_1st", "rfe_1st", "pis_1st", "hvy_wpn", 0.25);
  busVolume("explosion", 0.75);
  busVolume("hvy_wpn", 0.50);
}

train_ride() {
  level waittill("train_ride");
  rleft = getstruct("train_rear_left", "targetname");
  rright = getstruct("train_rear_right", "targetname");
  fleft = getstruct("train_front_left", "targetname");
  fright = getstruct("train_front_right", "targetname");
  fcenter = getstruct("train_front_center", "targetname");
  playSound(0, "train_rear_left", rleft.origin);
  playSound(0, "train_rear_right", rright.origin);
  playSound(0, "train_front_left", fleft.origin);
  playSound(0, "train_front_right", fright.origin);
  playSound(0, "train_front_center", fcenter.origin);
}

train_quake() {
  level waittill("train_quake");
  playSound(0, "train_shake_front", (0, 0, 0));
}

elec_loop() {
  level waittill("elec_loop");
  loop1 = getstruct("elec_loop1", "targetname");
  loop2 = getstruct("elec_loop2", "targetname");
  clientscripts\_audio::playloopat(0, "elec_loop", loop1.origin, 0);
  clientscripts\_audio::playloopat(0, "elec_loop2", loop2.origin, 0);
}

house_collapse() {
  level waittill("house1_collapse");
  roof = getstruct("introhouse_fx", "targetname");
  playSound(0, "building_collapse2", roof.origin);
}

fake_battle() {
  level waittill("train_ride");
  ber1_fake_battle1 = getstruct("fake_battle1", "targetname");
  ber1_fake_battle2 = getstruct("fake_battle2", "targetname");
  e1 = clientscripts\_audio::playloopat(0, "fake_battle1", ber1_fake_battle1.origin);
  e2 = clientscripts\_audio::playloopat(0, "fake_battle2", ber1_fake_battle2.origin);
  level waittill("fake_battle_done");
  deletefakeent(0, e1);
  deletefakeent(0, e2);
}

tank_wall_sound() {
  level waittill("tank_wall_sound");
  wall = getstruct("tank_wall_sound", "targetname");
  playSound(0, "grenade_explode", wall.origin);
  playSound(0, "grenade_explode_brick", wall.origin);
  wait 1;
  playSound(0, "tank_wall_sound", wall.origin);
}