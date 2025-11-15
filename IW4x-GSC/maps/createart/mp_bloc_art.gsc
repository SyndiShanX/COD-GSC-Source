/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_bloc_art.gsc
******************************************/

main() {
  level.tweakfile = true;



  setdvar("scr_fog_disable", "0");


  setExpFog(512, 5000, 0.501961, 0.501961, 0.45098, 0.25, 0);
  VisionSetNaked("mp_bloc", 0);
}