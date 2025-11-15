/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2883.gsc
************************/

register_interaction(param_00, param_01) {
  level.interactions[param_00] = param_01;
}

func_DED9(param_00, param_01) {
  level.var_10E1C[param_00] = param_01;
}

func_7A45(param_00) {
  if(!isDefined(level.interactions) || !isDefined(level.interactions[param_00])) {
    return undefined;
  }

  return level.interactions[param_00];
}

func_7CA7(param_00) {
  if(!issubstr(param_00, "casual") && !issubstr(param_00, "alert")) {
    if(isDefined(self.asm)) {
      var_01 = scripts\asm\asm::asm_getdemeanor();
      if(var_01 == "casual") {
        param_00 = param_00 + "_" + var_01;
      } else {
        param_00 = param_00 + "_alert";
      }
    } else {
      param_00 = param_00 + "_casual";
    }
  }

  if(!isDefined(level.var_10E1C) || !isDefined(level.var_10E1C[param_00])) {
    return undefined;
  }

  return level.var_10E1C[param_00];
}

func_9C27(param_00) {
  return isDefined(level.interactions) && isDefined(level.interactions[param_00]);
}

func_9CD8(param_00) {
  return isDefined(level.var_10E1C) && isDefined(level.var_10E1C[param_00 + "_casual"]);
}

func_9CD7(param_00) {
  if(isDefined(param_00.var_EE92) && func_9CD8(param_00.var_EE92)) {
    return 1;
  }

  return 0;
}

func_9C26(param_00) {
  if(isDefined(param_00.var_EE92) && func_9C27(param_00.var_EE92)) {
    return 1;
  }

  if(isDefined(param_00.script_noteworthy) && func_9C27(param_00.script_noteworthy)) {
    return 1;
  }

  return 0;
}

func_9C25(param_00) {
  if(isDefined(param_00.var_EE92)) {
    if(func_9C27(param_00.var_EE92) || param_00.var_EE92 == "combat_reaction") {
      return 1;
    }
  }

  return 0;
}

func_7837(param_00) {
  var_01 = scripts\asm\asm::asm_getdemeanor();
  if(isDefined(param_00.var_22F2)) {
    return param_00.var_22F2[var_01];
  }

  return undefined;
}

func_79A5(param_00) {
  var_01 = scripts\asm\asm::asm_getdemeanor();
  if(isDefined(param_00.var_6980)) {
    return param_00.var_6980[var_01];
  }

  return undefined;
}

func_7A30(param_00) {
  var_01 = scripts\asm\asm::asm_getdemeanor();
  return param_00.var_92FA;
}

func_F96C(param_00) {
  if(!isai(self)) {
    return;
  }

  self.asm.var_4C86.interaction = param_00;
  var_01 = func_7A45(param_00);
  if(!isDefined(var_01)) {
    var_01 = func_7CA7(param_00);
  }

  self.asm.var_4C86.var_697F = func_79A5(var_01);
}

func_CD4C(param_00, param_01, param_02, param_03, param_04) {
  param_00 = func_7A45(param_00);
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = 0.05;
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  func_10C47(param_00.var_EBEA[param_01]);
  self _meth_82E1(param_01, param_00.var_EBEA[param_01], param_02, param_03, param_04);
}

func_509D(param_00) {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var_01 = undefined;
  for(;;) {
    if(isstruct(param_00) || isent(param_00)) {
      var_01 = param_00.origin;
    } else if(isvector(param_00)) {
      var_01 = param_00;
    }

    if(isDefined(self.var_B004)) {
      self.var_B004["interaction_position"] = var_01;
    }

    scripts\engine\utility::waitframe();
  }
}

func_DE14(param_00) {
  var_01 = undefined;
  if(isDefined(self.var_B004)) {
    var_01 = self.var_B004["trigger_radius"];
    self.var_B004["trigger_radius"] = param_00;
    thread func_13B1(var_01);
  }
}

func_13B1(param_00) {
  self endon("interaction_end");
  self endon("reaction_end");
  self waittill("interaction_done");
  self.var_B004["trigger_radius"] = param_00;
}

func_CD4B(param_00, param_01, param_02) {
  self endon("death");
  self notify("reaction_end");
  var_03 = func_7A45(param_00);
  func_F96C(param_00);
  if(!isDefined(var_03)) {
    return;
  }

  self.var_B004 = var_03.var_EBEA;
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_1F25 = 0;
  self.var_EBF8 = 0;
  self.var_F274 = 0;
  self.var_10254 = 0;
  self.var_9C84 = 0;
  self.var_BE79 = 0;
  self.var_9A30 = param_00;
  self.var_DD4C = 1;
  if(!isDefined(self.var_1C4D)) {
    self.var_1C4D = 1;
  }

  if(isDefined(level.var_9A2E)) {
    scripts\sp\interaction_manager::func_168F();
    level.var_9A2E.var_4D94["registered_interactions"][param_00] = [];
    if(isDefined(var_03.var_EBEA["vo_lines_male"])) {
      level.var_9A2E.var_4D94["registered_interactions"][param_00]["vo_lines_male"] = var_03.var_EBEA["vo_lines_male"];
    }

    if(isDefined(var_03.var_EBEA["vo_lines_female"])) {
      level.var_9A2E.var_4D94["registered_interactions"][param_00]["vo_lines_female"] = var_03.var_EBEA["vo_lines_female"];
    }
  }

  if(isDefined(param_01)) {
    var_04 = undefined;
    if(isarray(self.var_B004["idle"])) {
      var_05 = self.var_B004["idle"][0];
    } else {
      var_05 = self.var_B004["idle"];
    }

    if(isstring(param_01)) {
      var_04 = scripts\engine\utility::getstruct(param_01, "targetname");
    } else if(isstruct(param_01)) {
      var_04 = param_01;
    } else if(isent(param_01)) {
      var_04 = param_01;
    } else {
      return;
    }

    var_06 = var_05;
    var_07 = getstartorigin(var_04.origin, var_04.angles, var_06);
    var_08 = getstartangles(var_04.origin, var_04.angles, var_06);
    if(!isDefined(self.var_9B89)) {
      self _meth_80F1(var_07, var_08);
    } else {
      self.origin = var_07;
      self.angles = var_08;
    }

    if(!isDefined(self.var_9B89)) {
      self animmode("noclip");
    }

    self.var_C6B9 = var_04;
  }

  if(!isDefined(self.var_1EDB)) {
    self.var_1EDB = spawnStruct();
  }

  if(isDefined(self.var_B004["no_gun"])) {
    if(!isDefined(self.var_9B89)) {
      scripts\sp\utility::func_86E4();
    }
  }

  if(isDefined(self.var_9B89)) {
    if(!isDefined(param_02)) {
      thread func_9A35();
      thread func_9A10();
    } else {
      thread func_9A11();
      thread func_9A10();
    }
  } else if(!isDefined(param_02)) {
    lib_0A1E::func_2307(::func_9A35, ::func_9A0F);
  } else {
    lib_0A1E::func_2307(::func_9A11, ::func_9A0F);
  }

  self waittill("reaction_end");
}

func_CE18(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("death");
  self endon("stop_smart_reaction");
  setup_interaction_head();
  var_08 = func_7A45(param_00).var_EBEA["trigger_radius"] * 2;
  thread scripts\sp\interaction_manager::func_DD45(var_08);
  func_CD51(param_00, param_05, param_01, param_07);
  self waittill("interaction_done");
  thread scripts\sp\utility::func_77B9(0.7);
  self notify("stop_reaction_look");
  func_137F5(param_06);
  play_looping_acknowlegdements(param_02, param_06);
}

setup_interaction_head() {
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
}

func_CD51(param_00, param_01, param_02, param_03) {
  if(issubstr(param_00, "blended")) {
    thread func_CD4D(param_00, param_01);
  } else {
    thread func_CD4B(param_00, param_01);
  }

  func_DB73(param_02, param_03);
}

func_DB73(param_00, param_01) {
  if(!isDefined(param_01)) {
    thread func_CDB1(param_00);
    return;
  }

  self waittill("playing_interaction_scene");
  scripts\engine\utility::delaythread(param_01, ::scripts\sp\interaction_manager::func_CE17, param_00);
}

func_CE1A(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
  thread func_CD50(param_00, param_05);
  scripts\sp\interaction_manager::func_CD24(85, 50, param_01, param_03, param_04);
  self notify("first_acknowledgement_done");
  func_137F5(param_06);
  var_07 = func_4906(param_02);
  for(;;) {
    var_08 = var_07 func_7A4D();
    scripts\sp\interaction_manager::func_CD24(85, 50, var_08, param_03, param_04);
    func_137F5(param_06);
  }
}

func_CE16(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
  func_CE0D(param_00);
  self notify("first_acknowledgement_done");
  func_137F5(param_04);
  play_looping_acknowlegdements(param_01, param_04);
}

func_CE19(param_00) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
  func_CE0D(undefined);
  func_137F5(param_00);
  play_looping_acknowlegdements(undefined, param_00);
}

func_CE1B(param_00, param_01, param_02) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
  thread func_CD50(param_00, param_01);
  scripts\sp\interaction_manager::func_CD24(85, 50);
  self notify("first_acknowledgement_done");
  func_137F5(param_02);
  play_looping_acknowlegdements(undefined, param_02);
}

func_CE0D(param_00) {
  self endon("stop_smart_reaction");
  var_01 = 110;
  var_02 = 85;
  scripts\sp\interaction_manager::func_CD24(var_01, var_02, param_00);
}

play_looping_acknowlegdements(param_00, param_01) {
  self endon("death");
  self endon("stop_smart_reaction");
  if(!isDefined(param_01)) {
    param_01 = 300;
  }

  if(isDefined(param_00)) {
    var_02 = func_4906(param_00);
    for(;;) {
      var_03 = var_02 func_7A4D();
      func_CE0D(var_03);
      func_137F5(param_01);
    }

    return;
  }

  for(;;) {
    func_CE0D();
    func_137F5(param_01);
  }
}

func_CE0C() {
  var_00 = 110;
  var_01 = 85;
  scripts\sp\interaction_manager::func_CD24(var_00, var_01);
}

func_137F5(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 256;
  }

  for(;;) {
    if(distance2d(self.origin, level.player.origin) >= param_00) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_4906(param_00) {
  if(!isarray(param_00) && !isstruct(param_00) && !isstring(param_00) && !isvector(param_00) && !param_00) {
    return undefined;
  }

  var_01 = spawnStruct();
  var_01.var_2857 = param_00;
  var_01.var_269A = param_00;
  var_01.used = [];
  return var_01;
}

func_E1F7() {
  self.used = [];
  self.var_269A = self.var_2857;
}

func_7A4D() {
  var_00 = undefined;
  if(isDefined(self.var_269A)) {
    if(self.var_269A.size <= 0) {
      func_E1F7();
    }

    var_00 = self.var_269A[randomint(self.var_269A.size)];
    self.used = scripts\engine\utility::array_add(self.used, var_00);
    self.var_269A = scripts\engine\utility::array_remove(self.var_269A, var_00);
    return var_00;
  }
}

func_CE15(param_00, param_01, param_02, param_03) {
  foreach(var_05 in param_00) {
    var_05 endon("death");
    var_05 endon("stop_smart_reaction");
    var_05.var_8C7E = % head;
    var_05.var_EF82 = % scripted_talking;
    var_05.var_504D = % generic_talker_allies;
  }

  if(param_00.size != param_01.size || param_00.size != param_02.size) {
    return;
  }

  func_CD35(param_00, param_01);
  var_07 = scripts\sp\interaction_manager::func_491D(param_00);
  var_07 func_137F5(param_03);
  func_CD38(param_00, param_02, param_03);
}

func_CD35(param_00, param_01) {
  var_02 = 110;
  var_03 = 85;
  scripts\sp\interaction_manager::func_CD37(param_00, var_02, var_03, param_01);
}

func_CD38(param_00, param_01, param_02) {
  foreach(var_04 in param_00) {
    var_04 endon("death");
    var_04 endon("stop_smart_reaction");
  }

  var_06 = func_48F8(param_01);
  var_07 = scripts\sp\interaction_manager::func_491D(param_00);
  for(;;) {
    var_08 = func_7A4E(var_06);
    func_CD35(param_00, var_08);
    var_07 func_137F5(param_02);
  }
}

func_48F8(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_01[var_02] = func_4906(param_00[var_02]);
  }

  return var_01;
}

func_7A4E(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_01[var_02] = param_00[var_02] func_7A4D();
  }

  return var_01;
}

func_CD53(param_00, param_01, param_02) {
  self endon("death");
  self notify("reaction_end");
  var_03 = func_7CA7(param_00);
  func_F96C(param_00);
  if(!isDefined(var_03)) {
    return;
  }

  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_9C84 = 0;
  self.var_BE79 = 0;
  self.var_9A30 = param_00;
  self.var_DD4C = 1;
  if(!isDefined(self.var_1C4D)) {
    self.var_1C4D = 1;
  }

  if(isDefined(level.var_9A2E)) {
    scripts\sp\interaction_manager::func_168F();
  }

  if(isDefined(param_01)) {
    var_04 = undefined;
    if(isarray(var_03.var_EBEA["idle"])) {
      var_05 = var_03.var_EBEA["idle"][0];
    } else {
      var_05 = var_04.var_EBEA["idle"];
    }

    if(isstring(param_01)) {
      var_04 = scripts\engine\utility::getstruct(param_01, "targetname");
    } else if(isstruct(param_01)) {
      var_04 = param_01;
    } else if(isent(param_01)) {
      var_04 = param_01;
    } else {
      return;
    }

    var_06 = var_05;
    var_07 = getstartorigin(var_04.origin, var_04.angles, var_06);
    var_08 = getstartangles(var_04.origin, var_04.angles, var_06);
    if(!isDefined(self.var_9B89)) {
      self _meth_80F1(var_07, var_08);
    } else {
      self.origin = var_07;
      self.angles = var_08;
    }

    if(!isDefined(self.var_9B89)) {
      self animmode("noclip");
    }

    self.var_C6B9 = var_04;
  }

  if(!isDefined(self.var_1EDB)) {
    self.var_1EDB = spawnStruct();
  }

  if(isDefined(var_03.var_EBEA["no_gun"])) {
    if(!isDefined(self.var_9B89) && self.var_394 != "none") {
      scripts\sp\utility::func_86E4();
    }
  }

  if(isDefined(self.var_9B89)) {
    thread func_9A37();
    thread func_9A10();
  } else {
    lib_0A1E::func_2307(::func_9A37, ::scripts\sp\interaction_manager::func_11048);
  }

  self waittill("reaction_end");
}

func_CD50(param_00, param_01, param_02) {
  self endon("death");
  self endon("reaction_end");
  var_03 = func_7A45(param_00);
  if(!isDefined(var_03)) {
    return;
  }

  self.var_B004 = var_03.var_EBEA;
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_1F25 = 0;
  self.var_EBF8 = 0;
  self.var_F274 = 0;
  self.var_10254 = 0;
  self.var_9C84 = 0;
  self.var_BE79 = 0;
  self.var_9A30 = param_00;
  self.var_DD4C = 1;
  self.var_C6B9 = undefined;
  self.var_C6B7 = undefined;
  if(!isDefined(self.var_1C4D)) {
    self.var_1C4D = 1;
  }

  if(isDefined(level.var_9A2E)) {
    level.var_9A2E.var_4D94["actors"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["actors"], self);
  }

  if(isDefined(param_02)) {
    self.var_C6B7 = param_02;
  }

  if(isDefined(param_01)) {
    var_04 = undefined;
    if(isarray(self.var_B004["idle"])) {
      var_05 = self.var_B004["idle"][0];
    } else {
      var_05 = self.var_B004["idle"];
    }

    if(isstring(param_01)) {
      var_04 = scripts\engine\utility::getstruct(param_01, "targetname");
    } else if(isstruct(param_01)) {
      var_04 = param_01;
    } else if(isent(param_01)) {
      var_04 = param_01;
    } else {
      return;
    }

    var_06 = var_05;
    var_07 = getstartorigin(var_04.origin, var_04.angles, var_06);
    var_08 = getstartangles(var_04.origin, var_04.angles, var_06);
    self.var_C6B9 = param_01;
  }

  if(!isDefined(self.var_9B89)) {
    self animmode("noclip");
  }

  if(!isDefined(self.var_1EDB)) {
    self.var_1EDB = spawnStruct();
  }

  if(isDefined(self.var_B004["no_gun"])) {
    if(!isDefined(self.var_9B89) && self.var_394 != "none") {
      scripts\sp\utility::func_86E4();
    }
  }

  if(isDefined(self.var_9B89)) {
    thread func_101F9();
    thread func_9A10();
  } else {
    lib_0A1E::func_2307(::func_101F9, ::func_9A0F);
  }

  self waittill("reaction_end");
}

func_CD4D(param_00, param_01) {
  self endon("death");
  self notify("reaction_end");
  var_02 = func_7A45(param_00);
  if(!isDefined(var_02)) {
    return;
  }

  func_E1CE(var_02, param_00);
  func_1690();
  func_BBFA(param_01);
  func_E7DE();
}

func_E1CE(param_00, param_01) {
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_B004 = param_00.var_EBEA;
  self.var_1F25 = 0;
  self.var_EBF8 = 0;
  self.var_F274 = 0;
  self.var_10254 = 0;
  self.var_9C84 = 0;
  self.var_BE79 = 0;
  self.var_9A30 = param_01;
  self.var_DD4C = 1;
  if(!isDefined(self.var_1C4D) || isDefined(self.var_1C4D) && !self.var_1C4D) {
    self.var_1C4D = 1;
  }

  if(!isDefined(self.var_1EDB)) {
    self.var_1EDB = spawnStruct();
  }

  if(isDefined(self.var_B004["no_gun"])) {
    if(!isDefined(self.var_9B89)) {
      scripts\sp\utility::func_86E4();
    }
  }
}

func_1690() {
  if(isDefined(level.var_9A2E)) {
    level.var_9A2E.var_4D94["actors"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["actors"], self);
  }
}

func_7A46() {
  if(isarray(self.var_B004["idle"])) {
    return self.var_B004["idle"][0];
  }

  return self.var_B004["idle"];
}

func_7A47(param_00) {
  var_01 = undefined;
  if(isstring(param_00)) {
    var_01 = scripts\engine\utility::getstruct(param_00, "targetname");
  } else if(isstruct(param_00)) {
    var_01 = param_00;
  } else if(isent(param_00)) {
    var_01 = param_00;
  } else {}

  return var_01;
}

func_BBFA(param_00) {
  if(isDefined(param_00)) {
    var_01 = func_7A46();
    var_02 = func_7A47(param_00);
    if(!isDefined(var_02)) {
      return;
    }

    self.var_C6B8 = param_00;
    var_03 = getstartorigin(var_02.origin, var_02.angles, var_01);
    var_04 = getstartangles(var_02.origin, var_02.angles, var_01);
    func_1162B(var_03, var_04);
    if(!isDefined(self.var_9B89)) {
      self animmode("noclip");
    }
  }
}

func_1162B(param_00, param_01) {
  if(isDefined(self.var_9B89)) {
    self.origin = param_00;
    self.angles = param_01;
    return;
  }

  self _meth_80F1(param_00, param_01);
}

func_E7DE() {
  if(isDefined(self.var_9B89)) {
    thread func_9A36();
    thread func_9A10();
  } else {
    lib_0A1E::func_2307(::func_9A36, ::func_9A0F);
  }

  self waittill("reaction_end");
}

func_CD4F(param_00, param_01) {
  self endon("death");
  var_02 = func_7A45(param_00);
  if(!isDefined(var_02)) {
    return;
  }

  self.var_B004 = var_02.var_EBEA;
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_9A30 = param_00;
  self.var_1F25 = 0;
  self.var_EBF8 = 0;
  self.var_F274 = 0;
  self.var_10254 = 0;
  self.var_9C84 = 0;
  self.var_BE79 = 0;
  if(!isDefined(self.var_1C4D)) {
    self.var_1C4D = 1;
  }

  if(isDefined(level.var_9A2E)) {
    level.var_9A2E.var_4D94["actors"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["actors"], self);
  }

  if(isDefined(param_01)) {
    var_03 = undefined;
    var_04 = self.var_B004["lastanim"];
    if(isstring(param_01)) {
      var_03 = scripts\engine\utility::getstruct(param_01, "targetname");
    } else if(isstruct(param_01)) {
      var_03 = param_01;
    } else {
      return;
    }

    self.var_B004["optional_struct"] = var_03;
  }

  if(!isDefined(self.var_1EDB)) {
    self.var_1EDB = spawnStruct();
  }

  if(isDefined(self.var_B004["no_gun"])) {
    if(!isDefined(self.var_9B89)) {
      scripts\sp\utility::func_86E4();
    }
  }

  thread lib_0A1E::func_2307(::func_9A13);
  self waittill("interaction_done");
}

func_4179() {
  self clearanim( % body, 0.2);
}

func_9C3D(param_00, param_01) {
  var_02 = anglesToForward(level.player.angles);
  var_03 = vectornormalize(param_00.origin - level.player.origin);
  var_04 = vectordot(var_02, var_03);
  if(var_04 >= param_01) {
    return 1;
  }

  return 0;
}

func_9A13() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_7245 = 0;
  func_4179();
  if(!isDefined(self.var_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_00 = self.var_B004["optional_struct"];
  var_01 = "single anim";
  if(!scripts\sp\utility::func_65DF("interaction_end")) {
    scripts\sp\utility::func_65E0("interaction_end");
  }

  scripts\sp\utility::func_65DD("interaction_end");
  var_02 = 0.25;
  var_03 = 0.25;
  if(isDefined(self.var_B004["common_name"])) {
    thread scripts\sp\interaction_manager::func_12754();
  }

  if(!self.var_BE79) {
    self.var_9C84 = 1;
    self notify("playing_interaction");
    var_04 = undefined;
    if(isDefined(self.var_B004["interaction_position"])) {
      var_04 = vectortoangles(self.var_B004["interaction_position"] - self.origin);
    } else {
      var_04 = vectortoangles(level.player.origin - self.origin);
    }

    var_05 = abs(angleclamp(var_04 - self.angles[1]) - 360);
    var_06 = scripts\sp\math::func_C097(0, 360, var_05);
    var_07 = self.var_B004["lastanim"];
    if(isDefined(self.var_B004["angles"])) {
      foreach(var_09 in self.var_B004["angles"]) {
        if(var_05 <= var_09) {
          var_07 = self.var_B004[var_09];
          break;
        }
      }
    }

    if(isDefined(var_00)) {
      var_0B = getstartorigin(var_00.origin, var_00.angles, var_07);
      var_0C = getstartangles(var_00.origin, var_00.angles, var_07);
      self _meth_80F1(var_0B, var_0C);
    }

    func_10C47(var_07);
    self _meth_82E1(var_01, var_07, 1, var_02);
    var_0D = getanimlength(var_07);
    wait(var_0D);
    self clearanim(var_07, var_03);
    level notify("interaction_done");
    self notify("interaction_done");
  }
}

func_9A11() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_7245 = 0;
  func_4179();
  if(!isDefined(self.var_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_00 = undefined;
  self.var_DC80 = 0;
  if(isarray(self.var_B004["idle"])) {
    var_00 = self.var_B004["idle"][0];
    thread func_DC7D();
  } else {
    var_00 = self.var_B004["idle"];
  }

  func_10C47(var_00);
  self _meth_82E1("idle", var_00, 1, 0.5, 1);
  thread func_9A3B("stop");
  var_01 = "single anim";
  if(!scripts\sp\utility::func_65DF("scene_end")) {
    scripts\sp\utility::func_65E0("scene_end");
  }

  scripts\sp\utility::func_65DD("scene_end");
  if(!scripts\sp\utility::func_65DF("playing_interaction")) {
    scripts\sp\utility::func_65E0("playing_interaction");
  }

  scripts\sp\utility::func_65DD("playing_interaction");
  var_02 = 0.11;
  var_03 = 0.25;
  var_04 = 0.25;
  var_05 = 350;
  var_06 = 0.45;
  var_07 = undefined;
  var_08 = undefined;
  var_09 = undefined;
  if(isDefined(self.var_B004["reacquire_left"]) || isDefined(self.var_B004["reacquire_right"])) {
    var_07 = 1;
  }

  self.var_DD54 = spawn("trigger_radius", self.origin, 0, self.var_B004["trigger_radius"], self.var_B004["trigger_radius"]);
  for(;;) {
    if((level.player istouching(self.var_DD54) || func_9C3D(self, 0.925)) && !self.var_DC80) {
      if(self.var_F274) {
        self.var_10254 = 1;
      } else {
        self.var_10254 = 0;
      }
    } else {
      self.var_10254 = 0;
    }

    var_0A = lengthsquared(level.player.origin - self.origin);
    var_0B = undefined;
    var_0C = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_0D = undefined;
    for(;;) {
      if(isDefined(self.var_B004["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::func_3839(self.var_B004["trigger_radius"] * 2)) {
        if(isDefined(self.var_B004["interaction_position"])) {
          var_0A = lengthsquared(self.var_B004["interaction_position"] - self.origin);
        } else {
          var_0A = lengthsquared(level.player.origin - self.origin);
        }

        if(isDefined(self.var_B004["interaction_trigger_override"])) {
          break;
        } else if(self.var_B004["trigger_radius"] > 0 && var_0A < squared(self.var_B004["trigger_radius"]) && func_9C3D(self, 0.925) && !self.var_DC80) {
          var_0E = self.origin + anglestoup(self.angles) * 66;
          var_0B = vectornormalize(level.player getEye() - var_0E) * self.var_B004["trigger_radius"] + var_0E;
          var_0D = scripts\common\trace::ray_trace(var_0E, var_0B, self, var_0C);
          if(isplayer(var_0D["entity"]) || isDefined(self.var_B004["interaction_trigger_override"])) {
            break;
          }
        }
      }

      scripts\engine\utility::waitframe();
    }

    if(isDefined(self.var_B004["common_name"])) {
      thread scripts\sp\interaction_manager::func_12754();
    }

    self.var_9C84 = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_0F = undefined;
    if(isDefined(self.var_B004["interaction_position"])) {
      var_0F = vectortoangles(self.var_B004["interaction_position"] - self.origin);
    } else {
      var_0F = vectortoangles(level.player.origin - self.origin);
    }

    var_10 = abs(angleclamp(var_0F - self.angles[1]) - 360);
    var_11 = scripts\sp\math::func_C097(0, 360, var_10);
    if(isDefined(self.var_B004["backseam"])) {
      if(var_11 >= 0 && var_11 <= 0.5) {
        var_11 = var_11 + 0.5;
      } else {
        var_11 = var_11 - 0.5;
      }
    }

    var_12 = self.var_B004["lastanim"];
    if(isDefined(self.var_B004["angles"]) && !self.var_F274) {
      foreach(var_14 in self.var_B004["angles"]) {
        if(var_10 <= var_14) {
          var_12 = self.var_B004[var_14];
          break;
        }
      }
    }

    if(isarray(var_12)) {
      if(isarray(var_12[0])) {
        var_16 = self.var_1F25;
        var_17 = var_12[0][var_16][0];
      } else {
        var_17 = var_12[0];
      }
    } else {
      var_17 = var_12;
    }

    if(!self.var_10254) {
      func_10C47(var_17);
      self give_left_powers(var_01, var_17, 1, var_03, 1);
      self.var_9C84 = 1;
    }

    if(!self.var_10254) {
      if(isarray(var_12)) {
        if(isarray(var_12[0]) && !isarray(self.var_B004["diff"])) {
          var_16 = self.var_1F25;
          var_18 = var_12[0][var_16];
          thread func_F59A(var_18);
          thread func_CC8C(var_18);
        } else if(var_12.size > 1) {
          thread func_CC8C(var_12);
        }
      }
    }

    if(isDefined(self.var_B004["reaction_func"])) {
      self thread[[self.var_B004["reaction_func"]]]();
    }

    var_19 = getanimlength(var_17);
    var_19 = var_19 - var_04;
    if(var_19 < 0) {
      var_19 = 0;
    }

    if(!self.var_10254) {
      wait(var_19);
    }

    if(!self.var_10254) {
      func_10C47(self.var_B004["follow"]);
      self _meth_82E8(var_01, self.var_B004["follow"], 1, 0.25, 1);
      self _meth_82B0(self.var_B004["follow"], var_11);
      self setanimknob(self.var_B004["ring"], 1, var_04, 1);
    }

    var_1A = undefined;
    if(isarray(self.var_B004["diff"])) {
      var_16 = self.var_1F25;
      var_1A = self.var_B004["diff"][var_16];
    } else {
      var_1A = self.var_B004["diff"];
    }

    func_10C47(var_1A);
    self _meth_82E8(var_01, var_1A, 1, 0.25, 1);
    self.var_9C84 = 1;
    if(!self.var_10254) {
      self _meth_82AC(self.var_B004["additive"], 1, var_04, 1);
    }

    scripts\engine\utility::delaythread(getanimlength(var_1A), ::scripts\sp\utility::func_65E1, "scene_end");
    scripts\sp\utility::func_65E1("playing_interaction");
    thread scripts\sp\utility::func_65DE("playing_interaction", getanimlength(var_1A));
    var_1B = var_11;
    for(;;) {
      var_1C = distance2d(level.player.origin, self.origin);
      if((var_1C >= var_05 || scripts\sp\utility::func_65DB("scene_end")) && !isDefined(var_07)) {
        var_0A = lengthsquared(level.player.origin - self.origin);
        if(var_0A < squared(self.var_B004["trigger_radius"])) {
          var_0E = self.origin + anglestoup(self.angles) * 66;
          var_0B = vectornormalize(level.player getEye() - var_0E) * self.var_B004["trigger_radius"] + var_0E;
          var_0D = scripts\common\trace::ray_trace(var_0E, var_0B, self, var_0C);
          if(isplayer(var_0D["entity"]) || isDefined(self.var_B004["interaction_trigger_override"])) {
            if(isarray(self.var_B004["diff"]) && self.var_1F25 < self.var_B004["diff"].size - 1) {
              self.var_F274 = 1;
              scripts\sp\utility::func_65DD("scene_end");
              self.var_1F25 = self.var_1F25 + 1;
              self clearanim(var_1A, 0.15);
              self.var_9C84 = 0;
              break;
            }
          }
        }

        if(isDefined(self.var_B004["exitangles"])) {
          var_1D = self.var_B004["exitangles_anims"]["lastexitanim"];
          if(isDefined(self.var_B004["interaction_position"])) {
            var_0F = vectortoangles(self.var_B004["interaction_position"] - self.origin);
          } else {
            var_0F = vectortoangles(level.player.origin - self.origin);
          }

          var_10 = abs(angleclamp(var_0F - self.angles[1]) - 360);
          foreach(var_1F in self.var_B004["exitangles"]) {
            if(var_10 <= var_1F) {
              var_1D = self.var_B004["exitangles_anims"][var_1F];
              break;
            }
          }

          func_10C47(var_1D);
          self give_left_powers(var_01, var_1D, 1, var_06, 1);
          wait(getanimlength(var_1D));
          if(isDefined(self.var_B004["end_idle"])) {
            if(isarray(var_12[0])) {
              if(self.var_1F25 >= var_12[0].size) {
                func_10C47(self.var_B004["end_idle"]);
                self give_left_powers(var_01, self.var_B004["end_idle"], 1, var_06, 1);
              } else {
                func_10C47(var_00);
                self give_left_powers(var_01, var_00, 1, var_06, 1);
              }
            } else {
              func_10C47(self.var_B004["end_idle"]);
              self give_left_powers(var_01, self.var_B004["end_idle"], 1, var_06, 1);
            }
          } else {
            func_10C47(var_00);
            self give_left_powers(var_01, var_00, 1, var_06, 1);
          }

          self.var_9C84 = 0;
          if(isarray(self.var_B004["diff"])) {
            if(self.var_1F25 < self.var_B004["diff"].size) {
              scripts\sp\utility::func_65DD("scene_end");
              self clearanim(self.var_B004["follow"], 0.1);
              self clearanim(self.var_B004["ring"], 0.1);
              self.var_1F25 = self.var_1F25 + 1;
              self.var_9C84 = 0;
            }

            if(self.var_1F25 >= self.var_B004["diff"].size) {
              self.var_9C84 = 0;
              var_09 = 1;
              if(!isDefined(self.var_B004["allow_multi_use"])) {
                self waittill("forever");
              }
            }
          } else {
            var_09 = 1;
            if(!isDefined(self.var_B004["allow_multi_use"])) {
              self waittill("forever");
            }
          }

          self.var_9C84 = 0;
          break;
        } else {
          if(isDefined(self.var_B004["end_idle"])) {
            if(isarray(var_12[0])) {
              if(self.var_1F25 >= var_12[0].size) {
                func_10C47(self.var_B004["end_idle"]);
                self give_left_powers(var_01, self.var_B004["end_idle"], 1, var_06, 1);
              } else {
                func_10C47(var_00);
                self give_left_powers(var_01, var_00, 1, var_06, 1);
              }
            } else {
              func_10C47(self.var_B004["end_idle"]);
              self give_left_powers(var_01, self.var_B004["end_idle"], 1, var_06, 1);
            }
          } else {
            func_10C47(var_00);
            self give_left_powers(var_01, var_00, 1, var_06, 1);
          }

          self.var_9C84 = 0;
          if(isarray(self.var_B004["diff"])) {
            if(self.var_1F25 < self.var_B004["diff"].size) {
              scripts\sp\utility::func_65DD("scene_end");
              self clearanim(self.var_B004["follow"], 0.1);
              self clearanim(self.var_B004["ring"], 0.1);
              self.var_1F25 = self.var_1F25 + 1;
              self.var_9C84 = 0;
            }

            if(self.var_1F25 >= self.var_B004["diff"].size) {
              self.var_9C84 = 0;
              var_09 = 1;
              if(!isDefined(self.var_B004["allow_multi_use"])) {
                self waittill("forever");
              }
            }
          } else {
            var_09 = 1;
            if(!isDefined(self.var_B004["allow_multi_use"])) {
              self waittill("forever");
            }
          }

          self.var_9C84 = 0;
          break;
        }
      }

      if(isDefined(self.var_B004["interaction_position"])) {
        var_0F = vectortoangles(self.var_B004["interaction_position"] - self.origin);
      } else {
        var_0F = vectortoangles(level.player.origin - self.origin);
      }

      var_10 = abs(angleclamp(var_0F - self.angles[1]) - 360);
      var_11 = scripts\sp\math::func_C097(0, 360, var_10);
      if(self.var_7245) {
        var_11 = 0;
      }

      if(isDefined(self.var_B004["backseam"])) {
        if(var_11 >= 0 && var_11 <= 0.5) {
          var_11 = var_11 + 0.5;
        } else {
          var_11 = var_11 - 0.5;
        }

        var_1B = var_1B + var_11 - var_1B * var_02;
      } else {
        var_1B = var_1B + var_11 - var_1B * var_02;
      }

      if(isDefined(var_07)) {
        var_21 = vectornormalize(level.player.origin - self.origin);
        var_21 = scripts\engine\utility::flatten_vector(var_21, anglestoup(self.angles));
        var_22 = anglesToForward(self.angles);
        var_23 = vectordot(var_21, var_22);
        var_10 = acos(var_23);
        var_24 = vectorcross(var_21, var_22);
        if(vectordot(var_24, anglestoup(self.angles)) < 0) {
          var_10 = var_10 * -1;
        }

        var_25 = 0;
        if(var_10 >= 90 && !var_25 && !scripts\sp\utility::func_65DB("playing_interaction")) {
          var_25 = 1;
          func_10C47(self.var_B004["reacquire_right"]);
          self clearanim( % body, 0.25);
          self _meth_82EA(var_01, self.var_B004["reacquire_right"], 1, 0.25);
          wait(clamp(getanimlength(self.var_B004["reacquire_right"]) - 0.25, 0, 100));
          self clearanim(self.var_B004["reacquire_right"], 0.25);
        } else if(var_10 < -90 && !var_25 && !scripts\sp\utility::func_65DB("playing_interaction")) {
          var_25 = 1;
          func_10C47(self.var_B004["reacquire_left"]);
          self clearanim( % body, 0.25);
          self _meth_82EA(var_01, self.var_B004["reacquire_left"], 1, 0.25);
          wait(clamp(getanimlength(self.var_B004["reacquire_left"]) - 0.25, 0, 100));
          self clearanim(self.var_B004["reacquire_left"], 0.25);
        } else {
          func_F5CD(self.var_B004["follow"], var_1B);
        }

        if(var_25) {
          if(isDefined(self.var_B004["interaction_position"])) {
            var_0F = vectortoangles(self.var_B004["interaction_position"] - self.origin);
          } else {
            var_0F = vectortoangles(level.player.origin - self.origin);
          }

          var_10 = abs(angleclamp(var_0F - self.angles[1]) - 360);
          var_11 = scripts\sp\math::func_C097(0, 360, var_10);
          func_10C47(self.var_B004["follow"]);
          self _meth_82E8(var_01, self.var_B004["follow"], 1, 0.25, 1);
          self _meth_82B0(self.var_B004["follow"], 0.5);
          self setanimknob(self.var_B004["ring"], 1, var_04, 1);
          if(!scripts\sp\utility::func_65DB("playing_interaction") && !scripts\sp\utility::func_65DB("scene_end")) {
            func_10C47(self.var_B004["diff"]);
            self _meth_82E8(var_01, self.var_B004["diff"], 1, 0.05, 1);
          }

          self _meth_82AC(self.var_B004["additive"], 1, var_04, 1);
          var_1B = 0.5;
        }
      } else {
        func_F5CD(self.var_B004["follow"], var_1B);
      }

      scripts\engine\utility::waitframe();
    }

    scripts\engine\utility::waitframe();
  }
}

func_9A35() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_7245 = 0;
  func_4179();
  if(!isDefined(self.var_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_00 = undefined;
  self.var_DC80 = 0;
  if(isarray(self.var_B004["idle"])) {
    var_00 = self.var_B004["idle"][0];
    thread func_DC7D();
  } else {
    var_00 = self.var_B004["idle"];
  }

  func_10C47(var_00);
  self _meth_82E1("idle", var_00, 1, 0.05, 1);
  thread func_9A3B("stop");
  var_01 = "single anim";
  if(!scripts\sp\utility::func_65DF("scene_end")) {
    scripts\sp\utility::func_65E0("scene_end");
  }

  scripts\sp\utility::func_65DD("scene_end");
  var_02 = 0.11;
  if(isDefined(self.var_B004["lookat_lerp"])) {
    var_02 = self.var_B004["lookat_lerp"];
  }

  var_03 = 0.25;
  if(isDefined(self.var_B004["initial_reaction_blendtime"])) {
    var_03 = self.var_B004["initial_reaction_blendtime"];
  }

  var_04 = 0.25;
  if(isDefined(self.var_B004["lookat_follow_blendtime"])) {
    var_04 = self.var_B004["lookat_follow_blendtime"];
  }

  var_05 = 350;
  if(isDefined(self.var_B004["lookat_end_distance"])) {
    var_05 = self.var_B004["lookat_end_distance"];
  }

  var_06 = 0.45;
  if(isDefined(self.var_B004["lookat_end_blendtime"])) {
    var_06 = self.var_B004["lookat_end_blendtime"];
  }

  self.var_DD54 = spawn("trigger_radius", self.origin, 0, self.var_B004["trigger_radius"], self.var_B004["trigger_radius"]);
  for(;;) {
    if((level.player istouching(self.var_DD54) || func_9C3D(self, 0.925)) && !self.var_DC80) {
      if(self.var_F274) {
        self.var_10254 = 1;
      } else {
        self.var_10254 = 0;
      }
    } else {
      self.var_10254 = 0;
    }

    var_07 = lengthsquared(level.player.origin - self.origin);
    var_08 = undefined;
    var_09 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_0A = undefined;
    for(;;) {
      if(isDefined(self.var_B004["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::func_3839(self.var_B004["trigger_radius"] * 2)) {
        if(isDefined(self.var_B004["interaction_position"])) {
          var_07 = lengthsquared(self.var_B004["interaction_position"] - self.origin);
        } else {
          var_07 = lengthsquared(level.player.origin - self.origin);
        }

        if(isDefined(self.var_B004["interaction_trigger_override"])) {
          break;
        } else if(self.var_B004["trigger_radius"] > 0 && var_07 < squared(self.var_B004["trigger_radius"]) && func_9C3D(self, 0.925) && !self.var_DC80) {
          var_0B = self.origin + anglestoup(self.angles) * 66;
          var_08 = vectornormalize(level.player getEye() - var_0B) * self.var_B004["trigger_radius"] + var_0B;
          var_0A = scripts\common\trace::ray_trace(var_0B, var_08, self, var_09);
          if(isplayer(var_0A["entity"]) || isDefined(self.var_B004["interaction_trigger_override"])) {
            break;
          }
        }
      }

      scripts\engine\utility::waitframe();
    }

    if(isDefined(self.var_B004["common_name"])) {
      thread scripts\sp\interaction_manager::func_12754();
    }

    self.var_9C84 = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_0C = undefined;
    if(isDefined(self.var_B004["interaction_position"])) {
      var_0C = vectortoangles(self.var_B004["interaction_position"] - self.origin);
    } else {
      var_0C = vectortoangles(level.player.origin - self.origin);
    }

    var_0D = abs(angleclamp(var_0C - self.angles[1]) - 360);
    var_0E = self.var_B004["lastanim"];
    if(isDefined(self.var_B004["angles"])) {
      foreach(var_10 in self.var_B004["angles"]) {
        if(var_0D <= var_10) {
          var_0E = self.var_B004[var_10];
          break;
        }
      }
    }

    if(isarray(var_0E)) {
      if(isarray(var_0E[0]) && self.var_1F25 < var_0E[0].size) {
        var_12 = self.var_1F25;
        var_13 = var_0E[0][var_12][0];
      } else {
        var_13 = var_0E[0];
      }
    } else {
      var_13 = var_0E;
    }

    if(!self.var_10254) {
      func_10C47(var_13);
      self give_left_powers(var_01, var_13, 1, var_03, 1);
      self.var_9C84 = 1;
    }

    level thread scripts\sp\interaction_manager::func_9A0E(self);
    if(isDefined(self.var_B004["scene"])) {
      if(isDefined(self.var_B004["interaction_position"])) {
        var_0C = vectortoangles(self.var_B004["interaction_position"] - self.origin);
      } else {
        var_0C = vectortoangles(level.player.origin - self.origin);
      }

      var_0D = abs(angleclamp(var_0C - self.angles[1]) - 360);
      if(self.var_10254) {
        wait(0);
      } else {
        wait(getanimlength(var_13));
      }

      if(isarray(self.var_B004["scene"])) {
        var_14 = self.var_EBF8;
        func_10C47(self.var_B004["scene"][var_14]);
        self give_left_powers(var_01, self.var_B004["scene"][var_14], 1, var_04, 1);
        wait(getanimlength(self.var_B004["scene"][var_14]));
        self.var_EBF8 = self.var_EBF8 + 1;
        self.var_F274 = 1;
      } else {
        func_10C47(self.var_B004["scene"]);
        self give_left_powers(var_01, self.var_B004["scene"], 1, var_04, 1);
        wait(getanimlength(self.var_B004["scene"]));
      }
    }

    if(isDefined(self.var_B004["exitangles"])) {
      if(isDefined(self.var_B004["interaction_position"])) {
        var_0C = vectortoangles(self.var_B004["interaction_position"] - self.origin);
      } else {
        var_0C = vectortoangles(level.player.origin - self.origin);
      }

      var_0D = abs(angleclamp(var_0C - self.angles[1]) - 360);
      var_15 = self.var_B004["exitangles_anims"]["lastexitanim"];
      foreach(var_17 in self.var_B004["exitangles"]) {
        if(var_0D <= var_17) {
          var_15 = self.var_B004["exitangles_anims"][var_17];
          break;
        }
      }

      func_10C47(var_15);
      self give_left_powers(var_01, var_15, 1, var_06, 1);
      wait(getanimlength(var_15));
      if(isDefined(self.var_B004["end_idle"])) {
        if(isarray(var_0E[0])) {
          if(self.var_1F25 >= var_0E[0].size) {
            func_10C47(self.var_B004["end_idle"]);
            self give_left_powers(var_01, self.var_B004["end_idle"], 1, var_06, 1);
          } else {
            func_10C47(var_00);
            self give_left_powers(var_01, var_00, 1, var_06, 1);
          }
        } else {
          func_10C47(self.var_B004["end_idle"]);
          self give_left_powers(var_01, self.var_B004["end_idle"], 1, var_06, 1);
        }
      } else {
        func_10C47(var_00);
        self give_left_powers(var_01, var_00, 1, var_06, 1);
      }

      self.var_9C84 = 0;
      if(!isDefined(self.var_B004["allow_multi_use"])) {
        self waittill("forever");
      }
    }

    if(!self.var_10254) {
      if(isarray(var_0E)) {
        if(isarray(var_0E[0]) && self.var_1F25 < var_0E[0].size) {
          var_12 = self.var_1F25;
          var_19 = var_0E[0][var_12];
          thread func_F59A(var_19);
          thread func_CC8C(var_19);
        } else if(var_0E.size > 1) {
          thread func_CC8C(var_0E);
        }
      }
    }

    if(isDefined(self.var_B004["reaction_func"])) {
      self[[self.var_B004["reaction_func"]]]();
    }

    var_1A = getanimlength(var_13);
    wait(var_1A);
    if(isDefined(self.var_B004["end_idle"])) {
      if(isarray(var_0E)) {
        if(isarray(var_0E[0])) {
          func_10C47();
          if(self.var_1F25 >= var_0E[0].size - 1) {
            self _meth_82E3(var_01, self.var_B004["end_idle"], % body, 1, var_06, 1);
          } else {
            self _meth_82E3(var_01, var_00, % body, 1, var_06, 1);
          }
        } else {
          self _meth_82E3(var_01, self.var_B004["end_idle"], % body, 1, var_06, 1);
        }
      } else {
        func_10C47();
        self _meth_82E3(var_01, self.var_B004["end_idle"], % body, 1, var_06, 1);
      }
    } else {
      func_10C47();
      self _meth_82E3(var_01, var_00, % body, 1, var_06, 1);
    }

    self.var_1F25 = self.var_1F25 + 1;
    level notify("interaction_done");
    self notify("interaction_done");
    if(isarray(var_0E)) {
      if(isarray(var_0E[0]) && self.var_1F25 < var_0E[0].size) {
        var_1B = self.var_F273 + self.var_F275 - getanimlength(var_13);
        var_1C = self.var_F273 + self.var_F275 + getanimlength(var_13);
        var_1D = clamp(var_1B, 0, var_1C);
        wait(var_1D);
        self clearanim(var_13, 0.1);
        self.var_9C84 = 0;
      } else {
        self.var_9C84 = 0;
        if(!isDefined(self.var_B004["allow_multi_use"])) {
          self waittill("forever");
        }
      }
    } else {
      self.var_9C84 = 0;
      if(!isDefined(self.var_B004["allow_multi_use"])) {
        self waittill("forever");
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_9A37() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  func_4179();
  if(!isDefined(self.var_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  var_00 = undefined;
  self.var_DC80 = 0;
  var_01 = func_7CA7(self.var_9A30);
  if(!isDefined(var_01)) {
    return;
  }

  var_01 = var_01.var_EBEA;
  var_02 = undefined;
  if(isarray(var_01["idle"])) {
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_02 = "idle_female";
    } else {
      var_02 = "idle";
    }

    var_00 = var_01[var_02][0];
    thread func_DC7E();
  } else {
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_02 = "idle_female";
    } else {
      var_02 = "idle";
    }

    var_00 = var_01[var_02];
  }

  var_03 = "single anim";
  func_10C47(var_00);
  self _meth_82E1(var_03, var_00, 1, 0.5, 1);
  self _meth_82B0(var_00, randomfloat(1));
  thread func_9A3B("stop");
  thread func_CC88();
  if(!scripts\sp\utility::func_65DF("scene_end")) {
    scripts\sp\utility::func_65E0("scene_end");
  }

  scripts\sp\utility::func_65DD("scene_end");
  var_04 = 0.11;
  var_05 = 0.25;
  var_06 = 0.25;
  var_07 = 350;
  var_08 = 0.45;
  self.var_DD54 = spawn("trigger_radius", self.origin, 0, var_01["trigger_radius"], var_01["trigger_radius"]);
  for(;;) {
    var_09 = lengthsquared(level.player.origin - self.origin);
    var_0A = undefined;
    var_0B = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_0C = undefined;
    for(;;) {
      if(!isDefined(self.var_DD49) || isDefined(self.var_DD49) && self.var_DD49 != "busy" && self.var_DD49 != "nag") {
        if(scripts\sp\interaction_manager::func_3839(var_01["trigger_radius"] * 2)) {
          if(isDefined(var_01["interaction_position"])) {
            var_09 = lengthsquared(var_01["interaction_position"] - self.origin);
          } else {
            var_09 = lengthsquared(level.player.origin - self.origin);
          }

          if(isDefined(var_01["interaction_trigger_override"])) {
            break;
          } else if(var_01["trigger_radius"] > 0 && var_09 < squared(var_01["trigger_radius"]) && func_9C3D(self, 0.925) && !self.var_DC80) {
            var_0D = self.origin + anglestoup(self.angles) * 66;
            var_0A = vectornormalize(level.player getEye() - var_0D) * var_01["trigger_radius"] + var_0D;
            var_0C = scripts\common\trace::ray_trace(var_0D, var_0A, self, var_0B);
            if(isplayer(var_0C["entity"]) || isDefined(var_01["interaction_trigger_override"])) {
              break;
            }
          }
        }
      }

      scripts\engine\utility::waitframe();
    }

    self.var_9C84 = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    var_0E = undefined;
    if(isDefined(var_01["interaction_position"])) {
      var_0E = vectortoangles(var_01["interaction_position"] - self.origin);
    } else {
      var_0E = vectortoangles(level.player.origin - self.origin);
    }

    var_0F = abs(angleclamp(var_0E - self.angles[1]) - 360);
    var_10 = "lastanim";
    if(isDefined(var_01["angles"])) {
      foreach(var_12 in var_01["angles"]) {
        if(var_0F <= var_12) {
          var_10 = var_12;
          break;
        }
      }
    }

    if(level.var_10E1C[self.var_9A30].var_EBEA[var_10].size < 1) {
      level.var_10E1C[self.var_9A30].var_EBEA[var_10] = level.var_10E1C[self.var_9A30].var_EBEA["angle_" + scripts\sp\utility::string(var_10) + "_spent"];
      level.var_10E1C[self.var_9A30].var_EBEA["angle_" + var_10 + "_spent"] = [];
    }

    var_14 = randomint(level.var_10E1C[self.var_9A30].var_EBEA[var_10].size);
    var_15 = level.var_10E1C[self.var_9A30].var_EBEA[var_10][var_14];
    func_10C47(var_15);
    self give_left_powers(var_03, var_15, 1, var_05, 1);
    self.var_9C84 = 1;
    thread scripts\sp\interaction_manager::func_9A39();
    wait(getanimlength(var_15));
    level.var_10E1C[self.var_9A30].var_EBEA["angle_" + var_10 + "_spent"] = scripts\engine\utility::array_add(level.var_10E1C[self.var_9A30].var_EBEA["angle_" + var_10 + "_spent"], var_15);
    level.var_10E1C[self.var_9A30].var_EBEA[var_10] = scripts\engine\utility::array_remove(level.var_10E1C[self.var_9A30].var_EBEA[var_10], var_15);
    if(isDefined(var_01["exitangles"])) {
      if(isDefined(var_01["interaction_position"])) {
        var_0E = vectortoangles(var_01["interaction_position"] - self.origin);
      } else {
        var_0E = vectortoangles(level.player.origin - self.origin);
      }

      var_0F = abs(angleclamp(var_0E - self.angles[1]) - 360);
      var_16 = "lastexitanim";
      foreach(var_18 in var_01["exitangles"]) {
        if(var_0F <= var_18) {
          var_16 = var_18;
          break;
        }
      }

      if(level.var_10E1C[self.var_9A30].var_EBEA[var_16].size < 1) {
        level.var_10E1C[self.var_9A30].var_EBEA[var_16][var_16] = level.var_10E1C[self.var_9A30].var_EBEA[var_16]["exit_angle_" + scripts\sp\utility::string(var_16) + "_spent"];
        level.var_10E1C[self.var_9A30].var_EBEA[var_16]["exit_angle_" + scripts\sp\utility::string(var_16) + "_spent"] = [];
      }

      var_14 = randomint(level.var_10E1C[self.var_9A30].var_EBEA[var_16].size);
      var_1A = level.var_10E1C[self.var_9A30].var_EBEA[var_16][var_14];
      func_10C47(var_1A);
      self give_left_powers(var_03, var_1A, 1, var_08, 1);
      wait(getanimlength(var_1A));
      level.var_10E1C[self.var_9A30].var_EBEA[var_16] = scripts\engine\utility::array_remove(level.var_10E1C[self.var_9A30].var_EBEA[var_16], var_1A);
    }

    func_10C47(var_00);
    self give_left_powers(var_03, var_00, 1, var_08, 1);
    self.var_9C84 = 0;
    if(isDefined(var_01["reaction_func"])) {
      self[[var_01["reaction_func"]]]();
    }

    level notify("interaction_done");
    thread scripts\sp\interaction_manager::func_F566("busy");
    scripts\engine\utility::waitframe();
    level waittill("forever");
  }
}

func_9A36() {
  self endon("death");
  self endon("reaction_end");
  func_9843();
  var_00 = 0.11;
  var_01 = 0.25;
  var_02 = 0.25;
  var_03 = 350;
  var_04 = func_F8D1();
  var_05 = "single anim";
  for(;;) {
    self.var_10254 = func_9C61();
    func_2B88();
    self.var_9C84 = 1;
    self notify("playing_interaction_scene");
    level notify("playing_interaction");
    if(isDefined(self.var_B004["common_name"])) {
      thread scripts\sp\interaction_manager::func_12754();
    }

    func_CCA9();
    scripts\engine\utility::waitframe();
  }
}

func_9843() {
  self givescorefortrophyblocks();
  self.var_7245 = 0;
  func_4179();
  if(!isDefined(self.var_9B89)) {
    self orientmode("face angle", self.angles[1]);
    self animmode("noclip");
  }

  if(!scripts\sp\utility::func_65DF("scene_end")) {
    scripts\sp\utility::func_65E0("scene_end");
  }

  scripts\sp\utility::func_65DD("scene_end");
  self.var_DD54 = spawn("trigger_radius", self.origin, 0, self.var_B004["trigger_radius"], self.var_B004["trigger_radius"]);
}

func_F8D1() {
  var_00 = func_7A4C();
  self.var_DC80 = 0;
  func_10C47(var_00);
  self _meth_82E1("single anim", var_00, 1, 0.05, 1);
  thread func_9A3B("stop");
}

func_7A4C() {
  var_00 = undefined;
  if(isarray(self.var_B004["idle"])) {
    var_00 = self.var_B004["idle"][0];
  } else {
    var_00 = self.var_B004["idle"];
  }

  return var_00;
}

func_9C61() {
  var_00 = undefined;
  if((level.player istouching(self.var_DD54) || func_9C3D(self, 0.925)) && !self.var_DC80) {
    if(self.var_F274) {
      var_00 = 1;
    } else {
      var_00 = 0;
    }
  } else {
    var_00 = 0;
  }

  return var_00;
}

func_2B88() {
  var_00 = lengthsquared(level.player.origin - self.origin);
  var_01 = undefined;
  var_02 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_03 = undefined;
  for(;;) {
    var_04 = scripts\sp\interaction_manager::func_3839(self.var_B004["trigger_radius"] * 2);
    if(var_04) {
      if(isDefined(self.var_B004["interaction_position"])) {
        var_00 = lengthsquared(self.var_B004["interaction_position"] - self.origin);
      } else {
        var_00 = lengthsquared(level.player.origin - self.origin);
      }

      if(isDefined(self.var_B004["interaction_trigger_override"])) {
        break;
      } else if(self.var_B004["trigger_radius"] > 0 && var_00 < squared(self.var_B004["trigger_radius"]) && func_9C3D(self, 0.925) && !self.var_DC80) {
        var_05 = self.origin + anglestoup(self.angles) * 66;
        var_01 = vectornormalize(level.player getEye() - var_05) * self.var_B004["trigger_radius"] + var_05;
        var_03 = scripts\common\trace::ray_trace(var_05, var_01, self, var_02);
        if(isplayer(var_03["entity"]) || isDefined(self.var_B004["interaction_trigger_override"])) {
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_CCA9() {
  func_9842();
  var_00 = 0;
  var_01 = 0;
  var_02 = gettime() / 1000;
  var_03 = getanimlength(self.var_B004["fwd_anim"]);
  while(gettime() / 1000 - var_02 < var_03) {
    var_04 = vectornormalize(level.player.origin - self.origin);
    var_05 = anglesToForward(self.angles);
    var_06 = anglesToForward(self.angles) * -1;
    var_07 = anglestoright(self.angles);
    var_08 = anglestoright(self.angles) * -1;
    var_09 = anglestoup(self.angles);
    var_0A = clamp(vectordot(var_04, var_05), 0.005, 1);
    var_0B = clamp(vectordot(var_04, var_07), 0.005, 1);
    var_0C = clamp(vectordot(var_04, var_08), 0.005, 1);
    var_0D = clamp(vectordot(var_04, var_06), 0.005, 1);
    self _meth_82AC(self.var_B004["right_anim"], var_0B, 0.2);
    self _meth_82AC(self.var_B004["left_anim"], var_0C, 0.2);
    self _meth_82E8("single anim", self.var_B004["fwd_anim"], var_0A + 0.005, 0.2);
    var_0E = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_05, var_04, var_09) > 0) {
      var_0E = 0;
    }

    if(var_0E) {
      var_01 = scripts\sp\math::func_AB6F(var_01, var_0D, 0.1);
      var_00 = scripts\sp\math::func_AB6F(var_00, 0.005, 0.1);
    } else {
      var_01 = scripts\sp\math::func_AB6F(var_01, 0.005, 0.1);
      var_00 = scripts\sp\math::func_AB6F(var_00, var_0D, 0.1);
    }

    self _meth_82AC(self.var_B004["back_right_anim"], var_01, 0.2);
    self _meth_82AC(self.var_B004["back_left_anim"], var_00, 0.2);
    scripts\engine\utility::waitframe();
  }

  var_0F = 0.45;
  func_62AB(var_0F);
  func_CD4E(var_0F);
}

func_9842() {
  var_00 = undefined;
  var_00 = vectortoangles(level.player.origin - self.origin);
  self.var_9C84 = 1;
  level thread scripts\sp\interaction_manager::func_9A0E(self);
  self _meth_82AC(self.var_B004["interaction_blend_parent"], 1, 0.2);
  var_01 = func_7A4C();
  self clearanim(var_01, 0.2);
  self clearanim( % head, 0.2);
  func_10C47(self.var_B004["fwd_anim"]);
  self _meth_82E8("single anim", self.var_B004["fwd_anim"], 0.005, 0.05);
  self _meth_82AC(self.var_B004["right_anim"], 0.005, 0.05);
  self _meth_82AC(self.var_B004["left_anim"], 0.005, 0.05);
  self _meth_82AC(self.var_B004["back_right_anim"], 0.005, 0.05);
  self _meth_82AC(self.var_B004["back_left_anim"], 0.005, 0.05);
}

func_62AB(param_00) {
  self.var_DD3C = undefined;
  self clearanim(self.var_B004["fwd_anim"], param_00);
  self clearanim(self.var_B004["right_anim"], param_00);
  self clearanim(self.var_B004["left_anim"], param_00);
  self clearanim(self.var_B004["back_right_anim"], param_00);
  self clearanim(self.var_B004["back_left_anim"], param_00);
  level notify("interaction_done");
  self notify("interaction_done");
  self.var_9C84 = 0;
}

func_CD4E(param_00) {
  for(;;) {
    var_01 = undefined;
    if(isDefined(self.var_B004["end_idle"])) {
      var_01 = self.var_B004["end_idle"];
      func_10C47(var_01);
      self _meth_82B0(var_01, 0);
      self _meth_82E3("single anim", var_01, % body, 1, param_00, 1);
    } else {
      var_01 = func_7A4C();
      func_10C47(var_01);
      self _meth_82B0(var_01, 0);
      self _meth_82E3("single anim", var_01, % body, 1, param_00, 1);
    }

    wait(getanimlength(var_01));
  }
}

func_101F9() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_00 = func_7A45(self.var_9A30);
  if(!scripts\sp\utility::func_65DF("hold_simple_idles")) {
    scripts\sp\utility::func_65E0("hold_simple_idles");
  } else {
    scripts\sp\utility::func_65DD("hold_simple_idles");
  }

  if(!isarray(var_00.var_EBEA["idle"])) {
    return;
  }

  if(isarray(var_00.var_EBEA["idle"]) && var_00.var_EBEA["idle"].size <= 1) {
    return;
  }

  var_01 = [];
  var_02 = var_00.var_EBEA["idle"];
  var_03 = var_02[0];
  var_02 = scripts\sp\utility::array_remove_index(var_02, 0);
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = undefined;
  if(isDefined(var_00.var_EBEA["idle_prop"]) && isDefined(self.var_C6B7)) {
    var_04 = [];
    var_00.var_EBEA["spent_array_prop"] = var_04;
    var_06 = var_00.var_EBEA["idle_prop"];
    var_05 = var_06[0];
    var_06 = scripts\sp\utility::array_remove_index(var_06, 0);
    var_07 = var_06;
    var_06 = undefined;
  }

  var_08 = var_02;
  var_02 = undefined;
  thread func_4179();
  func_9A3B("stop");
  for(;;) {
    if(isDefined(self.var_C6B9)) {
      func_13CA(self.var_C6B9, var_03);
    }

    func_10C47(var_03);
    self give_left_powers("single anim", var_03, 1, 0.2, 1);
    thread lib_0C4C::func_19BE();
    if(isDefined(self.var_C6B7)) {
      thread func_1404(var_05);
    }

    wait(getanimlength(var_03) * randomintrange(1, 2));
    while(scripts\sp\utility::func_65DB("hold_simple_idles")) {
      wait(getanimlength(var_03));
    }

    if(var_08.size <= 0) {
      var_08 = var_01;
      var_01 = [];
    }

    var_09 = randomint(var_08.size);
    var_0A = var_08[var_09];
    var_01 = scripts\engine\utility::array_add(var_01, var_0A);
    var_08 = scripts\sp\utility::array_remove_index(var_08, var_09);
    if(isDefined(self.var_C6B7)) {
      if(var_07.size <= 0) {
        var_07 = var_04;
        var_04 = [];
      }

      var_0B = var_07[var_09];
      var_04 = scripts\engine\utility::array_add(var_04, var_0B);
      var_07 = scripts\sp\utility::array_remove_index(var_07, var_09);
      thread func_1403(var_0B);
    }

    self clearanim(var_03, 0.2);
    if(isDefined(self.var_C6B9)) {
      func_13CA(self.var_C6B9, var_0A);
    }

    func_10C47(var_0A);
    self give_left_powers("single anim", var_0A, 1, 0.2, 1);
    thread lib_0C4C::func_19BD();
    wait(getanimlength(var_0A));
    self clearanim(var_0A, 0.2);
    if(isDefined(self.var_C6B7)) {
      thread func_1402();
    }

    scripts\engine\utility::waitframe();
  }
}

func_13CA(param_00, param_01) {
  var_02 = getstartorigin(param_00.origin, param_00.angles, param_01);
  var_03 = getstartangles(param_00.origin, param_00.angles, param_01);
  if(!isDefined(self.var_9B89)) {
    self _meth_80F1(var_02, var_03, 100000);
    wait(0.05);
    return;
  }

  self.origin = var_02;
  self.angles = var_03;
  self dontinterpolate();
  wait(0.05);
}

func_1403(param_00) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_C6B7 glinton(#animtree);
  self.var_C6B7 clearanim(self.var_C6B7.var_4B31, 0.2);
  self.var_C6B7 setanimknob(param_00, 1, 0.2, 1);
  self.var_C6B7.var_4B31 = param_00;
}

func_1404(param_00) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_C6B7 glinton(#animtree);
  self.var_C6B7 setanimknob(param_00, 1, 0.2, 1);
  self.var_C6B7.var_4B31 = param_00;
}

func_1402() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_C6B7 glinton(#animtree);
  self.var_C6B7 clearanim(self.var_C6B7.var_4B31, 0.2);
}

func_CC8B(param_00, param_01) {
  wait(param_00);
  var_02 = strtok(param_01, "_");
  if(scripts\engine\utility::array_contains(var_02, "plr")) {
    level.player scripts\sp\utility::play_sound_on_entity(param_01);
    return;
  }

  scripts\sp\utility::func_10346(param_01);
}

func_1368() {
  self notify("start_interaction_vo_note");
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("start_interaction_vo_note");
  for(;;) {
    self waittill("single anim", var_00);
    if(isarray(var_00)) {
      foreach(var_02 in var_00) {
        if(issubstr(var_02, "vo_") && !issubstr(var_02, "_plr")) {
          var_03 = getsubstr(var_02, 3);
          thread scripts\sp\utility::func_10346(var_03);
          wait(lookupsoundlength(var_03) / 1000);
          self notify("single dialogue");
          if(isDefined(self.var_EF82)) {
            self clearanim(self.var_EF82, 0.2);
          }
        }
      }

      continue;
    }

    if(issubstr(var_00, "vo_") && !issubstr(var_00, "_plr")) {
      var_03 = getsubstr(var_00, 3);
      thread scripts\sp\utility::func_10346(var_03);
      wait(lookupsoundlength(var_03) / 1000);
      self notify("single dialogue");
      if(isDefined(self.var_EF82)) {
        self clearanim(self.var_EF82, 0.2);
      }
    }
  }
}

func_CDB1(param_00) {
  self endon("death");
  self endon("stop_smart_reaction");
  var_01 = 0;
  while(!var_01) {
    self waittill("single anim", var_02);
    if(isarray(var_02)) {
      foreach(var_04 in var_02) {
        if(var_04 == "reaction_vo") {
          var_01 = 1;
          break;
        }
      }

      continue;
    }

    if(var_02 == "reaction_vo") {
      var_01 = 1;
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self notify("reaction_vo_fired");
  scripts\sp\interaction_manager::func_CE17(param_00);
}

func_CC88() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_00 = undefined;
  var_01 = undefined;
  if(!isDefined(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_male"])) {
    return;
  }

  if(!isDefined(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"])) {
    return;
  }

  if(!isDefined(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_male_vo"])) {
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_male_vo"] = [];
  }

  if(isDefined(self.gender) && issubstr(self.gender, "male")) {
    if(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_male"].size < 1) {
      level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_male"] = level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_male_vo"];
    }

    var_02 = level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_male"];
    var_03 = randomint(var_02.size);
    var_01 = var_02[var_03];
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_male"] = scripts\sp\utility::array_remove_index(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_male"], var_03);
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_male_vo"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_male_vo"], var_01);
  }

  if(!isDefined(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"])) {
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"] = [];
  }

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    if(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"].size < 1) {
      level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"] = level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"];
    }

    var_02 = level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"];
    var_03 = randomint(var_02.size);
    var_01 = var_02[var_03];
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"] = scripts\sp\utility::array_remove_index(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"], var_03);
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"], var_01);
  }

  var_04 = undefined;
  for(;;) {
    self waittill("single anim", var_05);
    if(isarray(var_05)) {
      foreach(var_07 in var_05) {
        if(var_07 == "reaction_vo") {
          var_04 = 1;
          break;
        }
      }
    } else if(var_05 == "reaction_vo") {
      var_04 = 1;
    }

    if(isDefined(var_04)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::func_10346(var_01);
}

func_CC8C(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  var_03 = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30];
  if(isDefined(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"])) {
    var_01 = 1;
    if(!isDefined(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"])) {
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "male")) {
      if(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"].size < 1) {
        level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"] = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"];
      }

      var_04 = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"];
      var_05 = randomint(var_04.size);
      var_02 = var_04[var_05];
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"] = scripts\sp\utility::array_remove_index(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"], var_05);
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"], var_02);
    }
  }

  if(isDefined(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"])) {
    var_01 = 1;
    if(!isDefined(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"])) {
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      if(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"].size < 1) {
        level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"] = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"];
      }

      var_04 = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"];
      var_05 = randomint(var_04.size);
      var_02 = var_04[var_05];
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"] = scripts\sp\utility::array_remove_index(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"], var_05);
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"], var_02);
    }
  }

  var_06 = param_00.size - 1;
  if(!isDefined(var_01)) {
    if(isstring(param_00[var_06])) {
      for(var_07 = 1; var_07 < param_00.size; var_07 = var_07 + 2) {
        func_CC8B(param_00[var_07], param_00[var_07 + 1]);
      }

      return;
    }

    for(var_07 = 1; var_07 < param_00.size - 1; var_07 = var_07 + 2) {
      func_CC8B(param_00[var_07], param_00[var_07 + 1]);
    }

    return;
  }

  func_CC8B(param_00[1], var_02);
}

func_F59A(param_00) {
  self.var_F275 = 0;
  self.var_F273 = 0;
  var_01 = param_00.size - 1;
  if(isstring(param_00[var_01])) {
    self.var_F273 = 0;
    for(var_02 = 1; var_02 < param_00.size; var_02 = var_02 + 2) {
      self.var_F275 = self.var_F275 + param_00[var_02];
    }

    return;
  }

  self.var_F273 = var_01[var_02];
  for(var_02 = 1; var_02 < param_00.size - 1; var_02 = var_02 + 2) {
    self.var_F275 = self.var_F275 + param_00[var_02];
  }
}

func_DC7D() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var_00 = undefined;
  var_01 = func_7A45(self.var_9A30);
  if(!isDefined(var_01)) {
    var_01 = func_7CA7(self.var_9A30);
  }

  self.var_383A = 1;
  self.var_9C83 = undefined;
  if(!isarray(var_01.var_EBEA["idle"])) {
    var_01.var_EBEA["idle"] = [var_01.var_EBEA["idle"], var_01.var_EBEA["idle"]];
  }

  var_02 = [];
  var_03 = var_01.var_EBEA["idle"];
  var_04 = var_03[0];
  var_03 = scripts\sp\utility::array_remove_index(var_03, 0);
  var_05 = var_03;
  var_03 = undefined;
  self.var_10DB2 = var_04;
  for(;;) {
    self.var_9C83 = 1;
    var_06 = getanimlength(var_04);
    var_07 = randomint(2) + 1;
    var_08 = var_06 * float(var_07);
    wait(var_08);
    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    if(var_05.size <= 0) {
      var_05 = var_02;
      var_02 = [];
    }

    var_09 = var_05[randomint(var_05.size)];
    var_02 = scripts\engine\utility::array_add(var_02, var_09);
    var_05 = scripts\engine\utility::array_remove(var_05, var_09);
    var_0A = undefined;
    var_0B = undefined;
    if(isDefined(self.var_C6B9)) {
      var_0A = getstartorigin(self.var_C6B9.origin, self.var_C6B9.angles, var_09);
      var_0B = getstartangles(self.var_C6B9.origin, self.var_C6B9.angles, var_09);
      if(!isDefined(self.var_9B89)) {
        self _meth_80F1(var_0A, var_0B);
      } else {
        self.origin = var_0A;
        self.angles = var_0B;
      }
    }

    while(self.var_9C84) {
      scripts\engine\utility::waitframe();
    }

    func_10C47(var_09);
    self give_left_powers("single anim", var_09, 1, 0.2, 1);
    self.var_DC80 = 1;
    var_0C = getanimlength(var_09);
    wait(var_0C);
    while(self.var_9C84) {
      scripts\engine\utility::waitframe();
    }

    if(isDefined(self.var_C6B9)) {
      var_0A = getstartorigin(self.var_C6B9.origin, self.var_C6B9.angles, var_04);
      var_0B = getstartangles(self.var_C6B9.origin, self.var_C6B9.angles, var_04);
      if(!isDefined(self.var_9B89)) {
        self _meth_80F1(var_0A, var_0B);
      } else {
        self.origin = var_0A;
        self.angles = var_0B;
      }
    }

    self.var_DC80 = 0;
    self clearanim(var_09, 0.3);
    self.var_9C83 = undefined;
    func_10C47(var_04);
    self give_left_powers("single anim", var_04, 1, 0.2, 1);
    self _meth_82B0(var_04, randomfloat(1));
    for(;;) {
      if(isDefined(self.var_383A)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    scripts\engine\utility::waitframe();
  }
}

func_DC7E() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var_00 = undefined;
  var_01 = func_7CA7(self.var_9A30);
  self.var_383A = 1;
  self.var_9C83 = undefined;
  var_02 = undefined;
  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    var_02 = "idle_female";
  } else {
    var_02 = "idle";
  }

  var_03 = var_01.var_EBEA[var_02][0];
  self.var_10DB2 = var_03;
  for(;;) {
    self.var_9C83 = 1;
    var_04 = getanimlength(var_03);
    var_05 = randomint(2) + 1;
    var_06 = var_04 * float(var_05);
    wait(var_06);
    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    var_07 = undefined;
    var_08 = undefined;
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_07 = "random_idles_female";
      var_08 = "spent_random_idles_female";
    } else {
      var_07 = "random_idles";
      var_08 = "spent_random_idles";
    }

    if(level.var_10E1C[self.var_9A30].var_EBEA[var_07].size <= 0) {
      level.var_10E1C[self.var_9A30].var_EBEA[var_07] = level.var_10E1C[self.var_9A30].var_EBEA[var_08];
      level.var_10E1C[self.var_9A30].var_EBEA[var_08] = [];
    }

    var_09 = level.var_10E1C[self.var_9A30].var_EBEA[var_07][randomint(level.var_10E1C[self.var_9A30].var_EBEA[var_07].size)];
    level.var_10E1C[self.var_9A30].var_EBEA[var_08] = scripts\engine\utility::array_add(level.var_10E1C[self.var_9A30].var_EBEA[var_08], var_09);
    level.var_10E1C[self.var_9A30].var_EBEA[var_07] = scripts\engine\utility::array_remove(level.var_10E1C[self.var_9A30].var_EBEA[var_07], var_09);
    var_0A = undefined;
    var_0B = undefined;
    if(isDefined(self.var_C6B9)) {
      var_0A = getstartorigin(self.var_C6B9.origin, self.var_C6B9.angles, var_09);
      var_0B = getstartangles(self.var_C6B9.origin, self.var_C6B9.angles, var_09);
      if(!isDefined(self.var_9B89)) {
        self _meth_80F1(var_0A, var_0B);
      } else {
        self.origin = var_0A;
        self.angles = var_0B;
      }
    }

    while(self.var_9C84) {
      scripts\engine\utility::waitframe();
    }

    func_10C47(var_09);
    self give_left_powers("single anim", var_09, 1, 0.2, 1);
    self.var_DC80 = 1;
    var_0C = getanimlength(var_09);
    wait(var_0C);
    while(self.var_9C84) {
      scripts\engine\utility::waitframe();
    }

    if(isDefined(self.var_C6B9)) {
      var_0A = getstartorigin(self.var_C6B9.origin, self.var_C6B9.angles, var_03);
      var_0B = getstartangles(self.var_C6B9.origin, self.var_C6B9.angles, var_03);
      if(!isDefined(self.var_9B89)) {
        self _meth_80F1(var_0A, var_0B);
      } else {
        self.origin = var_0A;
        self.angles = var_0B;
      }
    }

    self.var_DC80 = 0;
    self clearanim(var_09, 0.3);
    self.var_9C83 = undefined;
    func_10C47(var_03);
    self give_left_powers("single anim", var_03, 1, 0.2, 1);
    self _meth_82B0(var_03, randomfloat(1));
    for(;;) {
      if(isDefined(self.var_383A)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    scripts\engine\utility::waitframe();
  }
}

func_DC7F(param_00, param_01, param_02) {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  level endon("stop_idle_controller");
  self endon("stop_group_idle_controller");
  level endon("stop_group_idle_controller");
  self endon("death");
  if(!scripts\engine\utility::flag_exist("hold_group_vignettes")) {
    scripts\engine\utility::flag_init("hold_group_vignettes");
  }

  var_03 = [];
  var_04 = param_02;
  for(;;) {
    wait(randomfloatrange(param_01 * 0.5, param_01));
    foreach(var_06 in param_00) {
      if(!isDefined(var_06)) {
        self notify("stop_group_idle_controller");
        return;
      }

      var_06 endon("death");
      var_06 endon("entitydeleted");
      var_06.var_383A = undefined;
    }

    var_08 = 0;
    for(;;) {
      if(!scripts\engine\utility::flag("hold_group_vignettes")) {
        foreach(var_0A in param_00) {
          if(!isDefined(var_0A.var_9C83)) {
            var_08++;
          }
        }

        if(var_08 >= param_00.size) {
          break;
        } else {
          var_08 = 0;
        }
      }

      scripts\engine\utility::waitframe();
    }

    var_0C = undefined;
    if(isarray(param_02)) {
      if(var_04.size <= 0) {
        var_04 = param_02;
        var_03 = [];
      }

      var_0C = var_04[randomint(var_04.size)];
    } else {
      var_0C = param_02;
    }

    var_0D = 0;
    if(!scripts\engine\utility::flag("hold_group_vignettes")) {
      foreach(var_06 in param_00) {
        if(!isDefined(var_06)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var_0F = var_06 scripts\sp\utility::func_7DC1(var_0C);
        var_10 = getstartorigin(var_06.origin, var_06.angles, var_0F);
        var_11 = getstartangles(var_06.origin, var_06.angles, var_0F);
        if(isai(var_06)) {
          var_06 _meth_80F1(var_10, var_11);
        } else {
          var_06.origin = var_10;
          var_06.angles = var_11;
        }

        var_06 thread func_10C47(var_0F);
        var_06 give_left_powers("single anim", var_0F, 1, 0.2);
        var_06.var_1C4D = 0;
        var_06.var_906F = 1;
        var_0D = getanimlength(var_0F);
      }

      wait(var_0D);
      if(isarray(param_02)) {
        var_03 = scripts\engine\utility::array_add(var_03, var_0C);
        var_04 = scripts\engine\utility::array_remove(var_04, var_0C);
      }

      foreach(var_14 in param_00) {
        if(!isDefined(var_14)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var_0F = var_14 scripts\sp\utility::func_7DC1(var_0C);
        var_14 thread func_10C47(var_14.var_10DB2);
        var_14 setanimknob(var_0F, 0, 0.2);
        var_14 give_left_powers("single anim", var_14.var_10DB2, 1, 0.2, 1);
        var_14 _meth_82B0(var_14.var_10DB2, randomfloat(1));
        var_14.var_383A = 1;
        var_14.var_1C4D = 1;
        var_14.var_906F = undefined;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_9A0F() {
  if(!isDefined(self.var_DD4C)) {
    lib_0A1E::func_2386();
    func_9A3B("stop");
  }

  scripts\sp\interaction_manager::func_DFB5();
  self notify("reaction_end");
  thread scripts\sp\interaction_manager::func_10FF9();
  self notify("stop_smart_reaction");
  self.var_9CE2 = undefined;
}

func_9A10() {
  self waittill("reaction_end");
  scripts\sp\interaction_manager::func_DFB5();
  self notify("interaction_done");
  self notify("stop_reaction");
  self.var_9CE2 = undefined;
}

func_F5CD(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 = self getscoreinfocategory(param_00);
  var_04 = getanimlength(param_00);
  var_05 = param_01 - var_03 * var_04 / 0.05;
  self _meth_82AC(param_00, param_02, 0.25, var_05);
}

func_CCCA(param_00, param_01) {
  self endon("death");
  self endon("interaction_done");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_1F25 = 0;
  self.var_EBF8 = 0;
  self.var_F274 = 0;
  self.var_10254 = 0;
  self.var_9C84 = 0;
  self.var_BE79 = 0;
  self.var_43E5 = param_01;
  if(isDefined(level.var_9A2E)) {
    level.var_9A2E.var_4D94["actors"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["actors"], self);
  }

  while(self.script == "init") {
    scripts\engine\utility::waitframe();
  }

  for(;;) {
    for(;;) {
      var_02 = lengthsquared(level.player.origin - self.origin);
      if(var_02 < squared(150) && func_9C3D(self, 0.925)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    var_03 = self.asmname;
    var_04 = self.var_164D[var_03].var_4BC0;
    var_05 = level.asm[var_03].states[var_04];
    var_06 = var_05.var_C87F;
    self.var_43E4 = lib_0A1E::asm_getallanimsforstate(var_03, param_01);
    level.asm[var_03].states[var_04].var_C87F = var_06;
    if(var_04 == self.var_43E5 && !self.var_BE79) {
      if(param_00.var_EE92 == "combat_reaction") {
        var_07 = [];
        if(isDefined(param_00.type)) {
          switch (param_00.type) {
            case "Cover Crouch":
              var_07 = ["combat_crouch_1", "combat_crouch_2"];
              break;

            case "Cover Left":
              switch (self.a.pose) {
                case "stand":
                  var_07 = ["hm_grnd_org_cover_left_stand_react_01", "hm_grnd_org_cover_left_stand_react_02"];
                  break;

                case "crouch":
                  var_07 = ["hm_grnd_org_cover_left_crouch_react_01", "hm_grnd_org_cover_left_crouch_react_02"];
                  break;

                case "prone":
                  break;
              }
              break;

            case "Cover Right":
              switch (self.a.pose) {
                case "stand":
                  var_07 = ["hm_grnd_org_cover_right_stand_react_01", "hm_grnd_org_cover_right_stand_react_02"];
                  break;

                case "crouch":
                  var_07 = ["hm_grnd_org_cover_right_crouch_react_01", "hm_grnd_org_cover_right_crouch_react_02"];
                  break;

                case "prone":
                  break;
              }
              break;

            case "Cover Prone":
              break;

            case "Cover Stand":
              break;

            case "Cover Crouch Window":
              var_07 = ["combat_cover_crouch_1"];
              break;
          }

          if(var_07.size > 0) {
            var_08 = randomint(var_07.size);
            var_09 = var_07[var_08];
            func_43DA(var_09, param_00);
          } else {
            return;
          }
        }
      } else {
        func_43DA(param_00.var_EE92, param_00);
      }
    }

    wait(1.5);
  }
}

func_43DA(param_00, param_01) {
  self endon("death");
  self endon("interaction_done");
  var_02 = func_7A45(param_00);
  thread scripts\sp\anim::func_10CBF(self, "vo");
  thread func_1368();
  if(!isDefined(var_02)) {
    return;
  }

  self.var_B004 = var_02.var_EBEA;
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  var_03 = lengthsquared(level.player.origin - self.origin);
  var_04 = undefined;
  var_05 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_06 = undefined;
  if(isDefined(self.var_B004["interaction_position"])) {
    var_03 = lengthsquared(self.var_B004["interaction_position"] - self.origin);
  } else {
    var_03 = lengthsquared(level.player.origin - self.origin);
  }

  if(var_03 < squared(self.var_B004["trigger_radius"]) && func_9C3D(self, 0.925)) {
    var_04 = vectornormalize(level.player getEye() - self getEye()) * self.var_B004["trigger_radius"] + self getEye();
    var_06 = scripts\common\trace::ray_trace(self getEye(), var_04, self, var_05);
    if(isplayer(var_06["entity"])) {
      func_43DB();
    }
  }
}

func_43DB() {
  self endon("death");
  self endon("interaction_done");
  self.var_9C84 = 1;
  self notify("playing_interaction_scene");
  level notify("playing_interaction");
  var_00 = self.var_43E4;
  var_01 = undefined;
  if(isDefined(self.var_B004["interaction_position"])) {
    var_01 = vectortoangles(self.var_B004["interaction_position"] - self.origin);
  } else {
    var_01 = vectortoangles(level.player.origin - self.origin);
  }

  var_02 = abs(angleclamp(var_01 - self.angles[1]) - 360);
  var_03 = self.var_B004["lastanim"];
  if(isDefined(self.var_B004["angles"])) {
    foreach(var_05 in self.var_B004["angles"]) {
      if(var_02 <= var_05) {
        var_03 = self.var_B004[var_05];
        break;
      }
    }
  }

  if(isarray(var_03)) {
    if(isarray(var_03[0])) {
      var_07 = self.var_1F25;
      var_08 = var_03[0][var_07][0];
    } else {
      var_08 = var_08[0];
    }
  } else {
    var_08 = var_08;
  }

  func_10C47(var_08);
  self _meth_82AC( % cover, 0, 0.25, 1);
  self _meth_82E3("vo", var_08, % body, 1, 0.25, 1);
  wait(getanimlength(var_08));
  self clearanim( % scripted, 0.25);
  self _meth_82AC( % cover, 1, 0.25, 1);
  self.var_9C84 = 0;
  wait(0.25);
  self notify("interaction_done");
  level notify("interaction_done");
  thread func_9A0F();
}

func_43E7(param_00) {
  param_00.var_43E6 = 1;
  wait(2);
  param_00.var_43E6 = undefined;
}

func_BF07() {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var_00 = undefined;
  if(isDefined(self.var_A906)) {
    var_00 = self.var_A906.origin;
    while(isDefined(self.var_A906) && self.var_A906.origin == var_00) {
      scripts\engine\utility::waitframe();
    }
  } else if(isDefined(self.var_A905)) {
    var_00 = self.var_A905.origin;
    while(isDefined(self.var_A905) && self.var_A905.origin == var_00) {
      scripts\engine\utility::waitframe();
    }
  } else if(isDefined(self.var_A907)) {
    var_00 = self.var_A907;
    while(isDefined(self.var_A907) && self.var_A907 == var_00) {
      scripts\engine\utility::waitframe();
    }
  }

  self notify("interaction_done");
  thread func_9A0F();
}

func_9A32() {
  self endon("death");
  self endon("interaction_done");
  self.var_9A31 = undefined;
  for(;;) {
    self.var_9A31 = undefined;
    self waittill("pain");
    self.var_9A31 = 1;
    wait(5);
  }
}

func_9A3B(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "stop";
  }

  if(isai(self)) {
    self.a.movement = param_00;
    return;
  }
}

func_10C47(param_00) {
  var_01 = undefined;
  if(isDefined(self.var_9A30)) {
    var_01 = self.var_9A30;
  }

  thread scripts\sp\anim::func_10CBF(self, "single anim", var_01, undefined, param_00);
  thread scripts\sp\anim::func_1FCA(self, "single anim", var_01);
}