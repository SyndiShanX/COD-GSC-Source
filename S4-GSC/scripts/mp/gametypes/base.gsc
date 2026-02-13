/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\base.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "tdm";
  var_0[2] = "arm";
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
  setDvar("#x353929f8c3b90ca3a", 2250);
  setDvar("#x36b30e780f420eb79", 15);
  setdynamicdvar("#x3d89605100dc8a2bb", 150);
  setdynamicdvar("#x3ebf64a18d581b6f5", 1);
  setomnvar("ui_num_dom_flags", 7);
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
  level._id_7003 = ::_id_6FD0;
  level.onleavesquad = ::onleavesquad;
  level._id_AB42 = scripts\mp\gametypes\dom::_id_AAEF;
  level._id_8FA1 = gettime();
  level._id_AD3D = scripts\mp\gametypes\s4_base_loot::_id_AD3D;
  level.override_loadout_updateclassdefault_equipment = scripts\mp\gametypes\s4_base_loot::override_loadout_updateclassdefault_equipment;
  level.base_ongameended = ::_id_AAF6;
  level._id_150E = [];
  level._id_1FE3 = [];
  level._id_8FA2 = undefined;
  level._id_BC37 = undefined;
  level._id_BDA4 = 1;
  level._id_C587 = 1;
  level._id_C586["allies"] = 24;
  level._id_C586["axis"] = 24;
  game["dialog"]["gametype"] = "mp_glob_arms_bchr_z203";
  game["dialog"]["offense_obj"] = "offense_obj";
  game["dialog"]["defense_obj"] = "defense_obj";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["securing_d"] = "securing_d";
  game["dialog"]["securing_e"] = "securing_e";
  game["dialog"]["securing_f"] = "securing_f";
  game["dialog"]["securing_g"] = "securing_g";
  game["dialog"]["secured_a"] = "secured_a";
  game["dialog"]["secured_b"] = "secured_b";
  game["dialog"]["secured_c"] = "secured_c";
  game["dialog"]["secured_d"] = "secured_d";
  game["dialog"]["secured_e"] = "secured_e";
  game["dialog"]["secured_f"] = "secured_f";
  game["dialog"]["secured_g"] = "secured_g";
  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["losing_d"] = "losing_d";
  game["dialog"]["losing_e"] = "losing_e";
  game["dialog"]["losing_f"] = "losing_f";
  game["dialog"]["losing_g"] = "losing_g";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
  game["dialog"]["lost_d"] = "lost_d";
  game["dialog"]["lost_e"] = "lost_e";
  game["dialog"]["lost_f"] = "lost_f";
  game["dialog"]["lost_g"] = "lost_g";
  game["dialog"]["lost_all"] = "gamestate_domlosing";
  game["dialog"]["secure_all"] = "gamestate_domwinning";
  game["dialog"]["game_end_win"] = "mp_glob_arms_bchr_z204";
  game["dialog"]["game_end_lose"] = "mp_glob_arms_bchr_z205";
  game["dialog"]["last_base_winning"] = "mp_glob_arms_bchr_z206";
  game["dialog"]["winning_score"] = "mp_glob_arms_bchr_z208";
  game["dialog"]["losing_score"] = "mp_glob_arms_bchr_z209";
  game["dialog"]["base_neutral_capturing"] = "mp_glob_arms_bchr_z210";
  game["dialog"]["base_neutral_captured"] = "mp_glob_arms_bchr_z211";
  game["dialog"]["base_hostile_capturing"] = "mp_glob_arms_bchr_z212";
  game["dialog"]["base_hostile_capturing_contested"] = "mp_glob_arms_bchr_z213";
  game["dialog"]["base_hostile_captured"] = "mp_glob_arms_bchr_z214";
  game["dialog"]["base_friendly_defending_contested"] = "mp_glob_arms_bchr_z215";
  game["dialog"]["base_friendly_defending"] = "mp_glob_arms_bchr_z216";
  game["dialog"]["base_friendly_lost"] = "mp_glob_arms_bchr_z217";
  game["dialog"]["last_base"] = "mp_glob_arms_bchr_z225";
  game["dialog"]["nuked_a_enemy"] = "mp_glob_arms_bchr_z227";
  game["dialog"]["nuked_b_enemy"] = "mp_glob_arms_bchr_z229";
  game["dialog"]["nuked_c_enemy"] = "mp_glob_arms_bchr_z231";
  game["dialog"]["nuked_d_enemy"] = "mp_glob_arms_bchr_z233";
  game["dialog"]["nuked_e_enemy"] = "mp_glob_arms_bchr_z235";
  game["dialog"]["nuked_f_enemy"] = "mp_glob_arms_bchr_z237";
  game["dialog"]["nuked_g_enemy"] = "mp_glob_arms_bchr_z239";
  game["dialog"]["nuked_a_friendly"] = "mp_glob_arms_bchr_z226";
  game["dialog"]["nuked_b_friendly"] = "mp_glob_arms_bchr_z228";
  game["dialog"]["nuked_c_friendly"] = "mp_glob_arms_bchr_z230";
  game["dialog"]["nuked_d_friendly"] = "mp_glob_arms_bchr_z232";
  game["dialog"]["nuked_e_friendly"] = "mp_glob_arms_bchr_z234";
  game["dialog"]["nuked_f_friendly"] = "mp_glob_arms_bchr_z236";
  game["dialog"]["nuked_g_friendly"] = "mp_glob_arms_bchr_z238";
  game["dialog"]["gate_breach_friendly"] = "mp_glob_arms_bchr_z219";
  game["dialog"]["gate_breach_multiple_friendly"] = "mp_glob_arms_bchr_z220";
  game["dialog"]["wall_breach_friendly"] = "mp_glob_arms_bchr_z221";
  game["dialog"]["wall_breach_multiple_friendly"] = "mp_glob_arms_bchr_z222";
  game["dialog"]["crate_incoming"] = "mp_glob_arms_bchr_z240";
  game["dialog"]["crate_available"] = "mp_glob_arms_bchr_z242";
  game["dialog"]["crate_capturing_hostile"] = "mp_glob_arms_bchr_z243";
  game["dialog"]["crate_capturing_friendly"] = "mp_glob_arms_bchr_z244";
  game["dialog"]["crate_carrier_hostile"] = "mp_glob_arms_bchr_z315";
  game["dialog"]["crate_carrier_friendly"] = "mp_glob_arms_bchr_z316";
  game["dialog"]["crate_captured_hostile"] = "mp_glob_arms_bchr_z245";
  game["dialog"]["crate_captured_friendly"] = "mp_glob_arms_bchr_z246";
  game["dialog"]["nebula_friendly"] = "mp_glob_arms_bchr_fnin";
  game["dialog"]["nebula_hostile"] = "mp_glob_arms_bchr_enin";
  game["dialog"]["nebula_neutral"] = "mp_glob_arms_bchr_gnin";
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_snatch_ac130_clouds"] = loadfx("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_br_infil_omni_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx");
  level._effect["vfx_br_infil_spot_light"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx");
  level._effect["vfx_ar_damage_indicator_a"] = loadfx("vfx/s4/gamemode/vfx_ar_damage_indicator_a");
  level._effect["vfx_ar_gassed_base_zone"] = loadfx("vfx/s4/gamemode/vfx_ar_gassed_base_zone");
  level._effect["vfx_ar_gassed_base_zone_intro"] = loadfx("vfx/s4/gamemode/vfx_ar_gassed_base_zone_intro");
  level._effect["vfx_ar_missile_base_imp"] = loadfx("vfx/s4/gamemode/vfx_ar_missile_base_imp");
  level._effect["screen_ar_player_gas"] = loadfx("vfx/s4/screen/screen_ar_player_gas");
  level._effect["char_ar_gas_damage"] = loadfx("vfx/s4/character/_misc/char_ar_gas_damage");
  level._effect["char_ar_gas_death"] = loadfx("vfx/s4/character/_misc/char_ar_gas_death");
  level._effect["vfx_ar_base_spawn_blocker_01"] = loadfx("vfx/s4/gamemode/vfx_ar_base_spawn_blocker_01.vfx");
  level._effect["vfx_ar_base_spawn_blocker_02"] = loadfx("vfx/s4/gamemode/vfx_ar_base_spawn_blocker_02.vfx");
  level._effect["vfx_ar_base_spawn_blocker_03"] = loadfx("vfx/s4/gamemode/vfx_ar_base_spawn_blocker_03.vfx");
  level._effect["vfx_ar_base_spawn_b_blocker_01"] = loadfx("vfx/s4/gamemode/vfx_ar_base_spawn_b_blocker_01.vfx");
  level._effect["vfx_ar_base_spawn_b_blocker_02"] = loadfx("vfx/s4/gamemode/vfx_ar_base_spawn_b_blocker_02.vfx");
  level._effect["vfx_ar_base_spawn_b_blocker_03"] = loadfx("vfx/s4/gamemode/vfx_ar_base_spawn_b_blocker_03.vfx");
  level._effect["vfx_ar_crate_locator"] = loadfx("vfx/s4/gamemode/vfx_ar_crate_locator");
  level._effect["vfx_ui_closest_base_01"] = loadfx("vfx/s4/gamemode/vfx_ui_closest_base_01");
  level._effect["vfx_ui_last_base_01"] = loadfx("vfx/s4/gamemode/vfx_ui_last_base_01");
  level._id_0BCE["plane_propellor"] = loadfx("vfx/s4/vehicle/vfx_propeller_01.vfx");
  level._id_0BCE["plane_clouds"] = loadfx("vfx/s4/vehicle/plane_skilo_clouds.vfx");
  level._effect["vfx_ar_mc_spawn_flash"] = loadfx("vfx/s4/gamemode/vfx_ar_mc_spawn_flash");
  scripts\engine\utility::_id_0FDC("flare_fanfare_lrg_1", "vfx/s4/flare/flare_fanfare_blue_lrg");
  scripts\engine\utility::_id_0FDC("flare_fanfare_lrg_2", "vfx/s4/flare/flare_fanfare_green_lrg");
  scripts\engine\utility::_id_0FDC("flare_fanfare_lrg_3", "vfx/s4/flare/flare_fanfare_yellow_lrg");
  scripts\engine\utility::_id_0FDC("flare_fanfare_lrg_4", "vfx/s4/gamemode/vfx_ar_fanfare_capture");
  level._id_A741 = getdvarint("#x3bfd98e12a022743d", 0);
  level._id_8DA6 = getdvarint("#x3103e6dee1450798d", 7);
  level._id_FE94 = getdvarint("#x3ca6952121034fcb5", 1);
  level.overtimeduration = [];
  level.overtimeduration[0] = getdvarfloat("#x3d9d600b9f1ac1b5a", 60);
  level.overtimeduration[1] = getdvarfloat("#x3d9d5ffb9f1ac1927", 40);
  level.overtimeduration[2] = getdvarfloat("#x3d9d5feb9f1ac16f4", 20);
  level._id_FEAF = getdvarint("#x313b0b1363cee6385", 1);
  level._id_78F8 = 1;
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
  level._id_2A9B = spawnStruct();
  level._id_2A9B._id_B967 = 9999;
  level.basecontestedtier1 = getdvarfloat("#x3f3b5437c2e64d5fc", 0.0);
  level.basecontestedtier2 = getdvarfloat("#x3f3b5467c2e64dc95", 0.4);
  level.basecontestedtier3 = getdvarfloat("#x3f3b5457c2e64da62", 0.0);
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
  level._id_B027 = getdvarint("#x3a9673103fb31584d", 30);
  level._id_DCF1 = getdvarint("#x3cc919e4c4d578c6b", 1);
  level._id_DCF0 = getdvarint("#x39fff91bfe3481746", 1);
  level._id_E36D = getdvarint("#x3a91f976cb76dbace", 120);
  level._id_9A63 = getdvarint("#x3ff06c2b2134012df", 1);
  level._id_4DB3 = getdvarint("#x3fe185609cbe8a080", 0);
  level._id_4DB2 = getdvarint("#x34568285cc01ed353", 0);
  level._id_4DB4 = getdvarint("#x3fb71a2ac09ba589c", 0);
  level._id_4DB0 = getdvarint("#x38d56d85d81e706b2", 0);
  level._id_4DB1 = getdvarint("#x38d45f55d81d53c1d", 0);
  level._id_4DB5 = getdvarint("#x3a5d6f8ae52b4c7df", 0);
  level._id_FEA7 = getdvarint("#x393cac8a60d54291c", 0);
  level._id_A706 = [];
  level._id_A706["allies"] = 0;
  level._id_A706["axis"] = 0;
  level._id_A707 = getdvarint("#x39112b28dcfc70c1f", 100000);
  level._id_A6E7 = 0;
  level._id_A709 = "none";
  level._id_22A3 = getdvarint("#x3d7306aef3dc3bee", 1);
  level._id_22A5 = getdvarint("#x35b6051cfa30f7198", 1);
  level._id_22A6 = getdvarint("#x3f8f9c9681979baa9", 30);
  level.base_nuke_missile_pretime = getdvarint("#x328b4e782a79d943c", 3);

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

  level thread base_nuketutorialcrate();

  if(level._id_2E38 == 1) {
    level._id_2E39 = [];
    level._id_2E39["axis"] = 0;
    level._id_2E39["allies"] = 0;
  }

  level._id_9FC8 = 1;
  level._id_4AF6 = 1;
  level._id_E356 = ::_id_E356;
  thread prenukebases();

  if(getdvarint("#x3ce93e7a771aab4b0", 1)) {
    level _id_D884();
    level thread _id_D885();
  }

  thread _id_8274();
}

recordbaseactivity(var_0, var_1) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    var_0.lastbaseactivitytime = gettime();
  }
}

_id_8274() {
  waittillframeend;
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", ::base_support_vehicle_respawning);
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
  scripts\mp\utility\game::_id_C25D("base", 0);
}

_id_ABAD() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  setclientnamemode("auto_change");
  level._id_A8E8 = [];
  level._id_F935 = [];
  _id_8294();
  _id_0A8E::_id_C285(::_id_AB63);
  scripts\mp\gametypes\s4_base_loot::_id_985B();
  level thread nuke_crate_init();
  level._id_CAB6 = ::_id_E401;
  level._id_CAB2 = ::_id_6C45;
  scripts\mp\gametypes\s4_armory_kiosk::init();
  level thread _id_C530();
  _id_D5AD();
  level._id_FE52 = 0;
  level._id_4ADA = getdvarint("#x3cd4fedd054c3348b", 1);
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
  setupmatchdata();
  _id_2EEB();

  if(istrue(level._id_FE94)) {
    _id_D899();
  }

  level thread _id_CA67();

  if(level._id_FE2D) {
    level thread _id_9A16();
  }

  _id_0A8D::_id_829D();
  level thread _id_9BC1();
  level thread spawnnukesatintervals();
  level thread nukebasesatintervals();
  level thread _id_815C();
  _id_517D();

  if(istrue(level._id_FEA7)) {
    _id_07B9::_id_2F97();
  }

  _id_0797::_id_8251();
  level thread fobspawnselection_init();
  _id_C495();
}

_id_C495() {
  if(isDefined(level._id_4DB5) && level._id_4DB5 == 1) {
    var_0 = _func_0443();

    foreach(var_2 in var_0) {
      if(isDefined(var_2._id_0481) && var_2._id_0481 == "sfps_turret") {
        var_2 delete();
      }
    }
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_AF70 = scripts\mp\utility\dvars::_id_509C("pauseTime", 1, 0, 1);
  level._id_46D3 = scripts\mp\utility\dvars::_id_509C("delayPlayer", 1, 0, 1);
  level._id_E295 = scripts\mp\utility\dvars::_id_509A("spawnDelay", 5, 0, 30);
  level._id_FE83 = 1;
  setdynamicdvar("#x3629885a2468d1e4f", 1200);
  scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 1200);
  level._id_5C3B = scripts\mp\utility\dvars::_id_509A("#x328f66aefdd04dd", 30.0, 0, 30);
  level.flagcapturetime_neutral = scripts\mp\utility\dvars::_id_509A("flagCaptureTime_neutral", 20.0, 0, 30);
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

_id_C530() {
  var_0 = getEntArray("OutOfBounds", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_CE7D)) {
      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_3 in var_1) {
    foreach(var_7 in level._id_AD0F) {
      if(var_7 == var_3) {
        level._id_AD0F = scripts\engine\utility::array_remove(level._id_AD0F, var_3);
        break;
      }
    }

    var_3 delete();
  }
}

base_nuketutorialcrate() {
  level endon("game_ended");
  level waittill("prematch_started");
  var_0 = scripts\engine\utility::getstruct("base_intro_nukecrate", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel(level.leveldata._id_508A);
  _id_07D1::_id_60C2("prematch_waitForPlayers_Complete");
  var_1 delete();
}

prenukebases() {
  var_0 = getdvarint("#x38771cce1c177d002", 0);
  var_1 = getdvarint("#x365af2f05f91b9b4a", 1);
  var_2 = getdvarint("#x32182bc4170853ca7", 5);

  if(var_1) {
    var_0 = getrandombaselayoutindex(var_2);
  }

  if(var_0 == 0) {
    return;
  }
  level endon("game_ended");
  var_3 = [];

  switch (var_0) {
    case 1:
      var_3 = ["_a", "_g"];
      break;
    case 2:
      var_3 = ["_e", "_c"];
      break;
    case 3:
      var_3 = ["_b", "_f"];
      break;
    case 4:
      var_3 = ["_b", "_d", "_f"];
      break;
    case 5:
      var_3 = ["_a", "_b", "_f", "_g"];
      break;
    case 6:
      var_3 = ["_a", "_c", "_e", "_g"];
      break;
    case 7:
      var_3 = ["_d"];
      break;
    case 8:
      var_3 = ["_a", "_b", "_c"];
      break;
    case 9:
      var_3 = ["_e", "_f", "_g"];
      break;
  }

  if(var_3.size == 0) {
    return;
  }
  while(!isDefined(game["flags"]) || !isDefined(game["flags"]["prematch_waitForPlayers_Complete"])) {
    waitframe();
  }

  _id_07D1::_id_60C2("prematch_waitForPlayers_Complete");
  wait 0.5;

  foreach(var_5 in var_3) {
    foreach(var_7 in level._id_A8E8) {
      if(var_7._id_A8E1 == var_5) {
        var_8 = getdvarint("#x378cdc71e4d6d38bc", 7);

        if(isDefined(var_7)) {
          setDvar("#x378cdc71e4d6d38bc", var_8 - 1);
          ontargetbasefornuke(var_7);
          _id_C476(var_7);
          _id_8D94(var_7);
          _id_8DF4(var_7);
          thread _id_A129(var_7, 1);
        }
      }
    }

    wait(randomfloatrange(0.5, 1.5));
  }
}

getrandombaselayoutindex(var_0) {
  if(var_0 <= 2 || var_0 >= 7) {
    return 0;
  }

  var_1 = [];
  var_1[3] = [5, 6];
  var_1[4] = [4, 8, 9];
  var_1[5] = [1, 2, 3];
  var_1[6] = [7];
  return scripts\engine\utility::random(var_1[var_0]);
}

setupmatchdata() {
  level._id_1FE8 = "gw_fob_axisHQ";
  level._id_1513 = "gw_fob_alliesHQ";
  level._id_E6CD = [];
  level._id_E6CE = [];
  level._id_E6CF = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05", "gw_fob_alliesHQ", "gw_fob_axisHQ"];
  level._id_5DF7 = ["gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05", "gw_fob_axisHQ"];
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
  if(!isDefined(level._id_7346)) {
    level._id_7346 = spawnStruct();
  }

  level._id_7346._id_E6D0 = [];
  level._id_7346._id_E6D1 = [];
  level._id_7346._id_E6D2 = [];
  level._id_14F5 = [];
  var_0 = ["_a", "_b", "_c", "_d", "_e", "_f", "_g"];
  var_1 = 0;

  foreach(var_3 in level._id_5DF7) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::_id_6B17(var_3);
    var_4.trigger._id_A90E = var_0[var_1];
    var_1++;
    level._id_14F5[level._id_14F5.size] = var_4;

    if(scripts\engine\utility::array_contains(level._id_E6CD, var_3)) {
      level._id_7346._id_E6D0[level._id_7346._id_E6D0.size] = var_4;
      continue;
    }

    if(scripts\engine\utility::array_contains(level._id_E6CE, var_3)) {
      level._id_7346._id_E6D1[level._id_7346._id_E6D1.size] = var_4;
      continue;
    }

    if(scripts\engine\utility::array_contains(level._id_E6CF, var_3)) {
      level._id_7346._id_E6D2[level._id_7346._id_E6D2.size] = var_4;
    }
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

basecapture_playfireworks() {
  var_0 = "flare_fanfare_lrg_4";

  foreach(var_2 in self.fireworks) {
    playFX(scripts\engine\utility::getfx(var_0), var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles));
  }
}

_id_8159() {
  var_0 = getscriptablearray("build_scriptable", "script_noteworthy");
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4.classname == "scriptable_z_sfps_veh_gate_01_destp_d") {
      var_1[var_1.size] = var_4;
    } else if(var_4.classname == "scriptable_s4_alps_buildable_wall_01_destp") {
      var_2[var_2.size] = var_4;
    }

    var_4.team = "neutral";
  }

  foreach(var_7 in var_1) {
    var_7 setscriptablepartstate("main_part", "open_to_close");
    var_7.health = 800;
    var_7._id_3B8E = 1;
    var_7._id_8967 = 0;
    var_8 = getEntArray(var_7._id_0481, "targetname");

    foreach(var_4 in var_8) {
      if(isDefined(var_4._id_039B) && var_4._id_039B == "open_trigger") {
        var_7._id_AC35 = var_4;
        var_4._id_61DE = var_7;
        continue;
      }

      if(isDefined(var_4._id_039B) && var_4._id_039B == "repair_trigger") {
        var_7._id_C54F = var_4;
        var_4._id_61DE = var_7;
        continue;
      }

      if(isDefined(var_4._id_039B) && var_4._id_039B == "repair_icon") {
        var_7.repairhint = var_4;
        var_4._id_61DE = var_7;
      }
    }

    _id_0AA6::_id_99E8(var_7._id_AC35, ::_id_6207, ::_id_6208);
    _id_0AA6::_id_99E8(var_7._id_C54F, ::_id_6209, ::_id_620A);
    thread buildablegatedamagewatch(var_7);
  }

  foreach(var_13 in var_2) {
    var_13 setscriptablepartstate("main_part", "built");
    var_13.health = 1000;
    var_13._id_3B8E = 1;
    var_8 = getEntArray(var_13._id_0481, "targetname");

    foreach(var_4 in var_8) {
      if(isDefined(var_4._id_039B) && var_4._id_039B == "repair_trigger") {
        var_13._id_C54F = var_4;
        var_4._id_1099D = var_13;
        continue;
      }

      if(isDefined(var_4._id_039B) && var_4._id_039B == "repair_icon") {
        var_13.repairhint = var_4;
        var_4._id_1099D = var_13;
        continue;
      }

      if(isDefined(var_4._id_039B) && var_4._id_039B == "repair_clip") {
        var_13.repairclip = var_4;
        var_13.repairclip._id_AC91 = var_13.repairclip.origin;
        var_4._id_1099D = var_13;
        continue;
      }

      if(isDefined(var_4._id_039B) && var_4._id_039B == "repair_blocker") {
        var_13.repairblocker = var_4;
        var_4._id_1099D = var_13;
      }
    }

    _id_0AA6::_id_99E8(var_13._id_C54F, ::_id_109BD, ::_id_109BE);
    thread buildablewalldamagewatch(var_13);
  }
}

_id_6207(var_0, var_1) {
  if(!isDefined(var_1._id_F396)) {
    var_1._id_F396 = [];
  }

  if(!isDefined(scripts\engine\utility::_id_1BAB(var_1._id_F396, var_0))) {
    var_1._id_F396 = scripts\engine\utility::array_add(var_1._id_F396, var_0);
  }

  if(!istrue(var_1._id_61DE._id_3B8E)) {
    return;
  }
  if(!istrue(var_1._id_8967)) {
    if(var_1._id_61DE.team != "neutral" && var_0.team != var_1._id_61DE.team) {
      if(isDefined(var_0._id_A924) && var_0._id_A924.size > 0) {
        foreach(var_3 in var_0._id_A924) {
          if(var_3.team == var_1._id_61DE.team) {
            break;
          } else
            return;
        }
      } else
        return;
    }

    var_1._id_61DE setscriptablepartstate("main_part", "close_to_open");
    var_1._id_8967 = 1;
    var_0 thread watchtriggerentdeath(var_1);
  }
}

watchtriggerentdeath(var_0) {
  var_0 endon("gate_closing");
  self waittill("death");
  _id_6208(self, var_0);
}

_id_6208(var_0, var_1) {
  if(isDefined(var_1._id_F396) && isDefined(scripts\engine\utility::_id_1BAB(var_1._id_F396, var_0))) {
    var_1._id_F396 = scripts\engine\utility::array_remove(var_1._id_F396, var_0);
  }

  if(!istrue(var_1._id_61DE._id_3B8E)) {
    return;
  }
  if(istrue(var_1._id_8967)) {
    foreach(var_3 in var_1._id_F396) {
      if(scripts\engine\utility::is_equal(var_3.team, var_1._id_61DE.team)) {
        return;
      }
    }

    if(var_1 buildablevehiclecheck(1)) {
      return;
    }
    var_1._id_61DE setscriptablepartstate("main_part", "open_to_close");
    var_1._id_8967 = 0;
    var_1 notify("gate_closing");
  }
}

buildablevehiclecheck(var_0) {
  var_1 = self;
  var_2 = _func_0425(var_1.origin, 300);

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && var_4 istouching(var_1) && isalive(var_4)) {
      if(var_0) {
        var_4 thread buildable_monitorvehicledestruction(var_1);
      }

      return 1;
    }
  }

  return 0;
}

buildable_monitorvehicledestruction(var_0) {
  var_0 endon("gate_closing");
  self waittill("death");
  _id_6208(self, var_0);
}

_id_FC7F(var_0) {
  var_1 = 0;

  if(!isDefined(var_0._id_AC35._id_F396)) {
    var_0._id_AC35._id_F396 = [];
  }

  foreach(var_3 in var_0._id_AC35._id_F396) {
    if(scripts\mp\utility\player::isreallyalive(var_3)) {
      if(var_3.team == var_0.team) {
        var_1 = 1;
        break;
      }
    }
  }

  if(var_0._id_AC35 buildablevehiclecheck(1)) {
    var_1 = 1;
  }

  if(istrue(var_1) && !istrue(var_0._id_AC35._id_8967)) {
    var_0._id_AC35._id_61DE setscriptablepartstate("main_part", "close_to_open");
    var_0._id_AC35._id_8967 = 1;
  } else if(!istrue(var_1) && istrue(var_0._id_AC35._id_8967)) {
    var_0._id_AC35._id_61DE setscriptablepartstate("main_part", "open_to_close");
    var_0._id_AC35._id_8967 = 0;
    var_0._id_AC35 notify("gate_closing");
  }
}

_id_22BB() {
  return "scriptable_z_sfps_veh_gate_01_destp_d";
}

_id_6209(var_0, var_1) {}

_id_620A(var_0, var_1) {}

_id_109BD(var_0, var_1) {}

_id_109BE(var_0, var_1) {}

buildablegatedamagewatch(var_0) {
  var_0 endon("death");
  var_0._id_A54A = 1;
  var_0._id_A599 = 1;
  var_0 _id_07C3::_id_A100();
  var_0 thread _id_07C3::_id_A0FF(800, "hitequip", ::_id_2CEE, ::buildablegatemodifydamage, undefined, undefined, undefined, "hitequip");
}

buildablegatemodifydamage(var_0) {
  if(var_0.attacker.team == var_0._id_103C2.team) {
    return 0;
  }

  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor._id_1031E)) {
    return 0;
  }

  if(var_0.objweapon.basename == "s4_throwing_knife_mp") {
    return 0;
  }

  var_1 = 1;

  switch (var_0._id_9CD6) {
    case "MOD_RIFLE_BULLET":
      var_1 = 0.5;
      break;
    case "MOD_PISTOL_BULLET":
      var_1 = 0.05;
      break;
    case "MOD_MELEE":
      var_1 = 0.5;
      break;
    case "MOD_GRENADE":
      var_1 = 1.25;
      break;
    case "MOD_GRENADE_SPLASH":
      var_1 = 0.5;
      break;
    case "MOD_PROJECTILE":
      var_1 = 1.15;
      break;
    case "MOD_PROJECTILE_SPLASH":
      var_1 = 0.5;
      break;
    case "MOD_EXPLOSIVE":
      var_1 = 3;
      break;
    case "MOD_IMPACT":
      var_1 = 1;

      if(var_0.objweapon.classname == "throwingknife") {
        return 0;
      }

      break;
    default:
      break;
  }

  if(var_0.objweapon _meth_8624("gunperk_wreck")) {
    var_1 = var_1 * 2;
  }

  var_2 = var_0.damage * var_1;
  return var_2;
}

buildablewalldamagewatch(var_0) {
  var_0 endon("death");
  var_0._id_A54A = 1;
  var_0._id_A599 = 1;
  var_0 _id_07C3::_id_A100();
  var_0 thread _id_07C3::_id_A0FF(1000, "hitequip", ::_id_2CF9, ::buildablewallmodifydamage, undefined, undefined, undefined, "hitequip");

  while(var_0._id_014E < 330.0) {
    waitframe();
  }

  if(var_0._id_014E < 660.0) {
    var_0 setscriptablepartstate("main_part", 1);
  }

  while(var_0._id_014E < 660.0) {
    waitframe();
  }

  if(var_0._id_014E <= 1000) {
    var_0 setscriptablepartstate("main_part", 2);
  }

  while(var_0._id_014E < 1000) {
    waitframe();
  }
}

buildablewallmodifydamage(var_0) {
  if(var_0.attacker.team == var_0._id_103C2.team) {
    return 0;
  }

  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor._id_1031E)) {
    return 0;
  }

  if(var_0.objweapon.basename == "s4_throwing_knife_mp") {
    return 0;
  }

  var_1 = 1;

  switch (var_0._id_9CD6) {
    case "MOD_RIFLE_BULLET":
      var_1 = 0.1;
      break;
    case "MOD_PISTOL_BULLET":
      var_1 = 0.05;
      break;
    case "MOD_MELEE":
      var_1 = 0.1;
      break;
    case "MOD_GRENADE":
      var_1 = 1.25;
      break;
    case "MOD_GRENADE_SPLASH":
      var_1 = 0.5;
      break;
    case "MOD_PROJECTILE":
      var_1 = 1.15;
      break;
    case "MOD_PROJECTILE_SPLASH":
      var_1 = 0.5;
      break;
    case "MOD_EXPLOSIVE":
      var_1 = 3;
      break;
    case "MOD_IMPACT":
      var_1 = 1;

      if(var_0.objweapon.classname == "throwingknife") {
        return 0;
      }

      break;
    default:
      break;
  }

  if(var_0.objweapon _meth_8624("gunperk_wreck")) {
    var_1 = var_1 * 2;
  }

  var_2 = var_0.damage * var_1;
  return var_2;
}

_id_2CEE(var_0) {
  var_1 = self;
  var_1._id_3B8E = 0;
  recordbaseactivity(var_0.attacker, "buildableGateDamageDeath");
  var_1 setscriptablepartstate("main_part", "destroyed");
  var_0.attacker _id_07BC::creategametypechallenegeevent("destruction_armsRace");
  buildablegatedeathsetuprepair(var_1);
}

buildablegatedeathsetuprepair(var_0) {
  if(var_0.team == "allies" || var_0.team == "axis") {
    var_0.repairicon = _id_07D6::_id_3FF0(var_0.repairhint.origin, "HINT_BUTTON", undefined, "", 10, "duration_none", "hide", 900, 90, 1, 1);
    var_0 thread basecapturehintset(var_0);
  }

  _id_2CF0(var_0, &"BASE_MODE/REPAIR_WALL", 5);
  var_0._id_C54F thread _id_A0FA();
}

_id_2CF9(var_0) {
  var_1 = self;
  var_1._id_3B8E = 0;
  recordbaseactivity(var_0.attacker, "buildableWallDamageDeath");
  var_1 setscriptablepartstate("main_part", "destroyed");
  var_0.attacker _id_07BC::creategametypechallenegeevent("destruction_armsRace");
  buildablewalldeathsetuprepair(var_1);
}

buildablewalldeathsetuprepair(var_0) {
  if(var_0.team == "allies" || var_0.team == "axis") {
    var_0.repairicon = _id_07D6::_id_3FF0(var_0.repairhint.origin, "HINT_BUTTON", undefined, "", 10, "duration_none", "hide", 900, 90, 1, 1);
    var_0 thread basecapturehintset(var_0);
  }

  _id_2CF0(var_0, &"BASE_MODE/REPAIR_WALL", 5);
  var_0._id_C54F thread _id_A0FB();
}

buildablehintdistance(var_0) {
  self endon("buildable_hint_reset");
  level endon("game_ended");

  foreach(var_2 in var_0) {
    childthread buildablehintdistanceplayer(var_2);
  }

  while(isDefined(self.repairicon)) {
    if(isDefined(self._id_C54F) && isDefined(self._id_C54F._id_FEE8)) {
      var_4 = self._id_C54F getentitynumber();

      if(self._id_C54F buildablevehiclecheck(0)) {
        if(!isDefined(self._id_C54F._id_FEE8._id_FEDD) || self._id_C54F._id_FEE8._id_FEDD != "none") {
          var_5 = &"BASE_MODE/REPAIR_BLOCKED";

          if(isDefined(self._id_61DE)) {
            var_5 = &"BASE_MODE/REPAIR_BLOCKED";
          }

          self._id_C54F._id_FEE8 _id_07D6::_id_D8D0(var_5);
          self._id_C54F._id_FEE8 _id_07D6::_id_D4B1("none");
        }
      } else if(!isDefined(self._id_C54F._id_FEE8._id_FEDD) || self._id_C54F._id_FEE8._id_FEDD != "friendly") {
        var_6 = &"BASE_MODE/REPAIR_WALL";

        if(isDefined(self._id_61DE)) {
          var_6 = &"BASE_MODE/REPAIR_WALL";
        }

        self._id_C54F._id_FEE8 _id_07D6::_id_D8D0(var_6);
        self._id_C54F._id_FEE8 _id_07D6::_id_D4B1("friendly");
      }
    }

    waitframe();
  }
}

buildablehintdistanceplayer(var_0) {
  var_0 endon("disconnect");

  while(isDefined(self.repairicon) && scripts\mp\utility\player::isreallyalive(var_0)) {
    if(var_0 istouching(self._id_C54F)) {
      self.repairicon hidefromplayer(var_0);
    } else {
      self.repairicon showtoplayer(var_0);
    }

    waitframe();
  }
}

buildablegatemonitorstate(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = var_0 _meth_8575("main_part");

    if(var_1 == "destroyed") {
      self._id_620B = scripts\engine\utility::array_remove(self._id_620B, var_0);
      self notify("gate_buildable_destroyed");

      while(var_1 == "destroyed") {
        var_1 = var_0 _meth_8575("main_part");
        waitframe();
      }

      self._id_620B = scripts\engine\utility::array_add(self._id_620B, var_0);
    }

    waitframe();
  }
}

buildablewallmonitorstate(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = var_0 _meth_8575("main_part");

    if(var_1 == "destroyed") {
      self.walls = scripts\engine\utility::array_remove(self.walls, var_0);
      self notify("wall_buildable_destroyed");

      while(var_1 == "destroyed") {
        var_1 = var_0 _meth_8575("main_part");
        waitframe();
      }

      self.walls = scripts\engine\utility::array_add(self.walls, var_0);
    }

    waitframe();
  }
}

basecaptureresetbuildables(var_0) {
  self._id_89FF = 1;

  foreach(var_2 in self.buildables) {
    var_2 thread basecapturebuildablereset(var_0, self);
    waitframe();
  }
}

basecapturebuildablereset(var_0, var_1) {
  self notify("death");
  self setscriptablepartstate("main_part", "destroyed");
  self._id_3B8E = 0;

  if(isDefined(self._id_C54F._id_FEE8)) {
    self._id_C54F._id_FEE8 _id_07D6::_id_4AD1();
  }

  if(isDefined(self.repairicon)) {
    self.repairicon delete();
  }

  wait 3;

  if(self._id_C54F buildablevehiclecheck(0)) {
    if(self.classname == "scriptable_z_sfps_veh_gate_01_destp_d") {
      buildablegatedeathsetuprepair(self);
    } else if(self.classname == "scriptable_s4_alps_buildable_wall_01_destp") {
      buildablewalldeathsetuprepair(self);
    }
  } else {
    self._id_3B8E = 1;

    if(isDefined(self.repairclip)) {
      thread buildablewallrepairclipmove();
    }

    if(self.classname == "scriptable_z_sfps_veh_gate_01_destp_d") {
      self setscriptablepartstate("main_part", "repair_anim");
      thread buildablegatedamagewatch(self);
    } else if(self.classname == "scriptable_s4_alps_buildable_wall_01_destp") {
      self setscriptablepartstate("main_part", "repair_anim");
      thread buildablewalldamagewatch(self);
    }

    var_2 = self _meth_8575("main_part");

    while(var_2 == "repair_anim") {
      var_2 = self _meth_8575("main_part");
      waitframe();
    }

    if(self.classname == "scriptable_z_sfps_veh_gate_01_destp_d") {
      var_3 = [];

      foreach(var_5 in level.players) {
        if(!scripts\mp\utility\player::isreallyalive(var_5)) {
          continue;
        }
        if(var_5.team != self.team) {
          continue;
        }
        if(var_5 istouching(self._id_AC35)) {
          var_3 = scripts\engine\utility::array_add(var_3, var_5);
        }
      }

      if(var_3.size == 0) {
        self setscriptablepartstate("main_part", "open_to_close");
        self._id_AC35._id_8967 = 0;
      }
    }
  }

  var_1._id_89FF = 0;
  self notify("buildable_reset");
}

basecaptureresethints(var_0) {
  foreach(var_2 in self.buildables) {
    var_2 thread basecapturehintset(var_0);
  }
}

basecapturehintset(var_0) {
  self notify("buildable_hint_reset");
  var_1 = var_0.team;

  if(isDefined(self.repairicon) && scripts\mp\utility\player::isreallyalive(var_0)) {
    if(scripts\engine\utility::is_equal(var_1, "allies")) {
      var_2 = scripts\mp\utility\player::_id_6DC4("allies");

      foreach(var_4 in var_2) {
        self.repairicon showtoplayer(var_4);
      }

      thread buildablehintdistance(var_2);
      var_6 = scripts\mp\utility\player::_id_6DC4("axis");

      foreach(var_4 in var_6) {
        self.repairicon hidefromplayer(var_4);
      }
    } else if(scripts\engine\utility::is_equal(var_1, "axis")) {
      var_2 = scripts\mp\utility\player::_id_6DC4("axis");

      foreach(var_4 in var_2) {
        self.repairicon showtoplayer(var_4);
      }

      thread buildablehintdistance(var_2);
      var_6 = scripts\mp\utility\player::_id_6DC4("allies");

      foreach(var_4 in var_6) {
        self.repairicon hidefromplayer(var_4);
      }
    }
  }
}

_id_2CF0(var_0, var_1, var_2) {
  if(istrue(var_0._id_3B8E)) {
    return;
  }
  var_3 = var_0._id_C54F;
  var_4 = 1;
  var_3 makeuseable();

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  _id_2CF2(var_3, var_1, var_2, var_4);
  var_3._id_FEE8 _id_07D6::_id_D639(var_0.team);
  var_3._id_FEE8._id_7C8C = "baseRepair";
  var_3._id_FEE8.useweapon = makeweapon("s4_base_hammer_repair");
}

_id_A0FA() {
  level endon("game_ended");
  self._id_FEE8 _id_07D6::_id_5260();
  self waittill("used");
  self._id_61DE setscriptablepartstate("main_part", "repair_anim");
  self._id_61DE._id_3B8E = 1;
  self._id_FEE8 _id_07D6::_id_4AD1();

  if(isDefined(self._id_61DE.repairicon)) {
    self._id_61DE.repairicon delete();
  }

  var_0 = self._id_61DE _meth_8575("main_part");

  while(var_0 == "repair_anim") {
    var_0 = self._id_61DE _meth_8575("main_part");
    waitframe();
  }

  self notify("repair_complete");
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_3)) {
      continue;
    }
    if(var_3.team != self._id_61DE.team) {
      continue;
    }
    if(var_3 istouching(self._id_61DE._id_AC35)) {
      self._id_61DE._id_AC35._id_F396 = scripts\engine\utility::array_add(self._id_61DE._id_AC35._id_F396, var_3);
      var_3 thread watchtriggerentdeath(self._id_61DE._id_AC35);
    }
  }

  self._id_61DE._id_AC35._id_8967 = 1;
  _id_FC7F(self._id_61DE);
  buildablegatedamagewatch(self._id_61DE);
}

_id_A0FB() {
  level endon("game_ended");
  self._id_FEE8 _id_07D6::_id_5260();
  self waittill("used");

  for(;;) {
    var_0 = [];

    if(isDefined(level._id_1031A)) {
      foreach(var_2 in level._id_1031A) {
        if(!isDefined(var_2)) {
          continue;
        }
        if(!isalive(var_2)) {
          continue;
        }
        if(var_2 istouching(self._id_1099D.repairblocker)) {
          var_0 = scripts\engine\utility::array_add(var_0, var_2);
        }
      }
    }

    waitframe();

    if(var_0.size < 1) {
      break;
    }
  }

  self._id_1099D setscriptablepartstate("main_part", "repair_anim");
  self._id_1099D._id_3B8E = 1;
  self._id_1099D thread buildablewallrepairclipmove();
  self._id_FEE8 _id_07D6::_id_4AD1();

  if(isDefined(self._id_1099D.repairicon)) {
    self._id_1099D.repairicon delete();
  }

  var_4 = self._id_1099D _meth_8575("main_part");

  while(var_4 != "built") {
    var_4 = self._id_1099D _meth_8575("main_part");
    waitframe();
  }

  self notify("repair_complete");
  buildablewalldamagewatch(self._id_1099D);
}

buildablewallrepairclipmove() {
  wait 0.8;
  self.repairclip movez(170, 0.5);
  scripts\engine\utility::_id_108A8(5, "repair_complete", "buildable_reset");
  self.repairclip moveto(self.repairclip._id_AC91, 0.1);
}

_id_2CF2(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 notify("_raidTrigger");
  var_0 endon("_raidTrigger");

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = (0, 0, 0);
  }

  if(isDefined(var_0._id_FEE8)) {
    var_0._id_FEE8 notify("deleted");
    var_0._id_FEE8 = undefined;
  }

  if(var_2 > 0) {
    childthread _id_2CF8(var_0, var_2, var_1, var_3, var_4, var_5);
  } else {
    childthread _id_2CF3(var_0);
  }
}

_id_2CF8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_07D6::_id_406E("neutral", var_0, [], undefined, -1, var_4);
  var_6 _id_07D6::_id_15DF("friendly");
  var_6 _id_07D6::_id_D8D0(var_2);
  var_6 _id_07D6::_id_D8D1(var_2);
  var_6 _id_07D6::_id_D8D2(var_1);
  var_0 setuseholdduration("duration_none");
  var_6._id_ABCB = ::_id_2CF6;
  var_6._id_AA79 = ::_id_2CF4;
  var_6._id_AAC2 = ::_id_2CF5;
  var_6._id_FEE5 = var_3;
  var_6._id_1D79 = 0;
  var_6._id_FE35 = ::buildabletriggerusecondition;
  var_0._id_FEE8 = var_6;
}

_id_2CF3(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);
    _id_2CF7(var_0, var_1);
  }
}

_id_2CF6(var_0) {
  _id_2CF7(self.trigger, var_0);
}

_id_2CF7(var_0, var_1) {
  var_0 notify("used", var_1);
  recordbaseactivity(var_1, "buildableTriggerUsed");
}

_id_2CF4(var_0) {
  if(isPlayer(var_0)) {
    var_0 allowmelee(0);
  }

  self.trigger notify("beginUse", var_0);
}

_id_2CF5(var_0, var_1, var_2) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 allowmelee(1);
  }

  self.trigger notify("endUse", var_1, var_2);
  var_1 setclientomnvar("ui_securing", 0);
}

buildabletriggerusecondition(var_0) {
  if(self.trigger buildablevehiclecheck(0)) {
    return 0;
  }

  return 1;
}

initbuystationicons() {
  var_0 = getEntArray("buystation_icon", "targetname");

  foreach(var_2 in var_0) {
    foreach(var_4 in level._id_14F5) {
      if(scripts\engine\utility::is_equal(var_2._id_039B, var_4.name)) {
        var_2._id_2299 = var_4;
      }
    }

    var_6 = _id_07F9::_id_C57D();
    _id_07F9::_id_A867(var_6, "current", var_2.origin);
    _id_07F9::_id_FB98(var_6, 1);
    var_2._id_2299.trigger._id_60D8._id_A906 = var_6;
    var_2._id_2299 thread buystationreturnid(var_6);
    _id_07F9::_id_A8B1(var_6, 0);
    var_7 = var_2._id_2299.trigger._id_60D8 _id_07D6::_id_6C02();

    if(scripts\engine\utility::is_equal(var_7, "allies") || scripts\engine\utility::is_equal(var_7, "axis")) {
      _id_07F9::_id_A8CA(var_6, var_7);
    } else {
      _id_07F9::_id_A8A0(var_6);
    }

    if(scripts\engine\utility::is_equal(var_2._id_CE18, "vehicle")) {
      _id_07F9::_id_FB8F(var_6, "v_ui_icon_buystation_vehicles_01");
    } else {
      _id_07F9::_id_FB8F(var_6, "v_ui_icon_hud_buystation_generic_00");
    }

    thread buystationicondistanceupdate(var_6, var_2);
  }
}

buystationreturnid(var_0) {
  self waittill("nuked");
  _id_07F9::_id_C799(var_0);
}

buystationiconcaptureupdate(var_0) {
  _id_07F9::_id_A88D(self._id_A906, var_0);
}

redeploystationsinit() {
  _id_07A1::_id_CECC("s4_base_redeploy_map", ::redeploystationused);
}

redeploystationused(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level.gameended)) {
    return;
  }
  if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_3.inlaststand)) {
    return;
  }
  if(var_3 scripts\mp\gametypes\s4_armory_kiosk::_id_8DFD()) {
    return;
  }
  if(!isDefined(self._id_ADAE) || self._id_ADAE != var_3.team) {
    return;
  }
  var_3 notify("redeploynotify", "arms_race_redeploy", 2);
}

redeploystationteamset(var_0) {
  foreach(var_2 in self.redeploystations) {
    var_2._id_ADAE = var_0.team;
  }
}

buystationicondistanceupdate(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_1._id_2299;
  var_2 endon("nuked");
  var_3 = [];

  for(;;) {
    foreach(var_5 in level.players) {
      var_6 = var_5 istouching(var_2.trigger);
      var_7 = var_2.trigger._id_60D8 _id_07D6::_id_6C02() == var_5.team;
      var_8 = isDefined(var_5._id_82F2) && var_5._id_82F2 == 1;

      if(var_6 && var_7 && !var_8) {
        _id_07F9::_id_A89D(var_0, var_5);
        continue;
      }

      _id_07F9::_id_A89E(var_0, var_5);
    }

    waitframe();
  }
}

getbasebytrigger(var_0) {
  var_1 = var_0.origin;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level._id_A8E8) {
    var_7 = var_6.origin;
    var_4 = distancesquared(var_1, var_7);

    if(!isDefined(var_2) || var_4 < var_3) {
      var_2 = var_6;
      var_3 = var_4;
    }
  }

  return var_2;
}

_id_828F() {
  var_0 = getEntArray("sfpsSpawnDamageTrigger", "script_noteworthy");

  if(getdvarint("#x3817d1e9489c28daf", 0) == 1) {
    scripts\engine\utility::_id_1BA4(var_0);
    return;
  }

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_CD99)) {
      _func_0140("WARING: sfpsSpawnDamageTrigger without script_label to associate it with an objective, skipping.");
      continue;
    }

    var_3 = getbasebytrigger(var_2);

    if(!isDefined(var_3)) {
      _func_0140("WARING: sfpsSpawnDamageTrigger script_label '" + var_2._id_CD99 + "' is not a base objective key, skipping.");
      continue;
    }

    var_2 thread _id_A140(var_3);
    var_2 thread monitorgoliathtriggerenter(var_3);
  }
}

monitorgoliathtriggerenter(var_0) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isDefined(level._id_C343) || level._id_C343.size < 1) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_0._id_ADAE, var_1.team)) {
      continue;
    }
    if(var_0._id_ADAE == "neutral") {
      continue;
    }
    if(scripts\engine\utility::array_contains(level._id_C343, var_1)) {
      _id_0A5C::_id_48CE(var_1);
    }
  }
}

_id_A140(var_0) {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(isPlayer(var_1) && scripts\mp\utility\player::isreallyalive(var_1) && !istrue(var_1.innocapturearea)) {
      var_1 thread handleplayerinnocapturearea(self, var_0);
    }

    if(!isPlayer(var_1) || !scripts\mp\utility\player::isreallyalive(var_1) || istrue(var_1._id_82F1)) {
      continue;
    }
    var_2 = var_0 _id_07D6::_id_6C02();
    var_3 = var_2 != "neutral" && var_2 != var_1.team;

    if(var_3) {
      var_1._id_82F1 = 1;
      var_1 thread _id_7482(self, var_0);
      continue;
    }

    var_1 thread _id_A134(self);
  }
}

handleplayerinnocapturearea(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_nocapture_area");
  thread monitorplayerinnocaptureareaend(var_0, var_1);
  self.innocapturearea = 1;
  self.nocaptureareateam = var_1 _id_07D6::_id_6C02();

  for(;;) {
    var_2 = var_1 _id_07D6::_id_6C02();

    if(self.team != var_2) {
      scripts\common\base_warnings::base_warnings_show("not_capturing");
    } else if(self.team == var_2) {
      if(getbasecontestedtier(var_1) >= 1) {
        scripts\common\base_warnings::base_warnings_show("not_defending");
        self notify("base_in_spawnroom_while_contested");
      } else
        scripts\common\base_warnings::base_warning_hide();
    }

    wait 1;
  }
}

monitorplayerinnocaptureareaend(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_nocapture_area");

  for(;;) {
    var_2 = var_1 _id_07D6::_id_6C02();

    if(!self istouching(var_0) || !scripts\mp\utility\player::isreallyalive(self)) {
      self.innocapturearea = 0;
      self.nocaptureareateam = undefined;
      scripts\common\base_warnings::base_warning_hide();
      self notify("end_nocapture_area");
    }

    if(isDefined(self.nocaptureareateam) && var_2 != self.nocaptureareateam) {
      self.nocaptureareateam = var_2;
    }

    wait 0.25;
  }
}

_id_7482(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawnDamageEnd");
  self playlocalsound("ui_mp_splash_outofbounds");
  var_2 = 4;
  self setclientomnvar("ui_out_of_bounds_type", var_2);
  var_3 = int(gettime() + 10000);
  self setclientomnvar("ui_out_of_bounds_countdown", var_3);
  var_4 = var_1 _id_07D6::_id_6C02();
  self._id_E291 = scripts\mp\utility\outline::_id_ACD2(self, var_4, "outline_nodepth_red", "killstreak");
  thread _id_A136(var_0, var_1);
  scripts\common\utility::_id_158D(0);

  for(;;) {
    wait 1;
    var_5 = 20;

    if(isDefined(self.maxhealth)) {
      var_5 = _func_0037(self.maxhealth / 3);
    }

    self dodamage(var_5, var_0.origin, var_0, var_0, "MOD_TRIGGER_HURT");
    self playlocalsound("bullet_small_flesh_torso_plr");
  }
}

_id_A134(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("monitorPlayerLeftCommandCenter");
  self endon("monitorPlayerLeftCommandCenter");
  self._id_3ADE = var_0;

  for(;;) {
    if(!self istouching(var_0) || !scripts\mp\utility\player::isreallyalive(self)) {
      self._id_3ADE = undefined;
      return;
    }

    wait 0.25;
  }
}

_id_A136(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawnDamageEnd");
  self._id_3ADE = var_0;

  for(;;) {
    var_2 = var_1 _id_07D6::_id_6C02();

    if(!self istouching(var_0) || !scripts\mp\utility\player::isreallyalive(self) || self.team == var_2) {
      resetplayerspawndamage();
    }

    wait 0.25;
  }
}

resetplayerspawndamage() {
  self._id_82F1 = 0;
  self._id_3ADE = undefined;
  scripts\mp\utility\outline::outlinedisable(self._id_E291, self);
  self._id_E291 = undefined;
  scripts\common\utility::_id_158D(1);
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  self notify("spawnDamageEnd");
}

initspawndamageboundaryvisuals() {
  var_0 = getEntArray("spawn_room_collision", "targetname");

  foreach(var_2 in var_0) {
    var_3 = level._id_A8E8[var_2._id_CD99];
    var_3.spawn_room_collision_array = scripts\engine\utility::_id_1B8D(var_3.spawn_room_collision_array, var_2);
  }

  var_5 = scripts\engine\utility::getstructarray("spawn_room_boundary", "targetname");

  foreach(var_7 in var_5) {
    var_3 = level._id_A8E8[var_7._id_CD99];
    var_8 = spawn("script_model", var_7.origin);
    var_8.angles = var_7.angles;
    var_8 setModel("tag_origin");
    var_8._id_CD63 = var_7._id_CD63;
    var_8.vfx_structs = [];
    var_3.spawn_room_boundary_points = scripts\engine\utility::_id_1B8D(var_3.spawn_room_boundary_points, var_8);
  }

  foreach(var_3 in level._id_A8E8) {
    level thread updatespawndamageboundaryvisuals(var_3);
  }
}

updatespawndamageboundaryvisuals(var_0) {
  foreach(var_2 in var_0.spawn_room_collision_array) {
    switch (var_0._id_ADAE) {
      case "axis":
      case "allies":
        var_2 show();
        var_2 solid();
        break;
      default:
        var_2 hide();
        var_2 notsolid();
        break;
    }
  }

  foreach(var_5 in var_0.spawn_room_boundary_points) {
    delete_all_fx_on_boundary_struct(var_5);

    switch (var_0._id_ADAE) {
      case "allies":
        switch (var_5._id_CD63) {
          case "standard":
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_blocker_01"), "axis");
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_b_blocker_01"), "allies");
            break;
          case "large":
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_blocker_02"), "axis");
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_b_blocker_02"), "allies");
            break;
          case "tall":
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_blocker_03"), "axis");
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_b_blocker_03"), "allies");
            break;
        }

        break;
      case "axis":
        switch (var_5._id_CD63) {
          case "standard":
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_blocker_01"), "allies");
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_b_blocker_01"), "axis");
            break;
          case "large":
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_blocker_02"), "allies");
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_b_blocker_02"), "axis");
            break;
          case "tall":
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_blocker_03"), "allies");
            create_fx_on_boundary_struct(var_5, scripts\engine\utility::getfx("vfx_ar_base_spawn_b_blocker_03"), "axis");
            break;
        }

        break;
      default:
        switch (var_5._id_CD63) {
          case "standard":
            break;
          case "large":
            break;
          case "tall":
            break;
        }

        break;
    }

    waitframe();
  }
}

create_fx_on_boundary_struct(var_0, var_1, var_2) {
  var_3 = var_0.vfx_structs.size;
  var_0.vfx_structs[var_3] = spawn("script_model", var_0.origin);
  var_0.vfx_structs[var_3].angles = var_0.angles;
  var_0.vfx_structs[var_3] setModel("tag_origin");
  _func_02D4(var_1, var_0.vfx_structs[var_3], "tag_origin", var_2);
}

delete_all_fx_on_boundary_struct(var_0) {
  foreach(var_2 in var_0.vfx_structs) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }

  var_0.vfx_structs = scripts\engine\utility::_id_1BD1(var_0.vfx_structs);
}

_id_CA67(var_0) {
  level._id_1FED = [level._id_1FE8];
  level._id_1516 = [level._id_1513];
  var_1 = getEntArray("buystation_icon", "targetname");
  var_2 = getscriptablearray("build_scriptable", "script_noteworthy");
  var_3 = scripts\engine\utility::getstructarray("fireworks_struct", "script_noteworthy");

  if(istrue(level._id_FE94)) {
    foreach(var_5 in level._id_14F5) {
      var_6 = undefined;

      if(scripts\engine\utility::array_contains(level._id_7346._id_E6D0, var_5)) {
        var_6 = "allies";
      } else if(scripts\engine\utility::array_contains(level._id_7346._id_E6D1, var_5)) {
        var_6 = "axis";
      } else if(scripts\engine\utility::array_contains(level._id_7346._id_E6D2, var_5)) {
        var_6 = "neutral";
      }

      var_7 = _id_CA68(var_5.trigger, var_6);

      foreach(var_9 in var_1) {
        if(scripts\engine\utility::is_equal(var_9._id_039B, var_5.name)) {
          var_7.buystationicon = var_9;
          break;
        }
      }

      var_5.trigger._id_60D8.buildables = _func_00CA("build_scriptable", "script_noteworthy", var_5.trigger.origin, 2000);
      var_5.trigger._id_60D8._id_620B = [];
      var_5.trigger._id_60D8.walls = [];

      foreach(var_12 in var_5.trigger._id_60D8.buildables) {
        if(var_12.classname == "scriptable_z_sfps_veh_gate_01_destp_d") {
          var_5.trigger._id_60D8._id_620B = scripts\engine\utility::array_add(var_5.trigger._id_60D8._id_620B, var_12);
          var_5.trigger._id_60D8 thread buildablegatemonitorstate(var_12);
          continue;
        }

        if(var_12.classname == "scriptable_s4_alps_buildable_wall_01_destp") {
          var_5.trigger._id_60D8.walls = scripts\engine\utility::array_add(var_5.trigger._id_60D8.walls, var_12);
          var_5.trigger._id_60D8 thread buildablewallmonitorstate(var_12);
        }
      }

      var_5.trigger._id_60D8.maxgates = var_5.trigger._id_60D8._id_620B.size;
      var_5.trigger._id_60D8.curgates = var_5.trigger._id_60D8._id_620B.size;
      var_5.trigger._id_60D8.maxwalls = var_5.trigger._id_60D8.walls.size;
      var_5.trigger._id_60D8.curwalls = var_5.trigger._id_60D8.walls.size;
      var_5.trigger._id_60D8.redeploystations = _func_00CA("redeploy_map", "script_noteworthy", var_5.trigger.origin, 2000);

      foreach(var_15 in var_3) {
        if(!isDefined(var_5.trigger._id_60D8.fireworks)) {
          var_5.trigger._id_60D8.fireworks = [];
        }

        if(var_15._id_CD99 == var_5.name) {
          var_5.trigger._id_60D8.fireworks[var_5.trigger._id_60D8.fireworks.size] = var_15;
        }
      }

      var_7 thread _id_A0F7();

      if(var_6 == "allies" || var_6 == "axis") {
        if(var_6 == "allies") {
          level._id_1516[level._id_1516.size] = var_5.name;
        } else {
          level._id_1FED[level._id_1FED.size] = var_5.name;
        }

        if(isDefined(level._id_E371[var_5.name][var_6]._id_1782)) {
          level._id_E371[var_5.name][var_6]._id_1782.origin = var_5.trigger.origin + (0, 0, 100);
        }
      }
    }

    foreach(var_5 in level._id_14F5) {
      var_5.trigger._id_60D8._id_AA8D = ::_id_A891;
      var_5.trigger._id_60D8._id_ABC7 = ::_id_A893;
      var_5.trigger._id_60D8._id_ABCB = ::_id_A895;
      var_5.trigger._id_60D8._id_ABD4 = ::_id_A898;
      var_5.trigger._id_60D8._id_AA79 = ::_id_A896;
      var_5.trigger._id_60D8._id_AAC2 = ::_id_A897;
      var_5.trigger._id_60D8._id_AB54 = ::_id_A892;
      var_5.trigger._id_60D8._id_ABC9 = ::_id_A894;
      var_5.trigger._id_60D8._id_A732 = getbaseexploderid(var_5.trigger._id_60D8);
      level._id_A8E8[var_5.trigger._id_60D8._id_A8E1] = var_5.trigger._id_60D8;
      level._id_A8E8[var_5.trigger._id_60D8._id_A8E1].nuke_spawn_nodes = [];
      level._id_A8E8[var_5.trigger._id_60D8._id_A8E1].postnuke_spawn_nodes = [];
      level._id_E371[var_5.name]["allies"]._id_A8E1 = var_5.trigger._id_60D8._id_A8E1;
      level._id_E371[var_5.name]["axis"]._id_A8E1 = var_5.trigger._id_60D8._id_A8E1;
      var_5.trigger._id_60D8 thread monitorobjectivestate();
      var_5.trigger._id_60D8 thread monitorbuildablevo();
      var_5.trigger._id_60D8 thread monitorcapturealarm();
    }
  }

  _id_0819::_id_D6D8(level._id_1FED, "axis");
  _id_0819::_id_D6D8(level._id_1516, "allies");

  while(!isDefined(level._id_E371)) {
    waitframe();
  }

  waitframe();
  var_20 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1513);
  var_21 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1FE8);

  if(isDefined(level._id_E371[level._id_1FE8]["axis"]._id_1782)) {
    level._id_E371[level._id_1FE8]["axis"]._id_1782.origin = var_21.origin;
  }

  if(isDefined(level._id_E371[level._id_1513]["allies"]._id_1782)) {
    level._id_E371[level._id_1513]["allies"]._id_1782.origin = var_20.origin;
  }

  thread _id_828F();
  thread initspawndamageboundaryvisuals();
  level thread initnukezones();
  level thread base_vehiclelist_monitor();
  thread _id_8159();
  thread initbuystationicons();
  thread redeploystationsinit();
  thread scripts\mp\gametypes\s4_base_util::initbaselights();
  _id_7361();
}

monitorobjectivestate() {
  level endon("game_ended");
  self.objectivestate = "unowned";
  level waittill("prematch_done");

  for(;;) {
    if(self._id_4143 > 0) {
      if(self._id_ADAE == "allies") {
        var_0 = "allies_contested";
      } else if(self._id_ADAE == "axis") {
        var_0 = "axis_contested";
      } else {
        var_0 = "neutral_contested";
      }
    } else if(self._id_ADAE == "allies")
      var_0 = "allies_captured";
    else if(self._id_ADAE == "axis") {
      var_0 = "axis_captured";
    } else {
      var_0 = "unowned";
    }

    if(var_0 != self.objectivestate) {
      switch (var_0) {
        case "allies_captured":
          base_analytics_finishcapturebase(self);
          break;
        case "axis_captured":
          base_analytics_finishcapturebase(self);
          break;
        case "neutral_contested":
          base_analytics_capturingbase(self);
          break;
        case "axis_contested":
          base_analytics_capturingbase(self);
          break;
        case "allies_contested":
          base_analytics_capturingbase(self);
          break;
      }

      switch (self.objectivestate) {
        case "neutral_contested":
          if(var_0 == "axis_captured" || var_0 == "allies_captured") {
            scripts\mp\gametypes\s4_base_util::base_dialogonplayersinbase(self, undefined, "base_neutral_captured", "base_capture", 1, 1.4, 0, 0);
            level thread updatespawndamageboundaryvisuals(self);
          }

          break;
        case "allies_contested":
          if(var_0 == "axis_captured") {
            scripts\mp\gametypes\s4_base_util::base_dialogonplayersinbase(self, "axis", "base_hostile_captured", "base_capture", 1, 1.4, 0, 0);
            scripts\mp\gametypes\s4_base_util::base_dialogonplayersinbase(self, "allies", "base_friendly_lost", "base_capture", 1, 0, 0, 0);
            level thread updatespawndamageboundaryvisuals(self);
          }

          break;
        case "axis_contested":
          if(var_0 == "allies_captured") {
            scripts\mp\gametypes\s4_base_util::base_dialogonplayersinbase(self, "allies", "base_hostile_captured", "base_capture", 1, 1.4, 0, 0);
            scripts\mp\gametypes\s4_base_util::base_dialogonplayersinbase(self, "axis", "base_friendly_lost", "base_capture", 1, 0, 0, 0);
            level thread updatespawndamageboundaryvisuals(self);
          }

          break;
      }

      self.objectivestate = var_0;
      _id_FC69();
      _id_FD5D();
    }

    waitframe();
  }
}

monitorbuildablevo() {
  level endon("game_ended");
  var_0 = 5;
  self.buildablevolines = ["gate_breach_multiple_friendly", "gate_breach_friendly", "wall_breach_multiple_friendly", "wall_breach_friendly"];

  for(;;) {
    var_1 = scripts\engine\utility::_id_10897("gate_buildable_destroyed", "wall_buildable_destroyed");

    if(istrue(self._id_89FF)) {
      continue;
    }
    var_2 = undefined;

    if(var_1 == "gate_buildable_destroyed") {
      if(self._id_620B.size < self.maxgates / 2) {
        var_2 = "gate_breach_multiple_friendly";
      } else {
        var_2 = "gate_breach_friendly";
      }
    } else if(var_1 == "wall_buildable_destroyed") {
      if(self.walls.size < self.maxwalls / 2) {
        var_2 = "wall_breach_multiple_friendly";
      } else {
        var_2 = "wall_breach_friendly";
      }
    }

    if(!scripts\engine\utility::array_contains(self.buildablevolines, var_2)) {
      continue;
    }
    scripts\mp\gametypes\s4_base_util::base_dialogonplayersinbase(self, self._id_ADAE, var_2, "buildable_destroy", 1, 1, 0, 0);
    self.buildablevolines = scripts\engine\utility::array_remove(self.buildablevolines, var_2);
    thread buildablevocooldown(var_2, var_0);
    waitframe();
  }
}

buildablevocooldown(var_0, var_1) {
  wait(var_1);
  self.buildablevolines = scripts\engine\utility::array_add(self.buildablevolines, var_0);
}

monitorcapturealarm() {
  for(;;) {
    waitframe();

    if(self._id_ADAE == "neutral") {
      continue;
    }
    if(scripts\engine\utility::is_equal(self._id_37F6, "axis") || scripts\engine\utility::is_equal(self._id_37F6, "allies") || istrue(self._id_E57B)) {
      thread monitorcapturealarmstop();
      var_0 = self._id_4140;
      scripts\mp\gametypes\arms_race_audio::contested_base_alarm_sfx(var_0);
    }
  }
}

_id_FD5D() {
  var_0 = getbasearrayoftype(level._id_A8E8, "allies").size;
  var_1 = getbasearrayoftype(level._id_A8E8, "axis").size;
  game["teamScores"]["allies"] = var_0;
  game["teamScores"]["axis"] = var_1;
  _func_01F8("allies", int(var_0));
  _func_01F8("axis", int(var_1));
}

monitorcapturealarmstop() {
  while(scripts\engine\utility::is_equal(self._id_37F6, "axis") || scripts\engine\utility::is_equal(self._id_37F6, "allies") || istrue(self._id_E57B)) {
    waitframe();
  }

  self notify("snd_stop_contested_alarm");
}

getbaseindex(var_0) {
  var_1 = var_0._id_A8E1;
  var_2 = ["_a", "_b", "_c", "_d", "_e", "_f", "_g"];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] == var_1) {
      return var_3 + 1;
    }
  }

  return 0;
}

getbaseexploderid(var_0) {
  var_1 = var_0._id_A8E1;

  if(level.mapname == "mp_ar_alps") {
    switch (var_1) {
      case "_a":
        return 201;
      case "_b":
        return 202;
      case "_c":
        return 203;
      case "_d":
        return 204;
      case "_e":
        return 205;
      case "_f":
        return 206;
      case "_g":
        return 207;
      default:
        return undefined;
    }
  } else
    return undefined;
}

_id_A887() {
  wait 1;

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

  if(!isDefined(level._id_E377)) {
    var_0 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1513);
    var_1 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1FE8);
    level._id_E377 = [];
    level._id_E377["allies"] = vectornormalize(var_1.origin - var_0.origin);
    level._id_E377["axis"] = vectornormalize(var_0.origin - var_1.origin);
  }

  var_2 = "allies";
  var_3 = level._id_E377[var_2];
  var_4 = ["gw_fob_alliesHQ", "gw_fob_axisHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];

  foreach(var_6 in var_4) {
    if(getdvarint("#x332c8a7db9737b21b", 1) == 1) {
      var_7 = level._id_E371["gw_fob_03"][var_2]._id_1782.origin;
      var_8 = var_7 + (0, 0, 17000);
      level._id_E278[var_6][var_2].origin = var_8;
      level._id_E278[var_6][var_2].angles = (90, 0, -90);
      continue;
    }

    var_7 = level._id_E371[var_6][var_2]._id_1782.origin;
    var_8 = var_7 + var_3 * -8500 + (0, 0, 7000);
    var_9 = vectornormalize(var_7 - var_8);
    var_10 = scripts\mp\utility\script::_id_FFE3(var_9, (0, 0, 1));

    if(istrue(level._id_FEF0)) {
      var_11 = _id_0819::_id_6E1F();
      var_8 = (var_8[0], var_8[1], var_11);
    }

    var_8 = var_8 + _id_2EE0(var_2, var_7);
    level._id_E278[var_6][var_2].origin = var_8;
    level._id_E278[var_6][var_2].angles = var_10;
  }

  while(!isDefined(level._id_E278["gw_fob_axisHQ"])) {
    waitframe();
  }

  var_2 = "axis";
  var_3 = level._id_E377[var_2];
  var_4 = ["gw_fob_alliesHQ", "gw_fob_axisHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];

  foreach(var_6 in var_4) {
    if(getdvarint("#x332c8a7db9737b21b", 1) == 1) {
      var_7 = level._id_E371["gw_fob_03"][var_2]._id_1782.origin;
      var_8 = var_7 + (0, 0, 17000);
      level._id_E278[var_6][var_2].origin = var_8;
      level._id_E278[var_6][var_2].angles = (90, 0, -90);
      continue;
    }

    var_7 = level._id_E371[var_6][var_2]._id_1782.origin;
    var_8 = var_7 + var_3 * -8500 + (0, 0, 7000);
    var_9 = vectornormalize(var_7 - var_8);
    var_10 = scripts\mp\utility\script::_id_FFE3(var_9, (0, 0, 1));

    if(istrue(level._id_FEF0)) {
      var_11 = _id_0819::_id_6E1F();
      var_8 = (var_8[0], var_8[1], var_11);
    }

    var_8 = var_8 + _id_2EE0(var_2, var_7);
    level._id_E278[var_6][var_2].origin = var_8;
    level._id_E278[var_6][var_2].angles = var_10;
  }
}

fobspawnselection_init() {
  _id_07D1::_id_60C2("prematch_done");

  while(!isDefined(level._id_232A)) {
    waitframe();
  }

  _id_FC69();
}

_id_FC69() {
  if(istrue(_id_07D1::_id_60BE("prematch_done"))) {
    level._id_1FED = [];
    level._id_1516 = [];
  }

  foreach(var_1 in level._id_14F5) {
    var_2 = var_1.trigger._id_60D8;
    var_3 = getbasecontestedtier(level._id_A8E8[var_1.trigger._id_A90E]);

    if(scripts\engine\utility::is_equal(var_2._id_37F6, "none") || scripts\engine\utility::is_equal(var_2._id_37F6, var_2._id_ADAE)) {
      if(var_2._id_ADAE == "axis" && scripts\engine\utility::array_contains(level._id_232A, var_2)) {
        level._id_1FED[level._id_1FED.size] = var_1.name;

        if(isDefined(level._id_E371[var_1.name]["axis"]._id_1782)) {
          level._id_E371[var_1.name]["axis"]._id_1782.origin = var_1.trigger.origin + (0, 0, 100);
        }

        continue;
      }

      if(var_2._id_ADAE == "allies" && scripts\engine\utility::array_contains(level._id_232A, var_2)) {
        level._id_1516[level._id_1516.size] = var_1.name;

        if(isDefined(level._id_E371[var_1.name]["allies"]._id_1782)) {
          level._id_E371[var_1.name]["allies"]._id_1782.origin = var_1.trigger.origin + (0, 0, 100);
        }
      }
    }
  }

  level.axisspawnairdeploy = _id_D074("axis");
  level.alliesspawnairdeploy = _id_D074("allies");

  if(level._id_1FED.size == 0) {
    level._id_1FED = level.axisspawnairdeploy;
  }

  if(level._id_1516.size == 0) {
    level._id_1516 = level.alliesspawnairdeploy;
  }

  _id_0819::_id_D6D8(level._id_1FED, "axis");
  _id_0819::_id_D6D8(level._id_1516, "allies");
}

_id_D074(var_0) {
  if(!isDefined(var_0)) {
    return [];
  }

  var_1 = [];
  var_2 = undefined;

  foreach(var_5, var_4 in level._id_A8E8) {
    if(var_4._id_ADAE == "neutral" && scripts\engine\utility::array_contains(level._id_232A, var_4)) {
      var_1[var_1.size] = var_5;
    }
  }

  if(var_1.size > 0) {
    var_6 = undefined;

    if(var_0 == "allies") {
      var_6 = scripts\common\utility::_id_C94D((var_1.size - 1) / 2);
    } else if(var_0 == "axis") {
      var_6 = scripts\mp\utility\script::rounddown((var_1.size - 1) / 2);
    }

    var_2 = var_1[var_6];
  } else {
    var_7 = getbasesowned_notbeingnuked(var_0);

    if(var_7.size > 0) {
      return var_7;
    } else {
      var_8 = int((level._id_A8E8.size - 1) / 2);
      var_9 = getarraykeys(level._id_A8E8);
      var_2 = var_9[var_8];
    }
  }

  return [level._id_A8E8[var_2].trigger._id_0481];
}

getbasesowned_notbeingnuked(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_14F5) {
    var_4 = var_3.trigger._id_60D8;

    if(var_4._id_ADAE == var_0 && scripts\engine\utility::array_contains(level._id_232A, var_4)) {
      var_1[var_1.size] = var_3.name;
    }
  }

  return var_1;
}

_id_D5A9() {
  var_0 = "any";
  var_1 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1513);
  var_2 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1FE8);
  var_3 = var_2.origin;
  var_4 = _id_07D6::_id_4026(var_3, "neutral", (0, 0, 0), undefined, var_0, 0);
  _id_07F9::_id_FB96(var_4._id_A908, "axis");
  _id_07F9::_id_A8C8(var_4._id_A908, "axis");
  _id_07F9::_id_A8B1(var_4._id_A908, 0);
  var_4._id_970A = 0;
  _id_07F9::_id_A89A(var_4._id_A908, 0);
  _id_07F9::_id_FB8F(var_4._id_A908, "icon_waypoint_hq_friendly");
  _id_07F9::_id_FB98(var_4._id_A908, 6);
  var_4._id_970A = 1;
  level._id_7346._id_1FE7._id_9B4D = var_4;
  level._id_F935[level._id_F935.size] = var_4;
  var_4 = _id_07D6::_id_4026(var_3, "neutral", (0, 0, 0), undefined, var_0, 0);
  _id_07F9::_id_FB96(var_4._id_A908, "axis");
  _id_07F9::_id_A8C8(var_4._id_A908, "allies");
  _id_07F9::_id_A8B1(var_4._id_A908, 0);
  var_4._id_970A = 0;
  _id_07F9::_id_A89A(var_4._id_A908, 0);
  _id_07F9::_id_FB8F(var_4._id_A908, "icon_waypoint_hq_enemy");
  _id_07F9::_id_FB98(var_4._id_A908, 7);
  var_4._id_970A = 1;
  level._id_7346._id_1FE7._id_541F = var_4;
  level._id_F935[level._id_F935.size] = var_4;
  var_3 = var_1.origin;
  var_4 = _id_07D6::_id_4026(var_3, "neutral", (0, 0, 0), undefined, var_0, 0);
  _id_07F9::_id_FB96(var_4._id_A908, "allies");
  _id_07F9::_id_A8C8(var_4._id_A908, "allies");
  _id_07F9::_id_A8B1(var_4._id_A908, 0);
  var_4._id_970A = 0;
  _id_07F9::_id_A89A(var_4._id_A908, 0);
  _id_07F9::_id_FB8F(var_4._id_A908, "icon_waypoint_hq_friendly");
  _id_07F9::_id_FB98(var_4._id_A908, 6);
  var_4._id_970A = 1;
  level._id_7346._id_1512._id_9B4D = var_4;
  level._id_F935[level._id_F935.size] = var_4;
  var_4 = _id_07D6::_id_4026(var_3, "neutral", (0, 0, 0), undefined, var_0, 0);
  _id_07F9::_id_FB96(var_4._id_A908, "allies");
  _id_07F9::_id_A8C8(var_4._id_A908, "axis");
  _id_07F9::_id_A8B1(var_4._id_A908, 0);
  var_4._id_970A = 0;
  _id_07F9::_id_A89A(var_4._id_A908, 0);
  _id_07F9::_id_FB8F(var_4._id_A908, "icon_waypoint_hq_enemy");
  _id_07F9::_id_FB98(var_4._id_A908, 7);
  var_4._id_970A = 1;
  level._id_7346._id_1512._id_541F = var_4;
  level._id_F935[level._id_F935.size] = var_4;
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

  foreach(var_1 in level._id_EF89) {
    if(self._id_F396[var_1].size) {
      foreach(var_3 in self._id_F396[var_1]) {
        recordbaseactivity(var_3.player, "objective_OnContested");
      }
    }
  }
}

_id_A893(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4C(var_0);
}

_id_A896(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D50(var_0);
}

_id_A897(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::_id_4D51(var_0, var_1, var_2);

  if(istrue(var_2)) {
    _id_34E4(var_1.origin, var_1.team);
  }
}

_id_A895(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4F(var_0);
  recordbaseactivity(var_0, "objective_OnUse");

  if(getdvarint("#x38e35c13cd32e8837", 1) == 1) {
    thread basecaptureresetbuildables(var_0);
  }

  thread buystationiconcaptureupdate(var_0);
  thread basecaptureresethints(var_0);
  thread redeploystationteamset(var_0);
  thread basecapture_playfireworks();
}

_id_A898(var_0, var_1, var_2, var_3) {
  var_4 = _id_07D6::_id_6C02();

  if(var_4 == "neutral") {
    if(var_2 >= 0.0008) {
      var_3 _id_0A8D::_id_9137("base_neutral_capturing", "base_capture", 0, undefined, 45, 1);
    }
  } else if(var_4 != var_0) {
    if(var_2 >= 0.00053) {
      var_3 _id_0A8D::_id_9137("base_hostile_capturing", "base_capture", 0, undefined, 45, 1);
    } else {
      var_3 _id_0A8D::_id_9137("base_hostile_capturing_contested", "base_capture", 1, undefined, 45, 0);
    }
  } else if(var_4 == var_0) {
    if(var_2 >= 0.00053) {
      var_3 _id_0A8D::_id_9137("base_friendly_defending", "base_capture", 0, undefined, 45, 1);
    } else {
      var_3 _id_0A8D::_id_9137("base_friendly_defending_contested", "base_capture", 1, undefined, 45, 0);
    }
  }

  foreach(var_0 in level._id_EF89) {
    if(self._id_F396[var_0].size) {
      foreach(var_7 in self._id_F396[var_0]) {
        recordbaseactivity(var_7.player, "objective_OnUseUpdate");
      }
    }
  }
}

_id_A892(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4E(var_0);

  if(isDefined(var_0) && istrue(var_0._id_A72C)) {
    if(istrue(level._id_82D1)) {
      return 0;
    }

    var_1 = _id_6972(var_0.origin);

    if(!isDefined(var_1) || !isDefined(level._id_A8E8[var_1])) {
      return;
    }
    if(level._id_A8E8[var_1]._id_ADAE == var_0.team) {
      if(isDefined(var_0.vehicle)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_10182(var_0.vehicle, undefined, var_0, undefined, 1);
      }

      foreach(var_3 in level.players) {
        if(var_0.team != var_3.team) {
          continue;
        }
        if(var_0.guid == var_3.guid) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_3)) {
          continue;
        }
        foreach(var_5 in var_3.escortedteammates) {
          if(var_5.guid == var_0.guid) {
            var_3 setclientomnvar("ui_base_objective_deliver_complete", gettime());
            var_3 _id_1099("crate_escort_success");
          }
        }
      }

      var_0 setclientomnvar("ui_base_objective_deliver_complete", gettime());
      var_0 _id_1099("crate_delivery_success");
      waitframe();

      if(!scripts\mp\utility\player::isreallyalive(var_0)) {
        return;
      }
      level notify("nuke_crate_captured", var_0.team, var_0);
      var_0 notify("nuke_crate_captured");
    }
  }
}

_id_A894(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4E(var_0);
}

_id_6972(var_0) {
  foreach(var_2 in level._id_A8E8) {
    var_3 = distancesquared(var_0, var_2.origin);

    if(var_3 < 9000000) {
      return var_2._id_A8E1;
    }
  }

  return undefined;
}

_id_4D40() {}

_id_CA68(var_0, var_1) {
  level endon("game_ended");

  while(!isDefined(level._id_E371)) {
    waitframe();
  }

  var_0._id_CD99 = var_0._id_A90E;
  var_2 = scripts\mp\gametypes\obj_dom::_id_D896(var_0, undefined, 1, undefined, 0);
  var_2.origin = var_0.origin;
  var_2 _id_07D6::_id_15DF("enemy");
  var_2._id_497A = 0;
  var_2 _id_07D6::_id_D639(var_1);
  var_2._id_FE35 = ::basecaptureusecondition;
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

basecaptureusecondition(var_0) {
  if(var_0 _meth_86B7() || var_0 _meth_86B8() || var_0 isskydiving()) {
    return 0;
  }

  if(istrue(var_0._id_B072)) {
    return 0;
  }

  return 1;
}

_id_A0F7() {
  level endon("game_ended");
  level waittill("prematch_done");

  for(;;) {
    if(self._id_ADAE == "neutral") {
      var_0 = "neutral";
    } else {
      var_0 = scripts\mp\utility\game::_id_6BE2(self._id_ADAE)[0];
    }

    if(self._id_ADAE == "neutral" || !isDefined(self._id_F396[var_0]) || self._id_F396[var_0].size == 0) {
      wait 5;
      continue;
    }

    foreach(var_2 in self._id_F396[var_0]) {
      _func_02DC(var_2.player.origin, self._id_ADAE, 10);
    }

    wait 5;
  }
}

nuke_crate_init() {
  level.base_max_nuke_crates = getdvarint("#x3a0d033473748d121", 1);

  if(level.base_max_nuke_crates == 0) {
    level.base_max_nuke_crates = 1;
  }

  level.base_fixed_nuke_intervals = [];
  level.base_fixed_nuke_intervals[0] = getdvarfloat("#x3135678a3a965289c", 180);

  if(level.base_fixed_nuke_intervals[0] == 0) {
    level.base_fixed_nuke_intervals[0] = 180;
  }

  level.base_fixed_nuke_interval_default = getdvarfloat("#x3c76f97b2230ffca5", 120);

  while(!isDefined(level._id_A8E8) || level._id_A8E8.size == 0) {
    waitframe();
  }

  baseconnections_init();
  level.nuke_spawn_nodes = scripts\engine\utility::getstructarray("nuke_spawn_node", "targetname");
  level.nuke_crate_spawns_and_carriers = [];
  level.nuke_crate_neutral_count = 0;
  level.postnuke_spawn_nodes = [];

  foreach(var_1 in level.nuke_spawn_nodes) {
    var_1.nearby_bases = [];
    var_1.ispoi = 0;
    var_1.num_spawns = 0;

    if(isDefined(var_1._id_CD99)) {
      var_2 = strtok(var_1._id_CD99, ",");
    } else {
      var_2 = [];
      scripts\engine\utility::_id_5598("Nuke crate spawn struct doesn't have script_label definitions for nearby bases " + var_1.origin);
    }

    var_3 = ["_a", "_b", "_c", "_d", "_e", "_f", "_g"];

    foreach(var_5 in var_2) {
      switch (var_5) {
        case "_d":
        case "_f":
        case "_e":
        case "_g":
        case "_c":
        case "_a":
        case "_b":
          var_1.nearby_bases = scripts\engine\utility::array_add(var_1.nearby_bases, var_5);

          if(!scripts\engine\utility::array_contains(var_2, "postnuke")) {
            level._id_A8E8[var_5].nuke_spawn_nodes = scripts\engine\utility::array_add(level._id_A8E8[var_5].nuke_spawn_nodes, var_1);
          } else {
            level._id_A8E8[var_5].postnuke_spawn_nodes = scripts\engine\utility::array_add(level._id_A8E8[var_5].postnuke_spawn_nodes, var_1);
          }

          break;
        case "poi":
          var_1.ispoi = 1;
          break;
        case "postnuke":
          level.postnuke_spawn_nodes = scripts\engine\utility::_id_1B9D(level.postnuke_spawn_nodes, [var_1]);
          break;
        default:
          scripts\engine\utility::_id_5598("nuke_spawn_node has unknown script_label entry. Valid comma-delineated entries are base tags or 'poi' or 'postnuke'");
          break;
      }
    }
  }

  level.nuke_spawn_nodes = scripts\engine\utility::_id_1BBF(level.nuke_spawn_nodes, level.postnuke_spawn_nodes);
}

spawnnukesatintervals() {
  level endon("game_ended");
  level.pending_nuke_crate_spawns = 0;
  var_0 = 0;
  level waittill("prematch_done");

  for(;;) {
    if(shouldspawnnewnukecrate()) {
      if(var_0 >= level.base_fixed_nuke_intervals.size) {
        var_1 = level.base_fixed_nuke_interval_default;
      } else {
        var_1 = level.base_fixed_nuke_intervals[var_0];
      }

      var_2 = var_1;

      for(var_3 = 0; var_3 < var_1; var_3++) {
        if(level.nuke_crate_neutral_count > 0) {
          setomnvar("ui_base_objective_nebula_time", 0);
        } else {
          setomnvar("ui_base_objective_nebula_time", var_2);
        }

        wait 1;
        var_2 = var_2 - 1;
      }

      setomnvar("ui_base_objective_nebula_time", var_2);
      level thread _id_E32E();
      var_0++;
    } else {
      if(level.nuke_crate_neutral_count > 0) {
        setomnvar("ui_base_objective_nebula_time", 0);
      } else {
        setomnvar("ui_base_objective_nebula_time", -1);
      }

      wait 1;
    }

    waitframe();
  }
}

shouldspawnnewnukecrate() {
  if(istrue(level._id_82D1)) {
    return 0;
  }

  if(getdvarint("#x3f6f82a171abdd70e", 1) == 1) {
    if(level.nuke_crate_spawns_and_carriers.size + level.pending_nuke_crate_spawns < level.base_max_nuke_crates) {
      return 1;
    }
  }

  return 0;
}

_id_E32E() {
  level endon("game_ended");
  level.nuke_crate_neutral_count++;
  level.pending_nuke_crate_spawns++;
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_0 = _id_5AFD();

    if(isDefined(var_0)) {
      break;
    }

    wait 5;
  }

  level.pending_nuke_crate_spawns--;
  var_1 = undefined;

  if(isDefined(level.next_nuke_spawner)) {
    var_1 = level.next_nuke_spawner;
    level.next_nuke_spawner.num_spawns++;
    level.next_nuke_spawner = undefined;
    level.nuke_crate_spawns_and_carriers = scripts\engine\utility::array_add(level.nuke_crate_spawns_and_carriers, var_1);
  }

  var_2 = 1;
  var_3 = spawn("script_model", var_0);
  var_3 setModel("ks_crate_marker_mp");
  var_3 setscriptablepartstate("smoke", "on", 0);
  var_4 = _id_07F9::_id_C57D();
  _id_07F9::_id_A867(var_4, "current", var_0 + (0, 0, 100), level.leveldata._id_9F23);
  _id_07F9::_id_A8B1(var_4, 0);
  _id_07F9::_id_FB98(var_4, 6);
  thread base_hideobjectivedistance_toplayersinspawnselection(var_4);
  var_1._id_413F = var_4;

  if(!istrue(level._id_82D1)) {
    _id_0A8D::_id_E775("crate_incoming", "axis");
    _id_0A8D::_id_E775("crate_incoming", "allies");
  }

  foreach(var_6 in level.players) {
    if(isalive(var_6)) {
      var_6 thread scripts\mp\hud_message::showsplash("nuke_crate_spawn", 0);
    }
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_2);
  var_8 = scripts\cp_mp\killstreaks\airdrop::_id_502A(undefined, undefined, "base_nuke", var_0, (0, 0, 0), var_0 + (0, 0, -1300));
  var_8._id_7C8C = "care_package";
  var_9 = var_8._id_3E9B;
  var_10 = getarraykeys(var_9);
  var_11 = var_8._id_3E9B[var_10[0]];
  var_11._id_03E9 = var_1;
  var_11 scripts\engine\utility::waittill_any_3("timedout", "death", "activateCrate");
  level thread nukecrate_objectiveinit(var_11);
  level thread delayremovenukecratetracking(var_1);
  level.nuke_crate_neutral_count--;
  var_11 _meth_83A2();
  var_11 sethintstring(&"MP/ARMSRACE_CRATE_PICKUP");
  var_1._id_413F = undefined;
  _id_07F9::_id_C799(var_4);
  waitframe();
  var_3 delete();
}

nukecrate_objectiveinit(var_0, var_1) {
  level.nuke_crate_spawns_and_carriers = scripts\engine\utility::array_add(level.nuke_crate_spawns_and_carriers, var_0);
  level.nuke_crate_neutral_count++;

  if(!istrue(level._id_82D1)) {
    _id_0A8D::_id_E775("crate_available", "axis", "crate_available_axis", undefined, undefined, 45, 1);
    _id_0A8D::_id_E775("crate_available", "allies", "crate_available_allies", undefined, undefined, 45, 1);
  }

  var_0 scripts\cp_mp\killstreaks\airdrop::_id_4859();

  if(!isDefined(var_1)) {
    var_1 = _id_07F9::_id_C57D();
  }

  _id_07F9::_id_A867(var_1, "current", var_0.origin, level.leveldata._id_9F23);
  _id_07F9::_id_A8B1(var_1, 0);
  _id_07F9::_id_FB98(var_1, 6);
  _id_07F9::_id_FB93(var_1, var_0);
  _id_07F9::_id_FB9D(var_1, 100);
  thread base_hideobjectivedistance_toplayersinspawnselection(var_1);
  var_0._id_413F = var_1;
  level thread nukecrate_onusemonitor(var_0);
  level thread nukecrate_objectiveinit_cleanup(var_0, var_1);
  waitframe();
  var_0 nukecrate_monitornukezone();

  if(var_0 scripts\mp\outofbounds::_id_8AAA()) {
    var_0 scripts\cp_mp\killstreaks\airdrop::_id_4843();
  }
}

nukecrate_onusemonitor(var_0) {
  var_0 endon("timedout");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!istrue(level._id_82D1)) {
      _id_0A8D::_id_E775("crate_capturing_hostile", scripts\mp\utility\game::_id_6BE2(var_1.team)[0], "crate_capturing_hostile", undefined, undefined, 45, 1);
      var_1 _id_0A8D::_id_9137("crate_capturing_friendly", "crate_capturing", 0, undefined, 45, 1);
      wait 45;
    }
  }
}

nukecrate_objectiveinit_cleanup(var_0, var_1) {
  var_2 = var_0 scripts\engine\utility::_id_10898("timedout", "death", "crate_dropped");

  if(var_2 == "crate_dropped") {
    var_0 scripts\engine\utility::waittill_any_2("timedout", "death");
  }

  _id_07F9::_id_C799(var_1);
  level thread delayremovenukecratetracking(var_0);
  level.nuke_crate_neutral_count--;

  if(isDefined(var_0)) {
    var_0 scripts\cp_mp\killstreaks\airdrop::_id_4843();
  }
}

nukecrate_monitornukezone() {
  if(isDefined(level.destroyedbases)) {
    foreach(var_1 in level.destroyedbases) {
      if(istrue(var_1.trigger._id_60D8._id_10A1A) && self istouching(var_1._id_A729)) {
        scripts\cp_mp\killstreaks\airdrop::_id_4843();
      }
    }
  }
}

_id_5AFD() {
  if(!isDefined(level.players) || level.players.size <= 0) {
    return undefined;
  }

  var_0 = findnukecratedropspawner();

  if(isDefined(var_0)) {
    level.next_nuke_spawner = var_0;
    return var_0.origin;
  }

  var_1 = getnukelowestspawnsarray(level.nuke_spawn_nodes);

  if(isDefined(var_1)) {
    var_2 = scripts\engine\utility::random(var_1);
    level.next_nuke_spawner = var_2;
    return var_2.origin;
  }

  var_3 = _id_6952();

  if(isDefined(var_3)) {
    var_4 = (var_3[0], var_3[1], var_3[2]);
  } else {
    return undefined;
  }

  var_5 = getgroundposition(var_4, 32, 2500, var_3[2] + 256);
  return var_5;
}

findnukecratedropspawner() {
  if(getbasearrayofowned(level._id_A8E8).size == 0) {
    return findnukecratedropspawner_allbasesneutral();
  } else {
    var_0 = findnukecratedropspawner_somebasesneutral();

    if(isDefined(var_0)) {
      return var_0;
    }
  }

  var_1 = getlosingteam();

  if(var_1 != "tied") {
    var_2 = getbasearrayoftype(level._id_A8E8, var_1);

    if(var_2.size <= 1) {
      var_3 = findnukecratedropspawner_favorlosingteam();

      if(isDefined(var_3)) {
        return var_3;
      } else {
        return getpostnukespawnerfavorloser();
      }
    }
  }

  var_4 = findnukecratedropspawner_balancedbetweenteams();

  if(isDefined(var_4)) {
    return var_4;
  } else {
    return getpostnukespawnerbetweenclosestbases();
  }
}

findnukecratedropspawner_allbasesneutral() {
  var_0 = getnukespawnswithoutnukesinfield(level.nuke_spawn_nodes);
  var_0 = getnukelowestspawnsarray(var_0);

  if(var_0.size > 0) {
    var_1 = getnukespawnpoisarray(var_0);

    if(var_1.size > 0) {
      var_0 = var_1;
    }

    return getnukespawnerclosesttoplayerscentroid(var_0);
  }
}

findnukecratedropspawner_somebasesneutral() {
  var_0 = getbasearrayofunowned(level._id_A8E8);

  if(!isDefined(var_0) || var_0.size == 0) {
    return undefined;
  }

  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3._id_4143 == 0) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  if(var_1.size > 0) {
    var_0 = var_1;
  }

  var_5 = getbasearrayoftype(level._id_A8E8, "allies");
  var_6 = getbasearrayoftype(level._id_A8E8, "axis");
  var_7 = [];

  if(var_5.size > 0 && var_6.size > 0) {
    foreach(var_3 in var_0) {
      var_9 = undefined;

      foreach(var_11 in var_5) {
        var_12 = getbasekeydifference(var_3, var_11);

        if(!isDefined(var_9) || var_12 < var_9) {
          var_9 = var_12;
        }
      }

      var_14 = undefined;

      foreach(var_16 in var_6) {
        var_12 = getbasekeydifference(var_3, var_16);

        if(!isDefined(var_14) || var_12 < var_14) {
          var_14 = var_12;
        }
      }

      if(int(abs(var_9 - var_14)) <= 1) {
        var_7 = scripts\engine\utility::array_add(var_7, var_3);
      }
    }
  }

  var_19 = undefined;

  if(var_7.size > 0) {
    var_19 = var_7;
  } else {
    var_19 = var_0;
  }

  var_20 = getnukespawnersnearbasesexclusivenotshared(var_19);
  var_21 = getnukespawnswithoutnukesinfield(var_20);

  if(var_21.size > 0) {
    var_20 = var_21;
  }

  var_22 = getnukespawnpoisarray(var_20);

  if(var_22.size > 0) {
    var_20 = var_22;
  }

  var_20 = getnukelowestspawnsarray(var_20);
  var_23 = scripts\engine\utility::random(var_20);
  return var_23;
}

findnukecratedropspawner_favorlosingteam() {
  var_0 = getlosingteam();
  var_1 = _id_6E9A();
  var_2 = getbasearrayoftype(level._id_A8E8, var_0);
  var_3 = getbasearrayoftype(level._id_A8E8, var_1);
  var_4 = [];

  foreach(var_6 in var_2) {
    foreach(var_8 in var_3) {
      if(base_isadjacent(var_6, var_8)) {
        var_4 = scripts\engine\utility::array_add(var_4, var_6);
        break;
      }
    }
  }

  if(var_4.size > 0) {
    var_11 = getnukespawnerssharedbetweenopponents(var_4);
    var_12 = getnukespawnswithoutnukesinfield(var_11);

    if(var_12.size > 0) {
      var_11 = var_12;
    }

    var_13 = getnukespawnclosertoteambasearray(var_11, var_0);

    if(isDefined(var_13) && var_13.size > 0) {
      var_11 = var_13;
    }

    var_11 = getnukelowestspawnsarray(var_11);
    return scripts\engine\utility::random(var_11);
  } else
    return undefined;
}

findnukecratedropspawner_balancedbetweenteams() {
  var_0 = [];
  var_1 = ["_a", "_b", "_c", "_d", "_e", "_f", "_g"];

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    var_3 = var_1[var_2];

    if(isDefined(level._id_A8E8[var_3])) {
      for(var_4 = var_2 + 1; var_4 <= var_2 + 2; var_4++) {
        if(var_4 >= var_1.size) {
          break;
        }

        var_5 = var_1[var_4];

        if(isDefined(level._id_A8E8[var_5])) {
          if(level._id_A8E8[var_3]._id_ADAE == "axis" && level._id_A8E8[var_5]._id_ADAE == "allies" || level._id_A8E8[var_3]._id_ADAE == "allies" && level._id_A8E8[var_5]._id_ADAE == "axis") {
            if(base_isadjacent(level._id_A8E8[var_3], level._id_A8E8[var_5])) {
              var_0 = scripts\engine\utility::_id_1B9D(var_0, [level._id_A8E8[var_3]]);
              var_0 = scripts\engine\utility::_id_1B9D(var_0, [level._id_A8E8[var_5]]);
            }
          }
        }
      }
    }
  }

  if(var_0.size > 0) {
    var_6 = getnukespawnerssharedbetweenopponents(var_0);
    var_7 = getnukespawnswithoutnukesinfield(var_6);

    if(var_7.size > 0) {
      var_6 = var_7;
    }

    var_8 = getnukespawnpoisarray(var_6);

    if(var_8.size > 0) {
      var_6 = var_8;
    }

    var_6 = getnukelowestspawnsarray(var_6);
    var_9 = scripts\engine\utility::random(var_6);
    return var_9;
  } else
    return undefined;
}

_id_6953() {
  if(!isDefined(level._id_A8E8) || level._id_A8E8.size == 0) {
    return undefined;
  }

  var_0 = scripts\mp\gamescore::_id_0C0F("allies");
  var_1 = scripts\mp\gamescore::_id_0C0F("axis");

  if(var_1 <= 1 || var_0 <= 1) {
    return _id_6952();
  }

  var_2 = "allies";

  if(var_1 < var_0) {
    var_2 = "axis";
  }

  var_3 = 0;
  var_4 = [0, 0, 0];

  foreach(var_6 in level._id_A8E8) {
    if(var_6._id_ADAE == var_2 && isDefined(var_6.origin)) {
      var_4[0] = var_4[0] + var_6.origin[0];
      var_4[1] = var_4[1] + var_6.origin[1];
      var_4[2] = var_4[2] + var_6.origin[2];
      var_3++;
    }
  }

  if(var_3 == 0) {
    return _id_6952();
  }

  var_4[0] = var_4[0] / var_3;
  var_4[1] = var_4[1] / var_3;
  var_4[2] = var_4[2] / var_3;
  var_4[0] = var_4[0] + randomfloatrange(-1000, 1000);
  var_4[1] = var_4[1] + randomfloatrange(-1000, 1000);
  var_4[2] = var_4[2] + randomfloatrange(-1000, 1000);
  return var_4;
}

getcentroidoriginofplayersinteam(var_0) {
  var_1 = getcentroidofplayersinteam(var_0);

  if(isDefined(var_1)) {
    return (var_1[0], var_1[1], var_1[2]);
  } else {
    return undefined;
  }
}

getcentroidofplayersinteam(var_0) {
  if(!isDefined(level.players) || level.players.size <= 0) {
    return undefined;
  }

  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.sessionteam == var_0) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return getcentroidofplayersarray(var_1);
}

getcentroidoriginofallplayers() {
  var_0 = _id_6952();

  if(isDefined(var_0)) {
    return (var_0[0], var_0[1], var_0[2]);
  } else {
    return undefined;
  }
}

_id_6952() {
  if(!isDefined(level.players) || level.players.size <= 0) {
    return undefined;
  }

  return getcentroidofplayersarray(level.players);
}

getcentroidofplayersarray(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(scripts\mp\utility\player::isreallyalive(var_3) && var_3.team != "spectator") {
      var_1[var_1.size] = var_3.origin;
    }
  }

  if(var_1.size <= 0) {
    return undefined;
  }

  var_5 = [0, 0, 0];

  foreach(var_7 in var_1) {
    var_5[0] = var_5[0] + var_7[0];
    var_5[1] = var_5[1] + var_7[1];
    var_5[2] = var_5[2] + var_7[2];
  }

  var_5[0] = var_5[0] / var_1.size;
  var_5[1] = var_5[1] / var_1.size;
  var_5[2] = var_5[2] / var_1.size;
  return var_5;
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

_id_AAF6() {
  foreach(var_1 in level.players) {
    var_1 scripts\common\base_warnings::base_warnings_hide_all();
  }
}

matchending_timeexpired_getwinner() {
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in level._id_A8E8) {
    if(var_3._id_ADAE == "axis") {
      var_0++;
      continue;
    }

    if(var_3._id_ADAE == "allies") {
      var_1++;
    }
  }

  var_5 = "tie";

  if(var_0 > var_1) {
    var_5 = "axis";
  } else if(var_0 < var_1) {
    var_5 = "allies";
  }

  return var_5;
}

_id_9BC1() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    if(istrue(level._id_82D1)) {
      if(gettime() > level.overtime_gameendtime) {
        if(_id_2EF1("axis") == level._id_A8E8.size) {
          matchending_vo("axis", "allies");
          base_analytics_gameoverstate("axis");
          level thread scripts\mp\gamelogic::_id_52F7("axis", game["end_reason"]["objective_completed"], game["end_reason"]["objective_failed"], 0, 1);
        } else if(_id_2EF1("allies") == level._id_A8E8.size) {
          matchending_vo("allies", "axis");
          base_analytics_gameoverstate("allies");
          level thread scripts\mp\gamelogic::_id_52F7("allies", game["end_reason"]["objective_completed"], game["end_reason"]["objective_failed"], 0, 1);
        } else
          level base_endovertime();
      } else if(level._id_A8E8.size == 0) {
        _id_0A8D::_id_E775("game_end_lose", "axis");
        _id_0A8D::_id_E775("game_end_lose", "allies");
        base_analytics_gameoverstate("all_bases_nuked");
        level thread scripts\mp\gamelogic::_id_52F7("none", game["end_reason"]["objective_completed"], game["end_reason"]["objective_failed"], 0, 1);
      } else if(_id_2EF1(level.overtime_losing_team) >= 1)
        level base_endovertime();
    } else if(_id_2EF1("axis") == level._id_A8E8.size) {
      if(base_isovertimeavailableforteam("allies")) {
        level base_startovertime("allies");
      } else {
        matchending_vo("axis", "allies");
        base_analytics_gameoverstate("axis");
        level thread scripts\mp\gamelogic::_id_52F7("axis", game["end_reason"]["objective_completed"], game["end_reason"]["objective_failed"], 0, 1);
      }
    } else if(_id_2EF1("allies") == level._id_A8E8.size) {
      if(base_isovertimeavailableforteam("axis")) {
        level base_startovertime("axis");
      } else {
        matchending_vo("allies", "axis");
        base_analytics_gameoverstate("allies");
        level thread scripts\mp\gamelogic::_id_52F7("allies", game["end_reason"]["objective_completed"], game["end_reason"]["objective_failed"], 0, 1);
      }
    } else if(_id_2EF1("axis") == 1 && _id_2EF1("neutral") == 0 && level._id_A8E8.size > 2 && (!isDefined(level._id_5A6D) || !istrue(level._id_5A6D["axis"])))
      thread _id_A10D("axis");
    else if(_id_2EF1("allies") == 1 && _id_2EF1("neutral") == 0 && level._id_A8E8.size > 2 && (!isDefined(level._id_5A6D) || !istrue(level._id_5A6D["allies"]))) {
      thread _id_A10D("allies");
    }

    waitframe();
  }
}

matchending_vo(var_0, var_1) {
  _id_0A8D::_id_E775("game_end_lose", var_1);
  _id_0A8D::_id_E775("game_end_win", var_0);
}

_id_A10D(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level._id_5A6D)) {
    level._id_5A6D = [];
  }

  level._id_5A6D[var_0] = 1;
  _id_0A8D::_id_E775("last_base", var_0);
  _id_0A8D::_id_E775("last_base_winning", scripts\mp\utility\game::_id_6BE2(var_0)[0]);

  while(_id_2EF1(var_0) == 1) {
    foreach(var_2 in level._id_EF6A[var_0]["players"]) {
      var_2 notify("base_downtolastbase");
    }

    wait 10;
  }

  level._id_5A6D[var_0] = 0;
}

_id_3531(var_0) {
  foreach(var_2 in level._id_A8E8) {
    var_3 = scripts\mp\utility\game::_id_6BE2(var_2._id_ADAE)[0];

    if(var_2._id_4143 == 0 || var_2._id_F396[var_3].size == 0) {
      continue;
    } else {
      return 1;
    }
  }
}

base_startovertime(var_0) {
  var_1 = undefined;

  if(var_0 == "axis") {
    if(!isDefined(level.overtime_num_axis)) {
      level.overtime_num_axis = 0;
    }

    if(level.overtime_num_axis < level.overtimeduration.size) {
      var_2 = level.overtimeduration[level.overtime_num_axis];
      level.overtime_num_axis++;
      var_1 = level.overtime_num_axis;
    } else
      return 0;
  } else {
    if(!isDefined(level.overtime_num_allies)) {
      level.overtime_num_allies = 0;
    }

    if(level.overtime_num_allies < level.overtimeduration.size) {
      var_2 = level.overtimeduration[level.overtime_num_allies];
      level.overtime_num_allies++;
      var_1 = level.overtime_num_allies;
    } else
      return 0;
  }

  level notify("cancel_announcer_dialog");
  level.overtime_losing_team = var_0;
  _id_FC69();
  level thread base_overtimetimer(var_2, var_0, var_1);
  level notify("overtime_start");
  thread _id_07F8::base_overtime_music_start();
}

monitorovertimenearestbasetoplayer() {
  level endon("game_ended");
  self notify("end_overtime_nearest_base_effects");
  self endon("end_overtime_nearest_base_effects");
  thread monitorovertimenearestbasetoplayer_cleanup();
  var_0 = getdvarfloat("scr_base_nearest_vfx_heartbeat", 1);
  var_1 = undefined;

  for(;;) {
    wait(var_0);

    if(!istrue(level._id_82D1)) {
      monitorovertimenearestbasetoplayer_deletefx();
      continue;
    }

    if(self.team != level.overtime_losing_team) {
      continue;
    }
    if(level._id_A8E8.size > 0) {
      var_2 = undefined;
      var_3 = scripts\engine\utility::_id_6369(self.origin, level._id_A8E8);

      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_5 = var_3[var_4];

        if(!isDefined(var_5._id_ADAE) || var_5._id_ADAE == scripts\mp\utility\game::_id_6BE2(level.overtime_losing_team)[0]) {
          var_2 = var_5;
          break;
        }
      }

      if(!isDefined(var_2)) {
        monitorovertimenearestbasetoplayer_deletefx();
        continue;
      }

      if(!isDefined(var_1) || var_2 != var_1) {
        monitorovertimenearestbasetoplayer_deletefx();
        var_1 = var_2;
        self.overtime_nearestbase = var_2;
        self.overtime_nearest_base_fx = spawn("script_model", var_2.origin);
        self.overtime_nearest_base_fx setModel("tag_origin");
        _func_019D(scripts\engine\utility::getfx("vfx_ui_last_base_01"), self.overtime_nearest_base_fx, "tag_origin", self);
      }

      continue;
    }

    monitorovertimenearestbasetoplayer_deletefx();
  }
}

monitorovertimenearestbasetoplayer_deletefx() {
  self.overtime_nearestbase = undefined;

  if(isDefined(self.overtime_nearest_base_fx)) {
    self.overtime_nearest_base_fx delete();
    self.overtime_nearest_base_fx = undefined;
  }
}

monitorovertimenearestbasetoplayer_cleanup() {
  level endon("game_ended");
  scripts\engine\utility::_id_10882("death", "disconnect", "end_overtime_nearest_base_effects", "overtime_end");
  self notify("end_overtime_nearest_base_effects");
  monitorovertimenearestbasetoplayer_deletefx();
}

base_overtimetimer(var_0, var_1, var_2) {
  level endon("game_ended");

  if(!isDefined(level.overtime_totaltime)) {
    level.overtime_totaltime = 0;
  }

  level.overtime_startime = gettime();
  var_3 = scripts\mp\gamelogic::_id_6DE8();
  var_4 = var_0 * 1000;

  if(var_3 < var_4) {
    level.overtime_difffrommatchtimer = int(var_4 - var_3);
    level._id_5856 = level.overtime_difffrommatchtimer / 1000;
  } else
    level.overtime_difffrommatchtimer = undefined;

  level._id_82D1 = 1;
  level.incriticalovertime = 0;
  level.overtime_timerstopped = 0;
  level.overtime_gameendtime = int(gettime() + var_4);
  setomnvar("ui_base_overtime_end_time", level.overtime_gameendtime);

  foreach(var_6 in level.players) {
    if(var_6.team == var_1) {
      var_6 scripts\common\base_warnings::base_warnings_show_overtime("overtime_attack");
      continue;
    }

    var_6 scripts\common\base_warnings::base_warnings_show_overtime("overtime_defend");
  }

  level endon("overtime_end");

  for(;;) {
    if(base_shouldovertimetimerpause()) {
      if(!istrue(level.overtime_timerstopped)) {
        level.overtime_timerstopped = 1;
        level.overtimepausetimeremaining = int(level.overtime_gameendtime - gettime());
        scripts\mp\gamelogic::pausetimer();
        setomnvar("ui_base_overtime_paused", 1);
      } else
        level.overtime_gameendtime = int(gettime() + level.overtimepausetimeremaining);
    } else if(istrue(level.overtime_timerstopped) && !base_shouldovertimetimerpause()) {
      level.overtime_gameendtime = int(gettime() + level.overtimepausetimeremaining);
      level.overtime_timerstopped = 0;
      scripts\mp\gamelogic::resumetimer();
      setomnvar("ui_base_overtime_end_time", level.overtime_gameendtime);
      setomnvar("ui_base_overtime_paused", 0);
    }

    var_8 = level.overtime_gameendtime - gettime();

    if(!level.incriticalovertime && var_8 < 11000) {
      foreach(var_6 in level.players) {
        if(var_6.team == var_1) {
          var_6 scripts\common\base_warnings::base_warnings_show_overtime_critical("overtime_attack");
          continue;
        }

        var_6 scripts\common\base_warnings::base_warnings_show_overtime_critical("overtime_defend");
      }

      level.incriticalovertime = 1;
    }

    waitframe();
  }
}

base_shouldovertimetimerpause() {
  foreach(var_1 in level._id_A8E8) {
    switch (var_1.objectivestate) {
      case "axis_contested":
      case "allies_contested":
        return 1;
    }
  }

  return 0;
}

base_endovertime() {
  level notify("overtime_end");
  thread _id_07F8::base_overtime_music_stop();
  scripts\mp\gamelogic::resumetimer();
  level.overtime_totaltime = level.overtime_totaltime + (gettime() - level.overtime_startime);
  level._id_82D1 = 0;
  level.overtime_losing_team = undefined;

  foreach(var_1 in level._id_A8E8) {
    _id_34E4(var_1.origin);
  }

  foreach(var_4 in level.players) {
    var_4 scripts\common\base_warnings::base_warning_hide_overtime();
  }

  setomnvar("ui_base_overtime_end_time", 0);
  setomnvar("ui_base_overtime_paused", 0);
}

base_isovertimeavailableforteam(var_0) {
  if(getdvarint("#x35b62a64e75bf8850", 1) != 1) {
    return 0;
  }

  if(var_0 == "axis") {
    if(!isDefined(level.overtime_num_axis)) {
      return 1;
    }

    return level.overtime_num_axis < level.overtimeduration.size;
  } else {
    if(!isDefined(level.overtime_num_allies)) {
      return 1;
    }

    return level.overtime_num_allies < level.overtimeduration.size;
  }
}

base_getmaintimeremaining() {
  var_0 = gettime();
  var_1 = 0;

  if(istrue(level._id_82D1)) {
    var_1 = var_0 - level.overtime_startime;
  }

  var_2 = scripts\mp\utility\game::_id_6DE5() * 1000;
  var_3 = var_2 + level._id_E72D + var_1 + level.overtime_totaltime;
  var_4 = var_3 - var_0;
  return var_4;
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

nukebasesatintervals() {
  level endon("game_ended");
  level._id_A73C = [];
  level.basesqueuedtonuke = [];
  level waittill("prematch_done");

  if(!isDefined(level._id_232A)) {
    level._id_232A = [];

    foreach(var_1 in level._id_A8E8) {
      level._id_232A = scripts\engine\utility::array_add(level._id_232A, var_1);
    }
  }

  if(getdvarint("#x3f6f82a171abdd70e", 1) == 1) {
    level thread monitornukeplayerchoice();
  }

  while(level._id_232A.size > 1) {
    if(istrue(level._id_82D1)) {
      level waittill("overtime_over");
    }

    var_3 = _id_6B7C();
    ontargetbasefornuke(var_3);
    level thread vo_targetbase(var_3);
    level thread _id_FB8C();
    level._id_22A4 = gettime() + level._id_22A6 * 1000;
    thread scripts\mp\gametypes\arms_race_audio::prenukewarningsound(var_3);
    var_4 = getbaseindex(var_3);
    setomnvar("ui_base_nuke_target", var_4);

    if(isDefined(var_3)) {
      level thread _id_F07A(level._id_22A6, var_3);
      _id_B8A6(var_3);
    }

    thread _id_A127(var_3);
    level waittill("nuke_landed");
    var_5 = getdvarint("#x378cdc71e4d6d38bc", 5);

    if(isDefined(var_3)) {
      setDvar("#x378cdc71e4d6d38bc", var_5 - 1);
      _id_C476(var_3);
    }

    _id_8D94(var_3);
    killnukecratesinnukezone(var_3);
    _id_8DF4(var_3);
    setomnvar("ui_base_nuke_target", 0);
    thread _id_A129(var_3);
    level thread vo_nukedbase(var_3);
    level notify("update_nuke_timer");
    setomnvar("ui_nuke_end_milliseconds", 0);
    setDvar("#x325ebf44c413a0566", 0);

    if(getdvarint("#x378cdc71e4d6d38bc") < 6) {
      level._id_22A6 = level._id_22A6 + 30;
    }
  }
}

vo_targetbase(var_0) {
  wait 1;

  if(var_0.nukedefenderteam == "neutral") {
    _id_0A8D::_id_E775("nebula_neutral", "axis");
    _id_0A8D::_id_E775("nebula_neutral", "allies");
  } else {
    _id_0A8D::_id_E775("nebula_friendly", var_0.nukeattackerteam);

    if(var_0.nukedefenderteam != var_0.nukeattackerteam) {
      _id_0A8D::_id_E775("nebula_hostile", var_0.nukedefenderteam);
    } else {
      _id_0A8D::_id_E775("nebula_neutral", var_0.nukedefenderteam);
    }
  }
}

vo_nukedbase(var_0) {
  wait 1;
  _id_0A8D::_id_E775("nuked" + var_0.trigger._id_A90E + "_enemy", var_0.nukeattackerteam);

  if(var_0.nukedefenderteam != "neutral" && var_0.nukedefenderteam != var_0.nukeattackerteam) {
    _id_0A8D::_id_E775("nuked" + var_0.trigger._id_A90E + "_friendly", var_0.nukedefenderteam);
  }
}

monitornukeplayerchoice() {
  level endon("game_ended");

  for(;;) {
    level waittill("nuke_crate_captured", var_0, var_1);

    if(istrue(level._id_82D1)) {
      continue;
    }
    if(level._id_232A.size <= 1) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    level thread addbaseasnuketarget(var_1);
    level thread base_teleportplayeronnukecapture(var_1);
  }
}

monitorplayerrespawnafternukechoice() {
  level endon("game_ended");

  for(;;) {
    level waittill("nuke_target_chosen", var_0);
  }
}

base_teleportplayeronnukecapture(var_0) {
  var_1 = undefined;
  var_2 = [];

  foreach(var_4 in level._id_232A) {
    if(var_4._id_ADAE == var_0.team) {
      var_2[var_2.size] = var_4._id_A8E1;
    }
  }

  var_6 = [];

  foreach(var_8 in var_2) {
    foreach(var_4 in level._id_14F5) {
      if(var_4.trigger._id_A90E == var_8) {
        var_6[var_6.size] = var_4.trigger;
        break;
      }
    }
  }

  var_0._id_D066 = scripts\engine\utility::_id_6369(var_0.origin, var_6)[0]._id_0481;
  var_12 = scripts\engine\utility::getstructarray("locale_17", "script_noteworthy");
  var_13 = undefined;

  foreach(var_15 in var_12) {
    if(scripts\engine\utility::is_equal(var_0.team, var_15._id_CE7D) && scripts\engine\utility::is_equal(var_15._id_CD99, var_0._id_D066) && !scripts\engine\utility::is_equal(var_15._id_0481, "spawn_selection_camera")) {
      var_13 = var_15;
      break;
    }
  }

  var_17 = _func_00CB("mp_tdm_spawn");
  var_18 = [];

  foreach(var_20 in var_17) {
    if(scripts\engine\utility::is_equal(var_20.target, var_13._id_0481)) {
      var_18 = scripts\engine\utility::array_add(var_18, var_20);
    }
  }

  var_22 = var_18;
  var_23 = undefined;

  foreach(var_20 in var_18) {
    if(var_18.size < 1) {
      var_18 = var_22;
    }

    var_23 = scripts\engine\utility::random(var_18);
    var_25 = var_23.origin + (1, 1, 1);
    var_26 = 10;
    var_27 = [];
    var_28 = scripts\engine\trace::_id_3EE5(1, 0, 0, 0, 0, 0, 1, 0, 0);
    var_29 = scripts\engine\trace::_id_E40C(var_23.origin, var_25, var_26, var_27, var_28);

    if(isDefined(var_29[0])) {
      var_18 = scripts\engine\utility::array_remove(var_18, var_23);
      continue;
    }

    break;
  }

  if(scripts\mp\utility\player::isreallyalive(var_0)) {
    var_0 setorigin(var_23.origin);
  } else {
    var_0 scripts\mp\playerlogic::_id_E337();
  }
}

_id_6B7C() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(getdvarint("#x3f6f82a171abdd70e", 1) == 1) {
    while(level.basesqueuedtonuke.size == 0) {
      waitframe();
    }

    var_3 = scripts\engine\utility::_id_1BAC(level.basesqueuedtonuke);
    level.basesqueuedtonuke = scripts\engine\utility::array_remove(level.basesqueuedtonuke, var_3);
  }

  if(isDefined(var_3)) {
    var_0 = var_3;
  } else if(level._id_22A5) {
    var_4 = level._id_232A;
    var_4 = scripts\engine\utility::array_randomize(var_4);

    if(!isDefined(var_0)) {
      var_0 = var_4[0];
    }

    _func_0140("Random nuke base: " + var_0._id_7C73);
  } else
    var_0 = level._id_232A[0];

  level._id_232A = scripts\engine\utility::array_remove(level._id_232A, var_0);
  return var_0;
}

baseconnections_init() {
  if(!isDefined(level._id_22B2)) {
    level._id_22B2 = [];
    level._id_22B2["_a"] = ["_b", "_c"];
    level._id_22B2["_b"] = ["_a", "_c", "_d"];
    level._id_22B2["_c"] = ["_a", "_b", "_d"];
    level._id_22B2["_d"] = ["_b", "_c", "_e", "_f"];
    level._id_22B2["_e"] = ["_d", "_f", "_g"];
    level._id_22B2["_f"] = ["_d", "_e", "_g"];
    level._id_22B2["_g"] = ["_e", "_f"];
  }
}

addbaseasnuketarget(var_0) {
  level endon("game_ended");
  var_1 = spawnStruct();
  level.nuke_crate_spawns_and_carriers = scripts\engine\utility::array_add(level.nuke_crate_spawns_and_carriers, var_1);
  var_2 = var_0 _id_B071();
  level thread delayremovenukecratetracking(var_1, 1);

  if(!isDefined(var_2)) {
    var_3 = getbasearrayoftype(level._id_A8E8, var_0.team);
    var_4 = 0;

    foreach(var_6 in var_3) {
      if(var_0 istouching(var_6.trigger)) {
        var_4 = 1;
        break;
      }
    }

    if(!var_4 || istrue(level._id_82D1) || level._id_A8E8.size <= 1 || getbasearrayoftype(level._id_A8E8, scripts\mp\utility\game::_id_6BE2(var_0.team)[0]).size == 0 && getbasearrayoftype(level._id_A8E8, "neutral").size == 0) {
      var_0._id_A72C = 1;
      var_0 setclientomnvar("ui_base_carrying_nuke", 1);
      var_8 = "";

      if(var_0.team == "axis") {
        var_8 = "ui_base_objective_nebula_axis";
      } else {
        var_8 = "ui_base_objective_nebula_allies";
      }

      var_9 = _func_00BE(var_8);
      var_9 = var_9 + 1;
      setomnvar(var_8, var_9);

      if(!isDefined(var_0._id_413F)) {
        var_0._id_413F = _id_07F9::_id_C57D();
      }

      _id_07F9::_id_A867(var_0._id_413F, "current", var_0.origin + (0, 0, 120), level.leveldata._id_9F23);
      _id_07F9::_id_FB96(var_0._id_413F, var_0.sessionteam);
      _id_07F9::_id_A8B1(var_0._id_413F, 0);
      _id_07F9::_id_FB98(var_0._id_413F, 6);
      _id_07F9::_id_FB93(var_0._id_413F, var_0);
      _id_07F9::_id_FB9D(var_0._id_413F, 120);

      while(scripts\engine\utility::array_contains(level.nuke_crate_spawns_and_carriers, var_0)) {
        waitframe();
      }

      var_0 thread _id_A126();
    } else
      return;
  }

  if(isDefined(var_2) && !scripts\engine\utility::array_contains(level.basesqueuedtonuke, var_2)) {
    level.basesqueuedtonuke = scripts\engine\utility::array_add(level.basesqueuedtonuke, var_2);
    var_2.nukeattackerteam = var_0.team;
    var_2.nukedefenderteam = var_2._id_ADAE;
  }

  level notify("nuke_target_chosen", var_0);
  recordbaseactivity(var_0, "addBaseAsNukeTarget");
}

autopickbasetonuke() {
  baseconnections_init();
  var_0 = ["_d", "_e", "_f"];
  var_1 = scripts\mp\utility\game::_id_6BE2(self.team);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = [];
  var_5["allies"] = [];
  var_5["axis"] = [];
  var_5["neutral"] = [];

  foreach(var_7 in level._id_232A) {
    if(var_7._id_ADAE == "allies") {
      var_5["allies"] = ::scripts\engine\utility::array_add(var_5["allies"], var_7);
      continue;
    }

    if(var_7._id_ADAE == "axis") {
      var_5["axis"] = ::scripts\engine\utility::array_add(var_5["axis"], var_7);
      continue;
    }

    var_5["neutral"] = ::scripts\engine\utility::array_add(var_5["neutral"], var_7);
  }

  if(var_5[var_1[0]].size == 0) {
    var_2 = "neutral";
  } else {
    var_2 = var_1[0];
  }

  foreach(var_7 in var_5[var_2]) {
    var_10 = var_7._id_A8E1;

    if(level._id_22B2[var_10].size == 0) {
      continue;
    } else if(!isDefined(var_3)) {
      var_4 = var_7;
      var_3 = var_10;
      continue;
    } else if(level._id_22B2[var_10].size == 1) {
      var_4 = var_7;
      var_3 = var_10;
      break;
    } else if(level._id_22B2[var_10].size > level._id_22B2[var_3].size)
      continue;
    else {
      if(level._id_22B2[var_10].size < level._id_22B2[var_3].size) {
        var_4 = var_7;
        var_3 = var_10;
        continue;
      }

      if(level._id_22B2[var_10].size == level._id_22B2[var_3].size) {
        if(scripts\engine\utility::array_contains(var_0, var_10)) {
          continue;
        } else if(scripts\engine\utility::array_contains(var_0, var_3)) {
          var_4 = var_7;
          var_3 = var_10;
        }
      }
    }
  }

  if(isDefined(var_3)) {
    foreach(var_14, var_13 in level._id_22B2) {
      if(var_14 == var_3) {
        var_13 = undefined;
        continue;
      }

      if(scripts\engine\utility::array_contains(var_13, var_3)) {
        var_13 = scripts\engine\utility::array_remove(var_13, var_3);
      }
    }
  }

  return var_4;
}

_id_B071() {
  var_0 = undefined;

  if(getdvarint("#x3829a16035df939de", 1)) {
    _id_CA6C();
    var_1 = self._id_D066;

    if(isDefined(var_1)) {
      var_2 = _id_5AFE(var_1);

      foreach(var_4 in level._id_232A) {
        if(var_4._id_A8E1 == var_2) {
          var_0 = var_4;
          break;
        }
      }
    } else
      var_0 = autopickbasetonuke();
  } else
    var_0 = autopickbasetonuke();

  return var_0;
}

_id_5AFE(var_0) {
  foreach(var_2 in level._id_14F5) {
    if(var_2.trigger._id_0481 == var_0) {
      return var_2.trigger._id_A90E;
    }
  }
}

_id_CA6C() {
  self._id_B072 = 1;
  self setclientomnvar("ui_base_nuke_screen_active", 1);
  thread _id_0815::_id_E722(0.0, 0.5, 0.5);
  _id_0819::_id_1082A(0);
  _id_0A99::_id_D5EA(0);
  self._id_E293 = spawnStruct();
  self._id_E293._id_E332 = self.origin;
  self._id_E293._id_E267 = self.angles;
  thread _id_0815::_id_534A();
  self notify("spawncamera_start");
  childthread tacopsmapshowminimap();
  self._id_B072 = 0;
  self setclientomnvar("ui_base_nuke_selection_timer", 0);
  self setclientomnvar("ui_base_nuke_screen_active", 0);
}

_id_FB8C() {
  level endon("game_ended");
  level endon("disconnect");
  level notify("update_nuke_timer");
  level endon("update_nuke_timer");
  var_0 = level._id_22A6 * 1000 + gettime();
  setomnvar("ui_nuke_end_milliseconds", var_0);
  level waittill("host_migration_begin");
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 > 0) {
    setomnvar("ui_nuke_end_milliseconds", var_0 + var_1);
  }
}

_id_F07A(var_0, var_1) {
  level endon("game_ended");
  level endon("disconnect");
  level notify("update_nuke_timer");
  level endon("update_nuke_timer");
  level thread base_nuketimer_missilevfx(var_0, var_1);
  wait(var_0);

  if(istrue(var_1.enemyissieging)) {}

  level notify("nuke_landed");
  setomnvar("ui_nuke_countdown_active", 0);
}

base_nuketimer_missilevfx(var_0, var_1) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("update_nuke_timer");
  var_2 = var_0 - level.base_nuke_missile_pretime;

  if(var_2 > 0) {
    wait(var_2);
    thread scripts\mp\gametypes\arms_race_audio::snd_incomingmissile(var_1._id_4347);
    playFXOnTag(scripts\engine\utility::getfx("vfx_ar_missile_base_imp"), var_1._id_4347, "tag_origin");
  }
}

ontargetbasefornuke(var_0) {
  var_1 = level._id_A8E8[var_0._id_A8E1].nuke_spawn_nodes;
  level.nuke_spawn_nodes = scripts\engine\utility::_id_1BBF(level.nuke_spawn_nodes, var_1);

  foreach(var_3 in level._id_A8E8) {
    var_3.nuke_spawn_nodes = scripts\engine\utility::_id_1BBF(var_3.nuke_spawn_nodes, var_1);
  }

  if(_id_07D1::_id_60BE("prematch_done")) {
    _id_FC69();
  }

  foreach(var_6 in level._id_14F5) {
    if(var_6.trigger == level._id_A8E8[var_0._id_A8E1].trigger) {
      var_6.isgettingnuked = 1;
    }
  }
}

_id_C476(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_0._id_10A1A = 1;

  foreach(var_5, var_4 in level._id_A8E8) {
    if(var_4 == var_0) {
      var_1 = var_5;
      break;
    }
  }

  base_analytics_nukebase(var_0);
  level._id_A8E8[var_1] = undefined;
  var_6 = var_0._id_ADAE;

  if(var_6 != "neutral") {
    foreach(var_5, var_8 in level._id_E371) {
      if(isDefined(var_8[var_6]._id_A8E1) && var_8[var_6]._id_A8E1 == var_1) {
        var_2 = var_5;
        break;
      }
    }

    _id_0819::_id_C521(var_2, var_6);
    var_0._id_ADAE = "neutral";
  }

  foreach(var_10 in level._id_14F5) {
    if(var_10.trigger == var_0.trigger) {
      var_10 notify("nuked");
      level._id_14F5 = scripts\engine\utility::array_remove(level._id_14F5, var_10);
      break;
    }
  }

  var_0 _id_07D6::_id_15DF("none");
  var_0 _id_07D6::_id_D8E0("none");
  level.destroyedbases = scripts\engine\utility::_id_1B8D(level.destroyedbases, var_0);

  if(!isDefined(level.destroyedobjectivesbitflag)) {
    level.destroyedobjectivesbitflag = 0;
  }

  var_12 = getbaseindex(var_0);
  level.destroyedobjectivesbitflag = level.destroyedobjectivesbitflag | 1 << var_12;
  setomnvar("ui_base_destroyed_objectives", level.destroyedobjectivesbitflag);
  setomnvar("ui_base_objective_gas_entity_" + (var_12 - 1), var_0._id_4347);
  var_13 = _id_07F9::_id_C57D();
  level._id_A73C = scripts\engine\utility::array_add(level._id_A73C, var_13);
  _id_07F9::_id_A867(var_13, "active", var_0._id_A729.origin);
  _id_07F9::_id_A8B1(var_13, 0);
  _id_07F9::_id_FB8F(var_13, "icon_waypoint_dom" + var_1);
  _id_07F9::_id_FB9C(var_13, "Nebula");
  _id_07F9::_id_A8BE(var_13, 0);
  _id_07F9::_id_A8C4(var_13, 0);
  _id_07F9::_id_A8BA(var_13, 0);
  _id_07F9::_id_FB98(var_13, 8);
  _id_07F9::objective_set_hide_on_minimap_when_clipped(var_13, 1);
}

initnukezones() {
  foreach(var_1 in level._id_A8E8) {
    level thread _id_D895(var_1, var_1._id_A8E1);
  }
}

_id_D895(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0._id_A8E1)) {
    var_0._id_A8E1 = var_1;
  }

  var_2 = var_0.origin;

  if(!isDefined(var_2)) {
    var_2 = var_0._id_C90E.origin;
  }

  var_0._id_A728 = getent("nukeZone" + var_1, "targetname");

  if(isDefined(var_0._id_A728)) {
    var_3 = var_0._id_A728.origin;
  } else {
    var_3 = findnukezonevfxorigin(var_1);
  }

  if(!isDefined(var_3)) {
    var_3 = var_2 - (0, 0, 50);
  }

  var_0._id_4347 = spawn("script_model", var_3);
  var_0._id_4347 setModel("tag_origin");
  var_0._id_A729 = findnukezonetrigger(var_1);

  if(!isDefined(var_0._id_A729)) {
    var_0._id_A729 = spawn("trigger_radius", var_3 - (0, 0, 5000), 0, 3000, 20000);
  }

  if(isDefined(var_0._id_A729._id_0359)) {
    var_0._id_A740 = var_0._id_A729._id_0359;
  } else {
    var_0._id_A740 = 3000;
  }

  var_0.base_center_fx_origin = findbasecenterfxorigin(var_1);

  if(isDefined(var_0._id_A728)) {
    var_0._id_A728 delete();
  }
}

findnukezonetrigger(var_0) {
  var_1 = getEntArray("nukeBlastZoneTrigger", "targetname");

  foreach(var_3 in var_1) {
    if(var_3._id_CD99 == var_0) {
      return var_3;
    }
  }

  return undefined;
}

findnukezonevfxorigin(var_0) {
  var_1 = scripts\engine\utility::getstructarray("nukeBlastZone_fx_origin", "targetname");

  foreach(var_3 in var_1) {
    if(var_3._id_CD99 == var_0) {
      return var_3.origin;
    }
  }

  return undefined;
}

findbasecenterfxorigin(var_0) {
  var_1 = scripts\engine\utility::getstructarray("basecenter_fx_origin", "targetname");

  foreach(var_3 in var_1) {
    if(var_3._id_CD99 == var_0) {
      return var_3.origin;
    }
  }

  return undefined;
}

_id_8D94(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_A729)) {
    return;
  }
  var_1 = var_0._id_A729;

  foreach(var_3 in level.players) {
    if(!isalive(var_3) || isDefined(var_3.vehicle)) {
      continue;
    }
    if(var_3 istouching(var_1) && var_3.sessionstate == "playing" && !istrue(var_3._id_B928)) {
      var_3 _meth_81FA(var_3.origin, var_1, var_1, "MOD_TRIGGER_HURT");
    }
  }
}

killnukecratesinnukezone(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_A729)) {
    return;
  }
  var_1 = var_0._id_A729;

  foreach(var_3 in level.nuke_crate_spawns_and_carriers) {
    if(isDefined(var_3) && isDefined(var_3.cratetype) && var_3.cratetype == "base_nuke") {
      if(var_3 istouching(var_1)) {
        var_3 scripts\cp_mp\killstreaks\airdrop::_id_4843();
        level.nuke_crate_neutral_count--;
      }
    }
  }
}

_id_8DF4(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_A729) || !isDefined(level._id_1031A)) {
    return;
  }
  var_1 = var_0._id_A729;
  var_2 = spawnStruct();
  var_2.objweapon = undefined;
  var_2._id_9CD6 = "MOD_EXPLOSIVE";

  foreach(var_4 in level._id_1031A) {
    if(!isalive(var_4)) {
      continue;
    }
    if(var_4 istouching(var_1)) {
      var_2.inflictor = var_4;
      level._id_1031A = scripts\engine\utility::array_remove(level._id_1031A, var_4);

      if(isDefined(var_4._id_43DB)) {
        var_4 thread[[var_4._id_43DB]](var_2.inflictor, var_2.attacker, var_2.damage, var_2._id_7C97, var_2._id_9CD6, var_2.objweapon, var_2.point, var_2._id_49C1, var_2._id_79A8, var_2._id_F21F, var_2._id_9FDA, var_2._id_031A);
        continue;
      }

      if(isDefined(level._id_1032B) && isDefined(level._id_1032B._id_43DB)) {
        var_4 thread[[level._id_1032B._id_43DB]](var_2);
      }
    }
  }
}

_id_B8A6(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_4347)) {
    return;
  }
  playFXOnTag(scripts\engine\utility::getfx("vfx_ar_damage_indicator_a"), var_0._id_4347, "tag_origin");
}

_id_A127(var_0) {
  level endon("game_ended");
  level endon("nuke_landed");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0._id_A729;

  if(!isDefined(var_1)) {
    return;
  }
  var_1._id_109E4 = [];

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      if(isDefined(var_2.owner)) {
        var_2 = var_2.owner;
      } else {
        continue;
      }
    }

    if(!isDefined(var_1._id_109E4[var_2.guid])) {
      var_1._id_109E4[var_2.guid] = var_2;
      var_2 thread _id_A10A(var_1);
    }
  }
}

_id_A10A(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  level endon("nuke_landed");
  thread _id_A128(var_0);
  var_1 = 0;

  while(isDefined(self) && isalive(self) && (self istouching(var_0) || isDefined(self.vehicle) && self.vehicle istouching(var_0))) {
    if(var_1 == 0) {
      self setclientomnvar("ui_base_nuke_timer_type", 2);
      setomnvar("ui_nuke_countdown_active", 1);
      var_1 = 1;
    }

    waitframe();
  }

  self notify("nuke_exit_warning_zone");
  self setclientomnvar("ui_base_nuke_timer_type", -1);
  setomnvar("ui_nuke_countdown_active", 0);
  level notify("large_destruction_timer_stop");
  var_0._id_109E4[self.guid] = undefined;
}

_id_A128(var_0) {
  level endon("game_ended");
  level endon("nuke_landed");
  scripts\engine\utility::_id_10875("disconnect", "nuke_exit_warning_zone");
  var_0._id_109E4[self.guid] = undefined;
}

_id_A12A(var_0) {
  level endon("game_ended");
  scripts\engine\utility::_id_10875("disconnect", "left_all_nukezones");
  level._id_596C = scripts\engine\utility::array_remove(level._id_596C, self);
}

_id_A129(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }
  var_2 = var_0._id_A729;

  if(!isDefined(var_2)) {
    return;
  }
  _func_012F(scripts\engine\utility::getfx("vfx_ar_damage_indicator_a"), var_0._id_4347, "tag_origin");

  if(getdvarint("#x34273d28d4cb45aca", 1) == 1) {
    var_3 = var_0._id_4347 gettagorigin("tag_origin");

    if(istrue(var_1)) {
      var_4 = spawnfx(scripts\engine\utility::getfx("vfx_ar_gassed_base_zone_intro"), var_3);
      triggerfx(var_4);
      thread scripts\mp\gametypes\arms_race_audio::snd_nebulagas(var_0._id_4347);
      thread scripts\mp\gametypes\arms_race_audio::snd_incomingmissileintro(var_0._id_4347);
    } else {
      var_4 = spawnfx(scripts\engine\utility::getfx("vfx_ar_gassed_base_zone"), var_3);
      triggerfx(var_4);
      thread scripts\mp\gametypes\arms_race_audio::snd_nebulagas(var_0._id_4347);
    }
  }

  wait 2;

  for(;;) {
    var_2 waittill("trigger", var_5);

    if(!isDefined(var_5.guid)) {
      var_5.guid = "vehicle:" + gettime();
    }

    var_6 = 0;

    if(isDefined(var_5.vehicle)) {
      var_6 = 1;
      var_5 = var_5.vehicle;
    } else if(isDefined(var_5._id_A924))
      var_6 = 1;

    if(var_6 && !_func_011A(var_5.origin, var_2)) {
      waittillframeend;
      continue;
    }

    if(!isDefined(var_5._id_41DA) || !scripts\engine\utility::array_contains(var_5._id_41DA, var_2)) {
      if(isPlayer(var_5)) {
        thread monitorplayerinsidenuketrigger(var_5, var_2);
        continue;
      }

      if(isDefined(var_5._id_A924)) {
        level thread monitorvehicleinsidenuketrigger(var_5, var_2);
      }
    }
  }
}

monitorplayerinsidenuketrigger(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");
  addplayertofalloutdamagearray(var_0, var_1);
  var_0 thread _id_A12A(var_1);
  var_3 = "mpnuke";

  switch (level.mapname) {
    case "mp_ar_alps":
      var_3 = "mp_ar_alps_nuke";
      break;
  }

  var_0 visionsetnakedforplayer(var_3, 0.5);
  _func_019D(level._effect["screen_ar_player_gas"], var_0, "tag_origin", var_0);
  playFXOnTag(level._effect["char_ar_gas_damage"], var_0, "j_spine4");

  if(!istrue(var_0._id_61CB)) {
    var_0 thread _id_0A0D::_id_613D();
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](var_0, "gas_player_cough");
  }

  var_4 = 4;
  var_0 setclientomnvar("ui_out_of_bounds_type", var_4);
  var_5 = int(gettime() + 10000);
  var_0.base_nebulaoobendtime = var_5;
  var_0 setclientomnvar("ui_out_of_bounds_countdown", var_5);

  if(isDefined(var_2)) {
    while(isDefined(var_0) && isalive(var_0) && var_2 istouching(var_1) && isalive(var_2) && isDefined(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A6(var_2, var_0))) {
      waitframe();
    }
  }

  while(isDefined(var_0) && var_0 istouching(var_1) && isalive(var_0)) {
    waitframe();
  }

  removeplayerfromfalloutdamagearray(var_0, var_1);
  base_stopnukevfxonplayer(var_0);

  if(isDefined(var_0._id_41DA) && var_0._id_41DA.size <= 0) {
    var_0 notify("gas_exited");

    if(isDefined(var_0._id_ABEB) && var_0._id_ABEB.size > 0) {
      var_0 scripts\mp\outofbounds::_id_B6A1();
    } else {
      var_0 setclientomnvar("ui_out_of_bounds_type", 0);
      var_0 setclientomnvar("ui_out_of_bounds_countdown", 0);
    }
  }
}

base_stopnukevfxonplayer(var_0) {
  var_0 visionsetnakedforplayer("", 0);
  _func_012F(level._effect["screen_ar_player_gas"], var_0, "tag_origin");
  _func_012F(level._effect["char_ar_gas_damage"], var_0, "j_spine4");
}

monitorplayerinsidenuketrigger_ondeath() {
  level endon("game_ended");
  self endon("left_all_nukezones");
  thread monitorplayerinsidenuketrigger_nodeathvfxstates();
  self waittill("death");

  if(istrue(self.base_allow_nebuladeathvfx)) {
    playFXOnTag(level._effect["char_ar_gas_death"], self, "j_spine4");
  }
}

monitorplayerinsidenuketrigger_nodeathvfxstates() {
  level endon("game_ended");
  self endon("left_all_nukezones");
  self endon("death");

  for(;;) {
    waitframe();

    if(isDefined(self.vehicle) && isDefined(self.vehicle._id_A924) && scripts\engine\utility::array_contains(self.vehicle._id_A924, self)) {
      self.base_allow_nebuladeathvfx = 0;
      continue;
    }

    if(self _meth_86B7() || self _meth_86B8() || self isskydiving() || self isonladder()) {
      self.base_allow_nebuladeathvfx = 0;
      continue;
    }

    self.base_allow_nebuladeathvfx = 1;
  }
}

addplayertofalloutdamagearray(var_0, var_1) {
  if(!isDefined(var_0._id_41DA)) {
    var_0._id_41DA = [];
  }

  if(!scripts\engine\utility::array_contains(var_0._id_41DA, var_1)) {
    var_0._id_41DA = scripts\engine\utility::_id_1B8D(var_0._id_41DA, var_1);
  }

  if(!isDefined(level._id_596C)) {
    level._id_596C = [];
  }

  if(!scripts\engine\utility::array_contains(level._id_596C, var_0)) {
    level._id_596C = scripts\engine\utility::_id_1B8D(level._id_596C, var_0);
  }

  if(!isDefined(level._id_8851) || !level._id_8851) {
    thread _id_CA39();
  }
}

removeplayerfromfalloutdamagearray(var_0, var_1) {
  if(!isDefined(var_0._id_41DA)) {
    var_0._id_41DA = [];
  }

  if(!isDefined(level._id_596C)) {
    level._id_596C = [];
  }

  if(scripts\engine\utility::array_contains(var_0._id_41DA, var_1)) {
    if(isDefined(var_0)) {
      var_0._id_41DA = scripts\engine\utility::array_remove(var_0._id_41DA, var_1);
    }

    if(scripts\engine\utility::array_contains(level._id_596C, var_0) && var_0._id_41DA.size == 0) {
      level._id_596C = scripts\engine\utility::array_remove(level._id_596C, var_0);
      var_0 notify("left_all_nukezones");
    }
  }
}

monitorvehicleinsidenuketrigger(var_0, var_1) {
  level endon("game_ended");
  addvehicletofallouttracking(var_0, var_1);
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_0);

  foreach(var_4 in var_2) {
    level thread monitorplayerinsidenuketrigger(var_4, var_1, var_0);
  }

  while(isDefined(var_0) && var_0 istouching(var_1) && isalive(var_0)) {
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_0, 0);
    var_7 = scripts\engine\utility::_id_1BA6(var_6, var_2);

    foreach(var_9 in var_7) {
      level thread monitorplayerinsidenuketrigger(var_9, var_1, var_0);
    }

    var_2 = var_6;
    waitframe();
  }

  removevehiclefromfallouttracking(var_0, var_1);

  if(isDefined(var_0) && isDefined(var_0._id_A924) && var_0._id_A924.size > 0) {
    foreach(var_4 in scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_0, 0)) {
      removeplayerfromfalloutdamagearray(var_4, var_1);
      base_stopnukevfxonplayer(var_4);
    }
  }
}

addvehicletofallouttracking(var_0, var_1) {
  if(!isDefined(var_0._id_41DA)) {
    var_0._id_41DA = [];
  }

  if(!scripts\engine\utility::array_contains(var_0._id_41DA, var_1)) {
    var_0._id_41DA = scripts\engine\utility::_id_1B8D(var_0._id_41DA, var_1);
  }
}

removevehiclefromfallouttracking(var_0, var_1) {
  if(!isDefined(var_0._id_41DA)) {
    var_0._id_41DA = [];
  }

  if(scripts\engine\utility::array_contains(var_0._id_41DA, var_1)) {
    if(isDefined(var_0)) {
      var_0._id_41DA = scripts\engine\utility::array_remove(var_0._id_41DA, var_1);
    }
  }
}

_id_CA39() {
  level endon("game_ended");
  level._id_8851 = 1;

  while(level._id_596C.size > 0) {
    foreach(var_1 in level._id_596C) {
      if(!isDefined(var_1)) {
        level._id_596C = scripts\engine\utility::_id_1BD1(level._id_596C);
        continue;
      }

      var_2 = undefined;
      var_3 = _id_6977(var_1);
      var_4 = var_3;
      var_5 = var_3.origin;
      var_6 = [];

      if(isPlayer(var_1)) {
        var_6[0] = var_1;
      } else if(isDefined(var_1._id_A924)) {
        foreach(var_8 in scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_1)) {
          if(isalive(var_8)) {
            var_6[var_6.size] = var_8;
          }
        }
      }

      var_10 = !isDefined(var_1.sessionstate) || var_1.sessionstate == "playing";

      if(var_6.size > 0 && var_10) {
        foreach(var_12 in var_6) {
          var_12 shellshock("mp_radiation_high", 1);
        }

        var_1 dodamage(10, var_5, var_4, var_2, "MOD_TRIGGER_HURT");
      }
    }

    wait 1;
  }

  level._id_8851 = 0;
}

_id_6977(var_0) {
  if(!isDefined(var_0._id_41DA) || var_0._id_41DA.size == 0) {
    return undefined;
  }

  var_1 = var_0._id_41DA[0];

  for(var_2 = 1; var_2 < var_0._id_41DA.size; var_2++) {
    var_3 = distance(var_0.origin, var_1.origin);
    var_4 = distance(var_0.origin, var_0._id_41DA[var_2].origin);

    if(var_4 < var_3) {
      var_1 = var_0._id_41DA[var_2];
    }
  }

  return var_1;
}

_id_A126() {
  level endon("game_ended");
  self endon("nuke_crate_captured");
  var_0 = getbasearrayoftype(level._id_A8E8, self.team);
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(self istouching(var_3.trigger)) {
      if(istrue(self.innocapturearea)) {
        continue;
      }
      if(isDefined(level.captureexclusiontriggers)) {
        var_4 = 0;

        foreach(var_6 in level.captureexclusiontriggers) {
          if(isDefined(var_6) && self istouching(var_6)) {
            var_4 = 1;
            break;
          }
        }

        if(var_4) {
          continue;
        }
      }

      var_1 = 1;
      break;
    }
  }

  if(!var_1 || istrue(level._id_82D1)) {
    level.nuke_crate_spawns_and_carriers = scripts\engine\utility::array_add(level.nuke_crate_spawns_and_carriers, self);

    if(!istrue(level._id_82D1)) {
      _id_0A8D::_id_E775("crate_carrier_hostile", scripts\mp\utility\game::_id_6BE2(self.team)[0], "crate_carrier_hostile", undefined, undefined, 45, 1);
      _id_0A8D::_id_E775("crate_carrier_friendly", self.team, "crate_carrier_friendly", [self], undefined, 45, 1);
    }

    thread monitornukecratecarrier_cratecleanup();
    thread monitornukecratecarrier_nearestbase();
    scripts\engine\utility::waittill_any_2("death", "disconnect");
    var_9 = undefined;

    if(isDefined(self.origin)) {
      var_9 = self.origin;
    } else if(isDefined(self._id_CB4D)) {
      var_9 = self._id_CB4D;
    } else if(isDefined(self._id_BA0D)) {
      var_9 = self._id_BA0D;
    } else {
      return;
    }

    var_10 = undefined;

    if(isDefined(self.angles)) {
      var_10 = self.angles;
    } else {
      var_10 = (0, 0, 0);
    }

    var_11 = scripts\cp_mp\killstreaks\airdrop::_id_6995(var_9, 0);
    var_12 = scripts\cp_mp\killstreaks\airdrop::_id_6996(var_11, scripts\cp_mp\killstreaks\airdrop::_id_6994(var_11, 0));
    var_13 = scripts\cp_mp\killstreaks\airdrop::createcrate(undefined, undefined, "base_nuke", var_9, var_10, var_12, 0, 0);
    var_13._id_5FB8 hide();
    var_13 show();
    var_13 scripts\cp_mp\killstreaks\airdrop::_id_3E99();
    nukecrate_objectiveinit(var_13);
  }
}

monitornukecratecarrier_nearestbase() {
  level endon("game_ended");
  self notify("end_nearest_base_effects");
  self endon("end_nearest_base_effects");
  thread monitornukecratecarrier_nearestbase_cleanup();
  var_0 = getdvarfloat("scr_base_nearest_vfx_heartbeat", 1);
  var_1 = undefined;

  for(;;) {
    if(istrue(level._id_82D1)) {
      var_1 = undefined;
      self.nukecratecarrier_nearestbase = undefined;

      if(isDefined(self.nearest_base_fx)) {
        self.nearest_base_fx delete();
        self.nearest_base_fx = undefined;
      }

      wait(var_0);
      continue;
    }

    var_2 = getnearestbasetolocoftype(self.origin, self.team);

    if(isDefined(var_2)) {
      if(!isDefined(var_1) || var_2 != var_1) {
        if(isDefined(self.nearest_base_fx)) {
          self.nearest_base_fx delete();
          self.nearest_base_fx = undefined;
        }

        var_1 = var_2;
        self.nukecratecarrier_nearestbase = var_2;
        self.nearest_base_fx = spawn("script_model", var_1.base_center_fx_origin);
        self.nearest_base_fx setModel("tag_origin");
        self.nearest_base_fx.angles = (0, 0, 0);
        _func_019D(scripts\engine\utility::getfx("vfx_ui_closest_base_01"), self.nearest_base_fx, "tag_origin", self);
      }
    } else {
      var_1 = undefined;
      self.nukecratecarrier_nearestbase = undefined;

      if(isDefined(self.nearest_base_fx)) {
        self.nearest_base_fx delete();
        self.nearest_base_fx = undefined;
      }
    }

    wait(var_0);
  }
}

monitornukecratecarrier_nearestbase_cleanup() {
  level endon("game_ended");
  scripts\engine\utility::_id_10882("death", "disconnect", "nuke_crate_captured", "end_nearest_base_effects");
  self notify("end_nearest_base_effects");
  self.nukecratecarrier_nearestbase = undefined;

  if(isDefined(self.nearest_base_fx)) {
    self.nearest_base_fx delete();
    self.nearest_base_fx = undefined;
  }
}

monitornukecratecarrier_cratecleanup() {
  level endon("game_ended");
  var_0 = self.team;
  scripts\engine\utility::_id_10888(self, "disconnect", self, "death", self, "nuke_crate_captured", level, "game_ended");
  var_1 = "";

  if(var_0 == "axis") {
    var_1 = "ui_base_objective_nebula_axis";
  } else {
    var_1 = "ui_base_objective_nebula_allies";
  }

  var_2 = _func_00BE(var_1);
  var_2 = var_2 - 1;
  setomnvar(var_1, var_2);

  if(isDefined(self)) {
    self setclientomnvar("ui_base_objective_nebula_player", 0);
  }

  if(level.nuke_crate_neutral_count > 0) {
    setomnvar("ui_base_objective_nebula_time", 0);
  }

  level thread delayremovenukecratetracking(self);

  if(isDefined(self)) {
    self._id_A72C = 0;
    self setclientomnvar("ui_base_carrying_nuke", 0);
  }

  if(isDefined(self._id_413F)) {
    _id_07F9::_id_C799(self._id_413F);
    self._id_413F = undefined;
  }
}

monitornearestnuketoplayer() {
  level endon("game_ended");
  self notify("end_nearest_nuke_effects");
  self endon("end_nearest_nuke_effects");
  thread monitornearestnuketoplayer_cleanup();
  var_0 = getdvarfloat("scr_base_nearest_vfx_heartbeat", 1);
  var_1 = undefined;

  for(;;) {
    wait(var_0);

    if(istrue(level._id_82D1)) {
      monitornearestnuketoplayer_deletenukefx();
      continue;
    }

    if(istrue(self._id_B072)) {
      continue;
    }
    if(istrue(self._id_A72C)) {
      continue;
    }
    var_2 = array_removeundefined_andcarriersinnukeui(level.nuke_crate_spawns_and_carriers);

    if(var_2.size > 0) {
      var_3 = undefined;

      for(var_4 = 0; var_4 < var_2.size; var_4++) {
        var_5 = scripts\engine\utility::_id_6369(self.origin, var_2)[var_4];

        if(!isDefined(var_5.team) || var_5.team == self.team) {
          var_3 = var_5;
          break;
        }
      }

      if(!isDefined(var_3)) {
        monitornearestnuketoplayer_deletenukefx();
        continue;
      }

      if(!isDefined(var_1) || var_3 != var_1) {
        monitornearestnuketoplayer_deletenukefx();
        var_1 = var_3;
        self.nearestnuke = var_3;
        self.nearest_nuke_fx = spawn("script_model", var_3.origin);
        self.nearest_nuke_fx setModel("tag_origin");
        self.nearest_nuke_fx.angles = var_3.angles;

        if(!isDefined(var_3._id_0481) || var_3._id_0481 != "nuke_spawn_node") {
          self.nearest_nuke_fx linkto(var_3, "tag_origin");
        }

        _func_019D(scripts\engine\utility::getfx("vfx_ar_crate_locator"), self.nearest_nuke_fx, "tag_origin", self);
      }

      continue;
    }

    monitornearestnuketoplayer_deletenukefx();
  }
}

monitornearestnuketoplayer_cleanup() {
  level endon("game_ended");
  scripts\engine\utility::_id_10882("death", "disconnect", "end_nearest_nuke_effects", "nuke_crate_captured");
  self notify("end_nearest_nuke_effects");
  monitornearestnuketoplayer_deletenukefx();
}

monitornearestnuketoplayer_deletenukefx() {
  self.nearestnuke = undefined;

  if(isDefined(self.nearest_nuke_fx)) {
    self.nearest_nuke_fx delete();
    self.nearest_nuke_fx = undefined;
  }
}

delayremovenukecratetracking(var_0, var_1) {
  wait 1;

  if(isDefined(var_0)) {
    level.nuke_crate_spawns_and_carriers = scripts\engine\utility::array_remove(level.nuke_crate_spawns_and_carriers, var_0);
  } else {
    level.nuke_crate_spawns_and_carriers = scripts\engine\utility::_id_1BD1(level.nuke_crate_spawns_and_carriers);
  }

  if(istrue(var_1)) {
    scripts\engine\utility::_id_4794(var_0);
  }
}

array_removeundefined_andcarriersinnukeui(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!isDefined(var_3.origin)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_34E4(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(istrue(level._id_82D1)) {
    return 0;
  }

  var_2 = _id_6972(var_0);

  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = level._id_A8E8[var_2];

  if(!isDefined(var_1)) {
    var_1 = var_3._id_ADAE;
  }

  foreach(var_5 in var_3._id_F396[var_1]) {
    if(istrue(var_5.player._id_A72C)) {
      if(isDefined(var_5.player.vehicle)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_10182(var_5.player.vehicle, undefined, var_5.player, undefined, 1);
      }

      foreach(var_7 in level.players) {
        if(var_5.player.team != var_7.team) {
          continue;
        }
        if(var_5.player.guid == var_7.guid) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_7)) {
          continue;
        }
        foreach(var_9 in var_7.escortedteammates) {
          if(var_9.guid == var_5.player.guid) {
            var_7 setclientomnvar("ui_base_objective_deliver_complete", gettime());
            var_7 _id_1099("crate_escort_success");
          }
        }
      }

      var_5.player setclientomnvar("ui_base_objective_deliver_complete", gettime());
      waitframe();

      if(!scripts\mp\utility\player::isreallyalive(var_5.player)) {
        var_5.player._id_A72C = 0;
        continue;
      }

      level notify("nuke_crate_captured", var_5.player.team, var_5.player);
      var_5.player notify("nuke_crate_captured");
      _id_0A8D::_id_E775("crate_captured_hostile", scripts\mp\utility\game::_id_6BE2(var_5.player.team)[0]);
      _id_0A8D::_id_E775("crate_captured_friendly", var_5.player.team);
      var_5.player _id_1099("crate_delivery_success");
      var_5.player._id_A72C = 0;
      return 1;
    }
  }

  return 0;
}

base_hideobjectivedistance_toplayersinspawnselection(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    waitframe();
  }

  foreach(var_3 in level.players) {
    if(istrue(var_3._id_82F2)) {
      _id_07F9::_id_A876(var_0, var_3);
    }
  }
}

base_nukecratespawnsandcarriers_hidedistancetoplayer(var_0) {
  foreach(var_2 in level.nuke_crate_spawns_and_carriers) {
    if(isDefined(var_2._id_413F)) {
      _id_07F9::_id_A876(var_2._id_413F, var_0);
    }
  }
}

base_nukecratespawnsandcarriers_showdistancetoplayer(var_0) {
  foreach(var_2 in level.nuke_crate_spawns_and_carriers) {
    if(isDefined(var_2._id_413F)) {
      _id_07F9::_id_A8BF(var_2._id_413F, var_0);
    }
  }
}

_id_D884() {
  var_0 = [];
  var_1 = ["gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05", "gw_fob_axisHQ"];

  if(getdvarint("#x38771cce1c177d002", 0) > 0) {
    var_1 = modifybaselist(var_1);
  }

  foreach(var_3 in var_1) {
    var_0[var_0.size] = ::scripts\cp_mp\utility\game_utility::_id_6B17(var_3);
  }

  var_5 = getdvarfloat("scr_base_plane_dist", 22000);
  var_6 = getdvarfloat("scr_base_plane_height", 6000);
  var_7 = getdvarfloat("scr_base_plane_separation", 1500);
  var_8 = (0, 0, 0);
  var_9 = spawnStruct();
  var_10 = spawnStruct();
  var_11 = spawnStruct();
  var_12 = spawnStruct();
  var_13 = spawnStruct();
  var_14 = spawnStruct();
  var_15 = [];

  foreach(var_17 in var_0) {
    var_15[var_15.size] = var_17.origin;
  }

  var_19 = _func_0016(var_15);
  var_20 = spawnStruct();
  var_20.origin = (var_19[0], var_19[1], var_6);
  var_20.angles = (0, var_8[1], 0);
  var_21 = var_5 * vectornormalize(anglesToForward(var_20.angles));
  var_22 = var_7 * vectornormalize(anglestoright(var_20.angles));
  var_9.origin = var_20.origin + var_21 - var_22;
  var_10.origin = var_20.origin - var_21 - var_22;
  var_11.origin = var_20.origin - 2 * var_21 - var_22;
  var_12.origin = var_20.origin - var_21 + var_22;
  var_13.origin = var_20.origin + var_21 + var_22;
  var_14.origin = var_20.origin + 2 * var_21 + var_22;
  var_23 = [var_9, var_12];
  var_24 = [var_10, var_13];

  for(var_25 = 0; var_25 < var_23.size; var_25++) {
    var_23[var_25].angles = scripts\engine\utility::_id_5CD9(vectortoangles(var_24[var_25].origin - var_23[var_25].origin));
  }

  level._id_84D6 = [];
  level._id_84D6["allies"] = [];
  level._id_84D6["axis"] = [];
  level._id_84D6["axis"][0] = var_9;
  level._id_84D6["axis"][1] = var_10;
  level._id_84D6["allies"][0] = var_12;
  level._id_84D6["allies"][1] = var_13;
  level.exitpathnodes["axis"] = var_11;
  level.exitpathnodes["allies"] = var_14;
}

modifybaselist(var_0) {
  var_1 = var_0;
  var_2 = getdvarint("#x38771cce1c177d002", 0);
  var_3 = getdvarfloat("#x3619b4c1a2095d62a", 22000);
  var_4 = getdvarfloat("#x3ad52517ce5d07d25", 33);
  var_5 = getdvarfloat("#x3ac977d92c6d4e4f3", 27);
  var_6 = 1;

  switch (var_2) {
    case 1:
      var_1 = ["gw_fob_01", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_05"];
      var_6 = 0.75;
      break;
    case 2:
      var_1 = ["gw_fob_alliesHQ", "gw_fob_01", "gw_fob_03", "gw_fob_05", "gw_fob_axisHQ"];
      break;
    case 3:
      var_1 = ["gw_fob_alliesHQ", "gw_fob_02", "gw_fob_03", "gw_fob_04", "gw_fob_axisHQ"];
      break;
    case 4:
      var_1 = ["gw_fob_alliesHQ", "gw_fob_02", "gw_fob_04", "gw_fob_axisHQ"];
      break;
    case 5:
      var_1 = ["gw_fob_02", "gw_fob_03", "gw_fob_04"];
      var_6 = 0.7;
      break;
    case 6:
      var_1 = ["gw_fob_01", "gw_fob_03", "gw_fob_05"];
      var_6 = 0.75;
      break;
    case 7:
      var_1 = ["gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_04", "gw_fob_05", "gw_fob_axisHQ"];
      break;
    case 8:
      var_1 = ["gw_fob_03", "gw_fob_04", "gw_fob_05", "gw_fob_axisHQ"];
      var_6 = 0.65;
      break;
    case 9:
      var_1 = ["gw_fob_alliesHQ", "gw_fob_01", "gw_fob_02", "gw_fob_03"];
      var_6 = 0.65;
      break;
  }

  setDvar("#x3619b4c1a2095d62a", var_3 * var_6);
  setDvar("#x3ad52517ce5d07d25", var_4 * var_6);
  setDvar("#x3ac977d92c6d4e4f3", var_5 * var_6);
  return var_1;
}

_id_D885() {
  level endon("game_ended");

  while(!isDefined(level._id_EF89) || level._id_EF89.size < 2) {
    waitframe();
  }

  level thread _id_A6AF();

  foreach(var_1 in level._id_EF89) {
    if(!isDefined(level._id_84D6[var_1]) || !isDefined(level._id_84D6[var_1][0])) {
      continue;
    }
    level thread _id_CA44(var_1);
  }
}

_id_A6AF() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);
    var_0 thread monitornearestnuketoplayer();
    var_0 thread monitorovertimenearestbasetoplayer();

    if(isDefined(var_0.team)) {
      level notify("player_spawned_" + var_0.team, var_0);
    }
  }
}

_id_CA44(var_0) {
  level endon("game_ended");
  level._id_7AB5 = 0;
  var_1 = _id_E311("paratrooper", level._id_84D6[var_0][0]);
  var_1.team = var_0;
  var_1 hide();
  level thread _id_B178(var_0, var_1);
  level thread snd_flyintrovehicle_paratrooper_intro(var_1);
  level thread snd_flyintrovehicle_paratrooper_engine(var_1);
  level thread snd_flyintrovehicle_paratrooper_flyby(var_1);
  _id_07D1::_id_60C2("prematch_waitForPlayers_Complete");
  var_1 show();
  level thread spawnintrovehicle_vfx(var_1, "paratrooper");
  var_1 thread _id_5D47(var_0);
  level waittill("matchStartTimer_done");
  level notify("hotdrop_infil_end");
  level._id_7AB5 = 1;
}

_id_E311(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles);
  var_3 = anglestoright(var_1.angles);
  var_4 = 600;
  var_5 = "";
  var_6 = 1;
  var_7 = var_2 * var_4 * -1 + var_3 * var_4 * var_6;
  var_8 = spawn("script_model", var_1.origin + var_7);

  switch (var_0) {
    case "paratrooper":
      var_5 = "plane_skilo_ar_00";
      var_8 setModel(var_5);
      break;
    default:
      break;
  }

  var_8.angles = var_1.angles;
  return var_8;
}

spawnintrovehicle_vfx(var_0, var_1) {
  switch (var_1) {
    case "paratrooper":
      var_2 = "plane_skilo_ar_00";
      var_0 setModel(var_2);
      var_3 = spawn("script_model", var_0 gettagorigin("tag_turbine_l_fx"));
      var_3.angles = var_0 gettagangles("tag_turbine_l_fx");
      var_3 setModel("tag_origin");
      var_3 linkto(var_0, "tag_turbine_l_fx");
      var_0.propellorfx[0] = var_3;
      var_4 = spawn("script_model", var_0 gettagorigin("tag_turbine_r_fx"));
      var_4.angles = var_0 gettagangles("tag_turbine_r_fx");
      var_4 setModel("tag_origin");
      var_4 linkto(var_0, "tag_turbine_r_fx");
      var_0.propellorfx[1] = var_4;
      var_5 = spawn("script_model", var_0 gettagorigin("tag_origin"));
      var_5.angles = var_0 gettagangles("tag_origin");
      var_5 setModel("tag_origin");
      var_5 linkto(var_0, "tag_origin");
      var_0.cloudfx[2] = var_5;
      playFXOnTag(level._id_0BCE["plane_propellor"], var_0.propellorfx[0], "tag_origin");
      playFXOnTag(level._id_0BCE["plane_propellor"], var_0.propellorfx[1], "tag_origin");
      playFXOnTag(level._id_0BCE["plane_clouds"], var_0.cloudfx[2], "tag_origin");

      if(isDefined(level._effect["trail_chinook"])) {
        playFXOnTag(scripts\engine\utility::getfx("trail_chinook"), var_0, "tag_origin");
      }

      break;
    default:
      break;
  }
}

_id_B178(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  level endon("vehicle_spawn_stop");
  level endon("hotdrop_infil_end");
  var_1._id_B711 = [];

  for(;;) {
    level waittill("player_spawned_" + var_0, var_2);

    if(istrue(var_2._id_7AB4)) {
      continue;
    }
    if(isai(var_2) || istrue(var_2.pers["isTestClient"])) {
      continue;
    }
    var_2._id_84E2 = var_1;
    var_2._id_7AB4 = 1;
    level thread playerwaitforcountdown(var_1, var_2);
  }
}

playerwaitforcountdown(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  level endon("vehicle_spawn_stop");
  level endon("hotdrop_infil_end");
  var_1 endon("death");
  var_1 endon("disconnect");
  _id_07D1::_id_60C2("prematch_waitForPlayers_Complete");
  var_1 scripts\common\base_infil_prompts::create_base_infil_prompts();
  var_1 scripts\common\base_infil_prompts::infil_prompts_change_state("infil_initial");
  var_1 thread _id_AC5E(var_0);
  var_1 thread _id_A11E(var_0);
  var_0._id_B711[var_0._id_B711.size] = var_1;
}

_id_5D47(var_0) {
  level endon("game_ended");
  var_1 = getdvarfloat("scr_base_plane_flighttime", 33);
  var_2 = getdvarfloat("scr_base_plane_bailtime", 27);
  thread forceplayerjumpfromintrovehicle(var_0, var_2);
  self moveto(level._id_84D6[var_0][1].origin, var_1);
  wait(var_1);
  self moveto(level.exitpathnodes[var_0].origin, var_1);
  wait(var_1);

  foreach(var_4 in level._id_84D6[var_0]) {
    scripts\engine\utility::_id_4794(var_4);
  }

  scripts\engine\utility::_id_4794(level.exitpathnodes[var_0]);
  self delete();
}

forceplayerjumpfromintrovehicle(var_0, var_1) {
  level endon("game_ended");
  wait(var_1);
  var_2 = 0;
  var_3 = 10;

  if(self._id_B711.size > 0) {
    foreach(var_5 in self._id_B711) {
      var_5 notify("bail", var_2);
      var_2 = var_2 + var_3;
      thread snd_player_jump();
      level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_5, 0, 0);
    }
  }
}

_id_AC5E(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("death");
  self endon("disconnect");
  self setplayerangles(var_0.angles);
  self setorigin(var_0.origin);
  self playerlinkto(var_0, "tag_origin");
  self playerhide();
  self allowcrouch(0);
  self allowprone(0);

  if(isDefined(self._id_AC5E)) {
    self._id_AC5E delete();
  }

  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_player");
  var_1 linkto(var_0, "tag_origin", (0, 0, 50), (0, 0, 0));
  self._id_AC5E = var_1;
  self._id_AC5E thread scripts\mp\utility\entity::_id_477D(self);
  var_2 = "cam_orbit_br_ac130";
  self _meth_8697(var_2);
  thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0.25);
}

_id_A11E(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self setclientomnvar("ui_base_in_intro_plane", 1);
  _id_07D1::_id_60C2("prematch_done");
  thread monitorjumpoutinput();
  scripts\common\base_infil_prompts::infil_prompts_change_state("infil_jump");
  var_1 = var_0.origin;
  self waittill("bail", var_2);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_0._id_B711 = scripts\engine\utility::array_remove(var_0._id_B711, self);
  self cameradefault();
  self unlink();
  self setorigin(var_0.origin - (0, var_2, 100 + var_2));
  self playershow();
  self allowcrouch(1);
  self allowprone(1);
  self._id_84E2 = undefined;

  if(isDefined(self._id_AC5E)) {
    self._id_AC5E delete();
  }

  thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0.25);
  thread _id_0797::_id_E6AD(0.0, 0);
  scripts\common\base_infil_prompts::infil_prompts_change_state("infil_general_gameplay");
  self setclientomnvar("ui_base_in_intro_plane", 0);
}

monitorjumpoutinput() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self notifyonplayercommand("bail_input", "+gostand");
  self waittill("bail_input");
  thread snd_player_jump();
  self iprintlnbold("");
  self _meth_824C("bail_input", "+gostand");
  self notify("bail");
}

_id_8294() {
  level._id_60D6 = [];
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

  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_0 = _id_0817::_id_6D4E("mp_tdm_spawn");
  _id_0817::_id_C2B9("normal", var_0);
  var_0 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];

  foreach(var_9 in var_0) {
    var_10 = scripts\engine\utility::getstruct(var_9.target, "targetname");

    switch (var_10._id_CD99) {
      case "gw_fob_alliesHQ_extra":
        var_1 = scripts\engine\utility::array_add(var_1, var_9);
        break;
      case "gw_fob_axisHQ_extra":
        var_2 = scripts\engine\utility::array_add(var_2, var_9);
        break;
      case "gw_fob_01_extra":
        var_3 = scripts\engine\utility::array_add(var_3, var_9);
        break;
      case "gw_fob_02_extra":
        var_4 = scripts\engine\utility::array_add(var_4, var_9);
        break;
      case "gw_fob_03_extra":
        var_5 = scripts\engine\utility::array_add(var_5, var_9);
        break;
      case "gw_fob_04_extra":
        var_6 = scripts\engine\utility::array_add(var_6, var_9);
        break;
      case "gw_fob_05_extra":
        var_7 = scripts\engine\utility::array_add(var_7, var_9);
        break;
    }
  }

  _id_0817::_id_C2B9("gw_fob_alliesHQ_extra", var_1);
  _id_0817::_id_C2B9("gw_fob_axisHQ_extra", var_2);
  _id_0817::_id_C2B9("gw_fob_01_extra", var_3);
  _id_0817::_id_C2B9("gw_fob_02_extra", var_4);
  _id_0817::_id_C2B9("gw_fob_03_extra", var_5);
  _id_0817::_id_C2B9("gw_fob_04_extra", var_6);
  _id_0817::_id_C2B9("gw_fob_05_extra", var_7);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  level._id_E34D = var_0;
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
      _id_0817::_id_0EFF("start_attackers", 1);
      var_1 = _id_0817::_id_6D4A(self, var_0, undefined, "start_attackers");
    } else {
      _id_0817::_id_0EFF("start_defenders", 1);
      var_1 = _id_0817::_id_6D4A(self, var_0, undefined, "start_defenders");
    }
  } else {
    _id_0817::_id_0EFF("normal", 1);
    var_1 = _id_0817::_id_6D4A(self, var_0, undefined, "fallback");
  }

  if(istrue(level._id_FED1) && istrue(self._id_E4AB)) {
    var_2 = self getspectatingplayer();

    if(isDefined(var_2) && isDefined(self._id_E496) && self.team == var_2.team && self._id_E496 == var_2._id_E496) {
      var_1 = _id_0818::_id_5B07(var_2);
    }
  }

  return var_1;
}

monitortacopsmapexit() {
  var_0 = self;
  var_0 notify("listenRedeployExit");
  var_0 endon("disconnect");
  var_0 endon("listenRedeployExit");

  for(;;) {
    var_0 waittill("luinotifyserver", var_1, var_2);

    if(scripts\engine\utility::is_equal(var_1, "arms_race_redeploy")) {
      if(var_2 == 0) {
        var_0.tacopsmapclosed = 1;
        var_0 notify("tac_ops_map_selection_valid");
        var_0 childthread tacopsmapshowminimap();
        return;
      } else if(var_2 == 2) {
        var_0._id_D066 = _id_D074(var_0.team)[0];
        var_0 notify("tac_ops_map_selection_valid");
        return;
      }
    }
  }
}

tacopsmapshowminimap() {
  self waittill("end_spawn_cam_finished");
  scripts\mp\utility\player::_id_DCC4();
}

monitorredeploy() {
  var_0 = self;
  var_0 notify("listenRedeploy");
  var_0 endon("disconnect");
  var_0 endon("listenRedeploy");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_108A4("luinotifyserver", "redeploynotify");

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = var_1[0];
    var_3 = var_1[1];

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(isDefined(var_0._id_84E2)) {
      continue;
    }
    if(var_0 _meth_86B8()) {
      continue;
    }
    if(var_0 _meth_86B7()) {
      continue;
    }
    var_4 = var_0 getcurrentweapon();

    if(scripts\engine\utility::is_equal(var_4.basename, "s4_ks_remote_goliath_mp")) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    if(isDefined(level._id_596C) && scripts\engine\utility::array_contains(level._id_596C, var_0)) {
      continue;
    }
    var_5 = 0;

    foreach(var_7 in level.nuke_crate_spawns_and_carriers) {
      if(isDefined(var_7._id_B80E) && var_7._id_B80E == var_0) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      continue;
    }
    if(scripts\engine\utility::array_contains(level.nuke_crate_spawns_and_carriers, var_0)) {
      continue;
    }
    if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
      continue;
    }
    if(var_0 _meth_86BB()) {
      continue;
    }
    if(istrue(var_0._id_82F2)) {
      continue;
    }
    var_9 = undefined;

    if(var_0.team == "allies") {
      var_9 = "axis";
    } else if(var_0.team == "axis") {
      var_9 = "allies";
    }

    if(isDefined(var_9)) {
      var_10 = scripts\mp\utility\player::_id_6C60(var_0 getEye(), 2500, var_9);
      var_11 = [];

      for(var_12 = 0; var_12 < var_10.size; var_12++) {
        var_13 = scripts\engine\utility::_id_10E76(var_10[var_12].player getEye(), var_10[var_12].player getplayerangles(), var_0 getEye(), cos(85));

        if(var_13) {
          var_11 = scripts\engine\utility::array_add(var_11, var_10[var_12].player);
        }
      }

      if(var_11.size > 0) {
        continue;
      }
    }

    if(isplayerindanger(var_0)) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_2, "arms_race_redeploy")) {
      if(var_3 == 1 || var_3 == 2) {
        var_0.isredeploying = 1;
        var_0 notify("base_redeploy_detonate");

        if(var_3 == 1) {
          var_0 setclientomnvar("ui_base_redeploying_from_pause", 1);
        } else if(var_3 == 2) {
          var_0 setclientomnvar("ui_base_redeploying_from_map_board", 1);
        }

        var_0 thread _id_0815::_id_E722(0.0, 0.5, 0.5);
        var_0 thread monitortacopsmapexit();
        var_0 _id_0819::_id_1082A(0);
        var_0 _id_0A99::_id_D5EA(0);

        if(var_3 == 1) {
          var_0 setclientomnvar("ui_base_redeploying_from_pause", 0);
        } else if(var_3 == 2) {
          var_0 setclientomnvar("ui_base_redeploying_from_map_board", 0);
        }

        if(!istrue(var_0.tacopsmapclosed)) {
          var_14 = ["redeploy_source", var_1["message"]];
          var_0 _meth_870F("dlog_event_mp_base_player_redeploy", var_14);
          var_0 thread _id_0815::_id_534A();
          var_0 notify("spawncamera_start");

          if(istrue(var_0.isredeploying)) {
            var_0.isredeploying = 0;
          }

          if(scripts\mp\utility\player::isreallyalive(var_0)) {
            var_0 thread scripts\mp\playerlogic::_id_E337(1);
          } else {
            var_0 thread scripts\mp\playerlogic::_id_E337();
          }

          continue;
        }

        self._id_E293 = spawnStruct();
        self._id_E293._id_E332 = self.origin;
        self._id_E293._id_E267 = self.angles;
        var_0 thread _id_0815::_id_534A();
        var_0 notify("spawncamera_start");
        var_0.tacopsmapclosed = 0;

        if(istrue(var_0.isredeploying)) {
          var_0.isredeploying = 0;
        }

        while(var_0 _meth_876E("ui_in_spawn_camera") == 1) {
          waitframe();
        }

        if(!scripts\mp\utility\player::isreallyalive(var_0)) {
          var_0._id_10849 = 1;
          var_0 _id_0819::_id_1082A(0.5, 0);
          var_0 thread _id_0815::_id_534A();
          var_0 notify("spawncamera_start");
          var_0 thread scripts\mp\playerlogic::_id_E337();
        }
      }
    }
  }
}

isplayerindanger(var_0) {
  var_1 = gettime();

  if(isDefined(var_0) && (isDefined(var_0._id_8FB6) && var_0._id_8FB6 + 5000 > var_1) || isDefined(var_0._id_90A7) && var_0._id_90A7 + 5000 > var_1) {
    return 1;
  }

  if(isDefined(var_0._id_C0ED)) {
    var_0 scripts\mp\battlechatter_mp::_id_FF55();
  }

  if(isDefined(var_0._id_C0ED) && var_0._id_C0ED.size > 0) {
    return 1;
  }

  if(isDefined(var_0._id_90CA) && var_0._id_90CA + 3000 > var_1) {
    return 1;
  }

  if(isDefined(var_0._id_90CA) && isDefined(var_0._id_90C9) && var_0._id_90CA > var_0._id_90C9 || isDefined(var_0._id_90CA) && !isDefined(var_0._id_90C9)) {
    return 1;
  }

  var_2 = var_0 _meth_874A(384, 100, 1);

  if(isDefined(var_2)) {
    return 1;
  }

  if(isDefined(var_0.vehicle)) {
    if(istrue(var_0.vehicle._id_2D8B)) {
      return 1;
    }

    if(istrue(scripts\cp_mp\utility\weapon_utility::_id_8915(var_0.vehicle))) {
      return 1;
    }
  }

  if(isDefined(var_0) && var_0 scripts\mp\outofbounds::_id_8AAA()) {
    return 1;
  }

  if(isDefined(var_0) && isDefined(var_0._id_A58A) && var_0._id_A58A + 1000 > var_1) {
    return 1;
  }

  if(isDefined(level.gametype) && level.gametype == "base" && isDefined(var_0._id_F398) && base_isplayerindanger(var_0)) {
    return 1;
  }

  return 0;
}

monitorescortobjective() {
  level endon("game_ended");
  self notify("monitorEscortObjective");
  self endon("monitorEscortObjective");
  self endon("disconnect");
  self endon("death");
  self.escortedteammates = [];

  for(;;) {
    if(isDefined(self.escortedteammates)) {
      for(var_0 = self.escortedteammates.size - 1; var_0 >= 0; var_0--) {
        var_1 = self.escortedteammates[var_0];

        if(!scripts\engine\utility::array_contains(level.nuke_crate_spawns_and_carriers, var_1)) {
          self.escortedteammates = scripts\engine\utility::array_remove_index(self.escortedteammates, var_0);
        }
      }
    }

    var_2 = isplayerindanger(self);

    if(var_2) {
      for(var_0 = 0; var_0 < level.nuke_crate_spawns_and_carriers.size; var_0++) {
        var_1 = level.nuke_crate_spawns_and_carriers[var_0];

        if(isDefined(var_1.team) && var_1.team == self.team) {
          var_3 = 1000000;
          var_4 = distancesquared(self.origin, var_1.origin);

          if(var_4 < var_3) {
            if(!scripts\engine\utility::array_contains(self.escortedteammates, var_1)) {
              self.escortedteammates = scripts\engine\utility::array_add(self.escortedteammates, var_1);
            }
          }
        }
      }
    }

    waitframe();
  }
}

monitorcontestedbases() {
  level endon("game_ended");
  self notify("monitorContestedBases");
  self endon("monitorContestedBases");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    if(!isDefined(level._id_A8E8) || level._id_A8E8.size == 0) {
      waitframe();
      continue;
    }

    if(!isDefined(self) || _func_0458(self)) {
      return;
    }
    if(isDefined(self.closestcontestedbase) && isDefined(self.closestcontestedbaseplayerin) && isDefined(level._id_A8E8[self.closestcontestedbase])) {
      var_0 = self.pers["team"] == "allies" && scripts\engine\utility::is_equal(level._id_A8E8[self.closestcontestedbase].objectivestate, "allies_captured") || self.pers["team"] == "axis" && scripts\engine\utility::is_equal(level._id_A8E8[self.closestcontestedbase].objectivestate, "axis_captured");

      if(var_0) {
        self setclientomnvar("ui_base_objective_defend_target_complete", gettime());
        wait 3;
      }
    }

    var_1 = 9000000;
    var_2 = undefined;

    foreach(var_4 in level._id_A8E8) {
      var_5 = distancesquared(self.origin, var_4.origin);
      var_0 = self.pers["team"] == "allies" && var_4.objectivestate == "allies_contested" || self.pers["team"] == "axis" && var_4.objectivestate == "axis_contested";

      if(var_0 && var_5 < var_1) {
        var_1 = var_5;
        var_2 = var_4;
      }
    }

    self.closestcontestedobjective = var_2;

    if(!isDefined(var_2)) {
      self setclientomnvar("ui_base_objective_defend_target", 0);
      waitframe();
      continue;
    }

    var_7 = level._id_A8E8[var_2._id_A8E1]._id_F396[self.pers["team"]];
    var_8 = 0;

    if(!isDefined(var_7[self.guid])) {
      var_8 = 1;
    }

    self.closestcontestedbaseplayerin = var_8;
    self.closestcontestedbase = var_2._id_A8E1;
    self setclientomnvar("ui_base_objective_defend_target", getbaseindex(var_2));
    waitframe();
  }
}

_id_ABA4() {
  self._id_5EC6 = undefined;
  thread _id_FCC2();
  thread monitorcontestedbases();
  thread monitorescortobjective();
  thread scripts\mp\gametypes\s4_base_util::basemonitorweaponfire();
  _id_07F2::_id_FD3F(self.team, self._id_E496);

  if(istrue(self._id_7AB4) || level._id_7AB5) {
    thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0);

    if(!istrue(self._id_E309)) {
      thread _id_0797::_id_E6AD(0.0, 0);
      thread _id_0797::_id_B81E();
    } else
      thread onspawnplayer_watchforvehicleexit();

    scripts\common\base_infil_prompts::create_base_infil_prompts();
    scripts\common\base_infil_prompts::infil_prompts_change_state("infil_general_gameplay");
  }

  thread onspawnplayer_unfadefromblack();
  var_0 = getdvarint("#x3c8716d3ffc3b939c", 0);

  if(var_0 > 0) {
    scripts\mp\gametypes\s4_base_loot::_id_B3A0(var_0);
  }

  if(_id_0819::isredeploying()) {
    self.isredeploying = undefined;
  }

  thread monitorredeploy();

  if(getdvarint("#x3e138924b10a94dfa", 1) != 0) {
    thread scripts\mp\teams::_id_ACDA(1);
  }

  if(!isDefined(self._id_B956)) {
    self._id_B956 = 0;
  }

  if(getdvarint("#x3b20bf132f59ffcdd", 1)) {
    thread scripts\mp\gametypes\s4_base_util::motorcycle_monitor_summon();
    thread scripts\mp\gametypes\s4_base_util::motorcycle_monitor_summonability();
  }

  if(!isDefined(self.arena_evo_perks)) {
    scripts\mp\gametypes\s4_base_loot::_setperkuiomnvars();
  }
}

onspawnplayer_unfadefromblack() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  _id_07D1::_id_60C2("prematch_waitForPlayers_Complete");

  if(!isDefined(self._id_7AB4)) {
    thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0);
  }
}

onleavesquad() {
  playersetsquadcashomnvar(0);
}

base_unfadefromblackafterdelay(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  wait(var_0);
  scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0);
}

onspawnplayer_watchforvehicleexit() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self waittill("vehicle_exit");
  wait 0.1;
  thread _id_0797::_id_E6AD(0.0, 0);
  thread _id_0797::_id_B81E();
}

_id_FCC2() {
  level endon("game_ended");
  self notify("updateMatchStatusHintOnSpawn");
  self endon("updateMatchStatusHintOnSpawn");

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

  var_10 = self _meth_876E("ui_base_objective_nebula_player");

  if(var_10 && isDefined(self._id_1DDE)) {
    foreach(var_1 in self._id_1DDE) {
      var_1 setclientomnvar("ui_base_objective_eliminate_complete", gettime());
    }
  }

  if(self != var_1 && isPlayer(var_1)) {
    scripts\mp\gametypes\s4_base_loot::_id_E1C0(0, var_1);
  }

  scripts\mp\gametypes\s4_base_util::updatemotorcycleomnvar();

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
  if(istrue(level._id_15BD)) {
    level._id_15BD = 0;
  }

  if(isDefined(level._id_BFC9)) {
    thread _id_0808::_id_BFC1(var_0);
  }

  if(istrue(level._id_FEA7)) {
    var_0 _id_078A::_id_2F99();
  }

  var_0 thread monitorplayerpickedupweapons();
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

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");
    scripts\mp\utility\stats::_id_D550(0);

    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility\stats::_id_D550(self.pers["captures"]);
    }

    scripts\mp\utility\stats::_id_D551(0);

    if(isDefined(self.pers["defends"])) {
      scripts\mp\utility\stats::_id_D551(self.pers["defends"]);
    }
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

shouldbaseuseparachutespawns(var_0) {
  foreach(var_2 in level._id_A8E8) {
    if(var_2.trigger._id_0481 == var_0) {
      if(var_2._id_ADAE != self.team) {
        return 1;
      }

      if(var_2._id_37F6 != "none" && var_2._id_37F6 != var_2._id_ADAE) {
        return 1;
      }

      return 0;
    }
  }

  return 0;
}

getbasecontestedtier(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  if(!isDefined(var_0._id_4143) || !isDefined(var_0._id_FEE7)) {
    return 0;
  }

  var_1 = var_0._id_4143 / var_0._id_FEE7;

  if(var_1 > level.basecontestedtier3) {
    return 3;
  } else if(var_1 > level.basecontestedtier2) {
    return 2;
  } else if(var_1 > level.basecontestedtier1) {
    return 1;
  }

  return 0;
}

_id_8296() {
  level._id_E3EA = [];
  level._id_41F3 = "cop_2";
  var_0 = scripts\engine\utility::getstructarray("tac_ops_map_config", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;
    var_4 = scripts\engine\utility::getstructarray(var_2.target, "targetname");

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

snd_flyintrovehicle_paratrooper_intro(var_0) {
  var_1 = var_0 _meth_827E("veh_plane_carrier_intro");
}

snd_flyintrovehicle_paratrooper_engine(var_0) {
  var_1 = var_0 playLoopSound("veh_plane_carrier_engine_lp");
}

snd_flyintrovehicle_paratrooper_flyby(var_0) {
  var_1 = var_0 _meth_827E("veh_plane_carrier_flyby");
}

snd_player_jump() {
  self playSound("mp_ar_paratrooper_jump");
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

_id_2E19() {
  if(istrue(level._id_2E2D) && istrue(level._id_FE94)) {
    var_0 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1513);
    var_1 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1FE8);
    var_2 = (var_1.origin + var_0.origin) * 0.5;
    var_3 = vectortoangles(var_1.origin - var_0.origin);
    var_4 = var_3[1];

    if(0) {
      _id_44FE(var_2, (0, 1, 0), 100000);
    }
  } else {
    var_2 = (level._id_9AC4[0] + level._id_9AC4[1]) * 0.5;
    var_4 = randomfloatrange(0, 359);
  }

  var_5 = _id_99DF(var_2, var_4 - 90);
  level._id_2E3B = scripts\mp\gametypes\br_c130::_id_99FE(var_5);
  var_5._id_BFF4 = var_5._id_BFF4 + 180;
  level._id_2E3C = scripts\mp\gametypes\br_c130::_id_99FE(var_5);
  var_6 = 0.2;
  var_7 = 0;
  var_8 = 0;

  if(istrue(level._id_2E3D)) {
    var_6 = 0.1;
    var_7 = randomfloatrange(-5000.0, 5000);
    var_8 = randomfloatrange(-5000.0, 5000);
  }

  var_9 = anglestoright(level._id_2E3B._id_1784);
  level._id_2E3B._id_E715 = var_9 * level._id_2E30 + level._id_2E3B._id_E715;
  level._id_2E3B._id_5340 = var_9 * level._id_2E30 + level._id_2E3B._id_5340;
  var_9 = anglestoright(level._id_2E3C._id_1784);
  level._id_2E3C._id_E715 = var_9 * level._id_2E30 + level._id_2E3C._id_E715;
  level._id_2E3C._id_5340 = var_9 * level._id_2E30 + level._id_2E3C._id_5340;
  var_10 = (var_7, var_8, 0);
  level._id_2E3B._id_E715 = level._id_2E3B._id_E715 + var_10;
  level._id_2E3B._id_5340 = level._id_2E3B._id_5340 + var_10;
  level._id_2E3B._id_9E8E = _func_025E(level._id_2E3B._id_E715, level._id_2E3B._id_5340, 0.5);
  level._id_2E3C._id_E715 = level._id_2E3C._id_E715 + var_10;
  level._id_2E3C._id_5340 = level._id_2E3C._id_5340 + var_10;
  level._id_2E3C._id_9E8E = _func_025E(level._id_2E3C._id_E715, level._id_2E3C._id_5340, 0.5);
  level._id_2358 = _func_025E(level._id_2E3B._id_9E8E, level._id_2E3C._id_9E8E, 0.5);
  level._id_2E37 = _func_025E(level._id_2E3B._id_E715, level._id_2E3C._id_5340, var_6);
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

base_vehiclelist_monitor() {
  level endon("game_ended");

  while(!isDefined(level._id_1031A)) {
    waitframe();
  }

  for(;;) {
    level._id_1031A = scripts\engine\utility::_id_1BCC(level._id_1031A);
    waitframe();
  }
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
  _id_C2C7("cargo_truck_susp", scripts\cp_mp\vehicles\cargo_truck_susp::cargo_truck_susp_getspawnstructscallback, ::_id_10341);
  _id_C2C7("s4_tank", scripts\cp_mp\vehicles\s4_tank::s4_tank_getspawnstructscallback, ::_id_1034D);
  _id_C2C7("open_jeep", scripts\cp_mp\vehicles\open_jeep::open_jeep_getspawnstructscallback, ::vehiclespawn_open_jeep);
  _id_C2C7("motorcycle", scripts\cp_mp\vehicles\motorcycle::motorcycle_getspawnstructscallback, ::vehiclespawn_motorcycle);
}

_id_10341(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("cargo_truck_susp", var_2, var_1);
}

vehiclespawn_motorcycle(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("motorcycle", var_2, var_1);
}

_id_1034D(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  var_2._id_E325 = "place_at_position";
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("s4_tank", var_2, var_1);
}

vehiclespawn_open_jeep(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = _id_10343(var_0);
  var_2._id_E325 = "place_at_position";
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("open_jeep", var_2, var_1);
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
  var_0 = scripts\engine\utility::getstructarray("airdropLocation_allies", "targetname");
  var_1 = scripts\engine\utility::getstructarray("airdropLocation_axis", "targetname");
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
          var_1._id_E706 = (9215, 984, 325);
          var_1._id_E67A = (357, 186, 0);
          var_1._id_533C = (9107, 628, 1144);
          var_1._id_52DF = (19, 182, 0);
        } else {
          var_1._id_E706 = (-5351, 641, 408);
          var_1._id_E67A = (2, 352, 0);
          var_1._id_533C = (-5282, 996, 1103);
          var_1._id_52DF = (11, 347, 0);
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
  var_0 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1513);
  var_1 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1FE8);
  level._id_7B20 = (var_1.origin + var_0.origin) * 0.5;
  level._id_7B22 = var_0.origin - level._id_7B20;
  level._id_7B23 = var_1.origin - level._id_7B20;
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

  var_5 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1513);
  var_6 = scripts\cp_mp\utility\game_utility::_id_6B17(level._id_1FE8);

  if(var_0 == "axis") {
    var_7 = distance(var_6.origin, var_1);
    var_8 = level._id_7B23;
  } else {
    var_7 = distance(var_5.origin, var_1);
    var_8 = level._id_7B22;
  }

  if(var_7 < 2048) {
    return var_8 * var_2;
  }

  if(var_7 > level._id_7B1E) {
    if(var_0 == "axis") {
      var_7 = distance(var_5.origin, var_1);
    } else {
      var_7 = distance(var_6.origin, var_1);
    }

    var_9 = 100 - var_7 * 100 / level._id_7B1E;
    var_10 = var_8 * var_3 * -1.0 * (var_9 / 100);
    return var_10;
  } else {
    var_9 = 100 - var_7 * 100 / level._id_7B1E;
    var_10 = var_8 * var_2 * (var_9 / 100);
    return var_10;
  }
}

_id_E356() {
  if(isDefined(self._id_D066) && issubstr(self._id_D066, "HQ")) {
    return 1;
  }

  return 0;
}

_id_815C() {
  level endon("game_ended");
  setdvarifuninitialized("#x3795fc510236e5fbb", 0);
  level thread _id_3302();

  if(isDefined(level.players)) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1._id_32FE)) {
        var_1 _id_825D();
      }
    }
  }

  for(;;) {
    level waittill("connected", var_1);
    var_1 _id_825D();
  }
}

_id_3302() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  var_0 = 5.0;

  for(;;) {
    if(getdvarint("#x3795fc510236e5fbb", 0) > 0) {
      var_0 = getdvarint("#x3795fc510236e5fbb") * 2.5;
    }

    foreach(var_2 in level.players) {
      if(!isDefined(var_2._id_32FE)) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_2)) {
        continue;
      }
      var_2 _id_6FCA(var_0);
    }

    wait 2.5;
  }
}

_id_825D() {
  self._id_32FE = getdvarint("#x314946c38c889207", 0);
  _id_FCF6();
}

_id_FCF6() {
  var_0 = int(_id_6C45());
  self setclientomnvar("ui_base_current_cash", var_0);

  if(isDefined(self._id_E496) && isDefined(self._id_E4A0)) {
    playersetsquadcashomnvar(var_0);
  }
}

playersetsquadcashomnvar(var_0) {
  if(self._id_E4A0 < 0 || self._id_E4A0 > 3) {
    return;
  }
  var_1 = "ui_base_current_cash_squad_member_" + self._id_E4A0;
  var_2 = level._id_E48E[self.team][self._id_E496].players;

  foreach(var_4 in var_2) {
    if(isbot(var_4)) {
      continue;
    }
    var_4 setclientomnvar(var_1, var_0);
  }
}

_id_6FCA(var_0) {
  self _meth_870F("dlog_event_mp_base_player_gain_cash", ["cash", var_0]);
  self._id_32FE = self._id_32FE + var_0;
  _id_FCF6();
}

_id_6C45() {
  return self._id_32FE;
}

_id_E401(var_0, var_1) {
  var_0 = int(var_0);

  if(var_0 <= _id_6C45()) {
    self._id_32FE = self._id_32FE - var_0;
    _id_FCF6();
    return 1;
  }

  return 0;
}

_id_1099(var_0, var_1, var_2, var_3) {
  var_4 = tablelookuprownum("mp/cashScoreTable.csv", 0, var_0);

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(isDefined(var_0) && var_4 >= 0) {
    var_5 = int(int(tablelookupbyrow("mp/cashScoreTable.csv", var_4, 1)) * var_2);
    var_5 = checkcashdvars(var_0, var_5);
    var_5 = int(getdvarfloat("#x390a23afd3a0e5fac", 1.0) * var_5);

    if(isDefined(self.vehicle)) {
      var_5 = modifyvehiclecash(var_5, var_0);
    }

    var_6 = ["destroyed_vehicle_motorcycle", "destroyed_vehicle_jeep", "destroyed_vehicle_tank"];

    if(scripts\engine\utility::array_contains(var_6, var_0) && isDefined(self) && isDefined(var_3) && scripts\engine\utility::is_equal(self.team, var_3._id_ADAE)) {
      var_5 = 0;
    }

    _id_6FCA(var_5);
    return var_5;
  } else if(isDefined(var_1) && var_1 > 0) {
    var_1 = int(var_1 * var_2);
    _id_6FCA(var_1);
    return var_1;
  }

  return 0;
}

checkcashdvars(var_0, var_1) {
  switch (var_0) {
    case "destroyed_vehicle_motorcycle":
      var_1 = getdvarint("#x3b12b3559cef8ab3", var_1);
      break;
    case "destroyed_vehicle_tank":
      var_1 = getdvarint("#x3b29eb8cd38d96a88", var_1);
      break;
    case "destroyed_vehicle_jeep":
      var_1 = getdvarint("#x33ef25a6b79d977b0", var_1);
      break;
    case "destroyed_vehicle_truck":
      var_1 = getdvarint("#x34f5429cd9fe1dd25", var_1);
      break;
    case "baseDefendKill":
      var_1 = getdvarint("#x3e23570d3c6633560", var_1);
      break;
    case "medal_mode_base_assault_score":
      var_1 = getdvarint("#x368b358d88c8cdc0e", var_1);
      break;
    case "medal_mode_base_secure_score":
      var_1 = getdvarint("#x3745c206f17bc0252", var_1);
      break;
    case "medal_mode_base_secure_assist_score":
      var_1 = getdvarint("#x349ce2b24ed002838", var_1);
      break;
    case "medal_mode_base_secure_neutral_score":
      var_1 = getdvarint("#x3aa92e2306dc581f5", var_1);
      break;
    case "medal_mode_base_secure_neutralilized_score":
      var_1 = getdvarint("#x381c3f704e556e174", var_1);
      break;
    case "kill_crate_carrier":
      var_1 = getdvarint("#x3cc336f339820484a", var_1);
      break;
    case "kill":
      var_1 = getdvarint("#x37ce273a6e8e42cbd", var_1);
      break;
    case "crate_escort_success":
      var_1 = getdvarint("#x35453c46fc7bea901", var_1);
      break;
    case "crate_delivery_success":
      var_1 = getdvarint("#x3ef34ba16f5f7d4a1", var_1);
      break;
    case "crate_picked_up":
      var_1 = getdvarint("#x3132c784b1b0fdcb1", var_1);
      break;
    case "crate_pickup_assist":
      var_1 = getdvarint("#x3d2d692496e9c8d1a", var_1);
      break;
    case "obj_prog_defend":
      var_1 = getdvarint("#x3846ed722ccc1e1b0", var_1);
      break;
  }

  return var_1;
}

modifyvehiclecash(var_0, var_1) {
  if(var_0 <= 0) {
    return var_0;
  }

  var_2 = 1;

  switch (self.vehicle._id_1031E) {
    case "s4_tank":
      var_2 = getdvarfloat("#x3992b68f80a18f9e1", 0.3);
      break;
  }

  switch (var_1) {
    case "kill_crate_carrier":
    case "baseDefendKill":
    case "destroyed_vehicle_motorcycle":
    case "destroyed_vehicle_jeep":
    case "destroyed_vehicle_tank":
    case "kill":
      var_0 = int(var_0 * var_2);
      break;
  }

  return var_0;
}

_id_3517(var_0) {
  if(getdvarint("#x3551c0c650583db54")) {
    return 1;
  }

  if(var_0 > _id_6C45()) {
    return 0;
  } else {
    return 1;
  }
}

_id_6FD0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }
  if(scripts\engine\utility::is_equal(var_0, "kill") && istrue(var_4._id_A72C)) {
    var_0 = "kill_crate_carrier";
  }

  var_7 = undefined;

  if(isDefined(var_4)) {
    var_7 = var_4.team;
  }

  if(isDefined(var_2)) {
    var_8 = var_2;
  } else {
    var_8 = scripts\mp\rank::getscoreinfovalue(var_0);
  }

  var_9 = 1;

  if(isDefined(self.vehicle) && issubstr(var_0, "kill")) {
    var_10 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A6(self.vehicle, self);

    if(var_10 == "driver" || issubstr(var_10, "gunner")) {
      var_9 = 0.5;
    }
  }

  var_8 = var_8 * var_9;
  var_11 = 1;
  _id_1099(var_0, var_8, var_11, var_4);
}

_id_22B5(var_0, var_1) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "dpad_slot_down":
        if(scripts\mp\gametypes\br_public::_id_8805() && var_1 == 0) {
          if(isDefined(level._id_4BD8)) {
            self thread[[level._id_4BD8]](var_0, var_1);
          }

          break;
        }

        thread scripts\mp\gametypes\br_pickups::_id_BEEB(var_1);
        break;
      case "dpad_slot_up":
        scripts\mp\gametypes\br_pickups::_id_FE86(var_1);
        break;
      case "dpad_perk_buy":
        scripts\mp\gametypes\br_perks::_id_2DE4(var_1);
        break;
      case "try_use_heal_slot":
        var_2 = var_1;
        scripts\mp\gametypes\br_pickups::_id_B80C(var_2);
        break;
      case "br_drop_all":
        if(scripts\mp\gametypes\br_public::_id_8805() && var_1 == 0) {
          if(isDefined(level._id_4BD8)) {
            self thread[[level._id_4BD8]](var_0, var_1);
          }

          break;
        }

        scripts\mp\gametypes\br_pickups::_id_BEE4(var_1);
        break;
      default:
        break;
    }
  }
}

_id_A0BD() {
  self notify("armor_monitor_start");
  level endon("game_ended");
  self endon("armor_monitor_start");
  self notifyonplayercommand("weapnext_pressed", "+weapnext");
  self notifyonplayercommand("weapnext_released", "-weapnext");

  for(;;) {
    self waittill("weapnext_pressed");
    var_0 = scripts\engine\utility::_id_108A7(0.5, "weapnext_released");

    switch (var_0) {
      case "weapnext_released":
        break;
      case "timeout":
        scripts\mp\gametypes\br_pickups::_id_B80C(0);
        break;
    }
  }
}

base_support_vehicle_respawning() {
  return 0;
}

monitorplayerpickedupweapons() {
  level endon("game_ended");
  self endon("disconnect");
  self.pickedupweapons = [];
  thread resetplayerpickedupweapons();

  for(;;) {
    self waittill("weapon_pickup", var_0);

    if(isDefined(var_0)) {
      var_1 = getcompleteweaponname(var_0 _meth_8625());
      var_1 = scripts\mp\utility\script::_id_EA63(var_1, "_mp");
      self.pickedupweapons = scripts\engine\utility::array_add(self.pickedupweapons, var_1);
    }
  }
}

resetplayerpickedupweapons() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("death");
    self.pickedupweapons = [];
  }
}

_______________________dlog_functions___() {}

_______________________base_utility_functions___() {}

_id_6E9A() {
  if(!isDefined(level._id_A8E8) || level._id_A8E8.size == 0) {
    return undefined;
  }

  var_0 = getbasearrayoftype(level._id_A8E8, "allies").size;
  var_1 = getbasearrayoftype(level._id_A8E8, "axis").size;

  if(var_1 == var_0) {
    return "tied";
  }

  if(var_1 > var_0) {
    return "axis";
  } else {
    return "allies";
  }
}

getlosingteam() {
  if(!isDefined(level._id_A8E8) || level._id_A8E8.size == 0) {
    return undefined;
  }

  var_0 = getbasearrayoftype(level._id_A8E8, "allies").size;
  var_1 = getbasearrayoftype(level._id_A8E8, "axis").size;

  if(var_1 == var_0) {
    return "tied";
  }

  if(var_1 > var_0) {
    return "allies";
  } else {
    return "axis";
  }
}

getnukespawnersnearbases(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1 = scripts\engine\utility::_id_1B9D(var_1, var_3.nuke_spawn_nodes);
  }

  return var_1;
}

getnukespawnersnearbasesexclusivenotshared(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3.nuke_spawn_nodes) {
      if(var_5.nearby_bases.size == 1) {
        var_1 = scripts\engine\utility::array_add(var_1, var_5);
      }
    }
  }

  return var_1;
}

getnukespawnersequalbetweenopponents(var_0) {
  var_1 = getnukespawnersnearbases(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = 0;
    var_6 = 0;

    foreach(var_8 in var_4.nearby_bases) {
      switch (level._id_A8E8[var_8]._id_ADAE) {
        case "allies":
          var_5++;
          break;
        case "axis":
          var_6++;
          break;
      }
    }

    if(var_5 == var_6) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

getnukespawnerssharedbetweenopponents(var_0) {
  var_1 = getnukespawnersnearbases(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = 0;
    var_6 = 0;

    foreach(var_8 in var_4.nearby_bases) {
      if(isDefined(level._id_A8E8[var_8])) {
        switch (level._id_A8E8[var_8]._id_ADAE) {
          case "allies":
            var_5 = 1;
            break;
          case "axis":
            var_6 = 1;
            break;
        }

        if(var_5 && var_6) {
          var_2 = scripts\engine\utility::array_add(var_2, var_4);
          break;
        }
      }
    }
  }

  return var_2;
}

getnukespawnersnexttoteam(var_0, var_1) {
  var_2 = getnukespawnersnearbases(var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = 0;

    foreach(var_8 in var_5.nearby_bases) {
      if(level._id_A8E8[var_8]._id_ADAE == var_1) {
        var_6 = 1;
        break;
      }
    }

    if(var_6) {
      var_3 = scripts\engine\utility::array_add(var_3, var_5);
    }
  }

  return var_3;
}

getnukespawnersnotnexttoteam(var_0, var_1) {
  var_2 = getnukespawnersnearbases(var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = 0;

    foreach(var_8 in var_5.nearby_bases) {
      if(isDefined(level._id_A8E8[var_8]) && level._id_A8E8[var_8]._id_ADAE == var_1) {
        var_6 = 1;
        break;
      }
    }

    if(!var_6) {
      var_3 = scripts\engine\utility::array_add(var_3, var_5);
    }
  }

  return var_3;
}

getnukespawnsnearmostbases(var_0) {
  var_1 = getnukespawnersnearbases(var_0);
  var_2 = [];
  var_3 = 1;

  foreach(var_5 in var_1) {
    var_6 = 0;

    foreach(var_8 in var_0) {
      if(scripts\engine\utility::array_contains(var_5.nearby_bases, var_8._id_A8E1)) {
        var_6++;
      }
    }

    if(var_6 > var_3) {
      var_3 = var_6;
      var_2 = [var_5];
      continue;
    }

    if(var_6 == var_3) {
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  return var_2;
}

getnukespawnswithoutnukesinfield(var_0) {
  var_1 = [];

  foreach(var_3 in level.nuke_crate_spawns_and_carriers) {
    if(isDefined(var_3._id_03E9)) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  var_5 = [];

  foreach(var_7 in var_0) {
    if(!scripts\engine\utility::array_contains(level.nuke_crate_spawns_and_carriers, var_7) && !scripts\engine\utility::array_contains(var_1, var_7)) {
      var_5 = scripts\engine\utility::_id_1B9D(var_5, [var_7]);
    }
  }

  return var_5;
}

getnukelowestspawnsarray(var_0) {
  var_1 = [];

  if(!isDefined(var_0) || var_0.size == 0) {
    return var_1;
  }

  var_2 = var_0[0].num_spawns;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3].num_spawns == var_2) {
      var_1 = scripts\engine\utility::array_add(var_1, var_0[var_3]);
      continue;
    }

    if(var_0[var_3].num_spawns < var_2) {
      var_1 = [];
      var_1 = scripts\engine\utility::array_add(var_1, var_0[var_3]);
      var_2 = var_0[var_3].num_spawns;
    }
  }

  return var_1;
}

getnukespawnpoisarray(var_0) {
  if(getdvarint("#x3954eef015aa1b185", 1) >= 1) {
    var_1 = [];

    foreach(var_3 in var_0) {
      if(var_3.ispoi) {
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
      }
    }

    return var_1;
  } else
    return var_0;
}

getnukespawnclosertoteambasearray(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = getnearestownedbaseteam(var_4.origin);

    if(isDefined(var_5) && var_5 == var_1) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

getnukespawnerclosesttoplayerscentroid(var_0) {
  var_1 = getcentroidoriginofallplayers();

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = undefined;
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = distance(var_0[var_4].origin, var_1);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_2 = var_5;
      var_3 = var_0[var_4];
    }
  }

  return var_3;
}

getpostnukespawnerbetweenclosestbases() {
  var_0 = getclosestopposingbases();
  var_1 = scripts\engine\utility::random(var_0);
  var_2 = var_1[0].origin;
  var_3 = var_1[1].origin;
  var_4 = getnukelowestspawnsarray(level.postnuke_spawn_nodes);
  var_5 = getnukespawnswithoutnukesinfield(var_4);

  if(var_5.size > 0) {
    var_4 = var_5;
  }

  foreach(var_7 in var_4) {
    var_8 = distance(var_7.origin, var_2);
    var_9 = distance(var_7.origin, var_3);
    var_7.equidistance = abs(var_8 - var_9);
  }

  var_11 = scripts\engine\utility::_id_1BD6(var_4, ::getpostnukespawnerbetweenclosestbases_sort);
  var_12 = [];

  for(var_13 = 0; var_13 < 5; var_13++) {
    if(var_13 >= var_11.size) {
      break;
    }

    var_12[var_13] = var_11[var_13];
  }

  var_14 = getnukespawnpoisarray(var_12);

  if(var_14.size > 0) {
    var_12 = var_14;
  }

  return scripts\engine\utility::random(var_12);
}

getpostnukespawnerbetweenclosestbases_sort(var_0, var_1) {
  return var_0.equidistance < var_1.equidistance;
}

getpostnukespawnerfavorloser() {
  var_0 = getlosingteam();
  var_1 = _id_6E9A();
  var_2 = getbasearrayoftype(level._id_A8E8, var_0);
  var_3 = getbasearrayoftype(level._id_A8E8, var_1);
  var_4 = level.postnuke_spawn_nodes;
  var_5 = getnukespawnswithoutnukesinfield(var_4);

  if(var_5.size > 0) {
    var_4 = var_5;
  }

  foreach(var_7 in scripts\engine\utility::array_combine(var_2, var_3)) {
    foreach(var_9 in var_7.postnuke_spawn_nodes) {
      var_4 = scripts\engine\utility::array_remove(var_4, var_9);
    }
  }

  var_12 = getnukespawnclosertoteambasearray(var_4, var_0);

  if(isDefined(var_12) && var_12.size > 0) {
    var_4 = var_12;
  }

  var_4 = getnukelowestspawnsarray(var_4);
  var_13 = getnukespawnpoisarray(var_4);

  if(var_13.size > 0) {
    var_4 = var_13;
  }

  return scripts\engine\utility::random(var_4);
}

getclosestopposingbases() {
  var_0 = getbasearrayoftype(level._id_A8E8, "allies");
  var_1 = getbasearrayoftype(level._id_A8E8, "axis");
  var_2 = [];
  var_3 = undefined;

  foreach(var_5 in var_0) {
    foreach(var_7 in var_1) {
      var_8 = getbasekeydifference(var_5, var_7);

      if(!isDefined(var_3) || var_8 == var_3) {
        var_9 = [var_5, var_7];
        var_2 = scripts\engine\utility::_id_1B9D(var_2, [var_9]);
        var_3 = var_8;
        continue;
      }

      if(var_8 < var_3) {
        var_9 = [var_5, var_7];
        var_2 = [var_9];
        var_3 = var_8;
      }
    }
  }

  return var_2;
}

getnearestownedbaseteam(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level._id_A8E8) {
    if(var_6._id_ADAE == "allies") {
      var_7 = distance(var_0, var_6.origin);

      if(!isDefined(var_2) || var_7 < var_2) {
        var_1 = var_6;
        var_2 = var_7;
      }

      continue;
    }

    if(var_6._id_ADAE == "axis") {
      var_7 = distance(var_0, var_6.origin);

      if(!isDefined(var_4) || var_7 < var_4) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(!isDefined(var_1) && !isDefined(var_3)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    return "axis";
  }

  if(!isDefined(var_3)) {
    return "allies";
  }

  if(var_2 < var_4) {
    return "allies";
  } else {
    return "axis";
  }
}

getnearestbasetolocoftype(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level._id_A8E8) {
    if(var_5._id_ADAE == var_1) {
      var_6 = distance(var_0, var_5.origin);

      if(!isDefined(var_3) || var_6 < var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}

getbasearrayofunowned(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3._id_ADAE) || var_3._id_ADAE == "neutral") {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

getbasearrayofowned(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_ADAE) && var_3._id_ADAE != "neutral") {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

getbasearrayoftype(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_ADAE) && var_4._id_ADAE == var_1) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

getbasekeydifference(var_0, var_1) {
  var_2 = ["_a", "_b", "_c", "_d", "_e", "_f", "_g"];
  var_3 = scripts\engine\utility::_id_1BAB(var_2, var_0.trigger._id_A90E);
  var_4 = scripts\engine\utility::_id_1BAB(var_2, var_1.trigger._id_A90E);
  return int(abs(var_3 - var_4));
}

base_isadjacent(var_0, var_1) {
  var_2 = getbasekeydifference(var_0, var_1);

  switch (level.mapname) {
    case "mp_ar_alps":
      return var_2 <= 2;
    default:
      return var_2 <= 2;
  }
}

base_isplayerindanger(var_0) {
  if(isDefined(var_0._id_41DA) && var_0._id_41DA.size > 0) {
    return 1;
  }

  foreach(var_2 in getEntArray("enable_danger_flag", "targetname", 1)) {
    if(var_0 istouching(var_2)) {
      return 1;
    }
  }

  foreach(var_5 in var_0._id_F398) {
    if(isDefined(var_5._id_A90E) && isDefined(level._id_A8E8[var_5._id_A90E]) && (!scripts\engine\utility::is_equal(level._id_A8E8[var_5._id_A90E]._id_37F6, "none") && !scripts\engine\utility::is_equal(level._id_A8E8[var_5._id_A90E]._id_37F6, var_0.team))) {
      return 1;
    }
  }

  return 0;
}

base_analytics_validation() {
  if(scripts\mp\utility\game::getgametype() != "base") {
    return 0;
  }

  return 1;
}

base_analytics_capturingbase(var_0) {
  if(!base_analytics_validation()) {
    return;
  }
  var_1 = _id_07EE::_id_6DE4(gettime());
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 istouching(var_0.trigger) && var_5.sessionstate == "playing" && scripts\mp\utility\player::isreallyalive(var_5) && var_5.team != "spectator") {
      if(var_5.team == "axis") {
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
        continue;
      }

      if(var_5.team == "allies") {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  var_7 = [];
  var_7[var_7.size] = "base_id";
  var_7[var_7.size] = var_0.trigger._id_A90E;
  var_7[var_7.size] = "time";
  var_7[var_7.size] = var_1;
  var_7[var_7.size] = "base_owner";
  var_7[var_7.size] = var_0._id_ADAE;
  var_7[var_7.size] = "num_axis_players";
  var_7[var_7.size] = var_2.size;
  var_7[var_7.size] = "num_ally_players";
  var_7[var_7.size] = var_3.size;
  _func_03BF("dlog_event_base_capturingbase", var_7);
}

base_analytics_finishcapturebase(var_0) {
  if(!base_analytics_validation()) {
    return;
  }
  var_1 = _id_07EE::_id_6DE4(gettime());
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 istouching(var_0.trigger) && var_5.sessionstate == "playing" && scripts\mp\utility\player::isreallyalive(var_5) && var_5.team != "spectator") {
      if(var_5.team == "axis") {
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
        continue;
      }

      if(var_5.team == "allies") {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  var_7 = [];
  var_7[var_7.size] = "base_id";
  var_7[var_7.size] = var_0.trigger._id_A90E;
  var_7[var_7.size] = "time";
  var_7[var_7.size] = var_1;
  var_7[var_7.size] = "base_owner";
  var_7[var_7.size] = var_0._id_ADAE;
  var_7[var_7.size] = "num_axis_players";
  var_7[var_7.size] = var_2.size;
  var_7[var_7.size] = "num_ally_players";
  var_7[var_7.size] = var_3.size;
  _func_03BF("dlog_event_base_finishcapturebase", var_7);
}

base_analytics_nukebase(var_0) {
  if(!base_analytics_validation()) {
    return;
  }
  var_1 = _id_07EE::_id_6DE4(gettime());
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 istouching(var_0.trigger) && var_5.sessionstate == "playing" && scripts\mp\utility\player::isreallyalive(var_5) && var_5.team != "spectator") {
      if(var_5.team == "axis") {
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
        continue;
      }

      if(var_5.team == "allies") {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }
  }

  var_7 = [];
  var_7[var_7.size] = "base_id";
  var_7[var_7.size] = var_0.trigger._id_A90E;
  var_7[var_7.size] = "time";
  var_7[var_7.size] = var_1;
  var_7[var_7.size] = "base_owner";
  var_7[var_7.size] = var_0._id_ADAE;
  var_7[var_7.size] = "num_axis_players";
  var_7[var_7.size] = var_2.size;
  var_7[var_7.size] = "num_ally_players";
  var_7[var_7.size] = var_3.size;
  _func_03BF("dlog_event_base_nukedbase", var_7);
}

base_analytics_gameoverstate(var_0) {
  if(!base_analytics_validation()) {
    return;
  }
  var_1 = _id_07EE::_id_6DE4(gettime());
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in level._id_A8E8) {
    switch (var_6._id_ADAE) {
      case "axis":
        var_2++;
        break;
      case "allies":
        var_3++;
        break;
      case "neutral":
        var_4++;
        break;
    }
  }

  var_8 = [];
  var_8[var_8.size] = "winning_team";
  var_8[var_8.size] = var_0;
  var_8[var_8.size] = "time";
  var_8[var_8.size] = var_1;
  var_8[var_8.size] = "prenuke_layout_index";
  var_8[var_8.size] = getdvarint("#x38771cce1c177d002", 0);
  var_8[var_8.size] = "axis_bases";
  var_8[var_8.size] = var_2;
  var_8[var_8.size] = "ally_bases";
  var_8[var_8.size] = var_3;
  var_8[var_8.size] = "neutral_bases";
  var_8[var_8.size] = var_4;
  _func_03BF("dlog_event_base_gameoverstate", var_8);
}

getbasespawnoffsetvalues(var_0, var_1) {
  var_2 = getbasehqtrigger(var_0);
  var_3 = distance(var_2.origin, var_1);

  if(var_0 == "axis") {
    var_4 = level._id_7B23;
  } else {
    var_4 = level._id_7B22;
  }

  return [var_3, var_4];
}

getbasehqtrigger(var_0) {
  if(var_0 == "axis") {
    return getent("gw_fob_axisHQ", "targetname");
  } else {
    return getent("gw_fob_alliesHQ", "targetname");
  }
}