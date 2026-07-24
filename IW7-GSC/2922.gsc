/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2922.gsc
**************************************/

#using_animtree("generic_human");

_id_EBE9() {
  scripts\engine\utility::flag_init("setup_sceneblock_anims");
  level._id_EBFF = spawnStruct();
  level._id_EBFF.anims = [];
  level._id_EBFF.anims["shipcrib_stand_stationary_talk_idle_01"] = % shipcrib_stand_stationary_talk_idle_01;
  level._id_EBFF.anims["shipcrib_stand_idle01_arrival"] = % shipcrib_stand_idle01_arrival;
  level._id_EBFF.anims["shipcrib_stand_idle01_exit"] = % shipcrib_stand_idle01_exit;
  level._id_EBFF.anims["shipcrib_stand_stationary_talk_idle_02"] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EBFF.anims["shipcrib_stand_idle02_arrival"] = % shipcrib_stand_idle02_arrival;
  level._id_EBFF.anims["shipcrib_stand_idle02_exit"] = % shipcrib_stand_idle02_exit;
  level._id_EBFF.anims["shipcrib_stand_stationary_talk_idle_03"] = % shipcrib_stand_stationary_talk_idle_03;
  level._id_EBFF.anims["shipcrib_stand_idle03_arrival"] = % shipcrib_stand_idle03_arrival;
  level._id_EBFF.anims["shipcrib_stand_idle03_exit"] = % shipcrib_stand_idle03_exit;
  level._id_EBFF.anims["shipcrib_stand_stationary_talk_idle_04"] = % shipcrib_stand_stationary_talk_idle_04;
  level._id_EBFF.anims["shipcrib_stand_idle04_arrival"] = % shipcrib_stand_idle04_arrival;
  level._id_EBFF.anims["shipcrib_stand_idle04_exit"] = % shipcrib_stand_idle04_exit;
  level._id_EBFF.anims["shipcrib_stand_stationary_talk_idle_05"] = % shipcrib_stand_stationary_talk_idle_05;
  level._id_EBFF.anims["shipcrib_stand_idle05_arrival"] = % shipcrib_stand_idle05_arrival;
  level._id_EBFF.anims["shipcrib_stand_idle05_exit"] = % shipcrib_stand_idle05_exit;
  level._id_EBFF.anims["shipcrib_bridge_stand_console_transition_in"] = % shipcrib_bridge_stand_console_transition_in;
  level._id_EBFF.anims["shipcrib_bridge_stand_console_transition_out"] = % shipcrib_bridge_stand_console_transition_out;
  level._id_EBFF._id_EA31 = [];
  level._id_EBFF._id_EA31["shipcrib_stand_stationary_talk_idle_01_XO"] = % shipcrib_stand_stationary_talk_idle_01_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle01_arrival_XO"] = % shipcrib_stand_idle01_arrival_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle01_exit_XO"] = % shipcrib_stand_idle01_exit_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_stationary_talk_idle_02_XO"] = % shipcrib_stand_stationary_talk_idle_02_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle02_arrival_XO"] = % shipcrib_stand_idle02_arrival_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle02_exit_XO"] = % shipcrib_stand_idle02_exit_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_stationary_talk_idle_03_XO"] = % shipcrib_stand_stationary_talk_idle_03_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle03_arrival_XO"] = % shipcrib_stand_idle03_arrival_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle03_exit_XO"] = % shipcrib_stand_idle03_exit_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_stationary_talk_idle_04_XO"] = % shipcrib_stand_stationary_talk_idle_04_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle04_arrival_XO"] = % shipcrib_stand_idle04_arrival_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle04_exit_XO"] = % shipcrib_stand_idle04_exit_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_stationary_talk_idle_05_XO"] = % shipcrib_stand_stationary_talk_idle_05_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle05_arrival_XO"] = % shipcrib_stand_idle05_arrival_xo;
  level._id_EBFF._id_EA31["shipcrib_stand_idle05_exit_XO"] = % shipcrib_stand_idle05_exit_xo;
  level._id_EBFF.anims["shipcrib_bridge_stand_console_transition_in_XO"] = % shipcrib_bridge_stand_console_transition_in;
  level._id_EBFF.anims["shipcrib_bridge_stand_console_transition_out_XO"] = % shipcrib_bridge_stand_console_transition_out;
  scripts\engine\utility::flag_set("setup_sceneblock_anims");
}

_id_EC01(var_0, var_1, var_2) {
  self endon("death");
  self notify("starting_new_sceneblock");
  self endon("starting_new_sceneblock");
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(var_2) {
    _id_EC08("point", var_0);
  }

  scripts\sp\anim::_id_1EC7(self, var_1);
  self setgoalpos(self.origin);
}

_id_EC0D(var_0, var_1) {
  self endon("death");
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  var_2 = _id_0EFB::_id_7D7A(var_0);
  self _meth_80F1(var_2.origin, var_2.angles);
  self setgoalpos(self.origin);

  if(isDefined(var_1) && var_1) {
    if(var_1 && scripts\sp\interaction::_id_9C26(var_2)) {
      if(isDefined(var_2._id_EE92)) {
        if(issubstr(var_2._id_EE92, "opsmap")) {
          if(self._id_1FBB == "salter" || self._id_1FBB == "gator" || self._id_1FBB == "drop_officer") {
            thread _id_0EFB::_id_CD3F(var_2._id_EE92);
          } else {
            thread scripts\sp\interaction::_id_CD50(var_2._id_EE92);
          }
        } else
          thread scripts\sp\interaction::_id_CD4B(var_2._id_EE92);
      } else
        thread scripts\sp\interaction::_id_CD4B(var_2.script_noteworthy);
    }
  }

  scripts\engine\utility::waitframe();
}

_id_EC02(var_0, var_1) {
  level.player endon("death");
  var_2 = _id_0EFB::_id_7D7A(var_0);

  if(!isstring(var_0)) {
    var_0 = "empty";
  }

  level._id_EC02[var_0] = var_2;
  var_2 endon("death");
  var_2 _id_0E46::_id_48C4(undefined, undefined, undefined, 90, 3000, 1);
  var_3 = squared(500);

  for(;;) {
    while(distance2dsquared(var_2.origin, level.player.origin) > var_3) {
      scripts\engine\utility::waitframe();
    }

    var_2 _id_0E46::_id_DFE3();

    if(isDefined(var_1) && var_1) {
      break;
    }

    while(distance2dsquared(var_2.origin, level.player.origin) < var_3) {
      scripts\engine\utility::waitframe();
    }

    var_2 _id_0E46::_id_48C4(undefined, undefined, undefined, 60, 3000, 0);
  }
}

_id_EC03(var_0) {
  if(isDefined(level._id_EC02) && isDefined(level._id_EC02[var_0]) && isDefined(level._id_EC02[var_0]._id_4C1F)) {
    level._id_EC02[var_0] _id_0E46::_id_DFE3();
  }
}

_id_EC08(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_sceneblock_orient");
  self notify("starting_new_sceneblock_orient");
  self endon("starting_new_sceneblock_orient");
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  var_3 = _id_0EFB::_id_7D7A(var_1);

  if(!isDefined(var_0)) {
    var_0 = "angle";
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  switch (var_0) {
    case "angle":
      while(abs(self.angles[1] - var_3.angles[1]) > 1) {
        self orientmode("face angle", var_3.angles[1]);
        scripts\engine\utility::waitframe();
      }

      self _meth_80F1(self.origin, var_3.angles);
      scripts\engine\utility::waitframe();
      break;
    case "point":
      var_4 = vectortoangles(var_3.origin - self.origin);
      var_5 = anglesToForward(var_4);
      var_6 = anglesToForward(self.angles);
      var_7 = vectordot(var_5, var_6);

      while(var_7 < 0.99) {
        self orientmode("face point", var_3.origin);
        var_6 = anglesToForward(self.angles);
        var_7 = vectordot(var_5, var_6);
        scripts\engine\utility::waitframe();
      }

      self _meth_80F1(self.origin, vectortoangles(var_3.origin - self.origin));
      scripts\engine\utility::waitframe();
      break;
  }

  if(isDefined(var_3._id_8779) && !var_2) {
    var_3 delete();
  }
}

_id_EC0A(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self notify("starting_new_sceneblock");
  self endon("starting_new_sceneblock");

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(isDefined(self._id_EC09)) {
    if(!isDefined(level._id_EC85[self._id_1FBB])) {
      level._id_EC85[self._id_1FBB] = [];
    }

    if(!isDefined(level._id_EC85[self._id_1FBB][self._id_EC09])) {
      if(self._id_1FBB == "salter") {
        level._id_EC85[self._id_1FBB][self._id_EC09] = level._id_EBFF._id_EA31[self._id_EC09 + "_XO"];
      } else {
        level._id_EC85[self._id_1FBB][self._id_EC09] = level._id_EBFF.anims[self._id_EC09];
      }
    }

    scripts\sp\anim::_id_1F35(self, self._id_EC09);
    self._id_EC09 = undefined;
    self.a.movement = "stop";
  }

  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  var_6 = _id_0EFB::_id_7D7A(var_0);

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = "stand_idle";
  }

  if(!isDefined(var_4)) {
    var_4 = "Exposed";
  }

  if(var_1) {
    if(var_5) {
      scripts\engine\utility::delaycall(0.05, ::_meth_8250, 1);
    } else {
      scripts\engine\utility::delaycall(0.05, ::_meth_8250, 0);
    }

    var_6 scripts\sp\anim::_id_1ED0(self, var_3, undefined, var_4);
  } else {
    if(var_5) {
      scripts\engine\utility::delaycall(0.05, ::_meth_8250, 1);
    } else {
      scripts\engine\utility::delaycall(0.05, ::_meth_8250, 0);
    }

    var_6 scripts\sp\anim::_id_1ECE(self, var_3);
  }

  self.goalradius = 0;
  self setgoalpos(self.origin);

  if(var_5) {
    self _meth_8250(0);
  }

  self notify("sceneblock_reach_finished");

  if(var_2 && scripts\sp\interaction::_id_9C26(var_6)) {
    if(isDefined(var_6._id_EE92)) {
      if(issubstr(var_6._id_EE92, "opsmap")) {
        if(self._id_1FBB == "salter" || self._id_1FBB == "gator" || self._id_1FBB == "drop_officer") {
          thread _id_0EFB::_id_CD3F(var_6._id_EE92);
        } else {
          thread scripts\sp\interaction::_id_CD50(var_6._id_EE92);
        }
      } else
        thread scripts\sp\interaction::_id_CD4B(var_6._id_EE92);
    } else
      thread scripts\sp\interaction::_id_CD4B(var_6.script_noteworthy);
  }

  if(var_2 && scripts\sp\interaction::_id_9CD7(var_6)) {
    thread scripts\sp\interaction_manager::_id_CE40(var_6._id_EE92, var_6);
  }
}

_id_EC0C(var_0, var_1, var_2) {
  self endon("death");
  self endon("sceneblock_reachloop_stop");

  if(!isDefined(var_2)) {
    var_2 = "stop_loop";
  }

  _id_EC0A(var_0);
  self notify("sceneblock_reachloop_reach_finished");
  scripts\sp\anim::_id_1ECC(self, var_1, var_2);
}

_id_EC0B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_sceneblock");
  self notify("starting_new_sceneblock_idle");
  self endon("starting_new_sceneblock_idle");
  scripts\sp\utility::_id_415D("casual");

  if(!scripts\engine\utility::flag_exist("setup_sceneblock_anims") || !scripts\engine\utility::flag("setup_sceneblock_anims")) {
    _id_EBE9();
  }

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  if(!isDefined(level._id_EC85[self._id_1FBB])) {
    level._id_EC85[self._id_1FBB] = [];
  }

  if(isDefined(self._id_EC09) && isDefined(self._id_EC07)) {
    if(!isDefined(level._id_EC85[self._id_1FBB][self._id_EC09])) {
      if(self._id_1FBB == "salter") {
        level._id_EC85[self._id_1FBB][self._id_EC09] = level._id_EBFF._id_EA31[self._id_EC09 + "_XO"];
      } else {
        level._id_EC85[self._id_1FBB][self._id_EC09] = level._id_EBFF.anims[self._id_EC09];
      }
    }

    scripts\sp\anim::_id_1F35(self, self._id_EC09);
    self.a.movement = "stop";
  }

  if(var_1 != "shipcrib_stand_console" && !isDefined(level._id_EC85[self._id_1FBB][var_1])) {
    if(self._id_1FBB == "salter") {
      level._id_EC85[self._id_1FBB][var_1][0] = level._id_EBFF._id_EA31[var_1 + "_XO"];
    } else {
      level._id_EC85[self._id_1FBB][var_1][0] = level._id_EBFF.anims[var_1];
    }
  }

  self._id_EC07 = undefined;
  self._id_EC09 = undefined;
  _id_EC0A(var_0, var_3, var_4, var_5, var_6, var_7);

  if(var_1 != "shipcrib_stand_console") {
    thread scripts\sp\utility::_id_F40E("casual", var_1);
  }

  switch (var_1) {
    case "shipcrib_stand_stationary_talk_idle_01":
      self._id_EC07 = "shipcrib_stand_idle01_arrival";

      if(isDefined(var_2)) {
        self._id_EC09 = "shipcrib_stand_" + var_2 + "_exit";
      } else {
        self._id_EC09 = "shipcrib_stand_idle01_exit";
      }

      break;
    case "shipcrib_stand_stationary_talk_idle_02":
      self._id_EC07 = "shipcrib_stand_idle02_arrival";

      if(isDefined(var_2)) {
        self._id_EC09 = "shipcrib_stand_" + var_2 + "_exit";
      } else {
        self._id_EC09 = "shipcrib_stand_idle02_exit";
      }

      break;
    case "shipcrib_stand_stationary_talk_idle_03":
      self._id_EC07 = "shipcrib_stand_idle03_arrival";

      if(isDefined(var_2)) {
        self._id_EC09 = "shipcrib_stand_" + var_2 + "_exit";
      } else {
        self._id_EC09 = "shipcrib_stand_idle03_exit";
      }

      break;
    case "shipcrib_stand_stationary_talk_idle_04":
      self._id_EC07 = "shipcrib_stand_idle04_arrival";

      if(isDefined(var_2)) {
        self._id_EC09 = "shipcrib_stand_" + var_2 + "_exit";
      } else {
        self._id_EC09 = "shipcrib_stand_idle04_exit";
      }

      break;
    case "shipcrib_stand_stationary_talk_idle_05":
      self._id_EC07 = "shipcrib_stand_idle05_arrival";

      if(isDefined(var_2)) {
        self._id_EC09 = "shipcrib_stand_" + var_2 + "_exit";
      } else {
        self._id_EC09 = "shipcrib_stand_idle05_exit";
      }

      break;
    case "shipcrib_stand_console":
      self._id_EC07 = "shipcrib_bridge_stand_console_transition_in";
      self._id_EC09 = "shipcrib_bridge_stand_console_transition_out";
      scripts\sp\utility::_id_415D("casual");
      break;
  }

  if(isDefined(self._id_EC07)) {
    if(!isDefined(level._id_EC85[self._id_1FBB][self._id_EC07])) {
      if(self._id_1FBB == "salter") {
        level._id_EC85[self._id_1FBB][self._id_EC07] = level._id_EBFF._id_EA31[self._id_EC07 + "_XO"];
      } else {
        level._id_EC85[self._id_1FBB][self._id_EC07] = level._id_EBFF.anims[self._id_EC07];
      }
    }

    scripts\sp\anim::_id_1F35(self, self._id_EC07);
    self.a.movement = "stop";
  }

  self _meth_83A1();
  self notify("sceneblock_reachidle_finished");
  thread _id_13B0();
}

_id_13B0() {
  self endon("death");
  self waittill("starting_new_sceneblock");
  scripts\sp\utility::_id_415D("casual");
}

_id_EC06(var_0) {
  scripts\sp\utility::_id_415D("casual");

  if(!scripts\engine\utility::flag_exist("setup_sceneblock_anims") || !scripts\engine\utility::flag("setup_sceneblock_anims")) {
    _id_EBE9();
  }

  if(!isDefined(level._id_EC85[self._id_1FBB][var_0])) {
    if(self._id_1FBB == "salter") {
      level._id_EC85[self._id_1FBB][var_0][0] = level._id_EBFF._id_EA31[var_0 + "_XO"];
    } else {
      level._id_EC85[self._id_1FBB][var_0][0] = level._id_EBFF.anims[var_0];
    }
  }

  switch (var_0) {
    case "shipcrib_stand_stationary_talk_idle_01":
      self._id_EC07 = "shipcrib_stand_idle01_arrival";
      self._id_EC09 = "shipcrib_stand_idle01_exit";
      break;
    case "shipcrib_stand_stationary_talk_idle_02":
      self._id_EC07 = "shipcrib_stand_idle02_arrival";
      self._id_EC09 = "shipcrib_stand_idle02_exit";
      break;
    case "shipcrib_stand_stationary_talk_idle_03":
      self._id_EC07 = "shipcrib_stand_idle03_arrival";
      self._id_EC09 = "shipcrib_stand_idle03_exit";
      break;
    case "shipcrib_stand_stationary_talk_idle_04":
      self._id_EC07 = "shipcrib_stand_idle04_arrival";
      self._id_EC09 = "shipcrib_stand_idle04_exit";
      break;
    case "shipcrib_stand_stationary_talk_idle_05":
      self._id_EC07 = "shipcrib_stand_idle05_arrival";
      self._id_EC09 = "shipcrib_stand_idle05_exit";
      break;
  }

  thread scripts\sp\utility::_id_F40E("casual", var_0);
}

_id_EC04() {
  scripts\sp\utility::_id_415D("casual");
  self._id_EC07 = undefined;
  self._id_EC09 = undefined;
  self notify("stop_sceneblock");
}

_id_EC0F(var_0, var_1, var_2) {
  self endon("death");
  self notify("starting_new_sceneblock");
  self endon("starting_new_sceneblock");
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  var_3 = _id_0EFB::_id_7D7A(var_0);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = "sceneblock_walk_loop";
  }

  _id_EC08("point", var_3, 1);
  var_4 = scripts\common\trace::ray_trace(self.origin + (0, 0, 1), self.origin + (0, 0, -6), self);

  if(isDefined(var_4["entity"])) {
    self linkTo(var_4["entity"]);
  }

  thread scripts\sp\anim::_id_1ECC(self, var_2, "stop_loop");
  var_5 = 0;

  for(;;) {
    if(distance2d(self.origin, var_3.origin) < 12 && !var_5) {
      self _meth_80F1(self.origin, vectortoangles(var_3.origin - self.origin));
      var_5 = 1;
    } else if(distance2d(self.origin, var_3.origin) < 4) {
      self _meth_80F1(var_3.origin, self.angles);
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self notify("stop_loop");
  self _meth_83A1();
  self unlink();
  self setgoalpos(getgroundposition(self.origin, 1));

  if(var_1) {
    _id_EC08("angle", var_3);
  }
}

_id_EC0E(var_0, var_1, var_2) {}

_id_1450(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_545A)) {
    level._id_545A = [];
  }

  var_4 = 4;

  for(var_5 = 0; var_5 <= var_4; var_5++) {
    var_6 = 0;

    if(isDefined(level._id_545A["last cleartime"])) {
      if(gettime() - level._id_545A["last cleartime"] > 1000) {
        var_6 = 1;
      }
    }

    if(var_5 == var_4 || var_6) {
      for(var_5 = 0; var_5 < var_4; var_5++) {
        level._id_545A[var_5] = undefined;
        level._id_545A["last cleartime"] = undefined;
      }

      var_5 = 0;
      level._id_545A[var_5] = 1;
      break;
    }

    if(!isDefined(level._id_545A[var_5])) {
      level._id_545A[var_5] = 1;
      break;
    }
  }

  var_7 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_7 = "^1";
        break;
      case "green":
      case "g":
        var_7 = "^2";
        break;
      case "yellow":
      case "y":
        var_7 = "^3";
        break;
      case "blue":
      case "b":
        var_7 = "^4";
        break;
      case "cyan":
      case "c":
        var_7 = "^5";
        break;
      case "purple":
      case "p":
        var_7 = "^6";
        break;
      case "white":
      case "w":
        var_7 = "^7";
        break;
      case "bl":
      case "black":
        var_7 = "^8";
        break;
    }
  }

  var_8 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_8.location = 0;
  var_8.alignx = "left";
  var_8.aligny = "top";
  var_8.foreground = 1;
  var_8.sort = 20;
  var_8.alpha = 0;
  var_8 fadeovertime(0.5);
  var_8.alpha = 1;
  var_8.x = 40;
  var_8.y = 242 + var_5 * 18;
  var_8.label = " " + var_7 + var_0 + "^7: " + var_1;
  var_8.color = (1, 1, 1);
  var_9 = 1;
  level._id_545A["last cleartime"] = gettime() + (var_3 + var_9) * 1000;
  wait(var_3 - 0.25);
  var_8 fadeovertime(var_9);
  var_8.alpha = 0;
  var_8 scripts\engine\utility::delaycall(var_9, ::destroy);
  wait(var_9);
}