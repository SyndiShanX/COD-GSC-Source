/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_hawkwar\mp_hawkwar.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_hawkwar\mp_hawkwar_precache::main();
  scripts\mp\maps\mp_hawkwar\gen\mp_hawkwar_art::main();
  scripts\mp\maps\mp_hawkwar\mp_hawkwar_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_hawkwar");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_tessellationFactor", 0);
  setDvar("r_umbraAccurateOcclusionThreshold", 512);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
}