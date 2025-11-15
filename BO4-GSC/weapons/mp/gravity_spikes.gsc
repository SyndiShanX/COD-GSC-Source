/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\gravity_spikes.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\weapons\gravity_spikes;

#namespace gravity_spikes;

autoexec __init__system__() {
  system::register(#"gravity_spikes", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
  ability_player::register_gadget_activation_callbacks(7, &function_20bb376d, undefined);
}

function_20bb376d(abilityslot, weapon) {
  self battlechatter::function_bd715920(weapon, undefined, self getEye(), self);
  playFX("weapon/fx8_hero_grvity_slam_takeoff_3p", self.origin);

  if(isDefined(self.var_ea1458aa)) {
    self.var_ea1458aa.var_6799f1da = 0;

    if(!self isonground() && isDefined(self.var_700a5910) && isDefined(self.challenge_jump_begin) && self.var_700a5910 > self.challenge_jump_begin) {
      self.var_ea1458aa.var_6799f1da = 1;
    }
  }
}