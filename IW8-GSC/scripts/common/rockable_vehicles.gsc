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

  var0 = 0;

  foreach(var2 in level.rockablecars.cars) {
    if(var0 > 19) {
      var0 = 0;
      waitframe();
    }

    var0 += 1;

    if(scripts\common\utility::issp()) {
      if(!isDefined(var2.model) || !valid_rockable_vehicle(var2)) {
        level.rockablecars.cars = scripts\engine\utility::array_remove(level.rockablecars.cars, var2);
        continue;
      }
    }

    if(!isDefined(var2 getscriptablepartstate("Anim_Explosion", 1)) && !isDefined(var2 getscriptablepartstate("Anim_PlayerStandRock", 1))) {
      level.rockablecars.cars = scripts\engine\utility::array_remove(level.rockablecars.cars, var2);
      continue;
    }

    var2.forward = anglesToForward(var2.angles);
    var2.right = anglestoright(var2.angles);

    if(!scripts\common\utility::issp()) {
      var2.up = anglestoup(var2.angles);
      var2.frontpoint = var2 getpointinbounds(1, 0, 0);
      var2.backpoint = var2 getpointinbounds(-1, 0, 0);
      var2.leftpoint = var2 getpointinbounds(0, 1, 0);
      var2.rightpoint = var2 getpointinbounds(0, -1, 0);
      var2.toppoint = var2 getpointinbounds(0, 0, 0.25);
      var2.halflength = vectordot(var2.forward, var2.frontpoint - var2.backpoint) / 2;
      var2.halfwidth = vectordot(var2.right, var2.rightpoint - var2.leftpoint) / 2;
      var2.players = [];
      var2.touchtimes = [];
      var2.rocktimes = [];
      var2.rockstrings = [];
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
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
    self.rockable_last_point = var3;
    self.rockable_last_meansofdeath = var4;
    print3d_debug(self.origin + (0, 0, 0), "Damage by: " + var4 + " " + var0, (1, 1, 1), 1, 0.25, 100);
  }
}

function rockable_car_watch_death() {
  self endon("death");
  self waittillmatch("scriptableNotification", "anim_explosion");
  self notify("rocked");

  if(isexplosivedamagemod(self.rockable_last_meansofdeath)) {
    var0 = self.rockable_last_point - self.origin;
    var1 = scripts\engine\utility::ter_op(vectordot(self.forward, var0) > 0, "front", "back");
    var2 = scripts\engine\utility::ter_op(vectordot(self.right, var0) > 0, "right", "left");
    self setscriptablepartstate("Anim_Explosion", var1 + "_" + var2, 0);
    print3d_debug(self.origin + (0, 0, -5), "Death by: " + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 12), "Animation: " + var1 + "_" + var2, (1, 1, 1), 1, 0.25, 1000);
  } else {
    var3 = ["front_left", "front_right", "back_left", "back_right"];
    var4 = var3[randomint(var3.size - 1)];
    self setscriptablepartstate("Anim_Explosion", var4, 0);
    print3d_debug(self.origin + (0, 0, -5), "Death by: " + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 5), "scripted explosion", (1, 0, 0), 1, 0.5, 500);
    print3d_debug(self.origin + (0, 0, 10), "Animation: " + var4, (1, 1, 1), 1, 0.25, 1000);
  }

  self waittillmatch("scriptableNotification", "anim_explosion_complete");
  thread rockable_car_watch_dead();
}

function rockable_car_watch_dead() {
  self endon("death");

  for(;;) {
    self.health = 99999;
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);

    if(isexplosivedamagemod(var4) && var0 > 10) {
      self setscriptablepartstate("Anim_Explosion", "rock", 1);
    }

    print3d_debug(self.origin + (0, 0, 7), "Death animation: rock", (1, 1, 1), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 0), "Death damage by: " + var4 + " " + var0, (1, 1, 1), 1, 0.25, 150);
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
  var0 = 0;

  foreach(var2 in level.alarmcars.cars) {
    if(var0 > 19) {
      var0 = 0;
      waitframe();
    }

    var0 += 1;

    if(!isDefined(var2.script_noteworthy) || var2.script_noteworthy != "car_alarm" || !isDefined(var2 getscriptablehaspart("Car_Alarm"))) {
      level.alarmcars.cars = scripts\engine\utility::array_remove(level.alarmcars.cars, var2);
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
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
    print3d_debug(self.origin + (0, 0, -7), "Alarm damage by: " + var4 + " " + var0, (1, 1, 1), 1, 0.25, 150);
    self.alarmdamage += var0;
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

function print3d_debug(var0, var1, var2, var3, var4, var5) {
  if(getdvarint("scr_rockable_vehicle_debug")) {
    return;
  }
}