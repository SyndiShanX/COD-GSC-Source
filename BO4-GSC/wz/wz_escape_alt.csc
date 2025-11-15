/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz\wz_escape_alt.csc
***********************************************/

#include scripts\core_common\exploder_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world;
#include scripts\mp_common\load;
#include scripts\wz\wz_escape_alt_ffotd;
#include scripts\wz_common\wz_nixie_tubes;

#namespace wz_escape_alt;

event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  load::main();
  setdvar(#"cg_aggressivecullradius", 100);
  setdvar(#"hash_53f625ed150e7700", 12000);

  if(isDefined(getgametypesetting(#"hash_26f00de198472b81")) && getgametypesetting(#"hash_26f00de198472b81")) {
    setdvar(#"hash_53f625ed150e7700", 6000);
  }

  util::waitforclient(0);
  level.sensor_dart_radius = 1200;
  level thread function_e656c6cb();
}

function_e656c6cb() {
  item_world::function_4de3ca98();
  exploder::exploder("fxexp_portal_idle");
}