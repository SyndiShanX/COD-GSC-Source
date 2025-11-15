/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_undead_man_walking.gsc
********************************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_undead_man_walking;

autoexec __init__system__() {
  system::register(#"zm_bgb_undead_man_walking", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_undead_man_walking", "time", 60, &enable, undefined, undefined, undefined);
}

enable() {
  self endon(#"disconnect", #"bled_out", #"bgb_update");
  self thread function_da70ffac();

  if(bgb::increment_ref_count(#"zm_bgb_undead_man_walking")) {
    return;
  }

  function_8b96ace8(1);
  spawner::add_global_spawn_function(#"axis", &function_db1ee563);
}

function_da70ffac() {
  self waittill(#"disconnect", #"bled_out", #"bgb_update");

  if(bgb::decrement_ref_count(#"zm_bgb_undead_man_walking")) {
    return;
  }

  spawner::remove_global_spawn_function(#"axis", &function_db1ee563);
  function_8b96ace8(0);
}

function_8b96ace8(b_walk = 1) {
  a_ai = getaiarray();

  for(i = 0; i < a_ai.size; i++) {
    var_5d66253 = 0;

    if(isDefined(level.var_2f67e192)) {
      var_5d66253 = [
        [level.var_2f67e192]
      ](a_ai[i]);
    } else if(isalive(a_ai[i]) && (a_ai[i].zm_ai_category === #"basic" || a_ai[i].zm_ai_category === #"enhanced") && a_ai[i].team === level.zombie_team) {
      var_5d66253 = 1;
    }

    if(var_5d66253) {
      if(b_walk) {
        a_ai[i].zombie_move_speed_restore = a_ai[i].zombie_move_speed;
        a_ai[i].var_b518759e = 1;
        a_ai[i] zombie_utility::set_zombie_run_cycle_override_value("walk");
        continue;
      }

      a_ai[i].var_b518759e = undefined;
      a_ai[i] zombie_utility::set_zombie_run_cycle_restore_from_override();
    }
  }
}

function_db1ee563() {
  var_5d66253 = 0;

  if(isDefined(level.var_2f67e192)) {
    var_5d66253 = [[level.var_2f67e192]](self);
  } else if(isalive(self) && (self.zm_ai_category === #"basic" || self.zm_ai_category === #"enhanced") && self.team === level.zombie_team) {
    var_5d66253 = 1;
  }

  if(var_5d66253) {
    self.var_b518759e = 1;
    self zombie_utility::set_zombie_run_cycle_override_value("walk");
  }
}