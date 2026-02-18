/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\dem.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#namespace dem;

function event_handler[gametype_init] main(eventstruct) {
  callback::on_spawned(&on_player_spawned);

  if(getgametypesetting(#"silentplant") != 0) {
    setsoundcontext("bomb_plant", "silent");
  }

  clientfield::register_clientuimodel("Demolition.isCarryingBomb", #"hash_98bce8d3ef5ce18", #"iscarryingbomb", 1, 1, "int", undefined, 0, 0);
}

function on_player_spawned(localclientnum) {}