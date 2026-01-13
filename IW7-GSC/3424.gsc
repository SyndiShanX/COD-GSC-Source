/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3424.gsc
*********************************************/

func_13F54() {
  scripts\engine\utility::flag_init("spawn_point_score_data_init_done");
  level.zombies_spawn_score_func = ::func_7C8A;
  level.fake_players = [];
}

func_7C8A(var_0) {
  if(isDefined(var_0)) {
    return radiusdamage(var_0);
  }

  return radiusdamage(level.active_spawners);
}

func_13F59(var_0) {
  if(!scripts\cp\zombies\func_0D5F::critical_factor(scripts\cp\zombies\func_0D5F::func_26B8, var_0)) {
    return "secondary";
  }

  if(!scripts\cp\zombies\func_0D5F::critical_factor(scripts\cp\zombies\func_0D5F::func_26BC, var_0)) {
    return "secondary";
  }

  if(!scripts\cp\zombies\func_0D5F::critical_factor(scripts\cp\zombies\func_0D5F::func_26C4, var_0)) {
    return "secondary";
  }

  return "primary";
}

func_98C8(var_0) {
  var_0.totalscore = 0;
  var_0.var_11A3A = 0;
  var_0.var_C217 = 0;
  var_0.budgetedents = 0;
  var_0.var_A9E9 = [];
  var_0.var_A9E9["allies"] = 0;
  var_0.var_A9E9["axis"] = 0;
}

isinvalidzone(var_0) {
  if(isDefined(var_0.volume) && var_0.volume.var_19) {
    return 1;
  }

  return 0;
}

radiusdamage(var_0) {
  if(!isDefined(level.var_4B9C)) {
    level.var_4B9C = 0;
  } else {
    level.var_4B9C = func_790C(level.var_4B9C);
  }

  var_1 = level.var_4B9C;
  var_2 = [];
  foreach(var_4 in var_0) {
    func_98C8(var_4);
    if(func_13F59(var_4) == "primary") {
      var_2[var_2.size] = var_4;
    }
  }

  if(var_2.size) {
    var_6 = func_EC47(var_2, var_1);
  } else {
    var_6 = scripts\engine\utility::random(var_1);
  }

  scripts\engine\utility::flag_set("spawn_point_score_data_init_done");
  return var_6;
}

func_790C(var_0) {
  var_1 = level.players.size;
  if(var_1 == 1) {
    return 0;
  }

  var_2 = 0;
  var_3 = func_7B17(var_0);
  while(!var_2) {
    if(var_3 == var_0) {
      break;
    }

    var_4 = level.players[var_3];
    if(!scripts\engine\utility::istrue(var_4.spectating) && !scripts\engine\utility::istrue(var_4.is_fast_traveling) && !scripts\engine\utility::istrue(var_4.inlaststand)) {
      var_2 = 1;
    }

    if(!var_2) {
      var_3 = func_7B17(var_3);
    }
  }

  return var_3;
}

func_7B17(var_0) {
  var_1 = var_0 + 1;
  if(isDefined(level.players[var_1])) {
    return var_1;
  }

  var_1++;
  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(isDefined(level.players[var_1])) {
      return var_1;
    }

    if(var_1 >= level.players.size) {
      var_1 = 0;
      continue;
    }

    var_1++;
  }

  return 0;
}

func_EC47(var_0, var_1) {
  var_2 = var_0[0];
  var_0 = scripts\engine\utility::array_randomize(var_0);
  level notify("debug_spawner_score_reset");
  foreach(var_4 in var_0) {
    func_EC31(var_4, var_1);
    if(!isDefined(var_2) || var_4.totalscore > var_2.totalscore) {
      var_2 = var_4;
    }
  }

  return var_2;
}

func_913F(var_0, var_1, var_2) {
  if(var_2) {
    var_3 = (1, 1, 1);
    switch (var_1) {
      case 0:
        var_3 = (1, 0, 0);
        break;

      case 1:
        var_3 = (1, 1, 0);
        break;

      case 2:
        var_3 = (0, 1, 0);
        break;

      case 3:
        var_3 = (0, 1, 1);
        break;
    }

    thread scripts\cp\utility::drawsphere(var_0.origin, 20, 10, var_3);
  }
}

func_EC31(var_0, var_1) {
  var_2 = func_EC1A(1, ::func_D830, var_0, var_1);
  var_0.var_5706 = var_2;
  var_0.totalscore = var_0.totalscore + var_2;
  var_2 = func_EC1A(5, ::avoidrugbyoffsides, var_0);
  var_0.var_DDCB = var_2;
  var_0.totalscore = var_0.totalscore + var_2;
}

func_D830(var_0, var_1) {
  if(!isDefined(var_0.volume)) {
    return 0;
  }

  var_2 = level.players[var_1];
  var_3 = 0;
  var_4 = 0.75;
  if(allowedstances(var_0.volume)) {
    var_3 = 1;
  } else if(isDefined(var_0.volume.var_186E)) {
    foreach(var_6 in var_0.volume.var_186E) {
      if(allowedstances(var_6)) {
        var_3 = 0.5;
        break;
      }
    }
  }

  if(var_3 == 0) {
    return 0;
  }

  var_8 = getdvarint("scr_spawn_score_distance", 0);
  if(var_8 != 0) {
    var_9 = var_8 * var_8;
  } else if(isDefined(level.spawn_score_distance)) {
    var_9 = level.spawn_score_distance * level.spawn_score_distance;
  } else {
    var_9 = 2250000;
  }

  if(distancesquared(var_2.origin, var_0.origin) < var_9) {
    return 100;
  }

  return 100 * var_4 * var_3;
}

avoidrugbyoffsides(var_0) {
  if(isDefined(var_0.lastspawntime)) {
    var_1 = gettime() - var_0.lastspawntime;
    if(var_1 > 15000) {
      return 100;
    }

    return var_1 / 15000 * 100;
  }

  return 100;
}

func_D82F(var_0) {
  if(!isDefined(var_0.volume)) {
    return 0;
  }

  var_1 = allowedstances(var_0.volume);
  if(var_1 == 0) {
    return 0;
  }

  return 100 * 1 - var_1 * 0.15;
}

func_EC1A(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = [[var_1]](var_2, var_3, var_4);
  } else if(isDefined(var_4)) {
    var_5 = [[var_2]](var_3, var_4);
  } else {
    var_5 = [[var_2]](var_3);
  }

  var_5 = clamp(var_5, 0, 100);
  var_5 = var_5 * var_0;
  return var_5;
}

allowedstances(var_0) {
  var_1 = 0;
  foreach(var_3 in level.players) {
    if(scripts\engine\utility::istrue(var_3.spectating)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.is_fast_traveling)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.inlaststand)) {
      continue;
    }

    if(var_3 istouching(var_0)) {
      var_1++;
    }
  }

  foreach(var_3 in level.fake_players) {
    if(scripts\engine\utility::istrue(var_3.spectating)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.is_fast_traveling)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.inlaststand)) {
      continue;
    }

    if(ispointinvolume(var_3.origin, var_0)) {
      var_1++;
    }
  }

  return var_1;
}

allowfire(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = 0;
  foreach(var_5 in level.players) {
    if(distancesquared(var_5.origin, var_0.origin) < var_2) {
      var_3++;
    }
  }

  return var_3;
}

func_4F1C(var_0, var_1) {
  level endon("debug_spawner_score_reset");
  var_2 = 0;
  var_3 = 100;
  var_4 = 200;
  var_5 = 300;
  var_6 = 400;
  var_7 = 500;
  var_8 = 600;
  if(var_0.totalscore <= 0) {
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (1, 0, 0));
    return;
  }

  if(var_0.totalscore <= var_3) {
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (1, 1, 0));
    return;
  }

  if(var_0.totalscore < var_7) {
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (0, 1, 0));
    return;
  }

  if(var_0.totalscore >= var_7 && var_0.totalscore < var_8) {
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (0, 1, 1));
    return;
  }

  if(var_0.totalscore >= var_8) {
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (1, 1, 1));
    return;
  }
}

func_4F1D() {
  while(!isDefined(level.active_spawners)) {
    wait(0.1);
  }

  scripts\engine\utility::flag_wait("spawn_point_score_data_init_done");
  for(;;) {
    if(getdvarint("scr_spawn_point_debug", 0) != 0) {
      foreach(var_1 in level.active_spawners) {
        func_98C8(var_1);
        func_EC31(var_1, level.var_4B9C);
        if(isDefined(var_1.totalscore)) {
          level thread func_4F1C(var_1, 0.1);
        }
      }
    }

    wait(0.1);
  }
}