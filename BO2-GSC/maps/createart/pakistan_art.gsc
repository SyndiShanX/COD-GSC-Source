/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\pakistan_art.gsc
*******************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  setDvar("r_rimIntensity_debug", 1);
  setDvar("r_rimIntensity", 15);
  visionsetnaked("sp_pakistan_default", 2);
}

set_water_dvars_flatten_surface() {
  setDvar("r_waterwaveamplitude", "0 0 0 0");
}

turn_on_claw_vision() {
  level.vision_set_preclaw = level.player getvisionsetnaked();
  level.player visionsetnaked("claw_base", 0);
}

turn_off_claw_vision() {
  if(!isDefined(level.vision_set_preclaw))
    level.vision_set_preclaw = "default";

  level.player visionsetnaked(level.vision_set_preclaw, 0);
}

alley() {
  setDvar("r_rimIntensity_debug", 1);
  setDvar("r_rimIntensity", 8);
  visionsetnaked("sp_pakistan_default", 2);
}

drone_stealth() {
  setDvar("r_rimIntensity_debug", 1);
  setDvar("r_rimIntensity", 8);
  visionsetnaked("sp_pakistan_default", 2);
}

bank() {
  setDvar("r_rimIntensity_debug", 1);
  setDvar("r_rimIntensity", 8);
  visionsetnaked("sp_pakistan_default", 2);
}

sewer() {
  setDvar("r_rimIntensity_debug", 1);
  setDvar("r_rimIntensity", 8);
  visionsetnaked("sp_pakistan_default", 2);
}