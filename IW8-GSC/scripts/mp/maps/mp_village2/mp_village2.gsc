/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_village2\mp_village2.gsc
*******************************************************/

function main() {
  scripts\mp\trials\mp_trl_cleararea::keypad_check_levelinput();
  scripts\mp\maps\mp_village2\mp_village2_precache::main();
  scripts\mp\maps\mp_village2\gen\mp_village2_art::main();
  scripts\mp\maps\mp_village2\mp_village2_fx::main();
  scripts\mp\maps\mp_village2\mp_village2_lighting::main();
  level.ref_13d50 = 1;
  level._effect["vehicle_explosion2"] = loadfx("vfx/iw8_mp/vehicle/vfx_jeep_mp_death_exp.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_explosion_atv.vfx");
  level._effect["vehicle_fire"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_fire_linger.vfx");
  level._effect["vehicle_bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["barrel_explosion1"] = loadfx("vfx/iw8/prop/scriptables/vfx_red_barrel_exp.vfx");
  level._effect["barrel_explosion2"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["barrel_flame_small"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire_sm.vfx");
  level._effect["barrel_fire"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire.vfx");
  level._effect["nuke_rolling_death"] = loadfx("vfx/iw8_mp/killstreak/vfx_nuke_player_death_2.vfx");
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_village2", "codcaster_compass_map_mp_village2");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  level.music_style = "eastern_europe";
  thread player_fired_gun_monitor();
}

function player_fired_gun_monitor() {
  var0 = getEnt("clip256x256x256", "targetname");
  var1 = spawn("script_model", (-552, 3480, 296));
  var1.angles = (0, 29.9999, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("clip128x128x128", "targetname");
  var3 = spawn("script_model", (984, 3872, 312));
  var3.angles = (0, 0, 0);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = getEnt("clip256x256x256", "targetname");
  var5 = spawn("script_model", (1176, 3768, 224));
  var5.angles = (0, 0, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var6 = getEnt("clip256x256x256", "targetname");
  var7 = spawn("script_model", (1176, 3848, 184));
  var7.angles = (0, 0, 0);
  var7 clonebrushmodeltoscriptmodel(var6);
  var8 = getEnt("player512x512x8", "targetname");
  var9 = spawn("script_model", (1328, -1568, 888));
  var9.angles = (270, 222.604, -177.604);
  var9 clonebrushmodeltoscriptmodel(var8);
}