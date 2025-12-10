/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_powers.gsc
*********************************************/

init() {
  level.powers = [];
  level.var_D786 = [];
  level.var_D79B = [];
  level.var_D7A4 = [];
  thread scripts\cp\zombies\_powerup_ability::powershud_init();
  func_D77D();
  if(isDefined(level.power_setup_init)) {
    level[[level.power_setup_init]]();
  } else {
    powersetupfunctions("power_phaseShift", ::func_F7E2, ::func_12D07, ::usephaseshift, "powers_phase_shift_update", undefined, "phaseshift_interrupted");
    powersetupfunctions("power_kineticPulse", ::func_F776, ::unsetkillstreaktoscorestreak, ::func_1309C, undefined, undefined, undefined);
    powersetupfunctions("power_transponder", ::settransponder, ::unsettransponder, undefined, "transponder_update", "powers_transponder_used", undefined);
    powersetupfunctions("power_armageddon", undefined, undefined, ::usearmageddon, undefined, undefined, undefined);
    powersetupfunctions("power_microTurret", undefined, undefined, undefined, "microTurret_update", "powers_microTurret_used", undefined);
    powersetupfunctions("power_rewind", ::setrewind, ::unsetrewind, ::userewind, undefined, "powers_rewind_used", undefined);
    powersetupfunctions("power_repulsor", undefined, undefined, ::userepulsor, undefined, undefined, undefined);
    powersetupfunctions("power_blackholeGrenade", undefined, undefined, undefined, undefined, "powers_blackholeGrenade_used", undefined);
    powersetupfunctions("power_tripMine", undefined, undefined, undefined, "trip_mine_update", undefined, undefined);
    powersetupfunctions("power_portalGenerator", undefined, undefined, undefined, undefined, "powers_portalGenerator_used", undefined);
    powersetupfunctions("power_c4", undefined, undefined, undefined, "c4_update", undefined, undefined);
    powersetupfunctions("power_holyWater", ::giveholywater, ::takeholywater, undefined, undefined, undefined, undefined);
    thread scripts\cp\powers\coop_phaseshift::init();
    thread scripts\cp\powers\coop_kinetic_pulse::init();
    thread scripts\cp\powers\coop_repulsor::init();
    thread scripts\cp\powers\coop_transponder::init();
    thread scripts\cp\powers\coop_microturret::init();
    thread scripts\cp\powers\coop_trip_mine::tripmine_init();
    thread scripts\cp\powers\coop_blackholegrenade::blackholegrenadeinit();
    thread scripts\cp\powers\coop_holywater::init();
  }

  if(!isDefined(level.cosine)) {
    level.cosine = [];
    level.cosine["90"] = cos(90);
    level.cosine["89"] = cos(89);
    level.cosine["45"] = cos(45);
    level.cosine["25"] = cos(25);
    level.cosine["15"] = cos(15);
    level.cosine["10"] = cos(10);
    level.cosine["5"] = cos(5);
  }

  level func_FAD7();
  scripts\engine\utility::flag_init("powers_init_done");
  scripts\engine\utility::flag_set("powers_init_done");
}

func_FAD7() {
  level.overcook_func["cluster_grenade_zm"] = ::func_42DD;
  level.overcook_func["frag_grenade_zm"] = ::func_7358;
}

func_42DD(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("power_removed_power_clusterGrenade");
  if(!isDefined(param_01) || param_01 != "cluster_grenade_zm") {
    return;
  }

  if(!param_00 hasequipment("power_clusterGrenade")) {
    return;
  }

  var_02 = spawn("script_model", param_00.origin);
  var_03 = "power_clusterGrenade";
  thread scripts\cp\cp_weapon::clustergrenadeexplode(param_00.origin, scripts\engine\utility::array_randomize([0.2, 0.25, 0.25, 0.3]), param_00, var_02);
  param_00 power_adjustcharges(param_00.powers[var_03].charges - 1, param_00.powers[var_03].slot, 1);
  param_00 func_D765(var_03);
  param_00 thread func_E1F1();
  param_00 thread func_5166(var_03);
}

func_7358(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  var_02 = "power_frag";
  param_00 endon("power_removed_" + var_02);
  if(!isDefined(param_01) || param_01 != "frag_grenade_zm") {
    return;
  }

  if(!param_00 hasequipment(var_02)) {
    return;
  }

  var_03 = param_00.origin;
  playFX(scripts\engine\utility::getfx("clusterGrenade_explode"), var_03);
  playsoundatpos(var_03, "grenade_explode");
  if(!isDefined(param_00.powers[var_02])) {
    return;
  }

  param_00 power_adjustcharges(param_00.powers[var_02].charges - 1, param_00.powers[var_02].slot, 1);
  param_00 func_D765(var_02);
  param_00 radiusdamage(var_03, 256, 150, 100, param_00, "MOD_GRENADE", "frag_grenade_zm");
  playrumbleonposition("grenade_rumble", var_03);
  earthquake(0.5, 0.75, var_03, 800);
  foreach(var_05 in level.players) {
    if(var_05 scripts\cp\utility::isusingremote()) {
      continue;
    }

    if(distancesquared(var_03, var_05.origin) > 360000) {
      continue;
    }

    if(var_05 damageconetrace(var_03)) {
      var_05 thread scripts\cp\cp_weapon::dirteffect(var_03);
    }

    var_05 setclientomnvar("ui_hud_shake", 1);
  }

  param_00 thread func_E1F1();
  param_00 thread func_5166(var_02);
}

func_E1F1() {
  self endon("death");
  self getquadrant();
  while(self fragbuttonpressed()) {
    wait(0.1);
  }

  wait(0.1);
  self enableoffhandweapons();
}

func_5166(param_00) {
  self endon("death");
  self endon("end_last_second_throw_func");
  self notify("starting_delay_last_second_grenade_throws");
  thread func_62CD(0.25);
  self waittill("grenade_fire", var_01, var_02, var_03, var_04);
  if(isDefined(var_01) && var_01.classname == "grenade") {
    var_01 delete();
    power_adjustcharges(self.powers[param_00].charges + 1, self.powers[param_00].slot, 1);
  }
}

func_62CD(param_00) {
  self endon("death");
  wait(param_00);
  self notify("end_last_second_throw_func");
}

func_D724(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = spawnStruct();
  var_0A.var_130F3 = param_01;
  var_0A.weaponuse = param_02;
  var_0A.cooldowntime = param_04;
  var_0A.id = param_03;
  var_0A.maxcharges = param_05;
  var_0A.var_4E5A = param_06;
  var_0A.var_13058 = param_07;
  var_0A.var_12B2B = param_08;
  var_0A.defaultslot = param_09;
  level.powers[param_00] = var_0A;
}

func_D77D() {
  var_00 = 1;
  if(isDefined(level.power_table)) {
    var_01 = level.power_table;
  } else {
    var_01 = "cp\cp_powertable.csv";
  }

  for(;;) {
    var_02 = tablelookupbyrow(var_01, var_00, 0);
    if(var_02 == "") {
      break;
    }

    var_03 = tablelookupbyrow(var_01, var_00, 1);
    var_04 = tablelookupbyrow(var_01, var_00, 6);
    var_05 = tablelookupbyrow(var_01, var_00, 7);
    var_06 = tablelookupbyrow(var_01, var_00, 8);
    var_07 = tablelookupbyrow(var_01, var_00, 9);
    var_08 = tablelookupbyrow(var_01, var_00, 10);
    var_09 = tablelookupbyrow(var_01, var_00, 11);
    var_0A = tablelookupbyrow(var_01, var_00, 16);
    var_0B = tablelookupbyrow(var_01, var_00, 13);
    func_D724(var_03, var_04, var_05, int(var_02), float(var_06), int(var_07), int(var_08), int(var_09), var_0A, var_0B);
    if(isDefined(level.var_D7A4[var_05]) && var_05 != "<power_script_generic_weapon>") {
      switch (var_05) {
        case "power_rewind":
          if(var_03 == "power_rewinder") {
            break;
          }

          break;

        default:
          break;
      }
    }

    level.var_D7A4[var_05] = var_03;
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
  if(!isDefined(level.var_D77F)) {
    return undefined;
  }

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

givepower(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = 2;
  if(!isDefined(self.powers)) {
    self.powers = [];
  }

  if(param_00 == "none") {
    return;
  }

  if(param_01 == "scripted") {
    var_07++;
  }

  for(var_08 = self _meth_854D(); var_08 != "none"; var_08 = self _meth_854D()) {
    scripts\engine\utility::waitframe();
  }

  var_09 = getarraykeys(self.powers);
  foreach(var_0B in var_09) {
    if(self.powers[var_0B].slot == param_01) {
      self.var_A037 = var_0B;
      removepower(var_0B);
      scripts\cp\zombies\zombie_analytics::func_AF76(self.var_A037, level.transactionid);
      break;
    }
  }

  func_D725(param_00, param_01, param_04, param_05, param_06);
  var_0D = self.powers[param_00];
  var_0E = level.powers[param_00];
  self notify("delete_equipment " + param_01);
  if(isDefined(param_03)) {
    var_0D.passives = param_03;
  }

  var_0F = 0;
  if(isDefined(self.var_D76F) && isDefined(self.var_D76F[param_00])) {
    var_10 = self.var_D76F[param_00];
    var_11 = func_D720(var_10);
    if(var_11 > 0) {
      var_12 = var_0D.charges * var_0E.cooldowntime;
      var_0D.charges = int(var_12 - var_11 / var_0E.cooldowntime);
      if(var_0D.charges < 0) {
        var_0D.charges = 0;
      }

      var_0F = var_11;
      while(var_0F > var_0E.cooldowntime) {
        var_0F = var_0F - var_0E.cooldowntime;
      }
    }
  }

  if(param_01 == "scripted") {
    return;
  }

  var_0D.weaponuse = undefined;
  if(var_0E.weaponuse == "<power_script_generic_weapon>") {
    var_0D.weaponuse = scripts\engine\utility::ter_op(param_01 == "primary", "power_script_generic_primary_mp", "power_script_generic_secondary_mp");
  } else {
    var_0D.weaponuse = var_0E.weaponuse;
  }

  var_13 = _meth_8090(param_00);
  var_14 = scripts\engine\utility::ter_op(isDefined(var_13), var_13, var_0D.weaponuse);
  var_0D.weaponuse = var_14;
  self giveweapon(var_14, 0);
  self setweaponammoclip(var_14, var_0D.charges);
  if(var_0D.slot == "primary") {
    self assignweaponoffhandprimary(var_14);
    self.powerprimarygrenade = var_14;
  } else if(var_0D.slot == "secondary") {
    self assignweaponoffhandsecondary(var_14);
    self.powersecondarygrenade = var_14;
  }

  if(isDefined(level.var_D786[param_00])) {
    self[[level.var_D786[param_00]]](param_00);
  }

  if(isDefined(param_06) && !param_06) {
    thread func_E0AD(param_00);
  }

  if(!isai(self)) {
    thread func_D73D(param_00);
    thread func_B2F0(var_0E, param_00, var_0D.slot, var_0E.cooldowntime, var_0E.var_12ED9, var_0E.usednotify, var_14, var_0F, param_02);
  }
}

removepower(param_00) {
  if(isDefined(level.var_D79B[param_00])) {
    self[[level.var_D79B[param_00]]]();
  }

  if(isDefined(self.powers[param_00].weaponuse)) {
    self takeweapon(self.powers[param_00].weaponuse);
  }

  if(self.powers[param_00].slot == "primary") {
    self _meth_844D();
    self.powerprimarygrenade = undefined;
  } else if(self.powers[param_00].slot == "secondary") {
    self gonevo();
    self.powersecondarygrenade = undefined;
  }

  self notify("power_removed_" + param_00);
  func_13F00(self.powers[param_00].slot);
  self.powers[param_00] = undefined;
}

func_13F00(param_00) {
  if(param_00 == "scripted") {
    return;
  }

  self setclientomnvar(scripts\cp\zombies\_powerup_ability::powershud_getslotomnvar(param_00, 2), 0);
  self setclientomnvar(scripts\cp\zombies\_powerup_ability::powershud_getslotomnvar(param_00, 1), 0);
  self setclientomnvar(scripts\cp\zombies\_powerup_ability::powershud_getslotomnvar(param_00, 0), -1);
  self setclientomnvar(scripts\cp\zombies\_powerup_ability::powershud_getslotomnvar(param_00, 3), 0);
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

func_4171(param_00) {
  var_01 = self.powers;
  var_02 = func_D739();
  foreach(var_04 in var_02) {
    if(var_01[var_04].slot == param_00) {
      self.powers[var_04] = undefined;
      self notify("clear_power_slot" + var_04);
      removepower(var_04);
    }
  }

  func_13F00(param_00);
}

what_power_is_in_slot(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  var_03 = getarraykeys(self.powers);
  foreach(var_05 in var_03) {
    if(isDefined(self.powers[var_05].slot) && self.powers[var_05].slot == param_00) {
      var_02 = var_05;
      return var_02;
    }
  }

  return undefined;
}

func_D735(param_00) {
  return scripts\engine\utility::ter_op(self.powers[param_00].slot == "primary", "+frag", "+smoke");
}

func_D725(param_00, param_01, param_02, param_03, param_04) {
  var_05 = level.powers[param_00];
  var_06 = spawnStruct();
  var_06.slot = param_01;
  var_06.charges = var_05.maxcharges;
  if(scripts\engine\utility::istrue(param_02)) {
    var_06.charges++;
  }

  var_06.maxcharges = var_06.charges;
  var_06.var_93DD = 0;
  var_06.var_19 = 0;
  var_06.var_4619 = 0;
  var_06.cooldownratemod = 1;
  var_06.cooldown = param_03;
  var_06.permanent = param_04;
  var_06.passives = [];
  self.powers[param_00] = var_06;
}

func_B2F0(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + param_01);
  level endon("game_ended");
  if((isDefined(param_08) && param_08) || param_01 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + param_01);
  scripts\cp\zombies\_powerup_ability::powershud_assignpower(param_02, int(param_00.id), 1, int(self.powers[param_01].charges));
  scripts\cp\utility::gameflagwait("prematch_done");
  func_D750(param_02, 2);
  for(;;) {
    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      scripts\engine\utility::waittill_any_3("revive", "revive_success", "challenge_complete_revive");
    }

    func_D765(param_01);
    var_09 = param_06 + "_success";
    thread func_13A0E(param_03, param_01, var_09);
    var_0A = scripts\engine\utility::ter_op(param_00.var_130F3 == "weapon_hold", "offhand_pullback", "offhand_fired");
    self waittill(var_0A, var_0B);
    if(var_0B != param_06) {
      continue;
    }

    param_03 = controlslinkto(param_00);
    self notify(var_09);
    if(self.powers[param_01].charges != 0 && !self.powers[param_01].var_19) {
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

      if(!isDefined(self.dont_use_charges) || self.dont_use_charges != param_01) {
        if(!func_9EE3(param_01) && !isDefined(self.throwinggrenade)) {
          power_adjustcharges(-1, self.powers[param_01].slot);
        }
      }
    }

    if(isDefined(param_04) && level.powers[param_01].var_12B2B == "drain" && !scripts\engine\utility::istrue(self.powers[param_01].var_940B)) {
      func_D72B(param_01);
    }

    thread func_D72A(param_01, param_03, param_08);
  }
}

func_9EE3(param_00) {
  switch (param_00) {
    case "power_clusterGrenade":
    case "power_frag":
      return 1;

    default:
      return 0;
  }
}

controlslinkto(param_00) {
  if(scripts\engine\utility::istrue(level.var_D788)) {
    return 0.1;
  }

  if(scripts\engine\utility::istrue(level.infinite_grenades)) {
    return 2.5;
  }

  if(scripts\cp\utility::is_consumable_active("grenade_cooldown")) {
    return param_00.cooldowntime;
  }

  return param_00.cooldowntime;
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
      power_adjustcharges(1, var_03);
    }

    var_05 = var_01.var_91B1;
    if(var_05 == 1) {
      func_D750(var_03, 2);
    }
  }
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

func_E0AD(param_00) {
  self endon("disconnect");
  self endon("power_removed_" + param_00);
  level endon("game_ended");
  var_01 = self.powers[param_00];
  while(isDefined(self.powers[param_00])) {
    self waittill("power_used " + param_00);
    if(scripts\engine\utility::istrue(level.var_D788)) {
      continue;
    }

    if(var_01.charges < 1) {
      while(self isswitchingweapon() || scripts\engine\utility::array_contains(self.powers_active, param_00)) {
        wait(0.25);
      }

      wait(0.25);
      thread removepower(param_00);
    }
  }
}

func_D752(param_00) {
  if(!isDefined(self.powers[param_00])) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.powers[param_00].cooldown)) {
    return 1;
  }

  if(scripts\engine\utility::istrue(level.var_D788)) {
    return 1;
  }

  if(level.powers[param_00].var_13058) {
    return 1;
  }

  if(isDefined(self.powers[param_00].slot) && self.powers[param_00].slot != "primary") {
    return 0;
  }

  if(scripts\cp\utility::is_consumable_active("grenade_cooldown") && level.powers[param_00].defaultslot != "secondary") {
    return 1;
  }

  if(scripts\engine\utility::istrue(level.infinite_grenades)) {
    return 1;
  }

  return 0;
}

activatepower(param_00) {
  self.powers_active[self.powers_active.size] = param_00;
}

deactivatepower(param_00) {
  if(scripts\engine\utility::array_contains(self.powers_active, param_00)) {
    self.powers_active = scripts\engine\utility::array_remove(self.powers_active, param_00);
  }
}

func_D72A(param_00, param_01, param_02) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + param_00);
  self endon("power_cooldown_ended" + param_00);
  if((isDefined(param_02) && param_02) || param_00 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + param_00);
  self notify("power_cooldown_begin_" + param_00);
  self endon("power_cooldown_begin_" + param_00);
  level endon("game_ended");
  var_03 = level.powers[param_00];
  var_04 = self.powers[param_00];
  var_05 = var_04.slot;
  var_06 = param_00 + "_cooldown_update";
  var_04.var_93DD = 1;
  if(!isDefined(var_04.var_461C)) {
    var_04.var_461C = 0;
  }

  var_04.var_461C++;
  if(!isDefined(var_04.var_4617)) {
    var_04.var_4617 = 0;
  }

  if(!isDefined(var_04.var_4619)) {
    var_04.var_4619 = 0;
  }

  var_04.var_4619 = var_04.var_4619 + param_01;
  var_07 = var_04.var_91B1;
  if(isDefined(var_07) && var_07 != 0 && var_04.charges == 0) {
    func_D750(var_05, 1);
  }

  while(var_04.charges < var_04.maxcharges) {
    if(func_D752(param_00)) {
      wait(0.1);
    } else {
      level scripts\engine\utility::waittill_any_3("grenade_cooldown activated", "infinite_grenade_active", "start_power_cooldown");
      param_01 = controlslinkto(var_03);
    }

    if(var_04.var_4617 > param_01) {
      power_adjustcharges(1, var_05);
      func_D765(param_00);
      if(var_04.charges == var_04.maxcharges) {
        thread func_D730(param_00, param_02);
      }

      var_04.var_4617 = var_04.var_4617 - param_01;
      var_04.var_4619 = var_04.var_4619 - param_01;
      var_04.var_461C--;
      if(isDefined(var_07) && var_07 != 0) {
        func_D750(var_05, 2);
      }
    } else {
      var_04.var_4617 = var_04.var_4617 + 0.1;
      var_04.var_4619 = var_04.var_4619 - 0.1;
    }

    var_08 = min(1, var_04.var_4617 / param_01);
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

func_F85A(param_00) {
  self.powers[param_00].value = 0;
}

unsetspeedboost() {}

func_130DA() {}

func_F7E2(param_00) {}

func_12D07() {
  scripts\cp\powers\coop_phaseshift::func_E154();
}

usephaseshift() {
  scripts\cp\powers\coop_phaseshift::func_E88D();
}

func_12D2C() {}

func_130D5() {}

func_F676(param_00) {}

func_12C89() {}

func_13051() {}

settransponder(param_00) {}

unsettransponder() {
  self notify("detonate_transponder");
}

func_F776(param_00) {
  level.powers[param_00].var_5FF3 = 3;
}

unsetkillstreaktoscorestreak() {}

func_1309C() {
  scripts\cp\powers\coop_kinetic_pulse::func_E85E();
}

func_F6B1(param_00) {
  self allowdodge(1);
  self.var_38A1 = 1;
  self _meth_8454(3);
}

func_12C9F() {
  self allowdodge(0);
  self.var_38A1 = 0;
}

func_13072() {}

func_F7C8(param_00) {}

func_12CFB() {}

func_130B4() {}

func_F7E7(param_00) {}

func_12D0B() {}

usephasesplit() {}

setcloak(param_00) {}

unsetcloak() {}

func_13054() {}

func_F87E(param_00) {}

func_12D44() {}

func_130E7() {}

func_F7CC(param_00) {}

func_12CFD() {}

useovercharge() {}

func_F84A(param_00) {}

func_12D30() {}

func_130D7() {}

func_F69C(param_00) {}

unsetcomlink(param_00) {}

func_13055() {}

func_F84C(param_00) {}

func_12D31() {}

func_130D8() {}

func_F87F(param_00) {}

func_12D45() {}

func_130E8() {}

func_F777(param_00) {}

unsetkineticpulse() {}

func_1309D() {}

func_F81A(param_00) {}

func_12D18() {}

func_130CB() {}

func_F658(param_00) {
  level.powers[param_00].var_5FF3 = 30;
}

func_12C78() {}

func_13049() {}

func_F7A5(param_00) {}

func_12CF3() {}

func_130A5() {}

usearmageddon() {
  scripts\cp\powers\coop_armageddon::armageddon_use();
}

setrewind(param_00) {
  scripts\cp\powers\coop_rewind::setrewind();
}

unsetrewind() {
  scripts\cp\powers\coop_rewind::unsetrewind();
}

userewind() {}

userepulsor() {
  scripts\cp\powers\coop_repulsor::userepulsor();
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
    if((isDefined(self.powers[var_04].slot) && self.powers[var_04].slot == param_01) || param_01 == "all") {
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

power_adjustcharges(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = "all";
  }

  var_03 = func_D739();
  var_04 = param_00;
  foreach(var_06 in var_03) {
    if(!isDefined(param_00)) {
      var_04 = level.powers[var_06].maxcharges;
    }

    if(self.powers[var_06].slot == param_01 || param_01 == "all") {
      if(isDefined(param_02)) {
        self.powers[var_06].charges = int(min(var_04, level.powers[var_06].maxcharges));
      } else if(self.powers[var_06].charges + var_04 >= 0) {
        self.powers[var_06].charges = self.powers[var_06].charges + var_04;
      } else {
        self.powers[var_06].charges = 0;
      }

      self.powers[var_06].charges = int(clamp(self.powers[var_06].charges, 0, level.powers[var_06].maxcharges));
      self setweaponammoclip(self.powers[var_06].weaponuse, self.powers[var_06].charges);
      self notify("power_used " + var_06);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(self.powers[var_06].slot, self.powers[var_06].charges);
    }
  }
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

power_disablepower(param_00) {
  if(scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(0);
  }
}

power_enablepower(param_00) {
  if(!scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(1);
  }
}

usequickslothealitem(param_00) {
  scripts\cp\utility::_giveweapon(param_00);
  self switchtoweapon(param_00);
  wait(1);
  self switchtoweapon(param_00);
  self takeweapon(param_00);
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

func_13A0E(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + param_01);
  self endon(param_02);
  level endon("game_ended");
  self waittill("offhand_fired", var_03);
  var_04 = self.powers[param_01];
  if(isDefined(var_03) && var_03 == var_04.weaponuse) {
    if(!isalive(self)) {
      if(var_04.charges > 0) {
        power_adjustcharges(-1, var_04.slot);
      }

      if(!var_04.var_93DD) {
        var_04.var_4619 = level.powers[param_01].cooldowntime;
        thread func_D72A(param_01, param_00);
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

    case "ztransponder_mp":
    case "transponder_mp":
      self.triggerportableradarping notify("transponder_update", 0);
      break;

    case "sticky_mine_mp":
      self.triggerportableradarping notify("sticky_mine_update", 0);
      break;

    case "sonic_sensor_mp":
      self.triggerportableradarping notify("sonic_sensor_update", 0);
      break;

    case "trophy_mp":
      self.triggerportableradarping notify("trophy_update", 0);
      break;

    case "cryo_grenade_mp":
      self.triggerportableradarping notify("restart_cryo_grenade_cooldown", 0);
      break;

    case "micro_turret_zm":
    case "micro_turret_mp":
      self.triggerportableradarping notify("microTurret_update", 0);
      break;

    default:
      break;
  }
}

func_9F0A(param_00) {
  switch (param_00) {
    case "armorup_mp":
    case "iw7_niagara_mp":
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

func_7952(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_02.origin;
  if(!isDefined(var_05)) {
    return 0;
  }

  var_06 = vectornormalize(var_05 - param_00);
  if(!isDefined(param_04) || param_04 == "forward") {
    var_07 = anglesToForward(param_01);
  } else {
    var_07 = anglestoright(param_02);
  }

  var_08 = vectordot(var_07, var_06);
  return var_08 >= param_03;
}

give_player_crafted_power(param_00, param_01) {
  var_02 = param_00.power_name;
  var_03 = level.powers[var_02].defaultslot;
  param_01 thread givepower(var_02, var_03, undefined, undefined, undefined, 0, 0);
  param_01 playlocalsound("grenade_pickup");
  param_01 notify("new_power", var_02);
}

give_player_wall_bought_power(param_00, param_01) {
  var_02 = param_00.power_name;
  var_03 = level.powers[var_02].defaultslot;
  param_01 thread givepower(var_02, var_03, undefined, undefined, undefined, 0, 1);
  param_01 playlocalsound("grenade_pickup");
  param_01 notify("new_power", var_02);
}

power_watch_hint(param_00) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self.var_1268B = 0;
  self.var_B702 = 0;
  self.var_E4C6 = 0;
  self.var_F18D = 0;
  self.var_CAAB = 0;
  self.var_3CE6 = 0;
  self.var_2176 = 0;
  self.var_A6D6 = 0;
  self.var_A871 = 0;
  self.var_2690 = 0;
  self.var_936B = 0;
  self.var_B53E = 0;
  self.var_6018 = 0;
  self.var_2C9F = 0;
  self.var_E4B3 = 0;
  self.var_76C6 = 0;
  self.var_10487 = 0;
  self.mower_hint_displayed = 0;
  self.balloon_hint_displayed = 0;
  self.robot_hint_displayed = 0;
  self.lavalamp_hint_displayed = 0;
  self.zombgone_hint_displayed = 0;
  self.rad_extractor_hint_displayed = 0;
  param_00 = scripts\engine\utility::istrue(param_00);
  for(;;) {
    self waittill("new_power", var_01);
    wait(1);
    switch (var_01) {
      case "power_transponder":
        if(self.var_1268B < 3 && !param_00) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_TRANSPONDER", 4);
          self.var_1268B = self.var_1268B + 1;
        }
        break;

      case "power_rewind":
        if(self.var_E4C6 < 3 && !param_00) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_REWIND", 4);
          self.var_E4C6 = self.var_E4C6 + 1;
        }
        break;

      case "power_microTurret":
        if(self.var_B702 < 3 && !param_00) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_MICROTURRET", 4);
          self.var_B702 = self.var_B702 + 1;
        }
        break;

      case "power_siegeMode":
        if(self.var_F18D < 3 && !param_00) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_SIEGEMODE", 4);
          self.var_F18D = self.var_F18D + 1;
        }
        break;

      case "power_phaseShift":
        if(self.var_CAAB < 3 && !param_00) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_PHASESHIFT", 4);
          self.var_CAAB = self.var_CAAB + 1;
        }
        break;

      case "power_chargeMode":
        if(self.var_3CE6 < 3 && !param_00) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_CHARGEMODE", 4);
          self.var_3CE6 = self.var_3CE6 + 1;
        }
        break;

      case "power_armageddon":
        if(self.var_2176 < 3 && !param_00) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_ARMAGEDDON", 4);
          self.var_2176 = self.var_2176 + 1;
        }
        break;

      case "power_kineticPulse":
        if(self.var_A6D6 < 3 && !param_00) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_KINETICPULSE", 4);
          self.var_A6D6 = self.var_A6D6 + 1;
        }
        break;

      case "crafted_windowtrap":
        if(self.var_A871 < 3) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_HINT_LASER_WINDOW_TRAP", 4);
          self.var_A871 = self.var_A871 + 1;
        }
        break;

      case "crafted_autosentry":
        if(self.var_2690 < 3) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_HINT_AUTOSENTRY", 4);
          self.var_2690 = self.var_2690 + 1;
        }
        break;

      case "crafted_ims":
        if(self.var_936B < 3) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_HINT_IMS", 4);
          self.var_936B = self.var_936B + 1;
        }
        break;

      case "crafted_medusa":
        if(self.var_B53E < 3) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_HINT_MEDUSA", 4);
          self.var_B53E = self.var_B53E + 1;
        }
        break;

      case "crafted_electric_trap":
        if(self.var_6018 < 3) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_HINT_ELECTRICTRAP", 4);
          self.var_6018 = self.var_6018 + 1;
        }
        break;

      case "crafted_boombox":
        if(self.var_2C9F < 3) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_HINT_BOOMBOX", 4);
          self.var_6018 = self.var_6018 + 1;
        }
        break;

      case "crafted_revocator":
        if(self.var_E4B3 < 3) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_HINT_REVOCATOR", 4);
          self.var_E4B3 = self.var_E4B3 + 1;
        }
        break;

      case "crafted_gascan":
        if(self.var_76C6 < 3) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"ZOMBIE_CRAFTING_SOUVENIRS_HINT_GASCAN", 4);
          self.var_76C6 = self.var_76C6 + 1;
        }
        break;

      case "crafted_trap_mower":
        if(self.mower_hint_displayed < 2) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_RAVE_HINT_MOWER", 4);
          self.mower_hint_displayed = self.mower_hint_displayed + 1;
        }
        break;

      case "crafted_trap_balloon":
        if(self.balloon_hint_displayed < 2) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_RAVE_HINT_BALLOONS", 4);
          self.balloon_hint_displayed = self.balloon_hint_displayed + 1;
        }
        break;

      case "crafted_robot":
        if(self.robot_hint_displayed < 2) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_DISCO_USE_ROBOT", 4);
          self.robot_hint_displayed = self.robot_hint_displayed + 1;
        }
        break;

      case "crafted_lavalamp":
        if(self.lavalamp_hint_displayed < 2) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_DISCO_USE_LAVA_LAMP", 4);
          self.lavalamp_hint_displayed = self.lavalamp_hint_displayed + 1;
        }
        break;

      case "crafted_rad_extractor":
        if(self.rad_extractor_hint_displayed < 2) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_DISCO_USE_LAVA_LAMP", 4);
          self.rad_extractor_hint_displayed = self.rad_extractor_hint_displayed + 1;
        }
        break;

      case "crafted_zombgone":
        if(self.zombgone_hint_displayed < 2) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_DISCO_USE_ZOMBGONE", 4);
          self.zombgone_hint_displayed = self.zombgone_hint_displayed + 1;
        }
        break;
    }
  }
}

get_info_for_player_powers(param_00) {
  var_01 = [];
  foreach(var_03 in getarraykeys(param_00.powers)) {
    var_04 = spawnStruct();
    var_04.slot = param_00.powers[var_03].slot;
    var_04.charges = param_00.powers[var_03].charges;
    var_04.cooldown = param_00.powers[var_03].cooldown;
    var_04.permanent = param_00.powers[var_03].permanent;
    var_01[var_03] = var_04;
  }

  return var_01;
}

restore_powers(param_00, param_01) {
  foreach(var_06, var_03 in param_01) {
    var_04 = undefined;
    var_05 = 0;
    if(scripts\engine\utility::istrue(var_03.cooldown)) {
      var_04 = 1;
    }

    if(scripts\engine\utility::istrue(var_03.permanent)) {
      var_05 = 1;
    }

    if(var_03.slot == "secondary") {
      if(var_06 == "power_bait") {
        param_00 givepower(var_06, var_03.slot, undefined, undefined, undefined, 1, 1);
      } else {
        param_00 givepower(var_06, var_03.slot, undefined, undefined, undefined, var_04, var_05);
      }

      param_00 power_adjustcharges(var_03.charges, var_03.slot, 1);
      continue;
    }

    param_00 givepower(var_06, var_03.slot, undefined, undefined, undefined, undefined, 1);
    param_00 power_adjustcharges(var_03.charges, var_03.slot, 1);
  }
}

giveholywater(param_00) {
  scripts\cp\powers\coop_holywater::giveholywater();
}

takeholywater(param_00) {
  scripts\cp\powers\coop_holywater::takeholywater();
}