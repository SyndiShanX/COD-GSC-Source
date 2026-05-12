/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_ranked_play.gsc
**********************************************/

waitforbackendreply() {
  while(!function_03C5()) {
    wait 0.05;
  }
}

func_00D5() {
  if(function_03AF()) {
    thread func_6B90();
    level.var_75E7 = ::waitforbackendreply;
  }
}

func_6B90() {
  function_0265();
  level endon("game_win");
  level endon("exitLevel_called");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_6B6C();
  }
}

func_6B6C() {
  level endon("game_win");
  level endon("exitLevel_called");
  self method_854C();
  self.initial_mmr = self method_86C0();
}

func_6B56(param_00) {
  if(param_00 == "axis") {
    function_0263();
    return;
  }

  if(param_00 == "allies") {
    function_0262();
    return;
  }

  function_0264();
}

onmatchvoid() {
  function_03C3();
}

func_21BA() {
  var_00["allies"] = 0;
  var_00["axis"] = 0;
  foreach(var_02 in level.var_744A) {
    if(isDefined(var_02.var_01A7) && isDefined(var_00[var_02.var_01A7])) {
      var_00[var_02.var_01A7]++;
    }
  }

  foreach(var_02 in level.var_744A) {
    if(isDefined(var_02.var_01A7)) {
      if(var_02.var_01A7 == "allies" && var_00["axis"] == 0) {
        var_02.var_012C["division"]["wonByForfeit"] = 1;
        continue;
      }

      if(var_02.var_01A7 == "axis" && var_00["allies"] == 0) {
        var_02.var_012C["division"]["wonByForfeit"] = 1;
        continue;
      }

      var_02.var_012C["division"]["wonByForfeit"] = 0;
    }
  }
}

getrankformmr(param_00) {
  if(!isDefined(level.ranktablecache)) {
    level.ranktablecache = [];
    var_01 = function_027A("mp/rankedplaytable.csv");
    for(var_02 = 0; var_02 < var_01; var_02++) {
      var_03 = tablelookupbyrow("mp/rankedplaytable.csv", var_02, 1);
      var_04 = tablelookupbyrow("mp/rankedplaytable.csv", var_02, 2);
      level.ranktablecache[var_02] = [float(var_03), float(var_04)];
    }
  }

  for(var_05 = 0; var_05 < level.ranktablecache.size; var_05++) {
    if(param_00 >= level.ranktablecache[var_05][0] && param_00 < level.ranktablecache[var_05][1]) {
      return var_05 + 1;
    }
  }

  return 0;
}

giverankadvancerewards(param_00) {
  if(isDefined(self.initial_mmr)) {
    var_01 = self.initial_mmr;
    var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", param_00, "mmr_current");
    var_03 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", param_00, "ranked_games_total");
    var_04 = !self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", param_00, "mmr_was_adjusted");
    var_05 = var_03 == getdvarint("4697", 10);
    if(!var_04) {
      var_05 = var_03 == 1;
    }

    if(var_05) {
      var_06 = getrankformmr(var_02);
      if(var_06 < 1) {
        var_06 = 1;
      }

      for(var_07 = 1; var_07 <= var_06; var_07++) {
        lib_0468::ae_sendrankedplayrankupevent(var_07);
      }

      return;
    }

    if(!var_04 || var_03 > getdvarint("4697", 10)) {
      if(param_00 == 1) {
        var_08 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", param_00, "mmr_max");
        var_09 = getrankformmr(var_08);
        if(var_09 < 1) {
          var_09 = 1;
        }

        for(var_07 = 1; var_07 <= var_09; var_07++) {
          lib_0468::ae_sendrankedplayrankupevent(var_07);
        }

        return;
      }

      if(var_02 > var_01) {
        var_06 = getrankformmr(var_02);
        var_0A = getrankformmr(var_01);
        if(var_06 > var_0A) {
          lib_0468::ae_sendrankedplayrankupevent(var_06);
          return;
        }

        return;
      }

      return;
    }
  }
}