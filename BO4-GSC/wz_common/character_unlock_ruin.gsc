/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ruin.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ruin;

autoexec __init__system__() {
  system::register(#"character_unlock_ruin", &__init__, undefined, #"character_unlock_ruin_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"ruin_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_player_killed(&on_player_killed);
    level thread function_cb514c8b();
  }
}

function_cb514c8b() {
  item_world::function_4de3ca98();
  var_885c7eef = function_91b29d2a(#"cu08_spawn");

  if(!isDefined(var_885c7eef[0])) {
    return;
  }

  var_885c7eef = array::randomize(var_885c7eef);
  var_8a9122c8 = var_885c7eef[0];
  var_5901fe7f = 0;

  for(x = 1; x < var_885c7eef.size; x++) {
    if(isDefined(var_5901fe7f) && var_5901fe7f) {
      item_world::consume_item(var_885c7eef[x]);
      continue;
    }

    if(distance2d(var_885c7eef[x].origin, var_8a9122c8.origin) < 4000) {
      item_world::consume_item(var_885c7eef[x]);
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

  if(!attacker character_unlock::function_f0406288(#"ruin_unlock")) {
    return;
  }

  dist_to_target_sq = distancesquared(attacker.origin, self.origin);

  if(dist_to_target_sq > 196.85 * 196.85) {
    return;
  }

  if(!isDefined(attacker.var_faf1dae6)) {
    attacker.var_faf1dae6 = 0;
  }

  attacker.var_faf1dae6++;

  if(attacker.var_faf1dae6 == 1) {
    attacker character_unlock::function_c8beca5e(#"ruin_unlock", #"hash_4e9ba934add76371", 1);
  }
}