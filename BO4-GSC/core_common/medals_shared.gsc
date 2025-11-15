/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\medals_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace medals;

autoexec __init__system__() {
  system::register(#"medals", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
}

init() {
  level.medalinfo = [];
  level.medalcallbacks = [];
  level.numkills = 0;
  callback::on_connect(&on_player_connect);
}

on_player_connect() {
  self.lastkilledby = undefined;
}

setlastkilledby(attacker, inflictor) {
  self.lastkilledby = attacker;
  self.var_e78602fc = inflictor;
}

offenseglobalcount() {
  level.globalteammedals++;
}

defenseglobalcount() {
  level.globalteammedals++;
}

event_handler[player_medal] codecallback_medal(eventstruct) {
  if(!function_8570168d()) {
    self luinotifyevent(#"medal_received", 1, eventstruct.medal_index);
    self function_b552ffa9(#"medal_received", 1, eventstruct.medal_index);
  }
}

function_8570168d() {
  if(getdvar(#"hash_49e94b7aefac4f49", 0)) {
    return true;
  }

  if(sessionmodeismultiplayergame()) {
    mode = function_bea73b01();

    if(mode == 4) {
      return true;
    }
  }

  return false;
}