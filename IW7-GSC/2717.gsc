/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2717.gsc
***************************************/

init() {
  if(!isDefined(level.var_5056) || level.var_5056 == 0) {
    return;
  }
  if(!isDefined(game["defcon"])) {
    game["defcon"] = 4;
  }

  setdvar("scr_defcon", game["defcon"]);
  level.var_5059[5] = 0;
  level.var_5059[4] = 0;
  level.var_5059[3] = -1;
  level.var_5059[2] = -1;
  level.var_5059[1] = -1;
  level.var_5057[5] = 1;
  level.var_5057[4] = 1;
  level.var_5057[3] = 1;
  level.var_5057[2] = 1;
  level.var_5057[1] = 2;
  func_12E87(game["defcon"]);
  thread func_5054();
}

func_5055(var_0) {
  for(;;) {
    level waittill("player_got_killstreak_" + var_0, var_1);
    level notify("defcon_killstreak", var_0, var_1);
  }
}

func_5054() {
  level endon("game_ended");
  var_0 = 10;
  level thread func_5055(var_0);
  level thread func_5055(var_0 - 1);
  level thread func_5055(var_0 - 2);
  level thread func_5055(var_0 * 2);
  level thread func_5055(var_0 * 2 - 1);
  level thread func_5055(var_0 * 2 - 2);
  level thread func_5055(var_0 * 3);
  level thread func_5055(var_0 * 3 - 1);
  level thread func_5055(var_0 * 3 - 2);

  for(;;) {
    level waittill("defcon_killstreak", var_1, var_2);

    if(game["defcon"] <= 1) {
      continue;
    }
    if(var_1 % var_0 == var_0 - 2) {
      foreach(var_4 in level.players) {
        if(!isalive(var_4)) {
          continue;
        }
        var_4 thread scripts\mp\hud_message::showsplash("two_from_defcon", undefined, var_2);
      }

      continue;
    }

    if(var_1 % var_0 == var_0 - 1) {
      foreach(var_4 in level.players) {
        if(!isalive(var_4)) {
          continue;
        }
        var_4 thread scripts\mp\hud_message::showsplash("one_from_defcon", undefined, var_2);
      }

      continue;
    }

    func_12E87(game["defcon"] - 1, var_2, var_1);
  }
}

func_12E87(var_0, var_1, var_2) {
  var_0 = int(var_0);
  var_3 = game["defcon"];
  game["defcon"] = var_0;
  level.var_C2A7 = level.var_5057[var_0];
  setdvar("scr_defcon", game["defcon"]);

  if(isDefined(var_1)) {
    var_1 notify("changed_defcon");
  }

  if(var_0 == var_3) {
    return;
  }
  if(game["defcon"] == 3 && isDefined(var_1)) {
    var_1 scripts\mp\killstreaks\killstreaks::givekillstreak("airdrop_mega");
    var_1 thread scripts\mp\hud_message::showsplash("caused_defcon", var_2);
  }

  foreach(var_5 in level.players) {
    if(isalive(var_5)) {
      if(isDefined(var_1)) {
        var_5 thread scripts\mp\hud_message::showsplash("changed_defcon", undefined, var_1);
      }
    }
  }
}