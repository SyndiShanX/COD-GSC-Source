/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_permafrost2\mp_permafrost2.gsc
*************************************************************/

main() {
  scripts\mp\maps\mp_permafrost2\mp_permafrost2_precache::main();
  scripts\mp\maps\mp_permafrost2\gen\mp_permafrost2_art::main();
  scripts\mp\maps\mp_permafrost2\mp_permafrost2_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_permafrost2");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("sm_sunSampleSizeNear", 0.55);
  setDvar("r_tessellationFactor", 40);
  setDvar("r_tessellationCutoffFalloff", 256);
  setDvar("r_tessellationCutoffDistance", 800);
  setDvar("r_umbraAccurateOcclusionThreshold", 700);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread runmodespecifictriggers();
  thread _id_CDA4("mp_overflow_screen");
}

runmodespecifictriggers() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    wait 1;
    var_0 = spawn("trigger_radius", (-1386, -154, 692), 0, 46, 128);
    var_0.targetname = "uplink_nozone";
    var_0 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_0;
    var_1 = spawn("trigger_radius", (1416, 56, 432), 0, 32, 128);
    var_1.targetname = "uplink_nozone";
    var_1 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_1;
  }
}

_id_CDA4(var_0) {
  wait 30;
  playcinematicforalllooping(var_0);
}