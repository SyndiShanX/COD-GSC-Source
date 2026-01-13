/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2578.gsc
************************/

func_C565(var_0) {
  if(isDefined(self.var_C9B4)) {
    return level.success;
  }

  return level.failure;
}

func_F7B2(var_0) {
  var_1 = self.var_C9B4;
  if(!isDefined(var_1.var_D648) || !isDefined(var_1.var_D642) || !isDefined(var_1.var_1119D)) {
    return level.failure;
  }

  if(var_1.var_1119D == "loop") {
    var_1.var_D642 = var_1.var_D642 + 1;
    if(var_1.var_D642 >= var_1.var_D648.size) {
      var_1.var_D642 = 0;
    }
  } else if(var_1.var_1119D == "bounce") {
    if(!isDefined(var_1.var_54DA)) {
      var_1.var_54DA = 1;
    }

    var_1.var_D642 = var_1.var_D642 + var_1.var_54DA;
    if(var_1.var_D642 >= var_1.var_D648.size) {
      var_1.var_D642 = var_1.var_D648.size - 2;
      var_1.var_54DA = -1;
    } else if(var_1.var_D642 < 0) {
      var_1.var_D642 = 1;
      var_1.var_54DA = 1;
    }
  }

  self give_more_perk(var_1.var_D648[var_1.var_D642].var_D6A8);
  return level.success;
}

allowreload(var_0, var_1) {
  var_2 = self.var_C9B4;
  var_3 = var_2.var_D648[var_2.var_D642];
  var_4 = distancesquared(var_3, self.origin);
  var_5 = var_1;
  if(var_5 < 1) {
    var_5 = 1;
  }

  if(var_4 <= var_5 * var_5) {
    return level.success;
  }

  return level.running;
}

func_9ED9(var_0, var_1) {
  var_2 = var_1;
  var_3 = self.var_C9B4;
  var_4 = var_3.var_D648[var_3.var_D642];
  if(var_4.var_1119D == var_2) {
    return level.success;
  }
}

func_D4A0(var_0) {
  var_1 = self.var_C9B4;
  var_2 = var_1.var_D648[var_1.var_D642].var_92F3;
  if(!isDefined(var_2)) {
    return level.failure;
  }

  return level.running;
}