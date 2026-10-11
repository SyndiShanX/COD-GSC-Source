/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\game.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\cranked;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\matchdata;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace game_utility;

function getotherteam(team) {
  return getenemyteams(team);
}

function getroundlength() {
  if(!isDefined(level.starttime)) {
    return 0;
  }

  return gettime() - level.starttime;
}

function getgamelength() {
  if(!isDefined(game["gameLength"])) {
    return 0;
  }

  return getroundlength() + game["gameLength"];
}

function gettimepassedpercentage() {
  timelimit = gettimelimit();

  if(timelimit == 0) {
    return 0;
  }

  return gettimepassed() / gettimelimit() * 1000 * 100;
}

function getsecondspassed() {
  return gettimepassed() / 1000;
}

function getminutespassed() {
  return getsecondspassed() / 60;
}

function setuipostgamefade(fadetoblack, delay) {
  self endon("disconnect");

  if(istrue(level.nukeinfo.detonated)) {
    return;
  }

  if(istrue(level.var_ebb6ebb71ce4a007)) {
    return;
  }

  if(isDefined(self.var_a1192fa9f37ce26d) && self.var_a1192fa9f37ce26d == fadetoblack) {
    return;
  }

  if(!fadetoblack && !istrue(self.var_a1192fa9f37ce26d)) {
    return;
  }

  if(isDefined(delay)) {
    wait delay;
  }

  self.var_a1192fa9f37ce26d = fadetoblack;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, fadetoblack, 0.5);
}

function registerroundswitchdvar(dvarstring, defaultvalue, minvalue, maxvalue) {
  registerwatchdvarint("roundswitch", defaultvalue);
  dvarstring = hashcat(@ "scr_", dvarstring, "_roundswitch");
  level.roundswitchdvar = dvarstring;
  level.roundswitchmin = minvalue;
  level.roundswitchmax = maxvalue;
  level.roundswitch = getdvarint(dvarstring, defaultvalue);

  if(level.roundswitch < minvalue) {
    level.roundswitch = minvalue;
    return;
  }

  if(level.roundswitch > maxvalue) {
    level.roundswitch = maxvalue;
  }
}

function registerroundlimitdvar(dvarstring, defaultvalue) {
  registerwatchdvarint("roundlimit", defaultvalue);
}

function registernumteamsdvar(dvarstring, defaultvalue) {
  registerwatchdvarint("numTeams", defaultvalue);
}

function registerwinlimitdvar(dvarstring, defaultvalue) {
  registerwatchdvarint("winlimit", defaultvalue);
}

function registerwinbytwoenableddvar(dvarstring, defaultvalue) {
  registerwatchdvarint("winbytwoenabled", defaultvalue);
}

function registerwinbytwomaxroundsdvar(dvarstring, defaultvalue) {
  registerwatchdvarint("winbytwomaxrounds", defaultvalue);
}

function registerdogtagsenableddvar(dvarstring, defaultvalue) {
  registerwatchdvarint("dogtags", defaultvalue);
}

function registerscorelimitdvar(dvarstring, defaultvalue) {
  registerwatchdvarint("scorelimit", defaultvalue);
}

function registertimelimitdvar(dvarstring, defaultvalue) {
  registerwatchdvarfloat("timelimit", defaultvalue);
  setDvar(@ "ui_timelimit", gettimelimit());
}

function registerhalftimedvar(dvarstring, defaultvalue) {
  registerwatchdvarint("halftime", defaultvalue);
  setDvar(@ "ui_halftime", gethalftime());
}

function registernumlivesdvar(dvarstring, defaultvalue) {
  registerwatchdvarint("numlives", defaultvalue);
}

function registernumrevivesdvar(dvarstring, defaultvalue) {
  registerwatchdvarint("numrevives", defaultvalue);
}

function function_704789086c9ad943(dvarstring, defaultvalue) {
  registerwatchdvarint("pointsPerKill", defaultvalue);
}

function setovertimelimitdvar(value) {
  setDvar(@ "overtimetimelimit", value);
}

function registerlaststandhealthdvar(defaultvalue) {
  registerwatchdvarint("lastStandHealth", defaultvalue);
}

function registerlaststandrevivehealthdvar(defaultvalue) {
  registerwatchdvarint("lastStandReviveHealth", defaultvalue);
}

function registerlaststandtimerdvar(defaultvalue) {
  registerwatchdvarfloat("lastStandTimer", defaultvalue);
}

function registerlaststandrevivetimerdvar(defaultvalue) {
  registerwatchdvarfloat("lastStandReviveTimer", defaultvalue);
}

function registerlaststandweapondvar(defaultvalue) {
  registerwatchdvar("lastStandWeapon", defaultvalue);
}

function registerlaststandweapondelaydvar(defaultvalue) {
  registerwatchdvarfloat("lastStandWeaponDelay", defaultvalue);
}

function registerlaststandsuicidetimerdvar(defaultvalue) {
  registerwatchdvarfloat("lastStandSuicideTimer", defaultvalue);
}

function registerlaststandinvulntimerdvar(defaultvalue) {
  registerwatchdvarfloat("lastStandInvulnTimer", defaultvalue);
}

function registerlaststandrevivedecayscaledvar(defaultvalue) {
  registerwatchdvarfloat("lastStandReviveDecayScale", defaultvalue);
}

function function_65c4cae95d0c833b(defaultvalue) {
  registerwatchdvarint("teamReviveHealth", defaultvalue);
}

function function_c2bd90ff953a0ce4(defaultvalue) {
  registerwatchdvarfloat("teamReviveTime", defaultvalue);
}

function function_2597b9cd72447cb6(defaultvalue) {
  registerwatchdvarfloat("teamReviveTimeout", defaultvalue);
}

function isroundbased() {
  if(!level.teambased) {
    return false;
  }

  if(level.winlimit != 1 && level.roundlimit != 1) {
    return true;
  }

  if(getgametype() == "sr" || getbasegametype() == "sd" || getgametype() == "siege" || getgametype() == "cyber" || getgametype() == "mtmc" || getbasegametype() == "control" || getgametype() == "wm") {
    return true;
  }

  return false;
}

function isfirstround() {
  if(!level.teambased) {
    return true;
  }

  if(game["roundsPlayed"] == 0) {
    return true;
  }

  return false;
}

function nextroundisfinalround() {
  if(level.forcedend) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  if(level.roundlimit > 1 && game["roundsPlayed"] >= level.roundlimit - 1 && !istimetobeatrulegametype() && !isscoretobeatrulegametype()) {
    return true;
  }

  if(isovertimesupportedgametype() && (hitroundlimit() || hitwinlimit())) {
    if(shouldplaywinbytwo() && islastwinbytwo()) {
      return true;
    } else if(istimetobeatrulegametype() || isscoretobeatrulegametype()) {
      if(game["overtimeRoundsPlayed"] == 1) {
        return true;
      }
    } else if(!level.playovertime) {
      return true;
    }
  }

  var_1aa7d78f771c4fe = 0;

  foreach(entry in level.teamnamelist) {
    roundswon = getroundswon(entry);

    if(roundswon == level.winlimit - 1) {
      var_1aa7d78f771c4fe = 1;
      break;
    }
  }

  var_2e8dfeaa03398ee5 = level.winlimit > 0 && var_1aa7d78f771c4fe;

  if(var_2e8dfeaa03398ee5 && allteamstied()) {
    if(isovertimesupportedgametype()) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function nextroundismatchpoint() {
  if(level.forcedend) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  if(level.roundlimit > 1 && game["roundsPlayed"] >= level.roundlimit - 1 && !istimetobeatrulegametype() && !isscoretobeatrulegametype()) {
    return true;
  }

  if(isovertimesupportedgametype() && (hitroundlimit() || hitwinlimit())) {
    if(shouldplaywinbytwo() && islastwinbytwo()) {
      return true;
    } else if(istimetobeatrulegametype() || isscoretobeatrulegametype()) {
      if(game["overtimeRoundsPlayed"] == 1) {
        return true;
      }
    } else if(!level.playovertime) {
      return true;
    }
  }

  var_1aa7d78f771c4fe = 0;

  foreach(entry in level.teamnamelist) {
    roundswon = getroundswon(entry);

    if(roundswon == level.winlimit - 1) {
      if(shouldplaywinbytwo() && istrue(game["displayedMatchPoint"])) {
        game["displayedMatchPoint"] = 0;
      }

      return true;
    }
  }

  return false;
}

function wasonlyround() {
  if(level.playovertime) {
    return false;
  }

  if(!level.teambased) {
    return true;
  }

  if(isDefined(level.onlyroundoverride)) {
    return false;
  }

  if(level.winlimit == 1 && hitwinlimit()) {
    return true;
  }

  if(level.roundlimit == 1) {
    return true;
  }

  return false;
}

function waslastround() {
  if(level.forcedend) {
    return true;
  }

  if(isDefined(level.nukeinfo) && istrue(level.nukeinfo.gameover)) {
    return true;
  }

  if(istrue(level.ctfnukeended)) {
    return true;
  }

  if(wasonlyround()) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  if(ismutationgamemode() && game["roundsPlayed"] == 1) {
    return false;
  }

  if(hitroundlimit() || hitwinlimit()) {
    return !level.playovertime;
  }

  if(getgametype() == "ballmode") {
    if(game["status"] == "overtime") {
      return true;
    }

    timeremaining = scripts\mp\gamelogic::gettimeremaining();

    if(timeremaining <= 0) {
      return true;
    }
  }

  if(getgametype() == "wm" || ismutationgamemode()) {
    if(game["roundsPlayed"] == 2) {
      return true;
    }
  }

  return false;
}

function iswinbytworulegametype() {
  switch (getgametype()) {
    case #"hash_53825b446469ac4c":
    case #"hash_5ff8e011d5b9d1c8":
    case #"hash_aac44b0b52bacb8e":
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
      return (getdvarint(hashcat(@ "scr_", getgametype(), "_winByTwoEnabled"), 0) == 1);
  }

  return false;
}

function getmaxwinbytworounds() {
  return getdvarint(hashcat(@ "scr_", getgametype(), "_winByTwoMaxRounds"), level.winlimit);
}

function shouldplaywinbytwo() {
  alliesscore = game["roundsWon"]["allies"];
  axisscore = game["roundsWon"]["axis"];
  return iswinbytworulegametype() && abs(alliesscore - axisscore) < 2 && game["overtimeRoundsPlayed"] < getmaxwinbytworounds();
}

function islastwinbytwo() {
  return shouldplaywinbytwo() && game["overtimeRoundsPlayed"] == getmaxwinbytworounds() - 1;
}

function function_2f1b2a4a64257bea() {
  alliesscore = game["roundsWon"]["allies"];
  axisscore = game["roundsWon"]["axis"];
  return abs(alliesscore - axisscore) < 2;
}

function istimetobeatrulegametype() {
  switch (getgametype()) {
    case #"hash_1a5d186c17c00d3c":
    case #"hash_51347b2eb89b24c4":
    case #"hash_c749446269c21985":
      return true;
  }

  return false;
}

function intimetobeat() {
  return isDefined(game["status"]) && game["status"] == "recordTTB";
}

function settimetobeat(team) {
  if(!istimetobeatrulegametype()) {
    return false;
  }

  captime = getsecondspassed();
  score = scripts\mp\gamescore::_getteamscore(team);

  if(!istimetobeatvalid() || captime < game["timeToBeat"] && score >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != team) {
      game["timeToBeatOld"] = game["timeToBeat"];
    }

    game["timeToBeat"] = captime;
    game["timeToBeatTeam"] = team;
    game["timeToBeatScore"] = score;
    return true;
  }

  return false;
}

function istimetobeatvalid() {
  return game["timeToBeat"] != 0;
}

function shouldplaytimetobeatot() {
  return istimetobeatvalid() && game["overtimeRoundsPlayed"] == 1;
}

function isscoretobeatrulegametype() {
  switch (getgametype()) {
    case #"hash_8eb3658fb4985833":
      return true;
  }

  return false;
}

function setscoretobeat(team, score) {
  if(!isscoretobeatrulegametype()) {
    return 0;
  }

  istied = game["timeToBeatTeam"] != "none" && score == game["timeToBeatScore"];

  if(score >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != team) {
      game["timeToBeatScoreOld"] = game["timeToBeatScore"];
    }

    game["timeToBeatTeam"] = team;
    game["timeToBeatScore"] = score;
  }

  foreach(player in level.players) {
    player setclientomnvar("ui_friendly_time_to_beat", ter_op(player.team == game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
    player setclientomnvar("ui_enemy_time_to_beat", ter_op(player.team != game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
  }

  if(istied) {
    return "tie";
  }

  return game["timeToBeatTeam"];
}

function shouldplayscoretobeatot() {
  return isscoretobeatrulegametype() && game["overtimeRoundsPlayed"] == 1;
}

function isovertimesupportedgametype() {
  switch (getgametype()) {
    case #"hash_1e4846dca3ccf38":
    case #"hash_1a5d186c17c00d3c":
    case #"hash_1aac086c17fe5ccb":
    case #"hash_51347b2eb89b24c4":
    case #"hash_68e111ac56792b24":
    case #"hash_8eb3658fb4985833":
    case #"hash_a4803151db9c2947":
    case #"hash_c749446269c21985":
      return true;
    case #"hash_53825b446469ac4c":
    case #"hash_5ff8e011d5b9d1c8":
    case #"hash_aac44b0b52bacb8e":
    case #"hash_dd217fc2f74cbcdd":
    case #"hash_fa0ed2f6bd4f4395":
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
      return iswinbytworulegametype();
  }

  return false;
}

function getmaxovertimeroundsbygametype() {
  var_8127e47e743e3a3f = 0;

  switch (getgametype()) {
    case #"hash_1a5d186c17c00d3c":
    case #"hash_51347b2eb89b24c4":
    case #"hash_53825b446469ac4c":
    case #"hash_68e111ac56792b24":
    case #"hash_aac44b0b52bacb8e":
    case #"hash_c749446269c21985":
    case #"hash_dd217fc2f74cbcdd":
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
      var_8127e47e743e3a3f = 2;
      break;
    case #"hash_1e4846dca3ccf38":
    case #"hash_1aac086c17fe5ccb":
    case #"hash_a4803151db9c2947":
    case #"hash_b9aaf1c4459d9a15":
    case #"hash_fa0ed2f6bd4f4395":
      var_8127e47e743e3a3f = 1;
      break;
  }

  if(isanymlgmatch() && !istimetobeatrulegametype()) {
    return -1;
  }

  return var_8127e47e743e3a3f;
}

function getwingamebytype() {
  if(!isDefined(level.wingamebytype)) {
    if(!isroundbased() || !isobjectivebased() || ismoddedroundgame()) {
      level.wingamebytype = "teamScores";
    } else {
      level.wingamebytype = "roundsWon";
    }
  }

  return level.wingamebytype;
}

function issimultaneouskillenabled() {
  if(!isDefined(level.simultaneouskillenabled)) {
    level.simultaneouskillenabled = getdvarint(@ "killswitch_simultaneous_deaths", 0) == 0;
  }

  return level.simultaneouskillenabled;
}

function cantiebysimultaneouskill() {
  if(!issimultaneouskillenabled()) {
    return 0;
  }

  cantie = 0;

  switch (getgametype()) {
    case #"hash_ca6516c10db2c95":
    case #"hash_4b8799075d3a89b8":
    case #"hash_7485fa6c474ec865":
    case #"hash_7f9c384a34cc392f":
    case #"hash_8f01ce022684fbc8":
    case #"hash_bc5ad0664c3cc103":
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fb5b5e6c07253005":
      cantie = 1;
      break;
  }

  return cantie;
}

function shouldplayovertime() {
  tied = allteamstied();

  if(!hitroundlimit() && !hitwinlimit()) {
    return false;
  }

  if(!isovertimesupportedgametype()) {
    return false;
  }

  if(tied && inovertime()) {
    var_178e9c557e11fb83 = getmaxovertimeroundsbygametype();
    tied = ter_op(var_178e9c557e11fb83 == -1, 1, game["overtimeRoundsPlayed"] < var_178e9c557e11fb83);
  }

  var_b564bf7a9922b991 = shouldplaywinbytwo();
  var_4b3eea7964b200d2 = shouldplaytimetobeatot();
  var_974ea582db790ced = shouldplayscoretobeatot();
  return !level.forcedend && (tied || var_b564bf7a9922b991 || var_4b3eea7964b200d2 || var_974ea582db790ced);
}

function resetscoreonroundstart() {
  if(isDefined(level.resetscoreonroundstart)) {
    return [[level.resetscoreonroundstart]](inovertime());
  }

  return (getgametype() == "ctf" || getgametype() == "blitz") && !inovertime() && getwingamebytype() == "roundsWon";
}

function canplayhalfwayvo() {
  if(!isDefined(level.didhalfscorevoboost)) {
    level.didhalfscorevoboost = 0;
  }

  if(level.didhalfscorevoboost) {
    return 0;
  }

  switch (getgametype()) {
    case #"hash_1e4846dca3ccf38":
    case #"hash_7e89154a96f625d":
    case #"hash_ca6516c10db2c95":
    case #"hash_3a17de6e294210d2":
    case #"hash_4b8799075d3a89b8":
    case #"hash_51347b2eb89b24c4":
    case #"hash_6efb0f59a62300fb":
    case #"hash_7485fa6c474ec865":
    case #"hash_7f9c384a34cc392f":
    case #"hash_8c758b84936e8d42":
    case #"hash_8f01ce022684fbc8":
    case #"hash_b9458959b10637f8":
    case #"hash_bc5ad0664c3cc103":
    case #"hash_dd5b900f435d3f36":
    case #"hash_ddd385f0a27d71bb":
    case #"hash_e9037b8a10fb8a14":
    case #"hash_ea061d29bbd1f237":
    case #"hash_ec24570718a340f5":
    case #"hash_ec72fd25bbbac99e":
    case #"hash_f4a9126c03d3385b":
    case #"hash_fa0ed2f6bd4f4395":
    case #"hash_fa0ed9f6bd4f4e9a":
    case #"hash_fa34c5f6bd6d4432":
      return 1;
    case #"hash_1a5d186c17c00d3c":
    case #"hash_53825b446469ac4c":
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
    case #"hash_fb5b5e6c07253005":
      return 0;
    default:
      return 0;
  }
}

function hittimelimit() {
  if(getwatcheddvar("timelimit") <= 0) {
    return false;
  }

  timeleft = scripts\mp\gamelogic::gettimeremaining();

  if(timeleft > 0) {
    return false;
  }

  return true;
}

function hitroundlimit() {
  if(level.roundlimit <= 0) {
    return false;
  }

  return game["roundsPlayed"] >= level.roundlimit;
}

function hitscorelimit() {
  if(isobjectivebased()) {
    return false;
  }

  if(level.roundscorelimit <= 0) {
    return false;
  }

  if(level.teambased) {
    foreach(entry in level.teamnamelist) {
      if(game["teamScores"][entry] >= level.roundscorelimit) {
        return true;
      }
    }
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];

      if(isDefined(player.score) && player.score >= level.roundscorelimit) {
        return true;
      }
    }
  }

  return false;
}

function hitwinlimit() {
  if(level.winlimit <= 0) {
    return false;
  }

  if(!level.teambased) {
    return true;
  }

  foreach(entry in level.teamnamelist) {
    if(getroundswon(entry) >= level.winlimit) {
      return true;
    }
  }

  return false;
}

function getscorelimit() {
  if(isroundbased()) {
    if(level.roundlimit) {
      return level.roundlimit;
    } else {
      return level.winlimit;
    }

    return;
  }

  return level.roundscorelimit;
}

function getroundswon(team) {
  return game["roundsWon"][team];
}

function allteamstied() {
  wingamebytype = getwingamebytype();
  winvalue = undefined;

  foreach(entry in level.teamnamelist) {
    if(!isDefined(winvalue)) {
      winvalue = game[wingamebytype][entry];
      continue;
    }

    if(winvalue != game[wingamebytype][entry]) {
      return false;
    }
  }

  return true;
}

function isobjectivebased() {
  return level.objectivebased;
}

function gettimelimit() {
  if(inovertime() && (!isDefined(game["inNukeOvertime"]) || !game["inNukeOvertime"])) {
    if(istrue(game["timeToBeat"])) {
      return game["timeToBeat"];
    } else {
      overtimelimit = getdvarfloat(@ "overtimetimelimit");

      if(overtimelimit > 0) {
        return overtimelimit;
      } else {
        return getwatcheddvar("timelimit");
      }
    }

    return;
  }

  if(isDefined(level.extratime) && level.extratime > 0) {
    return (getwatcheddvar("timelimit") + level.extratime);
  }

  return getwatcheddvar("timelimit");
}

function gethalftime() {
  if(inovertime()) {
    return 0;
  }

  if(isDefined(game["inNukeOvertime"]) && game["inNukeOvertime"]) {
    return 0;
  }

  return getwatcheddvar("halftime");
}

function inovertime() {
  return isDefined(game["status"]) && game["status"] == "overtime";
}

function gamehasstarted() {
  if(isDefined(level.gamehasstarted)) {
    return level.gamehasstarted;
  }

  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      if(getteamdata(team, "hasSpawned")) {
        return 1;
      }
    }

    return 0;
  }

  return level.maxplayercount > 1;
}

function getlivingplayers(team) {
  player_array = [];

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }

    if(level.teambased && isDefined(team)) {
      if(team == player.pers["team"]) {
        player_array[player_array.size] = player;
      }

      continue;
    }

    player_array[player_array.size] = player;
  }

  return player_array;
}

function rankingenabled() {
  if(!isPlayer(self)) {
    return false;
  }

  return level.rankedmatch && !self.usingonlinedataoffline;
}

function onlinestatsenabled() {
  if(!isPlayer(self)) {
    return false;
  }

  return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

function privatematch() {
  return level.onlinegame && getdvarint(@ "xblive_privatematch");
}

function lobbyteamselectenabled() {
  return level.systemlink || privatematch() && getdvarint(@ "hash_eb8b825937d54d97", 0) || function_1eb7d2791d3c536f();
}

function matchmakinggame() {
  return level.matchmakingmatch;
}

function getgametypenumlives() {
  return getwatcheddvar("numlives");
}

function islifelimited() {
  if(!isDefined(level.numlifelimited)) {
    level.numlifelimited = getgametypenumlives();
  }

  return level.numlifelimited;
}

function getlastlivingplayer(team) {
  liveplayer = undefined;

  foreach(player in level.players) {
    if(isDefined(team) && player.team != team) {
      continue;
    }

    if(!player scripts\cp_mp\utility\player_utility::_isalive() && !player scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(isDefined(player.switching_teams) && player.switching_teams) {
      continue;
    }

    assertex(!isDefined(liveplayer), "<dev string:x1c>");
    liveplayer = player;
  }

  return liveplayer;
}

function trygetlastpotentiallivingplayer() {
  liveplayer = undefined;

  foreach(player in level.players) {
    if(!player scripts\cp_mp\utility\player_utility::_isalive() && !player scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(istrue(level.codcasterenabled)) {
      if(player iscodcaster()) {
        continue;
      }
    }

    if(isDefined(liveplayer)) {
      return undefined;
    }

    liveplayer = player;
  }

  if(isDefined(liveplayer)) {
    return liveplayer;
  }

  return undefined;
}

function getpotentiallivingplayers() {
  liveplayers = [];

  foreach(player in level.players) {
    if(!player scripts\cp_mp\utility\player_utility::_isalive() && !player scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(istrue(level.codcasterenabled)) {
      if(player iscodcaster()) {
        continue;
      }
    }

    liveplayers[liveplayers.size] = player;
  }

  return liveplayers;
}

function denysystemicteamchoice() {
  if(!isbot(self) && !istestclient(self)) {
    if(isintournament()) {
      return true;
    }

    if(istrue(level.codcasterenabled)) {
      return false;
    }
  }

  if(getdvarint(@ "hash_c11db9baa9e5bc9b", 0) > 0) {
    return true;
  }

  return false;
}

function allowteamassignment() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return level.teambased;
  }

  allowed = doesmodesupportplayerteamchoice();
  return allowed;
}

function doesmodesupportplayerteamchoice() {
  if(getdvarint(@ "hash_78653010d584aa6e", 0) == 0) {
    if(getgametype() == "gun" || scripts\cp_mp\utility\game_utility::isinfectedgametype()) {
      return false;
    }

    allowed = int(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 4));
    assert(isDefined(allowed));
    return (allowed > 0);
  }

  return istrue(level.gametypebundle.allowteamchoice);
}

function allowclasschoice() {
  if(getdvarint(@ "hash_c11db9baa9e5bc9b", 0) > 0) {
    return 0;
  }

  if(getdvarint(@ "hash_f195e306ffa755d0", 0) == 1) {
    return 0;
  }

  if(isDefined(level.allowclasschoicefunc)) {
    callbackresult = self[[level.allowclasschoicefunc]]();

    if(isDefined(callbackresult)) {
      return callbackresult;
    }
  }

  if(gameflag("infil_will_run") && isDefined(level.bypassclasschoicefunc)) {
    return 0;
  }

  if(istrue(level.denyclasschoice)) {
    return 0;
  }

  if(getdvarint(@ "hash_78653010d584aa6e", 0) == 0) {
    allowed = int(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 5));
    assert(isDefined(allowed));
    return allowed;
  }

  return istrue(level.gametypebundle.allowclasschoice);
}

function showfakeloadout() {
  return false;
}

function setfakeloadoutweaponslot(sweapon, var_7ebc888be394a18e) {
  weaponname = scripts\cp_mp\weapon::getweaponrootname(sweapon);
  attachments = [];

  if(weaponname != "iw8_knife") {
    attachments = getweaponattachments(sweapon);
  }

  for(i = 0; i < 3; i++) {
    var_b519f801a23677bf = -1;

    if(isDefined(attachments[i])) {
      if(!scripts\mp\utility\weapon::isattachmentsniperscopedefault(sweapon, attachments[i])) {
        var_b519f801a23677bf = tablelookuprownum("mp/attachmenttable.csv", 4, attachments[i]);
      }
    }
  }
}

function setcommonrulesfrommatchrulesdata(skipfriendlyfire) {
  teamcount = getmatchrulesdata("commonOption", "teamCount");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_teamcount"), teamcount);
  teamsize = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_teamsize"), teamsize);

  if(isDefined(level.var_d5afb09cfde5ee65) && (getgametype() == "defuse" || getgametype() == "hc_defuse")) {
    timelimit = level.var_d5afb09cfde5ee65;
  } else {
    timelimit = getmatchrulesdata("commonOption", "timeLimit");
  }

  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 1) {
    println("<dev string:x5e>");

    if(isDefined(game["gameStateRestore"]) && game["gameStateRestore"].enabled) {
      println("<dev string:x7f>");
      timelimit = game["gameStateRestore"].gametime;
    }
  }

  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_timeLimit"), timelimit);
  registertimelimitdvar(getgametype(), timelimit);
  level.initialtimelimit = timelimit;
  scorelimit = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_scoreLimit"), scorelimit);
  registerscorelimitdvar(getgametype(), scorelimit);
  winlimit = getmatchrulesdata("commonOption", "winLimit");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_winLimit"), winlimit);
  registerwinlimitdvar(getgametype(), winlimit);
  roundlimit = getmatchrulesdata("commonOption", "roundLimit");

  if(ismutationgamemode()) {
    roundlimit = 2;
  }

  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_roundLimit"), roundlimit);
  registerroundlimitdvar(getgametype(), roundlimit);
  roundswitch = getmatchrulesdata("commonOption", "roundSwitch");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_roundSwitch"), roundswitch);
  registerroundswitchdvar(getgametype(), roundswitch, 0, 9);
  winbytwoenabled = getmatchrulesdata("commonOption", "winByTwoEnabled");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_winByTwoEnabled"), winbytwoenabled);
  registerwinbytwoenableddvar(getgametype(), winbytwoenabled);
  winbytwomaxrounds = getmatchrulesdata("commonOption", "winByTwoMaxRounds");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_winByTwoMaxRounds"), winbytwomaxrounds);
  registerwinbytwomaxroundsdvar(getgametype(), winbytwomaxrounds);
  dogtags = getmatchrulesdata("commonOption", "dogTags");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_dogTags"), dogtags);
  registerdogtagsenableddvar(getgametype(), dogtags);
  spawnprotectiontimer = getmatchrulesdata("commonOption", "spawnProtectionTimer");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_spawnProtectionTimer"), spawnprotectiontimer);
  numlives = getmatchrulesdata("commonOption", "numLives");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_numLives"), numlives);
  registernumlivesdvar(getgametype(), numlives);
  numrevives = getmatchrulesdata("commonOption", "numRevives");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_numRevives"), numrevives);
  registernumrevivesdvar(getgametype(), numrevives);
  setdynamicdvar(@ "scr_player_maxhealth", getmatchrulesdata("commonOption", "maxHealth"));
  setdynamicdvar(@ "scr_player_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_healthregentime"), getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar(@ "scr_player_allowarmor", getmatchrulesdata("commonOption", "allowArmor"));
  setdynamicdvar(@ "scr_player_spawnarmor", getmatchrulesdata("commonOption", "spawnArmor"));
  setdynamicdvar(@ "hash_a6a3fd965485d4bc", getmatchrulesdata("commonOption", "spawnArmorPlates"));
  setdynamicdvar(@ "hash_8ad1ab9436bccca", getmatchrulesdata("commonOption", "dropArmorOnDeath"));
  setdynamicdvar(@ "hash_28d450f7f28644b7", getmatchrulesdata("commonOption", "armorDropAmount"));
  setdynamicdvar(@ "scr_player_disablesupersprint", getmatchrulesdata("commonOption", "disableSuperSprint"));
  setdynamicdvar(@ "hash_215eb9aef94dd47e", getmatchrulesdata("commonOption", "disableMount"));
  setdynamicdvar(@ "scr_player_laststand", getmatchrulesdata("commonOption", "lastStand"));
  setdynamicdvar(@ "hash_e4f93d764d11874d", getmatchrulesdata("commonOption", "deathsDoorEnterPct"));
  setdynamicdvar(@ "hash_b84edc242cc61abf", getmatchrulesdata("commonOption", "deathsDoorExitPct"));
  laststandhealth = getmatchrulesdata("commonOption", "lastStandHealth");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_lastStandHealth"), laststandhealth);
  registerlaststandhealthdvar(laststandhealth);
  laststandrevivehealth = getmatchrulesdata("commonOption", "lastStandReviveHealth");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_lastStandReviveHealth"), laststandrevivehealth);
  registerlaststandrevivehealthdvar(laststandrevivehealth);
  laststandtimer = getmatchrulesdata("commonOption", "lastStandTimer");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_lastStandTimer"), laststandtimer);
  registerlaststandtimerdvar(laststandtimer);
  laststandrevivetimer = getmatchrulesdata("commonOption", "lastStandReviveTimer");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_lastStandReviveTimer"), laststandrevivetimer);
  registerlaststandrevivetimerdvar(laststandrevivetimer);
  laststandsuicidetimer = getmatchrulesdata("commonOption", "lastStandSuicideTimer");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_lastStandSuicideTimer"), laststandsuicidetimer);
  registerlaststandsuicidetimerdvar(laststandsuicidetimer);
  setdynamicdvar(@ "hash_df1ae5a11f519ab5", getmatchrulesdata("commonOption", "reviveUseWeapon"));
  level.matchrules_damagemultiplier = 0;
  setdynamicdvar(@ "hash_b5e336c86438398c", getmatchrulesdata("commonOption", "vampirism"));
  setdynamicdvar(@ "scr_game_spectatetype", getmatchrulesdata("commonOption", "spectateModeAllowed"));
  setdynamicdvar(@ "scr_game_allowkillcam", getmatchrulesdata("commonOption", "showKillcam"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_killcamType"), getmatchrulesdata("commonOption", "killcamType"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_allow3rdspectate"), getmatchrulesdata("commonOption", "spectate3rdAllowed"));
  setdynamicdvar(@ "scr_game_enableminimap", getmatchrulesdata("commonOption", "enableMinimap"));
  setdynamicdvar(@ "scr_game_forceuav", getmatchrulesdata("commonOption", "radarAlwaysOn"));
  setdynamicdvar(@ "scr_game_radarhidepings", getmatchrulesdata("commonOption", "radarHideShots"));
  setdynamicdvar(@ "scr_game_navbarhideenemy", getmatchrulesdata("commonOption", "compassHideEnemy"));
  setdynamicdvar(@ "scr_game_navbarhidepings", getmatchrulesdata("commonOption", "compassHidePings"));
  setdynamicdvar(@ "scr_game_disablespawncamera", getmatchrulesdata("commonOption", "disableSpawnCamera"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_playerrespawndelay"), getmatchrulesdata("commonOption", "respawnDelay"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_suicidespawndelay"), getmatchrulesdata("commonOption", "suicideSpawnDelay"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_waverespawndelay"), getmatchrulesdata("commonOption", "waveRespawnDelay"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_waverespawndelay_alt"), getmatchrulesdata("commonOption", "waveRespawnDelayAlt"));
  setdynamicdvar(@ "hash_5d64cd3b24cf883a", getmatchrulesdata("commonOption", "forceRespawn"));
  level.matchrules_allowcustomclasses = getmatchrulesdata("commonOption", "allowCustomClasses");
  level.supportintel = getmatchrulesdata("commonOption", "allowIntel");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_allowKillstreaks"), getmatchrulesdata("commonOption", "allowKillstreaks"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_allowPerks"), getmatchrulesdata("commonOption", "allowPerks"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_allowSupers"), getmatchrulesdata("commonOption", "allowSupers"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_ffPunishLimit"), getmatchrulesdata("commonOption", "ffPunishLimit"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_ffPunishDamageLimit"), getmatchrulesdata("commonOption", "ffPunishDamageLimit"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_ffKickKillLimit"), getmatchrulesdata("commonOption", "ffKickKillLimit"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_ffKickDamageLimit"), getmatchrulesdata("commonOption", "ffKickDamageLimit"));
  setdynamicdvar(@ "scr_thirdperson", getmatchrulesdata("commonOption", "thirdPerson"));

  if(getdvarint(@ "hash_ff21d0d18916f3a1", 0) == 1) {
    setdynamicdvar(@ "camera_thirdperson", getmatchrulesdata("commonOption", "thirdPerson"));
  }

  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_roundRetainStreaks"), getmatchrulesdata("commonOption", "roundRetainStreaks"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_roundRetainStreakProg"), getmatchrulesdata("commonOption", "roundRetainStreakProg"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_deathRetainStreaks"), getmatchrulesdata("commonOption", "deathRetainStreaks"));
  setdynamicdvar(@ "scr_game_casualscorestreaks", getmatchrulesdata("commonOption", "casualScoreStreaks"));
  setdynamicdvar(@ "scr_game_wrapkillstreaks", getmatchrulesdata("commonOption", "wrapKillstreaks"));
  setdynamicdvar(@ "scr_game_superfastchargerate", getmatchrulesdata("commonOption", "superFastChargeRate"));
  setdynamicdvar(@ "scr_game_superpointsmod", getmatchrulesdata("commonOption", "superPointsMod"));
  setdynamicdvar(@ "hash_fbc77dbb0cf44cc7", getmatchrulesdata("commonOption", "spawnProtectionTimer"));
  setdynamicdvar(@ "scr_game_lethaldelay", getmatchrulesdata("commonOption", "equipmentDelay"));
  setdynamicdvar(@ "hash_9072002890a9a121", getmatchrulesdata("commonOption", "equipmentMSProtect"));
  setdynamicdvar(@ "hash_b8a0aa5681c2aa39", getmatchrulesdata("commonOption", "disableBattleChatter"));
  setdynamicdvar(@ "hash_94af58bec500b3b9", getmatchrulesdata("commonOption", "disableAnnouncer"));
  setdynamicdvar(@ "hash_29e6b70603680941", getmatchrulesdata("commonOption", "inGameLoot"));
  var_c84f9319fe9e602f = 0;

  if(!istrue(level.onlinegame) && getdvarint(@ "scr_skip_infils", 0)) {
    var_c84f9319fe9e602f = 1;
  }

  if(getdvarint(@ "hash_74cacae425805743", 0) > 0) {
    var_c84f9319fe9e602f = 1;
  }

  if(var_c84f9319fe9e602f || ismutationgamemode() || function_4ef12b6ed882dc9b() || function_4db593966758d557()) {
    setdynamicdvar(@ "scr_game_infilskip", 1);
  } else {
    setdynamicdvar(@ "scr_game_infilskip", getmatchrulesdata("commonOption", "infilSkip"));
  }

  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_practiceRound"), getmatchrulesdata("commonOption", "practiceRound"));
  setdynamicdvar(@ "hash_d2de59939486bd5a", getmatchrulesdata("commonOption", "postGameExfil"));
  setdynamicdvar(@ "hash_96dd663f32dba868", getmatchrulesdata("commonOption", "exfilExtractTimer"));
  setdynamicdvar(@ "hash_645019bc959ffaf9", getmatchrulesdata("commonOption", "exfilActiveTimer"));
  level.crankedbombtimer = getmatchrulesdata("commonOption", "crankedBombTimer");
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_crankedBombTimer"), level.crankedbombtimer);
  scripts\mp\cranked::registercrankedtimerdvar(getgametype(), level.crankedbombtimer);
  setdynamicdvar(@ "hash_72fe29aa713ea21e", getmatchrulesdata("commonOption", "classTableOverride"));
  setdynamicdvar(@ "scr_game_magcount", getmatchrulesdata("commonOption", "magCount"));
  setdynamicdvar(@ "hash_127490a7577f169f", getmatchrulesdata("commonOption", "tier1ModeEnabled"));
  setdynamicdvar(@ "hash_a2c2c2007177185e", getmatchrulesdata("commonOption", "hardcoreModeOn"));
  setdynamicdvar(@ "hash_a54edeed7c5b587f", getmatchrulesdata("commonOption", "headshotsOnly"));

  if(!isDefined(skipfriendlyfire)) {
    setdynamicdvar(@ "scr_team_fftype", getmatchrulesdata("commonOption", "friendlyFire"));
  }

  setDvar(@ "hash_8ed4dff39f3251f5", getdvarint(@ "scr_game_forceuav") == 1);
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_pointsPerKill"), getmatchrulesdata("commonOption", "pointsPerKill"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_pointsPerDeath"), getmatchrulesdata("commonOption", "pointsPerDeath"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_pointsHeadshotBonus"), getmatchrulesdata("commonOption", "pointsHeadshotBonus"));
  setdynamicdvar(hashcat(@ "scr_", getgametype(), "_pointsPerKSKill"), getmatchrulesdata("commonOption", "pointsPerKSKill"));
  setdynamicdvar(@ "hash_6ce167f2cdc8ef7c", "");
  setdynamicdvar(@ "hash_29d45d6822a1cf6d", "");

  if(privatematch() || level.systemlink || isanymlgmatch()) {
    setdynamicdvar(@ "scr_game_matchstarttime", getmatchrulesdata("commonOption", "matchStartTime"));
    setdynamicdvar(@ "hash_da33635b62d4e5b3", getmatchrulesdata("commonOption", "roundStartTime"));
  }

  setDvar(@ "hash_336f868b4d4b223", getmatchrulesdata("commonOption", "killstreakDelay"));

  if(getdvarint(@ "hash_f06ae50014e12fe5") == 1) {
    setDvar(@ "hash_8610ccd25560c117", getmatchrulesdata("commonOption", "dynamicMapElementsDisabled"));
  }
}

function reinitializematchrulesonmigration() {
  assert(isusingmatchrulesdata());
  assert(isDefined(level.initializematchrules));

  while(true) {
    level waittill("host_migration_begin");
    [[level.initializematchrules]]();

    if(isDefined(level.var_8b131e98e1629afe)) {
      [[level.var_8b131e98e1629afe]]();
    }
  }
}

function reinitializethermal(ent) {
  self endon("disconnect");

  if(isDefined(ent)) {
    ent endon("death");
  }

  while(true) {
    level waittill("host_migration_begin");

    if(isDefined(self.lastvisionsetthermal)) {
      self visionsetthermalforplayer(self.lastvisionsetthermal, 0);
    }
  }
}

function getmatchrulesspecialclass(team, index) {
  class = [];
  class ["loadoutPrimaryAttachment2"] = "none";
  class ["loadoutSecondaryAttachment2"] = "none";
  var_d414e906aa1e0afb = [];
  assertex(isDefined(team) && team != "<dev string:x9b>", "<dev string:xa3>");
  class ["loadoutPrimary"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "weapon");
  class ["loadoutPrimaryAttachment"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "attachmentSetup");
  class ["loadoutPrimaryAttachment2"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "attachmentSetup");
  class ["loadoutPrimaryCamo"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "camo");
  class ["loadoutPrimaryReticle"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "reticle");
  class ["loadoutSecondary"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "weapon");
  class ["loadoutSecondaryAttachment"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "attachmentSetup");
  class ["loadoutSecondaryAttachment2"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "attachmentSetup");
  class ["loadoutSecondaryCamo"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "camo");
  class ["loadoutSecondaryReticle"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "reticle");
  class ["loadoutPerks"] = var_d414e906aa1e0afb;
  class ["loadoutKillstreak1"] = scripts\mp\class::recipe_getkillstreak(team, index, 0);
  class ["loadoutKillstreak2"] = scripts\mp\class::recipe_getkillstreak(team, index, 1);
  class ["loadoutKillstreak3"] = scripts\mp\class::recipe_getkillstreak(team, index, 2);
  return class;
}

function isplayeroutsideofanybombsite(objweapon) {
  if(isDefined(level.objectives)) {
    foreach(bombzone in level.objectives) {
      if(self istouching(bombzone.noweapondropallowedtrigger)) {
        return false;
      }
    }
  }

  return true;
}

function gamehasneutralcrateowner(gametype) {
  switch (gametype) {
    case #"hash_415b79b2ee6a14d9":
    case #"hash_def61d8a0b05bf0d":
      return 1;
    default:
      return 0;
  }
}

function isanymlgmatch() {
  if(isusingmatchrulesdata()) {
    if(getdvarint(@ "hash_65c2395ef96fc773") == 0 && getmatchrulesdata("cwlRulesEnabled") == 1) {
      return 1;
    }
  }

  return getdvarint(@ "xblive_competitionmatch");
}

function ismlgsystemlink() {
  if(level.systemlink && getdvarint(@ "xblive_competitionmatch")) {
    return true;
  }

  return false;
}

function ismlgprivatematch() {
  if(privatematch() && getdvarint(@ "xblive_competitionmatch")) {
    return true;
  }

  return false;
}

function ismlgmatch() {
  if(ismlgsystemlink() || ismlgprivatematch()) {
    return true;
  }

  return false;
}

function ismoddedroundgame() {
  if(getgametype() == "dom" || getgametype() == "ctf" || getgametype() == "rush" || getgametype() == "blitz" || getgametype() == "rescue" || getgametype() == "ballmode" || getbasegametype() == "escort") {
    return true;
  }

  return false;
}

function isusingdefaultclass(team, index) {
  usingdefaultclass = 0;

  if(isDefined(index)) {
    if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "inUse")) {
      usingdefaultclass = 1;
    }
  } else {
    for(index = 0; index < 6; index++) {
      if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "inUse")) {
        usingdefaultclass = 1;
        break;
      }
    }
  }

  return usingdefaultclass;
}

function getmatchrulesdatawithteamandindex(category, team, index, field, arg1, arg2, arg3) {
  if(team == "axis") {
    index += 6;
  }

  if(isDefined(arg3)) {
    return getmatchrulesdata(category, index, field, arg1, arg2, arg3);
  }

  if(isDefined(arg2)) {
    return getmatchrulesdata(category, index, field, arg1, arg2);
  }

  return getmatchrulesdata(category, index, field, arg1);
}

function isspawnprotected() {
  return !issimulationplayer(self) && isDefined(self.spawntime) && isDefined(level.killstreakspawnshielddelayms) && gettime() < self.spawntime + level.killstreakspawnshielddelayms && !istrue(self.clearspawnprotection);
}

function clearspawnprotection() {
  self.clearspawnprotection = 1;
}

function ismatchstartprotected() {
  return isDefined(level.starttime) && gettime() < level.starttime + level.equipmentmatchstartshieldms;
}

function getgametype() {
  return scripts\cp_mp\utility\game_utility::getgametype();
}

function getbasegametype() {
  return scripts\cp_mp\utility\game_utility::getbasegametype();
}

function function_f6bad1d33ad22078() {
  if(level.leagueplaymatch) {
    return "mp_ranked";
  }

  return "mp";
}

function getsubgametype() {
  return scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
}

function issubgametype() {
  gametype = getgametype();
  subgametype = getsubgametype();
  return gametype != subgametype;
}

function isteamplacementsbmmmode() {
  switch (getsubgametype()) {
    case #"hash_3c1c1566d7b3b870":
    case #"hash_9196025f8ae8e51e":
    case #"hash_fa21c4f6bd5e3815":
      return true;
  }

  return false;
}

function isjuggermoshgamemode() {
  switch (getgametype()) {
    case #"hash_2f5af599c5c220d3":
    case #"hash_b024b6bb2d9e8547":
    case #"hash_cf3000550ee7e8b3":
      return true;
  }

  return false;
}

function function_4ef12b6ed882dc9b() {
  if(!isusingmatchrulesdata()) {
    return 0;
  }

  return getmatchrulesdata("commonOption", "paintballModeEnabled");
}

function function_7dc15b2c8dcd2ee7() {
  return getmatchrulesdata("commonOption", "bowsonlyEnabled");
}

function ismutationgamemode() {
  return getdvarint(@ "hash_bc885339c750a6ee", 0);
}

function ismutationgamemodezombie() {
  return ismutationgamemode() && isDefined(self) && self[[getsharedfunc("escort", "isZombie")]]();
}

function function_7586e7f1e96dc16d() {
  return function_d75b73c443421047() && isDefined(self) && isDefined(self.var_e5520effcbe8bd30);
}

function function_4db593966758d557() {
  if(getbasegametype() == "cyber") {
    if(level.mapname == "mp_jup_skidrow") {
      return true;
    }

    if(level.mapname == "mp_jup_skidrow_alt") {
      return true;
    }

    if(level.mapname == "mp_jup_dubai") {
      return true;
    }
  }

  return false;
}

function function_f24e99a2f548d0b8() {
  switch (getgametype()) {
    case #"hash_4cb5825e78aaa8c":
    case #"hash_a00cd1371d281532":
      return true;
  }

  return false;
}

function function_d75b73c443421047() {
  return getDvar(@ "ui_gametype", "") == "limbo";
}

function function_966592fd716d49c7() {
  if(!isusingmatchrulesdata()) {
    return 0;
  }

  if(isDefined(level.trickrtreatenabled)) {
    return level.trickrtreatenabled;
  }

  level.trickrtreatenabled = getmatchrulesdata("commonOption", "trickrtreatEnabled");
  return level.trickrtreatenabled;
}

function lpcfeaturegated() {
  if(runleanthreadmode()) {
    return true;
  }

  switch (getgametype()) {
    case #"hash_ca6516c10db2c95":
    case #"hash_5e78ea9021845d4a":
    case #"hash_7f9c384a34cc392f":
    case #"hash_8f01ce022684fbc8":
    case #"hash_9a6f07d0214a87db":
    case #"hash_bc5ad0664c3cc103":
    case #"hash_c065cef60f38490a":
    case #"hash_c7f4420f385eeb3d":
      return true;
  }

  return false;
}

function runleanthreadmode() {
  if(getdvarint(@ "hash_63b929c96913e1d") == 1) {
    return true;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() || level.leanthread == 1) {
    return true;
  }

  return false;
}

function gamehasinfil() {
  if(!isDefined(game["infil"])) {
    return 0;
  }

  var_97f23a7b99a8ccc7 = 1;

  foreach(entry in level.teamnamelist) {
    if(!isDefined(game["infil"][entry]) || !isDefined(game["infil"][entry][1])) {
      var_97f23a7b99a8ccc7 = 0;
      break;
    }
  }

  return var_97f23a7b99a8ccc7;
}

function teamhasinfil(team) {
  return gamehasinfil() && isgameplayteam(team) && isDefined(game["infil"][team][1]);
}

function iskillstreakdenied() {
  return scripts\cp_mp\emp_debuff::is_empd() || isairdenied();
}

function isairdenied() {
  if(self.team == "spectator") {
    return false;
  }

  return false;
}

function getmaxoutofboundstime() {
  return max(0, getdvarfloat(@ "scr_outofboundstime", 3));

  outofboundstime = level.outofboundstime;

  if(!isDefined(outofboundstime)) {
    outofboundstime = max(0, ter_op(matchmakinggame(), getdvarfloat(@ "scr_outofboundstime", 3), 3));
    level.outofboundstime = outofboundstime;
  }

  return outofboundstime;
}

function function_a01d18a56c6cc1aa() {
  return getdvarfloat(@ "hash_dd59793cdeddb43f", 15);
}

function getmaxoutofboundscooldown() {
  return max(0, getdvarfloat(@ "hash_1e90a42100ff3964", 3));

  outofboundscooldown = level.outofboundscooldown;

  if(!isDefined(outofboundscooldown)) {
    outofboundscooldown = max(0, getdvarfloat(@ "hash_1e90a42100ff3964", 3));
    level.outofboundscooldown = outofboundscooldown;
  }

  return outofboundscooldown;
}

function getmaxoutofboundsminefieldtime() {
  return max(0, getdvarfloat(@ "hash_e4bb2af9293410e5", 3));

  outofboundstimeminefield = level.outofboundstimeminefield;

  if(!isDefined(outofboundstimeminefield)) {
    outofboundstimeminefield = max(0, getdvarfloat(@ "hash_e4bb2af9293410e5", 3));
    level.outofboundstimeminefield = outofboundstimeminefield;
  }

  return outofboundstimeminefield;
}

function getmaxoutofboundsrestrictedtime() {
  level.outofboundstimerestricted = 10;
  return level.outofboundstimerestricted;
}

function getmaxoutofboundsbrtime() {
  var_61d3a4299744033e = getdvarfloat(@ "scr_outofboundstime", 10);

  if(var_61d3a4299744033e > 0) {
    level.outofboundstimebr = var_61d3a4299744033e;
  } else {
    level.outofboundstimebr = 10;
  }

  return level.outofboundstimebr;
}

function updateobjectivetext() {
  if(self.pers["team"] == "spectator") {
    self setclientdvar(@ "hash_e059919397a99593", "");
    return;
  }

  if(level.roundscorelimit > 0 && !isobjectivebased()) {
    if(isDefined(getobjectivescoretext(self.pers["team"]))) {
      if(level.splitscreen) {
        self setclientdvar(@ "hash_e059919397a99593", getobjectivescoretext(self.pers["team"]));
      } else {
        self setclientdvar(@ "hash_e059919397a99593", getobjectivescoretext(self.pers["team"]), level.roundscorelimit);
      }
    }

    return;
  }

  if(isDefined(getobjectivetext(self.pers["team"]))) {
    self setclientdvar(@ "hash_e059919397a99593", getobjectivetext(self.pers["team"]));
  }
}

function setobjectivetext(team, text) {
  game["strings"]["objective_" + team] = text;
}

function setobjectivescoretext(team, text) {
  game["strings"]["objective_score_" + team] = text;
}

function setobjectivehinttext(team, text) {
  game["strings"]["objective_hint_" + team] = text;
}

function getobjectivetext(team) {
  return game["strings"]["objective_" + team];
}

function getobjectivescoretext(team) {
  return game["strings"]["objective_score_" + team];
}

function getobjectivehinttext(team) {
  return game["strings"]["objective_hint_" + team];
}

function testgamemodestringlist(stringlist, gamemode) {
  if(!isDefined(stringlist) || stringlist == "" || !isDefined(gamemode) || gamemode == "") {
    return 0;
  }

  return issubstr(stringlist, gamemode);
}

function islaststandenabled() {
  return isDefined(level.laststand) && (level.laststand == 1 || level.laststand == 3) || istrue(level.var_78184ec36f669844);
}

function isteamreviveenabled() {
  return isDefined(level.laststand) && (level.laststand == 2 || level.laststand == 3);
}

function isdefending(victim) {
  inobjective = 0;

  switch (getgametype()) {
    case #"hash_eb5e5f470e0c1dc2":
      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        var_abb6fbdd8cd1a1d2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        var_44096cee99b7a48b = distancesquared(level.cyberemp.carrier.origin, victim.origin);

        if(var_abb6fbdd8cd1a1d2 < 90000 || var_44096cee99b7a48b < 90000) {
          inobjective = 1;
          break;
        }
      }

      foreach(bombzone in level.objectives) {
        if(istrue(bombzone.trigger.trigger_off)) {
          continue;
        }

        ownerteam = bombzone.ownerteam;

        if(ownerteam == self.team) {
          var_abb6fbdd8cd1a1d2 = distancesquared(bombzone.trigger.origin, self.origin);
          var_44096cee99b7a48b = distancesquared(bombzone.trigger.origin, victim.origin);

          if(var_abb6fbdd8cd1a1d2 < 90000 || var_44096cee99b7a48b < 90000) {
            inobjective = 1;
            break;
          }
        }
      }

      break;
    case #"hash_aac44b0b52bacb8e":
    case #"hash_dd217fc2f74cbcdd":
    case #"hash_fa0ed2f6bd4f4395":
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
      if(self.team != game["defenders"]) {
        break;
      }

      foreach(objective in level.objectives) {
        var_77ada7456cac5c0e = distancesquared(objective.trigger.origin, victim.origin);

        if(var_77ada7456cac5c0e < 90000) {
          inobjective = 1;
          break;
        }
      }

      break;
    case #"hash_4cb5825e78aaa8c":
    case #"hash_ca6516c10db2c95":
    case #"hash_2f5af599c5c220d3":
    case #"hash_3ae8dcf2840c03a0":
    case #"hash_5160cc5f44a0a22e":
    case #"hash_53825b446469ac4c":
    case #"hash_5e78ea9021845d4a":
    case #"hash_7f9c384a34cc392f":
    case #"hash_8c758b84936e8d42":
    case #"hash_a1313b745c17c07e":
    case #"hash_d82d642e83fb9772":
    case #"hash_ec24570718a340f5":
    case #"hash_f25c018be2dd3f5f":
    case #"hash_f4a9126c03d3385b":
      foreach(objective in level.objectives) {
        if(self.team != objective.ownerteam) {
          continue;
        }

        var_2f26c572a7a12636 = distancesquared(objective.curorigin, self.origin);
        var_d0502d3fad28fa4f = distancesquared(objective.curorigin, victim.origin);

        if(var_2f26c572a7a12636 < 90000 || var_d0502d3fad28fa4f < 90000) {
          inobjective = 1;
          break;
        }
      }

      break;
    case #"hash_634e449bb53a8268":
    case #"hash_6efb0f59a62300fb":
    case #"hash_78ebb3b7ce8f864f":
    case #"hash_a6b6d6b8dc1096cd":
    case #"hash_b9aaf1c4459d9a15":
    case #"hash_cf3000550ee7e8b3":
    case #"hash_dd5b900f435d3f36":
    case #"hash_ec72fd25bbbac99e":
    case #"hash_fa34c5f6bd6d4432":
      if(isDefined(level.zone)) {
        inobjective = ispointinvolume(self.origin, level.zone.trigger) || ispointinvolume(victim.origin, level.zone.trigger);
      }

      break;
  }

  return inobjective;
}

function isassaulting(victim) {
  inobjective = 0;

  switch (getgametype()) {
    case #"hash_eb5e5f470e0c1dc2":
      if(istrue(victim.isbombcarrier)) {
        inobjective = 1;
        break;
      }

      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        var_abb6fbdd8cd1a1d2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        var_44096cee99b7a48b = distancesquared(level.cyberemp.carrier.origin, victim.origin);

        if(var_abb6fbdd8cd1a1d2 < 90000 || var_44096cee99b7a48b < 90000) {
          inobjective = 1;
          break;
        }
      }

      foreach(bombzone in level.objectives) {
        if(istrue(bombzone.trigger.trigger_off)) {
          continue;
        }

        ownerteam = bombzone.ownerteam;

        if(ownerteam != self.team) {
          var_2f26c572a7a12636 = distancesquared(bombzone.trigger.origin, self.origin);
          var_d0502d3fad28fa4f = distancesquared(bombzone.trigger.origin, victim.origin);

          if(var_2f26c572a7a12636 < 90000 || var_d0502d3fad28fa4f < 90000) {
            inobjective = 1;
            break;
          }
        }
      }

      break;
    case #"hash_aac44b0b52bacb8e":
    case #"hash_dd217fc2f74cbcdd":
    case #"hash_fa0ed2f6bd4f4395":
    case #"hash_fa50b0f6bd82e972":
    case #"hash_fa50baf6bd82f930":
      if(self.team == game["defenders"]) {
        break;
      }

      foreach(objective in level.objectives) {
        var_77ada7456cac5c0e = distancesquared(objective.trigger.origin, victim.origin);

        if(var_77ada7456cac5c0e < 90000) {
          inobjective = 1;
          break;
        }
      }

      break;
    case #"hash_ca6516c10db2c95":
    case #"hash_3ae8dcf2840c03a0":
    case #"hash_5160cc5f44a0a22e":
    case #"hash_53825b446469ac4c":
    case #"hash_5e78ea9021845d4a":
    case #"hash_7f9c384a34cc392f":
    case #"hash_8c758b84936e8d42":
    case #"hash_a1313b745c17c07e":
    case #"hash_d82d642e83fb9772":
    case #"hash_ec24570718a340f5":
    case #"hash_f25c018be2dd3f5f":
    case #"hash_f4a9126c03d3385b":
      foreach(objective in level.objectives) {
        if(self.team == objective.ownerteam) {
          continue;
        }

        var_2f26c572a7a12636 = distancesquared(objective.curorigin, self.origin);
        var_d0502d3fad28fa4f = distancesquared(objective.curorigin, victim.origin);

        if(var_2f26c572a7a12636 < 90000 || var_d0502d3fad28fa4f < 90000) {
          inobjective = 1;
          break;
        }
      }

      break;
    case #"hash_634e449bb53a8268":
    case #"hash_6efb0f59a62300fb":
    case #"hash_78ebb3b7ce8f864f":
    case #"hash_a6b6d6b8dc1096cd":
    case #"hash_b9aaf1c4459d9a15":
    case #"hash_cf3000550ee7e8b3":
    case #"hash_dd5b900f435d3f36":
    case #"hash_ec72fd25bbbac99e":
    case #"hash_fa34c5f6bd6d4432":
      if(isDefined(level.zone)) {
        inobjective = ispointinvolume(self.origin, level.zone.trigger) || ispointinvolume(victim.origin, level.zone.trigger);
      }

      break;
  }

  return inobjective;
}

function gametypesupportsbasejumping() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return 1;
  }

  if(scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e()) {
    return 0;
  }

  switch (getgametype()) {
    case #"hash_1e4846dca3ccf38":
    case #"hash_ca6516c10db2c95":
    case #"hash_53825b446469ac4c":
    case #"hash_5e78ea9021845d4a":
    case #"hash_63fb0ba698c46db3":
    case #"hash_7485fa6c474ec865":
    case #"hash_7f9c384a34cc392f":
    case #"hash_8f01ce022684fbc8":
    case #"hash_9a6f07d0214a87db":
    case #"hash_b9458959b10637f8":
    case #"hash_bc5ad0664c3cc103":
    case #"hash_c065cef60f38490a":
    case #"hash_c7f4420f385eeb3d":
    case #"hash_f4a9126c03d3385b":
      return 1;
    default:
      return 0;
  }
}

function mapsupportsbasejumping() {
  if(scripts\cp_mp\utility\game_utility::isdonetskmap() || scripts\cp_mp\utility\game_utility::islargemap()) {
    return 1;
  }

  switch (level.mapname) {
    case #"hash_1b3ccf154e387057":
      return 1;
    case #"hash_7b08e6b8f46bd733":
      return 1;
    case #"hash_7ff81f1cd6143d9d":
      return 1;
    case #"hash_1dda853d40d6f75e":
      return 1;
    case #"hash_5cfcc13994df1513":
      return 1;
    case #"hash_ab7026ed3aa8e85e":
      return 1;
    case #"hash_e0f4521889150186":
      return 1;
    case #"hash_d1b7841a5040962a":
      return 1;
    case #"hash_2d70196d81f685bc":
      return 1;
    case #"hash_2d701c6d81f68a75":
      return 1;
    case #"hash_2d701b6d81f688e2":
      return 1;
    case #"hash_2d70166d81f68103":
      return 1;
    case #"hash_29da5cf015f908ce":
      return 1;
    case #"hash_ffa01e486cc66390":
      return 1;
    default:
      return 0;
  }
}

function logannouncement(player, contester, message, zoneorigin, extrainfo) {
  time_from_match_start = scripts\mp\matchdata::gettimefrommatchstart(gettime());

  if(!isDefined(message)) {
    return;
  }

  info = "";

  if(isDefined(extrainfo)) {
    info = extrainfo;
  } else {
    info = "none";
  }

  if(!isDefined(player)) {
    if(isDefined(zoneorigin)) {
      dlog_recordevent("dlog_event_announcement", ["time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", "none", "contester_team", "none", "zone_x", zoneorigin[0], "zone_y", zoneorigin[1], "zone_z", zoneorigin[2]]);
    } else {
      dlog_recordevent("dlog_event_announcement", ["time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info]);
    }

    return;
  }

  if(isDefined(contester)) {
    if(isDefined(zoneorigin)) {
      dlog_recordevent("dlog_event_announcement", ["player", player, "contester", contester, "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", player.team, "contester_team", contester.team, "zone_x", zoneorigin[0], "zone_y", zoneorigin[1], "zone_z", zoneorigin[2]]);
    } else {
      dlog_recordevent("dlog_event_announcement", ["player", player, "contester", contester, "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", player.team, "contester_team", contester.team]);
    }

    return;
  }

  if(isDefined(zoneorigin)) {
    dlog_recordevent("dlog_event_announcement", ["player", player, "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", player.team, "contester_team", "none", "zone_x", zoneorigin[0], "zone_y", zoneorigin[1], "zone_z", zoneorigin[2]]);
    return;
  }

  dlog_recordevent("dlog_event_announcement", ["player", player, "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", player.team]);
}

function isprophuntgametype() {
  return istrue(level.isprophunt);
}

function isgroundwarcoremode() {
  return istrue(level.isgroundwarinfected) || istrue(level.isgroundwarsiege) || istrue(level.isgroundwardom) || istrue(level.var_904f766b5267e332);
}

function function_a7caa13ebe4c4ba5() {
  switch (getgametype()) {
    case #"hash_1e4846dca3ccf38":
    case #"hash_ca6516c10db2c95":
    case #"hash_5e78ea9021845d4a":
    case #"hash_7f9c384a34cc392f":
    case #"hash_9a6f07d0214a87db":
    case #"hash_aac44b0b52bacb8e":
    case #"hash_c065cef60f38490a":
    case #"hash_c7f4420f385eeb3d":
    case #"hash_dd217fc2f74cbcdd":
    case #"hash_eb5e5f470e0c1dc2":
    case #"hash_ec086b911c1011ec":
    case #"hash_fa50b0f6bd82e972":
      return 1;
    default:
      return 0;
  }
}

function isverdansksubmap() {
  switch (scripts\cp_mp\utility\game_utility::getmapname()) {
    case #"hash_12f3765ef24b4037":
    case #"hash_1bc93b88575e82eb":
    case #"hash_32eaa112f8caa7e4":
    case #"hash_3a8b050ff58578ad":
    case #"hash_50de71be6e7469ff":
    case #"hash_7a28db3c5928c489":
    case #"hash_924a3fbe9fbe15c6":
    case #"hash_e4ca6b73b5022b26":
      return 1;
    default:
      return 0;
  }
}

function function_e417d8ef1c70cbcb() {
  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    return true;
  } else if(scripts\cp_mp\utility\game_utility::isdonetskmap()) {
    return true;
  } else if(isverdansksubmap()) {
    return true;
  } else if(getdvarint(@ "hash_e35a761bc944e0f8", 0) != 1) {
    return true;
  }

  return false;
}

function canparachutebecut(player) {
  var_37b3fb3ff20a3eb6 = 0;
  var_a5150dc49f8b1cc7 = 0;
  gametype = getgametype();

  if(isusingmatchrulesdata() && getmatchrulesdata("commonOption", "allowParachute") || (gametype == "arm" || gametype == "bigctf" || gametype == "conflict" || gametype == "risk" || gametype == "gwbomb" || isgroundwarcoremode()) && scripts\cp_mp\utility\game_utility::islargemap() || getdvarint(@ "hash_9365c7a237edaa2f", 0) == 1 || istrue(level.var_aac427da0a1569e2)) {
    if(istrue(level.parachutecancutautodeploy)) {
      var_37b3fb3ff20a3eb6 = 1;
    }

    if(istrue(level.parachutecancutparachute) && !istrue(player.var_4da443f197c8014e)) {
      var_a5150dc49f8b1cc7 = 1;
    }
  }

  if(var_37b3fb3ff20a3eb6) {
    player skydive_cutautodeployon();
  } else {
    player skydive_cutautodeployoff();
  }

  if(var_a5150dc49f8b1cc7) {
    player skydive_cutparachuteon();
    return;
  }

  player skydive_cutparachuteoff();
}

function function_1e098780c33853f2() {
  return matchmakinggame() && getdvarint(@ "hash_72fe29aa713ea21e", 0) != 0;
}

function function_ac09124b4e7535a6() {
  return matchmakinggame() && getdvarint(@ "hash_72fe29aa713ea21e", 0) == 1;
}

function function_b7d052e4bf41ee9b() {
  if(function_1e098780c33853f2()) {
    return true;
  }

  if(function_f24e99a2f548d0b8()) {
    return true;
  }

  return false;
}

function function_eb3158a25aee673a() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    subgametype = getsubgametype();
    return (subgametype == "dmz" || subgametype == "exgm");
  }

  return false;
}

function function_d7ec918e29c0b2f4() {
  return getdvarint(@ "online_allowteamchange");
}

function function_f698bfd3efa33302() {
  return istrue(level.supportcranked);
}

function function_e9f3a160bbefe208(player) {
  return isDefined(player) && istrue(player.supportcranked);
}

function get_linked_vehicle_nodes() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = get_links();

    if(linknames.size == 1) {
      return getvehiclenodearray(linknames[0], "script_linkname");
    } else if(linknames.size > 1) {
      return function_df5a62cb94a82870(linknames, "script_linkname");
    }
  }

  return array;
}

function function_af945a8525e5b3bb() {
  if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.var_e1113fd85977023f)) {
    return level.gametypebundle.var_e1113fd85977023f;
  }

  return "";
}

function function_9a59855eebf296b6() {
  if(isDefined(level.var_29ed825c4a9a052c)) {
    return level.var_29ed825c4a9a052c;
  }

  primaryflags = getEntArray("flag_primary", "targetname");

  foreach(flag in primaryflags) {
    if(flag.script_label == "_b") {
      level.var_29ed825c4a9a052c = flag.origin;
      break;
    }
  }

  return level.var_29ed825c4a9a052c;
}