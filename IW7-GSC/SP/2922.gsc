/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2922.gsc
************************/

func_EBE9() {
  scripts\engine\utility::flag_init("setup_sceneblock_anims");
  level.var_EBFF = spawnStruct();
  level.var_EBFF.var_47 = [];
  level.var_EBFF.var_47["shipcrib_stand_stationary_talk_idle_01"] = % shipcrib_stand_stationary_talk_idle_01;
  level.var_EBFF.var_47["shipcrib_stand_idle01_arrival"] = % shipcrib_stand_idle01_arrival;
  level.var_EBFF.var_47["shipcrib_stand_idle01_exit"] = % shipcrib_stand_idle01_exit;
  level.var_EBFF.var_47["shipcrib_stand_stationary_talk_idle_02"] = % shipcrib_stand_stationary_talk_idle_02;
  level.var_EBFF.var_47["shipcrib_stand_idle02_arrival"] = % shipcrib_stand_idle02_arrival;
  level.var_EBFF.var_47["shipcrib_stand_idle02_exit"] = % shipcrib_stand_idle02_exit;
  level.var_EBFF.var_47["shipcrib_stand_stationary_talk_idle_03"] = % shipcrib_stand_stationary_talk_idle_03;
  level.var_EBFF.var_47["shipcrib_stand_idle03_arrival"] = % shipcrib_stand_idle03_arrival;
  level.var_EBFF.var_47["shipcrib_stand_idle03_exit"] = % shipcrib_stand_idle03_exit;
  level.var_EBFF.var_47["shipcrib_stand_stationary_talk_idle_04"] = % shipcrib_stand_stationary_talk_idle_04;
  level.var_EBFF.var_47["shipcrib_stand_idle04_arrival"] = % shipcrib_stand_idle04_arrival;
  level.var_EBFF.var_47["shipcrib_stand_idle04_exit"] = % shipcrib_stand_idle04_exit;
  level.var_EBFF.var_47["shipcrib_stand_stationary_talk_idle_05"] = % shipcrib_stand_stationary_talk_idle_05;
  level.var_EBFF.var_47["shipcrib_stand_idle05_arrival"] = % shipcrib_stand_idle05_arrival;
  level.var_EBFF.var_47["shipcrib_stand_idle05_exit"] = % shipcrib_stand_idle05_exit;
  level.var_EBFF.var_47["shipcrib_bridge_stand_console_transition_in"] = % shipcrib_bridge_stand_console_transition_in;
  level.var_EBFF.var_47["shipcrib_bridge_stand_console_transition_out"] = % shipcrib_bridge_stand_console_transition_out;
  level.var_EBFF.var_EA31 = [];
  level.var_EBFF.var_EA31["shipcrib_stand_stationary_talk_idle_01_XO"] = % shipcrib_stand_stationary_talk_idle_01_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle01_arrival_XO"] = % shipcrib_stand_idle01_arrival_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle01_exit_XO"] = % shipcrib_stand_idle01_exit_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_stationary_talk_idle_02_XO"] = % shipcrib_stand_stationary_talk_idle_02_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle02_arrival_XO"] = % shipcrib_stand_idle02_arrival_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle02_exit_XO"] = % shipcrib_stand_idle02_exit_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_stationary_talk_idle_03_XO"] = % shipcrib_stand_stationary_talk_idle_03_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle03_arrival_XO"] = % shipcrib_stand_idle03_arrival_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle03_exit_XO"] = % shipcrib_stand_idle03_exit_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_stationary_talk_idle_04_XO"] = % shipcrib_stand_stationary_talk_idle_04_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle04_arrival_XO"] = % shipcrib_stand_idle04_arrival_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle04_exit_XO"] = % shipcrib_stand_idle04_exit_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_stationary_talk_idle_05_XO"] = % shipcrib_stand_stationary_talk_idle_05_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle05_arrival_XO"] = % shipcrib_stand_idle05_arrival_xo;
  level.var_EBFF.var_EA31["shipcrib_stand_idle05_exit_XO"] = % shipcrib_stand_idle05_exit_xo;
  level.var_EBFF.var_47["shipcrib_bridge_stand_console_transition_in_XO"] = % shipcrib_bridge_stand_console_transition_in;
  level.var_EBFF.var_47["shipcrib_bridge_stand_console_transition_out_XO"] = % shipcrib_bridge_stand_console_transition_out;
  scripts\engine\utility::flag_set("setup_sceneblock_anims");
}

func_EC01(param_00, param_01, param_02) {
  self endon("death");
  self notify("starting_new_sceneblock");
  self endon("starting_new_sceneblock");
  self notify("stop_loop");
  scripts\sp\interaction::func_9A0F();
  self givescorefortrophyblocks();
  lib_0A1E::func_2385();
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(param_02) {
    func_EC08("point", param_00);
  }

  scripts\sp\anim::func_1EC7(self, param_01);
  self give_mp_super_weapon(self.origin);
}

func_EC0D(param_00, param_01) {
  self endon("death");
  self notify("stop_loop");
  scripts\sp\interaction::func_9A0F();
  self givescorefortrophyblocks();
  lib_0A1E::func_2385();
  scripts\sp\anim::func_1F12(self);
  var_02 = lib_0EFB::func_7D7A(param_00);
  self _meth_80F1(var_02.origin, var_02.angles);
  self give_mp_super_weapon(self.origin);
  if(isDefined(param_01) && param_01) {
    if(param_01 && scripts\sp\interaction::func_9C26(var_02)) {
      if(isDefined(var_02.var_EE92)) {
        if(issubstr(var_02.var_EE92, "opsmap")) {
          if(self.var_1FBB == "salter" || self.var_1FBB == "gator" || self.var_1FBB == "drop_officer") {
            thread lib_0EFB::func_CD3F(var_02.var_EE92);
          } else {
            thread scripts\sp\interaction::func_CD50(var_02.var_EE92);
          }
        } else {
          thread scripts\sp\interaction::func_CD4B(var_02.var_EE92);
        }
      } else {
        thread scripts\sp\interaction::func_CD4B(var_02.script_noteworthy);
      }
    }
  }

  scripts\engine\utility::waitframe();
}

func_EC02(param_00, param_01) {
  level.player endon("death");
  var_02 = lib_0EFB::func_7D7A(param_00);
  if(!isstring(param_00)) {
    param_00 = "empty";
  }

  level.var_EC02[param_00] = var_02;
  var_02 endon("death");
  var_02 lib_0E46::func_48C4(undefined, undefined, undefined, 90, 3000, 1);
  var_03 = squared(500);
  for(;;) {
    while(distance2dsquared(var_02.origin, level.player.origin) > var_03) {
      scripts\engine\utility::waitframe();
    }

    var_02 lib_0E46::func_DFE3();
    if(isDefined(param_01) && param_01) {
      break;
    }

    while(distance2dsquared(var_02.origin, level.player.origin) < var_03) {
      scripts\engine\utility::waitframe();
    }

    var_02 lib_0E46::func_48C4(undefined, undefined, undefined, 60, 3000, 0);
  }
}

func_EC03(param_00) {
  if(isDefined(level.var_EC02) && isDefined(level.var_EC02[param_00]) && isDefined(level.var_EC02[param_00].var_4C1F)) {
    level.var_EC02[param_00] lib_0E46::func_DFE3();
  }
}

func_EC08(param_00, param_01, param_02) {
  self endon("death");
  self endon("stop_sceneblock_orient");
  self notify("starting_new_sceneblock_orient");
  self endon("starting_new_sceneblock_orient");
  self notify("stop_loop");
  scripts\sp\interaction::func_9A0F();
  self givescorefortrophyblocks();
  lib_0A1E::func_2385();
  var_03 = lib_0EFB::func_7D7A(param_01);
  if(!isDefined(param_00)) {
    param_00 = "angle";
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  switch (param_00) {
    case "angle":
      while(abs(self.angles[1] - var_03.angles[1]) > 1) {
        self orientmode("face angle", var_03.angles[1]);
        scripts\engine\utility::waitframe();
      }

      self _meth_80F1(self.origin, var_03.angles);
      scripts\engine\utility::waitframe();
      break;

    case "point":
      var_04 = vectortoangles(var_03.origin - self.origin);
      var_05 = anglesToForward(var_04);
      var_06 = anglesToForward(self.angles);
      var_07 = vectordot(var_05, var_06);
      while(var_07 < 0.99) {
        self orientmode("face point", var_03.origin);
        var_06 = anglesToForward(self.angles);
        var_07 = vectordot(var_05, var_06);
        scripts\engine\utility::waitframe();
      }

      self _meth_80F1(self.origin, vectortoangles(var_03.origin - self.origin));
      scripts\engine\utility::waitframe();
      break;
  }

  if(isDefined(var_03.var_8779) && !param_02) {
    var_03 delete();
  }
}

func_EC0A(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("death");
  self notify("starting_new_sceneblock");
  self endon("starting_new_sceneblock");
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  if(isDefined(self.var_EC09)) {
    if(!isDefined(level.var_EC85[self.var_1FBB])) {
      level.var_EC85[self.var_1FBB] = [];
    }

    if(!isDefined(level.var_EC85[self.var_1FBB][self.var_EC09])) {
      if(self.var_1FBB == "salter") {
        level.var_EC85[self.var_1FBB][self.var_EC09] = level.var_EBFF.var_EA31[self.var_EC09 + "_XO"];
      } else {
        level.var_EC85[self.var_1FBB][self.var_EC09] = level.var_EBFF.var_47[self.var_EC09];
      }
    }

    scripts\sp\anim::func_1F35(self, self.var_EC09);
    self.var_EC09 = undefined;
    self.a.movement = "stop";
  }

  self notify("stop_loop");
  scripts\sp\interaction::func_9A0F();
  self givescorefortrophyblocks();
  lib_0A1E::func_2385();
  scripts\sp\anim::func_1F12(self);
  var_06 = lib_0EFB::func_7D7A(param_00);
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = "stand_idle";
  }

  if(!isDefined(param_04)) {
    param_04 = "Exposed";
  }

  if(param_01) {
    if(param_05) {
      scripts\engine\utility::delaycall(0.05, ::_meth_8250, 1);
    } else {
      scripts\engine\utility::delaycall(0.05, ::_meth_8250, 0);
    }

    var_06 scripts\sp\anim::func_1ED0(self, param_03, undefined, param_04);
  } else {
    if(param_05) {
      scripts\engine\utility::delaycall(0.05, ::_meth_8250, 1);
    } else {
      scripts\engine\utility::delaycall(0.05, ::_meth_8250, 0);
    }

    var_06 scripts\sp\anim::func_1ECE(self, param_03);
  }

  self.objective_playermask_showto = 0;
  self give_mp_super_weapon(self.origin);
  if(param_05) {
    self _meth_8250(0);
  }

  self notify("sceneblock_reach_finished");
  if(param_02 && scripts\sp\interaction::func_9C26(var_06)) {
    if(isDefined(var_06.var_EE92)) {
      if(issubstr(var_06.var_EE92, "opsmap")) {
        if(self.var_1FBB == "salter" || self.var_1FBB == "gator" || self.var_1FBB == "drop_officer") {
          thread lib_0EFB::func_CD3F(var_06.var_EE92);
        } else {
          thread scripts\sp\interaction::func_CD50(var_06.var_EE92);
        }
      } else {
        thread scripts\sp\interaction::func_CD4B(var_06.var_EE92);
      }
    } else {
      thread scripts\sp\interaction::func_CD4B(var_06.script_noteworthy);
    }
  }

  if(param_02 && scripts\sp\interaction::func_9CD7(var_06)) {
    thread scripts\sp\interaction_manager::func_CE40(var_06.var_EE92, var_06);
  }
}

func_EC0C(param_00, param_01, param_02) {
  self endon("death");
  self endon("sceneblock_reachloop_stop");
  if(!isDefined(param_02)) {
    param_02 = "stop_loop";
  }

  func_EC0A(param_00);
  self notify("sceneblock_reachloop_reach_finished");
  scripts\sp\anim::func_1ECC(self, param_01, param_02);
}

func_EC0B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("death");
  self endon("stop_sceneblock");
  self notify("starting_new_sceneblock_idle");
  self endon("starting_new_sceneblock_idle");
  scripts\sp\utility::func_415D("casual");
  if(!scripts\engine\utility::flag_exist("setup_sceneblock_anims") || !scripts\engine\utility::flag("setup_sceneblock_anims")) {
    func_EBE9();
  }

  if(!isDefined(param_07)) {
    param_07 = 0;
  }

  if(!isDefined(level.var_EC85[self.var_1FBB])) {
    level.var_EC85[self.var_1FBB] = [];
  }

  if(isDefined(self.var_EC09) && isDefined(self.var_EC07)) {
    if(!isDefined(level.var_EC85[self.var_1FBB][self.var_EC09])) {
      if(self.var_1FBB == "salter") {
        level.var_EC85[self.var_1FBB][self.var_EC09] = level.var_EBFF.var_EA31[self.var_EC09 + "_XO"];
      } else {
        level.var_EC85[self.var_1FBB][self.var_EC09] = level.var_EBFF.var_47[self.var_EC09];
      }
    }

    scripts\sp\anim::func_1F35(self, self.var_EC09);
    self.a.movement = "stop";
  }

  if(param_01 != "shipcrib_stand_console" && !isDefined(level.var_EC85[self.var_1FBB][param_01])) {
    if(self.var_1FBB == "salter") {
      level.var_EC85[self.var_1FBB][param_01][0] = level.var_EBFF.var_EA31[param_01 + "_XO"];
    } else {
      level.var_EC85[self.var_1FBB][param_01][0] = level.var_EBFF.var_47[param_01];
    }
  }

  self.var_EC07 = undefined;
  self.var_EC09 = undefined;
  func_EC0A(param_00, param_03, param_04, param_05, param_06, param_07);
  if(param_01 != "shipcrib_stand_console") {
    thread scripts\sp\utility::func_F40E("casual", param_01);
  }

  switch (param_01) {
    case "shipcrib_stand_stationary_talk_idle_01":
      self.var_EC07 = "shipcrib_stand_idle01_arrival";
      if(isDefined(param_02)) {
        self.var_EC09 = "shipcrib_stand_" + param_02 + "_exit";
      } else {
        self.var_EC09 = "shipcrib_stand_idle01_exit";
      }
      break;

    case "shipcrib_stand_stationary_talk_idle_02":
      self.var_EC07 = "shipcrib_stand_idle02_arrival";
      if(isDefined(param_02)) {
        self.var_EC09 = "shipcrib_stand_" + param_02 + "_exit";
      } else {
        self.var_EC09 = "shipcrib_stand_idle02_exit";
      }
      break;

    case "shipcrib_stand_stationary_talk_idle_03":
      self.var_EC07 = "shipcrib_stand_idle03_arrival";
      if(isDefined(param_02)) {
        self.var_EC09 = "shipcrib_stand_" + param_02 + "_exit";
      } else {
        self.var_EC09 = "shipcrib_stand_idle03_exit";
      }
      break;

    case "shipcrib_stand_stationary_talk_idle_04":
      self.var_EC07 = "shipcrib_stand_idle04_arrival";
      if(isDefined(param_02)) {
        self.var_EC09 = "shipcrib_stand_" + param_02 + "_exit";
      } else {
        self.var_EC09 = "shipcrib_stand_idle04_exit";
      }
      break;

    case "shipcrib_stand_stationary_talk_idle_05":
      self.var_EC07 = "shipcrib_stand_idle05_arrival";
      if(isDefined(param_02)) {
        self.var_EC09 = "shipcrib_stand_" + param_02 + "_exit";
      } else {
        self.var_EC09 = "shipcrib_stand_idle05_exit";
      }
      break;

    case "shipcrib_stand_console":
      self.var_EC07 = "shipcrib_bridge_stand_console_transition_in";
      self.var_EC09 = "shipcrib_bridge_stand_console_transition_out";
      scripts\sp\utility::func_415D("casual");
      break;
  }

  if(isDefined(self.var_EC07)) {
    if(!isDefined(level.var_EC85[self.var_1FBB][self.var_EC07])) {
      if(self.var_1FBB == "salter") {
        level.var_EC85[self.var_1FBB][self.var_EC07] = level.var_EBFF.var_EA31[self.var_EC07 + "_XO"];
      } else {
        level.var_EC85[self.var_1FBB][self.var_EC07] = level.var_EBFF.var_47[self.var_EC07];
      }
    }

    scripts\sp\anim::func_1F35(self, self.var_EC07);
    self.a.movement = "stop";
  }

  self givescorefortrophyblocks();
  self notify("sceneblock_reachidle_finished");
  thread func_13B0();
}

func_13B0() {
  self endon("death");
  self waittill("starting_new_sceneblock");
  scripts\sp\utility::func_415D("casual");
}

func_EC06(param_00) {
  scripts\sp\utility::func_415D("casual");
  if(!scripts\engine\utility::flag_exist("setup_sceneblock_anims") || !scripts\engine\utility::flag("setup_sceneblock_anims")) {
    func_EBE9();
  }

  if(!isDefined(level.var_EC85[self.var_1FBB][param_00])) {
    if(self.var_1FBB == "salter") {
      level.var_EC85[self.var_1FBB][param_00][0] = level.var_EBFF.var_EA31[param_00 + "_XO"];
    } else {
      level.var_EC85[self.var_1FBB][param_00][0] = level.var_EBFF.var_47[param_00];
    }
  }

  switch (param_00) {
    case "shipcrib_stand_stationary_talk_idle_01":
      self.var_EC07 = "shipcrib_stand_idle01_arrival";
      self.var_EC09 = "shipcrib_stand_idle01_exit";
      break;

    case "shipcrib_stand_stationary_talk_idle_02":
      self.var_EC07 = "shipcrib_stand_idle02_arrival";
      self.var_EC09 = "shipcrib_stand_idle02_exit";
      break;

    case "shipcrib_stand_stationary_talk_idle_03":
      self.var_EC07 = "shipcrib_stand_idle03_arrival";
      self.var_EC09 = "shipcrib_stand_idle03_exit";
      break;

    case "shipcrib_stand_stationary_talk_idle_04":
      self.var_EC07 = "shipcrib_stand_idle04_arrival";
      self.var_EC09 = "shipcrib_stand_idle04_exit";
      break;

    case "shipcrib_stand_stationary_talk_idle_05":
      self.var_EC07 = "shipcrib_stand_idle05_arrival";
      self.var_EC09 = "shipcrib_stand_idle05_exit";
      break;
  }

  thread scripts\sp\utility::func_F40E("casual", param_00);
}

func_EC04() {
  scripts\sp\utility::func_415D("casual");
  self.var_EC07 = undefined;
  self.var_EC09 = undefined;
  self notify("stop_sceneblock");
}

func_EC0F(param_00, param_01, param_02) {
  self endon("death");
  self notify("starting_new_sceneblock");
  self endon("starting_new_sceneblock");
  self notify("stop_loop");
  scripts\sp\interaction::func_9A0F();
  self givescorefortrophyblocks();
  lib_0A1E::func_2385();
  var_03 = lib_0EFB::func_7D7A(param_00);
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = "sceneblock_walk_loop";
  }

  func_EC08("point", var_03, 1);
  var_04 = scripts\common\trace::ray_trace(self.origin + (0, 0, 1), self.origin + (0, 0, -6), self);
  if(isDefined(var_04["entity"])) {
    self linkto(var_04["entity"]);
  }

  thread scripts\sp\anim::func_1ECC(self, param_02, "stop_loop");
  var_05 = 0;
  for(;;) {
    if(distance2d(self.origin, var_03.origin) < 12 && !var_05) {
      self _meth_80F1(self.origin, vectortoangles(var_03.origin - self.origin));
      var_05 = 1;
    } else if(distance2d(self.origin, var_03.origin) < 4) {
      self _meth_80F1(var_03.origin, self.angles);
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self notify("stop_loop");
  self givescorefortrophyblocks();
  self unlink();
  self give_mp_super_weapon(getgroundposition(self.origin, 1));
  if(param_01) {
    func_EC08("angle", var_03);
  }
}

func_EC0E(param_00, param_01, param_02) {}

func_1450(param_00, param_01, param_02, param_03) {
  self endon("death");
  if(getdvarint("loc_warnings", 0)) {
    return;
  }

  if(!isDefined(level.var_545A)) {
    level.var_545A = [];
  }

  var_04 = 4;
  for(var_05 = 0; var_05 <= var_04; var_05++) {
    var_06 = 0;
    if(isDefined(level.var_545A["last cleartime"])) {
      if(gettime() - level.var_545A["last cleartime"] > 1000) {
        var_06 = 1;
      }
    }

    if(var_05 == var_04 || var_06) {
      for(var_05 = 0; var_05 < var_04; var_05++) {
        level.var_545A[var_05] = undefined;
        level.var_545A["last cleartime"] = undefined;
      }

      var_05 = 0;
      level.var_545A[var_05] = 1;
      break;
    }

    if(!isDefined(level.var_545A[var_05])) {
      level.var_545A[var_05] = 1;
      break;
    }
  }

  var_07 = "^3";
  if(isDefined(param_02)) {
    switch (param_02) {
      case "red":
      case "r":
        var_07 = "^1";
        break;

      case "green":
      case "g":
        var_07 = "^2";
        break;

      case "yellow":
      case "y":
        var_07 = "^3";
        break;

      case "blue":
      case "b":
        var_07 = "^4";
        break;

      case "cyan":
      case "c":
        var_07 = "^5";
        break;

      case "purple":
      case "p":
        var_07 = "^6";
        break;

      case "white":
      case "w":
        var_07 = "^7";
        break;

      case "bl":
      case "black":
        var_07 = "^8";
        break;
    }
  }

  var_08 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_08.location = 0;
  var_08.alignx = "left";
  var_08.aligny = "top";
  var_08.foreground = 1;
  var_08.sort = 20;
  var_08.alpha = 0;
  var_08 fadeovertime(0.5);
  var_08.alpha = 1;
  var_08.x = 40;
  var_08.y = 242 + var_05 * 18;
  var_08.label = " " + var_07 + param_00 + "^7: " + param_01;
  var_08.color = (1, 1, 1);
  var_09 = 1;
  level.var_545A["last cleartime"] = gettime() + param_03 + var_09 * 1000;
  wait(param_03 - 0.25);
  var_08 fadeovertime(var_09);
  var_08.alpha = 0;
  var_08 scripts\engine\utility::delaycall(var_09, ::destroy);
  wait(var_09);
}