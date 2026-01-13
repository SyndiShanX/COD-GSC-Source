/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2569.gsc
************************/

func_E477(var_0) {
  return level.success;
}

func_E470(var_0) {
  return level.failure;
}

func_E475(var_0) {
  return level.running;
}

func_E478(var_0, var_1) {
  if(var_1 == 1) {
    return level.success;
  }

  return level.failure;
}

func_9FEE(var_0, var_1) {
  if(isDefined(var_1)) {
    return level.success;
  }

  return level.failure;
}

func_FAF6(var_0) {
  self.bt.instancedata[var_0] = [];
  self.bt.instancedata[var_0]["waitStartTime"] = gettime();
}

func_5AEA(var_0, var_1) {
  var_2 = self.bt.instancedata[var_0]["waitStartTime"];
  if(gettime() - var_2 < var_1) {
    return level.running;
  }

  return level.success;
}

func_8C0A(var_0, var_1) {
  var_2 = var_1;
  if(self getpersstat(var_2)) {
    return level.success;
  }

  return level.failure;
}

func_13157(var_0, var_1) {
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = var_1[2];
  if(var_3 <= var_2 && var_2 <= var_4) {
    return level.success;
  }

  return level.failure;
}

func_DC6A(var_0, var_1) {
  var_2 = var_1[0];
  var_3 = var_1[1];
  if(randomint(var_2) < var_3) {
    return level.success;
  }

  return level.failure;
}

cointoss(var_0) {
  if(randomint(100) < 50) {
    return level.success;
  }

  return level.failure;
}

func_9309(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = self;
  }

  return isalive(var_2);
}

func_9307(var_0) {
  if(scripts\asm\asm_bb::bb_isanimscripted()) {
    return level.success;
  }

  return level.failure;
}

func_930C(var_0) {
  if(scripts\asm\asm_bb::bb_isselfdestruct()) {
    return level.success;
  }

  return level.failure;
}