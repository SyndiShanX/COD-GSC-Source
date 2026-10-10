/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_powers.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_loadout;
#using scripts\cp\cp_powers;
#using scripts\cp\equipment\cp_trophy_system;
#using scripts\cp\laststand;
#using scripts\cp\powers\cp_tactical_cover;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\powershud;
#using scripts\engine\utility;
#namespace cp_powers;

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
  thread powershud_init();
  powerparsetable();

  if(isDefined(level.power_setup_init)) {
    level[[level.power_setup_init]]();
  } else {
    powersetupfunctions("power_c4", undefined, undefined, undefined, "c4_update", undefined, undefined);
    powersetupfunctions("power_flash", undefined, undefined, undefined, undefined, undefined, undefined);
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

  level setupovercookfuncs();
  flag_init("powers_init_done");
  flag_set("powers_init_done");
}

function setupovercookfuncs() {
  level.overcook_func["frag_grenade_mp"] = &fraggrenadeovercookfunc;
}

function fraggrenadeovercookfunc(victim, sweapon) {
  level endon("game_ended");
  victim endon("disconnect");
  power = "power_frag";
  victim endon("power_removed_" + power);

  if(!isDefined(sweapon) || sweapon != "frag_grenade_mp") {
    return;
  }

  if(!victim haspower(power)) {
    return;
  }

  position = victim.origin;
  playFX(level._effect["grenade_explode_overcook"], position);
  playsoundatpos(position, "iw9_frag_grenade_expl_trans");

  if(!isDefined(victim.powers[power])) {
    return;
  }

  victim power_adjustcharges(victim.powers[power].charges - 1, victim.powers[power].slot, 1);
  victim power_updateammo(power);
  victim radiusdamage(position, 256, 150, 100, victim, "MOD_GRENADE", "frag_grenade_mp");
  playrumbleonposition("grenade_rumble", position);
  earthquake(0.5, 0.75, position, 800);

  foreach(player in level.players) {
    if(player isusingremote()) {
      continue;
    }

    if(distancesquared(position, player.origin) > 360000) {
      continue;
    }

    if(player damageconetrace(position)) {
      player thread scripts\cp\weapon::dirteffect(position);
    }

    player setclientomnvar("ui_hud_shake", 1);
  }

  victim thread reset_grenades();
  victim thread delete_last_second_grenade_throws(power);
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

function delete_last_second_grenade_throws(power) {
  self endon("death");
  self endon("end_last_second_throw_func");
  self notify("starting_delay_last_second_grenade_throws");
  thread end_function_after_time(0.25);
  self waittill("grenade_fire", arg1, arg2, arg3, arg4);

  if(isDefined(arg1) && arg1.classname == "grenade") {
    arg1 delete();
    power_adjustcharges(self.powers[power].charges + 1, self.powers[power].slot, 1);
  }
}

function end_function_after_time(timer) {
  self endon("death");
  wait timer;
  self notify("end_last_second_throw_func");
}

function power_createdefaultstruct(power, usetype, weaponuse, id, cooldowntime, maxcharges, deathreset, usecooldown, uitype, defaultslot) {
  assertex(isDefined(power) && isstring(power), "power_createDefaultStruct() called with invalid power.");
  assertex(isDefined(usetype) && isstring(usetype), "power_createDefaultStruct() called with invalid useType.");
  assertex(isDefined(weaponuse) && weaponuse != "", "power_createDefaultStruct(): requires a weapon to be defined.");
  assertex(isDefined(id), "power_createDefaultStruct() called with invalid id.");
  assertex(isDefined(cooldowntime), "power_createDefaultStruct() called with invalid cooldownTime.");
  assertex(isDefined(maxcharges), "power_createDefaultStruct() called with invalid maxCharges.");
  assertex(isDefined(maxcharges), "power_createDefaultStruct() called with invalid deathReset.");
  assertex(isDefined(usecooldown), "power_createDefaultStruct() called with invalid useCooldown.");
  assertex(isDefined(uitype), "power_createDefaultStruct() called with invalid uiType.");
  assertex(!isDefined(level.powers[power]), "power_createDefaultStruct() called multiple times on the same power: " + power);
  struct = spawnStruct();
  struct.usetype = usetype;
  struct.weaponuse = weaponuse;
  struct.cooldowntime = cooldowntime;
  struct.id = id;

  if(isDefined(weaponuse)) {
    struct.maxcharges = weaponstartammo(weaponuse);
  } else {
    struct.maxcharges = maxcharges;
  }

  struct.deathreset = deathreset;
  struct.usecooldown = usecooldown;
  struct.uitype = uitype;
  struct.defaultslot = defaultslot;
  level.powers[power] = struct;
}

function powerparsetable() {
  row = 1;

  if(isDefined(level.power_table)) {
    table = level.power_table;
  } else {
    table = "cp/cp_powerTable.csv";
  }

  while(true) {
    id = tablelookupbyrow(table, row, 0);

    if(id == "") {
      break;
    }

    refname = tablelookupbyrow(table, row, 1);
    usetype = tablelookupbyrow(table, row, 6);
    useweapon = tablelookupbyrow(table, row, 7);
    cooldown = tablelookupbyrow(table, row, 8);
    maxcharges = tablelookupbyrow(table, row, 9);
    deathreset = tablelookupbyrow(table, row, 10);
    usecooldown = tablelookupbyrow(table, row, 11);
    uitype = tablelookupbyrow(table, row, 16);
    defaultslot = tablelookupbyrow(table, row, 13);
    power_createdefaultstruct(refname, usetype, useweapon, int(id), float(cooldown), int(maxcharges), int(deathreset), int(usecooldown), uitype, defaultslot);

    if(isDefined(level.powerweaponmap[useweapon]) && useweapon != "<power_script_generic_weapon>") {
      switch (useweapon) {
        case #"hash_e674cd076f353038":
          if(refname == "power_rewinder") {
            break;
          }
        default:
          assertmsg("Two powers attempting to use the same weapon. " + refname + " and " + level.powerweaponmap[useweapon]);
          break;
      }
    }

    level.powerweaponmap[useweapon] = refname;
    row++;
  }
}

function powersetupfunctions(power, setfunc, unsetfunc, usefunc, updatenotify, usednotify, interruptnotify) {
  struct = level.powers[power];

  if(!isDefined(struct)) {
    error("No configuration data for " + power + " found! Is it in powertable.csv? Or make sure powerSetupFunctions is called after the table is initialized.");
  }

  level.powersetfuncs[power] = setfunc;
  level.powerunsetfuncs[power] = unsetfunc;

  if(isDefined(usefunc)) {
    struct.usefunc = usefunc;
  }

  if(isDefined(updatenotify)) {
    struct.updatenotify = updatenotify;
  }

  if(isDefined(usednotify)) {
    struct.usednotify = usednotify;
  }

  if(isDefined(interruptnotify)) {
    struct.interruptnotify = interruptnotify;
  }
}

function power_sethudstate(slot, newstate) {
  power = getpower(slot);
  var_bdfac2ddbd96a676 = self.powers[power];
  var_e0c214de92f727a2 = level.powers[power];
  state = var_bdfac2ddbd96a676.hudstate;
  charges = var_bdfac2ddbd96a676.charges;

  if(isDefined(state) && state == newstate) {
    return;
  }

  if(isDefined(state)) {
    power_unsethudstate(slot);
  }

  switch (newstate) {
    case 0:
      powershud_beginpowerdrain(slot);
      powershud_updatepowermeter(slot, 1);
      powershud_updatepowerchargescp(power, slot, charges);
      thread power_watchhuddrainmeter(power);
      break;
    case 1:
      powershud_beginpowercooldown(slot, 0);
      powershud_updatepowerchargescp(power, slot, charges);
      thread power_watchhudcooldownmeter(power);
      break;
    case 2:
      powershud_updatepowerdisabled(slot, 0);
      powershud_updatepowermeter(slot, 1);
      powershud_updatepowerchargescp(power, slot, charges);
      thread power_watchhudcharges(power);
      break;
    case 3:
      break;
  }

  var_bdfac2ddbd96a676.hudstate = newstate;
  thread power_unsethudstateonremoved(slot);
}

function power_unsethudstate(slot) {
  power = getpower(slot);

  if(!isDefined(power)) {
    return;
  }

  var_bdfac2ddbd96a676 = self.powers[power];
  hudstate = var_bdfac2ddbd96a676.hudstate;

  if(!isDefined(hudstate)) {
    return;
  }

  switch (hudstate) {
    case #"hash_a2d60046b3c8fee9":
      break;
    case 0:
      powershud_endpowerdrain(slot);
      break;
    case 2:
      break;
    case 1:
      powershud_finishpowercooldown(slot, 0);
      break;
  }

  var_bdfac2ddbd96a676.hudstate = undefined;
}

function power_unsethudstateonremoved(slot) {
  self endon("disconnect");
  self notify("power_unsetHudStateOnRemoved_" + slot);
  self endon("power_unsetHudStateOnRemoved_" + slot);
  power = getpower(slot);
  self waittill("power_removed_" + power);
  power_unsethudstate(slot);
}

function givepower(power, slot, var_1240c819518d164c, passives, extracharge, cooldown, permanent, var_c3d005dcdd2a50a2) {
  assertex(isDefined(power), "givePower() param power not defined");
  assertex(isDefined(slot) && (slot == "primary" || slot == "secondary" || slot == "scripted"), "givePower() param slot invalid");
  var_546da77ecd6ea55f = 2;

  if(!isDefined(self.powers)) {
    self.powers = [];
  }

  if(power == "none") {
    return;
  }

  if(slot == "scripted") {
    var_546da77ecd6ea55f++;
  }

  for(heldoffhand = self getheldoffhand(); !isnullweapon(heldoffhand); heldoffhand = self getheldoffhand()) {
    waitframe();
  }

  var_6110f0b30c5a30c4 = getarraykeys(self.powers);

  foreach(item in var_6110f0b30c5a30c4) {
    if(self.powers[item].slot == slot) {
      self.itemreplaced = item;
      removepower(item);
      break;
    }
  }

  assertex(self.powers.size <= var_546da77ecd6ea55f, self.powers.size + ": givePower() called on player without first removing a power. Should not have more than" + var_546da77ecd6ea55f + ".");

  if(istrue(level.var_6977260e9e3fa7c)) {
    extracharge = 1;
  }

  if(isDefined(level.extra_charge_func)) {
    extracharge = [[level.extra_charge_func]](power);
  }

  power_createplayerstruct(power, slot, extracharge, cooldown, permanent, var_c3d005dcdd2a50a2);
  var_bdfac2ddbd96a676 = self.powers[power];
  var_e0c214de92f727a2 = level.powers[power];
  self notify("delete_equipment " + slot);
  var_c19c52338a112eda = 0;

  if(isDefined(self.powercooldowns) && isDefined(self.powercooldowns[power])) {
    var_7dfb465fca9e822d = self.powercooldowns[power];
    var_4408b269f137df4 = power_cooldownremaining(var_7dfb465fca9e822d);

    if(var_4408b269f137df4 > 0) {
      timetotal = var_bdfac2ddbd96a676.charges * var_e0c214de92f727a2.cooldowntime;
      var_bdfac2ddbd96a676.charges = int((timetotal - var_4408b269f137df4) / var_e0c214de92f727a2.cooldowntime);

      if(var_bdfac2ddbd96a676.charges < 0) {
        assertmsg("givePower() calculated a negative amount of charges remaining. Should not happen.");
        var_bdfac2ddbd96a676.charges = 0;
      }

      var_c19c52338a112eda = var_4408b269f137df4;

      while(var_c19c52338a112eda > var_e0c214de92f727a2.cooldowntime) {
        var_c19c52338a112eda -= var_e0c214de92f727a2.cooldowntime;
      }
    }
  }

  if(slot == "scripted") {
    return;
  }

  var_bdfac2ddbd96a676.weaponuse = undefined;

  if(var_e0c214de92f727a2.weaponuse == "<power_script_generic_weapon>") {
    var_bdfac2ddbd96a676.weaponuse = ter_op(slot == "primary", "power_script_generic_primary_mp", "power_script_generic_secondary_mp");
  } else {
    var_bdfac2ddbd96a676.weaponuse = var_e0c214de92f727a2.weaponuse;
  }

  weaponuse = var_bdfac2ddbd96a676.weaponuse;
  var_bdfac2ddbd96a676.weaponuse = weaponuse;
  var_bdfac2ddbd96a676.objweapon = makeweapon(weaponuse);
  self giveweapon(var_bdfac2ddbd96a676.objweapon);
  self setweaponammoclip(var_bdfac2ddbd96a676.objweapon, var_bdfac2ddbd96a676.charges);

  if(var_bdfac2ddbd96a676.slot == "primary") {
    self assignweaponoffhandprimary(var_bdfac2ddbd96a676.objweapon);
    self.powerprimarygrenade = weaponuse;
    self setclientomnvar("ui_power_max_charges", var_bdfac2ddbd96a676.charges);
  } else if(var_bdfac2ddbd96a676.slot == "secondary") {
    self assignweaponoffhandsecondary(var_bdfac2ddbd96a676.objweapon);
    self.powersecondarygrenade = weaponuse;
    self setclientomnvar("ui_power_secondary_max_charges", var_bdfac2ddbd96a676.charges);
  }

  if(isDefined(level.powersetfuncs[power])) {
    self[[level.powersetfuncs[power]]](power);
  }

  if(isDefined(permanent) && !permanent) {
    thread remove_when_charges_exhausted(power);
  }

  if(!isai(self)) {
    thread power_modifychargesonscavenge(power);
    thread power_modifychargesonpickuporfailure(power);
    thread managepowerbuttonuse(var_e0c214de92f727a2, power, var_bdfac2ddbd96a676.slot, var_e0c214de92f727a2.cooldowntime, var_e0c214de92f727a2.updatenotify, var_e0c214de92f727a2.usednotify, weaponuse, var_c19c52338a112eda, var_1240c819518d164c);
  }
}

function removepower(power) {
  assertex(isDefined(self.powers) && isDefined(self.powers[power]), "removePower() called on player without power: " + power);

  if(isDefined(level.powerunsetfuncs[power])) {
    self[[level.powerunsetfuncs[power]]]();
  }

  if(isDefined(self.powers[power].weaponuse)) {
    self takeweapon(self.powers[power].weaponuse);
  }

  if(self.powers[power].slot == "primary") {
    self clearoffhandprimary();
    self.powerprimarygrenade = undefined;
  } else if(self.powers[power].slot == "secondary") {
    self clearoffhandsecondary();
    self.powersecondarygrenade = undefined;
  }

  self notify("power_removed_" + power);
  zm_powershud_clearpower(self.powers[power].slot);
  self.powers[power] = undefined;
}

function zm_powershud_clearpower(slot) {
  if(slot == "scripted") {
    return;
  }

  self setclientomnvar(powershud_getslotomnvar(slot, 2), 0);
  self setclientomnvar(powershud_getslotomnvar(slot, 1), 0);
  self setclientomnvar(powershud_getslotomnvar(slot, 0), -1);
  self setclientomnvar(powershud_getslotomnvar(slot, 3), 0);
}

function cleanpowercooldowns() {
  if(isDefined(self.powercooldowns) && self.powercooldowns.size > 0) {
    cooldowns = self.powercooldowns;

    foreach(struct in cooldowns) {
      if(power_cooldownremaining(struct) == 0) {
        self.powercooldowns[pwr] = undefined;
      }
    }
  }
}

function power_cooldownremaining(struct) {
  var_e0c214de92f727a2 = level.powers[struct.power];
  var_231069448521a740 = (struct.maxcharges - struct.charges) * var_e0c214de92f727a2.cooldowntime - var_e0c214de92f727a2.cooldowntime - struct.cooldownleft;
  timepassed = (gettime() - struct.timestamp) / 1000;
  return max(0, var_231069448521a740 - timepassed);
}

function clearpowers() {
  self notify("powers_cleanUp");

  if(isDefined(self.powers)) {
    powers = self.powers;

    foreach(struct in powers) {
      removepower(pwr);
    }

    self.powers = [];
  }
}

function getpower(slot) {
  if(!isDefined(self.powers)) {
    return undefined;
  }

  foreach(power in self.powers) {
    if(power.slot == slot) {
      return powername;
    }
  }

  return undefined;
}

function clear_power_slot(slot) {
  powers = self.powers;
  array = power_getpowerkeys();

  foreach(item in array) {
    if(powers[item].slot == slot) {
      self.powers[item] = undefined;
      self notify("clear_power_slot" + item);
      removepower(item);
    }
  }

  zm_powershud_clearpower(slot);
}

function what_power_is_in_slot(slot) {
  powers = undefined;
  power = undefined;
  array = getarraykeys(self.powers);

  foreach(key in array) {
    if(isDefined(self.powers[key].slot) && self.powers[key].slot == slot) {
      power = key;
      return power;
    }
  }

  return undefined;
}

function power_getinputcommand(power) {
  assertex(isDefined(level.powers[power]), "power_getInputCommand() called on power not entered into level.powers.");
  return ter_op(self.powers[power].slot == "primary", "+frag", "+smoke");
}

function power_createplayerstruct(power, slot, extracharge, cooldown, permanent, var_c3d005dcdd2a50a2) {
  assertex(isDefined(level.powers[power]), "power_createPlayerStruct() called with power: " + power + " that's not defined in level.powers array.");
  var_e0c214de92f727a2 = level.powers[power];
  var_653f9ba7f27182ab = spawnStruct();
  var_653f9ba7f27182ab.slot = slot;
  var_653f9ba7f27182ab.charges = var_e0c214de92f727a2.maxcharges;

  if(istrue(extracharge)) {
    var_653f9ba7f27182ab.charges++;
  }

  var_653f9ba7f27182ab.maxcharges = get_max_charges(power, slot);

  if(isDefined(var_c3d005dcdd2a50a2)) {
    var_653f9ba7f27182ab.maxcharges = var_c3d005dcdd2a50a2;
    var_653f9ba7f27182ab.charges = var_653f9ba7f27182ab.maxcharges;
  }

  var_653f9ba7f27182ab.incooldown = 0;
  var_653f9ba7f27182ab.active = 0;
  var_653f9ba7f27182ab.cooldownleft = 0;
  var_653f9ba7f27182ab.cooldownratemod = 1;
  var_653f9ba7f27182ab.cooldown = cooldown;
  var_653f9ba7f27182ab.permanent = permanent;
  var_653f9ba7f27182ab.passives = [];
  self.powers[power] = var_653f9ba7f27182ab;
  self.equipment[slot] = power;
}

function get_max_charges(power, slot) {
  if(scripts\cp\utility::is_specops_gametype()) {
    return level.powers[power].maxcharges;
  }

  return scripts\cp\cp_loadout::get_num_of_charges_for_power(self, slot);
}

function managepowerbuttonuse(var_e0c214de92f727a2, power, slot, cooldowntime, updatenotify, usednotify, weaponuse, var_c19c52338a112eda, var_1240c819518d164c) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  level endon("game_ended");

  if(isDefined(var_1240c819518d164c) && var_1240c819518d164c || power == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + power);
  powershud_assignpower(slot, int(var_e0c214de92f727a2.id), 1, int(self.powers[power].charges));
  gameflagwait("prematch_done");
  power_sethudstate(slot, 2);

  while(true) {
    if(scripts\cp\laststand::player_in_laststand(self)) {
      waittill_any_3("revive", "revive_success", "challenge_complete_revive");
    }

    power_updateammo(power);
    var_80905137dd741a79 = weaponuse + "_success";
    thread watchearlyout(cooldowntime, power, var_80905137dd741a79);
    var_b1aa23f01ec70c87 = ter_op(var_e0c214de92f727a2.usetype == "weapon_hold", "offhand_pullback", "offhand_fired");
    self waittill(var_b1aa23f01ec70c87, objweapon);

    if(objweapon.basename != weaponuse) {
      continue;
    }

    cooldowntime = getpowercooldowntime(var_e0c214de92f727a2);
    self notify(var_80905137dd741a79);

    if(self.powers[power].charges != 0 && !self.powers[power].active) {
      success = undefined;

      if(isDefined(var_e0c214de92f727a2.usefunc)) {
        success = self thread[[var_e0c214de92f727a2.usefunc]](objweapon);

        if(isDefined(success) && success == 0) {
          continue;
        }
      }

      if(isDefined(usednotify)) {
        self waittill(usednotify, success);

        if(isDefined(success) && success == 0) {
          continue;
        }
      }

      if(!isDefined(self.dont_use_charges) || self.dont_use_charges != power) {}
    }

    power_adjustcharges(-1, self.powers[power].slot);
    self notify("power_used " + power);

    if(isDefined(updatenotify) && level.powers[power].uitype == "drain" && !istrue(self.powers[power].indrain)) {
      power_dodrain(power);
    }

    thread power_docooldown(power, cooldowntime, var_1240c819518d164c);
  }
}

function ispickedupgrenadetype(power) {
  switch (power) {
    case #"hash_1bc398971cc4305c":
    case #"hash_497754f33560ac77":
    case #"hash_5a611d302206f39c":
    case #"hash_6a8bfc48d4a90ba3":
    case #"hash_ae10efa2fe15642a":
    case #"hash_bf0fd8e6fe2267bb":
      return 1;
    default:
      return 0;
  }
}

function getpowercooldowntime(var_e0c214de92f727a2) {
  if(istrue(level.powershortcooldown)) {
    return 0.1;
  }

  if(istrue(level.infinite_grenades)) {
    return 2.5;
  }

  if(is_consumable_active("grenade_cooldown")) {
    return var_e0c214de92f727a2.cooldowntime;
  }

  return var_e0c214de92f727a2.cooldowntime;
}

function power_modifychargesonscavenge(power) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  var_bdfac2ddbd96a676 = self.powers[power];
  weaponuse = var_bdfac2ddbd96a676.weaponuse;
  slot = var_bdfac2ddbd96a676.slot;

  while(true) {
    self waittill("scavenged_ammo", weaponname);

    if(weaponname == weaponuse) {
      power_adjustcharges(var_bdfac2ddbd96a676.maxcharges, slot);
    }

    state = var_bdfac2ddbd96a676.hudstate;

    if(state == 1) {
      power_sethudstate(slot, 2);
    }
  }
}

function power_modifychargesonpickuporfailure(power) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  var_bdfac2ddbd96a676 = self.powers[power];
  weaponuse = var_bdfac2ddbd96a676.weaponuse;
  slot = var_bdfac2ddbd96a676.slot;

  while(true) {
    self waittill("pickup_equipment", weaponname);

    if(weaponname == weaponuse) {
      power_adjustcharges(1, slot);
    }

    state = var_bdfac2ddbd96a676.hudstate;

    if(state == 1) {
      power_sethudstate(slot, 2);
    }
  }
}

function remove_when_charges_exhausted(power) {
  self endon("disconnect");
  self endon("power_removed_" + power);
  level endon("game_ended");
  var_bdfac2ddbd96a676 = self.powers[power];

  while(isDefined(self.powers[power])) {
    self waittill("power_used " + power);

    if(istrue(level.powershortcooldown)) {
      continue;
    }

    if(var_bdfac2ddbd96a676.charges < 1) {
      while(self isswitchingweapon() || array_contains(self.powers_active, power)) {
        wait 0.25;
      }

      wait 0.25;
      thread removepower(power);
    }
  }
}

function power_shouldcooldown(power) {
  if(!isDefined(self.powers[power])) {
    return false;
  }

  if(istrue(self.powers[power].cooldown)) {
    return true;
  }

  if(istrue(level.powershortcooldown)) {
    return true;
  }

  if(level.powers[power].usecooldown) {
    return true;
  }

  if(isDefined(self.powers[power].slot) && self.powers[power].slot != "primary") {
    return false;
  }

  if(is_consumable_active("grenade_cooldown") && level.powers[power].defaultslot != "secondary") {
    return true;
  }

  if(istrue(level.infinite_grenades)) {
    return true;
  }

  if(isDefined(level.var_2824d9ed9338d048)) {
    if(level.var_2824d9ed9338d048 == 1) {
      return true;
    }

    if(level.var_2824d9ed9338d048 == 0) {
      return false;
    }
  }

  return false;
}

function activatepower(power) {
  self.powers_active[self.powers_active.size] = power;
}

function deactivatepower(power) {
  if(array_contains(self.powers_active, power)) {
    self.powers_active = array_remove(self.powers_active, power);
  }
}

function power_docooldown(power, cooldowntime, var_1240c819518d164c) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  self endon("power_cooldown_ended" + power);

  if(isDefined(var_1240c819518d164c) && var_1240c819518d164c || power == "power_copycatGrenade") {
    self endon("start_copycat");
  }

  self endon("clear_power_slot" + power);
  self notify("power_cooldown_begin_" + power);
  self endon("power_cooldown_begin_" + power);
  level endon("game_ended");
  var_e0c214de92f727a2 = level.powers[power];
  var_bdfac2ddbd96a676 = self.powers[power];
  slot = var_bdfac2ddbd96a676.slot;
  updatenotify = power + "_cooldown_update";
  var_bdfac2ddbd96a676.incooldown = 1;

  if(!isDefined(var_bdfac2ddbd96a676.cooldownsqueued)) {
    var_bdfac2ddbd96a676.cooldownsqueued = 0;
  }

  var_bdfac2ddbd96a676.cooldownsqueued++;

  if(!isDefined(var_bdfac2ddbd96a676.cooldowncounter)) {
    var_bdfac2ddbd96a676.cooldowncounter = 0;
  }

  if(!isDefined(var_bdfac2ddbd96a676.cooldownleft)) {
    var_bdfac2ddbd96a676.cooldownleft = 0;
  }

  var_bdfac2ddbd96a676.cooldownleft += cooldowntime;
  state = var_bdfac2ddbd96a676.hudstate;

  if(isDefined(state) && state != 0 && var_bdfac2ddbd96a676.charges == 0) {
    power_sethudstate(slot, 1);
  }

  while(var_bdfac2ddbd96a676.charges < var_bdfac2ddbd96a676.maxcharges) {
    if(power_shouldcooldown(power)) {
      wait 0.1;
    } else {
      level waittill_any_3("grenade_cooldown activated", "infinite_grenade_active", "start_power_cooldown");
      cooldowntime = getpowercooldowntime(var_e0c214de92f727a2);
    }

    if(var_bdfac2ddbd96a676.cooldowncounter > cooldowntime) {
      power_adjustcharges(1, slot);
      power_updateammo(power);

      if(var_bdfac2ddbd96a676.charges == var_bdfac2ddbd96a676.maxcharges) {
        thread power_endcooldown(power, var_1240c819518d164c);
      }

      var_bdfac2ddbd96a676.cooldowncounter -= cooldowntime;
      var_bdfac2ddbd96a676.cooldownleft -= cooldowntime;
      var_bdfac2ddbd96a676.cooldownsqueued--;

      if(isDefined(state) && state != 0) {
        power_sethudstate(slot, 2);
      }
    } else {
      var_bdfac2ddbd96a676.cooldowncounter += 0.1;
      var_bdfac2ddbd96a676.cooldownleft -= 0.1;
    }

    var_88a6638c4d7144a2 = min(1, var_bdfac2ddbd96a676.cooldowncounter / cooldowntime);
    self notify(updatenotify, var_88a6638c4d7144a2);
  }

  thread power_endcooldown(power, var_1240c819518d164c);
}

function power_endcooldown(power, var_1240c819518d164c) {
  self notify("power_cooldown_ended" + power);
  var_bdfac2ddbd96a676 = self.powers[power];
  var_bdfac2ddbd96a676.incooldown = 0;
  var_bdfac2ddbd96a676.cooldowncounter = 0;
  var_bdfac2ddbd96a676.cooldownleft = 0;
  var_bdfac2ddbd96a676.cooldownsqueued = 0;

  if(isDefined(var_1240c819518d164c) && var_1240c819518d164c) {
    self notify("copycat_reset");
  }

  hudstate = var_bdfac2ddbd96a676.hudstate;
  slot = var_bdfac2ddbd96a676.slot;

  if(hudstate == 0) {
    return;
  }

  power_sethudstate(slot, 2);
}

function power_dodrain(power) {
  self endon("death");
  self endon("power_drain_ended_" + power);
  self notify("power_cooldown_ended_" + power);
  var_e0c214de92f727a2 = level.powers[power];
  var_bdfac2ddbd96a676 = self.powers[power];
  updatenotify = var_e0c214de92f727a2.updatenotify;
  interruptnotify = var_e0c214de92f727a2.interruptnotify;
  slot = var_bdfac2ddbd96a676.slot;
  var_bdfac2ddbd96a676.indrain = 1;
  power_disableactivation(power);
  power_sethudstate(slot, 0);

  if(isDefined(interruptnotify)) {
    thread power_enddrainoninterrupt(power, slot, interruptnotify);
  }

  while(true) {
    self waittill(updatenotify, value);

    if(value == 0) {
      break;
    }
  }

  thread power_enddrain(power);
}

function power_enddrainoninterrupt(power, slot, interruptnotify) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  self endon("power_drain_ended_" + power);
  self waittill(interruptnotify);
  thread power_enddrain(power);
}

function power_enddrain(power) {
  self notify("power_drain_ended_" + power);
  var_bdfac2ddbd96a676 = self.powers[power];
  slot = var_bdfac2ddbd96a676.slot;
  var_bdfac2ddbd96a676.indrain = 0;
  power_enableactivation(power);

  if(var_bdfac2ddbd96a676.charges > 0) {
    power_sethudstate(slot, 2);
    return;
  }

  power_sethudstate(slot, 1);
}

function haspower(power) {
  if(!isDefined(self.powers[power])) {
    return false;
  }

  return true;
}

function waitonpowerbutton(slot) {
  self endon("death");
  self endon("disconnect");

  if(slot == "primary") {
    var_2d19f7aab0ae05a2 = "power_primary_used";
  } else {
    var_2d19f7aab0ae05a2 = "power_secondary_used";
  }

  while(true) {
    if(!isDefined(self)) {
      wait 1;
      break;
    }

    self waittill(var_2d19f7aab0ae05a2);
    break;
  }
}

function power_modifycooldownrate(var_971e656edbdb9fe7, slot) {
  if(!isDefined(slot)) {
    slot = "all";
  }

  array = power_getpowerkeys();

  foreach(key in array) {
    if(isDefined(self.powers[key].slot) && self.powers[key].slot == slot || slot == "all") {
      self.powers[key].cooldownratemod = var_971e656edbdb9fe7;
    }
  }
}

function power_adjustcharges(adjustment, slot, var_d6eae0bf53da1172) {
  if(!isDefined(slot)) {
    slot = "all";
  }

  array = power_getpowerkeys();
  var_78d608efc5c796c6 = adjustment;

  foreach(key in array) {
    if(!isDefined(adjustment)) {
      var_78d608efc5c796c6 = self.powers[key].maxcharges;
    }

    if(self.powers[key].slot == slot || slot == "all") {
      if(isDefined(var_d6eae0bf53da1172)) {
        self.powers[key].charges = int(min(var_78d608efc5c796c6, self.powers[key].maxcharges));
      } else if(self.powers[key].charges + var_78d608efc5c796c6 >= 0) {
        self.powers[key].charges += var_78d608efc5c796c6;
      } else {
        self.powers[key].charges = 0;
      }

      self.powers[key].charges = int(clamp(self.powers[key].charges, 0, self.powers[key].maxcharges));
      self setweaponammoclip(self.powers[key].weaponuse, self.powers[key].charges);
      powershud_updatepowerchargescp(key, self.powers[key].slot, self.powers[key].charges);
    }
  }
}

function function_ae3298b480d63acd(slot, num_charges) {
  if(slot == "primary") {
    primary_gren = getpower(slot);

    if(!array_contains_key(level.powers, primary_gren)) {
      primary_gren = "power_frag";
    }

    thread scripts\cp\cp_powers::givepower(primary_gren, "primary", undefined, undefined, undefined, undefined, 1, num_charges);
    return;
  }

  if(slot == "secondary") {
    secondary_gren = getpower(slot);

    if(!array_contains_key(level.powers, secondary_gren)) {
      secondary_gren = "power_flash";
    }

    thread scripts\cp\cp_powers::givepower(secondary_gren, "secondary", undefined, undefined, undefined, undefined, 1, num_charges);
  }
}

function power_checkifequipmentammofull(player) {
  array = player power_getpowerkeys();

  foreach(key in array) {
    if(player.powers[key].charges != player.powers[key].maxcharges) {
      return false;
    }
  }

  return true;
}

function power_getpowerkeys() {
  var_3dc1d46c48273f10 = getarraykeys(level.powers);
  var_eafc0f62d074ffd7 = getarraykeys(self.powers);
  array = [];
  index = 0;

  foreach(key in var_eafc0f62d074ffd7) {
    foreach(entry in var_3dc1d46c48273f10) {
      if(key == entry) {
        array[index] = key;
        index += 1;
        break;
      }
    }
  }

  return array;
}

function power_disablepower(slot) {
  val::set("power", "offhand_weapons", 0);
}

function power_enablepower(slot) {
  val::reset_all("power");
}

function definepowerovertimeduration(id) {
  if(!isDefined(self.powerdurations)) {
    self.powerdurations = [];
  }

  if(!isDefined(self.powerdurations[id])) {
    self.powerdurations[id] = 0;
  }
}

function getpowerovertimeduration(id) {
  definepowerovertimeduration(id);
  return self.powerdurations[id];
}

function setpowerovertimeduration(id, duration) {
  definepowerovertimeduration(id);
  self.powerdurations[id] = duration;
}

function watchearlyout(cooldowntime, power, var_80905137dd741a79) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  self endon(var_80905137dd741a79);
  level endon("game_ended");
  self waittill("offhand_fired", objweapon);
  var_bdfac2ddbd96a676 = self.powers[power];
  weaponname = getcompleteweaponname(objweapon);

  if(weaponname == var_bdfac2ddbd96a676.weaponuse) {
    if(!isalive(self)) {
      if(var_bdfac2ddbd96a676.charges > 0) {
        power_adjustcharges(-1, var_bdfac2ddbd96a676.slot);
      }

      if(!var_bdfac2ddbd96a676.incooldown) {
        var_bdfac2ddbd96a676.cooldownleft = level.powers[power].cooldowntime;
        thread power_docooldown(power, cooldowntime);
      }
    }
  }
}

function ispowersbuttonPressed(command) {
  if(command == "+frag" && self fragButtonPressed() || command == "+smoke" && self secondaryoffhandbuttonPressed()) {
    return 1;
  }

  return 0;
}

function power_watchhudcharges(power) {
  self endon("power_available_ended_" + power);
  var_bdfac2ddbd96a676 = self.powers[power];
  slot = var_bdfac2ddbd96a676.slot;

  while(true) {
    self waittill("power_charges_adjusted_" + power, charges);
    powershud_updatepowerchargescp(power, slot, charges);
  }
}

function powershud_updatepowerchargescp(power, slot, charges) {
  self setclientomnvar(powershud_getslotomnvar(slot, 0), int(charges));
}

function power_watchhuddrainmeter(power) {
  self endon("disconnect");
  self endon("power_removed_" + power);
  self endon("power_drain_ended_" + power);
  var_bdfac2ddbd96a676 = self.powers[power];
  var_e0c214de92f727a2 = level.powers[power];
  slot = var_bdfac2ddbd96a676.slot;
  updatenotify = var_e0c214de92f727a2.updatenotify;

  if(!isDefined(updatenotify)) {
    updatenotify = power + "_update";
  }

  while(true) {
    self waittill(updatenotify, var_88a6638c4d7144a2);
    var_88a6638c4d7144a2 = max(0, min(1, var_88a6638c4d7144a2));
    powershud_updatepowerdrainprogress(slot, var_88a6638c4d7144a2);
  }
}

function power_watchhudcooldownmeter(power) {
  self endon("disconnect");
  self endon("power_removed_" + power);
  self endon("power_cooldown_ended" + power);
  var_bdfac2ddbd96a676 = self.powers[power];
  var_e0c214de92f727a2 = level.powers[power];
  slot = var_bdfac2ddbd96a676.slot;
  updatenotify = power + "_cooldown_update";

  while(true) {
    self waittill(updatenotify, var_88a6638c4d7144a2);
    powershud_updatepowercooldown(slot, var_88a6638c4d7144a2);
  }
}

function power_disableactivation(power) {
  var_bdfac2ddbd96a676 = self.powers[power];

  if(!isDefined(var_bdfac2ddbd96a676.disableactivation)) {
    var_bdfac2ddbd96a676.disableactivation = 0;
  }

  var_bdfac2ddbd96a676.disableactivation++;

  if(var_bdfac2ddbd96a676.disableactivation == 1) {
    power_updateammo(power);
  }
}

function power_enableactivation(power) {
  var_bdfac2ddbd96a676 = self.powers[power];
  assert(isDefined(var_bdfac2ddbd96a676.disableactivation) && var_bdfac2ddbd96a676.disableactivation > 0);
  var_bdfac2ddbd96a676.disableactivation--;

  if(var_bdfac2ddbd96a676.disableactivation == 0) {
    power_updateammo(power);
  }
}

function power_updateammo(power) {
  var_bdfac2ddbd96a676 = self.powers[power];
  disabled = isDefined(var_bdfac2ddbd96a676.disableactivation) && var_bdfac2ddbd96a676.disableactivation;
  charges = var_bdfac2ddbd96a676.charges > 0;

  if(!disabled && charges) {
    self setweaponammoclip(var_bdfac2ddbd96a676.weaponuse, var_bdfac2ddbd96a676.charges + 1);
    return;
  }

  self setweaponammoclip(var_bdfac2ddbd96a676.weaponuse, 0);

  if(is_wave_gametype()) {
    thread power_wave_mode_reset_playerdata(var_bdfac2ddbd96a676.slot);
  }
}

function power_wave_mode_reset_playerdata(slot) {
  if(slot == "primary") {
    self setclientomnvar("reset_wave_loadout", 3);
    return;
  }

  if(slot == "secondary") {
    wait 0.5;
    self setclientomnvar("reset_wave_loadout", 4);
  }
}

function power_addammo(power, amount) {
  var_bdfac2ddbd96a676 = self.powers[power];
  disabled = isDefined(var_bdfac2ddbd96a676.disableactivation) && var_bdfac2ddbd96a676.disableactivation;
  charges = var_bdfac2ddbd96a676.charges;

  if(!disabled) {
    if(charges + 1 < var_bdfac2ddbd96a676.maxcharges) {
      self setweaponammoclip(var_bdfac2ddbd96a676.objweapon, charges + 1);
      self notify("power_charges_adjusted_" + power, charges + 1);
      var_bdfac2ddbd96a676.charges += 1;
    } else {
      self setweaponammoclip(var_bdfac2ddbd96a676.objweapon, var_bdfac2ddbd96a676.maxcharges);
      self notify("power_charges_adjusted_" + power, var_bdfac2ddbd96a676.maxcharges);
      var_bdfac2ddbd96a676.charges = var_bdfac2ddbd96a676.maxcharges;
    }

    return;
  }

  self setweaponammoclip(var_bdfac2ddbd96a676.weaponuse, 0);

  self iprintln("<dev string:x1c>");
}

function get_info_for_player_powers(player) {
  info_for_player_powers = [];

  foreach(power in getarraykeys(player.powers)) {
    var_f982332caa507d3b = spawnStruct();
    var_f982332caa507d3b.slot = player.powers[power].slot;
    var_f982332caa507d3b.charges = player.powers[power].charges;
    var_f982332caa507d3b.cooldown = player.powers[power].cooldown;
    var_f982332caa507d3b.permanent = player.powers[power].permanent;
    var_f982332caa507d3b.maxcharges = player.powers[power].maxcharges;
    info_for_player_powers[power] = var_f982332caa507d3b;
  }

  return info_for_player_powers;
}

function restore_powers(player, info_for_player_powers) {
  foreach(power, var_f982332caa507d3b in info_for_player_powers) {
    cooldown = undefined;
    permanent = 0;

    if(istrue(var_f982332caa507d3b.cooldown)) {
      cooldown = 1;
    }

    if(istrue(var_f982332caa507d3b.permanent)) {
      permanent = 1;
    }

    if(var_f982332caa507d3b.slot == "secondary") {
      if(power == "power_bait") {
        player givepower(power, var_f982332caa507d3b.slot, undefined, undefined, undefined, 1, 1, var_f982332caa507d3b.maxcharges);
      } else {
        player givepower(power, var_f982332caa507d3b.slot, undefined, undefined, undefined, cooldown, permanent, var_f982332caa507d3b.maxcharges);
      }

      player power_adjustcharges(var_f982332caa507d3b.charges, var_f982332caa507d3b.slot, 1);
      continue;
    }

    player givepower(power, var_f982332caa507d3b.slot, undefined, undefined, undefined, undefined, 1, var_f982332caa507d3b.maxcharges);
    player power_adjustcharges(var_f982332caa507d3b.charges, var_f982332caa507d3b.slot, 1);
  }
}

function givecover(power) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired(undefined, undefined, undefined, 0);
}

function takecover(power) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_take(undefined, undefined, 1);
}

function is_power(power) {
  return isDefined(level.powers[power]);
}