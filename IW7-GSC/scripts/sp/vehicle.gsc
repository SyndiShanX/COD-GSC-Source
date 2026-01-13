/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\vehicle.gsc
**********************************/

func_979A() {
  if(isDefined(level.var_5619) && level.var_5619) {
    return;
  }

  if(!scripts\engine\utility::add_init_script("vehicles", ::func_979A)) {
    return;
  }

  thread func_979B();
  scripts\sp\utility::func_D6D9(::func_40D9);
}

func_40D9() {
  level.var_13570 = undefined;
  level.var_13571 = undefined;
  level.var_13575 = undefined;
}

func_979B() {
  scripts\engine\utility::create_lock("aircraft_wash_math");
  scripts\sp\vehicle_code::func_F9C7();
  level.vehicle.var_8DAA = scripts\engine\utility::array_combine(level.vehicle.var_8DAA, scripts\sp\utility::_meth_8181("helicopter_crash_location", "targetname"));
  scripts\sp\vehicle_code::func_FA79();
  var_0 = scripts\sp\vehicle_code::func_D808();
  scripts\sp\vehicle_code::func_FA7A(var_0);
  level.vehicle.var_8BBA = getEntArray("script_vehicle", "code_classname").size > 0;
  scripts\sp\utility::func_16EB("invulerable_frags", &"SCRIPT_INVULERABLE_FRAGS", undefined);
  scripts\sp\utility::func_16EB("invulerable_bullets", &"SCRIPT_INVULERABLE_BULLETS", undefined);
  scripts\sp\utility::func_16EB("c12_bullets", &"SCRIPT_C12_BULLETS");
}

func_1321A(var_0, var_1, var_2) {
  return scripts\sp\vehicle_paths::func_1442(var_0, var_1, var_2);
}

func_13237(var_0) {
  return scripts\sp\vehicle_code::func_1444(var_0);
}

func_A5DF(var_0, var_1) {
  return scripts\sp\vehicle_code::func_12FB(var_0, var_1);
}

playgestureviewmodel() {
  self._meth_843F = 1;
}

_meth_8440() {
  self._meth_843F = 0;
}

func_B6B9() {
  return scripts\sp\vehicle_code::func_134C();
}

func_B6BA() {
  return scripts\sp\vehicle_code::func_134D();
}

func_9FEF() {
  return isDefined(self.var_380);
}

func_131F7() {
  return scripts\sp\vehicle_code::func_143E();
}

func_9BF2() {
  return scripts\sp\vehicle_code::func_12F0();
}

func_131FC() {
  self notify("kill_rumble_forever");
}

func_1080E(var_0) {
  var_1 = [];
  var_1 = scripts\sp\vehicle_code::func_10810(var_0);
  return var_1;
}

func_1080C(var_0) {
  var_1 = func_1080E(var_0);
  return var_1[0];
}

func_1080D(var_0) {
  var_1 = func_1080E(var_0);
  thread scripts\sp\vehicle_paths::setsuit(var_1[0]);
  return var_1[0];
}

func_1080F(var_0) {
  var_1 = func_1080E(var_0);
  foreach(var_3 in var_1) {
    thread scripts\sp\vehicle_paths::setsuit(var_3);
  }

  return var_1;
}

func_1A92(var_0) {
  thread scripts\sp\vehicle_code::func_1A93(var_0);
}

func_13259() {
  scripts\sp\vehicle_code::func_13D03(1);
}

func_13258() {
  scripts\sp\vehicle_code::func_13D03(0);
}

func_9BC7() {
  return self.var_B91F;
}

func_1320F(var_0, var_1, var_2) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  scripts\sp\vehicle_aianim::func_ADA7(var_0, undefined, var_2);
}

func_1080B() {
  var_0 = scripts\sp\utility::func_10808();
  if(isDefined(self.script_speed)) {
    if(!func_9E2C()) {
      var_0 _meth_83F4(self.script_speed);
    }
  }

  thread scripts\sp\vehicle_paths::setsuit(var_0);
  return var_0;
}

func_2470(var_0) {
  self vehicle_teleport(var_0.origin, var_0.angles);
  if(!func_9E2C()) {
    scripts\engine\utility::waitframe();
    self attachpath(var_0);
  }

  thread func_1321A(var_0, 1);
}

func_2471(var_0) {
  self vehicle_teleport(var_0.origin, var_0.angles);
  scripts\engine\utility::waitframe();
  if(!func_9E2C()) {
    self attachpath(var_0);
  }

  thread func_1321A(var_0);
  scripts\sp\vehicle_paths::setsuit(self);
}

func_131DF(var_0) {
  var_1 = [];
  var_2 = self.classname;
  if(!isDefined(level.vehicle.var_116CE.var_12BCF[var_2])) {
    return var_1;
  }

  var_3 = level.vehicle.var_116CE.var_12BCF[var_2];
  if(!isDefined(var_0)) {
    return var_1;
  }

  foreach(var_5 in self.var_E4FB) {
    foreach(var_7 in var_3[var_0]) {
      if(var_5.var_1321D == var_7) {
        var_1[var_1.size] = var_5;
      }
    }
  }

  return var_1;
}

func_13253(var_0) {
  return scripts\sp\vehicle_code::func_1446(var_0);
}

func_13250() {
  self notify("stop_scanning_turret");
}

func_131DD() {
  self endon("death");
  var_0 = [];
  var_1 = self.var_247E;
  if(!isDefined(self.var_247E)) {
    return var_0;
  }

  var_2 = var_1;
  var_2.var_46B3 = 0;
  while(isDefined(var_2)) {
    if(isDefined(var_2.var_46B3) && var_2.var_46B3 == 1) {
      break;
    }

    var_0 = scripts\engine\utility::array_add(var_0, var_2);
    var_2.var_46B3 = 1;
    if(!isDefined(var_2.target)) {
      break;
    }

    if(!func_9E2C()) {
      var_2 = getvehiclenode(var_2.target, "targetname");
      continue;
    }

    var_2 = scripts\sp\utility::func_7E96(var_2.target, "targetname");
  }

  return var_0;
}

func_1320C(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  scripts\sp\vehicle_lights::lights_on(var_0, var_1);
}

func_1320B(var_0, var_1) {
  scripts\sp\vehicle_lights::lights_off(var_0, var_1);
}

func_13245(var_0, var_1) {
  self setswitchnode(var_0, var_1);
  self.var_247E = var_1;
  thread func_1321A();
}

func_13244(var_0, var_1, var_2) {
  return scripts\sp\vehicle_paths::func_1445(var_0, var_1, var_2);
}

func_13220(var_0) {
  return scripts\sp\vehicle_paths::func_1443(var_0);
}

func_9E2C() {
  return scripts\sp\vehicle_code::func_12F8();
}

func_9D34() {
  return scripts\sp\vehicle_code::func_12F6();
}

func_3182(var_0) {
  if(!isDefined(level.vehicle.var_116CE.var_4E12)) {
    level.vehicle.var_116CE.var_4E12 = [];
  }

  var_1 = spawnStruct();
  var_1.delay = var_0;
  level.vehicle.var_116CE.var_4E12[level.var_13570] = var_1;
}

func_61FB() {
  scripts\sp\vehicle_code::func_F9C7();
  level.vehicle.var_10709 = 1;
}