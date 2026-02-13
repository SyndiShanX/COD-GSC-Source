/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_ww_dg2\.csc.gsc
*************************************************/

init() {
  _id_0006::_id_D501();
  level.dg2_1p_effects = [];
  _id_0006::addweaponchangedcallback(::monitor_dg2_change);
}

monitor_dg2_change(var_0, var_1) {
  var_2 = self _meth_802D();

  if(var_0 == var_2) {
    if(var_1.currweaponname == "s4_ar_tgun_mp") {
      thread monitor_dg2_state(var_0);
    } else {
      self notify("stop_monitor_dg2_state");
      kill_dg2_1p_effects(var_0);
    }
  }
}

monitor_dg2_state(var_0) {
  self endon("death");
  self notify("stop_monitor_dg2_state");
  self endon("stop_monitor_dg2_state");
  waitframe();
  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = _func_010E(var_0);

  if(var_4 == 6) {
    var_5 = "vfx/s4/zombie/vfx_dg2_bulb_ug_zmb";
    var_6 = "vfx/s4/zombie/vfx_dg2_bulbous_ug_zmb";
    var_7 = "vfx/s4/zombie/vfx_tesla_raill_idle_ug_zmb";
  } else {
    var_5 = "vfx/s4/zombie_ai/vfx_dg2_bulb_zmb";
    var_6 = "vfx/s4/zombie/vfx_dg2_bulbous_zmb";
    var_7 = "vfx/s4/zombie/vfx_tesla_raill_idle_zmb";
  }

  for(;;) {
    var_8 = _func_010C(var_0);

    if(!isDefined(var_3)) {
      var_3 = 0;
    }

    var_9 = var_3;
    var_3 = _func_010F(var_0);

    if(var_3 == 0 && var_9 != var_3) {
      thread wait_to_update_fx_after_inspection_interrupt();
    }

    var_10 = _id_0510::ter_op(var_8, 0, get_dg2_ammo_state(var_0, var_4));
    var_11 = 0;

    if(var_10 != var_1) {
      update_bulb_effects(var_10, var_0, var_5, var_6);
      var_1 = var_10;
      var_11 = 1;
    }

    if(!istrue(var_11) && istrue(self.should_update_fx_after_inspection_interrupt)) {
      update_bulb_effects(var_10, var_0, var_5, var_6);
      var_12 = var_10;
      self.should_update_fx_after_inspection_interrupt = 0;
    }

    if(var_10 != 0) {
      var_13 = _func_00A6();

      if(!isDefined(self.last_rail_fx_play_time) || var_13 > self.last_rail_fx_play_time + 12000) {
        if(var_4 == 6) {
          _func_00D2(var_0, "vfx/s4/zombie/vfx_tesla_raill_idle_ug_zmb", "tag_flash");
        } else {
          _func_00D2(var_0, "vfx/s4/zombie/vfx_tesla_raill_idle_zmb", "tag_flash");
        }

        self.last_rail_fx_play_time = var_13;
      }
    }

    waitframe();
  }
}

update_bulb_effects(var_0, var_1, var_2, var_3) {
  stop_dg2_1p_effects(var_1);
  level.dg2_1p_effects[var_1] = [];

  switch (var_0) {
    case 3:
      play_dg2_1p_effect(var_1, var_2, "tag_bulb_3");
    case 2:
      play_dg2_1p_effect(var_1, var_2, "tag_bulb_2");
    case 1:
      play_dg2_1p_effect(var_1, var_2, "tag_bulb_1");
      play_dg2_1p_effect(var_1, var_3, "tag_fx");
      break;
    default:
      break;
  }
}

wait_to_update_fx_after_inspection_interrupt() {
  self endon("death");
  self notify("wait_to_update_fx_after_inspection_interrupt");
  self endon("wait_to_update_fx_after_inspection_interrupt");
  wait 0.1;
  self.should_update_fx_after_inspection_interrupt = 1;
}

get_dg2_ammo_state(var_0, var_1) {
  var_2 = _func_010D(var_0);

  if(var_1 == 6) {
    var_3 = _func_002C(anglestoup(var_2 / 2));
  } else {
    var_3 = var_2;
  }

  return var_3;
}

play_dg2_1p_effect(var_0, var_1, var_2) {
  if(_func_00D0(var_0, var_2)) {
    level.dg2_1p_effects[var_0][level.dg2_1p_effects[var_0].size] = _func_00D2(var_0, var_1, var_2);
  }
}

stop_dg2_1p_effects(var_0) {
  if(isDefined(level.dg2_1p_effects[var_0])) {
    for(var_1 = 0; var_1 < level.dg2_1p_effects[var_0].size; var_1++) {
      if(isDefined(level.dg2_1p_effects[var_0][var_1])) {
        _func_00C3(var_0, level.dg2_1p_effects[var_0][var_1]);
      }
    }

    level.dg2_1p_effects[var_0] = undefined;
  }
}

kill_dg2_1p_effects(var_0) {
  if(isDefined(level.dg2_1p_effects[var_0])) {
    for(var_1 = 0; var_1 < level.dg2_1p_effects[var_0].size; var_1++) {
      if(isDefined(level.dg2_1p_effects[var_0][var_1])) {
        _func_00C4(var_0, level.dg2_1p_effects[var_0][var_1]);
      }
    }

    level.dg2_1p_effects[var_0] = undefined;
  }
}