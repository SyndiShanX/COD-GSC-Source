/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2569.gsc
************************/

func_E477(param_00) {
  return level.success;
}

func_E470(param_00) {
  return level.failure;
}

func_E475(param_00) {
  return level.running;
}

func_E478(param_00, param_01) {
  if(param_01 == 1) {
    return level.success;
  }

  return level.failure;
}

func_9FEE(param_00, param_01) {
  if(isDefined(param_01)) {
    return level.success;
  }

  return level.failure;
}

func_FAF6(param_00) {
  self.var_3135.instancedata[param_00] = [];
  self.var_3135.instancedata[param_00]["waitStartTime"] = gettime();
}

func_5AEA(param_00, param_01) {
  var_02 = self.var_3135.instancedata[param_00]["waitStartTime"];
  if(gettime() - var_02 < param_01) {
    return level.running;
  }

  return level.success;
}

func_8C0A(param_00, param_01) {
  var_02 = param_01;
  if(self getpersstat(var_02)) {
    return level.success;
  }

  return level.failure;
}

func_13157(param_00, param_01) {
  var_02 = param_01[0];
  var_03 = param_01[1];
  var_04 = param_01[2];
  if(var_03 <= var_02 && var_02 <= var_04) {
    return level.success;
  }

  return level.failure;
}

func_DC6A(param_00, param_01) {
  var_02 = param_01[0];
  var_03 = param_01[1];
  if(randomint(var_02) < var_03) {
    return level.success;
  }

  return level.failure;
}

cointoss(param_00) {
  if(randomint(100) < 50) {
    return level.success;
  }

  return level.failure;
}

func_9309(param_00, param_01) {
  if(isDefined(param_01)) {
    var_02 = param_01;
  } else {
    var_02 = self;
  }

  return isalive(var_02);
}

func_9307(param_00) {
  if(scripts\asm\asm_bb::bb_isanimscripted()) {
    return level.success;
  }

  return level.failure;
}

func_930C(param_00) {
  if(scripts\asm\asm_bb::bb_isselfdestruct()) {
    return level.success;
  }

  return level.failure;
}