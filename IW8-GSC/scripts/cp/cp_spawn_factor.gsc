/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawn_factor.gsc
***********************************************/

function critical_factor(var_0, var_1) {
  var_2 = [[var_0]](var_1);
  var_2 = clamp(var_2, 0, 1000);
  return var_2;
}

function avoidgrenades(var_0) {
  foreach(var_2 in level.grenades) {
    if(!isDefined(var_2) || !isexplosivedangeroustoplayer(var_2, self)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_2.origin) < 122500) {
      return 0;
    }
  }

  return 1000;
}

function avoidmines(var_0) {
  var_1 = level.mines;

  if(isDefined(level.placed_crafted_traps)) {
    var_1 = scripts\engine\utility::array_combine(level.mines, level.placed_crafted_traps);
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !isexplosivedangeroustoplayer(var_3, self)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_3.origin) < 122500) {
      return 0;
    }
  }

  return 1000;
}

function isexplosivedangeroustoplayer(var_0) {
  if(!level.teambased || level.friendlyfire || !isDefined(var_0.team)) {
    return 1;
  }

  var_1 = undefined;

  if(isDefined(self.owner)) {
    if(var_0 == self.owner) {
      return 1;
    }

    var_1 = self.owner.team;
  }

  if(isDefined(var_1)) {
    return (var_1 != var_0.team);
  }

  return 1;
}

function avoidtelefrag(var_0) {
  if(isDefined(self.allowtelefrag)) {
    return 1000;
  }

  if(isDefined(var_0.allowtelefrag)) {
    return 1000;
  }

  if(positionwouldtelefrag(var_0.origin)) {
    return 0;
  }

  return 1000;
}

function spawn_point_too_far(var_0) {
  if(distancesquared(scripts\cp\utility::get_center_point_of_array(level.players), var_0.origin) >= 16777216) {
    return 0;
  }

  return 1000;
}