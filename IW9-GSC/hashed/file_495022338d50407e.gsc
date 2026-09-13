/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_495022338d50407e.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_AC29BBE3A85FC5FA = spawnStruct();
  level._id_AC29BBE3A85FC5FA.capturetime = getdvarint("dvar_40D76DD47F1FFBC5", 75);
  level._id_AC29BBE3A85FC5FA._id_029A79D378C70E0B = getdvarint("dvar_8FD341AD9E996D3A", 150);
  _id_AB2BE8088C0A7C90 = scripts\engine\utility::getStructArray("dmz_safe", "script_noteworthy");
  validlocations = [];

  foreach(_id_2A438B0332B8A143 in _id_AB2BE8088C0A7C90) {
    _id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(_id_2A438B0332B8A143.origin);

    if(!isDefined(_id_276AC5E84835EA87))
      validlocations[validlocations.size] = _id_2A438B0332B8A143;
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("safe", ::_id_04071D82A4AF35FC);
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_BA90393E0583B4F7, validlocations);
}

_id_BA90393E0583B4F7(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_42C897C05FDDA094;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_F28CAA329349BBAD;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_3436BDADD63E9416;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_D36F7F4E34B1C64D;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_EB88F0C1BC2ACD7F;
  _id_B8EBE3F71A08AB40.ref = "dmz_safe_find";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;
  return _id_B8EBE3F71A08AB40;
}

_id_42C897C05FDDA094() {
  if(!isDefined(self.node)) {
    return;
  }
  self._id_32605DB102447D94 = spawnscriptable("dmz_safe", self.node.origin, self.node.angles);
  self._id_32605DB102447D94._id_B8EBE3F71A08AB40 = self;
  self.capturetime = level._id_AC29BBE3A85FC5FA.capturetime;
  trigger = spawn("trigger_radius", self.node.origin, 0, int(level._id_AC29BBE3A85FC5FA._id_029A79D378C70E0B), int(level._id_AC29BBE3A85FC5FA._id_029A79D378C70E0B));
  trigger scripts\engine\utility::trigger_off();
  self.trigger = trigger;
  self.curorigin = self.node.origin;
  self.offset3d = (0, 0, 60);
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, "ui_map_icon_obj_recover");
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 4);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
  objective_setshowprogress(self.objidnum, 1);
  _id_A17B754D1372F83E(2);
  thread _id_A765843F381AD171();
  thread _id_474E2E9B4A997564(trigger, level._id_AC29BBE3A85FC5FA._id_029A79D378C70E0B);
}

_id_EB88F0C1BC2ACD7F(_id_FABF84450735DD93) {
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_safe_defend_assigned", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
}

_id_3436BDADD63E9416(player) {
  if(istrue(self.started))
    self._id_32605DB102447D94 enablescriptableplayeruse(player);
}

_id_D36F7F4E34B1C64D(player) {
  self._id_32605DB102447D94 disablescriptableplayeruse(player);
}

_id_F28CAA329349BBAD(_id_FABF84450735DD93) {
  if(self._id_32605DB102447D94 getscriptablepartstate("safe") == "waiting")
    self._id_32605DB102447D94 setscriptablepartstate("safe", "usable");

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.team) && !scripts\engine\utility::array_contains(self.teams, player.team))
      self._id_32605DB102447D94 disablescriptableplayeruse(player);
  }
}

_id_A22953D5C684962B(_id_FABF84450735DD93) {
  scripts\mp\gameobjects::releaseid();

  foreach(team in self.teams) {
    _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_safe_defend_complete", _id_FABF84450735DD93);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  }

  waitframe();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_04071D82A4AF35FC(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state == "usable") {
    instance setscriptablepartstate(part, "unusable");
    _id_58ACAD1090B81311 = scripts\engine\utility::array_contains(instance._id_B8EBE3F71A08AB40.teams, player.team);

    foreach(team in instance._id_B8EBE3F71A08AB40.teams)
    instance._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_safe_defend_started", team);

    if(!_id_58ACAD1090B81311)
      instance._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_safe_defend_started", player.team);

    waitframe();
    instance._id_B8EBE3F71A08AB40.trigger scripts\engine\utility::trigger_on();
    instance._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_safe_defend");

    if(!_id_58ACAD1090B81311)
      instance._id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0 _id_03314ADD7998AB13::_id_3FAA04EF514A5FC4(player.team, undefined, player);

    foreach(team in instance._id_B8EBE3F71A08AB40.teams) {
      if(team == player.team) {
        _id_5307834CD39B435C::_id_1C2BD1696D29935B(team, "dmz_mission_safe_opening");
        _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_action", 1.0, "dmz_activity_action_classic");
        continue;
      }

      _id_5307834CD39B435C::_id_1C2BD1696D29935B(team, "dmz_mission_safe_opening_other_team");
    }
  } else if(state == "open_usable") {
    if(!isDefined(instance.contents)) {
      instance.contents = _id_D257C9925E2AFFD2();
      instance._id_46A3A8565AC0C17C = 4;
      instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);
      instance._id_B8EBE3F71A08AB40 _id_A22953D5C684962B(player.team);
    } else
      instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);
  }
}

_id_A17B754D1372F83E(_id_6E6EE0D9F73A2999) {
  self.agents = [];
  _id_F945F5534FFEDF42 = anglesToForward(self._id_32605DB102447D94.angles) * 80;
  origin = getclosestpointonnavmesh(self._id_32605DB102447D94.origin + _id_F945F5534FFEDF42);
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "short_range", undefined, 2), origin, self._id_32605DB102447D94.angles, "high", "mission", "safeInitialGuards", undefined, undefined, undefined, self._id_B205D90302DA2F07, 1);

  if(isDefined(agent)) {
    self.agents[0] = agent;
    agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent, 0);

    if(isagent(agent)) {
      agent _id_120270BD0A747A35::_id_304DA84D9A815C01(origin, 64);
      agent allowedstances("stand");
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6E6EE0D9F73A2999; _id_AC0E594AC96AA3A8++) {
    _id_DCF5E15C58C4152A = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "short_range");
    _id_50FBAC14DA970AE7 = randomfloatrange(144, 360);
    forward = anglesToForward(self._id_32605DB102447D94.angles) * _id_50FBAC14DA970AE7;
    right = vectorcross((0, 0, 1), forward);
    _id_CB88E484EB1A3A92 = axistoangles(forward, right, (0, 0, 1));
    _id_88B83B0D7A43EA72 = _id_AC0E594AC96AA3A8 / _id_6E6EE0D9F73A2999 * 360 + randomfloatrange(-30.0, 30.0) % 360;
    offset = rotatepointaroundvector((0, 0, 1), forward, _id_88B83B0D7A43EA72);
    origin = getclosestpointonnavmesh(self._id_32605DB102447D94.origin + offset);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(_id_DCF5E15C58C4152A, origin, _id_CB88E484EB1A3A92, "high", "mission", "safe", undefined, undefined, undefined, self._id_B205D90302DA2F07);

    if(isDefined(agent)) {
      self.agents[self.agents.size] = agent;
      agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
    }
  }

  if(isDefined(self.agents)) {
    foreach(agent in self.agents) {
      if(isagent(agent))
        thread _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(agent, "assignment", self._id_6CD05F946A7917F7);
    }
  }
}

_id_A765843F381AD171() {
  level endon("game_ended");
  self endon("task_ended");
  self.progress = 0;
  _id_A81135442EE1A731 = 0;
  _id_306804C6C85C36B0 = undefined;
  _id_94947EF251BF06D8 = 0;
  _id_F7D8DF490BD332C3 = 512;
  _id_7CC37D084D5E863C = 0;
  _id_90FB369A18926018 = [];

  for(;;) {
    if(isDefined(self.trigger) && !istrue(self.trigger.trigger_off)) {
      if(!isDefined(_id_306804C6C85C36B0))
        _id_306804C6C85C36B0 = [0, self.capturetime / 4, self.capturetime / 2, self.capturetime / 100 * 75];

      if(self._id_78122E18403A8DC4.size > 0) {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = min(self.capturetime, self.progress + level.framedurationseconds);
      } else {
        _id_F8527642EA162AE5 = self.progress;
        self.progress = max(0, self.progress - level.framedurationseconds * 2);
      }

      _id_90FB369A18926018 = _id_075A1596E8181156(self._id_78122E18403A8DC4, _id_90FB369A18926018);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.progress / self.capturetime);

      if(self.progress >= self.capturetime)
        _id_67ABFC6A70AF2CCC();
      else if(self._id_78122E18403A8DC4.size > 0 && isDefined(_id_306804C6C85C36B0[_id_94947EF251BF06D8]) && self.progress >= _id_306804C6C85C36B0[_id_94947EF251BF06D8]) {
        _id_94947EF251BF06D8++;
        _id_F7D8DF490BD332C3 = _id_F7D8DF490BD332C3 + 768;

        if(_id_F7D8DF490BD332C3 > 2816)
          _id_F7D8DF490BD332C3 = 2816;

        agents = _id_48814951E916AF89::_id_353FECD1549F5F42(self.node.origin, _id_F7D8DF490BD332C3, undefined, 3, undefined, 64, 128);

        if(isDefined(agents)) {
          self.agents = scripts\engine\utility::array_combine(self.agents, agents);
          _id_A81135442EE1A731 = _id_A81135442EE1A731 + agents.size;
        }

        if(!_id_7CC37D084D5E863C && _id_94947EF251BF06D8 == 1 && _id_A81135442EE1A731 < 4) {
          _id_DA117CA38EFAC51B = _id_48814951E916AF89::_id_77ACC10C4823DD8A(5, self.node.origin, "high", "mission", "safeReinforcements", undefined, undefined, 1, self.node._id_B205D90302DA2F07, "Helicopter", 32, 64, ["shotgun"]);

          if(isDefined(_id_DA117CA38EFAC51B) && _id_DA117CA38EFAC51B.size > 0) {
            _id_7CC37D084D5E863C = 1;
            self.agents = scripts\engine\utility::array_combine(self.agents, _id_DA117CA38EFAC51B);
          }
        }
      } else if(self._id_78122E18403A8DC4.size == 0 && _id_94947EF251BF06D8 > 0) {
        _id_94947EF251BF06D8 = 0;
        _id_F7D8DF490BD332C3 = 512;

        foreach(agent in self.agents)
        agent._id_9F78B0C726E807FF = 0;
      }
    }

    waitframe();
  }
}

_id_075A1596E8181156(_id_78122E18403A8DC4, _id_90FB369A18926018) {
  _id_5C882C8F7BB9C72A = scripts\engine\utility::array_combine(_id_78122E18403A8DC4, _id_90FB369A18926018);

  foreach(player in _id_5C882C8F7BB9C72A) {
    if(!isDefined(player)) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::objective_pin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_7299A742781A5030(2, player);
      scripts\mp\objidpoolmanager::_id_8F7A55BDA12EBB21(&"MP_DMZ_MISSIONS/OPENING_SAFE", player);
      continue;
    }

    if(scripts\engine\utility::array_contains(_id_90FB369A18926018, player) && !scripts\engine\utility::array_contains(_id_78122E18403A8DC4, player)) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);
      scripts\mp\objidpoolmanager::_id_7299A742781A5030(0, player);
    }
  }

  return _id_78122E18403A8DC4;
}

_id_67ABFC6A70AF2CCC() {
  self.trigger delete();
  _id_6C4E8CEA70BF4B6D::_id_42718C89B38E260B(self.objidnum, self.teams);

  foreach(agent in self.agents)
  agent._id_9F78B0C726E807FF = 0;

  foreach(team in self.teams) {
    _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_safe_defend_unlocked", team);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_tension", 1.0, "dmz_activity_tension_classic");
    _id_5307834CD39B435C::_id_1C2BD1696D29935B(team, "dmz_mission_safe_unlocked");
  }

  self._id_32605DB102447D94 setscriptablepartstate("safe", "open_usable");
  _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_safe_loot");
}

_id_474E2E9B4A997564(trigger, radius) {
  level endon("game_ended");
  self endon("task_ended");
  self._id_78122E18403A8DC4 = [];

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player) || scripts\engine\utility::array_contains(self._id_78122E18403A8DC4, player)) {
      continue;
    }
    self._id_78122E18403A8DC4 = scripts\engine\utility::array_add(self._id_78122E18403A8DC4, player);
    thread _id_D5720AE15E13FF51(trigger, player, radius);
  }
}

_id_D257C9925E2AFFD2() {
  contents = [];
  _id_8EDB49ADF90C641A = randomintrange(50, 75);
  contents[0]["quantity"] = _id_8EDB49ADF90C641A;
  contents[0]["lootID"] = 8395;
  contents[1]["quantity"] = 125 - _id_8EDB49ADF90C641A;
  contents[1]["lootID"] = 8395;

  if(randomint(2) > 0) {
    contents[2]["quantity"] = 1;
    contents[2]["lootID"] = 9230;
  } else {
    contents[2]["quantity"] = 1;
    contents[2]["lootID"] = 9224;
  }

  randomint = randomint(3);

  if(randomint == 0) {
    contents[3]["quantity"] = 5;
    contents[3]["lootID"] = 9111;
  } else if(randomint == 1) {
    contents[3]["quantity"] = 1;
    contents[3]["lootID"] = 8548;
    contents[4]["quantity"] = 1;
    contents[4]["lootID"] = 8548;
  } else {
    contents[3]["quantity"] = 5;
    contents[3]["lootID"] = 8372;
  }

  if(randomfloat(1) < 0.2) {
    randomint = randomint(3);
    index = contents.size;

    if(randomint == 0) {
      contents[index]["quantity"] = 1;
      contents[index]["lootID"] = 8089;
    } else if(randomint == 1) {
      contents[index]["quantity"] = 1;
      contents[index]["lootID"] = 3200;
    } else {
      contents[index]["quantity"] = 1;
      contents[index]["lootID"] = 2696;
    }
  }

  return scripts\engine\utility::array_randomize(contents);
}

_id_D5720AE15E13FF51(trigger, player, radius) {
  while(isDefined(player) && isalive(player) && isDefined(self.trigger) && distance(trigger.origin, player.origin) < radius * 1.2)
    wait 0.2;

  self._id_78122E18403A8DC4 = scripts\engine\utility::array_remove(self._id_78122E18403A8DC4, player);
}