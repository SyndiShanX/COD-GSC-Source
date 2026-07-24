/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_nova\mp_nova.gsc
***********************************************/

main() {
  scripts\mp\maps\mp_nova\mp_nova_precache::main();
  scripts\mp\maps\mp_nova\gen\mp_nova_art::main();
  scripts\mp\maps\mp_nova\mp_nova_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_nova");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraaccurateocclusionthreshold", 450);
  setDvar("r_tessellation", 0);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
}