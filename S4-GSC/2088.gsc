/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2088.gsc
*************************************************/

init() {
  level._id_A2AD = 1;
  level.top_players = [];
  level.top_players["axis"] = [];
  level.top_players["allies"] = [];
  register_mvp_weapons_from_table();
  level.postmatchflowweapons["s4_ks_remote_goliath_mp"] = ["s4_ks_remote_goliath_mp"];

  if(getdvarint("#x312d49106d8ba6b77", 0)) {
    scripts\engine\utility::delaythread(1, scripts\mp\team_mvp_characters_util::file_print_generate_animation_data_function);
  }

  level._id_60B7 = _id_6865();

  if(should_disable_winner_circle()) {
    level._id_A2AD = 0;
  }

  scripts\mp\team_mvp_characters_util::_id_C1C9();
  level.mp_winner_circle_operator_animation = [];
  level._id_2022 = getdvarint("#x3e6ac3185ffce4205", 0) != 0;
}

register_mvp_weapons_from_table() {
  var_0 = "postMatchFlowAnimations.csv";
  var_1 = "postMatchFlowAnimationsIntros.csv";
  level.postmatchflowweapons = [];

  foreach(var_3 in [var_0, var_1]) {
    var_4 = tablelookupgetnumrows(var_3);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      foreach(var_7 in [7, 9]) {
        var_8 = tablelookupbyrow(var_3, var_5, var_7);

        if(!isDefined(level.postmatchflowweapons[var_8]) && issubstr(var_8, "s4_execution")) {
          level.postmatchflowweapons[var_8] = var_8;
        }
      }
    }
  }
}

should_disable_winner_circle() {
  if(!isDefined(level._id_60B7)) {
    return 1;
  }

  if(!getdvarint("#x367cf740082006fbd", 1)) {
    return 1;
  }

  if(getdvarint("#x3af4635af5e253c51", 0)) {
    return 1;
  }

  if(!scripts\mp\utility\game::_id_60F9()) {
    return 1;
  }

  var_0 = 1;

  if(var_0 && (scripts\mp\utility\game::privatematch() || !level.onlinegame)) {
    return 1;
  }

  if(level.splitscreen) {
    return 1;
  }

  return 0;
}

preload_weapon_internal(var_0, var_1) {
  if(isDefined(var_0) && var_0 != "none") {
    if(!scripts\engine\utility::_id_1BA1(level.post_match_flow_weapons[var_1], var_0)) {
      if(!isDefined(level.post_match_flow_weapon_link_ent)) {
        level.post_match_flow_weapon_link_ent = spawn("script_model", level._id_60B7.origin);
        level.post_match_flow_weapon_link_ent setModel("tag_origin");
      }

      var_2 = spawn_winner_circle_weapon(var_0);

      if(getdvarint("#x364c7a4b1b4ad2fca", 1) && !istrue(level.winner_circle_first_weapon_spawned)) {
        level.winner_circle_first_weapon_spawned = 1;
        var_2 = spawn_winner_circle_weapon(var_0);
        level.post_match_flow_weapons[var_1][var_0] = var_2;
      }

      level.post_match_flow_weapons[var_1][var_0] = var_2;
    }
  }
}

spawn_winner_circle_weapon(var_0) {
  var_1 = spawn("weapon_" + var_0, level._id_60B7.origin);
  var_1 hide(1);
  var_1 linkto(level.post_match_flow_weapon_link_ent);
}

have_preloaded_weapons(var_0) {
  if(!isDefined(level.post_match_flow_weapons)) {
    return 0;
  }

  if(!isDefined(level.post_match_flow_weapons[var_0])) {
    return 0;
  }

  return level.post_match_flow_weapons[var_0].size != 0;
}

have_preloaded_weapon(var_0, var_1) {
  return isDefined(level.post_match_flow_weapons) && isDefined(level.post_match_flow_weapons[var_0]) && scripts\engine\utility::_id_1BA1(level.post_match_flow_weapons[var_0], var_1);
}

preload_weapons(var_0, var_1) {
  level.mp_winner_circle_operator_animation[var_0] = [];
  var_2 = [];

  if(var_0 == "teamMVP") {
    var_2 = get_preload_winner_circle_weapons_mvp();
  } else {
    if(isDefined(level.forcepotgplayer)) {
      var_1 = level.forcepotgplayer;
    }

    var_3 = var_1 get_mvp_highlight_animation_data();
    var_2 = _id_081E::get_client_character_scene_mvp_weapons("pom", var_1.pers["team"], var_3);
  }

  if(!isDefined(level.post_match_flow_weapons)) {
    level.post_match_flow_weapons = [];
  }

  if(!isDefined(level.post_match_flow_weapons[var_0])) {
    level.post_match_flow_weapons[var_0] = [];
  }

  foreach(var_5 in var_2) {
    preload_weapon_internal(var_5, var_0);
  }
}

preload_non_transient_operator(var_0) {
  if(!getdvarint("#x34ee8cd8be00cb440", 1)) {
    return;
  }
  var_1 = _id_081E::get_models_for_skin(var_0);

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", (0, 0, 0));
    var_4 setModel(var_3);
    var_4 hide(1);
  }
}

get_list_of_models_used_during_pmf(var_0, var_1) {
  var_2 = [];

  if(getDvar(_id_081E::debuggetoperatoroverridedvarname(var_0), "") != "") {
    var_3 = getDvar(_id_081E::debuggetoperatoroverridedvarname(var_0), "");
    var_2 = _id_081E::get_models_for_skin(var_3);

    if(var_0 == "teamMVP") {
      var_4 = var_1[0] get_fatality_animation_data();
      var_5 = _id_081E::get_models_for_skin(var_4[10]);
      var_2 = scripts\engine\utility::array_add(var_2, var_5[0]);
      var_2 = scripts\engine\utility::array_add(var_2, var_5[1]);
    }
  } else {
    foreach(var_7 in var_1) {
      var_2 = scripts\engine\utility::array_add(var_2, var_7._id_AC3D._id_75DA);
      var_2 = scripts\engine\utility::array_add(var_2, var_7._id_AC3D._id_25CA);

      if(var_0 == "teamMVP") {
        var_4 = var_7 get_fatality_animation_data();
        var_5 = _id_081E::get_models_for_skin(var_4[10]);
        var_2 = scripts\engine\utility::array_add(var_2, var_5[0]);
        var_2 = scripts\engine\utility::array_add(var_2, var_5[1]);
      }
    }
  }

  return var_2;
}

preload_transient_models(var_0, var_1) {
  var_2 = level._id_EF89;

  if(isDefined(var_1)) {
    var_2 = [var_1];
  }

  foreach(var_1 in var_2) {
    if(!isDefined(level._id_EF6A[var_1]["loadedTransientModels"])) {
      level._id_EF6A[var_1]["loadedTransientModels"] = [];
    }

    foreach(var_5 in var_0) {
      if(!istrue(level._id_EF6A[var_1]["loadedTransientModels"][var_5])) {
        foreach(var_7 in level._id_EF6A[var_1]["players"]) {
          var_7 _meth_886F(var_5);
        }

        level._id_EF6A[var_1]["loadedTransientModels"][var_5] = 1;
      }
    }
  }
}

unload_transient_models(var_0, var_1) {
  var_2 = level._id_EF89;

  if(isDefined(var_1)) {
    var_2 = [var_1];
  }

  foreach(var_1 in var_2) {
    foreach(var_5 in var_0) {
      if(!isDefined(level._id_EF6A[var_1]["loadedTransientModels"])) {
        break;
      }

      if(istrue(level._id_EF6A[var_1]["loadedTransientModels"][var_5])) {
        foreach(var_7 in level._id_EF6A[var_1]["players"]) {
          var_7 _meth_8870(var_5);
        }

        level._id_EF6A[var_1]["loadedTransientModels"][var_5] = 0;
      }
    }
  }
}

cleanup_preloaded_weapons(var_0) {
  if(!isDefined(level.post_match_flow_weapons)) {
    return;
  }
  if(!isDefined(level.post_match_flow_weapons[var_0])) {
    return;
  }
  var_1 = level.post_match_flow_weapons[var_0];

  foreach(var_3 in var_1) {
    if(!_func_0458(var_3)) {
      var_3 delete();
    }
  }

  level.post_match_flow_weapons[var_0] = [];
  level.mp_winner_circle_operator_animation[var_0] = [];
}

_id_D80D(var_0) {
  level._id_BA35 = var_0;
  thread _id_07F8::matchpostflow();
  var_1 = level._id_60B7.angles;
  _id_806D("podium", level._id_60B7, var_1, 2, 90, 1);
  _id_806D("operator", level._id_60B7, var_1, 2, 50, 1);
  _id_806D("player", level._id_60B7, var_1, 2, 50, 1);
}

_id_C9EE(var_0) {
  thread _id_0829::_id_9487();
  level thread scripts\mp\playerlogic::wc_lighting();

  if(!istrue(level.ran_winner_circle_intro_fx)) {
    level.ran_winner_circle_intro_fx = 1;
    scripts\engine\utility::_id_57BA("winner_circle_level_vfx");
  }

  foreach(var_2 in level.players) {
    var_2 playerhide();
    var_2 _id_10E57("operator", 1);
    var_2 _meth_8209(0.0, 0.2);
  }

  var_4 = var_0 get_mvp_highlight_animation_data();

  foreach(var_6 in level._id_EF89) {
    level thread _id_081E::_id_C9B6("pom", var_6, var_4, var_0);
  }

  level scripts\engine\utility::_id_108A8(10, "pom_stopanim", "team_mvp_pom_continue");
  _id_44E1();

  foreach(var_2 in level.players) {
    var_2 _meth_865E();
  }

  foreach(var_2 in level.players) {
    var_2 _meth_8060();
  }

  cleanup_preloaded_weapons("pom");
}

get_mvp_highlight_animation_data() {
  var_0 = get_operator_specific_animation("pom", self);
  return var_0;
}

get_fatality_animation_data() {
  var_0 = get_operator_specific_animation("teamMVP", self);
  return var_0;
}

get_operator_specific_animation(var_0, var_1) {
  if(!isDefined(level.mp_winner_circle_operator_animation[var_0])) {
    level.mp_winner_circle_operator_animation[var_0] = [];
  }

  if(scripts\engine\utility::_id_1BA1(level.mp_winner_circle_operator_animation[var_0], var_1.guid)) {
    return level.mp_winner_circle_operator_animation[var_0][var_1.guid];
  }

  var_2 = var_1._id_AC3D._id_AC41;

  if(_id_081E::debuggetoperatoroverridedvarname(var_0) != "") {
    var_2 = strtok(_id_081E::debuggetoperatoroverridedvarname(var_0), "_")[0];
  }

  var_3 = var_1 _id_635E(var_0);
  level.mp_winner_circle_operator_animation[var_0][var_1.guid] = var_3;
  return var_3;
}

_id_C9CF(var_0, var_1, var_2) {
  self notify("run_funcs_on_anim_notetracks");
  self endon("run_funcs_on_anim_notetracks");
  self endon("entitydeleted");

  foreach(var_4 in level.players) {
    var_4 _meth_865D();
  }

  var_6 = 1;

  for(;;) {
    self waittill(var_0, var_7);

    if(!_func_0107(var_7)) {
      var_7 = [var_7];
    }

    foreach(var_9 in var_7) {
      if(issubstr(var_9, "slow_")) {
        if(!getdvarint("#x387fafb37a525b0c2", 1)) {
          continue;
        }
        var_10 = strtok(var_9, "_");
        var_11 = var_10[0];
        var_12 = var_10[1];

        if(scripts\engine\utility::is_equal(var_12, "stopanim")) {
          level notify("pom_stopanim");
          _func_01F0(1, 1, 0);
          return;
        }

        var_13 = var_10[2];
        _func_01F0(var_6, int(var_12) / 100, float(var_13) / 1000);
        wait(float(var_13) / 1000);
        var_6 = int(var_12);
      }

      if(issubstr(var_9, "dof")) {
        var_10 = strtok(var_9, "_");
        var_11 = var_10[0];
        var_14 = float(var_10[1]);
        var_15 = float(var_10[2]);
        var_16 = 1.0;

        if(isDefined(var_10[3])) {
          var_16 = float(var_10[3]);
        }

        var_17 = 2.0;

        if(isDefined(var_10[4])) {
          var_17 = float(var_10[4]);
        }

        var_18 = undefined;

        if(isDefined(var_1)) {
          var_19 = level._id_EF6A[var_1]["players"];
        } else {
          var_19 = level.players;
        }

        foreach(var_4 in var_19) {
          if(istrue(var_2) && !istrue(var_4.isins4infil)) {
            continue;
          }
          var_4 _meth_8660(var_14, var_15, var_16, var_17);
        }
      }
    }
  }
}

_id_C5AA() {
  _func_01F0(1, 1, 0);

  foreach(var_1 in level.players) {
    var_1 _meth_865E();
    waitframe();
    var_1 _meth_865D();
  }
}

_id_44B6(var_0, var_1) {
  for(;;) {
    level thread scripts\engine\utility::_id_4EED(var_0, var_0 + 32 * vectornormalize(anglesToForward(var_1)), (1, 1, 1));
    waitframe();
  }
}

_id_6865() {
  var_0 = scripts\engine\utility::getstructarray("solo_featured", "script_noteworthy");

  if(var_0.size > 0) {
    return var_0[0];
  }

  var_1 = scripts\engine\utility::array_combine(scripts\engine\utility::getstructarray("solo_featured", "script_noteworthy"), scripts\engine\utility::getstructarray("group_featured", "script_noteworthy"));

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3._id_CD99, "characters_3_middle")) {
      return var_3;
    }
  }
}

_id_806D(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_BA33)) {
    level._id_BA33 = [];
  }

  if(!isDefined(level._id_BA33[var_0])) {
    level._id_BA33[var_0] = [];
  }

  foreach(var_7 in level._id_EF89) {
    level._id_BA33[var_0][var_7] = ::scripts\mp\team_mvp_characters_util::create_client_character_camera(var_1.origin, var_2, var_5);
  }
}

_id_63B1(var_0, var_1) {
  return level._id_BA33[var_0][var_1].origin;
}

_id_63AD(var_0, var_1) {
  if(!isDefined(level._id_BA33[var_0][var_1].angles)) {
    return (0, 0, 0);
  }

  return level._id_BA33[var_0][var_1].angles;
}

_id_10E57(var_0, var_1) {
  var_2 = self;
  var_3 = var_2.pers["team"];

  if(isDefined(level._id_10E55)) {
    var_3 = level._id_10E55;
  }

  if(!isDefined(level._id_BA33)) {
    return;
  }
  var_4 = level._id_BA33[var_0][var_3];
  var_2 scripts\mp\team_mvp_characters_util::attach_player_to_camera_view(var_4);
}

set_additional_stream_pos() {
  var_0 = level._id_60B7.origin + (0, 0, 500);

  foreach(var_2 in level.players) {
    var_2 _meth_86A3(var_0, 1);
  }
}

cleanup_additional_stream_pos() {
  foreach(var_1 in level.players) {
    var_1 _meth_86A4();
  }
}

_id_44E1() {
  if(level._id_2022) {
    while(getdvarint("#x3e6ac3185ffce4205", 0) != 0) {
      waitframe();
    }

    iprintlnbold("RESUME ANIMATION!");
    setDvar("#x3e6ac3185ffce4205", 1);
    setdynamicdvar("#x3e6ac3185ffce4205", 1);
  }

  _id_C5AA();
  level notify("pom_resume_from_freeze_frame");
}

_id_86DC() {
  return istrue(level._id_A2AD);
}

_id_C9ED(var_0) {
  if(!scripts\mp\utility\game::_id_10A16() && getdvarint("#x3b2b5cc3df72bc4b8", 1)) {
    return;
  }
  var_1 = get_list_of_models_used_during_pmf("pom", [var_0]);
  preload_transient_models(var_1);

  if(_id_86DC()) {
    preload_non_transient_operator("ger_lmg");
  }

  if(!have_preloaded_weapons("pom")) {
    preload_weapons("pom", var_0);
  }

  _id_C9EE(var_0);
  unload_transient_models(var_1);
}

_id_D841(var_0, var_1) {
  level.top_players[var_0] = [];

  foreach(var_4, var_3 in var_1) {
    if(var_4 >= 3) {
      break;
    }

    level.top_players[var_0] = ::scripts\engine\utility::array_add(level.top_players[var_0], var_3);
  }
}

get_num_winner_circle_spots() {
  return 3;
}

winner_circle_thread(var_0, var_1, var_2, var_3) {
  var_4 = "teamMVP";
  var_5 = [];
  var_6 = [];

  if(!istrue(level.debug_team_mvp_run_all_animations)) {
    var_5 = get_list_of_models_used_during_pmf(var_4, var_1);
    preload_transient_models(var_5, var_3);
  }

  for(var_7 = 0; var_7 < var_0; var_7++) {
    var_8 = var_7;
    var_12 = var_1[var_8];

    if(var_4 == "teamMVP") {
      var_13 = var_12 get_fatality_animation_data();
    } else {
      var_13 = var_12 get_mvp_highlight_animation_data();
    }

    _id_081E::_id_C9B6(var_4, var_3, var_13, var_12, var_8, var_1.size);
  }

  unload_transient_models(var_5);
}

get_preload_winner_circle_weapons_mvp() {
  var_0 = [];

  foreach(var_2 in level._id_EF89) {
    var_3 = mvp_get_top_players_for_team(var_2);

    if(!isDefined(var_3) || var_3.size == 0) {
      continue;
    }
    var_4 = int(var_3.size);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = var_5;
      var_7 = var_3[var_6];
      var_8 = var_7 get_fatality_animation_data();
      var_9 = _id_081E::get_client_character_scene_mvp_weapons("teamMVP", var_2, var_8);

      foreach(var_11 in var_9) {
        var_0 = scripts\engine\utility::array_add(var_0, var_11);
      }
    }
  }

  return var_0;
}

_id_CA1B() {
  if(!istrue(level.ran_winner_circle_intro_fx)) {
    level.ran_winner_circle_intro_fx = 1;
    scripts\engine\utility::_id_57BA("winner_circle_level_vfx");
  }

  thread _id_0829::_id_9488();

  foreach(var_1 in level.players) {
    var_1 playerhide();
  }

  var_3 = scripts\mp\utility\game::_id_875D();
  var_4 = undefined;
  var_5 = undefined;
  var_6 = [];
  var_7 = -2;
  var_8 = 0;
  var_9 = [];

  foreach(var_11 in level._id_EF89) {
    var_12 = mvp_get_top_players_for_team(var_11);

    if(!isDefined(var_12) || var_12.size == 0) {
      continue;
    }
    var_14 = int(var_12.size);
    var_15 = _id_6865();
    var_5 = var_15.origin;
    var_4 = var_15.angles + (0, 90, 0);
    var_16 = ["left", "middle", "right"];
    var_8 = 0;
    thread winner_circle_thread(var_14, var_12, var_16, var_11);

    for(var_13 = 0; var_13 < var_14; var_13++) {
      var_17 = var_13;
      var_18 = var_16[var_17];
      var_19 = "ui_wc_winner_order_" + var_17;
      var_20 = _id_66B3(var_18);
      var_21 = var_12[var_17];
      var_22 = var_21 get_fatality_animation_data();
      var_23 = scripts\mp\team_mvp_characters_util::_id_6354(var_22[0]);
      var_8 = var_8 + var_23;

      if(level._id_2022) {
        level waittill("pom_resume_from_freeze_frame");
      }

      if(var_3) {
        var_9[var_19] = var_20;
        continue;
      }

      foreach(var_1 in level._id_EF6A[var_11]["players"]) {
        var_1 setclientomnvar(var_19, var_20);
      }
    }

    if(var_3) {
      foreach(var_1 in level.players) {
        for(var_13 = 0; var_13 < _id_07A7::_id_6591(); var_13++) {
          var_19 = "ui_wc_winner_order_" + var_13;

          if(isDefined(var_9[var_19])) {
            var_1 setclientomnvar(var_19, var_9[var_19]);
            continue;
          }

          var_1 setclientomnvar(var_19, 0);
        }
      }
    }

    foreach(var_1 in level._id_EF6A[var_11]["players"]) {
      var_29 = int(min(var_8 * 1000, 99999));
      var_1 setclientomnvar("ui_wc_anim_length", var_29);
    }

    scripts\engine\utility::delaythread(var_8, ::_id_A691, var_11);
  }
}

mvp_get_top_players_for_team(var_0) {
  if(!isDefined(level.top_players[var_0])) {
    return [];
  }

  return level.top_players[var_0];
}

_id_D18A(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = spawnStruct();
    var_5._id_009D = var_4 _meth_812A();
    var_5._id_0218 = var_4 _meth_812B();
    var_5._id_00E9 = 0;
    var_5._id_04FE = var_4 getcurrentweapon();
    var_5._id_00E7 = var_4 _meth_8587();
    var_5.name = var_4.name;
    var_5._id_0509 = var_4 getxuid();
    var_5._id_39A3 = var_4 getentitynumber();
    var_5._id_B991 = var_2.size;
    var_2[var_2.size] = var_5;
  }

  _func_033B(var_1 getentitynumber(), var_2);
}

_id_A691(var_0) {
  level notify("team_mvp_final_pose_start_" + var_0);
}

_id_ED9B(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level._id_EF6A[var_0]["players"]) {
    var_5 _meth_8856(var_2, var_3);
    var_5 playlocalsound("ui_mp_splash_mvp_highlight_blade");
    var_5 setclientomnvar("ui_wc_screenshot", var_1);
  }
}

_id_635E(var_0) {
  var_1 = [];
  var_2 = getDvar("#x383f02feb4ee89bcc", "");
  var_3 = getDvar("#x32a3ff8f4d4d0588e", "");

  if(scripts\engine\utility::is_equal(var_0, "pom")) {
    var_4 = "postMatchFlowAnimationsIntros.csv";
    var_5 = self._id_AC3D.pomintro;

    if(var_3 != "") {
      var_5 = var_3;
    }
  } else {
    var_4 = "postMatchFlowAnimations.csv";
    var_5 = self._id_AC3D.highlight;

    if(var_2 != "") {
      var_5 = var_2;
    }
  }

  var_1 = get_pmf_data_row(var_4, var_5);
  return var_1;
}

get_pmf_data_row(var_0, var_1) {
  var_2 = [];
  var_2[0] = _func_0222(var_0, 0, var_1, 0);
  var_2[1] = _func_0222(var_0, 0, var_1, 1);
  var_2[2] = _func_0222(var_0, 0, var_1, 2);
  var_2[3] = _func_0222(var_0, 0, var_1, 3);
  var_2[4] = _func_0222(var_0, 0, var_1, 4);
  var_2[5] = _func_0222(var_0, 0, var_1, 5);
  var_2[6] = _func_0222(var_0, 0, var_1, 6);
  var_2[7] = _func_0222(var_0, 0, var_1, 7);
  var_2[8] = _func_0222(var_0, 0, var_1, 8);
  var_2[9] = _func_0222(var_0, 0, var_1, 9);
  var_2[10] = _func_0222(var_0, 0, var_1, 10);
  var_2[11] = _func_0222(var_0, 0, var_1, 11);
  var_2[12] = _func_0222(var_0, 0, var_1, 12);
  var_2[13] = _func_0222(var_0, 0, var_1, 13);
  var_2[14] = _func_0222(var_0, 0, var_1, 14);
  var_2[15] = _func_0222(var_0, 0, var_1, 15);
  var_2[16] = _func_0222(var_0, 0, var_1, 16);
  var_2[17] = _func_0222(var_0, 0, var_1, 17);
  var_2[18] = _func_0222(var_0, 0, var_1, 18);
  var_2[19] = _func_0222(var_0, 0, var_1, 19);
  var_2[20] = _func_0222(var_0, 0, var_1, 20);
  var_2[21] = tablelookuprownum(var_0, 0, var_1);
  return var_2;
}

_id_66B3(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "left":
      var_1 = 1;
      break;
    case "right":
      var_1 = 3;
      break;
    case "middle":
      var_1 = 2;
      break;
  }

  return var_1;
}

_id_C9CB(var_0) {
  foreach(var_2 in level.players) {
    var_2 scripts\mp\utility\player::_id_FD26("playing");
    var_2 _meth_8577("winnercircle");
  }

  wait(var_0);

  foreach(var_2 in level.players) {
    var_2 _meth_8577("winnercircle40");
  }
}

_id_10E56(var_0, var_1) {
  wait(var_0);
  var_2 = 0.5;

  foreach(var_4 in level.players) {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_4, 1, var_2);
  }

  wait 1;

  foreach(var_4 in level.players) {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_4, 0, var_2);
  }
}

_id_B31A(var_0) {
  wait(var_0);

  foreach(var_2 in level.players) {
    var_2 playsoundtoplayer("mp_cmd_camera_zoom_in", var_2);
  }
}

_id_DC61(var_0) {
  var_0 _id_10E57("podium");
}

_id_DC5D(var_0) {
  var_0 _id_10E57("podium");
}

get_default_fatality_ref() {
  return "fatality_generic_pistol_01";
}

get_default_pom_intro() {
  return "pom_generic_01";
}