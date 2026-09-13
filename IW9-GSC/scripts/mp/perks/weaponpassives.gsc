/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\weaponpassives.gsc
***********************************************/

weaponpassivesinit() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawnedweaponpassives);
}

onplayerspawnedweaponpassives() {
  thread watchweaponchanged();
}

applyweaponchange() {
  _id_DD515FCF025B2E79 = self.currentweapon;

  if(isDefined(_id_DD515FCF025B2E79) && _id_DD515FCF025B2E79.basename != "none")
    giveweaponpassives(_id_DD515FCF025B2E79);
}

watchweaponchanged() {
  self endon("death_or_disconnect");

  for(;;) {
    applyweaponchange();
    scripts\engine\utility::waittill_either("weapon_change", "giveLoadout");
  }
}

giveweaponpassives(weapon) {
  clearpassives();
  passives = scripts\mp\loot::getpassivesforweapon(weapon.basename, weapon.variantid);

  if(isDefined(passives)) {
    foreach(_id_F8B2E6BF3F40AB02 in passives)
    giveplayerpassive(_id_F8B2E6BF3F40AB02);
  }

  self notify("weapon_passives_given");
}

giveplayerpassive(_id_F8B2E6BF3F40AB02) {
  scripts\mp\utility\perk::giveperk(_id_F8B2E6BF3F40AB02);
  self.weaponpassives[self.weaponpassives.size] = _id_F8B2E6BF3F40AB02;
}

clearpassives() {
  if(isDefined(self.weaponpassives)) {
    foreach(_id_F8B2E6BF3F40AB02 in self.weaponpassives)
    scripts\mp\utility\perk::removeperk(_id_F8B2E6BF3F40AB02);
  }

  self.weaponpassives = [];
}

forgetpassives() {
  self.weaponpassives = [];
}

definepassivevalue(_id_EE91862B850C90E5) {
  if(!isDefined(self.passivevalues))
    self.passivevalues = [];

  if(!isDefined(self.passivevalues[_id_EE91862B850C90E5]))
    self.passivevalues[_id_EE91862B850C90E5] = 0.0;
}

getpassivevalue(_id_EE91862B850C90E5) {
  definepassivevalue(_id_EE91862B850C90E5);
  return self.passivevalues[_id_EE91862B850C90E5];
}

setpassivevalue(_id_EE91862B850C90E5, value) {
  definepassivevalue(_id_EE91862B850C90E5);
  self.passivevalues[_id_EE91862B850C90E5] = value;
}

teamsmatch(_id_57C86EFA51E1F301, targetplayer) {
  if(level.teambased)
    return _id_57C86EFA51E1F301.team == targetplayer.team;

  return _id_57C86EFA51E1F301 == targetplayer;
}

updateweaponpassivesonuse(player, objweapon) {}

updateweaponpassivesondamage(victim, attacker, damage, smeansofdeath, objweapon, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887) {}

loadoutweapongiven(objweapon) {}

updateweaponpassivesonkill(einflictor, attacker, victim, idamage, smeansofdeath, objweapon, shitloc, vdir) {}

testpassivemessage(_id_F8B2E6BF3F40AB02, _id_0E4731409BD255E0) {
  if(!isDefined(_id_0E4731409BD255E0))
    _id_0E4731409BD255E0 = "";

  _id_77BDBF78236F1F9B = 0;
  messageref = scripts\mp\passives::getpassivemessage(_id_F8B2E6BF3F40AB02);
  _id_BCEDF03B3E6ABCB1 = "";

  if(isDefined(messageref)) {
    _id_BCEDF03B3E6ABCB1 = messageref + _id_0E4731409BD255E0;
    _id_77BDBF78236F1F9B = scripts\mp\hud_message::testmiscmessage(_id_BCEDF03B3E6ABCB1);
  }

  if(_id_77BDBF78236F1F9B) {
    return;
  }
  return;
}

checkpassivemessage(_id_F8B2E6BF3F40AB02, _id_0E4731409BD255E0) {
  if(!isDefined(_id_0E4731409BD255E0))
    _id_0E4731409BD255E0 = "";

  messageref = scripts\mp\passives::getpassivemessage(_id_F8B2E6BF3F40AB02);

  if(isDefined(messageref)) {
    if(isendstr(_id_0E4731409BD255E0, "_camo")) {
      _id_B545D8C9B1EB9F0E = scripts\mp\utility\script::strip_suffix(_id_0E4731409BD255E0, "_camo");
      _id_0E4731409BD255E0 = _id_B545D8C9B1EB9F0E;
    }

    scripts\mp\hud_message::showmiscmessage(messageref + _id_0E4731409BD255E0);
  }
}

getpassivedeathwatching(attacker, key) {
  if(!isDefined(attacker.passivedeathwatcher))
    return 0;

  if(!isDefined(attacker.passivedeathwatcher[key]))
    return 0;

  if(attacker.passivedeathwatcher[key])
    return 1;

  return 0;
}

setpassivedeathwatching(attacker, key, enabled) {
  if(!isDefined(attacker.passivedeathwatcher))
    attacker.passivedeathwatcher = [];

  attacker.passivedeathwatcher[key] = enabled;
}

clearpassivedeathwatching(attacker, key) {
  if(!isDefined(attacker.passivedeathwatcher))
    attacker.passivedeathwatcher = [];

  attacker.passivedeathwatcher[key] = undefined;
}

setstackvalues(id, stacksmax, _id_4D8375D9E2E75E74, decaytime) {
  if(!isDefined(self.stackvalues))
    self.stackvalues = [];

  if(!isDefined(self.stackvalues[id])) {
    values = spawnStruct();
    values.id = id;
    values.stacksmax = stacksmax;
    values.stackscurrent = _id_4D8375D9E2E75E74;
    values.decaytime = decaytime;
    self.stackvalues[id] = values;
  }
}

getstackvalues(id) {
  if(!isDefined(self.stackvalues))
    return undefined;

  if(!isDefined(self.stackvalues[id]))
    return undefined;

  values = self.stackvalues[id];
  return values;
}

getstackcount(id) {
  values = getstackvalues(id);

  if(!isDefined(values))
    return 0;

  return values.stackscurrent;
}

addstackcount(id, amount) {}