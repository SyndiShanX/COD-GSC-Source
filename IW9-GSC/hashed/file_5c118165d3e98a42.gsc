/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5c118165d3e98a42.gsc
***********************************************/

_id_D8DE1E0BC05F3B3A(_id_1B64869207D9F98F) {
  level.elevators = [];
  level._id_FDD3DFF47723BE1F = [];
  level._id_40E610580F1CBAF8 = [];
  level._id_52B8E16BC0CD79D6 = 0;
  _id_38338A9A033E68A3();
  _id_40E610580F1CBAF8 = getentitylessscriptablearray("elevator_stop", "script_noteworthy");
  _id_AB337E7F8A1FA44A = [];

  foreach(stop in _id_40E610580F1CBAF8) {
    _id_68333DFC5840CBD8 = stop.origin[0] + "," + stop.origin[1];

    if(!isDefined(_id_AB337E7F8A1FA44A[_id_68333DFC5840CBD8]))
      _id_AB337E7F8A1FA44A[_id_68333DFC5840CBD8] = [];

    _id_AB337E7F8A1FA44A[_id_68333DFC5840CBD8][_id_AB337E7F8A1FA44A[_id_68333DFC5840CBD8].size] = stop;
    stop.open = 0;
    _id_A4DE0BB1CFAF96E8 = getentitylessscriptablearray(stop.target, "targetname");
    stop._id_0E4118BDA122B112 = _id_A4DE0BB1CFAF96E8[0];
    _id_BD440A13487263EF = scripts\engine\utility::getStruct(stop._id_0E4118BDA122B112.target, "targetname");
    stop._id_BD440A13487263EF = _id_BD440A13487263EF.origin;
    stop.doors = getentitylessscriptablearray(stop._id_0E4118BDA122B112.target, "targetname");
    stop._id_90DABE3606074803 = getEnt(stop.target, "targetname");

    if(level.mapname == "mp_biobunker" && isDefined(stop.script_linkname) && isendstr(stop.script_linkname, "elevator_50"))
      stop._id_BD440A13487263EF = (-15049, 7096, 1660);

    _id_6073FE6FF110D6A8 = getEntArray(stop._id_0E4118BDA122B112.target, "targetname");

    foreach(targetent in _id_6073FE6FF110D6A8) {
      if(targetent.classname == "script_brushmodel") {
        stop._id_6C7D2BF4BA0F495D = targetent;
        continue;
      }

      if(targetent.classname == "info_volume")
        stop._id_0907E66D3BF42C5A = targetent;
    }

    foreach(door in stop.doors) {
      door.open = 0;
      door.clip = getEnt(door.target, "targetname");
      door.clip._id_F16D407674809F11 = door.clip.origin;
      _id_E84C9E6B1231BF18 = scripts\engine\utility::getStruct(door.clip.target, "targetname");
      door.clip._id_C2FAC7A209524732 = _id_E84C9E6B1231BF18.origin;

      if(isDefined(_id_E84C9E6B1231BF18.target) && _id_E84C9E6B1231BF18.target != "") {
        _id_9932BF8D872AEC43 = getEnt(_id_E84C9E6B1231BF18.target, "targetname");
        door._id_9932BF8D872AEC43 = _id_9932BF8D872AEC43;
      }
    }

    stop._id_CE7F7E62DF1E0B51 = scripts\engine\utility::getStruct(stop.target, "targetname");
  }

  _id_9C512BD31F6B92D0 = scripts\engine\utility::getStructArray("elevator_car", "script_noteworthy");

  foreach(_id_DDF67F48730C77B1 in _id_AB337E7F8A1FA44A) {
    _id_EEC55FABA21F3653 = spawnStruct();
    _id_EEC55FABA21F3653.parts = [];
    _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6 = [];
    group = "elevator_group_free";
    _id_EEC55FABA21F3653.group = group;
    _id_D8ACB6785F746668 = 0;

    foreach(stop in _id_DDF67F48730C77B1)
    stop._id_EEC55FABA21F3653 = _id_EEC55FABA21F3653;

    _id_8518FDD0909B90FD = _id_DDF67F48730C77B1[_id_D8ACB6785F746668].origin;
    _id_636C8575D7A7768B = undefined;
    _id_21EFBD9501C439BA = undefined;

    foreach(car in _id_9C512BD31F6B92D0) {
      dist = distancesquared(car.origin, _id_8518FDD0909B90FD);

      if(!isDefined(_id_636C8575D7A7768B) || _id_636C8575D7A7768B > dist) {
        _id_636C8575D7A7768B = dist;
        _id_21EFBD9501C439BA = car;
      }
    }

    car = spawn("script_model", _id_21EFBD9501C439BA.origin);
    car.angles = _id_21EFBD9501C439BA.angles;

    switch (level.mapname) {
      case "mp_bio_lab":
        car setModel("building_biolabs_elevator_set_int");
        break;
      case "mp_biobunker":
        car setModel("building_biobunker_elevator_car_frame_one_way");
        break;
      default:
        car setModel("building_biolabs_elevator_set_int");
        break;
    }

    car.animname = "elevator";
    car scripts\common\anim::setanimtree();
    car._id_EEC55FABA21F3653 = _id_EEC55FABA21F3653;
    car.moverdoesnotkill = 1;
    _id_EEC55FABA21F3653.car = car;
    _id_3B8C6779206FB1DE = scripts\engine\utility::array_sort_with_func(_id_DDF67F48730C77B1, ::_id_90E407AC8F409CCD);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3B8C6779206FB1DE.size; _id_AC0E594AC96AA3A8++) {
      _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8] = _id_3B8C6779206FB1DE[_id_AC0E594AC96AA3A8];
      _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_5DCB93DB1678CDAF = _id_AC0E594AC96AA3A8;

      if(_id_AC0E594AC96AA3A8 > 0)
        _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_E340247A219F2577 = _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8].origin[2] - _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8 - 1].origin[2] + _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8 - 1]._id_E340247A219F2577;
      else
        _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_E340247A219F2577 = _id_EEC55FABA21F3653.car.origin[2];

      _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_EEC55FABA21F3653 = _id_EEC55FABA21F3653;
      _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8].floor = _id_AC0E594AC96AA3A8;
      _id_95459826AE7A2253 = (_id_EEC55FABA21F3653.car.origin[0], _id_EEC55FABA21F3653.car.origin[1], _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_E340247A219F2577);
      _id_6485CB51EB50DC9B = _id_135DE56D99FC05B8(_id_95459826AE7A2253);
      _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_6485CB51EB50DC9B = scripts\engine\utility::ter_op(isDefined(_id_6485CB51EB50DC9B), _id_6485CB51EB50DC9B, _id_AC0E594AC96AA3A8);
      _id_32E27AD06C3E7804 = _id_C10FF09314E3F687(_id_DDF67F48730C77B1[_id_AC0E594AC96AA3A8]);

      if(!isDefined(_id_32E27AD06C3E7804)) {
        level._id_52B8E16BC0CD79D6++;
        _id_32E27AD06C3E7804 = "unAuthorized_stop_" + level._id_52B8E16BC0CD79D6;
      }

      _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_32E27AD06C3E7804 = _id_32E27AD06C3E7804;
      level._id_40E610580F1CBAF8[_id_32E27AD06C3E7804] = _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8];
    }

    _id_EEC55FABA21F3653.id = _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[0]._id_32E27AD06C3E7804;
    _id_EEC55FABA21F3653._id_33DE00DF8A9FBBE0 = 0;
    _id_EEC55FABA21F3653._id_3EAD649FC902FEC2 = 0;

    if(!isDefined(level.elevators[group]))
      level.elevators[group] = [];

    level.elevators[group][level.elevators[group].size] = _id_EEC55FABA21F3653;
  }

  level._id_DD26B041C74AFBD0 = [];
  level._id_A6C231AB0B186CD7 = [];
  level._id_D4F835AFC5B8309B = [];
  level thread _id_963FC4C3B794E7F0();
  level thread _id_9003BD09B085A887();
  level._id_B212A36BEC6CF8DA = 1;

  if(isDefined(_id_1B64869207D9F98F))
    _id_67E7F45E112E77F2(_id_1B64869207D9F98F);
}

_id_90E407AC8F409CCD(_id_00EBBFD0D8F2A9CF, _id_00EBC0D0D8F2AC02) {
  return _id_00EBBFD0D8F2A9CF.origin[2] < _id_00EBC0D0D8F2AC02.origin[2];
}

_id_298651E30E37AD6A(_id_61EE04CD86F17F18, _id_61EE07CD86F185B1) {
  return distancesquared(_id_61EE04CD86F17F18.origin, self.origin) < distancesquared(_id_61EE07CD86F185B1.origin, self.origin);
}

_id_BA13D98DAB57CA7E(group, state, func) {
  if(!isDefined(level._id_FDD3DFF47723BE1F[group]))
    level._id_FDD3DFF47723BE1F[group] = [];

  level._id_FDD3DFF47723BE1F[group][state] = func;
}

_id_8435B8855414BB47(owner, group, state, _id_9B553BB5E16EF3FF, _id_476FDBC4F0D1EF0A, _id_E108D0ABDB42CFF6, _id_6E7276B7516D41DA, _id_FD5C5E2FFB3B1D08) {
  _id_4087E8C204288C38 = spawnStruct();
  _id_4087E8C204288C38.owner = owner;
  _id_4087E8C204288C38.group = group;
  _id_4087E8C204288C38.state = state;
  _id_4087E8C204288C38._id_9B553BB5E16EF3FF = _id_9B553BB5E16EF3FF;
  _id_4087E8C204288C38._id_476FDBC4F0D1EF0A = _id_476FDBC4F0D1EF0A;
  _id_4087E8C204288C38._id_6B8D91134ACB6B09 = _id_E108D0ABDB42CFF6;
  _id_4087E8C204288C38._id_6E7276B7516D41DA = _id_6E7276B7516D41DA;
  _id_4087E8C204288C38._id_FD5C5E2FFB3B1D08 = _id_FD5C5E2FFB3B1D08;
  level._id_A6C231AB0B186CD7[level._id_A6C231AB0B186CD7.size] = _id_4087E8C204288C38;
}

_id_20E0F2F56A5BA71F(owner, group, state, id, _id_6E7276B7516D41DA, _id_FD5C5E2FFB3B1D08) {
  _id_4087E8C204288C38 = spawnStruct();
  _id_4087E8C204288C38.owner = owner;
  _id_4087E8C204288C38.group = group;
  _id_4087E8C204288C38.state = state;
  _id_4087E8C204288C38._id_476FDBC4F0D1EF0A = "elevator_pick_rule_id";
  _id_4087E8C204288C38.id = id;
  _id_4087E8C204288C38._id_6E7276B7516D41DA = _id_6E7276B7516D41DA;
  _id_4087E8C204288C38._id_FD5C5E2FFB3B1D08 = _id_FD5C5E2FFB3B1D08;
  level._id_A6C231AB0B186CD7[level._id_A6C231AB0B186CD7.size] = _id_4087E8C204288C38;
}

_id_92BEB6591366AB26(owner, group, state, _id_9B553BB5E16EF3FF, _id_476FDBC4F0D1EF0A) {
  _id_EEC55FABA21F3653 = undefined;

  switch (_id_476FDBC4F0D1EF0A) {
    case "elevator_pick_rule_ideal":
      _id_EEC55FABA21F3653 = _id_7BEE30545564F6D2(_id_9B553BB5E16EF3FF);
      break;
  }

  if(isDefined(_id_EEC55FABA21F3653))
    _id_EEC55FABA21F3653 _id_8051BA8F94FDCB81(group, state);

  return _id_EEC55FABA21F3653;
}

_id_FA81150E9ADA1F6A(_id_5DCB93DB1678CDAF) {
  if(!scripts\engine\utility::array_contains(level._id_D4F835AFC5B8309B, _id_5DCB93DB1678CDAF))
    level._id_D4F835AFC5B8309B[level._id_D4F835AFC5B8309B.size] = _id_5DCB93DB1678CDAF;
}

_id_E81853B8E49151BA(_id_5DCB93DB1678CDAF) {
  if(!isDefined(_id_5DCB93DB1678CDAF))
    return 0;

  return scripts\engine\utility::array_contains(level._id_D4F835AFC5B8309B, _id_5DCB93DB1678CDAF);
}

_id_135DE56D99FC05B8(origin) {
  if(isDefined(level._id_172E4B629498723C))
    return [[level._id_172E4B629498723C]](origin);
}

_id_C10FF09314E3F687(_id_D54026D89E48A921) {
  if(isDefined(_id_D54026D89E48A921.script_linkname)) {
    _id_4025B91FA50C1EA7 = strtok(_id_D54026D89E48A921.script_linkname, "_");

    if(isDefined(_id_4025B91FA50C1EA7) && _id_4025B91FA50C1EA7.size > 0) {
      _id_32E27AD06C3E7804 = _id_4025B91FA50C1EA7[1];

      for(_id_AC0E594AC96AA3A8 = 2; _id_AC0E594AC96AA3A8 < _id_4025B91FA50C1EA7.size; _id_AC0E594AC96AA3A8++)
        _id_32E27AD06C3E7804 = _id_32E27AD06C3E7804 + "_" + _id_4025B91FA50C1EA7[_id_AC0E594AC96AA3A8];

      return _id_32E27AD06C3E7804;
    }
  }

  return undefined;
}

_id_9003BD09B085A887() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  foreach(_id_EEC55FABA21F3653 in level.elevators["elevator_group_free"]) {
    _id_DB76C4BB596D090E = _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_EEC55FABA21F3653._id_33DE00DF8A9FBBE0];
    _id_DB76C4BB596D090E._id_6C7D2BF4BA0F495D disconnectPaths();
  }
}

_id_963FC4C3B794E7F0() {
  level endon("game_ended");
  _id_34901859711436C9 = 0;

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_A6C231AB0B186CD7.size; _id_AC0E594AC96AA3A8++) {
      if(level.elevators["elevator_group_free"].size > 0) {
        _id_EEC55FABA21F3653 = undefined;
        _id_3170CA906B2241A6 = level._id_A6C231AB0B186CD7[_id_AC0E594AC96AA3A8];

        switch (_id_3170CA906B2241A6._id_476FDBC4F0D1EF0A) {
          case "elevator_pick_rule_random":
            _id_EEC55FABA21F3653 = _id_7EA9434601358283();
            break;
          case "elevator_pick_rule_random_exclude_picked":
            _id_EEC55FABA21F3653 = _id_2DDB2D81EE6055CE(_id_3170CA906B2241A6.owner);
            break;
          case "elevator_pick_rule_random_exclude_picked_on_specify_floors":
            _id_EEC55FABA21F3653 = _id_2DDB2D81EE6055CE(_id_3170CA906B2241A6.owner, _id_3170CA906B2241A6._id_6B8D91134ACB6B09);
            break;
          case "elevator_pick_rule_ideal":
            _id_EEC55FABA21F3653 = _id_7BEE30545564F6D2(_id_3170CA906B2241A6._id_9B553BB5E16EF3FF);
            break;
          case "elevator_pick_rule_id":
            _id_EEC55FABA21F3653 = _id_AC05B2A25B870E68(_id_3170CA906B2241A6.id);
            break;
        }

        if(isDefined(_id_EEC55FABA21F3653)) {
          if(isDefined(_id_3170CA906B2241A6._id_6E7276B7516D41DA))
            level thread[[_id_3170CA906B2241A6._id_6E7276B7516D41DA]](_id_EEC55FABA21F3653, _id_3170CA906B2241A6._id_FD5C5E2FFB3B1D08);

          _id_EEC55FABA21F3653 _id_8051BA8F94FDCB81(_id_3170CA906B2241A6.group, _id_3170CA906B2241A6.state);
          level._id_A6C231AB0B186CD7[_id_AC0E594AC96AA3A8] = undefined;
          _id_34901859711436C9 = 1;
        }
      }
    }

    if(istrue(_id_34901859711436C9)) {
      level._id_A6C231AB0B186CD7 = scripts\engine\utility::array_removeundefined(level._id_A6C231AB0B186CD7);
      _id_34901859711436C9 = 0;
    }

    waitframe();
  }
}

_id_67E7F45E112E77F2(table) {
  _id_8F117D9581995C82 = 0;
  _id_BBE34F2CCAE3241C = 1;
  _id_977F24E61599CBBA = 0;

  if(tableexists(table))
    _id_977F24E61599CBBA = tablelookupgetnumrows(table);
  else
    return;

  level._id_6FDFDC44A9268868 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    _id_60E5F351E61FADFD = spawnStruct();
    _id_22BCD0FB063692B5 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_8F117D9581995C82);
    _id_7C4E2C6A50914434 = strtok(_id_22BCD0FB063692B5, ", ");
    _id_8518FDD0909B90FD = (float(_id_7C4E2C6A50914434[0]), float(_id_7C4E2C6A50914434[1]), float(_id_7C4E2C6A50914434[2]));
    _id_60E5F351E61FADFD.origin = _id_8518FDD0909B90FD;
    _id_60E5F351E61FADFD.enable = 1;
    _id_474CB0EC00D51C72 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_BBE34F2CCAE3241C);
    _id_975CC022038F8367 = strtok(_id_474CB0EC00D51C72, ", ");
    _id_60E5F351E61FADFD._id_5A5CAA498B10D837 = _id_975CC022038F8367;
    level._id_6FDFDC44A9268868[_id_AC0E594AC96AA3A8] = _id_60E5F351E61FADFD;
  }
}

_id_7EA9434601358283() {
  _id_EEC55FABA21F3653 = scripts\engine\utility::_id_7A2AAA4A09A4D250(level.elevators["elevator_group_free"]);

  if(isDefined(_id_EEC55FABA21F3653)) {
    if(_id_EEC55FABA21F3653._id_E108D0ABDB42CFF6.size > 1)
      _id_EEC55FABA21F3653._id_3EAD649FC902FEC2 = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_EEC55FABA21F3653._id_E108D0ABDB42CFF6);

    return _id_EEC55FABA21F3653;
  }

  return undefined;
}

_id_7BEE30545564F6D2(_id_9B553BB5E16EF3FF) {
  if(!isDefined(level._id_6FDFDC44A9268868) || level._id_6FDFDC44A9268868.size == 0)
    return undefined;

  _id_B7C2EAD7F1429B4A = spawnStruct();
  _id_B7C2EAD7F1429B4A.origin = _id_9B553BB5E16EF3FF;
  _id_2621D6D616A10F79 = _id_B7C2EAD7F1429B4A scripts\engine\utility::array_sort_with_func(level._id_6FDFDC44A9268868, ::_id_298651E30E37AD6A);
  _id_57CDA711A1D5019B = [];

  foreach(node in _id_2621D6D616A10F79) {
    if(istrue(node.enable)) {
      _id_57CDA711A1D5019B = node._id_5A5CAA498B10D837;
      break;
    }
  }

  foreach(_id_32E27AD06C3E7804 in _id_57CDA711A1D5019B) {
    stop = level._id_40E610580F1CBAF8[_id_32E27AD06C3E7804];
    _id_EEC55FABA21F3653 = _id_AC05B2A25B870E68(_id_32E27AD06C3E7804);

    if(isDefined(_id_EEC55FABA21F3653)) {
      _id_E06FA5DC319066FC = 1;

      if(isDefined(level._id_6D879681512CD627))
        _id_E06FA5DC319066FC = [[level._id_6D879681512CD627]](stop, _id_9B553BB5E16EF3FF);

      if(_id_E06FA5DC319066FC)
        return _id_EEC55FABA21F3653;
    }
  }

  return undefined;
}

_id_AC05B2A25B870E68(_id_32E27AD06C3E7804) {
  stop = level._id_40E610580F1CBAF8[_id_32E27AD06C3E7804];

  if(stop._id_EEC55FABA21F3653.group == "elevator_group_free") {
    stop._id_EEC55FABA21F3653._id_3EAD649FC902FEC2 = stop.floor;
    return stop._id_EEC55FABA21F3653;
  }

  return undefined;
}

_id_B7EE067FA2ED527D(_id_32E27AD06C3E7804) {
  return level._id_40E610580F1CBAF8[_id_32E27AD06C3E7804]._id_EEC55FABA21F3653;
}

_id_EA03313F519B9E06(group) {
  return level.elevators[group];
}

_id_E8F746DFA279CEFD(_id_32E27AD06C3E7804) {
  return level._id_40E610580F1CBAF8[_id_32E27AD06C3E7804];
}

_id_E273AC02F95D54E5(owner, _id_631B0D2882D5D238) {
  foreach(_id_6485CB51EB50DC9B in _id_631B0D2882D5D238) {
    foreach(stop in level._id_40E610580F1CBAF8) {
      if(_id_6485CB51EB50DC9B == stop._id_6485CB51EB50DC9B) {
        _id_E3BAFFC8F1C9431B = stop._id_EEC55FABA21F3653;
        _id_552B12DD61440B65 = level._id_DD26B041C74AFBD0[owner][_id_E3BAFFC8F1C9431B.id];

        if(!isDefined(_id_552B12DD61440B65) || scripts\engine\utility::array_contains(_id_552B12DD61440B65._id_9DE3AEC35059FB4B, stop.floor))
          return 1;
      }
    }
  }

  return 0;
}

_id_2DDB2D81EE6055CE(owner, _id_631B0D2882D5D238) {
  if(!isDefined(level._id_DD26B041C74AFBD0[owner]))
    level._id_DD26B041C74AFBD0[owner] = [];

  _id_133738871E398CF3 = [];

  if(!isDefined(_id_631B0D2882D5D238))
    _id_133738871E398CF3 = level._id_D4F835AFC5B8309B;
  else if(isarray(_id_631B0D2882D5D238)) {
    foreach(_id_6485CB51EB50DC9B in _id_631B0D2882D5D238) {
      if(_id_E81853B8E49151BA(_id_6485CB51EB50DC9B))
        _id_133738871E398CF3[_id_133738871E398CF3.size] = _id_6485CB51EB50DC9B;
    }
  } else
    return undefined;

  if(_id_133738871E398CF3.size == 0)
    return undefined;

  _id_95CF8C20B345E817 = [];

  foreach(_id_EEC55FABA21F3653 in level.elevators["elevator_group_free"]) {
    _id_E36E2B32136A86FE = undefined;
    _id_552B12DD61440B65 = level._id_DD26B041C74AFBD0[owner][_id_EEC55FABA21F3653.id];

    if(!isDefined(_id_552B12DD61440B65)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6.size; _id_AC0E594AC96AA3A8++) {
        _id_6485CB51EB50DC9B = _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_6485CB51EB50DC9B;

        if(scripts\engine\utility::array_contains(_id_133738871E398CF3, _id_6485CB51EB50DC9B)) {
          if(!isDefined(_id_E36E2B32136A86FE)) {
            _id_E36E2B32136A86FE = spawnStruct();
            _id_E36E2B32136A86FE._id_96D5EBB0B818388C = [];
            _id_E36E2B32136A86FE._id_EEC55FABA21F3653 = _id_EEC55FABA21F3653;
            _id_95CF8C20B345E817[_id_95CF8C20B345E817.size] = _id_E36E2B32136A86FE;
          }

          _id_E36E2B32136A86FE._id_96D5EBB0B818388C[_id_E36E2B32136A86FE._id_96D5EBB0B818388C.size] = _id_AC0E594AC96AA3A8;
        }
      }

      continue;
    }

    if(_id_552B12DD61440B65._id_9DE3AEC35059FB4B.size > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_552B12DD61440B65._id_9DE3AEC35059FB4B.size; _id_AC0E594AC96AA3A8++) {
        _id_6485CB51EB50DC9B = _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[_id_552B12DD61440B65._id_9DE3AEC35059FB4B[_id_AC0E594AC96AA3A8]]._id_6485CB51EB50DC9B;

        if(scripts\engine\utility::array_contains(_id_133738871E398CF3, _id_6485CB51EB50DC9B)) {
          if(!isDefined(_id_E36E2B32136A86FE)) {
            _id_E36E2B32136A86FE = spawnStruct();
            _id_E36E2B32136A86FE._id_96D5EBB0B818388C = [];
            _id_E36E2B32136A86FE._id_EEC55FABA21F3653 = _id_EEC55FABA21F3653;
            _id_95CF8C20B345E817[_id_95CF8C20B345E817.size] = _id_E36E2B32136A86FE;
          }

          _id_E36E2B32136A86FE._id_96D5EBB0B818388C[_id_E36E2B32136A86FE._id_96D5EBB0B818388C.size] = _id_552B12DD61440B65._id_9DE3AEC35059FB4B[_id_AC0E594AC96AA3A8];
        }
      }
    }
  }

  if(_id_95CF8C20B345E817.size == 0)
    return undefined;

  _id_C814DB13C0ABC6AB = _id_95CF8C20B345E817[randomint(_id_95CF8C20B345E817.size)];
  _id_EEC55FABA21F3653 = _id_C814DB13C0ABC6AB._id_EEC55FABA21F3653;
  _id_96D5EBB0B818388C = _id_C814DB13C0ABC6AB._id_96D5EBB0B818388C;
  _id_552B12DD61440B65 = level._id_DD26B041C74AFBD0[owner][_id_EEC55FABA21F3653.id];

  if(!isDefined(_id_552B12DD61440B65)) {
    _id_552B12DD61440B65 = spawnStruct();
    _id_552B12DD61440B65._id_9DE3AEC35059FB4B = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6.size; _id_AC0E594AC96AA3A8++)
      _id_552B12DD61440B65._id_9DE3AEC35059FB4B[_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;
  }

  _id_EEC55FABA21F3653._id_3EAD649FC902FEC2 = scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_96D5EBB0B818388C);
  _id_552B12DD61440B65._id_9DE3AEC35059FB4B = scripts\engine\utility::array_remove(_id_552B12DD61440B65._id_9DE3AEC35059FB4B, _id_EEC55FABA21F3653._id_3EAD649FC902FEC2);
  level._id_DD26B041C74AFBD0[owner][_id_EEC55FABA21F3653.id] = _id_552B12DD61440B65;
  return _id_EEC55FABA21F3653;
}

_id_8051BA8F94FDCB81(group, state) {
  level.elevators[self.group] = scripts\engine\utility::array_remove(level.elevators[self.group], self);
  self.group = group;
  self.state = state;

  if(!isDefined(level.elevators[group]))
    level.elevators[group] = [];

  level.elevators[group][level.elevators[group].size] = self;
  waitframe();
  thread _id_580E82173AE3940C();
}

_id_1526944EF1762358() {
  level.elevators[self.group] = scripts\engine\utility::array_remove(level.elevators[self.group], self);
  self.group = "elevator_group_free";
  self.state = "";
  level.elevators["elevator_group_free"][level.elevators["elevator_group_free"].size] = self;
  self notify("elevator_release");
}

_id_580E82173AE3940C() {
  level endon("game_ended");
  self endon("elevator_release");

  for(;;) {
    _id_D1DA69720DEC3C33 = 1;

    if(!isDefined(self.group)) {
      _id_D1DA69720DEC3C33 = 0;
      logstring(self.id + " Group is undefined for this elevator");
    }

    if(_id_D1DA69720DEC3C33 && !isDefined(level._id_FDD3DFF47723BE1F[self.group])) {
      _id_D1DA69720DEC3C33 = 0;
      logstring(self.id + " Group " + self.group + " has not registered FSM yet");
    }

    if(_id_D1DA69720DEC3C33 && !isDefined(self.state)) {
      _id_D1DA69720DEC3C33 = 0;
      logstring(self.id + " State is undefined for this elevator in Group: " + self.group);
    }

    if(_id_D1DA69720DEC3C33 && !isDefined(level._id_FDD3DFF47723BE1F[self.group][self.state])) {
      _id_D1DA69720DEC3C33 = 0;
      logstring(self.id + " State " + self.state + " has not been registered FSM to Group: " + self.group);
    }

    if(_id_D1DA69720DEC3C33) {
      logstring("===============Elevator FSM Log===============");
      logstring("Elevator Id: " + self.id);
      logstring("Group: " + self.group);
      logstring("State: " + self.state);
      logstring("===============Elevator FSM Log End===============");
    }

    self[[level._id_FDD3DFF47723BE1F[self.group][self.state]]]();
  }
}

_id_AB1C91150C30299A() {
  duration = self._id_3EAD649FC902FEC2 - self._id_33DE00DF8A9FBBE0;
  duration = scripts\engine\utility::ter_op(duration >= 0, duration, self._id_33DE00DF8A9FBBE0 - self._id_3EAD649FC902FEC2);

  if(duration != 0) {
    _id_26ADB9ABDD954D53("reinforcement_closed");
    self.car moveTo((self.car.origin[0], self.car.origin[1], self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2]._id_E340247A219F2577), duration);
    wait(duration);
    waitframe();
  }

  self._id_33DE00DF8A9FBBE0 = self._id_3EAD649FC902FEC2;
}

_id_FEA8A1D17E4D669F() {
  foreach(door in self.doors)
  door setscriptablepartstate("door", "open", 0);

  wait 2;

  foreach(door in self.doors)
  door.state = door getscriptablepartstate("door");
}

_id_7C2ABB1B0D147A89() {
  foreach(door in self.doors)
  door setscriptablepartstate("door", "closed", 0);

  wait 2;

  foreach(door in self.doors)
  door.state = door getscriptablepartstate("door");
}

_id_88C392696FD02DC4() {
  foreach(door in self.doors)
  door setscriptablepartstate("door", "reinforcement_open", 0);

  wait 2;

  foreach(door in self.doors)
  door.state = door getscriptablepartstate("door");
}

_id_D32C693D3A04F8F8() {
  foreach(door in self.doors)
  door setscriptablepartstate("door", "reinforcement_closed", 0);

  wait 2;

  foreach(door in self.doors)
  door.state = door getscriptablepartstate("door");
}

_id_26ADB9ABDD954D53(_id_D2023E6F2E483030) {
  foreach(floor in self._id_E108D0ABDB42CFF6) {
    foreach(door in floor.doors)
    door setscriptablepartstate("door", _id_D2023E6F2E483030, 0);
  }
}

#using_animtree("script_model");

_id_38338A9A033E68A3() {
  level.scr_animtree["elevator"] = #animtree;
  level.scr_anim["elevator"]["close"] = % iw9_elevator_int_door_close;
  level.scr_animname["elevator"]["close"] = "iw9_elevator_int_door_close";
  level.scr_eventanim["elevator"]["close"] = "iw9_elevator_int_door_close";
  level.scr_animtree["elevator"] = #animtree;
  level.scr_anim["elevator"]["open"] = % iw9_elevator_int_door_open;
  level.scr_animname["elevator"]["open"] = "iw9_elevator_int_door_open";
  level.scr_eventanim["elevator"]["open"] = "iw9_elevator_int_door_open";
}