/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_sm_gas_station.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#namespace mp_sm_gas_station;

function event_handler[level_init] main(eventstruct) {
  level.missileremotelaunchvert = 9500;
  callback::function_900862de(&function_900862de);
  callback::on_game_playing(&on_game_playing);
  load::main();
  compass::setupminimap("");
  setDvar(#"hash_7b06b8037c26b99b", 70);
  level.var_3944682[# "allies"] = {
    #origin: (0, 1500, 1200), #angles: (0, -65, 0)
  };
  level.var_3944682[# "axis"] = {
    #origin: (0, 1500, 1200), #angles: (0, 115, 0)
  };
}

function function_900862de() {
  a_players = getplayers();

  foreach(player in a_players) {
    player setsunshadowsplitdistance(3500);
  }
}

function on_game_playing() {
  a_players = getplayers();

  foreach(player in a_players) {
    player setsunshadowsplitdistance(1500);
  }
}