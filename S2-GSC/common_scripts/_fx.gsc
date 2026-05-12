/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_fx.gsc
*********************************************/

func_52BD() {
  if(!isDefined(level.var_3F02)) {
    level.var_3F02 = [];
  }

  if(!isDefined(level.var_3F02["create_triggerfx"])) {
    level.var_3F02["create_triggerfx"] = ::func_27C2;
  }

  if(!isDefined(level.var_062E)) {
    level.var_062E = spawnStruct();
  }

  common_scripts\utility::func_27A6("createfx_looper", 20);
  level.var_3F70 = 1;
  level.var_062E.var_3945 = ::common_scripts\_exploder::func_392D;
  waittillframeend;
  waittillframeend;
  level.var_062E.var_3945 = ::common_scripts\_exploder::func_392B;
  level.var_062E.var_83F3 = 0;
  if(getdvarint("1189") == 1) {
    level.var_062E.var_83F3 = 1;
  }

  if(level.var_27F6) {
    level.var_062E.var_83F3 = 0;
  }

  if(level.var_27F6) {
    level waittill("createfx_common_done");
  }

  level.var_062E.var_8F32 = [];
  for(var_00 = 0; var_00 < level.var_2804.size; var_00++) {
    var_01 = level.var_2804[var_00];
    var_01 common_scripts\_createfx::func_84A8();
    switch (var_01.var_A265["type"]) {
      case "loopfx":
        var_01 thread func_5EF5();
        break;

      case "oneshotfx":
        var_01 thread func_6B11();
        break;

      case "soundfx":
        var_01 thread func_27A8();
        if(isDefined(var_01.var_A265["end_notify"]) && !common_scripts\utility::func_0F79(level.var_062E.var_8F32, var_01.var_A265["end_notify"])) {
          level.var_062E.var_8F32[level.var_062E.var_8F32.size] = var_01.var_A265["end_notify"];
        }
        break;

      case "soundfx_interval":
        var_01 thread func_27A1();
        if(isDefined(var_01.var_A265["end_notify"]) && !common_scripts\utility::func_0F79(level.var_062E.var_8F32, var_01.var_A265["end_notify"])) {
          level.var_062E.var_8F32[level.var_062E.var_8F32.size] = var_01.var_A265["end_notify"];
        }
        break;

      case "reactive_fx":
        var_01 func_0958();
        break;

      case "soundfx_dynamic":
        var_01 thread func_2794();
        break;
    }
  }

  thread func_8F33();
  func_214C();
  level notify("createfx_initialized");
}

func_7C81() {}

func_214C() {}

func_217A(param_00, param_01) {}

func_770F(param_00, param_01, param_02, param_03) {
  if(getDvar("debug") == "1") {}
}

func_7085() {
  if(isDefined(self.var_A265["platform"])) {
    var_00 = self.var_A265["platform"];
    if((var_00 == "ng" && !level.var_010B) || (var_00 == "pc" && !level.var_0122) || (var_00 == "xb3" && !level.var_01D4) || (var_00 == "ps4" && !level.var_0148) || (var_00 == "!ng" && level.var_010B) || (var_00 == "!pc" && level.var_0122) || (var_00 == "!xb3" && level.var_01D4) || var_00 == "!ps4" && level.var_0148) {
      return 0;
    }
  }

  return 1;
}

func_6B10(param_00, param_01, param_02, param_03) {}

func_3946(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E, param_0F, param_10, param_11) {
  if(1) {
    var_12 = common_scripts\utility::func_27E7(param_01);
    var_12.var_A265["origin"] = param_02;
    var_12.var_A265["angles"] = (0, 0, 0);
    if(isDefined(param_04)) {
      var_12.var_A265["angles"] = vectortoangles(param_04 - param_02);
    }

    var_12.var_A265["delay"] = param_03;
    var_12.var_A265["exploder"] = param_00;
    if(isDefined(level.var_2807)) {
      var_13 = level.var_2807[var_12.var_A265["exploder"]];
      if(!isDefined(var_13)) {
        var_13 = [];
      }

      var_13[var_13.size] = var_12;
      level.var_2807[var_12.var_A265["exploder"]] = var_13;
    }

    return;
  }

  var_14 = spawn("script_origin", (0, 0, 0));
  var_14.var_0116 = param_02;
  var_14.var_001D = vectortoangles(param_04 - param_02);
  var_14.var_8186 = param_00;
  var_14.var_81BB = param_01;
  var_14.var_0161 = param_03;
  var_14.var_8193 = param_05;
  var_14.var_8194 = param_06;
  var_14.var_8195 = param_07;
  var_14.var_828A = param_08;
  var_14.var_817B = param_09;
  var_14.var_8146 = param_0A;
  var_14.var_8276 = param_0F;
  var_14.var_828B = param_0B;
  var_14.var_8196 = param_10;
  var_14.var_8278 = param_0C;
  var_14.var_8154 = param_0D;
  var_14.var_8153 = param_0E;
  var_14.var_8188 = param_11;
  var_15 = anglesToForward(var_14.var_001D);
  var_15 = var_15 * 150;
  var_14.var_9834 = param_02 + var_15;
  if(!isDefined(level.var_06CC)) {
    level.var_06CC = [];
  }

  level.var_06CC[level.var_06CC.size] = var_14;
}

func_5EEE(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = common_scripts\utility::func_2814(param_00);
  var_07.var_A265["origin"] = param_01;
  var_07.var_A265["angles"] = (0, 0, 0);
  if(isDefined(param_03)) {
    var_07.var_A265["angles"] = vectortoangles(param_03 - param_01);
  }

  var_07.var_A265["delay"] = param_02;
}

func_27A7() {
  self.var_5EED = playloopedfx(level.var_0611[self.var_A265["fxid"]], self.var_A265["delay"], self.var_A265["origin"], 0, self.var_A265["forward"], self.var_A265["up"]);
  func_27A8();
}

func_27A8() {
  if(!func_7085()) {
    return;
  }

  self notify("stop_loop");
  if(!isDefined(self.var_A265["soundalias"])) {
    return;
  }

  if(self.var_A265["soundalias"] == "nil") {
    return;
  }

  var_00 = 0;
  var_01 = undefined;
  if(isDefined(self.var_A265["stopable"]) && self.var_A265["stopable"]) {
    if(isDefined(self.var_5EED)) {
      var_01 = "death";
    } else {
      var_01 = "stop_loop";
    }
  } else if(level.var_062E.var_83F3 && isDefined(self.var_A265["server_culled"])) {
    var_00 = self.var_A265["server_culled"];
  }

  var_02 = self;
  if(isDefined(self.var_5EED)) {
    var_02 = self.var_5EED;
  }

  var_03 = undefined;
  if(level.var_27F6) {
    var_03 = self;
  }

  var_02 common_scripts\utility::func_5EE2(self.var_A265["soundalias"], self.var_A265["origin"], self.var_A265["angles"], var_00, var_01, var_03);
}

func_27A1() {
  if(!func_7085()) {
    return;
  }

  self notify("stop_loop");
  if(!isDefined(self.var_A265["soundalias"])) {
    return;
  }

  if(self.var_A265["soundalias"] == "nil") {
    return;
  }

  var_00 = undefined;
  var_01 = self;
  if((isDefined(self.var_A265["stopable"]) && self.var_A265["stopable"]) || level.var_27F6) {
    if(isDefined(self.var_5EED)) {
      var_01 = self.var_5EED;
      var_00 = "death";
    } else {
      var_00 = "stop_loop";
    }
  }

  var_01 thread common_scripts\utility::func_5EE1(self.var_A265["soundalias"], self.var_A265["origin"], self.var_A265["angles"], var_00, undefined, self.var_A265["delay_min"], self.var_A265["delay_max"]);
}

func_2794() {
  if(!func_7085()) {
    return;
  }

  if(!isDefined(self.var_A265["ambiencename"])) {
    return;
  }

  if(self.var_A265["ambiencename"] == "nil") {
    return;
  }

  if(common_scripts\utility::func_57D7()) {
    return;
  }

  if(getDvar("1459") == "on") {
    common_scripts\utility::func_3C9F("createfx_started");
  }

  if(isDefined(self.var_29FB)) {
    level.var_721C stopdynamicambience(self.var_29FB.var_A01E);
  }

  self.var_29FB = spawnStruct();
  self.var_29FB common_scripts\utility::func_10DA();
  level.var_721C playdynamicambience(self.var_A265["ambiencename"], self.var_A265["origin"], self.var_A265["dynamic_distance"], self.var_29FB.var_A01E);
}

func_5EF5() {
  wait 0.05;
  if(isDefined(self.var_3F7E)) {
    level waittill("start fx" + self.var_3F7E);
  }

  for(;;) {
    func_27A7();
    if(isDefined(self.var_9A01)) {
      thread func_5EF4(self.var_9A01);
    }

    if(isDefined(self.var_3F7F)) {
      level waittill("stop fx" + self.var_3F7F);
    } else {
      return;
    }

    if(isDefined(self.var_5EED)) {
      self.var_5EED delete();
    }

    if(isDefined(self.var_3F7E)) {
      level waittill("start fx" + self.var_3F7E);
      continue;
    }
  }
}

func_5EF1(param_00) {
  self endon("death");
  param_00 waittill("effect id changed", var_01);
}

func_5EF2(param_00) {
  self endon("death");
  for(;;) {
    param_00 waittill("effect org changed", var_01);
    self.var_0116 = var_01;
  }
}

func_5EF0(param_00) {
  self endon("death");
  param_00 waittill("effect delay changed", var_01);
}

func_5EF3(param_00) {
  self endon("death");
  param_00 waittill("effect deleted");
  self delete();
}

func_5EF4(param_00) {
  self endon("death");
  wait(param_00);
  self.var_5EED delete();
}

func_5F02(param_00, param_01, param_02) {
  level thread func_5F06(param_00, param_01, param_02);
}

func_5F06(param_00, param_01, param_02) {
  var_03 = spawn("script_origin", param_01);
  var_03.var_0116 = param_01;
  var_03 method_861D(param_00);
}

func_48E1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  thread func_48E2(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07);
}

func_48E2(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  level endon("stop all gunfireloopfx");
  wait 0.05;
  if(param_07 < param_06) {
    var_08 = param_07;
    param_07 = param_06;
    param_06 = var_08;
  }

  var_09 = param_06;
  var_0A = param_07 - param_06;
  if(param_05 < param_04) {
    var_08 = param_05;
    param_05 = param_04;
    param_04 = var_08;
  }

  var_0B = param_04;
  var_0C = param_05 - param_04;
  if(param_03 < param_02) {
    var_08 = param_03;
    param_03 = param_02;
    param_02 = var_08;
  }

  var_0D = param_02;
  var_0E = param_03 - param_02;
  var_0F = spawnfx(level.var_0611[param_00], param_01);
  if(!level.var_27F6) {
    var_0F method_80D4();
  }

  for(;;) {
    var_10 = var_0D + randomint(var_0E);
    for(var_11 = 0; var_11 < var_10; var_11++) {
      triggerfx(var_0F);
      wait(var_0B + randomfloat(var_0C));
    }

    wait(var_09 + randomfloat(var_0A));
  }
}

func_48E3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  thread func_48E4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

func_48E4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  level endon("stop all gunfireloopfx");
  wait 0.05;
  if(param_08 < param_07) {
    var_09 = param_08;
    param_08 = param_07;
    param_07 = var_09;
  }

  var_0A = param_07;
  var_0B = param_08 - param_07;
  if(param_06 < param_05) {
    var_09 = param_06;
    param_06 = param_05;
    param_05 = var_09;
  }

  var_0C = param_05;
  var_0D = param_06 - param_05;
  if(param_04 < param_03) {
    var_09 = param_04;
    param_04 = param_03;
    param_03 = var_09;
  }

  var_0E = param_03;
  var_0F = param_04 - param_03;
  param_02 = vectornormalize(param_02 - param_01);
  var_10 = spawnfx(level.var_0611[param_00], param_01, param_02);
  if(!level.var_27F6) {
    var_10 method_80D4();
  }

  for(;;) {
    var_11 = var_0E + randomint(var_0F);
    for(var_12 = 0; var_12 < int(var_11 / level.var_3F70); var_12++) {
      triggerfx(var_10);
      var_13 = var_0C + randomfloat(var_0D) * level.var_3F70;
      if(var_13 < 0.05) {
        var_13 = 0.05;
      }

      wait(var_13);
    }

    wait(var_0C + randomfloat(var_0D));
    wait(var_0A + randomfloat(var_0B));
  }
}

func_8681(param_00) {
  level.var_3F70 = 1 / param_00;
}

func_8834() {
  if(!isDefined(self.var_81BB) || !isDefined(self.var_81BA) || !isDefined(self.var_0161)) {
    return;
  }

  if(isDefined(self.var_0106)) {
    if(self.var_0106 == "toilet") {
      thread func_1DB1();
      return;
    }
  }

  var_00 = undefined;
  if(isDefined(self.var_01A2)) {
    var_01 = getent(self.var_01A2, "targetname");
    if(isDefined(var_01)) {
      var_00 = var_01.var_0116;
    }
  }

  var_02 = undefined;
  if(isDefined(self.var_81BC)) {
    var_02 = self.var_81BC;
  }

  var_03 = undefined;
  if(isDefined(self.var_81BD)) {
    var_03 = self.var_81BD;
  }

  if(self.var_81BA == "OneShotfx") {
    func_6B10(self.var_81BB, self.var_0116, self.var_0161, var_00);
  }

  if(self.var_81BA == "loopfx") {
    func_5EEE(self.var_81BB, self.var_0116, self.var_0161, var_00, var_02, var_03);
  }

  if(self.var_81BA == "loopsound") {
    func_5F02(self.var_81BB, self.var_0116, self.var_0161);
  }

  self delete();
}

func_1DB1() {
  var_00 = (0, 0, self.var_001D[1]);
  var_01 = level.var_0611[self.var_81BB];
  var_02 = self.var_0116;
  wait(1);
  level thread func_1DB2(var_00, var_02, var_01);
  self delete();
}

func_1DB2(param_00, param_01, param_02) {
  for(;;) {
    playFX(param_02, param_01);
    wait(30 + randomfloat(40));
  }
}

func_27C2() {
  if(!func_A411(self.var_A265["fxid"])) {
    return;
  }

  self.var_5EED = spawnfx(level.var_0611[self.var_A265["fxid"]], self.var_A265["origin"], self.var_A265["forward"], self.var_A265["up"]);
  triggerfx(self.var_5EED, self.var_A265["delay"]);
  if(!level.var_27F6) {
    self.var_5EED method_80D4();
  }

  func_27A8();
}

func_A411(param_00) {
  if(isDefined(level.var_0611[param_00])) {
    return 1;
  }

  if(!isDefined(level.var_067C)) {
    level.var_067C = [];
  }

  level.var_067C[self.var_A265["fxid"]] = param_00;
  func_A412(param_00);
  return 0;
}

func_A412(param_00) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  wait 0.05;
  var_01 = "";
  var_02 = getarraykeys(level.var_067C);
  foreach(var_04 in var_02) {
    var_01 = var_01 + var_04 + "\n";
  }
}

func_6B11() {
  wait 0.05;
  if(!func_7085()) {
    return;
  }

  if(self.var_A265["delay"] > 0) {
    wait(self.var_A265["delay"]);
  }

  [[level.var_3F02["create_triggerfx"]]]();
}

func_0958() {
  if(!func_7085()) {
    return;
  }

  if(!common_scripts\utility::func_57D7() && getDvar("1459") == "") {
    return;
  }

  if(!isDefined(level.var_062E.var_7AB0)) {
    level.var_062E.var_7AB0 = 1;
    level thread func_7AAE();
  }

  if(!isDefined(level.var_062E.var_7AAD)) {
    level.var_062E.var_7AAD = [];
  }

  level.var_062E.var_7AAD[level.var_062E.var_7AAD.size] = self;
  self.var_66AE = 3000;
}

func_7AAE() {
  if(!common_scripts\utility::func_57D7()) {
    if(getDvar("1459") == "on") {
      common_scripts\utility::func_3C9F("createfx_started");
    }
  }

  level.var_062E.var_7AAF = [];
  var_00 = 256;
  for(;;) {
    level waittill("code_damageradius", var_01, var_00, var_02, var_03);
    var_04 = func_8F21(var_02, var_00);
    foreach(var_07, var_06 in var_04) {
      var_06 thread func_718B(var_07);
    }
  }
}

func_A2B8(param_00) {
  return (param_00[0], param_00[1], 0);
}

func_8F21(param_00, param_01) {
  var_02 = [];
  var_03 = gettime();
  foreach(var_05 in level.var_062E.var_7AAD) {
    if(var_05.var_66AE > var_03) {
      continue;
    }

    var_06 = var_05.var_A265["reactive_radius"] + param_01;
    var_06 = var_06 * var_06;
    if(distancesquared(param_00, var_05.var_A265["origin"]) < var_06) {
      var_02[var_02.size] = var_05;
    }
  }

  foreach(var_05 in var_02) {
    var_09 = func_A2B8(var_05.var_A265["origin"] - level.var_721C.var_0116);
    var_0A = func_A2B8(param_00 - level.var_721C.var_0116);
    var_0B = vectornormalize(var_09);
    var_0C = vectornormalize(var_0A);
    var_05.var_32B1 = vectordot(var_0B, var_0C);
  }

  for(var_0E = 0; var_0E < var_02.size - 1; var_0E++) {
    for(var_0F = var_0E + 1; var_0F < var_02.size; var_0F++) {
      if(var_02[var_0E].var_32B1 > var_02[var_0F].var_32B1) {
        var_10 = var_02[var_0E];
        var_02[var_0E] = var_02[var_0F];
        var_02[var_0F] = var_10;
      }
    }
  }

  foreach(var_05 in var_02) {
    var_05.var_0116 = undefined;
    var_05.var_32B1 = undefined;
  }

  for(var_0E = 4; var_0E < var_02.size; var_0E++) {
    var_02[var_0E] = undefined;
  }

  return var_02;
}

func_718B(param_00) {
  var_01 = func_42F0();
  if(!isDefined(var_01)) {
    return;
  }

  self.var_66AE = gettime() + 3000;
  var_01.var_0116 = self.var_A265["origin"];
  var_01.var_55E4 = 1;
  wait(param_00 * randomfloatrange(0.05, 0.1));
  if(common_scripts\utility::func_57D7()) {
    var_01 method_8617(self.var_A265["soundalias"], "sounddone");
    var_01 waittill("sounddone");
  } else {
    var_01 method_8617(self.var_A265["soundalias"]);
    wait(2);
  }

  wait(0.1);
  var_01.var_55E4 = 0;
}

func_42F0() {
  foreach(var_01 in level.var_062E.var_7AAF) {
    if(!var_01.var_55E4) {
      return var_01;
    }
  }

  if(level.var_062E.var_7AAF.size < 4) {
    var_01 = spawn("script_origin", (0, 0, 0));
    var_01.var_55E4 = 0;
    level.var_062E.var_7AAF[level.var_062E.var_7AAF.size] = var_01;
    return var_01;
  }

  return undefined;
}

func_8F33() {
  for(;;) {
    var_00 = level common_scripts\utility::func_A712(level.var_062E.var_8F32);
    for(var_01 = 0; var_01 < level.var_2804.size; var_01++) {
      var_02 = level.var_2804[var_01];
      if(var_02.var_A265["type"] == "soundfx_interval" || var_02.var_A265["type"] == "soundfx") {
        if(isDefined(var_02.var_A265["end_notify"]) && var_02.var_A265["end_notify"] == var_00) {
          var_02 notify("stop_loop");
        }
      }
    }
  }
}