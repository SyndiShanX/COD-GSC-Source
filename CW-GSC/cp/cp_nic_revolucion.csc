/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_nic_revolucion.csc
***********************************************/

#using script_26c8cfe8e27649cd;
#using script_2a51053f55890a96;
#using script_38867f943fb86135;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\cp\cp_nic_revolucion_fx;
#namespace cp_nic_revolucion;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  cp_nic_revolucion_fx::preload();
  load::main();
  callback::on_spawned(&on_player_spawned);
  util::waitforclient(0);
}

function on_player_spawned(localclientnum) {
  if(!isDefined(level.player)) {
    level.player = self;
  }
}