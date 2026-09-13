/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_powers.gsc
***********************************************/

init() {
  level.powers = [];
  level.powersetfuncs = [];
  level.powerunsetfuncs = [];
  level.powerweaponmap = [];
  level.disablepowerfunc = ::power_disablepower;
  level.enablepowerfunc = ::power_enablepower;
  level.power_adjustcharges = ::power_adjustcharges;
  level.power_clearpower = ::zm_powershud_clearpower;
  level.power_haspower = ::haspower;
  level.clearpowers = ::clearpowers;
  level.power_modifycooldownrate = ::power_modifycooldownrate;
  scripts\cp\equipment\cp_trophy_system::trophy_init();
  level._effect["grenade_explode"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_frag_gren.vfx");
  level._effect["grenade_explode_overcook"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_frag_gren_airb.vfx");
  thread scripts\cp_mp\powershud::powershud_init();
  powerparsetable();

  if(isDefined(level.power_setup_init))
    level[[level.power_setup_init]]();
  else {
    powersetupfunctions("power_c4", undefined, undefined, undefined, "c4_update", undefined, undefined);
    powersetupfunctions("power_flash", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_molotov", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_smokeGrenade", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_claymore", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("power_cover", undefined, ::takecover, ::givecover, undefined, undefined, undefined);
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
  scripts\engine\utility::flag_init("powers_init_done");
  scripts\engine\utility::flag_set("powers_init_done");
}

setupovercookfuncs() {
  level.overcook_func["frag_grenade_mp"] = ::fraggrenadeovercookfunc;
}

fraggrenadeovercookfunc(victim, sweapon) {
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
    if(player scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(distancesquared(position, player.origin) > 360000) {
      continue;
    }
    if(player damageconetrace(position))
      player thread _id_74502A9E0EF1F19C::dirteffect(position);

    player setclientomnvar("ui_hud_shake", 1);
  }

  victim thread reset_grenades();
  victim thread delete_last_second_grenade_throws(power);
}

reset_grenades() {
  self endon("death");
  self disableoffhandweapons();

  while(self fragButtonPressed())
    wait 0.1;

  wait 0.1;
  self enableoffhandweapons();
}

delete_last_second_grenade_throws(power) {
  self endon("death");
  self endon("end_last_second_throw_func");
  self notify("starting_delay_last_second_grenade_throws");
  thread end_function_after_time(0.25);
  self waittill("grenade_fire", _id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_434849FD34BB4BA0, _id_434850FD34BB5B05);

  if(isDefined(_id_43484BFD34BB5006) && _id_43484BFD34BB5006.classname == "grenade") {
    _id_43484BFD34BB5006 delete();
    power_adjustcharges(self.powers[power].charges + 1, self.powers[power].slot, 1);
  }
}

end_function_after_time(timer) {
  self endon("death");
  wait(timer);
  self notify("end_last_second_throw_func");
}

power_createdefaultstruct(power, usetype, weaponuse, id, cooldowntime, maxcharges, deathreset, usecooldown, uitype, defaultslot) {
  struct = spawnStruct();
  struct.usetype = usetype;
  struct.weaponuse = weaponuse;
  struct.cooldowntime = cooldowntime;
  struct.id = id;

  if(isDefined(weaponuse))
    struct.maxcharges = weaponstartammo(weaponuse);
  else
    struct.maxcharges = maxcharges;

  struct.deathreset = deathreset;
  struct.usecooldown = usecooldown;
  struct.uitype = uitype;
  struct.defaultslot = defaultslot;
  level.powers[power] = struct;
}

powerparsetable() {
  _id_CB89110314447B2F = 1;

  if(isDefined(level.power_table))
    table = level.power_table;
  else
    table = "cp/cp_powerTable.csv";

  for(;;) {
    id = tablelookupbyrow(table, _id_CB89110314447B2F, 0);

    if(id == "") {
      break;
    }

    refname = tablelookupbyrow(table, _id_CB89110314447B2F, 1);
    usetype = tablelookupbyrow(table, _id_CB89110314447B2F, 6);
    useweapon = tablelookupbyrow(table, _id_CB89110314447B2F, 7);
    cooldown = tablelookupbyrow(table, _id_CB89110314447B2F, 8);
    maxcharges = tablelookupbyrow(table, _id_CB89110314447B2F, 9);
    deathreset = tablelookupbyrow(table, _id_CB89110314447B2F, 10);
    usecooldown = tablelookupbyrow(table, _id_CB89110314447B2F, 11);
    uitype = tablelookupbyrow(table, _id_CB89110314447B2F, 16);
    defaultslot = tablelookupbyrow(table, _id_CB89110314447B2F, 13);
    power_createdefaultstruct(refname, usetype, useweapon, int(id), float(cooldown), int(maxcharges), int(deathreset), int(usecooldown), uitype, defaultslot);

    if(isDefined(level.powerweaponmap[useweapon]) && useweapon != "<power_script_generic_weapon>") {
      switch (useweapon) {
        case "power_rewind":
          if(refname == "power_rewinder") {
            break;
          }
        default:
          break;
      }
    }

    level.powerweaponmap[useweapon] = refname;
    _id_CB89110314447B2F++;
  }
}

powersetupfunctions(power, setfunc, unsetfunc, usefunc, updatenotify, usednotify, interruptnotify) {
  struct = level.powers[power];

  if(!isDefined(struct))
    scripts\engine\utility::error("No configuration data for " + power + " found! Is it in powertable.csv? Or make sure powerSetupFunctions is called after the table is initialized.");

  level.powersetfuncs[power] = setfunc;
  level.powerunsetfuncs[power] = unsetfunc;

  if(isDefined(usefunc))
    struct.usefunc = usefunc;

  if(isDefined(updatenotify))
    struct.updatenotify = updatenotify;

  if(isDefined(usednotify))
    struct.usednotify = usednotify;

  if(isDefined(interruptnotify))
    struct.interruptnotify = interruptnotify;
}

power_sethudstate(slot, _id_9B1941CB7354665E) {
  power = getpower(slot);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  _id_E0C214DE92F727A2 = level.powers[power];
  state = _id_BDFAC2DDBD96A676.hudstate;
  charges = _id_BDFAC2DDBD96A676.charges;

  if(isDefined(state) && state == _id_9B1941CB7354665E) {
    return;
  }
  if(isDefined(state))
    power_unsethudstate(slot);

  switch (_id_9B1941CB7354665E) {
    case 0:
      scripts\cp_mp\powershud::powershud_beginpowerdrain(slot);
      scripts\cp_mp\powershud::powershud_updatepowermeter(slot, 1);
      powershud_updatepowerchargescp(power, slot, charges);
      thread power_watchhuddrainmeter(power);
      break;
    case 1:
      scripts\cp_mp\powershud::powershud_beginpowercooldown(slot, 0);
      powershud_updatepowerchargescp(power, slot, charges);
      thread power_watchhudcooldownmeter(power);
      break;
    case 2:
      scripts\cp_mp\powershud::powershud_updatepowerdisabled(slot, 0);
      scripts\cp_mp\powershud::powershud_updatepowermeter(slot, 1);
      powershud_updatepowerchargescp(power, slot, charges);
      thread power_watchhudcharges(power);
      break;
    case 3:
      break;
  }

  _id_BDFAC2DDBD96A676.hudstate = _id_9B1941CB7354665E;
  thread power_unsethudstateonremoved(slot);
}

power_unsethudstate(slot) {
  power = getpower(slot);

  if(!isDefined(power)) {
    return;
  }
  _id_BDFAC2DDBD96A676 = self.powers[power];
  hudstate = _id_BDFAC2DDBD96A676.hudstate;

  if(!isDefined(hudstate)) {
    return;
  }
  switch (hudstate) {
    case "unavailable":
      break;
    case 0:
      scripts\cp_mp\powershud::powershud_endpowerdrain(slot);
      break;
    case 2:
      break;
    case 1:
      scripts\cp_mp\powershud::powershud_finishpowercooldown(slot, 0);
      break;
  }

  _id_BDFAC2DDBD96A676.hudstate = undefined;
}

power_unsethudstateonremoved(slot) {
  self endon("disconnect");
  self notify("power_unsetHudStateOnRemoved_" + slot);
  self endon("power_unsetHudStateOnRemoved_" + slot);
  power = getpower(slot);
  self waittill("power_removed_" + power);
  power_unsethudstate(slot);
}

givepower(power, slot, _id_1240C819518D164C, passives, _id_A4358251FC4337B9, cooldown, permanent, _id_C3D005DCDD2A50A2) {
  _id_546DA77ECD6EA55F = 2;

  if(!isDefined(self.powers))
    self.powers = [];

  if(power == "none") {
    return;
  }
  if(slot == "scripted")
    _id_546DA77ECD6EA55F++;

  for(_id_F24845EEAEEDC946 = self getheldoffhand(); !isnullweapon(_id_F24845EEAEEDC946); _id_F24845EEAEEDC946 = self getheldoffhand())
    waitframe();

  _id_6110F0B30C5A30C4 = getarraykeys(self.powers);

  foreach(item in _id_6110F0B30C5A30C4) {
    if(self.powers[item].slot == slot) {
      self.itemreplaced = item;
      removepower(item);
      break;
    }
  }

  if(isDefined(level.extra_charge_func))
    _id_A4358251FC4337B9 = [[level.extra_charge_func]](power);

  power_createplayerstruct(power, slot, _id_A4358251FC4337B9, cooldown, permanent, _id_C3D005DCDD2A50A2);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  _id_E0C214DE92F727A2 = level.powers[power];
  self notify("delete_equipment " + slot);
  _id_C19C52338A112EDA = 0.0;

  if(isDefined(self.powercooldowns) && isDefined(self.powercooldowns[power])) {
    _id_7DFB465FCA9E822D = self.powercooldowns[power];
    _id_04408B269F137DF4 = power_cooldownremaining(_id_7DFB465FCA9E822D);

    if(_id_04408B269F137DF4 > 0.0) {
      _id_F5DA80D787F5C5B2 = _id_BDFAC2DDBD96A676.charges * _id_E0C214DE92F727A2.cooldowntime;
      _id_BDFAC2DDBD96A676.charges = int((_id_F5DA80D787F5C5B2 - _id_04408B269F137DF4) / _id_E0C214DE92F727A2.cooldowntime);

      if(_id_BDFAC2DDBD96A676.charges < 0)
        _id_BDFAC2DDBD96A676.charges = 0;

      for(_id_C19C52338A112EDA = _id_04408B269F137DF4; _id_C19C52338A112EDA > _id_E0C214DE92F727A2.cooldowntime; _id_C19C52338A112EDA = _id_C19C52338A112EDA - _id_E0C214DE92F727A2.cooldowntime) {}
    }
  }

  if(slot == "scripted") {
    return;
  }
  _id_BDFAC2DDBD96A676.weaponuse = undefined;

  if(_id_E0C214DE92F727A2.weaponuse == "<power_script_generic_weapon>")
    _id_BDFAC2DDBD96A676.weaponuse = scripts\engine\utility::ter_op(slot == "primary", "power_script_generic_primary_mp", "power_script_generic_secondary_mp");
  else
    _id_BDFAC2DDBD96A676.weaponuse = _id_E0C214DE92F727A2.weaponuse;

  weaponuse = _id_BDFAC2DDBD96A676.weaponuse;
  _id_BDFAC2DDBD96A676.weaponuse = weaponuse;
  _id_BDFAC2DDBD96A676.objweapon = makeweapon(weaponuse);
  self giveweapon(_id_BDFAC2DDBD96A676.objweapon);
  self setweaponammoclip(_id_BDFAC2DDBD96A676.objweapon, _id_BDFAC2DDBD96A676.charges);

  if(_id_BDFAC2DDBD96A676.slot == "primary") {
    self assignweaponoffhandprimary(_id_BDFAC2DDBD96A676.objweapon);
    self.powerprimarygrenade = weaponuse;
    self setclientomnvar("ui_power_max_charges", _id_BDFAC2DDBD96A676.charges);
  } else if(_id_BDFAC2DDBD96A676.slot == "secondary") {
    self assignweaponoffhandsecondary(_id_BDFAC2DDBD96A676.objweapon);
    self.powersecondarygrenade = weaponuse;
    self setclientomnvar("ui_power_secondary_max_charges", _id_BDFAC2DDBD96A676.charges);
  }

  if(isDefined(level.powersetfuncs[power]))
    self[[level.powersetfuncs[power]]](power);

  if(isDefined(permanent) && !permanent)
    thread remove_when_charges_exhausted(power);

  if(!isai(self)) {
    thread power_modifychargesonscavenge(power);
    thread power_modifychargesonpickuporfailure(power);
    thread managepowerbuttonuse(_id_E0C214DE92F727A2, power, _id_BDFAC2DDBD96A676.slot, _id_E0C214DE92F727A2.cooldowntime, _id_E0C214DE92F727A2.updatenotify, _id_E0C214DE92F727A2.usednotify, weaponuse, _id_C19C52338A112EDA, _id_1240C819518D164C);
  }
}

removepower(power) {
  if(isDefined(level.powerunsetfuncs[power]))
    self[[level.powerunsetfuncs[power]]]();

  if(isDefined(self.powers[power].weaponuse))
    self takeweapon(self.powers[power].weaponuse);

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

zm_powershud_clearpower(slot) {
  if(slot == "scripted") {
    return;
  }
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(slot, 2), 0);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(slot, 1), 0);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(slot, 0), -1);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(slot, 3), 0);
}

cleanpowercooldowns() {
  if(isDefined(self.powercooldowns) && self.powercooldowns.size > 0) {
    _id_77BFAB09ECD1341D = self.powercooldowns;

    foreach(_id_B19BD2030265157A, struct in _id_77BFAB09ECD1341D) {
      if(power_cooldownremaining(struct) == 0.0)
        self.powercooldowns[_id_B19BD2030265157A] = undefined;
    }
  }
}

power_cooldownremaining(struct) {
  _id_E0C214DE92F727A2 = level.powers[struct.power];
  _id_231069448521A740 = (struct.maxcharges - struct.charges) * _id_E0C214DE92F727A2.cooldowntime - (_id_E0C214DE92F727A2.cooldowntime - struct.cooldownleft);
  _id_3B5803E733581858 = (gettime() - struct.timestamp) / 1000;
  return max(0, _id_231069448521A740 - _id_3B5803E733581858);
}

clearpowers() {
  self notify("powers_cleanUp");

  if(isDefined(self.powers)) {
    powers = self.powers;

    foreach(_id_B19BD2030265157A, struct in powers)
    removepower(_id_B19BD2030265157A);

    self.powers = [];
  }
}

getpower(slot) {
  if(!isDefined(self.powers))
    return undefined;

  foreach(_id_DC34121B4BB07FB9, power in self.powers) {
    if(power.slot == slot)
      return _id_DC34121B4BB07FB9;
  }

  return undefined;
}

clear_power_slot(slot) {
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

what_power_is_in_slot(slot) {
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

power_getinputcommand(power) {
  return scripts\engine\utility::ter_op(self.powers[power].slot == "primary", "+frag", "+smoke");
}

power_createplayerstruct(power, slot, _id_A4358251FC4337B9, cooldown, permanent, _id_C3D005DCDD2A50A2) {
  _id_E0C214DE92F727A2 = level.powers[power];
  _id_653F9BA7F27182AB = spawnStruct();
  _id_653F9BA7F27182AB.slot = slot;
  _id_653F9BA7F27182AB.charges = _id_E0C214DE92F727A2.maxcharges;

  if(istrue(_id_A4358251FC4337B9))
    _id_653F9BA7F27182AB.charges++;

  _id_653F9BA7F27182AB.maxcharges = get_max_charges(power, slot);

  if(isDefined(_id_C3D005DCDD2A50A2)) {
    _id_653F9BA7F27182AB.maxcharges = _id_C3D005DCDD2A50A2;
    _id_653F9BA7F27182AB.charges = _id_653F9BA7F27182AB.maxcharges;
  }

  _id_653F9BA7F27182AB.incooldown = 0;
  _id_653F9BA7F27182AB.active = 0;
  _id_653F9BA7F27182AB.cooldownleft = 0;
  _id_653F9BA7F27182AB.cooldownratemod = 1.0;
  _id_653F9BA7F27182AB.cooldown = cooldown;
  _id_653F9BA7F27182AB.permanent = permanent;
  _id_653F9BA7F27182AB.passives = [];
  self.powers[power] = _id_653F9BA7F27182AB;
  self.equipment[slot] = power;
}

get_max_charges(power, slot) {
  if(scripts\cp\utility::is_specops_gametype())
    return level.powers[power].maxcharges;

  return scripts\cp\cp_loadout::get_num_of_charges_for_power(self, slot);
}

managepowerbuttonuse(_id_E0C214DE92F727A2, power, slot, cooldowntime, updatenotify, usednotify, weaponuse, _id_C19C52338A112EDA, _id_1240C819518D164C) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  level endon("game_ended");

  if(isDefined(_id_1240C819518D164C) && _id_1240C819518D164C || power == "power_copycatGrenade")
    self endon("start_copycat");

  self endon("clear_power_slot" + power);
  scripts\cp_mp\powershud::powershud_assignpower(slot, int(_id_E0C214DE92F727A2.id), 1, int(self.powers[power].charges));
  scripts\cp\utility::gameflagwait("prematch_done");
  power_sethudstate(slot, 2);

  for(;;) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(self))
      scripts\engine\utility::waittill_any_3("revive", "revive_success", "challenge_complete_revive");

    power_updateammo(power);
    _id_80905137DD741A79 = weaponuse + "_success";
    thread watchearlyout(cooldowntime, power, _id_80905137DD741A79);
    _id_B1AA23F01EC70C87 = scripts\engine\utility::ter_op(_id_E0C214DE92F727A2.usetype == "weapon_hold", "offhand_pullback", "offhand_fired");
    self waittill(_id_B1AA23F01EC70C87, objweapon);

    if(objweapon.basename != weaponuse) {
      continue;
    }
    cooldowntime = getpowercooldowntime(_id_E0C214DE92F727A2);
    self notify(_id_80905137DD741A79);

    if(self.powers[power].charges != 0 && !self.powers[power].active) {
      success = undefined;

      if(isDefined(_id_E0C214DE92F727A2.usefunc)) {
        success = self thread[[_id_E0C214DE92F727A2.usefunc]](objweapon);

        if(isDefined(success) && success == 0)
          continue;
      }

      if(isDefined(usednotify)) {
        self waittill(usednotify, success);

        if(isDefined(success) && success == 0)
          continue;
      }

      if(!isDefined(self.dont_use_charges) || self.dont_use_charges != power) {}
    }

    power_adjustcharges(-1, self.powers[power].slot);
    self notify("power_used " + power);

    if(isDefined(updatenotify) && level.powers[power].uitype == "drain" && !istrue(self.powers[power].indrain))
      power_dodrain(power);

    thread power_docooldown(power, cooldowntime, _id_1240C819518D164C);
  }
}

ispickedupgrenadetype(power) {
  switch (power) {
    case "power_clusterGrenade":
    case "power_sentry":
    case "power_ammoCrate":
    case "power_smokeGrenade":
    case "power_molotov":
    case "power_frag":
      return 1;
    default:
      return 0;
  }
}

getpowercooldowntime(_id_E0C214DE92F727A2) {
  if(istrue(level.powershortcooldown))
    return 0.1;
  else if(istrue(level.infinite_grenades))
    return 2.5;
  else if(scripts\cp\utility::is_consumable_active("grenade_cooldown"))
    return _id_E0C214DE92F727A2.cooldowntime;
  else
    return _id_E0C214DE92F727A2.cooldowntime;
}

power_modifychargesonscavenge(power) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  weaponuse = _id_BDFAC2DDBD96A676.weaponuse;
  slot = _id_BDFAC2DDBD96A676.slot;

  for(;;) {
    self waittill("scavenged_ammo", weaponname);

    if(weaponname == weaponuse)
      power_adjustcharges(_id_BDFAC2DDBD96A676.maxcharges, slot);

    state = _id_BDFAC2DDBD96A676.hudstate;

    if(state == 1)
      power_sethudstate(slot, 2);
  }
}

power_modifychargesonpickuporfailure(power) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  weaponuse = _id_BDFAC2DDBD96A676.weaponuse;
  slot = _id_BDFAC2DDBD96A676.slot;

  for(;;) {
    self waittill("pickup_equipment", weaponname);

    if(weaponname == weaponuse)
      power_adjustcharges(1, slot);

    state = _id_BDFAC2DDBD96A676.hudstate;

    if(state == 1)
      power_sethudstate(slot, 2);
  }
}

remove_when_charges_exhausted(power) {
  self endon("disconnect");
  self endon("power_removed_" + power);
  level endon("game_ended");
  _id_BDFAC2DDBD96A676 = self.powers[power];

  while(isDefined(self.powers[power])) {
    self waittill("power_used " + power);

    if(istrue(level.powershortcooldown)) {
      continue;
    }
    if(_id_BDFAC2DDBD96A676.charges < 1) {
      while(self isswitchingweapon() || scripts\engine\utility::array_contains(self.powers_active, power))
        wait 0.25;

      wait 0.25;
      thread removepower(power);
    }
  }
}

power_shouldcooldown(power) {
  if(!isDefined(self.powers[power]))
    return 0;

  if(istrue(self.powers[power].cooldown))
    return 1;

  if(istrue(level.powershortcooldown))
    return 1;

  if(level.powers[power].usecooldown)
    return 1;

  if(isDefined(self.powers[power].slot) && self.powers[power].slot != "primary")
    return 0;

  if(scripts\cp\utility::is_consumable_active("grenade_cooldown") && level.powers[power].defaultslot != "secondary")
    return 1;

  if(istrue(level.infinite_grenades))
    return 1;

  return 0;
}

activatepower(power) {
  self.powers_active[self.powers_active.size] = power;
}

deactivatepower(power) {
  if(scripts\engine\utility::array_contains(self.powers_active, power))
    self.powers_active = scripts\engine\utility::array_remove(self.powers_active, power);
}

power_docooldown(power, cooldowntime, _id_1240C819518D164C) {
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  self endon("power_cooldown_ended" + power);

  if(isDefined(_id_1240C819518D164C) && _id_1240C819518D164C || power == "power_copycatGrenade")
    self endon("start_copycat");

  self endon("clear_power_slot" + power);
  self notify("power_cooldown_begin_" + power);
  self endon("power_cooldown_begin_" + power);
  level endon("game_ended");
  _id_E0C214DE92F727A2 = level.powers[power];
  _id_BDFAC2DDBD96A676 = self.powers[power];
  slot = _id_BDFAC2DDBD96A676.slot;
  updatenotify = power + "_cooldown_update";
  _id_BDFAC2DDBD96A676.incooldown = 1;

  if(!isDefined(_id_BDFAC2DDBD96A676.cooldownsqueued))
    _id_BDFAC2DDBD96A676.cooldownsqueued = 0;

  _id_BDFAC2DDBD96A676.cooldownsqueued++;

  if(!isDefined(_id_BDFAC2DDBD96A676.cooldowncounter))
    _id_BDFAC2DDBD96A676.cooldowncounter = 0;

  if(!isDefined(_id_BDFAC2DDBD96A676.cooldownleft))
    _id_BDFAC2DDBD96A676.cooldownleft = 0;

  _id_BDFAC2DDBD96A676.cooldownleft = _id_BDFAC2DDBD96A676.cooldownleft + cooldowntime;
  state = _id_BDFAC2DDBD96A676.hudstate;

  if(isDefined(state) && state != 0 && _id_BDFAC2DDBD96A676.charges == 0)
    power_sethudstate(slot, 1);

  while(_id_BDFAC2DDBD96A676.charges < _id_BDFAC2DDBD96A676.maxcharges) {
    if(power_shouldcooldown(power))
      wait 0.1;
    else {
      level scripts\engine\utility::waittill_any_3("grenade_cooldown activated", "infinite_grenade_active", "start_power_cooldown");
      cooldowntime = getpowercooldowntime(_id_E0C214DE92F727A2);
    }

    if(_id_BDFAC2DDBD96A676.cooldowncounter > cooldowntime) {
      power_adjustcharges(1, slot);
      power_updateammo(power);

      if(_id_BDFAC2DDBD96A676.charges == _id_BDFAC2DDBD96A676.maxcharges)
        thread power_endcooldown(power, _id_1240C819518D164C);

      _id_BDFAC2DDBD96A676.cooldowncounter = _id_BDFAC2DDBD96A676.cooldowncounter - cooldowntime;
      _id_BDFAC2DDBD96A676.cooldownleft = _id_BDFAC2DDBD96A676.cooldownleft - cooldowntime;
      _id_BDFAC2DDBD96A676.cooldownsqueued--;

      if(isDefined(state) && state != 0)
        power_sethudstate(slot, 2);
    } else {
      _id_BDFAC2DDBD96A676.cooldowncounter = _id_BDFAC2DDBD96A676.cooldowncounter + 0.1;
      _id_BDFAC2DDBD96A676.cooldownleft = _id_BDFAC2DDBD96A676.cooldownleft - 0.1;
    }

    _id_88A6638C4D7144A2 = min(1, _id_BDFAC2DDBD96A676.cooldowncounter / cooldowntime);
    self notify(updatenotify, _id_88A6638C4D7144A2);
  }

  thread power_endcooldown(power, _id_1240C819518D164C);
}

power_endcooldown(power, _id_1240C819518D164C) {
  self notify("power_cooldown_ended" + power);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  _id_BDFAC2DDBD96A676.incooldown = 0;
  _id_BDFAC2DDBD96A676.cooldowncounter = 0;
  _id_BDFAC2DDBD96A676.cooldownleft = 0;
  _id_BDFAC2DDBD96A676.cooldownsqueued = 0;

  if(isDefined(_id_1240C819518D164C) && _id_1240C819518D164C)
    self notify("copycat_reset");

  hudstate = _id_BDFAC2DDBD96A676.hudstate;
  slot = _id_BDFAC2DDBD96A676.slot;

  if(hudstate == 0) {
    return;
  }
  power_sethudstate(slot, 2);
}

power_dodrain(power) {
  self endon("death");
  self endon("power_drain_ended_" + power);
  self notify("power_cooldown_ended_" + power);
  _id_E0C214DE92F727A2 = level.powers[power];
  _id_BDFAC2DDBD96A676 = self.powers[power];
  updatenotify = _id_E0C214DE92F727A2.updatenotify;
  interruptnotify = _id_E0C214DE92F727A2.interruptnotify;
  slot = _id_BDFAC2DDBD96A676.slot;
  _id_BDFAC2DDBD96A676.indrain = 1;
  power_disableactivation(power);
  power_sethudstate(slot, 0);

  if(isDefined(interruptnotify))
    thread power_enddrainoninterrupt(power, slot, interruptnotify);

  for(;;) {
    self waittill(updatenotify, value);

    if(value == 0) {
      break;
    }
  }

  thread power_enddrain(power);
}

power_enddrainoninterrupt(power, slot, interruptnotify) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  self endon("power_drain_ended_" + power);
  self waittill(interruptnotify);
  thread power_enddrain(power);
}

power_enddrain(power) {
  self notify("power_drain_ended_" + power);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  slot = _id_BDFAC2DDBD96A676.slot;
  _id_BDFAC2DDBD96A676.indrain = 0;
  power_enableactivation(power);

  if(_id_BDFAC2DDBD96A676.charges > 0)
    power_sethudstate(slot, 2);
  else
    power_sethudstate(slot, 1);
}

haspower(power) {
  if(!isDefined(self.powers[power]))
    return 0;

  return 1;
}

waitonpowerbutton(slot) {
  self endon("death");
  self endon("disconnect");

  if(slot == "primary")
    _id_2D19F7AAB0AE05A2 = "power_primary_used";
  else
    _id_2D19F7AAB0AE05A2 = "power_secondary_used";

  for(;;) {
    if(!isDefined(self)) {
      wait 1;
      break;
    }

    self waittill(_id_2D19F7AAB0AE05A2);
    break;
  }
}

power_modifycooldownrate(_id_971E656EDBDB9FE7, slot) {
  if(!isDefined(slot))
    slot = "all";

  array = power_getpowerkeys();

  foreach(key in array) {
    if(isDefined(self.powers[key].slot) && self.powers[key].slot == slot || slot == "all")
      self.powers[key].cooldownratemod = _id_971E656EDBDB9FE7;
  }
}

power_adjustcharges(_id_BB3A4ED149FCAF82, slot, _id_D6EAE0BF53DA1172) {
  if(!isDefined(slot))
    slot = "all";

  array = power_getpowerkeys();
  _id_78D608EFC5C796C6 = _id_BB3A4ED149FCAF82;

  foreach(key in array) {
    if(!isDefined(_id_BB3A4ED149FCAF82))
      _id_78D608EFC5C796C6 = self.powers[key].maxcharges;

    if(self.powers[key].slot == slot || slot == "all") {
      if(isDefined(_id_D6EAE0BF53DA1172))
        self.powers[key].charges = int(min(_id_78D608EFC5C796C6, self.powers[key].maxcharges));
      else if(self.powers[key].charges + _id_78D608EFC5C796C6 >= 0)
        self.powers[key].charges = self.powers[key].charges + _id_78D608EFC5C796C6;
      else
        self.powers[key].charges = 0;

      self.powers[key].charges = int(clamp(self.powers[key].charges, 0, self.powers[key].maxcharges));
      self setweaponammoclip(self.powers[key].weaponuse, self.powers[key].charges);
      powershud_updatepowerchargescp(key, self.powers[key].slot, self.powers[key].charges);
    }
  }
}

_id_AE3298B480D63ACD(slot, _id_FF342E44B3C617AD) {
  if(slot == "primary") {
    _id_F366AF1BB183316C = getpower(slot);

    if(!scripts\engine\utility::array_contains_key(level.powers, _id_F366AF1BB183316C))
      _id_F366AF1BB183316C = "power_frag";

    thread givepower(_id_F366AF1BB183316C, "primary", undefined, undefined, undefined, undefined, 1, _id_FF342E44B3C617AD);
  } else if(slot == "secondary") {
    _id_5E7BDAD4B7D0C7AC = getpower(slot);

    if(!scripts\engine\utility::array_contains_key(level.powers, _id_5E7BDAD4B7D0C7AC))
      _id_5E7BDAD4B7D0C7AC = "power_flash";

    thread givepower(_id_5E7BDAD4B7D0C7AC, "secondary", undefined, undefined, undefined, undefined, 1, _id_FF342E44B3C617AD);
  }
}

power_checkifequipmentammofull(player) {
  array = player power_getpowerkeys();

  foreach(key in array) {
    if(player.powers[key].charges != player.powers[key].maxcharges)
      return 0;
  }

  return 1;
}

power_getpowerkeys() {
  _id_3DC1D46C48273F10 = getarraykeys(level.powers);
  _id_EAFC0F62D074FFD7 = getarraykeys(self.powers);
  array = [];
  index = 0;

  foreach(key in _id_EAFC0F62D074FFD7) {
    foreach(_id_F90358454413407F in _id_3DC1D46C48273F10) {
      if(key == _id_F90358454413407F) {
        array[index] = key;
        index = index + 1;
        break;
      }
    }
  }

  return array;
}

power_disablepower(slot) {
  _id_3B64EB40368C1450::set("power", "offhand_weapons", 0);
}

power_enablepower(slot) {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("power");
}

definepowerovertimeduration(id) {
  if(!isDefined(self.powerdurations))
    self.powerdurations = [];

  if(!isDefined(self.powerdurations[id]))
    self.powerdurations[id] = 0.0;
}

getpowerovertimeduration(id) {
  definepowerovertimeduration(id);
  return self.powerdurations[id];
}

setpowerovertimeduration(id, duration) {
  definepowerovertimeduration(id);
  self.powerdurations[id] = duration;
}

watchearlyout(cooldowntime, power, _id_80905137DD741A79) {
  self endon("disconnect");
  self endon("powers_cleanUp");
  self endon("power_removed_" + power);
  self endon(_id_80905137DD741A79);
  level endon("game_ended");
  self waittill("offhand_fired", objweapon);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  weaponname = getcompleteweaponname(objweapon);

  if(weaponname == _id_BDFAC2DDBD96A676.weaponuse) {
    if(!isalive(self)) {
      if(_id_BDFAC2DDBD96A676.charges > 0)
        power_adjustcharges(-1, _id_BDFAC2DDBD96A676.slot);

      if(!_id_BDFAC2DDBD96A676.incooldown) {
        _id_BDFAC2DDBD96A676.cooldownleft = level.powers[power].cooldowntime;
        thread power_docooldown(power, cooldowntime);
      }
    }
  }
}

ispowersbuttonPressed(_id_10D8148F3496F8DE) {
  if(_id_10D8148F3496F8DE == "+frag" && self fragButtonPressed() || _id_10D8148F3496F8DE == "+smoke" && self secondaryoffhandbuttonPressed())
    return 1;
  else
    return 0;
}

power_watchhudcharges(power) {
  self endon("power_available_ended_" + power);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  slot = _id_BDFAC2DDBD96A676.slot;

  for(;;) {
    self waittill("power_charges_adjusted_" + power, charges);
    powershud_updatepowerchargescp(power, slot, charges);
  }
}

powershud_updatepowerchargescp(power, slot, charges) {
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(slot, 0), int(charges));
}

power_watchhuddrainmeter(power) {
  self endon("disconnect");
  self endon("power_removed_" + power);
  self endon("power_drain_ended_" + power);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  _id_E0C214DE92F727A2 = level.powers[power];
  slot = _id_BDFAC2DDBD96A676.slot;
  updatenotify = _id_E0C214DE92F727A2.updatenotify;

  if(!isDefined(updatenotify))
    updatenotify = power + "_update";

  for(;;) {
    self waittill(updatenotify, _id_88A6638C4D7144A2);
    _id_88A6638C4D7144A2 = max(0, min(1, _id_88A6638C4D7144A2));
    scripts\cp_mp\powershud::powershud_updatepowerdrainprogress(slot, _id_88A6638C4D7144A2);
  }
}

power_watchhudcooldownmeter(power) {
  self endon("disconnect");
  self endon("power_removed_" + power);
  self endon("power_cooldown_ended" + power);
  _id_BDFAC2DDBD96A676 = self.powers[power];
  _id_E0C214DE92F727A2 = level.powers[power];
  slot = _id_BDFAC2DDBD96A676.slot;
  updatenotify = power + "_cooldown_update";

  for(;;) {
    self waittill(updatenotify, _id_88A6638C4D7144A2);
    scripts\cp_mp\powershud::powershud_updatepowercooldown(slot, _id_88A6638C4D7144A2);
  }
}

power_disableactivation(power) {
  _id_BDFAC2DDBD96A676 = self.powers[power];

  if(!isDefined(_id_BDFAC2DDBD96A676.disableactivation))
    _id_BDFAC2DDBD96A676.disableactivation = 0;

  _id_BDFAC2DDBD96A676.disableactivation++;

  if(_id_BDFAC2DDBD96A676.disableactivation == 1)
    power_updateammo(power);
}

power_enableactivation(power) {
  _id_BDFAC2DDBD96A676 = self.powers[power];
  _id_BDFAC2DDBD96A676.disableactivation--;

  if(_id_BDFAC2DDBD96A676.disableactivation == 0)
    power_updateammo(power);
}

power_updateammo(power) {
  _id_BDFAC2DDBD96A676 = self.powers[power];
  disabled = isDefined(_id_BDFAC2DDBD96A676.disableactivation) && _id_BDFAC2DDBD96A676.disableactivation;
  charges = _id_BDFAC2DDBD96A676.charges > 0;

  if(!disabled && charges)
    self setweaponammoclip(_id_BDFAC2DDBD96A676.weaponuse, _id_BDFAC2DDBD96A676.charges + 1);
  else {
    self setweaponammoclip(_id_BDFAC2DDBD96A676.weaponuse, 0);

    if(scripts\cp\utility::is_wave_gametype())
      thread power_wave_mode_reset_playerdata(_id_BDFAC2DDBD96A676.slot);
  }
}

power_wave_mode_reset_playerdata(slot) {
  if(slot == "primary")
    self setclientomnvar("reset_wave_loadout", 3);
  else if(slot == "secondary") {
    wait 0.5;
    self setclientomnvar("reset_wave_loadout", 4);
  }
}

power_addammo(power, amount) {
  _id_BDFAC2DDBD96A676 = self.powers[power];
  disabled = isDefined(_id_BDFAC2DDBD96A676.disableactivation) && _id_BDFAC2DDBD96A676.disableactivation;
  charges = _id_BDFAC2DDBD96A676.charges;

  if(!disabled) {
    if(charges + 1 < _id_BDFAC2DDBD96A676.maxcharges) {
      self setweaponammoclip(_id_BDFAC2DDBD96A676.objweapon, charges + 1);
      self notify("power_charges_adjusted_" + power, charges + 1);
      _id_BDFAC2DDBD96A676.charges = _id_BDFAC2DDBD96A676.charges + 1;
    } else {
      self setweaponammoclip(_id_BDFAC2DDBD96A676.objweapon, _id_BDFAC2DDBD96A676.maxcharges);
      self notify("power_charges_adjusted_" + power, _id_BDFAC2DDBD96A676.maxcharges);
      _id_BDFAC2DDBD96A676.charges = _id_BDFAC2DDBD96A676.maxcharges;
    }
  } else
    self setweaponammoclip(_id_BDFAC2DDBD96A676.weaponuse, 0);
}

get_info_for_player_powers(player) {
  _id_A43771298EB6964A = [];

  foreach(power in getarraykeys(player.powers)) {
    _id_F982332CAA507D3B = spawnStruct();
    _id_F982332CAA507D3B.slot = player.powers[power].slot;
    _id_F982332CAA507D3B.charges = player.powers[power].charges;
    _id_F982332CAA507D3B.cooldown = player.powers[power].cooldown;
    _id_F982332CAA507D3B.permanent = player.powers[power].permanent;
    _id_F982332CAA507D3B.maxcharges = player.powers[power].maxcharges;
    _id_A43771298EB6964A[power] = _id_F982332CAA507D3B;
  }

  return _id_A43771298EB6964A;
}

restore_powers(player, _id_A43771298EB6964A) {
  foreach(power, _id_F982332CAA507D3B in _id_A43771298EB6964A) {
    cooldown = undefined;
    permanent = 0;

    if(istrue(_id_F982332CAA507D3B.cooldown))
      cooldown = 1;

    if(istrue(_id_F982332CAA507D3B.permanent))
      permanent = 1;

    if(_id_F982332CAA507D3B.slot == "secondary") {
      if(power == "power_bait")
        player givepower(power, _id_F982332CAA507D3B.slot, undefined, undefined, undefined, 1, 1, _id_F982332CAA507D3B.maxcharges);
      else
        player givepower(power, _id_F982332CAA507D3B.slot, undefined, undefined, undefined, cooldown, permanent, _id_F982332CAA507D3B.maxcharges);

      player power_adjustcharges(_id_F982332CAA507D3B.charges, _id_F982332CAA507D3B.slot, 1);
      continue;
    }

    player givepower(power, _id_F982332CAA507D3B.slot, undefined, undefined, undefined, undefined, 1, _id_F982332CAA507D3B.maxcharges);
    player power_adjustcharges(_id_F982332CAA507D3B.charges, _id_F982332CAA507D3B.slot, 1);
  }
}

givecover(power) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired(undefined, undefined, undefined, 0);
}

takecover(power) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_take(undefined, undefined, 1);
}

_id_D9EBB18FDF6BB7EB(power) {
  return isDefined(level.powers[power]);
}