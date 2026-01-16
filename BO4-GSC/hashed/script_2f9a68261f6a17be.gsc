/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_2f9a68261f6a17be.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace namespace_b28d86fd;

autoexec __init__system__() {
  system::register(#"hash_41cb195ec280085c", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_149b9c514fee8fc3", &on_begin, &on_end);
}

private on_begin() {
  callback::function_33f0ddd3(&function_33f0ddd3);

  foreach(player in getplayers()) {
    player thread zm_trial_util::function_bf710271();
    player zm_trial_util::function_7dbb1712(1);
  }

  a_t_traps = getEntArray("zombie_trap", "targetname");
  str_text = zm_utility::function_d6046228(#"hash_24a438482954901", #"hash_61d85c966dd9e83f");

  foreach(t_trap in a_t_traps) {
    if(!(isDefined(t_trap._trap_in_use) && t_trap._trap_in_use) && isDefined(t_trap.var_b3166dc1) && t_trap.var_b3166dc1) {
      t_trap zm_traps::trap_set_string(str_text, t_trap.zombie_cost);
    }
  }

  a_ai = getaiteamarray(level.zombie_team);

  foreach(ai in a_ai) {
    if(isalive(ai) && (ai.zm_ai_category === #"miniboss" || ai.zm_ai_category === #"heavy")) {
      ai.takedamage = 1;
      ai.allowdeath = 1;
      ai kill();
    }
  }

  level.var_153e9058 = 1;
  level.var_fe2bb2ac = 1;
  level zm_trial::function_25ee130(1);
  level thread function_70594057();
}

private on_end(round_reset) {
  callback::function_824d206(&function_33f0ddd3);
  level.var_153e9058 = undefined;
  level.var_fe2bb2ac = undefined;
  level zm_trial::function_25ee130(0);

  foreach(player in getplayers()) {
    player thread zm_trial_util::function_dc0859e();
    player zm_trial_util::function_7dbb1712(1);
  }

  a_t_traps = getEntArray("zombie_trap", "targetname");
  str_text = zm_utility::function_d6046228(#"hash_23c1c09e94181fdb", #"hash_6e8ef1b690e98e51");

  foreach(t_trap in a_t_traps) {
    if(!(isDefined(t_trap._trap_in_use) && t_trap._trap_in_use) && isDefined(t_trap.var_b3166dc1) && t_trap.var_b3166dc1) {
      t_trap zm_traps::trap_set_string(str_text, t_trap.zombie_cost);
    }
  }
}

private function_33f0ddd3(s_event) {
  if(s_event.event === "give_weapon" && !zm_loadout::function_2ff6913(s_event.weapon)) {
    self lockweapon(s_event.weapon, 1, 1);

    if(s_event.weapon.dualwieldweapon != level.weaponnone) {
      self lockweapon(s_event.weapon.dualwieldweapon, 1, 1);
    }

    if(s_event.weapon.altweapon != level.weaponnone) {
      self lockweapon(s_event.weapon.altweapon, 1, 1);
    }
  }
}

is_active() {
  s_challenge = zm_trial::function_a36e8c38(#"hash_149b9c514fee8fc3");
  return isDefined(s_challenge);
}

function_70594057() {
  level endon(#"hash_7646638df88a3656", #"end_game");
  level waittill(#"zombie_total_set");

  for(n_kills = 0; true; n_kills++) {
    level waittill(#"trap_kill", #"hash_528d7b7f7d6c51a1", #"hash_317f58ba0d580c27", #"hash_148b3ce521088846");
  }
}