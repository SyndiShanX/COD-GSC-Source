/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\createart\arcadia_art.gsc
********************************************************/

main() {
  level.tweakfile = true;

  setDevDvar("scr_fog_disable", "0");

  setExpFog(7486.81, 54493.6, 1, 0.835294, 0.698039, 1, 0, 0.230599, 0.131324, 0.0576405, (0.359908, -1, 0), 38.2866, 180, 8.46814);
  maps\_utility::set_vision_set("arcadia", 0);
}