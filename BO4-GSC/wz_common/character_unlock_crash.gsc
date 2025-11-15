/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_crash.gsc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\item_world_fixup;
#include scripts\mp_common\teams\teams;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_crash;

autoexec __init__system__() {
  system::register(#"character_unlock_crash", &__init__, undefined, #"character_unlock_crash_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"crash_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_drop_item", &on_drop_item);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);
    callback::on_item_pickup(&on_item_pickup);
    callback::on_item_use(&on_item_use);

    if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
      item_world_fixup::function_e70fa91c(#"health_stash_parent", #"health_stash_cu03", 3);
      return;
    }

    item_world_fixup::function_e70fa91c(#"health_stash_parent", #"health_stash_cu03", 10);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu03_item") {
    if(self character_unlock::function_f0406288(#"crash_unlock")) {
      var_4862d883 = self function_687146d();

      if(var_4862d883 >= 15) {
        self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9c0240fd010e", 1);
      }

      var_c503939b = globallogic::function_e9e52d05();

      if(var_c503939b <= function_c816ea5b()) {
        if(self character_unlock::function_f0406288(#"crash_unlock")) {
          self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9b0240fcff5b", 1);
        }
      }
    }
  }
}

on_drop_item(params) {
  if(!isplayer(self)) {
    return;
  }

  itementry = params.item.itementry;
  deathstash = params.item.deathstash;

  if(isDefined(deathstash) && deathstash) {
    return;
  }

  if(isDefined(itementry) && itementry.itemtype === #"health") {
    if(self character_unlock::function_f0406288(#"crash_unlock")) {
      var_4862d883 = self function_687146d();

      if(var_4862d883 < 15) {
        self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9c0240fd010e", 0);
      }
    }
  }
}

on_item_pickup(params) {
  itementry = params.item.itementry;

  if(isDefined(itementry) && itementry.itemtype === #"health") {
    if(self character_unlock::function_f0406288(#"crash_unlock")) {
      var_4862d883 = self function_687146d();

      if(var_4862d883 >= 15) {
        self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9c0240fd010e", 1);
      }
    }
  }
}

on_item_use(params) {
  itementry = params.item.itementry;

  if(isDefined(itementry) && itementry.itemtype === #"health") {
    if(self character_unlock::function_f0406288(#"crash_unlock")) {
      var_4862d883 = self function_687146d();

      if(var_4862d883 < 15) {
        self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9c0240fd010e", 0);
      }
    }
  }
}

private function_687146d() {
  var_4862d883 = 0;

  if(isDefined(self.inventory) && isDefined(self.inventory.items)) {
    foreach(item in self.inventory.items) {
      if(isDefined(item.itementry) && item.itementry.itemtype === #"health") {
        var_4862d883 += item.count;
      }
    }
  }

  return var_4862d883;
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_6d75024c) && level.var_6d75024c) {
    return;
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"crash_unlock")) {
            player character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9b0240fcff5b", 1);
          }
        }
      }
    }

    level.var_6d75024c = 1;
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
      return 3;
    case 5:
      return 3;
  }
}