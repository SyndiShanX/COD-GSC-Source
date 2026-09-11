/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\rockable_vehicles.gsc
************************************************/

function init() {
  setdvarifuninitialized("scr_rockable_vehicle_debug", 0);
  level scripts\engine\utility::delaythread(0.05, &rockable_cars_init);
}

function rockable_cars_init() {
  level.rockablecars = spawnStruct();
  level.rockablecars.cars = getscriptablearray("scriptable", "code_classname");

  if(!isDefined(level.rockablecars.cars) || level.rockablecars.cars.size <= 0) {
    return;
  }

  var_0 = 0;

  foreach(var_2 in level.rockablecars.cars) {
    if(var_0 > 19) {
      var_0 = 0;
      waitframe();
    }

    var_0 += 1;

    if(scripts\common\utility::issp()) {
      if(!isDefined(var_2.model) || !valid_rockable_vehicle(var_2)) {
        level.rockablecars.cars = scripts\engine\utility::array_remove(level.rockablecars.cars, var_2);
        continue;
      }
    }

    if(!isDefined(var_2 getscriptablepartstate("Anim_Explosion", 1)) && !isDefined(var_2 getscriptablepartstate("Anim_PlayerStandRock", 1))) {
      level.rockablecars.cars = scripts\engine\utility::array_remove(level.rockablecars.cars, var_2);
      continue;
    }

    var_2.forward = anglesToForward(var_2.angles);
    var_2.right = anglestoright(var_2.angles);

    if(!scripts\common\utility::issp()) {
      var_2.up = anglestoup(var_2.angles);
      var_2.frontpoint = var_2 getpointinbounds(1, 0, 0);
      var_2.backpoint = var_2 getpointinbounds(-1, 0, 0);
      var_2.leftpoint = var_2 getpointinbounds(0, 1, 0);
      var_2.rightpoint = var_2 getpointinbounds(0, -1, 0);
      var_2.toppoint = var_2 getpointinbounds(0, 0, 0.25);
      var_2.halflength = vectordot(var_2.forward, var_2.frontpoint - var_2.backpoint) / 2;
      var_2.halfwidth = vectordot(var_2.right, var_2.rightpoint - var_2.leftpoint) / 2;
      var_2.players = [];
      var_2.touchtimes = [];
      var_2.rocktimes = [];
      var_2.rockstrings = [];
    }

    thread rockable_car_debug();
    thread rockable_car_watch_damage();
    thread rockable_car_watch_death();
  }

  thread alarm_cars_init();
}

function valid_rockable_vehicle() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "not_rockable") {
    return 0;
  }

  if(issubstr(self.model, "veh8_")) {
    return 1;
  }

  return 0;
}

function rockable_car_watch_damage() {
  self endon("death");
  self endon("rocked");
  self setCanDamage(1);
  self.rockable_last_point = 0;
  self.rockable_last_meansofdeath = "";

  for(;;) {
    self.health = 99999;
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    self.rockable_last_point = var_3;
    self.rockable_last_meansofdeath = var_4;
    print3d_debug(self.origin + (0, 0, 0), "Damage by: " + var_4 + " " + var_0, (1, 1, 1), 1, 0.25, 100);
  }
}

function rockable_car_watch_death() {
  self endon("death");
  self waittillmatch("scriptableNotification", "anim_explosion");
  self notify("rocked");

  if(isexplosivedamagemod(self.rockable_last_meansofdeath)) {
    var_0 = self.rockable_last_point - self.origin;
    var_1 = scripts\engine\utility::ter_op(vectordot(self.forward, var_0) > 0, "front", "back");
    var_2 = scripts\engine\utility::ter_op(vectordot(self.right, var_0) > 0, "right", "left");
    self setscriptablepartstate("Anim_Explosion", var_1 + "_" + var_2, 0);
    print3d_debug(self.origin + (0, 0, -5), "Death by: " + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 12), "Animation: " + var_1 + "_" + var_2, (1, 1, 1), 1, 0.25, 1000);
  } else {
    var_3 = ["front_left", "front_right", "back_left", "back_right"];
    var_4 = var_3[randomint(var_3.size - 1)];
    self setscriptablepartstate("Anim_Explosion", var_4, 0);
    print3d_debug(self.origin + (0, 0, -5), "Death by: " + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 5), "scripted explosion", (1, 0, 0), 1, 0.5, 500);
    print3d_debug(self.origin + (0, 0, 10), "Animation: " + var_4, (1, 1, 1), 1, 0.25, 1000);
  }

  self waittillmatch("scriptableNotification", "anim_explosion_complete");
  thread rockable_car_watch_dead();
}

function rockable_car_watch_dead() {
  self endon("death");

  for(;;) {
    self.health = 99999;
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isexplosivedamagemod(var_4) && var_0 > 10) {
      self setscriptablepartstate("Anim_Explosion", "rock", 1);
    }

    print3d_debug(self.origin + (0, 0, 7), "Death animation: rock", (1, 1, 1), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 0), "Death damage by: " + var_4 + " " + var_0, (1, 1, 1), 1, 0.25, 150);
  }
}

function rockable_car_debug() {
  self endon("death");

  if(getdvarint("scr_rockable_vehicle_debug")) {
    for(;;) {
      print3d_debug(self.origin + (0, 0, 60), "rockable", (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }

    return;
  }
}

function alarm_cars_init() {
  level.alarmcars = spawnStruct();
  level.alarmcars.cars = level.rockablecars.cars;
  var_0 = 0;

  foreach(var_2 in level.alarmcars.cars) {
    if(var_0 > 19) {
      var_0 = 0;
      waitframe();
    }

    var_0 += 1;

    if(!isDefined(var_2.script_noteworthy) || var_2.script_noteworthy != "car_alarm" || !isDefined(var_2 getscriptablehaspart("Car_Alarm"))) {
      level.alarmcars.cars = scripts\engine\utility::array_remove(level.alarmcars.cars, var_2);
      continue;
    }

    thread alarm_car_watch_damage();
  }
}

function alarm_car_watch_damage() {
  self endon("death");
  self endon("rocked");
  self endon("stop_alarm");
  self setCanDamage(1);
  self.alarmdamage = 0;
  thread alarm_car_debug();

  for(;;) {
    self.health = 99999;
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    print3d_debug(self.origin + (0, 0, -7), "Alarm damage by: " + var_4 + " " + var_0, (1, 1, 1), 1, 0.25, 150);
    self.alarmdamage += var_0;
    waitframe();

    if(self.alarmdamage > 200) {
      self setscriptablepartstate("Car_Alarm", "on", 0);
      level notify("car_alarm", self);
      break;
    }
  }
}

function alarm_car_debug() {
  self endon("death");

  if(getdvarint("scr_rockable_vehicle_debug")) {
    for(;;) {
      print3d_debug(self.origin + (0, 0, 70), "alarm.dmg: " + self.alarmdamage, (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }

    return;
  }
}

function print3d_debug(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("scr_rockable_vehicle_debug")) {
    return;
  }
}