/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1368.gsc
*********************************************/

lib_0558::func_4746(param_00, param_01, param_02) {
  var_03 = [];
  foreach(var_05 in param_00) {
    lib_050E::func_534D(var_05);
    if(var_05 lib_055A::func_905D() && var_05 lib_055A::func_905C(param_01, param_02)) {
      var_03[var_03.size] = var_05;
    }
  }

  if(var_03.size) {
    var_07 = lib_0558::func_80AF(var_03, param_01, param_02);
  } else {
    if(!isDefined(self.var_9070)) {
      self.var_9070 = spawnStruct();
    }

    var_07 = lib_050E::func_8398(self.var_01A7, param_01, self.var_9070);
  }

  return var_07;
}

lib_0558::func_80AF(param_00, param_01, param_02) {
  var_03 = param_00[0];
  foreach(var_05 in param_00) {
    lib_0558::func_80A9(var_05, param_01, param_02);
    if(!isDefined(var_03) || var_05.var_9AB8 > var_03.var_9AB8) {
      var_03 = var_05;
    }
  }

  return var_03;
}

lib_0558::func_80A9(param_00, param_01, param_02) {
  var_03 = lib_0558::func_80A3(2, ::lib_0558::func_766A, param_00);
  param_00.var_9AB8 = param_00.var_9AB8 + var_03;
  var_03 = lib_0558::func_80A3(1, ::lib_0558::func_144B, param_00);
  param_00.var_9AB8 = param_00.var_9AB8 + var_03;
  var_03 = lib_0558::func_80A3(6, ::lib_0558::func_6025, param_00, param_01, param_02);
  param_00.var_9AB8 = param_00.var_9AB8 + var_03;
}

lib_0558::func_6025(param_00, param_01, param_02) {
  if(param_00 lib_055A::func_905C(param_01, param_02)) {
    return 100;
  }

  return 0;
}

lib_0558::func_766A(param_00) {
  if(!isDefined(param_00.var_AC8A)) {
    return 0;
  }

  if(lib_055A::func_5780(param_00.var_AC8A)) {
    return 100;
  }

  return 0;
}

lib_0558::func_144B(param_00) {
  if(isDefined(param_00.var_5BE2)) {
    var_01 = gettime() - param_00.var_5BE2;
    if(var_01 > 30000) {
      return 100;
    }

    return var_01 / 30000 * 100;
  }

  return 100;
}

lib_0558::func_7665(param_00) {
  if(!isDefined(param_00.var_AC8A)) {
    return 0;
  }

  var_01 = lib_055A::func_45BF(param_00.var_AC8A);
  if(var_01 == 0) {
    return 0;
  }

  return 100 * 1 - var_01 * 0.15;
}

lib_0558::func_80A3(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_04)) {
    var_05 = [[param_01]](param_02, param_03, param_04);
  } else if(isDefined(param_04)) {
    var_05 = [[param_02]](param_03, param_04);
  } else {
    var_05 = [[param_02]](param_03);
  }

  var_05 = clamp(var_05, 0, 100);
  var_05 = var_05 * param_00;
  return var_05;
}