/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1c9fa9bfb0a2fd44.gsc
***********************************************/

_id_FB7271D5EE18B98D(data) {
  if(getdvarint("dvar_2285359FE82B0C32", 0)) {
    data.enabled = 0;
    return;
  }

  level._id_D6AE5CC7B162C730 = spawnStruct();

  if(getdvarint("dvar_ACDC5CE16ECC02D0", 0) != 0)
    level._id_D6AE5CC7B162C730._id_61AB58DC6657120C = getdvarint("dvar_ACDC5CE16ECC02D0", 0);
  else
    level._id_D6AE5CC7B162C730._id_61AB58DC6657120C = _id_64ACB6CE534155B7::_id_B891F0C9814330EB("intel");

  level._id_D6AE5CC7B162C730._id_7F9F1E2EAA06D964 = 0;
  level._id_D6AE5CC7B162C730._id_8F47B7E23761E59B = 21;
  level._id_D6AE5CC7B162C730._id_07383519BDE1C5CE = getdvarint("dvar_D10426D97130E8C6", 17);
  level._id_D6AE5CC7B162C730._id_5F4A68D8FB9F45DD = getdvarint("dvar_045924EAA4893905", 256);
  level._id_D6AE5CC7B162C730._id_F7C654680776AD51 = getdvarfloat("dvar_243CA292CE24D785", 3.0);
  level._id_D6AE5CC7B162C730._id_54950A9B1EFD59AA = getdvarint("dvar_7DD5A957F5239D17", 17716);
  level._id_D6AE5CC7B162C730._id_39974C65A006A4BF = getdvarint("dvar_94DDFBB79F6A4B9D", 9843);
  level._id_D6AE5CC7B162C730._id_336B7F22ECCD99A5 = getdvarint("dvar_F9F88743E5FAC753", 13780);
  level._id_D6AE5CC7B162C730._id_983590DF9B7304D1 = getdvarfloat("dvar_8702BC70726B6D6E", 30.0);
  level._id_D6AE5CC7B162C730._id_4ADA32E3D3F08A0D = getdvarint("dvar_AE75E0C5BCBD4650", 1000);
  level._id_D6AE5CC7B162C730._id_30326E6A2F443451 = level._id_D6AE5CC7B162C730._id_4ADA32E3D3F08A0D * level._id_D6AE5CC7B162C730._id_4ADA32E3D3F08A0D;
  level._id_D6AE5CC7B162C730._id_C7FABBF8BA74055D = getdvarfloat("dvar_B8256B398CFE55DE", 30.0);
  level._id_D6AE5CC7B162C730._id_01949B6E747CA100 = _id_581D908C1D397D4D();
  _id_0C00335A7AEB2728::_id_7828C1AFE3365DD2();
  level thread _id_01D91A7E7CD5C459();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_upload_station", ::_id_C75BD0F88A8E39BE);
  scripts\common\utility::_id_D6B99CCF87941A5A(::_id_C1A7A6A8E7FD451B);
  data.funcs["onInit"] = ::_id_8C64A4F648288A95;
  data.funcs["onShowAgain"] = ::_id_86CFD4337FEDF826;
  data.funcs["onTeamAssigned"] = ::_id_921A0BE9EC330C6A;
  data.funcs["onEnterGulag"] = ::_id_CA07A6CA5C3C8AF5;
  data.funcs["onPlayerRespawn"] = ::_id_F6755BD234F8E261;
  data.funcs["onPlayerKilled"] = ::_id_A2045D8CAF0F792F;
  data.funcs["onPlayerDisconnect"] = ::_id_319BA124F0EC457C;
  data.funcs["onCancel"] = ::_id_AFD4BF63773CD7AD;
  data.funcs["onPlayerTearDown"] = ::_id_83D3732A571F142A;
  data.funcs["onPlayerAssimilated"] = ::_id_75B53AD947495F9C;
  data.funcs["circleTick"] = ::_id_BCDFE083CC8168D7;
  game["dialog"]["mission_intel_success"] = "rnkd_wzan_mssc";
  game["dialog"]["mission_intel_laptop_first_person"] = "rnkd_wzan_plnt";
  game["dialog"]["mission_intel_laptop"] = "rnkd_wzan_tmnt";
  game["dialog"]["mission_intel_upload_first_person"] = "rnkd_wzan_plpl";
  game["dialog"]["mission_intel_upload"] = "rnkd_wzan_tmpl";
}

_id_8C64A4F648288A95() {
  if(!getdvarint("dvar_40174AE61F584D73", 1))
    return 0;

  self._id_265CF6F9F157AD08 = self.tablet _id_5827342A45EAF2AA();

  if(!isDefined(self._id_265CF6F9F157AD08))
    return 0;

  self._id_265CF6F9F157AD08._id_B7718B6E41108129 = scripts\engine\utility::array_add_safe(self._id_265CF6F9F157AD08._id_B7718B6E41108129, self);
  return 1;
}

_id_86CFD4337FEDF826() {
  return 0;
}

_id_921A0BE9EC330C6A() {
  self.category = "intel";
  time = level._id_D6AE5CC7B162C730._id_61AB58DC6657120C;
  _id_64ACB6CE534155B7::uiobjectiveshowtoteam("intel_upload", self.teams[0]);
  time = _id_64ACB6CE534155B7::_id_9B6275085FBCB8F4(time);
  _id_64ACB6CE534155B7::_id_5A15174D34F0670C(time);
  thread _id_6410262ECCC0AB66(time);
  self.domflag = self._id_265CF6F9F157AD08.domflag;
  self._id_B0F4BF8621B96C0A = [];
  self._id_BF7F7683EA10DA26 = ::_id_AA30A0B07502A038;
  _id_206025BFD8717380();

  if(istrue(self._id_265CF6F9F157AD08._id_AFD4C1E75AEE7F02)) {
    self.domflag = self._id_265CF6F9F157AD08.flag;
    self.domflag._id_B7718B6E41108129[self.domflag._id_B7718B6E41108129.size] = self;
  } else {
    thread _id_0C00335A7AEB2728::_id_443A192943945265(self._id_265CF6F9F157AD08, level._id_D6AE5CC7B162C730._id_F7C654680776AD51);
    self._id_265CF6F9F157AD08.domflag scripts\common\utility::_id_57257D1ED9CE2F48(::_id_DA92A1FEF510A088);
  }

  self._id_7BE8B486A10B3DE8 = 0;
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteamexcludeplayer("mission_intel_laptop", self.teams[0], self._id_0D154AC2657C5F44, 1, undefined, 2);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("mission_intel_laptop_first_person", self._id_0D154AC2657C5F44, 1, undefined, 2);
}

_id_CA07A6CA5C3C8AF5(player) {
  if(_id_42A0806457EA8039(player)) {
    if(isDefined(self.objidnum) && self.objidnum != -1)
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objidnum, player);

    self notify("foreceUpdateTeamDistance");
  }
}

_id_F6755BD234F8E261(player) {
  if(_id_42A0806457EA8039(player)) {
    if(isDefined(self.objidnum) && self.objidnum != -1)
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, player);

    self notify("foreceUpdateTeamDistance");
  }
}

_id_A2045D8CAF0F792F(attacker, victim) {
  _id_1274E747E767A78F(victim);
}

_id_319BA124F0EC457C(player) {
  _id_1274E747E767A78F(player);
}

_id_AFD4BF63773CD7AD(team) {
  if(istrue(self.teams[0] == team))
    _id_CD0F560FAD2E9CB6(0);
}

_id_1274E747E767A78F(player) {
  if(player.team == self.teams[0]) {
    if(!_id_3ACF1C0EBAF602F2::isteamvalid(self.teams[0], level._id_41F4BC9EE8C7C9C6.defaultfilter))
      _id_CD0F560FAD2E9CB6(0);
  }
}

_id_83D3732A571F142A(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_8A04AA0E0755E7E3 == self.teams[0]) {
    if(isDefined(self.domflag))
      self.domflag disablescriptableplayeruse(player);

    if(isDefined(self.objidnum) && self.objidnum != -1)
      objective_removeclientfrommask(self.objidnum, player);

    player _id_64ACB6CE534155B7::uiobjectivehide();

    if(!_id_3ACF1C0EBAF602F2::isteamvalid(self.teams[0], level._id_41F4BC9EE8C7C9C6.defaultfilter)) {
      _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");
      _id_0C00335A7AEB2728::_id_1CA101629B43A466(_id_E2B2BBD9E6539F11);

      foreach(player in _id_E2B2BBD9E6539F11)
      self.domflag disablescriptableplayeruse(player);

      thread _id_B61E551AD0E7BAD9(0);
    }
  }
}

_id_75B53AD947495F9C(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  if(_id_EB06B338608EF354 == self.teams[0]) {
    player _id_64ACB6CE534155B7::uiobjectiveshow("intel_upload");

    if(isDefined(self.domflag) && !istrue(self._id_A29978B7F26D9210))
      self.domflag enablescriptableplayeruse(player);

    player setclientomnvar("ui_br_objective_countdown_timer", self.missiontime);

    if(isDefined(self.objidnum) && self.objidnum != -1)
      objective_addclienttomask(self.objidnum, player);
  }
}

_id_BCDFE083CC8168D7(_id_819EDACDACB810E4, _id_52D59C928EB97C81) {
  if(istrue(self._id_DF2A5E89C3BBA966)) {
    return;
  }
  if(isDefined(self._id_265CF6F9F157AD08)) {
    if(!istrue(self._id_A29978B7F26D9210) && !istrue(self._id_265CF6F9F157AD08.domflag.playersintrigger.size > 0)) {
      if(!_id_58F20490049AF6AC::_id_778A4C3D053ED0A9(self._id_265CF6F9F157AD08.origin)) {
        self._id_DF2A5E89C3BBA966 = 1;
        _id_CD0F560FAD2E9CB6(1, "br_intel_quest_obj_circle", "mission_gen_fail");
      }
    }
  }
}

_id_CD0F560FAD2E9CB6(_id_BEF2D73950379FA0, _id_F7B6CC6C062A7A43, _id_A7B676ACA5B263C2) {
  _id_FABF84450735DD93 = self.teams[0];
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_0C00335A7AEB2728::_id_1CA101629B43A466(_id_E2B2BBD9E6539F11);

  foreach(player in _id_E2B2BBD9E6539F11)
  self.domflag disablescriptableplayeruse(player);

  if(istrue(_id_BEF2D73950379FA0)) {
    params = spawnStruct();
    params.intvar = 0;
    _id_64ACB6CE534155B7::displayteamsplash(_id_FABF84450735DD93, _id_F7B6CC6C062A7A43, params);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam(_id_A7B676ACA5B263C2, _id_FABF84450735DD93, 1, 2);
  }

  thread _id_B61E551AD0E7BAD9(0);
}

_id_42A0806457EA8039(player) {
  if(player.team == self.teams[0])
    return 1;

  return 0;
}

_id_AA30A0B07502A038(_id_FABF84450735DD93) {
  _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_0C00335A7AEB2728::_id_1CA101629B43A466(_id_E2B2BBD9E6539F11);
  missionid = _id_64ACB6CE534155B7::getquestindex("intel_upload");
  rewards = _id_64ACB6CE534155B7::_id_D212A5E7A40D7C8D("intel", _id_FABF84450735DD93, self._id_265CF6F9F157AD08);

  if(isDefined(rewards) && isDefined(rewards["plunder"]))
    _id_64ACB6CE534155B7::_id_878EBCC241B54505("br_intel_quest_complete", _id_64ACB6CE534155B7::_id_3D262D56274BD22E("intel"), rewards["plunder"], _id_FABF84450735DD93);

  _id_64ACB6CE534155B7::displaysquadmessagetoteam(_id_FABF84450735DD93, self._id_21280A92D9373B6F, 8, missionid);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_intel_success", _id_FABF84450735DD93, 1, 2);
  _id_90B08876A946FDF5 = anglesToForward(self._id_265CF6F9F157AD08.angles);
  self.rewardorigin = self._id_265CF6F9F157AD08.origin + _id_90B08876A946FDF5 * 20 + (0, 0, -40);
  self.rewardangles = self._id_265CF6F9F157AD08.angles + (0, -100, 0);
  self.result = "success";

  if(getdvarint("dvar_8C8552D204629DDA", 1)) {
    items = getscriptcachecontents("br_intel_drop", level._id_D6AE5CC7B162C730._id_7F9F1E2EAA06D964);
    level._id_D6AE5CC7B162C730._id_7F9F1E2EAA06D964 = level._id_D6AE5CC7B162C730._id_7F9F1E2EAA06D964 + 1;

    if(level._id_D6AE5CC7B162C730._id_7F9F1E2EAA06D964 >= level._id_D6AE5CC7B162C730._id_8F47B7E23761E59B)
      level._id_D6AE5CC7B162C730._id_7F9F1E2EAA06D964 = 0;

    _id_3ACF1C0EBAF602F2::questrewarddropitems(_id_FABF84450735DD93, items, self.rewardorigin, self.rewardangles, 1, 3, 0);
  }

  waitframe();
  thread _id_B61E551AD0E7BAD9(1, rewards);
}

_id_B61E551AD0E7BAD9(_id_0405848C3AE19E65, results) {
  self notify("task_ended");
  self.ended = 1;
  wait 1.0;
  self.objectiveiconid = self.objidnum;
  _id_64ACB6CE534155B7::deletequestobjicon();
  _id_64ACB6CE534155B7::_id_93663FE58D95F174(scripts\engine\utility::ter_op(istrue(_id_0405848C3AE19E65), self.teams[0], undefined), results);
}

_id_6410262ECCC0AB66(time) {
  self endon("task_ended");
  level endon("game_ended");
  wait(time);
  _id_CD0F560FAD2E9CB6(1, "br_intel_quest_timer_expired", "mission_gen_fail");
}

_id_206025BFD8717380() {
  _id_8609CB351C3E80D1 = self._id_265CF6F9F157AD08;
  _id_FABF84450735DD93 = self.teams[0];
  self.curorigin = _id_8609CB351C3E80D1.domflag.origin;
  self.offset3d = (0, 0, 50);
  scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  _id_8609CB351C3E80D1.curorigin = _id_8609CB351C3E80D1.domflag.origin;
  _id_8609CB351C3E80D1.offset3d = (0, 0, 50);
  _id_8609CB351C3E80D1 scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  self.icon = _id_8609CB351C3E80D1.objidnum;
  _id_0A4E5FBEF083C4FF = self._id_265CF6F9F157AD08.domflag.origin + (0, 0, 70);
  _id_C4ABD8BFAC50B27D(_id_FABF84450735DD93, _id_0A4E5FBEF083C4FF);
  _id_8609CB351C3E80D1 _id_C4ABD8BFAC50B27D(_id_FABF84450735DD93, _id_0A4E5FBEF083C4FF);
  scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(self.icon);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("secure_intel_assigned", _id_FABF84450735DD93);
  level thread _id_1E4A61DB11011446::teamsplashbr("br_intel_quest_start_team", self._id_0D154AC2657C5F44, _id_FABF84450735DD93);
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players)
  _id_8609CB351C3E80D1.domflag enablescriptableplayeruse(player);
}

_id_7FFA6D379EA1165D(_id_B44207C85B344031) {
  level endon("game_ended");

  if(isDefined(_id_B44207C85B344031) && _id_B44207C85B344031 > 0)
    wait(_id_B44207C85B344031);

  if(isDefined(self._id_C2FEE681E05824C8))
    self._id_C2FEE681E05824C8 freescriptable();

  self freescriptable();
}

_id_C4ABD8BFAC50B27D(_id_FABF84450735DD93, pos) {
  if(isDefined(self.objidnum) && self.objidnum != -1) {
    objective_icon(self.objidnum, "ui_map_icon_obj_intel");
    objective_position(self.objidnum, pos);
    _id_DA291C5BFE4A2469(_id_FABF84450735DD93, self.objidnum);
    objective_showtoplayersinmask(self.objidnum);
    _func_9427CB5974C925D9(self.objidnum, 1);
    objective_setbackground(self.objidnum, 4);
  }
}

_id_C1A7A6A8E7FD451B(_id_A95A0F321427A749, _id_071947160FFEDB67, _id_7D52B05C966F0D1C) {
  _id_6F52EC16D42ECDAD = [];

  foreach(_id_6AD234DBF4573257 in level._id_D6AE5CC7B162C730._id_01949B6E747CA100) {
    if(_func_335E62799B1A356A(_id_6AD234DBF4573257.origin, _id_A95A0F321427A749, _id_071947160FFEDB67)) {
      if(isDefined(_id_6AD234DBF4573257._id_B7718B6E41108129)) {
        foreach(_id_B8EBE3F71A08AB40 in _id_6AD234DBF4573257._id_B7718B6E41108129) {
          if(isDefined(_id_B8EBE3F71A08AB40.tablet))
            _id_B8EBE3F71A08AB40.tablet thread _id_64ACB6CE534155B7::tablethide(1);
        }
      }

      continue;
    }

    _id_6F52EC16D42ECDAD[_id_6F52EC16D42ECDAD.size] = _id_6AD234DBF4573257;
  }

  level._id_D6AE5CC7B162C730._id_01949B6E747CA100 = _id_6F52EC16D42ECDAD;
}

_id_DA92A1FEF510A088() {
  domflag = self;

  if(isDefined(domflag._id_B7718B6E41108129)) {
    foreach(_id_B8EBE3F71A08AB40 in domflag._id_B7718B6E41108129) {
      if(isDefined(_id_B8EBE3F71A08AB40))
        _id_B8EBE3F71A08AB40 _id_CD0F560FAD2E9CB6(0);
    }
  }

  return 1;
}

_id_DA291C5BFE4A2469(team, objidnum) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      continue;
    }
    if(isDefined(objidnum) && objidnum != -1)
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objidnum, player);
  }
}

_id_581D908C1D397D4D() {
  _id_7626533FB4B71334 = [];

  switch (level.mapname) {
    case "mp_saba":
    case "mp_saba_pm":
    case "mp_saba2":
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((14632, -36913, 1032), (0, 264, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((31114, -27512, 416), (0, 25, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((35576, -16729, 573), (0, 220, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((43723, -2898, 826), (0, 294, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((1844, -29488, 1141), (0, 90, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-2473, -36374, 664), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-22680, -42563, 907), (0, 246, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-14192, -27855, 1123), (0, 93, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-28781, -11631, 1451), (0, 335, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-49670, -14810, 313), (0, 289, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-3969, -11271, 4959), (0, 149, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((17069, -14178, 3045), (0, 241, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((16343, -54703, 1530), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((16670, -861, 290), (0, 252, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-23780, 2603, 3027), (0, 270, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-52088, 5217, 1351), (0, 313, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-7803, 16124, 465), (0, 270, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-28145, 22620, 22), (0, 106, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-902, 35963, 641), (0, 122, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((16467, 25448, 321), (0, 0, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((29864, 12348, 315), (0, 196, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-19292, 37654, -45), (0, 328, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-23490, 46377, 89), (0, 270, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((7904, 46667, 641), (0, 270, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-47006, 22163, 1442), (0, 343, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((27418, 28340, 847), (0, 0, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((23164, 36511, 746), (0, 246, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((16127, 35267, 609), (0, 223, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((5605, 30082, 875), (0, 320, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((5597, 41869, 535), (0, 278, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-8128, 50578, 550), (0, 263, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-8504, 41540, 476), (0, 72, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-15376, 23018, 76), (0, 13, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-5092, 25132, 113), (0, 45, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((5750, 18891, 827), (0, 0, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((26216, 19785, 518), (0, 90, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((19648, 10934, 2068), (0, 90, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((7590, 9246, 844), (0, 127, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((14563, 19084, 633), (0, 0, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((12178, 23967, 1602), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((30144, -414, 759), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((40794, -9333, 940), (0, 295, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-4622, 4321, 906), (0, 15, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-14171, 7020, 730), (0, 315, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-25996, 7943, 2104), (0, 70, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-31969, 8345, 1738), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-39819, 3693, 1062), (0, 45, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-39867, 17263, 114), (0, 130, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-48590, 11723, 858), (0, 220, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-22328, 15455, -420), (0, 195, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-41360, -7413, 982), (0, 198, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-36915, -27468, 522), (0, 113, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-30953, -18671, 730), (0, 288, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-22683, -22178, 842), (0, 270, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-11410, -5510, 1954), (0, 330, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((3430, -3112, 2171), (0, 206, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((25605, -12860, 2187), (0, 343, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((3154, -15985, 3772), (0, 225, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-2465, -22729, 4554), (0, 90, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-34960, 23518, -118), (0, 326, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-48430, -2540, 1042), (0, 52, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-41715, -20043, 634), (0, 19, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-26566, 29753, 702), (0, 15, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-34207, -2256, 2603), (0, 0, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-12088, -14992, 2163), (0, 220, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-31935, -37375, 570), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-26775, -31291, 778), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-15821, -34576, 1038), (0, 270, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-31470, -47479, 617), (0, 75, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-17344, -50396, 572), (0, 267, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-7624, -42117, 800), (0, 133, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((590, -48822, 583), (0, 326, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((11005, -43955, 627), (0, 280, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((12490, -52289, 1042), (0, 225, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((23519, -51487, 914), (0, 150, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((12664, -22905, 1540), (0, 310, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((16525, -24629, 1402), (0, 185, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((24823, -25665, 1090), (0, 30, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((27218, -35106, 690), (0, 115, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((22228, -43290, 774), (0, 115, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((6527, -38162, 278), (0, 225, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-14168, -42988, 1109), (0, 145, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-36106, -14338, 594), (0, 37, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-19732, -12624, 834), (0, 355, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((24680, -5824, 1022), (0, 280, 0)));
      break;
    case "mp_delta_pm":
    case "mp_delta":
      _id_BEA797230FE57651 = scripts\engine\utility::getStructArray("dmz_dom_tower", "script_noteworthy");

      foreach(_id_7A1DB53B7997F1D4 in _id_BEA797230FE57651)
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF(_id_7A1DB53B7997F1D4.origin, _id_7A1DB53B7997F1D4.angles));

      break;
    case "mp_br_mechanics":
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-471, -1886, 58), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((-367, -811, 58), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((704, -2767, 58), (0, 270, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((1970, -4096, 58), (0, 270, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((3077, -2300, 58), (0, 180, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((2935, 59, 58), (0, 0, 0)));
      _id_7626533FB4B71334 = scripts\engine\utility::array_add(_id_7626533FB4B71334, _id_54E178C1343A8CBF((5015, -674, 58), (0, 0, 0)));
      break;
    case "mp_delta_sc":
    case "mp_gulag_blacksite_dev":
      break;
    default:
      break;
  }

  return _id_7626533FB4B71334;
}

_id_54E178C1343A8CBF(origin, angles) {
  _id_48A52C8D018D3159 = spawnStruct();
  _id_48A52C8D018D3159.origin = origin;
  _id_48A52C8D018D3159.angles = angles;
  return _id_48A52C8D018D3159;
}

_id_01D91A7E7CD5C459() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(_id_6AD234DBF4573257 in level._id_D6AE5CC7B162C730._id_01949B6E747CA100) {
    _id_CCD641F9100F73F8 = getgroundposition(_id_6AD234DBF4573257.origin, 1);

    if(!isDefined(_id_6AD234DBF4573257.domflag))
      _id_6AD234DBF4573257.domflag = spawnscriptable("dmz_upload_station", _id_CCD641F9100F73F8, _id_6AD234DBF4573257.angles);

    foreach(player in level.players)
    _id_6AD234DBF4573257.domflag disablescriptableplayeruse(player);

    _id_6AD234DBF4573257.domflag scripts\common\utility::_id_57257D1ED9CE2F48(::_id_DA92A1FEF510A088);
  }
}

_id_5827342A45EAF2AA() {
  level._id_D6AE5CC7B162C730._id_01949B6E747CA100 = scripts\engine\utility::array_randomize(level._id_D6AE5CC7B162C730._id_01949B6E747CA100);
  _id_B88AA9CCEE86B6A3 = undefined;
  _id_06B50C4622758CC3 = level._id_D6AE5CC7B162C730._id_54950A9B1EFD59AA;

  foreach(node in level._id_D6AE5CC7B162C730._id_01949B6E747CA100) {
    dist = distance2d(node.origin, self.origin);

    if(dist > level._id_D6AE5CC7B162C730._id_54950A9B1EFD59AA) {
      continue;
    }
    if(!level.br_circle_disabled) {
      _id_24588C4E37E62333 = 0;
      _id_527A7B84D978E792 = _id_58F20490049AF6AC::_id_60951B84C58915AB(self.origin);
      _id_FDC6EE1B91EBB7BF = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_527A7B84D978E792);

      if(!isDefined(node._id_E1384FF4A85E24E6)) {
        _id_220E66163356B51E = _id_58F20490049AF6AC::_id_60951B84C58915AB(node.origin);
        _id_24588C4E37E62333 = _id_58F20490049AF6AC::_id_7D8550B9A2C52852(_id_220E66163356B51E);
      }

      if(_id_24588C4E37E62333 < _id_FDC6EE1B91EBB7BF) {
        continue;
      }
      _id_42F65B4B53C1F5D4 = dist / 190;
      _id_24588C4E37E62333 = _id_24588C4E37E62333 - _id_42F65B4B53C1F5D4;

      if(_id_24588C4E37E62333 < level._id_D6AE5CC7B162C730._id_C7FABBF8BA74055D)
        continue;
    }

    _id_5435995E95681B89 = 0;

    if(dist < level._id_D6AE5CC7B162C730._id_336B7F22ECCD99A5) {
      if(dist < level._id_D6AE5CC7B162C730._id_39974C65A006A4BF)
        _id_5435995E95681B89 = level._id_D6AE5CC7B162C730._id_39974C65A006A4BF - dist;
    } else
      _id_5435995E95681B89 = dist - level._id_D6AE5CC7B162C730._id_336B7F22ECCD99A5;

    if(_id_5435995E95681B89 < _id_06B50C4622758CC3) {
      _id_06B50C4622758CC3 = _id_5435995E95681B89;
      _id_B88AA9CCEE86B6A3 = node;

      if(_id_5435995E95681B89 <= 0) {
        break;
      }
    }
  }

  return _id_B88AA9CCEE86B6A3;
}

_id_C75BD0F88A8E39BE(instance, part, state, _id_FBA0376E0036DE8D, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  thread _id_0C00335A7AEB2728::_id_A22AC2645C342456(instance, part, state, _id_FBA0376E0036DE8D, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
}

_id_9D25D9397C798607(instance, _id_A6F06CA54F389164) {
  foreach(player in level.players)
  instance disablescriptableplayeruse(player);

  foreach(_id_B8EBE3F71A08AB40 in instance._id_B7718B6E41108129) {
    if(isDefined(_id_A6F06CA54F389164)) {
      if(_id_B8EBE3F71A08AB40.teams[0] == _id_A6F06CA54F389164)
        continue;
    }

    _id_729F88304CD1D6F8 = scripts\mp\utility\teams::getteamdata(_id_B8EBE3F71A08AB40.teams[0], "players");

    foreach(player in _id_729F88304CD1D6F8)
    instance enablescriptableplayeruse(player);
  }
}

_id_9E9A76453CF89412(team, domflag, objidnum) {
  self endon("task_ended");
  level endon("game_ended");
  scripts\mp\objidpoolmanager::objective_set_play_intro(objidnum, 0);

  for(;;) {
    _id_E2B2BBD9E6539F11 = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in _id_E2B2BBD9E6539F11) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
        continue;
      }
      if(isDefined(objidnum) && objidnum != -1)
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objidnum, player);
    }

    foreach(player in domflag.playersintrigger) {
      if(player.team == team)
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(objidnum, player);
    }

    waitframe();
  }
}