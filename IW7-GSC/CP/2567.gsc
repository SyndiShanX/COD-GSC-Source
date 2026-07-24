/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2567.gsc
**************************************/

_id_B29B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = [];

  if(isDefined(var_0)) {
    var_14[0] = var_0;
  } else {
    return var_14;
  }

  if(isDefined(var_1)) {
    var_14[1] = var_1;
  } else {
    return var_14;
  }

  if(isDefined(var_2)) {
    var_14[2] = var_2;
  } else {
    return var_14;
  }

  if(isDefined(var_3)) {
    var_14[3] = var_3;
  } else {
    return var_14;
  }

  if(isDefined(var_4)) {
    var_14[4] = var_4;
  } else {
    return var_14;
  }

  if(isDefined(var_5)) {
    var_14[5] = var_5;
  } else {
    return var_14;
  }

  if(isDefined(var_6)) {
    var_14[6] = var_6;
  } else {
    return var_14;
  }

  if(isDefined(var_7)) {
    var_14[7] = var_7;
  } else {
    return var_14;
  }

  if(isDefined(var_8)) {
    var_14[8] = var_8;
  } else {
    return var_14;
  }

  if(isDefined(var_9)) {
    var_14[9] = var_9;
  } else {
    return var_14;
  }

  if(isDefined(var_10)) {
    var_14[10] = var_10;
  } else {
    return var_14;
  }

  if(isDefined(var_11)) {
    var_14[11] = var_11;
  } else {
    return var_14;
  }

  if(isDefined(var_12)) {
    var_14[12] = var_12;
  } else {
    return var_14;
  }

  if(isDefined(var_13)) {
    var_14[13] = var_13;
  }

  return var_14;
}

_id_97ED(var_0) {
  self._id_71A8 = ::_id_7FD3;
  self._id_71AE = _id_0F3C::isaimedataimtarget;
  self._id_71A0 = ::_id_4F66;
  self._id_71A6 = ::_id_7EFC;

  if(isDefined(self.weapon)) {
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;
  } else {
    self.bulletsinclip = 0;
    self.primaryweapon = "none";
  }

  self.secondaryweapon = "none";
  self._id_101B4 = "none";
  anim._id_32BF = _id_B29B(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim._id_6B93 = _id_B29B(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim._id_F217 = _id_B29B(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);

  if(!isDefined(anim.shootenemywrapper_func)) {
    anim.shootenemywrapper_func = ::_id_FE9D;
  }

  if(!isDefined(anim._id_FED3)) {
    anim._id_FED3 = ::_id_FED2;
  }

  self._id_A9ED = 0;
  self._id_504E = 55;
  self._id_129AF = 55;
  self.upaimlimit = -60;
  self.downaimlimit = 60;
  self.providecoveringfire = 0;
  self._id_DCAF = 256;
  self._id_B781 = 750;

  if(self.team == "allies") {
    self.suppressionthreshold = 0.5;
  } else {
    self.suppressionthreshold = 0.0;
  }

  _id_F724();
  return anim.success;
}

_id_F724() {
  anim.covercrouchleanpitch = 55;
  anim._id_1A52 = 10;
  anim._id_1A50 = 4096;
  anim._id_1A51 = 45;
  anim._id_1A44 = 20;
  anim._id_C88B = 25;
  anim._id_C889 = anim._id_1A50;
  anim._id_C88A = anim._id_1A51;
  anim._id_C87D = 30;
  anim._id_B480 = 65;
  anim._id_B47F = 65;
}

_id_FA33() {
  self._id_B4C3 = 130;
  self._id_E878 = 0.461538;
  self._id_E876 = 0.3;
}

_id_7FD3() {
  if(isDefined(self._id_10AB7) && self._id_10AB7) {
    return "sprint";
  }

  if(isDefined(self.grenade) && isDefined(self.enemy) && self.frontshieldanglecos == 1) {
    if(distancesquared(self.origin, self.enemy.origin) > 90000) {
      return "sprint";
    }
  }

  if(isDefined(self._id_527B)) {
    return self._id_527B;
  }

  if(isDefined(self.enemy) || isDefined(self._id_6571)) {
    return "combat";
  }

  return "walk";
}

_id_4F66() {
  var_0 = self.bulletsinclip;

  if(weaponclass(self.weapon) == "mg") {
    var_1 = randomfloat(10);

    if(var_1 < 3) {
      var_0 = randomintrange(2, 6);
    } else if(var_1 < 8) {
      var_0 = randomintrange(6, 12);
    } else {
      var_0 = randomintrange(12, 20);
    }
  }

  return var_0;
}

_id_FE9D(var_0) {
  self._id_A9ED = gettime();
  var_1 = _id_0F3C::_id_811C();
  var_2 = _id_0F3C::_id_811E(var_1);
  _id_FED2(var_2, var_0);
}

_id_FED2(var_0, var_1) {
  self shoot(1.0, var_0, 1, 0, 1);
}

_id_7EFC() {
  if(isDefined(self.node)) {
    var_0 = self.node gethighestnodestance();

    if(var_0 == "prone" && self.unittype == "c6") {
      var_0 = "crouch";
    }

    return var_0;
  }

  return undefined;
}