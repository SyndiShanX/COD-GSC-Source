/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\heavyarmor.gsc
*************************************/

addheavyarmor(param_00) {
  var_01 = self.heavyarmor;
  if(!isDefined(self.struct)) {
    var_01 = spawnStruct(self.heavyarmor);
    var_01.player = self;
    var_01.hp = 0;
    self.heavyarmor = var_01;
    var_01.hp = var_01.hp + param_00;
    self notify("heavyArmor_added");
    return;
  }

  var_01.hp = var_01.hp + param_00;
}

subtractheavyarmor(param_00) {
  var_01 = self.heavyarmor;
  if(scripts\mp\utility::istrue(var_01.var_9344)) {
    return;
  }

  if(var_01.hp > 0) {
    var_01.hp = max(0, var_01.hp - param_00);
    scripts\mp\missions::func_D991("ch_heavy_armor_absorb", param_00);
    if(var_01.hp <= 0) {
      thread heavyarmor_break();
    }
  }
}

removeheavyarmor() {
  self notify("heavyArmor_removed");
  self.heavyarmor = undefined;
}

heavyarmormodifydamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(param_02 <= 0 && param_03 <= 0) {
    return [0, param_02, param_03];
  }

  if(param_04 == "MOD_SUICIDE") {
    return [0, param_02, param_03];
  }

  if(isDefined(param_01) && param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn") {
    return [0, param_02, param_03];
  }

  if(!param_00 hasheavyarmor()) {
    return [0, param_02, param_03];
  }

  if(scripts\mp\utility::isbombsiteweapon(param_05)) {
    return [0, param_02, param_03];
  }

  if(param_00 hasheavyarmorinvulnerability()) {
    return [1, 1, 0];
  }

  var_0B = param_00 getheavyarmor();
  var_0C = heavyarmor_getdamagemodifier(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
  var_0D = param_02 * var_0C;
  var_0E = param_03 * var_0C;
  var_0F = var_0D + var_0E;
  if(!param_0A) {
    param_00 subtractheavyarmor(var_0F);
  }

  if(param_00 hasheavyarmorinvulnerability()) {
    return [var_0B, 1, 0];
  }

  return [param_02 + param_03, 1, 0];
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

heavyarmor_getdamagemodifier(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = [];
  if(scripts\mp\utility::issuperweapon(param_04)) {
    var_0B[var_0B.size] = 1.33;
  }

  if(isexplosivedamagemod(param_04)) {
    var_0B[var_0B.size] = 1.5;
  }

  if(param_04 == "MOD_MELEE") {
    var_0B[var_0B.size] = 1.5;
  }

  if(scripts\mp\utility::isheadshot(param_05, param_08, param_04, param_01)) {
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