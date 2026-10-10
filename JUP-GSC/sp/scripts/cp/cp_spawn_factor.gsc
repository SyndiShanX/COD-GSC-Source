/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_spawn_factor.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_spawn_factor;

function critical_factor(var_e2cadc5bf4175e47, spawnpoint) {
  scorefactor = [[var_e2cadc5bf4175e47]](spawnpoint);
  scorefactor = clamp(scorefactor, 0, 1000);
  return scorefactor;
}

function avoidgrenades(spawnpoint) {
  foreach(grenade in level.grenades) {
    if(!isDefined(grenade) || !grenade isexplosivedangeroustoplayer(self)) {
      continue;
    }

    if(distancesquared(spawnpoint.origin, grenade.origin) < 122500) {
      return 0;
    }
  }

  return 1000;
}

function avoidmines(spawnpoint) {
  var_4e5da354865df1fd = level.mines;

  if(isDefined(level.placed_crafted_traps)) {
    var_4e5da354865df1fd = array_combine(level.mines, level.placed_crafted_traps);
  }

  foreach(explosive in var_4e5da354865df1fd) {
    if(!isDefined(explosive) || !explosive isexplosivedangeroustoplayer(self)) {
      continue;
    }

    if(distancesquared(spawnpoint.origin, explosive.origin) < 122500) {
      return 0;
    }
  }

  return 1000;
}

function isexplosivedangeroustoplayer(player) {
  if(!level.teambased || level.friendlyfire || !isDefined(player.team)) {
    return 1;
  }

  explosiveteam = undefined;

  if(isDefined(self.owner)) {
    if(player == self.owner) {
      return 1;
    }

    explosiveteam = self.owner.team;
  }

  if(isDefined(explosiveteam)) {
    return (explosiveteam != player.team);
  }

  return 1;
}

function avoidtelefrag(spawnpoint) {
  if(isDefined(self.allowtelefrag)) {
    return 1000;
  }

  if(isDefined(spawnpoint.allowtelefrag)) {
    return 1000;
  }

  if(positionwouldtelefrag(spawnpoint.origin)) {
    return 0;
  }

  return 1000;
}

function spawn_point_too_far(spawnpoint) {
  if(distancesquared(get_center_point_of_array(level.players), spawnpoint.origin) >= 16777216) {
    return 0;
  }

  return 1000;
}