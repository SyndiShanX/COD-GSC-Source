/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_farm_art.gsc
******************************************/

main() {
  level.tweakfile = true;

  setdvar("scr_fog_disable", "0");

  setExpFog(300, 1400, 0.36, 0.35, 0.4, 1.0, 0);
  VisionSetNaked("mp_farm", 0);
}