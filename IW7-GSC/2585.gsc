/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 2585.gsc
***********************************************/

func_12F5C(var_0) {
  if(isDefined(anim.var_13CD3) && isDefined(self.var_72BA)) {
    scripts\asm\asm_bb::bb_clearweaponrequest();
    self[[anim.var_13CD3]]();
    return 0;
  }

  func_98E2();

  if(scripts\asm\asm_bb::bb_isselfdestruct() || isDefined(scripts\aitypes\combat::makescrambler())) {
    scripts\asm\asm_bb::bb_clearweaponrequest();
    return anim.success;
  }

  var_1 = 0;
  var_2 = func_3EBC();

  if(isDefined(var_2)) {
    if(var_2 != self.weapon) {
      var_1 = 1;
    }

    scripts\asm\asm_bb::bb_requestweapon(var_2);
  } else
    scripts\asm\asm_bb::bb_clearweaponrequest();

  if(scripts\anim\utility_common::isasniper()) {
    if(var_1) {
      if(isDefined(self.weapon) && !scripts\anim\utility_common::issniperrifle(self.weapon) && isDefined(self.bt.shootparams)) {
        scripts\aitypes\combat::func_FE5A(self.bt.shootparams);
      }
    }

    if(isDefined(self.weapon) && scripts\anim\utility_common::issniperrifle(self.weapon) && isDefined(self.bt.shootparams) && !scripts\asm\shared\utility::isatcovernode()) {
      var_3 = undefined;

      if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos)) {
        var_3 = distancesquared(self.origin, self._blackboard.shootparams.pos);
      } else if(isDefined(self.enemy)) {
        var_3 = distancesquared(self.origin, self.enemy.origin);
      }

      if(var_3 < 262144) {
        scripts\aitypes\combat::func_FE5A(self.bt.shootparams);
      }
    }
  } else if(isDefined(self.bt.shootparams) && isDefined(self.bt.shootparams.var_29AF) && self.bt.shootparams.var_29AF)
    scripts\aitypes\combat::func_FE5A(self.bt.shootparams);

  return anim.success;
}

func_98E2() {
  self.var_13CC3 = [];

  if(isDefined(self.primaryweapon) && self.primaryweapon != "none") {
    self.var_13CC3[self.var_13CC3.size] = self.primaryweapon;
  }

  if(isDefined(self.secondaryweapon) && self.secondaryweapon != "none") {
    self.var_13CC3[self.var_13CC3.size] = self.secondaryweapon;
  }

  if(isDefined(self.var_101B4) && self.var_101B4 != "none") {
    self.var_13CC3[self.var_13CC3.size] = self.var_101B4;
  }
}

func_3EBC() {
  if(isDefined(self.var_72DE)) {
    return "pistol";
  }

  if(isDefined(self._blackboard.var_5D3B)) {
    return "pistol";
  }

  var_0 = 0;
  var_1 = undefined;

  foreach(var_3 in self.var_13CC3) {
    var_4 = weaponclass(var_3);
    var_5 = func_67D7(var_4, var_3);

    if(var_5 > var_0) {
      var_0 = var_5;
      var_1 = var_4;
    }
  }

  return var_1;
}

func_67D7(var_0, var_1) {
  if(var_0 == "pistol") {
    if(weaponclass(self.weapon) == "rocketlauncher" && self.a.rockets <= 0) {
      return 1000;
    }

    if(func_391A(undefined) != anim.success) {
      return 0;
    }

    var_2 = scripts\anim\utility_common::isusingsidearm();
    var_3 = undefined;

    if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos)) {
      var_3 = distancesquared(self.origin, self._blackboard.shootparams.pos);
    } else if(var_2 && isDefined(self.enemy)) {
      var_3 = distancesquared(self.origin, self.enemy.origin);
    }

    if(isDefined(var_3)) {
      var_4 = 409;
      var_5 = scripts\anim\utility_common::isasniper(0);

      if(var_5) {
        var_4 = 512;
      }

      if(var_2) {
        var_4 = var_4 + 36;
      }

      if(var_3 < var_4 * var_4) {
        if(var_5) {
          return 1000;
        }

        if(scripts\anim\utility_common::usingmg() && var_3 < 16384) {
          return 1000;
        }

        if(scripts\anim\utility_common::isusingprimary() && self.bulletsinclip != 0) {
          return 10;
        }

        return 1000;
      }
    }

    return 0;
  } else if(var_0 == "rocketlauncher") {
    if(self.a.rockets <= 0) {
      return 0;
    }

    return 100;
  } else
    return 100;

  return 100;
}

func_9F5F(var_0) {
  if(scripts\anim\utility_common::isasniper()) {
    return anim.success;
  }

  return anim.failure;
}

usingturret(var_0) {
  if(self.weapon == self.var_101B4 && self.weapon != "none") {
    return anim.success;
  }

  return anim.failure;
}

func_100A7(var_0) {
  if(usingturret(var_0) == anim.success) {
    return anim.failure;
  }

  if(isDefined(self.var_72DE)) {
    return anim.success;
  }

  if(func_391A(var_0) != anim.success) {
    return anim.failure;
  }
}

func_391A(var_0) {
  if(isDefined(self.var_C009)) {
    return anim.failure;
  }

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return anim.failure;
  }

  var_1 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var_1) && distance(self.origin, var_1.origin) < 16) {
    return anim.failure;
  }

  if(isDefined(self.melee)) {
    return anim.failure;
  }

  return anim.success;
}