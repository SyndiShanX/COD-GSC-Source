/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\combat_mp.gsc
***********************************************/

makearray(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = [];

  if(isDefined(var_0))
    var_14[0] = var_0;
  else
    return var_14;

  if(isDefined(var_1))
    var_14[1] = var_1;
  else
    return var_14;

  if(isDefined(var_2))
    var_14[2] = var_2;
  else
    return var_14;

  if(isDefined(var_3))
    var_14[3] = var_3;
  else
    return var_14;

  if(isDefined(var_4))
    var_14[4] = var_4;
  else
    return var_14;

  if(isDefined(var_5))
    var_14[5] = var_5;
  else
    return var_14;

  if(isDefined(var_6))
    var_14[6] = var_6;
  else
    return var_14;

  if(isDefined(var_7))
    var_14[7] = var_7;
  else
    return var_14;

  if(isDefined(var_8))
    var_14[8] = var_8;
  else
    return var_14;

  if(isDefined(var_9))
    var_14[9] = var_9;
  else
    return var_14;

  if(isDefined(var_10))
    var_14[10] = var_10;
  else
    return var_14;

  if(isDefined(var_11))
    var_14[11] = var_11;
  else
    return var_14;

  if(isDefined(var_12))
    var_14[12] = var_12;
  else
    return var_14;

  if(isDefined(var_13))
    var_14[13] = var_13;

  return var_14;
}

initcombatfunctions_mp(var_0) {
  self.fnsetlaserflag = ::noop;
  self.fnlaseron = ::noop;
  self.fnlaseroff = ::noop;

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

  if(!isDefined(anim.shootenemywrapper_func))
    anim.shootenemywrapper_func = ::shootenemywrapper_shootnotify;

  if(!isDefined(anim.shootposwrapper_func))
    anim.shootposwrapper_func = ::shootposwrapper;

  self.lastshoottime = 0;
  self.defaultturnthreshold = 55;
  self.turnthreshold = 55;
  self.upaimlimit = -60;
  self.downaimlimit = 60;
  self.providecoveringfire = 0;
  self.randomgrenaderange = 256;
  self.minexposedgrenadedist = 750;
  self.fnsetstealthstate = scripts\aitypes\stealth::setstealthstate;
  self.fnisinstealthidle = scripts\aitypes\stealth::isidle;
  self.fnisinstealthinvestigate = scripts\aitypes\stealth::isinvestigating;
  self.fnisinstealthhunt = scripts\aitypes\stealth::ishunting;
  self.fnisinstealthcombat = scripts\aitypes\stealth::iscombating;
  self.fnisinstealthidlescriptedanim = scripts\aitypes\stealth::isidlescriptedanim;
  self.fnstealthupdatevisionforlighting = scripts\aitypes\stealth::updatevisionforlighting;
  self.fnstealthisidlecurious = scripts\aitypes\stealth::isidlecurious;
  self.fnresetmisstime = ::resetmisstime;

  if(self.team == "_encstr_9A8507BA4040188D08")
    self.suppressionthreshold = 0.5;
  else
    self.suppressionthreshold = 0.0;

  setglobalaimsettings();
  return anim.success;
}

noop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  return 0;
}

setglobalaimsettings() {
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

resetmisstime() {
  scripts\common\gameskill::resetmisstime();
}

shootenemywrapper_shootnotify(var_0) {
  self.lastshoottime = gettime();
  var_1 = scripts\asm\shared\utility::getshootfrompos();
  var_2 = scripts\asm\shared\mp\utility::getshootpos(var_1);
  shootposwrapper(var_2, var_0);
}

shootposwrapper(var_0, var_1) {
  self shoot(1.0, var_0, 1, 0, 1);
}