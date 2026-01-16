/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_reaper.gsc
*************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\teams\teams;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_reaper;

autoexec __init__system__() {
  system::register(#"character_unlock_reaper", &__init__, undefined, #"character_unlock_reaper_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"reaper_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_22c795c5dddbfc97", &function_381c1e1d);
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu35_item") {
    if(self character_unlock::function_f0406288(#"reaper_unlock")) {
      if(self stats::get_stat_global(#"kills_early") >= 115) {
        self character_unlock::function_c8beca5e(#"reaper_unlock", #"hash_555c37b28c4a770c", 1);
      }

      var_c503939b = globallogic::function_e9e52d05();

      if(var_c503939b <= function_c816ea5b()) {
        self character_unlock::function_c8beca5e(#"reaper_unlock", #"hash_555c3ab28c4a7c25", 1);
      }
    }
  }
}

function_381c1e1d() {
  if(self character_unlock::function_f0406288(#"reaper_unlock")) {
    if(self stats::get_stat_global(#"kills_early") >= 115) {
      self character_unlock::function_c8beca5e(#"reaper_unlock", #"hash_555c37b28c4a770c", 1);
    }
  }
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_dcd43b16) && level.var_dcd43b16) {
    return;
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"reaper_unlock")) {
            player character_unlock::function_c8beca5e(#"reaper_unlock", #"hash_555c3ab28c4a7c25", 1);
          }
        }
      }
    }

    level.var_dcd43b16 = 1;
  }
}

private function_c816ea5b() {
  maxteamplayers = isDefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;

  switch (maxteamplayers) {
    case 1:
      return 5;
    case 2:
      return 3;
    case 4:
    default:
      return 2;
    case 5:
      return 2;
  }
}