/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\print.gsc
***********************************************/

printonteam(_id_03B3911DBB789B1D, team) {
  foreach(player in level.players) {
    if(player.team != team) {
      continue;
    }
    player iprintln(_id_03B3911DBB789B1D);
  }
}

printboldonteam(text, team) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(isDefined(player.pers["team"]) && player.pers["team"] == team)
      player iprintlnbold(text);
  }
}

printboldonteamarg(text, team, _id_8B461603A1F825D3) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(isDefined(player.pers["team"]) && player.pers["team"] == team)
      player iprintlnbold(text, _id_8B461603A1F825D3);
  }
}

printonteamarg(text, team, _id_8B461603A1F825D3) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(isDefined(player.pers["team"]) && player.pers["team"] == team)
      player iprintln(text, _id_8B461603A1F825D3);
  }
}

printonplayers(text, team) {
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(team)) {
      if(isDefined(players[_id_AC0E594AC96AA3A8].pers["team"]) && players[_id_AC0E594AC96AA3A8].pers["team"] == team)
        players[_id_AC0E594AC96AA3A8] iprintln(text);

      continue;
    }

    players[_id_AC0E594AC96AA3A8] iprintln(text);
  }
}

printandsoundoneveryone(team, otherteam, _id_3BFC74BCA56DC083, _id_04996CB790A76D90, _id_96B42188DDE6B587, _id_6E876B0E771031C4, _id_10F856AF87757278) {
  _id_C5A058D1489C98BB = isDefined(_id_96B42188DDE6B587);
  _id_1273B8AA3CD214D1 = 0;

  if(isDefined(_id_6E876B0E771031C4))
    _id_1273B8AA3CD214D1 = 1;

  if(level.splitscreen || !_id_C5A058D1489C98BB) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];
      playerteam = player.team;

      if(isDefined(playerteam) && isDefined(_id_10F856AF87757278)) {
        if(playerteam == team && isDefined(_id_3BFC74BCA56DC083)) {
          player iprintln(_id_3BFC74BCA56DC083, _id_10F856AF87757278);
          continue;
        }

        if(playerteam == otherteam && isDefined(_id_04996CB790A76D90))
          player iprintln(_id_04996CB790A76D90, _id_10F856AF87757278);
      }
    }

    if(_id_C5A058D1489C98BB)
      level.players[0] playlocalsound(_id_96B42188DDE6B587);
  } else if(_id_1273B8AA3CD214D1) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];
      playerteam = player.team;

      if(isDefined(playerteam)) {
        if(playerteam == team) {
          if(isDefined(_id_3BFC74BCA56DC083))
            player iprintln(_id_3BFC74BCA56DC083, _id_10F856AF87757278);

          player playlocalsound(_id_96B42188DDE6B587);
          continue;
        }

        if(playerteam == otherteam) {
          if(isDefined(_id_04996CB790A76D90))
            player iprintln(_id_04996CB790A76D90, _id_10F856AF87757278);

          player playlocalsound(_id_6E876B0E771031C4);
        }
      }
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];
      playerteam = player.team;

      if(isDefined(playerteam)) {
        if(playerteam == team) {
          if(isDefined(_id_3BFC74BCA56DC083))
            player iprintln(_id_3BFC74BCA56DC083, _id_10F856AF87757278);

          player playlocalsound(_id_96B42188DDE6B587);
          continue;
        }

        if(playerteam == otherteam) {
          if(isDefined(_id_04996CB790A76D90))
            player iprintln(_id_04996CB790A76D90, _id_10F856AF87757278);
        }
      }
    }
  }
}

printandsoundonteam(team, _id_03B3911DBB789B1D, soundalias) {
  foreach(player in level.players) {
    if(player.team != team) {
      continue;
    }
    player printandsoundonplayer(_id_03B3911DBB789B1D, soundalias);
  }
}

printandsoundonplayer(_id_03B3911DBB789B1D, soundalias) {
  self iprintln(_id_03B3911DBB789B1D);
  self playlocalsound(soundalias);
}

printgameaction(msg, player) {
  if(getdvarint("scr_suppress_game_actions", 0) == 1) {
    return;
  }
  _id_4FF53C0F1206C71D = "";

  if(isDefined(player)) {
    if(isPlayer(player))
      _id_4FF53C0F1206C71D = "[" + player getentitynumber() + ":" + player.name + "] ";
    else
      _id_4FF53C0F1206C71D = "[" + player getentitynumber() + "]";
  }
}

teamhudtutorialmessage(msg, team, time) {
  if(!scripts\mp\utility\teams::getteamdata(team, "teamCount")) {
    return;
  }
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players"))
  player thread tutorialprint(msg, time);
}

tutorialprint(msg, time, _id_B64FB86F3B6ECB4B) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(_id_B64FB86F3B6ECB4B))
    _id_B64FB86F3B6ECB4B = 1;

  self sethudtutorialmessage(msg, _id_B64FB86F3B6ECB4B);
  wait(time);
  self clearhudtutorialmessage();
}

getformattedtimestamp() {
  _id_5A888D1F754C231F = gettime();
  hours = int(_id_5A888D1F754C231F * 0.000000277778);
  _id_5A888D1F754C231F = _id_5A888D1F754C231F - hours * 3600000;
  _id_6C681AD49BE4496A = int(_id_5A888D1F754C231F * 0.0000166667);
  _id_5A888D1F754C231F = _id_5A888D1F754C231F - _id_6C681AD49BE4496A * 60000;
  _id_CC748B6D457627FE = int(_id_5A888D1F754C231F * 0.001);
  _id_5A888D1F754C231F = _id_5A888D1F754C231F - _id_CC748B6D457627FE * 1000;
  _id_6053DCEE5C49332C = undefined;

  if(hours < 10)
    _id_6053DCEE5C49332C = "00" + hours;
  else if(hours < 100)
    _id_6053DCEE5C49332C = "0" + hours;
  else
    _id_6053DCEE5C49332C = "" + hours;

  _id_BA1D3B06ACD32166 = scripts\engine\utility::ter_op(_id_6C681AD49BE4496A < 10, "0" + _id_6C681AD49BE4496A, "" + _id_6C681AD49BE4496A);
  _id_5580595A2AA92D9A = scripts\engine\utility::ter_op(_id_CC748B6D457627FE < 10, "0" + _id_CC748B6D457627FE, "" + _id_CC748B6D457627FE);
  _id_BA25552E1955513E = undefined;

  if(_id_5A888D1F754C231F < 10)
    _id_BA25552E1955513E = "00" + _id_5A888D1F754C231F;
  else if(_id_5A888D1F754C231F < 100)
    _id_BA25552E1955513E = "0" + _id_5A888D1F754C231F;
  else
    _id_BA25552E1955513E = "" + _id_5A888D1F754C231F;

  return _id_6053DCEE5C49332C + ":" + _id_BA1D3B06ACD32166 + ":" + _id_5580595A2AA92D9A + ":" + _id_BA25552E1955513E;
}

datalogprint(message, tag) {
  if(!analyticsstreamerislogfilestreamingenabled()) {
    return;
  }
  text = "";

  if(isDefined(tag))
    text = text + ("<" + tag + "> ");

  text = text + (message + "\n");
  analyticsstreamerlogfilewritetobuffer(text);
}