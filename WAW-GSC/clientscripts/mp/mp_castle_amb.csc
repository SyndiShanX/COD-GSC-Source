/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_castle_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoor_pkg");
  declareambientpackage("wood_room_pkg");
  declareambientpackage("partial_room_pkg");
  declareambientpackage("stone_tunnel_pkg");
  declareambientpackage("under_bridge_pkg");
  declareAmbientRoom("outdoor_room");
  setAmbientRoomReverb("outdoor_room", "mountains", 1, 1);
  declareAmbientRoom("wood_room");
  setAmbientRoomTone("wood_room", "int_wind");
  setAmbientRoomReverb("wood_room", "wood_room", 1, 1);
  declareAmbientRoom("partial_room");
  setAmbientRoomTone("partial_room", "int_wind");
  setAmbientRoomReverb("partial_room", "wood_room", 1, 1);
  declareAmbientRoom("stone_tunnel_room");
  setAmbientRoomReverb("stone_tunnel_room", "stonecorridor", 1, .4);
  declareAmbientRoom("under_bridge_room");
  setAmbientRoomReverb("under_bridge_room", "stonecorridor", 1, .15);
  activateAmbientPackage(0, "outdoor_pkg", 0);
  activateAmbientRoom(0, "outdoor_room", 0);
}