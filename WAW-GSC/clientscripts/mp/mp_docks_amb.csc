/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\mp_docks_amb.csc
*****************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

main() {
  declareAmbientPackage("default_pkg");
  declareAmbientPackage("rain_package");
  declareAmbientPackage("rain_out_package");
  declareAmbientPackage("sub_package");
  declareAmbientRoom("default_room");
  setAmbientRoomReverb("default_room", "cave", 1, 1);
  declareAmbientRoom("rain_room");
  setAmbientRoomReverb("rain_room", "cave", 1, 1);
  setAmbientRoomTone("rain_room", "helmetrainf");
  declareAmbientRoom("rain_out_room");
  setAmbientRoomReverb("rain_out_room", "mountains", 1, 1);
  setAmbientRoomTone("rain_out_room", "helmetrainf_2");
  declareAmbientRoom("sub_room");
  setAmbientRoomReverb("sub_room", "sewerpipe", 1, 0.5);
  activateAmbientPackage(0, "default_pkg", 0);
  activateAmbientRoom(0, "default_room", 0);
  array_thread(getstructarray("lightning", "targetname"), ::lightning_audio);
}

lightning_audio() {
  while(1) {
    wait(randomintrange(45, 120));
    {
      playFX(0, level._effect["mp_lightning_flash"], self.origin);
      playSound(0, "thunder", self.origin);
    }
  }
}