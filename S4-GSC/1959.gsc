/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1959.gsc
*************************************************/

init() {
  _id_0CB2();
  level._id_0E59 = [];
  _id_C23A("mostMultiKills", undefined, ::_id_7588, ["totalMultikills"], 3);
  _id_C23A("mostFinishingMoves", undefined, ::_id_7588, ["executions"], 3);
  _id_C23A("mostMeleeKills", undefined, ::_id_7588, ["meleeKills"], 5);
  _id_C23A("mostExplosiveEliminations", undefined, ::_id_7588, ["explosiveKills"], 7);
  _id_C23A("mostHeadshotKills", undefined, ::_id_7588, ["headshots"], 7);
  _id_C23A("mostKillstreaksDestroyed", undefined, ::_id_7588, ["destroyedKillstreaks"], 5);
  _id_C23A("mostKillstreaksCalledIn", undefined, ::_id_7588, ["killstreaksUsed"], 7);
  _id_C23A("mostCaptures", undefined, ::_id_7588, ["captures"], 3);
  _id_C23A("highestEDRatio", undefined, ::hashighestkdr, undefined, 1);
  _id_C23A("mostDefends", undefined, ::_id_7588, ["defends"], 5);
  _id_C23A("mostEliminations", undefined, ::_id_7588, ["kills", "assists"], 15);
  _id_C23A("highestScore", undefined, ::hasfirstplacescore, undefined, 0);
  _id_C23A("mostTimeNearEnemies", undefined, ::_id_7588, ["timeNearEnemies"], 0);
  _id_C23A("mostTimeNearAllies", undefined, ::_id_7588, ["timeNearAllies"], 0);
  _id_C23A("secondHighestScore", undefined, ::_id_75AC, undefined, 0);
  _id_C23A("thirdHighestScore", undefined, ::_id_75BC, undefined, 0);
  _id_C23A("tagsCaptured", undefined, ::_id_7588, ["confirmed"], 3);
  _id_C23A("tagsDenied", undefined, ::_id_7588, ["denied"], 3);
  _id_C23A("timeOnPoint", undefined, ::_id_7588, ["objTime"], 30);
  _id_C23A("bombPlanted", undefined, ::_id_7588, ["plants"], 1);
  _id_C23A("bombDefused", undefined, ::_id_7588, ["defuses"], 1);
}

_id_C23A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility\game::getgametype();
  var_6 = 2;

  switch (var_5) {
    case "war":
      var_6 = 8;
      break;
    case "dom":
      var_6 = 9;
      break;
    case "conf":
      var_6 = 10;
      break;
    case "koth":
    case "patrol":
      var_6 = 11;
      break;
    case "sd":
      var_6 = 12;
      break;
    default:
      break;
  }

  var_7 = spawnStruct();
  var_7._id_7C8C = int(_func_0222("mp/accoladestable.csv", 1, var_0, 0));
  var_7._id_0E5A = int(_func_0222("mp/accoladestable.csv", 1, var_0, var_6));
  var_7._id_4361 = var_3;
  var_7._id_5672 = var_2;
  var_7._id_10E5A = [];
  var_7._id_10E60 = 0;
  var_7.minimumval = var_4;
  var_7.isactive = !isDefined(var_1) || [[var_1]]();
  level._id_0E59[var_0] = var_7;
}

_id_19C4() {
  foreach(var_5, var_1 in level._id_0E59) {
    self setplayerdata(level.progressiongroup, "playerStats", "matchAccolades", var_5, 0);

    if(!isDefined(var_1._id_4361)) {
      continue;
    }
    foreach(var_3 in var_1._id_4361) {
      scripts\mp\utility\stats::_id_8257(var_3);
    }
  }
}

_id_10FC1(var_0, var_1) {
  var_2 = var_0 getplayerdata(level.progressiongroup, "playerStats", "accoladeStats", var_1);
  var_0 setplayerdata(level.progressiongroup, "playerStats", "accoladeStats", var_1, var_2 + 1);
  var_0 setplayerdata(level.progressiongroup, "playerStats", "matchAccolades", var_1, 1);
}

_id_566B() {
  foreach(var_1 in level.players) {
    var_1._id_9BA7 = [];
  }

  foreach(var_8, var_4 in level._id_0E59) {
    if(!var_4.isactive) {
      continue;
    }
    foreach(var_6 in level._id_EF89) {
      level _id_566A(var_8, var_6);
    }
  }
}

_id_F342(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = level._id_EF6A[var_0]["players"];

  if(scripts\mp\utility\game::getgametype() == "arena_evo") {
    if(scripts\mp\gametypes\arena_evo_tourney_util::_id_86E2(var_0)) {
      return [];
    }
  }

  foreach(var_6 in var_4) {
    var_2[var_6.guid] = 0;
    var_3[var_6.guid] = var_6;

    if(isDefined(var_6._id_9BA7) && var_6._id_9BA7.size > 0) {
      foreach(var_8 in var_6._id_9BA7) {
        var_2[var_6.guid] = var_2[var_6.guid] + level._id_0E59[var_8._id_C189]._id_0E5A;
      }
    }
  }

  var_11 = _func_0426(var_2, "down");

  foreach(var_13 in var_11) {
    var_6 = var_3[var_13];
    var_14 = isDefined(var_6._id_9BA7) && var_6._id_9BA7.size > 0;

    if(var_14 && var_1.size < 3 && !_id_081E::skipplayerbotfinalkillcam(var_6)) {
      var_1[var_1.size] = var_6;
    }
  }

  return var_1;
}

_id_0B9C() {
  foreach(var_1 in level.players) {
    for(var_2 = 0; var_2 < 3; var_2++) {
      var_1 setclientomnvar("ui_wc_winner_" + var_2, -1);

      for(var_3 = 0; var_3 < 1; var_3++) {
        var_1 setclientomnvar("ui_wc_accolade_" + var_2 + "_" + var_3, -1);
        var_1 setclientomnvar("ui_wc_accolade_player_" + var_3, -1);
        var_1 setclientomnvar("ui_wc_accolade_score_" + var_2 + "_" + var_3, -1);
      }
    }
  }
}

_id_0B42() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_9BA7)) {
      for(var_2 = 0; var_2 < min(1, var_1._id_9BA7.size); var_2++) {
        var_3 = level._id_0E59[var_1._id_9BA7[var_2]._id_C189]._id_7C8C;
        var_1 setclientomnvar("ui_wc_accolade_player_" + var_2, var_3);
      }
    }
  }
}

_id_A6AE(var_0) {
  _id_0B9C();

  foreach(var_2 in level._id_EF89) {
    var_3 = level._id_EF6A[var_2]["players"];

    foreach(var_5 in var_3) {
      for(var_6 = 0; var_6 < min(3, var_0.size); var_6++) {
        var_7 = var_0[var_6];
        var_5 setclientomnvar("ui_wc_winner_" + var_6, var_7 getentitynumber());
      }
    }
  }
}

_id_A6AD() {
  _id_0B9C();
  _id_0B42();
  level._id_10E5B = [];

  foreach(var_1 in level._id_EF89) {
    var_2 = _id_F342(var_1);
    var_3 = 0;
    var_4 = level._id_EF6A[var_1]["players"];

    foreach(var_6 in var_4) {
      for(var_7 = 0; var_7 < min(3, var_2.size); var_7++) {
        var_8 = var_2[var_7];
        var_6 setclientomnvar("ui_wc_winner_" + var_7, var_8 getentitynumber());
        var_8._id_9BA7 = scripts\engine\utility::_id_1BD6(var_8._id_9BA7, ::sortaccoladesbypriority);

        for(var_9 = 0; var_9 < min(1, var_8._id_9BA7.size); var_9++) {
          var_3 = var_3 + 1;
          var_10 = level._id_0E59[var_8._id_9BA7[var_9]._id_C189]._id_7C8C;
          var_6 setclientomnvar("ui_wc_accolade_" + var_7 + "_" + var_9, var_10);
          var_6 setclientomnvar("ui_wc_accolade_score_" + var_7 + "_" + var_9, var_8._id_9BA7[var_9]._id_04CB);
        }
      }
    }

    level._id_10E5B[var_1] = var_3;
  }
}

sortaccoladesbypriority(var_0, var_1) {
  return var_0._id_BD27 > var_1._id_BD27;
}

_id_6591() {
  return 3;
}

_id_81ED() {
  level._id_10E5C = [];

  foreach(var_1 in level._id_EF89) {
    var_2 = [];

    for(var_3 = 0; var_3 < 9; var_3++) {
      var_2[var_3] = 0;
    }

    level._id_10E5C[var_1] = var_2;
  }

  foreach(var_6 in level.players) {
    var_6._id_10E5C = [];

    for(var_3 = 0; var_3 < 9; var_3++) {
      var_6._id_10E5C[var_3] = 0;
      var_6 _meth_82F8("ui_wc_vote_bits", var_3, 0);
      var_6 setclientomnvar("ui_wc_votes_" + var_3, 0);
    }
  }
}

_id_0CB2() {
  level _id_000F::_id_990C("winners_circle_vote", ::_id_0C89);
  level _id_000F::_id_990C("winners_circle_mode", ::_id_0C88);
}

_id_0C42(var_0, var_1) {
  return var_1 >= 0 && var_1 < level._id_10E5B[var_0];
}

_id_0C89(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  waittillframeend;
  var_2 = var_1.pers["team"];

  if(!isDefined(var_2)) {
    return;
  }
  if(!_id_0C42(var_2, var_0)) {
    return;
  }
  if(var_1._id_10E5C[var_0]) {
    return;
  }
  var_3 = 0;

  for(var_4 = 0; var_4 < 9; var_4++) {
    if(var_1._id_10E5C[var_4]) {
      var_3 = var_3 + 1;
    }
  }

  if(var_3 >= 1) {
    return;
  }
  var_1._id_10E5C[var_0] = 1;
  level._id_10E5C[var_2][var_0] = level._id_10E5C[var_2][var_0] + 1;
  var_5 = level._id_10E5C[var_2][var_0];
  var_6 = var_1 _meth_876E("ui_wc_accolade_" + var_0 + "_0");
  var_7 = undefined;

  foreach(var_10, var_9 in level._id_0E59) {
    if(var_6 == var_9._id_7C8C) {
      var_7 = var_10;
      break;
    }
  }

  var_1 _meth_870F("dlog_event_gamemp_mvp_vote", ["accolade_ref", var_7]);

  if(!isDefined(var_1.gainedxpfromaccoladevoting)) {
    var_1.gainedxpfromaccoladevoting = 1;
    var_1 thread scripts\mp\rank::giverankxp("accolade_vote", scripts\mp\rank::getscoreinfovalue("accolade_vote"));
  }

  var_1 _meth_82F8("ui_wc_vote_bits", var_0, 1);
  var_11 = level._id_EF6A[var_2]["players"];

  foreach(var_13 in var_11) {
    var_13 setclientomnvar("ui_wc_votes_" + var_0, var_5);
  }
}

_id_0C88(var_0) {
  var_1 = self;

  if(var_0 == 0) {
    _id_0828::_id_DC61(var_1);
  } else if(var_0 == 1) {
    _id_0828::_id_DC5D(var_1);
  } else if(var_0 == 2) {
    return;
  }
}

_id_566A(var_0, var_1) {
  [[level._id_0E59[var_0]._id_5672]](var_0, var_1);
}

_id_F3F0(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!(var_2 >= level._id_0E59[var_0].minimumval)) {
    return;
  }
  foreach(var_4 in level._id_0E59[var_0]._id_10E5A) {
    if(scripts\engine\utility::is_equal(var_1.pers["team"], var_4.pers["team"])) {
      return;
    }
  }

  level thread track_accolade_win_stats(var_1, var_0);
  level._id_0E59[var_0]._id_10E5A[level._id_0E59[var_0]._id_10E5A.size] = var_1;
  level._id_0E59[var_0]._id_10E60 = var_2;

  if(!isDefined(var_1._id_9BA7)) {
    var_1._id_9BA7 = [];
  }

  var_6 = spawnStruct();
  var_6._id_04CB = var_2;
  var_6._id_C189 = var_0;
  var_6._id_BD27 = level._id_0E59[var_0]._id_0E5A;
  var_1._id_9BA7[var_1._id_9BA7.size] = var_6;
}

track_accolade_win_stats(var_0, var_1) {
  if(istrue(level.challengesallowed)) {
    _id_10FC1(var_0, var_1);
  }

  var_0 _meth_870F("dlog_event_gamemp_accolade_awarded", ["accolade_ref", var_1]);
}

_id_75BC(var_0, var_1) {
  return hasplacementscore(3, var_0, var_1);
}

_id_75AC(var_0, var_1) {
  return hasplacementscore(2, var_0, var_1);
}

hasfirstplacescore(var_0, var_1) {
  return hasplacementscore(1, var_0, var_1);
}

hasplacementscore(var_0, var_1, var_2) {
  if(!isDefined(level._id_B793) || !isDefined(level._id_B793[var_2])) {
    _id_B7DA();
  }

  if(level._id_B793[var_2].size < var_0) {
    return;
  }
  var_3 = level._id_B793[var_2][var_0 - 1];
  var_4 = var_3._id_B760;
  var_5 = var_3._id_04CB;
  _id_F3F0(var_1, var_4, var_5);
  return 1;
}

hashighestkdr(var_0, var_1) {
  var_2 = playerssortbyreforfunc(var_0, ::get_kda);
  var_3 = var_2[var_1][0];
  level.kdr_info = var_2;

  if(!isDefined(var_3)) {
    return;
  }
  if(var_3._id_04CB > 0) {
    _id_F3F0(var_0, var_3._id_B760, var_3._id_04CB);
  }
}

playerssortbyreforfunc(var_0, var_1) {
  if(_func_03AC(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }

  var_3 = [];
  var_4 = [];

  foreach(var_6 in level._id_EF89) {
    var_7 = level._id_EF6A[var_6]["players"];
    var_8 = [];

    foreach(var_10 in var_7) {
      var_11 = spawnStruct();
      var_11._id_B760 = var_10;
      var_11._id_04CB = [[var_2]](var_10);
      var_8[var_8.size] = var_11;
    }

    var_8 = scripts\engine\utility::_id_1BD6(var_8, ::is_player1_higher_scoring);
    var_4[var_6] = var_8;
  }

  return var_4;
}

get_kda(var_0) {
  var_1 = scripts\engine\utility::ter_op(var_0.pers["deaths"] > 0, var_0.pers["deaths"], 1);
  var_2 = var_0.pers["kills"] + var_0.pers["assists"];
  return var_2 / var_1;
}

is_player1_higher_scoring(var_0, var_1) {
  return var_1._id_04CB < var_0._id_04CB;
}

_id_7588(var_0, var_1) {
  var_2 = undefined;
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5.pers["team"] != var_1) {
      continue;
    }
    var_6 = 0;

    foreach(var_8 in level._id_0E59[var_0]._id_4361) {
      var_6 = var_6 + var_5.pers[var_8];
    }

    if(var_6 == 0) {
      continue;
    }
    if(!isDefined(var_2) || var_6 > var_2) {
      var_2 = var_6;
      var_3 = [];
      var_3[var_3.size] = var_5;
      continue;
    }

    if(var_6 == var_2) {
      var_3[var_3.size] = var_5;
    }
  }

  foreach(var_5 in var_3) {
    _id_F3F0(var_0, var_5, var_2);
  }
}

_id_75AB(var_0, var_1) {
  if(!isDefined(level._id_B727) || !isDefined(level._id_B727[var_1])) {
    _id_B7D9();
  }

  if(level._id_B727[var_1].size < 2) {
    return;
  }
  _id_F3F0(var_0, level._id_B727[var_1][1]._id_B760, level._id_B727[var_1][1]._id_04CB);
}

_id_7563(var_0, var_1) {
  if(!isDefined(level._id_B727) || !isDefined(level._id_B727[var_1])) {
    _id_B7D9();
  }

  if(level._id_B727[var_1].size < 1) {
    return;
  }
  _id_F3F0(var_0, level._id_B727[var_1][0]._id_B760, level._id_B727[var_1][0]._id_04CB);
}

_id_7586(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4.pers["team"] != var_1) {
      continue;
    }
    var_5 = scripts\engine\utility::ter_op(isDefined(var_4._id_9BA7), var_4._id_9BA7.size, 0);

    if(var_5 >= 3) {
      _id_F3F0(var_0, var_4, var_5);
    }
  }
}

_id_B7DA() {
  level._id_B793 = [];

  foreach(var_1 in level._id_EF89) {
    var_2 = [];

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3].pers["team"] != var_1) {
        continue;
      }
      var_4 = spawnStruct();
      var_4._id_B760 = level.players[var_3];
      var_4._id_04CB = level.players[var_3].pers["score"];
      var_2[var_2.size] = var_4;
    }

    level._id_B793[var_1] = _id_E03A(var_2);
  }
}

_id_E03A(var_0) {
  for(var_1 = 1; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    for(var_3 = var_1 - 1; var_3 >= 0 && var_0[var_3]._id_04CB < var_2._id_04CB; var_3--) {
      var_0[var_3 + 1] = var_0[var_3];
    }

    var_0[var_3 + 1] = var_2;
  }

  return var_0;
}

_id_B7D9() {
  var_0 = ["defends", "assaults", "captures", "returns", "plants", "defuses", "confirmed", "denied", "objTime"];
  level._id_B727 = [];

  foreach(var_2 in level.players) {
    var_3 = 0;

    foreach(var_5 in var_0) {
      if(isDefined(var_2.pers[var_5])) {
        var_3 = var_3 + var_2.pers[var_5];
      }
    }

    var_2.pers["totalObjScore"] = var_3;
  }

  foreach(var_9 in level._id_EF89) {
    var_10 = [];

    for(var_11 = 0; var_11 < level.players.size; var_11++) {
      if(level.players[var_11].pers["team"] != var_9) {
        continue;
      }
      var_12 = spawnStruct();
      var_12._id_B760 = level.players[var_11];
      var_12._id_04CB = level.players[var_11].pers["totalObjScore"];
      var_10[var_10.size] = var_12;
    }

    level._id_B727[var_9] = _id_E03A(var_10);
  }
}

_id_1A58() {
  return istrue(level.killcam);
}

_id_8953() {
  return !scripts\mp\utility\game::_id_CA4B();
}

_id_87B0() {
  _id_07D1::_id_60C2("infil_setup_complete");
  return scripts\mp\utility\game::_id_159D();
}

_id_890C() {
  return istrue(level._id_A790);
}

_id_8A04() {
  return istrue(level._id_A797);
}

_id_87C4() {
  return scripts\mp\utility\game::getgametype() != "br";
}

_id_1A59() {
  return istrue(level._id_15BD);
}

_id_1A55() {
  return istrue(level._id_15D8);
}

_id_8959() {
  return scripts\mp\utility\game::getgametype() != "war" && scripts\mp\utility\game::getgametype() != "dm" && scripts\mp\utility\game::getgametype() != "br";
}

_id_8784() {
  return _id_07D6::_id_8785();
}

_id_87A6() {
  if(_id_07D6::_id_8785()) {
    return 1;
  }

  switch (scripts\mp\utility\game::getgametype()) {
    case "ctf":
      return 1;
  }

  return 0;
}

_id_87A2() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "grnd":
    case "grind":
    case "mendota":
    case "kspoint":
    case "hq":
    case "koth":
    case "arena_evo":
    case "arena":
    case "siege":
    case "dom":
    case "base":
    case "arm":
      return 1;
  }

  return 0;
}

_id_87DE() {
  return scripts\mp\utility\game::getgametype() == "ctf";
}

_id_8A49() {
  return istrue(level._id_FECE);
}

_id_1B0D() {
  return istrue(level._id_4CE9);
}

_id_8882() {
  return scripts\mp\utility\game::getgametype() == "grind";
}

_id_88C1() {
  return scripts\mp\utility\game::getgametype() == "infect";
}

_id_8886() {
  return scripts\mp\utility\game::getgametype() == "gun";
}

_id_888F() {
  return scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd" || scripts\mp\utility\game::getgametype() == "kspoint";
}

_id_1B0F() {
  return getdvarint("#x3472b950714ddf102", 0) == 1;
}