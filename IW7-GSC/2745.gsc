/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2745.gsc
***************************************/

addheavyarmor(var_0) {
  var_1 = self.heavyarmor;

  if(!isDefined(self.struct)) {
    var_1 = spawnStruct(self.heavyarmor);
    var_1.player = self;
    var_1.hp = 0;
    self.heavyarmor = var_1;
    var_1.hp = var_1.hp + var_0;
    self notify("heavyArmor_added");
  } else
    var_1.hp = var_1.hp + var_0;
}

subtractheavyarmor(var_0) {
  var_1 = self.heavyarmor;

  if(scripts\mp\utility\game::istrue(var_1.var_9344)) {
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

heavyarmormodifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_2 <= 0 && var_3 <= 0) {
    return [0, var_2, var_3];
  }

  if(var_4 == "MOD_SUICIDE") {
    return [0, var_2, var_3];
  }

  if(isDefined(var_1) && (var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn")) {
    return [0, var_2, var_3];
  }

  if(!var_0 hasheavyarmor()) {
    return [0, var_2, var_3];
  }

  if(scripts\mp\utility\game::isbombsiteweapon(var_5)) {
    return [0, var_2, var_3];
  }

  if(var_0 hasheavyarmorinvulnerability()) {
    return [1, 1, 0];
  }

  var_11 = var_0 getheavyarmor();
  var_12 = heavyarmor_getdamagemodifier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  var_13 = var_2 * var_12;
  var_14 = var_3 * var_12;
  var_15 = var_13 + var_14;

  if(!var_10) {
    var_0 subtractheavyarmor(var_15);
  }

  if(var_0 hasheavyarmorinvulnerability()) {
    return [var_11, 1, 0];
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
  return isDefined(self.heavyarmor) && (self.heavyarmor.hp > 0 || scripts\mp\utility\game::istrue(self.heavyarmor.invulnerabilityframe));
}

hasheavyarmorinvulnerability() {
  return isDefined(self.heavyarmor) && scripts\mp\utility\game::istrue(self.heavyarmor.invulnerabilityframe);
}

heavyarmor_break() {
  self endon("disconnect");
  self endon("heavyArmor_removed");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    self.heavyarmor.invulnerabilityframe = 1;
  }

  self notify("heavyArmor_broken");
  waittillframeend;
  thread removeheavyarmor();
}

heavyarmor_getdamagemodifier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = [];

  if(scripts\mp\utility\game::issuperweapon(var_4)) {
    var_11[var_11.size] = 1.33;
  }

  if(isexplosivedamagemod(var_4)) {
    var_11[var_11.size] = 1.5;
  }

  if(var_4 == "MOD_MELEE") {
    var_11[var_11.size] = 1.5;
  }

  if(scripts\mp\utility\game::isheadshot(var_5, var_8, var_4, var_1)) {
    var_11[var_11.size] = 1.5;
  }

  var_12 = 1;

  foreach(var_14 in var_11) {
    if(var_14 > var_12) {
      var_14 = var_12;
    }
  }

  return var_12;
}