/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
    var_00 = spawn("trigger_radius", (-1386, -154, 692), 0, 46, 128);
    var_00.var_336 = "uplink_nozone";
    var_00 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_00;
    var_01 = spawn("trigger_radius", (1416, 56, 432), 0, 32, 128);
    var_01.var_336 = "uplink_nozone";
    var_01 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_01;
  }
}

func_CDA4(param_00) {
  wait(30);
  playcinematicforalllooping(param_00);
}