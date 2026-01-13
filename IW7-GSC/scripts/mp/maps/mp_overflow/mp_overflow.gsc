/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_overflow\mp_overflow.gsc
*******************************************************/

main() {
  scripts\mp\maps\mp_overflow\mp_overflow_precache::main();
  scripts\mp\maps\mp_overflow\gen\mp_overflow_art::main();
  scripts\mp\maps\mp_overflow\mp_overflow_fx::main();
  scripts\mp\load::main();
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_overflow");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("sm_sunSampleSizeNear", 0.55);
  setdvar("r_tessellationFactor", 40);
  setdvar("r_tessellationCutoffFalloff", 256);
  setdvar("r_tessellationCutoffDistance", 800);
  setdvar("r_umbraAccurateOcclusionThreshold", 700);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread runmodespecifictriggers();
  thread func_CDA4("mp_overflow_screen");
}

runmodespecifictriggers() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    wait(1);
    var_0 = spawn("trigger_radius", (-1386, -154, 692), 0, 46, 128);
    var_0.var_336 = "uplink_nozone";
    var_0 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_0;
    var_1 = spawn("trigger_radius", (1416, 56, 432), 0, 32, 128);
    var_1.var_336 = "uplink_nozone";
    var_1 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_1;
  }
}

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
}