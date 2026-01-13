/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2883.gsc
*********************************************/

register_interaction(var_0, var_1) {
  level.interactions[var_0] = var_1;
}

func_DED9(var_0, var_1) {
  level.var_10E1C[var_0] = var_1;
}

func_7A45(var_0) {
  if(!isDefined(level.interactions) || !isDefined(level.interactions[var_0])) {
    return undefined;
  }

  return level.interactions[var_0];
}

func_7CA7(var_0) {
  if(!issubstr(var_0, "casual") && !issubstr(var_0, "alert")) {
    if(isDefined(self.asm)) {
      var_1 = scripts\asm\asm::asm_getdemeanor();
      if(var_1 == "casual") {
        var_0 = var_0 + "_" + var_1;
      } else {
        var_0 = var_0 + "_alert";
      }
    } else {
      var_0 = var_0 + "_casual";
    }
  }

  if(!isDefined(level.var_10E1C) || !isDefined(level.var_10E1C[var_0])) {
    return undefined;
  }

  return level.var_10E1C[var_0];
}

func_9C27(var_0) {
  return isDefined(level.interactions) && isDefined(level.interactions[var_0]);
}

func_9CD8(var_0) {
  return isDefined(level.var_10E1C) && isDefined(level.var_10E1C[var_0 + "_casual"]);
}

func_9CD7(var_0) {
  if(isDefined(var_0.var_EE92) && func_9CD8(var_0.var_EE92)) {
    return 1;
  }

  return 0;
}

func_9C26(var_0) {
  if(isDefined(var_0.var_EE92) && func_9C27(var_0.var_EE92)) {
    return 1;
  }

  if(isDefined(var_0.script_noteworthy) && func_9C27(var_0.script_noteworthy)) {
    return 1;
  }

  return 0;
}

func_9C25(var_0) {
  if(isDefined(var_0.var_EE92)) {
    if(func_9C27(var_0.var_EE92) || var_0.var_EE92 == "combat_reaction") {
      return 1;
    }
  }

  return 0;
}

func_7837(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();
  if(isDefined(var_0.var_22F2)) {
    return var_0.var_22F2[var_1];
  }

  return undefined;
}

func_79A5(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();
  if(isDefined(var_0.var_6980)) {
    return var_0.var_6980[var_1];
  }

  return undefined;
}

func_7A30(var_0) {
  var_1 = scripts\asm\asm::asm_getdemeanor();
  return var_0.var_92FA;
}

func_F96C(var_0) {
  if(!isai(self)) {
    return;
  }

  self.asm.var_4C86.interaction = var_0;
  var_1 = func_7A45(var_0);
  if(!isDefined(var_1)) {
    var_1 = func_7CA7(var_0);
  }

  self.asm.var_4C86.var_697F = func_79A5(var_1);
}

func_CD4C(var_0, var_1, var_2, var_3, var_4) {
  var_0 = func_7A45(var_0);
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.05;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  func_10C47(var_0.var_EBEA[var_1]);
  self func_82E1(var_1, var_0.var_EBEA[var_1], var_2, var_3, var_4);
}

func_509D(var_0) {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var_1 = undefined;
  for(;;) {
    if(isstruct(var_0) || isent(var_0)) {
      var_1 = var_0.origin;
    } else if(isvector(var_0)) {
      var_1 = var_0;
    }

    if(isDefined(self.var_B004)) {
      self.var_B004["interaction_position"] = var_1;
    }

    scripts\engine\utility::waitframe();
  }
}

func_DE14(var_0) {
  var_1 = undefined;
  if(isDefined(self.var_B004)) {
    var_1 = self.var_B004["trigger_radius"];
    self.var_B004["trigger_radius"] = var_0;
    thread func_13B1(var_1);
  }
}

func_13B1(var_0) {
  self endon("interaction_end");
  self endon("reaction_end");
  self waittill("interaction_done");
  self.var_B004["trigger_radius"] = var_0;
}

func_CD4B(var_0, var_1, var_2) {
  self endon("death");
  self notify("reaction_end");
  var_3 = func_7A45(var_0);
  func_F96C(var_0);
  if(!isDefined(var_3)) {
    return;
  }

  self.var_B004 = var_3.var_EBEA;
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_1F25 = 0;
  self.var_EBF8 = 0;
  self.var_F274 = 0;
  self.var_10254 = 0;
  self.var_9C84 = 0;
  self.var_BE79 = 0;
  self.var_9A30 = var_0;
  self.var_DD4C = 1;
  if(!isDefined(self.var_1C4D)) {
    self.var_1C4D = 1;
  }

  if(isDefined(level.var_9A2E)) {
    scripts\sp\interaction_manager::func_168F();
    level.var_9A2E.var_4D94["registered_interactions"][var_0] = [];
    if(isDefined(var_3.var_EBEA["vo_lines_male"])) {
      level.var_9A2E.var_4D94["registered_interactions"][var_0]["vo_lines_male"] = var_3.var_EBEA["vo_lines_male"];
    }

    if(isDefined(var_3.var_EBEA["vo_lines_female"])) {
      level.var_9A2E.var_4D94["registered_interactions"][var_0]["vo_lines_female"] = var_3.var_EBEA["vo_lines_female"];
    }
  }

  if(isDefined(var_1)) {
    var_4 = undefined;
    if(isarray(self.var_B004["idle"])) {
      var_5 = self.var_B004["idle"][0];
    } else {
      var_5 = self.var_B004["idle"];
    }

    if(isstring(var_1)) {
      var_4 = scripts\engine\utility::getstruct(var_1, "targetname");
    } else if(isstruct(var_1)) {
      var_4 = var_1;
    } else if(isent(var_1)) {
      var_4 = var_1;
    } else {
      return;
    }

    var_6 = var_5;
    var_7 = getstartorigin(var_4.origin, var_4.angles, var_6);
    var_8 = getstartangles(var_4.origin, var_4.angles, var_6);
    if(!isDefined(self.var_9B89)) {
      self func_80F1(var_7, var_8);
    } else {
      self.origin = var_7;
      self.angles = var_8;
    }

    if(!isDefined(self.var_9B89)) {
      self animmode("noclip");
    }

    self.var_C6B9 = var_4;
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
    if(!isDefined(var_2)) {
      thread func_9A35();
      thread func_9A10();
    } else {
      thread func_9A11();
      thread func_9A10();
    }
  } else if(!isDefined(var_2)) {
    lib_0A1E::func_2307(::func_9A35, ::func_9A0F);
  } else {
    lib_0A1E::func_2307(::func_9A11, ::func_9A0F);
  }

  self waittill("reaction_end");
}

func_CE18(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_smart_reaction");
  setup_interaction_head();
  var_8 = func_7A45(var_0).var_EBEA["trigger_radius"] * 2;
  thread scripts\sp\interaction_manager::func_DD45(var_8);
  func_CD51(var_0, var_5, var_1, var_7);
  self waittill("interaction_done");
  thread scripts\sp\utility::func_77B9(0.7);
  self notify("stop_reaction_look");
  func_137F5(var_6);
  play_looping_acknowlegdements(var_2, var_6);
}

setup_interaction_head() {
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
}

func_CD51(var_0, var_1, var_2, var_3) {
  if(issubstr(var_0, "blended")) {
    thread func_CD4D(var_0, var_1);
  } else {
    thread func_CD4B(var_0, var_1);
  }

  func_DB73(var_2, var_3);
}

func_DB73(var_0, var_1) {
  if(!isDefined(var_1)) {
    thread func_CDB1(var_0);
    return;
  }

  self waittill("playing_interaction_scene");
  scripts\engine\utility::delaythread(var_1, scripts\sp\interaction_manager::func_CE17, var_0);
}

func_CE1A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
  thread func_CD50(var_0, var_5);
  scripts\sp\interaction_manager::func_CD24(85, 50, var_1, var_3, var_4);
  self notify("first_acknowledgement_done");
  func_137F5(var_6);
  var_7 = func_4906(var_2);
  for(;;) {
    var_8 = var_7 func_7A4D();
    scripts\sp\interaction_manager::func_CD24(85, 50, var_8, var_3, var_4);
    func_137F5(var_6);
  }
}

func_CE16(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
  func_CE0D(var_0);
  self notify("first_acknowledgement_done");
  func_137F5(var_4);
  play_looping_acknowlegdements(var_1, var_4);
}

func_CE19(var_0) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
  func_CE0D(undefined);
  func_137F5(var_0);
  play_looping_acknowlegdements(undefined, var_0);
}

func_CE1B(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_smart_reaction");
  self.var_8C7E = % head;
  self.var_EF82 = % scripted_talking;
  self.var_504D = % generic_talker_allies;
  thread func_CD50(var_0, var_1);
  scripts\sp\interaction_manager::func_CD24(85, 50);
  self notify("first_acknowledgement_done");
  func_137F5(var_2);
  play_looping_acknowlegdements(undefined, var_2);
}

func_CE0D(var_0) {
  self endon("stop_smart_reaction");
  var_1 = 110;
  var_2 = 85;
  scripts\sp\interaction_manager::func_CD24(var_1, var_2, var_0);
}

play_looping_acknowlegdements(var_0, var_1) {
  self endon("death");
  self endon("stop_smart_reaction");
  if(!isDefined(var_1)) {
    var_1 = 300;
  }

  if(isDefined(var_0)) {
    var_2 = func_4906(var_0);
    for(;;) {
      var_3 = var_2 func_7A4D();
      func_CE0D(var_3);
      func_137F5(var_1);
    }

    return;
  }

  for(;;) {
    func_CE0D();
    func_137F5(var_1);
  }
}

func_CE0C() {
  var_0 = 110;
  var_1 = 85;
  scripts\sp\interaction_manager::func_CD24(var_0, var_1);
}

func_137F5(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 256;
  }

  for(;;) {
    if(distance2d(self.origin, level.player.origin) >= var_0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_4906(var_0) {
  if(!isarray(var_0) && !isstruct(var_0) && !isstring(var_0) && !isvector(var_0) && !var_0) {
    return undefined;
  }

  var_1 = spawnStruct();
  var_1.var_2857 = var_0;
  var_1.var_269A = var_0;
  var_1.used = [];
  return var_1;
}

func_E1F7() {
  self.used = [];
  self.var_269A = self.var_2857;
}

func_7A4D() {
  var_0 = undefined;
  if(isDefined(self.var_269A)) {
    if(self.var_269A.size <= 0) {
      func_E1F7();
    }

    var_0 = self.var_269A[randomint(self.var_269A.size)];
    self.used = scripts\engine\utility::array_add(self.used, var_0);
    self.var_269A = scripts\engine\utility::array_remove(self.var_269A, var_0);
    return var_0;
  }
}

func_CE15(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5 endon("death");
    var_5 endon("stop_smart_reaction");
    var_5.var_8C7E = % head;
    var_5.var_EF82 = % scripted_talking;
    var_5.var_504D = % generic_talker_allies;
  }

  if(var_0.size != var_1.size || var_0.size != var_2.size) {
    return;
  }

  func_CD35(var_0, var_1);
  var_7 = scripts\sp\interaction_manager::func_491D(var_0);
  var_7 func_137F5(var_3);
  func_CD38(var_0, var_2, var_3);
}

func_CD35(var_0, var_1) {
  var_2 = 110;
  var_3 = 85;
  scripts\sp\interaction_manager::func_CD37(var_0, var_2, var_3, var_1);
}

func_CD38(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 endon("death");
    var_4 endon("stop_smart_reaction");
  }

  var_6 = func_48F8(var_1);
  var_7 = scripts\sp\interaction_manager::func_491D(var_0);
  for(;;) {
    var_8 = func_7A4E(var_6);
    func_CD35(var_0, var_8);
    var_7 func_137F5(var_2);
  }
}

func_48F8(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = func_4906(var_0[var_2]);
  }

  return var_1;
}

func_7A4E(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = var_0[var_2] func_7A4D();
  }

  return var_1;
}

func_CD53(var_0, var_1, var_2) {
  self endon("death");
  self notify("reaction_end");
  var_3 = func_7CA7(var_0);
  func_F96C(var_0);
  if(!isDefined(var_3)) {
    return;
  }

  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_9C84 = 0;
  self.var_BE79 = 0;
  self.var_9A30 = var_0;
  self.var_DD4C = 1;
  if(!isDefined(self.var_1C4D)) {
    self.var_1C4D = 1;
  }

  if(isDefined(level.var_9A2E)) {
    scripts\sp\interaction_manager::func_168F();
  }

  if(isDefined(var_1)) {
    var_4 = undefined;
    if(isarray(var_3.var_EBEA["idle"])) {
      var_5 = var_3.var_EBEA["idle"][0];
    } else {
      var_5 = var_4.var_EBEA["idle"];
    }

    if(isstring(var_1)) {
      var_4 = scripts\engine\utility::getstruct(var_1, "targetname");
    } else if(isstruct(var_1)) {
      var_4 = var_1;
    } else if(isent(var_1)) {
      var_4 = var_1;
    } else {
      return;
    }

    var_6 = var_5;
    var_7 = getstartorigin(var_4.origin, var_4.angles, var_6);
    var_8 = getstartangles(var_4.origin, var_4.angles, var_6);
    if(!isDefined(self.var_9B89)) {
      self func_80F1(var_7, var_8);
    } else {
      self.origin = var_7;
      self.angles = var_8;
    }

    if(!isDefined(self.var_9B89)) {
      self animmode("noclip");
    }

    self.var_C6B9 = var_4;
  }

  if(!isDefined(self.var_1EDB)) {
    self.var_1EDB = spawnStruct();
  }

  if(isDefined(var_3.var_EBEA["no_gun"])) {
    if(!isDefined(self.var_9B89) && self.var_394 != "none") {
      scripts\sp\utility::func_86E4();
    }
  }

  if(isDefined(self.var_9B89)) {
    thread func_9A37();
    thread func_9A10();
  } else {
    lib_0A1E::func_2307(::func_9A37, scripts\sp\interaction_manager::func_11048);
  }

  self waittill("reaction_end");
}

func_CD50(var_0, var_1, var_2) {
  self endon("death");
  self endon("reaction_end");
  var_3 = func_7A45(var_0);
  if(!isDefined(var_3)) {
    return;
  }

  self.var_B004 = var_3.var_EBEA;
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_1F25 = 0;
  self.var_EBF8 = 0;
  self.var_F274 = 0;
  self.var_10254 = 0;
  self.var_9C84 = 0;
  self.var_BE79 = 0;
  self.var_9A30 = var_0;
  self.var_DD4C = 1;
  self.var_C6B9 = undefined;
  self.var_C6B7 = undefined;
  if(!isDefined(self.var_1C4D)) {
    self.var_1C4D = 1;
  }

  if(isDefined(level.var_9A2E)) {
    level.var_9A2E.var_4D94["actors"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["actors"], self);
  }

  if(isDefined(var_2)) {
    self.var_C6B7 = var_2;
  }

  if(isDefined(var_1)) {
    var_4 = undefined;
    if(isarray(self.var_B004["idle"])) {
      var_5 = self.var_B004["idle"][0];
    } else {
      var_5 = self.var_B004["idle"];
    }

    if(isstring(var_1)) {
      var_4 = scripts\engine\utility::getstruct(var_1, "targetname");
    } else if(isstruct(var_1)) {
      var_4 = var_1;
    } else if(isent(var_1)) {
      var_4 = var_1;
    } else {
      return;
    }

    var_6 = var_5;
    var_7 = getstartorigin(var_4.origin, var_4.angles, var_6);
    var_8 = getstartangles(var_4.origin, var_4.angles, var_6);
    self.var_C6B9 = var_1;
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

func_CD4D(var_0, var_1) {
  self endon("death");
  self notify("reaction_end");
  var_2 = func_7A45(var_0);
  if(!isDefined(var_2)) {
    return;
  }

  func_E1CE(var_2, var_0);
  func_1690();
  func_BBFA(var_1);
  func_E7DE();
}

func_E1CE(var_0, var_1) {
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_B004 = var_0.var_EBEA;
  self.var_1F25 = 0;
  self.var_EBF8 = 0;
  self.var_F274 = 0;
  self.var_10254 = 0;
  self.var_9C84 = 0;
  self.var_BE79 = 0;
  self.var_9A30 = var_1;
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

func_7A47(var_0) {
  var_1 = undefined;
  if(isstring(var_0)) {
    var_1 = scripts\engine\utility::getstruct(var_0, "targetname");
  } else if(isstruct(var_0)) {
    var_1 = var_0;
  } else if(isent(var_0)) {
    var_1 = var_0;
  }

  return var_1;
}

func_BBFA(var_0) {
  if(isDefined(var_0)) {
    var_1 = func_7A46();
    var_2 = func_7A47(var_0);
    if(!isDefined(var_2)) {
      return;
    }

    self.var_C6B8 = var_0;
    var_3 = getstartorigin(var_2.origin, var_2.angles, var_1);
    var_4 = getstartangles(var_2.origin, var_2.angles, var_1);
    func_1162B(var_3, var_4);
    if(!isDefined(self.var_9B89)) {
      self animmode("noclip");
    }
  }
}

func_1162B(var_0, var_1) {
  if(isDefined(self.var_9B89)) {
    self.origin = var_0;
    self.angles = var_1;
    return;
  }

  self func_80F1(var_0, var_1);
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

func_CD4F(var_0, var_1) {
  self endon("death");
  var_2 = func_7A45(var_0);
  if(!isDefined(var_2)) {
    return;
  }

  self.var_B004 = var_2.var_EBEA;
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  self.var_9A30 = var_0;
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

  if(isDefined(var_1)) {
    var_3 = undefined;
    var_4 = self.var_B004["lastanim"];
    if(isstring(var_1)) {
      var_3 = scripts\engine\utility::getstruct(var_1, "targetname");
    } else if(isstruct(var_1)) {
      var_3 = var_1;
    } else {
      return;
    }

    self.var_B004["optional_struct"] = var_3;
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

func_9C3D(var_0, var_1) {
  var_2 = anglesToForward(level.player.angles);
  var_3 = vectornormalize(var_0.origin - level.player.origin);
  var_4 = vectordot(var_2, var_3);
  if(var_4 >= var_1) {
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

  var_0 = self.var_B004["optional_struct"];
  var_1 = "single anim";
  if(!scripts\sp\utility::func_65DF("interaction_end")) {
    scripts\sp\utility::func_65E0("interaction_end");
  }

  scripts\sp\utility::func_65DD("interaction_end");
  var_2 = 0.25;
  var_3 = 0.25;
  if(isDefined(self.var_B004["common_name"])) {
    thread scripts\sp\interaction_manager::func_12754();
  }

  if(!self.var_BE79) {
    self.var_9C84 = 1;
    self notify("playing_interaction");
    var_4 = undefined;
    if(isDefined(self.var_B004["interaction_position"])) {
      var_4 = vectortoangles(self.var_B004["interaction_position"] - self.origin);
    } else {
      var_4 = vectortoangles(level.player.origin - self.origin);
    }

    var_5 = abs(angleclamp(var_4 - self.angles[1]) - 360);
    var_6 = scripts\sp\math::func_C097(0, 360, var_5);
    var_7 = self.var_B004["lastanim"];
    if(isDefined(self.var_B004["angles"])) {
      foreach(var_9 in self.var_B004["angles"]) {
        if(var_5 <= var_9) {
          var_7 = self.var_B004[var_9];
          break;
        }
      }
    }

    if(isDefined(var_0)) {
      var_0B = getstartorigin(var_0.origin, var_0.angles, var_7);
      var_0C = getstartangles(var_0.origin, var_0.angles, var_7);
      self func_80F1(var_0B, var_0C);
    }

    func_10C47(var_7);
    self func_82E1(var_1, var_7, 1, var_2);
    var_0D = getanimlength(var_7);
    wait(var_0D);
    self clearanim(var_7, var_3);
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

  var_0 = undefined;
  self.var_DC80 = 0;
  if(isarray(self.var_B004["idle"])) {
    var_0 = self.var_B004["idle"][0];
    thread func_DC7D();
  } else {
    var_0 = self.var_B004["idle"];
  }

  func_10C47(var_0);
  self func_82E1("idle", var_0, 1, 0.5, 1);
  thread func_9A3B("stop");
  var_1 = "single anim";
  if(!scripts\sp\utility::func_65DF("scene_end")) {
    scripts\sp\utility::func_65E0("scene_end");
  }

  scripts\sp\utility::func_65DD("scene_end");
  if(!scripts\sp\utility::func_65DF("playing_interaction")) {
    scripts\sp\utility::func_65E0("playing_interaction");
  }

  scripts\sp\utility::func_65DD("playing_interaction");
  var_2 = 0.11;
  var_3 = 0.25;
  var_4 = 0.25;
  var_5 = 350;
  var_6 = 0.45;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  if(isDefined(self.var_B004["reacquire_left"]) || isDefined(self.var_B004["reacquire_right"])) {
    var_7 = 1;
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
      self give_left_powers(var_1, var_17, 1, var_3, 1);
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
    var_19 = var_19 - var_4;
    if(var_19 < 0) {
      var_19 = 0;
    }

    if(!self.var_10254) {
      wait(var_19);
    }

    if(!self.var_10254) {
      func_10C47(self.var_B004["follow"]);
      self func_82E8(var_1, self.var_B004["follow"], 1, 0.25, 1);
      self func_82B0(self.var_B004["follow"], var_11);
      self setanimknob(self.var_B004["ring"], 1, var_4, 1);
    }

    var_1A = undefined;
    if(isarray(self.var_B004["diff"])) {
      var_16 = self.var_1F25;
      var_1A = self.var_B004["diff"][var_16];
    } else {
      var_1A = self.var_B004["diff"];
    }

    func_10C47(var_1A);
    self func_82E8(var_1, var_1A, 1, 0.25, 1);
    self.var_9C84 = 1;
    if(!self.var_10254) {
      self func_82AC(self.var_B004["additive"], 1, var_4, 1);
    }

    scripts\engine\utility::delaythread(getanimlength(var_1A), scripts\sp\utility::func_65E1, "scene_end");
    scripts\sp\utility::func_65E1("playing_interaction");
    thread scripts\sp\utility::func_65DE("playing_interaction", getanimlength(var_1A));
    var_1B = var_11;
    for(;;) {
      var_1C = distance2d(level.player.origin, self.origin);
      if((var_1C >= var_5 || scripts\sp\utility::func_65DB("scene_end")) && !isDefined(var_7)) {
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
          self give_left_powers(var_1, var_1D, 1, var_6, 1);
          wait(getanimlength(var_1D));
          if(isDefined(self.var_B004["end_idle"])) {
            if(isarray(var_12[0])) {
              if(self.var_1F25 >= var_12[0].size) {
                func_10C47(self.var_B004["end_idle"]);
                self give_left_powers(var_1, self.var_B004["end_idle"], 1, var_6, 1);
              } else {
                func_10C47(var_0);
                self give_left_powers(var_1, var_0, 1, var_6, 1);
              }
            } else {
              func_10C47(self.var_B004["end_idle"]);
              self give_left_powers(var_1, self.var_B004["end_idle"], 1, var_6, 1);
            }
          } else {
            func_10C47(var_0);
            self give_left_powers(var_1, var_0, 1, var_6, 1);
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
              var_9 = 1;
              if(!isDefined(self.var_B004["allow_multi_use"])) {
                self waittill("forever");
              }
            }
          } else {
            var_9 = 1;
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
                self give_left_powers(var_1, self.var_B004["end_idle"], 1, var_6, 1);
              } else {
                func_10C47(var_0);
                self give_left_powers(var_1, var_0, 1, var_6, 1);
              }
            } else {
              func_10C47(self.var_B004["end_idle"]);
              self give_left_powers(var_1, self.var_B004["end_idle"], 1, var_6, 1);
            }
          } else {
            func_10C47(var_0);
            self give_left_powers(var_1, var_0, 1, var_6, 1);
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
              var_9 = 1;
              if(!isDefined(self.var_B004["allow_multi_use"])) {
                self waittill("forever");
              }
            }
          } else {
            var_9 = 1;
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

        var_1B = var_1B + var_11 - var_1B * var_2;
      } else {
        var_1B = var_1B + var_11 - var_1B * var_2;
      }

      if(isDefined(var_7)) {
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
          self func_82EA(var_1, self.var_B004["reacquire_right"], 1, 0.25);
          wait(clamp(getanimlength(self.var_B004["reacquire_right"]) - 0.25, 0, 100));
          self clearanim(self.var_B004["reacquire_right"], 0.25);
        } else if(var_10 < -90 && !var_25 && !scripts\sp\utility::func_65DB("playing_interaction")) {
          var_25 = 1;
          func_10C47(self.var_B004["reacquire_left"]);
          self clearanim( % body, 0.25);
          self func_82EA(var_1, self.var_B004["reacquire_left"], 1, 0.25);
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
          self func_82E8(var_1, self.var_B004["follow"], 1, 0.25, 1);
          self func_82B0(self.var_B004["follow"], 0.5);
          self setanimknob(self.var_B004["ring"], 1, var_4, 1);
          if(!scripts\sp\utility::func_65DB("playing_interaction") && !scripts\sp\utility::func_65DB("scene_end")) {
            func_10C47(self.var_B004["diff"]);
            self func_82E8(var_1, self.var_B004["diff"], 1, 0.05, 1);
          }

          self func_82AC(self.var_B004["additive"], 1, var_4, 1);
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

  var_0 = undefined;
  self.var_DC80 = 0;
  if(isarray(self.var_B004["idle"])) {
    var_0 = self.var_B004["idle"][0];
    thread func_DC7D();
  } else {
    var_0 = self.var_B004["idle"];
  }

  func_10C47(var_0);
  self func_82E1("idle", var_0, 1, 0.05, 1);
  thread func_9A3B("stop");
  var_1 = "single anim";
  if(!scripts\sp\utility::func_65DF("scene_end")) {
    scripts\sp\utility::func_65E0("scene_end");
  }

  scripts\sp\utility::func_65DD("scene_end");
  var_2 = 0.11;
  if(isDefined(self.var_B004["lookat_lerp"])) {
    var_2 = self.var_B004["lookat_lerp"];
  }

  var_3 = 0.25;
  if(isDefined(self.var_B004["initial_reaction_blendtime"])) {
    var_3 = self.var_B004["initial_reaction_blendtime"];
  }

  var_4 = 0.25;
  if(isDefined(self.var_B004["lookat_follow_blendtime"])) {
    var_4 = self.var_B004["lookat_follow_blendtime"];
  }

  var_5 = 350;
  if(isDefined(self.var_B004["lookat_end_distance"])) {
    var_5 = self.var_B004["lookat_end_distance"];
  }

  var_6 = 0.45;
  if(isDefined(self.var_B004["lookat_end_blendtime"])) {
    var_6 = self.var_B004["lookat_end_blendtime"];
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

    var_7 = lengthsquared(level.player.origin - self.origin);
    var_8 = undefined;
    var_9 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_0A = undefined;
    for(;;) {
      if(isDefined(self.var_B004["interaction_trigger_override"])) {
        break;
      }

      if(scripts\sp\interaction_manager::func_3839(self.var_B004["trigger_radius"] * 2)) {
        if(isDefined(self.var_B004["interaction_position"])) {
          var_7 = lengthsquared(self.var_B004["interaction_position"] - self.origin);
        } else {
          var_7 = lengthsquared(level.player.origin - self.origin);
        }

        if(isDefined(self.var_B004["interaction_trigger_override"])) {
          break;
        } else if(self.var_B004["trigger_radius"] > 0 && var_7 < squared(self.var_B004["trigger_radius"]) && func_9C3D(self, 0.925) && !self.var_DC80) {
          var_0B = self.origin + anglestoup(self.angles) * 66;
          var_8 = vectornormalize(level.player getEye() - var_0B) * self.var_B004["trigger_radius"] + var_0B;
          var_0A = scripts\common\trace::ray_trace(var_0B, var_8, self, var_9);
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
      self give_left_powers(var_1, var_13, 1, var_3, 1);
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
        self give_left_powers(var_1, self.var_B004["scene"][var_14], 1, var_4, 1);
        wait(getanimlength(self.var_B004["scene"][var_14]));
        self.var_EBF8 = self.var_EBF8 + 1;
        self.var_F274 = 1;
      } else {
        func_10C47(self.var_B004["scene"]);
        self give_left_powers(var_1, self.var_B004["scene"], 1, var_4, 1);
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
      self give_left_powers(var_1, var_15, 1, var_6, 1);
      wait(getanimlength(var_15));
      if(isDefined(self.var_B004["end_idle"])) {
        if(isarray(var_0E[0])) {
          if(self.var_1F25 >= var_0E[0].size) {
            func_10C47(self.var_B004["end_idle"]);
            self give_left_powers(var_1, self.var_B004["end_idle"], 1, var_6, 1);
          } else {
            func_10C47(var_0);
            self give_left_powers(var_1, var_0, 1, var_6, 1);
          }
        } else {
          func_10C47(self.var_B004["end_idle"]);
          self give_left_powers(var_1, self.var_B004["end_idle"], 1, var_6, 1);
        }
      } else {
        func_10C47(var_0);
        self give_left_powers(var_1, var_0, 1, var_6, 1);
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
            self func_82E3(var_1, self.var_B004["end_idle"], % body, 1, var_6, 1);
          } else {
            self func_82E3(var_1, var_0, % body, 1, var_6, 1);
          }
        } else {
          self func_82E3(var_1, self.var_B004["end_idle"], % body, 1, var_6, 1);
        }
      } else {
        func_10C47();
        self func_82E3(var_1, self.var_B004["end_idle"], % body, 1, var_6, 1);
      }
    } else {
      func_10C47();
      self func_82E3(var_1, var_0, % body, 1, var_6, 1);
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

  var_0 = undefined;
  self.var_DC80 = 0;
  var_1 = func_7CA7(self.var_9A30);
  if(!isDefined(var_1)) {
    return;
  }

  var_1 = var_1.var_EBEA;
  var_2 = undefined;
  if(isarray(var_1["idle"])) {
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_2 = "idle_female";
    } else {
      var_2 = "idle";
    }

    var_0 = var_1[var_2][0];
    thread func_DC7E();
  } else {
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_2 = "idle_female";
    } else {
      var_2 = "idle";
    }

    var_0 = var_1[var_2];
  }

  var_3 = "single anim";
  func_10C47(var_0);
  self func_82E1(var_3, var_0, 1, 0.5, 1);
  self func_82B0(var_0, randomfloat(1));
  thread func_9A3B("stop");
  thread func_CC88();
  if(!scripts\sp\utility::func_65DF("scene_end")) {
    scripts\sp\utility::func_65E0("scene_end");
  }

  scripts\sp\utility::func_65DD("scene_end");
  var_4 = 0.11;
  var_5 = 0.25;
  var_6 = 0.25;
  var_7 = 350;
  var_8 = 0.45;
  self.var_DD54 = spawn("trigger_radius", self.origin, 0, var_1["trigger_radius"], var_1["trigger_radius"]);
  for(;;) {
    var_9 = lengthsquared(level.player.origin - self.origin);
    var_0A = undefined;
    var_0B = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
    var_0C = undefined;
    for(;;) {
      if(!isDefined(self.var_DD49) || isDefined(self.var_DD49) && self.var_DD49 != "busy" && self.var_DD49 != "nag") {
        if(scripts\sp\interaction_manager::func_3839(var_1["trigger_radius"] * 2)) {
          if(isDefined(var_1["interaction_position"])) {
            var_9 = lengthsquared(var_1["interaction_position"] - self.origin);
          } else {
            var_9 = lengthsquared(level.player.origin - self.origin);
          }

          if(isDefined(var_1["interaction_trigger_override"])) {
            break;
          } else if(var_1["trigger_radius"] > 0 && var_9 < squared(var_1["trigger_radius"]) && func_9C3D(self, 0.925) && !self.var_DC80) {
            var_0D = self.origin + anglestoup(self.angles) * 66;
            var_0A = vectornormalize(level.player getEye() - var_0D) * var_1["trigger_radius"] + var_0D;
            var_0C = scripts\common\trace::ray_trace(var_0D, var_0A, self, var_0B);
            if(isplayer(var_0C["entity"]) || isDefined(var_1["interaction_trigger_override"])) {
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
    if(isDefined(var_1["interaction_position"])) {
      var_0E = vectortoangles(var_1["interaction_position"] - self.origin);
    } else {
      var_0E = vectortoangles(level.player.origin - self.origin);
    }

    var_0F = abs(angleclamp(var_0E - self.angles[1]) - 360);
    var_10 = "lastanim";
    if(isDefined(var_1["angles"])) {
      foreach(var_12 in var_1["angles"]) {
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
    self give_left_powers(var_3, var_15, 1, var_5, 1);
    self.var_9C84 = 1;
    thread scripts\sp\interaction_manager::func_9A39();
    wait(getanimlength(var_15));
    level.var_10E1C[self.var_9A30].var_EBEA["angle_" + var_10 + "_spent"] = scripts\engine\utility::array_add(level.var_10E1C[self.var_9A30].var_EBEA["angle_" + var_10 + "_spent"], var_15);
    level.var_10E1C[self.var_9A30].var_EBEA[var_10] = scripts\engine\utility::array_remove(level.var_10E1C[self.var_9A30].var_EBEA[var_10], var_15);
    if(isDefined(var_1["exitangles"])) {
      if(isDefined(var_1["interaction_position"])) {
        var_0E = vectortoangles(var_1["interaction_position"] - self.origin);
      } else {
        var_0E = vectortoangles(level.player.origin - self.origin);
      }

      var_0F = abs(angleclamp(var_0E - self.angles[1]) - 360);
      var_16 = "lastexitanim";
      foreach(var_18 in var_1["exitangles"]) {
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
      self give_left_powers(var_3, var_1A, 1, var_8, 1);
      wait(getanimlength(var_1A));
      level.var_10E1C[self.var_9A30].var_EBEA[var_16] = scripts\engine\utility::array_remove(level.var_10E1C[self.var_9A30].var_EBEA[var_16], var_1A);
    }

    func_10C47(var_0);
    self give_left_powers(var_3, var_0, 1, var_8, 1);
    self.var_9C84 = 0;
    if(isDefined(var_1["reaction_func"])) {
      self[[var_1["reaction_func"]]]();
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
  var_0 = 0.11;
  var_1 = 0.25;
  var_2 = 0.25;
  var_3 = 350;
  var_4 = func_F8D1();
  var_5 = "single anim";
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
  var_0 = func_7A4C();
  self.var_DC80 = 0;
  func_10C47(var_0);
  self func_82E1("single anim", var_0, 1, 0.05, 1);
  thread func_9A3B("stop");
}

func_7A4C() {
  var_0 = undefined;
  if(isarray(self.var_B004["idle"])) {
    var_0 = self.var_B004["idle"][0];
  } else {
    var_0 = self.var_B004["idle"];
  }

  return var_0;
}

func_9C61() {
  var_0 = undefined;
  if((level.player istouching(self.var_DD54) || func_9C3D(self, 0.925)) && !self.var_DC80) {
    if(self.var_F274) {
      var_0 = 1;
    } else {
      var_0 = 0;
    }
  } else {
    var_0 = 0;
  }

  return var_0;
}

func_2B88() {
  var_0 = lengthsquared(level.player.origin - self.origin);
  var_1 = undefined;
  var_2 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_3 = undefined;
  for(;;) {
    var_4 = scripts\sp\interaction_manager::func_3839(self.var_B004["trigger_radius"] * 2);
    if(var_4) {
      if(isDefined(self.var_B004["interaction_position"])) {
        var_0 = lengthsquared(self.var_B004["interaction_position"] - self.origin);
      } else {
        var_0 = lengthsquared(level.player.origin - self.origin);
      }

      if(isDefined(self.var_B004["interaction_trigger_override"])) {
        break;
      } else if(self.var_B004["trigger_radius"] > 0 && var_0 < squared(self.var_B004["trigger_radius"]) && func_9C3D(self, 0.925) && !self.var_DC80) {
        var_5 = self.origin + anglestoup(self.angles) * 66;
        var_1 = vectornormalize(level.player getEye() - var_5) * self.var_B004["trigger_radius"] + var_5;
        var_3 = scripts\common\trace::ray_trace(var_5, var_1, self, var_2);
        if(isplayer(var_3["entity"]) || isDefined(self.var_B004["interaction_trigger_override"])) {
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_CCA9() {
  func_9842();
  var_0 = 0;
  var_1 = 0;
  var_2 = gettime() / 1000;
  var_3 = getanimlength(self.var_B004["fwd_anim"]);
  while(gettime() / 1000 - var_2 < var_3) {
    var_4 = vectornormalize(level.player.origin - self.origin);
    var_5 = anglesToForward(self.angles);
    var_6 = anglesToForward(self.angles) * -1;
    var_7 = anglestoright(self.angles);
    var_8 = anglestoright(self.angles) * -1;
    var_9 = anglestoup(self.angles);
    var_0A = clamp(vectordot(var_4, var_5), 0.005, 1);
    var_0B = clamp(vectordot(var_4, var_7), 0.005, 1);
    var_0C = clamp(vectordot(var_4, var_8), 0.005, 1);
    var_0D = clamp(vectordot(var_4, var_6), 0.005, 1);
    self func_82AC(self.var_B004["right_anim"], var_0B, 0.2);
    self func_82AC(self.var_B004["left_anim"], var_0C, 0.2);
    self func_82E8("single anim", self.var_B004["fwd_anim"], var_0A + 0.005, 0.2);
    var_0E = 1;
    if(scripts\engine\utility::anglebetweenvectorssigned(var_5, var_4, var_9) > 0) {
      var_0E = 0;
    }

    if(var_0E) {
      var_1 = scripts\sp\math::func_AB6F(var_1, var_0D, 0.1);
      var_0 = scripts\sp\math::func_AB6F(var_0, 0.005, 0.1);
    } else {
      var_1 = scripts\sp\math::func_AB6F(var_1, 0.005, 0.1);
      var_0 = scripts\sp\math::func_AB6F(var_0, var_0D, 0.1);
    }

    self func_82AC(self.var_B004["back_right_anim"], var_1, 0.2);
    self func_82AC(self.var_B004["back_left_anim"], var_0, 0.2);
    scripts\engine\utility::waitframe();
  }

  var_0F = 0.45;
  func_62AB(var_0F);
  func_CD4E(var_0F);
}

func_9842() {
  var_0 = undefined;
  var_0 = vectortoangles(level.player.origin - self.origin);
  self.var_9C84 = 1;
  level thread scripts\sp\interaction_manager::func_9A0E(self);
  self func_82AC(self.var_B004["interaction_blend_parent"], 1, 0.2);
  var_1 = func_7A4C();
  self clearanim(var_1, 0.2);
  self clearanim( % head, 0.2);
  func_10C47(self.var_B004["fwd_anim"]);
  self func_82E8("single anim", self.var_B004["fwd_anim"], 0.005, 0.05);
  self func_82AC(self.var_B004["right_anim"], 0.005, 0.05);
  self func_82AC(self.var_B004["left_anim"], 0.005, 0.05);
  self func_82AC(self.var_B004["back_right_anim"], 0.005, 0.05);
  self func_82AC(self.var_B004["back_left_anim"], 0.005, 0.05);
}

func_62AB(var_0) {
  self.var_DD3C = undefined;
  self clearanim(self.var_B004["fwd_anim"], var_0);
  self clearanim(self.var_B004["right_anim"], var_0);
  self clearanim(self.var_B004["left_anim"], var_0);
  self clearanim(self.var_B004["back_right_anim"], var_0);
  self clearanim(self.var_B004["back_left_anim"], var_0);
  level notify("interaction_done");
  self notify("interaction_done");
  self.var_9C84 = 0;
}

func_CD4E(var_0) {
  for(;;) {
    var_1 = undefined;
    if(isDefined(self.var_B004["end_idle"])) {
      var_1 = self.var_B004["end_idle"];
      func_10C47(var_1);
      self func_82B0(var_1, 0);
      self func_82E3("single anim", var_1, % body, 1, var_0, 1);
    } else {
      var_1 = func_7A4C();
      func_10C47(var_1);
      self func_82B0(var_1, 0);
      self func_82E3("single anim", var_1, % body, 1, var_0, 1);
    }

    wait(getanimlength(var_1));
  }
}

func_101F9() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_0 = func_7A45(self.var_9A30);
  if(!scripts\sp\utility::func_65DF("hold_simple_idles")) {
    scripts\sp\utility::func_65E0("hold_simple_idles");
  } else {
    scripts\sp\utility::func_65DD("hold_simple_idles");
  }

  if(!isarray(var_0.var_EBEA["idle"])) {
    return;
  }

  if(isarray(var_0.var_EBEA["idle"]) && var_0.var_EBEA["idle"].size <= 1) {
    return;
  }

  var_1 = [];
  var_2 = var_0.var_EBEA["idle"];
  var_3 = var_2[0];
  var_2 = scripts\sp\utility::array_remove_index(var_2, 0);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  if(isDefined(var_0.var_EBEA["idle_prop"]) && isDefined(self.var_C6B7)) {
    var_4 = [];
    var_0.var_EBEA["spent_array_prop"] = var_4;
    var_6 = var_0.var_EBEA["idle_prop"];
    var_5 = var_6[0];
    var_6 = scripts\sp\utility::array_remove_index(var_6, 0);
    var_7 = var_6;
    var_6 = undefined;
  }

  var_8 = var_2;
  var_2 = undefined;
  thread func_4179();
  func_9A3B("stop");
  for(;;) {
    if(isDefined(self.var_C6B9)) {
      func_13CA(self.var_C6B9, var_3);
    }

    func_10C47(var_3);
    self give_left_powers("single anim", var_3, 1, 0.2, 1);
    thread lib_0C4C::func_19BE();
    if(isDefined(self.var_C6B7)) {
      thread func_1404(var_5);
    }

    wait(getanimlength(var_3) * randomintrange(1, 2));
    while(scripts\sp\utility::func_65DB("hold_simple_idles")) {
      wait(getanimlength(var_3));
    }

    if(var_8.size <= 0) {
      var_8 = var_1;
      var_1 = [];
    }

    var_9 = randomint(var_8.size);
    var_0A = var_8[var_9];
    var_1 = scripts\engine\utility::array_add(var_1, var_0A);
    var_8 = scripts\sp\utility::array_remove_index(var_8, var_9);
    if(isDefined(self.var_C6B7)) {
      if(var_7.size <= 0) {
        var_7 = var_4;
        var_4 = [];
      }

      var_0B = var_7[var_9];
      var_4 = scripts\engine\utility::array_add(var_4, var_0B);
      var_7 = scripts\sp\utility::array_remove_index(var_7, var_9);
      thread func_1403(var_0B);
    }

    self clearanim(var_3, 0.2);
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

func_13CA(var_0, var_1) {
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1);
  if(!isDefined(self.var_9B89)) {
    self func_80F1(var_2, var_3, 100000);
    wait(0.05);
    return;
  }

  self.origin = var_2;
  self.angles = var_3;
  self dontinterpolate();
  wait(0.05);
}

func_1403(var_0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_C6B7 glinton(#animtree);
  self.var_C6B7 clearanim(self.var_C6B7.var_4B31, 0.2);
  self.var_C6B7 setanimknob(var_0, 1, 0.2, 1);
  self.var_C6B7.var_4B31 = var_0;
}

func_1404(var_0) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_C6B7 glinton(#animtree);
  self.var_C6B7 setanimknob(var_0, 1, 0.2, 1);
  self.var_C6B7.var_4B31 = var_0;
}

func_1402() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self.var_C6B7 glinton(#animtree);
  self.var_C6B7 clearanim(self.var_C6B7.var_4B31, 0.2);
}

func_CC8B(var_0, var_1) {
  wait(var_0);
  var_2 = strtok(var_1, "_");
  if(scripts\engine\utility::array_contains(var_2, "plr")) {
    level.player scripts\sp\utility::play_sound_on_entity(var_1);
    return;
  }

  scripts\sp\utility::func_10346(var_1);
}

func_1368() {
  self notify("start_interaction_vo_note");
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("start_interaction_vo_note");
  for(;;) {
    self waittill("single anim", var_0);
    if(isarray(var_0)) {
      foreach(var_2 in var_0) {
        if(issubstr(var_2, "vo_") && !issubstr(var_2, "_plr")) {
          var_3 = getsubstr(var_2, 3);
          thread scripts\sp\utility::func_10346(var_3);
          wait(lookupsoundlength(var_3) / 1000);
          self notify("single dialogue");
          if(isDefined(self.var_EF82)) {
            self clearanim(self.var_EF82, 0.2);
          }
        }
      }

      continue;
    }

    if(issubstr(var_0, "vo_") && !issubstr(var_0, "_plr")) {
      var_3 = getsubstr(var_0, 3);
      thread scripts\sp\utility::func_10346(var_3);
      wait(lookupsoundlength(var_3) / 1000);
      self notify("single dialogue");
      if(isDefined(self.var_EF82)) {
        self clearanim(self.var_EF82, 0.2);
      }
    }
  }
}

func_CDB1(var_0) {
  self endon("death");
  self endon("stop_smart_reaction");
  var_1 = 0;
  while(!var_1) {
    self waittill("single anim", var_2);
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4 == "reaction_vo") {
          var_1 = 1;
          break;
        }
      }

      continue;
    }

    if(var_2 == "reaction_vo") {
      var_1 = 1;
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self notify("reaction_vo_fired");
  scripts\sp\interaction_manager::func_CE17(var_0);
}

func_CC88() {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  var_0 = undefined;
  var_1 = undefined;
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

    var_2 = level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_male"];
    var_3 = randomint(var_2.size);
    var_1 = var_2[var_3];
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_male"] = scripts\sp\utility::array_remove_index(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_male"], var_3);
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_male_vo"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_male_vo"], var_1);
  }

  if(!isDefined(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"])) {
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"] = [];
  }

  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    if(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"].size < 1) {
      level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"] = level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"];
    }

    var_2 = level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"];
    var_3 = randomint(var_2.size);
    var_1 = var_2[var_3];
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"] = scripts\sp\utility::array_remove_index(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["vo_lines_female"], var_3);
    level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["registered_state_interactions"][self.var_9A30]["used_female_vo"], var_1);
  }

  var_4 = undefined;
  for(;;) {
    self waittill("single anim", var_5);
    if(isarray(var_5)) {
      foreach(var_7 in var_5) {
        if(var_7 == "reaction_vo") {
          var_4 = 1;
          break;
        }
      }
    } else if(var_5 == "reaction_vo") {
      var_4 = 1;
    }

    if(isDefined(var_4)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::func_10346(var_1);
}

func_CC8C(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30];
  if(isDefined(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"])) {
    var_1 = 1;
    if(!isDefined(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"])) {
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "male")) {
      if(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"].size < 1) {
        level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"] = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"];
      }

      var_4 = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"];
      var_5 = randomint(var_4.size);
      var_2 = var_4[var_5];
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"] = scripts\sp\utility::array_remove_index(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_male"], var_5);
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_male_vo"], var_2);
    }
  }

  if(isDefined(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"])) {
    var_1 = 1;
    if(!isDefined(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"])) {
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"] = [];
    }

    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      if(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"].size < 1) {
        level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"] = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"];
      }

      var_4 = level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"];
      var_5 = randomint(var_4.size);
      var_2 = var_4[var_5];
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"] = scripts\sp\utility::array_remove_index(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["vo_lines_female"], var_5);
      level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["registered_interactions"][self.var_9A30]["used_female_vo"], var_2);
    }
  }

  var_6 = var_0.size - 1;
  if(!isDefined(var_1)) {
    if(isstring(var_0[var_6])) {
      for(var_7 = 1; var_7 < var_0.size; var_7 = var_7 + 2) {
        func_CC8B(var_0[var_7], var_0[var_7 + 1]);
      }

      return;
    }

    for(var_7 = 1; var_7 < var_0.size - 1; var_7 = var_7 + 2) {
      func_CC8B(var_0[var_7], var_0[var_7 + 1]);
    }

    return;
  }

  func_CC8B(var_0[1], var_2);
}

func_F59A(var_0) {
  self.var_F275 = 0;
  self.var_F273 = 0;
  var_1 = var_0.size - 1;
  if(isstring(var_0[var_1])) {
    self.var_F273 = 0;
    for(var_2 = 1; var_2 < var_0.size; var_2 = var_2 + 2) {
      self.var_F275 = self.var_F275 + var_0[var_2];
    }

    return;
  }

  self.var_F273 = var_1[var_2];
  for(var_2 = 1; var_2 < var_0.size - 1; var_2 = var_2 + 2) {
    self.var_F275 = self.var_F275 + var_0[var_2];
  }
}

func_DC7D() {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  self endon("death");
  var_0 = undefined;
  var_1 = func_7A45(self.var_9A30);
  if(!isDefined(var_1)) {
    var_1 = func_7CA7(self.var_9A30);
  }

  self.var_383A = 1;
  self.var_9C83 = undefined;
  if(!isarray(var_1.var_EBEA["idle"])) {
    var_1.var_EBEA["idle"] = [var_1.var_EBEA["idle"], var_1.var_EBEA["idle"]];
  }

  var_2 = [];
  var_3 = var_1.var_EBEA["idle"];
  var_4 = var_3[0];
  var_3 = scripts\sp\utility::array_remove_index(var_3, 0);
  var_5 = var_3;
  var_3 = undefined;
  self.var_10DB2 = var_4;
  for(;;) {
    self.var_9C83 = 1;
    var_6 = getanimlength(var_4);
    var_7 = randomint(2) + 1;
    var_8 = var_6 * float(var_7);
    wait(var_8);
    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    if(var_5.size <= 0) {
      var_5 = var_2;
      var_2 = [];
    }

    var_9 = var_5[randomint(var_5.size)];
    var_2 = scripts\engine\utility::array_add(var_2, var_9);
    var_5 = scripts\engine\utility::array_remove(var_5, var_9);
    var_0A = undefined;
    var_0B = undefined;
    if(isDefined(self.var_C6B9)) {
      var_0A = getstartorigin(self.var_C6B9.origin, self.var_C6B9.angles, var_9);
      var_0B = getstartangles(self.var_C6B9.origin, self.var_C6B9.angles, var_9);
      if(!isDefined(self.var_9B89)) {
        self func_80F1(var_0A, var_0B);
      } else {
        self.origin = var_0A;
        self.angles = var_0B;
      }
    }

    while(self.var_9C84) {
      scripts\engine\utility::waitframe();
    }

    func_10C47(var_9);
    self give_left_powers("single anim", var_9, 1, 0.2, 1);
    self.var_DC80 = 1;
    var_0C = getanimlength(var_9);
    wait(var_0C);
    while(self.var_9C84) {
      scripts\engine\utility::waitframe();
    }

    if(isDefined(self.var_C6B9)) {
      var_0A = getstartorigin(self.var_C6B9.origin, self.var_C6B9.angles, var_4);
      var_0B = getstartangles(self.var_C6B9.origin, self.var_C6B9.angles, var_4);
      if(!isDefined(self.var_9B89)) {
        self func_80F1(var_0A, var_0B);
      } else {
        self.origin = var_0A;
        self.angles = var_0B;
      }
    }

    self.var_DC80 = 0;
    self clearanim(var_9, 0.3);
    self.var_9C83 = undefined;
    func_10C47(var_4);
    self give_left_powers("single anim", var_4, 1, 0.2, 1);
    self func_82B0(var_4, randomfloat(1));
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
  var_0 = undefined;
  var_1 = func_7CA7(self.var_9A30);
  self.var_383A = 1;
  self.var_9C83 = undefined;
  var_2 = undefined;
  if(isDefined(self.gender) && issubstr(self.gender, "female")) {
    var_2 = "idle_female";
  } else {
    var_2 = "idle";
  }

  var_3 = var_1.var_EBEA[var_2][0];
  self.var_10DB2 = var_3;
  for(;;) {
    self.var_9C83 = 1;
    var_4 = getanimlength(var_3);
    var_5 = randomint(2) + 1;
    var_6 = var_4 * float(var_5);
    wait(var_6);
    for(;;) {
      if(distance2dsquared(self.origin, level.player.origin) >= squared(150)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    var_7 = undefined;
    var_8 = undefined;
    if(isDefined(self.gender) && issubstr(self.gender, "female")) {
      var_7 = "random_idles_female";
      var_8 = "spent_random_idles_female";
    } else {
      var_7 = "random_idles";
      var_8 = "spent_random_idles";
    }

    if(level.var_10E1C[self.var_9A30].var_EBEA[var_7].size <= 0) {
      level.var_10E1C[self.var_9A30].var_EBEA[var_7] = level.var_10E1C[self.var_9A30].var_EBEA[var_8];
      level.var_10E1C[self.var_9A30].var_EBEA[var_8] = [];
    }

    var_9 = level.var_10E1C[self.var_9A30].var_EBEA[var_7][randomint(level.var_10E1C[self.var_9A30].var_EBEA[var_7].size)];
    level.var_10E1C[self.var_9A30].var_EBEA[var_8] = scripts\engine\utility::array_add(level.var_10E1C[self.var_9A30].var_EBEA[var_8], var_9);
    level.var_10E1C[self.var_9A30].var_EBEA[var_7] = scripts\engine\utility::array_remove(level.var_10E1C[self.var_9A30].var_EBEA[var_7], var_9);
    var_0A = undefined;
    var_0B = undefined;
    if(isDefined(self.var_C6B9)) {
      var_0A = getstartorigin(self.var_C6B9.origin, self.var_C6B9.angles, var_9);
      var_0B = getstartangles(self.var_C6B9.origin, self.var_C6B9.angles, var_9);
      if(!isDefined(self.var_9B89)) {
        self func_80F1(var_0A, var_0B);
      } else {
        self.origin = var_0A;
        self.angles = var_0B;
      }
    }

    while(self.var_9C84) {
      scripts\engine\utility::waitframe();
    }

    func_10C47(var_9);
    self give_left_powers("single anim", var_9, 1, 0.2, 1);
    self.var_DC80 = 1;
    var_0C = getanimlength(var_9);
    wait(var_0C);
    while(self.var_9C84) {
      scripts\engine\utility::waitframe();
    }

    if(isDefined(self.var_C6B9)) {
      var_0A = getstartorigin(self.var_C6B9.origin, self.var_C6B9.angles, var_3);
      var_0B = getstartangles(self.var_C6B9.origin, self.var_C6B9.angles, var_3);
      if(!isDefined(self.var_9B89)) {
        self func_80F1(var_0A, var_0B);
      } else {
        self.origin = var_0A;
        self.angles = var_0B;
      }
    }

    self.var_DC80 = 0;
    self clearanim(var_9, 0.3);
    self.var_9C83 = undefined;
    func_10C47(var_3);
    self give_left_powers("single anim", var_3, 1, 0.2, 1);
    self func_82B0(var_3, randomfloat(1));
    for(;;) {
      if(isDefined(self.var_383A)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    scripts\engine\utility::waitframe();
  }
}

func_DC7F(var_0, var_1, var_2) {
  self endon("reaction_end");
  self endon("stop_idle_controller");
  level endon("stop_idle_controller");
  self endon("stop_group_idle_controller");
  level endon("stop_group_idle_controller");
  self endon("death");
  if(!scripts\engine\utility::flag_exist("hold_group_vignettes")) {
    scripts\engine\utility::flag_init("hold_group_vignettes");
  }

  var_3 = [];
  var_4 = var_2;
  for(;;) {
    wait(randomfloatrange(var_1 * 0.5, var_1));
    foreach(var_6 in var_0) {
      if(!isDefined(var_6)) {
        self notify("stop_group_idle_controller");
        return;
      }

      var_6 endon("death");
      var_6 endon("entitydeleted");
      var_6.var_383A = undefined;
    }

    var_8 = 0;
    for(;;) {
      if(!scripts\engine\utility::flag("hold_group_vignettes")) {
        foreach(var_0A in var_0) {
          if(!isDefined(var_0A.var_9C83)) {
            var_8++;
          }
        }

        if(var_8 >= var_0.size) {
          break;
        } else {
          var_8 = 0;
        }
      }

      scripts\engine\utility::waitframe();
    }

    var_0C = undefined;
    if(isarray(var_2)) {
      if(var_4.size <= 0) {
        var_4 = var_2;
        var_3 = [];
      }

      var_0C = var_4[randomint(var_4.size)];
    } else {
      var_0C = var_2;
    }

    var_0D = 0;
    if(!scripts\engine\utility::flag("hold_group_vignettes")) {
      foreach(var_6 in var_0) {
        if(!isDefined(var_6)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var_0F = var_6 scripts\sp\utility::func_7DC1(var_0C);
        var_10 = getstartorigin(var_6.origin, var_6.angles, var_0F);
        var_11 = getstartangles(var_6.origin, var_6.angles, var_0F);
        if(isai(var_6)) {
          var_6 func_80F1(var_10, var_11);
        } else {
          var_6.origin = var_10;
          var_6.angles = var_11;
        }

        var_6 thread func_10C47(var_0F);
        var_6 give_left_powers("single anim", var_0F, 1, 0.2);
        var_6.var_1C4D = 0;
        var_6.var_906F = 1;
        var_0D = getanimlength(var_0F);
      }

      wait(var_0D);
      if(isarray(var_2)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_0C);
        var_4 = scripts\engine\utility::array_remove(var_4, var_0C);
      }

      foreach(var_14 in var_0) {
        if(!isDefined(var_14)) {
          self notify("stop_group_idle_controller");
          return;
        }

        var_0F = var_14 scripts\sp\utility::func_7DC1(var_0C);
        var_14 thread func_10C47(var_14.var_10DB2);
        var_14 setanimknob(var_0F, 0, 0.2);
        var_14 give_left_powers("single anim", var_14.var_10DB2, 1, 0.2, 1);
        var_14 func_82B0(var_14.var_10DB2, randomfloat(1));
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

func_F5CD(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = self getscoreinfocategory(var_0);
  var_4 = getanimlength(var_0);
  var_5 = var_1 - var_3 * var_4 / 0.05;
  self func_82AC(var_0, var_2, 0.25, var_5);
}

func_CCCA(var_0, var_1) {
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
  self.var_43E5 = var_1;
  if(isDefined(level.var_9A2E)) {
    level.var_9A2E.var_4D94["actors"] = scripts\engine\utility::array_add(level.var_9A2E.var_4D94["actors"], self);
  }

  while(self.script == "init") {
    scripts\engine\utility::waitframe();
  }

  for(;;) {
    for(;;) {
      var_2 = lengthsquared(level.player.origin - self.origin);
      if(var_2 < squared(150) && func_9C3D(self, 0.925)) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    var_3 = self.asmname;
    var_4 = self.var_164D[var_3].var_4BC0;
    var_5 = level.asm[var_3].states[var_4];
    var_6 = var_5.var_C87F;
    self.var_43E4 = lib_0A1E::asm_getallanimsforstate(var_3, var_1);
    level.asm[var_3].states[var_4].var_C87F = var_6;
    if(var_4 == self.var_43E5 && !self.var_BE79) {
      if(var_0.var_EE92 == "combat_reaction") {
        var_7 = [];
        if(isDefined(var_0.type)) {
          switch (var_0.type) {
            case "Cover Crouch":
              var_7 = ["combat_crouch_1", "combat_crouch_2"];
              break;

            case "Cover Left":
              switch (self.a.pose) {
                case "stand":
                  var_7 = ["hm_grnd_org_cover_left_stand_react_01", "hm_grnd_org_cover_left_stand_react_02"];
                  break;

                case "crouch":
                  var_7 = ["hm_grnd_org_cover_left_crouch_react_01", "hm_grnd_org_cover_left_crouch_react_02"];
                  break;

                case "prone":
                  break;
              }
              break;

            case "Cover Right":
              switch (self.a.pose) {
                case "stand":
                  var_7 = ["hm_grnd_org_cover_right_stand_react_01", "hm_grnd_org_cover_right_stand_react_02"];
                  break;

                case "crouch":
                  var_7 = ["hm_grnd_org_cover_right_crouch_react_01", "hm_grnd_org_cover_right_crouch_react_02"];
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
              var_7 = ["combat_cover_crouch_1"];
              break;
          }

          if(var_7.size > 0) {
            var_8 = randomint(var_7.size);
            var_9 = var_7[var_8];
            func_43DA(var_9, var_0);
          } else {
            return;
          }
        }
      } else {
        func_43DA(var_0.var_EE92, var_0);
      }
    }

    wait(1.5);
  }
}

func_43DA(var_0, var_1) {
  self endon("death");
  self endon("interaction_done");
  var_2 = func_7A45(var_0);
  thread scripts\sp\anim::func_10CBF(self, "vo");
  thread func_1368();
  if(!isDefined(var_2)) {
    return;
  }

  self.var_B004 = var_2.var_EBEA;
  if(!isDefined(self.var_1FBB)) {
    self.var_1FBB = "generic";
  }

  var_3 = lengthsquared(level.player.origin - self.origin);
  var_4 = undefined;
  var_5 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_6 = undefined;
  if(isDefined(self.var_B004["interaction_position"])) {
    var_3 = lengthsquared(self.var_B004["interaction_position"] - self.origin);
  } else {
    var_3 = lengthsquared(level.player.origin - self.origin);
  }

  if(var_3 < squared(self.var_B004["trigger_radius"]) && func_9C3D(self, 0.925)) {
    var_4 = vectornormalize(level.player getEye() - self getEye()) * self.var_B004["trigger_radius"] + self getEye();
    var_6 = scripts\common\trace::ray_trace(self getEye(), var_4, self, var_5);
    if(isplayer(var_6["entity"])) {
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
  var_0 = self.var_43E4;
  var_1 = undefined;
  if(isDefined(self.var_B004["interaction_position"])) {
    var_1 = vectortoangles(self.var_B004["interaction_position"] - self.origin);
  } else {
    var_1 = vectortoangles(level.player.origin - self.origin);
  }

  var_2 = abs(angleclamp(var_1 - self.angles[1]) - 360);
  var_3 = self.var_B004["lastanim"];
  if(isDefined(self.var_B004["angles"])) {
    foreach(var_5 in self.var_B004["angles"]) {
      if(var_2 <= var_5) {
        var_3 = self.var_B004[var_5];
        break;
      }
    }
  }

  if(isarray(var_3)) {
    if(isarray(var_3[0])) {
      var_7 = self.var_1F25;
      var_8 = var_3[0][var_7][0];
    } else {
      var_8 = var_8[0];
    }
  } else {
    var_8 = var_8;
  }

  func_10C47(var_8);
  self func_82AC( % cover, 0, 0.25, 1);
  self func_82E3("vo", var_8, % body, 1, 0.25, 1);
  wait(getanimlength(var_8));
  self clearanim( % scripted, 0.25);
  self func_82AC( % cover, 1, 0.25, 1);
  self.var_9C84 = 0;
  wait(0.25);
  self notify("interaction_done");
  level notify("interaction_done");
  thread func_9A0F();
}

func_43E7(var_0) {
  var_0.var_43E6 = 1;
  wait(2);
  var_0.var_43E6 = undefined;
}

func_BF07() {
  self endon("death");
  self endon("reaction_done");
  self endon("entitydeleted");
  var_0 = undefined;
  if(isDefined(self.var_A906)) {
    var_0 = self.var_A906.origin;
    while(isDefined(self.var_A906) && self.var_A906.origin == var_0) {
      scripts\engine\utility::waitframe();
    }
  } else if(isDefined(self.var_A905)) {
    var_0 = self.var_A905.origin;
    while(isDefined(self.var_A905) && self.var_A905.origin == var_0) {
      scripts\engine\utility::waitframe();
    }
  } else if(isDefined(self.var_A907)) {
    var_0 = self.var_A907;
    while(isDefined(self.var_A907) && self.var_A907 == var_0) {
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

func_9A3B(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "stop";
  }

  if(isai(self)) {
    self.a.movement = var_0;
    return;
  }
}

func_10C47(var_0) {
  var_1 = undefined;
  if(isDefined(self.var_9A30)) {
    var_1 = self.var_9A30;
  }

  thread scripts\sp\anim::func_10CBF(self, "single anim", var_1, undefined, var_0);
  thread scripts\sp\anim::func_1FCA(self, "single anim", var_1);
}