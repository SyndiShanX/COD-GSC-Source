/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\rockable_vehicles.gsc
************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace rockable_vehicles;

function init() {
  setdvarifuninitialized(@ "hash_89dce574801028ad", 0);
  level utility::delaythread(0.05, &rockable_cars_init);
}

function rockable_cars_init() {
  level.rockablecars = spawnStruct();
  level.rockablecars.cars = [];
  scriptables = getscriptablearray("X\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95", #code_classname);

  if(!isDefined(scriptables) || scriptables.size <= 0) {
    return;
  }

  count = 0;

  foreach(car in scriptables) {
    if(count > 19) {
      count = 0;
      waitframe();
    }

    count += 1;

    if(utility::issp()) {
      if(!isDefined(car.model) || !car valid_rockable_vehicle()) {
        continue;
      }
    }

    if(!car getscriptablehaspart("h\xed\x82\b\x01\xc0\xde4d\xfek\xa7\x04\xdd") && !car getscriptablehaspart("8E),>s2uM\xb3yg\x1f?\xa5\x81\xe0\x94]\xeb")) {
      continue;
    }

    level.rockablecars.cars[level.rockablecars.cars.size] = car;
    car.forward = anglesToForward(car.angles);
    car.right = anglestoright(car.angles);

    if(!utility::issp()) {
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
      car.var_973561a9d60c4a23 = 1;
    }

    car thread rockable_car_debug();

    if(getdvarint(@ "hash_2448528570ef56f7", 1) == 1) {
      car thread rockable_car_watch_damage();
      car thread rockable_car_watch_death();
      continue;
    }

    car setscriptablepartstate("\xb7\x1bs\xf8", "\x9c\x83\xbe\x9f\x1cc\x18I\xf81");
  }

  utility::flag_set("\x865\x06\xb5\x1c\x9a\xb8\xd8U\x19K{\rYS\x1d\x12\xe5");
  level thread alarm_cars_init();
}

function valid_rockable_vehicle() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "l\x9a\x0f\xe6\xc5w\x143\xbb\xc2\x8c@") {
    return 0;
  }

  if(issubstr(self.model, "\xcc\xcdn@\x13") || issubstr(self.model, "\xa2\xed\x1f\x9e\xbe")) {
    return 1;
  }

  return 0;
}

function rockable_car_watch_damage() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93\xb7\x8d[Y\xc8");
  self setCanDamage(1);
  self.rockable_last_point = 0;
  self.rockable_last_meansofdeath = "";

  while(true) {
    self.health = 99999;
    self waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.rockable_last_point = point;
    self.rockable_last_meansofdeath = meansofdeath;
    print3d_debug(self.origin + (0, 0, 0), "\x11\x0f\x97ux\xf0\x86*L\xb1\x04" + meansofdeath + "\xda" + damage, (1, 1, 1), 1, 0.25, 100);
  }
}

function rockable_car_watch_death() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittillmatch("\xe6\x8d'Kp\xa3X\x98\xd8\xac\xc9\xedtK3-\x8da:i\xde\xdc", "H\xed\x82\b\x01\xc4\xde4d\xfek\xa7\x04\xdd");
  self notify("\x93\xb7\x8d[Y\xc8");

  if(isexplosivedamagemod(self.rockable_last_meansofdeath)) {
    btwn = self.rockable_last_point - self.origin;
    forwardstr = vectordot(self.forward, btwn) > 0 ? "x\xd9\xebt\x91" : "\x8a+\xf04";
    rightstr = vectordot(self.right, btwn) > 0 ? "o0\xee\xc1\x8c" : "=\xff0b";
    self setscriptablepartstate("h\xed\x82\b\x01\xc0\xde4d\xfek\xa7\x04\xdd", forwardstr + "w" + rightstr, 0);
    print3d_debug(self.origin + (0, 0, -5), "DV\x16\x1d\xa1\x10\x89yG\x80" + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 12), "\x89\x9dS\xd0~#,.\x96\xd0\xb3" + forwardstr + "w" + rightstr, (1, 1, 1), 1, 0.25, 1000);
  } else {
    death_anims = ["%\xd3\ac\x84\xd8rQRr", "\xcbA\xe1\xc9#\xf6+\xe4\x82\xf4l", "\x8d\xea,\xe40\t\xddt\x83", "\xfb\xac\xa5\r\xe3s[\xdd\xf4y"];
    death_anim = death_anims[randomint(death_anims.size - 1)];
    self setscriptablepartstate("h\xed\x82\b\x01\xc0\xde4d\xfek\xa7\x04\xdd", death_anim, 0);
    print3d_debug(self.origin + (0, 0, -5), "DV\x16\x1d\xa1\x10\x89yG\x80" + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 5), "\xaf\xda\xfak\tK\x80,#\x88H{Y\xe1\xca}\x92\xa5", (1, 0, 0), 1, 0.5, 500);
    print3d_debug(self.origin + (0, 0, 10), "\x89\x9dS\xd0~#,.\x96\xd0\xb3" + death_anim, (1, 1, 1), 1, 0.25, 1000);
  }

  if(getdvarint(@ "hash_e9421533f01288a", 0) == 1) {
    wait randomfloatrange(15, 30);
    self setscriptablepartstate("\xb7\x1bs\xf8", "\x9eb\xb9N\xbc;");
    thread rockable_car_watch_death();
    return;
  }

  self waittillmatch("\xe6\x8d'Kp\xa3X\x98\xd8\xac\xc9\xedtK3-\x8da:i\xde\xdc", "\x93mZ\x02\xb2\x9cR\x84\xf4E\xfd\xdf\x9e\xea\x9f\x1c(\xaf\xabB\x1d\x87W");
  thread rockable_car_watch_dead();
}

function rockable_car_watch_dead() {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self.health = 99999;
    self waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isexplosivedamagemod(meansofdeath) && damage > 10) {
      self setscriptablepartstate("h\xed\x82\b\x01\xc0\xde4d\xfek\xa7\x04\xdd", "I\x9f\x80r", 1);
    }

    print3d_debug(self.origin + (0, 0, 7), "\x9f\x14\x9b\xca[~S`HSHU@\xda\xaal\xbc" + "I\x9f\x80r", (1, 1, 1), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 0), "^#\f\x13+\xfc\x1e=\xf5O\xa5U\x86\xf0\xfa\x84}" + meansofdeath + "\xda" + damage, (1, 1, 1), 1, 0.25, 150);
  }
}

function rockable_car_debug() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(getdvarint(@ "hash_89dce574801028ad")) {
    for(;;) {
      print3d_debug(self.origin + (0, 0, 60), "\xce0\xb2\x88[\x84\xb7=", (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }
  }
}

function alarm_cars_init() {
  level.alarmcars = spawnStruct();
  level.alarmcars.cars = level.rockablecars.cars;
  count = 0;

  foreach(car in level.alarmcars.cars) {
    if(count > 19) {
      count = 0;
      waitframe();
    }

    count += 1;

    if(!isDefined(car.script_noteworthy) || car.script_noteworthy != "\xb5\x86kU\xe6_[aC\x0e\xd1m\x84mV\x89\x85\xc5U\x98\xb5" || !isDefined(car getscriptablehaspart("2bK\x18\xd9\x14\xf0Vz"))) {
      level.alarmcars.cars = arrayremove(level.alarmcars.cars, car);
      continue;
    }

    car thread alarm_car_watch_damage();
  }
}

function alarm_car_watch_damage() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93\xb7\x8d[Y\xc8");
  self endon("\tX\x9f\xd2L\xa3HY\xf5\r");
  self setCanDamage(1);
  self.alarmdamage = 0;
  thread alarm_car_debug();

  while(true) {
    self.health = 99999;
    self waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    print3d_debug(self.origin + (0, 0, -7), "\x10\xf3\xad\x8b\xefe@#\xd3\x9e\r\xe3\xff\xee\x874\xc7" + meansofdeath + "\xda" + damage, (1, 1, 1), 1, 0.25, 150);
    self.alarmdamage += damage;
    waitframe();

    if(self.alarmdamage > 200) {
      self setscriptablepartstate("2bK\x18\xd9\x14\xf0Vz", "\xb8\"", 0);
      level notify("\xb5\x86kU\xe6_[aC\x0e\xd1m\x84mV\x89\x85\xc5U\x98\xb5", self);
      break;
    }
  }
}

function alarm_car_debug() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(getdvarint(@ "hash_89dce574801028ad")) {
    for(;;) {
      print3d_debug(self.origin + (0, 0, 70), ",\xc6X\xe4\xb6\x17\x10\x10#\xd6vG\x10" + self.alarmdamage, (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }
  }
}

function print3d_debug(origin, text, color, alpha, scale, duration) {
  if(getdvarint(@ "hash_89dce574801028ad")) {
    print3d(origin, text, color, alpha, scale, duration);
  }
}