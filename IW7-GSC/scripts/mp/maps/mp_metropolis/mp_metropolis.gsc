/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_metropolis\mp_metropolis.gsc
***********************************************************/

main() {
  scripts\mp\maps\mp_metropolis\mp_metropolis_precache::main();
  scripts\mp\maps\mp_metropolis\gen\mp_metropolis_art::main();
  scripts\mp\maps\mp_metropolis\mp_metropolis_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_metropolis");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 5);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_sdfShadowPenumbra", 0.2);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread _id_CDA4("mp_metropolis_news_v2");
  thread scripts\mp\animation_suite::animationsuite();
  thread trainanims();
  thread fix_collision();
  thread move_hardpoint_startspawns();
  thread move_ball_startspawns();
  thread spawn_ball_allowed_trigger();
  thread spawn_oob_trigger();
  thread runmodespecifictriggers();
}

fix_collision() {
  var_0 = getEnt("clip128x128x8", "targetname");
  var_1 = spawn("script_model", (535.5, -727, 72));
  var_1.angles = (90, 37.2594, -7.74062);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("player256x256x8", "targetname");
  var_3 = spawn("script_model", (-2046, -236, 402));
  var_3.angles = (89.2967, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = spawn("script_model", (-973.5, 1159.5, 119));
  var_4.angles = (0, 40, 90);
  var_4 setModel("fixture_exposed_air_vent_cover_mp_metropolis_patch");
  var_5 = spawn("script_model", (-960, 1171, 119));
  var_5.angles = (0, 40, 90);
  var_5 setModel("fixture_exposed_air_vent_cover_mp_metropolis_patch");
  var_6 = spawn("script_model", (0, 0, 0));
  var_6.angles = (0, 0, 0);
  var_6 setModel("mp_metropolis_nosight_all_01");
  var_7 = spawn("script_model", (0, 0, 0));
  var_7.angles = (0, 0, 0);
  var_7 setModel("mp_metropolis_player_concrete_all");
  var_8 = getEnt("clip128x128x128", "targetname");
  var_9 = spawn("script_model", (-2192, 452, 184));
  var_9.angles = (0, 0, -14.0003);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("player32x32x128", "targetname");
  var_11 = spawn("script_model", (-2600, -680, 344));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("clip128x128x8", "targetname");
  var_13 = spawn("script_model", (-52, 2032, 64));
  var_13.angles = (0, 0, -99.4002);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("player64x64x256", "targetname");
  var_15 = spawn("script_model", (-176, -1716, 372));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("player256x256x8", "targetname");
  var_17 = spawn("script_model", (443, 528, 19));
  var_17.angles = (30, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("player32x32x8", "targetname");
  var_19 = spawn("script_model", (-928, -1881, 202));
  var_19.angles = (330, 0, -90);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = getEnt("clip256x256x8", "targetname");
  var_21 = spawn("script_model", (-712, 706, 32));
  var_21.angles = (0, 0, 90);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getEnt("player512x512x8", "targetname");
  var_23 = spawn("script_model", (-1320, -592, 552));
  var_23.angles = (270, 0, 0);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getEnt("player32x32x8", "targetname");
  var_25 = spawn("script_model", (-2596, -240, 318));
  var_25.angles = (75, 0, 0);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = spawn("script_model", (784, -112, 108));
  var_26.angles = (180, 0, 0);
  var_26 setModel("mp_desert_uplink_col_01");
  var_27 = spawn("script_model", (1092, 20, 68));
  var_27.angles = (0, 90, 0);
  var_27 setModel("mp_desert_uplink_col_01");
  var_28 = getEnt("clip32x32x256", "targetname");
  var_29 = spawn("script_model", (-146, -472, 252));
  var_29.angles = (0, 0, -3.00007);
  var_29 clonebrushmodeltoscriptmodel(var_28);
  var_30 = getEnt("clip32x32x256", "targetname");
  var_31 = spawn("script_model", (300, 44, 256));
  var_31.angles = (0, 0, 4.99991);
  var_31 clonebrushmodeltoscriptmodel(var_30);
  var_32 = spawn("script_model", (-920, 432, 200));
  var_32.angles = (0, 0, 0);
  var_32 setModel("mp_metropolis_missile_clip_1");
  var_33 = getEnt("clip256x256x8", "targetname");
  var_34 = spawn("script_model", (-3248, 488, 96));
  var_34.angles = (0, 345, 90);
  var_34 clonebrushmodeltoscriptmodel(var_33);
  var_35 = getEnt("clip256x256x8", "targetname");
  var_36 = spawn("script_model", (-3248, 488, 352));
  var_36.angles = (0, 345, 90);
  var_36 clonebrushmodeltoscriptmodel(var_35);
}

_id_CDA4(var_0) {
  wait 30;
  playcinematicforalllooping(var_0);
}

trainanims() {
  precachemodel("veh_civ_train_fn_01");
  wait 3;
  var_0 = getEntArray("train", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("veh_civ_train_fn_01");
    var_3 show();
    var_3 linkTo(var_2);
    var_2 thread animatetraincar();

    if(var_2.targetname == "train01" || var_2.targetname == "train03" || var_2.targetname == "train05") {
      var_2 thread animatetraincaraudio();
    }
  }
}

animatetraincar() {
  level endon("game_ended");
  var_0 = self.origin;

  for(;;) {
    wait 5;
    self movey(11000, 20, 10, 0);
    wait 20;
    self movez(-1000, 0.1);
    wait 1;
    self hide();
    wait 1;
    self movey(-28000, 0.1);
    wait 1;
    self show();
    self movez(1000, 0.1);
    wait 1;
    self moveTo(var_0 + (0, randomintrange(-50, 50), 0), 20, 0, 6);
    wait 20;
  }
}

animatetraincaraudio() {
  level endon("game_ended");
  var_0 = self.origin;

  for(;;) {
    wait 5;
    self movey(11000, 20, 10, 0);
    self playSound("mp_met_train_start");
    wait 0.5;
    self stoploopsound("");
    wait 0.5;
    self playLoopSound("mp_met_train_move_lp");
    wait 19;
    self stoploopsound("");
    self movez(-1000, 0.1);
    wait 1;
    self hide();
    wait 1;
    self movey(-28000, 0.1);
    wait 1;
    self show();
    self movez(1000, 0.1);
    wait 1;
    self moveTo(var_0 + (0, randomintrange(-50, 50), 0), 20, 0, 6);
    wait 2;
    self playLoopSound("mp_met_train_move_lp");
    wait 16;
    self playsoundonmovingent("mp_met_train_stop");
    wait 0.5;
    self stoploopsound("");
    wait 0.5;
    self playLoopSound("mp_met_train_idle_lp");
    wait 1;
  }
}

traininit() {
  var_0 = getEntArray("train", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 setModel("veh_civ_train_fn_01");
  }

  return var_0;
}

move_hardpoint_startspawns() {
  if(level.gametype == "koth" || level.gametype == "grnd") {
    wait 1;
    var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_allies_start");
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_koth_spawn_axis_start");

    foreach(var_3 in var_0) {
      if(distance(var_3.origin, (-584, -2112, 0.121567)) < 10) {
        var_3.origin = (-1728, -1552, -72);
        var_3.angles = (0, 30, 0);
      }

      if(distance(var_3.origin, (-448, -2112, 0.121567)) < 10) {
        var_3.origin = (-1664, -1584, -72);
        var_3.angles = (0, 45, 0);
      }

      if(distance(var_3.origin, (-376, -2120, 0.121567)) < 10) {
        var_3.origin = (-1696, -1648, -72);
        var_3.angles = (0, 45, 0);
      }

      if(distance(var_3.origin, (-584, -2040, 0.121567)) < 10) {
        var_3.origin = (-1632, -1680, -72);
        var_3.angles = (0, 90, 0);
      }

      if(distance(var_3.origin, (-520, -2040, 0.121567)) < 10) {
        var_3.origin = (-1600, -1616, -64);
        var_3.angles = (0, 90, 0);
      }

      if(distance(var_3.origin, (-480, -1912, 0.121567)) < 10) {
        var_3.origin = (-1536, -1648, -64);
        var_3.angles = (0, 90, 0);
      }

      if(distance(var_3.origin, (-448, -2040, 0.121567)) < 10) {
        var_3.origin = (-1568, -1712, -64);
        var_3.angles = (0, 90, 0);
      }

      if(distance(var_3.origin, (-552, -1976, 0.121567)) < 10) {
        var_3.origin = (-1504, -1744, -64);
        var_3.angles = (0, 120, 0);
      }

      if(distance(var_3.origin, (-416, -1976, 0.121567)) < 10) {
        var_3.origin = (-1472, -1680, -64);
        var_3.angles = (0, 120, 0);
      }

      if(distance(var_3.origin, (-488, -1976, 0.121567)) < 10) {
        var_3.origin = (-1435, -1620, -64);
        var_3.angles = (0, 120, 0);
      }

      if(distance(var_3.origin, (-520, -2112, 0.121567)) < 10) {
        var_3.origin = (-1500, -1590, -64);
        var_3.angles = (0, 120, 0);
      }

      if(distance(var_3.origin, (-376, -2048, 0.121567)) < 10) {
        var_3.origin = (-1570, -1556, -64);
        var_3.angles = (0, 120, 0);
      }
    }

    foreach(var_3 in var_1) {
      if(distance(var_3.origin, (-1692, 2116, -15.8765)) < 10) {
        var_3.origin = (928, 1056, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1658, 2180, -15.8765)) < 10) {
        var_3.origin = (928, 1120, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1704, 2052, -15.8765)) < 10) {
        var_3.origin = (928, 1184, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1742, 2188, -15.8765)) < 10) {
        var_3.origin = (992, 1056, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1890, 2188, -15.8765)) < 10) {
        var_3.origin = (992, 1120, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1810, 2188, -15.8765)) < 10) {
        var_3.origin = (992, 1184, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1788, 2120, -15.8765)) < 10) {
        var_3.origin = (1056, 1056, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1888, 2124, -15.8765)) < 10) {
        var_3.origin = (1056, 1120, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1784, 2052, -15.8765)) < 10) {
        var_3.origin = (1056, 1184, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1884, 2052, -15.8765)) < 10) {
        var_3.origin = (870, 1184, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1872, 1980, -15.8765)) < 10) {
        var_3.origin = (870, 1120, 48);
        var_3.angles = (0, 180, 0);
      }

      if(distance(var_3.origin, (-1760, 1964, -15.8765)) < 10) {
        var_3.origin = (870, 1056, 48);
        var_3.angles = (0, 180, 0);
      }
    }

    filterstartspawns();
  }
}

move_ball_startspawns() {
  if(level.gametype == "ball") {
    wait 1;
    var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_ball_spawn_axis_start");

    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (-2418.9, -457.3, -73.8721)) < 10) {
        var_2.origin = (-2528, -1072, 68);
        var_2.angles = (0, 60, 0);
      }

      if(distance(var_2.origin, (-2470.6, -542.3, -73.8721)) < 10) {
        var_2.origin = (-2528, -992, 64);
        var_2.angles = (0, 60, 0);
      }

      if(distance(var_2.origin, (-2405, -553.4, -73.8721)) < 10) {
        var_2.origin = (-2528, -912, 64);
        var_2.angles = (0, 60, 0);
      }

      if(distance(var_2.origin, (-2542.8, -601.9, -73.8721)) < 10) {
        var_2.origin = (-2448, -1024, 64);
        var_2.angles = (0, 60, 0);
      }

      if(distance(var_2.origin, (-2470.6, -462.3, -73.8721)) < 10) {
        var_2.origin = (-2448, -944, 64);
        var_2.angles = (0, 60, 0);
      }

      if(distance(var_2.origin, (-2547.8, -519.9, -73.8721)) < 10) {
        var_2.origin = (-2128, -1520, 64);
        var_2.angles = (0, 0, 0);
      }

      if(distance(var_2.origin, (-2549.1, -439.9, -73.8721)) < 10) {
        var_2.origin = (-2128, -1456, 64);
        var_2.angles = (0, 0, 0);
      }

      if(distance(var_2.origin, (-2474.9, -388.4, -71.8755)) < 10) {
        var_2.origin = (-2128, -1392, 64);
        var_2.angles = (0, 0, 0);
      }

      if(distance(var_2.origin, (-2477, -607.4, -73.8721)) < 10) {
        var_2.origin = (-2048, -1424, 64);
        var_2.angles = (0, 0, 0);
      }

      if(distance(var_2.origin, (-2545, -358.4, -71.8755)) < 10) {
        var_2.origin = (-2048, -1488, 64);
        var_2.angles = (0, 0, 0);
      }
    }

    filterstartspawns();
  }
}

filterstartspawns() {
  var_0 = level._id_10DF1;
  level._id_10DF1 = [];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] scripts\mp\spawnlogic::_id_108FA();
    var_0[var_1].selected = 0;
    var_0[var_1].infront = 0;
    level._id_10DF1[level._id_10DF1.size] = var_0[var_1];
  }

  if(level.teambased) {
    foreach(var_3 in var_0) {
      var_3.infront = 1;
      var_4 = anglesToForward(var_3.angles);

      foreach(var_6 in var_0) {
        if(var_3 == var_6) {
          continue;
        }
        var_7 = vectorNormalize(var_6.origin - var_3.origin);
        var_8 = vectordot(var_4, var_7);

        if(var_8 > 0.86) {
          var_3.infront = 0;
          break;
        }
      }
    }
  }
}

spawn_ball_allowed_trigger() {
  wait 1;
  var_0 = spawn("trigger_radius", (-990, 427, 550), 0, 4000, 400);
  var_1 = spawn("trigger_radius", (-2201, -746, 370), 0, 200, 500);
  var_2 = spawn("trigger_radius", (-2352, -1417, 290), 0, 250, 500);
  var_3 = spawn("trigger_radius", (-1882, -1342, 370), 0, 200, 500);
  var_4 = spawn("trigger_radius", (-1898, -859, 370), 0, 200, 500);
  var_5 = spawn("trigger_radius", (-1894, -1082, 521), 0, 200, 500);
  var_6 = spawn("trigger_radius", (-1155, 1846, 260), 0, 380, 400);
  var_7 = spawn("trigger_radius", (30, -1250, 150), 0, 140, 400);
  var_8 = spawn("trigger_radius", (-140, -1450, 250), 0, 300, 400);
  var_9 = spawn("trigger_radius", (-1947, 16, 254), 0, 150, 400);
  var_10 = spawn("trigger_radius", (-2351, 200, 364), 0, 700, 400);
  level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_0;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_1;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_2;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_3;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_4;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_5;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_6;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_7;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_8;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_9;
  level.ballallowedtriggers[level.ballallowedtriggers.size] = var_10;
}

spawn_oob_trigger() {
  wait 1;
  var_0 = spawn("trigger_radius", (400, 1235, 160), 0, 35, 20);
  var_1 = spawn("trigger_radius", (400, 1210, 55), 0, 40, 20);
  var_2 = spawn("trigger_radius", (-2310, -175, -60), 0, 30, 10);
  var_3 = spawn("trigger_radius", (-2310, -227, -60), 0, 30, 10);
  var_0 hide();
  var_1 hide();
  var_2 hide();
  var_3 hide();
  level._id_C7B3[level._id_C7B3.size] = var_0;
  level._id_C7B3[level._id_C7B3.size] = var_1;
  level._id_C7B3[level._id_C7B3.size] = var_2;
  level._id_C7B3[level._id_C7B3.size] = var_3;
}

runmodespecifictriggers() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    wait 1;
    var_0 = spawn("trigger_radius", (-2600, -70, -70), 0, 70, 50);
    var_0.targetname = "uplink_nozone";
    var_0 hide();
    var_1 = spawn("trigger_radius", (-2580, -60, -20), 0, 50, 40);
    var_1.targetname = "uplink_nozone";
    var_1 hide();
    var_2 = spawn("trigger_radius", (-2580, -155, -70), 0, 40, 40);
    var_2.targetname = "uplink_nozone";
    var_2 hide();
    var_3 = spawn("trigger_radius", (367, 1360, 700), 0, 130, 10);
    var_3.targetname = "uplink_nozone";
    var_3 hide();
    var_4 = spawn("trigger_radius", (54, 1340, 700), 0, 150, 10);
    var_4.targetname = "uplink_nozone";
    var_4 hide();
    var_5 = spawn("trigger_radius", (-1015, 94, 720), 0, 140, 10);
    var_5.targetname = "uplink_nozone";
    var_5 hide();
    var_6 = spawn("trigger_radius", (-760, -320, 720), 0, 500, 10);
    var_6.targetname = "uplink_nozone";
    var_6 hide();
    var_7 = spawn("trigger_radius", (-1425, -427, 315), 0, 150, 5);
    var_7.targetname = "uplink_nozone";
    var_7 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_0;
    level.nozonetriggers[level.nozonetriggers.size] = var_1;
    level.nozonetriggers[level.nozonetriggers.size] = var_2;
    level.nozonetriggers[level.nozonetriggers.size] = var_3;
    level.nozonetriggers[level.nozonetriggers.size] = var_4;
    level.nozonetriggers[level.nozonetriggers.size] = var_5;
    level.nozonetriggers[level.nozonetriggers.size] = var_6;
    level.nozonetriggers[level.nozonetriggers.size] = var_7;
  }
}