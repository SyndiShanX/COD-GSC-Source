/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchrecording.gsc
***********************************************/

function init() {
  var_0 = matchrecording_getrecordingtype();

  if(!matchrecording_validaterecordingtype(var_0)) {
    return;
  } else {
    level.matchrecording_type = var_0;
  }

  level.matchreceventcountline = 0;
  level.matchrecevents = [];
  level.matchrecording_logevent = &matchrecording_logevent;
  level.matchrecording_logeventmsg = &matchrecording_logeventmsg;
  level.matchrecording_logeventplayername = &matchrecording_logeventplayername;
  level.matchrecording_dump = &matchrecording_dump;
  level.matchrecording_generateid = &matchrecording_generateid;
  level.matchrecording_usereventthink = &matchrecording_usereventthink;

  if(level.matchrecording_type == 1) {
    matchrecording_glog_addheader();
  } else if(level.matchrecording_type == 3) {
    matchrecording_scriptdata_openfileaddheader(1);
  }

  thread matchrecording_logallplayerposthink();
  thread matchrecording_onplayerconnect();
  thread matchrecording_loggameendstats();
  thread matchrecording_vehiclewatcher(level, "matchrecording_ground_vehicle");
  thread matchrecording_vehiclewatcher(level, "matchrecording_small_ground_vehicle");
  thread matchrecording_vehiclewatcher(level, "matchrecording_plane");
  thread matchrecording_vehiclewatcher(level, "matchrecording_chopper");
}

function matchrecording_getrecordingtype() {
  if(scripts\mp\utility\game::lpcfeaturegated() && scripts\mp\utility\game::getgametype() != "arm") {
    return 0;
  }

  var_0 = getdvarint("scr_match_recording", 0);

  if(var_0 == 0 && getdvarint("g_logEnable", 0) == 1) {
    var_0 = 1;
  } else if(drawentitybounds()) {
    var_0 = 1;
  }

  return var_0;
}

function matchrecording_validaterecordingtype(var_0) {
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
    var_4 = drawentitybounds();
    var_1 = var_3 == 1 || var_4 == 1;
  }

  return var_1;
}

function matchrecording_isenabled() {
  return isDefined(level.matchrecording_type) && level.matchrecording_type > 0;
}

function matchrecording_teammap(var_0) {
  if(isDefined(level.teambased) && !level.teambased) {
    var_1 = 2;
  } else if(!isDefined(var_1) || var_1 == "allies") {
    var_1 = 2;
  } else {
    var_1 = 3;
  }

  return var_1;
}

function matchrecording_eventcharmap(var_0) {
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
    case "FLAG_D":
      var_1 = "D";
      break;
    case "FLAG_E":
      var_1 = "E";
      break;
    case "FLAG_0":
      var_1 = "0";
      break;
    case "FLAG_1":
      var_1 = "1";
      break;
    case "FLAG_2":
      var_1 = "2";
      break;
    case "FLAG_3":
      var_1 = "3";
      break;
    case "FLAG_4":
      var_1 = "4";
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
    case "GROUND_VEHICLE":
      var_1 = "G";
      break;
    case "SMALL_GROUND_VEHICLE":
      var_1 = "g";
      break;
    case "PLANE_VEHICLE":
      var_1 = "V";
      break;
    case "CHOPPER_VEHICLE":
      var_1 = "H";
      break;
    default:
      break;
  }

  return var_1;
}

function matchrecording_getfileheaderarray() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "<mrec_start> \n");
}

function matchrecording_logevent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
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
  level.matchrecevents[level.matchrecevents.size - 1] += var_14;
}

function matchrecording_logeventmsg(var_0, var_1, var_2) {
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
  level.matchrecevents[level.matchrecevents.size - 1] += var_4;
}

function matchrecording_logeventplayername(var_0, var_1, var_2) {
  if(!matchrecording_isenabled()) {
    return;
  }

  matchrecording_inceventlinecount();
  var_3 = matchrecording_teammap(var_1);
  var_4 = matchrecording_eventcharmap("PLAYER_NAME");
  var_5 = "|" + var_0 + " " + var_3 + " " + var_4 + " " + "\"" + var_2 + "\"";
  level.matchrecevents[level.matchrecevents.size - 1] += var_5;
}

function matchrecording_inceventlinecount() {
  level.matchreceventcountline++;

  if(level.matchrecevents.size == 0) {
    level.matchrecevents[level.matchrecevents.size] = "<mrec_events> ";
    level.matchreceventcountline = 0;
    return;
  }

  if(level.matchreceventcountline > 30 || level.matchrecevents[level.matchrecevents.size - 1].size > 800) {
    if(level.matchrecording_type == 1 || level.matchrecording_type == 3) {
      matchrecording_dump();
    }

    level.matchrecevents[level.matchrecevents.size] = "<mrec_events> ";
    level.matchreceventcountline = 0;
    return;
  }
}

function matchrecording_dump() {
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

function matchrecording_glog_dump() {
  if(level.matchrecording_type == 2) {
    matchrecording_glog_addheader();
  }

  foreach(var_1 in level.matchrecevents) {
    logprint(var_1 + "\n");

    if(drawentitybounds()) {
      analyticsstreamerlogfiletagplayer(var_1 + "\n");
    }
  }

  level.matchrecevents = [];
}

function matchrecording_glog_addheader() {
  var_0 = matchrecording_getfileheaderarray();

  foreach(var_2 in var_0) {
    logprint(var_2);

    if(drawentitybounds()) {
      analyticsstreamerlogfiletagplayer(var_2);
    }
  }
}

function matchrecording_scriptdata_openfilewrite() {}

function matchrecording_scriptdata_openfileappend() {}

function matchrecording_scriptdata_openfileaddheader(var_0) {}

function matchrecording_scriptdata_dump() {}

function matchrecording_logallplayerposthink() {
  if(!matchrecording_isenabled()) {
    return;
  }

  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    var_0 = gettime();
    var_1 = level.players;

    foreach(var_3 in var_1) {
      var_4 = gettime();

      if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3)) {
        matchrecording_logevent(var_3.clientid, var_3.team, "PATH", var_3.origin[0], var_3.origin[1], var_4);
        waitframe();
      }
    }

    wait max(level.framedurationseconds, 1.5 - (gettime() - var_0) / 1000);
  }
}

function matchrecording_onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    thread matchrecording_usereventthink();
  }
}

function matchrecording_loggameendstats() {
  level waittill("game_ended");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in level.players) {
    if(isDefined(var_6.ref_1338f)) {
      var_0 = var_6.ref_1338f;
    }

    if(isDefined(var_6.nuke_explposstruct)) {
      var_3 = var_6.nuke_explposstruct;
    }

    if(isDefined(var_6.nuke_hostmigration_waitlongdurationwithpause)) {
      var_4 = var_6.nuke_hostmigration_waitlongdurationwithpause;
    }
  }

  if(var_3 > 0) {
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Shot in the back percent: " + var_0 / var_3 * 100 + "%");
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Avg. Engagement Length: " + var_4 / var_3 / 1000 + "s");
  }

  if(isDefined(level.frontlineinfo) && isDefined(level.frontlineinfo.uptime) && isDefined(level.frontlineinfo.downtime)) {
    var_8 = level.frontlineinfo.uptime + level.frontlineinfo.downtime;

    if(var_8 > 0) {
      matchrecording_logeventmsg("LOG_STAT", gettime(), "Frontline Uptime: " + level.frontlineinfo.uptime / var_8 * 100 + "%");
      return;
    }

    return;
  }
}

function matchrecording_usereventthink() {
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
    var_0 = scripts\engine\utility::ref_143b4("log_user_event_end", "log_user_event_generic_event");

    if(var_0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      matchrecording_logeventmsg("LOG_USER_EVENT", gettime(), self.name);
    }
  }
}

function matchrecording_generateid() {
  if(!isDefined(game["matchRecording_nextID"])) {
    game["matchRecording_nextID"] = 100;
  }

  var_0 = game["matchRecording_nextID"];
  game["matchRecording_nextID"]++;
  return var_0;
}

function matchrecording_vehiclewatcher(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    level waittill(var_0, var_2);
    matchrecording_vehicletrackingthink(var_2, var_1);
  }
}

function matchrecording_vehicletrackingthink(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = matchrecording_generateid();

  if(!isDefined(self.team)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no team");
    return;
  }

  if(!isDefined(self.origin)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no origin");
    return;
  }

  thread matchrecording_vehiclecleanupthink(var_1, var_0);

  for(;;) {
    var_2 = scripts\engine\utility::ter_op(self.team == "allies", 1, 2);
    matchrecording_logevent(var_1, self.team, var_0, self.origin[0], self.origin[1], gettime(), var_2);
    wait 0.25;
  }
}

function matchrecording_vehiclecleanupthink(var_0, var_1) {
  level endon("game_ended");
  self waittill("death");
  matchrecording_logevent(var_0, "allies", var_1, 0, 0, gettime(), 0);
}