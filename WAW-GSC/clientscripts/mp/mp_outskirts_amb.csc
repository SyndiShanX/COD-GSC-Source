/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_outskirts_amb.csc
*************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoors_pkg");

  declareAmbientPackage("indoors_pkg");

  declareAmbientPackage("indoors2_pkg");

  declareAmbientPackage("small_pkg");

  declareAmbientPackage("tunnel_pkg");

  declareAmbientRoom("outdoors_room");
  setAmbientRoomTone("outdoors_room", "outdoors_wind");
  setAmbientRoomReverb("outdoors_room", "mountains", 1, 1);

  declareAmbientRoom("indoors_room");
  setAmbientRoomReverb("indoors_room", "wood_room", 1, 1);

  declareAmbientRoom("indoors2_room");
  setAmbientRoomReverb("indoors2_room", "partial_room", 1, 1);

  declareAmbientRoom("small_room");
  setAmbientRoomReverb("small_room", "hallway", 1, 1);

  declareAmbientRoom("tunnel_room");
  setAmbientRoomTone("tunnel_room", "tunnel_tone");
  setAmbientRoomReverb("tunnel_room", "stonecorridor", 1, .4);

  activateAmbientPackage(0, "outdoors_pkg", 0);
  activateAmbientRoom(0, "outdoors_room", 0);
}