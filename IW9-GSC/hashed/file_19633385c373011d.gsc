/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_19633385c373011d.gsc
***********************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "champion") {
    return;
  }
  init();
}

init() {
  _id_4A0D1F5F6BE0F8C7::init();
  level thread _id_634D911D513C3380();
  level thread initpostmain();
  level thread initdialog();
  setdvarifuninitialized("dvar_98FAD011285F3011", 0);
  setdvarifuninitialized("dvar_E82B8618853A182C", 1500);
  level thread _id_7B49B147E0D292E5();
  level thread _id_90066BC128FBD493();
  _id_303FD53078A244F1::init();
  _id_5BC86A57086A4774::init();
  level.brdisablefinalkillcam = 1;
  level._id_C5DC0E983C929728 = getdvarint("dvar_58E2B234D0A26865", 0);
}

_id_7B49B147E0D292E5() {
  setomnvar("ui_br_resurgence_respawn_enabled", 1);
  _id_97B175CEC5B685BE("mp/classtable_br_resurgence_mgl.csv");
  _id_97B175CEC5B685BE("mp/classtable_br_resurgence_mgl_circle2.csv");
  _id_97B175CEC5B685BE("mp/classtable_br_resurgence_mgl_circle3.csv");
  level.brgametype._id_6420B42C7ADD53CC = getdvarint("dvar_D2891D4180DE0553", 1);
  level.brgametype._id_F6682C80C3C868D6 = getdvarint("dvar_B13B80D2A347596E", 1);
  level.brgametype._id_FBC20F6D398B973E = getdvarint("dvar_9F287F2A37CD90F4", 0);
  level.brgametype._id_7B3746FD57041FB7 = getdvarint("dvar_0D834C362EAEEF3A", 1);
  level.brgametype._id_FC3B5A2E206A85F2 = getdvarint("dvar_9A00313371F55DE1", 0);
  level.brgametype._id_3DD997E45E444B3D = getdvarint("dvar_CFB769A290798F09", 1);
  level.brgametype._id_8CB996B879748BB1 = getdvarfloat("dvar_6772E6C744D1D962", 30);
  level.brgametype._id_59AF2E5140D3FED7 = getdvarfloat("dvar_E9B60187D57107B9", 1.0);
  level.respawnheightoverride = getdvarint("dvar_AE35E4BB8A3AA9E7", 7500);
  level.brgametype._id_A916B204F027AF6B = getdvarint("dvar_A91B489383D89274", 0);
  level.brgametype._id_6F3C4D74A8C614AB = getdvarint("dvar_38AFF65BDA44B82A", 1);
  level.brgametype._id_B43745B85F249E68 = 1;
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("mayConsiderPlayerDead");
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("onMarkPlayerAsEliminated");
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("getDefaultLoadout");
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("kioskRevivePlayer");
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("onPlayerKilled");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("circleTimer", ::circletimer);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("mayConsiderPlayerDead", ::brmayconsiderplayerdead);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("triggerRespawnOverlay", ::triggerrespawnoverlay);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerNakedDropLoadout", ::playernakeddroploadout);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("getDefaultLoadout", ::_id_391B372CD3C0DDDC);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("kioskRevivePlayer", ::kioskreviveplayer);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("dropOnPlayerDeath", ::droponplayerdeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onMarkPlayerAsEliminated", ::_id_0F5CFF6DA44A3790);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onCloseCircleCompleted", ::_id_F3EE77261EEB34DD);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::_id_735FE9EC0C4DD312);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onDeadEvent", ::ondeadevent);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerGetRespawnPoint", ::_id_952548D8AED47102);
  waittillframeend;

  if(level.brgametype._id_3DD997E45E444B3D)
    level._id_5DFD73C97BF5D03D = ::_id_5DFD73C97BF5D03D;

  level._id_484F1A4BDB5CDA1E = ::_id_A2131D000491AE2C;
  _id_0641EEE023180065();
  thread _id_49A4F952CCB3FD45();
  thread _id_8369D5301DE43452();
  thread _id_AAACD0F0A1D84290();
  thread _id_E003A419D3914C23();
  thread _id_2573E08A439335F7();
}

_id_90066BC128FBD493() {
  level endon("game_ended");
  level waittill("prematch_done");
  _id_2695A20D4011076D::_id_4448B165E1F42719(4);
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(4, _id_4384ABBF498DF6A7::dangercircletick);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(_id_303FD53078A244F1::_id_C9A0784E88FCF18D);
}

_id_9A61575DE4F3D1EC() {
  if(!istrue(level._id_9DB23A91B81905C3)) {
    level.canprocessot = 1;
    level.ontimelimitgraceperiod = getdvarfloat("dvar_B1DC99C22B12BD63", 0);
    level.currenttimelimitdelay = 0.0;
    level._id_9DB23A91B81905C3 = level.ontimelimitgraceperiod > 0;
    level.setallclientomnvarot = level._id_9DB23A91B81905C3;
    level.forceotlogictorun = level._id_9DB23A91B81905C3;
    scripts\mp\hud_util::showsplashtoall("br_champion_overtime_activated");
    level thread scripts\mp\music_and_dialog::_id_283A36147406B42F();
  }
}

_id_634D911D513C3380() {
  if(getdvarint("dvar_5A1DAE481EF5D089", 0) == 1)
    _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");

  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("randomizeCircleCenter");
  _id_362C58E8BB39BCDA::disablefeature("planeSnapToOOB");
  _id_362C58E8BB39BCDA::enablefeature("planeUseCircleRadius");
  _id_362C58E8BB39BCDA::enablefeature("circleEarlyStart");
}

initpostmain() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("champion", "packClientMatchData", ::packclientmatchdata);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("createC130PathStruct", ::createc130pathstruct);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("addToC130Infil", ::addtoc130infil);
  level.bots_gametype_handles_class_choice = 0;

  if(getdvarint("dvar_BB3CFA989A77B2C5", 1) == 1)
    thread setdropbagdelay();

  waittillframeend;
  level.ontimelimit = ::ontimelimit;
  cleanupents();
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
}

_id_0B79B55C5A0AAA08(_id_939B8E8818BFD5AE, state, missionid, _id_C08E41851ED100E8) {
  player = _id_939B8E8818BFD5AE getentitynumber();

  if(!isDefined(state))
    state = 0;

  if(!isDefined(player))
    player = 0;

  if(!isDefined(missionid))
    missionid = 0;

  _id_936B577D2320099A = 4;
  _id_017662F483F270D8 = _id_936B577D2320099A;
  _id_4110E41370F4D67C = 8;
  _id_D8354A49CC36AA44 = _id_017662F483F270D8 + _id_4110E41370F4D67C;
  _id_D950A79D86F32708 = 16;
  _id_D5F8C4084A83331B = 0;
  _id_3FAA24937366BD8C = _id_D8354A49CC36AA44 + _id_D950A79D86F32708;

  foreach(_id_640136359951D151 in _id_C08E41851ED100E8) {
    _id_D5F8C4084A83331B = _id_D5F8C4084A83331B | _id_640136359951D151 << _id_3FAA24937366BD8C;
    _id_3FAA24937366BD8C++;
  }

  value = 0;
  value = _id_D5F8C4084A83331B | missionid << _id_D8354A49CC36AA44 | player << _id_017662F483F270D8 | state;
  self setclientomnvar("ui_br_expanded_obit_message", value);
}

_id_4BB3153D2BC88C04(team, _id_939B8E8818BFD5AE, state, missionid, _id_C08E41851ED100E8) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player _id_0B79B55C5A0AAA08(_id_939B8E8818BFD5AE, state, missionid, _id_C08E41851ED100E8);
}

_id_A380C47216DC87A7(attacker, _id_E48B3D05087E93F5, _id_73CACD5A645AAB1F) {
  if(getdvarint("dvar_5B0A580D2ED6F60E", 1) == 0) {
    return;
  }
  _id_4AF8655668DF58E2 = _id_E48B3D05087E93F5 getentitynumber();
  attackerentnum = attacker getentitynumber();
  _id_AF9CBB6CB7344131 = [];
  index = 1;
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(level.players[attackerentnum].team, "players");

  foreach(_id_F90358454413407F in _id_A6AB8D0FDA441DC2) {
    if(_id_F90358454413407F == level.players[attackerentnum]) {
      _id_AF9CBB6CB7344131[index] = 0;
      index++;
      continue;
    }

    _id_AF9CBB6CB7344131[index] = 0;

    foreach(_id_22080D73AE745A4B in _id_73CACD5A645AAB1F) {
      if(_id_F90358454413407F == _id_22080D73AE745A4B) {
        _id_AF9CBB6CB7344131[index] = 1;
        break;
      }
    }

    index++;
  }

  for(_id_AC61D946AFDBA08B = index; _id_AC61D946AFDBA08B < 4; _id_AC61D946AFDBA08B++)
    _id_AF9CBB6CB7344131[_id_AC61D946AFDBA08B] = 0;

  _id_4BB3153D2BC88C04(level.players[attackerentnum].team, level.players[attackerentnum], 15, _id_4AF8655668DF58E2, _id_AF9CBB6CB7344131);
}

initdialog() {
  level endon("game_ended");
  game["dialog"]["match_start"] = "gametype_resurgence";
  game["dialog"]["match_desc"] = "gametype_desc_resurgence";
  game["dialog"]["last_man_standing"] = "rsrg_squad_last_alive";
  game["dialog"]["champion_avenge_teammate"] = "resurgence_avenge_teammate";
  game["dialog"]["champion_redeploy"] = "resurgence_redeploy";
  game["dialog"]["champion_disabled"] = "resurgence_reinforcement_disabled";
  game["dialog"]["champion_ending"] = "resurgence_reinforcement_ending";
  game["dialog"]["champion_teammate_respawn"] = "resurgence_teammate_respawn";
}

_id_747B066379119D51() {
  game["dialog"]["last_man_standing"] = "resurgence_last_alive";
}

cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

_id_49A4F952CCB3FD45() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.brgametype._id_C42E40EC22A1F0D4 = 1;
  level._id_843573804B98EB7E = 1;
}

_id_8369D5301DE43452() {
  waittillframeend;
  _id_8DBB05FF88408C71 = level.allteamnamelist;

  foreach(index, team in _id_8DBB05FF88408C71)
  level.teamdata[team]["index"] = index;

  _id_840B848760F488A4 = getdvarint("dvar_96C8E4682FF85B5F", 0);

  if(istrue(_id_840B848760F488A4)) {
    foreach(name, team in level.teamdata)
    level.teamdata[name]["trackedTeams"] = [];
  } else {
    scripts\mp\flags::gameflagwait("prematch_done");
    scripts\mp\flags::gameflagwait("prematch_fade_done");

    foreach(player in level.players)
    player._id_A93508890D2545D1 = [];
  }
}

_id_AAACD0F0A1D84290() {
  foreach(name, team in level.teamdata)
  level.teamdata[name]["deadPlayers"] = [];
}

_id_EC09C585DA4071ED(_id_401C3A2E68AAB0FD) {
  winner = _id_303FD53078A244F1::gethighestscoringteam();
  level thread scripts\mp\gamelogic::endgame(winner, _id_401C3A2E68AAB0FD);
}

ontimelimit() {
  if(!isDefined(level.ontimelimitgraceperiod)) {
    level _id_9A61575DE4F3D1EC();
    return;
  }

  foreach(_id_F90358454413407F in level.teamnamelist)
  _id_1E4A61DB11011446::setaardata(_id_F90358454413407F);

  _id_EC09C585DA4071ED(game["end_reason"]["time_limit_reached"]);
}

brmayconsiderplayerdead(player) {
  if(scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("prematch_fade_done")) {
    player thread _id_3C88EC256B493BD0();

    if(!istrue(level.brgametype._id_B43745B85F249E68))
      _id_0A34750D17473C49::markplayeraseliminated(player);
  }

  return 1;
}

ondeadevent(team) {
  return 1;
}

packclientmatchdata() {
  if(!isDefined(self._id_011E422333CB859E))
    self._id_011E422333CB859E = 0;

  _id_081DAB8953B9DF82 = self._id_011E422333CB859E;

  if(_id_081DAB8953B9DF82 > 255)
    _id_081DAB8953B9DF82 = 255;

  self.extrascore0 = _id_081DAB8953B9DF82;
  self.pers["extrascore0"] = _id_081DAB8953B9DF82;
  return _id_081DAB8953B9DF82;
}

_id_348449F96FF7CEF8(teamdata, _id_075C8CC005E7E9F3) {
  _id_2F945DAC0CD1EDCB = !istrue(level.teamdata[self.team]["teamHadFirstRevive"]);

  if(_id_2F945DAC0CD1EDCB)
    level.teamdata[self.team]["teamHadFirstRevive"] = 1;

  foreach(_id_B46423B1979CB10E in teamdata) {
    if(!isDefined(_id_B46423B1979CB10E._id_011E422333CB859E))
      _id_B46423B1979CB10E._id_011E422333CB859E = 0;

    _id_B46423B1979CB10E._id_011E422333CB859E++;
    _id_B46423B1979CB10E _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("reviveCount", _id_B46423B1979CB10E._id_011E422333CB859E);
    _id_B46423B1979CB10E packclientmatchdata();
    _id_75A087E96D31DDC5 = !isDefined(_id_075C8CC005E7E9F3) || _id_B46423B1979CB10E != _id_075C8CC005E7E9F3;
    _id_4B59E709FD5BCC45 = _id_2F945DAC0CD1EDCB && _id_75A087E96D31DDC5;

    if(_id_4B59E709FD5BCC45)
      _id_B46423B1979CB10E thread scripts\mp\hud_message::showsplash("br_resurgence_first_revive", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp_mgl");
  }
}

kioskreviveplayer(_id_84E2123AACA9A965, _id_57D71760971F748F) {
  _id_C7869D69DBCF7FD3 = self;
  _id_C7869D69DBCF7FD3 thread _id_67708F418B1FAC79::playergulagautowin("championKioskRevive", _id_84E2123AACA9A965, _id_57D71760971F748F);
  _id_C7869D69DBCF7FD3 _id_348449F96FF7CEF8(level.teamdata[_id_C7869D69DBCF7FD3.team]["alivePlayers"], _id_84E2123AACA9A965);
  _id_1F8DA2719751FC5F();
  return;
}

droponplayerdeath(attacker) {
  if(istrue(level.brgametype._id_D6DC578C217F88CF) && !isDefined(self._id_5FB036C33CDDD360))
    _id_1E4A61DB11011446::_id_10FFA1071B1C2681();

  return 0;
}

_id_0F5CFF6DA44A3790(player) {
  _id_4A0D1F5F6BE0F8C7::_id_305F60799DC60D7C(player);
}

_id_735FE9EC0C4DD312(_id_642470E1ABC1BBF9) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  if(!isDefined(_id_642470E1ABC1BBF9.victim)) {
    return;
  }
  thread _id_362C58E8BB39BCDA::runbrgametypefunc("preOnPlayerKilled", _id_642470E1ABC1BBF9);

  if(!isDefined(_id_642470E1ABC1BBF9.attacker) || !isPlayer(_id_642470E1ABC1BBF9.attacker) || _id_642470E1ABC1BBF9.attacker == _id_642470E1ABC1BBF9.victim) {
    return;
  }
  _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(_id_642470E1ABC1BBF9.attacker.team, "aliveCount");

  if(_id_BCE4EFC75EB01319 <= 0) {
    return;
  }
  _id_642470E1ABC1BBF9.attacker _id_FF9954EB6FA229A8(_id_642470E1ABC1BBF9.attacker.team, _id_642470E1ABC1BBF9.victim.team);
  _id_642470E1ABC1BBF9.attacker thread _id_7AF0DACEE64943C2(_id_642470E1ABC1BBF9.attacker.team, _id_642470E1ABC1BBF9.victim);
}

_id_FF9954EB6FA229A8(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98) {
  if(!level.brgametype._id_6420B42C7ADD53CC) {
    return;
  }
  _id_E6D99D0E23BF8BF1(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98);
}

_id_7AF0DACEE64943C2(team, _id_3E59C6682B60D27E) {
  level endon("game_ended");

  if(!level.brgametype._id_F6682C80C3C868D6) {
    return;
  }
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(team, "aliveCount");

  if(_id_BCE4EFC75EB01319 <= 0) {
    return;
  }
  _id_D0B996FDE8BFC937 = level.teamdata[team]["deadPlayers"];

  if(_id_D0B996FDE8BFC937.size <= 0) {
    return;
  }
  _id_4E776A22240FF174 = _id_C033AB6F3FAA6FCA(_id_D0B996FDE8BFC937, _id_3E59C6682B60D27E);
  _id_5535FF78FC16526E(_id_4E776A22240FF174, _id_3E59C6682B60D27E);
}

_id_C033AB6F3FAA6FCA(_id_D0B996FDE8BFC937, _id_3E59C6682B60D27E) {
  _id_4E776A22240FF174 = [];

  if(istrue(level.brgametype._id_FBC20F6D398B973E)) {
    foreach(item in _id_D0B996FDE8BFC937) {
      if(!isDefined(item)) {
        continue;
      }
      _id_4E776A22240FF174 = scripts\engine\utility::array_add(_id_4E776A22240FF174, item);
      break;
    }
  } else {
    foreach(item in _id_D0B996FDE8BFC937) {
      if(!isDefined(item)) {
        continue;
      }
      if(isDefined(item._id_6181DE250AFA5BB6) && item._id_6181DE250AFA5BB6 == _id_3E59C6682B60D27E && isDefined(item.player))
        _id_4E776A22240FF174 = scripts\engine\utility::array_add(_id_4E776A22240FF174, item.player);
    }
  }

  return _id_4E776A22240FF174;
}

_id_5535FF78FC16526E(_id_4E776A22240FF174, _id_E48B3D05087E93F5) {
  if(_id_4E776A22240FF174.size <= 0) {
    return;
  }
  foreach(_id_F0EA4030349A33D5 in _id_4E776A22240FF174) {
    if(!isDefined(_id_F0EA4030349A33D5)) {
      continue;
    }
    _id_9D794B8A2AD15CD5(_id_F0EA4030349A33D5);
  }

  if(!istrue(level.brgametype._id_7B3746FD57041FB7))
    _id_A380C47216DC87A7(self, _id_E48B3D05087E93F5, _id_4E776A22240FF174);

  thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("champion_avenge_teammate", self);
}

_id_9D794B8A2AD15CD5(_id_92A674D94DF29E77) {
  if(istrue(level.brgametype._id_7B3746FD57041FB7))
    _id_92A674D94DF29E77.respawndelay = _id_92A674D94DF29E77.respawndelay - getdvarint("dvar_E72DBD678E8FC4F4", 5);
  else
    _id_92A674D94DF29E77 thread _id_6DD03F431350EE4C(1, level.teamdata[_id_92A674D94DF29E77.team]["alivePlayers"]);
}

_id_6F0F4E7B3FF7B57C(_id_A93508890D2545D1) {
  _id_9EA49C3096713D26 = -1;
  _id_3071102F98CBED33 = 2147483647;

  foreach(_id_109EBF347B2F2ECE, _id_CF7D42708E58BB98 in _id_A93508890D2545D1) {
    if(_id_CF7D42708E58BB98["startTime"] < _id_3071102F98CBED33) {
      _id_9EA49C3096713D26 = _id_109EBF347B2F2ECE;
      _id_3071102F98CBED33 = _id_CF7D42708E58BB98["startTime"];
    }
  }

  return _id_9EA49C3096713D26;
}

_id_85FEE305E2D829C1(array, _id_FABF84450735DD93) {
  _id_81113FD663E237B1 = -1;

  foreach(index, team in array) {
    if(team["name"] == _id_FABF84450735DD93) {
      _id_81113FD663E237B1 = index;
      break;
    }
  }

  return _id_81113FD663E237B1;
}

_id_0611500F4751AAF1(_id_3A7747BC9807F3C0, _id_3EDA0EF65C9478AC, _id_109EBF347B2F2ECE) {
  _id_5BA62BE302F54D98 = int(pow(2, 8));
  _id_8501F555EA8DBE78 = 8 * _id_109EBF347B2F2ECE;
  _id_F3877FB86A0EAA6C = _id_5BA62BE302F54D98 - 1;
  _id_F3877FB86A0EAA6C = _id_F3877FB86A0EAA6C << _id_8501F555EA8DBE78;
  _id_F8F977081D3DA8B4 = ~_id_F3877FB86A0EAA6C;
  _id_3A7747BC9807F3C0 = _id_3A7747BC9807F3C0 &_id_F8F977081D3DA8B4;
  _id_1CC902F24EF7CC11 = _id_3EDA0EF65C9478AC << _id_8501F555EA8DBE78;
  _id_3A7747BC9807F3C0 = _id_3A7747BC9807F3C0 | _id_1CC902F24EF7CC11;
  return _id_3A7747BC9807F3C0;
}

_id_D6D795DB2CAE2C1B(_id_29412B34AF141C29, _id_3E00D2D6FB1BD934, _id_8DB0C8D0A8DA2329) {
  _id_3A7747BC9807F3C0 = -1;

  foreach(player in _id_29412B34AF141C29) {
    if(isDefined(player)) {
      if(_id_3A7747BC9807F3C0 < 0) {
        _id_3A7747BC9807F3C0 = player getclientomnvar("resurgence_tracked_teams");
        _id_3A7747BC9807F3C0 = _id_0611500F4751AAF1(_id_3A7747BC9807F3C0, _id_3E00D2D6FB1BD934, _id_8DB0C8D0A8DA2329);
      }

      player setclientomnvar("resurgence_tracked_teams", _id_3A7747BC9807F3C0);
    }
  }
}

_id_F6686365221E78CB() {
  _id_840B848760F488A4 = getdvarint("dvar_96C8E4682FF85B5F", 0);
  _id_A93508890D2545D1 = [];

  if(istrue(_id_840B848760F488A4))
    _id_A93508890D2545D1 = scripts\mp\utility\teams::getteamdata(self.team, "trackedTeams");
  else {
    if(!isDefined(self._id_A93508890D2545D1))
      self._id_A93508890D2545D1 = [];

    _id_A93508890D2545D1 = self._id_A93508890D2545D1;
  }

  return _id_A93508890D2545D1;
}

_id_E6D99D0E23BF8BF1(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98) {
  _id_BB58BCC7B0654344 = -1;
  _id_A93508890D2545D1 = _id_F6686365221E78CB();
  _id_BB58BCC7B0654344 = _id_85FEE305E2D829C1(_id_A93508890D2545D1, _id_CF7D42708E58BB98);

  if(_id_BB58BCC7B0654344 < 0) {
    if(_id_A93508890D2545D1.size == 4)
      _id_BB58BCC7B0654344 = _id_6F0F4E7B3FF7B57C(_id_A93508890D2545D1);
    else
      _id_BB58BCC7B0654344 = _id_A93508890D2545D1.size;
  }

  if(_id_BB58BCC7B0654344 < 0 || _id_BB58BCC7B0654344 >= 4) {
    return;
  }
  thread _id_7CA4D46DFE174E90(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98, _id_BB58BCC7B0654344);
}

_id_7CA4D46DFE174E90(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98, _id_BB58BCC7B0654344) {
  if(_id_BB58BCC7B0654344 < 0 || _id_BB58BCC7B0654344 >= 4) {
    return;
  }
  notifyname = "trackTeam" + _id_A1B4FAB5A3B4FA5E + _id_BB58BCC7B0654344;
  _id_29412B34AF141C29 = [];
  _id_05B1596320DF748C = [];
  _id_05B1596320DF748C["name"] = _id_CF7D42708E58BB98;
  _id_05B1596320DF748C["startTime"] = gettime();
  _id_840B848760F488A4 = getdvarint("dvar_96C8E4682FF85B5F", 0);

  if(istrue(_id_840B848760F488A4)) {
    level notify(notifyname);
    level endon(notifyname);
    level.teamdata[_id_A1B4FAB5A3B4FA5E]["trackedTeams"][_id_BB58BCC7B0654344] = _id_05B1596320DF748C;
    _id_29412B34AF141C29 = scripts\mp\utility\teams::getteamdata(_id_A1B4FAB5A3B4FA5E, "players");
  } else {
    self notify(notifyname);
    self endon(notifyname);
    self._id_A93508890D2545D1[_id_BB58BCC7B0654344] = _id_05B1596320DF748C;
    _id_29412B34AF141C29 = [self];
  }

  _id_3E00D2D6FB1BD934 = scripts\cp_mp\utility\player_utility::getteamindex(_id_CF7D42708E58BB98);
  _id_D6D795DB2CAE2C1B(_id_29412B34AF141C29, _id_3E00D2D6FB1BD934, _id_BB58BCC7B0654344);
  _id_776DF703E8901349 = getdvarfloat("dvar_DC284649B5343DF1", 2.5);
  wait(_id_776DF703E8901349);
  _id_D6D795DB2CAE2C1B(_id_29412B34AF141C29, 0, _id_BB58BCC7B0654344);
}

_id_E003A419D3914C23() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level waittill("infils_ready");
  _id_10B5C13C81DB5079 = _id_B398ACC9BA21ECB5();

  if(_id_10B5C13C81DB5079 < 0) {
    return;
  }
  totaltime = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_10B5C13C81DB5079; _id_AC0E594AC96AA3A8++)
    totaltime = totaltime + (level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8] + level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8]);

  _id_F9F04F141AE1E4D4 = int(totaltime * 1000);
  _id_7BF1255A3715A632 = gettime();
  _id_3112E3DE7BF7F005 = _id_7BF1255A3715A632 + _id_F9F04F141AE1E4D4;
  setomnvarforallclients("ui_br_timed_feature_end_time", _id_3112E3DE7BF7F005);
  setomnvarforallclients("ui_br_resurgence_will_disable", 0);
  level._id_01FCBA68EFD8D4BF = totaltime;
  _id_A9A4271FA4D4ACEE = _id_F9F04F141AE1E4D4;
  _id_EB17C8739491B838 = getdvarint("dvar_342776B421CE99FA", 90000);
  thread _id_C2890D0252B9F16D(_id_A9A4271FA4D4ACEE / 1000);

  while(_id_A9A4271FA4D4ACEE > _id_EB17C8739491B838) {
    wait((_id_A9A4271FA4D4ACEE - _id_EB17C8739491B838) / 1000);
    _id_6CF8E0BF922944AE = gettime() - _id_7BF1255A3715A632;
    _id_A9A4271FA4D4ACEE = _id_F9F04F141AE1E4D4 - _id_6CF8E0BF922944AE;
  }

  setomnvarforallclients("ui_br_resurgence_will_disable", 1);
  setomnvarforallclients("ui_br_timed_feature_end_time", int(gettime() + _id_A9A4271FA4D4ACEE));

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player thread scripts\mp\hud_message::showsplash("br_resurgence_reinforcement_closing", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp_mgl");
  }
}

_id_C2890D0252B9F16D(remainingtime) {
  wait(remainingtime - 90);
  _id_2CEDCC356F1B9FC8::brleaderdialog("champion_ending");
}

_id_2573E08A439335F7() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.brgametype.respawndelay = [];
  level.brgametype._id_A427C307DE983162 = getdvarint("dvar_8676FE51DAAEABE1", 1);
  _id_10B5C13C81DB5079 = _id_B398ACC9BA21ECB5();

  if(level.brgametype._id_A427C307DE983162 && _id_10B5C13C81DB5079 >= 0) {
    _id_31F53A82B8311132 = ["dvar_54321AD57677EE05", "dvar_543219D57677EBD2", "dvar_543218D57677E99F", "dvar_543217D57677E76C", "dvar_543216D57677E539", "dvar_543215D57677E306", "dvar_543214D57677E0D3", "dvar_543213D57677DEA0", "dvar_543222D57677FF9D", "dvar_543221D57677FD6A"];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_10B5C13C81DB5079; _id_AC0E594AC96AA3A8++)
      level.brgametype.respawndelay[_id_AC0E594AC96AA3A8] = getdvarint(_id_31F53A82B8311132[_id_AC0E594AC96AA3A8], 20);
  } else
    level.brgametype.respawndelay[0] = getdvarint("dvar_4DB324F75255CC28", 20);
}

_id_B909ABB7A17A92AD() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue &~16384;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", _id_8F617FFD000EB682);
}

_id_6BB3D05538568538() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue | 16384;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", _id_8F617FFD000EB682);
}

_id_9B57A5870079DEE1() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue | 32768;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", _id_8F617FFD000EB682);
}

_id_80A44396D4052334() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue &~32768;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", _id_8F617FFD000EB682);
}

_id_6238A0C9226288BC(value) {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_0A31AE8D2963FA9D = currentvalue &~16383;
  _id_8F617FFD000EB682 = _id_0A31AE8D2963FA9D | value;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", _id_8F617FFD000EB682);
}

_id_A4F5EAE4925AD484(value) {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_0A31AE8D2963FA9D = currentvalue &~2147418112;
  forceupdate = currentvalue & 1073741824;

  if(forceupdate != 0)
    forceupdate = 0;
  else
    forceupdate = 1073741824;

  _id_8F617FFD000EB682 = _id_0A31AE8D2963FA9D | value << 16 | forceupdate;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", _id_8F617FFD000EB682);
}

_id_D04DAAB64EA0D3DF(player) {
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_F0EA4030349A33D5 in _id_A6AB8D0FDA441DC2) {
    _id_F5AA9C197C4CF398 = _id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag();
    _id_73409C2EDFA9E4F9 = isalive(_id_F0EA4030349A33D5) && !istrue(_id_F0EA4030349A33D5.inlaststand);

    if(_id_F0EA4030349A33D5 != player && _id_73409C2EDFA9E4F9 && !_id_F5AA9C197C4CF398)
      return 1;
  }

  return 0;
}

_id_DE118D63BF624508() {
  player = self;

  if(player _id_67708F418B1FAC79::_id_4A25D64251FAB1B7()) {
    player _id_348449F96FF7CEF8(level.teamdata[player.team]["alivePlayers"]);
    _id_1F8DA2719751FC5F();
    player scripts\mp\playerlogic::addtoalivecount("champion_gulag");
    _id_0A34750D17473C49::unmarkplayeraseliminated(player);
    _id_4911936F026C8E38 = _id_1E4A61DB11011446::brmayconsiderplayerdead(player);

    if(!_id_4911936F026C8E38)
      _id_67708F418B1FAC79::entergulag(player);

    self.waitingtospawn = 0;
  }
}

_id_AAC26C7A1CFE6C48() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("doingRespawn");

  if(istrue(level.brgametype._id_55F0D9F2A10553C4)) {
    while(_id_D04DAAB64EA0D3DF(self))
      waitframe();

    _id_B909ABB7A17A92AD();
    self notify("squad_wiped");
    waitframe();
    _id_DE118D63BF624508();
  } else {
    for(_id_849D01AFB2FC0F0A = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount"); _id_849D01AFB2FC0F0A > 0; _id_849D01AFB2FC0F0A = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount"))
      waitframe();

    _id_B909ABB7A17A92AD();
    _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("respawnInSeconds", 0);
    self notify("squad_wiped");
  }
}

_id_5DFD73C97BF5D03D(player, _id_E851FFA44B7E0D54, event, points, _id_645B1A1D2A1DDFB7) {
  if(!isDefined(player)) {
    return;
  }
  if(!isalive(player)) {
    return;
  }
  if(points <= 0) {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_done") || !scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }
  if(isDefined(event) && isDefined(_id_645B1A1D2A1DDFB7) && event == "br_kioskBuy" && _id_645B1A1D2A1DDFB7 == "br_team_revive") {
    _id_780D8A24242378D5 = scripts\mp\utility\teams::getteamdata(player.team, "aliveCount");
    _id_CD51AB4357F76C8C = scripts\mp\utility\teams::getteamdata(player.team, "teamCount");
    _id_DE1F625722D92973 = _id_CD51AB4357F76C8C - _id_780D8A24242378D5;

    if(_id_DE1F625722D92973 == 1)
      return;
  }

  _id_09A5E708D6675417 = getdvarfloat("dvar_87972322CE9BEAE8", 0.02);
  _id_36A08DC900BABAF2 = getdvarint("dvar_530E945BB955C51F", 50);
  _id_91F726FA8B73DDD5 = int(floor((points + _id_36A08DC900BABAF2) * _id_09A5E708D6675417));

  if(isDefined(event)) {
    if(event == "br_kioskBuy") {
      _id_C7C9A35C374FA86F = getdvarfloat("dvar_0EA4CF932BDA2F0B", 0.3);
      _id_91F726FA8B73DDD5 = int(ceil(_id_91F726FA8B73DDD5 * _id_C7C9A35C374FA86F));
    } else if(event == "kill")
      _id_91F726FA8B73DDD5 = int(floor((250 + _id_36A08DC900BABAF2) * _id_09A5E708D6675417));
    else if(event == "br_cacheOpen")
      _id_91F726FA8B73DDD5 = int(floor((100 + _id_36A08DC900BABAF2) * _id_09A5E708D6675417));
  }

  if(_id_91F726FA8B73DDD5 <= 0) {
    return;
  }
  playerteam = level.teamdata[player.team];

  if(!isDefined(playerteam)) {
    return;
  }
  if(isDefined(level._id_D937F91DC5EF2330) && isDefined(level._id_D937F91DC5EF2330._id_73B8B368E62EADA0) && isDefined(level._id_D937F91DC5EF2330._id_300BC2BE9CF48540) && player.team == level._id_D937F91DC5EF2330._id_300BC2BE9CF48540)
    _id_91F726FA8B73DDD5 = _id_91F726FA8B73DDD5 * level._id_D937F91DC5EF2330._id_73B8B368E62EADA0;

  _id_77AE8A032E59320B = playerteam["deadPlayers"];

  if(!isDefined(_id_77AE8A032E59320B)) {
    return;
  }
  _id_7CD081D8BBC27830 = 0;

  foreach(dead in _id_77AE8A032E59320B) {
    if(isDefined(dead) && isDefined(dead.player) && dead.player != player) {
      if(dead.player.respawndelay > 0) {
        dead.player.respawndelay = int(max(0, dead.player.respawndelay - _id_91F726FA8B73DDD5));

        if(!isDefined(dead.player._id_C54AFD6E867E686B))
          dead.player._id_C54AFD6E867E686B = 0;

        dead.player._id_C54AFD6E867E686B = dead.player._id_C54AFD6E867E686B + _id_91F726FA8B73DDD5;
        _id_7CD081D8BBC27830 = 1;
      }
    }
  }

  if(_id_7CD081D8BBC27830) {
    if(istrue(player._id_5C3B157495F480A2))
      player._id_5449B5708779EE8E = player._id_5449B5708779EE8E + _id_91F726FA8B73DDD5;
    else {
      player._id_5C3B157495F480A2 = 1;
      player._id_5449B5708779EE8E = _id_91F726FA8B73DDD5;
      player thread _id_BB5D745AD4AED02C();
    }
  }
}

_id_BB5D745AD4AED02C() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("squad_wiped");
  wait 0.5;

  if(isDefined(self._id_5449B5708779EE8E) && self._id_5449B5708779EE8E > 0)
    _id_A4F5EAE4925AD484(self._id_5449B5708779EE8E);

  self._id_5449B5708779EE8E = undefined;
  self._id_5C3B157495F480A2 = 0;
}

_id_3C88EC256B493BD0() {
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("squad_wiped");
  player endon("force_stop_respawn");

  if(!istrue(level.brgametype._id_B43745B85F249E68))
    player thread _id_AAC26C7A1CFE6C48();

  player thread _id_C1A20EDBED65900B();

  if(isDefined(level.brgametype._id_C655C38108F1827F))
    player.respawndelay = level.brgametype._id_C655C38108F1827F;
  else if(level.br_circle.circleindex < 0) {
    player.respawndelay = level.brgametype.respawndelay[0];

    if(istrue(level.brgametype._id_FC3B5A2E206A85F2))
      player.respawndelay = level.brgametype._id_6B7F1DCB0FD6591D;
  } else {
    circleindex = int(min(level.br_circle.circleindex, level.brgametype.respawndelay.size - 1));
    player.respawndelay = level.brgametype.respawndelay[circleindex];

    if(istrue(level.brgametype._id_FC3B5A2E206A85F2))
      player.respawndelay = level.brgametype._id_6B7F1DCB0FD6591D;
  }

  if(!isDefined(player.respawndelay)) {
    _id_539576F2B677F552 = "";
    _id_75C7789394667F32 = "\n";
    _id_79B9159E31664699 = getarraykeys(game["flags"]);

    foreach(name in _id_79B9159E31664699)
    _id_75C7789394667F32 = _id_75C7789394667F32 + (name + " -> " + game["flags"][name] + "\n");

    _id_539576F2B677F552 = _id_539576F2B677F552 + _id_75C7789394667F32;
    scripts\mp\utility\script::demoforcesre(_id_539576F2B677F552);
    player.respawndelay = 20;
  }

  if(getdvarint("dvar_D31B1C01A86089C2", 1) == 1 && isalive(player)) {
    scripts\mp\utility\script::demoforcesre("Alive player added to resurgence countdown. IsAlive: " + isalive(player) + ". Sessionstate: " + player.sessionstate);
    waitframe();
    scripts\mp\utility\script::demoforcesre("Alive player added to resurgence countdown - after waitframe. IsAlive: " + isalive(player) + ". Sessionstate: " + player.sessionstate);
  }

  player _id_80A44396D4052334();
  player _id_6BB3D05538568538();
  player _id_6238A0C9226288BC(player.respawndelay);

  for(player._id_C54AFD6E867E686B = 0; player.respawndelay > 0; player.respawndelay--) {
    if(player.respawndelay <= 5)
      player playsoundtoplayer("ui_mp_resurgence_timer_quarter_sec", player);
    else if(player.respawndelay <= 10)
      player playsoundtoplayer("ui_mp_resurgence_timer_half_sec", player);
    else if(player.respawndelay % 4 == 2)
      player playsoundtoplayer("ui_mp_resurgence_timer", player);
    else
      player playsoundtoplayer("ui_mp_resurgence_timer_tick", player);

    if(isalive(player))
      player.respawndelay = 0;
    else
      player _id_6238A0C9226288BC(player.respawndelay);

    player _id_A4F5EAE4925AD484(player._id_C54AFD6E867E686B);
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("respawnInSeconds", player.respawndelay);
    player._id_C54AFD6E867E686B = 0;
    wait 1;
  }

  player _id_B909ABB7A17A92AD();
  player _id_A4F5EAE4925AD484(0);
  player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("respawnInSeconds", 0);

  if(!isalive(player)) {
    if(isDefined(player.team)) {
      _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(player.team, player, 14, 1);

      foreach(_id_F0EA4030349A33D5 in level.teamdata[player.team]["alivePlayers"]) {
        if(!istrue(_id_F0EA4030349A33D5._id_0024278E2EC4540E))
          _id_F0EA4030349A33D5 thread _id_53B4CAF82507F423();
      }
    }

    player thread _id_6DD03F431350EE4C(0, level.teamdata[player.team]["alivePlayers"]);
  }
}

_id_53B4CAF82507F423() {
  level endon("game_ended");
  self._id_0024278E2EC4540E = 1;
  thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("champion_teammate_respawn", self);
  wait 5;
  self._id_0024278E2EC4540E = undefined;
}

_id_C1A20EDBED65900B() {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();
  _id_81F2B277D31BB707();
}

_id_81F2B277D31BB707() {
  if(istrue(level.brgametype._id_AD3C825B1DD7D9A8)) {
    return;
  }
  _id_92884735D8E33FBB = self;

  if(!istrue(level.brgametype._id_FBC20F6D398B973E)) {
    _id_92884735D8E33FBB = spawnStruct();
    _id_92884735D8E33FBB.player = self;
    _id_92884735D8E33FBB._id_6181DE250AFA5BB6 = self.lastkilledby;
  }

  _id_7193E062042F638D = [];
  _id_77AE8A032E59320B = level.teamdata[self.team]["deadPlayers"];

  foreach(dead in _id_77AE8A032E59320B) {
    if(isDefined(dead))
      _id_7193E062042F638D[_id_7193E062042F638D.size] = dead.player.name;
  }

  level.teamdata[self.team]["deadPlayers"] = scripts\engine\utility::array_add(level.teamdata[self.team]["deadPlayers"], _id_92884735D8E33FBB);
}

_id_1F8DA2719751FC5F() {
  if(istrue(level.brgametype._id_AD3C825B1DD7D9A8)) {
    return;
  }
  _id_77AE8A032E59320B = level.teamdata[self.team]["deadPlayers"];

  if(istrue(level.brgametype._id_FBC20F6D398B973E))
    _id_77AE8A032E59320B = scripts\engine\utility::array_remove(_id_77AE8A032E59320B, self);
  else {
    _id_D674D7970EEF9653 = [];

    foreach(item in _id_77AE8A032E59320B) {
      if(isDefined(item) && item.player != self)
        _id_D674D7970EEF9653[_id_D674D7970EEF9653.size] = item;
    }

    _id_77AE8A032E59320B = _id_D674D7970EEF9653;
  }

  level.teamdata[self.team]["deadPlayers"] = _id_77AE8A032E59320B;
}

_id_6DD03F431350EE4C(_id_CB5BA4C3282C39C1, _id_54EBFC906D9A55E7) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("doingRespawn");

  if(istrue(player.respawningfromtoken)) {
    return;
  }
  player.respawningfromtoken = 1;

  if(istrue(level.brgametype._id_6F3C4D74A8C614AB))
    player notify("started_spawnPlayer");

  if(istrue(_id_CB5BA4C3282C39C1)) {
    player _id_9B57A5870079DEE1();
    player thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
    wait 1.5;
  }

  player _id_348449F96FF7CEF8(_id_54EBFC906D9A55E7);
  _id_1F8DA2719751FC5F();
  player scripts\mp\playerlogic::addtoalivecount("champion");
  _id_0A34750D17473C49::unmarkplayeraseliminated(player);
  player _id_7E52B56769FA7774::addrespawntoken(1);
  _id_1476E0F78320A501 = 0;

  if(istrue(level.brgametype._id_A916B204F027AF6B))
    _id_1476E0F78320A501 = player _id_5BAB271917698DC4::playerwaitforprestreaming();

  streamtimeout = _id_2CEDCC356F1B9FC8::getdefaultstreamhinttimeoutms() / 1000;
  spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102(0, streamtimeout);
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  self.forcespawnorigin = _id_11F3B4465C8B637B;

  if(_id_1476E0F78320A501)
    player scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  _id_B59F471C2C064E56 = 1.0;
  player _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  wait(_id_B59F471C2C064E56);
  player _id_B909ABB7A17A92AD();
  player scripts\mp\hud_message::clearsplashqueue();
  player scripts\mp\playerlogic::spawnplayer(undefined, 0);
  player scripts\cp_mp\execution::_clearexecution();
  player _id_7E52B56769FA7774::initplayer();
  player _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
  player.respawningfromtoken = undefined;
  player _id_80A44396D4052334();
  player thread _id_5BAB271917698DC4::triggerrespawnoverlay(20);
  player respawn(spawnpoint, _id_11F3B4465C8B637B);
}

triggerrespawnoverlay() {
  wait 0.5;
  return 1;
}

respawn(spawnpoint, _id_11F3B4465C8B637B) {
  level notify("update_circle_hide");

  if(isDefined(self.oobimmunity))
    scripts\mp\outofbounds::disableoobimmunity(self);

  _id_1E4A61DB11011446::givelaststandifneeded(self);
  _id_C04B5EDF3F9EA340();

  if(!isDefined(spawnpoint))
    spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();

  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(_id_11F3B4465C8B637B))
    startorigin = _id_11F3B4465C8B637B;

  _id_5BAB271917698DC4::_id_961B4AFC4C695B94();
  self setOrigin(startorigin, 1);
  self setplayerangles(spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(self);
  self playerlinktoabsolute(linker, "tag_origin");
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_gametype_champion::respawn()");
  thread _id_5BAB271917698DC4::playercleanupentondisconnect(linker);
  waitframe();
  playerrespawncleanup();

  if(getdvarint("dvar_DF02345C60008647", 1) == 0)
    _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();

  _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();

  if(isDefined(_id_11F3B4465C8B637B))
    linker.origin = spawnorigin;

  linker playsoundtoplayer("br_ac130_flyby", self);
  wait 1.5;
  self unlink();
  self clearsoundsubmix("deaths_door_mp");

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    self clearsoundsubmix("iw8_br_gulag_tutorial", 2);
  else
    self clearsoundsubmix("solo_cin_igc_music", 2);

  self clearclienttriggeraudiozone(1);
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_gametype_champion::respawn()");
  playersetcontrols(1);
  _id_BDA1DE83E1856735 = 0;

  if(isDefined(level.parachutedeploydelay))
    _id_BDA1DE83E1856735 = level.parachutedeploydelay;

  if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    thread scripts\cp_mp\parachute::startfreefall(_id_BDA1DE83E1856735, 0, undefined, undefined, 1);

  if(scripts\mp\utility\game::getgametype() == "br")
    self setclientomnvar("ui_show_spectateHud", -1);

  _id_5BAB271917698DC4::resetplayermovespeedscale();
  _id_07C40FA80892A721::givestartingarmor();
  _id_3ACF1C0EBAF602F2::onplayerrespawn();
  _id_4D5A55FCA0ED1835::onplayerrespawn();
  _id_7E52B56769FA7774::removerespawntoken();
  wait 0.5;

  if(scripts\mp\utility\game::getgametype() == "br")
    thread _id_5BAB271917698DC4::playercinematicfadeout();

  waitframe();
  linker delete();

  if(istrue(level._id_3FF7C73209FCF59D))
    _id_002E0206D4774172::_id_FA674FB6E8372620();

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    self notify("respawn_from_gulag");

  self notify("can_show_splashes");

  if(!istrue(level.ignoregulagredeploysplash))
    thread scripts\mp\hud_message::showsplash("br_resurgence_redeploy", 20, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp_mgl");

  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("champion_redeploy", self);
}

playerrespawncleanup() {
  self notify("resurgenceRespawn");
  self.health = self.maxhealth;
  _id_3B64EB40368C1450::set("resurgenceRespawn", "player_for_spawn_logic", 0);
  _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isRespawning", 0);
}

_id_C04B5EDF3F9EA340() {
  if(isDefined(level.br_standard_loadout) || getdvarint("dvar_F97D261E2F377AD9", 1) != 0)
    self.gulagtableloadout = 1;
}

playersetcontrols(enable) {
  if(enable) {
    self enableoffhandweapons();
    self enableusability();
  } else {
    self disableoffhandweapons();
    self disableusability();
  }
}

_id_391B372CD3C0DDDC() {
  loadout = level.br_standard_loadout;

  if(isDefined(level._id_C04B5EDF3F9EA340)) {
    circleindex = 0;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      circleindex = min(level.br_circle.circleindex, level._id_C04B5EDF3F9EA340.size);
      circleindex = int(circleindex);
    }

    if(isDefined(level._id_77C121D31E587BA8[circleindex]))
      loadout = level._id_C04B5EDF3F9EA340[circleindex][level._id_77C121D31E587BA8[circleindex]];
  }

  return loadout;
}

_id_B8D1B2B54AD5F08D() {
  _id_C179E44BD14D2D12 = 0;

  if(isDefined(level._id_C04B5EDF3F9EA340)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      if(level.br_circle.circleindex == level._id_C04B5EDF3F9EA340.size - 1)
        _id_C179E44BD14D2D12 = 1;
    }
  }

  return _id_C179E44BD14D2D12;
}

playernakeddroploadout() {
  if(istrue(level._id_52BA18A9DC3B6BFD)) {
    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("giveFavoriteLoadout"))
      _id_362C58E8BB39BCDA::runbrgametypefunc("giveFavoriteLoadout");
  } else if(istrue(level.brgametype._id_D6DC578C217F88CF) && isDefined(self._id_5FB036C33CDDD360))
    _id_1E4A61DB11011446::_id_7FBB2E52F100474E();
  else {
    if(!istrue(self._id_AB5F5270CB22E3C8)) {
      _id_DAB2D2EFDE751B62 = "classtable:classtable_br_vanilla";
      level.br_standard_loadout = _id_1E4A61DB11011446::initstandardloadout(_id_DAB2D2EFDE751B62, 0);
      self._id_AB5F5270CB22E3C8 = 1;
    } else
      level.br_standard_loadout = _id_391B372CD3C0DDDC();

    _id_C179E44BD14D2D12 = _id_B8D1B2B54AD5F08D();
    _id_1E4A61DB11011446::givestandardtableloadout(0, 1, _id_C179E44BD14D2D12);
  }

  if(isDefined(level._id_D937F91DC5EF2330) && level._id_D937F91DC5EF2330._id_F8A98F02F2B8BEBF == 1)
    _id_1E4A61DB11011446::brgivestartfieldupgrade();

  _id_07C40FA80892A721::givestartingarmor();

  if(!isDefined(self._id_B2B6316D154F7468)) {
    self._id_B2B6316D154F7468 = 1;
    _id_CE214AFC7B96A3A7 = getdvarint("dvar_E67C864263196598", 0);

    if(_id_CE214AFC7B96A3A7)
      _id_7E52B56769FA7774::addselfrevivetoken(1);

    _id_BC5632FFDB336731 = getdvarint("dvar_5868A46B12B1B4DD", 0);

    if(_id_BC5632FFDB336731)
      scripts\mp\perks\perks::addspecialistbonus();
  } else {
    _id_CE214AFC7B96A3A7 = getdvarint("dvar_CD33C7AD9A88587F", 0);

    if(_id_CE214AFC7B96A3A7)
      _id_7E52B56769FA7774::addselfrevivetoken(1);

    _id_BC5632FFDB336731 = getdvarint("dvar_5868A46B12B1B4DD", 0);

    if(_id_BC5632FFDB336731)
      scripts\mp\perks\perks::addspecialistbonus();
  }

  return 0;
}

_id_B398ACC9BA21ECB5() {
  return getdvarint("dvar_05C872AF62541D1D", 3);
}

circletimer(circleindex) {
  if(istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    _id_10B5C13C81DB5079 = _id_B398ACC9BA21ECB5();

    if(circleindex >= _id_10B5C13C81DB5079 && _id_10B5C13C81DB5079 >= 0)
      _id_1A3782804D2407E5();
  }
}

_id_1A3782804D2407E5() {
  level.brgametype._id_C42E40EC22A1F0D4 = 0;
  level notify("respawn_disabled");
  _id_747B066379119D51();
  _id_362C58E8BB39BCDA::runbrgametypefunc("resurgenceDisable");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    _id_1671F48D05259D22::dangernotifyplayer(player, "respawn_disabled", 2);
    player setclientomnvar("ui_br_timed_feature_end_time", 0);
    player _id_362C58E8BB39BCDA::runbrgametypefunc("playerResurgenceDisable");
  }

  _id_2CEDCC356F1B9FC8::brleaderdialog("champion_disabled");
}

_id_97B175CEC5B685BE(table) {
  if(!isDefined(level._id_C04B5EDF3F9EA340))
    level._id_C04B5EDF3F9EA340 = [];

  _id_A78225C464121E51 = level._id_C04B5EDF3F9EA340.size;
  _id_07D958726E11B327 = tablelookupgetnumcols(table) - 1;
  level._id_C04B5EDF3F9EA340[_id_A78225C464121E51] = [];

  for(_id_089688461C79EF11 = 0; _id_089688461C79EF11 < _id_07D958726E11B327; _id_089688461C79EF11++)
    level._id_C04B5EDF3F9EA340[_id_A78225C464121E51][level._id_C04B5EDF3F9EA340[_id_A78225C464121E51].size] = _id_AA8A954D66BF39B4(_id_089688461C79EF11, table);

  level._id_77C121D31E587BA8 = [];

  foreach(circleindex, _id_1A9E152363126A93 in level._id_C04B5EDF3F9EA340) {
    if(isDefined(level._id_C04B5EDF3F9EA340[circleindex]) && level._id_C04B5EDF3F9EA340[circleindex].size > 0)
      level._id_77C121D31E587BA8[circleindex] = randomintrange(0, level._id_C04B5EDF3F9EA340[circleindex].size);
  }
}

_id_AA8A954D66BF39B4(_id_089688461C79EF11, table) {
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = tablelookup(table, 0, "loadoutPrimary", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment"] = tablelookup(table, 0, "loadoutPrimaryAttachment1", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment2"] = tablelookup(table, 0, "loadoutPrimaryAttachment2", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment3"] = tablelookup(table, 0, "loadoutPrimaryAttachment3", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment4"] = tablelookup(table, 0, "loadoutPrimaryAttachment4", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryAttachment5"] = tablelookup(table, 0, "loadoutPrimaryAttachment5", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryCamo"] = tablelookup(table, 0, "loadoutPrimaryCamo", _id_089688461C79EF11 + 1);
  loadout["loadoutPrimaryReticle"] = tablelookup(table, 0, "loadoutPrimaryReticle", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondary"] = tablelookup(table, 0, "loadoutSecondary", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment"] = tablelookup(table, 0, "loadoutSecondaryAttachment1", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment2"] = tablelookup(table, 0, "loadoutSecondaryAttachment2", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment3"] = tablelookup(table, 0, "loadoutSecondaryAttachment3", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment4"] = tablelookup(table, 0, "loadoutSecondaryAttachment4", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryAttachment5"] = tablelookup(table, 0, "loadoutSecondaryAttachment5", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryCamo"] = tablelookup(table, 0, "loadoutSecondaryCamo", _id_089688461C79EF11 + 1);
  loadout["loadoutSecondaryReticle"] = tablelookup(table, 0, "loadoutSecondaryReticle", _id_089688461C79EF11 + 1);
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = tablelookup(table, 0, "loadoutEquipmentPrimary", _id_089688461C79EF11 + 1);
  loadout["loadoutEquipmentSecondary"] = tablelookup(table, 0, "loadoutEquipmentSecondary", _id_089688461C79EF11 + 1);
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [tablelookup(table, 0, "loadoutPerk1", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutPerk2", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutPerk3", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutExtraPerk1", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutExtraPerk2", _id_089688461C79EF11 + 1), tablelookup(table, 0, "loadoutExtraPerk3", _id_089688461C79EF11 + 1)];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = _id_089688461C79EF11;
  return loadout;
}

_id_0641EEE023180065() {
  if(!istrue(level.brgametype._id_FC3B5A2E206A85F2)) {
    return;
  }
  if(!isDefined(level.brgametype._id_EAC0ACA57FE86358))
    level.brgametype._id_EAC0ACA57FE86358 = [60, 30];

  thread _id_9EAD22D4F0EE52DA();
}

_id_9EAD22D4F0EE52DA() {
  level endon("game_ended");
  _id_415A76657415492E = 0;
  level.brgametype._id_6B7F1DCB0FD6591D = level.brgametype._id_EAC0ACA57FE86358[_id_415A76657415492E];
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level waittill("infils_ready");

  while(level.brgametype._id_C42E40EC22A1F0D4) {
    while(level.brgametype._id_6B7F1DCB0FD6591D > 0) {
      wait 1;
      level.brgametype._id_6B7F1DCB0FD6591D--;
    }

    wait 1;
    _id_415A76657415492E = int(min(_id_415A76657415492E + 1, level.brgametype._id_EAC0ACA57FE86358.size - 1));
    level.brgametype._id_6B7F1DCB0FD6591D = level.brgametype._id_EAC0ACA57FE86358[_id_415A76657415492E];
  }
}

createc130pathstruct() {
  _id_F9CBFF5134DA960B = (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], 0);
  _id_E5BD279D3767139F = level.br_level.br_circleradii[1];
  c130pathstruct = _id_45B2B4A889E633FA::createtestc130path(_id_F9CBFF5134DA960B, _id_E5BD279D3767139F);
  return c130pathstruct;
}

addtoc130infil() {
  thread kickplayersatcircleedge();
}

kickplayersatcircleedge() {
  level endon("game_ended");
  self endon("death");
  _id_432421C6EC2BFCD9 = distance(self.pathstruct.startpt, self.pathstruct.endptui);
  _id_42F65B4B53C1F5D4 = _id_432421C6EC2BFCD9 / _id_45B2B4A889E633FA::getc130speed() - 5;
  wait(_id_42F65B4B53C1F5D4);

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == "c130" && !isDefined(player.jumptype)) {
      player.jumptype = "outOfBounds";
      player notify("halo_kick_c130");
    }
  }
}

setdropbagdelay() {
  waittillframeend;
  _id_56DDE920C84C7B04 = -15;
  _id_C2D7D58BFAD1B1EE = _id_2695A20D4011076D::getcircleclosetime(1);
  _id_A14D77328BA7E8F1 = max(0, _id_C2D7D58BFAD1B1EE + _id_56DDE920C84C7B04);
  _id_7B76B8BB6B541A17 = getdvarfloat("dvar_B81B25BCD8C7D749", _id_A14D77328BA7E8F1);
  _id_362C58E8BB39BCDA::registerbrgametypedata("dropBagDelay", _id_7B76B8BB6B541A17);
}

_id_F3EE77261EEB34DD(_id_6B890E6BE7982EFB) {
  timeremaining = scripts\mp\gamelogic::gettimeremaining() / 1000;
  timeremaining = timeremaining + getdvarint("dvar_B1DC99C22B12BD63", 0);
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = _id_2695A20D4011076D::getdangercircleorigin() + (0, 0, _id_2695A20D4011076D::getdangercircleradius());
  _id_2695A20D4011076D::setstaticuicircles(timeremaining, level.br_circle.safecircleui, level.br_circle.dangercircleui, _id_6B890E6BE7982EFB);
}

_id_952548D8AED47102(_id_447913206D1F7916, timeuntilspawn, _id_F9A785628F97EEC6) {
  _id_8108B284F99B128A = getdvarfloat("dvar_D9E0311BD167F06B", 0.0);
  _id_812BBC84F9C17040 = getdvarfloat("dvar_D9BC471BD13FA615", 1.0);
  spawnorigin = _id_2695A20D4011076D::getrandompointinsafecircle(_id_8108B284F99B128A, _id_812BBC84F9C17040);

  if(isDefined(spawnorigin))
    spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(spawnorigin);

  return spawnorigin;
}

_id_A2131D000491AE2C(eattacker, victim) {
  if(victim.agent_type == "actor_enemy_mp_jugg_mgl" && isPlayer(eattacker))
    eattacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_17AB30C9BC1E4C7C");
}