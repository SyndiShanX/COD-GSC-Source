/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_bloc_sh_art.gsc
*********************************************/

main() {
  level.tweakfile = true;

  setdvar("scr_fog_disable", "0");

  setExpFog(1000, 5000, 0.631961, 0.501961, 0.3098, 0.07, 0);
  VisionSetNaked("mp_bloc_sh", 0);
}