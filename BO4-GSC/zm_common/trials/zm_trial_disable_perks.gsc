/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_perks.gsc
*******************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_disable_perks;

autoexec __init__system__() {
  system::register(#"zm_trial_disable_perks", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_perks", &on_begin, &on_end);
}

private on_begin() {
  level zm_trial::function_2b3a3307(1);
  assert(isDefined(level.var_b8be892e));

  foreach(player in getplayers()) {
    player function_f0b698a7();

    if(!isDefined(player.var_7864a0f6)) {
      player.var_7864a0f6 = player zm_trial_util::function_3f8a4145(0);
      player function_85611c27();
    }
  }

  callback::on_revived(&function_776fbeaf);
  callback::on_laststand(&function_551412f6);
  zm_trial_util::function_8036c103();
}

private on_end(round_reset) {
  level zm_trial::function_2b3a3307(0);

  if(!round_reset) {
    foreach(player in getplayers()) {
      assert(isDefined(player.var_7864a0f6));
      player zm_trial_util::function_d37a769(player.var_7864a0f6);
      player function_2c0ae6d1();
      player.var_7864a0f6 = undefined;
    }
  }

  callback::remove_on_revived(&function_776fbeaf);
  callback::remove_on_laststand(&function_551412f6);
  zm_trial_util::function_302c6014();
}

is_active(var_34f09024 = 0) {
  if(var_34f09024 && zm_trial::function_48736df9(#"disable_perks")) {
    return true;
  }

  challenge = zm_trial::function_a36e8c38(#"disable_perks");
  return isDefined(challenge);
}

lose_perk(perk) {
  if(!is_active()) {
    return false;
  }

  slot = self zm_perks::function_c1efcc57(perk);

  if(slot != -1 && isDefined(self.var_7864a0f6) && isDefined(self.var_7864a0f6.var_149ec45c[slot]) && self.var_7864a0f6.var_149ec45c[slot] && !self zm_perks::function_e56d8ef4(perk)) {
    arrayremovevalue(self.var_cd5d9345, perk, 0);
    self.var_7864a0f6.var_149ec45c[slot] = 0;

    if(!isDefined(self.var_7864a0f6.var_6fdc9c9c)) {
      self.var_7864a0f6.var_6fdc9c9c = [];
    } else if(!isarray(self.var_7864a0f6.var_6fdc9c9c)) {
      self.var_7864a0f6.var_6fdc9c9c = array(self.var_7864a0f6.var_6fdc9c9c);
    }

    self.var_7864a0f6.var_6fdc9c9c[self.var_7864a0f6.var_6fdc9c9c.size] = slot;
    return true;
  }

  return false;
}

function_776fbeaf(s_params) {
  if(isDefined(self.var_fbc66a96) && self.var_fbc66a96 && isDefined(self.var_7864a0f6) && isarray(self.var_7864a0f6.var_149ec45c) && isarray(self.var_7864a0f6.var_6fdc9c9c)) {
    foreach(var_224c0c9c in self.var_7864a0f6.var_6fdc9c9c) {
      self.var_7864a0f6.var_149ec45c[var_224c0c9c] = 1;
    }

    self.var_7864a0f6.var_6fdc9c9c = undefined;
  }
}

function_551412f6() {
  if(isDefined(self.var_7864a0f6)) {
    self.var_7864a0f6.var_724d826b = undefined;
    self.var_7864a0f6.var_8dee79a9 = undefined;
    self.var_7864a0f6.var_d3f0257d = undefined;
  }
}

private function_f0b698a7() {
  self player::generate_weapon_data();
  self.var_4a17c2cb = self._generated_weapons;
  self._generated_current_weapon = undefined;
  self._generated_weapons = undefined;
}

private function_85611c27() {
  if(isDefined(self.var_7864a0f6.additional_primary_weapon)) {
    foreach(weapondata in self.var_4a17c2cb) {
      weapon = weapondata[#"weapon"];

      if(weapon === self.var_7864a0f6.additional_primary_weapon) {
        self.var_7864a0f6.var_dd9bd473 = weapondata;
        return;
      }
    }
  }
}

private function_2c0ae6d1() {
  assert(isDefined(self.var_4a17c2cb));
  var_4493e3e1 = isarray(self.var_7864a0f6.var_724d826b) && isinarray(self.var_7864a0f6.var_724d826b, #"specialty_additionalprimaryweapon");

  if((var_4493e3e1 || isinarray(self.var_466b927f, #"specialty_additionalprimaryweapon")) && isDefined(self.var_7864a0f6.additional_primary_weapon) && isDefined(self.var_7864a0f6.var_dd9bd473) && !self hasweapon(self.var_7864a0f6.additional_primary_weapon)) {
    self player::weapondata_give(self.var_7864a0f6.var_dd9bd473);
    self zm_trial_util::function_7f999aa0(self.var_7864a0f6);
  }

  self.var_4a17c2cb = undefined;
}