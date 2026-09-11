/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\combat_mp.gsc
***********************************************/

function makearray(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  var14 = [];

  if(isDefined(var0)) {
    GscBinSkip0(0x2e, 0, var0);
  }

  return var14;
}

function initcombatfunctions_mp(var0) {
  self.fnsetlaserflag = &noop;
  self.fnlaseron = &noop;
  self.fnlaseroff = &noop;

  if(isDefined(self.weapon)) {
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;
  } else {
    self.bulletsinclip = 0;
    self.primaryweapon = isundefinedweapon();
  }

  self.secondaryweapon = isundefinedweapon();
  anim.burstfirenumshots = makearray(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim.fastburstfirenumshots = makearray(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim.semifirenumshots = makearray(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);

  if(!isDefined(anim.shootenemywrapper_func)) {
    anim.shootenemywrapper_func = &shootenemywrapper_shootnotify;
  }

  if(!isDefined(anim.shootposwrapper_func)) {
    anim.shootposwrapper_func = &shootposwrapper;
  }

  self.lastshoottime = 0;
  self.defaultturnthreshold = 55;
  self.turnthreshold = 55;
  self.upaimlimit = -60;
  self.downaimlimit = 60;
  self.providecoveringfire = 0;
  self.randomgrenaderange = 256;
  self.minexposedgrenadedist = 750;
  self.fnsetstealthstate = &scripts\aitypes\stealth::setstealthstate;
  self.fnisinstealthidle = &scripts\aitypes\stealth::isidle;
  self.fnisinstealthinvestigate = &scripts\aitypes\stealth::isinvestigating;
  self.fnisinstealthhunt = &scripts\aitypes\stealth::ishunting;
  self.fnisinstealthcombat = &scripts\aitypes\stealth::iscombating;
  self.fnisinstealthidlescriptedanim = &scripts\aitypes\stealth::isidlescriptedanim;
  self.fnstealthupdatevisionforlighting = &scripts\aitypes\stealth::updatevisionforlighting;
  self.fnstealthisidlecurious = &scripts\aitypes\stealth::isidlecurious;
  self.fnresetmisstime = &resetmisstime;

  if(self.team == "allies") {
    self.suppressionthreshold = 0.5;
  } else {
    self.suppressionthreshold = 0;
  }

  setglobalaimsettings();
  return anim.success;
}

function noop(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  return false;
}

function setglobalaimsettings() {
  anim.covercrouchleanpitch = 55;
  anim.aimyawdifffartolerance = 10;
  anim.aimyawdiffclosedistsq = 4096;
  anim.aimyawdiffclosetolerance = 45;
  anim.aimpitchdifftolerance = 20;
  anim.painyawdifffartolerance = 25;
  anim.painyawdiffclosedistsq = anim.aimyawdiffclosedistsq;
  anim.painyawdiffclosetolerance = anim.aimyawdiffclosetolerance;
  anim.painpitchdifftolerance = 30;
  anim.maxanglecheckyawdelta = 65;
  anim.maxanglecheckpitchdelta = 65;
}

function resetmisstime() {
  scripts\common\gameskill::resetmisstime();
}

function shootenemywrapper_shootnotify(var0) {
  self.lastshoottime = gettime();
  var1 = scripts\asm\shared\utility::getshootfrompos();
  var2 = scripts\asm\shared\mp\utility::getshootpos(var1);
  shootposwrapper(var2, var0);
}

function shootposwrapper(var0, var1) {
  self shoot(1, var0, 1, 0, 1);
}