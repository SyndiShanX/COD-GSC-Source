/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5cda031797dce489.gsc
***********************************************/

_id_25A296C2ED85E35F() {
  if(!level._id_43307855F189EB31._id_82FEDF664AD855EB) {
    return;
  }
  _id_FF712D25592CC337();
  _id_09D3950220A7BBA3 = _id_5B3F79C906B20510();
  level._id_43307855F189EB31._id_C8FAD0C23F319E5B = [];

  foreach(_id_E1EEA2D83BCE4672 in _id_09D3950220A7BBA3)
  level._id_43307855F189EB31._id_C8FAD0C23F319E5B[_id_E1EEA2D83BCE4672._id_0E0624B9863250A2] = _id_E1EEA2D83BCE4672;

  level._id_43307855F189EB31._id_CB1A9A6651A906DF = getdvarint("dvar_C2AEEE6F21D5D332", 4);
}

_id_FF712D25592CC337() {
  game["dialog"]["gulag_jailer_incoming"] = "fght_jalr_gutw";
  game["dialog"]["gulag_jailer_arrived"] = "fght_jalr_guji";
}

_id_5B3F79C906B20510() {
  _id_09D3950220A7BBA3 = [];
  _id_09D3950220A7BBA3[_id_09D3950220A7BBA3.size] = "stationary_guards";
  _id_09D3950220A7BBA3[_id_09D3950220A7BBA3.size] = "mixed_combat";
  _id_09D3950220A7BBA3[_id_09D3950220A7BBA3.size] = "combat_rush";
  _id_09D3950220A7BBA3[_id_09D3950220A7BBA3.size] = "patrol_guards";
  _id_09D3950220A7BBA3[_id_09D3950220A7BBA3.size] = "jailer_guard";
  _id_956D22F6FDB80EA1 = [];

  foreach(_id_E1EEA2D83BCE4672 in _id_09D3950220A7BBA3) {
    _id_7877F7A05191A34A = _id_D873949DC73D9847(_id_E1EEA2D83BCE4672);

    if(isDefined(_id_7877F7A05191A34A))
      _id_956D22F6FDB80EA1[_id_956D22F6FDB80EA1.size] = _id_7877F7A05191A34A;
  }

  return _id_956D22F6FDB80EA1;
}

_id_D873949DC73D9847(_id_0E0624B9863250A2) {
  if(isDefined(_id_0E0624B9863250A2)) {
    _id_F53E52E268D0ECBF = _id_23773068308F7B86(_id_0E0624B9863250A2);
    _id_597299ACD456DB1A = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_FF06B06505B0FFFC", _id_0E0624B9863250A2), _id_F53E52E268D0ECBF);

    if(getDvar("dvar_0865217224DBE397", "") == _id_0E0624B9863250A2 || _id_597299ACD456DB1A > 0) {
      _id_7877F7A05191A34A = spawnStruct();
      _id_7877F7A05191A34A.weight = _id_597299ACD456DB1A;
      _id_7877F7A05191A34A._id_0E0624B9863250A2 = _id_0E0624B9863250A2;

      switch (_id_0E0624B9863250A2) {
        case "stationary_guards":
          _id_7877F7A05191A34A.validatefunc = ::_id_F90BD5CE6FE97249;
          _id_7877F7A05191A34A._id_EC2EC5F083DF61CD = ::_id_609B4C8F19884C6D;
          _id_7877F7A05191A34A._id_DEA1B9B1CDABF819 = ::_id_D19A7FA3B438D083;
          return _id_7877F7A05191A34A;
        case "mixed_combat":
          _id_7877F7A05191A34A.validatefunc = ::_id_E1F36D119D6700F4;
          _id_7877F7A05191A34A._id_EC2EC5F083DF61CD = ::_id_4E90E3F8408F39F8;
          _id_7877F7A05191A34A._id_DEA1B9B1CDABF819 = ::_id_F72C05143DD18BDA;
          return _id_7877F7A05191A34A;
        case "combat_rush":
          _id_7877F7A05191A34A.validatefunc = ::_id_DBE8FAB19CE67EBB;
          _id_7877F7A05191A34A._id_EC2EC5F083DF61CD = ::_id_5467C6BA98A48FC7;
          _id_7877F7A05191A34A._id_DEA1B9B1CDABF819 = ::_id_93082EA5E92E3815;
          return _id_7877F7A05191A34A;
        case "patrol_guards":
          _id_7877F7A05191A34A.validatefunc = ::_id_2F225E6F823D9505;
          _id_7877F7A05191A34A._id_EC2EC5F083DF61CD = ::_id_BFC00912DE655901;
          _id_7877F7A05191A34A._id_DEA1B9B1CDABF819 = ::_id_A8BF9E61AF16BA9F;
          return _id_7877F7A05191A34A;
        case "jailer_guard":
          _id_7877F7A05191A34A.validatefunc = ::_id_CD1A60F4BF6D5907;
          _id_7877F7A05191A34A._id_EC2EC5F083DF61CD = ::_id_2BADF4089A186133;
          _id_7877F7A05191A34A._id_DEA1B9B1CDABF819 = ::_id_536DDEAB33FF6B51;
          return _id_7877F7A05191A34A;
        default:
          _id_7877F7A05191A34A.validatefunc = ::_id_F90BD5CE6FE97249;
          _id_7877F7A05191A34A._id_EC2EC5F083DF61CD = ::_id_609B4C8F19884C6D;
          _id_7877F7A05191A34A._id_DEA1B9B1CDABF819 = ::_id_D19A7FA3B438D083;
          return _id_7877F7A05191A34A;
      }
    }
  }
}

_id_23773068308F7B86(_id_0E0624B9863250A2) {
  if(!isDefined(_id_0E0624B9863250A2))
    return 0;

  switch (_id_0E0624B9863250A2) {
    case "stationary_guards":
      return 0;
    case "mixed_combat":
      return 0;
    case "combat_rush":
      return 0;
    case "patrol_guards":
      return 0;
    case "jailer_guard":
      return 1;
    default:
      return 0;
  }
}

_id_89235E4FE5354B16(arena) {
  if(isDefined(level._id_43307855F189EB31._id_C8FAD0C23F319E5B)) {
    _id_0BC2C7EBC26E6B6F = [];

    foreach(_id_E1EEA2D83BCE4672 in level._id_43307855F189EB31._id_C8FAD0C23F319E5B) {
      if(isDefined(_id_E1EEA2D83BCE4672.validatefunc) && [[_id_E1EEA2D83BCE4672.validatefunc]](arena))
        _id_0BC2C7EBC26E6B6F[_id_0BC2C7EBC26E6B6F.size] = _id_E1EEA2D83BCE4672._id_0E0624B9863250A2;
    }

    _id_055D94B80D7D0A4A = getDvar("dvar_0865217224DBE397", "");
    _id_3CB75658113711A4 = "stationary_guards";

    if(_id_055D94B80D7D0A4A == "")
      _id_3CB75658113711A4 = _id_9CE8F3ADE5C16FB7(_id_0BC2C7EBC26E6B6F);
    else if(isDefined(level._id_43307855F189EB31._id_C8FAD0C23F319E5B[_id_055D94B80D7D0A4A]))
      _id_3CB75658113711A4 = _id_055D94B80D7D0A4A;
    else
      _id_024601896FE5FA52("Invalid Variation Type given for override. Using default variation.");

    _id_9A8B9DA48E504ED3 = level._id_43307855F189EB31._id_C8FAD0C23F319E5B[_id_3CB75658113711A4];

    if(isDefined(_id_9A8B9DA48E504ED3._id_EC2EC5F083DF61CD)) {
      arena._id_A88CD2794AE356A7 = _id_9A8B9DA48E504ED3;
      [[_id_9A8B9DA48E504ED3._id_EC2EC5F083DF61CD]](arena);
    }
  }
}

_id_9CE8F3ADE5C16FB7(_id_50F938AF0FFCDE52) {
  _id_C35D9F1ADC6B131F = 0.0;
  _id_414D201BFCA427A2 = [];

  foreach(_id_40EF999C46820A15 in _id_50F938AF0FFCDE52) {
    _id_7877F7A05191A34A = level._id_43307855F189EB31._id_C8FAD0C23F319E5B[_id_40EF999C46820A15];
    _id_597299ACD456DB1A = _id_7877F7A05191A34A.weight;
    _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + _id_597299ACD456DB1A;
    _id_414D201BFCA427A2[_id_40EF999C46820A15] = _id_C35D9F1ADC6B131F;
  }

  _id_F3FD55934AF8F5D1 = randomfloat(_id_C35D9F1ADC6B131F);

  foreach(_id_40EF999C46820A15 in _id_50F938AF0FFCDE52) {
    if(_id_414D201BFCA427A2[_id_40EF999C46820A15] >= _id_F3FD55934AF8F5D1)
      return _id_40EF999C46820A15;
  }

  return "stationary_guards";
}

_id_024601896FE5FA52(message) {
  if(getdvarint("dvar_AC25B65055B213B3", 0))
    logstring("AI GULAG VARIATIONS: " + message);
}

_id_F90BD5CE6FE97249(arena) {
  return 1;
}

_id_609B4C8F19884C6D(arena) {
  foreach(_id_55E69FB0CE97F15E in arena._id_79F102B3ABCC6F8A)
  thread _id_CA641BB5167E4A5B(arena, _id_55E69FB0CE97F15E);
}

_id_CA641BB5167E4A5B(arena, _id_55E69FB0CE97F15E, _id_1439F86640D42E34, _id_7CA24826046F8EE3, _id_8E5A9B658FA525ED) {
  level endon("game_ended");

  if(!isDefined(_id_1439F86640D42E34))
    _id_1439F86640D42E34 = "smg";

  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_1439F86640D42E34, _id_7CA24826046F8EE3, _id_8E5A9B658FA525ED);
  _id_2AC210AF318CF38B = _id_55E69FB0CE97F15E.origin;

  if(!getdvarint("dvar_B3D7A9483362813E", 0))
    _id_2AC210AF318CF38B = getclosestpointonnavmesh(_id_55E69FB0CE97F15E.origin);

  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread _id_46FDF7B12C5F5620::_id_C31F3A6EF58A2928(arena);

    if(getdvarint("dvar_B3D7A9483362813E", 0)) {
      agent forceteleport(_id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles);
      agent setgoalpos(agent.origin, 32);
      agent clearpath();
      agent.fixednode = 1;
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent, 1, agent.origin);
    } else
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
  }
}

_id_D19A7FA3B438D083(arena, _id_0536AC6B9E3D2178) {}

_id_E1F36D119D6700F4(arena) {
  return 1;
}

_id_4E90E3F8408F39F8(arena) {
  foreach(_id_55E69FB0CE97F15E in arena._id_79F102B3ABCC6F8A) {
    if(isstartstr(_id_55E69FB0CE97F15E.script_noteworthy, "gulag_ai_enemy_armory")) {
      thread _id_55EFD2583D54DF2A(arena, _id_55E69FB0CE97F15E, undefined, 2);
      continue;
    }

    if(isstartstr(_id_55E69FB0CE97F15E.script_noteworthy, "gulag_ai_enemy_meeting")) {
      thread _id_CA641BB5167E4A5B(arena, _id_55E69FB0CE97F15E, undefined, 2);
      continue;
    }

    if(isstartstr(_id_55E69FB0CE97F15E.script_noteworthy, "gulag_ai_enemy_economy")) {
      thread _id_55EFD2583D54DF2A(arena, _id_55E69FB0CE97F15E);
      continue;
    }

    if(isstartstr(_id_55E69FB0CE97F15E.script_noteworthy, "gulag_ai_enemy_bar"))
      thread _id_CA641BB5167E4A5B(arena, _id_55E69FB0CE97F15E);
  }
}

_id_F72C05143DD18BDA(arena, _id_0536AC6B9E3D2178) {}

_id_DBE8FAB19CE67EBB(arena) {
  return 1;
}

_id_5467C6BA98A48FC7(arena) {
  foreach(_id_55E69FB0CE97F15E in arena._id_79F102B3ABCC6F8A)
  thread _id_55EFD2583D54DF2A(arena, _id_55E69FB0CE97F15E);
}

_id_55EFD2583D54DF2A(arena, _id_55E69FB0CE97F15E, _id_1439F86640D42E34, _id_7CA24826046F8EE3, _id_8E5A9B658FA525ED) {
  level endon("game_ended");

  if(!isDefined(_id_1439F86640D42E34))
    _id_1439F86640D42E34 = "smg";

  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_1439F86640D42E34, _id_7CA24826046F8EE3, _id_8E5A9B658FA525ED);
  _id_2AC210AF318CF38B = getclosestpointonnavmesh(_id_55E69FB0CE97F15E.origin);
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);

  if(isagent(agent)) {
    agent thread _id_46FDF7B12C5F5620::_id_C31F3A6EF58A2928(arena);
    arena waittill("ai_gulag_matchStarted");
    _id_C5E7FCE963586EC0 = arena.fightspawns[0].origin;
    agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, _id_C5E7FCE963586EC0);
  }
}

_id_93082EA5E92E3815(arena, _id_0536AC6B9E3D2178) {}

_id_2F225E6F823D9505(arena) {
  return 1;
}

_id_BFC00912DE655901(arena) {
  _id_DEB852AEE36CBAF9 = getdvarint("dvar_F8FE15AAF2F77C90", 3);

  if(_id_DEB852AEE36CBAF9 <= 0) {
    return;
  }
  _id_4D0DEC66237FE9AE = getdvarfloat("dvar_FAB0873E75ED4193", 8.0);
  _id_3C3D57FD381F981B = 0;
  _id_BFE291B401A9BF2A = scripts\engine\utility::array_randomize(arena._id_79F102B3ABCC6F8A);
  _id_1439F86640D42E34 = undefined;

  if(_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena) && level._id_43307855F189EB31._id_CB1A9A6651A906DF == 4) {
    _id_1439F86640D42E34 = "jugg";

    if(!isDefined(level._id_6A4C9FBD7AA58544)) {
      level._id_6A4C9FBD7AA58544 = [];
      _id_6172179F6BD0769E::_id_4C60C607A6E7B9AE();

      foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
        if(getdvarint(_func_2EF675C13CA1C4AF("scr_", _id_E2958F412A7425C0.name, "_disabled"), 0) > 0) {
          _id_E2958F412A7425C0.disabled = 1;
          continue;
        }

        if(isDefined(_id_E2958F412A7425C0._id_EC2EC5F083DF61CD))
          [[_id_E2958F412A7425C0._id_EC2EC5F083DF61CD]](_id_E2958F412A7425C0);
      }
    }
  }

  foreach(_id_55E69FB0CE97F15E in _id_BFE291B401A9BF2A) {
    thread _id_287401A3027DB2BF(arena, _id_55E69FB0CE97F15E, _id_1439F86640D42E34, level._id_43307855F189EB31._id_CB1A9A6651A906DF, undefined, _id_4D0DEC66237FE9AE);
    _id_3C3D57FD381F981B++;

    if(_id_3C3D57FD381F981B >= _id_DEB852AEE36CBAF9) {
      break;
    }
  }
}

_id_A8BF9E61AF16BA9F(arena, _id_0536AC6B9E3D2178) {}

_id_287401A3027DB2BF(arena, _id_55E69FB0CE97F15E, _id_1439F86640D42E34, _id_7CA24826046F8EE3, _id_8E5A9B658FA525ED, _id_4D0DEC66237FE9AE) {
  level endon("game_ended");

  if(!isDefined(_id_1439F86640D42E34))
    _id_1439F86640D42E34 = "smg";

  agent = undefined;
  _id_2AC210AF318CF38B = _id_55E69FB0CE97F15E.origin;
  _id_2AC210AF318CF38B = getgroundposition(_id_2AC210AF318CF38B, 12);

  if(_id_1439F86640D42E34 == "jugg") {
    _id_55E69FB0CE97F15E.origin = _id_2AC210AF318CF38B;
    agent = _id_6172179F6BD0769E::_id_7F6818BE5068DD4E(_id_55E69FB0CE97F15E, "gulag");
    weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_sm_aviktor", ["thermal01", "none", "none", "none", "silencer01_sm", "laserirsmg"], "none", "none");
    agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, weapon);
  } else {
    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_1439F86640D42E34, _id_7CA24826046F8EE3, _id_8E5A9B658FA525ED);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);
  }

  if(!isDefined(agent)) {
    _id_024601896FE5FA52("Agent failed to spawn in arena: " + arena.gulagindex);
    return;
  }

  agent.baseaccuracy = getdvarfloat("dvar_3EC2E682B32338FE", 0.6);
  agent.accuracy = agent.baseaccuracy;
  agent.maxsightdistsqrd = getdvarfloat("dvar_1F2B18095C07FD11", 31360000);

  if(isagent(agent)) {
    agent _id_46FDF7B12C5F5620::_id_C31F3A6EF58A2928(arena);
    agent._id_4D0DEC66237FE9AE = _id_4D0DEC66237FE9AE;

    if(isDefined(arena._id_D7BAAFC9B07F5094) && arena._id_D7BAAFC9B07F5094.size > 0) {
      pathstruct = arena._id_D7BAAFC9B07F5094[randomint(arena._id_D7BAAFC9B07F5094.size)];
      _id_2F55781AF96F22F9 = _id_93E03A3112114BFB(_id_2AC210AF318CF38B, pathstruct.path);
      level thread _id_120270BD0A747A35::_id_25CC93D439C3033A([agent], pathstruct, _id_2F55781AF96F22F9);
    } else
      level thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
  }
}

_id_CD1A60F4BF6D5907(arena) {
  return 1;
}

_id_2BADF4089A186133(arena) {
  if(!isDefined(level._id_6A4C9FBD7AA58544) && (_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena) && level._id_43307855F189EB31._id_CB1A9A6651A906DF == 4)) {
    level._id_6A4C9FBD7AA58544 = [];
    _id_6172179F6BD0769E::_id_4C60C607A6E7B9AE();

    foreach(_id_E2958F412A7425C0 in level._id_6A4C9FBD7AA58544) {
      if(getdvarint(_func_2EF675C13CA1C4AF("scr_", _id_E2958F412A7425C0.name, "_disabled"), 0) > 0) {
        _id_E2958F412A7425C0.disabled = 1;
        continue;
      }

      if(isDefined(_id_E2958F412A7425C0._id_EC2EC5F083DF61CD))
        [[_id_E2958F412A7425C0._id_EC2EC5F083DF61CD]](_id_E2958F412A7425C0);
    }
  }

  _id_55E69FB0CE97F15E = undefined;

  if(getdvarint("dvar_FBF0C13AB4A94311", 0))
    _id_55E69FB0CE97F15E = arena._id_198C1CB09F6DBFB1;
  else {
    _id_BFE291B401A9BF2A = scripts\engine\utility::array_randomize(arena._id_79F102B3ABCC6F8A);
    _id_55E69FB0CE97F15E = _id_BFE291B401A9BF2A[0];
  }

  thread _id_5038458E3CEEB5BD(arena, _id_55E69FB0CE97F15E);
}

_id_5E687A5A783B435D(_id_FB8418425DC67596) {
  result = [-1.0, -1.0, -1.0, -1.0];
  index = 0;

  foreach(player in _id_FB8418425DC67596.gulagarena.arenaplayers) {
    if(index == 4) {
      break;
    }

    if(isDefined(player)) {
      result[index] = float(player getentitynumber());
      index++;
    }
  }

  return result;
}

_id_5038458E3CEEB5BD(arena, _id_55E69FB0CE97F15E) {
  level endon("game_ended");
  arena endon("matchEnded");
  arena endon("fight_over");
  _id_2AC210AF318CF38B = _id_55E69FB0CE97F15E.origin;
  _id_2AC210AF318CF38B = getgroundposition(_id_2AC210AF318CF38B, 12);
  _id_55E69FB0CE97F15E.origin = _id_2AC210AF318CF38B;
  _id_7CA24826046F8EE3 = level._id_43307855F189EB31._id_CB1A9A6651A906DF;
  _id_0E46E01E060830B0 = getdvarfloat("dvar_28FC993237FC1087", 30.0);
  _id_5F9B4FD184DCB3A2 = max(0.0, getdvarfloat("dvar_C75FAE28E8A2210E", 6.0));
  _id_74B5B12BB6514385 = max(0.0, _id_0E46E01E060830B0 - _id_5F9B4FD184DCB3A2);
  wait(_id_74B5B12BB6514385);

  if(_id_3583FF375AB3A91E::_id_D8F18F1D691C0EF8(arena) && isarray(arena.arenaplayers)) {
    foreach(player in arena.arenaplayers)
    player _id_3583FF375AB3A91E::_id_696F54DA8FCB6BBE("gulag_jailer_incoming", arena);
  }

  wait(_id_5F9B4FD184DCB3A2);

  if(_id_7CA24826046F8EE3 == 4)
    agent = _id_6172179F6BD0769E::_id_7F6818BE5068DD4E(_id_55E69FB0CE97F15E, "gulag");
  else {
    _id_1439F86640D42E34 = "shotgun";
    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_1439F86640D42E34, _id_7CA24826046F8EE3);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, _id_55E69FB0CE97F15E.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1);
  }

  if(!isDefined(agent)) {
    _id_024601896FE5FA52("Agent failed to spawn in arena: " + arena.gulagindex);
    return;
  }

  weapon = undefined;
  _id_39A346ED89FA49AE = getDvar("dvar_B29E4F282F8EEA21", "");

  switch (_id_39A346ED89FA49AE) {
    case "smg":
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_sm_aviktor", ["thermal01", "none", "none", "none", "silencer01_sm", "none"], "none", "none");
      break;
    case "melee":
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
      break;
    case "shotgun":
      weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_sh_charlie725_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    default:
      break;
  }

  body = undefined;
  head = undefined;
  helmet = undefined;

  if(_id_7CA24826046F8EE3 < 4) {
    body = "body_sp_opforce_shadow_company_elite_3_1";
    head = "head_sp_opforce_shadow_company_elite_3_1";
    helmet = getdvarint("dvar_BEB5C0190B33FEA0", 10);
  } else
    helmet = getdvarint("dvar_BEB5C0190B33FEA0", 1500);

  armor = getdvarint("dvar_882A30A0C7844F34", 3400);
  agent scripts\mp\mp_agent::set_agent_health(getdvarint("br_ai_gulag_jailer_health", 100));
  _id_A664AAD02EE98BD2 = getdvarint("dvar_617969F5D3FA5BB5", "frag_grenade_mp");
  grenadeammo = getdvarint("dvar_6529E1ACE08F3F17", 0);
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet, 1);
  agent._id_C5459B9332D53733 = getdvarfloat("dvar_727C76A293D85E6F", 4);
  agent.maxsightdistsqrd = getdvarfloat("dvar_FA26F07D026720BE", 12250000);
  agent._id_2626D6897D71B728 = getdvarfloat("dvar_57F1A5678A01B7EB", 12250000);
  agent._id_B4E73B5C37FE850F = getdvarint("dvar_8B0D1BD49A4054B5", 0);
  agent.combatmode = getDvar("dvar_46CEFFC16960F65E", "no_cover");
  agent.goalradius = getdvarint("dvar_D9A7939C74C23D34", 3200);
  agent._id_9FF99CFC426066A2 = agent.goalradius;
  agent.ballowexecutions = getdvarint("dvar_52D3883D39C08659", 1);
  agent.minpaindamage = getdvarint("dvar_289B813A732C2672", 450);
  agent._id_9440DC8A2AA90AED = getdvarint("dvar_61EC5D7484718BC9", 500);
  agent._id_7D606BEC79308EB5 = getdvarint("dvar_A0B1E91F87FAF171", 768);
  agent._id_85A0F6383A5DD784 = getdvarint("dvar_F2334AA4FA920550", 512);
  agent._id_A67833FEA11A521C = getdvarint("dvar_95A0623D74D35620", 128);
  agent._id_0427CBD3288A2F59 = getdvarint("dvar_CB0A08EDCAC4931D", 128);
  agent._id_789BF98B36E292DB = getdvarint("dvar_34A27361609EFE2F", 1000);
  agent._id_7878EF8B36BC3525 = getdvarint("dvar_347F81616078D541", 500);
  _id_4AAF2FA9E5D0F74A = 8.0;
  _id_8C0F071F480A9D9A = getdvarfloat("dvar_8BE34599DFA102B8", 30.0) + getdvarfloat("scr_br_fc_overtime", 30.0) - (getdvarfloat("dvar_28FC993237FC1087", 25.0) + _id_4AAF2FA9E5D0F74A);
  _func_1B688B532168CD14(::_id_5E687A5A783B435D);
  agent _meth_E451EECC3A7441C3("default", _id_8C0F071F480A9D9A);
  agent._id_6C66AFBC7F2CE4B0 = 1;
  agent.gulagarena = arena;
  agent._id_2A3CA6FC2D0E1CDC = agent.armorhealth + agent.maxhealth;
  agent._id_5888FE9DAC2D7D8E = getdvarint("dvar_2E956FD207E71D5A", 5);
  level._id_C0F958F7943F0CDE = ::_id_D6BF9D11FD14ACBC;
  agent _id_0450E0E26617A68F();
  _id_6CFB886A97484C55 = [];
  _id_6CFB886A97484C55[_id_6CFB886A97484C55.size] = "wz_gulag_jailer_death_a";
  _id_6CFB886A97484C55[_id_6CFB886A97484C55.size] = "wz_gulag_jailer_death_b";
  _id_6CFB886A97484C55[_id_6CFB886A97484C55.size] = "wz_gulag_jailer_death_c";
  _id_6CFB886A97484C55[_id_6CFB886A97484C55.size] = "wz_gulag_jailer_death_d";
  agent.deathstate = "animscripted";
  agent.deathalias = scripts\engine\utility::random(_id_6CFB886A97484C55);

  if(isagent(agent)) {
    agent _id_03AA8E63A56E3416::_id_82EEE32BB4C490D8(arena);

    if(istrue(level._id_43307855F189EB31._id_6712560A5EF54A88))
      agent.nocorpse = 1;

    arena notify("Jailer_Spawned");
    agent.ignoreall = 1;
    agent playLoopSound("mus_jugg_01_hp");
    agent setclothtype("nylon");
    agent _meth_8ABE5A968CC3C220("scubagr");
    agent _id_3F32B2AC35F3EA96(arena);
    level thread _id_DABF898F5F2A99E5(agent, arena);
    agent.ignoreall = 0;
  }
}

_id_536DDEAB33FF6B51(arena) {}

_id_0450E0E26617A68F() {
  if(!getdvarint("dvar_3019C51AAA25B462", 0)) {
    return;
  }
  arena = self.gulagarena;
  _id_F7A309109C19A8EB = scripts\engine\utility::array_combine(arena.arenaplayers, arena.jailedplayers);

  foreach(player in _id_F7A309109C19A8EB)
  player setclientomnvar("ui_br_twotwo_gulag_jailer_health", 100);
}

_id_D6BF9D11FD14ACBC(idamage) {
  if(isDefined(self._id_2A3CA6FC2D0E1CDC) && isDefined(idamage) && idamage >= 0 && getdvarint("dvar_3019C51AAA25B462", 0)) {
    _id_C047DEEA265F1E49 = self.health + self.armorhealth;
    _id_8C3CE3103E9D62EF = int(ceil(_id_C047DEEA265F1E49 / self._id_2A3CA6FC2D0E1CDC * 100));
    arena = self.gulagarena;
    _id_F7A309109C19A8EB = scripts\engine\utility::array_combine(arena.arenaplayers, arena.jailedplayers);

    foreach(player in _id_F7A309109C19A8EB)
    player setclientomnvar("ui_br_twotwo_gulag_jailer_health", _id_8C3CE3103E9D62EF);
  }
}

_id_3F32B2AC35F3EA96(arena) {
  _id_7408385AE587EBAD = [];
  _id_7408385AE587EBAD[_id_7408385AE587EBAD.size] = "wz_gulag_jailer_enter_a";
  _id_7408385AE587EBAD[_id_7408385AE587EBAD.size] = "wz_gulag_jailer_enter_b";
  _id_7408385AE587EBAD[_id_7408385AE587EBAD.size] = "wz_gulag_jailer_enter_c";
  _id_7408385AE587EBAD[_id_7408385AE587EBAD.size] = "wz_gulag_jailer_enter_d";
  _id_FEB9DED19A11D621 = [];
  _id_FEB9DED19A11D621[_id_FEB9DED19A11D621.size] = "wz_gulag_jailer_enter_doors_a";
  _id_FEB9DED19A11D621[_id_FEB9DED19A11D621.size] = "wz_gulag_jailer_enter_doors_b";
  _id_FEB9DED19A11D621[_id_FEB9DED19A11D621.size] = "wz_gulag_jailer_enter_doors_c";
  _id_FEB9DED19A11D621[_id_FEB9DED19A11D621.size] = "wz_gulag_jailer_enter_doors_d";
  _id_F019F5897A011C52 = randomint(4);
  self.animationarchetype = "juggernaut";
  startpos = arena._id_198C1CB09F6DBFB1.origin;
  startangles = arena._id_198C1CB09F6DBFB1.angles;
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", _id_7408385AE587EBAD[_id_F019F5897A011C52]);
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  _id_BCF9684C0529009A = getstartorigin(startpos, startangles, xanim);
  _id_F20BC08C9FC211A0 = getstartangles(startpos, startangles, xanim);
  self forceteleport(_id_BCF9684C0529009A, _id_F20BC08C9FC211A0);
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
  self dontinterpolate();

  foreach(player in arena.arenaplayers) {
    player scripts\engine\utility::delaycall(0.1, ::setplayermusicstate, "mx_mp_br_gulag_juggernaut");
    player scripts\engine\utility::delaythread(2.3, scripts\mp\hud_message::showsplash, "br_twotwo_gulag_jailer_spawn");

    if(istrue(level._id_43307855F189EB31._id_41BA817A6AA8EA0A))
      player scripts\engine\utility::delaythread(3.5, _id_3583FF375AB3A91E::_id_696F54DA8FCB6BBE, "gulag_jailer_arrived", arena);
  }

  arena._id_945AC0DF95F159B3 scriptmodelplayanimdeltamotionfrompos(_id_FEB9DED19A11D621[_id_F019F5897A011C52], arena._id_198C1CB09F6DBFB1.origin, arena._id_198C1CB09F6DBFB1.angles);
  self aisetanim("animscripted", animindex);
  self animmode("noclip");
  _id_228C1F2F3A2D92F1 = getanimlength(xanim);
  wait(_id_228C1F2F3A2D92F1);
  thread _id_C7E36FCF1462F9AF(arena);
  _id_3D698930D3181F40 = _id_B6D4A15B2927BE20(arena);
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", "wz_gulag_jailer_well_walk_forward");
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);
  _id_BCF9684C0529009A = getstartorigin(startpos, startangles, xanim);
  _id_F20BC08C9FC211A0 = getstartangles(startpos, startangles, xanim);
  self forceteleport(_id_BCF9684C0529009A + (0, 0, 8), _id_F20BC08C9FC211A0);
  self dontinterpolate();
  self aisetanim("animscripted", animindex);
  self animmode("noclip");
  _id_228C1F2F3A2D92F1 = getanimlength(xanim);
  wait(_id_228C1F2F3A2D92F1);
  scripts\asm\asm_bb::bb_clearanimScripted();
}

_id_C7E36FCF1462F9AF(arena) {
  _id_B14B8CDC38138DB8 = 160;
  _id_59D38865512DCBF9 = 10;
  _id_78A3D5C778457697 = 75;
  _id_BF4CEAB43C3815C9 = 600;
  _id_D88864D300C4668D = 1100;
  _id_96DB99F7468F1547 = [];

  foreach(player in arena.arenaplayers) {
    if(!isDefined(player)) {
      continue;
    }
    _id_9D6746D0624B17FB = distance2d(player.origin, arena._id_198C1CB09F6DBFB1.origin);
    _id_785B4DA79140E397 = abs(player.origin[2] - arena._id_198C1CB09F6DBFB1.origin[2]);

    if(_id_9D6746D0624B17FB < _id_B14B8CDC38138DB8 && _id_785B4DA79140E397 <= _id_59D38865512DCBF9)
      _id_96DB99F7468F1547[_id_96DB99F7468F1547.size] = player;
  }

  foreach(player in _id_96DB99F7468F1547) {
    _id_06A214550D82154A = undefined;
    _id_9D6746D0624B17FB = distance2d(player.origin, arena._id_198C1CB09F6DBFB1.origin);
    _id_06A214550D82154A = vectorNormalize(player.origin - arena._id_198C1CB09F6DBFB1.origin) * scripts\engine\utility::ter_op(_id_9D6746D0624B17FB < _id_78A3D5C778457697, _id_D88864D300C4668D, _id_BF4CEAB43C3815C9);
    player setvelocity(_id_06A214550D82154A);
  }

  scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(arena._id_198C1CB09F6DBFB1.origin, undefined, 3.5, _id_B14B8CDC38138DB8);
}

_id_B6D4A15B2927BE20(arena) {}

_id_DABF898F5F2A99E5(agent, arena) {
  agent endon("death");
  _id_120270BD0A747A35::_id_1670C315976C767B();
  wait 1;
  agent.meleechargedistvsplayer = 100;
  agent.meleechargedist = 100;

  if(getdvarint("dvar_8BF4874031AF778A", 0))
    _id_411C2B5EC5ACD20A(agent, arena);
  else {}
}

_id_1B065D8D74E9EB4C(agent, arena) {
  _id_A28ACEEAA1666056 = getdvarint("dvar_8D0B6A1B71C97774", 100);
  _id_5F246A59FF52B9CB = getdvarint("dvar_2BE23112DF934CB6", 8);
  _id_624C453A0DACE3BE = getdvarint("dvar_0F31E28C193AE06A", 0);
  _id_8B9C7217FE2AE0E8 = getdvarint("dvar_47D84E982292419C", 1);

  for(;;) {
    while(!agent.baimedataimtarget)
      waitframe();

    if(_id_8B9C7217FE2AE0E8) {
      agent thread _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_jugg_sweep", "caps/common/cap_jugg_sweep");
      agent waittill("cap_exit_completed");
      continue;
    }

    _id_63A5B32B096323BE = agent getshootfrompos();
    _id_CFF075B05A95577B = agent getshootpos(_id_63A5B32B096323BE);
    _id_5E327849C41B7DD8 = undefined;

    if(isDefined(_id_CFF075B05A95577B))
      _id_5E327849C41B7DD8 = _id_CFF075B05A95577B.shootpos;
    else
      _id_5E327849C41B7DD8 = agent lastknownpos(agent.enemy);

    forwardvec = vectorNormalize(_id_5E327849C41B7DD8 - _id_63A5B32B096323BE);
    agent.dontmelee = 1;
    agent setbtgoalpos(3, agent.origin);
    _id_01B785CD99212D6D = forwardvec * 100 + _id_63A5B32B096323BE;
    _id_3FF0C90A7E138C20 = scripts\engine\utility::spawn_script_origin(_id_01B785CD99212D6D);

    if(_id_624C453A0DACE3BE)
      thread scripts\mp\utility\debug::drawsphere(_id_3FF0C90A7E138C20.origin, 25, 5, (0, 1, 0));

    level thread _id_32308E52CCFF8164(_id_3FF0C90A7E138C20, agent);
    agent setentitytarget(_id_3FF0C90A7E138C20);
    waitframe();
    _id_4C44BD3C9BAC5AE2 = vectortoangles(forwardvec);
    _id_579B30DA898346E1 = _id_4C44BD3C9BAC5AE2[1] + _id_A28ACEEAA1666056;
    _id_38A99723F45FA9A2 = anglesToForward((0, _id_579B30DA898346E1, 0)) * distance2d(_id_01B785CD99212D6D, _id_63A5B32B096323BE);
    _id_75A658E067E7548C = _id_01B785CD99212D6D + _id_38A99723F45FA9A2;

    if(_id_624C453A0DACE3BE)
      thread scripts\mp\utility\debug::drawsphere(_id_75A658E067E7548C, 25, 5, (0, 1, 1));

    _id_3FF0C90A7E138C20 moveTo(_id_75A658E067E7548C, agent._id_5888FE9DAC2D7D8E);
    wait(agent._id_5888FE9DAC2D7D8E);
    agent forcereloading();
    agent.bulletsinclip = 0;
    agent.dontevershoot = 1;
    agent clearentitytarget();
    _id_3FF0C90A7E138C20 delete();
    agent setgoalpos(agent.origin, 10000);
    agent.dontmelee = 0;
    wait(_id_5F246A59FF52B9CB);
    agent.dontevershoot = 0;
  }
}

_id_32308E52CCFF8164(_id_3FF0C90A7E138C20, agent) {
  _id_3FF0C90A7E138C20 endon("death");
  agent waittill("death");
  _id_3FF0C90A7E138C20 delete();
}

_id_411C2B5EC5ACD20A(agent, arena) {
  _id_56CD131A91453511 = getdvarfloat("dvar_15EC5F864D15E41D", 0.5);
  _id_6FA953E577ADC01E = getdvarfloat("dvar_E54D8527EE6A429A", 0.4);
  _id_600A0CC182C41CBD = getdvarfloat("dvar_1A17D98123E7F319", 0.1);
  _id_00DE3194C9477B34 = getdvarfloat("dvar_ECAA9BFA3F51C620", 10.0);

  for(;;) {
    _id_C9D16956EB3A9D44 = [];
    _id_8980DD54AFD4CD16 = 0;
    _id_B5BC250D2565700A = 0;
    _id_D0C5A54A30143B50 = [];
    _id_62F96D9FB747538F = [];
    _id_7A9097C1CBFC3BDE = [];

    foreach(player in arena.arenaplayers) {
      if(isalive(player)) {
        _id_B47A8CC2E1180256 = scripts\engine\utility::array_contains(arena._id_801CDCFADC4D465C, player);
        playerid = player getentitynumber();
        _id_62F96D9FB747538F = scripts\engine\utility::array_add(_id_62F96D9FB747538F, player);

        if(_id_B47A8CC2E1180256)
          _id_8980DD54AFD4CD16++;
        else
          _id_8980DD54AFD4CD16--;

        if(isDefined(player._id_A6E0850023A9D8F9)) {
          if(!isDefined(player._id_9EAD71E797F9EEBB))
            player._id_9EAD71E797F9EEBB = 0;

          _id_D0C5A54A30143B50[playerid] = player._id_A6E0850023A9D8F9 - player._id_9EAD71E797F9EEBB;
          _id_B5BC250D2565700A = _id_B5BC250D2565700A + _id_D0C5A54A30143B50[playerid];
          player._id_9EAD71E797F9EEBB = player._id_A6E0850023A9D8F9;
        }
      }
    }

    _id_62F96D9FB747538F = sortbydistance(_id_62F96D9FB747538F, agent.origin);
    _id_86380489B943A379 = -1;
    _id_22C69A24A1AD0D6A = undefined;

    for(index = 0; index < _id_62F96D9FB747538F.size; index++) {
      player = _id_62F96D9FB747538F[index];
      playerid = player getentitynumber();
      _id_C9D16956EB3A9D44[playerid] = 0;

      if(!istrue(arena._id_5F525E1E05714BB5)) {
        _id_B47A8CC2E1180256 = scripts\engine\utility::array_contains(arena._id_801CDCFADC4D465C, player);

        if(_id_B47A8CC2E1180256 && _id_8980DD54AFD4CD16 > 0)
          _id_C9D16956EB3A9D44[playerid] = _id_C9D16956EB3A9D44[playerid] + _id_56CD131A91453511;
        else if(!_id_B47A8CC2E1180256 && _id_8980DD54AFD4CD16 < 0)
          _id_C9D16956EB3A9D44[playerid] = _id_C9D16956EB3A9D44[playerid] + _id_56CD131A91453511;
      }

      if(isDefined(_id_D0C5A54A30143B50[playerid]) && _id_B5BC250D2565700A > 0) {
        _id_15DBE60970AAB166 = _id_D0C5A54A30143B50[playerid] / _id_B5BC250D2565700A * _id_6FA953E577ADC01E;
        _id_C9D16956EB3A9D44[playerid] = _id_C9D16956EB3A9D44[playerid] + _id_15DBE60970AAB166;
      }

      _id_D6F25D5146EBEBA0 = (_id_62F96D9FB747538F.size - index) / _id_62F96D9FB747538F.size * _id_600A0CC182C41CBD;
      _id_C9D16956EB3A9D44[playerid] = _id_C9D16956EB3A9D44[playerid] + _id_D6F25D5146EBEBA0;

      if(_id_C9D16956EB3A9D44[playerid] > _id_86380489B943A379) {
        _id_86380489B943A379 = _id_C9D16956EB3A9D44[playerid];
        _id_22C69A24A1AD0D6A = player;
      }
    }

    if(isDefined(_id_22C69A24A1AD0D6A)) {
      agent agentsetfavoriteenemy(_id_22C69A24A1AD0D6A);
      agent setgoalentity(_id_22C69A24A1AD0D6A);
    }

    wait(_id_00DE3194C9477B34);
  }
}

_id_93E03A3112114BFB(origin, path) {
  if(!isDefined(path) || path.size < 1)
    return undefined;

  index = undefined;
  dist = undefined;

  foreach(_id_AC0E594AC96AA3A8, node in path) {
    _id_5C1EE5AB8012EA11 = distancesquared(node.origin, origin);

    if(!isDefined(dist) || _id_5C1EE5AB8012EA11 < dist) {
      dist = _id_5C1EE5AB8012EA11;
      index = _id_AC0E594AC96AA3A8;
    }
  }

  return index;
}

_id_62729CB2F806997A(arena, _id_55E69FB0CE97F15E, _id_1439F86640D42E34) {
  level endon("game_ended");
  _id_4D0DEC66237FE9AE = self._id_4D0DEC66237FE9AE;

  if(isDefined(_id_4D0DEC66237FE9AE))
    wait(_id_4D0DEC66237FE9AE);

  level thread _id_287401A3027DB2BF(arena, _id_55E69FB0CE97F15E, _id_1439F86640D42E34, level._id_43307855F189EB31._id_CB1A9A6651A906DF, undefined, _id_4D0DEC66237FE9AE);
}