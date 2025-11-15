/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_ctrl_z.gsc
***********************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\aats\zm_aat_brain_decay;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_stats;

#namespace zm_bgb_ctrl_z;

autoexec __init__system__() {
  system::register(#"zm_bgb_ctrl_z", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_ctrl_z", "time", 30, &enable, &disable, &validation, undefined);
}

enable() {
  self endon(#"disconnect", #"bled_out", #"bgb_update");
  a_ai_targets = function_880a86b2();
  self.var_89221e7d = 0;

  if(a_ai_targets.size > 2) {
    var_87cb7224 = [];
    var_db50d438 = [];

    foreach(ai in a_ai_targets) {
      if(!self function_80d68e4d(ai, 0.766, 0)) {
        if(!isDefined(var_87cb7224)) {
          var_87cb7224 = [];
        } else if(!isarray(var_87cb7224)) {
          var_87cb7224 = array(var_87cb7224);
        }

        var_87cb7224[var_87cb7224.size] = ai;
        continue;
      }

      if(!isDefined(var_db50d438)) {
        var_db50d438 = [];
      } else if(!isarray(var_db50d438)) {
        var_db50d438 = array(var_db50d438);
      }

      var_db50d438[var_db50d438.size] = ai;
    }

    a_ai_targets = arraycombine(var_87cb7224, var_db50d438, 0, 0);
  }

  for(x = 0; x < a_ai_targets.size; x++) {
    if(a_ai_targets[x] zm_aat_brain_decay::function_682e5375()) {
      a_ai_targets[x].var_b518759e = undefined;
      a_ai_targets[x] zombie_utility::set_zombie_run_cycle_restore_from_override();
      a_ai_targets[x] thread turn_z(self);
    }
  }
}

disable() {
  self.var_89221e7d = undefined;
}

validation() {
  a_ai_targets = function_880a86b2();

  if(a_ai_targets.size) {
    return true;
  }

  return false;
}

turn_z(player) {
  if(player.var_89221e7d < 2) {
    player.var_89221e7d++;
    self thread clientfield::set("zm_aat_brain_decay", 1);
    self thread zombie_death_time_limit(player);
    self.team = #"allies";
    self.aat_turned = 1;
    self.n_aat_turned_zombie_kills = 0;
    self.takedamage = 0;
    self.allowdeath = 0;
    self.allowpain = 0;
    self.b_ignore_cleanup = 1;

    if(self.archetype === #"zombie") {
      self zombie_utility::set_zombie_run_cycle("sprint");

      if(math::cointoss()) {
        if(self.zombie_arms_position == "up") {
          self.variant_type = 6;
        } else {
          self.variant_type = 7;
        }
      } else if(self.zombie_arms_position == "up") {
        self.variant_type = 7;
      } else {
        self.variant_type = 8;
      }
    }

    if(isplayer(player)) {
      player zm_stats::increment_challenge_stat(#"zombie_hunter_brain_decay");
      self.var_443d78cc = player;
    }

    self thread zm_aat_brain_decay::function_8e97a3a4(player, level.weapondefault);
    self thread zm_aat_brain_decay::zombie_kill_tracker(player);
  }
}

zombie_death_time_limit(e_attacker) {
  self endon(#"death");
  wait 30;
  self clientfield::set("zm_aat_brain_decay", 0);
  self clientfield::increment("zm_aat_brain_decay_exp", 1);
  var_8651a024 = self getcentroid();
  waitframe(1);
  self.takedamage = 1;
  self.allowdeath = 1;
  self zm_aat_brain_decay::zombie_death_explosion(var_8651a024, e_attacker);
  self zm_aat_brain_decay::zombie_death_gib(e_attacker);
}

function_880a86b2() {
  a_ai_targets = getaispeciesarray(level.zombie_team, "all");
  var_c5e280bb = [];

  foreach(ai in a_ai_targets) {
    if(ai.archetype === #"zombie") {
      if(!isDefined(var_c5e280bb)) {
        var_c5e280bb = [];
      } else if(!isarray(var_c5e280bb)) {
        var_c5e280bb = array(var_c5e280bb);
      }

      var_c5e280bb[var_c5e280bb.size] = ai;
    }
  }

  a_ai_targets = arraysortclosest(var_c5e280bb, self getorigin(), a_ai_targets.size, 0, 400);
  a_ai_targets = array::remove_dead(var_c5e280bb);
  a_ai_targets = array::remove_undefined(var_c5e280bb);
  return var_c5e280bb;
}