/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2032.gsc
*************************************************/

init() {
  var_0 = _id_9BD3();

  if(!_id_9BE6(var_0)) {
    return;
  } else {
    level._id_9BE4 = var_0;
  }

  level._id_9BCC = 0;
  level._id_9BCD = [];
  level._id_9BDA = ::_id_9BDA;
  level._id_9BDB = ::_id_9BDB;
  level._id_9BDC = ::_id_9BDC;
  level._id_9BCE = ::_id_9BCE;
  level._id_9BD1 = ::_id_9BD1;
  level._id_9BE5 = ::_id_9BE5;

  if(level._id_9BE4 == 1) {
    _id_9BD4();
  } else if(level._id_9BE4 == 3) {
    _id_9BE0(1);
  }

  level thread _id_9BD9();
  level thread _id_9BDE();
  level thread _id_9BDD();
  level thread _id_9BE9("matchrecording_ground_vehicle", "GROUND_VEHICLE");
  level thread _id_9BE9("matchrecording_small_ground_vehicle", "SMALL_GROUND_VEHICLE");
  level thread _id_9BE9("matchrecording_plane", "PLANE_VEHICLE");
  level thread _id_9BE9("matchrecording_chopper", "CHOPPER_VEHICLE");
}

_id_9BD3() {
  if(scripts\mp\utility\game::_id_98D3() && scripts\mp\utility\game::getgametype() != "arm") {
    return 0;
  }

  var_0 = getdvarint("#x3a981357292c5e32e", 0);

  if(var_0 == 0 && getdvarint("#x3bb08e97a87a7dcff", 0) == 1) {
    var_0 = 1;
  } else if(_func_0391()) {
    var_0 = 1;
  }

  return var_0;
}

_id_9BE6(var_0) {
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
    var_3 = getdvarint("#x3bb08e97a87a7dcff", 0);
    var_4 = _func_0391();
    var_1 = var_3 == 1 || var_4 == 1;
  }

  return var_1;
}

_id_9BD8() {
  return isDefined(level._id_9BE4) && level._id_9BE4 > 0;
}

_id_9BE3(var_0) {
  if(isDefined(level.teambased) && !level.teambased) {
    var_1 = 2;
  } else if(!isDefined(var_0) || var_0 == "allies") {
    var_1 = 2;
  } else {
    var_1 = 3;
  }

  return var_1;
}

_id_9BCF(var_0) {
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

_id_9BD2() {
  var_0 = [];
  var_0[var_0.size] = "<mrec_start> \n";
  var_0[var_0.size] = "<mrec_map> " + level.script + "\n";
  var_0[var_0.size] = "<mrec_game_type> " + scripts\mp\utility\game::getgametype() + "\n";
  var_0[var_0.size] = "<mrec_event_def> PATH p\n";
  var_0[var_0.size] = "<mrec_event_def> PATH_SPAWN s\n";
  var_0[var_0.size] = "<mrec_event_def> PATH_DEATH d\n";
  var_0[var_0.size] = "<mrec_event_def> PATH_BULLET b\n";
  var_0[var_0.size] = "<mrec_event_def> PATH_EXPLOSION e\n";
  var_0[var_0.size] = "<mrec_event_def> ANCHOR t\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_LINE l 255,0,0,0\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_LINE [ 255,255,127,0\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_LINE ] 255,0,255,255\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE A flagA.tga flagAallies.tga flagAaxis.tga\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE B flagB.tga flagBallies.tga flagBaxis.tga\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE C flagC.tga flagCallies.tga flagCaxis.tga\n";
  var_0[var_0.size] = "<mrec_event_def> SPAWN_ENTITY S\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE O flagAallies.tga flagAaxis.tga\n";
  var_0[var_0.size] = "<mrec_event_def> LOG_MESSAGE ! \"No good spawns found. Using bad spawn.\" \n";
  var_0[var_0.size] = "<mrec_event_def> LOG_MESSAGE m \"MSG: \" \n";
  var_0[var_0.size] = "<mrec_event_def> LOG_MESSAGE u \"User Event From \" \n";
  var_0[var_0.size] = "<mrec_event_def> LOG_MESSAGE ? \"STAT: \" \n";
  var_0[var_0.size] = "<mrec_event_def> PLAYER_NAME n\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE + bestSpawnAllies.tga\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE ^ bestSpawnAxis.tga\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE G blank.tga groundVehicleAllies.tga groundVehicleAxis.tga\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE g blank.tga smallGroundVehicleAllies.tga smallGroundVehicleAxis.tga\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE H blank.tga chopperAllies.tga chopperAxis.tga\n";
  var_0[var_0.size] = "<mrec_event_def> GENERIC_IMAGE V blank.tga planeAllies.tga planeAxis.tga\n";
  return var_0;
}

_id_9BDA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!_id_9BD8()) {
    return;
  }
  _id_9BD6();
  var_9 = _id_9BE3(var_1);
  var_10 = int(var_3) + "," + int(var_4);
  var_11 = _id_9BCF(var_2);

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
  level._id_9BCD[level._id_9BCD.size - 1] = level._id_9BCD[level._id_9BCD.size - 1] + var_14;
}

_id_9BDB(var_0, var_1, var_2) {
  if(!_id_9BD8()) {
    return;
  }
  _id_9BD6();
  var_3 = _id_9BCF(var_0);

  if(var_2 != "") {
    if(!isDefined(var_2)) {
      var_2 = "";
    } else {
      var_2 = " \"" + var_2 + "\"";
    }
  }

  var_4 = "|0 0 " + var_3 + " " + var_1 + var_2;
  level._id_9BCD[level._id_9BCD.size - 1] = level._id_9BCD[level._id_9BCD.size - 1] + var_4;
}

_id_9BDC(var_0, var_1, var_2) {
  if(!_id_9BD8()) {
    return;
  }
  _id_9BD6();
  var_3 = _id_9BE3(var_1);
  var_4 = _id_9BCF("PLAYER_NAME");
  var_5 = "|" + var_0 + " " + var_3 + " " + var_4 + " " + "\"" + var_2 + "\"";
  level._id_9BCD[level._id_9BCD.size - 1] = level._id_9BCD[level._id_9BCD.size - 1] + var_5;
}

_id_9BD6() {
  level._id_9BCC++;

  if(level._id_9BCD.size == 0) {
    level._id_9BCD[level._id_9BCD.size] = "<mrec_events> ";
    level._id_9BCC = 0;
  } else if(level._id_9BCC > 30 || level._id_9BCD[level._id_9BCD.size - 1].size > 800) {
    if(level._id_9BE4 == 1 || level._id_9BE4 == 3) {
      _id_9BCE();
    }

    level._id_9BCD[level._id_9BCD.size] = "<mrec_events> ";
    level._id_9BCC = 0;
  }
}

_id_9BCE() {
  if(!_id_9BD8()) {
    return;
  }
  if(!isDefined(level._id_9BCD) || level._id_9BCD.size == 0) {
    return;
  }
  switch (level._id_9BE4) {
    case 2:
    case 1:
      _id_9BD5();
      break;
    case 4:
    case 3:
      _id_9BDF();
      break;
    default:
      break;
  }
}

_id_9BD5() {
  if(level._id_9BE4 == 2) {
    _id_9BD4();
  }

  foreach(var_1 in level._id_9BCD) {
    _func_0140(var_1 + "\n");

    if(_func_0391()) {
      _func_038F(var_1 + "\n");
    }
  }

  level._id_9BCD = [];
}

_id_9BD4() {
  var_0 = _id_9BD2();

  foreach(var_2 in var_0) {
    _func_0140(var_2);

    if(_func_0391()) {
      _func_038F(var_2);
    }
  }
}

_id_9BE2() {}

_id_9BE1() {}

_id_9BE0(var_0) {}

_id_9BDF() {}

_id_9BD9() {
  if(!_id_9BD8()) {
    return;
  }
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    var_0 = gettime();
    var_1 = level.players;

    foreach(var_3 in var_1) {
      var_4 = gettime();

      if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3)) {
        _id_9BDA(var_3._id_399D, var_3.team, "PATH", var_3.origin[0], var_3.origin[1], var_4);
        waitframe();
      }
    }

    wait(max(level._id_5F3A, 1.5 - (gettime() - var_0) / 1000));
  }
}

_id_9BDE() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_9BE5();
  }
}

_id_9BDD() {
  level waittill("game_ended");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0.0;
  var_3 = 0;
  var_4 = 0.0;

  foreach(var_6 in level.players) {
    if(isDefined(var_6._id_DD1A)) {
      var_0 = var_6._id_DD1A;
    }

    if(isDefined(var_6._id_5455)) {
      var_3 = var_6._id_5455;
    }

    if(isDefined(var_6._id_5457)) {
      var_4 = var_6._id_5457;
    }
  }

  if(var_3 > 0) {
    _id_9BDB("LOG_STAT", gettime(), "Shot in the back percent: " + var_0 / var_3 * 100.0 + "%");
    _id_9BDB("LOG_STAT", gettime(), "Avg. Engagement Length: " + var_4 / var_3 / 1000.0 + "s");
  }

  if(isDefined(level._id_5FDF) && isDefined(level._id_5FDF._id_FDAC) && isDefined(level._id_5FDF._id_4EBB)) {
    var_8 = level._id_5FDF._id_FDAC + level._id_5FDF._id_4EBB;

    if(var_8 > 0.0) {
      _id_9BDB("LOG_STAT", gettime(), "Frontline Uptime: " + level._id_5FDF._id_FDAC / var_8 * 100.0 + "%");
    }
  }
}

_id_9BE5() {
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
    var_0 = scripts\engine\utility::_id_1089F("log_user_event_end", "log_user_event_generic_event");

    if(var_0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      _id_9BDB("LOG_USER_EVENT", gettime(), self.name);
    }
  }
}

_id_9BD1() {
  if(!isDefined(game["matchRecording_nextID"])) {
    game["matchRecording_nextID"] = 100;
  }

  var_0 = game["matchRecording_nextID"];
  game["matchRecording_nextID"]++;
  return var_0;
}

_id_9BE9(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    level waittill(var_0, var_2);
    var_2 _id_9BE8(var_1);
  }
}

_id_9BE8(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = _id_9BD1();

  if(!isDefined(self.team)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no team");
    return;
  }

  if(!isDefined(self.origin)) {
    iprintln("MatchRecording - Can't log vehicle, because it has no origin");
    return;
  }

  thread _id_9BE7(var_1, var_0);

  for(;;) {
    var_2 = scripts\engine\utility::ter_op(self.team == "allies", 1, 2);
    _id_9BDA(var_1, self.team, var_0, self.origin[0], self.origin[1], gettime(), var_2);
    wait 0.25;
  }
}

_id_9BE7(var_0, var_1) {
  level endon("game_ended");
  self waittill("death");
  _id_9BDA(var_0, "allies", var_1, 0, 0, gettime(), 0);
}