/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_sidemission_tundra.csc
***********************************************/

#using script_4cf7b14ad21db4a0;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace cp_sidemission_tundra;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  callback::on_spawned(&on_spawned);
  load::main();
  util::waitforclient(0);
  spy_camera::function_cd91501d(70000);
}

function on_spawned(localclientnum) {
  self endon(#"death", #"disconnect");
  waitframe(1);
  weapons = [];
  weapons[weapons.size] = getweapon(#"tr_longburst_t9", "scope3x", "stalker2", "quickdraw2");
  self thread util::force_stream_weapons(localclientnum, weapons);
  forcestreamxmodel("c_t9_cp_rus_soviet_army_rudnik_body");
  forcestreamxmodel("c_t9_cp_rus_soviet_army_rudnik_head");
}