/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hud.gsc
***********************************************/

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
  level.fontheight = 12;
  setDvar("ui_remotemissile_playernum", 0);
  setDvar("ui_pmc_won", 0);
  setDvar("ui_actionSlot_1_forceActive", "off");
  setDvar("ui_actionSlot_2_forceActive", "off");
  setDvar("ui_actionSlot_3_forceActive", "off");
  setDvar("ui_actionSlot_4_forceActive", "off");
  setDvar("hideHudFast", 0);
  setDvar("ui_securing", "");
  setDvar("ui_securing_progress", 0.0);
  setDvar("hud_showObjectives", 1);
  setDvar("hud_showIntel", 1);
  setDvar("minimap_sp", 0);
  setDvar("minimap_full_sp", 0);
  helmet_meters_init();
}

helmet_meters_init() {
  if(isDefined(level.helmet_meters)) {
    return;
  }
  var_0 = [];
  var_0["oxygen"] = 0.0;
  var_0["temperature"] = 0;
  var_0["pressure"] = 0.0;
  level.helmet_meters = var_0;
}

helmet_meters_on(var_0, var_1) {
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
    level.helmet_meters["oxygen"] = var_2;
    level.helmet_meters["temperature"] = var_3;
    level.helmet_meters["pressure"] = var_4;
    return;
  }

  level.helmet_meters["oxygen"] = 0.0;
  level.helmet_meters["temperature"] = 0;
  level.helmet_meters["pressure"] = 0.0;
  var_5 = randomfloatrange(3, 4);
  thread helmet_meters_ramp_and_stabilize("oxygen", var_5, var_2);
  thread helmet_meters_ramp_and_stabilize("temperature", var_5, var_3);
  thread helmet_meters_ramp_and_stabilize("pressure", var_5, var_4);
}

helmet_meters_off(var_0) {
  thread helmet_meters_ramp("oxygen", randomfloatrange(3, 4), 0.0);
  thread helmet_meters_ramp("temperature", randomfloatrange(3, 4), 0);
  thread helmet_meters_ramp("pressure", randomfloatrange(3, 4), 0.0);
}

helmet_meters_normal_suit(var_0, var_1) {
  var_2 = randomfloatrange(93.83, 93.87);
  var_3 = randomintrange(18, 22);
  var_4 = randomfloatrange(8.2, 8.4);
  level.helmet_meters["oxygen"] = var_2;
  level.helmet_meters["temperature"] = var_3;
  level.helmet_meters["pressure"] = var_4;

  if(isDefined(var_1) && var_1) {
    return;
  }
  if(!isDefined(var_0)) {
    setomnvar("ui_helmet_meter_oxygen", helmet_meters_rounding("oxygen", var_2));
    setomnvar("ui_helmet_meter_temperature", helmet_meters_rounding("temperature", var_3));
    setomnvar("ui_helmet_meter_pressure", helmet_meters_rounding("pressure", var_4));
    return;
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", var_0, var_2);
  thread helmet_meters_ramp_and_stabilize("temperature", var_0, var_3);
  thread helmet_meters_ramp_and_stabilize("pressure", var_0, var_4);
}

helmet_meters_normal_ship(var_0, var_1) {
  var_2 = randomfloatrange(20.93, 20.97);
  var_3 = randomintrange(18, 22);
  var_4 = randomfloatrange(14.5, 14.9);
  level.helmet_meters["oxygen"] = var_2;
  level.helmet_meters["temperature"] = var_3;
  level.helmet_meters["pressure"] = var_4;

  if(isDefined(var_1) && var_1) {
    return;
  }
  if(!isDefined(var_0)) {
    setomnvar("ui_helmet_meter_oxygen", helmet_meters_rounding("oxygen", var_2));
    setomnvar("ui_helmet_meter_temperature", helmet_meters_rounding("temperature", var_3));
    setomnvar("ui_helmet_meter_pressure", helmet_meters_rounding("pressure", var_4));
    return;
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", var_0, var_2);
  thread helmet_meters_ramp_and_stabilize("temperature", var_0, var_3);
  thread helmet_meters_ramp_and_stabilize("pressure", var_0, var_4);
}

helmet_meters_set_oxygen(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    level.helmet_meters["oxygen"] = var_0;
    return;
  }

  if(!isDefined(var_1))
    var_1 = randomfloatrange(3, 4);

  helmet_meters_ramp("oxygen", var_1, var_0);
  helmet_meters_stabilize("oxygen");
}

helmet_meters_set_temperature(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    level.helmet_meters["temperature"] = var_0;
    return;
  }

  if(!isDefined(var_1))
    var_1 = randomfloatrange(3, 4);

  helmet_meters_ramp("temperature", var_1, var_0);
  helmet_meters_stabilize("temperature");
}

helmet_meters_set_pressure(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    level.helmet_meters["pressure"] = var_0;
    return;
  }

  if(!isDefined(var_1))
    var_1 = randomfloatrange(3, 4);

  helmet_meters_ramp("pressure", var_1, var_0);
  helmet_meters_stabilize("pressure");
}

helmet_meters_airlock_in(var_0) {
  var_1 = randomfloatrange(20.93, 20.97);
  var_2 = randomintrange(18, 22);
  var_3 = randomfloatrange(14.5, 14.9);

  if(!isDefined(var_0))
    var_0 = randomfloatrange(3, 4);

  thread helmet_meters_ramp_and_stabilize("oxygen", var_0, var_1);

  if(!isDefined(var_0))
    var_0 = randomfloatrange(3, 4);

  thread helmet_meters_ramp_and_stabilize("temperature", var_0, var_2);

  if(!isDefined(var_0))
    var_0 = randomfloatrange(3, 4);

  thread helmet_meters_ramp_and_stabilize("pressure", var_0, var_3);
}

helmet_meters_airlock_out(var_0) {
  var_1 = randomfloatrange(93.83, 93.87);
  var_2 = randomintrange(18, 22);
  var_3 = randomfloatrange(8.2, 8.4);

  if(!isDefined(var_0))
    var_0 = randomfloatrange(3, 4);

  thread helmet_meters_ramp_and_stabilize("oxygen", var_0, var_1);

  if(!isDefined(var_0))
    var_0 = randomfloatrange(3, 4);

  thread helmet_meters_ramp_and_stabilize("temperature", var_0, var_2);

  if(!isDefined(var_0))
    var_0 = randomfloatrange(3, 4);

  thread helmet_meters_ramp_and_stabilize("pressure", var_0, var_3);
}

helmet_meters_forced_decompress(var_0, var_1) {
  if(var_0 == "interior") {
    var_2 = randomfloatrange(20.93, 20.97);
    var_3 = randomintrange(18, 22);
    var_4 = randomfloatrange(14.5, 14.9);
  } else {
    var_2 = randomfloatrange(6, 8);
    var_3 = randomintrange(-60, -50);
    var_4 = randomfloatrange(4, 6);
  }

  if(!isDefined(var_1))
    var_1 = randomfloatrange(2, 3);

  thread helmet_meters_ramp_and_stabilize("oxygen", var_1, var_2);

  if(!isDefined(var_1))
    var_1 = randomfloatrange(2, 3);

  thread helmet_meters_ramp_and_stabilize("temperature", var_1, var_3);

  if(!isDefined(var_1))
    var_1 = randomfloatrange(2, 3);

  thread helmet_meters_ramp_and_stabilize("pressure", var_1, var_4);
}

helmet_meters_ramp(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = abs((var_2 - level.helmet_meters[var_0]) / var_1 * 0.05);
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

  if(var_2 == level.helmet_meters[var_0])
    return;
  else if(var_2 < level.helmet_meters[var_0])
    var_10 = 0;

  for(var_11 = 0; var_11 < var_1; var_11 = var_11 + 0.05) {
    if(var_10)
      level.helmet_meters[var_0] = level.helmet_meters[var_0] + var_6;
    else
      level.helmet_meters[var_0] = level.helmet_meters[var_0] - var_6;

    var_12 = helmet_meters_rounding(var_0, level.helmet_meters[var_0]);
    setomnvar(var_7, var_12);
    wait 0.05;
  }

  var_12 = helmet_meters_rounding(var_0, level.helmet_meters[var_0]);
  setomnvar(var_7, var_12);
}

helmet_meters_stabilize(var_0) {
  var_1 = 0;

  if(var_0 == "oxygen")
    var_1 = randomfloatrange(-0.5, 0.5) + level.helmet_meters[var_0];
  else if(var_0 == "temperature")
    var_1 = randomintrange(-1, 1) + level.helmet_meters[var_0];
  else if(var_0 == "pressure")
    var_1 = randomfloatrange(-0.5, 0.5) + level.helmet_meters[var_0];

  var_2 = level.helmet_meters[var_0];
  var_3 = randomfloatrange(1, 3);
  helmet_meters_ramp(var_0, var_3, var_1);
  var_3 = randomfloatrange(1, 2);
  helmet_meters_ramp(var_0, var_3, var_2);
}

helmet_meters_ramp_and_stabilize(var_0, var_1, var_2) {
  helmet_meters_ramp(var_0, var_1, var_2);
  helmet_meters_stabilize(var_0);
}

helmet_meters_rounding(var_0, var_1) {
  var_2 = int(var_1);
  return var_2;
}