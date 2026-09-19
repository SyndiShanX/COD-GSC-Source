/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1364.gsc
**************************************/

init() {
  level._id_AB3A = [];
  var_0 = 3;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level._id_AB3A[var_1] = spawn("script_model", (0, 0, 0));
    level._id_AB3A[var_1] _meth_861B(0);
    level._id_AB3A[var_1]._id_00D4 = var_1;
  }

  level._id_AB01 = [];
  level thread _id_8A31(0, "round_start", "zmb_mus_roundcount", 0, 0, 0.5, 0);
  level thread _id_8A31(1, "round_normal", ["zmb_mus_wave_01_lp", "zmb_mus_wave_02_lp", "zmb_mus_wave_03_lp"], 0, 1, 1, 1);
  level thread _id_8A31(1, "round_zombie_dog", ["zmb_mus_spec_01_lp", "zmb_mus_spec_02_lp", "zmb_mus_spec_03_lp"], 0, 1, 1, 1);
  level thread _id_8A31(1, "round_zombie_host", ["zmb_mus_spec_01_lp", "zmb_mus_spec_02_lp", "zmb_mus_spec_03_lp"], 0, 1, 1, 1);
  level thread _id_8A31(0, "round_end", "zmb_mus_roundfinish", 0, 0, 0.5, 0);
  level thread _id_8A31(2, "round_intermission", "zmb_mus_postround", 0, 1, 1, 0);
  level thread _id_8A31(0, "game_over", "zmb_mus_sweeper", 0, 0, 0, 0);
  level thread _id_8A31(-1, "player_died", "zmb_mus_deathsting", 1, 0, 0, 0);

  if(isDefined(level._id_2987))
    level thread[[level._id_2987]]();
}

_id_8A31(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_3)
    var_0 = undefined;

  if(!isDefined(level._id_AB01[var_1]))
    level._id_AB01[var_1] = spawnStruct();

  if(_func_0C0(var_2)) {
    level._id_AB01[var_1]._id_0BB4 = var_2[0];
    level._id_AB01[var_1]._id_0BB5 = var_2;
  } else
    level._id_AB01[var_1]._id_0BB4 = var_2;

  level._id_AB01[var_1]._id_37AB = var_0;
  level._id_AB01[var_1]._id_55B3 = var_4;
  level._id_AB01[var_1]._id_6AAA = var_3;
  level._id_AB01[var_1]._id_92AE = var_5;
  level._id_AB01[var_1]._id_93F3 = var_6;
}

_id_20CB(var_0, var_1) {
  var_2 = level._id_AB01[var_0];

  if(!isDefined(var_2)) {
    return;
  }
  if(isDefined(level._id_6A40)) {
    if(level._id_6A40 == var_2)
      return;
    else if(level._id_6A40 == level._id_AB01["game_over"])
      return;
  }

  thread _id_06A0(var_2, var_1);
  level._id_6A40 = var_2;
}

_id_06A0(var_0, var_1) {
  if(1) {
    return;
  }
  if(isDefined(var_0._id_92AE) && var_0._id_92AE > 0)
    wait(var_0._id_92AE);

  if(var_0 == level._id_AB01["round_intermission"]) {
    var_2 = level._id_AB3A[var_0._id_37AB];
    var_2 _meth_861D(var_0._id_0BB4);
    var_2 _meth_861B(1, 0.5);
    wait 10;
    var_2 _meth_861B(0, 5);
    wait 5;
    var_2 _meth_8612();
  } else if(var_0._id_55B3) {
    var_2 = level._id_AB3A[var_0._id_37AB];
    var_3 = var_0._id_0BB4;

    if(isDefined(var_0._id_0BB5)) {
      if(!isDefined(var_0._id_5B11))
        var_0._id_5B11 = randomint(var_0._id_0BB5.size);
      else
        var_0._id_5B11 = (var_0._id_5B11 + 1) % var_0._id_0BB5.size;

      var_3 = var_0._id_0BB5[var_0._id_5B11];
      var_0._id_0BB4 = var_3;
    }

    var_2 _meth_861D(var_3);
    var_2 _meth_861B(1);
    thread _id_0726(var_2, var_0);

    if(level._id_7F2A == "normal") {
      thread _id_0727(var_2, var_0);
      return;
    }
  } else if(var_0._id_6AAA)
    var_1 _meth_860F(var_0._id_0BB4, var_1);
  else {
    var_2 = level._id_AB3A[var_0._id_37AB];
    var_2 _meth_861F(var_0._id_0BB4);
    var_2 _meth_861B(1);
  }
}

_id_0726(var_0, var_1) {
  level endon("zombie_stopOnTimeElapsed");
  level waittill("zombie_wave_ended");

  if(isDefined(var_1._id_93F3) && var_1._id_93F3 > 0)
    wait(var_1._id_93F3);

  var_0 _meth_861B(0, 2);
  wait 2;
  var_0 _meth_8612();
  var_0 _meth_861B(1);
}

_id_0727(var_0, var_1) {
  level endon("zombie_wave_ended");
  wait 20;
  var_0 _meth_861B(0, 20);
  wait 20;
  var_0 _meth_8612();
  var_0 _meth_861B(1);
  level notify("zombie_stopOnTimeElapsed");
}