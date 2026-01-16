/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_convoy.gsc
********************************/

main() {
  maps\mp\mp_convoy_fx::main();
  maps\createart\mp_convoy_art::main();
  maps\mp\_load::main();
  maps\mp\mp_convoy_precache::main();
  maps\mp\_compass::setupminimap("compass_map_mp_convoy");
  game["allies"] = "marines";
  game["axis"] = "opfor";
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "desert";
  game["axis_soldiertype"] = "desert";
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("compassmaxrange", "2000");
  thread delete_botconnect_clip();
  thread misc_rotate_ceilingfans();
  fix_sab_bomb();
}

fix_sab_bomb() {
  if(level.gametype == "sab") {
    var_0 = maps\mp\gametypes\common_bomb_gameobject::getcarrybombvisuals("sab_bomb");
    var_1 = var_0[0];
    var_1.origin = (var_1.origin[0], var_1.origin[1], var_1.origin[2] - 4);
  }
}

delete_botconnect_clip() {
  for (;;) {
    var_0 = getent("ambush_botconnect_delete_on_load", "targetname");

    if(isdefined(var_0)) {
      var_0 delete();
      break;
    }

    waitframe();
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