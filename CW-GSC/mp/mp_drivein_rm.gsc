/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_drivein_rm.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#namespace mp_drivein_rm;

function event_handler[level_init] main(eventstruct) {
  level thread function_be535c3();
  load::main();
  compass::setupminimap("");
}

function function_be535c3() {
  var_f7d8aaa7 = strtok("sd sd_hc sd_bb sd_cdl sd_cdlpro dem dem_hc", " ");
  gametype = util::get_game_type();

  if(isinarray(var_f7d8aaa7, gametype)) {
    hidemiscmodels("sd_table");
    array::delete_all(getEntArray("sd_table", "targetname"));
    return;
  }

  array::run_all(getEntArray("sd_table", "targetname"), &disconnectpaths, undefined, 0);
}