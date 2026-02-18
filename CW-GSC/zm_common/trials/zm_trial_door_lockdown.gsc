/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_door_lockdown.gsc
*******************************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#namespace zm_trial_door_lockdown;

function private autoexec __init__system__() {
  system::register(#"zm_trial_door_lockdown", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  clientfield::register("scriptmover", "" + # "zm_trial_door_lockdown", 16000, 1, "int");
  zm_trial::register_challenge(#"door_lockdown", &on_begin, &on_end);
}

function private on_begin() {
  function_58fc4e38(8);
  level flag::set(#"disable_fast_travel");
  var_57ba058f = getEntArray("gondola_call_trigger", "targetname");
  var_9ce0aba1 = getEntArray("gondola_move_trigger", "targetname");
  array::run_all(var_57ba058f, &setinvisibletoall);
  array::run_all(var_9ce0aba1, &setinvisibletoall);
}

function private on_end(round_reset) {
  level flag::clear(#"disable_fast_travel");
  var_57ba058f = getEntArray("gondola_call_trigger", "targetname");
  var_9ce0aba1 = getEntArray("gondola_move_trigger", "targetname");
  array::run_all(var_57ba058f, &setvisibletoall);
  array::run_all(var_9ce0aba1, &setvisibletoall);
  function_92f23ef0();
}

function is_active() {
  s_challenge = zm_trial::function_a36e8c38(#"door_lockdown");
  return isDefined(s_challenge);
}

function function_58fc4e38(n_delay = 0) {
  level endon(#"hash_7646638df88a3656");
  wait n_delay;
  a_s_blockers = struct::get_array("trials_door_lockdown_clip");

  foreach(s_blocker in a_s_blockers) {
    if(!isDefined(s_blocker.mdl_blocker)) {
      s_blocker.mdl_blocker = util::spawn_model(isDefined(s_blocker.model) ? s_blocker.model : # "collision_player_wall_128x128x10", s_blocker.origin, s_blocker.angles);
    }

    s_blocker.mdl_blocker ghost();
    util::wait_network_frame();
    s_blocker.mdl_blocker clientfield::set("" + # "zm_trial_door_lockdown", 1);
  }
}

function function_92f23ef0(n_delay = 0) {
  level endon(#"hash_7646638df88a3656");
  wait n_delay;
  a_s_blockers = struct::get_array("trials_door_lockdown_clip");

  foreach(s_blocker in a_s_blockers) {
    if(isDefined(s_blocker.mdl_blocker)) {
      s_blocker.mdl_blocker clientfield::set("" + # "zm_trial_door_lockdown", 0);
      util::wait_network_frame();
      s_blocker.mdl_blocker delete();
    }
  }
}