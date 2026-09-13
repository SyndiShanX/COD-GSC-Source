/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6d337a1fd1d54c5f.gsc
***********************************************/

_id_9C85640063AA1A62() {
  if(getdvarint("dvar_6E8E023EC4104C6B", 1) == 0) {
    return;
  }
  level._id_FA3DD562A7CACA8B = spawnStruct();
  level._id_FA3DD562A7CACA8B._id_5C0DB4AE53D9C085 = [];
  level._id_FA3DD562A7CACA8B._id_045456A8F2F811B1 = [];
  level._id_FA3DD562A7CACA8B.squads = [];
  level._id_FA3DD562A7CACA8B._id_9DD6B3D4501D8C85 = 36000000;
  level._id_FA3DD562A7CACA8B._id_929D174CEFDC4349 = getdvarint("dvar_5A55C9E713F5A065", 4);
  level._id_FA3DD562A7CACA8B._id_5D9ED7EB019F5547 = getdvarint("dvar_EA5CA0AFEAB8E384", 3);
  level._id_FA3DD562A7CACA8B._id_5F8899C94CC60197 = getdvarint("dvar_8DFDC1BD2A887AC2", 6);
  level._id_FA3DD562A7CACA8B._id_2D6A23DB056A0EC0 = getdvarint("dvar_CB63F8CB9E4E1DEF", 300) * 1000;
  level._id_FA3DD562A7CACA8B._id_85324A1062E736BA = getdvarint("dvar_B5D7E9E85AB3C104", 3);
  level._id_FA3DD562A7CACA8B._id_22D3A45413CEA3AC = getdvarint("dvar_2B11B9ACA19CE8CB", 500);
  level._id_FA3DD562A7CACA8B._id_55A75BA6640B59F4 = getdvarint("dvar_21134403816F9C13", 3000);
  level._id_FA3DD562A7CACA8B._id_09FE72F3581FC4D1 = getdvarint("dvar_AF4FFD6EF7FF488C", 8000);
  level waittill("matchStartTimer_done");
  level thread _id_C346D1C9AC9F157B();
}

_id_C346D1C9AC9F157B() {
  level endon("game_ended");

  for(;;) {
    foreach(_id_FABF84450735DD93, team in level.teamdata) {
      if(team["players"].size >= level._id_FA3DD562A7CACA8B._id_85324A1062E736BA) {
        if(!scripts\engine\utility::array_contains(level._id_FA3DD562A7CACA8B._id_5C0DB4AE53D9C085, _id_FABF84450735DD93))
          level._id_FA3DD562A7CACA8B._id_5C0DB4AE53D9C085[level._id_FA3DD562A7CACA8B._id_5C0DB4AE53D9C085.size] = _id_FABF84450735DD93;

        continue;
      }

      if(scripts\engine\utility::array_contains(level._id_FA3DD562A7CACA8B._id_5C0DB4AE53D9C085, _id_FABF84450735DD93))
        level._id_FA3DD562A7CACA8B._id_5C0DB4AE53D9C085 = scripts\engine\utility::array_remove(level._id_FA3DD562A7CACA8B._id_5C0DB4AE53D9C085, _id_FABF84450735DD93);
    }

    foreach(_id_FABF84450735DD93 in level._id_FA3DD562A7CACA8B._id_5C0DB4AE53D9C085) {
      _id_E4736E9E5D3B8721 = 0;

      foreach(player in level.teamdata[_id_FABF84450735DD93]["players"]) {
        _id_E5AEB68208944793 = _id_42DB00FECB0FA74D::_id_F59BB0593A8F98A9(player);
        _id_E4736E9E5D3B8721 = _id_E4736E9E5D3B8721 + _id_E5AEB68208944793;
      }

      _id_5B7BB441A2C90A7E = _id_E4736E9E5D3B8721 / level.teamdata[_id_FABF84450735DD93]["players"].size;

      if(_id_5B7BB441A2C90A7E > level._id_FA3DD562A7CACA8B._id_929D174CEFDC4349 && !scripts\engine\utility::array_contains(level._id_FA3DD562A7CACA8B._id_045456A8F2F811B1, _id_FABF84450735DD93))
        level._id_FA3DD562A7CACA8B._id_045456A8F2F811B1[level._id_FA3DD562A7CACA8B._id_045456A8F2F811B1.size] = _id_FABF84450735DD93;
    }

    foreach(_id_FABF84450735DD93 in level._id_FA3DD562A7CACA8B._id_045456A8F2F811B1) {
      if(!isDefined(level._id_FA3DD562A7CACA8B.squads[_id_FABF84450735DD93]) || isDefined(level._id_FA3DD562A7CACA8B.squads[_id_FABF84450735DD93]) && level._id_FA3DD562A7CACA8B.squads[_id_FABF84450735DD93].agents.size == 0 && level._id_FA3DD562A7CACA8B.squads[_id_FABF84450735DD93]._id_51DE3B8D2B8E9B2B + level._id_FA3DD562A7CACA8B._id_2D6A23DB056A0EC0 < gettime()) {
        [agents, targetplayer] = _id_5CE5C9510BD3966F(_id_FABF84450735DD93);

        if(isDefined(agents) && agents.size > 0) {
          _id_36AAB17D28116D3F = spawnStruct();
          _id_36AAB17D28116D3F.agents = agents;
          _id_36AAB17D28116D3F.lastspawntime = gettime();
          _id_36AAB17D28116D3F._id_51DE3B8D2B8E9B2B = undefined;
          _id_36AAB17D28116D3F.targetplayer = targetplayer;
          _id_36AAB17D28116D3F._id_6D915EF0D70DA0F8 = _id_FABF84450735DD93;
          _id_36AAB17D28116D3F._id_A2AF1CBF7D514616 = gettime() + getdvarint("dvar_8F091E5825453D52", 300) * 1000;
          _id_36AAB17D28116D3F._id_28384072AF6B86C7 = 0;
          _id_B8EBE3F71A08AB40 = spawnStruct();
          _id_B8EBE3F71A08AB40._id_7EF0FA7A21303CCC = 0;
          _id_B8EBE3F71A08AB40.targetteam = _id_FABF84450735DD93;
          _id_36AAB17D28116D3F._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
          level._id_FA3DD562A7CACA8B.squads[_id_FABF84450735DD93] = _id_36AAB17D28116D3F;
          level thread _id_E5EB00BFF9A93501(_id_36AAB17D28116D3F);
          level thread _id_DD936EBCE491512C(_id_36AAB17D28116D3F);
          _id_747765FE20E9955F(_id_36AAB17D28116D3F);
          level thread _id_5A859E557F811744(_id_36AAB17D28116D3F);
        }
      }
    }

    foreach(_id_FABF84450735DD93, _id_36AAB17D28116D3F in level._id_FA3DD562A7CACA8B.squads) {
      if(_id_36AAB17D28116D3F.agents.size == 0)
        level._id_FA3DD562A7CACA8B._id_045456A8F2F811B1 = scripts\engine\utility::array_remove(level._id_FA3DD562A7CACA8B._id_045456A8F2F811B1, _id_FABF84450735DD93);
    }

    wait 5;
  }
}

_id_5A859E557F811744(_id_36AAB17D28116D3F) {
  level endon("game_ended");
  _id_868F59CA4D8832A1 = 1;

  while(_id_868F59CA4D8832A1) {
    if(istrue(_id_36AAB17D28116D3F._id_28384072AF6B86C7)) {
      return;
    }
    if(gettime() >= _id_36AAB17D28116D3F._id_A2AF1CBF7D514616) {
      break;
    }

    wait 1;
  }

  _id_DC92E2D675B5C228(_id_36AAB17D28116D3F);
}

_id_DD936EBCE491512C(_id_36AAB17D28116D3F) {
  foreach(agent in _id_36AAB17D28116D3F.agents)
  level thread _id_14F434EEEA1EA747(agent, _id_36AAB17D28116D3F);
}

_id_AFB28615A07DE8BE(_id_36AAB17D28116D3F) {
  level endon("game_ended");
  _id_92D22DD457ED9C95 = 1;

  while(_id_92D22DD457ED9C95) {
    if(istrue(_id_36AAB17D28116D3F._id_28384072AF6B86C7)) {
      return;
    }
    players = level.teamdata[_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8]["players"];
    _id_92D22DD457ED9C95 = 0;

    foreach(player in players) {
      if(isalive(player)) {
        _id_92D22DD457ED9C95 = 1;
        break;
      }
    }

    waitframe();
  }

  _id_DC92E2D675B5C228(_id_36AAB17D28116D3F);
}

_id_DC92E2D675B5C228(_id_36AAB17D28116D3F) {
  _id_36AAB17D28116D3F._id_28384072AF6B86C7 = 1;
  _id_36AAB17D28116D3F._id_51DE3B8D2B8E9B2B = gettime();
  players = level.teamdata[_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8]["players"];

  if(_id_36AAB17D28116D3F.agents.size > 0)
    level thread _id_2678F4F9C8F29E17(_id_36AAB17D28116D3F);

  foreach(player in players) {
    player.aq_targethudenabled = 0;
    player setclientomnvar("ui_br_assassination_target", 0);
  }

  _id_36AAB17D28116D3F._id_B8EBE3F71A08AB40._id_7EF0FA7A21303CCC = 1;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_hunt_target_survived", players);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8, "dmz_activity_win", 1.0);
}

_id_14F434EEEA1EA747(agent, _id_36AAB17D28116D3F) {
  agent waittill("death");
  _id_36AAB17D28116D3F.agents = scripts\engine\utility::array_remove(_id_36AAB17D28116D3F.agents, agent);

  if(_id_36AAB17D28116D3F.agents.size == 0)
    _id_DC92E2D675B5C228(_id_36AAB17D28116D3F);
}

_id_5CE5C9510BD3966F(_id_C7A173D080D099EE) {
  _id_9B71757C091FF3A8 = _id_D1F2FAC85D1D53EC(_id_C7A173D080D099EE);
  _id_246027A1B24DD32F = ["ar", "sniper", "lmg", "sniper", "sniper", "lmg", "ar", "lmg"];
  _id_CF627BF100B5BAFC = [];

  foreach(_id_083C3368707C68E6 in _id_246027A1B24DD32F)
  _id_CF627BF100B5BAFC[_id_CF627BF100B5BAFC.size] = _id_48814951E916AF89::_id_DE59D7CB310C1AFF(_id_083C3368707C68E6, 3);

  _id_EC862C2C00C7AB5D = _id_48814951E916AF89::_id_B9D78FCE07834C95(_id_CF627BF100B5BAFC);
  team = level._id_4B195D3DD0024B9C;
  agents = _id_48814951E916AF89::_id_2F3B04FC531B4115(level._id_FA3DD562A7CACA8B._id_5F8899C94CC60197, _id_9B71757C091FF3A8.origin, "absolute", "huntSquad", undefined, undefined, team, undefined, undefined, "closet", undefined, undefined, _id_EC862C2C00C7AB5D);

  if(!isDefined(agents) || agents.size == 0)
    agents = _id_48814951E916AF89::_id_2F3B04FC531B4115(level._id_FA3DD562A7CACA8B._id_5F8899C94CC60197, _id_9B71757C091FF3A8.origin, "absolute", "huntSquad", undefined, undefined, team, undefined, undefined, "heli", undefined, undefined, _id_EC862C2C00C7AB5D);

  if(!isDefined(agents) || agents.size == 0)
    return [];

  foreach(agent in agents) {
    if(isDefined(agent) && !isint(agent) && isalive(agent)) {
      agent thread _id_B0F37206E615F8B1(agent);
      _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(agent, "hSquad_overrideAgent", ::_id_B0F37206E615F8B1);
    }
  }

  return [agents, _id_9B71757C091FF3A8];
}

_id_D1F2FAC85D1D53EC(_id_C7A173D080D099EE, playerlist) {
  _id_9B71757C091FF3A8 = undefined;
  _id_938BC262B777579B = 0;

  if(isDefined(playerlist))
    _id_23C073F7E25A2123 = playerlist;
  else {
    if(!isDefined(_id_C7A173D080D099EE)) {
      return;
    }
    _id_23C073F7E25A2123 = level.teamdata[_id_C7A173D080D099EE]["players"];
  }

  foreach(player in _id_23C073F7E25A2123) {
    if(!isDefined(_id_9B71757C091FF3A8) || player.kills > _id_938BC262B777579B) {
      _id_9B71757C091FF3A8 = player;
      _id_938BC262B777579B = player.kills;
    }
  }

  return _id_9B71757C091FF3A8;
}

_id_937F3ECE2A4CC754(_id_C7A173D080D099EE, origin) {
  _id_23C073F7E25A2123 = level.teamdata[_id_C7A173D080D099EE]["players"];
  _id_0A427DED21077317 = [];

  foreach(player in _id_23C073F7E25A2123) {
    distsq = distancesquared(player.origin, origin);

    if(level._id_FA3DD562A7CACA8B._id_9DD6B3D4501D8C85 > distsq)
      _id_0A427DED21077317[_id_0A427DED21077317.size] = player;
  }

  return _id_0A427DED21077317;
}

_id_58DAEFFDA334806B(agents) {
  _id_FFE7A776396F984D = [];

  foreach(agent in agents) {
    if(isalive(agent))
      _id_FFE7A776396F984D[_id_FFE7A776396F984D.size] = agent.origin;
  }

  if(_id_FFE7A776396F984D.size == 0) {
    return;
  }
  return averagepoint(_id_FFE7A776396F984D);
}

_id_E5EB00BFF9A93501(_id_36AAB17D28116D3F) {
  _id_CB791416725E9BC6 = 1;
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8, "dmz_activity_tension", 1.0);
  players = level.teamdata[_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8]["players"];

  foreach(player in players) {
    _id_371B4C2AB5861E62::_id_AB491B16F8423C8E(player, "hs", 0);
    group = _id_371B4C2AB5861E62::_id_ED5140C225D4F337(player);
    _id_371B4C2AB5861E62::_id_CA2ADCE5C7865C20(player, group);
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_hunt_assigned_others", [player]);
    _id_BCC9E506D1DBAD57(player, _id_36AAB17D28116D3F);
    player._id_783A508C7B030E91 = 1;
  }

  for(;;) {
    if(istrue(_id_36AAB17D28116D3F._id_28384072AF6B86C7)) {
      return;
    }
    _id_3E75268D56D4F616 = 0;

    foreach(agent in _id_36AAB17D28116D3F.agents) {
      if(isDefined(agent.vehicle)) {
        _id_3E75268D56D4F616 = 1;
        break;
      }
    }

    if(!_id_3E75268D56D4F616) {
      break;
    }

    wait 1;
  }

  level thread _id_AFB28615A07DE8BE(_id_36AAB17D28116D3F);

  while(_id_CB791416725E9BC6) {
    if(istrue(_id_36AAB17D28116D3F._id_28384072AF6B86C7)) {
      return;
    }
    players = level.teamdata[_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8]["players"];

    foreach(player in players) {
      if(isDefined(player) && isalive(player) && istrue(player._id_783A508C7B030E91)) {
        continue;
      }
      _id_371B4C2AB5861E62::_id_AB491B16F8423C8E(player, "hs", 0);
      group = _id_371B4C2AB5861E62::_id_ED5140C225D4F337(player);
      _id_371B4C2AB5861E62::_id_CA2ADCE5C7865C20(player, group);
      player._id_783A508C7B030E91 = 1;
    }

    _id_E209E757754B853F = _id_58DAEFFDA334806B(_id_36AAB17D28116D3F.agents);
    _id_0A427DED21077317 = _id_937F3ECE2A4CC754(_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8, _id_E209E757754B853F);

    if(!isDefined(_id_0A427DED21077317) || _id_0A427DED21077317.size == 0) {
      _id_DC92E2D675B5C228(_id_36AAB17D28116D3F);
      _id_CB791416725E9BC6 = 0;
      continue;
    }

    _id_36AAB17D28116D3F.targetplayer = _id_D1F2FAC85D1D53EC(_id_36AAB17D28116D3F._id_C7A173D080D099EE, _id_0A427DED21077317);

    foreach(agent in _id_36AAB17D28116D3F.agents) {
      if(isDefined(agent.vehicle)) {
        continue;
      }
      _id_9EE0DDD0A3A34811 = distancesquared(agent.origin, _id_36AAB17D28116D3F.targetplayer.origin);

      if(_id_9EE0DDD0A3A34811 < level._id_FA3DD562A7CACA8B._id_9DD6B3D4501D8C85) {
        _id_A3C64CEF39877A97 = _id_700CF5F1CD29A9DC(agent.agent_type);
        agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, _id_36AAB17D28116D3F.targetplayer.origin, _id_A3C64CEF39877A97, _id_A3C64CEF39877A97, 32, 1);
        continue;
      }

      agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, _id_E209E757754B853F, 32, 32, 32, 1);
    }

    wait 10;
  }
}

_id_2678F4F9C8F29E17(_id_36AAB17D28116D3F) {
  _id_E209E757754B853F = _id_58DAEFFDA334806B(_id_36AAB17D28116D3F.agents);
  _id_276AC5E84835EA87 = _id_48814951E916AF89::_id_9C5A68CA1385322E(_id_E209E757754B853F, undefined, undefined, 8000, undefined, 1, 1);

  foreach(agent in _id_36AAB17D28116D3F.agents) {
    origin = undefined;

    if(isDefined(_id_276AC5E84835EA87)) {
      origin = scripts\engine\utility::random(_id_276AC5E84835EA87._id_52914617670842A1).origin;
      agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, origin, 32, 32, 32, 1);
    }

    agent thread _id_969BE422C531295A(agent, origin);
  }
}

_id_969BE422C531295A(agent, origin) {
  agent endon("death");
  distsq = 225000000;

  if(isDefined(origin))
    distsq = distancesquared(agent.origin, origin);

  _id_822DB80CE3C87A54 = 16384;
  _id_3B5803E733581858 = 0;
  interval = 5;

  while(distsq > _id_822DB80CE3C87A54) {
    if(isDefined(origin))
      agent thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, origin, 32, 32, 32, 1);

    wait(interval);
    players = getentarrayinradius("player", "classname", agent.origin, 2056);

    if(isDefined(players) && players.size == 0) {
      break;
    }

    if(isDefined(origin))
      distsq = distancesquared(agent.origin, origin);
  }

  agent.nocorpse = 1;
  agent.noloot = 1;
  agent._id_AD799295A6692B29 = 1;
  agent.dropweapon = 0;
  agent kill();
}

_id_700CF5F1CD29A9DC(aitype) {
  if(!isDefined(aitype)) {
    return;
  }
  if(issubstr(aitype, "_ar"))
    return 256;
  else if(issubstr(aitype, "_lmg") || issubstr(aitype, "_sniper"))
    return 768;
  else if(issubstr(aitype, "_smg") || issubstr(aitype, "_shotgun"))
    return 128;
  else if(issubstr(aitype, "_rpg"))
    return 512;
}

_id_F35A110D69D42DC9(team) {
  if(isDefined(level._id_FA3DD562A7CACA8B) && isDefined(level._id_FA3DD562A7CACA8B.squads)) {
    foreach(struct in level._id_FA3DD562A7CACA8B.squads) {
      if(isDefined(struct.targetteam) && team == struct.targetteam && !istrue(struct._id_28384072AF6B86C7))
        return 1;
    }
  }

  return 0;
}

_id_037B884B4DF5B873() {
  wait 5;
  player = level.players[0];
  _id_371B4C2AB5861E62::_id_AB491B16F8423C8E(player, "hs", 0);
  group = _id_371B4C2AB5861E62::_id_ED5140C225D4F337(player);
  _id_371B4C2AB5861E62::_id_CA2ADCE5C7865C20(player, group);
  level thread _id_5CE5C9510BD3966F(player.team);
}

_id_17FA0B0F3FCED1C5(agent) {
  agent endon("death");

  for(;;) {
    if(!isint(agent) && isalive(agent)) {}

    waitframe();
  }
}

_id_B0F37206E615F8B1(agent) {
  agent thread _id_371B4C2AB5861E62::_id_9CA698CDFFE22968(agent, 1);
  wait 1;
  helmet = level._id_6855C201495094B6["tier3"];
  agent _meth_CBC1621BBD0BB42D(1);
  _id_371B4C2AB5861E62::_id_58203C3739D2D0C6(agent, "huntSquad");
  agent._id_B582B10663B5B2A9 = 0;

  if(scripts\engine\utility::cointoss()) {
    body = "body_mp_koenig_iw9_7_1";
    head = "head_mp_koenig_iw9_7_1";
  } else {
    body = "body_mp_stiletto_iw9_8_1";
    head = "head_mp_stiletto_iw9_8_1";
  }

  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, head, undefined, undefined, undefined, level._id_FA3DD562A7CACA8B._id_22D3A45413CEA3AC, helmet, 1);
  agent.baseaccuracy = getdvarfloat("dvar_C7631AD6F642733B", 2.2);
  agent._id_CBD87A0BC497B778 = 1;
  agent._id_8E3405AC46C40E0F = 1;
  agent._id_D5E499E7FE2C490B = 1;
  agent._id_1544C20E168D97C0 = 12000;
  agent._id_98ADD129A7ECB962 = 1;
  agent.forcelongdeath = 1;
  agent setengagementmindist(1024, 256);
  agent setengagementmaxdist(6000, 9000);
  agent _meth_9215CE6FC83759B9(4500);
  agent thread _id_17FA0B0F3FCED1C5(agent);
}

_id_747765FE20E9955F(_id_36AAB17D28116D3F) {
  players = level.teamdata[_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8]["players"];
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_hunt_assigned_others", players);

  foreach(player in players)
  _id_BCC9E506D1DBAD57(player, _id_36AAB17D28116D3F);
}

_id_BCC9E506D1DBAD57(player, _id_36AAB17D28116D3F) {
  player setclientomnvar("ui_br_assassination_target_timer", _id_36AAB17D28116D3F._id_A2AF1CBF7D514616);
  player.aq_targethudenabled = 1;
  player thread _id_602D8934E5324A2D(_id_36AAB17D28116D3F);
}

_id_602D8934E5324A2D(_id_36AAB17D28116D3F) {
  for(;;) {
    if(istrue(_id_36AAB17D28116D3F._id_28384072AF6B86C7)) {
      return;
    }
    players = level.teamdata[_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8]["players"];

    if(!isDefined(_id_36AAB17D28116D3F._id_DED4510767B9FBA9))
      _id_36AAB17D28116D3F._id_DED4510767B9FBA9 = [];

    threatlevel = undefined;

    if(!isDefined(_id_36AAB17D28116D3F.targetplayer)) {
      _id_E209E757754B853F = _id_58DAEFFDA334806B(_id_36AAB17D28116D3F.agents);
      _id_0A427DED21077317 = _id_937F3ECE2A4CC754(_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8, _id_E209E757754B853F);
      _id_36AAB17D28116D3F.targetplayer = _id_D1F2FAC85D1D53EC(_id_36AAB17D28116D3F._id_C7A173D080D099EE, _id_0A427DED21077317);
    }

    dist = distance(_id_36AAB17D28116D3F.targetplayer.origin, _id_58DAEFFDA334806B(_id_36AAB17D28116D3F.agents));
    threatlevel = 0;

    if(dist > level._id_FA3DD562A7CACA8B._id_09FE72F3581FC4D1)
      threatlevel = 0;
    else if(dist > level._id_FA3DD562A7CACA8B._id_55A75BA6640B59F4) {
      threatlevel = 1;
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_36AAB17D28116D3F._id_6D915EF0D70DA0F8, "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
    } else
      threatlevel = 2;

    foreach(player in players) {
      playerid = player scripts\mp\utility\player::getuniqueid();

      if(!isDefined(_id_36AAB17D28116D3F._id_DED4510767B9FBA9[playerid]))
        _id_36AAB17D28116D3F._id_DED4510767B9FBA9[playerid] = 0;

      if(!isDefined(threatlevel))
        threatlevel = _id_36AAB17D28116D3F._id_DED4510767B9FBA9[playerid];

      _id_36AAB17D28116D3F._id_DED4510767B9FBA9[playerid] = threatlevel;
      player _id_64ACB6CE534155B7::_id_19582BA0DBCC0AB0(player, threatlevel);
    }

    wait 2;
  }
}