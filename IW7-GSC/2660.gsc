/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2660.gsc
*********************************************/

func_4941(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.var_D928)) {
    level.var_D928 = [];
  }

  var_6 = spawnStruct();
  var_6.var_B437 = var_1;
  var_6.var_A017 = var_3;
  var_6.var_A01E = var_4;
  var_6.var_DB03 = var_5;
  var_6.var_D926 = [];
  foreach(var_8 in var_2) {
    var_6.var_D926[var_8] = [];
  }

  level.var_D928[var_0] = var_6;
}

func_16F6(var_0, var_1, var_2) {
  if(func_FF7D(var_1)) {
    func_DB03(var_1);
  }

  if(!func_37F4(var_0, var_1, var_2)) {
    return;
  }

  func_E044(var_0, var_1);
  if(func_FF84(var_1, var_2)) {
    func_E063(var_1, var_2);
  }

  func_16F7(var_0, var_1, var_2);
}

func_37F4(var_0, var_1, var_2) {
  if(func_7B3E(var_1, var_2) == func_7BE1(var_1)) {
    return 0;
  }

  return 1;
}

func_E043(var_0, var_1) {
  func_E044(var_0, var_1);
}

func_E044(var_0, var_1) {
  foreach(var_4, var_3 in level.var_D928[var_1].var_D926) {
    if(scripts\engine\utility::array_contains(var_3, var_0)) {
      level.var_D928[var_1].var_D926[var_4] = scripts\engine\utility::array_remove(var_3, var_0);
      [
        [func_7966(var_1)]
      ](var_0);
    }
  }
}

func_FF84(var_0, var_1) {
  if(func_9C99(var_0)) {
    return 1;
  }

  return 0;
}

func_9C99(var_0) {
  var_1 = 0;
  foreach(var_3 in level.var_D928[var_0].var_D926) {
    var_1 = var_1 + var_3.size;
  }

  return level.var_D928[var_0].var_B437 == var_1;
}

func_DB03(var_0) {
  foreach(var_3, var_2 in level.var_D928[var_0].var_D926) {
    level.var_D928[var_0].var_D926[var_3] = scripts\engine\utility::array_removeundefined(level.var_D928[var_0].var_D926[var_3]);
  }
}

func_7B3E(var_0, var_1) {
  var_2 = 0;
  foreach(var_5, var_4 in level.var_D928[var_0].var_D926) {
    if(var_5 == var_1) {
      break;
    }

    var_2 = var_2 + level.var_D928[var_0].var_D926[var_5].size;
  }

  return var_2;
}

func_E063(var_0, var_1) {
  var_2 = func_7CDF(var_0, var_1);
  func_E062(var_0, var_2);
}

func_7CDF(var_0, var_1) {
  var_2 = undefined;
  foreach(var_1, var_4 in level.var_D928[var_0].var_D926) {
    if(level.var_D928[var_0].var_D926[var_1].size > 0) {
      var_2 = var_1;
    }
  }

  return var_2;
}

func_16F7(var_0, var_1, var_2) {
  [[func_77D1(var_1)]](var_0);
  level.var_D928[var_1].var_D926[var_2][level.var_D928[var_1].var_D926[var_2].size] = var_0;
}

func_E062(var_0, var_1) {
  var_2 = func_7B49(var_0, var_1);
  [[func_7966(var_0)]](var_2);
  level.var_D928[var_0].var_D926[var_1] = scripts\engine\utility::array_remove(level.var_D928[var_0].var_D926[var_1], var_2);
}

func_FF7D(var_0) {
  return level.var_D928[var_0].var_DB03;
}

func_7B49(var_0, var_1) {
  return level.var_D928[var_0].var_D926[var_1][0];
}

func_7BE1(var_0) {
  return level.var_D928[var_0].var_B437;
}

func_77D1(var_0) {
  return level.var_D928[var_0].var_A017;
}

func_7966(var_0) {
  return level.var_D928[var_0].var_A01E;
}