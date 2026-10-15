/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_player.gsc
******************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;

#namespace globallogic_player;

autoexec __init__system__() {
  system::register(#"globallogic_player", &__init__, undefined, undefined);
}

__init__() {
  level.var_aadc08f8 = &function_4b7bb02c;
  callback::on_disconnect(&on_player_disconnect);
}

function_4b7bb02c(weapon) {
  if(!killstreaks::is_killstreak_weapon(weapon)) {
    return true;
  }

  if(killstreaks::is_killstreak_weapon_assist_allowed(weapon)) {
    return true;
  }

  return false;
}

on_player_disconnect() {
  if(sessionmodeismultiplayergame()) {
    uploadstats();
  }
}