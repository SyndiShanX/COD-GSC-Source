/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_upgrade_multiple.gsc
**********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_weapons;

#namespace zm_trial_upgrade_multiple;

autoexec __init__system__() {
  system::register(#"zm_trial_upgrade_multiple", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"upgrade_multiple", &on_begin, &on_end);
}

private on_begin(n_count, n_repacks) {
  assert(isDefined(level.zombie_weapons_upgraded));
  level.var_ab9d0ec6 = [];

  foreach(weapon in getarraykeys(level.zombie_weapons_upgraded)) {
    if(weapon != level.weaponnone) {
      if(!isDefined(level.var_ab9d0ec6)) {
        level.var_ab9d0ec6 = [];
      } else if(!isarray(level.var_ab9d0ec6)) {
        level.var_ab9d0ec6 = array(level.var_ab9d0ec6);
      }

      if(!isinarray(level.var_ab9d0ec6, weapon)) {
        level.var_ab9d0ec6[level.var_ab9d0ec6.size] = weapon;
      }
    }
  }

  self.var_5ba20db5 = zm_trial::function_5769f26a(n_count);

  if(isDefined(n_repacks)) {
    self.var_5027af68 = zm_trial::function_5769f26a(n_repacks);
  } else {
    self.var_5027af68 = 0;
  }

  foreach(player in getplayers()) {
    player thread function_e73fbbf7(self.var_5ba20db5, self.var_5027af68);
  }
}

private on_end(round_reset) {
  foreach(player in getplayers()) {
    player zm_trial_util::function_f3aacffb();
  }

  assert(isDefined(level.var_ab9d0ec6));
  assert(isDefined(level.var_ab9d0ec6.size > 0));

  if(!round_reset) {
    var_696c3b4 = [];

    foreach(player in getplayers()) {
      if(player.var_c2490d61 === 0) {
        if(!isDefined(var_696c3b4)) {
          var_696c3b4 = [];
        } else if(!isarray(var_696c3b4)) {
          var_696c3b4 = array(var_696c3b4);
        }

        if(!isinarray(var_696c3b4, player)) {
          var_696c3b4[var_696c3b4.size] = player;
        }
      }

      player.var_c2490d61 = undefined;
    }

    if(var_696c3b4.size == 1) {
      zm_trial::fail(#"hash_753fe45bee19e131", var_696c3b4);
    } else if(var_696c3b4.size > 1) {
      zm_trial::fail(#"hash_3539a53b7cf9ea2", var_696c3b4);
    }
  }

  self.var_5ba20db5 = undefined;
}

private function_e73fbbf7(var_5ba20db5, var_27f8d634) {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");
  self.var_c2490d61 = 0;
  var_fa5d7ea0 = 0;

  while(true) {
    self function_46feb36d(var_5ba20db5, var_27f8d634);
    w_curr = self getcurrentweapon();

    if(self.var_c2490d61) {
      if(!var_fa5d7ea0) {
        self zm_trial_util::function_63060af4(1);
        var_fa5d7ea0 = 1;
      }
    } else if(zm_weapons::weapon_supports_aat(w_curr) && var_27f8d634 > 0) {
      self zm_trial_util::function_63060af4(0);
      self zm_trial_util::function_f3aacffb();
      n_repacks = zm_pap_util::function_83c29ddb(w_curr);
      self zm_trial_util::function_c2cd0cba(var_27f8d634);
      self zm_trial_util::function_2190356a(n_repacks);
      var_fa5d7ea0 = 0;
    } else {
      if(zm_weapons::is_weapon_upgraded(w_curr)) {
        self zm_trial_util::function_63060af4(1);
      } else {
        self zm_trial_util::function_63060af4(0);
      }

      var_fa5d7ea0 = 0;
    }

    self waittill(#"weapon_change_complete");
  }
}

private function_46feb36d(var_5ba20db5, var_27f8d634) {
  if(self.sessionstate != "spectator") {
    var_6c114dfb = 0;
    self.var_c2490d61 = 0;

    foreach(weapon in level.var_ab9d0ec6) {
      if(self hasweapon(weapon, 1)) {
        if(zm_weapons::weapon_supports_aat(weapon) && zm_pap_util::function_83c29ddb(weapon) >= var_27f8d634 || !zm_weapons::weapon_supports_aat(weapon) && zm_weapons::is_weapon_upgraded(weapon)) {
          var_6c114dfb++;
        }
      }
    }

    if(var_6c114dfb >= var_5ba20db5) {
      self.var_c2490d61 = 1;
    }
  }
}