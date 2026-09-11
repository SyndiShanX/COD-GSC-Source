/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\weapon.gsc
***********************************************/

function updateweapon(var0) {
  if(isDefined(anim.weaponstowfunction) && isDefined(self.forcedweapon)) {
    scripts\asm\asm_bb::bb_clearweaponrequest();
    self[[anim.weaponstowfunction]]();
    return anim.success;
  }

  if(istrue(self.runngun) && !scripts\aitypes\combat::hasatleastammo(0.2)) {
    scripts\aitypes\combat::reload_cheatammo();
  }

  return anim.failure;
}

function initweaponarray() {
  self.weapons = [];

  if(!nullweapon(self.primaryweapon)) {
    self.weapons[self.weapons.size] = self.primaryweapon;
  }

  if(!nullweapon(self.secondaryweapon)) {
    self.weapons[self.weapons.size] = self.secondaryweapon;
  }

  if(!nullweapon(self.sidearm)) {
    self.weapons[self.weapons.size] = self.sidearm;
    return;
  }
}

function choosebestweapon() {
  if(istrue(self.forcesidearm)) {
    return "pistol";
  }

  if(istrue(self._blackboard.droppedlmg)) {
    return "pistol";
  }

  var0 = 0;
  var1 = undefined;

  foreach(var3 in self.weapons) {
    var4 = weaponclass(var3);
    var5 = evalweaponscore(var4, var3);

    if(var5 > var0) {
      var0 = var5;
      var1 = var4;
    }
  }

  return var1;
}

function getsidearmdist() {
  var0 = scripts\anim\utility_common::isusingsidearm();
  var1 = 409;
  var2 = scripts\anim\utility_common::isasniper(0);

  if(var2) {
    var1 = 512;
  }

  if(var0) {
    var1 += 36;
  }

  return var1;
}

function withinswitchtopistoldist() {
  if(isDefined(self.enemy) && isDefined(self.sidearm) && !nullweapon(self.sidearm) && !istrue(self.disablepistol)) {
    var0 = getsidearmdist();
    var1 = distancesquared(self.origin, self.enemy.origin);
    return (var1 < var0 * var0);
  }

  return false;
}

function evalweaponscore(var0, var1) {
  if(var0 == "pistol") {
    if(weaponclass(self.weapon) == "rocketlauncher" && self.rocketammo <= 0) {
      return 1000;
    }

    if(canswitchtosidearm(undefined) != anim.success) {
      return 0;
    }

    var2 = scripts\asm\asm_bb::bb_getcovernode();

    if(scripts\anim\utility_common::usingmg() && isDefined(var2) && !self iscovervalidagainstenemy(var2)) {
      return 1000;
    }

    if(checkcoverforsidearm(undefined) != anim.success) {
      return 0;
    }

    var3 = withinswitchtopistoldist();
    var4 = scripts\anim\utility_common::isasniper(0);

    if(var3) {
      var5 = distancesquared(self.origin, self.enemy.origin);

      if(var4) {
        return 1000;
      }

      if(scripts\anim\utility_common::usingmg() && var5 < 16384) {
        return 1000;
      }

      if(scripts\anim\utility_common::isusingprimary() && scripts\aitypes\combat::hasatleastammo(0.1)) {
        return 10;
      }

      return 1000;
    }

    return 0;
  } else if(var4 == "rocketlauncher") {
    if(self.rocketammo <= 0) {
      return 0;
    }

    return 100;
  } else {
    return 100;
  }

  return 100;
}

function issniper(var0) {
  if(scripts\anim\utility_common::isasniper()) {
    return anim.success;
  }

  return anim.failure;
}

function usingsidearm(var0) {
  if(self.weapon == self.sidearm && !nullweapon(self.weapon)) {
    return anim.success;
  }

  return anim.failure;
}

function shouldswitchtosidearm(var0) {
  if(usingsidearm(var0) == anim.success) {
    return anim.failure;
  }

  if(istrue(self.forcesidearm)) {
    return anim.success;
  }

  if(canswitchtosidearm(var0) != anim.success) {
    return anim.failure;
  }

  if(checkcoverforsidearm(var0) != anim.success) {
    return anim.failure;
  }

  return anim.success;
}

function canswitchtosidearm(var0) {
  if(istrue(self.disablepistol)) {
    return anim.failure;
  }

  if(scripts\asm\asm_bb::bb_moverequested() && isDefined(self.pathgoalpos) && length2dsquared(self.velocity) > 1) {
    return anim.failure;
  }

  if(isDefined(self.melee)) {
    return anim.failure;
  }

  return anim.success;
}

function checkcoverforsidearm(var0) {
  var1 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var1) && distance(self.origin, var1.origin) < 16) {
    return anim.failure;
  }

  return anim.success;
}

function weaponcanmelee() {
  if(isDefined(self.sidearm) && isDefined(self.weapon) && self.weapon == self.sidearm && (istrue(self.forcesidearm) || istrue(self._blackboard.droppedlmg))) {
    return false;
  }

  return true;
}