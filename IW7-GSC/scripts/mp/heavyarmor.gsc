/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\heavyarmor.gsc
*********************************************/

addheavyarmor(var_0) {
  var_1 = self.heavyarmor;
  if(!isDefined(self.struct)) {
    var_1 = spawnStruct(self.heavyarmor);
    var_1.player = self;
    var_1.hp = 0;
    self.heavyarmor = var_1;
    var_1.hp = var_1.hp + var_0;
    self notify("heavyArmor_added");
    return;
  }

  var_1.hp = var_1.hp + var_0;
}

subtractheavyarmor(var_0) {
  var_1 = self.heavyarmor;
  if(scripts\mp\utility::istrue(var_1.var_9344)) {
    return;
  }

  if(var_1.hp > 0) {
    var_1.hp = max(0, var_1.hp - var_0);
    scripts\mp\missions::func_D991("ch_heavy_armor_absorb", var_0);
    if(var_1.hp <= 0) {
      thread heavyarmor_break();
    }
  }
}

removeheavyarmor() {
  self notify("heavyArmor_removed");
  self.heavyarmor = undefined;
}

heavyarmormodifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(var_2 <= 0 && var_3 <= 0) {
    return [0, var_2, var_3];
  }

  if(var_4 == "MOD_SUICIDE") {
    return [0, var_2, var_3];
  }

  if(isDefined(var_1) && var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn") {
    return [0, var_2, var_3];
  }

  if(!var_0 hasheavyarmor()) {
    return [0, var_2, var_3];
  }

  if(scripts\mp\utility::isbombsiteweapon(var_5)) {
    return [0, var_2, var_3];
  }

  if(var_0 hasheavyarmorinvulnerability()) {
    return [1, 1, 0];
  }

  var_0B = var_0 getheavyarmor();
  var_0C = heavyarmor_getdamagemodifier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
  var_0D = var_2 * var_0C;
  var_0E = var_3 * var_0C;
  var_0F = var_0D + var_0E;
  if(!var_0A) {
    var_0 subtractheavyarmor(var_0F);
  }

  if(var_0 hasheavyarmorinvulnerability()) {
    return [var_0B, 1, 0];
  }

  return [var_2 + var_3, 1, 0];
}

getheavyarmor() {
  if(!hasheavyarmor()) {
    return 0;
  }

  return self.heavyarmor.hp;
}

hasheavyarmor() {
  return isDefined(self.heavyarmor) && self.heavyarmor.hp > 0 || scripts\mp\utility::istrue(self.heavyarmor.invulnerabilityframe);
}

hasheavyarmorinvulnerability() {
  return isDefined(self.heavyarmor) && scripts\mp\utility::istrue(self.heavyarmor.invulnerabilityframe);
}

heavyarmor_break() {
  self endon("disconnect");
  self endon("heavyArmor_removed");
  if(!scripts\mp\utility::isanymlgmatch()) {
    self.heavyarmor.invulnerabilityframe = 1;
  }

  self notify("heavyArmor_broken");
  waittillframeend;
  thread removeheavyarmor();
}

heavyarmor_getdamagemodifier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  var_0B = [];
  if(scripts\mp\utility::issuperweapon(var_4)) {
    var_0B[var_0B.size] = 1.33;
  }

  if(isexplosivedamagemod(var_4)) {
    var_0B[var_0B.size] = 1.5;
  }

  if(var_4 == "MOD_MELEE") {
    var_0B[var_0B.size] = 1.5;
  }

  if(scripts\mp\utility::isheadshot(var_5, var_8, var_4, var_1)) {
    var_0B[var_0B.size] = 1.5;
  }

  var_0C = 1;
  foreach(var_0E in var_0B) {
    if(var_0E > var_0C) {
      var_0E = var_0C;
    }
  }

  return var_0C;
}