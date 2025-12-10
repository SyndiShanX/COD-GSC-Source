/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_carentan_art.gsc
**********************************************/

main() {
  level.tweakfile = true;

  setdvar("scr_fog_disable", "0");

  setExpFog(500, 3500, 0.501961, 0.501961, 0.45098, 0.2, 0);
  VisionSetNaked("mp_carentan", 0);
}