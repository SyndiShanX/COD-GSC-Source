/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\hud.gsc
*********************************************/

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

  setDvar("ui_remotemissile_playernum", 0);
  setDvar("ui_pmc_won", 0);
  setDvar("ui_actionSlot_1_forceActive", "off");
  setDvar("ui_actionSlot_2_forceActive", "off");
  setDvar("ui_actionSlot_3_forceActive", "off");
  setDvar("ui_actionSlot_4_forceActive", "off");
  setDvar("hideHudFast", 0);
  setDvar("ui_securing", "");
  setDvar("ui_securing_progress", 0);
  setDvar("hud_showObjectives", 1);
  setDvar("hud_showIntel", 1);
  setDvar("minimap_sp", 0);
  setDvar("minimap_full_sp", 0);
  loadluifile("inGame.sp.KleenexPopup");
  func_8DF5();
}

func_8DF5() {
  if(isDefined(level.var_8DF1)) {
    return;
  }

  var_0 = [];
  var_0["oxygen"] = 0;
  var_0["temperature"] = 0;
  var_0["pressure"] = 0;
  level.var_8DF1 = var_0;
}

func_8DF9(var_0, var_1) {
  if(var_0 == "suit") {
    var_2 = randomfloatrange(93.83, 93.87);
    var_3 = randomintrange(18, 22);
    var_4 = randomfloatrange(8.2, 8.4);
  } else {
    var_2 = randomfloatrange(20.93, 20.97);
    var_3 = randomintrange(18, 22);
    var_4 = randomfloatrange(14.5, 14.9);
  }

  if(isDefined(var_1) && var_1) {
    level.var_8DF1["oxygen"] = var_2;
    level.var_8DF1["temperature"] = var_3;
    level.var_8DF1["pressure"] = var_4;
    return;
  }

  level.var_8DF1["oxygen"] = 0;
  level.var_8DF1["temperature"] = 0;
  level.var_8DF1["pressure"] = 0;
  var_5 = randomfloatrange(3, 4);
  thread func_8DFB("oxygen", var_5, var_2);
  thread func_8DFB("temperature", var_5, var_3);
  thread func_8DFB("pressure", var_5, var_4);
}

func_8DF8(var_0) {
  thread func_8DFA("oxygen", randomfloatrange(3, 4), 0);
  thread func_8DFA("temperature", randomfloatrange(3, 4), 0);
  thread func_8DFA("pressure", randomfloatrange(3, 4), 0);
}

func_8DF7(var_0, var_1) {
  var_2 = randomfloatrange(93.83, 93.87);
  var_3 = randomintrange(18, 22);
  var_4 = randomfloatrange(8.2, 8.4);
  level.var_8DF1["oxygen"] = var_2;
  level.var_8DF1["temperature"] = var_3;
  level.var_8DF1["pressure"] = var_4;
  if(isDefined(var_1) && var_1) {
    return;
  }

  if(!isDefined(var_0)) {
    setomnvar("ui_helmet_meter_oxygen", func_8DFC("oxygen", var_2));
    setomnvar("ui_helmet_meter_temperature", func_8DFC("temperature", var_3));
    setomnvar("ui_helmet_meter_pressure", func_8DFC("pressure", var_4));
    return;
  }

  thread func_8DFB("oxygen", var_0, var_2);
  thread func_8DFB("temperature", var_0, var_3);
  thread func_8DFB("pressure", var_0, var_4);
}

func_8DF6(var_0, var_1) {
  var_2 = randomfloatrange(20.93, 20.97);
  var_3 = randomintrange(18, 22);
  var_4 = randomfloatrange(14.5, 14.9);
  level.var_8DF1["oxygen"] = var_2;
  level.var_8DF1["temperature"] = var_3;
  level.var_8DF1["pressure"] = var_4;
  if(isDefined(var_1) && var_1) {
    return;
  }

  if(!isDefined(var_0)) {
    setomnvar("ui_helmet_meter_oxygen", func_8DFC("oxygen", var_2));
    setomnvar("ui_helmet_meter_temperature", func_8DFC("temperature", var_3));
    setomnvar("ui_helmet_meter_pressure", func_8DFC("pressure", var_4));
    return;
  }

  thread func_8DFB("oxygen", var_0, var_2);
  thread func_8DFB("temperature", var_0, var_3);
  thread func_8DFB("pressure", var_0, var_4);
}

func_8DFD(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    level.var_8DF1["oxygen"] = var_0;
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = randomfloatrange(3, 4);
  }

  func_8DFA("oxygen", var_1, var_0);
  func_8E00("oxygen");
}

func_8DFF(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    level.var_8DF1["temperature"] = var_0;
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = randomfloatrange(3, 4);
  }

  func_8DFA("temperature", var_1, var_0);
  func_8E00("temperature");
}

func_8DFE(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    level.var_8DF1["pressure"] = var_0;
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = randomfloatrange(3, 4);
  }

  func_8DFA("pressure", var_1, var_0);
  func_8E00("pressure");
}

func_8DF2(var_0) {
  var_1 = randomfloatrange(20.93, 20.97);
  var_2 = randomintrange(18, 22);
  var_3 = randomfloatrange(14.5, 14.9);
  if(!isDefined(var_0)) {
    var_0 = randomfloatrange(3, 4);
  }

  thread func_8DFB("oxygen", var_0, var_1);
  if(!isDefined(var_0)) {
    var_0 = randomfloatrange(3, 4);
  }

  thread func_8DFB("temperature", var_0, var_2);
  if(!isDefined(var_0)) {
    var_0 = randomfloatrange(3, 4);
  }

  thread func_8DFB("pressure", var_0, var_3);
}

func_8DF3(var_0) {
  var_1 = randomfloatrange(93.83, 93.87);
  var_2 = randomintrange(18, 22);
  var_3 = randomfloatrange(8.2, 8.4);
  if(!isDefined(var_0)) {
    var_0 = randomfloatrange(3, 4);
  }

  thread func_8DFB("oxygen", var_0, var_1);
  if(!isDefined(var_0)) {
    var_0 = randomfloatrange(3, 4);
  }

  thread func_8DFB("temperature", var_0, var_2);
  if(!isDefined(var_0)) {
    var_0 = randomfloatrange(3, 4);
  }

  thread func_8DFB("pressure", var_0, var_3);
}

func_8DF4(var_0, var_1) {
  if(var_0 == "interior") {
    var_2 = randomfloatrange(20.93, 20.97);
    var_3 = randomintrange(18, 22);
    var_4 = randomfloatrange(14.5, 14.9);
  } else {
    var_2 = randomfloatrange(6, 8);
    var_3 = randomintrange(-60, -50);
    var_4 = randomfloatrange(4, 6);
  }

  if(!isDefined(var_1)) {
    var_1 = randomfloatrange(2, 3);
  }

  thread func_8DFB("oxygen", var_1, var_2);
  if(!isDefined(var_1)) {
    var_1 = randomfloatrange(2, 3);
  }

  thread func_8DFB("temperature", var_1, var_3);
  if(!isDefined(var_1)) {
    var_1 = randomfloatrange(2, 3);
  }

  thread func_8DFB("pressure", var_1, var_4);
}

func_8DFA(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = abs(var_2 - level.var_8DF1[var_0] / var_1 * 0.05);
  var_7 = "ui_helmet_meter_" + var_0;
  if(var_0 == "oxygen") {
    var_3 = 1;
    var_4 = 1;
  } else if(var_0 == "temperature") {
    var_3 = 2;
    var_4 = 3;
  } else if(var_0 == "pressure") {
    var_3 = 1;
    var_4 = 1;
  }

  var_8 = var_3 * 0.05;
  var_9 = var_4 * 0.05;
  var_10 = 1;
  if(var_2 == level.var_8DF1[var_0]) {
    return;
  } else if(var_2 < level.var_8DF1[var_0]) {
    var_10 = 0;
  }

  var_11 = 0;
  while(var_11 < var_1) {
    if(var_10) {
      level.var_8DF1[var_0] = level.var_8DF1[var_0] + var_6;
    } else {
      level.var_8DF1[var_0] = level.var_8DF1[var_0] - var_6;
    }

    var_12 = func_8DFC(var_0, level.var_8DF1[var_0]);
    setomnvar(var_7, var_12);
    wait(0.05);
    var_11 = var_11 + 0.05;
  }

  var_12 = func_8DFC(var_0, level.var_8DF1[var_0]);
  setomnvar(var_7, var_12);
}

func_8E00(var_0) {
  var_1 = 0;
  if(var_0 == "oxygen") {
    var_1 = randomfloatrange(-0.5, 0.5) + level.var_8DF1[var_0];
  } else if(var_0 == "temperature") {
    var_1 = randomintrange(-1, 1) + level.var_8DF1[var_0];
  } else if(var_0 == "pressure") {
    var_1 = randomfloatrange(-0.5, 0.5) + level.var_8DF1[var_0];
  }

  var_2 = level.var_8DF1[var_0];
  var_3 = randomfloatrange(1, 3);
  func_8DFA(var_0, var_3, var_1);
  var_3 = randomfloatrange(1, 2);
  func_8DFA(var_0, var_3, var_2);
}

func_8DFB(var_0, var_1, var_2) {
  func_8DFA(var_0, var_1, var_2);
  func_8E00(var_0);
}

func_8DFC(var_0, var_1) {
  var_2 = int(var_1);
  return var_2;
}