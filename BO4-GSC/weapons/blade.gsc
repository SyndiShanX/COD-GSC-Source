/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\blade.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace blade;

autoexec __init__system__() {
  system::register(#"blade", &__init__, undefined, undefined);
}

__init__() {
  level.weaponsigblade = getweapon(#"sig_blade");
  level.weaponsigbladeprojectile = getweapon(#"sig_blade_projectile");
  ability_player::register_gadget_activation_callbacks(11, &function_a1aa3b85, &function_b0105ee8);
}

function_efa90c79(weapon) {
  if(weapon === level.weaponsigblade) {
    self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 6);
    return true;
  } else if(weapon === level.weaponsigbladeprojectile) {
    self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 7);
    return true;
  }

  return false;
}

function_d6805ff5(weapon) {
  if(weapon === level.weaponsigblade) {
    self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
    return 1;
  }
}

function_a1aa3b85(abilityslot, weapon) {
  if(weapon !== level.weaponsigblade && weapon !== level.weaponsigbladeprojectile) {
    return;
  }

  self.var_f5455815 = 1;

  if(isDefined(self)) {
    self function_efa90c79(weapon);
  }

  self thread function_c5c8d661(weapon);

  while(isDefined(self.var_f5455815) && self.var_f5455815) {
    waitresult = self waittill(#"death", #"weapon_change");

    if(!self.var_f5455815) {
      break;
    }

    if(isDefined(self) && waitresult._notify == "weapon_change" && self function_efa90c79(waitresult.weapon)) {
      self thread function_c5c8d661(waitresult.weapon);
      continue;
    } else if(isDefined(self) && self isonladder()) {
      self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
      continue;
    }

    break;
  }

  if(isDefined(self)) {
    self notify(#"bladeended");
  }
}

function_b0105ee8(abilityslot, weapon) {
  if(isDefined(self)) {
    self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
    self notify(#"bladeended");
  }

  self.var_f5455815 = 0;
}

function_c5c8d661(weapon) {
  self notify("4066015d94dac5b3");
  self endon("4066015d94dac5b3");
  self endon(#"death");
  self endon(#"disconnect");
  self endon(#"bladeended");

  if(self isplayerswimming()) {
    self function_d6805ff5(weapon);
  }

  while(true) {
    ret = self waittill(#"swimming_begin", #"swimming_end");

    switch (ret._notify) {
      case #"swimming_begin":
        self function_d6805ff5(weapon);
        break;
      case #"swimming_end":
        self function_efa90c79(weapon);
        break;
    }
  }
}