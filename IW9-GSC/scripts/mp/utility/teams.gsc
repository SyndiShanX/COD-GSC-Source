/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\teams.gsc
***********************************************/

getteamdata(team, _id_8E9EF05D6E84968C) {
  return level.teamdata[team][_id_8E9EF05D6E84968C];
}

setteamdata(team, _id_8E9EF05D6E84968C, value) {
  level.teamdata[team][_id_8E9EF05D6E84968C] = value;
}

modifyteamdata(team, _id_8E9EF05D6E84968C, value) {
  level.teamdata[team][_id_8E9EF05D6E84968C] = level.teamdata[team][_id_8E9EF05D6E84968C] + value;
}

addplayertoteam(player, team, _id_CF5D3F8F0D10E600) {
  level.teamdata[team]["teamCount"]++;
  level.teamdata[team]["players"] = scripts\engine\utility::array_add(level.teamdata[team]["players"], player);

  if(_id_CF5D3F8F0D10E600)
    addtoteamlives(player, team, undefined, "addPlayerToTeam");
}

removeplayerfromteam(player, team) {
  level.teamdata[team]["teamCount"]--;
  level.teamdata[team]["players"] = scripts\engine\utility::array_remove(level.teamdata[team]["players"], player);
}

addtoteamlives(player, team, _id_28335DE6505D7E0C, context) {
  context = scripts\engine\utility::_id_53C4C53197386572(context, "?");

  if(_id_29988E4859C121F3(player, team, context)) {
    level.teamdata[team]["aliveCount"]++;
    level.teamdata[team]["alivePlayers"] = scripts\engine\utility::array_add(level.teamdata[team]["alivePlayers"], player);
  }

  if(level.multiteambased)
    level.teamdata[team]["deathEvent"] = 0;

  validatealivecount("add", team, player, context);

  if(isDefined(level.modeaddtoteamlives))
    [[level.modeaddtoteamlives]](player, team, context);

  if(scripts\mp\utility\game::lpcfeaturegated()) {
    return;
  }
  if(istrue(_id_28335DE6505D7E0C) && isgameplayteam(team)) {
    foreach(player in level.teamdata[team]["players"])
    player playlocalsound("mp_bodycount_tick_positive");

    enemies = getenemyplayers(team);

    foreach(player in enemies)
    player playlocalsound("mp_bodycount_tick_negative");
  }
}

_id_29988E4859C121F3(player, team, context) {
  found = scripts\engine\utility::array_contains(level.teamdata[team]["alivePlayers"], player);

  if(found) {
    message = "[alivePlayers] Attempt to add duplicated player to alivePlayers array.";
    aliveplayers = level.teamdata[team]["alivePlayers"].size;
    _id_BCE4EFC75EB01319 = level.teamdata[team]["aliveCount"];
    dlog_recordevent("dlog_event_alive_count_mismatch", ["alive_players", aliveplayers, "alive_count", _id_BCE4EFC75EB01319, "event", message, "team", team, "player_xuid", player getxuid(), "player_name", player.name]);
    message = message + " name=" + player.name + " team=" + team + " context =" + context;
    logstring(message);
    return 0;
  }

  return 1;
}

removefromteamlives(player, team, _id_28335DE6505D7E0C, context) {
  context = scripts\engine\utility::_id_53C4C53197386572(context, "?");

  if(_id_52A53A09B91B9DCB(player, team, context)) {
    level.teamdata[team]["aliveCount"]--;
    level.teamdata[team]["alivePlayers"] = scripts\engine\utility::array_remove(level.teamdata[team]["alivePlayers"], player);
  }

  validatealivecount("remove", team, player, context);

  if(isDefined(level.moderemovefromteamlives))
    [[level.moderemovefromteamlives]](player, team, context);

  if(istrue(_id_28335DE6505D7E0C) && isgameplayteam(team)) {
    _id_8E64916B837AFA27 = "mp_bodycount_tick_negative";
    _id_8940A36AC40EBF77 = "mp_bodycount_tick_positive";

    if(level.teamdata[team]["aliveCount"] == 1) {
      _id_8E64916B837AFA27 = "mp_bodycount_tick_negative_final";
      _id_8940A36AC40EBF77 = "mp_bodycount_tick_positive_final";
    }

    foreach(player in level.teamdata[team]["players"])
    player playlocalsound(_id_8E64916B837AFA27);

    if(!scripts\mp\utility\game::lpcfeaturegated()) {
      enemies = getenemyplayers(team);

      foreach(player in enemies)
      player playlocalsound(_id_8940A36AC40EBF77);
    }
  }
}

_id_52A53A09B91B9DCB(player, team, context) {
  message = undefined;
  _id_F95D20ECCE7501B1 = 1;

  if(level.teamdata[team]["aliveCount"] <= 0) {
    _id_F95D20ECCE7501B1 = 0;
    message = "[alivePlayers] Attempt to remove a player, but aliveCount<=0.";
  } else if(!scripts\engine\utility::array_contains(level.teamdata[team]["alivePlayers"], player)) {
    _id_F95D20ECCE7501B1 = 0;
    message = "[alivePlayers] Attempt to remove a player which is not in alivePlayers array.";
  }

  if(!_id_F95D20ECCE7501B1) {
    aliveplayers = level.teamdata[team]["alivePlayers"].size;
    _id_BCE4EFC75EB01319 = level.teamdata[team]["aliveCount"];
    dlog_recordevent("dlog_event_alive_count_mismatch", ["alive_players", aliveplayers, "alive_count", _id_BCE4EFC75EB01319, "event", message, "team", team, "player_xuid", player getxuid(), "player_name", player.name]);
    message = message + " name=" + player.name + " team=" + team + " context =" + context;
    logstring(message);
  }

  return _id_F95D20ECCE7501B1;
}

validatealivecount(eventtype, team, player, context) {
  _id_8129A2CBD6A585D4 = getdvarint("dvar_2BFDCC415ED38338", 1);
  context = scripts\engine\utility::_id_53C4C53197386572(context, "?");
  _id_A6B269D3A73B87F9 = 0;
  _id_1124B7AC7D344FED = 0;

  if(isDefined(eventtype)) {
    if(eventtype == "disconnect" || eventtype == "extract") {
      _id_A6B269D3A73B87F9 = scripts\engine\utility::array_contains(level.teamdata[team]["alivePlayers"], player);

      if(_id_A6B269D3A73B87F9 && _id_8129A2CBD6A585D4)
        player scripts\mp\playerlogic::removefromalivecount(1, "validateAliveCount");
    } else if(eventtype == "add") {
      _id_FD5E7A241044B880 = scripts\engine\utility::array_remove_duplicates(level.teamdata[team]["alivePlayers"]);

      if(_id_FD5E7A241044B880.size < level.teamdata[team]["alivePlayers"].size) {
        _id_1124B7AC7D344FED = 1;
        eventtype = eventtype + " duplicate";
      }
    }
  }

  aliveplayers = level.teamdata[team]["alivePlayers"].size;
  _id_BCE4EFC75EB01319 = level.teamdata[team]["aliveCount"];

  if(aliveplayers != _id_BCE4EFC75EB01319 || _id_A6B269D3A73B87F9 || _id_1124B7AC7D344FED) {
    message = "";

    if(_id_1124B7AC7D344FED)
      message = "WARNING: Duplicate players in alive player array! context=" + context;
    else if(_id_A6B269D3A73B87F9)
      message = "WARNING: player in alive array after disconnect! context=" + context;
    else
      message = "WARNING: alivePlayers and aliveCount are out of sync! context=" + context;

    dlog_recordevent("dlog_event_alive_count_mismatch", ["alive_players", aliveplayers, "alive_count", _id_BCE4EFC75EB01319, "event", eventtype, "team", team, "player_xuid", player getxuid(), "player_name", player.name]);
    scripts\mp\utility\script::demoforcesre(message);

    if(_id_8129A2CBD6A585D4) {
      level.teamdata[team]["alivePlayers"] = scripts\engine\utility::array_remove_duplicates(level.teamdata[team]["alivePlayers"]);
      level.teamdata[team]["aliveCount"] = level.teamdata[team]["alivePlayers"].size;
      [[level.updategameevents]]();
    }
  }
}

getteamcount(team, _id_7102F45D5F0B5834) {
  if(istrue(_id_7102F45D5F0B5834))
    return level.teamdata[team]["alivePlayers"].size;
  else
    return level.teamdata[team]["players"].size;
}

getenemyteams(_id_68BB1F110EC06A58) {
  teams = level.teamnamelist;
  teams = scripts\engine\utility::array_remove(teams, _id_68BB1F110EC06A58);
  return teams;
}

getfriendlyplayers(_id_68BB1F110EC06A58, _id_7102F45D5F0B5834) {
  _id_A38AB755B393EDBE = [];

  if(istrue(_id_7102F45D5F0B5834)) {
    foreach(player in level.teamdata[_id_68BB1F110EC06A58]["alivePlayers"]) {
      if(isDefined(player) && isalive(player) && !isDefined(player.fauxdead))
        _id_A38AB755B393EDBE[_id_A38AB755B393EDBE.size] = player;
    }
  } else {
    foreach(player in level.teamdata[_id_68BB1F110EC06A58]["players"])
    _id_A38AB755B393EDBE[_id_A38AB755B393EDBE.size] = player;
  }

  return _id_A38AB755B393EDBE;
}

getenemyplayers(_id_68BB1F110EC06A58, _id_7102F45D5F0B5834) {
  enemies = [];
  _id_B0C33D224B825287 = getenemyteams(_id_68BB1F110EC06A58);

  foreach(team in _id_B0C33D224B825287) {
    if(istrue(_id_7102F45D5F0B5834)) {
      foreach(player in level.teamdata[team]["alivePlayers"]) {
        if(isDefined(player) && isalive(player) && !isDefined(player.fauxdead))
          enemies[enemies.size] = player;
      }

      continue;
    }

    foreach(player in level.teamdata[team]["players"])
    enemies[enemies.size] = player;
  }

  return enemies;
}

_id_3D0F2343793D709B(_id_68BB1F110EC06A58, _id_D9AA850E7EE12CA3, _id_7102F45D5F0B5834) {
  if(isDefined(_id_68BB1F110EC06A58) && isDefined(_id_D9AA850E7EE12CA3) && isDefined(level.squaddata) && isDefined(level.squaddata[_id_68BB1F110EC06A58]) && isDefined(level.squaddata[_id_68BB1F110EC06A58][_id_D9AA850E7EE12CA3])) {
    if(istrue(_id_7102F45D5F0B5834)) {
      _id_607DA387F3617ED1 = [];

      foreach(player in level.squaddata[_id_68BB1F110EC06A58][_id_D9AA850E7EE12CA3].players) {
        if(scripts\mp\utility\player::isreallyalive(player))
          _id_607DA387F3617ED1[_id_607DA387F3617ED1.size] = player;
      }

      return _id_607DA387F3617ED1;
    } else
      return level.squaddata[_id_68BB1F110EC06A58][_id_D9AA850E7EE12CA3].players;
  }

  return getfriendlyplayers(_id_68BB1F110EC06A58, _id_7102F45D5F0B5834);
}

getenemycount(_id_68BB1F110EC06A58, _id_7102F45D5F0B5834) {
  count = 0;
  _id_B0C33D224B825287 = getenemyteams(_id_68BB1F110EC06A58);

  foreach(team in _id_B0C33D224B825287)
  count = count + getteamcount(team, istrue(_id_7102F45D5F0B5834));

  return count;
}

_id_44A6F98CC3C0F5F4(team) {
  _id_7D247415A9640D07 = scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm";
  _id_65C32DD267D39DDB = team == "team_hundred_ninety_five" || team == "team_hundred_ninety_three" || team == "team_hundred_ninety_four" || team == "team_hundred_ninety_five" || team == "team_hundred_ninety_six" || team == "team_hundred_ninety_seven" || team == "team_hundred_ninety_eight" || team == "team_hundred_ninety_nine";
  return _id_7D247415A9640D07 && _id_65C32DD267D39DDB;
}

isgameplayteam(team) {
  return isDefined(team) && scripts\engine\utility::array_contains(level.teamnamelist, team);
}

getfaction(team) {
  return game[team];
}

getteamname(_id_5EC35B0D0E09922D) {
  if(!isDefined(level.teamdata[_id_5EC35B0D0E09922D]["teamName"]))
    level.teamdata[_id_5EC35B0D0E09922D]["teamName"] = tablelookupistring("mp/factionTable.csv", 0, game[_id_5EC35B0D0E09922D], 1);

  return level.teamdata[_id_5EC35B0D0E09922D]["teamName"];
}

getteamshortname(_id_5EC35B0D0E09922D) {
  if(!isDefined(level.teamdata[_id_5EC35B0D0E09922D]["shortName"]))
    level.teamdata[_id_5EC35B0D0E09922D]["shortName"] = tablelookupistring("mp/factionTable.csv", 0, game[_id_5EC35B0D0E09922D], 2);

  return level.teamdata[_id_5EC35B0D0E09922D]["shortName"];
}

getteamicon(_id_5EC35B0D0E09922D) {
  if(!isDefined(level.teamdata[_id_5EC35B0D0E09922D]["teamIcon"]))
    level.teamdata[_id_5EC35B0D0E09922D]["teamIcon"] = tablelookup("mp/factionTable.csv", 0, game[_id_5EC35B0D0E09922D], 5);

  return level.teamdata[_id_5EC35B0D0E09922D]["teamIcon"];
}

getteamheadicon(_id_5EC35B0D0E09922D) {
  if(!isDefined(level.teamdata[_id_5EC35B0D0E09922D]["headIcon"]))
    level.teamdata[_id_5EC35B0D0E09922D]["headIcon"] = tablelookup("mp/factionTable.csv", 0, game[_id_5EC35B0D0E09922D], 7);

  return level.teamdata[_id_5EC35B0D0E09922D]["headIcon"];
}

getteamvoiceinfix(_id_5EC35B0D0E09922D) {
  if(!isDefined(level.teamdata[_id_5EC35B0D0E09922D]["soundInfix"]))
    level.teamdata[_id_5EC35B0D0E09922D]["soundInfix"] = tablelookup("mp/factionTable.csv", 0, game[_id_5EC35B0D0E09922D], 8);

  return level.teamdata[_id_5EC35B0D0E09922D]["soundInfix"];
}

getcustomizationprefix(_id_5EC35B0D0E09922D) {
  if(!isDefined(level.teamdata[_id_5EC35B0D0E09922D]["customizationInfix"]))
    level.teamdata[_id_5EC35B0D0E09922D]["customizationInfix"] = tablelookup("mp/factionTable.csv", 0, game[_id_5EC35B0D0E09922D], 10);

  return level.teamdata[_id_5EC35B0D0E09922D]["customizationInfix"];
}

_id_F5F92738A88B4577(_id_5EC35B0D0E09922D) {
  if(!isDefined(level.teamdata[_id_5EC35B0D0E09922D]["superFaction"]))
    level.teamdata[_id_5EC35B0D0E09922D]["superFaction"] = tablelookup("mp/factionTable.csv", 0, game[_id_5EC35B0D0E09922D], 14);

  return level.teamdata[_id_5EC35B0D0E09922D]["superFaction"];
}

getteamfactionsfrommap(_id_5EC35B0D0E09922D) {
  if(!isDefined(level.teamdata[_id_5EC35B0D0E09922D]["teamFaction"])) {
    switch (_id_5EC35B0D0E09922D) {
      case "axis":
        _id_93E959B71EB01067 = 10;
        break;
      case "allies":
        _id_93E959B71EB01067 = 11;
        break;
      case "team_three":
        _id_93E959B71EB01067 = 12;
        break;
      case "team_four":
        _id_93E959B71EB01067 = 13;
        break;
      case "team_five":
        _id_93E959B71EB01067 = 14;
        break;
      case "team_six":
        _id_93E959B71EB01067 = 15;
        break;
      default:
        _id_93E959B71EB01067 = 11;
        break;
    }

    level.teamdata[_id_5EC35B0D0E09922D]["teamFaction"] = tablelookup("mp/mapInfo.csv", 0, scripts\cp_mp\utility\game_utility::getmapname(), _id_93E959B71EB01067);

    if(level.teamdata[_id_5EC35B0D0E09922D]["teamFaction"] == "")
      level.teamdata[_id_5EC35B0D0E09922D]["teamFaction"] = "SAS";

    game[_id_5EC35B0D0E09922D] = level.teamdata[_id_5EC35B0D0E09922D]["teamFaction"];
  }

  return level.teamdata[_id_5EC35B0D0E09922D]["teamFaction"];
}

getcustomgametypeteammax() {
  gametype = scripts\mp\utility\game::getgametype();
  return getdvarint(_func_2EF675C13CA1C4AF("scr_", gametype, "_teamcount"), -1);
}

_id_F6728366BA30005C() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "getFriendlyPlayers", ::getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "getEnemyPlayers", ::getenemyplayers);
}

calculatenumteamswithplayers() {
  _id_153F283BCBFFA477 = 0;

  foreach(team in level.teamdata) {
    if(team["players"].size > 0)
      _id_153F283BCBFFA477++;
  }

  level._id_153F283BCBFFA477 = _id_153F283BCBFFA477;
}