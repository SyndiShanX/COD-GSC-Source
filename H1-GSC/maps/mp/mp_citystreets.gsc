/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_citystreets.gsc
********************************/

main() {
  maps\mp\mp_citystreets_precache::main();
  maps\mp\mp_citystreets_fx::main();
  maps\createart\mp_citystreets_art::main();
  maps\mp\_load::main();
  maps\mp\_compass::setupminimap("compass_map_mp_citystreets");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  game["allies_soldiertype"] = "desert";
  game["axis_soldiertype"] = "desert";
  setdvar("compassmaxrange", "2000");
  maps\mp\_explosive_barrels::main();
  thread misc_rotate_ceilingfans();
  level.oldschoolfxtype = "bright";
  maps\mp\_utility::hardpointtriggerswap((2477, -937, 32), "patch_hp_zone_trigger_3");
  maps\mp\_utility::headquarterstriggerswap((2477, -937, 32), "patch_hq_zone_trigger_1");

  if(level.gametype == "ctf")
    maps\mp\gametypes\ctf::setflagbasefx("vfx\unique\vfx_marker_ctf", "vfx\unique\vfx_marker_ctf_red_mid");
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