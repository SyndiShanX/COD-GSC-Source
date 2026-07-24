/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_paris\mp_paris.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_paris\mp_paris_precache::main();
  scripts\mp\maps\mp_paris\gen\mp_paris_art::main();
  scripts\mp\maps\mp_paris\mp_paris_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_paris");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 3);
  setDvar("r_umbraAccurateOcclusionThreshold", 512);
  setDvar("r_tessellationFactor", 0);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  thread droptonavmeshtriggers();
}

droptonavmeshtriggers() {
  wait 1;
  var_0 = spawn("trigger_radius", (-469, -769, 40), 0, 70, 70);
  var_0 hide();
  level.droptonavmeshtriggers[level.droptonavmeshtriggers.size] = var_0;
}