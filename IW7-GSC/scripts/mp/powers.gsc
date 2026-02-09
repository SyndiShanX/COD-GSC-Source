/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\powers.gsc
*********************************************/

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

func_D724(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9.var_130F3 = var_1;
  var_9.weaponuse = var_2;
  var_9.cooldowntime = var_4;
  var_9.id = var_3;
  var_9.maxcharges = var_5;
  var_9.var_4E5A = var_6;
  var_9.var_13058 = var_7;
  var_9.var_12B2B = var_8;
  if(var_9.var_12B2B == "interact") {
    var_9.var_12B2B = "charges";
  }

  level.powers[var_0] = var_9;
}

func_D77D() {
  var_0 = 1;
  for(;;) {
    var_1 = tablelookupbyrow("mp\powertable.csv", var_0, 0);
    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp\powertable.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp\powertable.csv", var_0, 6);
    var_4 = tablelookupbyrow("mp\powertable.csv", var_0, 7);
    var_5 = tablelookupbyrow("mp\powertable.csv", var_0, 8);
    var_6 = tablelookupbyrow("mp\powertable.csv", var_0, 9);
    var_7 = tablelookupbyrow("mp\powertable.csv", var_0, 10);
    var_8 = tablelookupbyrow("mp\powertable.csv", var_0, 11);
    var_9 = tablelookupbyrow("mp\powertable.csv", var_0, 15);
    func_D724(var_2, var_3, var_4, int(var_1), float(var_5), int(var_6), int(var_7), int(var_8), var_9);
    if(isDefined(level.var_D7A4[var_4]) && var_4 != "<power_script_generic_weapon>") {
      switch (var_4) {
        default:
          break;
      }
    }

    level.var_D7A4[var_4] = var_2;
    var_0++;
  }
}

func_D780() {
  if(!isDefined(level.var_D77F)) {
    level.var_D77F = [];
  }

  var_0 = 0;
  for(;;) {
    var_1 = tablelookupbyrow("mp\powerpassivetable.csv", var_0, 0);
    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp\powerpassivetable.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp\powerpassivetable.csv", var_0, 2);
    var_4 = tablelookupbyrow("mp\powerpassivetable.csv", var_0, 3);
    var_5 = spawnStruct();
    if(var_4 != "") {
      var_5.var_23B1 = var_4;
      level.var_D7A4[var_4] = var_2;
    }

    if(!isDefined(level.var_D77F[var_2])) {
      level.var_D77F[var_2] = [];
    }

    var_6 = level.var_D77F[var_2];
    if(!isDefined(var_6[var_3])) {
      var_6[var_3] = var_5;
      level.var_D77F[var_2] = var_6;
    }

    var_0++;
  }
}

func_8091(var_0, var_1) {
  if(!isDefined(level.var_D77F[var_0])) {
    return undefined;
  }

  var_2 = level.var_D77F[var_0];
  if(!isDefined(var_2[var_1])) {
    return undefined;
  }

  return var_2[var_1];
}

func_8090(var_0) {
  if(!isDefined(self.powers[var_0])) {
    return undefined;
  }

  var_1 = self.powers[var_0];
  var_2 = getDvar("scr_debug_power_passive");
  if(isDefined(var_2)) {
    var_3 = func_8091(var_0, var_2);
    if(isDefined(var_3)) {
      if(isDefined(var_3.var_23B1)) {
        return var_3.var_23B1;
      }
    }
  }

  foreach(var_5 in var_1.passives) {
    var_3 = func_8091(var_0, var_5);
    if(!isDefined(var_3)) {
      continue;
    }

    if(isDefined(var_3.var_23B1)) {
      return var_3.var_23B1;
    }
  }

  return undefined;
}

powersetupfunctions(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = level.powers[var_0];
  if(!isDefined(var_7)) {
    scripts\engine\utility::error("No configuration data for " + var_0 + " found! Is it in powertable.csv? Or make sure powerSetupFunctions is called after the table is initialized.");
  }

  level.var_D786[var_0] = var_1;
  level.var_D79B[var_0] = var_2;
  if(isDefined(var_3)) {
    var_7.usefunc = var_3;
  }

  if(isDefined(var_4)) {
    var_7.var_12ED9 = var_4;
  }

  if(isDefined(var_5)) {
    var_7.usednotify = var_5;
  }

  if(isDefined(var_6)) {
    var_7.var_9A90 = var_6;
  }
}

func_D750(var_0, var_1) {
  var_2 = getcurrentequipment(var_0);
  var_3 = self.powers[var_2];
  var_4 = level.powers[var_2];
  var_5 = var_3.var_91B1;
  var_6 = var_3.charges;
  if(isDefined(var_5) && var_5 == var_1) {
    return;
  }

  if(isDefined(var_5)) {
    func_D75E(var_0);
  }

  switch (var_1) {
    case 0:
      scripts\cp\zombies\_powerup_ability::powershud_beginpowerdrain(var_0);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowermeter(var_0, 1);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(var_0, var_6);
      thread func_D76E(var_2);
      break;

    case 1:
      scripts\cp\zombies\_powerup_ability::powershud_beginpowercooldown(var_0, 0);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(var_0, var_6);
      thread func_D76D(var_2);
      break;

    case 2:
      scripts\cp\zombies\_powerup_ability::powershud_updatepowerdisabled(var_0, 0);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowermeter(var_0, 1);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(var_0, var_6);
      thread func_D76C(var_2);
      break;

    case 3:
      break;
  }

  var_3.var_91B1 = var_1;
  thread func_D75F(var_0);
}

func_D75E(var_0) {
  var_1 = getcurrentequipment(var_0);
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = self.powers[var_1];
  var_3 = var_2.var_91B1;
  if(!isDefined(var_3)) {
    return;
  }

  switch (var_3) {
    case "unavailable":
      break;

    case 0:
      scripts\cp\zombies\_powerup_ability::powershud_endpowerdrain(var_0);
      break;

    case 2:
      break;

    case 1:
      scripts\cp\zombies\_powerup_ability::powershud_finishpowercooldown(var_0, 0);
      break;
  }

  var_2.var_91B1 = undefined;
}

func_D75F(var_0) {
  self endon("disconnect");
  self notify("power_unsetHudStateOnRemoved_" + var_0);
  self endon("power_unsetHudStateOnRemoved_" + var_0);
  var_1 = getcurrentequipment(var_0);
  self waittill("power_removed_" + var_1);
  func_D75E(var_0);
}

givepower(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 2;
  if(!isDefined(self.powers)) {
    self.powers = [];
  }

  if(var_0 == "none") {
    return;
  }

  if(var_1 == "scripted") {
    var_5++;
  }

  func_D725(var_0, var_1, var_4);
  var_6 = self.powers[var_0];
  var_7 = level.powers[var_0];
  scripts\cp\zombies\_powerup_ability::powershud_updatepowermaxcharges(var_6.slot, var_6.maxcharges);
  if(isDefined(var_3)) {
    var_6.passives = var_3;
  }

  var_11 = 0;
  if(isDefined(self.var_D76F) && isDefined(self.var_D76F[var_0])) {
    var_12 = self.var_D76F[var_0];
    var_13 = func_D720(var_12);
    if(var_13 > 0) {
      var_14 = var_6.charges * var_7.cooldowntime;
      var_6.charges = int(var_14 - var_13 / var_7.cooldowntime);
      if(var_6.charges < 0) {
        var_6.charges = 0;
      }

      var_11 = var_13;
      while(var_11 > var_7.cooldowntime) {
        var_11 = var_11 - var_7.cooldowntime;
      }
    }
  }

  if(var_1 == "scripted") {
    return;
  }

  var_6.weaponuse = undefined;
  if(var_7.weaponuse == "<power_script_generic_weapon>") {
    var_6.weaponuse = scripts\engine\utility::ter_op(var_1 == "primary", "power_script_generic_primary_mp", "power_script_generic_secondary_mp");
  } else {
    var_6.weaponuse = var_7.weaponuse;
  }

  var_15 = func_8090(var_0);
  var_10 = scripts\engine\utility::ter_op(isDefined(var_15), var_15, var_6.weaponuse);
  var_6.weaponuse = var_10;
  scripts\mp\utility::_giveweapon(var_10, 0);
  self setweaponammoclip(var_10, var_6.charges);
  if(var_6.slot == "primary") {
    self assignweaponoffhandprimary(var_10);
    self.powerprimarygrenade = var_10;
  } else if(var_6.slot == "secondary") {
    self assignweaponoffhandsecondary(var_10);
    self.powersecondarygrenade = var_10;
  }

  if(isDefined(level.var_D786[var_0])) {
    self[[level.var_D786[var_0]]](var_0);
  }

  thread func_D73D(var_0);
  thread func_B2F0(var_7, var_0, var_6.slot, var_7.cooldowntime, var_7.var_12ED9, var_7.usednotify, var_10, var_11, var_2);
}

removepower(var_0) {
  if(isDefined(level.var_D79B[var_0])) {
    self[[level.var_D79B[var_0]]]();
  }

  if(isDefined(self.powers[var_0].weaponuse)) {
    scripts\mp\utility::_takeweapon(self.powers[var_0].weaponuse);
  }

  if(self.powers[var_0].slot == "primary") {
    self func_844D();
    self.powerprimarygrenade = undefined;
  } else if(self.powers[var_0].slot == "secondary") {
    self gonevo();
    self.powersecondarygrenade = undefined;
  }

  self notify("power_removed_" + var_0);
  scripts\cp\zombies\_powerup_ability::powershud_clearpower(self.powers[var_0].slot);
  self.powers[var_0] = undefined;
}

func_110C2() {
  if(isDefined(self.powers)) {
    if(!isDefined(self.var_D76F)) {
      self.var_D76F = [];
    } else {
      func_4042();
    }

    foreach(var_3, var_1 in self.powers) {
      if(isDefined(level.var_C81F) && level.var_C81F == 1) {
        continue;
      } else if(isDefined(level.var_C81F) && level.var_C81F != 0) {
        if(level.powers[var_3].var_4E5A == 1) {
          continue;
        }
      } else if(!isDefined(level.var_C81F)) {
        if(level.powers[var_3].var_4E5A == 1) {
          continue;
        }
      }

      if(var_1.var_4619 > 0) {
        var_2 = spawnStruct();
        var_2.power = var_3;
        var_2.var_4619 = var_1.var_4619;
        var_2.charges = var_1.charges;
        var_2.maxcharges = var_1.maxcharges;
        var_2.var_4E5A = var_1.var_4E5A;
        var_2.var_11931 = gettime();
        self.var_D76F[var_3] = var_2;
      }
    }
  }
}

func_4042() {
  if(isDefined(self.var_D76F) && self.var_D76F.size > 0) {
    var_0 = self.var_D76F;
    foreach(var_3, var_2 in var_0) {
      if(func_D720(var_2) == 0) {
        self.var_D76F[var_3] = undefined;
      }
    }
  }
}

func_D720(var_0) {
  var_1 = level.powers[var_0.power];
  var_2 = var_0.maxcharges - var_0.charges * var_1.cooldowntime - var_1.cooldowntime - var_0.var_4619;
  var_3 = gettime() - var_0.var_11931 / 1000;
  return max(0, var_2 - var_3);
}

clearpowers() {
  self notify("powers_cleanUp");
  if(isDefined(self.powers)) {
    var_0 = self.powers;
    foreach(var_3, var_2 in var_0) {
      removepower(var_3);
    }

    self.powers = [];
  }
}

getcurrentequipment(var_0) {
  if(!isDefined(self.powers)) {
    return undefined;
  }

  foreach(var_3, var_2 in self.powers) {
    if(var_2.slot == var_0) {
      return var_3;
    }
  }

  return undefined;
}

func_E265() {
  if(!isDefined(self) || !isDefined(self.powers)) {
    return;
  }

  foreach(var_4, var_1 in self.powers) {
    var_2 = var_1.charges;
    var_3 = var_1.maxcharges;
    if(var_2 != var_3) {
      self.powers[var_4].charges = self.powers[var_4].maxcharges;
      func_D765(var_4);
      self notify("power_charges_adjusted_" + var_4, self.powers[var_4].charges);
    }
  }
}

func_1813(var_0) {
  if(!isDefined(self) || !isDefined(self.powers)) {
    return;
  }

  foreach(var_7, var_2 in self.powers) {
    var_3 = var_2.charges;
    var_4 = var_2.maxcharges;
    var_5 = var_3 + var_0;
    if(var_5 > var_4) {
      var_5 = var_4;
    }

    var_6 = var_5 - var_3;
    if(var_6 > 0) {
      self.powers[var_7].charges = var_5;
      func_D765(var_7);
      self notify("power_charges_adjusted_" + var_7, self.powers[var_7].charges);
    }
  }
}

func_D735(var_0) {
  return scripts\engine\utility::ter_op(self.powers[var_0].slot == "primary", "+frag", "+smoke");
}

func_D734(var_0) {
  return self.powers[var_0].charges;
}

func_D736(var_0) {
  return self.powers[var_0].maxcharges;
}

func_D737(var_0) {
  return level.var_D7A4[var_0];
}

func_D738(var_0) {
  if(!isDefined(var_0) || !isDefined(level.powers[var_0]) || var_0 == "none") {
    return 0;
  }

  return level.powers[var_0].id;
}

func_D725(var_0, var_1, var_2) {
  var_3 = level.powers[var_0];
  var_4 = spawnStruct();
  var_4.slot = var_1;
  var_4.charges = var_3.maxcharges;
  if(scripts\mp\utility::istrue(var_2)) {
    var_4.charges++;
  }

  var_4.maxcharges = var_4.charges;
  var_4.var_93DD = 0;
  var_4.var_19 = 0;
  var_4.var_4619 = 0;
  var_4.cooldownratemod = 1;
  var_4.passives = [];
  self.powers[var_0] = var_4;
}

func_B2F0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_1);
  if((isDefined(var_8) && var_8) || var_1 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  scripts\cp\zombies\_powerup_ability::powershud_assignpower(var_2, int(var_0.id), 1, int(self.powers[var_1].charges));
  scripts\mp\utility::gameflagwait("prematch_done");
  var_3 = scripts\mp\powerloot::func_7FBF(var_1, var_3);
  func_D750(var_2, 2);
  scripts\cp\zombies\_powerup_ability::powershud_updatepoweroffcooldown(var_2, 0);
  self notify("power_available", var_1, var_2);
  thread scripts\mp\weapons::func_13AB5(self, var_1, var_2);
  for(;;) {
    func_D765(var_1);
    var_9 = var_6 + "_success";
    thread func_13A0E(var_3, var_1, var_9, var_2);
    var_10 = scripts\engine\utility::ter_op(var_0.var_130F3 == "weapon_hold", "offhand_pullback", "offhand_fired");
    if(var_0.var_130F3 == "weapon_hold") {
      self waittill(var_10, var_11);
      if(var_11 != var_6) {
        continue;
      }
    } else if(!func_D76B(var_6)) {
      continue;
    }

    self notify("power_activated", var_1, var_2);
    scripts\mp\utility::printgameaction("power used - " + var_1, self);
    self notify(var_9);
    var_12 = undefined;
    if(isDefined(var_0.usefunc)) {
      var_12 = self thread[[var_0.usefunc]]();
      if(isDefined(var_12) && var_12 == 0) {
        continue;
      }
    }

    if(isDefined(var_5)) {
      self waittill(var_5, var_12);
      if(isDefined(var_12) && var_12 == 0) {
        continue;
      }
    }

    scripts\mp\gamelogic::sethasdonecombat(self, 1);
    scripts\mp\analyticslog::logevent_powerused(var_1, "unused");
    power_adjustcharges(-1, self.powers[var_1].slot);
    combatrecordpoweruse(var_1);
    if(isDefined(var_4) && level.powers[var_1].var_12B2B == "drain" && !scripts\mp\utility::istrue(self.powers[var_1].var_940B)) {
      func_D72B(var_1);
    }

    thread func_D72A(var_1, var_3, var_8, var_2);
  }
}

func_D73F(var_0) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = level.powers[var_0];
  for(;;) {
    self waittill("scavenged_ammo", var_3);
    if(var_1.weaponuse == var_3) {
      var_4 = var_2.cooldowntime;
      func_D74F(var_0, var_4);
    }
  }
}

func_D74C(var_0) {
  if(hasequipment(var_0)) {
    var_1 = self.powers[var_0];
    func_D71B(1, var_0);
    func_D765(var_0);
    var_2 = var_1.var_91B1;
    if(isDefined(var_2) && var_2 == 1) {
      func_D750(var_1.slot, 2);
    }
  }
}

func_D73D(var_0) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.weaponuse;
  var_3 = var_1.slot;
  for(;;) {
    self waittill("scavenged_ammo", var_4);
    if(var_4 == var_2) {
      func_D74C(var_0);
    }
  }
}

func_EBD4(var_0) {
  var_0 func_D74C("power_throwingKnife");
  var_0 func_D74C("power_blinkKnife");
  var_0 func_D74C("power_bioSpike");
}

func_D74F(var_0, var_1) {
  var_2 = self.powers[var_0];
  var_3 = level.powers[var_0];
  var_2.var_4617 = min(var_1, var_3.cooldowntime);
  var_2.var_4619 = var_3.cooldowntime - var_1;
  if(var_2.var_4619 <= 0) {
    self notify("finish_power_cooldown_" + var_0);
  }
}

func_D752(var_0, var_1) {
  if(var_1 scripts\mp\utility::_hasperk("specialty_powercell")) {
    return 1;
  }

  if(level.powers[var_0].var_13058) {
    return 1;
  }

  return 0;
}

func_D72A(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  self endon("power_cooldown_ended" + var_0);
  if((isDefined(var_2) && var_2) || var_0 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self notify("power_cooldown_begin_" + var_0);
  self endon("power_cooldown_begin_" + var_0);
  var_4 = level.powers[var_0];
  var_5 = self.powers[var_0];
  var_3 = var_5.slot;
  var_6 = var_0 + "_cooldown_update";
  var_5.var_93DD = 1;
  if(!isDefined(var_5.var_461C)) {
    var_5.var_461C = 0;
  }

  var_5.var_461C++;
  if(!isDefined(var_5.var_4617)) {
    var_5.var_4617 = 0;
  }

  if(!isDefined(var_5.var_4619)) {
    var_5.var_4619 = 0;
  }

  var_5.var_4619 = var_5.var_4619 + var_1;
  var_7 = var_5.var_91B1;
  if(isDefined(var_7) && var_7 != 0 && var_5.charges == 0) {
    func_D750(var_3, 1);
    self notify("power_unavailable", var_0, var_3);
  }

  while(var_5.charges < var_5.maxcharges) {
    if(func_D752(var_0, self)) {
      wait(0.1);
    } else {
      self waittill("power_charges_adjusted_" + var_0);
    }

    if(var_5.var_4617 > var_1) {
      power_adjustcharges(1, var_3);
      func_D765(var_0);
      if(var_5.charges == var_5.maxcharges) {
        thread func_D730(var_0, var_2);
      }

      var_5.var_4617 = var_5.var_4617 - var_1;
      var_5.var_4619 = var_5.var_4619 - var_1;
      var_5.var_461C--;
      if(isDefined(var_7) && var_7 != 0) {
        func_D750(var_3, 2);
      }
    } else {
      var_5.var_4617 = var_5.var_4617 + 0.1;
      var_5.var_4619 = var_5.var_4619 - 0.1;
    }

    var_8 = min(1, var_5.var_4617 / var_1);
    self notify(var_6, var_8);
  }

  thread func_D730(var_0, var_2);
}

func_D730(var_0, var_1) {
  self notify("power_cooldown_ended" + var_0);
  var_2 = self.powers[var_0];
  var_2.var_93DD = 0;
  var_2.var_4617 = 0;
  var_2.var_4619 = 0;
  var_2.var_461C = 0;
  if(isDefined(var_1) && var_1) {
    self notify("copycat_reset");
  }

  var_3 = var_2.var_91B1;
  var_4 = var_2.slot;
  if(var_3 == 0) {
    return;
  }

  func_D750(var_4, 2);
}

func_D72B(var_0) {
  self endon("death");
  self endon("power_drain_ended_" + var_0);
  self notify("power_cooldown_ended_" + var_0);
  var_1 = level.powers[var_0];
  var_2 = self.powers[var_0];
  var_3 = var_1.var_12ED9;
  var_4 = var_1.var_9A90;
  var_5 = var_2.slot;
  var_2.var_940B = 1;
  func_D727(var_0);
  func_D750(var_5, 0);
  if(isDefined(var_4)) {
    thread func_D732(var_0, var_5, var_4);
  }

  for(;;) {
    self waittill(var_3, var_6);
    if(var_6 == 0) {
      break;
    }
  }

  thread func_D731(var_0);
}

func_D732(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  self endon("power_drain_ended_" + var_0);
  self waittill(var_2);
  thread func_D731(var_0);
}

func_D731(var_0) {
  self notify("power_drain_ended_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.slot;
  var_1.var_940B = 0;
  func_D72D(var_0);
  if(var_1.charges > 0) {
    func_D750(var_2, 2);
    return;
  }

  func_D750(var_2, 1);
}

func_12D2C() {}

func_130D5() {}

func_F676(var_0) {
  level.powers[var_0].var_4620 = "multi_use";
}

func_12C89() {}

func_13051() {
  scripts\mp\bulletstorm::func_10D76();
}

func_F6B1(var_0) {}

func_12C9F() {
  scripts\mp\equipment\dash::func_E0E9();
}

func_13072() {
  return scripts\mp\equipment\dash::func_4D90();
}

func_F7C8(var_0) {}

func_12CFB() {
  scripts\mp\equipment\optic_wave::func_E145();
}

func_130B4() {
  scripts\mp\equipment\optic_wave::func_C6AF();
}

func_F7E7(var_0) {}

func_12D0B() {
  scripts\mp\equipment\phase_split::func_CABB();
}

usephasesplit() {
  return scripts\mp\equipment\phase_split::func_CAC2();
}

func_F6EF(var_0) {
  scripts\mp\equipment\exploding_drone::func_69D0(var_0);
}

func_12CAF() {
  scripts\mp\equipment\exploding_drone::func_69D3();
}

func_13085() {}

func_F7CC(var_0) {}

func_12CFD() {
  scripts\mp\equipment\overcharge::func_E14C();
}

useovercharge() {
  scripts\mp\equipment\overcharge::useovercharge();
}

func_F84A(var_0) {}

func_12D30() {
  scripts\mp\equipment\smoke_wall::func_E16E();
}

func_130D7() {
  scripts\mp\equipment\smoke_wall::func_1037D();
}

func_F69C(var_0) {}

unsetcomlink(var_0) {
  scripts\mp\equipment\commlink::func_E0E0();
}

func_13055() {
  scripts\mp\equipment\commlink::setturrettargetent();
}

func_F87F(var_0) {
  scripts\mp\equipment\telereap::func_83B2();
}

func_12D45() {
  scripts\mp\equipment\telereap::removethinker();
}

func_130E8() {
  var_0 = scripts\mp\equipment\telereap::func_130E8();
  return var_0;
}

func_F844(var_0) {}

func_12D2B() {
  scripts\mp\phaseshift::func_E169();
}

func_130D4() {
  scripts\mp\phaseshift::func_D41C();
}

settransponder(var_0) {
  scripts\mp\equipment\transponder::func_F5D3();
}

unsettransponder() {
  scripts\mp\equipment\transponder::removetransponder();
}

func_130F0() {
  scripts\mp\equipment\transponder::transponder_use();
}

func_F7EB(var_0) {
  scripts\mp\equipment\plasma_spear::giveplayeraccessory();
}

func_12D0D() {
  scripts\mp\equipment\plasma_spear::func_E158();
}

setheadgear(var_0) {
  level.powers[var_0].var_5FF3 = 30;
  level.var_8C74 = 0.8;
}

unsetheadgear() {}

func_1308F() {
  scripts\mp\equipment\headgear::func_E855();
}

func_F658(var_0) {
  level.powers[var_0].var_5FF3 = 30;
}

func_12C78() {}

func_13049() {
  scripts\mp\equipment\barrier::func_E83A();
}

func_F659(var_0) {}

func_12C79() {}

func_1304B() {
  scripts\mp\equipment\battery::func_E83B();
}

func_F7A5(var_0) {
  scripts\mp\equipment\mortar_mount::func_BB90();
}

func_12CF3() {
  scripts\mp\equipment\mortar_mount::func_BB93();
}

func_130A5() {
  scripts\mp\equipment\mortar_mount::func_BB94();
}

func_F62E(var_0) {}

func_12C67() {
  scripts\mp\equipment\adrenaline::removeadrenaline();
}

useadrenaline() {
  thread scripts\mp\equipment\adrenaline::useadrenaline();
}

func_F7AB(var_0) {
  scripts\mp\equipment\multi_visor::func_F7AB();
}

func_12CF6() {
  scripts\mp\equipment\multi_visor::func_E13F();
}

func_130A7() {
  scripts\mp\equipment\multi_visor::func_130A7();
}

func_F861(var_0) {
  scripts\mp\archetypes\archscout::func_F861();
}

func_12D38() {
  scripts\mp\archetypes\archscout::func_E175();
}

func_130E0() {
  scripts\mp\archetypes\archscout::func_130E0();
}

func_F7B5(var_0) {
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

func_F899(var_0) {
  scripts\mp\trophy_system::func_12820();
}

func_12D52() {
  scripts\mp\trophy_system::func_12825();
}

func_F677(var_0) {
  scripts\mp\equipment\c4::c4_set();
}

func_F69E(var_0) {
  scripts\mp\equipment\cone_flash::func_44FB();
}

unsetcooldown() {
  scripts\mp\equipment\cone_flash::func_44FD();
}

func_13057() {
  scripts\mp\equipment\cone_flash::func_44FF();
}

func_F664(var_0) {}

func_12C80() {
  scripts\mp\equipment\blackhat::func_E0D4();
}

func_1304D() {
  scripts\mp\equipment\blackhat::func_13073();
}

func_FB22(var_0) {
  scripts\mp\equipment\wrist_rocket::wristrocket_set();
}

func_12D6A() {
  scripts\mp\equipment\wrist_rocket::wristrocket_unset();
}

hasequipment(var_0) {
  if(!isDefined(self.powers[var_0])) {
    return 0;
  }

  return 1;
}

func_13709(var_0) {
  self endon("death");
  self endon("disconnect");
  if(var_0 == "primary") {
    var_1 = "power_primary_used";
  } else {
    var_1 = "power_secondary_used";
  }

  for(;;) {
    if(!isDefined(self)) {
      wait(1);
      break;
    }

    self waittill(var_1);
    break;
  }
}

power_modifycooldownrate(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  var_2 = func_D739();
  foreach(var_4 in var_2) {
    if(self.powers[var_4].slot == var_1 || var_1 == "all") {
      self.powers[var_4].cooldownratemod = var_0;
    }
  }
}

func_D74E(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  var_1 = func_D739();
  foreach(var_3 in var_1) {
    if(self.powers[var_3].slot == var_0 || var_0 == "all") {
      self.powers[var_3].cooldownratemod = 1;
    }
  }
}

power_adjustcharges(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  var_2 = func_D739();
  foreach(var_4 in var_2) {
    if(self.powers[var_4].slot == var_1 || var_1 == "all") {
      var_5 = self.powers[var_4].charges;
      var_6 = self.powers[var_4].maxcharges;
      var_7 = max(min(var_6, var_5 + var_0), 0);
      self.powers[var_4].charges = var_7;
      if(var_5 != var_7) {
        self notify("power_charges_adjusted_" + var_4, self.powers[var_4].charges);
      }
    }
  }
}

func_D71B(var_0, var_1) {
  power_adjustcharges(var_0, self.powers[var_1].slot);
}

func_D739() {
  var_0 = getarraykeys(level.powers);
  var_1 = getarraykeys(self.powers);
  var_2 = [];
  var_3 = 0;
  foreach(var_5 in var_1) {
    foreach(var_7 in var_0) {
      if(var_5 == var_7) {
        var_2[var_3] = var_5;
        var_3 = var_3 + 1;
        break;
      }
    }
  }

  return var_2;
}

func_D729() {
  scripts\engine\utility::allow_offhand_weapons(0);
}

func_D72F() {
  scripts\engine\utility::allow_offhand_weapons(1);
}

usequickslothealitem(var_0) {
  scripts\mp\utility::_giveweapon(var_0);
  scripts\mp\utility::_switchtoweapon(var_0);
  wait(1);
  scripts\mp\utility::_switchtoweapon(var_0);
  scripts\mp\utility::_takeweapon(var_0);
}

func_50A4(var_0) {
  if(!isDefined(self.var_D775)) {
    self.var_D775 = [];
  }

  if(!isDefined(self.var_D775[var_0])) {
    self.var_D775[var_0] = 0;
  }
}

damageconetrace(var_0) {
  func_50A4(var_0);
  return self.var_D775[var_0];
}

func_F809(var_0, var_1) {
  func_50A4(var_0);
  self.var_D775[var_0] = var_1;
}

func_4575(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("cancel_" + var_1);
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  var_0 = var_0 * 1000;
  var_3 = 1 / var_0;
  var_4 = gettime();
  func_F809(var_1, var_0);
  var_5 = damageconetrace(var_1);
  while(var_5 > 0) {
    func_C170(var_1, var_5 * var_3);
    wait(0.1);
    var_5 = damageconetrace(var_1);
    var_6 = gettime();
    var_5 = var_5 - var_6 - var_4;
    var_4 = var_6;
    func_F809(var_1, var_5);
  }

  func_C170(var_1, 0);
}

func_3885(var_0) {
  func_F809(var_0, 0);
  self notify("cancel_" + var_0);
  func_C170(var_0, 0);
}

func_C170(var_0, var_1) {
  self notify(var_0, var_1);
}

func_13A0E(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_1);
  self endon(var_2);
  level endon("game_ended");
  self waittill("offhand_fired", var_4);
  var_5 = self.powers[var_1];
  if(isDefined(var_4) && var_4 == var_5.weaponuse) {
    if(!isalive(self)) {
      if(var_5.charges > 0) {
        scripts\mp\analyticslog::logevent_powerused(var_1, "unused");
        power_adjustcharges(-1, var_5.slot);
      }

      if(!var_5.var_93DD) {
        var_5.var_4619 = level.powers[var_1].cooldowntime;
        thread func_D72A(var_1, var_0, undefined, var_3);
        return;
      }
    }
  }
}

func_136DD(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    thread func_13A68(var_0, var_2);
  }

  thread func_13A7D(var_0, var_1);
  self waittill("power_use_update_" + var_0, var_3);
  return var_3;
}

func_13A68(var_0, var_1) {
  self endon("power_use_update_" + var_0);
  for(;;) {
    self waittill("scavenged_ammo", var_2);
    if(var_2 == var_1) {
      self notify("power_use_update_" + var_0);
      return;
    }
  }
}

func_13A7D(var_0, var_1) {
  self endon("power_use_update_" + var_0);
  self waittill(var_1, var_2);
  self notify("power_use_update_" + var_0, var_2);
}

func_D767(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_2 = var_2 - 1;
  var_5 = 0;
  var_6 = 0.05;
  var_7 = func_D735(var_0);
  var_8 = undefined;
  var_9 = var_3;
  for(;;) {
    if(!func_9F09(var_7)) {
      break;
    }

    if(func_9F09(var_7)) {
      while(func_9F09(var_7)) {
        if(self usebuttonpressed()) {
          if(var_5 == 0) {
            var_6 = 0.05;
          }

          var_10 = 0;
          while(self usebuttonpressed()) {
            var_10 = var_10 + 0.05;
            if(var_10 >= var_6) {
              var_1 = func_93FD(var_1, var_2, var_3);
              var_5 = 1;
              var_10 = 0;
              var_6 = 0.7;
              var_4 = 1;
              self[[var_9]](var_1);
              break;
            }

            wait(0.05);
          }
        }

        wait(0.05);
        if(self usebuttonpressed() == 0) {
          var_5 = 0;
          break;
        }
      }
    }

    wait(0.05);
  }

  if(!var_4) {
    if(var_1 == var_2) {
      var_1 = 0;
    } else {
      var_1++;
    }

    self[[var_9]](var_1);
  }

  return var_1;
}

func_9F09(var_0) {
  if((var_0 == "+frag" && self fragbuttonpressed()) || var_0 == "+smoke" && self secondaryoffhandbuttonpressed()) {
    return 1;
  }

  return 0;
}

func_D769(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(var_1)) {
    var_1 = 2000;
  } else {
    var_1 = var_1 * 1000;
  }

  var_2 = func_D735(var_0);
  var_3 = gettime();
  var_4 = var_3 + var_1;
  while(func_9F09(var_2) && gettime() < var_4) {
    wait(0.05);
  }

  return gettime() - var_3 / 1000;
}

func_93FD(var_0, var_1, var_2) {
  if(var_0 < var_1) {
    var_0++;
  } else {
    var_0 = 0;
  }

  return var_0;
}

func_C179() {
  if(!isDefined(self.weapon_name)) {
    return;
  }

  switch (self.weapon_name) {
    case "bouncingbetty_mp":
      self.owner notify("bouncing_betty_update", 0);
      break;

    case "transponder_mp":
      self.owner notify("transponder_update", 0);
      break;

    case "trip_mine_mp":
      self.owner notify("trip_mine_update", 0);
      break;

    case "sonic_sensor_mp":
      self.owner notify("sonic_sensor_update", 0);
      break;

    case "trophy_mp":
      self.owner notify("trophy_update", 0);
      break;

    case "fear_grenade_mp":
      self.owner notify("restart_fear_grenade_cooldown", 0);
      break;

    case "cryo_mine":
      self.owner notify("cryo_mine_update", 0);
      break;

    case "micro_turret_mp":
      self.owner notify("microTurret_update", 0);
      break;

    default:
      break;
  }
}

func_9F0A(var_0) {
  switch (var_0) {
    case "iw6_minigunsiege_mp":
    case "iw7_niagara_mp":
    case "armorup_mp":
      return 1;

    default:
      return 0;
  }
}

func_F808(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1 > 0) {
    func_4575(var_1, var_0);
    return;
  }

  func_3885(var_0);
}

func_D76C(var_0) {
  self endon("death");
  self endon("power_available_ended_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.slot;
  for(;;) {
    self waittill("power_charges_adjusted_" + var_0, var_3);
    scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(var_2, var_3);
  }
}

func_D76E(var_0) {
  self endon("disconnect");
  self endon("power_removed_" + var_0);
  self endon("power_drain_ended_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = level.powers[var_0];
  var_3 = var_1.slot;
  var_4 = var_2.var_12ED9;
  if(!isDefined(var_4)) {
    var_4 = var_0 + "_update";
  }

  for(;;) {
    self waittill(var_4, var_5);
    var_5 = max(0, min(1, var_5));
    scripts\cp\zombies\_powerup_ability::powershud_updatepowerdrainprogress(var_3, var_5);
  }
}

func_D76D(var_0) {
  self endon("disconnect");
  self endon("power_removed_" + var_0);
  self endon("power_cooldown_ended" + var_0);
  var_1 = self.powers[var_0];
  var_2 = level.powers[var_0];
  var_3 = var_1.slot;
  var_4 = var_0 + "_cooldown_update";
  for(;;) {
    self waittill(var_4, var_5);
    scripts\cp\zombies\_powerup_ability::powershud_updatepowercooldown(var_3, var_5);
  }
}

func_D76B(var_0) {
  var_1 = spawnStruct();
  childthread func_13A2C(var_0, var_1);
  childthread func_13A2D(var_0, var_1);
  self waittill("grenadeOffhandFiredRace_" + var_0 + "_begin");
  waittillframeend;
  self notify("grenadeOffhandFiredRace_" + var_0 + "_end");
  if(isDefined(var_1.enableworldup) && var_1.enableworldup == var_0) {
    return !isDefined(var_1.setonwallanimconditional);
  }

  if(isDefined(var_1.var_C336) && var_1.var_C336 == var_0) {
    return 1;
  }

  return 0;
}

func_13A2C(var_0, var_1) {
  self endon("grenadeOffhandFiredRace_" + var_0 + "_end");
  for(;;) {
    self waittill("grenade_fire", var_2, var_3, var_4, var_5);
    if(!scripts\mp\utility::func_85E0(var_2)) {
      continue;
    }

    var_1.enableworldup = var_3;
    var_1.setonwallanimconditional = var_5;
    break;
  }

  self notify("grenadeOffhandFiredRace_" + var_0 + "_begin");
}

func_13A2D(var_0, var_1) {
  self endon("grenadeOffhandFiredRace_" + var_0 + "_end");
  self waittill("offhand_fired", var_2);
  var_1.var_C336 = var_2;
  self notify("grenadeOffhandFiredRace_" + var_0 + "_begin");
}

func_D727(var_0) {
  var_1 = self.powers[var_0];
  if(!isDefined(var_1.var_55AB)) {
    var_1.var_55AB = 0;
  }

  var_1.var_55AB++;
  if(var_1.var_55AB == 1) {
    func_D765(var_0);
  }
}

func_D72D(var_0) {
  var_1 = self.powers[var_0];
  var_1.var_55AB--;
  if(var_1.var_55AB == 0) {
    func_D765(var_0);
  }
}

func_D71E(var_0) {
  var_1 = self.powers[var_0];
  return !isDefined(var_1.var_55AB) || var_1.var_55AB == 0;
}

func_D765(var_0) {
  var_1 = self.powers[var_0];
  var_2 = isDefined(var_1.var_55AB) && var_1.var_55AB;
  var_3 = var_1.charges > 0;
  if(!var_2 && var_3) {
    self setweaponammoclip(var_1.weaponuse, 1);
    return;
  }

  self setweaponammoclip(var_1.weaponuse, 0);
}

combatrecordpoweruse(var_0) {
  if(!scripts\mp\utility::canrecordcombatrecordstats()) {
    return;
  }

  var_1 = undefined;
  if(isenumvaluevalid("mp", "LethalStatItems", var_0)) {
    var_1 = "lethalStats";
  } else if(isenumvaluevalid("mp", "TacticalStatItems", var_0)) {
    var_1 = "tacticalStats";
  } else {
    return;
  }

  var_3 = self getplayerdata("mp", var_1, var_0, "uses");
  self setplayerdata("mp", var_1, var_0, "uses", var_3 + 1);
}

equipmenthit(var_0, var_1, var_2, var_3) {
  if(scripts\mp\utility::playersareenemies(var_1, var_0)) {
    if(scripts\mp\utility::iskillstreakweapon(var_2)) {
      return;
    }

    if(!isDefined(var_1.lasthittime[var_2])) {
      var_1.lasthittime[var_2] = 0;
    }

    if(var_1.lasthittime[var_2] == gettime()) {
      return;
    }

    var_1.lasthittime[var_2] = gettime();
    var_1 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_2, 1, "hits");
    var_4 = var_1 scripts\mp\persistence::statgetbuffered("totalShots");
    var_5 = var_1 scripts\mp\persistence::statgetbuffered("hits") + 1;
    if(var_5 <= var_4) {
      var_1 scripts\mp\persistence::func_10E55("hits", var_5);
      var_1 scripts\mp\persistence::func_10E55("misses", int(var_4 - var_5));
      var_1 scripts\mp\persistence::func_10E55("accuracy", int(var_5 * 10000 / var_4));
    }

    if((isDefined(var_3) && scripts\engine\utility::isbulletdamage(var_3)) || scripts\mp\utility::isprojectiledamage(var_3)) {
      var_1 thread scripts\mp\contractchallenges::contractshotslanded(var_2);
      var_1.lastdamagetime = gettime();
      var_6 = scripts\mp\utility::getweapongroup(var_2);
      if(var_6 == "weapon_lmg") {
        if(!isDefined(var_1.shotslandedlmg)) {
          var_1.shotslandedlmg = 1;
          return;
        }

        var_1.shotslandedlmg++;
        return;
      }
    }
  }
}