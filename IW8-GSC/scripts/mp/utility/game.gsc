/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\game.gsc
***********************************************/

function getotherteam(var_0) {
  return scripts\mp\utility\teams::getenemyteams(var_0);
}

function gettimepassed() {
  if(!isDefined(level.starttime) || !isDefined(level.discardtime)) {
    return 0;
  }

  if(level.timerstopped) {
    return (level.timerpausetime - level.starttime - level.discardtime - level.overtimetotal);
  }

  return gettime() - level.starttime - level.discardtime - level.overtimetotal;
}

function gettimepassedpercentage() {
  var_0 = gettimelimit();

  if(var_0 == 0) {
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

function setuipostgamefade(var_0, var_1) {
  self endon("disconnect");

  if(istrue(level.nukedetonated)) {
    return;
  }

  if(!isDefined(self.fadecurrent)) {
    self.fadecurrent = 0;
  }

  if(self.fadecurrent == var_0) {
    return;
  }

  if(isDefined(var_1)) {
    wait var_1;
  }

  self notify("setUIPostGameFade");
  self endon("setUIPostGameFade");

  if(self.fadecurrent < var_0) {
    self.fadecurrent = clamp(self.fadecurrent + 0.5 * abs(self.fadecurrent - var_0), 0, 1);
  } else {
    self.fadecurrent = clamp(self.fadecurrent - 0.5 * abs(self.fadecurrent - var_0), 0, 1);
  }

  self setclientomnvar("ui_total_fade", self.fadecurrent);
  wait 0.1;
  self.fadecurrent = var_0;
  self setclientomnvar("ui_total_fade", self.fadecurrent);
}

function registerroundswitchdvar(var_0, var_1, var_2, var_3) {
  scripts\mp\utility\dvars::registerwatchdvarint("roundswitch", var_1);
  var_0 = "scr_" + var_0 + "_roundswitch";
  level.roundswitchdvar = var_0;
  level.roundswitchmin = var_2;
  level.roundswitchmax = var_3;
  level.roundswitch = getdvarint(var_0, var_1);

  if(level.roundswitch < var_2) {
    level.roundswitch = var_2;
    return;
  }

  if(level.roundswitch > var_3) {
    level.roundswitch = var_3;
    return;
  }
}

function registerroundlimitdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("roundlimit", var_1);
}

function registernumteamsdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("numTeams", var_1);
}

function registerwinlimitdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("winlimit", var_1);
}

function registerwinbytwoenableddvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("winbytwoenabled", var_1);
}

function registerwinbytwomaxroundsdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("winbytwomaxrounds", var_1);
}

function registerdogtagsenableddvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("dogtags", var_1);
}

function registerscorelimitdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("scorelimit", var_1);
}

function registertimelimitdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("timelimit", var_1);
  setDvar("ui_timelimit", gettimelimit());
}

function registerhalftimedvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("halftime", var_1);
  setDvar("ui_halftime", gethalftime());
}

function registernumlivesdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("numlives", var_1);
}

function registernumrevivesdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("numrevives", var_1);
}

function setovertimelimitdvar(var_0) {
  setDvar("overtimeTimeLimit", var_0);
}

function registerlaststandhealthdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarint("lastStandHealth", var_0);
}

function registerlaststandrevivehealthdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarint("lastStandReviveHealth", var_0);
}

function registerlaststandtimerdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandTimer", var_0);
}

function registerlaststandrevivetimerdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandReviveTimer", var_0);
}

function registerlaststandweapondvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvar("lastStandWeapon", var_0);
}

function registerlaststandweapondelaydvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandWeaponDelay", var_0);
}

function registerlaststandsuicidetimerdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandSuicideTimer", var_0);
}

function registerlaststandinvulntimerdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandInvulnTimer", var_0);
}

function registerlaststandrevivedecayscaledvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandReviveDecayScale", var_0);
}

function isroundbased() {
  if(!level.teambased) {
    return false;
  }

  if(level.winlimit != 1 && level.roundlimit != 1) {
    return true;
  }

  if(getgametype() == "sr" || getgametype() == "sd" || getgametype() == "siege" || getgametype() == "cyber" || getgametype() == "mtmc") {
    return true;
  }

  return false;
}

function safehouse_vo_return_start(var_0) {
  return "team_two_hundred";
}

function vehicle_collision_ignorefuturemultievent(var_0) {
  if(var_0 == safehouse_vo_return_start() && (isDefined(level.ref_14687) || deposit_from_compromised_convoy_delayed_failsafe())) {
    return true;
  }

  return false;
}

function deposit_from_compromised_convoy_delayed_failsafe() {
  return getdvarint("scr_br_use_agents", 0) > 0 || istrue(level.disable_oob_immunity_on_riders);
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

  var_0 = 0;

  foreach(var_2 in level.teamnamelist) {
    if(vehicle_collision_ignorefuturemultievent(level, var_2)) {
      continue;
    }

    var_3 = getroundswon(var_2);

    if(var_3 == level.winlimit - 1) {
      var_0 = 1;
      break;
    }
  }

  var_5 = level.winlimit > 0 && var_0;

  if(var_5 && allteamstied()) {
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

  var_0 = 0;

  foreach(var_2 in level.teamnamelist) {
    if(vehicle_collision_ignorefuturemultievent(level, var_2)) {
      continue;
    }

    var_3 = getroundswon(var_2);

    if(var_3 == level.winlimit - 1) {
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

  if(istrue(level.initcircuitbreakers)) {
    return true;
  }

  if(wasonlyround()) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  if(hitroundlimit() || hitwinlimit()) {
    return !level.playovertime;
  }

  return false;
}

function iswinbytworulegametype() {
  switch (getgametype()) {
    case "siege":
    case "sr":
    case "sd":
    case "arena":
      return (getdvarint("scr_" + getgametype() + "_winByTwoEnabled", 0) == 1);
  }

  return false;
}

function getmaxwinbytworounds() {
  return getdvarint("scr_" + getgametype() + "_winByTwoMaxRounds", level.winlimit);
}

function shouldplaywinbytwo() {
  var_0 = game["roundsWon"]["allies"];
  var_1 = game["roundsWon"]["axis"];
  return iswinbytworulegametype() && abs(var_0 - var_1) < 2 && game["overtimeRoundsPlayed"] < getmaxwinbytworounds();
}

function islastwinbytwo() {
  return shouldplaywinbytwo() && game["overtimeRoundsPlayed"] == getmaxwinbytworounds() - 1;
}

function ref_1332B() {
  var_0 = game["roundsWon"]["allies"];
  var_1 = game["roundsWon"]["axis"];
  return abs(var_0 - var_1) < 2;
}

function istimetobeatrulegametype() {
  switch (getgametype()) {
    case "payload":
    case "ball":
    case "ctf":
      return true;
  }

  return false;
}

function intimetobeat() {
  return isDefined(game["status"]) && game["status"] == "recordTTB";
}

function settimetobeat(var_0) {
  if(!istimetobeatrulegametype()) {
    return false;
  }

  var_1 = getsecondspassed();
  var_2 = scripts\mp\gamescore::_getteamscore(var_0);

  if(!istimetobeatvalid() || var_1 < game["timeToBeat"] && var_2 >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != var_0) {
      game["timeToBeatOld"] = game["timeToBeat"];
    }

    game["timeToBeat"] = var_1;
    game["timeToBeatTeam"] = var_0;
    game["timeToBeatScore"] = var_2;
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
    case "rush":
      return true;
  }

  return false;
}

function setscoretobeat(var_0, var_1) {
  if(!isscoretobeatrulegametype()) {
    return 0;
  }

  var_2 = game["timeToBeatTeam"] != "none" && var_1 == game["timeToBeatScore"];

  if(var_1 >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != var_0) {
      game["timeToBeatScoreOld"] = game["timeToBeatScore"];
    }

    game["timeToBeatTeam"] = var_0;
    game["timeToBeatScore"] = var_1;
  }

  foreach(var_4 in level.players) {
    var_4 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_4.team == game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
    var_4 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_4.team != game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
  }

  if(var_2) {
    return "tie";
  }

  return game["timeToBeatTeam"];
}

function shouldplayscoretobeatot() {
  return isscoretobeatrulegametype() && game["overtimeRoundsPlayed"] == 1;
}

function isovertimesupportedgametype() {
  if(isgamebattlematch()) {
    return true;
  }

  switch (getgametype()) {
    case "payload":
    case "cmd":
    case "blitz":
    case "rush":
    case "ball":
    case "ctf":
      return true;
    case "dd":
    case "siege":
    case "sr":
    case "sd":
    case "arena":
      return iswinbytworulegametype();
  }

  return false;
}

function getmaxovertimeroundsbygametype() {
  if(isgamebattlematch()) {
    return -1;
  }

  var_0 = 0;

  switch (getgametype()) {
    case "payload":
    case "blitz":
    case "ball":
    case "ctf":
    case "siege":
    case "sr":
    case "sd":
      var_0 = 2;
      break;
    case "cmd":
    case "dd":
      var_0 = 1;
      break;
  }

  if(isanymlgmatch() && !istimetobeatrulegametype()) {
    return -1;
  }

  return var_0;
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
    level.simultaneouskillenabled = getdvarint("killswitch_simultaneous_deaths", 0) == 0;
  }

  return level.simultaneouskillenabled;
}

function cantiebysimultaneouskill() {
  if(!issimultaneouskillenabled()) {
    return 0;
  }

  var_0 = 0;

  switch (getgametype()) {
    case "dm":
    case "war":
    case "brtdm":
    case "gun":
    case "front":
    case "arm":
      var_0 = 1;
      break;
  }

  return var_0;
}

function shouldplayovertime() {
  if(!hitroundlimit() && !hitwinlimit()) {
    return false;
  }

  if(!isovertimesupportedgametype()) {
    return false;
  }

  var_0 = allteamstied();

  if(var_0 && inovertime()) {
    var_1 = getmaxovertimeroundsbygametype();
    var_0 = scripts\engine\utility::ter_op(var_1 == -1, 1, game["overtimeRoundsPlayed"] < var_1);
  }

  var_2 = shouldplaywinbytwo();
  var_3 = shouldplaytimetobeatot();
  var_4 = shouldplayscoretobeatot();
  return !level.forcedend && (var_0 || var_2 || var_3 || var_4);
}

function resetscoreonroundstart() {
  if(istrue(level.resetscoreonroundstart)) {
    return true;
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
    case "grnd":
    case "grind":
    case "dm":
    case "war":
    case "koth":
    case "hq":
    case "pill":
    case "brtdm":
    case "conf":
    case "tdef":
    case "dd":
    case "ball":
    case "dom":
    case "infect":
    case "front":
    case "arm":
      return 1;
    case "mp_zomb":
    case "gun":
    case "ctf":
    case "siege":
    case "sr":
    case "sd":
      return 0;
    default:
      return 0;
  }
}

function hittimelimit() {
  if(scripts\mp\utility\dvars::getwatcheddvar("timelimit") <= 0) {
    return false;
  }

  var_0 = scripts\mp\gamelogic::gettimeremaining();

  if(var_0 > 0) {
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
    foreach(var_1 in level.teamnamelist) {
      if(game["teamScores"][var_1] >= level.roundscorelimit) {
        return true;
      }
    }
  } else {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(isDefined(var_4.score) && var_4.score >= level.roundscorelimit) {
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

  foreach(var_1 in level.teamnamelist) {
    if(getroundswon(var_1) >= level.winlimit) {
      return true;
    }
  }

  return false;
}

function getscorelimit() {
  if(isroundbased()) {
    if(level.roundlimit) {
      return level.roundlimit;
    }

    return level.winlimit;
  }

  return level.roundscorelimit;
}

function getroundswon(var_0) {
  return game["roundsWon"][var_0];
}

function allteamstied() {
  var_0 = getwingamebytype();
  var_1 = undefined;

  foreach(var_3 in level.teamnamelist) {
    if(!isDefined(var_1)) {
      var_1 = game[var_0][var_3];
      continue;
    }

    if(var_1 != game[var_0][var_3]) {
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
    }

    var_0 = getdvarfloat("overtimeTimeLimit");

    if(var_0 > 0) {
      return var_0;
    }

    return scripts\mp\utility\dvars::getwatcheddvar("timelimit");
  }

  if(isDefined(level.extratime) && level.extratime > 0) {
    return (scripts\mp\utility\dvars::getwatcheddvar("timelimit") + level.extratime);
  }

  return scripts\mp\utility\dvars::getwatcheddvar("timelimit");
}

function gethalftime() {
  if(inovertime()) {
    return 0;
  }

  if(isDefined(game["inNukeOvertime"]) && game["inNukeOvertime"]) {
    return 0;
  }

  return scripts\mp\utility\dvars::getwatcheddvar("halftime");
}

function inovertime() {
  return isDefined(game["status"]) && game["status"] == "overtime";
}

function gamehasstarted() {
  if(isDefined(level.gamehasstarted)) {
    return level.gamehasstarted;
  }

  if(level.teambased) {
    foreach(var_1 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_1, "hasSpawned")) {
        return 1;
      }
    }

    return 0;
  }

  return level.maxplayercount > 1;
}

function getlivingplayers(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }

    if(level.teambased && isDefined(var_0)) {
      if(var_0 == var_3.pers["team"]) {
        var_1 = var_3;
      }

      continue;
    }

    var_1 = var_3;
  }

  return var_1;
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
  return level.onlinegame && getdvarint("xblive_privatematch");
}

function lobbyteamselectenabled() {
  return level.systemlink || privatematch() && getdvarint("lobby_team_select", 0) || function_0426();
}

function matchmakinggame() {
  return level.matchmakingmatch;
}

function getgametypenumlives() {
  return scripts\mp\utility\dvars::getwatcheddvar("numlives");
}

function getlastlivingplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_0) && var_3.team != var_0) {
      continue;
    }

    if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() && !var_3 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(isDefined(var_3.switching_teams) && var_3.switching_teams) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function ref_13E13() {
  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive() && !var_2 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(level.codcasterenabled) {
      if(var_2 ismlgspectator()) {
        continue;
      }
    }

    if(isDefined(var_0)) {
      return undefined;
    }

    var_0 = var_2;
  }

  if(isDefined(var_0)) {
    return var_0;
  }

  return undefined;
}

function getpotentiallivingplayers() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive() && !var_2 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(level.codcasterenabled) {
      if(var_2 ismlgspectator()) {
        continue;
      }
    }

    var_0 = var_2;
  }

  return var_0;
}

function denysystemicteamchoice() {
  if(!isbot(self) && !initmaxspeedforpathlengthtable(self)) {
    if(isgamebattlematch()) {
      return true;
    }

    if(dotournamentendgame()) {
      return true;
    }

    if(level.codcasterenabled) {
      return false;
    }
  }

  if(getdvarint("scr_skipclasschoice", 0) > 0) {
    return true;
  }

  return false;
}

function allowteamassignment() {
  if(getgametype() == "br" || getgametype() == "cranked") {
    return level.teambased;
  }

  var_0 = doesmodesupportplayerteamchoice();
  return var_0;
}

function doesmodesupportplayerteamchoice() {
  if(getgametype() == "gun" || getgametype() == "infect") {
    return false;
  }

  var_0 = int(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 4));
  return var_0 > 0;
}

function allowclasschoice() {
  if(getdvarint("scr_skipclasschoice", 0) > 0 || skiploadout()) {
    return 0;
  }

  if(isDefined(level.allowclasschoicefunc)) {
    var_0 = self[[level.allowclasschoicefunc]]();

    if(isDefined(var_0)) {
      return var_0;
    }
  }

  if(scripts\mp\flags::gameflag("infil_will_run") && isDefined(level.bypassclasschoicefunc)) {
    return 0;
  }

  var_1 = int(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 5));

  if(!isai(self) && istrue(level.denyclasschoice)) {
    return 0;
  }

  return var_1;
}

function skiploadout() {
  if(getgametype() == "dm") {
    return istrue(level.aonrules);
  } else if(getgametype() == "arena") {
    return (isDefined(level.arenaloadouts) && level.arenaloadouts != 1);
  }

  return false;
}

function showfakeloadout() {
  return false;
}

function setfakeloadoutweaponslot(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3 = [];

  if(var_2 != "iw8_knife") {
    var_3 = getweaponattachments(var_0);
  }

  if(isDefined(var_2)) {
    var_4 = tablelookuprownum("mp/statstable.csv", 4, var_2);
  }

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = -1;

    if(isDefined(var_3[var_5])) {
      if(!scripts\mp\utility\weapon::isattachmentsniperscopedefault(var_0, var_3[var_5])) {
        var_6 = tablelookuprownum("mp/attachmenttable.csv", 4, var_3[var_5]);
      }
    }
  }
}

function setcommonrulesfrommatchrulesdata(var_0) {
  var_1 = getmatchrulesdata("commonOption", "teamCount");
  setdynamicdvar("scr_" + getgametype() + "_teamcount", var_1);
  var_2 = getmatchrulesdata("commonOption", "teamSize");
  setdynamicdvar("scr_" + getgametype() + "_teamsize", var_2);
  var_3 = getmatchrulesdata("commonOption", "timeLimit");
  setdynamicdvar("scr_" + getgametype() + "_timeLimit", var_3);
  registertimelimitdvar(getgametype(), var_3);
  var_4 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_" + getgametype() + "_scoreLimit", var_4);
  registerscorelimitdvar(getgametype(), var_4);
  var_5 = getmatchrulesdata("commonOption", "winLimit");
  setdynamicdvar("scr_" + getgametype() + "_winLimit", var_5);
  registerwinlimitdvar(getgametype(), var_5);
  var_6 = getmatchrulesdata("commonOption", "roundLimit");
  setdynamicdvar("scr_" + getgametype() + "_roundLimit", var_6);
  registerroundlimitdvar(getgametype(), var_6);
  var_7 = getmatchrulesdata("commonOption", "roundSwitch");
  setdynamicdvar("scr_" + getgametype() + "_roundSwitch", var_7);
  registerroundswitchdvar(getgametype(), var_7, 0, 9);
  var_8 = getmatchrulesdata("commonOption", "winByTwoEnabled");
  setdynamicdvar("scr_" + getgametype() + "_winByTwoEnabled", var_8);
  registerwinbytwoenableddvar(getgametype(), var_8);
  var_9 = getmatchrulesdata("commonOption", "winByTwoMaxRounds");
  setdynamicdvar("scr_" + getgametype() + "_winByTwoMaxRounds", var_9);
  registerwinbytwomaxroundsdvar(getgametype(), var_9);
  var_10 = getmatchrulesdata("commonOption", "dogTags");
  setdynamicdvar("scr_" + getgametype() + "_dogTags", var_10);
  registerdogtagsenableddvar(getgametype(), var_10);
  var_11 = getmatchrulesdata("commonOption", "spawnProtectionTimer");
  setdynamicdvar("scr_" + getgametype() + "_spawnProtectionTimer", var_11);
  var_12 = getmatchrulesdata("commonOption", "numLives");
  setdynamicdvar("scr_" + getgametype() + "_numLives", var_12);
  registernumlivesdvar(getgametype(), var_12);
  var_13 = getmatchrulesdata("commonOption", "numRevives");
  setdynamicdvar("scr_" + getgametype() + "_numRevives", var_13);
  registernumrevivesdvar(getgametype(), var_13);
  setdynamicdvar("scr_player_maxhealth", getmatchrulesdata("commonOption", "maxHealth"));
  setdynamicdvar("scr_player_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar("scr_" + getgametype() + "_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar("scr_player_disableSuperSprint", getmatchrulesdata("commonOption", "disableSuperSprint"));
  setdynamicdvar("scr_player_disableMount", getmatchrulesdata("commonOption", "disableMount"));
  setdynamicdvar("scr_player_lastStand", getmatchrulesdata("commonOption", "lastStand"));
  var_14 = getmatchrulesdata("commonOption", "lastStandHealth");
  setdynamicdvar("scr_" + getgametype() + "_lastStandHealth", var_14);
  registerlaststandhealthdvar(var_14);
  var_15 = getmatchrulesdata("commonOption", "lastStandReviveHealth");
  setdynamicdvar("scr_" + getgametype() + "_lastStandReviveHealth", var_15);
  registerlaststandrevivehealthdvar(var_15);
  var_16 = getmatchrulesdata("commonOption", "lastStandTimer");
  setdynamicdvar("scr_" + getgametype() + "_lastStandTimer", var_16);
  registerlaststandtimerdvar(var_16);
  var_17 = getmatchrulesdata("commonOption", "lastStandReviveTimer");
  setdynamicdvar("scr_" + getgametype() + "_lastStandReviveTimer", var_17);
  registerlaststandrevivetimerdvar(var_17);
  var_18 = getmatchrulesdata("commonOption", "lastStandSuicideTimer");
  setdynamicdvar("scr_" + getgametype() + "_lastStandSuicideTimer", var_18);
  registerlaststandsuicidetimerdvar(var_18);
  setdynamicdvar("scr_player_reviveuseweapon", getmatchrulesdata("commonOption", "reviveUseWeapon"));
  level.matchrules_damagemultiplier = 0;
  setdynamicdvar("scr_game_vampirism", getmatchrulesdata("commonOption", "vampirism"));
  setdynamicdvar("scr_game_spectatetype", getmatchrulesdata("commonOption", "spectateModeAllowed"));
  setdynamicdvar("scr_game_allowkillcam", getmatchrulesdata("commonOption", "showKillcam"));
  setdynamicdvar("scr_" + getgametype() + "_killcamType", getmatchrulesdata("commonOption", "killcamType"));
  setdynamicdvar("scr_" + getgametype() + "_allow3rdspectate", getmatchrulesdata("commonOption", "spectate3rdAllowed"));
  setdynamicdvar("scr_game_enableMinimap", getmatchrulesdata("commonOption", "enableMinimap"));
  setdynamicdvar("scr_game_forceuav", getmatchrulesdata("commonOption", "radarAlwaysOn"));
  setdynamicdvar("scr_game_radarHidePings", getmatchrulesdata("commonOption", "radarHideShots"));
  setdynamicdvar("scr_game_navBarHideEnemy", getmatchrulesdata("commonOption", "compassHideEnemy"));
  setdynamicdvar("scr_game_navBarHidePings", getmatchrulesdata("commonOption", "compassHidePings"));
  setdynamicdvar("scr_game_disablespawncamera", getmatchrulesdata("commonOption", "disableSpawnCamera"));
  setdynamicdvar("scr_" + getgametype() + "_playerrespawndelay", getmatchrulesdata("commonOption", "respawnDelay"));
  setdynamicdvar("scr_" + getgametype() + "_suicidespawndelay", getmatchrulesdata("commonOption", "suicideSpawnDelay"));
  setdynamicdvar("scr_" + getgametype() + "_waverespawndelay", getmatchrulesdata("commonOption", "waveRespawnDelay"));
  setdynamicdvar("scr_" + getgametype() + "_waverespawndelay_alt", getmatchrulesdata("commonOption", "waveRespawnDelayAlt"));
  setdynamicdvar("scr_player_forcerespawn", getmatchrulesdata("commonOption", "forceRespawn"));
  level.matchrules_allowcustomclasses = getmatchrulesdata("commonOption", "allowCustomClasses");
  level.supportintel = getmatchrulesdata("commonOption", "allowIntel");
  setdynamicdvar("scr_" + getgametype() + "_allowKillstreaks", getmatchrulesdata("commonOption", "allowKillstreaks"));
  setdynamicdvar("scr_" + getgametype() + "_allowPerks", getmatchrulesdata("commonOption", "allowPerks"));
  setdynamicdvar("scr_" + getgametype() + "_allowSupers", getmatchrulesdata("commonOption", "allowSupers"));
  setdynamicdvar("scr_" + getgametype() + "_ffPunishLimit", getmatchrulesdata("commonOption", "ffPunishLimit"));
  setdynamicdvar("scr_" + getgametype() + "_roundRetainStreaks", getmatchrulesdata("commonOption", "roundRetainStreaks"));
  setdynamicdvar("scr_" + getgametype() + "_roundRetainStreakProg", getmatchrulesdata("commonOption", "roundRetainStreakProg"));
  setdynamicdvar("scr_" + getgametype() + "_deathRetainStreaks", getmatchrulesdata("commonOption", "deathRetainStreaks"));
  setdynamicdvar("scr_game_casualScoreStreaks", getmatchrulesdata("commonOption", "casualScoreStreaks"));
  setdynamicdvar("scr_game_wrapKillstreaks", getmatchrulesdata("commonOption", "wrapKillstreaks"));
  setdynamicdvar("scr_game_superFastChargeRate", getmatchrulesdata("commonOption", "superFastChargeRate"));
  setdynamicdvar("scr_game_superPointsMod", getmatchrulesdata("commonOption", "superPointsMod"));
  setdynamicdvar("scr_game_spawnProtectionTimer", getmatchrulesdata("commonOption", "spawnProtectionTimer"));
  setdynamicdvar("scr_game_lethalDelay", getmatchrulesdata("commonOption", "equipmentDelay"));
  setdynamicdvar("scr_game_equipmentMSProtect", getmatchrulesdata("commonOption", "equipmentMSProtect"));
  setdynamicdvar("scr_game_disableBattleChatter", getmatchrulesdata("commonOption", "disableBattleChatter"));
  setdynamicdvar("scr_game_disableAnnouncer", getmatchrulesdata("commonOption", "disableAnnouncer"));
  setdynamicdvar("scr_game_inGameLoot", getmatchrulesdata("commonOption", "inGameLoot"));
  setdynamicdvar("scr_game_infilSkip", getmatchrulesdata("commonOption", "infilSkip"));
  setdynamicdvar("scr_" + getgametype() + "_practiceRound", getmatchrulesdata("commonOption", "practiceRound"));
  setdynamicdvar("scr_game_postGameExfil", getmatchrulesdata("commonOption", "postGameExfil"));
  setdynamicdvar("scr_game_exfilExtractTimer", getmatchrulesdata("commonOption", "exfilExtractTimer"));
  setdynamicdvar("scr_game_exfilActiveTimer", getmatchrulesdata("commonOption", "exfilActiveTimer"));
  setdynamicdvar("scr_player_postGameExfilWeapon", getmatchrulesdata("commonOption", "postGameExfilWeapon"));
  level.crankedbombtimer = getmatchrulesdata("commonOption", "crankedBombTimer");
  setdynamicdvar("scr_" + getgametype() + "_crankedBombTimer", level.crankedbombtimer);
  scripts\mp\cranked::registercrankedtimerdvar(getgametype(), level.crankedbombtimer);
  setdynamicdvar("scr_game_magcount", getmatchrulesdata("commonOption", "magCount"));
  setdynamicdvar("scr_game_tacticalmode", getmatchrulesdata("commonOption", "tacticalMode"));
  setdynamicdvar("scr_game_onlyheadshots", getmatchrulesdata("commonOption", "headshotsOnly"));

  if(!isDefined(var_0)) {
    setdynamicdvar("scr_team_fftype", getmatchrulesdata("commonOption", "friendlyFire"));
  }

  setDvar("bg_compassShowEnemies", getdvarint("scr_game_forceuav") == 1);
  setdynamicdvar("scr_" + getgametype() + "_enemyDeathLoc", getmatchrulesdata("commonOption", "enemyDeathLoc"));
  setdynamicdvar("scr_" + getgametype() + "_pointsPerKill", getmatchrulesdata("commonOption", "pointsPerKill"));
  setdynamicdvar("scr_" + getgametype() + "_pointsPerDeath", getmatchrulesdata("commonOption", "pointsPerDeath"));
  setdynamicdvar("scr_" + getgametype() + "_pointsHeadshotBonus", getmatchrulesdata("commonOption", "pointsHeadshotBonus"));
  setdynamicdvar("scr_" + getgametype() + "_pointsPerKSKill", getmatchrulesdata("commonOption", "pointsPerKSKill"));
  setdynamicdvar("scr_game_cdltuning", getmatchrulesdata("commonOption", "cdltuning"));
  setdynamicdvar("scr_devRemoveDomFlag", "");
  setdynamicdvar("scr_devPlaceDomFlag", "");

  if(privatematch() || level.systemlink || isanymlgmatch()) {
    level.codcasterenabled = getmatchrulesdata("commonOption", "codcasterEnabled");
    setDvar("com_codcasterEnabled", level.codcasterenabled);
    setdynamicdvar("scr_game_matchStartTime", getmatchrulesdata("commonOption", "matchStartTime"));
    setdynamicdvar("scr_game_roundStartTime", getmatchrulesdata("commonOption", "roundStartTime"));
    return;
  }
}

function reinitializematchrulesonmigration() {
  for(;;) {
    level waittill("host_migration_begin");
    [[level.initializematchrules]]();
  }
}

function reinitializethermal(var_0) {
  self endon("disconnect");

  if(isDefined(var_0)) {
    var_0 endon("death");
  }

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self.lastvisionsetthermal)) {
      self visionsetthermalforplayer(self.lastvisionsetthermal, 0);
    }
  }
}

function getmatchrulesspecialclass(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, "loadoutPrimaryAttachment2", "none");
}

function isplayeroutsideofanybombsite(var_0) {
  if(isDefined(level.objectives)) {
    foreach(var_2 in level.objectives) {
      if(self istouching(var_2.noweapondropallowedtrigger)) {
        return false;
      }
    }
  }

  return true;
}

function gamehasneutralcrateowner(var_0) {
  switch (var_0) {
    case "sotf_ffa":
    case "sotf":
      return 1;
    default:
      return 0;
  }
}

function isanymlgmatch() {
  if(isusingmatchrulesdata()) {
    if(getdvarint("killswitch_CDL_restriction_ingame") == 0 && getmatchrulesdata("cwlRulesEnabled") == 1) {
      return true;
    }
  }

  return getdvarint("xblive_competitionmatch") || istrue(level.get_wave_max_count);
}

function ismlgsystemlink() {
  if(level.systemlink && (getdvarint("xblive_competitionmatch") || istrue(level.get_wave_max_count))) {
    return true;
  }

  return false;
}

function ismlgprivatematch() {
  if(privatematch() && (getdvarint("xblive_competitionmatch") || istrue(level.get_wave_max_count))) {
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

function setmlgannouncement(var_0, var_1, var_2, var_3) {
  if(var_1 == "axis") {
    var_0 += 2000;
  } else if(var_1 == "allies") {
    var_0 += 1000;
  }

  if(isDefined(var_2)) {
    var_0 += (var_2 + 1) * 10000;
  }

  if(isDefined(var_3)) {
    if(isnumber(var_3)) {
      var_0 += (var_3 + 1) * 1000000;
    } else {
      scripts\engine\utility::error("mlg announcement extra data supports numbers only. Invalid extra data: " + var_3);
    }
  }

  if(isDefined(var_0)) {
    setomnvar("ui_mlg_announcement", var_0);
    return;
  }
}

function ismoddedroundgame() {
  if(getgametype() == "dom" || getgametype() == "ctf" || getgametype() == "rush" || getgametype() == "blitz") {
    return true;
  }

  return false;
}

function isusingdefaultclass(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1)) {
    if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "inUse")) {
      var_2 = 1;
    }
  } else {
    for(var_1 = 0; var_1 < 6; var_1++) {
      if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", var_0, var_1, "class", "inUse")) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

function getmatchrulesdatawithteamandindex(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_1 == "axis") {
    var_2 += 6;
  }

  if(isDefined(var_6)) {
    return getmatchrulesdata(var_0, var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_5)) {
    return getmatchrulesdata(var_0, var_2, var_3, var_4, var_5);
  }

  return getmatchrulesdata(var_0, var_2, var_3, var_4);
}

function isspawnprotected() {
  return gettime() < self.spawntime + level.killstreakspawnshielddelayms;
}

function ismatchstartprotected() {
  return isDefined(level.starttime) && gettime() < level.starttime + level.equipmentmatchstartshieldms;
}

function unset_relic_grounded() {
  var_0 = getgametype() == "br";
  var_1 = getgametype() == "brtdm";
  return var_0 || var_1;
}

function getgametype() {
  return level.gametype;
}

function round_vehicle_logic() {
  var_0 = getgametype();

  if(var_0 == "br") {
    var_1 = getDvar("scr_br_gametype", "");

    if(var_1 != "") {
      return var_1;
    }
  }

  return var_0;
}

function usingfallback() {
  var_0 = getgametype();
  var_1 = round_vehicle_logic();
  return var_0 != var_1;
}

function validate_track() {
  if(round_vehicle_logic() == "br") {
    return true;
  } else if(round_vehicle_logic() == "jugg") {
    return true;
  }

  return false;
}

function lpcfeaturegated() {
  if(getdvarint("scr_forceLeanThreadMode") == 1) {
    return true;
  }

  if(getgametype() == "arm" || getgametype() == "br" || getgametype() == "brtdm" || level.leanthread == 1) {
    return true;
  }

  return false;
}

function runleanthreadmode() {
  if(getdvarint("scr_forceLeanThreadMode") == 1) {
    return true;
  }

  if(getgametype() == "br" || level.leanthread == 1) {
    return true;
  }

  return false;
}

function issquadmode() {
  return getdvarint("party_maxSquadSize", 0) > 1;
}

function gamehasinfil() {
  if(!isDefined(game["infil"])) {
    return 0;
  }

  var_0 = 1;

  foreach(var_2 in level.teamnamelist) {
    if(!isDefined(game["infil"][var_2]) || !isDefined(game["infil"][var_2]["lanes"])) {
      var_0 = 0;
      break;
    }
  }

  return var_0;
}

function teamhasinfil(var_0) {
  return gamehasinfil() && scripts\mp\utility\teams::isgameplayteam(var_0) && isDefined(game["infil"][var_0]["lanes"]);
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
  var_0 = level.outofboundstime;

  if(!isDefined(var_0)) {
    var_0 = max(0, scripts\engine\utility::ter_op(matchmakinggame(), getdvarfloat("scr_outOfBoundsTime", 3), 3));
    level.outofboundstime = var_0;
  }

  return var_0;
}

function getmaxoutofboundscooldown() {
  var_0 = level.outofboundscooldown;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("scr_outOfBoundsCooldown", 3));
    level.outofboundscooldown = var_0;
  }

  return var_0;
}

function getmaxoutofboundsminefieldtime() {
  var_0 = level.outofboundstimeminefield;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("scr_outOfBoundsTimeMinefield", 3));
    level.outofboundstimeminefield = var_0;
  }

  return var_0;
}

function getmaxoutofboundsrestrictedtime() {
  level.outofboundstimerestricted = 5;
  return level.outofboundstimerestricted;
}

function repair_grill_fixing_short_sfx() {
  if(!isDefined(level.ref_12162)) {
    level.ref_12162 = max(0, getdvarfloat("scr_outOfBoundsTime", 5));
  }

  return level.ref_12162;
}

function runbrgametypefunc() {
  var_0 = self;

  if(isDefined(var_0.ref_120B4)) {
    return var_0.ref_120B4;
  }

  return undefined;
}

function repair_grill_stop_exit_foley_sfx() {
  if(!isDefined(level.ref_12164)) {
    level.ref_12164 = getdvarint("scr_br_payload_retreat_time", 30);
  }

  return level.ref_12164;
}

function repair_grill_start_enter_foley_sfx() {
  if(!isDefined(level.ref_12163)) {
    level.ref_12163 = getdvarint("scr_br_payload_redraw_time", 10);
  }

  return level.ref_12163;
}

function updateobjectivetext() {
  if(self.pers["team"] == "spectator") {
    self setclientdvar("cg_objectiveText", "");
    return;
  }

  if(level.roundscorelimit > 0 && !isobjectivebased()) {
    if(isDefined(getobjectivescoretext(self.pers["team"]))) {
      if(level.splitscreen) {
        self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]));
        return;
      }

      self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]), level.roundscorelimit);
      return;
    }

    return;
  }

  if(isDefined(getobjectivetext(self.pers["team"]))) {
    self setclientdvar("cg_objectiveText", getobjectivetext(self.pers["team"]));
    return;
  }
}

function setobjectivetext(var_0, var_1) {
  game["strings"]["objective_" + var_0] = var_1;
}

function setobjectivescoretext(var_0, var_1) {
  game["strings"]["objective_score_" + var_0] = var_1;
}

function setobjectivehinttext(var_0, var_1) {
  game["strings"]["objective_hint_" + var_0] = var_1;
}

function getobjectivetext(var_0) {
  return game["strings"]["objective_" + var_0];
}

function getobjectivescoretext(var_0) {
  return game["strings"]["objective_score_" + var_0];
}

function getobjectivehinttext(var_0) {
  return game["strings"]["objective_hint_" + var_0];
}

function testgamemodestringlist(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "" || !isDefined(var_1) || var_1 == "") {
    return 0;
  }

  return issubstr(var_0, var_1);
}

function islaststandenabled() {
  return isDefined(level.laststand) && level.laststand == 1;
}

function isteamreviveenabled() {
  return isDefined(level.laststand) && level.laststand == 2;
}

function checkrealismhudsettings() {
  if(istrue(level.testrandomrealismclients)) {
    if(!isDefined(self.isrealismenabled)) {
      if(scripts\engine\utility::cointoss()) {
        self setclientomnvar("ui_realism_hud", 1);
        self.isrealismenabled = 1;
        return;
      }

      self setclientomnvar("ui_realism_hud", 0);
      self.isrealismenabled = 0;
      return;
    }

    return;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    self setclientomnvar("ui_realism_hud", 1);
    return;
  }

  self setclientomnvar("ui_realism_hud", 0);
}

function isdefending() {
  var_1 = 0;

  switch (getgametype()) {
    case "cyber":
      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        var_2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        var_3 = distancesquared(level.cyberemp.carrier.origin, var_0.origin);

        if(var_2 < 90000 || var_3 < 90000) {
          var_1 = 1;
          break;
        }
      }

      foreach(var_5 in level.objectives) {
          if(istrue(var_5.trigger.trigger_off)) {
            continue;
          }

          var_6 = var_5.ownerteam;

          if(var_6 == self.team) {
            var_2 = distancesquared(var_5.trigger.origin, self.origin);
            var_3 = distancesquared(var_5.trigger.origin, < error > .origin);

            if(var_2 < 90000 || var_3 < 90000) {
              <
              error > = 1;
              break;
            }
          }
        }

        <
        error > = undefined;
      var_5 = undefined;
      break;
    case "dd":
    case "sr":
    case "sd":
      if(self.team != game["defenders"]) {
        break;
      }

      foreach(var_9 in level.objectives) {
        var_10 = distancesquared(var_9.trigger.origin, < error > .origin);

        if(var_10 < 90000) {
          <
          error > = 1;
          break;
        }
      }

      break;
    case "grind":
    case "pill":
    case "siege":
    case "dom":
    case "arm":
      foreach(var_9 in level.objectives) {
        if(self.team != var_9.ownerteam) {
          continue;
        }

        var_13 = distancesquared(var_9.curorigin, self.origin);
        var_14 = distancesquared(var_9.curorigin, < error > .origin);

        if(var_13 < 90000 || var_14 < 90000) {
          <
          error > = 1;
          break;
        }
      }

      break;
    case "grnd":
    case "koth":
    case "hq":
      if(isDefined(level.zone)) {
        <
        error > = ispointinvolume(self.origin, level.zone.trigger) || ispointinvolume( < error > .origin, level.zone.trigger);
      }

      break;
  }

  return < error > ;
}

function turret_outline_watcher() {
  var_1 = 0;

  switch (getgametype()) {
    case "cyber":
      if(istrue(var_0.isbombcarrier)) {
        var_1 = 1;
        break;
      }

      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        var_2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        var_3 = distancesquared(level.cyberemp.carrier.origin, var_0.origin);

        if(var_2 < 90000 || var_3 < 90000) {
          var_1 = 1;
          break;
        }
      }

      foreach(var_5 in level.objectives) {
          if(istrue(var_5.trigger.trigger_off)) {
            continue;
          }

          var_6 = var_5.ownerteam;

          if(var_6 != self.team) {
            var_7 = distancesquared(var_5.trigger.origin, self.origin);
            var_8 = distancesquared(var_5.trigger.origin, < error > .origin);

            if(var_7 < 90000 || var_8 < 90000) {
              <
              error > = 1;
              break;
            }
          }
        }

        <
        error > = undefined;
      var_5 = undefined;
      break;
    case "dd":
    case "sr":
    case "sd":
      if(self.team == game["defenders"]) {
        break;
      }

      foreach(var_11 in level.objectives) {
        var_12 = distancesquared(var_11.trigger.origin, < error > .origin);

        if(var_12 < 90000) {
          <
          error > = 1;
          break;
        }
      }

      break;
    case "grind":
    case "pill":
    case "siege":
    case "dom":
    case "arm":
      foreach(var_11 in level.objectives) {
        if(self.team == var_11.ownerteam) {
          continue;
        }

        var_7 = distancesquared(var_11.curorigin, self.origin);
        var_8 = distancesquared(var_11.curorigin, < error > .origin);

        if(var_7 < 90000 || var_8 < 90000) {
          <
          error > = 1;
          break;
        }
      }

      break;
    case "grnd":
    case "koth":
    case "hq":
      if(isDefined(level.zone)) {
        <
        error > = ispointinvolume(self.origin, level.zone.trigger) || ispointinvolume( < error > .origin, level.zone.trigger);
      }

      break;
  }

  return < error > ;
}

function gametypesupportsbasejumping() {
  switch (getgametype()) {
    case "war":
    case "trial":
    case "brtdm":
    case "siege":
    case "dom":
    case "infect":
    case "br":
    case "arm":
      return 1;
    default:
      return 0;
  }
}

function mapsupportsbasejumping() {
  if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    return 1;
  }

  switch (level.mapname) {
    case "mp_carpoc_test":
    case "mp_riverside_gw":
    case "mp_promenade_gw":
    case "mp_layover_gw":
    case "mp_boneyard_gw":
    case "mp_farms2":
    case "mp_bm_bunker01":
    case "mp_firingrange":
    case "mp_br_mechanics":
    case "mp_wz_island":
    case "mp_port2_gw":
    case "mp_farms2_gw":
    case "mp_downtown_gw":
    case "mp_quarry2":
    case "mp_locale_test":
      return 1;
    default:
      return 0;
  }
}

function ref_119AC(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());

  if(!isDefined(var_2)) {
    return;
  }

  var_6 = "";

  if(isDefined(var_4)) {
    var_6 = var_4;
  } else {
    var_6 = "none";
  }

  if(!isDefined(var_0)) {
    if(isDefined(var_3)) {
      getentitylessscriptablearray("dlog_event_announcement", ["time_from_match_start", var_5, "announcement", var_2, "extra_info", var_6, "player_team", "none", "contester_team", "none", "zone_x", var_3[0], "zone_y", var_3[1], "zone_z", var_3[2]]);
      return;
    }

    getentitylessscriptablearray("dlog_event_announcement", ["time_from_match_start", var_5, "announcement", var_2, "extra_info", var_6]);
    return;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_3)) {
      getentitylessscriptablearray("dlog_event_announcement", ["player", var_0, "contester", var_1, "time_from_match_start", var_5, "announcement", var_2, "extra_info", var_6, "player_team", var_0.team, "contester_team", var_1.team, "zone_x", var_3[0], "zone_y", var_3[1], "zone_z", var_3[2]]);
      return;
    }

    getentitylessscriptablearray("dlog_event_announcement", ["player", var_0, "contester", var_1, "time_from_match_start", var_5, "announcement", var_2, "extra_info", var_6, "player_team", var_0.team, "contester_team", var_1.team]);
    return;
  }

  if(isDefined(var_3)) {
    getentitylessscriptablearray("dlog_event_announcement", ["player", var_0, "time_from_match_start", var_5, "announcement", var_2, "extra_info", var_6, "player_team", var_0.team, "contester_team", "none", "zone_x", var_3[0], "zone_y", var_3[1], "zone_z", var_3[2]]);
    return;
  }

  getentitylessscriptablearray("dlog_event_announcement", ["player", var_0, "time_from_match_start", var_5, "announcement", var_2, "extra_info", var_6, "player_team", var_0.team]);
}

function updatex1stashhud() {
  return istrue(level.updatex1prematchloadoutarray);
}

function unset_relic_landlocked() {
  return istrue(level.unset_relic_laststandmelee) || istrue(level.unset_relic_lfo) || istrue(level.unset_relic_laststand);
}

function vcloseangles() {
  var_0 = 0;

  switch (scripts\cp_mp\utility\game_utility::getmapname()) {
    case "mp_riverside_gw":
    case "mp_promenade_gw":
    case "mp_layover_gw":
    case "mp_boneyard_gw":
    case "mp_port2_gw":
    case "mp_farms2_gw":
    case "mp_downtown_gw":
    case "mp_quarry2":
      return 1;
    default:
      return 0;
  }
}

function get_allowed_vehicle_types_from_spawnpoint(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = scripts\cp_mp\utility\game_utility::getmapname();

  if((getgametype() == "arm" || unset_relic_landlocked()) && vcloseangles() || getdvarint("scr_game_forceEnableParachuteCut", 0) == 1) {
    if(var_3 != "mp_aniyah") {
      if(istrue(level.ref_121C8)) {
        var_1 = 1;
      }

      if(istrue(level.ref_121C9) && !istrue(var_0.little_bird_mg_playerexitturret)) {
        var_2 = 1;
      }
    }
  }

  if(var_1) {
    var_0 getclientomnvar();
  } else {
    var_0 weaponswitchbuttonPressed();
  }

  if(var_2) {
    var_0 skydive_cutautodeployon();
    return;
  }

  var_0 skydive_cutautodeployoff();
}

function tv_station_intro_camera() {
  return matchmakinggame() && getdvarint("scr_classtable_override", 0) > 0;
}

function usefloorrocks() {
  return matchmakinggame() && getdvarint("scr_classtable_override", 0) == 1;
}

function handle_carry_special_item() {
  if(tv_station_intro_camera()) {
    switch (getdvarint("scr_classtable_override", 0)) {
      case 1:
        return true;
      default:
        return false;
    }
  } else if(isDefined(level.set_systems_init_flag) && level.set_systems_init_flag > 0) {
    return true;
  }

  return false;
}

function usequesttimer() {
  return getdvarint("scr_enable_server_halloween_content", 0) != 0;
}

function updatetextongamepadchange() {
  switch (getgametype()) {
    case "brtdm":
      return false;
    case "br":
      switch (round_vehicle_logic()) {
        case "x2":
        case "payload":
        case "gold_war":
        case "kingslayer":
        case "risk":
        case "rat_race":
        case "dmz":
        case "rumble":
          return false;
      }

      break;
  }

  return true;
}

function ref_131A3(var_0, var_1) {
  if(var_1) {
    var_0.c130 = 1;
    return;
  }

  var_0.c130 = undefined;
}

function updatehistoryhud(var_0) {
  return istrue(var_0.c130);
}