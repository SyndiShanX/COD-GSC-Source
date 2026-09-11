/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\heavyarmor.gsc
***********************************************/

function addheavyarmor(var_0) {
  var_1 = self.heavyarmor;

  if(!isDefined(self.struct)) {
    var_1 = spawnStruct(self.heavyarmor);
    var_1.player = self;
    var_1.hp = 0;
    self.heavyarmor = var_1;
    var_1.hp += var_0;
    self notify("heavyArmor_added");
    return;
  }

  var_1.hp += var_0;
}

function subtractheavyarmor(var_0) {
  var_1 = self.heavyarmor;

  if(istrue(var_1.immunityframe)) {
    return;
  }

  if(var_1.hp > 0) {
    var_1.hp = max(0, var_1.hp - var_0);

    if(var_1.hp <= 0) {
      thread heavyarmor_break();
      return;
    }

    return;
  }
}

function removeheavyarmor() {
  self notify("heavyArmor_removed");
  self.heavyarmor = undefined;
}

function heavyarmormodifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_2 <= 0 && var_3 <= 0) {
    return [0, var_2, var_3];
  }

  if(var_4 == "MOD_SUICIDE") {
    return [0, var_2, var_3];
  }

  if(isDefined(var_1) && (var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn")) {
    return [0, var_2, var_3];
  }

  if(!hasheavyarmor(var_0)) {
    return [0, var_2, var_3];
  }

  if(scripts\mp\utility\weapon::isbombsiteweapon(var_5)) {
    return [0, var_2, var_3];
  }

  if(hasheavyarmorinvulnerability(var_0)) {
    return [1, 1, 0];
  }

  var_11 = getheavyarmor(var_0);
  var_12 = heavyarmor_getdamagemodifier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  var_13 = var_2 * var_12;
  var_14 = var_3 * var_12;
  var_15 = var_13 + var_14;

  if(!var_10) {
    subtractheavyarmor(var_0, var_15);
  }

  if(hasheavyarmorinvulnerability(var_0)) {
    return [var_11, 1, 0];
  }

  return [var_2 + var_3, 1, 0];
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

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    self.heavyarmor.invulnerabilityframe = 1;
  }

  self notify("heavyArmor_broken");
  waittillframeend();
  thread removeheavyarmor();
}

function heavyarmor_getdamagemodifier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = [];

  if(scripts\mp\utility\weapon::issuperweapon(var_5)) {
    GscBinSkip0(0x2e, var_11.size, 1.33);
  }

  if(isexplosivedamagemod(var_4)) {
    GscBinSkip0(0x2e, var_11.size, 1.5);
  }

  if(var_4 == "MOD_MELEE") {
    GscBinSkip0(0x2e, var_11.size, 1.5);
  }

  if(scripts\mp\utility\damage::isheadshot(var_8, var_4, var_1)) {
    GscBinSkip0(0x2e, var_11.size, 1.5);
  }

  var_12 = 1;

  foreach(var_14 in var_11) {
    if(var_14 > var_12) {
      var_14 = var_12;
    }
  }

  return var_12;
}