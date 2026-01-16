/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_strike.gsc
********************************/

main() {
  maps\mp\mp_strike_precache::main();
  maps\mp\mp_strike_fx::main();
  maps\createart\mp_strike_art::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_strike");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setdvar("compassmaxrange", "1900");
  setdvar("r_specularcolorscale", "1.86");
  fix_hp_zone_5();
  thread misc_rotate_ceilingfans();
}

fix_hp_zone_5() {
  if(level.gametype == "hp") {
    var_0 = getentarray("hp_zone_5", "targetname");
    var_0[2].script_noteworthy = "neutral";
  }
}

misc_rotate_ceilingfans() {
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin", "targetname"), ::ceilingfan_rotate_custom);
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin_slow", "targetname"), ::ceilingfan_rotate_slow_custom);
  common_scripts\utility::array_thread(getentarray("me_fanceil_spin_med", "targetname"), ::ceilingfan_rotate_med_custom);
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

ceilingfan_rotate_med_custom() {
  var_0 = 150;
  var_1 = 20000;

  for (;;) {
    self rotatevelocity((0, var_0, 0), var_1);
    wait(var_1);
  }
}