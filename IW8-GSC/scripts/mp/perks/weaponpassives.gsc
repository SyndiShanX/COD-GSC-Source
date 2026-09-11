/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\weaponpassives.gsc
***********************************************/

function weaponpassivesinit() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawnedweaponpassives);
}

function onplayerspawnedweaponpassives() {
  thread watchweaponchanged();
}

function applyweaponchange() {
  var_0 = self.currentweapon;

  if(isDefined(var_0) && var_0.basename != "none") {
    giveweaponpassives(var_0);
    return;
  }
}

function watchweaponchanged() {
  self endon("death_or_disconnect");

  for(;;) {
    applyweaponchange();
    scripts\engine\utility::waittill_either("weapon_change", "giveLoadout");
  }
}

function giveweaponpassives(var_0) {
  clearpassives();
  var_1 = scripts\mp\loot::getpassivesforweapon(var_0.basename, var_0.variantid);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      giveplayerpassive(var_3);
    }
  }

  self notify("weapon_passives_given");
}

function giveplayerpassive(var_0) {
  scripts\mp\utility\perk::giveperk(var_0);
  self.weaponpassives[self.weaponpassives.size] = var_0;
}

function clearpassives() {
  if(isDefined(self.weaponpassives)) {
    foreach(var_1 in self.weaponpassives) {
      scripts\mp\utility\perk::removeperk(var_1);
    }
  }

  self.weaponpassives = [];
}

function forgetpassives() {
  self.weaponpassives = [];
}

function definepassivevalue(var_0) {
  if(!isDefined(self.passivevalues)) {
    self.passivevalues = [];
  }

  if(!isDefined(self.passivevalues[var_0])) {
    self.passivevalues[var_0] = 0;
    return;
  }
}

function getpassivevalue(var_0) {
  definepassivevalue(var_0);
  return self.passivevalues[var_0];
}

function setpassivevalue(var_0, var_1) {
  definepassivevalue(var_0);
  self.passivevalues[var_0] = var_1;
}

function teamsmatch(var_0, var_1) {
  if(level.teambased) {
    return (var_0.team == var_1.team);
  }

  return var_0 == var_1;
}

function updateweaponpassivesonuse(var_0, var_1) {}

function updateweaponpassivesondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

function loadoutweapongiven(var_0) {}

function updateweaponpassivesonkill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

function testpassivemessage(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = 0;
  var_3 = scripts\mp\passives::getpassivemessage(var_0);
  var_4 = "";

  if(isDefined(var_3)) {
    var_4 = var_3 + var_1;
    var_2 = scripts\mp\hud_message::testmiscmessage(var_4);
  }

  if(var_2) {
    return;
  }
}

function checkpassivemessage(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = scripts\mp\passives::getpassivemessage(var_0);

  if(isDefined(var_2)) {
    if(isendstr(var_1, "_camo")) {
      var_3 = scripts\mp\utility\script::strip_suffix(var_1, "_camo");
      var_1 = var_3;
    }

    scripts\mp\hud_message::showmiscmessage(var_2 + var_1);
    return;
  }
}

function getpassivedeathwatching(var_0, var_1) {
  if(!isDefined(var_0.passivedeathwatcher)) {
    return false;
  }

  if(!isDefined(var_0.passivedeathwatcher[var_1])) {
    return false;
  }

  if(var_0.passivedeathwatcher[var_1]) {
    return true;
  }

  return false;
}

function setpassivedeathwatching(var_0, var_1, var_2) {
  if(!isDefined(var_0.passivedeathwatcher)) {
    var_0.passivedeathwatcher = [];
  }

  var_0.passivedeathwatcher[var_1] = var_2;
}

function clearpassivedeathwatching(var_0, var_1) {
  if(!isDefined(var_0.passivedeathwatcher)) {
    var_0.passivedeathwatcher = [];
  }

  var_0.passivedeathwatcher[var_1] = undefined;
}

function setstackvalues(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stackvalues)) {
    self.stackvalues = [];
  }

  if(!isDefined(self.stackvalues[var_0])) {
    var_4 = spawnStruct();
    var_4.id = var_0;
    var_4.stacksmax = var_1;
    var_4.stackscurrent = var_2;
    var_4.decaytime = var_3;
    self.stackvalues[var_0] = var_4;
    return;
  }
}

function getstackvalues(var_0) {
  if(!isDefined(self.stackvalues)) {
    return undefined;
  }

  if(!isDefined(self.stackvalues[var_0])) {
    return undefined;
  }

  var_1 = self.stackvalues[var_0];
  return var_1;
}

function getstackcount(var_0) {
  var_1 = getstackvalues(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1.stackscurrent;
}

function addstackcount(var_0, var_1) {}