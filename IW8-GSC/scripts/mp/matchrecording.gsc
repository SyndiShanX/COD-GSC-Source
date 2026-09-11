/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchrecording.gsc
***********************************************/

function init() {
  var0 = matchrecording_getrecordingtype();

  if(!matchrecording_validaterecordingtype(var0)) {
    return;
  } else {
    level.matchrecording_type = var0;
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

  var0 = getdvarint("scr_match_recording", 0);

  if(var0 == 0 && getdvarint("SQNRRQTTQ", 0) == 1) {
    var0 = 1;
  } else if(drawentitybounds()) {
    var0 = 1;
  }

  return var0;
}

function matchrecording_validaterecordingtype(var0) {
  var1 = 1;

  if(var0 == 0) {
    var1 = 0;
  } else if(var0 < 0 || var0 > 4) {
    var1 = 0;
  } else if(var0 == 3 || var0 == 4) {
    var2 = 0;

    if(!var2) {
      var1 = 0;
    }
  } else if(var0 == 1 || var0 == 2) {
    var3 = getdvarint("SQNRRQTTQ", 0);
    var4 = drawentitybounds();
    var1 = var3 == 1 || var4 == 1;
  }

  return var1;
}

function matchrecording_isenabled() {
  return isDefined(level.matchrecording_type) && level.matchrecording_type > 0;
}

function matchrecording_teammap(var0) {
  if(isDefined(level.teambased) && !level.teambased) {
    var1 = 2;
  } else if(!isDefined(var1) || var1 == "allies") {
    var1 = 2;
  } else {
    var1 = 3;
  }

  return var1;
}

function matchrecording_eventcharmap(var0) {
  var1 = undefined;

  switch (var0) {
    case "PATH":
      var1 = "p";
      break;
    case "SPAWN":
      var1 = "s";
      break;
    case "DEATH":
      var1 = "d";
      break;
    case "BULLET":
      var1 = "b";
      break;
    case "EXPLOSION":
      var1 = "e";
      break;
    case "ANCHOR":
      var1 = "t";
      break;
    case "FRONT_LINE":
      var1 = "l";
      break;
    case "FRONT_LINE_ALLIES":
      var1 = "[";
      break;
    case "FRONT_LINE_AXIS":
      var1 = "]";
      break;
    case "FLAG_A":
      var1 = "A";
      break;
    case "FLAG_B":
      var1 = "B";
      break;
    case "FLAG_C":
      var1 = "C";
      break;
    case "FLAG_D":
      var1 = "D";
      break;
    case "FLAG_E":
      var1 = "E";
      break;
    case "FLAG_0":
      var1 = "0";
      break;
    case "FLAG_1":
      var1 = "1";
      break;
    case "FLAG_2":
      var1 = "2";
      break;
    case "FLAG_3":
      var1 = "3";
      break;
    case "FLAG_4":
      var1 = "4";
      break;
    case "SPAWN_ENTITY":
      var1 = "S";
      break;
    case "PORTAL":
      var1 = "O";
      break;
    case "LOG_BAD_SPAWN":
      var1 = "!";
      break;
    case "LOG_GENERIC_MESSAGE":
      var1 = "m";
      break;
    case "LOG_USER_EVENT":
      var1 = "u";
      break;
    case "LOG_STAT":
      var1 = "?";
      break;
    case "PLAYER_NAME":
      var1 = "n";
      break;
    case "BEST_SPAWN_ALLIES":
      var1 = "+";
      break;
    case "BEST_SPAWN_AXIS":
      var1 = "^";
      break;
    case "GROUND_VEHICLE":
      var1 = "G";
      break;
    case "SMALL_GROUND_VEHICLE":
      var1 = "g";
      break;
    case "PLANE_VEHICLE":
      var1 = "V";
      break;
    case "CHOPPER_VEHICLE":
      var1 = "H";
      break;
    default:
      break;
  }

  return var1;
}

function matchrecording_getfileheaderarray() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "<mrec_start> \n");
}

function matchrecording_logevent(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!matchrecording_isenabled()) {
    return;
  }

  matchrecording_inceventlinecount();
  var9 = matchrecording_teammap(var1);
  var10 = int(var3) + "," + int(var4);
  var11 = matchrecording_eventcharmap(var2);

  if(var2 == "BULLET" || var2 == "FRONT_LINE" || var2 == "FRONT_LINE_ALLIES" || var2 == "FRONT_LINE_AXIS") {}

  var12 = "";

  if(isDefined(var6)) {
    var12 = " s:" + var6;
  }

  var13 = "";

  if(isDefined(var7) && isDefined(var8)) {
    var13 = " " + int(var7) + "," + int(var8);
  }

  var14 = "|" + var0 + " " + var9 + " " + var11 + " " + var10 + " " + var5 + var13 + var12;
  level.matchrecevents[level.matchrecevents.size - 1] += var14;
}

function matchrecording_logeventmsg(var0, var1, var2) {
  if(!matchrecording_isenabled()) {
    return;
  }

  matchrecording_inceventlinecount();
  var3 = matchrecording_eventcharmap(var0);

  if(var2 != "") {
    if(!isDefined(var2)) {
      var2 = "";
    } else {
      var2 = " \"" + var2 + "\"";
    }
  }

  var4 = "|0 0 " + var3 + " " + var1 + var2;
  level.matchrecevents[level.matchrecevents.size - 1] += var4;
}

function matchrecording_logeventplayername(var0, var1, var2) {
  if(!matchrecording_isenabled()) {
    return;
  }

  matchrecording_inceventlinecount();
  var3 = matchrecording_teammap(var1);
  var4 = matchrecording_eventcharmap("PLAYER_NAME");
  var5 = "|" + var0 + " " + var3 + " " + var4 + " " + "\"" + var2 + "\"";
  level.matchrecevents[level.matchrecevents.size - 1] += var5;
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

  foreach(var1 in level.matchrecevents) {
    logprint(var1 + "\n");

    if(drawentitybounds()) {
      analyticsstreamerlogfiletagplayer(var1 + "\n");
    }
  }

  level.matchrecevents = [];
}

function matchrecording_glog_addheader() {
  var0 = matchrecording_getfileheaderarray();

  foreach(var2 in var0) {
    logprint(var2);

    if(drawentitybounds()) {
      analyticsstreamerlogfiletagplayer(var2);
    }
  }
}

function matchrecording_scriptdata_openfilewrite() {}

function matchrecording_scriptdata_openfileappend() {}

function matchrecording_scriptdata_openfileaddheader(var0) {}

function matchrecording_scriptdata_dump() {}

function matchrecording_logallplayerposthink() {
  if(!matchrecording_isenabled()) {
    return;
  }

  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    var0 = gettime();
    var1 = level.players;

    foreach(var3 in var1) {
      var4 = gettime();

      if(isDefined(var3) && scripts\mp\utility\player::isreallyalive(var3)) {
        matchrecording_logevent(var3.clientid, var3.team, "PATH", var3.origin[0], var3.origin[1], var4);
        waitframe();
      }
    }

    wait max(level.framedurationseconds, 1.5 - (gettime() - var0) / 1000);
  }
}

function matchrecording_onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    thread matchrecording_usereventthink();
  }
}

function matchrecording_loggameendstats() {
  level waittill("game_ended");
  var0 = 0;
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = 0;

  foreach(var6 in level.players) {
    if(isDefined(var6.ref_1338f)) {
      var0 = var6.ref_1338f;
    }

    if(isDefined(var6.nuke_explposstruct)) {
      var3 = var6.nuke_explposstruct;
    }

    if(isDefined(var6.nuke_hostmigration_waitlongdurationwithpause)) {
      var4 = var6.nuke_hostmigration_waitlongdurationwithpause;
    }
  }

  if(var3 > 0) {
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Shot in the back percent: " + var0 / var3 * 100 + "%");
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Avg. Engagement Length: " + var4 / var3 / 1000 + "s");
  }

  if(isDefined(level.frontlineinfo) && isDefined(level.frontlineinfo.uptime) && isDefined(level.frontlineinfo.downtime)) {
    var8 = level.frontlineinfo.uptime + level.frontlineinfo.downtime;

    if(var8 > 0) {
      matchrecording_logeventmsg("LOG_STAT", gettime(), "Frontline Uptime: " + level.frontlineinfo.uptime / var8 * 100 + "%");
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
    var0 = scripts\engine\utility::ref_143b4("log_user_event_end", "log_user_event_generic_event");

    if(var0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      matchrecording_logeventmsg("LOG_USER_EVENT", gettime(), self.name);
    }
  }
}

function matchrecording_generateid() {
  if(!isDefined(game["matchRecording_nextID"])) {
    game["matchRecording_nextID"] = 100;
  }

  var0 = game["matchRecording_nextID"];
  game["matchRecording_nextID"]++;
  return var0;
}

function matchrecording_vehiclewatcher(var0, var1) {
  level endon("game_ended");

  for(;;) {
    level waittill(var0, var2);
    matchrecording_vehicletrackingthink(var2, var1);
  }
}

function matchrecording_vehicletrackingthink(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = matchrecording_generateid();

  if(!isDefined(self.team)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no team");
    return;
  }

  if(!isDefined(self.origin)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no origin");
    return;
  }

  thread matchrecording_vehiclecleanupthink(var1, var0);

  for(;;) {
    var2 = scripts\engine\utility::ter_op(self.team == "allies", 1, 2);
    matchrecording_logevent(var1, self.team, var0, self.origin[0], self.origin[1], gettime(), var2);
    wait 0.25;
  }
}

function matchrecording_vehiclecleanupthink(var0, var1) {
  level endon("game_ended");
  self waittill("death");
  matchrecording_logevent(var0, "allies", var1, 0, 0, gettime(), 0);
}