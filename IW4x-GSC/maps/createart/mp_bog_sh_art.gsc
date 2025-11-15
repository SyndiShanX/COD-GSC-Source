/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_bog_sh_art.gsc
********************************************/

main() {
  level.tweakfile = true;



  setdvar("scr_fog_disable", "0");

  setExpFog(1580.28, 6000.05, 0.544852, 0.394025, 0.21177, 0.3, 0);

  VisionSetNaked("mp_bog_sh", 0);
}