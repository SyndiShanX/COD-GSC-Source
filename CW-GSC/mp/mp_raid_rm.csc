/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_raid_rm.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#namespace mp_raid_rm;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  callback::on_gameplay_started(&on_gameplay_started);
  level thread function_b02d88a3();
  load::main();
  util::waitforclient(0);
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  util::function_8eb5d4b0(700, 1.5);
}

function function_b02d88a3() {
  var_f7d8aaa7 = strtok("tdm tdm_hc tdm10v10 conf conf10v10 conf_hc dm dm_hc ctf koth koth10v10 koth_cdl koth_hc oic shrp gun control control_cdl koth_cdlpro control_cdlpro", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_f7d8aaa7, gametype)) {
    indices = findvolumedecalindexarray("dom_bounds");

    foreach(index in indices) {
      hidevolumedecal(index);
    }
  }
}