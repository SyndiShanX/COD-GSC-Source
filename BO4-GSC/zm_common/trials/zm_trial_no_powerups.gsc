/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_no_powerups.gsc
*****************************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_no_powerups;

autoexec __init__system__() {
  system::register(#"zm_trial_no_powerups", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"no_powerups", &on_begin, &on_end);
}

private on_begin() {
  self.active = 1;
  self.enemies_killed = 0;
  zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 80);
  zm_spawner::register_zombie_death_event_callback(&function_138aec8e);
  kill_count = zm_powerups::function_2ff352cc();

  if(!isDefined(level.var_1dce56cc) || kill_count < level.var_1dce56cc) {
    level.var_1dce56cc = kill_count;
  }
}

private on_end(round_reset) {
  self.active = 0;
  zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 4);
  level.var_1dce56cc = level.n_total_kills + randomintrangeinclusive(15, 25);
  zombie_utility::set_zombie_var(#"zombie_drop_item", 0);
  zm_spawner::deregister_zombie_death_event_callback(&function_138aec8e);
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"no_powerups");
  return isDefined(challenge) && isDefined(challenge.active) && challenge.active;
}

function_2fc5f13() {
  challenge = zm_trial::function_a36e8c38(#"no_powerups");
  assert(isDefined(challenge));
  var_5843af96 = zm_round_logic::get_zombie_count_for_round(level.round_number, getplayers().size);
  frac = math::clamp(challenge.enemies_killed / var_5843af96, 0, 1);
  modifier = lerpfloat(25, 40, frac);
  return modifier;
}

private function_138aec8e(attacker) {
  if(!isplayer(attacker) && !(isDefined(self.nuked) && self.nuked)) {
    return;
  }

  challenge = zm_trial::function_a36e8c38(#"no_powerups");
  assert(isDefined(challenge));
  challenge.enemies_killed++;
}