/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\print.gsc
***********************************************/

printonteam(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3.team != var_1) {
      continue;
    }
    var_3 iprintln(var_0);
  }
}

printboldonteam(var_0, var_1) {
  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isDefined(var_3.pers["_encstr_8AEF05472BC2D6"]) && var_3.pers["_encstr_8AEF05472BC2D6"] == var_1)
      var_3 iprintlnbold(var_0);
  }
}

printboldonteamarg(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(isDefined(var_4.pers["_encstr_8AEF05472BC2D6"]) && var_4.pers["_encstr_8AEF05472BC2D6"] == var_1)
      var_4 iprintlnbold(var_0, var_2);
  }
}

printonteamarg(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(isDefined(var_4.pers["_encstr_8AEF05472BC2D6"]) && var_4.pers["_encstr_8AEF05472BC2D6"] == var_1)
      var_4 iprintln(var_0, var_2);
  }
}

printonplayers(var_0, var_1) {
  var_2 = level.players;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_1)) {
      if(isDefined(var_2[var_3].pers["_encstr_8AEF05472BC2D6"]) && var_2[var_3].pers["_encstr_8AEF05472BC2D6"] == var_1)
        var_2[var_3] iprintln(var_0);

      continue;
    }

    var_2[var_3] iprintln(var_0);
  }
}

printandsoundoneveryone(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = isDefined(var_4);
  var_8 = 0;

  if(isDefined(var_5))
    var_8 = 1;

  if(level.splitscreen || !var_7) {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];
      var_11 = var_10.team;

      if(isDefined(var_11)) {
        if(var_11 == var_0 && isDefined(var_2)) {
          var_10 iprintln(var_2, var_6);
          continue;
        }

        if(var_11 == var_1 && isDefined(var_3))
          var_10 iprintln(var_3, var_6);
      }
    }

    if(var_7)
      level.players[0] playlocalsound(var_4);
  } else if(var_8) {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];
      var_11 = var_10.team;

      if(isDefined(var_11)) {
        if(var_11 == var_0) {
          if(isDefined(var_2))
            var_10 iprintln(var_2, var_6);

          var_10 playlocalsound(var_4);
          continue;
        }

        if(var_11 == var_1) {
          if(isDefined(var_3))
            var_10 iprintln(var_3, var_6);

          var_10 playlocalsound(var_5);
        }
      }
    }
  } else {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];
      var_11 = var_10.team;

      if(isDefined(var_11)) {
        if(var_11 == var_0) {
          if(isDefined(var_2))
            var_10 iprintln(var_2, var_6);

          var_10 playlocalsound(var_4);
          continue;
        }

        if(var_11 == var_1) {
          if(isDefined(var_3))
            var_10 iprintln(var_3, var_6);
        }
      }
    }
  }
}

printandsoundonteam(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(var_4.team != var_0) {
      continue;
    }
    var_4 printandsoundonplayer(var_1, var_2);
  }
}

printandsoundonplayer(var_0, var_1) {
  self iprintln(var_0);
  self playlocalsound(var_1);
}

printgameaction(var_0, var_1) {
  if(getdvarint("_encstr_97F11A28822A07D317B8F7EE85279BBFD70A4010B906B70B3FDFF066", 0) == 1) {
    return;
  }
  var_2 = "_encstr_B40101";

  if(isDefined(var_1))
    var_2 = "_encstr_B44C0203" + var_1 getentitynumber() + "_encstr_8D4C02E8" + var_1.name + "_encstr_AF07039E3E";
}

teamhudtutorialmessage(var_0, var_1, var_2) {
  if(!scripts\mp\utility\teams::getteamdata(var_1, "_encstr_AB580A05672AE35D5FFF50B8")) {
    return;
  }
  foreach(var_4 in scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B"))
  var_4 thread tutorialprint(var_0, var_2);
}

tutorialprint(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self sethudtutorialmessage(var_0);
  wait(var_1);
  self clearhudtutorialmessage();
}

getformattedtimestamp() {
  var_0 = gettime();
  var_1 = int(var_0 * 0.000000277778);
  var_0 = var_0 - var_1 * 3600000;
  var_2 = int(var_0 * 0.0000166667);
  var_0 = var_0 - var_2 * 60000;
  var_3 = int(var_0 * 0.001);
  var_0 = var_0 - var_3 * 1000;
  var_4 = undefined;

  if(var_1 < 10)
    var_4 = "_encstr_9B0703C081" + var_1;
  else if(var_1 < 100)
    var_4 = "_encstr_934C0218" + var_1;
  else
    var_4 = "_encstr_B40101" + var_1;

  var_5 = scripts\engine\utility::ter_op(var_2 < 10, "_encstr_934C0218" + var_2, "_encstr_B40101" + var_2);
  var_6 = scripts\engine\utility::ter_op(var_3 < 10, "_encstr_934C0218" + var_3, "_encstr_B40101" + var_3);
  var_7 = undefined;

  if(var_0 < 10)
    var_7 = "_encstr_9B0703C081" + var_0;
  else if(var_0 < 100)
    var_7 = "_encstr_934C0218" + var_0;
  else
    var_7 = "_encstr_B40101" + var_0;

  return var_4 + "_encstr_8D4C02E8" + var_5 + "_encstr_8D4C02E8" + var_6 + "_encstr_8D4C02E8" + var_7;
}

datalogprint(var_0, var_1) {
  if(!drawentitybounds()) {
    return;
  }
  var_2 = "_encstr_B40101";

  if(isDefined(var_1))
    var_2 = var_2 + ("_encstr_994C02EF" + var_1 + "_encstr_B40703B1E9");

  var_2 = var_2 + (var_0 + "_encstr_AD4C02A0");
  analyticsstreamerlogfiletagplayer(var_2);
}