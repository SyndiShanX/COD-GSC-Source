/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_58fe895fd0fbe620.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_F330CDB3A4738B38 = spawnStruct();
  level._id_F330CDB3A4738B38._id_5B4471E9EFDE87C3 = getdvarint("dvar_5243A49D736C276A", 45);
  level._id_F330CDB3A4738B38.planttime = getdvarint("dvar_4BDB410D2186F5EE", 5);
  level._id_F330CDB3A4738B38.defusetime = getdvarint("dvar_B41D9E16B59E4339", 5);
  level._id_F330CDB3A4738B38._id_7ADE8FAC6578B011 = getdvarint("dvar_A7D16B728A6465E6", 4);
  level._id_F330CDB3A4738B38.maxagents = getdvarint("dvar_2F3B4E80C7494134", 7);
  level._id_F330CDB3A4738B38._id_DE41D7355EF417C2 = getdvarint("dvar_331ED4C738FC999D", 0);
  level._effect["samsite_bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["bombsite_explosion"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");
  level._effect["bombsite_sparks"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_spark_trails_ch.vfx");
  _id_25DD3020969AA0F6 = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("dmz_supply_site", "script_noteworthy"));
  _id_78E1E12738C48FD3 = [];

  foreach(node in _id_25DD3020969AA0F6) {
    if(!isDefined(_id_78E1E12738C48FD3[node._id_B205D90302DA2F07]))
      _id_78E1E12738C48FD3[node._id_B205D90302DA2F07] = [];

    _id_78E1E12738C48FD3[node._id_B205D90302DA2F07][_id_78E1E12738C48FD3[node._id_B205D90302DA2F07].size] = node;
  }

  level._id_364DC596F40B8927 = [];

  foreach(_id_B205D90302DA2F07, _id_8B462903A1F84F9C in _id_78E1E12738C48FD3) {
    foreach(node in _id_8B462903A1F84F9C) {
      if(istrue(node.inuse)) {
        continue;
      }
      foreach(_id_1A7683A86F43BFF9 in _id_8B462903A1F84F9C) {
        if(node == _id_1A7683A86F43BFF9) {
          continue;
        }
        if(istrue(_id_1A7683A86F43BFF9.inuse)) {
          continue;
        }
        distance = distancesquared(node.origin, _id_1A7683A86F43BFF9.origin);

        if(distance < 4000000 || distance > 144000000) {
          continue;
        }
        node.end = _id_1A7683A86F43BFF9;
        node.inuse = 1;
        _id_1A7683A86F43BFF9.inuse = 1;
        level._id_364DC596F40B8927[level._id_364DC596F40B8927.size] = node;
      }
    }
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_supply_site_use", ::_id_4CADBB00EF649EE1);
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_32859F3F074BD004, level._id_364DC596F40B8927);
}

_id_32859F3F074BD004(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_129F1EF2E5686F84;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_65FCEECCC5C94E3D;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_59AE2A3ABCF5622F;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_80FA3143507133D8;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_4F74F23F5FD2D1B3;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_AC54686747281732;
  _id_B8EBE3F71A08AB40.ref = "dmz_demo_first";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;
  _id_B8EBE3F71A08AB40.end = node.end;
  node._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;
  node.end._id_B8EBE3F71A08AB40 = _id_B8EBE3F71A08AB40;

  if(!isDefined(level._id_3F95CE7A612B2553))
    level._id_3F95CE7A612B2553 = 0;

  _id_B8EBE3F71A08AB40._id_6CD05F946A7917F7 = "demoMission" + level._id_3F95CE7A612B2553;
  level._id_3F95CE7A612B2553++;
  return _id_B8EBE3F71A08AB40;
}

_id_129F1EF2E5686F84() {
  self.teams = [];
  self.bombsplanted = 0;
  self._id_8F0A9767E7A155A1 = 0;
  self.node _id_402EBB691260E816();
  self.end _id_402EBB691260E816();
  self.node thread _id_49C1DA07D69B6895(randomintrange(level._id_F330CDB3A4738B38._id_7ADE8FAC6578B011, level._id_F330CDB3A4738B38.maxagents + 1));
  self.end thread _id_49C1DA07D69B6895(randomintrange(level._id_F330CDB3A4738B38._id_7ADE8FAC6578B011, level._id_F330CDB3A4738B38.maxagents + 1));
  self.initialized = 1;
  self notify("task_initialized");
}

_id_65FCEECCC5C94E3D(_id_FABF84450735DD93) {
  self endon("task_ended");

  if(!isDefined(self.initialized) || !self.initialized)
    self waittill("task_initialized");
}

_id_59AE2A3ABCF5622F(_id_FABF84450735DD93) {
  self endon("task_ended");

  if(!isDefined(self.initialized) || !self.initialized)
    self waittill("task_initialized");

  self.node thread _id_D492DE2E54F2FA53();
  self.end thread _id_D492DE2E54F2FA53();
  thread _id_A8F1928F5279090B();
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_assigned", _id_FABF84450735DD93, 5.0);
  thread _id_C373F127DAFC389A(_id_FABF84450735DD93);
  waitframe();
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_demo_accept", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
}

_id_80FA3143507133D8(player) {
  foreach(node in [self.node, self.end]) {
    node _id_6C4E8CEA70BF4B6D::_id_FBF23AE15945EE5A(player);
    node _id_6C4E8CEA70BF4B6D::_id_1851E9CFB7687F68(player);

    if(isDefined(node.scriptable)) {
      if(istrue(node.bombplanted)) {
        node.scriptable disablescriptableplayeruse(player);
        continue;
      }

      node.scriptable enablescriptableplayeruse(player);
    }
  }
}

_id_4F74F23F5FD2D1B3(player) {
  foreach(node in [self.node, self.end]) {
    node _id_6C4E8CEA70BF4B6D::_id_401535E3FA9E171C(player);
    node _id_6C4E8CEA70BF4B6D::_id_556FB3A465F0E978(player);

    if(isDefined(node.scriptable)) {
      if(istrue(node.bombplanted)) {
        node.scriptable enablescriptableplayeruse(player);
        continue;
      }

      node.scriptable disablescriptableplayeruse(player);
    }
  }
}

_id_AC54686747281732(team) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    foreach(node in [self.node, self.end]) {
      if(isDefined(node.scriptable))
        node.scriptable disablescriptableplayeruse(player);
    }
  }

  self.failure = 1;
  _id_8250FD658E3AAE32();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
}

_id_8250FD658E3AAE32() {
  self.node _id_274106FC5A44C464();
  self.end _id_274106FC5A44C464();
}

_id_930BC6DC39F516DB(_id_FABF84450735DD93) {
  self notify("task_ended");
  players = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

  foreach(player in players)
  scripts\mp\objidpoolmanager::_id_7299A742781A5030(0, player);

  _id_8250FD658E3AAE32();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_A8F1928F5279090B() {
  self endon("task_ended");
  _id_F95FEB63C772E28F = (0, 0, 0);
  _id_D12A341B40354143 = 0;
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");
  _id_88BC5CA990516A9F = undefined;

  foreach(player in _id_E2B2BBD9E6539F11) {
    _id_D12A341B40354143++;
    _id_F95FEB63C772E28F = _id_F95FEB63C772E28F + player.origin;
  }

  if(_id_D12A341B40354143 > 0) {
    _id_F95FEB63C772E28F = _id_F95FEB63C772E28F / _id_D12A341B40354143;
    _id_88BC5CA990516A9F = sortbydistance([self.node, self.end], _id_F95FEB63C772E28F)[0];
  }

  self.node childthread _id_03314ADD7998AB13::_id_00CED2DBD3BA98D2(self.teams[0], self._id_EFA8EF05B190D7D0._id_7CA287A82F54E4F6, self.node == _id_88BC5CA990516A9F);
  self.end childthread _id_03314ADD7998AB13::_id_00CED2DBD3BA98D2(self.teams[0], self._id_EFA8EF05B190D7D0._id_7CA287A82F54E4F6, self.end == _id_88BC5CA990516A9F);
}

_id_402EBB691260E816() {
  self.site = spawnscriptable("dmz_supply_site", self.origin, self.angles);
}

_id_49C1DA07D69B6895(numagents) {
  _id_FEE76566EDC91600 = _id_48814951E916AF89::_id_9B6306B0CD33BD79(self.origin);
  aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, "short_range", undefined, _id_FEE76566EDC91600 + 1);
  _id_F945F5534FFEDF42 = anglesToForward(self.angles) * 80;
  origin = getclosestpointonnavmesh(self.origin + _id_F945F5534FFEDF42);
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, self.angles, "high", "mission", "safeInitialGuards", undefined, undefined, undefined, self._id_B205D90302DA2F07, 0, undefined, 1);

  if(isDefined(agent))
    thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numagents; _id_AC0E594AC96AA3A8++) {
    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, undefined, undefined, undefined, _id_FEE76566EDC91600);
    _id_50FBAC14DA970AE7 = randomfloatrange(144, 360);
    forward = anglesToForward(self.angles) * _id_50FBAC14DA970AE7;
    right = vectorcross((0, 0, 1), forward);
    _id_CB88E484EB1A3A92 = axistoangles(forward, right, (0, 0, 1));
    _id_88B83B0D7A43EA72 = _id_AC0E594AC96AA3A8 / numagents * 360 + randomfloatrange(-30.0, 30.0) % 360;
    offset = rotatepointaroundvector((0, 0, 1), forward, _id_88B83B0D7A43EA72);
    origin = getclosestpointonnavmesh(self.origin + offset);
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, _id_CB88E484EB1A3A92, "high", "mission", "demo", undefined, undefined, undefined, self._id_B205D90302DA2F07, 0, undefined, 0);

    if(isDefined(agent))
      thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
  }
}

_id_B73C05A413966AB2(time) {
  thread _id_71290CB605C32041(time);
  starttime = gettime();
  offset = level._id_F330CDB3A4738B38.defusetime;
  totaltime = time + offset;
  self.plantedbomb thread playtickingsound(time, offset);
  self.timeremaining = totaltime;

  for(;;) {
    currenttime = gettime();
    duration = (currenttime - starttime) / 1000;
    _id_0DE2C2A1FD468B5F = 1 - duration / time;
    progress = clamp(_id_0DE2C2A1FD468B5F, 0, 1);
    self.timeremaining = totaltime - duration;

    if(self.timeremaining <= 0) {
      self notify("bomb_exploded");
      break;
    }

    waitframe();
  }
}

_id_ACCEAD05B2C47CB7() {
  if(isDefined(self.plantedbomb)) {
    effect = "samsite_bomb_explosion";
    _id_408F3E834E201526 = self.plantedbomb.origin + (0, 0, 50);
    _id_EFDFC6EBE7A152C5 = spawnfx(level._effect[effect], _id_408F3E834E201526);
    _id_EFDFC6EBE7A152C5 thread scripts\engine\utility::_id_B4B04DE87729A6F3(10.0);
    triggerfx(_id_EFDFC6EBE7A152C5);
    physicsexplosionsphere(_id_408F3E834E201526, 200, 100, 3);
    playrumbleonposition("grenade_rumble", self.plantedbomb.origin);
    earthquake(0.25, 0.5, self.plantedbomb.origin, 500);
    playsoundatpos(_id_408F3E834E201526, "exp_bombsite_lr");
    self.plantedbomb radiusdamage(self.origin + (0, 0, 50), 350, 500, 10, self.plantedbomb, undefined, undefined, undefined, 0);

    if(isDefined(self.site)) {
      wait 0.25;
      effect = "bombsite_explosion";
      _id_408F3E834E201526 = self.site.origin;
      _id_EFDFC6EBE7A152C5 = spawnfx(level._effect[effect], _id_408F3E834E201526);
      _id_EFDFC6EBE7A152C5 thread scripts\engine\utility::_id_B4B04DE87729A6F3(10.0);
      triggerfx(_id_EFDFC6EBE7A152C5);
      physicsexplosionsphere(_id_408F3E834E201526, 200, 100, 3);
      playrumbleonposition("grenade_rumble", self.site.origin);
      earthquake(0.75, 2.0, self.site.origin, 2000);
      self.plantedbomb radiusdamage(self.origin + (0, 0, 50), 750, 500, 10, self.plantedbomb);
      self.site setscriptablepartstate("dmz_supply_site", "destroyed");
      wait 0.05;
      self.plantedbomb delete();
    }
  }
}

_id_33B12655DEB4B72A(time) {
  level endon("game_ended");
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  self endon("bomb_defused");
  _id_B73C05A413966AB2(time);

  foreach(team in self._id_B8EBE3F71A08AB40.teams)
  objective_hideprogressforteam(self.icon, team);

  _id_ACCEAD05B2C47CB7();
  wait 0.1;
  self._id_B8EBE3F71A08AB40._id_8F0A9767E7A155A1++;
  _id_274106FC5A44C464();
  team = self._id_B8EBE3F71A08AB40.teams[0];

  if(self._id_B8EBE3F71A08AB40._id_8F0A9767E7A155A1 == 2) {
    thread _id_662CBAC61C1AE7E2::_id_9967799221F8DD5E(team, self.origin);
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_second_exploded", team, 1.5);

    if(getdvarint("dvar_E9A3F2805D0F46B8", 1))
      thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_safe_reward_contractor ", team, 4.5);
    else
      thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_safe_reward_intel", team, 4.5);

    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
    self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(team);
    self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_demo_win", "demo", self._id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, team);
    self._id_B8EBE3F71A08AB40 thread _id_930BC6DC39F516DB(team);
  } else if(self._id_B8EBE3F71A08AB40._id_8F0A9767E7A155A1 == 1) {
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_first_exploded", team, 1.5);
    self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_demo_first_explosion", team);

    if(self._id_B8EBE3F71A08AB40.bombsplanted == 1)
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
  }
}

_id_BC04FD896910905A() {
  self.scriptable setscriptablepartstate("dmz_supply_site_use", "usable", 0);

  foreach(player in level.players)
  self.scriptable disablescriptableplayeruse(player);

  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_B8EBE3F71A08AB40.teams[0], "players");

  foreach(player in _id_E2B2BBD9E6539F11)
  self.scriptable enablescriptableplayeruse(player);
}

_id_DDA2D720BBB26623() {
  self.scriptable = spawnscriptable("dmz_supply_site_use", self.origin, self.angles);
  self.scriptable.node = self;
  _id_BC04FD896910905A();
}

_id_E9BFFB81BD2653A4() {
  self.scriptable setscriptablepartstate("dmz_supply_site_use", "defusable");

  foreach(player in level.players)
  self.scriptable enablescriptableplayeruse(player);

  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_B8EBE3F71A08AB40.teams[0], "players");

  foreach(player in _id_E2B2BBD9E6539F11)
  self.scriptable disablescriptableplayeruse(player);
}

_id_EBAA4417A40158F5() {
  self.scriptable.origin = self.plantedbomb.origin;
  _id_E9BFFB81BD2653A4();
}

_id_D492DE2E54F2FA53() {
  _id_DDA2D720BBB26623();
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 100);
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.origin + self.offset3d, "sabotage");
  _id_6C4E8CEA70BF4B6D::_id_8CD2AC82037F025C("Hostage_Dmz", self.origin, 1000);
  _id_6C4E8CEA70BF4B6D::_id_E54DF8560BF7DC64(self._id_B8EBE3F71A08AB40.teams[0]);
  self waittill("bomb_planted");
  self._id_B8EBE3F71A08AB40.bombsplanted++;
  objective_position(self.icon, self.plantedbomb.origin + (0, 0, 50));
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self._id_B8EBE3F71A08AB40.teams[0], "players");

  if(self._id_B8EBE3F71A08AB40.bombsplanted == 2) {
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_second_plant", self._id_06036CD81FE22627.team);
    self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_demo_defend");
  } else if(self._id_B8EBE3F71A08AB40.bombsplanted == 1) {
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_first_plant", self._id_06036CD81FE22627.team);
    node = scripts\engine\utility::ter_op(self == self._id_B8EBE3F71A08AB40.node, self._id_B8EBE3F71A08AB40.end, self._id_B8EBE3F71A08AB40.node);
    self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_demo_second");
  }

  _id_EBAA4417A40158F5();
  thread _id_1839A40E099BB63F();
  thread _id_33B12655DEB4B72A(level._id_F330CDB3A4738B38._id_5B4471E9EFDE87C3);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self._id_B8EBE3F71A08AB40.teams[0], "dmz_activity_action", 0.0, "dmz_activity_action_classic");

  if(istrue(level._id_F330CDB3A4738B38._id_DE41D7355EF417C2)) {
    self._id_7B45AAAC74192C14 = _id_48814951E916AF89::_id_353FECD1549F5F42(self.plantedbomb.origin, 2048, undefined, 10);

    if(self._id_7B45AAAC74192C14.size < 5)
      thread _id_844DFE93476D59AB();
  }
}

_id_4CADBB00EF649EE1(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(part != "dmz_supply_site_use") {
    return;
  }
  if(state == "usable") {
    instance setscriptablepartstate("dmz_supply_site_use", "unusable");
    node = instance.node;
    _id_B8EBE3F71A08AB40 = node._id_B8EBE3F71A08AB40;

    if(isDefined(node._id_8E977040CC228632) && istrue(node._id_8E977040CC228632)) {
      return;
    }
    node._id_8E977040CC228632 = 1;
    bomb = _id_CADC5181C3B67E3F(player);
    thread _id_6C4E8CEA70BF4B6D::_id_D86771EDADBA8B4A(node, node, player);
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < level._id_F330CDB3A4738B38.planttime) {
      if(node._id_A4CF15C49F3E9EEF || istrue(_id_B8EBE3F71A08AB40.failure) || !scripts\mp\utility\player::_id_AD443BBCDCF37B85(player)) {
        node._id_8E977040CC228632 = 0;
        _id_0DB896F4486CA187(player, bomb);

        if(!istrue(_id_B8EBE3F71A08AB40.failure))
          node _id_BC04FD896910905A();

        return;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    origin = player.origin;
    _id_0DB896F4486CA187(player, bomb);

    if(istrue(_id_B8EBE3F71A08AB40.failure)) {
      return;
    }
    _id_EEB138FAE3842A92 = spawn("script_model", origin);
    _id_EEB138FAE3842A92 setModel("offhand_2h_wm_briefcase_bomb_v0");
    _id_EEB138FAE3842A92.visuals = [];
    _id_EEB138FAE3842A92.visuals[0] = spawn("script_model", origin);
    _id_EEB138FAE3842A92.visuals[0] setModel("tag_origin");
    _id_EEB138FAE3842A92.curorigin = origin;
    _id_EEB138FAE3842A92.offset3d = (0, 0, 15);
    _id_EEB138FAE3842A92.safeorigin = origin;
    _id_EEB138FAE3842A92.trigger = spawnStruct();
    _id_EEB138FAE3842A92.icon = -1;
    _id_EEB138FAE3842A92.owner = player;
    _id_EEB138FAE3842A92 scripts\mp\gameobjects::setdropped(undefined, undefined, 1);
    node.plantedbomb = _id_EEB138FAE3842A92;
    node.plantedbomb.node = node;
    node.bombplanted = 1;
    node._id_06036CD81FE22627 = player;
    node notify("bomb_planted");
  } else if(state == "defusable") {
    instance setscriptablepartstate("dmz_supply_site_use", "unusable");
    node = instance.node;
    _id_B8EBE3F71A08AB40 = node._id_B8EBE3F71A08AB40;

    if(isDefined(node._id_482C2428A4E2FDDC) && istrue(node._id_482C2428A4E2FDDC)) {
      return;
    }
    node._id_482C2428A4E2FDDC = 1;
    node.plantedbomb hide();
    bomb = _id_CADC5181C3B67E3F(player);
    thread _id_6C4E8CEA70BF4B6D::_id_D86771EDADBA8B4A(node, node, player);
    _id_8B07FA3892A3A8A4 = 0;

    while(_id_8B07FA3892A3A8A4 < level._id_F330CDB3A4738B38.defusetime) {
      if(node._id_A4CF15C49F3E9EEF || !scripts\mp\utility\player::_id_AD443BBCDCF37B85(player) || istrue(_id_B8EBE3F71A08AB40.failure) || isDefined(player._id_02CA0DAC193D83C1) && player._id_02CA0DAC193D83C1) {
        node._id_482C2428A4E2FDDC = 0;
        _id_0DB896F4486CA187(player, bomb);
        node.plantedbomb show();

        if(!istrue(_id_B8EBE3F71A08AB40.failure))
          node _id_E9BFFB81BD2653A4();

        return;
      }

      _id_8B07FA3892A3A8A4 = _id_8B07FA3892A3A8A4 + level.framedurationseconds;
      waitframe();
    }

    if(istrue(_id_B8EBE3F71A08AB40.failure)) {
      _id_0DB896F4486CA187(player, bomb);
      return;
    }

    node notify("bomb_defused");
    node._id_285292A6695A1FCA = player;
    _id_0DB896F4486CA187(player, bomb);
    node.plantedbomb show();
  }
}

_id_1839A40E099BB63F() {
  level endon("game_ended");
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  self endon("bomb_exploded");
  self waittill("bomb_defused");
  self.scriptable freescriptable();
  _id_03060D27FFB03AD2 = self._id_285292A6695A1FCA.team;
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_defused_others", _id_03060D27FFB03AD2, 1.5);
  self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_demo_defused_win", "demo", self._id_B8EBE3F71A08AB40._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_03060D27FFB03AD2);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_03060D27FFB03AD2, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  thread _id_662CBAC61C1AE7E2::_id_9967799221F8DD5E(_id_03060D27FFB03AD2, self.origin);

  if(getdvarint("dvar_671F3AF465D66FF7", 0))
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_safe_reward_contractor ", _id_03060D27FFB03AD2, 4.5);
  else
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_safe_reward_intel", _id_03060D27FFB03AD2, 4.5);

  _id_379D6BAD84E53438 = self._id_B8EBE3F71A08AB40.teams[0];
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_defused", _id_379D6BAD84E53438, 1.5);
  self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_demo_defused_lose", "demo", 0, _id_379D6BAD84E53438);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_379D6BAD84E53438, "dmz_activity_lose", 1.0, "dmz_activity_lose_classic");
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onBombDefused", self._id_285292A6695A1FCA);
  self._id_B8EBE3F71A08AB40 _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_03060D27FFB03AD2);
  self._id_B8EBE3F71A08AB40 thread _id_930BC6DC39F516DB(undefined);
  wait 10.0;
  self.plantedbomb delete();
}

_id_71290CB605C32041(timer) {
  level endon("game_ended");
  self._id_B8EBE3F71A08AB40 endon("task_ended");
  self endon("bomb_defused");
  wait(timer);
  self.scriptable setscriptablepartstate("dmz_supply_site_use", "unusable", 0);
}

_id_CADC5181C3B67E3F(player) {
  player _id_BF9EC93BEE75F88C(0);
  bomb = makeweapon("briefcase_bomb_mp");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(bomb, undefined, undefined, 0);
  player setweaponammostock(bomb, 0);
  player setweaponammoclip(bomb, 0);
  player thread scripts\mp\gameobjects::switchtouseweapon(bomb, 1, 1);
  return bomb;
}

_id_0DB896F4486CA187(player, bomb) {
  lastweaponobj = player scripts\mp\utility\inventory::getlastweapon();

  if(player scripts\mp\utility\killstreak::isjuggernaut())
    lastweaponobj = scripts\mp\juggernaut::jugg_getminigunweapon();
  else if(!player hasweapon(lastweaponobj))
    lastweaponobj = player scripts\mp\utility\inventory::getfirstprimaryweapon();

  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(lastweaponobj, 0, 1);
  player takeweapon(bomb);
  player _id_BF9EC93BEE75F88C(1);
}

_id_844DFE93476D59AB() {
  level endon("game_ended");
  self endon("task_ended");
  self endon("bomb_exploded");
  agents = undefined;

  while(!isDefined(agents)) {
    agents = _id_48814951E916AF89::_id_77ACC10C4823DD8A(5, self.origin, "medium", "mission", "demoReinforcements", undefined, undefined, 1, self._id_B205D90302DA2F07);

    if(!isDefined(agents))
      wait 1.0;
  }
}

_id_BF9EC93BEE75F88C(_id_BD138DE99B3B3507) {
  _id_3B64EB40368C1450::set("sam_holding_bomb", "allow_movement", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "sprint", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "fire", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "reload", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "weapon_pickup", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "weapon_switch", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "allow_jump", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "gesture", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "supers", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "allow_super_jump", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "vehicle_use", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "vehicle_lean_out", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "vehicle_seat_switch", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "ascender_use", _id_BD138DE99B3B3507);
  self _meth_35501B42058D4DE9();

  if(_id_BD138DE99B3B3507)
    scripts\engine\utility::waittill_any_timeout_1(0.8, "bomb_allow_offhands");

  _id_3B64EB40368C1450::set("sam_holding_bomb", "melee", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "mantle", _id_BD138DE99B3B3507);
  _id_3B64EB40368C1450::set("sam_holding_bomb", "offhand_weapons", _id_BD138DE99B3B3507);

  if(_id_BD138DE99B3B3507) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("sam_holding_bomb");
    self _meth_BB04491D50D9E43E();
  }
}

playtickingsound(time, offset) {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  self.node endon("bomb_exploded");
  self.node endon("bomb_defused");
  self.node._id_B8EBE3F71A08AB40 endon("task_ended");
  _id_8AA881DB64E772E5 = 45;
  _id_A46637C818D15DBF = 10;
  _id_F139DBCFCE7A127D = 2;
  time = time * 1000;
  offset = offset * 1000;
  currenttime = gettime();
  _id_F28399727742EB23 = currenttime + time + offset;
  _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

  while(_id_C301D652D9A73075 > 0) {
    currenttime = gettime();
    _id_C301D652D9A73075 = _id_F28399727742EB23 - currenttime;

    if(_id_C301D652D9A73075 <= 0 + offset) {
      if(_id_C301D652D9A73075 <= 250) {
        if(soundexists("dmz_bombsite_warning_beep_05"))
          self playSound("dmz_bombsite_warning_beep_05");
      } else if(_id_C301D652D9A73075 <= 750) {
        if(soundexists("dmz_bombsite_warning_beep_04"))
          self playSound("dmz_bombsite_warning_beep_04");
      } else if(_id_C301D652D9A73075 <= 1500) {
        if(soundexists("dmz_bombsite_warning_beep_03"))
          self playSound("dmz_bombsite_warning_beep_03");
      } else if(soundexists("dmz_bombsite_warning_beep_02"))
        self playSound("dmz_bombsite_warning_beep_02");

      wait 0.25;
      continue;
    }

    if(_id_C301D652D9A73075 <= 10000 + offset) {
      if(soundexists("dmz_bombsite_warning_beep_02"))
        self playSound("dmz_bombsite_warning_beep_02");

      wait 0.5;
      continue;
    }

    if(soundexists("dmz_bombsite_warning_beep_01"))
      self playSound("dmz_bombsite_warning_beep_01");

    wait 1.0;
  }
}

_id_C373F127DAFC389A(team) {
  self endon("task_ended");
  _id_27483A41D2410CC8 = 9000000;
  _id_B485E3529246A8DE = 90000;
  _id_44937005A0F57F50 = 0;

  for(;;) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");
    _id_4F0FC1C36324AFFB = 10000000000;
    _id_0FA73C7E2D99FA15 = (0, 0, 0);

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      distsq = distance2dsquared(self.node.origin, player.origin);

      if(_id_4F0FC1C36324AFFB > distsq) {
        _id_4F0FC1C36324AFFB = distsq;
        _id_0FA73C7E2D99FA15 = player.origin;
      }
    }

    if(!_id_44937005A0F57F50 && _id_4F0FC1C36324AFFB < _id_27483A41D2410CC8) {
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_near", team);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
      _id_44937005A0F57F50 = 1;
    }

    if(_id_4F0FC1C36324AFFB < _id_B485E3529246A8DE) {
      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("demolition_approach", team);
      _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(team, "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
      return;
    }

    wait 1.0;
  }
}

_id_274106FC5A44C464() {
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();

  if(isDefined(self.scriptable))
    self.scriptable freescriptable();
}