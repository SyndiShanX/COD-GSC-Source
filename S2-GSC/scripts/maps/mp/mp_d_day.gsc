/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_d_day.gsc
****************************************/

main() {
  setdvarifuninitialized("loadscreen_poses", 0);
  _id_04A2::main();
  _id_040A::main();
  _id_04A1::main();
  _id_0483::main();
  maps\mp\mp_d_day_lighting::main();
  maps\mp\mp_d_day_aud::main();
  _id_0472::_id_8A2F("compass_map_mp_d_day");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level._id_5A7C = "mp_d_day_killstreak";
  level._id_5A6B = "mp_d_day_killstreak";
  level._id_47CD = "mp_d_day_glide1";
  level._id_47CE = "mp_d_day_glide2";
  level._id_A4B5["intensity"] = 0.2;
  level._id_A4B5["falloff"] = 1.2;
  level._id_A4B5["scaleX"] = 1;
  level._id_A4B5["scaleY"] = 1;
  level._id_A4B5["squareAspectRatio"] = 0;
  level._id_A4B5["lerpDuration"] = 0.1;
  level._id_A4BE["intensity"] = 0.5;
  level._id_A4BE["falloff"] = 1.2;
  level._id_A4BE["scaleX"] = 1;
  level._id_A4BE["scaleY"] = 1;
  level._id_A4BE["squareAspectRatio"] = 0;
  level._id_A4BE["lerpDuration"] = 0.4;
  level._id_6465["velocityscaler"] = 0.35;
  level._id_6465["cameraRotationInfluence"] = 0;
  level._id_6465["cameraTranslationInfluence"] = 0;
  setDvar("1520", "-0.3 1 0.3 13");
  setDvar("5800", 3);
  setDvar("4230", 400);
  _id_854F();
  level thread maps\mp\_utility::_id_5246();
  thread _id_918C();
  level thread _id_5461();
}

_id_854F() {
  setDvar("330", 1);
  setDvar("1271", 30);
}

_id_918C() {
  var_0 = [(3419.79, 6397.19, 735.927), (1774.04, 6258.63, 724.925), (1005.1, 8224.58, 863.727), (688.495, 7922.39, 900.26), (2013.09, 3907.71, 365.023), (2489.66, 5191.32, 335.633), (-1613.17, 7480.25, 799.985), (-151.475, 6909.94, 749.729), (-900.085, 9282.89, 924.29), (-1221.37, 3117.04, 357.256), (824.276, 2733.36, 350.209), (-2921.04, 7171.94, 823.524), (-2411.72, 5768.69, 760.266), (-2562.08, 5337.96, 695.713), (-1954.52, 3878.88, 375.158), (-2825.11, 4752.04, 293.088)];
  wait 4;
  var_1 = 10;
  var_2 = 10;

  for(;;) {
    var_3 = _func_0A5(0.8, 2);
    wait(var_3);

    while(var_2 == var_1)
      var_2 = _func_0A4(10, 25);

    _func_213(var_2);

    if(var_2 < 15)
      _func_213(1);
    else if(var_2 > 14 && var_2 < 20)
      _func_213(2);
    else
      _func_213(3);

    thread _id_0FF4(var_0[var_2 - 10]);
    var_1 = var_2;
  }
}

_id_0FF4(var_0) {
  var_1 = 0.4;
  wait 2;
  _func_17F(var_1, 1.0, var_0, 600);
}

_id_5461() {
  level endon("game_ended");

  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
    return;
  }
  if(isDefined(game["status"]) && game["status"] != "normal") {
    return;
  }
  if(!isDefined(level.teambased) || !level.teambased) {
    return;
  }
  level waittill("matchStartTimer");
  thread _id_7043();
  thread _id_7043(10, 0.0, 15.0, 3, 1600);
  thread _id_3AAD();
}

_id_3AAD() {
  wait 2;
  var_0 = 8;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = _func_0A5(0.05, 0.25);
    var_3 = _func_0A5(9.0, 12.0);
    var_4 = 1;
    var_5 = 1800;
    var_6 = _func_0A4(-2000, 2000);
    var_7 = 1;
    thread _id_7043(var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    wait 0.75;
  }
}

_id_7043(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  var_7 = common_scripts\utility::_id_46B5("intro_flight_path_start", "targetname");
  var_8 = common_scripts\utility::_id_46B5("intro_flight_path_end", "targetname");

  if(!isDefined(var_0))
    var_0 = 100;

  if(!isDefined(var_7) || !isDefined(var_8)) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = 2000;

  if(!isDefined(var_2))
    var_2 = 18.0;

  if(!isDefined(var_1))
    var_1 = 5.0;

  if(!isDefined(var_3))
    var_3 = 5;

  if(isDefined(var_6) && var_6) {
    var_9 = "ks_fighter_strafe_usa";
    var_10 = "vehicle_usa_fighter_thunderbolt_vista";
    var_11 = "vehicle_usa_fighter_thunderbolt_vista_fade";
  } else {
    var_9 = "ks_emergency_airdrop_usa";
    var_10 = "usa_bomber_commando_vista";
    var_11 = "usa_bomber_commando_vista_fade";
  }

  var_12 = 1200;
  var_13 = 1;
  var_14 = [];
  var_15 = 1;
  var_16 = var_7.origin + (0, 0, var_4);
  var_17 = var_8.origin + (0, 0, var_4);
  wait(var_1);

  while(var_13 <= var_3) {
    var_18 = spawn("script_model", var_16);
    var_18 setModel(var_11);
    var_18 thread _id_7016(var_10);

    if(isDefined(var_9))
      var_18 _meth_8276(var_9);

    var_14[var_14.size] = var_18;
    var_18.angles = vectortoangles(vectorNormalize(var_17 - var_16));
    var_19 = anglesToForward(var_18.angles);
    var_20 = anglestoright(var_18.angles);

    if(isDefined(var_6) && var_6)
      _func_147(common_scripts\utility::_id_44F5("fighter_plane_flyover"), var_18, "tag_origin");
    else
      _func_147(common_scripts\utility::_id_44F5("bomber_plane_flyover"), var_18, "tag_origin");

    if(isDefined(var_5) && var_15) {
      var_16 = var_16 + var_20 * var_5;
      var_17 = var_17 + var_20 * var_5;
      var_15 = 0;
    }

    switch (var_13) {
      case 1:
        var_18.origin = var_16;
        var_18._id_4800 = var_17;
        var_18._id_7035 = 1;
        var_18._id_7021 = var_13 + var_0;
        break;
      case 2:
        var_18.origin = var_16 + var_20 * var_12 * -1 + var_19 * var_12 * -1;
        var_18._id_4800 = var_17 + var_20 * var_12 * -1 + var_19 * var_12 * -1;
        var_18._id_7035 = 2;
        var_18._id_7021 = var_13 + var_0;
        break;
      case 3:
        var_18.origin = var_16 + var_20 * var_12 + var_19 * var_12 * -1;
        var_18._id_4800 = var_17 + var_20 * var_12 + var_19 * var_12 * -1;
        var_18._id_7035 = 3;
        var_18._id_7021 = var_13 + var_0;
        break;
      case 4:
        var_18.origin = var_16 + var_20 * var_12 * -2 + var_19 * var_12 * -2;
        var_18._id_4800 = var_17 + var_20 * var_12 * -2 + var_19 * var_12 * -2;
        var_18._id_7035 = 4;
        var_18._id_7021 = var_13 + var_0;
        break;
      case 5:
        var_18.origin = var_16 + var_20 * var_12 * 2 + var_19 * var_12 * -2;
        var_18._id_4800 = var_17 + var_20 * var_12 * 2 + var_19 * var_12 * -2;
        var_18._id_7035 = 5;
        var_18._id_7021 = var_13 + var_0;
        break;
    }

    var_18 thread _id_7025();
    var_18 _id_0378::_id_8D74("mp_intro_dday_plane_flyover", var_10, var_18._id_7021);
    var_18 _meth_82B1(var_18._id_4800, var_2);
    var_13++;
    waitframe();
  }

  wait(var_2 - 1.0);

  foreach(var_18 in var_14)
  var_18 thread _id_7017(var_11);
}

_id_7025() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0;
  var_1 = 5;
  var_2 = -8;
  var_3 = _func_0A5(1.0, 2.0);
  var_4 = 1;

  for(;;) {
    if(var_4 % 2 == 0)
      self _meth_82B8(self.angles + (0, 0, var_1), var_3);
    else if(var_4 % 3 == 0)
      self _meth_82B8(self.angles + (0, 0, var_0), var_3);
    else
      self _meth_82B8(self.angles + (0, 0, var_2), var_3);

    wait(var_3);
    var_4++;
  }
}

_id_7016(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = 0.5;
  self _meth_8450(0, 1, var_1);
  wait(var_1);
  self setModel(var_0);
}

_id_7017(var_0) {
  var_1 = 1.0;
  self setModel(var_0);
  self _meth_8450(1, 0, var_1);
}