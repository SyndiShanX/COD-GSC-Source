/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5fd79768b8941cfb.gsc
***********************************************/

_id_B585808F22E26AA6(_id_9B9F1075DB564ACD, _id_CB1CD0599C50F0E9) {
  _id_D6C04A6D8C7B7693 = [];

  foreach(loot in _id_9B9F1075DB564ACD._id_A679C918818FA808) {
    type = loot.targetname;

    switch (type) {
      case "moving_buy_station":
        scriptable = _id_863B4187F0955E66(loot);
        break;
      case "moving_workbench":
        scriptable = _id_5EFFFD6EA06BAB7B(loot);
        break;
      case "br_loot_cache":
        if(isDefined(_id_9B9F1075DB564ACD._id_FD5B04DE8603C8A6))
          scriptable = [[_id_9B9F1075DB564ACD._id_FD5B04DE8603C8A6]](_id_9B9F1075DB564ACD, loot, type);
        else
          scriptable = _id_E3F46AD7BAC518E8(loot, type);

        break;
      default:
        scriptable = undefined;
        break;
    }

    if(isDefined(scriptable))
      _id_D6C04A6D8C7B7693[_id_D6C04A6D8C7B7693.size] = scriptable;
  }

  thread _id_B6875112271FAC46(_id_9B9F1075DB564ACD, _id_D6C04A6D8C7B7693, _id_CB1CD0599C50F0E9);
}

_id_863B4187F0955E66(loot) {
  scriptable = _id_4384ABBF498DF6A7::_id_7CB54F604C35BE8C(loot);
  scriptable setscriptablepartstate("br_plunder_box", "hidden");
  return scriptable;
}

_id_5EFFFD6EA06BAB7B(loot) {
  if(_id_67CC94C07AB18D3A::_id_19598C1EA1487B84()) {
    scriptable = spawnscriptable("br_workbench", loot.origin, loot.angles);
    scriptable setscriptablepartstate("br_workbench", "visible");
    return scriptable;
  }
}

_id_E3F46AD7BAC518E8(loot, type) {
  scriptable = spawnscriptable(type, loot.origin, loot.angles);
  thread _id_7A553DB47DD1D2B5(scriptable);
  return scriptable;
}

_id_7A553DB47DD1D2B5(_id_CB2499E4E9D175A2) {
  level waittill("prematch_fade_done");

  if(_id_CB2499E4E9D175A2 getscriptablehaspart("body") && _id_CB2499E4E9D175A2 getscriptableparthasstate("body", "closed_usable_no_collision"))
    _id_CB2499E4E9D175A2 setscriptablepartstate("body", "closed_usable_no_collision");
  else if(_id_CB2499E4E9D175A2 getscriptablehaspart("body") && _id_CB2499E4E9D175A2 getscriptableparthasstate("body", "closed_usable"))
    _id_CB2499E4E9D175A2 setscriptablepartstate("body", "closed_usable");
}

_id_B6875112271FAC46(_id_9B9F1075DB564ACD, _id_D6C04A6D8C7B7693, _id_CB1CD0599C50F0E9) {
  level waittill("prematch_fade_done");

  foreach(scriptable in _id_D6C04A6D8C7B7693) {
    offset = _id_9D12545308A35FD2(scriptable, _id_9B9F1075DB564ACD);
    scriptable thread _id_C8F65416CE71277A(_id_CB1CD0599C50F0E9, offset, scriptable.angles);
  }
}

_id_9D12545308A35FD2(loot, _id_9B9F1075DB564ACD) {
  _id_C35E1C74AEFB4992 = loot.origin - _id_9B9F1075DB564ACD._id_0FF2A1EDCD931BA3;
  return _id_C35E1C74AEFB4992;
}

_id_C8F65416CE71277A(scriptmodel, offset, angles) {
  level endon("game_ended");
  waitframe();
  scripts\common\utility::_id_6E506F39F121EA8A(scriptmodel, offset, angles);
  self.parent = scriptmodel;
}

_id_702EE23ACA4D2485(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_FE1033CAE51778CC, _id_B3E01B11D76E1DB6, time) {
  _id_D99757891D1ED279 = scripts\engine\utility::ter_op(_id_B3E01B11D76E1DB6 >= _id_FE1033CAE51778CC, 1, -1);
  _id_3C141DF65714D228 = scripts\engine\utility::ter_op(_id_D99757891D1ED279 >= 0, _id_FE1033CAE51778CC, _id_B3E01B11D76E1DB6);
  _id_47EF1080427D4D3A = scripts\engine\utility::ter_op(_id_D99757891D1ED279 >= 0, _id_B3E01B11D76E1DB6, _id_FE1033CAE51778CC);
  _id_60278BCB8AC1212B = (_id_47EF1080427D4D3A - _id_3C141DF65714D228) / time;

  while(_id_FE1033CAE51778CC != _id_B3E01B11D76E1DB6) {
    _id_FE1033CAE51778CC = _id_DBF72252B51C25AF(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_D99757891D1ED279, _id_60278BCB8AC1212B, _id_FE1033CAE51778CC, _id_B3E01B11D76E1DB6);
    waitframe();
  }

  return _id_FE1033CAE51778CC;
}

_id_DBF72252B51C25AF(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_D99757891D1ED279, _id_60278BCB8AC1212B, _id_FE1033CAE51778CC, _id_B3E01B11D76E1DB6) {
  _id_58BEABC1E8B6397F = _id_FE1033CAE51778CC + _id_D99757891D1ED279 * level.framedurationseconds * _id_60278BCB8AC1212B;

  if(_id_D99757891D1ED279 == 1 && _id_58BEABC1E8B6397F >= _id_B3E01B11D76E1DB6 || _id_D99757891D1ED279 == -1 && _id_58BEABC1E8B6397F <= _id_B3E01B11D76E1DB6)
    _id_58BEABC1E8B6397F = _id_B3E01B11D76E1DB6;

  if(_id_58BEABC1E8B6397F != _id_FE1033CAE51778CC) {
    _id_FE1033CAE51778CC = _id_58BEABC1E8B6397F;
    _id_EE6AC63A2F326FE8(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_FE1033CAE51778CC);
  }

  return _id_FE1033CAE51778CC;
}

_id_EE6AC63A2F326FE8(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_58BEABC1E8B6397F) {
  _id_B2A3F9ABCEE9D071 setanimrate(_id_E26F44ACAD48DDD1, _id_58BEABC1E8B6397F);

  if(isDefined(_id_B2A3F9ABCEE9D071._id_F5AB71E8BF7A604B))
    [[_id_B2A3F9ABCEE9D071._id_F5AB71E8BF7A604B]](_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_58BEABC1E8B6397F);
}

_id_FFD9B2FE58C97F7C(_id_776BAE99312943AE, _id_E26F44ACAD48DDD1) {
  _id_DFB7FF3BEF234B0E = _id_776BAE99312943AE getanimtime(_id_E26F44ACAD48DDD1);
  _id_00CDD725F8F73B94 = getanimlength(_id_E26F44ACAD48DDD1) * _id_DFB7FF3BEF234B0E;
  return _id_00CDD725F8F73B94;
}

_id_E549E7BB5A16C3BC() {
  level endon("game_ended");
  self endon("death");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

_id_84114ACFF04CFCCB(_id_C975FCDFFCE9C9A6, _id_C975FBDFFCE9C773, _id_7731ADEF63E19B0C, _id_57E49972A041777E, _id_C4E36A338FA34F19) {
  if(_id_C975FCDFFCE9C9A6 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD() == _id_7731ADEF63E19B0C) {
    _id_A2731E6D9AF15254 = _id_C975FCDFFCE9C9A6;
    vehicle = _id_C975FBDFFCE9C773;
  } else {
    _id_A2731E6D9AF15254 = _id_C975FBDFFCE9C773;
    vehicle = _id_C975FCDFFCE9C9A6;
  }

  if(scripts\cp_mp\vehicles\vehicle_collision::_id_D88AED99025A81E4(vehicle, _id_A2731E6D9AF15254)) {
    return;
  }
  if(!isDefined(vehicle) || !isDefined(vehicle.health)) {
    return;
  }
  _id_DC494B3DF72D32CF = undefined;
  _id_B671DDA1C1164EC4 = vehicle vehicle_getvelocity();

  if(isDefined(_id_A2731E6D9AF15254.velocity))
    _id_DC494B3DF72D32CF = _id_A2731E6D9AF15254.velocity;
  else if(isDefined(_id_A2731E6D9AF15254 getlinkedchildren())) {
    velocity = undefined;
    children = _id_A2731E6D9AF15254 getlinkedchildren();

    foreach(child in children) {
      if(isDefined(child.velocity)) {
        _id_DC494B3DF72D32CF = child.velocity;
        break;
      }
    }
  }

  _id_04277B8E82ED3E5C = 1;
  _id_E560B75818B74794 = 1;
  _id_818AC4C7F82E5CA5 = 1;
  _id_6D4FC1AF18B13A8B = 1;
  _id_BAF692851EE3418D = 20;
  _id_E0C9CBAB4AB671F3 = 0.5;
  _id_D768B2AB879AAF25 = 30;
  _id_45DFDE7180341DD5 = length(_id_B671DDA1C1164EC4);
  _id_04277B8E82ED3E5C = scripts\engine\math::remap(_id_45DFDE7180341DD5, 0, 600, _id_6D4FC1AF18B13A8B, _id_BAF692851EE3418D);
  _id_4EF87BE7F0367144 = scripts\engine\math::anglebetweenvectorsunit(vectorNormalize(_id_B671DDA1C1164EC4), vectorNormalize(_id_DC494B3DF72D32CF));
  _id_E560B75818B74794 = scripts\engine\math::remap(_id_4EF87BE7F0367144, 0, 180, _id_E0C9CBAB4AB671F3, _id_D768B2AB879AAF25);

  if(getdvarfloat("dvar_C243128198440F06", -1) != -1)
    _id_818AC4C7F82E5CA5 = getdvarfloat("dvar_C243128198440F06", -1);

  health = vehicle.health;
  mindamage = health / 10;
  damage = mindamage * _id_E560B75818B74794 * _id_04277B8E82ED3E5C * _id_818AC4C7F82E5CA5;
  isvehicledestroyed = damage >= health;

  if(isvehicledestroyed)
    vehicle._id_A8F4BB03B366AA80 = 1;

  vehicle dodamage(damage, _id_A2731E6D9AF15254.origin, _id_A2731E6D9AF15254, _id_A2731E6D9AF15254, "MOD_CRUSH");

  if(vehicle vehicle_isphysveh()) {
    _id_B16F8AAD32BD1E89 = scripts\engine\utility::ter_op(isDefined(_id_C4E36A338FA34F19), _id_C4E36A338FA34F19, 250);
    vehicle _meth_E0201404A8B6F664(vehicle.origin - _id_A2731E6D9AF15254.origin + (0, 0, 200), _id_B16F8AAD32BD1E89, 1);
  }

  if(vehicle.health < health)
    level thread scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_ignorefutureevent(vehicle, _id_A2731E6D9AF15254, _id_57E49972A041777E);

  _id_3CBF5EC3E372F1F2 = spawnStruct();
  _id_3CBF5EC3E372F1F2._id_A2731E6D9AF15254 = _id_A2731E6D9AF15254;
  _id_3CBF5EC3E372F1F2.vehicle = vehicle;
  _id_3CBF5EC3E372F1F2.isvehicledestroyed = isvehicledestroyed;
  return _id_3CBF5EC3E372F1F2;
}