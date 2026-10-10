/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\hud.gsc
***********************************************/

#namespace hud;

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
  setDvar(@ "hash_32cde99045864a11", 0);
  setDvar(@ "hash_787d2c09ca39aac4", 0);
  setDvar(@ "hash_9565929f2ba6b781", "off");
  setDvar(@ "hash_a1036b0b7af18aa8", "off");
  setDvar(@ "hash_f0b47c7069fd9933", "off");
  setDvar(@ "hash_fc22f9d5d3626cfa", "off");
  setDvar(@ "hash_98062fe56e38667d", 0);
  setDvar(@ "ui_securing", "");
  setDvar(@ "ui_securing_progress", 0);
  setDvar(@ "hash_9fb9448766c1f439", 1);
  setDvar(@ "hash_6a3a3c63c640148f", 1);
  setDvar(@ "minimap_sp", 0);
  setDvar(@ "hash_6b6a0dbe8c0bf7bf", 0);
  helmet_meters_init();
}

function helmet_meters_init() {
  if(isDefined(level.helmet_meters)) {
    return;
  }

  meters = [];
  meters["oxygen"] = 0;
  meters["temperature"] = 0;
  meters["pressure"] = 0;
  level.helmet_meters = meters;
}

function helmet_meters_on(environment, hidden) {
  if(environment == "suit") {
    oxygen = randomfloatrange(93.83, 93.87);
    temperature = randomintrange(18, 22);
    pressure = randomfloatrange(8.2, 8.4);
  } else {
    oxygen = randomfloatrange(20.93, 20.97);
    temperature = randomintrange(18, 22);
    pressure = randomfloatrange(14.5, 14.9);
  }

  if(isDefined(hidden) && hidden) {
    level.helmet_meters["oxygen"] = oxygen;
    level.helmet_meters["temperature"] = temperature;
    level.helmet_meters["pressure"] = pressure;
    return;
  }

  level.helmet_meters["oxygen"] = 0;
  level.helmet_meters["temperature"] = 0;
  level.helmet_meters["pressure"] = 0;
  duration = randomfloatrange(3, 4);
  thread helmet_meters_ramp_and_stabilize("oxygen", duration, oxygen);
  thread helmet_meters_ramp_and_stabilize("temperature", duration, temperature);
  thread helmet_meters_ramp_and_stabilize("pressure", duration, pressure);
}

function helmet_meters_off(hidden) {
  thread helmet_meters_ramp("oxygen", randomfloatrange(3, 4), 0);
  thread helmet_meters_ramp("temperature", randomfloatrange(3, 4), 0);
  thread helmet_meters_ramp("pressure", randomfloatrange(3, 4), 0);
}

function helmet_meters_normal_suit(duration, hidden) {
  oxygen = randomfloatrange(93.83, 93.87);
  temperature = randomintrange(18, 22);
  pressure = randomfloatrange(8.2, 8.4);
  level.helmet_meters["oxygen"] = oxygen;
  level.helmet_meters["temperature"] = temperature;
  level.helmet_meters["pressure"] = pressure;

  if(isDefined(hidden) && hidden) {
    return;
  }

  if(!isDefined(duration)) {
    setomnvar("ui_helmet_meter_oxygen", helmet_meters_rounding("oxygen", oxygen));
    setomnvar("ui_helmet_meter_temperature", helmet_meters_rounding("temperature", temperature));
    setomnvar("ui_helmet_meter_pressure", helmet_meters_rounding("pressure", pressure));
    return;
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", duration, oxygen);
  thread helmet_meters_ramp_and_stabilize("temperature", duration, temperature);
  thread helmet_meters_ramp_and_stabilize("pressure", duration, pressure);
}

function helmet_meters_normal_ship(duration, hidden) {
  oxygen = randomfloatrange(20.93, 20.97);
  temperature = randomintrange(18, 22);
  pressure = randomfloatrange(14.5, 14.9);
  level.helmet_meters["oxygen"] = oxygen;
  level.helmet_meters["temperature"] = temperature;
  level.helmet_meters["pressure"] = pressure;

  if(isDefined(hidden) && hidden) {
    return;
  }

  if(!isDefined(duration)) {
    setomnvar("ui_helmet_meter_oxygen", helmet_meters_rounding("oxygen", oxygen));
    setomnvar("ui_helmet_meter_temperature", helmet_meters_rounding("temperature", temperature));
    setomnvar("ui_helmet_meter_pressure", helmet_meters_rounding("pressure", pressure));
    return;
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", duration, oxygen);
  thread helmet_meters_ramp_and_stabilize("temperature", duration, temperature);
  thread helmet_meters_ramp_and_stabilize("pressure", duration, pressure);
}

function helmet_meters_set_oxygen(value, duration, hidden) {
  if(isDefined(hidden) && hidden) {
    level.helmet_meters["oxygen"] = value;
    return;
  }

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  helmet_meters_ramp("oxygen", duration, value);
  helmet_meters_stabilize("oxygen");
}

function helmet_meters_set_temperature(value, duration, hidden) {
  if(isDefined(hidden) && hidden) {
    level.helmet_meters["temperature"] = value;
    return;
  }

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  helmet_meters_ramp("temperature", duration, value);
  helmet_meters_stabilize("temperature");
}

function helmet_meters_set_pressure(value, duration, hidden) {
  if(isDefined(hidden) && hidden) {
    level.helmet_meters["pressure"] = value;
    return;
  }

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  helmet_meters_ramp("pressure", duration, value);
  helmet_meters_stabilize("pressure");
}

function helmet_meters_airlock_in(duration) {
  oxygen = randomfloatrange(20.93, 20.97);
  temperature = randomintrange(18, 22);
  pressure = randomfloatrange(14.5, 14.9);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", duration, oxygen);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("temperature", duration, temperature);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("pressure", duration, pressure);
}

function helmet_meters_airlock_out(duration) {
  oxygen = randomfloatrange(93.83, 93.87);
  temperature = randomintrange(18, 22);
  pressure = randomfloatrange(8.2, 8.4);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", duration, oxygen);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("temperature", duration, temperature);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("pressure", duration, pressure);
}

function helmet_meters_forced_decompress(environment, duration) {
  if(environment == "interior") {
    oxygen = randomfloatrange(20.93, 20.97);
    temperature = randomintrange(18, 22);
    pressure = randomfloatrange(14.5, 14.9);
  } else {
    oxygen = randomfloatrange(6, 8);
    temperature = randomintrange(-60, -50);
    pressure = randomfloatrange(4, 6);
  }

  if(!isDefined(duration)) {
    duration = randomfloatrange(2, 3);
  }

  thread helmet_meters_ramp_and_stabilize("oxygen", duration, oxygen);

  if(!isDefined(duration)) {
    duration = randomfloatrange(2, 3);
  }

  thread helmet_meters_ramp_and_stabilize("temperature", duration, temperature);

  if(!isDefined(duration)) {
    duration = randomfloatrange(2, 3);
  }

  thread helmet_meters_ramp_and_stabilize("pressure", duration, pressure);
}

function helmet_meters_ramp(type, duration, goal_value) {
  accel = 0;
  decel = 0;
  var_78cd7a63f38d99d1 = 0;
  base_increment = abs((goal_value - level.helmet_meters[type]) / duration * 0.05);
  var_e9d476a3809cb3f1 = "ui_helmet_meter_" + type;

  if(type == "oxygen") {
    accel = 1;
    decel = 1;
  } else if(type == "temperature") {
    accel = 2;
    decel = 3;
  } else if(type == "pressure") {
    accel = 1;
    decel = 1;
  }

  accel_increment = accel * 0.05;
  decel_increment = decel * 0.05;
  value_raise = 1;

  if(goal_value == level.helmet_meters[type]) {
    return;
  } else if(goal_value < level.helmet_meters[type]) {
    value_raise = 0;
  }

  i = 0;

  while(i < duration) {
    if(value_raise) {
      level.helmet_meters[type] += base_increment;
    } else {
      level.helmet_meters[type] -= base_increment;
    }

    var_f82eacb5a2248d90 = helmet_meters_rounding(type, level.helmet_meters[type]);
    setomnvar(var_e9d476a3809cb3f1, var_f82eacb5a2248d90);
    wait 0.05;
    i += 0.05;
  }

  var_f82eacb5a2248d90 = helmet_meters_rounding(type, level.helmet_meters[type]);
  setomnvar(var_e9d476a3809cb3f1, var_f82eacb5a2248d90);
}

function helmet_meters_stabilize(type) {
  goal_value = 0;

  if(type == "oxygen") {
    goal_value = randomfloatrange(-0.5, 0.5) + level.helmet_meters[type];
  } else if(type == "temperature") {
    goal_value = randomintrange(-1, 1) + level.helmet_meters[type];
  } else if(type == "pressure") {
    goal_value = randomfloatrange(-0.5, 0.5) + level.helmet_meters[type];
  }

  old_value = level.helmet_meters[type];
  duration = randomfloatrange(1, 3);
  helmet_meters_ramp(type, duration, goal_value);
  duration = randomfloatrange(1, 2);
  helmet_meters_ramp(type, duration, old_value);
}

function helmet_meters_ramp_and_stabilize(type, duration, goal_value) {
  helmet_meters_ramp(type, duration, goal_value);
  helmet_meters_stabilize(type);
}

function helmet_meters_rounding(type, value) {
  goal_value = int(value);
  return goal_value;
}