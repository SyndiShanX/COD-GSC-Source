/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_trap_rnd.gsc
***********************************************/

func_9CC0(param_00) {
  var_01 = getEntArray(param_00.var_01A2, "targetname");
  level.var_9CC0 = var_01[0];
  level.var_9CC0.var_9C92 = param_00;
  level.var_9CC0.var_9CBB = param_00.var_0165;
  thread lib_0378::func_8D74("aud_trap_elec_start");
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.var_0165)) {
      continue;
    }

    if(var_03.var_0165 == "damage_over_time") {
      param_00 thread func_9CC2(var_03);
      param_00 thread func_9CC3(var_03);
      wait 0.05;
    }
  }

  thread func_9CC1(param_00);
}

func_9CC2(param_00) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_01 = 0;
  var_02 = 0.25;
  if(isDefined(self.var_817A)) {
    var_03 = self.var_817A;
  } else {
    var_03 = 20;
  }

  while(var_01 < var_03) {
    wait(var_02);
    var_01 = var_01 + var_02;
    foreach(var_05 in level.var_744A) {
      if(!var_05 istouching(param_00)) {
        continue;
      }

      var_05 thread func_35B1();
    }
  }
}

func_9CC3(param_00) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_01 = 0;
  var_02 = 0.15;
  if(isDefined(self.var_817A)) {
    var_03 = self.var_817A;
  } else {
    var_03 = 20;
  }

  while(var_01 < var_03) {
    wait(var_02);
    var_01 = var_01 + var_02;
    var_04 = lib_0547::func_408F();
    foreach(var_06 in var_04) {
      if(!isDefined(var_06) || !isalive(var_06)) {
        continue;
      }

      if(isPlayer(var_06)) {
        continue;
      }

      if(!var_06 istouching(param_00)) {
        continue;
      }

      maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_6FEE(var_06);
      var_06 lib_054D::func_099B("electroBuff", var_06 func_44B0(self.var_0117));
    }
  }
}

func_9CC1(param_00) {
  for(;;) {
    param_00 waittill("trap_state_change", var_01);
    if(var_01 == "cooldown" || var_01 == "no_power" || var_01 == "deactivate") {}
  }
}

func_44B0(param_00) {
  var_01 = lib_054D::func_443F("electroBuff");
  if(!isDefined(var_01)) {
    var_01 = func_9048();
  }

  if(isDefined(self.var_0A4B) && self.var_0A4B == "zombie_heavy") {
    var_01.var_29D5 = 600 * lib_054D::func_4441();
  }

  var_01.var_5CC8 = 0.2;
  var_01.var_721C = param_00;
  return var_01;
}

func_9048() {
  var_00 = spawnStruct();
  var_00.var_1CF2 = ::func_A10B;
  var_00.var_1CF0 = ::func_7CD9;
  var_00.var_5CC8 = 0.2;
  var_00.var_29D5 = 60 * lib_054D::func_4441();
  var_00.var_90F0 = 0.6;
  self notify("speed_debuffs_changed");
  return var_00;
}

func_A10B(param_00) {
  if(lib_0547::func_580A()) {
    self dodamage(param_00.var_29D5 * 0.25, self.var_0116, level.var_9CC0, level.var_9CC0, "MOD_ENERGY", "trap_zm_mp");
    return;
  }

  self dodamage(param_00.var_29D5, self.var_0116, level.var_9CC0, level.var_9CC0, "MOD_ENERGY", "trap_zm_mp");
  if(!isDefined(self.hitbytrap)) {
    foreach(var_02 in level.var_744A) {
      var_02 maps\mp\gametypes\zombies::func_47C7("kill_trap");
      self.hitbytrap = 1;
    }
  }
}

func_7CD9(param_00) {
  self notify("speed_debuffs_changed");
}

func_35B1() {}