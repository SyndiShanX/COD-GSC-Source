/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\hud.gsc
**************************************/

#namespace hud;

function init() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "=\xff0b";
  level.uiparent.vertalign = "\x1d Q";
  level.uiparent.alignx = "=\xff0b";
  level.uiparent.aligny = "\x1d Q";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  setDvar(@ "hash_32cde99045864a11", 0);
  setDvar(@ "hash_787d2c09ca39aac4", 0);
  setDvar(@ "hash_9565929f2ba6b781", "\xf8\x88m");
  setDvar(@ "hash_a1036b0b7af18aa8", "\xf8\x88m");
  setDvar(@ "hash_f0b47c7069fd9933", "\xf8\x88m");
  setDvar(@ "hash_fc22f9d5d3626cfa", "\xf8\x88m");
  setDvar(@ "hidehudfast", 0);
  setDvar(@ "ui_securing", "");
  setDvar(@ "ui_securing_progress", 0);
  setDvar(@ "hash_9fb9448766c1f439", 1);
  setDvar(@ "hash_6a3a3c63c640148f", 1);
  setDvar(@ "minimap_sp", 0);
  setDvar(@ "hash_6b6a0dbe8c0bf7bf", 0);

  if(getprojectname() == "_\xde_") {
    setomnvar("D\xf2\xc0Z\vY\x13\x04\xe5\x10\x1d\as\x98\xb1", 0);
  }

  helmet_meters_init();
}

function helmet_meters_init() {
  if(isDefined(level.helmet_meters)) {
    return;
  }

  meters = [];
  meters["\xcf\xb7F\xae\x03\xe2"] = 0;
  meters["q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9"] = 0;
  meters["\x9c|\xe7\x8c\f\xb4;\x87"] = 0;
  level.helmet_meters = meters;
}

function helmet_meters_on(environment, hidden) {
  if(environment == "\xbb\x9a\x06~") {
    oxygen = randomfloatrange(93.83, 93.87);
    temperature = randomintrange(18, 22);
    pressure = randomfloatrange(8.2, 8.4);
  } else {
    oxygen = randomfloatrange(20.93, 20.97);
    temperature = randomintrange(18, 22);
    pressure = randomfloatrange(14.5, 14.9);
  }

  if(isDefined(hidden) && hidden) {
    level.helmet_meters["\xcf\xb7F\xae\x03\xe2"] = oxygen;
    level.helmet_meters["q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9"] = temperature;
    level.helmet_meters["\x9c|\xe7\x8c\f\xb4;\x87"] = pressure;
    return;
  }

  level.helmet_meters["\xcf\xb7F\xae\x03\xe2"] = 0;
  level.helmet_meters["q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9"] = 0;
  level.helmet_meters["\x9c|\xe7\x8c\f\xb4;\x87"] = 0;
  duration = randomfloatrange(3, 4);
  thread helmet_meters_ramp_and_stabilize("\xcf\xb7F\xae\x03\xe2", duration, oxygen);
  thread helmet_meters_ramp_and_stabilize("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", duration, temperature);
  thread helmet_meters_ramp_and_stabilize("\x9c|\xe7\x8c\f\xb4;\x87", duration, pressure);
}

function helmet_meters_off(hidden) {
  thread helmet_meters_ramp("\xcf\xb7F\xae\x03\xe2", randomfloatrange(3, 4), 0);
  thread helmet_meters_ramp("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", randomfloatrange(3, 4), 0);
  thread helmet_meters_ramp("\x9c|\xe7\x8c\f\xb4;\x87", randomfloatrange(3, 4), 0);
}

function helmet_meters_normal_suit(duration, hidden) {
  oxygen = randomfloatrange(93.83, 93.87);
  temperature = randomintrange(18, 22);
  pressure = randomfloatrange(8.2, 8.4);
  level.helmet_meters["\xcf\xb7F\xae\x03\xe2"] = oxygen;
  level.helmet_meters["q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9"] = temperature;
  level.helmet_meters["\x9c|\xe7\x8c\f\xb4;\x87"] = pressure;

  if(isDefined(hidden) && hidden) {
    return;
  }

  if(!isDefined(duration)) {
    setomnvar("M\x1a\x1cZ\xd5#\xb4\xd8\xde&\x03\xdcp\xe3\x81\x03\a\xca\xb43\xd2/", helmet_meters_rounding("\xcf\xb7F\xae\x03\xe2", oxygen));
    setomnvar("\xeb\xdc\xff\n\xb9GZ\xc0\xf9\x10\xad\xc7\x06\xceiI0Z\x9d\x1e\x80\xc0\x15\x8d\x05@\x9a", helmet_meters_rounding("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", temperature));
    setomnvar("K\xcc\xb0PB\x93\xcdP\xd0\x17\xd0\xfc4\xa9e\v\xb9\x89\xea\x9f\xd5q\x9a\xa2", helmet_meters_rounding("\x9c|\xe7\x8c\f\xb4;\x87", pressure));
    return;
  }

  thread helmet_meters_ramp_and_stabilize("\xcf\xb7F\xae\x03\xe2", duration, oxygen);
  thread helmet_meters_ramp_and_stabilize("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", duration, temperature);
  thread helmet_meters_ramp_and_stabilize("\x9c|\xe7\x8c\f\xb4;\x87", duration, pressure);
}

function helmet_meters_normal_ship(duration, hidden) {
  oxygen = randomfloatrange(20.93, 20.97);
  temperature = randomintrange(18, 22);
  pressure = randomfloatrange(14.5, 14.9);
  level.helmet_meters["\xcf\xb7F\xae\x03\xe2"] = oxygen;
  level.helmet_meters["q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9"] = temperature;
  level.helmet_meters["\x9c|\xe7\x8c\f\xb4;\x87"] = pressure;

  if(isDefined(hidden) && hidden) {
    return;
  }

  if(!isDefined(duration)) {
    setomnvar("M\x1a\x1cZ\xd5#\xb4\xd8\xde&\x03\xdcp\xe3\x81\x03\a\xca\xb43\xd2/", helmet_meters_rounding("\xcf\xb7F\xae\x03\xe2", oxygen));
    setomnvar("\xeb\xdc\xff\n\xb9GZ\xc0\xf9\x10\xad\xc7\x06\xceiI0Z\x9d\x1e\x80\xc0\x15\x8d\x05@\x9a", helmet_meters_rounding("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", temperature));
    setomnvar("K\xcc\xb0PB\x93\xcdP\xd0\x17\xd0\xfc4\xa9e\v\xb9\x89\xea\x9f\xd5q\x9a\xa2", helmet_meters_rounding("\x9c|\xe7\x8c\f\xb4;\x87", pressure));
    return;
  }

  thread helmet_meters_ramp_and_stabilize("\xcf\xb7F\xae\x03\xe2", duration, oxygen);
  thread helmet_meters_ramp_and_stabilize("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", duration, temperature);
  thread helmet_meters_ramp_and_stabilize("\x9c|\xe7\x8c\f\xb4;\x87", duration, pressure);
}

function helmet_meters_set_oxygen(value, duration, hidden) {
  if(isDefined(hidden) && hidden) {
    level.helmet_meters["\xcf\xb7F\xae\x03\xe2"] = value;
    return;
  }

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  helmet_meters_ramp("\xcf\xb7F\xae\x03\xe2", duration, value);
  helmet_meters_stabilize("\xcf\xb7F\xae\x03\xe2");
}

function helmet_meters_set_temperature(value, duration, hidden) {
  if(isDefined(hidden) && hidden) {
    level.helmet_meters["q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9"] = value;
    return;
  }

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  helmet_meters_ramp("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", duration, value);
  helmet_meters_stabilize("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9");
}

function helmet_meters_set_pressure(value, duration, hidden) {
  if(isDefined(hidden) && hidden) {
    level.helmet_meters["\x9c|\xe7\x8c\f\xb4;\x87"] = value;
    return;
  }

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  helmet_meters_ramp("\x9c|\xe7\x8c\f\xb4;\x87", duration, value);
  helmet_meters_stabilize("\x9c|\xe7\x8c\f\xb4;\x87");
}

function helmet_meters_airlock_in(duration) {
  oxygen = randomfloatrange(20.93, 20.97);
  temperature = randomintrange(18, 22);
  pressure = randomfloatrange(14.5, 14.9);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("\xcf\xb7F\xae\x03\xe2", duration, oxygen);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", duration, temperature);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("\x9c|\xe7\x8c\f\xb4;\x87", duration, pressure);
}

function helmet_meters_airlock_out(duration) {
  oxygen = randomfloatrange(93.83, 93.87);
  temperature = randomintrange(18, 22);
  pressure = randomfloatrange(8.2, 8.4);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("\xcf\xb7F\xae\x03\xe2", duration, oxygen);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", duration, temperature);

  if(!isDefined(duration)) {
    duration = randomfloatrange(3, 4);
  }

  thread helmet_meters_ramp_and_stabilize("\x9c|\xe7\x8c\f\xb4;\x87", duration, pressure);
}

function helmet_meters_forced_decompress(environment, duration) {
  if(environment == "\xb6\xdc7T\x8c\xbfA\x19") {
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

  thread helmet_meters_ramp_and_stabilize("\xcf\xb7F\xae\x03\xe2", duration, oxygen);

  if(!isDefined(duration)) {
    duration = randomfloatrange(2, 3);
  }

  thread helmet_meters_ramp_and_stabilize("q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9", duration, temperature);

  if(!isDefined(duration)) {
    duration = randomfloatrange(2, 3);
  }

  thread helmet_meters_ramp_and_stabilize("\x9c|\xe7\x8c\f\xb4;\x87", duration, pressure);
}

function helmet_meters_ramp(type, duration, goal_value) {
  accel = 0;
  decel = 0;
  var_f3de030b2d862ba0 = 0;
  base_increment = abs((goal_value - level.helmet_meters[type]) / duration * 0.05);
  omnvarname = "\xfb\nX{\xb8\xf4_\x12\x96\xdda\xbb\v\xe3\xb5q" + type;

  if(type == "\xcf\xb7F\xae\x03\xe2") {
    accel = 1;
    decel = 1;
  } else if(type == "q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9") {
    accel = 2;
    decel = 3;
  } else if(type == "\x9c|\xe7\x8c\f\xb4;\x87") {
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

    rounded_value = helmet_meters_rounding(type, level.helmet_meters[type]);
    setomnvar(omnvarname, rounded_value);
    wait 0.05;
    i += 0.05;
  }

  rounded_value = helmet_meters_rounding(type, level.helmet_meters[type]);
  setomnvar(omnvarname, rounded_value);
}

function helmet_meters_stabilize(type) {
  goal_value = 0;

  if(type == "\xcf\xb7F\xae\x03\xe2") {
    goal_value = randomfloatrange(-0.5, 0.5) + level.helmet_meters[type];
  } else if(type == "q\x86\xae\x86\xcf\x96\xcc\xbf\xf6W\xf9") {
    goal_value = randomintrange(-1, 1) + level.helmet_meters[type];
  } else if(type == "\x9c|\xe7\x8c\f\xb4;\x87") {
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