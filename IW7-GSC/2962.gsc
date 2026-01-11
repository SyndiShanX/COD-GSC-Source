/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2962.gsc
***************************************/

func_11166(var_00, var_01) {
  var_02 = var_0.func_11159;
  var_03 = var_1.func_11159;
  self.func_2274[var_03] = var_00;
  self.func_2274[var_02] = var_01;
  self.func_2274[var_02].func_11159 = var_02;
  self.func_2274[var_03].func_11159 = var_03;
}

func_1368E() {
  self endon("death");
  self endon("removed from battleChatter");

  while(self.func_9F6B) {
    wait 0.05;
  }
}

func_13636(var_00) {
  self endon("death");
  var_00 endon("trigger");
  self waittill("trigger");
  var_00 notify("trigger");
}

func_13634(var_00, var_01) {
  var_02 = getEntArray(var_00, var_01);
  var_03 = spawnStruct();
  scripts\engine\utility::array_thread(var_02, ::func_13636, var_03);
  var_03 waittill("trigger");
}

func_65FB(var_00) {
  self endon("done");
  var_00 waittill("trigger");
  self notify("done");
}

func_12DAC() {
  self notify("debug_color_update");
  self endon("debug_color_update");
  var_00 = self.unique_id;
  self waittill("death");
  level.func_4EBE[var_00] = undefined;
  level notify("updated_color_friendlies");
}

func_12DAB(var_00) {
  thread func_12DAC();

  if(isDefined(self.func_EDAD)) {
    level.func_4EBE[var_00] = self.func_EDAD;
  }
  else {
    level.func_4EBE[var_00] = undefined;
  }

  level notify("updated_color_friendlies");
}

func_9938() {}

func_BF01(var_00) {
  self notify("new_color_being_set");
  self.func_BF06 = 1;
  scripts\sp\colors::func_AB3A();
  self endon("new_color_being_set");
  self endon("death");
  waittillframeend;
  waittillframeend;

  if(isDefined(self.func_EDAD)) {
    self.func_4BDF = level.func_4BE0[scripts\sp\colors::func_7CE4()][self.func_EDAD];

    if(isDefined(self.func_5955)) {
      self.func_5955 = undefined;
    }
    else {
      thread scripts\sp\colors::_meth_8467();
    }
  }

  self.func_BF06 = undefined;
  self notify("done_setting_new_color");
}

func_65FA(var_00, var_01) {
  self endon(var_00);
  wait(var_01);
}

func_13764(var_00, var_01, var_02) {
  var_00 endon("done");
  [
    [var_01]
  ](var_02);
  var_00 notify("done");
}

func_9022(var_00, var_01) {
  self endon("hint_print_timeout");
  self endon("hint_print_remove");
  var_01 endon("new_hint");

  for(;;) {
    self.func_6AB8 = 1;

    if(isDefined(level.func_8FE4) && [
        [level.func_8FE4]
      ]() || var_1.func_4B7A != var_00) {
      break;
    }
    wait 0.05;
  }
}

func_9014(var_00) {
  wait(var_00);
  self.func_6AB8 = 1;
  self notify("hint_print_timeout");
}

func_900D(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  return var_00 + func_12DB(var_01, var_02, var_03, var_04, var_05, var_06);
}

func_12DB(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = _getsticksconfig();

  if(level.player scripts\engine\utility::is_player_gamepad_enabled()) {
    if(isDefined(level.func_DADB) && level.func_DADB || isDefined(level.func_DADC) && level.func_DADC) {
      if(issubstr(var_06, "southpaw") || var_05 && issubstr(var_06, "legacy")) {
        return var_04;
      }
      else {
        return var_03;
      }
    } else if(issubstr(var_06, "southpaw") || var_05 && issubstr(var_06, "legacy"))
      return var_02;
    else {
      return var_01;
    }
  } else
    return var_00;
}

func_12DC(var_00, var_01) {
  var_02 = var_01 + var_00;
  var_03 = level.func_1274F[var_02];
  level.func_8FE4 = var_03;
}

func_12DD(var_00, var_01) {
  var_02 = var_01 + var_00;
  var_03 = level.func_12750[var_02];
  var_04 = scripts\sp\utility::func_7B92();
  var_04 _meth_8496(var_03);
}

func_900E(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  level notify("hint_change_config");
  level endon("hint_change_config");
  var_07 = func_12DB(var_01, var_02, var_03, var_04, var_05, var_06);

  while(isDefined(level.func_4B80) && level.func_4B80) {
    var_08 = func_12DB(var_01, var_02, var_03, var_04, var_05, var_06);

    if(var_08 != var_07) {
      var_07 = var_08;
      func_12DC(var_07, var_00);
      func_12DD(var_07, var_00);
    }

    scripts\engine\utility::waitframe();
  }
}

func_9021(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self notify("new_hint");
  var_07 = gettime();

  if(!isDefined(var_06)) {
    var_06 = 0;
  }

  if(!isalive(self)) {
    return;
  }
  scripts\sp\utility::func_65E8("global_hint_in_use");

  if(isDefined(self.func_4B7A)) {
    if(self.func_4B7A == var_00) {
      return;
    }
    else {
      self.func_4B7A = var_00;
      scripts\sp\utility::func_65E1("global_hint_in_use");
      wait 0.05;
    }
  }

  self.func_4B7A = var_00;
  scripts\sp\utility::func_65E1("global_hint_in_use");
  level.func_4B80 = 1;
  level.func_8FE4 = var_01;
  level endon("friendlyfire_mission_fail");
  self _meth_8496(var_00);
  var_08 = spawnStruct();
  var_8.func_6AB8 = 0;

  if(isDefined(var_05)) {
    var_08 thread func_9014(var_05);
  }

  var_08 thread func_52AB();
  var_08 thread func_52AC();
  var_08 thread destroy_hint_on_c6_grab();
  var_08 func_9022(var_00, self);

  if(!scripts\engine\utility::is_true(var_8.func_6AB8)) {
    self _meth_8497(1);
  }

  scripts\sp\utility::func_135AF(var_07, var_06);
  var_08 notify("removing_hint");
  self.func_4B7A = undefined;

  if(var_8.func_6AB8) {
    self _meth_8497();
  }

  level.func_4B80 = 0;
  scripts\sp\utility::func_65DD("global_hint_in_use");
}

func_52AB(var_00) {
  self endon("removing_hint");
  level waittill("friendlyfire_mission_fail");
  self.func_6AB8 = 1;
  self notify("hint_print_remove");
}

destroy_hint_on_c6_grab(var_00) {
  self endon("removing_hint");

  for(;;) {
    if(!isDefined(level.player.melee)) {
      wait 0.05;
    }
    else if(!isDefined(level.player.melee.func_B5FE)) {
      wait 0.05;
    }
    else {
      break;
    }

    wait 0.05;
  }

  self.func_6AB8 = 1;
  self notify("hint_print_remove");
}

func_52AC(var_00) {
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
  self.func_6AB8 = 1;
  self notify("hint_print_remove");
}

func_74DE(var_00) {
  self endon("death");
  var_00 scripts\engine\utility::waittill_either("function_done", "death");
}

func_74DF(var_00) {
  func_74DE(var_00);

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

func_74DB(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self endon("death");

  if(!isDefined(var_0.func_74D7)) {
    var_0.func_74D7 = [];
  }

  var_0.func_74D7[var_0.func_74D7.size] = self;
  thread func_74DC(var_00);
  func_74D8(var_00);

  if(isDefined(var_00) && isDefined(var_0.func_74D7)) {
    self.func_74DA = 1;
    self notify("function_stack_func_begun");

    if(isDefined(var_06)) {
      var_00[[var_01]](var_02, var_03, var_04, var_05, var_06);
    }
    else if(isDefined(var_05)) {
      var_00[[var_01]](var_02, var_03, var_04, var_05);
    }
    else if(isDefined(var_04)) {
      var_00[[var_01]](var_02, var_03, var_04);
    }
    else if(isDefined(var_03)) {
      var_00[[var_01]](var_02, var_03);
    }
    else if(isDefined(var_02)) {
      var_00[[var_01]](var_02);
    }
    else {
      var_00[[var_01]]();
    }

    if(isDefined(var_00) && isDefined(var_0.func_74D7)) {
      var_0.func_74D7 = scripts\engine\utility::array_remove(var_0.func_74D7, self);
      var_00 notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self.func_74DA = 0;
    self notify("function_done");
  }
}

func_74DC(var_00) {
  self endon("function_done");
  self waittill("death");

  if(isDefined(var_00)) {
    var_0.func_74D7 = scripts\engine\utility::array_remove(var_0.func_74D7, self);
    var_00 notify("level_function_stack_ready");
  }
}

func_74D8(var_00) {
  var_00 endon("death");
  self endon("death");
  var_00 endon("clear_function_stack");

  while(var_0.func_74D7[0] != self) {
    var_00 waittill("level_function_stack_ready");
  }
}

func_1362A(var_00, var_01) {
  if(isDefined(var_01)) {
    var_01 endon("death");
  }

  self endon("death");
  var_00 waittill("sounddone");
  return 1;
}

func_22D9(var_00, var_01, var_02) {
  func_22DA(var_00, var_01, var_02);
  self.func_1187 = 0;
  self notify("_array_wait");
}

func_22DA(var_00, var_01, var_02) {
  var_00 endon(var_01);
  var_00 endon("death");

  if(isDefined(var_02)) {
    wait(var_02);
  }
  else {
    var_00 waittill(var_01);
  }
}

func_68CC(var_00) {
  if(var_0.func_C8FD.size == 0) {
    var_0.func_376B call[[var_0.func]]();
  }
  else if(var_0.func_C8FD.size == 1) {
    var_0.func_376B call[[var_0.func]](var_0.func_C8FD[0]);
  }
  else if(var_0.func_C8FD.size == 2) {
    var_0.func_376B call[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1]);
  }
  else if(var_0.func_C8FD.size == 3) {
    var_0.func_376B call[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1], var_0.func_C8FD[2]);
  }

  if(var_0.func_C8FD.size == 4) {
    var_0.func_376B call[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1], var_0.func_C8FD[2], var_0.func_C8FD[3]);
  }

  if(var_0.func_C8FD.size == 5) {
    var_0.func_376B call[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1], var_0.func_C8FD[2], var_0.func_C8FD[3], var_0.func_C8FD[4]);
  }
}

func_68CD(var_00) {
  if(var_0.func_C8FD.size == 0) {
    call[[var_0.func]]();
  }
  else if(var_0.func_C8FD.size == 1) {
    call[[var_0.func]](var_0.func_C8FD[0]);
  }
  else if(var_0.func_C8FD.size == 2) {
    call[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1]);
  }
  else if(var_0.func_C8FD.size == 3) {
    call[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1], var_0.func_C8FD[2]);
  }

  if(var_0.func_C8FD.size == 4) {
    call[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1], var_0.func_C8FD[2], var_0.func_C8FD[3]);
  }

  if(var_0.func_C8FD.size == 5) {
    call[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1], var_0.func_C8FD[2], var_0.func_C8FD[3], var_0.func_C8FD[4]);
  }
}

func_68CE(var_00, var_01) {
  if(!isDefined(var_0.func_376B)) {
    return;
  }
  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_1[var_02].func_376B endon(var_1[var_02].func_6317);
  }

  if(var_0.func_C8FD.size == 0) {
    var_0.func_376B[[var_0.func]]();
  }
  else if(var_0.func_C8FD.size == 1) {
    var_0.func_376B[[var_0.func]](var_0.func_C8FD[0]);
  }
  else if(var_0.func_C8FD.size == 2) {
    var_0.func_376B[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1]);
  }
  else if(var_0.func_C8FD.size == 3) {
    var_0.func_376B[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1], var_0.func_C8FD[2]);
  }

  if(var_0.func_C8FD.size == 4) {
    var_0.func_376B[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1], var_0.func_C8FD[2], var_0.func_C8FD[3]);
  }

  if(var_0.func_C8FD.size == 5) {
    var_0.func_376B[[var_0.func]](var_0.func_C8FD[0], var_0.func_C8FD[1], var_0.func_C8FD[2], var_0.func_C8FD[3], var_0.func_C8FD[4]);
  }
}

func_13774(var_00, var_01) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  func_68CE(var_00, var_01);
  self.count--;
  self notify("func_ended");
}

func_13720(var_00, var_01) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  func_68CE(var_00, var_01);
  self.func_1521--;
  self notify("abort_func_ended");
}

func_5767(var_00) {
  self endon("all_funcs_ended");

  if(!var_0.size) {
    return;
  }
  var_01 = 0;
  self.func_1521 = var_0.size;
  var_02 = [];
  scripts\engine\utility::array_levelthread(var_00, ::func_13720, var_02);

  for(;;) {
    if(self.func_1521 <= var_01) {
      break;
    }
    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

func_12688(var_00) {
  if(isDefined(self.forward)) {
    var_01 = anglesToForward(var_0.angles);
    var_0.origin = var_0.origin + var_01 * self.forward;
  }

  if(isDefined(self.right)) {
    var_02 = anglestoright(var_0.angles);
    var_0.origin = var_0.origin + var_02 * self.right;
  }

  if(isDefined(self.up)) {
    var_03 = anglestoup(var_0.angles);
    var_0.origin = var_0.origin + var_03 * self.up;
  }

  if(isDefined(self.yaw)) {
    var_00 addyaw(self.yaw);
  }

  if(isDefined(self.func_CBE9)) {
    var_00 addpitch(self.func_CBE9);
  }

  if(isDefined(self.func_E67D)) {
    var_00 addroll(self.func_E67D);
  }
}

func_5F8E(var_00, var_01, var_02, var_03, var_04) {
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

  self.func_E81D = "";
  self.func_C3CB = self.moveplaybackrate;
  thread func_10FE6();
  var_05 = var_00 * var_00;
  var_06 = var_01 * var_01;
  var_07 = var_02 * var_02;
  var_08 = var_03 * var_03;

  for(;;) {
    wait 0.05;
    var_09 = level.players[0];

    foreach(var_11 in level.players) {
      if(distancesquared(var_9.origin, self.origin) > distancesquared(var_11.origin, self.origin)) {
        var_09 = var_11;
      }
    }

    var_13 = anglesToForward(self.angles);
    var_14 = vectornormalize(var_9.origin - self.origin);
    var_15 = vectordot(var_13, var_14);
    var_16 = distancesquared(self.origin, var_9.origin);
    var_17 = var_16;

    if(isDefined(var_04)) {
      var_18 = scripts\engine\utility::getclosest(var_9.origin, var_04);
      var_17 = distancesquared(var_18.origin, var_9.origin);
    }

    var_19 = 0;

    if(isDefined(self.func_A905)) {
      var_19 = [
    }
        [level.func_5EFB]
      ](self.func_A905, var_01);
    else if(isDefined(self.func_A906)) {
      var_19 = [
    }
        [level.func_5EFB]
      ](self.func_A906, var_01);

    if(scripts\anim\utility::func_9D9B() && !self.func_5953) {
      self.moveplaybackrate = 1;
    }

    if(var_16 < var_06 || var_15 > -0.25 || var_19) {
      func_5F8C("sprint");
      wait 0.5;
      continue;
    } else if(var_16 < var_05 || var_15 > -0.25) {
      func_5F8C("run");
      wait 0.5;
      continue;
    } else if(var_17 > var_07) {
      if(self.a.movement != "stop") {
        func_5F8C("stop");
        wait 0.5;
      }

      continue;
    } else if(var_16 > var_08) {
      func_5F8C("jog");
      wait 0.5;
      continue;
    }
  }
}

func_10FE6() {
  self endon("start_dynamic_run_speed");
  self endon("death");
  func_10FE7();

  if(!self.func_5953) {
    self.moveplaybackrate = self.func_C3CB;
  }

  if(isDefined(level.func_EC85["generic"]["DRS_run"])) {
    if(isarray(level.func_EC85["generic"]["DRS_run"])) {
      scripts\sp\utility::func_F3CC("DRS_run");
    }
    else {
      scripts\sp\utility::func_F3CB("DRS_run");
    }
  } else
    scripts\sp\utility::func_417A();

  self notify("stop_loop");
  scripts\sp\utility::func_65DD("dynamic_run_speed_stopping");
  scripts\sp\utility::func_65DD("dynamic_run_speed_stopped");
}

func_10FE7() {
  level endon("_stealth_spotted");
  self waittill("stop_dynamic_run_speed");
}

func_5F8C(var_00) {
  if(self.func_E81D == var_00) {
    return;
  }
  self.func_E81D = var_00;

  switch (var_00) {
    case "sprint":
      if(scripts\anim\utility::func_9D9B() && !self.func_5953) {
        self.moveplaybackrate = 1;
      }
      else if(!self.func_5953) {
        self.moveplaybackrate = 1.15;
      }

      if(isarray(level.func_EC85["generic"]["DRS_sprint"])) {
        scripts\sp\utility::func_F3CC("DRS_sprint");
      }
      else {
        scripts\sp\utility::func_F3CB("DRS_sprint");
      }

      self notify("stop_loop");
      scripts\sp\utility::anim_stopanimscripted();
      scripts\sp\utility::func_65DD("dynamic_run_speed_stopped");
      break;
    case "run":
      if(!self.func_5953) {
        self.moveplaybackrate = self.func_C3CB;
      }

      if(isDefined(level.func_EC85["generic"]["DRS_run"])) {
        if(isarray(level.func_EC85["generic"]["DRS_run"])) {
          scripts\sp\utility::func_F3CC("DRS_run");
        }
        else {
          scripts\sp\utility::func_F3CB("DRS_run");
        }
      } else
        scripts\sp\utility::func_417A();

      self notify("stop_loop");
      scripts\sp\utility::anim_stopanimscripted();
      scripts\sp\utility::func_65DD("dynamic_run_speed_stopped");
      break;
    case "stop":
      thread func_5F8F();
      break;
    case "jog":
      if(!self.func_5953) {
        self.moveplaybackrate = self.func_C3CB;
      }

      if(isDefined(level.func_EC85["generic"]["DRS_combat_jog"])) {
        if(isarray(level.func_EC85["generic"]["DRS_combat_jog"])) {
          scripts\sp\utility::func_F3CC("DRS_combat_jog");
        }
        else {
          scripts\sp\utility::func_F3CB("DRS_combat_jog");
        }
      } else
        scripts\sp\utility::func_417A();

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

    if(isDefined(level.func_EC85["generic"]["signal_go"])) {
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
    if(isDefined(level.func_5F8D)) {
      var_02 = scripts\engine\utility::random(level.func_5F8D);
      level thread scripts\sp\utility::func_DBF3(var_02);
    }

    if(isDefined(level.func_EC85["generic"]["signal_go"])) {
      func_8A0B("go");
    }
  }
}

func_8A0B(var_00, var_01, var_02, var_03) {
  var_04 = 1;

  if(isDefined(var_01)) {
    var_04 = !var_01;
  }

  if(isDefined(var_02)) {
    level endon(var_02);
  }

  if(isDefined(var_03)) {
    level waittill(var_03);
  }

  var_05 = "signal_" + var_00;

  if(self.a.pose == "crouch") {
    var_05 = var_05 + "_crouch";
  }
  else if(self.script == "cover_right") {
    var_05 = var_05 + "_coverR";
  }
  else if(scripts\anim\utility::func_9D9B()) {
    var_05 = var_05 + "_cqb";
  }

  if(var_04) {
    self give_capture_credit(scripts\sp\utility::func_7ECF(var_05), 1, 0, 1.1);
  }
  else {
    scripts\sp\anim::func_1EC7(self, var_05);
  }
}

func_764E() {
  return int(getdvar("g_speed"));
}

func_764F(var_00) {
  _setsaveddvar("g_speed", int(var_00));
}

func_7647() {
  return level.player _meth_810B();
}

func_7648(var_00) {
  level.player give_crafted_fireworks_trap(var_00);
}

func_BCF0() {
  return self.func_BCF5;
}

func_BCF3(var_00) {
  self.func_BCF5 = var_00;
  self setmovespeedscale(var_00);
}

func_2680() {
  if(scripts\engine\utility::flag_exist("autosave_tactical_player_nade")) {
    return;
  }
  scripts\engine\utility::flag_init("autosave_tactical_player_nade");
  level.func_267E = 0;
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
    scripts\engine\utility::waittill_any_timeout(10, "autosave_grenade_thrown");
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

  if(!level.func_267E) {
    scripts\engine\utility::flag_clear("autosave_tactical_player_nade");
  }
}

func_267B(var_00) {
  level.func_267E++;
  var_00 scripts\engine\utility::waittill_notify_or_timeout("death", 10);
  level.func_267E--;
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

  var_00 = _getaiarray("axis");

  foreach(var_02 in var_00) {
    if(isDefined(var_2.enemy) && isplayer(var_2.enemy)) {
      return;
    }
  }

  waittillframeend;
  scripts\sp\utility::func_2669();
}

func_BDE6(var_00, var_01, var_02, var_03) {
  scripts\sp\utility::func_BDEC(var_01);
  level endon("stop_music");
  wait(var_01);
  thread scripts\sp\utility::func_BDE5(var_00, undefined, var_02, var_03);
}

func_BDE2(var_00, var_01, var_02, var_03, var_04, var_05) {
  scripts\sp\utility::func_BDEC(var_02);
  level endon("stop_music");
  wait(var_02);
  thread func_BDE1(var_00, var_01, undefined, var_03, var_04, var_05);
}

func_BDE1(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isDefined(var_02) && var_02 > 0) {
    thread func_BDE2(var_00, var_01, var_02, var_03, var_04, var_05);
    return;
  }

  scripts\sp\utility::func_BDEC();
  level endon("stop_music");
  scripts\sp\utility::func_BDF2(var_00, var_03, var_04);

  if(isDefined(var_05) && var_05 == 1 && scripts\engine\utility::flag_exist("_stealth_spotted")) {
    level endon("_stealth_spotted");
    thread func_BDE4(var_00, var_01, var_02);
  }

  var_06 = scripts\sp\utility::func_BDF1(var_00);

  if(!isDefined(var_01)) {
    var_01 = 1;
  }

  if(var_01 <= 10) {
    var_06 = var_06 + var_01;
  }

  wait(var_06);
  scripts\sp\utility::func_BDDF(var_00, var_01, var_02, var_03, var_04);
}

func_BDE4(var_00, var_01, var_02) {
  level endon("stop_music");
  scripts\engine\utility::flag_wait("_stealth_spotted");
  _musicstop(0.5);

  while(scripts\engine\utility::flag("_stealth_spotted")) {
    scripts\engine\utility::flag_waitopen("_stealth_spotted");
    wait 1;
  }

  thread scripts\sp\utility::func_BDDF(var_00, var_01, var_02);
}

func_5AAD(var_00, var_01, var_02) {
  self endon("death");
  self endon("stop_sliding");
  var_03 = self;
  var_04 = undefined;
  var_05 = var_0.origin;
  var_06 = var_0.origin;
  var_07 = undefined;

  for(;;) {
    var_08 = var_03 getnormalizedmovement();
    var_09 = anglesToForward(var_3.angles);
    var_10 = anglestoright(var_3.angles);
    var_08 = (var_8[1] * var_10[0] + var_8[0] * var_9[0], var_8[1] * var_10[1] + var_8[0] * var_9[1], 0);
    var_0.slidevelocity = var_0.slidevelocity + var_08 * var_01;
    var_3.func_7601.origin = var_0.origin + anglesToForward(var_0.func_77BA.angles) * 400;
    wait 0.05;
    var_0.slidevelocity = var_0.slidevelocity * (1 - var_02);
  }
}

func_A5CF(var_00) {
  self endon("death");

  if(isDefined(var_00)) {
    wait(randomfloat(var_00));
  }

  playFXOnTag(scripts\engine\utility::getfx("flesh_hit"), self, "tag_eye");
  self _meth_81D0(level.player.origin);
}

func_12E1F(var_00, var_01) {
  self endon("death");
  var_02 = 0;

  for(;;) {
    if(self.func_99E5 > 0.0001 && gettime() > 300) {
      if(!var_02) {
        self _meth_8244(var_01);
        var_02 = 1;
      }
    } else if(var_02) {
      self stoprumble(var_01);
      var_02 = 0;
    }

    var_03 = 1 - self.func_99E5;
    var_03 = var_03 * 1000;
    self.origin = var_00 getEye() + (0, 0, var_03);
    wait 0.05;
  }
}

func_D961(var_00, var_01, var_02, var_03, var_04) {
  waittillframeend;

  if(!isDefined(self.start)) {
    self.start = 0;
  }

  if(!isDefined(self.end)) {
    self.end = 1;
  }

  if(!isDefined(self.func_2857)) {
    self.func_2857 = 0;
  }

  var_05 = self.time * 20;
  var_06 = self.end - self.start;
  self.func_10FCB = 0;

  if(isDefined(var_04)) {
    for(var_07 = 0; var_07 <= var_05 && !self.func_10FCB; var_7++) {
      var_08 = self.func_2857 + var_07 * var_06 / var_05;
      var_01 thread[[var_00]](var_08, var_02, var_03, var_04);
      wait 0.05;
    }
  } else if(isDefined(var_03)) {
    for(var_07 = 0; var_07 <= var_05 && !self.func_10FCB; var_7++) {
      var_08 = self.func_2857 + var_07 * var_06 / var_05;
      var_01 thread[[var_00]](var_08, var_02, var_03);
      wait 0.05;
    }
  } else if(isDefined(var_02)) {
    for(var_07 = 0; var_07 <= var_05 && !self.func_10FCB; var_7++) {
      var_08 = self.func_2857 + var_07 * var_06 / var_05;
      var_01 thread[[var_00]](var_08, var_02);
      wait 0.05;
    }
  } else {
    for(var_07 = 0; var_07 <= var_05 && !self.func_10FCB; var_7++) {
      var_08 = self.func_2857 + var_07 * var_06 / var_05;
      var_01 thread[[var_00]](var_08);
      wait 0.05;
    }
  }
}

func_78D1() {
  var_00 = "allies";

  if(isDefined(self.func_ED34)) {
    var_00 = "axis";
  }

  var_00 = scripts\sp\colors::func_7CE4(var_00);
  var_01 = [];

  if(var_00 == "allies") {
    var_02 = scripts\sp\colors::func_78D9(self.func_ED33, "allies");
    var_01 = var_2["colorCodes"];
  } else {
    var_02 = scripts\sp\colors::func_78D9(self.func_ED34, "axis");
    var_01 = var_2["colorCodes"];
  }

  var_03 = [];
  var_3["team"] = var_00;
  var_3["codes"] = var_01;
  return var_03;
}

func_50E5(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self endon("death");
  self endon("stop_delay_thread");
  wait(var_01);

  if(isDefined(var_07)) {
    childthread[[var_00]](var_02, var_03, var_04, var_05, var_06, var_07);
  }
  else if(isDefined(var_06)) {
    childthread[[var_00]](var_02, var_03, var_04, var_05, var_06);
  }
  else if(isDefined(var_05)) {
    childthread[[var_00]](var_02, var_03, var_04, var_05);
  }
  else if(isDefined(var_04)) {
    childthread[[var_00]](var_02, var_03, var_04);
  }
  else if(isDefined(var_03)) {
    childthread[[var_00]](var_02, var_03);
  }
  else if(isDefined(var_02)) {
    childthread[[var_00]](var_02);
  }
  else {
    childthread[[var_00]]();
  }
}

func_6E7D(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self endon("death");
  scripts\engine\utility::flag_wait(var_1[0]);
  scripts\engine\utility::delaythread_proc(var_00, var_1[1], var_02, var_03, var_04, var_05, var_06);
}

func_13844(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self endon("death");
  self waittill(var_1[0]);
  scripts\engine\utility::delaythread_proc(var_00, var_1[1], var_02, var_03, var_04, var_05, var_06);
}

func_178E() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");

  for(var_00 = 0; var_00 < 20; var_0++) {
    waittillframeend;
  }
}

func_12D95() {}

func_4461(var_00, var_01, var_02, var_03) {
  if(!var_1.size) {
    return undefined;
  }

  if(isDefined(var_02)) {
    var_04 = undefined;
    var_05 = getarraykeys(var_01);

    for(var_06 = 0; var_06 < var_5.size; var_6++) {
      var_07 = distance(var_1[var_5[var_06]].v["origin"], var_00);

      if([
          [var_03]
        ](var_07, var_02)) {
        continue;
      }
      var_02 = var_07;
      var_04 = var_1[var_5[var_06]];
    }

    return var_04;
  }

  var_05 = getarraykeys(var_01);
  var_04 = var_1[var_5[0]];
  var_02 = distance(var_4.v["origin"], var_00);

  for(var_06 = 1; var_06 < var_5.size; var_6++) {
    var_07 = distance(var_1[var_5[var_06]].v["origin"], var_00);

    if([
        [var_03]
      ](var_07, var_02)) {
      continue;
    }
    var_02 = var_07;
    var_04 = var_1[var_5[var_06]];
  }

  return var_04;
}

func_13816() {
  for(;;) {
    self waittill("trigger", var_00);
    waittillframeend;

    if(var_0.func_4BF7 == self) {
      return var_00;
    }
  }
}

func_1789() {
  self.func_1274A = [];
  self waittill("trigger", var_00);
  var_01 = self.func_1274A;
  self.func_1274A = undefined;

  foreach(var_03 in var_01) {
  thread[[var_03]](var_00);
  }
}

func_1778(var_00) {
  if(!isDefined(level.func_EC91[var_00])) {
    level.func_EC91[var_00] = var_00;
  }
}

func_1773(var_00) {
  if(!isDefined(level.func_EC8E[var_00])) {
    level.func_EC8E[var_00] = var_00;
  }
}

func_175F(var_00) {
  if(!isDefined(level.func_EC85[self.func_1FBB])) {
    level.func_EC85[self.func_1FBB] = [];
  }

  if(!isDefined(level.scr_sound[self.func_1FBB])) {
    level.scr_sound[self.func_1FBB] = [];
  }

  if(!isDefined(level.scr_sound[self.func_1FBB][var_00])) {
    level.scr_sound[self.func_1FBB][var_00] = var_00;
  }
}

func_1760(var_00) {
  if(!isDefined(level.scr_sound["generic"])) {
    level.scr_sound["generic"] = [];
  }

  if(!isDefined(level.scr_sound["generic"][var_00])) {
    level.scr_sound["generic"][var_00] = var_00;
  }
}

func_1287(var_00, var_01) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_02);
    scripts\engine\utility::flag_set(var_00);

    if(!var_01) {
      return;
    }
    while(var_02 istouching(self)) {
      wait 0.05;
    }

    scripts\engine\utility::flag_clear(var_00);
  }
}

func_7615(var_00, var_01) {
  var_0.func_75BA = 1;

  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  if(var_01) {
    func_22D4(var_0.fx, scripts\engine\utility::pauseeffect);
  }
  else {
    scripts\engine\utility::array_thread(var_0.fx, scripts\engine\utility::pauseeffect);
  }
}

func_22D4(var_00, var_01, var_02) {
  var_03 = 0;

  if(!isDefined(var_02)) {
    var_02 = 5;
  }

  var_04 = [];

  foreach(var_06 in var_00) {
    var_4[var_4.size] = var_06;
    var_3++;
    var_03 = var_03 % var_02;

    if(var_02 == 0) {
      scripts\engine\utility::array_thread(var_04, var_01);
      wait 0.05;
      var_04 = [];
    }
  }
}

func_28D9(var_00) {
  level endon("battlechatter_off_thread");
  scripts\anim\battlechatter::func_29C1();

  while(!isDefined(anim.func_3D4B)) {
    wait 0.05;
  }

  anim.func_29B7 = 1;
  wait 1.5;

  if(isDefined(var_00)) {
    scripts\sp\utility::func_F2DC(var_00, 1);
    var_01 = _getaiarray(var_00);
  } else {
    foreach(var_00 in anim.func_115E7) {
    scripts\sp\utility::func_F2DC(var_00, 1);
    }

    var_01 = _getaiarray();
  }

  if(isDefined(level.func_A056) && isDefined(level.func_A056.func_1630)) {
    var_01 = scripts\engine\utility::array_combine(var_01, level.func_A056.func_1630);
  }

  for(var_04 = 0; var_04 < var_1.size; var_4++) {
    var_1[var_04] scripts\sp\utility::func_F2DA(1);
  }
}

func_517B(var_00, var_01) {
  var_00 endon("death");
  self waittill("death");

  if(isDefined(var_00)) {
    if(var_00 gettimepassed()) {
      var_00 waittill(var_01);
    }

    var_00 delete();
  }
}

func_F3A7(var_00, var_01) {
  thread scripts\sp\utility::func_F3A5(var_00, var_01, scripts\sp\utility::empty_func, "set_flag_on_spawned");
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

func_13757(var_00) {
  self waittill("death");
  var_0.count--;
  var_00 notify("waittill_dead guy died");
}

func_13756(var_00) {
  scripts\engine\utility::waittill_either("death", "pain_death");
  var_0.count--;
  var_00 notify("waittill_dead_guy_dead_or_dying");
}

func_13758(var_00) {
  wait(var_00);
  self notify("thread_timed_out");
}

dyndof_thread() {
  level endon("stop_dynDOF");

  for(;;) {
    var_00 = dyndof_distance();

    if(var_00 > -1) {
      dyndof_set(var_00);
    }

    wait 0.05;
  }
}

dyndof_set(var_00) {
  var_01 = 800;
  var_02 = var_00 / var_01;
  var_03 = level.dyndof.nearstart * var_02;
  var_04 = level.dyndof.nearend * var_02;
  var_05 = level.dyndof.farstart * var_02;
  var_06 = level.dyndof.farend * var_02;
  var_04 = var_03 + (level.dyndof.nearend - level.dyndof.nearstart) * var_02;
  var_04 = clamp(var_04, level.dyndof.nearendmindist, level.dyndof.nearendmaxdist);
  var_06 = var_05 + (level.dyndof.farend - level.dyndof.farstart) * var_02;
  func_0B0A::func_583F(var_03, var_04, level.dyndof.nearblur, var_05, var_06, level.dyndof.farblur, level.dyndof.focusspeed);
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
  var_2[var_2.size] = (var_04 * -1, 0, 0);
  var_2[var_2.size] = (0, var_04, 0);
  var_2[var_2.size] = (0, var_04 * -1, 0);
  var_2[var_2.size] = (0, 0, 0);
  var_05 = [];

  foreach(var_09, var_07 in var_02) {
    var_08 = dyndof_trace_internal(var_07);

    if(!isDefined(var_08)) {
      continue;
    }
    var_5[var_5.size] = var_8[0];
  }

  if(var_5.size == 0) {
    return level.dyndof.maxfocusdist;
  }

  var_09 = 0;
  var_10 = var_5[var_09];

  for(var_11 = 1; var_11 < var_5.size; var_11++) {
    if(var_5[var_11]["fraction"] < var_10["fraction"]) {
      var_10 = var_5[var_11];
    }
  }

  return level.dyndof.maxfocusdist * var_10["fraction"];
}

dyndof_trace_internal(var_00) {
  var_00 = _combineangles(dyndof_getplayerangles(), var_00);
  var_01 = dyndof_getplayerorigin();
  var_02 = dyndof_getplayerorigin() + anglesToForward(var_00) * level.dyndof.maxfocusdist;
  return physics_raycast(var_01, var_02, level.dyndof.func_457D, [level.player], 1, "physicsquery_closest", 0);
}

dyndof_getplayerorigin() {
  if(level.player getteamflagcount()) {
    var_00 = level.player getlinkedparent();

    if(isDefined(var_0.dyndof_hastag)) {
      if(var_0.dyndof_hastag) {
        return var_00 gettagorigin("tag_camera");
      }
    } else if(isDefined(var_0.model)) {
      if(scripts\sp\utility::hastag(var_0.model, "tag_camera")) {
        var_0.dyndof_hastag = 1;
      }
      else {
        var_0.dyndof_hastag = 0;
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
  var_0.maxfocusdist = 50000;
  var_0.focusspeed = 0.3;
  var_0.func_457D = get_dyndof_contents();
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
  return var_00;
}

destroy_dyndof() {
  level.dyndof = undefined;
}

get_dyndof_contents() {
  var_00 = ["physicscontents_actor", "physicscontents_canshootclip", "physicscontents_clipshot", "physicscontents_corpse", "physicscontents_corpseclipshot", "physicscontents_detail", "physicscontents_foliage", "physicscontents_item", "physicscontents_itemclip", "physicscontents_mantle", "physicscontents_player", "physicscontents_solid", "physicscontents_structural", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_water"];
  return physics_createcontents(var_00);
}