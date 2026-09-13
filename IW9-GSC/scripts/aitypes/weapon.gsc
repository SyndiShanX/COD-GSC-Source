/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\weapon.gsc
***********************************************/

initweaponarray() {
  self.weapons = [];

  if(!isnullweapon(self.primaryweapon))
    self.weapons[self.weapons.size] = self.primaryweapon;

  if(!isnullweapon(self.secondaryweapon))
    self.weapons[self.weapons.size] = self.secondaryweapon;

  if(!isnullweapon(self.sidearm))
    self.weapons[self.weapons.size] = self.sidearm;
}

choosebestweapon() {
  if(istrue(self.forcesidearm))
    return "pistol";

  if(istrue(self._blackboard.droppedlmg))
    return "pistol";

  _id_053A4DA52F050A4F = 0;
  _id_21C4C58489D139F5 = undefined;

  foreach(weapon in self.weapons) {
    _id_0DD6BF5F9DBA888C = weaponclass(weapon);
    score = evalweaponscore(_id_0DD6BF5F9DBA888C, weapon);

    if(score > _id_053A4DA52F050A4F) {
      _id_053A4DA52F050A4F = score;
      _id_21C4C58489D139F5 = _id_0DD6BF5F9DBA888C;
    }
  }

  return _id_21C4C58489D139F5;
}

getsidearmdist() {
  _id_08465F7779F8A19A = _id_2B79931B08683E0A::isusingsidearm();
  _id_448C66DDC99A9ACC = 409;
  _id_EE026FC5E0F3F95A = self _meth_E8CA4080D02A0BB4(0);

  if(_id_EE026FC5E0F3F95A)
    _id_448C66DDC99A9ACC = 512;

  if(_id_08465F7779F8A19A)
    _id_448C66DDC99A9ACC = _id_448C66DDC99A9ACC + 36;

  return _id_448C66DDC99A9ACC;
}

withinswitchtopistoldist() {
  if(isDefined(self.enemy) && isDefined(self.sidearm) && !isnullweapon(self.sidearm) && !istrue(self.disablepistol)) {
    _id_448C66DDC99A9ACC = getsidearmdist();
    _id_6F1937277208C460 = distancesquared(self.origin, self.enemy.origin);
    return _id_6F1937277208C460 < _id_448C66DDC99A9ACC * _id_448C66DDC99A9ACC;
  }

  return 0;
}

evalweaponscore(_id_0DD6BF5F9DBA888C, weapon) {
  if(_id_0DD6BF5F9DBA888C == "pistol") {
    if(weaponclass(self.weapon) == "rocketlauncher" && self.rocketammo <= 0)
      return 1000;

    if(canswitchtosidearm(undefined) != anim.success)
      return 0;

    covernode = scripts\asm\asm_bb::bb_getcovernode();

    if(_id_2B79931B08683E0A::usingmg() && isDefined(covernode) && !self _meth_DC83DAA4D1EB7A5F(covernode))
      return 1000;

    if(checkcoverforsidearm(undefined) != anim.success)
      return 0;

    _id_C6E04DC8D8240B82 = withinswitchtopistoldist();
    _id_EE026FC5E0F3F95A = self _meth_E8CA4080D02A0BB4(0);

    if(_id_C6E04DC8D8240B82) {
      _id_6F1937277208C460 = distancesquared(self.origin, self.enemy.origin);

      if(_id_EE026FC5E0F3F95A)
        return 1000;

      if(_id_2B79931B08683E0A::usingmg() && _id_6F1937277208C460 < 16384)
        return 1000;

      if(_id_2B79931B08683E0A::isusingprimary() && scripts\aitypes\combat::hasatleastammo(0.1))
        return 10;

      return 1000;
    }

    return 0;
  } else if(_id_0DD6BF5F9DBA888C == "rocketlauncher") {
    if(self.rocketammo <= 0)
      return 0;

    return 100;
  } else
    return 100;

  return 100;
}

issniper(_id_B8EBE3F71A08AB40) {
  if(self _meth_E8CA4080D02A0BB4())
    return anim.success;

  return anim.failure;
}

usingsidearm(_id_B8EBE3F71A08AB40) {
  if(self.weapon == self.sidearm && !isnullweapon(self.weapon))
    return anim.success;

  return anim.failure;
}

shouldswitchtosidearm(_id_B8EBE3F71A08AB40) {
  if(usingsidearm(_id_B8EBE3F71A08AB40) == anim.success)
    return anim.failure;

  if(istrue(self.forcesidearm))
    return anim.success;

  if(canswitchtosidearm(_id_B8EBE3F71A08AB40) != anim.success)
    return anim.failure;

  if(checkcoverforsidearm(_id_B8EBE3F71A08AB40) != anim.success)
    return anim.failure;

  return anim.success;
}

canswitchtosidearm(_id_B8EBE3F71A08AB40) {
  if(istrue(self.disablepistol))
    return anim.failure;

  if(scripts\asm\asm_bb::bb_moverequested() && isDefined(self.pathgoalpos) && length2dsquared(self.velocity) > 1)
    return anim.failure;

  if(self._id_A97AC004F00C5DF9)
    return anim.failure;

  return anim.success;
}

checkcoverforsidearm(_id_B8EBE3F71A08AB40) {
  covernode = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(covernode) && distance(self.origin, covernode.origin) < 16)
    return anim.failure;

  return anim.success;
}