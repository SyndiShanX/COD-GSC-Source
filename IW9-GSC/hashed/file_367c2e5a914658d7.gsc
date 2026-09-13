/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_367c2e5a914658d7.gsc
***********************************************/

_id_36F209B336E4F71B() {
  logstring("ActiveWarzone - Init");
  _id_48814951E916AF89::_id_BA4022744DCE59F6("activeWarzone");
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(10, ::_id_5684B9A123F38950);
  level thread _watchforcircleclosure();
}

_id_C4B698ED8DD5C33D() {
  agents = _func_7EB04CA16D045775("activeWarzone");

  foreach(agent in agents) {
    if(isalive(agent) && !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(agent.origin)) {
      logstring("ActiveWarzone Kill Active AI in gas at " + agent.origin);
      agent kill();
    }
  }
}

_id_974A505E30D0049C() {
  agents = _func_5508DDEA3A84DF39("activeWarzone");

  foreach(agent in agents) {
    _id_7D2909FDC2B71387 = level._id_879053468F168806[agent];

    if(!_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(_id_7D2909FDC2B71387.origin)) {
      logstring("ActiveWarzone Delete Dormant AI in gas at " + _id_7D2909FDC2B71387.origin);
      _id_DC81911388DFA0D3(agent);
    }
  }
}

_id_5684B9A123F38950(circleorigin, circleradius, _id_5D954F1724092F5A) {
  _id_F85C8A0556EDF077 = circleradius * circleradius;
  agents = _func_B4B9401715CF98EA("activeWarzone");

  foreach(agent in agents) {
    if(isint(agent)) {
      _id_7D2909FDC2B71387 = level._id_879053468F168806[agent];
      _id_457471485336C961 = lengthsquared(_id_7D2909FDC2B71387.origin - circleorigin);

      if(_id_457471485336C961 >= _id_F85C8A0556EDF077) {
        logstring("ActiveWarzone Delete Dormant AI in gas at " + _id_7D2909FDC2B71387.origin + " - gas center " + circleorigin + " r" + circleradius);
        _id_DC81911388DFA0D3(agent);
      }

      continue;
    }

    _id_457471485336C961 = lengthsquared(agent.origin - circleorigin);

    if(_id_457471485336C961 >= _id_F85C8A0556EDF077) {
      logstring("ActiveWarzone Kill Active AI in gas at " + agent.origin + " - gas center " + circleorigin + " r" + circleradius);
      agent kill();
    }
  }
}

_id_A9EAF2243763094D() {
  if(level.mapname == "mp_sealion") {
    return;
  }
  _id_AF9632EFDCFAD62B = 0;
  _id_79E560A0CE3C1F2B = 0;
  _id_F861C48005312253 = 0;
  _id_09A1C1B5C5CB9C1E = 0;
  volumes = _func_F159C10D5CF8F0B4("building_bounds", "script_noteworthy");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < volumes.size; _id_AC0E594AC96AA3A8++) {
    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("pistol", 1);
    agent = _id_8F1B9042D7FDFCDA(aitype, volumes[_id_AC0E594AC96AA3A8], volumes[_id_AC0E594AC96AA3A8].origin, (0, 0, 0));

    if(isint(agent)) {
      _id_AF9632EFDCFAD62B++;
      _id_09A1C1B5C5CB9C1E++;

      if(_id_AF9632EFDCFAD62B % 100 == 0)
        waitframe();

      continue;
    }

    _id_79E560A0CE3C1F2B++;
  }

  logstring("ActiveWarzone - Living World Only Spawns " + _id_09A1C1B5C5CB9C1E + "/" + volumes.size);
  level._id_6DB1FC6674F5C81D = undefined;
  level._id_35A97CEB54818616 = undefined;
  level._id_BA2AA87E33811B32 = undefined;
  waitframe();
  waitframe();
  waitframe();

  foreach(_id_276AC5E84835EA87 in level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1) {
    if(!isDefined(_id_276AC5E84835EA87._id_52914617670842A1) || _id_276AC5E84835EA87._id_52914617670842A1.size == 0) {
      logstring("Skipping unused fortresses for no guard nodes at " + _id_276AC5E84835EA87.origin);
      _id_F861C48005312253++;
      continue;
    }

    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("pistol", 1);
    _id_8C7CD2B569611279 = _id_59D68C7B901FC998(_id_276AC5E84835EA87._id_0C8C070D7375EF1E);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8C7CD2B569611279; _id_AC0E594AC96AA3A8++) {
      _id_C229D93C0BB4F8E8 = _id_276AC5E84835EA87._id_52914617670842A1[randomint(_id_276AC5E84835EA87._id_52914617670842A1.size)];
      agent = _id_1DD6DD044FD43E09(aitype, _id_C229D93C0BB4F8E8.origin, _id_C229D93C0BB4F8E8.angles, _id_276AC5E84835EA87.origin, 120);

      if(isint(agent)) {
        _id_AF9632EFDCFAD62B++;

        if(_id_AF9632EFDCFAD62B % 100 == 0)
          waitframe();

        continue;
      }

      _id_79E560A0CE3C1F2B++;
    }
  }

  logstring("ActiveWarzone - World AI Spawned Dormant " + _id_AF9632EFDCFAD62B);
  logstring("ActiveWarzone - World AI Denied Spawned " + _id_79E560A0CE3C1F2B);
  logstring("ActiveWarzone - Total Unused fortresses " + level._id_F1073FBD45B59A06._id_1D7353058EA3A9F1.size);
  logstring("ActiveWarzone - Unused Fortresses skipped from no Guard Nodes " + _id_F861C48005312253);
}

_id_7B7F58778D9D6990(agent) {
  agent = self;
  agent._id_14C360EBEC241178 = agent.maxsightdistsqrd;
  agent.maxsightdistsqrd = 230400;
  agent.accuracy = 0.4;
  agent _meth_D493E7FE15E5EAF4("star_4");
  agent._id_CF430336D17E3AFE = 1;
}

_id_8F1B9042D7FDFCDA(aitype, volume, spawnorigin, spawnangles) {
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, spawnorigin, spawnangles, "low", "activeWarzone", undefined, undefined, undefined, undefined, undefined, undefined, 0, 1, undefined, 1);

  if(isint(agent)) {
    _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "active", ::_id_7B7F58778D9D6990);
    _id_9632417EC6055A75 = undefined;
    _id_DC8625458EE5ED14 = volume getboundshalfsize();
    _id_978098481752DC72 = min(max(_id_DC8625458EE5ED14[0], _id_DC8625458EE5ED14[1]), 360);
    nodes = getnodesinradius(volume.origin, _id_978098481752DC72, 0, 120, "Cover");

    if(nodes.size > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
        if(ispointinvolume(nodes[_id_AC0E594AC96AA3A8].origin, volume)) {
          _id_9632417EC6055A75 = nodes[_id_AC0E594AC96AA3A8].origin;
          break;
        }
      }
    }

    if(isDefined(_id_9632417EC6055A75)) {
      pathstruct = spawnStruct();
      pathstruct.path = [spawnorigin, _id_9632417EC6055A75];
      pathstruct.claimed = 0;
      pathstruct._id_4437E81F60B6B5A0 = 1;
      _id_120270BD0A747A35::_id_4561FE6BFC76F8EC(agent, [agent], pathstruct, volume.origin, _id_978098481752DC72);
    } else
      _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, volume.origin, 120, 0);
  }

  return agent;
}

_id_1DD6DD044FD43E09(aitype, spawnorigin, spawnangles, _id_0E9E8FCA7D95D12A, _id_978098481752DC72) {
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, spawnorigin, spawnangles, "low", "activeWarzone", undefined, undefined, undefined, undefined, undefined, undefined, 0, 1, undefined, 1);

  if(isint(agent)) {
    _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "active", ::_id_7B7F58778D9D6990);
    _id_9632417EC6055A75 = undefined;
    _id_58194B37523ADC95 = (_id_0E9E8FCA7D95D12A[0], _id_0E9E8FCA7D95D12A[1], spawnorigin[2]);
    nodes = getnodesinradius(_id_58194B37523ADC95, _id_978098481752DC72, 0, 60, "Cover");

    if(nodes.size > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
        if(distance2dsquared(spawnorigin, nodes[_id_AC0E594AC96AA3A8].origin) >= 9216) {
          _id_9632417EC6055A75 = nodes[_id_AC0E594AC96AA3A8].origin;
          break;
        }
      }
    }

    if(!isDefined(_id_9632417EC6055A75)) {
      if(distance2dsquared(spawnorigin, _id_58194B37523ADC95) >= 9216)
        _id_9632417EC6055A75 = _id_58194B37523ADC95;
    }

    if(isDefined(_id_9632417EC6055A75)) {
      pathstruct = spawnStruct();
      pathstruct.path = [spawnorigin, _id_9632417EC6055A75];
      pathstruct.claimed = 0;
      pathstruct._id_4437E81F60B6B5A0 = 1;
      _id_120270BD0A747A35::_id_4561FE6BFC76F8EC(agent, [agent], pathstruct, _id_58194B37523ADC95, _id_978098481752DC72);
    } else {
      _id_58194B37523ADC95 = (_id_0E9E8FCA7D95D12A[0], _id_0E9E8FCA7D95D12A[1], spawnorigin[2]);
      _id_120270BD0A747A35::_id_E786AA52B93833EB(agent, _id_58194B37523ADC95, 120, 0);
    }
  }

  return agent;
}

_id_276D8F79560A28F8() {
  level endon("game_ended");
  level waittill("infils_ready");
  _id_F501D4E6074A9D91 = getdvarint("dvar_1F417CB6ADC43C30", 240);
  wait(_id_F501D4E6074A9D91);
  logstring("ActiveWarzone - Updating AI weapons at " + _id_F501D4E6074A9D91 + " seconds");
  _id_A3E821EB4249F933();
}

_watchforcircleclosure() {
  level endon("game_ended");
  _id_DFF50030F50C58EA = getdvarint("dvar_4DC5C5741B807BAE", 5);

  if(_id_DFF50030F50C58EA) {
    for(;;) {
      level waittill("br_circle_set");
      circleindex = level.br_circle.circleindex + 1;

      if(circleindex >= _id_DFF50030F50C58EA) {
        _id_A92FF5CDCED1873E();
        return;
      }
    }
  }
}

_id_DC81911388DFA0D3(id) {
  _id_371B4C2AB5861E62::_id_4E065F1747AADD51(id, "activeWarzone");
}

_id_A92FF5CDCED1873E() {
  logstring("ActiveWarzone - Deleting All " + level._id_879053468F168806.size + " dormant AI");
  _id_AF9632EFDCFAD62B = _func_5508DDEA3A84DF39("activeWarzone");

  foreach(id in _id_AF9632EFDCFAD62B) {
    logstring("ActiveWarzone - Deleting dormant id #" + id);
    _id_DC81911388DFA0D3(id);
  }
}

_id_A3E821EB4249F933() {
  _id_AF9632EFDCFAD62B = _func_5508DDEA3A84DF39("activeWarzone");
  logstring("ActiveWarzone - Upgrading " + _id_AF9632EFDCFAD62B.size + " dormant AI");

  foreach(id in _id_AF9632EFDCFAD62B) {
    if(isDefined(level._id_879053468F168806[id])) {
      if(randomint(5) == 0)
        aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("shotgun", 1);
      else
        aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("smg", 1);

      logstring("ActiveWarzone - Upgrading dormant id #" + id + " to " + aitype);
      level._id_879053468F168806[id].aitype = aitype;
      continue;
    }

    logstring("ActiveWarzone - Cant Find Dormant AI " + id + " - This should never happen");
  }
}

_id_59D68C7B901FC998(_id_0C8C070D7375EF1E) {
  if(_id_0C8C070D7375EF1E == "large" || _id_0C8C070D7375EF1E == "hero")
    return getdvarint("dvar_3A990161316EF42C", 2);
  else if(_id_0C8C070D7375EF1E == "medium")
    return getdvarint("dvar_264C33CE5715AA10", 1);

  return getdvarint("dvar_D4B060E8DA9B92C0", 1);
}