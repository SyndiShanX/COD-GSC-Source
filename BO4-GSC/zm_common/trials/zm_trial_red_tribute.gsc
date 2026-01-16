/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_red_tribute.gsc
*****************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_red_challenges_rewards;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_red_tribute;

autoexec __init__system__() {
  system::register(#"zm_trial_red_tribute", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"red_tribute", &on_begin, &on_end);
}

private on_begin() {
  foreach(player in getplayers()) {
    player thread function_29bcf2f8();
  }

  callback::on_ai_spawned(&on_ai_spawned);
  callback::on_ai_killed(&on_ai_killed);
  level.var_ddd04c77 = 0;
  level thread function_6fa5c86();
}

private on_end(round_reset) {
  if(!round_reset) {
    var_ef7fbb73 = [];

    foreach(player in getplayers()) {
      if(!player.var_bfc22435) {
        if(!isDefined(var_ef7fbb73)) {
          var_ef7fbb73 = [];
        } else if(!isarray(var_ef7fbb73)) {
          var_ef7fbb73 = array(var_ef7fbb73);
        }

        var_ef7fbb73[var_ef7fbb73.size] = player;
      }
    }

    if(var_ef7fbb73.size) {
      zm_trial::fail(undefined, var_ef7fbb73);
    }
  }

  foreach(player in getplayers()) {
    player.var_bfc22435 = undefined;
    player zm_trial_util::function_f3aacffb();
  }

  level flag::clear("infinite_round_spawning");
  level.var_ddd04c77 = undefined;
  callback::remove_on_ai_spawned(&on_ai_spawned);
  callback::remove_on_ai_killed(&on_ai_killed);
}

private function_29bcf2f8() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");
  self.var_bfc22435 = 0;

  if(isDefined(self.var_7a281a7e)) {
    self.var_7a281a7e.b_timeout = 1;
  }

  if(isarray(level.var_d1c9bbc4)) {
    arrayremovevalue(level.var_d1c9bbc4, undefined);

    foreach(var_8c04c69e in level.var_d1c9bbc4) {
      var_8c04c69e.b_timeout = 1;
    }
  }

  self notify(#"challenge_reward_timeout");
  self notify(#"spew_reward_picked_up");

  if(isDefined(self.s_tribute_bowl) && isDefined(self.s_tribute_bowl.var_9d32404)) {
    self.s_tribute_bowl.var_9d32404 clientfield::set("" + #"hash_21f5fab6a3d22093", 0);
  }

  self zm_red_challenges_rewards::set_tribute(0);
  self zm_red_challenges_rewards::function_ae2c0ba5();
  self zm_trial_util::function_63060af4(0);

  while(true) {
    s_waitresult = self waittill(#"hash_24326081081c2468");

    if(s_waitresult.var_9e09931e === 4) {
      self.var_bfc22435 = 1;
      self zm_trial_util::function_63060af4(1);
      return;
    }
  }
}

private function_6fa5c86() {
  level endon(#"hash_7646638df88a3656");
  level flag::set("infinite_round_spawning");

  while(true) {
    var_84579c01 = 1;

    foreach(player in getplayers()) {
      if(isalive(player) && !(isDefined(player.var_bfc22435) && player.var_bfc22435)) {
        var_84579c01 = 0;
        break;
      }
    }

    if(var_84579c01) {
      level flag::clear("infinite_round_spawning");
      return;
    }

    wait 1;
  }
}

on_ai_spawned() {
  self thread track_spawns();
}

private track_spawns() {
  self endon(#"death");
  level endon(#"hash_7646638df88a3656");
  wait 1;

  if(!(isDefined(self.var_12745932) && self.var_12745932)) {
    level.var_ddd04c77++;

    if(level.var_ddd04c77 >= level.var_38b15968) {
      self zm_score::function_acaab828(1);
    }
  }
}

on_ai_killed(params) {
  if(isDefined(self.b_cleaned_up) && self.b_cleaned_up) {
    level.var_ddd04c77--;
  }
}

is_active() {
  s_challenge = zm_trial::function_a36e8c38(#"red_tribute");
  return isDefined(s_challenge);
}