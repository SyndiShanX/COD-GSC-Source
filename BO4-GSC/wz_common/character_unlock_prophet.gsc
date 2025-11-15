/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_prophet.gsc
**************************************************/

#include script_71e26f08f03b7a7a;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_prophet;

autoexec __init__system__() {
  system::register(#"character_unlock_prophet", &__init__, undefined, #"character_unlock_prophet_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"prophet_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_last_alive", &function_4ac25840);
    callback::add_callback(#"on_drop_item", &on_drop_item);
    character_unlock::function_d2294476(#"supply_drop_stash_cu10", 2, 3);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu10_item") {
    self thread function_798820a9(item);
  }
}

on_drop_item(params) {
  if(!isplayer(self)) {
    return;
  }

  if(isDefined(params.item) && isDefined(params.item.itementry)) {
    itementry = params.item.itementry;

    if(itementry.name === #"cu10_item" && !self character_unlock::function_f0406288(#"prophet_unlock")) {
      self notify(#"dropped_prophet_item");
    }
  }
}

function_798820a9(item) {
  self notify("3da3c6e1687182e2");
  self endon("3da3c6e1687182e2");
  self endon(#"hash_249a493b6d9b422c", #"dropped_prophet_item", #"disonnect", #"death");

  if(!isplayer(self)) {
    return;
  }

  player = self;

  while(isDefined(player)) {
    if(isDefined(player.inventory) && isDefined(player.inventory.consumed)) {
      if((isDefined(player.inventory.consumed.size) ? player.inventory.consumed.size : 0) >= 3) {
        player character_unlock::function_c8beca5e(#"prophet_unlock", #"hash_63b7bd67a959fc47", 1);
      } else {
        player character_unlock::function_c8beca5e(#"prophet_unlock", #"hash_63b7bd67a959fc47", 0);
      }
    }

    waitframe(1);
  }
}

function_4ac25840(params) {
  foreach(team in params.teams_alive) {
    players = getplayers(team);

    foreach(player in players) {
      if(player character_unlock::function_f0406288(#"prophet_unlock")) {
        player character_unlock::function_c8beca5e(#"prophet_unlock", #"hash_63b7be67a959fdfa", 1);
        player notify(#"hash_249a493b6d9b422c");
      }
    }
  }
}