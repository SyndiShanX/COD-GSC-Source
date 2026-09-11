/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawn_factor.gsc
***********************************************/

function critical_factor(var0, var1) {
  var2 = [[var0]](var1);
  var2 = clamp(var2, 0, 1000);
  return var2;
}

function avoidgrenades(var0) {
  foreach(var2 in level.grenades) {
    if(!isDefined(var2) || !isexplosivedangeroustoplayer(var2, self)) {
      continue;
    }

    if(distancesquared(var0.origin, var2.origin) < 122500) {
      return 0;
    }
  }

  return 1000;
}

function avoidmines(var0) {
  var1 = level.mines;

  if(isDefined(level.placed_crafted_traps)) {
    var1 = scripts\engine\utility::array_combine(level.mines, level.placed_crafted_traps);
  }

  foreach(var3 in var1) {
    if(!isDefined(var3) || !isexplosivedangeroustoplayer(var3, self)) {
      continue;
    }

    if(distancesquared(var0.origin, var3.origin) < 122500) {
      return 0;
    }
  }

  return 1000;
}

function isexplosivedangeroustoplayer(var0) {
  if(!level.teambased || level.friendlyfire || !isDefined(var0.team)) {
    return 1;
  }

  var1 = undefined;

  if(isDefined(self.owner)) {
    if(var0 == self.owner) {
      return 1;
    }

    var1 = self.owner.team;
  }

  if(isDefined(var1)) {
    return (var1 != var0.team);
  }

  return 1;
}

function avoidtelefrag(var0) {
  if(isDefined(self.allowtelefrag)) {
    return 1000;
  }

  if(isDefined(var0.allowtelefrag)) {
    return 1000;
  }

  if(positionwouldtelefrag(var0.origin)) {
    return 0;
  }

  return 1000;
}

function spawn_point_too_far(var0) {
  if(distancesquared(scripts\cp\utility::get_center_point_of_array(level.players), var0.origin) >= 16777216) {
    return 0;
  }

  return 1000;
}