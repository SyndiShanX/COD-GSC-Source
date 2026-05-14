/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_no_player_death.gsc
*********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#namespace zm_trial_no_player_death;

autoexec __init__system__() {
  system::register(#"zm_trial_no_player_death", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"no_player_death", &on_begin, &on_end);
}

on_begin() {
  foreach(player in getplayers()) {
    player callback::on_laststand(&on_player_laststand);
  }
}

on_end(round_reset) {
  foreach(player in getplayers()) {
    player callback::remove_on_laststand(&on_player_laststand);
  }
}

on_player_laststand() {
  var_57807cdc = [];
  array::add(var_57807cdc, self, 0);
  zm_trial::fail(#"hash_272fae998263208b", var_57807cdc);
}