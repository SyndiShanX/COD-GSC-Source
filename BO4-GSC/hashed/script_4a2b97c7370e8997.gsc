/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_4a2b97c7370e8997.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm\zm_office_elevators;
#include scripts\zm\zm_office_teleporters;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_office_disable_teleporters_elevators;

autoexec __init__system__() {
  system::register(#"zm_trial_office_disable_teleporters_elevators", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_teleporters_elevators", &on_begin, &on_end);
}

private on_begin() {
  self function_3b7e62cf();
  self function_28dce407();
}

private on_end(round_reset) {
  self function_72c09628();
  self function_8209b7a5();
}

private function_3b7e62cf() {
  elevator1 = getent("elevator1", "targetname");
  elevator2 = getent("elevator2", "targetname");
  elevator1 thread function_98c1b6be();
  elevator2 thread function_98c1b6be();
}

private function_98c1b6be() {
  if(self.active === 1) {
    self waittill(#"hash_26d932820f7f5373");
  }

  self zm_office_elevators::disable_callboxes();
  self zm_office_elevators::disable_elevator_buys();
}

private function_28dce407() {
  zm_office_teleporters::function_a6bb56f6();
}

private function_72c09628() {
  elevator1 = getent("elevator1", "targetname");
  elevator2 = getent("elevator2", "targetname");
  elevator1 zm_office_elevators::enable_callboxes();
  elevator1 zm_office_elevators::enable_elevator_buys();
  elevator2 zm_office_elevators::enable_callboxes();
  elevator2 zm_office_elevators::enable_elevator_buys();
}

private function_8209b7a5() {
  zm_office_teleporters::function_cc9b97b0();
}