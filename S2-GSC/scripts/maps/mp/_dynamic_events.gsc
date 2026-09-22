/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_dynamic_events.gsc
***********************************************/

_id_352E(var_0, var_1, var_2) {
  if(getdvarint("233")) {
    return;
  }
  if(isDefined(level._id_352F)) {
    if(level._id_352F == 1) {
      return;
    }
    if(level._id_352F == 2) {
      if(isDefined(var_2)) {
        level[[var_2]]();
      }

      return;
    }
  }

  setdvarifuninitialized("scr_dynamic_event_state", "on");

  if(getDvar("scr_dynamic_event_state", "on") == "off") {
    return;
  } else if(getDvar("scr_dynamic_event_state", "on") == "endstate") {
    if(isDefined(var_2)) {
      level[[var_2]]();
    }

    return;
  }

  if(!isDefined(level._id_352E)) {
    level._id_352E = [];
  }

  if(level.gametype == "sd" || level.gametype == "sr") {
    level thread _id_4A59(var_0, var_2);
  } else {
    level thread _id_49DC(var_0, var_1, 0);
  }

  level thread _id_5E8F();
}

_id_5E8F() {}

_id_4A59(var_0, var_1) {
  game["dynamicEvent_switchedsides"] = game["switchedsides"];

  if(level.gametype == "sd") {
    game["dynamicEvent_scorelimit"] = getdvarint("scr_sd_winlimit", 6);
  } else if(level.gametype == "sr") {
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
    _id_2151(var_0, var_1, game["dynamicEvent_teamA_RoundTally"]);
  } else if(game["dynamicEvent_switchedsides"] == 1) {
    game["dynamicEvent_teamB_RoundTally"]++;
    _id_2151(var_0, var_1, game["dynamicEvent_teamB_RoundTally"]);
  }
}

_id_2151(var_0, var_1, var_2) {
  var_3 = int(game["dynamicEvent_scorelimit"] / 2);

  if(var_3 == 0) {
    var_3 = 3;
  }

  if(var_2 == var_3) {
    wait 10;
    level notify("dynamic_event_starting");

    if(isDefined(var_0) && isDefined(var_1)) {
      level[[var_0]]();
    }
  } else if(var_2 > var_3) {
    if(isDefined(var_0) && isDefined(var_1)) {
      level[[var_1]]();
    }
  }
}

_id_49DC(var_0, var_1, var_2) {
  var_3 = _id_44AE();
  var_4 = _id_44AD();
  var_5 = undefined;
  var_6 = maps\mp\_utility::getscorelimit();

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  while(var_3 > var_4 && (!var_2 || (!isDefined(var_5) || var_5 <= var_6 * level._id_352E["start_percent"]))) {
    wait 1;
    maps\mp\gametypes\_hostmigration::_id_A782();
    var_3 = var_3 - 1;
    var_5 = _id_44AC();
  }

  level notify("dynamic_event_starting");

  if(isDefined(var_0)) {
    level[[var_0]]();
  }
}

_id_8672(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  if(var_0 < 0 || var_0 > 1) {}

  level._id_352E["start_percent"] = var_0;
}

_id_44AD() {
  if(!isDefined(level._id_352E["start_percent"])) {
    _id_8672();
  }

  var_0 = _id_44AE();
  var_1 = var_0 - var_0 * level._id_352E["start_percent"];
  return var_1;
}

_id_44AC() {
  var_0 = undefined;

  if(level.teambased) {
    var_1 = _id_04D2::_id_473F();

    if(isDefined(var_1) && var_1 == "none" && isDefined(level._id_985B)) {
      var_0 = _id_04D2::_id_063E(level._id_985B[0]);
    } else if(isDefined(var_1)) {
      var_0 = _id_04D2::_id_063E(var_1);
    }
  } else {
    var_2 = _id_04D2::_id_450A();

    if(!isDefined(var_2) && isDefined(level.players) && level.players.size > 0) {
      var_0 = _id_04D2::_id_0638(level.players[0]);
    } else if(isDefined(var_2)) {
      var_0 = _id_04D2::_id_0638(var_2);
    }
  }

  return var_0;
}

_id_44AE() {
  var_0 = maps\mp\_utility::gettimelimit();

  if(var_0 == 0) {
    var_0 = 600;
  } else {
    var_0 = var_0 * 60;
  }

  var_1 = maps\mp\_utility::gethalftime();

  if(isDefined(var_1) && var_1) {
    var_0 = var_0 / 2;
  }

  return var_0;
}