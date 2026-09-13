/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_110fd2130c2ed1fe.gsc
***********************************************/

init() {
  enabled = _id_3ACF1C0EBAF602F2::registerquestcategory("assassination", 1);

  if(!enabled) {
    return;
  }
  _id_3ACF1C0EBAF602F2::registerquestcategorytablevalues("assassination_all");
  _id_3ACF1C0EBAF602F2::registerquestcategorytablevalues("assassination_all_timed");
  level.br_leaderbystreak = getdvarint("dvar_22C4C1F9EFB1DE0A", 0) != 0;
  _id_3ACF1C0EBAF602F2::getquestdata("assassination").questbasetimer = getdvarint("dvar_2F9CD2B10D05E2B3", 180);
  _id_3ACF1C0EBAF602F2::getquestdata("assassination").questbonustimer = getdvarint("dvar_23B6F8F2AF592FC1", 60);
  _id_3ACF1C0EBAF602F2::getquestdata("assassination").resettimeronkill = getdvarint("dvar_B18C855819438FDE", 1);
  _id_3ACF1C0EBAF602F2::registerquestthink("assassination", ::aq_questthink_circleposition, 10);
  _id_3ACF1C0EBAF602F2::registerquestthink("assassination", ::aq_questthink_objectivevisibility, 0.2);
  _id_3ACF1C0EBAF602F2::registerremovequestinstance("assassination", ::aq_removequestinstance);
  _id_3ACF1C0EBAF602F2::registeronplayerkilled("assassination", ::aq_playerdied);
  _id_3ACF1C0EBAF602F2::registeronplayerdisconnect("assassination", ::aq_playerdisconnect);
  _id_2E06828EC179F5BE = scripts\engine\utility::array_add(level.questinfo.defaultfilter, ::filtercondition_hasbeentracked);
  _id_2E06828EC179F5BE = scripts\engine\utility::array_add(level.questinfo.defaultfilter, _id_3ACF1C0EBAF602F2::filtercondition_isdowned);
  _id_3ACF1C0EBAF602F2::registerplayerfilter("assassination", _id_2E06828EC179F5BE, 0);
  _id_3ACF1C0EBAF602F2::questtimerinit("assassination", 1);
  _id_3ACF1C0EBAF602F2::registerontimerupdate("assassination", ::aq_ontimerupdate);
  _id_3ACF1C0EBAF602F2::registerontimerexpired("assassination", ::aq_ontimerexpired);
  _id_3ACF1C0EBAF602F2::getquestdata("assassination").alltrackedplayers = [];
  allassassin_init();
  game["dialog"]["mission_ass_accept"] = "mission_mission_ass_single_accept";
  game["dialog"]["mission_ass_hunted"] = "mission_mission_ass_hunted";
  game["dialog"]["mission_ass_success"] = "mission_mission_ass_single_success";
  game["dialog"]["mission_ass_hunted_success"] = "mission_mission_ass_hunted_success";
  game["dialog"]["mission_ass_hunted_timed_out"] = "mission_mission_ass_hunted_timed_out";
  game["dialog"]["mission_ass_fail"] = "mission_mission_ass_fail";
}

filtercondition_hasbeentracked(player) {
  if(isDefined(player.hasbeentracked) && player.hasbeentracked)
    return 0;

  return 1;
}

aq_questthink_circleposition() {
  if(self.modifier == "_all_timed") {
    return;
  }
  if(!isDefined(self.targetplayer))
    getnewtargetplayer();

  determinetrackingcircleposition(self.targetplayer);
  determinetrackingcirclesize();
  updateassassinationthreatlevel(self.targetteam);
}

aq_questthink_objectivevisibility() {
  if(scripts\mp\utility\game::getsubgametype() != "champion")
    determineobjectivevisibility();
}

aq_removequestinstance() {
  if(istrue(level._id_059C0B24BA708E3C)) {
    _id_0C255B9DC9A79D15::_id_93833843135C9A25();
    removeallaqui();
    return;
  }

  _id_3ACF1C0EBAF602F2::releaseteamonquest(self.hunterteam);
  removeallaqui();
}

takequestitem(pickupent) {
  if(istrue(level._id_059C0B24BA708E3C)) {
    _id_0C255B9DC9A79D15::_id_902F03D6A23A0A45(self.team, self._id_0FF97225579DE16A, "stat_67EB4B642067882A");
    hunterteam = self.team;
    _id_F2AC96E684BA151B = self._id_0FF97225579DE16A;
    besttarget = _id_0C255B9DC9A79D15::_id_998E39DBCDAFDDE7(self);
    instance = undefined;

    if(isDefined(besttarget) && besttarget.size >= 2) {
      targetteam = besttarget[0];
      _id_6CFADE342F01731E = besttarget[1];
      instance = _id_0C255B9DC9A79D15::_id_A721F329DE58F4C3(hunterteam, _id_F2AC96E684BA151B, targetteam, _id_6CFADE342F01731E, pickupent.index, self, "", pickupent);
    }
  } else {
    _id_3ACF1C0EBAF602F2::giveteampoints(self.team, "stat_67EB4B642067882A");
    hunterteam = self.team;
    targetteam = determinetargetteam(self);
    instance = givequest(hunterteam, targetteam, pickupent.index, self, "", pickupent);
  }

  if(!isDefined(instance)) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassination_notargets", undefined, 5);
    _id_E141356311900568 = spawnStruct();
    _id_E141356311900568.origin = pickupent.origin;
    _id_E141356311900568.angles = pickupent.angles;
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
      _id_6B5E1783915835C1 = "mp/loot_set_cache_contents_dmz.csv";
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "health", _id_6B5E1783915835C1);
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 2, "ammo", _id_6B5E1783915835C1);
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 1, 1, "plunder", _id_6B5E1783915835C1);
    } else {
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "health");
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 2, "ammo");
      _id_E141356311900568 _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 1, 1, "plunder");
    }

    return;
  }

  instance givequestsplash(self);
}

givequestsplash(_id_6006E8173093C1E4) {
  params = spawnStruct();
  params.excludedplayers = [];
  params.excludedplayers[0] = self.targetplayer;

  if(isDefined(_id_6006E8173093C1E4))
    params.excludedplayers[1] = _id_6006E8173093C1E4;

  params.stringvar = self.targetplayer.name;
  _id_0C255B9DC9A79D15::_id_9D1C5280F5963C8C("target", "br_assassination_quest_start_target_team", params);
  _id_3ACF1C0EBAF602F2::displayplayersplash(self.targetplayer, "br_assassination_quest_start_target_player");

  if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    thread _id_0C255B9DC9A79D15::_id_6F8E4AD4812F9004("mission_ass_hunted", "target", 1);

  params.plundervar = _id_3ACF1C0EBAF602F2::getquestplunderrewardinstance(_id_3ACF1C0EBAF602F2::getquestrewardtier(self.hunterteam));
  _id_0C255B9DC9A79D15::_id_9D1C5280F5963C8C("hunter", "br_assassination_quest_start_hunter_team", params);

  if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    thread _id_0C255B9DC9A79D15::_id_6F8E4AD4812F9004("mission_ass_accept", "hunter", 1);

  if(isDefined(_id_6006E8173093C1E4)) {
    _id_3ACF1C0EBAF602F2::displayplayersplash(_id_6006E8173093C1E4, "br_assassination_quest_start_tablet_finder", params);
    _id_0C255B9DC9A79D15::_id_448F9AF17B797C5A("hunter", _id_6006E8173093C1E4, 6, _id_3ACF1C0EBAF602F2::getquestindex("assassination"));
  }
}

givequest(hunterteam, targetteam, id, player, modifier, rewardscriptable) {
  instance = _id_3ACF1C0EBAF602F2::createquestinstance("assassination", hunterteam, id, rewardscriptable);
  instance.modifier = modifier;

  if(!isDefined(instance.modifier))
    instance.modifier = "";

  instance _id_3ACF1C0EBAF602F2::registerteamonquest(hunterteam, player);
  instance.hunterteam = hunterteam;
  instance.targetteam = targetteam;
  instance.targets_killed_by_hunters = 0;
  instance.hunters_killed_by_targets = 0;
  instance.targetteamremaining = 0;

  if(isDefined(targetteam))
    instance.targetteamremaining = instance _id_3ACF1C0EBAF602F2::getvalidplayersinteam(targetteam).size;

  if(!isDefined(instance.targetteam)) {
    cancelgivequest(instance);
    return undefined;
  }

  if(instance.modifier != "_all")
    instance _id_3ACF1C0EBAF602F2::questtimerset(_id_3ACF1C0EBAF602F2::getquestdata("assassination").questbasetimer, 4);

  instance scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Assassination_Br");
  instance getnewtargetplayer(player);

  if(!isDefined(instance.targetplayer)) {
    cancelgivequest(instance);
    return undefined;
  }

  if(instance.modifier == "_all_timed")
    level.teamdata[hunterteam]["hasFailed"] = 0;

  instance determinetrackingcircleposition(instance.targetplayer);
  instance determinetrackingcirclesize();
  instance updateassassinationthreatlevel(instance.targetteam);

  if(scripts\mp\utility\game::getsubgametype() == "champion")
    level notify("quest_objective_updated_" + hunterteam, instance);
  else
    instance determineobjectivevisibility();

  _id_3ACF1C0EBAF602F2::addquestinstance("assassination", instance);
  _id_3ACF1C0EBAF602F2::startteamcontractchallenge("assassination", player, hunterteam);
  return instance;
}

cancelgivequest(instance) {
  instance scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  instance.result = "no_locale";

  if(istrue(level._id_059C0B24BA708E3C))
    instance _id_0C255B9DC9A79D15::_id_93833843135C9A25();
  else
    instance _id_3ACF1C0EBAF602F2::releaseteamonquest(instance.hunterteam);
}

determinetargetteam(player) {
  hunterteam = player.team;
  _id_3B8219D206004DFA = undefined;
  _id_12729FF62E52ED4D = level.players;
  _id_EA7CD2B67D803BC4 = _id_3ACF1C0EBAF602F2::getquestdata("assassination").alltrackedplayers;
  _id_EA7CD5B67D80425D = scripts\mp\utility\teams::getteamdata(hunterteam, "players");
  excludedteams = scripts\engine\utility::array_combine_unique(_id_EA7CD2B67D803BC4, _id_EA7CD5B67D80425D);
  _id_EB362CD8AE206E57 = 0;
  _id_18176E8F61BB2E83 = level.questinfo.quests["assassination"].filters[0];
  _id_63B9EFF90CD38E5D = 5000;
  _id_877E83278A9F2EAC = 30000;

  if(gametypeoverrideassassinsearchparams()) {
    _id_63B9EFF90CD38E5D = level.quest_assdistmin;
    _id_877E83278A9F2EAC = level.quest_assdistmax;
  }

  while(!isDefined(_id_3B8219D206004DFA)) {
    _id_EB362CD8AE206E57 = _id_EB362CD8AE206E57 + 5000;
    playerlist = scripts\engine\utility::get_array_of_closest(player.origin, _id_12729FF62E52ED4D, excludedteams, undefined, _id_63B9EFF90CD38E5D + _id_EB362CD8AE206E57, _id_63B9EFF90CD38E5D);
    playerlist = _id_3ACF1C0EBAF602F2::getvalidplayersinarray(playerlist, _id_18176E8F61BB2E83);

    if(!isDefined(playerlist) || playerlist.size == 0) {
      if(_id_EB362CD8AE206E57 > _id_877E83278A9F2EAC) {
        playerlist = scripts\engine\utility::get_array_of_closest(player.origin, _id_12729FF62E52ED4D, excludedteams, undefined, undefined, undefined);
        playerlist = _id_3ACF1C0EBAF602F2::getvalidplayersinarray(playerlist, _id_18176E8F61BB2E83);

        if(!isDefined(playerlist) || playerlist.size == 0)
          return undefined;
      } else
        continue;
    }

    _id_3A0D4DA4585D5B22 = [];

    foreach(targetplayer in playerlist)
    _id_3A0D4DA4585D5B22[targetplayer.team] = _id_3ACF1C0EBAF602F2::getvalidplayersinteam(targetplayer.team, _id_18176E8F61BB2E83).size;

    _id_29F6D200784F77B3 = _id_3ACF1C0EBAF602F2::getteamcenter(hunterteam, _id_18176E8F61BB2E83);
    _id_90B91D6205FCE07F = _id_3ACF1C0EBAF602F2::getvalidplayersinteam(hunterteam, _id_18176E8F61BB2E83).size;

    foreach(team, _id_0774C9CA5D1D6221 in _id_3A0D4DA4585D5B22) {
      if(!isDefined(_id_3B8219D206004DFA)) {
        _id_3B8219D206004DFA = team;
        continue;
      }

      if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
        _id_E6A3E80614FBD020 = _id_6AFF3948CF4CCA03::getteamcarriedplunder(_id_3B8219D206004DFA);
        _id_C237B8FC2586F74F = _id_6AFF3948CF4CCA03::getteamcarriedplunder(team);

        if(_id_C237B8FC2586F74F > 100000) {
          if(_id_C237B8FC2586F74F > _id_E6A3E80614FBD020) {
            _id_3B8219D206004DFA = team;
            continue;
          }
        }
      }

      _id_2A83DF6C49112D96 = abs(_id_90B91D6205FCE07F - _id_0774C9CA5D1D6221);

      if(_id_2A83DF6C49112D96 < abs(_id_90B91D6205FCE07F - _id_3A0D4DA4585D5B22[_id_3B8219D206004DFA])) {
        _id_3B8219D206004DFA = team;
        continue;
      } else if(_id_2A83DF6C49112D96 > abs(_id_90B91D6205FCE07F - _id_3A0D4DA4585D5B22[_id_3B8219D206004DFA])) {
        continue;
      }
      if(_id_0774C9CA5D1D6221 > _id_3A0D4DA4585D5B22[_id_3B8219D206004DFA]) {
        _id_3B8219D206004DFA = team;
        continue;
      } else if(_id_0774C9CA5D1D6221 < _id_3A0D4DA4585D5B22[_id_3B8219D206004DFA]) {
        continue;
      }
      _id_0B78E01E4CA8F50A = _id_3ACF1C0EBAF602F2::getteamcenter(team, _id_18176E8F61BB2E83);
      _id_76E3E3800077282F = _id_3ACF1C0EBAF602F2::getteamcenter(_id_3B8219D206004DFA, _id_18176E8F61BB2E83);

      if(distance2d(_id_29F6D200784F77B3, _id_0B78E01E4CA8F50A) < distance2d(_id_29F6D200784F77B3, _id_76E3E3800077282F)) {
        _id_3B8219D206004DFA = team;
        continue;
      }
    }
  }

  if(isDefined(_id_3B8219D206004DFA))
    _id_3ACF1C0EBAF602F2::getquestdata("assassination").alltrackedplayers = scripts\engine\utility::array_combine(_id_3ACF1C0EBAF602F2::getquestdata("assassination").alltrackedplayers, scripts\mp\utility\teams::getteamdata(_id_3B8219D206004DFA, "players"));

  return _id_3B8219D206004DFA;
}

determinetargetplayer(targetteam, _id_A9FF06560DA3D11F) {
  _id_6864BEE22874201B = undefined;
  _id_B803EA87ECF23294 = undefined;
  targetplayer = undefined;
  _id_29F6D200784F77B3 = _id_0C255B9DC9A79D15::_id_87AFE756CB5DFDE7("hunter");

  foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("target")) {
    if(!_id_3ACF1C0EBAF602F2::isplayervalid(player, getfilterformodifier(self.modifier))) {
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
  search_location = (targetplayer.origin[0], targetplayer.origin[1], getcirclesize());

  if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    search_location = search_location + scripts\engine\math::random_vector_2d() * randomfloatrange(getcirclerangemin(), getcirclerangemax());

  scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(search_location);
}

determinetrackingcirclesize() {
  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(level.lootleadermarksize);
    self.threat_level = 2;
  } else {
    _id_579AC64EAFB44D97 = _id_0C255B9DC9A79D15::_id_9F8AF67E38F19B5D("hunter");

    if(_id_579AC64EAFB44D97.size == 0) {
      scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(3500);
      self.threat_level = 0;
    } else {
      _id_42CA41C7DADAE0C0 = undefined;

      foreach(player in _id_579AC64EAFB44D97) {
        dist = distance2d(player.origin, self.targetplayer.origin);

        if(!isDefined(_id_42CA41C7DADAE0C0) || dist < _id_42CA41C7DADAE0C0)
          _id_42CA41C7DADAE0C0 = dist;
      }

      if(_id_42CA41C7DADAE0C0 > 5000) {
        scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(3500);
        self.threat_level = 0;
        return;
      }

      if(_id_42CA41C7DADAE0C0 > 2500) {
        scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(2000);
        self.threat_level = 1;
        return;
      }

      scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(1500);
      self.threat_level = 2;
    }
  }
}

determineobjectivevisibility() {
  foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("hunter")) {
    _id_1B7F5108008D55B6 = player _id_2CEDCC356F1B9FC8::isplayeringulag();
    _id_4D454E0079090D74 = isDefined(player.aq_hudenabled) && player.aq_hudenabled;

    if(_id_1B7F5108008D55B6 && _id_4D454E0079090D74)
      player hideassassinationhud(self);

    if(!_id_1B7F5108008D55B6 && !_id_4D454E0079090D74)
      player showassassinationhud(self);
  }

  foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("target")) {
    _id_1B7F5108008D55B6 = player _id_2CEDCC356F1B9FC8::isplayeringulag();
    _id_4D454E0079090D74 = isDefined(player.aq_targethudenabled) && player.aq_targethudenabled;

    if(_id_1B7F5108008D55B6 && _id_4D454E0079090D74)
      player hideassassinationtargethud();

    if(!_id_1B7F5108008D55B6 && !_id_4D454E0079090D74)
      player showassassinationtargethud(self.targetplayer, self.threat_level);
  }
}

aq_ontimerupdate() {
  foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("target"))
  player setclientomnvar("ui_br_assassination_target_timer", self.missiontime);

  if(self.modifier == "_all_timed")
    thread assassinationtimewarning();
}

aq_ontimerexpired() {
  if(self.modifier == "_all_timed") {
    scripts\mp\utility\teams::setteamdata(self.targetteam, "hasFailed", 1);
    allassassin_timeout_end(self.hunterteam);
    _id_3ACF1C0EBAF602F2::removequestinstance();
  } else {
    _id_0C255B9DC9A79D15::_id_9D1C5280F5963C8C("hunter", "br_assassination_timer_expire_hunters_lose");
    rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(self.targetteam);
    reward = _id_3ACF1C0EBAF602F2::getquestplunderreward("assassination", rewardtier);
    self.rewardmodifier = "_averted";
    params = spawnStruct();
    missionid = _id_3ACF1C0EBAF602F2::getquestindex("assassination");
    _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_3ACF1C0EBAF602F2::getquestrewardbuildgroupref("assassination", self.rewardmodifier, self.modifier));
    params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
    _id_0C255B9DC9A79D15::_id_9D1C5280F5963C8C("target", "br_assassination_timer_expire_targets_win", params);
    thread _id_0C255B9DC9A79D15::_id_6F8E4AD4812F9004("mission_ass_fail", "hunter", 1);
    thread _id_0C255B9DC9A79D15::_id_6F8E4AD4812F9004("mission_ass_hunted_timed_out", "target", 1);

    if(getDvar("dvar_7611A2790A0BF7FE", "") != "plunder" && getDvar("dvar_7611A2790A0BF7FE", "") != "risk")
      _id_3ACF1C0EBAF602F2::givequestrewardsinstance(self.targetteam, self.targetplayer.origin, self.targetplayer.angles, self.rewardscriptable, _id_0C255B9DC9A79D15::_id_FC0A70293A565642("target"));
  }
}

aq_playerdied(attacker, victim) {
  if(victim _id_2CEDCC356F1B9FC8::isplayeringulag() || attacker _id_2CEDCC356F1B9FC8::isplayeringulag()) {
    return;
  }
  thread aq_playerremoved(victim, attacker);
}

aq_playerdisconnect(_id_345221032955C106) {
  thread aq_playerremoved(_id_345221032955C106);
}

aq_playerremoved(_id_A1A07F4BC10BF84C, attacker) {
  if(self.modifier == "_all_timed" && scripts\mp\utility\teams::getteamdata(self.hunterteam, "hasFailed")) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    if(!isbot(_id_A1A07F4BC10BF84C))
      return;
  }

  if(_id_A1A07F4BC10BF84C.team == self.targetteam) {
    if(_id_A1A07F4BC10BF84C == self.targetplayer) {
      _id_FB0ECE5F482AFF3E = _id_A1A07F4BC10BF84C.attackers;
      wait 0.75;
      params = spawnStruct();
      rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(self.hunterteam);
      missionid = _id_3ACF1C0EBAF602F2::getquestindex("assassination");

      if(isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.hunterteam) {
        _id_1B4ADA49A21B51CA = "br_assassination_complete_hunters_win";
        self.rewardmodifier = "_target_killed";
        _id_0C255B9DC9A79D15::_id_448F9AF17B797C5A("hunter", attacker, 8, _id_3ACF1C0EBAF602F2::getquestindex("assassination"));

        if(isDefined(level._id_52781BE0B4E8A959))
          level[[level._id_52781BE0B4E8A959]](attacker.team);

        if(scripts\mp\utility\game::getsubgametype() == "rumble_mgl")
          level notify("assassination_quest_completed", attacker.team, attacker._id_0FF97225579DE16A);
      } else {
        _id_1B4ADA49A21B51CA = "br_assassination_complete_target_vanished";
        self.rewardmodifier = "_target_vanished";
      }

      _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_3ACF1C0EBAF602F2::getquestrewardbuildgroupref("assassination", self.rewardmodifier, self.modifier));
      params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
      _id_0C255B9DC9A79D15::_id_9D1C5280F5963C8C("hunter", _id_1B4ADA49A21B51CA, params);

      if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
        _id_0C255B9DC9A79D15::_id_6F8E4AD4812F9004("mission_ass_success", "hunter", 1);

      self.rewardorigin = _id_A1A07F4BC10BF84C.origin;
      self.rewardangles = _id_A1A07F4BC10BF84C.angles;

      if(isDefined(_id_FB0ECE5F482AFF3E)) {
        foreach(_id_01602D6431533BDC in _id_FB0ECE5F482AFF3E) {
          if(isDefined(_id_01602D6431533BDC.team) && _id_01602D6431533BDC.team == self.hunterteam)
            _id_3ACF1C0EBAF602F2::registercontributingplayers(_id_01602D6431533BDC);
        }
      }

      self.result = "success";
      _id_3ACF1C0EBAF602F2::removequestinstance();
    }

    if(self.modifier == "_all_timed") {
      if(!isDefined(level.gulag) || isDefined(level.gulag) && !istrue(level.gulag.shutdown)) {
        foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("hunter")) {
          if(istrue(player.inlaststand))
            player scripts\mp\laststand::finishreviveplayer("use_hold_revive_success", player);

          if(!isalive(player)) {
            player _id_7E52B56769FA7774::addrespawntoken(1);
            player thread _id_67708F418B1FAC79::playergulagautowin("aq");
          }
        }
      }
    }
  } else if(_id_A1A07F4BC10BF84C.team == self.hunterteam) {
    if(!_id_0C255B9DC9A79D15::_id_DAAD346821543E6F("hunter", getfilterformodifier(self.modifier))) {
      if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk") {
        self.result = "fail";
        _id_3ACF1C0EBAF602F2::removequestinstance();
      } else {
        self.rewardmodifier = "_averted";
        rewards = _id_3ACF1C0EBAF602F2::givequestrewardsinstance(self.targetteam, _id_A1A07F4BC10BF84C.origin, _id_A1A07F4BC10BF84C.angles, self.rewardscriptable, _id_0C255B9DC9A79D15::_id_FC0A70293A565642("target"));
        params = spawnStruct();
        params.plundervar = _id_1E4A61DB11011446::get_int_or_0(rewards["plunder"]);
        _id_0C255B9DC9A79D15::_id_9D1C5280F5963C8C("target", "br_assassination_complete_targets_win", params);
        self.result = "fail";
        _id_3ACF1C0EBAF602F2::removequestinstance();
      }
    }
  }
}

getnewtargetplayer(_id_A9FF06560DA3D11F) {
  determinetargetplayer(self.targetteam, _id_A9FF06560DA3D11F);
  determinetrackingcircleposition(self.targetplayer);
  determinetrackingcirclesize();
  updateassassinationhud();
}

removeallaqui() {
  foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("hunter"))
  player hideassassinationhud(self);

  foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("target"))
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
  _id_3ACF1C0EBAF602F2::uiobjectiveshow("assassination" + instance.modifier);
  instance scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(self);
}

hideassassinationhud(instance) {
  self.aq_hudenabled = 0;
  _id_3ACF1C0EBAF602F2::uiobjectivehide();
  instance scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(self);
}

updateassassinationdataomnvar(targetplayer, threatlevel) {
  if(isDefined(self.aq_targethudenabled) && self.aq_targethudenabled)
    entitynumber = targetplayer getentitynumber();
  else
    entitynumber = -1;

  entitynumber = targetplayer getentitynumber();
  entitynumber = entitynumber + 1;
  value = threatlevel << 8 | entitynumber;
  self setclientomnvar("ui_br_assassination_target", value);
}

updateassassinationthreatlevel(targetteam) {
  foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("target"))
  player updateassassinationdataomnvar(self.targetplayer, self.threat_level);
}

showassassinationtargethud(targetplayer, threatlevel) {
  self.aq_targethudenabled = 1;
  updateassassinationdataomnvar(targetplayer, threatlevel);
}

hideassassinationtargethud() {
  self.aq_targethudenabled = 0;
  self setclientomnvar("ui_br_assassination_target", 0);
}

updateassassinationhud() {
  foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("hunter")) {
    player showassassinationhud(self);
    player _id_3ACF1C0EBAF602F2::uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(player in _id_0C255B9DC9A79D15::_id_FC0A70293A565642("target"))
  player showassassinationtargethud(self.targetplayer, self.threat_level);
}

assassinationtimewarning() {
  self notify("assassinationTimeWarning");
  self endon("assassinationTimeWarning");
  self endon("removed");
  _id_C5CB4A18BBD39719 = [300, 240, 180, 120, 90, 60, 30, 10];

  foreach(time in _id_C5CB4A18BBD39719) {
    _id_D57A5431D4F9D54E = (self.missiontime - gettime()) / 1000;
    _id_3777ECE6A73EADA5 = _id_D57A5431D4F9D54E - time;

    if(_id_3777ECE6A73EADA5 < 0) {
      continue;
    }
    wait(_id_3777ECE6A73EADA5);
    _id_3C59120EE220BF08 = int(time / 60);
    _id_7FAC5B3FFF459084 = _id_3ACF1C0EBAF602F2::getvalidplayersinarray(_id_0C255B9DC9A79D15::_id_FC0A70293A565642("hunter"), getfilterformodifier(self.modifier));

    foreach(player in _id_7FAC5B3FFF459084) {
      endtime = gettime() + time * 1000;
      _id_E6932C067E0B2E71 = 5;

      if(time <= 20)
        _id_E6932C067E0B2E71 = time;

      player scripts\mp\utility\lower_message::setlowermessageomnvar("br_assassin_mission_time_warning", endtime, _id_E6932C067E0B2E71);

      if(_id_3C59120EE220BF08 >= 2) {
        player iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_MIN", _id_3C59120EE220BF08);
        continue;
      }

      player iprintlnbold(&"MP_BR_INGAME/MISSION_ASSASSIN_2_TIME_WARNING_SEC", time);
    }
  }
}

allassassin_init() {
  level thread allassassin_givewait();
}

allassassin_givewait() {
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_5159F960A67ED33B = getdvarint("dvar_4D250E4873E1753E", 0);

  if(!_id_5159F960A67ED33B) {
    return;
  }
  waittime = getdvarint("dvar_35C40B91DCC26B01", 120);
  disableteamkillrewards();
  wait(waittime);
  allassassin_give(_id_5159F960A67ED33B);
}

allassassin_give(_id_5159F960A67ED33B) {
  info = spawnStruct();
  info.teamlist = [];
  info.lastmissionendtime = [];
  info.resttimems = int(getdvarfloat("dvar_E2DF198F0E15683C", 10) * 1000);

  if(_id_5159F960A67ED33B == 1)
    info.modifier = "_all";
  else if(_id_5159F960A67ED33B == 2)
    info.modifier = "_all_timed";
  else {}

  if(info.modifier == "_all_timed")
    info allassassin_initteamlist_timed();
  else
    info allassassin_initteamlist();

  info thread allassassin_applyquest();
  info thread allassassin_updatewait();
}

allassassin_getsortedteams() {
  _id_B04EF87F1A902F58 = (0, 0, 0);
  teams = allassassin_teams();
  _id_E0D75123860C4962 = [];

  foreach(team in teams) {
    leader = undefined;
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in _id_A6AB8D0FDA441DC2) {
      if(player _id_2CEDCC356F1B9FC8::isplayeringulag()) {
        continue;
      }
      if(player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader()) {
        leader = player;
        break;
      }

      if(!isDefined(leader))
        leader = player;
    }

    if(!isDefined(leader)) {
      continue;
    }
    _id_6B06FC1CF05DC054 = spawnStruct();
    _id_6B06FC1CF05DC054.team = team;
    _id_6B06FC1CF05DC054.pos = leader.origin;
    _id_B04EF87F1A902F58 = _id_B04EF87F1A902F58 + _id_6B06FC1CF05DC054.pos;
    _id_E0D75123860C4962[_id_E0D75123860C4962.size] = _id_6B06FC1CF05DC054;
  }

  if(_id_E0D75123860C4962.size < 2)
    return _id_E0D75123860C4962;

  _id_B04EF87F1A902F58 = _id_B04EF87F1A902F58 / _id_E0D75123860C4962.size;

  foreach(_id_6B06FC1CF05DC054 in _id_E0D75123860C4962) {
    dir = _id_6B06FC1CF05DC054.pos - _id_B04EF87F1A902F58;
    _id_6B06FC1CF05DC054.sortvalue = vectortoangles(dir)[1];
  }

  _id_E0D75123860C4962 = scripts\mp\utility\script::quicksort(_id_E0D75123860C4962, ::allassassin_teamcompare);
  return _id_E0D75123860C4962;
}

allassassin_initteamlist() {
  _id_E0D75123860C4962 = allassassin_getsortedteams();
  _id_62EFCD976FE84759 = getdvarint("dvar_285C13782C4ED68F", 150);
  _id_7F494A77CF41CCB7 = _id_E0D75123860C4962.size;

  if(isDefined(_id_62EFCD976FE84759))
    _id_62EFCD976FE84759 = int(min(_id_62EFCD976FE84759, _id_7F494A77CF41CCB7));
  else
    _id_62EFCD976FE84759 = _id_7F494A77CF41CCB7;

  _id_3AEA174D1DA06F4F = int(_id_7F494A77CF41CCB7 / _id_62EFCD976FE84759);
  _id_F246834464C55D65 = _id_7F494A77CF41CCB7 % _id_62EFCD976FE84759;
  _id_7DA84E0B1BD4815E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3AEA174D1DA06F4F; _id_AC0E594AC96AA3A8++)
    _id_7DA84E0B1BD4815E[_id_AC0E594AC96AA3A8] = _id_62EFCD976FE84759;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F246834464C55D65; _id_AC0E594AC96AA3A8++)
    _id_7DA84E0B1BD4815E[_id_AC0E594AC96AA3A8 % _id_3AEA174D1DA06F4F]++;

  count = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7DA84E0B1BD4815E.size; _id_AC0E594AC96AA3A8++) {
    _id_62EFCD976FE84759 = _id_7DA84E0B1BD4815E[_id_AC0E594AC96AA3A8];

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_62EFCD976FE84759; _id_AC0E5C4AC96AAA41++) {
      team = _id_E0D75123860C4962[count + _id_AC0E5C4AC96AAA41].team;
      _id_D4145D9E255225DC = wrapindex(_id_AC0E5C4AC96AAA41 - 1, _id_62EFCD976FE84759);
      next = wrapindex(_id_AC0E5C4AC96AAA41 + 1, _id_62EFCD976FE84759);
      targetedby = _id_E0D75123860C4962[count + _id_D4145D9E255225DC].team;
      targeting = _id_E0D75123860C4962[count + next].team;
      _id_DB62C0CFC8A661CC = spawnStruct();
      _id_DB62C0CFC8A661CC.targetedby = targetedby;
      _id_DB62C0CFC8A661CC.targeting = targeting;
      self.teamlist[team] = _id_DB62C0CFC8A661CC;
    }

    count = count + _id_62EFCD976FE84759;
  }
}

allassassin_initteamlist_timed() {
  maxdist = getdvarfloat("dvar_F4E01D5AB43ECD85", 10000);
  _id_E0D75123860C4962 = allassassin_getsortedteams();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E0D75123860C4962.size; _id_AC0E594AC96AA3A8++) {
    hunterteam = _id_E0D75123860C4962[_id_AC0E594AC96AA3A8].team;

    if(isDefined(self.teamlist[hunterteam])) {
      continue;
    }
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_E0D75123860C4962.size - 1; _id_AC0E5C4AC96AAA41++) {
      if(_id_AC0E5C4AC96AAA41 % 2)
        offset = int(-0.5 * _id_AC0E5C4AC96AAA41 - 0.5);
      else
        offset = int(0.5 * _id_AC0E5C4AC96AAA41 + 1);

      _id_8F632E019EAD6A8B = wrapindex(_id_AC0E594AC96AA3A8 + offset, _id_E0D75123860C4962.size);
      targetteam = _id_E0D75123860C4962[_id_8F632E019EAD6A8B].team;

      if(isDefined(self.teamlist[targetteam])) {
        continue;
      }
      targetpos = _id_E0D75123860C4962[_id_8F632E019EAD6A8B].pos;
      _id_1A840FBA6C86AE3F = _id_E0D75123860C4962[_id_AC0E594AC96AA3A8].pos;

      if(distance(targetpos, _id_1A840FBA6C86AE3F) > maxdist) {
        continue;
      }
      _id_925B356F96C01616 = spawnStruct();
      _id_925B356F96C01616.targetedby = targetteam;
      _id_925B356F96C01616.targeting = targetteam;
      self.teamlist[hunterteam] = _id_925B356F96C01616;
      _id_1494FC5165320C85 = spawnStruct();
      _id_1494FC5165320C85.targetedby = hunterteam;
      _id_1494FC5165320C85.targeting = hunterteam;
      self.teamlist[targetteam] = _id_1494FC5165320C85;
      break;
    }
  }
}

allassassin_teams() {
  time = gettime();
  teams = [];

  foreach(team, data in level.teamdata) {
    if(isDefined(self.teamlist[team])) {
      continue;
    }
    lastmissionendtime = self.lastmissionendtime[team];

    if(isDefined(lastmissionendtime) && time < lastmissionendtime + self.resttimems) {
      continue;
    }
    if(!_id_3ACF1C0EBAF602F2::isteamvalid(team, getfilterformodifier(self.modifier))) {
      continue;
    }
    teams[teams.size] = team;
  }

  return teams;
}

allassassin_oninstanceremoved(instance) {
  instance waittill("removed");
  self.lastmissionendtime[instance.hunterteam] = gettime();
  self notify("update");
}

allassassin_updatewait() {
  _id_E9D45F780D45651F = getdvarint("dvar_8292C07ABD783B9B", 10);

  for(;;) {
    scripts\engine\utility::waittill_notify_or_timeout("update", _id_E9D45F780D45651F);

    if(self.modifier == "_all_timed") {
      allassassin_update_timed();
      continue;
    }

    allassassin_update();
  }
}

allassassin_update_timed() {
  _id_A489651F714E2632 = [];

  foreach(team, _id_368AE33CB19F91F8 in self.teamlist) {
    if(!isDefined(level.questinfo.quests["assassination"].instances[team]))
      _id_A489651F714E2632[_id_A489651F714E2632.size] = team;
  }

  foreach(team in _id_A489651F714E2632)
  self.teamlist[team] = undefined;

  allassassin_initteamlist_timed();
  allassassin_applyquest();
}

allassassin_update() {
  _id_A489651F714E2632 = [];

  foreach(team, _id_368AE33CB19F91F8 in self.teamlist) {
    if(!isDefined(level.questinfo.quests["assassination"].instances[team])) {
      if(_id_368AE33CB19F91F8.targeting == _id_368AE33CB19F91F8.targetedby)
        _id_A489651F714E2632[_id_A489651F714E2632.size] = team;
    }
  }

  foreach(team in _id_A489651F714E2632)
  self.teamlist[team] = undefined;

  _id_F17A683B71E14AB7 = allassassin_teams();
  _id_D94FD49D5E466DAE = _id_F17A683B71E14AB7.size;
  _id_A489651F714E2632 = [];

  foreach(team, _id_368AE33CB19F91F8 in self.teamlist) {
    if(!_id_3ACF1C0EBAF602F2::isteamvalid(team, getfilterformodifier(self.modifier))) {
      if(_id_D94FD49D5E466DAE > 0) {
        _id_D94FD49D5E466DAE--;
        _id_27ECED4B9943A2DD = _id_F17A683B71E14AB7[_id_D94FD49D5E466DAE];
        self.teamlist[_id_27ECED4B9943A2DD] = spawnStruct();
        self.teamlist[_id_27ECED4B9943A2DD].targeting = _id_368AE33CB19F91F8.targeting;
        self.teamlist[_id_27ECED4B9943A2DD].targetedby = _id_368AE33CB19F91F8.targetedby;
        self.teamlist[_id_368AE33CB19F91F8.targetedby].targeting = _id_27ECED4B9943A2DD;
        self.teamlist[_id_368AE33CB19F91F8.targeting].targetedby = _id_27ECED4B9943A2DD;
      } else {
        self.teamlist[_id_368AE33CB19F91F8.targetedby].targeting = _id_368AE33CB19F91F8.targeting;
        self.teamlist[_id_368AE33CB19F91F8.targeting].targetedby = _id_368AE33CB19F91F8.targetedby;
      }

      _id_A489651F714E2632[_id_A489651F714E2632.size] = team;
    }
  }

  foreach(team in _id_A489651F714E2632)
  self.teamlist[team] = undefined;

  if(_id_D94FD49D5E466DAE >= 2) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D94FD49D5E466DAE; _id_AC0E594AC96AA3A8++) {
      team = _id_F17A683B71E14AB7[_id_AC0E594AC96AA3A8];
      _id_D4145D9E255225DC = wrapindex(_id_AC0E594AC96AA3A8 - 1, _id_D94FD49D5E466DAE);
      next = wrapindex(_id_AC0E594AC96AA3A8 + 1, _id_D94FD49D5E466DAE);
      targetedby = _id_F17A683B71E14AB7[_id_D4145D9E255225DC];
      targeting = _id_F17A683B71E14AB7[next];
      _id_DB62C0CFC8A661CC = spawnStruct();
      _id_DB62C0CFC8A661CC.targetedby = targetedby;
      _id_DB62C0CFC8A661CC.targeting = targeting;
      self.teamlist[team] = _id_DB62C0CFC8A661CC;
    }
  }

  if(self.teamlist.size < 2) {
    return;
  }
  allassassin_applyquest();
}

allassassin_applyquest() {
  foreach(team, _id_368AE33CB19F91F8 in self.teamlist) {
    if(isDefined(level.questinfo.quests["assassination"].instances[team])) {
      continue;
    }
    _id_A9FF06560DA3D11F = team;
    target = _id_368AE33CB19F91F8.targeting;
    id = "all_" + _id_A9FF06560DA3D11F + "_" + target;
    instance = givequest(_id_A9FF06560DA3D11F, target, id, undefined, self.modifier);

    if(isDefined(instance)) {
      instance givequestsplash();

      if(self.modifier == "_all_timed")
        instance thread allassassin_updatecircle();

      thread allassassin_oninstanceremoved(instance);
    }
  }
}

allassassin_updatecircle() {
  self endon("removed");
  _id_80D667631E622EA2 = getdvarfloat("dvar_5052E7021A993BB7", 10);
  _id_68C8CDB264CBD6DF = getdvarfloat("dvar_60DD91FCD2553058", 1.0);

  for(;;) {
    aq_questthink_circleposition();
    determinetrackingcircleposition(self.targetplayer);
    frac = getquesttimefrac();
    _id_3777ECE6A73EADA5 = _id_80D667631E622EA2 - _id_68C8CDB264CBD6DF;
    wait(_id_3777ECE6A73EADA5 * frac + _id_68C8CDB264CBD6DF);
  }
}

allassassin_teamcompare(left, right) {
  return left.sortvalue <= right.sortvalue;
}

allassassin_timeout_end(team) {
  _id_EBF3DC022ECCFE21 = _id_3ACF1C0EBAF602F2::getvalidplayersinarray(scripts\mp\utility\teams::getteamdata(team, "players"));

  foreach(player in _id_EBF3DC022ECCFE21) {
    if(isalive(player))
      player kill(player.origin, player);
  }

  _id_3ACF1C0EBAF602F2::displayteamsplash(team, "br_assassination_timer_expire_hunters_lose");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_ass_fail", team, 1);
}

wrapindex(index, _id_B3720D45E34D6FBB) {
  return (index % _id_B3720D45E34D6FBB + _id_B3720D45E34D6FBB) % _id_B3720D45E34D6FBB;
}

disableteamkillrewards() {
  _id_3ACF1C0EBAF602F2::getquestdata("assassination").disableteamrewards = 1;
}

disableplayerkillrewards() {
  _id_3ACF1C0EBAF602F2::getquestdata("assassination").disableplayerrewards = 1;
}

checkifteamrewardsareenabled() {
  return isDefined(_id_3ACF1C0EBAF602F2::getquestdata("assassination").disableteamrewards) && _id_3ACF1C0EBAF602F2::getquestdata("assassination").disableteamrewards;
}

checkifplayerrewardsareenabled() {
  return isDefined(_id_3ACF1C0EBAF602F2::getquestdata("assassination").disableplayerrewards) && _id_3ACF1C0EBAF602F2::getquestdata("assassination").disableplayerrewards;
}

getquesttimefrac() {
  _id_89CAD6E3DA206570 = _id_3ACF1C0EBAF602F2::getquestdata("assassination").questbasetimer;
  timeremaining = (self.missiontime - gettime()) / 1000;
  frac = clamp(timeremaining / _id_89CAD6E3DA206570, 0.0, 1.0);
  return frac;
}

getcirclesize() {
  if(self.modifier == "_all_timed") {
    _id_2D901C509015E202 = getdvarfloat("dvar_05DFB0EEF997D40F", 3000.0);
    _id_9B491929F64DD317 = getdvarfloat("dvar_1BE2F04AD5C56C28", 200.0);
    frac = getquesttimefrac();
    _id_3777ECE6A73EADA5 = _id_2D901C509015E202 - _id_9B491929F64DD317;
    return _id_3777ECE6A73EADA5 * frac + _id_9B491929F64DD317;
  } else
    return 2000;
}

getcirclerangemin() {
  if(self.modifier == "_all_timed")
    return 0;
  else
    return 100;
}

getcirclerangemax() {
  if(self.modifier == "_all_timed") {
    _id_6E831C5902E07B4C = getcirclesize();
    return _id_6E831C5902E07B4C * 0.5;
  } else
    return 900;
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
  quests = _id_3ACF1C0EBAF602F2::getquestdata("assassination");

  if(!isDefined(quests))
    return 0;

  foreach(instance in quests.instances) {
    if(instance.targetteam == self.team)
      return 1;
  }

  return 0;
}