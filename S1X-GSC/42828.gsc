/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42828.gsc
**************************************/

init() {
  if(level.rankedmatch && !(getdvarint("scr_game_division", 0) > 0)) {
    level thread onplayerconnect();
  }
}

onplayerconnect() {
  level endon("game_ended");
  level waittill("prematch_over");
  waitframe();

  foreach(var_1 in level.players) {
    if(isbot(var_1)) {
      continue;
    }
    var_1 resetreinforcements();
    var_1 thread checkforreinforcements();
  }

  for(;;) {
    level waittill("connected", var_1);

    if(isbot(var_1)) {
      continue;
    }
    var_1 resetreinforcements();
    var_1 thread checkforreinforcements();
  }
}

resetreinforcements() {
  self setclientomnvar("ui_reinforcement_timer_type", 0);
  self setclientomnvar("ui_reinforcement_timer", 0);
}

storependingreinforcement(var_0) {
  self.pers["reinforcements"] = spawnStruct();
  self.pers["reinforcements"].type = var_0;
  self.pers["reinforcements"].starttimepassed = maps\mp\_utility::getgametimepassedms();
}

cancelpendingreinforcement() {
  self.pers["reinforcements"].type = 0;
}

pendingreinforcementavailable() {
  return isDefined(self.pers["reinforcements"]);
}

checkforreinforcements() {
  self endon("disconnect");
  level endon("game_ended");

  if(!maps\mp\_utility::allowclasschoice()) {
    return;
  }
  if(self.health <= 0) {
    self waittill("spawned_player");
  }

  if(pendingreinforcementavailable()) {
    thread continuereinforcements();
    return;
  }

  var_0 = 0;

  if(maps\mp\_utility::practiceroundgame()) {
    var_0 = 4;
  } else {
    var_0 = self consumereinforcement();
  }

  storependingreinforcement(var_0);

  if(var_0 == 0) {
    return;
  }
  var_2 = gettimetoreinforcementfortypems(var_0);
  var_3 = gettimeremainingincludingrounds();

  if(var_3 < var_2) {
    cancelpendingreinforcement();
    return;
  }

  thread waitforreinforcementoftype(var_0, var_2);
}

continuereinforcements() {
  var_0 = self.pers["reinforcements"].type;

  if(var_0 == 0) {
    return;
  }
  var_1 = gettimetoreinforcementfortypems(var_0);
  var_2 = maps\mp\_utility::getgametimepassedms();
  var_3 = self.pers["reinforcements"].starttimepassed;
  var_1 = var_1 - var_2;
  var_1 = var_1 + var_3;
  thread waitforreinforcementoftype(var_0, var_1);
}

gettimeremainingincludingrounds() {
  if(maps\mp\_utility::isroundbased()) {
    var_0 = maps\mp\_utility::getscorelimit();
    var_1 = min(var_0 - maps\mp\_utility::getroundswon("allies"), var_0 - maps\mp\_utility::getroundswon("axis"));
    var_2 = maps\mp\_utility::gettimelimit() * var_1;
    return var_2 * 60 * 1000 - maps\mp\_utility::gettimepassed();
  } else {
    return maps\mp\gametypes\_gamelogic::gettimeremaining();
  }
}

gettimetoreinforcementfortypems(var_0) {
  switch (var_0) {
    case 1:
      return 120000;
    case 2:
      return 240000;
    case 3:
      return 360000;
    case 4:
      return 60000;
    default:
      break;
  }

  return 0;
}

geticontypeforreinforcementoftype(var_0) {
  switch (var_0) {
    case 1:
      return 1;
    case 2:
      return 2;
    case 3:
      return 3;
    case 4:
      return 1;
    default:
      break;
  }

  return 0;
}

getcarepackagestreakforreinforcementoftype(var_0) {
  switch (var_0) {
    case 1:
      return "airdrop_reinforcement_common";
    case 2:
      return "airdrop_reinforcement_uncommon";
    case 3:
      return "airdrop_reinforcement_rare";
    case 4:
      return "airdrop_reinforcement_practice";
    default:
      break;
  }

  return "";
}

waitforreinforcementoftype(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = geticontypeforreinforcementoftype(var_0);
  self setclientomnvar("ui_reinforcement_timer_type", var_2);
  self setclientomnvar("ui_reinforcement_timer", gettime() + var_1);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_1 / 1000.0);
  self setclientomnvar("ui_reinforcement_timer_type", 0);
  self setclientomnvar("ui_reinforcement_timer", 0);
  givereinforcementoftype(var_0);
}

givereinforcementoftype(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  var_1 = getcarepackagestreakforreinforcementoftype(var_0);
  var_2 = 500;
  var_3 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex(var_1);
  thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_1, var_2, undefined, undefined, var_3);
  maps\mp\killstreaks\_killstreaks::givekillstreak(var_1);
  cancelpendingreinforcement();
}