/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_terminal_art.gsc
********************************************************/

// _createart generated.modify at your own risk. Changing values should be fine.
main() {

  level.tweakfile = true;

  //* Fog section * 

  setDevDvar("scr_fog_disable", "0");

  setExpFog(581.8, 15447.9, 0.425054, 0.467361, 0.489628, 0.579678, 0);
  VisionSetNaked("mp_terminal", 0);

}