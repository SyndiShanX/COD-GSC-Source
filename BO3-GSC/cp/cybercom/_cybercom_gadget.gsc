/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_bb;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_dev;
#using scripts\cp\cybercom\_cybercom_gadget_active_camo;
#using scripts\cp\cybercom\_cybercom_gadget_cacophany;
#using scripts\cp\cybercom\_cybercom_gadget_concussive_wave;
#using scripts\cp\cybercom\_cybercom_gadget_electrostatic_strike;
#using scripts\cp\cybercom\_cybercom_gadget_exosuitbreakdown;
#using scripts\cp\cybercom\_cybercom_gadget_firefly;
#using scripts\cp\cybercom\_cybercom_gadget_forced_malfunction;
#using scripts\cp\cybercom\_cybercom_gadget_iff_override;
#using scripts\cp\cybercom\_cybercom_gadget_immolation;
#using scripts\cp\cybercom\_cybercom_gadget_misdirection;
#using scripts\cp\cybercom\_cybercom_gadget_mrpukey;
#using scripts\cp\cybercom\_cybercom_gadget_overdrive;
#using scripts\cp\cybercom\_cybercom_gadget_rapid_strike;
#using scripts\cp\cybercom\_cybercom_gadget_ravage_core;
#using scripts\cp\cybercom\_cybercom_gadget_security_breach;
#using scripts\cp\cybercom\_cybercom_gadget_sensory_overload;
#using scripts\cp\cybercom\_cybercom_gadget_servo_shortout;
#using scripts\cp\cybercom\_cybercom_gadget_smokescreen;
#using scripts\cp\cybercom\_cybercom_gadget_surge;
#using scripts\cp\cybercom\_cybercom_gadget_system_overload;
#using scripts\cp\cybercom\_cybercom_gadget_unstoppable_force;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom_gadget;

function init() {
  cybercom_gadget_iff_override::init();
  cybercom_gadget_security_breach::init();
  cybercom_gadget_system_overload::init();
  cybercom_gadget_servo_shortout::init();
  cybercom_gadget_exosuitbreakdown::init();
  cybercom_gadget_surge::init();
  namespace_9cc756f9::init();
  namespace_f388b961::init();
  cybercom_gadget_unstoppable_force::init();
  cybercom_gadget_concussive_wave::init();
  cybercom_gadget_active_camo::init();
  namespace_6dcc04c7::init();
  namespace_328b6406::init();
  cybercom_gadget_immolation::init();
  cybercom_gadget_sensory_overload::init();
  cybercom_gadget_forced_malfunction::init();
  cybercom_gadget_firefly::init();
  cybercom_gadget_smokescreen::init();
  cybercom_gadget_misdirection::init();
  cybercom_gadget_electrostatic_strike::init();
  namespace_e44205a2::init();
}

function main() {
  callback::on_connect( & on_player_connect);
  callback::on_spawned( & on_player_spawned);
  cybercom_gadget_system_overload::main();
  cybercom_gadget_exosuitbreakdown::main();
  cybercom_gadget_surge::main();
  cybercom_gadget_iff_override::main();
  cybercom_gadget_security_breach::main();
  cybercom_gadget_servo_shortout::main();
  namespace_9cc756f9::main();
  namespace_f388b961::main();
  cybercom_gadget_smokescreen::main();
  cybercom_gadget_forced_malfunction::main();
  cybercom_gadget_active_camo::main();
  cybercom_gadget_concussive_wave::main();
  cybercom_gadget_unstoppable_force::main();
  namespace_328b6406::main();
  cybercom_gadget_sensory_overload::main();
  cybercom_gadget_misdirection::main();
  namespace_6dcc04c7::main();
  namespace_e44205a2::main();
  cybercom_gadget_firefly::main();
  cybercom_gadget_immolation::main();
  cybercom_gadget_electrostatic_strike::main();
}

function on_player_connect() {
  self thread function_48868896();
}

function on_player_spawned() {
  self thread function_12bffd86();
}

function function_12bffd86() {
  self notify("hash_12bffd86");
  self endon("hash_12bffd86");
  self endon("disconnect");
  while(true) {
    ret = self util::waittill_any_return("cybercom_activation_failed", "cybercom_activation_succeeded");
    if(!isDefined(ret)) {
      continue;
    }
    if(!isDefined(self.cybercom.activecybercomweapon)) {
      continue;
    }
    ability = function_1a6a2760(self.cybercom.activecybercomweapon);
    upgraded = self hascybercomability(ability.name) == 2;
    if(ret == "cybercom_activation_succeeded") {
      alias = "gdt_cybercore_activate" + (isDefined(upgraded) && (upgraded ? "_upgraded" : ""));
    } else {
      alias = "gdt_cybercore_activate_fail";
    }
    if(!(isDefined(ability.passive) && ability.passive)) {
      self playSound(alias);
    }
  }
}

function registerability(type, flag, passive = 0) {
  if(!isDefined(level.cybercom)) {
    cybercom::initialize();
  }
  if(getabilitybyflag(type, flag) == undefined) {
    ability = spawnStruct();
    ability.type = type;
    ability.flag = flag;
    ability.passive = passive;
    ability.name = getcybercomabilityname(type, flag);
    ability.weapon = getcybercomweapon(type, flag, 0);
    ability.weaponupgraded = getcybercomweapon(type, flag, 1);
    level.cybercom.abilities[level.cybercom.abilities.size] = ability;
  }
}

function ismeleeability(ability) {
  if(isDefined(ability)) {
    if(ability.type == 1 && ability.flag == 64) {
      return true;
    }
    if(ability.type == 2 && ability.flag == 2) {
      return true;
    }
    if(ability.type == 0 && ability.flag == 16) {
      return true;
    }
  }
  return false;
}

function meleeabilitygiven(ability, upgrade) {
  if(!isDefined(ability)) {
    return;
  }
  if(!ismeleeability(ability)) {
    return;
  }
  if(!isDefined(upgrade)) {
    status = self hascybercomability(ability.name);
    if(status == 0) {
      return;
    }
    upgrade = status == 2;
  }
  if(upgrade) {
    weapon = ability.weaponupgraded;
  } else {
    weapon = ability.weapon;
  }
  if(isDefined(self.cybercom.activecybercommeleeweapon) && self.cybercom.activecybercommeleeweapon != weapon) {
    self takeweapon(self.cybercom.activecybercommeleeweapon);
    self notify("weapon_taken", self.cybercom.activecybercommeleeweapon);
    level notify("weapon_taken", self.cybercom.activecybercommeleeweapon, self);
    self.cybercom.activecybercommeleeweapon = undefined;
  }
  if(!self hasweapon(weapon)) {
    self giveweapon(weapon);
    self notify("weapon_given", weapon);
    level notify("weapon_given", weapon, self);
  }
  self.cybercom.activecybercommeleeweapon = weapon;
}

function abilitytaken(ability) {
  if(!isDefined(ability)) {
    return;
  }
  if(self hasweapon(ability.weapon)) {
    self takeweapon(ability.weapon);
    self notify("weapon_taken", ability.weapon);
    level notify("weapon_taken", ability.weapon, self);
  }
  if(isDefined(self.cybercom.activecybercommeleeweapon) && self.cybercom.activecybercommeleeweapon == ability.weapon) {
    self.cybercom.activecybercommeleeweapon = undefined;
  }
  if(isDefined(self.cybercom.activecybercomweapon) && self.cybercom.activecybercomweapon == ability.weapon) {
    self.cybercom.activecybercomweapon = undefined;
  }
  if(self hasweapon(ability.weaponupgraded)) {
    self takeweapon(ability.weaponupgraded);
    self notify("weapon_taken", ability.weaponupgraded);
    level notify("weapon_taken", ability.weaponupgraded, self);
  }
  if(isDefined(self.cybercom.activecybercommeleeweapon) && self.cybercom.activecybercommeleeweapon == ability.weaponupgraded) {
    self.cybercom.activecybercommeleeweapon = undefined;
  }
  if(isDefined(self.cybercom.activecybercomweapon) && self.cybercom.activecybercomweapon == ability.weaponupgraded) {
    self.cybercom.activecybercomweapon = undefined;
  }
}

function giveability(name, upgrade) {
  assert(getdvarint(""), "");
  ability = getabilitybyname(name);
  if(!isDefined(ability)) {
    return;
  }
  self setcybercomability(name, upgrade);
  self cybercom::updatecybercomflags();
  self meleeabilitygiven(ability, upgrade);
}

function function_edff667f() {
  foreach(ability in level.cybercom.abilities) {
    self giveability(ability.name, 1);
  }
}

function equipability(name, var_a67a6c08 = 0) {
  assert(getdvarint(""), "");
  abilitystatus = self hascybercomability(name);
  if(abilitystatus == 0) {
    return;
  }
  ability = getabilitybyname(name);
  if(!isDefined(ability)) {
    return;
  }
  self.cybercom.flags.type = ability.type;
  self setcybercomactivetype(ability.type);
  self.cybercom.lastequipped = ability;
  if(abilitystatus == 2) {
    weapon = ability.weaponupgraded;
  } else {
    weapon = ability.weapon;
  }
  if(!ismeleeability(ability)) {
    if(isDefined(self.cybercom.activecybercommeleeweapon) && self hasweapon(self.cybercom.activecybercommeleeweapon)) {
      var_7116dac7 = self.cybercom.activecybercommeleeweapon;
      self takeweapon(self.cybercom.activecybercommeleeweapon);
      self.cybercom.activecybercommeleeweapon = undefined;
    }
    if(isDefined(self.cybercom.activecybercomweapon) && weapon != self.cybercom.activecybercomweapon) {
      self takeweapon(self.cybercom.activecybercomweapon);
      self notify("weapon_taken", self.cybercom.activecybercomweapon);
      level notify("weapon_taken", self.cybercom.activecybercomweapon, self);
    }
    if(!self hasweapon(weapon)) {
      self giveweapon(weapon);
      self notify("weapon_given", weapon);
      level notify("weapon_given", weapon, self);
    }
    self.cybercom.activecybercomweapon = weapon;
    if(!(isDefined(self.cybercom.given_first_ability) && self.cybercom.given_first_ability)) {
      var_a67a6c08 = 1;
      self.cybercom.given_first_ability = 1;
    }
    if(isDefined(var_7116dac7)) {
      self giveweapon(var_7116dac7);
      self.cybercom.activecybercommeleeweapon = var_7116dac7;
      var_7116dac7 = undefined;
    }
    abilities = getabilitiesfortype(self.cybercom.lastequipped.type);
    abilityindex = 1;
    foreach(ability in abilities) {
      if(ability.name == self.cybercom.lastequipped.name) {
        self setcontrolleruimodelvalue("AbilityWheel.Selected" + (ability.type + 1), abilityindex);
        break;
      }
      abilityindex++;
    }
  }
  self sortheldweapons();
  if(var_a67a6c08) {
    self thread function_cae3643b();
  }
  bb::logcybercomevent(self, "equipped", name);
  var_6f5af609 = int(tablelookup("gamedata/stats/cp/cp_statstable.csv", 4, ability.name, 0));
  if(isDefined(self.var_768ee804)) {
    var_6f5af609 = var_6f5af609 | (self.var_768ee804 << 10);
  }
  self setdstat("PlayerStatsList", "LAST_CYBERCOM_EQUIPPED", "statValue", var_6f5af609);
  return ability;
}

function private function_cae3643b() {
  waittillframeend();
  self gadgetpowerset(0, 100);
  self gadgetpowerset(1, 100);
  self gadgetpowerset(2, 100);
}

function takeallabilities() {
  abilities = self getavailableabilities();
  foreach(ability in abilities) {
    self abilitytaken(ability);
  }
  self clearcybercomability();
  if(isDefined(self.cybercom.activecybercomweapon) && self hasweapon(self.cybercom.activecybercomweapon)) {
    self takeweapon(self.cybercom.activecybercomweapon);
  }
  self.cybercom.activecybercomweapon = undefined;
  if(isDefined(self.cybercom.activecybercommeleeweapon) && self hasweapon(self.cybercom.activecybercommeleeweapon)) {
    self takeweapon(self.cybercom.activecybercommeleeweapon);
  }
  self.cybercom.activecybercommeleeweapon = undefined;
  self cybercom::updatecybercomflags();
}

function getabilitybyname(name) {
  foreach(ability in level.cybercom.abilities) {
    if(!isDefined(ability)) {
      continue;
    }
    if(ability.name == name) {
      return ability;
    }
  }
}

function getabilitybyweaponname(name) {
  weapon = getweapon(name);
  foreach(ability in level.cybercom.abilities) {
    if(isDefined(ability.weapon) && weapon.name == ability.weapon.name) {
      return ability;
    }
  }
}

function function_1a6a2760(weapon) {
  if(!isDefined(weapon)) {
    return;
  }
  foreach(ability in level.cybercom.abilities) {
    if(isDefined(ability.weapon) && weapon == ability.weapon) {
      return ability;
    }
    if(isDefined(ability.weaponupgraded) && weapon == ability.weaponupgraded) {
      return ability;
    }
  }
}

function getabilitybyflag(type, flag) {
  foreach(ability in level.cybercom.abilities) {
    if(ability.type == type && ability.flag == flag) {
      return ability;
    }
  }
  return undefined;
}

function getavailableabilities() {
  abilities = [];
  if(!isDefined(self.cybercom) || !isDefined(self.cybercom.flags) || !isDefined(self.cybercom.flags.type)) {
    return abilities;
  }
  foreach(ability in level.cybercom.abilities) {
    ccomabilitystatus = self hascybercomability(ability.name);
    if(ccomabilitystatus != 0) {
      abilities[abilities.size] = ability;
    }
  }
  return abilities;
}

function getabilitiesfortype(type) {
  abilities = [];
  foreach(ability in level.cybercom.abilities) {
    if(ability.type == type) {
      abilities[abilities.size] = ability;
    }
  }
  return abilities;
}

function function_48868896() {
  self endon("disconnect");
  while(true) {
    self waittill("setcybercomability", var_4ccb808f);
    self equipability(var_4ccb808f);
  }
}