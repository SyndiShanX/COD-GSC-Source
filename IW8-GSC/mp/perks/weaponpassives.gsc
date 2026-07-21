/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\perks\weaponpassives.gsc
***********************************************/

weaponpassivesinit() {
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawnedweaponpassives);
}

onplayerspawnedweaponpassives() {
  thread watchweaponchanged();
}

applyweaponchange() {
  var_0 = self.currentweapon;

  if(isDefined(var_0) && var_0.basename != "_encstr_8BBA05185F8B99")
    giveweaponpassives(var_0);
}

watchweaponchanged() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    applyweaponchange();
    scripts\engine\utility::waittill_either("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_B2030CA0C91D2F44C0B314F8836B");
  }
}

giveweaponpassives(var_0) {
  clearpassives();
  var_1 = scripts\mp\loot::getpassivesforweapon(var_0.basename, var_0.variantid);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1)
    giveplayerpassive(var_3);
  }

  self notify("_encstr_8E08168C5DBF339FDDB9D05053B2AB4B07D3AF0CB93B59D5");
}

giveplayerpassive(var_0) {
  scripts\mp\utility\perk::giveperk(var_0);
  self.weaponpassives[self.weaponpassives.size] = var_0;
}

clearpassives() {
  if(isDefined(self.weaponpassives)) {
    foreach(var_1 in self.weaponpassives)
    scripts\mp\utility\perk::removeperk(var_1);
  }

  self.weaponpassives = [];
}

forgetpassives() {
  self.weaponpassives = [];
}

definepassivevalue(var_0) {
  if(!isDefined(self.passivevalues))
    self.passivevalues = [];

  if(!isDefined(self.passivevalues[var_0]))
    self.passivevalues[var_0] = 0.0;
}

getpassivevalue(var_0) {
  definepassivevalue(var_0);
  return self.passivevalues[var_0];
}

setpassivevalue(var_0, var_1) {
  definepassivevalue(var_0);
  self.passivevalues[var_0] = var_1;
}

teamsmatch(var_0, var_1) {
  if(level.teambased)
    return var_0.team == var_1.team;

  return var_0 == var_1;
}

updateweaponpassivesonuse(var_0, var_1) {}

updateweaponpassivesondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

loadoutweapongiven(var_0) {}

updateweaponpassivesonkill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

testpassivemessage(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  var_2 = 0;
  var_3 = scripts\mp\passives::getpassivemessage(var_0);
  var_4 = "_encstr_B40101";

  if(isDefined(var_3)) {
    var_4 = var_3 + var_1;
    var_2 = scripts\mp\hud_message::testmiscmessage(var_4);
  }

  if(var_2) {
    return;
  }
  return;
}

checkpassivemessage(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  var_2 = scripts\mp\passives::getpassivemessage(var_0);

  if(isDefined(var_2)) {
    if(isendstr(var_1, "_encstr_8DDF06EB36586B7B")) {
      var_3 = scripts\mp\utility\script::strip_suffix(var_1, "_encstr_8DDF06EB36586B7B");
      var_1 = var_3;
    }

    scripts\mp\hud_message::showmiscmessage(var_2 + var_1);
  }
}

getpassivedeathwatching(var_0, var_1) {
  if(!isDefined(var_0.passivedeathwatcher))
    return 0;

  if(!isDefined(var_0.passivedeathwatcher[var_1]))
    return 0;

  if(var_0.passivedeathwatcher[var_1])
    return 1;

  return 0;
}

setpassivedeathwatching(var_0, var_1, var_2) {
  if(!isDefined(var_0.passivedeathwatcher))
    var_0.passivedeathwatcher = [];

  var_0.passivedeathwatcher[var_1] = var_2;
}

clearpassivedeathwatching(var_0, var_1) {
  if(!isDefined(var_0.passivedeathwatcher))
    var_0.passivedeathwatcher = [];

  var_0.passivedeathwatcher[var_1] = undefined;
}

setstackvalues(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stackvalues))
    self.stackvalues = [];

  if(!isDefined(self.stackvalues[var_0])) {
    var_4 = spawnStruct();
    var_4.id = var_0;
    var_4.stacksmax = var_1;
    var_4.stackscurrent = var_2;
    var_4.decaytime = var_3;
    self.stackvalues[var_0] = var_4;
  }
}

getstackvalues(var_0) {
  if(!isDefined(self.stackvalues))
    return undefined;

  if(!isDefined(self.stackvalues[var_0]))
    return undefined;

  var_1 = self.stackvalues[var_0];
  return var_1;
}

getstackcount(var_0) {
  var_1 = getstackvalues(var_0);

  if(!isDefined(var_1))
    return 0;

  return var_1.stackscurrent;
}

addstackcount(var_0, var_1) {}