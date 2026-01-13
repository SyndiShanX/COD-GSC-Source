/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\_id_0D5F.gsc
*********************************************/

func_9758() {
  if(!isDefined(level.var_10680)) {
    level.var_10680 = 250000;
  }
}

func_EC19(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = [[var_1]](var_2, var_3);
  } else {
    var_4 = [[var_2]](var_3);
  }

  var_4 = clamp(var_4, 0, 100);
  var_4 = var_4 * var_0;
  var_2.var_11A3A = var_2.var_11A3A + 100 * var_0;
  var_2.var_A9E9[self.team] = var_2.var_A9E9[self.team] + var_4;
  return var_4;
}

critical_factor(var_0, var_1) {
  var_2 = [[var_0]](var_1);
  var_2 = clamp(var_2, 0, 100);
  return var_2;
}

avoidcarepackages(var_0) {
  foreach(var_2 in level.carepackages) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_2.origin) < 22500) {
      return 0;
    }
  }

  return 100;
}

func_26B8(var_0) {
  foreach(var_2 in level.grenades) {
    if(!isDefined(var_2) || !var_2 isexplosivedangeroustoplayer(self)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_2.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

func_26BC(var_0) {
  var_1 = level.mines;
  if(isDefined(level.placed_crafted_traps)) {
    var_1 = scripts\engine\utility::array_combine(level.mines, level.placed_crafted_traps);
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !var_3 isexplosivedangeroustoplayer(self)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_3.origin) < 122500) {
      return 0;
    }
  }

  return 100;
}

isexplosivedangeroustoplayer(var_0) {
  if(!level.teambased || level.friendlyfire || !isDefined(var_0.team)) {
    return 1;
  }

  var_1 = undefined;
  if(isDefined(self.triggerportableradarping)) {
    if(var_0 == self.triggerportableradarping) {
      return 1;
    }

    var_1 = self.triggerportableradarping.team;
  }

  if(isDefined(var_1)) {
    return var_1 != var_0.team;
  }

  return 1;
}

func_26C4(var_0) {
  if(isDefined(self.var_1CAE)) {
    return 100;
  }

  if(isDefined(var_0.var_1CAE)) {
    return 100;
  }

  if(positionwouldtelefrag(var_0.origin)) {
    return 0;
  }

  return 100;
}

avoidsamespawn(var_0) {
  if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == var_0) {
    return 0;
  }

  return 100;
}

randomspawnscore(var_0) {
  return randomintrange(0, 99);
}

maxplayerspawninfluencedistsquared(var_0) {
  return 3240000;
}