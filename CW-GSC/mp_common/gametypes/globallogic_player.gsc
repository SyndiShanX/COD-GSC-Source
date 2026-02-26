/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_player.gsc
******************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#namespace globallogic_player;

function private autoexec __init__system__() {
  system::register(#"globallogic_player", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_aadc08f8 = &function_4b7bb02c;
  callback::on_disconnect(&on_player_disconnect);
}

function function_4b7bb02c(weapon) {
  if(!killstreaks::is_killstreak_weapon(weapon)) {
    return true;
  }

  if(killstreaks::is_killstreak_weapon_assist_allowed(weapon)) {
    return true;
  }

  return false;
}

function on_player_disconnect() {
  player = self;

  if(sessionmodeismultiplayergame()) {
    uploadstats();

    if(getdvarint(#"hash_37dfd97d34a15e14", 0)) {
      player contracts::function_78083139();

      if(isDefined(player.pers[#"hash_150795bee4d46ce4"])) {
        var_28ee869a = gettime() - player.pers[#"hash_150795bee4d46ce4"];
        player challenges::function_659f7dc(var_28ee869a, 0);
      }

      player function_4835d26a();
    }
  }
}