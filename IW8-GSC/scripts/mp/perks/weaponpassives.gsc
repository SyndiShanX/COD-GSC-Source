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
  var0 = self.currentweapon;

  if(isDefined(var0) && var0.basename != "none") {
    giveweaponpassives(var0);
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

function giveweaponpassives(var0) {
  clearpassives();
  var1 = scripts\mp\loot::getpassivesforweapon(var0.basename, var0.variantid);

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      giveplayerpassive(var3);
    }
  }

  self notify("weapon_passives_given");
}

function giveplayerpassive(var0) {
  scripts\mp\utility\perk::giveperk(var0);
  self.weaponpassives[self.weaponpassives.size] = var0;
}

function clearpassives() {
  if(isDefined(self.weaponpassives)) {
    foreach(var1 in self.weaponpassives) {
      scripts\mp\utility\perk::removeperk(var1);
    }
  }

  self.weaponpassives = [];
}

function forgetpassives() {
  self.weaponpassives = [];
}

function definepassivevalue(var0) {
  if(!isDefined(self.passivevalues)) {
    self.passivevalues = [];
  }

  if(!isDefined(self.passivevalues[var0])) {
    self.passivevalues[var0] = 0;
    return;
  }
}

function getpassivevalue(var0) {
  definepassivevalue(var0);
  return self.passivevalues[var0];
}

function setpassivevalue(var0, var1) {
  definepassivevalue(var0);
  self.passivevalues[var0] = var1;
}

function teamsmatch(var0, var1) {
  if(level.teambased) {
    return (var0.team == var1.team);
  }

  return var0 == var1;
}

function updateweaponpassivesonuse(var0, var1) {}

function updateweaponpassivesondamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {}

function loadoutweapongiven(var0) {}

function updateweaponpassivesonkill(var0, var1, var2, var3, var4, var5, var6, var7) {}

function testpassivemessage(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  }

  var2 = 0;
  var3 = scripts\mp\passives::getpassivemessage(var0);
  var4 = "";

  if(isDefined(var3)) {
    var4 = var3 + var1;
    var2 = scripts\mp\hud_message::testmiscmessage(var4);
  }

  if(var2) {
    return;
  }
}

function checkpassivemessage(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  }

  var2 = scripts\mp\passives::getpassivemessage(var0);

  if(isDefined(var2)) {
    if(isendstr(var1, "_camo")) {
      var3 = scripts\mp\utility\script::strip_suffix(var1, "_camo");
      var1 = var3;
    }

    scripts\mp\hud_message::showmiscmessage(var2 + var1);
    return;
  }
}

function getpassivedeathwatching(var0, var1) {
  if(!isDefined(var0.passivedeathwatcher)) {
    return false;
  }

  if(!isDefined(var0.passivedeathwatcher[var1])) {
    return false;
  }

  if(var0.passivedeathwatcher[var1]) {
    return true;
  }

  return false;
}

function setpassivedeathwatching(var0, var1, var2) {
  if(!isDefined(var0.passivedeathwatcher)) {
    var0.passivedeathwatcher = [];
  }

  var0.passivedeathwatcher[var1] = var2;
}

function clearpassivedeathwatching(var0, var1) {
  if(!isDefined(var0.passivedeathwatcher)) {
    var0.passivedeathwatcher = [];
  }

  var0.passivedeathwatcher[var1] = undefined;
}

function setstackvalues(var0, var1, var2, var3) {
  if(!isDefined(self.stackvalues)) {
    self.stackvalues = [];
  }

  if(!isDefined(self.stackvalues[var0])) {
    var4 = spawnStruct();
    var4.id = var0;
    var4.stacksmax = var1;
    var4.stackscurrent = var2;
    var4.decaytime = var3;
    self.stackvalues[var0] = var4;
    return;
  }
}

function getstackvalues(var0) {
  if(!isDefined(self.stackvalues)) {
    return undefined;
  }

  if(!isDefined(self.stackvalues[var0])) {
    return undefined;
  }

  var1 = self.stackvalues[var0];
  return var1;
}

function getstackcount(var0) {
  var1 = getstackvalues(var0);

  if(!isDefined(var1)) {
    return 0;
  }

  return var1.stackscurrent;
}

function addstackcount(var0, var1) {}