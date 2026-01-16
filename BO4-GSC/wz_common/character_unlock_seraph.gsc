/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_seraph.gsc
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
#include scripts\wz_common\character_unlock_seraph_fixup;
#include scripts\wz_common\wz_firing_range;

#namespace character_unlock_seraph;

autoexec __init__system__() {
  system::register(#"character_unlock_seraph", &__init__, undefined, #"character_unlock_seraph_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"seraph_unlock", &function_2613aeec);
  callback::on_finalize_initialization(&on_finalize_initialization);
}

on_finalize_initialization() {
  waitframe(1);
  level function_75097bb5();
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_player_killed(&on_player_killed);
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_team_eliminated", &function_4ac25840);
    wz_firing_range::init_targets(#"hash_3af83a27a707345a");
    level.var_d27ee2e7 = 1;
    level thread function_211772b5();
    return;
  }

  level thread function_1e3aca52();
}

function_211772b5() {
  item_world::function_4de3ca98();
  var_b2425612 = getdynentarray(#"hash_81ef4f75cff4919");

  if(isDefined(var_b2425612) && var_b2425612.size > 1) {
    var_65688262 = array::random(var_b2425612);
    arrayremovevalue(var_b2425612, var_65688262);

    foreach(box in var_b2425612) {
      if(isDefined(box)) {
        setdynentenabled(box, 0);
      }
    }

    var_590fbce8 = function_91b29d2a(#"annihilator_spawn");

    if(isDefined(var_590fbce8) && var_590fbce8.size > 1) {
      var_590fbce8 = arraysortclosest(var_590fbce8, var_65688262.origin);

      for(i = 1; i < var_590fbce8.size; i++) {
        item_world::consume_item(var_590fbce8[i]);
      }
    }
  }
}

function_1e3aca52() {
  item_world::function_4de3ca98();
  level function_75097bb5();
}

function_75097bb5() {
  var_1c9468df = getdynent(#"hash_3af83a27a707345a");

  if(isDefined(var_1c9468df)) {
    setdynentenabled(var_1c9468df, 0);
  }

  var_b2425612 = getdynentarray(#"hash_81ef4f75cff4919");

  if(isDefined(var_b2425612)) {
    foreach(box in var_b2425612) {
      if(isDefined(box)) {
        setdynentenabled(box, 0);
      }
    }
  }
}

private event_handler[event_cf200f34] function_209450ae(eventstruct) {
  if(!(isDefined(level.var_d27ee2e7) && level.var_d27ee2e7)) {
    return;
  }

  if(!level character_unlock::function_b3681acb()) {
    return;
  }

  if(level.inprematchperiod) {
    return;
  }

  dynent = eventstruct.ent;

  if(dynent.targetname !== #"hash_3af83a27a707345a") {
    return;
  }

  attacker = eventstruct.attacker;
  weapon = eventstruct.weapon;
  position = eventstruct.position;
  direction = eventstruct.dir;

  if(!isplayer(attacker) || !isDefined(weapon) || !isDefined(position) || !isDefined(direction)) {
    return;
  }

  if(weapon.weapclass != "pistol" && weapon.weapclass != "pistol spread") {
    return;
  }

  if(distancesquared(attacker.origin, dynent.origin) < 200 * 200) {
    return;
  }

  if(attacker character_unlock::function_d7e6fa92(#"seraph_unlock")) {
    return;
  }

  targetangles = dynent.angles + (0, 90, 0);
  var_2bbc9717 = anglesToForward(targetangles);

  if(vectordot(var_2bbc9717, direction) >= 0) {
    return;
  }

  var_f748425e = dynent.origin + (0, 0, 60);

  if(distance2dsquared(var_f748425e, position) > 5 * 5) {
    return;
  }

  var_bbe521bc = getdynent(#"hash_81ef4f75cff4919");

  if(function_ffdbe8c2(var_bbe521bc) != 1) {
    setdynentstate(var_bbe521bc, 1);
  }
}

on_player_killed() {
  if(!isDefined(self.laststandparams)) {
    return;
  }

  attacker = self.laststandparams.attacker;
  weapon = self.laststandparams.sweapon;

  if(!isplayer(attacker) || !isDefined(weapon)) {
    return;
  }

  if(weapon.name != #"hero_annihilator") {
    return;
  }

  if(!attacker util::isenemyteam(self.team)) {
    return;
  }

  if(!attacker character_unlock::function_f0406288(#"seraph_unlock")) {
    return;
  }

  attacker character_unlock::function_c8beca5e(#"seraph_unlock", #"hash_633d185cd2140f1a", 1);
}

function_1c4b5097(item) {
  if(isDefined(item.itementry) && item.itementry.name === #"annihilator_wz_item") {
    var_c503939b = globallogic::function_e9e52d05();

    if(var_c503939b <= function_c816ea5b()) {
      if(self character_unlock::function_f0406288(#"seraph_unlock")) {
        self character_unlock::function_c8beca5e(#"seraph_unlock", #"hash_633d175cd2140d67", 1);
      }
    }
  }
}

function_4ac25840(dead_team) {
  if(isDefined(level.var_3227278c) && level.var_3227278c) {
    return;
  }

  var_c503939b = globallogic::function_e9e52d05();

  if(var_c503939b <= function_c816ea5b()) {
    foreach(team in level.teams) {
      if(teams::function_9dd75dad(team) && !teams::is_all_dead(team)) {
        players = getplayers(team);

        foreach(player in players) {
          if(player character_unlock::function_f0406288(#"seraph_unlock")) {
            player character_unlock::function_c8beca5e(#"seraph_unlock", #"hash_633d175cd2140d67", 1);
          }
        }
      }
    }

    level.var_3227278c = 1;
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

function_f6dc1aa9() {
  while(true) {
    var_f748425e = self.origin + (0, 0, 60);
    sphere(var_f748425e, 5, (1, 1, 0));
    waitframe(1);
  }
}

