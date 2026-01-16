/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_crash.gsc
********************************/

main() {
  maps\mp\mp_crash_precache::main();
  maps\mp\mp_crash_fx::main();
  maps\createart\mp_crash_art::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_crash_dlc");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  setdvar("compassmaxrange", "1600");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  thread misc_rotate_ceilingfans();
  thread knockbadpanoffwall();
}

misc_rotate_ceilingfans() {
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin", "targetname"), ::ceilingfan_rotate_custom);
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin_slow", "targetname"), ::ceilingfan_rotate_slow_custom);
}

ceilingfan_rotate_custom() {
  var_0 = 600;
  var_1 = 20000;

  for (;;) {
    self rotatevelocity((0, var_0, 0), var_1);
    wait(var_1);
  }
}

ceilingfan_rotate_slow_custom() {
  var_0 = 50;
  var_1 = 20000;

  for (;;) {
    self rotatevelocity((0, var_0, 0), var_1);
    wait(var_1);
  }
}

knockbadpanoffwall() {
  for (;;) {
    level waittill("connected", var_0);

    if(isbot(var_0)) {
      continue;
    }
    thread delayimpulsepot();
  }
}

delayimpulsepot() {
  level notify("delayImpulsePot");
  level endon("delayImpulsePot");
  wait 1;
  physicsjitter((1597, 835, 216), 1, 0, 100, 100);
}