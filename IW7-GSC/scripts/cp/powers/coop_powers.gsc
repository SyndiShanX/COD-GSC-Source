/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
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

func_42DD(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("power_removed_power_clusterGrenade");
  if(!isDefined(var_1) || var_1 != "cluster_grenade_zm") {
    return;
  }

  if(!var_0 hasequipment("power_clusterGrenade")) {
    return;
  }

  var_2 = spawn("script_model", var_0.origin);
  var_3 = "power_clusterGrenade";
  thread scripts\cp\cp_weapon::clustergrenadeexplode(var_0.origin, scripts\engine\utility::array_randomize([0.2, 0.25, 0.25, 0.3]), var_0, var_2);
  var_0 power_adjustcharges(var_0.powers[var_3].charges - 1, var_0.powers[var_3].slot, 1);
  var_0 func_D765(var_3);
  var_0 thread func_E1F1();
  var_0 thread func_5166(var_3);
}

func_7358(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_2 = "power_frag";
  var_0 endon("power_removed_" + var_2);
  if(!isDefined(var_1) || var_1 != "frag_grenade_zm") {
    return;
  }

  if(!var_0 hasequipment(var_2)) {
    return;
  }

  var_3 = var_0.origin;
  playFX(scripts\engine\utility::getfx("clusterGrenade_explode"), var_3);
  playsoundatpos(var_3, "grenade_explode");
  if(!isDefined(var_0.powers[var_2])) {
    return;
  }

  var_0 power_adjustcharges(var_0.powers[var_2].charges - 1, var_0.powers[var_2].slot, 1);
  var_0 func_D765(var_2);
  var_0 radiusdamage(var_3, 256, 150, 100, var_0, "MOD_GRENADE", "frag_grenade_zm");
  playrumbleonposition("grenade_rumble", var_3);
  earthquake(0.5, 0.75, var_3, 800);
  foreach(var_5 in level.players) {
    if(var_5 scripts\cp\utility::isusingremote()) {
      continue;
    }

    if(distancesquared(var_3, var_5.origin) > 360000) {
      continue;
    }

    if(var_5 damageconetrace(var_3)) {
      var_5 thread scripts\cp\cp_weapon::dirteffect(var_3);
    }

    var_5 setclientomnvar("ui_hud_shake", 1);
  }

  var_0 thread func_E1F1();
  var_0 thread func_5166(var_2);
}

func_E1F1() {
  self endon("death");
  self getquadrant();
  while(self fragButtonPressed()) {
    wait(0.1);
  }

  wait(0.1);
  self enableoffhandweapons();
}

func_5166(var_0) {
  self endon("death");
  self endon("end_last_second_throw_func");
  self notify("starting_delay_last_second_grenade_throws");
  thread func_62CD(0.25);
  self waittill("grenade_fire", var_1, var_2, var_3, var_4);
  if(isDefined(var_1) && var_1.classname == "grenade") {
    var_1 delete();
    power_adjustcharges(self.powers[var_0].charges + 1, self.powers[var_0].slot, 1);
  }
}

func_62CD(var_0) {
  self endon("death");
  wait(var_0);
  self notify("end_last_second_throw_func");
}

func_D724(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_10.var_130F3 = var_1;
  var_10.weaponuse = var_2;
  var_10.cooldowntime = var_4;
  var_10.id = var_3;
  var_10.maxcharges = var_5;
  var_10.var_4E5A = var_6;
  var_10.var_13058 = var_7;
  var_10.var_12B2B = var_8;
  var_10.defaultslot = var_9;
  level.powers[var_0] = var_10;
}

func_D77D() {
  var_0 = 1;
  if(isDefined(level.power_table)) {
    var_1 = level.power_table;
  } else {
    var_1 = "cp\cp_powertable.csv";
  }

  for(;;) {
    var_2 = tablelookupbyrow(var_1, var_0, 0);
    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_0, 1);
    var_4 = tablelookupbyrow(var_1, var_0, 6);
    var_5 = tablelookupbyrow(var_1, var_0, 7);
    var_6 = tablelookupbyrow(var_1, var_0, 8);
    var_7 = tablelookupbyrow(var_1, var_0, 9);
    var_8 = tablelookupbyrow(var_1, var_0, 10);
    var_9 = tablelookupbyrow(var_1, var_0, 11);
    var_10 = tablelookupbyrow(var_1, var_0, 16);
    var_11 = tablelookupbyrow(var_1, var_0, 13);
    func_D724(var_3, var_4, var_5, int(var_2), float(var_6), int(var_7), int(var_8), int(var_9), var_10, var_11);
    if(isDefined(level.var_D7A4[var_5]) && var_5 != "<power_script_generic_weapon>") {
      switch (var_5) {
        case "power_rewind":
          if(var_3 == "power_rewinder") {
            break;
          }

          break;

        default:
          break;
      }
    }

    level.var_D7A4[var_5] = var_3;
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
  if(!isDefined(level.var_D77F)) {
    return undefined;
  }

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

givepower(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 2;
  if(!isDefined(self.powers)) {
    self.powers = [];
  }

  if(var_0 == "none") {
    return;
  }

  if(var_1 == "scripted") {
    var_7++;
  }

  for(var_8 = self func_854D(); var_8 != "none"; var_8 = self func_854D()) {
    scripts\engine\utility::waitframe();
  }

  var_9 = getarraykeys(self.powers);
  foreach(var_11 in var_9) {
    if(self.powers[var_11].slot == var_1) {
      self.var_A037 = var_11;
      removepower(var_11);
      scripts\cp\zombies\zombie_analytics::func_AF76(self.var_A037, level.transactionid);
      break;
    }
  }

  func_D725(var_0, var_1, var_4, var_5, var_6);
  var_13 = self.powers[var_0];
  var_14 = level.powers[var_0];
  self notify("delete_equipment " + var_1);
  if(isDefined(var_3)) {
    var_13.passives = var_3;
  }

  var_15 = 0;
  if(isDefined(self.var_D76F) && isDefined(self.var_D76F[var_0])) {
    var_10 = self.var_D76F[var_0];
    var_11 = func_D720(var_10);
    if(var_11 > 0) {
      var_12 = var_13.charges * var_14.cooldowntime;
      var_13.charges = int(var_12 - var_11 / var_14.cooldowntime);
      if(var_13.charges < 0) {
        var_13.charges = 0;
      }

      var_15 = var_11;
      while(var_15 > var_14.cooldowntime) {
        var_15 = var_15 - var_14.cooldowntime;
      }
    }
  }

  if(var_1 == "scripted") {
    return;
  }

  var_13.weaponuse = undefined;
  if(var_14.weaponuse == "<power_script_generic_weapon>") {
    var_13.weaponuse = scripts\engine\utility::ter_op(var_1 == "primary", "power_script_generic_primary_mp", "power_script_generic_secondary_mp");
  } else {
    var_13.weaponuse = var_14.weaponuse;
  }

  var_13 = func_8090(var_0);
  var_14 = scripts\engine\utility::ter_op(isDefined(var_13), var_13, var_13.weaponuse);
  var_13.weaponuse = var_14;
  self giveweapon(var_14, 0);
  self setweaponammoclip(var_14, var_13.charges);
  if(var_13.slot == "primary") {
    self assignweaponoffhandprimary(var_14);
    self.powerprimarygrenade = var_14;
  } else if(var_13.slot == "secondary") {
    self assignweaponoffhandsecondary(var_14);
    self.powersecondarygrenade = var_14;
  }

  if(isDefined(level.var_D786[var_0])) {
    self[[level.var_D786[var_0]]](var_0);
  }

  if(isDefined(var_6) && !var_6) {
    thread func_E0AD(var_0);
  }

  if(!isai(self)) {
    thread func_D73D(var_0);
    thread func_B2F0(var_14, var_0, var_13.slot, var_14.cooldowntime, var_14.var_12ED9, var_14.usednotify, var_14, var_15, var_2);
  }
}

removepower(var_0) {
  if(isDefined(level.var_D79B[var_0])) {
    self[[level.var_D79B[var_0]]]();
  }

  if(isDefined(self.powers[var_0].weaponuse)) {
    self takeweapon(self.powers[var_0].weaponuse);
  }

  if(self.powers[var_0].slot == "primary") {
    self func_844D();
    self.powerprimarygrenade = undefined;
  } else if(self.powers[var_0].slot == "secondary") {
    self gonevo();
    self.powersecondarygrenade = undefined;
  }

  self notify("power_removed_" + var_0);
  func_13F00(self.powers[var_0].slot);
  self.powers[var_0] = undefined;
}

func_13F00(var_0) {
  if(var_0 == "scripted") {
    return;
  }

  self setclientomnvar(scripts\cp\zombies\_powerup_ability::powershud_getslotomnvar(var_0, 2), 0);
  self setclientomnvar(scripts\cp\zombies\_powerup_ability::powershud_getslotomnvar(var_0, 1), 0);
  self setclientomnvar(scripts\cp\zombies\_powerup_ability::powershud_getslotomnvar(var_0, 0), -1);
  self setclientomnvar(scripts\cp\zombies\_powerup_ability::powershud_getslotomnvar(var_0, 3), 0);
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

func_4171(var_0) {
  var_1 = self.powers;
  var_2 = func_D739();
  foreach(var_4 in var_2) {
    if(var_1[var_4].slot == var_0) {
      self.powers[var_4] = undefined;
      self notify("clear_power_slot" + var_4);
      removepower(var_4);
    }
  }

  func_13F00(var_0);
}

what_power_is_in_slot(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = getarraykeys(self.powers);
  foreach(var_5 in var_3) {
    if(isDefined(self.powers[var_5].slot) && self.powers[var_5].slot == var_0) {
      var_2 = var_5;
      return var_2;
    }
  }

  return undefined;
}

func_D735(var_0) {
  return scripts\engine\utility::ter_op(self.powers[var_0].slot == "primary", "+frag", "+smoke");
}

func_D725(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.powers[var_0];
  var_6 = spawnStruct();
  var_6.slot = var_1;
  var_6.charges = var_5.maxcharges;
  if(scripts\engine\utility::istrue(var_2)) {
    var_6.charges++;
  }

  var_6.maxcharges = var_6.charges;
  var_6.var_93DD = 0;
  var_6.var_19 = 0;
  var_6.var_4619 = 0;
  var_6.cooldownratemod = 1;
  var_6.cooldown = var_3;
  var_6.permanent = var_4;
  var_6.passives = [];
  self.powers[var_0] = var_6;
}

func_B2F0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_1);
  level endon("game_ended");
  if((isDefined(var_8) && var_8) || var_1 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + var_1);
  scripts\cp\zombies\_powerup_ability::powershud_assignpower(var_2, int(var_0.id), 1, int(self.powers[var_1].charges));
  scripts\cp\utility::gameflagwait("prematch_done");
  func_D750(var_2, 2);
  for(;;) {
    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      scripts\engine\utility::waittill_any("revive", "revive_success", "challenge_complete_revive");
    }

    func_D765(var_1);
    var_9 = var_6 + "_success";
    thread func_13A0E(var_3, var_1, var_9);
    var_10 = scripts\engine\utility::ter_op(var_0.var_130F3 == "weapon_hold", "offhand_pullback", "offhand_fired");
    self waittill(var_10, var_11);
    if(var_11 != var_6) {
      continue;
    }

    var_3 = controlslinkto(var_0);
    self notify(var_9);
    if(self.powers[var_1].charges != 0 && !self.powers[var_1].var_19) {
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

      if(!isDefined(self.dont_use_charges) || self.dont_use_charges != var_1) {
        if(!func_9EE3(var_1) && !isDefined(self.throwinggrenade)) {
          power_adjustcharges(-1, self.powers[var_1].slot);
        }
      }
    }

    if(isDefined(var_4) && level.powers[var_1].var_12B2B == "drain" && !scripts\engine\utility::istrue(self.powers[var_1].var_940B)) {
      func_D72B(var_1);
    }

    thread func_D72A(var_1, var_3, var_8);
  }
}

func_9EE3(var_0) {
  switch (var_0) {
    case "power_clusterGrenade":
    case "power_frag":
      return 1;

    default:
      return 0;
  }
}

controlslinkto(var_0) {
  if(scripts\engine\utility::istrue(level.var_D788)) {
    return 0.1;
  }

  if(scripts\engine\utility::istrue(level.infinite_grenades)) {
    return 2.5;
  }

  if(scripts\cp\utility::is_consumable_active("grenade_cooldown")) {
    return var_0.cooldowntime;
  }

  return var_0.cooldowntime;
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
      power_adjustcharges(1, var_3);
    }

    var_5 = var_1.var_91B1;
    if(var_5 == 1) {
      func_D750(var_3, 2);
    }
  }
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

func_E0AD(var_0) {
  self endon("disconnect");
  self endon("power_removed_" + var_0);
  level endon("game_ended");
  var_1 = self.powers[var_0];
  while(isDefined(self.powers[var_0])) {
    self waittill("power_used " + var_0);
    if(scripts\engine\utility::istrue(level.var_D788)) {
      continue;
    }

    if(var_1.charges < 1) {
      while(self isswitchingweapon() || scripts\engine\utility::array_contains(self.powers_active, var_0)) {
        wait(0.25);
      }

      wait(0.25);
      thread removepower(var_0);
    }
  }
}

func_D752(var_0) {
  if(!isDefined(self.powers[var_0])) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.powers[var_0].cooldown)) {
    return 1;
  }

  if(scripts\engine\utility::istrue(level.var_D788)) {
    return 1;
  }

  if(level.powers[var_0].var_13058) {
    return 1;
  }

  if(isDefined(self.powers[var_0].slot) && self.powers[var_0].slot != "primary") {
    return 0;
  }

  if(scripts\cp\utility::is_consumable_active("grenade_cooldown") && level.powers[var_0].defaultslot != "secondary") {
    return 1;
  }

  if(scripts\engine\utility::istrue(level.infinite_grenades)) {
    return 1;
  }

  return 0;
}

activatepower(var_0) {
  self.powers_active[self.powers_active.size] = var_0;
}

deactivatepower(var_0) {
  if(scripts\engine\utility::array_contains(self.powers_active, var_0)) {
    self.powers_active = scripts\engine\utility::array_remove(self.powers_active, var_0);
  }
}

func_D72A(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  self endon("power_cooldown_ended" + var_0);
  if((isDefined(var_2) && var_2) || var_0 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + var_0);
  self notify("power_cooldown_begin_" + var_0);
  self endon("power_cooldown_begin_" + var_0);
  level endon("game_ended");
  var_3 = level.powers[var_0];
  var_4 = self.powers[var_0];
  var_5 = var_4.slot;
  var_6 = var_0 + "_cooldown_update";
  var_4.var_93DD = 1;
  if(!isDefined(var_4.var_461C)) {
    var_4.var_461C = 0;
  }

  var_4.var_461C++;
  if(!isDefined(var_4.var_4617)) {
    var_4.var_4617 = 0;
  }

  if(!isDefined(var_4.var_4619)) {
    var_4.var_4619 = 0;
  }

  var_4.var_4619 = var_4.var_4619 + var_1;
  var_7 = var_4.var_91B1;
  if(isDefined(var_7) && var_7 != 0 && var_4.charges == 0) {
    func_D750(var_5, 1);
  }

  while(var_4.charges < var_4.maxcharges) {
    if(func_D752(var_0)) {
      wait(0.1);
    } else {
      level scripts\engine\utility::waittill_any("grenade_cooldown activated", "infinite_grenade_active", "start_power_cooldown");
      var_1 = controlslinkto(var_3);
    }

    if(var_4.var_4617 > var_1) {
      power_adjustcharges(1, var_5);
      func_D765(var_0);
      if(var_4.charges == var_4.maxcharges) {
        thread func_D730(var_0, var_2);
      }

      var_4.var_4617 = var_4.var_4617 - var_1;
      var_4.var_4619 = var_4.var_4619 - var_1;
      var_4.var_461C--;
      if(isDefined(var_7) && var_7 != 0) {
        func_D750(var_5, 2);
      }
    } else {
      var_4.var_4617 = var_4.var_4617 + 0.1;
      var_4.var_4619 = var_4.var_4619 - 0.1;
    }

    var_8 = min(1, var_4.var_4617 / var_1);
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

func_F85A(var_0) {
  self.powers[var_0].value = 0;
}

unsetspeedboost() {}

func_130DA() {}

func_F7E2(var_0) {}

func_12D07() {
  scripts\cp\powers\coop_phaseshift::func_E154();
}

usephaseshift() {
  scripts\cp\powers\coop_phaseshift::func_E88D();
}

func_12D2C() {}

func_130D5() {}

func_F676(var_0) {}

func_12C89() {}

func_13051() {}

settransponder(var_0) {}

unsettransponder() {
  self notify("detonate_transponder");
}

func_F776(var_0) {
  level.powers[var_0].var_5FF3 = 3;
}

unsetkillstreaktoscorestreak() {}

func_1309C() {
  scripts\cp\powers\coop_kinetic_pulse::func_E85E();
}

func_F6B1(var_0) {
  self allowdodge(1);
  self.var_38A1 = 1;
  self func_8454(3);
}

func_12C9F() {
  self allowdodge(0);
  self.var_38A1 = 0;
}

func_13072() {}

func_F7C8(var_0) {}

func_12CFB() {}

func_130B4() {}

func_F7E7(var_0) {}

func_12D0B() {}

usephasesplit() {}

setcloak(var_0) {}

unsetcloak() {}

func_13054() {}

func_F87E(var_0) {}

func_12D44() {}

func_130E7() {}

func_F7CC(var_0) {}

func_12CFD() {}

useovercharge() {}

func_F84A(var_0) {}

func_12D30() {}

func_130D7() {}

func_F69C(var_0) {}

unsetcomlink(var_0) {}

func_13055() {}

func_F84C(var_0) {}

func_12D31() {}

func_130D8() {}

func_F87F(var_0) {}

func_12D45() {}

func_130E8() {}

func_F777(var_0) {}

unsetkineticpulse() {}

func_1309D() {}

func_F81A(var_0) {}

func_12D18() {}

func_130CB() {}

func_F658(var_0) {
  level.powers[var_0].var_5FF3 = 30;
}

func_12C78() {}

func_13049() {}

func_F7A5(var_0) {}

func_12CF3() {}

func_130A5() {}

usearmageddon() {
  scripts\cp\powers\coop_armageddon::armageddon_use();
}

setrewind(var_0) {
  scripts\cp\powers\coop_rewind::setrewind();
}

unsetrewind() {
  scripts\cp\powers\coop_rewind::unsetrewind();
}

userewind() {}

userepulsor() {
  scripts\cp\powers\coop_repulsor::userepulsor();
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
    if((isDefined(self.powers[var_4].slot) && self.powers[var_4].slot == var_1) || var_1 == "all") {
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

power_adjustcharges(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  var_3 = func_D739();
  var_4 = var_0;
  foreach(var_6 in var_3) {
    if(!isDefined(var_0)) {
      var_4 = level.powers[var_6].maxcharges;
    }

    if(self.powers[var_6].slot == var_1 || var_1 == "all") {
      if(isDefined(var_2)) {
        self.powers[var_6].charges = int(min(var_4, level.powers[var_6].maxcharges));
      } else if(self.powers[var_6].charges + var_4 >= 0) {
        self.powers[var_6].charges = self.powers[var_6].charges + var_4;
      } else {
        self.powers[var_6].charges = 0;
      }

      self.powers[var_6].charges = int(clamp(self.powers[var_6].charges, 0, level.powers[var_6].maxcharges));
      self setweaponammoclip(self.powers[var_6].weaponuse, self.powers[var_6].charges);
      self notify("power_used " + var_6);
      scripts\cp\zombies\_powerup_ability::powershud_updatepowercharges(self.powers[var_6].slot, self.powers[var_6].charges);
    }
  }
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

power_disablepower(var_0) {
  if(scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(0);
  }
}

power_enablepower(var_0) {
  if(!scripts\engine\utility::isoffhandweaponsallowed()) {
    scripts\engine\utility::allow_offhand_weapons(1);
  }
}

usequickslothealitem(var_0) {
  scripts\cp\utility::_giveweapon(var_0);
  self switchtoweapon(var_0);
  wait(1);
  self switchtoweapon(var_0);
  self takeweapon(var_0);
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

func_13A0E(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_1);
  self endon(var_2);
  level endon("game_ended");
  self waittill("offhand_fired", var_3);
  var_4 = self.powers[var_1];
  if(isDefined(var_3) && var_3 == var_4.weaponuse) {
    if(!isalive(self)) {
      if(var_4.charges > 0) {
        power_adjustcharges(-1, var_4.slot);
      }

      if(!var_4.var_93DD) {
        var_4.var_4619 = level.powers[var_1].cooldowntime;
        thread func_D72A(var_1, var_0);
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
        if(self useButtonPressed()) {
          if(var_5 == 0) {
            var_6 = 0.05;
          }

          var_10 = 0;
          while(self useButtonPressed()) {
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
        if(self useButtonPressed() == 0) {
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
  if((var_0 == "+frag" && self fragButtonPressed()) || var_0 == "+smoke" && self secondaryoffhandbuttonPressed()) {
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

    case "ztransponder_mp":
    case "transponder_mp":
      self.owner notify("transponder_update", 0);
      break;

    case "sticky_mine_mp":
      self.owner notify("sticky_mine_update", 0);
      break;

    case "sonic_sensor_mp":
      self.owner notify("sonic_sensor_update", 0);
      break;

    case "trophy_mp":
      self.owner notify("trophy_update", 0);
      break;

    case "cryo_grenade_mp":
      self.owner notify("restart_cryo_grenade_cooldown", 0);
      break;

    case "micro_turret_zm":
    case "micro_turret_mp":
      self.owner notify("microTurret_update", 0);
      break;

    default:
      break;
  }
}

func_9F0A(var_0) {
  switch (var_0) {
    case "armorup_mp":
    case "iw7_niagara_mp":
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

func_7952(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2.origin;
  if(!isDefined(var_5)) {
    return 0;
  }

  var_6 = vectornormalize(var_5 - var_0);
  if(!isDefined(var_4) || var_4 == "forward") {
    var_7 = anglesToForward(var_1);
  } else {
    var_7 = anglestoright(var_2);
  }

  var_8 = vectordot(var_7, var_6);
  return var_8 >= var_3;
}

give_player_crafted_power(var_0, var_1) {
  var_2 = var_0.power_name;
  var_3 = level.powers[var_2].defaultslot;
  var_1 thread givepower(var_2, var_3, undefined, undefined, undefined, 0, 0);
  var_1 playlocalsound("grenade_pickup");
  var_1 notify("new_power", var_2);
}

give_player_wall_bought_power(var_0, var_1) {
  var_2 = var_0.power_name;
  var_3 = level.powers[var_2].defaultslot;
  var_1 thread givepower(var_2, var_3, undefined, undefined, undefined, 0, 1);
  var_1 playlocalsound("grenade_pickup");
  var_1 notify("new_power", var_2);
}

power_watch_hint(var_0) {
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
  var_0 = scripts\engine\utility::istrue(var_0);
  for(;;) {
    self waittill("new_power", var_1);
    wait(1);
    switch (var_1) {
      case "power_transponder":
        if(self.var_1268B < 3 && !var_0) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_TRANSPONDER", 4);
          self.var_1268B = self.var_1268B + 1;
        }
        break;

      case "power_rewind":
        if(self.var_E4C6 < 3 && !var_0) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_REWIND", 4);
          self.var_E4C6 = self.var_E4C6 + 1;
        }
        break;

      case "power_microTurret":
        if(self.var_B702 < 3 && !var_0) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_MICROTURRET", 4);
          self.var_B702 = self.var_B702 + 1;
        }
        break;

      case "power_siegeMode":
        if(self.var_F18D < 3 && !var_0) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_SIEGEMODE", 4);
          self.var_F18D = self.var_F18D + 1;
        }
        break;

      case "power_phaseShift":
        if(self.var_CAAB < 3 && !var_0) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_PHASESHIFT", 4);
          self.var_CAAB = self.var_CAAB + 1;
        }
        break;

      case "power_chargeMode":
        if(self.var_3CE6 < 3 && !var_0) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_CHARGEMODE", 4);
          self.var_3CE6 = self.var_3CE6 + 1;
        }
        break;

      case "power_armageddon":
        if(self.var_2176 < 3 && !var_0) {
          scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_ZMB_INTERACTIONS_HINT_ARMAGEDDON", 4);
          self.var_2176 = self.var_2176 + 1;
        }
        break;

      case "power_kineticPulse":
        if(self.var_A6D6 < 3 && !var_0) {
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

get_info_for_player_powers(var_0) {
  var_1 = [];
  foreach(var_3 in getarraykeys(var_0.powers)) {
    var_4 = spawnStruct();
    var_4.slot = var_0.powers[var_3].slot;
    var_4.charges = var_0.powers[var_3].charges;
    var_4.cooldown = var_0.powers[var_3].cooldown;
    var_4.permanent = var_0.powers[var_3].permanent;
    var_1[var_3] = var_4;
  }

  return var_1;
}

restore_powers(var_0, var_1) {
  foreach(var_6, var_3 in var_1) {
    var_4 = undefined;
    var_5 = 0;
    if(scripts\engine\utility::istrue(var_3.cooldown)) {
      var_4 = 1;
    }

    if(scripts\engine\utility::istrue(var_3.permanent)) {
      var_5 = 1;
    }

    if(var_3.slot == "secondary") {
      if(var_6 == "power_bait") {
        var_0 givepower(var_6, var_3.slot, undefined, undefined, undefined, 1, 1);
      } else {
        var_0 givepower(var_6, var_3.slot, undefined, undefined, undefined, var_4, var_5);
      }

      var_0 power_adjustcharges(var_3.charges, var_3.slot, 1);
      continue;
    }

    var_0 givepower(var_6, var_3.slot, undefined, undefined, undefined, undefined, 1);
    var_0 power_adjustcharges(var_3.charges, var_3.slot, 1);
  }
}

giveholywater(var_0) {
  scripts\cp\powers\coop_holywater::giveholywater();
}

takeholywater(var_0) {
  scripts\cp\powers\coop_holywater::takeholywater();
}