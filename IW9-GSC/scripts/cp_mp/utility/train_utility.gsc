/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\train_utility.gsc
***************************************************/

player_standing_on_train() {
  _id_EB0BF8D1503BBB00 = self getmovingplatformparent();

  if(isDefined(_id_EB0BF8D1503BBB00)) {
    if(is_train_ent(_id_EB0BF8D1503BBB00))
      return 1;
  }

  return 0;
}

_id_00D6B0A591AC99BD() {
  if(isDefined(level.wztrain_info) && isDefined(level.wztrain_info.train_array))
    return level.wztrain_info.train_array[0];
}

is_train_ent(_id_1D9FB21B4F3023F3) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(!isDefined(ent)) {
        continue;
      }
      if(ent == _id_1D9FB21B4F3023F3)
        return 1;
      else if(isDefined(ent.linked_model) && ent.linked_model == _id_1D9FB21B4F3023F3)
        return 1;
    }
  }

  return 0;
}

_id_31156831AFC882AD() {
  if(!isDefined(level.wztrain_info))
    return undefined;

  _id_EB0BF8D1503BBB00 = self getmovingplatformparent();
  return _id_E58B746157089C68(_id_EB0BF8D1503BBB00);
}

_id_E58B746157089C68(_id_1D9FB21B4F3023F3) {
  if(!isDefined(level.wztrain_info))
    return undefined;

  if(!isDefined(level.wztrain_info._id_C3604781A9D33A7A))
    return undefined;

  if(!isDefined(_id_1D9FB21B4F3023F3))
    return undefined;

  foreach(train, array in level.wztrain_info._id_C3604781A9D33A7A) {
    foreach(ent in array) {
      if(ent == _id_1D9FB21B4F3023F3)
        return train;
      else if(isDefined(ent.linked_model) && ent.linked_model == _id_1D9FB21B4F3023F3)
        return train;
    }
  }

  return undefined;
}

_id_D699841D5E241043() {
  _id_C56207BDA09B3A36 = ["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_playerclip"];
  return physics_createcontents(_id_C56207BDA09B3A36);
}

is_moving_platform_train(movingplatforment) {
  if(!isDefined(movingplatforment))
    return 0;

  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == movingplatforment)
        return 1;
      else if(isDefined(ent.linked_model) && ent.linked_model == movingplatforment)
        return 1;
    }
  }

  return 0;
}

isplayerinsiderectangularzonebasedonent(player, _id_712EA31644C12F3B, _id_F5E80A9C637F1716, _id_1575B6A2D72EAB66, _id_DFF51823F3F6BCDD, _id_98029591BFD2ABAE, _id_1D3812E060E06BF3, _id_88469BDE23234DFD, _id_20E0E132629F3354) {
  _id_988D234C5DB33AFD = createrectangularzonebasedonent(_id_712EA31644C12F3B, _id_F5E80A9C637F1716, _id_1575B6A2D72EAB66, _id_DFF51823F3F6BCDD, _id_98029591BFD2ABAE, _id_1D3812E060E06BF3, _id_88469BDE23234DFD, _id_20E0E132629F3354);
  return isplayerinsiderectangularzone(player, _id_988D234C5DB33AFD);
}

isplayerinsiderectangularzone(player, _id_988D234C5DB33AFD) {
  _id_57CECBF0394A8C73 = player.origin[0];
  _id_57CECAF0394A8A40 = player.origin[1];
  _id_57CECDF0394A90D9 = player.origin[2];

  if(_id_57CECBF0394A8C73 > _id_988D234C5DB33AFD.max_x)
    return 0;

  if(_id_57CECBF0394A8C73 < _id_988D234C5DB33AFD.min_x)
    return 0;

  if(_id_57CECAF0394A8A40 > _id_988D234C5DB33AFD.max_y)
    return 0;

  if(_id_57CECAF0394A8A40 < _id_988D234C5DB33AFD.min_y)
    return 0;

  if(_id_57CECDF0394A90D9 > _id_988D234C5DB33AFD.max_z)
    return 0;

  if(_id_57CECDF0394A90D9 < _id_988D234C5DB33AFD.min_z)
    return 0;

  return 1;
}

createrectangularzonebasedonent(_id_712EA31644C12F3B, _id_F5E80A9C637F1716, _id_1575B6A2D72EAB66, _id_DFF51823F3F6BCDD, _id_98029591BFD2ABAE, _id_1D3812E060E06BF3, _id_88469BDE23234DFD, _id_20E0E132629F3354) {
  _id_988D234C5DB33AFD = createdefaultrectangularzone();
  _id_AC8052989CDB2473 = anglesToForward(_id_712EA31644C12F3B.angles);
  _id_EBEF6D02B5739464 = anglestoright(_id_712EA31644C12F3B.angles);
  _id_E3899FF8C3F3E723 = anglestoup(_id_712EA31644C12F3B.angles);
  _id_8B429BC997BDE15E = _id_712EA31644C12F3B gettagorigin(_id_F5E80A9C637F1716);
  _id_891C8352F22D5DAE = _id_8B429BC997BDE15E + _id_AC8052989CDB2473 * _id_1575B6A2D72EAB66 + _id_EBEF6D02B5739464 * _id_DFF51823F3F6BCDD + _id_E3899FF8C3F3E723 * _id_98029591BFD2ABAE;
  _id_0B068B11C5DF814D = [];
  halflength = _id_1D3812E060E06BF3 / 2;
  halfwidth = _id_88469BDE23234DFD / 2;
  halfheight = _id_20E0E132629F3354 / 2;
  _id_B125447FFFEB35C0 = [halflength, halflength * -1];
  _id_5A33CFA8A827BFD2 = [halfwidth, halfwidth * -1];
  _id_F3079322750CD72F = [halfheight, halfheight * -1];

  foreach(_id_C734DF03C2E01876 in _id_B125447FFFEB35C0) {
    foreach(_id_210F94A8FD146F18 in _id_5A33CFA8A827BFD2) {
      foreach(heightoffset in _id_F3079322750CD72F) {
        _id_1B5AFBEDD7E1EE0C = _id_891C8352F22D5DAE + _id_AC8052989CDB2473 * _id_C734DF03C2E01876 + _id_EBEF6D02B5739464 * _id_210F94A8FD146F18 + _id_E3899FF8C3F3E723 * heightoffset;
        updaterectangularzone(_id_1B5AFBEDD7E1EE0C, _id_988D234C5DB33AFD);
      }
    }
  }

  return _id_988D234C5DB33AFD;
}

updaterectangularzone(_id_1B5AFBEDD7E1EE0C, _id_988D234C5DB33AFD) {
  _id_0B068011C5DF691C = _id_1B5AFBEDD7E1EE0C[0];
  _id_0B068111C5DF6B4F = _id_1B5AFBEDD7E1EE0C[1];
  _id_0B068211C5DF6D82 = _id_1B5AFBEDD7E1EE0C[2];

  if(_id_0B068011C5DF691C > _id_988D234C5DB33AFD.max_x)
    _id_988D234C5DB33AFD.max_x = _id_0B068011C5DF691C;

  if(_id_0B068011C5DF691C < _id_988D234C5DB33AFD.min_x)
    _id_988D234C5DB33AFD.min_x = _id_0B068011C5DF691C;

  if(_id_0B068111C5DF6B4F > _id_988D234C5DB33AFD.max_y)
    _id_988D234C5DB33AFD.max_y = _id_0B068111C5DF6B4F;

  if(_id_0B068111C5DF6B4F < _id_988D234C5DB33AFD.min_y)
    _id_988D234C5DB33AFD.min_y = _id_0B068111C5DF6B4F;

  if(_id_0B068211C5DF6D82 > _id_988D234C5DB33AFD.max_z)
    _id_988D234C5DB33AFD.max_z = _id_0B068211C5DF6D82;

  if(_id_0B068211C5DF6D82 < _id_988D234C5DB33AFD.min_z)
    _id_988D234C5DB33AFD.min_z = _id_0B068211C5DF6D82;
}

createdefaultrectangularzone() {
  _id_988D234C5DB33AFD = spawnStruct();
  _id_988D234C5DB33AFD.max_x = -999999;
  _id_988D234C5DB33AFD.min_x = 999999;
  _id_988D234C5DB33AFD.max_y = -999999;
  _id_988D234C5DB33AFD.min_y = 999999;
  _id_988D234C5DB33AFD.max_z = -999999;
  _id_988D234C5DB33AFD.min_z = 999999;
  return _id_988D234C5DB33AFD;
}