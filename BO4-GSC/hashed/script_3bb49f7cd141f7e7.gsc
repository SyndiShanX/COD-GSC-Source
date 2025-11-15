/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_3bb49f7cd141f7e7.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_weapons;

#namespace namespace_5c493a54;

autoexec __init__system__() {
  system::register(#"hash_23b914dca866a297", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_b7f913776f85df2", &on_begin, &on_end);
}

private on_begin(var_2e5ed433, var_1532dab3, var_94d24883) {
  level.var_2e5ed433 = zm_trial::function_5769f26a(var_2e5ed433) * 1000;

  if(isDefined(var_1532dab3)) {
    var_1532dab3 = zm_trial::function_5769f26a(var_1532dab3);
  }

  if(isDefined(var_94d24883)) {
    var_94d24883 = zm_trial::function_5769f26a(var_94d24883);
  }

  foreach(player in getplayers()) {
    player thread point_watcher(var_1532dab3, var_94d24883);
  }
}

private on_end(round_reset) {
  level.var_2e5ed433 = undefined;
  level notify(#"hash_2669c6e7b1eb2e4b");
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"hash_b7f913776f85df2");
  return isDefined(challenge);
}

private point_watcher(var_1532dab3 = 1, var_94d24883 = 0.9) {
  level endon(#"hash_2669c6e7b1eb2e4b", #"end_game", #"hash_7646638df88a3656");
  self endon(#"disconnect");
  wait 15;

  while(true) {
    if(isalive(self) && !self laststand::player_is_in_laststand() && isDefined(self.score) && self.score > level.var_2e5ed433) {
      self dodamage(var_1532dab3, self.origin);
      wait var_94d24883;
    }

    waitframe(1);
  }
}