/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3580.gsc
*********************************************/

func_DAF5(var_0) {
  thread func_13A55(var_0);
  thread func_13A6E(var_0);
}

func_13A55(var_0) {
  var_0 endon("death");
  self waittill("disconnect");
  var_0 delete();
}

func_13A6E(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_0 waittill("missile_stuck");
  var_1 = anglestoup(var_0.angles);
  var_2 = func_10856(var_0);
  var_2 scripts\mp\equipment\blackhat::func_2B2A();
  var_2 thread func_13A3B();
  thread func_13B19(var_2);
}

func_13B19(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_1 = var_0.objective_position;
  var_1 endon("death");
  var_0 setscriptablepartstate("effects", "warmUp", 0);
  wait(1);
  var_0 setscriptablepartstate("effects", "explode_01", 0);
  var_1 thread scripts\mp\shellshock::func_DAF3();
  var_0 radiusdamage(var_1.origin, 256, 100, 50, var_1.triggerportableradarping, "MOD_EXPLOSIVE", var_1.weapon_name);
  var_2 = var_1.ticks;
  for(var_3 = 0; var_3 < var_2; var_3++) {
    wait(0.5);
    switch (var_3) {
      case 0:
        var_0 setscriptablepartstate("effects", "explode_02", 0);
        break;

      case 1:
        var_0 setscriptablepartstate("effects", "explode_03", 0);
        break;

      case 2:
        var_0 setscriptablepartstate("effects", "explode_04", 0);
        break;

      case 3:
        var_0 setscriptablepartstate("effects", "explode_05", 0);
        break;
    }

    var_1 thread scripts\mp\shellshock::func_DAF3();
    var_0 radiusdamage(var_1.origin, 256, 40, 20, var_1.triggerportableradarping, "MOD_EXPLOSIVE", var_1.weapon_name);
  }

  wait(1);
  var_1 delete();
}

func_10856(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("prop_mp_pulse_grenade_temp");
  var_1.angles = var_0.angles;
  var_1 linkto(var_0);
  var_1.objective_position = var_0;
  var_1.triggerportableradarping = var_0.triggerportableradarping;
  var_1 setotherent(var_0.triggerportableradarping);
  var_1 thread func_40F3(var_0);
  var_0 hide();
  return var_1;
}

func_13A3B() {
  scripts\mp\damage::monitordamage(50, "pulseGrenade", ::func_612B, ::func_612C, 0);
}

func_612B(var_0, var_1, var_2, var_3) {
  if(isDefined(self.triggerportableradarping) && var_0 != self.triggerportableradarping) {
    var_0 scripts\mp\killstreaks\_killstreaks::func_83A0();
    var_0 notify("destroyed_equipment");
  }

  scripts\mp\equipment\blackhat::func_2B2C();
  self.objective_position delete();
  self notify("detonateExplosive");
}

func_612C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleempdamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

func_40F3(var_0) {
  var_0 waittill("death");
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