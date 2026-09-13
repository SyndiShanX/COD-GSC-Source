/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_resurgence.gsc
***********************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "resurgence") {
    return;
  }
  init();
}

init() {
  _id_528570CEB9DC7BF4();
  thread _id_7269C88A927E7937();
  _id_67CAACEC6DDD6A25();
  level thread _id_8AF96D3889F46280();
  level thread _id_D7A7AA9EE1CC1071();
  setdvarifuninitialized("dvar_98FAD011285F3011", 0);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    setdvarifuninitialized("dvar_E82B8618853A182C", 2000);
  else
    setDvar("dvar_E82B8618853A182C", 2000);
}

_id_D7A7AA9EE1CC1071() {
  setomnvar("ui_br_resurgence_respawn_enabled", 1);
  level.brgametype._id_F25F680FB993CCEF = getdvarint("dvar_B06743DF480E3BB6", 0) == 1;

  if(istrue(level.brgametype._id_F25F680FB993CCEF))
    _id_E793259B8F9D5B2D();

  level.brgametype._id_04AD7C03EC4FA687 = getdvarint("dvar_4838B7C39021124C", 0) == 1;
  level.brgametype._id_9524142EB719A321 = !istrue(level.brgametype._id_B43745B85F249E68) && getdvarint("dvar_13BA9EE48D08EE48", 1) == 1;
  level.brgametype._id_BB9B77186CB79AE6 = getdvarint("dvar_F1EF637B3AB006FB", 1) == 1;
  level.brgametype._id_BBDE847AED85512A = !level.brgametype._id_04AD7C03EC4FA687 && !istrue(level.brgametype._id_B43745B85F249E68) && getdvarint("dvar_EFFCC0523BC99BB9", 1) == 1;
  level.brgametype._id_836C1FC36B00559D = getdvarint("dvar_DDDFB37F0D106B0F", 1) == 1;
  level.brgametype._id_574951D2EFF9C094 = !level.brgametype._id_04AD7C03EC4FA687 && getdvarint("dvar_5A17D3C422C65887", 0) == 1;
  level.brgametype._id_36DBCA9D337B4930 = getdvarint("dvar_7F1CABF5A72F2647", 1) == 1;
  level.brgametype._id_8947D8F4E61494FA = getdvarint("dvar_4ABDFD8D72CDF072", 1) == 1 && level.brgametype._id_BB9B77186CB79AE6;
  level.brgametype._id_FB997D1846BD5CF4 = getdvarint("dvar_0FB2C9F57E35F736", 1) == 1 && level.brgametype._id_9524142EB719A321;

  if(level.brgametype._id_BBDE847AED85512A) {
    level.brgametype._id_F8DA748DF2368691 = getdvarint("dvar_23641E104DB7AFC6", 3);
    level.brgametype._id_8F48D3F93AC1204C = getdvarint("dvar_BCE5AE6C10BB74CB", 60);
    level.brgametype._id_74427B8346A538DF = getdvarint("dvar_8AACC13E4663F7E5", 15);
  }

  _id_E30BFEC8B3D65B77();
  level.brgametype._id_6420B42C7ADD53CC = getdvarint("dvar_D2891D4180DE0553", 1);
  level.brgametype._id_840B848760F488A4 = getdvarint("dvar_96C8E4682FF85B5F", 0);
  level.brgametype._id_428C736511619824 = getdvarfloat("dvar_DC284649B5343DF1", 2.5);
  level.brgametype._id_6EE71092BE57820C = getdvarfloat("dvar_8217B0DFA2D04C31", 10);
  level.brgametype._id_F6682C80C3C868D6 = getdvarint("dvar_B13B80D2A347596E", 1);
  level.brgametype._id_FBC20F6D398B973E = getdvarint("dvar_9F287F2A37CD90F4", 0);
  level.brgametype._id_7B3746FD57041FB7 = getdvarint("dvar_0D834C362EAEEF3A", 1);
  level.brgametype._id_3DD997E45E444B3D = getdvarint("dvar_CFB769A290798F09", 1);
  level.respawnheightoverride = getdvarint("dvar_AE35E4BB8A3AA9E7", 7500);
  level.brgametype._id_2CFDC1D6E92251BF = getdvarint("dvar_E72DBD678E8FC4F4", 5);
  level.brgametype._id_B30E180B0B50D598 = getdvarint("dvar_5DC7BA56C5253EE8", 1);
  level.brgametype._id_14AFB82AA29BC57C = getdvarint("dvar_77028B51CD3D0A56", -1);
  level.brgametype._id_F439C17A413F05C3 = getdvarint("dvar_E77B23156A69CBC1", 1) == 1;
  level.brgametype._id_B8A3736F232F201A = getdvarint("dvar_51697D665F5B67FE", 1000);
  level.brgametype._id_4AF675F2894744AE = squared(level.brgametype._id_B8A3736F232F201A);
  level.brgametype._id_76BA167FAB191869 = getdvarint("dvar_08D276DA6FAB8C5E", 2500);
  level.brgametype._id_4C9D8CDDC19303ED = squared(level.brgametype._id_76BA167FAB191869);
  level.brgametype._id_A11C00BD12593A72 = getdvarfloat("dvar_07652A62713E7E3D", 15);
  level.brgametype._id_CF8A4EF13ED2F5BA = getdvarint("dvar_ED51351F11220D40", 1) == 1;
  level.brgametype._id_F9623A041E743669 = level.brgametype._id_F439C17A413F05C3 && getdvarint("dvar_4C1EFE20B495C492", 0) == 1;

  if(level.brgametype._id_F9623A041E743669) {
    level.brgametype._id_87D4766B5816BBF5 = getdvarint("dvar_44552ACAB369E55B", 2);
    level.brgametype._id_3DE07078C89E05F0 = getdvarint("dvar_A5958C5664CCB954", 3);
    level.brgametype._id_096E126D983A6BCB = getdvarint("dvar_5093E1A58ADBB3EA", 4);
  }

  level.brgametype._id_4A73AD987E2857E1 = getdvarint("dvar_4D634BA058318A25", -1);
  level.brgametype._id_ED0962F69D72E5B1 = getdvarint("dvar_8A84225861F51E28", -1);
  level.brgametype._id_12D3D7F14586D634 = getdvarint("dvar_129E6244045A81B6", -1);
  level.brgametype._id_DD674D15153F7AAB = getdvarint("dvar_85DB29695AD16662", -1);
  level.brgametype._id_BC6456D93D2E9053 = getdvarint("dvar_717B2AB5FD9216DF", -1);
  level.brgametype._id_A922C322AA7D8E27 = getdvarint("dvar_59BE9F022AAE99B1", -1);
  level.brgametype._id_DCA0E6FEF4E95FA9 = getdvarint("dvar_C11E2240978A14AB", -1);
  level.brgametype._id_4A10A8DD79FB5AB4 = getdvarint("dvar_4F0BCEDAA99A517F", -1);
  level.brgametype._id_A8FFBF7C6F0E152B = getdvarint("dvar_398CC06DC285F5B6", -1);
  level.brgametype._id_53911FA2D60CCB40 = getdvarint("dvar_4928F88CF598F176", -1);
  level.brgametype._id_79155A61DB265B6E = getdvarint("dvar_B49EC960BCBA14BC", -1);
  level.brgametype._id_E3C11803759B1678 = getdvarint("dvar_76FA3FFC4EB3F38C", -1);
  level.brgametype._id_8CB996B879748BB1 = getdvarfloat("dvar_6772E6C744D1D962", 30);
  level.brgametype._id_59AF2E5140D3FED7 = getdvarfloat("dvar_E9B60187D57107B9", 1.0);
  level.brgametype._id_A916B204F027AF6B = getdvarint("dvar_A91B489383D89274", 0);
  level.brgametype._id_6F3C4D74A8C614AB = getdvarint("dvar_38AFF65BDA44B82A", 1);
  level.brgametype._id_BE0C10911FEC189F = 1;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("mayConsiderPlayerDead");
    _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("getDefaultLoadout");
    _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("kioskRevivePlayer");
    _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("isTeamEliminated");
  }

  _id_362C58E8BB39BCDA::registerbrgametypefunc("circleTimer", ::circletimer);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("mayConsiderPlayerDead", ::_id_411AF8132CA77D3A);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("triggerRespawnOverlay", ::_id_0002E712BC64FDE7);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerNakedDropLoadout", ::_id_6AB3FA08604DED12);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("getDefaultLoadout", ::_id_B0FC27EC6E239628);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerDropBonuses", ::_id_0DECD4293C451C70);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerKilledSpawn", ::_id_F99A079543F11BF7);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("markPlayerAsEliminatedOnKilled", ::_id_4001B05BDB048819);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("assignLastStandAttacker", ::_id_F39FA02F6ED912FC);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("kioskRevivePlayer", ::_id_0F9A2B6AE09E7A00);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("jailbreakRevivePlayer", ::_id_15E7D31B2E31D8A8);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("dropOnPlayerDeath", ::droponplayerdeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("vipRespawnPlayer", ::_id_F9D21088ED2C3306);

  if(getdvarint("dvar_1B0FE60F7AE5735A", 0) == 1) {
    _id_362C58E8BB39BCDA::registerbrgametypefunc("mapCenterFinalCircle", ::_id_C2E48F2200BD249B);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("getFinalCircleCenter", ::_id_C2E48F2200BD249B);
  }

  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::_id_277C5D414A129608);
  waittillframeend;

  if(level.brgametype._id_3DD997E45E444B3D)
    level._id_5DFD73C97BF5D03D = ::_id_3709903D7AD3F711;

  thread _id_C3AA670D2773DB51();
  thread _id_AA202A5E20886406();
  thread _id_9F61893413E0093C();
  thread _id_3EE5F100EB900CAF();
  thread _id_0809485F51D59EBB();
  thread _id_797B21B78B5E0A26();
  thread _id_04F5568CF15D60B8();
  thread _id_90507E372A40C684();
  thread _id_22EF1CD58A8D87E8();
  thread _id_128D1A71FC850B8A::init();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_7EA88DD9BC483463);
  thread _id_81BAAD6D96FF2130();
}

_id_E30BFEC8B3D65B77() {
  _id_97B175CEC5B685BE("classtable:classtable_br_resurgence");
  _id_97B175CEC5B685BE("classtable:classtable_br_resurgence_circle2");
  _id_97B175CEC5B685BE("classtable:classtable_br_resurgence_circle3");
}

_id_528570CEB9DC7BF4() {
  if(getdvarint("dvar_5A1DAE481EF5D089", 0) == 1)
    _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");

  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("randomizeCircleCenter");

  if(getdvarint("dvar_32BD10766631266F", 0) != 0) {
    if(getdvarint("dvar_6A54F6FF93E297BA", 1) == 1)
      _id_362C58E8BB39BCDA::disablefeature("planeSnapToOOB");

    _id_362C58E8BB39BCDA::enablefeature("planeUseCircleRadius");
    _id_362C58E8BB39BCDA::enablefeature("circleEarlyStart");
  }
}

_id_67CAACEC6DDD6A25() {
  _id_28C73298E4316AC0::init();

  if(getdvarint("dvar_58495AD861147D94", 0)) {
    level._id_428703950599C9E9 = _id_268C4DA1EF6A20A8::_id_428703950599C9E9;
    level thread _id_1C47017BA325709A::_id_7F4D3080C6E8748B();
    level thread _id_2BC0B0102F9B7751::_id_D0FFCD08E0870CF2();
    level thread _id_640CF1641C03E2A0::_id_CA39A413ACE3C168();
    scripts\cp_mp\utility\script_utility::registersharedfunc("paraReinforce", "onChutePull", _id_640CF1641C03E2A0::_id_6A8AD55C5A4036D1);
  }
}

_id_8AF96D3889F46280() {
  scripts\cp_mp\utility\script_utility::registersharedfunc(level.brgametype.name, "packClientMatchData", ::_id_ECE0D8AE46D230C8);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("playerWelcomeSplashes");

  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  waittillframeend;

  if(getdvarint("dvar_32BD10766631266F", 0) != 0 || getdvarint("dvar_6C0E9A2AC5ECE4B5", 1)) {
    _id_362C58E8BB39BCDA::registerbrgametypefunc("createC130PathStruct", ::_id_38A46A469C73DC2C);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("addToC130Infil", ::_id_C338E39DB41D9374);

    if(getdvarint("dvar_BB3CFA989A77B2C5", 1) == 1)
      _id_010870C1A437402B();
  }

  if(getdvarint("dvar_82DD678EBEC737E0", 0) == 1)
    level thread _id_9680317AFD0E4558();

  level.ontimelimit = ::_id_060A9F05BEB5E480;
  _id_0171E7F7D10B8131();
  scripts\mp\rank::registerscoreinfo("stat_EF9582D72160F199", "stat_7CE4FD9430E80CEA", 100);
  scripts\mp\rank::registerscoreinfo("stat_C19301D569C97C3C", "stat_7CE4FD9430E80CEA", 200);

  if(getdvarint("dvar_B3EB77522192E559", 1) != 0)
    _id_2695A20D4011076D::_id_ECA79FA0F341EE08(13, undefined, undefined, undefined, ::_id_CEE78F828E373996);

  level.brgametype._id_B09B7AFE082A9239 = "dx_br_seal_";
  level.brgametype._id_042B1E877AB187C6 = "splash_list_iw9_br_resurgence_mp";
}

_id_CEE78F828E373996() {
  level.br_circle.dangercircleui.origin = _id_2695A20D4011076D::getdangercircleorigin() + (0, 0, _id_2695A20D4011076D::getdangercircleradius());
  _id_2695A20D4011076D::setstaticuicircles(500, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0);
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

_id_5367B756A0EEB9DB(attacker, _id_E48B3D05087E93F5, _id_73CACD5A645AAB1F) {
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

_id_7269C88A927E7937() {
  level endon("game_ended");
  waitframe();
  game["dialog"]["match_start"] = "rsrg_wzan_gtrs";
  game["dialog"]["primary_objective_solo"] = "rsrg_wzan_rdso";
  game["dialog"]["primary_objective"] = "rsrg_wzan_gtdr";
  game["dialog"]["resurgence_redeploy"] = "rsrg_wzan_redo";
  game["dialog"]["resurgence_disabled"] = "rsrg_wzan_rdis";
  game["dialog"]["resurgence_ending"] = "rsrg_wzan_rend";
  game["dialog"]["last_man_standing"] = "rsrg_wzan_rsla";
  game["dialog"]["resurgence_avenge_teammate"] = "rsrg_wzan_avgt";
  game["dialog"]["resurgence_teammate_respawn"] = "rsrg_wzan_tmre";
  game["dialog"]["resurgence_hunt_reminder"] = "rsrg_wzan_huao";
  game["dialog"]["resurgence_on_player_disconnect"] = "rsrg_wzan_tadj";
}

_id_683452DFA2B09CCD() {
  game["dialog"]["last_man_standing"] = "rsrg_wzan_rdis";
}

_id_0171E7F7D10B8131() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

_id_C3AA670D2773DB51() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.brgametype._id_C42E40EC22A1F0D4 = 1;
  level._id_843573804B98EB7E = 1;
}

_id_AA202A5E20886406() {
  waittillframeend;
  _id_8DBB05FF88408C71 = level.allteamnamelist;

  foreach(index, team in _id_8DBB05FF88408C71)
  level.teamdata[team]["index"] = index;

  if(istrue(level.brgametype._id_840B848760F488A4)) {
    foreach(name, team in level.teamdata)
    level.teamdata[name]["trackedTeams"] = [];
  } else {
    scripts\mp\flags::gameflagwait("prematch_done");
    scripts\mp\flags::gameflagwait("prematch_fade_done");

    foreach(player in level.players)
    player._id_A93508890D2545D1 = [];
  }
}

_id_9F61893413E0093C() {
  foreach(name, team in level.teamdata)
  level.teamdata[name]["deadPlayers"] = [];

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player._id_3EAD79441FB2C7BE = [];
  }
}

_id_060A9F05BEB5E480() {
  if(isDefined(level.numendgame))
    level thread _id_1E4A61DB11011446::startendgame(1);

  level.numendgame = undefined;
}

_id_411AF8132CA77D3A(player) {
  result = player _id_362C58E8BB39BCDA::runbrgametypefunc("brPreMayConsiderPlayerDead");

  if(isDefined(result))
    return result;

  if(scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("prematch_fade_done")) {
    if(istrue(player._id_1E309FA83F9FBE2E))
      return _id_AFB309407C44FC11(player);
    else
      return _id_C76781B1D95BB338(player);
  }

  return 1;
}

_id_C76781B1D95BB338(player) {
  player thread _id_B1DFE6C6434FC16C();
  player thread _id_362C58E8BB39BCDA::runbrgametypefunc("onResurgencePlayerWaitRespawn");
  return 1;
}

_id_AFB309407C44FC11(player) {
  if(istrue(level.brgametype._id_C42E40EC22A1F0D4) || istrue(self._id_08A52130C321AA8A)) {
    if(!isDefined(player.respawndelay))
      player.respawndelay = 0;

    if(player.respawndelay <= 0) {
      player._id_EA1C01DC368298B2 = 1;
      return 0;
    }
  }

  player _id_BBEE565C7645EA29();
  player notify("squad_wiped");
  return 1;
}

_id_2FFB02751EBA32DF(_id_F99D56BCB582A8BA) {
  if(istrue(level.brgametype._id_F25F680FB993CCEF)) {
    return;
  }
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  foreach(player in scripts\mp\utility\teams::getteamdata(_id_F99D56BCB582A8BA.team, "players")) {
    if(!istrue(player._id_6F75C711F7773C67) && isalive(player) && _id_F99D56BCB582A8BA != player) {
      player._id_6F75C711F7773C67 = 1;
      player thread scripts\mp\hud_message::showsplash("br_resurgence_first_dead_improvement", undefined, undefined, undefined, undefined, level.brgametype._id_042B1E877AB187C6);
    }
  }
}

_id_ECE0D8AE46D230C8() {
  if(!isDefined(self._id_9EFAA5D4F566B9D8))
    self._id_9EFAA5D4F566B9D8 = 0;

  _id_081DAB8953B9DF82 = self._id_9EFAA5D4F566B9D8;

  if(_id_081DAB8953B9DF82 > 255)
    _id_081DAB8953B9DF82 = 255;

  self.extrascore0 = _id_081DAB8953B9DF82;
  self.pers["extrascore0"] = _id_081DAB8953B9DF82;
  _id_C5C0C138D608BE6A = 0;

  if(isDefined(self.brmissionscompleted))
    _id_C5C0C138D608BE6A = _id_C5C0C138D608BE6A + self.brmissionscompleted;

  if(_id_C5C0C138D608BE6A > 15)
    _id_C5C0C138D608BE6A = 15;

  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + (_id_C5C0C138D608BE6A << 8);
  return _id_081DAB8953B9DF82;
}

_id_FB9ED4B8A0E55BFC(teamdata, _id_075C8CC005E7E9F3) {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("registerReviveCount")) {
    return;
  }
  if(!istrue(self._id_1E309FA83F9FBE2E)) {
    _id_2F945DAC0CD1EDCB = !istrue(level.teamdata[self.team]["teamHadFirstRevive"]);

    if(_id_2F945DAC0CD1EDCB)
      level.teamdata[self.team]["teamHadFirstRevive"] = 1;

    foreach(_id_B46423B1979CB10E in teamdata) {
      if(isDefined(_id_B46423B1979CB10E) && !isDefined(_id_B46423B1979CB10E._id_9EFAA5D4F566B9D8))
        _id_B46423B1979CB10E._id_9EFAA5D4F566B9D8 = 0;

      _id_B46423B1979CB10E._id_9EFAA5D4F566B9D8++;
      _id_B46423B1979CB10E _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("reviveCount", _id_B46423B1979CB10E._id_9EFAA5D4F566B9D8);
      _id_B46423B1979CB10E _id_ECE0D8AE46D230C8();
      _id_75A087E96D31DDC5 = !isDefined(_id_075C8CC005E7E9F3) || _id_B46423B1979CB10E != _id_075C8CC005E7E9F3;
      _id_4B59E709FD5BCC45 = _id_2F945DAC0CD1EDCB && _id_75A087E96D31DDC5;

      if(_id_4B59E709FD5BCC45)
        _id_B46423B1979CB10E thread scripts\mp\hud_message::showsplash("br_resurgence_first_revive_improvement", undefined, undefined, undefined, undefined, level.brgametype._id_042B1E877AB187C6);
    }
  } else {
    if(!isDefined(self._id_9EFAA5D4F566B9D8))
      self._id_9EFAA5D4F566B9D8 = 0;

    self._id_9EFAA5D4F566B9D8++;
    _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("reviveCount", self._id_9EFAA5D4F566B9D8);
  }
}

_id_4001B05BDB048819() {
  _id_1AB32500A7D5B09A = istrue(self._id_08A52130C321AA8A);
  self._id_08A52130C321AA8A = undefined;

  if(!istrue(self._id_1E309FA83F9FBE2E))
    return 1;

  _id_838D3619FB1FF27B = isDefined(self.respawndelay) && self.respawndelay > 0;
  return scripts\mp\flags::gameflag("prematch_fade_done") && (_id_838D3619FB1FF27B || !istrue(level.brgametype._id_C42E40EC22A1F0D4) && !_id_1AB32500A7D5B09A);
}

_id_F9D21088ED2C3306(_id_84E2123AACA9A965) {
  if(isalive(self)) {
    return;
  }
  _id_0F9A2B6AE09E7A00(_id_84E2123AACA9A965);
}

_id_15E7D31B2E31D8A8() {
  _id_0F9A2B6AE09E7A00(undefined, undefined, 1);
}

_id_0F9A2B6AE09E7A00(_id_84E2123AACA9A965, _id_57D71760971F748F, _id_74AF5908127B6729) {
  if(istrue(self._id_1E309FA83F9FBE2E)) {
    return;
  }
  _id_C7869D69DBCF7FD3 = self;
  _id_C7869D69DBCF7FD3 thread _id_67708F418B1FAC79::playergulagautowin("resurgenceEarlyRevive", _id_84E2123AACA9A965, _id_57D71760971F748F, undefined, _id_74AF5908127B6729);
  _id_C7869D69DBCF7FD3 _id_FB9ED4B8A0E55BFC(level.teamdata[_id_C7869D69DBCF7FD3.team]["alivePlayers"], _id_84E2123AACA9A965);
  _id_C3C91F0DFBF4F683();
  return;
}

droponplayerdeath(attacker) {
  if(istrue(self._id_1E309FA83F9FBE2E)) {
    return;
  }
  if(istrue(level.brgametype._id_574951D2EFF9C094) || istrue(level.brgametype._id_D6DC578C217F88CF) && !isDefined(self._id_5FB036C33CDDD360))
    _id_1E4A61DB11011446::_id_10FFA1071B1C2681();

  return 0;
}

_id_277C5D414A129608(_id_642470E1ABC1BBF9) {
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
  thread _id_2FFB02751EBA32DF(_id_642470E1ABC1BBF9.victim);

  if(!isDefined(_id_642470E1ABC1BBF9.attacker) || !isPlayer(_id_642470E1ABC1BBF9.attacker) || _id_642470E1ABC1BBF9.attacker == _id_642470E1ABC1BBF9.victim) {
    if(!istrue(_id_642470E1ABC1BBF9.victim._id_1E309FA83F9FBE2E))
      _id_028FE2AED2424B8F(_id_642470E1ABC1BBF9.victim);
  } else {
    if(istrue(level.brgametype._id_F9623A041E743669)) {
      _id_642470E1ABC1BBF9.victim._id_3B90A1EE7A57F5B1 = undefined;
      _id_642470E1ABC1BBF9.victim._id_84F4B10A80C5CE0A = 0;
    }

    _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(_id_642470E1ABC1BBF9.attacker.team, "aliveCount");

    if(_id_BCE4EFC75EB01319 <= 0) {
      return;
    }
    _id_642470E1ABC1BBF9.attacker _id_266B9FB5E9453EF1(_id_642470E1ABC1BBF9.victim);
    _id_642470E1ABC1BBF9.attacker _id_2A897CD68A200CB2();
    _id_642470E1ABC1BBF9.attacker _id_01EE2942F2A3BA7B();
    _id_60F89EA387E4FD31(_id_642470E1ABC1BBF9.victim);
    _id_642470E1ABC1BBF9.victim thread _id_183E83CF14BFEB7A(_id_642470E1ABC1BBF9.attacker);

    if(istrue(_id_642470E1ABC1BBF9.victim._id_1E309FA83F9FBE2E)) {
      _id_140BE6F794C627C9(_id_642470E1ABC1BBF9);

      if(!isDefined(_id_642470E1ABC1BBF9.victim._id_3EAD79441FB2C7BE))
        _id_642470E1ABC1BBF9.victim._id_3EAD79441FB2C7BE = [];

      if(!scripts\engine\utility::array_contains(_id_642470E1ABC1BBF9.victim._id_3EAD79441FB2C7BE, _id_642470E1ABC1BBF9.attacker))
        scripts\engine\utility::array_add(_id_642470E1ABC1BBF9.victim._id_3EAD79441FB2C7BE, _id_642470E1ABC1BBF9.attacker);

      _id_642470E1ABC1BBF9.attacker thread _id_D17AA77CA39E8D00(_id_642470E1ABC1BBF9.victim);
      _id_642470E1ABC1BBF9.attacker thread _id_D0262F6A0C49EDBB(_id_642470E1ABC1BBF9.victim);
    } else {
      _id_642470E1ABC1BBF9.attacker _id_778D96C94679909C(_id_642470E1ABC1BBF9.attacker.team, _id_642470E1ABC1BBF9.victim.team);
      _id_028FE2AED2424B8F(_id_642470E1ABC1BBF9.victim);
    }

    if(istrue(_id_642470E1ABC1BBF9.attacker._id_1E309FA83F9FBE2E)) {
      _id_642470E1ABC1BBF9.attacker thread _id_2C7BB4C045E81497(_id_642470E1ABC1BBF9.victim);
      return;
    }

    _id_642470E1ABC1BBF9.attacker thread _id_8CC833B706D330BF(_id_642470E1ABC1BBF9.attacker.team, _id_642470E1ABC1BBF9.victim);
  }
}

_id_028FE2AED2424B8F(victim) {
  victim._id_9470762801D7EBD9 = 0;

  if(!istrue(level.brgametype._id_F439C17A413F05C3)) {
    return;
  }
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  foreach(player in scripts\mp\utility\teams::getteamdata(victim.team, "players")) {
    if(!istrue(player._id_9470762801D7EBD9))
      player thread _id_5A5BB23FC0B48595();
  }
}

_id_5A5BB23FC0B48595() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self._id_9470762801D7EBD9 = 1;

  while(!isalive(self) || !self isonground() && !self _meth_E40102956C887F7C() && !scripts\cp_mp\utility\player_utility::isinvehicle())
    wait 1;

  self._id_9470762801D7EBD9 = scripts\mp\utility\teams::getteamcount(self.team, 1) < scripts\mp\utility\teams::getteamcount(self.team);
  self._id_3A570A6D7CEA7826 = self.origin;
  self._id_BFBA4165EBAE7169 = 0.0;

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    self._id_B3D3D6102F5B1BCB = 1;
    self._id_42BD6DC51AB8C2B0 = level.brgametype._id_76BA167FAB191869;
    self._id_71359C6A4CEAB6D1 = level.brgametype._id_4C9D8CDDC19303ED;
  } else {
    self._id_B3D3D6102F5B1BCB = 0;
    self._id_42BD6DC51AB8C2B0 = level.brgametype._id_B8A3736F232F201A;
    self._id_71359C6A4CEAB6D1 = level.brgametype._id_4AF675F2894744AE;
  }

  while(istrue(self._id_9470762801D7EBD9)) {
    _id_CA9845D32AE88521 = scripts\cp_mp\utility\player_utility::isinvehicle();

    if(self._id_B3D3D6102F5B1BCB != _id_CA9845D32AE88521) {
      self._id_B3D3D6102F5B1BCB = _id_CA9845D32AE88521;
      _id_234F5A6C3524F185 = distance2d(self._id_3A570A6D7CEA7826, self.origin);
      _id_041668E7944A5E5E = scripts\engine\utility::ter_op(_id_CA9845D32AE88521, level.brgametype._id_76BA167FAB191869, level.brgametype._id_B8A3736F232F201A);
      self._id_BFBA4165EBAE7169 = _id_234F5A6C3524F185 / self._id_42BD6DC51AB8C2B0;
      self._id_42BD6DC51AB8C2B0 = _id_234F5A6C3524F185 + (1 - self._id_BFBA4165EBAE7169) * _id_041668E7944A5E5E;
      self._id_71359C6A4CEAB6D1 = squared(self._id_42BD6DC51AB8C2B0);
    }

    if(distance2dsquared(self._id_3A570A6D7CEA7826, self.origin) > self._id_71359C6A4CEAB6D1) {
      scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6991D4171C93F394");
      self._id_3A570A6D7CEA7826 = self.origin;
    }

    wait 1;
    self._id_9470762801D7EBD9 = scripts\mp\utility\teams::getteamcount(self.team, 1) < scripts\mp\utility\teams::getteamcount(self.team);
  }
}

_id_778D96C94679909C(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98) {
  if(!level.brgametype._id_6420B42C7ADD53CC) {
    return;
  }
  _id_63C057F27DC906B5(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98, level.brgametype._id_428C736511619824);
}

_id_8CC833B706D330BF(team, _id_3E59C6682B60D27E) {
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
  _id_4E776A22240FF174 = _id_D99EC654FCD96CC6(_id_D0B996FDE8BFC937, _id_3E59C6682B60D27E);
  _id_FFCD45C1B7A5355A(_id_4E776A22240FF174, _id_3E59C6682B60D27E);
}

_id_D99EC654FCD96CC6(_id_D0B996FDE8BFC937, _id_3E59C6682B60D27E) {
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

_id_A045BCDB0D1BEBF9(victim, attacker) {
  if(isDefined(attacker) && (!isDefined(victim) || victim != attacker || isDefined(victim.team) && victim.team != attacker.team))
    attacker scripts\mp\utility\points::_id_0366980B6A8796AE("stat_56BBA12AF2118978");
}

_id_266B9FB5E9453EF1(victim) {
  if(!istrue(level.brgametype._id_F439C17A413F05C3)) {
    return;
  }
  if(!isDefined(self._id_F968DC3ADF6C967E))
    self._id_F968DC3ADF6C967E = [];
  else {
    _id_A93508890D2545D1 = _id_F6686365221E78CB();
    _id_3E00D2D6FB1BD934 = _id_85FEE305E2D829C1(_id_A93508890D2545D1, victim.team);

    if(_id_3E00D2D6FB1BD934 < 0 || _id_3E00D2D6FB1BD934 >= 4) {
      return;
    }
    _id_CF7D42708E58BB98 = _id_A93508890D2545D1[_id_3E00D2D6FB1BD934];
    _id_79529D487C7F67DA = gettime();
    _id_E0BA1A2E8FFB8E1E = _id_79529D487C7F67DA - _id_CF7D42708E58BB98["startTime"];

    if(_id_E0BA1A2E8FFB8E1E < level.brgametype._id_A11C00BD12593A72 * 1000) {
      if(isDefined(self._id_F968DC3ADF6C967E[victim.team]))
        self._id_F968DC3ADF6C967E[victim.team]++;
      else
        self._id_F968DC3ADF6C967E[victim.team] = 1;

      _id_4E3AA4DBE97C98C4(victim);
      return;
    }

    self._id_F968DC3ADF6C967E[victim.team] = undefined;
  }
}

_id_4E3AA4DBE97C98C4(victim) {
  _id_0AB149E767FFAAEA = self._id_F968DC3ADF6C967E[victim.team];

  if(_id_0AB149E767FFAAEA == 1)
    scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5C88182B179622FF");
  else if(_id_0AB149E767FFAAEA == 2)
    scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D19D617F698A15ED");
  else
    scripts\mp\utility\points::_id_0366980B6A8796AE("stat_0C17682D0EACA99D");
}

_id_2A897CD68A200CB2() {
  if(!istrue(level.brgametype._id_F439C17A413F05C3) || istrue(self._id_1E309FA83F9FBE2E)) {
    return;
  }
  _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamcount(self.team, 1);

  if(_id_BCE4EFC75EB01319 == 1)
    scripts\mp\utility\points::_id_0366980B6A8796AE("stat_0951FE694822446B");
}

_id_01EE2942F2A3BA7B() {
  if(!istrue(level.brgametype._id_F9623A041E743669)) {
    return;
  }
  if(!isDefined(self._id_84F4B10A80C5CE0A))
    self._id_84F4B10A80C5CE0A = 0;

  if(self._id_84F4B10A80C5CE0A >= level.brgametype._id_096E126D983A6BCB) {
    return;
  }
  if(!isDefined(self._id_3B90A1EE7A57F5B1))
    self._id_3B90A1EE7A57F5B1 = level.brgametype._id_3B90A1EE7A57F5B1;

  _id_250CA808E7137065 = 1;

  if(self._id_84F4B10A80C5CE0A >= level.brgametype._id_3DE07078C89E05F0)
    _id_250CA808E7137065 = 3;
  else if(self._id_84F4B10A80C5CE0A >= level.brgametype._id_87D4766B5816BBF5)
    _id_250CA808E7137065 = 2;

  _id_652429904B5EB1C5 = undefined;

  for(hasperk = 1; hasperk && self._id_3B90A1EE7A57F5B1[_id_250CA808E7137065].size > 0; self._id_3B90A1EE7A57F5B1[_id_250CA808E7137065] = scripts\engine\utility::array_remove(self._id_3B90A1EE7A57F5B1[_id_250CA808E7137065], _id_652429904B5EB1C5)) {
    _id_652429904B5EB1C5 = scripts\engine\utility::random(self._id_3B90A1EE7A57F5B1[_id_250CA808E7137065]);
    hasperk = scripts\mp\utility\perk::_hasperk(_id_652429904B5EB1C5);
  }

  if(!hasperk)
    _id_DF2259F42D74D342(_id_652429904B5EB1C5);
}

_id_DF2259F42D74D342(perk) {
  scripts\mp\utility\perk::giveperk(perk);
  self._id_84F4B10A80C5CE0A++;
  lootid = level.br_pickups._id_7B2BFF2D04EE1017["brloot_" + perk];

  if(!isDefined(lootid)) {
    return;
  }
  _id_FBB5190911C15C1B = self getvieworigin();
  _id_7E52B56769FA7774::_id_37BE6E543436F3B3(lootid, _id_FBB5190911C15C1B, 1, 0);
}

_id_60F89EA387E4FD31(victim) {
  if(!istrue(level.brgametype._id_CF8A4EF13ED2F5BA) || scripts\mp\utility\teams::getteamdata(victim.team, "aliveCount") > 0) {
    return;
  }
  perkpackagelist = getscriptbundle("perkpackagelist:br_perkpackagelist_iw9");
  _id_782866E364DCD2EF = scripts\engine\utility::_id_7A2AAA4A09A4D250(perkpackagelist._id_1DACE216D1A32D14);
  _id_82FDF4C0D6CA802C = strtok(_id_782866E364DCD2EF._id_782866E364DCD2EF, "_")[1];
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  droporigin = victim.origin;
  dropangles = victim.angles;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, droporigin, dropangles, victim);
  _id_7E52B56769FA7774::spawnpickup("brloot_perkpack_" + _id_82FDF4C0D6CA802C + "_br", _id_CB4FAD49263E20C4, 1, 1);
}

_id_183E83CF14BFEB7A(_id_56521B8795115DEB) {
  if(!istrue(level.brgametype._id_36DBCA9D337B4930) || !isDefined(_id_56521B8795115DEB) || !isPlayer(_id_56521B8795115DEB)) {
    return;
  }
  level endon("game_ended");
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  squadmemberindex = self._id_3F78C6A0862F9E25;

  if(!isDefined(squadmemberindex) || squadmemberindex == -1) {
    return;
  }
  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player)) {
      _id_99DFD5EC21DADCF8 = _id_56521B8795115DEB getentitynumber();
      _id_50F4785A0782E768 = int(clamp(_id_99DFD5EC21DADCF8 + 1, 1, 255));
      player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_resurgence_team_nemeses", squadmemberindex * 8, 8, _id_50F4785A0782E768);
    }
  }

  scripts\engine\utility::waittill_any_3("disconnect", "started_spawnPlayer", "avenged");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player))
      player scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_resurgence_team_nemeses", squadmemberindex * 8, 8, 0);
  }
}

_id_2C7BB4C045E81497(victim) {
  level endon("game_ended");

  if(!level.brgametype._id_F6682C80C3C868D6) {
    return;
  }
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  _id_C86EEFDAF13D0D81(victim);
}

_id_D0262F6A0C49EDBB(victim) {
  level endon("game_ended");
  self endon("disconnect");
  victim endon("disconnect");
  victim endon("squad_wiped");

  if(!level.brgametype._id_6420B42C7ADD53CC) {
    return;
  }
  if(!isDefined(victim)) {
    return;
  }
  victim waittill("respawn_done");
  _id_63C057F27DC906B5(self.team, victim.team, level.brgametype._id_6EE71092BE57820C);
}

_id_D17AA77CA39E8D00(victim) {
  attacker = self;

  if(istrue(victim.br_iseliminated)) {
    attacker thread scripts\mp\events::killeventtextpopup("enemy_wiped", 0);
    attacker thread scripts\mp\utility\points::giveunifiedpoints("enemy_wiped", attacker.wipeweapon);
    attacker thread _id_58D39D7DB7E05D7A(victim);
  }
}

_id_58D39D7DB7E05D7A(victim) {
  lastweapon = _id_1E4A61DB11011446::brchooselaststandweapon();
  _id_1E4A61DB11011446::teamwipedobituary(victim, self, lastweapon);
  _id_6A9853A7EF309B8F = [];

  if(!isDefined(_id_6A9853A7EF309B8F[self.team])) {
    _id_6A9853A7EF309B8F[self.team] = 1;
    self playsoundtoteam("ui_team_wipe_splash", self.team);
  }
}

_id_FFCD45C1B7A5355A(_id_4E776A22240FF174, _id_E48B3D05087E93F5) {
  if(_id_4E776A22240FF174.size <= 0) {
    return;
  }
  foreach(_id_F0EA4030349A33D5 in _id_4E776A22240FF174) {
    if(!isDefined(_id_F0EA4030349A33D5)) {
      continue;
    }
    _id_D33F6589A1C04EE9(_id_F0EA4030349A33D5);
  }

  if(!istrue(level.brgametype._id_7B3746FD57041FB7))
    _id_5367B756A0EEB9DB(self, _id_E48B3D05087E93F5, _id_4E776A22240FF174);

  thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("resurgence_avenge_teammate", self, undefined, undefined, undefined, undefined, level.brgametype._id_B09B7AFE082A9239);
}

_id_D33F6589A1C04EE9(_id_92A674D94DF29E77) {
  if(istrue(level.brgametype._id_574951D2EFF9C094))
    _id_92A674D94DF29E77._id_231DD1DC2A6ED943 = 1;

  _id_92A674D94DF29E77 notify("avenged");

  if(istrue(level.brgametype._id_7B3746FD57041FB7)) {
    _id_92A674D94DF29E77.respawndelay = int(max(0, _id_92A674D94DF29E77.respawndelay - level.brgametype._id_2CFDC1D6E92251BF));

    if(!isDefined(_id_92A674D94DF29E77._id_C54AFD6E867E686B))
      _id_92A674D94DF29E77._id_C54AFD6E867E686B = 0;

    _id_92A674D94DF29E77._id_C54AFD6E867E686B = _id_92A674D94DF29E77._id_C54AFD6E867E686B + level.brgametype._id_2CFDC1D6E92251BF;
    _id_362C58E8BB39BCDA::runbrgametypefunc("updateRespawnDelay", _id_92A674D94DF29E77);
  } else
    _id_92A674D94DF29E77 thread _id_7CB9398C136B6A50(1, level.teamdata[_id_92A674D94DF29E77.team]["alivePlayers"]);
}

_id_C86EEFDAF13D0D81(victim) {
  if(self.respawndelay <= 0) {
    return;
  }
  if(!isDefined(self._id_3EAD79441FB2C7BE))
    self._id_3EAD79441FB2C7BE = [];

  if(isDefined(self._id_3EAD79441FB2C7BE) && scripts\engine\utility::array_contains(self._id_3EAD79441FB2C7BE, victim)) {
    if(istrue(level.brgametype._id_7B3746FD57041FB7)) {
      _id_4E47F37A50CBAC36(self, level.brgametype._id_2CFDC1D6E92251BF);
      _id_362C58E8BB39BCDA::runbrgametypefunc("updateRespawnDelay", self);
      _id_AAE3AC84B3FF8E6D();
      wait 1;
      _id_1F013990C19FCD88();
    }

    scripts\engine\utility::array_remove(self._id_3EAD79441FB2C7BE, victim);
    thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
  }
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

_id_D6D795DB2CAE2C1B(_id_29412B34AF141C29, _id_38678FA9BDC12FDF, _id_3E00D2D6FB1BD934, _id_8DB0C8D0A8DA2329) {
  _id_3A7747BC9807F3C0 = -1;
  _id_BD7E56573C70F3DB = !_id_3E00D2D6FB1BD934 == 0;

  foreach(player in _id_29412B34AF141C29) {
    if(isDefined(player)) {
      if(_id_3A7747BC9807F3C0 < 0) {
        _id_3A7747BC9807F3C0 = player getclientomnvar("ui_br_resurgence_tracked_teams");
        _id_3A7747BC9807F3C0 = _id_0611500F4751AAF1(_id_3A7747BC9807F3C0, _id_3E00D2D6FB1BD934, _id_8DB0C8D0A8DA2329);
      }

      player setclientomnvar("ui_br_resurgence_tracked_teams", _id_3A7747BC9807F3C0);
      player setclientomnvar("ui_br_interrogate_tracking_other_team", _id_BD7E56573C70F3DB);

      foreach(_id_8B4C31EE3A50DC14 in _id_38678FA9BDC12FDF) {
        if(isDefined(_id_8B4C31EE3A50DC14))
          player _meth_8F6193AF4627DD8B(2, _id_8B4C31EE3A50DC14, _id_BD7E56573C70F3DB);
      }
    }
  }

  if(istrue(level.brgametype._id_836C1FC36B00559D)) {
    foreach(_id_8B4C31EE3A50DC14 in _id_38678FA9BDC12FDF) {
      if(isDefined(_id_8B4C31EE3A50DC14))
        _id_8B4C31EE3A50DC14 setclientomnvar("ui_br_interrogate_team_is_being_tracked", _id_BD7E56573C70F3DB);
    }
  }
}

_id_F6686365221E78CB() {
  _id_A93508890D2545D1 = [];

  if(istrue(level.brgametype._id_840B848760F488A4))
    _id_A93508890D2545D1 = scripts\mp\utility\teams::getteamdata(self.team, "trackedTeams");
  else {
    if(!isDefined(self._id_A93508890D2545D1))
      self._id_A93508890D2545D1 = [];

    _id_A93508890D2545D1 = self._id_A93508890D2545D1;
  }

  return _id_A93508890D2545D1;
}

_id_63C057F27DC906B5(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98, _id_9622B10EA4ACBC01) {
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
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
  thread _id_7278F9076C781224(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98, _id_BB58BCC7B0654344, _id_9622B10EA4ACBC01);
}

_id_7278F9076C781224(_id_A1B4FAB5A3B4FA5E, _id_CF7D42708E58BB98, _id_BB58BCC7B0654344, _id_9622B10EA4ACBC01) {
  if(_id_BB58BCC7B0654344 < 0 || _id_BB58BCC7B0654344 >= 4) {
    return;
  }
  notifyname = "trackTeam" + _id_A1B4FAB5A3B4FA5E + _id_BB58BCC7B0654344;
  _id_29412B34AF141C29 = [];
  _id_05B1596320DF748C = [];
  _id_05B1596320DF748C["name"] = _id_CF7D42708E58BB98;
  _id_05B1596320DF748C["startTime"] = gettime();
  _id_2CEDCC356F1B9FC8::brleaderdialogteam("resurgence_hunt_reminder", _id_A1B4FAB5A3B4FA5E, 1, undefined, undefined, "dx_br_bds4_");

  if(istrue(level.brgametype._id_840B848760F488A4)) {
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
  _id_38678FA9BDC12FDF = scripts\mp\utility\teams::getteamdata(_id_CF7D42708E58BB98, "players");
  _id_D6D795DB2CAE2C1B(_id_29412B34AF141C29, _id_38678FA9BDC12FDF, _id_3E00D2D6FB1BD934, _id_BB58BCC7B0654344);
  wait(_id_9622B10EA4ACBC01);
  _id_D6D795DB2CAE2C1B(_id_29412B34AF141C29, _id_38678FA9BDC12FDF, 0, _id_BB58BCC7B0654344);
}

_id_3EE5F100EB900CAF() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(istrue(level.brgametype._id_B43745B85F249E68)) {
    return;
  }
  if(getdvarint("dvar_32BD10766631266F", 0) == 0)
    level waittill("infils_ready");

  _id_10B5C13C81DB5079 = _id_B398ACC9BA21ECB5();
  totaltime = 0;

  if(getdvarint("dvar_32BD10766631266F", 0))
    totaltime = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_10B5C13C81DB5079; _id_AC0E594AC96AA3A8++)
    totaltime = totaltime + (level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8] + level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8]);

  _id_F9F04F141AE1E4D4 = int(totaltime * 1000);
  _id_7BF1255A3715A632 = gettime();
  _id_3112E3DE7BF7F005 = _id_7BF1255A3715A632 + _id_F9F04F141AE1E4D4;
  setomnvarforallclients("ui_br_timed_feature_end_time", _id_3112E3DE7BF7F005);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    setomnvarforallclients("ui_br_resurgence_will_disable", 0);

  level._id_01FCBA68EFD8D4BF = totaltime;

  if(level.brgametype._id_9524142EB719A321) {
    level.brgametype._id_D851832A0F677C60 = getdvarint("dvar_D83FF6D2E0647BC5", totaltime);
    thread _id_5A44C88BDF9B01AE(level.brgametype._id_D851832A0F677C60);
  }

  _id_A9A4271FA4D4ACEE = _id_F9F04F141AE1E4D4;
  _id_EB17C8739491B838 = getdvarint("dvar_342776B421CE99FA", 90000);
  thread _id_852D53966B46F329(_id_A9A4271FA4D4ACEE / 1000);

  while(_id_A9A4271FA4D4ACEE > _id_EB17C8739491B838) {
    wait((_id_A9A4271FA4D4ACEE - _id_EB17C8739491B838) / 1000);
    _id_6CF8E0BF922944AE = gettime() - _id_7BF1255A3715A632;
    _id_A9A4271FA4D4ACEE = _id_F9F04F141AE1E4D4 - _id_6CF8E0BF922944AE;
  }

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    setomnvarforallclients("ui_br_resurgence_will_disable", 1);

  setomnvarforallclients("ui_br_timed_feature_end_time", int(gettime() + _id_A9A4271FA4D4ACEE) - 1);

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("resurgenceDisableSkipForPlayer", player))) {
      continue;
    }
    player thread scripts\mp\hud_message::showsplash("br_resurgence_reinforcement_closing_improvement", undefined, undefined, undefined, undefined, level.brgametype._id_042B1E877AB187C6);
  }
}

_id_5A44C88BDF9B01AE(remainingtime) {
  level endon("game_ended");
  wait(remainingtime);
  level.brgametype._id_9524142EB719A321 = 0;
}

_id_852D53966B46F329(remainingtime) {
  level endon("game_ended");
  wait(remainingtime - 90);
  _id_2CEDCC356F1B9FC8::brleaderdialog("resurgence_ending", undefined, undefined, undefined, undefined, undefined, level.brgametype._id_B09B7AFE082A9239);
}

_id_0809485F51D59EBB() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.brgametype.respawndelay = [];
  level.brgametype._id_34AF112C77C2C381 = ["_solos", "_duos", "_trios", "_quads"];
  _id_0E6CA3C2CA24B16F();
  _id_10B5C13C81DB5079 = _id_B398ACC9BA21ECB5();

  foreach(_id_53A4A1C920DEF4BD in level.brgametype._id_34AF112C77C2C381) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_10B5C13C81DB5079; _id_AC0E594AC96AA3A8++) {
      _id_33BFDC2307CF55B4 = getdvarint(_func_2EF675C13CA1C4AF("dvar_FA5F73966EB446D7", _id_AC0E594AC96AA3A8 + 1, _id_53A4A1C920DEF4BD), -1);

      if(_id_33BFDC2307CF55B4 >= 0) {
        level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][_id_AC0E594AC96AA3A8] = _id_33BFDC2307CF55B4;
        continue;
      }

      if(_id_AC0E594AC96AA3A8 >= level.brgametype.respawndelay[_id_53A4A1C920DEF4BD].size)
        level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][_id_AC0E594AC96AA3A8] = level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][_id_AC0E594AC96AA3A8 - 1];
    }
  }
}

_id_0E6CA3C2CA24B16F() {
  level.brgametype.respawndelay["_solos"][0] = getdvarint("dvar_D474AE8371B653A7", 15);
  level.brgametype.respawndelay["_solos"][1] = getdvarint("dvar_D474AF8371B655DA", 20);
  level.brgametype.respawndelay["_solos"][2] = getdvarint("dvar_D474B08371B6580D", 30);
  level.brgametype.respawndelay["_duos"][0] = getdvarint("dvar_98B57A9986390134", 15);
  level.brgametype.respawndelay["_duos"][1] = getdvarint("dvar_98B57D99863907CD", 20);
  level.brgametype.respawndelay["_duos"][2] = getdvarint("dvar_98B57C998639059A", 30);
  level.brgametype.respawndelay["_trios"][0] = getdvarint("dvar_C0D316EFC3EF6B12", 20);
  level.brgametype.respawndelay["_trios"][1] = getdvarint("dvar_C0D315EFC3EF68DF", 30);
  level.brgametype.respawndelay["_trios"][2] = getdvarint("dvar_C0D314EFC3EF66AC", 40);
  level.brgametype.respawndelay["_quads"][0] = getdvarint("dvar_6C1FFB69E01548FB", 25);
  level.brgametype.respawndelay["_quads"][1] = getdvarint("dvar_6C1FFC69E0154B2E", 35);
  level.brgametype.respawndelay["_quads"][2] = getdvarint("dvar_6C1FFD69E0154D61", 45);
}

_id_BBEE565C7645EA29() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue &~16384;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
}

_id_FFF107D76EB56064() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue | 16384;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
}

_id_AAE3AC84B3FF8E6D() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue | 32768;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
}

_id_1F013990C19FCD88() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue &~32768;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
}

_id_B12988FDF64EFE98(value) {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_0A31AE8D2963FA9D = currentvalue &~16383;
  _id_8F617FFD000EB682 = _id_0A31AE8D2963FA9D | value;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
}

_id_230EA867CD69C598(value) {
  _id_270CD077009199A0 = 0;

  if(istrue(self._id_14AFB82AA29BC57C)) {
    _id_270CD077009199A0 = 2147483648;
    self._id_14AFB82AA29BC57C = 0;
  }

  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  _id_0A31AE8D2963FA9D = currentvalue &~4294901760;
  forceupdate = currentvalue & 1073741824;

  if(forceupdate != 0)
    forceupdate = 0;
  else
    forceupdate = 1073741824;

  _id_8F617FFD000EB682 = _id_0A31AE8D2963FA9D | value << 16 | forceupdate | _id_270CD077009199A0;
  self setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
}

_id_77B9DEDB0B66CA96(data) {
  if(!isDefined(data)) {
    self setclientomnvar("ui_resurgence_action_feedback", 0);
    return;
  }

  _id_E47695EF0B8F3142 = 0;
  _id_B896B356A2893E12 = undefined;
  _id_AD37E6684F9BFB21 = undefined;

  foreach(playerid, _id_C14FF75A269F0428 in data) {
    if(_id_C14FF75A269F0428._id_07BA2C5F32045574 > _id_E47695EF0B8F3142) {
      _id_E47695EF0B8F3142 = _id_C14FF75A269F0428._id_07BA2C5F32045574;
      _id_B896B356A2893E12 = playerid;
      _id_AD37E6684F9BFB21 = _id_C14FF75A269F0428;
    }
  }

  eventid = 0;

  if(isDefined(_id_AD37E6684F9BFB21.event))
    eventid = scripts\mp\rank::getscoreinfocategory(_id_AD37E6684F9BFB21.event, "stat_EC3B335BB0B2F752");

  value = _id_B896B356A2893E12 + 1 + (eventid << 3);
  self setclientomnvar("ui_resurgence_action_feedback", value);
  self._id_C1E15642EFB69421 = undefined;
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

_id_EB172B91A9FDF684() {
  player = self;

  if(player _id_67708F418B1FAC79::_id_4A25D64251FAB1B7()) {
    player _id_FB9ED4B8A0E55BFC(level.teamdata[player.team]["alivePlayers"]);
    _id_C3C91F0DFBF4F683();
    player scripts\mp\playerlogic::addtoalivecount("resurgence1");
    _id_0A34750D17473C49::unmarkplayeraseliminated(player);
    _id_4911936F026C8E38 = _id_1E4A61DB11011446::brmayconsiderplayerdead(player);

    if(!_id_4911936F026C8E38)
      _id_67708F418B1FAC79::entergulag(player);

    self.waitingtospawn = 0;
  }
}

_id_2310E5A630AB167C() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("doingRespawn");

  if(istrue(level.brgametype._id_55F0D9F2A10553C4)) {
    while(_id_D04DAAB64EA0D3DF(self))
      waitframe();

    _id_BBEE565C7645EA29();
    self notify("squad_wiped");
    waitframe();
    _id_EB172B91A9FDF684();
  } else {
    for(_id_849D01AFB2FC0F0A = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount"); _id_849D01AFB2FC0F0A > 0; _id_849D01AFB2FC0F0A = scripts\mp\utility\teams::getteamdata(self.team, "aliveCount"))
      waitframe();

    _id_BBEE565C7645EA29();
    _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("respawnInSeconds", 0);
    self notify("squad_wiped");
  }
}

_id_140BE6F794C627C9(_id_642470E1ABC1BBF9) {
  if(!isDefined(_id_642470E1ABC1BBF9.victim) || !isDefined(_id_642470E1ABC1BBF9.attacker)) {
    return;
  }
  if(_id_642470E1ABC1BBF9.victim == _id_642470E1ABC1BBF9.attacker || !isPlayer(_id_642470E1ABC1BBF9.attacker) && !isagent(_id_642470E1ABC1BBF9.attacker)) {
    return;
  }
  _id_849D01AFB2FC0F0A = scripts\mp\utility\teams::getteamdata(_id_642470E1ABC1BBF9.victim.team, "aliveCount");

  if(_id_849D01AFB2FC0F0A == 0)
    _id_642470E1ABC1BBF9.attacker scripts\cp_mp\challenges::oncollectitem("t_wipe");
}

_id_3709903D7AD3F711(player, _id_E851FFA44B7E0D54, event, points, _id_645B1A1D2A1DDFB7) {
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
  if(scripts\engine\utility::is_equal(event, "br_kioskBuy") && scripts\engine\utility::is_equal(_id_645B1A1D2A1DDFB7, "br_team_revive")) {
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
    } else if(event == "kill") {
      if(isPlayer(_id_E851FFA44B7E0D54)) {
        if(level.brgametype._id_ED0962F69D72E5B1 >= 0)
          _id_91F726FA8B73DDD5 = level.brgametype._id_ED0962F69D72E5B1;
        else
          _id_91F726FA8B73DDD5 = int(floor((250 + _id_36A08DC900BABAF2) * _id_09A5E708D6675417));
      } else if(level.brgametype._id_12D3D7F14586D634 >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_12D3D7F14586D634;
      else
        _id_CFFE35E4B21FB902 = int(floor((150 + _id_36A08DC900BABAF2) * _id_09A5E708D6675417));
    } else if(event == "headshot") {
      if(level.brgametype._id_DD674D15153F7AAB >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_DD674D15153F7AAB;
    } else if(event == "team_wiped") {
      if(level.brgametype._id_A922C322AA7D8E27 >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_A922C322AA7D8E27;
    } else if(event == "br_cacheOpen") {
      if(level.brgametype._id_DCA0E6FEF4E95FA9 >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_DCA0E6FEF4E95FA9;
      else
        _id_91F726FA8B73DDD5 = int(floor((100 + _id_36A08DC900BABAF2) * _id_09A5E708D6675417));
    } else if(event == "br_pe_capNode")
      _id_91F726FA8B73DDD5 = int(floor((700 + _id_36A08DC900BABAF2) * _id_09A5E708D6675417));
    else if(event == "resurgence_on_the_move") {
      if(level.brgametype._id_4A10A8DD79FB5AB4 >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_4A10A8DD79FB5AB4;
    } else if(event == "resurgence_hunter") {
      if(level.brgametype._id_A8FFBF7C6F0E152B >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_A8FFBF7C6F0E152B;
    } else if(event == "resurgence_hunter_double") {
      if(level.brgametype._id_53911FA2D60CCB40 >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_53911FA2D60CCB40;
    } else if(event == "resurgence_hunter_spree") {
      if(level.brgametype._id_79155A61DB265B6E >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_79155A61DB265B6E;
    } else if(event == "resurgence_armor_break") {
      if(level.brgametype._id_BC6456D93D2E9053 >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_BC6456D93D2E9053;
    } else if(event == "resurgence_fearless_kill") {
      if(level.brgametype._id_E3C11803759B1678 >= 0)
        _id_91F726FA8B73DDD5 = level.brgametype._id_E3C11803759B1678;
    } else if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      circle = min(max(1, level.br_circle.circleindex), 6);
      _id_6B00B1E8A043C2A0 = "br_downEnemy_circle_" + scripts\engine\utility::string(circle);

      if(event == _id_6B00B1E8A043C2A0) {
        if(level.brgametype._id_4A73AD987E2857E1 >= 0)
          _id_91F726FA8B73DDD5 = level.brgametype._id_4A73AD987E2857E1;
      }
    }
  }

  if(_id_91F726FA8B73DDD5 <= 0) {
    return;
  }
  if(istrue(player._id_1E309FA83F9FBE2E))
    _id_4E47F37A50CBAC36(player, _id_91F726FA8B73DDD5);
  else
    _id_249ED663848B0E5F(player, _id_91F726FA8B73DDD5, event);
}

_id_4E47F37A50CBAC36(player, _id_91F726FA8B73DDD5) {
  if(isDefined(player.respawndelay) && player.respawndelay > 0) {
    player.respawndelay = int(max(0, player.respawndelay - _id_91F726FA8B73DDD5));
    _id_362C58E8BB39BCDA::runbrgametypefunc("updateRespawnDelay", player);

    if(!isDefined(player._id_C54AFD6E867E686B))
      player._id_C54AFD6E867E686B = 0;

    player._id_C54AFD6E867E686B = player._id_C54AFD6E867E686B + _id_91F726FA8B73DDD5;
  }
}

_id_249ED663848B0E5F(player, _id_91F726FA8B73DDD5, event) {
  if(!isDefined(player.team)) {
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
        _id_362C58E8BB39BCDA::runbrgametypefunc("updateRespawnDelay", dead.player);

        if(!isDefined(dead.player._id_C54AFD6E867E686B))
          dead.player._id_C54AFD6E867E686B = 0;

        dead.player._id_C54AFD6E867E686B = dead.player._id_C54AFD6E867E686B + _id_91F726FA8B73DDD5;
        _id_7CD081D8BBC27830 = 1;
        playerid = player._id_3F78C6A0862F9E25;

        if(!isDefined(playerid) || playerid == -1) {
          continue;
        }
        if(!isDefined(dead.player._id_C1E15642EFB69421))
          dead.player._id_C1E15642EFB69421 = [];

        if(!isDefined(dead.player._id_C1E15642EFB69421[playerid])) {
          dead.player._id_C1E15642EFB69421[playerid] = spawnStruct();
          dead.player._id_C1E15642EFB69421[playerid]._id_07BA2C5F32045574 = 0;
        }

        dead.player._id_C1E15642EFB69421[playerid]._id_07BA2C5F32045574 = dead.player._id_C1E15642EFB69421[playerid]._id_07BA2C5F32045574 + _id_91F726FA8B73DDD5;

        if(isDefined(event)) {
          text = scripts\mp\rank::getscoreinfocategory(event, "stat_FA04F4EF1995407E");

          if(isDefined(text) && text != "") {
            _id_72907823769EF142 = dead.player._id_C1E15642EFB69421[playerid]._id_72907823769EF142;

            if(!isDefined(_id_72907823769EF142) || _id_91F726FA8B73DDD5 > _id_72907823769EF142) {
              dead.player._id_C1E15642EFB69421[playerid]._id_72907823769EF142 = _id_91F726FA8B73DDD5;
              dead.player._id_C1E15642EFB69421[playerid].event = event;
            }
          }
        }
      }
    }
  }

  if(_id_7CD081D8BBC27830) {
    if(istrue(player._id_5C3B157495F480A2))
      player._id_5449B5708779EE8E = player._id_5449B5708779EE8E + _id_91F726FA8B73DDD5;
    else {
      player._id_5C3B157495F480A2 = 1;
      player._id_5449B5708779EE8E = _id_91F726FA8B73DDD5;
      player thread _id_5D3D825B6D78B130();
    }
  }
}

_id_5D3D825B6D78B130() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("squad_wiped");

  if(!isPlayer(self)) {
    return;
  }
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_5449B5708779EE8E) && self._id_5449B5708779EE8E > 0)
    _id_230EA867CD69C598(self._id_5449B5708779EE8E);

  self._id_5449B5708779EE8E = undefined;
  self._id_5C3B157495F480A2 = 0;
}

_id_B1DFE6C6434FC16C() {
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4) && !istrue(self._id_08A52130C321AA8A)) {
    return;
  }
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("squad_wiped");
  player endon("force_stop_respawn");

  if(!istrue(level.brgametype._id_B43745B85F249E68))
    player thread _id_2310E5A630AB167C();

  player thread _id_F1262AB9B4BF1697();

  if(level.brgametype._id_BBDE847AED85512A)
    player thread _id_B3B332F4D23EB080();

  _id_53A4A1C920DEF4BD = player _id_338BA9B353A9A78B();

  if(isDefined(level.brgametype._id_88A254227DA87C7F) && isDefined(level.brgametype._id_88A254227DA87C7F[player.team]))
    player.respawndelay = level.brgametype._id_88A254227DA87C7F[player.team]._id_96197AE66BD1D8C3[_id_53A4A1C920DEF4BD];
  else if(isDefined(level.brgametype._id_C655C38108F1827F))
    player.respawndelay = level.brgametype._id_C655C38108F1827F;
  else if(level.br_circle.circleindex < 0)
    player.respawndelay = level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][0];
  else {
    circleindex = int(min(level.br_circle.circleindex, level.brgametype.respawndelay[_id_53A4A1C920DEF4BD].size - 1));
    player.respawndelay = level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][circleindex];
  }

  if(level.brgametype._id_14AFB82AA29BC57C > 0 && self.attacker == self) {
    player.respawndelay = player.respawndelay + level.brgametype._id_14AFB82AA29BC57C;
    player thread _id_46261E8DA3C3005E();
  }

  if(!isDefined(player.respawndelay)) {
    _id_539576F2B677F552 = "";
    _id_75C7789394667F32 = "\n";
    _id_79B9159E31664699 = getarraykeys(game["flags"]);

    foreach(name in _id_79B9159E31664699)
    _id_75C7789394667F32 = _id_75C7789394667F32 + (name + " -> " + game["flags"][name] + "\n");

    _id_539576F2B677F552 = _id_539576F2B677F552 + _id_75C7789394667F32;
    scripts\mp\utility\script::demoforcesre(_id_539576F2B677F552);
    player.respawndelay = 30;
  }

  if(getdvarint("dvar_D31B1C01A86089C2", 1) == 1 && isalive(player)) {
    scripts\mp\utility\script::demoforcesre("Alive player added to resurgence countdown. IsAlive: " + isalive(player) + ". Sessionstate: " + player.sessionstate);
    waitframe();
    scripts\mp\utility\script::demoforcesre("Alive player added to resurgence countdown - after waitframe. IsAlive: " + isalive(player) + ". Sessionstate: " + player.sessionstate);
  }

  player _id_1F013990C19FCD88();
  player _id_FFF107D76EB56064();
  player _id_B12988FDF64EFE98(player.respawndelay);

  for(player._id_C54AFD6E867E686B = 0; player.respawndelay > 0; player.respawndelay--) {
    if(isalive(player))
      player.respawndelay = 0;
    else
      player _id_B12988FDF64EFE98(player.respawndelay);

    player _id_230EA867CD69C598(player._id_C54AFD6E867E686B);
    player _id_77B9DEDB0B66CA96(player._id_C1E15642EFB69421);
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("respawnInSeconds", player.respawndelay);
    player._id_C54AFD6E867E686B = 0;
    wait 1;
  }

  player._id_C1E15642EFB69421 = undefined;
  player _id_BBEE565C7645EA29();
  player _id_B12988FDF64EFE98(0);
  player _id_230EA867CD69C598(0);
  player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("respawnInSeconds", 0);

  if(!isalive(player)) {
    if(isDefined(player.team)) {
      _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(player.team, player, 14, 1);

      foreach(_id_F0EA4030349A33D5 in level.teamdata[player.team]["alivePlayers"]) {
        if(!istrue(_id_F0EA4030349A33D5._id_0024278E2EC4540E))
          _id_F0EA4030349A33D5 thread _id_4C5AE16AC1A3265F();
      }
    }

    player thread _id_7CB9398C136B6A50(0, level.teamdata[player.team]["alivePlayers"]);
  }
}

_id_46261E8DA3C3005E() {
  level endon("game_ended");
  self endon("disconnect");

  while(self.sessionstate != "intermission")
    waitframe();

  self._id_14AFB82AA29BC57C = 1;
  _id_230EA867CD69C598(level.brgametype._id_14AFB82AA29BC57C);
}

_id_8D7079499B5B7D01() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("squad_wiped");
  self endon("force_stop_respawn");
  self endon("started_spawnPlayer");
  _id_6489FCDFE6FA2E36::waittillspectating(self);

  for(;;) {
    if(istrue(self._id_04D92A54B804BAFC)) {
      _id_123793B0882EC6FB(2);
      self waittill("team_care_request_cooldown_clear");
    }

    teamdata = level.teamdata[self.team];
    _id_6D5ED003AF1F9612 = teamdata["players"];

    if(teamdata["aliveCount"] > int(scripts\mp\utility\teams::getteamcount(self.team) * 0.5)) {
      _id_123793B0882EC6FB(0);
      scripts\engine\utility::waittill_any_ents_array(_id_6D5ED003AF1F9612, "death");
      continue;
    }

    _id_123793B0882EC6FB(1);
    _id_3170CA906B2241A6 = scripts\engine\utility::waittill_any_return_3("request_care", "team_care_request_sent", "alive_count_change");

    if(_id_3170CA906B2241A6 == "request_care") {
      _id_BCE4EFC75EB01319 = level.teamdata[self.team]["aliveCount"];

      foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
      _id_F0EA4030349A33D5 thread _id_4744BB1DB1B48F9A(_id_BCE4EFC75EB01319);

      wait(level.brgametype._id_8F48D3F93AC1204C);
    }
  }
}

_id_4744BB1DB1B48F9A(_id_BCE4EFC75EB01319) {
  level endon("game_ended");
  self endon("disconnect");
  _id_BD49896AB411C64C(_id_BCE4EFC75EB01319);
  _id_123793B0882EC6FB(2);
  thread _id_DD82FE8B8E1D0ECB();
  wait(level.brgametype._id_F8DA748DF2368691);
  _id_123793B0882EC6FB(0);
}

_id_DD82FE8B8E1D0ECB() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_04D92A54B804BAFC = 1;
  self notify("team_care_request_sent");
  wait(level.brgametype._id_74427B8346A538DF);
  self._id_04D92A54B804BAFC = 0;
  self notify("team_care_request_cooldown_clear");
}

_id_B3B332F4D23EB080() {
  level endon("game_ended");
  self endon("disconnect");

  if(!isbot(self)) {
    self notifyonplayercommand("request_care", "+ping");
    self notifyonplayercommand("request_care", "+actionslot 1");
  }

  _id_8D7079499B5B7D01();
  _id_123793B0882EC6FB(0);

  if(!isbot(self)) {
    self notifyonplayercommandremove("request_care", "+ping");
    self notifyonplayercommandremove("request_care", "+actionslot 1");
  }

  foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["players"])
  _id_F0EA4030349A33D5 notify("alive_count_change");
}

_id_4C5AE16AC1A3265F() {
  level endon("game_ended");
  self._id_0024278E2EC4540E = 1;
  thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("resurgence_teammate_respawn", self, undefined, undefined, undefined, undefined, level.brgametype._id_B09B7AFE082A9239);
  wait 5;
  self._id_0024278E2EC4540E = undefined;
}

_id_F1262AB9B4BF1697() {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();
  _id_65114AE4A91A1013();
}

_id_65114AE4A91A1013() {
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

_id_C3C91F0DFBF4F683() {
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

_id_CD4132B03FFCF8CF() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("squad_wiped");
  player endon("respawn_disabled");

  while(player.respawndelay > 0) {
    if(player.respawndelay <= 5)
      player playsoundtoplayer("ui_mp_resurgence_timer_quarter_sec", player);
    else if(player.respawndelay <= 10)
      player playsoundtoplayer("ui_mp_resurgence_timer_half_sec", player);
    else if(player.respawndelay % 4 == 2)
      player playsoundtoplayer("ui_mp_resurgence_timer", player);
    else
      player playsoundtoplayer("ui_mp_resurgence_timer_tick", player);

    player _id_B12988FDF64EFE98(player.respawndelay);
    player _id_230EA867CD69C598(player._id_C54AFD6E867E686B);
    player._id_C54AFD6E867E686B = 0;
    wait 1;
    player.respawndelay--;
  }

  player _id_BBEE565C7645EA29();
  player thread scripts\mp\hud_message::showsplash("br_resurgence_respawn_active_improvement", undefined, undefined, undefined, undefined, level.brgametype._id_042B1E877AB187C6);
}

_id_E37AC9F8CBED03EB() {
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  player = self;
  level endon("game_ended");
  player endon("squad_wiped");
  player endon("respawn_disabled");
  player endon("death_or_disconnect");

  if(getdvarint("dvar_75857926E5E5D0B8", 0) != 0)
    player.respawndelay = getdvarint("dvar_75857926E5E5D0B8", 0);
  else {
    _id_53A4A1C920DEF4BD = player _id_338BA9B353A9A78B();
    circleindex = int(max(0, int(min(level.br_circle.circleindex, level.brgametype.respawndelay[_id_53A4A1C920DEF4BD].size - 1))));
    player.respawndelay = level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][circleindex];
  }

  player waittill("respawn_done");
  player _id_B12988FDF64EFE98(player.respawndelay);
  player _id_FFF107D76EB56064();
  player._id_C54AFD6E867E686B = 0;

  while(!player isonground() && !player _meth_E40102956C887F7C())
    waitframe();

  player thread _id_CD4132B03FFCF8CF();
}

_id_F99A079543F11BF7(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  if(!istrue(self._id_1E309FA83F9FBE2E)) {
    return;
  }
  if(!istrue(level.br_prematchstarted))
    return undefined;

  player = self;

  if(istrue(player._id_EA1C01DC368298B2)) {
    player.alreadyaddedtoalivecount = 1;
    player thread _id_7CB9398C136B6A50();
    player thread _id_E37AC9F8CBED03EB();
  } else
    _id_642470E1ABC1BBF9.victim thread _id_6489FCDFE6FA2E36::spawnspectator(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7);

  player._id_EA1C01DC368298B2 = undefined;
  return 1;
}

_id_7CB9398C136B6A50(_id_CB5BA4C3282C39C1, _id_54EBFC906D9A55E7) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("doingRespawn");
  _id_30A91E1938CFD1B2 = _id_2D7EF4D534930DF4(_id_CB5BA4C3282C39C1, _id_54EBFC906D9A55E7);
  player _id_5BAB271917698DC4::_id_D5EE3D3FAD992D43(undefined, _id_30A91E1938CFD1B2);
}

_id_0002E712BC64FDE7() {
  wait 0.5;
  return 1;
}

_id_8A747FED5FDC31ED(spawnpoint, streamtimeout) {
  if(level.br_circle.circleindex < 2) {
    _id_7B693900AD4AED24 = getclosestpointonnavmesh(spawnpoint.origin);
    maxdistance = getdvarint("dvar_CD6B7DAED2AB5024", 2500);

    if(distance2d(_id_7B693900AD4AED24, spawnpoint.origin) > maxdistance) {
      targetpos = getrandomnavpoint(_id_7B693900AD4AED24, randomfloat(maxdistance));
      spawnpoint.origin = (targetpos[0], targetpos[1], spawnpoint.origin[2]);
    }
  }

  if(isDefined(self.lastdeathpos)) {
    maxdistance = getdvarint("dvar_CD6B7DAED2AB5024", 2500);
    _id_AC55BC4E66DA14A7 = maxdistance * maxdistance;

    if(distance2dsquared(self.lastdeathpos, spawnpoint.origin) > _id_AC55BC4E66DA14A7) {
      offset = spawnpoint.origin - self.lastdeathpos;
      offset = vectorNormalize(offset);
      offset = (offset[0] * maxdistance, offset[1] * maxdistance, offset[2]);
      targetpos = (self.lastdeathpos[0] + offset[0], self.lastdeathpos[1] + offset[1], offset[2]);
      targetpos = getclosestpointonnavmesh(targetpos);
      spawnpoint.origin = (targetpos[0], targetpos[1], spawnpoint.origin[2]);
    }
  }

  if(_id_5BAB271917698DC4::_id_61B5424AA3FE974E(spawnpoint.origin, streamtimeout)) {
    safeorigin = _id_2695A20D4011076D::getsafecircleorigin();
    _id_F434D604C09196AA = _id_2695A20D4011076D::getsafecircleradius();
    offset = spawnpoint.origin - safeorigin;
    offset = vectorNormalize(offset);
    offset = (offset[0] * _id_F434D604C09196AA, offset[1] * _id_F434D604C09196AA, offset[2]);
    targetpos = safeorigin + offset;
    spawnpoint.origin = (targetpos[0], targetpos[1], spawnpoint.origin[2]);
  }
}

_id_2D7EF4D534930DF4(_id_CB5BA4C3282C39C1, _id_54EBFC906D9A55E7) {
  _id_CDD53A78F51F64FE = _id_5BAB271917698DC4::_id_ADE48AF7C782E202(::_id_179991A5F6040F91, "br_ac130_flyby", undefined);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_9FD565BCD654ED48(::_id_47F3CED79ED3A338);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_B4C313DF5D7FB216(::_id_777D7EF570638306, 20);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_8CB232CDF47DA79C(::_id_FF75BBD246D432EC, 20);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_02556973693D6315(::_id_0E762446073AC085, "br_resurgence_redeploy_improvement", 20, level.brgametype._id_042B1E877AB187C6, "resurgence_redeploy", level.brgametype._id_B09B7AFE082A9239);
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_CB5BA4C3282C39C1 = _id_CB5BA4C3282C39C1;
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_54EBFC906D9A55E7 = _id_54EBFC906D9A55E7;
  return _id_CDD53A78F51F64FE;
}

_id_FF75BBD246D432EC(_id_9FDC1F9E4FC628E4) {
  if(!istrue(self._id_1E309FA83F9FBE2E))
    _id_7E52B56769FA7774::removerespawntoken();
}

_id_0E762446073AC085(_id_9FDC1F9E4FC628E4) {
  if(istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    if(istrue(self._id_1E309FA83F9FBE2E) && !istrue(self._id_36A7CB5E6F04DE78)) {
      thread scripts\mp\hud_message::showsplash("br_resurgence_survive_countdown_improvement", undefined, undefined, undefined, undefined, level.brgametype._id_042B1E877AB187C6);
      self._id_36A7CB5E6F04DE78 = 1;
    }
  } else if(istrue(self._id_1E309FA83F9FBE2E))
    thread scripts\mp\hud_message::showsplash("br_resurgence_reinforcement_closed_improvement", undefined, undefined, undefined, undefined, level.brgametype._id_042B1E877AB187C6);

  if(istrue(self._id_1E309FA83F9FBE2E))
    self notify("respawn_done");
}

_id_777D7EF570638306(_id_9FDC1F9E4FC628E4) {
  player = self;

  if(istrue(player._id_1E309FA83F9FBE2E))
    player _id_FFF107D76EB56064();
  else
    player _id_BBEE565C7645EA29();

  if(!istrue(player._id_1E309FA83F9FBE2E))
    player _id_1F013990C19FCD88();

  _id_C04B5EDF3F9EA340();
  _id_0D4066589FEF0017 = 0;
  return _id_0D4066589FEF0017;
}

_id_47F3CED79ED3A338(_id_9FDC1F9E4FC628E4) {
  player = self;

  if(!istrue(player._id_1E309FA83F9FBE2E)) {
    if(istrue(player.respawningfromtoken))
      return 0;

    player.respawningfromtoken = 1;

    if(istrue(_id_9FDC1F9E4FC628E4._id_CB5BA4C3282C39C1)) {
      player _id_AAE3AC84B3FF8E6D();
      player thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
      wait 1.5;
    }

    player _id_FB9ED4B8A0E55BFC(_id_9FDC1F9E4FC628E4._id_54EBFC906D9A55E7);
    _id_C3C91F0DFBF4F683();
    player scripts\mp\playerlogic::addtoalivecount("resurgence2");
    _id_0A34750D17473C49::unmarkplayeraseliminated(player);
    player _id_7E52B56769FA7774::addrespawntoken(1);
  } else
    player _id_FB9ED4B8A0E55BFC();

  return 1;
}

_id_179991A5F6040F91(_id_9FDC1F9E4FC628E4) {
  self notify("resurgenceRespawn");
  self.health = self.maxhealth;
  _id_3B64EB40368C1450::set("resurgenceRespawn", "player_for_spawn_logic", 0);
  _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isRespawning", 0);
}

_id_C04B5EDF3F9EA340() {
  if(isDefined(level.br_standard_loadout) || getdvarint("dvar_F97D261E2F377AD9", 1) != 0)
    self.gulagtableloadout = 1;
}

_id_B0FC27EC6E239628() {
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

_id_24034961E51052D9() {
  _id_C179E44BD14D2D12 = 0;

  if(isDefined(level._id_C04B5EDF3F9EA340)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      if(level.br_circle.circleindex == level._id_C04B5EDF3F9EA340.size - 1)
        _id_C179E44BD14D2D12 = 1;
    }
  }

  return _id_C179E44BD14D2D12;
}

_id_6AB3FA08604DED12() {
  _id_A0C010617B88D7BC = istrue(level.brgametype._id_574951D2EFF9C094) && istrue(self._id_231DD1DC2A6ED943);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && istrue(level._id_52BA18A9DC3B6BFD))
    _id_362C58E8BB39BCDA::runbrgametypefunc("giveFavoriteLoadout");
  else if((_id_A0C010617B88D7BC || istrue(level.brgametype._id_D6DC578C217F88CF)) && isDefined(self._id_5FB036C33CDDD360)) {
    _id_1E4A61DB11011446::_id_7FBB2E52F100474E();

    if(_id_A0C010617B88D7BC)
      thread scripts\mp\hud_message::showsplash("br_resurgence_vengeance_loadout", undefined, undefined, undefined, undefined, level.brgametype._id_042B1E877AB187C6);
  } else {
    if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && !istrue(self._id_AB5F5270CB22E3C8)) {
      _id_DAB2D2EFDE751B62 = "classtable:classtable_br_vanilla";
      level.br_standard_loadout = _id_1E4A61DB11011446::initstandardloadout(_id_DAB2D2EFDE751B62, 0);
      self._id_AB5F5270CB22E3C8 = 1;
    } else
      level.br_standard_loadout = _id_B0FC27EC6E239628();

    _id_C179E44BD14D2D12 = _id_24034961E51052D9();
    _id_5D3709F813102611 = scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587();
    _id_1E4A61DB11011446::givestandardtableloadout(0, 1, _id_C179E44BD14D2D12, _id_5D3709F813102611);
  }

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && istrue(level.brgametype._id_5FFBEA0FD5D29E28))
    _id_07C40FA80892A721::givestartingarmor();

  if(isDefined(level._id_D937F91DC5EF2330) && level._id_D937F91DC5EF2330._id_F8A98F02F2B8BEBF == 1)
    _id_1E4A61DB11011446::brgivestartfieldupgrade();

  if(!isDefined(self.equipment) || !isDefined(self.equipment["health"]))
    _id_07C40FA80892A721::_id_BE5C0CDFA0202544();

  self._id_231DD1DC2A6ED943 = undefined;
  return 0;
}

_id_0DECD4293C451C70() {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(!isDefined(self._id_B2B6316D154F7468)) {
    self._id_B2B6316D154F7468 = 1;
    _id_CE214AFC7B96A3A7 = getdvarint("dvar_E67C864263196598", 1);

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
}

_id_53382489FF523151() {
  _id_B1F627237929640E = ["brloot_self_revive", "brloot_equip_gasmask", "brloot_equip_gasmask_durable"];
  return scripts\engine\utility::_id_7A2AAA4A09A4D250(_id_B1F627237929640E);
}

getrandomkillstreak(_id_D1C6815242045D90) {
  return pickscriptablelootitem("killstreak", 0, _id_D1C6815242045D90, "mp/loot/br/default/lootset_cache_base.csv");
}

_id_B398ACC9BA21ECB5() {
  return getdvarint("dvar_05C872AF62541D1D", 3);
}

circletimer(circleindex) {
  if(istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    _id_10B5C13C81DB5079 = _id_B398ACC9BA21ECB5();

    if(circleindex >= _id_10B5C13C81DB5079) {
      _id_1A3782804D2407E5();

      if(_id_2C3C990BA58FA6F5::_id_364F4C40FF756CAC()) {
        if(isDefined(level._id_49D407295B31E357) && isDefined(level._id_49D407295B31E357._id_08CBC8B62D3634B5))
          thread[[level._id_49D407295B31E357._id_08CBC8B62D3634B5]](0);
      }
    }
  }
}

_id_338BA9B353A9A78B() {
  _id_89850B370A87AA3C = 0;

  if(level.brgametype._id_BB9B77186CB79AE6) {
    players = scripts\mp\utility\player::getteamarray(self.team);
    _id_89850B370A87AA3C = players.size - 1;

    foreach(player in players) {
      if(isDefined(player) && istrue(player._id_632BAD3EDB4E449E))
        _id_89850B370A87AA3C--;
    }
  } else
    _id_89850B370A87AA3C = getdvarint("dvar_4838B7C39021124C", 1) - 1;

  _id_89850B370A87AA3C = int(max(min(_id_89850B370A87AA3C, level.brgametype._id_34AF112C77C2C381.size - 1), 0));
  return level.brgametype._id_34AF112C77C2C381[_id_89850B370A87AA3C];
}

_id_F39FA02F6ED912FC(attackers) {
  if(!istrue(self._id_1E309FA83F9FBE2E)) {
    return;
  }
  victim = self;

  if(!isDefined(victim.respawndelay))
    victim.respawndelay = 0;

  if(victim.respawndelay > 0 || !istrue(level.brgametype._id_C42E40EC22A1F0D4))
    attackers[attackers.size] = victim.laststandattacker;
}

_id_1A3782804D2407E5() {
  level.brgametype._id_C42E40EC22A1F0D4 = 0;
  level.brgametype._id_BBDE847AED85512A = 0;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    level notify("respawn_disabled ");

  if(!level.brgametype._id_04AD7C03EC4FA687) {
    _id_683452DFA2B09CCD();
    _id_362C58E8BB39BCDA::runbrgametypefunc("resurgenceDisable");
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("resurgenceDisableSkipForPlayer", player))) {
      continue;
    }
    if(scripts\mp\utility\player::isinlaststand(player)) {
      player._id_08A52130C321AA8A = 1;
      player thread _id_3D8918359E1B33C5();
    }

    player thread scripts\mp\hud_message::showsplash("br_resurgence_reinforcement_closed_improvement", undefined, undefined, undefined, undefined, level.brgametype._id_042B1E877AB187C6);
    player setclientomnvar("ui_br_timed_feature_end_time", 0);

    if(istrue(player._id_1E309FA83F9FBE2E)) {
      player notify("respawn_disabled");
      continue;
    }

    player _id_362C58E8BB39BCDA::runbrgametypefunc("playerResurgenceDisable");
  }

  _id_2CEDCC356F1B9FC8::brleaderdialog("resurgence_disabled", undefined, undefined, undefined, undefined, undefined, level.brgametype._id_B09B7AFE082A9239);
}

_id_3D8918359E1B33C5() {
  self endon("death_or_disconnect");
  self waittill("last_stand_revived");
  self._id_08A52130C321AA8A = undefined;
}

_id_97B175CEC5B685BE(table) {
  if(!isDefined(level._id_C04B5EDF3F9EA340))
    level._id_C04B5EDF3F9EA340 = [];

  _id_A78225C464121E51 = level._id_C04B5EDF3F9EA340.size;
  _id_07D958726E11B327 = scripts\mp\class::_id_DF2933F96D726D71(table);
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
  _id_CFA6985254954FB3 = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11);
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = _id_CFA6985254954FB3.primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = _id_CFA6985254954FB3.primaryweapon._id_59F68715C04CE28F;
  loadout["loadoutPrimaryAttachment2"] = _id_CFA6985254954FB3.primaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutPrimaryAttachment3"] = _id_CFA6985254954FB3.primaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutPrimaryAttachment4"] = _id_CFA6985254954FB3.primaryweapon._id_59F68215C04CD790;
  loadout["loadoutPrimaryAttachment5"] = _id_CFA6985254954FB3.primaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutPrimaryCamo"] = _id_CFA6985254954FB3.primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = _id_CFA6985254954FB3.primaryweapon.reticle;
  loadout["loadoutSecondary"] = _id_CFA6985254954FB3.secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68715C04CE28F;
  loadout["loadoutSecondaryAttachment2"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutSecondaryAttachment3"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutSecondaryAttachment4"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68215C04CD790;
  loadout["loadoutSecondaryAttachment5"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutSecondaryCamo"] = _id_CFA6985254954FB3.secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = _id_CFA6985254954FB3.secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = _id_CFA6985254954FB3.equipment.primary;
  loadout["loadoutEquipmentSecondary"] = _id_CFA6985254954FB3.equipment._id_D7B9856A19F9B6B5;
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [_id_CFA6985254954FB3.perks._id_16680ABD1742C050, _id_CFA6985254954FB3.perks._id_16680DBD1742C6E9, _id_CFA6985254954FB3.perks._id_16680CBD1742C4B6, _id_CFA6985254954FB3._id_50D0559DCBA571E2._id_16680ABD1742C050, _id_CFA6985254954FB3._id_50D0559DCBA571E2._id_16680DBD1742C6E9, _id_CFA6985254954FB3._id_50D0559DCBA571E2._id_16680CBD1742C4B6];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = _id_089688461C79EF11;
  return loadout;
}

_id_38A46A469C73DC2C() {
  _id_F9CBFF5134DA960B = (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], 0);
  _id_E5BD279D3767139F = level.br_level.br_circleradii[1];
  c130pathstruct = _id_45B2B4A889E633FA::createtestc130path(_id_F9CBFF5134DA960B, _id_E5BD279D3767139F, undefined, level.brgametype._id_B024F80FC9886FC4, level.brgametype._id_92FCC390C4C0ACD7);
  return c130pathstruct;
}

_id_C338E39DB41D9374() {
  thread _id_6CC4C90F16A60A4B();
}

_id_6CC4C90F16A60A4B() {
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

_id_7EA88DD9BC483463(player) {
  if(!scripts\mp\flags::gameflag("prematch_fade_done") || level.brgametype._id_04AD7C03EC4FA687 || !istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  _id_5AAB9D85460F9E87 = scripts\mp\utility\player::getteamarray(player.team);

  foreach(_id_55604B242897E62E in _id_5AAB9D85460F9E87)
  _id_0C17A21E7020DF4C(_id_55604B242897E62E, 0, player);

  if(istrue(level.brgametype._id_BB9B77186CB79AE6) && istrue(level.brgametype._id_C42E40EC22A1F0D4) && !istrue(level.brgametype._id_2B5EE6212B58E7A6))
    _id_2CEDCC356F1B9FC8::brleaderdialog("resurgence_on_player_disconnect", 1, _id_5AAB9D85460F9E87, undefined, 0, undefined, "dx_br_bds4_");
}

_id_9BF15D9BF66EAD8D(player) {
  if(!istrue(player._id_632BAD3EDB4E449E))
    thread _id_C4D09E34EB4D8E2B(player, 1);

  return [];
}

_id_E60EBCDF4083532E(player) {
  thread _id_C4D09E34EB4D8E2B(player, 0);
}

_id_C4D09E34EB4D8E2B(player, _id_051C0C03BB238C17) {
  level endon("game_ended");

  if(!scripts\mp\flags::gameflag("prematch_fade_done") || level.brgametype._id_04AD7C03EC4FA687 || !istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  _id_5AAB9D85460F9E87 = scripts\mp\utility\player::getteamarray(player.team);

  if(istrue(level.brgametype._id_BB9B77186CB79AE6)) {
    if(level.brgametype._id_8947D8F4E61494FA) {
      foreach(_id_55604B242897E62E in _id_5AAB9D85460F9E87) {
        _id_F7B6CC6C062A7A43 = "br_resurgence_ally_rejoin_improvement";

        if(istrue(_id_051C0C03BB238C17))
          _id_F7B6CC6C062A7A43 = "br_resurgence_ally_left_improvement";

        _id_55604B242897E62E thread scripts\mp\hud_message::showsplash(_id_F7B6CC6C062A7A43, undefined, player, undefined, undefined, level.brgametype._id_042B1E877AB187C6);
      }
    }

    if(_id_051C0C03BB238C17)
      _id_2CEDCC356F1B9FC8::brleaderdialog("resurgence_on_player_disconnect", 1, _id_5AAB9D85460F9E87, undefined, 0, undefined, "dx_br_bds4_");
  }
}

_id_0CC9995519D9CEE6(player, _id_08ADB6861B69910E) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isalive(player) || !player isonground() && !player _meth_E40102956C887F7C())
    wait 1;

  if(!_id_08ADB6861B69910E && istrue(level.brgametype._id_FB997D1846BD5CF4))
    player thread scripts\mp\hud_message::showsplash("br_resurgence_left_behind_improvement", undefined, undefined, undefined, undefined, level.brgametype._id_042B1E877AB187C6);

  player.respawndelay = 0;
  player._id_1E309FA83F9FBE2E = 1;
  player setclientomnvar("ui_br_resurgence_respawn_type", 1);
}

_id_22EF1CD58A8D87E8() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_0774C9CA5D1D6221 = getdvarint("dvar_4838B7C39021124C", 0);

  foreach(team in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamcount(team) < _id_0774C9CA5D1D6221) {
      _id_A6AB8D0FDA441DC2 = scripts\mp\utility\player::getteamarray(team);

      foreach(player in _id_A6AB8D0FDA441DC2) {
        if(isDefined(player))
          _id_0C17A21E7020DF4C(player, 1);
      }
    }
  }
}

_id_0C17A21E7020DF4C(player, _id_08ADB6861B69910E, _id_3DC09661D4D00956) {
  if(scripts\mp\utility\teams::getteamcount(player.team) == 1 && istrue(level.brgametype._id_9524142EB719A321))
    thread _id_0CC9995519D9CEE6(player, _id_08ADB6861B69910E);
  else if(!_id_08ADB6861B69910E && istrue(level.brgametype._id_8947D8F4E61494FA) && !istrue(level.brgametype._id_2B5EE6212B58E7A6))
    player thread scripts\mp\hud_message::showsplash("br_resurgence_ally_left_improvement", undefined, _id_3DC09661D4D00956, undefined, 1, level.brgametype._id_042B1E877AB187C6);
}

_id_81BAAD6D96FF2130() {
  level endon("game_ended");
  level scripts\engine\utility::flag_wait("StartGameTypeCallbackFinished");
  level.brgametype._id_2B5EE6212B58E7A6 = _id_04CDABCD91A92977::_id_E3BD94413509BC25() && getdvarint("dvar_B14D64E76F160241", 1);

  if(istrue(level.brgametype._id_2B5EE6212B58E7A6)) {
    _id_04CDABCD91A92977::_id_8CE5B106FBBA9E9F(::_id_9BF15D9BF66EAD8D);
    _id_04CDABCD91A92977::_id_8FE6D6539ED31A88(::_id_E60EBCDF4083532E);
  }
}

_id_797B21B78B5E0A26(_id_114D19D4F6606873) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(player in level.players) {
    if(isDefined(player)) {
      _id_EC0FC26262EF7791 = level.brgametype._id_04AD7C03EC4FA687 || level.brgametype._id_9524142EB719A321 && scripts\mp\utility\teams::getteamcount(player.team) == 1;

      if(_id_EC0FC26262EF7791) {
        player.respawndelay = 0;
        player._id_1E309FA83F9FBE2E = 1;
        player setclientomnvar("ui_br_resurgence_respawn_type", 1);
      } else {
        player._id_1E309FA83F9FBE2E = 0;
        player setclientomnvar("ui_br_resurgence_respawn_type", 0);
      }
    }
  }
}

_id_04F5568CF15D60B8() {
  if(!istrue(level.brgametype._id_F439C17A413F05C3)) {
    return;
  }
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(player in level.players) {
    if(isDefined(player))
      player._id_8C5C47F81A1869E5 = ::_id_A045BCDB0D1BEBF9;
  }
}

_id_90507E372A40C684() {
  if(!istrue(level.brgametype._id_F9623A041E743669)) {
    return;
  }
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_3B90A1EE7A57F5B1 = [];

  foreach(perkref in level._id_FFC23517BDB76237) {
    if(_id_793956FB93DE9504(perkref)) {
      _id_4A0E5042CE1AE1E2 = level._id_A1AD2758FCBD2F5E[perkref]._id_4A0E5042CE1AE1E2;

      if(!isDefined(_id_3B90A1EE7A57F5B1[_id_4A0E5042CE1AE1E2]))
        _id_3B90A1EE7A57F5B1[_id_4A0E5042CE1AE1E2] = [];

      _id_BB58BCC7B0654344 = _id_3B90A1EE7A57F5B1[_id_4A0E5042CE1AE1E2].size;
      _id_3B90A1EE7A57F5B1[_id_4A0E5042CE1AE1E2][_id_BB58BCC7B0654344] = perkref;
    }
  }

  level.brgametype._id_3B90A1EE7A57F5B1 = _id_3B90A1EE7A57F5B1;
}

_id_793956FB93DE9504(perkref) {
  return isDefined(level._id_A1AD2758FCBD2F5E[perkref]) && istrue(level._id_A1AD2758FCBD2F5E[perkref]._id_594AF43597023062) && istrue(level._id_A1AD2758FCBD2F5E[perkref].specialistbr) && !istrue(level._id_A1AD2758FCBD2F5E[perkref]._id_806F83B21EA91E21);
}

_id_010870C1A437402B() {
  _id_FAEEDAF859FD76F6 = [];
  _id_56DDE920C84C7B04 = -15;
  circleindex = getdvarint("dvar_0D8B0FCD21FAAA19", 1);
  _id_C2D7D58BFAD1B1EE = _id_2695A20D4011076D::getcircleclosetime(circleindex);
  _id_A14D77328BA7E8F1 = max(0, _id_C2D7D58BFAD1B1EE + _id_56DDE920C84C7B04);
  _id_7B76B8BB6B541A17 = getdvarfloat("dvar_B81B25BCD8C7D749", _id_A14D77328BA7E8F1);

  if(_id_7B76B8BB6B541A17 == -1.0)
    _id_7B76B8BB6B541A17 = _id_A14D77328BA7E8F1;

  _id_FAEEDAF859FD76F6[_id_FAEEDAF859FD76F6.size] = _id_7B76B8BB6B541A17;
  circleindex = getdvarint("dvar_DDCEF5DA1224B559", -1);

  if(circleindex > 0) {
    _id_C2D7D58BFAD1B1EE = _id_2695A20D4011076D::getcircleclosetime(circleindex);
    _id_A14D77328BA7E8F1 = max(0, _id_C2D7D58BFAD1B1EE + _id_56DDE920C84C7B04);
    _id_7B76B8BB6B541A17 = getdvarfloat("dvar_3771B5264B3F0789", _id_A14D77328BA7E8F1);

    if(_id_7B76B8BB6B541A17 == -1.0)
      _id_7B76B8BB6B541A17 = _id_A14D77328BA7E8F1;

    _id_FAEEDAF859FD76F6[_id_FAEEDAF859FD76F6.size] = _id_7B76B8BB6B541A17;
  }

  _id_362C58E8BB39BCDA::registerbrgametypedata("dropBagDelay", _id_FAEEDAF859FD76F6);
}

_id_9680317AFD0E4558() {
  level endon("game_ended");
  circleindex = getdvarint("dvar_18DDB1FF66D76C3E", 5);
  _id_C2D7D58BFAD1B1EE = _id_2695A20D4011076D::getcircleclosetime(circleindex);
  level waittill("prematch_started");
  wait(_id_C2D7D58BFAD1B1EE);
  circlecenter = level.br_level.br_circlecenters[circleindex + 1];
  radius = level.br_level.br_circleradii[circleindex + 1];
  count = getdvarint("dvar_D56A2151B61E380C", 3);
  _id_D0DE0DB1760B9C5B = 360 / count;
  yaw = 0.0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    yaw = yaw + _id_D0DE0DB1760B9C5B;
    _id_F7D73AC7E17AA57E = (0, yaw, 0);
    _id_45FE3F8F3E08E301 = circlecenter + anglesToForward(_id_F7D73AC7E17AA57E) * radius * 0.5;
    _id_332BFCF7ECA6F520 = _id_2695A20D4011076D::getrandompointinboundscircle(_id_45FE3F8F3E08E301, radius * 0.5, 0.25, 0.75, 1, 0, 1);
    _id_57CE8F0135B8B312::_id_590979EF771686A8(undefined, _id_332BFCF7ECA6F520);
  }
}

_id_C2E48F2200BD249B() {
  circlecenter = getdvarvector("dvar_EB589C6BD2884BBB", level._id_E6BDEFD8842BDD49);
  return circlecenter;
}

_id_E793259B8F9D5B2D() {
  _id_362C58E8BB39BCDA::registerbrgametypefunc("isTeamEliminated", ::_id_ED345D3EFB37C25C);
  level.checkforlaststandwipe = ::_id_7657B6775B05E1B9;
  level.brgametype._id_B43745B85F249E68 = 1;
  level._id_9F2C0D537922A861 = 1;
}

_id_ED345D3EFB37C25C(_id_FABF84450735DD93) {
  return 0;
}

_id_7657B6775B05E1B9(victim, _id_9C14AE6E04BBD667) {
  return 0;
}

_id_123793B0882EC6FB(_id_9B1941CB7354665E) {
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_resurgence_care_request", 0, 2, _id_9B1941CB7354665E);
}

_id_BD49896AB411C64C(_id_BCE4EFC75EB01319) {
  scripts\cp_mp\utility\omnvar_utility::_id_63437FCA39C681DC("ui_resurgence_care_request", 2, 3, _id_BCE4EFC75EB01319);
}

playerwelcomesplashes(data) {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("infil_animatic_complete");

  if(getdvarint("dvar_4838B7C39021124C", 0) == 1)
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective_solo", self, undefined, undefined, 1.5, undefined, level.brgametype._id_B09B7AFE082A9239);
  else
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective", self, undefined, undefined, 1.5, undefined, level.brgametype._id_B09B7AFE082A9239);

  if(istrue(self.isbrsquadleader))
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("deploy_squad_leader", self, 1, 0, 4.5);

  while(!self isonground())
    waitframe();

  _id_715028F54BAD19A1::branalytics_landing(self);
}