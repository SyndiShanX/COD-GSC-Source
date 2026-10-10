/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\heavyarmor.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\game;
#using scripts\mp\utility\weapon;
#namespace heavyarmor;

function addheavyarmor(value) {
  struct = self.heavyarmor;

  if(!isDefined(self.struct)) {
    struct = spawnStruct(self.heavyarmor);
    struct.player = self;
    struct.hp = 0;
    self.heavyarmor = struct;
    struct.hp += value;
    self notify("heavyArmor_added");
    return;
  }

  struct.hp += value;
}

function subtractheavyarmor(value) {
  assert(isDefined(self.heavyarmor) && self.heavyarmor.hp > 0);
  struct = self.heavyarmor;

  if(istrue(struct.immunityframe)) {
    return;
  }

  if(struct.hp > 0) {
    struct.hp = max(0, struct.hp - value);

    if(struct.hp <= 0) {
      thread heavyarmor_break();
    }
  }
}

function removeheavyarmor() {
  assert(isDefined(self.heavyarmor));
  self notify("heavyArmor_removed");
  self.heavyarmor = undefined;
}

function heavyarmormodifydamage(victim, attacker, damage, damageadd, smeansofdeath, sweapon, impactpoint, impactdir, shitloc, inflictor, query) {
  if(damage <= 0 && damageadd <= 0) {
    return [0, damage, damageadd];
  }

  if(smeansofdeath == "MOD_SUICIDE") {
    return [0, damage, damageadd];
  }

  if(isDefined(attacker) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
    return [0, damage, damageadd];
  }

  if(!victim hasheavyarmor()) {
    return [0, damage, damageadd];
  }

  if(isbombsiteweapon(sweapon)) {
    return [0, damage, damageadd];
  }

  if(victim hasheavyarmorinvulnerability()) {
    return [1, 1, 0];
  }

  var_b87fe815189396e6 = victim getheavyarmor();
  modifier = heavyarmor_getdamagemodifier(victim, attacker, damage, damageadd, smeansofdeath, sweapon, impactpoint, impactdir, shitloc, inflictor, query);
  modifieddamage = damage * modifier;
  var_b85ff186894ba31e = damageadd * modifier;
  modifieddamageblocked = modifieddamage + var_b85ff186894ba31e;

  if(!query) {
    victim subtractheavyarmor(modifieddamageblocked);
  }

  if(victim hasheavyarmorinvulnerability()) {
    return [var_b87fe815189396e6, 1, 0];
  }

  return [damage + damageadd, 1, 0];
}

function getheavyarmor() {
  if(!hasheavyarmor()) {
    return 0;
  }

  return self.heavyarmor.hp;
}

function hasheavyarmor() {
  return isDefined(self.heavyarmor) && (self.heavyarmor.hp > 0 || istrue(self.heavyarmor.invulnerabilityframe));
}

function hasheavyarmorinvulnerability() {
  return isDefined(self.heavyarmor) && istrue(self.heavyarmor.invulnerabilityframe);
}

function heavyarmor_break() {
  self endon("disconnect");
  self endon("heavyArmor_removed");

  if(!isanymlgmatch()) {
    self.heavyarmor.invulnerabilityframe = 1;
  }

  self notify("heavyArmor_broken");
  waittillframeend();
  thread removeheavyarmor();
}

function heavyarmor_getdamagemodifier(victim, attacker, damage, damageadd, smeansofdeath, sweapon, impactpoint, impactdir, shitloc, inflictor, query) {
  modifiers = [];

  if(issuperweapon(sweapon)) {
    modifiers[modifiers.size] = 1.33;
  }

  if(isexplosivedamagemod(smeansofdeath)) {
    modifiers[modifiers.size] = 1.5;
  }

  if(smeansofdeath == "MOD_MELEE") {
    modifiers[modifiers.size] = 1.5;
  }

  if(isheadshot(shitloc, smeansofdeath, attacker)) {
    modifiers[modifiers.size] = 1.5;
  }

  bestmodifier = 1;

  foreach(modifier in modifiers) {
    if(modifier > bestmodifier) {
      modifier = bestmodifier;
    }
  }

  return bestmodifier;
}