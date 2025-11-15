/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_27561a336793031c.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace namespace_980ebe0;

autoexec __init__system__() {
  system::register(#"hash_503c1b9ec21992cc", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_3493e071de24d8a1", &on_begin, &on_end);
}

private on_begin(var_53c7b205 = #"1") {
  level.var_53c7b205 = zm_trial::function_5769f26a(var_53c7b205);

  foreach(player in getplayers()) {
    player thread function_13db986c(level.var_53c7b205);
  }

  callback::on_spawned(&on_player_spawned);
}

private on_end(round_reset) {
  callback::remove_on_spawned(&on_player_spawned);
  level.var_53c7b205 = undefined;
}

private on_player_spawned() {
  self thread function_13db986c(level.var_53c7b205);
}

private function_13db986c(var_53c7b205) {
  self notify("48c46c9de397db92");
  self endon("48c46c9de397db92");
  self endon(#"death");
  level endon(#"hash_7646638df88a3656", #"end_game");
  self waittill(#"hash_7a32b2af2eef5415");

  while(true) {
    if(isalive(self) && !self laststand::player_is_in_laststand()) {
      self dodamage(var_53c7b205, self.origin);
    }

    wait 1;
  }
}