/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_storm_spring_art.gsc
**************************************************/

// _createart generated.modify at your own risk. Changing values should be fine.
main() {

  level.tweakfile = true;

  //* Fog section * 

  setdevdvar("scr_fog_disable", "0");

  setExpFog(2500, 4000, 0.6, 0.67, 0.74, 0.486854, 0);
  VisionSetNaked("mp_storm_spring", 0);

}