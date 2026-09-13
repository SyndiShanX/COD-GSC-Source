/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\plea_for_help.gsc
***********************************************/

init() {
  _id_362C58E8BB39BCDA::enablefeature("pleaForHelp");
  _id_CC0D5A1E8A904E5C = scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isEnabled")]]();
  level.laststand = scripts\mp\tweakables::gettweakablevalue("player", "laststand");
  setomnvar("ui_last_stand_type", level.laststand);
  level._id_1A52552BE0B92C9B = getdvarint("dvar_CAAA48448A7F3558", 0) == 1;
  scripts\cp_mp\utility\script_utility::registersharedfunc("pleaForHelp", "isEnabled", ::_id_4DB915A9CE0E903A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pleaForHelp", "callForHelp", ::_id_F70FCDBFFBB4AA73);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pleaForHelp", "isPleading", ::_id_C1E2F014739D7903);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pleaForHelp", "UpdatePlayerPleaForAll", ::_id_91BCAF0C98ECFB81);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pleaForHelp", "deletePleasFromTeam", ::_id_F6457A70C99155DC);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_6BDC6F56944DC3AA);
  _id_451A1A9BD9613164::_id_8ECE37593311858A(::_id_DDBDC83E53B603F7);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerrespawn);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("plea_request", ::_id_4E60EA7D6C5AB305);
  level._id_DBBD13CC9AD757C1 = spawnStruct();
  level._id_DBBD13CC9AD757C1._id_30DB13447A236F3A = 0;
  level._id_DBBD13CC9AD757C1._id_807FFB67240349F5 = [];
  level._id_DBBD13CC9AD757C1._id_7FF3973C2AD05964 = getdvarint("dvar_009CCE9B50F7EED8", 10000);
  level._id_DBBD13CC9AD757C1._id_FCCAEA57406D9937 = getdvarint("dvar_7D0B9F953D90D2E1", 1);
  level._id_DBBD13CC9AD757C1._id_A8F396F44DF1C126 = getdvarint("dvar_71770D1190C57088", 300);
  level._id_DBBD13CC9AD757C1._id_5A0820C3017C65A6 = getdvarint("dvar_BA3DC3C4D745F037", 24);
  level._id_DBBD13CC9AD757C1._id_07836C12F19DD2C3 = getdvarint("dvar_F1E1A5ED455C1600", 2);
  level._id_DBBD13CC9AD757C1._id_AFDD97402F873F1E = getdvarfloat("dvar_329CD90CFDDD2497", 0.5);
  level._id_DBBD13CC9AD757C1._id_0AB651CB230F0D65 = getdvarint("dvar_04D7861BBE97A0C2", 1);
  level._id_DBBD13CC9AD757C1._id_B1A743CA97F7690E = getdvarint("dvar_523A07040487FF3E", 30);
  level._id_DBBD13CC9AD757C1._id_504FA7A88BA40E41 = getdvarint("dvar_40AD1DD5F4A4F9E2", 0);
  thread _id_BA1CBFC640DA6557();
}

_id_DDBDC83E53B603F7() {
  self._id_5A6BEC925741FEE3 = 0;
  _id_5CCCB32072A43854(0);
}

_id_4DB915A9CE0E903A() {
  if(!_id_3FF084F114B7F6C9::_id_6934349B7823D888())
    return 0;

  if(!isDefined(level._id_5E3E13175C48C44A))
    level._id_5E3E13175C48C44A = getdvarint("dvar_B682A9C77AF06B57", 1);

  return istrue(level._id_5E3E13175C48C44A);
}

_id_DBBD13CC9AD757C1(origin, _id_15AB90A8DE6865AA) {
  if(!istrue(level._id_DBBD13CC9AD757C1._id_0AB651CB230F0D65))
    _id_15AB90A8DE6865AA _id_2E673B4C90CD35FB();

  _id_496AAA68C40AEB44 = _id_1144DEA4D6D6E575(origin, _id_15AB90A8DE6865AA);
  _id_496AAA68C40AEB44 _id_C9E6FCD7831F36AF(origin);
  _id_15AB90A8DE6865AA thread _id_E163B2023BA2BFC6(origin);
}

_id_AD29F2CDC94AAC3B() {
  return level._id_DBBD13CC9AD757C1._id_7FF3973C2AD05964;
}

_id_4FB04DB192FBF4DA(player) {
  return scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isPlayersAssimDisabled") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isPlayersAssimDisabled")]](self) && !istrue(level._id_DBBD13CC9AD757C1._id_30DB13447A236F3A);
}

_id_BFDFD3C9BA0CC7CB(player) {
  if(!isDefined(level._id_DBBD13CC9AD757C1) || istrue(level._id_DBBD13CC9AD757C1._id_30DB13447A236F3A))
    return 0;

  if(istrue(player.squadwiped) && !getdvarint("dvar_A5BFCE6C742AA583", 1))
    return 0;

  if(!istrue(player._id_C4C8B91E0B16AA5E))
    return 0;

  if(!_id_4FB04DB192FBF4DA(player))
    return 0;

  if(player._id_5A6BEC925741FEE3 >= level._id_DBBD13CC9AD757C1._id_FCCAEA57406D9937)
    return 0;

  if(level._id_DBBD13CC9AD757C1._id_807FFB67240349F5.size >= level._id_DBBD13CC9AD757C1._id_5A0820C3017C65A6)
    return 0;

  if(_id_1174ABEDBEFE9ADA::_id_076EF3C8B8171D2D(player.origin))
    return 0;

  return 1;
}

_id_C1E2F014739D7903(player) {
  return _id_4DB915A9CE0E903A() && isDefined(_id_C069F41A6BC4A19A(player));
}

_id_C069F41A6BC4A19A(player) {
  if(!isDefined(player))
    return undefined;

  index = player getentitynumber();

  if(isDefined(index))
    return level._id_DBBD13CC9AD757C1._id_807FFB67240349F5[index];

  return undefined;
}

_id_31097CF0C8F08654() {
  if(istrue(level._id_DBBD13CC9AD757C1._id_30DB13447A236F3A)) {
    return;
  }
  level._id_DBBD13CC9AD757C1._id_30DB13447A236F3A = 1;

  foreach(_id_496AAA68C40AEB44 in level._id_DBBD13CC9AD757C1._id_807FFB67240349F5) {
    if(!isDefined(_id_496AAA68C40AEB44)) {
      continue;
    }
    _id_496AAA68C40AEB44 thread _id_B5341D976F6C944D();
  }
}

_id_BA1CBFC640DA6557() {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_2("gulag_closed", "dmz_radiation_started");
  _id_31097CF0C8F08654();
}

_id_F70FCDBFFBB4AA73() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self endon("br_team_fully_eliminated");
  _id_5CCCB32072A43854(0);
  self._id_7C813E50FF75BE27 = undefined;
  scripts\mp\killcam::_id_7A8A04D15AD052D5();

  if(!_id_BFDFD3C9BA0CC7CB(self)) {
    return;
  }
  _id_5CCCB32072A43854(1);
  _id_6E9F9801408856F8 = isbot(self) && _id_E2AED369E0BAC150();
  _id_BA7E8AD2868EF874 = ["spawned", "plea_deleted", "plea_created", "br_team_fully_eliminated", "plea_eliminated"];
  self _meth_BC667001F9DD3808(self.origin);
  scripts\mp\utility\player::_id_BBF44D52CA2820CD("request_plea_kbm", "activate", ::_id_D9AE2A812E5EE454, undefined, _id_BA7E8AD2868EF874, 4, ::_id_52273A4095C18970, "kbm_only", _id_6E9F9801408856F8);
  scripts\mp\utility\player::_id_BBF44D52CA2820CD("request_plea_gamepad", "actionslot 2", ::_id_D9AE2A812E5EE454, undefined, _id_BA7E8AD2868EF874, 4, ::_id_52273A4095C18970, "gamepad_only");
}

_id_52273A4095C18970(_id_4F0C2C3538662F1B, progress, iscomplete) {
  _id_C0DD862E5087634C = !iscomplete && progress == 0;

  if(self._id_36C1DC28EDF11BED == 1 && progress > 0) {
    if(!isDefined(self._id_250A9483D4CA72CD))
      self._id_250A9483D4CA72CD = gettime();

    scripts\mp\utility\lower_message::setlowermessageomnvar("plea_no_time");
    _id_5CCCB32072A43854(2);
  } else if(self._id_36C1DC28EDF11BED == 2 && _id_C0DD862E5087634C) {
    if(isDefined(self._id_250A9483D4CA72CD) && isDefined(self._id_6AF52E47CBD09141)) {
      _id_99BAA92BB2AB2FB3 = gettime() - self._id_250A9483D4CA72CD;
      _id_7EC6A65C4B4043A3 = self._id_6AF52E47CBD09141 + _id_99BAA92BB2AB2FB3;
      self._id_6AF52E47CBD09141 = _id_7EC6A65C4B4043A3;
      scripts\mp\utility\lower_message::setlowermessageomnvar("plea_time", _id_7EC6A65C4B4043A3);
      self._id_250A9483D4CA72CD = undefined;
    }

    _id_5CCCB32072A43854(1);
  }
}

_id_D8B32F106816AFC1(player) {
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(player._id_6AF52E47CBD09141)) {
    return;
  }
  for(;;) {
    if(isDefined(player._id_250A9483D4CA72CD)) {
      waitframe();
      continue;
    }

    if(player._id_6AF52E47CBD09141 <= gettime()) {
      return;
    }
    waitframe();
  }
}

_id_D9AE2A812E5EE454(_id_4F0C2C3538662F1B) {
  if(self._id_36C1DC28EDF11BED == 2) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("plea_waiting");
    _id_DBBD13CC9AD757C1(self.origin, self);
    waitframe();
    _id_5CCCB32072A43854(3);
    self._id_5A6BEC925741FEE3++;
    self notify("plea_created");
  }
}

_id_1144DEA4D6D6E575(origin, _id_15AB90A8DE6865AA) {
  _id_496AAA68C40AEB44 = spawnStruct();
  _id_496AAA68C40AEB44._id_15AB90A8DE6865AA = _id_15AB90A8DE6865AA;
  _id_496AAA68C40AEB44._id_8F6367CF93AE04F0 = 0;
  _id_496AAA68C40AEB44 _id_23C9A2A29579048D(origin);
  _id_496AAA68C40AEB44 _id_7E7F8FAC7F822024(origin);
  _id_496AAA68C40AEB44 _id_5CB50EC8CF0F89A5();
  _id_675D06C4A07C4178(_id_496AAA68C40AEB44);
  _id_15AB90A8DE6865AA clearpredictedstreampos();
  _id_496AAA68C40AEB44 thread _id_D00F5ADC927EEE80();
  _id_496AAA68C40AEB44 thread _id_99A48D20B7D454EF();
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("assim_plea_me_join_you", [_id_15AB90A8DE6865AA]);
  return _id_496AAA68C40AEB44;
}

_id_B03CF5A57E364AF2(player) {
  index = player getentitynumber();

  if(isDefined(level._id_DBBD13CC9AD757C1._id_807FFB67240349F5[index]))
    level._id_DBBD13CC9AD757C1._id_807FFB67240349F5[index] _id_B5341D976F6C944D();
}

_id_675D06C4A07C4178(_id_496AAA68C40AEB44) {
  index = _id_496AAA68C40AEB44._id_15AB90A8DE6865AA getentitynumber();
  _id_496AAA68C40AEB44.index = index;
  level._id_DBBD13CC9AD757C1._id_807FFB67240349F5[index] = _id_496AAA68C40AEB44;
  _id_496AAA68C40AEB44._id_3BF41BB7C12CDB4E = [];
}

_id_23C9A2A29579048D(origin) {
  offset = (0, 0, 20);
  spawnpos = origin + offset;
  self._id_DBCE45A33308630D = spawnscriptable("br_plea_request", spawnpos, (0, 0, 0));
  self._id_DBCE45A33308630D scripts\common\utility::_id_6E506F39F121EA8A(self._id_15AB90A8DE6865AA, offset);
  self._id_DBCE45A33308630D.id = "plea_for_help_looting";
  self._id_DBCE45A33308630D.usetime = level._id_DBBD13CC9AD757C1._id_07836C12F19DD2C3 * 1000;
  self._id_DBCE45A33308630D.curprogress = 0;
  self._id_DBCE45A33308630D._id_496AAA68C40AEB44 = self;
}

_id_7E7F8FAC7F822024(origin) {
  self.objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objid, "current", origin, "hud_icon_plea_for_help");
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objid, 1);
    scripts\mp\objidpoolmanager::update_objective_onentity(self.objid, self._id_15AB90A8DE6865AA);
    objective_setlabel(self.objid, &"MP_BR_INGAME/PLEA_FOR_HELP");
    _id_7FF3973C2AD05964 = _id_AD29F2CDC94AAC3B();
    _func_C047D7FFE7A83501(self.objid, _id_7FF3973C2AD05964 - 500, _id_7FF3973C2AD05964);
    _id_9B68823114A3405F();
  }
}

_id_D00F5ADC927EEE80() {
  self endon("plea_deleted");
  self._id_15AB90A8DE6865AA endon("disconnect");
  timeout = level._id_DBBD13CC9AD757C1._id_A8F396F44DF1C126;

  if(istrue(level._id_DBBD13CC9AD757C1._id_504FA7A88BA40E41))
    level scripts\engine\utility::waittill_notify_or_timeout("game_ended", timeout);
  else
    level waittill("game_ended");

  thread _id_B5341D976F6C944D();
}

_id_99A48D20B7D454EF() {
  self endon("plea_deleted");
  level endon("game_ended");
  _id_B2E7E41C5DF2102B = 0;

  while(!_id_B2E7E41C5DF2102B) {
    _id_B2E7E41C5DF2102B = _id_1174ABEDBEFE9ADA::_id_076EF3C8B8171D2D(self._id_DBCE45A33308630D.origin);
    wait 1;
  }

  wait 5;
  thread _id_B5341D976F6C944D();
}

_id_91BCAF0C98ECFB81(_id_F99D56BCB582A8BA) {
  if(!_id_C1E2F014739D7903(_id_F99D56BCB582A8BA)) {
    return;
  }
  index = _id_F99D56BCB582A8BA getentitynumber();
  _id_496AAA68C40AEB44 = level._id_DBBD13CC9AD757C1._id_807FFB67240349F5[index];
  _id_496AAA68C40AEB44 _id_5CB50EC8CF0F89A5();
}

_id_46EEA9B19A5046CF(_id_F99D56BCB582A8BA, _id_784C8ADA1184FF89) {
  if(!isDefined(_id_F99D56BCB582A8BA) || !isDefined(_id_784C8ADA1184FF89))
    return 1;

  if(!isDefined(_id_F99D56BCB582A8BA.lastkilledby) || !isDefined(_id_F99D56BCB582A8BA.team) || !isDefined(_id_784C8ADA1184FF89.team))
    return 1;

  if(getdvarint("dvar_A37E111D455283D2", 1) || _id_F99D56BCB582A8BA.lastkilledby.team != _id_784C8ADA1184FF89.team)
    return 1;

  return 0;
}

_id_5CB50EC8CF0F89A5() {
  _id_7FF3973C2AD05964 = _id_AD29F2CDC94AAC3B();
  _id_E965BCE0774276B4 = scripts\mp\utility\player::getplayersinradius(self._id_DBCE45A33308630D.origin, _id_7FF3973C2AD05964);
  _id_6985F8AD6A6FC95B = scripts\engine\utility::array_difference(level.players, _id_E965BCE0774276B4);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objid);

  foreach(player in _id_E965BCE0774276B4) {
    if(!isDefined(player)) {
      continue;
    }
    if(_id_F4468DD443922B9E(self._id_15AB90A8DE6865AA, player, 1) && _id_46EEA9B19A5046CF(self._id_15AB90A8DE6865AA, player)) {
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("assim_plea_me_join_you_nearby", [player]);
      _id_09610EEE898AC5A6(player);
      continue;
    }

    _id_E0949ADDB6054291(player);
  }

  foreach(player in _id_6985F8AD6A6FC95B) {
    if(!isDefined(player)) {
      continue;
    }
    _id_E0949ADDB6054291(player);
  }
}

_id_E0949ADDB6054291(player) {
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objid, player);
  self._id_DBCE45A33308630D disablescriptableplayeruse(player);
  self._id_15AB90A8DE6865AA _id_4DEC72501AC491A5(player);
}

_id_09610EEE898AC5A6(player) {
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objid, player);
  self._id_DBCE45A33308630D enablescriptableplayeruse(player);
}

_id_9A375C85268AFAAA(team) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_7FF3973C2AD05964 = _id_AD29F2CDC94AAC3B();

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    _id_28AE41A833E83C3F = _id_F4468DD443922B9E(self._id_15AB90A8DE6865AA, player, 1);

    if(!_id_28AE41A833E83C3F) {
      _id_E0949ADDB6054291(player);
      continue;
    }

    dist = distance2d(self._id_DBCE45A33308630D.origin, player.origin);

    if(dist <= _id_7FF3973C2AD05964)
      _id_09610EEE898AC5A6(player);
    else
      _id_E0949ADDB6054291(player);
  }
}

_id_631C07DEA1296288(team) {
  foreach(_id_496AAA68C40AEB44 in level._id_DBBD13CC9AD757C1._id_807FFB67240349F5) {
    if(!isDefined(_id_496AAA68C40AEB44)) {
      continue;
    }
    _id_496AAA68C40AEB44 _id_9A375C85268AFAAA(team);
  }
}

_id_4DEC72501AC491A5(player) {
  if(isDefined(self._id_6A4360DCF2A8F3D4)) {
    if(istrue(self._id_6A4360DCF2A8F3D4._id_386694991BE029A0) && self.team == player.team) {
      self._id_6A4360DCF2A8F3D4 disablescriptableplayeruse(player);
      return;
    } else
      self._id_6A4360DCF2A8F3D4 enablescriptableplayeruse(player);
  }
}

_id_1032F89962BEC545(player) {
  if(isDefined(self._id_6A4360DCF2A8F3D4))
    self._id_6A4360DCF2A8F3D4 disablescriptableplayeruse(player);
}

_id_1B4A4AFFDF4C7798() {
  if(isDefined(self._id_6A4360DCF2A8F3D4)) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(istrue(self._id_6A4360DCF2A8F3D4._id_386694991BE029A0) && self.team == player.team) {
        self._id_6A4360DCF2A8F3D4 disablescriptableplayeruse(player);
        continue;
      }

      self._id_6A4360DCF2A8F3D4 enablescriptableplayeruse(player);
    }
  }
}

_id_7BBC24BC9F4693BB(instance, part, state, player, _id_496AAA68C40AEB44) {
  level endon("game_ended");
  _id_496AAA68C40AEB44._id_15AB90A8DE6865AA endon("disconnect");
  _id_496AAA68C40AEB44 endon("plea_deleted");

  if(!_id_F4468DD443922B9E(_id_496AAA68C40AEB44._id_15AB90A8DE6865AA, player, 1)) {
    player scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_TEAM_SIZE");
    return;
  }

  if(isDefined(instance._id_E4F0B27DD32F8D95) || _id_496AAA68C40AEB44._id_15AB90A8DE6865AA scripts\mp\utility\player::getbeingrevivedinternal()) {
    player scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
    return;
  }

  _id_D31D331A4C57867B = isbot(player);
  instance.curprogress = 0;
  instance._id_E4F0B27DD32F8D95 = player;
  beingrevived = 0;

  while((player useButtonPressed() || _id_D31D331A4C57867B) && instance.curprogress < instance.usetime && scripts\mp\utility\player::_id_AD443BBCDCF37B85(player) && !beingrevived) {
    instance.curprogress = instance.curprogress + level.frameduration;

    if(instance.curprogress >= 250)
      player scripts\mp\gameobjects::updateuiprogress(instance, 1);

    waitframe();
    beingrevived = _id_496AAA68C40AEB44._id_15AB90A8DE6865AA scripts\mp\utility\player::getbeingrevivedinternal();

    if(_id_D31D331A4C57867B && istrue(instance._id_FB04222D93E0905B)) {
      break;
    }
  }

  _id_7E41AED52F964714 = instance.curprogress >= instance.usetime;
  instance.curprogress = 0;
  player scripts\mp\gameobjects::updateuiprogress(instance, 0);

  if(isDefined(_id_496AAA68C40AEB44) && scripts\mp\utility\player::_id_AD443BBCDCF37B85(player) && !beingrevived && _id_7E41AED52F964714)
    _id_97D4AA6A47A2A3DF = _id_496AAA68C40AEB44 _id_FEC9399C00988060(player);

  if(isDefined(instance))
    instance._id_E4F0B27DD32F8D95 = undefined;
}

_id_30655E044834FC14(_id_E501C18E04378D20) {
  if(isDefined(self._id_15AB90A8DE6865AA._id_6A4360DCF2A8F3D4) && !isbot(_id_E501C18E04378D20)) {
    _id_089AA81C53E4E27B = self._id_15AB90A8DE6865AA._id_6A4360DCF2A8F3D4;
    _id_089AA81C53E4E27B setscriptablepartstate("body", "partially_open_in_use_unusable");
    items = getscriptablelootcachecontents(_id_089AA81C53E4E27B);
    _id_089AA81C53E4E27B _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 1, _id_E501C18E04378D20, _id_089AA81C53E4E27B.contents);
  }

  thread _id_B5341D976F6C944D();
  return 1;
}

_id_FEC9399C00988060(_id_784C8ADA1184FF89) {
  _id_3B96D5666000C2E0 = self._id_15AB90A8DE6865AA;

  if(getdvarint("dvar_216394A34963463D", 1)) {
    _id_3B96D5666000C2E0._id_2EE33CFB70F7EAAF = _id_784C8ADA1184FF89;
    _id_784C8ADA1184FF89._id_2F950A6A60FFB7D3 = _id_3B96D5666000C2E0;
    _id_784C8ADA1184FF89 thread _id_396A814D39E7044F::_id_36EDF91561322753(6, 20, ::_id_C26F981347110521);
    _id_3B96D5666000C2E0 playerrespawn();
    _id_784C8ADA1184FF89 thread scripts\mp\utility\points::givexpwithtext("stat_6990F2812894108B");

    if(getdvarint("dvar_3C8939469C4D6C50", 1)) {
      _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_784C8ADA1184FF89.team, "alivePlayers");
      _id_188008B85F8B14D4::_id_0ED4C2D913D203BF(_id_6D5ED003AF1F9612, "plea_grace_time");
      _id_188008B85F8B14D4::_id_0ED4C2D913D203BF([_id_3B96D5666000C2E0], "plea_grace_time");
      _id_CD4D702523C3EFB7 = scripts\engine\utility::array_add(_id_6D5ED003AF1F9612, _id_3B96D5666000C2E0);
      level thread _id_3EE28C2EF70BB7D3(_id_CD4D702523C3EFB7);
    }

    thread _id_B5341D976F6C944D();
    return 1;
  } else if(_id_7EEA956B4D052875(_id_3B96D5666000C2E0, _id_784C8ADA1184FF89)) {
    _id_3B96D5666000C2E0 playerrespawn();
    _id_784C8ADA1184FF89 thread scripts\mp\utility\points::givexpwithtext("stat_6990F2812894108B");
    _id_B7102C003905C9B1("player_team_switched", [_id_3B96D5666000C2E0]);
    thread _id_B5341D976F6C944D();
    return 1;
  }

  return 0;
}

_id_7EEA956B4D052875(_id_3B96D5666000C2E0, _id_784C8ADA1184FF89) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "canAssimilate") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "assimilatePlayer"))
    return 0;

  if([[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "canAssimilate")]](_id_3B96D5666000C2E0, _id_784C8ADA1184FF89, _id_784C8ADA1184FF89, 0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "assimilatePlayer")]](_id_3B96D5666000C2E0, _id_784C8ADA1184FF89, 1);
    return 1;
  } else
    return 0;
}

_id_C26F981347110521(_id_8D1DD77475DB7A6A) {
  if(!istrue(_id_8D1DD77475DB7A6A))
    return 0;

  _id_784C8ADA1184FF89 = self;
  _id_3B96D5666000C2E0 = self._id_2F950A6A60FFB7D3;

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "canAssimilate") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "assimilatePlayer"))
    return 0;

  if([[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "canAssimilate")]](_id_3B96D5666000C2E0, _id_784C8ADA1184FF89, _id_784C8ADA1184FF89, 0)) {
    success = [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "sendDirectAssimRequest")]](_id_784C8ADA1184FF89, _id_3B96D5666000C2E0, 0, 0);

    if(istrue(success))
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("assim_request_you_join_me", [_id_784C8ADA1184FF89]);

    return istrue(success);
  } else
    return 0;
}

playerrespawn() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }
  _id_123A6F38785CDF2D::playerfakespectate(0);
  _id_5307834CD39B435C::_id_B892C6B4C68C344A([self], 0.5);
  self clearsoundsubmix("deaths_door_mp");
  self clearsoundsubmix("iw9_mp_killcam");
  self.isrespawn = 1;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\playerlogic::spawnplayer(undefined, 1);
  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer();
  _id_0A34750D17473C49::unmarkplayeraseliminated(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_B092E3259EC308D8");
  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
  thread _id_4480C6CE37B2BDF3::_id_707D956BDBD4B134();
}

_id_E163B2023BA2BFC6(_id_AD4D55FD441C70BD) {
  self endon("disconnect");
  contents = physics_createcontents(["physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_playernosight"]);
  _id_A92E3D2FF7AF10C9 = scripts\mp\utility\player::_id_6D606D81EA9AB50B(1, 1, contents);

  if(!isDefined(_id_A92E3D2FF7AF10C9)) {
    return;
  }
  thread _id_C3FF897E4DE174F9(_id_A92E3D2FF7AF10C9, _id_AD4D55FD441C70BD);
  self waittill("plea_deleted");
  self allowspectateteam(self.team, 1);
  self cameraunlink();
  _id_A92E3D2FF7AF10C9 delete();
}

_id_C3FF897E4DE174F9(cameraent, _id_AD4D55FD441C70BD) {
  self endon("disconnect");
  self endon("plea_deleted");

  if(isbot(self) || cameraent.data._id_6095EFE86105E553.size == 0) {
    return;
  }
  wait 0.5;
  cameraent._id_AD4D55FD441C70BD = _id_AD4D55FD441C70BD;
  cameraent._id_1133FB4CD2BF985A = 0;
  cameraent._id_3E3E41683DC1BCDD = level._id_DBBD13CC9AD757C1._id_AFDD97402F873F1E;
  scripts\mp\utility\player::_id_4B6858706980B154("previous_camera_position_kbm", "moveleft", ::_id_7BC6EE82D60A23AC, cameraent, ["plea_deleted"], "kbm_only", cameraent._id_3E3E41683DC1BCDD);
  scripts\mp\utility\player::_id_4B6858706980B154("next_camera_position_kbm", "moveright", ::_id_93267D1B12626524, cameraent, ["plea_deleted"], "kbm_only", cameraent._id_3E3E41683DC1BCDD);
  scripts\mp\utility\player::_id_4B6858706980B154("previous_camera_position_gamepad", "actionslot 3", ::_id_7BC6EE82D60A23AC, cameraent, ["plea_deleted"], "gamepad_only", cameraent._id_3E3E41683DC1BCDD);
  scripts\mp\utility\player::_id_4B6858706980B154("next_camera_position_gamepad", "actionslot 4", ::_id_93267D1B12626524, cameraent, ["plea_deleted"], "gamepad_only", cameraent._id_3E3E41683DC1BCDD);
}

_id_93267D1B12626524(cameraent) {
  _id_379DE5A38F0E582A = cameraent.data;
  cameraent._id_1133FB4CD2BF985A = (cameraent._id_1133FB4CD2BF985A + 1) % _id_379DE5A38F0E582A._id_6095EFE86105E553.size;
  _id_12B614F64A9BA025 = _id_379DE5A38F0E582A._id_6095EFE86105E553[cameraent._id_1133FB4CD2BF985A];
  cameraent _id_3718DCB439A51665(_id_12B614F64A9BA025, cameraent._id_AD4D55FD441C70BD);
}

_id_7BC6EE82D60A23AC(cameraent) {
  _id_379DE5A38F0E582A = cameraent.data;
  cameraent._id_1133FB4CD2BF985A = cameraent._id_1133FB4CD2BF985A - 1;

  if(cameraent._id_1133FB4CD2BF985A < 0)
    cameraent._id_1133FB4CD2BF985A = _id_379DE5A38F0E582A._id_6095EFE86105E553.size - 1;

  _id_12B614F64A9BA025 = _id_379DE5A38F0E582A._id_6095EFE86105E553[cameraent._id_1133FB4CD2BF985A];
  cameraent _id_3718DCB439A51665(_id_12B614F64A9BA025, cameraent._id_AD4D55FD441C70BD);
}

_id_3718DCB439A51665(_id_12B614F64A9BA025, _id_AD4D55FD441C70BD) {
  _id_83038D49C868DB4D = vectorNormalize(_id_AD4D55FD441C70BD - _id_12B614F64A9BA025);
  self moveTo(_id_12B614F64A9BA025, self._id_3E3E41683DC1BCDD, 0, 0);
  self rotateTo(vectortoangles(_id_83038D49C868DB4D), self._id_3E3E41683DC1BCDD, 0, 0);
}

_id_9B68823114A3405F() {
  _id_7D2E1A4944F8B507 = _id_AD29F2CDC94AAC3B();
  triggerheight = 6000;
  heightoffset = (0, 0, 2000);
  triggerradius = spawn("trigger_radius", self._id_DBCE45A33308630D.origin - heightoffset, 0, _id_7D2E1A4944F8B507, 6000);
  triggerradius._id_496AAA68C40AEB44 = self;
  self.trigger = triggerradius;
  scripts\mp\utility\trigger::makeenterexittrigger(triggerradius, ::_id_B786B6748090B866, ::_id_1361F5D497E474D0, undefined, undefined, ::_id_76E95D35A6CDBE41);
}

_id_B786B6748090B866(player, trigger) {
  _id_496AAA68C40AEB44 = trigger._id_496AAA68C40AEB44;

  if(!isalive(player) || !_id_F4468DD443922B9E(_id_496AAA68C40AEB44._id_15AB90A8DE6865AA, player, 1) || !_id_46EEA9B19A5046CF(_id_496AAA68C40AEB44._id_15AB90A8DE6865AA, player)) {
    return;
  }
  _id_496AAA68C40AEB44 _id_09610EEE898AC5A6(player);

  if(isDefined(_id_496AAA68C40AEB44._id_3BF41BB7C12CDB4E) && !scripts\engine\utility::array_contains(_id_496AAA68C40AEB44._id_3BF41BB7C12CDB4E, player.guid)) {
    _id_B7102C003905C9B1("dmz_plea_for_help_requested", [player]);
    _id_496AAA68C40AEB44._id_3BF41BB7C12CDB4E[_id_496AAA68C40AEB44._id_3BF41BB7C12CDB4E.size] = player.guid;
  }
}

_id_1361F5D497E474D0(player, trigger) {
  _id_496AAA68C40AEB44 = trigger._id_496AAA68C40AEB44;
  _id_496AAA68C40AEB44 _id_E0949ADDB6054291(player);
}

_id_72C2355A581A6EDB(trigger) {
  self endon("plea_squad_count_updated");
  self endon("plea_deleted");
  waittillframeend;

  if(!isDefined(self._id_15AB90A8DE6865AA)) {
    return;
  }
  _id_8F6367CF93AE04F0 = _id_A05533B81CE8225C(trigger, self._id_15AB90A8DE6865AA);

  if(self._id_8F6367CF93AE04F0 != _id_8F6367CF93AE04F0) {
    self._id_8F6367CF93AE04F0 = _id_8F6367CF93AE04F0;
    self._id_15AB90A8DE6865AA _id_F3B1F4580FFB7524(_id_8F6367CF93AE04F0);
  }

  self notify("plea_squad_count_updated");
}

_id_A05533B81CE8225C(trigger, _id_15AB90A8DE6865AA) {
  _id_AED530C6CCCA889E = [];

  foreach(playerent in trigger.triggerenterents) {
    if(!isDefined(playerent) || !isPlayer(playerent)) {
      continue;
    }
    if(!isDefined(playerent.team) || playerent.team == _id_15AB90A8DE6865AA.team) {
      continue;
    }
    if(!_id_7DFA4473A3663C96(playerent.team)) {
      continue;
    }
    _id_AED530C6CCCA889E[playerent.team] = 1;
  }

  return _id_AED530C6CCCA889E.size;
}

_id_76E95D35A6CDBE41(_id_102FF186309F63B8, trigger) {
  return !isPlayer(_id_102FF186309F63B8) || !isDefined(trigger);
}

_id_B5341D976F6C944D() {
  if(isDefined(self.trigger))
    self.trigger delete();

  if(isDefined(self.objid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objid);

  if(isDefined(self._id_DBCE45A33308630D)) {
    if(isDefined(self._id_DBCE45A33308630D._id_E4F0B27DD32F8D95)) {
      self._id_DBCE45A33308630D.curprogress = 0;
      self._id_DBCE45A33308630D._id_E4F0B27DD32F8D95 scripts\mp\gameobjects::updateuiprogress(self._id_DBCE45A33308630D, 0);
    }

    self._id_DBCE45A33308630D freescriptable();
  }

  if(isDefined(self._id_15AB90A8DE6865AA)) {
    self._id_15AB90A8DE6865AA _id_5CCCB32072A43854(0);
    self._id_15AB90A8DE6865AA _id_1B4A4AFFDF4C7798();
  }

  level._id_DBBD13CC9AD757C1._id_807FFB67240349F5[self.index] = undefined;
  self notify("plea_deleted");
  self._id_15AB90A8DE6865AA notify("plea_deleted");
}

_id_F6457A70C99155DC(team) {
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(!isDefined(player)) {
      continue;
    }
    if(_id_C1E2F014739D7903(player)) {
      _id_496AAA68C40AEB44 = _id_C069F41A6BC4A19A(player);
      _id_496AAA68C40AEB44 thread _id_B5341D976F6C944D();
    }
  }
}

_id_58E61608AAB59511(player) {
  if(!isDefined(player)) {
    return;
  }
  _id_496AAA68C40AEB44 = _id_C069F41A6BC4A19A(player);

  if(isDefined(_id_496AAA68C40AEB44)) {
    _id_496AAA68C40AEB44 thread _id_B5341D976F6C944D();
    _id_631C07DEA1296288(player.team);
  }
}

_id_C9E6FCD7831F36AF(origin) {
  _id_7FF3973C2AD05964 = _id_AD29F2CDC94AAC3B();
  _id_E965BCE0774276B4 = scripts\mp\utility\player::getplayersinradius(origin, _id_7FF3973C2AD05964);

  foreach(player in _id_E965BCE0774276B4) {
    if(!isDefined(player)) {
      continue;
    }
    if(scripts\mp\utility\player::isreallyalive(player) && _id_F4468DD443922B9E(self._id_15AB90A8DE6865AA, player, 1) && _id_46EEA9B19A5046CF(self._id_15AB90A8DE6865AA, player)) {
      _id_B7102C003905C9B1("dmz_plea_for_help_requested", [player]);
      self._id_3BF41BB7C12CDB4E[self._id_3BF41BB7C12CDB4E.size] = player.guid;
    }
  }
}

onplayerdisconnect(player) {
  _id_58E61608AAB59511(player);
}

onplayerrespawn() {
  _id_58E61608AAB59511(self);
}

_id_6BDC6F56944DC3AA(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  _id_631C07DEA1296288(_id_8A04AA0E0755E7E3);
  _id_631C07DEA1296288(_id_EB06B338608EF354);
}

_id_4E60EA7D6C5AB305(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  thread _id_7BBC24BC9F4693BB(instance, part, state, player, instance._id_496AAA68C40AEB44);
}

_id_5CCCB32072A43854(_id_6D38DF6EA2EB7767) {
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_plea_for_help_data", 0, 2, _id_6D38DF6EA2EB7767);
  self._id_36C1DC28EDF11BED = _id_6D38DF6EA2EB7767;
}

_id_F3B1F4580FFB7524(_id_511A034BA346F623) {
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_plea_for_help_data", 2, 8, _id_511A034BA346F623);
}

_id_B7102C003905C9B1(splashname, _id_9052970FF4BCE526) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showDMZSplash"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showDMZSplash")]](splashname, _id_9052970FF4BCE526);
}

_id_F4468DD443922B9E(_id_3B96D5666000C2E0, _id_784C8ADA1184FF89, _id_4ADE2291346E1240) {
  if(!istrue(_id_3B96D5666000C2E0.br_iseliminated))
    return 0;

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "canAssimilate"))
    return 0;

  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "canAssimilate")]](_id_3B96D5666000C2E0, _id_784C8ADA1184FF89, _id_784C8ADA1184FF89, _id_4ADE2291346E1240);
}

_id_7DFA4473A3663C96(team) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "canTeamAssimilate"))
    return 0;

  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "canTeamAssimilate")]](team);
}

_id_E2AED369E0BAC150() {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "shouldAutoAcceptTeamSwitch"))
    return 0;

  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "shouldAutoAcceptTeamSwitch")]]();
}

_id_2E673B4C90CD35FB() {
  thread scripts\mp\teamrevive::removetrigger(self.guid);
}

_id_3EE28C2EF70BB7D3(players) {
  level endon("game_ended");
  _id_B1A743CA97F7690E = level._id_DBBD13CC9AD757C1._id_B1A743CA97F7690E;
  _id_3E8AEB2A9E8D86D6 = undefined;

  foreach(player in players) {
    if(!isDefined(_id_3E8AEB2A9E8D86D6))
      _id_3E8AEB2A9E8D86D6 = player.team + "_proxy";

    player._id_3E8AEB2A9E8D86D6 = _id_3E8AEB2A9E8D86D6;
  }

  wait(_id_B1A743CA97F7690E);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    player._id_3E8AEB2A9E8D86D6 = undefined;
  }
}