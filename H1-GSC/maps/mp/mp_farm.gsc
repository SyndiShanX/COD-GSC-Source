/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_farm.gsc
********************************/

main() {
  maps\mp\mp_farm_precache::main();
  maps\mp\mp_farm_fx::main();
  maps\createart\mp_farm_art::main();
  maps\mp\_load::main();
  maps\mp\_water::init();
  maps\mp\_compass::setupminimap("compass_map_mp_farm");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_soldiertype"] = "woodland";
  game["axis_soldiertype"] = "woodland";
  setdvar("compassmaxrange", "2000");
  maps\mp\_fx_trigger::main();
  level replace_turrets();
  level.dd_flip_respawns = 1;
}

replace_turrets() {
  var_0 = getentarray("misc_turret", "classname");

  foreach(var_2 in var_0) {
    var_3 = var_2.origin;
    var_4 = var_2.angles;
    var_2 delete();
    var_5 = spawnturret("misc_turret", var_3, "saw_bipod_stand_mp", 0);
    var_5 setmodel("weapon_saw_MG_setup");
    var_5.angles = var_4;
  }
}