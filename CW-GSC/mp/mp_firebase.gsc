/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_firebase.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\red_door;
#namespace mp_firebase;

function event_handler[level_init] main(eventstruct) {
  level thread function_876cf680();
  load::main();
  level.var_23e297bc = undefined;
  compass::setupminimap("");
}

function function_876cf680() {
  var_a139d000 = strtok("sd sd_cdl", " ");
  str_gametype = util::get_game_type();

  if(isinarray(var_a139d000, str_gametype)) {
    hidemiscmodels("cave_cover_01");
    array::delete_all(getEntArray("cave_cover_01", "targetname"));
  }

  array::run_all(getEntArray("cave_cover_01", "targetname"), &disconnectpaths, undefined, 0);
}