/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_torque.gsc
*************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\item_world_fixup;
#include scripts\mp_common\teams\teams;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_torque;

autoexec __init__system__() {
  system::register(#"character_unlock_torque", &__init__, undefined, #"character_unlock_torque_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"torque_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_item_use(&function_a2877194);
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);

    if(isDefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659")) {
      item_world_fixup::function_e70fa91c(#"ammo_stash_parent_dlc1", #"supply_drop_stash_cu02", 2);
      return;
    }

    item_world_fixup::function_e70fa91c(#"ammo_stash_parent_dlc1", #"supply_drop_stash_cu02", 6);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu02_item") {
    self.var_cadd241b = 1;
    var_c503939b = globallogic::function_e9e52d05();

    if(var_c503939b <= function_c816ea5b()) {
      if(self character_unlock::function_f0406288(#"torque_unlock")) {
        self character_unlock::function_c8beca5e(#"torque_unlock", #"hash_b47463756c6a60f", 1);
      }
    }
  }
}

function_a2877194(params) {
  if(!(isDefined(self.var_cadd241b) && self.var_cadd241b)) {
    return;
  }

  if(!self character_unlock::function_f0406288(#"torque_unlock")) {
    return;
  }

  item_name = params.item.itementry.name;

  if(item_name === #"concertina_wire_wz_item") {
    if(!isDefined(self.var_41ae08e8)) {
      self.var_41ae08e8 = 0;
    }

    self.var_41ae08e8++;

    if(self.var_41ae08e8 == 2) {
      self character_unlock::function_c8beca5e(#"torque_unlock", #"hash_a9ec4883fd0293d", 1);
    }

    return;
  }

  if(item_name === #"barricade_wz_item") {
    if(!isDefined(self.var_c0bc1135)) {
      self.var_c0bc1135 = 0;
    }

    self.var_c0bc1135++;

    if(self.var_c0bc1135 == 1) {
      self character_unlock::function_c8beca5e(#"torque_unlock", #"hash_3843c83850f09a08", 1);
    }
  }
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_93eb15f7) && level.var_93eb15f7) {
    return;
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"torque_unlock")) {
            player character_unlock::function_c8beca5e(#"torque_unlock", #"hash_b47463756c6a60f", 1);
          }
        }
      }
    }

    level.var_93eb15f7 = 1;
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