/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1c47017ba325709a.gsc
***********************************************/

_id_7F4D3080C6E8748B() {
  level._id_CE783FC59EA392D1 = 1;
  level._id_FA8B075E623245A7 = getdvarint("dvar_2FF2C53D8D6E7C01", 30) * 1000;
  level._id_0E575D73E8D29994 = getdvarint("dvar_79B9E1DD01AE9CB7", 0);
  level._id_FCB29AEE3F6EAB0D = getdvarint("dvar_9D611E4D54454129", 30);
  level._id_25DE264EE4D0E7AA = getdvarint("dvar_0E4BE7BE05AB1911", 4000);
  _id_8E34D09C5E2FC0F2();
  level._id_E435E1E848664132["veh9_techo_rebel_armor"] = ::_id_95E274DB21433C2B;
  level._id_E435E1E848664132["veh9_overland_2016"] = ::_id_95E274DB21433C2B;
  level._id_E435E1E848664132["veh9_sedan_hatchback_1985"] = ::_id_95E274DB21433C2B;
  level._id_E435E1E848664132["veh9_mil_cargo_truck"] = ::_id_95E274DB21433C2B;
  level._id_E435E1E848664132["veh9_jltv"] = ::_id_95E274DB21433C2B;
  level._id_E435E1E848664132["veh9_jltv_mg"] = ::_id_95E274DB21433C2B;
  level._id_E435E1E848664132["techo_reinforce"] = ::_id_95E274DB21433C2B;
  scripts\cp_mp\vehicles\vehicle_tracking::_id_5C8408CB68649308("veh9_techo_rebel_armor", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_5C8408CB68649308("veh9_overland_2016", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_5C8408CB68649308("veh9_sedan_hatchback_1985", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_5C8408CB68649308("veh9_mil_cargo_truck", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_5C8408CB68649308("veh9_jltv", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_5C8408CB68649308("veh9_jltv_mg", "GROUND_REINFORCE", 6);
}

_id_8E34D09C5E2FC0F2() {
  while(!scripts\engine\utility::flag_exist("create_script_initialized"))
    waitframe();

  scripts\engine\utility::flag_wait("create_script_initialized");
  waitframe();
  level._id_B01C03D751886F28 = 0;

  if(getdvarint("dvar_04A77EF221A7D22A", 0) == 1) {
    return;
  }
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    while(level._id_B205D90302DA2F07.size == 0)
      waitframe();

    waitframe();
    _id_46F73294FB8B410C = scripts\engine\utility::getStructArray("ground_reinforce_node", "targetname");

    foreach(_id_171F90B9C4C76D44, _id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"] = spawnStruct();
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_E45AA5237F84CE6F = [];
      level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_7AFD0CB611ECB973 = [];

      if(istrue(level._id_4CFD75AA6DDDE156))
        _id_B7015A0DBEFEBCE1 = _id_46F73294FB8B410C;
      else
        _id_B7015A0DBEFEBCE1 = _id_5DEF7AF2A9F04234::_id_9656B61CC8A37CBA(_id_46F73294FB8B410C, _id_171F90B9C4C76D44);

      foreach(index, node in _id_B7015A0DBEFEBCE1) {
        if(isDefined(node._id_7643B53B09BBF1D5)) {
          continue;
        }
        _id_3DE9D35A8CBB1EA6 = _id_6747838FA0463AB2(node, _id_B7015A0DBEFEBCE1);

        if(isDefined(_id_3DE9D35A8CBB1EA6) && isDefined(_id_3DE9D35A8CBB1EA6._id_E601AC2F09720AA2))
          level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_E45AA5237F84CE6F[_id_3DE9D35A8CBB1EA6._id_E601AC2F09720AA2] = _id_3DE9D35A8CBB1EA6;
      }

      foreach(_id_782866E364DCD2EF in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_E45AA5237F84CE6F) {
        foreach(node in _id_782866E364DCD2EF._id_F1A894F81AD453AF) {
          if(!scripts\engine\utility::array_contains(_id_782866E364DCD2EF._id_B7015A0DBEFEBCE1, node))
            level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_7AFD0CB611ECB973[level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_7AFD0CB611ECB973.size] = node;
        }

        if(!istrue(level._id_40E5E944FBBF704E))
          _id_782866E364DCD2EF._id_F1A894F81AD453AF = undefined;
      }
    }
  } else {
    level._id_89CABEB3F8028DC6 = spawnStruct();
    level._id_89CABEB3F8028DC6._id_E45AA5237F84CE6F = [];
    level._id_89CABEB3F8028DC6._id_7AFD0CB611ECB973 = [];
    _id_B7015A0DBEFEBCE1 = scripts\engine\utility::getStructArray("ground_reinforce_node", "targetname");

    foreach(index, node in _id_B7015A0DBEFEBCE1) {
      _id_3DE9D35A8CBB1EA6 = _id_6747838FA0463AB2(node, _id_B7015A0DBEFEBCE1);

      if(isDefined(_id_3DE9D35A8CBB1EA6) && isDefined(_id_3DE9D35A8CBB1EA6._id_E601AC2F09720AA2))
        level._id_89CABEB3F8028DC6._id_E45AA5237F84CE6F[_id_3DE9D35A8CBB1EA6._id_E601AC2F09720AA2] = _id_3DE9D35A8CBB1EA6;
    }

    foreach(_id_782866E364DCD2EF in level._id_89CABEB3F8028DC6._id_E45AA5237F84CE6F) {
      foreach(node in _id_782866E364DCD2EF._id_F1A894F81AD453AF) {
        if(!scripts\engine\utility::array_contains(_id_782866E364DCD2EF._id_B7015A0DBEFEBCE1, node))
          level._id_89CABEB3F8028DC6._id_7AFD0CB611ECB973[level._id_89CABEB3F8028DC6._id_7AFD0CB611ECB973.size] = node;
      }

      if(!istrue(level._id_40E5E944FBBF704E))
        _id_782866E364DCD2EF._id_F1A894F81AD453AF = undefined;
    }
  }
}

_id_6747838FA0463AB2(node, _id_B7015A0DBEFEBCE1) {
  if(!isDefined(node.target)) {
    return;
  }
  _id_782866E364DCD2EF = spawnStruct();
  _id_782866E364DCD2EF._id_E601AC2F09720AA2 = level._id_B01C03D751886F28;
  level._id_B01C03D751886F28++;
  _id_782866E364DCD2EF._id_F1A894F81AD453AF = [];
  _id_4A3B8372442841E5 = [];
  _id_8BAE1659C6ED57F9 = 0;
  allnodes = [node];
  _id_428B0C825645A14B = 0;
  _id_46F73294FB8B410C = [];

  while(_id_428B0C825645A14B < allnodes.size) {
    _id_FC7B2C2415093B8D = allnodes[_id_428B0C825645A14B];
    _id_428B0C825645A14B++;

    if(scripts\engine\utility::array_contains(_id_B7015A0DBEFEBCE1, _id_FC7B2C2415093B8D)) {
      if(!scripts\engine\utility::array_contains(_id_46F73294FB8B410C, _id_FC7B2C2415093B8D)) {
        _id_46F73294FB8B410C[_id_46F73294FB8B410C.size] = _id_FC7B2C2415093B8D;
        _id_FC7B2C2415093B8D = _id_A8C8D8521C0DE967(_id_FC7B2C2415093B8D, _id_8BAE1659C6ED57F9);
        _id_4A3B8372442841E5[_id_4A3B8372442841E5.size] = _id_FC7B2C2415093B8D._id_7643B53B09BBF1D5;
        _id_FC7B2C2415093B8D._id_4A3B8372442841E5 = [_id_FC7B2C2415093B8D._id_7643B53B09BBF1D5];
        _id_8BAE1659C6ED57F9++;
      }
    } else if(isDefined(_id_FC7B2C2415093B8D.targetname)) {
      _id_EEA002E5AACA5242 = scripts\engine\utility::getStructArray(_id_FC7B2C2415093B8D.targetname, "target");

      foreach(_id_0C84F6220E6636C5 in _id_EEA002E5AACA5242) {
        if(!scripts\engine\utility::array_contains(allnodes, _id_0C84F6220E6636C5)) {
          allnodes[allnodes.size] = _id_0C84F6220E6636C5;
          _id_0C84F6220E6636C5._id_4A3B8372442841E5 = [];
          _id_0C84F6220E6636C5._id_E601AC2F09720AA2 = _id_782866E364DCD2EF._id_E601AC2F09720AA2;
          _id_0C84F6220E6636C5._id_D4145D9E255225DC = undefined;
        }
      }
    }

    if(isDefined(_id_FC7B2C2415093B8D.target)) {
      _id_EEA002E5AACA5242 = scripts\engine\utility::getStructArray(_id_FC7B2C2415093B8D.target, "targetname");

      foreach(_id_0C84F6220E6636C5 in _id_EEA002E5AACA5242) {
        if(!scripts\engine\utility::array_contains(allnodes, _id_0C84F6220E6636C5)) {
          allnodes[allnodes.size] = _id_0C84F6220E6636C5;
          _id_0C84F6220E6636C5._id_4A3B8372442841E5 = [];
          _id_0C84F6220E6636C5._id_E601AC2F09720AA2 = _id_782866E364DCD2EF._id_E601AC2F09720AA2;
          _id_0C84F6220E6636C5._id_D4145D9E255225DC = _id_FC7B2C2415093B8D;
          continue;
        }

        if(!isDefined(_id_0C84F6220E6636C5._id_D4145D9E255225DC)) {
          _id_0C84F6220E6636C5._id_D4145D9E255225DC = _id_FC7B2C2415093B8D;
          continue;
        }

        if(isarray(_id_0C84F6220E6636C5._id_D4145D9E255225DC)) {
          if(!scripts\engine\utility::array_contains(_id_0C84F6220E6636C5._id_D4145D9E255225DC, _id_FC7B2C2415093B8D))
            _id_0C84F6220E6636C5._id_D4145D9E255225DC[_id_0C84F6220E6636C5._id_D4145D9E255225DC.size] = _id_FC7B2C2415093B8D;

          continue;
        }

        if(_id_0C84F6220E6636C5._id_D4145D9E255225DC != _id_FC7B2C2415093B8D)
          _id_0C84F6220E6636C5._id_D4145D9E255225DC = [_id_0C84F6220E6636C5._id_D4145D9E255225DC, _id_FC7B2C2415093B8D];
      }
    }
  }

  foreach(_id_C229D93C0BB4F8E8 in _id_46F73294FB8B410C)
  _id_64F41B179B2030CC(_id_C229D93C0BB4F8E8);

  _id_782866E364DCD2EF._id_F1A894F81AD453AF = scripts\engine\utility::array_combine_unique(_id_782866E364DCD2EF._id_F1A894F81AD453AF, allnodes);

  foreach(_id_C229D93C0BB4F8E8 in _id_46F73294FB8B410C)
  _id_782866E364DCD2EF._id_B7015A0DBEFEBCE1[_id_C229D93C0BB4F8E8._id_7643B53B09BBF1D5] = _id_C229D93C0BB4F8E8;

  _id_782866E364DCD2EF._id_4A3B8372442841E5 = _id_4A3B8372442841E5;
  return _id_782866E364DCD2EF;
}

_id_64F41B179B2030CC(_id_C229D93C0BB4F8E8) {
  allnodes = scripts\engine\utility::getStructArray(_id_C229D93C0BB4F8E8.target, "targetname");
  _id_428B0C825645A14B = 0;

  while(_id_428B0C825645A14B < allnodes.size) {
    node = allnodes[_id_428B0C825645A14B];
    _id_428B0C825645A14B++;
    node._id_4A3B8372442841E5[node._id_4A3B8372442841E5.size] = _id_C229D93C0BB4F8E8._id_7643B53B09BBF1D5;

    if(isDefined(node.target)) {
      _id_CC8ADC8AFBBCC72E = scripts\engine\utility::getStructArray(node.target, "targetname");

      if(isDefined(_id_CC8ADC8AFBBCC72E)) {
        foreach(_id_7294D525FCCF3A69 in _id_CC8ADC8AFBBCC72E) {
          if(scripts\engine\utility::array_contains(allnodes, _id_7294D525FCCF3A69)) {
            continue;
          }
          allnodes[allnodes.size] = _id_7294D525FCCF3A69;
        }
      }
    }
  }
}

_id_A8C8D8521C0DE967(node, _id_512FFBFFC675F2FC) {
  node.lastusedtime = 0;
  node._id_7643B53B09BBF1D5 = _id_512FFBFFC675F2FC;
  return node;
}

_id_1172336A24A3FAC0(_id_B9161FCA8CA8119A, _id_C5E7FCE963586EC0, _id_171F90B9C4C76D44, _id_93390A6953905FEF, _id_07C99D4ED1E5A3A8) {
  spawners = undefined;
  _id_37A86A6D390BF8EC = [];

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);

    _id_A829CD2E1F4EC42A = sortbydistance(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_7AFD0CB611ECB973, _id_C5E7FCE963586EC0);
  } else
    _id_A829CD2E1F4EC42A = sortbydistance(level._id_89CABEB3F8028DC6._id_7AFD0CB611ECB973, _id_C5E7FCE963586EC0);

  _id_42E40D3B6C566752 = _id_07C99D4ED1E5A3A8;

  if(istrue(_id_93390A6953905FEF))
    _id_42E40D3B6C566752 = 1;

  _id_30F3CBC949CF145C = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_42E40D3B6C566752; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_A829CD2E1F4EC42A[_id_AC0E594AC96AA3A8]))
      _id_30F3CBC949CF145C[_id_30F3CBC949CF145C.size] = _id_A829CD2E1F4EC42A[_id_AC0E594AC96AA3A8];
  }

  if(istrue(level._id_85E83F382AEDC103) || istrue(level._id_0E575D73E8D29994))
    return [_id_30F3CBC949CF145C[0]];

  return _id_30F3CBC949CF145C;
}

_id_3F36FCE913F23B19(_id_E710A9290407911B, _id_171F90B9C4C76D44) {
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    foreach(_id_9D33FB21F8C1ABB2 in _id_E710A9290407911B) {
      _id_782866E364DCD2EF = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_E45AA5237F84CE6F[_id_9D33FB21F8C1ABB2._id_E601AC2F09720AA2];
      _id_FD5EA9CB37C309D3 = [];

      foreach(_id_8EF89542D7D7C021 in _id_9D33FB21F8C1ABB2._id_4A3B8372442841E5)
      _id_FD5EA9CB37C309D3[_id_FD5EA9CB37C309D3.size] = _id_782866E364DCD2EF._id_B7015A0DBEFEBCE1[_id_8EF89542D7D7C021];

      _id_D81C039F781FAF29 = [];

      if(_func_A794FCF9545F2062()) {
        foreach(_id_FB1DEF007972B25A in _id_FD5EA9CB37C309D3) {
          players = _func_B1EEF70090B5B7B5(_id_FB1DEF007972B25A.origin, level._id_25DE264EE4D0E7AA, _func_869CCB4E3451B8C6(["etype_player"]), [], undefined);

          if(isDefined(players) && players.size > 0)
            continue;
          else
            _id_D81C039F781FAF29[_id_D81C039F781FAF29.size] = _id_FB1DEF007972B25A;
        }
      }

      if(_id_D81C039F781FAF29.size > 0)
        return [scripts\engine\utility::random(_id_D81C039F781FAF29), _id_9D33FB21F8C1ABB2];
    }

    return [undefined, undefined];
  } else {
    foreach(_id_9D33FB21F8C1ABB2 in _id_E710A9290407911B) {
      _id_782866E364DCD2EF = level._id_89CABEB3F8028DC6._id_E45AA5237F84CE6F[_id_9D33FB21F8C1ABB2._id_E601AC2F09720AA2];
      _id_FD5EA9CB37C309D3 = [];

      foreach(_id_8EF89542D7D7C021 in _id_9D33FB21F8C1ABB2._id_4A3B8372442841E5)
      _id_FD5EA9CB37C309D3[_id_FD5EA9CB37C309D3.size] = _id_782866E364DCD2EF._id_B7015A0DBEFEBCE1[_id_8EF89542D7D7C021];

      if(_id_FD5EA9CB37C309D3.size > 0)
        return [scripts\engine\utility::random(_id_FD5EA9CB37C309D3), _id_9D33FB21F8C1ABB2];
    }

    return [undefined, undefined];
  }
}

_id_C277806325266D3C(_id_9D33FB21F8C1ABB2, _id_C229D93C0BB4F8E8, _id_171F90B9C4C76D44) {
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(_id_171F90B9C4C76D44))
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_9D33FB21F8C1ABB2.origin);

    _id_782866E364DCD2EF = level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_E45AA5237F84CE6F[_id_9D33FB21F8C1ABB2._id_E601AC2F09720AA2];
  } else
    _id_782866E364DCD2EF = level._id_89CABEB3F8028DC6._id_E45AA5237F84CE6F[_id_9D33FB21F8C1ABB2._id_E601AC2F09720AA2];

  _id_9F207219355D1982 = [_id_9D33FB21F8C1ABB2];

  for(currentnode = _id_9D33FB21F8C1ABB2; isDefined(currentnode._id_D4145D9E255225DC); _id_9F207219355D1982[_id_9F207219355D1982.size] = currentnode) {
    if(isarray(currentnode._id_D4145D9E255225DC)) {
      _id_25DD3020969AA0F6 = [];

      foreach(node in currentnode._id_D4145D9E255225DC) {
        if(scripts\engine\utility::array_contains(node._id_4A3B8372442841E5, _id_C229D93C0BB4F8E8._id_7643B53B09BBF1D5))
          _id_25DD3020969AA0F6[_id_25DD3020969AA0F6.size] = node;
      }

      currentnode = scripts\engine\utility::random(_id_25DD3020969AA0F6);
      continue;
    }

    currentnode = currentnode._id_D4145D9E255225DC;
  }

  _id_9F207219355D1982 = scripts\engine\utility::array_reverse(_id_9F207219355D1982);
  origins = [];

  foreach(node in _id_9F207219355D1982)
  origins[origins.size] = node.origin;

  return origins;
}

_id_96A6B09D8CE2A773(node, _id_7643B53B09BBF1D5, _id_782866E364DCD2EF) {
  _id_25DD3020969AA0F6 = scripts\engine\utility::getStructArray(node.targetname, "target");

  foreach(_id_E9C5BBCA67080141 in _id_25DD3020969AA0F6) {
    if(isDefined(_id_E9C5BBCA67080141._id_7643B53B09BBF1D5) && _id_E9C5BBCA67080141._id_7643B53B09BBF1D5 == _id_7643B53B09BBF1D5)
      return _id_E9C5BBCA67080141;

    if(isDefined(_id_E9C5BBCA67080141._id_4A3B8372442841E5) && scripts\engine\utility::array_contains(_id_E9C5BBCA67080141._id_4A3B8372442841E5, _id_7643B53B09BBF1D5))
      _id_25DD3020969AA0F6[_id_25DD3020969AA0F6.size] = _id_E9C5BBCA67080141;
  }

  return scripts\engine\utility::random(_id_25DD3020969AA0F6);
}

_id_2301BA68EC48226E(_id_3DE9D35A8CBB1EA6) {
  if(!isDefined(_id_3DE9D35A8CBB1EA6.lastusedtime))
    return 1;

  if(_id_3DE9D35A8CBB1EA6.lastusedtime + level._id_FA8B075E623245A7 < gettime()) {
    _id_3DE9D35A8CBB1EA6.lastusedtime = undefined;
    return 1;
  }

  return 0;
}

_id_A5B0665E0A814BE6(numagents, _id_EC862C2C00C7AB5D, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, _id_93390A6953905FEF, _id_171F90B9C4C76D44, _id_8E5A9B658FA525ED, _id_B9161FCA8CA8119A) {
  if(isDefined(level._id_33A2175A9A4306BC) && istrue(level._id_33A2175A9A4306BC._id_009BADBB469626F6))
    return [undefined, undefined];

  _id_B9161FCA8CA8119A = _id_5E7837D4D6B6DD45(_id_B9161FCA8CA8119A);

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle(_id_B9161FCA8CA8119A, undefined, undefined, "GROUND_REINFORCE"))
    return [undefined, undefined];

  if(!isDefined(_id_171F90B9C4C76D44))
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_C5E7FCE963586EC0);

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    if(!isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]) || !isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]) || level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["groundReinforceStruct"]._id_E45AA5237F84CE6F.size == 0)
      return [undefined, undefined];
  } else if(!isDefined(level._id_89CABEB3F8028DC6) || level._id_89CABEB3F8028DC6._id_E45AA5237F84CE6F.size == 0)
    return [undefined, undefined];

  vehicle = undefined;
  _id_C5E7FCE963586EC0 = _id_120270BD0A747A35::_id_D378CC95ABAB583B(_id_C5E7FCE963586EC0, _id_171F90B9C4C76D44);
  _id_C5E7FCE963586EC0 = getclosestpointonnavmesh(_id_C5E7FCE963586EC0);
  _id_7AFD0CB611ECB973 = _id_1172336A24A3FAC0(_id_B9161FCA8CA8119A, _id_C5E7FCE963586EC0, _id_171F90B9C4C76D44, _id_93390A6953905FEF, 5);
  [_id_72DAC79A97FC7C5C, _id_9D33FB21F8C1ABB2] = _id_3F36FCE913F23B19(_id_7AFD0CB611ECB973, _id_171F90B9C4C76D44);

  if(!isDefined(_id_72DAC79A97FC7C5C))
    return [undefined, undefined];

  _id_72DAC79A97FC7C5C.origin = getclosestpointonnavmesh(_id_72DAC79A97FC7C5C.origin) + (0, 0, 128);
  _id_72DAC79A97FC7C5C._id_9D33FB21F8C1ABB2 = _id_9D33FB21F8C1ABB2;
  _id_72DAC79A97FC7C5C.lastusedtime = gettime();
  tier = _id_48814951E916AF89::_id_AA34A142B7664DD1(_id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44));

  if(!isDefined(_id_EC862C2C00C7AB5D))
    _id_EC862C2C00C7AB5D = _id_236A093E8A0EC040(_id_B9161FCA8CA8119A, tier);

  if(!isDefined(_id_72DAC79A97FC7C5C._id_B205D90302DA2F07))
    _id_72DAC79A97FC7C5C._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;

  logstring("Ground reinforcement spawn: " + numagents + " AI at " + _id_C5E7FCE963586EC0);
  spawners = _id_F260B1CEF943F1AB(_id_B9161FCA8CA8119A, numagents, _id_EC862C2C00C7AB5D, _id_72DAC79A97FC7C5C.origin, _id_72DAC79A97FC7C5C._id_B205D90302DA2F07, priority, category, _id_8E5A9B658FA525ED);
  riders = _id_4AD6C25D6754F697(spawners, numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, team, groupname, _id_B9161FCA8CA8119A);

  if(!isDefined(riders) || riders.size == 0)
    return [undefined, undefined];

  _id_72DAC79A97FC7C5C._id_79FA6BD3C9BF6A0D = 1;
  _id_72DAC79A97FC7C5C.dontgetonpath = 1;
  spawndata = spawnStruct();
  spawndata.origin = _id_72DAC79A97FC7C5C.origin;
  spawndata.angles = _id_72DAC79A97FC7C5C.angles;
  spawndata.spawntype = "GROUND_REINFORCE";
  spawndata.showheadicon = 1;
  spawndata._id_F16652E1462A3739 = 1;
  _id_14CDE247AC3313A4 = _id_55DACE275F65D5B6(_id_B9161FCA8CA8119A);

  if(isDefined(_id_14CDE247AC3313A4))
    spawndata._id_14CDE247AC3313A4 = _id_14CDE247AC3313A4;

  _id_EE8DA5624236DC89 = spawnStruct();
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_B9161FCA8CA8119A, spawndata, _id_EE8DA5624236DC89);
  vehicle.vehicle_spawner = _id_72DAC79A97FC7C5C;
  vehicle._id_C5E7FCE963586EC0 = _id_C5E7FCE963586EC0;
  vehicle._id_EB504FC7E1CFEB4C = getdvarint("dvar_9E4FFF9024BD3A06", 1);
  spawninvehicle = !isDefined(_id_72DAC79A97FC7C5C._id_3F0312E6382C878F) || istrue(_id_72DAC79A97FC7C5C._id_3F0312E6382C878F);
  vehicle scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6(riders, spawninvehicle);

  if(isDefined(level._id_6E5FF6CAE14C4081))
    level._id_6E5FF6CAE14C4081[level._id_6E5FF6CAE14C4081.size] = vehicle;

  if(isDefined(level._id_E435E1E848664132[_id_B9161FCA8CA8119A]))
    vehicle thread[[level._id_E435E1E848664132[_id_B9161FCA8CA8119A]]]();

  if(istrue(vehicle._id_20D6BFFF3D46371D)) {
    foreach(rider in riders)
    _id_48814951E916AF89::_id_C9B9FE3F7F739586(rider);
  }

  return [vehicle, riders];
}

_id_F260B1CEF943F1AB(_id_3D22F278EFD315CC, _id_4AF808CB9330A11A, _id_EC862C2C00C7AB5D, origin, _id_171F90B9C4C76D44, priority, category, _id_8E5A9B658FA525ED) {
  _id_E4353165DD6DE45E = scripts\engine\utility::ter_op(isDefined(level._id_F0872E42DAF6D4D5), level._id_F0872E42DAF6D4D5, origin);
  _id_CA38685E5BF373F4 = (0, 0, 0);
  _id_001250F27C957FEC = scripts\cp_mp\vehicles\vehicle::_id_95022424D8B0DC1C(_id_3D22F278EFD315CC);

  if(_id_4AF808CB9330A11A > _id_001250F27C957FEC)
    _id_4AF808CB9330A11A = _id_001250F27C957FEC;

  if(!isDefined(category))
    category = "reinforcements";

  _id_0644D90DE7685F75 = _id_48814951E916AF89::_id_8C6DBB64C8E1603C(_id_4AF808CB9330A11A, category, origin, _id_171F90B9C4C76D44, 0);

  if(!_id_0644D90DE7685F75 && !_id_48814951E916AF89::_id_359F24553BDCCA92(_id_4AF808CB9330A11A, priority))
    return undefined;

  riders = [];
  _id_C229D93C0BB4F8E8 = spawnStruct();
  _id_C229D93C0BB4F8E8._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
  _id_C229D93C0BB4F8E8.origin = origin;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4AF808CB9330A11A; _id_AC0E594AC96AA3A8++) {
    riders[_id_AC0E594AC96AA3A8] = spawnStruct();
    riders[_id_AC0E594AC96AA3A8].origin = _id_E4353165DD6DE45E;
    riders[_id_AC0E594AC96AA3A8].angles = _id_CA38685E5BF373F4;
    riders[_id_AC0E594AC96AA3A8]._id_B205D90302DA2F07 = _id_171F90B9C4C76D44;
    type = undefined;

    if(isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].type))
      type = _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].type;

    tier = undefined;

    if(isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].tier))
      tier = _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8].tier;

    _id_177DB62B63710F5D = undefined;

    if(isDefined(_id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8]._id_8E5A9B658FA525ED))
      _id_177DB62B63710F5D = _id_EC862C2C00C7AB5D._id_DD4F509B9C56C76F[_id_AC0E594AC96AA3A8]._id_8E5A9B658FA525ED;

    riders[_id_AC0E594AC96AA3A8].aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(_id_C229D93C0BB4F8E8, _id_171F90B9C4C76D44, undefined, type, tier, scripts\engine\utility::_id_53C4C53197386572(_id_177DB62B63710F5D, _id_8E5A9B658FA525ED));
  }

  return riders;
}

_id_4AD6C25D6754F697(spawners, numagents, _id_C5E7FCE963586EC0, priority, category, _id_1C9CB43BCF3EB16D, team, groupname, _id_3D22F278EFD315CC, _id_30EC18A4C33AF064) {
  if(!isDefined(spawners))
    return undefined;

  if(!isDefined(groupname))
    groupname = _id_48814951E916AF89::_id_78759441C259F58A(_id_C5E7FCE963586EC0, numagents);

  if(!isDefined(_id_30EC18A4C33AF064))
    _id_30EC18A4C33AF064 = _id_3D22F278EFD315CC;

  _id_30EC18A4C33AF064 = _id_CEB3C1EF8F369684(_id_30EC18A4C33AF064);
  _id_0A19B73001EB4102 = [];
  riders = [];

  foreach(index, spawner in spawners) {
    rider = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(spawner.aitype, spawner.origin, spawner.angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, team, undefined, spawner._id_B205D90302DA2F07, undefined, undefined, 0);

    if(isDefined(rider)) {
      rider.group = spawner;
      rider.group.group_name = spawner.targetname;
      rider.spawnpoint = spawner;
      rider.spawner = spawner;
      rider.vehiclerunexit = 1;

      if(isDefined(_id_30EC18A4C33AF064)) {
        if(isDefined(_id_30EC18A4C33AF064[index]))
          rider.script_startingposition = _id_30EC18A4C33AF064[index];
        else if(!scripts\engine\utility::array_contains(_id_30EC18A4C33AF064, index))
          rider.script_startingposition = index;
        else {
          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
            if(!scripts\engine\utility::array_contains(_id_30EC18A4C33AF064, _id_AC0E594AC96AA3A8) && !scripts\engine\utility::array_contains(_id_0A19B73001EB4102, _id_AC0E594AC96AA3A8)) {
              rider.script_startingposition = _id_AC0E594AC96AA3A8;
              break;
            }
          }
        }
      } else
        rider.script_startingposition = index;

      _id_0A19B73001EB4102[_id_0A19B73001EB4102.size] = rider.script_startingposition;

      if(isDefined(level._id_7A9F066F79BED633))
        rider thread[[level._id_7A9F066F79BED633]]();

      riders[riders.size] = rider;
      rider thread _id_4BAC13D511590220::_id_CBA4FF426A2F58AB(rider.script_startingposition);
    }
  }

  return riders;
}

_id_95E274DB21433C2B() {
  _id_D8B6F7AD3B0DEAD7 = [];
  _id_D8B6F7AD3B0DEAD7 = _id_C277806325266D3C(self.vehicle_spawner._id_9D33FB21F8C1ABB2, self.vehicle_spawner, self.vehicle_spawner._id_B205D90302DA2F07);

  if(_id_48814951E916AF89::_id_E57289D4E2128A53(_id_D8B6F7AD3B0DEAD7))
    self._id_20D6BFFF3D46371D = 1;

  self._id_D8B6F7AD3B0DEAD7 = _id_D8B6F7AD3B0DEAD7;
  thread _id_710348CA3287D2E9();
  veh_speed = scripts\engine\utility::mph_to_ips(level._id_FCB29AEE3F6EAB0D);

  if(issubstr(self.classname_mp, "cargo")) {
    _id_4BAC13D511590220::_id_1DA2C31423C2676A();
    self _meth_77320E794D35465A("p2p", "brakeAtGoal", 1);
    self _meth_77320E794D35465A("p2p", "goalThreshold", level._id_FCB29AEE3F6EAB0D * 4);
    self _meth_77320E794D35465A("p2p", "steeringMultiplier", 2.5);
    self _meth_77320E794D35465A("p2p", "stuckTime", 1);
    self _meth_77320E794D35465A("p2p", "manualSpeed", veh_speed);
  } else {
    _id_4BAC13D511590220::_id_1DA2C31423C2676A();
    self _meth_77320E794D35465A("p2p", "brakeAtGoal", 1);
    self _meth_77320E794D35465A("p2p", "goalThreshold", level._id_FCB29AEE3F6EAB0D * 4);
    self _meth_77320E794D35465A("p2p", "steeringMultiplier", 2.5);
    self _meth_77320E794D35465A("p2p", "stuckTime", 1);
    self _meth_77320E794D35465A("p2p", "manualSpeed", veh_speed);
  }

  self._id_9ACFC0BD86B2E2C1 = _id_4BAC13D511590220::_id_DF5D237DB38291AC;
  self._id_A9F96E33F612C828 = _id_4BAC13D511590220::_id_6A0B2A08499A9842;
  scripts\common\vehicle::vehicle_lights_on("headlights", "script_vehicle_iw9_truck_techo_rebel_armor");
  self endon("death");
  self endon("stop_chasing");
  self endon("startedUnload");

  if(!isDefined(level._id_24A25C6BE881BE0C))
    level._id_24A25C6BE881BE0C = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_techo_rebel_armor", "damageIgnoresArmor"))
    self._id_7A646FF827387AC0 = scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_techo_rebel_armor", "damageIgnoresArmor");

  for(result = undefined; !istrue(self.unloading); result = _id_4BAC13D511590220::_id_8F40A2C8678F8304(self.origin, _id_17809E3C62D05F91, level._id_FCB29AEE3F6EAB0D)) {
    _id_17809E3C62D05F91 = self._id_D8B6F7AD3B0DEAD7[0];
    waitframe();

    if(!isDefined(_id_17809E3C62D05F91)) {
      thread _id_FB7E5919765650EA("combat");
      return;
    }

    if(isDefined(result) && result != "path_blocked")
      self._id_D8B6F7AD3B0DEAD7 = scripts\engine\utility::array_slice(self._id_D8B6F7AD3B0DEAD7, 1);

    if(self._id_D8B6F7AD3B0DEAD7.size == 1)
      self _meth_77320E794D35465A("p2p", "goalThreshold", level._id_FCB29AEE3F6EAB0D * 4);

    _id_4BAC13D511590220::_id_28991B23DBA743D8(_id_17809E3C62D05F91);
  }
}

_id_FB7E5919765650EA(exittype) {
  self endon("death");
  self notify("startedUnload");

  if(istrue(self.unloading)) {
    return;
  }
  self.unloading = 1;
  riders = self.riders;
  _id_24E4405CF93F20ED::_id_7D8F81A94DC08A15(1, exittype);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_887B4E2CBE3AB92C();
  _id_08BC50C369B52AF0 = self._id_D8B6F7AD3B0DEAD7;
  _id_08BC50C369B52AF0[_id_08BC50C369B52AF0.size] = self._id_C5E7FCE963586EC0;

  foreach(rider in riders)
  rider thread _id_120270BD0A747A35::_id_65F6A39E1083FB6B(rider, _id_08BC50C369B52AF0, 64, 128, undefined, 1, riders);

  if(getdvarint("dvar_88693526977782E2", 1) != 1) {
    return;
  }
  self endon("stop_watching_abandoned");
  wait 180;
  level thread _id_9F45B9478C4E937B(self);
}

_id_9F45B9478C4E937B(vehicle) {
  vehicle scripts\cp_mp\vehicles\vehicle_spawn::_id_357783D7C1D96273();
  _id_FB41D1CA75009BF0 = vehicle scripts\cp_mp\vehicles\vehicle::_id_12F5A0E2344C10C5();

  if(!isDefined(_id_FB41D1CA75009BF0)) {
    return;
  }
  wait 60;

  if(isDefined(_id_FB41D1CA75009BF0))
    _id_FB41D1CA75009BF0 scripts\cp_mp\vehicles\vehicle_spawn::_id_357783D7C1D96273();
}

_id_710348CA3287D2E9() {
  self endon("death");
  self endon("startedUnload");
  _id_8A96DEF5A3CC6530 = 0;

  for(;;) {
    waitframe();

    if(scripts\common\vehicle_code::vehicle_is_stopped())
      _id_8A96DEF5A3CC6530++;
    else
      _id_8A96DEF5A3CC6530 = 0;

    if(_id_24E4405CF93F20ED::_id_EEE51130CC8DCE38()) {
      thread _id_FB7E5919765650EA("combat");
      return;
    }

    if(_id_8A96DEF5A3CC6530 > 10) {
      thread _id_FB7E5919765650EA();
      return;
    }
  }
}

_id_5E7837D4D6B6DD45(type) {
  switch (type) {
    case "techo":
      return "veh9_techo_rebel_armor";
    case "overland":
      return "veh9_overland_2016";
    case "sedan":
      return "veh9_sedan_hatchback_1985";
    case "cargo":
      return "veh9_mil_cargo_truck";
    case "jltv":
      return "veh9_jltv";
    case "jltv_mg":
      return "veh9_jltv_mg";
    default:
      return "veh9_techo_rebel_armor";
  }
}

_id_236A093E8A0EC040(_id_3D22F278EFD315CC, tier) {
  if(!isDefined(tier))
    tier = 1;

  _id_246027A1B24DD32F = [];

  switch (_id_3D22F278EFD315CC) {
    case "veh9_techo_rebel_armor":
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("patrol_primary", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("vehicle_patrol_rare", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("patrol_primary", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("vehicle_patrol_rare", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = "lmg";
      break;
    case "veh9_sedan_hatchback_1985":
    case "veh9_overland_2016":
    case "veh9_jltv":
    case "veh9_jltv_mg":
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("patrol_primary", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("convoy_attack_turret", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("patrol_primary", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("vehicle_patrol_rare", tier);
      break;
    case "veh9_mil_cargo_truck":
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("patrol_primary", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("patrol_primary", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("patrol_primary", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("patrol_primary", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("patrol_primary", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("vehicle_patrol_rare", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("vehicle_patrol_rare", tier);
      _id_246027A1B24DD32F[_id_246027A1B24DD32F.size] = _id_48814951E916AF89::_id_ED108FF3EB578327("vehicle_patrol_rare", tier);
      break;
    default:
      return undefined;
  }

  _id_CF627BF100B5BAFC = [];

  foreach(_id_083C3368707C68E6 in _id_246027A1B24DD32F)
  _id_CF627BF100B5BAFC[_id_CF627BF100B5BAFC.size] = _id_48814951E916AF89::_id_DE59D7CB310C1AFF(_id_083C3368707C68E6, tier);

  _id_EC862C2C00C7AB5D = _id_48814951E916AF89::_id_B9D78FCE07834C95(_id_CF627BF100B5BAFC);
  return _id_EC862C2C00C7AB5D;
}

_id_CEB3C1EF8F369684(_id_3D22F278EFD315CC) {
  switch (_id_3D22F278EFD315CC) {
    case "veh9_techo_rebel_armor":
      return [0, 5, 6];
    case "veh9_jltv_mg":
      return [0, 4, 1, 2, 3];
    case "veh9_mil_cargo_truck_convoy_attack":
      return [0, 1, 3, 4, 5, 6, 7];
    default:
      return undefined;
  }
}

_id_55DACE275F65D5B6(vehicletype) {
  if(!isDefined(level._id_0F5F783A9D656258._id_48D4812167FBB628[vehicletype])) {
    return;
  }
  return scripts\engine\utility::random(level._id_0F5F783A9D656258._id_48D4812167FBB628[vehicletype]);
}