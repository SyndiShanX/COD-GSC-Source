/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ix_stanton.gsc
*****************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\teams\teams;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ix_stanton;

autoexec __init__system__() {
  system::register(#"character_unlock_ix_stanton", &__init__, undefined, #"character_unlock_ix_stanton_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"ix_stanton_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_drop_inventory", &on_use_perk);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);
  }
}

function_1c4b5097(item) {
  if(isDefined(item.itementry) && item.itementry.name === #"cu31_item") {
    var_c503939b = globallogic::function_e9e52d05();

    if(var_c503939b <= function_c816ea5b()) {
      if(self character_unlock::function_f0406288(#"ix_stanton_unlock")) {
        self character_unlock::function_c8beca5e(#"ix_stanton_unlock", #"hash_9eef458b72b750d", 1);
      }
    }
  }
}

on_use_perk(player) {
  if(!isplayer(player)) {
    return;
  }

  if(!player character_unlock::function_f0406288(#"ix_stanton_unlock")) {
    return;
  }

  if(!isDefined(player.var_e598921d)) {
    player.var_e598921d = 0;
  }

  player.var_e598921d++;

  if(player.var_e598921d == 5) {
    player character_unlock::function_c8beca5e(#"ix_stanton_unlock", #"hash_9eef158b72b6ff4", 1);
  }
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_6a1f6a43) && level.var_6a1f6a43) {
    return;
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"ix_stanton_unlock")) {
            player character_unlock::function_c8beca5e(#"ix_stanton_unlock", #"hash_9eef458b72b750d", 1);
          }
        }
      }
    }

    level.var_6a1f6a43 = 1;
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
      return 8;
    case 5:
      return 8;
  }
}