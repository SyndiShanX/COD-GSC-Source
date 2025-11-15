/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_takeo.gsc
************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\item_drop;
#include scripts\mp_common\item_world;
#include scripts\mp_common\teams\teams;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_takeo;

autoexec __init__system__() {
  system::register(#"character_unlock_takeo", &__init__, undefined, #"character_unlock_takeo_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"takeo_unlock", &function_2613aeec);
  callback::on_finalize_initialization(&on_finalize_initialization);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_item_use(&on_item_use);
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);
    a_dynents = getdynentarray(#"hash_7b220e1de3a2000d");

    if(isDefined(a_dynents) && isarray(a_dynents)) {
      foreach(ent in a_dynents) {
        ent.onuse = &function_d5cd583a;
      }
    }

    return;
  }

  level thread function_279880b1();
}

on_finalize_initialization() {
  waitframe(1);
  level function_552910e9();
}

function_279880b1() {
  item_world::function_4de3ca98();
  level function_552910e9();
}

function_552910e9() {
  a_dynents = getdynentarray(#"hash_7b220e1de3a2000d");

  if(isDefined(a_dynents) && isarray(a_dynents)) {
    foreach(dynent in a_dynents) {
      setdynentenabled(dynent, 0);
    }
  }
}

function_d5cd583a(activator, laststate, state) {
  if(!level character_unlock::function_b3681acb()) {
    return;
  }

  if(level.inprematchperiod) {
    return;
  }

  spawnpos = struct::get(self.target, "targetname");

  if(!isDefined(spawnpos)) {
    return;
  }

  point = function_4ba8fde(#"cu18_item");

  if(isDefined(point) && isDefined(point.itementry)) {
    dropitem = self item_drop::drop_item(point.itementry.weapon, 1, point.itementry.amount, point.id, spawnpos.origin, spawnpos.angles);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(itementry.name === #"cu18_item") {
    if(self character_unlock::function_f0406288(#"takeo_unlock")) {
      self function_895b40e4();
      self character_unlock::function_c8beca5e(#"takeo_unlock", #"hash_56b5eb94fb75cbed", 1);
      self.var_b5d833a4 = 1;
      var_c503939b = globallogic::function_e9e52d05();

      if(var_c503939b <= function_c816ea5b()) {
        self character_unlock::function_c8beca5e(#"takeo_unlock", #"hash_56b5e894fb75c6d4", 1);
      }
    }
  }
}

on_item_use(params) {
  if(!(isDefined(self.var_b5d833a4) && self.var_b5d833a4)) {
    return;
  }

  if(isDefined(self.var_979273e3) && self.var_979273e3) {
    return;
  }

  item = params.item;

  if(isDefined(item.itementry) && item.itementry.itemtype === #"equipment") {
    if(self character_unlock::function_c70bcc7a(#"takeo_unlock")) {
      self character_unlock::function_c8beca5e(#"takeo_unlock", #"hash_56b5eb94fb75cbed", 2);
      self.var_979273e3 = 1;
    }
  }
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_2dd7bbb7) && level.var_2dd7bbb7) {
    return;
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"takeo_unlock")) {
            player character_unlock::function_c8beca5e(#"takeo_unlock", #"hash_56b5e894fb75c6d4", 1);
          }
        }
      }
    }

    level.var_2dd7bbb7 = 1;
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

private function_895b40e4() {
  self playsoundtoplayer(#"hash_1c5c27cafefddb2f", self);
}