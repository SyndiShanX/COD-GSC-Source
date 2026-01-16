/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_nikolai.gsc
**************************************************/

#include scripts\abilities\gadgets\gadget_cymbal_monkey;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\teams\teams;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;
#include scripts\wz_common\character_unlock_nikolai_fixup;

#namespace character_unlock_nikolai;

autoexec __init__system__() {
  system::register(#"character_unlock_nikolai", &__init__, undefined, #"character_unlock_nikolai_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"nikolai_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_3c09ead7e9d8a968", &function_19a80b40);
    callback::add_callback(#"hash_6aa0232dd3c8376a", &function_8bf71bd6);
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);
  }
}

function_19a80b40(var_a0ffe134) {
  if(!isplayer(self) || !isDefined(var_a0ffe134)) {
    return;
  }

  if(!level character_unlock::function_b3681acb()) {
    return;
  }

  if(level.inprematchperiod) {
    return;
  }

  gate = getdynent(#"hash_3400914dff71459c");

  if(!isDefined(gate)) {
    return;
  }

  if(distancesquared(var_a0ffe134.origin, gate.origin) > 500 * 500) {
    return;
  }

  if(function_ffdbe8c2(gate) == 1) {
    return;
  }

  check_origin = gate.origin + rotatepoint((100, 25, 0), gate.angles);

    if(distancesquared(var_a0ffe134.origin, check_origin) > 150 * 150) {
      return;
    }

  var_a0ffe134 thread gadget_cymbal_monkey::function_b9934c1d();
}

function_8bf71bd6() {
  if(!isDefined(self) || !isDefined(self.var_38af96b9)) {
    return;
  }

  player = self.var_38af96b9.originalowner;

  if(!isplayer(player)) {
    return;
  }

  gate = getdynent(#"hash_3400914dff71459c");

  if(!isDefined(gate)) {
    return;
  }

  if(distancesquared(self.origin, gate.origin) > 500 * 500) {
    return;
  }

  if(function_ffdbe8c2(gate) == 1) {
    return;
  }

  check_origin = gate.origin + rotatepoint((100, 25, 0), gate.angles);

    if(distancesquared(self.origin, check_origin) > 150 * 150) {
      return;
    }

  traversal_start_node = getnode("gy_traversal_start", "targetname");

  if(isDefined(traversal_start_node)) {
    linktraversal(traversal_start_node);
  }

  player function_587e512e();
  setdynentstate(gate, 1);
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(isDefined(itementry) && itementry.name === #"cu16_item") {
    var_c503939b = globallogic::function_e9e52d05();

    if(var_c503939b <= function_c816ea5b()) {
      if(self character_unlock::function_f0406288(#"nikolai_unlock")) {
        self character_unlock::function_c8beca5e(#"nikolai_unlock", #"hash_6a5c9e02cc60e87e", 1);
      }
    }
  }
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_cf7b9008) && level.var_cf7b9008) {
    return;
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"nikolai_unlock")) {
            player character_unlock::function_c8beca5e(#"nikolai_unlock", #"hash_6a5c9e02cc60e87e", 1);
          }
        }
      }
    }

    level.var_cf7b9008 = 1;
  }
}

private function_587e512e() {
  self playsoundtoplayer(#"hash_1c4290ca92541819", self);
  self playSound(#"hash_8489803fbb0e650");

  foreach(player in getplayers(self.team)) {
    if(isDefined(player)) {
      player playsoundtoplayer(#"hash_41def4c864993224", player);
    }
  }
}

private function_c816ea5b() {
  maxteamplayers = isDefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1;

  switch (maxteamplayers) {
    case 1:
      return 10;
    case 2:
      return 5;
    case 4:
    default:
      return 3;
    case 5:
      return 3;
  }
}

function_3fbc7157(origin, radius) {
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");

  while(true) {
    circle(origin + (0, 0, 10), radius, (1, 0, 0), 0, 1, 1);
    waitframe(1);
  }
}

