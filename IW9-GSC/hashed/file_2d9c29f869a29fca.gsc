/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2d9c29f869a29fca.gsc
***********************************************/

_id_6D19FE96E8F91A3C(eventtable) {
  level endon("game_ended");

  while(!istrue(level._id_FC7E9CF9D867765E))
    waitframe();

  level._id_8ECA0B5093624BAD = spawnStruct();
  level._id_8ECA0B5093624BAD._id_0A302CA030D14B6C = eventtable;
  level._id_8ECA0B5093624BAD._id_B708CF6F19119633 = getdvarint("dvar_288D569D27B5EDC2", 2);
  level._id_8ECA0B5093624BAD._id_F0F01BFAA7703DCD = getDvar("dvar_05D8E3D6670A11C2", "ru");
  _id_76D53099646022B8();
  _id_902E1FCB8EBAEC65();
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  level thread _id_A5EAD3B5172A91D1();
  level thread _id_0882D145C90B49B0();
}

_id_76D53099646022B8() {
  level._id_8ECA0B5093624BAD._id_1DACE216D1A32D14 = level._id_FB4C92E328823A89;
  level._id_8ECA0B5093624BAD._id_D7BAAFC9B07F5094 = level._id_C5233088F09B986A;
}

_id_902E1FCB8EBAEC65() {
  level._id_8ECA0B5093624BAD._id_2F52CFB4D771F71C = [];
  level._id_8ECA0B5093624BAD._id_2F52CFB4D771F71C["nearest"] = ::_id_A724D7F20A1CFFC7;
  level._id_8ECA0B5093624BAD._id_2F52CFB4D771F71C["random"] = ::_id_1C1AF0D6E2EE8166;
  level._id_8ECA0B5093624BAD._id_86610F45C6029B86 = [];
  level._id_8ECA0B5093624BAD._id_86610F45C6029B86["wander"] = ::_id_604779072961884B;
  level._id_8ECA0B5093624BAD._id_86610F45C6029B86["patrol"] = ::_id_F521618DC02A370B;
  level._id_8ECA0B5093624BAD._id_86610F45C6029B86["combat_rush"] = ::_id_232CEAFDCFDF50F9;
  level._id_8ECA0B5093624BAD._id_86610F45C6029B86["stealth_combat"] = ::_id_7768F5DFBF84A754;
  level._id_8ECA0B5093624BAD._id_309BEA83DDCFD6BE = [];
  level._id_8ECA0B5093624BAD._id_309BEA83DDCFD6BE["random_player"] = ::_id_066256226FE7618B;
  level._id_8ECA0B5093624BAD._id_309BEA83DDCFD6BE["event_target"] = ::_id_EF7CA6696BDB3C2E;
  level._id_8ECA0B5093624BAD._id_309BEA83DDCFD6BE["static"] = ::_id_A0F12C6178A9E8BB;
  _id_37095D3B46D6306C();
}

_id_37095D3B46D6306C() {
  table = level._id_8ECA0B5093624BAD._id_0A302CA030D14B6C;

  if(!isDefined(table)) {
    return;
  }
  if(!tableexists(table)) {
    return;
  }
  _id_C79A36400A031D9C = 0;
  _id_FF84A340872F8208 = _id_C79A36400A031D9C + 1;
  _id_65631BE0FB33399A = _id_FF84A340872F8208 + 1;
  _id_F16A0C5D3A48CA79 = _id_65631BE0FB33399A + 1;
  _id_46802C2082D6DD62 = _id_F16A0C5D3A48CA79 + 1;
  _id_4253B2A384E3B914 = _id_46802C2082D6DD62 + 1;
  _id_3BFC066F17F970D4 = _id_4253B2A384E3B914 + 1;
  _id_E5741D5C76968477 = _id_3BFC066F17F970D4 + 1;
  _id_C37CB0F31A08CBE7 = _id_E5741D5C76968477 + 1;
  _id_FA48F60FAC73396D = _id_C37CB0F31A08CBE7 + 1;
  events = [];
  _id_977F24E61599CBBA = tablelookupgetnumrows(table);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_977F24E61599CBBA; _id_AC0E594AC96AA3A8++) {
    _id_AA4213CD309FD5CC = _id_AC0E594AC96AA3A8 + 2;
    event = spawnStruct();
    notifystring = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_C79A36400A031D9C));
    _id_5BDFC7C0F9BFAE90 = notifystring == "";

    if(_id_5BDFC7C0F9BFAE90) {
      continue;
    }
    spawntype = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_FF84A340872F8208));

    if(scripts\engine\utility::string_starts_with(spawntype, "elevator_")) {
      event._id_62F322F5314DFF70 = "nearest";
      _id_AD1CF7DFD996AEB0 = _func_2E84A570D6AF300A(spawntype, "elevator_");
      event._id_AD1CF7DFD996AEB0 = _id_AD1CF7DFD996AEB0;
    } else
      event._id_62F322F5314DFF70 = spawntype;

    behavior = tolower(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_65631BE0FB33399A));
    event.behavior = behavior;

    if(!isDefined(level._id_8ECA0B5093624BAD._id_86610F45C6029B86[behavior]))
      event.behavior = "wander";

    _id_9C09C62F3E77079E = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_F16A0C5D3A48CA79);
    event.patroltarget = _id_9C09C62F3E77079E;
    event._id_AA3B0E88545B7496 = _id_9C09C62F3E77079E;

    if(isDefined(event._id_AA3B0E88545B7496) && event._id_AA3B0E88545B7496 != "") {
      if(!isDefined(level._id_8ECA0B5093624BAD._id_309BEA83DDCFD6BE[event._id_AA3B0E88545B7496])) {
        target = scripts\engine\utility::getStruct(event._id_AA3B0E88545B7496, "targetname");

        if(isDefined(target)) {
          event._id_AA3B0E88545B7496 = "static";
          event._id_9C09C62F3E77079E = target;
          _id_239F3C52A3F4D4C0 = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_46802C2082D6DD62);

          if(_id_239F3C52A3F4D4C0 != "") {
            _id_A1078A4990D909C2 = level.stealth.combat_volumes[_id_239F3C52A3F4D4C0];

            if(isDefined(_id_A1078A4990D909C2) && ispointinvolume(target.origin, _id_A1078A4990D909C2))
              event._id_4793A774F31B8A49 = _id_239F3C52A3F4D4C0;
            else {}
          }
        } else
          continue;
      } else
        event._id_AA3B0E88545B7496 = tolower(event._id_AA3B0E88545B7496);
    }

    event.tier = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_4253B2A384E3B914));

    if(event.tier < 1 || event.tier > 3)
      event.tier = 1;

    if(int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_3BFC066F17F970D4)) == 1)
      event._id_DCF5E15C58C4152A = "elite";

    event._id_A42605E2D29AC0CA = int(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_E5741D5C76968477));
    event.vo = tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_C37CB0F31A08CBE7);

    if(event.vo == "")
      event.vo = undefined;

    event.agents = _id_0BDF9FB6DF358658(tablelookupbyrow(table, _id_AC0E594AC96AA3A8, _id_FA48F60FAC73396D));

    if(!isDefined(events[notifystring]))
      events[notifystring] = [];

    events[notifystring][events[notifystring].size] = event;
  }

  level._id_8ECA0B5093624BAD.events = events;
}

_id_0BDF9FB6DF358658(_id_2901E44A3E919B00) {
  _id_1406328DB677DD32 = strtok(tolower(_id_2901E44A3E919B00), "|");
  agents = [];

  foreach(slot in _id_1406328DB677DD32) {
    agent = spawnStruct();
    _id_67F14F8315CB0F2F = strtok(slot, "_");

    if(_id_67F14F8315CB0F2F.size < 2) {
      continue;
    }
    if(scripts\engine\utility::string_starts_with(slot, "enemy_mp_"))
      agent._id_1439F86640D42E34 = slot;
    else if(issubstr(slot, "spawnset")) {
      _id_DBF36F7631378496 = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_67F14F8315CB0F2F.size; _id_AC0E594AC96AA3A8++) {
        if(_id_67F14F8315CB0F2F[_id_AC0E594AC96AA3A8] == "spawnset") {
          for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < _id_67F14F8315CB0F2F.size; _id_AC0E5C4AC96AAA41++)
            _id_DBF36F7631378496[_id_DBF36F7631378496.size] = _id_67F14F8315CB0F2F[_id_AC0E5C4AC96AAA41];

          break;
        }
      }

      if(_id_DBF36F7631378496.size > 0)
        agent._id_FCDC7F62624C71FF = scripts\engine\utility::_id_996B01CD49D0128D(_id_DBF36F7631378496, "_");
      else
        continue;
    } else
      agent._id_1439F86640D42E34 = _id_67F14F8315CB0F2F[1];

    agents[agents.size] = agent;
  }

  return agents;
}

_id_844DFE93476D59AB(notifystring, origin, _id_87D4C4075F48EC58, onspawnfunc) {
  events = level._id_8ECA0B5093624BAD.events[notifystring];

  foreach(_id_769BB62217827DD4 in events) {
    event = _func_7E7B315FCB2B9159(_id_769BB62217827DD4);

    if(!_id_A4775F34D5D40F6F(event)) {
      continue;
    }
    event._id_EA3E3B2121E6713A = notifystring;
    event.origin = origin;
    event.targetorigin = origin;
    event._id_87D4C4075F48EC58 = _id_87D4C4075F48EC58;
    event.onspawnfunc = onspawnfunc;

    if(isDefined(event._id_AD1CF7DFD996AEB0)) {
      _id_6C8A34DB9465C360(event);
      level thread _id_7610D369D923704B(event.vo);
      continue;
    }

    _id_F8A2519FE9829057(event);
  }
}

_id_A4775F34D5D40F6F(event) {
  if(isDefined(event._id_A42605E2D29AC0CA))
    return event._id_A42605E2D29AC0CA <= level._id_153F283BCBFFA477;

  return 1;
}

_id_7610D369D923704B(vo) {
  level endon("game_ended");

  if(!isDefined(vo)) {
    return;
  }
  if(istrue(level._id_4F02FD233CCED2AD)) {
    return;
  }
  if(!isDefined(level._id_0E1CA44858CD8EA1)) {
    return;
  }
  if(istrue(level._id_EB9576F309942FF4)) {
    return;
  }
  level thread[[level._id_0E1CA44858CD8EA1]](vo);

  if(istrue(level._id_EB9576F309942FF4)) {
    level._id_4F02FD233CCED2AD = 1;
    wait 20;
    level._id_4F02FD233CCED2AD = 0;
  }
}

_id_F8A2519FE9829057(event) {
  level._id_8ECA0B5093624BAD._id_E0E163A9ECF33364[level._id_8ECA0B5093624BAD._id_E0E163A9ECF33364.size] = event;
}

_id_A5EAD3B5172A91D1() {
  level endon("game_ended");
  level._id_8ECA0B5093624BAD._id_E0E163A9ECF33364 = [];
  level._id_8ECA0B5093624BAD._id_73EC3E3E7E7A5BC5 = 0;

  for(;;) {
    _id_E0E163A9ECF33364 = level._id_8ECA0B5093624BAD._id_E0E163A9ECF33364;
    level._id_8ECA0B5093624BAD._id_E0E163A9ECF33364 = [];

    foreach(event in _id_E0E163A9ECF33364) {
      _id_4D66B39D0C0E3BB3 = level._id_8ECA0B5093624BAD._id_2F52CFB4D771F71C[event._id_62F322F5314DFF70];
      _id_E60D0AD459B4749F = level._id_8ECA0B5093624BAD._id_86610F45C6029B86[event.behavior];
      _id_9577902B42FBD7F6 = [];

      if(isDefined(_id_4D66B39D0C0E3BB3))
        _id_9577902B42FBD7F6 = [[_id_4D66B39D0C0E3BB3]](event);

      if(_id_9577902B42FBD7F6.size == 0) {
        continue;
      }
      if(!isDefined(level._id_8ECA0B5093624BAD._id_C56AF23D6560EA95))
        level._id_8ECA0B5093624BAD._id_C56AF23D6560EA95 = 0;

      level._id_8ECA0B5093624BAD._id_C56AF23D6560EA95++;
      _id_8E5A9B658FA525ED = undefined;

      if(level._id_8ECA0B5093624BAD._id_C56AF23D6560EA95 % level._id_8ECA0B5093624BAD._id_B708CF6F19119633 == 0)
        _id_8E5A9B658FA525ED = level._id_8ECA0B5093624BAD._id_F0F01BFAA7703DCD;

      count = 0;
      _id_531A693C75E5D9AD = min(_id_9577902B42FBD7F6.size, event.agents.size);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_531A693C75E5D9AD; _id_AC0E594AC96AA3A8++) {
        _id_AE32DFE2FB67FFB2 = event.agents[_id_AC0E594AC96AA3A8];
        _id_AE32DFE2FB67FFB2._id_FB1DEF007972B25A = _id_9577902B42FBD7F6[_id_AC0E594AC96AA3A8].origin;
        _id_AE32DFE2FB67FFB2.tier = event.tier;
        _id_AE32DFE2FB67FFB2._id_DCF5E15C58C4152A = event._id_DCF5E15C58C4152A;
        _id_AE32DFE2FB67FFB2._id_4793A774F31B8A49 = event._id_4793A774F31B8A49;
        _id_AE32DFE2FB67FFB2._id_8E5A9B658FA525ED = _id_8E5A9B658FA525ED;
        agent = _id_8D179EAE4D8341F6(_id_AE32DFE2FB67FFB2);

        if(isDefined(agent)) {
          if(isDefined(_id_E60D0AD459B4749F))
            agent thread[[_id_E60D0AD459B4749F]](event);

          if(isDefined(event.onspawnfunc))
            agent thread[[event.onspawnfunc]]();

          count++;
        }
      }
    }

    waitframe();
  }
}

_id_0882D145C90B49B0() {
  level endon("game_ended");
  level._id_153F283BCBFFA477 = 0;
  level waittill("match_start_real_countdown");
  teamswithplayers = [];

  foreach(player in level.players)
  teamswithplayers[player.team] = 1;

  for(level._id_153F283BCBFFA477 = teamswithplayers.size; !level.nojip; level._id_153F283BCBFFA477 = teamswithplayers.size) {
    level waittill("add_to_team", player);
    teamswithplayers[player.team] = 1;
  }
}

_id_A724D7F20A1CFFC7(event) {
  return _id_6153E980B3EB0E1B::_id_184496A131FC4014(event.origin);
}

_id_A99608223FCD0B11(event) {
  loc = event.origin;
  _id_3EAD649FC902FEC2 = 0;

  if(isDefined(level._id_172E4B629498723C))
    _id_3EAD649FC902FEC2 = [[level._id_172E4B629498723C]](loc);

  if(!isDefined(_id_3EAD649FC902FEC2))
    return [];

  _id_1DACE216D1A32D14 = sortbydistancecullbyradius(level._id_8ECA0B5093624BAD._id_1DACE216D1A32D14, loc, event._id_04C133E205730F37);
  _id_4F0FC1C36324AFFB = event._id_15FF0FB9B87937F5 * event._id_15FF0FB9B87937F5;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1DACE216D1A32D14.size; _id_AC0E594AC96AA3A8++) {
    if(_id_1DACE216D1A32D14[_id_AC0E594AC96AA3A8].floor != _id_3EAD649FC902FEC2) {
      continue;
    }
    dist = distance2dsquared(_id_1DACE216D1A32D14[_id_AC0E594AC96AA3A8].origin, loc);

    if(dist > _id_4F0FC1C36324AFFB)
      return _id_1DACE216D1A32D14[_id_AC0E594AC96AA3A8]._id_B7015A0DBEFEBCE1;
  }

  return [];
}

_id_1C1AF0D6E2EE8166(event) {
  index = randomint(level._id_8ECA0B5093624BAD._id_1DACE216D1A32D14.size);

  foreach(_id_782866E364DCD2EF in level._id_8ECA0B5093624BAD._id_1DACE216D1A32D14) {
    if(index == 0)
      return _id_782866E364DCD2EF._id_B7015A0DBEFEBCE1;

    index--;
  }

  return [];
}

_id_8D179EAE4D8341F6(_id_AE32DFE2FB67FFB2) {
  spawnorigin = getclosestpointonnavmesh(_id_AE32DFE2FB67FFB2._id_FB1DEF007972B25A);
  _id_FCDC7F62624C71FF = _id_AE32DFE2FB67FFB2._id_FCDC7F62624C71FF;
  tier = _id_AE32DFE2FB67FFB2.tier;
  _id_1439F86640D42E34 = _id_AE32DFE2FB67FFB2._id_1439F86640D42E34;
  _id_80F4BDE7090A4773 = _id_AE32DFE2FB67FFB2._id_DCF5E15C58C4152A;
  _id_8E5A9B658FA525ED = _id_AE32DFE2FB67FFB2._id_8E5A9B658FA525ED;

  if(scripts\engine\utility::string_starts_with(_id_1439F86640D42E34, "enemy_mp_"))
    aitype = _id_1439F86640D42E34;
  else
    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, _id_FCDC7F62624C71FF, _id_1439F86640D42E34, tier, _id_8E5A9B658FA525ED);

  _id_EC8AF9ED3E95D273 = _id_AE32DFE2FB67FFB2._id_4793A774F31B8A49;

  if(!isDefined(_id_EC8AF9ED3E95D273)) {
    level._id_8ECA0B5093624BAD._id_73EC3E3E7E7A5BC5++;
    _id_EC8AF9ED3E95D273 = "bio_reinforce_" + floor(level._id_8ECA0B5093624BAD._id_73EC3E3E7E7A5BC5 / 48);
  }

  if(isDefined(level._id_4B195D3DD0024B9C))
    team = level._id_4B195D3DD0024B9C;
  else
    team = "team_hundred_ninety_five";

  if(isDefined(_id_8E5A9B658FA525ED))
    team = _id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC(_id_8E5A9B658FA525ED);

  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, spawnorigin, (0, 0, 0), "medium", "reinforcements", "biolab", _id_EC8AF9ED3E95D273, team, undefined, undefined, undefined, undefined, 0, _id_80F4BDE7090A4773);

  if(isDefined(agent)) {
    agent._id_B582B10663B5B2A9 = 0;

    if(getdvarint("dvar_B0E7EDF188DDB934", 1) == 1)
      agent.aggressivemode = 1;

    agent.goalheight = 80;

    if(tier == 3)
      agent._id_CD6A3A50F09688B9 = undefined;
  } else {}

  return agent;
}

_id_174FFC9E64F5CE0D() {
  if(isDefined(level.agentarray)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.agentarray.size; _id_AC0E594AC96AA3A8++) {
      _id_355D66BD195DDB35 = "bio_reinforce_gas_" + floor(_id_AC0E594AC96AA3A8 / 48);
      agent = level.agentarray[_id_AC0E594AC96AA3A8];

      if(istrue(agent.isactive)) {
        agent cleargoalvolume();
        agent.script_stealthgroup = _id_355D66BD195DDB35;
        agent._id_D7F4A1B60F84E53F = _id_355D66BD195DDB35;
        scripts\stealth\group::addtogroup(_id_355D66BD195DDB35, agent);

        if(agent._id_FE5EBEFA740C7106 == 3) {
          _id_448DCBC6F715EFDC = level.stealth.combat_volumes[agent.script_stealthgroup];

          if(isDefined(_id_448DCBC6F715EFDC))
            agent setbtgoalvolume(0, _id_448DCBC6F715EFDC);
          else
            agent clearbtgoal(0);
        }
      }
    }
  }

  foreach(door in level._id_F64C6EF6F688A407) {
    if(door._id_8F7EDDC9C0864A1B == "stuck" || door._id_8F7EDDC9C0864A1B == "high_security")
      door _meth_80902296B05BE00A();
  }
}

_id_604779072961884B(event) {
  thread _id_CEE3B39981879330(self, 256, 256);
}

_id_CEE3B39981879330(agent, radius, _id_C154E6E386654A30, origin) {
  _id_2AE805B43221A762 = origin;

  if(isagent(agent) && !isDefined(origin))
    _id_2AE805B43221A762 = agent.origin;

  if(!isDefined(radius))
    radius = 100;

  if(!isDefined(_id_C154E6E386654A30) || _id_C154E6E386654A30 <= 0)
    _id_C154E6E386654A30 = 50;

  _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, _id_2AE805B43221A762, radius, _id_C154E6E386654A30);

  if(isint(agent)) {
    return;
  }
  agent endon("death");
  agent endon("stealth_investigate");
  agent endon("stealth_hunt");
  agent endon("stealth_combat");
  agent endon("startCombatRush");
  agent endon("simulate_stealth_combat");
  _id_120270BD0A747A35::_id_1670C315976C767B();
  wait 1;
  _id_4793A774F31B8A49 = agent.script_stealthgroup;

  if(!isDefined(_id_4793A774F31B8A49))
    _id_4793A774F31B8A49 = agent.script_groupname;

  _id_448DCBC6F715EFDC = scripts\engine\utility::ter_op(isDefined(_id_4793A774F31B8A49), level.stealth.combat_volumes[_id_4793A774F31B8A49], undefined);
  _id_B58BA569FFDA4497 = origin;

  if(!isDefined(_id_B58BA569FFDA4497))
    _id_B58BA569FFDA4497 = agent.origin;

  if(isDefined(_id_448DCBC6F715EFDC)) {
    targetorigin = agent _meth_DC3E712739096E5F(_id_B58BA569FFDA4497, _id_448DCBC6F715EFDC);

    if(!isDefined(targetorigin))
      targetorigin = agent _meth_DC3E712739096E5F(_id_448DCBC6F715EFDC.origin, _id_448DCBC6F715EFDC);

    if(isDefined(targetorigin)) {
      origin = targetorigin;
      agent _id_120270BD0A747A35::_id_304DA84D9A815C01(targetorigin, 8, 1);
      agent waittill("goal");
    }
  }

  originalorigin = agent.origin;
  min = radius - _id_C154E6E386654A30;
  max = radius + _id_C154E6E386654A30;

  if(issubstr(agent.agent_type, "riot"))
    agent thread _id_FB85F3C76446F0A6(_id_448DCBC6F715EFDC);

  for(;;) {
    _id_BCFEC646853A95C1 = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_BCFEC546853A938E = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    _id_B30A6C38CD4FE517 = (originalorigin[0] + _id_BCFEC646853A95C1, originalorigin[1] + _id_BCFEC546853A938E, originalorigin[2]);

    if(distance2d(agent.origin, _id_B30A6C38CD4FE517) > 20) {
      if(isDefined(_id_448DCBC6F715EFDC)) {
        _id_B30A6C38CD4FE517 = agent _meth_DC3E712739096E5F(_id_B30A6C38CD4FE517, _id_448DCBC6F715EFDC);

        if(isDefined(_id_B30A6C38CD4FE517)) {
          _id_E24929C0E254D7B4 = agent getclosestreachablepointonnavmesh(_id_B30A6C38CD4FE517, 0);

          if(!isDefined(_id_E24929C0E254D7B4) || !ispointinvolume(_id_E24929C0E254D7B4, _id_448DCBC6F715EFDC))
            _id_B30A6C38CD4FE517 = undefined;
        }
      }

      if(isDefined(_id_B30A6C38CD4FE517)) {
        agent _id_120270BD0A747A35::_setgoalpos(_id_B30A6C38CD4FE517, 8);

        if(isDefined(_id_448DCBC6F715EFDC) && isDefined(agent.scriptgoalpos) && ispointinvolume(agent.scriptgoalpos, _id_448DCBC6F715EFDC))
          agent setgoalvolume(_id_448DCBC6F715EFDC);

        agent thread _id_120270BD0A747A35::_id_BF182F1600FEC92A(agent);
        agent scripts\engine\utility::waittill_any_2("goal", "refreshGoalPos");
      }
    }

    wait(randomfloatrange(4.5, 5.5));
  }
}

_id_FB85F3C76446F0A6(volume) {
  level endon("game_ended");
  self endon("death");
  self._id_C833409FB72D15FB = 1;
  _id_67AA26E315CB0F92 = 500;
  _id_8F31932AB91DC7E1 = "dmz_bio_lab_radiation_started";
  scripts\common\utility::set_battlechatter(0);
  msg = "";
  _id_EC8AF9ED3E95D273 = undefined;

  if(isDefined(level.stealth.groupdata))
    _id_EC8AF9ED3E95D273 = level.stealth.groupdata.groups[self.script_groupname];

  for(;;) {
    _id_BC79FC4E4BAD97C4 = 0;

    if(isDefined(_id_EC8AF9ED3E95D273) && _id_EC8AF9ED3E95D273.members.size != 0) {
      foreach(_id_80EF668C09FFB70F in _id_EC8AF9ED3E95D273.members) {
        if(_id_80EF668C09FFB70F != self && isalive(_id_80EF668C09FFB70F) && _id_80EF668C09FFB70F._id_FE5EBEFA740C7106 == 3) {
          _id_BC79FC4E4BAD97C4 = 1;
          break;
        }
      }
    } else if(isalive(self.enemy))
      _id_BC79FC4E4BAD97C4 = 1;

    if(_id_BC79FC4E4BAD97C4) {
      break;
    }

    msg = level scripts\engine\utility::waittill_any_timeout_1(1, _id_8F31932AB91DC7E1);

    if(msg == _id_8F31932AB91DC7E1) {
      break;
    }
  }

  self notify("simulate_stealth_combat");

  if(msg != _id_8F31932AB91DC7E1 && isDefined(volume)) {
    for(;;) {
      _id_AC1F7E6AECC80188 = 0;

      if(isalive(self.enemy)) {
        pos = findclosestlospointwithinvolume(volume, self.enemy.origin, self.origin, [self.enemy.origin], _id_67AA26E315CB0F92);

        if(isDefined(pos)) {
          _id_120270BD0A747A35::_setgoalpos(pos, 8);

          if(isDefined(self.scriptgoalpos) && ispointinvolume(self.scriptgoalpos, volume))
            self setgoalvolume(volume);

          thread _id_120270BD0A747A35::_id_BF182F1600FEC92A(self);
          _id_AC1F7E6AECC80188 = 1;
        }
      }

      if(_id_AC1F7E6AECC80188)
        msg = scripts\engine\utility::waittill_any_ents_return(level, _id_8F31932AB91DC7E1, self, "goal", self, "refreshGoalPos");
      else
        msg = level scripts\engine\utility::waittill_any_timeout_1(1, _id_8F31932AB91DC7E1);

      if(msg == _id_8F31932AB91DC7E1) {
        break;
      }
    }
  }

  for(;;) {
    _id_AC1F7E6AECC80188 = 0;

    if(isalive(self.enemy)) {
      pos = findclosestlospointwithinradius(self.enemy.origin, 1000, self.enemy.origin, self.origin, [self.enemy.origin], _id_67AA26E315CB0F92);

      if(isDefined(pos)) {
        _id_120270BD0A747A35::_setgoalpos(pos, 8);
        thread _id_120270BD0A747A35::_id_BF182F1600FEC92A(self);
        _id_AC1F7E6AECC80188 = 1;
      }
    }

    if(_id_AC1F7E6AECC80188) {
      scripts\engine\utility::waittill_any_2("goal", "refreshGoalPos");
      continue;
    }

    wait 1;
  }
}

_id_232CEAFDCFDF50F9(event) {
  origin = [[level._id_8ECA0B5093624BAD._id_309BEA83DDCFD6BE[event._id_AA3B0E88545B7496]]](event);

  if(isDefined(origin)) {
    if(!isDefined(event._id_87D4C4075F48EC58))
      event._id_87D4C4075F48EC58 = 512;

    if(isDefined(event._id_AD1CF7DFD996AEB0) && isDefined(event._id_A15DE8F6EED9F024)) {
      _id_2BD923437ECC04BD = [event._id_A15DE8F6EED9F024, origin];
      _id_FAE1573B43B85605 = [32, event._id_87D4C4075F48EC58];
      thread _id_6153E980B3EB0E1B::_id_A2500A5266B0321A(self, _id_2BD923437ECC04BD, 0, _id_FAE1573B43B85605, undefined, undefined, undefined, ::_id_CEE3B39981879330);
    } else
      thread _id_120270BD0A747A35::_id_A5117518725DA028(self, origin, 0, event._id_87D4C4075F48EC58, undefined, undefined, undefined, undefined, ::_id_CEE3B39981879330);
  } else {}
}

_id_F521618DC02A370B(event) {
  pathstruct = level._id_8ECA0B5093624BAD._id_D7BAAFC9B07F5094[event.patroltarget];
  level thread _id_120270BD0A747A35::_id_25CC93D439C3033A([self], pathstruct);
}

_id_7768F5DFBF84A754(event) {
  scripts\stealth\enemy::bt_set_stealth_state("combat");
  closestplayer = undefined;
  _id_84D4866087B00608 = undefined;

  foreach(player in level.players) {
    if(isalive(player)) {
      distsq = distancesquared(player.origin, self.origin);

      if(!isDefined(_id_84D4866087B00608) || _id_84D4866087B00608 > distsq) {
        _id_84D4866087B00608 = distsq;
        closestplayer = player;
      }
    }
  }

  if(isDefined(closestplayer))
    self getenemyinfo(closestplayer);

  self._id_5323A94889EFF1DE = 1;
  self resetthreatupdate();
}

_id_066256226FE7618B(event) {
  _id_6D39356E6E1F0FC1 = 0;

  for(player = undefined; _id_6D39356E6E1F0FC1 < 20; _id_6D39356E6E1F0FC1++) {
    player = scripts\engine\utility::random(level.players);

    if(scripts\mp\utility\player::_id_AD443BBCDCF37B85(player))
      return player.origin;
  }

  if(isDefined(player))
    return player.origin;

  return undefined;
}

_id_A0F12C6178A9E8BB(event) {
  return event._id_9C09C62F3E77079E.origin;
}

_id_EF7CA6696BDB3C2E(event) {
  return event.targetorigin;
}

_id_3FB0D650BE8286CE() {
  level endon("game_ended");

  while(!istrue(level._id_B212A36BEC6CF8DA))
    waitframe();

  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_reinforcement", "moving", ::_id_4E36E0590E67E09A);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_reinforcement", "doors_open", ::_id_EC009A967D1D5EB9);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_reinforcement", "doors_closing", ::_id_8B680B3EF155FC34);
}

_id_6C8A34DB9465C360(event) {
  if(event._id_AD1CF7DFD996AEB0 == "ideal") {
    if(!isDefined(event.origin)) {
      event.origin = [[level._id_8ECA0B5093624BAD._id_309BEA83DDCFD6BE[event._id_AA3B0E88545B7496]]](event);

      if(!isDefined(event.origin))
        return;
    }
  }

  _id_BA669C07247B5AB0 = spawnStruct();
  _id_BA669C07247B5AB0.event = event;

  if(scripts\engine\utility::string_starts_with(event._id_AD1CF7DFD996AEB0, "id_")) {
    _id_32E27AD06C3E7804 = _func_2E84A570D6AF300A(event._id_AD1CF7DFD996AEB0, "id_");
    _id_5C118165D3E98A42::_id_20E0F2F56A5BA71F("reinforcement", "elevator_group_reinforcement", "moving", _id_32E27AD06C3E7804, ::_id_1B85310C60FEEB2F, _id_BA669C07247B5AB0);
  } else
    _id_5C118165D3E98A42::_id_8435B8855414BB47("reinforcement", "elevator_group_reinforcement", "moving", event.origin, "elevator_pick_rule_" + event._id_AD1CF7DFD996AEB0, undefined, ::_id_1B85310C60FEEB2F, _id_BA669C07247B5AB0);
}

_id_1B85310C60FEEB2F(_id_EEC55FABA21F3653, params) {
  _id_EEC55FABA21F3653.event = params.event;
}

_id_4E36E0590E67E09A() {
  _id_EC3FEABCB6D33C37 = self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2]._id_0E4118BDA122B112;
  _id_6201EA4A59D9E92F = self._id_3EAD649FC902FEC2 - self._id_33DE00DF8A9FBBE0;

  if(_id_6201EA4A59D9E92F > 0)
    _id_EC3FEABCB6D33C37 setscriptablepartstate("model", "up", 0);
  else
    _id_EC3FEABCB6D33C37 setscriptablepartstate("model", "down", 0);

  _id_5C118165D3E98A42::_id_AB1C91150C30299A();
  _id_EC3FEABCB6D33C37 setscriptablepartstate("model", "arrived", 0);
  self.state = "doors_open";
}

_id_EC009A967D1D5EB9() {
  self.event.origin = self.car.origin;
  self.event._id_A15DE8F6EED9F024 = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_BD440A13487263EF;
  _id_F8A2519FE9829057(self.event);
  self._id_C5E7FCE963586EC0 = [[level._id_8ECA0B5093624BAD._id_309BEA83DDCFD6BE[self.event._id_AA3B0E88545B7496]]](self.event);
  _id_6153E980B3EB0E1B::_id_EC009A967D1D5EB9();
  self.state = "doors_closing";
}

_id_8B680B3EF155FC34() {
  self._id_EA3E3B2121E6713A = self.event._id_EA3E3B2121E6713A;
  self._id_C5E7FCE963586EC0 = [[level._id_8ECA0B5093624BAD._id_309BEA83DDCFD6BE[self.event._id_AA3B0E88545B7496]]](self.event);
  _id_6153E980B3EB0E1B::_id_8B680B3EF155FC34();
}

_id_354EBFF91B3C29CA() {
  if(getdvarint("ai_allowdormancy", 0) == 1 && _id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    foreach(_id_B205D90302DA2F07 in level._id_B205D90302DA2F07) {
      if(isDefined(_id_B205D90302DA2F07["subAreas"])) {
        foreach(_id_D1CF55B36FACF5A8 in _id_B205D90302DA2F07["subAreas"]) {
          if(isDefined(_id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA)) {
            foreach(agent in _id_D1CF55B36FACF5A8._id_3EBB6024E3F220CA) {
              if(!isDefined(agent)) {
                continue;
              }
              if(isagent(agent)) {
                agent _id_48814951E916AF89::_id_28B90EB2B591003F();
                continue;
              }

              if(isint(agent))
                _id_371B4C2AB5861E62::_id_4E065F1747AADD51(agent);
            }
          }
        }
      }
    }
  } else {
    foreach(agent in level.agentarray) {
      if(isalive(agent) && !istrue(agent.invulnerable))
        agent kill();
    }
  }
}

_id_3140165E8671CD37() {
  foreach(agent in level.agentarray) {
    if(isalive(agent))
      agent despawnagent();
  }
}