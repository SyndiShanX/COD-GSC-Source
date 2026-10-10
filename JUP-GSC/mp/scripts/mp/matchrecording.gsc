/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\matchrecording.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\matchdata;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace matchrecording;

function init() {
  assertex(!isDefined(level.matchrecording_type), "<dev string:x1c>");
  recordingtype = matchrecording_getrecordingtype();

  if(!matchrecording_validaterecordingtype(recordingtype)) {
    return;
  } else {
    level.matchrecording_type = recordingtype;
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

  level thread matchrecording_logallplayerposthink();
  level thread matchrecording_onplayerconnect();
  level thread matchrecording_loggameendstats();
  level thread matchrecording_vehiclewatcher("matchrecording_ground_vehicle", "GROUND_VEHICLE");
  level thread matchrecording_vehiclewatcher("matchrecording_small_ground_vehicle", "SMALL_GROUND_VEHICLE");
  level thread matchrecording_vehiclewatcher("matchrecording_plane", "PLANE_VEHICLE");
  level thread matchrecording_vehiclewatcher("matchrecording_chopper", "CHOPPER_VEHICLE");
}

function matchrecording_getrecordingtype() {
  if(lpcfeaturegated() && getgametype() != "arm" && getgametype() != "conflict") {
    return 0;
  }

  type = getdvarint(@ "hash_dbe4b78ae44499c8", 0);

  if(type == 0 && getdvarint(@ "hash_b328f87e7c1ded21", 0) == 1) {
    type = 1;
  } else if(analyticsstreamerislogfilestreamingenabled()) {
    type = 1;
  }

  return type;
}

function matchrecording_validaterecordingtype(typeval) {
  result = 1;

  if(typeval == 0) {
    result = 0;
  } else if(typeval < 0 || typeval > 4) {
    assertmsg("<dev string:x44>" + typeval);
    result = 0;
  } else if(typeval == 3 || typeval == 4) {
    var_1342032fe5b235a6 = 0;

    var_1342032fe5b235a6 = 1;

    if(!var_1342032fe5b235a6) {
      assertmsg("<dev string:xba>" + typeval);
      result = 0;
    }
  } else if(typeval == 1 || typeval == 2) {
    var_accdc2233ab9770 = getdvarint(@ "hash_b328f87e7c1ded21", 0);
    var_5ae8370351e1a4a1 = analyticsstreamerislogfilestreamingenabled();
    result = var_accdc2233ab9770 == 1 || var_5ae8370351e1a4a1 == 1;
    assertex(result == 1, "<dev string:x12c>");
  }

  return result;
}

function matchrecording_isenabled() {
  return isDefined(level.matchrecording_type) && level.matchrecording_type > 0;
}

function matchrecording_teammap(teamname) {
  if(isDefined(level.teambased) && !level.teambased) {
    result = 2;
  } else if(!isDefined(teamname) || teamname == "allies") {
    result = 2;
  } else {
    result = 3;
  }

  return result;
}

function matchrecording_eventcharmap(event) {
  eventchar = undefined;

  switch (event) {
    case #"hash_ec91d04aafaffe56":
      eventchar = "p";
      break;
    case #"hash_945fc291982ded18":
      eventchar = "s";
      break;
    case #"hash_f8c2554e05678a8d":
      eventchar = "d";
      break;
    case #"hash_8f7fd70c5987ea59":
      eventchar = "b";
      break;
    case #"hash_36c6169aaf0125a0":
      eventchar = "e";
      break;
    case #"hash_3819040083fb6294":
      eventchar = "t";
      break;
    case #"hash_8d9e20b710f779a7":
      eventchar = "l";
      break;
    case #"hash_3dd92e59bd6a825e":
      eventchar = "[";
      break;
    case #"hash_bfab0a97caa56709":
      eventchar = "]";
      break;
    case #"hash_15aa75e5faef833b":
      eventchar = "A";
      break;
    case #"hash_15aa76e5faef84ce":
      eventchar = "B";
      break;
    case #"hash_15aa77e5faef8661":
      eventchar = "C";
      break;
    case #"hash_15aa78e5faef87f4":
      eventchar = "D";
      break;
    case #"hash_15aa79e5faef8987":
      eventchar = "E";
      break;
    case #"hash_15aa84e5faef9ad8":
      eventchar = "0";
      break;
    case #"hash_15aa85e5faef9c6b":
      eventchar = "1";
      break;
    case #"hash_15aa86e5faef9dfe":
      eventchar = "2";
      break;
    case #"hash_15aa87e5faef9f91":
      eventchar = "3";
      break;
    case #"hash_15aa88e5faefa124":
      eventchar = "4";
      break;
    case #"hash_af78f78a213f2e9a":
      eventchar = "S";
      break;
    case #"hash_99264a563d62312b":
      eventchar = "O";
      break;
    case #"hash_77fea0649b41a0d5":
      eventchar = "!";
      break;
    case #"hash_30765763b6eae663":
      eventchar = "m";
      break;
    case #"hash_27bd18e3a64148c2":
      eventchar = "u";
      break;
    case #"hash_ebe8ddb545ee11c0":
      eventchar = "?";
      break;
    case #"hash_84e2df1e1e7795ee":
      eventchar = "n";
      break;
    case #"hash_5dad097e1ee588e":
      eventchar = "+";
      break;
    case #"hash_8eb45d501d18b819":
      eventchar = "^";
      break;
    case #"hash_faf31591468c0301":
      eventchar = "G";
      break;
    case #"hash_539e90ea786e44c5":
      eventchar = "g";
      break;
    case #"hash_bd9d4e183a058042":
      eventchar = "V";
      break;
    case #"hash_933571b34f210f5f":
      eventchar = "H";
      break;
    default:
      assertmsg("<dev string:x170>" + event);
      break;
  }

  return eventchar;
}

function matchrecording_getfileheaderarray() {
  array = [];
  array[array.size] = "<mrec_start> \n";
  array[array.size] = "<mrec_map> " + level.script + "\n";
  array[array.size] = "<mrec_game_type> " + getgametype() + "\n";
  array[array.size] = "<mrec_event_def> PATH p\n";
  array[array.size] = "<mrec_event_def> PATH_SPAWN s\n";
  array[array.size] = "<mrec_event_def> PATH_DEATH d\n";
  array[array.size] = "<mrec_event_def> PATH_BULLET b\n";
  array[array.size] = "<mrec_event_def> PATH_EXPLOSION e\n";
  array[array.size] = "<mrec_event_def> ANCHOR t\n";
  array[array.size] = "<mrec_event_def> GENERIC_LINE l 255,0,0,0\n";
  array[array.size] = "<mrec_event_def> GENERIC_LINE [ 255,255,127,0\n";
  array[array.size] = "<mrec_event_def> GENERIC_LINE ] 255,0,255,255\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE A flagA.tga flagAallies.tga flagAaxis.tga\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE B flagB.tga flagBallies.tga flagBaxis.tga\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE C flagC.tga flagCallies.tga flagCaxis.tga\n";
  array[array.size] = "<mrec_event_def> SPAWN_ENTITY S\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE O flagAallies.tga flagAaxis.tga\n";
  array[array.size] = "<mrec_event_def> LOG_MESSAGE ! \"No good spawns found. Using bad spawn.\" \n";
  array[array.size] = "<mrec_event_def> LOG_MESSAGE m \"MSG: \" \n";
  array[array.size] = "<mrec_event_def> LOG_MESSAGE u \"User Event From \" \n";
  array[array.size] = "<mrec_event_def> LOG_MESSAGE ? \"STAT: \" \n";
  array[array.size] = "<mrec_event_def> PLAYER_NAME n\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE + bestSpawnAllies.tga\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE ^ bestSpawnAxis.tga\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE G blank.tga groundVehicleAllies.tga groundVehicleAxis.tga\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE g blank.tga smallGroundVehicleAllies.tga smallGroundVehicleAxis.tga\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE H blank.tga chopperAllies.tga chopperAxis.tga\n";
  array[array.size] = "<mrec_event_def> GENERIC_IMAGE V blank.tga planeAllies.tga planeAxis.tga\n";
  return array;
}

function matchrecording_logevent(var_619cf3736c12073, teamname, event, x, y, timemsec, opstateindex, var_31ef7d754ebf53f, var_baa945e8fb3ba8aa) {
  if(!matchrecording_isenabled()) {
    return;
  }

  matchrecording_inceventlinecount();
  teamidx = matchrecording_teammap(teamname);
  xy = int(x) + "," + int(y);
  eventchar = matchrecording_eventcharmap(event);

  if(event == "BULLET" || event == "FRONT_LINE" || event == "FRONT_LINE_ALLIES" || event == "FRONT_LINE_AXIS") {
    assertex(isDefined(var_31ef7d754ebf53f) && isDefined(var_baa945e8fb3ba8aa), "<dev string:x1ad>" + event + "<dev string:x1d2>");
  }

  strstate = "";

  if(isDefined(opstateindex)) {
    assertex(opstateindex == int(opstateindex) && opstateindex >= 0, "<dev string:x203>");
    strstate = " s:" + opstateindex;
  }

  var_a9e08ccaa418b973 = "";

  if(isDefined(var_31ef7d754ebf53f) && isDefined(var_baa945e8fb3ba8aa)) {
    var_a9e08ccaa418b973 = " " + int(var_31ef7d754ebf53f) + "," + int(var_baa945e8fb3ba8aa);
  }

  eventpack = "|" + var_619cf3736c12073 + " " + teamidx + " " + eventchar + " " + xy + " " + timemsec + var_a9e08ccaa418b973 + strstate;
  level.matchrecevents[level.matchrecevents.size - 1] += eventpack;
}

function matchrecording_logeventmsg(event, timemsec, var_e377539688c48f4b) {
  if(!matchrecording_isenabled()) {
    return;
  }

  matchrecording_inceventlinecount();
  eventchar = matchrecording_eventcharmap(event);

  if(var_e377539688c48f4b != "") {
    if(!isDefined(var_e377539688c48f4b)) {
      var_e377539688c48f4b = "";
    } else {
      var_e377539688c48f4b = " \"" + var_e377539688c48f4b + "\"";
    }
  }

  eventpack = "|0 0 " + eventchar + " " + timemsec + var_e377539688c48f4b;
  level.matchrecevents[level.matchrecevents.size - 1] += eventpack;
}

function matchrecording_logeventplayername(ownerid, teamname, ownername) {
  if(!matchrecording_isenabled()) {
    return;
  }

  matchrecording_inceventlinecount();
  teamidx = matchrecording_teammap(teamname);
  eventchar = matchrecording_eventcharmap("PLAYER_NAME");
  eventpack = "|" + ownerid + " " + teamidx + " " + eventchar + " " + "\"" + ownername + "\"";
  level.matchrecevents[level.matchrecevents.size - 1] += eventpack;
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
    case 1:
    case 2:
      matchrecording_glog_dump();
      break;
    case 3:
    case 4:
      matchrecording_scriptdata_dump();
      break;
    default:
      assertmsg("<dev string:x259>" + level.matchrecording_type);
      break;
  }
}

function matchrecording_glog_dump() {
  if(level.matchrecording_type == 2) {
    matchrecording_glog_addheader();
  }

  foreach(eventstr in level.matchrecevents) {
    logprint(eventstr + "\n");

    if(analyticsstreamerislogfilestreamingenabled()) {
      analyticsstreamerlogfilewritetobuffer(eventstr + "\n");
    }
  }

  level.matchrecevents = [];
}

function matchrecording_glog_addheader() {
  headerstrings = matchrecording_getfileheaderarray();

  foreach(h in headerstrings) {
    logprint(h);

    if(analyticsstreamerislogfilestreamingenabled()) {
      analyticsstreamerlogfilewritetobuffer(h);
    }
  }
}

function matchrecording_scriptdata_openfilewrite() {
  assertex(!isDefined(level.var_ac13a3f4ca2c6c83), "<dev string:x29e>");
  level.var_ac13a3f4ca2c6c83 = "<dev string:x2f4>" + level.script + "<dev string:x311>" + getgametype() + "<dev string:x311>" + scripts\mp\matchdata::getmatchstarttimeutc() + "<dev string:x316>";
  fileid = openfile(level.var_ac13a3f4ca2c6c83, "<dev string:x31e>");

  if(fileid == -1) {
    assertmsg("<dev string:x327>" + level.var_ac13a3f4ca2c6c83);
  }

  return fileid;
}

function matchrecording_scriptdata_openfileappend() {
  if(!isDefined(level.var_ac13a3f4ca2c6c83)) {
    assertmsg("<dev string:x36c>");
    return -1;
  }

  fileid = openfile(level.var_ac13a3f4ca2c6c83, "<dev string:x3ca>");

  if(fileid == -1) {
    assertmsg("<dev string:x3d4>" + level.var_ac13a3f4ca2c6c83);
  }

  return fileid;
}

function matchrecording_scriptdata_openfileaddheader(closeafter) {
  fileid = matchrecording_scriptdata_openfilewrite();
  headerstrings = matchrecording_getfileheaderarray();

  foreach(h in headerstrings) {
    fprintln(fileid, h);
  }

  if(closeafter) {
    fileid = closefile(fileid);
  }

  return fileid;
}

function matchrecording_scriptdata_dump() {
  fileid = -1;

  if(level.matchrecording_type == 4) {
    fileid = matchrecording_scriptdata_openfileaddheader(0);
  } else if(level.matchrecording_type == 3) {
    fileid = matchrecording_scriptdata_openfileappend();
  }

  if(fileid == -1) {
    return;
  }

  foreach(eventstr in level.matchrecevents) {
    fprintln(fileid, eventstr);
  }

  fileid = closefile(fileid);

  if(fileid == -1) {
    assertmsg("<dev string:x405>" + level.var_ac13a3f4ca2c6c83);
  }

  level.matchrecevents = [];
}

function matchrecording_logallplayerposthink() {
  if(!matchrecording_isenabled()) {
    return;
  }

  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    timestart = gettime();
    players = level.players;

    foreach(player in players) {
      time = gettime();

      if(isDefined(player) && isreallyalive(player)) {
        matchrecording_logevent(player.clientid, player.team, "PATH", player.origin[0], player.origin[1], time);
        waitframe();
      }
    }

    wait max(level.framedurationseconds, 1.5 - (gettime() - timestart) / 1000);
  }
}

function matchrecording_onplayerconnect() {
  while(true) {
    level waittill("connected", player);
    player thread matchrecording_usereventthink();
  }
}

function matchrecording_loggameendstats() {
  level waittill("game_ended");
  sidekillcount = 0;
  var_25c32cef8be0663b = 0;
  anglestotal = 0;
  engagementcount = 0;
  engagementtotal = 0;

  foreach(player in level.players) {
    if(isDefined(player.sidekillcount)) {
      sidekillcount = player.sidekillcount;
    }

    if(isDefined(player.engagementcount)) {
      engagementcount = player.engagementcount;
    }

    if(isDefined(player.engagementtime)) {
      engagementtotal = player.engagementtime;
    }
  }

  if(engagementcount > 0) {
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Shot in the back percent: " + sidekillcount / engagementcount * 100 + "%");
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Avg. Engagement Length: " + engagementtotal / engagementcount / 1000 + "s");
  }

  if(isDefined(level.frontlineinfo) && isDefined(level.frontlineinfo.uptime) && isDefined(level.frontlineinfo.downtime)) {
    totaltime = level.frontlineinfo.uptime + level.frontlineinfo.downtime;

    if(totaltime > 0) {
      matchrecording_logeventmsg("LOG_STAT", gettime(), "Frontline Uptime: " + level.frontlineinfo.uptime / totaltime * 100 + "%");
    }
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

  while(true) {
    self waittill("log_user_event_start");
    notification = waittill_any_return_no_endon_death_2("log_user_event_end", "log_user_event_generic_event");

    if(notification == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      matchrecording_logeventmsg("LOG_USER_EVENT", gettime(), self.name);
    }
  }
}

function matchrecording_generateid() {
  if(!isDefined(game["matchRecording_nextID"])) {
    game["matchRecording_nextID"] = 100;
  }

  returnvalue = game["matchRecording_nextID"];
  game["matchRecording_nextID"]++;
  return returnvalue;
}

function matchrecording_vehiclewatcher(notifymsg, logtype) {
  level endon("game_ended");

  while(true) {
    level waittill(notifymsg, vehicle);
    vehicle matchrecording_vehicletrackingthink(logtype);
  }
}

function matchrecording_vehicletrackingthink(logtype) {
  level endon("game_ended");
  self endon("death");
  vehicleid = matchrecording_generateid();

  if(!isDefined(self.team)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no team");
    return;
  }

  if(!isDefined(self.origin)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no origin");
    return;
  }

  thread matchrecording_vehiclecleanupthink(vehicleid, logtype);

  while(true) {
    state = ter_op(self.team == "allies", 1, 2);
    matchrecording_logevent(vehicleid, self.team, logtype, self.origin[0], self.origin[1], gettime(), state);
    wait 0.25;
  }
}

function matchrecording_vehiclecleanupthink(logid, logtype) {
  level endon("game_ended");
  self waittill("death");
  matchrecording_logevent(logid, "allies", logtype, 0, 0, gettime(), 0);
}