/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2745.gsc
***************************************/

addheavyarmor(var_00) {
  var_01 = self.heavyarmor;

  if(!isDefined(self.struct)) {
    var_01 = spawnStruct(self.heavyarmor);
    var_1.player = self;
    var_1.hp = 0;
    self.heavyarmor = var_01;
    var_1.hp = var_1.hp + var_00;
    self notify("heavyArmor_added");
  } else
    var_1.hp = var_1.hp + var_00;
}

subtractheavyarmor(var_00) {
  var_01 = self.heavyarmor;

  if(scripts\mp\utility\game::istrue(var_1.func_9344)) {
    return;
  }
  if(var_1.hp > 0) {
    var_1.hp = max(0, var_1.hp - var_00);
    scripts\mp\missions::func_D991("ch_heavy_armor_absorb", var_00);

    if(var_1.hp <= 0)
      thread heavyarmor_break();
  }
}

removeheavyarmor() {
  self notify("heavyArmor_removed");
  self.heavyarmor = undefined;
}

heavyarmormodifydamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(var_02 <= 0 && var_03 <= 0)
    return [0, var_02, var_03];

  if(var_04 == "MOD_SUICIDE")
    return [0, var_02, var_03];

  if(isDefined(var_01) && (var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn"))
    return [0, var_02, var_03];

  if(!var_00 hasheavyarmor())
    return [0, var_02, var_03];

  if(scripts\mp\utility\game::isbombsiteweapon(var_05))
    return [0, var_02, var_03];

  if(var_00 hasheavyarmorinvulnerability())
    return [1, 1, 0];

  var_11 = var_00 getheavyarmor();
  var_12 = heavyarmor_getdamagemodifier(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
  var_13 = var_02 * var_12;
  var_14 = var_03 * var_12;
  var_15 = var_13 + var_14;

  if(!var_10)
    var_00 subtractheavyarmor(var_15);

  if(var_00 hasheavyarmorinvulnerability())
    return [var_11, 1, 0];

  return [var_02 + var_03, 1, 0];
}

getheavyarmor() {
  if(!hasheavyarmor())
    return 0;

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

  if(!scripts\mp\utility\game::isanymlgmatch())
    self.heavyarmor.invulnerabilityframe = 1;

  self notify("heavyArmor_broken");
  waittillframeend;
  thread removeheavyarmor();
}

heavyarmor_getdamagemodifier(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  var_11 = [];

  if(scripts\mp\utility\game::issuperweapon(var_04))
    var_11[var_11.size] = 1.33;

  if(isexplosivedamagemod(var_04))
    var_11[var_11.size] = 1.5;

  if(var_04 == "MOD_MELEE")
    var_11[var_11.size] = 1.5;

  if(scripts\mp\utility\game::isheadshot(var_05, var_08, var_04, var_01))
    var_11[var_11.size] = 1.5;

  var_12 = 1;

  foreach(var_14 in var_11) {
    if(var_14 > var_12)
      var_14 = var_12;
  }

  return var_12;
}