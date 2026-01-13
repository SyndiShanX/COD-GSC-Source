/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2768.gsc
***************************************/

init() {
  var_0 = getdvarint("scr_match_recording", 0);

  if(!func_B408(var_0)) {
    return;
  } else {
    level.matchrecording_type = var_0;
  }

  level.matchreceventcountline = 0;
  level.matchrecevents = [];
  level.matchrecording_logevent = ::matchrecording_logevent;
  level.matchrecording_logeventmsg = ::matchrecording_logeventmsg;
  level.matchrecording_logeventplayername = ::matchrecording_logeventplayername;
  level.matchrecording_dump = ::matchrecording_dump;
  level.matchrecording_generateid = ::matchrecording_generateid;
  level.matchrecording_usereventthink = ::matchrecording_usereventthink;

  if(level.matchrecording_type == 1) {
    func_B3F5();
  } else if(level.matchrecording_type == 3) {
    matchrecording_scriptdata_openfileaddheader(1);
  }

  level thread matchrecording_logallplayerposthink();
  level thread matchrecording_onplayerconnect();
  level thread func_B3FE();
}

func_B408(var_0) {
  var_1 = 1;

  if(var_0 == 0) {
    var_1 = 0;
  } else if(var_0 < 0 || var_0 > 4) {
    var_1 = 0;
  } else if(var_0 == 3 || var_0 == 4) {
    var_2 = 0;

    if(!var_2) {
      var_1 = 0;
    }
  } else if(var_0 == 1 || var_0 == 2) {
    var_3 = getdvarint("g_logEnable", 0);
    var_1 = var_3 == 1;
  }

  return var_1;
}

matchrecording_isenabled() {
  return isDefined(level.matchrecording_type) && level.matchrecording_type > 0;
}

matchrecording_teammap(var_0) {
  if(isDefined(level.teambased) && !level.teambased) {
    var_1 = 2;
  } else if(!isDefined(var_0) || var_0 == "allies") {
    var_1 = 2;
  } else {
    var_1 = 3;
  }

  return var_1;
}

matchrecording_eventcharmap(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "PATH":
      var_1 = "p";
      break;
    case "SPAWN":
      var_1 = "s";
      break;
    case "DEATH":
      var_1 = "d";
      break;
    case "BULLET":
      var_1 = "b";
      break;
    case "EXPLOSION":
      var_1 = "e";
      break;
    case "ANCHOR":
      var_1 = "t";
      break;
    case "FRONT_LINE":
      var_1 = "l";
      break;
    case "FRONT_LINE_ALLIES":
      var_1 = "[";
      break;
    case "FRONT_LINE_AXIS":
      var_1 = "]";
      break;
    case "FLAG_A":
      var_1 = "A";
      break;
    case "FLAG_B":
      var_1 = "B";
      break;
    case "FLAG_C":
      var_1 = "C";
      break;
    case "SPAWN_ENTITY":
      var_1 = "S";
      break;
    case "PORTAL":
      var_1 = "O";
      break;
    case "LOG_BAD_SPAWN":
      var_1 = "!";
      break;
    case "LOG_GENERIC_MESSAGE":
      var_1 = "m";
      break;
    case "LOG_USER_EVENT":
      var_1 = "u";
      break;
    case "LOG_STAT":
      var_1 = "?";
      break;
    case "PLAYER_NAME":
      var_1 = "n";
      break;
    case "BEST_SPAWN_ALLIES":
      var_1 = "+";
      break;
    case "BEST_SPAWN_AXIS":
      var_1 = "^";
      break;
    default:
      break;
  }

  return var_1;
}

func_B3F4() {
  var_0 = [];
  var_0[var_0.size] = "<mrec_map> " + level.script + "\\n";
  var_0[var_0.size] = "<mrec_game_type> " + level.gametype + "\\n";
  var_0[var_0.size] = "<mrec_event_def> PATH p\\n";
  var_0[var_0.size] = "<mrec_event_def> PATH_SPAWN s\\n";
  var_0[var_0.size] = "<mrec_event_def> PATH_DEATH d\\n";
  var_0[var_0.size] = "<mrec_event_def> PATH_BULLET b\\n";
  var_0[var_0.size] = "<mrec_event_def> PATH_EXPLOSION e\\n";
  var_0[var_0.size] = "<mrec_event_def> ANCHOR t\\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_LINE l 255,0,0,0\\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_LINE [255,255,127,0\\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_LINE] 255,0,255,255\\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE A flagA.tga flagAallies.tga flagAaxis.tga\\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE B flagB.tga flagBallies.tga flagBaxis.tga\\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE C flagC.tga flagCallies.tga flagCaxis.tga\\n";
  var_0[var_0.size] = "<mrec_event_def> SPAWN_ENTITY S\\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE O flagAallies.tga flagAaxis.tga\\n";
  var_0[var_0.size] = "<mrec_event_def> LOG_MESSAGE ! \"No good spawns found. Using bad spawn.\" \\n";
  var_0[var_0.size] = "<mrec_event_def> LOG_MESSAGE m \"MSG: \" \\n";
  var_0[var_0.size] = "<mrec_event_def> LOG_MESSAGE u \"User Event From \" \\n";
  var_0[var_0.size] = "<mrec_event_def> LOG_MESSAGE ? \"STAT: \" \\n";
  var_0[var_0.size] = "<mrec_event_def> PLAYER_NAME n\\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE + bestSpawnAllies.tga\\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE ^ bestSpawnAxis.tga\\n";
  return var_0;
}

matchrecording_logevent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  var_9 = matchrecording_teammap(var_1);
  var_10 = int(var_3) + "," + int(var_4);
  var_11 = matchrecording_eventcharmap(var_2);

  if(var_2 == "BULLET" || var_2 == "FRONT_LINE" || var_2 == "FRONT_LINE_ALLIES" || var_2 == "FRONT_LINE_AXIS") {}

  var_12 = "";

  if(isDefined(var_6)) {
    var_12 = " s:" + var_6;
  }

  var_13 = "";

  if(isDefined(var_7) && isDefined(var_8)) {
    var_13 = " " + int(var_7) + "," + int(var_8);
  }

  var_14 = "|" + var_0 + " " + var_9 + " " + var_11 + " " + var_10 + " " + var_5 + var_13 + var_12;
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + var_14;
}

matchrecording_logeventmsg(var_0, var_1, var_2) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  var_3 = matchrecording_eventcharmap(var_0);

  if(var_2 != "") {
    if(!isDefined(var_2)) {
      var_2 = "";
    } else {
      var_2 = " \"" + var_2 + "\"";
    }
  }

  var_4 = "|0 0 " + var_3 + " " + var_1 + var_2;
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + var_4;
}

matchrecording_logeventplayername(var_0, var_1, var_2) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  var_3 = matchrecording_teammap(var_1);
  var_4 = matchrecording_eventcharmap("PLAYER_NAME");
  var_5 = "|" + var_0 + " " + var_3 + " " + var_4 + " " + "\"" + var_2 + "\"";
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + var_5;
}

matchrecording_inceventlinecount() {
  level.matchreceventcountline++;

  if(level.matchrecevents.size == 0) {
    level.matchrecevents[level.matchrecevents.size] = "<mrec_events> ";
    level.matchreceventcountline = 0;
  } else if(level.matchreceventcountline > 30 || level.matchrecevents[level.matchrecevents.size - 1].size > 800) {
    if(level.matchrecording_type == 1 || level.matchrecording_type == 3) {
      matchrecording_dump();
    }

    level.matchrecevents[level.matchrecevents.size] = "<mrec_events> ";
    level.matchreceventcountline = 0;
  }
}

matchrecording_dump() {
  if(!matchrecording_isenabled()) {
    return;
  }
  if(!isDefined(level.matchrecevents) || level.matchrecevents.size == 0) {
    return;
  }
  switch (level.matchrecording_type) {
    case 2:
    case 1:
      matchrecording_glog_dump();
      break;
    case 4:
    case 3:
      matchrecording_scriptdata_dump();
      break;
    default:
      break;
  }
}

matchrecording_glog_dump() {
  if(level.matchrecording_type == 2) {
    func_B3F5();
  }

  foreach(var_1 in level.matchrecevents) {
    logprint(var_1 + "\\n");
  }

  level.matchrecevents = [];
}

func_B3F5() {
  var_0 = func_B3F4();

  foreach(var_2 in var_0) {
    logprint(var_2);
  }
}

matchrecording_scriptdata_openfilewrite() {}

matchrecording_scriptdata_openfileappend() {}

matchrecording_scriptdata_openfileaddheader(var_0) {}

matchrecording_scriptdata_dump() {}

matchrecording_logallplayerposthink() {
  if(!matchrecording_isenabled()) {
    return;
  }
  level endon("game_ended");
  scripts\mp\utility\game::gameflagwait("prematch_done");

  for(;;) {
    var_0 = gettime();
    var_1 = level.players;

    foreach(var_3 in var_1) {
      var_4 = gettime();

      if(isDefined(var_3) && scripts\mp\utility\game::isreallyalive(var_3)) {
        matchrecording_logevent(var_3.clientid, var_3.team, "PATH", var_3.origin[0], var_3.origin[1], var_4);
        scripts\engine\utility::waitframe();
      }
    }

    wait(max(0.05, 1.5 - (gettime() - var_0) / 1000));
  }
}

matchrecording_onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread matchrecording_usereventthink();
  }
}

func_B3FE() {
  level waittill("game_ended");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0.0;
  var_3 = 0;
  var_4 = 0.0;

  foreach(var_6 in level.players) {
    if(isDefined(var_6.var_D37E)) {
      foreach(var_8 in var_6.var_D37E) {
        var_2 = var_2 + var_8;
        var_1++;

        if(var_8 > 75.0) {
          var_0++;
        }
      }
    }

    if(isDefined(var_6.engagementtimes)) {
      foreach(var_11 in var_6.engagementtimes) {
        var_4 = var_4 + var_11;
        var_3++;
      }
    }
  }

  if(var_1 > 0) {
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Shot in the back percent: " + var_0 / var_1 * 100.0 + "%");
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Avg. Death Angle: " + var_2 / var_1);
  }

  if(var_3 > 0) {
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Avg. Engagement Length: " + var_4 / var_3 / 1000.0 + "s");
  }

  if(isDefined(level.var_744D) && isDefined(level.var_744D.var_12F92) && isDefined(level.var_744D.var_5AFE)) {
    var_14 = level.var_744D.var_12F92 + level.var_744D.var_5AFE;

    if(var_14 > 0.0) {
      matchrecording_logeventmsg("LOG_STAT", gettime(), "Frontline Uptime: " + level.var_744D.var_12F92 / var_14 * 100.0 + "%");
    }
  }
}

matchrecording_usereventthink() {
  self endon("disconnect");
  level endon("game_ended");

  if(isai(self)) {
    return;
  }
  self notifyonplayercommand("log_user_event_start", "+actionslot 3");
  self notifyonplayercommand("log_user_event_end", "-actionslot 3");
  self notifyonplayercommand("log_user_event_generic_event", "+gostand");

  for(;;) {
    self waittill("log_user_event_start");
    var_0 = scripts\engine\utility::waittill_any_return("log_user_event_end", "log_user_event_generic_event");

    if(var_0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      matchrecording_logeventmsg("LOG_USER_EVENT", gettime(), self.name);
    }
  }
}

matchrecording_generateid() {
  if(!isDefined(game["matchRecording_nextID"])) {
    game["matchRecording_nextID"] = 100;
  }

  var_0 = game["matchRecording_nextID"];
  game["matchRecording_nextID"]++;
  return var_0;
}