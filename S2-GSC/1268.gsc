/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1268.gsc
*********************************************/

func_767F() {
  var_00 = getEntArray("boundary_trigger", "targetname");
  var_01 = getdvarint("trailer_disable_boundaries", 0) > 0;
  if(var_01) {
    foreach(var_03 in var_00) {
      var_03 common_scripts\utility::func_9D9F();
      if(isDefined(var_03.var_1A2)) {
        var_04 = getEntArray(var_03.var_1A2, "targetname");
        foreach(var_06 in var_04) {
          if(var_06.var_165 == "visuals" || var_06.var_165 == "visuals_retreat") {
            var_06 delete();
          }
        }
      }
    }
  }
}

func_00D5() {
  level.var_1B69 = [];
  var_00 = getEntArray("boundary_trigger", "targetname");
  var_01 = getdvarint("trailer_disable_boundaries", 0) > 0;
  if(var_01) {
    foreach(var_03 in var_00) {
      var_03 common_scripts\utility::func_9D9F();
      var_04 = getEntArray(var_03.var_1A2, "targetname");
      foreach(var_06 in var_04) {
        if(var_06.var_165 == "visuals" || var_06.var_165 == "visuals_retreat") {
          var_06 delete();
        }
      }
    }

    return;
  }

  foreach(var_09 in var_07) {
    var_0A = var_09.var_165;
    if(isDefined(level.var_1B69[var_0A])) {}

    var_0B = "free";
    if(issubstr(var_0A, "allies")) {
      var_0B = "allies";
      if(game["switchedsides"]) {
        var_0B = "axis";
      }
    } else if(issubstr(var_0A, "axis")) {
      var_0B = "axis";
      if(game["switchedsides"]) {
        var_0B = "allies";
      }
    }

    level.var_1B69[var_0A] = spawnStruct();
    level.var_1B69[var_0A].var_9D65 = var_09;
    level.var_1B69[var_0A].var_931A = "inactive";
    level.var_1B69[var_0A].var_1A7 = var_0B;
    level.var_1B69[var_0A].var_A582 = var_09 func_529C();
    level.var_1B69[var_0A].var_A583 = var_09 func_529B();
    level.var_1B69[var_0A].var_A55D = 0;
    level.var_1B69[var_0A].var_A55E = 0;
    func_A192(var_0A);
    var_09 common_scripts\utility::func_9D9F();
    var_09 thread func_1B6A();
  }

  func_863D("alwaysOn", "active", 5);
  level thread func_A910();
  level thread func_4AC5();
}

func_A910() {
  level endon("game_ended");
  for(;;) {
    level common_scripts\utility::knock_off_battery("player_spawned", "joined_team", "joined_spectators");
    foreach(var_02, var_01 in level.var_1B69) {
      func_A192(var_02);
    }
  }
}

deleteboundarytriggers() {
  foreach(var_01 in level.var_1B69) {
    if(isDefined(var_01.var_9D65)) {
      var_01.var_9D65 delete();
    }

    if(isDefined(var_01.var_A582)) {
      common_scripts\utility::func_F71(var_01.var_A582, ::delete);
      var_01.var_A582 = [];
    }

    if(isDefined(var_01.var_A583)) {
      common_scripts\utility::func_F71(var_01.var_A583, ::delete);
      var_01.var_A583 = [];
    }
  }

  level.var_1B69 = [];
  foreach(var_04 in level.var_744A) {
    var_04.var_1B69 = [];
  }
}

func_4AC5() {
  level waittill("game_ended");
  deleteboundarytriggers();
}

func_529C() {
  var_00 = [];
  if(!isDefined(self.var_1A2)) {
    return undefined;
  }

  var_01 = getEntArray(self.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.var_165 == "visuals") {
      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

func_529B() {
  var_00 = [];
  if(!isDefined(self.var_1A2)) {
    return undefined;
  }

  var_01 = getEntArray(self.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.var_165 == "visuals_retreat") {
      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

func_8C2A(param_00, param_01) {
  if(level.var_1B69[param_00].var_A55D == param_01) {
    return;
  }

  level.var_1B69[param_00].var_A55D = param_01;
  func_A192(param_00);
}

func_8C13(param_00, param_01) {
  if(level.var_1B69[param_00].var_A55E == param_01) {
    return;
  }

  level.var_1B69[param_00].var_A55E = param_01;
  func_A192(param_00);
}

func_A192(param_00) {
  var_01 = level.var_1B69[param_00].var_A55D;
  if(isDefined(level.var_1B69[param_00].var_A582)) {
    if(var_01) {
      foreach(var_03 in level.var_744A) {
        var_01 = 0;
        if(isDefined(var_03.var_1A7) && var_03.var_1A7 == "allies" || var_03.var_1A7 == "axis") {
          var_01 = level.var_1B69[param_00].var_1A7 != var_03.var_1A7;
        }

        if(var_01) {
          common_scripts\utility::func_F71(level.var_1B69[param_00].var_A582, ::showtoclient, var_03);
          continue;
        }

        common_scripts\utility::func_F71(level.var_1B69[param_00].var_A582, ::hidefromclient, var_03);
      }
    } else {
      common_scripts\utility::func_F71(level.var_1B69[param_00].var_A582, ::method_805C);
    }
  }

  var_05 = level.var_1B69[param_00].var_A55E;
  if(isDefined(level.var_1B69[param_00].var_A583)) {
    if(var_05) {
      foreach(var_03 in level.var_744A) {
        var_01 = 0;
        if(isDefined(var_03.var_1A7) && var_03.var_1A7 == "allies" || var_03.var_1A7 == "axis") {
          var_01 = level.var_1B69[param_00].var_1A7 != var_03.var_1A7;
        }

        if(var_01) {
          common_scripts\utility::func_F71(level.var_1B69[param_00].var_A583, ::showtoclient, var_03);
          continue;
        }

        common_scripts\utility::func_F71(level.var_1B69[param_00].var_A583, ::hidefromclient, var_03);
      }

      return;
    }

    common_scripts\utility::func_F71(level.var_1B69[param_00].var_A583, ::method_805C);
  }
}

func_863D(param_00, param_01, param_02) {
  if(isDefined(level.var_1B69[param_00])) {
    var_03 = level.var_1B69[param_00].var_931A;
    level.var_1B69[param_00].var_931A = param_01;
    if(param_01 == "active") {
      level.var_1B69[param_00].var_99DA = int(param_02 * 1000);
    } else if(param_01 == "incoming") {
      level.var_1B69[param_00].var_99DA = gettime() + int(param_02 * 1000);
      level.var_1B69[param_00].var_9309 = gettime();
    }

    if(var_03 == "inactive" && param_01 != "inactive") {
      level.var_1B69[param_00].var_9D65 common_scripts\utility::func_9DA3();
    } else if(var_03 != "inactive" && param_01 == "inactive") {
      level.var_1B69[param_00].var_9D65 common_scripts\utility::func_9D9F();
    }

    if(var_03 != "incoming" && param_01 == "incoming") {
      func_8C13(param_00, 1);
    } else if(var_03 == "incoming" && param_01 != "incoming") {
      func_8C13(param_00, 0);
    }
  } else if(param_00 != "alwaysOn") {
    iprintln("setBoundaryTriggerState called with invalid trigger name \'" + param_00 + "\' and state \'" + param_01 + "\'.");
  }

  level notify("raid_boundaries_changed");
}

func_8BEF(param_00) {
  foreach(var_03, var_02 in level.var_1B69) {
    func_8C2A(var_03, common_scripts\utility::func_F79(param_00, var_03));
  }
}

func_7D4E() {
  foreach(var_01 in level.var_744A) {
    var_01.var_8D0 = undefined;
  }
}

func_1B6A() {
  self endon("death");
  var_00 = self.var_165;
  for(;;) {
    self waittill("trigger", var_01);
    if(!isPlayer(var_01)) {
      continue;
    }

    if(!maps\mp\_utility::func_57A0(var_01)) {
      continue;
    }

    if(var_01.var_1A7 == level.var_1B69[var_00].var_1A7 && !isDefined(var_01.var_2016)) {
      continue;
    }

    if(isDefined(var_01.var_2016) && common_scripts\utility::func_562E(var_01.var_2016.ignoreboundaries)) {
      continue;
    }

    var_02 = level.var_1B69[var_00].var_931A;
    if(var_02 == "inactive") {
      continue;
    }

    if(var_02 == "active") {
      var_01 thread func_7400(self);
      if(var_00 != "alwaysOn") {
        lib_0502::func_9860(var_01, 1, 3, 0);
        level thread func_79C3(var_01, 3);
      }

      continue;
    }

    if(var_02 == "incoming") {
      var_01 thread func_7405(self);
    }
  }
}

func_79C3(param_00, param_01) {
  if(isPlayer(param_00) || function_01EF(param_00)) {
    if(isDefined(param_01)) {
      param_00.var_6DEC = 1;
      param_00 setperk("specialty_radararrow", 1, 0);
      param_00 func_7915(param_01);
      param_00 thread maps\mp\perks\_perkfunctions::func_A930();
    }
  }
}

func_7915(param_00) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait(param_00);
  self.var_6DEC = 0;
  self unsetperk("specialty_radararrow", 1);
  self notify("unsetPainted");
}

func_73AD(param_00) {
  if(!isDefined(self.var_1B69)) {
    self.var_1B69 = [];
  }

  self.var_1B69 = common_scripts\utility::func_F6F(self.var_1B69, param_00.var_165);
}

func_7444(param_00) {
  self.var_1B69 = common_scripts\utility::func_F93(self.var_1B69, param_00.var_165);
}

func_7410(param_00) {
  if(!isDefined(self.var_1B69)) {
    return 0;
  }

  return common_scripts\utility::func_F79(self.var_1B69, param_00.var_165);
}

func_7411(param_00) {
  if(!isDefined(self.var_1B69)) {
    return 0;
  }

  foreach(var_02 in self.var_1B69) {
    if(level.var_1B69[var_02].var_931A == param_00) {
      return 1;
    }
  }

  return 0;
}

func_43FE() {
  var_00 = [];
  foreach(var_02 in level.var_1B69) {
    if(var_02.var_931A == "active") {
      var_00[var_00.size] = var_02.var_9D65;
    }
  }

  return var_00;
}

func_7415(param_00, param_01) {
  if(!isDefined(self.var_1B69)) {
    return 0;
  }

  foreach(var_03 in self.var_1B69) {
    if(level.var_1B69[var_03].var_931A == param_01) {
      return param_00 == level.var_1B69[var_03].var_9D65;
    }
  }

  return 0;
}

func_7443(param_00) {
  foreach(var_02 in self.var_1B69) {
    if(level.var_1B69[var_02].var_931A == param_00) {
      self.var_1B69 = common_scripts\utility::func_F93(self.var_1B69, var_02);
    }
  }
}

func_747F() {
  var_00 = self.var_8CF;
  var_01 = self.var_50E7;
  var_02 = self.var_2AB1;
  if(isDefined(self.var_2AB1)) {
    func_7480(1);
    self setclientomnvar("ui_raid_boundary_timer", 0);
    self setclientomnvar("ui_raid_boundary_type", 2);
    return;
  }

  if(!isDefined(var_00) && !isDefined(var_01)) {
    func_7480(0);
    self setclientomnvar("ui_raid_boundary_timer", 0);
    self setclientomnvar("ui_raid_boundary_type", -1);
    return;
  }

  if(!isDefined(var_00)) {
    func_7480(1);
    self setclientomnvar("ui_raid_boundary_timer", var_01);
    self setclientomnvar("ui_raid_boundary_type", 1);
    return;
  }

  if(!isDefined(var_01)) {
    func_7480(1);
    self setclientomnvar("ui_raid_boundary_timer", var_00);
    self setclientomnvar("ui_raid_boundary_type", 0);
    return;
  }

  if(var_00 > var_01) {
    func_7480(1);
    self setclientomnvar("ui_raid_boundary_timer", var_01);
    self setclientomnvar("ui_raid_boundary_type", 1);
    return;
  }

  func_7480(1);
  self setclientomnvar("ui_raid_boundary_timer", var_00);
  self setclientomnvar("ui_raid_boundary_type", 0);
}

func_7480(param_00) {
  if(!isDefined(self.var_1B67)) {
    self.var_1B67 = 0;
  }

  if(self.var_1B67 == param_00) {
    return;
  }

  self.var_1B67 = param_00;
  if(param_00) {
    thread func_745B();
    return;
  }

  thread func_73FE();
}

func_745B() {
  var_00 = 0.2;
  if(isDefined(self.var_1B68)) {
    self notify("cancelBoundaryOverlayHide");
  } else {
    self.var_1B68 = newclienthudelem(self);
    self.var_1B68.maxsightdistsqrd = 0;
    self.var_1B68.var_1D7 = 0;
    self.var_1B68.ignoreme = -5;
    self.var_1B68.var_C6 = "fullscreen";
    self.var_1B68.var_1CA = "fullscreen";
    self.var_1B68 setshader("overlay_raid_boundary", 640, 480);
    self.var_1B68.var_C2 = 1;
    self.var_1B68.var_180 = 0;
    self.var_1B68.var_18 = 0;
  }

  self.var_1B68 fadeovertime(var_00);
  self.var_1B68.var_18 = 1;
}

func_73FE() {
  self endon("death");
  self endon("disconnect");
  self endon("cancelBoundaryOverlayHide");
  var_00 = 0.2;
  if(!isDefined(self.var_1B68)) {
    return;
  }

  self.var_1B68 fadeovertime(var_00);
  self.var_1B68.var_18 = 0;
  wait(var_00);
  self.var_1B68 destroy();
}

func_73D9() {
  var_00 = 6000;
  var_01 = 6;
  if(!isDefined(self.var_1B6B)) {
    self.var_1B6B = 0;
    self.var_1B6C = 1;
  }

  if(self.var_1B6B > gettime()) {
    return;
  }

  if(isDefined(game["music"]["boundary_warning"]) && function_0344(game["music"]["boundary_warning"])) {
    playclientsound(game["music"]["boundary_warning"], undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, self);
  }

  var_02 = lib_0506::func_A618("out_of_bounds" + self.var_1B6C, 0.5, "death", 1, self);
  if(common_scripts\utility::func_562E(var_02)) {
    self.var_1B6B = gettime() + var_00;
    self.var_1B6C++;
    if(self.var_1B6C > var_01) {
      self.var_1B6C = 1;
    }
  }
}

func_7400(param_00) {
  self endon("deathSentence");
  self endon("death");
  self endon("disconnect");
  self.var_5B69 = gettime();
  if(func_7410(param_00)) {
    return;
  }

  thread func_73C5();
  var_01 = param_00.var_165;
  if(!isDefined(self.var_8D0)) {
    self.var_8D0 = level.var_1B69[var_01].var_99DA;
  }

  var_02 = gettime() + self.var_8D0;
  if(isDefined(self.var_50E7)) {
    var_02 = min(var_02, self.var_50E7);
  }

  func_73AD(param_00);
  if(!isDefined(self.var_8CF)) {
    self.var_8CF = var_02;
  }

  func_747F();
  func_73D9();
  for(;;) {
    wait 0.05;
    if(isDefined(self.var_8CF) && gettime() > self.var_8CF) {
      thread func_2AB1("boundaryraid_mp");
      return;
    } else if(gettime() - self.var_5B69 > 100) {
      func_7443("active");
      self.var_8CF = undefined;
      func_747F();
      return;
    }

    if(!isDefined(self.var_8D0)) {
      self.var_8D0 = level.var_1B69[var_01].var_99DA;
    }

    if(func_7415(param_00, "active")) {
      self.var_8D0 = self.var_8D0 - 50;
    }
  }
}

func_7405(param_00) {
  self endon("deathSentence");
  self endon("death");
  self endon("disconnect");
  self.var_5BAC = gettime();
  if(func_7410(param_00)) {
    return;
  }

  thread func_73C5();
  var_01 = param_00.var_165;
  var_02 = level.var_1B69[var_01].var_99DA;
  var_03 = 3000;
  if(var_02 - gettime() < var_03) {
    if(!func_7411("active")) {
      return;
    }
  }

  func_73AD(param_00);
  if(!isDefined(self.var_50E7)) {
    self.var_50E7 = var_02;
  }

  self.var_781A = 0;
  var_04 = gettime();
  if(gettime() - level.var_1B69[var_01].var_9309 <= 100) {
    self.var_781A = 1;
  }

  func_747F();
  for(;;) {
    wait 0.05;
    if(isDefined(self.var_50E7) && gettime() >= self.var_50E7) {
      thread func_2AB1("retreatraid_mp");
      return;
    } else if(gettime() - self.var_5BAC > 100) {
      func_7443("incoming");
      self.var_50E7 = undefined;
      func_747F();
      if(self.var_781A == 1) {
        self.var_781A = 0;
        lib_0502::func_7926(self);
      }

      return;
    }
  }
}

func_73C5() {
  self notify("playerCleanupBoundaryDataOnDeath");
  self endon("playerCleanupBoundaryDataOnDeath");
  self endon("disconnect");
  common_scripts\utility::func_A732("death", "deathSentence");
  self.var_8CF = undefined;
  self.var_50E7 = undefined;
  self.var_2AB1 = undefined;
  self.var_1B69 = undefined;
  func_747F();
}

func_2AB1(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.var_2AB1 = 1;
  func_747F();
  if(isDefined(self method_85E2())) {
    self method_80F4();
    self dodamage(self.var_FB * 10, self.var_116, self, undefined, "MOD_EXPLOSIVE");
    return;
  }

  thread func_2AB2(param_00);
}

func_2AB2(param_00) {
  var_01 = self;
  var_02 = self.var_116;
  var_03 = self.var_1D;
  var_04 = self getEye() + anglesToForward(var_03) * 40;
  var_05 = var_02 + anglesToForward(var_03) * 70;
  var_06 = bulletTrace(var_05 + (0, 0, 32), var_05 + (0, 0, -32), 0, undefined);
  var_05 = var_06["position"];
  var_07 = spawn("script_model", var_05);
  var_07.var_116 = var_05;
  var_07.var_1D = var_03;
  var_07 setModel("npc_ger_smi44_bouncing_betty");
  var_07 lib_0378::func_8D74("wpn_bouncingbetty_trigger");
  maps\mp\gametypes\_hostmigration::func_A6F5(0.1);
  var_07 lib_0378::func_8D74("wpn_bouncingbetty_spin");
  var_07 moveto(var_04, 0.7, 0, 0.65);
  var_07 rotatevelocity((0, 750, 32), 0.7, 0, 0.65);
  var_07 thread func_74DD();
  maps\mp\gametypes\_hostmigration::func_A6F5(0.65);
  var_07 lib_0378::func_8D74("wpn_bouncingbetty_exp");
  var_08 = var_07 gettagorigin("tag_fx");
  playFX(level.var_61C8, var_08);
  maps\mp\gametypes\_hostmigration::func_A6F5(0.05);
  var_07 method_8511();
  if(isDefined(var_01) && isalive(var_01)) {
    var_01 dodamage(750, var_01.var_116, var_01, undefined, "MOD_EXPLOSIVE", param_00);
  }

  maps\mp\gametypes\_hostmigration::func_A6F5(1);
  var_07 delete();
}

func_74DD() {
  self endon("death");
  var_00 = gettime() + 1000;
  while(gettime() < var_00) {
    wait 0.05;
    playFXOnTag(level.var_61CF, self, "tag_fx_spin1");
    playFXOnTag(level.var_61CF, self, "tag_fx_spin3");
    wait 0.05;
    playFXOnTag(level.var_61CF, self, "tag_fx_spin2");
    playFXOnTag(level.var_61CF, self, "tag_fx_spin4");
  }
}

func_8BEA(param_00) {
  foreach(var_02 in level.var_1B69) {
    if(common_scripts\utility::func_562E(var_02.var_A55D)) {
      foreach(var_04 in var_02.var_A582) {
        var_04 showtoclient(param_00);
      }
    }
  }
}

func_7D4F(param_00) {
  foreach(var_08, var_02 in level.var_1B69) {
    if(common_scripts\utility::func_562E(var_02.var_A55D)) {
      if(var_02.var_1A7 == param_00.var_1A7) {
        foreach(var_04 in var_02.var_A582) {
          var_04 hidefromclient(param_00);
        }
      } else {
        foreach(var_04 in var_08.var_A582) {
          var_04 showtoclient(param_00);
        }
      }
    }
  }
}

func_9C77(param_00, param_01) {
  level notify("transitionBoundary");
  if(common_scripts\utility::func_562E(level.var_79C2.var_6980)) {
    waittillframeend;
  }

  func_863D(param_00, "incoming", param_01);
  level.var_79C2.var_6980 = 1;
  level.var_79C2.var_694A = gettime();
  level maps\mp\gametypes\_hostmigration::func_A74C("transitionBoundary", param_01);
  func_863D(param_00, "active", 5);
  level.var_79C2.var_6980 = undefined;
}