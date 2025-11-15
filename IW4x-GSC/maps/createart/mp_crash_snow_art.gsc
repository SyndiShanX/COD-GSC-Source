/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\mp_crash_snow_art.gsc
************************************************/

main() {
  level.tweakfile = true;



  setdvar("scr_fog_disable", "0");

  setExpFog(107.592, 2009.78, 0.260505, 0.264527, 0.308905, 1.0, 0);
  VisionSetNaked("mp_crash_snow", 0);
}