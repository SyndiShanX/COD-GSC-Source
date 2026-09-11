/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\hud.gsc
***********************************************/

function init() {
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
  level.fontheight = 12;
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
  helmet_meters_init();
}

function helmet_meters_init() {
  if(isDefined(level.helmet_meters)) {
    return;
  }

  var0 = [];
  GscBinSkip0(0x2e, "oxygen", 0);
}

function helmet_meters_on(var0, var1) {
  if(var0 == "suit") {
    var2 = randomfloatrange(93.83, 93.87);
    var3 = randomintrange(18, 22);
    var4 = randomfloatrange(8.2, 8.4);
  } else {
    var2 = randomfloatrange(20.93, 20.97);
    var3 = randomintrange(18, 22);
    var4 = randomfloatrange(14.5, 14.9);
  }

  if(isDefined(var4) && var4) {
    level.helmet_meters["oxygen"] = var2;
    level.helmet_meters["temperature"] = var3;
    level.helmet_meters["pressure"] = var4;
    return;
  }

  level.helmet_meters["oxygen"] = 0;
  level.helmet_meters["temperature"] = 0;
  level.helmet_meters["pressure"] = 0;
  var5 = randomfloatrange(3, 4);
  thread helmet_meters_ramp_and_stabilize("oxygen", var5, var2);
  thread helmet_meters_ramp_and_stabilize("temperature", var5, var3);
  thread helmet_meters_ramp_and_stabilize("pressure", var5, var4);
}

function helmet_meters_off(var0) {
  thread helmet_meters_ramp("oxygen", randomfloatrange(3, 4), 0);
  thread helmet_meters_ramp("temperature", randomfloatrange(3, 4), 0);
  thread helmet_meters_ramp("pressure", randomfloatrange(3, 4), 0);
}

function helmet_meters_normal_suit(var0, var1) {
  var2 = randomfloatrange(93.83, 93.87);
  var3 = randomintrange(18, 22);
  var4 = randomfloatrange(8.2, 8.4);
  level.helmet_meters["oxygen"] = var2;
  level.helmet_meters["temperature"] = var3;
  level.helmet_meters["pressure"] = var4;

  if(isDefined(var1) && var1) {
    return;
  }

  if(!isDefined(var0)) {
    setomnvar("ui_helmet_meter_oxygen", helmet_meters_rounding("oxygen", var2));
    setomnvar("ui_helmet_meter_temperature", helmet_meters_rounding("temperature", var3));
    setomnvar("ui_helmet_meter_pressure", helmet_meters_rounding("pressure", var4));
    return;
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", var0, var2);
  thread helmet_meters_ramp_and_stabilize("temperature", var0, var3);
  thread helmet_meters_ramp_and_stabilize("pressure", var0, var4);
}

function helmet_meters_normal_ship(var0, var1) {
  var2 = randomfloatrange(20.93, 20.97);
  var3 = randomintrange(18, 22);
  var4 = randomfloatrange(14.5, 14.9);
  level.helmet_meters["oxygen"] = var2;
  level.helmet_meters["temperature"] = var3;
  level.helmet_meters["pressure"] = var4;

  if(isDefined(var1) && var1) {
    return;
  }

  if(!isDefined(var0)) {
    setomnvar("ui_helmet_meter_oxygen", helmet_meters_rounding("oxygen", var2));
    setomnvar("ui_helmet_meter_temperature", helmet_meters_rounding("temperature", var3));
    setomnvar("ui_helmet_meter_pressure", helmet_meters_rounding("pressure", var4));
    return;
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", var0, var2);
  thread helmet_meters_ramp_and_stabilize("temperature", var0, var3);
  thread helmet_meters_ramp_and_stabilize("pressure", var0, var4);
}

function helmet_meters_set_oxygen(var0, var1, var2) {
  if(isDefined(var2) && var2) {
    level.helmet_meters["oxygen"] = var0;
    return;
  }

  if(!isDefined(var1)) {
    var1 = randomfloatrange(3, 4);
  }

  helmet_meters_ramp("oxygen", var1, var0);
  helmet_meters_stabilize("oxygen");
}

function helmet_meters_set_temperature(var0, var1, var2) {
  if(isDefined(var2) && var2) {
    level.helmet_meters["temperature"] = var0;
    return;
  }

  if(!isDefined(var1)) {
    var1 = randomfloatrange(3, 4);
  }

  helmet_meters_ramp("temperature", var1, var0);
  helmet_meters_stabilize("temperature");
}

function helmet_meters_set_pressure(var0, var1, var2) {
  if(isDefined(var2) && var2) {
    level.helmet_meters["pressure"] = var0;
    return;
  }

  if(!isDefined(var1)) {
    var1 = randomfloatrange(3, 4);
  }

  helmet_meters_ramp("pressure", var1, var0);
  helmet_meters_stabilize("pressure");
}

function helmet_meters_airlock_in(var0) {
  var1 = randomfloatrange(20.93, 20.97);
  var2 = randomintrange(18, 22);
  var3 = randomfloatrange(14.5, 14.9);

  if(!isDefined(var0)) {
    var0 = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", var0, var1);

  if(!isDefined(var0)) {
    var0 = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("temperature", var0, var2);

  if(!isDefined(var0)) {
    var0 = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("pressure", var0, var3);
}

function helmet_meters_airlock_out(var0) {
  var1 = randomfloatrange(93.83, 93.87);
  var2 = randomintrange(18, 22);
  var3 = randomfloatrange(8.2, 8.4);

  if(!isDefined(var0)) {
    var0 = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", var0, var1);

  if(!isDefined(var0)) {
    var0 = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("temperature", var0, var2);

  if(!isDefined(var0)) {
    var0 = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("pressure", var0, var3);
}

function helmet_meters_forced_decompress(var0, var1) {
  if(var0 == "interior") {
    var2 = randomfloatrange(20.93, 20.97);
    var3 = randomintrange(18, 22);
    var4 = randomfloatrange(14.5, 14.9);
  } else {
    var2 = randomfloatrange(6, 8);
    var3 = randomintrange(-60, -50);
    var4 = randomfloatrange(4, 6);
  }

  if(!isDefined(var4)) {
    var4 = randomfloatrange(2, 3);
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", var4, var2);

  if(!isDefined(var4)) {
    var4 = randomfloatrange(2, 3);
  }

  thread helmet_meters_ramp_and_stabilize("temperature", var4, var3);

  if(!isDefined(var4)) {
    var4 = randomfloatrange(2, 3);
  }

  thread helmet_meters_ramp_and_stabilize("pressure", var4, var4);
}

function helmet_meters_ramp(var0, var1, var2) {
  var3 = 0;
  var4 = 0;
  var5 = 0;
  var6 = abs((var2 - level.helmet_meters[var0]) / var1 * 0.05);
  var7 = "ui_helmet_meter_" + var0;

  if(var0 == "oxygen") {
    var3 = 1;
    var4 = 1;
  } else if(var0 == "temperature") {
    var3 = 2;
    var4 = 3;
  } else if(var0 == "pressure") {
    var3 = 1;
    var4 = 1;
  }

  var8 = var3 * 0.05;
  var9 = var4 * 0.05;
  var10 = 1;

  if(var2 == level.helmet_meters[var0]) {
    return;
  } else if(var2 < level.helmet_meters[var0]) {
    var10 = 0;
  }

  var11 = 0;

  while(var11 < var1) {
    if(var10) {
      level.helmet_meters[var0] += var6;
    } else {
      level.helmet_meters[var0] -= var6;
    }

    var12 = helmet_meters_rounding(var0, level.helmet_meters[var0]);
    setomnvar(var7, var12);
    wait 0.05;
    var11 += 0.05;
  }

  var12 = helmet_meters_rounding(var0, level.helmet_meters[var0]);
  setomnvar(var7, var12);
}

function helmet_meters_stabilize(var0) {
  var1 = 0;

  if(var0 == "oxygen") {
    var1 = randomfloatrange(-0.5, 0.5) + level.helmet_meters[var0];
  } else if(var0 == "temperature") {
    var1 = randomintrange(-1, 1) + level.helmet_meters[var0];
  } else if(var0 == "pressure") {
    var1 = randomfloatrange(-0.5, 0.5) + level.helmet_meters[var0];
  }

  var2 = level.helmet_meters[var0];
  var3 = randomfloatrange(1, 3);
  helmet_meters_ramp(var0, var3, var1);
  var3 = randomfloatrange(1, 2);
  helmet_meters_ramp(var0, var3, var2);
}

function helmet_meters_ramp_and_stabilize(var0, var1, var2) {
  helmet_meters_ramp(var0, var1, var2);
  helmet_meters_stabilize(var0);
}

function helmet_meters_rounding(var0, var1) {
  var2 = int(var1);
  return var2;
}