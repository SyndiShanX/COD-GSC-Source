/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1d4ca739cb476f50.csc
***********************************************/

#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#namespace minigame;

function private autoexec __init__system__() {
  system::register("minigames", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  serverfield::register("minigame_progress", 1, 3, "int");
}

function notify_progress(e_player, steps) {
  assert(8 - 1 >= steps);
  var_4b635559 = int(steps * (8 - 1));
  e_player serverfield::set("minigame_progress", var_4b635559);
}