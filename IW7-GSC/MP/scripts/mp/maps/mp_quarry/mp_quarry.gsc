/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_quarry\mp_quarry.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_quarry\mp_quarry_precache::main();
  scripts\mp\maps\mp_quarry\gen\mp_quarry_art::main();
  scripts\mp\maps\mp_quarry\mp_quarry_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_quarry");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_tessellationCutoffDistance", 2200);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread scripts\mp\animation_suite::animationsuite();
  level thread _id_CDA4("mp_quarry_kotch");
}

_id_CDA4(var_0) {
  level scripts\engine\utility::waittill_either("allRigsBooted", "prematch_done");
  playcinematicforalllooping(var_0);
}