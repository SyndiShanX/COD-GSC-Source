/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchrecording.gsc
***********************************************/

init() {
  _id_CA55FF9933D1C7F0 = matchrecording_getrecordingtype();

  if(!matchrecording_validaterecordingtype(_id_CA55FF9933D1C7F0))
    return;
  else
    level.matchrecording_type = _id_CA55FF9933D1C7F0;

  level.matchreceventcountline = 0;
  level.matchrecevents = [];
  level.matchrecording_logevent = ::matchrecording_logevent;
  level.matchrecording_logeventmsg = ::matchrecording_logeventmsg;
  level.matchrecording_logeventplayername = ::matchrecording_logeventplayername;
  level.matchrecording_dump = ::matchrecording_dump;
  level.matchrecording_generateid = ::matchrecording_generateid;
  level.matchrecording_usereventthink = ::matchrecording_usereventthink;

  if(level.matchrecording_type == 1)
    matchrecording_glog_addheader();
  else if(level.matchrecording_type == 3)
    matchrecording_scriptdata_openfileaddheader(1);

  level thread matchrecording_logallplayerposthink();
  level thread matchrecording_onplayerconnect();
  level thread matchrecording_loggameendstats();
  level thread matchrecording_vehiclewatcher("matchrecording_ground_vehicle", "GROUND_VEHICLE");
  level thread matchrecording_vehiclewatcher("matchrecording_small_ground_vehicle", "SMALL_GROUND_VEHICLE");
  level thread matchrecording_vehiclewatcher("matchrecording_plane", "PLANE_VEHICLE");
  level thread matchrecording_vehiclewatcher("matchrecording_chopper", "CHOPPER_VEHICLE");
}

matchrecording_getrecordingtype() {
  if(scripts\mp\utility\game::lpcfeaturegated() && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "conflict")
    return 0;

  type = getdvarint("scr_match_recording", 0);

  if(type == 0 && getdvarint("g_logenable", 0) == 1)
    type = 1;
  else if(analyticsstreamerislogfilestreamingenabled())
    type = 1;

  return type;
}

matchrecording_validaterecordingtype(_id_B0A68D1419F4B2A8) {
  result = 1;

  if(_id_B0A68D1419F4B2A8 == 0)
    result = 0;
  else if(_id_B0A68D1419F4B2A8 < 0 || _id_B0A68D1419F4B2A8 > 4)
    result = 0;
  else if(_id_B0A68D1419F4B2A8 == 3 || _id_B0A68D1419F4B2A8 == 4) {
    _id_1342032FE5B235A6 = 0;

    if(!_id_1342032FE5B235A6)
      result = 0;
  } else if(_id_B0A68D1419F4B2A8 == 1 || _id_B0A68D1419F4B2A8 == 2) {
    _id_0ACCDC2233AB9770 = getdvarint("g_logenable", 0);
    _id_5AE8370351E1A4A1 = analyticsstreamerislogfilestreamingenabled();
    result = _id_0ACCDC2233AB9770 == 1 || _id_5AE8370351E1A4A1 == 1;
  }

  return result;
}

matchrecording_isenabled() {
  return isDefined(level.matchrecording_type) && level.matchrecording_type > 0;
}

matchrecording_teammap(_id_FABF84450735DD93) {
  if(isDefined(level.teambased) && !level.teambased)
    result = 2;
  else if(!isDefined(_id_FABF84450735DD93) || _id_FABF84450735DD93 == "allies")
    result = 2;
  else
    result = 3;

  return result;
}

matchrecording_eventcharmap(event) {
  _id_96D176A367E72C83 = undefined;

  switch (event) {
    case "PATH":
      _id_96D176A367E72C83 = "p";
      break;
    case "SPAWN":
      _id_96D176A367E72C83 = "s";
      break;
    case "DEATH":
      _id_96D176A367E72C83 = "d";
      break;
    case "BULLET":
      _id_96D176A367E72C83 = "b";
      break;
    case "EXPLOSION":
      _id_96D176A367E72C83 = "e";
      break;
    case "ANCHOR":
      _id_96D176A367E72C83 = "t";
      break;
    case "FRONT_LINE":
      _id_96D176A367E72C83 = "l";
      break;
    case "FRONT_LINE_ALLIES":
      _id_96D176A367E72C83 = "[";
      break;
    case "FRONT_LINE_AXIS":
      _id_96D176A367E72C83 = "]";
      break;
    case "FLAG_A":
      _id_96D176A367E72C83 = "A";
      break;
    case "FLAG_B":
      _id_96D176A367E72C83 = "B";
      break;
    case "FLAG_C":
      _id_96D176A367E72C83 = "C";
      break;
    case "FLAG_D":
      _id_96D176A367E72C83 = "D";
      break;
    case "FLAG_E":
      _id_96D176A367E72C83 = "E";
      break;
    case "FLAG_0":
      _id_96D176A367E72C83 = "0";
      break;
    case "FLAG_1":
      _id_96D176A367E72C83 = "1";
      break;
    case "FLAG_2":
      _id_96D176A367E72C83 = "2";
      break;
    case "FLAG_3":
      _id_96D176A367E72C83 = "3";
      break;
    case "FLAG_4":
      _id_96D176A367E72C83 = "4";
      break;
    case "SPAWN_ENTITY":
      _id_96D176A367E72C83 = "S";
      break;
    case "PORTAL":
      _id_96D176A367E72C83 = "O";
      break;
    case "LOG_BAD_SPAWN":
      _id_96D176A367E72C83 = "!";
      break;
    case "LOG_GENERIC_MESSAGE":
      _id_96D176A367E72C83 = "m";
      break;
    case "LOG_USER_EVENT":
      _id_96D176A367E72C83 = "u";
      break;
    case "LOG_STAT":
      _id_96D176A367E72C83 = "?";
      break;
    case "PLAYER_NAME":
      _id_96D176A367E72C83 = "n";
      break;
    case "BEST_SPAWN_ALLIES":
      _id_96D176A367E72C83 = "+";
      break;
    case "BEST_SPAWN_AXIS":
      _id_96D176A367E72C83 = "^";
      break;
    case "GROUND_VEHICLE":
      _id_96D176A367E72C83 = "G";
      break;
    case "SMALL_GROUND_VEHICLE":
      _id_96D176A367E72C83 = "g";
      break;
    case "PLANE_VEHICLE":
      _id_96D176A367E72C83 = "V";
      break;
    case "CHOPPER_VEHICLE":
      _id_96D176A367E72C83 = "H";
      break;
    default:
      break;
  }

  return _id_96D176A367E72C83;
}

matchrecording_getfileheaderarray() {
  array = [];
  array[array.size] = "<mrec_start> \n";
  array[array.size] = "<mrec_map> " + level.script + "\n";
  array[array.size] = "<mrec_game_type> " + scripts\mp\utility\game::getgametype() + "\n";
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

matchrecording_logevent(_id_0619CF3736C12073, _id_FABF84450735DD93, event, x, y, _id_932081FF95E8CB30, _id_ECA15488BD96EDF9, _id_031EF7D754EBF53F, _id_BAA945E8FB3BA8AA) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  _id_AC9BF40E02D1BFCF = matchrecording_teammap(_id_FABF84450735DD93);
  xy = int(x) + "," + int(y);
  _id_96D176A367E72C83 = matchrecording_eventcharmap(event);

  if(event == "BULLET" || event == "FRONT_LINE" || event == "FRONT_LINE_ALLIES" || event == "FRONT_LINE_AXIS") {}

  _id_3378306339A5AA51 = "";

  if(isDefined(_id_ECA15488BD96EDF9))
    _id_3378306339A5AA51 = " s:" + _id_ECA15488BD96EDF9;

  _id_A9E08CCAA418B973 = "";

  if(isDefined(_id_031EF7D754EBF53F) && isDefined(_id_BAA945E8FB3BA8AA))
    _id_A9E08CCAA418B973 = " " + int(_id_031EF7D754EBF53F) + "," + int(_id_BAA945E8FB3BA8AA);

  _id_FDB35062CD12C096 = "|" + _id_0619CF3736C12073 + " " + _id_AC9BF40E02D1BFCF + " " + _id_96D176A367E72C83 + " " + xy + " " + _id_932081FF95E8CB30 + _id_A9E08CCAA418B973 + _id_3378306339A5AA51;
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + _id_FDB35062CD12C096;
}

matchrecording_logeventmsg(event, _id_932081FF95E8CB30, _id_E377539688C48F4B) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  _id_96D176A367E72C83 = matchrecording_eventcharmap(event);

  if(_id_E377539688C48F4B != "") {
    if(!isDefined(_id_E377539688C48F4B))
      _id_E377539688C48F4B = "";
    else
      _id_E377539688C48F4B = " \"" + _id_E377539688C48F4B + "\"";
  }

  _id_FDB35062CD12C096 = "|0 0 " + _id_96D176A367E72C83 + " " + _id_932081FF95E8CB30 + _id_E377539688C48F4B;
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + _id_FDB35062CD12C096;
}

matchrecording_logeventplayername(ownerid, _id_FABF84450735DD93, _id_64590709A63255BB) {
  if(!matchrecording_isenabled()) {
    return;
  }
  matchrecording_inceventlinecount();
  _id_AC9BF40E02D1BFCF = matchrecording_teammap(_id_FABF84450735DD93);
  _id_96D176A367E72C83 = matchrecording_eventcharmap("PLAYER_NAME");
  _id_FDB35062CD12C096 = "|" + ownerid + " " + _id_AC9BF40E02D1BFCF + " " + _id_96D176A367E72C83 + " " + "\"" + _id_64590709A63255BB + "\"";
  level.matchrecevents[level.matchrecevents.size - 1] = level.matchrecevents[level.matchrecevents.size - 1] + _id_FDB35062CD12C096;
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
    matchrecording_glog_addheader();

  foreach(_id_0BB0A0A84C7691F2 in level.matchrecevents) {
    logprint(_id_0BB0A0A84C7691F2 + "\n");

    if(analyticsstreamerislogfilestreamingenabled())
      analyticsstreamerlogfilewritetobuffer(_id_0BB0A0A84C7691F2 + "\n");
  }

  level.matchrecevents = [];
}

matchrecording_glog_addheader() {
  _id_4BD127F7A6C73DD2 = matchrecording_getfileheaderarray();

  foreach(h in _id_4BD127F7A6C73DD2) {
    logprint(h);

    if(analyticsstreamerislogfilestreamingenabled())
      analyticsstreamerlogfilewritetobuffer(h);
  }
}

matchrecording_scriptdata_openfilewrite() {}

matchrecording_scriptdata_openfileappend() {}

matchrecording_scriptdata_openfileaddheader(_id_5DCEFF890B44AD77) {}

matchrecording_scriptdata_dump() {}

matchrecording_logallplayerposthink() {
  if(!matchrecording_isenabled()) {
    return;
  }
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    _id_071DF66B50009254 = gettime();
    players = level.players;

    foreach(player in players) {
      time = gettime();

      if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player)) {
        matchrecording_logevent(player.clientid, player.team, "PATH", player.origin[0], player.origin[1], time);
        waitframe();
      }
    }

    wait(max(level.framedurationseconds, 1.5 - (gettime() - _id_071DF66B50009254) / 1000));
  }
}

matchrecording_onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread matchrecording_usereventthink();
  }
}

matchrecording_loggameendstats() {
  level waittill("game_ended");
  sidekillcount = 0;
  _id_25C32CEF8BE0663B = 0;
  _id_0176DA9F1546C225 = 0.0;
  engagementcount = 0;
  _id_E485E348B80BA43C = 0.0;

  foreach(player in level.players) {
    if(isDefined(player.sidekillcount))
      sidekillcount = player.sidekillcount;

    if(isDefined(player.engagementcount))
      engagementcount = player.engagementcount;

    if(isDefined(player.engagementtime))
      _id_E485E348B80BA43C = player.engagementtime;
  }

  if(engagementcount > 0) {
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Shot in the back percent: " + sidekillcount / engagementcount * 100.0 + "%");
    matchrecording_logeventmsg("LOG_STAT", gettime(), "Avg. Engagement Length: " + _id_E485E348B80BA43C / engagementcount / 1000.0 + "s");
  }

  if(isDefined(level.frontlineinfo) && isDefined(level.frontlineinfo.uptime) && isDefined(level.frontlineinfo.downtime)) {
    totaltime = level.frontlineinfo.uptime + level.frontlineinfo.downtime;

    if(totaltime > 0.0)
      matchrecording_logeventmsg("LOG_STAT", gettime(), "Frontline Uptime: " + level.frontlineinfo.uptime / totaltime * 100.0 + "%");
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
    _id_EA3E3B2121E6713A = scripts\engine\utility::waittill_any_return_no_endon_death_2("log_user_event_end", "log_user_event_generic_event");

    if(_id_EA3E3B2121E6713A == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      matchrecording_logeventmsg("LOG_USER_EVENT", gettime(), self.name);
    }
  }
}

matchrecording_generateid() {
  if(!isDefined(game["matchRecording_nextID"]))
    game["matchRecording_nextID"] = 100;

  _id_0FB1BE37BB7CDA28 = game["matchRecording_nextID"];
  game["matchRecording_nextID"]++;
  return _id_0FB1BE37BB7CDA28;
}

matchrecording_vehiclewatcher(_id_70687E0CC558A009, _id_E8E12C0A3441AD85) {
  level endon("game_ended");

  for(;;) {
    level waittill(_id_70687E0CC558A009, vehicle);
    vehicle matchrecording_vehicletrackingthink(_id_E8E12C0A3441AD85);
  }
}

matchrecording_vehicletrackingthink(_id_E8E12C0A3441AD85) {
  level endon("game_ended");
  self endon("death");
  _id_F794F29935653F3E = matchrecording_generateid();

  if(!isDefined(self.team)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no team");
    return;
  }

  if(!isDefined(self.origin)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no origin");
    return;
  }

  thread matchrecording_vehiclecleanupthink(_id_F794F29935653F3E, _id_E8E12C0A3441AD85);

  for(;;) {
    state = scripts\engine\utility::ter_op(self.team == "allies", 1, 2);
    matchrecording_logevent(_id_F794F29935653F3E, self.team, _id_E8E12C0A3441AD85, self.origin[0], self.origin[1], gettime(), state);
    wait 0.25;
  }
}

matchrecording_vehiclecleanupthink(logid, _id_E8E12C0A3441AD85) {
  level endon("game_ended");
  self waittill("death");
  matchrecording_logevent(logid, "allies", _id_E8E12C0A3441AD85, 0, 0, gettime(), 0);
}