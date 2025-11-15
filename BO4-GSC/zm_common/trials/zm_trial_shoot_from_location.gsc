/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_shoot_from_location.gsc
*************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_shoot_from_location;

autoexec __init__system__() {
  system::register(#"zm_trial_shoot_from_location", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"shoot_from_location", &on_begin, &on_end);
}

private on_begin() {
  if(util::get_map_name() == "zm_office") {
    elevator1 = getent("elevator1", "targetname");
    elevator2 = getent("elevator2", "targetname");
    elevator1.cost = 0;
    elevator2.cost = 0;
    trigger1 = getent(elevator1.targetname + "_buy", "script_noteworthy");
    trigger2 = getent(elevator2.targetname + "_buy", "script_noteworthy");
    trigger1 sethintstring(level.var_31560d97, elevator1.cost);
    trigger2 sethintstring(level.var_31560d97, elevator2.cost);
  }

  str_targetname = "trials_shoot_from_location";
  level.var_7f31a12d = getEntArray(str_targetname, "targetname");
  assert(level.var_7f31a12d.size, "<dev string:x38>");
  callback::function_33f0ddd3(&function_33f0ddd3);

  foreach(player in getplayers()) {
    player thread function_3658663();
  }
}

private on_end(round_reset) {
  callback::function_824d206(&function_33f0ddd3);

  if(util::get_map_name() == "zm_office") {
    elevator1 = getent("elevator1", "targetname");
    elevator2 = getent("elevator2", "targetname");
    elevator1.cost = 500;
    elevator2.cost = 500;
    trigger1 = getent(elevator1.targetname + "_buy", "script_noteworthy");
    trigger2 = getent(elevator2.targetname + "_buy", "script_noteworthy");
    trigger1 sethintstring(level.var_31560d97, elevator1.cost);
    trigger2 sethintstring(level.var_31560d97, elevator2.cost);
  }

  foreach(player in getplayers()) {
    player thread zm_trial_util::function_dc0859e();
  }

  level.var_7f31a12d = undefined;
}

private function_3658663() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");
  var_407eb07 = 0;

  while(true) {
    var_f2b6fe6e = 0;

    foreach(var_3953f2a9 in level.var_7f31a12d) {
      if(self istouching(var_3953f2a9)) {
        var_f2b6fe6e = 1;
        break;
      }
    }

    if(var_f2b6fe6e && var_407eb07) {
      self zm_trial_util::function_dc0859e();
      var_407eb07 = 0;
    } else if(!var_f2b6fe6e && !var_407eb07) {
      self zm_trial_util::function_bf710271();
      var_407eb07 = 1;
    }

    waitframe(1);
  }
}

private function_33f0ddd3(s_event) {
  if(s_event.event === "give_weapon") {
    var_f2b6fe6e = 0;

    foreach(var_3953f2a9 in level.var_7f31a12d) {
      if(self istouching(var_3953f2a9)) {
        var_f2b6fe6e = 1;
        break;
      }
    }

    if(!var_f2b6fe6e && !zm_loadout::function_2ff6913(s_event.weapon)) {
      self lockweapon(s_event.weapon, 1, 1);
    }
  }
}