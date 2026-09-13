/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6b7618d5ead05b66.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  level._id_2DF078757BF07A9C = spawnStruct();
  level._id_2DF078757BF07A9C.circleradius = getdvarint("dvar_FE6626EF02D8F40C", 300);
  level._id_2DF078757BF07A9C._id_E3AA1DE9D96E0086 = getdvarint("dvar_0336EFDA7C2D0EEF", 700);
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_66FFDDABD1ACF94D, _id_CD188BF0ECA0B685());
}

_id_66FFDDABD1ACF94D(_id_EFA8EF05B190D7D0, _id_276AC5E84835EA87) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_973ED02A7FF4858E;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_9B000E63C2C98E77;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_8EAAE8654221FDC5;
  _id_B8EBE3F71A08AB40._id_276AC5E84835EA87 = _id_276AC5E84835EA87;
  _id_B8EBE3F71A08AB40.node = _id_276AC5E84835EA87;
  _id_B8EBE3F71A08AB40.ref = "dmz_clear_fortress";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  return _id_B8EBE3F71A08AB40;
}

_id_973ED02A7FF4858E() {
  self._id_6181D0250AFA3CEC = 0;
  _id_79B9C85900392AD6 = _id_6C4E8CEA70BF4B6D::_id_AB50F62A3A730400(self._id_276AC5E84835EA87.origin, level._id_2DF078757BF07A9C.circleradius);
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self._id_276AC5E84835EA87.origin + (0, 0, 750));
  _id_6C4E8CEA70BF4B6D::_id_325390EDB051CD5D("Hostage_Dmz", [_id_79B9C85900392AD6], level._id_2DF078757BF07A9C.circleradius + level._id_2DF078757BF07A9C._id_E3AA1DE9D96E0086);

  if(!isDefined(self._id_276AC5E84835EA87._id_698AB4F1074B4F37) || !self._id_276AC5E84835EA87._id_698AB4F1074B4F37)
    self._id_276AC5E84835EA87 waittill("spawned_agents");

  self._id_FFB8DD38BB2FCB3A = _id_C084840561571609();

  if(!isDefined(self._id_FFB8DD38BB2FCB3A) || self._id_FFB8DD38BB2FCB3A.size == 0) {
    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
    return;
  }

  self._id_65240018A4921EA7 = self._id_FFB8DD38BB2FCB3A.size;
  self._id_EFA8EF05B190D7D0.origin = self._id_276AC5E84835EA87.origin;
  thread _id_9935990849FE88DD();
  self.initialized = 1;
  self notify("task_initialized");
}

_id_9B000E63C2C98E77(_id_FABF84450735DD93) {
  self endon("end_task");

  if(!isDefined(self.initialized) || !self.initialized)
    self waittill("task_initialized");

  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("clear_fort_approach", _id_FABF84450735DD93);
}

_id_8EAAE8654221FDC5(_id_FABF84450735DD93) {
  self endon("end_task");

  if(!isDefined(self.initialized) || !self.initialized)
    self waittill("task_initialized");

  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("clear_fort_assigned", _id_FABF84450735DD93);
  thread _id_C373F127DAFC389A(_id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_clear_fort_assigned", _id_FABF84450735DD93);
  _id_6C4E8CEA70BF4B6D::_id_E54DF8560BF7DC64(_id_FABF84450735DD93);
  thread _id_6C4E8CEA70BF4B6D::_id_9E357E07833A0D1A(_id_FABF84450735DD93);
}

_id_2134F4B01729BB9E(agent, _id_6181DE250AFA5BB6) {
  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team) && scripts\engine\utility::array_contains(self._id_FFB8DD38BB2FCB3A, agent)) {
    _id_872AD260CEF5CB9A();

    if(self._id_FFB8DD38BB2FCB3A.size == 1)
      thread _id_12F03B76F27611E3(_id_6181DE250AFA5BB6.team);

    _id_B275BDA155C24C12(_id_6181DE250AFA5BB6, agent);
  }
}

_id_9935990849FE88DD() {
  for(;;) {
    ai = scripts\common\utility::_id_0A92D0739B2373DF(self._id_276AC5E84835EA87.origin, 3000, 0);
    _id_C65A4CA6F567404A = [];

    foreach(guy in ai) {
      foreach(volume in self._id_276AC5E84835EA87._id_AA7C37B8B3EC1F46) {
        if(ispointinvolume(guy.origin, volume))
          _id_C65A4CA6F567404A[_id_C65A4CA6F567404A.size] = guy;
      }
    }

    if(!_id_C65A4CA6F567404A.size) {
      _id_1432B702120E6711(self.teams[0]);
      return;
    }

    wait 1.0;
  }
}

_id_1432B702120E6711(_id_FABF84450735DD93) {
  self notify("end_task");
  _id_48814951E916AF89::_id_66A6064FAD612BF3(::_id_2134F4B01729BB9E);
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
  _id_6C4E8CEA70BF4B6D::_id_2476DAEFA3384C5E();

  if(isDefined(_id_FABF84450735DD93)) {
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("clear_fort_success", _id_FABF84450735DD93);
    _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_clear_fort_complete", "clear", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_FABF84450735DD93);
    _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_FABF84450735DD93);
    thread scripts\mp\music_and_dialog::_id_F139A00330157E01(scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players"));
  }

  waitframe();
  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_12F03B76F27611E3(_id_FABF84450735DD93) {
  self endon("end_task");
  wait 15;

  for(;;) {
    players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

    foreach(ai in self._id_FFB8DD38BB2FCB3A) {
      _id_35D198C823443318 = undefined;
      _id_636C8575D7A7768B = 1000000000;

      foreach(player in players) {
        _id_DF8E0358F6E2B842 = distance(ai.origin, player.origin);

        if(_id_DF8E0358F6E2B842 < _id_636C8575D7A7768B) {
          _id_636C8575D7A7768B = _id_DF8E0358F6E2B842;
          _id_35D198C823443318 = player;
        }
      }

      if(!isDefined(_id_35D198C823443318)) {
        continue;
      }
      if(!ai cansee(_id_35D198C823443318) && _id_636C8575D7A7768B > 50 && _id_636C8575D7A7768B < 500)
        _id_120270BD0A747A35::_id_A5117518725DA028(ai, _id_35D198C823443318.origin);
    }

    wait 1;
  }
}

_id_CD188BF0ECA0B685() {
  _id_F49C655DB37DA764 = _id_4948CDF739393D2D::_id_AFA1F5BF0DE4E4D1();
  nodes = [];

  if(!isDefined(_id_F49C655DB37DA764))
    return nodes;

  foreach(_id_47E9B099C2D0B060 in _id_F49C655DB37DA764) {
    if(_id_4948CDF739393D2D::_id_4EC4F39A2E1745F2(_id_47E9B099C2D0B060)) {
      continue;
    }
    _id_47E9B099C2D0B060._id_276AC5E84835EA87 = _id_47E9B099C2D0B060;
    nodes[nodes.size] = _id_47E9B099C2D0B060;
  }

  return nodes;
}

_id_C084840561571609() {
  if(!isDefined(self._id_276AC5E84835EA87))
    return undefined;

  _id_CD207438E3E764E6 = level.agentarray;

  if(!isDefined(_id_CD207438E3E764E6) || _id_CD207438E3E764E6.size == 0)
    return undefined;

  _id_DC7F77838B035B27 = [];

  if(self._id_276AC5E84835EA87._id_AA7C37B8B3EC1F46.size == 0)
    return _id_DC7F77838B035B27;

  foreach(guy in _id_CD207438E3E764E6) {
    if(!isalive(guy)) {
      continue;
    }
    foreach(volume in self._id_276AC5E84835EA87._id_AA7C37B8B3EC1F46) {
      if(ispointinvolume(guy.origin, volume))
        _id_DC7F77838B035B27[_id_DC7F77838B035B27.size] = guy;
    }
  }

  return _id_DC7F77838B035B27;
}

_id_872AD260CEF5CB9A() {
  _id_7A896B25AF9482C9 = 0;
  _id_9E249E6FE9F695D5 = [];

  foreach(ai in self._id_FFB8DD38BB2FCB3A) {
    if(!isalive(ai)) {
      _id_9E249E6FE9F695D5[_id_9E249E6FE9F695D5.size] = ai;
      _id_7A896B25AF9482C9++;
    }
  }

  foreach(ai in _id_9E249E6FE9F695D5)
  self._id_FFB8DD38BB2FCB3A = scripts\engine\utility::array_remove(self._id_FFB8DD38BB2FCB3A, ai);

  self._id_6181D0250AFA3CEC = self._id_6181D0250AFA3CEC + _id_7A896B25AF9482C9;
}

_id_B275BDA155C24C12(_id_6181DE250AFA5BB6, agent) {
  if(self._id_6181D0250AFA3CEC >= self._id_65240018A4921EA7 || self._id_FFB8DD38BB2FCB3A.size == 0) {
    if(isDefined(agent)) {
      self._id_AA1ED8F12D71A7A5._id_9D5EBD8DBF54C6AC = agent.origin;
      self._id_AA1ED8F12D71A7A5._id_1DCE29AA33FC1FAA = agent.angles;
    }

    if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team) && isDefined(_id_03314ADD7998AB13::_id_73FD6FE2488E3EBF(self._id_EFA8EF05B190D7D0, _id_6181DE250AFA5BB6.team)) && _id_03314ADD7998AB13::_id_73FD6FE2488E3EBF(self._id_EFA8EF05B190D7D0, _id_6181DE250AFA5BB6.team) == self)
      _id_1432B702120E6711(_id_6181DE250AFA5BB6.team);
    else
      _id_1432B702120E6711();
  }
}

_id_C373F127DAFC389A(team) {
  self endon("end_task");

  for(;;) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");
    _id_4F0FC1C36324AFFB = 100000;
    _id_0FA73C7E2D99FA15 = (0, 0, 0);

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      distsq = distance2dsquared(self._id_276AC5E84835EA87.origin, player.origin);

      if(_id_4F0FC1C36324AFFB > distsq) {
        _id_4F0FC1C36324AFFB = distsq;
        _id_0FA73C7E2D99FA15 = player.origin;
      }
    }

    foreach(volume in self._id_276AC5E84835EA87._id_AA7C37B8B3EC1F46) {
      if(ispointinvolume(_id_0FA73C7E2D99FA15, volume)) {
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("clear_fort_entered", team);
        return;
      }
    }

    wait 1.0;
  }
}