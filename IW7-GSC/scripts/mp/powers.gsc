/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\powers.gsc
*********************************/

init() {
  level.powers = [];
  level.var_D786 = [];
  level.var_D79B = [];
  level.var_D7A4 = [];
  thread scripts\cp\zombies\_powerup_ability::powershud_init();
  func_D77D();
  func_D780();
  powersetupfunctions("power_siegeMode", undefined, ::func_12D2C, ::func_130D5, "powers_siegemode_update", undefined, undefined);
  powersetupfunctions("power_dash", ::func_F6B1, ::func_12C9F, ::func_13072, undefined, undefined, undefined);
  powersetupfunctions("power_opticWave", ::func_F7C8, ::func_12CFB, ::func_130B4, undefined, undefined, undefined);
  powersetupfunctions("power_overCharge", ::func_F7CC, ::func_12CFD, ::useovercharge, "power_overCharge_update", undefined, "removeOvercharge");
  powersetupfunctions("power_comlink", ::func_F69C, ::unsetcomlink, ::func_13055, undefined, undefined, undefined);
  powersetupfunctions("power_c4", ::func_F677, undefined, undefined, "c4_update", undefined, undefined);
  powersetupfunctions("power_bouncingBetty", undefined, undefined, undefined, "bouncing_betty_update", undefined, undefined);
  powersetupfunctions("power_throwingReap", ::func_F7EB, ::func_12D0D, undefined, undefined, undefined, undefined);
  powersetupfunctions("power_transponder", undefined, undefined, undefined, "transponder_update", "powers_transponder_used", undefined);
  powersetupfunctions("power_sonicSensor", undefined, undefined, undefined, "sonic_sensor_update", undefined, undefined);
  powersetupfunctions("power_barrier", ::func_F658, ::func_12C78, ::func_13049, undefined, "powers_barrier_used", undefined);
  powersetupfunctions("power_mortarMount", ::func_F7A5, ::func_12CF3, ::func_130A5, undefined, "powers_mortarMount_used", undefined);
  powersetupfunctions("power_tripMine", undefined, undefined, undefined, "trip_mine_update", undefined, undefined);
  powersetupfunctions("power_adrenaline", ::func_F62E, ::func_12C67, ::useadrenaline, "power_adrenaline_update", undefined, "removeAdrenaline");
  powersetupfunctions("power_multiVisor", ::func_F7AB, ::func_12CF6, ::func_130A7, "power_multi_visor_update", undefined, undefined);
  powersetupfunctions("power_trophy", ::func_F899, ::func_12D52, undefined, "trophy_update", undefined, undefined);
  powersetupfunctions("power_stealthMode", ::func_F861, ::func_12D38, ::func_130E0, "powers_stealth_mode_update", undefined, undefined);
  powersetupfunctions("power_disruptor", undefined, undefined, undefined, undefined, undefined, undefined);
  powersetupfunctions("power_pulseGrenade", undefined, undefined, undefined, undefined, undefined, undefined);
  powersetupfunctions("power_niagara", ::func_F7B5, ::func_12CF7, ::func_130AA, "powers_niagara_update", undefined, undefined);
  powersetupfunctions("power_distortionField", undefined, undefined, undefined, undefined, undefined, undefined);
  powersetupfunctions("power_fearGrenade", undefined, undefined, undefined, "restart_fear_grenade_cooldown", undefined, undefined);
  powersetupfunctions("power_explodingDrone", ::func_F6EF, ::func_12CAF, ::func_13085, "exploding_drone_update", undefined, undefined);
  powersetupfunctions("power_cryoMine", undefined, undefined, undefined, "cryo_mine_update", undefined, undefined);
  powersetupfunctions("power_coneFlash", ::func_F69E, ::unsetcooldown, ::func_13057, undefined, undefined, undefined);
  powersetupfunctions("power_blackhat", ::func_F664, ::func_12C80, ::func_1304D, undefined, "powers_blackhat_used", undefined);
  powersetupfunctions("power_periphVis", undefined, ::func_12D03, ::usepercent, "periphVis_update", undefined, undefined);
  powersetupfunctions("power_deployableCover", undefined, undefined, undefined, undefined, undefined, undefined);
  powersetupfunctions("power_blackholeGrenade", undefined, undefined, undefined, undefined, undefined, undefined);
  powersetupfunctions("power_shardBall", undefined, undefined, undefined, undefined, "powers_shardBall_used", undefined);
  powersetupfunctions("power_wristRocket", ::func_FB22, ::func_12D6A, undefined, undefined, undefined, undefined);
  thread scripts\mp\equipment\ground_pound::init();
  thread scripts\mp\equipment\adrenaline::init();
  thread scripts\mp\equipment\exploding_drone::func_69D5();
  thread scripts\mp\equipment\deployable_cover::func_5223();
  thread scripts\mp\equipment\wrist_rocket::wristrocketinit();
  thread scripts\mp\blackholegrenade::blackholegrenadeinit();
  thread scripts\mp\equipment\split_grenade::init();
  thread scripts\mp\equipment\spider_grenade::spidergrenade_init();
  thread scripts\mp\trophy_system::func_12813();
  thread scripts\mp\domeshield::domeshield_init();
  thread scripts\mp\powers\blink_knife::blinkknifeinit();
}

func_D724(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = spawnStruct();
  var_09.var_130F3 = param_01;
  var_09.weaponuse = param_02;
  var_09.cooldowntime = param_04;
  var_09.id = param_03;
  var_09.maxcharges = param_05;
  var_09.var_4E5A = param_06;
  var_09.var_13058 = param_07;
  var_09.var_12B2B = param_08;
  if(var_09.var_12B2B == "interact") {
    var_09.var_12B2B = "charges";
  }

  level.powers[param_00] = var_09;
}

func_D77D() {
  var_00 = 1;
  for(;;) {
    var_01 = tablelookupbyrow("mp\powertable.csv", var_00, 0);
    if(var_01 == "") {
      break;
    }

    var_02 = tablelookupbyrow("mp\powertable.csv", var_00, 1);
    var_03 = tablelookupbyrow("mp\powertable.csv", var_00, 6);
    var_04 = tablelookupbyrow("mp\powertable.csv", var_00, 7);
    var_05 = tablelookupbyrow("mp\powertable.csv", var_00, 8);
    var_06 = tablelookupbyrow("mp\powertable.csv", var_00, 9);
    var_07 = tablelookupbyrow("mp\powertable.csv", var_00, 10);
    var_08 = tablelookupbyrow("mp\powertable.csv", var_00, 11);
    var_09 = tablelookupbyrow("mp\powertable.csv", var_00, 15);
    func_D724(var_02, var_03, var_04, int(var_01), float(var_05), int(var_06), int(var_07), int(var_08), var_09);
    if(isDefined(level.var_D7A4[var_04]) && var_04 != "<power_script_generic_weapon>") {
      switch (var_04) {
        default:
          break;
      }
    }

    level.var_D7A4[var_04] = var_02;
    var_00++;
  }
}

func_D780() {
  if(!isDefined(level.var_D77F)) {
    level.var_D77F = [];
  }

  var_00 = 0;
  for(;;) {
    var_01 = tablelookupbyrow("mp\powerpassivetable.csv", var_00, 0);
    if(var_01 == "") {
      break;
    }

    var_02 = tablelookupbyrow("mp\powerpassivetable.csv", var_00, 1);
    var_03 = tablelookupbyrow("mp\powerpassivetable.csv", var_00, 2);
    var_04 = tablelookupbyrow("mp\powerpassivetable.csv", var_00, 3);
    var_05 = spawnStruct();
    if(var_04 != "") {
      var_05.var_23B1 = var_04;
      level.var_D7A4[var_04] = var_02;
    }

    if(!isDefined(level.var_D77F[var_02])) {
      level.var_D77F[var_02] = [];
    }

    var_06 = level.var_D77F[var_02];
    if(!isDefined(var_06[var_03])) {
      var_06[var_03] = var_05;
      level.var_D77F[var_02] = var_06;
    }

    var_00++;
  }
}

_meth_8091(param_00, param_01) {
  if(!isDefined(level.var_D77F[param_00])) {
    return undefined;
  }

  var_02 = level.var_D77F[param_00];
  if(!isDefined(var_02[param_01])) {
    return undefined;
  }

  return var_02[param_01];
}

_meth_8090(param_00) {
  if(!isDefined(self.powers[param_00])) {
    return undefined;
  }

  var_01 = self.powers[param_00];
  var_02 = getdvar("scr_debug_power_passive");
  if(isDefined(var_02)) {
    var_03 = _meth_8091(param_00, var_02);
    if(isDefined(var_03)) {
      if(isDefined(var_03.var_23B1)) {
        return var_03.var_23B1;
      }
    }
  }

  foreach(var_05 in var_01.passives) {
    var_03 = _meth_8091(param_00, var_05);
    if(!isDefined(var_03)) {
      continue;
    }

    if(isDefined(var_03.var_23B1)) {
      return var_03.var_23B1;
    }
  }

  return undefined;
}

powersetupfunctions(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = level.powers[param_00];
  if(!isDefined(var_07)) {
    scripts\engine\utility::error("No configuration data for " + param_00 + " found! Is it in powertable.csv? Or make sure powerSetupFunctions is called after the table is initialized.");
  }

  level.var_D786[param_00] = param_01;
  level.var_D79B[param_00] = param_02;
  if(isDefined(param_03)) {
    var_07.usefunc = param_03;
  }

  if(isDefined(param_04)) {
    var_07.var_12ED9 = param_04;
  }

  if(isDefined(param_05)) {
    var_07.usednotify = param_05;
  }

  if(isDefined(param_06)) {
    var_07.var_9A90 = param_06;
  }
}

func_D750(param_00, param_01) {
  var_02 = getcurrentequipment(param_00);
  var_03 = self.powers[var_02];
  var_04 = level.powers[var_02];
  var_05 = var_03.var_91B1;
  var_06 = var_03.charges;
  if(isDefined(var_05) && var_05 == param_01) {
    return;
  }

  if(isDefined(var_05)) {
    func_D75E(param_00);
  }

  switch (param_01) {
    case 0:
      scripts\cp\zombies\_powerup_ability::powershud_beginpowerdrain(param_00);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowermeter(param_00, 1);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(param_00, var_06);
      thread func_D76E(var_02);
      break;

    case 1:
      scripts\cp\zombies\_powerup_ability::powershud_beginpowercooldown(param_00, 0);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(param_00, var_06);
      thread func_D76D(var_02);
      break;

    case 2:
      scripts\cp\zombies\_powerup_ability::powershud_updatepowerdisabled(param_00, 0);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowermeter(param_00, 1);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(param_00, var_06);
      thread func_D76C(var_02);
      break;

    case 3:
      break;
  }

  var_03.var_91B1 = param_01;
  thread func_D75F(param_00);
}

func_D75E(param_00) {
  var_01 = getcurrentequipment(param_00);
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = self.powers[var_01];
  var_03 = var_02.var_91B1;
  if(!isDefined(var_03)) {
    return;
  }

  switch (var_03) {
    case "unavailable":
      break;

    case 0:
      scripts\cp\zombies\_powerup_ability::powershud_endpowerdrain(param_00);
      break;

    case 2:
      break;

    case 1:
      scripts\cp\zombies\_powerup_ability::powershud_finishpowercooldown(param_00, 0);
      break;
  }

  var_02.var_91B1 = undefined;
}

func_D75F(param_00) {
  self endon("disconnect");
  self notify("power_unsetHudStateOnRemoved_" + param_00);
  self endon("power_unsetHudStateOnRemoved_" + param_00);
  var_01 = getcurrentequipment(param_00);
  self waittill("power_removed_" + var_01);
  func_D75E(param_00);
}

givepower(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 2;
  if(!isDefined(self.powers)) {
    self.powers = [];
  }

  if(param_00 == "none") {
    return;
  }

  if(param_01 == "scripted") {
    var_05++;
  }

  func_D725(param_00, param_01, param_04);
  var_06 = self.powers[param_00];
  var_07 = level.powers[param_00];
  scripts\cp\zombies\_powerup_ability::powershud_updatepowermaxcharges(var_06.slot, var_06.maxcharges);
  if(isDefined(param_03)) {
    var_06.passives = param_03;
  }

  var_0B = 0;
  if(isDefined(self.var_D76F) && isDefined(self.var_D76F[param_00])) {
    var_0C = self.var_D76F[param_00];
    var_0D = func_D720(var_0C);
    if(var_0D > 0) {
      var_0E = var_06.charges * var_07.cooldowntime;
      var_06.charges = int(var_0E - var_0D / var_07.cooldowntime);
      if(var_06.charges < 0) {
        var_06.charges = 0;
      }

      var_0B = var_0D;
      while(var_0B > var_07.cooldowntime) {
        var_0B = var_0B - var_07.cooldowntime;
      }
    }
  }

  if(param_01 == "scripted") {
    return;
  }

  var_06.weaponuse = undefined;
  if(var_07.weaponuse == "<power_script_generic_weapon>") {
    var_06.weaponuse = scripts\engine\utility::ter_op(param_01 == "primary", "power_script_generic_primary_mp", "power_script_generic_secondary_mp");
  } else {
    var_06.weaponuse = var_07.weaponuse;
  }

  var_0F = _meth_8090(param_00);
  var_10 = scripts\engine\utility::ter_op(isDefined(var_0F), var_0F, var_06.weaponuse);
  var_06.weaponuse = var_10;
  scripts\mp\utility::_giveweapon(var_10, 0);
  self setweaponammoclip(var_10, var_06.charges);
  if(var_06.slot == "primary") {
    self assignweaponoffhandprimary(var_10);
    self.powerprimarygrenade = var_10;
  } else if(var_06.slot == "secondary") {
    self assignweaponoffhandsecondary(var_10);
    self.powersecondarygrenade = var_10;
  }

  if(isDefined(level.var_D786[param_00])) {
    self[[level.var_D786[param_00]]](param_00);
  }

  thread func_D73D(param_00);
  thread func_B2F0(var_07, param_00, var_06.slot, var_07.cooldowntime, var_07.var_12ED9, var_07.usednotify, var_10, var_0B, param_02);
}

removepower(param_00) {
  if(isDefined(level.var_D79B[param_00])) {
    self[[level.var_D79B[param_00]]]();
  }

  if(isDefined(self.powers[param_00].weaponuse)) {
    scripts\mp\utility::_takeweapon(self.powers[param_00].weaponuse);
  }

  if(self.powers[param_00].slot == "primary") {
    self _meth_844D();
    self.powerprimarygrenade = undefined;
  } else if(self.powers[param_00].slot == "secondary") {
    self gonevo();
    self.powersecondarygrenade = undefined;
  }

  self notify("power_removed_" + param_00);
  scripts\cp\zombies\_powerup_ability::powershud_clearpower(self.powers[param_00].slot);
  self.powers[param_00] = undefined;
}

func_110C2() {
  if(isDefined(self.powers)) {
    if(!isDefined(self.var_D76F)) {
      self.var_D76F = [];
    } else {
      func_4042();
    }

    foreach(var_03, var_01 in self.powers) {
      if(isDefined(level.var_C81F) && level.var_C81F == 1) {
        continue;
      } else if(isDefined(level.var_C81F) && level.var_C81F != 0) {
        if(level.powers[var_03].var_4E5A == 1) {
          continue;
        }
      } else if(!isDefined(level.var_C81F)) {
        if(level.powers[var_03].var_4E5A == 1) {
          continue;
        }
      }

      if(var_01.var_4619 > 0) {
        var_02 = spawnStruct();
        var_02.power = var_03;
        var_02.var_4619 = var_01.var_4619;
        var_02.charges = var_01.charges;
        var_02.maxcharges = var_01.maxcharges;
        var_02.var_4E5A = var_01.var_4E5A;
        var_02.var_11931 = gettime();
        self.var_D76F[var_03] = var_02;
      }
    }
  }
}

func_4042() {
  if(isDefined(self.var_D76F) && self.var_D76F.size > 0) {
    var_00 = self.var_D76F;
    foreach(var_03, var_02 in var_00) {
      if(func_D720(var_02) == 0) {
        self.var_D76F[var_03] = undefined;
      }
    }
  }
}

func_D720(param_00) {
  var_01 = level.powers[param_00.power];
  var_02 = param_00.maxcharges - param_00.charges * var_01.cooldowntime - var_01.cooldowntime - param_00.var_4619;
  var_03 = gettime() - param_00.var_11931 / 1000;
  return max(0, var_02 - var_03);
}

clearpowers() {
  self notify("powers_cleanUp");
  if(isDefined(self.powers)) {
    var_00 = self.powers;
    foreach(var_03, var_02 in var_00) {
      removepower(var_03);
    }

    self.powers = [];
  }
}

getcurrentequipment(param_00) {
  if(!isDefined(self.powers)) {
    return undefined;
  }

  foreach(var_03, var_02 in self.powers) {
    if(var_02.slot == param_00) {
      return var_03;
    }
  }

  return undefined;
}

func_E265() {
  if(!isDefined(self) || !isDefined(self.powers)) {
    return;
  }

  foreach(var_04, var_01 in self.powers) {
    var_02 = var_01.charges;
    var_03 = var_01.maxcharges;
    if(var_02 != var_03) {
      self.powers[var_04].charges = self.powers[var_04].maxcharges;
      func_D765(var_04);
      self notify("power_charges_adjusted_" + var_04, self.powers[var_04].charges);
    }
  }
}

func_1813(param_00) {
  if(!isDefined(self) || !isDefined(self.powers)) {
    return;
  }

  foreach(var_07, var_02 in self.powers) {
    var_03 = var_02.charges;
    var_04 = var_02.maxcharges;
    var_05 = var_03 + param_00;
    if(var_05 > var_04) {
      var_05 = var_04;
    }

    var_06 = var_05 - var_03;
    if(var_06 > 0) {
      self.powers[var_07].charges = var_05;
      func_D765(var_07);
      self notify("power_charges_adjusted_" + var_07, self.powers[var_07].charges);
    }
  }
}

func_D735(param_00) {
  return scripts\engine\utility::ter_op(self.powers[param_00].slot == "primary", "+frag", "+smoke");
}

func_D734(param_00) {
  return self.powers[param_00].charges;
}

func_D736(param_00) {
  return self.powers[param_00].maxcharges;
}

func_D737(param_00) {
  return level.var_D7A4[param_00];
}

func_D738(param_00) {
  if(!isDefined(param_00) || !isDefined(level.powers[param_00]) || param_00 == "none") {
    return 0;
  }

  return level.powers[param_00].id;
}

func_D725(param_00, param_01, param_02) {
  var_03 = level.powers[param_00];
  var_04 = spawnStruct();
  var_04.slot = param_01;
  var_04.charges = var_03.maxcharges;
  if(scripts\mp\utility::istrue(param_02)) {
    var_04.charges++;
  }

  var_04.maxcharges = var_04.charges;
  var_04.var_93DD = 0;
  var_04.var_19 = 0;
  var_04.var_4619 = 0;
  var_04.cooldownratemod = 1;
  var_04.passives = [];
  self.powers[param_00] = var_04;
}

func_B2F0(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + param_01);
  if((isDefined(param_08) && param_08) || param_01 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  scripts\cp\zombies\_powerup_ability::powershud_assignpower(param_02, int(param_00.id), 1, int(self.powers[param_01].charges));
  scripts\mp\utility::gameflagwait("prematch_done");
  param_03 = scripts\mp\powerloot::func_7FBF(param_01, param_03);
  func_D750(param_02, 2);
  scripts\cp\zombies\_powerup_ability::powershud_updatepoweroffcooldown(param_02, 0);
  self notify("power_available", param_01, param_02);
  thread scripts\mp\weapons::func_13AB5(self, param_01, param_02);
  for(;;) {
    func_D765(param_01);
    var_09 = param_06 + "_success";
    thread func_13A0E(param_03, param_01, var_09, param_02);
    var_0A = scripts\engine\utility::ter_op(param_00.var_130F3 == "weapon_hold", "offhand_pullback", "offhand_fired");
    if(param_00.var_130F3 == "weapon_hold") {
      self waittill(var_0A, var_0B);
      if(var_0B != param_06) {
        continue;
      }
    } else if(!func_D76B(param_06)) {
      continue;
    }

    self notify("power_activated", param_01, param_02);
    scripts\mp\utility::printgameaction("power used - " + param_01, self);
    self notify(var_09);
    var_0C = undefined;
    if(isDefined(param_00.usefunc)) {
      var_0C = self thread[[param_00.usefunc]]();
      if(isDefined(var_0C) && var_0C == 0) {
        continue;
      }
    }

    if(isDefined(param_05)) {
      self waittill(param_05, var_0C);
      if(isDefined(var_0C) && var_0C == 0) {
        continue;
      }
    }

    scripts\mp\gamelogic::sethasdonecombat(self, 1);
    scripts\mp\analyticslog::logevent_powerused(param_01, "unused");
    power_adjustcharges(-1, self.powers[param_01].slot);
    combatrecordpoweruse(param_01);
    if(isDefined(param_04) && level.powers[param_01].var_12B2B == "drain" && !scripts\mp\utility::istrue(self.powers[param_01].var_940B)) {
      func_D72B(param_01);
    }

    thread func_D72A(param_01, param_03, param_08, param_02);
  }
}

func_D73F(param_00) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + param_00);
  var_01 = self.powers[param_00];
  var_02 = level.powers[param_00];
  for(;;) {
    self waittill("scavenged_ammo", var_03);
    if(var_01.weaponuse == var_03) {
      var_04 = var_02.cooldowntime;
      func_D74F(param_00, var_04);
    }
  }
}

func_D74C(param_00) {
  if(hasequipment(param_00)) {
    var_01 = self.powers[param_00];
    func_D71B(1, param_00);
    func_D765(param_00);
    var_02 = var_01.var_91B1;
    if(isDefined(var_02) && var_02 == 1) {
      func_D750(var_01.slot, 2);
    }
  }
}

func_D73D(param_00) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + param_00);
  var_01 = self.powers[param_00];
  var_02 = var_01.weaponuse;
  var_03 = var_01.slot;
  for(;;) {
    self waittill("scavenged_ammo", var_04);
    if(var_04 == var_02) {
      func_D74C(param_00);
    }
  }
}

func_EBD4(param_00) {
  param_00 func_D74C("power_throwingKnife");
  param_00 func_D74C("power_blinkKnife");
  param_00 func_D74C("power_bioSpike");
}

func_D74F(param_00, param_01) {
  var_02 = self.powers[param_00];
  var_03 = level.powers[param_00];
  var_02.var_4617 = min(param_01, var_03.cooldowntime);
  var_02.var_4619 = var_03.cooldowntime - param_01;
  if(var_02.var_4619 <= 0) {
    self notify("finish_power_cooldown_" + param_00);
  }
}

func_D752(param_00, param_01) {
  if(param_01 scripts\mp\utility::_hasperk("specialty_powercell")) {
    return 1;
  }

  if(level.powers[param_00].var_13058) {
    return 1;
  }

  return 0;
}

func_D72A(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + param_00);
  self endon("power_cooldown_ended" + param_00);
  if((isDefined(param_02) && param_02) || param_00 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self notify("power_cooldown_begin_" + param_00);
  self endon("power_cooldown_begin_" + param_00);
  var_04 = level.powers[param_00];
  var_05 = self.powers[param_00];
  param_03 = var_05.slot;
  var_06 = param_00 + "_cooldown_update";
  var_05.var_93DD = 1;
  if(!isDefined(var_05.var_461C)) {
    var_05.var_461C = 0;
  }

  var_05.var_461C++;
  if(!isDefined(var_05.var_4617)) {
    var_05.var_4617 = 0;
  }

  if(!isDefined(var_05.var_4619)) {
    var_05.var_4619 = 0;
  }

  var_05.var_4619 = var_05.var_4619 + param_01;
  var_07 = var_05.var_91B1;
  if(isDefined(var_07) && var_07 != 0 && var_05.charges == 0) {
    func_D750(param_03, 1);
    self notify("power_unavailable", param_00, param_03);
  }

  while(var_05.charges < var_05.maxcharges) {
    if(func_D752(param_00, self)) {
      wait(0.1);
    } else {
      self waittill("power_charges_adjusted_" + param_00);
    }

    if(var_05.var_4617 > param_01) {
      power_adjustcharges(1, param_03);
      func_D765(param_00);
      if(var_05.charges == var_05.maxcharges) {
        thread func_D730(param_00, param_02);
      }

      var_05.var_4617 = var_05.var_4617 - param_01;
      var_05.var_4619 = var_05.var_4619 - param_01;
      var_05.var_461C--;
      if(isDefined(var_07) && var_07 != 0) {
        func_D750(param_03, 2);
      }
    } else {
      var_05.var_4617 = var_05.var_4617 + 0.1;
      var_05.var_4619 = var_05.var_4619 - 0.1;
    }

    var_08 = min(1, var_05.var_4617 / param_01);
    self notify(var_06, var_08);
  }

  thread func_D730(param_00, param_02);
}

func_D730(param_00, param_01) {
  self notify("power_cooldown_ended" + param_00);
  var_02 = self.powers[param_00];
  var_02.var_93DD = 0;
  var_02.var_4617 = 0;
  var_02.var_4619 = 0;
  var_02.var_461C = 0;
  if(isDefined(param_01) && param_01) {
    self notify("copycat_reset");
  }

  var_03 = var_02.var_91B1;
  var_04 = var_02.slot;
  if(var_03 == 0) {
    return;
  }

  func_D750(var_04, 2);
}

func_D72B(param_00) {
  self endon("death");
  self endon("power_drain_ended_" + param_00);
  self notify("power_cooldown_ended_" + param_00);
  var_01 = level.powers[param_00];
  var_02 = self.powers[param_00];
  var_03 = var_01.var_12ED9;
  var_04 = var_01.var_9A90;
  var_05 = var_02.slot;
  var_02.var_940B = 1;
  func_D727(param_00);
  func_D750(var_05, 0);
  if(isDefined(var_04)) {
    thread func_D732(param_00, var_05, var_04);
  }

  for(;;) {
    self waittill(var_03, var_06);
    if(var_06 == 0) {
      break;
    }
  }

  thread func_D731(param_00);
}

func_D732(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + param_00);
  self endon("power_drain_ended_" + param_00);
  self waittill(param_02);
  thread func_D731(param_00);
}

func_D731(param_00) {
  self notify("power_drain_ended_" + param_00);
  var_01 = self.powers[param_00];
  var_02 = var_01.slot;
  var_01.var_940B = 0;
  func_D72D(param_00);
  if(var_01.charges > 0) {
    func_D750(var_02, 2);
    return;
  }

  func_D750(var_02, 1);
}

func_12D2C() {}

func_130D5() {}

func_F676(param_00) {
  level.powers[param_00].var_4620 = "multi_use";
}

func_12C89() {}

func_13051() {
  scripts\mp\bulletstorm::func_10D76();
}

func_F6B1(param_00) {}

func_12C9F() {
  scripts\mp\equipment\dash::func_E0E9();
}

func_13072() {
  return scripts\mp\equipment\dash::func_4D90();
}

func_F7C8(param_00) {}

func_12CFB() {
  scripts\mp\equipment\optic_wave::func_E145();
}

func_130B4() {
  scripts\mp\equipment\optic_wave::func_C6AF();
}

func_F7E7(param_00) {}

func_12D0B() {
  scripts\mp\equipment\phase_split::func_CABB();
}

usephasesplit() {
  return scripts\mp\equipment\phase_split::func_CAC2();
}

func_F6EF(param_00) {
  scripts\mp\equipment\exploding_drone::func_69D0(param_00);
}

func_12CAF() {
  scripts\mp\equipment\exploding_drone::func_69D3();
}

func_13085() {}

func_F7CC(param_00) {}

func_12CFD() {
  scripts\mp\equipment\overcharge::func_E14C();
}

useovercharge() {
  scripts\mp\equipment\overcharge::useovercharge();
}

func_F84A(param_00) {}

func_12D30() {
  scripts\mp\equipment\smoke_wall::func_E16E();
}

func_130D7() {
  scripts\mp\equipment\smoke_wall::func_1037D();
}

func_F69C(param_00) {}

unsetcomlink(param_00) {
  scripts\mp\equipment\commlink::func_E0E0();
}

func_13055() {
  scripts\mp\equipment\commlink::setturrettargetent();
}

func_F87F(param_00) {
  scripts\mp\equipment\telereap::_meth_83B2();
}

func_12D45() {
  scripts\mp\equipment\telereap::removethinker();
}

func_130E8() {
  var_00 = scripts\mp\equipment\telereap::func_130E8();
  return var_00;
}

func_F844(param_00) {}

func_12D2B() {
  scripts\mp\phaseshift::func_E169();
}

func_130D4() {
  scripts\mp\phaseshift::func_D41C();
}

settransponder(param_00) {
  scripts\mp\equipment\transponder::func_F5D3();
}

unsettransponder() {
  scripts\mp\equipment\transponder::removetransponder();
}

func_130F0() {
  scripts\mp\equipment\transponder::transponder_use();
}

func_F7EB(param_00) {
  scripts\mp\equipment\plasma_spear::giveplayeraccessory();
}

func_12D0D() {
  scripts\mp\equipment\plasma_spear::func_E158();
}

setheadgear(param_00) {
  level.powers[param_00].var_5FF3 = 30;
  level.var_8C74 = 0.8;
}

unsetheadgear() {}

func_1308F() {
  scripts\mp\equipment\headgear::func_E855();
}

func_F658(param_00) {
  level.powers[param_00].var_5FF3 = 30;
}

func_12C78() {}

func_13049() {
  scripts\mp\equipment\barrier::func_E83A();
}

func_F659(param_00) {}

func_12C79() {}

func_1304B() {
  scripts\mp\equipment\battery::func_E83B();
}

func_F7A5(param_00) {
  scripts\mp\equipment\mortar_mount::func_BB90();
}

func_12CF3() {
  scripts\mp\equipment\mortar_mount::func_BB93();
}

func_130A5() {
  scripts\mp\equipment\mortar_mount::func_BB94();
}

func_F62E(param_00) {}

func_12C67() {
  scripts\mp\equipment\adrenaline::removeadrenaline();
}

useadrenaline() {
  thread scripts\mp\equipment\adrenaline::useadrenaline();
}

func_F7AB(param_00) {
  scripts\mp\equipment\multi_visor::func_F7AB();
}

func_12CF6() {
  scripts\mp\equipment\multi_visor::func_E13F();
}

func_130A7() {
  scripts\mp\equipment\multi_visor::func_130A7();
}

func_F861(param_00) {
  scripts\mp\archetypes\archscout::func_F861();
}

func_12D38() {
  scripts\mp\archetypes\archscout::func_E175();
}

func_130E0() {
  scripts\mp\archetypes\archscout::func_130E0();
}

func_F7B5(param_00) {
  scripts\mp\equipment\niagara::func_BFC9();
}

func_12CF7() {
  scripts\mp\equipment\niagara::func_BFCA();
}

func_130AA() {
  scripts\mp\equipment\niagara::func_BFCB();
}

func_12D03() {
  scripts\mp\equipment\peripheral_vision::func_CA2B();
}

usepercent() {
  scripts\mp\equipment\peripheral_vision::func_CA2C();
}

func_F899(param_00) {
  scripts\mp\trophy_system::func_12820();
}

func_12D52() {
  scripts\mp\trophy_system::func_12825();
}

func_F677(param_00) {
  scripts\mp\equipment\c4::c4_set();
}

func_F69E(param_00) {
  scripts\mp\equipment\cone_flash::func_44FB();
}

unsetcooldown() {
  scripts\mp\equipment\cone_flash::func_44FD();
}

func_13057() {
  scripts\mp\equipment\cone_flash::func_44FF();
}

func_F664(param_00) {}

func_12C80() {
  scripts\mp\equipment\blackhat::func_E0D4();
}

func_1304D() {
  scripts\mp\equipment\blackhat::func_13073();
}

func_FB22(param_00) {
  scripts\mp\equipment\wrist_rocket::wristrocket_set();
}

func_12D6A() {
  scripts\mp\equipment\wrist_rocket::wristrocket_unset();
}

hasequipment(param_00) {
  if(!isDefined(self.powers[param_00])) {
    return 0;
  }

  return 1;
}

func_13709(param_00) {
  self endon("death");
  self endon("disconnect");
  if(param_00 == "primary") {
    var_01 = "power_primary_used";
  } else {
    var_01 = "power_secondary_used";
  }

  for(;;) {
    if(!isDefined(self)) {
      wait(1);
      break;
    }

    self waittill(var_01);
    break;
  }
}

power_modifycooldownrate(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "all";
  }

  var_02 = func_D739();
  foreach(var_04 in var_02) {
    if(self.powers[var_04].slot == param_01 || param_01 == "all") {
      self.powers[var_04].cooldownratemod = param_00;
    }
  }
}

func_D74E(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  var_01 = func_D739();
  foreach(var_03 in var_01) {
    if(self.powers[var_03].slot == param_00 || param_00 == "all") {
      self.powers[var_03].cooldownratemod = 1;
    }
  }
}

power_adjustcharges(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "all";
  }

  var_02 = func_D739();
  foreach(var_04 in var_02) {
    if(self.powers[var_04].slot == param_01 || param_01 == "all") {
      var_05 = self.powers[var_04].charges;
      var_06 = self.powers[var_04].maxcharges;
      var_07 = max(min(var_06, var_05 + param_00), 0);
      self.powers[var_04].charges = var_07;
      if(var_05 != var_07) {
        self notify("power_charges_adjusted_" + var_04, self.powers[var_04].charges);
      }
    }
  }
}

func_D71B(param_00, param_01) {
  power_adjustcharges(param_00, self.powers[param_01].slot);
}

func_D739() {
  var_00 = getarraykeys(level.powers);
  var_01 = getarraykeys(self.powers);
  var_02 = [];
  var_03 = 0;
  foreach(var_05 in var_01) {
    foreach(var_07 in var_00) {
      if(var_05 == var_07) {
        var_02[var_03] = var_05;
        var_03 = var_03 + 1;
        break;
      }
    }
  }

  return var_02;
}

func_D729() {
  scripts\engine\utility::allow_offhand_weapons(0);
}

func_D72F() {
  scripts\engine\utility::allow_offhand_weapons(1);
}

usequickslothealitem(param_00) {
  scripts\mp\utility::_giveweapon(param_00);
  scripts\mp\utility::_switchtoweapon(param_00);
  wait(1);
  scripts\mp\utility::_switchtoweapon(param_00);
  scripts\mp\utility::_takeweapon(param_00);
}

func_50A4(param_00) {
  if(!isDefined(self.var_D775)) {
    self.var_D775 = [];
  }

  if(!isDefined(self.var_D775[param_00])) {
    self.var_D775[param_00] = 0;
  }
}

damageconetrace(param_00) {
  func_50A4(param_00);
  return self.var_D775[param_00];
}

func_F809(param_00, param_01) {
  func_50A4(param_00);
  self.var_D775[param_00] = param_01;
}

func_4575(param_00, param_01, param_02) {
  self endon("death");
  self endon("disconnect");
  self endon("cancel_" + param_01);
  if(isDefined(param_02)) {
    self endon(param_02);
  }

  param_00 = param_00 * 1000;
  var_03 = 1 / param_00;
  var_04 = gettime();
  func_F809(param_01, param_00);
  var_05 = damageconetrace(param_01);
  while(var_05 > 0) {
    func_C170(param_01, var_05 * var_03);
    wait(0.1);
    var_05 = damageconetrace(param_01);
    var_06 = gettime();
    var_05 = var_05 - var_06 - var_04;
    var_04 = var_06;
    func_F809(param_01, var_05);
  }

  func_C170(param_01, 0);
}

func_3885(param_00) {
  func_F809(param_00, 0);
  self notify("cancel_" + param_00);
  func_C170(param_00, 0);
}

func_C170(param_00, param_01) {
  self notify(param_00, param_01);
}

func_13A0E(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + param_01);
  self endon(param_02);
  level endon("game_ended");
  self waittill("offhand_fired", var_04);
  var_05 = self.powers[param_01];
  if(isDefined(var_04) && var_04 == var_05.weaponuse) {
    if(!isalive(self)) {
      if(var_05.charges > 0) {
        scripts\mp\analyticslog::logevent_powerused(param_01, "unused");
        power_adjustcharges(-1, var_05.slot);
      }

      if(!var_05.var_93DD) {
        var_05.var_4619 = level.powers[param_01].cooldowntime;
        thread func_D72A(param_01, param_00, undefined, param_03);
        return;
      }
    }
  }
}

func_136DD(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    thread func_13A68(param_00, param_02);
  }

  thread func_13A7D(param_00, param_01);
  self waittill("power_use_update_" + param_00, var_03);
  return var_03;
}

func_13A68(param_00, param_01) {
  self endon("power_use_update_" + param_00);
  for(;;) {
    self waittill("scavenged_ammo", var_02);
    if(var_02 == param_01) {
      self notify("power_use_update_" + param_00);
      return;
    }
  }
}

func_13A7D(param_00, param_01) {
  self endon("power_use_update_" + param_00);
  self waittill(param_01, var_02);
  self notify("power_use_update_" + param_00, var_02);
}

func_D767(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  param_02 = param_02 - 1;
  var_05 = 0;
  var_06 = 0.05;
  var_07 = func_D735(param_00);
  var_08 = undefined;
  var_09 = param_03;
  for(;;) {
    if(!func_9F09(var_07)) {
      break;
    }

    if(func_9F09(var_07)) {
      while(func_9F09(var_07)) {
        if(self usebuttonpressed()) {
          if(var_05 == 0) {
            var_06 = 0.05;
          }

          var_0A = 0;
          while(self usebuttonpressed()) {
            var_0A = var_0A + 0.05;
            if(var_0A >= var_06) {
              param_01 = func_93FD(param_01, param_02, param_03);
              var_05 = 1;
              var_0A = 0;
              var_06 = 0.7;
              var_04 = 1;
              self[[var_09]](param_01);
              break;
            }

            wait(0.05);
          }
        }

        wait(0.05);
        if(self usebuttonpressed() == 0) {
          var_05 = 0;
          break;
        }
      }
    }

    wait(0.05);
  }

  if(!var_04) {
    if(param_01 == param_02) {
      param_01 = 0;
    } else {
      param_01++;
    }

    self[[var_09]](param_01);
  }

  return param_01;
}

func_9F09(param_00) {
  if((param_00 == "+frag" && self fragbuttonpressed()) || param_00 == "+smoke" && self secondaryoffhandbuttonpressed()) {
    return 1;
  }

  return 0;
}

func_D769(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(param_01)) {
    param_01 = 2000;
  } else {
    param_01 = param_01 * 1000;
  }

  var_02 = func_D735(param_00);
  var_03 = gettime();
  var_04 = var_03 + param_01;
  while(func_9F09(var_02) && gettime() < var_04) {
    wait(0.05);
  }

  return gettime() - var_03 / 1000;
}

func_93FD(param_00, param_01, param_02) {
  if(param_00 < param_01) {
    param_00++;
  } else {
    param_00 = 0;
  }

  return param_00;
}

func_C179() {
  if(!isDefined(self.weapon_name)) {
    return;
  }

  switch (self.weapon_name) {
    case "bouncingbetty_mp":
      self.triggerportableradarping notify("bouncing_betty_update", 0);
      break;

    case "transponder_mp":
      self.triggerportableradarping notify("transponder_update", 0);
      break;

    case "trip_mine_mp":
      self.triggerportableradarping notify("trip_mine_update", 0);
      break;

    case "sonic_sensor_mp":
      self.triggerportableradarping notify("sonic_sensor_update", 0);
      break;

    case "trophy_mp":
      self.triggerportableradarping notify("trophy_update", 0);
      break;

    case "fear_grenade_mp":
      self.triggerportableradarping notify("restart_fear_grenade_cooldown", 0);
      break;

    case "cryo_mine":
      self.triggerportableradarping notify("cryo_mine_update", 0);
      break;

    case "micro_turret_mp":
      self.triggerportableradarping notify("microTurret_update", 0);
      break;

    default:
      break;
  }
}

func_9F0A(param_00) {
  switch (param_00) {
    case "iw6_minigunsiege_mp":
    case "iw7_niagara_mp":
    case "armorup_mp":
      return 1;

    default:
      return 0;
  }
}

func_F808(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01 > 0) {
    func_4575(param_01, param_00);
    return;
  }

  func_3885(param_00);
}

func_D76C(param_00) {
  self endon("death");
  self endon("power_available_ended_" + param_00);
  var_01 = self.powers[param_00];
  var_02 = var_01.slot;
  for(;;) {
    self waittill("power_charges_adjusted_" + param_00, var_03);
    scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(var_02, var_03);
  }
}

func_D76E(param_00) {
  self endon("disconnect");
  self endon("power_removed_" + param_00);
  self endon("power_drain_ended_" + param_00);
  var_01 = self.powers[param_00];
  var_02 = level.powers[param_00];
  var_03 = var_01.slot;
  var_04 = var_02.var_12ED9;
  if(!isDefined(var_04)) {
    var_04 = param_00 + "_update";
  }

  for(;;) {
    self waittill(var_04, var_05);
    var_05 = max(0, min(1, var_05));
    scripts\cp\zombies\_powerup_ability::powershud_updatepowerdrainprogress(var_03, var_05);
  }
}

func_D76D(param_00) {
  self endon("disconnect");
  self endon("power_removed_" + param_00);
  self endon("power_cooldown_ended" + param_00);
  var_01 = self.powers[param_00];
  var_02 = level.powers[param_00];
  var_03 = var_01.slot;
  var_04 = param_00 + "_cooldown_update";
  for(;;) {
    self waittill(var_04, var_05);
    scripts\cp\zombies\_powerup_ability::powershud_updatepowercooldown(var_03, var_05);
  }
}

func_D76B(param_00) {
  var_01 = spawnStruct();
  childthread func_13A2C(param_00, var_01);
  childthread func_13A2D(param_00, var_01);
  self waittill("grenadeOffhandFiredRace_" + param_00 + "_begin");
  waittillframeend;
  self notify("grenadeOffhandFiredRace_" + param_00 + "_end");
  if(isDefined(var_01.enableworldup) && var_01.enableworldup == param_00) {
    return !isDefined(var_01.setonwallanimconditional);
  }

  if(isDefined(var_01.var_C336) && var_01.var_C336 == param_00) {
    return 1;
  }

  return 0;
}

func_13A2C(param_00, param_01) {
  self endon("grenadeOffhandFiredRace_" + param_00 + "_end");
  for(;;) {
    self waittill("grenade_fire", var_02, var_03, var_04, var_05);
    if(!scripts\mp\utility::func_85E0(var_02)) {
      continue;
    }

    param_01.enableworldup = var_03;
    param_01.setonwallanimconditional = var_05;
    break;
  }

  self notify("grenadeOffhandFiredRace_" + param_00 + "_begin");
}

func_13A2D(param_00, param_01) {
  self endon("grenadeOffhandFiredRace_" + param_00 + "_end");
  self waittill("offhand_fired", var_02);
  param_01.var_C336 = var_02;
  self notify("grenadeOffhandFiredRace_" + param_00 + "_begin");
}

func_D727(param_00) {
  var_01 = self.powers[param_00];
  if(!isDefined(var_01.var_55AB)) {
    var_01.var_55AB = 0;
  }

  var_01.var_55AB++;
  if(var_01.var_55AB == 1) {
    func_D765(param_00);
  }
}

func_D72D(param_00) {
  var_01 = self.powers[param_00];
  var_01.var_55AB--;
  if(var_01.var_55AB == 0) {
    func_D765(param_00);
  }
}

func_D71E(param_00) {
  var_01 = self.powers[param_00];
  return !isDefined(var_01.var_55AB) || var_01.var_55AB == 0;
}

func_D765(param_00) {
  var_01 = self.powers[param_00];
  var_02 = isDefined(var_01.var_55AB) && var_01.var_55AB;
  var_03 = var_01.charges > 0;
  if(!var_02 && var_03) {
    self setweaponammoclip(var_01.weaponuse, 1);
    return;
  }

  self setweaponammoclip(var_01.weaponuse, 0);
}

combatrecordpoweruse(param_00) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_01 = undefined;
  if(isenumvaluevalid("mp", "LethalStatItems", param_00)) {
    var_01 = "lethalStats";
  } else if(isenumvaluevalid("mp", "TacticalStatItems", param_00)) {
    var_01 = "tacticalStats";
  } else {
    return;
  }

  var_03 = self getplayerdata("mp", var_01, param_00, "uses");
  self setplayerdata("mp", var_01, param_00, "uses", var_03 + 1);
}

equipmenthit(param_00, param_01, param_02, param_03) {
  if(scripts\mp\utility::playersareenemies(param_01, param_00)) {
    if(scripts\mp\utility::iskillstreakweapon(param_02)) {
      return;
    }

    if(!isDefined(param_01.lasthittime[param_02])) {
      param_01.lasthittime[param_02] = 0;
    }

    if(param_01.lasthittime[param_02] == gettime()) {
      return;
    }

    param_01.lasthittime[param_02] = gettime();
    param_01 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(param_02, 1, "hits");
    var_04 = param_01 scripts\mp\persistence::statgetbuffered("totalShots");
    var_05 = param_01 scripts\mp\persistence::statgetbuffered("hits") + 1;
    if(var_05 <= var_04) {
      param_01 scripts\mp\persistence::func_10E55("hits", var_05);
      param_01 scripts\mp\persistence::func_10E55("misses", int(var_04 - var_05));
      param_01 scripts\mp\persistence::func_10E55("accuracy", int(var_05 * 10000 / var_04));
    }

    if((isDefined(param_03) && scripts\engine\utility::isbulletdamage(param_03)) || scripts\mp\utility::isprojectiledamage(param_03)) {
      param_01 thread scripts\mp\contractchallenges::contractshotslanded(param_02);
      param_01.lastdamagetime = gettime();
      var_06 = scripts\mp\utility::getweapongroup(param_02);
      if(var_06 == "weapon_lmg") {
        if(!isDefined(param_01.shotslandedlmg)) {
          param_01.shotslandedlmg = 1;
          return;
        }

        param_01.shotslandedlmg++;
        return;
      }
    }
  }
}