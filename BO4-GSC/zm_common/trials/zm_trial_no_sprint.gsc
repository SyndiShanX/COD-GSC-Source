/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_no_sprint.gsc
***************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_no_sprint;

autoexec __init__system__() {
  system::register(#"zm_trial_no_sprint", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"no_sprint", &on_begin, &on_end);
}

private on_begin() {
  callback::on_spawned(&function_dc856fd8);

  foreach(player in getplayers()) {
    player allowsprint(0);
    player._allow_sprint = 0;
    player thread function_dc856fd8();
    player thread function_31f500f();
  }
}

private on_end(round_reset) {
  callback::remove_on_spawned(&function_dc856fd8);

  foreach(player in getplayers()) {
    player notify(#"allow_sprint");
    player._allow_sprint = undefined;
    player allowsprint(1);
  }
}

private function_dc856fd8() {
  self notify("374b3a40e7866d07");
  self endon("374b3a40e7866d07");
  self endon(#"disconnect", #"allow_sprint");
  self allowsprint(0);

  while(true) {
    self waittill(#"crafting_fail", #"crafting_success", #"bgb_update");

    if(isalive(self)) {
      self allowsprint(0);
    }
  }
}

private function_31f500f() {
  self endon(#"disconnect", #"allow_sprint");

  while(true) {
    if(isalive(self) && self sprintbuttonpressed()) {
      self zm_trial_util::function_97444b02();

      while(self sprintbuttonpressed()) {
        waitframe(1);
      }
    }

    waitframe(1);
  }
}