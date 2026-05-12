/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_dynamic_events.gsc
*********************************************/

func_352E(param_00, param_01, param_02) {
  if(getdvarint("233")) {
    return;
  }

  if(isDefined(level.var_352F)) {
    if(level.var_352F == 1) {
      return;
    }

    if(level.var_352F == 2) {
      if(isDefined(param_02)) {
        level[[param_02]]();
      }

      return;
    }
  }

  setdvarifuninitialized("scr_dynamic_event_state", "on");
  if(getDvar("scr_dynamic_event_state", "on") == "off") {
    return;
  } else if(getDvar("scr_dynamic_event_state", "on") == "endstate") {
    if(isDefined(param_02)) {
      level[[param_02]]();
    }

    return;
  }

  if(!isDefined(level.var_352E)) {
    level.var_352E = [];
  }

  if(level.var_3FDC == "sd" || level.var_3FDC == "sr") {
    level thread func_4A59(param_00, param_02);
  } else {
    level thread func_49DC(param_00, param_01, 0);
  }

  level thread func_5E8F();
}

func_5E8F() {}

func_4A59(param_00, param_01) {
  game["dynamicEvent_switchedsides"] = game["switchedsides"];
  if(level.var_3FDC == "sd") {
    game["dynamicEvent_scorelimit"] = getdvarint("scr_sd_winlimit", 6);
  } else if(level.var_3FDC == "sr") {
    game["dynamicEvent_scorelimit"] = getdvarint("scr_sr_winlimit", 6);
  }

  if(!isDefined(game["dynamicEvent_switchedsides"])) {
    game["dynamicEvent_switchedsides"] = 0;
  }

  if(!isDefined(game["dynamicEvent_teamA_RoundTally"])) {
    game["dynamicEvent_teamA_RoundTally"] = 0;
  }

  if(!isDefined(game["dynamicEvent_teamB_RoundTally"])) {
    game["dynamicEvent_teamB_RoundTally"] = 0;
  }

  if(game["dynamicEvent_switchedsides"] == 0) {
    game["dynamicEvent_teamA_RoundTally"]++;
    func_2151(param_00, param_01, game["dynamicEvent_teamA_RoundTally"]);
    return;
  }

  if(game["dynamicEvent_switchedsides"] == 1) {
    game["dynamicEvent_teamB_RoundTally"]++;
    func_2151(param_00, param_01, game["dynamicEvent_teamB_RoundTally"]);
  }
}

func_2151(param_00, param_01, param_02) {
  var_03 = int(game["dynamicEvent_scorelimit"] / 2);
  if(var_03 == 0) {
    var_03 = 3;
  }

  if(param_02 == var_03) {
    wait(10);
    level notify("dynamic_event_starting");
    if(isDefined(param_00) && isDefined(param_01)) {
      level[[param_00]]();
      return;
    }

    return;
  }

  if(param_02 > var_03) {
    if(isDefined(param_00) && isDefined(param_01)) {
      level[[param_01]]();
      return;
    }
  }
}

func_49DC(param_00, param_01, param_02) {
  var_03 = func_44AE();
  var_04 = func_44AD();
  var_05 = undefined;
  var_06 = maps\mp\_utility::func_4672();
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  while(var_03 > var_04 && !param_02 || !isDefined(var_05) || var_05 <= var_06 * level.var_352E["start_percent"]) {
    wait(1);
    maps\mp\gametypes\_hostmigration::func_A782();
    var_03 = var_03 - 1;
    var_05 = func_44AC();
  }

  level notify("dynamic_event_starting");
  if(isDefined(param_00)) {
    level[[param_00]]();
  }
}

func_8672(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0.5;
  }

  if(param_00 < 0 || param_00 > 1) {}

  level.var_352E["start_percent"] = param_00;
}

func_44AD() {
  if(!isDefined(level.var_352E["start_percent"])) {
    func_8672();
  }

  var_00 = func_44AE();
  var_01 = var_00 - var_00 * level.var_352E["start_percent"];
  return var_01;
}

func_44AC() {
  var_00 = undefined;
  if(level.var_984D) {
    var_01 = maps\mp\gametypes\_gamescore::func_473F();
    if(isDefined(var_01) && var_01 == "none" && isDefined(level.var_985B)) {
      var_00 = maps\mp\gametypes\_gamescore::func_063E(level.var_985B[0]);
    } else if(isDefined(var_01)) {
      var_00 = maps\mp\gametypes\_gamescore::func_063E(var_01);
    }
  } else {
    var_02 = maps\mp\gametypes\_gamescore::func_450A();
    if(!isDefined(var_02) && isDefined(level.var_744A) && level.var_744A.size > 0) {
      var_01 = maps\mp\gametypes\_gamescore::func_0638(level.var_744A[0]);
    } else if(isDefined(var_02)) {
      var_01 = maps\mp\gametypes\_gamescore::func_0638(var_02);
    }
  }

  return var_02;
}

func_44AE() {
  var_00 = maps\mp\_utility::func_46E2();
  if(var_00 == 0) {
    var_00 = 600;
  } else {
    var_00 = var_00 * 60;
  }

  var_01 = maps\mp\_utility::func_4502();
  if(isDefined(var_01) && var_01) {
    var_00 = var_00 / 2;
  }

  return var_00;
}