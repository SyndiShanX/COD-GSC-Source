/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_mason.gsc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\item_world_fixup;
#include scripts\mp_common\teams\teams;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_mason;

autoexec __init__system__() {
  system::register(#"character_unlock_mason", &__init__, undefined, #"character_unlock_mason_fixup");
}

__init__() {
  clientfield::register("world", "array_broadcast", 1, 1, "int");
  clientfield::register("toplayer", "array_effects", 1, 1, "int");
  character_unlock_fixup::function_90ee7a97(#"mason_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);

    if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
      item_world_fixup::function_e70fa91c(#"wz_escape_supply_stash_parent", #"supply_stash_cu19", 1);
    } else {
      item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"supply_stash_cu19", 6);
    }

    dynent = getdynent(#"array_broadcast");

    if(isDefined(dynent)) {
      dynent.onuse = &function_1e224132;
    }
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(isDefined(itementry) && itementry.name === #"cu19_item") {
    var_c503939b = globallogic::function_e9e52d05();

    if(var_c503939b <= function_c816ea5b()) {
      if(self character_unlock::function_f0406288(#"mason_unlock")) {
        self character_unlock::function_c8beca5e(#"mason_unlock", #"hash_7334980069e5e2fa", 1);
      }
    }
  }
}

function_1e224132(activator, laststate, state) {
  if(isplayer(activator) && !level.inprematchperiod) {
    characterassetname = getcharacterassetname(activator getcharacterbodytype(), currentsessionmode());

    if(activator character_unlock::function_f0406288(#"mason_unlock")) {
      level clientfield::set("array_broadcast", 1);
      activator clientfield::set_to_player("array_effects", 1);
      activator thread function_e3abcf2();
      activator character_unlock::function_c8beca5e(#"mason_unlock", #"hash_7334970069e5e147", 1);
    }

    activator stats::function_d40764f3(#"activation_count_broadcast", 1);
  }
}

function_e3abcf2() {
  self endon(#"disconnect", #"game_ended");
  var_70f6f8c = 1;

  while(isplayer(self) && isalive(self) && var_70f6f8c) {
    var_70f6f8c = self character_unlock::function_f0406288(#"mason_unlock");
    waitframe(1);
  }

  self clientfield::set_to_player("array_effects", 0);
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_7733b33f) && level.var_7733b33f) {
    return;
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"mason_unlock")) {
            player character_unlock::function_c8beca5e(#"mason_unlock", #"hash_7334980069e5e2fa", 1);
          }
        }
      }
    }

    level.var_7733b33f = 1;
  }
}

private function_c816ea5b() {
  maxteamplayers = isDefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;

  switch (maxteamplayers) {
    case 1:
      return 15;
    case 2:
      return 8;
    case 4:
    default:
      return 4;
    case 5:
      return 4;
  }
}