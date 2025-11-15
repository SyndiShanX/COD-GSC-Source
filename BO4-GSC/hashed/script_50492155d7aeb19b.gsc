/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_50492155d7aeb19b.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_trial;

#namespace namespace_e87f6502;

autoexec __init__system__() {
  system::register(#"hash_32c6ae5e840ecca3", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_63788b93aa1642c1", &on_begin, &on_end);
}

private on_begin() {
  level.var_b31000be = 600;

  foreach(e_player in getplayers()) {
    e_player thread function_8bb2443b();
  }
}

private on_end(round_reset) {
  level.var_b31000be = undefined;
}

private function_8bb2443b() {
  level endon(#"hash_7646638df88a3656");
  self endon(#"death");

  while(true) {
    if(self clientfield::get_to_player("nova_crawler_gas_cloud_postfx_clientfield")) {
      self zm_custom::function_db030433();
      self zm_score::player_reduce_points("take_specified", level.var_b31000be);
    }

    wait 1;
  }
}