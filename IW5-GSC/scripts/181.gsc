/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\181.gsc
**************************************/

main() {
  var_0 = [];
  var_0 = _id_1976("THE_BEST_OF_THE_BEST");
  var_0 _id_1979("sp_intro", 0, "BACK_IN_THE_FIGHT", 1, "THE_BIG_APPLE", 0.1);
  var_0 _id_1979("sp_ny_manhattan", 0, "TOO_BIG_TO_FAIL", 1, "THE_BIG_APPLE", undefined);
  var_0 _id_1979("sp_ny_harbor", 0, "WET_WORK", 1, "THE_BIG_APPLE", undefined);
  var_0 _id_1979("sp_intro", 0, "CARPE_DIEM", 1, "OUT_OF_THE_FRYING_PAN", undefined);
  var_0 _id_1979("hijack", 0, "FREQUENT_FLIER", 1, "OUT_OF_THE_FRYING_PAN", undefined);
  var_0 _id_1979("sp_warlord", 0, "UP_TO_NO_GOOD", 1, "OUT_OF_THE_FRYING_PAN", undefined);
  var_0 _id_1979("london", 1, undefined, 1, "EUROPEAN_VACATION", 1);
  var_0 _id_1979("innocent", 0, "ONE_WAY_TICKET", 1, "EUROPEAN_VACATION", 0.1);
  var_0 _id_1979("hamburg", 0, "WELCOME_TO_WW3", 1, "EUROPEAN_VACATION", undefined);
  var_0 _id_1979("sp_payback", 0, "SANDSTORM", 1, "EUROPEAN_VACATION", undefined);
  var_0 _id_1979("sp_paris_a", 1, undefined, 1, "CITY_OF_LIGHTS", undefined);
  var_0 _id_1979("sp_paris_b", 0, "BACK_SEAT_DRIVER", 1, "CITY_OF_LIGHTS", undefined);
  var_0 _id_1979("paris_ac130", 0, "WELL_ALWAYS_HAVE_PARIS", 1, "CITY_OF_LIGHTS", undefined);
  var_0 _id_1979("sp_prague", 0, "VIVE_LA_REVOLUTION", 1, "THE_DARKEST_HOUR", undefined);
  var_0 _id_1979("prague_escape", 0, "REQUIEM", 1, "THE_DARKEST_HOUR", undefined);
  var_0 _id_1979("castle", 0, "STORM_THE_CASTLE", 1, "THE_DARKEST_HOUR", undefined);
  var_0 _id_1979("sp_berlin", 0, "BAD_FIRST_DATE", 1, "THIS_IS_THE_END", undefined);
  var_0 _id_1979("rescue_2", 0, "DIAMOND_IN_THE_ROUGH", 1, "THIS_IS_THE_END", undefined);
  var_0 _id_1979("sp_dubai", 0, "WHO_DARES_WINS", 1, "THIS_IS_THE_END", undefined);

  if(maps\_utility::_id_0A36()) {
    level._id_1952 = [];

    for(var_1 = 0; var_1 < 100; var_1++) {
      var_2 = tablelookup("sp/specopstable.csv", 0, var_1, 1);

      if(var_2 != "") {
        _id_1955(var_2);
        continue;
      }

      break;
    }

    var_3 = _id_1976("SPECIAL_OPS");
    var_4 = int(tablelookup("sp/specopstable.csv", 0, "survival_count", 1));

    for(var_1 = 100; var_1 < 200; var_1++) {
      var_5 = var_1 - 100;
      var_2 = tablelookup("sp/specopstable.csv", 0, var_1, 1);

      if(var_2 != "") {
        var_3 _id_197E(var_2, var_5);
        continue;
      }

      break;
    }

    for(var_1 = 200; var_1 < 300; var_1++) {
      var_5 = var_1 - 200 + var_4;
      var_2 = tablelookup("sp/specopstable.csv", 0, var_1, 1);

      if(var_2 != "") {
        var_3 _id_197E(var_2, var_5);
        continue;
      }

      break;
    }

    level._id_1889 = var_3;
  }

  level._id_1953 = var_0;
}

_id_1954() {
  wait 10;

  while(getdvarint("test_next_mission") < 1) {
    wait 3;
  }
  _id_1956();
}

_id_1955(var_0) {
  level._id_1952[var_0] = spawnStruct();
  level._id_1952[var_0]._id_160B = var_0;
  level._id_1952[var_0].unlock = int(tablelookup("sp/specopstable.csv", 1, var_0, 5));
}

_id_1956() {
  if(maps\_utility::_id_1957()) {
    setsaveddvar("ui_nextMission", "0");

    if(isDefined(level._id_1958)) {
      changelevel("", 0, level._id_1958);
    } else {
      changelevel("", 0);
    }
  } else {
    level notify("nextmission");
    level._id_195A = 1;
    level.player enableinvulnerability();
    var_0 = undefined;
    setsaveddvar("ui_nextMission", "1");
    setDvar("ui_showPopup", "0");
    setDvar("ui_popupString", "");
    setDvar("ui_prev_map", level.script);

    if(level.script == "london") {
      game["previous_map"] = "london";
    } else {
      game["previous_map"] = undefined;
    }
    var_0 = level._id_1953 _id_188A(level.script);

    if(level.script == "sp_intro" && !getdvarint("prologue_select")) {
      for(var_1 = var_0 + 1; var_1 < level._id_1953._id_190C.size - 1; var_1++) {
        if(level._id_1953._id_190C[var_1].name == "sp_intro") {
          var_0 = var_1;
          break;
        }
      }
    }

    setDvar("prologue_select", "0");
    maps\_gameskill::_id_195B("aa_main_" + level.script);

    if(!isDefined(var_0)) {
      missionsuccess(level.script);
      return;
    }

    if(level.script != "sp_dubai") {
      maps\_utility::_id_195C();
    }
    level._id_1953 _id_1970(var_0);

    if(level.player getlocalplayerprofiledata("highestMission") < var_0 + 1 && level.script == "sp_dubai" && getdvarint("mis_cheat") == 0) {
      setDvar("ui_sp_unlock", "0");
      setDvar("ui_sp_unlock", "1");
    }

    var_2 = _id_195E();
    updategamerprofile();

    if(level._id_1953 _id_1987(var_0)) {
      maps\_utility::_id_195D(level._id_1953 _id_1983(var_0));
    }
    if(level._id_1953 _id_1986(var_0) && _id_1966(var_0) == 4 && level._id_1953 _id_1988(var_0)) {
      maps\_utility::_id_195D(level._id_1953 _id_1984(var_0));
    }
    if(level._id_1953 _id_198A() && level._id_1953 _id_1975() > 2) {
      maps\_utility::_id_195D(level._id_1953 _id_1989());
    }
    if(level.script == "sp_dubai") {
      return;
    }
    var_3 = var_0 + 1;

    if(maps\_utility::_id_09D4()) {
      if(!getdvarint("arcademode_full")) {
        setsaveddvar("ui_nextMission", "0");
        missionsuccess(level.script);
        return;
      }
    }

    if(level._id_1953 _id_197C(var_0)) {
      if(isDefined(level._id_1953 _id_1985(var_0))) {
        changelevel(level._id_1953 _id_1981(var_3), level._id_1953 _id_1982(var_0), level._id_1953 _id_1985(var_0));
        return;
      }

      changelevel(level._id_1953 _id_1981(var_3), level._id_1953 _id_1982(var_0));
      return;
      return;
    }

    missionsuccess(level._id_1953 _id_1981(var_3), level._id_1953 _id_1982(var_0));
  }
}

_id_195E() {
  var_0 = int(_id_195F() * 100);

  if(getdvarint("mis_cheat") == 0) {
    level.player setlocalplayerprofiledata("percentCompleteSP", var_0);
  }
  return var_0;
}

_id_195F() {
  var_0 = max(_id_1961(), _id_1962());
  var_1 = 0.5;
  var_2 = _id_1963();
  var_3 = 0.25;
  var_4 = _id_1964();
  var_5 = 0.1;
  var_6 = _id_1965();
  var_7 = 0.15;
  var_8 = 0.0;
  var_8 = var_8 + var_1 * var_0;
  var_8 = var_8 + var_3 * var_2;
  var_8 = var_8 + var_5 * var_4;
  var_8 = var_8 + var_7 * var_6;
  return var_8;
}

_id_1960(var_0) {
  var_1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_2 = 0;
  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < level._id_1953._id_190C.size - 1; var_5++) {
    if(int(var_1[var_5]) >= var_0) {
      var_2++;
    }
  }

  var_6 = var_2 / (level._id_1953._id_190C.size - 1) * 100;
  return var_6;
}

_id_1961() {
  var_0 = 1;
  return _id_1960(var_0);
}

_id_1962() {
  var_0 = 2;
  return _id_1960(var_0);
}

_id_1963() {
  var_0 = 3;
  return _id_1960(var_0);
}

_id_1964() {
  var_0 = 4;
  return _id_1960(var_0);
}

_id_1965() {
  var_0 = 45;
  var_1 = level.player getlocalplayerprofiledata("cheatPoints") / var_0 * 100;
  return var_1;
}

_id_1966(var_0) {
  return int(level.player getlocalplayerprofiledata("missionHighestDifficulty")[var_0]);
}

_id_1967(var_0) {
  return int(level.player getlocalplayerprofiledata("missionSOHighestDifficulty")[var_0]);
}

_id_1913(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_190E) && var_2._id_190E) {
      continue;
    }
    var_3 = var_2 getlocalplayerprofiledata("missionSOHighestDifficulty");

    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_2._id_1968)) {
      continue;
    }
    var_4 = 0;

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_4 = var_4 + max(0, int(var_3[var_5]) - 1);
    }
    if(var_3.size == 0) {
      var_3 = "00000000000000000000000000000000000000000000000000";
    }
    while(var_0 >= var_3.size) {
      var_3 = var_3 + "0";
    }
    var_6 = 0;

    if(maps\_utility::_id_12DC()) {
      var_6 = 0;
    } else {
      var_6 = level._id_16D1;

      if(isDefined(var_2._id_1969)) {
        var_6 = var_2._id_1969;
      }
    }

    if(int(var_3[var_0]) > var_6) {
      continue;
    }
    var_7 = "";

    for(var_8 = 0; var_8 < var_3.size; var_8++) {
      if(var_8 != var_0) {
        var_7 = var_7 + var_3[var_8];
        continue;
      }

      var_7 = var_7 + (var_6 + 1);
    }

    var_9 = 0;

    for(var_5 = 0; var_5 < var_7.size; var_5++) {
      var_9 = var_9 + max(0, int(var_7[var_5]) - 1);
    }
    var_10 = var_9 - var_4;

    if(var_10 > 0) {
      var_2._id_196A = _id_196F(var_7);
      var_2._id_196B = 1;
      var_2._id_196C = var_10;

      foreach(var_12 in level._id_1952) {
        if(var_12.unlock == 0) {
          continue;
        }
        if(level.ps3 && issplitscreen() && isDefined(level._id_1337) && var_2 == level._id_1337) {
          continue;
        }
        if(var_4 < var_12.unlock && var_9 >= var_12.unlock) {
          var_2._id_196D = 1;
          var_2._id_196E = var_12._id_160B;
        }
      }

      if(var_9 >= 48) {
        var_2._id_196D = 1;
        var_2._id_196E = "so_completed";
        maps\_utility::_id_1427(1);
      }
    }

    if(var_2 maps\_specialops_code::_id_1908() || issplitscreen() && level.ps3 && isDefined(level._id_1337) && var_2 == level._id_1337) {
      var_2 setlocalplayerprofiledata("missionSOHighestDifficulty", var_7);
    }
  }
}

_id_196F(var_0) {
  if(!maps\_utility::_id_12DC()) {
    if(int(tablelookup("sp/specOpsTable.csv", 1, level.script, 14)) == 0) {
      return 0;
    }
  }

  var_1 = int(tablelookup("sp/specopstable.csv", 0, "survival_count", 1));
  var_2 = int(tablelookup("sp/specopstable.csv", 0, "mission_count", 1));
  var_3 = var_1 + var_2;
  var_4 = 0;

  if(maps\_utility::_id_12DC()) {
    for(var_5 = 0; var_5 < var_1; var_5++) {
      var_4 = var_4 + int(max(0, int(var_0[var_5]) - 1));
    }
  } else {
    for(var_5 = var_1; var_5 < var_3; var_5++) {
      var_4 = var_4 + int(max(0, int(var_0[var_5]) - 1));
    }
  }

  return var_4 == 1;
}

_id_1970(var_0) {
  var_1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_2 = "";

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_3 != var_0) {
      var_2 = var_2 + var_1[var_3];
      continue;
    }

    if(level.gameskill + 1 > int(var_1[var_0])) {
      var_2 = var_2 + (level.gameskill + 1);
      continue;
    }

    var_2 = var_2 + var_1[var_3];
  }

  var_4 = "";
  var_5 = 0;
  var_6 = 0;

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    if(int(var_2[var_7]) == 0 || var_5) {
      var_4 = var_4 + "0";
      var_5 = 1;
      continue;
    }

    var_4 = var_4 + var_2[var_7];
    var_6++;
  }

  _id_1971(var_6);
  _id_1972(var_4);
}

_id_1971(var_0) {
  if(getDvar("mis_cheat") == "1") {
    return;
  }
  level.player setlocalplayerprofiledata("highestMission", var_0);
}

_id_1972(var_0) {
  if(getDvar("mis_cheat") == "1") {
    return;
  }
  level.player setlocalplayerprofiledata("missionHighestDifficulty", var_0);
}

_id_1973(var_0) {
  var_1 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  return int(var_1[var_0]);
}

_id_1974(var_0) {
  if(var_0 < 9) {
    return "mis_0" + (var_0 + 1);
  } else {
    return "mis_" + (var_0 + 1);
  }
}

_id_1975() {
  var_0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_1 = 4;

  for(var_2 = 0; var_2 < self._id_190C.size; var_2++) {
    if(int(var_0[var_2]) < var_1) {
      var_1 = int(var_0[var_2]);
    }
  }

  return var_1;
}

_id_1976(var_0) {
  var_1 = spawnStruct();
  var_1._id_190C = [];
  var_1._id_1977 = [];
  var_1._id_1978 = var_0;
  return var_1;
}

_id_1979(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self._id_190C.size;
  self._id_190C[var_7] = spawnStruct();
  self._id_190C[var_7].name = var_0;
  self._id_190C[var_7]._id_197A = var_1;
  self._id_190C[var_7]._id_197B = var_2;
  self._id_190C[var_7]._id_197C = var_3;
  self._id_190C[var_7]._id_197D = var_4;

  if(isDefined(var_5)) {
    self._id_190C[var_7]._id_1543 = var_5;
  }
}

_id_197E(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = self._id_190C.size;
  }
  self._id_190C[var_2] = spawnStruct();
  self._id_190C[var_2].name = var_0;
  var_3 = tablelookup("sp/specopstable.csv", 1, var_0, 13);

  if(var_3 == "") {
    return;
  }
  if(!isDefined(level._id_1952[var_3]._id_197F)) {
    level._id_1952[var_3]._id_197F = [];
  }
  var_4 = level._id_1952[var_3]._id_197F.size;
  level._id_1952[var_3]._id_197F[var_4] = var_0;
}

_id_1980(var_0) {
  var_1 = self._id_1977.size;
  self._id_1977[var_1] = var_0;
}

_id_188A(var_0) {
  foreach(var_3, var_2 in self._id_190C) {
    if(var_2.name == var_0) {
      return var_3;
    }
  }

  return undefined;
}

_id_1981(var_0) {
  return self._id_190C[var_0].name;
}

_id_1982(var_0) {
  return self._id_190C[var_0]._id_197A;
}

_id_1983(var_0) {
  return self._id_190C[var_0]._id_197B;
}

_id_1984(var_0) {
  return self._id_190C[var_0]._id_197D;
}

_id_1985(var_0) {
  if(!isDefined(self._id_190C[var_0]._id_1543)) {
    return undefined;
  }
  return self._id_190C[var_0]._id_1543;
}

_id_1986(var_0) {
  if(isDefined(self._id_190C[var_0]._id_197D)) {
    return 1;
  } else {
    return 0;
  }
}

_id_1987(var_0) {
  if(isDefined(self._id_190C[var_0]._id_197B)) {
    return 1;
  } else {
    return 0;
  }
}

_id_1988(var_0) {
  for(var_1 = 0; var_1 < self._id_190C.size; var_1++) {
    if(var_1 == var_0) {
      continue;
    }
    if(!_id_1986(var_1)) {
      continue;
    }
    if(self._id_190C[var_1]._id_197D == self._id_190C[var_0]._id_197D) {
      if(_id_1966(var_1) < 4) {
        return 0;
      }
    }
  }

  return 1;
}

_id_197C(var_0) {
  if(!isDefined(self._id_190C[var_0]._id_197C)) {
    return 0;
  }
  return 1;
}

_id_1989() {
  return self._id_1978;
}

_id_198A() {
  if(isDefined(self._id_1978)) {
    return 1;
  } else {
    return 0;
  }
}

_id_198B() {
  for(var_0 = 0; var_0 < self._id_190C.size; var_0++) {
    if(!_id_1973(var_0)) {
      return var_0;
    }
  }

  return 0;
}

_id_198C() {
  var_0 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
  var_1 = "";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_2 < 20) {
      var_1 = var_1 + 2;
      continue;
    }

    var_1 = var_1 + 0;
  }

  level.player setlocalplayerprofiledata("missionHighestDifficulty", var_1);
  level.player setlocalplayerprofiledata("highestMission", 20);
}

_id_198D() {
  level.player setlocalplayerprofiledata("missionHighestDifficulty", "00000000000000000000000000000000000000000000000000");
  level.player setlocalplayerprofiledata("highestMission", 1);
}

_id_198E() {
  changelevel("airplane", 0);
}

_id_17F8(var_0) {
  if(!isDefined(self._id_16C6)) {
    self._id_16C6 = [];
  }
  if(!isDefined(level._id_16CF)) {
    level._id_16CF = 0;
    level._id_16CE = 0;
  }

  var_1 = min(level._id_16CE - level._id_16CF, 86400000);
  var_1 = maps\_utility::_id_17FC(var_1, 1, 0);

  foreach(var_3 in level.players) {
    var_3._id_16C6["time"] = var_1;
    var_3._id_16C6["name"] = var_3.playername;
    var_3._id_16C6["difficulty"] = var_3 maps\_utility::_id_198F();

    if(isDefined(var_3._id_1969)) {
      var_3._id_16C6["difficulty"] = var_3._id_1969;
    }
  }

  level._id_16C4 = 0;

  if(maps\_utility::_id_12DC()) {
    foreach(var_3 in level.players) {
      var_3._id_16C6["score"] = [[level._id_1990]]();
      var_3._id_16C6["wave"] = [[level._id_1991]]();
      var_3._id_16C6["kills"] = var_3._id_18D3["kill"];
    }

    level._id_16C4 = [[level._id_1990]]();
  } else {
    var_7 = 300000;

    if(isDefined(level._id_16CB)) {
      var_7 = level._id_16CB;
    }
    var_8 = 0;

    if(var_1 < var_7) {
      var_8 = int((var_7 - var_1) / var_7 * 10000);
    }
    level._id_16C4 = int(level._id_16D1 * 10000) + var_8;

    foreach(var_3 in level.players) {
      var_3._id_16C6["kills"] = var_3.stats["kills"];
      var_3._id_16C6["score"] = level._id_16C4;
    }
  }

  if(!isDefined(level._id_16BC) || !level._id_16BC) {
    foreach(var_3 in level.players) {
      if(maps\_utility::_id_12C1()) {
        var_3._id_1992 = 4;
        continue;
      }

      var_3._id_1992 = 3;
    }
  }

  if(isDefined(level._id_16BD)) {
    [[level._id_16BD]]();
  }
  if(var_0) {
    common_scripts\utility::flag_set("special_op_final_xp_given");

    foreach(var_3 in level.players) {
      var_14 = _id_01DB(var_3._id_16C6["score"]);
      var_15 = 0;

      if(isDefined(level._id_1910) && level._id_1910) {
        var_3 thread maps\_utility::_id_12BE("completion_xp");
        var_15 = maps\_rank::getscoreinfovalue("completion_xp");
      } else {
        var_16 = undefined;
        var_17 = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);

        if(isDefined(var_17) && var_17 != "") {
          var_16 = var_3 getlocalplayerprofiledata(var_17);
        }
        if(isDefined(var_16) && var_16 == 0 && !maps\_utility::_id_12DC()) {
          var_3 thread maps\_utility::_id_12BE("completion_xp");
          var_15 = maps\_rank::getscoreinfovalue("completion_xp");
        }
      }

      if(!maps\_utility::_id_12DC()) {
        var_18 = var_15 + var_14;

        if(var_3._id_12CE["rankxp"] < level._id_01DA) {
          if(var_15 != 0) {
            var_3 thread maps\_utility::_id_16C7("@SPECIAL_OPS_UI_XP_COMPLETION_FRIST_TIME", "^8+" + var_15, "@SPECIAL_OPS_UI_XP_COMPLETION", "^8+" + var_18);
          } else {
            var_3 thread maps\_utility::_id_16C7("@SPECIAL_OPS_UI_XP_COMPLETION", "", "^8+" + var_18);
          }
        }

        var_3 thread maps\_utility::_id_12BE("final_score_xp", var_14);
      }
    }
  }

  if(!isDefined(level._id_16BC) || !level._id_16BC) {
    _id_1994();
  }
}

_id_01DB(var_0) {
  return int(var_0 / 10);
}

_id_17FA() {
  if(isDefined(level._id_12F5) && level._id_12F5 > 0) {
    wait(level._id_12F5);
  }
  thread maps\_ambient::_id_1946("specialop_fadeout", level._id_1707);
  thread maps\_ambient::_id_1948(level._id_1707, 10);
  _id_1993();

  if(isDefined(level.player._id_196A) && level.player._id_196A) {
    setDvar("ui_first_star_player1", level.player._id_196A);
  }
  if(isDefined(level.player._id_196B) && level.player._id_196B) {
    setDvar("ui_eog_player1_stars", level.player._id_196C);
  }
  if(isDefined(level.player._id_196D) && level.player._id_196D) {
    setDvar("ui_eog_player1_unlock", level.player._id_196E);
  }
  if(isDefined(level.player._id_1911) && level.player._id_1911) {
    setDvar("ui_eog_player1_bestscore", level.player._id_1912);
  }
  if(maps\_utility::_id_12C1()) {
    if(isDefined(level.player._id_190E) && level.player._id_190E) {
      setDvar("ui_eog_player1_noreward", level.player._id_190E);
    }
    if(isDefined(level._id_1337._id_196A) && level._id_1337._id_196A) {
      setDvar("ui_first_star_player2", level._id_1337._id_196A);
    }
    if(isDefined(level._id_1337._id_196B) && level._id_1337._id_196B) {
      setDvar("ui_eog_player2_stars", level._id_1337._id_196C);
    }
    if(isDefined(level._id_1337._id_196D) && level._id_1337._id_196D) {
      setDvar("ui_eog_player2_unlock", level._id_1337._id_196E);
    }
    if(isDefined(level._id_1337._id_190E) && level._id_1337._id_190E) {
      setDvar("ui_eog_player2_noreward", level._id_1337._id_190E);
    }
    if(isDefined(level._id_1337._id_1911) && level._id_1337._id_1911) {
      setDvar("ui_eog_player2_bestscore", level._id_1337._id_1912);
    }
    wait 0.05;
    level.player openpopupmenu("coop_eog_summary");
    level._id_1337 openpopupmenu("coop_eog_summary2");
  } else {
    wait 0.05;
    level.player openpopupmenu("sp_eog_summary");
  }
}

_id_1993() {
  setDvar("ui_eog_player1_stars", "");
  setDvar("ui_eog_player1_unlock", "");
  setDvar("ui_eog_player1_besttime", "");
  setDvar("ui_eog_player1_bestscore", "");
  setDvar("ui_eog_player1_noreward", "");
  setDvar("ui_eog_player2_stars", "");
  setDvar("ui_eog_player2_unlock", "");
  setDvar("ui_eog_player2_besttime", "");
  setDvar("ui_eog_player2_bestscore", "");
  setDvar("ui_eog_player2_noreward", "");
}

_id_1994() {
  foreach(var_1 in level.players) {
    var_1 _id_1995();
    var_1 _id_1996();
    var_1 _id_1998();
    var_1 _id_1997();

    if(!level._id_16C9) {
      var_1 _id_1999();
    }
  }
}

_id_1995() {
  if(maps\_utility::_id_12C1()) {
    maps\_utility::_id_16C7("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER", undefined, 1);
  }
}

_id_1996() {
  var_0 = self._id_16C6["kills"];

  if(maps\_utility::_id_12C1()) {
    var_1 = maps\_utility::_id_133A(self)._id_16C6["kills"];
    maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_0, var_1, undefined, 2);
  } else {
    maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_0, undefined, undefined, 1);
  }
}

_id_1997() {
  var_0[0] = "@MENU_RECRUIT";
  var_0[1] = "@MENU_REGULAR";
  var_0[2] = "@MENU_HARDENED";
  var_0[3] = "@MENU_VETERAN";
  var_1 = maps\_utility::_id_198F();
  maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_1, undefined, undefined, 2 + int(maps\_utility::_id_12C1()));
}

_id_1998() {
  var_0 = self._id_16C6["time"] * 0.001;
  var_1 = maps\_utility::_id_16D0(var_0, 1);
  maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TIME", var_1, undefined, undefined, 3 + int(maps\_utility::_id_12C1()));
}

_id_1999() {
  if(maps\_utility::_id_12C1()) {
    var_0 = "@SPECIAL_OPS_UI_TEAM_SCORE";
  } else {
    var_0 = "@SPECIAL_OPS_UI_SCORE";
  }
  var_1 = self._id_16C6["score"];
  maps\_utility::_id_16C7(var_0, var_1);
}