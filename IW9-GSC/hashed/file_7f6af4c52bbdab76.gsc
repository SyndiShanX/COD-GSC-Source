/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7f6af4c52bbdab76.gsc
***********************************************/

init() {
  level._id_37AA0062320EBD1A.doors = [];
  doors = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "door");

  foreach(door in doors) {
    if(!door getscriptableparthasstate("door", "closed")) {
      continue;
    }
    if(door getscriptablepartstate("door") != "closed") {
      continue;
    }
    _id_0646B88B6B0468F9 = door _meth_D90515F5E17DBC6F();

    if(!ispointonnavmesh(_id_0646B88B6B0468F9)) {
      continue;
    }
    level._id_37AA0062320EBD1A.doors[level._id_37AA0062320EBD1A.doors.size] = door;
  }
}

_id_FFD4129F1032E796() {
  self botsetdifficultysetting("slideChance", 0);
  self._id_37AA0062320EBD1A.onplayerkilled = ::onplayerkilled;

  if(level._id_37AA0062320EBD1A.doors.size <= 0) {
    return;
  }
  door = _id_8563E304EBEB864E();
  self._id_37AA0062320EBD1A._id_97DD4F64F6425EAA = door;

  if(!_id_72A26AE8088DF617(door)) {
    _id_B2C0521B89512BA9(door);
    return;
  }

  _id_D65B2FB0B79BD54D = _id_5E5BD9A8B8896F3A(door);

  if(!isDefined(_id_D65B2FB0B79BD54D)) {
    _id_183BC29D2DAB9FDF("can't find test pos", self, undefined, door, undefined, undefined, 0);
    return;
  }

  _id_0D22FDCA158E266E = 20;
  _id_FC77E2B383D17EC9 = _id_0A661C5FAD6BEDD8::_id_721588AE374756B5(_id_D65B2FB0B79BD54D._id_5394FC468396843C, _id_0D22FDCA158E266E);

  if(isDefined(_id_FC77E2B383D17EC9)) {
    _id_183BC29D2DAB9FDF("teleport failed/" + _id_FC77E2B383D17EC9, self, self.origin, door, _id_D65B2FB0B79BD54D._id_5394FC468396843C, _id_D65B2FB0B79BD54D._id_518A4E9F2D3B108D, 0);
    return;
  }

  for(_id_8BE25B38B6CC08EC = [_id_D65B2FB0B79BD54D._id_518A4E9F2D3B108D, _id_D65B2FB0B79BD54D._id_5394FC468396843C]; _id_8BE25B38B6CC08EC.size > 0; _id_8BE25B38B6CC08EC = scripts\engine\utility::array_remove(_id_8BE25B38B6CC08EC, _id_7DCA7B54862A5286)) {
    _id_7DCA7B54862A5286 = _id_8BE25B38B6CC08EC[0];

    if(!_id_41EEB1B4BF5B7790(self, _id_D65B2FB0B79BD54D, _id_7DCA7B54862A5286)) {
      break;
    }
  }

  door scriptabledoorclose();
}

_id_60524DE5341E2666() {
  if(isDefined(self)) {
    self botsetflag("disable_movement", 0);
    self._id_37AA0062320EBD1A._id_97DD4F64F6425EAA = undefined;
  }
}

_id_8563E304EBEB864E() {
  lastindex = level._id_37AA0062320EBD1A.doors.size - 1;
  door = level._id_37AA0062320EBD1A.doors[lastindex];
  level._id_37AA0062320EBD1A.doors = scripts\engine\utility::array_remove_index(level._id_37AA0062320EBD1A.doors, lastindex);
  return door;
}

_id_B2C0521B89512BA9(door) {
  level._id_37AA0062320EBD1A.doors = scripts\engine\utility::array_insert(level._id_37AA0062320EBD1A.doors, door, 0);
}

_id_3113F44EBAFE71B1() {
  return level._id_37AA0062320EBD1A.doors.size > 0 || isDefined(self._id_37AA0062320EBD1A._id_97DD4F64F6425EAA);
}

_id_72A26AE8088DF617(door) {
  if(door scriptabledoorisclosed())
    return 1;

  door scriptabledoorclose();
  wait 1;
  return door scriptabledoorisclosed();
}

_id_5E5BD9A8B8896F3A(door) {
  _id_DD4626B0FA4445E2 = [50, 70, 100];
  _id_A53088F1B67DDE16 = 50;
  _id_29E0B716037ACBD9 = 1.25;
  _id_0646B88B6B0468F9 = door _meth_D90515F5E17DBC6F();

  foreach(_id_D3E7EF03D73E0D93 in _id_DD4626B0FA4445E2) {
    _id_5394FC468396843C = getclosestpointonnavmesh(_id_0646B88B6B0468F9 + anglesToForward(door.angles + (0, -90, 0)) * _id_D3E7EF03D73E0D93);
    _id_5394FC468396843C = scripts\engine\utility::drop_to_ground(_id_5394FC468396843C, _id_A53088F1B67DDE16);
    _id_518A4E9F2D3B108D = getclosestpointonnavmesh(_id_0646B88B6B0468F9 + anglesToForward(door.angles + (0, 90, 0)) * _id_D3E7EF03D73E0D93);
    _id_518A4E9F2D3B108D = scripts\engine\utility::drop_to_ground(_id_518A4E9F2D3B108D, _id_A53088F1B67DDE16);

    if(distance(_id_5394FC468396843C, _id_518A4E9F2D3B108D) <= 2 * _id_D3E7EF03D73E0D93 * _id_29E0B716037ACBD9) {
      _id_D65B2FB0B79BD54D = spawnStruct();
      _id_D65B2FB0B79BD54D.door = door;
      _id_D65B2FB0B79BD54D._id_1CDF5229A7B795E2 = door.angles;
      _id_D65B2FB0B79BD54D._id_5394FC468396843C = _id_5394FC468396843C;
      _id_D65B2FB0B79BD54D._id_518A4E9F2D3B108D = _id_518A4E9F2D3B108D;
      return _id_D65B2FB0B79BD54D;
    }
  }

  return undefined;
}

_id_41EEB1B4BF5B7790(bot, _id_D65B2FB0B79BD54D, targetpos) {
  _id_E68C4BB8093910B8 = 4.5;
  _id_3961EE7D4AD90424 = 0.25;
  _id_EA742470751D2E85 = 0;
  _id_ECBD358979C06C94 = gettime();
  _id_DABF4CF09B2C06CA = bot.origin;

  for(;;) {
    bot _id_59FF79D681BB860C::_id_9E400058EF021B03(targetpos, 16);
    result = _id_0A661C5FAD6BEDD8::_id_B564050A363F08EC(bot, _id_3961EE7D4AD90424);

    if(!_id_EA742470751D2E85) {
      _id_EA742470751D2E85 = _id_D750FAC76A6017C9(_id_D65B2FB0B79BD54D, _id_DABF4CF09B2C06CA, bot.origin);
      _id_DABF4CF09B2C06CA = bot.origin;
    }

    if(result == "goal") {
      if(!_id_EA742470751D2E85) {
        _id_183BC29D2DAB9FDF("bypass the door", bot, _id_DABF4CF09B2C06CA, _id_D65B2FB0B79BD54D.door, _id_D65B2FB0B79BD54D._id_5394FC468396843C, _id_D65B2FB0B79BD54D._id_518A4E9F2D3B108D, _id_EA742470751D2E85);
        return 0;
      }

      break;
    } else {
      if((result == "timeout" || result == "bad_path_stuck") && gettime() - _id_ECBD358979C06C94 < _id_E68C4BB8093910B8 * 1000)
        continue;
      else if(result == "bad_path_door_blocker_door_owner" || result == "bad_path_door_blocker_invalid_client") {
        _id_D65B2FB0B79BD54D.door scriptabledoorclose();
        _id_B2C0521B89512BA9(_id_D65B2FB0B79BD54D.door);
        return 0;
      }

      _id_183BC29D2DAB9FDF(result, bot, _id_DABF4CF09B2C06CA, _id_D65B2FB0B79BD54D.door, _id_D65B2FB0B79BD54D._id_5394FC468396843C, _id_D65B2FB0B79BD54D._id_518A4E9F2D3B108D, _id_EA742470751D2E85);
      return 0;
    }
  }

  return 1;
}

_id_D750FAC76A6017C9(_id_D65B2FB0B79BD54D, startpos, endpos) {
  _id_1E35E50E4B93EAB6 = 64;
  _id_11855AC71DB6DC0D = _id_D65B2FB0B79BD54D.door.origin;
  _id_1A2DFA0E910C8A94 = _id_11855AC71DB6DC0D + anglesToForward(_id_D65B2FB0B79BD54D._id_1CDF5229A7B795E2) * _id_1E35E50E4B93EAB6;
  return _id_08AD14AEEC3F67B1(startpos, endpos, _id_11855AC71DB6DC0D, _id_1A2DFA0E910C8A94);
}

_id_08AD14AEEC3F67B1(p1, p2, _id_CDC86878F511B5A3, _id_CDC86978F511B7D6) {
  _id_A50631B6539F72D5 = scripts\engine\utility::ter_op(p1[0] > p2[0], p1[0], p2[0]);
  _id_A5291BB653C58A2B = scripts\engine\utility::ter_op(p1[0] > p2[0], p2[0], p1[0]);
  _id_1B13C7A356A1E420 = scripts\engine\utility::ter_op(p1[1] > p2[1], p1[1], p2[1]);
  _id_1AF0BDA3567B866A = scripts\engine\utility::ter_op(p1[1] > p2[1], p2[1], p1[1]);
  _id_31AB34A515F2C3C6 = scripts\engine\utility::ter_op(_id_CDC86878F511B5A3[0] > _id_CDC86978F511B7D6[0], _id_CDC86878F511B5A3[0], _id_CDC86978F511B7D6[0]);
  _id_318826A515CC5D44 = scripts\engine\utility::ter_op(_id_CDC86878F511B5A3[0] > _id_CDC86978F511B7D6[0], _id_CDC86978F511B7D6[0], _id_CDC86878F511B5A3[0]);
  _id_FEE7F6B9BB338ED3 = scripts\engine\utility::ter_op(_id_CDC86878F511B5A3[1] > _id_CDC86978F511B7D6[1], _id_CDC86878F511B5A3[1], _id_CDC86978F511B7D6[1]);
  _id_FF0B0CB9BB5A06ED = scripts\engine\utility::ter_op(_id_CDC86878F511B5A3[1] > _id_CDC86978F511B7D6[1], _id_CDC86978F511B7D6[1], _id_CDC86878F511B5A3[1]);

  if(_id_A50631B6539F72D5 < _id_318826A515CC5D44 || _id_31AB34A515F2C3C6 < _id_A5291BB653C58A2B || _id_1B13C7A356A1E420 < _id_FF0B0CB9BB5A06ED || _id_FEE7F6B9BB338ED3 < _id_1AF0BDA3567B866A)
    return 0;

  _id_3CBA69C5D573125C = (p1[0] - p2[0]) * (_id_CDC86878F511B5A3[1] - p2[1]) - (p1[1] - p2[1]) * (_id_CDC86878F511B5A3[0] - p2[0]);
  _id_3CBA6CC5D57318F5 = (p1[0] - p2[0]) * (_id_CDC86978F511B7D6[1] - p2[1]) - (p1[1] - p2[1]) * (_id_CDC86978F511B7D6[0] - p2[0]);
  _id_3CBA6BC5D57316C2 = (_id_CDC86878F511B5A3[0] - _id_CDC86978F511B7D6[0]) * (p1[1] - _id_CDC86978F511B7D6[1]) - (_id_CDC86878F511B5A3[1] - _id_CDC86978F511B7D6[1]) * (p1[0] - _id_CDC86978F511B7D6[0]);
  _id_3CBA66C5D5730BC3 = (_id_CDC86878F511B5A3[0] - _id_CDC86978F511B7D6[0]) * (p2[1] - _id_CDC86978F511B7D6[1]) - (_id_CDC86878F511B5A3[1] - _id_CDC86978F511B7D6[1]) * (p2[0] - _id_CDC86978F511B7D6[0]);
  return _id_3CBA69C5D573125C * _id_3CBA6CC5D57318F5 <= 0 && _id_3CBA6BC5D57316C2 * _id_3CBA66C5D5730BC3 <= 0;
}

onplayerkilled(_id_642470E1ABC1BBF9) {
  if(!isbot(self)) {
    return;
  }
  _id_183BC29D2DAB9FDF("death", self, self.lastdeathpos, self._id_37AA0062320EBD1A._id_97DD4F64F6425EAA, undefined, undefined, 0);
}

_id_183BC29D2DAB9FDF(_id_0889F3D7E1C1EA6B, bot, _id_DABF4CF09B2C06CA, door, _id_5394FC468396843C, _id_518A4E9F2D3B108D, _id_EA742470751D2E85) {
  _id_A38464FF439AFF91 = "unknownPos";
  _id_DABF4CF09B2C06CA = scripts\engine\utility::ter_op(isDefined(_id_DABF4CF09B2C06CA), _id_DABF4CF09B2C06CA, _id_A38464FF439AFF91);
  _id_5394FC468396843C = scripts\engine\utility::ter_op(isDefined(_id_5394FC468396843C), _id_5394FC468396843C, _id_A38464FF439AFF91);
  _id_518A4E9F2D3B108D = scripts\engine\utility::ter_op(isDefined(_id_518A4E9F2D3B108D), _id_518A4E9F2D3B108D, _id_A38464FF439AFF91);
  _id_1FC860A3DD042E43 = -1;
  _id_20510600314FE827 = (0, 0, 0);

  if(isDefined(door)) {
    _id_1FC860A3DD042E43 = door.index;
    _id_20510600314FE827 = door.origin;
  }

  _id_444A5451F436094A = "situation: " + _id_0889F3D7E1C1EA6B + ";" + "bot: " + bot getentitynumber() + ";" + "lastPosition: " + _id_DABF4CF09B2C06CA + ";" + "door indx: " + _id_1FC860A3DD042E43 + ";" + "door origin: " + _id_20510600314FE827 + ";" + "beforeDoorPos: " + _id_5394FC468396843C + ";" + "afterDoorPos: " + _id_518A4E9F2D3B108D + ";" + "isPassed: " + _id_EA742470751D2E85 + ";";
  _id_0A661C5FAD6BEDD8::_id_9A0A24DE119B078A("Door", _id_444A5451F436094A);
}