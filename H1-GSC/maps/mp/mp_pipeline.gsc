/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_pipeline.gsc
********************************/

main() {
  maps\mp\mp_pipeline_precache::main();
  maps\mp\mp_pipeline_fx::main();
  maps\createart\mp_pipeline_art::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_pipeline");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setdvar("r_specularcolorscale", "1");
  setdvar("r_glowbloomintensity0", ".1");
  setdvar("r_glowbloomintensity1", ".1");
  setdvar("r_glowskybleedintensity0", ".1");
  setdvar("compassmaxrange", "2200");
  thread delete_botconnect_clip();
  thread misc_rotate_ceilingfans();
  level replace_turrets();
  fix_sab_bomb();
  maps\mp\_utility::hardpointtriggerswap((132, 3704, 64), "patch_hp_zone_trigger_2");
}

fix_sab_bomb() {
  if(level.gametype == "sab") {
    var_0 = maps\mp\gametypes\common_bomb_gameobject::getcarrybombvisuals("sab_bomb");
    var_1 = var_0[0];
    var_1.origin = (var_1.origin[0], var_1.origin[1], var_1.origin[2] + 7.5);
  }
}

replace_turrets() {
  var_0 = getentarray("misc_turret", "classname");

  foreach(var_2 in var_0) {
    var_3 = var_2.origin;
    var_4 = var_2.angles;
    var_2 delete();
    var_5 = spawnturret("misc_turret", var_3, "saw_bipod_crouch_mp", 0);
    var_5 setmodel("weapon_saw_MG_setup");
    var_5.angles = var_4;
  }
}

delete_botconnect_clip() {
  for (;;) {
    var_0 = getent("botconnect_delete_on_load", "targetname");

    if(isdefined(var_0)) {
      var_0 delete();
      break;
    }

    waitframe();
  }
}

misc_rotate_ceilingfans() {
  common_scripts\utility::array_thread(getentarray("fan_spin", "targetname"), ::ceilingfan_rotate_custom);
  common_scripts\utility::array_thread(getentarray("fan_spin_slow", "targetname"), ::ceilingfan_rotate_slow_custom);
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