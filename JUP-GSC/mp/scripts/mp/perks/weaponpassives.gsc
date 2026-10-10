/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\perks\weaponpassives.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#using scripts\mp\loot;
#using scripts\mp\passives;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace weaponpassives;

function weaponpassivesinit() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawnedweaponpassives);
}

function onplayerspawnedweaponpassives() {
  thread watchweaponchanged();
}

function applyweaponchange() {
  newweapon = self.currentweapon;

  if(isDefined(newweapon) && newweapon.basename != "none") {
    giveweaponpassives(newweapon);
  }
}

function watchweaponchanged() {
  self endon("death_or_disconnect");

  while(true) {
    applyweaponchange();
    waittill_either("weapon_change", "giveLoadout");
  }
}

function giveweaponpassives(weapon) {
  clearpassives();
  passives = scripts\mp\loot::getpassivesforweapon(weapon.basename, weapon.variantid);

  if(isDefined(passives)) {
    foreach(passive in passives) {
      giveplayerpassive(passive);
    }
  }

  self notify("weapon_passives_given");
}

function giveplayerpassive(passive) {
  giveperk(passive);
  self.weaponpassives[self.weaponpassives.size] = passive;
}

function clearpassives() {
  if(isDefined(self.weaponpassives)) {
    foreach(passive in self.weaponpassives) {
      removeperk(passive);
    }
  }

  self.weaponpassives = [];
}

function forgetpassives() {
  self.weaponpassives = [];
}

function definepassivevalue(link) {
  if(!isDefined(self.passivevalues)) {
    self.passivevalues = [];
  }

  if(!isDefined(self.passivevalues[link])) {
    self.passivevalues[link] = 0;
  }
}

function getpassivevalue(link) {
  definepassivevalue(link);
  return self.passivevalues[link];
}

function setpassivevalue(link, value) {
  definepassivevalue(link);
  self.passivevalues[link] = value;
}

function teamsmatch(sourceplayer, targetplayer) {
  if(level.teambased) {
    return (sourceplayer.team == targetplayer.team);
  }

  return sourceplayer == targetplayer;
}

function updateweaponpassivesonuse(player, objweapon) {}

function updateweaponpassivesondamage(victim, attacker, damage, smeansofdeath, objweapon, impactpoint, impactdir, shitloc, inflictor, query) {}

function loadoutweapongiven(objweapon) {}

function updateweaponpassivesonkill(einflictor, attacker, victim, idamage, smeansofdeath, objweapon, shitloc, vdir) {}

function testpassivemessage(passive, suffix) {
  if(!isDefined(suffix)) {
    suffix = "";
  }

  messagesuccess = 0;
  messageref = scripts\mp\passives::getpassivemessage(passive);
  messagestring = "";

  if(isDefined(messageref)) {
    messagestring = messageref + suffix;
    messagesuccess = scripts\mp\hud_message::testmiscmessage(messagestring);
  }

  if(messagesuccess) {
    println("<dev string:x1c>" + messagestring);
    return;
  }

  println("<dev string:x3c>" + messagestring);
}

function checkpassivemessage(passive, suffix) {
  if(!isDefined(suffix)) {
    suffix = "";
  }

  messageref = scripts\mp\passives::getpassivemessage(passive);

  if(isDefined(messageref)) {
    if(isendstr(suffix, "_camo")) {
      tempstring = strip_suffix(suffix, "_camo");
      suffix = tempstring;
    }

    scripts\mp\hud_message::showmiscmessage(messageref + suffix);
  }
}

function getpassivedeathwatching(attacker, key) {
  if(!isDefined(attacker.passivedeathwatcher)) {
    return false;
  }

  if(!isDefined(attacker.passivedeathwatcher[key])) {
    return false;
  }

  if(attacker.passivedeathwatcher[key]) {
    return true;
  }

  return false;
}

function setpassivedeathwatching(attacker, key, enabled) {
  if(!isDefined(attacker.passivedeathwatcher)) {
    attacker.passivedeathwatcher = [];
  }

  attacker.passivedeathwatcher[key] = enabled;
}

function clearpassivedeathwatching(attacker, key) {
  if(!isDefined(attacker.passivedeathwatcher)) {
    attacker.passivedeathwatcher = [];
  }

  attacker.passivedeathwatcher[key] = undefined;
}

function setstackvalues(id, stacksmax, var_4d8375d9e2e75e74, decaytime) {
  if(!isDefined(self.stackvalues)) {
    self.stackvalues = [];
  }

  if(!isDefined(self.stackvalues[id])) {
    values = spawnStruct();
    values.id = id;
    values.stacksmax = stacksmax;
    values.stackscurrent = var_4d8375d9e2e75e74;
    values.decaytime = decaytime;
    self.stackvalues[id] = values;
  }
}

function getstackvalues(id) {
  if(!isDefined(self.stackvalues)) {
    return undefined;
  }

  if(!isDefined(self.stackvalues[id])) {
    return undefined;
  }

  values = self.stackvalues[id];
  return values;
}

function getstackcount(id) {
  values = getstackvalues(id);

  if(!isDefined(values)) {
    return 0;
  }

  return values.stackscurrent;
}

function addstackcount(id, amount) {}