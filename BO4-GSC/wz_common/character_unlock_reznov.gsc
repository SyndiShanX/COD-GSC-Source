/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_reznov.gsc
*************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\item_world;
#include scripts\mp_common\teams\teams;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;
#include scripts\wz_common\character_unlock_reznov_fixup;

#namespace character_unlock_reznov;

autoexec __init__system__() {
  system::register(#"character_unlock_reznov", &__init__, undefined, #"character_unlock_reznov_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"reznov_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_player_killed(&on_player_killed);
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);
    level thread function_4f4cf89e();
  }
}

function_4f4cf89e() {
  item_world::function_4de3ca98();
  var_daed388 = function_91b29d2a(#"cu21_spawn");

  if(!isDefined(var_daed388[0])) {
    return;
  }

  var_daed388 = array::randomize(var_daed388);
  var_8a9122c8 = var_daed388[0];
  var_5901fe7f = 0;

  for(x = 1; x < var_daed388.size; x++) {
    if(isDefined(var_5901fe7f) && var_5901fe7f) {
      item_world::consume_item(var_daed388[x]);
      continue;
    }

    if(distance2d(var_daed388[x].origin, var_8a9122c8.origin) < 500) {
      item_world::consume_item(var_daed388[x]);
      continue;
    }

    var_5901fe7f = 1;
  }
}

on_player_killed() {
  if(!isDefined(self.laststandparams)) {
    return;
  }

  attacker = self.laststandparams.attacker;

  if(!isplayer(attacker)) {
    return;
  }

  if(!attacker util::isenemyteam(self.team)) {
    return;
  }

  weapon = self.laststandparams.sweapon;

  if(!weapon.isprimary) {
    return;
  }

  attacker_origin = self.laststandparams.attackerorigin;
  victim_origin = self.laststandparams.victimorigin;

  if(!isDefined(attacker_origin) || !isDefined(victim_origin)) {
    return;
  }

  if(!attacker character_unlock::function_f0406288(#"reznov_unlock")) {
    return;
  }

  dist_to_target_sq = distancesquared(attacker_origin, victim_origin);

  if(dist_to_target_sq < 7800 * 7800) {
    return;
  }

  if(!isDefined(attacker.var_ec8d7cbc)) {
    attacker.var_ec8d7cbc = 0;
  }

  attacker.var_ec8d7cbc++;

  if(attacker.var_ec8d7cbc == 1) {
    attacker character_unlock::function_c8beca5e(#"reznov_unlock", #"hash_1cd3eb5d2d22f647", 1);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(isDefined(itementry) && itementry.name === #"cu21_item") {
    var_c503939b = globallogic::function_e9e52d05();

    if(var_c503939b <= function_c816ea5b()) {
      if(self character_unlock::function_f0406288(#"reznov_unlock")) {
        self character_unlock::function_c8beca5e(#"reznov_unlock", #"hash_1cd3ec5d2d22f7fa", 1);
      }
    }
  }
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_34983012) && level.var_34983012) {
    return;
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"reznov_unlock")) {
            player character_unlock::function_c8beca5e(#"reznov_unlock", #"hash_1cd3ec5d2d22f7fa", 1);
          }
        }
      }
    }

    level.var_34983012 = 1;
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