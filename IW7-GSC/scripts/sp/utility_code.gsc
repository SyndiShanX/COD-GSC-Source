/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\utility_code.gsc
***************************************/

func_11166(param_00, param_01) {
  var_02 = param_00.var_11159;
  var_03 = param_01.var_11159;
  self.var_2274[var_03] = param_00;
  self.var_2274[var_02] = param_01;
  self.var_2274[var_02].var_11159 = var_02;
  self.var_2274[var_03].var_11159 = var_03;
}

func_1368E() {
  self endon("death");
  self endon("removed from battleChatter");
  while(self.var_9F6B) {
    wait(0.05);
  }
}

func_13636(param_00) {
  self endon("death");
  param_00 endon("trigger");
  self waittill("trigger");
  param_00 notify("trigger");
}

func_13634(param_00, param_01) {
  var_02 = getEntArray(param_00, param_01);
  var_03 = spawnStruct();
  scripts\engine\utility::array_thread(var_02, ::func_13636, var_03);
  var_03 waittill("trigger");
}

func_65FB(param_00) {
  self endon("done");
  param_00 waittill("trigger");
  self notify("done");
}

func_12DAC() {
  self notify("debug_color_update");
  self endon("debug_color_update");
  var_00 = self.unique_id;
  self waittill("death");
  level.var_4EBE[var_00] = undefined;
  level notify("updated_color_friendlies");
}

func_12DAB(param_00) {
  thread func_12DAC();
  if(isDefined(self.var_EDAD)) {
    level.var_4EBE[param_00] = self.var_EDAD;
  } else {
    level.var_4EBE[param_00] = undefined;
  }

  level notify("updated_color_friendlies");
}

func_9938() {}

func_BF01(param_00) {
  self notify("new_color_being_set");
  self.var_BF06 = 1;
  scripts\sp\colors::func_AB3A();
  self endon("new_color_being_set");
  self endon("death");
  waittillframeend;
  waittillframeend;
  if(isDefined(self.var_EDAD)) {
    self.var_4BDF = level.var_4BE0[scripts\sp\colors::func_7CE4()][self.var_EDAD];
    if(isDefined(self.var_5955)) {
      self.var_5955 = undefined;
    } else {
      thread scripts\sp\colors::_meth_8467();
    }
  }

  self.var_BF06 = undefined;
  self notify("done_setting_new_color");
}

func_65FA(param_00, param_01) {
  self endon(param_00);
  wait(param_01);
}

func_13764(param_00, param_01, param_02) {
  param_00 endon("done");
  [[param_01]](param_02);
  param_00 notify("done");
}

func_9022(param_00, param_01) {
  self endon("hint_print_timeout");
  self endon("hint_print_remove");
  param_01 endon("new_hint");
  for(;;) {
    self.var_6AB8 = 1;
    if((isDefined(level.var_8FE4) && [
        [level.var_8FE4]
      ]()) || param_01.var_4B7A != param_00) {
      break;
    }

    wait(0.05);
  }
}

func_9014(param_00) {
  wait(param_00);
  self.var_6AB8 = 1;
  self notify("hint_print_timeout");
}

func_900D(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  return param_00 + func_12DB(param_01, param_02, param_03, param_04, param_05, param_06);
}

func_12DB(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = getsticksconfig();
  if(level.player scripts\engine\utility::is_player_gamepad_enabled()) {
    if((isDefined(level.var_DADB) && level.var_DADB) || isDefined(level.var_DADC) && level.var_DADC) {
      if(issubstr(var_06, "southpaw") || param_05 && issubstr(var_06, "legacy")) {
        return param_04;
      }

      return param_03;
    }

    if(issubstr(var_06, "southpaw") || param_05 && issubstr(var_06, "legacy")) {
      return param_02;
    }

    return param_01;
  }

  return param_00;
}

func_12DC(param_00, param_01) {
  var_02 = param_01 + param_00;
  var_03 = level.var_1274F[var_02];
  level.var_8FE4 = var_03;
}

func_12DD(param_00, param_01) {
  var_02 = param_01 + param_00;
  var_03 = level.var_12750[var_02];
  var_04 = scripts\sp\utility::func_7B92();
  var_04 sethudtutorialmessage(var_03);
}

func_900E(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  level notify("hint_change_config");
  level endon("hint_change_config");
  var_07 = func_12DB(param_01, param_02, param_03, param_04, param_05, param_06);
  while(isDefined(level.var_4B80) && level.var_4B80) {
    var_08 = func_12DB(param_01, param_02, param_03, param_04, param_05, param_06);
    if(var_08 != var_07) {
      var_07 = var_08;
      func_12DC(var_07, param_00);
      func_12DD(var_07, param_00);
    }

    scripts\engine\utility::waitframe();
  }
}

func_9021(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self notify("new_hint");
  var_07 = gettime();
  if(!isDefined(param_06)) {
    param_06 = 0;
  }

  if(!isalive(self)) {
    return;
  }

  scripts\sp\utility::func_65E8("global_hint_in_use");
  if(isDefined(self.var_4B7A)) {
    if(self.var_4B7A == param_00) {
      return;
    } else {
      self.var_4B7A = param_00;
      scripts\sp\utility::func_65E1("global_hint_in_use");
      wait(0.05);
    }
  }

  self.var_4B7A = param_00;
  scripts\sp\utility::func_65E1("global_hint_in_use");
  level.var_4B80 = 1;
  level.var_8FE4 = param_01;
  level endon("friendlyfire_mission_fail");
  self sethudtutorialmessage(param_00);
  var_08 = spawnStruct();
  var_08.var_6AB8 = 0;
  if(isDefined(param_05)) {
    var_08 thread func_9014(param_05);
  }

  var_08 thread func_52AB();
  var_08 thread func_52AC();
  var_08 thread destroy_hint_on_c6_grab();
  var_08 func_9022(param_00, self);
  if(!scripts\engine\utility::istrue(var_08.var_6AB8)) {
    self clearhudtutorialmessage(1);
  }

  scripts\sp\utility::func_135AF(var_07, param_06);
  var_08 notify("removing_hint");
  self.var_4B7A = undefined;
  if(var_08.var_6AB8) {
    self clearhudtutorialmessage();
  }

  level.var_4B80 = 0;
  scripts\sp\utility::func_65DD("global_hint_in_use");
}

func_52AB(param_00) {
  self endon("removing_hint");
  level waittill("friendlyfire_mission_fail");
  self.var_6AB8 = 1;
  self notify("hint_print_remove");
}

destroy_hint_on_c6_grab(param_00) {
  self endon("removing_hint");
  for(;;) {
    if(!isDefined(level.player.melee)) {
      wait(0.05);
    } else if(!isDefined(level.player.melee.var_B5FE)) {
      wait(0.05);
    } else {
      break;
    }

    wait(0.05);
  }

  self.var_6AB8 = 1;
  self notify("hint_print_remove");
}

func_52AC(param_00) {
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
  self.var_6AB8 = 1;
  self notify("hint_print_remove");
}

func_74DE(param_00) {
  self endon("death");
  param_00 scripts\engine\utility::waittill_either("function_done", "death");
}

func_74DF(param_00) {
  func_74DE(param_00);
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

func_74DB(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  if(!isDefined(param_00.var_74D7)) {
    param_00.var_74D7 = [];
  }

  param_00.var_74D7[param_00.var_74D7.size] = self;
  thread func_74DC(param_00);
  func_74D8(param_00);
  if(isDefined(param_00) && isDefined(param_00.var_74D7)) {
    self.var_74DA = 1;
    self notify("function_stack_func_begun");
    if(isDefined(param_06)) {
      param_00[[param_01]](param_02, param_03, param_04, param_05, param_06);
    } else if(isDefined(param_05)) {
      param_00[[param_01]](param_02, param_03, param_04, param_05);
    } else if(isDefined(param_04)) {
      param_00[[param_01]](param_02, param_03, param_04);
    } else if(isDefined(param_03)) {
      param_00[[param_01]](param_02, param_03);
    } else if(isDefined(param_02)) {
      param_00[[param_01]](param_02);
    } else {
      param_00[[param_01]]();
    }

    if(isDefined(param_00) && isDefined(param_00.var_74D7)) {
      param_00.var_74D7 = scripts\engine\utility::array_remove(param_00.var_74D7, self);
      param_00 notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self.var_74DA = 0;
    self notify("function_done");
  }
}

func_74DC(param_00) {
  self endon("function_done");
  self waittill("death");
  if(isDefined(param_00)) {
    param_00.var_74D7 = scripts\engine\utility::array_remove(param_00.var_74D7, self);
    param_00 notify("level_function_stack_ready");
  }
}

func_74D8(param_00) {
  param_00 endon("death");
  self endon("death");
  param_00 endon("clear_function_stack");
  while(param_00.var_74D7[0] != self) {
    param_00 waittill("level_function_stack_ready");
  }
}

func_1362A(param_00, param_01) {
  if(isDefined(param_01)) {
    param_01 endon("death");
  }

  self endon("death");
  param_00 waittill("sounddone");
  return 1;
}

func_22D9(param_00, param_01, param_02) {
  func_22DA(param_00, param_01, param_02);
  self.var_1187 = 0;
  self notify("_array_wait");
}

func_22DA(param_00, param_01, param_02) {
  param_00 endon(param_01);
  param_00 endon("death");
  if(isDefined(param_02)) {
    wait(param_02);
    return;
  }

  param_00 waittill(param_01);
}

func_68CC(param_00) {
  if(param_00.var_C8FD.size == 0) {
    param_00.var_376B[[param_00.func]]();
  } else if(param_00.var_C8FD.size == 1) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0]);
  } else if(param_00.var_C8FD.size == 2) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1]);
  } else if(param_00.var_C8FD.size == 3) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1], param_00.var_C8FD[2]);
  }

  if(param_00.var_C8FD.size == 4) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1], param_00.var_C8FD[2], param_00.var_C8FD[3]);
  }

  if(param_00.var_C8FD.size == 5) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1], param_00.var_C8FD[2], param_00.var_C8FD[3], param_00.var_C8FD[4]);
  }
}

func_68CD(param_00) {
  if(param_00.var_C8FD.size == 0) {
    [[param_00.func]]();
  } else if(param_00.var_C8FD.size == 1) {
    [[param_00.func]](param_00.var_C8FD[0]);
  } else if(param_00.var_C8FD.size == 2) {
    [[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1]);
  } else if(param_00.var_C8FD.size == 3) {
    [[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1], param_00.var_C8FD[2]);
  }

  if(param_00.var_C8FD.size == 4) {
    [[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1], param_00.var_C8FD[2], param_00.var_C8FD[3]);
  }

  if(param_00.var_C8FD.size == 5) {
    [[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1], param_00.var_C8FD[2], param_00.var_C8FD[3], param_00.var_C8FD[4]);
  }
}

func_68CE(param_00, param_01) {
  if(!isDefined(param_00.var_376B)) {
    return;
  }

  for(var_02 = 0; var_02 < param_01.size; var_02++) {
    param_01[var_02].var_376B endon(param_01[var_02].var_6317);
  }

  if(param_00.var_C8FD.size == 0) {
    param_00.var_376B[[param_00.func]]();
  } else if(param_00.var_C8FD.size == 1) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0]);
  } else if(param_00.var_C8FD.size == 2) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1]);
  } else if(param_00.var_C8FD.size == 3) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1], param_00.var_C8FD[2]);
  }

  if(param_00.var_C8FD.size == 4) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1], param_00.var_C8FD[2], param_00.var_C8FD[3]);
  }

  if(param_00.var_C8FD.size == 5) {
    param_00.var_376B[[param_00.func]](param_00.var_C8FD[0], param_00.var_C8FD[1], param_00.var_C8FD[2], param_00.var_C8FD[3], param_00.var_C8FD[4]);
  }
}

func_13774(param_00, param_01) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  func_68CE(param_00, param_01);
  self.var_C1--;
  self notify("func_ended");
}

func_13720(param_00, param_01) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  func_68CE(param_00, param_01);
  self.var_1521--;
  self notify("abort_func_ended");
}

func_5767(param_00) {
  self endon("all_funcs_ended");
  if(!param_00.size) {
    return;
  }

  var_01 = 0;
  self.var_1521 = param_00.size;
  var_02 = [];
  scripts\engine\utility::array_levelthread(param_00, ::func_13720, var_02);
  for(;;) {
    if(self.var_1521 <= var_01) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

func_12688(param_00) {
  if(isDefined(self.missionfailed)) {
    var_01 = anglesToForward(param_00.angles);
    param_00.origin = param_00.origin + var_01 * self.missionfailed;
  }

  if(isDefined(self.setdebugorigin)) {
    var_02 = anglestoright(param_00.angles);
    param_00.origin = param_00.origin + var_02 * self.setdebugorigin;
  }

  if(isDefined(self.var_367)) {
    var_03 = anglestoup(param_00.angles);
    param_00.origin = param_00.origin + var_03 * self.var_367;
  }

  if(isDefined(self.yaw)) {
    param_00 addyaw(self.yaw);
  }

  if(isDefined(self.var_CBE9)) {
    param_00 getnodeyawtoenemy(self.var_CBE9);
  }

  if(isDefined(self.var_E67D)) {
    param_00 getnodeyawtoorigin(self.var_E67D);
  }
}

func_5F8E(param_00, param_01, param_02, param_03, param_04) {
  self notify("start_dynamic_run_speed");
  self endon("death");
  self endon("stop_dynamic_run_speed");
  self endon("start_dynamic_run_speed");
  level endon("_stealth_spotted");
  if(scripts\sp\utility::func_65DF("_stealth_custom_anim")) {
    scripts\sp\utility::func_65E8("_stealth_custom_anim");
  }

  if(!scripts\sp\utility::func_65DF("dynamic_run_speed_stopped")) {
    scripts\sp\utility::func_65E0("dynamic_run_speed_stopped");
    scripts\sp\utility::func_65E0("dynamic_run_speed_stopping");
  } else {
    scripts\sp\utility::func_65DD("dynamic_run_speed_stopping");
    scripts\sp\utility::func_65DD("dynamic_run_speed_stopped");
  }

  self.var_E81D = "";
  self.var_C3CB = self.moveplaybackrate;
  thread func_10FE6();
  var_05 = param_00 * param_00;
  var_06 = param_01 * param_01;
  var_07 = param_02 * param_02;
  var_08 = param_03 * param_03;
  for(;;) {
    wait(0.05);
    var_09 = level.players[0];
    foreach(var_0B in level.players) {
      if(distancesquared(var_09.origin, self.origin) > distancesquared(var_0B.origin, self.origin)) {
        var_09 = var_0B;
      }
    }

    var_0D = anglesToForward(self.angles);
    var_0E = vectornormalize(var_09.origin - self.origin);
    var_0F = vectordot(var_0D, var_0E);
    var_10 = distancesquared(self.origin, var_09.origin);
    var_11 = var_10;
    if(isDefined(param_04)) {
      var_12 = scripts\engine\utility::getclosest(var_09.origin, param_04);
      var_11 = distancesquared(var_12.origin, var_09.origin);
    }

    var_13 = 0;
    if(isDefined(self.var_A905)) {
      var_13 = [
        [level.var_5EFB]
      ](self.var_A905, param_01);
    } else if(isDefined(self.var_A906)) {
      var_13 = [
        [level.var_5EFB]
      ](self.var_A906, param_01);
    }

    if(scripts\anim\utility::func_9D9B() && !self.var_5953) {
      self.moveplaybackrate = 1;
    }

    if(var_10 < var_06 || var_0F > -0.25 || var_13) {
      func_5F8C("sprint");
      wait(0.5);
      continue;
    } else if(var_10 < var_05 || var_0F > -0.25) {
      func_5F8C("run");
      wait(0.5);
      continue;
    } else if(var_11 > var_07) {
      if(self.a.movement != "stop") {
        func_5F8C("stop");
        wait(0.5);
      }

      continue;
    } else if(var_10 > var_08) {
      func_5F8C("jog");
      wait(0.5);
      continue;
    }
  }
}

func_10FE6() {
  self endon("start_dynamic_run_speed");
  self endon("death");
  func_10FE7();
  if(!self.var_5953) {
    self.moveplaybackrate = self.var_C3CB;
  }

  if(isDefined(level.var_EC85["generic"]["DRS_run"])) {
    if(isarray(level.var_EC85["generic"]["DRS_run"])) {
      scripts\sp\utility::func_F3CC("DRS_run");
    } else {
      scripts\sp\utility::func_F3CB("DRS_run");
    }
  } else {
    scripts\sp\utility::func_417A();
  }

  self notify("stop_loop");
  scripts\sp\utility::func_65DD("dynamic_run_speed_stopping");
  scripts\sp\utility::func_65DD("dynamic_run_speed_stopped");
}

func_10FE7() {
  level endon("_stealth_spotted");
  self waittill("stop_dynamic_run_speed");
}

func_5F8C(param_00) {
  if(self.var_E81D == param_00) {
    return;
  }

  self.var_E81D = param_00;
  switch (param_00) {
    case "sprint":
      if(scripts\anim\utility::func_9D9B() && !self.var_5953) {
        self.moveplaybackrate = 1;
      } else if(!self.var_5953) {
        self.moveplaybackrate = 1.15;
      }

      if(isarray(level.var_EC85["generic"]["DRS_sprint"])) {
        scripts\sp\utility::func_F3CC("DRS_sprint");
      } else {
        scripts\sp\utility::func_F3CB("DRS_sprint");
      }

      self notify("stop_loop");
      scripts\sp\utility::anim_stopanimscripted();
      scripts\sp\utility::func_65DD("dynamic_run_speed_stopped");
      break;

    case "run":
      if(!self.var_5953) {
        self.moveplaybackrate = self.var_C3CB;
      }

      if(isDefined(level.var_EC85["generic"]["DRS_run"])) {
        if(isarray(level.var_EC85["generic"]["DRS_run"])) {
          scripts\sp\utility::func_F3CC("DRS_run");
        } else {
          scripts\sp\utility::func_F3CB("DRS_run");
        }
      } else {
        scripts\sp\utility::func_417A();
      }

      self notify("stop_loop");
      scripts\sp\utility::anim_stopanimscripted();
      scripts\sp\utility::func_65DD("dynamic_run_speed_stopped");
      break;

    case "stop":
      thread func_5F8F();
      break;

    case "jog":
      if(!self.var_5953) {
        self.moveplaybackrate = self.var_C3CB;
      }

      if(isDefined(level.var_EC85["generic"]["DRS_combat_jog"])) {
        if(isarray(level.var_EC85["generic"]["DRS_combat_jog"])) {
          scripts\sp\utility::func_F3CC("DRS_combat_jog");
        } else {
          scripts\sp\utility::func_F3CB("DRS_combat_jog");
        }
      } else {
        scripts\sp\utility::func_417A();
      }

      self notify("stop_loop");
      scripts\sp\utility::anim_stopanimscripted();
      scripts\sp\utility::func_65DD("dynamic_run_speed_stopped");
      break;

    case "crouch":
      break;
  }
}

func_5F8F() {
  self endon("death");
  if(scripts\sp\utility::func_65DB("dynamic_run_speed_stopped")) {
    return;
  }

  if(scripts\sp\utility::func_65DB("dynamic_run_speed_stopping")) {
    return;
  }

  self endon("stop_dynamic_run_speed");
  scripts\sp\utility::func_65E1("dynamic_run_speed_stopping");
  scripts\sp\utility::func_65E1("dynamic_run_speed_stopped");
  self endon("dynamic_run_speed_stopped");
  var_00 = "DRS_run_2_stop";
  scripts\sp\anim::func_1EC8(self, "gravity", var_00);
  scripts\sp\utility::func_65DD("dynamic_run_speed_stopping");
  while(scripts\sp\utility::func_65DB("dynamic_run_speed_stopped")) {
    var_01 = "DRS_stop_idle";
    thread scripts\sp\anim::func_1ECC(self, var_01);
    if(isDefined(level.var_EC85["generic"]["signal_go"])) {
      func_8A0B("go");
    }

    wait(randomfloatrange(12, 20));
    if(scripts\sp\utility::func_65DF("_stealth_stance_handler")) {
      scripts\sp\utility::func_65E8("_stealth_stance_handler");
    }

    self notify("stop_loop");
    if(!scripts\sp\utility::func_65DB("dynamic_run_speed_stopped")) {
      return;
    }

    if(isDefined(level.var_5F8D)) {
      var_02 = scripts\engine\utility::random(level.var_5F8D);
      level thread scripts\sp\utility::func_DBF3(var_02);
    }

    if(isDefined(level.var_EC85["generic"]["signal_go"])) {
      func_8A0B("go");
    }
  }
}

func_8A0B(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  if(isDefined(param_01)) {
    var_04 = !param_01;
  }

  if(isDefined(param_02)) {
    level endon(param_02);
  }

  if(isDefined(param_03)) {
    level waittill(param_03);
  }

  var_05 = "signal_" + param_00;
  if(self.a.pose == "crouch") {
    var_05 = var_05 + "_crouch";
  } else if(self.script == "cover_right") {
    var_05 = var_05 + "_coverR";
  } else if(scripts\anim\utility::func_9D9B()) {
    var_05 = var_05 + "_cqb";
  }

  if(var_04) {
    self give_capture_credit(scripts\sp\utility::func_7ECF(var_05), 1, 0, 1.1);
    return;
  }

  scripts\sp\anim::func_1EC7(self, var_05);
}

func_764E() {
  return int(getdvar("g_speed"));
}

func_764F(param_00) {
  setsaveddvar("g_speed", int(param_00));
}

func_7647() {
  return level.player _meth_810B();
}

func_7648(param_00) {
  level.player give_crafted_fireworks_trap(param_00);
}

func_BCF0() {
  return self.var_BCF5;
}

func_BCF3(param_00) {
  self.var_BCF5 = param_00;
  self setmovespeedscale(param_00);
}

func_2680() {
  if(scripts\engine\utility::flag_exist("autosave_tactical_player_nade")) {
    return;
  }

  scripts\engine\utility::flag_init("autosave_tactical_player_nade");
  level.var_267E = 0;
  notifyoncommand("autosave_player_nade", "+frag");
  notifyoncommand("autosave_player_nade", "-smoke");
  notifyoncommand("autosave_player_nade", "+smoke");
  scripts\engine\utility::array_thread(level.players, ::func_267A);
}

func_267A() {
  for(;;) {
    self waittill("autosave_player_nade");
    scripts\engine\utility::flag_set("autosave_tactical_player_nade");
    thread func_267C();
    scripts\engine\utility::waittill_any_timeout_1(10, "autosave_grenade_thrown");
    self notify("autosave_grenade_throw_timeout");
    func_267D();
  }
}

func_267C() {
  self endon("autosave_grenade_throw_timeout");
  self waittill("grenade_fire", var_00);
  thread func_267B(var_00);
  self notify("autosave_grenade_thrown");
}

func_267D() {
  waittillframeend;
  if(!level.var_267E) {
    scripts\engine\utility::flag_clear("autosave_tactical_player_nade");
  }
}

func_267B(param_00) {
  level.var_267E++;
  param_00 scripts\engine\utility::waittill_notify_or_timeout("death", 10);
  level.var_267E--;
  func_267D();
}

func_267F() {
  level notify("autosave_tactical_proc");
  level endon("autosave_tactical_proc");
  level thread scripts\sp\utility::func_C12D("kill_save", 5);
  level endon("kill_save");
  level endon("autosave_tactical_player_nade");
  if(scripts\engine\utility::flag("autosave_tactical_player_nade")) {
    scripts\engine\utility::flag_waitopen_or_timeout("autosave_tactical_player_nade", 4);
    if(scripts\engine\utility::flag("autosave_tactical_player_nade")) {
      return;
    }
  }

  var_00 = getaiarray("axis");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.isnodeoccupied) && isplayer(var_02.isnodeoccupied)) {
      return;
    }
  }

  waittillframeend;
  scripts\sp\utility::func_2669();
}

func_BDE6(param_00, param_01, param_02, param_03) {
  scripts\sp\utility::func_BDEC(param_01);
  level endon("stop_music");
  wait(param_01);
  thread scripts\sp\utility::func_BDE5(param_00, undefined, param_02, param_03);
}

func_BDE2(param_00, param_01, param_02, param_03, param_04, param_05) {
  scripts\sp\utility::func_BDEC(param_02);
  level endon("stop_music");
  wait(param_02);
  thread func_BDE1(param_00, param_01, undefined, param_03, param_04, param_05);
}

func_BDE1(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_02) && param_02 > 0) {
    thread func_BDE2(param_00, param_01, param_02, param_03, param_04, param_05);
    return;
  }

  scripts\sp\utility::func_BDEC();
  level endon("stop_music");
  scripts\sp\utility::func_BDF2(param_00, param_03, param_04);
  if(isDefined(param_05) && param_05 == 1 && scripts\engine\utility::flag_exist("_stealth_spotted")) {
    level endon("_stealth_spotted");
    thread func_BDE4(param_00, param_01, param_02);
  }

  var_06 = scripts\sp\utility::func_BDF1(param_00);
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(param_01 <= 10) {
    var_06 = var_06 + param_01;
  }

  wait(var_06);
  scripts\sp\utility::func_BDDF(param_00, param_01, param_02, param_03, param_04);
}

func_BDE4(param_00, param_01, param_02) {
  level endon("stop_music");
  scripts\engine\utility::flag_wait("_stealth_spotted");
  musicstop(0.5);
  while(scripts\engine\utility::flag("_stealth_spotted")) {
    scripts\engine\utility::flag_waitopen("_stealth_spotted");
    wait(1);
  }

  thread scripts\sp\utility::func_BDDF(param_00, param_01, param_02);
}

func_5AAD(param_00, param_01, param_02) {
  self endon("death");
  self endon("stop_sliding");
  var_03 = self;
  var_04 = undefined;
  var_05 = param_00.origin;
  var_06 = param_00.origin;
  var_07 = undefined;
  for(;;) {
    var_08 = var_03 getnormalizedmovement();
    var_09 = anglesToForward(var_03.angles);
    var_0A = anglestoright(var_03.angles);
    var_08 = (var_08[1] * var_0A[0] + var_08[0] * var_09[0], var_08[1] * var_0A[1] + var_08[0] * var_09[1], 0);
    param_00.slidevelocity = param_00.slidevelocity + var_08 * param_01;
    var_03.var_7601.origin = param_00.origin + anglesToForward(param_00.var_77BA.angles) * 400;
    wait(0.05);
    param_00.slidevelocity = param_00.slidevelocity * 1 - param_02;
  }
}

func_A5CF(param_00) {
  self endon("death");
  if(isDefined(param_00)) {
    wait(randomfloat(param_00));
  }

  playFXOnTag(scripts\engine\utility::getfx("flesh_hit"), self, "tag_eye");
  self _meth_81D0(level.player.origin);
}

func_12E1F(param_00, param_01) {
  self endon("death");
  var_02 = 0;
  for(;;) {
    if(self.var_99E5 > 0.0001 && gettime() > 300) {
      if(!var_02) {
        self _meth_8244(param_01);
        var_02 = 1;
      }
    } else if(var_02) {
      self stoprumble(param_01);
      var_02 = 0;
    }

    var_03 = 1 - self.var_99E5;
    var_03 = var_03 * 1000;
    self.origin = param_00 getEye() + (0, 0, var_03);
    wait(0.05);
  }
}

func_D961(param_00, param_01, param_02, param_03, param_04) {
  waittillframeend;
  if(!isDefined(self.start)) {
    self.start = 0;
  }

  if(!isDefined(self.end)) {
    self.end = 1;
  }

  if(!isDefined(self.var_2857)) {
    self.var_2857 = 0;
  }

  var_05 = self.time * 20;
  var_06 = self.end - self.start;
  self.var_10FCB = 0;
  if(isDefined(param_04)) {
    for(var_07 = 0; var_07 <= var_05 && !self.var_10FCB; var_07++) {
      var_08 = self.var_2857 + var_07 * var_06 / var_05;
      param_01 thread[[param_00]](var_08, param_02, param_03, param_04);
      wait(0.05);
    }

    return;
  }

  if(isDefined(var_05)) {
    for(var_07 = 0; var_07 <= var_05 && !self.var_10FCB; var_07++) {
      var_08 = self.var_2857 + var_07 * var_06 / var_05;
      param_01 thread[[param_00]](var_08, param_02, param_03);
      wait(0.05);
    }

    return;
  }

  if(isDefined(param_04)) {
    for(var_07 = 0; var_07 <= var_05 && !self.var_10FCB; var_07++) {
      var_08 = self.var_2857 + var_07 * var_06 / var_05;
      param_01 thread[[param_00]](var_08, param_02);
      wait(0.05);
    }

    return;
  }

  for(var_07 = 0; var_07 <= var_05 && !self.var_10FCB; var_07++) {
    var_08 = self.var_2857 + var_07 * var_06 / var_05;
    param_01 thread[[param_00]](var_08);
    wait(0.05);
  }
}

func_78D1() {
  var_00 = "allies";
  if(isDefined(self.var_ED34)) {
    var_00 = "axis";
  }

  var_00 = scripts\sp\colors::func_7CE4(var_00);
  var_01 = [];
  if(var_00 == "allies") {
    var_02 = scripts\sp\colors::func_78D9(self.var_ED33, "allies");
    var_01 = var_02["colorCodes"];
  } else {
    var_02 = scripts\sp\colors::func_78D9(self.var_ED34, "axis");
    var_01 = var_02["colorCodes"];
  }

  var_03 = [];
  var_03["team"] = var_00;
  var_03["codes"] = var_01;
  return var_03;
}

func_50E5(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("death");
  self endon("stop_delay_thread");
  wait(param_01);
  if(isDefined(param_07)) {
    childthread[[param_00]](param_02, param_03, param_04, param_05, param_06, param_07);
    return;
  }

  if(isDefined(param_06)) {
    childthread[[param_00]](param_02, param_03, param_04, param_05, param_06);
    return;
  }

  if(isDefined(param_05)) {
    childthread[[param_00]](param_02, param_03, param_04, param_05);
    return;
  }

  if(isDefined(param_04)) {
    childthread[[param_00]](param_02, param_03, param_04);
    return;
  }

  if(isDefined(param_03)) {
    childthread[[param_00]](param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    childthread[[param_00]](param_02);
    return;
  }

  childthread[[param_00]]();
}

func_6E7D(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  scripts\engine\utility::flag_wait(param_01[0]);
  scripts\engine\utility::delaythread_proc(param_00, param_01[1], param_02, param_03, param_04, param_05, param_06);
}

func_13844(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  self waittill(param_01[0]);
  scripts\engine\utility::delaythread_proc(param_00, param_01[1], param_02, param_03, param_04, param_05, param_06);
}

func_178E() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");
  for(var_00 = 0; var_00 < 20; var_00++) {
    waittillframeend;
  }
}

func_12D95() {}

func_4461(param_00, param_01, param_02, param_03) {
  if(!param_01.size) {
    return undefined;
  }

  if(isDefined(param_02)) {
    var_04 = undefined;
    var_05 = getarraykeys(param_01);
    for(var_06 = 0; var_06 < var_05.size; var_06++) {
      var_07 = distance(param_01[var_05[var_06]].v["origin"], param_00);
      if([[param_03]](var_07, param_02)) {
        continue;
      }

      param_02 = var_07;
      var_04 = param_01[var_05[var_06]];
    }

    return var_04;
  }

  var_05 = getarraykeys(var_05);
  var_04 = var_04[var_07[0]];
  var_04 = distance(var_07.v["origin"], param_02);
  for(var_06 = 1; var_06 < var_04.size; var_06++) {
    var_07 = distance(param_01[var_04[var_06]].v["origin"], param_00);
    if([
        [param_03]
      ](var_07, param_02)) {
      continue;
    }

    param_02 = var_07;
    var_05 = param_01[var_04[var_06]];
  }

  return var_05;
}

func_13816() {
  for(;;) {
    self waittill("trigger", var_00);
    waittillframeend;
    if(var_00.var_4BF7 == self) {
      return var_00;
    }
  }
}

func_1789() {
  self.var_1274A = [];
  self waittill("trigger", var_00);
  var_01 = self.var_1274A;
  self.var_1274A = undefined;
  foreach(var_03 in var_01) {
    thread[[var_03]](var_00);
  }
}

func_1778(param_00) {
  if(!isDefined(level.var_EC91[param_00])) {
    level.var_EC91[param_00] = param_00;
  }
}

func_1773(param_00) {
  if(!isDefined(level.var_EC8E[param_00])) {
    level.var_EC8E[param_00] = param_00;
  }
}

func_175F(param_00) {
  if(!isDefined(level.var_EC85[self.var_1FBB])) {
    level.var_EC85[self.var_1FBB] = [];
  }

  if(!isDefined(level.scr_sound[self.var_1FBB])) {
    level.scr_sound[self.var_1FBB] = [];
  }

  if(!isDefined(level.scr_sound[self.var_1FBB][param_00])) {
    level.scr_sound[self.var_1FBB][param_00] = param_00;
  }
}

func_1760(param_00) {
  if(!isDefined(level.scr_sound["generic"])) {
    level.scr_sound["generic"] = [];
  }

  if(!isDefined(level.scr_sound["generic"][param_00])) {
    level.scr_sound["generic"][param_00] = param_00;
  }
}

func_1287(param_00, param_01) {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_02);
    scripts\engine\utility::flag_set(param_00);
    if(!param_01) {
      return;
    }

    while(var_02 istouching(self)) {
      wait(0.05);
    }

    scripts\engine\utility::flag_clear(param_00);
  }
}

func_7615(param_00, param_01) {
  param_00.var_75BA = 1;
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01) {
    func_22D4(param_00.fx, ::scripts\engine\utility::pauseeffect);
    return;
  }

  scripts\engine\utility::array_thread(param_00.fx, ::scripts\engine\utility::pauseeffect);
}

func_22D4(param_00, param_01, param_02) {
  var_03 = 0;
  if(!isDefined(param_02)) {
    param_02 = 5;
  }

  var_04 = [];
  foreach(var_06 in param_00) {
    var_04[var_04.size] = var_06;
    var_03++;
    var_03 = var_03 % param_02;
    if(param_02 == 0) {
      scripts\engine\utility::array_thread(var_04, param_01);
      wait(0.05);
      var_04 = [];
    }
  }
}

func_28D9(param_00) {
  level endon("battlechatter_off_thread");
  scripts\anim\battlechatter::func_29C1();
  while(!isDefined(level.var_3D4B)) {
    wait(0.05);
  }

  anim.var_29B7 = 1;
  wait(1.5);
  if(isDefined(param_00)) {
    scripts\sp\utility::func_F2DC(param_00, 1);
    var_01 = getaiarray(param_00);
  } else {
    foreach(param_00 in level.var_115E7) {
      scripts\sp\utility::func_F2DC(param_00, 1);
    }

    var_01 = getaiarray();
  }

  if(isDefined(level.var_A056) && isDefined(level.var_A056.var_1630)) {
    var_01 = scripts\engine\utility::array_combine(var_01, level.var_A056.var_1630);
  }

  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    var_01[var_04] scripts\sp\utility::func_F2DA(1);
  }
}

func_517B(param_00, param_01) {
  param_00 endon("death");
  self waittill("death");
  if(isDefined(param_00)) {
    if(param_00 gettimepassed()) {
      param_00 waittill(param_01);
    }

    param_00 delete();
  }
}

func_F3A7(param_00, param_01) {
  thread scripts\sp\utility::func_F3A5(param_00, param_01, ::scripts\sp\utility::empty_func, "set_flag_on_spawned");
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

func_13757(param_00) {
  self waittill("death");
  param_00.var_C1--;
  param_00 notify("waittill_dead guy died");
}

func_13756(param_00) {
  scripts\engine\utility::waittill_either("death", "pain_death");
  param_00.var_C1--;
  param_00 notify("waittill_dead_guy_dead_or_dying");
}

func_13758(param_00) {
  wait(param_00);
  self notify("thread_timed_out");
}

dyndof_thread() {
  level endon("stop_dynDOF");
  for(;;) {
    var_00 = dyndof_distance();
    if(var_00 > -1) {
      dyndof_set(var_00);
    }

    wait(0.05);
  }
}

dyndof_set(param_00) {
  var_01 = 800;
  var_02 = param_00 / var_01;
  var_03 = level.dyndof.nearstart * var_02;
  var_04 = level.dyndof.nearend * var_02;
  var_05 = level.dyndof.farstart * var_02;
  var_06 = level.dyndof.farend * var_02;
  var_04 = var_03 + level.dyndof.nearend - level.dyndof.nearstart * var_02;
  var_04 = clamp(var_04, level.dyndof.nearendmindist, level.dyndof.nearendmaxdist);
  var_06 = var_05 + level.dyndof.farend - level.dyndof.farstart * var_02;
  scripts\sp\art::func_583F(var_03, var_04, level.dyndof.nearblur, var_05, var_06, level.dyndof.farblur, level.dyndof.focusspeed);
}

dyndof_distance() {
  var_00 = level.dyndof.maxfocusdist * 0.5;
  var_01 = 20;
  var_02 = dyndof_getplayerangles();
  var_03 = dyndof_getplayerorigin() + anglesToForward(var_02) * var_00;
  if(level.dyndof.prevorigin == var_03 && level.dyndof.prevangles == var_02) {
    return -1;
  }

  level.dyndof.prevorigin = var_03;
  level.dyndof.prevangles = var_02;
  var_02 = [];
  var_04 = 3;
  var_02[var_02.size] = (var_04 * -1, 0, 0);
  var_02[var_02.size] = (0, var_04, 0);
  var_02[var_02.size] = (0, var_04 * -1, 0);
  var_02[var_02.size] = (0, 0, 0);
  var_05 = [];
  foreach(var_07 in var_02) {
    var_08 = dyndof_trace_internal(var_07);
    if(!isDefined(var_08)) {
      continue;
    }

    var_05[var_05.size] = var_08[0];
  }

  if(var_05.size == 0) {
    return level.dyndof.maxfocusdist;
  }

  var_09 = 0;
  var_0A = var_05[var_09];
  for(var_0B = 1; var_0B < var_05.size; var_0B++) {
    if(var_05[var_0B]["fraction"] < var_0A["fraction"]) {
      var_0A = var_05[var_0B];
    }
  }

  return level.dyndof.maxfocusdist * var_0A["fraction"];
}

dyndof_trace_internal(param_00) {
  param_00 = combineangles(dyndof_getplayerangles(), param_00);
  var_01 = dyndof_getplayerorigin();
  var_02 = dyndof_getplayerorigin() + anglesToForward(param_00) * level.dyndof.maxfocusdist;
  return physics_raycast(var_01, var_02, level.dyndof.var_457D, [level.player], 1, "physicsquery_closest", 0);
}

dyndof_getplayerorigin() {
  if(level.player islinked()) {
    var_00 = level.player getlinkedparent();
    if(isDefined(var_00.dyndof_hastag)) {
      if(var_00.dyndof_hastag) {
        return var_00 gettagorigin("tag_camera");
      }
    } else if(isDefined(var_00.model)) {
      if(scripts\sp\utility::hastag(var_00.model, "tag_camera")) {
        var_00.dyndof_hastag = 1;
      } else {
        var_00.dyndof_hastag = 0;
      }
    }
  }

  return level.player getvieworigin();
}

dyndof_getplayerangles() {
  var_00 = level.player getplayerangles();
  return var_00;
}

create_dyndof() {
  var_00 = spawnStruct();
  var_00.maxfocusdist = -15536;
  var_00.focusspeed = 0.3;
  var_00.var_457D = get_dyndof_contents();
  var_00.nearstart = 0;
  var_00.nearend = 500;
  var_00.nearblur = 5;
  var_00.farstart = 2000;
  var_00.farend = 5000;
  var_00.farblur = 5;
  var_00.nearendmindist = 30;
  var_00.nearendmaxdist = 1000;
  var_00.farendmindist = 200;
  var_00.farendmaxdist = var_00.maxfocusdist;
  var_00.prevangles = (0, 0, 0);
  var_00.prevorigin = (0, 0, 0);
  return var_00;
}

destroy_dyndof() {
  level.dyndof = undefined;
}

get_dyndof_contents() {
  var_00 = ["physicscontents_actor", "physicscontents_canshootclip", "physicscontents_clipshot", "physicscontents_corpse", "physicscontents_corpseclipshot", "physicscontents_detail", "physicscontents_foliage", "physicscontents_item", "physicscontents_itemclip", "physicscontents_mantle", "physicscontents_player", "physicscontents_solid", "physicscontents_structural", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_water"];
  return physics_createcontents(var_00);
}