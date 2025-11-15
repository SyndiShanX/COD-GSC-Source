/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2717.gsc
***************************************/

init() {
  if(!isDefined(level.func_5056) || level.func_5056 == 0) {
    return;
  }
  if(!isDefined(game["defcon"]))
    game["defcon"] = 4;

  setdvar("scr_defcon", game["defcon"]);
  level.func_5059[5] = 0;
  level.func_5059[4] = 0;
  level.func_5059[3] = -1;
  level.func_5059[2] = -1;
  level.func_5059[1] = -1;
  level.func_5057[5] = 1;
  level.func_5057[4] = 1;
  level.func_5057[3] = 1;
  level.func_5057[2] = 1;
  level.func_5057[1] = 2;
  func_12E87(game["defcon"]);
  thread func_5054();
}

func_5055(var_00) {
  for(;;) {
    level waittill("player_got_killstreak_" + var_00, var_01);
    level notify("defcon_killstreak", var_00, var_01);
  }
}

func_5054() {
  level endon("game_ended");
  var_00 = 10;
  level thread func_5055(var_00);
  level thread func_5055(var_00 - 1);
  level thread func_5055(var_00 - 2);
  level thread func_5055(var_00 * 2);
  level thread func_5055(var_00 * 2 - 1);
  level thread func_5055(var_00 * 2 - 2);
  level thread func_5055(var_00 * 3);
  level thread func_5055(var_00 * 3 - 1);
  level thread func_5055(var_00 * 3 - 2);

  for(;;) {
    level waittill("defcon_killstreak", var_01, var_02);

    if(game["defcon"] <= 1) {
      continue;
    }
    if(var_01 % var_00 == var_00 - 2) {
      foreach(var_04 in level.players) {
        if(!isalive(var_04)) {
          continue;
        }
        var_04 thread scripts\mp\hud_message::showsplash("two_from_defcon", undefined, var_02);
      }

      continue;
    }

    if(var_01 % var_00 == var_00 - 1) {
      foreach(var_04 in level.players) {
        if(!isalive(var_04)) {
          continue;
        }
        var_04 thread scripts\mp\hud_message::showsplash("one_from_defcon", undefined, var_02);
      }

      continue;
    }

    func_12E87(game["defcon"] - 1, var_02, var_01);
  }
}

func_12E87(var_00, var_01, var_02) {
  var_00 = int(var_00);
  var_03 = game["defcon"];
  game["defcon"] = var_00;
  level.func_C2A7 = level.func_5057[var_00];
  setdvar("scr_defcon", game["defcon"]);

  if(isDefined(var_01))
    var_01 notify("changed_defcon");

  if(var_00 == var_03) {
    return;
  }
  if(game["defcon"] == 3 && isDefined(var_01)) {
    var_01 scripts\mp\killstreaks\killstreaks::givekillstreak("airdrop_mega");
    var_01 thread scripts\mp\hud_message::showsplash("caused_defcon", var_02);
  }

  foreach(var_05 in level.players) {
    if(isalive(var_05)) {
      if(isDefined(var_01))
        var_05 thread scripts\mp\hud_message::showsplash("changed_defcon", undefined, var_01);
    }
  }
}