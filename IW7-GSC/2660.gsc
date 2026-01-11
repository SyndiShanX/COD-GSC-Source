/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2660.gsc
************************/

func_4941(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.var_D928)) {
    level.var_D928 = [];
  }

  var_06 = spawnStruct();
  var_06.var_B437 = param_01;
  var_06.var_A017 = param_03;
  var_06.var_A01E = param_04;
  var_06.var_DB03 = param_05;
  var_06.var_D926 = [];
  foreach(var_08 in param_02) {
    var_06.var_D926[var_08] = [];
  }

  level.var_D928[param_00] = var_06;
}

func_16F6(param_00, param_01, param_02) {
  if(func_FF7D(param_01)) {
    func_DB03(param_01);
  }

  if(!func_37F4(param_00, param_01, param_02)) {
    return;
  }

  func_E044(param_00, param_01);
  if(func_FF84(param_01, param_02)) {
    func_E063(param_01, param_02);
  }

  func_16F7(param_00, param_01, param_02);
}

func_37F4(param_00, param_01, param_02) {
  if(func_7B3E(param_01, param_02) == func_7BE1(param_01)) {
    return 0;
  }

  return 1;
}

func_E043(param_00, param_01) {
  func_E044(param_00, param_01);
}

func_E044(param_00, param_01) {
  foreach(var_04, var_03 in level.var_D928[param_01].var_D926) {
    if(scripts\engine\utility::array_contains(var_03, param_00)) {
      level.var_D928[param_01].var_D926[var_04] = ::scripts\engine\utility::array_remove(var_03, param_00);
      [
        [func_7966(param_01)]
      ](param_00);
    }
  }
}

func_FF84(param_00, param_01) {
  if(func_9C99(param_00)) {
    return 1;
  }

  return 0;
}

func_9C99(param_00) {
  var_01 = 0;
  foreach(var_03 in level.var_D928[param_00].var_D926) {
    var_01 = var_01 + var_03.size;
  }

  return level.var_D928[param_00].var_B437 == var_01;
}

func_DB03(param_00) {
  foreach(var_03, var_02 in level.var_D928[param_00].var_D926) {
    level.var_D928[param_00].var_D926[var_03] = ::scripts\engine\utility::array_removeundefined(level.var_D928[param_00].var_D926[var_03]);
  }
}

func_7B3E(param_00, param_01) {
  var_02 = 0;
  foreach(var_05, var_04 in level.var_D928[param_00].var_D926) {
    if(var_05 == param_01) {
      break;
    }

    var_02 = var_02 + level.var_D928[param_00].var_D926[var_05].size;
  }

  return var_02;
}

func_E063(param_00, param_01) {
  var_02 = func_7CDF(param_00, param_01);
  func_E062(param_00, var_02);
}

func_7CDF(param_00, param_01) {
  var_02 = undefined;
  foreach(param_01, var_04 in level.var_D928[param_00].var_D926) {
    if(level.var_D928[param_00].var_D926[param_01].size > 0) {
      var_02 = param_01;
    }
  }

  return var_02;
}

func_16F7(param_00, param_01, param_02) {
  [
    [func_77D1(param_01)]
  ](param_00);
  level.var_D928[param_01].var_D926[param_02][level.var_D928[param_01].var_D926[param_02].size] = param_00;
}

func_E062(param_00, param_01) {
  var_02 = func_7B49(param_00, param_01);
  [
    [func_7966(param_00)]
  ](var_02);
  level.var_D928[param_00].var_D926[param_01] = ::scripts\engine\utility::array_remove(level.var_D928[param_00].var_D926[param_01], var_02);
}

func_FF7D(param_00) {
  return level.var_D928[param_00].var_DB03;
}

func_7B49(param_00, param_01) {
  return level.var_D928[param_00].var_D926[param_01][0];
}

func_7BE1(param_00) {
  return level.var_D928[param_00].var_B437;
}

func_77D1(param_00) {
  return level.var_D928[param_00].var_A017;
}

func_7966(param_00) {
  return level.var_D928[param_00].var_A01E;
}