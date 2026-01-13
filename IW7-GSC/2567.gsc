/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 2567.gsc
***********************************************/

func_B29B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
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

func_97ED(var_0) {
  self.var_71A8 = ::func_7FD3;
  self.var_71AE = lib_0F3C::isaimedataimtarget;
  self.var_71A0 = ::func_4F66;
  self.var_71A6 = ::func_7EFC;

  if(isDefined(self.weapon)) {
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;
  } else {
    self.bulletsinclip = 0;
    self.primaryweapon = "none";
  }

  self.secondaryweapon = "none";
  self.var_101B4 = "none";
  anim.var_32BF = func_B29B(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim.var_6B93 = func_B29B(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim.var_F217 = func_B29B(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);

  if(!isDefined(anim.shootenemywrapper_func)) {
    anim.shootenemywrapper_func = ::func_FE9D;
  }

  if(!isDefined(anim.var_FED3)) {
    anim.var_FED3 = ::func_FED2;
  }

  self.var_A9ED = 0;
  self.var_504E = 55;
  self.var_129AF = 55;
  self.upaimlimit = -60;
  self.downaimlimit = 60;
  self.providecoveringfire = 0;
  self.var_DCAF = 256;
  self.var_B781 = 750;

  if(self.team == "allies") {
    self.suppressionthreshold = 0.5;
  } else {
    self.suppressionthreshold = 0.0;
  }

  func_F724();
  return anim.success;
}

func_F724() {
  anim.covercrouchleanpitch = 55;
  anim.var_1A52 = 10;
  anim.var_1A50 = 4096;
  anim.var_1A51 = 45;
  anim.var_1A44 = 20;
  anim.var_C88B = 25;
  anim.var_C889 = anim.var_1A50;
  anim.var_C88A = anim.var_1A51;
  anim.var_C87D = 30;
  anim.var_B480 = 65;
  anim.var_B47F = 65;
}

func_FA33() {
  self.var_B4C3 = 130;
  self.var_E878 = 0.461538;
  self.var_E876 = 0.3;
}

func_7FD3() {
  if(isDefined(self.var_10AB7) && self.var_10AB7) {
    return "sprint";
  }

  if(isDefined(self.grenade) && isDefined(self.enemy) && self.frontshieldanglecos == 1) {
    if(distancesquared(self.origin, self.enemy.origin) > 90000) {
      return "sprint";
    }
  }

  if(isDefined(self.var_527B)) {
    return self.var_527B;
  }

  if(isDefined(self.enemy) || isDefined(self.var_6571)) {
    return "combat";
  }

  return "walk";
}

func_4F66() {
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

func_FE9D(var_0) {
  self.var_A9ED = gettime();
  var_1 = lib_0F3C::func_811C();
  var_2 = lib_0F3C::func_811E(var_1);
  func_FED2(var_2, var_0);
}

func_FED2(var_0, var_1) {
  self shoot(1.0, var_0, 1, 0, 1);
}

func_7EFC() {
  if(isDefined(self.node)) {
    var_0 = self.node gethighestnodestance();

    if(var_0 == "prone" && self.unittype == "c6") {
      var_0 = "crouch";
    }

    return var_0;
  }

  return undefined;
}