/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_powers.gsc
***********************************************/

function init() {
  level.powers = [];
  level.powersetfuncs = [];
  level.powerunsetfuncs = [];
  level.powerweaponmap = [];
  level.disablepowerfunc = &power_disablepower;
  level.enablepowerfunc = &power_enablepower;
  level.power_adjustcharges = &power_adjustcharges;
  level.power_clearpower = &zm_powershud_clearpower;
  level.power_haspower = &haspower;
  level.clearpowers = &clearpowers;
  level.power_modifycooldownrate = &power_modifycooldownrate;
  scripts\cp\equipment\cp_trophy_system::trophy_init();
  level._effect["grenade_explode"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_frag_gren.vfx");
  level._effect["grenade_explode_overcook"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_frag_gren_airb.vfx");
  thread scripts\cp_mp\powershud::powershud_init();
  powerparsetable();

  if(isDefined(level.power_setup_init)) {
    level[[level.power_setup_init]]();
  } else {
    powersetupfunctions("power_c4", undefined, undefined, undefined, "c4_update", undefined, undefined);
    powersetupfunctions("power_flash", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_dud", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_ammoCrate", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_sentry", undefined, undefined, &scripts\cp\cp_weapon_autosentry::give_crafted_sentry, undefined, undefined, undefined);
    powersetupfunctions("power_molotov", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_smokeGrenade", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_claymore", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_cover", undefined, &takecover, &givecover, undefined, undefined, undefined);
    powersetupfunctions("power_snapshotGrenade", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_thermite", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("equip_hb_sensor", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("equip_radial_sensor", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("equip_adrenaline", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("equip_decoy", undefined, undefined, undefined, undefined, undefined, undefined);
    thread scripts\cp\cp_weapon_autosentry::init();
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

  setupovercookfuncs(level);
  scripts\engine\utility::flag_init("powers_init_done");
  scripts\engine\utility::flag_set("powers_init_done");
}

function setupovercookfuncs() {
  level.overcook_func["frag_grenade_mp"] = &fraggrenadeovercookfunc;
}

function fraggrenadeovercookfunc(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_2 = "power_frag";
  var_0 endon("power_removed_" + var_2);

  if(!isDefined(var_1) || var_1 != "frag_grenade_mp") {
    return;
  }

  if(!haspower(var_0, var_2)) {
    return;
  }

  var_3 = var_0.origin;
  playFX(level._effect["grenade_explode_overcook"], var_3);
  playsoundatpos(var_3, "frag_grenade_expl_trans");

  if(!isDefined(var_0.powers[var_2])) {
    return;
  }

  power_adjustcharges(var_0, var_0.powers[var_2].charges - 1, var_0.powers[var_2].slot, 1);
  power_updateammo(var_0, var_2);
  var_0 radiusdamage(var_3, 256, 150, 100, var_0, "MOD_GRENADE", "frag_grenade_mp");
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

  thread reset_grenades();
  thread delete_last_second_grenade_throws(var_0);
}

function reset_grenades() {
  self endon("death");
  self disableoffhandweapons();

  while(self fragButtonPressed()) {
    wait 0.1;
  }

  wait 0.1;
  self enableoffhandweapons();
}

function delete_last_second_grenade_throws(var_0) {
  self endon("death");
  self endon("end_last_second_throw_func");
  self notify("starting_delay_last_second_grenade_throws");
  thread end_function_after_time(0.25);
  self waittill("grenade_fire", var_1, var_2, var_3, var_4);

  if(isDefined(var_1) && var_1.classname == "grenade") {
    var_1 delete();
    power_adjustcharges(self.powers[var_0].charges + 1, self.powers[var_0].slot, 1);
    return;
  }
}

function end_function_after_time(var_0) {
  self endon("death");
  wait var_0;
  self notify("end_last_second_throw_func");
}

function power_createdefaultstruct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_10.usetype = var_1;
  var_10.weaponuse = var_2;
  var_10.cooldowntime = var_4;
  var_10.id = var_3;

  if(level.gametype == "cp_pvpve") {
    var_10.maxcharges = 1;
  } else {
    var_10.maxcharges = var_5;
  }

  var_10.deathreset = var_6;
  var_10.usecooldown = var_7;
  var_10.uitype = var_8;
  var_10.defaultslot = var_9;
  level.powers[var_0] = var_10;
}

function powerparsetable() {
  var_0 = 1;

  if(isDefined(level.power_table)) {
    var_1 = level.power_table;
    goto LOC_00000021;
  }

  for(var_1 = "cp/cp_powerTable.csv";; var_1++) {
    var_2 = tablelookupbyrow(var_1, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_1, 1);
    var_4 = tablelookupbyrow(var_1, var_1, 6);
    var_5 = tablelookupbyrow(var_1, var_1, 7);
    var_6 = tablelookupbyrow(var_1, var_1, 8);
    var_7 = tablelookupbyrow(var_1, var_1, 9);
    var_8 = tablelookupbyrow(var_1, var_1, 10);
    var_9 = tablelookupbyrow(var_1, var_1, 11);
    var_10 = tablelookupbyrow(var_1, var_1, 16);
    var_11 = tablelookupbyrow(var_1, var_1, 13);
    power_createdefaultstruct(var_3, var_4, var_5, int(var_2), float(var_6), int(var_7), int(var_8), int(var_9), var_10, var_11);

    if(isDefined(level.powerweaponmap[var_5]) && var_5 != "<power_script_generic_weapon>") {
      switch (var_5) {
        case "power_rewind":
          if(var_3 == "power_rewinder") {
            break;
          }
        default:
          break;
      }
    }

    level.powerweaponmap[var_5] = var_3;
  }
}

function powersetupfunctions(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = level.powers[var_0];

  if(!isDefined(var_7)) {
    scripts\engine\utility::error("No configuration data for " + var_0 + " found! Is it in powertable.csv? Or make sure powerSetupFunctions is called after the table is initialized.");
  }

  level.powersetfuncs[var_0] = var_1;
  level.powerunsetfuncs[var_0] = var_2;

  if(isDefined(var_3)) {
    var_7.usefunc = var_3;
  }

  if(isDefined(var_4)) {
    var_7.updatenotify = var_4;
  }

  if(isDefined(var_5)) {
    var_7.usednotify = var_5;
  }

  if(isDefined(var_6)) {
    var_7.interruptnotify = var_6;
    return;
  }
}

function power_sethudstate(var_0, var_1) {
  var_2 = getpower(var_0);
  var_3 = self.powers[var_2];
  var_4 = level.powers[var_2];
  var_5 = var_3.hudstate;
  var_6 = var_3.charges;

  if(isDefined(var_5) && var_5 == var_1) {
    return;
  }

  if(isDefined(var_5)) {
    power_unsethudstate(var_0);
  }

  switch (var_1) {
    case 0:
      scripts\cp_mp\powershud::powershud_beginpowerdrain(var_0);
      scripts\cp_mp\powershud::powershud_updatepowermeter(var_0, 1);
      powershud_updatepowerchargescp(var_2, var_0, var_6);
      thread power_watchhuddrainmeter(var_2);
      break;
    case 1:
      scripts\cp_mp\powershud::powershud_beginpowercooldown(var_0, 0);
      powershud_updatepowerchargescp(var_2, var_0, var_6);
      thread power_watchhudcooldownmeter(var_2);
      break;
    case 2:
      scripts\cp_mp\powershud::powershud_updatepowerdisabled(var_0, 0);
      scripts\cp_mp\powershud::powershud_updatepowermeter(var_0, 1);
      powershud_updatepowerchargescp(var_2, var_0, var_6);
      thread power_watchhudcharges(var_2);
      break;
    case 3:
      break;
  }

  var_3.hudstate = var_1;
  thread power_unsethudstateonremoved(var_0);
}

function power_unsethudstate(var_0) {
  var_1 = getpower(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = self.powers[var_1];
  var_3 = var_2.hudstate;

  if(!isDefined(var_3)) {
    return;
  }

  switch (var_3) {
    case "unavailable":
      break;
    case 0:
      scripts\cp_mp\powershud::powershud_endpowerdrain(var_0);
      break;
    case 2:
      break;
    case 1:
      scripts\cp_mp\powershud::powershud_finishpowercooldown(var_0, 0);
      break;
  }

  var_2.hudstate = undefined;
}

function power_unsethudstateonremoved(var_0) {
  self endon("disconnect");
  self notify("power_unsetHudStateOnRemoved_" + var_0);
  self endon("power_unsetHudStateOnRemoved_" + var_0);
  var_1 = getpower(var_0);
  self waittill("power_removed_" + var_1);
  power_unsethudstate(var_0);
}

function givepower(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 2;

  if(!isDefined(self.powers)) {
    self.powers = [];
  }

  if(var_0 == "none") {
    return;
  }

  if(var_1 == "scripted") {
    var_8++;
  }

  for(var_9 = self getheldoffhand(); !nullweapon(var_9); var_9 = self getheldoffhand()) {
    waitframe();
  }

  var_10 = getarraykeys(self.powers);

  foreach(var_12 in var_10) {
    if(self.powers[var_12].slot == var_1) {
      self.itemreplaced = var_12;
      removepower(var_12);
      break;
    }
  }

  if(isDefined(level.extra_charge_func)) {
    var_4 = [[level.extra_charge_func]](var_0);
  }

  power_createplayerstruct(var_0, var_1, var_4, var_5, var_6, var_7);
  var_14 = self.powers[var_0];
  var_15 = level.powers[var_0];
  self notify("delete_equipment " + var_1);
  var_16 = 0;

  if(isDefined(self.powercooldowns) && isDefined(self.powercooldowns[var_0])) {
    var_17 = self.powercooldowns[var_0];
    var_18 = power_cooldownremaining(var_17);

    if(var_18 > 0) {
      var_19 = var_14.charges * var_15.cooldowntime;
      var_14.charges = int((var_19 - var_18) / var_15.cooldowntime);

      if(var_14.charges < 0) {
        var_14.charges = 0;
      }

      var_16 = var_18;

      while(var_16 > var_15.cooldowntime) {
        var_16 -= var_15.cooldowntime;
      }
    }
  }

  if(var_1 == "scripted") {
    return;
  }

  var_14.weaponuse = undefined;

  if(var_15.weaponuse == "<power_script_generic_weapon>") {
    var_14.weaponuse = scripts\engine\utility::ter_op(var_1 == "primary", "power_script_generic_primary_mp", "power_script_generic_secondary_mp");
  } else {
    var_14.weaponuse = var_15.weaponuse;
  }

  var_20 = var_14.weaponuse;
  var_14.weaponuse = var_20;
  var_14.objweapon = getcompleteweaponname(var_20);
  self giveweapon(var_14.objweapon);
  self setweaponammoclip(var_14.objweapon, var_14.charges);

  if(var_14.slot == "primary") {
    self assignweaponoffhandprimary(var_14.objweapon);
    self.powerprimarygrenade = var_20;
    self setclientomnvar("ui_power_max_charges", var_14.charges);
  } else if(var_14.slot == "secondary") {
    self assignweaponoffhandsecondary(var_14.objweapon);
    self.powersecondarygrenade = var_20;
    self setclientomnvar("ui_power_secondary_max_charges", var_14.charges);
  }

  if(isDefined(level.powersetfuncs[var_0])) {
    self[[level.powersetfuncs[var_0]]](var_0);
  }

  if(isDefined(var_6) && !var_6) {
    thread remove_when_charges_exhausted(var_0);
  }

  if(!isai(self)) {
    thread power_modifychargesonscavenge(var_0);
    thread power_modifychargesonpickuporfailure(var_0);
    thread managepowerbuttonuse(var_15, var_0, var_14.slot, var_15.cooldowntime, var_15.updatenotify, var_15.usednotify, var_20, var_16, var_2);
  }

  self notify("powers_updated");
}

function removepower(var_0) {
  if(isDefined(level.powerunsetfuncs[var_0])) {
    self[[level.powerunsetfuncs[var_0]]]();
  }

  if(isDefined(self.powers[var_0].weaponuse)) {
    self takeweapon(self.powers[var_0].weaponuse);
  }

  if(self.powers[var_0].slot == "primary") {
    self clearoffhandprimary();
    self.powerprimarygrenade = undefined;
  } else if(self.powers[var_0].slot == "secondary") {
    self clearoffhandsecondary();
    self.powersecondarygrenade = undefined;
  }

  self notify("power_removed_" + var_0);
  zm_powershud_clearpower(self.powers[var_0].slot);
  self.powers[var_0] = undefined;
}

function zm_powershud_clearpower(var_0) {
  if(var_0 == "scripted") {
    return;
  }

  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_0, 2), 0);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_0, 1), 0);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_0, 0), -1);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_0, 3), 0);
}

function cleanpowercooldowns() {
  if(isDefined(self.powercooldowns) && self.powercooldowns.size > 0) {
    var_0 = self.powercooldowns;

    foreach(var_2 in var_0) {
      if(power_cooldownremaining(var_2) == 0) {
        self.powercooldowns[var_3] = undefined;
      }
    }

    return;
  }
}

function power_cooldownremaining(var_0) {
  var_1 = level.powers[var_0.power];
  var_2 = (var_0.maxcharges - var_0.charges) * var_1.cooldowntime - var_1.cooldowntime - var_0.cooldownleft;
  var_3 = (gettime() - var_0.timestamp) / 1000;
  return max(0, var_2 - var_3);
}

function clearpowers() {
  self notify("powers_cleanUp");

  if(isDefined(self.powers)) {
    var_0 = self.powers;

    foreach(var_2 in var_0) {
      removepower(var_3);
    }

    self.powers = [];
    return;
  }
}

function getpower(var_0) {
  if(!isDefined(self.powers)) {
    return undefined;
  }

  foreach(var_2 in self.powers) {
    if(var_2.slot == var_0) {
      return var_3;
    }
  }

  return undefined;
}

function clear_power_slot(var_0) {
  var_1 = self.powers;
  var_2 = power_getpowerkeys();

  foreach(var_4 in var_2) {
    if(var_1[var_4].slot == var_0) {
      self.powers[var_4] = undefined;
      self notify("clear_power_slot" + var_4);
      removepower(var_4);
    }
  }

  zm_powershud_clearpower(var_0);
}

function what_power_is_in_slot(var_0) {
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

function power_getinputcommand(var_0) {
  return scripts\engine\utility::ter_op(self.powers[var_0].slot == "primary", "+frag", "+smoke");
}

function power_createplayerstruct(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.powers[var_0];
  var_7 = spawnStruct();
  var_7.slot = var_1;
  var_7.charges = var_6.maxcharges;

  if(istrue(var_2)) {
    var_7.charges++;
  }

  if(isDefined(var_5)) {
    var_7.charges = var_5;
  }

  var_7.maxcharges = quadgridcenterpoints(var_0, var_1);
  var_7.incooldown = 0;
  var_7.active = 0;
  var_7.cooldownleft = 0;
  var_7.cooldownratemod = 1;
  var_7.cooldown = var_3;
  var_7.permanent = var_4;
  var_7.passives = [];
  self.powers[var_0] = var_7;
}

function quadgridcenterpoints(var_0, var_1) {
  if(scripts\cp\utility::tryingtoleave()) {
    return level.powers[var_0].maxcharges;
  }

  return scripts\cp\cp_loadout::get_num_of_charges_for_power(self, var_1);
}

function managepowerbuttonuse(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_1);
  level endon("game_ended");

  if(isDefined(var_8) && var_8 || var_1 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + var_1);
  scripts\cp_mp\powershud::powershud_assignpower(var_2, int(var_0.id), 1, int(self.powers[var_1].charges));
  scripts\cp\utility::gameflagwait("prematch_done");
  power_sethudstate(var_2, 2);

  for(;;) {
    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      scripts\engine\utility::ref_143a6("revive", "revive_success", "challenge_complete_revive");
    }

    power_updateammo(var_1);
    var_9 = var_6 + "_success";
    thread watchearlyout(var_3, var_1, var_9);
    var_10 = scripts\engine\utility::ter_op(var_0.usetype == "weapon_hold", "offhand_pullback", "offhand_fired");
    self waittill(var_10, var_11);

    if(var_11.basename != var_6) {
      continue;
    }

    var_3 = getpowercooldowntime(var_0);
    self notify(var_9);

    if(self.powers[var_1].charges != 0 && !self.powers[var_1].active) {
      var_12 = undefined;

      if(isDefined(var_0.usefunc)) {
        var_12 = self thread[[var_0.usefunc]](var_11);

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

      if(!isDefined(self.dont_use_charges) || self.dont_use_charges != var_1) {}
    }

    power_adjustcharges(-1, self.powers[var_1].slot);
    self notify("power_used " + var_1);

    if(isDefined(var_4) && level.powers[var_1].uitype == "drain" && !istrue(self.powers[var_1].indrain)) {
      power_dodrain(var_1);
    }

    thread power_docooldown(var_1, var_3, var_8);
  }
}

function ispickedupgrenadetype(var_0) {
  switch (var_0) {
    case "power_clusterGrenade":
    case "power_sentry":
    case "power_ammoCrate":
    case "power_frag":
    case "power_smokeGrenade":
    case "power_molotov":
      return 1;
    default:
      return 0;
  }
}

function getpowercooldowntime(var_0) {
  if(istrue(level.powershortcooldown)) {
    return 0.1;
  }

  if(istrue(level.infinite_grenades)) {
    return 2.5;
  }

  if(scripts\cp\utility::is_consumable_active("grenade_cooldown")) {
    return var_0.cooldowntime;
  }

  return var_0.cooldowntime;
}

function power_modifychargesonscavenge(var_0) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.weaponuse;
  var_3 = var_1.slot;

  for(;;) {
    self waittill("scavenged_ammo", var_4);

    if(var_4 == var_2) {
      power_adjustcharges(var_1.maxcharges, var_3);
    }

    var_5 = var_1.hudstate;

    if(var_5 == 1) {
      power_sethudstate(var_3, 2);
    }
  }
}

function power_modifychargesonpickuporfailure(var_0) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.weaponuse;
  var_3 = var_1.slot;

  for(;;) {
    self waittill("pickup_equipment", var_4);

    if(var_4 == var_2) {
      power_adjustcharges(1, var_3);
    }

    var_5 = var_1.hudstate;

    if(var_5 == 1) {
      power_sethudstate(var_3, 2);
    }
  }
}

function remove_when_charges_exhausted(var_0) {
  self endon("disconnect");
  self endon("power_removed_" + var_0);
  level endon("game_ended");
  var_1 = self.powers[var_0];

  while(isDefined(self.powers[var_0])) {
    self waittill("power_used " + var_0);

    if(istrue(level.powershortcooldown)) {
      continue;
    }

    if(var_1.charges < 1) {
      while(self isswitchingweapon() || scripts\engine\utility::array_contains(self.powers_active, var_0)) {
        wait 0.25;
      }

      wait 0.25;
      thread removepower(var_0);
    }
  }
}

function power_shouldcooldown(var_0) {
  if(!isDefined(self.powers[var_0])) {
    return false;
  }

  if(istrue(self.powers[var_0].cooldown)) {
    return true;
  }

  if(istrue(level.powershortcooldown)) {
    return true;
  }

  if(level.powers[var_0].usecooldown) {
    return true;
  }

  if(isDefined(self.powers[var_0].slot) && self.powers[var_0].slot != "primary") {
    return false;
  }

  if(scripts\cp\utility::is_consumable_active("grenade_cooldown") && level.powers[var_0].defaultslot != "secondary") {
    return true;
  }

  if(istrue(level.infinite_grenades)) {
    return true;
  }

  return false;
}

function activatepower(var_0) {
  self.powers_active[self.powers_active.size] = var_0;
}

function deactivatepower(var_0) {
  if(scripts\engine\utility::array_contains(self.powers_active, var_0)) {
    self.powers_active = scripts\engine\utility::array_remove(self.powers_active, var_0);
    return;
  }
}

function power_docooldown(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  self endon("power_cooldown_ended" + var_0);

  if(isDefined(var_2) && var_2 || var_0 == "power_copycatGrenade") {
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
  var_4.incooldown = 1;

  if(!isDefined(var_4.cooldownsqueued)) {
    var_4.cooldownsqueued = 0;
  }

  var_4.cooldownsqueued++;

  if(!isDefined(var_4.cooldowncounter)) {
    var_4.cooldowncounter = 0;
  }

  if(!isDefined(var_4.cooldownleft)) {
    var_4.cooldownleft = 0;
  }

  var_4.cooldownleft += var_1;
  var_7 = var_4.hudstate;
  jumpiffalse(isDefined(var_7) && var_7 != 0 && var_4.charges == 0) LOC_00000116;
  power_sethudstate(var_5, 1);

  while(var_4.charges < var_4.maxcharges) {
    if(power_shouldcooldown(var_0)) {
      wait 0.1;
    } else {
      level scripts\engine\utility::ref_143a6("grenade_cooldown activated", "infinite_grenade_active", "start_power_cooldown");
      var_1 = getpowercooldowntime(var_3);
    }

    if(var_4.cooldowncounter > var_1) {
      power_adjustcharges(1, var_5);
      power_updateammo(var_0);

      if(var_4.charges == var_4.maxcharges) {
        thread power_endcooldown(var_0, var_2);
      }

      var_4.cooldowncounter -= var_1;
      var_4.cooldownleft -= var_1;
      var_4.cooldownsqueued--;

      if(isDefined(var_7) && var_7 != 0) {
        power_sethudstate(var_5, 2);
      }
    } else {
      var_4.cooldowncounter += 0.1;
      var_4.cooldownleft -= 0.1;
    }

    var_8 = min(1, var_4.cooldowncounter / var_1);
    self notify(var_6, var_8);
  }

  thread power_endcooldown(var_0, var_2);
}

function power_endcooldown(var_0, var_1) {
  self notify("power_cooldown_ended" + var_0);
  var_2 = self.powers[var_0];
  var_2.incooldown = 0;
  var_2.cooldowncounter = 0;
  var_2.cooldownleft = 0;
  var_2.cooldownsqueued = 0;

  if(isDefined(var_1) && var_1) {
    self notify("copycat_reset");
  }

  var_3 = var_2.hudstate;
  var_4 = var_2.slot;

  if(var_3 == 0) {
    return;
  }

  power_sethudstate(var_4, 2);
}

function power_dodrain(var_0) {
  self endon("death");
  self endon("power_drain_ended_" + var_0);
  self notify("power_cooldown_ended_" + var_0);
  var_1 = level.powers[var_0];
  var_2 = self.powers[var_0];
  var_3 = var_1.updatenotify;
  var_4 = var_1.interruptnotify;
  var_5 = var_2.slot;
  var_2.indrain = 1;
  power_disableactivation(var_0);
  power_sethudstate(var_5, 0);
  jumpiffalse(isDefined(var_4)) LOC_00000071;
  thread power_enddrainoninterrupt(var_0, var_5, var_4);

  for(;;) {
    self waittill(var_3, var_6);

    if(var_6 == 0) {
      break;
    }
  }

  thread power_enddrain(var_0);
}

function power_enddrainoninterrupt(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_0);
  self endon("power_drain_ended_" + var_0);
  self waittill(var_2);
  thread power_enddrain(var_0);
}

function power_enddrain(var_0) {
  self notify("power_drain_ended_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.slot;
  var_1.indrain = 0;
  power_enableactivation(var_0);

  if(var_1.charges > 0) {
    power_sethudstate(var_2, 2);
    return;
  }

  power_sethudstate(var_2, 1);
}

function haspower(var_0) {
  if(!isDefined(self.powers[var_0])) {
    return false;
  }

  return true;
}

function waitonpowerbutton(var_0) {
  self endon("death");
  self endon("disconnect");

  if(var_0 == "primary") {
    var_1 = "power_primary_used";
  } else {
    var_1 = "power_secondary_used";
  }

  for(;;) {
    if(!isDefined(self)) {
      wait 1;
      break;
    }

    self waittill(var_1);
    break;
  }
}

function power_modifycooldownrate(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  var_2 = power_getpowerkeys();

  foreach(var_4 in var_2) {
    if(isDefined(self.powers[var_4].slot) && self.powers[var_4].slot == var_1 || var_1 == "all") {
      self.powers[var_4].cooldownratemod = var_0;
    }
  }
}

function power_adjustcharges(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  var_3 = power_getpowerkeys();
  var_4 = var_0;

  foreach(var_6 in var_3) {
    if(!isDefined(var_0)) {
      var_4 = self.powers[var_6].maxcharges;
    }

    if(self.powers[var_6].slot == var_1 || var_1 == "all") {
      if(isDefined(var_2)) {
        self.powers[var_6].charges = int(min(var_4, self.powers[var_6].maxcharges));
      } else if(self.powers[var_6].charges + var_4 >= 0) {
        self.powers[var_6].charges += var_4;
      } else {
        self.powers[var_6].charges = 0;
      }

      self.powers[var_6].charges = int(clamp(self.powers[var_6].charges, 0, self.powers[var_6].maxcharges));
      self setweaponammoclip(self.powers[var_6].weaponuse, self.powers[var_6].charges);
      powershud_updatepowerchargescp(var_6, self.powers[var_6].slot, self.powers[var_6].charges);
    }
  }
}

function ref_1281c(var_0) {
  var_1 = power_getpowerkeys(var_0);

  foreach(var_3 in var_1) {
    if(var_0.powers[var_3].charges != var_0.powers[var_3].maxcharges) {
      return false;
    }
  }

  return true;
}

function power_getpowerkeys() {
  var_0 = getarraykeys(level.powers);
  var_1 = getarraykeys(self.powers);
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_1) {
    foreach(var_7 in var_0) {
      if(var_5 == var_7) {
        var_2 = var_5;
        var_3 += 1;
        break;
      }
    }
  }

  return var_2;
}

function power_disablepower(var_0) {
  if(scripts\common\utility::is_offhand_weapons_allowed()) {
    scripts\common\utility::allow_offhand_weapons(0);
    return;
  }
}

function power_enablepower(var_0) {
  if(!scripts\common\utility::is_offhand_weapons_allowed()) {
    scripts\common\utility::allow_offhand_weapons(1);
    return;
  }
}

function definepowerovertimeduration(var_0) {
  if(!isDefined(self.powerdurations)) {
    self.powerdurations = [];
  }

  if(!isDefined(self.powerdurations[var_0])) {
    self.powerdurations[var_0] = 0;
    return;
  }
}

function getpowerovertimeduration(var_0) {
  definepowerovertimeduration(var_0);
  return self.powerdurations[var_0];
}

function setpowerovertimeduration(var_0, var_1) {
  definepowerovertimeduration(var_0);
  self.powerdurations[var_0] = var_1;
}

function watchearlyout(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var_1);
  self endon(var_2);
  level endon("game_ended");
  self waittill("offhand_fired", var_3);
  var_4 = self.powers[var_1];
  var_5 = createheadicon(var_3);

  if(var_5 == var_4.weaponuse) {
    if(!isalive(self)) {
      if(var_4.charges > 0) {
        power_adjustcharges(-1, var_4.slot);
      }

      if(!var_4.incooldown) {
        var_4.cooldownleft = level.powers[var_1].cooldowntime;
        thread power_docooldown(var_1, var_0);
        return;
      }

      return;
    }

    return;
  }
}

function ispowersbuttonPressed(var_0) {
  if(var_0 == "+frag" && self fragButtonPressed() || var_0 == "+smoke" && self secondaryoffhandbuttonPressed()) {
    return 1;
  }

  return 0;
}

function power_watchhudcharges(var_0) {
  self endon("power_available_ended_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.slot;

  for(;;) {
    self waittill("power_charges_adjusted_" + var_0, var_3);
    powershud_updatepowerchargescp(var_0, var_2, var_3);
  }
}

function powershud_updatepowerchargescp(var_0, var_1, var_2) {
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_1, 0), int(var_2));
}

function power_watchhuddrainmeter(var_0) {
  self endon("disconnect");
  self endon("power_removed_" + var_0);
  self endon("power_drain_ended_" + var_0);
  var_1 = self.powers[var_0];
  var_2 = level.powers[var_0];
  var_3 = var_1.slot;
  var_4 = var_2.updatenotify;
  jumpiftrue(isDefined(var_4)) LOC_0000004d;
  var_4 = var_0 + "_update";

  for(;;) {
    self waittill(var_4, var_5);
    var_5 = max(0, min(1, var_5));
    scripts\cp_mp\powershud::powershud_updatepowerdrainprogress(var_3, var_5);
  }
}

function power_watchhudcooldownmeter(var_0) {
  self endon("disconnect");
  self endon("power_removed_" + var_0);
  self endon("power_cooldown_ended" + var_0);
  var_1 = self.powers[var_0];
  var_2 = level.powers[var_0];
  var_3 = var_1.slot;
  var_4 = var_0 + "_cooldown_update";

  for(;;) {
    self waittill(var_4, var_5);
    scripts\cp_mp\powershud::powershud_updatepowercooldown(var_3, var_5);
  }
}

function power_disableactivation(var_0) {
  var_1 = self.powers[var_0];

  if(!isDefined(var_1.disableactivation)) {
    var_1.disableactivation = 0;
  }

  var_1.disableactivation++;

  if(var_1.disableactivation == 1) {
    power_updateammo(var_0);
    return;
  }
}

function power_enableactivation(var_0) {
  var_1 = self.powers[var_0];
  var_1.disableactivation--;

  if(var_1.disableactivation == 0) {
    power_updateammo(var_0);
    return;
  }
}

function power_updateammo(var_0) {
  var_1 = self.powers[var_0];
  var_2 = isDefined(var_1.disableactivation) && var_1.disableactivation;
  var_3 = var_1.charges > 0;

  if(!var_2 && var_3) {
    self setweaponammoclip(var_1.weaponuse, var_1.charges + 1);
    return;
  }

  self setweaponammoclip(var_1.weaponuse, 0);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    thread ref_1281d(var_1.slot);
    return;
  }
}

function ref_1281d(var_0) {
  if(var_0 == "primary") {
    self setclientomnvar("reset_wave_loadout", 3);
    return;
  }

  if(var_0 == "secondary") {
    wait 0.5;
    self setclientomnvar("reset_wave_loadout", 4);
    return;
  }
}

function power_addammo(var_0, var_1) {
  var_2 = self.powers[var_0];
  var_3 = isDefined(var_2.disableactivation) && var_2.disableactivation;
  var_4 = var_2.charges;

  if(!var_3) {
    if(var_4 + 1 < var_2.maxcharges) {
      self setweaponammoclip(var_2.objweapon, var_4 + 1);
      self notify("power_charges_adjusted_" + var_0, var_4 + 1);
      var_2.charges += 1;
      return;
    }

    self setweaponammoclip(var_2.objweapon, var_2.maxcharges);
    self notify("power_charges_adjusted_" + var_0, var_2.maxcharges);
    var_2.charges = var_2.maxcharges;
    return;
  }

  self setweaponammoclip(var_2.weaponuse, 0);
}

function get_info_for_player_powers(var_0) {
  var_1 = [];

  foreach(var_3 in getarraykeys(var_0.powers)) {
    var_4 = spawnStruct();
    var_4.slot = var_0.powers[var_3].slot;
    var_4.charges = var_0.powers[var_3].charges;
    var_4.cooldown = var_0.powers[var_3].cooldown;
    var_4.permanent = var_0.powers[var_3].permanent;
    var_4.maxcharges = var_0.powers[var_3].maxcharges;
    var_1 = var_4;
  }

  return var_1;
}

function restore_powers(var_0, var_1) {
  foreach(var_6, var_3 in var_1) {
    var_4 = undefined;
    var_5 = 0;

    if(istrue(var_3.cooldown)) {
      var_4 = 1;
    }

    if(istrue(var_3.permanent)) {
      var_5 = 1;
    }

    if(var_3.slot == "secondary") {
      if(var_6 == "power_bait") {
        givepower(var_0, var_6, var_3.slot, undefined, undefined, undefined, 1, 1, var_3.maxcharges);
      } else {
        givepower(var_0, var_6, var_3.slot, undefined, undefined, undefined, var_4, var_5, var_3.maxcharges);
      }

      power_adjustcharges(var_0, var_3.charges, var_3.slot, 1);
      continue;
    }

    givepower(var_0, var_6, var_3.slot, undefined, undefined, undefined, undefined, 1, var_3.maxcharges);
    power_adjustcharges(var_0, var_3.charges, var_3.slot, 1);
  }
}

function givecover(var_0) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired(undefined, undefined, undefined, 0);
}

function takecover(var_0) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_take(undefined, undefined, 1);
}