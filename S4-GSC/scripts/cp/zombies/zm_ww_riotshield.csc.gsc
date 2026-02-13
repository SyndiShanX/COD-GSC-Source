/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_ww_riotshield\.csc.gsc
*******************************************************/

init() {
  _id_0006::_id_D501();
  level.wwshield_1p_effects = [];
  _id_0006::addweaponchangedcallback(::monitor_wwshield_change);
}

monitor_wwshield_state(var_0) {
  self endon("death");
  self notify("stop_monitor_wwshield_state");
  self endon("stop_monitor_wwshield_state");
  var_1 = 0;

  for(;;) {
    var_2 = _func_010C(var_0);
    var_3 = _id_0510::ter_op(var_2, 0, _func_00D5(var_0, "csc_wwshield_fx_state"));

    if(var_3 != var_1) {
      stop_wwshield_1p_effects(var_0);
      level.wwshield_1p_effects[var_0] = [];

      if(var_3 == 2) {
        play_wwshield_1p_effect(var_0, "vfx/s4/zombie_weapon/vfx_ww_shield_ambient_activation_1p", "in_eye03");
        play_wwshield_1p_effect(var_0, "vfx/s4/zombie_weapon/vfx_ww_shield_ambient_activation_eye_middle_1p", "in_eye01");
        play_wwshield_1p_effect(var_0, "vfx/s4/zombie_weapon/vfx_ww_shield_ambient_activation_eye_small_1p", "in_eye03");
      } else if(var_3 == 1) {
        play_wwshield_1p_effect(var_0, "vfx/s4/zombie_weapon/vfx_ww_shield_ambient_eye_middle_1p", "in_eye01");
        play_wwshield_1p_effect(var_0, "vfx/s4/zombie_weapon/vfx_ww_shield_ambient_eye_small_1p", "in_eye03");
      }

      var_1 = var_3;
    }

    waitframe();
  }
}

monitor_wwshield_change(var_0, var_1) {
  var_2 = self _meth_802D();

  if(var_0 == var_2) {
    if(var_1.currweaponname == "s4_me_rindigoww_mp") {
      thread monitor_wwshield_state(var_0);
    } else {
      self notify("stop_monitor_wwshield_state");
      kill_wwshield_1p_effects(var_0);
    }
  }
}

play_wwshield_1p_effect(var_0, var_1, var_2) {
  if(_func_00D0(var_0, var_2)) {
    level.wwshield_1p_effects[var_0][level.wwshield_1p_effects[var_0].size] = _func_00D2(var_0, var_1, var_2);
  }
}

stop_wwshield_1p_effects(var_0) {
  if(isDefined(level.wwshield_1p_effects[var_0])) {
    for(var_1 = 0; var_1 < level.wwshield_1p_effects[var_0].size; var_1++) {
      if(isDefined(level.wwshield_1p_effects[var_0][var_1])) {
        _func_00C3(var_0, level.wwshield_1p_effects[var_0][var_1]);
      }
    }

    level.wwshield_1p_effects[var_0] = undefined;
  }
}

kill_wwshield_1p_effects(var_0) {
  if(isDefined(level.wwshield_1p_effects[var_0])) {
    for(var_1 = 0; var_1 < level.wwshield_1p_effects[var_0].size; var_1++) {
      if(isDefined(level.wwshield_1p_effects[var_0][var_1])) {
        _func_00C4(var_0, level.wwshield_1p_effects[var_0][var_1]);
      }
    }

    level.wwshield_1p_effects[var_0] = undefined;
  }
}