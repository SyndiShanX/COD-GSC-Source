/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_seelow_amb.csc
**********************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("outdoors_pkg");

  declareAmbientPackage("indoors_pkg");

  declareAmbientPackage("indoors2_pkg");

  declareAmbientPackage("bridge_pkg");

  declareAmbientPackage("shed_pkg");

  declareAmbientPackage("tunnel_pkg");

  declareAmbientPackage("underhill_pkg");

  declareAmbientRoom("outdoors_room");
  setAmbientRoomTone("outdoors_room", "outdoors_wind");
  setAmbientRoomReverb("outdoors_room", "mountains", 1, 1);

  declareAmbientRoom("indoors_room");
  setAmbientRoomReverb("indoors_room", "mediumroom", 1, 1);

  declareAmbientRoom("indoors2_room");
  setAmbientRoomReverb("indoors2_room", "mediumroom", 1, 1);

  declareAmbientRoom("bridge_room");
  setAmbientRoomReverb("bridge_room", "under_bridge", 1, 1);

  declareAmbientRoom("shed_room");
  setAmbientRoomReverb("shed_room", "wooden_structure", 1, 1);

  declareAmbientRoom("tunnel_room");
  setAmbientRoomTone("tunnel_room", "pipe_tone");
  setAmbientRoomReverb("tunnel_room", "sewerpipe", 1, .9);

  declareAmbientRoom("underhill_room");
  setAmbientRoomTone("underhill_room", "underhill_tone");
  setAmbientRoomReverb("underhill_room", "dirt_tunnel", 1, 1);

  activateAmbientPackage(0, "outdoors_pkg", 0);
  activateAmbientRoom(0, "outdoors_room", 0);
}