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

function fraggrenadeovercookfunc(var0, var1) {
  level endon("game_ended");
  var0 endon("disconnect");
  var2 = "power_frag";
  var0 endon("power_removed_" + var2);

  if(!isDefined(var1) || var1 != "frag_grenade_mp") {
    return;
  }

  if(!haspower(var0, var2)) {
    return;
  }

  var3 = var0.origin;
  playFX(level._effect["grenade_explode_overcook"], var3);
  playsoundatpos(var3, "frag_grenade_expl_trans");

  if(!isDefined(var0.powers[var2])) {
    return;
  }

  power_adjustcharges(var0, var0.powers[var2].charges - 1, var0.powers[var2].slot, 1);
  power_updateammo(var0, var2);
  var0 radiusdamage(var3, 256, 150, 100, var0, "MOD_GRENADE", "frag_grenade_mp");
  playrumbleonposition("grenade_rumble", var3);
  earthquake(0.5, 0.75, var3, 800);

  foreach(var5 in level.players) {
    if(var5 scripts\cp\utility::isusingremote()) {
      continue;
    }

    if(distancesquared(var3, var5.origin) > 360000) {
      continue;
    }

    if(var5 damageconetrace(var3)) {
      var5 thread scripts\cp\cp_weapon::dirteffect(var3);
    }

    var5 setclientomnvar("ui_hud_shake", 1);
  }

  thread reset_grenades();
  thread delete_last_second_grenade_throws(var0);
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

function delete_last_second_grenade_throws(var0) {
  self endon("death");
  self endon("end_last_second_throw_func");
  self notify("starting_delay_last_second_grenade_throws");
  thread end_function_after_time(0.25);
  self waittill("grenade_fire", var1, var2, var3, var4);

  if(isDefined(var1) && var1.classname == "grenade") {
    var1 delete();
    power_adjustcharges(self.powers[var0].charges + 1, self.powers[var0].slot, 1);
    return;
  }
}

function end_function_after_time(var0) {
  self endon("death");
  wait var0;
  self notify("end_last_second_throw_func");
}

function power_createdefaultstruct(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = spawnStruct();
  var10.usetype = var1;
  var10.weaponuse = var2;
  var10.cooldowntime = var4;
  var10.id = var3;

  if(level.gametype == "cp_pvpve") {
    var10.maxcharges = 1;
  } else {
    var10.maxcharges = var5;
  }

  var10.deathreset = var6;
  var10.usecooldown = var7;
  var10.uitype = var8;
  var10.defaultslot = var9;
  level.powers[var0] = var10;
}

function powerparsetable() {
  var0 = 1;

  if(isDefined(level.power_table)) {
    var1 = level.power_table;
    goto LOC_00000021;
  }

  for(var1 = "cp/cp_powerTable.csv";; var1++) {
    var2 = tablelookupbyrow(var1, var1, 0);

    if(var2 == "") {
      break;
    }

    var3 = tablelookupbyrow(var1, var1, 1);
    var4 = tablelookupbyrow(var1, var1, 6);
    var5 = tablelookupbyrow(var1, var1, 7);
    var6 = tablelookupbyrow(var1, var1, 8);
    var7 = tablelookupbyrow(var1, var1, 9);
    var8 = tablelookupbyrow(var1, var1, 10);
    var9 = tablelookupbyrow(var1, var1, 11);
    var10 = tablelookupbyrow(var1, var1, 16);
    var11 = tablelookupbyrow(var1, var1, 13);
    power_createdefaultstruct(var3, var4, var5, int(var2), float(var6), int(var7), int(var8), int(var9), var10, var11);

    if(isDefined(level.powerweaponmap[var5]) && var5 != "<power_script_generic_weapon>") {
      switch (var5) {
        case "power_rewind":
          if(var3 == "power_rewinder") {
            break;
          }
        default:
          break;
      }
    }

    level.powerweaponmap[var5] = var3;
  }
}

function powersetupfunctions(var0, var1, var2, var3, var4, var5, var6) {
  var7 = level.powers[var0];

  if(!isDefined(var7)) {
    scripts\engine\utility::error("No configuration data for " + var0 + " found! Is it in powertable.csv? Or make sure powerSetupFunctions is called after the table is initialized.");
  }

  level.powersetfuncs[var0] = var1;
  level.powerunsetfuncs[var0] = var2;

  if(isDefined(var3)) {
    var7.usefunc = var3;
  }

  if(isDefined(var4)) {
    var7.updatenotify = var4;
  }

  if(isDefined(var5)) {
    var7.usednotify = var5;
  }

  if(isDefined(var6)) {
    var7.interruptnotify = var6;
    return;
  }
}

function power_sethudstate(var0, var1) {
  var2 = getpower(var0);
  var3 = self.powers[var2];
  var4 = level.powers[var2];
  var5 = var3.hudstate;
  var6 = var3.charges;

  if(isDefined(var5) && var5 == var1) {
    return;
  }

  if(isDefined(var5)) {
    power_unsethudstate(var0);
  }

  switch (var1) {
    case 0:
      scripts\cp_mp\powershud::powershud_beginpowerdrain(var0);
      scripts\cp_mp\powershud::powershud_updatepowermeter(var0, 1);
      powershud_updatepowerchargescp(var2, var0, var6);
      thread power_watchhuddrainmeter(var2);
      break;
    case 1:
      scripts\cp_mp\powershud::powershud_beginpowercooldown(var0, 0);
      powershud_updatepowerchargescp(var2, var0, var6);
      thread power_watchhudcooldownmeter(var2);
      break;
    case 2:
      scripts\cp_mp\powershud::powershud_updatepowerdisabled(var0, 0);
      scripts\cp_mp\powershud::powershud_updatepowermeter(var0, 1);
      powershud_updatepowerchargescp(var2, var0, var6);
      thread power_watchhudcharges(var2);
      break;
    case 3:
      break;
  }

  var3.hudstate = var1;
  thread power_unsethudstateonremoved(var0);
}

function power_unsethudstate(var0) {
  var1 = getpower(var0);

  if(!isDefined(var1)) {
    return;
  }

  var2 = self.powers[var1];
  var3 = var2.hudstate;

  if(!isDefined(var3)) {
    return;
  }

  switch (var3) {
    case "unavailable":
      break;
    case 0:
      scripts\cp_mp\powershud::powershud_endpowerdrain(var0);
      break;
    case 2:
      break;
    case 1:
      scripts\cp_mp\powershud::powershud_finishpowercooldown(var0, 0);
      break;
  }

  var2.hudstate = undefined;
}

function power_unsethudstateonremoved(var0) {
  self endon("disconnect");
  self notify("power_unsetHudStateOnRemoved_" + var0);
  self endon("power_unsetHudStateOnRemoved_" + var0);
  var1 = getpower(var0);
  self waittill("power_removed_" + var1);
  power_unsethudstate(var0);
}

function givepower(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = 2;

  if(!isDefined(self.powers)) {
    self.powers = [];
  }

  if(var0 == "none") {
    return;
  }

  if(var1 == "scripted") {
    var8++;
  }

  for(var9 = self getheldoffhand(); !nullweapon(var9); var9 = self getheldoffhand()) {
    waitframe();
  }

  var10 = getarraykeys(self.powers);

  foreach(var12 in var10) {
    if(self.powers[var12].slot == var1) {
      self.itemreplaced = var12;
      removepower(var12);
      break;
    }
  }

  if(isDefined(level.extra_charge_func)) {
    var4 = [[level.extra_charge_func]](var0);
  }

  power_createplayerstruct(var0, var1, var4, var5, var6, var7);
  var14 = self.powers[var0];
  var15 = level.powers[var0];
  self notify("delete_equipment " + var1);
  var16 = 0;

  if(isDefined(self.powercooldowns) && isDefined(self.powercooldowns[var0])) {
    var17 = self.powercooldowns[var0];
    var18 = power_cooldownremaining(var17);

    if(var18 > 0) {
      var19 = var14.charges * var15.cooldowntime;
      var14.charges = int((var19 - var18) / var15.cooldowntime);

      if(var14.charges < 0) {
        var14.charges = 0;
      }

      var16 = var18;

      while(var16 > var15.cooldowntime) {
        var16 -= var15.cooldowntime;
      }
    }
  }

  if(var1 == "scripted") {
    return;
  }

  var14.weaponuse = undefined;

  if(var15.weaponuse == "<power_script_generic_weapon>") {
    var14.weaponuse = scripts\engine\utility::ter_op(var1 == "primary", "power_script_generic_primary_mp", "power_script_generic_secondary_mp");
  } else {
    var14.weaponuse = var15.weaponuse;
  }

  var20 = var14.weaponuse;
  var14.weaponuse = var20;
  var14.objweapon = getcompleteweaponname(var20);
  self giveweapon(var14.objweapon);
  self setweaponammoclip(var14.objweapon, var14.charges);

  if(var14.slot == "primary") {
    self assignweaponoffhandprimary(var14.objweapon);
    self.powerprimarygrenade = var20;
    self setclientomnvar("ui_power_max_charges", var14.charges);
  } else if(var14.slot == "secondary") {
    self assignweaponoffhandsecondary(var14.objweapon);
    self.powersecondarygrenade = var20;
    self setclientomnvar("ui_power_secondary_max_charges", var14.charges);
  }

  if(isDefined(level.powersetfuncs[var0])) {
    self[[level.powersetfuncs[var0]]](var0);
  }

  if(isDefined(var6) && !var6) {
    thread remove_when_charges_exhausted(var0);
  }

  if(!isai(self)) {
    thread power_modifychargesonscavenge(var0);
    thread power_modifychargesonpickuporfailure(var0);
    thread managepowerbuttonuse(var15, var0, var14.slot, var15.cooldowntime, var15.updatenotify, var15.usednotify, var20, var16, var2);
  }

  self notify("powers_updated");
}

function removepower(var0) {
  if(isDefined(level.powerunsetfuncs[var0])) {
    self[[level.powerunsetfuncs[var0]]]();
  }

  if(isDefined(self.powers[var0].weaponuse)) {
    self takeweapon(self.powers[var0].weaponuse);
  }

  if(self.powers[var0].slot == "primary") {
    self clearoffhandprimary();
    self.powerprimarygrenade = undefined;
  } else if(self.powers[var0].slot == "secondary") {
    self clearoffhandsecondary();
    self.powersecondarygrenade = undefined;
  }

  self notify("power_removed_" + var0);
  zm_powershud_clearpower(self.powers[var0].slot);
  self.powers[var0] = undefined;
}

function zm_powershud_clearpower(var0) {
  if(var0 == "scripted") {
    return;
  }

  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var0, 2), 0);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var0, 1), 0);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var0, 0), -1);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var0, 3), 0);
}

function cleanpowercooldowns() {
  if(isDefined(self.powercooldowns) && self.powercooldowns.size > 0) {
    var0 = self.powercooldowns;

    foreach(var2 in var0) {
      if(power_cooldownremaining(var2) == 0) {
        self.powercooldowns[var3] = undefined;
      }
    }

    return;
  }
}

function power_cooldownremaining(var0) {
  var1 = level.powers[var0.power];
  var2 = (var0.maxcharges - var0.charges) * var1.cooldowntime - var1.cooldowntime - var0.cooldownleft;
  var3 = (gettime() - var0.timestamp) / 1000;
  return max(0, var2 - var3);
}

function clearpowers() {
  self notify("powers_cleanUp");

  if(isDefined(self.powers)) {
    var0 = self.powers;

    foreach(var2 in var0) {
      removepower(var3);
    }

    self.powers = [];
    return;
  }
}

function getpower(var0) {
  if(!isDefined(self.powers)) {
    return undefined;
  }

  foreach(var2 in self.powers) {
    if(var2.slot == var0) {
      return var3;
    }
  }

  return undefined;
}

function clear_power_slot(var0) {
  var1 = self.powers;
  var2 = power_getpowerkeys();

  foreach(var4 in var2) {
    if(var1[var4].slot == var0) {
      self.powers[var4] = undefined;
      self notify("clear_power_slot" + var4);
      removepower(var4);
    }
  }

  zm_powershud_clearpower(var0);
}

function what_power_is_in_slot(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = getarraykeys(self.powers);

  foreach(var5 in var3) {
    if(isDefined(self.powers[var5].slot) && self.powers[var5].slot == var0) {
      var2 = var5;
      return var2;
    }
  }

  return undefined;
}

function power_getinputcommand(var0) {
  return scripts\engine\utility::ter_op(self.powers[var0].slot == "primary", "+frag", "+smoke");
}

function power_createplayerstruct(var0, var1, var2, var3, var4, var5) {
  var6 = level.powers[var0];
  var7 = spawnStruct();
  var7.slot = var1;
  var7.charges = var6.maxcharges;

  if(istrue(var2)) {
    var7.charges++;
  }

  if(isDefined(var5)) {
    var7.charges = var5;
  }

  var7.maxcharges = quadgridcenterpoints(var0, var1);
  var7.incooldown = 0;
  var7.active = 0;
  var7.cooldownleft = 0;
  var7.cooldownratemod = 1;
  var7.cooldown = var3;
  var7.permanent = var4;
  var7.passives = [];
  self.powers[var0] = var7;
}

function quadgridcenterpoints(var0, var1) {
  if(scripts\cp\utility::tryingtoleave()) {
    return level.powers[var0].maxcharges;
  }

  return scripts\cp\cp_loadout::get_num_of_charges_for_power(self, var1);
}

function managepowerbuttonuse(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var1);
  level endon("game_ended");

  if(isDefined(var8) && var8 || var1 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + var1);
  scripts\cp_mp\powershud::powershud_assignpower(var2, int(var0.id), 1, int(self.powers[var1].charges));
  scripts\cp\utility::gameflagwait("prematch_done");
  power_sethudstate(var2, 2);

  for(;;) {
    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      scripts\engine\utility::ref_143a6("revive", "revive_success", "challenge_complete_revive");
    }

    power_updateammo(var1);
    var9 = var6 + "_success";
    thread watchearlyout(var3, var1, var9);
    var10 = scripts\engine\utility::ter_op(var0.usetype == "weapon_hold", "offhand_pullback", "offhand_fired");
    self waittill(var10, var11);

    if(var11.basename != var6) {
      continue;
    }

    var3 = getpowercooldowntime(var0);
    self notify(var9);

    if(self.powers[var1].charges != 0 && !self.powers[var1].active) {
      var12 = undefined;

      if(isDefined(var0.usefunc)) {
        var12 = self thread[[var0.usefunc]](var11);

        if(isDefined(var12) && var12 == 0) {
          continue;
        }
      }

      if(isDefined(var5)) {
        self waittill(var5, var12);

        if(isDefined(var12) && var12 == 0) {
          continue;
        }
      }

      if(!isDefined(self.dont_use_charges) || self.dont_use_charges != var1) {}
    }

    power_adjustcharges(-1, self.powers[var1].slot);
    self notify("power_used " + var1);

    if(isDefined(var4) && level.powers[var1].uitype == "drain" && !istrue(self.powers[var1].indrain)) {
      power_dodrain(var1);
    }

    thread power_docooldown(var1, var3, var8);
  }
}

function ispickedupgrenadetype(var0) {
  switch (var0) {
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

function getpowercooldowntime(var0) {
  if(istrue(level.powershortcooldown)) {
    return 0.1;
  }

  if(istrue(level.infinite_grenades)) {
    return 2.5;
  }

  if(scripts\cp\utility::is_consumable_active("grenade_cooldown")) {
    return var0.cooldowntime;
  }

  return var0.cooldowntime;
}

function power_modifychargesonscavenge(var0) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var0);
  var1 = self.powers[var0];
  var2 = var1.weaponuse;
  var3 = var1.slot;

  for(;;) {
    self waittill("scavenged_ammo", var4);

    if(var4 == var2) {
      power_adjustcharges(var1.maxcharges, var3);
    }

    var5 = var1.hudstate;

    if(var5 == 1) {
      power_sethudstate(var3, 2);
    }
  }
}

function power_modifychargesonpickuporfailure(var0) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var0);
  var1 = self.powers[var0];
  var2 = var1.weaponuse;
  var3 = var1.slot;

  for(;;) {
    self waittill("pickup_equipment", var4);

    if(var4 == var2) {
      power_adjustcharges(1, var3);
    }

    var5 = var1.hudstate;

    if(var5 == 1) {
      power_sethudstate(var3, 2);
    }
  }
}

function remove_when_charges_exhausted(var0) {
  self endon("disconnect");
  self endon("power_removed_" + var0);
  level endon("game_ended");
  var1 = self.powers[var0];

  while(isDefined(self.powers[var0])) {
    self waittill("power_used " + var0);

    if(istrue(level.powershortcooldown)) {
      continue;
    }

    if(var1.charges < 1) {
      while(self isswitchingweapon() || scripts\engine\utility::array_contains(self.powers_active, var0)) {
        wait 0.25;
      }

      wait 0.25;
      thread removepower(var0);
    }
  }
}

function power_shouldcooldown(var0) {
  if(!isDefined(self.powers[var0])) {
    return false;
  }

  if(istrue(self.powers[var0].cooldown)) {
    return true;
  }

  if(istrue(level.powershortcooldown)) {
    return true;
  }

  if(level.powers[var0].usecooldown) {
    return true;
  }

  if(isDefined(self.powers[var0].slot) && self.powers[var0].slot != "primary") {
    return false;
  }

  if(scripts\cp\utility::is_consumable_active("grenade_cooldown") && level.powers[var0].defaultslot != "secondary") {
    return true;
  }

  if(istrue(level.infinite_grenades)) {
    return true;
  }

  return false;
}

function activatepower(var0) {
  self.powers_active[self.powers_active.size] = var0;
}

function deactivatepower(var0) {
  if(scripts\engine\utility::array_contains(self.powers_active, var0)) {
    self.powers_active = scripts\engine\utility::array_remove(self.powers_active, var0);
    return;
  }
}

function power_docooldown(var0, var1, var2) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var0);
  self endon("power_cooldown_ended" + var0);

  if(isDefined(var2) && var2 || var0 == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + var0);
  self notify("power_cooldown_begin_" + var0);
  self endon("power_cooldown_begin_" + var0);
  level endon("game_ended");
  var3 = level.powers[var0];
  var4 = self.powers[var0];
  var5 = var4.slot;
  var6 = var0 + "_cooldown_update";
  var4.incooldown = 1;

  if(!isDefined(var4.cooldownsqueued)) {
    var4.cooldownsqueued = 0;
  }

  var4.cooldownsqueued++;

  if(!isDefined(var4.cooldowncounter)) {
    var4.cooldowncounter = 0;
  }

  if(!isDefined(var4.cooldownleft)) {
    var4.cooldownleft = 0;
  }

  var4.cooldownleft += var1;
  var7 = var4.hudstate;
  jumpiffalse(isDefined(var7) && var7 != 0 && var4.charges == 0) LOC_00000116;
  power_sethudstate(var5, 1);

  while(var4.charges < var4.maxcharges) {
    if(power_shouldcooldown(var0)) {
      wait 0.1;
    } else {
      level scripts\engine\utility::ref_143a6("grenade_cooldown activated", "infinite_grenade_active", "start_power_cooldown");
      var1 = getpowercooldowntime(var3);
    }

    if(var4.cooldowncounter > var1) {
      power_adjustcharges(1, var5);
      power_updateammo(var0);

      if(var4.charges == var4.maxcharges) {
        thread power_endcooldown(var0, var2);
      }

      var4.cooldowncounter -= var1;
      var4.cooldownleft -= var1;
      var4.cooldownsqueued--;

      if(isDefined(var7) && var7 != 0) {
        power_sethudstate(var5, 2);
      }
    } else {
      var4.cooldowncounter += 0.1;
      var4.cooldownleft -= 0.1;
    }

    var8 = min(1, var4.cooldowncounter / var1);
    self notify(var6, var8);
  }

  thread power_endcooldown(var0, var2);
}

function power_endcooldown(var0, var1) {
  self notify("power_cooldown_ended" + var0);
  var2 = self.powers[var0];
  var2.incooldown = 0;
  var2.cooldowncounter = 0;
  var2.cooldownleft = 0;
  var2.cooldownsqueued = 0;

  if(isDefined(var1) && var1) {
    self notify("copycat_reset");
  }

  var3 = var2.hudstate;
  var4 = var2.slot;

  if(var3 == 0) {
    return;
  }

  power_sethudstate(var4, 2);
}

function power_dodrain(var0) {
  self endon("death");
  self endon("power_drain_ended_" + var0);
  self notify("power_cooldown_ended_" + var0);
  var1 = level.powers[var0];
  var2 = self.powers[var0];
  var3 = var1.updatenotify;
  var4 = var1.interruptnotify;
  var5 = var2.slot;
  var2.indrain = 1;
  power_disableactivation(var0);
  power_sethudstate(var5, 0);
  jumpiffalse(isDefined(var4)) LOC_00000071;
  thread power_enddrainoninterrupt(var0, var5, var4);

  for(;;) {
    self waittill(var3, var6);

    if(var6 == 0) {
      break;
    }
  }

  thread power_enddrain(var0);
}

function power_enddrainoninterrupt(var0, var1, var2) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var0);
  self endon("power_drain_ended_" + var0);
  self waittill(var2);
  thread power_enddrain(var0);
}

function power_enddrain(var0) {
  self notify("power_drain_ended_" + var0);
  var1 = self.powers[var0];
  var2 = var1.slot;
  var1.indrain = 0;
  power_enableactivation(var0);

  if(var1.charges > 0) {
    power_sethudstate(var2, 2);
    return;
  }

  power_sethudstate(var2, 1);
}

function haspower(var0) {
  if(!isDefined(self.powers[var0])) {
    return false;
  }

  return true;
}

function waitonpowerbutton(var0) {
  self endon("death");
  self endon("disconnect");

  if(var0 == "primary") {
    var1 = "power_primary_used";
  } else {
    var1 = "power_secondary_used";
  }

  for(;;) {
    if(!isDefined(self)) {
      wait 1;
      break;
    }

    self waittill(var1);
    break;
  }
}

function power_modifycooldownrate(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "all";
  }

  var2 = power_getpowerkeys();

  foreach(var4 in var2) {
    if(isDefined(self.powers[var4].slot) && self.powers[var4].slot == var1 || var1 == "all") {
      self.powers[var4].cooldownratemod = var0;
    }
  }
}

function power_adjustcharges(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = "all";
  }

  var3 = power_getpowerkeys();
  var4 = var0;

  foreach(var6 in var3) {
    if(!isDefined(var0)) {
      var4 = self.powers[var6].maxcharges;
    }

    if(self.powers[var6].slot == var1 || var1 == "all") {
      if(isDefined(var2)) {
        self.powers[var6].charges = int(min(var4, self.powers[var6].maxcharges));
      } else if(self.powers[var6].charges + var4 >= 0) {
        self.powers[var6].charges += var4;
      } else {
        self.powers[var6].charges = 0;
      }

      self.powers[var6].charges = int(clamp(self.powers[var6].charges, 0, self.powers[var6].maxcharges));
      self setweaponammoclip(self.powers[var6].weaponuse, self.powers[var6].charges);
      powershud_updatepowerchargescp(var6, self.powers[var6].slot, self.powers[var6].charges);
    }
  }
}

function ref_1281c(var0) {
  var1 = power_getpowerkeys(var0);

  foreach(var3 in var1) {
    if(var0.powers[var3].charges != var0.powers[var3].maxcharges) {
      return false;
    }
  }

  return true;
}

function power_getpowerkeys() {
  var0 = getarraykeys(level.powers);
  var1 = getarraykeys(self.powers);
  var2 = [];
  var3 = 0;

  foreach(var5 in var1) {
    foreach(var7 in var0) {
      if(var5 == var7) {
        var2 = var5;
        var3 += 1;
        break;
      }
    }
  }

  return var2;
}

function power_disablepower(var0) {
  if(scripts\common\utility::is_offhand_weapons_allowed()) {
    scripts\common\utility::allow_offhand_weapons(0);
    return;
  }
}

function power_enablepower(var0) {
  if(!scripts\common\utility::is_offhand_weapons_allowed()) {
    scripts\common\utility::allow_offhand_weapons(1);
    return;
  }
}

function definepowerovertimeduration(var0) {
  if(!isDefined(self.powerdurations)) {
    self.powerdurations = [];
  }

  if(!isDefined(self.powerdurations[var0])) {
    self.powerdurations[var0] = 0;
    return;
  }
}

function getpowerovertimeduration(var0) {
  definepowerovertimeduration(var0);
  return self.powerdurations[var0];
}

function setpowerovertimeduration(var0, var1) {
  definepowerovertimeduration(var0);
  self.powerdurations[var0] = var1;
}

function watchearlyout(var0, var1, var2) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + var1);
  self endon(var2);
  level endon("game_ended");
  self waittill("offhand_fired", var3);
  var4 = self.powers[var1];
  var5 = createheadicon(var3);

  if(var5 == var4.weaponuse) {
    if(!isalive(self)) {
      if(var4.charges > 0) {
        power_adjustcharges(-1, var4.slot);
      }

      if(!var4.incooldown) {
        var4.cooldownleft = level.powers[var1].cooldowntime;
        thread power_docooldown(var1, var0);
        return;
      }

      return;
    }

    return;
  }
}

function ispowersbuttonPressed(var0) {
  if(var0 == "+frag" && self fragButtonPressed() || var0 == "+smoke" && self secondaryoffhandbuttonPressed()) {
    return 1;
  }

  return 0;
}

function power_watchhudcharges(var0) {
  self endon("power_available_ended_" + var0);
  var1 = self.powers[var0];
  var2 = var1.slot;

  for(;;) {
    self waittill("power_charges_adjusted_" + var0, var3);
    powershud_updatepowerchargescp(var0, var2, var3);
  }
}

function powershud_updatepowerchargescp(var0, var1, var2) {
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var1, 0), int(var2));
}

function power_watchhuddrainmeter(var0) {
  self endon("disconnect");
  self endon("power_removed_" + var0);
  self endon("power_drain_ended_" + var0);
  var1 = self.powers[var0];
  var2 = level.powers[var0];
  var3 = var1.slot;
  var4 = var2.updatenotify;
  jumpiftrue(isDefined(var4)) LOC_0000004d;
  var4 = var0 + "_update";

  for(;;) {
    self waittill(var4, var5);
    var5 = max(0, min(1, var5));
    scripts\cp_mp\powershud::powershud_updatepowerdrainprogress(var3, var5);
  }
}

function power_watchhudcooldownmeter(var0) {
  self endon("disconnect");
  self endon("power_removed_" + var0);
  self endon("power_cooldown_ended" + var0);
  var1 = self.powers[var0];
  var2 = level.powers[var0];
  var3 = var1.slot;
  var4 = var0 + "_cooldown_update";

  for(;;) {
    self waittill(var4, var5);
    scripts\cp_mp\powershud::powershud_updatepowercooldown(var3, var5);
  }
}

function power_disableactivation(var0) {
  var1 = self.powers[var0];

  if(!isDefined(var1.disableactivation)) {
    var1.disableactivation = 0;
  }

  var1.disableactivation++;

  if(var1.disableactivation == 1) {
    power_updateammo(var0);
    return;
  }
}

function power_enableactivation(var0) {
  var1 = self.powers[var0];
  var1.disableactivation--;

  if(var1.disableactivation == 0) {
    power_updateammo(var0);
    return;
  }
}

function power_updateammo(var0) {
  var1 = self.powers[var0];
  var2 = isDefined(var1.disableactivation) && var1.disableactivation;
  var3 = var1.charges > 0;

  if(!var2 && var3) {
    self setweaponammoclip(var1.weaponuse, var1.charges + 1);
    return;
  }

  self setweaponammoclip(var1.weaponuse, 0);

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    thread ref_1281d(var1.slot);
    return;
  }
}

function ref_1281d(var0) {
  if(var0 == "primary") {
    self setclientomnvar("reset_wave_loadout", 3);
    return;
  }

  if(var0 == "secondary") {
    wait 0.5;
    self setclientomnvar("reset_wave_loadout", 4);
    return;
  }
}

function power_addammo(var0, var1) {
  var2 = self.powers[var0];
  var3 = isDefined(var2.disableactivation) && var2.disableactivation;
  var4 = var2.charges;

  if(!var3) {
    if(var4 + 1 < var2.maxcharges) {
      self setweaponammoclip(var2.objweapon, var4 + 1);
      self notify("power_charges_adjusted_" + var0, var4 + 1);
      var2.charges += 1;
      return;
    }

    self setweaponammoclip(var2.objweapon, var2.maxcharges);
    self notify("power_charges_adjusted_" + var0, var2.maxcharges);
    var2.charges = var2.maxcharges;
    return;
  }

  self setweaponammoclip(var2.weaponuse, 0);
}

function get_info_for_player_powers(var0) {
  var1 = [];

  foreach(var3 in getarraykeys(var0.powers)) {
    var4 = spawnStruct();
    var4.slot = var0.powers[var3].slot;
    var4.charges = var0.powers[var3].charges;
    var4.cooldown = var0.powers[var3].cooldown;
    var4.permanent = var0.powers[var3].permanent;
    var4.maxcharges = var0.powers[var3].maxcharges;
    var1 = var4;
  }

  return var1;
}

function restore_powers(var0, var1) {
  foreach(var6, var3 in var1) {
    var4 = undefined;
    var5 = 0;

    if(istrue(var3.cooldown)) {
      var4 = 1;
    }

    if(istrue(var3.permanent)) {
      var5 = 1;
    }

    if(var3.slot == "secondary") {
      if(var6 == "power_bait") {
        givepower(var0, var6, var3.slot, undefined, undefined, undefined, 1, 1, var3.maxcharges);
      } else {
        givepower(var0, var6, var3.slot, undefined, undefined, undefined, var4, var5, var3.maxcharges);
      }

      power_adjustcharges(var0, var3.charges, var3.slot, 1);
      continue;
    }

    givepower(var0, var6, var3.slot, undefined, undefined, undefined, undefined, 1, var3.maxcharges);
    power_adjustcharges(var0, var3.charges, var3.slot, 1);
  }
}

function givecover(var0) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired(undefined, undefined, undefined, 0);
}

function takecover(var0) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_take(undefined, undefined, 1);
}