/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_nuke.gsc
*************************************************/

_id_90E8(var_0) {
  var_1 = 0.2;
  var_2 = 0.6;
  var_3 = 0;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    level thread _id_0C49(var_0[var_4]);

    if(var_4 < var_0.size - 1) {
      var_5 = randomfloatrange(var_1, var_2);
      var_3 = var_3 + var_5;
      wait(var_5);
    }
  }

  level thread _id_0C5B(var_3);
}

_id_692D() {
  return getdvarfloat("#x383921694cb53afd6", 8.0);
}

_id_0C5B(var_0) {
  var_1 = _id_692D();
  var_2 = 2.0;
  var_3 = 10.0;
  var_4 = var_1 - var_0;
  wait(var_4);

  if(getdvarint("#x33894e200bb6b6b8b", 1) > 0) {
    for(var_5 = 0; var_5 < level.players.size; var_5++) {
      if(isDefined(level.players[var_5]) && !level.players[var_5] scripts\mp\gametypes\br_public::_id_8990()) {
        level.players[var_5] visionsetnakedforplayer("br_nuke_global_flash", 0.2);
      }
    }
  } else
    visionsetnaked("br_nuke_global_flash", 0.2);

  level._id_A734 = 1;
  wait(var_2 + var_0);

  if(getdvarint("#x33894e200bb6b6b8b", 1) > 0) {
    for(var_5 = 0; var_5 < level.players.size; var_5++) {
      if(isDefined(level.players[var_5]) && !level.players[var_5] scripts\mp\gametypes\br_public::_id_8990()) {
        level.players[var_5] visionsetnakedforplayer("br_nuke_global_aftermath", 2.0);
      }
    }
  } else
    visionsetnaked("br_nuke_global_aftermath", 2.0);

  level._id_A734 = 0;
  wait(var_3);
  visionsetnaked("", 3.0);
}

_id_0C49(var_0) {
  var_1 = "nuke_mp";
  var_2 = _id_692D();
  var_3 = "ks_nuke_br";
  var_4 = 100000;
  var_5 = 5.0;
  var_6 = scripts\mp\gametypes\br_circle::_id_69C5();
  var_7 = var_0 - var_6;
  var_7 = vectornormalize((var_7[0], var_7[1], 0));
  var_8 = var_0 + var_7 * 20000 + (0, 0, 30000);
  playsoundatpos(var_8, "iw8_nuke_dist_launch");
  var_9 = (0, 0, -1 * getdvarint("#x33c01342f08fa6256", 800));
  var_10 = (var_0 - 0.5 * var_9 * _func_0219(var_2) - var_8) / var_2;
  var_11 = magicgrenademanual(var_1, var_8, var_10, var_2);
  var_11 setscriptablepartstate("launch", "on", 0);
  wait(var_2);
  var_12 = var_11.origin;
  var_11 setscriptablepartstate("launch", "off", 0);
  var_11 delete();
  var_13 = spawn("script_model", var_12);
  var_13 setModel(var_3);
  var_14 = var_6 - var_12;
  var_14 = vectornormalize((var_14[0], var_14[1], 0));
  var_13.angles = vectortoangles(var_14);
  var_13 setscriptablepartstate("explode", "on", 0);
  var_13 thread scripts\mp\utility\script::_id_46C7(50);
  playsoundatpos(var_12, "iw8_nuke_impact_low");
  playsoundatpos(var_12, "iw8_nuke_incoming_blast_wave");
  playsoundatpos(var_12, "iw8_nuke_blast");
  playsoundatpos(var_12, "iw8_nuke_blast_tail");
  earthquake(0.4, var_5, var_12, var_4);
  wait(var_5);
  earthquake(0.3, 1, var_12, var_4);
}