/******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_frontend9\mp_frontend9_lighting.gsc
******************************************************************/

main() {
  waitframe();
  scripts\engine\utility::_id_5C11("flare_on");
  scripts\engine\utility::_id_5C11("flare_flicker");
  scripts\engine\utility::_id_5C11("flare_on_op");
  level.frontend_lighting_operator_close = ::operator_close;
  level.frontend_lighting_operator_far = ::operator_far;
}

operator_close() {
  setDvar("#x368bdfdbc24f123de", 0);
  setDvar("#x3315497e1370274af", 8);
  setDvar("#x3c0aa0a6ec3acae1a", 4);
  setDvar("#x34ffe3d8b0515fe9d", 2.25);
}

operator_far() {
  setDvar("#x368bdfdbc24f123de", 0);
  setDvar("#x3315497e1370274af", 32);
  setDvar("#x3c0aa0a6ec3acae1a", 3);
  setDvar("#x34ffe3d8b0515fe9d", 6);
  level.camera_character_faction_select._id_22B1 = getent("char_west_b_detail", "targetname");
  level.camera_character_faction_select._id_22B1._id_47FB = [7, 75];
  level.camera_character_faction_select._id_A370 = 34;
}

weapons_close() {
  setDvar("#x368bdfdbc24f123de", 0);
  setDvar("#x3315497e1370274af", 16);
  setDvar("#x34ffe3d8b0515fe9d", 0);
  setDvar("#x366a409d6a93d9df2", 12);
}

weapons_far() {
  setDvar("#x368bdfdbc24f123de", 0);
  setDvar("#x3315497e1370274af", 16);
  setDvar("#x3c0aa0a6ec3acae1a", 16);
  setDvar("#x34ffe3d8b0515fe9d", 0);
}

weapons_watch() {
  setDvar("#x368bdfdbc24f123de", 0);
  setDvar("#x3c0aa0a6ec3acae1a", 8);
  setDvar("#x34ffe3d8b0515fe9d", 0);
}

lobby_close() {
  setDvar("#x36953c7226815560c", "128 384 640 4096");
  setDvar("#x368bdfdbc24f123de", 0);
  setDvar("#x34ffe3d8b0515fe9d", 0);
}

lobby_far() {
  setDvar("#x36953c7226815560c", "1024 1024 1024 4096");
  setDvar("#x368bdfdbc24f123de", 0);
  setDvar("#x34ffe3d8b0515fe9d", 0);
}

flare_lgt_pos_lerp() {
  wait 5;
  var_0 = getent("flare_lgt", "targetname");
  var_0 _meth_8338(0);
  var_0 _meth_8334((1, 0.95, 0.9));
  var_1 = var_0.origin;
  var_2 = getent("lobby_charslot_01", "targetname");
  var_3 = scripts\engine\utility::getstruct("pos_1", "targetname");
  var_4 = scripts\engine\utility::getstruct("pos_2", "targetname");
  var_5 = scripts\engine\utility::getstruct("pos_3", "targetname");
  var_6 = scripts\engine\utility::getstruct("pos_4", "targetname");
  var_7 = scripts\engine\utility::getstruct("pos_5", "targetname");
  var_8 = scripts\engine\utility::getstruct("pos_6", "targetname");
  var_9 = scripts\engine\utility::getstruct("pos_7", "targetname");
  var_10 = scripts\engine\utility::getstruct("pos_8", "targetname");
  var_11 = scripts\engine\utility::getstruct("pos_9", "targetname");
  var_12 = scripts\engine\utility::getstruct("pos_10", "targetname");
  var_13 = scripts\engine\utility::getstruct("pos_11", "targetname");
  var_14 = scripts\engine\utility::getstruct("pos_12", "targetname");

  if(scripts\engine\utility::_id_5C00("flare_on") == 0) {
    scripts\engine\utility::_id_5C1B("flare_on");
    thread lock_to_character(var_0, var_2);

    while(scripts\engine\utility::_id_5C00("flare_on")) {
      thread spot_lerp_origin(var_0, 3, var_3.origin);
      wait 4;
      scripts\engine\utility::_id_5C1B("flare_flicker");
      thread flare_flicker(var_0, 9, 13, 3, 6);
      thread spot_lerp_origin(var_0, 5, var_4.origin);
      wait 6;
      thread spot_lerp_origin(var_0, 5, var_5.origin);
      wait 5;
      scripts\engine\utility::_id_5C04("flare_flicker");
      wait 10;
      thread spot_lerp_origin(var_0, 1, var_6.origin);
      wait 2;
      scripts\engine\utility::_id_5C1B("flare_flicker");
      thread flare_flicker(var_0, 7, 16, 3, 5);
      thread spot_lerp_origin(var_0, 3, var_7.origin);
      wait 4;
      thread spot_lerp_origin(var_0, 3, var_8.origin);
      wait 4;
      scripts\engine\utility::_id_5C04("flare_flicker");
      wait 8;
      thread spot_lerp_origin(var_0, 1, var_9.origin);
      wait 2;
      scripts\engine\utility::_id_5C1B("flare_flicker");
      thread flare_flicker(var_0, 8, 18, 2, 6);
      thread spot_lerp_origin(var_0, 3, var_10.origin);
      wait 4;
      thread spot_lerp_origin(var_0, 3, var_11.origin);
      wait 4;
      scripts\engine\utility::_id_5C04("flare_flicker");
      wait 9;
      thread spot_lerp_origin(var_0, 1, var_12.origin);
      wait 2;
      scripts\engine\utility::_id_5C1B("flare_flicker");
      thread flare_flicker(var_0, 8, 18, 2, 6);
      thread spot_lerp_origin(var_0, 4, var_13.origin);
      wait 5;
      thread spot_lerp_origin(var_0, 4, var_14.origin);
      wait 5;
      scripts\engine\utility::_id_5C04("flare_flicker");
      wait 8;
    }
  }
}

flare_lgt_pos_lerp_op() {
  wait 5;
  var_0 = getent("flare_lgt_op", "targetname");
  var_0 _meth_8338(10);
  var_0 _meth_8334((1, 0.95, 0.9));
  var_1 = var_0.origin;
  var_2 = getent("charroom_char_west_b", "targetname");
  var_3 = scripts\engine\utility::getstruct("pos_13", "targetname");
  var_4 = scripts\engine\utility::getstruct("pos_14", "targetname");
  var_5 = scripts\engine\utility::getstruct("pos_15", "targetname");
  var_6 = scripts\engine\utility::getstruct("pos_16", "targetname");
  var_7 = scripts\engine\utility::getstruct("pos_17", "targetname");
  var_8 = scripts\engine\utility::getstruct("pos_18", "targetname");
  var_9 = scripts\engine\utility::getstruct("pos_19", "targetname");
  var_10 = scripts\engine\utility::getstruct("pos_20", "targetname");
  var_11 = scripts\engine\utility::getstruct("pos_21", "targetname");

  if(scripts\engine\utility::_id_5C00("flare_on_op") == 0) {
    scripts\engine\utility::_id_5C1B("flare_on_op");
    thread lock_to_character_op(var_0, var_2);

    while(scripts\engine\utility::_id_5C00("flare_on_op")) {
      thread spot_lerp_origin(var_0, 3, var_3.origin);
      wait 4;
      scripts\engine\utility::_id_5C1B("flare_flicker");
      thread flare_flicker(var_0, 5, 10, 3, 6);
      thread spot_lerp_origin(var_0, 3, var_4.origin);
      wait 3;
      thread spot_lerp_origin(var_0, 4, var_5.origin);
      wait 3;
      scripts\engine\utility::_id_5C04("flare_flicker");
      wait 8;
      thread spot_lerp_origin(var_0, 3, var_6.origin);
      wait 4;
      scripts\engine\utility::_id_5C1B("flare_flicker");
      thread flare_flicker(var_0, 5, 8, 3, 6);
      thread spot_lerp_origin(var_0, 5, var_7.origin);
      wait 3;
      thread spot_lerp_origin(var_0, 5, var_8.origin);
      wait 3;
      scripts\engine\utility::_id_5C04("flare_flicker");
      wait 5.1;
      thread spot_lerp_origin(var_0, 3, var_9.origin);
      wait 4;
      scripts\engine\utility::_id_5C1B("flare_flicker");
      thread flare_flicker(var_0, 5, 9, 3, 6);
      thread spot_lerp_origin(var_0, 3, var_10.origin);
      wait 2;
      thread spot_lerp_origin(var_0, 3, var_11.origin);
      wait 2;
      scripts\engine\utility::_id_5C04("flare_flicker");
      wait 7;
    }

    thread spot_lerp_origin(var_0, 4, var_1.origin);
  }
}

flare_flicker(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2;

  for(var_6 = 0; scripts\engine\utility::_id_5C00("flare_flicker"); var_5 = var_6) {
    var_6 = randomfloatrange(var_1, var_2);
    var_7 = randomfloatrange(var_3, var_4);
    var_7 = var_7 * 0.75;

    for(var_8 = 0; var_8 < var_7; var_8++) {
      var_9 = var_6 * (var_8 / var_7) + var_5 * ((var_7 - var_8) / var_7);
      var_0 _meth_8338(var_9);
      wait 0.05;
    }
  }

  thread flare_lerp_down(var_0, var_1, var_2, var_6, 4.0);
}

flare_lerp_down(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_6 = randomfloatrange(var_1, var_2);
  var_7 = gettime();
  var_8 = gettime() + var_4 * 1000.0;
  var_9 = var_4 / 0.05;

  for(var_10 = 0; var_10 < var_9; var_10++) {
    var_11 = gettime() - var_7;
    var_12 = _func_0439(0, var_4 * 1000.0, 1.0, 0.0, var_11);
    var_13 = var_6 * (var_10 / var_9) + var_5 * ((var_9 - var_10) / var_9);
    var_13 = var_13 * var_12;
    var_0 _meth_8338(var_13);
    wait 0.05;
    var_5 = var_6;
  }
}

_id_5B32(var_0, var_1, var_2, var_3, var_4) {
  for(var_5 = var_2; scripts\engine\utility::_id_5C00("fire_flicker"); var_5 = var_6) {
    var_6 = randomfloatrange(var_1, var_2);
    var_7 = randomfloatrange(var_3, var_4);
    var_7 = var_7 * 0.75;

    for(var_8 = 0; var_8 < var_7; var_8++) {
      var_9 = var_6 * (var_8 / var_7) + var_5 * ((var_7 - var_8) / var_7);
      var_0 _meth_8338(var_9);
      wait 0.05;
    }
  }
}

spot_lerp_origin(var_0, var_1, var_2) {
  var_0 notify("stop lerp");
  var_0 endon("stop lerp");
  var_0 endon("death");
  var_3 = var_0.origin;
  var_4 = 0;

  while(var_4 < var_1) {
    var_0.origin = _func_025E(var_3, var_2, var_4 / var_1);
    var_4 = var_4 + 0.05;
    wait 0.05;
  }

  var_0.origin = var_2;
}

lerp_spot_intensity(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");

  if(!isDefined(var_3)) {
    return;
  }
  var_3 endon("death");
  var_4 = var_3 _meth_8146();
  var_3.endintensity = var_2;
  var_5 = 0;

  while(var_5 < var_1) {
    var_6 = var_4 + (var_2 - var_4) * (var_5 / var_1);
    var_5 = var_5 + 0.05;
    var_3 _meth_8338(var_6);
    wait 0.05;
  }

  var_3 _meth_8338(var_2);
}

lock_to_character(var_0, var_1) {
  for(;;) {
    var_2 = var_1.origin - var_0.origin;
    var_3 = vectortoangles(var_2);
    var_0.angles = var_3;
    waitframe();
  }
}

lock_to_character_op(var_0, var_1) {
  for(;;) {
    var_2 = var_1.origin - var_0.origin;
    var_3 = vectortoangles(var_2);
    var_0.angles = var_3;
    waitframe();
  }
}