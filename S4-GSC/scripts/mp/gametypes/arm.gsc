/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arm.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "tdm";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 2400);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  setDvar("#x35c5201b4d43386ca", 0);
  setDvar("#x3f28f1ae1b8dcaa4b", 1);
  setDvar("#x3a91f090ec02b0c9c", 30);
  setDvar("#x3472b950714ddf102", 1);
  setDvar("#x3d823bf55201066bf", 0);
  setomnvar("ui_num_dom_flags", 5);
  _id_FC7D();
  level._id_CC11 = undefined;
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB70 = ::_id_AB70;
  level._id_AB8C = ::_id_6CEF;
  level._id_AB3F = ::_id_AB3F;
  level._id_AB42 = scripts\mp\gametypes\dom::_id_AAEF;
  level._id_8FA1 = gettime();
  level._id_150E = [];
  level._id_1FE3 = [];
  level._id_8FA2 = undefined;
  level._id_BC37 = undefined;
  level._id_BDA4 = 1;
  level._id_C587 = 1;
  level._id_C586["allies"] = 24;
  level._id_C586["axis"] = 24;
  game["dialog"]["gametype"] = "gametype_groundwar";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x3e488386ae6284c8")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "boost_groundwar";
  game["dialog"]["defense_obj"] = "boost_groundwar";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["securing_d"] = "securing_d";
  game["dialog"]["securing_e"] = "securing_e";
  game["dialog"]["secured_a"] = "secured_a";
  game["dialog"]["secured_b"] = "secured_b";
  game["dialog"]["secured_c"] = "secured_c";
  game["dialog"]["secured_d"] = "secured_d";
  game["dialog"]["secured_e"] = "secured_e";
  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["losing_d"] = "losing_d";
  game["dialog"]["losing_e"] = "losing_e";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
  game["dialog"]["lost_d"] = "lost_d";
  game["dialog"]["lost_e"] = "lost_e";
  game["dialog"]["lost_all"] = "gamestate_domlosing";
  game["dialog"]["secure_all"] = "gamestate_domwinning";
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_snatch_ac130_clouds"] = loadfx("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_br_infil_omni_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx");
  level._effect["vfx_br_infil_spot_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx");
  level._id_A741 = getdvarint("#x3bfd98e12a022743d", 0);
  level._id_8DA6 = getdvarint("#x3103e6dee1450798d", 7);
  level._id_FE94 = getdvarint("#x3ca6952121034fcb5", 1);
  level._id_FEAF = getdvarint("#x313b0b1363cee6385", 1);
  level._id_78F8 = getdvarint("#x3cbc93de10211da5", 0);
  level._id_78F7 = getdvarint("#x35cddf67b91b51cde", 0);
  level._id_4AC2 = getdvarint("#x33408348a23c0e69f", 1);
  level._id_3B22 = getdvarint("#x395047732c9386979", 0);
  level._id_FE2D = getdvarint("#x376a3839120aa7052", 0);
  level._id_FE2E = getdvarint("#x3dac1d2e5c5ec69e4", 0);
  level._id_2E38 = getdvarint("#x335c9162c4bc34894", 0);
  level._id_2E32 = getdvarfloat("#x384678d9f3c66f49f", 4000);
  level._id_2E30 = getdvarfloat("#x3a41442d4f1ba9669", 5000);
  level._id_2E2D = getdvarfloat("#x3b7aa9db5e0254128", 1);
  level._id_501D = getdvarint("#x392cdcfb93fbc2eb5", 0);
  level._id_E374 = getdvarint("#x3cca618301ca0779", 0);
  level._id_E375 = getdvarint("#x3a69b2a48be352968", 0);
  level._id_FED0 = getdvarint("#x3ddcfcb3c1d89e534", 1);
  level._id_E380 = getdvarint("#x393a2d2e0404a88a2", 0);
  level._id_FED7 = getdvarint("#x31464756ad8886e2c", 0);
  level._id_FEF0 = getdvarint("#x3a4f50b3f65b0804f", 1);
  level._id_5ED0 = getdvarint("#x3dd1f421ab4b9a188", 0);
  level._id_9C77 = getdvarint("#x3c5eb45a167f774cc", 2);
  level._id_EE45 = getdvarint("#x340c2e338c98dcecf", 120);
  level._id_19A8 = getdvarint("#x3a24edec7bf696d91", 120);
  level._id_97C9 = getdvarint("#x3f35aa0ed4c39b6d7", 1);
  level._id_9DD9 = getdvarint("#x3ba85ae2c38db6ea0", 1);
  level._id_9DDA = getdvarint("#x3dfb676b412fdd044", 30);
  level._id_A793 = getdvarint("#x320b84c098c6975f6", 25);
  level._id_4ADA = getdvarint("#x3cd4fedd054c3348b", 0);
  level._id_B027 = getdvarint("#x3a9673103fb31584d", 30);
  level._id_DCF1 = getdvarint("#x3cc919e4c4d578c6b", 1);
  level._id_DCF0 = getdvarint("#x39fff91bfe3481746", 1);
  level._id_E36D = getdvarint("#x3a91f976cb76dbace", 120);
  level._id_9A63 = getdvarint("#x3ff06c2b2134012df", 1);
  level._id_4DB3 = getdvarint("#x3fe185609cbe8a080", 0);
  level._id_4DB2 = getdvarint("#x34568285cc01ed353", 0);
  level._id_FEA7 = getdvarint("#x393cac8a60d54291c", 0);

  if(istrue(level._id_DCF1)) {
    level._id_F3FF = [];
    level._id_F3FF["axis"] = [];
    level._id_F3FF["allies"] = [];
  }

  if(istrue(level._id_DCF0)) {
    level._id_F3FD = [];
    level._id_F3FD["axis"] = [];
    level._id_F3FD["allies"] = [];
    level._id_F3FD["untouched"] = [];
  }

  if(level._id_FE94 || level._id_FEAF || level._id_FED2) {
    setDvar("#x3a6e1a518ba5d320", 1);
    setDvar("#x341f25c791e305774", 0);
    setDvar("#x3ac6e820187d28f75", 1);
  } else {
    setDvar("#x3a6e1a518ba5d320", 0);
    setDvar("#x341f25c791e305774", 1);
    setDvar("#x3ac6e820187d28f75", 1);
  }

  if(level._id_501D) {
    level._id_25A8 = 1;
  }

  if(level._id_2E38 == 1) {
    level._id_2E39 = [];
    level._id_2E39["axis"] = 0;
    level._id_2E39["allies"] = 0;
  }

  level._id_9FC8 = 1;
  level._id_4AF6 = 1;
  level._id_E356 = ::_id_E356;
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3c744d2679bb7b23e", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("#x358fd022a3e2a05a8", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("#x3a98393f65af0da90", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("#x32c19aa7f9d6f4781", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("#x327f89bda93b12ee0", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("#x349a29b4cdc046df6", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("#x3fa26e168be99222f", getmatchrulesdata("kothData", "delayPlayer"));
  setdynamicdvar("#x3dee07d0e9553df14", getmatchrulesdata("kothData", "useHQRules"));
  setdynamicdvar("#x3f8d056b65fee1f85", getmatchrulesdata("tdefData", "spawnDelay"));
  scripts\mp\utility\game::_id_C25D("arm", 0);
}

_id_ABAD() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  setclientnamemode("auto_change");
  level._id_A8E8 = [];
  level._id_F935 = [];
  _id_8294();
  _id_D5AD();
  level._id_FE52 = 0;
  level._id_8DE0 = [];
  level._id_EF80 = [];
  level._id_EF80["allies"] = [];
  level._id_EF80["axis"] = [];
  level._id_8DDB = [];
  level._id_8DDB[4] = ["cruise_predator", "scrambler_drone_guard"];
  level._id_8DDB[3] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level._id_8DDB[2] = ["toma_strike", "chopper_gunner", "pac_sentry", "ball_turret_gunner"];
  level._id_EF80["allies"] = ["cruise_predator", "precision_airstrike", "cruise_predator"];
  level._id_EF80["axis"] = ["cruise_predator", "precision_airstrike", "cruise_predator"];
  level thread _id_D8C5();
  _id_4489();
  _id_D87F();
  _id_2EEB();

  if(istrue(level._id_FE94)) {
    _id_D899();
  }

  level thread _id_CA67();

  if(level._id_FE2D) {
    level thread _id_9A16();
  }

  if(istrue(level._id_FEAF)) {
    _id_0808::init();
    level thread _id_8081();
  }

  thread _id_7FA6();
  level thread _id_FC52();
  _id_0A8D::_id_829D();

  if(istrue(level._id_9DD9)) {
    level thread _id_A704();
  }

  _id_517D();

  if(istrue(level._id_FEA7)) {
    _id_07B9::_id_2F97();
  }

  _id_0797::_id_8251();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_AF70 = scripts\mp\utility\dvars::_id_509C("pauseTime", 1, 0, 1);
  level._id_46D3 = scripts\mp\utility\dvars::_id_509C("delayPlayer", 1, 0, 1);
  level._id_E295 = scripts\mp\utility\dvars::_id_509A("spawnDelay", 5, 0, 30);
  level._id_FE83 = 1;
  level._id_5C3B = scripts\mp\utility\dvars::_id_509A("#x328f66aefdd04dd", 30, 0, 30);
  level._id_5C47 = scripts\mp\utility\dvars::_id_509C("flagsRequiredToScore", 1, 1, 3);
  level._id_B9C1 = scripts\mp\utility\dvars::_id_509C("pointsPerFlag", 1, 1, 300);
  level._id_5C41 = scripts\mp\utility\dvars::_id_509C("flagNeutralization", 0, 0, 1);
  level._id_BB6F = scripts\mp\utility\dvars::_id_509C("preCapPoints", 0, 0, 1);
  level._id_322C = scripts\mp\utility\dvars::_id_509C("captureDecay", 1, 0, 1);
  level._id_3236 = scripts\mp\utility\dvars::_id_509C("captureType", 1, 0, 3);
  level._id_A782 = scripts\mp\utility\dvars::_id_509C("numFlagsScoreOnKill", 0, 0, 3);
  level._id_A8EC = scripts\mp\utility\dvars::_id_509A("objScalar", 4, 1, 10);

  if(getdvarint("#x3d2a96c86ba77fb0f", 0) == 1) {
    setDvar("#x360e94616e8c18378", 1);
    var_0 = 1000;
    var_1 = getdvarint("#x3143f632acfa7d87f", 0);

    if(var_1 != 0) {
      var_0 = var_1;
    }

    setDvar("#x3665360981d1e5d17", var_0);
  }
}

_id_D5AD() {
  level._id_7C42 = "waypoint_capture";
  level._id_7C74 = "waypoint_captureneutral";
  level._id_7C4B = "waypoint_defend";
  level._id_7C48 = "waypoint_contested";
  level._id_7C50 = "waypoint_defending";
  level._id_7C87 = "waypoint_taking";
  level._id_7C6F = "waypoint_losing";
}

_id_517D() {
  scripts\cp_mp\utility\game_utility::_id_C4E8("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::_id_C4E8("vehicle_volume", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::_id_C4E8("vehicle_volume_simplified", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::_id_C4E8("super", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::_id_C4E8("militarybase", "script_noteworthy");
  scripts\cp_mp\utility\game_utility::_id_C4E8("location_volume", "targetname");
  scripts\cp_mp\utility\game_utility::_id_C4E8("locale_area_trigger", "targetname");
  scripts\cp_mp\utility\game_utility::_id_C4E8("bank_entry_detector", "targetname");
  scripts\cp_mp\utility\game_utility::_id_C4E8("shadow_blocker", "targetname");
  scripts\cp_mp\utility\game_utility::_id_C4E9("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::_id_C4E9("veh8_mil_air_acharlie130", 1);
  scripts\cp_mp\utility\game_utility::_id_C4E9("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::_id_C4E9("me_electrical_box_street_01", 1);
  scripts\cp_mp\utility\game_utility::_id_C4E7("light");
  scripts\cp_mp\utility\game_utility::_id_C4E7("trigger_use_touch");

  if(isDefined(level._id_96CC) && level._id_96CC == "locale_6") {
    scripts\cp_mp\utility\game_utility::_id_C4E8("locale_8", "script_noteworthy");
  }

  var_0 = [];
  var_0[0] = (-22592, 27367, 1000);
  var_0[1] = (-22592, 27303, -448);
  var_0[2] = (7837, -9674, 1154);
  var_0[3] = (7637, -9674, 1154);
  var_0[4] = (7901, -9674, -270);
  var_0[5] = (7701, -9674, -270);
  var_0[6] = (10366, -11606, 66);
  var_0[7] = (10366, -11813, 66);
  var_0[6] = (10366, -11670, -270);
  var_0[7] = (10366, -11877, -270);
  var_0[8] = (7498, -11716, 66);
  var_0[9] = (7498, -11652, -270);
  var_0[10] = (-1200, -18954, -242);
  var_0[11] = (-1215, -19016, 774);
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.model) && var_3.model == "tag_origin") {
      var_4 = 0;

      foreach(var_6 in var_0) {
        if(var_4) {
          break;
        }

        if(distancesquared(var_3.origin, var_6) < 144) {
          var_4 = 1;
        }
      }

      if(var_4) {
        var_3 delete();
      }
    }
  }
}

_id_C4FC() {
  wait 5;
  var_0 = [];
  var_0[0] = "tactical_cover_col";
  var_0[1] = "tactical_ladder_col";
  var_0[2] = "clip8x8x256";
  var_0[3] = "player8x8x256";
  var_0[4] = "ladderMetal264";
  var_0[5] = "ladderWood192";
  var_0[6] = "ladderMetal192";
  var_0[7] = "mount128";
  var_0[8] = "mount64";
  var_0[9] = "mount32";
  var_0[10] = "mount256";
  var_0[11] = "ladderWood264";
  var_0[12] = "nosight256x256x8";
  var_0[13] = "nosight128x128x8";
  var_0[14] = "mountCorner128";
  var_0[15] = "mantle256";
  var_0[16] = "mantle128";
  var_0[17] = "mantle64";
  var_0[18] = "mantle32";
  var_0[19] = "stairsHalfFlight128";
  var_0[20] = "stairsFullFlight128";

  foreach(var_2 in var_0) {
    scripts\cp_mp\utility\game_utility::_id_C4E8(var_2, "targetname");
  }
}

_id_4489() {
  level._id_1FE8 = "gw_fob_axisHQ";
  level._id_1513 = "gw_fob_alliesHQ";
  level._id_E6CD = [];
  level._id_E6CE = [];
  level._id_E6CF = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
  level._id_45A3 = "gw_fob_axishq";
  level._id_45A4 = "gw_fob_axishq";
  level._id_45A1 = "gw_fob_allieshq";
  level._id_45A2 = "gw_fob_allieshq";
}

_id_D8C5() {
  while(!isDefined(game["killstreakTable"])) {
    waitframe();
  }

  foreach(var_2, var_1 in game["killstreakTable"]._id_EC74) {
    level._id_10CCD[var_2 + "_incoming"] = "neutral";
    level._id_10CCC[var_2 + "_incoming"] = 1;
    level._id_10CD9[var_2 + "_incoming"] = "";
    level._id_10CD8[var_2 + "_incoming"] = var_1["hudIcon"];
    level._id_10CD1[var_2 + "_incoming"] = 0;
    level._id_10CCD[var_2] = "neutral";
    level._id_10CCC[var_2] = 1;
    level._id_10CD9[var_2] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
    level._id_10CD8[var_2] = var_1["hudIcon"];
  }
}

_id_D87F() {
  level._id_7346 = spawnStruct();
  level._id_7346._id_1FE7 = spawnStruct();
  level._id_7346._id_1FE7.trigger = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1FE8);

  if(!isDefined(level._id_7346._id_1FE7)) {}

  level._id_7346._id_1512 = spawnStruct();
  level._id_7346._id_1512.trigger = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1513);

  if(!isDefined(level._id_7346._id_1512)) {
    return;
  }
}

_id_D899() {
  level._id_7346._id_E6D0 = [];
  level._id_7346._id_E6D1 = [];
  level._id_7346._id_E6D2 = [];
  var_0 = ["_a", "_b", "_c", "_d", "_e"];
  var_1 = 0;

  foreach(var_3 in level._id_E6CD) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::_id_6B17(var_3);
    var_4.trigger._id_A90E = var_0[var_1];
    var_1++;
    level._id_7346._id_E6D0[level._id_7346._id_E6D0.size] = var_4;
  }

  foreach(var_3 in level._id_E6CE) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::_id_6B17(var_3);
    var_4.trigger._id_A90E = var_0[var_1];
    var_1++;
    level._id_7346._id_E6D1[level._id_7346._id_E6D1.size] = var_4;
  }

  foreach(var_3 in level._id_E6CF) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::_id_6B17(var_3);
    var_4.trigger._id_A90E = var_0[var_1];
    var_1++;
    level._id_7346._id_E6D2[level._id_7346._id_E6D2.size] = var_4;
  }
}

_id_FC52() {
  level endon("game_ended");
  var_0 = undefined;
  var_1 = undefined;
  level waittill("prematch_done");
  level thread _id_0819::_id_FC68();

  while(!level.gameended) {
    wait 10;
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_2 = _id_6C00();

    if(!isDefined(level._id_CC24)) {
      level._id_CC24 = [];
    }

    foreach(var_4 in level._id_EF89) {
      level._id_CC24[var_4] = 0;
    }

    if(var_2.size) {
      for(var_6 = 1; var_6 < var_2.size; var_6++) {
        var_7 = var_2[var_6];
        var_8 = gettime() - var_7._id_3235;

        for(var_9 = var_6 - 1; var_9 >= 0 && var_8 > gettime() - var_2[var_9]._id_3235; var_9--) {
          var_2[var_9 + 1] = var_2[var_9];
        }

        var_2[var_9 + 1] = var_7;
      }

      foreach(var_7 in var_2) {
        var_11 = var_7 _id_07D6::_id_6C02();
        var_0 = _func_00DB(var_11);
        var_12 = scripts\mp\gametypes\obj_dom::_id_6DCE(var_11);

        if(var_12 >= level._id_5C47) {
          level._id_CC24[var_11] = level._id_CC24[var_11] + level._id_B9C1;
        }
      }
    }

    _id_FD1C();
  }
}

_id_6C00() {
  var_0 = [];

  foreach(var_2 in level._id_A8E8) {
    if(var_2 _id_07D6::_id_6C02() != "neutral" && isDefined(var_2._id_3235)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_FD1C() {
  var_0 = [];

  foreach(var_2 in level._id_EF89) {
    var_3 = game["teamScores"][var_2] + level._id_CC24[var_2];

    if(var_3 >= level._id_C948) {
      var_0[var_0.size] = var_2;
    }
  }

  if(var_0.size == 1) {
    level._id_CC24[var_0[0]] = level._id_C948 - game["teamScores"][var_0[0]];
  }

  var_5 = scripts\mp\gamescore::_id_2F03();

  foreach(var_2 in level._id_EF89) {
    if(level._id_CC24[var_2] > 0) {
      scripts\mp\gamescore::_id_7001(var_2, level._id_CC24[var_2], 1, undefined, 1);
    }
  }

  var_8 = scripts\mp\gamescore::_id_2F03();

  if(var_5 != var_8) {
    scripts\mp\gamescore::_id_B8D0(var_8, 1, var_5);
  }
}

_id_CA67(var_0) {
  level._id_1FED = [level._id_1FE8];
  level._id_1516 = [level._id_1513];
  level._id_14F5 = [];

  if(istrue(level._id_FE94)) {
    foreach(var_2 in level._id_7346._id_E6D1) {
      var_3 = _id_CA68(var_2.trigger, "axis");
      level._id_14F5[level._id_14F5.size] = var_2;
      level._id_1FED[level._id_1FED.size] = var_2.name;

      if(isDefined(level._id_E371[var_2.name]["axis"]._id_1782)) {
        level._id_E371[var_2.name]["axis"]._id_1782.origin = var_2.trigger.origin + (0, 0, 100);
      }
    }

    foreach(var_2 in level._id_7346._id_E6D0) {
      var_3 = _id_CA68(var_2.trigger, "allies");
      level._id_14F5[level._id_14F5.size] = var_2;
      level._id_1516[level._id_1516.size] = var_2.name;

      if(isDefined(level._id_E371[var_2.name]["allies"]._id_1782)) {
        level._id_E371[var_2.name]["allies"]._id_1782.origin = var_2.trigger.origin + (0, 0, 100);
      }
    }

    foreach(var_2 in level._id_7346._id_E6D2) {
      var_3 = _id_CA68(var_2.trigger, "neutral");
      level._id_14F5[level._id_14F5.size] = var_2;
    }

    foreach(var_2 in level._id_14F5) {
      var_2.trigger._id_60D8._id_AA8D = ::_id_A891;
      var_2.trigger._id_60D8._id_ABC7 = ::_id_A893;
      var_2.trigger._id_60D8._id_ABCB = ::_id_A895;
      var_2.trigger._id_60D8._id_AA79 = ::_id_A896;
      var_2.trigger._id_60D8._id_AAC2 = ::_id_A897;
      var_2.trigger._id_60D8._id_AB54 = ::_id_A892;
      var_2.trigger._id_60D8._id_ABC9 = ::_id_A894;
      level._id_A8E8[var_2.trigger._id_60D8._id_A8E1] = var_2.trigger._id_60D8;
      level._id_E371[var_2.name]["allies"]._id_A8E1 = var_2.trigger._id_60D8._id_A8E1;
      level._id_E371[var_2.name]["axis"]._id_A8E1 = var_2.trigger._id_60D8._id_A8E1;
    }
  }

  _id_0819::_id_D6D8(level._id_1FED, "axis");
  _id_0819::_id_D6D8(level._id_1516, "allies");
  _id_D5A9();

  while(!isDefined(level._id_E371)) {
    waitframe();
  }

  waitframe();

  if(isDefined(level._id_E371[level._id_1FE8]["axis"]._id_1782)) {
    level._id_E371[level._id_1FE8]["axis"]._id_1782.origin = level._id_7346._id_1FE7.trigger.origin;
  }

  if(isDefined(level._id_E371[level._id_1513]["allies"]._id_1782)) {
    level._id_E371[level._id_1513]["allies"]._id_1782.origin = level._id_7346._id_1512.trigger.origin;
  }

  level thread _id_A887();
  _id_7361();
}

_id_A887() {
  wait 1;
  _id_07F9::_id_A89F(level._id_7346._id_1FE7._id_9B4D._id_A908);
  _id_07F9::_id_A89F(level._id_7346._id_1512._id_9B4D._id_A908);
  _id_07F9::_id_A89F(level._id_7346._id_1FE7._id_541F._id_A908);
  _id_07F9::_id_A89F(level._id_7346._id_1512._id_541F._id_A908);

  foreach(var_1 in level._id_14F5) {
    _id_07F9::_id_A89F(var_1.trigger._id_60D8._id_A908);
  }

  if(isDefined(level._id_BFC9)) {
    foreach(var_4 in level._id_BFC9) {
      _id_07F9::_id_A89F(var_4._id_9B4D._id_A908);
    }
  }

  while(!_id_07D1::_id_60BE("prematch_done")) {
    waitframe();
  }

  _id_07F9::_id_A8C8(level._id_7346._id_1FE7._id_9B4D._id_A908, "axis");
  _id_07F9::_id_A8C8(level._id_7346._id_1512._id_9B4D._id_A908, "allies");

  foreach(var_1 in level._id_14F5) {
    _id_07F9::_id_A8A2(var_1.trigger._id_60D8._id_A908);
  }

  if(isDefined(level._id_BFC9)) {
    foreach(var_4 in level._id_BFC9) {
      if(isDefined(var_4)) {
        _id_07F9::_id_A8C8(var_4._id_9B4D._id_A908, var_4.team);
      }
    }
  }
}

_id_7361() {
  if(istrue(level._id_FED7)) {
    return;
  }
  while(!isDefined(level._id_E278["gw_fob_alliesHQ"])) {
    waitframe();
  }

  var_0 = "allies";
  var_1 = level._id_E377[var_0];
  var_2 = ["gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];

  foreach(var_4 in var_2) {
    var_5 = level._id_E371[var_4][var_0]._id_1782.origin;
    var_6 = var_5 + var_1 * -8500 + (0, 0, 7000);
    var_7 = vectornormalize(var_5 - var_6);
    var_8 = scripts\mp\utility\script::_id_FFE3(var_7, (0, 0, 1));

    if(istrue(level._id_FEF0)) {
      var_9 = _id_0819::_id_6E1F();
      var_6 = (var_6[0], var_6[1], var_9);
    }

    var_6 = var_6 + _id_2EE0(var_0, var_5);
    level._id_E278[var_4][var_0].origin = var_6;
    level._id_E278[var_4][var_0].angles = var_8;
  }

  while(!isDefined(level._id_E278["gw_fob_axisHQ"])) {
    waitframe();
  }

  var_0 = "axis";
  var_1 = level._id_E377[var_0];
  var_2 = ["gw_fob_axisHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];

  foreach(var_4 in var_2) {
    var_5 = level._id_E371[var_4][var_0]._id_1782.origin;
    var_6 = var_5 + var_1 * -8500 + (0, 0, 7000);
    var_7 = vectornormalize(var_5 - var_6);
    var_8 = scripts\mp\utility\script::_id_FFE3(var_7, (0, 0, 1));

    if(istrue(level._id_FEF0)) {
      var_9 = _id_0819::_id_6E1F();
      var_6 = (var_6[0], var_6[1], var_9);
    }

    var_6 = var_6 + _id_2EE0(var_0, var_5);
    level._id_E278[var_4][var_0].origin = var_6;
    level._id_E278[var_4][var_0].angles = var_8;
  }
}

_id_FC69() {
  level._id_1FED = [level._id_1FE8];
  level._id_1516 = [level._id_1513];

  foreach(var_1 in level._id_14F5) {
    var_2 = var_1.trigger._id_60D8;

    if(var_2._id_ADAE == "axis") {
      level._id_1FED[level._id_1FED.size] = var_1.name;

      if(isDefined(level._id_E371[var_1.name]["axis"]._id_1782)) {
        level._id_E371[var_1.name]["axis"]._id_1782.origin = var_1.trigger.origin + (0, 0, 100);
      }

      continue;
    }

    if(var_2._id_ADAE == "allies") {
      level._id_1516[level._id_1516.size] = var_1.name;

      if(isDefined(level._id_E371[var_1.name]["allies"]._id_1782)) {
        level._id_E371[var_1.name]["allies"]._id_1782.origin = var_1.trigger.origin + (0, 0, 100);
      }
    }
  }

  _id_0819::_id_D6D8(level._id_1FED, "axis");
  _id_0819::_id_D6D8(level._id_1516, "allies");
}

_id_D5A9() {
  var_0 = "any";
  var_1 = level._id_7346._id_1FE7.trigger.origin;
  var_2 = _id_07D6::_id_4026(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  _id_07F9::_id_FB96(var_2._id_A908, "axis");
  _id_07F9::_id_A8C8(var_2._id_A908, "axis");
  _id_07F9::_id_A8B1(var_2._id_A908, 0);
  var_2._id_970A = 0;
  _id_07F9::_id_A89A(var_2._id_A908, 0);
  _id_07F9::_id_FB8F(var_2._id_A908, "icon_waypoint_hq_friendly");
  _id_07F9::_id_FB98(var_2._id_A908, 6);
  var_2._id_970A = 1;
  level._id_7346._id_1FE7._id_9B4D = var_2;
  level._id_F935[level._id_F935.size] = var_2;
  var_2 = _id_07D6::_id_4026(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  _id_07F9::_id_FB96(var_2._id_A908, "axis");
  _id_07F9::_id_A8C8(var_2._id_A908, "allies");
  _id_07F9::_id_A8B1(var_2._id_A908, 0);
  var_2._id_970A = 0;
  _id_07F9::_id_A89A(var_2._id_A908, 0);
  _id_07F9::_id_FB8F(var_2._id_A908, "icon_waypoint_hq_enemy");
  _id_07F9::_id_FB98(var_2._id_A908, 7);
  var_2._id_970A = 1;
  level._id_7346._id_1FE7._id_541F = var_2;
  level._id_F935[level._id_F935.size] = var_2;
  var_1 = level._id_7346._id_1512.trigger.origin;
  var_2 = _id_07D6::_id_4026(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  _id_07F9::_id_FB96(var_2._id_A908, "allies");
  _id_07F9::_id_A8C8(var_2._id_A908, "allies");
  _id_07F9::_id_A8B1(var_2._id_A908, 0);
  var_2._id_970A = 0;
  _id_07F9::_id_A89A(var_2._id_A908, 0);
  _id_07F9::_id_FB8F(var_2._id_A908, "icon_waypoint_hq_friendly");
  _id_07F9::_id_FB98(var_2._id_A908, 6);
  var_2._id_970A = 1;
  level._id_7346._id_1512._id_9B4D = var_2;
  level._id_F935[level._id_F935.size] = var_2;
  var_2 = _id_07D6::_id_4026(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  _id_07F9::_id_FB96(var_2._id_A908, "allies");
  _id_07F9::_id_A8C8(var_2._id_A908, "axis");
  _id_07F9::_id_A8B1(var_2._id_A908, 0);
  var_2._id_970A = 0;
  _id_07F9::_id_A89A(var_2._id_A908, 0);
  _id_07F9::_id_FB8F(var_2._id_A908, "icon_waypoint_hq_enemy");
  _id_07F9::_id_FB98(var_2._id_A908, 7);
  var_2._id_970A = 1;
  level._id_7346._id_1512._id_541F = var_2;
  level._id_F935[level._id_F935.size] = var_2;
  level._id_E377 = [];
  level._id_E377["allies"] = vectornormalize(level._id_7346._id_1FE7.trigger.origin - level._id_7346._id_1512.trigger.origin);
  level._id_E377["axis"] = vectornormalize(level._id_7346._id_1512.trigger.origin - level._id_7346._id_1FE7.trigger.origin);
}

_id_E36C() {
  self endon("disconnect");

  if(self.team == "allies") {
    _id_07F9::_id_A89D(level._id_7346._id_1512._id_9B4D._id_A908, self);
    _id_07F9::_id_A89D(level._id_7346._id_1FE7._id_541F._id_A908, self);
  } else {
    _id_07F9::_id_A89D(level._id_7346._id_1512._id_541F._id_A908, self);
    _id_07F9::_id_A89D(level._id_7346._id_1FE7._id_9B4D._id_A908, self);
  }

  while(self._id_82F2) {
    waitframe();
  }

  if(self.team == "axis") {
    _id_07F9::_id_A89E(level._id_7346._id_1512._id_541F._id_A908, self);
  } else {
    _id_07F9::_id_A89E(level._id_7346._id_1FE7._id_541F._id_A908, self);
  }
}

_id_A891() {
  scripts\mp\gametypes\obj_dom::_id_4D47();

  if(!istrue(self._id_FC53)) {
    _id_FC69();
    self._id_FC53 = 1;
  }
}

_id_A893(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4C(var_0);

  if(istrue(self._id_FC53)) {
    _id_FC69();
    self._id_FC53 = 0;
  }
}

_id_A896(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D50(var_0);
  _id_FC69();
}

_id_A897(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::_id_4D51(var_0, var_1, var_2);
  _id_FC69();
}

_id_A895(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4F(var_0);
  _id_FC69();
}

_id_A898(var_0, var_1, var_2, var_3) {}

_id_A892(var_0) {
  _id_FC69();
  scripts\mp\gametypes\obj_dom::_id_4D4E(var_0);
}

_id_A894(var_0) {
  _id_FC69();
  scripts\mp\gametypes\obj_dom::_id_4D4E(var_0);
}

_id_4D40() {}

_id_CA68(var_0, var_1) {
  level endon("game_ended");

  while(!isDefined(level._id_E371)) {
    waitframe();
  }

  var_0._id_CD99 = var_0._id_A90E;
  var_2 = scripts\mp\gametypes\obj_dom::_id_D896(var_0, undefined, undefined, undefined, 0);
  var_2.origin = var_0.origin;
  var_2 _id_07D6::_id_15DF("enemy");
  var_2._id_497A = 0;
  var_2 _id_07D6::_id_D639(var_1);
  var_3 = "any";

  if(var_1 != "neutral") {
    if(level._id_78F7) {
      var_3 = "friendly";
    }

    var_2._id_3235 = gettime();
  }

  var_2 _id_07D6::_id_D8E0(var_3);
  return var_2;
}

_id_5028(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airdrop::_id_500C(var_2, var_0, var_1.origin, (0, randomint(360), 0), undefined);
  return var_3;
}

_id_4C53(var_0, var_1, var_2) {
  var_3 = var_1.origin + (0, 0, 2000);
  var_4 = scripts\common\utility::groundpos(var_3, (0, 0, 1));
  var_1._id_103BE = spawn("script_model", var_4);
  var_1._id_103BE setModel("tag_origin");
  var_1._id_103BE.angles = (0, 0, 0);
  var_1._id_103BE playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var_1._id_103BE, "tag_origin");

  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::_id_108A7(var_2, "crate_dropped");
  } else {
    wait(var_2);
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var_1._id_103BE, "tag_origin");
  var_1._id_103BE delete();
}

_id_10DD(var_0) {
  level._id_8DDB[var_0] = ::scripts\engine\utility::array_randomize(level._id_8DDB[var_0]);

  foreach(var_2 in level._id_8DDB[var_0]) {
    level._id_8DE0[level._id_8DE0.size] = var_2;
  }
}

_id_502C(var_0) {
  level._id_0F6D._id_13A5[var_0] = ::scripts\engine\utility::array_randomize(level._id_0F6D._id_13A5[var_0]);

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = level._id_0F6D._id_13A5[var_0][var_1];

    if(isDefined(var_2)) {
      var_2._id_88D2 = 0;
      level thread _id_CA48(var_2.origin, var_0);
      wait(randomfloatrange(1.5, 2.5));
    }
  }
}

_id_C2C4() {
  scripts\cp_mp\killstreaks\airdrop::_id_8272();
  level._id_FF60 = spawnStruct();
  level._id_FF60._id_3A0B = scripts\engine\utility::getStructArray("dropBagCluterNode", "script_noteworthy");
  var_0 = scripts\engine\utility::getStructArray("dropBagLocation", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2._id_84EF = 0;

    foreach(var_4 in level._id_FF60._id_3A0B) {
      if(var_2.target == var_4._id_0481) {
        if(!isDefined(var_4._id_503C)) {
          var_4._id_503C = [];
        }

        var_4._id_503C[var_4._id_503C.size] = var_2;
        continue;
      }
    }
  }

  level._id_A4AA = 100;

  if(0) {
    thread _id_44A6();
  }
}

_id_44A6() {
  for(;;) {
    _id_35DC();
    wait 1;
  }
}

_id_3525(var_0) {
  if(game["teamScores"][var_0] >= level._id_A4AA) {
    level._id_A4AA = level._id_A4AA + 100;
    _id_503A(2);
  }
}

_id_503A(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      var_1 = var_3;
      break;
    }
  }

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = _id_35DC();
    thread _id_CA48(var_6, var_1, _id_6ADA(1));
    wait 5;
  }
}

_id_35DC() {
  var_0 = randomfloatrange(0, 1.0);
  var_1 = _func_025E(level._id_2E3B._id_E715, level._id_2E3B._id_5340, var_0);
  var_2 = _func_025E(level._id_2E3C._id_5340, level._id_2E3C._id_E715, var_0);
  var_3 = _func_025E(var_1, var_2, 0.5);
  var_4 = scripts\engine\trace::ray_trace(var_3, var_3 - (0, 0, 100000));
  var_3 = var_4["position"];
  var_5 = _id_5AE5(var_3);

  if(0) {
    _id_44FE(var_1, (0, 0, 1), 100);
    _id_44FE(var_2, (0, 0, 1), 100);
    _id_44FE(var_3, (1, 0, 0), 100);
    _id_44FE(var_5.origin, (0, 1, 0), 100);
    thread scripts\mp\utility\debug::_id_4F43(var_3, var_5.origin, 3, (0, 1, 0));
  }

  return var_5;
}

_id_5AE5(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_2 = var_1 scripts\engine\utility::_id_1BD6(level._id_FF60._id_3A0B, ::_id_E034);

  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::array_randomize(var_4._id_503C);

    if(0) {
      return var_5[0];
    } else {
      foreach(var_7 in var_5) {
        if(!var_7._id_84EF) {
          var_7._id_84EF = 1;
          return var_7;
        }
      }
    }
  }

  return undefined;
}

_id_3608() {
  var_0 = randomfloatrange(level._id_9AC4[1][0], level._id_9AC4[0][0]);
  var_1 = randomfloatrange(level._id_9AC4[1][1], level._id_9AC4[0][1]);
  var_2 = (var_0, var_1, 100000);
  var_3 = scripts\engine\trace::ray_trace(var_2, var_2 - (0, 0, 100000));
  var_2 = var_3["position"];
  var_4 = _id_5AE5(var_2);

  if(0) {
    _id_44FE(var_2, (1, 0, 0), 100);
    _id_44FE(var_4.origin, (0, 1, 0), 100);
    thread scripts\mp\utility\debug::_id_4F43(var_2, var_4.origin, 3, (0, 1, 0));
  }

  return var_4;
}

_id_CA48(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = undefined;
  var_4 = _id_07D6::_id_4026(var_0.origin, "neutral", (0, 0, 72), undefined, "any");
  var_4.origin = var_0.origin;
  var_4.angles = var_0.angles;
  thread _id_4C53(undefined, var_0, 16);
  var_4._id_7C73 = "_incoming";
  var_4._id_970A = 0;
  var_4 _id_07D6::_id_D61B(var_2);
  var_4._id_970A = 1;
  wait 4;
  var_3 = scripts\cp_mp\killstreaks\airdrop::_id_500C(var_1.team, var_2, var_0.origin, (0, randomint(360), 0), undefined);
  var_3._id_DDB4 = 1;
  var_3._id_A443 = 0;
  var_3._id_10813 = 1;
  var_3._id_8D8A = 0;
  var_3._id_4B06 = 1;
  var_3._id_8760 = 1;
  var_3 waittill("crate_dropped");
  var_4._id_FE90 = var_3;
  var_4.origin = var_3.origin;
  var_5 = 0;
  var_6 = 0.1;
  wait 1;
  var_3 notify("objective_activate");
  _id_07F9::_id_FB93(var_4._id_A908, var_3);
  _id_07F9::_id_FB9D(var_4._id_A908, 72);
  var_4._id_7C73 = "";
  var_4._id_970A = 0;
  var_4 _id_07D6::_id_D61B(var_2);
  var_4._id_970A = 1;
  _func_0167(var_4._id_A908, "");
  var_3 waittill("death");
  var_4 _id_07D6::_id_D8E0("none");
  var_4 _id_07D6::_id_C300();
  var_4._id_1041A = "none";
}

_id_6ADA(var_0) {
  if(!isDefined(level._id_8DE8)) {
    _id_BD72();
  }

  level._id_8DE8[var_0] = ::scripts\engine\utility::array_randomize(level._id_8DE8[var_0]);
  return level._id_8DE8[var_0][0];
}

_id_BD72() {
  level._id_8DE8 = [];
  level._id_8DE8[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level._id_8DE8[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level._id_8DE8[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level._id_8DE8[0] = ["uav"];
}

_id_2A4A(var_0) {
  return level._id_8DD5._id_EA18._id_EC74[var_0]["hudIcon"];
}

_id_A704() {
  _id_07D1::_id_60C2("prematch_done");

  if(istrue(level._id_FE94)) {
    level thread _id_A705();
  }
}

_id_A705() {
  level endon("game_ended");
  level endon("mercy_ending_timer_started");

  for(;;) {
    if(_id_2EF1("axis") == level._id_A8E8.size) {
      level thread _id_A71A("axis");
    } else if(_id_2EF1("allies") == level._id_A8E8.size) {
      level thread _id_A71A("allies");
    }

    waitframe();
  }
}

_id_A71A(var_0) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  setomnvar("ui_nuke_timer_type", 1);
  setomnvar("ui_arm_dominatingTeam", scripts\engine\utility::ter_op(var_0 == "axis", 1, 2));
  setomnvar("ui_nuke_timer_time", level._id_9DDA);
  setomnvar("ui_nuke_countdown_active", 1);
  var_1 = 0;
  var_2 = gettime();
  var_3 = level._id_9DDA * 1000 + var_2;
  setomnvar("ui_nuke_end_milliseconds", level._id_9DDA * 1000 + var_2);

  while(_id_2EF1(var_0) == level._id_A8E8.size) {
    waitframe();

    if(gettime() > var_3) {
      _id_A721(var_0);
      level notify("mercy_ending_triggered");
    }
  }

  setomnvar("ui_nuke_countdown_active", 0);
  level thread _id_A705();
}

_id_A721(var_0) {
  level endon("game_ended");
  level._id_9DDC = 1;
  level._id_259B = 1;

  foreach(var_2 in level._id_A8E8) {
    var_2 _id_07D6::_id_15DF("none");
  }

  setomnvar("ui_nuke_countdown_active", 0);

  foreach(var_5 in level.players) {
    if(isDefined(var_5) && !isbot(var_5) && istrue(var_5._id_82F2)) {
      if(isDefined(var_5._id_AC43)) {
        var_5 _meth_8680("mp_spawn_camera");
        var_5._id_AC43 stoploopsound(var_5._id_AC44);
        var_5._id_AC43 delete();
        var_5._id_AC43 = undefined;
        var_5._id_AC44 = undefined;
      }
    }
  }

  if(isDefined(level._id_EF6A[var_0]["alivePlayers"][0])) {
    var_7 = level._id_EF6A[var_0]["alivePlayers"][0];
    var_7 _id_0A56::_id_F795();
  } else
    level thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
}

_id_A742(var_0) {
  if(!istrue(var_0._id_758D)) {
    var_1 = var_0._id_8D6F % level._id_8DA6;

    if(var_1 >= 0 && var_0._id_8D6F >= level._id_8DA6) {
      var_0._id_758D = 1;
      var_0 thread scripts\mp\killstreaks\killstreaks::givekillstreak("nuke_select_location", 0, 0, var_0);
      var_0 scripts\mp\hud_message::_id_DCBD("nuke_select_location", undefined, 1);
    }
  }
}

_id_8294() {
  level._id_60D6 = [];
  var_0 = "mp_gw_spawn_allies_start";
  var_1 = "mp_gw_spawn_axis_start";
  level._id_60D6["allies"] = var_0;
  level._id_60D6["axis"] = var_1;
  level._id_60D5 = [];
  level._id_60D5["allies"] = "mp_tdm_spawn";
  level._id_60D5["axis"] = "mp_tdm_spawn";
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);

  if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_aniyah") {
    _id_0817::_id_D461("GroundWarTTLOS", "Crit_Default");
  } else if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    _id_0817::_id_D461("GroundWar", "Crit_Default");
  } else {
    _id_0817::_id_D461("Default", "Crit_Default");
  }

  _id_0817::_id_113A("mp_gw_spawn_allies_start");
  _id_0817::_id_113A("mp_gw_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_gw_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_gw_spawn_axis_start");
  var_2 = _id_0817::_id_6D4E("mp_gw_spawn_allies_start");
  var_3 = _id_0817::_id_6D4E("mp_gw_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_2);
  _id_0817::_id_C2B9("start_defenders", var_3);
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_4 = _id_0817::_id_6D4E("mp_tdm_spawn");
  var_5 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
  _id_0817::_id_C2B9("normal", var_4);
  _id_0817::_id_C2B9("fallback", var_5);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  level._id_E34D = var_4;
  _id_0817::_id_0EE5();
}

_id_2EFC(var_0) {
  var_0._id_CF35._id_4BB9 = [];

  foreach(var_2 in level._id_A8E8) {
    var_3 = _func_00C4(var_0.origin, var_2.origin, 5000);

    if(var_3 < 0) {
      var_3 = scripts\engine\utility::_id_4B8C(var_0.origin, var_2.origin);
    } else {
      var_3 = var_3 * var_3;
    }

    var_0._id_CF35._id_4BB9[var_2 getentitynumber()] = var_3;

    if(var_3 > var_2._id_6041) {
      var_2._id_6041 = var_3;
    }
  }
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
    } else {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
    }
  } else
    var_1 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");

  if(istrue(level._id_FED1) && istrue(self._id_E4AB)) {
    var_2 = self getspectatingplayer();

    if(isDefined(var_2) && isDefined(self._id_E496) && self.team == var_2.team && self._id_E496 == var_2._id_E496) {
      var_1 = _id_0818::_id_5B07(var_2);
    }
  }

  return var_1;
}

_id_ABA4() {
  self._id_5EC6 = undefined;
  thread _id_FCC2();
  _id_07F2::_id_FD3F(self.team, self._id_E496);
}

_id_FCC2() {
  level endon("game_ended");

  if(isDefined(level._id_A73F)) {
    self setclientomnvar("ui_match_status_hint_text", 28);
  } else {
    self setclientomnvar("ui_match_status_hint_text", 27);
  }
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_07F2::_id_FD3F(self.team, self._id_E496);
  scripts\mp\gametypes\obj_dom::_id_1FC6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(level._id_A741 && isPlayer(var_1) && var_3 != "MOD_SUICIDE") {
    if(!isDefined(var_1._id_8D6F)) {
      var_1._id_8D6F = 0;
    }

    if(!istrue(var_1._id_758D)) {
      var_1._id_8D6F++;
    }

    _id_A742(var_1);
  }

  if(!isDefined(level._id_2E39) || level._id_2E38 != 1) {
    return;
  }
  level._id_2E39[self.team] = level._id_2E39[self.team] + 1;
}

_id_9A1A(var_0) {
  if(!isDefined(level._id_2A3B)) {
    level._id_2A3B = [];
  }

  if(level._id_2A3B.size > 64) {
    for(var_1 = 0; var_1 < 16; var_1++) {
      if(isDefined(level._id_2A3B[var_1])) {
        level._id_2A3B[var_1] delete();
        level._id_2A3B[var_1] = undefined;
      }
    }

    var_2 = [];

    for(var_1 = 16; var_1 < level._id_2A3B.size; var_1++) {
      var_2[var_1 - 16] = level._id_2A3B[var_1];
    }

    level._id_2A3B = var_2;
  }

  foreach(var_4 in var_0) {
    level._id_2A3B[level._id_2A3B.size] = var_4;
  }

  if(!isDefined(level._id_2A95._id_5048)) {
    level._id_2A95._id_5048 = [];
  }

  if(level._id_2A95._id_5048.size > 64) {
    for(var_1 = 0; var_1 < 16; var_1++) {
      if(isDefined(level._id_2A95._id_5048[var_1])) {
        level._id_2A95._id_5048[var_1] delete();
        level._id_2A95._id_5048[var_1] = undefined;
      }
    }

    var_2 = [];

    for(var_1 = 16; var_1 < level._id_2A95._id_5048.size; var_1++) {
      var_2[var_1 - 16] = level._id_2A95._id_5048[var_1];
    }

    level._id_2A95._id_5048 = var_2;
  }
}

onplayerconnect(var_0) {
  if(isDefined(level._id_BFC9)) {
    thread _id_0808::_id_BFC1(var_0);
  }

  if(istrue(level._id_FEA7)) {
    var_0 _id_078A::_id_2F99();
  }

  _id_0A8E::_id_C285(::_id_AB63);
}

_id_AB63(var_0) {
  thread _id_0819::_id_C1AD(var_0.team, var_0._id_E496);
}

_id_FC79() {
  var_0 = "lane02_4";

  if(isDefined(level._id_0F6D)) {
    var_0 = level._id_0F6D._id_110ED._id_CD99;
  }

  _id_0815::_id_D572("allies", level._id_E278[var_0]["allies"]);
  _id_0815::_id_D572("axis", level._id_E278[var_0]["axis"]);
}

_id_44C6() {
  for(;;) {
    wait 0.25;

    if(!isDefined(level.players[0])) {
      continue;
    }
    foreach(var_5, var_1 in level._id_E278) {
      foreach(var_4, var_3 in var_1) {
        thread scripts\mp\utility\debug::_id_4F32(var_3.origin, var_3.angles, 0.25, 50);
        thread scripts\mp\utility\debug::_id_4F48(var_3.origin, 50.0, 0.25, scripts\engine\utility::ter_op(var_4 == "allies", (0, 0, 1), (1, 0, 0)));
      }
    }
  }
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");
  }
}

_id_6C03(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

_id_6CEF() {
  self._id_E279 = 0;
  return undefined;
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_8296() {
  level._id_E3EA = [];
  level._id_41F3 = "cop_2";
  var_0 = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

    foreach(var_6 in var_4) {
      switch (var_6._id_CD99) {
        case "to_allies_camera":
          _id_D714(var_3, "allies", var_6);
          break;
        case "to_axis_camera":
          _id_D714(var_3, "axis", var_6);
          break;
      }
    }
  }
}

_id_D714(var_0, var_1, var_2) {
  if(!isDefined(level._id_E3EA[var_0])) {
    level._id_E3EA[var_0] = [];
  }

  level._id_E3EA[var_0][var_1] = var_2;
}

_id_19EE() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self _meth_840B();
}

_id_C533() {
  self _meth_840A();
}

_id_E727() {
  if(scripts\mp\utility\game::_id_8A95()) {
    return;
  }
  waitframe();
  scripts\mp\utility\player::_id_FD26("spectator");
  _id_081A::_id_D512();

  if(isDefined(self._id_8FB8)) {
    self setplayerangles(self._id_8FB8);
  }

  wait 0.1;
  scripts\mp\utility\player::_id_D51E();
  var_0 = 0;
  var_1 = undefined;
  var_2 = (0, 0, 0);
  var_3 = 1000;
  var_4 = self.origin + (0, 0, var_3);
  var_5 = self.angles;
  self._id_4411 = var_4;
  self._id_4410 = var_5;
  var_6 = spawn("script_model", self getvieworigin());
  var_6 setModel("tag_origin");
  var_6.angles = var_5;
  self._id_E3E9 = var_6;
  self._id_8AD7 = 1;
  self cameralinkto(var_6, "tag_origin", 1);
  thread _id_4CF1();
  var_6 _id_A227(self, var_4, var_5);
}

_id_4CF1() {
  wait 0.4;
  thread _id_B8DB();
  _id_19EE();
}

_id_534B() {
  if(!isDefined(self._id_E3E9)) {
    return;
  }
  _id_C533();
  thread _id_CA72();
}

_id_A227(var_0, var_1, var_2) {
  var_0 endon("spawned_player");
  var_3 = 1.0;
  var_4 = 1.0;
  self moveto(var_1, 2.0, 1.0, 1.0);
  var_0 _meth_82FD("spawn_cam", 0.5, "mix");
  self rotateto(var_2, 2.0, 1.0, 1.0);
  wait 1.1;
  var_5 = anglesToForward(var_2) * 300;
  var_5 = var_5 * (1, 1, 0);

  if(isDefined(var_0) && isDefined(var_0._id_E3E9)) {
    self moveto(var_1 + var_5, 15.0, 1.0, 1.0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1 + var_5, 1000);
  }
}

_id_CA72() {
  self waittill("spawned_player");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::_id_FD26("spectator");
  self cameralinkto(self._id_E3E9, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self._id_E3E9 moveto(var_0, 0.5);
  self _meth_8078(0.5);
  self._id_E3E9 rotateto(var_1, 0.5, 0.5);
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }
  self visionsetnakedforplayer("", 0);
  thread _id_B8DB();
  scripts\mp\utility\player::_id_FD26("playing");
  self _meth_8060();
  self._id_E3E9 delete();
}

_id_B8DB() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0._id_01D6 = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

_id_1B15(var_0, var_1) {
  var_2 = "dx_mpa_ustl_" + var_0;
  var_2 = tolower(var_2);
  var_3 = undefined;

  if(var_1 == "bothTeams") {
    var_4 = scripts\mp\utility\teams::_id_6DCA("axis", "players");
    var_5 = scripts\mp\utility\teams::_id_6DCA("allies", "players");
    var_3 = scripts\engine\utility::array_combine(var_4, var_5);
  } else if(var_1 == "axis" || var_1 == "allies")
    var_3 = scripts\mp\utility\teams::_id_6DCA(var_1, "players");

  foreach(var_7 in var_3) {
    if(!isbot(var_7)) {
      var_7 _id_1B13(var_2, var_0);
    }
  }
}

_id_1B16(var_0) {
  var_1 = "dx_mpa_ustl_announcer_" + var_0;
  var_1 = tolower(var_1);
  _id_1B13(var_1, var_0);
}

_id_1B13(var_0, var_1) {
  if(isDefined(self._id_B705)) {
    var_2 = 5000;

    if(gettime() < self._id_B705["time"] + var_2 && self._id_B705["dialog"] == var_1) {
      return;
    }
    self._id_B705["time"] = gettime();
    self._id_B705["dialog"] = var_1;
  }

  if(_func_0205(var_0)) {
    self _meth_8287(var_0, var_1, 2);
  }
}

_id_9A16() {
  level endon("game_ended");
  var_0 = 6000;
  var_1 = 12000;
  var_2 = 20000;
  var_3 = 1;
  var_4 = (0, 0, 6000);
  level._id_F206 = 0;
  level._id_5CF5 = 20;
  level._id_E270 = [];

  foreach(var_6 in level._id_EF89) {
    level._id_E270[var_6] = undefined;
  }

  _id_2E19();
  level._id_E270["axis"] = _id_3FA0("axis", level._id_2E3B._id_E715 + var_4);
  level._id_E270["allies"] = _id_3FA0("allies", level._id_2E3C._id_E715 + var_4);

  while(!isDefined(level._id_E371)) {
    waitframe();
  }

  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    if(!isDefined(level._id_F284)) {
      level._id_F284 = [];
    }

    if(!isDefined(level._id_F284["axis"])) {
      level._id_F284["axis"] = 0;
    }

    if(!isDefined(level._id_F284["allies"])) {
      level._id_F284["allies"] = 0;
    }

    var_8 = gettime() + (level._id_5CF5 + level._id_F206) * 1000;
    level._id_F284["axis"] = var_8;
    level._id_F284["allies"] = var_8;

    if(0) {
      thread scripts\mp\utility\debug::_id_4F43(level._id_2E3B._id_E715, level._id_2E3B._id_5340, 1000, (1, 0, 0));
      thread scripts\mp\utility\debug::_id_4F43(level._id_2E3C._id_E715, level._id_2E3C._id_5340, 1000, (0, 0, 1));
    }

    if(var_3) {
      level._id_E270["axis"] thread _id_7426(level._id_2E3B._id_E715 + var_4, level._id_2E3B._id_5340 + var_4, level._id_5CF5, "axis");
      level._id_E270["allies"] thread _id_7426(level._id_2E3C._id_E715 + var_4, level._id_2E3C._id_5340 + var_4, level._id_5CF5, "allies");
    } else {
      level._id_E270["axis"] thread _id_7426(level._id_2E3B._id_E715, level._id_2E3B._id_5340, level._id_5CF5, "axis");
      level._id_E270["allies"] thread _id_7426(level._id_2E3C._id_E715, level._id_2E3C._id_5340, level._id_5CF5, "allies");
    }

    level._id_2E31 = 1;
    level scripts\engine\utility::_id_10879(["C130_path_complete_axis", "C130_path_complete_allies"]);
    _id_2E11();
    var_9 = level._id_2E3B._id_E715;
    level._id_2E3B._id_E715 = level._id_2E3B._id_5340;
    level._id_2E3B._id_5340 = var_9;
    var_9 = level._id_2E3C._id_E715;
    level._id_2E3C._id_E715 = level._id_2E3C._id_5340;
    level._id_2E3C._id_5340 = var_9;
    var_3 = 0;

    if(istrue(level._id_FE2E)) {
      level._id_FE2D = 0;
      break;
    }
  }

  _id_0819::_id_C496("axis", "dynamic_c130");
  _id_0819::_id_C496("allies", "dynamic_c130");
  _id_0819::_id_C521("dynamic_c130", "axis");
  _id_0819::_id_C521("dynamic_c130", "allies");
  level._id_E270["axis"] delete();
  level._id_E270["allies"] delete();
}

_id_3FA0(var_0, var_1) {
  var_2 = spawn("script_model", var_1);
  var_2 setModel("veh8_mil_air_acharlie130");
  var_2 setCanDamage(0);
  var_2.maxhealth = 100000;
  var_2.health = var_2.maxhealth;
  var_2._id_B72B = [(32, 30, 0), (-32, 30, 0), (0, 30, 0), (16, 30, 0), (-16, 30, 0)];
  var_2._id_41E2 = 0;
  var_2._id_C6C3 = [];
  var_2.players = [];
  var_2.team = var_0;
  var_2 playLoopSound("iw8_ks_ac130_lp");
  var_2 thread scripts\mp\gametypes\br_c130::_id_72F8();
  return var_2;
}

_id_7426(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = distance(var_1, var_0);
  var_6 = var_0 + var_4 * var_5 * 0.425;
  var_7 = var_0 + var_4 * var_5 * 0.55;
  var_8 = var_2 * 0.3;
  var_9 = var_2 * 0.6;
  var_10 = var_2 * 0.1;
  self._id_318D = 1;
  self._id_31A7 = 0;
  var_11 = vectornormalize(var_1 - var_0);
  self.angles = vectortoangles(var_11);
  self.origin = var_0;
  _id_620F();
  self moveto(var_1, var_8 + var_9 + var_10, var_8 * 0.25);
  wait(var_8);
  self._id_31A7 = 1;

  foreach(var_13 in self.players) {
    var_13 notify("canParachute");
  }

  wait(var_9);
  self._id_318D = 0;
  self._id_31A7 = 0;

  foreach(var_13 in self.players) {
    var_13 notify("halo_kick_c130");
  }

  wait(var_10);
  level notify("C130_path_complete_" + var_3);
}

_id_620F() {
  self.players = scripts\engine\utility::array_combine(self.players, self._id_C6C3);
  self._id_C6C3 = [];
  var_0 = 1400;
  var_1 = (30, 0, 0);
  var_2 = anglesToForward(var_1) * var_0 * -1;
  var_3 = self gettagorigin("tag_origin") + var_2;
  var_4 = self.angles;

  foreach(var_6 in self.players) {
    if(!isDefined(var_6)) {
      continue;
    }
    var_6._id_5EC4 = var_3;
    var_6._id_5EC3 = var_4;
    var_6 notify("c130_ready");
  }
}

_id_C4B7(var_0) {
  wait(var_0);
  _id_C4B6();
}

_id_C4B6() {
  _id_0819::_id_C496(self.team, "dynamic_c130");
  _id_0819::_id_C521("dynamic_c130", self.team);
}

_id_E33E() {
  self endon("disconnect");

  if(!isDefined(level._id_E270[self.team])) {
    return;
  }
  self waittill("spawn_camera_idle");
  var_0 = level._id_E270[self.team];
  var_0._id_C6C3[var_0._id_C6C3.size] = self;

  if(istrue(var_0._id_318D)) {
    var_0 _id_620F();
  }

  if(istrue(self._id_82F0)) {
    self waittill("spawn_camera_complete");
  } else {
    self waittill("spawned_player");
  }

  scripts\common\utility::_id_154F(0);
  self disableusability();
  self disableoffhandweapons();
  self allowmelee(0);
  self allowads(0);
  self allowfire(0);
  self setCanDamage(0);
  thread _id_8CA2(var_0, 0);
  self._id_2A5E = "c130";

  if(!isbot(self)) {
    thread scripts\mp\gametypes\br_c130::_id_AC5E(var_0);
  }
}

_id_8CA2(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("jumpListener()");
  self endon("jumpListener()");

  if(isDefined(self._id_AE18)) {
    self._id_AE18 delete();
  }

  self._id_2E0E = var_0;
  thread _id_954F(var_0, var_1);
  thread _id_9550(var_0, var_1);
}

_id_9550(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenKick()");
  self endon("listenKick()");
  self waittill("halo_kick_c130");
  self cameradefault();
  self unlink();
  wait 0.1;

  if(self.sessionstate == "spectator") {
    return;
  }
  var_2 = var_0 scripts\mp\gametypes\br_helicopters::_id_2EC6();
  thread _id_AE18(var_0, var_1);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

_id_954F(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("br_jump");
  self notify("listenJump()");
  self endon("listenJump()");
  self notifyonplayercommand("halo_jump_c130", "+gostand");

  for(;;) {
    var_2 = scripts\engine\utility::_id_108C5("halo_jump_c130", "canParachute");

    if(isDefined(var_2) && var_2 == "canParachute") {
      self iprintlnbold("Press Jump to Parachute!");
    } else if(!istrue(var_0._id_31A7)) {
      self iprintlnbold("Not over the AO");
    } else {
      break;
    }

    if(self.sessionstate == "spectator") {
      return;
    }
  }

  self cameradefault();
  self unlink();
  wait 0.1;
  thread _id_AE18(var_0, var_1);
  self notify("br_jump");
  self notify("stop_cam_shake");
}

_id_AE18(var_0, var_1) {
  self endon("jumpListener()");
  self notify("parachute()");
  self endon("parachute()");

  if(self.team == "axis") {
    var_2 = level._id_2E3C._id_9E8E;
  } else {
    var_2 = level._id_2E3B._id_9E8E;
  }

  var_3 = vectornormalize(var_2 - var_0.origin);
  var_0.players = scripts\engine\utility::array_remove(var_0.players, self);

  if(isDefined(var_0._id_B72B) && isDefined(var_0._id_41E2)) {
    var_4 = var_0._id_B72B[var_0._id_41E2];
    self setorigin(var_0.origin + var_4, 1, 1);
    var_0._id_41E2++;

    if(var_0._id_41E2 == var_0._id_B72B.size) {
      var_0._id_41E2 = 0;
    }
  } else {
    var_5 = anglesToForward(var_0.angles) * var_0._id_2ACC;
    self setorigin(var_0.origin + var_5, 1, 1);
  }

  waitframe();
  self playershow();
  self._id_B928 = 0;
  self._id_2E0E = undefined;
  self setplayerangles(vectortoangles(var_3));
  thread _id_0797::_id_E6AD(5.0, 0);
}

_id_447D() {
  wait 10;

  for(;;) {
    _id_2E19();
    level._id_2E3B._id_E715 = level._id_2E3B._id_E715 - (0, 0, 10000);
    level._id_2E3B._id_5340 = level._id_2E3B._id_5340 - (0, 0, 10000);
    level._id_2E3C._id_E715 = level._id_2E3C._id_E715 - (0, 0, 10000);
    level._id_2E3C._id_5340 = level._id_2E3C._id_5340 - (0, 0, 10000);
    thread scripts\mp\utility\debug::_id_4F43(level._id_2E3B._id_E715, level._id_2E3B._id_5340, 1, (1, 0, 1));
    thread scripts\mp\utility\debug::_id_4F43(level._id_2E3C._id_E715, level._id_2E3C._id_5340, 1, (1, 0, 1));
    wait 1;
  }
}

_id_2E19() {
  if(istrue(level._id_2E2D) && istrue(level._id_FE94)) {
    var_0 = (level._id_7346._id_1FE7.trigger.origin + level._id_7346._id_1512.trigger.origin) * 0.5;
    var_1 = vectortoangles(level._id_7346._id_1FE7.trigger.origin - level._id_7346._id_1512.trigger.origin);
    var_2 = var_1[1];

    if(0) {
      _id_44FE(var_0, (0, 1, 0), 100000);
    }
  } else {
    var_0 = (level._id_9AC4[0] + level._id_9AC4[1]) * 0.5;
    var_2 = randomfloatrange(0, 359);
  }

  var_3 = _id_99DF(var_0, var_2 - 90);
  level._id_2E3B = scripts\mp\gametypes\br_c130::_id_99FE(var_3);
  var_3._id_BFF4 = var_3._id_BFF4 + 180;
  level._id_2E3C = scripts\mp\gametypes\br_c130::_id_99FE(var_3);
  var_4 = 0.2;
  var_5 = 0;
  var_6 = 0;

  if(istrue(level._id_2E3D)) {
    var_4 = 0.1;
    var_5 = randomfloatrange(-5000.0, 5000);
    var_6 = randomfloatrange(-5000.0, 5000);
  }

  var_7 = anglestoright(level._id_2E3B._id_1784);
  level._id_2E3B._id_E715 = var_7 * level._id_2E30 + level._id_2E3B._id_E715;
  level._id_2E3B._id_5340 = var_7 * level._id_2E30 + level._id_2E3B._id_5340;
  var_7 = anglestoright(level._id_2E3C._id_1784);
  level._id_2E3C._id_E715 = var_7 * level._id_2E30 + level._id_2E3C._id_E715;
  level._id_2E3C._id_5340 = var_7 * level._id_2E30 + level._id_2E3C._id_5340;
  var_8 = (var_5, var_6, 0);
  level._id_2E3B._id_E715 = level._id_2E3B._id_E715 + var_8;
  level._id_2E3B._id_5340 = level._id_2E3B._id_5340 + var_8;
  level._id_2E3B._id_9E8E = _func_025E(level._id_2E3B._id_E715, level._id_2E3B._id_5340, 0.5);
  level._id_2E3C._id_E715 = level._id_2E3C._id_E715 + var_8;
  level._id_2E3C._id_5340 = level._id_2E3C._id_5340 + var_8;
  level._id_2E3C._id_9E8E = _func_025E(level._id_2E3C._id_E715, level._id_2E3C._id_5340, 0.5);
  level._id_2358 = _func_025E(level._id_2E3B._id_9E8E, level._id_2E3C._id_9E8E, 0.5);
  level._id_2E37 = _func_025E(level._id_2E3B._id_E715, level._id_2E3C._id_5340, var_4);
  level._id_2E37 = level._id_2E37 - level._id_2E3B._id_E715;
  level._id_2E37 = vectornormalize(level._id_2E37) * level._id_2E30 / 10;
  level._id_2E37 = (level._id_2E37[0], level._id_2E37[1], 0);
}

_id_99DF(var_0, var_1) {
  var_2 = 6.28318;
  var_3 = var_1;
  var_4 = 180;
  var_5 = level._id_2E32;
  var_6 = spawnStruct();
  var_6._id_BEFE = var_5;
  var_6._id_BFF4 = var_3;
  var_6._id_52DE = var_4;
  var_6._id_3392 = var_0;
  return var_6;
}

_id_2E11() {
  if(0) {
    level._id_2E38 = 2;
  }

  if(level._id_2E38 == 0) {
    return;
  } else if(level._id_2E38 == 1) {
    if(0) {
      level._id_2E39["axis"] = 1;
      level._id_2E39["allies"] = 0;
    }

    if(level._id_2E39["axis"] > level._id_2E39["allies"]) {
      if(_id_1B08(level._id_2E37)) {
        level._id_2E3B._id_E715 = level._id_2E3B._id_E715 + level._id_2E37;
        level._id_2E3B._id_5340 = level._id_2E3B._id_5340 + level._id_2E37;
        level._id_2E3C._id_E715 = level._id_2E3C._id_E715 + level._id_2E37;
        level._id_2E3C._id_5340 = level._id_2E3C._id_5340 + level._id_2E37;
      }
    } else if(_id_1B08(level._id_2E37 * -1.0)) {
      level._id_2E3B._id_E715 = level._id_2E3B._id_E715 - level._id_2E37;
      level._id_2E3B._id_5340 = level._id_2E3B._id_5340 - level._id_2E37;
      level._id_2E3C._id_E715 = level._id_2E3C._id_E715 - level._id_2E37;
      level._id_2E3C._id_5340 = level._id_2E3C._id_5340 - level._id_2E37;
    }

    level._id_2E3B._id_9E8E = _func_025E(level._id_2E3B._id_E715, level._id_2E3B._id_5340, 0.5);
    level._id_2E3C._id_9E8E = _func_025E(level._id_2E3C._id_E715, level._id_2E3C._id_5340, 0.5);
    level._id_2E39["axis"] = 0;
    level._id_2E39["allies"] = 0;
  } else if(level._id_2E38 == 2) {
    var_0 = (0, 0, 0);
    var_1 = (0, 0, 0);
    var_2 = 0;
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(isalive(var_5)) {
        if(var_5.team == "axis") {
          var_0 = var_0 + var_5.origin;
          var_2++;
          continue;
        }

        if(var_5.team == "allies") {
          var_1 = var_1 + var_5.origin;
          var_3++;
        }
      }
    }

    if(var_2 == 0 || var_3 == 0) {
      return;
    }
    var_7 = var_0 / var_2;
    var_8 = var_1 / var_3;
    var_9 = _func_025E(var_7, var_8, 0.5);
    level._id_2E37 = _func_025E(level._id_2358, var_9, 0.5);
    level._id_2E37 = level._id_2E37 - level._id_2358;
    var_10 = distance2d(level._id_2358, var_9);
    level._id_2E37 = vectornormalize(level._id_2E37) * var_10 / 4;
    level._id_2E37 = (level._id_2E37[0], level._id_2E37[1], 0);

    if(_id_1B08(level._id_2E37)) {
      level._id_2E3B._id_E715 = level._id_2E3B._id_E715 + level._id_2E37;
      level._id_2E3B._id_5340 = level._id_2E3B._id_5340 + level._id_2E37;
      level._id_2E3B._id_9E8E = _func_025E(level._id_2E3B._id_E715, level._id_2E3B._id_5340, 0.5);
      level._id_2E3C._id_E715 = level._id_2E3C._id_E715 + level._id_2E37;
      level._id_2E3C._id_5340 = level._id_2E3C._id_5340 + level._id_2E37;
      level._id_2E3C._id_9E8E = _func_025E(level._id_2E3C._id_E715, level._id_2E3C._id_5340, 0.5);

      if(0) {
        _id_44FE(level._id_2358, (1, 0, 0), 700);
        _id_44FE(var_9, (0, 1, 0), 700);
      }

      level._id_2358 = level._id_2358 + level._id_2E37;
    }
  }
}

_id_1B08(var_0) {
  return _id_89B9(level._id_2E3B._id_E715 + var_0) && _id_89B9(level._id_2E3B._id_5340 + var_0) && _id_89B9(level._id_2E3C._id_E715 + var_0) && _id_89B9(level._id_2E3C._id_5340 + var_0);
}

_id_89B9(var_0) {
  return var_0[0] < level._id_9AC4[0][0] && var_0[0] > level._id_9AC4[1][0] && var_0[1] < level._id_9AC4[0][1] && var_0[1] > level._id_9AC4[1][1];
}

_id_C2C7(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_C19E = var_0;
  var_3._id_E274 = var_2;
  var_3._id_10353 = [[var_1]]();

  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  level.vehicleinfo[var_0] = var_3;
}

_id_7FA6() {
  level._id_7D38 = 1;
  _id_C2C7("technical", _id_09DB::_id_EFE7, ::_id_1034F);
  _id_C2C7("little_bird", _id_09D7::_id_956E, ::_id_10349);
  _id_C2C7("cop_car", _id_09D1::_id_3D37, ::_id_10342);
  _id_C2C7("atv", _id_09CD::_id_1E4D, ::_id_10340);
  _id_C2C7("cargo_truck", _id_09D0::_id_3282, ::_id_10341);
  _id_C2C7("hoopty", _id_09D2::_id_79FC, ::_id_10344);
  _id_C2C7("hoopty_truck", _id_09D3::_id_7A20, ::_id_10345);
  _id_C2C7("jeep", _id_09D4::_id_8BB8, ::_id_10347);
  _id_C2C7("large_transport", _id_09D5::_id_8ECF, ::_id_10348);
  _id_C2C7("medium_transport", _id_09D8::_id_9CED, ::_id_1034A);
  _id_C2C7("pickup_truck", _id_09D9::_id_B094, ::_id_1034B);
  _id_C2C7("tac_rover", _id_09DA::_id_ECD1, ::_id_1034C);
  _id_C2C7("van", _id_09DC::_id_FF8D, ::_id_10350);
  _id_C2C7("light_tank", _id_09D6::_id_93D1, ::_id_1034D);
  _id_C2C7("apc_russian", _id_09CC::_id_1987, ::_id_1033F);
  level._id_10352 = [];
  level._id_EE52 = [];
  level._id_EE51 = [];

  foreach(var_1 in level.vehicleinfo) {
    if(var_1._id_C19E == "light_tank" && level.mapname == "mp_downtown_gw" && level._id_96CC == "locale_6") {
      var_2 = [];
      var_3 = [];
      var_2[0] = (17465, -21971, -150);
      var_3[0] = (10, 90, 0);
      var_2[1] = (16460, -22045, -150);
      var_3[1] = (358, 26, 0);
      var_4 = 0;
      var_5 = [];
      var_6 = [];
      var_5[0] = (19430, -2396, -380);
      var_6[0] = (7, 315, 0);
      var_5[1] = (21100, -2356, -380);
      var_6[1] = (7, 219, 0);
      var_7 = 0;

      foreach(var_9 in var_1._id_10353) {
        if(isDefined(var_9._id_039B) && var_9._id_039B == "locale_6") {
          if(isDefined(var_9._id_CE7D) && var_9._id_CE7D == "axis") {
            var_9.origin = var_2[var_4];
            var_9.angles = var_3[var_4];
            var_4++;
            continue;
          }

          if(isDefined(var_9._id_CE7D) && var_9._id_CE7D == "allies") {
            var_9.origin = var_5[var_7];
            var_9.angles = var_6[var_7];
            var_7++;
          }
        }
      }
    }

    if(var_1._id_C19E == "atv") {
      if(level.mapname == "mp_farms2_gw" && level._id_96CC == "locale_9") {
        var_11 = [];
        var_12 = [];
        var_11[0] = (46022, 1039, 56);
        var_12[0] = (7, 289, 0);
        var_11[1] = (47881, -1404, 115);
        var_12[1] = (8, 294, 0);
        var_11[2] = (47970, -22545, -320);
        var_12[2] = (9, 105, 0);

        for(var_13 = 0; var_13 < var_11.size; var_13++) {
          var_14 = spawnStruct();
          var_14.origin = var_11[var_13];
          var_14.angles = var_12[var_13];
          var_14._id_039B = "locale_9";
          var_14._id_0481 = "atv_spawn";
          var_14._id_04DE = "atango_physics_mp";
          var_1._id_10353[var_1._id_10353.size] = var_14;
        }

        foreach(var_9 in var_1._id_10353) {
          if(distancesquared(var_9.origin, (53109, -8400, -710)) < 16384) {
            var_9.origin = (46868, -457, 18);
            var_9.angles = (11, 252, 0);
            continue;
          }

          if(distancesquared(var_9.origin, (48215, -1671, 56)) < 16384) {
            var_9.origin = (47906, -676, 55);
            var_9.angles = (11, 309, 0);
          }
        }
      } else if(level.mapname == "mp_downtown_gw" && level._id_96CC == "locale_6") {
        var_11 = [];
        var_12 = [];
        var_11[0] = (17806, -20823, -110);
        var_12[0] = (11, 358, 0);
        var_11[1] = (16109, -24057, -144);
        var_12[1] = (1, 90, 0);
        var_11[2] = (18227, -704, -448);
        var_12[2] = (7, 266, 0);
        var_11[3] = (19180, 332, -447);
        var_12[3] = (6, 298, 0);

        for(var_13 = 0; var_13 < var_11.size; var_13++) {
          var_14 = spawnStruct();
          var_14.origin = var_11[var_13];
          var_14.angles = var_12[var_13];
          var_14._id_039B = "locale_6";
          var_14._id_0481 = "atv_spawn";
          var_14._id_04DE = "atango_physics_mp";
          var_1._id_10353[var_1._id_10353.size] = var_14;
        }

        foreach(var_9 in var_1._id_10353) {
          if(distancesquared(var_9.origin, (18368, -21157, -107)) < 16384) {
            var_9.origin = (16572, -19828, 86);
            var_9.angles = (2, 55, 0);
            continue;
          }

          if(distancesquared(var_9.origin, (19526, -15475, -97)) < 16384) {
            var_9.origin = (19177, -15490, -116);
            var_9.angles = (2, 64, 0);
          }
        }
      }
    }

    if(var_1._id_C19E == "tac_rover") {
      if(level.mapname == "mp_farms2_gw" && level._id_96CC == "locale_9") {
        var_11 = [];
        var_12 = [];
        var_11[0] = (48384, -1703, 70);
        var_12[0] = (7, 260, 0);
        var_11[1] = (50216, -22058, -336);
        var_12[1] = (5, 84, 0);

        for(var_13 = 0; var_13 < var_11.size; var_13++) {
          var_14 = spawnStruct();
          var_14.origin = var_11[var_13];
          var_14.angles = var_12[var_13];
          var_14._id_039B = "locale_9";
          var_14._id_0481 = "tacrover_spawn";
          var_14._id_04DE = "tromeo_physics_mp";
          var_1._id_10353[var_1._id_10353.size] = var_14;
        }
      } else if(level.mapname == "mp_downtown_gw" && level._id_96CC == "locale_6") {
        var_11 = [];
        var_12 = [];
        var_11[0] = (21969, -11928, -156);
        var_12[0] = (7, 269, 0);
        var_11[1] = (16413, -22817, -144);
        var_12[1] = (7, 85, 0);

        for(var_13 = 0; var_13 < var_11.size; var_13++) {
          var_14 = spawnStruct();
          var_14.origin = var_11[var_13];
          var_14.angles = var_12[var_13];
          var_14._id_039B = "locale_6";
          var_14._id_0481 = "tacrover_spawn";
          var_14._id_04DE = "tromeo_physics_mp";
          var_1._id_10353[var_1._id_10353.size] = var_14;
        }
      }
    }

    if(var_1._id_C19E == "cargo_truck" && level.mapname == "mp_downtown_gw" && level._id_96CC == "locale_6") {
      foreach(var_9 in var_1._id_10353) {
        if(distancesquared(var_9.origin, (20559, -24015, -105)) < 16384) {
          var_9.origin = (18119, -21282, -118);
          var_9.angles = (6, 55, 0);
        }
      }
    }

    foreach(var_9 in var_1._id_10353) {
      if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && isDefined(var_9._id_039B) && var_9._id_039B == level._id_96CC) {
        if(var_1._id_C19E == "light_tank") {
          if(isDefined(var_9._id_CE7D) && var_9._id_CE7D == "axis") {
            var_22 = level._id_EE52.size;
            level._id_EE52[var_22] = var_9;
            level._id_EE52[var_22]._id_C19E = var_1._id_C19E;
          } else if(isDefined(var_9._id_CE7D) && var_9._id_CE7D == "allies") {
            var_22 = level._id_EE51.size;
            level._id_EE51[var_22] = var_9;
            level._id_EE51[var_22]._id_C19E = var_1._id_C19E;
          } else {
            var_22 = level._id_10352.size;
            level._id_10352[var_22] = var_9;
            level._id_10352[var_22]._id_C19E = var_1._id_C19E;
          }
        } else if(istrue(level._id_4DB3) && var_1._id_C19E == "jeep" || istrue(level._id_4DB2) && var_1._id_C19E == "cargo_truck")
          continue;
        else {
          var_22 = level._id_10352.size;
          level._id_10352[var_22] = var_9;
          level._id_10352[var_22]._id_C19E = var_1._id_C19E;
        }
      }
    }
  }

  if(0) {
    foreach(var_26 in level._id_10352) {
      thread scripts\mp\utility\debug::_id_4F43(var_26.origin, var_26.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level._id_10352 = scripts\engine\utility::array_randomize(level._id_10352);
  var_28 = level._id_A793;

  if(!isDefined(level._id_A793)) {
    var_28 = 25;
  }

  if(0) {
    for(var_13 = 0; var_13 < var_28; var_13++) {
      var_26 = level._id_10352[var_13];
      thread scripts\mp\utility\debug::_id_4F43(var_26.origin + (0, 0, 1500), var_26.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var_13 = 0; var_13 < var_28; var_13++) {
    var_26 = level._id_10352[var_13];

    if(isDefined(var_26)) {
      var_1 = level.vehicleinfo[var_26._id_C19E];
      [[var_1._id_E274]](var_26);
    }
  }

  _id_07D1::_id_60C2("prematch_countdown");
  level._id_A78A = 0;
  level._id_A789 = 0;
  thread _id_10346(level._id_EE52);
  thread _id_10346(level._id_EE51);
}

_id_10346(var_0) {
  foreach(var_2 in var_0) {
    var_3 = level.vehicleinfo[var_2._id_C19E];
    [[var_3._id_E274]](var_2);
    wait(randomfloatrange(2.0, 3.0));
  }
}

_id_1034F(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("technical", var_2, var_1);
}

_id_10349(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("little_bird", var_2, var_1);
}

_id_10342(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("cop_car", var_2, var_1);
}

_id_10340(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("atv", var_2, var_1);
}

_id_10341(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("cargo_truck", var_2, var_1);
}

_id_10344(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("hoopty", var_2, var_1);
}

_id_10345(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("hoopty_truck", var_2, var_1);
}

_id_10347(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("jeep", var_2, var_1);
}

_id_1033F(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("apc_russian", var_2, var_1);
}

_id_1034E(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("light_tank", var_2, var_1);
}

_id_10348(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("large_transport", var_2, var_1);
}

_id_1034A(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("medium_transport", var_2, var_1);
}

_id_1034B(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("pickup_truck", var_2, var_1);
}

_id_1034C(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("tac_rover", var_2, var_1);
}

_id_10350(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("van", var_2, var_1);
}

_id_1034D(var_0, var_1) {
  if(!isDefined(var_0._id_CE7D)) {
    var_2 = _id_1034E(var_0, var_1);
    return var_2;
  }

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_3 = _id_10343(var_0);
  var_3._id_E325 = "airdrop_at_position_unsafe";

  if(isDefined(var_0._id_CE7D) && var_0._id_CE7D == "axis") {
    if(level._id_A78A >= level._id_9C77) {
      return;
    }
    var_3._id_FE22 = 1;
    var_3.team = "axis";
    level._id_A78A++;
  } else {
    if(level._id_A789 >= level._id_9C77) {
      return;
    }
    var_3.team = "allies";
    level._id_A789++;
  }

  var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("light_tank", var_3, var_1);

  if(istrue(level._id_DCF1)) {
    _id_1002A(var_2, var_2.team);
  }

  return var_2;
}

_id_1002A(var_0, var_1) {
  wait 1;
  var_2 = _id_07D6::_id_4026(var_0.origin, var_1, (0, 0, 0), undefined, 0, 0);
  _id_07F9::_id_FB96(var_2._id_A908, var_1);
  _id_07F9::_id_A89F(var_2._id_A908);
  _id_07F9::_id_A8B1(var_2._id_A908, 0);
  var_2._id_970A = 0;
  _id_07F9::_id_A89A(var_2._id_A908, 0);
  _id_07F9::_id_FB8F(var_2._id_A908, "icon_minimap_bradley_spawn_selection");
  _id_07F9::_id_FB98(var_2._id_A908, 1);
  _id_07F9::_id_FB93(var_2._id_A908, var_0);
  var_2._id_970A = 1;

  foreach(var_4 in level.players) {
    if(isDefined(var_4) && isDefined(var_4.team) && var_4.team == var_1 && istrue(var_4._id_82F2)) {
      _id_07F9::_id_A89D(var_2._id_A908, var_4);
    }
  }

  var_0._id_E372 = var_2;
  thread _id_102E4(var_0);
  level._id_F3FF[var_1][level._id_F3FF[var_1].size] = var_0;
}

_id_102E4(var_0) {
  var_1 = var_0._id_E372._id_A908;
  var_2 = var_0.team;
  var_0 waittill("death");
  _id_07F9::_id_C799(var_1);
  level._id_F3FF[var_2] = ::scripts\engine\utility::array_remove(level._id_F3FF[var_2], var_0);
}

_id_1025F() {
  self endon("disconnect");
  _id_07D1::_id_60C2("prematch_done");

  foreach(var_1 in level._id_F3FF[self.team]) {
    _id_07F9::_id_A89D(var_1._id_E372._id_A908, self);
  }

  while(self._id_82F2) {
    waitframe();
  }

  foreach(var_1 in level._id_F3FF["axis"]) {
    _id_07F9::_id_A89E(var_1._id_E372._id_A908, self);
  }

  foreach(var_1 in level._id_F3FF["allies"]) {
    _id_07F9::_id_A89E(var_1._id_E372._id_A908, self);
  }
}

_id_10343(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "GAME_MODE";
  var_1._id_DCB0 = 1;
  return var_1;
}

_id_506C(var_0) {
  var_1 = var_0.team;
  var_2 = "bradley";

  if(level.teambased) {
    if(isDefined(level._id_8DC5[var_2])) {
      if(isDefined(level._id_8DC5[var_2][var_1])) {
        if(gettime() < level._id_8DC5[var_2][var_1]) {
          return;
        }
      }
    }

    level._id_8DC5[var_2][var_1] = gettime() + _id_0A8D::_id_6AE0() * 1000;
  }

  _id_0A8D::_id_9136(var_1 + "_friendly_" + var_2 + "_inbound", var_1, "killstreak_used");
}

_id_10029(var_0, var_1) {
  wait 1;
  var_2 = _id_07D6::_id_4026(var_0.origin, var_1, (0, 0, 0), undefined, 0, 0);
  _id_07F9::_id_FB96(var_2._id_A908, var_1);
  _id_07F9::_id_A89F(var_2._id_A908);
  _id_07F9::_id_A8B1(var_2._id_A908, 0);
  var_2._id_970A = 0;
  _id_07F9::_id_A89A(var_2._id_A908, 0);
  _id_07F9::_id_FB8F(var_2._id_A908, "icon_minimap_littlebird_static");
  _id_07F9::_id_FB98(var_2._id_A908, 1);
  _id_07F9::_id_FB93(var_2._id_A908, var_0);
  var_2._id_970A = 1;

  foreach(var_4 in level.players) {
    if(isDefined(var_4) && istrue(var_4._id_82F2)) {
      _id_07F9::_id_A89D(var_2._id_A908, var_4);
    }
  }

  var_0._id_E372 = var_2;
  thread _id_102E3(var_0);
  level._id_F3FD["untouched"][level._id_F3FD["untouched"].size] = var_0;
}

_id_102E3(var_0) {
  var_1 = var_0._id_E372._id_A908;
  var_0 waittill("death");
  _id_07F9::_id_C799(var_1);
  var_2 = var_0._id_90A6;

  if(!isDefined(var_0._id_90A6)) {
    var_2 = "untouched";
  }

  level._id_F3FD[var_2] = ::scripts\engine\utility::array_remove(level._id_F3FD[var_2], var_0);
}

_id_10260() {
  self endon("disconnect");
  _id_07D1::_id_60C2("prematch_done");

  foreach(var_1 in level._id_F3FD[self.team]) {
    _id_07F9::_id_A89D(var_1._id_E372._id_A908, self);
  }

  foreach(var_1 in level._id_F3FD["untouched"]) {
    _id_07F9::_id_A89D(var_1._id_E372._id_A908, self);
  }

  while(self._id_82F2) {
    waitframe();
  }

  foreach(var_1 in level._id_F3FD["axis"]) {
    _id_07F9::_id_A89E(var_1._id_E372._id_A908, self);
  }

  foreach(var_1 in level._id_F3FD["allies"]) {
    _id_07F9::_id_A89E(var_1._id_E372._id_A908, self);
  }

  foreach(var_1 in level._id_F3FD["untouched"]) {
    _id_07F9::_id_A89E(var_1._id_E372._id_A908, self);
  }
}

_id_10234(var_0) {
  if(isDefined(self._id_90A6)) {
    level._id_F3FD[self._id_90A6] = ::scripts\engine\utility::array_remove(level._id_F3FD[self._id_90A6], self);
  } else {
    level._id_F3FD["untouched"] = ::scripts\engine\utility::array_remove(level._id_F3FD["untouched"], self);
  }

  self._id_90A6 = var_0;
  level._id_F3FD[var_0][level._id_F3FD[var_0].size] = self;
  _id_07F9::_id_FB8F(self._id_E372._id_A908, "icon_minimap_littlebird_spawn_selection");

  foreach(var_2 in level.players) {
    _id_07F9::_id_A89E(self._id_E372._id_A908, var_2);

    if(isDefined(var_2) && isDefined(var_2.team) && var_2.team == var_0 && istrue(var_2._id_82F2)) {
      _id_07F9::_id_A89D(self._id_E372._id_A908, var_2);
      continue;
    }

    _id_07F9::_id_A89E(self._id_E372._id_A908, var_2);
  }
}

_id_8081() {
  while(!isDefined(level._id_E371)) {
    waitframe();
  }

  waitframe();
  level._id_BFC9 = [];
  var_0 = scripts\engine\utility::getStructArray("rallyPointTechnical", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && isDefined(var_2._id_039B) && var_2._id_039B != level._id_96CC) {
      continue;
    }
    var_3 = scripts\engine\utility::ter_op(var_2._id_CE7D == "axis", "axis", "allies");
    var_4 = _id_6CB8(var_2, var_3);
    var_5 = spawnStruct();
    var_6 = _id_0AB9::_id_EFFE(var_4, var_5);

    if(isDefined(var_6)) {
      level._id_BFC9[level._id_BFC9.size] = var_6;
      continue;
    }
  }

  var_0 = scripts\engine\utility::getStructArray("rallyPointLittleBird", "targetname");

  if(!istrue(level._id_4AC2)) {
    foreach(var_2 in var_0) {
      if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && isDefined(var_2._id_039B) && var_2._id_039B != level._id_96CC) {
        continue;
      }
      var_3 = scripts\engine\utility::ter_op(var_2._id_CE7D == "axis", "axis", "allies");
      var_4 = _id_6CB8(var_2, var_3);
      var_5 = spawnStruct();
      var_6 = _id_0AB5::_id_9581(var_4, var_5);

      if(isDefined(var_6)) {
        level._id_BFC9[level._id_BFC9.size] = var_6;
        continue;
      }
    }
  } else if(!istrue(level._id_3B22)) {
    if(level._id_96CC == "locale_6" && level.mapname == "mp_downtown_gw" && istrue(level._id_9A63)) {
      var_10 = [];
      var_10[0] = (23718, -4470, -350);
      var_10[1] = (25046, -17463, -50);
      var_10[2] = (19627, -17495, 50);
      var_10[3] = (23478, -7635, -250);
      var_11 = [];
      var_11[0] = (6, 316, 0);
      var_11[1] = (8, 225, 0);
      var_11[2] = (10, 47, 0);
      var_11[3] = (11, 176, 0);

      foreach(var_13, var_2 in var_0) {
        var_2.origin = var_10[var_13];
        var_2.angles = var_11[var_13];
      }
    }

    foreach(var_2 in var_0) {
      if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && isDefined(var_2._id_039B) && var_2._id_039B != level._id_96CC) {
        continue;
      }
      if(!isDefined(var_2.angles)) {
        var_2.angles = (0, randomfloat(360), 0);
      }

      var_4 = _id_10343(var_2);
      var_6 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("little_bird", var_4, undefined);
      level thread _id_10029(var_6, "neutral");
    }
  }

  var_0 = scripts\engine\utility::getStructArray("rallyPointAPC", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && isDefined(var_2._id_039B) && var_2._id_039B != level._id_96CC) {
      continue;
    }
    var_3 = scripts\engine\utility::ter_op(var_2._id_CE7D == "axis", "axis", "allies");
    var_4 = _id_6CB8(var_2, var_3);

    if(var_3 == "allies") {
      var_4._id_FE22 = 1;
    }

    var_5 = spawnStruct();
    var_6 = _id_0AA9::_id_199A(var_4, var_5);

    if(isDefined(var_6)) {
      level._id_BFC9[level._id_BFC9.size] = var_6;
      continue;
    }
  }

  foreach(var_19 in level._id_EF89) {
    while(!isDefined(level._id_1F95[var_19][0])) {
      waitframe();
    }
  }

  var_21 = 0;
  var_22 = 0;
  var_23 = 0;
  var_24 = 0;
  var_25 = 0;
  var_26 = 0;
  var_27 = "gw_vehicle_technical_";
  var_28 = "gw_vehicle_littlebird_";
  var_29 = "gw_vehicle_apc_";

  foreach(var_6 in level._id_BFC9) {
    var_4 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(var_6);

    if(!isDefined(var_4._id_BFC5)) {
      var_4._id_BFC5 = var_6.health;
    } else {
      var_6.health = var_4._id_BFC5;
    }

    var_13 = 0;
    var_31 = undefined;

    if(var_6.team == "axis") {
      if(var_6._id_1031E == "technical") {
        var_21++;

        if(var_21 <= 8) {
          var_4._id_C189 = var_27 + var_21;
        } else {}
      } else if(var_6._id_1031E == "little_bird") {
        var_22++;

        if(var_22 <= 2) {
          var_4._id_C189 = var_28 + var_22;
        } else {}
      } else if(var_6._id_1031E == "apc_russian") {
        var_23++;

        if(var_23 <= 2) {
          var_4._id_C189 = var_29 + var_23;
        } else {}
      }
    } else if(var_6._id_1031E == "technical") {
      var_24++;

      if(var_24 <= 8) {
        var_4._id_C189 = var_27 + var_24;
      } else {}
    } else if(var_6._id_1031E == "little_bird") {
      var_25++;

      if(var_25 <= 2) {
        var_4._id_C189 = var_28 + var_25;
      } else {}
    } else if(var_6._id_1031E == "apc_russian") {
      var_26++;

      if(var_26 <= 2) {
        var_4._id_C189 = var_29 + var_26;
      } else {}
    }

    if(istrue(level._id_FEAF) && level._id_FEAF != 2) {
      _id_10C26(var_6);
    }
  }
}

_id_10C26(var_0) {
  _id_0808::_id_BFC7(var_0);
}

_id_6CB8(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2.spawntype = "GAME_MODE";
  var_2._id_31A0 = 1;
  var_2.team = var_1;
  return var_2;
}

_id_1B12() {
  level._id_AD0F = [];
  var_0 = getEntArray("OutOfBounds", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && isDefined(var_2._id_039B) && var_2._id_039B == level._id_96CC) {
      level._id_AD0F[level._id_AD0F.size] = var_2;
      continue;
    }

    var_2 delete();
  }
}

_id_44EE(var_0) {
  if(0) {
    return;
  }
}

_id_8958(var_0) {
  if(var_0._id_ADAE == "axis") {
    return var_0._id_A79A["allies"] > 0;
  } else if(var_0._id_ADAE == "allies") {
    return var_0._id_A79A["axis"] > 0;
  }
}

_id_2EF1(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_A8E8) {
    if(var_3._id_ADAE == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_3FF0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = undefined;

  if(isDefined(var_11)) {
    var_12 = var_11;
  } else {
    var_12 = spawn("script_model", var_0);
  }

  var_12 makeuseable();

  if(isDefined(var_11) && isDefined(var_0)) {
    var_12 _meth_84D7(var_0);
  }

  if(isDefined(var_1)) {
    var_12 setcursorhint(var_1);
  } else {
    var_12 setcursorhint("HINT_NOICON");
  }

  if(isDefined(var_2)) {
    var_12 _meth_84DA(var_2);
  }

  if(isDefined(var_3)) {
    var_12 sethintstring(var_3);
  }

  if(isDefined(var_4)) {
    var_12 _meth_83A1(var_4);
  } else {
    var_12 _meth_83A1(0);
  }

  if(isDefined(var_5)) {
    var_12 setuseholdduration(var_5);
  } else {
    var_12 setuseholdduration("duration_short");
  }

  if(isDefined(var_6)) {
    var_12 _meth_84D9(var_6);
  } else {
    var_12 _meth_84D9("hide");
  }

  if(isDefined(var_7)) {
    var_12 _meth_84D4(var_7);
  } else {
    var_12 _meth_84D4(200);
  }

  if(isDefined(var_8)) {
    var_12 sethintdisplayfov(var_8);
  } else {
    var_12 sethintdisplayfov(160);
  }

  if(isDefined(var_9)) {
    var_12 setuserange(var_9);
  } else {
    var_12 setuserange(50);
  }

  if(isDefined(var_10)) {
    var_12 setusefov(var_10);
  } else {
    var_12 setusefov(120);
  }

  if(!isDefined(var_11)) {
    return var_12;
  }
}

_id_2EE8() {
  if(level.mapname == "mp_arm_test") {
    level._id_2E34 = (0, 375, 0);
    level._id_2E35 = (0, 1, 0);
    level._id_1FE5 = (-1, 0, 0);
    level._id_1510 = (1, 0, 0);
  } else {
    level._id_2E34 = (5100, -1615, 0);
    level._id_2E35 = (1, 0, 0);
    level._id_1FE5 = (0, -1, 0);
    level._id_1510 = (0, 1, 0);
  }
}

_id_6A1D() {
  var_0 = scripts\engine\utility::getStructArray("airdropLocation_allies", "targetname");
  var_1 = scripts\engine\utility::getStructArray("airdropLocation_axis", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  var_3 = scripts\engine\utility::_id_6969(level._id_8EA9._id_41DC._id_60D8.origin, var_2);
  var_4 = scripts\engine\utility::_id_6969(level._id_8EAA._id_41DC._id_60D8.origin, var_2);
  var_5 = scripts\engine\utility::_id_6969(level._id_8EAB._id_41DC._id_60D8.origin, var_2);
  level._id_1B23 = 3;
  return [var_3, var_4, var_5];
}

_id_AAD4(var_0) {}

_id_AAD6(var_0) {
  level._id_1B23--;

  if(level._id_1B23 == 0) {
    thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["target_destroyed"]);
  }
}

_id_E034(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) < distancesquared(var_1.origin, self.origin);
}

_id_2EE5(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1.0, 1.0);

  if(var_7 > 0) {
    var_4 = randomfloatrange(var_3[0] + var_1 * var_7, var_3[0] + var_2 * var_7);

    if(var_4 >= level._id_2A73._id_2A2E[0][0]) {
      var_4 = level._id_2A73._id_2A2E[0][0] - 250;
    }
  } else {
    var_4 = randomfloatrange(var_3[0] + var_2 * var_7, var_3[0] + var_1 * var_7);

    if(var_4 <= level._id_2A73._id_2A2E[1][0]) {
      var_4 = level._id_2A73._id_2A2E[1][0] + 250;
    }
  }

  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1.0, 1.0);

  if(var_7 > 0) {
    var_5 = randomfloatrange(var_3[1] + var_1 * var_7, var_3[1] + var_2 * var_7);

    if(var_5 >= level._id_2A73._id_2A2E[0][1]) {
      var_5 = level._id_2A73._id_2A2E[0][1] - 250;
    }
  } else {
    var_5 = randomfloatrange(var_3[1] + var_2 * var_7, var_3[1] + var_1 * var_7);

    if(var_5 >= level._id_2A73._id_2A2E[1][1]) {
      var_5 = level._id_2A73._id_2A2E[1][1] + 250;
    }
  }

  var_8 = spawnStruct();
  var_8.origin = (var_4, var_5, var_3[2]);
  return var_8;
}

_id_44FE(var_0, var_1, var_2) {}

_id_6B60(var_0) {
  var_1 = spawnStruct();
  var_1._id_E706 = undefined;
  var_1._id_533E = undefined;

  if(level.mapname == "mp_locale_test") {
    switch (level._id_96CC) {
      case "locale_8":
      case "locale_6":
        if(var_0 == "axis") {
          var_1._id_E706 = (2094, -1804, 2763);
          var_1._id_E67A = (54, 40, 0);
          var_1._id_533C = (2094, -1804, 2763);
          var_1._id_52DF = (54, 40, 0);
        } else {
          var_1._id_E706 = (2315, 1956, 2763);
          var_1._id_E67A = (54, 296, 0);
          var_1._id_533C = (2094, -1804, 2763);
          var_1._id_52DF = (54, 40, 0);
        }

        break;
      default:
        var_1._id_E706 = (0, 0, 0);
        var_1._id_E67A = (0, 0, 0);
        var_1._id_533C = (0, 0, 0);
        var_1._id_52DF = (0, 0, 0);
        break;
    }
  } else {
    switch (level._id_96CC) {
      case "locale_3":
        if(var_0 == "axis") {
          var_1._id_E706 = (38864, -14018, -396);
          var_1._id_E67A = (3, 250, 0);
          var_1._id_533C = (38473, -14077, 401);
          var_1._id_52DF = (15, 252, 0);
        } else {
          var_1._id_E706 = (30526, -38262, -483);
          var_1._id_E67A = (0, 72, 0);
          var_1._id_533C = (30024, -38403, 560);
          var_1._id_52DF = (19, 67, 0);
        }

        break;
      case "locale_6":
        if(var_0 == "axis") {
          var_1._id_E706 = (16977, -23256, 169);
          var_1._id_E67A = (9, 69, 0);
          var_1._id_533C = (16899, -23467, 683);
          var_1._id_52DF = (15, 68, 0);
        } else {
          var_1._id_E706 = (18607, 1423, -355);
          var_1._id_E67A = (8, 289, 0);
          var_1._id_533C = (18100, 1083, 503);
          var_1._id_52DF = (22, 302, 0);
        }

        break;
      case "locale_8":
        if(var_0 == "axis") {
          var_1._id_E706 = (18672, -26836, -129);
          var_1._id_E67A = (359, 76, 0);
          var_1._id_533C = (18518, -26909, 314);
          var_1._id_52DF = (14, 69, 0);
        } else {
          var_1._id_E706 = (18607, 1423, -355);
          var_1._id_E67A = (8, 289, 0);
          var_1._id_533C = (18100, 1083, 503);
          var_1._id_52DF = (22, 302, 0);
        }

        break;
      case "locale_16":
      case "locale_5":
        if(var_0 == "axis") {
          var_1._id_E706 = (24893, 28349, 1408);
          var_1._id_E67A = (15, 54, 0);
          var_1._id_533C = (25613, 29274, 1255);
          var_1._id_52DF = (19, 53, 0);
        } else {
          var_1._id_E706 = (39490, 48919, 2302);
          var_1._id_E67A = (17, 235, 0);
          var_1._id_533C = (39254, 48584, 1542);
          var_1._id_52DF = (18, 245, 0);
        }

        break;
      case "locale_9":
        if(var_0 == "axis") {
          var_1._id_E706 = (48331, -24822, 514);
          var_1._id_E67A = (12, 77, 0);
          var_1._id_533C = (48424, -24421, -240);
          var_1._id_52DF = (2, 77, 0);
        } else {
          var_1._id_E706 = (46188, 2520, 49);
          var_1._id_E67A = (7, 295, 0);
          var_1._id_533C = (46571, 2664, 526);
          var_1._id_52DF = (16, 276, 0);
        }

        break;
      case "locale_10":
        if(var_0 == "axis") {
          var_1._id_E706 = (-11083, 22197, 381);
          var_1._id_E67A = (10, 181, 0);
          var_1._id_533C = (-12112, 23761, 381);
          var_1._id_52DF = (11, 201, 0);
        } else {
          var_1._id_E706 = (-31134, 11924, -116);
          var_1._id_E67A = (0, 36, 0);
          var_1._id_533C = (-31134, 11924, 434);
          var_1._id_52DF = (11, 36, 0);
        }

        break;
      case "locale_17":
        if(var_0 == "axis") {
          var_1._id_E706 = (5346, -554, 2800);
          var_1._id_E67A = (8, 170, 0);
          var_1._id_533C = (5346, -554, 3400);
          var_1._id_52DF = (8, 170, 0);
        } else {
          var_1._id_E706 = (-8762, 4741, 2800);
          var_1._id_E67A = (8, 350, 0);
          var_1._id_533C = (-8762, 4741, 3400);
          var_1._id_52DF = (8, 350, 0);
        }

        break;
      default:
        var_1._id_E706 = (0, 0, 0);
        var_1._id_E67A = (0, 0, 0);
        var_1._id_533C = (0, 0, 0);
        var_1._id_52DF = (0, 0, 0);
        break;
    }
  }

  return var_1;
}

_id_2EEB() {
  level._id_7B20 = (level._id_7346._id_1FE7.trigger.origin + level._id_7346._id_1512.trigger.origin) * 0.5;
  level._id_7B22 = level._id_7346._id_1FE7.trigger.origin - level._id_7B20;
  level._id_7B23 = level._id_7346._id_1512.trigger.origin - level._id_7B20;
  level._id_7B1E = length(level._id_7B23);
}

_id_2EE0(var_0, var_1) {
  switch (level.mapname) {
    case "mp_quarry2":
      var_2 = 0.25;
      var_3 = 0.35;
      break;
    case "mp_farms2":
      var_2 = 0.25;
      var_3 = 0.8;
      break;
    case "mp_aniyah":
      var_2 = 0.5;
      var_3 = 0.3;
      break;
    default:
      var_2 = 0.0;
      var_3 = 0.0;
      break;
  }

  var_4 = distance(var_1, level._id_7B20);

  if(var_4 < 2048) {
    return (0, 0, 0);
  }

  if(scripts\mp\utility\game::isbasegametype()) {
    [var_6, var_7] = ::scripts\mp\gametypes\base::getbasespawnoffsetvalues(var_0, var_1);
  } else if(var_0 == "axis") {
    var_6 = distance(level._id_7346._id_1FE7.trigger.origin, var_1);
    var_7 = level._id_7B23;
  } else {
    var_6 = distance(level._id_7346._id_1512.trigger.origin, var_1);
    var_7 = level._id_7B22;
  }

  if(var_6 < 2048) {
    return var_7 * var_2;
  }

  if(var_6 > level._id_7B1E) {
    if(scripts\mp\utility\game::isbasegametype()) {
      [var_6, var_7] = ::scripts\mp\gametypes\base::getbasespawnoffsetvalues(var_0, var_1);
    } else if(var_0 == "axis") {
      var_6 = distance(level._id_7346._id_1512.trigger.origin, var_1);
    } else {
      var_6 = distance(level._id_7346._id_1FE7.trigger.origin, var_1);
    }

    var_9 = 100 - var_6 * 100 / level._id_7B1E;
    var_10 = var_7 * var_3 * -1.0 * (var_9 / 100);
    return var_10;
  } else {
    var_9 = 100 - var_6 * 100 / level._id_7B1E;
    var_10 = var_7 * var_2 * (var_9 / 100);
    return var_10;
  }
}

_id_E356() {
  if(isDefined(self._id_D066) && issubstr(self._id_D066, "HQ")) {
    return 1;
  }

  return 0;
}