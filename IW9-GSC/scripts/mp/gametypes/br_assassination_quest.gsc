/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_assassination_quest.gsc
***********************************************************/

_id_FB7271D5EE18B98D(data) {
  level._id_7E12F6EB4FCB4EA1 = spawnStruct();

  if(getdvarint("dvar_364DCA8E32D958FA", 0) != 0)
    level._id_7E12F6EB4FCB4EA1.time = getdvarint("dvar_364DCA8E32D958FA", 0);
  else
    level._id_7E12F6EB4FCB4EA1.time = _id_64ACB6CE534155B7::_id_B891F0C9814330EB("assassination");

  level._id_7E12F6EB4FCB4EA1._id_987F2ECCF1688B21 = getdvarint("scr_br_asn_min_search_radius", 5000);
  level._id_7E12F6EB4FCB4EA1._id_877E83278A9F2EAC = getdvarint("dvar_C7054640761BE2EF", 30000);
  level._id_7E12F6EB4FCB4EA1._id_8718AEB5B6F8EB16 = getdvarint("dvar_34D149DFDDECFA91", 5000);
  level._id_7E12F6EB4FCB4EA1._id_FDDF856CA727F674 = getdvarint("scr_br_asn_min_plunder", 100000);
  level._id_7E12F6EB4FCB4EA1._id_2A708F42DF785976 = getdvarint("scr_br_asn_circle_range_min", 100);
  level._id_7E12F6EB4FCB4EA1._id_2A938142DF9E8264 = getdvarint("scr_br_asn_circle_range_max", 1000);
  level._id_7E12F6EB4FCB4EA1._id_3BD4A66A02968ECC = getdvarint("dvar_025BA69E846763B6", 1500);
  level._id_7E12F6EB4FCB4EA1._id_5094B22FD45A3EF6 = getdvarint("dvar_DD2F37F5EC580F08", 2000);
  level._id_7E12F6EB4FCB4EA1._id_A3487335038DF794 = getdvarint("scr_br_asn_circle_radius_large", 3500);
  level._id_7E12F6EB4FCB4EA1._id_65DD392CAFAB8111 = getdvarint("dvar_5B3F6111A22668CD", 2500);
  level._id_7E12F6EB4FCB4EA1._id_A12A720226632B47 = getdvarint("dvar_BEFDE6C410585907", 5000);
  level._id_7E12F6EB4FCB4EA1._id_7BE7F4C0BDC1C7B0 = getdvarint("dvar_581D50A4690192AE", 1);
  level._id_7E12F6EB4FCB4EA1._id_0892526141A627E1 = getdvarint("dvar_5746CCD8CB2F6B4F", 1);
  level._id_AAB4FBA7A041B281 = [];
  game["dialog"]["mission_ass_accept"] = "msaa_wzan_mssn";
  game["dialog"]["mission_ass_hunted"] = "msah_wzan_mssn";
  game["dialog"]["mission_ass_success"] = "msas_wzan_mssn";
  game["dialog"]["mission_ass_hunted_success"] = "mahs_wzan_mssn";
  game["dialog"]["mission_ass_hunted_timed_out"] = "maht_wzan_mssn";
  game["dialog"]["mission_ass_hunted_fail"] = "gncn_wzan_msfr";
  game["dialog"]["mission_ass_fail"] = "gncn_wzan_msto";
  data.funcs["onInit"] = ::_id_6E27EE56573D1441;
  data.funcs["onTeamAssigned"] = ::_id_B946C0DB13D4D90E;
  data.funcs["onEnterGulag"] = ::_id_CA07A6CA5C3C8AF5;
  data.funcs["onPlayerRespawn"] = ::_id_F6755BD234F8E261;
  data.funcs["onPlayerKilled"] = ::_id_A2045D8CAF0F792F;
  data.funcs["onPlayerDisconnect"] = ::_id_319BA124F0EC457C;
  data.funcs["onCancel"] = ::_id_AFD4BF63773CD7AD;
  data.funcs["onPlayerTearDown"] = ::_id_83D3732A571F142A;
  data.funcs["onPlayerAssimilated"] = ::_id_75B53AD947495F9C;
  data.funcs["onTargetAssimilated"] = ::_id_DA75EEB9CE2E7700;
  data.funcs["onTargetTeamTearDown"] = ::_id_39D180C28FE14643;
  data.funcs["onTargetTeamAssimilated"] = ::_id_1A1B4D2219442853;
}

_id_45CAD8C5444E638D() {
  if(level._id_7E12F6EB4FCB4EA1._id_7BE7F4C0BDC1C7B0 == 0)
    return 0;

  return istrue(self._id_31D13939F28644D4);
}

_id_6E27EE56573D1441() {
  return 1;
}

_id_B946C0DB13D4D90E() {
  self.category = "assassination";
  _id_86A80A97F4672FC8 = !level.br_circle_disabled && istrue(level._id_2DF69B8E552238B6) && istrue(level._id_B31733F431ED12E0._id_CE4D234D77082447);

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("aq_determineTargetTeam"))
    self.targetteam = _id_362C58E8BB39BCDA::runbrgametypefunc("aq_determineTargetTeam", self._id_0D154AC2657C5F44, _id_86A80A97F4672FC8);
  else
    self.targetteam = determinetargetteam(self._id_0D154AC2657C5F44, _id_86A80A97F4672FC8);

  if(isDefined(self.targetteam)) {
    self.hunterteam = self.teams[0];
    level._id_AAB4FBA7A041B281 = scripts\engine\utility::array_combine(level._id_AAB4FBA7A041B281, scripts\mp\utility\teams::getteamdata(self.targetteam, "players"));
    determinetargetplayer(self.targetteam, self._id_0D154AC2657C5F44);

    if(!isDefined(self.targetplayer)) {
      return;
    }
    scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Assassination_Br");
    determinetrackingcircleposition(self.targetplayer);
    determinetrackingcirclesize();
    thread _id_6CA0A919D228D381();
    thread _id_7B16AC880855A705();
    thread _id_A9B3B9469A7A2746();
    time = level._id_7E12F6EB4FCB4EA1.time;
    time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(time);
    _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time, 0);
    thread _id_D1967972E47F382A(time);
    updateassassinationhud();
    params = spawnStruct();
    params.excludedplayers = [];
    params.excludedplayers[0] = self.targetplayer;

    if(isDefined(self._id_0D154AC2657C5F44))
      params.excludedplayers[1] = self._id_0D154AC2657C5F44;

    params.stringvar = self.targetplayer.name;
    _id_64ACB6CE534155B7::displayteamsplash(self.targetteam, "br_assassination_quest_start_target_team", params);
    _id_64ACB6CE534155B7::displayplayersplash(self.targetplayer, "br_assassination_quest_start_target_player");

    if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_hunted", self.targetteam, 1, 2);

    _id_64ACB6CE534155B7::displayteamsplash(self.hunterteam, "br_assassination_quest_start_hunter_team", params);

    if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_accept", self.hunterteam, 1, 2);

    if(isDefined(self._id_0D154AC2657C5F44)) {
      _id_64ACB6CE534155B7::displayplayersplash(self._id_0D154AC2657C5F44, "br_assassination_quest_start_tablet_finder", params);
      _id_64ACB6CE534155B7::displaysquadmessagetoteam(self.hunterteam, self._id_0D154AC2657C5F44, 6, _id_64ACB6CE534155B7::getquestindex("assassination"));
      return;
    }
  } else {
    self._id_0D154AC2657C5F44 scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassination_notargets", undefined, 5);
    _id_E141356311900568 = spawnStruct();
    _id_E141356311900568.origin = self._id_0D154AC2657C5F44.origin;
    _id_E141356311900568.angles = self._id_0D154AC2657C5F44.angles;
    _id_6B5E1783915835C1 = undefined;
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "health", _id_6B5E1783915835C1);
    _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 2, "ammo", _id_6B5E1783915835C1);
    _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 1, 1, "plunder", _id_6B5E1783915835C1);
    _id_64ACB6CE534155B7::_id_93663FE58D95F174();
  }
}

_id_CA07A6CA5C3C8AF5(player) {
  if(player.team == self.hunterteam)
    scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
  else if(player.team == self.targetteam)
    player hideassassinationtargethud();
}

_id_F6755BD234F8E261(player) {
  if(player.team == self.hunterteam)
    scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
  else if(player.team == self.targetteam)
    player showassassinationtargethud(self.targetplayer, self.threat_level);
}

_id_A2045D8CAF0F792F(attacker, victim) {
  aq_playerremoved(victim);
}

_id_319BA124F0EC457C(player) {
  aq_playerremoved(player);
}

aq_playerremoved(player) {
  if(isDefined(player.team) && player.team == self.hunterteam) {
    if(!_id_3ACF1C0EBAF602F2::isteamvalid(self.hunterteam, level._id_41F4BC9EE8C7C9C6.defaultfilter)) {
      params = spawnStruct();
      params.intvar = 0;
      rewards = _id_64ACB6CE534155B7::_id_6DDD1EECBE562ACF("assassin_averted", self.targetteam, self.targetplayer);

      if(isDefined(rewards) && isDefined(rewards["plunder"])) {
        params.intvar = int(rewards["plunder"]);
        _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_assassination_complete_targets_win", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("assassination"), rewards["plunder"], self.targetteam);
      }

      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_hunted_timed_out", self.targetteam, 1, 2);
      thread _id_AC21667E0F251104(0);
    }
  }
}

_id_AFD4BF63773CD7AD(team) {
  if(istrue(self.teams[0] == team)) {
    if(getdvarint("dvar_339E124F41F186AD", 1) == 1) {
      params = spawnStruct();
      params.intvar = 0;
      rewards = _id_64ACB6CE534155B7::_id_6DDD1EECBE562ACF("assassin_averted", self.targetteam, self.targetplayer);

      if(isDefined(rewards) && isDefined(rewards["plunder"])) {
        params.intvar = int(rewards["plunder"]);
        _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_assassination_complete_targets_win", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("assassination"), rewards["plunder"], self.targetteam);
      }

      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_hunted_timed_out", self.targetteam, 1, 2);
    }

    thread _id_AC21667E0F251104(0);
  }
}

_id_83D3732A571F142A(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_8A04AA0E0755E7E3 == self.teams[0]) {
    player hideassassinationhud(self);

    if(!_id_3ACF1C0EBAF602F2::isteamvalid(self.hunterteam, level._id_41F4BC9EE8C7C9C6.defaultfilter)) {
      rewards = _id_64ACB6CE534155B7::_id_6DDD1EECBE562ACF("assassin_averted", self.targetteam, self.targetplayer);

      if(isDefined(rewards) && isDefined(rewards["plunder"]))
        _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_assassination_complete_targets_win", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("assassination"), rewards["plunder"], self.targetteam);

      level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_hunted_timed_out", self.targetteam, 1, 2);
      thread _id_AC21667E0F251104(0);
    }
  }
}

_id_75B53AD947495F9C(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(!isDefined(self.targetplayer)) {
    return;
  }
  if(self.targetplayer == player) {
    return;
  }
  if(_id_EB06B338608EF354 == self.teams[0]) {
    player showassassinationhud(self);
    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);
  }
}

_id_39D180C28FE14643(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  player hideassassinationtargethud();
}

_id_1A1B4D2219442853(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  player _id_70B452A81A4408D6(self.targetplayer, self.threat_level, self);
}

_id_DA75EEB9CE2E7700(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  player hideassassinationtargethud();
  rewards = undefined;

  if(self.teams[0] != _id_EB06B338608EF354) {
    rewards = _id_64ACB6CE534155B7::_id_6DDD1EECBE562ACF("assassin_target_vanished", self.hunterteam, self._id_0D154AC2657C5F44);

    if(isDefined(rewards) && isDefined(rewards["plunder"]))
      _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_assassination_complete_target_vanished", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("assassination"), rewards["plunder"], self.hunterteam);
  }

  thread _id_AC21667E0F251104(1, rewards);
}

_id_42A0806457EA8039(player) {
  if(player.team == self.teams[0])
    return 1;

  return 0;
}

_id_AC21667E0F251104(success, results) {
  self notify("task_ended");
  level._id_AAB4FBA7A041B281 = scripts\engine\utility::array_remove_array(level._id_AAB4FBA7A041B281, scripts\mp\utility\teams::getteamdata(self.targetteam, "players"));

  if(!scripts\mp\flags::levelflag("game_over"))
    wait 1.0;

  removeallaqui();
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(success), self.teams[0], undefined), results);
}

_id_7B16AC880855A705() {
  self endon("task_ended");

  if(!level._id_7E12F6EB4FCB4EA1._id_0892526141A627E1)
    level endon("game_ended");

  self.targetplayer waittill("death_or_disconnect");
  _id_1B4ADA49A21B51CA = undefined;

  if(isDefined(self.targetplayer.lastkilledby) && isPlayer(self.targetplayer.lastkilledby) && isDefined(self.targetplayer.lastkilledby.team) && self.targetplayer.lastkilledby.team == self.teams[0]) {
    _id_1B4ADA49A21B51CA = "br_assassination_complete_hunters_win";
    _id_FA69571549E78551 = "assassin_target_killed";
    _id_64ACB6CE534155B7::displaysquadmessagetoteam(self.hunterteam, self.targetplayer.lastkilledby, 8, _id_64ACB6CE534155B7::getquestindex("assassination"));
    _id_64ACB6CE534155B7::displayteamsplash(self.targetteam, "br_assassination_target_killed_target_team");
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_hunted_fail", self.targetteam, 1, 2.5);
  } else {
    _id_1B4ADA49A21B51CA = "br_assassination_complete_target_vanished";
    _id_FA69571549E78551 = "assassin_target_vanished";
  }

  params = spawnStruct();
  rewards = _id_64ACB6CE534155B7::_id_6DDD1EECBE562ACF(_id_FA69571549E78551, self.hunterteam, self._id_0D154AC2657C5F44);

  if(isDefined(rewards) && isDefined(rewards["plunder"])) {
    params.intvar = int(rewards["plunder"]);
    _id_64ACB6CE534155B7::_id_878EBCC241B54505(_id_1B4ADA49A21B51CA, _id_64ACB6CE534155B7::_id_3D262D56274BD22E("assassination"), rewards["plunder"], self.hunterteam);
  }

  if(getdvarint("dvar_827F1BF2224B0D61", 0) == 1)
    self._id_0D154AC2657C5F44 _id_64ACB6CE534155B7::_id_496ED653FAACACD2(self.hunterteam);

  if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_success", self.hunterteam, 1, 2);

  thread _id_AC21667E0F251104(1, rewards);
}

_id_A9B3B9469A7A2746() {
  self endon("task_ended");
  level waittill("game_ended");
  waitframe();
  self notify("task_ended");
}

_id_D1967972E47F382A(time) {
  self endon("task_ended");
  level endon("game_ended");
  wait(time);
  params = spawnStruct();
  params.intvar = 0;
  _id_64ACB6CE534155B7::displayteamsplash(self.hunterteam, "br_assassination_timer_expire_hunters_lose", params);
  rewards = _id_64ACB6CE534155B7::_id_6DDD1EECBE562ACF("assassin_averted", self.targetteam, self.targetplayer);

  if(isDefined(rewards) && isDefined(rewards["plunder"])) {
    params.intvar = int(rewards["plunder"]);
    _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_assassination_timer_expire_targets_win", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("assassination"), rewards["plunder"], self.targetteam);
  }

  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_fail", self.hunterteam, 1, 2);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_hunted_timed_out", self.targetteam, 1, 2);
  thread _id_AC21667E0F251104(0);
}

_id_6CA0A919D228D381() {
  self endon("task_ended");
  level endon("game_ended");

  for(;;) {
    determinetrackingcircleposition(self.targetplayer);
    determinetrackingcirclesize();
    updateassassinationthreatlevel(self.targetteam);
    wait 10.0;
  }
}

determinetargetteam(player, _id_86A80A97F4672FC8) {
  hunterteam = player.team;
  _id_3B8219D206004DFA = undefined;
  _id_0774C9CA5D1D6221 = 0;
  _id_12729FF62E52ED4D = level.players;
  _id_EA7CD2B67D803BC4 = level._id_AAB4FBA7A041B281;
  _id_EA7CD5B67D80425D = scripts\mp\utility\teams::getteamdata(hunterteam, "players");
  excludedteams = scripts\engine\utility::array_combine_unique(_id_EA7CD2B67D803BC4, _id_EA7CD5B67D80425D);
  _id_EB362CD8AE206E57 = 0;
  _id_63B9EFF90CD38E5D = level._id_7E12F6EB4FCB4EA1._id_987F2ECCF1688B21;
  _id_877E83278A9F2EAC = level._id_7E12F6EB4FCB4EA1._id_877E83278A9F2EAC;

  while(!isDefined(_id_3B8219D206004DFA)) {
    _id_EB362CD8AE206E57 = _id_EB362CD8AE206E57 + level._id_7E12F6EB4FCB4EA1._id_8718AEB5B6F8EB16;
    _id_64D072985F0A15A5 = scripts\engine\utility::get_array_of_closest(player.origin, _id_12729FF62E52ED4D, excludedteams, undefined, _id_63B9EFF90CD38E5D + _id_EB362CD8AE206E57, _id_63B9EFF90CD38E5D);
    playerlist = [];

    foreach(_id_BD73C7ACC56CD20C in _id_64D072985F0A15A5) {
      if(istrue(_id_86A80A97F4672FC8) && !_id_58F20490049AF6AC::_id_77CEC84F05CA9418(player.origin, _id_BD73C7ACC56CD20C.origin)) {
        continue;
      }
      if(!istrue(_id_BD73C7ACC56CD20C.hasbeentracked) && !_id_BD73C7ACC56CD20C _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && scripts\mp\utility\player::isreallyalive(_id_BD73C7ACC56CD20C) && !_id_BD73C7ACC56CD20C _id_45CAD8C5444E638D() && !_id_BD73C7ACC56CD20C _id_2CEDCC356F1B9FC8::playeriszombie())
        playerlist[playerlist.size] = _id_BD73C7ACC56CD20C;
    }

    if(playerlist.size == 0) {
      if(_id_EB362CD8AE206E57 > _id_877E83278A9F2EAC) {
        _id_64D072985F0A15A5 = scripts\engine\utility::get_array_of_closest(player.origin, _id_12729FF62E52ED4D, scripts\mp\utility\teams::getteamdata(hunterteam, "players"), undefined, undefined, undefined);

        foreach(_id_BD73C7ACC56CD20C in _id_64D072985F0A15A5) {
          if(istrue(_id_86A80A97F4672FC8) && !_id_58F20490049AF6AC::_id_77CEC84F05CA9418(player.origin, _id_BD73C7ACC56CD20C.origin)) {
            continue;
          }
          if(!_id_BD73C7ACC56CD20C _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && scripts\mp\utility\player::isreallyalive(_id_BD73C7ACC56CD20C) && !_id_BD73C7ACC56CD20C _id_2CEDCC356F1B9FC8::playeriszombie())
            playerlist[playerlist.size] = _id_BD73C7ACC56CD20C;
        }

        if(playerlist.size == 0)
          return undefined;
      }
    }

    _id_3A0D4DA4585D5B22 = [];
    _id_90B91D6205FCE07F = 0;
    _id_29F6D200784F77B3 = (0, 0, 0);

    foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(hunterteam, "players")) {
      if(!_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() && scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5)) {
        _id_90B91D6205FCE07F++;
        _id_29F6D200784F77B3 = _id_29F6D200784F77B3 + _id_F0EA4030349A33D5.origin;
      }
    }

    _id_29F6D200784F77B3 = _id_29F6D200784F77B3 / _id_90B91D6205FCE07F;

    foreach(_id_BD73C7ACC56CD20C in playerlist) {
      _id_B54FEA3B6F15223C = 0;

      foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(_id_BD73C7ACC56CD20C.team, "players")) {
        if(!_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5))
          _id_B54FEA3B6F15223C++;
      }

      if(_id_B54FEA3B6F15223C == 0) {
        continue;
      }
      if(!isDefined(_id_3B8219D206004DFA)) {
        _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
        _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
        continue;
      }

      if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
        _id_E6A3E80614FBD020 = _id_6AFF3948CF4CCA03::getteamcarriedplunder(_id_3B8219D206004DFA);
        _id_C237B8FC2586F74F = _id_6AFF3948CF4CCA03::getteamcarriedplunder(_id_BD73C7ACC56CD20C.team);

        if(_id_C237B8FC2586F74F > level._id_7E12F6EB4FCB4EA1._id_FDDF856CA727F674) {
          if(_id_C237B8FC2586F74F > _id_E6A3E80614FBD020) {
            _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
            _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
            continue;
          }
        }
      }

      _id_2A83DF6C49112D96 = abs(_id_90B91D6205FCE07F - _id_0774C9CA5D1D6221);

      if(_id_2A83DF6C49112D96 < abs(_id_90B91D6205FCE07F - _id_B54FEA3B6F15223C)) {
        _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
        _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
        continue;
      } else if(_id_2A83DF6C49112D96 > abs(_id_90B91D6205FCE07F - _id_B54FEA3B6F15223C)) {
        continue;
      }
      if(_id_0774C9CA5D1D6221 > _id_B54FEA3B6F15223C) {
        _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
        _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
        continue;
      } else if(_id_0774C9CA5D1D6221 < _id_B54FEA3B6F15223C) {
        continue;
      }
      _id_0B78E01E4CA8F50A = (0, 0, 0);

      foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(_id_BD73C7ACC56CD20C.team, "players")) {
        if(!_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5))
          _id_0B78E01E4CA8F50A = _id_0B78E01E4CA8F50A + _id_F0EA4030349A33D5.origin;
      }

      _id_0B78E01E4CA8F50A = _id_0B78E01E4CA8F50A / _id_B54FEA3B6F15223C;
      _id_76E3E3800077282F = (0, 0, 0);

      foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(_id_3B8219D206004DFA, "players")) {
        if(!_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5))
          _id_0B78E01E4CA8F50A = _id_0B78E01E4CA8F50A + _id_F0EA4030349A33D5.origin;
      }

      _id_76E3E3800077282F = _id_76E3E3800077282F / _id_B54FEA3B6F15223C;

      if(distance2d(_id_29F6D200784F77B3, _id_0B78E01E4CA8F50A) < distance2d(_id_29F6D200784F77B3, _id_76E3E3800077282F)) {
        _id_3B8219D206004DFA = _id_BD73C7ACC56CD20C.team;
        _id_0774C9CA5D1D6221 = _id_B54FEA3B6F15223C;
        continue;
      }
    }
  }

  return _id_3B8219D206004DFA;
}

determinetargetplayer(targetteam, _id_A9FF06560DA3D11F, _id_86A80A97F4672FC8) {
  _id_6864BEE22874201B = undefined;
  _id_B803EA87ECF23294 = undefined;
  targetplayer = undefined;
  _id_29F6D200784F77B3 = (0, 0, 0);
  _id_90B91D6205FCE07F = 0;
  _id_18A9E17A42F641A4 = 0;

  foreach(_id_F0EA4030349A33D5 in scripts\mp\utility\teams::getteamdata(targetteam, "players")) {
    if(!_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5)) {
      _id_29F6D200784F77B3 = _id_29F6D200784F77B3 + _id_F0EA4030349A33D5.origin;
      _id_90B91D6205FCE07F++;
    }

    if(!_id_F0EA4030349A33D5 _id_45CAD8C5444E638D() && !_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::playeriszombie())
      _id_18A9E17A42F641A4++;
  }

  _id_29F6D200784F77B3 = _id_29F6D200784F77B3 / _id_90B91D6205FCE07F;

  foreach(player in scripts\mp\utility\teams::getteamdata(targetteam, "players")) {
    if(istrue(_id_86A80A97F4672FC8) && !_id_58F20490049AF6AC::_id_77CEC84F05CA9418(player.origin, _id_A9FF06560DA3D11F.origin)) {
      continue;
    }
    if(player _id_2CEDCC356F1B9FC8::isplayeringulag() || !scripts\mp\utility\player::isreallyalive(player) || player _id_2CEDCC356F1B9FC8::playeriszombie()) {
      continue;
    }
    if(_id_18A9E17A42F641A4 > 0 && player _id_45CAD8C5444E638D()) {
      continue;
    }
    if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
      if(scripts\engine\utility::is_equal(player.script_noteworthy, "assassination_target")) {
        targetplayer = player;
        break;
      }
    }

    if(!isDefined(targetplayer))
      targetplayer = player;

    if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
      _id_B3D7D06E99EFD05E = player.plundercount;

      if(isDefined(_id_B3D7D06E99EFD05E)) {
        _id_2CC640C4CF5D3E6A = distance2dsquared(_id_A9FF06560DA3D11F.origin, player.origin);

        if(!isDefined(_id_B803EA87ECF23294) || _id_2CC640C4CF5D3E6A <= _id_B803EA87ECF23294) {
          if(!isDefined(_id_6864BEE22874201B) || _id_B3D7D06E99EFD05E >= _id_6864BEE22874201B) {
            _id_6864BEE22874201B = _id_B3D7D06E99EFD05E;
            _id_B803EA87ECF23294 = _id_2CC640C4CF5D3E6A;
            targetplayer = player;
          }
        }
      }

      continue;
    }

    if(distance2d(_id_29F6D200784F77B3, player.origin) < distance2d(_id_29F6D200784F77B3, targetplayer.origin))
      targetplayer = player;
  }

  targetplayer.hasbeentracked = 0;
  self.targetplayer = targetplayer;
}

determinetrackingcircleposition(targetplayer) {
  search_location = (targetplayer.origin[0], targetplayer.origin[1], level._id_7E12F6EB4FCB4EA1._id_5094B22FD45A3EF6);

  if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    search_location = search_location + scripts\engine\math::random_vector_2d() * randomfloatrange(level._id_7E12F6EB4FCB4EA1._id_2A708F42DF785976, level._id_7E12F6EB4FCB4EA1._id_2A938142DF9E8264);

  scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(search_location);
}

determinetrackingcirclesize() {
  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(level.lootleadermarksize);
    self.threat_level = 2;
  } else {
    _id_579AC64EAFB44D97 = [];

    foreach(player in scripts\mp\utility\teams::getteamdata(self.hunterteam, "players")) {
      if(!player _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(player))
        _id_579AC64EAFB44D97[_id_579AC64EAFB44D97.size] = player;
    }

    if(_id_579AC64EAFB44D97.size == 0) {
      scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(level._id_7E12F6EB4FCB4EA1._id_A3487335038DF794);
      self.threat_level = 0;
    } else {
      _id_42CA41C7DADAE0C0 = undefined;

      foreach(player in _id_579AC64EAFB44D97) {
        dist = distance2d(player.origin, self.targetplayer.origin);

        if(!isDefined(_id_42CA41C7DADAE0C0) || dist < _id_42CA41C7DADAE0C0)
          _id_42CA41C7DADAE0C0 = dist;
      }

      if(_id_42CA41C7DADAE0C0 > level._id_7E12F6EB4FCB4EA1._id_A12A720226632B47) {
        scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(level._id_7E12F6EB4FCB4EA1._id_A3487335038DF794);
        self.threat_level = 0;
        return;
      }

      if(_id_42CA41C7DADAE0C0 > level._id_7E12F6EB4FCB4EA1._id_65DD392CAFAB8111) {
        scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(level._id_7E12F6EB4FCB4EA1._id_5094B22FD45A3EF6);
        self.threat_level = 1;
        return;
      }

      scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(level._id_7E12F6EB4FCB4EA1._id_3BD4A66A02968ECC);
      self.threat_level = 2;
    }
  }
}

determineobjectivevisibility() {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.hunterteam, "players")) {
    _id_1B7F5108008D55B6 = player _id_2CEDCC356F1B9FC8::isplayeringulag();
    _id_4D454E0079090D74 = isDefined(player.aq_hudenabled) && player.aq_hudenabled;

    if(_id_1B7F5108008D55B6 && _id_4D454E0079090D74)
      player hideassassinationhud(self);

    if(!_id_1B7F5108008D55B6 && !_id_4D454E0079090D74)
      player showassassinationhud(self);
  }

  foreach(player in scripts\mp\utility\teams::getteamdata(self.targetteam, "players")) {
    _id_1B7F5108008D55B6 = player _id_2CEDCC356F1B9FC8::isplayeringulag();
    _id_4D454E0079090D74 = isDefined(player.aq_targethudenabled) && player.aq_targethudenabled;

    if(_id_1B7F5108008D55B6 && _id_4D454E0079090D74)
      player hideassassinationtargethud();

    if(!_id_1B7F5108008D55B6 && !_id_4D454E0079090D74)
      player showassassinationtargethud(self.targetplayer, self.threat_level);
  }
}

getnewtargetplayer(_id_A9FF06560DA3D11F) {
  determinetargetplayer(self.targetteam, _id_A9FF06560DA3D11F);
  determinetrackingcircleposition(self.targetplayer);
  determinetrackingcirclesize();
  updateassassinationhud();
}

removeallaqui() {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.hunterteam, "players"))
  player hideassassinationhud(self);

  foreach(player in scripts\mp\utility\teams::getteamdata(self.targetteam, "players"))
  player hideassassinationtargethud();

  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
}

getplayerkills() {
  if(level.br_leaderbystreak)
    return self.killsthislife.size;
  else
    return self.kills;
}

getfilterformodifier(modifier) {
  switch (modifier) {
    case "_all":
    case "_all_timed":
      return level.questinfo.defaultfilter;
    default:
      return 0;
  }
}

showassassinationhud(instance) {
  self.aq_hudenabled = 1;
  _id_64ACB6CE534155B7::uiobjectiveshow("assassination");
  instance scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(self);
}

hideassassinationhud(instance) {
  self.aq_hudenabled = 0;
  _id_64ACB6CE534155B7::uiobjectivehide();
  instance scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(self);
}

updateassassinationthreatlevel(targetteam) {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.targetteam, "players"))
  player _id_64ACB6CE534155B7::_id_19582BA0DBCC0AB0(self.targetplayer, self.threat_level);
}

showassassinationtargethud(targetplayer, threatlevel) {
  self.aq_targethudenabled = 1;
  _id_64ACB6CE534155B7::_id_19582BA0DBCC0AB0(targetplayer, threatlevel);
}

_id_70B452A81A4408D6(targetplayer, threatlevel, _id_B8EBE3F71A08AB40) {
  self.aq_targethudenabled = 1;
  self setclientomnvar("ui_br_assassination_target_timer", _id_B8EBE3F71A08AB40.missiontime);
  _id_64ACB6CE534155B7::_id_19582BA0DBCC0AB0(targetplayer, threatlevel);
}

hideassassinationtargethud() {
  self.aq_targethudenabled = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

updateassassinationhud() {
  foreach(player in scripts\mp\utility\teams::getteamdata(self.hunterteam, "players")) {
    player showassassinationhud(self);
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(player in scripts\mp\utility\teams::getteamdata(self.targetteam, "players")) {
    player showassassinationtargethud(self.targetplayer, self.threat_level);
    player setclientomnvar("ui_br_assassination_target_timer", self.missiontime);
  }
}

gametypeoverrideassassinsearchparams() {
  _id_9254FE14251C6557 = 0;
  gametype = scripts\mp\utility\game::getsubgametype();

  switch (gametype) {
    case "vanilla":
    case "mini_mgl":
    case "mini":
    case "risk":
    case "plunder":
      _id_9254FE14251C6557 = 1;
      break;
  }

  return _id_9254FE14251C6557;
}

_id_5F352FB76C54705C() {
  if(isDefined(level._id_AAB4FBA7A041B281))
    return 0;

  return scripts\engine\utility::array_contains(level._id_AAB4FBA7A041B281, self);
}