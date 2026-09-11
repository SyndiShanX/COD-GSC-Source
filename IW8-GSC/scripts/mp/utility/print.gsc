/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\print.gsc
***********************************************/

function printonteam(var0, var1) {
  foreach(var3 in level.players) {
    if(var3.team != var1) {
      continue;
    }

    var3 iprintln(var0);
  }
}

function printboldonteam(var0, var1) {
  for(var2 = 0; var2 < level.players.size; var2++) {
    var3 = level.players[var2];

    if(isDefined(var3.pers["team"]) && var3.pers["team"] == var1) {
      var3 iprintlnbold(var0);
    }
  }
}

function printboldonteamarg(var0, var1, var2) {
  for(var3 = 0; var3 < level.players.size; var3++) {
    var4 = level.players[var3];

    if(isDefined(var4.pers["team"]) && var4.pers["team"] == var1) {
      var4 iprintlnbold(var0, var2);
    }
  }
}

function printonteamarg(var0, var1, var2) {
  for(var3 = 0; var3 < level.players.size; var3++) {
    var4 = level.players[var3];

    if(isDefined(var4.pers["team"]) && var4.pers["team"] == var1) {
      var4 iprintln(var0, var2);
    }
  }
}

function printonplayers(var0, var1) {
  var2 = level.players;

  for(var3 = 0; var3 < var2.size; var3++) {
    if(isDefined(var1)) {
      if(isDefined(var2[var3].pers["team"]) && var2[var3].pers["team"] == var1) {
        var2[var3] iprintln(var0);
      }

      continue;
    }

    var2[var3] iprintln(var0);
  }
}

function printandsoundoneveryone(var0, var1, var2, var3, var4, var5, var6) {
  var7 = isDefined(var4);
  var8 = 0;

  if(isDefined(var5)) {
    var8 = 1;
  }

  if(level.splitscreen || !var7) {
    for(var9 = 0; var9 < level.players.size; var9++) {
      var10 = level.players[var9];
      var11 = var10.team;

      if(isDefined(var11)) {
        if(var11 == var0 && isDefined(var2)) {
          var10 iprintln(var2, var6);
          continue;
        }

        if(var11 == var1 && isDefined(var3)) {
          var10 iprintln(var3, var6);
        }
      }
    }

    if(var7) {
      level.players[0] playlocalsound(var4);
      return;
    }

    return;
  }

  if(var11) {
    for(var9 = 0; var9 < level.players.size; var9++) {
      var10 = level.players[var9];
      var11 = var10.team;

      if(isDefined(var11)) {
        if(var11 == var3) {
          if(isDefined(var5)) {
            var10 iprintln(var5, var9);
          }

          var10 playlocalsound(var7);
          continue;
        }

        if(var11 == var4) {
          if(isDefined(var6)) {
            var10 iprintln(var6, var9);
          }

          var10 playlocalsound(var8);
        }
      }
    }

    return;
  }

  for(var9 = 0; var9 < level.players.size; var9++) {
    var10 = level.players[var9];
    var11 = var10.team;

    if(isDefined(var11)) {
      if(var11 == var6) {
        if(isDefined(var8)) {
          var10 iprintln(var8, var9);
        }

        var10 playlocalsound(var10);
        continue;
      }

      if(var11 == var7) {
        if(isDefined(var9)) {
          var10 iprintln(var9, var9);
        }
      }
    }
  }
}

function printandsoundonteam(var0, var1, var2) {
  foreach(var4 in level.players) {
    if(var4.team != var0) {
      continue;
    }

    printandsoundonplayer(var4, var1, var2);
  }
}

function printandsoundonplayer(var0, var1) {
  self iprintln(var0);
  self playlocalsound(var1);
}

function printgameaction(var0, var1) {
  if(getdvarint("scr_suppress_game_actions", 0) == 1) {
    return;
  }

  var2 = "";

  if(isDefined(var1)) {
    var2 = "[" + var1 getentitynumber() + ":" + var1.name + "] ";
  }
}

function teamhudtutorialmessage(var0, var1, var2) {
  if(!scripts\mp\utility\teams::getteamdata(var1, "teamCount")) {
    return;
  }

  foreach(var4 in scripts\mp\utility\teams::getteamdata(var1, "players")) {
    thread tutorialprint(var4, var0);
  }
}

function tutorialprint(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self sethudtutorialmessage(var0);
  wait var1;
  self clearhudtutorialmessage();
}

function getformattedtimestamp() {
  var0 = gettime();
  var1 = int(var0 * 2.77778e-07);
  var0 -= var1 * 3600000;
  var2 = int(var0 * 1.66667e-05);
  var0 -= var2 * 60000;
  var3 = int(var0 * 0.001);
  var0 -= var3 * 1000;
  var4 = undefined;

  if(var1 < 10) {
    var4 = "00" + var1;
  } else if(var1 < 100) {
    var4 = "0" + var1;
  } else {
    var4 = "" + var1;
  }

  var5 = scripts\engine\utility::ter_op(var2 < 10, "0" + var2, "" + var2);
  var6 = scripts\engine\utility::ter_op(var3 < 10, "0" + var3, "" + var3);
  var7 = undefined;

  if(var0 < 10) {
    var7 = "00" + var0;
  } else if(var0 < 100) {
    var7 = "0" + var0;
  } else {
    var7 = "" + var0;
  }

  return var4 + ":" + var5 + ":" + var6 + ":" + var7;
}

function datalogprint(var0, var1) {
  if(!drawentitybounds()) {
    return;
  }

  var2 = "";

  if(isDefined(var1)) {
    var2 += "<" + var1 + "> ";
  }

  var2 += var0 + "\n";
  analyticsstreamerlogfiletagplayer(var2);
}