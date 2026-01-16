/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_zombie_speed_changes.gsc
**************************************************************/

#include script_24c32478acf44108;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace zm_trial_zombie_speed_changes;

autoexec __init__system__() {
  system::register(#"zm_trial_zombie_speed_changes", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"zombie_speed_changes", &on_begin, &on_end);
  namespace_9ff9f642::register_slowdown(#"zm_trial_zombie_speed_changes", 1.5);
}

private on_begin() {
  level thread function_4458377c();
  level thread zm_utility::play_sound_2d("zmb_trial_horror_round_start");
}

private on_end(round_reset) {}

private function_4458377c() {
  level endon(#"hash_7646638df88a3656");

  while(true) {
    a_ai_zombies = getaiteamarray(level.zombie_team);

    foreach(ai in a_ai_zombies) {
      if(!isalive(ai) || isDefined(ai.var_cda2fa8) && ai.var_cda2fa8) {
        continue;
      }

      e_player = arraygetclosest(ai.origin, getplayers());

      if(isplayer(e_player) && distance(ai.origin, e_player.origin) > 100) {
        ai thread function_fe65f5a6(randomfloatrange(1.25, 1.5), e_player);
      } else if(math::cointoss(20)) {
        ai thread function_fe65f5a6(randomfloatrange(1.1, 1.25), e_player);
      }

      waitframe(1);
    }

    n_wait_time = randomfloatrange(1, 2);
    wait n_wait_time;
  }
}

function_fe65f5a6(var_b7358df3, e_player, n_timeout = 1) {
  self endon(#"death");
  self.var_cda2fa8 = 1;

  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area) && self.archetype !== #"zombie_dog") {
    self waittill(#"completed_emerging_into_playable_area");
  }

  self thread namespace_9ff9f642::slowdown(#"zm_trial_zombie_speed_changes", 0.75);
  n_delay_time = randomfloatrange(2, 5);
  wait n_delay_time;
  self thread namespace_9ff9f642::slowdown(#"zm_trial_zombie_speed_changes", var_b7358df3);
  self playSound(#"hash_46661e1d0062f53b");

  if(math::cointoss(20)) {
    if(isDefined(e_player) && isalive(e_player)) {
      if(e_player islookingat(self)) {
        self playsoundtoplayer(#"hash_69671b54d86128ce", e_player);
      }
    }
  }

  n_timer = 0;

  while(n_timer < n_timeout) {
    if(isalive(e_player) && distance(e_player.origin, self.origin) < 100) {
      break;
    }

    n_timer += float(function_60d95f53()) / 1000;
    waitframe(1);
  }

  self thread namespace_9ff9f642::slowdown(#"zm_trial_zombie_speed_changes", 0.75);
  self.var_cda2fa8 = undefined;
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"zombie_speed_changes");
  return isDefined(challenge);
}