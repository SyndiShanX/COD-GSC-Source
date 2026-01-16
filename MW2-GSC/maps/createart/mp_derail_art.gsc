/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\mp_derail_art.gsc
********************************************************/

// _createart generated.modify at your own risk. Changing values should be fine.
main() {

  level.tweakfile = true;

  //* Fog section * 

  setDevDvar("scr_fog_disable", "0");

  setExpFog(1148.54, 6581, 1, 1, 1, 0.0946854, 0);
  VisionSetNaked("mp_derail", 0);

}