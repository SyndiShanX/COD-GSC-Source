/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\weapon.gsc
***********************************************/

updateweapon(var_0) {
  if(isDefined(anim.weaponstowfunction) && isDefined(self.forcedweapon)) {
    scripts\asm\asm_bb::bb_clearweaponrequest();
    self[[anim.weaponstowfunction]]();
    return anim.success;
  }

  if(istrue(self.runngun) && !scripts\aitypes\combat::hasatleastammo(0.2))
    scripts\aitypes\combat::reload_cheatammo();

  return anim.failure;
}

initweaponarray() {
  self.weapons = [];

  if(!nullweapon(self.primaryweapon))
    self.weapons[self.weapons.size] = self.primaryweapon;

  if(!nullweapon(self.secondaryweapon))
    self.weapons[self.weapons.size] = self.secondaryweapon;

  if(!nullweapon(self.sidearm))
    self.weapons[self.weapons.size] = self.sidearm;
}

choosebestweapon() {
  if(istrue(self.forcesidearm))
    return "pistol";

  if(istrue(self._blackboard.droppedlmg))
    return "pistol";

  var_0 = 0;
  var_1 = undefined;

  foreach(var_3 in self.weapons) {
    var_4 = weaponclass(var_3);
    var_5 = evalweaponscore(var_4, var_3);

    if(var_5 > var_0) {
      var_0 = var_5;
      var_1 = var_4;
    }
  }

  return var_1;
}

getsidearmdist() {
  var_0 = scripts\anim\utility_common.gsc::isusingsidearm();
  var_1 = 409;
  var_2 = scripts\anim\utility_common.gsc::isasniper(0);

  if(var_2)
    var_1 = 512;

  if(var_0)
    var_1 = var_1 + 36;

  return var_1;
}

withinswitchtopistoldist() {
  if(isDefined(self.enemy) && isDefined(self.sidearm) && !nullweapon(self.sidearm) && !istrue(self.disablepistol)) {
    var_0 = getsidearmdist();
    var_1 = distancesquared(self.origin, self.enemy.origin);
    return var_1 < var_0 * var_0;
  }

  return 0;
}

evalweaponscore(var_0, var_1) {
  if(var_0 == "pistol") {
    if(weaponclass(self.weapon) == "rocketlauncher" && self.rocketammo <= 0)
      return 1000;

    if(canswitchtosidearm(undefined) != anim.success)
      return 0;

    var_2 = scripts\asm\asm_bb::bb_getcovernode();

    if(scripts\anim\utility_common.gsc::usingmg() && isDefined(var_2) && !self iscovervalidagainstenemy(var_2))
      return 1000;

    if(checkcoverforsidearm(undefined) != anim.success)
      return 0;

    var_3 = withinswitchtopistoldist();
    var_4 = scripts\anim\utility_common.gsc::isasniper(0);

    if(var_3) {
      var_5 = distancesquared(self.origin, self.enemy.origin);

      if(var_4)
        return 1000;

      if(scripts\anim\utility_common.gsc::usingmg() && var_5 < 16384)
        return 1000;

      if(scripts\anim\utility_common.gsc::isusingprimary() && scripts\aitypes\combat::hasatleastammo(0.1))
        return 10;

      return 1000;
    }

    return 0;
  } else if(var_0 == "rocketlauncher") {
    if(self.rocketammo <= 0)
      return 0;

    return 100;
  } else
    return 100;

  return 100;
}

issniper(var_0) {
  if(scripts\anim\utility_common.gsc::isasniper())
    return anim.success;

  return anim.failure;
}

usingsidearm(var_0) {
  if(self.weapon == self.sidearm && !nullweapon(self.weapon))
    return anim.success;

  return anim.failure;
}

shouldswitchtosidearm(var_0) {
  if(usingsidearm(var_0) == anim.success)
    return anim.failure;

  if(istrue(self.forcesidearm))
    return anim.success;

  if(canswitchtosidearm(var_0) != anim.success)
    return anim.failure;

  if(checkcoverforsidearm(var_0) != anim.success)
    return anim.failure;

  return anim.success;
}

canswitchtosidearm(var_0) {
  if(istrue(self.disablepistol))
    return anim.failure;

  if(scripts\asm\asm_bb::bb_moverequested() && isDefined(self.pathgoalpos) && length2dsquared(self.velocity) > 1)
    return anim.failure;

  if(isDefined(self.melee))
    return anim.failure;

  return anim.success;
}

checkcoverforsidearm(var_0) {
  var_1 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var_1) && distance(self.origin, var_1.origin) < 16)
    return anim.failure;

  return anim.success;
}

weaponcanmelee() {
  if(isDefined(self.sidearm) && isDefined(self.weapon) && self.weapon == self.sidearm && (istrue(self.forcesidearm) || istrue(self._blackboard.droppedlmg)))
    return 0;

  return 1;
}