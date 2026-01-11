/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2878.gsc
***************************************/

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
  }
  else {
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
  setdvar("ui_securing_progress", 0.0);
  setdvar("hud_showObjectives", 1);
  setdvar("hud_showIntel", 1);
  setdvar("minimap_sp", 0);
  setdvar("minimap_full_sp", 0);
  _loadluifile("inGame.sp.KleenexPopup");
  func_8DF5();
}

func_8DF5() {
  if(isDefined(level.func_8DF1)) {
    return;
  }
  var_00 = [];
  var_0["oxygen"] = 0.0;
  var_0["temperature"] = 0;
  var_0["pressure"] = 0.0;
  level.func_8DF1 = var_00;
}

func_8DF9(var_00, var_01) {
  if(var_00 == "suit") {
    var_02 = randomfloatrange(93.83, 93.87);
    var_03 = randomintrange(18, 22);
    var_04 = randomfloatrange(8.2, 8.4);
  } else {
    var_02 = randomfloatrange(20.93, 20.97);
    var_03 = randomintrange(18, 22);
    var_04 = randomfloatrange(14.5, 14.9);
  }

  if(isDefined(var_01) && var_01) {
    level.func_8DF1["oxygen"] = var_02;
    level.func_8DF1["temperature"] = var_03;
    level.func_8DF1["pressure"] = var_04;
    return;
  }

  level.func_8DF1["oxygen"] = 0.0;
  level.func_8DF1["temperature"] = 0;
  level.func_8DF1["pressure"] = 0.0;
  var_05 = randomfloatrange(3, 4);
  thread func_8DFB("oxygen", var_05, var_02);
  thread func_8DFB("temperature", var_05, var_03);
  thread func_8DFB("pressure", var_05, var_04);
}

func_8DF8(var_00) {
  thread func_8DFA("oxygen", randomfloatrange(3, 4), 0.0);
  thread func_8DFA("temperature", randomfloatrange(3, 4), 0);
  thread func_8DFA("pressure", randomfloatrange(3, 4), 0.0);
}

func_8DF7(var_00, var_01) {
  var_02 = randomfloatrange(93.83, 93.87);
  var_03 = randomintrange(18, 22);
  var_04 = randomfloatrange(8.2, 8.4);
  level.func_8DF1["oxygen"] = var_02;
  level.func_8DF1["temperature"] = var_03;
  level.func_8DF1["pressure"] = var_04;

  if(isDefined(var_01) && var_01) {
    return;
  }
  if(!isDefined(var_00)) {
    setomnvar("ui_helmet_meter_oxygen", func_8DFC("oxygen", var_02));
    setomnvar("ui_helmet_meter_temperature", func_8DFC("temperature", var_03));
    setomnvar("ui_helmet_meter_pressure", func_8DFC("pressure", var_04));
    return;
  }

  thread func_8DFB("oxygen", var_00, var_02);
  thread func_8DFB("temperature", var_00, var_03);
  thread func_8DFB("pressure", var_00, var_04);
}

func_8DF6(var_00, var_01) {
  var_02 = randomfloatrange(20.93, 20.97);
  var_03 = randomintrange(18, 22);
  var_04 = randomfloatrange(14.5, 14.9);
  level.func_8DF1["oxygen"] = var_02;
  level.func_8DF1["temperature"] = var_03;
  level.func_8DF1["pressure"] = var_04;

  if(isDefined(var_01) && var_01) {
    return;
  }
  if(!isDefined(var_00)) {
    setomnvar("ui_helmet_meter_oxygen", func_8DFC("oxygen", var_02));
    setomnvar("ui_helmet_meter_temperature", func_8DFC("temperature", var_03));
    setomnvar("ui_helmet_meter_pressure", func_8DFC("pressure", var_04));
    return;
  }

  thread func_8DFB("oxygen", var_00, var_02);
  thread func_8DFB("temperature", var_00, var_03);
  thread func_8DFB("pressure", var_00, var_04);
}

func_8DFD(var_00, var_01, var_02) {
  if(isDefined(var_02) && var_02) {
    level.func_8DF1["oxygen"] = var_00;
    return;
  }

  if(!isDefined(var_01)) {
    var_01 = randomfloatrange(3, 4);
  }

  func_8DFA("oxygen", var_01, var_00);
  func_8E00("oxygen");
}

func_8DFF(var_00, var_01, var_02) {
  if(isDefined(var_02) && var_02) {
    level.func_8DF1["temperature"] = var_00;
    return;
  }

  if(!isDefined(var_01)) {
    var_01 = randomfloatrange(3, 4);
  }

  func_8DFA("temperature", var_01, var_00);
  func_8E00("temperature");
}

func_8DFE(var_00, var_01, var_02) {
  if(isDefined(var_02) && var_02) {
    level.func_8DF1["pressure"] = var_00;
    return;
  }

  if(!isDefined(var_01)) {
    var_01 = randomfloatrange(3, 4);
  }

  func_8DFA("pressure", var_01, var_00);
  func_8E00("pressure");
}

func_8DF2(var_00) {
  var_01 = randomfloatrange(20.93, 20.97);
  var_02 = randomintrange(18, 22);
  var_03 = randomfloatrange(14.5, 14.9);

  if(!isDefined(var_00)) {
    var_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("oxygen", var_00, var_01);

  if(!isDefined(var_00)) {
    var_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("temperature", var_00, var_02);

  if(!isDefined(var_00)) {
    var_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("pressure", var_00, var_03);
}

func_8DF3(var_00) {
  var_01 = randomfloatrange(93.83, 93.87);
  var_02 = randomintrange(18, 22);
  var_03 = randomfloatrange(8.2, 8.4);

  if(!isDefined(var_00)) {
    var_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("oxygen", var_00, var_01);

  if(!isDefined(var_00)) {
    var_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("temperature", var_00, var_02);

  if(!isDefined(var_00)) {
    var_00 = randomfloatrange(3, 4);
  }

  thread func_8DFB("pressure", var_00, var_03);
}

func_8DF4(var_00, var_01) {
  if(var_00 == "interior") {
    var_02 = randomfloatrange(20.93, 20.97);
    var_03 = randomintrange(18, 22);
    var_04 = randomfloatrange(14.5, 14.9);
  } else {
    var_02 = randomfloatrange(6, 8);
    var_03 = randomintrange(-60, -50);
    var_04 = randomfloatrange(4, 6);
  }

  if(!isDefined(var_01)) {
    var_01 = randomfloatrange(2, 3);
  }

  thread func_8DFB("oxygen", var_01, var_02);

  if(!isDefined(var_01)) {
    var_01 = randomfloatrange(2, 3);
  }

  thread func_8DFB("temperature", var_01, var_03);

  if(!isDefined(var_01)) {
    var_01 = randomfloatrange(2, 3);
  }

  thread func_8DFB("pressure", var_01, var_04);
}

func_8DFA(var_00, var_01, var_02) {
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  var_06 = abs((var_02 - level.func_8DF1[var_00]) / var_01 * 0.05);
  var_07 = "ui_helmet_meter_" + var_00;

  if(var_00 == "oxygen") {
    var_03 = 1;
    var_04 = 1;
  } else if(var_00 == "temperature") {
    var_03 = 2;
    var_04 = 3;
  } else if(var_00 == "pressure") {
    var_03 = 1;
    var_04 = 1;
  }

  var_08 = var_03 * 0.05;
  var_09 = var_04 * 0.05;
  var_10 = 1;

  if(var_02 == level.func_8DF1[var_00]) {
    return;
  }
  else if(var_02 < level.func_8DF1[var_00]) {
    var_10 = 0;
  }

  for(var_11 = 0; var_11 < var_01; var_11 = var_11 + 0.05) {
    if(var_10) {
      level.func_8DF1[var_00] = level.func_8DF1[var_00] + var_06;
    }
    else {
      level.func_8DF1[var_00] = level.func_8DF1[var_00] - var_06;
    }

    var_12 = func_8DFC(var_00, level.func_8DF1[var_00]);
    setomnvar(var_07, var_12);
    wait 0.05;
  }

  var_12 = func_8DFC(var_00, level.func_8DF1[var_00]);
  setomnvar(var_07, var_12);
}

func_8E00(var_00) {
  var_01 = 0;

  if(var_00 == "oxygen") {
    var_01 = randomfloatrange(-0.5, 0.5) + level.func_8DF1[var_00];
  }
  else if(var_00 == "temperature") {
    var_01 = randomintrange(-1, 1) + level.func_8DF1[var_00];
  }
  else if(var_00 == "pressure") {
    var_01 = randomfloatrange(-0.5, 0.5) + level.func_8DF1[var_00];
  }

  var_02 = level.func_8DF1[var_00];
  var_03 = randomfloatrange(1, 3);
  func_8DFA(var_00, var_03, var_01);
  var_03 = randomfloatrange(1, 2);
  func_8DFA(var_00, var_03, var_02);
}

func_8DFB(var_00, var_01, var_02) {
  func_8DFA(var_00, var_01, var_02);
  func_8E00(var_00);
}

func_8DFC(var_00, var_01) {
  var_02 = int(var_01);
  return var_02;
}