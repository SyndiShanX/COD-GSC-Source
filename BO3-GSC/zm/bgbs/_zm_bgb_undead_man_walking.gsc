/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_undead_man_walking.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_undead_man_walking;

function autoexec __init__sytem__() {
  system::register("zm_bgb_undead_man_walking", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_undead_man_walking", "time", 240, & enable, undefined, undefined, undefined);
}

function enable() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  self thread function_40e95c74();
  if(bgb::increment_ref_count("zm_bgb_undead_man_walking")) {
    return;
  }
  function_b41dc007(1);
  spawner::add_global_spawn_function("axis", & function_f3d5076d);
}

function function_40e95c74() {
  self util::waittill_any("disconnect", "bled_out", "bgb_update");
  if(bgb::decrement_ref_count("zm_bgb_undead_man_walking")) {
    return;
  }
  spawner::remove_global_spawn_function("axis", & function_f3d5076d);
  function_b41dc007(0);
}

function function_b41dc007(b_walk = 1) {
  a_ai = getaiarray();
  for (i = 0; i < a_ai.size; i++) {
    var_3812f8bd = 0;
    if(isdefined(level.var_9e59cb5b)) {
      var_3812f8bd = [
        [level.var_9e59cb5b]
      ](a_ai[i]);
    } else if(isalive(a_ai[i]) && a_ai[i].archetype === "zombie" && a_ai[i].team === level.zombie_team) {
      var_3812f8bd = 1;
    }
    if(var_3812f8bd) {
      if(b_walk) {
        a_ai[i] zombie_utility::set_zombie_run_cycle_override_value("walk");
        continue;
      }
      a_ai[i] zombie_utility::set_zombie_run_cycle_restore_from_override();
    }
  }
}

function function_f3d5076d() {
  var_3812f8bd = 0;
  if(isdefined(level.var_9e59cb5b)) {
    var_3812f8bd = [
      [level.var_9e59cb5b]
    ](self);
  } else if(isalive(self) && self.archetype === "zombie" && self.team === level.zombie_team) {
    var_3812f8bd = 1;
  }
  if(var_3812f8bd) {
    self zombie_utility::set_zombie_run_cycle_override_value("walk");
  }
}