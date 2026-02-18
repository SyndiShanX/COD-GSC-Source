/**********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_board_everything.gsc
**********************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#namespace zm_trial_board_everything;

function private autoexec __init__system__() {
  system::register(#"zm_trial_board_everything", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"board_everything", &on_begin, &on_end);
}

function private on_begin() {
  zm_powerups::function_74b8ec6b("carpenter");
  level thread function_4172344e();
}

function private on_end(round_reset) {
  if(!round_reset && level.var_3de460b1 < level.var_70135c38) {
    zm_trial::fail(#"hash_e0fa688fb248886");
  }

  level.var_3de460b1 = undefined;
  level.var_70135c38 = undefined;
  zm_trial_util::function_f3dbeda7();
  zm_powerups::function_41cedb05("carpenter");
}

function function_4172344e() {
  level endon(#"hash_7646638df88a3656");

  while(true) {
    level.var_70135c38 = level.exterior_goals.size;
    level.var_3de460b1 = 0;

    foreach(s_barrier in level.exterior_goals) {
      if(zm_utility::all_chunks_intact(s_barrier, s_barrier.barrier_chunks) || zm_utility::no_valid_repairable_boards(s_barrier, s_barrier.barrier_chunks)) {
        level.var_3de460b1++;
      }
    }

    zm_trial_util::function_2976fa44(level.var_70135c38);
    zm_trial_util::function_dace284(level.var_3de460b1, 1);
    s_waitresult = level waittill(#"zombie_board_tear", #"board_repaired", #"carpenter_finished");
  }
}