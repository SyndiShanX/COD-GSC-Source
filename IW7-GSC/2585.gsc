/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2585.gsc
************************/

func_12F5C(param_00) {
  if(isDefined(level.var_13CD3) && isDefined(self.var_72BA)) {
    scripts\asm\asm_bb::bb_clearweaponrequest();
    self[[level.var_13CD3]]();
    return 0;
  }

  func_98E2();
  if(scripts\asm\asm_bb::bb_isselfdestruct() || isDefined(scripts\aitypes\combat::makescrambler())) {
    scripts\asm\asm_bb::bb_clearweaponrequest();
    return level.success;
  }

  var_01 = 0;
  var_02 = func_3EBC();
  if(isDefined(var_02)) {
    if(var_02 != self.var_394) {
      var_01 = 1;
    }

    scripts\asm\asm_bb::bb_requestweapon(var_02);
  } else {
    scripts\asm\asm_bb::bb_clearweaponrequest();
  }

  if(scripts\anim\utility_common::isasniper()) {
    if(var_01) {
      if(isDefined(self.var_394) && !scripts\anim\utility_common::issniperrifle(self.var_394) && isDefined(self.var_3135.shootparams)) {
        scripts\aitypes\combat::func_FE5A(self.var_3135.shootparams);
      }
    }

    if(isDefined(self.var_394) && scripts\anim\utility_common::issniperrifle(self.var_394) && isDefined(self.var_3135.shootparams) && !scripts\asm\shared_utility::isatcovernode()) {
      var_03 = undefined;
      if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.pos)) {
        var_03 = distancesquared(self.origin, self.var_1198.shootparams.pos);
      } else if(isDefined(self.isnodeoccupied)) {
        var_03 = distancesquared(self.origin, self.isnodeoccupied.origin);
      }

      if(var_03 < 262144) {
        scripts\aitypes\combat::func_FE5A(self.var_3135.shootparams);
      }
    }
  } else if(isDefined(self.var_3135.shootparams) && isDefined(self.var_3135.shootparams.var_29AF) && self.var_3135.shootparams.var_29AF) {
    scripts\aitypes\combat::func_FE5A(self.var_3135.shootparams);
  }

  return level.success;
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

  if(isDefined(self.var_1198.var_5D3B)) {
    return "pistol";
  }

  var_00 = 0;
  var_01 = undefined;
  foreach(var_03 in self.var_13CC3) {
    var_04 = weaponclass(var_03);
    var_05 = func_67D7(var_04, var_03);
    if(var_05 > var_00) {
      var_00 = var_05;
      var_01 = var_04;
    }
  }

  return var_01;
}

func_67D7(param_00, param_01) {
  if(param_00 == "pistol") {
    if(weaponclass(self.var_394) == "rocketlauncher" && self.a.rockets <= 0) {
      return 1000;
    }

    if(func_391A(undefined) != level.success) {
      return 0;
    }

    var_02 = scripts\anim\utility_common::isusingsidearm();
    var_03 = undefined;
    if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.pos)) {
      var_03 = distancesquared(self.origin, self.var_1198.shootparams.pos);
    } else if(var_02 && isDefined(self.isnodeoccupied)) {
      var_03 = distancesquared(self.origin, self.isnodeoccupied.origin);
    }

    if(isDefined(var_03)) {
      var_04 = 409;
      var_05 = scripts\anim\utility_common::isasniper(0);
      if(var_05) {
        var_04 = 512;
      }

      if(var_02) {
        var_04 = var_04 + 36;
      }

      if(var_03 < var_04 * var_04) {
        if(var_05) {
          return 1000;
        }

        if(scripts\anim\utility_common::usingmg() && var_03 < 16384) {
          return 1000;
        }

        if(scripts\anim\utility_common::isusingprimary() && self.bulletsinclip != 0) {
          return 10;
        }

        return 1000;
      }
    }

    return 0;
  } else if(var_02 == "rocketlauncher") {
    if(self.a.rockets <= 0) {
      return 0;
    }

    return 100;
  } else {
    return 100;
  }

  return 100;
}

func_9F5F(param_00) {
  if(scripts\anim\utility_common::isasniper()) {
    return level.success;
  }

  return level.failure;
}

usingturret(param_00) {
  if(self.var_394 == self.var_101B4 && self.var_394 != "none") {
    return level.success;
  }

  return level.failure;
}

func_100A7(param_00) {
  if(usingturret(param_00) == level.success) {
    return level.failure;
  }

  if(isDefined(self.var_72DE)) {
    return level.success;
  }

  if(func_391A(param_00) != level.success) {
    return level.failure;
  }
}

func_391A(param_00) {
  if(isDefined(self.var_C009)) {
    return level.failure;
  }

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return level.failure;
  }

  var_01 = scripts\asm\asm_bb::bb_getcovernode();
  if(isDefined(var_01) && distance(self.origin, var_01.origin) < 16) {
    return level.failure;
  }

  if(isDefined(self.melee)) {
    return level.failure;
  }

  return level.success;
}