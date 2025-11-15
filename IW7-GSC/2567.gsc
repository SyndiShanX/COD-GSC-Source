/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2567.gsc
************************/

func_B29B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  var_0E = [];
  if(isDefined(param_00)) {
    var_0E[0] = param_00;
  } else {
    return var_0E;
  }

  if(isDefined(param_01)) {
    var_0E[1] = param_01;
  } else {
    return var_0E;
  }

  if(isDefined(param_02)) {
    var_0E[2] = param_02;
  } else {
    return var_0E;
  }

  if(isDefined(param_03)) {
    var_0E[3] = param_03;
  } else {
    return var_0E;
  }

  if(isDefined(param_04)) {
    var_0E[4] = param_04;
  } else {
    return var_0E;
  }

  if(isDefined(param_05)) {
    var_0E[5] = param_05;
  } else {
    return var_0E;
  }

  if(isDefined(param_06)) {
    var_0E[6] = param_06;
  } else {
    return var_0E;
  }

  if(isDefined(param_07)) {
    var_0E[7] = param_07;
  } else {
    return var_0E;
  }

  if(isDefined(param_08)) {
    var_0E[8] = param_08;
  } else {
    return var_0E;
  }

  if(isDefined(param_09)) {
    var_0E[9] = param_09;
  } else {
    return var_0E;
  }

  if(isDefined(param_0A)) {
    var_0E[10] = param_0A;
  } else {
    return var_0E;
  }

  if(isDefined(param_0B)) {
    var_0E[11] = param_0B;
  } else {
    return var_0E;
  }

  if(isDefined(param_0C)) {
    var_0E[12] = param_0C;
  } else {
    return var_0E;
  }

  if(isDefined(param_0D)) {
    var_0E[13] = param_0D;
  }

  return var_0E;
}

func_97ED(param_00) {
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
  var_00 = self.bulletsinclip;
  if(weaponclass(self.var_394) == "mg") {
    var_01 = randomfloat(10);
    if(var_01 < 3) {
      var_00 = randomintrange(2, 6);
    } else if(var_01 < 8) {
      var_00 = randomintrange(6, 12);
    } else {
      var_00 = randomintrange(12, 20);
    }
  }

  return var_00;
}

func_FE9D(param_00) {
  self.var_A9ED = gettime();
  var_01 = lib_0F3C::_meth_811C();
  var_02 = lib_0F3C::_meth_811E(var_01);
  func_FED2(var_02, param_00);
}

func_FED2(param_00, param_01) {
  self shoot(1, param_00, 1, 0, 1);
}

func_7EFC() {
  if(isDefined(self.target_getindexoftarget)) {
    var_00 = self.target_getindexoftarget gethighestnodestance();
    if(var_00 == "prone" && self.unittype == "c6") {
      var_00 = "crouch";
    }

    return var_00;
  }

  return undefined;
}