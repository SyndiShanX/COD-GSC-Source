/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_pipeline_art.gsc
**********************************************/

main() {
  level.tweakfile = true;

  setdvar("scr_fog_disable", "0");

  setExpFog(700, 3548, 0.33086, 0.33086, 0.33086, 1.0, 0);
  VisionSetNaked("mp_pipeline", 0);
}