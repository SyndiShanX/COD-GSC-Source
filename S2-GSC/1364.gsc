/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1364.gsc
*********************************************/

lib_0554::func_00D5() {
  level.var_AB3A = [];
  var_00 = 3;
  for(var_01 = 0; var_01 < var_00; var_01++) {
    level.var_AB3A[var_01] = spawn("script_model", (0, 0, 0));
    level.var_AB3A[var_01] method_861B(0);
    level.var_AB3A[var_01].var_00D4 = var_01;
  }

  level.var_AB01 = [];
  level thread lib_0554::func_8A31(0, "round_start", "zmb_mus_roundcount", 0, 0, 0.5, 0);
  level thread lib_0554::func_8A31(1, "round_normal", ["zmb_mus_wave_01_lp", "zmb_mus_wave_02_lp", "zmb_mus_wave_03_lp"], 0, 1, 1, 1);
  level thread lib_0554::func_8A31(1, "round_zombie_dog", ["zmb_mus_spec_01_lp", "zmb_mus_spec_02_lp", "zmb_mus_spec_03_lp"], 0, 1, 1, 1);
  level thread lib_0554::func_8A31(1, "round_zombie_host", ["zmb_mus_spec_01_lp", "zmb_mus_spec_02_lp", "zmb_mus_spec_03_lp"], 0, 1, 1, 1);
  level thread lib_0554::func_8A31(0, "round_end", "zmb_mus_roundfinish", 0, 0, 0.5, 0);
  level thread lib_0554::func_8A31(2, "round_intermission", "zmb_mus_postround", 0, 1, 1, 0);
  level thread lib_0554::func_8A31(0, "game_over", "zmb_mus_sweeper", 0, 0, 0, 0);
  level thread lib_0554::func_8A31(-1, "player_died", "zmb_mus_deathsting", 1, 0, 0, 0);
  if(isDefined(level.var_2987)) {
    level thread[[level.var_2987]]();
  }
}

lib_0554::func_8A31(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(param_03) {
    param_00 = undefined;
  }

  if(!isDefined(level.var_AB01[param_01])) {
    level.var_AB01[param_01] = spawnStruct();
  }

  if(isarray(param_02)) {
    level.var_AB01[param_01].var_0BB4 = param_02[0];
    level.var_AB01[param_01].var_0BB5 = param_02;
  } else {
    level.var_AB01[param_01].var_0BB4 = param_02;
  }

  level.var_AB01[param_01].var_37AB = param_00;
  level.var_AB01[param_01].var_55B3 = param_04;
  level.var_AB01[param_01].var_6AAA = param_03;
  level.var_AB01[param_01].var_92AE = param_05;
  level.var_AB01[param_01].var_93F3 = param_06;
}

lib_0554::func_20CB(param_00, param_01) {
  var_02 = level.var_AB01[param_00];
  if(!isDefined(var_02)) {
    return;
  }

  if(isDefined(level.var_6A40)) {
    if(level.var_6A40 == var_02) {
      return;
    } else if(level.var_6A40 == level.var_AB01["game_over"]) {
      return;
    }
  }

  thread lib_0554::func_06A0(var_02, param_01);
  level.var_6A40 = var_02;
}

lib_0554::func_06A0(param_00, param_01) {
  if(1) {
    return;
  }

  if(isDefined(param_00.var_92AE) && param_00.var_92AE > 0) {
    wait(param_00.var_92AE);
  }

  if(param_00 == level.var_AB01["round_intermission"]) {
    var_02 = level.var_AB3A[param_00.var_37AB];
    var_02 method_861D(param_00.var_0BB4);
    var_02 method_861B(1, 0.5);
    wait(10);
    var_02 method_861B(0, 5);
    wait(5);
    var_02 stoploopsound();
    return;
  }

  if(param_00.var_55B3) {
    var_02 = level.var_AB3A[param_00.var_37AB];
    var_03 = param_00.var_0BB4;
    if(isDefined(param_00.var_0BB5)) {
      if(!isDefined(param_00.var_5B11)) {
        param_00.var_5B11 = randomint(param_00.var_0BB5.size);
      } else {
        param_00.var_5B11 = param_00.var_5B11 + 1 % param_00.var_0BB5.size;
      }

      var_03 = param_00.var_0BB5[param_00.var_5B11];
      param_00.var_0BB4 = var_03;
    }

    var_02 method_861D(var_03);
    var_02 method_861B(1);
    thread lib_0554::func_0726(var_02, param_00);
    if(level.var_7F2A == "normal") {
      thread lib_0554::func_0727(var_02, param_00);
      return;
    }

    return;
  }

  if(var_02.var_6AAA) {
    var_03 method_860F(var_02.var_0BB4, var_03);
    return;
  }

  var_02 = level.var_AB3A[var_02.var_37AB];
  var_03 playsoundonmovingent(param_01.var_0BB4);
  var_03 method_861B(1);
}

lib_0554::func_0726(param_00, param_01) {
  level endon("zombie_stopOnTimeElapsed");
  level waittill("zombie_wave_ended");
  if(isDefined(param_01.var_93F3) && param_01.var_93F3 > 0) {
    wait(param_01.var_93F3);
  }

  param_00 method_861B(0, 2);
  wait(2);
  param_00 stoploopsound();
  param_00 method_861B(1);
}

lib_0554::func_0727(param_00, param_01) {
  level endon("zombie_wave_ended");
  wait(20);
  param_00 method_861B(0, 20);
  wait(20);
  param_00 stoploopsound();
  param_00 method_861B(1);
  level notify("zombie_stopOnTimeElapsed");
}