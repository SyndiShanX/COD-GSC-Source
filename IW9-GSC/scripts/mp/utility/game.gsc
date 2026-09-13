/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\game.gsc
***********************************************/

getotherteam(team) {
  return scripts\mp\utility\teams::getenemyteams(team);
}

gettimepassed() {
  if(!isDefined(level.starttime) || !isDefined(level.discardtime))
    return 0;

  if(level.timerstopped)
    return level.timerpausetime - level.starttime - level.discardtime - level.overtimetotal;
  else
    return gettime() - level.starttime - level.discardtime - level.overtimetotal;
}

_id_1236E61C6E2C58F1() {
  if(!isDefined(level.starttime))
    return 0;

  return gettime() - level.starttime;
}

_id_4C8FF40F12C474E9() {
  if(!isDefined(game["gameLength"]))
    return 0;

  return _id_1236E61C6E2C58F1() + game["gameLength"];
}

gettimepassedpercentage() {
  timelimit = gettimelimit();

  if(timelimit == 0)
    return 0;

  return gettimepassed() / (gettimelimit() * 1000) * 100;
}

getsecondspassed() {
  return gettimepassed() / 1000;
}

getminutespassed() {
  return getsecondspassed() / 60;
}

setuipostgamefade(fadetoblack, delay) {
  self endon("disconnect");

  if(istrue(level.nukeinfo._id_AD590A75663898F3)) {
    return;
  }
  if(isDefined(self._id_A1192FA9F37CE26D) && self._id_A1192FA9F37CE26D == fadetoblack) {
    return;
  }
  if(!fadetoblack && !istrue(self._id_A1192FA9F37CE26D)) {
    return;
  }
  if(isDefined(delay))
    wait(delay);

  self._id_A1192FA9F37CE26D = fadetoblack;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, fadetoblack, 0.5);
}

registerroundswitchdvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B, _id_3C141DF65714D228, _id_47EF1080427D4D3A) {
  scripts\mp\utility\dvars::registerwatchdvarint("roundswitch", _id_FC8AFB765C52482B);
  _id_CEFFD5A372961F55 = _func_2EF675C13CA1C4AF("scr_", _id_CEFFD5A372961F55, "_roundswitch");
  level.roundswitchdvar = _id_CEFFD5A372961F55;
  level.roundswitchmin = _id_3C141DF65714D228;
  level.roundswitchmax = _id_47EF1080427D4D3A;
  level.roundswitch = getdvarint(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B);

  if(level.roundswitch < _id_3C141DF65714D228)
    level.roundswitch = _id_3C141DF65714D228;
  else if(level.roundswitch > _id_47EF1080427D4D3A)
    level.roundswitch = _id_47EF1080427D4D3A;
}

registerroundlimitdvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("roundlimit", _id_FC8AFB765C52482B);
}

registernumteamsdvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("numTeams", _id_FC8AFB765C52482B);
}

registerwinlimitdvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("winlimit", _id_FC8AFB765C52482B);
}

registerwinbytwoenableddvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("winbytwoenabled", _id_FC8AFB765C52482B);
}

registerwinbytwomaxroundsdvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("winbytwomaxrounds", _id_FC8AFB765C52482B);
}

registerdogtagsenableddvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("dogtags", _id_FC8AFB765C52482B);
}

registerscorelimitdvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("scorelimit", _id_FC8AFB765C52482B);
}

registertimelimitdvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("timelimit", _id_FC8AFB765C52482B);
  setDvar("ui_timelimit", gettimelimit());
}

registerhalftimedvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("halftime", _id_FC8AFB765C52482B);
  setDvar("ui_halftime", gethalftime());
}

registernumlivesdvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("numlives", _id_FC8AFB765C52482B);
}

registernumrevivesdvar(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("numrevives", _id_FC8AFB765C52482B);
}

_id_704789086C9AD943(_id_CEFFD5A372961F55, _id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("pointsPerKill", _id_FC8AFB765C52482B);
}

setovertimelimitdvar(value) {
  setDvar("overtimeTimeLimit", value);
}

registerlaststandhealthdvar(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("lastStandHealth", _id_FC8AFB765C52482B);
}

registerlaststandrevivehealthdvar(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("lastStandReviveHealth", _id_FC8AFB765C52482B);
}

registerlaststandtimerdvar(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandTimer", _id_FC8AFB765C52482B);
}

registerlaststandrevivetimerdvar(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandReviveTimer", _id_FC8AFB765C52482B);
}

registerlaststandweapondvar(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvar("lastStandWeapon", _id_FC8AFB765C52482B);
}

registerlaststandweapondelaydvar(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandWeaponDelay", _id_FC8AFB765C52482B);
}

registerlaststandsuicidetimerdvar(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandSuicideTimer", _id_FC8AFB765C52482B);
}

registerlaststandinvulntimerdvar(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandInvulnTimer", _id_FC8AFB765C52482B);
}

registerlaststandrevivedecayscaledvar(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("lastStandReviveDecayScale", _id_FC8AFB765C52482B);
}

_id_65C4CAE95D0C833B(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarint("teamReviveHealth", _id_FC8AFB765C52482B);
}

_id_C2BD90FF953A0CE4(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("teamReviveTime", _id_FC8AFB765C52482B);
}

_id_2597B9CD72447CB6(_id_FC8AFB765C52482B) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("teamReviveTimeout", _id_FC8AFB765C52482B);
}

isroundbased() {
  if(!level.teambased)
    return 0;

  if(level.winlimit != 1 && level.roundlimit != 1)
    return 1;

  if(getgametype() == "sr" || getgametype() == "sd" || getgametype() == "siege" || getgametype() == "cyber" || getgametype() == "mtmc" || getgametype() == "control")
    return 1;

  return 0;
}

isfirstround() {
  if(!level.teambased)
    return 1;

  if(game["roundsPlayed"] == 0)
    return 1;

  return 0;
}

nextroundisfinalround() {
  if(level.forcedend)
    return 1;

  if(!level.teambased)
    return 1;

  if(level.roundlimit > 1 && game["roundsPlayed"] >= level.roundlimit - 1 && !istimetobeatrulegametype() && !isscoretobeatrulegametype())
    return 1;

  if(isovertimesupportedgametype() && (hitroundlimit() || hitwinlimit())) {
    if(shouldplaywinbytwo() && islastwinbytwo())
      return 1;
    else if(istimetobeatrulegametype() || isscoretobeatrulegametype()) {
      if(game["overtimeRoundsPlayed"] == 1)
        return 1;
    } else if(!level.playovertime)
      return 1;
  }

  _id_01AA7D78F771C4FE = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_C077C467A67F3354 = getroundswon(_id_F90358454413407F);

    if(_id_C077C467A67F3354 == level.winlimit - 1) {
      _id_01AA7D78F771C4FE = 1;
      break;
    }
  }

  _id_2E8DFEAA03398EE5 = level.winlimit > 0 && _id_01AA7D78F771C4FE;

  if(_id_2E8DFEAA03398EE5 && allteamstied()) {
    if(isovertimesupportedgametype())
      return 0;
    else
      return 1;
  }

  return 0;
}

nextroundismatchpoint() {
  if(level.forcedend)
    return 1;

  if(!level.teambased)
    return 1;

  if(level.roundlimit > 1 && game["roundsPlayed"] >= level.roundlimit - 1 && !istimetobeatrulegametype() && !isscoretobeatrulegametype())
    return 1;

  if(isovertimesupportedgametype() && (hitroundlimit() || hitwinlimit())) {
    if(shouldplaywinbytwo() && islastwinbytwo())
      return 1;
    else if(istimetobeatrulegametype() || isscoretobeatrulegametype()) {
      if(game["overtimeRoundsPlayed"] == 1)
        return 1;
    } else if(!level.playovertime)
      return 1;
  }

  _id_01AA7D78F771C4FE = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_C077C467A67F3354 = getroundswon(_id_F90358454413407F);

    if(_id_C077C467A67F3354 == level.winlimit - 1) {
      if(shouldplaywinbytwo() && istrue(game["displayedMatchPoint"]))
        game["displayedMatchPoint"] = 0;

      return 1;
    }
  }

  return 0;
}

wasonlyround() {
  if(level.playovertime)
    return 0;

  if(!level.teambased)
    return 1;

  if(isDefined(level.onlyroundoverride))
    return 0;

  if(level.winlimit == 1 && hitwinlimit())
    return 1;

  if(level.roundlimit == 1)
    return 1;

  return 0;
}

waslastround() {
  if(level.forcedend)
    return 1;

  if(isDefined(level.nukeinfo) && istrue(level.nukeinfo._id_F30E30BC8F212949))
    return 1;

  if(istrue(level.ctfnukeended))
    return 1;

  if(wasonlyround())
    return 1;

  if(!level.teambased)
    return 1;

  if(hitroundlimit() || hitwinlimit())
    return !level.playovertime;

  if(getgametype() == "ballmode") {
    if(game["status"] == "overtime")
      return 1;

    timeremaining = scripts\mp\gamelogic::gettimeremaining();

    if(timeremaining <= 0.0)
      return 1;
  }

  return 0;
}

iswinbytworulegametype() {
  switch (getgametype()) {
    case "siege":
    case "sr":
    case "sd":
    case "arena":
      return getdvarint(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_winByTwoEnabled"), 0) == 1;
  }

  return 0;
}

getmaxwinbytworounds() {
  return getdvarint(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_winByTwoMaxRounds"), level.winlimit);
}

shouldplaywinbytwo() {
  _id_43A41488C3C487DF = game["roundsWon"]["allies"];
  _id_18A3FAB290E780C2 = game["roundsWon"]["axis"];
  return iswinbytworulegametype() && abs(_id_43A41488C3C487DF - _id_18A3FAB290E780C2) < 2 && game["overtimeRoundsPlayed"] < getmaxwinbytworounds();
}

islastwinbytwo() {
  return shouldplaywinbytwo() && game["overtimeRoundsPlayed"] == getmaxwinbytworounds() - 1;
}

_id_2F1B2A4A64257BEA() {
  _id_43A41488C3C487DF = game["roundsWon"]["allies"];
  _id_18A3FAB290E780C2 = game["roundsWon"]["axis"];
  return abs(_id_43A41488C3C487DF - _id_18A3FAB290E780C2) < 2;
}

istimetobeatrulegametype() {
  switch (getgametype()) {
    case "payload":
    case "ball":
    case "ctf":
      return 1;
  }

  return 0;
}

intimetobeat() {
  return isDefined(game["status"]) && game["status"] == "recordTTB";
}

settimetobeat(team) {
  if(!istimetobeatrulegametype())
    return 0;

  _id_282EC5B083CD0BEE = getsecondspassed();
  score = scripts\mp\gamescore::_getteamscore(team);

  if(!istimetobeatvalid() || _id_282EC5B083CD0BEE < game["timeToBeat"] && score >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != team)
      game["timeToBeatOld"] = game["timeToBeat"];

    game["timeToBeat"] = _id_282EC5B083CD0BEE;
    game["timeToBeatTeam"] = team;
    game["timeToBeatScore"] = score;
    return 1;
  }

  return 0;
}

istimetobeatvalid() {
  return game["timeToBeat"] != 0;
}

shouldplaytimetobeatot() {
  return istimetobeatvalid() && game["overtimeRoundsPlayed"] == 1;
}

isscoretobeatrulegametype() {
  switch (getgametype()) {
    case "rush":
      return 1;
  }

  return 0;
}

setscoretobeat(team, score) {
  if(!isscoretobeatrulegametype())
    return 0;

  _id_74876CEB45F023C3 = game["timeToBeatTeam"] != "none" && score == game["timeToBeatScore"];

  if(score >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != team)
      game["timeToBeatScoreOld"] = game["timeToBeatScore"];

    game["timeToBeatTeam"] = team;
    game["timeToBeatScore"] = score;
  }

  foreach(player in level.players) {
    player setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(player.team == game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
    player setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(player.team != game["timeToBeatTeam"], game["timeToBeatScore"], game["timeToBeatScoreOld"]));
  }

  if(_id_74876CEB45F023C3)
    return "tie";
  else
    return game["timeToBeatTeam"];
}

shouldplayscoretobeatot() {
  return isscoretobeatrulegametype() && game["overtimeRoundsPlayed"] == 1;
}

isovertimesupportedgametype() {
  switch (getgametype()) {
    case "payload":
    case "blitz":
    case "rush":
    case "cmd":
    case "bigctf":
    case "ball":
    case "ctf":
    case "ballmode":
      return 1;
    case "dd":
    case "siege":
    case "sr":
    case "sd":
    case "arena":
      return iswinbytworulegametype();
  }

  return 0;
}

getmaxovertimeroundsbygametype() {
  _id_8127E47E743E3A3F = 0;

  switch (getgametype()) {
    case "payload":
    case "blitz":
    case "ball":
    case "ctf":
    case "siege":
    case "sr":
    case "sd":
      _id_8127E47E743E3A3F = 2;
      break;
    case "cmd":
    case "bigctf":
    case "dd":
    case "ballmode":
      _id_8127E47E743E3A3F = 1;
      break;
  }

  if(isanymlgmatch() && !istimetobeatrulegametype())
    return -1;

  return _id_8127E47E743E3A3F;
}

getwingamebytype() {
  if(!isDefined(level.wingamebytype)) {
    if(!isroundbased() || !isobjectivebased() || ismoddedroundgame())
      level.wingamebytype = "teamScores";
    else
      level.wingamebytype = "roundsWon";
  }

  return level.wingamebytype;
}

issimultaneouskillenabled() {
  if(!isDefined(level.simultaneouskillenabled))
    level.simultaneouskillenabled = getdvarint("dvar_0AA96B1E9C9809B8", 0) == 0;

  return level.simultaneouskillenabled;
}

cantiebysimultaneouskill() {
  if(!issimultaneouskillenabled())
    return 0;

  _id_B6311BC566CFDD35 = 0;

  switch (getgametype()) {
    case "dm":
    case "war":
    case "brtdm_mgl":
    case "brtdm":
    case "gun":
    case "conflict":
    case "front":
    case "arm":
      _id_B6311BC566CFDD35 = 1;
  }

  return _id_B6311BC566CFDD35;
}

shouldplayovertime() {
  _id_453896F6C55AB413 = allteamstied();

  if(!hitroundlimit() && !hitwinlimit())
    return 0;

  if(!isovertimesupportedgametype())
    return 0;

  if(_id_453896F6C55AB413 && inovertime()) {
    _id_178E9C557E11FB83 = getmaxovertimeroundsbygametype();
    _id_453896F6C55AB413 = scripts\engine\utility::ter_op(_id_178E9C557E11FB83 == -1, 1, game["overtimeRoundsPlayed"] < _id_178E9C557E11FB83);
  }

  _id_B564BF7A9922B991 = shouldplaywinbytwo();
  _id_4B3EEA7964B200D2 = shouldplaytimetobeatot();
  _id_974EA582DB790CED = shouldplayscoretobeatot();
  return !level.forcedend && (_id_453896F6C55AB413 || _id_B564BF7A9922B991 || _id_4B3EEA7964B200D2 || _id_974EA582DB790CED);
}

resetscoreonroundstart() {
  if(istrue(level.resetscoreonroundstart))
    return 1;

  return (getgametype() == "ctf" || getgametype() == "blitz") && !inovertime() && getwingamebytype() == "roundsWon";
}

canplayhalfwayvo() {
  if(!isDefined(level.didhalfscorevoboost))
    level.didhalfscorevoboost = 0;

  if(level.didhalfscorevoboost)
    return 0;

  switch (getgametype()) {
    case "grnd":
    case "grind":
    case "dm":
    case "war":
    case "brtdm_mgl":
    case "brtdm":
    case "koth":
    case "hq":
    case "pill":
    case "bigctf":
    case "conf":
    case "tdef":
    case "conflict":
    case "dd":
    case "ball":
    case "dom":
    case "infect":
    case "front":
    case "arm":
      return 1;
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

hittimelimit() {
  if(scripts\mp\utility\dvars::getwatcheddvar("timelimit") <= 0)
    return 0;

  _id_8DD9F2EB8215A139 = scripts\mp\gamelogic::gettimeremaining();

  if(_id_8DD9F2EB8215A139 > 0)
    return 0;

  return 1;
}

hitroundlimit() {
  if(level.roundlimit <= 0)
    return 0;

  return game["roundsPlayed"] >= level.roundlimit;
}

hitscorelimit() {
  if(isobjectivebased())
    return 0;

  if(level.roundscorelimit <= 0)
    return 0;

  if(level.teambased) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(game["teamScores"][_id_F90358454413407F] >= level.roundscorelimit)
        return 1;
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];

      if(isDefined(player.score) && player.score >= level.roundscorelimit)
        return 1;
    }
  }

  return 0;
}

hitwinlimit() {
  if(level.winlimit <= 0)
    return 0;

  if(!level.teambased)
    return 1;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(getroundswon(_id_F90358454413407F) >= level.winlimit)
      return 1;
  }

  return 0;
}

getscorelimit() {
  if(isroundbased()) {
    if(level.roundlimit)
      return level.roundlimit;
    else
      return level.winlimit;
  } else
    return level.roundscorelimit;
}

getroundswon(team) {
  return game["roundsWon"][team];
}

allteamstied() {
  wingamebytype = getwingamebytype();
  _id_511CD90B67273662 = undefined;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(!isDefined(_id_511CD90B67273662)) {
      _id_511CD90B67273662 = game[wingamebytype][_id_F90358454413407F];
      continue;
    }

    if(_id_511CD90B67273662 != game[wingamebytype][_id_F90358454413407F])
      return 0;
  }

  return 1;
}

isobjectivebased() {
  return level.objectivebased;
}

gettimelimit() {
  if(inovertime() && (!isDefined(game["inNukeOvertime"]) || !game["inNukeOvertime"])) {
    if(istrue(game["timeToBeat"]))
      return game["timeToBeat"];
    else {
      _id_B14CC397DDC59419 = getdvarfloat("overtimeTimeLimit");

      if(_id_B14CC397DDC59419 > 0)
        return _id_B14CC397DDC59419;
      else
        return scripts\mp\utility\dvars::getwatcheddvar("timelimit");
    }
  } else if(isDefined(level.extratime) && level.extratime > 0)
    return scripts\mp\utility\dvars::getwatcheddvar("timelimit") + level.extratime;
  else
    return scripts\mp\utility\dvars::getwatcheddvar("timelimit");
}

gethalftime() {
  if(inovertime())
    return 0;
  else if(isDefined(game["inNukeOvertime"]) && game["inNukeOvertime"])
    return 0;
  else
    return scripts\mp\utility\dvars::getwatcheddvar("halftime");
}

inovertime() {
  return isDefined(game["status"]) && game["status"] == "overtime";
}

gamehasstarted() {
  if(isDefined(level.gamehasstarted))
    return level.gamehasstarted;

  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(team, "hasSpawned"))
        return 1;
    }

    return 0;
  }

  return level.maxplayercount > 1;
}

getlivingplayers(team) {
  _id_F104A131C0A929A2 = [];

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    if(level.teambased && isDefined(team)) {
      if(team == player.pers["team"])
        _id_F104A131C0A929A2[_id_F104A131C0A929A2.size] = player;

      continue;
    }

    _id_F104A131C0A929A2[_id_F104A131C0A929A2.size] = player;
  }

  return _id_F104A131C0A929A2;
}

rankingenabled() {
  if(!isPlayer(self))
    return 0;

  return level.rankedmatch && !self.usingonlinedataoffline;
}

onlinestatsenabled() {
  if(!isPlayer(self))
    return 0;

  return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

privatematch() {
  return level.onlinegame && getdvarint("xblive_privatematch");
}

lobbyteamselectenabled() {
  return level.systemlink || privatematch() && getdvarint("lobby_team_select", 0) || _func_1EB7D2791D3C536F();
}

matchmakinggame() {
  return level.matchmakingmatch;
}

getgametypenumlives() {
  return scripts\mp\utility\dvars::getwatcheddvar("numlives");
}

islifelimited() {
  if(!isDefined(level.numlifelimited))
    level.numlifelimited = getgametypenumlives();

  return level.numlifelimited;
}

getlastlivingplayer(team) {
  _id_AB9AADEF5F024E12 = undefined;

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
    _id_AB9AADEF5F024E12 = player;
  }

  return _id_AB9AADEF5F024E12;
}

trygetlastpotentiallivingplayer() {
  _id_AB9AADEF5F024E12 = undefined;

  foreach(player in level.players) {
    if(!player scripts\cp_mp\utility\player_utility::_isalive() && !player scripts\mp\playerlogic::mayspawn()) {
      continue;
    }
    if(level.codcasterenabled) {
      if(player _meth_8420670EAFC8D391())
        continue;
    }

    if(isDefined(_id_AB9AADEF5F024E12))
      return undefined;
    else
      _id_AB9AADEF5F024E12 = player;
  }

  if(isDefined(_id_AB9AADEF5F024E12))
    return _id_AB9AADEF5F024E12;
  else
    return undefined;
}

getpotentiallivingplayers() {
  _id_677AE66DF2125F53 = [];

  foreach(player in level.players) {
    if(!player scripts\cp_mp\utility\player_utility::_isalive() && !player scripts\mp\playerlogic::mayspawn()) {
      continue;
    }
    if(level.codcasterenabled) {
      if(player _meth_8420670EAFC8D391())
        continue;
    }

    _id_677AE66DF2125F53[_id_677AE66DF2125F53.size] = player;
  }

  return _id_677AE66DF2125F53;
}

denysystemicteamchoice() {
  if(!isbot(self) && !istestclient(self)) {
    if(isintournament())
      return 1;

    if(level.codcasterenabled)
      return 0;
  }

  if(getdvarint("scr_skipclasschoice", 0) > 0)
    return 1;

  return 0;
}

allowteamassignment() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return level.teambased;

  _id_9BBACB179DEA3237 = doesmodesupportplayerteamchoice();
  return _id_9BBACB179DEA3237;
}

doesmodesupportplayerteamchoice() {
  if(getdvarint("dvar_78653010D584AA6E", 0) == 0) {
    if(getgametype() == "gun" || getgametype() == "infect")
      return 0;

    _id_9BBACB179DEA3237 = int(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 4));
    return _id_9BBACB179DEA3237 > 0;
  }

  return level._id_62F6F7640E4431E3._id_71B14066991700EC;
}

allowclasschoice() {
  if(getdvarint("scr_skipclasschoice", 0) > 0)
    return 0;

  if(getdvarint("dvar_F195E306FFA755D0", 0) == 1)
    return 0;

  if(isDefined(level.allowclasschoicefunc)) {
    _id_874F942CCD7D034B = self[[level.allowclasschoicefunc]]();

    if(isDefined(_id_874F942CCD7D034B))
      return _id_874F942CCD7D034B;
  }

  if(scripts\mp\flags::gameflag("infil_will_run") && isDefined(level.bypassclasschoicefunc))
    return 0;

  if(istrue(level.denyclasschoice))
    return 0;

  if(getdvarint("dvar_78653010D584AA6E", 0) == 0) {
    _id_9BBACB179DEA3237 = int(tablelookup("mp/gametypesTable.csv", 0, getgametype(), 5));
    return _id_9BBACB179DEA3237;
  }

  return level._id_62F6F7640E4431E3.allowclasschoice;
}

showfakeloadout() {
  return 0;
}

setfakeloadoutweaponslot(sweapon, _id_7EBC888BE394A18E) {
  weaponname = _id_2669878CF5A1B6BC::getweaponrootname(sweapon);
  attachments = [];

  if(weaponname != "iw8_knife")
    attachments = getweaponattachments(sweapon);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    _id_B519F801A23677BF = -1;

    if(isDefined(attachments[_id_AC0E594AC96AA3A8])) {
      if(!scripts\mp\utility\weapon::isattachmentsniperscopedefault(sweapon, attachments[_id_AC0E594AC96AA3A8]))
        _id_B519F801A23677BF = tablelookuprownum("mp/attachmenttable.csv", 4, attachments[_id_AC0E594AC96AA3A8]);
    }
  }
}

setcommonrulesfrommatchrulesdata(skipfriendlyfire) {
  _id_652F47620AC4713F = getmatchrulesdata("commonOption", "teamCount");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_teamcount"), _id_652F47620AC4713F);
  _id_0774C9CA5D1D6221 = getmatchrulesdata("commonOption", "teamSize");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_teamsize"), _id_0774C9CA5D1D6221);
  timelimit = getmatchrulesdata("commonOption", "timeLimit");

  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 1) {
    if(isDefined(game["gameStateRestore"]) && game["gameStateRestore"].enabled)
      timelimit = game["gameStateRestore"].gametime;
  }

  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_timeLimit"), timelimit);
  registertimelimitdvar(getgametype(), timelimit);
  scorelimit = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_scoreLimit"), scorelimit);
  registerscorelimitdvar(getgametype(), scorelimit);
  winlimit = getmatchrulesdata("commonOption", "winLimit");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_winLimit"), winlimit);
  registerwinlimitdvar(getgametype(), winlimit);
  roundlimit = getmatchrulesdata("commonOption", "roundLimit");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_roundLimit"), roundlimit);
  registerroundlimitdvar(getgametype(), roundlimit);
  roundswitch = getmatchrulesdata("commonOption", "roundSwitch");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_roundSwitch"), roundswitch);
  registerroundswitchdvar(getgametype(), roundswitch, 0, 9);
  _id_789F5229B64DFE83 = getmatchrulesdata("commonOption", "winByTwoEnabled");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_winByTwoEnabled"), _id_789F5229B64DFE83);
  registerwinbytwoenableddvar(getgametype(), _id_789F5229B64DFE83);
  _id_9F6329673D2D1959 = getmatchrulesdata("commonOption", "winByTwoMaxRounds");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_winByTwoMaxRounds"), _id_9F6329673D2D1959);
  registerwinbytwomaxroundsdvar(getgametype(), _id_9F6329673D2D1959);
  dogtags = getmatchrulesdata("commonOption", "dogTags");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_dogTags"), dogtags);
  registerdogtagsenableddvar(getgametype(), dogtags);
  spawnprotectiontimer = getmatchrulesdata("commonOption", "spawnProtectionTimer");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_spawnProtectionTimer"), spawnprotectiontimer);
  _id_76F0BC10A4B13CE2 = getmatchrulesdata("commonOption", "numLives");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_numLives"), _id_76F0BC10A4B13CE2);
  registernumlivesdvar(getgametype(), _id_76F0BC10A4B13CE2);
  numrevives = getmatchrulesdata("commonOption", "numRevives");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_numRevives"), numrevives);
  registernumrevivesdvar(getgametype(), numrevives);
  setdynamicdvar("scr_player_maxhealth", getmatchrulesdata("commonOption", "maxHealth"));
  setdynamicdvar("scr_player_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_healthregentime"), getmatchrulesdata("commonOption", "healthRegen"));
  setdynamicdvar("scr_player_allowarmor", getmatchrulesdata("commonOption", "allowArmor"));
  setdynamicdvar("scr_player_spawnarmor", getmatchrulesdata("commonOption", "spawnArmor"));
  setdynamicdvar("scr_player_spawnarmorplates", getmatchrulesdata("commonOption", "spawnArmorPlates"));
  setdynamicdvar("dvar_08AD1AB9436BCCCA", getmatchrulesdata("commonOption", "dropArmorOnDeath"));
  setdynamicdvar("dvar_28D450F7F28644B7", getmatchrulesdata("commonOption", "armorDropAmount"));
  setdynamicdvar("scr_player_disableSuperSprint", getmatchrulesdata("commonOption", "disableSuperSprint"));
  setdynamicdvar("scr_player_disableMount", getmatchrulesdata("commonOption", "disableMount"));
  setdynamicdvar("scr_player_lastStand", getmatchrulesdata("commonOption", "lastStand"));
  laststandhealth = getmatchrulesdata("commonOption", "lastStandHealth");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_lastStandHealth"), laststandhealth);
  registerlaststandhealthdvar(laststandhealth);
  laststandrevivehealth = getmatchrulesdata("commonOption", "lastStandReviveHealth");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_lastStandReviveHealth"), laststandrevivehealth);
  registerlaststandrevivehealthdvar(laststandrevivehealth);
  laststandtimer = getmatchrulesdata("commonOption", "lastStandTimer");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_lastStandTimer"), laststandtimer);
  registerlaststandtimerdvar(laststandtimer);
  laststandrevivetimer = getmatchrulesdata("commonOption", "lastStandReviveTimer");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_lastStandReviveTimer"), laststandrevivetimer);
  registerlaststandrevivetimerdvar(laststandrevivetimer);
  laststandsuicidetimer = getmatchrulesdata("commonOption", "lastStandSuicideTimer");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_lastStandSuicideTimer"), laststandsuicidetimer);
  registerlaststandsuicidetimerdvar(laststandsuicidetimer);
  setdynamicdvar("dvar_DF1AE5A11F519AB5", getmatchrulesdata("commonOption", "reviveUseWeapon"));
  level.matchrules_damagemultiplier = 0;
  setdynamicdvar("scr_game_vampirism", getmatchrulesdata("commonOption", "vampirism"));
  setdynamicdvar("scr_game_spectatetype", getmatchrulesdata("commonOption", "spectateModeAllowed"));
  setdynamicdvar("scr_game_allowkillcam", getmatchrulesdata("commonOption", "showKillcam"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_killcamType"), getmatchrulesdata("commonOption", "killcamType"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_allow3rdspectate"), getmatchrulesdata("commonOption", "spectate3rdAllowed"));
  setdynamicdvar("scr_game_enableMinimap", getmatchrulesdata("commonOption", "enableMinimap"));
  setdynamicdvar("scr_game_forceuav", getmatchrulesdata("commonOption", "radarAlwaysOn"));
  setdynamicdvar("scr_game_radarHidePings", getmatchrulesdata("commonOption", "radarHideShots"));
  setdynamicdvar("scr_game_navBarHideEnemy", getmatchrulesdata("commonOption", "compassHideEnemy"));
  setdynamicdvar("scr_game_navBarHidePings", getmatchrulesdata("commonOption", "compassHidePings"));
  setdynamicdvar("scr_game_disablespawncamera", getmatchrulesdata("commonOption", "disableSpawnCamera"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_playerrespawndelay"), getmatchrulesdata("commonOption", "respawnDelay"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_suicidespawndelay"), getmatchrulesdata("commonOption", "suicideSpawnDelay"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_waverespawndelay"), getmatchrulesdata("commonOption", "waveRespawnDelay"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_waverespawndelay_alt"), getmatchrulesdata("commonOption", "waveRespawnDelayAlt"));
  setdynamicdvar("scr_player_forcerespawn", getmatchrulesdata("commonOption", "forceRespawn"));
  level.matchrules_allowcustomclasses = getmatchrulesdata("commonOption", "allowCustomClasses");
  level.supportintel = getmatchrulesdata("commonOption", "allowIntel");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_allowKillstreaks"), getmatchrulesdata("commonOption", "allowKillstreaks"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_allowPerks"), getmatchrulesdata("commonOption", "allowPerks"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_allowSupers"), getmatchrulesdata("commonOption", "allowSupers"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_ffPunishLimit"), getmatchrulesdata("commonOption", "ffPunishLimit"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_ffPunishDamageLimit"), getmatchrulesdata("commonOption", "ffPunishDamageLimit"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_ffKickKillLimit"), getmatchrulesdata("commonOption", "ffKickKillLimit"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_ffKickDamageLimit"), getmatchrulesdata("commonOption", "ffKickDamageLimit"));
  setdynamicdvar("scr_thirdperson", getmatchrulesdata("commonOption", "thirdPerson"));

  if(getdvarint("dvar_FF21D0D18916F3A1", 0) == 1)
    setdynamicdvar("camera_thirdPerson", getmatchrulesdata("commonOption", "thirdPerson"));

  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_roundRetainStreaks"), getmatchrulesdata("commonOption", "roundRetainStreaks"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_roundRetainStreakProg"), getmatchrulesdata("commonOption", "roundRetainStreakProg"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_deathRetainStreaks"), getmatchrulesdata("commonOption", "deathRetainStreaks"));
  setdynamicdvar("scr_game_casualScoreStreaks", getmatchrulesdata("commonOption", "casualScoreStreaks"));
  setdynamicdvar("scr_game_wrapkillstreaks", getmatchrulesdata("commonOption", "wrapKillstreaks"));
  setdynamicdvar("scr_game_superFastChargeRate", getmatchrulesdata("commonOption", "superFastChargeRate"));
  setdynamicdvar("scr_game_superPointsMod", getmatchrulesdata("commonOption", "superPointsMod"));
  setdynamicdvar("scr_game_spawnprotectiontimer", getmatchrulesdata("commonOption", "spawnProtectionTimer"));
  setdynamicdvar("scr_game_lethalDelay", getmatchrulesdata("commonOption", "equipmentDelay"));
  setdynamicdvar("scr_game_equipmentMSProtect", getmatchrulesdata("commonOption", "equipmentMSProtect"));
  setdynamicdvar("scr_game_disableBattleChatter", getmatchrulesdata("commonOption", "disableBattleChatter"));
  setdynamicdvar("scr_game_disableAnnouncer", getmatchrulesdata("commonOption", "disableAnnouncer"));
  setdynamicdvar("scr_game_inGameLoot", getmatchrulesdata("commonOption", "inGameLoot"));
  setdynamicdvar("scr_game_infilSkip", getmatchrulesdata("commonOption", "infilSkip"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_practiceRound"), getmatchrulesdata("commonOption", "practiceRound"));
  setdynamicdvar("dvar_D2DE59939486BD5A", getmatchrulesdata("commonOption", "postGameExfil"));
  setdynamicdvar("dvar_96DD663F32DBA868", getmatchrulesdata("commonOption", "exfilExtractTimer"));
  setdynamicdvar("dvar_645019BC959FFAF9", getmatchrulesdata("commonOption", "exfilActiveTimer"));
  level.crankedbombtimer = getmatchrulesdata("commonOption", "crankedBombTimer");
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_crankedBombTimer"), level.crankedbombtimer);
  scripts\mp\cranked::registercrankedtimerdvar(getgametype(), level.crankedbombtimer);
  setdynamicdvar("dvar_72FE29AA713EA21E", getmatchrulesdata("commonOption", "classTableOverride"));
  setdynamicdvar("scr_game_magcount", getmatchrulesdata("commonOption", "magCount"));
  setdynamicdvar("dvar_127490A7577F169F", getmatchrulesdata("commonOption", "tier1ModeEnabled"));
  setdynamicdvar("dvar_A2C2C2007177185E", getmatchrulesdata("commonOption", "hardcoreModeEnabled"));
  setdynamicdvar("scr_game_onlyheadshots", getmatchrulesdata("commonOption", "headshotsOnly"));

  if(!isDefined(skipfriendlyfire))
    setdynamicdvar("scr_team_fftype", getmatchrulesdata("commonOption", "friendlyFire"));

  setDvar("bg_compassShowEnemies", getdvarint("scr_game_forceuav") == 1);
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_pointsPerKill"), getmatchrulesdata("commonOption", "pointsPerKill"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_pointsPerDeath"), getmatchrulesdata("commonOption", "pointsPerDeath"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_pointsHeadshotBonus"), getmatchrulesdata("commonOption", "pointsHeadshotBonus"));
  setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", getgametype(), "_pointsPerKSKill"), getmatchrulesdata("commonOption", "pointsPerKSKill"));
  setdynamicdvar("scr_devremovedomflag", "");
  setdynamicdvar("scr_devplacedomflag", "");

  if(privatematch() || level.systemlink || isanymlgmatch()) {
    level.codcasterenabled = getmatchrulesdata("commonOption", "codcasterEnabled");
    setDvar("com_codcasterenabled", level.codcasterenabled);
    setdynamicdvar("scr_game_matchstarttime", getmatchrulesdata("commonOption", "matchStartTime"));
    setdynamicdvar("scr_game_roundstarttime", getmatchrulesdata("commonOption", "roundStartTime"));
  }

  setDvar("scr_game_killstreakdelay", getmatchrulesdata("commonOption", "killstreakDelay"));

  if(getdvarint("dvar_F06AE50014E12FE5") == 1)
    setDvar("dvar_8610CCD25560C117", getmatchrulesdata("commonOption", "dynamicMapElementsDisabled"));
}

reinitializematchrulesonmigration() {
  for(;;) {
    level waittill("host_migration_begin");
    [[level.initializematchrules]]();

    if(isDefined(level._id_8B131E98E1629AFE))
      [[level._id_8B131E98E1629AFE]]();
  }
}

reinitializethermal(ent) {
  self endon("disconnect");

  if(isDefined(ent))
    ent endon("death");

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self.lastvisionsetthermal))
      self visionsetthermalforplayer(self.lastvisionsetthermal, 0);
  }
}

getmatchrulesspecialclass(team, index) {
  class = [];
  class ["loadoutPrimaryAttachment2"] = "none";
  class ["loadoutSecondaryAttachment2"] = "none";
  _id_D414E906AA1E0AFB = [];
  class ["loadoutPrimary"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "weapon");
  class ["loadoutPrimaryAttachment"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "attachmentSetup", 0, "attachment");
  class ["loadoutPrimaryAttachment2"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "attachmentSetup", 1, "attachment");
  class ["loadoutPrimaryCamo"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "camo");
  class ["loadoutPrimaryReticle"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 0, "reticle");
  class ["loadoutSecondary"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "weapon");
  class ["loadoutSecondaryAttachment"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "attachmentSetup", 0, "attachment");
  class ["loadoutSecondaryAttachment2"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "attachmentSetup", 1, "attachment");
  class ["loadoutSecondaryCamo"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "camo");
  class ["loadoutSecondaryReticle"] = getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "weaponSetups", 1, "reticle");
  class ["loadoutPerks"] = _id_D414E906AA1E0AFB;
  class ["loadoutKillstreak1"] = scripts\mp\class::recipe_getkillstreak(team, index, 0);
  class ["loadoutKillstreak2"] = scripts\mp\class::recipe_getkillstreak(team, index, 1);
  class ["loadoutKillstreak3"] = scripts\mp\class::recipe_getkillstreak(team, index, 2);
  return class;
}

isplayeroutsideofanybombsite(objweapon) {
  if(isDefined(level.objectives)) {
    foreach(_id_EEF26A325310D3AF in level.objectives) {
      if(self istouching(_id_EEF26A325310D3AF.noweapondropallowedtrigger))
        return 0;
    }
  }

  return 1;
}

gamehasneutralcrateowner(gametype) {
  switch (gametype) {
    case "sotf_ffa":
    case "sotf":
      return 1;
    default:
      return 0;
  }
}

isanymlgmatch() {
  if(isusingmatchrulesdata()) {
    if(getdvarint("killswitch_cdl_restriction_ingame") == 0 && getmatchrulesdata("cwlRulesEnabled") == 1)
      return 1;
  }

  return getdvarint("xblive_competitionmatch");
}

ismlgsystemlink() {
  if(level.systemlink && getdvarint("xblive_competitionmatch"))
    return 1;

  return 0;
}

ismlgprivatematch() {
  if(privatematch() && getdvarint("xblive_competitionmatch"))
    return 1;

  return 0;
}

ismlgmatch() {
  if(ismlgsystemlink() || ismlgprivatematch())
    return 1;

  return 0;
}

ismoddedroundgame() {
  if(getgametype() == "dom" || getgametype() == "ctf" || getgametype() == "rush" || getgametype() == "blitz" || getgametype() == "rescue" || getgametype() == "ballmode")
    return 1;

  return 0;
}

isusingdefaultclass(team, index) {
  _id_7AF641E395C0788C = 0;

  if(isDefined(index)) {
    if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "inUse"))
      _id_7AF641E395C0788C = 1;
  } else {
    for(index = 0; index < 6; index++) {
      if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", team, index, "class", "inUse")) {
        _id_7AF641E395C0788C = 1;
        break;
      }
    }
  }

  return _id_7AF641E395C0788C;
}

getmatchrulesdatawithteamandindex(category, team, index, _id_BC35CB5830C7F81B, _id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_434849FD34BB4BA0) {
  if(team == "axis")
    index = index + 6;

  if(isDefined(_id_434849FD34BB4BA0))
    return getmatchrulesdata(category, index, _id_BC35CB5830C7F81B, _id_43484BFD34BB5006, _id_43484AFD34BB4DD3, _id_434849FD34BB4BA0);
  else if(isDefined(_id_43484AFD34BB4DD3))
    return getmatchrulesdata(category, index, _id_BC35CB5830C7F81B, _id_43484BFD34BB5006, _id_43484AFD34BB4DD3);
  else
    return getmatchrulesdata(category, index, _id_BC35CB5830C7F81B, _id_43484BFD34BB5006);
}

isspawnprotected() {
  return gettime() < self.spawntime + level.killstreakspawnshielddelayms;
}

ismatchstartprotected() {
  return isDefined(level.starttime) && gettime() < level.starttime + level.equipmentmatchstartshieldms;
}

getgametype() {
  if(!isDefined(level.gametype))
    level.gametype = tolower(getDvar("g_gametype"));

  return level.gametype;
}

_id_F6BAD1D33AD22078() {
  if(level._id_EC2FB549B15AD827)
    return "mp_ranked";

  return "mp";
}

getsubgametype() {
  gametype = getgametype();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_FAF0D2FAC3F47583 = getDvar("dvar_7611A2790A0BF7FE", "");

    if(_id_FAF0D2FAC3F47583 != "")
      return _id_FAF0D2FAC3F47583;
  }

  return gametype;
}

issubgametype() {
  gametype = getgametype();
  _id_FAF0D2FAC3F47583 = getsubgametype();
  return gametype != _id_FAF0D2FAC3F47583;
}

isteamplacementsbmmmode() {
  switch (getsubgametype()) {
    case "aladdin":
    case "jugg":
    case "br":
      return 1;
  }

  return 0;
}

lpcfeaturegated() {
  if(runleanthreadmode())
    return 1;

  switch (getgametype()) {
    case "brtdm_mgl":
    case "brtdm":
    case "gwtdm":
    case "gwai":
    case "gwbomb":
    case "conflict":
    case "risk":
    case "arm":
      return 1;
  }

  return 0;
}

runleanthreadmode() {
  if(getdvarint("dvar_063B929C96913E1D") == 1)
    return 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || level.leanthread == 1)
    return 1;

  return 0;
}

gamehasinfil() {
  if(!isDefined(game["infil"]))
    return 0;

  _id_97F23A7B99A8CCC7 = 1;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(!isDefined(game["infil"][_id_F90358454413407F]) || !isDefined(game["infil"][_id_F90358454413407F][1])) {
      _id_97F23A7B99A8CCC7 = 0;
      break;
    }
  }

  return _id_97F23A7B99A8CCC7;
}

teamhasinfil(team) {
  return gamehasinfil() && scripts\mp\utility\teams::isgameplayteam(team) && isDefined(game["infil"][team][1]);
}

iskillstreakdenied() {
  return scripts\cp_mp\emp_debuff::is_empd() || isairdenied();
}

isairdenied() {
  if(self.team == "spectator")
    return 0;

  return 0;
}

getmaxoutofboundstime() {
  outofboundstime = level.outofboundstime;

  if(!isDefined(outofboundstime)) {
    outofboundstime = max(0, scripts\engine\utility::ter_op(matchmakinggame(), getdvarfloat("scr_outofboundstime", 3), 3));
    level.outofboundstime = outofboundstime;
  }

  return outofboundstime;
}

_id_A01D18A56C6CC1AA() {
  return getdvarfloat("dvar_DD59793CDEDDB43F", 15.0);
}

getmaxoutofboundscooldown() {
  outofboundscooldown = level.outofboundscooldown;

  if(!isDefined(outofboundscooldown)) {
    outofboundscooldown = max(0, getdvarfloat("scr_outofboundscooldown", 3));
    level.outofboundscooldown = outofboundscooldown;
  }

  return outofboundscooldown;
}

getmaxoutofboundsminefieldtime() {
  outofboundstimeminefield = level.outofboundstimeminefield;

  if(!isDefined(outofboundstimeminefield)) {
    outofboundstimeminefield = max(0, getdvarfloat("scr_outofboundstimeminefield", 3));
    level.outofboundstimeminefield = outofboundstimeminefield;
  }

  return outofboundstimeminefield;
}

getmaxoutofboundsrestrictedtime() {
  level.outofboundstimerestricted = 10;
  return level.outofboundstimerestricted;
}

getmaxoutofboundsbrtime() {
  _id_61D3A4299744033E = getdvarfloat("scr_outofboundstime", 5);

  if(_id_61D3A4299744033E > 0)
    level.outofboundstimebr = _id_61D3A4299744033E;
  else
    level.outofboundstimebr = 5;

  return level.outofboundstimebr;
}

updateobjectivetext() {
  if(self.pers["team"] == "spectator")
    self setclientdvar("cg_objectiveText", "");
  else {
    if(level.roundscorelimit > 0 && !isobjectivebased()) {
      if(isDefined(getobjectivescoretext(self.pers["team"]))) {
        if(level.splitscreen) {
          self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]));
          return;
        }

        self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]), level.roundscorelimit);
        return;
        return;
      }

      return;
    }

    if(isDefined(getobjectivetext(self.pers["team"])))
      self setclientdvar("cg_objectiveText", getobjectivetext(self.pers["team"]));
  }
}

setobjectivetext(team, text) {
  game["strings"]["objective_" + team] = text;
}

setobjectivescoretext(team, text) {
  game["strings"]["objective_score_" + team] = text;
}

setobjectivehinttext(team, text) {
  game["strings"]["objective_hint_" + team] = text;
}

getobjectivetext(team) {
  return game["strings"]["objective_" + team];
}

getobjectivescoretext(team) {
  return game["strings"]["objective_score_" + team];
}

getobjectivehinttext(team) {
  return game["strings"]["objective_hint_" + team];
}

testgamemodestringlist(_id_5598168FD5B0E734, _id_B2FF82EC901486E4) {
  if(!isDefined(_id_5598168FD5B0E734) || _id_5598168FD5B0E734 == "" || !isDefined(_id_B2FF82EC901486E4) || _id_B2FF82EC901486E4 == "")
    return 0;

  return issubstr(_id_5598168FD5B0E734, _id_B2FF82EC901486E4);
}

islaststandenabled() {
  return isDefined(level.laststand) && (level.laststand == 1 || level.laststand == 3) || istrue(level._id_78184EC36F669844);
}

isteamreviveenabled() {
  return isDefined(level.laststand) && (level.laststand == 2 || level.laststand == 3);
}

isdefending(victim) {
  _id_46460432F5099265 = 0;

  switch (getgametype()) {
    case "cyber":
      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        _id_ABB6FBDD8CD1A1D2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        _id_44096CEE99B7A48B = distancesquared(level.cyberemp.carrier.origin, victim.origin);

        if(_id_ABB6FBDD8CD1A1D2 < 90000 || _id_44096CEE99B7A48B < 90000) {
          _id_46460432F5099265 = 1;
          break;
        }
      }

      foreach(_id_EEF26A325310D3AF in level.objectives) {
        if(istrue(_id_EEF26A325310D3AF.trigger.trigger_off)) {
          continue;
        }
        ownerteam = _id_EEF26A325310D3AF.ownerteam;

        if(ownerteam == self.team) {
          _id_ABB6FBDD8CD1A1D2 = distancesquared(_id_EEF26A325310D3AF.trigger.origin, self.origin);
          _id_44096CEE99B7A48B = distancesquared(_id_EEF26A325310D3AF.trigger.origin, victim.origin);

          if(_id_ABB6FBDD8CD1A1D2 < 90000 || _id_44096CEE99B7A48B < 90000) {
            _id_46460432F5099265 = 1;
            break;
          }
        }
      }

      break;
    case "dd":
    case "sr":
    case "sd":
      if(self.team != game["defenders"]) {
        break;
      }

      foreach(objective in level.objectives) {
        _id_77ADA7456CAC5C0E = distancesquared(objective.trigger.origin, victim.origin);

        if(_id_77ADA7456CAC5C0E < 90000) {
          _id_46460432F5099265 = 1;
          break;
        }
      }

      break;
    case "grind":
    case "pill":
    case "conflict":
    case "siege":
    case "dom":
    case "risk":
    case "control":
    case "arm":
      foreach(objective in level.objectives) {
        if(self.team != objective.ownerteam) {
          continue;
        }
        _id_2F26C572A7A12636 = distancesquared(objective.curorigin, self.origin);
        _id_D0502D3FAD28FA4F = distancesquared(objective.curorigin, victim.origin);

        if(_id_2F26C572A7A12636 < 90000 || _id_D0502D3FAD28FA4F < 90000) {
          _id_46460432F5099265 = 1;
          break;
        }
      }

      break;
    case "grnd":
    case "koth":
    case "hq":
      if(isDefined(level.zone))
        _id_46460432F5099265 = ispointinvolume(self.origin, level.zone.trigger) || ispointinvolume(victim.origin, level.zone.trigger);

      break;
  }

  return _id_46460432F5099265;
}

isassaulting(victim) {
  _id_46460432F5099265 = 0;

  switch (getgametype()) {
    case "cyber":
      if(istrue(victim.isbombcarrier)) {
        _id_46460432F5099265 = 1;
        break;
      }

      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        _id_ABB6FBDD8CD1A1D2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        _id_44096CEE99B7A48B = distancesquared(level.cyberemp.carrier.origin, victim.origin);

        if(_id_ABB6FBDD8CD1A1D2 < 90000 || _id_44096CEE99B7A48B < 90000) {
          _id_46460432F5099265 = 1;
          break;
        }
      }

      foreach(_id_EEF26A325310D3AF in level.objectives) {
        if(istrue(_id_EEF26A325310D3AF.trigger.trigger_off)) {
          continue;
        }
        ownerteam = _id_EEF26A325310D3AF.ownerteam;

        if(ownerteam != self.team) {
          _id_2F26C572A7A12636 = distancesquared(_id_EEF26A325310D3AF.trigger.origin, self.origin);
          _id_D0502D3FAD28FA4F = distancesquared(_id_EEF26A325310D3AF.trigger.origin, victim.origin);

          if(_id_2F26C572A7A12636 < 90000 || _id_D0502D3FAD28FA4F < 90000) {
            _id_46460432F5099265 = 1;
            break;
          }
        }
      }

      break;
    case "dd":
    case "sr":
    case "sd":
      if(self.team == game["defenders"]) {
        break;
      }

      foreach(objective in level.objectives) {
        _id_77ADA7456CAC5C0E = distancesquared(objective.trigger.origin, victim.origin);

        if(_id_77ADA7456CAC5C0E < 90000) {
          _id_46460432F5099265 = 1;
          break;
        }
      }

      break;
    case "grind":
    case "pill":
    case "conflict":
    case "siege":
    case "dom":
    case "risk":
    case "control":
    case "arm":
      foreach(objective in level.objectives) {
        if(self.team == objective.ownerteam) {
          continue;
        }
        _id_2F26C572A7A12636 = distancesquared(objective.curorigin, self.origin);
        _id_D0502D3FAD28FA4F = distancesquared(objective.curorigin, victim.origin);

        if(_id_2F26C572A7A12636 < 90000 || _id_D0502D3FAD28FA4F < 90000) {
          _id_46460432F5099265 = 1;
          break;
        }
      }

      break;
    case "grnd":
    case "koth":
    case "hq":
      if(isDefined(level.zone))
        _id_46460432F5099265 = ispointinvolume(self.origin, level.zone.trigger) || ispointinvolume(victim.origin, level.zone.trigger);

      break;
  }

  return _id_46460432F5099265;
}

gametypesupportsbasejumping() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 1;

  if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
    return 0;

  switch (getgametype()) {
    case "war":
    case "brtdm_mgl":
    case "brtdm":
    case "gwtdm":
    case "gwai":
    case "gwbomb":
    case "trial":
    case "bigctf":
    case "conflict":
    case "siege":
    case "dom":
    case "risk":
    case "infect":
    case "arm":
      return 1;
    default:
      return 0;
  }
}

mapsupportsbasejumping() {
  if(scripts\cp_mp\utility\game_utility::isdonetskmap() || scripts\cp_mp\utility\game_utility::islargemap())
    return 1;

  switch (level.mapname) {
    case "mp_firingrange":
      return 1;
    case "mp_bm_bunker01":
      return 1;
    case "mp_t10_avalon_colosseum":
      return 1;
    case "mp_t10_test_avalon_shipyard":
      return 1;
    case "mp_t10_test_avalon_heliport":
      return 1;
    case "mp_t10_test_bbroer02":
      return 1;
    case "mp_t10_test_eleblanc":
      return 1;
    default:
      return 0;
  }
}

logannouncement(player, _id_08B206AE73134AF8, message, _id_456B8F0EA933D0E5, _id_6BE94E066872096D) {
  _id_C11C25D130348314 = scripts\mp\matchdata::gettimefrommatchstart(gettime());

  if(!isDefined(message)) {
    return;
  }
  info = "";

  if(isDefined(_id_6BE94E066872096D))
    info = _id_6BE94E066872096D;
  else
    info = "none";

  if(!isDefined(player)) {
    if(isDefined(_id_456B8F0EA933D0E5))
      dlog_recordevent("dlog_event_announcement", ["time_from_match_start", _id_C11C25D130348314, "announcement", message, "extra_info", info, "player_team", "none", "contester_team", "none", "zone_x", _id_456B8F0EA933D0E5[0], "zone_y", _id_456B8F0EA933D0E5[1], "zone_z", _id_456B8F0EA933D0E5[2]]);
    else
      dlog_recordevent("dlog_event_announcement", ["time_from_match_start", _id_C11C25D130348314, "announcement", message, "extra_info", info]);
  } else if(isDefined(_id_08B206AE73134AF8)) {
    if(isDefined(_id_456B8F0EA933D0E5))
      dlog_recordevent("dlog_event_announcement", ["player", player, "contester", _id_08B206AE73134AF8, "time_from_match_start", _id_C11C25D130348314, "announcement", message, "extra_info", info, "player_team", player.team, "contester_team", _id_08B206AE73134AF8.team, "zone_x", _id_456B8F0EA933D0E5[0], "zone_y", _id_456B8F0EA933D0E5[1], "zone_z", _id_456B8F0EA933D0E5[2]]);
    else
      dlog_recordevent("dlog_event_announcement", ["player", player, "contester", _id_08B206AE73134AF8, "time_from_match_start", _id_C11C25D130348314, "announcement", message, "extra_info", info, "player_team", player.team, "contester_team", _id_08B206AE73134AF8.team]);
  } else if(isDefined(_id_456B8F0EA933D0E5))
    dlog_recordevent("dlog_event_announcement", ["player", player, "time_from_match_start", _id_C11C25D130348314, "announcement", message, "extra_info", info, "player_team", player.team, "contester_team", "none", "zone_x", _id_456B8F0EA933D0E5[0], "zone_y", _id_456B8F0EA933D0E5[1], "zone_z", _id_456B8F0EA933D0E5[2]]);
  else
    dlog_recordevent("dlog_event_announcement", ["player", player, "time_from_match_start", _id_C11C25D130348314, "announcement", message, "extra_info", info, "player_team", player.team]);
}

isprophuntgametype() {
  return istrue(level.isprophunt);
}

isgroundwarcoremode() {
  return istrue(level.isgroundwarinfected) || istrue(level.isgroundwarsiege) || istrue(level.isgroundwardom) || istrue(level._id_904F766B5267E332);
}

_id_A7CAA13EBE4C4BA5() {
  switch (getgametype()) {
    case "rescue":
    case "gwtdm":
    case "gwai":
    case "gwbomb":
    case "bigctf":
    case "conflict":
    case "cyber":
    case "sd":
    case "risk":
    case "arm":
      return 1;
    default:
      return 0;
  }
}

isverdansksubmap() {
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

_id_E417D8EF1C70CBCB() {
  if(scripts\cp_mp\utility\game_utility::islargemap())
    return 1;
  else if(scripts\cp_mp\utility\game_utility::isdonetskmap())
    return 1;
  else if(isverdansksubmap())
    return 1;
  else if(getdvarint("dvar_E35A761BC944E0F8", 0) != 1)
    return 1;

  return 0;
}

canparachutebecut(player) {
  _id_37B3FB3FF20A3EB6 = 0;
  _id_A5150DC49F8B1CC7 = 0;
  gametype = getgametype();

  if((gametype == "arm" || gametype == "bigctf" || gametype == "conflict" || gametype == "risk" || gametype == "gwbomb" || isgroundwarcoremode()) && scripts\cp_mp\utility\game_utility::islargemap() || getdvarint("dvar_9365C7A237EDAA2F", 0) == 1) {
    if(istrue(level.parachutecancutautodeploy))
      _id_37B3FB3FF20A3EB6 = 1;

    if(istrue(level.parachutecancutparachute) && !istrue(player._id_4DA443F197C8014E))
      _id_A5150DC49F8B1CC7 = 1;
  }

  if(_id_37B3FB3FF20A3EB6)
    player skydive_cutautodeployon();
  else
    player skydive_cutautodeployoff();

  if(_id_A5150DC49F8B1CC7)
    player skydive_cutparachuteon();
  else
    player skydive_cutparachuteoff();
}

_id_1E098780C33853F2() {
  return matchmakinggame() && getdvarint("dvar_72FE29AA713EA21E", 0) != 0;
}

_id_AC09124B4E7535A6() {
  return matchmakinggame() && getdvarint("dvar_72FE29AA713EA21E", 0) == 1;
}

_id_B7D052E4BF41EE9B() {
  if(_id_1E098780C33853F2())
    return 1;

  return 0;
}

_id_EB3158A25AEE673A() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_FAF0D2FAC3F47583 = getsubgametype();
    return _id_FAF0D2FAC3F47583 == "dmz" || _id_FAF0D2FAC3F47583 == "exgm";
  }

  return 0;
}

_id_D7EC918E29C0B2F4() {
  return level._id_12CA3A9EE540A9ED;
}

_id_F698BFD3EFA33302() {
  return istrue(level.supportcranked);
}

_id_E9F3A160BBEFE208(player) {
  return isDefined(player) && istrue(player.supportcranked);
}