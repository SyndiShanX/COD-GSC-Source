/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_audio.gsc
***********************************************/

_id_7E508409C4935112(_id_F90E9A2E19CBCED8) {
  _id_51941101270F867D = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85(_id_F90E9A2E19CBCED8);

  if(_id_51941101270F867D == "" && _id_F90E9A2E19CBCED8 != "")
    _id_51941101270F867D = _id_F90E9A2E19CBCED8;

  return _id_51941101270F867D;
}

_id_9941DAD3D3D51468(_id_6B9A0DBBF039DECE) {
  _id_CBFB00F6FDB0AFBA = undefined;

  if(!isDefined(_id_6B9A0DBBF039DECE)) {
    return;
  }
  if(_id_6B9A0DBBF039DECE == 1)
    _id_CBFB00F6FDB0AFBA = "_classic";

  return _id_CBFB00F6FDB0AFBA;
}

_id_CAEAF68AB0E87565(players, _id_F90E9A2E19CBCED8, _id_74B5B12BB6514385, _id_6B9A0DBBF039DECE) {
  if(!isDefined(_id_F90E9A2E19CBCED8)) {
    return;
  }
  if(_id_1174ABEDBEFE9ADA::_id_28F7A303238284EE()) {
    return;
  }
  _id_74B5B12BB6514385 = scripts\engine\utility::_id_53C4C53197386572(_id_74B5B12BB6514385, 0.0);
  _id_51941101270F867D = _id_7E508409C4935112(_id_F90E9A2E19CBCED8);

  if(isDefined(_id_6B9A0DBBF039DECE))
    _id_CBFB00F6FDB0AFBA = _id_7E508409C4935112(_id_6B9A0DBBF039DECE);
  else
    _id_CBFB00F6FDB0AFBA = undefined;

  level scripts\engine\utility::delaythread(_id_74B5B12BB6514385, _id_7AB5B649FA408138::_id_FE75A89529DD0FD0, players, _id_51941101270F867D, undefined, undefined, _id_CBFB00F6FDB0AFBA);
}

_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, _id_F90E9A2E19CBCED8, _id_74B5B12BB6514385, _id_6B9A0DBBF039DECE) {
  if(!isDefined(_id_F90E9A2E19CBCED8)) {
    return;
  }
  if(_id_1174ABEDBEFE9ADA::_id_28F7A303238284EE()) {
    return;
  }
  _id_74B5B12BB6514385 = scripts\engine\utility::_id_53C4C53197386572(_id_74B5B12BB6514385, 0.0);
  _id_51941101270F867D = _id_7E508409C4935112(_id_F90E9A2E19CBCED8);

  if(isDefined(_id_6B9A0DBBF039DECE))
    _id_CBFB00F6FDB0AFBA = _id_7E508409C4935112(_id_6B9A0DBBF039DECE);
  else
    _id_CBFB00F6FDB0AFBA = undefined;

  level scripts\engine\utility::delaythread(_id_74B5B12BB6514385, _id_7AB5B649FA408138::_id_46979D2FD81A6D4B, _id_FABF84450735DD93, _id_51941101270F867D, undefined, _id_CBFB00F6FDB0AFBA);
}

_id_9B8077B5CD6F43B1(teams, _id_F90E9A2E19CBCED8) {
  foreach(team in teams)
  _id_C1FD3441CCFBA6F8(_id_F90E9A2E19CBCED8, team);
}

_id_202AE29F54B67993(_id_FABF84450735DD93, _id_6E077719C0EFCB61, radius, _id_F90E9A2E19CBCED8, _id_74B5B12BB6514385, _id_6B9A0DBBF039DECE) {
  if(!isDefined(_id_F90E9A2E19CBCED8)) {
    return;
  }
  if(_id_1174ABEDBEFE9ADA::_id_28F7A303238284EE()) {
    return;
  }
  _id_74B5B12BB6514385 = scripts\engine\utility::_id_53C4C53197386572(_id_74B5B12BB6514385, 0.0);
  _id_51941101270F867D = _id_7E508409C4935112(_id_F90E9A2E19CBCED8);
  level scripts\engine\utility::delaythread(_id_74B5B12BB6514385, _id_7AB5B649FA408138::_id_FDD0934F1A32F70D, _id_6E077719C0EFCB61, radius, _id_51941101270F867D, _id_FABF84450735DD93, _id_6B9A0DBBF039DECE);
}

_id_4231B99C9D0E1875(_id_45A0FFA62AA6BFA8, players, _id_F90E9A2E19CBCED8, delay, _id_6B9A0DBBF039DECE) {
  players = scripts\engine\utility::array_remove_array(players, _id_45A0FFA62AA6BFA8._id_085E53E70C7110DA);

  if(isarray(players) && players.size > 0) {
    _id_CBFB00F6FDB0AFBA = undefined;

    if(isDefined(_id_6B9A0DBBF039DECE))
      _id_CBFB00F6FDB0AFBA = _id_F90E9A2E19CBCED8 + _id_9941DAD3D3D51468(_id_6B9A0DBBF039DECE);

    _id_CAEAF68AB0E87565(players, _id_F90E9A2E19CBCED8, delay, _id_CBFB00F6FDB0AFBA);

    foreach(player in players) {
      if(isPlayer(player)) {
        _id_C53E78332A6C514F = player getentitynumber();
        _id_45A0FFA62AA6BFA8._id_085E53E70C7110DA[_id_C53E78332A6C514F] = player;
        player._id_AC30570114234210 = 1;
      }
    }
  }
}

_id_30F2D27959CA7507(_id_45A0FFA62AA6BFA8, players, _id_F90E9A2E19CBCED8, delay) {
  if(isarray(players) && players.size > 0) {
    _id_CAEAF68AB0E87565(players, _id_F90E9A2E19CBCED8, delay);

    foreach(player in players) {
      if(isPlayer(player)) {
        _id_C53E78332A6C514F = player getentitynumber();
        _id_45A0FFA62AA6BFA8._id_085E53E70C7110DA[_id_C53E78332A6C514F] = undefined;
        player._id_AC30570114234210 = undefined;
      }
    }
  }
}

_id_889B71CBCB02D4E1(_id_45A0FFA62AA6BFA8, _id_6E077719C0EFCB61, radius, team, _id_F90E9A2E19CBCED8, delay, _id_6B9A0DBBF039DECE) {
  players = _id_7AB5B649FA408138::_id_D6FE092BC83DA45B(_id_6E077719C0EFCB61, radius, team);
  _id_4231B99C9D0E1875(_id_45A0FFA62AA6BFA8, players, _id_F90E9A2E19CBCED8, delay, _id_6B9A0DBBF039DECE);
}

_id_AE73DBEDF54B701F(players, _id_F90E9A2E19CBCED8, _id_74B5B12BB6514385, _id_6B9A0DBBF039DECE) {
  if(!isDefined(_id_F90E9A2E19CBCED8)) {
    return;
  }
  if(_id_1174ABEDBEFE9ADA::_id_28F7A303238284EE()) {
    return;
  }
  _id_74B5B12BB6514385 = scripts\engine\utility::_id_53C4C53197386572(_id_74B5B12BB6514385, 0.0);
  _id_51941101270F867D = _id_7E508409C4935112(_id_F90E9A2E19CBCED8);
  _id_330AF766290F5BFA = [];

  foreach(player in players) {
    if(isPlayer(player)) {
      _id_E499790B0786EB88 = istrue(player._id_AC30570114234210) || istrue(player._id_2441210FE6EEA080);

      if(!_id_E499790B0786EB88)
        _id_330AF766290F5BFA = scripts\engine\utility::array_add(_id_330AF766290F5BFA, player);
    }
  }

  _id_CBFB00F6FDB0AFBA = undefined;

  if(isDefined(_id_6B9A0DBBF039DECE))
    _id_CBFB00F6FDB0AFBA = _id_F90E9A2E19CBCED8 + _id_9941DAD3D3D51468(_id_6B9A0DBBF039DECE);

  _id_CAEAF68AB0E87565(_id_330AF766290F5BFA, _id_F90E9A2E19CBCED8, _id_74B5B12BB6514385, _id_CBFB00F6FDB0AFBA);
}

_id_5C07A5046A6DC0F4(_id_A3BF560B25C4A33E, _id_6E077719C0EFCB61, radius, _id_F90E9A2E19CBCED8, _id_74B5B12BB6514385, _id_6B9A0DBBF039DECE) {
  if(!isDefined(_id_F90E9A2E19CBCED8)) {
    return;
  }
  if(_id_1174ABEDBEFE9ADA::_id_28F7A303238284EE()) {
    return;
  }
  players = _id_7AB5B649FA408138::_id_D6FE092BC83DA45B(_id_6E077719C0EFCB61, radius, _id_A3BF560B25C4A33E);
  _id_AE73DBEDF54B701F(players, _id_F90E9A2E19CBCED8, _id_74B5B12BB6514385, _id_6B9A0DBBF039DECE);
}

_id_12BB57E8DD07E939(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(_id_80EF668C09FFB70F in array) {
    _id_B30B086EBFEB7F53 = scripts\mp\utility\player::isreallyalive(_id_80EF668C09FFB70F);

    if(!_id_B30B086EBFEB7F53) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = _id_80EF668C09FFB70F;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_38D3CA2B80804E24(players, origin, radius, team) {
  _id_878914B0358BC7B5 = _id_7AB5B649FA408138::_id_D6FE092BC83DA45B(origin, radius, team);
  _id_49D97C7342A0B24C = scripts\engine\utility::array_difference(players, _id_878914B0358BC7B5);
  _id_FA817B3E1D246130 = _id_12BB57E8DD07E939(_id_49D97C7342A0B24C);
  return _id_FA817B3E1D246130;
}

_id_BA92E3AB3234F345(players) {
  _id_FA817B3E1D246130 = _id_12BB57E8DD07E939(players);
  _id_20900957E6D2013F = scripts\engine\utility::array_difference(players, _id_FA817B3E1D246130);
  return _id_20900957E6D2013F;
}

_id_0882459B3AA239C4(players, origin, radius, team) {
  _id_878914B0358BC7B5 = _id_7AB5B649FA408138::_id_D6FE092BC83DA45B(origin, radius, team);
  _id_49D97C7342A0B24C = scripts\engine\utility::array_difference(players, _id_878914B0358BC7B5);
  _id_FA817B3E1D246130 = _id_12BB57E8DD07E939(_id_878914B0358BC7B5);
  _id_20900957E6D2013F = scripts\engine\utility::array_difference(_id_878914B0358BC7B5, _id_FA817B3E1D246130);
  _id_C071B5D1B8FA53FD = scripts\engine\utility::array_combine(_id_49D97C7342A0B24C, _id_20900957E6D2013F);
  return _id_C071B5D1B8FA53FD;
}

_id_62CA322DDE3AB783(agent, _id_E52F572DFADB149F, _id_0E23B09DE2E27ED9) {
  _id_E52F572DFADB149F = scripts\engine\utility::_id_53C4C53197386572(_id_E52F572DFADB149F, 12000);
  _id_0E23B09DE2E27ED9 = scripts\engine\utility::_id_53C4C53197386572(_id_0E23B09DE2E27ED9, 30000);

  if(!isDefined(agent))
    return undefined;

  state = undefined;

  if(isnumber(agent.health) && agent.health <= 0) {
    state = "dead";
    return state;
  }

  _id_82D990C965650A23 = scripts\engine\utility::_id_53C4C53197386572(agent.lastenemysighttime, 0);

  if(isarray(agent.attackerdata)) {
    foreach(attackerdata in agent.attackerdata) {
      if(isnumber(attackerdata.lasttimedamaged) && attackerdata.lasttimedamaged > _id_82D990C965650A23)
        _id_82D990C965650A23 = attackerdata.lasttimedamaged;
    }
  }

  if(_id_82D990C965650A23 == 0)
    state = "idle";
  else {
    _id_64F88D0441939203 = gettime();
    _id_50A2B6968424656C = _id_64F88D0441939203 - _id_82D990C965650A23;

    if(_id_50A2B6968424656C >= _id_0E23B09DE2E27ED9)
      state = "idle";
    else if(_id_50A2B6968424656C >= _id_E52F572DFADB149F)
      state = "alert";
    else if(_id_50A2B6968424656C < _id_E52F572DFADB149F)
      state = "combat";
  }

  return state;
}

_id_CADC473B3A7D171C(vehicle, _id_E52F572DFADB149F, _id_0E23B09DE2E27ED9) {
  _id_E52F572DFADB149F = scripts\engine\utility::_id_53C4C53197386572(_id_E52F572DFADB149F, 12000);
  _id_0E23B09DE2E27ED9 = scripts\engine\utility::_id_53C4C53197386572(_id_0E23B09DE2E27ED9, 30000);
  state = undefined;

  if(isDefined(vehicle) && isstring(vehicle.currentstate))
    state = vehicle.currentstate;

  if(!isDefined(vehicle._id_8A2A32E2464A95DB))
    vehicle._id_8A2A32E2464A95DB = 0;

  if(isstring(state) && (state == "attack" || state == "combat"))
    vehicle._id_8A2A32E2464A95DB = gettime();

  if(isnumber(vehicle._id_8A2A32E2464A95DB)) {
    if(vehicle._id_8A2A32E2464A95DB == 0)
      state = "idle";
    else {
      _id_64F88D0441939203 = gettime();
      _id_779CC6BBBA56FA06 = _id_64F88D0441939203 - vehicle._id_8A2A32E2464A95DB;

      if(_id_779CC6BBBA56FA06 >= _id_0E23B09DE2E27ED9)
        state = "idle";
      else if(_id_779CC6BBBA56FA06 >= _id_E52F572DFADB149F)
        state = "alert";
      else if(_id_779CC6BBBA56FA06 < _id_E52F572DFADB149F)
        state = "combat";
    }
  }

  return state;
}

_id_2D29365E60139DF1(ent, _id_E52F572DFADB149F, _id_0E23B09DE2E27ED9) {
  state = "???";

  if(isDefined(ent) && isstring(ent.classname)) {
    if(ent.classname == "agent")
      state = _id_62CA322DDE3AB783(ent, _id_E52F572DFADB149F, _id_0E23B09DE2E27ED9);
    else if(ent.classname == "script_vehicle")
      state = _id_CADC473B3A7D171C(ent);
  }

  if(!isDefined(state))
    state = "???";

  return state;
}

_id_2351F113D5579540(ent) {
  enemy = undefined;

  if(isDefined(ent) && isstring(ent.classname)) {
    if(ent.classname == "agent")
      enemy = ent.enemy;
    else if(ent.classname == "script_vehicle") {
      if(isstring(ent.vehiclename) && ent.vehiclename == "dmz_boss_chopper")
        enemy = _id_20FC47823E95E4AF::_id_32DA9B74B9E6D888(ent);
      else if(isstring(ent.vehiclename) && ent.vehiclename == "pac_sentry")
        enemy = ent._id_C6DFDD9743149226;
      else
        enemy = ent.enemy;
    }
  }

  return enemy;
}

_id_B5BE3A44077AEC21(_id_0566868292EE2A1B, _id_985AE874212B863E, _id_E52F572DFADB149F, _id_0E23B09DE2E27ED9, _id_6B9A0DBBF039DECE) {
  level endon("game_ended");
  _id_0566868292EE2A1B notify("stop_boss_ai_music_thread");
  _id_0566868292EE2A1B endon("stop_boss_ai_music_thread");

  if(!isarray(_id_0566868292EE2A1B._id_085E53E70C7110DA))
    _id_0566868292EE2A1B._id_085E53E70C7110DA = [];

  _id_0566868292EE2A1B._id_56524C0776D62D8C = _id_E52F572DFADB149F;
  _id_0566868292EE2A1B._id_1910DE7604C2D4A0 = _id_0E23B09DE2E27ED9;
  state = "idle";
  enemy = undefined;
  _id_0ACD9B4729D23197 = "idle";
  _id_5DA6E5DA7BD60520 = undefined;
  _id_6181DE250AFA5BB6 = undefined;
  _id_CBFB00F6FDB0AFBA = undefined;

  while(!istrue(_id_0566868292EE2A1B._id_6181D0250AFA3CEC)) {
    _id_E2958F412A7425C0 = scripts\engine\utility::_id_53C4C53197386572(_id_0566868292EE2A1B._id_E2958F412A7425C0, _id_0566868292EE2A1B.agent);
    state = _id_2D29365E60139DF1(_id_E2958F412A7425C0, _id_E52F572DFADB149F, _id_0E23B09DE2E27ED9);
    enemy = _id_2351F113D5579540(_id_E2958F412A7425C0);
    _id_276ADDAD006D7D88 = isstring(state) && state != _id_0ACD9B4729D23197;
    _id_D5F4A3ADCDDA8A85 = isDefined(enemy) && isDefined(_id_5DA6E5DA7BD60520) && enemy != _id_5DA6E5DA7BD60520 || isDefined(enemy) && !isDefined(_id_5DA6E5DA7BD60520);

    if(_id_276ADDAD006D7D88 || _id_D5F4A3ADCDDA8A85) {
      if(state == "dead") {
        break;
      }

      _id_1D509F7271D9BE18 = _id_985AE874212B863E[state];

      if(isarray(_id_1D509F7271D9BE18) && isstring(_id_1D509F7271D9BE18[0])) {
        _id_F90E9A2E19CBCED8 = _id_1D509F7271D9BE18[0];
        delay = _id_1D509F7271D9BE18[1];
        _id_9DF00C73E6741337 = isPlayer(enemy) && !scripts\engine\utility::array_contains(_id_0566868292EE2A1B._id_085E53E70C7110DA, enemy);

        if(state == "combat" && _id_9DF00C73E6741337)
          _id_889B71CBCB02D4E1(_id_0566868292EE2A1B, enemy, level._id_B1149892B2595056, enemy.team, _id_F90E9A2E19CBCED8, delay, _id_6B9A0DBBF039DECE);
        else if(state == "idle" && _id_0566868292EE2A1B._id_085E53E70C7110DA.size > 0)
          _id_30F2D27959CA7507(_id_0566868292EE2A1B, _id_0566868292EE2A1B._id_085E53E70C7110DA, _id_F90E9A2E19CBCED8, delay);
      }
    }

    if(_id_0566868292EE2A1B._id_085E53E70C7110DA.size > 0) {
      _id_1D509F7271D9BE18 = _id_985AE874212B863E["idle"];
      _id_749AD895EA80D046 = isent(_id_E2958F412A7425C0) && isvector(_id_E2958F412A7425C0.origin);
      _id_BB7805258A1F947D = undefined;

      if(istrue(_id_749AD895EA80D046))
        _id_BB7805258A1F947D = _id_38D3CA2B80804E24(_id_0566868292EE2A1B._id_085E53E70C7110DA, _id_E2958F412A7425C0.origin, level._id_7B10B08DDB3F610F);

      if(isarray(_id_BB7805258A1F947D) && _id_BB7805258A1F947D.size > 0 && isarray(_id_1D509F7271D9BE18) && isstring(_id_1D509F7271D9BE18[0])) {
        _id_F90E9A2E19CBCED8 = _id_1D509F7271D9BE18[0];
        delay = _id_1D509F7271D9BE18[1];
        _id_30F2D27959CA7507(_id_0566868292EE2A1B, _id_BB7805258A1F947D, _id_F90E9A2E19CBCED8, delay);
      }

      _id_20900957E6D2013F = _id_BA92E3AB3234F345(_id_0566868292EE2A1B._id_085E53E70C7110DA);

      if(isarray(_id_20900957E6D2013F) && _id_20900957E6D2013F.size > 0) {
        _id_F90E9A2E19CBCED8 = "dmz_activity_lose";
        delay = 0.0;
        _id_30F2D27959CA7507(_id_0566868292EE2A1B, _id_20900957E6D2013F, _id_F90E9A2E19CBCED8, delay);
      }
    }

    _id_0ACD9B4729D23197 = state;
    _id_5DA6E5DA7BD60520 = enemy;
    _id_0D8E566314371B23 = randomintrange(1, 5);
    waittime = _id_0D8E566314371B23 * 0.05;

    if(isent(_id_E2958F412A7425C0)) {
      _id_E2958F412A7425C0 scripts\engine\utility::waittill_any_timeout_1(waittime, "death");
      continue;
    }

    wait(waittime);
  }
}

_id_73F954808739F7BC(_id_0566868292EE2A1B, _id_6181DE250AFA5BB6, _id_F5D18545CC5B0616, _id_1CCBC0E90FCC38CA, _id_75AA8F7260CAAAF2, _id_D4222FE9C4D26866) {
  _id_0566868292EE2A1B notify("stop_boss_ai_music_thread");

  if(isarray(_id_0566868292EE2A1B._id_085E53E70C7110DA) && _id_0566868292EE2A1B._id_085E53E70C7110DA.size > 0) {
    _id_D10123541BCE9C64 = level._id_B1149892B2595056 * 2;
    _id_A0585BC229DCD714 = _id_7AB5B649FA408138::_id_D6FE092BC83DA45B(_id_6181DE250AFA5BB6, _id_D10123541BCE9C64, _id_6181DE250AFA5BB6.team);
    _id_30F2D27959CA7507(_id_0566868292EE2A1B, _id_A0585BC229DCD714, _id_F5D18545CC5B0616, _id_1CCBC0E90FCC38CA);

    if(isDefined(_id_75AA8F7260CAAAF2)) {
      _id_75AA8F7260CAAAF2 = scripts\engine\utility::_id_53C4C53197386572(_id_75AA8F7260CAAAF2, "dmz_activity_lose");
      _id_D4222FE9C4D26866 = scripts\engine\utility::_id_53C4C53197386572(_id_D4222FE9C4D26866, 3.0);
      _id_30F2D27959CA7507(_id_0566868292EE2A1B, _id_0566868292EE2A1B._id_085E53E70C7110DA, _id_75AA8F7260CAAAF2, _id_D4222FE9C4D26866);
    }
  }
}

_id_2E4AFBF3AEAF31E4(_id_0566868292EE2A1B, _id_F90E9A2E19CBCED8, _id_54307D62E05248F8) {
  _id_0566868292EE2A1B notify("stop_boss_ai_music_thread");

  if(isarray(_id_0566868292EE2A1B._id_085E53E70C7110DA) && _id_0566868292EE2A1B._id_085E53E70C7110DA.size > 0) {
    _id_5EFAA35D4E74FF73 = level._id_B1149892B2595056 * 2;
    players = _id_7AB5B649FA408138::_id_D6FE092BC83DA45B(_id_0566868292EE2A1B._id_E2958F412A7425C0, _id_5EFAA35D4E74FF73);
    _id_30F2D27959CA7507(_id_0566868292EE2A1B, players, _id_F90E9A2E19CBCED8, _id_54307D62E05248F8);
  }
}