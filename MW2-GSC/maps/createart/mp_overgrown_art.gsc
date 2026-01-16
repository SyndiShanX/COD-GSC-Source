/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_overgrown_art.gsc
********************************************************/

// _createart generated.modify at your own risk. Changing values should be fine.
main() {

  level.tweakfile = true;

  //* Fog section * 

  setDevDvar("scr_fog_disable", "0");

  setExpFog(612, 4500, 0.542909, 0.580392, 0.603922, 1, 0);
  VisionSetNaked("mp_overgrown", 0);

}