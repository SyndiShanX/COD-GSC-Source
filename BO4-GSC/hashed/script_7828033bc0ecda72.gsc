/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_7828033bc0ecda72.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;

#namespace namespace_7499819f;

autoexec __init__system__() {
  system::register(#"hash_3887e77731340f48", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_b143bd998abdd27", &on_begin, &on_end);
}

private on_begin() {
  foreach(player in getplayers()) {
    player callback::on_laststand(&on_player_laststand);
  }
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player callback::remove_on_laststand(&on_player_laststand);
  }
}

private on_player_laststand() {
  var_57807cdc = [];
  array::add(var_57807cdc, self, 0);
  zm_trial::fail(#"hash_272fae998263208b", var_57807cdc);
}