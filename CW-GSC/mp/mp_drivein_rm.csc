/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_drivein_rm.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#namespace mp_drivein_rm;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  callback::on_gameplay_started(&on_gameplay_started);
  load::main();
  util::waitforclient(0);
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  util::function_8eb5d4b0(750, 2);
}