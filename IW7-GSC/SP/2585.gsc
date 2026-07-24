/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2585.gsc
**************************************/

_id_12F5C(var_0) {
  if(isDefined(anim._id_13CD3) && isDefined(self._id_72BA)) {
    scripts\asm\asm_bb::bb_clearweaponrequest();
    self[[anim._id_13CD3]]();
    return 0;
  }

  _id_98E2();

  if(scripts\asm\asm_bb::bb_isselfdestruct() || isDefined(scripts\aitypes\combat::_id_81F4())) {
    scripts\asm\asm_bb::bb_clearweaponrequest();
    return anim.success;
  }

  var_1 = 0;
  var_2 = _id_3EBC();

  if(isDefined(var_2)) {
    if(var_2 != self.weapon)
      var_1 = 1;

    scripts\asm\asm_bb::bb_requestweapon(var_2);
  } else
    scripts\asm\asm_bb::bb_clearweaponrequest();

  if(scripts\anim\utility_common::isasniper()) {
    if(var_1) {
      if(isDefined(self.weapon) && !scripts\anim\utility_common::issniperrifle(self.weapon) && isDefined(self.bt.shootparams))
        scripts\aitypes\combat::_id_FE5A(self.bt.shootparams);
    }

    if(isDefined(self.weapon) && scripts\anim\utility_common::issniperrifle(self.weapon) && isDefined(self.bt.shootparams) && !scripts\asm\shared\utility::isatcovernode()) {
      var_3 = undefined;

      if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos))
        var_3 = distancesquared(self.origin, self._blackboard.shootparams.pos);
      else if(isDefined(self.enemy))
        var_3 = distancesquared(self.origin, self.enemy.origin);

      if(var_3 < 262144)
        scripts\aitypes\combat::_id_FE5A(self.bt.shootparams);
    }
  } else if(isDefined(self.bt.shootparams) && isDefined(self.bt.shootparams._id_29AF) && self.bt.shootparams._id_29AF)
    scripts\aitypes\combat::_id_FE5A(self.bt.shootparams);

  return anim.success;
}

_id_98E2() {
  self._id_13CC3 = [];

  if(isDefined(self.primaryweapon) && self.primaryweapon != "none")
    self._id_13CC3[self._id_13CC3.size] = self.primaryweapon;

  if(isDefined(self.secondaryweapon) && self.secondaryweapon != "none")
    self._id_13CC3[self._id_13CC3.size] = self.secondaryweapon;

  if(isDefined(self._id_101B4) && self._id_101B4 != "none")
    self._id_13CC3[self._id_13CC3.size] = self._id_101B4;
}

_id_3EBC() {
  if(isDefined(self._id_72DE))
    return "pistol";

  if(isDefined(self._blackboard._id_5D3B))
    return "pistol";

  var_0 = 0;
  var_1 = undefined;

  foreach(var_3 in self._id_13CC3) {
    var_4 = weaponclass(var_3);
    var_5 = _id_67D7(var_4, var_3);

    if(var_5 > var_0) {
      var_0 = var_5;
      var_1 = var_4;
    }
  }

  return var_1;
}

_id_67D7(var_0, var_1) {
  if(var_0 == "pistol") {
    if(weaponclass(self.weapon) == "rocketlauncher" && self.a.rockets <= 0)
      return 1000;

    if(_id_391A(undefined) != anim.success)
      return 0;

    var_2 = scripts\anim\utility_common::isusingsidearm();
    var_3 = undefined;

    if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams.pos))
      var_3 = distancesquared(self.origin, self._blackboard.shootparams.pos);
    else if(var_2 && isDefined(self.enemy))
      var_3 = distancesquared(self.origin, self.enemy.origin);

    if(isDefined(var_3)) {
      var_4 = 409;
      var_5 = scripts\anim\utility_common::isasniper(0);

      if(var_5)
        var_4 = 512;

      if(var_2)
        var_4 = var_4 + 36;

      if(var_3 < var_4 * var_4) {
        if(var_5)
          return 1000;

        if(scripts\anim\utility_common::usingmg() && var_3 < 16384)
          return 1000;

        if(scripts\anim\utility_common::isusingprimary() && self.bulletsinclip != 0)
          return 10;

        return 1000;
      }
    }

    return 0;
  } else if(var_0 == "rocketlauncher") {
    if(self.a.rockets <= 0)
      return 0;

    return 100;
  } else
    return 100;

  return 100;
}

_id_9F5F(var_0) {
  if(scripts\anim\utility_common::isasniper())
    return anim.success;

  return anim.failure;
}

usingturret(var_0) {
  if(self.weapon == self._id_101B4 && self.weapon != "none")
    return anim.success;

  return anim.failure;
}

_id_100A7(var_0) {
  if(usingturret(var_0) == anim.success)
    return anim.failure;

  if(isDefined(self._id_72DE))
    return anim.success;

  if(_id_391A(var_0) != anim.success)
    return anim.failure;
}

_id_391A(var_0) {
  if(isDefined(self._id_C009))
    return anim.failure;

  if(scripts\asm\asm_bb::bb_moverequested())
    return anim.failure;

  var_1 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var_1) && distance(self.origin, var_1.origin) < 16)
    return anim.failure;

  if(isDefined(self.melee))
    return anim.failure;

  return anim.success;
}