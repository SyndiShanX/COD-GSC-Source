/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_ranked_play.gsc
******************************************************/

waitforbackendreply() {
  while(!_func_3C5())
    waitframe();
}

init() {
  if(_func_3AF()) {
    thread _id_6B90();
    level._id_75E7 = ::waitforbackendreply;
  }
}

_id_6B90() {
  _func_265();
  level endon("game_win");
  level endon("exitLevel_called");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerconnect();
  }
}

onplayerconnect() {
  level endon("game_win");
  level endon("exitLevel_called");
  self _meth_854C();
  self.initial_mmr = self _meth_86C0();
}

_id_6B56(var_0) {
  if(var_0 == "axis")
    _func_263();
  else if(var_0 == "allies")
    _func_262();
  else
    _func_264();
}

onmatchvoid() {
  _func_3C3();
}

_id_21BA() {
  var_0["allies"] = 0;
  var_0["axis"] = 0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.team) && isDefined(var_0[var_2.team]))
      var_0[var_2.team]++;
  }

  foreach(var_2 in level.players) {
    if(isDefined(var_2.team)) {
      if(var_2.team == "allies" && var_0["axis"] == 0) {
        var_2.pers["division"]["wonByForfeit"] = 1;
        continue;
      }

      if(var_2.team == "axis" && var_0["allies"] == 0) {
        var_2.pers["division"]["wonByForfeit"] = 1;
        continue;
      }

      var_2.pers["division"]["wonByForfeit"] = 0;
    }
  }
}

getrankformmr(var_0) {
  if(!isDefined(level.ranktablecache)) {
    level.ranktablecache = [];
    var_1 = _func_27A("mp/rankedplaytable.csv");

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = _func_1AE("mp/rankedplaytable.csv", var_2, 1);
      var_4 = _func_1AE("mp/rankedplaytable.csv", var_2, 2);
      level.ranktablecache[var_2] = [_func_0AD(var_3), _func_0AD(var_4)];
    }
  }

  for(var_5 = 0; var_5 < level.ranktablecache.size; var_5++) {
    if(var_0 >= level.ranktablecache[var_5][0] && var_0 < level.ranktablecache[var_5][1])
      return var_5 + 1;
  }

  return 0;
}

giverankadvancerewards(var_0) {
  if(isDefined(self.initial_mmr)) {
    var_1 = self.initial_mmr;
    var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_0, "mmr_current");
    var_3 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_0, "ranked_games_total");
    var_4 = !self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_0, "mmr_was_adjusted");
    var_5 = var_3 == getdvarint("4697", 10);

    if(!var_4)
      var_5 = var_3 == 1;

    if(var_5) {
      var_6 = getrankformmr(var_2);

      if(var_6 < 1)
        var_6 = 1;

      for(var_7 = 1; var_7 <= var_6; var_7++)
        _id_0468::ae_sendrankedplayrankupevent(var_7);
    } else if(!var_4 || var_3 > getdvarint("4697", 10)) {
      if(var_0 == 1) {
        var_8 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_0, "mmr_max");
        var_9 = getrankformmr(var_8);

        if(var_9 < 1)
          var_9 = 1;

        for(var_7 = 1; var_7 <= var_9; var_7++)
          _id_0468::ae_sendrankedplayrankupevent(var_7);
      } else if(var_2 > var_1) {
        var_6 = getrankformmr(var_2);
        var_10 = getrankformmr(var_1);

        if(var_6 > var_10)
          _id_0468::ae_sendrankedplayrankupevent(var_6);
      }
    }
  }
}