/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_recon.gsc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\item_world_fixup;
#include scripts\mp_common\teams\teams;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_recon;

autoexec __init__system__() {
  system::register(#"character_unlock_recon", &__init__, undefined, #"character_unlock_recon_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"recon_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::on_player_damage(&on_player_damage);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);

    if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
      item_world_fixup::function_e70fa91c(#"wz_escape_supply_stash_parent", #"supply_stash_cu04", 1);
      return;
    }

    item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"supply_stash_cu04", 6);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu04_item") {
    if(self character_unlock::function_f0406288(#"recon_unlock")) {
      self character_unlock::function_c8beca5e(#"recon_unlock", #"hash_91d5ea7b26a8aca", 1);
      var_f63b894c = 0;

      foreach(team in level.teams) {
        if(teams::function_9dd75dad(team)) {
          var_f63b894c++;
        }
      }

      var_c503939b = globallogic::function_e9e52d05();

      if(var_f63b894c > 0 && var_c503939b <= function_c816ea5b()) {
        self character_unlock::function_c8beca5e(#"recon_unlock", #"hash_91d5da7b26a8917", 1);
      }
    }
  }
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_72429ca6) && level.var_72429ca6) {
    return;
  }

  var_f63b894c = 0;

  foreach(team in level.teams) {
    if(teams::function_9dd75dad(team)) {
      var_f63b894c++;
    }
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_f63b894c > 0 && var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"recon_unlock")) {
            player character_unlock::function_c8beca5e(#"recon_unlock", #"hash_91d5da7b26a8917", 1);
          }
        }
      }
    }

    level.var_72429ca6 = 1;
  }
}

on_player_damage(params) {
  if(params.smeansofdeath == "MOD_DEATH_CIRCLE" && self character_unlock::function_c70bcc7a(#"recon_unlock")) {
    self character_unlock::function_c8beca5e(#"recon_unlock", #"hash_91d5ea7b26a8aca", 2);
  }
}

private function_c816ea5b() {
  maxteamplayers = isDefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;

  switch (maxteamplayers) {
    case 1:
      return 30;
    case 2:
      return 15;
    case 4:
    default:
      return 7;
    case 5:
      return 7;
  }
}