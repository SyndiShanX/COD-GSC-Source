/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\heavyarmor.gsc
***********************************************/

addheavyarmor(var_0) {
  var_1 = self.heavyarmor;

  if(!isDefined(self.struct)) {
    var_1 = spawnStruct(self.heavyarmor);
    var_1.player = self;
    var_1.hp = 0;
    self.heavyarmor = var_1;
    var_1.hp = var_1.hp + var_0;
    self notify("_encstr_AAD611D0CA58CEBCA09CDADB9CBE5891325932");
  } else
    var_1.hp = var_1.hp + var_0;
}

subtractheavyarmor(var_0) {
  var_1 = self.heavyarmor;

  if(istrue(var_1.immunityframe)) {
    return;
  }
  if(var_1.hp > 0) {
    var_1.hp = max(0, var_1.hp - var_0);

    if(var_1.hp <= 0)
      thread heavyarmor_break();
  }
}

removeheavyarmor() {
  self notify("_encstr_A6851302293753D0997DCDC755415A4769ED9B5A91");
  self.heavyarmor = undefined;
}

heavyarmormodifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_2 <= 0 && var_3 <= 0)
    return [0, var_2, var_3];

  if(var_4 == "_encstr_AB590C99ED78875F650F3951034D")
    return [0, var_2, var_3];

  if(isDefined(var_1) && (var_1.classname == "_encstr_85FE0DD5727A27098513298817CA23" || var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0"))
    return [0, var_2, var_3];

  if(!var_0 hasheavyarmor())
    return [0, var_2, var_3];

  if(scripts\mp\utility\weapon::isbombsiteweapon(var_5))
    return [0, var_2, var_3];

  if(var_0 hasheavyarmorinvulnerability())
    return [1, 1, 0];

  var_11 = var_0 getheavyarmor();
  var_12 = heavyarmor_getdamagemodifier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  var_13 = var_2 * var_12;
  var_14 = var_3 * var_12;
  var_15 = var_13 + var_14;

  if(!var_10)
    var_0 subtractheavyarmor(var_15);

  if(var_0 hasheavyarmorinvulnerability())
    return [var_11, 1, 0];

  return [var_2 + var_3, 1, 0];
}

getheavyarmor() {
  if(!hasheavyarmor())
    return 0;

  return self.heavyarmor.hp;
}

hasheavyarmor() {
  return isDefined(self.heavyarmor) && (self.heavyarmor.hp > 0 || istrue(self.heavyarmor.invulnerabilityframe));
}

hasheavyarmorinvulnerability() {
  return isDefined(self.heavyarmor) && istrue(self.heavyarmor.invulnerabilityframe);
}

heavyarmor_break() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A6851302293753D0997DCDC755415A4769ED9B5A91");

  if(!scripts\mp\utility\game::isanymlgmatch())
    self.heavyarmor.invulnerabilityframe = 1;

  self notify("_encstr_A6031288D901B31387C8D58FB3E9C56B1F20519A");
  waittillframeend;
  thread removeheavyarmor();
}

heavyarmor_getdamagemodifier(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = [];

  if(scripts\mp\utility\weapon::issuperweapon(var_5))
    var_11[var_11.size] = 1.33;

  if(isexplosivedamagemod(var_4))
    var_11[var_11.size] = 1.5;

  if(var_4 == "_encstr_8DED0A21C79B660BC7588981")
    var_11[var_11.size] = 1.5;

  if(scripts\mp\utility\damage::isheadshot(var_8, var_4, var_1))
    var_11[var_11.size] = 1.5;

  var_12 = 1;

  foreach(var_14 in var_11) {
    if(var_14 > var_12)
      var_14 = var_12;
  }

  return var_12;
}