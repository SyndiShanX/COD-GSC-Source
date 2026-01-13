/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2567.gsc
************************/

func_B29B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  var_0E = [];
  if(isDefined(var_0)) {
    var_0E[0] = var_0;
  } else {
    return var_0E;
  }

  if(isDefined(var_1)) {
    var_0E[1] = var_1;
  } else {
    return var_0E;
  }

  if(isDefined(var_2)) {
    var_0E[2] = var_2;
  } else {
    return var_0E;
  }

  if(isDefined(var_3)) {
    var_0E[3] = var_3;
  } else {
    return var_0E;
  }

  if(isDefined(var_4)) {
    var_0E[4] = var_4;
  } else {
    return var_0E;
  }

  if(isDefined(var_5)) {
    var_0E[5] = var_5;
  } else {
    return var_0E;
  }

  if(isDefined(var_6)) {
    var_0E[6] = var_6;
  } else {
    return var_0E;
  }

  if(isDefined(var_7)) {
    var_0E[7] = var_7;
  } else {
    return var_0E;
  }

  if(isDefined(var_8)) {
    var_0E[8] = var_8;
  } else {
    return var_0E;
  }

  if(isDefined(var_9)) {
    var_0E[9] = var_9;
  } else {
    return var_0E;
  }

  if(isDefined(var_0A)) {
    var_0E[10] = var_0A;
  } else {
    return var_0E;
  }

  if(isDefined(var_0B)) {
    var_0E[11] = var_0B;
  } else {
    return var_0E;
  }

  if(isDefined(var_0C)) {
    var_0E[12] = var_0C;
  } else {
    return var_0E;
  }

  if(isDefined(var_0D)) {
    var_0E[13] = var_0D;
  }

  return var_0E;
}

func_97ED(var_0) {
  self.var_71A8 = ::func_7FD3;
  self.var_71AE = ::lib_0F3C::isaimedataimtarget;
  self.var_71A0 = ::func_4F66;
  self.var_71A6 = ::func_7EFC;
  if(isDefined(self.var_394)) {
    self.bulletsinclip = weaponclipsize(self.var_394);
    self.primaryweapon = self.var_394;
  } else {
    self.bulletsinclip = 0;
    self.primaryweapon = "none";
  }

  self.secondaryweapon = "none";
  self.var_101B4 = "none";
  anim.var_32BF = func_B29B(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim.var_6B93 = func_B29B(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim.var_F217 = func_B29B(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  if(!isDefined(level.shootenemywrapper_func)) {
    anim.shootenemywrapper_func = ::func_FE9D;
  }

  if(!isDefined(level.var_FED3)) {
    anim.var_FED3 = ::func_FED2;
  }

  self.var_A9ED = 0;
  self.var_504E = 55;
  self.var_129AF = 55;
  self.var_368 = -60;
  self.isbot = 60;
  self.assertmsg = 0;
  self.var_DCAF = 256;
  self.var_B781 = 750;
  if(self.team == "allies") {
    self.suppressionthreshold = 0.5;
  } else {
    self.suppressionthreshold = 0;
  }

  func_F724();
  return level.success;
}

func_F724() {
  anim.covercrouchleanpitch = 55;
  anim.var_1A52 = 10;
  anim.var_1A50 = 4096;
  anim.var_1A51 = 45;
  anim.var_1A44 = 20;
  anim.var_C88B = 25;
  anim.var_C889 = level.var_1A50;
  anim.var_C88A = level.var_1A51;
  anim.var_C87D = 30;
  anim.var_B480 = 65;
  anim.var_B47F = 65;
}

func_FA33() {
  self.var_B4C3 = 130;
  self.var_E878 = 0.4615385;
  self.var_E876 = 0.3;
}

func_7FD3() {
  if(isDefined(self.var_10AB7) && self.var_10AB7) {
    return "sprint";
  }

  if(isDefined(self.objective_position) && isDefined(self.isnodeoccupied) && self.objective_additionalcurrent == 1) {
    if(distancesquared(self.origin, self.isnodeoccupied.origin) > 90000) {
      return "sprint";
    }
  }

  if(isDefined(self.var_527B)) {
    return self.var_527B;
  }

  if(isDefined(self.isnodeoccupied) || isDefined(self.var_6571)) {
    return "combat";
  }

  return "walk";
}

func_4F66() {
  var_0 = self.bulletsinclip;
  if(weaponclass(self.var_394) == "mg") {
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
  var_1 = lib_0F3C::_meth_811C();
  var_2 = lib_0F3C::_meth_811E(var_1);
  func_FED2(var_2, var_0);
}

func_FED2(var_0, var_1) {
  self shoot(1, var_0, 1, 0, 1);
}

func_7EFC() {
  if(isDefined(self.target_getindexoftarget)) {
    var_0 = self.target_getindexoftarget gethighestnodestance();
    if(var_0 == "prone" && self.unittype == "c6") {
      var_0 = "crouch";
    }

    return var_0;
  }

  return undefined;
}