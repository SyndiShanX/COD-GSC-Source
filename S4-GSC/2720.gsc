/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2720.gsc
*************************************************/

_id_BD19(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3.team != var_1) {
      continue;
    }
    var_3 iprintln(var_0);
  }
}

_id_BD0F(var_0, var_1) {
  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isDefined(var_3.pers["team"]) && var_3.pers["team"] == var_1) {
      var_3 iprintlnbold(var_0);
    }
  }
}

_id_BD10(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
      var_4 iprintlnbold(var_0, var_2);
    }
  }
}

_id_BD1A(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
      var_4 iprintln(var_0, var_2);
    }
  }
}

_id_BD18(var_0, var_1) {
  var_2 = level.players;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_1)) {
      if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == var_1) {
        var_2[var_3] iprintln(var_0);
      }

      continue;
    }

    var_2[var_3] iprintln(var_0);
  }
}

_id_BD0C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = isDefined(var_4);
  var_8 = 0;

  if(isDefined(var_5)) {
    var_8 = 1;
  }

  if(level.splitscreen || !var_7) {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];
      var_11 = var_10.team;

      if(isDefined(var_11)) {
        if(var_11 == var_0 && isDefined(var_2)) {
          var_10 iprintln(var_2, var_6);
          continue;
        }

        if(var_11 == var_1 && isDefined(var_3)) {
          var_10 iprintln(var_3, var_6);
        }
      }
    }

    if(var_7) {
      level.players[0] playlocalsound(var_4);
    }
  } else if(var_8) {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];
      var_11 = var_10.team;

      if(isDefined(var_11)) {
        if(var_11 == var_0) {
          if(isDefined(var_2)) {
            var_10 iprintln(var_2, var_6);
          }

          var_10 playlocalsound(var_4);
          continue;
        }

        if(var_11 == var_1) {
          if(isDefined(var_3)) {
            var_10 iprintln(var_3, var_6);
          }

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
          if(isDefined(var_2)) {
            var_10 iprintln(var_2, var_6);
          }

          var_10 playlocalsound(var_4);
          continue;
        }

        if(var_11 == var_1) {
          if(isDefined(var_3)) {
            var_10 iprintln(var_3, var_6);
          }
        }
      }
    }
  }
}

_id_BD0E(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(var_4.team != var_0) {
      continue;
    }
    var_4 _id_BD0D(var_1, var_2);
  }
}

_id_BD0D(var_0, var_1) {
  self iprintln(var_0);
  self playlocalsound(var_1);
}

_id_BD15(var_0, var_1) {
  if(getdvarint("#x31b67fc2e3dd57ab1", 0) == 1) {
    return;
  }
  var_2 = "";

  if(isDefined(var_1)) {
    var_2 = "[" + var_1 getentitynumber() + ":" + var_1.name + "] ";
  }
}

_id_EF7B(var_0, var_1, var_2) {
  if(!scripts\mp\utility\teams::_id_6DCA(var_1, "teamCount")) {
    return;
  }
  foreach(var_4 in scripts\mp\utility\teams::_id_6DCA(var_1, "players")) {
    var_4 thread _id_F8D0(var_0, var_2);
  }
}

_id_F8D0(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self sethudtutorialmessage(var_0);
  wait(var_1);
  self clearhudtutorialmessage();
}

_id_6A55() {
  var_0 = gettime();
  var_1 = int(var_0 * 0.000000277778);
  var_0 = var_0 - var_1 * 3600000;
  var_2 = int(var_0 * 0.0000166667);
  var_0 = var_0 - var_2 * 60000;
  var_3 = int(var_0 * 0.001);
  var_0 = var_0 - var_3 * 1000;
  var_4 = undefined;

  if(var_1 < 10) {
    var_4 = "00" + var_1;
  } else if(var_1 < 100) {
    var_4 = "0" + var_1;
  } else {
    var_4 = "" + var_1;
  }

  var_5 = scripts\engine\utility::ter_op(var_2 < 10, "0" + var_2, "" + var_2);
  var_6 = scripts\engine\utility::ter_op(var_3 < 10, "0" + var_3, "" + var_3);
  var_7 = undefined;

  if(var_0 < 10) {
    var_7 = "00" + var_0;
  } else if(var_0 < 100) {
    var_7 = "0" + var_0;
  } else {
    var_7 = "" + var_0;
  }

  return var_4 + ":" + var_5 + ":" + var_6 + ":" + var_7;
}

_id_4360(var_0, var_1) {
  if(!_func_0391()) {
    return;
  }
  var_2 = "";

  if(isDefined(var_1)) {
    var_2 = var_2 + ("<" + var_1 + "> ");
  }

  var_2 = var_2 + (var_0 + "\n");
  _func_038F(var_2);
}