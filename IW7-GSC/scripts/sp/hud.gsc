/******************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\hud.gsc
******************************/

init() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "left";
  level.uiparent.vertalign = "top";
  level.uiparent.alignx = "left";
  level.uiparent.aligny = "top";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  if(level.console) {
    level.fontheight = 12;
  } else {
    level.fontheight = 12;
  }

  setdvar("ui_remotemissile_playernum", 0);
  setdvar("ui_pmc_won", 0);
  setdvar("ui_actionSlot_1_forceActive", "off");
  setdvar("ui_actionSlot_2_forceActive", "off");
  setdvar("ui_actionSlot_3_forceActive", "off");
  setdvar("ui_actionSlot_4_forceActive", "off");
  setdvar("hideHudFast", 0);
  setdvar("ui_securing", "");
  setdvar("ui_securing_progress", 0);
  setdvar("hud_showObjectives", 1);
  setdvar("hud_showIntel", 1);
  setdvar("minimap_sp", 0);
  setdvar("minimap_full_sp", 0);
  loadluifile("inGame.sp.KleenexPopup");
  func_8DF5();
}

func_8DF5() {
  if(isDefined(level.var_8DF1)) {
    return;
  }

  var_00 = [];
  var_00["oxygen"] = 0;
  var_00["temperature"] = 0;
  var_00["pressure"] = 0;
  level.var_8DF1 = var_00;
}

func_8DF9(param_00, param_01) {
  if(param_00 == "suit") {
    var_02 = randomfloatrange(93.83, 93.87);
    var_03 = randomintrange(18, 22);
    var_04 = randomfloatrange(8.2, 8.4);
  } else {
    var_02 = randomfloatrange(20.93, 20.97);
    var_03 = randomintrange(18, 22);
    var_04 = randomfloatrange(14.5, 14.9);
  }

  if(isDefined(param_01) && param_01) {
    level.var_8DF1["oxygen"] = var_02;
    level.var_8DF1["temperature"] = var_03;
    level.var_8DF1["pressure"] = var_04;
    return;
  }

  level.var_8DF1["oxygen"] = 0;
  level.var_8DF1["temperature"] = 0;
  level.var_8DF1["pressure"] = 0;
  var_05 = randomfloatrange(3, 4);
  thread func_8DFB("oxygen", var_05, var_02);
  thread func_8DFB("temperature", var_05, var_03);
  thread func_8DFB("pressure", var_05, var_04);
}

func_8DF8(param_00) {
  thread func_8DFA("oxygen", randomfloatrange(3, 4), 0);
  thread func_8DFA("temperature", randomfloatrange(3, 4), 0);
  thread func_8DFA("pressure", randomfloatrange(3, 4), 0);
}

func_8DF7(param_00, param_01) {
  var_02 = randomfloatrange(93.83, 93.87);
  var_03 = randomintrange(18, 22);
  var_04 = randomfloatrange(8.2, 8.4);
  level.var_8DF1["oxygen"] = var_02;
  level.var_8DF1["temperature"] = var_03;
  level.var_8DF1["pressure"] = var_04;
  if(isDefined(param_01) && param_01) {
    return;
  }

  if(!isDefined(param_00)) {
    setomnvar("ui_helmet_meter_oxygen", func_8DFC("oxygen", var_02));
    setomnvar("ui_helmet_meter_temperature", func_8DFC("temperature", var_03));
    setomnvar("ui_helmet_meter_pressure", func_8DFC("pressure", var_04));
    return;
  }

  thread func_8DFB("oxygen", param_00, var_02);
  thread func_8DFB("temperature", param_00, var_03);
  thread func_8DFB("pressure", param_00, var_04);
}

func_8DF6(param_00, param_01) {
  var_02 = randomfloatrange(20.93, 20.97);
  var_03 = randomintrange(18, 22);
  var_04 = randomfloatrange(14.5, 14.9);
  level.var_8DF1["oxygen"] = var_02;
  level.var_8DF1["temperature"] = var_03;
  level.var_8DF1["pressure"] = var_04;
  if(isDefined(param_01) && param_01) {
    return;
  }

  if(!isDefined(param_00)) {
    setomnvar("ui_helmet_meter_oxygen", func_8DFC("oxygen", var_02));
    setomnvar("ui_helmet_meter_temperature", func_8DFC("temperature", var_03));
    setomnvar("ui_helmet_meter_pressure", func_8DFC("pressure", var_04));
    return;
  }

  thread func_8DFB("oxygen", param_00, var_02);
  thread func_8DFB("temperature", param_00, var_03);
  thread func_8DFB("pressure", param_00, var_04);
}

func_8DFD(param_00, param_01, param_02) {
  if(isDefined(param_02) && param_02) {
    level.var_8DF1["oxygen"] = param_00;
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = randomfloatrange(3, 4);
  }

  func_8DFA("oxygen", param_01, param_00);
  func_8E00("oxygen");
}

func_8DFF(param_00, param_01, param_02) {
  if(isDefined(param_02) && param_02) {
    level.var_8DF1["temperature"] = param_00;
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = randomfloatrange(3, 4);
  }

  func_8DFA("temperature", param_01, param_00);
  func_8E00("temperature");
}

func_8DFE(param_00, param_01, param_02) {
  if(isDefined(param_02) && param_02) {
    level.var_8DF1["pressure"] = param_00;
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = randomfloatrange(3, 4);
  }

  func_8DFA("pressure", param_01, param_00);
  func_8E00("pressure");
}

func_8DF2(param_00) {
  var_01 = randomfloatrange(20.93, 20.97);
  var_02 = randomintrange(18, 22);
  var_03 = randomfloatrange(14.5, 14.9);
  if(!isDefined(param_00)) {
    param_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("oxygen", param_00, var_01);
  if(!isDefined(param_00)) {
    param_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("temperature", param_00, var_02);
  if(!isDefined(param_00)) {
    param_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("pressure", param_00, var_03);
}

func_8DF3(param_00) {
  var_01 = randomfloatrange(93.83, 93.87);
  var_02 = randomintrange(18, 22);
  var_03 = randomfloatrange(8.2, 8.4);
  if(!isDefined(param_00)) {
    param_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("oxygen", param_00, var_01);
  if(!isDefined(param_00)) {
    param_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("temperature", param_00, var_02);
  if(!isDefined(param_00)) {
    param_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("pressure", param_00, var_03);
}

func_8DF4(param_00, param_01) {
  if(param_00 == "interior") {
    var_02 = randomfloatrange(20.93, 20.97);
    var_03 = randomintrange(18, 22);
    var_04 = randomfloatrange(14.5, 14.9);
  } else {
    var_02 = randomfloatrange(6, 8);
    var_03 = randomintrange(-60, -50);
    var_04 = randomfloatrange(4, 6);
  }

  if(!isDefined(param_01)) {
    param_01 = randomfloatrange(2, 3);
  }

  thread func_8DFB("oxygen", param_01, var_02);
  if(!isDefined(param_01)) {
    param_01 = randomfloatrange(2, 3);
  }

  thread func_8DFB("temperature", param_01, var_03);
  if(!isDefined(param_01)) {
    param_01 = randomfloatrange(2, 3);
  }

  thread func_8DFB("pressure", param_01, var_04);
}

func_8DFA(param_00, param_01, param_02) {
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = abs(param_02 - level.var_8DF1[param_00] / param_01 * 0.05);
  var_07 = "ui_helmet_meter_" + param_00;
  if(param_00 == "oxygen") {
    var_03 = 1;
    var_04 = 1;
  } else if(param_00 == "temperature") {
    var_03 = 2;
    var_04 = 3;
  } else if(param_00 == "pressure") {
    var_03 = 1;
    var_04 = 1;
  }

  var_08 = var_03 * 0.05;
  var_09 = var_04 * 0.05;
  var_0A = 1;
  if(param_02 == level.var_8DF1[param_00]) {
    return;
  } else if(param_02 < level.var_8DF1[param_00]) {
    var_0A = 0;
  }

  var_0B = 0;
  while(var_0B < param_01) {
    if(var_0A) {
      level.var_8DF1[param_00] = level.var_8DF1[param_00] + var_06;
    } else {
      level.var_8DF1[param_00] = level.var_8DF1[param_00] - var_06;
    }

    var_0C = func_8DFC(param_00, level.var_8DF1[param_00]);
    setomnvar(var_07, var_0C);
    wait(0.05);
    var_0B = var_0B + 0.05;
  }

  var_0C = func_8DFC(param_00, level.var_8DF1[param_00]);
  setomnvar(var_07, var_0C);
}

func_8E00(param_00) {
  var_01 = 0;
  if(param_00 == "oxygen") {
    var_01 = randomfloatrange(-0.5, 0.5) + level.var_8DF1[param_00];
  } else if(param_00 == "temperature") {
    var_01 = randomintrange(-1, 1) + level.var_8DF1[param_00];
  } else if(param_00 == "pressure") {
    var_01 = randomfloatrange(-0.5, 0.5) + level.var_8DF1[param_00];
  }

  var_02 = level.var_8DF1[param_00];
  var_03 = randomfloatrange(1, 3);
  func_8DFA(param_00, var_03, var_01);
  var_03 = randomfloatrange(1, 2);
  func_8DFA(param_00, var_03, var_02);
}

func_8DFB(param_00, param_01, param_02) {
  func_8DFA(param_00, param_01, param_02);
  func_8E00(param_00);
}

func_8DFC(param_00, param_01) {
  var_02 = int(param_01);
  return var_02;
}