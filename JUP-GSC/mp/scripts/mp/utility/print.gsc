/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\print.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;
#namespace print;

function printonteam(printstring, team) {
  foreach(player in level.players) {
    if(player.team != team) {
      continue;
    }

    player iprintln(printstring);
  }
}

function printboldonteam(text, team) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player iprintlnbold(text);
    }
  }
}

function printboldonteamarg(text, team, arg) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player iprintlnbold(text, arg);
    }
  }
}

function printonteamarg(text, team, arg) {
  assert(isDefined(level.players));

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers["team"]) && player.pers["team"] == team) {
      player iprintln(text, arg);
    }
  }
}

function printonplayers(text, team) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    if(isDefined(team)) {
      if(isDefined(players[i].pers["team"]) && players[i].pers["team"] == team) {
        players[i] iprintln(text);
      }

      continue;
    }

    players[i] iprintln(text);
  }
}

function printandsoundoneveryone(team, otherteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg) {
  shoulddosounds = isDefined(soundfriendly);
  shoulddoenemysounds = 0;

  if(isDefined(soundenemy)) {
    assert(shoulddosounds);
    shoulddoenemysounds = 1;
  }

  if(level.splitscreen || !shoulddosounds) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      playerteam = player.team;

      if(isDefined(playerteam) && isDefined(printarg)) {
        if(playerteam == team && isDefined(printfriendly)) {
          player iprintln(printfriendly, printarg);
          continue;
        }

        if(playerteam == otherteam && isDefined(printenemy)) {
          player iprintln(printenemy, printarg);
        }
      }
    }

    if(shoulddosounds) {
      assert(level.splitscreen);
      level.players[0] playlocalsound(soundfriendly);
    }

    return;
  }

  assert(shoulddosounds);

  if(shoulddoenemysounds) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      playerteam = player.team;

      if(isDefined(playerteam)) {
        if(playerteam == team) {
          if(isDefined(printfriendly)) {
            player iprintln(printfriendly, printarg);
          }

          player playlocalsound(soundfriendly);
          continue;
        }

        if(playerteam == otherteam) {
          if(isDefined(printenemy)) {
            player iprintln(printenemy, printarg);
          }

          player playlocalsound(soundenemy);
        }
      }
    }

    return;
  }

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    playerteam = player.team;

    if(isDefined(playerteam)) {
      if(playerteam == team) {
        if(isDefined(printfriendly)) {
          player iprintln(printfriendly, printarg);
        }

        player playlocalsound(soundfriendly);
        continue;
      }

      if(playerteam == otherteam) {
        if(isDefined(printenemy)) {
          player iprintln(printenemy, printarg);
        }
      }
    }
  }
}

function printandsoundonteam(team, printstring, soundalias) {
  foreach(player in level.players) {
    if(player.team != team) {
      continue;
    }

    player printandsoundonplayer(printstring, soundalias);
  }
}

function printandsoundonplayer(printstring, soundalias) {
  self iprintln(printstring);
  self playlocalsound(soundalias);
}

function printgameaction(msg, player) {
  if(getdvarint(@ "hash_dd6678cdc48d6adf", 0) == 1) {
    return;
  }

  playerstring = "";

  if(isDefined(player)) {
    if(isPlayer(player)) {
      playerstring = "[" + player getentitynumber() + ":" + player.name + "] ";
    } else {
      playerstring = "[" + player getentitynumber() + "]";
    }
  }

  println("<dev string:x1c>" + playerstring + msg + "<dev string:x24>" + gettime() + "<dev string:x2a>");
}

function teamhudtutorialmessage(msg, team, time) {
  if(!getteamdata(team, "teamCount")) {
    return;
  }

  foreach(player in getteamdata(team, "players")) {
    player thread tutorialprint(msg, time);
  }
}

function tutorialprint(msg, time, optional_state) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(optional_state)) {
    optional_state = 1;
  }

  self sethudtutorialmessage(msg, optional_state);
  wait time;
  self clearhudtutorialmessage();
}

function getformattedtimestamp(var_5020b0f5e510abb3) {
  if(isDefined(var_5020b0f5e510abb3)) {
    milliseconds = var_5020b0f5e510abb3;
  } else {
    milliseconds = gettime();
  }

  hours = int(milliseconds * 2.77778e-07);
  milliseconds -= hours * 3600000;
  minutes = int(milliseconds * 1.66667e-05);
  milliseconds -= minutes * 60000;
  seconds = int(milliseconds * 0.001);
  milliseconds -= seconds * 1000;
  hourtext = undefined;

  if(hours < 10) {
    hourtext = "00" + hours;
  } else if(hours < 100) {
    hourtext = "0" + hours;
  } else {
    hourtext = "" + hours;
  }

  minutetext = ter_op(minutes < 10, "0" + minutes, "" + minutes);
  secondtext = ter_op(seconds < 10, "0" + seconds, "" + seconds);
  mstext = undefined;

  if(milliseconds < 10) {
    mstext = "00" + milliseconds;
  } else if(milliseconds < 100) {
    mstext = "0" + milliseconds;
  } else {
    mstext = "" + milliseconds;
  }

  return hourtext + ":" + minutetext + ":" + secondtext + ":" + mstext;
}

function datalogprint(message, tag) {
  if(!analyticsstreamerislogfilestreamingenabled()) {
    return;
  }

  text = "";

  if(isDefined(tag)) {
    text += "<" + tag + "> ";
  }

  text += message + "\n";
  analyticsstreamerlogfilewritetobuffer(text);
}