/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_fx.gsc
*********************************************/

func_52BD() {
  if(!isDefined(level.var_3F02)) {
    level.var_3F02 = [];
  }

  if(!isDefined(level.var_3F02["create_triggerfx"])) {
    level.var_3F02["create_triggerfx"] = ::create_triggerfx;
  }

  if(!isDefined(level._fx)) {
    level._fx = spawnStruct();
  }

  common_scripts\utility::func_27A6("createfx_looper", 20);
  level.var_3F70 = 1;
  level._fx.var_3945 = ::common_scripts\_exploder::func_392D;
  waittillframeend;
  waittillframeend;
  level._fx.var_3945 = ::common_scripts\_exploder::func_392B;
  level._fx.var_83F3 = 0;
  if(getdvarint("1189") == 1) {
    level._fx.var_83F3 = 1;
  }

  if(level.var_27F6) {
    level._fx.var_83F3 = 0;
  }

  if(level.var_27F6) {
    level waittill("createfx_common_done");
  }

  level._fx.var_8F32 = [];
  for(var_00 = 0; var_00 < level.createfxent.size; var_00++) {
    var_01 = level.createfxent[var_00];
    var_01 common_scripts\_createfx::set_forward_and_up_vectors();
    switch (var_01.v["type"]) {
      case "loopfx":
        var_01 thread loopfxthread();
        break;

      case "oneshotfx":
        var_01 thread oneshotfxthread();
        break;

      case "soundfx":
        var_01 thread create_loopsound();
        if(isDefined(var_01.v["end_notify"]) && !common_scripts\utility::func_F79(level._fx.var_8F32, var_01.v["end_notify"])) {
          level._fx.var_8F32[level._fx.var_8F32.size] = var_01.v["end_notify"];
        }
        break;

      case "soundfx_interval":
        var_01 thread create_interval_sound();
        if(isDefined(var_01.v["end_notify"]) && !common_scripts\utility::func_F79(level._fx.var_8F32, var_01.v["end_notify"])) {
          level._fx.var_8F32[level._fx.var_8F32.size] = var_01.v["end_notify"];
        }
        break;

      case "reactive_fx":
        var_01 func_0958();
        break;

      case "soundfx_dynamic":
        var_01 thread create_dynamicambience();
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
  if(isDefined(self.v["platform"])) {
    var_00 = self.v["platform"];
    if((var_00 == "ng" && !level.var_10B) || (var_00 == "pc" && !level.var_122) || (var_00 == "xb3" && !level.weaponinventorytype) || (var_00 == "ps4" && !level.var_148) || (var_00 == "!ng" && level.var_10B) || (var_00 == "!pc" && level.var_122) || (var_00 == "!xb3" && level.weaponinventorytype) || var_00 == "!ps4" && level.var_148) {
      return 0;
    }
  }

  return 1;
}

func_6B10(param_00, param_01, param_02, param_03) {}

func_3946(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D, param_0E, param_0F, param_10, param_11) {
  if(1) {
    var_12 = common_scripts\utility::createexploder(param_01);
    var_12.v["origin"] = param_02;
    var_12.v["angles"] = (0, 0, 0);
    if(isDefined(param_04)) {
      var_12.v["angles"] = vectortoangles(param_04 - param_02);
    }

    var_12.v["delay"] = param_03;
    var_12.v["exploder"] = param_00;
    if(isDefined(level.var_2807)) {
      var_13 = level.var_2807[var_12.v["exploder"]];
      if(!isDefined(var_13)) {
        var_13 = [];
      }

      var_13[var_13.size] = var_12;
      level.var_2807[var_12.v["exploder"]] = var_13;
    }

    return;
  }

  var_14 = spawn("script_origin", (0, 0, 0));
  var_14.origin = param_03;
  var_14.angles = vectortoangles(param_05 - param_03);
  var_14.setdepthoffield = param_01;
  var_14.var_81BB = param_02;
  var_14.script_delay = param_04;
  var_14.var_8193 = param_06;
  var_14.var_8194 = param_07;
  var_14.var_8195 = param_08;
  var_14.script_sound = param_09;
  var_14.var_817B = param_0A;
  var_14.var_8146 = param_0B;
  var_14.scriptmodelplayanim = param_10;
  var_14.var_828B = param_0C;
  var_14.var_8196 = param_11;
  var_14.var_8278 = param_0D;
  var_14.var_8154 = param_0E;
  var_14.var_8153 = param_0F;
  var_14.var_8188 = var_12;
  var_15 = anglesToForward(var_14.angles);
  var_15 = var_15 * 150;
  var_14.var_9834 = param_03 + var_15;
  if(!isDefined(level.var_6CC)) {
    level.var_6CC = [];
  }

  level.var_6CC[level.var_6CC.size] = var_14;
}

func_5EEE(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = common_scripts\utility::func_2814(param_00);
  var_07.v["origin"] = param_01;
  var_07.v["angles"] = (0, 0, 0);
  if(isDefined(param_03)) {
    var_07.v["angles"] = vectortoangles(param_03 - param_01);
  }

  var_07.v["delay"] = param_02;
}

create_looper() {
  self.looper = playloopedfx(level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"]);
  create_loopsound();
}

create_loopsound() {
  if(!func_7085()) {
    return;
  }

  self notify("stop_loop");
  if(!isDefined(self.v["soundalias"])) {
    return;
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }

  var_00 = 0;
  var_01 = undefined;
  if(isDefined(self.v["stopable"]) && self.v["stopable"]) {
    if(isDefined(self.looper)) {
      var_01 = "death";
    } else {
      var_01 = "stop_loop";
    }
  } else if(level._fx.var_83F3 && isDefined(self.v["server_culled"])) {
    var_00 = self.v["server_culled"];
  }

  var_02 = self;
  if(isDefined(self.looper)) {
    var_02 = self.looper;
  }

  var_03 = undefined;
  if(level.var_27F6) {
    var_03 = self;
  }

  var_02 common_scripts\utility::func_5EE2(self.v["soundalias"], self.v["origin"], self.v["angles"], var_00, var_01, var_03);
}

create_interval_sound() {
  if(!func_7085()) {
    return;
  }

  self notify("stop_loop");
  if(!isDefined(self.v["soundalias"])) {
    return;
  }

  if(self.v["soundalias"] == "nil") {
    return;
  }

  var_00 = undefined;
  var_01 = self;
  if((isDefined(self.v["stopable"]) && self.v["stopable"]) || level.var_27F6) {
    if(isDefined(self.looper)) {
      var_01 = self.looper;
      var_00 = "death";
    } else {
      var_00 = "stop_loop";
    }
  }

  var_01 thread common_scripts\utility::func_5EE1(self.v["soundalias"], self.v["origin"], self.v["angles"], var_00, undefined, self.v["delay_min"], self.v["delay_max"]);
}

create_dynamicambience() {
  if(!func_7085()) {
    return;
  }

  if(!isDefined(self.v["ambiencename"])) {
    return;
  }

  if(self.v["ambiencename"] == "nil") {
    return;
  }

  if(common_scripts\utility::issp()) {
    return;
  }

  if(getDvar("1459") == "on") {
    common_scripts\utility::func_3C9F("createfx_started");
  }

  if(isDefined(self.var_29FB)) {
    level.player stopdynamicambience(self.var_29FB.var_A01E);
  }

  self.var_29FB = spawnStruct();
  self.var_29FB common_scripts\utility::func_10DA();
  level.player playdynamicambience(self.v["ambiencename"], self.v["origin"], self.v["dynamic_distance"], self.var_29FB.var_A01E);
}

loopfxthread() {
  wait 0.05;
  if(isDefined(self.var_3F7E)) {
    level waittill("start fx" + self.var_3F7E);
  }

  for(;;) {
    create_looper();
    if(isDefined(self.var_9A01)) {
      thread func_5EF4(self.var_9A01);
    }

    if(isDefined(self.var_3F7F)) {
      level waittill("stop fx" + self.var_3F7F);
    } else {
      return;
    }

    if(isDefined(self.looper)) {
      self.looper delete();
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
    self.origin = var_01;
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
  self.looper delete();
}

func_5F02(param_00, param_01, param_02) {
  level thread func_5F06(param_00, param_01, param_02);
}

func_5F06(param_00, param_01, param_02) {
  var_03 = spawn("script_origin", param_01);
  var_03.origin = param_01;
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
  var_0F = spawnfx(level._effect[param_00], param_01);
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
  param_02 = vectorNormalize(param_02 - param_01);
  var_10 = spawnfx(level._effect[param_00], param_01, param_02);
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
  if(!isDefined(self.var_81BB) || !isDefined(self.var_81BA) || !isDefined(self.script_delay)) {
    return;
  }

  if(isDefined(self.model)) {
    if(self.model == "toilet") {
      thread func_1DB1();
      return;
    }
  }

  var_00 = undefined;
  if(isDefined(self.target)) {
    var_01 = getEnt(self.target, "targetname");
    if(isDefined(var_01)) {
      var_00 = var_01.origin;
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
    func_6B10(self.var_81BB, self.origin, self.script_delay, var_00);
  }

  if(self.var_81BA == "loopfx") {
    func_5EEE(self.var_81BB, self.origin, self.script_delay, var_00, var_02, var_03);
  }

  if(self.var_81BA == "loopsound") {
    func_5F02(self.var_81BB, self.origin, self.script_delay);
  }

  self delete();
}

func_1DB1() {
  var_00 = (0, 0, self.angles[1]);
  var_01 = level._effect[self.var_81BB];
  var_02 = self.origin;
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

create_triggerfx() {
  if(!func_A411(self.v["fxid"])) {
    return;
  }

  self.looper = spawnfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self.looper, self.v["delay"]);
  if(!level.var_27F6) {
    self.looper method_80D4();
  }

  create_loopsound();
}

func_A411(param_00) {
  if(isDefined(level._effect[param_00])) {
    return 1;
  }

  if(!isDefined(level.var_67C)) {
    level.var_67C = [];
  }

  level.var_67C[self.v["fxid"]] = param_00;
  func_A412(param_00);
  return 0;
}

func_A412(param_00) {
  level notify("verify_effects_assignment_print");
  level endon("verify_effects_assignment_print");
  wait 0.05;
  var_01 = "";
  var_02 = getarraykeys(level.var_67C);
  foreach(var_04 in var_02) {
    var_01 = var_01 + var_04 + "\n";
  }
}

oneshotfxthread() {
  wait 0.05;
  if(!func_7085()) {
    return;
  }

  if(self.v["delay"] > 0) {
    wait(self.v["delay"]);
  }

  [[level.var_3F02["create_triggerfx"]]]();
}

func_0958() {
  if(!func_7085()) {
    return;
  }

  if(!common_scripts\utility::issp() && getDvar("1459") == "") {
    return;
  }

  if(!isDefined(level._fx.var_7AB0)) {
    level._fx.var_7AB0 = 1;
    level thread func_7AAE();
  }

  if(!isDefined(level._fx.reactive_fx_ents)) {
    level._fx.reactive_fx_ents = [];
  }

  level._fx.reactive_fx_ents[level._fx.reactive_fx_ents.size] = self;
  self.var_66AE = 3000;
}

func_7AAE() {
  if(!common_scripts\utility::issp()) {
    if(getDvar("1459") == "on") {
      common_scripts\utility::func_3C9F("createfx_started");
    }
  }

  level._fx.var_7AAF = [];
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
  foreach(var_05 in level._fx.reactive_fx_ents) {
    if(var_05.var_66AE > var_03) {
      continue;
    }

    var_06 = var_05.v["reactive_radius"] + param_01;
    var_06 = var_06 * var_06;
    if(distancesquared(param_00, var_05.v["origin"]) < var_06) {
      var_02[var_02.size] = var_05;
    }
  }

  foreach(var_05 in var_02) {
    var_09 = func_A2B8(var_05.v["origin"] - level.player.origin);
    var_0A = func_A2B8(param_00 - level.player.origin);
    var_0B = vectorNormalize(var_09);
    var_0C = vectorNormalize(var_0A);
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
    var_05.origin = undefined;
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
  var_01.origin = self.v["origin"];
  var_01.is_playing = 1;
  wait(param_00 * randomfloatrange(0.05, 0.1));
  if(common_scripts\utility::issp()) {
    var_01 playSound(self.v["soundalias"], "sounddone");
    var_01 waittill("sounddone");
  } else {
    var_01 playSound(self.v["soundalias"]);
    wait(2);
  }

  wait(0.1);
  var_01.is_playing = 0;
}

func_42F0() {
  foreach(var_01 in level._fx.var_7AAF) {
    if(!var_01.is_playing) {
      return var_01;
    }
  }

  if(level._fx.var_7AAF.size < 4) {
    var_01 = spawn("script_origin", (0, 0, 0));
    var_01.is_playing = 0;
    level._fx.var_7AAF[level._fx.var_7AAF.size] = var_01;
    return var_01;
  }

  return undefined;
}

func_8F33() {
  for(;;) {
    var_00 = level common_scripts\utility::func_A712(level._fx.var_8F32);
    for(var_01 = 0; var_01 < level.createfxent.size; var_01++) {
      var_02 = level.createfxent[var_01];
      if(var_02.v["type"] == "soundfx_interval" || var_02.v["type"] == "soundfx") {
        if(isDefined(var_02.v["end_notify"]) && var_02.v["end_notify"] == var_00) {
          var_02 notify("stop_loop");
        }
      }
    }
  }
}