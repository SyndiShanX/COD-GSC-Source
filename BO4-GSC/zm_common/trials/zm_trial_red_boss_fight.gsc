/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_red_boss_fight.gsc
********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_red_boss_battle;
#include scripts\zm\zm_red_fasttravel;
#include scripts\zm_common\zm_aoe;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_red_boss_fight;

autoexec __init__system__() {
  system::register(#"zm_trial_red_boss_fight", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"red_boss_fight", &on_begin, &on_end);
}

private on_begin() {
  if(!isDefined(level.var_27a02034)) {
    level.var_27a02034 = 0;
  }

  level thread start_boss_fight();
}

private on_end(round_reset) {
  if(round_reset) {
    level.var_27a02034 = 1;
    zm_aoe::function_3690781e();
  } else {
    level.check_for_valid_spawn_near_team_callback = level.var_5b175281;
    level.var_5b175281 = undefined;
  }

  level flag::clear(#"infinite_round_spawning");
  level flag::clear(#"pause_round_timeout");
}

private start_boss_fight() {
  level endon(#"end_game", #"hash_7646638df88a3656");

  level flag::set("<dev string:x38>");
  level flag::set(#"pap_quest_completed");
  level flag::set(#"zm_red_fasttravel_open");

    level.var_5b175281 = level.check_for_valid_spawn_near_team_callback;
  level.check_for_valid_spawn_near_team_callback = &function_7d23aaf2;

  if(level.var_27a02034) {
    red_boss_battle::function_dfaf17c8();
    level thread red_boss_battle::function_3a2efd4e(0, 0, 0);
  } else {
    wait 12;
    level lui::screen_fade_out(1);
    level thread red_boss_battle::function_3a2efd4e(0, 0, 1);
    wait 0.5;
    level thread lui::screen_fade_in(1);
  }

  level flag::wait_till(#"boss_battle_complete");
  level flag::clear(#"infinite_round_spawning");
  level flag::clear(#"pause_round_timeout");
  level.zombie_total = 0;
  wait 5;
  level notify(#"kill_round_wait");
}

function_7d23aaf2(player, var_feed7374) {
  var_62b2df56 = struct::get_array("s_boss_arena_teleport");
  n_ent_num = player getentitynumber();
  return var_62b2df56[n_ent_num];
}