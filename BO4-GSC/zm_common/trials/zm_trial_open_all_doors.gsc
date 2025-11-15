/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_open_all_doors.gsc
********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_open_all_doors;

autoexec __init__system__() {
  system::register(#"zm_trial_open_all_doors", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zombie_doors = getEntArray("zombie_door", "targetname");
  zombie_debris = getEntArray("zombie_debris", "targetname");
  level.var_a0f5e369 = function_d34c075e(zombie_doors);
  level.var_3a748490 = function_d34c075e(zombie_debris);
  zm_trial::register_challenge(#"open_all_doors", &on_begin, &on_end);
}

private on_begin(n_timer) {
  level.var_d39baced = level.zombie_total_set_func;
  level.zombie_total_set_func = &set_zombie_total;
  zm_trial_util::function_2976fa44(function_d2a5d1f0());
  zm_trial_util::function_2976fa44(function_e242d7a8());
  level thread function_b2fa4678();

  if(isDefined(n_timer)) {
    self.n_timer = zm_trial::function_5769f26a(n_timer);
    level thread monitor_timer(self.n_timer);
  }
}

private on_end(round_reset) {
  level.zombie_total_set_func = level.var_d39baced;
  zm_trial_util::function_f3dbeda7();

  if(!round_reset) {
    var_eeba6731 = function_d2a5d1f0();
    var_de1def71 = function_e242d7a8();

    if(var_eeba6731 < var_de1def71) {
      zm_trial::fail(#"hash_2c31c30f3d0b0484", getplayers());
    }
  }

  if(isDefined(self.n_timer)) {
    foreach(player in getplayers()) {
      player zm_trial_util::function_885fb2c8();
    }
  }

  level.var_d0b04690 = undefined;
}

set_zombie_total() {
  var_92217b88 = (level.var_a0f5e369 + level.var_3a748490) * 10;
  level.zombie_total = int(max(level.zombie_total, var_92217b88));
}

private function_d34c075e(ents) {
  ents = array::remove_undefined(ents, 0);
  unique = [];

  foreach(ent in ents) {
    if(isDefined(ent.target)) {
      unique[ent.target] = 1;
    }
  }

  return unique.size;
}

private function_a4cfa984(door_ents, debris_ents) {
  var_8b730c3e = [];

  foreach(door_ent in door_ents) {
    if(isDefined(door_ent.target) && isDefined(door_ent.has_been_opened) && door_ent.has_been_opened) {
      var_8b730c3e[door_ent.target] = 1;
    }
  }

  var_eeba6731 = var_8b730c3e.size;
  var_c5f7c25b = function_d34c075e(debris_ents);
  var_69310a8a = level.var_3a748490 - var_c5f7c25b;
  return var_eeba6731 + var_69310a8a;
}

private function_b2fa4678() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");
  var_c43a6efa = 0;
  var_58161ed2 = function_e242d7a8();

  while(true) {
    var_54e16eaa = function_d2a5d1f0();

    if(var_54e16eaa != var_c43a6efa) {
      if(var_54e16eaa >= var_58161ed2) {
        zm_trial_util::function_7d32b7d0(1);
        level notify(#"hash_6ba2e2da302282");
        level.var_d0b04690 = 1;
      } else {
        zm_trial_util::function_dace284(var_54e16eaa);
      }

      var_c43a6efa = var_54e16eaa;
    }

    wait 0.5;
  }
}

private monitor_timer(n_timer) {
  level endon(#"hash_7646638df88a3656");
  wait 12;

  foreach(player in getplayers()) {
    player zm_trial_util::function_128378c9(n_timer, 1, #"hash_c2b77be4cf5b142");
  }

  level waittilltimeout(n_timer + 1, #"hash_6ba2e2da302282");

  foreach(player in getplayers()) {
    player zm_trial_util::function_885fb2c8();
  }

  if(function_d2a5d1f0() < function_e242d7a8()) {
    zm_trial::fail(#"hash_2c31c30f3d0b0484", getplayers());
  }
}

function_d2a5d1f0() {
  zombie_doors = getEntArray("zombie_door", "targetname");
  zombie_debris = getEntArray("zombie_debris", "targetname");
  var_49a2fc65 = function_a4cfa984(zombie_doors, zombie_debris);
  return var_49a2fc65;
}

function_e242d7a8() {
  return level.var_a0f5e369 + level.var_3a748490;
}