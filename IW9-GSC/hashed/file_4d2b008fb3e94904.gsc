/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4d2b008fb3e94904.gsc
***********************************************/

_id_62F2E8F81EA61013() {
  wait 10;
  _id_41C1F6E897CA2992 = getEntArray("movable_barrier", "targetname");
  level._id_D6933A9EE57E4072 = [];

  foreach(barrier in _id_41C1F6E897CA2992)
  level thread _id_A5F9590322187942(barrier);
}

_id_A5F9590322187942(barrier) {
  _id_2C0D3CB833264497 = getEnt("movable_barrier_clip", "targetname");
  _id_2C0D3CB833264497 notsolid();
  collision = spawn("script_model", barrier.origin + (0, 0, 32));
  collision dontinterpolate();
  collision.angles = barrier.angles;
  collision clonebrushmodeltoscriptmodel(_id_2C0D3CB833264497);
  collision disconnectPaths();
  barrier.clip = collision;
  barrier.clip.barrier = barrier;
  _id_CAE43579F0F0CE1B = scripts\engine\utility::getStruct(barrier.target, "targetname");
  barrier._id_CAE43579F0F0CE1B = _id_CAE43579F0F0CE1B;
  _id_4806F758B23854BA = spawn("script_origin", barrier._id_CAE43579F0F0CE1B.origin);

  if(isDefined(_id_CAE43579F0F0CE1B.angles))
    _id_4806F758B23854BA.angles = _id_CAE43579F0F0CE1B.angles;

  barrier._id_4806F758B23854BA = _id_4806F758B23854BA;
  barrier linkTo(_id_4806F758B23854BA);
  barrier.clip linkTo(_id_4806F758B23854BA);
  level._id_D6933A9EE57E4072[level._id_D6933A9EE57E4072.size] = barrier;
  barrier _id_B441DACC6C791929();
  _id_FD9C95BC53AA2FFD = barrier._id_CAE43579F0F0CE1B.script_parameters;

  if(isDefined(_id_FD9C95BC53AA2FFD)) {
    _id_FD9C95BC53AA2FFD = strtok(_id_FD9C95BC53AA2FFD, "_");

    if(_id_FD9C95BC53AA2FFD[0] == "roll") {
      _id_A2999C158533ABF3 = int(_id_FD9C95BC53AA2FFD[1]) * -1;
      barrier._id_4806F758B23854BA rotateroll(_id_A2999C158533ABF3, 1);
    }
  } else
    barrier._id_4806F758B23854BA rotateTo(90, 1);

  collision connectpaths();
}

_id_B441DACC6C791929() {
  self waittill("move_barrier");
}

_id_6D846E1780D0DE6A(_id_BBBEB834FD6B3696) {
  _id_055F75D9F16D814F = [];

  foreach(barrier in level._id_D6933A9EE57E4072) {
    if(isDefined(barrier.script_noteworthy)) {
      if(barrier.script_noteworthy == _id_BBBEB834FD6B3696)
        _id_055F75D9F16D814F[_id_055F75D9F16D814F.size] = barrier;
    }
  }

  return _id_055F75D9F16D814F;
}

_id_81E0001104B6EF22(dist) {
  _id_ABD9EE4725B96FC2 = dist * dist;

  for(;;) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, self.origin) < _id_ABD9EE4725B96FC2)
        return;
    }

    wait 1;
  }

  self notify("move_barrier");
}