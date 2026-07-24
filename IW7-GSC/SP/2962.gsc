/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2962.gsc
**************************************/

_id_11166(var_0, var_1) {
  var_2 = var_0._id_11159;
  var_3 = var_1._id_11159;
  self._id_2274[var_3] = var_0;
  self._id_2274[var_2] = var_1;
  self._id_2274[var_2]._id_11159 = var_2;
  self._id_2274[var_3]._id_11159 = var_3;
}

_id_1368E() {
  self endon("death");
  self endon("removed from battleChatter");

  while(self._id_9F6B) {
    wait 0.05;
  }
}

_id_13636(var_0) {
  self endon("death");
  var_0 endon("trigger");
  self waittill("trigger");
  var_0 notify("trigger");
}

_id_13634(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = spawnStruct();
  scripts\engine\utility::array_thread(var_2, ::_id_13636, var_3);
  var_3 waittill("trigger");
}

_id_65FB(var_0) {
  self endon("done");
  var_0 waittill("trigger");
  self notify("done");
}

_id_12DAC() {
  self notify("debug_color_update");
  self endon("debug_color_update");
  var_0 = self.unique_id;
  self waittill("death");
  level._id_4EBE[var_0] = undefined;
  level notify("updated_color_friendlies");
}

_id_12DAB(var_0) {
  thread _id_12DAC();

  if(isDefined(self._id_EDAD)) {
    level._id_4EBE[var_0] = self._id_EDAD;
  } else {
    level._id_4EBE[var_0] = undefined;
  }

  level notify("updated_color_friendlies");
}

_id_9938() {}

_id_BF01(var_0) {
  self notify("new_color_being_set");
  self._id_BF06 = 1;
  scripts\sp\colors::_id_AB3A();
  self endon("new_color_being_set");
  self endon("death");
  waittillframeend;
  waittillframeend;

  if(isDefined(self._id_EDAD)) {
    self._id_4BDF = level._id_4BE0[scripts\sp\colors::_id_7CE4()][self._id_EDAD];

    if(isDefined(self._id_5955)) {
      self._id_5955 = undefined;
    } else {
      thread scripts\sp\colors::_id_8467();
    }
  }

  self._id_BF06 = undefined;
  self notify("done_setting_new_color");
}

_id_65FA(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_13764(var_0, var_1, var_2) {
  var_0 endon("done");
  [[var_1]](var_2);
  var_0 notify("done");
}

_id_9022(var_0, var_1) {
  self endon("hint_print_timeout");
  self endon("hint_print_remove");
  var_1 endon("new_hint");

  for(;;) {
    self._id_6AB8 = 1;

    if(isDefined(level._id_8FE4) && [[level._id_8FE4]]() || var_1._id_4B7A != var_0) {
      break;
    }

    wait 0.05;
  }
}

_id_9014(var_0) {
  wait(var_0);
  self._id_6AB8 = 1;
  self notify("hint_print_timeout");
}

_id_900D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return var_0 + _id_12DB(var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_12DB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getsticksconfig();

  if(level.player scripts\engine\utility::is_player_gamepad_enabled()) {
    if(isDefined(level._id_DADB) && level._id_DADB || isDefined(level._id_DADC) && level._id_DADC) {
      if(issubstr(var_6, "southpaw") || var_5 && issubstr(var_6, "legacy")) {
        return var_4;
      } else {
        return var_3;
      }
    } else if(issubstr(var_6, "southpaw") || var_5 && issubstr(var_6, "legacy"))
      return var_2;
    else {
      return var_1;
    }
  } else
    return var_0;
}

_id_12DC(var_0, var_1) {
  var_2 = var_1 + var_0;
  var_3 = level._id_1274F[var_2];
  level._id_8FE4 = var_3;
}

_id_12DD(var_0, var_1) {
  var_2 = var_1 + var_0;
  var_3 = level._id_12750[var_2];
  var_4 = scripts\sp\utility::_id_7B92();
  var_4 _meth_8496(var_3);
}

_id_900E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level notify("hint_change_config");
  level endon("hint_change_config");
  var_7 = _id_12DB(var_1, var_2, var_3, var_4, var_5, var_6);

  while(isDefined(level._id_4B80) && level._id_4B80) {
    var_8 = _id_12DB(var_1, var_2, var_3, var_4, var_5, var_6);

    if(var_8 != var_7) {
      var_7 = var_8;
      _id_12DC(var_7, var_0);
      _id_12DD(var_7, var_0);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_9021(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self notify("new_hint");
  var_7 = gettime();

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  if(!isalive(self)) {
    return;
  }
  scripts\sp\utility::_id_65E8("global_hint_in_use");

  if(isDefined(self._id_4B7A)) {
    if(self._id_4B7A == var_0) {
      return;
    } else {
      self._id_4B7A = var_0;
      scripts\sp\utility::_id_65E1("global_hint_in_use");
      wait 0.05;
    }
  }

  self._id_4B7A = var_0;
  scripts\sp\utility::_id_65E1("global_hint_in_use");
  level._id_4B80 = 1;
  level._id_8FE4 = var_1;
  level endon("friendlyfire_mission_fail");
  self _meth_8496(var_0);
  var_8 = spawnStruct();
  var_8._id_6AB8 = 0;

  if(isDefined(var_5)) {
    var_8 thread _id_9014(var_5);
  }

  var_8 thread _id_52AB();
  var_8 thread _id_52AC();
  var_8 thread destroy_hint_on_c6_grab();
  var_8 _id_9022(var_0, self);

  if(!scripts\engine\utility::is_true(var_8._id_6AB8)) {
    self _meth_8497(1);
  }

  scripts\sp\utility::_id_135AF(var_7, var_6);
  var_8 notify("removing_hint");
  self._id_4B7A = undefined;

  if(var_8._id_6AB8) {
    self _meth_8497();
  }

  level._id_4B80 = 0;
  scripts\sp\utility::_id_65DD("global_hint_in_use");
}

_id_52AB(var_0) {
  self endon("removing_hint");
  level waittill("friendlyfire_mission_fail");
  self._id_6AB8 = 1;
  self notify("hint_print_remove");
}

destroy_hint_on_c6_grab(var_0) {
  self endon("removing_hint");

  for(;;) {
    if(!isDefined(level.player.melee)) {
      wait 0.05;
    } else if(!isDefined(level.player.melee._id_B5FE)) {
      wait 0.05;
    } else {
      break;
    }

    wait 0.05;
  }

  self._id_6AB8 = 1;
  self notify("hint_print_remove");
}

_id_52AC(var_0) {
  self endon("removing_hint");
  level.player waittill("death");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  iprintlnbold(" ");
  self._id_6AB8 = 1;
  self notify("hint_print_remove");
}

_id_74DE(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_either("function_done", "death");
}

_id_74DF(var_0) {
  _id_74DE(var_0);

  if(!isDefined(self)) {
    return 0;
  }

  if(!issentient(self)) {
    return 1;
  }

  if(isalive(self)) {
    return 1;
  }

  return 0;
}

_id_74DB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isDefined(var_0._id_74D7)) {
    var_0._id_74D7 = [];
  }

  var_0._id_74D7[var_0._id_74D7.size] = self;
  thread _id_74DC(var_0);
  _id_74D8(var_0);

  if(isDefined(var_0) && isDefined(var_0._id_74D7)) {
    self._id_74DA = 1;
    self notify("function_stack_func_begun");

    if(isDefined(var_6)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5, var_6);
    } else if(isDefined(var_5)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5);
    } else if(isDefined(var_4)) {
      var_0[[var_1]](var_2, var_3, var_4);
    } else if(isDefined(var_3)) {
      var_0[[var_1]](var_2, var_3);
    } else if(isDefined(var_2)) {
      var_0[[var_1]](var_2);
    } else {
      var_0[[var_1]]();
    }

    if(isDefined(var_0) && isDefined(var_0._id_74D7)) {
      var_0._id_74D7 = scripts\engine\utility::array_remove(var_0._id_74D7, self);
      var_0 notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self._id_74DA = 0;
    self notify("function_done");
  }
}

_id_74DC(var_0) {
  self endon("function_done");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0._id_74D7 = scripts\engine\utility::array_remove(var_0._id_74D7, self);
    var_0 notify("level_function_stack_ready");
  }
}

_id_74D8(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("clear_function_stack");

  while(var_0._id_74D7[0] != self) {
    var_0 waittill("level_function_stack_ready");
  }
}

_id_1362A(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 endon("death");
  }

  self endon("death");
  var_0 waittill("sounddone");
  return 1;
}

_id_22D9(var_0, var_1, var_2) {
  _id_22DA(var_0, var_1, var_2);
  self._id_1187 = 0;
  self notify("_array_wait");
}

_id_22DA(var_0, var_1, var_2) {
  var_0 endon(var_1);
  var_0 endon("death");

  if(isDefined(var_2)) {
    wait(var_2);
  } else {
    var_0 waittill(var_1);
  }
}

_id_68CC(var_0) {
  if(var_0._id_C8FD.size == 0) {
    var_0._id_376B call[[var_0.func]]();
  } else if(var_0._id_C8FD.size == 1) {
    var_0._id_376B call[[var_0.func]](var_0._id_C8FD[0]);
  } else if(var_0._id_C8FD.size == 2) {
    var_0._id_376B call[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1]);
  } else if(var_0._id_C8FD.size == 3) {
    var_0._id_376B call[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1], var_0._id_C8FD[2]);
  }

  if(var_0._id_C8FD.size == 4) {
    var_0._id_376B call[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1], var_0._id_C8FD[2], var_0._id_C8FD[3]);
  }

  if(var_0._id_C8FD.size == 5) {
    var_0._id_376B call[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1], var_0._id_C8FD[2], var_0._id_C8FD[3], var_0._id_C8FD[4]);
  }
}

_id_68CD(var_0) {
  if(var_0._id_C8FD.size == 0) {
    call[[var_0.func]]();
  } else if(var_0._id_C8FD.size == 1) {
    call[[var_0.func]](var_0._id_C8FD[0]);
  } else if(var_0._id_C8FD.size == 2) {
    call[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1]);
  } else if(var_0._id_C8FD.size == 3) {
    call[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1], var_0._id_C8FD[2]);
  }

  if(var_0._id_C8FD.size == 4) {
    call[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1], var_0._id_C8FD[2], var_0._id_C8FD[3]);
  }

  if(var_0._id_C8FD.size == 5) {
    call[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1], var_0._id_C8FD[2], var_0._id_C8FD[3], var_0._id_C8FD[4]);
  }
}

_id_68CE(var_0, var_1) {
  if(!isDefined(var_0._id_376B)) {
    return;
  }
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2]._id_376B endon(var_1[var_2]._id_6317);
  }

  if(var_0._id_C8FD.size == 0) {
    var_0._id_376B[[var_0.func]]();
  } else if(var_0._id_C8FD.size == 1) {
    var_0._id_376B[[var_0.func]](var_0._id_C8FD[0]);
  } else if(var_0._id_C8FD.size == 2) {
    var_0._id_376B[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1]);
  } else if(var_0._id_C8FD.size == 3) {
    var_0._id_376B[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1], var_0._id_C8FD[2]);
  }

  if(var_0._id_C8FD.size == 4) {
    var_0._id_376B[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1], var_0._id_C8FD[2], var_0._id_C8FD[3]);
  }

  if(var_0._id_C8FD.size == 5) {
    var_0._id_376B[[var_0.func]](var_0._id_C8FD[0], var_0._id_C8FD[1], var_0._id_C8FD[2], var_0._id_C8FD[3], var_0._id_C8FD[4]);
  }
}

_id_13774(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  _id_68CE(var_0, var_1);
  self.count--;
  self notify("func_ended");
}

_id_13720(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  _id_68CE(var_0, var_1);
  self._id_1521--;
  self notify("abort_func_ended");
}

_id_5767(var_0) {
  self endon("all_funcs_ended");

  if(!var_0.size) {
    return;
  }
  var_1 = 0;
  self._id_1521 = var_0.size;
  var_2 = [];
  scripts\engine\utility::array_levelthread(var_0, ::_id_13720, var_2);

  for(;;) {
    if(self._id_1521 <= var_1) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

_id_12688(var_0) {
  if(isDefined(self.forward)) {
    var_1 = anglesToForward(var_0.angles);
    var_0.origin = var_0.origin + var_1 * self.forward;
  }

  if(isDefined(self.right)) {
    var_2 = anglestoright(var_0.angles);
    var_0.origin = var_0.origin + var_2 * self.right;
  }

  if(isDefined(self.up)) {
    var_3 = anglestoup(var_0.angles);
    var_0.origin = var_0.origin + var_3 * self.up;
  }

  if(isDefined(self.yaw)) {
    var_0 addyaw(self.yaw);
  }

  if(isDefined(self._id_CBE9)) {
    var_0 addpitch(self._id_CBE9);
  }

  if(isDefined(self._id_E67D)) {
    var_0 addroll(self._id_E67D);
  }
}

_id_5F8E(var_0, var_1, var_2, var_3, var_4) {
  self notify("start_dynamic_run_speed");
  self endon("death");
  self endon("stop_dynamic_run_speed");
  self endon("start_dynamic_run_speed");
  level endon("_stealth_spotted");

  if(scripts\sp\utility::_id_65DF("_stealth_custom_anim")) {
    scripts\sp\utility::_id_65E8("_stealth_custom_anim");
  }

  if(!scripts\sp\utility::_id_65DF("dynamic_run_speed_stopped")) {
    scripts\sp\utility::_id_65E0("dynamic_run_speed_stopped");
    scripts\sp\utility::_id_65E0("dynamic_run_speed_stopping");
  } else {
    scripts\sp\utility::_id_65DD("dynamic_run_speed_stopping");
    scripts\sp\utility::_id_65DD("dynamic_run_speed_stopped");
  }

  self._id_E81D = "";
  self._id_C3CB = self.moveplaybackrate;
  thread _id_10FE6();
  var_5 = var_0 * var_0;
  var_6 = var_1 * var_1;
  var_7 = var_2 * var_2;
  var_8 = var_3 * var_3;

  for(;;) {
    wait 0.05;
    var_9 = level.players[0];

    foreach(var_11 in level.players) {
      if(distancesquared(var_9.origin, self.origin) > distancesquared(var_11.origin, self.origin)) {
        var_9 = var_11;
      }
    }

    var_13 = anglesToForward(self.angles);
    var_14 = vectorNormalize(var_9.origin - self.origin);
    var_15 = vectordot(var_13, var_14);
    var_16 = distancesquared(self.origin, var_9.origin);
    var_17 = var_16;

    if(isDefined(var_4)) {
      var_18 = scripts\engine\utility::getclosest(var_9.origin, var_4);
      var_17 = distancesquared(var_18.origin, var_9.origin);
    }

    var_19 = 0;

    if(isDefined(self._id_A905)) {
      var_19 = [[level._id_5EFB]](self._id_A905, var_1);
    } else if(isDefined(self._id_A906)) {
      var_19 = [[level._id_5EFB]](self._id_A906, var_1);
    }

    if(scripts\anim\utility::_id_9D9B() && !self._id_5953) {
      self.moveplaybackrate = 1;
    }

    if(var_16 < var_6 || var_15 > -0.25 || var_19) {
      _id_5F8C("sprint");
      wait 0.5;
      continue;
    } else if(var_16 < var_5 || var_15 > -0.25) {
      _id_5F8C("run");
      wait 0.5;
      continue;
    } else if(var_17 > var_7) {
      if(self.a.movement != "stop") {
        _id_5F8C("stop");
        wait 0.5;
      }

      continue;
    } else if(var_16 > var_8) {
      _id_5F8C("jog");
      wait 0.5;
      continue;
    }
  }
}

_id_10FE6() {
  self endon("start_dynamic_run_speed");
  self endon("death");
  _id_10FE7();

  if(!self._id_5953) {
    self.moveplaybackrate = self._id_C3CB;
  }

  if(isDefined(level._id_EC85["generic"]["DRS_run"])) {
    if(isarray(level._id_EC85["generic"]["DRS_run"])) {
      scripts\sp\utility::_id_F3CC("DRS_run");
    } else {
      scripts\sp\utility::_id_F3CB("DRS_run");
    }
  } else
    scripts\sp\utility::_id_417A();

  self notify("stop_loop");
  scripts\sp\utility::_id_65DD("dynamic_run_speed_stopping");
  scripts\sp\utility::_id_65DD("dynamic_run_speed_stopped");
}

_id_10FE7() {
  level endon("_stealth_spotted");
  self waittill("stop_dynamic_run_speed");
}

_id_5F8C(var_0) {
  if(self._id_E81D == var_0) {
    return;
  }
  self._id_E81D = var_0;

  switch (var_0) {
    case "sprint":
      if(scripts\anim\utility::_id_9D9B() && !self._id_5953) {
        self.moveplaybackrate = 1;
      } else if(!self._id_5953) {
        self.moveplaybackrate = 1.15;
      }

      if(isarray(level._id_EC85["generic"]["DRS_sprint"])) {
        scripts\sp\utility::_id_F3CC("DRS_sprint");
      } else {
        scripts\sp\utility::_id_F3CB("DRS_sprint");
      }

      self notify("stop_loop");
      scripts\sp\utility::anim_stopanimScripted();
      scripts\sp\utility::_id_65DD("dynamic_run_speed_stopped");
      break;
    case "run":
      if(!self._id_5953) {
        self.moveplaybackrate = self._id_C3CB;
      }

      if(isDefined(level._id_EC85["generic"]["DRS_run"])) {
        if(isarray(level._id_EC85["generic"]["DRS_run"])) {
          scripts\sp\utility::_id_F3CC("DRS_run");
        } else {
          scripts\sp\utility::_id_F3CB("DRS_run");
        }
      } else
        scripts\sp\utility::_id_417A();

      self notify("stop_loop");
      scripts\sp\utility::anim_stopanimScripted();
      scripts\sp\utility::_id_65DD("dynamic_run_speed_stopped");
      break;
    case "stop":
      thread _id_5F8F();
      break;
    case "jog":
      if(!self._id_5953) {
        self.moveplaybackrate = self._id_C3CB;
      }

      if(isDefined(level._id_EC85["generic"]["DRS_combat_jog"])) {
        if(isarray(level._id_EC85["generic"]["DRS_combat_jog"])) {
          scripts\sp\utility::_id_F3CC("DRS_combat_jog");
        } else {
          scripts\sp\utility::_id_F3CB("DRS_combat_jog");
        }
      } else
        scripts\sp\utility::_id_417A();

      self notify("stop_loop");
      scripts\sp\utility::anim_stopanimScripted();
      scripts\sp\utility::_id_65DD("dynamic_run_speed_stopped");
      break;
    case "crouch":
      break;
  }
}

_id_5F8F() {
  self endon("death");

  if(scripts\sp\utility::_id_65DB("dynamic_run_speed_stopped")) {
    return;
  }
  if(scripts\sp\utility::_id_65DB("dynamic_run_speed_stopping")) {
    return;
  }
  self endon("stop_dynamic_run_speed");
  scripts\sp\utility::_id_65E1("dynamic_run_speed_stopping");
  scripts\sp\utility::_id_65E1("dynamic_run_speed_stopped");
  self endon("dynamic_run_speed_stopped");
  var_0 = "DRS_run_2_stop";
  scripts\sp\anim::_id_1EC8(self, "gravity", var_0);
  scripts\sp\utility::_id_65DD("dynamic_run_speed_stopping");

  while(scripts\sp\utility::_id_65DB("dynamic_run_speed_stopped")) {
    var_1 = "DRS_stop_idle";
    thread scripts\sp\anim::_id_1ECC(self, var_1);

    if(isDefined(level._id_EC85["generic"]["signal_go"])) {
      _id_8A0B("go");
    }

    wait(randomfloatrange(12, 20));

    if(scripts\sp\utility::_id_65DF("_stealth_stance_handler")) {
      scripts\sp\utility::_id_65E8("_stealth_stance_handler");
    }

    self notify("stop_loop");

    if(!scripts\sp\utility::_id_65DB("dynamic_run_speed_stopped")) {
      return;
    }
    if(isDefined(level._id_5F8D)) {
      var_2 = scripts\engine\utility::random(level._id_5F8D);
      level thread scripts\sp\utility::_id_DBF3(var_2);
    }

    if(isDefined(level._id_EC85["generic"]["signal_go"])) {
      _id_8A0B("go");
    }
  }
}

_id_8A0B(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isDefined(var_1)) {
    var_4 = !var_1;
  }

  if(isDefined(var_2)) {
    level endon(var_2);
  }

  if(isDefined(var_3)) {
    level waittill(var_3);
  }

  var_5 = "signal_" + var_0;

  if(self.a.pose == "crouch") {
    var_5 = var_5 + "_crouch";
  } else if(self.script == "cover_right") {
    var_5 = var_5 + "_coverR";
  } else if(scripts\anim\utility::_id_9D9B()) {
    var_5 = var_5 + "_cqb";
  }

  if(var_4) {
    self _meth_82AE(scripts\sp\utility::_id_7ECF(var_5), 1, 0, 1.1);
  } else {
    scripts\sp\anim::_id_1EC7(self, var_5);
  }
}

_id_764E() {
  return int(getDvar("g_speed"));
}

_id_764F(var_0) {
  setsaveddvar("g_speed", int(var_0));
}

_id_7647() {
  return level.player _meth_810B();
}

_id_7648(var_0) {
  level.player _meth_82B5(var_0);
}

_id_BCF0() {
  return self._id_BCF5;
}

_id_BCF3(var_0) {
  self._id_BCF5 = var_0;
  self setmovespeedscale(var_0);
}

_id_2680() {
  if(scripts\engine\utility::flag_exist("autosave_tactical_player_nade")) {
    return;
  }
  scripts\engine\utility::flag_init("autosave_tactical_player_nade");
  level._id_267E = 0;
  notifyoncommand("autosave_player_nade", "+frag");
  notifyoncommand("autosave_player_nade", "-smoke");
  notifyoncommand("autosave_player_nade", "+smoke");
  scripts\engine\utility::array_thread(level.players, ::_id_267A);
}

_id_267A() {
  for(;;) {
    self waittill("autosave_player_nade");
    scripts\engine\utility::flag_set("autosave_tactical_player_nade");
    thread _id_267C();
    scripts\engine\utility::waittill_any_timeout(10, "autosave_grenade_thrown");
    self notify("autosave_grenade_throw_timeout");
    _id_267D();
  }
}

_id_267C() {
  self endon("autosave_grenade_throw_timeout");
  self waittill("grenade_fire", var_0);
  thread _id_267B(var_0);
  self notify("autosave_grenade_thrown");
}

_id_267D() {
  waittillframeend;

  if(!level._id_267E) {
    scripts\engine\utility::flag_clear("autosave_tactical_player_nade");
  }
}

_id_267B(var_0) {
  level._id_267E++;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", 10);
  level._id_267E--;
  _id_267D();
}

_id_267F() {
  level notify("autosave_tactical_proc");
  level endon("autosave_tactical_proc");
  level thread scripts\sp\utility::_id_C12D("kill_save", 5);
  level endon("kill_save");
  level endon("autosave_tactical_player_nade");

  if(scripts\engine\utility::flag("autosave_tactical_player_nade")) {
    scripts\engine\utility::flag_waitopen_or_timeout("autosave_tactical_player_nade", 4);

    if(scripts\engine\utility::flag("autosave_tactical_player_nade")) {
      return;
    }
  }

  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.enemy) && isPlayer(var_2.enemy)) {
      return;
    }
  }

  waittillframeend;
  scripts\sp\utility::_id_2669();
}

_id_BDE6(var_0, var_1, var_2, var_3) {
  scripts\sp\utility::_id_BDEC(var_1);
  level endon("stop_music");
  wait(var_1);
  thread scripts\sp\utility::_id_BDE5(var_0, undefined, var_2, var_3);
}

_id_BDE2(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\sp\utility::_id_BDEC(var_2);
  level endon("stop_music");
  wait(var_2);
  thread _id_BDE1(var_0, var_1, undefined, var_3, var_4, var_5);
}

_id_BDE1(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_2) && var_2 > 0) {
    thread _id_BDE2(var_0, var_1, var_2, var_3, var_4, var_5);
    return;
  }

  scripts\sp\utility::_id_BDEC();
  level endon("stop_music");
  scripts\sp\utility::_id_BDF2(var_0, var_3, var_4);

  if(isDefined(var_5) && var_5 == 1 && scripts\engine\utility::flag_exist("_stealth_spotted")) {
    level endon("_stealth_spotted");
    thread _id_BDE4(var_0, var_1, var_2);
  }

  var_6 = scripts\sp\utility::_id_BDF1(var_0);

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1 <= 10) {
    var_6 = var_6 + var_1;
  }

  wait(var_6);
  scripts\sp\utility::_id_BDDF(var_0, var_1, var_2, var_3, var_4);
}

_id_BDE4(var_0, var_1, var_2) {
  level endon("stop_music");
  scripts\engine\utility::flag_wait("_stealth_spotted");
  musicstop(0.5);

  while(scripts\engine\utility::flag("_stealth_spotted")) {
    scripts\engine\utility::flag_waitopen("_stealth_spotted");
    wait 1;
  }

  thread scripts\sp\utility::_id_BDDF(var_0, var_1, var_2);
}

_id_5AAD(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_sliding");
  var_3 = self;
  var_4 = undefined;
  var_5 = var_0.origin;
  var_6 = var_0.origin;
  var_7 = undefined;

  for(;;) {
    var_8 = var_3 getnormalizedmovement();
    var_9 = anglesToForward(var_3.angles);
    var_10 = anglestoright(var_3.angles);
    var_8 = (var_8[1] * var_10[0] + var_8[0] * var_9[0], var_8[1] * var_10[1] + var_8[0] * var_9[1], 0);
    var_0.slidevelocity = var_0.slidevelocity + var_8 * var_1;
    var_3._id_7601.origin = var_0.origin + anglesToForward(var_0._id_77BA.angles) * 400;
    wait 0.05;
    var_0.slidevelocity = var_0.slidevelocity * (1 - var_2);
  }
}

_id_A5CF(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    wait(randomfloat(var_0));
  }

  playFXOnTag(scripts\engine\utility::getfx("flesh_hit"), self, "tag_eye");
  self _meth_81D0(level.player.origin);
}

_id_12E1F(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  for(;;) {
    if(self._id_99E5 > 0.0001 && gettime() > 300) {
      if(!var_2) {
        self _meth_8244(var_1);
        var_2 = 1;
      }
    } else if(var_2) {
      self stoprumble(var_1);
      var_2 = 0;
    }

    var_3 = 1 - self._id_99E5;
    var_3 = var_3 * 1000;
    self.origin = var_0 getEye() + (0, 0, var_3);
    wait 0.05;
  }
}

_id_D961(var_0, var_1, var_2, var_3, var_4) {
  waittillframeend;

  if(!isDefined(self.start)) {
    self.start = 0;
  }

  if(!isDefined(self.end)) {
    self.end = 1;
  }

  if(!isDefined(self._id_2857)) {
    self._id_2857 = 0;
  }

  var_5 = self.time * 20;
  var_6 = self.end - self.start;
  self._id_10FCB = 0;

  if(isDefined(var_4)) {
    for(var_7 = 0; var_7 <= var_5 && !self._id_10FCB; var_7++) {
      var_8 = self._id_2857 + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2, var_3, var_4);
      wait 0.05;
    }
  } else if(isDefined(var_3)) {
    for(var_7 = 0; var_7 <= var_5 && !self._id_10FCB; var_7++) {
      var_8 = self._id_2857 + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2, var_3);
      wait 0.05;
    }
  } else if(isDefined(var_2)) {
    for(var_7 = 0; var_7 <= var_5 && !self._id_10FCB; var_7++) {
      var_8 = self._id_2857 + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2);
      wait 0.05;
    }
  } else {
    for(var_7 = 0; var_7 <= var_5 && !self._id_10FCB; var_7++) {
      var_8 = self._id_2857 + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8);
      wait 0.05;
    }
  }
}

_id_78D1() {
  var_0 = "allies";

  if(isDefined(self._id_ED34)) {
    var_0 = "axis";
  }

  var_0 = scripts\sp\colors::_id_7CE4(var_0);
  var_1 = [];

  if(var_0 == "allies") {
    var_2 = scripts\sp\colors::_id_78D9(self._id_ED33, "allies");
    var_1 = var_2["colorCodes"];
  } else {
    var_2 = scripts\sp\colors::_id_78D9(self._id_ED34, "axis");
    var_1 = var_2["colorCodes"];
  }

  var_3 = [];
  var_3["team"] = var_0;
  var_3["codes"] = var_1;
  return var_3;
}

_id_50E5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  wait(var_1);

  if(isDefined(var_7)) {
    childthread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    childthread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    childthread[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    childthread[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    childthread[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    childthread[[var_0]](var_2);
  } else {
    childthread[[var_0]]();
  }
}

_id_6E7D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  scripts\engine\utility::flag_wait(var_1[0]);
  scripts\engine\utility::delaythread_proc(var_0, var_1[1], var_2, var_3, var_4, var_5, var_6);
}

_id_13844(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self waittill(var_1[0]);
  scripts\engine\utility::delaythread_proc(var_0, var_1[1], var_2, var_3, var_4, var_5, var_6);
}

_id_178E() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");

  for(var_0 = 0; var_0 < 20; var_0++) {
    waittillframeend;
  }
}

_id_12D95() {}

_id_4461(var_0, var_1, var_2, var_3) {
  if(!var_1.size) {
    return undefined;
  }

  if(isDefined(var_2)) {
    var_4 = undefined;
    var_5 = getarraykeys(var_1);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = distance(var_1[var_5[var_6]].v["origin"], var_0);

      if([[var_3]](var_7, var_2)) {
        continue;
      }
      var_2 = var_7;
      var_4 = var_1[var_5[var_6]];
    }

    return var_4;
  }

  var_5 = getarraykeys(var_1);
  var_4 = var_1[var_5[0]];
  var_2 = distance(var_4.v["origin"], var_0);

  for(var_6 = 1; var_6 < var_5.size; var_6++) {
    var_7 = distance(var_1[var_5[var_6]].v["origin"], var_0);

    if([[var_3]](var_7, var_2)) {
      continue;
    }
    var_2 = var_7;
    var_4 = var_1[var_5[var_6]];
  }

  return var_4;
}

_id_13816() {
  for(;;) {
    self waittill("trigger", var_0);
    waittillframeend;

    if(var_0._id_4BF7 == self) {
      return var_0;
    }
  }
}

_id_1789() {
  self._id_1274A = [];
  self waittill("trigger", var_0);
  var_1 = self._id_1274A;
  self._id_1274A = undefined;

  foreach(var_3 in var_1) {
    thread[[var_3]](var_0);
  }
}

_id_1778(var_0) {
  if(!isDefined(level._id_EC91[var_0])) {
    level._id_EC91[var_0] = var_0;
  }
}

_id_1773(var_0) {
  if(!isDefined(level._id_EC8E[var_0])) {
    level._id_EC8E[var_0] = var_0;
  }
}

_id_175F(var_0) {
  if(!isDefined(level._id_EC85[self._id_1FBB])) {
    level._id_EC85[self._id_1FBB] = [];
  }

  if(!isDefined(level.scr_sound[self._id_1FBB])) {
    level.scr_sound[self._id_1FBB] = [];
  }

  if(!isDefined(level.scr_sound[self._id_1FBB][var_0])) {
    level.scr_sound[self._id_1FBB][var_0] = var_0;
  }
}

_id_1760(var_0) {
  if(!isDefined(level.scr_sound["generic"])) {
    level.scr_sound["generic"] = [];
  }

  if(!isDefined(level.scr_sound["generic"][var_0])) {
    level.scr_sound["generic"][var_0] = var_0;
  }
}

_id_1287(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_2);
    scripts\engine\utility::flag_set(var_0);

    if(!var_1) {
      return;
    }
    while(var_2 istouching(self)) {
      wait 0.05;
    }

    scripts\engine\utility::flag_clear(var_0);
  }
}

_id_7615(var_0, var_1) {
  var_0._id_75BA = 1;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    _id_22D4(var_0.fx, scripts\engine\utility::pauseeffect);
  } else {
    scripts\engine\utility::array_thread(var_0.fx, scripts\engine\utility::pauseeffect);
  }
}

_id_22D4(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  var_4 = [];

  foreach(var_6 in var_0) {
    var_4[var_4.size] = var_6;
    var_3++;
    var_3 = var_3 % var_2;

    if(var_2 == 0) {
      scripts\engine\utility::array_thread(var_4, var_1);
      wait 0.05;
      var_4 = [];
    }
  }
}

_id_28D9(var_0) {
  level endon("battlechatter_off_thread");
  scripts\anim\battlechatter::_id_29C1();

  while(!isDefined(anim._id_3D4B)) {
    wait 0.05;
  }

  anim._id_29B7 = 1;
  wait 1.5;

  if(isDefined(var_0)) {
    scripts\sp\utility::_id_F2DC(var_0, 1);
    var_1 = getaiarray(var_0);
  } else {
    foreach(var_0 in anim._id_115E7) {
      scripts\sp\utility::_id_F2DC(var_0, 1);
    }

    var_1 = getaiarray();
  }

  if(isDefined(level._id_A056) && isDefined(level._id_A056._id_1630)) {
    var_1 = scripts\engine\utility::array_combine(var_1, level._id_A056._id_1630);
  }

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_1[var_4] scripts\sp\utility::_id_F2DA(1);
  }
}

_id_517B(var_0, var_1) {
  var_0 endon("death");
  self waittill("death");

  if(isDefined(var_0)) {
    if(var_0 _meth_81CB()) {
      var_0 waittill(var_1);
    }

    var_0 delete();
  }
}

_id_F3A7(var_0, var_1) {
  thread scripts\sp\utility::_id_F3A5(var_0, var_1, scripts\sp\utility::empty_func, "set_flag_on_spawned");
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

_id_13757(var_0) {
  self waittill("death");
  var_0.count--;
  var_0 notify("waittill_dead guy died");
}

_id_13756(var_0) {
  scripts\engine\utility::waittill_either("death", "pain_death");
  var_0.count--;
  var_0 notify("waittill_dead_guy_dead_or_dying");
}

_id_13758(var_0) {
  wait(var_0);
  self notify("thread_timed_out");
}

dyndof_thread() {
  level endon("stop_dynDOF");

  for(;;) {
    var_0 = dyndof_distance();

    if(var_0 > -1) {
      dyndof_set(var_0);
    }

    wait 0.05;
  }
}

dyndof_set(var_0) {
  var_1 = 800;
  var_2 = var_0 / var_1;
  var_3 = level.dyndof.nearstart * var_2;
  var_4 = level.dyndof.nearend * var_2;
  var_5 = level.dyndof.farstart * var_2;
  var_6 = level.dyndof.farend * var_2;
  var_4 = var_3 + (level.dyndof.nearend - level.dyndof.nearstart) * var_2;
  var_4 = clamp(var_4, level.dyndof.nearendmindist, level.dyndof.nearendmaxdist);
  var_6 = var_5 + (level.dyndof.farend - level.dyndof.farstart) * var_2;
  _id_0B0A::_id_583F(var_3, var_4, level.dyndof.nearblur, var_5, var_6, level.dyndof.farblur, level.dyndof.focusspeed);
}

dyndof_distance() {
  var_0 = level.dyndof.maxfocusdist * 0.5;
  var_1 = 20;
  var_2 = dyndof_getplayerangles();
  var_3 = dyndof_getplayerorigin() + anglesToForward(var_2) * var_0;

  if(level.dyndof.prevorigin == var_3 && level.dyndof.prevangles == var_2) {
    return -1;
  }

  level.dyndof.prevorigin = var_3;
  level.dyndof.prevangles = var_2;
  var_2 = [];
  var_4 = 3;
  var_2[var_2.size] = (var_4 * -1, 0, 0);
  var_2[var_2.size] = (0, var_4, 0);
  var_2[var_2.size] = (0, var_4 * -1, 0);
  var_2[var_2.size] = (0, 0, 0);
  var_5 = [];

  foreach(var_9, var_7 in var_2) {
    var_8 = dyndof_trace_internal(var_7);

    if(!isDefined(var_8)) {
      continue;
    }
    var_5[var_5.size] = var_8[0];
  }

  if(var_5.size == 0) {
    return level.dyndof.maxfocusdist;
  }

  var_9 = 0;
  var_10 = var_5[var_9];

  for(var_11 = 1; var_11 < var_5.size; var_11++) {
    if(var_5[var_11]["fraction"] < var_10["fraction"]) {
      var_10 = var_5[var_11];
    }
  }

  return level.dyndof.maxfocusdist * var_10["fraction"];
}

dyndof_trace_internal(var_0) {
  var_0 = combineangles(dyndof_getplayerangles(), var_0);
  var_1 = dyndof_getplayerorigin();
  var_2 = dyndof_getplayerorigin() + anglesToForward(var_0) * level.dyndof.maxfocusdist;
  return physics_raycast(var_1, var_2, level.dyndof._id_457D, [level.player], 1, "physicsquery_closest", 0);
}

dyndof_getplayerorigin() {
  if(level.player islinked()) {
    var_0 = level.player getlinkedparent();

    if(isDefined(var_0.dyndof_hastag)) {
      if(var_0.dyndof_hastag) {
        return var_0 gettagorigin("tag_camera");
      }
    } else if(isDefined(var_0.model)) {
      if(scripts\sp\utility::hastag(var_0.model, "tag_camera")) {
        var_0.dyndof_hastag = 1;
      } else {
        var_0.dyndof_hastag = 0;
      }
    }
  }

  return level.player getvieworigin();
}

dyndof_getplayerangles() {
  var_0 = level.player getplayerangles();
  return var_0;
}

create_dyndof() {
  var_0 = spawnStruct();
  var_0.maxfocusdist = 50000;
  var_0.focusspeed = 0.3;
  var_0._id_457D = get_dyndof_contents();
  var_0.nearstart = 0;
  var_0.nearend = 500;
  var_0.nearblur = 5;
  var_0.farstart = 2000;
  var_0.farend = 5000;
  var_0.farblur = 5;
  var_0.nearendmindist = 30;
  var_0.nearendmaxdist = 1000;
  var_0.farendmindist = 200;
  var_0.farendmaxdist = var_0.maxfocusdist;
  var_0.prevangles = (0, 0, 0);
  var_0.prevorigin = (0, 0, 0);
  return var_0;
}

destroy_dyndof() {
  level.dyndof = undefined;
}

get_dyndof_contents() {
  var_0 = ["physicscontents_actor", "physicscontents_canshootclip", "physicscontents_clipshot", "physicscontents_corpse", "physicscontents_corpseclipshot", "physicscontents_detail", "physicscontents_foliage", "physicscontents_item", "physicscontents_itemclip", "physicscontents_mantle", "physicscontents_player", "physicscontents_solid", "physicscontents_structural", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_water"];
  return physics_createcontents(var_0);
}