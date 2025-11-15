/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_give_reward.gsc
*****************************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_utility;

#namespace zm_trial_give_reward;

autoexec __init__system__() {
  system::register(#"zm_trial_give_reward", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  level.var_5335b66f = associativearray(#"zm_zodt8_default", 1, #"zm_towers_default", 2, #"zm_office_default", 3, #"zm_escape_default", 4, #"zm_mansion_default", 5, #"zm_red_default", 6, #"zm_zodt8_variant_1", 7, #"zm_white_default", 8, #"zm_orange_default", 9);
  zm_trial::register_challenge(#"give_reward", &on_begin, &on_end);
  level.var_ee7ca64 = [];
}

private on_begin(var_c2964c77, description, image, challenge_stat, var_191009a6, trial_completed) {
  self.var_c2964c77 = var_c2964c77;
  self.challenge_stat = challenge_stat;
  self.var_191009a6 = var_191009a6;
  self.trial_completed = trial_completed === #"1";
}

private on_end(round_reset) {
  if(!round_reset && !level flag::get(#"trial_failed")) {
    self function_e7254828();

    if(isDefined(self.trial_completed) && self.trial_completed) {
      luinotifyevent(#"zm_trial_completed");

      foreach(player in getplayers()) {
        player zm_utility::giveachievement_wrapper("zm_trials_round_30");
      }
    }
  }
}

private function_e7254828() {
  assert(isDefined(level.var_6d87ac05) && isDefined(level.var_6d87ac05.name));
  assert(isDefined(level.var_5335b66f) && isDefined(level.var_5335b66f[level.var_6d87ac05.name]));
  var_93493c8 = level.var_5335b66f[level.var_6d87ac05.name];
  curr_time = gettime() - level.var_21e22beb;
  var_ee7ca64 = isDefined(level.var_ee7ca64[level.round_number]) && level.var_ee7ca64[level.round_number];

  if(isDefined(self.trial_completed) && self.trial_completed) {
    level.var_bccd8271 = curr_time;
  }

  foreach(player in getplayers()) {
    best_time = player zm_stats::function_8e274b32(self.var_c2964c77);

    if(best_time == 0 && !var_ee7ca64) {
      level.var_ee7ca64[level.round_number] = 1;
      player luinotifyevent(#"hash_8d33c3be569f08", 1, self.row);

      if(level.onlinegame) {
        player function_cce105c8(#"zm_gauntlet_reward", 1, var_93493c8, 2, level.round_number);
        player function_4835d26a();
      }
    }

    player zm_stats::function_31931250(self.var_c2964c77, curr_time);
    best_time = player zm_stats::function_b1520544(self.var_c2964c77);

    if(best_time == 0 || curr_time < best_time) {
      player zm_stats::function_49469f35(self.var_c2964c77, curr_time);
    }

    best_time = zm_stats::get_match_stat(self.var_c2964c77);

    if(best_time == 0 || curr_time < best_time) {
      zm_stats::set_match_stat(self.var_c2964c77, curr_time);
    }

    best_time = player zm_stats::function_e4358abd(self.var_c2964c77);

    if(best_time == 0 || curr_time < best_time) {
      player zm_stats::function_9daadcaa(self.var_c2964c77, curr_time);
    }

    if(isDefined(self.trial_completed) && self.trial_completed) {
      player notify(#"stop_player_monitor_time_played");
    }

    player zm_stats::increment_challenge_stat(self.challenge_stat, 1);

    if(level.round_number == 20) {
      player contracts::increment_zm_contract(#"contract_zm_gauntlet_silver");
    }

    if(zm_trial::function_ba9853db() == 0) {
      if(isDefined(self.var_191009a6)) {
        player zm_stats::increment_challenge_stat(self.var_191009a6, 1);
      }

      if(level.round_number == 10) {
        player contracts::increment_zm_contract(#"contract_zm_gauntlet_bronze");
      }
    }
  }
}