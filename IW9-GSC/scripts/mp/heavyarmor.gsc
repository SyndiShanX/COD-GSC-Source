/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\heavyarmor.gsc
***********************************************/

addheavyarmor(value) {
  struct = self.heavyarmor;

  if(!isDefined(self.struct)) {
    struct = spawnStruct(self.heavyarmor);
    struct.player = self;
    struct.hp = 0;
    self.heavyarmor = struct;
    struct.hp = struct.hp + value;
    self notify("heavyArmor_added");
  } else
    struct.hp = struct.hp + value;
}

subtractheavyarmor(value) {
  struct = self.heavyarmor;

  if(istrue(struct.immunityframe)) {
    return;
  }
  if(struct.hp > 0) {
    struct.hp = max(0, struct.hp - value);

    if(struct.hp <= 0)
      thread heavyarmor_break();
  }
}

removeheavyarmor() {
  self notify("heavyArmor_removed");
  self.heavyarmor = undefined;
}

heavyarmormodifydamage(victim, attacker, damage, _id_6CAC94B6632AA667, smeansofdeath, sweapon, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887) {
  if(damage <= 0 && _id_6CAC94B6632AA667 <= 0)
    return [0, damage, _id_6CAC94B6632AA667];

  if(smeansofdeath == "MOD_SUICIDE")
    return [0, damage, _id_6CAC94B6632AA667];

  if(isDefined(attacker) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn"))
    return [0, damage, _id_6CAC94B6632AA667];

  if(!victim hasheavyarmor())
    return [0, damage, _id_6CAC94B6632AA667];

  if(scripts\mp\utility\weapon::isbombsiteweapon(sweapon))
    return [0, damage, _id_6CAC94B6632AA667];

  if(victim hasheavyarmorinvulnerability())
    return [1, 1, 0];

  _id_B87FE815189396E6 = victim getheavyarmor();
  modifier = heavyarmor_getdamagemodifier(victim, attacker, damage, _id_6CAC94B6632AA667, smeansofdeath, sweapon, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887);
  _id_702BFC08FABD86CB = damage * modifier;
  _id_B85FF186894BA31E = _id_6CAC94B6632AA667 * modifier;
  _id_69D5427F107982F5 = _id_702BFC08FABD86CB + _id_B85FF186894BA31E;

  if(!_id_124225617CFE6887)
    victim subtractheavyarmor(_id_69D5427F107982F5);

  if(victim hasheavyarmorinvulnerability())
    return [_id_B87FE815189396E6, 1, 0];

  return [damage + _id_6CAC94B6632AA667, 1, 0];
}

getheavyarmor() {
  if(!hasheavyarmor())
    return 0;

  return self.heavyarmor.hp;
}

hasheavyarmor() {
  return isDefined(self.heavyarmor) && (self.heavyarmor.hp > 0 || istrue(self.heavyarmor.invulnerabilityframe));
}

hasheavyarmorinvulnerability() {
  return isDefined(self.heavyarmor) && istrue(self.heavyarmor.invulnerabilityframe);
}

heavyarmor_break() {
  self endon("disconnect");
  self endon("heavyArmor_removed");

  if(!scripts\mp\utility\game::isanymlgmatch())
    self.heavyarmor.invulnerabilityframe = 1;

  self notify("heavyArmor_broken");
  waittillframeend;
  thread removeheavyarmor();
}

heavyarmor_getdamagemodifier(victim, attacker, damage, _id_6CAC94B6632AA667, smeansofdeath, sweapon, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887) {
  modifiers = [];

  if(scripts\mp\utility\weapon::issuperweapon(sweapon))
    modifiers[modifiers.size] = 1.33;

  if(isexplosivedamagemod(smeansofdeath))
    modifiers[modifiers.size] = 1.5;

  if(smeansofdeath == "MOD_MELEE")
    modifiers[modifiers.size] = 1.5;

  if(scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
    modifiers[modifiers.size] = 1.5;

  _id_1D71101015322DD2 = 1;

  foreach(modifier in modifiers) {
    if(modifier > _id_1D71101015322DD2)
      modifier = _id_1D71101015322DD2;
  }

  return _id_1D71101015322DD2;
}