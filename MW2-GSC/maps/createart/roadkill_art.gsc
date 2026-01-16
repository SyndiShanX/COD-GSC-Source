/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\roadkill_art.gsc
********************************************************/

// _createart generated.modify at your own risk. Changing values should be fine.
main() {

  level.tweakfile = true;

  //* Fog section * 

  setDevDvar("scr_fog_disable", "0");

  setExpFog(639.671, 14192, 0.356863, 0.423, 0.505, 0.69, 0);
  maps\_utility::set_vision_set("roadkill", 0);

}