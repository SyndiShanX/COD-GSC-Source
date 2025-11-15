/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2768.gsc
***************************************/

init() {
  var_00 = getdvarint("scr_match_recording", 0);

  if(!func_B408(var_00))
    return;
  else
    level.matchrecording_type = var_00;

  level.matchreceventcountline = 0;
  level.matchrecevents = [];
  level.matchrecording_logevent = ::matchrecording_logevent;
  level.matchrecording_logeventmsg = ::matchrecording_logeventmsg;
  level.matchrecording_logeventplayername = ::matchrecording_logeventplayername;
  level.matchrecording_dump = ::matchrecording_dump;
  level.matchrecording_generateid = ::matchrecording_generateid;
  level.matchrecording_usereventthink = ::matchrecording_usereventthink;

  if(level.matchrecording_type == 1)
    func_B3F5();
  else if(level.matchrecording_type == 3)
    matchrecording_scriptdata_openfileaddheader(1);

  level thread matchrecording_logallplayerposthink();
  level thread matchrecording_onplayerconnect();
  level thread func_B3FE();
}

func_B408(var_00) {
  var_01 = 1;

  if(var_00 == 0)
    var_01 = 0;
  else if(var_00 < 0 || var_00 > 4)
    var_01 = 0;
  else if(var_00 == 3 || var_00 == 4) {
    var_02 = 0;

    if(!var_02)
      var_01 = 0;
  } else if(var_00 == 1 || var_00 == 2) {
    var_03 = getdvarint("g_logEnable", 0);
    var_01 = var_03 == 1;
  }

  return var_01;
}

matchrecording_isenabled() {
  return isDefined(level.matchrecording_type) && level.matchrecording_type > 0;
}

matchrecording_teammap(var_00) {
  if(isDefined(level.teambased) && !level.teambased)
    var_01 = 2;
  else if(!isDefined(var_00) || var_00 == "allies")
    var_01 = 2;
  else
    var_01 = 3;

  return var_01;
}

matchrecording_eventcharmap(var_00) {
  var_01 = undefined;

  switch (var_00) {
    case "PATH":
      var_01 = "p";
      break;
    case "SPAWN":
      var_01 = "s";
      break;
    case "DEATH":
      var_01 = "d";
      break;
    case "BULLET":
      var_01 = "b";
      break;
    case "EXPLOSION":
      var_01 = "e";
      break;
    case "ANCHOR":
      var_01 = "t";
      break;
    case "FRONT_LINE":
      var_01 = "l";
      break;
    case "FRONT_LINE_ALLIES":
      var_01 = "[";
      break;
    case "FRONT_LINE_AXIS":
      var_01 = "]";
      break;
    case "FLAG_A":
      var_01 = "A";
      break;
    case "FLAG_B":
      var_01 = "B";
      break;
    case "FLAG_C":
      var_01 = "C";
      break;
    case "SPAWN_ENTITY":
      var_01 = "S";
      break;
    case "PORTAL":
      var_01 = "O";
      break;
    case "LOG_BAD_SPAWN":
      var_01 = "!";
      break;
    case "LOG_GENERIC_MESSAGE":
      var_01 = "m";
      break;
    case "LOG_USER_EVENT":
      var_01 = "u";
      break;
    case "LOG_STAT":
      var_01 = "?";
      break;
    case "PLAYER_NAME":
      var_01 = "n";
      break;
    case "BEST_SPAWN_ALLIES":
      var_01 = "+";
      break;
    case "BEST_SPAWN_AXIS":
      var_01 = "^";
      break;
    default:
      break;
  }

  return var_01;
}

func_B3F4() {
  var_00 = [];
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
  return var_00;
}

matchrecording_logevent(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  var_09 = matchrecording_teammap(var_01);
  var_10 = int(var_03) + "," + int(var_04);
  var_11 = matchrecording_eventcharmap(var_02);

  if(var_02 == "BULLET" || var_02 == "FRONT_LINE" || var_02 == "FRONT_LINE_ALLIES" || var_02 == "FRONT_LINE_AXIS") {}

  var_12 = "";

  if(isDefined(var_06))
    var_12 = " s:" + var_06;

  var_13 = "";

  if(isDefined(var_07) && isDefined(var_08))
    var_13 = " " + int(var_07) + "," + int(var_08);

  var_14 = "|" + var_00 + " " + var_09 + " " + var_11 + " " + var_10 + " " + var_05 + var_13 + var_12;
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + var_14;
}

matchrecording_logeventmsg(var_00, var_01, var_02) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  var_03 = matchrecording_eventcharmap(var_00);

  if(var_02 != "") {
    if(!isDefined(var_02))
      var_02 = "";
    else
      var_02 = " \"" + var_02 + "\"";
  }

  var_04 = "|0 0 " + var_03 + " " + var_01 + var_02;
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + var_04;
}

matchrecording_logeventplayername(var_00, var_01, var_02) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  var_03 = matchrecording_teammap(var_01);
  var_04 = matchrecording_eventcharmap("PLAYER_NAME");
  var_05 = "|" + var_00 + " " + var_03 + " " + var_04 + " " + "\"" + var_02 + "\"";
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + var_05;
}

matchrecording_inceventlinecount() {
  level.matchreceventcountline++;

  if(level.matchrecevents.size == 0) {
    level.matchrecevents[level.matchrecevents.size] = "<mrec_events> ";
    level.matchreceventcountline = 0;
  } else if(level.matchreceventcountline > 30 || level.matchrecevents[level.matchrecevents.size - 1].size > 800) {
    if(level.matchrecording_type == 1 || level.matchrecording_type == 3)
      matchrecording_dump();

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
  if(level.matchrecording_type == 2)
    func_B3F5();

  foreach(var_01 in level.matchrecevents)
  logprint(var_01 + "\\n");

  level.matchrecevents = [];
}

func_B3F5() {
  var_00 = func_B3F4();

  foreach(var_02 in var_00)
  logprint(var_02);
}

matchrecording_scriptdata_openfilewrite() {}

matchrecording_scriptdata_openfileappend() {}

matchrecording_scriptdata_openfileaddheader(var_00) {}

matchrecording_scriptdata_dump() {}

matchrecording_logallplayerposthink() {
  if(!matchrecording_isenabled()) {
    return;
  }
  level endon("game_ended");
  scripts\mp\utility\game::gameflagwait("prematch_done");

  for(;;) {
    var_00 = gettime();
    var_01 = level.players;

    foreach(var_03 in var_01) {
      var_04 = gettime();

      if(isDefined(var_03) && scripts\mp\utility\game::isreallyalive(var_03)) {
        matchrecording_logevent(var_3.clientid, var_3.team, "PATH", var_3.origin[0], var_3.origin[1], var_04);
        scripts\engine\utility::waitframe();
      }
    }

    wait(max(0.05, 1.5 - (gettime() - var_00) / 1000));
  }
}

matchrecording_onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread matchrecording_usereventthink();
  }
}

func_B3FE() {
  level waittill("game_ended");
  var_00 = 0;
  var_01 = 0;
  var_02 = 0.0;
  var_03 = 0;
  var_04 = 0.0;

  foreach(var_06 in level.players) {
    if(isDefined(var_6.func_D37E)) {
      foreach(var_08 in var_6.func_D37E) {
        var_02 = var_02 + var_08;
        var_1++;

        if(var_08 > 75.0)
          var_0++;
      }
    }

    if(isDefined(var_6.engagementtimes)) {
      foreach(var_11 in var_6.engagementtimes) {
        var_04 = var_04 + var_11;
        var_3++;
      }
    }
  }

  if(var_01 > 0) {
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Shot in the back percent: " + var_00 / var_01 * 100.0 + "%");
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Avg. Death Angle: " + var_02 / var_01);
  }

  if(var_03 > 0)
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Avg. Engagement Length: " + var_04 / var_03 / 1000.0 + "s");

  if(isDefined(level.func_744D) && isDefined(level.func_744D.func_12F92) && isDefined(level.func_744D.func_5AFE)) {
    var_14 = level.func_744D.func_12F92 + level.func_744D.func_5AFE;

    if(var_14 > 0.0)
      matchrecording_logeventmsg("LOG_STAT", gettime(), "Frontline Uptime: " + level.func_744D.func_12F92 / var_14 * 100.0 + "%");
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
    var_00 = scripts\engine\utility::waittill_any_return("log_user_event_end", "log_user_event_generic_event");

    if(var_00 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      matchrecording_logeventmsg("LOG_USER_EVENT", gettime(), self.name);
    }
  }
}

matchrecording_generateid() {
  if(!isDefined(game["matchRecording_nextID"]))
    game["matchRecording_nextID"] = 100;

  var_00 = game["matchRecording_nextID"];
  game["matchRecording_nextID"]++;
  return var_00;
}