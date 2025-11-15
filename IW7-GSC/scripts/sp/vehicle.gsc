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
  var_00 = scripts\sp\vehicle_code::func_D808();
  scripts\sp\vehicle_code::func_FA7A(var_00);
  level.vehicle.var_8BBA = getEntArray("script_vehicle", "code_classname").size > 0;
  scripts\sp\utility::func_16EB("invulerable_frags", & "SCRIPT_INVULERABLE_FRAGS", undefined);
  scripts\sp\utility::func_16EB("invulerable_bullets", & "SCRIPT_INVULERABLE_BULLETS", undefined);
  scripts\sp\utility::func_16EB("c12_bullets", & "SCRIPT_C12_BULLETS");
}

func_1321A(param_00, param_01, param_02) {
  return scripts\sp\vehicle_paths::func_1442(param_00, param_01, param_02);
}

func_13237(param_00) {
  return scripts\sp\vehicle_code::func_1444(param_00);
}

func_A5DF(param_00, param_01) {
  return scripts\sp\vehicle_code::func_12FB(param_00, param_01);
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

func_1080E(param_00) {
  var_01 = [];
  var_01 = scripts\sp\vehicle_code::func_10810(param_00);
  return var_01;
}

func_1080C(param_00) {
  var_01 = func_1080E(param_00);
  return var_01[0];
}

func_1080D(param_00) {
  var_01 = func_1080E(param_00);
  thread scripts\sp\vehicle_paths::setsuit(var_01[0]);
  return var_01[0];
}

func_1080F(param_00) {
  var_01 = func_1080E(param_00);
  foreach(var_03 in var_01) {
    thread scripts\sp\vehicle_paths::setsuit(var_03);
  }

  return var_01;
}

func_1A92(param_00) {
  thread scripts\sp\vehicle_code::func_1A93(param_00);
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

func_1320F(param_00, param_01, param_02) {
  if(!isarray(param_00)) {
    param_00 = [param_00];
  }

  scripts\sp\vehicle_aianim::func_ADA7(param_00, undefined, param_02);
}

func_1080B() {
  var_00 = scripts\sp\utility::func_10808();
  if(isDefined(self.script_speed)) {
    if(!func_9E2C()) {
      var_00 _meth_83F4(self.script_speed);
    }
  }

  thread scripts\sp\vehicle_paths::setsuit(var_00);
  return var_00;
}

func_2470(param_00) {
  self vehicle_teleport(param_00.origin, param_00.angles);
  if(!func_9E2C()) {
    scripts\engine\utility::waitframe();
    self attachpath(param_00);
  }

  thread func_1321A(param_00, 1);
}

func_2471(param_00) {
  self vehicle_teleport(param_00.origin, param_00.angles);
  scripts\engine\utility::waitframe();
  if(!func_9E2C()) {
    self attachpath(param_00);
  }

  thread func_1321A(param_00);
  scripts\sp\vehicle_paths::setsuit(self);
}

func_131DF(param_00) {
  var_01 = [];
  var_02 = self.classname;
  if(!isDefined(level.vehicle.var_116CE.var_12BCF[var_02])) {
    return var_01;
  }

  var_03 = level.vehicle.var_116CE.var_12BCF[var_02];
  if(!isDefined(param_00)) {
    return var_01;
  }

  foreach(var_05 in self.var_E4FB) {
    foreach(var_07 in var_03[param_00]) {
      if(var_05.var_1321D == var_07) {
        var_01[var_01.size] = var_05;
      }
    }
  }

  return var_01;
}

func_13253(param_00) {
  return scripts\sp\vehicle_code::func_1446(param_00);
}

func_13250() {
  self notify("stop_scanning_turret");
}

func_131DD() {
  self endon("death");
  var_00 = [];
  var_01 = self.var_247E;
  if(!isDefined(self.var_247E)) {
    return var_00;
  }

  var_02 = var_01;
  var_02.var_46B3 = 0;
  while(isDefined(var_02)) {
    if(isDefined(var_02.var_46B3) && var_02.var_46B3 == 1) {
      break;
    }

    var_00 = scripts\engine\utility::array_add(var_00, var_02);
    var_02.var_46B3 = 1;
    if(!isDefined(var_02.target)) {
      break;
    }

    if(!func_9E2C()) {
      var_02 = getvehiclenode(var_02.target, "targetname");
      continue;
    }

    var_02 = scripts\sp\utility::func_7E96(var_02.target, "targetname");
  }

  return var_00;
}

func_1320C(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  scripts\sp\vehicle_lights::lights_on(param_00, param_01);
}

func_1320B(param_00, param_01) {
  scripts\sp\vehicle_lights::lights_off(param_00, param_01);
}

func_13245(param_00, param_01) {
  self setswitchnode(param_00, param_01);
  self.var_247E = param_01;
  thread func_1321A();
}

func_13244(param_00, param_01, param_02) {
  return scripts\sp\vehicle_paths::func_1445(param_00, param_01, param_02);
}

func_13220(param_00) {
  return scripts\sp\vehicle_paths::func_1443(param_00);
}

func_9E2C() {
  return scripts\sp\vehicle_code::func_12F8();
}

func_9D34() {
  return scripts\sp\vehicle_code::func_12F6();
}

func_3182(param_00) {
  if(!isDefined(level.vehicle.var_116CE.var_4E12)) {
    level.vehicle.var_116CE.var_4E12 = [];
  }

  var_01 = spawnStruct();
  var_01.delay = param_00;
  level.vehicle.var_116CE.var_4E12[level.var_13570] = var_01;
}

func_61FB() {
  scripts\sp\vehicle_code::func_F9C7();
  level.vehicle.var_10709 = 1;
}