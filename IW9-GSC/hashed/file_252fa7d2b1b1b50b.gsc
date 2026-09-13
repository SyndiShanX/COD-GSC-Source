/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_252fa7d2b1b1b50b.gsc
***********************************************/

_id_FA326688EAFCB0E5() {
  _id_5EFE196C4C230159();
}

_id_A8C998F28B4865B4(_id_7AFBC86F36593308, circle_radius, _id_371CF8C2296A023F) {
  _id_5EFE196C4C230159();
}

_id_5EFE196C4C230159() {
  foreach(category in level._id_93E65C79243EA01A) {
    agents = _func_B4B9401715CF98EA(category);

    foreach(agent in agents) {
      if(isint(agent)) {
        _id_7D2909FDC2B71387 = level._id_879053468F168806[agent];

        if(!_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(_id_7D2909FDC2B71387.origin))
          _id_371B4C2AB5861E62::_id_4E065F1747AADD51(agent, category);

        continue;
      }

      if(isDefined(agent.chute) || isDefined(agent.ridingvehicle)) {
        continue;
      }
      if(isDefined(agent.birthtime) && gettime() < agent.birthtime + 10000) {
        continue;
      }
      if(!_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(agent.origin)) {
        _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "killedByGas", 1);
        agent kill();
      }
    }
  }
}

_id_B146E2B40516B668(category) {
  if(!isDefined(level._id_93E65C79243EA01A)) {
    level._id_93E65C79243EA01A = [];
    _id_2695A20D4011076D::_id_ECA79FA0F341EE08(11, ::_id_A8C998F28B4865B4, ::_id_FA326688EAFCB0E5);
  }

  level._id_93E65C79243EA01A = scripts\engine\utility::_id_6D6AF8144A5131F1(level._id_93E65C79243EA01A, category);
}

_id_091EEDA4F6EA1DAF(category) {
  if(!isDefined(level._id_93E65C79243EA01A)) {
    return;
  }
  level._id_93E65C79243EA01A = scripts\engine\utility::array_remove(level._id_93E65C79243EA01A, category);
}

_id_4E0244F0C1AB5067(location, _id_DD4F509B9C56C76F, _id_461B8C89EB0F0715, params) {
  _id_AAC993A0C1361744 = "everyone";
  _id_49E3C22608848BD6 = undefined;
  _id_6ADBAF8D10937E14 = "high";
  _id_15D6C88336DEBDF4 = 0;
  _id_08FB0AFEC6EE6A75 = 10000;

  if(isDefined(params)) {
    if(isDefined(params._id_AAC993A0C1361744))
      _id_AAC993A0C1361744 = params._id_AAC993A0C1361744;

    if(isDefined(params._id_49E3C22608848BD6))
      _id_49E3C22608848BD6 = params._id_49E3C22608848BD6;

    if(isDefined(params._id_6ADBAF8D10937E14))
      _id_6ADBAF8D10937E14 = params._id_6ADBAF8D10937E14;

    if(isDefined(params._id_15D6C88336DEBDF4))
      _id_15D6C88336DEBDF4 = params._id_15D6C88336DEBDF4;

    if(isDefined(params._id_08FB0AFEC6EE6A75))
      _id_08FB0AFEC6EE6A75 = params._id_08FB0AFEC6EE6A75;
  }

  agents = [];
  _id_2984A3A7B3C051A7 = getclosestpointonnavmesh(location);
  group_name = _id_48814951E916AF89::_id_78759441C259F58A();
  _id_F96E9372BF4D85EB = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_2984A3A7B3C051A7);

  foreach(type in _id_461B8C89EB0F0715) {
    if(issubstr(type, "heli") && istrue(level._id_425DF8E23AAEF18C)) {
      _id_9A5A0701386AC693 = _id_48814951E916AF89::_id_B9D78FCE07834C95(_id_DD4F509B9C56C76F);
      _id_51900AF8E34C7D04 = _id_2BC0B0102F9B7751::_id_03779DEB97B61A65(_id_DD4F509B9C56C76F.size, _id_2984A3A7B3C051A7, _id_6ADBAF8D10937E14, _id_AAC993A0C1361744, _id_49E3C22608848BD6, group_name, "team_hundred_ninety_five", _id_15D6C88336DEBDF4, _id_F96E9372BF4D85EB, 256, 512, _id_9A5A0701386AC693, 1, 0);

      if(isDefined(_id_51900AF8E34C7D04))
        agents = _id_51900AF8E34C7D04;
    } else if(issubstr(type, "para") && isDefined(level._id_E578A787B54AD109)) {
      _id_9A5A0701386AC693 = _id_48814951E916AF89::_id_B9D78FCE07834C95(_id_DD4F509B9C56C76F);
      _id_63F6F0241FC2A71E = _id_640CF1641C03E2A0::_id_55AB9C6DA96226E7(_id_DD4F509B9C56C76F.size, _id_2984A3A7B3C051A7, _id_08FB0AFEC6EE6A75, _id_9A5A0701386AC693, _id_6ADBAF8D10937E14, _id_AAC993A0C1361744, _id_49E3C22608848BD6, "team_hundred_ninety_five", _id_15D6C88336DEBDF4, _id_F96E9372BF4D85EB, undefined, undefined, 1, 1, 1, 256);

      if(isDefined(_id_63F6F0241FC2A71E))
        agents = _id_63F6F0241FC2A71E;
    } else if(issubstr(type, "closet")) {
      _id_9A5A0701386AC693 = _id_48814951E916AF89::_id_B9D78FCE07834C95(_id_DD4F509B9C56C76F);
      _id_586EFC1D3CAF3644 = _id_48814951E916AF89::_id_9EA6EDDB437EACA5(_id_DD4F509B9C56C76F.size, _id_2984A3A7B3C051A7, _id_6ADBAF8D10937E14, _id_AAC993A0C1361744, _id_49E3C22608848BD6, group_name, "team_hundred_ninety_five", _id_15D6C88336DEBDF4, _id_F96E9372BF4D85EB, undefined, undefined, 256);

      if(isDefined(_id_586EFC1D3CAF3644))
        agents = _id_586EFC1D3CAF3644;
    } else if(issubstr(type, "safe"))
      agents = _id_3C4B94287BC8E5F9(_id_2984A3A7B3C051A7, _id_DD4F509B9C56C76F, _id_F96E9372BF4D85EB, group_name, params);
    else {}

    if(agents.size > 0) {
      break;
    }
  }

  if(agents.size <= 0) {}

  return agents;
}

_id_3C4B94287BC8E5F9(location, _id_DD4F509B9C56C76F, _id_F96E9372BF4D85EB, group_name, params) {
  _id_D7AC817D738940DA = [];
  agents = [];
  _id_D7AC817D738940DA = _id_F94BE34470EE3BAD(location, _id_DD4F509B9C56C76F.size, params._id_A78DAF96B4BDF866, params._id_1B20F5FB6AEE28F7, params._id_0CF0B51BA5E529A7);

  if(_id_D7AC817D738940DA.size < _id_DD4F509B9C56C76F.size)
    return agents;

  foreach(index, _id_3170CA906B2241A6 in _id_DD4F509B9C56C76F) {
    _id_4C3337129231E244 = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_3170CA906B2241A6.type, _id_3170CA906B2241A6.tier, _id_3170CA906B2241A6._id_8E5A9B658FA525ED);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_4C3337129231E244, _id_D7AC817D738940DA[index], (0, 0, 0), params._id_6ADBAF8D10937E14, params._id_AAC993A0C1361744, undefined, group_name, "team_hundred_ninety_five", undefined, _id_F96E9372BF4D85EB, 1, 0, 0, undefined, 0);

    if(isDefined(agent)) {
      agents[agents.size] = agent;
      agent thread _id_120270BD0A747A35::_id_9BBF1713A14FA580(agent, 256, 256, location);
    }

    waitframe();
  }

  return agents;
}

_id_F94BE34470EE3BAD(location, spawn_count, _id_2459CCC8942D8B86, _id_139B059F5DDEA817, _id_1EE216DF0796DB1F) {
  _id_D7AC817D738940DA = [];
  _id_48FCD52A851C7579 = squared(_id_2459CCC8942D8B86 - _id_139B059F5DDEA817);

  if(!isDefined(_id_2459CCC8942D8B86))
    _id_2459CCC8942D8B86 = 1500;

  if(!isDefined(_id_139B059F5DDEA817))
    _id_139B059F5DDEA817 = 500;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 15; _id_AC0E594AC96AA3A8++) {
    _id_0AEDD7371F20A2B9 = location + vectorNormalize(scripts\engine\utility::_id_6174330574A2A273()) * _id_2459CCC8942D8B86;
    spawnpoints = getrandomnavpoints(getclosestpointonnavmesh(_id_0AEDD7371F20A2B9), _id_139B059F5DDEA817, _id_1EE216DF0796DB1F);

    foreach(point in spawnpoints) {
      if(abs(point[2] - location[2]) > 60) {
        continue;
      }
      distsq = distance2dsquared(point, location);

      if(distsq >= _id_48FCD52A851C7579 && _id_120270BD0A747A35::_id_5867290FDA7A1AC1(point, 64, 1000, 128))
        _id_D7AC817D738940DA[_id_D7AC817D738940DA.size] = point;

      if(_id_D7AC817D738940DA.size >= spawn_count)
        return _id_D7AC817D738940DA;
    }

    waitframe();
  }

  return _id_D7AC817D738940DA;
}