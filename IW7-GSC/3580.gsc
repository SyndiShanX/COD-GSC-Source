/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3580.gsc
************************/

func_DAF5(param_00) {
  thread func_13A55(param_00);
  thread func_13A6E(param_00);
}

func_13A55(param_00) {
  param_00 endon("death");
  self waittill("disconnect");
  param_00 delete();
}

func_13A6E(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  param_00 waittill("missile_stuck");
  var_01 = anglestoup(param_00.angles);
  var_02 = func_10856(param_00);
  var_02 scripts\mp\equipment\blackhat::func_2B2A();
  var_02 thread func_13A3B();
  thread func_13B19(var_02);
}

func_13B19(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  var_01 = param_00.objective_position;
  var_01 endon("death");
  param_00 setscriptablepartstate("effects", "warmUp", 0);
  wait(1);
  param_00 setscriptablepartstate("effects", "explode_01", 0);
  var_01 thread scripts\mp\shellshock::func_DAF3();
  param_00 radiusdamage(var_01.origin, 256, 100, 50, var_01.triggerportableradarping, "MOD_EXPLOSIVE", var_01.weapon_name);
  var_02 = var_01.ticks;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    wait(0.5);
    switch (var_03) {
      case 0:
        param_00 setscriptablepartstate("effects", "explode_02", 0);
        break;

      case 1:
        param_00 setscriptablepartstate("effects", "explode_03", 0);
        break;

      case 2:
        param_00 setscriptablepartstate("effects", "explode_04", 0);
        break;

      case 3:
        param_00 setscriptablepartstate("effects", "explode_05", 0);
        break;
    }

    var_01 thread scripts\mp\shellshock::func_DAF3();
    param_00 radiusdamage(var_01.origin, 256, 40, 20, var_01.triggerportableradarping, "MOD_EXPLOSIVE", var_01.weapon_name);
  }

  wait(1);
  var_01 delete();
}

func_10856(param_00) {
  var_01 = spawn("script_model", param_00.origin);
  var_01 setModel("prop_mp_pulse_grenade_temp");
  var_01.angles = param_00.angles;
  var_01 linkto(param_00);
  var_01.objective_position = param_00;
  var_01.triggerportableradarping = param_00.triggerportableradarping;
  var_01 setotherent(param_00.triggerportableradarping);
  var_01 thread func_40F3(param_00);
  param_00 hide();
  return var_01;
}

func_13A3B() {
  scripts\mp\damage::monitordamage(50, "pulseGrenade", ::func_612B, ::func_612C, 0);
}

func_612B(param_00, param_01, param_02, param_03) {
  if(isDefined(self.triggerportableradarping) && param_00 != self.triggerportableradarping) {
    param_00 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
    param_00 notify("destroyed_equipment");
  }

  scripts\mp\equipment\blackhat::func_2B2C();
  self.objective_position delete();
  self notify("detonateExplosive");
}

func_612C(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\damage::handlemeleedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleempdamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

func_40F3(param_00) {
  param_00 waittill("death");
  self delete();
}

killcament() {
  if(isDefined(self)) {
    return self.objective_position;
  }
}

func_DAF4() {
  self shellshock("pulse_grenade_mp", 0.3);
}