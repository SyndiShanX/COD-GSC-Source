/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber3_amb.gsc
*****************************************************/

#include maps\_utility;
#include maps\_ambientpackage;
#include maps\_music;

main() {
  declareAmbientPackage("ber3_outdoors_pkg");
  declareAmbientPackage("ber3_stone_room_pkg");
  declareAmbientPackage("ber3_wood_room_pkg");
  declareAmbientPackage("ber3_rodent_pkg");
  addAmbientElement("ber3_rodent_pkg", "amb_rodents", 5, 35, 100, 500);
  declareAmbientPackage("ber3_large_tunnel_pkg");
  addAmbientElement("ber3_large_tunnel_pkg", "amb_water_drips", 0.05, 0.8, 10, 100);
  declareAmbientPackage("ber3_small_tunnel_pkg");
  declareAmbientRoom("ber3_outdoors_room");
  setAmbientRoomReverb("ber3_outdoors_room", "Ber1", 1, 1);
  declareAmbientRoom("ber3_hallway_room");
  setAmbientRoomTone("ber3_hallway_room", "train_station_wind");
  declareAmbientRoom("ber3_partial_room");
  setAmbientRoomTone("ber3_partial_room", "partial_room_wind");
  declareAmbientRoom("ber3_big_room");
  setAmbientRoomTone("ber3_big_room", "train_station_wind");
  declareAmbientRoom("ber3_small_tunnel");
  setAmbientRoomTone("ber3_small_tunnel", "bgt_small_tunnel");
  declareAmbientRoom("ber3_large_tunnel");
  setAmbientRoomTone("ber3_large_tunnel", "bgt_large_tunnel");
  activateAmbientPackage("ber3_outdoors_pkg", 0);
  activateAmbientRoom("ber3_outdoors_room", 0);
  level thread battle_cry();
  level thread battle_cry2();
}

battle_cry() {
  level waittill("battle_cry");
  yell = getent("battle_cry", "targetname");
  playsoundatposition("See1_IGD_700A_RURS", yell.origin);
}

battle_cry2() {
  level waittill("pwn_joyal");
  yell = getent("battle_cry", "targetname");
  playsoundatposition("See1_IGD_700A_RURS", yell.origin);
}