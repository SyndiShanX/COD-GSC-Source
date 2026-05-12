/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gameobjects.gsc
**********************************************/

func_00F9(param_00) {
  param_00[param_00.size] = "airdrop_pallet";
  var_01 = getEntArray();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(isDefined(var_01[var_02].var_81BE)) {
      var_03 = 1;
      var_04 = strtok(var_01[var_02].var_81BE, " ");
      for(var_05 = 0; var_05 < param_00.size; var_05++) {
        for(var_06 = 0; var_06 < var_04.size; var_06++) {
          if(var_04[var_06] == param_00[var_05]) {
            var_03 = 0;
            break;
          }
        }

        if(!var_03) {
          break;
        }
      }

      if(var_03) {
        if(isDefined(var_01[var_02].var_8186)) {
          common_scripts\_createfx::func_7CE2(var_01[var_02]);
        }

        var_01[var_02] delete();
      }
    }
  }
}

func_00D5() {
  level.var_688F = 0;
  level.var_6991 = 0;
  level thread func_6B6C();
}

func_6B6C() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_6B82();
    var_00 thread func_6AEE();
  }
}

func_6B82() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("spawned_player");
    if(isDefined(self.var_3FCB)) {
      self.var_3FCB = undefined;
      continue;
    }

    func_5240();
  }
}

func_5240() {
  thread func_6AE3();
  self.var_9AC5 = [];
  self.var_2016 = undefined;
  self.var_2310 = undefined;
  self.var_1F63 = 1;
  self.var_5A3E = undefined;
  self.var_52F8 = 1;
}

func_6AE3() {
  level endon("game_ended");
  self waittill("death");
  if(isDefined(self.var_2016)) {
    if(function_0367() || isDefined(self.var_2016.var_2D3F) && self.var_2016.var_2D3F) {
      self.var_2016 func_2D2F();
      return;
    }

    self.var_2016 thread func_866E();
    if(level.var_3FDC == "relic") {
      level maps\mp\gametypes\relic::attemptdropteslagun(self.var_0116);
    }
  }
}

func_6AEE() {
  level endon("game_ended");
  self waittill("disconnect");
  if(isDefined(self.var_2016)) {
    if(function_0367()) {
      self.var_2016 func_2D2F();
      return;
    }

    self.var_2016 thread func_866E();
  }
}

func_27D6(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  var_07.var_01B9 = "carryObject";
  var_07.var_28D4 = param_01.var_0116;
  var_07.var_6DB2 = param_00;
  var_07.var_37D8 = param_01 getentitynumber();
  if(issubstr(param_01.var_003A, "use")) {
    var_07.var_9DC4 = "use";
  } else {
    var_07.var_9DC4 = "proximity";
  }

  param_01.var_162D = param_01.var_0116;
  var_07.var_9D65 = param_01;
  var_07.var_A248 = undefined;
  if(!isDefined(param_03)) {
    param_03 = (0, 0, 0);
  }

  var_07.var_6A1D = param_03;
  for(var_08 = 0; var_08 < param_02.size; var_08++) {
    param_02[var_08].var_162D = param_02[var_08].var_0116;
    param_02[var_08].var_15F4 = param_02[var_08].var_001D;
  }

  var_07.var_A582 = param_02;
  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  if(!param_05) {
    if(!isDefined(param_06)) {
      param_06 = 0;
    }

    var_07.var_2562 = [];
    var_07.var_698A = func_45A9();
    var_07.var_698B = func_45A9();
    var_07.var_698C = func_45A9();
    var_07.var_6990 = 0;
    var_07.var_698F = 0;
    var_07.var_6993 = 5;
    level.var_6991 = level.var_6991 + 2;
    objective_add(var_07.var_698A, "invisible", var_07.var_28D4);
    objective_add(var_07.var_698B, "invisible", var_07.var_28D4);
    objective_add(var_07.var_698C, "invisible", var_07.var_28D4);
    objective_team(var_07.var_698A, "allies");
    objective_team(var_07.var_698B, "axis");
    objective_playermask_hidefromall(var_07.var_698C);
    if(param_06) {
      var_07.var_6996["allies"] = maps\mp\gametypes\_objpoints::func_282F("objpoint_allies_" + var_07.var_37D8, var_07.var_28D4 + param_03, "allies", undefined);
      var_07.var_6996["axis"] = maps\mp\gametypes\_objpoints::func_282F("objpoint_axis_" + var_07.var_37D8, var_07.var_28D4 + param_03, "axis", undefined);
      var_07.var_6996["broadcaster"] = maps\mp\gametypes\_objpoints::func_282F("objpoint_broadcaster_" + var_07.var_37D8, var_07.var_28D4 + param_03, "broadcaster", undefined);
      var_07.var_6996["broadcaster"].var_001F = 0;
      var_07.var_6996["allies"].var_0018 = 0;
      var_07.var_6996["axis"].var_0018 = 0;
    }
  }

  var_07.var_2006 = undefined;
  var_07.var_57A6 = 0;
  var_07.var_5412 = "none";
  var_07.var_0C33 = 0;
  var_07.var_A965 = 0;
  var_07.var_59DD = 0;
  var_07.var_AA8A = [];
  var_07.var_AA89 = [];
  var_07.var_356E = undefined;
  var_07.var_200B = 0;
  var_07.var_A560 = "none";
  var_07.var_2015 = undefined;
  var_07.var_6AEF = undefined;
  var_07.var_6B62 = undefined;
  var_07.var_6B93 = undefined;
  if(var_07.var_9DC4 == "use") {
    var_07 thread func_201A();
  } else {
    var_07.var_28D5 = 0;
    var_07.var_A23F = 0;
    var_07.var_A22B = 0;
    var_07.var_65BF = 0;
    var_07.var_1F49 = 0;
    var_07.var_5107 = 0;
    var_07.var_986E = [];
    var_07.var_986D = [];
    var_07.var_689F["neutral"] = 0;
    var_07.var_689F["axis"] = 0;
    var_07.var_689F["allies"] = 0;
    var_07.var_689F["none"] = 0;
    var_07.var_9AC3["neutral"] = [];
    var_07.var_9AC3["axis"] = [];
    var_07.var_9AC3["allies"] = [];
    var_07.var_9AC3["none"] = [];
    var_07.var_230F = "none";
    var_07.var_230E = undefined;
    var_07.var_5B81 = undefined;
    var_07.var_5B82 = "none";
    var_07.var_5B83 = 0;
    if(level.var_6520) {
      foreach(var_0A in level.var_985B) {
        var_07.var_689F[var_0A] = 0;
        var_07.var_9AC3[var_0A] = [];
      }
    }

    var_07 thread func_2018();
  }

  if(!param_05) {
    var_07 thread func_A0F2(param_04);
  }

  return var_07;
}

func_2D2F() {
  if(!isDefined(self.var_01B9) || self.var_01B9 != "carryObject") {
    return;
  }

  var_00 = self;
  var_00.var_01B9 = undefined;
  var_00.var_28D4 = undefined;
  var_00.var_6DB2 = undefined;
  var_00.var_37D8 = undefined;
  var_00.var_9DC4 = undefined;
  var_00.var_9D65 unlink();
  var_00.var_9D65 delete();
  var_00.var_9D65 = undefined;
  var_00.var_A248 = undefined;
  var_00.var_6A1D = undefined;
  foreach(var_02 in var_00.var_A582) {
    if(isDefined(var_02)) {
      var_02 delete();
    }
  }

  var_00.var_A582 = undefined;
  if(!function_0367()) {
    if(isDefined(var_00.var_698A)) {
      maps\mp\_utility::func_068B(var_00.var_698A);
    }

    if(isDefined(var_00.var_698B)) {
      maps\mp\_utility::func_068B(var_00.var_698B);
    }

    if(isDefined(var_00.var_698C)) {
      maps\mp\_utility::func_068B(var_00.var_698C);
    }
  }

  var_00.var_2562 = undefined;
  var_00.var_698A = undefined;
  var_00.var_698B = undefined;
  var_00.var_698C = undefined;
  var_00.var_6990 = undefined;
  var_00.var_698F = undefined;
  var_00.var_6993 = undefined;
  if(isDefined(var_00.var_6996)) {
    maps\mp\gametypes\_objpoints::func_2D3E(var_00.var_6996["allies"]);
    maps\mp\gametypes\_objpoints::func_2D3E(var_00.var_6996["axis"]);
    maps\mp\gametypes\_objpoints::func_2D3E(var_00.var_6996["broadcaster"]);
  }

  var_00.var_6996 = undefined;
  var_00.var_2006 = undefined;
  var_00.var_57A6 = undefined;
  var_00.var_5412 = undefined;
  var_00.var_0C33 = undefined;
  var_00.var_A965 = undefined;
  var_00.var_59DD = undefined;
  var_00.var_AA8A = undefined;
  var_00.var_AA89 = undefined;
  var_00.var_356E = undefined;
  var_00.var_200B = undefined;
  var_00.var_A560 = undefined;
  var_00.var_2015 = undefined;
  var_00.var_6AEF = undefined;
  var_00.var_6B62 = undefined;
  var_00.var_6B93 = undefined;
  var_00.var_28D5 = undefined;
  var_00.var_A23F = undefined;
  var_00.var_A22B = undefined;
  var_00.var_65BF = undefined;
  var_00.var_1F49 = undefined;
  var_00.var_5107 = undefined;
  var_00.var_986E = undefined;
  var_00.var_986D = undefined;
  var_00.var_689F = undefined;
  var_00.var_9AC3 = undefined;
  var_00.var_230F = undefined;
  var_00.var_230E = undefined;
  var_00.var_5B81 = undefined;
  var_00.var_5B82 = undefined;
  var_00.var_5B83 = undefined;
  var_00 notify("death");
  var_00 notify("deleted");
}

func_201A() {
  level endon("game_ended");
  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    if(self.var_57A6) {
      continue;
    }

    if(!maps\mp\_utility::func_57A0(var_00)) {
      continue;
    }

    if(!func_1F53(var_00.var_012C["team"])) {
      continue;
    }

    if(!var_00.var_1F63) {
      continue;
    }

    if(!isDefined(var_00.var_52F8)) {
      continue;
    }

    if(isDefined(var_00.var_99AC)) {
      continue;
    }

    if(isDefined(self.var_2006)) {
      continue;
    }

    if(var_00 maps\mp\_utility::func_581D() || var_00 maps\mp\_utility::func_572D()) {
      continue;
    }

    func_86F9(var_00);
  }
}

func_2018() {
  thread func_2019();
}

func_2019() {
  if(function_0367()) {
    self endon("death");
    self endon("deleted");
  }

  if((isDefined(level.var_5677) && level.var_5677) || isDefined(level.var_579A) && level.var_579A) {
    self endon("death");
  }

  level endon("game_ended");
  thread func_779A();
  for(;;) {
    waittillframeend;
    if(self.var_A23F && self.var_28D5 >= self.var_A23F) {
      self.var_28D5 = 0;
      var_00 = func_44AF();
      if(isDefined(self.var_6AFA)) {
        self[[self.var_6AFA]](func_445B(), var_00, isDefined(var_00));
      }

      if(isDefined(var_00)) {
        func_86F9(var_00);
      }

      func_864E("none");
      self.var_230E = undefined;
    }

    if(self.var_230F != "none") {
      if(self.var_A23F) {
        if(!self.var_689F[self.var_230F] || func_5108() || common_scripts\utility::func_562E(self.var_A414) && isDefined(self.var_1F84) && ![[self.var_1F84]](self.var_230E)) {
          if(isDefined(self.var_6AFA)) {
            self[[self.var_6AFA]](func_445B(), self.var_230E, 0);
          }

          func_864E("none");
          self.var_230E = undefined;
        } else {
          self.var_28D5 = self.var_28D5 + 50 * self.var_A22B;
          if(isDefined(self.var_6BCB)) {
            self[[self.var_6BCB]](func_445B(), self.var_28D5 / self.var_A23F, 50 * self.var_A22B / self.var_A23F);
          }
        }
      } else {
        if(maps\mp\_utility::func_57A0(self.var_230E)) {
          func_86F9(self.var_230E);
        }

        func_864E("none");
        self.var_230E = undefined;
      }
    }

    wait 0.05;
    maps\mp\gametypes\_hostmigration::func_A782();
  }
}

func_6FCF(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.var_1F63 = 0;
  for(;;) {
    if(distancesquared(self.var_0116, param_00) > 4096) {
      break;
    }

    wait(0.2);
  }

  self.var_1F63 = 1;
}

func_86F9(param_00) {
  if(isai(param_00) && isDefined(param_00.var_0117)) {
    return;
  }

  if(isDefined(param_00.var_2016)) {
    if(isDefined(self.var_6B63)) {
      self[[self.var_6B63]](param_00);
    }

    return;
  }

  param_00 func_479E(self);
  func_8643(param_00);
  for(var_01 = 0; var_01 < self.var_A582.size; var_01++) {
    self.var_A582[var_01] method_805C();
  }

  self.var_9D65.var_0116 = self.var_9D65.var_0116 + (0, 0, 10000);
  self notify("pickup_object");
  if(isDefined(self.var_6B62)) {
    self[[self.var_6B62]](param_00);
  }

  func_A0FE();
  func_A19B();
}

func_A0F2(param_00) {
  if((isDefined(level.var_5677) && level.var_5677) || isDefined(level.var_579A) && level.var_579A) {
    self endon("death");
  }

  level endon("game_ended");
  if(function_0367()) {
    self endon("death");
    self endon("deleted");
  }

  for(;;) {
    if(isDefined(self.var_2006)) {
      self.var_28D4 = self.var_2006.var_0116 + (0, 0, 75);
      self.var_28CF = self.var_2006.var_0116;
      self.var_6996["allies"] maps\mp\gametypes\_objpoints::func_A145(self.var_28D4);
      self.var_6996["axis"] maps\mp\gametypes\_objpoints::func_A145(self.var_28D4);
      var_01 = self.var_6993 + 1;
      if(common_scripts\utility::func_562E(param_00)) {
        var_02 = var_01;
      } else {
        var_02 = 0;
      }

      if((self.var_A560 == "friendly" || self.var_A560 == "any") && func_56FB("allies") && self.var_6990) {
        if(self.var_6996["allies"].var_57CB) {
          self.var_6996["allies"].var_0018 = self.var_6996["allies"].var_15F3;
          self.var_6996["allies"] fadeovertime(var_01);
          self.var_6996["allies"].var_0018 = 0;
        }

        objective_position(self.var_698A, self.var_28D4, var_02);
      } else if((self.var_A560 == "friendly" || self.var_A560 == "any") && func_56FB("axis") && self.var_6990) {
        if(self.var_6996["axis"].var_57CB) {
          self.var_6996["axis"].var_0018 = self.var_6996["axis"].var_15F3;
          self.var_6996["axis"] fadeovertime(var_01);
          self.var_6996["axis"].var_0018 = 0;
        }

        objective_position(self.var_698B, self.var_28D4, var_02);
      }

      if((self.var_A560 == "enemy" || self.var_A560 == "any") && !func_56FB("allies") && self.var_698F) {
        if(self.var_6996["allies"].var_57CB) {
          self.var_6996["allies"].var_0018 = self.var_6996["allies"].var_15F3;
          self.var_6996["allies"] fadeovertime(var_01);
          self.var_6996["allies"].var_0018 = 0;
        }

        objective_position(self.var_698A, self.var_28D4, var_02);
      } else if((self.var_A560 == "enemy" || self.var_A560 == "any") && !func_56FB("axis") && self.var_698F) {
        if(self.var_6996["axis"].var_57CB) {
          self.var_6996["axis"].var_0018 = self.var_6996["axis"].var_15F3;
          self.var_6996["axis"] fadeovertime(var_01);
          self.var_6996["axis"].var_0018 = 0;
        }

        objective_position(self.var_698B, self.var_28D4, var_02);
      }

      common_scripts\utility::func_A63E(self.var_6993, "dropped", "reset");
      continue;
    }

    self.var_28CF = undefined;
    self.var_6996["allies"] maps\mp\gametypes\_objpoints::func_A145(self.var_28D4 + self.var_6A1D);
    self.var_6996["axis"] maps\mp\gametypes\_objpoints::func_A145(self.var_28D4 + self.var_6A1D);
    wait 0.05;
  }
}

func_4D05() {
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  level waittill("game_ended");
  if(isDefined(self.var_2015)) {
    self.var_2015.var_0018 = 0;
  }
}

func_479E(param_00) {
  self.var_2016 = param_00;
  thread func_9BA1();
  if(common_scripts\utility::func_562E(param_00.carrythinkbypass)) {
    self thread[[param_00.var_201D]]();
  }

  if(isDefined(param_00.var_201C)) {
    func_805D(param_00);
    param_00.var_2008 = self hasweapon(param_00.var_201C);
    if(isDefined(param_00.var_201D)) {
      self thread[[param_00.var_201D]]();
    }

    maps\mp\_utility::func_0642(param_00.var_201C);
    self switchtoweapon(param_00.var_201C);
    self method_82CD();
    common_scripts\utility::func_0603();
  } else if(!param_00.var_0C33) {
    common_scripts\utility::func_0602();
    if(isDefined(param_00.var_5FD8)) {
      self thread[[param_00.var_5FD8]]();
    } else {
      thread func_5FD8();
    }
  }

  if(isDefined(param_00.var_2015) && isPlayer(self)) {
    if(level.var_910F) {
      self.var_2015 = maps\mp\gametypes\_hud_util::func_280B(param_00.var_2015, 33, 33);
      self.var_2015 maps\mp\gametypes\_hud_util::func_8707("BOTTOM RIGHT", "BOTTOM RIGHT", -50, -78);
    } else {
      self.var_2015 = maps\mp\gametypes\_hud_util::func_280B(param_00.var_2015, 50, 50);
      self.var_2015 maps\mp\gametypes\_hud_util::func_8707("BOTTOM RIGHT", "BOTTOM RIGHT", -90, -110);
    }

    self.var_2015.var_00C2 = 1;
    thread func_4D05();
  }
}

func_7E30() {
  self.var_57A6 = 1;
  self notify("reset");
  for(var_00 = 0; var_00 < self.var_A582.size; var_00++) {
    self.var_A582[var_00].var_0116 = self.var_A582[var_00].var_162D;
    self.var_A582[var_00].var_001D = self.var_A582[var_00].var_15F4;
    self.var_A582[var_00] method_805B();
  }

  self.var_9D65.var_0116 = self.var_9D65.var_162D;
  self.var_28D4 = self.var_9D65.var_0116;
  if(isDefined(self.var_6B93)) {
    self[[self.var_6B93]]();
  }

  func_23DA();
  func_A19B();
  func_A0FE();
  self.var_57A6 = 0;
}

func_5715() {
  if(isDefined(self.var_2006)) {
    return 0;
  }

  if(self.var_28D4 != self.var_9D65.var_162D) {
    return 0;
  }

  return 1;
}

func_870A(param_00, param_01) {
  self.var_57A6 = 1;
  for(var_02 = 0; var_02 < self.var_A582.size; var_02++) {
    self.var_A582[var_02].var_0116 = param_00;
    self.var_A582[var_02].var_001D = param_01;
    self.var_A582[var_02] method_805B();
  }

  self.var_9D65.var_0116 = param_00;
  self.var_28D4 = self.var_9D65.var_0116;
  func_23DA();
  func_A19B();
  func_A0FE();
  self.var_57A6 = 0;
}

func_6B7D() {
  if(isDefined(self.var_2016)) {
    self.var_2016 thread func_866E();
  }
}

func_2017(param_00) {
  for(var_01 = 0; var_01 < param_00.var_2016.var_A582.size; var_01++) {
    param_00.var_2016.var_A582[var_01] unlink();
  }

  param_00.var_2016.var_9D65 unlink();
  param_00.var_2016 notify("stop_pickup_timeout");
  param_00.var_2016 func_7E30();
}

func_866E(param_00) {
  if(level.var_3FDC == "sd") {
    wait 0.05;
  }

  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(isDefined(self.var_866E)) {
    if([[self.var_866E]]()) {
      return;
    }
  }

  self.var_57A6 = 1;
  self notify("dropped");
  if(isDefined(self.var_2006) && self.var_2006.var_01A7 != "spectator") {
    if(isDefined(self.var_2006.var_18A8)) {
      var_01 = playerphysicstrace(self.var_2006.var_0116 + (0, 0, 20), self.var_2006.var_0116 - (0, 0, 2000), self.var_2006.var_18A8);
      var_02 = bulletTrace(self.var_2006.var_0116 + (0, 0, 20), self.var_2006.var_0116 - (0, 0, 2000), 0, self.var_2006.var_18A8);
    } else {
      var_01 = playerphysicstrace(self.var_2006.var_0116 + (0, 0, 20), self.var_2006.var_0116 - (0, 0, 2000));
      var_02 = bulletTrace(self.var_2006.var_0116 + (0, 0, 20), self.var_2006.var_0116 - (0, 0, 2000), 0);
    }
  } else {
    var_01 = playerphysicstrace(self.var_802F + (0, 0, 20), self.var_802F - (0, 0, 20));
    var_02 = bulletTrace(self.var_802F + (0, 0, 20), self.var_802F - (0, 0, 20), 0, undefined);
  }

  var_03 = self.var_2006;
  if(isDefined(var_01)) {
    var_04 = randomfloat(360);
    var_05 = var_01;
    if(isDefined(self.var_A581)) {
      var_05 = var_05 + self.var_A581;
    }

    if(var_02["fraction"] < 1 && distance(var_02["position"], var_01) < 10) {
      var_06 = (cos(var_04), sin(var_04), 0);
      var_06 = vectornormalize(var_06 - var_02["normal"] * vectordot(var_06, var_02["normal"]));
      var_07 = vectortoangles(var_06);
    } else {
      var_07 = (0, var_05, 0);
    }

    for(var_08 = 0; var_08 < self.var_A582.size; var_08++) {
      self.var_A582[var_08].var_0116 = var_05;
      self.var_A582[var_08].var_001D = var_07;
      if(param_00 <= 0) {
        self.var_A582[var_08] method_805B();
        continue;
      }

      self.var_A582[var_08] thread common_scripts\utility::func_2CB7(param_00);
    }

    self.var_9D65.var_0116 = var_05;
    self.var_28D4 = self.var_9D65.var_0116;
    var_09 = spawnStruct();
    var_09.var_2016 = self;
    var_09.var_2AA8 = ::func_2017;
    self.var_9D65 thread maps\mp\_movers::func_4A27(var_09);
    thread func_6FD6();
  }

  if(!isDefined(var_03)) {
    for(var_08 = 0; var_08 < self.var_A582.size; var_08++) {
      self.var_A582[var_08].var_0116 = self.var_A582[var_08].var_162D;
      self.var_A582[var_08].var_001D = self.var_A582[var_08].var_15F4;
      if(var_02 <= 0) {
        self.var_A582[var_08] method_805B();
        continue;
      }

      self.var_A582[var_08] thread common_scripts\utility::func_2CB7(var_02);
    }

    self.var_9D65.var_0116 = self.var_9D65.var_162D;
    self.var_28D4 = self.var_9D65.var_162D;
  }

  if(isDefined(self.var_6AEF)) {
    self[[self.var_6AEF]](var_05);
  }

  func_23DA();
  func_A0FE();
  func_A19B();
  self.var_57A6 = 0;
}

func_8643(param_00) {
  self.var_2006 = param_00;
  thread func_A191();
}

func_23DA() {
  if(!isDefined(self.var_2006)) {
    return;
  }

  self.var_2006 func_95ED(self);
  self.var_2006 = undefined;
  self.var_28CF = undefined;
  self notify("carrier_cleared");
}

func_6FD6() {
  self endon("pickup_object");
  self endon("stop_pickup_timeout");
  wait 0.05;
  if(func_5808()) {
    func_7E30();
    return;
  }

  if(isDefined(self.var_138A)) {
    wait(self.var_138A);
    if(!isDefined(self.var_2006)) {
      func_7E30();
    }
  }
}

func_5808() {
  var_00 = getEntArray("out_of_bounds", "targetname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    if(!self.var_A582[0] istouching(var_00[var_01])) {
      continue;
    }

    return 1;
  }

  if(!self.var_A582[0] method_8524()) {
    var_00 = getEntArray("out_of_bounds_at_rest", "targetname");
    for(var_01 = 0; var_01 < var_00.size; var_01++) {
      if(!self.var_A582[0] istouching(var_00[var_01])) {
        continue;
      }

      return 1;
    }
  }

  var_02 = getEntArray("trigger_hurt", "classname");
  for(var_01 = 0; var_01 < var_02.size; var_01++) {
    if(!self.var_A582[0] istouching(var_02[var_01])) {
      continue;
    }

    return 1;
  }

  if(self.var_A965) {
    var_03 = getEntArray("trigger_underwater", "targetname");
    for(var_01 = 0; var_01 < var_03.size; var_01++) {
      if(!self.var_A582[0] istouching(var_03[var_01])) {
        continue;
      }

      return 1;
    }
  }

  return 0;
}

func_466F(param_00) {
  var_01 = issubstr(param_00, "zk383");
  if(isDefined(self.var_012C["altModeActive"]) && isDefined(self.var_0079) && self.var_012C["altModeActive"] && self.var_0079 != 5 && maps\mp\_utility::func_472A(param_00) == "weapon_smg" && issubstr(param_00, "suppressor") && !var_01) {
    var_02 = maps\mp\gametypes\_divisions::func_461C(1);
    if(var_02 == "suppressor_level1" || var_02 == "suppressor_level2" || var_02 == "suppressor_level3") {
      param_00 = "alt+" + param_00;
    }
  } else if(var_01 && common_scripts\utility::func_562E(self.var_012C["altModeActive"])) {
    param_00 = "alt+" + param_00;
  } else if(isDefined(self.var_012C["dragonBreathActive"]) && self.var_012C["dragonBreathActive"] && isDefined(self.var_0079) && self.var_0079 != 5 && maps\mp\_utility::func_472A(param_00) == "weapon_shotgun" && issubstr(param_00, "dragon_breath")) {
    param_00 = "alt+" + param_00;
  } else if(isDefined(self.var_012C["rifleGrenadeActive"]) && self.var_012C["rifleGrenadeActive"] && isDefined(self.var_0079) && self.var_0079 != 5 && maps\mp\_utility::func_472A(param_00) == "weapon_assault" && issubstr(param_00, "grenade_launcher")) {
    param_00 = "alt+" + param_00;
  }

  return param_00;
}

func_805D(param_00) {
  if(self playerisweaponplantenabled() && isDefined(self.var_201C) && self hasweapon(self.var_201C)) {
    var_01 = self.var_201C;
  } else {
    var_01 = func_466F(self getcurrentprimaryweapon());
  }

  param_00.var_200C = var_01;
}

func_466D(param_00) {
  if(isDefined(param_00.var_200C) && self hasweapon(param_00.var_200C)) {
    return param_00.var_200C;
  }

  var_01 = self getweaponslistprimaries();
  return var_01[0];
}

func_95ED(param_00) {
  if(isDefined(self.var_2015)) {
    self.var_2015 maps\mp\gametypes\_hud_util::func_2DCC();
  }

  if(isDefined(self)) {
    self.var_2016 = undefined;
  }

  self notify("drop_object");
  if(param_00.var_9DC4 == "proximity") {
    thread func_6FCF(param_00.var_9D65.var_0116);
  }

  if(maps\mp\_utility::func_57A0(self)) {
    if(isDefined(param_00.var_201C)) {
      var_01 = common_scripts\utility::func_562E(param_00.var_59D8);
      if(!var_01 && isDefined(param_00.var_59D9)) {
        var_01 = param_00[[param_00.var_59D9]](self);
      }

      if(!param_00.var_2008 && !var_01) {
        self takeweapon(param_00.var_201C);
      }

      var_02 = !common_scripts\utility::func_562E(param_00.var_0C2C) || !self method_833B();
      if(var_02) {
        var_03 = func_466D(param_00);
        self switchtoweapon(var_03);
      }

      self method_82CE();
      common_scripts\utility::func_0617();
      return;
    }

    if(!param_00.var_0C33) {
      common_scripts\utility::func_0616();
      return;
    }
  }
}

func_9BA1() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  while(isDefined(self.var_2016) && maps\mp\_utility::func_57A0(self)) {
    if(self isonground()) {
      var_00 = bulletTrace(self.var_0116 + (0, 0, 20), self.var_0116 - (0, 0, 20), 0, undefined);
      if(var_00["fraction"] < 1) {
        self.var_2016.var_802F = var_00["position"];
      }
    }

    wait 0.05;
  }
}

func_5FD8() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  for(;;) {
    while(self attackButtonPressed() || self fragButtonPressed() || self secondaryoffhandbuttonPressed() || self meleeButtonPressed()) {
      wait 0.05;
    }

    while(!self attackButtonPressed() && !self fragButtonPressed() && !self secondaryoffhandbuttonPressed() && !self meleeButtonPressed()) {
      wait 0.05;
    }

    if(isDefined(self.var_2016) && !self useButtonPressed()) {
      self.var_2016 thread func_866E();
    }
  }
}

deleteuseobjectobjectives() {
  if(isDefined(self.var_698A)) {
    maps\mp\_utility::func_068B(self.var_698A);
    self.var_698A = undefined;
  }

  if(isDefined(self.var_698B)) {
    maps\mp\_utility::func_068B(self.var_698B);
    self.var_698B = undefined;
  }

  if(isDefined(self.var_698C)) {
    maps\mp\_utility::func_068B(self.var_698C);
    self.var_698C = undefined;
  }
}

func_2D58() {
  deleteuseobjectobjectives();
  if(isDefined(self.var_6996)) {
    maps\mp\gametypes\_objpoints::func_2D3E(self.var_6996["allies"]);
    maps\mp\gametypes\_objpoints::func_2D3E(self.var_6996["axis"]);
    maps\mp\gametypes\_objpoints::func_2D3E(self.var_6996["broadcaster"]);
  }

  self.var_9D65 = undefined;
  self notify("deleted");
}

func_2837(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnStruct();
  var_06.var_01B9 = "useObject";
  var_06.var_28D4 = param_01.var_0116;
  var_06.var_6DB2 = param_00;
  var_06.var_37D8 = param_01 getentitynumber();
  var_06.var_59E8 = undefined;
  if(issubstr(param_01.var_003A, "use")) {
    var_06.var_9DC4 = "use";
  } else {
    var_06.var_9DC4 = "proximity";
  }

  var_06.var_9D65 = param_01;
  for(var_07 = 0; var_07 < param_02.size; var_07++) {
    param_02[var_07].var_162D = param_02[var_07].var_0116;
    param_02[var_07].var_15F4 = param_02[var_07].var_001D;
  }

  var_06.var_A582 = param_02;
  if(!isDefined(param_03)) {
    param_03 = (0, 0, 0);
  }

  var_06.var_6A1D = param_03;
  if(!isDefined(param_04) || !param_04) {
    var_06.var_2562 = [];
    var_06.var_698A = func_45A9();
    var_06.var_698B = func_45A9();
    var_06.var_698C = func_45A9();
    objective_add(var_06.var_698A, "invisible", var_06.var_28D4);
    objective_add(var_06.var_698B, "invisible", var_06.var_28D4);
    objective_add(var_06.var_698C, "invisible", var_06.var_28D4);
    objective_team(var_06.var_698A, "allies");
    objective_team(var_06.var_698B, "axis");
    objective_playermask_hidefromall(var_06.var_698C);
    if(!isDefined(param_05) || !param_05) {
      var_06.var_6996["allies"] = maps\mp\gametypes\_objpoints::func_282F("objpoint_allies_" + var_06.var_37D8, var_06.var_28D4 + param_03, "allies", undefined);
      var_06.var_6996["axis"] = maps\mp\gametypes\_objpoints::func_282F("objpoint_axis_" + var_06.var_37D8, var_06.var_28D4 + param_03, "axis", undefined);
      var_06.var_6996["broadcaster"] = maps\mp\gametypes\_objpoints::func_282F("objpoint_broadcaster_" + var_06.var_37D8, var_06.var_28D4 + param_03, "broadcaster", undefined);
      var_06.var_6996["broadcaster"].var_001F = 0;
      var_06.var_6996["allies"].var_0018 = 0;
      var_06.var_6996["axis"].var_0018 = 0;
      var_06.var_6996["broadcaster"].var_0018 = 0;
    }
  }

  var_06.var_5412 = "none";
  var_06.var_59DD = 0;
  var_06.var_AA8A = [];
  var_06.var_AA89 = [];
  var_06.var_356E = undefined;
  var_06.var_A560 = "none";
  var_06.var_6BBF = undefined;
  var_06.var_6AC9 = undefined;
  var_06.var_A23D = "default";
  var_06.var_A23F = 10000;
  var_06.var_28D5 = 0;
  if(var_06.var_9DC4 == "proximity") {
    var_06.var_986E = [];
    var_06.var_986D = [];
    var_06.var_689F["neutral"] = 0;
    var_06.var_689F["axis"] = 0;
    var_06.var_689F["allies"] = 0;
    var_06.var_689F["none"] = 0;
    var_06.var_9AC3["neutral"] = [];
    var_06.var_9AC3["axis"] = [];
    var_06.var_9AC3["allies"] = [];
    var_06.var_9AC3["none"] = [];
    var_06.var_A22B = 0;
    var_06.var_230F = "none";
    var_06.var_230E = undefined;
    var_06.var_5B81 = undefined;
    var_06.var_5B82 = "none";
    var_06.var_5B83 = 0;
    var_06.var_65BF = 0;
    var_06.var_1F49 = 0;
    var_06.var_5107 = 0;
    var_06.var_A414 = 0;
    if(level.var_6520) {
      foreach(var_09 in level.var_985B) {
        var_06.var_689F[var_09] = 0;
        var_06.var_9AC3[var_09] = [];
      }
    }

    var_06 thread func_A225();
  } else {
    var_06.var_5F95 = 0;
    var_06.var_A22B = 1;
    var_06.var_A23C = 1;
    var_06 thread func_A227();
  }

  return var_06;
}

func_6497(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  if(isDefined(self.var_9D65)) {
    self.var_9D65 method_808C();
    self.var_9D65.var_0116 = param_00;
  }

  if(isDefined(self.var_9D65.var_162D)) {
    self.var_9D65.var_162D = param_00;
  }

  if(isDefined(self.var_5CBA)) {
    self.var_5CBA method_808C();
    self.var_5CBA.var_0116 = param_00;
  }

  if(isDefined(self.var_A582)) {
    foreach(var_03 in self.var_A582) {
      var_03 method_808C();
      var_03.var_0116 = param_00;
      var_03.var_162D = param_00;
    }
  }

  if(isDefined(self.var_0116)) {
    self.var_0116 = param_00;
  }

  if(isDefined(self.var_28D4)) {
    self.var_28D4 = param_00;
  }

  if(isDefined(self.var_4800)) {
    if(isDefined(self.var_4800.var_80A4)) {
      foreach(var_06 in self.var_4800.var_80A4) {
        var_06.var_0116 = param_00;
      }
    }

    if(isDefined(self.var_4800.var_0116)) {
      self.var_4800.var_0116 = param_00;
    }
  }

  if(isDefined(self.var_6996)) {
    foreach(var_09 in self.var_6996) {
      var_09 maps\mp\gametypes\_objpoints::func_A145(param_00 + param_01);
    }
  }

  if(isDefined(self.var_698A)) {
    objective_position(self.var_698A, param_00);
  }

  if(isDefined(self.var_698B)) {
    objective_position(self.var_698B, param_00);
  }

  if(isDefined(self.var_698C)) {
    objective_position(self.var_698C, param_00);
  }

  if(isDefined(self.var_15F8)) {
    self.var_15F8 delete();
    var_0B = self.var_A582[0].var_0116 + (0, 0, 32);
    var_0C = self.var_A582[0].var_0116 + (0, 0, -32);
    var_0D = bulletTrace(var_0B, var_0C, 0, undefined);
    var_0E = vectortoangles(var_0D["normal"]);
    self.var_15F9 = anglesToForward(var_0E);
    self.var_15FB = anglestoright(var_0E);
    self.var_15FA = var_0D["position"];
    if(level.var_3FDC == "dom") {
      maps\mp\gametypes\dom::func_A192();
    }
  }
}

func_86B5(param_00) {
  self.var_59E8 = param_00;
}

func_2956() {
  var_00 = self getcurrentprimaryweapon();
  if(maps\mp\_utility::func_5740(var_00) && !issubstr(var_00, "turrethead") && var_00 != "flamethrower_mp" && var_00 != "flamethrower_german_mp" && var_00 != "flamethrower_grenadier_mp" && var_00 != "flamethrower_german_grenadier_mp" && var_00 != "killstreak_molotov_cocktail_mp" && var_00 != "killstreak_molotov_cocktail_grenadier_mp" && var_00 != "teslagun_war_moon_mp") {
    return 1;
  }

  return 0;
}

func_A227() {
  level endon("game_ended");
  self endon("deleted");
  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    if(!maps\mp\_utility::func_57A0(var_00)) {
      continue;
    }

    if(!func_1F53(var_00.var_012C["team"])) {
      continue;
    }

    if(!var_00 isonground()) {
      continue;
    }

    if(var_00 method_851C()) {
      continue;
    }

    if(var_00 func_2956()) {
      continue;
    }

    if(!func_21CA(var_00)) {
      if(isDefined(self.var_6AC9)) {
        self[[self.var_6AC9]](var_00);
      }

      continue;
    }

    if(isDefined(self.var_1F84) && ![[self.var_1F84]](var_00)) {
      continue;
    }

    if(!var_00 common_scripts\utility::func_5851()) {
      continue;
    }

    var_01 = 1;
    var_02 = self.var_A23F;
    if(isDefined(self.var_6E79)) {
      var_02 = self.var_6E79.var_A23F;
    }

    if(var_02 > 0) {
      if(isDefined(self.var_6ABC)) {
        self[[self.var_6ABC]](var_00);
      }

      if(isDefined(self.var_6E79) && isDefined(self.var_6E79.var_6ABC)) {
        self.var_6E79[[self.var_6E79.var_6ABC]](var_00);
      }

      if(!isDefined(self.var_59E8)) {
        thread func_1F78();
      }

      var_03 = var_00.var_012C["team"];
      var_01 = func_A213(var_00);
      self notify("finished_use");
      if(isDefined(self.var_6AFA)) {
        self[[self.var_6AFA]](var_03, var_00, var_01);
      }

      if(isDefined(self.var_6E79) && isDefined(self.var_6E79.var_6AFA)) {
        self.var_6E79[[self.var_6E79.var_6AFA]](var_03, var_00, var_01);
      }
    }

    if(!var_01) {
      continue;
    }

    if(isDefined(self.var_6BBF)) {
      self[[self.var_6BBF]](var_00);
    }

    if(isDefined(self.var_6E79) && isDefined(self.var_6E79.var_6BBF)) {
      self.var_6E79[[self.var_6E79.var_6BBF]](var_00);
    }
  }
}

func_21CA(param_00) {
  if(!isDefined(self.var_59E8)) {
    return 1;
  }

  if(!isDefined(param_00.var_2016)) {
    return 0;
  }

  var_01 = self.var_59E8;
  if(!isarray(var_01)) {
    var_01 = [var_01];
  }

  foreach(var_03 in var_01) {
    if(var_03 == param_00.var_2016) {
      return 1;
    }
  }

  return 0;
}

func_1F78() {
  level endon("game_ended");
  self endon("deleted");
  self endon("finished_use");
  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    if(!maps\mp\_utility::func_57A0(var_00)) {
      continue;
    }

    if(!func_1F53(var_00.var_012C["team"])) {
      continue;
    }

    if(isDefined(self.var_6AC9)) {
      self[[self.var_6AC9]](var_00);
    }
  }
}

func_44AF() {
  var_00 = self.var_230F;
  if(maps\mp\_utility::func_57A0(self.var_230E)) {
    var_01 = self.var_230E;
  } else {
    var_01 = undefined;
  }

  if(self.var_9AC3[var_00].size > 0) {
    var_02 = undefined;
    var_03 = getarraykeys(self.var_9AC3[var_00]);
    for(var_04 = 0; var_04 < var_03.size; var_04++) {
      var_05 = self.var_9AC3[var_00][var_03[var_04]];
      if(maps\mp\_utility::func_57A0(var_05.var_721C) && !isDefined(var_02) || var_05.var_9309 < var_02) {
        var_01 = var_05.var_721C;
        var_02 = var_05.var_9309;
      }
    }
  }

  return var_01;
}

func_A225() {
  level endon("game_ended");
  self endon("deleted");
  thread func_779A();
  for(;;) {
    if(self.var_A23F && self.var_28D5 >= self.var_A23F) {
      if(!self.var_59DD) {
        self.var_28D5 = 0;
      }

      if(self.var_5107 || common_scripts\utility::func_562E(self.cancapwithoutclaim)) {
        var_00 = self.var_230E;
      } else {
        var_00 = func_44AF();
      }

      if(isDefined(self.var_6AFA)) {
        self[[self.var_6AFA]](func_445B(), var_00, isDefined(var_00));
      }

      if(isDefined(var_00) && isDefined(self.var_6BBF)) {
        self[[self.var_6BBF]](var_00);
      }

      if(!self.var_65BF) {
        func_864E("none");
        self.var_230E = undefined;
      }
    }

    if(self.var_230F != "none") {
      if(self.var_A23F && !self.var_65BF || func_45F7() != func_445B()) {
        if(!self.var_689F[self.var_230F] || func_5108() || common_scripts\utility::func_562E(self.var_A414) && isDefined(self.var_1F84) && ![[self.var_1F84]](self.var_230E)) {
          if(isDefined(self.var_6AFA)) {
            self[[self.var_6AFA]](func_445B(), self.var_230E, 0);
          }

          func_864E("none");
          if(!common_scripts\utility::func_562E(self.cancapwithoutclaim)) {
            self.var_230E = undefined;
          }
        } else {
          self.var_28D5 = self.var_28D5 + 50 * self.var_A22B;
          if(self.var_28D5 <= 0) {
            self.var_28D5 = self.var_28D5 * -1;
            self.var_5B82 = self.var_230F;
            func_A18F();
          }

          if(isDefined(self.var_6BCB)) {
            self[[self.var_6BCB]](func_445B(), self.var_28D5 / self.var_A23F, 50 * self.var_A22B / self.var_A23F);
          }
        }
      } else if(!self.var_65BF) {
        if(isDefined(self.var_6BBF)) {
          self[[self.var_6BBF]](self.var_230E);
        }

        if(!self.var_65BF) {
          func_864E("none");
          if(!common_scripts\utility::func_562E(self.cancapwithoutclaim)) {
            self.var_230E = undefined;
          }
        }
      } else if(!self.var_689F[self.var_230F]) {
        if(isDefined(self.var_6BBD)) {
          self[[self.var_6BBD]]();
        }

        func_864E("none");
        if(!common_scripts\utility::func_562E(self.cancapwithoutclaim)) {
          self.var_230E = undefined;
        }
      } else if(self.var_1F49) {
        var_01 = func_45CB(self.var_230F);
        if(var_01 > 0) {
          if(isDefined(self.var_6AD0)) {
            self[[self.var_6AD0]]();
          }

          func_864E("none");
          if(!common_scripts\utility::func_562E(self.cancapwithoutclaim)) {
            self.var_230E = undefined;
          }
        }
      }
    } else if(self.var_65BF && func_45F7() != "none") {
      if(!self.var_689F[func_45F7()]) {
        if(isDefined(self.var_6BBD)) {
          self[[self.var_6BBD]]();
        }
      } else if(self.var_1F49 && self.var_5B82 != "none" && self.var_689F[self.var_5B82]) {
        var_01 = func_45CB(self.var_5B82);
        if(var_01 == 0) {
          if(isDefined(self.var_6BBB)) {
            self[[self.var_6BBB]](self.var_5B82);
          }
        }
      }
    }

    wait 0.05;
    maps\mp\gametypes\_hostmigration::func_A782();
  }
}

func_1F47(param_00) {
  if(isDefined(self.var_2006)) {
    return 0;
  }

  if(self.var_5107 && !func_5108()) {
    return 0;
  }

  if(self.var_1F49) {
    var_01 = func_45CB(param_00.var_012C["team"]);
    if(var_01 != 0) {
      return 0;
    }
  }

  if(func_21CA(param_00)) {
    return 1;
  }

  return 0;
}

func_779A() {
  level endon("game_ended");
  self endon("deleted");
  var_00 = self.var_37D8;
  for(;;) {
    if(!isDefined(self) | !isDefined(self.var_9D65)) {
      return;
    }

    self.var_9D65 waittill("trigger", var_01);
    if(!maps\mp\_utility::func_57A0(var_01)) {
      continue;
    }

    if(!maps\mp\_utility::func_56FF(var_01)) {
      continue;
    }

    if(!self.var_9D65 method_8691(var_01)) {
      continue;
    }

    if(isDefined(self.var_2006)) {
      continue;
    }

    if(var_01 maps\mp\_utility::func_581D() || isDefined(var_01.var_9071) || var_01 maps\mp\_utility::func_572D()) {
      continue;
    }

    if(isDefined(var_01.var_003A) && var_01.var_003A == "script_vehicle") {
      continue;
    }

    if(!isDefined(var_01.var_52F8)) {
      continue;
    }

    if(isDefined(self.var_66D5) && self.var_66D5 > gettime()) {
      continue;
    }

    if(isDefined(self.var_1F84) && ![[self.var_1F84]](var_01)) {
      continue;
    }

    if(func_1F53(var_01.var_012C["team"], var_01) && self.var_230F == "none") {
      if(func_1F47(var_01)) {
        if(common_scripts\utility::func_562E(self.var_7D25)) {
          if(isDefined(self.var_1F6A)) {
            var_02 = self[[self.var_1F6A]](var_01, self.var_A582);
          } else {
            var_02 = func_7799(var_01, self.var_A582);
          }

          if(!var_02) {
            continue;
          }
        }

        if(common_scripts\utility::func_562E(self.requirescontinuouslos) && isDefined(self.var_1F6A) && !self[[self.var_1F6A]](var_01, self.var_A582)) {
          continue;
        }

        if(self.var_5107 && !isDefined(self.var_5B81) || var_01 != self.var_5B81) {
          self.var_28D5 = 0;
        }

        func_864E(var_01.var_012C["team"]);
        self.var_230E = var_01;
        if(self.var_5107) {
          self.var_5B81 = var_01;
        }

        var_03 = func_4663(var_01.var_012C["team"]);
        if(isDefined(self.var_986E[var_03])) {
          self.var_A23F = self.var_986E[var_03];
        }

        if(self.var_A23F && isDefined(self.var_6ABC)) {
          self[[self.var_6ABC]](self.var_230E);
        }
      } else if(isDefined(self.var_6AC9)) {
        self[[self.var_6AC9]](var_01);
      }
    }

    if(maps\mp\_utility::func_57A0(var_01) && !isDefined(var_01.var_9AC5[var_00])) {
      var_01 thread func_9DC3(self);
    }
  }
}

func_7799(param_00, param_01) {
  var_02 = [32, 16, 0];
  var_03 = undefined;
  if(isDefined(param_01) && param_01.size) {
    if(param_01.size > 1 && !issubstr(level.var_3FDC, "ctf")) {}

    var_03 = param_01[0];
  }

  var_04 = param_00.var_0116 - self.var_9D65.var_0116;
  var_04 = (var_04[0], var_04[1], 0);
  var_04 = vectornormalize(var_04);
  var_04 = var_04 * 5;
  foreach(var_06 in var_02) {
    var_07 = param_00 getEye();
    var_08 = self.var_9D65.var_0116 + var_04 + (0, 0, var_06);
    var_09 = bulletTrace(var_07, var_08, 0, var_03, 0, 0, 0, 0, 1, 0, 0);
    if(var_09["fraction"] == 1) {
      return 1;
    }
  }

  return 0;
}

func_864E(param_00) {
  if(!common_scripts\utility::func_562E(self.cancapwithoutclaim)) {}

  if(self.var_59DD) {
    if(self.var_5B82 == "none") {
      self.var_5B82 = param_00;
    }

    self.var_230F = param_00;
  } else {
    if(self.var_230F == "none" && gettime() - self.var_5B83 > 1000) {
      self.var_28D5 = 0;
    } else if(param_00 != "none" && param_00 != self.var_5B82) {
      self.var_28D5 = 0;
    }

    self.var_5B82 = self.var_230F;
  }

  self.var_5B83 = gettime();
  self.var_230F = param_00;
  func_A18F();
}

func_445B() {
  return self.var_230F;
}

func_9DC3(param_00) {
  param_00 endon("death");
  var_01 = self.var_012C["team"];
  param_00.var_689F[var_01]++;
  var_02 = self.var_48CA;
  var_03 = spawnStruct();
  var_03.var_721C = self;
  var_03.var_9309 = gettime();
  param_00.var_9AC3[var_01][var_02] = var_03;
  if(isDefined(param_00.var_6BB8)) {
    param_00[[param_00.var_6BB8]](self);
  }

  if(!isDefined(param_00.var_681A)) {
    param_00.var_681A = 0;
  }

  self.var_9AC5[param_00.var_37D8] = param_00.var_9D65;
  if(isDefined(level.var_3FCF)) {
    self[[level.var_3FCF]](param_00);
  }

  param_00 func_A18F();
  while(maps\mp\_utility::func_57A0(self) && isDefined(param_00.var_9D65) && self istouching(param_00.var_9D65) && !level.var_3F9D) {
    if(common_scripts\utility::func_562E(param_00.requirescontinuouslos) && isDefined(param_00.var_1F6A) && !param_00[[param_00.var_1F6A]](self, param_00.var_A582)) {
      break;
    }

    if(isPlayer(self) && param_00.var_A23F) {
      func_A18A(param_00, 1);
      if(isDefined(level.var_3FCE)) {
        self[[level.var_3FCE]](param_00, 0);
        continue;
      }

      func_A156(param_00, 0);
    }

    wait 0.05;
  }

  if(isDefined(self) && isDefined(self.var_9AC5)) {
    if(isPlayer(self) && param_00.var_A23F) {
      func_A18A(param_00, 0);
      if(isDefined(level.var_3FCE)) {
        self[[level.var_3FCE]](param_00, 1);
      } else {
        func_A156(param_00, 1);
      }
    }

    self.var_9AC5[param_00.var_37D8] = undefined;
    if(isDefined(param_00.var_6BB9)) {
      param_00[[param_00.var_6BB9]](self);
    }
  }

  if(level.var_3F9D) {
    return;
  }

  param_00.var_9AC3[var_01][var_02] = undefined;
  param_00.var_689F[var_01]--;
  param_00 func_A18F();
  if(isDefined(level.var_3FD0)) {
    self[[level.var_3FD0]](param_00);
  }
}

func_A156(param_00, param_01) {
  var_02 = self.var_012C["team"];
  if(param_01 || !param_00 func_1F53(var_02) || var_02 != param_00.var_230F || param_00.var_681A) {
    if(isDefined(self.var_7794)) {
      self.var_7794 maps\mp\gametypes\_hud_util::func_4D06();
    }

    if(isDefined(self.var_7795)) {
      self.var_7795 maps\mp\gametypes\_hud_util::func_4D06();
    }

    return;
  }

  if(!isDefined(self.var_7794)) {
    self.var_7794 = maps\mp\gametypes\_hud_util::func_2821();
    self.var_7794.var_5C0C = undefined;
    self.var_7794.var_5BAA = 0;
  }

  if(self.var_7794.var_4CC7) {
    self.var_7794 maps\mp\gametypes\_hud_util::func_8BF6();
    self.var_7794.var_5C0C = undefined;
    self.var_7794.var_5BAA = 0;
  }

  if(!isDefined(self.var_7795)) {
    self.var_7795 = maps\mp\gametypes\_hud_util::func_2822();
    var_03 = param_00 func_4663(var_02);
    if(isDefined(param_00.var_986D[var_03])) {
      self.var_7795 settext(param_00.var_986D[var_03]);
    } else {
      self.var_7795 settext(param_00.var_A23D);
    }
  }

  if(self.var_7795.var_4CC7) {
    self.var_7795 maps\mp\gametypes\_hud_util::func_8BF6();
    var_03 = param_01 func_4663(var_03);
    if(isDefined(param_00.var_986D[var_03])) {
      self.var_7795 settext(param_00.var_986D[var_03]);
    } else {
      self.var_7795 settext(param_00.var_A23D);
    }
  }

  if(!isDefined(self.var_7794.var_5C0C) || self.var_7794.var_5C0C != param_01.var_A22B || self.var_7794.var_5BAA != isDefined(level.var_4E09)) {
    if(param_01.var_28D5 > param_01.var_A23F) {
      param_01.var_28D5 = param_01.var_A23F;
    }

    var_04 = param_01.var_28D5 / param_01.var_A23F;
    var_05 = 1000 / param_01.var_A23F * param_01.var_A22B;
    if(isDefined(level.var_4E09)) {
      var_05 = 0;
    }

    if(param_01.var_59DD && !var_04 && var_05 < 0) {
      var_05 = 0;
    }

    self.var_7794 maps\mp\gametypes\_hud_util::func_A0E3(var_04, var_05);
    self.var_7794.var_5C0C = param_01.var_A22B;
    self.var_7794.var_5BAA = isDefined(level.var_4E09);
  }
}

func_45CB(param_00) {
  return self.var_689F[maps\mp\_utility::func_45DE(param_00)];
}

func_A18A(param_00, param_01) {
  var_02 = level.var_3FDC;
  var_03 = param_00.var_502A;
  if(!isDefined(level.var_4E09)) {
    if(param_00.var_28D5 > param_00.var_A23F) {
      param_00.var_28D5 = param_00.var_A23F;
    }

    var_04 = param_00.var_28D5 / param_00.var_A23F;
    if((var_02 == "dom" || var_02 == "assault" || var_02 == "control") && isDefined(var_03) && var_03 == "domFlag") {
      if(!param_01 || param_00.var_6DB2 == self.var_01A7 || param_00.var_230F != self.var_01A7) {
        var_04 = 0.01;
      }

      if(var_04 != 0) {
        self setclientomnvar("ui_capture_progress", var_04);
      }
    }

    var_05 = var_02 == "sd";
    if((var_05 || var_02 == "assault" || var_02 == "control" || var_02 == "sr" || var_02 == "demo") && isDefined(var_03) && var_03 == "bombZone" || var_03 == "defuseObject") {
      if(!param_01) {
        var_04 = 0;
      }

      var_04 = max(0.01, var_04);
      if(var_04 != 0) {
        self setclientomnvar("ui_capture_progress", var_04);
      }

      if(var_05) {
        self setclientomnvar("ui_capture_progress_global", var_04);
      }
    }

    if(isDefined(var_03) && var_02 == "twar" && var_03 == "twarZone") {
      if(!param_01) {
        var_04 = 0;
      }

      var_04 = max(0.01, var_04);
      if(var_04 != 0) {
        self setclientomnvar("ui_capture_progress", var_04);
      }
    }

    if(isDefined(var_03) && var_02 == "raid") {
      if(var_03 == "raidZoneCaptureHP" || var_03 == "raidZoneCaptureDom" || var_03 == "raidZoneCaptureTwar" || var_03 == "raidConstruct" || var_03 == "raidRepair" || var_03 == "raidPlantExplosive" || var_03 == "raidDefuseExplosive") {
        if(!param_01) {
          var_04 = 0;
        }

        var_04 = max(0.01, var_04);
        if(var_04 != 0) {
          self setclientomnvar("ui_capture_progress", var_04);
        }
      }
    }

    if(var_02 == "zombies" && isDefined(var_03) && var_03 == "defuseObject") {
      if(!param_01) {
        var_04 = 0;
      }

      var_04 = max(0.01, var_04);
      if(var_04 != 0) {
        self setclientomnvar("ui_capture_progress", var_04);
      }
    }
  }

  if((var_02 == "dom" || var_02 == "assault" || var_02 == "control") && isDefined(var_03) && var_03 == "domFlag") {
    if(param_01 && isDefined(param_00.var_915C) && param_00.var_915C) {
      if(param_00.var_00E5 == "_a") {
        self setclientomnvar("ui_capture_icon", 4);
      } else if(param_00.var_00E5 == "_b") {
        self setclientomnvar("ui_capture_icon", 5);
      } else if(param_00.var_00E5 == "_c") {
        self setclientomnvar("ui_capture_icon", 6);
      }

      self setclientomnvar("ui_capture_status_index", 2);
    } else if(param_01 && param_00.var_6DB2 == "neutral") {
      if(param_00.var_00E5 == "_a") {
        self setclientomnvar("ui_capture_icon", 7);
      } else if(param_00.var_00E5 == "_b") {
        self setclientomnvar("ui_capture_icon", 8);
      } else if(param_00.var_00E5 == "_c") {
        self setclientomnvar("ui_capture_icon", 9);
      }

      self setclientomnvar("ui_capture_status_index", 1);
    } else if(param_01 && param_00.var_6DB2 != self.var_01A7) {
      if(param_00.var_00E5 == "_a") {
        self setclientomnvar("ui_capture_icon", 1);
      } else if(param_00.var_00E5 == "_b") {
        self setclientomnvar("ui_capture_icon", 2);
      } else if(param_00.var_00E5 == "_c") {
        self setclientomnvar("ui_capture_icon", 3);
      }

      self setclientomnvar("ui_capture_status_index", 1);
    } else {
      self setclientomnvar("ui_capture_icon", 0);
      self setclientomnvar("ui_capture_status_index", 0);
    }
  }

  if((var_02 == "sd" || var_02 == "sr" || var_02 == "demo") && isDefined(var_03) && var_03 == "bombZone" || var_03 == "defuseObject") {
    if(!param_01) {
      self setclientomnvar("ui_capture_icon", 0);
    } else if(param_00 func_56FB(self.var_012C["team"])) {
      self setclientomnvar("ui_capture_icon", 2);
    } else {
      self setclientomnvar("ui_capture_icon", 1);
    }
  }

  if(isDefined(var_03) && var_02 == "twar" && var_03 == "twarZone") {
    if(!param_01 || isDefined(param_00.var_915C) && param_00.var_915C) {
      self setclientomnvar("ui_capture_icon", 0);
    } else {
      self setclientomnvar("ui_capture_icon", 1);
    }
  }

  if(var_02 == "raid" && isDefined(var_03)) {
    if(param_01) {
      if(var_03 == "raidZoneCaptureHP") {
        if(common_scripts\utility::func_562E(param_00.var_4D04)) {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        } else if(common_scripts\utility::func_562E(param_00.var_915C)) {
          self setclientomnvar("ui_capture_status_index", 2);
          self setclientomnvar("ui_capture_icon", 2);
        } else if(param_00 func_1F53(self.var_012C["team"]) && self.var_012C["team"] == param_00.var_230F) {
          self setclientomnvar("ui_capture_status_index", 1);
          self setclientomnvar("ui_capture_icon", 1);
        } else {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        }
      } else if(var_03 == "raidZoneCaptureDom") {
        if(common_scripts\utility::func_562E(param_00.var_915C)) {
          self setclientomnvar("ui_capture_status_index", 2);
          self setclientomnvar("ui_capture_icon", 2);
        } else if(param_00.var_6DB2 == "neutral" || param_00.var_6DB2 != self.var_01A7) {
          self setclientomnvar("ui_capture_status_index", 1);
          self setclientomnvar("ui_capture_icon", 1);
        } else {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        }
      } else if(var_03 == "raidZoneCaptureTwar") {
        if(param_00.var_28D5 < param_00.var_A23F || param_00.var_230F != "none") {
          if(!common_scripts\utility::func_562E(param_00.var_915C)) {
            if(param_00.var_5B82 == "neutral" || param_00.var_5B82 == self.var_01A7) {
              self setclientomnvar("ui_capture_status_index", 1);
              self setclientomnvar("ui_capture_icon", 1);
            } else {
              self setclientomnvar("ui_capture_status_index", 3);
              self setclientomnvar("ui_capture_icon", 3);
            }
          } else {
            self setclientomnvar("ui_capture_status_index", 2);
            self setclientomnvar("ui_capture_icon", 2);
          }
        } else {
          self setclientomnvar("ui_capture_icon", 0);
          self setclientomnvar("ui_capture_status_index", 0);
        }
      } else if(var_03 == "raidConstruct") {
        self setclientomnvar("ui_capture_status_index", 4);
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_03 == "raidRepair") {
        self setclientomnvar("ui_capture_status_index", 5);
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_03 == "raidPlantExplosive") {
        self setclientomnvar("ui_capture_status_index", 6);
        self setclientomnvar("ui_capture_icon", 1);
      } else if(var_03 == "raidDefuseExplosive") {
        self setclientomnvar("ui_capture_status_index", 7);
        self setclientomnvar("ui_capture_icon", 1);
      }
    } else {
      self setclientomnvar("ui_capture_icon", 0);
      self setclientomnvar("ui_capture_status_index", 0);
    }
  }

  if(var_02 == "zombies" && isDefined(var_03) && var_03 == "defuseObject") {
    if(!param_01) {
      self setclientomnvar("ui_capture_icon", 0);
      return;
    }

    self setclientomnvar("ui_capture_icon", 1);
  }
}

func_A18F() {
  if(isDefined(self.var_6BBE)) {
    self[[self.var_6BBE]]();
    return;
  }

  func_A190();
}

func_A190() {
  var_00 = self.var_689F[self.var_230F];
  var_01 = 0;
  var_02 = 0;
  if(level.var_6520) {
    foreach(var_04 in level.var_985B) {
      if(self.var_230F != var_04) {
        var_01 = var_01 + self.var_689F[var_04];
      }
    }
  } else {
    if(self.var_230F != "axis") {
      var_01 = var_01 + self.var_689F["axis"];
    }

    if(self.var_230F != "allies") {
      var_01 = var_01 + self.var_689F["allies"];
    }
  }

  foreach(var_07 in self.var_9AC3[self.var_230F]) {
    if(!isDefined(var_07.var_721C)) {
      continue;
    }

    if(var_07.var_721C.var_012C["team"] != self.var_230F) {
      continue;
    }

    if(var_07.var_721C.var_696D == 1) {
      continue;
    }

    if(level.var_3FDC == "hp") {
      continue;
    }

    if(isDefined(self.var_502A) && self.var_502A == "raidEscortTrigger") {
      continue;
    }

    var_00 = var_00 * var_07.var_721C.var_696D;
    var_02 = var_07.var_721C.var_696D;
  }

  self.var_A22B = 0;
  self.var_915C = var_00 && var_01;
  if(var_00 && !var_01) {
    self.var_A22B = min(var_00, 4);
  }

  if(isDefined(self.var_5676) && self.var_5676 && var_02 != 0) {
    self.var_A22B = 1 * var_02;
  } else if(isDefined(self.var_5676) && self.var_5676) {
    self.var_A22B = 1;
  }

  if(self.var_59DD && self.var_5B82 != self.var_230F) {
    self.var_A22B = self.var_A22B * -1;
  }
}

func_115B() {
  self endon("death");
  self endon("disconnect");
  self endon("done_using");
  wait(0.7);
  self attach("npc_gen_s_and_d_bomb", "tag_inhand", 1);
  self.var_1147 = "npc_gen_s_and_d_bomb";
}

func_9BA8() {
  thread func_2383();
  level endon("game_ended");
  level endon("zone_moved");
  for(;;) {
    foreach(var_01 in level.var_744A) {
      if(var_01 istouching(self.var_9D65)) {
        var_01 setgametypevip(1);
        continue;
      }

      var_01 setgametypevip(0);
    }

    wait(0.5);
  }
}

func_2383() {
  level common_scripts\utility::func_A70A("game_ended", "zone_moved");
  foreach(var_01 in level.var_744A) {
    var_01 setgametypevip(0);
  }
}

func_A213(param_00) {
  param_00 notify("use_hold");
  if(common_scripts\utility::func_562E(self.var_2F90)) {
    param_00 allowmovement(0);
    param_00 method_8324();
  } else if(isPlayer(param_00)) {
    param_00 playerlinkto(self.var_9D65);
  } else {
    param_00 linkto(self.var_9D65);
  }

  param_00 clientclaimtrigger(self.var_9D65);
  param_00.var_2310 = self.var_9D65;
  var_01 = self.var_A248;
  var_02 = param_00 getcurrentweapon();
  if(isDefined(param_00.var_201C) && maps\mp\gametypes\_division_change::func_574C(var_02)) {
    var_02 = param_00.var_201C;
  }

  if(maps\mp\killstreaks\_killstreaks::doeskillstreakweaponstowammo(var_02)) {
    var_03 = param_00 getweaponammoclip(var_02);
    var_04 = param_00 getweaponammostock(var_02);
    if(var_03 + var_04 <= 0) {
      var_02 = param_00.var_8061;
    }
  }

  if(isDefined(var_01)) {
    if(maps\mp\_utility::isuseweapon(var_02)) {
      var_02 = param_00.var_5BC5;
    }

    param_00.var_5BC5 = var_02;
    param_00 maps\mp\_utility::func_0642(var_01);
    param_00 method_8324();
    param_00 setweaponammostock(var_01, 0);
    param_00 method_82FA(var_01, 0);
    param_00 switchtoweapon(var_01);
    param_00.hasuseweapon = 1;
    if(!isDefined(self.var_113F) || self.var_113F == 1) {
      param_00 thread func_115B();
    }
  } else {
    param_00 common_scripts\utility::func_0602();
  }

  var_05 = param_00 getentitynumber();
  if(isDefined(self.var_6E79)) {
    if(!self.var_6E79.var_5F95 && self.var_6E79.var_54F6.size == 0) {
      self.var_6E79.var_28D5 = 0;
    }

    self.var_54F5 = 1;
    self.var_6E79.var_54F6[var_05] = 1;
    self.var_6E79.var_A22B[var_05] = 0;
    if(isPlayer(param_00)) {
      if(isDefined(level.var_3FD1)) {
        param_00 thread[[level.var_3FD1]](self.var_6E79);
      } else {
        param_00 thread func_6F82(self.var_6E79);
      }
    }
  } else {
    if(!self.var_5F95) {
      self.var_28D5 = 0;
    }

    self.var_54F5 = 1;
    self.var_A22B = 0;
    if(isPlayer(param_00)) {
      if(isDefined(level.var_3FD1)) {
        param_00 thread[[level.var_3FD1]](self);
      } else {
        param_00 thread func_6F82(self);
      }
    }
  }

  var_06 = func_A214(param_00, var_02);
  if(isDefined(param_00)) {
    param_00 func_2E46();
    param_00 notify("done_using");
  }

  if(isDefined(var_01) && isDefined(param_00)) {
    param_00 thread func_95F5(var_01);
  }

  if(isDefined(var_06) && var_06) {
    return 1;
  }

  if(isDefined(param_00)) {
    param_00.var_2310 = undefined;
    if(isDefined(var_01)) {
      param_00.hasuseweapon = undefined;
      if(var_02 != "none") {
        if(common_scripts\utility::func_562E(self.var_7894)) {
          param_00 maps\mp\_utility::func_955D(var_02);
        } else {
          param_00 maps\mp\_utility::func_955C(var_02);
        }
      } else {
        param_00 takeweapon(var_01);
      }
    } else {
      param_00 common_scripts\utility::func_0616();
    }

    if(common_scripts\utility::func_562E(self.var_2F90)) {
      param_00 allowmovement(1);
    } else {
      param_00 unlink();
    }

    if(!maps\mp\_utility::func_57A0(param_00)) {
      param_00.var_5A3E = 1;
    }
  }

  self.var_54F5 = 0;
  if(isDefined(self.var_6E79)) {
    self.var_6E79.var_54F6[var_05] = undefined;
    self.var_6E79.var_A22B[var_05] = 0;
  }

  self.var_9D65 releaseclaimedtrigger();
  return 0;
}

func_2E46() {
  if(isDefined(self.var_1147)) {
    self method_802E(self.var_1147, "tag_inhand");
    self.var_1147 = undefined;
  }
}

func_95F5(param_00) {
  self endon("use_hold");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(self getcurrentweapon() == param_00 && !isDefined(self.var_99AC)) {
    wait 0.05;
  }

  self method_8325();
  self takeweapon(param_00);
}

func_A23B(param_00, param_01, param_02, param_03) {
  if(!maps\mp\_utility::func_57A0(param_00)) {
    return 0;
  }

  if(!param_00 istouching(self.var_9D65)) {
    return 0;
  }

  if(!param_00 useButtonPressed()) {
    return 0;
  }

  if(isDefined(param_00.var_99AC)) {
    return 0;
  }

  if(isDefined(self.var_6E79)) {
    if(self.var_6E79.var_A23C && param_00 meleeButtonPressed()) {
      return 0;
    }

    if(self.var_6E79.var_28D5 >= self.var_6E79.var_A23F) {
      return 0;
    }

    if(!func_45D4(self.var_6E79) && !param_01) {
      return 0;
    }
  } else {
    if(self.var_A23C && param_00 meleeButtonPressed()) {
      return 0;
    }

    if(self.var_28D5 >= self.var_A23F) {
      return 0;
    }

    if(!self.var_A22B && !param_01) {
      return 0;
    }
  }

  if(param_01 && param_02 > param_03) {
    return 0;
  }

  return 1;
}

func_A214(param_00, param_01) {
  level endon("game_ended");
  self endon("disabled");
  param_00 endon("stop_useHoldThinkLoop");
  var_02 = self.var_A248;
  var_03 = 1;
  var_04 = 0;
  var_05 = 1.5;
  var_06 = param_00 getentitynumber();
  var_07 = param_00.var_696D;
  while(func_A23B(param_00, var_03, var_04, var_05)) {
    var_04 = var_04 + 0.05;
    if(!isDefined(var_02) || param_00 getcurrentweapon() == var_02) {
      if(isDefined(self.var_6E79)) {
        if(isDefined(self.var_6E79.var_695A) && issubstr(self.var_6E79.var_695A, "bridge_")) {
          var_07 = 1;
        }

        self.var_6E79.var_28D5 = self.var_6E79.var_28D5 + 50 * self.var_6E79.var_A22B[var_06];
        self.var_6E79.var_A22B[var_06] = 1 * var_07;
        if(isDefined(self.var_6E79.var_A22C)) {
          self.var_6E79.var_A22B[var_06] = self.var_6E79.var_A22B[var_06] * self[[self.var_6E79.var_A22C]](param_00);
        }

        if(var_03 && isDefined(self.var_6E79.var_A212)) {
          self.var_6E79[[self.var_6E79.var_A212]](param_00);
        }
      } else {
        if(isDefined(self.var_502A)) {
          if(issubstr(self.var_502A, "raidZoneCaptureTwar")) {
            var_07 = 1;
          }

          if(isDefined(self.var_695A) && (issubstr(self.var_695A, "gun_") || issubstr(self.var_695A, "bomb_") || issubstr(self.var_695A, "town_bombplant")) && issubstr(self.var_502A, "raidDefuseExplosive") || issubstr(self.var_502A, "raidPlantExplosive")) {
            var_07 = 1;
          }
        }

        if(isDefined(self.var_A248)) {
          if(self.var_A248 == "war_generic_open_mp") {
            var_07 = 1;
          }
        }

        if(isDefined(self.var_695A)) {
          if(issubstr(self.var_695A, "hostage_")) {
            var_07 = 1;
          }
        }

        self.var_28D5 = self.var_28D5 + 50 * self.var_A22B;
        self.var_A22B = 1 * var_07;
        if(var_03 && isDefined(self.var_A212)) {
          self[[self.var_A212]](param_00);
        }
      }

      var_03 = 0;
    } else if(isDefined(self.var_6E79)) {
      self.var_6E79.var_A22B[var_06] = 0;
    } else {
      self.var_A22B = 0;
    }

    if(isDefined(self.var_6E79)) {
      var_08 = self.var_6E79.var_28D5 >= self.var_6E79.var_A23F;
    } else {
      var_08 = self.var_28D5 >= self.var_A23F;
    }

    if(var_08) {
      if(isDefined(self.var_6E79)) {
        self.var_6E79.var_54F6 = [];
      }

      self.var_54F5 = 0;
      param_00 clientreleasetrigger(self.var_9D65);
      param_00.var_2310 = undefined;
      if(isDefined(var_02)) {
        param_00 setweaponammostock(var_02, 1);
        param_00 method_82FA(var_02, 1);
        param_00.hasuseweapon = undefined;
        if(param_01 != "none") {
          param_00 maps\mp\_utility::func_955C(param_01);
        } else {
          param_00 takeweapon(var_02);
        }
      } else {
        param_00 common_scripts\utility::func_0616();
      }

      if(common_scripts\utility::func_562E(self.var_2F90)) {
        param_00 allowmovement(1);
      } else {
        param_00 unlink();
      }

      return maps\mp\_utility::func_57A0(param_00);
    }

    wait 0.05;
    maps\mp\gametypes\_hostmigration::func_A782();
  }

  return 0;
}

func_A226(param_00) {
  var_01 = spawnStruct();
  foreach(var_03 in param_00) {
    var_03.var_6E79 = var_01;
    var_03.var_28D5 = undefined;
    var_03.var_A23F = undefined;
    var_03.var_A22B = undefined;
    var_03.var_5F95 = undefined;
  }

  var_01.var_576E = 1;
  var_01.var_28D5 = 0;
  var_01.var_A22B = [];
  var_01.var_5F95 = 0;
  var_01.var_21F7 = param_00;
  var_01.var_54F6 = [];
  var_01.var_A23C = 1;
  return var_01;
}

func_6F82(param_00) {
  self endon("disconnect");
  var_01 = undefined;
  if(!isDefined(param_00.var_681A) || !param_00.var_681A) {
    var_01 = maps\mp\gametypes\_hud_util::func_2821();
  }

  var_02 = undefined;
  if(isDefined(var_01) && isDefined(param_00.var_A23D)) {
    var_02 = maps\mp\gametypes\_hud_util::func_2822();
    var_02 settext(param_00.var_A23D);
  }

  var_03 = -1;
  var_04 = isDefined(level.var_4E09);
  while(maps\mp\_utility::func_57A0(self) && func_A224(param_00) && !level.var_3F9D) {
    if(var_03 != func_45D4(param_00) || var_04 != isDefined(level.var_4E09)) {
      if(param_00.var_28D5 > param_00.var_A23F) {
        param_00.var_28D5 = param_00.var_A23F;
      }

      var_05 = param_00.var_28D5 / param_00.var_A23F;
      var_06 = 1000 / param_00.var_A23F * func_45D4(param_00);
      if(isDefined(level.var_4E09)) {
        var_06 = 0;
      }

      if(isDefined(var_01)) {
        var_01 maps\mp\gametypes\_hud_util::func_A0E3(var_05, var_06);
        if(!func_45D4(param_00)) {
          var_01 maps\mp\gametypes\_hud_util::func_4D06();
          if(isDefined(var_02)) {
            var_02 maps\mp\gametypes\_hud_util::func_4D06();
          }
        } else {
          var_01 maps\mp\gametypes\_hud_util::func_8BF6();
          if(isDefined(var_02)) {
            var_02 maps\mp\gametypes\_hud_util::func_8BF6();
          }
        }
      }
    }

    var_05 = func_45D4(var_02);
    var_06 = isDefined(level.var_4E09);
    func_A18A(var_02, 1);
    wait 0.05;
  }

  func_A18A(param_00, 0);
  if(isDefined(var_01)) {
    var_01 maps\mp\gametypes\_hud_util::func_2DCC();
  }

  if(isDefined(var_02)) {
    var_02 maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

func_45D4(param_00) {
  if(common_scripts\utility::func_562E(param_00.var_576E)) {
    var_01 = 0;
    foreach(var_03 in param_00.var_A22B) {
      var_01 = var_01 + var_03;
    }

    return var_01;
  }

  return param_00.var_A22B;
}

func_A224(param_00) {
  if(common_scripts\utility::func_562E(param_00.var_576E)) {
    return isDefined(param_00.var_54F6[self getentitynumber()]);
  }

  return param_00.var_54F5;
}

func_A182() {
  if(self.var_9DC4 != "use") {
    return;
  }

  if(self.var_5412 == "none") {
    self.var_9D65.var_0116 = self.var_9D65.var_0116 - (0, 0, 50000);
    return;
  }

  if(self.var_5412 == "any") {
    self.var_9D65.var_0116 = self.var_28D4;
    self.var_9D65 setteamfortrigger("none");
    return;
  }

  if(self.var_5412 == "friendly") {
    self.var_9D65.var_0116 = self.var_28D4;
    if(self.var_6DB2 == "allies") {
      self.var_9D65 setteamfortrigger("allies");
      return;
    }

    if(self.var_6DB2 == "axis") {
      self.var_9D65 setteamfortrigger("axis");
      return;
    }

    self.var_9D65.var_0116 = self.var_9D65.var_0116 - (0, 0, 50000);
    return;
  }

  if(self.var_5412 == "enemy") {
    self.var_9D65.var_0116 = self.var_28D4;
    if(self.var_6DB2 == "allies") {
      self.var_9D65 setteamfortrigger("axis");
      return;
    }

    if(self.var_6DB2 == "axis") {
      self.var_9D65 setteamfortrigger("allies");
      return;
    }

    self.var_9D65 setteamfortrigger("none");
    return;
  }
}

func_86DF(param_00, param_01, param_02) {
  param_00.var_0056 = game["dvar_color_names"]["plaintext"];
  param_00.var_002A = game["dvar_color_names"][self.var_AA8B[param_02]];
  var_03 = func_471F(self.var_2562[param_02]);
  if(var_03 != "") {
    param_00.var_0175 = game["dvar_color_names"][var_03];
  }
}

func_A19B() {
  if(self.var_A560 == "any") {
    func_A19A("friendly", 1);
    func_A19A("enemy", 1);
  } else if(self.var_A560 == "friendly") {
    func_A19A("friendly", 1);
    func_A19A("enemy", 0);
  } else if(self.var_A560 == "enemy") {
    func_A19A("friendly", 0);
    func_A19A("enemy", 1);
  } else {
    func_A19A("friendly", 0);
    func_A19A("enemy", 0);
  }

  func_A19A("broadcaster", 1);
}

func_A19A(param_00, param_01) {
  if(!isDefined(self.var_AA8A[param_00])) {
    param_01 = 0;
  }

  var_02 = func_4708(param_00);
  var_03 = func_8BB2();
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_05 = "objpoint_" + var_02[var_04] + "_" + self.var_37D8;
    var_06 = maps\mp\gametypes\_objpoints::func_45D6(var_05);
    if(!isDefined(var_06)) {
      continue;
    }

    var_06 notify("stop_flashing_thread");
    var_06 thread maps\mp\gametypes\_objpoints::func_9401();
    if(param_01) {
      if(var_03) {
        var_06 setshader(func_471E(self.var_AA8A[param_00]), level.var_6998, level.var_6998);
      } else {
        var_06 setshader(self.var_AA8A[param_00], level.var_6998, level.var_6998, self.var_AA89[param_00]);
      }

      var_06 fadeovertime(0.05);
      var_06.var_0018 = var_06.var_15F3;
      var_06.var_57CB = 1;
      if(isDefined(self.var_2562[param_00])) {
        var_06 setwaypoint(1, 1, 0, 0, 0, 0, 0, 0, 0, 0, isDefined(self.var_356E) && self.var_356E);
      } else {
        var_06 setwaypoint(1, 0);
      }

      if(var_03) {
        func_86DF(var_06, var_02[var_04], param_00);
        var_06 setwaypointbackground(func_471D(self.var_AA8A[param_00]), func_4720(self.var_AA8A[param_00]));
      }

      if(self.var_01B9 == "carryObject") {
        if(isDefined(self.var_2006) && !func_8B9A(param_00)) {
          var_06 settargetent(self.var_2006);
        } else if(!isDefined(self.var_2006) && isDefined(self.var_695F) && self.var_695F) {
          var_06 settargetent(self.var_A582[0]);
        } else {
          var_06 cleartargetent();
        }
      }
    } else {
      var_06 fadeovertime(0.05);
      var_06.var_0018 = 0;
      var_06.var_57CB = 0;
      var_06 cleartargetent();
    }

    var_06 thread func_4D1C();
  }
}

func_4D1C() {
  self notify("hideWorldIconOnGameEnd");
  self endon("hideWorldIconOnGameEnd");
  self endon("death");
  level waittill("game_ended");
  if(isDefined(self)) {
    self.var_0018 = 0;
  }
}

func_A17A(param_00, param_01) {}

func_A0FE() {
  if(self.var_A560 == "any") {
    func_A0FD("friendly", 1);
    func_A0FD("enemy", 1);
  } else if(self.var_A560 == "friendly") {
    func_A0FD("friendly", 1);
    func_A0FD("enemy", 0);
  } else if(self.var_A560 == "enemy") {
    func_A0FD("friendly", 0);
    func_A0FD("enemy", 1);
  } else {
    func_A0FD("friendly", 0);
    func_A0FD("enemy", 0);
  }

  func_A0FD("broadcaster", 1);
}

func_446B(param_00) {
  var_01 = 0;
  if(isDefined(param_00)) {
    if(param_00 == "friendly") {
      var_01 = 1;
    } else if(param_00 == "enemy") {
      var_01 = 2;
    } else if(param_00 == "contest") {
      var_01 = 3;
    }
  }

  return var_01;
}

func_A142(param_00, param_01) {
  var_02 = self.var_AA8B[param_01];
  var_03 = func_446B(var_02);
  var_04 = func_471F(self.var_2562[param_01]);
  var_05 = func_446B(var_04);
  function_0370(param_00, var_03, var_05);
}

func_A0FD(param_00, param_01) {
  if(!isDefined(self.var_2562)) {
    return;
  }

  var_02 = func_4708(param_00);
  var_03 = func_8BB2();
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_05 = param_01;
    if(!var_05 && func_8BA7(var_02[var_04])) {
      var_05 = 1;
    }

    var_06 = self.var_698A;
    if(var_02[var_04] == "axis") {
      var_06 = self.var_698B;
    }

    if(var_02[var_04] == "broadcaster") {
      var_06 = self.var_698C;
    }

    if(!isDefined(self.var_2562[param_00]) || !var_05) {
      objective_state(var_06, "invisible");
      continue;
    }

    if(var_03) {
      var_07 = self.var_2562[param_00];
      function_01D1(var_06, func_471E(var_07));
      function_036F(var_06, func_471D(var_07), func_4720(var_07));
      func_A142(var_06, param_00);
    } else if(common_scripts\utility::func_562E(self.var_A200)) {
      function_01D1(var_06, self.var_2562[param_00], param_00);
    } else {
      function_01D1(var_06, self.var_2562[param_00]);
    }

    objective_state(var_06, "active");
    if(self.var_01B9 == "carryObject") {
      if(maps\mp\_utility::func_57A0(self.var_2006) && !func_8B9A(param_00)) {
        objective_onentity(var_06, self.var_2006);
        continue;
      }

      if(isDefined(self.var_695F) && self.var_695F) {
        objective_onentity(var_06, self.var_A582[0]);
        continue;
      }

      objective_position(var_06, self.var_28D4);
    }
  }
}

func_8B9A(param_00) {
  if(param_00 == "friendly" && self.var_6990) {
    return 1;
  } else if(param_00 == "enemy" && self.var_698F) {
    return 1;
  }

  return 0;
}

func_4708(param_00) {
  var_01 = [];
  if(param_00 == "friendly") {
    if(func_56FB("allies")) {
      var_01[var_01.size] = "allies";
    }

    if(func_56FB("axis")) {
      var_01[var_01.size] = "axis";
    }
  } else if(param_00 == "enemy") {
    if(!func_56FB("allies")) {
      var_01[var_01.size] = "allies";
    }

    if(!func_56FB("axis")) {
      var_01[var_01.size] = "axis";
    }
  } else if(param_00 == "broadcaster") {
    var_01[var_01.size] = "broadcaster";
  }

  return var_01;
}

func_8BA7(param_00) {
  if(param_00 == "broadcaster") {
    return 0;
  }

  if(!isDefined(self.var_2006)) {
    return 0;
  }

  if(self.var_2006 maps\mp\_utility::func_0649("specialty_radarimmune") || self.var_2006 maps\mp\_utility::func_0649("specialty_uavhidden")) {
    return 0;
  }

  return getteamradar(param_00);
}

func_A191() {
  self endon("death");
  self endon("carrier_cleared");
  for(;;) {
    level waittill("radar_status_change");
    func_A0FE();
  }
}

func_86EC(param_00) {
  self.var_6DB2 = param_00;
  func_A182();
  func_A0FE();
  func_A19B();
}

func_45F7() {
  return self.var_6DB2;
}

func_8A5A(param_00) {
  self.var_A23F = int(param_00 * 1000);
}

func_8A59(param_00) {
  self.var_A23D = param_00;
}

func_8740(param_00, param_01) {
  self.var_986E[param_00] = int(param_01 * 1000);
}

func_873F(param_00, param_01) {
  self.var_986D[param_00] = param_01;
}

func_8A57(param_00) {
  self.var_9D65 sethintstring(param_00);
}

func_0C1D(param_00) {
  self.var_5412 = param_00;
}

func_0C30(param_00) {
  self.var_5412 = param_00;
  func_A182();
}

func_8A60(param_00) {
  self.var_A560 = param_00;
  func_A0FE();
  func_A19B();
}

func_86CD(param_00) {
  if(param_00) {
    for(var_01 = 0; var_01 < self.var_A582.size; var_01++) {
      self.var_A582[var_01] method_805B();
      if(self.var_A582[var_01].var_003A == "script_brushmodel" || self.var_A582[var_01].var_003A == "script_model") {
        foreach(var_03 in level.var_744A) {
          if(var_03 istouching(self.var_A582[var_01])) {
            var_03 maps\mp\_utility::func_0728();
          }
        }

        self.var_A582[var_01] thread func_5FBB();
      }
    }

    return;
  }

  for(var_01 = 0; var_01 < self.var_A582.size; var_01++) {
    self.var_A582[var_01] method_805C();
    if(self.var_A582[var_01].var_003A == "script_brushmodel" || self.var_A582[var_01].var_003A == "script_model") {
      self.var_A582[var_01] notify("changing_solidness");
      self.var_A582[var_01] notsolid();
    }
  }
}

func_5FBB() {
  self endon("death");
  self notify("changing_solidness");
  self endon("changing_solidness");
  for(;;) {
    for(var_00 = 0; var_00 < level.var_744A.size; var_00++) {
      if(level.var_744A[var_00] istouching(self)) {
        break;
      }
    }

    if(var_00 == level.var_744A.size) {
      self solid();
      break;
    }

    wait 0.05;
  }
}

func_8644(param_00) {
  self.var_200B = param_00;
}

func_8640(param_00) {
  self.var_A23A = param_00;
}

func_446C(param_00) {
  if(param_00 == 1) {
    return "enemy";
  }

  if(param_00 == 2) {
    return "friendly";
  }

  if(param_00 == 3) {
    return "contest";
  }

  return "neutral";
}

func_860A(param_00, param_01, param_02, param_03) {
  self.var_2562[param_00] = param_01;
  self.var_A200 = param_02;
  if(func_8BB2()) {
    if(isDefined(param_03)) {
      self.var_AA8B[param_00] = func_446C(param_03);
    } else if(!isDefined(param_01)) {
      self.var_AA8B[param_00] = "neutral";
    } else {
      self.var_AA8B[param_00] = func_471C(param_01);
    }
  }

  func_A0FE();
}

func_860E(param_00, param_01, param_02, param_03) {
  self.var_AA8A[param_00] = param_01;
  self.var_356E = param_03;
  if(!func_8BB2()) {
    if(isDefined(param_02)) {
      self.var_AA89[param_00] = param_02;
    } else {
      self.var_AA89[param_00] = 0;
    }
  } else if(isDefined(param_02)) {
    self.var_AA8B[param_00] = func_446C(param_02);
  } else if(!isDefined(param_01)) {
    self.var_AA8B[param_00] = "neutral";
  } else {
    self.var_AA8B[param_00] = func_471C(param_01);
  }

  func_A19B();
}

func_861A(param_00, param_01) {
  self.var_AA8D[param_00] = param_01;
}

func_8645(param_00) {
  self.var_2015 = param_00;
}

func_471D(param_00) {
  if(!isDefined(level.var_A98F)) {
    maps\mp\gametypes\_gamelogic::func_5367();
  }

  var_01 = level.var_A98F[param_00];
  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01;
}

func_4720(param_00) {
  if(!isDefined(level.var_A994)) {
    maps\mp\gametypes\_gamelogic::func_5367();
  }

  var_01 = level.var_A994[param_00];
  if(!isDefined(var_01)) {
    return "";
  }

  return var_01;
}

func_471E(param_00) {
  if(!isDefined(level.var_A98F)) {
    maps\mp\gametypes\_gamelogic::func_5367();
  }

  var_01 = level.var_A992[param_00];
  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01;
}

func_471C(param_00) {
  if(!isDefined(level.var_A990)) {
    maps\mp\gametypes\_gamelogic::func_5367();
  }

  var_01 = level.var_A990[param_00];
  if(!isDefined(var_01)) {
    return "neutral";
  }

  return var_01;
}

func_471F(param_00) {
  if(!isDefined(level.var_A993)) {
    maps\mp\gametypes\_gamelogic::func_5367();
  }

  var_01 = level.var_A993[param_00];
  if(!isDefined(var_01)) {
    return "";
  }

  return var_01;
}

func_2F93() {
  self notify("disabled");
  if(self.var_01B9 == "carryObject") {
    if(isDefined(self.var_2006)) {
      self.var_2006 func_95ED(self);
    }

    for(var_00 = 0; var_00 < self.var_A582.size; var_00++) {
      self.var_A582[var_00] method_805C();
    }
  }

  self.var_9D65 common_scripts\utility::func_9D9F();
  func_8A60("none");
}

func_365D() {
  if(self.var_01B9 == "carryObject") {
    for(var_00 = 0; var_00 < self.var_A582.size; var_00++) {
      self.var_A582[var_00] method_805B();
    }
  }

  self.var_9D65 common_scripts\utility::func_9DA3();
  func_8A60("any");
}

func_4663(param_00) {
  if(param_00 == self.var_6DB2) {
    return "friendly";
  }

  return "enemy";
}

func_56FB(param_00) {
  var_01 = func_445B();
  if(self.var_6DB2 == "neutral" && var_01 != "none" && var_01 != param_00) {
    return 1;
  }

  if(self.var_6DB2 == "any") {
    return 1;
  }

  if(self.var_6DB2 == param_00) {
    return 1;
  }

  return 0;
}

func_1F53(param_00, param_01) {
  switch (self.var_5412) {
    case "none":
      return 0;

    case "any":
      return 1;

    case "friendly":
      if(param_00 == self.var_6DB2) {
        return 1;
      } else {
        return 0;
      }

      break;

    case "enemy":
      if(param_00 != self.var_6DB2) {
        return 1;
      } else {
        return 0;
      }

      break;

    default:
      return 0;
  }
}

func_57FE(param_00) {
  if(param_00 == "neutral") {
    return 1;
  }

  if(param_00 == "allies") {
    return 1;
  }

  if(param_00 == "axis") {
    return 1;
  }

  if(param_00 == "any") {
    return 1;
  }

  if(param_00 == "none") {
    return 1;
  }

  foreach(var_02 in level.var_985B) {
    if(param_00 == var_02) {
      return 1;
    }
  }

  return 0;
}

func_57A2(param_00) {
  if(param_00 == "friendly") {
    return 1;
  }

  if(param_00 == "enemy") {
    return 1;
  }

  if(param_00 == "any") {
    return 1;
  }

  if(param_00 == "none") {
    return 1;
  }

  return 0;
}

func_44B9(param_00) {
  if(level.var_6520) {}

  if(param_00 == "neutral" || param_00 == "none") {
    return "none";
  }

  if(param_00 == "allies") {
    return "axis";
  }

  return "allies";
}

func_45A9() {
  if(!isDefined(level.var_7AD6) || level.var_7AD6.size < 1) {
    var_00 = level.var_688F;
    level.var_688F++;
  } else {
    var_00 = level.var_7AD6[level.var_7AD6.size - 1];
    level.var_7AD6[level.var_7AD6.size - 1] = undefined;
  }

  if(var_00 > 31) {
    if(maps\mp\_utility::func_579B()) {}

    var_00 = 31;
  }

  return var_00;
}

func_454C() {
  var_00 = self.var_9D65.var_81E8;
  if(!isDefined(var_00)) {
    var_00 = "";
    return var_00;
  }

  if(var_00[0] != "_") {
    return "_" + var_00;
  }

  return var_00;
}

func_5307() {
  self.var_6638 = undefined;
  self.var_1E4D = 0;
  self.var_6AA9 = undefined;
}

func_65BF(param_00) {
  self.var_65BF = param_00;
}

func_1F49(param_00) {
  self.var_1F49 = param_00;
}

func_6B52(param_00) {
  self.var_5107 = param_00;
}

func_8BB2() {
  return !maps\mp\_utility::func_579B();
}

func_39F4() {
  self endon("disconnect");
  level endon("game_ended");
  var_00 = 120;
  var_01 = randomintrange(30, 90);
  var_00 = var_00 + var_01;
  maps\mp\gametypes\_hostmigration::func_A6F5(var_00);
  self waittill("show_loot_notification");
}

func_5108() {
  if(!self.var_5107) {
    return 0;
  }

  if(!isDefined(self.var_230E) || !isDefined(self.var_230E.var_9AC5)) {
    return 1;
  }

  var_00 = self.var_230E.var_9AC5[self.var_37D8];
  if(!isDefined(var_00) || var_00 != self.var_9D65) {
    return 1;
  }

  return 0;
}

cancapwithoutclaim(param_00) {
  self.cancapwithoutclaim = param_00;
}