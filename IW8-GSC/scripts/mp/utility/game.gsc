/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\game.gsc
***********************************************/

function getotherteam(var0) {
  return scripts\mp\utility\teams::getenemyteams(var0);
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
  var0 = gettimelimit();

  if(var0 == 0) {
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

function setuipostgamefade(var0, var1) {
  self endon("disconnect");

  if(istrue(level.nukedetonated)) {
    return;
  }

  if(!isDefined(self.fadecurrent)) {
    self.fadecurrent = 0;
  }

  if(self.fadecurrent == var0) {
    return;
  }

  if(isDefined(var1)) {
    wait var1;
  }

  self notify("setUIPostGameFade");
  self endon("setUIPostGameFade");

  if(self.fadecurrent < var0) {
    self.fadecurrent = clamp(self.fadecurrent + 0.5 * abs(self.fadecurrent - var0), 0, 1);
  } else {
    self.fadecurrent = clamp(self.fadecurrent - 0.5 * abs(self.fadecurrent - var0), 0, 1);
  }

  self setclientomnvar("ui_total_fade", self.fadecurrent);
  wait 0.1;
  self.fadecurrent = var0;
  self setclientomnvar("ui_total_fade", self.fadecurrent);
}

function registerroundswitchdvar(var0, var1, var2, var3) {
  scripts\mp\utility\dvars::registerwatchdvarint("roundswitch", var1);
  var0 = "scr_" + var0 + "_roundswitch";
  level.roundswitchdvar = var0;
  level.roundswitchmin = var2;
  level.roundswitchmax = var3;
  level.roundswitch = getdvarint(var0, var1);

  if(level.roundswitch < var2) {
    level.roundswitch = var2;
    return;
  }

  if(level.roundswitch > var3) {
    level.roundswitch = var3;
    return;
  }
}

function registerroundlimitdvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("roundlimit", var1);
}

function registernumteamsdvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("numTeams", var1);
}

function registerwinlimitdvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("winlimit", var1);
}

function registerwinbytwoenableddvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("winbytwoenabled", var1);
}

function registerwinbytwomaxroundsdvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("winbytwomaxrounds", var1);
}

function registerdogtagsenableddvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("dogtags", var1);
}

function registerscorelimitdvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("scorelimit", var1);
}

function registertimelimitdvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("timelimit", var1);
  setDvar("ui_timelimit", gettimelimit());
}

function registerhalftimedvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("halftime", var1);
  setDvar("ui_halftime", gethalftime());
}

function registernumlivesdvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("numlives", var1);
}

function registernumrevivesdvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("numrevives", var1);
}

function setovertimelimitdvar(var0) {
  setDvar("overtimeTimeLimit", var0);
}

function registerlaststandhealthdvar(var0) {
  scripts\mp\utility\dvars::registerwatchdvarint("lastStandHealth", var0);
}

function registerlaststandrevivehealthdvar(var0) {
  scripts\mp\utility\dvars::registerwatchdvarint("lastStandReviveHealth", var0);
}

function registerlaststandtimerdvar(var0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandTimer", var0);
}

function registerlaststandrevivetimerdvar(var0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandReviveTimer", var0);
}

function registerlaststandweapondvar(var0) {
  scripts\mp\utility\dvars::registerwatchdvar("lastStandWeapon", var0);
}

function registerlaststandweapondelaydvar(var0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandWeaponDelay", var0);
}

function registerlaststandsuicidetimerdvar(var0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandSuicideTimer", var0);
}

function registerlaststandinvulntimerdvar(var0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandInvulnTimer", var0);
}

function registerlaststandrevivedecayscaledvar(var0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandReviveDecayScale", var0);
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

function safehouse_vo_return_start(var0) {
  return "team_two_hundred";
}

function vehicle_collision_ignorefuturemultievent(var0) {
  if(var0 == safehouse_vo_return_start() && (isDefined(level.ref_14687) || deposit_from_compromised_convoy_delayed_failsafe())) {
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

  var0 = 0;

  foreach(var2 in level.teamnamelist) {
    if(vehicle_collision_ignorefuturemultievent(level, var2)) {
      continue;
    }

    var3 = getroundswon(var2);

    if(var3 == level.winlimit - 1) {
      var0 = 1;
      break;
    }
  }

  var5 = level.winlimit > 0 && var0;

  if(var5 && allteamstied()) {
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

  var0 = 0;

  foreach(var2 in level.teamnamelist) {
    if(vehicle_collision_ignorefuturemultievent(level, var2)) {
      continue;
    }

    var3 = getroundswon(var2);

    if(var3 == level.winlimit - 1) {
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
  var0 = game["roundsWon"]["allies"];
  var1 = game["roundsWon"]["axis"];
  return iswinbytworulegametype() && abs(var0 - var1) < 2 && game["overtimeRoundsPlayed"] < getmaxwinbytworounds();
}

function islastwinbytwo() {
  return shouldplaywinbytwo() && game["overtimeRoundsPlayed"] == getmaxwinbytworounds() - 1;
}

function ref_1332b() {
  var0 = game["roundsWon"]["allies"];
  var1 = game["roundsWon"]["axis"];
  return abs(var0 - var1) < 2;
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

function settimetobeat(var0) {
  if(!istimetobeatrulegametype()) {
    return false;
  }

  var1 = getsecondspassed();
  var2 = scripts\mp\gamescore::_getteamscore(var0);

  if(!istimetobeatvalid() || var1 < game["timeToBeat"] && var2 >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != var0) {
      game["timeToBeatOld"] = game["timeToBeat"];
    }

    game["timeToBeat"] = var1;
    game["timeToBeatTeam"] = var0;
    game["timeToBeatScore"] = var2;
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

function setscoretobeat(var0, var1) {
  if(!isscoretobeatrulegametype()) {
    return 0;
  }

  var2 = game["timeToBeatTeam"] != "none" && var1 == game["timeToBeatScore"];

  if(var1 >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != var0) {
      game["timeToBeatScoreOld"] = game["timeToBeatScore"];
    }

    game["timeToBeatTeam"] = var0;
    game["timeToBeatScore"] = var1;
  }

  foreach(var4 in level.players) {
    var4 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var4.team == game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
    var4 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var4.team != game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
  }

  if(var2) {
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

  var0 = 0;

  switch (getgametype()) {
    case "payload":
    case "blitz":
    case "ball":
    case "ctf":
    case "siege":
    case "sr":
    case "sd":
      var0 = 2;
      break;
    case "cmd":
    case "dd":
      var0 = 1;
      break;
  }

  if(isanymlgmatch() && !istimetobeatrulegametype()) {
    return -1;
  }

  return var0;
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
    level.simultaneouskillenabled = getdvarint("MRSNQSMSPL", 0) == 0;
  }

  return level.simultaneouskillenabled;
}

function cantiebysimultaneouskill() {
  if(!issimultaneouskillenabled()) {
    return 0;
  }

  var0 = 0;

  switch (getgametype()) {
    case "dm":
    case "war":
    case "brtdm":
    case "gun":
    case "front":
    case "arm":
      var0 = 1;
      break;
  }

  return var0;
}

function shouldplayovertime() {
  if(!hitroundlimit() && !hitwinlimit()) {
    return false;
  }

  if(!isovertimesupportedgametype()) {
    return false;
  }

  var0 = allteamstied();

  if(var0 && inovertime()) {
    var1 = getmaxovertimeroundsbygametype();
    var0 = scripts\engine\utility::ter_op(var1 == -1, 1, game["overtimeRoundsPlayed"] < var1);
  }

  var2 = shouldplaywinbytwo();
  var3 = shouldplaytimetobeatot();
  var4 = shouldplayscoretobeatot();
  return !level.forcedend && (var0 || var2 || var3 || var4);
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

  var0 = scripts\mp\gamelogic::gettimeremaining();

  if(var0 > 0) {
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
    foreach(var1 in level.teamnamelist) {
      if(game["teamScores"][var1] >= level.roundscorelimit) {
        return true;
      }
    }
  } else {
    for(var3 = 0; var3 < level.players.size; var3++) {
      var4 = level.players[var3];

      if(isDefined(var4.score) && var4.score >= level.roundscorelimit) {
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

  foreach(var1 in level.teamnamelist) {
    if(getroundswon(var1) >= level.winlimit) {
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

function getroundswon(var0) {
  return game["roundsWon"][var0];
}

function allteamstied() {
  var0 = getwingamebytype();
  var1 = undefined;

  foreach(var3 in level.teamnamelist) {
    if(!isDefined(var1)) {
      var1 = game[var0][var3];
      continue;
    }

    if(var1 != game[var0][var3]) {
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

    var0 = getdvarfloat("overtimeTimeLimit");

    if(var0 > 0) {
      return var0;
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
    foreach(var1 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var1, "hasSpawned")) {
        return 1;
      }
    }

    return 0;
  }

  return level.maxplayercount > 1;
}

function getlivingplayers(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(!isalive(var3)) {
      continue;
    }

    if(level.teambased && isDefined(var0)) {
      if(var0 == var3.pers["team"]) {
        var1 = var3;
      }

      continue;
    }

    var1 = var3;
  }

  return var1;
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
  return level.onlinegame && getdvarint("LSTLQTSSRM");
}

function lobbyteamselectenabled() {
  return level.systemlink || privatematch() && getdvarint("NQORMNOQQM", 0) || function_0426();
}

function matchmakinggame() {
  return level.matchmakingmatch;
}

function getgametypenumlives() {
  return scripts\mp\utility\dvars::getwatcheddvar("numlives");
}

function getlastlivingplayer(var0) {
  var1 = undefined;

  foreach(var3 in level.players) {
    if(isDefined(var0) && var3.team != var0) {
      continue;
    }

    if(!var3 scripts\cp_mp\utility\player_utility::_isalive() && !var3 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(isDefined(var3.switching_teams) && var3.switching_teams) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function ref_13e13() {
  var0 = undefined;

  foreach(var2 in level.players) {
    if(!var2 scripts\cp_mp\utility\player_utility::_isalive() && !var2 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(level.codcasterenabled) {
      if(var2 ismlgspectator()) {
        continue;
      }
    }

    if(isDefined(var0)) {
      return undefined;
    }

    var0 = var2;
  }

  if(isDefined(var0)) {
    return var0;
  }

  return undefined;
}

function getpotentiallivingplayers() {
  var0 = [];

  foreach(var2 in level.players) {
    if(!var2 scripts\cp_mp\utility\player_utility::_isalive() && !var2 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }

    if(level.codcasterenabled) {
      if(var2 ismlgspectator()) {
        continue;
      }
    }

    var0 = var2;
  }

  return var0;
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

  var0 = doesmodesupportplayerteamchoice();
  return var0;
}

function doesmodesupportplayerteamchoice() {
  if(getgametype() == "gun" || getgametype() == "infect") {
    return false;
  }

  var0 = int(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 4));
  return var0 > 0;
}

function allowclasschoice() {
  if(getdvarint("scr_skipclasschoice", 0) > 0 || skiploadout()) {
    return 0;
  }

  if(isDefined(level.allowclasschoicefunc)) {
    var0 = self[[level.allowclasschoicefunc]]();

    if(isDefined(var0)) {
      return var0;
    }
  }

  if(scripts\mp\flags::gameflag("infil_will_run") && isDefined(level.bypassclasschoicefunc)) {
    return 0;
  }

  var1 = int(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 5));

  if(!isai(self) && istrue(level.denyclasschoice)) {
    return 0;
  }

  return var1;
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

function setfakeloadoutweaponslot(var0, var1) {
  var2 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var3 = [];

  if(var2 != "iw8_knife") {
    var3 = getweaponattachments(var0);
  }

  if(isDefined(var2)) {
    var4 = tablelookuprownum("mp/statstable.csv", 4, var2);
  }

  for(var5 = 0; var5 < 3; var5++) {
    var6 = -1;

    if(isDefined(var3[var5])) {
      if(!scripts\mp\utility\weapon::isattachmentsniperscopedefault(var0, var3[var5])) {
        var6 = tablelookuprownum("mp/attachmenttable.csv", 4, var3[var5]);
      }
    }
  }
}

function setcommonrulesfrommatchrulesdata(var0) {
  var1 = getmatchrulesdata("commonOption", "teamCount");
  setdynamicdvar("scr_" + getgametype() + "_teamcount", var1);
  var2 = getmatchrulesdata("commonOption", "teamSize");
  setdynamicdvar("scr_" + getgametype() + "_teamsize", var2);
  var3 = getmatchrulesdata("commonOption", "timeLimit");
  setdynamicdvar("scr_" + getgametype() + "_timeLimit", var3);
  registertimelimitdvar(getgametype(), var3);
  var4 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_" + getgametype() + "_scoreLimit", var4);
  registerscorelimitdvar(getgametype(), var4);
  var5 = getmatchrulesdata("commonOption", "winLimit");
  setdynamicdvar("scr_" + getgametype() + "_winLimit", var5);
  registerwinlimitdvar(getgametype(), var5);
  var6 = getmatchrulesdata("commonOption", "roundLimit");
  setdynamicdvar("scr_" + getgametype() + "_roundLimit", var6);
  registerroundlimitdvar(getgametype(), var6);
  var7 = getmatchrulesdata("commonOption", "roundSwitch");
  setdynamicdvar("scr_" + getgametype() + "_roundSwitch", var7);
  registerroundswitchdvar(getgametype(), var7, 0, 9);
  var8 = getmatchrulesdata("commonOption", "winByTwoEnabled");
  setdynamicdvar("scr_" + getgametype() + "_winByTwoEnabled", var8);
  registerwinbytwoenableddvar(getgametype(), var8);
  var9 = getmatchrulesdata("commonOption", "winByTwoMaxRounds");
  setdynamicdvar("scr_" + getgametype() + "_winByTwoMaxRounds", var9);
  registerwinbytwomaxroundsdvar(getgametype(), var9);
  var10 = getmatchrulesdata("commonOption", "dogTags");
  setdynamicdvar("scr_" + getgametype() + "_dogTags", var10);
  registerdogtagsenableddvar(getgametype(), var10);
  var11 = getmatchrulesdata("commonOption", "spawnProtectionTimer");
  setdynamicdvar("scr_" + getgametype() + "_spawnProtectionTimer", var11);
  var12 = getmatchrulesdata("commonOption", "numLives");
  setdynamicdvar("scr_" + getgametype() + "_numLives", var12);
  registernumlivesdvar(getgametype(), var12);
  var13 = getmatchrulesdata("commonOption", "numRevives");
  setdynamicdvar("scr_" + getgametype() + "_numRevives", var13);
  registernumrevivesdvar(getgametype(), var13);
  setdynamicdvar("scr_player_maxhealth", getmatchrulesdata("commonOption", "maxHealth"));
  setdynamicdvar("scr_player_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar("scr_" + getgametype() + "_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar("scr_player_disableSuperSprint", getmatchrulesdata("commonOption", "disableSuperSprint"));
  setdynamicdvar("scr_player_disableMount", getmatchrulesdata("commonOption", "disableMount"));
  setdynamicdvar("scr_player_lastStand", getmatchrulesdata("commonOption", "lastStand"));
  var14 = getmatchrulesdata("commonOption", "lastStandHealth");
  setdynamicdvar("scr_" + getgametype() + "_lastStandHealth", var14);
  registerlaststandhealthdvar(var14);
  var15 = getmatchrulesdata("commonOption", "lastStandReviveHealth");
  setdynamicdvar("scr_" + getgametype() + "_lastStandReviveHealth", var15);
  registerlaststandrevivehealthdvar(var15);
  var16 = getmatchrulesdata("commonOption", "lastStandTimer");
  setdynamicdvar("scr_" + getgametype() + "_lastStandTimer", var16);
  registerlaststandtimerdvar(var16);
  var17 = getmatchrulesdata("commonOption", "lastStandReviveTimer");
  setdynamicdvar("scr_" + getgametype() + "_lastStandReviveTimer", var17);
  registerlaststandrevivetimerdvar(var17);
  var18 = getmatchrulesdata("commonOption", "lastStandSuicideTimer");
  setdynamicdvar("scr_" + getgametype() + "_lastStandSuicideTimer", var18);
  registerlaststandsuicidetimerdvar(var18);
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

  if(!isDefined(var0)) {
    setdynamicdvar("scr_team_fftype", getmatchrulesdata("commonOption", "friendlyFire"));
  }

  setDvar("MPOKQNLPRM", getdvarint("scr_game_forceuav") == 1);
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
    setDvar("MOSNOQPOSS", level.codcasterenabled);
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

function reinitializethermal(var0) {
  self endon("disconnect");

  if(isDefined(var0)) {
    var0 endon("death");
  }

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self.lastvisionsetthermal)) {
      self visionsetthermalforplayer(self.lastvisionsetthermal, 0);
    }
  }
}

function getmatchrulesspecialclass(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, "loadoutPrimaryAttachment2", "none");
}

function isplayeroutsideofanybombsite(var0) {
  if(isDefined(level.objectives)) {
    foreach(var2 in level.objectives) {
      if(self istouching(var2.noweapondropallowedtrigger)) {
        return false;
      }
    }
  }

  return true;
}

function gamehasneutralcrateowner(var0) {
  switch (var0) {
    case "sotf_ffa":
    case "sotf":
      return 1;
    default:
      return 0;
  }
}

function isanymlgmatch() {
  if(isusingmatchrulesdata()) {
    if(getdvarint("NTLNTTNNLQ") == 0 && getmatchrulesdata("cwlRulesEnabled") == 1) {
      return true;
    }
  }

  return getdvarint("LOMTKQTRTM") || istrue(level.get_wave_max_count);
}

function ismlgsystemlink() {
  if(level.systemlink && (getdvarint("LOMTKQTRTM") || istrue(level.get_wave_max_count))) {
    return true;
  }

  return false;
}

function ismlgprivatematch() {
  if(privatematch() && (getdvarint("LOMTKQTRTM") || istrue(level.get_wave_max_count))) {
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

function setmlgannouncement(var0, var1, var2, var3) {
  if(var1 == "axis") {
    var0 += 2000;
  } else if(var1 == "allies") {
    var0 += 1000;
  }

  if(isDefined(var2)) {
    var0 += (var2 + 1) * 10000;
  }

  if(isDefined(var3)) {
    if(isnumber(var3)) {
      var0 += (var3 + 1) * 1000000;
    } else {
      scripts\engine\utility::error("mlg announcement extra data supports numbers only. Invalid extra data: " + var3);
    }
  }

  if(isDefined(var0)) {
    setomnvar("ui_mlg_announcement", var0);
    return;
  }
}

function ismoddedroundgame() {
  if(getgametype() == "dom" || getgametype() == "ctf" || getgametype() == "rush" || getgametype() == "blitz") {
    return true;
  }

  return false;
}

function isusingdefaultclass(var0, var1) {
  var2 = 0;

  if(isDefined(var1)) {
    if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", var0, var1, "class", "inUse")) {
      var2 = 1;
    }
  } else {
    for(var1 = 0; var1 < 6; var1++) {
      if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", var0, var1, "class", "inUse")) {
        var2 = 1;
        break;
      }
    }
  }

  return var2;
}

function getmatchrulesdatawithteamandindex(var0, var1, var2, var3, var4, var5, var6) {
  if(var1 == "axis") {
    var2 += 6;
  }

  if(isDefined(var6)) {
    return getmatchrulesdata(var0, var2, var3, var4, var5, var6);
  }

  if(isDefined(var5)) {
    return getmatchrulesdata(var0, var2, var3, var4, var5);
  }

  return getmatchrulesdata(var0, var2, var3, var4);
}

function isspawnprotected() {
  return gettime() < self.spawntime + level.killstreakspawnshielddelayms;
}

function ismatchstartprotected() {
  return isDefined(level.starttime) && gettime() < level.starttime + level.equipmentmatchstartshieldms;
}

function unset_relic_grounded() {
  var0 = getgametype() == "br";
  var1 = getgametype() == "brtdm";
  return var0 || var1;
}

function getgametype() {
  return level.gametype;
}

function round_vehicle_logic() {
  var0 = getgametype();

  if(var0 == "br") {
    var1 = getDvar("scr_br_gametype", "");

    if(var1 != "") {
      return var1;
    }
  }

  return var0;
}

function usingfallback() {
  var0 = getgametype();
  var1 = round_vehicle_logic();
  return var0 != var1;
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
  return getdvarint("RRNTNNKNP", 0) > 1;
}

function gamehasinfil() {
  if(!isDefined(game["infil"])) {
    return 0;
  }

  var0 = 1;

  foreach(var2 in level.teamnamelist) {
    if(!isDefined(game["infil"][var2]) || !isDefined(game["infil"][var2]["lanes"])) {
      var0 = 0;
      break;
    }
  }

  return var0;
}

function teamhasinfil(var0) {
  return gamehasinfil() && scripts\mp\utility\teams::isgameplayteam(var0) && isDefined(game["infil"][var0]["lanes"]);
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
  var0 = level.outofboundstime;

  if(!isDefined(var0)) {
    var0 = max(0, scripts\engine\utility::ter_op(matchmakinggame(), getdvarfloat("scr_outOfBoundsTime", 3), 3));
    level.outofboundstime = var0;
  }

  return var0;
}

function getmaxoutofboundscooldown() {
  var0 = level.outofboundscooldown;

  if(!isDefined(var0)) {
    var0 = max(0, getdvarfloat("scr_outOfBoundsCooldown", 3));
    level.outofboundscooldown = var0;
  }

  return var0;
}

function getmaxoutofboundsminefieldtime() {
  var0 = level.outofboundstimeminefield;

  if(!isDefined(var0)) {
    var0 = max(0, getdvarfloat("scr_outOfBoundsTimeMinefield", 3));
    level.outofboundstimeminefield = var0;
  }

  return var0;
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
  var0 = self;

  if(isDefined(var0.ref_120b4)) {
    return var0.ref_120b4;
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
    self setclientdvar("MSRPQTQOOK", "");
    return;
  }

  if(level.roundscorelimit > 0 && !isobjectivebased()) {
    if(isDefined(getobjectivescoretext(self.pers["team"]))) {
      if(level.splitscreen) {
        self setclientdvar("MSRPQTQOOK", getobjectivescoretext(self.pers["team"]));
        return;
      }

      self setclientdvar("MSRPQTQOOK", getobjectivescoretext(self.pers["team"]), level.roundscorelimit);
      return;
    }

    return;
  }

  if(isDefined(getobjectivetext(self.pers["team"]))) {
    self setclientdvar("MSRPQTQOOK", getobjectivetext(self.pers["team"]));
    return;
  }
}

function setobjectivetext(var0, var1) {
  game["strings"]["objective_" + var0] = var1;
}

function setobjectivescoretext(var0, var1) {
  game["strings"]["objective_score_" + var0] = var1;
}

function setobjectivehinttext(var0, var1) {
  game["strings"]["objective_hint_" + var0] = var1;
}

function getobjectivetext(var0) {
  return game["strings"]["objective_" + var0];
}

function getobjectivescoretext(var0) {
  return game["strings"]["objective_score_" + var0];
}

function getobjectivehinttext(var0) {
  return game["strings"]["objective_hint_" + var0];
}

function testgamemodestringlist(var0, var1) {
  if(!isDefined(var0) || var0 == "" || !isDefined(var1) || var1 == "") {
    return 0;
  }

  return issubstr(var0, var1);
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
  var1 = 0;

  switch (getgametype()) {
    case "cyber":
      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        var2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        var3 = distancesquared(level.cyberemp.carrier.origin, var0.origin);

        if(var2 < 90000 || var3 < 90000) {
          var1 = 1;
          break;
        }
      }

      foreach(var5 in level.objectives) {
          if(istrue(var5.trigger.trigger_off)) {
            continue;
          }

          var6 = var5.ownerteam;

          if(var6 == self.team) {
            var2 = distancesquared(var5.trigger.origin, self.origin);
            var3 = distancesquared(var5.trigger.origin, < error > .origin);

            if(var2 < 90000 || var3 < 90000) {
              <
              error > = 1;
              break;
            }
          }
        }

        <
        error > = undefined;
      var5 = undefined;
      break;
    case "dd":
    case "sr":
    case "sd":
      if(self.team != game["defenders"]) {
        break;
      }

      foreach(var9 in level.objectives) {
        var10 = distancesquared(var9.trigger.origin, < error > .origin);

        if(var10 < 90000) {
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
      foreach(var9 in level.objectives) {
        if(self.team != var9.ownerteam) {
          continue;
        }

        var13 = distancesquared(var9.curorigin, self.origin);
        var14 = distancesquared(var9.curorigin, < error > .origin);

        if(var13 < 90000 || var14 < 90000) {
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
  var1 = 0;

  switch (getgametype()) {
    case "cyber":
      if(istrue(var0.isbombcarrier)) {
        var1 = 1;
        break;
      }

      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        var2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        var3 = distancesquared(level.cyberemp.carrier.origin, var0.origin);

        if(var2 < 90000 || var3 < 90000) {
          var1 = 1;
          break;
        }
      }

      foreach(var5 in level.objectives) {
          if(istrue(var5.trigger.trigger_off)) {
            continue;
          }

          var6 = var5.ownerteam;

          if(var6 != self.team) {
            var7 = distancesquared(var5.trigger.origin, self.origin);
            var8 = distancesquared(var5.trigger.origin, < error > .origin);

            if(var7 < 90000 || var8 < 90000) {
              <
              error > = 1;
              break;
            }
          }
        }

        <
        error > = undefined;
      var5 = undefined;
      break;
    case "dd":
    case "sr":
    case "sd":
      if(self.team == game["defenders"]) {
        break;
      }

      foreach(var11 in level.objectives) {
        var12 = distancesquared(var11.trigger.origin, < error > .origin);

        if(var12 < 90000) {
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
      foreach(var11 in level.objectives) {
        if(self.team == var11.ownerteam) {
          continue;
        }

        var7 = distancesquared(var11.curorigin, self.origin);
        var8 = distancesquared(var11.curorigin, < error > .origin);

        if(var7 < 90000 || var8 < 90000) {
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

function ref_119ac(var0, var1, var2, var3, var4) {
  var5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());

  if(!isDefined(var2)) {
    return;
  }

  var6 = "";

  if(isDefined(var4)) {
    var6 = var4;
  } else {
    var6 = "none";
  }

  if(!isDefined(var0)) {
    if(isDefined(var3)) {
      getentitylessscriptablearray("dlog_event_announcement", ["time_from_match_start", var5, "announcement", var2, "extra_info", var6, "player_team", "none", "contester_team", "none", "zone_x", var3[0], "zone_y", var3[1], "zone_z", var3[2]]);
      return;
    }

    getentitylessscriptablearray("dlog_event_announcement", ["time_from_match_start", var5, "announcement", var2, "extra_info", var6]);
    return;
  }

  if(isDefined(var1)) {
    if(isDefined(var3)) {
      getentitylessscriptablearray("dlog_event_announcement", ["player", var0, "contester", var1, "time_from_match_start", var5, "announcement", var2, "extra_info", var6, "player_team", var0.team, "contester_team", var1.team, "zone_x", var3[0], "zone_y", var3[1], "zone_z", var3[2]]);
      return;
    }

    getentitylessscriptablearray("dlog_event_announcement", ["player", var0, "contester", var1, "time_from_match_start", var5, "announcement", var2, "extra_info", var6, "player_team", var0.team, "contester_team", var1.team]);
    return;
  }

  if(isDefined(var3)) {
    getentitylessscriptablearray("dlog_event_announcement", ["player", var0, "time_from_match_start", var5, "announcement", var2, "extra_info", var6, "player_team", var0.team, "contester_team", "none", "zone_x", var3[0], "zone_y", var3[1], "zone_z", var3[2]]);
    return;
  }

  getentitylessscriptablearray("dlog_event_announcement", ["player", var0, "time_from_match_start", var5, "announcement", var2, "extra_info", var6, "player_team", var0.team]);
}

function updatex1stashhud() {
  return istrue(level.updatex1prematchloadoutarray);
}

function unset_relic_landlocked() {
  return istrue(level.unset_relic_laststandmelee) || istrue(level.unset_relic_lfo) || istrue(level.unset_relic_laststand);
}

function vcloseangles() {
  var0 = 0;

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

function get_allowed_vehicle_types_from_spawnpoint(var0) {
  var1 = 0;
  var2 = 0;
  var3 = scripts\cp_mp\utility\game_utility::getmapname();

  if((getgametype() == "arm" || unset_relic_landlocked()) && vcloseangles() || getdvarint("scr_game_forceEnableParachuteCut", 0) == 1) {
    if(var3 != "mp_aniyah") {
      if(istrue(level.ref_121c8)) {
        var1 = 1;
      }

      if(istrue(level.ref_121c9) && !istrue(var0.little_bird_mg_playerexitturret)) {
        var2 = 1;
      }
    }
  }

  if(var1) {
    var0 getclientomnvar();
  } else {
    var0 weaponswitchbuttonPressed();
  }

  if(var2) {
    var0 skydive_cutautodeployon();
    return;
  }

  var0 skydive_cutautodeployoff();
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

function ref_131a3(var0, var1) {
  if(var1) {
    var0.c130 = 1;
    return;
  }

  var0.c130 = undefined;
}

function updatehistoryhud(var0) {
  return istrue(var0.c130);
}