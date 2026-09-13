/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_303fd53078a244f1.gsc
***********************************************/

init() {
  level._id_55E0B414E3671F70 = spawnStruct();
  level._id_55E0B414E3671F70._id_9114BFA21B393250 = getdvarint("dvar_018CBDEAAF429CFF", 10000);
  level._id_55E0B414E3671F70._id_BCC631242A5514CB = getdvarint("dvar_F1341F4AA15134F6", 100000);
  level._id_55E0B414E3671F70._id_C2AC96535E5213EA = getdvarint("dvar_547EEA684B2142D7", 2);
  level._id_55E0B414E3671F70._id_A5B0C4131FBA9805 = getdvarint("dvar_EDC7E18F90773ACC", 0);
  level._id_51B3A6E65CAFF0B8 = [];
  level._id_A2B5C48F1D7712FF = [];
}

gethighestscoringteam() {
  _id_C7761B0132ABCFA7 = 0;
  _id_01FF67BA127220E2 = undefined;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_929A6DF466DC4F22 = _getteamscore(_id_F90358454413407F);

    if(!isDefined(_id_01FF67BA127220E2) || _id_929A6DF466DC4F22 > _id_C7761B0132ABCFA7) {
      _id_C7761B0132ABCFA7 = _id_929A6DF466DC4F22;
      _id_01FF67BA127220E2 = _id_F90358454413407F;
      _id_CA17ACB9EA3FA61D = 0;
    }
  }

  return _id_01FF67BA127220E2;
}

_getteamscore(team) {
  level._id_51B3A6E65CAFF0B8[team] = scripts\engine\utility::_id_53C4C53197386572(level._id_51B3A6E65CAFF0B8[team], 0);
  return int(level._id_51B3A6E65CAFF0B8[team]);
}

_id_C3E907F56B24DBD8(player) {
  if(!isDefined(player._id_9356898B6A19A4AC))
    player._id_9356898B6A19A4AC = 0;

  return int(player._id_9356898B6A19A4AC);
}

updateteamscoreplacements() {
  _id_2E2DD5105CE091DC = tablesort(level._id_51B3A6E65CAFF0B8, "down");
  _id_4F7F0599B533DA3C = undefined;
  _id_87AB742859974D26 = 0;
  _id_8ACBB0D8AC1FC9FA = 0;
  placement = 0;
  _id_F441D2DEE6F33B34 = 1;

  foreach(team in _id_2E2DD5105CE091DC) {
    score = level._id_51B3A6E65CAFF0B8[team];

    if(!isDefined(_id_4F7F0599B533DA3C) || score < _id_4F7F0599B533DA3C) {
      _id_4F7F0599B533DA3C = score;
      placement = _id_F441D2DEE6F33B34;
    }

    level._id_A2B5C48F1D7712FF[team] = placement;

    if(score <= _id_4F7F0599B533DA3C)
      _id_F441D2DEE6F33B34++;

    if(placement == 1)
      _id_87AB742859974D26 = _getteamscore(team);
    else if(placement == 2)
      _id_8ACBB0D8AC1FC9FA = _getteamscore(team);

    foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(team, "players")) {
      _id_F0EA4030349A33D5 setclientomnvar("ui_champion_br_team_placement", placement);
      _id_F0EA4030349A33D5 setclientomnvar("ui_br_player_position", placement);
    }
  }

  setomnvar("ui_champion_br_team_score_second", int(_id_8ACBB0D8AC1FC9FA));
  setomnvar("ui_champion_br_team_score_leader", int(_id_87AB742859974D26));
}

_id_A5BA0C4D432F1524(player, score) {
  player setclientomnvar("ui_champion_br_player_score", score);
  player._id_9356898B6A19A4AC = score;
}

_setteamscore(team, score) {
  level._id_51B3A6E65CAFF0B8[team] = score;
  updateteamscoreplacements();

  foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(team, "players"))
  _id_F0EA4030349A33D5 setclientomnvar("ui_champion_br_team_score", score);

  if(!istrue(level._id_9DB23A91B81905C3) && level._id_51B3A6E65CAFF0B8[team] >= level._id_55E0B414E3671F70._id_9114BFA21B393250)
    _id_19633385C373011D::_id_9A61575DE4F3D1EC();

  if(level._id_51B3A6E65CAFF0B8[team] >= level._id_55E0B414E3671F70._id_BCC631242A5514CB && !istrue(self._id_964721CA906C5421))
    _id_19633385C373011D::_id_EC09C585DA4071ED(game["end_reason"]["score_limit_reached"]);
}

_id_8F3C16BF2D2412CB(eventref) {
  self endon("death_or_disconnect");

  if(!isDefined(self._id_2A44575989728111))
    self._id_2A44575989728111 = [];

  foreach(event in self._id_2A44575989728111) {
    if(event.eventref == eventref)
      return;
  }

  taskid = scripts\mp\rank::_id_B2425A8C88E4A460(eventref);

  if(!isDefined(taskid)) {
    if(istrue(self._id_0CB773BB1EAD7836))
      return;
    else
      self._id_0CB773BB1EAD7836 = 1;
  }

  eventdata = spawnStruct();
  eventdata.eventref = eventref;
  eventdata.processedscoreevent = 0;
  eventdata.score = scripts\mp\rank::getscoreinfovalue(eventref);
  self._id_2A44575989728111[self._id_2A44575989728111.size] = eventdata;
  self notify("championEventPreProcess");
  self endon("championEventPreProcess");
  waitframe();

  if(!isDefined(self._id_488ED33E4875A0C1))
    self._id_488ED33E4875A0C1 = [];

  foreach(event in self._id_2A44575989728111)
  self._id_488ED33E4875A0C1[self._id_488ED33E4875A0C1.size] = event;

  self._id_2A44575989728111 = undefined;
  thread _id_3CED6A64B51063F9();
}

_id_3CED6A64B51063F9() {
  self notify("processChampionScoreQueue");
  self endon("processChampionScoreQueue");

  foreach(event in self._id_488ED33E4875A0C1) {
    if(event.processedscoreevent) {
      continue;
    }
    _id_ADB2F998089074A2(event.eventref, event.score);
    event.processedscoreevent = 1;
    wait(getdvarfloat("scr_splash_kill_buffer", 0.3));
  }

  self._id_488ED33E4875A0C1 = undefined;
}

_id_C9A0784E88FCF18D(_id_7148C1A6F25491F8, val) {
  if(_id_7148C1A6F25491F8 == "regular_champion_score_complete")
    self._id_0CB773BB1EAD7836 = 0;
}

_id_ADB2F998089074A2(event, score) {
  taskid = scripts\mp\rank::_id_B2425A8C88E4A460(event);

  if(isDefined(taskid)) {
    _id_9FADE146C7EFC102 = score / 600;

    foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
      if(!isDefined(_id_F0EA4030349A33D5._id_569912475DED8C1C))
        _id_F0EA4030349A33D5._id_569912475DED8C1C = 0;

      if(!isDefined(_id_F0EA4030349A33D5._id_6879BB88396F7AB7))
        _id_F0EA4030349A33D5._id_6879BB88396F7AB7 = 0;

      _id_F0EA4030349A33D5 setclientomnvar("ui_champion_score_event_list_" + _id_F0EA4030349A33D5._id_569912475DED8C1C, int(_id_9FADE146C7EFC102));
      _id_F0EA4030349A33D5 setclientomnvar("ui_champion_score_event_control", _id_F0EA4030349A33D5._id_6879BB88396F7AB7 % 10);
      _id_F0EA4030349A33D5._id_569912475DED8C1C++;
      _id_F0EA4030349A33D5._id_569912475DED8C1C = _id_F0EA4030349A33D5._id_569912475DED8C1C % 5;
      _id_F0EA4030349A33D5._id_6879BB88396F7AB7++;
    }
  } else {
    if(!isDefined(self._id_569912475DED8C1C))
      self._id_569912475DED8C1C = 0;

    if(!isDefined(self._id_6879BB88396F7AB7))
      self._id_6879BB88396F7AB7 = 0;

    self setclientomnvar("ui_champion_score_event_list_" + self._id_569912475DED8C1C, 99);
    self setclientomnvar("ui_champion_score_event_control", self._id_6879BB88396F7AB7 % 10);
    self._id_569912475DED8C1C++;
    self._id_569912475DED8C1C = self._id_569912475DED8C1C % 5;
    self._id_6879BB88396F7AB7++;
  }
}

_id_0366980B6A8796AE(event) {
  _id_E7A7E20EC68138E3 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done");

  if(istrue(level.gameended) || !isDefined(event) || _id_E7A7E20EC68138E3) {
    return;
  }
  score = scripts\mp\rank::getscoreinfovalue(event);

  if(!isDefined(score)) {
    logstring("brChampion_doScoreEvent() with event \"" + _func_0F28FD66285FA2C9(event) + "\", but that event doesn't exist in the gametype's scoreeventlist asset");
    score = 0;
  } else {
    if(istrue(level._id_9DB23A91B81905C3))
      score = score * level._id_55E0B414E3671F70._id_C2AC96535E5213EA;

    if(!scripts\mp\utility\teams::isgameplayteam(self.team)) {
      return;
    }
    _id_A5BA0C4D432F1524(self, _id_C3E907F56B24DBD8(self) + score);
    taskid = scripts\mp\rank::_id_B2425A8C88E4A460(event);

    if(isDefined(taskid)) {
      foreach(_id_B8EBE3F71A08AB40 in level.teamdata[self.team]["taskInfo"]._id_BF3BD069CCF703A8) {
        if(istrue(_id_B8EBE3F71A08AB40._id_B35BD02B951AB0A6)) {
          _setteamscore(self.team, _getteamscore(self.team) + score);
          thread _id_8F3C16BF2D2412CB(event);
          _id_B8EBE3F71A08AB40._id_B35BD02B951AB0A6 = 0;
        }
      }

      return;
    }

    _setteamscore(self.team, _getteamscore(self.team) + score);
    thread _id_8F3C16BF2D2412CB(event);
  }
}