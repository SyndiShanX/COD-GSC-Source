/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_45993630a26b2d85.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_weapons;

#namespace namespace_983e5028;

autoexec __init__system__() {
  system::register(#"hash_1633972af838a447", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_2fc73bc20035fe8", &on_begin, &on_end);
}

private on_begin(var_d34d02af) {
  level.var_d34d02af = zm_trial::function_5769f26a(var_d34d02af);
  callback::on_weapon_fired(&on_weapon_fired);

  foreach(player in getplayers()) {
    player thread function_a5a431f6();
  }
}

private on_end(round_reset) {
  callback::remove_on_weapon_fired(&on_weapon_fired);
  level.var_d34d02af = undefined;
}

private on_weapon_fired(params) {
  if(zm_weapons::is_explosive_weapon(params.weapon)) {
    self zm_score::player_reduce_points("take_specified", level.var_d34d02af * 2);
    return;
  }

  self zm_score::player_reduce_points("take_specified", level.var_d34d02af);
}

private function_a5a431f6() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");

  while(true) {
    s_waitresult = self waittill(#"ammo_reduction", #"lightning_ball_created");
    self zm_score::player_reduce_points("take_specified", level.var_d34d02af);
  }
}