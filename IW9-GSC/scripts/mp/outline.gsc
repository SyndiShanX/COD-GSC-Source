/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\outline.gsc
***********************************************/

init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::outlineonplayerdisconnect);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::outlineonplayerjoinedteam);
  _id_2342B8AAD723994E::registeronplayerjoinsquadcallback(::outlineonplayerjoinedsquad);
  level thread outlineidswatchpending();
}

outlineenableinternal(_id_F20913FEC7561C5F, playersvisibleto, hudoutlineassetname, prioritygroup, type, _id_00FA3B23D51C2DC7, squadindex) {
  if(!isDefined(_id_F20913FEC7561C5F.outlines))
    _id_F20913FEC7561C5F.outlines = [];

  _id_E1CECB04682E8442 = spawnStruct();
  _id_E1CECB04682E8442.isdisabled = 0;
  _id_E1CECB04682E8442.priority = outlineprioritygroupmap(prioritygroup);
  _id_E1CECB04682E8442.playersvisibleto = playersvisibleto;
  _id_E1CECB04682E8442.playersvisibletopending = [];
  _id_E1CECB04682E8442.hudoutlineassetname = hudoutlineassetname;
  _id_E1CECB04682E8442.type = type;
  _id_E1CECB04682E8442.team = _id_00FA3B23D51C2DC7;
  _id_E1CECB04682E8442._id_0FF97225579DE16A = squadindex;
  id = outlinegenerateuniqueid();
  _id_F20913FEC7561C5F.outlines[id] = _id_E1CECB04682E8442;
  outlineaddtogloballist(_id_F20913FEC7561C5F);
  _id_CDA6602A02C53BA3 = [];

  foreach(player in _id_E1CECB04682E8442.playersvisibleto) {
    if(!canoutlineforplayer(player)) {
      _id_E1CECB04682E8442.playersvisibletopending[_id_E1CECB04682E8442.playersvisibletopending.size] = player;
      level.outlineidspending[id] = _id_F20913FEC7561C5F;
      continue;
    }

    _id_25A840A406E8542A = outlinegethighestinfoforplayer(_id_F20913FEC7561C5F, player);

    if(!isDefined(_id_25A840A406E8542A) || _id_25A840A406E8542A == _id_E1CECB04682E8442 || _id_25A840A406E8542A.priority == _id_E1CECB04682E8442.priority)
      _id_CDA6602A02C53BA3[_id_CDA6602A02C53BA3.size] = player;
  }

  if(_id_CDA6602A02C53BA3.size > 0) {
    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      _id_F20913FEC7561C5F _id_03430D5003D0CC9F(_id_CDA6602A02C53BA3, prioritygroup);
    else
      _id_F20913FEC7561C5F _hudoutlineenableforclients(_id_CDA6602A02C53BA3, _id_E1CECB04682E8442.hudoutlineassetname);
  }

  return id;
}

outlinedisableinternal(id, _id_420A996E67989DC4) {
  if(!isDefined(_id_420A996E67989DC4)) {
    level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);
    return;
  } else if(!isDefined(_id_420A996E67989DC4.outlines)) {
    outlineremovefromgloballist(_id_420A996E67989DC4);
    return;
  }

  _id_77C349ECEF6FB0D9 = _id_420A996E67989DC4.outlines[id];

  if(!isDefined(_id_77C349ECEF6FB0D9) || _id_77C349ECEF6FB0D9.isdisabled) {
    return;
  }
  _id_77C349ECEF6FB0D9.isdisabled = 1;

  foreach(player in _id_77C349ECEF6FB0D9.playersvisibleto) {
    if(!isDefined(player)) {
      continue;
    }
    if(!canoutlineforplayer(player)) {
      _id_77C349ECEF6FB0D9.playersvisibletopending[_id_77C349ECEF6FB0D9.playersvisibletopending.size] = player;
      level.outlineidspending[id] = _id_420A996E67989DC4;
      continue;
    }

    _id_25A840A406E8542A = outlinegethighestinfoforplayer(_id_420A996E67989DC4, player);

    if(isDefined(_id_25A840A406E8542A)) {
      if(_id_25A840A406E8542A.priority <= _id_77C349ECEF6FB0D9.priority)
        _id_420A996E67989DC4 _hudoutlineenableforclient(player, _id_25A840A406E8542A.hudoutlineassetname);

      continue;
    }

    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
      _id_420A996E67989DC4 _id_32DFA50C47325ABE(player, "equipment", 1);
      continue;
    }

    _id_420A996E67989DC4 hudoutlinedisableforclient(player);
  }

  if(_id_77C349ECEF6FB0D9.playersvisibletopending.size == 0) {
    _id_420A996E67989DC4.outlines[id] = undefined;

    if(_id_420A996E67989DC4.outlines.size == 0)
      outlineremovefromgloballist(_id_420A996E67989DC4);
  }
}

hudoutline_channels_init() {
  self.hudoutlinechannels = [];
  self._id_2876398BDE7A4CF4 = "outline_depth_white";
  hudoutline_add_channel_internal("default", 0, self._id_2876398BDE7A4CF4);
}

hudoutline_add_channel_internal(channelname, priority, _id_4430B08D5A2D47BF) {
  if(!isDefined(self.hudoutlinechannels))
    hudoutline_channels_init();

  if(_id_BF76E3EACCF13673(self.hudoutlinechannels, channelname) == -1) {
    _id_52BF811C168D0D09 = self.hudoutlinechannels.size;
    index = scripts\engine\utility::ter_op(_id_52BF811C168D0D09 > 0, _id_52BF811C168D0D09, 0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_52BF811C168D0D09; _id_AC0E594AC96AA3A8++) {
      if(self.hudoutlinechannels[_id_AC0E594AC96AA3A8]._id_C060921D335B9210 >= priority) {
        index = _id_AC0E594AC96AA3A8;
        break;
      }
    }

    _id_0B1CDFAE547AD011 = spawnStruct();
    _id_0B1CDFAE547AD011.channelname = channelname;
    _id_0B1CDFAE547AD011._id_C060921D335B9210 = priority;
    _id_0B1CDFAE547AD011._id_4430B08D5A2D47BF = _id_4430B08D5A2D47BF;
    _id_0B1CDFAE547AD011._id_41272A9C461E0853 = [];
    self.hudoutlinechannels = scripts\engine\utility::array_insert(self.hudoutlinechannels, _id_0B1CDFAE547AD011, index);
  }
}

hudoutline_enable_internal(_id_FF3FE241243B175B, channelname, hudoutlineasset) {
  if(!isDefined(channelname))
    channelname = "default";

  if(!isDefined(self.hudoutlinechannels))
    hudoutline_channels_init();

  _id_97A487044B719F14 = _id_BF76E3EACCF13673(self.hudoutlinechannels, channelname);

  if(_id_97A487044B719F14 == -1) {
    if(!isDefined(hudoutlineasset))
      hudoutlineasset = self._id_2876398BDE7A4CF4;

    hudoutline_add_channel_internal(channelname, self.hudoutlinechannels[0]._id_C060921D335B9210 - 1, hudoutlineasset);
    _id_97A487044B719F14 = _id_BF76E3EACCF13673(self.hudoutlinechannels, channelname);
  }

  if(channelname != "default" && isDefined(hudoutlineasset) && self.hudoutlinechannels[_id_97A487044B719F14]._id_4430B08D5A2D47BF != hudoutlineasset && _id_370C25ACB4DA9FE9(channelname, self)) {
    self.hudoutlinechannels[_id_97A487044B719F14]._id_4430B08D5A2D47BF = hudoutlineasset;
    _id_A2D9562A736F54E3(channelname, self, hudoutlineasset);
  }

  if(!isDefined(self.hudoutlinecurchannel))
    hudoutline_activate_channel(channelname, _id_FF3FE241243B175B);

  _id_A948959983E82F10 = self.hudoutlinecurchannel._id_C060921D335B9210;
  _id_C8446D6318008D2C = self.hudoutlinechannels[_id_97A487044B719F14]._id_C060921D335B9210;

  if(!scripts\engine\utility::array_contains(self.hudoutlinechannels[_id_97A487044B719F14]._id_41272A9C461E0853, _id_FF3FE241243B175B))
    self.hudoutlinechannels[_id_97A487044B719F14]._id_41272A9C461E0853 = scripts\engine\utility::array_add(self.hudoutlinechannels[_id_97A487044B719F14]._id_41272A9C461E0853, _id_FF3FE241243B175B);

  if(self.hudoutlinecurchannel.channelname != channelname && _id_A948959983E82F10 < _id_C8446D6318008D2C)
    hudoutline_activate_channel(channelname, _id_FF3FE241243B175B);
  else if(self.hudoutlinecurchannel.channelname == channelname)
    _id_F980012FC1B73AEE(self, channelname, _id_FF3FE241243B175B);
  else if(self.hudoutlinecurchannel.channelname != channelname && _id_A948959983E82F10 > _id_C8446D6318008D2C && !scripts\engine\utility::array_contains(self.hudoutlinecurchannel._id_41272A9C461E0853, _id_FF3FE241243B175B))
    hudoutline_activate_channel(channelname, _id_FF3FE241243B175B);
}

_id_BF76E3EACCF13673(_id_A531B6FFDACF9AB5, channelname) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A531B6FFDACF9AB5.size; _id_AC0E594AC96AA3A8++) {
    if(_id_A531B6FFDACF9AB5[_id_AC0E594AC96AA3A8].channelname == channelname)
      return _id_AC0E594AC96AA3A8;
  }

  return -1;
}

_id_370C25ACB4DA9FE9(channelname, ent) {
  _id_97A487044B719F14 = _id_BF76E3EACCF13673(self.hudoutlinechannels, channelname);

  if(_id_97A487044B719F14 >= 0 && self.hudoutlinechannels[_id_97A487044B719F14]._id_41272A9C461E0853.size > 0)
    return 1;

  return 0;
}

_id_F980012FC1B73AEE(ent, channelname, _id_FF3FE241243B175B) {
  if(!_id_2BD2083AE492439A(ent, _id_FF3FE241243B175B))
    _id_AF1ED457EA26863C(ent, channelname, _id_FF3FE241243B175B);
  else {
    foreach(_id_5214F6C13B097AA8 in self.hudoutlinechannels) {
      _id_97A487044B719F14 = _id_BF76E3EACCF13673(self.hudoutlinechannels, channelname);

      if(_id_97A487044B719F14 >= 0 && _id_5214F6C13B097AA8._id_C060921D335B9210 > self.hudoutlinechannels[_id_97A487044B719F14]._id_C060921D335B9210 && scripts\engine\utility::array_contains(_id_5214F6C13B097AA8._id_41272A9C461E0853, _id_FF3FE241243B175B))
        return;
    }

    _id_AF1ED457EA26863C(ent, channelname, _id_FF3FE241243B175B);
  }
}

_id_2BD2083AE492439A(ent, _id_FF3FE241243B175B) {
  foreach(_id_7148C1A6F25491F8 in ent.hudoutlinechannels) {
    if(scripts\engine\utility::array_contains(_id_7148C1A6F25491F8._id_41272A9C461E0853, _id_FF3FE241243B175B))
      return 1;
  }

  return 0;
}

_id_A2D9562A736F54E3(channelname, ent, hudoutlineasset) {
  _id_97A487044B719F14 = _id_BF76E3EACCF13673(self.hudoutlinechannels, channelname);

  if(_id_97A487044B719F14 >= 0) {
    foreach(_id_FF3FE241243B175B in self.hudoutlinechannels[_id_97A487044B719F14]._id_41272A9C461E0853)
    ent hudoutlineenableforclient(_id_FF3FE241243B175B, hudoutlineasset);
  }
}

_id_AF1ED457EA26863C(ent, channelname, _id_FF3FE241243B175B) {
  _id_97A487044B719F14 = _id_BF76E3EACCF13673(self.hudoutlinechannels, channelname);

  if(_id_97A487044B719F14 >= 0) {
    _id_7148C1A6F25491F8 = self.hudoutlinechannels[_id_97A487044B719F14];
    ent hudoutlineenableforclient(_id_FF3FE241243B175B, _id_7148C1A6F25491F8._id_4430B08D5A2D47BF);

    if(!scripts\engine\utility::array_contains(_id_7148C1A6F25491F8._id_41272A9C461E0853, _id_FF3FE241243B175B))
      self.hudoutlinechannels[_id_97A487044B719F14]._id_41272A9C461E0853 = scripts\engine\utility::array_add(_id_7148C1A6F25491F8._id_41272A9C461E0853, _id_FF3FE241243B175B);
  }
}

hudoutline_activate_channel(channelname, _id_FF3FE241243B175B) {
  if(isDefined(self.hudoutlinecurchannel) && self.hudoutlinecurchannel.channelname != channelname && scripts\engine\utility::array_contains(self.hudoutlinecurchannel._id_41272A9C461E0853, _id_FF3FE241243B175B))
    _id_32DFA50C47325ABE(_id_FF3FE241243B175B, self.hudoutlinecurchannel.channelname, 0);

  self.hudoutlinecurchannel = self.hudoutlinechannels[_id_BF76E3EACCF13673(self.hudoutlinechannels, channelname)];
  _id_F980012FC1B73AEE(self, channelname, _id_FF3FE241243B175B);
}

_id_32DFA50C47325ABE(_id_10AFC5CE5A1FEEBE, channelname, _id_D6EE45FAFD47E3CC) {
  if(!isDefined(_id_D6EE45FAFD47E3CC))
    _id_D6EE45FAFD47E3CC = 0;

  _id_97A487044B719F14 = _id_BF76E3EACCF13673(self.hudoutlinechannels, channelname);
  _id_7148C1A6F25491F8 = self.hudoutlinechannels[_id_97A487044B719F14];

  if(isDefined(_id_7148C1A6F25491F8)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7148C1A6F25491F8._id_41272A9C461E0853.size; _id_AC0E594AC96AA3A8++) {
      if(_id_7148C1A6F25491F8._id_41272A9C461E0853[_id_AC0E594AC96AA3A8] == _id_10AFC5CE5A1FEEBE) {
        self hudoutlinedisableforclient(_id_10AFC5CE5A1FEEBE);

        if(_id_D6EE45FAFD47E3CC)
          self.hudoutlinechannels[_id_97A487044B719F14]._id_41272A9C461E0853 = scripts\engine\utility::array_remove_index(_id_7148C1A6F25491F8._id_41272A9C461E0853, _id_AC0E594AC96AA3A8, 0);

        break;
      }
    }

    for(_id_AC0E594AC96AA3A8 = self.hudoutlinechannels.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
      if(self.hudoutlinechannels[_id_AC0E594AC96AA3A8]._id_C060921D335B9210 > _id_7148C1A6F25491F8._id_C060921D335B9210) {
        continue;
      }
      if(scripts\engine\utility::array_contains(self.hudoutlinechannels[_id_AC0E594AC96AA3A8]._id_41272A9C461E0853, _id_10AFC5CE5A1FEEBE)) {
        hudoutline_activate_channel(self.hudoutlinechannels[_id_AC0E594AC96AA3A8].channelname, _id_10AFC5CE5A1FEEBE);
        break;
      }
    }
  }
}

outlinerefreshinternal(_id_420A996E67989DC4) {
  if(!isDefined(_id_420A996E67989DC4.outlines) || _id_420A996E67989DC4.outlines.size == 0) {
    return;
  }
  foreach(_id_5454630434983DD7, _id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
    if(!isDefined(_id_E1CECB04682E8442) || _id_E1CECB04682E8442.isdisabled) {
      continue;
    }
    foreach(player in _id_E1CECB04682E8442.playersvisibleto) {
      if(!isDefined(player)) {
        continue;
      }
      _id_25A840A406E8542A = outlinegethighestinfoforplayer(_id_420A996E67989DC4, player);

      if(isDefined(_id_25A840A406E8542A))
        _id_420A996E67989DC4 _hudoutlineenableforclient(player, _id_25A840A406E8542A.hudoutlineassetname);
    }
  }
}

outlineonplayerdisconnect(player) {
  outlineremoveplayerfromvisibletoarrays(player);
  outlinedisableinternalall(player);
}

outlineonplayerjoinedteam(player) {
  if(!isDefined(player.team) || player.team == "spectator" || player.team == "codcaster") {
    return;
  }
  thread outlineonplayerjoinedteam_onfirstspawn(player);
}

outlineonplayerjoinedteam_onfirstspawn(player) {
  player notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  player endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  player endon("disconnect");
  player waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(player);
  outlinedisableinternalall(player);
  outlineaddplayertoexistingallandteamoutlines(player);
}

outlineonplayerjoinedsquad(player) {
  thread outlineonplayerjoinedsquad_onfirstspawn(player);
}

outlineonplayerjoinedsquad_onfirstspawn(player) {
  player notify("outlineOnPlayerJoinedSquad_onFirstSpawn");
  player endon("outlineOnPlayerJoinedSquad_onFirstSpawn");
  player endon("disconnect");
  player waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(player, 1);
  outlineaddplayertoexistingsquadoutlines(player);
}

outlineremoveplayerfromvisibletoarrays(player, _id_E1F59B5642DA1702) {
  level.outlineents = scripts\engine\utility::array_removeundefined(level.outlineents);

  foreach(_id_420A996E67989DC4 in level.outlineents) {
    _id_8408CBA753ABA3E3 = 0;

    if(!isDefined(_id_420A996E67989DC4) || !isDefined(_id_420A996E67989DC4.outlines)) {
      continue;
    }
    foreach(_id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
      if(!isDefined(_id_E1CECB04682E8442.playersvisibleto)) {
        continue;
      }
      if(istrue(_id_E1F59B5642DA1702)) {
        if(_id_E1CECB04682E8442.type != "SQUAD")
          continue;
      }

      _id_E1CECB04682E8442.playersvisibleto = scripts\engine\utility::array_removeundefined(_id_E1CECB04682E8442.playersvisibleto);

      if(isDefined(player) && scripts\engine\utility::array_contains(_id_E1CECB04682E8442.playersvisibleto, player)) {
        _id_E1CECB04682E8442.playersvisibleto = scripts\engine\utility::array_remove(_id_E1CECB04682E8442.playersvisibleto, player);
        _id_8408CBA753ABA3E3 = 1;
      }
    }

    if(_id_8408CBA753ABA3E3 && isDefined(_id_420A996E67989DC4) && isDefined(player))
      _id_420A996E67989DC4 hudoutlinedisableforclient(player);
  }
}

outlineaddplayertoexistingallandteamoutlines(player) {
  foreach(_id_420A996E67989DC4 in level.outlineents) {
    if(!isDefined(_id_420A996E67989DC4) || !isDefined(_id_420A996E67989DC4.outlines)) {
      continue;
    }
    _id_25A840A406E8542A = undefined;

    foreach(_id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
      if(_id_E1CECB04682E8442.type == "ALL" || _id_E1CECB04682E8442.type == "TEAM" && _id_E1CECB04682E8442.team == player.team) {
        if(!scripts\engine\utility::array_contains(_id_E1CECB04682E8442.playersvisibleto, player))
          _id_E1CECB04682E8442.playersvisibleto[_id_E1CECB04682E8442.playersvisibleto.size] = player;
        else {}

        if(!isDefined(_id_25A840A406E8542A) || _id_E1CECB04682E8442.priority > _id_25A840A406E8542A.priority)
          _id_25A840A406E8542A = _id_E1CECB04682E8442;
      }
    }

    if(isDefined(_id_25A840A406E8542A))
      _id_420A996E67989DC4 _hudoutlineenableforclient(player, _id_25A840A406E8542A.hudoutlineassetname);
  }
}

outlineaddplayertoexistingsquadoutlines(player) {
  if(!isDefined(player._id_0FF97225579DE16A)) {}

  foreach(_id_420A996E67989DC4 in level.outlineents) {
    if(!isDefined(_id_420A996E67989DC4) || !isDefined(_id_420A996E67989DC4.outlines)) {
      continue;
    }
    _id_25A840A406E8542A = undefined;

    foreach(_id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
      if(_id_E1CECB04682E8442.type == "SQUAD" && _id_E1CECB04682E8442.team == player.team && isDefined(_id_E1CECB04682E8442._id_0FF97225579DE16A) && _id_E1CECB04682E8442._id_0FF97225579DE16A == player._id_0FF97225579DE16A) {
        if(!scripts\engine\utility::array_contains(_id_E1CECB04682E8442.playersvisibleto, player))
          _id_E1CECB04682E8442.playersvisibleto[_id_E1CECB04682E8442.playersvisibleto.size] = player;
        else {}

        if(!isDefined(_id_25A840A406E8542A) || _id_E1CECB04682E8442.priority > _id_25A840A406E8542A.priority)
          _id_25A840A406E8542A = _id_E1CECB04682E8442;
      }
    }

    if(isDefined(_id_25A840A406E8542A))
      _id_420A996E67989DC4 _hudoutlineenableforclient(player, _id_25A840A406E8542A.hudoutlineassetname);
  }
}

outlinedisableinternalall(_id_420A996E67989DC4) {
  if(!isDefined(_id_420A996E67989DC4) || !isDefined(_id_420A996E67989DC4.outlines) || _id_420A996E67989DC4.outlines.size == 0) {
    return;
  }
  foreach(id, _ in _id_420A996E67989DC4.outlines)
  outlinedisableinternal(id, _id_420A996E67989DC4);
}

outlineaddtogloballist(_id_420A996E67989DC4) {
  if(!scripts\engine\utility::array_contains(level.outlineents, _id_420A996E67989DC4))
    level.outlineents[level.outlineents.size] = _id_420A996E67989DC4;
}

outlineremovefromgloballist(_id_420A996E67989DC4) {
  level.outlineents = scripts\engine\utility::array_remove(level.outlineents, _id_420A996E67989DC4);
}

outlinegethighestpriorityid(_id_420A996E67989DC4) {
  result = -1;

  if(!isDefined(_id_420A996E67989DC4.outlines) || _id_420A996E67989DC4.size == 0)
    return result;

  _id_25A840A406E8542A = undefined;

  foreach(id, _id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
    if(!isDefined(_id_E1CECB04682E8442) || _id_E1CECB04682E8442.isdisabled) {
      continue;
    }
    if(!isDefined(_id_25A840A406E8542A) || _id_E1CECB04682E8442.priority > _id_25A840A406E8542A.priority) {
      _id_25A840A406E8542A = _id_E1CECB04682E8442;
      result = id;
    }
  }

  return result;
}

outlinegethighestinfoforplayer(_id_420A996E67989DC4, player) {
  _id_25A840A406E8542A = undefined;

  if(!isDefined(_id_420A996E67989DC4.outlines) || _id_420A996E67989DC4.size == 0)
    return _id_25A840A406E8542A;

  foreach(id, _id_E1CECB04682E8442 in _id_420A996E67989DC4.outlines) {
    if(!isDefined(_id_E1CECB04682E8442) || _id_E1CECB04682E8442.isdisabled) {
      continue;
    }
    if(scripts\engine\utility::array_contains(_id_E1CECB04682E8442.playersvisibleto, player) && (!isDefined(_id_25A840A406E8542A) || _id_E1CECB04682E8442.priority > _id_25A840A406E8542A.priority))
      _id_25A840A406E8542A = _id_E1CECB04682E8442;
  }

  return _id_25A840A406E8542A;
}

outlinegenerateuniqueid() {
  level.outlineids++;
  return level.outlineids;
}

outlineprioritygroupmap(prioritygroup) {
  prioritygroup = tolower(prioritygroup);
  priority = undefined;

  switch (prioritygroup) {
    case "lowest":
      priority = 0;
      break;
    case "level_script":
      priority = 1;
      break;
    case "equipment":
      priority = 2;
      break;
    case "perk":
      priority = 3;
      break;
    case "perk_superior":
      priority = 4;
      break;
    case "killstreak":
      priority = 5;
      break;
    case "killstreak_personal":
      priority = 6;
      break;
    case "laststand":
      priority = 7;
      break;
    case "top":
      priority = 8;
      break;
    default:
      priority = 0;
      break;
  }

  return priority;
}

outlineiddowatch() {
  foreach(index, ent in level.outlineidspending) {
    if(!isDefined(ent)) {
      continue;
    }
    if(!isDefined(ent.outlines)) {
      continue;
    }
    _id_E1CECB04682E8442 = ent.outlines[index];

    if(!isDefined(_id_E1CECB04682E8442)) {
      continue;
    }
    if(_id_E1CECB04682E8442.playersvisibletopending.size > 0) {
      if(outlinerefreshpending(ent, index))
        level.outlineidspending[index] = undefined;
    }
  }
}

outlineidswatchpending() {
  for(;;) {
    waittillframeend;
    outlineiddowatch();
    waitframe();
  }
}

outlinerefreshpending(_id_420A996E67989DC4, id) {
  _id_E1CECB04682E8442 = _id_420A996E67989DC4.outlines[id];

  foreach(index, player in _id_E1CECB04682E8442.playersvisibletopending) {
    if(!isDefined(player)) {
      continue;
    }
    if(canoutlineforplayer(player)) {
      _id_25A840A406E8542A = outlinegethighestinfoforplayer(_id_420A996E67989DC4, player);

      if(isDefined(_id_25A840A406E8542A) && _id_25A840A406E8542A.hudoutlineassetname != "invisible")
        _id_420A996E67989DC4 hudoutlineenableforclient(player, _id_25A840A406E8542A.hudoutlineassetname);
      else
        _id_420A996E67989DC4 hudoutlinedisableforclient(player);

      _id_E1CECB04682E8442.playersvisibletopending[index] = undefined;
    }
  }

  _id_E1CECB04682E8442.playersvisibletopending = scripts\engine\utility::array_removeundefined(_id_E1CECB04682E8442.playersvisibletopending);

  if(_id_E1CECB04682E8442.playersvisibletopending.size == 0) {
    if(_id_E1CECB04682E8442.isdisabled)
      _id_420A996E67989DC4.outlines[id] = undefined;

    if(_id_420A996E67989DC4.outlines.size == 0)
      outlineremovefromgloballist(_id_420A996E67989DC4);

    return 1;
  }

  return 0;
}

canoutlineforplayer(player) {
  return player.sessionstate != "spectator";
}

_id_03430D5003D0CC9F(_id_CDA6602A02C53BA3, prioritygroup) {
  foreach(operator in _id_CDA6602A02C53BA3)
  hudoutline_enable_internal(operator, prioritygroup);
}

_hudoutlineenableforclient(_id_2C6CA80E296FED3A, hudoutlineassetname) {
  if(hudoutlineassetname == "invisible")
    self hudoutlinedisableforclient(_id_2C6CA80E296FED3A);
  else
    self hudoutlineenableforclient(_id_2C6CA80E296FED3A, hudoutlineassetname);
}

_hudoutlineenableforclients(_id_B66F9E35E36435BB, hudoutlineassetname) {
  if(hudoutlineassetname == "invisible")
    self hudoutlinedisableforclients(_id_B66F9E35E36435BB);
  else
    self hudoutlineenableforclients(_id_B66F9E35E36435BB, hudoutlineassetname);
}