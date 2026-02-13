/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\infil_s4.gsc
*************************************************/

#using_animtree("client_character");

infil_s4_init() {
  setdvarifuninitialized("#x3f0f78c3998dbcaa0", 1);
  setdvarifuninitialized("#x354e86bec4a0580a4", 1);
  setdvarifuninitialized("#x3a1fa189fd329eaad", 1);

  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0) {
    return;
  }
  _id_07D1::_id_60C0("s4_infil_started", 0);
  level.s4_infil_location = _id_0828::_id_6865();
  level.invalidinfilweapons = ["s4_me_rindigo"];

  if(!isDefined(level.s4_infil_location)) {
    return;
  }
  if(!scripts\mp\utility\game::gametypesupportss4infils()) {
    return;
  }
  if(!getdvarint("#x3a08e9b38f4c4fb5", 1)) {
    return;
  }
  level.infil_s4_will_run = 1;
  var_0 = _func_0079(%s4_mp_infil_camera);
  level._id_BBAD = getdvarint("#x3eca1f58470677919", 15);
  level._id_9BAA = var_0 + 2.0;
  level._id_BBAE = var_0 + 2.0;
  thread scripts\mp\gamelogic::_id_9BF2("match_starting_in", level._id_BBAD + level._id_BBAE);
  level.s4_infil_camera = scripts\mp\team_mvp_characters_util::create_client_character_camera(level.s4_infil_location.origin, level.s4_infil_location.angles, 1);
  level thread onplayerspawned();
  level thread run_s4_infil_intro_scene();
}

s4_infil_set_additional_stream_pos(var_0) {
  foreach(var_2 in level.players) {
    var_2 _meth_86A3(var_0, 1);
  }
}

s4_infil_set_additional_stream_spawn() {
  foreach(var_1 in level.players) {
    var_1 _meth_86A3(var_1.origin, 1);
  }
}

s4_infil_clear_additional_stream() {
  foreach(var_1 in level.players) {
    var_1 _meth_86A4();
  }
}

run_s4_infil_intro_scene() {
  level endon("game_ended");
  level waittill("match_start_real_countdown");
  setomnvar("ui_in_infil", 1);
  s4_infil_set_additional_stream_pos(level.s4_infil_location.origin);
  wait 2.0;
  setomnvar("infil_lgt_dvars", 1);
  _id_07D1::_id_60C1("s4_infil_started");
  level thread start_s4_infil();
}

onplayerspawned() {
  level endon("s4_infil_started");

  for(;;) {
    level waittill("player_spawned", var_0);
    thread _id_07F8::aud_infil_start();
    var_0 thread player_join_intro();
  }
}

player_join_intro() {
  var_0 = self;
  var_0.isins4infil = 1;
  var_0 setclientomnvar("ui_wc_anim_type", 2);
  var_0 scripts\common\utility::_id_151F(0);
  var_0 scripts\mp\utility\player::_id_0BEE(1);
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_0, 1, 0.0);
  var_0 scripts\mp\team_mvp_characters_util::attach_player_to_camera_view(level.s4_infil_camera);
  var_0 _meth_8209(0, 0);

  if(isDefined(level.infilvisionset)) {
    visionsetnaked("", 0);
    wait 0.05;
    var_0 visionsetnakedforplayer(level.infilvisionset, 0);
  } else if(isDefined(level._id_10E5E))
    var_0 visionsetnakedforplayer(level._id_10E5E, 0);
  else {
    visionsetnaked("", 0);
  }
}

start_s4_infil(var_0) {
  scripts\engine\utility::_id_57BA("winner_circle_level_vfx");
  level thread scripts\mp\playerlogic::infil_lighting();

  foreach(var_2 in level._id_EF89) {
    level thread start_s4_infil_internal_for_team(var_2);
  }

  level thread scripts\mp\team_mvp_characters_util::_id_C9B1(level.s4_infil_camera, "s4_mp_infil_camera", level.s4_infil_location.origin, level.s4_infil_location.angles);
  s4_infil_clear_additional_stream();
  level.s4_infil_camera wait_for_animation_end();
  level notify("s4_infil_animation_done");
  thread _id_07F8::aud_infil_end();
  setomnvar("infil_lgt_dvars", 0);
  scripts\engine\utility::_id_E893("winner_circle_level_vfx");
}

start_s4_infil_internal_for_team(var_0) {
  if(level.teambased) {
    var_1 = level._id_EF6A[var_0]["players"];
  } else {
    var_1 = level.players;
  }

  level.s4_infil_camera thread _id_0828::_id_C9CF("clientCharacterAnim", var_0, 1);

  if(var_1.size == 0) {
    return;
  }
  foreach(var_6 in var_1) {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_6, 0, 0.3);
  }

  var_8 = var_1.size;

  if(var_8 > 6) {
    var_8 = 6;
  }

  var_9 = [];
  var_10 = [];
  scripts\mp\s4_client_characters_util::setup_client_characters(var_0, "infil");

  for(var_11 = 0; var_11 < var_8; var_11++) {
    scripts\mp\s4_client_characters_util::increment_client_character_num_for_team(var_0, "infil");
    var_3 = spawn("script_character", level.s4_infil_location.origin, 0, 0, scripts\mp\s4_client_characters_util::get_client_character_num_for_team(var_0, "infil"), "MPClientCharacter");
    var_3.angles = level.s4_infil_location.angles;

    foreach(var_6 in level.players) {
      if(!scripts\engine\utility::is_equal(var_0, var_6.pers["team"])) {
        var_3 hidefromplayer(var_6);
      }
    }

    var_6 = var_1[var_11];
    var_14 = var_6 get_weapon_for_infil();
    var_15 = var_11 + 1;
    var_16 = "_gun";

    if(scripts\engine\utility::array_contains(level.invalidinfilweapons, var_14) || issubstr(var_14, "s4_me_rindigo") || scripts\mp\utility\game::getgametype() == "gun") {
      var_16 = "_no_gun";
    }

    var_17 = var_3 scripts\mp\team_mvp_characters_util::run_delta_motion_on_client_character("s4_mp_infil_guy_0" + var_15 + var_16, level.s4_infil_location.origin, level.s4_infil_location.angles);
    var_3._id_0460 = var_17;
    var_9[var_9.size] = var_3;
    var_10[var_10.size] = var_1[var_11];
  }

  foreach(var_6 in var_1) {
    var_19 = get_character_array_player_centered(var_10, var_6);
    var_20 = get_infilcharacterarray(var_19, scripts\mp\s4_client_characters_util::get_client_character_num_for_team(var_0, "infil"));
    _func_033B(var_6 getentitynumber(), var_20);
  }

  level waittill("s4_infil_animation_done");

  if(level.teambased) {
    var_1 = level._id_EF6A[var_0]["players"];
  } else {
    var_1 = level.players;
  }

  foreach(var_6 in var_1) {
    if(!istrue(var_6.isins4infil)) {
      continue;
    }
    var_6 _meth_8060();
    var_6 visionsetnakedforplayer("", 0.2);
    var_6 _meth_8209(1, 0.2);
    var_6 _meth_865E();

    if(!var_6 scripts\common\utility::_id_8544()) {
      var_6 scripts\common\utility::_id_151F(1);
    }

    var_6 scripts\mp\utility\player::_id_0BEE(0, 1);
    var_6.isins4infil = 0;
  }

  foreach(var_3 in var_9) {
    var_3._id_0460 delete();
    var_3 delete();
  }
}

get_weapon_for_infil() {
  var_0 = self;
  var_1 = var_0._id_90CB;
  var_2 = getcompleteweaponname(var_1 _meth_8625());
  var_2 = scripts\mp\utility\script::_id_EA63(var_2, "_mp");
  return var_2;
}

get_character_array_player_centered(var_0, var_1) {
  var_2 = [];
  var_2[0] = var_1;

  foreach(var_4 in var_0) {
    if(scripts\engine\utility::is_equal(var_1, var_4)) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(var_2.size > 6) {
    var_2 = scripts\engine\utility::_id_1BD4(var_2, 0, 6);
  }

  return var_2;
}

wait_for_animation_end() {
  var_0 = self;

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    var_1 = 0;
    var_0 waittill("clientCharacterAnim", var_2);

    if(!_func_0107(var_2)) {
      var_2 = [var_2];
    }

    foreach(var_4 in var_2) {
      if(scripts\engine\utility::is_equal(var_4, "end")) {
        var_1 = 1;
        break;
      }
    }

    if(var_1) {
      break;
    }
  }
}

infil_stripvariantid(var_0) {
  var_1 = strtok(var_0, "_");

  if(!_func_010D(var_1[var_1.size - 1], "v")) {
    return var_0;
  }

  var_2 = var_1[0];

  for(var_3 = 1; var_3 < var_1.size - 1; var_3++) {
    var_2 = var_2 + "_" + var_1[var_3];
  }

  return var_2;
}

infil_getbaseattachmenttoidmap(var_0) {
  var_1 = [];

  foreach(var_5, var_3 in var_0) {
    var_4 = scripts\mp\utility\weapon::_id_1DA5(var_5);

    if(var_4 == "rec" || issubstr(var_4, "selectsemi")) {
      continue;
    }
    var_1[var_4] = var_0[var_5];
  }

  return var_1;
}

get_infilcharacterarray(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = "none";
    var_6 = ["none", "none", "none", "none"];
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;

    if(isDefined(var_4._id_90CB)) {
      var_10 = getcompleteweaponname(var_4._id_90CB _meth_8625());
      var_10 = scripts\mp\utility\script::_id_EA63(infil_stripvariantid(var_10), "_mp");
      var_11 = getweaponattachments(var_4._id_90CB);

      if(getdvarint("#x354e86bec4a0580a4") == 1) {
        var_7 = var_4._id_90CB._id_04CC;

        if(getdvarint("#x3a1fa189fd329eaad") == 1) {
          var_9 = infil_getbaseattachmenttoidmap(var_4._id_90CB._id_0071);
        }
      }

      if(getdvarint("#x3f0f78c3998dbcaa0") == 1) {
        var_5 = var_4._id_90CB._id_00D2;
        var_6 = [var_4._id_90CB._id_0409, var_4._id_90CB._id_040A, var_4._id_90CB._id_040B, var_4._id_90CB._id_040C];
        var_8 = var_4._id_90CB._id_04ED;
      }
    } else {
      var_10 = scripts\mp\utility\script::_id_EA63("s4_pi_mike1911_mp", "_mp");
      var_11 = [];
    }

    var_12 = undefined;

    if(isDefined(var_7) && var_7 != 0) {
      var_12 = scripts\mp\class::_id_2D15(var_10, var_9, var_5, "none", var_7, var_8, var_6, undefined);
    } else {
      var_12 = scripts\mp\class::buildweapon(var_10, var_11, var_5, "none", var_7, undefined, var_8, var_6, undefined);
    }

    var_13 = getcompleteweaponname(var_12);
    var_14 = spawnStruct();
    [var_14._id_009D, var_14._id_0218] = _id_081E::get_indicies_from_customization(var_4._id_AC3D);
    var_14._id_04FE = var_13;
    var_14._id_00E7 = var_4 _meth_8587();
    var_14.name = var_4.name;
    var_14._id_0509 = var_4 getxuid();
    var_14._id_39A3 = var_4 getentitynumber();
    var_14._id_B991 = var_2.size;
    var_14._id_00E9 = var_1;
    var_2[var_2.size] = var_14;
  }

  return var_2;
}