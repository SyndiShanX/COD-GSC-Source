/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawn_factor.gsc
***********************************************/

critical_factor(_id_E2CADC5BF4175E47, spawnpoint) {
  _id_913B73097FDCDB62 = [[_id_E2CADC5BF4175E47]](spawnpoint);
  _id_913B73097FDCDB62 = clamp(_id_913B73097FDCDB62, 0, 1000);
  return _id_913B73097FDCDB62;
}

avoidgrenades(spawnpoint) {
  foreach(grenade in level.grenades) {
    if(!isDefined(grenade) || !grenade isexplosivedangeroustoplayer(self))
      continue;
    else if(distancesquared(spawnpoint.origin, grenade.origin) < 122500)
      return 0;
  }

  return 1000;
}

avoidmines(spawnpoint) {
  _id_4E5DA354865DF1FD = level.mines;

  if(isDefined(level.placed_crafted_traps))
    _id_4E5DA354865DF1FD = scripts\engine\utility::array_combine(level.mines, level.placed_crafted_traps);

  foreach(explosive in _id_4E5DA354865DF1FD) {
    if(!isDefined(explosive) || !explosive isexplosivedangeroustoplayer(self)) {
      continue;
    }
    if(distancesquared(spawnpoint.origin, explosive.origin) < 122500)
      return 0;
  }

  return 1000;
}

isexplosivedangeroustoplayer(player) {
  if(!level.teambased || level.friendlyfire || !isDefined(player.team))
    return 1;
  else {
    _id_567FBB57B0FBCAF9 = undefined;

    if(isDefined(self.owner)) {
      if(player == self.owner)
        return 1;

      _id_567FBB57B0FBCAF9 = self.owner.team;
    }

    if(isDefined(_id_567FBB57B0FBCAF9))
      return _id_567FBB57B0FBCAF9 != player.team;
    else
      return 1;
  }
}

avoidtelefrag(spawnpoint) {
  if(isDefined(self.allowtelefrag))
    return 1000;
  else if(isDefined(spawnpoint.allowtelefrag))
    return 1000;
  else if(positionwouldtelefrag(spawnpoint.origin))
    return 0;
  else
    return 1000;
}

spawn_point_too_far(spawnpoint) {
  if(distancesquared(scripts\cp\utility::get_center_point_of_array(level.players), spawnpoint.origin) >= 16777216)
    return 0;
  else
    return 1000;
}