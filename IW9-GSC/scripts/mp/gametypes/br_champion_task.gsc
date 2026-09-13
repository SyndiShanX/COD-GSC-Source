/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_champion_task.gsc
*****************************************************/

init() {
  level._id_E4CFB225AB81E7BC = spawnStruct();
  level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40 = [];
  level._id_E4CFB225AB81E7BC._id_D4B9E030F49735D5 = 0;
  level._id_E4CFB225AB81E7BC._id_07E96A4CD28C47DF = getdvarint("dvar_157892394561C040", 20000);
  level._id_E4CFB225AB81E7BC.category = [];
  level._id_E4CFB225AB81E7BC._id_165262BFF9D18643 = getdvarint("dvar_19D0A0659E587943", 3);
  level._id_E4CFB225AB81E7BC._id_321199DD86ADA674 = [];
  level._id_E4CFB225AB81E7BC._id_321199DD86ADA674[0] = getdvarint("dvar_20142DF6EA94BBFB", 30);
  level._id_E4CFB225AB81E7BC._id_321199DD86ADA674[1] = getdvarint("dvar_270A15B4F57B1367", 30);
  level._id_E4CFB225AB81E7BC.cooldowntime = getdvarint("dvar_6E0CC95268573EE8", 2);
  level._id_E4CFB225AB81E7BC._id_C03AA461C41A6798 = getDvar("dvar_3E231620461938E3", "");
  _id_6D00AE53CE465992();
  loadtables();
  _id_76E0D0742A7D2EBC();
  _id_1B0C7342C6A5006F();
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerFirstLand", ::_id_FCE871AF545EE33C);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPickupItemUsed", ::_id_F817ADD79E895736);
  level thread _id_F5C1889669D23A75();
}

_id_1B0C7342C6A5006F() {
  _id_50D581B454B6D41D::_id_FE852F92145C24A6();
  _id_3B9AF437CA74921E::_id_FE852F92145C24A6();
  _id_7273C20B83D8FF3B::_id_FE852F92145C24A6();
  _id_538F66FCE659A889::_id_FE852F92145C24A6();
  _id_5815E81B17277D5F::_id_FE852F92145C24A6();
  _id_74661DC598AE1A43::_id_FE852F92145C24A6();
}

_id_FCE871AF545EE33C(player) {
  if(scripts\mp\flags::gameflag("prematch_done") && !istrue(player.br_isplayerbeforeinitialinfildeploy))
    level.teamdata[player.team]["taskInfo"].activated = 1;
}

_id_A978C2984EE71B09(left, right) {
  return left.weight < right.weight;
}

_id_5D533973550BC682() {
  foreach(_id_E4CFB225AB81E7BC in level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40) {
    if(_id_E4CFB225AB81E7BC._id_500370E4F476FAA9 > 0) {
      eventref = "champion_mission_" + _id_E4CFB225AB81E7BC.ref + "_completed";
      scripts\mp\rank::registerscoreinfo(eventref, "stat_7CE4FD9430E80CEA", _id_E4CFB225AB81E7BC._id_500370E4F476FAA9);
    }
  }
}

_id_545FD3E2A4AA7A6C() {
  foreach(_id_E4CFB225AB81E7BC in level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40) {
    eventref = "champion_mission_" + _id_E4CFB225AB81E7BC.ref + "_completed";
    scripts\mp\rank::registerscoreinfo(eventref, "stat_2A95DA1330928B16", _id_E4CFB225AB81E7BC.id);
  }
}

_id_6D00AE53CE465992() {
  _id_592628DE6512430C = getdvarint("dvar_3DFCD10AE7842553", 1);
  level._id_E4CFB225AB81E7BC._id_F789E187C35E4184 = scripts\engine\utility::ter_op(_id_592628DE6512430C == 1, "mp/brmission_champion_task.csv", "mp/brmission_champion_task_mixed_squad.csv");
  level._id_E4CFB225AB81E7BC._id_24C261C20943F470 = scripts\engine\utility::ter_op(_id_592628DE6512430C == 1, "mp/brmission_champion_task_difficulty.csv", "mp/brmission_champion_task_mixed_squad_difficulty.csv");
}

_id_76E0D0742A7D2EBC() {
  _id_CB89110314447B2F = 0;
  _id_50FED135881D222C = [];

  for(;;) {
    _id_E1677011E469CF5D = tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_24C261C20943F470, _id_CB89110314447B2F, 0);

    if(!isDefined(_id_E1677011E469CF5D) || _id_E1677011E469CF5D == "") {
      break;
    }

    _id_E1677011E469CF5D = int(_id_E1677011E469CF5D);
    _id_50FED135881D222C[_id_E1677011E469CF5D] = [];
    _id_2E93CEABF63022FC = 0;

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 5; _id_AC0E594AC96AA3A8++) {
      _id_50FED135881D222C[_id_E1677011E469CF5D][_id_2E93CEABF63022FC] = int(tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_24C261C20943F470, _id_CB89110314447B2F, _id_AC0E594AC96AA3A8));
      _id_2E93CEABF63022FC++;
    }

    _id_CB89110314447B2F++;
  }

  level._id_E4CFB225AB81E7BC._id_50FED135881D222C = _id_50FED135881D222C;
}

loadtables() {
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_015AD24E2FBEEE5D = tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 1);

    if(!isDefined(_id_015AD24E2FBEEE5D) || _id_015AD24E2FBEEE5D == "") {
      break;
    }

    _id_E4CFB225AB81E7BC = spawnStruct();
    _id_E4CFB225AB81E7BC.ref = _id_015AD24E2FBEEE5D;
    _id_E4CFB225AB81E7BC.id = int(tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 0));
    _id_E4CFB225AB81E7BC.weight = int(tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 2));
    _id_E4CFB225AB81E7BC.category = tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 3);
    _id_E4CFB225AB81E7BC._id_1C9CB43BCF3EB16D = tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 4);
    _id_E4CFB225AB81E7BC._id_6A656594EA8FFCFA = tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 5);
    _id_E4CFB225AB81E7BC.targetnum = int(tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 6));
    _id_E4CFB225AB81E7BC.duration = int(tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 7));
    _id_E4CFB225AB81E7BC.objectiveicon = tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 9);
    _id_E4CFB225AB81E7BC._id_C89DC5A2CAA0D945 = tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 10);
    _id_E4CFB225AB81E7BC._id_500370E4F476FAA9 = int(tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 13));
    _id_E4CFB225AB81E7BC.difficulty = int(tablelookupbyrow(level._id_E4CFB225AB81E7BC._id_F789E187C35E4184, _id_CB89110314447B2F, 14));
    level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40[level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40.size] = _id_E4CFB225AB81E7BC;

    if(!isDefined(level._id_E4CFB225AB81E7BC.category[_id_E4CFB225AB81E7BC.category])) {
      level._id_E4CFB225AB81E7BC.category[_id_E4CFB225AB81E7BC.category] = spawnStruct();
      level._id_E4CFB225AB81E7BC.category[_id_E4CFB225AB81E7BC.category].funcs = [];
    }

    _id_CB89110314447B2F++;
  }

  level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40 = scripts\engine\utility::array_sort_with_func(level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40, ::_id_A978C2984EE71B09);

  foreach(_id_B8EBE3F71A08AB40 in level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40)
  level._id_E4CFB225AB81E7BC._id_D4B9E030F49735D5 = level._id_E4CFB225AB81E7BC._id_D4B9E030F49735D5 + _id_B8EBE3F71A08AB40.weight;
}

_id_F5C1889669D23A75() {
  level endon("game_ended");
  level waittill("prematch_done");
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_FAF2C6A1A5A7AA93);
  _id_5D533973550BC682();
  _id_545FD3E2A4AA7A6C();

  foreach(tablet in level.questinfo.activetablets)
  tablet setscriptablepartstate(tablet.type, "hidden");

  level thread _id_8E45171E5C3A01BE();
}

_id_AE0491BEE1CD18B1(team) {
  level endon("game_ended");

  for(;;) {
    waittime = level._id_E4CFB225AB81E7BC._id_321199DD86ADA674[self._id_E730E6B70780F72B];
    self._id_E730E6B70780F72B++;

    if(!isDefined(waittime)) {
      return;
    }
    wait(waittime);
  }
}

_id_8E45171E5C3A01BE() {
  level endon("game_ended");

  for(;;) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(level.teamdata[_id_F90358454413407F]["alivePlayers"].size <= 0) {
        continue;
      }
      _id_E4CFB225AB81E7BC = level.teamdata[_id_F90358454413407F]["taskInfo"];

      if(!isDefined(_id_E4CFB225AB81E7BC)) {
        _id_E4CFB225AB81E7BC = spawnStruct();
        _id_E4CFB225AB81E7BC._id_BF3BD069CCF703A8 = [];
        _id_E4CFB225AB81E7BC.activated = 0;
        _id_E4CFB225AB81E7BC._id_E1677011E469CF5D = 0;
        level.teamdata[_id_F90358454413407F]["taskInfo"] = _id_E4CFB225AB81E7BC;
      }

      if(!istrue(_id_E4CFB225AB81E7BC.activated)) {
        continue;
      }
      if(!isDefined(_id_E4CFB225AB81E7BC._id_E730E6B70780F72B)) {
        _id_E4CFB225AB81E7BC._id_E730E6B70780F72B = 0;
        _id_E4CFB225AB81E7BC thread _id_AE0491BEE1CD18B1(_id_F90358454413407F);
      }

      if(isDefined(_id_E4CFB225AB81E7BC.lastfinishtime) && _id_E4CFB225AB81E7BC.lastfinishtime + level._id_E4CFB225AB81E7BC.cooldowntime * 1000 > gettime()) {
        continue;
      }
      if(_id_E4CFB225AB81E7BC._id_BF3BD069CCF703A8.size < _id_E4CFB225AB81E7BC._id_E730E6B70780F72B) {
        _id_B8EBE3F71A08AB40 = _id_D1B023D925DEF837(_id_F90358454413407F);
        _id_6DC0BBC01CB1F972(_id_B8EBE3F71A08AB40, _id_F90358454413407F);
      }
    }

    wait 0.5;
  }
}

_id_A6CD232D5AE39984(team) {
  _id_E4CFB225AB81E7BC = level.teamdata[team]["taskInfo"];
  _id_E1677011E469CF5D = _id_E4CFB225AB81E7BC._id_E1677011E469CF5D;

  if(_id_E4CFB225AB81E7BC._id_E1677011E469CF5D >= level._id_E4CFB225AB81E7BC._id_50FED135881D222C.size)
    _id_E1677011E469CF5D = level._id_E4CFB225AB81E7BC._id_50FED135881D222C.size - 1;

  _id_50FED135881D222C = level._id_E4CFB225AB81E7BC._id_50FED135881D222C[_id_E1677011E469CF5D];
  _id_D4B9E030F49735D5 = 0;

  foreach(weight in _id_50FED135881D222C)
  _id_D4B9E030F49735D5 = _id_D4B9E030F49735D5 + weight;

  _id_00AE14C5A8B1B582 = randomintrange(1, _id_D4B9E030F49735D5 + 1);
  _id_23FA13A8754DF71E = 0;
  difficulty = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_50FED135881D222C.size; _id_AC0E594AC96AA3A8++) {
    _id_23FA13A8754DF71E = _id_23FA13A8754DF71E + _id_50FED135881D222C[_id_AC0E594AC96AA3A8];

    if(_id_23FA13A8754DF71E >= _id_00AE14C5A8B1B582) {
      difficulty = _id_AC0E594AC96AA3A8;
      break;
    }
  }

  return difficulty;
}

_id_52C8C6CE1652AC8A(_id_ECFACC314935307E) {
  if(level._id_E4CFB225AB81E7BC._id_C03AA461C41A6798 == "")
    return undefined;

  foreach(_id_17953215DD7C5F9B in _id_ECFACC314935307E) {
    if(_id_17953215DD7C5F9B.info.ref == level._id_E4CFB225AB81E7BC._id_C03AA461C41A6798)
      return undefined;
  }

  _id_C03AA461C41A6798 = undefined;
  _id_BF3BD069CCF703A8 = level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40;

  foreach(_id_B8EBE3F71A08AB40 in _id_BF3BD069CCF703A8) {
    if(_id_B8EBE3F71A08AB40.ref == level._id_E4CFB225AB81E7BC._id_C03AA461C41A6798) {
      _id_C03AA461C41A6798 = _id_B8EBE3F71A08AB40;
      break;
    }
  }

  return _id_C03AA461C41A6798;
}

_id_98E66AC4422E0A25(team, _id_B8EBE3F71A08AB40, _id_EFC95EC059EE8D1F, _id_809DC2BC8D228963) {
  if(_id_B8EBE3F71A08AB40.difficulty != _id_809DC2BC8D228963)
    return 1;

  _id_411DF937520D264C = level.teamdata[team]["taskInfo"]._id_411DF937520D264C;
  _id_0598C27310477274 = isDefined(_id_411DF937520D264C) && _id_411DF937520D264C._id_6A656594EA8FFCFA == _id_B8EBE3F71A08AB40._id_6A656594EA8FFCFA;
  return istrue(_id_EFC95EC059EE8D1F[_id_B8EBE3F71A08AB40._id_6A656594EA8FFCFA]) || _id_0598C27310477274;
}

_id_D1B023D925DEF837(team) {
  if(!isDefined(level._id_E4CFB225AB81E7BC._id_D4B9E030F49735D5))
    return undefined;

  _id_ECFACC314935307E = level.teamdata[team]["taskInfo"]._id_BF3BD069CCF703A8;
  _id_C03AA461C41A6798 = _id_52C8C6CE1652AC8A(_id_ECFACC314935307E);

  if(isDefined(_id_C03AA461C41A6798))
    return _id_C03AA461C41A6798;

  _id_809DC2BC8D228963 = _id_A6CD232D5AE39984(team);
  _id_EFC95EC059EE8D1F = [];

  foreach(_id_B8EBE3F71A08AB40 in _id_ECFACC314935307E)
  _id_EFC95EC059EE8D1F[_id_B8EBE3F71A08AB40.info._id_6A656594EA8FFCFA] = 1;

  _id_5F5F4821BB1203D7 = [];
  _id_83377FE188EA5189 = 0;

  foreach(_id_B8EBE3F71A08AB40 in level._id_E4CFB225AB81E7BC._id_B8EBE3F71A08AB40) {
    if(!_id_98E66AC4422E0A25(team, _id_B8EBE3F71A08AB40, _id_EFC95EC059EE8D1F, _id_809DC2BC8D228963)) {
      _id_83377FE188EA5189 = _id_83377FE188EA5189 + _id_B8EBE3F71A08AB40.weight;
      _id_5F5F4821BB1203D7[_id_5F5F4821BB1203D7.size] = _id_B8EBE3F71A08AB40;
    }
  }

  if(_id_83377FE188EA5189 <= 0)
    return undefined;

  _id_00AE14C5A8B1B582 = randomintrange(1, _id_83377FE188EA5189 + 1);
  _id_23FA13A8754DF71E = 0;
  _id_BE80583079EC3E95 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5F5F4821BB1203D7.size; _id_AC0E594AC96AA3A8++) {
    _id_23FA13A8754DF71E = _id_23FA13A8754DF71E + _id_5F5F4821BB1203D7[_id_AC0E594AC96AA3A8].weight;

    if(_id_23FA13A8754DF71E >= _id_00AE14C5A8B1B582) {
      _id_BE80583079EC3E95 = _id_5F5F4821BB1203D7[_id_AC0E594AC96AA3A8];
      break;
    }
  }

  return _id_BE80583079EC3E95;
}

_id_6DC0BBC01CB1F972(_id_BE80583079EC3E95, team) {
  if(!isDefined(_id_BE80583079EC3E95)) {
    return;
  }
  _id_AC52D7E9D13E767F = level._id_E4CFB225AB81E7BC.category[_id_BE80583079EC3E95.category].funcs;

  if(isDefined(_id_AC52D7E9D13E767F["checkTaskValid"])) {
    isvalid = [[_id_AC52D7E9D13E767F["checkTaskValid"]]](_id_BE80583079EC3E95, team);

    if(!isvalid)
      return;
  }

  _id_17953215DD7C5F9B = _id_2A01F2053FBDC8E4(_id_BE80583079EC3E95, team);
  [[_id_AC52D7E9D13E767F["tryAssignTask"]]](_id_17953215DD7C5F9B);

  if((issubstr(_id_BE80583079EC3E95.ref, "kill") || issubstr(_id_BE80583079EC3E95.ref, "down") || issubstr(_id_BE80583079EC3E95.ref, "damage")) && _id_BE80583079EC3E95.ref != "any_killstreak") {
    foreach(player in level.teamdata[team]["players"]) {
      if(!isbot(player))
        player._id_E54CC9323D3DC44E = 1;
    }
  }

  if(_id_BE80583079EC3E95.duration != 0 && _id_BE80583079EC3E95.category != "tablet")
    thread _id_45AE11193C21E83A(_id_17953215DD7C5F9B);

  _id_0419EF70CFCBFAFE(_id_17953215DD7C5F9B, "assigned");
}

_id_2A01F2053FBDC8E4(_id_BE80583079EC3E95, team) {
  _id_E4CFB225AB81E7BC = level.teamdata[team]["taskInfo"];
  _id_17953215DD7C5F9B = spawnStruct();
  _id_17953215DD7C5F9B.info = _id_BE80583079EC3E95;
  _id_17953215DD7C5F9B.team = team;
  _id_17953215DD7C5F9B.currentvalue = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_E4CFB225AB81E7BC._id_165262BFF9D18643; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(_id_E4CFB225AB81E7BC._id_BF3BD069CCF703A8[_id_AC0E594AC96AA3A8])) {
      _id_E4CFB225AB81E7BC._id_BF3BD069CCF703A8[_id_AC0E594AC96AA3A8] = _id_17953215DD7C5F9B;
      break;
    }
  }

  _id_D0BDD994D7D8E9B9(_id_17953215DD7C5F9B, _id_BE80583079EC3E95.id);
  _id_E77AF979434B2B4D(_id_17953215DD7C5F9B, 0);
  _id_F1C522713F6662FE(_id_17953215DD7C5F9B);
  return _id_17953215DD7C5F9B;
}

_id_32139ED00E90904A(_id_17953215DD7C5F9B) {
  _id_E4CFB225AB81E7BC = level.teamdata[_id_17953215DD7C5F9B.team]["taskInfo"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_E4CFB225AB81E7BC._id_165262BFF9D18643; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_E4CFB225AB81E7BC._id_BF3BD069CCF703A8[_id_AC0E594AC96AA3A8]) && _id_E4CFB225AB81E7BC._id_BF3BD069CCF703A8[_id_AC0E594AC96AA3A8] == _id_17953215DD7C5F9B)
      return _id_AC0E594AC96AA3A8;
  }

  return -1;
}

_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, value) {
  _id_17953215DD7C5F9B.currentvalue = _id_17953215DD7C5F9B.currentvalue + value;

  if(_id_17953215DD7C5F9B.currentvalue >= _id_17953215DD7C5F9B.info.targetnum) {
    _id_C70072A3CF2BEFDF(_id_17953215DD7C5F9B);
    _id_9AAD50CBCB9B942E(_id_17953215DD7C5F9B, "success");
  } else
    _id_E77AF979434B2B4D(_id_17953215DD7C5F9B, _id_17953215DD7C5F9B.currentvalue);
}

_id_45AE11193C21E83A(_id_17953215DD7C5F9B) {
  if(!isDefined(_id_17953215DD7C5F9B)) {
    return;
  }
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");
  duration = _id_17953215DD7C5F9B.info.duration;
  endtime = gettime() + duration * 1000;
  _id_B10E35B5C472D03E = _id_32139ED00E90904A(_id_17953215DD7C5F9B) + 1;

  foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"])
  player setclientomnvar("ui_champion_br_task" + _id_B10E35B5C472D03E + "_countdown_timer", endtime);

  wait(duration);
  _id_9AAD50CBCB9B942E(_id_17953215DD7C5F9B, "timeout");
}

_id_9AAD50CBCB9B942E(_id_17953215DD7C5F9B, result) {
  _id_D0BDD994D7D8E9B9(_id_17953215DD7C5F9B, 0);
  _id_E77AF979434B2B4D(_id_17953215DD7C5F9B, 0);
  _id_F1C522713F6662FE(_id_17953215DD7C5F9B, result);
  _id_A4762296E49D5615(_id_17953215DD7C5F9B);
  _id_E4CFB225AB81E7BC = level.teamdata[_id_17953215DD7C5F9B.team]["taskInfo"];
  _id_E4CFB225AB81E7BC._id_BF3BD069CCF703A8[_id_32139ED00E90904A(_id_17953215DD7C5F9B)] = undefined;
  _id_E4CFB225AB81E7BC._id_411DF937520D264C = _id_17953215DD7C5F9B.info;
  _id_E4CFB225AB81E7BC.lastfinishtime = gettime();
  _id_E4CFB225AB81E7BC._id_E1677011E469CF5D++;
  _id_808A95CB8033C636 = 1;

  foreach(_id_B8EBE3F71A08AB40 in _id_E4CFB225AB81E7BC._id_BF3BD069CCF703A8) {
    if((issubstr(_id_B8EBE3F71A08AB40.info.ref, "kill") || issubstr(_id_B8EBE3F71A08AB40.info.ref, "down") || issubstr(_id_B8EBE3F71A08AB40.info.ref, "damage")) && _id_B8EBE3F71A08AB40.info.ref != "any_killstreak") {
      _id_808A95CB8033C636 = 0;
      break;
    }
  }

  if(_id_808A95CB8033C636) {
    foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"]) {
      if(!isbot(player) && istrue(player._id_E54CC9323D3DC44E))
        player._id_E54CC9323D3DC44E = undefined;
    }
  }

  if(isDefined(result)) {
    if(result == "success")
      _id_0419EF70CFCBFAFE(_id_17953215DD7C5F9B, "completed");
    else if(result == "timeout")
      _id_0419EF70CFCBFAFE(_id_17953215DD7C5F9B, "time_out");
  }

  _id_DC1DDF344F05F387(_id_17953215DD7C5F9B);
  _id_D306F944E9D41C98(_id_17953215DD7C5F9B.info.category, "onTaskEnd", _id_17953215DD7C5F9B);
  _id_17953215DD7C5F9B notify("task_end");
}

_id_C70072A3CF2BEFDF(_id_17953215DD7C5F9B) {
  _id_17953215DD7C5F9B._id_B35BD02B951AB0A6 = 1;
  eventref = "champion_mission_" + _id_17953215DD7C5F9B.info.ref + "_completed";

  foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"])
  player scripts\mp\utility\points::_id_0366980B6A8796AE(_func_1823FF50BB28148D(eventref));
}

_id_7FD06DBD60481367(category, _id_6B9F4C30D54F0F83) {
  _id_AC52D7E9D13E767F = level._id_E4CFB225AB81E7BC.category[category].funcs;
  return isDefined(_id_AC52D7E9D13E767F) && isDefined(_id_AC52D7E9D13E767F[_id_6B9F4C30D54F0F83]);
}

_id_AC97A4F2AB8C2D53(category, _id_6B9F4C30D54F0F83, func) {
  level._id_E4CFB225AB81E7BC.category[category].funcs[_id_6B9F4C30D54F0F83] = func;
}

_id_D306F944E9D41C98(category, _id_6B9F4C30D54F0F83, param1, param2) {
  func = level._id_E4CFB225AB81E7BC.category[category].funcs[_id_6B9F4C30D54F0F83];

  if(isDefined(func)) {
    if(isDefined(param2))
      return [[func]](param1, param2);
    else if(isDefined(param1))
      return [[func]](param1);
    else
      return [[func]]();
  }
}

_id_4B70EE1A6CCDA665(team) {
  _id_E61E2FBF2FD48FC0 = [];
  index = 1;

  foreach(player in level.teamdata[team]["players"]) {
    if(index > 4) {
      break;
    }

    if(!isDefined(player._id_46334D99742B3BF3))
      _id_E61E2FBF2FD48FC0[index] = 0;
    else {
      clientnum = player getentitynumber();
      _id_B10E35B5C472D03E = _id_32139ED00E90904A(player._id_46334D99742B3BF3) + 1;
      value = clientnum;
      value = value << 4 | _id_B10E35B5C472D03E;
      _id_E61E2FBF2FD48FC0[index] = value;
    }

    index++;
  }

  return _id_E61E2FBF2FD48FC0;
}

_id_5CE6AB0B7DA3E97D(team) {
  _id_E61E2FBF2FD48FC0 = _id_4B70EE1A6CCDA665(team);

  foreach(player in level.teamdata[team]["players"]) {
    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 4; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_E61E2FBF2FD48FC0[_id_AC0E594AC96AA3A8])) {
        name = "ui_champion_player" + _id_AC0E594AC96AA3A8 + "_currentTask";
        player setclientomnvar(name, _id_E61E2FBF2FD48FC0[_id_AC0E594AC96AA3A8]);
      }
    }
  }
}

_id_A4762296E49D5615(_id_17953215DD7C5F9B) {
  players = level.teamdata[_id_17953215DD7C5F9B.team]["players"];

  foreach(player in players) {
    if(isDefined(player._id_46334D99742B3BF3) && player._id_46334D99742B3BF3 == _id_17953215DD7C5F9B)
      player._id_46334D99742B3BF3 = undefined;
  }

  _id_5CE6AB0B7DA3E97D(_id_17953215DD7C5F9B.team);
}

_id_D0BDD994D7D8E9B9(_id_17953215DD7C5F9B, taskid) {
  _id_B10E35B5C472D03E = _id_32139ED00E90904A(_id_17953215DD7C5F9B) + 1;

  if(_id_B10E35B5C472D03E <= 0) {
    return;
  }
  omnvar = "ui_champion_br_task" + _id_B10E35B5C472D03E + "_id";

  foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"])
  player setclientomnvar(omnvar, taskid);
}

_id_E77AF979434B2B4D(_id_17953215DD7C5F9B, _id_FF65E066242C67B1) {
  _id_B10E35B5C472D03E = _id_32139ED00E90904A(_id_17953215DD7C5F9B) + 1;

  if(_id_B10E35B5C472D03E <= 0) {
    return;
  }
  omnvar = "ui_champion_br_task" + _id_B10E35B5C472D03E + "_value";

  foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"])
  player setclientomnvar(omnvar, _id_FF65E066242C67B1);
}

_id_F1C522713F6662FE(_id_17953215DD7C5F9B, status) {
  _id_B10E35B5C472D03E = _id_32139ED00E90904A(_id_17953215DD7C5F9B) + 1;

  if(_id_B10E35B5C472D03E <= 0) {
    return;
  }
  omnvar = "ui_champion_br_task" + _id_B10E35B5C472D03E + "_status";
  value = -1;

  if(isDefined(status)) {
    if(status == "timeout")
      value = 0;
    else if(status == "success")
      value = 1;
  }

  foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"])
  player setclientomnvar(omnvar, value);
}

_id_0419EF70CFCBFAFE(_id_17953215DD7C5F9B, category) {
  if(!isDefined(_id_17953215DD7C5F9B)) {
    return;
  }
  _id_F7B6CC6C062A7A43 = "br_champion_task_" + _id_17953215DD7C5F9B.info.ref + "_" + category;
  _id_83AFA1BB13298AC7 = scripts\mp\hud_message::_id_73BAF095C3B9CCE6(_id_F7B6CC6C062A7A43);

  if(!isDefined(_id_83AFA1BB13298AC7) || _id_83AFA1BB13298AC7 < 0)
    _id_F7B6CC6C062A7A43 = "br_champion_generic_task_" + category;

  foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"])
  player thread scripts\mp\hud_message::showsplash(_id_F7B6CC6C062A7A43);
}

_id_FAF2C6A1A5A7AA93(_id_7148C1A6F25491F8, value) {
  if(_id_7148C1A6F25491F8 != "champion_task_selected") {
    return;
  }
  _id_BF3BD069CCF703A8 = level.teamdata[self.team]["taskInfo"]._id_BF3BD069CCF703A8;
  _id_17953215DD7C5F9B = _id_BF3BD069CCF703A8[value - 1];
  self._id_46334D99742B3BF3 = _id_17953215DD7C5F9B;
  _id_5CE6AB0B7DA3E97D(self.team);
  _id_8FD21242A694AA72(_id_17953215DD7C5F9B);

  foreach(_id_B8EBE3F71A08AB40 in _id_BF3BD069CCF703A8) {
    selected = _id_17953215DD7C5F9B == _id_B8EBE3F71A08AB40;
    _id_D306F944E9D41C98(_id_B8EBE3F71A08AB40.info.category, "onPlayerSelectTask", _id_B8EBE3F71A08AB40, selected);
  }
}

_id_2E55101FFD0D483C(_id_17953215DD7C5F9B, items, _id_B10249C96F1B8DEA, _id_7E10E952A53C915F, _id_70696E1B9F55CBF7) {
  _id_0441C690181A13AC = undefined;
  target = undefined;

  foreach(item in items) {
    isvalid = [[_id_B10249C96F1B8DEA]](_id_17953215DD7C5F9B, item);

    if(isvalid) {
      _id_4EB801042B324702 = distance2dsquared(item.origin, self.origin);

      if(!isDefined(_id_0441C690181A13AC) || _id_4EB801042B324702 < _id_0441C690181A13AC) {
        target = item;
        _id_0441C690181A13AC = _id_4EB801042B324702;
      }
    }
  }

  _id_709285B860CAFF8D(target, _id_17953215DD7C5F9B, _id_7E10E952A53C915F, _id_70696E1B9F55CBF7);
}

_id_709285B860CAFF8D(target, _id_17953215DD7C5F9B, _id_7E10E952A53C915F, _id_70696E1B9F55CBF7) {
  if(!isDefined(target)) {
    return;
  }
  if(!isDefined(_id_7E10E952A53C915F))
    _id_7E10E952A53C915F = 40;

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objectiveiconid != -1) {
    _id_B8ABADD2C4D56FD8 = spawnStruct();
    _id_B8ABADD2C4D56FD8.objectiveiconid = objectiveiconid;
    _id_B8ABADD2C4D56FD8.item = target;
    _id_B8ABADD2C4D56FD8._id_17953215DD7C5F9B = _id_17953215DD7C5F9B;
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "current", target.origin, _id_17953215DD7C5F9B.info.objectiveicon);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_outro(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 0);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objectiveiconid, _id_7E10E952A53C915F);

    if(istrue(_id_70696E1B9F55CBF7) && isent(target))
      scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, target);

    objective_setlabel(objectiveiconid, _id_17953215DD7C5F9B.info._id_C89DC5A2CAA0D945);
    objective_showtoplayersinmask(objectiveiconid);
    objective_addclienttomask(objectiveiconid, self);
    self._id_B8ABADD2C4D56FD8 = _id_B8ABADD2C4D56FD8;
  }
}

_id_F817ADD79E895736(pickupent) {
  if(!isDefined(pickupent.instance)) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player._id_B8ABADD2C4D56FD8) && player._id_B8ABADD2C4D56FD8.item == pickupent.instance) {
      player._id_AD30CE892002A2B2 = pickupent.instance;
      player _id_8FD21242A694AA72();
      player._id_AD30CE892002A2B2 = undefined;
    }
  }
}

_id_AFE6658CFFE7D1A8() {
  if(!isDefined(self._id_B8ABADD2C4D56FD8)) {
    return;
  }
  _id_17953215DD7C5F9B = self._id_B8ABADD2C4D56FD8._id_17953215DD7C5F9B;

  if(_id_7FD06DBD60481367(_id_17953215DD7C5F9B.info.category, "removeObjectiveInfo"))
    _id_D306F944E9D41C98(_id_17953215DD7C5F9B.info.category, "removeObjectiveInfo");
  else {
    self._id_B8ABADD2C4D56FD8 notify("objective_removed");
    self._id_B8ABADD2C4D56FD8.item scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

    if(isDefined(self._id_B8ABADD2C4D56FD8.objectiveiconid))
      self._id_B8ABADD2C4D56FD8 _id_3ACF1C0EBAF602F2::deletequestobjicon();

    self._id_B8ABADD2C4D56FD8 = undefined;
  }
}

_id_DC1DDF344F05F387(_id_17953215DD7C5F9B) {
  players = level.teamdata[_id_17953215DD7C5F9B.team]["players"];

  foreach(player in players) {
    if(isDefined(player._id_B8ABADD2C4D56FD8) && player._id_B8ABADD2C4D56FD8._id_17953215DD7C5F9B == _id_17953215DD7C5F9B)
      player _id_AFE6658CFFE7D1A8();
  }
}

_id_8FD21242A694AA72(_id_17953215DD7C5F9B) {
  if(!isDefined(_id_17953215DD7C5F9B) && isDefined(self._id_B8ABADD2C4D56FD8))
    _id_17953215DD7C5F9B = self._id_B8ABADD2C4D56FD8._id_17953215DD7C5F9B;

  _id_AFE6658CFFE7D1A8();

  if(isDefined(_id_17953215DD7C5F9B))
    _id_D306F944E9D41C98(_id_17953215DD7C5F9B.info.category, "tryBindObjective", _id_17953215DD7C5F9B);
}