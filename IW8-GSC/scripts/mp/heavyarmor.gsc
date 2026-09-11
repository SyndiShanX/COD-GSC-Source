/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\heavyarmor.gsc
***********************************************/

function addheavyarmor(var0) {
  var1 = self.heavyarmor;

  if(!isDefined(self.struct)) {
    var1 = spawnStruct(self.heavyarmor);
    var1.player = self;
    var1.hp = 0;
    self.heavyarmor = var1;
    var1.hp += var0;
    self notify("heavyArmor_added");
    return;
  }

  var1.hp += var0;
}

function subtractheavyarmor(var0) {
  var1 = self.heavyarmor;

  if(istrue(var1.immunityframe)) {
    return;
  }

  if(var1.hp > 0) {
    var1.hp = max(0, var1.hp - var0);

    if(var1.hp <= 0) {
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

function heavyarmormodifydamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(var2 <= 0 && var3 <= 0) {
    return [0, var2, var3];
  }

  if(var4 == "MOD_SUICIDE") {
    return [0, var2, var3];
  }

  if(isDefined(var1) && (var1.classname == "trigger_hurt" || var1.classname == "worldspawn")) {
    return [0, var2, var3];
  }

  if(!hasheavyarmor(var0)) {
    return [0, var2, var3];
  }

  if(scripts\mp\utility\weapon::isbombsiteweapon(var5)) {
    return [0, var2, var3];
  }

  if(hasheavyarmorinvulnerability(var0)) {
    return [1, 1, 0];
  }

  var11 = getheavyarmor(var0);
  var12 = heavyarmor_getdamagemodifier(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
  var13 = var2 * var12;
  var14 = var3 * var12;
  var15 = var13 + var14;

  if(!var10) {
    subtractheavyarmor(var0, var15);
  }

  if(hasheavyarmorinvulnerability(var0)) {
    return [var11, 1, 0];
  }

  return [var2 + var3, 1, 0];
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

function heavyarmor_getdamagemodifier(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = [];

  if(scripts\mp\utility\weapon::issuperweapon(var5)) {
    GscBinSkip0(0x2e, var11.size, 1.33);
  }

  if(isexplosivedamagemod(var4)) {
    GscBinSkip0(0x2e, var11.size, 1.5);
  }

  if(var4 == "MOD_MELEE") {
    GscBinSkip0(0x2e, var11.size, 1.5);
  }

  if(scripts\mp\utility\damage::isheadshot(var8, var4, var1)) {
    GscBinSkip0(0x2e, var11.size, 1.5);
  }

  var12 = 1;

  foreach(var14 in var11) {
    if(var14 > var12) {
      var14 = var12;
    }
  }

  return var12;
}