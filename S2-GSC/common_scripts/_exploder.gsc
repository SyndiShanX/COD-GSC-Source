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
  foreach(var_03 in level.createfxent) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03.v["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_03.v["exploder"])) {
      continue;
    }

    if(var_03.v["exploder"] == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

func_885C(param_00) {
  var_01 = param_00.setdepthoffield;
  if(!isDefined(level.var_3948[var_01])) {
    level.var_3948[var_01] = [];
  }

  var_02 = param_00.targetname;
  if(!isDefined(var_02)) {
    var_02 = "";
  }

  level.var_3948[var_01][level.var_3948[var_01].size] = param_00;
  if(func_393B(param_00)) {
    param_00 hide();
    return;
  }

  if(func_393A(param_00)) {
    param_00 hide();
    param_00 notsolid();
    if(isDefined(param_00.spawnflags) && param_00.spawnflags & 1) {
      if(isDefined(param_00.var_8166)) {
        param_00 connectpaths();
      }
    }

    return;
  }

  if(func_3939(param_00)) {
    param_00 hide();
    param_00 notsolid();
    if(isDefined(param_00.spawnflags) && param_00.spawnflags & 1) {
      param_00 connectpaths();
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
      var_04.setdepthoffield = var_04.var_8272;
    }

    if(isDefined(var_04.var_6019)) {
      continue;
    }

    if(isDefined(var_04.setdepthoffield)) {
      func_885C(var_04);
    }
  }

  var_06 = [];
  var_07 = getEntArray("script_brushmodel", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].setdepthoffield = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].setdepthoffield)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = getEntArray("script_model", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].setdepthoffield = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].setdepthoffield)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = getEntArray("script_origin", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].setdepthoffield = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].setdepthoffield)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = getEntArray("item_health", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].setdepthoffield = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].setdepthoffield)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = level.struct;
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(!isDefined(var_07[var_02])) {
      continue;
    }

    if(isDefined(var_07[var_02].var_8272)) {
      var_07[var_02].setdepthoffield = var_07[var_02].var_8272;
    }

    if(isDefined(var_07[var_02].setdepthoffield)) {
      if(!isDefined(var_07[var_02].angles)) {
        var_07[var_02].angles = (0, 0, 0);
      }

      var_06[var_06.size] = var_07[var_02];
    }
  }

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var_08 = [];
  var_08["exploderchunk visible"] = 1;
  var_08["exploderchunk"] = 1;
  var_08["exploder"] = 1;
  thread func_8825();
  for(var_02 = 0; var_02 < var_06.size; var_02++) {
    var_09 = var_06[var_02];
    var_04 = common_scripts\utility::createexploder(var_09.var_81BB);
    var_04.v = [];
    var_04.v["origin"] = var_09.origin;
    var_04.v["angles"] = var_09.angles;
    var_04.v["delay"] = var_09.script_delay;
    var_04.v["delay_post"] = var_09.var_8155;
    var_04.v["firefx"] = var_09.var_8193;
    var_04.v["firefxdelay"] = var_09.var_8194;
    var_04.v["firefxsound"] = var_09.var_8195;
    var_04.v["firefxtimeout"] = var_09.var_8196;
    var_04.v["earthquake"] = var_09.var_817B;
    var_04.v["rumble"] = var_09.var_827D;
    var_04.v["damage"] = var_09.var_8146;
    var_04.v["damage_radius"] = var_09.scriptmodelplayanim;
    var_04.v["soundalias"] = var_09.var_828B;
    var_04.v["repeat"] = var_09.var_8278;
    var_04.v["delay_min"] = var_09.var_8154;
    var_04.v["delay_max"] = var_09.var_8153;
    var_04.v["target"] = var_09.target;
    var_04.v["ender"] = var_09.var_817E;
    var_04.v["physics"] = var_09.iprintlnbold;
    var_04.v["type"] = "exploder";
    if(!isDefined(var_09.var_81BB)) {
      var_04.v["fxid"] = "No FX";
    } else {
      var_04.v["fxid"] = var_09.var_81BB;
    }

    var_04.v["exploder"] = var_09.setdepthoffield;
    if(isDefined(level.var_2807)) {
      var_0A = level.var_2807[var_04.v["exploder"]];
      if(!isDefined(var_0A)) {
        var_0A = [];
      }

      var_0A[var_0A.size] = var_04;
      level.var_2807[var_04.v["exploder"]] = var_0A;
    }

    if(!isDefined(var_04.v["delay"])) {
      var_04.v["delay"] = 0;
    }

    if(isDefined(var_09.target)) {
      var_0B = getEntArray(var_04.v["target"], "targetname")[0];
      if(isDefined(var_0B)) {
        var_0C = var_0B.origin;
        var_04.v["angles"] = vectortoangles(var_0C - var_04.v["origin"]);
      } else {
        var_0B = common_scripts\utility::func_4375(var_04.v["target"]);
        if(isDefined(var_0B)) {
          var_0C = var_0B.origin;
          var_04.v["angles"] = vectortoangles(var_0C - var_04.v["origin"]);
        }
      }
    }

    if(!isDefined(var_09.code_classname)) {
      var_04.model = var_09;
      if(isDefined(var_04.model.var_8205)) {
        precachemodel(var_04.model.var_8205);
      }
    } else if(var_09.code_classname == "script_brushmodel" || isDefined(var_09.model)) {
      var_04.model = var_09;
      var_04.model.var_2FBF = var_09.var_8166;
    }

    if(isDefined(var_09.targetname) && isDefined(var_08[var_09.targetname])) {
      var_04.v["exploder_type"] = var_09.targetname;
    } else {
      var_04.v["exploder_type"] = "normal";
    }

    if(isDefined(var_09.var_6019)) {
      var_04.v["masked_exploder"] = var_09.model;
      var_04.v["masked_exploder_spawnflags"] = var_09.spawnflags;
      var_04.v["masked_exploder_script_disconnectpaths"] = var_09.var_8166;
      var_09 delete();
    }

    var_04 common_scripts\_createfx::post_entity_creation_function();
  }
}

func_8825() {
  waittillframeend;
  waittillframeend;
  waittillframeend;
  var_00 = [];
  foreach(var_02 in level.createfxent) {
    if(var_02.v["type"] != "exploder") {
      continue;
    }

    var_03 = var_02.v["flag"];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 == "nil") {
      var_02.v["flag"] = undefined;
    }

    var_00[var_03] = 1;
  }

  foreach(var_07, var_06 in var_00) {
    thread func_3933(var_07);
  }
}

func_3933(param_00) {
  if(!common_scripts\utility::func_3C83(param_00)) {
    common_scripts\utility::flag_init(param_00);
  }

  common_scripts\utility::func_3C9F(param_00);
  foreach(var_02 in level.createfxent) {
    if(var_02.v["type"] != "exploder") {
      continue;
    }

    var_03 = var_02.v["flag"];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 != param_00) {
      continue;
    }

    var_02 common_scripts\utility::activate_individual_exploder();
  }
}

func_393A(param_00) {
  return isDefined(param_00.targetname) && param_00.targetname == "exploder";
}

func_393B(param_00) {
  return param_00.model == "fx" && !isDefined(param_00.targetname) || param_00.targetname != "exploderchunk";
}

func_3939(param_00) {
  return isDefined(param_00.targetname) && param_00.targetname == "exploderchunk";
}

func_8BCA(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    var_01 = level.var_2807[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(!func_393B(var_03.model) && !func_393A(var_03.model) && !func_3939(var_03.model)) {
          var_03.model show();
        }

        if(isDefined(var_03.var_1CB4)) {
          var_03.model show();
        }
      }

      return;
    }

    return;
  }

  var_05 = 0;
  while(var_03 < level.createfxent.size) {
    var_05 = level.createfxent[var_03];
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05.v["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_05.v["exploder"])) {
      continue;
    }

    if(var_05.v["exploder"] + "" != var_02) {
      continue;
    }

    if(isDefined(var_05.model)) {
      if(!func_393B(var_05.model) && !func_393A(var_05.model) && !func_3939(var_05.model)) {
        var_05.model show();
      }

      if(isDefined(var_05.var_1CB4)) {
        var_05.model show();
      }
    }

    var_03++;
  }
}

func_93C8(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    var_01 = level.var_2807[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(!isDefined(var_03.looper)) {
          continue;
        }

        var_03.looper delete();
      }

      return;
    }

    return;
  }

  var_05 = 0;
  while(var_03 < level.createfxent.size) {
    var_05 = level.createfxent[var_03];
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05.v["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_05.v["exploder"])) {
      continue;
    }

    if(var_05.v["exploder"] + "" != var_02) {
      continue;
    }

    if(!isDefined(var_05.looper)) {
      continue;
    }

    var_05.looper delete();
    var_03++;
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
    foreach(var_04 in level.createfxent) {
      if(var_04.v["type"] != "exploder") {
        continue;
      }

      if(!isDefined(var_04.v["exploder"])) {
        continue;
      }

      if(var_04.v["exploder"] + "" != param_00) {
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
        if(isDefined(var_03.model)) {
          var_03.model hide();
        }
      }

      return;
    }

    return;
  }

  var_05 = 0;
  while(var_03 < level.createfxent.size) {
    var_05 = level.createfxent[var_03];
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05.v["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_05.v["exploder"])) {
      continue;
    }

    if(var_05.v["exploder"] + "" != var_02) {
      continue;
    }

    if(isDefined(var_05.model)) {
      var_05.model hide();
    }

    var_03++;
  }
}

func_2D0D(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.var_2807)) {
    var_01 = level.var_2807[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isDefined(var_03.model)) {
          var_03.model delete();
        }
      }
    }
  } else {
    for(var_05 = 0; var_05 < level.createfxent.size; var_05++) {
      var_03 = level.createfxent[var_05];
      if(!isDefined(var_03)) {
        continue;
      }

      if(var_03.v["type"] != "exploder") {
        continue;
      }

      if(!isDefined(var_03.v["exploder"])) {
        continue;
      }

      if(var_03.v["exploder"] + "" != param_00) {
        continue;
      }

      if(isDefined(var_03.model)) {
        var_03.model delete();
      }
    }
  }

  level notify("killexplodertridgers" + param_00);
}

func_392F() {
  if(isDefined(self.v["delay"])) {
    var_00 = self.v["delay"];
  } else {
    var_00 = 0;
  }

  if(isDefined(self.v["damage_radius"])) {
    var_01 = self.v["damage_radius"];
  } else {
    var_01 = 128;
  }

  var_02 = self.v["damage"];
  var_03 = self.v["origin"];
  wait(var_00);
  if(isDefined(level.var_2971)) {
    [[level.var_2971]](var_03, var_01, var_02);
    return;
  }

  radiusdamage(var_03, var_01, var_02, var_02);
}

func_0895() {
  if(isDefined(self.v["firefx"])) {
    thread func_3BB8();
  }

  if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX") {
    thread func_1F5E();
  }

  if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
    thread func_8F30();
  }

  if(isDefined(self.v["loopsound"]) && self.v["loopsound"] != "nil") {
    thread func_359F();
  }

  if(isDefined(self.v["damage"])) {
    thread func_392F();
  }

  if(isDefined(self.v["earthquake"])) {
    thread func_3931();
  }

  if(isDefined(self.v["rumble"])) {
    thread func_393F();
  }

  if(self.v["exploder_type"] == "exploder") {
    thread func_1CB3();
    return;
  }

  if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible") {
    thread func_1CB5();
    return;
  }

  thread func_1CB2();
}

func_1CB2() {
  var_00 = self.v["exploder"];
  if(isDefined(self.v["delay"]) && self.v["delay"] >= 0) {
    wait(self.v["delay"]);
  } else {
    wait 0.05;
  }

  if(!isDefined(self.model)) {
    return;
  }

  if(isDefined(self.model.classname)) {
    if(common_scripts\utility::issp() && self.model.spawnflags & 1) {
      self.model[[level.connectpathsfunction]]();
    }
  }

  if(level.var_27F6) {
    if(isDefined(self.var_3928)) {
      return;
    }

    self.var_3928 = 1;
    self.model hide();
    self.model notsolid();
    wait(3);
    self.var_3928 = undefined;
    self.model show();
    self.model solid();
    return;
  }

  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX") {
    self.v["exploder"] = undefined;
  }

  waittillframeend;
  if(isDefined(self.model) && isDefined(self.model.classname)) {
    self.model delete();
  }
}

func_1CB5() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }

  var_00 = undefined;
  if(isDefined(self.v["target"])) {
    var_00 = common_scripts\utility::func_4375(self.v["target"]);
  }

  if(!isDefined(var_00)) {
    self.model delete();
    return;
  }

  self.model show();
  if(isDefined(self.v["delay_post"])) {
    wait(self.v["delay_post"]);
  }

  var_01 = self.v["origin"];
  var_02 = self.v["angles"];
  var_03 = var_00.origin;
  var_04 = var_03 - self.v["origin"];
  var_05 = var_04[0];
  var_06 = var_04[1];
  var_07 = var_04[2];
  var_08 = isDefined(self.v["physics"]);
  if(var_08) {
    var_09 = undefined;
    if(isDefined(var_00.target)) {
      var_09 = var_00 common_scripts\utility::func_4375();
    }

    if(!isDefined(var_09)) {
      var_0A = var_01;
      var_0B = var_00.origin;
    } else {
      var_0A = var_02.origin;
      var_0B = var_0A.origin - var_01.origin * self.v["physics"];
    }

    self.model method_82C5(var_0A, var_0B);
    return;
  } else {
    self.model rotatevelocity((var_08, var_09, var_0A), 12);
    self.model gravitymove((var_08, var_09, var_0A), 12);
  }

  if(level.var_27F6) {
    if(isDefined(self.var_3928)) {
      return;
    }

    self.var_3928 = 1;
    wait(3);
    self.var_3928 = undefined;
    self.v["origin"] = var_04;
    self.v["angles"] = var_05;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait(6);
  self.model delete();
}

func_1CB3() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }

  if(!isDefined(self.model.var_8205)) {
    self.model show();
    self.model solid();
  } else {
    var_00 = self.model common_scripts\utility::func_8FFC();
    if(isDefined(self.model.script_linkname)) {
      var_00.script_linkname = self.model.script_linkname;
    }

    var_00 setModel(self.model.var_8205);
    var_00 show();
  }

  self.var_1CB4 = 1;
  if(common_scripts\utility::issp() && !isDefined(self.model.var_8205) && self.model.spawnflags & 1) {
    if(!isDefined(self.model.var_2FBF)) {
      self.model[[level.connectpathsfunction]]();
    } else {
      self.model[[level.var_2FC3]]();
    }
  }

  if(level.var_27F6) {
    if(isDefined(self.var_3928)) {
      return;
    }

    self.var_3928 = 1;
    wait(3);
    self.var_3928 = undefined;
    if(!isDefined(self.model.var_8205)) {
      self.model hide();
      self.model notsolid();
    }
  }
}

func_393F() {
  if(!common_scripts\utility::issp()) {
    return;
  }

  func_3930();
  level.player playRumbleOnEntity(self.v["rumble"]);
}

func_3930() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }

  var_00 = self.v["delay"];
  var_01 = self.v["delay"] + 0.001;
  if(isDefined(self.v["delay_min"])) {
    var_00 = self.v["delay_min"];
  }

  if(isDefined(self.v["delay_max"])) {
    var_01 = self.v["delay_max"];
  }

  if(var_00 > 0) {
    var_02 = randomfloatrange(var_00, var_01);
    self.var_8F0 = var_02;
    wait(var_02);
  }
}

func_359F() {
  common_scripts\utility::func_3F51();
  var_00 = self.v["origin"];
  var_01 = self.v["loopsound"];
  func_3930();
  common_scripts\utility::func_5EDF(var_01, var_00);
}

func_8F30() {
  func_35A0();
}

func_35A0() {
  var_00 = self.v["origin"];
  var_01 = self.v["soundalias"];
  func_3930();
  common_scripts\utility::func_3F50(var_01, var_00);
}

func_3931() {
  func_3930();
  common_scripts\utility::func_30AE(self.v["earthquake"], self.v["origin"]);
}

func_393D() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }

  common_scripts\utility::func_3F50(self.v["soundalias"], self.v["origin"]);
}

func_3BB8() {
  var_00 = self.v["forward"];
  var_01 = self.v["up"];
  var_02 = undefined;
  var_03 = self.v["firefxsound"];
  var_04 = self.v["origin"];
  var_05 = self.v["firefx"];
  var_06 = self.v["ender"];
  if(!isDefined(var_06)) {
    var_06 = "createfx_effectStopper";
  }

  var_07 = 0.5;
  if(isDefined(self.v["firefxdelay"])) {
    var_07 = self.v["firefxdelay"];
  }

  func_3930();
  if(isDefined(var_03)) {
    common_scripts\utility::func_5EE2(var_03, var_04, (0, 0, 0), 1, var_06);
  }

  playFX(level._effect[var_05], self.v["origin"], var_00, var_01);
}

func_1F5E() {
  if(isDefined(self.v["repeat"])) {
    thread func_393D();
    for(var_00 = 0; var_00 < self.v["repeat"]; var_00++) {
      playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      func_3930();
    }

    return;
  }

  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }

  if(self.v["delay"] >= 0) {
    func_3930();
    var_01 = 0;
  } else {
    var_01 = self.v["delay"];
  }

  if(isDefined(self.looper)) {
    self.looper delete();
  }

  self.looper = spawnfx(common_scripts\utility::func_44F5(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  if(level.var_27F6) {
    function_014E(self.looper, 1);
  }

  if(self.v["delay"] >= 0) {
    triggerfx(self.looper);
  } else {
    triggerfx(self.looper, var_01);
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

        var_06 common_scripts\utility::activate_individual_exploder();
        var_03 = 1;
      }
    }
  } else {
    for(var_08 = 0; var_08 < level.createfxent.size; var_08++) {
      var_06 = level.createfxent[var_08];
      if(!isDefined(var_06)) {
        continue;
      }

      if(var_06.v["type"] != "exploder") {
        continue;
      }

      if(!isDefined(var_06.v["exploder"])) {
        continue;
      }

      if(var_06.v["exploder"] + "" != param_00) {
        continue;
      }

      if(!var_06 func_2158()) {
        continue;
      }

      var_06 common_scripts\utility::activate_individual_exploder();
      var_03 = 1;
    }
  }

  if(!func_8BA5() && !var_03) {
    func_088E(param_00, param_01, param_02);
  }
}

exploder(param_00, param_01, param_02) {
  [[level._fx.var_3945]](param_00, param_01, param_02);
}

kill_exploder(param_00) {
  var_01 = func_44D1(param_00);
  if(isDefined(var_01)) {
    foreach(var_03 in var_01) {
      if(isDefined(var_03.looper)) {
        function_014E(var_03.looper, 1);
      }
    }

    wait 0.05;
    foreach(var_03 in var_01) {
      var_03 common_scripts\utility::pauseeffect();
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
  if(common_scripts\utility::issp()) {
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