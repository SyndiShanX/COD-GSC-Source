/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\battleshield.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace battleshield;

autoexec __init__system__() {
  system::register(#"battleshield", &__init__, undefined, undefined);
}

__init__() {
  level.weaponsigbuckler = getweapon(#"sig_buckler");
  level.weaponsigbucklerlh = getweapon(#"sig_buckler_lh");
  level.weaponsigshieldturret = getweapon(#"sig_shield_turret");
  level.var_69aaf8f = getdvarfloat(#"hash_27445ccf68d30520", 5);
  ability_player::register_gadget_activation_callbacks(11, &function_e31bc59d, &linkcable_off_tele);
}

function_e31bc59d(abilityslot, weapon) {
  if(weapon != getweapon(#"sig_buckler_dw")) {
    return;
  }

  self.var_4233f7e5 = 1;
  self.var_70465a20 = gettime();

  if(!(isDefined(level.var_c4002ed1) && level.var_c4002ed1)) {
    if(isDefined(self)) {
      self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 1);
    }
  }

  self waittill(#"death", #"weapon_change");

  if(isDefined(self)) {
    self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
  }
}

linkcable_off_tele(abilityslot, weapon) {
  self.var_4233f7e5 = 0;
}