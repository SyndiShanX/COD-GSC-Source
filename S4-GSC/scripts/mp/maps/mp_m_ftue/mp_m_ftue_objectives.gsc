/**************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_ftue\mp_m_ftue_objectives.gsc
**************************************************************/

_id_A864(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_0C76(var_0);
  _id_0C75(var_0);
  _id_A8D1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_A8D1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  _id_0C76(var_0);

  if(isDefined(var_1)) {
    _id_A8BB(var_0, var_1);
  }

  if(isDefined(var_2)) {
    if(isent(var_2)) {
      _id_A8B0(var_0, var_0, var_2);
    } else {
      _id_A8B3(var_0, var_2);
    }
  }

  if(isDefined(var_3)) {
    _id_A8AC(var_0, var_3);
  }

  if(isDefined(var_4)) {
    _id_A8AF(var_0, var_4);
  }

  if(isDefined(var_5)) {
    _id_A8AE(var_0, var_5);
  }

  if(isDefined(var_6)) {
    _id_A8BC(var_0, var_6);
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  _id_A8B8(var_0, var_7);

  if(isDefined(var_8)) {
    _id_A8B9(var_0, var_8);
  }

  if(isDefined(var_9)) {
    objective_set_screen_offset_y(var_0, var_9);
  }

  if(istrue(var_10)) {
    level notify("objectives_updated");
  }
}

_id_A8A9(var_0, var_1) {
  var_2 = _id_0C72(var_0);
  level._id_A869[var_2] = undefined;
  _func_015C(var_2);

  if(istrue(var_1)) {
    level notify("objectives_updated");
  }
}

_id_A873(var_0) {
  _id_0C76(var_0);

  if(isDefined(level._id_A869)) {
    foreach(var_2 in level._id_A869) {
      if(isDefined(var_2._id_A8E4) && var_2._id_A8E4 == var_0) {
        return 1;
      }
    }
  }

  return 0;
}

objective_get_objective_count(var_0) {
  if(!isDefined(level._id_A869)) {
    return 0;
  }

  return level._id_A869.size;
}

_id_A86C(var_0) {
  _id_A8BB(var_0, "done");
  var_1 = _id_0C72(var_0);
}

_id_A8BB(var_0, var_1) {
  _id_0C76(var_0);
  var_2 = _id_0C72(var_0);
  _func_016B(var_2, var_1);

  if(var_1 == "failed") {} else if(var_1 == "done") {}

  if(isDefined(level._id_A869) && isDefined(level._id_A869[var_2])) {
    var_3 = level._id_A869[var_2]._id_E747;

    if(!isDefined(var_3) || var_3 != var_1) {
      level notify("objectives_updated_state", var_1);
    }

    level._id_A869[var_2]._id_E747 = var_1;
  }
}

_id_A8B3(var_0, var_1, var_2) {
  _id_0C76(var_0);
  var_3 = _id_0C72(var_0);
  _func_0163(var_3, var_1);

  if(istrue(var_2)) {
    level notify("objectives_updated");
  }
}

_id_A8AC(var_0, var_1, var_2) {
  _id_0C76(var_0);
  var_3 = _id_0C72(var_0);
  _func_0171(var_3, var_1);

  if(istrue(var_2)) {
    level notify("objectives_updated");
  }
}

_id_A8AF(var_0, var_1, var_2) {
  _id_0C76(var_0);
  var_3 = _id_0C72(var_0);
  _func_0167(var_3, var_1);

  if(istrue(var_2)) {
    level notify("objectives_updated");
  }
}

_id_A8AE(var_0, var_1, var_2) {
  _id_0C76(var_0);
  var_3 = _id_0C72(var_0);
  _func_015D(var_3, var_1);

  if(istrue(var_2)) {
    level notify("objectives_updated");
  }
}

_id_A8BC(var_0, var_1, var_2) {
  _id_0C76(var_0);
  var_3 = _id_0C72(var_0);
  _func_0161(var_3, var_1);

  if(istrue(var_2)) {
    level notify("objectives_updated");
  }
}

objective_set_screen_offset_y(var_0, var_1, var_2) {
  _id_0C76(var_0);
  var_3 = _id_0C72(var_0);
  _func_0162(var_3, var_1);

  if(istrue(var_2)) {
    level notify("objectives_updated");
  }
}

objective_apply_prompt_offset(var_0) {
  _id_0C76(var_0);
  objective_set_screen_offset_y(var_0, -50);
}

objective_apply_ai_offset(var_0) {
  _id_0C76(var_0);
  _id_A8BC(var_0, 72);
}

_id_A8B8(var_0, var_1, var_2) {
  _id_0C76(var_0);
  var_3 = _id_0C72(var_0);
  _func_0176(var_3, var_1);

  if(istrue(var_2)) {
    level notify("objectives_updated");
  }
}

_id_A8B9(var_0, var_1, var_2) {
  _id_0C76(var_0);
  var_3 = _id_0C72(var_0);
  _func_017B(var_3, var_1);

  if(istrue(var_2)) {
    level notify("objectives_updated");
  }
}

_id_A8B0(var_0, var_1, var_2, var_3) {
  _id_0C76(var_0);
  var_4 = _id_0C72(var_0);

  if(level._id_A869[var_4]._id_96DE.size > 0) {
    scripts\engine\utility::_id_5598("Calling this function while having locations set is scary. OnEntity always takes the first index.");
    _id_A8AA(var_0);
  }

  level._id_A869[var_4]._id_96DE[0] = var_1;
  _func_0160(var_4, var_2);

  if(isai(var_2)) {
    objective_apply_ai_offset(var_0);
  } else {
    _id_A8BC(var_0, 0);
  }

  if(istrue(var_3)) {
    level notify("objectives_updated");
  }
}

_id_A865(var_0, var_1, var_2, var_3) {
  _id_0C70(var_0, var_1, var_2, var_3);
}

_id_A866(var_0, var_1, var_2, var_3) {
  _id_0C70(var_0, var_1, var_2, var_3);
}

_id_A8AB(var_0, var_1, var_2) {
  var_3 = -1;
  var_4 = _id_0C72(var_0);
  var_5 = level._id_A869[var_4]._id_96DE;

  foreach(var_8, var_7 in var_5) {
    if(isDefined(var_7) && var_7 == var_1) {
      var_3 = var_8;
      break;
    }
  }

  level._id_A869[var_4]._id_96DE[var_3] = undefined;
  _func_0165(var_4, var_3);

  if(istrue(var_2)) {
    level notify("objectives_updated", "location");
  }
}

_id_A8AA(var_0, var_1) {
  var_2 = _id_0C72(var_0);

  for(var_3 = 0; var_3 < 8; var_3++) {
    _func_0165(var_2, var_3);
  }

  level._id_A869[var_2]._id_96DE = [];

  if(istrue(var_1)) {
    level notify("objectives_updated");
  }
}

objective_update_display() {
  level notify("objectives_updated");
}

objective_show_markers_continuous(var_0, var_1) {
  if(isDefined(var_0)) {
    scripts\engine\utility::_id_5C24(var_0);
  }

  setomnvar("ui_show_objectives_force", 1);

  if(isDefined(var_1)) {
    scripts\engine\utility::_id_5C24(var_1);
  } else {
    for(;;) {
      var_2 = level scripts\engine\utility::_id_108A4("objectives_updated_state", "objectives_updated");

      if(var_2["message"] == "objectives_updated") {
        break;
      }

      if(var_2[0] != "current" && var_2[0] != "invisible") {
        break;
      }
    }
  }

  setomnvar("ui_show_objectives_force", 0);
}

objective_set_show_reveal_animation(var_0) {
  level.player setclientomnvar("ui_objective_reveal_fanfare_enabled", var_0);
}

objective_set_show_dismiss_animation(var_0) {
  level.player setclientomnvar("ui_objective_dismiss_fanfare_enabled", var_0);
}

objective_is_reveal_animation_enabled() {
  return level.player _meth_876E("ui_objective_reveal_fanfare_enabled");
}

objective_reminder_set_enabled(var_0) {
  level.objective_reminder._id_523F = var_0;

  if(istrue(level.objective_reminder._id_523F)) {
    _objective_reminder_reset_timer();
  }
}

objective_reminder_set_on_flag(var_0, var_1) {
  scripts\engine\utility::_id_5C24(var_1);
  objective_reminder_set_enabled(var_0);
}

objective_reminder_set_on_flag_any_array(var_0, var_1) {
  scripts\engine\utility::_id_5C28(var_1);
  objective_reminder_set_enabled(var_0);
}

objective_reminder_set_on_notify(var_0, var_1) {
  self waittill(var_1);
  objective_reminder_set_enabled(var_0);
}

objective_reminder_set_on_notify_any_array(var_0, var_1) {
  scripts\engine\utility::_id_10892(var_1);
  objective_reminder_set_enabled(var_0);
}

objective_reminder_set_cooldown_duration(var_0) {
  if(!isDefined(var_0) || var_0 == 0) {
    level.objective_reminder._id_469A = 180000;
  }

  var_0 = var_0 * 1000;
  level.objective_reminder._id_469A = var_0;
  _objective_reminder_reset_timer(var_0);
}

objective_reminder_set_timer(var_0) {
  if(isDefined(var_0)) {
    if(var_0 == 0) {
      thread _objective_reminder_show_reminder_start();
      _objective_reminder_reset_timer();
      return;
    }

    var_0 = int(var_0 * 1000);
    _objective_reminder_reset_timer(var_0);
  }

  _objective_reminder_reset_timer(var_0);
}

objective_reminder_show() {
  if(!_objective_reminder_skip()) {
    objective_reminder_set_timer(0);
  }
}

objective_reminder_show_forced(var_0) {
  level.objective_reminder.forced = 1;
  objective_reminder_show();

  if(isDefined(var_0)) {
    scripts\engine\utility::_id_10888(self, var_0, level, "objectives_updated_state", level.player, "objective_reminder_end");
  } else {
    scripts\engine\utility::_id_10888(level, "objectives_updated_state", level.player, "objective_reminder_end");
  }

  level.objective_reminder.forced = 0;
}

_id_0C70(var_0, var_1, var_2, var_3) {
  var_4 = _id_0C72(var_0);
  var_5 = _id_0C73(var_4);
  level._id_A869[var_4]._id_96DE[var_5] = var_1;
  _func_0164(var_4, var_5, var_2);

  if(istrue(var_3)) {
    level notify("objectives_updated");
  }
}

_id_0C76(var_0) {}

_id_0C75(var_0) {
  _id_0C72(var_0, 1);
}

_id_0C72(var_0, var_1) {
  if(!isDefined(level._id_A869)) {
    level._id_A869 = [];
  }

  var_2 = -1;

  if(istrue(var_1)) {
    var_2 = _id_0C74();
    level._id_A869[var_2] = spawnStruct();
    level._id_A869[var_2]._id_A8E4 = var_0;
    level._id_A869[var_2]._id_96DE = [];
    _func_015C(var_2);
  } else {
    for(var_3 = 0; var_3 < 32; var_3++) {
      if(isDefined(level._id_A869[var_3]) && isDefined(level._id_A869[var_3]._id_A8E4) && level._id_A869[var_3]._id_A8E4 == var_0) {
        var_2 = var_3;
        break;
      }
    }
  }

  return var_2;
}

_id_0C73(var_0) {
  var_1 = level._id_A869[var_0]._id_96DE;

  for(var_2 = 0; var_2 < 8; var_2++) {
    if(!isDefined(var_1[var_2])) {
      return var_2;
    } else if(var_1[var_2] == "") {
      return var_2;
    }
  }
}

_id_0C74() {
  for(var_0 = 0; var_0 < 32; var_0++) {
    if(!isDefined(level._id_A869[var_0])) {
      return var_0;
    }
  }
}

_objective_reminder_think() {
  level.objective_reminder = spawnStruct();
  objective_reminder_set_enabled(0);
  _objective_reminder_reset_timer();
  childthread _objective_reminder_refresh_think();

  for(;;) {
    var_0 = gettime();

    if(_objective_reminder_skip()) {
      _objective_reminder_reset_timer();
    } else if(level.objective_reminder.next_time <= var_0 || istrue(level.objective_reminder.forced)) {
      if(istrue(level.objective_reminder._id_523F)) {
        thread _objective_reminder_show_reminder_start();
        _objective_reminder_reset_timer();
      }
    }

    wait 5;
  }
}

_objective_reminder_show_reminder_start() {
  var_0 = gettime() + 10000;

  while(gettime() < var_0 || istrue(level.objective_reminder.forced)) {
    if(_objective_reminder_skip()) {
      break;
    }

    waitframe();
  }

  _objective_reminder_show_reminder_end();
}

_objective_reminder_show_reminder_end() {
  level.player notify("objective_reminder_end");
}

_objective_reminder_reset_timer(var_0) {
  if(!isDefined(level.objective_reminder._id_469A)) {
    level.objective_reminder._id_469A = 180000;
  }

  if(isDefined(var_0) && var_0 > 0) {
    level.objective_reminder._id_469A = var_0;
  }

  level.objective_reminder.next_time = gettime() + level.objective_reminder._id_469A;
}

_objective_reminder_refresh_think() {
  for(;;) {
    var_0 = scripts\engine\utility::_id_1088C(level.player, "focus_pressed", level, "objectives_updated", level, "player_linked_to_rig");
    _objective_reminder_reset_timer();
  }
}

_objective_reminder_skip() {
  return scripts\engine\utility::_id_5C00("objectives_displayed") || objective_get_objective_count() == 0;
}