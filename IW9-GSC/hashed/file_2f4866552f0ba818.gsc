/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2f4866552f0ba818.gsc
***********************************************/

_id_5A426C120B990E2C() {
  level._id_8ABD2C3C0748DFDD = getdvarint("dvar_298CC7147EF3F50B", 0);
  _id_48814951E916AF89::init();

  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  while(!isDefined(level.stealth))
    waitframe();

  while(!isDefined(level.agentarray))
    waitframe();

  setDvar("dvar_D3907CDE9245B595", 0);
  level._id_B747EE617515989A = getdvarint("dvar_DC995FFE71BB3262", 256);
  level._id_72E8A99508B7BE1B = getdvarint("dvar_80DAB21524B4B344", 32);
  level._id_33BF1309AB913BEA = getdvarint("dvar_23D2D501004ED790", 2);
  level._id_3881C7EA72921771 = getdvarint("dvar_6D3496529AF637A1", 6);
  level._id_9D28D5B70AA9F5E4 = ::_id_F83373EC853727E4;
  wait 1;
  level._id_830F45E2E1A72FE9 = [];

  foreach(objective in level.objectives)
  objective._id_99669E1E71DBD643 = [];

  _id_3B29F5840BE404C8 = level.gw_objstruct.axishqloc.trigger.origin;
  _id_F0E061BC5D7DF499("axis", _id_3B29F5840BE404C8);
  _id_3B29F5840BE404C8 = level.gw_objstruct.allieshqloc.trigger.origin;
  _id_F0E061BC5D7DF499("allies", _id_3B29F5840BE404C8);

  while(!isDefined(level.gameskill) || !isDefined(level.difficultytype))
    waitframe();

  level thread _id_5D5756B4F3AD6727("axis");
  level thread _id_5D5756B4F3AD6727("allies");
  _id_CFDE0D78A0770CE5 = [];

  foreach(objective in level.gw_objstruct.startingfobs_neutral) {
    _id_92DB85C8DCF21152 = spawnStruct();
    _id_92DB85C8DCF21152.origin = objective.trigger.origin;
    _id_CFDE0D78A0770CE5[_id_CFDE0D78A0770CE5.size] = _id_92DB85C8DCF21152;
  }

  _id_2BC0B0102F9B7751::_id_16C5CA10B4C664A7(_id_CFDE0D78A0770CE5, 1);
  _id_2BC0B0102F9B7751::_id_BF8AB11DD9E76F93(::_id_A23016F4E8D27AD9);
}

_id_F0E061BC5D7DF499(team, _id_3B29F5840BE404C8) {
  _id_1107CD549B74476C = [];

  if(!isDefined(level._id_17A9EC1F2CB3D31C))
    level._id_17A9EC1F2CB3D31C = [];

  level._id_17A9EC1F2CB3D31C[team] = [];

  foreach(objective in level.objectives)
  objective._id_99669E1E71DBD643[team] = [];

  foreach(objective in level.objectives)
  _id_1107CD549B74476C[objective.objectivekey] = distance(_id_3B29F5840BE404C8, objective.origin);

  _id_7C0082DF0C8D0198 = sortbydistance(level.objectives, _id_3B29F5840BE404C8);
  _id_B866B4302E49723D = 0;
  _id_DA8AD15A62B1F458 = undefined;

  foreach(objective in _id_7C0082DF0C8D0198) {
    if(level._id_17A9EC1F2CB3D31C[team].size == 0) {
      level._id_17A9EC1F2CB3D31C[team][_id_B866B4302E49723D] = [];
      level._id_17A9EC1F2CB3D31C[team][_id_B866B4302E49723D][0] = objective;
      _id_DA8AD15A62B1F458 = _id_1107CD549B74476C[objective.objectivekey];
      continue;
    }

    if(abs(_id_DA8AD15A62B1F458 - _id_1107CD549B74476C[objective.objectivekey]) < 2048) {
      level._id_17A9EC1F2CB3D31C[team][_id_B866B4302E49723D][level._id_17A9EC1F2CB3D31C[team][_id_B866B4302E49723D].size] = objective;
      _id_DA8AD15A62B1F458 = _id_1107CD549B74476C[objective.objectivekey];
      continue;
    } else {
      _id_B866B4302E49723D++;
      level._id_17A9EC1F2CB3D31C[team][_id_B866B4302E49723D] = [];
      level._id_17A9EC1F2CB3D31C[team][_id_B866B4302E49723D][0] = objective;
      _id_DA8AD15A62B1F458 = _id_1107CD549B74476C[objective.objectivekey];
      continue;
    }
  }
}

_id_5D5756B4F3AD6727(team) {
  level endon("game_ended");
  _id_35C0E0D47EA5452F = "gw_fob_" + team + "HQ";
  _id_FD5EA9CB37C309D3 = level.spawnselectionlocations[_id_35C0E0D47EA5452F][team].spawnpoints;
  _id_B5B1784D5A1327C7 = "spawnHQ_" + team;
  _id_48814951E916AF89::_id_BA4022744DCE59F6(_id_B5B1784D5A1327C7, level._id_72E8A99508B7BE1B);
  level thread _id_42E3CAC95300F3B6();

  for(;;) {
    _id_3D2E4B298E935C8D = _id_48814951E916AF89::_id_9368FB9261E4CD0A(_id_B5B1784D5A1327C7);
    _id_0A678C8EEA807690 = level._id_72E8A99508B7BE1B - _id_3D2E4B298E935C8D;

    if(_id_0A678C8EEA807690 > level._id_33BF1309AB913BEA)
      _id_0A678C8EEA807690 = level._id_33BF1309AB913BEA;

    _id_FD5EA9CB37C309D3 = scripts\engine\utility::array_randomize(_id_FD5EA9CB37C309D3);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0A678C8EEA807690; _id_AC0E594AC96AA3A8++) {
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB();
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_FD5EA9CB37C309D3[_id_AC0E594AC96AA3A8].origin, _id_FD5EA9CB37C309D3[_id_AC0E594AC96AA3A8].angles, "medium", _id_B5B1784D5A1327C7, undefined, _id_B5B1784D5A1327C7, team);

      if(isDefined(agent)) {
        agent thread _id_8F5702C79710B342(agent, team);
        _id_4A7A3357A053496D = _id_B2B5DE3C80EBCEB4(agent);
        origin = getclosestpointonnavmesh(_id_4A7A3357A053496D.origin + (randomfloatrange(level._id_B747EE617515989A * -1.0, level._id_B747EE617515989A), randomfloatrange(level._id_B747EE617515989A * -1.0, level._id_B747EE617515989A), 0));
        agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, origin);
      }
    }

    wait 20;
  }
}

_id_8F5702C79710B342(agent, team) {
  waitframe();
  agent.gameskill = _id_53DA3333B83B3527::get_gameskill();
  agent _id_53DA3333B83B3527::apply_difficulty_settings(1);
  _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "team", team);
  _id_2E6F8AA8306432ED(agent);
}

_id_B2B5DE3C80EBCEB4(agent) {
  if(isDefined(agent._id_4A7A3357A053496D) && agent._id_4A7A3357A053496D.ownerteam == "neutral")
    return agent._id_4A7A3357A053496D;

  foreach(index, group in level._id_17A9EC1F2CB3D31C[agent.team]) {
    if(isDefined(agent._id_B866B4302E49723D) && index <= agent._id_B866B4302E49723D) {
      continue;
    }
    _id_FD7E4FD2FC6452A2 = scripts\engine\utility::array_randomize(group);

    foreach(objective in _id_FD7E4FD2FC6452A2) {
      if(objective._id_99669E1E71DBD643[agent.team].size < level._id_3881C7EA72921771 && (objective.ownerteam == agent.team || objective.ownerteam == "neutral")) {
        agent._id_4A7A3357A053496D = objective;
        agent._id_B866B4302E49723D = index;
        _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "assignedObjective", objective);
        objective._id_99669E1E71DBD643[agent.team][objective._id_99669E1E71DBD643[agent.team].size] = agent;
        return objective;
      }
    }
  }

  if(!isDefined(agent._id_4A7A3357A053496D)) {
    keys = getarraykeys(level._id_17A9EC1F2CB3D31C[agent.team]);
    _id_FFEA19DCB2194908 = scripts\engine\utility::random(keys);
    _id_E31223333F557B21 = level._id_17A9EC1F2CB3D31C[agent.team][_id_FFEA19DCB2194908];
    objective = scripts\engine\utility::random(_id_E31223333F557B21);
    agent._id_4A7A3357A053496D = objective;
    agent._id_B866B4302E49723D = _id_FFEA19DCB2194908;
    _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "assignedObjective", objective);
    objective._id_99669E1E71DBD643[agent.team][objective._id_99669E1E71DBD643[agent.team].size] = agent;
    return objective;
  }

  return agent._id_4A7A3357A053496D;
}

_id_42E3CAC95300F3B6() {
  level endon("game_ended");

  for(;;) {
    foreach(agent in level.agentarray) {
      if(isalive(agent) && isDefined(agent._id_4A7A3357A053496D)) {
        _id_4A7A3357A053496D = _id_B2B5DE3C80EBCEB4(agent);
        origin = getclosestpointonnavmesh(_id_4A7A3357A053496D.origin + (randomfloatrange(level._id_B747EE617515989A * -1.0, level._id_B747EE617515989A), randomfloatrange(level._id_B747EE617515989A * -1.0, level._id_B747EE617515989A), 0));
        agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, origin);
      }
    }

    wait 20;
  }
}

_id_2E6F8AA8306432ED(agent) {
  if(agent.team == "axis") {
    body = "body_spetsnaz_cqc";
    head = "head_spetsnaz_cqc";
  } else {
    body = "body_mp_eastern_geist_1_1_lod1";
    head = "head_mp_eastern_bale_1_1";
  }

  weapon = undefined;
  _id_A664AAD02EE98BD2 = _id_371B4C2AB5861E62::_id_BA0801276542946B();
  grenadeammo = getdvarint("dvar_2E7CC22BEE3354DF", 0);
  armor = 0;
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, head, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor);
  agent.baseaccuracy = getdvarfloat("dvar_949A1D9903E71C7A", 0.4);
}

_id_F83373EC853727E4(agent, _id_772EDBDCFE906C73) {
  if(!isDefined(agent._id_4A7A3357A053496D))
    _id_4A7A3357A053496D = _id_B2B5DE3C80EBCEB4(agent);

  _id_1F48F987BA8392D0 = level._id_B747EE617515989A * 3;
  origin = getclosestpointonnavmesh(agent._id_4A7A3357A053496D.origin + (randomfloatrange(_id_1F48F987BA8392D0 * -1.0, _id_1F48F987BA8392D0), randomfloatrange(_id_1F48F987BA8392D0 * -1.0, _id_1F48F987BA8392D0), 0));
  agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, origin);
}

_id_359EA987396492DB() {
  _id_CCFF9574F6A53859 = getdvarint("dvar_F4B8192392C987FC", 25);
  _id_B60A2AD1B8EB2369 = getdvarint("dvar_8EEC5964FBFE4A41", 5);

  if(istrue(level._id_8ABD2C3C0748DFDD)) {}

  _id_DD7BFEA4EB1DA762 = [];

  foreach(key, data in level.spawnselectionlocations) {
    if(issubstr(key, "_hq_")) {
      continue;
    }
    _id_DD7BFEA4EB1DA762[key] = data;
  }

  _id_6C95BB29DB70AF0C = _id_DD7BFEA4EB1DA762.size * _id_CCFF9574F6A53859 / 100;
  _id_F6FFE6E5EB90834A = scripts\engine\utility::array_randomize(getarraykeys(_id_DD7BFEA4EB1DA762));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6C95BB29DB70AF0C; _id_AC0E594AC96AA3A8++)
    _id_95D5AE2B8159B521(_id_B60A2AD1B8EB2369, _id_F6FFE6E5EB90834A[_id_AC0E594AC96AA3A8], "team_six", 1);
}

_id_95D5AE2B8159B521(numagents, objectivename, team, _id_FD9831032CDDAA89) {
  _id_FD5EA9CB37C309D3 = [];

  if(istrue(_id_FD9831032CDDAA89)) {
    foreach(team in level.spawnselectionlocations[objectivename])
    _id_FD5EA9CB37C309D3 = scripts\engine\utility::array_combine(_id_FD5EA9CB37C309D3, team.spawnpoints);
  }

  agents = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
    loc = scripts\engine\utility::random(_id_FD5EA9CB37C309D3);
    agent = undefined;

    if(isDefined(loc) && isDefined(loc.origin) && isDefined(loc.angles) && isDefined(objectivename)) {
      aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB();
      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc.origin, loc.angles, "medium", "everybody", "objective", objectivename);

      if(!isDefined(agent) && istrue(level._id_8ABD2C3C0748DFDD)) {}
    }

    agents[agents.size] = agent;
  }

  _id_800054CA1A89DACE = undefined;

  foreach(objective in level.gw_objstruct.startingfobs_neutral) {
    if(objective.name == objectivename) {
      _id_800054CA1A89DACE = objective.trigger.origin;
      break;
    }
  }

  foreach(agent in agents) {
    if(isalive(agent) && isDefined(agent)) {
      if(isDefined(_id_800054CA1A89DACE))
        agent _id_120270BD0A747A35::_id_304DA84D9A815C01(getclosestpointonnavmesh(_id_800054CA1A89DACE), 1024);

      agent scripts\stealth\enemy::bt_set_stealth_state("combat", undefined);
      agent.stealth.script_nexthuntpos = _id_800054CA1A89DACE;
    }
  }
}

_id_E7AD80F4A663B94B(objectivekey, numagents, team) {
  if(!isDefined(team))
    return undefined;

  _id_800054CA1A89DACE = level.objectives[objectivekey].trigger.origin;
  agents = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(numagents, _id_800054CA1A89DACE, "medium", "everybody", "heli", objectivekey, team);
  return agents;
}

_id_CDE31646BDB6A9D1(objectivekey, numagents, team) {
  if(!isDefined(team))
    return undefined;

  _id_800054CA1A89DACE = level.objectives[objectivekey].trigger.origin;
  agents = _id_640CF1641C03E2A0::_id_55AB9C6DA96226E7(numagents, _id_800054CA1A89DACE, _id_800054CA1A89DACE[2] + 5000, undefined, "medium", "everybody", "paratroopers", team);
  return agents;
}

_id_A23016F4E8D27AD9(_id_34CE337E073A0C34, _id_93390A6953905FEF, team) {
  _id_9B3BB378DB91CF83 = spawnStruct();
  _id_9B3BB378DB91CF83.origin = _id_34CE337E073A0C34;
  _id_4F922AF45D0CAC6C = sortbydistance(level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C, _id_9B3BB378DB91CF83.origin);
  _id_29376CACC64CC4E6 = _id_2BC0B0102F9B7751::_id_321665DCDCBF401E(_id_4F922AF45D0CAC6C, _id_34CE337E073A0C34);

  if(isDefined(_id_29376CACC64CC4E6))
    return _id_29376CACC64CC4E6;

  return undefined;
}

_id_0E86EA43131BE76C() {
  level thread _id_268C4DA1EF6A20A8::init();
  _id_48814951E916AF89::init();
  _id_48814951E916AF89::_id_BA4022744DCE59F6("everybody", 100);
  level thread _id_640CF1641C03E2A0::_id_CA39A413ACE3C168();
  level thread _id_2BC0B0102F9B7751::_id_D0FFCD08E0870CF2();

  while(!istrue(level._id_AA5583D4CBBFD72E))
    waitframe();

  level thread _id_848D0782943B416D();
  _id_48814951E916AF89::_id_2FC80954FA70D153();

  foreach(key, obj in level.objectives) {
    numagents = getdvarint("dvar_C9A6B9ED9529AEAD", 15);
    _id_40E875A042B82875 = getdvarint("dvar_FA7168124C5A98ED", 0);
    level thread _id_A30A48F0C1A403EC(key, "team_hundred_ninety_five", numagents, _id_40E875A042B82875, 1);
  }
}

_id_A30A48F0C1A403EC(objectivekey, team, numagents, _id_40E875A042B82875, _id_F750412DF131D69A) {
  obj = level.objectives[objectivekey];
  groupname = _id_48814951E916AF89::_id_78759441C259F58A(obj.trigger.origin);
  _id_9815FCE1944A6AE0 = _id_120270BD0A747A35::_id_2E33F8E46F95167C(obj.trigger.origin, 1024, 1);
  _id_F1548C57038E1B7A = scripts\engine\utility::array_combine(_id_9815FCE1944A6AE0._id_E67F0B2EA7AE69ED, _id_9815FCE1944A6AE0._id_8A055A821DDA7DA0, _id_9815FCE1944A6AE0._id_3288C473E8336AB4);

  if(!isDefined(numagents))
    numagents = getdvarint("dvar_32626C81A7C27E96", 5);

  if(numagents > 0) {
    if(!istrue(_id_F750412DF131D69A)) {
      _id_0B58631347B6AB04 = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(numagents, obj.trigger.origin, "medium", "everybody", "captureAgents", groupname, team, 1, undefined, undefined, undefined, undefined, 1);

      foreach(agent in _id_0B58631347B6AB04) {
        if(isDefined(obj._id_3BF790F79CB25065))
          agent setgoalvolumeauto(obj._id_3BF790F79CB25065);

        agent.objectivekey = objectivekey;

        if(scripts\mp\utility\teams::isgameplayteam(team))
          level._id_141462A19F98285A[objectivekey][team].agents[level._id_141462A19F98285A[objectivekey][team].agents.size] = agent;
      }
    } else {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
        aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB();
        _id_924B776D91E77572 = undefined;

        if(_id_F1548C57038E1B7A.size > 0) {
          _id_25DD3020969AA0F6 = _id_120270BD0A747A35::_id_3A17F0CCDDC999B4(obj.trigger.origin, _id_F1548C57038E1B7A, 3, 256, 0);
          _id_25DD3020969AA0F6 = scripts\engine\utility::array_randomize(_id_25DD3020969AA0F6);

          if(_id_25DD3020969AA0F6.size > 0)
            _id_924B776D91E77572 = _id_25DD3020969AA0F6;
        }

        spawnorigin = obj.trigger.origin;

        if(isDefined(_id_924B776D91E77572))
          spawnorigin = _id_924B776D91E77572[0].origin;

        agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, obj.trigger.origin, (0, 0, 0), "medium", "everybody", "captureAgents", groupname, team, undefined, undefined, 1);

        if(isDefined(agent)) {
          _id_0FD32F08E72B657F::_id_35C195DF2BA46725(agent, "team_hundred_ninety_five");

          if(isDefined(_id_924B776D91E77572))
            _id_120270BD0A747A35::_id_2B26D000F2CCFC11(agent, _id_924B776D91E77572[0]);
          else
            agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, 256, 256);

          if(isDefined(obj._id_3BF790F79CB25065))
            agent setgoalvolumeauto(obj._id_3BF790F79CB25065);

          agent.objectivekey = objectivekey;

          if(scripts\mp\utility\teams::isgameplayteam(team))
            level._id_141462A19F98285A[objectivekey][team].agents[level._id_141462A19F98285A[objectivekey][team].agents.size] = agent;
        }
      }
    }
  }

  if(!isDefined(_id_40E875A042B82875))
    _id_40E875A042B82875 = getdvarint("dvar_FF335488D9D13E7C", 0);

  if(_id_40E875A042B82875 > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_40E875A042B82875; _id_AC0E594AC96AA3A8++) {
      _id_EF178BB38661FF1B = undefined;

      if(_id_F1548C57038E1B7A.size > 0) {
        _id_25DD3020969AA0F6 = _id_120270BD0A747A35::_id_3A17F0CCDDC999B4(obj.trigger.origin, _id_F1548C57038E1B7A, _id_F1548C57038E1B7A.size, 256, 0);
        _id_25DD3020969AA0F6 = scripts\engine\utility::array_randomize(_id_25DD3020969AA0F6);

        if(_id_25DD3020969AA0F6.size > 0)
          _id_EF178BB38661FF1B = _id_25DD3020969AA0F6[0];
      }

      spawnorigin = obj.trigger.origin;

      if(isDefined(_id_EF178BB38661FF1B))
        spawnorigin = _id_EF178BB38661FF1B.origin;

      agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("actor_enemy_mp_jugg_aq", spawnorigin, (0, 0, 0), "absolute", "everybody", "jugg", groupname, undefined, undefined, undefined, 1);

      if(isDefined(agent)) {
        _id_371B4C2AB5861E62::_id_1828F1E20E52B418(agent);

        if(isDefined(_id_EF178BB38661FF1B))
          _id_120270BD0A747A35::_id_2B26D000F2CCFC11(agent, _id_EF178BB38661FF1B);
        else
          agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, 256, 256);

        if(isDefined(obj._id_3BF790F79CB25065))
          agent setgoalvolumeauto(obj._id_3BF790F79CB25065);
      }
    }
  }
}

_id_3B97B97E14948C02(_id_34CE337E073A0C34, _id_93390A6953905FEF) {
  _id_9B3BB378DB91CF83 = spawnStruct();
  _id_9B3BB378DB91CF83.origin = _id_34CE337E073A0C34;
  _id_4F922AF45D0CAC6C = sortbydistance(level._id_B6D8EEC09E6F3C63._id_4F922AF45D0CAC6C, _id_9B3BB378DB91CF83.origin);
  _id_29376CACC64CC4E6 = _id_2BC0B0102F9B7751::_id_321665DCDCBF401E(_id_4F922AF45D0CAC6C, _id_34CE337E073A0C34);

  if(isDefined(_id_29376CACC64CC4E6))
    return _id_29376CACC64CC4E6;

  return undefined;
}

_id_5CD456D9B2CDC538(agent, _id_6181DE250AFA5BB6) {
  if(!isDefined(agent.objectivekey) || !scripts\mp\utility\teams::isgameplayteam(agent.team)) {
    return;
  }
  level._id_141462A19F98285A[agent.objectivekey][agent.team].agents = scripts\engine\utility::array_remove(level._id_141462A19F98285A[agent.objectivekey][agent.team].agents, agent);
}

_id_848D0782943B416D() {
  _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_5CD456D9B2CDC538, level);
  _id_BCCBF55E003F6240 = getdvarint("dvar_32626C81A7C27E96", 5);
  _id_FDE40312BD18AE9E = getdvarint("dvar_9780788CA9CFA05B", 2);
  _id_68299821AD1626E0 = getdvarint("dvar_DCE73A817D63D040", 30) * 1000;
  level._id_141462A19F98285A = [];

  foreach(key, obj in level.objectives) {
    level._id_141462A19F98285A[key] = [];

    foreach(team in level.teamnamelist) {
      data = spawnStruct();
      data.agents = [];
      data._id_8E55C5943A080A2E = 0;
      level._id_141462A19F98285A[key][team] = data;
    }
  }

  for(;;) {
    foreach(key, obj in level.objectives) {
      wait 1.0;
      team = obj.ownerteam;

      if(team == "neutral") {
        continue;
      }
      currenttime = gettime();

      if(currenttime < level._id_141462A19F98285A[key][team]._id_8E55C5943A080A2E + _id_68299821AD1626E0) {
        continue;
      }
      _id_9CC5BE111B6FA65C = [];

      foreach(agent in level._id_141462A19F98285A[key][team].agents) {
        if(agent.health > 0)
          _id_9CC5BE111B6FA65C[_id_9CC5BE111B6FA65C.size] = agent;
      }

      level._id_141462A19F98285A[key][team].agents = _id_9CC5BE111B6FA65C;
      _id_3E955591D6FEBC8D = level._id_141462A19F98285A[key][team].agents.size;

      if(_id_3E955591D6FEBC8D <= _id_FDE40312BD18AE9E) {
        level thread _id_A30A48F0C1A403EC(key, team, _id_BCCBF55E003F6240 - _id_3E955591D6FEBC8D, 0);
        level._id_141462A19F98285A[key][team]._id_8E55C5943A080A2E = currenttime;
      }
    }
  }
}