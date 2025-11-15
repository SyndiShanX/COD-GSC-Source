/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3424.gsc
************************/

func_13F54() {
  scripts\engine\utility::flag_init("spawn_point_score_data_init_done");
  level.zombies_spawn_score_func = ::func_7C8A;
  level.fake_players = [];
}

func_7C8A(param_00) {
  if(isDefined(param_00)) {
    return radiusdamage(param_00);
  }

  return radiusdamage(level.active_spawners);
}

func_13F59(param_00) {
  if(!scripts\cp\zombies\func_0D5F::critical_factor(::scripts\cp\zombies\func_0D5F::func_26B8, param_00)) {
    return "secondary";
  }

  if(!scripts\cp\zombies\func_0D5F::critical_factor(::scripts\cp\zombies\func_0D5F::func_26BC, param_00)) {
    return "secondary";
  }

  if(!scripts\cp\zombies\func_0D5F::critical_factor(::scripts\cp\zombies\func_0D5F::func_26C4, param_00)) {
    return "secondary";
  }

  return "primary";
}

func_98C8(param_00) {
  param_00.totalscore = 0;
  param_00.var_11A3A = 0;
  param_00.var_C217 = 0;
  param_00.budgetedents = 0;
  param_00.var_A9E9 = [];
  param_00.var_A9E9["allies"] = 0;
  param_00.var_A9E9["axis"] = 0;
}

isinvalidzone(param_00) {
  if(isDefined(param_00.volume) && param_00.volume.var_19) {
    return 1;
  }

  return 0;
}

radiusdamage(param_00) {
  if(!isDefined(level.var_4B9C)) {
    level.var_4B9C = 0;
  } else {
    level.var_4B9C = func_790C(level.var_4B9C);
  }

  var_01 = level.var_4B9C;
  var_02 = [];
  foreach(var_04 in param_00) {
    func_98C8(var_04);
    if(func_13F59(var_04) == "primary") {
      var_02[var_02.size] = var_04;
    }
  }

  if(var_02.size) {
    var_06 = func_EC47(var_02, var_01);
  } else {
    var_06 = scripts\engine\utility::random(var_01);
  }

  scripts\engine\utility::flag_set("spawn_point_score_data_init_done");
  return var_06;
}

func_790C(param_00) {
  var_01 = level.players.size;
  if(var_01 == 1) {
    return 0;
  }

  var_02 = 0;
  var_03 = func_7B17(param_00);
  while(!var_02) {
    if(var_03 == param_00) {
      break;
    }

    var_04 = level.players[var_03];
    if(!scripts\engine\utility::istrue(var_04.spectating) && !scripts\engine\utility::istrue(var_04.is_fast_traveling) && !scripts\engine\utility::istrue(var_04.inlaststand)) {
      var_02 = 1;
    }

    if(!var_02) {
      var_03 = func_7B17(var_03);
    }
  }

  return var_03;
}

func_7B17(param_00) {
  var_01 = param_00 + 1;
  if(isDefined(level.players[var_01])) {
    return var_01;
  }

  var_01++;
  for(var_02 = 0; var_02 < level.players.size; var_02++) {
    if(isDefined(level.players[var_01])) {
      return var_01;
    }

    if(var_01 >= level.players.size) {
      var_01 = 0;
      continue;
    }

    var_01++;
  }

  return 0;
}

func_EC47(param_00, param_01) {
  var_02 = param_00[0];
  param_00 = scripts\engine\utility::array_randomize(param_00);
  level notify("debug_spawner_score_reset");
  foreach(var_04 in param_00) {
    func_EC31(var_04, param_01);
    if(!isDefined(var_02) || var_04.totalscore > var_02.totalscore) {
      var_02 = var_04;
    }
  }

  return var_02;
}

func_913F(param_00, param_01, param_02) {
  if(param_02) {
    var_03 = (1, 1, 1);
    switch (param_01) {
      case 0:
        var_03 = (1, 0, 0);
        break;

      case 1:
        var_03 = (1, 1, 0);
        break;

      case 2:
        var_03 = (0, 1, 0);
        break;

      case 3:
        var_03 = (0, 1, 1);
        break;
    }

    thread scripts\cp\utility::drawsphere(param_00.origin, 20, 10, var_03);
  }
}

func_EC31(param_00, param_01) {
  var_02 = func_EC1A(1, ::func_D830, param_00, param_01);
  param_00.var_5706 = var_02;
  param_00.totalscore = param_00.totalscore + var_02;
  var_02 = func_EC1A(5, ::avoidrugbyoffsides, param_00);
  param_00.var_DDCB = var_02;
  param_00.totalscore = param_00.totalscore + var_02;
}

func_D830(param_00, param_01) {
  if(!isDefined(param_00.volume)) {
    return 0;
  }

  var_02 = level.players[param_01];
  var_03 = 0;
  var_04 = 0.75;
  if(allowedstances(param_00.volume)) {
    var_03 = 1;
  } else if(isDefined(param_00.volume.var_186E)) {
    foreach(var_06 in param_00.volume.var_186E) {
      if(allowedstances(var_06)) {
        var_03 = 0.5;
        break;
      }
    }
  }

  if(var_03 == 0) {
    return 0;
  }

  var_08 = getdvarint("scr_spawn_score_distance", 0);
  if(var_08 != 0) {
    var_09 = var_08 * var_08;
  } else if(isDefined(level.spawn_score_distance)) {
    var_09 = level.spawn_score_distance * level.spawn_score_distance;
  } else {
    var_09 = 2250000;
  }

  if(distancesquared(var_02.origin, param_00.origin) < var_09) {
    return 100;
  }

  return 100 * var_04 * var_03;
}

avoidrugbyoffsides(param_00) {
  if(isDefined(param_00.lastspawntime)) {
    var_01 = gettime() - param_00.lastspawntime;
    if(var_01 > 15000) {
      return 100;
    }

    return var_01 / 15000 * 100;
  }

  return 100;
}

func_D82F(param_00) {
  if(!isDefined(param_00.volume)) {
    return 0;
  }

  var_01 = allowedstances(param_00.volume);
  if(var_01 == 0) {
    return 0;
  }

  return 100 * 1 - var_01 * 0.15;
}

func_EC1A(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_04)) {
    var_05 = [[param_01]](param_02, param_03, param_04);
  } else if(isDefined(param_04)) {
    var_05 = [[param_02]](param_03, param_04);
  } else {
    var_05 = [[param_02]](param_03);
  }

  var_05 = clamp(var_05, 0, 100);
  var_05 = var_05 * param_00;
  return var_05;
}

allowedstances(param_00) {
  var_01 = 0;
  foreach(var_03 in level.players) {
    if(scripts\engine\utility::istrue(var_03.spectating)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.is_fast_traveling)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.inlaststand)) {
      continue;
    }

    if(var_03 istouching(param_00)) {
      var_01++;
    }
  }

  foreach(var_03 in level.fake_players) {
    if(scripts\engine\utility::istrue(var_03.spectating)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.is_fast_traveling)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_03.inlaststand)) {
      continue;
    }

    if(ispointinvolume(var_03.origin, param_00)) {
      var_01++;
    }
  }

  return var_01;
}

allowfire(param_00, param_01) {
  var_02 = param_01 * param_01;
  var_03 = 0;
  foreach(var_05 in level.players) {
    if(distancesquared(var_05.origin, param_00.origin) < var_02) {
      var_03++;
    }
  }

  return var_03;
}

func_4F1C(param_00, param_01) {
  level endon("debug_spawner_score_reset");
  var_02 = 0;
  var_03 = 100;
  var_04 = 200;
  var_05 = 300;
  var_06 = 400;
  var_07 = 500;
  var_08 = 600;
  if(param_00.totalscore <= 0) {
    scripts\cp\utility::drawsphere(param_00.origin, 20, param_01, (1, 0, 0));
    return;
  }

  if(param_00.totalscore <= var_03) {
    scripts\cp\utility::drawsphere(param_00.origin, 20, param_01, (1, 1, 0));
    return;
  }

  if(param_00.totalscore < var_07) {
    scripts\cp\utility::drawsphere(param_00.origin, 20, param_01, (0, 1, 0));
    return;
  }

  if(param_00.totalscore >= var_07 && param_00.totalscore < var_08) {
    scripts\cp\utility::drawsphere(param_00.origin, 20, param_01, (0, 1, 1));
    return;
  }

  if(param_00.totalscore >= var_08) {
    scripts\cp\utility::drawsphere(param_00.origin, 20, param_01, (1, 1, 1));
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
      foreach(var_01 in level.active_spawners) {
        func_98C8(var_01);
        func_EC31(var_01, level.var_4B9C);
        if(isDefined(var_01.totalscore)) {
          level thread func_4F1C(var_01, 0.1);
        }
      }
    }

    wait(0.1);
  }
}