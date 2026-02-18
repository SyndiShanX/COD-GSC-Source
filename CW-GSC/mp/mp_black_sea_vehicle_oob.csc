/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_black_sea_vehicle_oob.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#namespace namespace_a208feb2;

function event_handler[gametype_start] main(eventstruct) {
  var_c34e1dc2 = strtok("war12v12", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_c34e1dc2, gametype) || !getdvarint(#"hash_360035890f73b515", 0)) {
    return;
  }

  callback::on_gameplay_started(&on_gameplay_started);
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  function_f9f55898(localclientnum);
}

function function_f9f55898(localclientnum) {
  var_c34e1dc2 = strtok("war12v12", " ");
  gametype = util::get_game_type();

  if(!isinarray(var_c34e1dc2, gametype) || !getdvarint(#"hash_360035890f73b515", 0)) {
    array::delete_all(getEntArray(localclientnum, "vehicle_oob_minimap", "targetname"));
    return;
  }

  var_c41d6d5b = getEntArray(localclientnum, "vehicle_oob_minimap", "targetname");
  array::run_all(var_c41d6d5b, &function_c06a8682, localclientnum);
}