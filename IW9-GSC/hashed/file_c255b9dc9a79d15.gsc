/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_c255b9dc9a79d15.gsc
***********************************************/

_id_FC0A70293A565642(_id_B0FDC80D7BAC5654) {
  players = undefined;
  playerteam = undefined;
  _id_96674628376EABA6 = undefined;

  if(_id_B0FDC80D7BAC5654 == "hunter") {
    players = self._id_579AC64EAFB44D97;
    playerteam = self.hunterteam;
    _id_96674628376EABA6 = self._id_F2AC96E684BA151B;
  }

  if(_id_B0FDC80D7BAC5654 == "target") {
    players = self._id_AFC29C10D530D13E;
    playerteam = self.targetteam;
    _id_96674628376EABA6 = self._id_6CFADE342F01731E;
  }

  if(isDefined(players))
    return players;
  else if(isDefined(playerteam)) {
    if(isDefined(_id_96674628376EABA6))
      return scripts\mp\utility\teams::_id_3D0F2343793D709B(playerteam, _id_96674628376EABA6);
    else
      return scripts\mp\utility\teams::getteamdata(playerteam, "players");
  }

  return [];
}

_id_87AFE756CB5DFDE7(_id_B0FDC80D7BAC5654, _id_1F4E8B926C213A9A) {
  players = _id_FC0A70293A565642(_id_B0FDC80D7BAC5654);
  center = (0, 0, 0);
  validplayers = _id_3ACF1C0EBAF602F2::getvalidplayersinarray(players, _id_1F4E8B926C213A9A);

  if(validplayers.size <= 0)
    return center;

  foreach(player in validplayers)
  center = center + player.origin;

  center = center / validplayers.size;
  return center;
}

_id_9D1C5280F5963C8C(_id_B0FDC80D7BAC5654, _id_AB0F126B12B30E01, params) {
  players = _id_FC0A70293A565642(_id_B0FDC80D7BAC5654);
  _id_3ACF1C0EBAF602F2::displaysplashtoplayers(players, _id_AB0F126B12B30E01, params);
}

_id_6F8E4AD4812F9004(dialog, _id_B0FDC80D7BAC5654, _id_A64CAD1ECC519617, delay, _id_ABB7E1EA2ADCE060, _id_BA850EF48CFDAD1D) {
  players = _id_FC0A70293A565642(_id_B0FDC80D7BAC5654);
  level _id_2CEDCC356F1B9FC8::brleaderdialog(dialog, _id_A64CAD1ECC519617, _id_FC0A70293A565642(_id_B0FDC80D7BAC5654), undefined, delay, _id_ABB7E1EA2ADCE060, _id_BA850EF48CFDAD1D);
}

_id_448F9AF17B797C5A(_id_B0FDC80D7BAC5654, _id_939B8E8818BFD5AE, state, missionid) {
  foreach(player in _id_FC0A70293A565642(_id_B0FDC80D7BAC5654))
  player _id_3ACF1C0EBAF602F2::displaysquadmessagetoplayer(_id_939B8E8818BFD5AE, state, missionid);
}

_id_DAAD346821543E6F(_id_B0FDC80D7BAC5654, _id_1F4E8B926C213A9A) {
  _id_18176E8F61BB2E83 = _id_3ACF1C0EBAF602F2::_validateplayerfilter(_id_1F4E8B926C213A9A);

  foreach(player in _id_FC0A70293A565642(_id_B0FDC80D7BAC5654)) {
    if(_id_3ACF1C0EBAF602F2::_validateplayer(player, _id_18176E8F61BB2E83))
      return 1;
  }

  return 0;
}

_id_9F8AF67E38F19B5D(_id_B0FDC80D7BAC5654, _id_1F4E8B926C213A9A) {
  _id_18176E8F61BB2E83 = _id_3ACF1C0EBAF602F2::_validateplayerfilter(_id_1F4E8B926C213A9A);
  players = [];

  foreach(player in _id_FC0A70293A565642(_id_B0FDC80D7BAC5654)) {
    if(_id_3ACF1C0EBAF602F2::_validateplayer(player, _id_18176E8F61BB2E83))
      players[players.size] = player;
  }

  return players;
}

_id_902F03D6A23A0A45(team, squad, ref) {
  if(scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
    return;
  }
  if(isDefined(level.squaddata) && isDefined(level.squaddata[team])) {
    foreach(player in level.squaddata[team][squad].players)
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE(ref);
  }
}

_id_4A05A71EC50D0D26(team, squad, _id_1F4E8B926C213A9A) {
  _id_18176E8F61BB2E83 = _id_3ACF1C0EBAF602F2::_validateplayerfilter(_id_1F4E8B926C213A9A);
  players = [];

  foreach(player in scripts\mp\utility\teams::_id_3D0F2343793D709B(team, squad)) {
    if(_id_3ACF1C0EBAF602F2::_validateplayer(player, _id_18176E8F61BB2E83))
      players[players.size] = player;
  }

  return players;
}

_id_1143F0B866E4163A(team, squad, _id_18176E8F61BB2E83) {
  center = (0, 0, 0);
  validplayers = _id_4A05A71EC50D0D26(team, squad, _id_18176E8F61BB2E83);

  if(validplayers.size <= 0)
    return center;

  foreach(player in validplayers)
  center = center + player.origin;

  center = center / validplayers.size;
  return center;
}

_id_998E39DBCDAFDDE7(player) {
  hunterteam = player.team;
  _id_F2AC96E684BA151B = player._id_0FF97225579DE16A;
  _id_3B8219D206004DFA = undefined;
  _id_8D18D9F040E35327 = undefined;
  _id_12729FF62E52ED4D = level.players;
  _id_EA7CD2B67D803BC4 = _id_3ACF1C0EBAF602F2::getquestdata("assassination").alltrackedplayers;
  _id_EA7CD5B67D80425D = scripts\mp\utility\teams::getteamdata(hunterteam, "players");
  excludedplayers = scripts\engine\utility::array_combine_unique(_id_EA7CD2B67D803BC4, _id_EA7CD5B67D80425D);
  _id_18176E8F61BB2E83 = level.questinfo.quests["assassination"].filters[0];
  _id_63B9EFF90CD38E5D = 5000;
  _id_877E83278A9F2EAC = 30000;
  _id_EB362CD8AE206E57 = 0;

  while(!isDefined(_id_8D18D9F040E35327)) {
    _id_EB362CD8AE206E57 = _id_EB362CD8AE206E57 + 5000;
    playerlist = scripts\engine\utility::get_array_of_closest(player.origin, _id_12729FF62E52ED4D, excludedplayers, undefined, _id_63B9EFF90CD38E5D + _id_EB362CD8AE206E57, _id_63B9EFF90CD38E5D);
    playerlist = _id_3ACF1C0EBAF602F2::getvalidplayersinarray(playerlist, _id_18176E8F61BB2E83);

    if(!isDefined(playerlist) || playerlist.size == 0) {
      if(_id_EB362CD8AE206E57 > _id_877E83278A9F2EAC) {
        playerlist = scripts\engine\utility::get_array_of_closest(player.origin, _id_12729FF62E52ED4D, excludedplayers, undefined, undefined, undefined);
        playerlist = _id_3ACF1C0EBAF602F2::getvalidplayersinarray(playerlist, _id_18176E8F61BB2E83);

        if(!isDefined(playerlist) || playerlist.size == 0)
          return undefined;
      } else
        continue;
    }

    _id_AD2A19C36030D8B7 = [];
    _id_3A0D4DA4585D5B22 = [];

    foreach(targetplayer in playerlist) {
      _id_AD2A19C36030D8B7[targetplayer._id_0FF97225579DE16A] = _id_4A05A71EC50D0D26(targetplayer.team, targetplayer._id_0FF97225579DE16A, _id_18176E8F61BB2E83).size;
      _id_3A0D4DA4585D5B22[targetplayer._id_0FF97225579DE16A] = targetplayer.team;
    }

    _id_43F1B6BF70E1F1AE = _id_1143F0B866E4163A(hunterteam, _id_F2AC96E684BA151B, _id_18176E8F61BB2E83);
    _id_DAC92862560B89BA = _id_4A05A71EC50D0D26(hunterteam, _id_F2AC96E684BA151B, _id_18176E8F61BB2E83).size;

    foreach(squad, _id_CD51AB4357F76C8C in _id_AD2A19C36030D8B7) {
      if(!isDefined(_id_8D18D9F040E35327)) {
        _id_3B8219D206004DFA = _id_3A0D4DA4585D5B22[squad];
        _id_8D18D9F040E35327 = squad;
        continue;
      }

      _id_2A83DF6C49112D96 = abs(_id_DAC92862560B89BA - _id_CD51AB4357F76C8C);

      if(_id_2A83DF6C49112D96 < abs(_id_DAC92862560B89BA - _id_AD2A19C36030D8B7[_id_8D18D9F040E35327])) {
        _id_3B8219D206004DFA = _id_3A0D4DA4585D5B22[squad];
        _id_8D18D9F040E35327 = squad;
        continue;
      } else if(_id_2A83DF6C49112D96 > abs(_id_DAC92862560B89BA - _id_AD2A19C36030D8B7[_id_8D18D9F040E35327])) {
        continue;
      }
      if(_id_CD51AB4357F76C8C > _id_AD2A19C36030D8B7[_id_8D18D9F040E35327]) {
        _id_3B8219D206004DFA = _id_3A0D4DA4585D5B22[squad];
        _id_8D18D9F040E35327 = squad;
        continue;
      } else if(_id_CD51AB4357F76C8C < _id_AD2A19C36030D8B7[_id_8D18D9F040E35327]) {
        continue;
      }
      _id_3483706CF86EDB31 = _id_1143F0B866E4163A(_id_3A0D4DA4585D5B22[squad], squad, _id_18176E8F61BB2E83);
      _id_2D7861E0BDE6A28A = _id_1143F0B866E4163A(_id_3B8219D206004DFA, _id_8D18D9F040E35327, _id_18176E8F61BB2E83);

      if(distance2d(_id_43F1B6BF70E1F1AE, _id_3483706CF86EDB31) < distance2d(_id_43F1B6BF70E1F1AE, _id_2D7861E0BDE6A28A)) {
        _id_3B8219D206004DFA = _id_3A0D4DA4585D5B22[squad];
        _id_8D18D9F040E35327 = squad;
        continue;
      }
    }
  }

  if(isDefined(_id_8D18D9F040E35327))
    _id_3ACF1C0EBAF602F2::getquestdata("assassination").alltrackedplayers = scripts\engine\utility::array_combine(_id_3ACF1C0EBAF602F2::getquestdata("assassination").alltrackedplayers, scripts\mp\utility\teams::_id_3D0F2343793D709B(_id_3B8219D206004DFA, _id_8D18D9F040E35327));

  return [_id_3B8219D206004DFA, _id_8D18D9F040E35327];
}

_id_CD8A8F4DA6B90EA8(squad, _id_DE16A768392AEEA5) {
  if(!isDefined(_id_DE16A768392AEEA5))
    _id_DE16A768392AEEA5 = 0;

  _id_F6426590C29D7AB0 = 0;

  foreach(player in scripts\mp\utility\teams::_id_3D0F2343793D709B(self.team, squad)) {
    if(istrue(player.hasbettermissionrewards))
      _id_F6426590C29D7AB0++;
  }

  if(!_id_DE16A768392AEEA5 && isDefined(level.questinfo.maxperkbonustier) && isDefined(level.questinfo.maxperkbonustier[squad]))
    _id_F6426590C29D7AB0 = int(min(_id_F6426590C29D7AB0, level.questinfo.maxperkbonustier[squad]));

  return _id_F6426590C29D7AB0;
}

_id_80EB0740DE24AABF(team, player) {
  _id_715028F54BAD19A1::branalytics_missionstart(self, player);
  level.questinfo.teamsonquests = scripts\engine\utility::array_add(level.questinfo.teamsonquests, team);
  level.questinfo._id_05AFA170B3886678 = scripts\engine\utility::array_add(level.questinfo._id_05AFA170B3886678, player._id_0FF97225579DE16A);

  if(!isDefined(level.questinfo.maxperkbonustier))
    level.questinfo.maxperkbonustier = [];

  level.questinfo.maxperkbonustier[player._id_0FF97225579DE16A] = player _id_CD8A8F4DA6B90EA8(player._id_0FF97225579DE16A, 1);
  level notify("quest_started", team);
}

_id_202BBF325055D2C2(category, _id_A705A5A5884EBF9C) {
  foreach(player in _id_FC0A70293A565642("hunter")) {
    if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
      continue;
    }
    _id_591000CB6EF11522 = _id_64ACB6CE534155B7::getquesttableindex(category);
    player scripts\cp_mp\challenges::oncontractstart(_id_591000CB6EF11522, _id_A705A5A5884EBF9C);
  }
}

_id_1E5B12A2032DE6CB() {
  foreach(player in _id_FC0A70293A565642("hunter"))
  player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);

  _id_935C70547A6790A9 = _id_3ACF1C0EBAF602F2::getquestdata(self.category);
  updatefunc = _id_935C70547A6790A9.funcs["onTimerUpdate"];

  if(isDefined(updatefunc))
    [[updatefunc]]();

  thread _id_3ACF1C0EBAF602F2::_questtimerwait();
}

_id_1C69B851009C7518(time, _id_09707FF10D99D386) {
  if(!isDefined(_id_09707FF10D99D386))
    _id_09707FF10D99D386 = 0;

  totaltime = time + _id_09707FF10D99D386;
  _id_935C70547A6790A9 = _id_3ACF1C0EBAF602F2::getquestdata(self.category);

  if(!_id_935C70547A6790A9.usequesttimer) {
    return;
  }
  self.missiontime = gettime() + totaltime * 1000;
  _id_1E5B12A2032DE6CB();
}

_id_A721F329DE58F4C3(hunterteam, _id_F2AC96E684BA151B, targetteam, _id_6CFADE342F01731E, id, player, modifier, rewardscriptable) {
  instance = _id_3ACF1C0EBAF602F2::createquestinstance("assassination", _id_F2AC96E684BA151B, id, rewardscriptable);
  instance.modifier = modifier;

  if(!isDefined(instance.modifier))
    instance.modifier = "";

  instance.hunterteam = hunterteam;
  instance._id_F2AC96E684BA151B = _id_F2AC96E684BA151B;
  instance.targetteam = targetteam;
  instance._id_6CFADE342F01731E = _id_6CFADE342F01731E;
  instance.targets_killed_by_hunters = 0;
  instance.hunters_killed_by_targets = 0;
  instance scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Assassination_Br");
  instance _id_110FD2130C2ED1FE::getnewtargetplayer(player);
  instance._id_AFC29C10D530D13E = instance _id_FC0A70293A565642("target");
  instance._id_579AC64EAFB44D97 = instance _id_FC0A70293A565642("hunter");

  if(!isDefined(instance.targetplayer))
    return undefined;

  instance _id_80EB0740DE24AABF(hunterteam, player);

  if(instance.modifier != "_all")
    instance _id_1C69B851009C7518(_id_3ACF1C0EBAF602F2::getquestdata("assassination").questbasetimer, 4);

  instance _id_110FD2130C2ED1FE::updateassassinationthreatlevel(instance._id_6CFADE342F01731E);
  instance _id_110FD2130C2ED1FE::determineobjectivevisibility();
  _id_3ACF1C0EBAF602F2::addquestinstance("assassination", instance);
  instance _id_202BBF325055D2C2("assassination", player);
  return instance;
}

_id_93833843135C9A25() {
  team = self.hunterteam;
  squad = self._id_F2AC96E684BA151B;

  if(isDefined(level.questinfo.maxperkbonustier))
    level.questinfo.maxperkbonustier[squad] = undefined;

  level.questinfo.teamsonquests = scripts\engine\utility::array_remove(level.questinfo.teamsonquests, team);
  level.questinfo._id_05AFA170B3886678 = scripts\engine\utility::array_remove(level.questinfo._id_05AFA170B3886678, squad);
  _id_3ACF1C0EBAF602F2::getquestdata("assassination").alltrackedplayers = scripts\engine\utility::array_remove_array(_id_3ACF1C0EBAF602F2::getquestdata("assassination").alltrackedplayers, _id_FC0A70293A565642("target"));

  if(isDefined(self.targetplayer))
    self.targetplayer.hasbeentracked = 1;

  _id_89EDDDE3DA46BC8D = _id_3ACF1C0EBAF602F2::getquestrewardtier(team);
  results = [];

  if(isDefined(self.result) && self.result == "success") {
    foreach(player in self.contributingplayers) {
      if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
        continue;
      }
      player.brmissionscompleted = _id_1E4A61DB11011446::get_int_or_0(player.brmissionscompleted) + 1;

      if(level._id_58ADCE74179AB9EF) {
        player scripts\mp\utility\stats::incpersstat("objectivesCompleted", 1);
        player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("missionsCompleted", player scripts\mp\utility\stats::getpersstat("objectivesCompleted"));
      } else
        player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("missionsCompleted", player.brmissionscompleted);

      player scripts\mp\utility\stats::incpersstat("contracts", 1);

      if(!isDefined(player.brmissiontypescompleted))
        player.brmissiontypescompleted = [];

      player.brmissiontypescompleted[self.questcategory] = _id_1E4A61DB11011446::get_int_or_0(player.brmissiontypescompleted[self.questcategory]) + 1;
      player _id_43828ADD0312B6BF::challengeevaluator("br_mastery_fiveContracts");
    }

    if(getdvarint("dvar_82BDE055B11E6698", 0))
      results = _id_3ACF1C0EBAF602F2::givequestrewardsinstance(team, self.rewardorigin, self.rewardangles, self.rewardscriptable, self.contributingplayers);
  }

  if(isDefined(self.result)) {
    _id_A4BC9AD7065C48E9 = scripts\engine\utility::ter_op(self.result == "success", 1, 2);
    _id_1BBEB265EF74BC60 = self.category;

    foreach(player in _id_FC0A70293A565642("hunter")) {
      if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
        continue;
      }
      _id_591000CB6EF11522 = _id_64ACB6CE534155B7::getquesttableindex(self.category);
      player scripts\cp_mp\challenges::oncontractend(_id_591000CB6EF11522, _id_A4BC9AD7065C48E9 == 1, 1);
      player notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    if(isDefined(self._id_6CFADE342F01731E)) {
      _id_C0CBB1ECD0D11AFD = scripts\engine\utility::ter_op(self.result == "success", 2, 1);

      foreach(player in _id_FC0A70293A565642("target")) {
        if(isbot(player) && _id_2CEDCC356F1B9FC8::istutorial()) {
          continue;
        }
        _id_591000CB6EF11522 = _id_64ACB6CE534155B7::getquesttableindex(self.category);
        player scripts\cp_mp\challenges::oncontractend(_id_591000CB6EF11522, _id_C0CBB1ECD0D11AFD == 1, 2);
      }
    }
  }

  _id_50FBEBDD0E036299 = _id_FC0A70293A565642("hunter");
  _id_5E004B0F1C9ABFFB = _id_50FBEBDD0E036299.size;
  _id_715028F54BAD19A1::branalytics_missionend(self, _id_89EDDDE3DA46BC8D, results, _id_5E004B0F1C9ABFFB);
  self notify("questEnded");

  if(isDefined(self.rewardscriptable))
    self.rewardscriptable notify("questEnded", team, self.result);
}