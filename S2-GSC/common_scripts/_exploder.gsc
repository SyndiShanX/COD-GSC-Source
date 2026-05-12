/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_exploder.gsc
*********************************************/

func_44D1(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    return level.var_2807[param_00];
  }

  var_01 = [];
  foreach(var_03 in level.var_2804) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03.var_A265["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_03.var_A265["exploder"])) {
      continue;
    }

    if(var_03.var_A265["exploder"] == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

func_885C(param_00) {
  var_01 = param_00.var_8186;
  if(!isDefined(level.var_3948[var_01])) {
    level.var_3948[var_01] = [];
  }

  var_02 = param_00.var_01A5;
  if(!isDefined(var_02)) {
    var_02 = "";
  }

  level.var_3948[var_01][level.var_3948[var_01].size] = param_00;
  if(func_393B(param_00)) {
    param_00 method_805C();
    return;
  }

  if(func_393A(param_00)) {
    param_00 method_805C();
    param_00 notsolid();
    if(isDefined(param_00.var_0187) && param_00.var_0187 & 1) {
      if(isDefined(param_00.var_8166)) {
        param_00 method_8060();
      }
    }

    return;
  }

  if(func_3939(param_00)) {
    param_00 method_805C();
    param_00 notsolid();
    if(isDefined(param_00.var_0187) && param_00.var_0187 & 1) {
      param_00 method_8060();
    }
  }
}

func_8A1A() {
  level.var_3948 = [];
  var_00 = getEntArray("script_brushmodel", "classname");
  var_01 = getEntArray("script_model", "classname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_00[var_00.size] = var_01[var_02];
  }

  foreach(var_04 in var_00) {
    if(isDefined(var_04.var_8272)) {
      var_04.var_8186 = var_04.var_8272;
    }

    if(isDefined(var_04.var_6019)) {
      continue;
    }

    if(isDefined(var_04.var_8186)) {
      func_885C(var_04);
    }
  }

  var_06 = [];
  var_07 = getEntArray("script_brushmodel", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].var_8186 = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].var_8186)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = getEntArray("script_model", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].var_8186 = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].var_8186)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = getEntArray("script_origin", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].var_8186 = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].var_8186)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = getEntArray("item_health", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].var_8186 = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].var_8186)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = level.var_9478;
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(!isDefined(var_07[var_02])) {
      continue;
    }

    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].var_8186 = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].var_8186)) {
      if(!isDefined(var_07[var_02].var_001D)) {
        var_07[var_02].var_001D = (0, 0, 0);
      }

      var_06[var_06.size] = var_07[var_02];
    }
  }

  if(!isDefined(level.var_2804)) {
    level.var_2804 = [];
  }

  var_08 = [];
  var_08["exploderchunk visible"] = 1;
  var_08["exploderchunk"] = 1;
  var_08["exploder"] = 1;
  thread func_8825();
  var_02 = 0;
  while(var_02 < var_06.size) {
    var_09 = var_06[var_02];
    var_04 = common_scripts\utility::func_27E7(var_09.var_81BB);
    var_04.var_A265 = [];
    var_04.var_A265["origin"] = var_09.var_0116;
    var_04.var_A265["angles"] = var_09.var_001D;
    var_04.var_A265["delay"] = var_09.var_0161;
    var_04.var_A265["delay_post"] = var_09.var_8155;
    var_04.var_A265["firefx"] = var_09.var_8193;
    var_04.var_A265["firefxdelay"] = var_09.var_8194;
    var_04.var_A265["firefxsound"] = var_09.var_8195;
    var_04.var_A265["firefxtimeout"] = var_09.var_8196;
    var_04.var_A265["earthquake"] = var_09.var_817B;
    var_04.var_A265["rumble"] = var_09.var_827D;
    var_04.var_A265["damage"] = var_09.var_8146;
    var_04.var_A265["damage_radius"] = var_09.var_8276;
    var_04.var_A265["soundalias"] = var_09.var_828B;
    var_04.var_A265["repeat"] = var_09.var_8278;
    var_04.var_A265["delay_min"] = var_09.var_8154;
    var_04.var_A265["delay_max"] = var_09.var_8153;
    var_04.var_A265["target"] = var_09.var_01A2;
    var_04.var_A265["ender"] = var_09.var_817E;
    var_04.var_A265["physics"] = var_09.var_8269;
    var_04.var_A265["type"] = "exploder";
    if(!isDefined(var_09.var_81BB)) {
      var_04.var_A265["fxid"] = "No FX";
    } else {
      var_04.var_A265["fxid"] = var_09.var_81BB;
    }

    var_04.var_A265["exploder"] = var_09.var_8186;
    if(isDefined(level.var_2807)) {
      var_0A = level.var_2807[var_04.var_A265["exploder"]];
      if(!isDefined(var_0A)) {
        var_0A = [];
      }

      var_0A[var_0A.size] = var_04;
      level.var_2807[var_04.var_A265["exploder"]] = var_0A;
    }

    if(!isDefined(var_04.var_A265["delay"])) {
      var_04.var_A265["delay"] = 0;
    }

    if(isDefined(var_09.var_01A2)) {
      var_0B = getEntArray(var_04.var_A265["target"], "targetname")[0];
      if(isDefined(var_0B)) {
        var_0C = var_0B.var_0116;
        var_04.var_A265["angles"] = vectortoangles(var_0C - var_04.var_A265["origin"]);
      } else {
        var_0B = common_scripts\utility::func_4375(var_04.var_A265["target"]);
        if(isDefined(var_0B)) {
          var_0C = var_0B.var_0116;
          var_04.var_A265["angles"] = vectortoangles(var_0C - var_04.var_A265["origin"]);
        }
      }
    }

    if(!isDefined(var_0B.var_003B)) {
      var_05.var_0106 = var_0B;
      if(isDefined(var_05.var_0106.var_8205)) {
        precachemodel(var_05.var_0106.var_8205);
      }
    } else if(var_0B.var_003B == "script_brushmodel" || isDefined(var_0B.var_0106)) {
      var_05.var_0106 = var_0B;
      var_05.var_0106.var_2FBF = var_0B.var_8166;
    }

    if(isDefined(var_0B.var_01A5) && isDefined(var_09[var_0B.var_01A5])) {
      var_05.var_A265["exploder_type"] = var_0B.var_01A5;
    } else {
      var_05.var_A265["exploder_type"] = "normal";
    }

    if(isDefined(var_0B.var_6019)) {
      var_05.var_A265["masked_exploder"] = var_0B.var_0106;
      var_05.var_A265["masked_exploder_spawnflags"] = var_0B.var_0187;
      var_05.var_A265["masked_exploder_script_disconnectpaths"] = var_0B.var_8166;
      var_0B delete();
    }

    var_05 common_scripts\_createfx::func_75BE();
    var_03++;
  }
}

func_8825() {
  waittillframeend;
  waittillframeend;
  waittillframeend;
  var_00 = [];
  foreach(var_02 in level.var_2804) {
    if(var_02.var_A265["type"] != "exploder") {
      continue;
    }

    var_03 = var_02.var_A265["flag"];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 == "nil") {
      var_02.var_A265["flag"] = undefined;
    }

    var_00[var_03] = 1;
  }

  foreach(var_07, var_06 in var_00) {
    thread func_3933(var_07);
  }
}

func_3933(param_00) {
  if(!common_scripts\utility::func_3C83(param_00)) {
    common_scripts\utility::func_3C87(param_00);
  }

  common_scripts\utility::func_3C9F(param_00);
  foreach(var_02 in level.var_2804) {
    if(var_02.var_A265["type"] != "exploder") {
      continue;
    }

    var_03 = var_02.var_A265["flag"];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 != param_00) {
      continue;
    }

    var_02 common_scripts\utility::func_0894();
  }
}

func_393A(param_00) {
  return isDefined(param_00.var_01A5) && param_00.var_01A5 == "exploder";
}

func_393B(param_00) {
  return param_00.var_0106 == "fx" && !isDefined(param_00.var_01A5) || param_00.var_01A5 != "exploderchunk";
}

func_3939(param_00) {
  return isDefined(param_00.var_01A5) && param_00.var_01A5 == "exploderchunk";
}

func_8BCA(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    var_01 = level.var_2807[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(!func_393B(var_03.var_0106) && !func_393A(var_03.var_0106) && !func_3939(var_03.var_0106)) {
          var_03.var_0106 method_805B();
        }

        if(isDefined(var_03.var_1CB4)) {
          var_03.var_0106 method_805B();
        }
      }

      return;
    }

    return;
  }

  for(var_05 = 0; var_05 < level.var_2804.size; var_05++) {
    var_03 = level.var_2804[var_05];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03.var_A265["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_03.var_A265["exploder"])) {
      continue;
    }

    if(var_03.var_A265["exploder"] + "" != param_00) {
      continue;
    }

    if(isDefined(var_03.var_0106)) {
      if(!func_393B(var_03.var_0106) && !func_393A(var_03.var_0106) && !func_3939(var_03.var_0106)) {
        var_03.var_0106 method_805B();
      }

      if(isDefined(var_03.var_1CB4)) {
        var_03.var_0106 method_805B();
      }
    }
  }
}

func_93C8(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    var_01 = level.var_2807[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(!isDefined(var_03.var_5EED)) {
          continue;
        }

        var_03.var_5EED delete();
      }

      return;
    }

    return;
  }

  for(var_05 = 0; var_05 < level.var_2804.size; var_05++) {
    var_03 = level.var_2804[var_05];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03.var_A265["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_03.var_A265["exploder"])) {
      continue;
    }

    if(var_03.var_A265["exploder"] + "" != param_00) {
      continue;
    }

    if(!isDefined(var_03.var_5EED)) {
      continue;
    }

    var_03.var_5EED delete();
  }
}

func_417F(param_00) {
  param_00 = param_00 + "";
  var_01 = [];
  if(isDefined(level.var_2807)) {
    var_02 = level.var_2807[param_00];
    if(isDefined(var_02)) {
      var_01 = var_02;
    }
  } else {
    foreach(var_04 in level.var_2804) {
      if(var_04.var_A265["type"] != "exploder") {
        continue;
      }

      if(!isDefined(var_04.var_A265["exploder"])) {
        continue;
      }

      if(var_04.var_A265["exploder"] + "" != param_00) {
        continue;
      }

      var_01[var_01.size] = var_04;
    }
  }

  return var_01;
}

func_4CE3(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    var_01 = level.var_2807[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isDefined(var_03.var_0106)) {
          var_03.var_0106 method_805C();
        }
      }

      return;
    }

    return;
  }

  for(var_05 = 0; var_05 < level.var_2804.size; var_05++) {
    var_03 = level.var_2804[var_05];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03.var_A265["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_03.var_A265["exploder"])) {
      continue;
    }

    if(var_03.var_A265["exploder"] + "" != param_00) {
      continue;
    }

    if(isDefined(var_03.var_0106)) {
      var_03.var_0106 method_805C();
    }
  }
}

func_2D0D(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    var_01 = level.var_2807[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isDefined(var_03.var_0106)) {
          var_03.var_0106 delete();
        }
      }
    }
  } else {
    for(var_05 = 0; var_05 < level.var_2804.size; var_05++) {
      var_03 = level.var_2804[var_05];
      if(!isDefined(var_03)) {
        continue;
      }

      if(var_03.var_A265["type"] != "exploder") {
        continue;
      }

      if(!isDefined(var_03.var_A265["exploder"])) {
        continue;
      }

      if(var_03.var_A265["exploder"] + "" != param_00) {
        continue;
      }

      if(isDefined(var_03.var_0106)) {
        var_03.var_0106 delete();
      }
    }
  }

  level notify("killexplodertridgers" + param_00);
}

func_392F() {
  if(isDefined(self.var_A265["delay"])) {
    var_00 = self.var_A265["delay"];
  } else {
    var_00 = 0;
  }

  if(isDefined(self.var_A265["damage_radius"])) {
    var_01 = self.var_A265["damage_radius"];
  } else {
    var_01 = 128;
  }

  var_02 = self.var_A265["damage"];
  var_03 = self.var_A265["origin"];
  wait(var_00);
  if(isDefined(level.var_2971)) {
    [[level.var_2971]](var_03, var_01, var_02);
    return;
  }

  radiusdamage(var_03, var_01, var_02, var_02);
}

func_0895() {
  if(isDefined(self.var_A265["firefx"])) {
    thread func_3BB8();
  }

  if(isDefined(self.var_A265["fxid"]) && self.var_A265["fxid"] != "No FX") {
    thread func_1F5E();
  }

  if(isDefined(self.var_A265["soundalias"]) && self.var_A265["soundalias"] != "nil") {
    thread func_8F30();
  }

  if(isDefined(self.var_A265["loopsound"]) && self.var_A265["loopsound"] != "nil") {
    thread func_359F();
  }

  if(isDefined(self.var_A265["damage"])) {
    thread func_392F();
  }

  if(isDefined(self.var_A265["earthquake"])) {
    thread func_3931();
  }

  if(isDefined(self.var_A265["rumble"])) {
    thread func_393F();
  }

  if(self.var_A265["exploder_type"] == "exploder") {
    thread func_1CB3();
    return;
  }

  if(self.var_A265["exploder_type"] == "exploderchunk" || self.var_A265["exploder_type"] == "exploderchunk visible") {
    thread func_1CB5();
    return;
  }

  thread func_1CB2();
}

func_1CB2() {
  var_00 = self.var_A265["exploder"];
  if(isDefined(self.var_A265["delay"]) && self.var_A265["delay"] >= 0) {
    wait(self.var_A265["delay"]);
  } else {
    wait 0.05;
  }

  if(!isDefined(self.var_0106)) {
    return;
  }

  if(isDefined(self.var_0106.var_003A)) {
    if(common_scripts\utility::func_57D7() && self.var_0106.var_0187 & 1) {
      self.var_0106[[level.var_2587]]();
    }
  }

  if(level.var_27F6) {
    if(isDefined(self.var_3928)) {
      return;
    }

    self.var_3928 = 1;
    self.var_0106 method_805C();
    self.var_0106 notsolid();
    wait(3);
    self.var_3928 = undefined;
    self.var_0106 method_805B();
    self.var_0106 solid();
    return;
  }

  if(!isDefined(self.var_A265["fxid"]) || self.var_A265["fxid"] == "No FX") {
    self.var_A265["exploder"] = undefined;
  }

  waittillframeend;
  if(isDefined(self.var_0106) && isDefined(self.var_0106.var_003A)) {
    self.var_0106 delete();
  }
}

func_1CB5() {
  if(isDefined(self.var_A265["delay"])) {
    wait(self.var_A265["delay"]);
  }

  var_00 = undefined;
  if(isDefined(self.var_A265["target"])) {
    var_00 = common_scripts\utility::func_4375(self.var_A265["target"]);
  }

  if(!isDefined(var_00)) {
    self.var_0106 delete();
    return;
  }

  self.var_0106 method_805B();
  if(isDefined(self.var_A265["delay_post"])) {
    wait(self.var_A265["delay_post"]);
  }

  var_01 = self.var_A265["origin"];
  var_02 = self.var_A265["angles"];
  var_03 = var_00.var_0116;
  var_04 = var_03 - self.var_A265["origin"];
  var_05 = var_04[0];
  var_06 = var_04[1];
  var_07 = var_04[2];
  var_08 = isDefined(self.var_A265["physics"]);
  if(var_08) {
    var_09 = undefined;
    if(isDefined(var_00.var_01A2)) {
      var_09 = var_00 common_scripts\utility::func_4375();
    }

    if(!isDefined(var_09)) {
      var_0A = var_01;
      var_0B = var_00.var_0116;
    } else {
      var_0A = var_02.var_0116;
      var_0B = var_0A.var_0116 - var_01.var_0116 * self.var_A265["physics"];
    }

    self.var_0106 method_82C5(var_0A, var_0B);
    return;
  } else {
    self.var_0106 rotatevelocity((var_08, var_09, var_0A), 12);
    self.var_0106 gravitymove((var_08, var_09, var_0A), 12);
  }

  if(level.var_27F6) {
    if(isDefined(self.var_3928)) {
      return;
    }

    self.var_3928 = 1;
    wait(3);
    self.var_3928 = undefined;
    self.var_A265["origin"] = var_04;
    self.var_A265["angles"] = var_05;
    self.var_0106 method_805C();
    return;
  }

  self.var_A265["exploder"] = undefined;
  wait(6);
  self.var_0106 delete();
}

func_1CB3() {
  if(isDefined(self.var_A265["delay"])) {
    wait(self.var_A265["delay"]);
  }

  if(!isDefined(self.var_0106.var_8205)) {
    self.var_0106 method_805B();
    self.var_0106 solid();
  } else {
    var_00 = self.var_0106 common_scripts\utility::func_8FFC();
    if(isDefined(self.var_0106.var_0164)) {
      var_00.var_0164 = self.var_0106.var_0164;
    }

    var_00 setModel(self.var_0106.var_8205);
    var_00 method_805B();
  }

  self.var_1CB4 = 1;
  if(common_scripts\utility::func_57D7() && !isDefined(self.var_0106.var_8205) && self.var_0106.var_0187 & 1) {
    if(!isDefined(self.var_0106.var_2FBF)) {
      self.var_0106[[level.var_2587]]();
    } else {
      self.var_0106[[level.var_2FC3]]();
    }
  }

  if(level.var_27F6) {
    if(isDefined(self.var_3928)) {
      return;
    }

    self.var_3928 = 1;
    wait(3);
    self.var_3928 = undefined;
    if(!isDefined(self.var_0106.var_8205)) {
      self.var_0106 method_805C();
      self.var_0106 notsolid();
    }
  }
}

func_393F() {
  if(!common_scripts\utility::func_57D7()) {
    return;
  }

  func_3930();
  level.var_721C playrumbleonentity(self.var_A265["rumble"]);
}

func_3930() {
  if(!isDefined(self.var_A265["delay"])) {
    self.var_A265["delay"] = 0;
  }

  var_00 = self.var_A265["delay"];
  var_01 = self.var_A265["delay"] + 0.001;
  if(isDefined(self.var_A265["delay_min"])) {
    var_00 = self.var_A265["delay_min"];
  }

  if(isDefined(self.var_A265["delay_max"])) {
    var_01 = self.var_A265["delay_max"];
  }

  if(var_00 > 0) {
    var_02 = randomfloatrange(var_00, var_01);
    self.var_08F0 = var_02;
    wait(var_02);
  }
}

func_359F() {
  common_scripts\utility::func_3F51();
  var_00 = self.var_A265["origin"];
  var_01 = self.var_A265["loopsound"];
  func_3930();
  common_scripts\utility::func_5EDF(var_01, var_00);
}

func_8F30() {
  func_35A0();
}

func_35A0() {
  var_00 = self.var_A265["origin"];
  var_01 = self.var_A265["soundalias"];
  func_3930();
  common_scripts\utility::func_3F50(var_01, var_00);
}

func_3931() {
  func_3930();
  common_scripts\utility::func_30AE(self.var_A265["earthquake"], self.var_A265["origin"]);
}

func_393D() {
  if(!isDefined(self.var_A265["soundalias"]) || self.var_A265["soundalias"] == "nil") {
    return;
  }

  common_scripts\utility::func_3F50(self.var_A265["soundalias"], self.var_A265["origin"]);
}

func_3BB8() {
  var_00 = self.var_A265["forward"];
  var_01 = self.var_A265["up"];
  var_02 = undefined;
  var_03 = self.var_A265["firefxsound"];
  var_04 = self.var_A265["origin"];
  var_05 = self.var_A265["firefx"];
  var_06 = self.var_A265["ender"];
  if(!isDefined(var_06)) {
    var_06 = "createfx_effectStopper";
  }

  var_07 = 0.5;
  if(isDefined(self.var_A265["firefxdelay"])) {
    var_07 = self.var_A265["firefxdelay"];
  }

  func_3930();
  if(isDefined(var_03)) {
    common_scripts\utility::func_5EE2(var_03, var_04, (0, 0, 0), 1, var_06);
  }

  playFX(level.var_0611[var_05], self.var_A265["origin"], var_00, var_01);
}

func_1F5E() {
  if(isDefined(self.var_A265["repeat"])) {
    thread func_393D();
    for(var_00 = 0; var_00 < self.var_A265["repeat"]; var_00++) {
      playFX(level.var_0611[self.var_A265["fxid"]], self.var_A265["origin"], self.var_A265["forward"], self.var_A265["up"]);
      func_3930();
    }

    return;
  }

  if(!isDefined(self.var_A265["delay"])) {
    self.var_A265["delay"] = 0;
  }

  if(self.var_A265["delay"] >= 0) {
    func_3930();
    var_01 = 0;
  } else {
    var_01 = self.var_A265["delay"];
  }

  if(isDefined(self.var_5EED)) {
    self.var_5EED delete();
  }

  self.var_5EED = spawnfx(common_scripts\utility::func_44F5(self.var_A265["fxid"]), self.var_A265["origin"], self.var_A265["forward"], self.var_A265["up"]);
  if(level.var_27F6) {
    function_014E(self.var_5EED, 1);
  }

  if(self.var_A265["delay"] >= 0) {
    triggerfx(self.var_5EED);
  } else {
    triggerfx(self.var_5EED, var_01);
  }

  func_393D();
}

func_0891(param_00, param_01, param_02) {
  param_00 = param_00 + "";
  level notify("exploding_" + param_00);
  var_03 = 0;
  if(isDefined(level.var_2807) && !level.var_27F6) {
    var_04 = level.var_2807[param_00];
    if(isDefined(var_04)) {
      foreach(var_06 in var_04) {
        if(!var_06 func_2158()) {
          continue;
        }

        var_06 common_scripts\utility::func_0894();
        var_03 = 1;
      }
    }
  } else {
    for(var_08 = 0; var_08 < level.var_2804.size; var_08++) {
      var_06 = level.var_2804[var_08];
      if(!isDefined(var_06)) {
        continue;
      }

      if(var_06.var_A265["type"] != "exploder") {
        continue;
      }

      if(!isDefined(var_06.var_A265["exploder"])) {
        continue;
      }

      if(var_06.var_A265["exploder"] + "" != param_00) {
        continue;
      }

      if(!var_06 func_2158()) {
        continue;
      }

      var_06 common_scripts\utility::func_0894();
      var_03 = 1;
    }
  }

  if(!func_8BA5() && !var_03) {
    func_088E(param_00, param_01, param_02);
  }
}

func_392A(param_00, param_01, param_02) {
  [[level.var_062E.var_3945]](param_00, param_01, param_02);
}

func_5A01(param_00) {
  var_01 = func_44D1(param_00);
  if(isDefined(var_01)) {
    foreach(var_03 in var_01) {
      if(isDefined(var_03.var_5EED)) {
        function_014E(var_03.var_5EED, 1);
      }
    }

    wait 0.05;
    foreach(var_03 in var_01) {
      var_03 common_scripts\utility::func_6F21();
    }
  }
}

func_2158() {
  var_00 = self;
  return 1;
}

func_088E(param_00, param_01, param_02) {
  if(!func_5640(param_00)) {
    return;
  }

  var_03 = int(param_00);
  activateclientexploder(var_03, param_01, param_02);
}

func_2A6D(param_00, param_01, param_02) {
  if(!func_5640(param_00)) {
    return;
  }

  var_03 = int(param_00);
  stopclientexploder(var_03, param_01, param_02);
}

func_5640(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = param_00;
  if(isstring(param_00)) {
    var_01 = int(param_00);
    if(var_01 == 0 && param_00 != "0") {
      return 0;
    }
  }

  return var_01 >= 0;
}

func_8BA5() {
  if(common_scripts\utility::func_57D7()) {
    return 1;
  }

  if(!isDefined(level.var_27F6)) {
    level.var_27F6 = getDvar("1459") != "";
  }

  if(level.var_27F6) {
    return 1;
  }

  return getDvar("3508") != "1";
}

func_392D(param_00, param_01, param_02) {
  waittillframeend;
  waittillframeend;
  func_0891(param_00, param_01, param_02);
}

func_392B(param_00, param_01, param_02) {
  func_0891(param_00, param_01, param_02);
}