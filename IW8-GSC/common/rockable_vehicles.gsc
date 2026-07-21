/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\rockable_vehicles.gsc
***********************************************/

init() {
  setdvarifuninitialized("_encstr_AF661B936E93A74A0FD072AAA071C7EF4BC56831F6B8B7D931C8EAE3A0", 0);
  level scripts\engine\utility::delaythread(0.05, ::rockable_cars_init);
}

rockable_cars_init() {
  level.rockablecars = spawnStruct();
  level.rockablecars.cars = getscriptablearray("_encstr_96010BDCD8392D073A164C1B2B", "_encstr_956D0F572FD22561C3BD81DB62A6D869BA");

  if(!isDefined(level.rockablecars.cars) || level.rockablecars.cars.size <= 0) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level.rockablecars.cars) {
    if(var_0 > 19) {
      var_0 = 0;
      waitframe();
    }

    var_0 = var_0 + 1;

    if(scripts\common\utility::issp()) {
      if(!isDefined(var_2.model) || !var_2 valid_rockable_vehicle()) {
        level.rockablecars.cars = scripts\engine\utility::array_remove(level.rockablecars.cars, var_2);
        continue;
      }
    }

    if(!isDefined(var_2 getscriptablepartstate("_encstr_AF790FF15D41D931254052FCA0E06102C6", 1)) && !isDefined(var_2 getscriptablepartstate("_encstr_8CED155BB68CB8608B02919AFA6B3E28261EA9F52FF640", 1))) {
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

    var_2 thread rockable_car_debug();
    var_2 thread rockable_car_watch_damage();
    var_2 thread rockable_car_watch_death();
  }

  level thread alarm_cars_init();
}

valid_rockable_vehicle() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "_encstr_82380D1DAFA3418E0F9AC8B1B23BCD")
    return 0;

  if(issubstr(self.model, "_encstr_A2B606CEAC43E0D7"))
    return 1;
  else
    return 0;
}

rockable_car_watch_damage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8E8A07F3E786825508");
  self setCanDamage(1);
  self.rockable_last_point = 0;
  self.rockable_last_meansofdeath = "_encstr_B40101";

  for(;;) {
    self.health = 99999;
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    self.rockable_last_point = var_3;
    self.rockable_last_meansofdeath = var_4;
    print3d_debug(self.origin + (0, 0, 0), "_encstr_93CF0C91794D18BC9F06B1DA4F62" + var_4 + "_encstr_974C0246" + var_0, (1, 1, 1), 1, 0.25, 100);
  }
}

rockable_car_watch_death() {
  self endon("_encstr_AD75063D571AE108");
  self waittillmatch("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", "_encstr_AF790FF05D41D931214052FCA0E06102C6");
  self notify("_encstr_8E8A07F3E786825508");

  if(isexplosivedamagemod(self.rockable_last_meansofdeath)) {
    var_0 = self.rockable_last_point - self.origin;
    var_1 = scripts\engine\utility::ter_op(vectordot(self.forward, var_0) > 0, "_encstr_AA5606FD1AF05085", "_encstr_B69B0589C236B6");
    var_2 = scripts\engine\utility::ter_op(vectordot(self.right, var_0) > 0, "_encstr_8253060E2B5FE330", "_encstr_A5AD056A019C63");
    self setscriptablepartstate("_encstr_AF790FF15D41D931254052FCA0E06102C6", var_1 + "_encstr_BA4C02DF" + var_2, 0);
    print3d_debug(self.origin + (0, 0, -5), "_encstr_83C30B882B0BA30D0413BC7402" + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 12), "_encstr_9BDA0C2873A5D6C2474BEDE67480" + var_1 + "_encstr_BA4C02DF" + var_2, (1, 1, 1), 1, 0.25, 1000);
  } else {
    var_3 = ["_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3"];
    var_4 = var_3[randomint(var_3.size - 1)];
    self setscriptablepartstate("_encstr_AF790FF15D41D931254052FCA0E06102C6", var_4, 0);
    print3d_debug(self.origin + (0, 0, -5), "_encstr_83C30B882B0BA30D0413BC7402" + self.rockable_last_meansofdeath, (1, 0, 0), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 5), "_encstr_AA89131E7E837393EC07A882EF086B81BAE29BA895", (1, 0, 0), 1, 0.5, 500);
    print3d_debug(self.origin + (0, 0, 10), "_encstr_9BDA0C2873A5D6C2474BEDE67480" + var_4, (1, 1, 1), 1, 0.25, 1000);
  }

  self waittillmatch("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", "_encstr_8C0B1819A53025FF3582935A48161F1DA05F936FCBA02DDF65D9");
  thread rockable_car_watch_dead();
}

rockable_car_watch_dead() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.health = 99999;
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isexplosivedamagemod(var_4) && var_0 > 10)
      self setscriptablepartstate("_encstr_AF790FF15D41D931254052FCA0E06102C6", "_encstr_8A1F05937B366D", 1);

    print3d_debug(self.origin + (0, 0, 7), "_encstr_97ED1611B2C2A31A10B0DCA56B161DB4DBB9D140E4F6B1DA", (1, 1, 1), 1, 0.25, 1000);
    print3d_debug(self.origin + (0, 0, 0), "_encstr_B87012B955768813A25A39A012675DE24EB1CDE9" + var_4 + "_encstr_974C0246" + var_0, (1, 1, 1), 1, 0.25, 150);
  }
}

rockable_car_debug() {
  self endon("_encstr_AD75063D571AE108");

  if(getdvarint("_encstr_AF661B936E93A74A0FD072AAA071C7EF4BC56831F6B8B7D931C8EAE3A0")) {
    for(;;) {
      print3d_debug(self.origin + (0, 0, 60), "_encstr_B869090D70E71FEA92A033", (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }
  }
}

alarm_cars_init() {
  level.alarmcars = spawnStruct();
  level.alarmcars.cars = level.rockablecars.cars;
  var_0 = 0;

  foreach(var_2 in level.alarmcars.cars) {
    if(var_0 > 19) {
      var_0 = 0;
      waitframe();
    }

    var_0 = var_0 + 1;

    if(!isDefined(var_2.script_noteworthy) || var_2.script_noteworthy != "_encstr_96E90A967E039F3174979868" || !isDefined(var_2 getscriptablehaspart("_encstr_96E90A867E039F3574979868"))) {
      level.alarmcars.cars = scripts\engine\utility::array_remove(level.alarmcars.cars, var_2);
      continue;
    }

    var_2 thread alarm_car_watch_damage();
  }
}

alarm_car_watch_damage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8E8A07F3E786825508");
  self endon("_encstr_A9A30BB664AF1BA746E220A0EA");
  self setCanDamage(1);
  self.alarmdamage = 0;
  thread alarm_car_debug();

  for(;;) {
    self.health = 99999;
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    print3d_debug(self.origin + (0, 0, -7), "_encstr_8E761279B22E9DD002EC3F21C1371981564B3AFA" + var_4 + "_encstr_974C0246" + var_0, (1, 1, 1), 1, 0.25, 150);
    self.alarmdamage = self.alarmdamage + var_0;
    waitframe();

    if(self.alarmdamage > 200) {
      self setscriptablepartstate("_encstr_96E90A867E039F3574979868", "_encstr_AB0703DBB9", 0);
      level notify("_encstr_96E90A967E039F3174979868", self);
      break;
    }
  }
}

alarm_car_debug() {
  self endon("_encstr_AD75063D571AE108");

  if(getdvarint("_encstr_AF661B936E93A74A0FD072AAA071C7EF4BC56831F6B8B7D931C8EAE3A0")) {
    for(;;) {
      print3d_debug(self.origin + (0, 0, 70), "_encstr_86F50E58D816275BE20840C8ADEC7440" + self.alarmdamage, (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }
  }
}

print3d_debug(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("_encstr_AF661B936E93A74A0FD072AAA071C7EF4BC56831F6B8B7D931C8EAE3A0"))
    return;
}