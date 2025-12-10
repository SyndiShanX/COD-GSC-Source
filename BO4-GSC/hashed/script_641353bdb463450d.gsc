/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_641353bdb463450d.gsc
***********************************************/

#using script_2595527427ea71eb;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#namespace namespace_724be82b;

autoexec __init__system__() {
  system::register(#"hash_262f628396f811df", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }
  zm_trial::register_challenge(#"teleporter_timeout", &on_begin, &on_end);
}

private on_begin(timeout_time, var_ee246467) {
  self.timeout_time = zm_trial::function_9b72fb1a(timeout_time);
  foreach(player in getplayers()) {
    player thread function_9e885f2b(self, var_ee246467);
    player thread damage_monitor();
  }
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player.var_2bdd0abc = undefined;
    player zm_trial_util::stop_timer();
    level.var_bb57ff69 zm_trial_timer::close(player);
  }
}

private function_9e885f2b(challenge, var_ee246467) {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");
  wait 12;
  self.var_2bdd0abc = level.time + challenge.timeout_time * 1000;
  level.var_bb57ff69 zm_trial_timer::open(self);
  level.var_bb57ff69 zm_trial_timer::set_timer_text(self, var_ee246467);
  self zm_trial_util::start_timer(challenge.timeout_time);
  while(true) {
    self waittill(#"teleporting");
    if(level.var_bb57ff69 zm_trial_timer::is_open(self)) {
      level.var_bb57ff69 zm_trial_timer::close(self);
    }
    self zm_trial_util::stop_timer();
    wait 3.75;
    if(!level.var_bb57ff69 zm_trial_timer::is_open(self)) {
      level.var_bb57ff69 zm_trial_timer::open(self);
    }
    self zm_trial_util::start_timer(challenge.timeout_time);
    self.var_2bdd0abc = level.time + challenge.timeout_time * 1000;
  }
}

private damage_monitor() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");
  wait 12;
  while(true) {
    if(self.var_2bdd0abc < level.time && self.sessionstate != "spectator" && !self laststand::player_is_in_laststand() && !(isDefined(self.var_e99541c5) && self.var_e99541c5)) {
      if(level.var_bb57ff69 zm_trial_timer::is_open(self)) {
        level.var_bb57ff69 zm_trial_timer::close(self);
      }
      var_b32f7076 = int(self.maxhealth * 0.0667);
      if(self.health <= var_b32f7076) {
        if(zm_utility::is_magic_bullet_shield_enabled(self)) {
          self util::stop_magic_bullet_shield();
        }
        self dodamage(self.health + 1000, self.origin);
        waitframe(1);
      } else {
        self.health -= var_b32f7076;
        wait 1;
      }
      continue;
    }
    waitframe(1);
  }
}