/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\rockable_vehicles.gsc
************************************************/

init() {
  setdvarifuninitialized("dvar_89DCE574801028AD", 0);
  level scripts\engine\utility::delaythread(0.05, ::rockable_cars_init);
}

rockable_cars_init() {
  level.rockablecars = spawnStruct();
  level.rockablecars.cars = [];
  scriptables = getscriptablearray("scriptable", "code_classname");

  if(!isDefined(scriptables) || scriptables.size <= 0) {
    return;
  }
  count = 0;

  foreach(car in scriptables) {
    if(count > 19) {
      count = 0;
      waitframe();
    }

    count = count + 1;

    if(scripts\common\utility::issp()) {
      if(!isDefined(car.model) || !car valid_rockable_vehicle())
        continue;
    }

    if(!car getscriptablehaspart("Anim_Explosion") && !car getscriptablehaspart("Anim_PlayerStandRock")) {
      continue;
    }
    level.rockablecars.cars[level.rockablecars.cars.size] = car;
    car.forward = anglesToForward(car.angles);
    car.right = anglestoright(car.angles);

    if(!scripts\common\utility::issp()) {
      car.up = anglestoup(car.angles);
      car.frontpoint = car getpointinbounds(1, 0, 0);
      car.backpoint = car getpointinbounds(-1, 0, 0);
      car.leftpoint = car getpointinbounds(0, 1, 0);
      car.rightpoint = car getpointinbounds(0, -1, 0);
      car.toppoint = car getpointinbounds(0, 0, -0.15);
      car.halflength = vectordot(car.forward, car.frontpoint - car.backpoint) / 2;
      car.halfwidth = vectordot(car.right, car.rightpoint - car.leftpoint) / 2;
      car.players = [];
      car.touchtimes = [];
      car.rocktimes = [];
      car._id_743EBAB8013B6CDE = 1;
    }

    car thread rockable_car_debug();

    if(getdvarint("dvar_2448528570EF56F7", 1) == 1) {
      car thread rockable_car_watch_damage();
      car thread rockable_car_watch_death();
      continue;
    }

    car setscriptablepartstate("body", "no_process");
  }

  scripts\engine\utility::flag_set("rockable_cars_init");
  level thread alarm_cars_init();
}

valid_rockable_vehicle() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "not_rockable")
    return 0;

  if(issubstr(self.model, "veh8_") || issubstr(self.model, "veh9_"))
    return 1;
  else
    return 0;
}

rockable_car_watch_damage() {
  self endon("death");
  self endon("rocked");
  self setCanDamage(1);
  self.rockable_last_point = 0;
  self.rockable_last_meansofdeath = "";

  for(;;) {
    self.health = 99999;
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.rockable_last_point = point;
    self.rockable_last_meansofdeath = meansofdeath;
    print3d_debug(self.origin + (0, 0, 0), "Damage by: " + meansofdeath + " " + damage, (1, 1, 1), 1, 0.25, 100);
  }
}

rockable_car_watch_death() {
  self endon("death");
  self waittillmatch("scriptableNotification", "anim_explosion");
  self notify("rocked");

  if(isexplosivedamagemod(self.rockable_last_meansofdeath)) {
    _id_340D59422336E85A = self.rockable_last_point - self.origin;
    _id_AD3D23DAC7C40D91 = scripts\engine\utility::ter_op(vectordot(self.forward, _id_340D59422336E85A) > 0, "front", "back");
    _id_26CDA4570F0CAFB4 = scripts\engine\utility::ter_op(vectordot(self.right, _id_340D59422336E85A) > 0, "right", "left");
    self setscriptablepartstate("Anim_Explosion", _id_AD3D23DAC7C40D91 + "_" + _id_26CDA4570F0CAFB4, 0);
    print3d_debug(self.origin + (0, 0, -5), "Death by: " + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 12), "Animation: " + _id_AD3D23DAC7C40D91 + "_" + _id_26CDA4570F0CAFB4, (1, 1, 1), 1, 0.25, 1000);
  } else {
    _id_336C218E59594398 = ["front_left", "front_right", "back_left", "back_right"];
    _id_95002E6CED84067B = _id_336C218E59594398[randomint(_id_336C218E59594398.size - 1)];
    self setscriptablepartstate("Anim_Explosion", _id_95002E6CED84067B, 0);
    print3d_debug(self.origin + (0, 0, -5), "Death by: " + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 5), "scripted explosion", (1, 0, 0), 1, 0.5, 500);
    print3d_debug(self.origin + (0, 0, 10), "Animation: " + _id_95002E6CED84067B, (1, 1, 1), 1, 0.25, 1000);
  }

  if(getdvarint("dvar_0E9421533F01288A", 0) == 1) {
    wait(randomfloatrange(15, 30));
    self setscriptablepartstate("body", "onfire");
    thread rockable_car_watch_death();
    return;
  }

  self waittillmatch("scriptableNotification", "anim_explosion_complete");
  thread rockable_car_watch_dead();
}

rockable_car_watch_dead() {
  self endon("death");

  for(;;) {
    self.health = 99999;
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isexplosivedamagemod(meansofdeath) && damage > 10)
      self setscriptablepartstate("Anim_Explosion", "rock", 1);

    print3d_debug(self.origin + (0, 0, 7), "Death animation: rock", (1, 1, 1), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 0), "Death damage by: " + meansofdeath + " " + damage, (1, 1, 1), 1, 0.25, 150);
  }
}

rockable_car_debug() {
  self endon("death");

  if(getdvarint("dvar_89DCE574801028AD")) {
    for(;;) {
      print3d_debug(self.origin + (0, 0, 60), "rockable", (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }
  }
}

alarm_cars_init() {
  level.alarmcars = spawnStruct();
  level.alarmcars.cars = level.rockablecars.cars;
  count = 0;

  foreach(car in level.alarmcars.cars) {
    if(count > 19) {
      count = 0;
      waitframe();
    }

    count = count + 1;

    if(!isDefined(car.script_noteworthy) || car.script_noteworthy != "veh9_generic_alarm_on" || !isDefined(car getscriptablehaspart("Car_Alarm"))) {
      level.alarmcars.cars = scripts\engine\utility::array_remove(level.alarmcars.cars, car);
      continue;
    }

    car thread alarm_car_watch_damage();
  }
}

alarm_car_watch_damage() {
  self endon("death");
  self endon("rocked");
  self endon("stop_alarm");
  self setCanDamage(1);
  self.alarmdamage = 0;
  thread alarm_car_debug();

  for(;;) {
    self.health = 99999;
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    print3d_debug(self.origin + (0, 0, -7), "Alarm damage by: " + meansofdeath + " " + damage, (1, 1, 1), 1, 0.25, 150);
    self.alarmdamage = self.alarmdamage + damage;
    waitframe();

    if(self.alarmdamage > 200) {
      self setscriptablepartstate("Car_Alarm", "on", 0);
      level notify("veh9_generic_alarm_on", self);
      break;
    }
  }
}

alarm_car_debug() {
  self endon("death");

  if(getdvarint("dvar_89DCE574801028AD")) {
    for(;;) {
      print3d_debug(self.origin + (0, 0, 70), "alarm.dmg: " + self.alarmdamage, (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }
  }
}

print3d_debug(origin, text, color, alpha, scale, duration) {
  if(getdvarint("dvar_89DCE574801028AD"))
    return;
}