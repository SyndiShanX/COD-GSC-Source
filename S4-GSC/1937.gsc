/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1937.gsc
*************************************************/

_id_5FD8(var_0, var_1) {
  level._id_2FF9 = spawn("script_model", var_0);
  level._id_2FF9 setModel("tag_origin");
  level._id_2FF9.angles = var_1;
}

_id_5FDA(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self cameralinkto(level._id_2FF9, "tag_origin");
  level._id_0F2C = _func_032B();
  [[var_0]](level._id_0F2C);
  waitframe();

  for(;;) {
    var_1 = _func_032B();

    if(var_1.name == level._id_0F2C.name && var_1.index == level._id_0F2C.index) {
      if(level._id_0F2C.name == getDvar("#x3d0538ecf9605f053")) {
        _func_039C();
      }

      waitframe();
      continue;
    }

    level._id_0F2C = var_1;
    [[var_0]](var_1);
  }
}

_id_3079(var_0) {
  if(var_0.name == "") {
    return;
  }
  var_1 = _id_6744(var_0);

  if(!isDefined(var_1["scene"]) || !isDefined(var_1["camera"])) {
    return;
  }
  _id_D130(var_1["scene"], var_1["camera"]);
  _id_56E7(var_0, level._id_41ED);
  level._id_41ED = var_0.name;
}

_id_D130(var_0, var_1) {
  level._id_0F2A = var_0;
  level._id_0F19 = var_1;
}

_id_56E7(var_0, var_1) {
  var_2 = !isDefined(level._id_0F2A) || level._id_F48A;

  if(var_2) {
    thread _id_5FD9(level._id_0F19, level._id_0F2A._id_A370, level._id_0F2A._id_3713, 0, 0.2, ::_id_FB67);
  }

  var_3 = level._id_F491;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = undefined;
  var_15 = undefined;

  if(isDefined(var_3[var_0.name])) {
    var_16 = var_3[var_0.name];
    var_17 = var_16["default"];

    if(isDefined(var_1) && isDefined(var_16[var_1])) {
      var_6 = var_16[var_1]["callback"];
      var_5 = var_16[var_1]["fov"];
      var_4 = var_16[var_1]["speed"];
      var_8 = var_16[var_1]["fadeOutTime"];
      var_9 = var_16[var_1]["fadeInTime"];
      var_10 = var_16[var_1]["cinematicName"];
      var_11 = var_16[var_1]["accelScalar"];
      var_12 = var_16[var_1]["decelScalar"];
      var_13 = var_16[var_1]["moveTime"];
      var_14 = var_16[var_1]["use_bounce"];
      var_15 = var_16[var_1]["lighting_change"];

      if(isDefined(var_16[var_1]["transition"])) {
        var_7 = var_16[var_1]["transition"];
      }
    }

    var_6 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, var_17["callback"]);

    if(!isDefined(var_7)) {
      var_7 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, var_17["transition"]);
      var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, var_17["fov"]);
      var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, var_17["speed"]);
      var_8 = scripts\engine\utility::ter_op(isDefined(var_8), var_6, var_17["fadeOutTime"]);
      var_9 = scripts\engine\utility::ter_op(isDefined(var_9), var_5, var_17["fadeInTime"]);
      var_10 = scripts\engine\utility::ter_op(isDefined(var_10), var_10, var_17["cinematicName"]);
      var_11 = scripts\engine\utility::ter_op(isDefined(var_11), var_11, var_17["accelScalar"]);
      var_12 = scripts\engine\utility::ter_op(isDefined(var_12), var_12, var_17["decelScalar"]);
      var_13 = scripts\engine\utility::ter_op(isDefined(var_13), var_13, var_17["moveTime"]);
      var_14 = scripts\engine\utility::ter_op(isDefined(var_14), var_14, var_17["use_bounce"]);
      var_15 = scripts\engine\utility::ter_op(isDefined(var_15), var_15, var_17["lighting_change"]);
    }
  } else {
    var_7 = ::_id_5FD9;
    var_6 = ::_id_FB41;
  }

  if(isDefined(var_15)) {
    level thread[[var_15]]();
  }

  if(var_7 == ::frontend_camera_no_move) {
    var_8 = scripts\engine\utility::ter_op(isDefined(var_8), var_8, 0.2);
    var_9 = scripts\engine\utility::ter_op(isDefined(var_9), var_9, 0.2);
    [[var_7]](level._id_0F19, var_8, var_9, var_6);
  } else if(var_7 == ::_id_5FD9) {
    var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, level._id_0F2A._id_A370);
    var_8 = scripts\engine\utility::ter_op(isDefined(var_8), var_8, 0.2);
    var_9 = scripts\engine\utility::ter_op(isDefined(var_9), var_9, 0.2);
    var_10 = scripts\engine\utility::ter_op(isDefined(var_10), var_10, level._id_0F2A._id_3713);
    [[var_7]](level._id_0F19, var_5, var_10, var_8, var_9, var_6);
  } else if(var_7 == ::_id_5FD7) {
    var_11 = scripts\engine\utility::ter_op(isDefined(var_11), var_11, 0.1);
    var_12 = scripts\engine\utility::ter_op(isDefined(var_12), var_12, 0.1);
    var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, 5000);
    var_14 = scripts\engine\utility::ter_op(isDefined(var_14), var_14, 0);
    var_13 = scripts\engine\utility::ter_op(isDefined(var_13), var_13, 0);
    _id_FB41();

    if(var_6 == ::_id_FB41 && !level._id_B812 usinggamepad()) {
      var_6 = ::_id_FB42;
    }

    [[var_7]](level._id_0F19, var_4, 0, 1, var_6, var_11, var_12, var_14, var_13);
  } else if(var_7 == ::teleport_cam_instantly) {
    var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, level._id_0F2A._id_A370);
    [[var_7]](level._id_0F19, var_5);
  } else {}
}

_id_3072(var_0, var_1, var_2, var_3, var_4, var_5) {
  level._id_B812 _meth_8282(var_0.origin);

  if(var_1 < 0.05) {
    var_1 = 0.05;
  }

  var_6 = 0.0;
  var_7 = 0.0;

  if(var_2) {
    var_6 = var_1 * var_3;
    var_7 = var_1 * var_4;
  }

  if(var_5) {
    var_8 = 1.3;
    var_9 = vectornormalize(var_0.origin - level._id_2FF9.origin);
    var_10 = var_0.origin + var_9 * var_8;
    var_11 = var_1 / 2.0;
    var_12 = var_11 * 0.0;
    var_13 = var_11 * 0.5;
    var_14 = var_11 * 0.5;
    var_15 = var_11 * 0.0;
    level._id_2FF9 moveto(var_10, var_11, var_12, var_13);
    level._id_2FF9 rotateto(var_0.angles, var_11, var_12, var_13);
    wait(var_11);
    level._id_2FF9 moveto(var_0.origin, var_11, var_14, var_15);
    wait(var_11);
  } else {
    level._id_2FF9._id_A203 = var_0;
    level._id_2FF9 moveto(var_0.origin, var_1, var_6, var_7);
    level._id_2FF9 rotateto(var_0.angles, var_1, var_6, var_7);

    if(level._id_B812 usinggamepad()) {
      wait(var_1);
    }
  }
}

_id_5FD7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_2FF9._id_A203)) {
    level._id_2FF9.origin = level._id_2FF9._id_A203.origin;
    level._id_2FF9.angles = level._id_2FF9._id_A203.angles;
  }

  level notify("camera_move");
  level endon("camera_move");

  if(!isDefined(var_1)) {
    var_1 = 900;
  }

  var_9 = var_0;

  if(var_8 == 0 || level._id_B812 usinggamepad()) {
    var_10 = distance(level._id_2FF9.origin, var_9.origin);
    var_8 = var_10 / var_1;

    if(var_10 > 350) {
      var_2 = 1;
      var_8 = 0.05;
      _id_FBE9();
    }
  }

  if(var_2) {
    level._id_2FF9.origin = var_9.origin;
    level._id_2FF9.angles = var_9.angles;
  } else
    _id_3072(var_9, var_8, var_3, var_5, var_6, var_7);

  var_11 = var_5 + var_6;

  if(var_11 > 1.0) {
    var_5 = var_5 / var_11;
    var_6 = var_6 / var_11;
  }

  while(isDefined(var_9.target)) {
    if(!isDefined(var_9.target)) {
      return;
    }
    var_9 = getent(var_9.target, "targetname");
    _id_3072(var_9, var_8, var_3, var_5, var_6, var_7);
  }

  level._id_2FF9._id_A203 = undefined;

  if(isDefined(var_4)) {
    self thread[[var_4]]();
  }

  _func_039C();
}

_id_5FD9(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("camera_teleport");
  level endon("camera_teleport");
  level._id_B812 _meth_8282(var_0.origin);
  level._id_F48A = 1;
  _func_0329(0, var_3);
  wait(var_3 + 0.05);
  _func_032A(var_1, 0);
  level._id_2FF9 dontinterpolate();
  level._id_2FF9.origin = var_0.origin;
  level._id_2FF9.angles = var_0.angles;
  level._id_2FF9._id_A203 = undefined;

  if(isDefined(var_2)) {
    _func_033D(var_2);
  }

  wait 0.1;

  if(isDefined(var_5)) {
    [[var_5]]();
  }

  _func_0329(1, var_4);
  level._id_F48A = 0;
  _func_039C();
}

frontend_camera_no_move(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("camera_teleport");
  level endon("camera_teleport");
  level._id_B812 _meth_8282(var_0.origin);
  level._id_F48A = 1;
  _func_0329(0, var_1);
  wait(var_1 + 0.05);
  wait 0.1;

  if(isDefined(var_3)) {
    [[var_3]]();
  }

  _func_0329(1, var_2);
  level._id_F48A = 0;
  _func_039C();
}

_id_FB47() {
  if(isDefined(level._id_0F2A._id_FB46)) {
    [[level._id_0F2A._id_FB46]]();
  } else if(isDefined(level._id_0F2A._id_33F6)) {
    var_0 = 0;

    if(isDefined(level._id_0F2A._id_33F3)) {
      var_0 = level._id_0F2A._id_33F3;
    }

    level.characters[var_0].origin = level._id_0F2A._id_33F6.origin;
    level.characters[var_0].angles = level._id_0F2A._id_33F6.angles;
  }
}

update_lighting() {
  if(isDefined(level._id_0F2A.update_lighting)) {
    [[level._id_0F2A.update_lighting]]();
  }
}

_id_FBAC() {
  _id_FB47();
  _id_FBE9();
  _id_FB41();
  _id_FBCC();
  update_lighting();
}

_id_FB41() {
  var_0 = level._id_0F19._id_47FB;
  self _meth_8660(var_0[0], var_0[1], 20, 20);
}

_id_FB42() {
  var_0 = level._id_0F19._id_47FB;
  self _meth_8660(var_0[0], var_0[1], 3, 3);
}

_id_FB67() {
  level notify("kill_multicam");
  _id_FB47();
  _id_FBE9();
  _id_FB41();
  _id_FBCC();
}

update_entities_and_not_camera() {
  level notify("kill_multicam");
  _id_FB47();
  _id_FBE9();
  _id_FBCC();
}

_id_FBCC() {
  if(isDefined(level._id_0F2A._id_E434)) {
    setDvar("#x3beed502923a4c08f", level._id_0F2A._id_E434);
  } else {
    setDvar("#x3beed502923a4c08f", 2);
  }
}

_id_A21E(var_0) {
  level.weapons[var_0].origin = level._id_0F2A._id_10D06[var_0].origin;
  level.weapons[var_0].angles = level._id_0F2A._id_10D06[var_0].angles;
}

_id_FBE9() {
  if(isDefined(level._id_0F2A._id_10D06)) {
    if(_func_0107(level._id_0F2A._id_10D06)) {
      for(var_0 = 0; var_0 <= 3; var_0++) {
        if(isDefined(level._id_0F2A._id_10D06[var_0])) {
          _id_A21E(var_0);
        }
      }
    }
  }
}

_id_FB3A() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    if(var_0 < 4.0) {
      var_1 = getent("tourroom_charslot_left_0" + (var_0 + 1), "targetname");
    } else {
      var_2 = var_0 - 4.0;
      var_1 = getent("tourroom_charslot_right_0" + (var_2 + 1), "targetname");
    }

    level.characters[var_0].origin = var_1.origin;
    level.characters[var_0].angles = var_1.angles;
  }
}

_id_FB71() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    if(var_0 < 4.0) {
      var_1 = getent("tourroom_charslot_left_0" + (var_0 + 1), "targetname");
    } else {
      var_2 = var_0 - 4.0;
      var_1 = getent("tourroom_charslot_right_0" + (var_2 + 1), "targetname");
    }

    level.characters[var_0].origin = var_1.origin;
    level.characters[var_0].angles = var_1.angles;
  }
}

update_tank_char_loc() {
  var_0 = getent("tank_scene_frontend_s4", "targetname");
  thread run_tank_animation();
  var_1 = [];
  var_1[var_1.size] = getent("lobby_charslot_01", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_02", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_03", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_04", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_05", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_06", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_07", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_08", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_01_dog", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_02_dog", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_03_dog", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_04_dog", "targetname");

  foreach(var_4, var_3 in var_1) {
    var_3.origin = var_0.origin + get_tank_anim_offset(var_4);
  }

  var_1 = [];
  var_1[var_1.size] = getent("lobby_charslot_09", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_10", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_11", "targetname");
  var_1[var_1.size] = getent("lobby_charslot_12", "targetname");

  foreach(var_6, var_3 in var_1) {
    var_3.origin = var_0.origin + get_tank_anim_offset(var_6);
  }
}

#using_animtree("script_model");

run_tank_animation() {
  if(!isDefined(level._id_F88A) || !isDefined(level.tankmodel)) {
    return;
  }
  for(;;) {
    level.tankmodel _meth_82CA();
    level._id_F88A _meth_82CA();
    level.tankmodel _meth_82CB("s4_mp_lobby_walk_tank", "tank_front");
    level._id_F88A _meth_82CB("s4_mp_lobby_walk_tank", "tank_front_turret");
    wait(_func_0079(%s4_mp_lobby_walk_tank));
  }
}

update_character_select_char_loc() {
  var_0 = getent("charroom_char_west_b", "targetname");
  var_1 = get_offset_transform_from_position_table("charroom_char_west_b");
  var_0 adjust_ent_with_table_data(var_0.origin, var_1);
  var_2 = getent("char_west_b", "targetname");
  var_1 = get_offset_transform_from_position_table("char_west_b");
  var_2 adjust_ent_with_table_data(var_0.origin, var_1);
  var_2 = getent("char_west_b_detail", "targetname");
  var_1 = get_offset_transform_from_position_table("char_west_b_detail");
  var_2 adjust_ent_with_table_data(var_0.origin, var_1);
}

get_tank_anim_offset(var_0) {
  var_1 = [];
  var_1[var_1.size] = "s4_mp_lobby_walk_01_generic_a";
  var_1[var_1.size] = "s4_mp_lobby_walk_02_generic_a";
  var_1[var_1.size] = "s4_mp_lobby_walk_03_generic_a";
  var_1[var_1.size] = "s4_mp_lobby_walk_04_generic_a";
  var_1[var_1.size] = "s4_mp_lobby_walk_05_generic_a";
  var_1[var_1.size] = "s4_mp_lobby_walk_06_generic_a";
  var_1[var_1.size] = "s4_mp_lobby_walk_07_generic_a";
  var_1[var_1.size] = "s4_mp_lobby_walk_08_generic_a";
  var_1[var_1.size] = "lobby_charslot_01_dog";
  var_1[var_1.size] = "lobby_charslot_02_dog";
  var_1[var_1.size] = "lobby_charslot_03_dog";
  var_1[var_1.size] = "lobby_charslot_04_dog";
  var_2 = [];
  var_2[var_2.size] = "#x3640fcd67bdb0e576";
  var_2[var_2.size] = "#x3fbd53e40e961c3b";
  var_2[var_2.size] = "#x31601b612ae1530d4";
  var_2[var_2.size] = "#x39358678a5fc78651";
  var_2[var_2.size] = "#x318494f3797278e5a";
  var_2[var_2.size] = "#x32c6936ff0e7bfd9f";
  var_2[var_2.size] = "#x31e7fd7fefbf18a08";
  var_2[var_2.size] = "#x317e7984edb65bf95";
  var_2[var_2.size] = "#x342046c311f1d84a0";
  var_2[var_2.size] = "#x3692cb74dd48b9201";
  var_2[var_2.size] = "#x3f78f7065b839937e";
  var_2[var_2.size] = "#x34d970cd342e8775f";
  var_3 = _func_0222("frontEndSceneData/frontendCharacterPositionData.csv", 0, var_1[int(var_0)], 1);
  var_4 = _func_0222("frontEndSceneData/frontendCharacterPositionData.csv", 0, var_1[int(var_0)], 2);
  var_5 = _func_0222("frontEndSceneData/frontendCharacterPositionData.csv", 0, var_1[int(var_0)], 3);
  var_6 = (int(var_3), int(var_4), int(var_5));
  var_7 = get_dvar_offset(var_6, (0, 0, 0), var_2[int(var_0)]);
  return var_7["pos"];
}

get_dvar_offset(var_0, var_1, var_2) {
  var_3["pos"] = var_0;
  var_3["rotation"] = var_1;
  return var_3;
}

_id_FB7F() {
  update_tank_char_loc();
  update_character_select_char_loc();
  var_0 = getent("lobby_charslot_01", "targetname");
  level.characters[0].origin = var_0.origin;
  level.characters[0].angles = var_0.angles;

  for(var_1 = 1; var_1 < 8; var_1++) {
    var_2 = var_1 + 1;

    if(var_2 < 10) {
      var_0 = getent("lobby_charslot_0" + var_2, "targetname");
    } else {
      var_0 = getent("lobby_charslot_" + var_2, "targetname");
    }

    if(isDefined(var_0)) {
      level.characters[var_1].origin = var_0.origin;
      level.characters[var_1].angles = var_0.angles;
    }
  }

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_2 = var_3 + 1;
    var_1 = 8 + var_3;
    var_0 = getent("lobby_charslot_0" + var_2 + "_dog", "targetname");
    level.characters[var_1].origin = var_0.origin;
    level.characters[var_1].angles = var_0.angles;
  }
}

update_lobby_char_loc_v2() {
  _id_FB7F();
  thread update_multicamera_lobby();
}

update_multicamera_lobby() {
  if(!isDefined(level.charactercount)) {
    level.charactercount = 1;
  }

  level.currentframe = 0;
  level endon("kill_multicam");

  for(;;) {
    level.currentframe = level.currentframe + 1;

    if(level.currentframe > 2) {
      level.currentframe = 0;
    }

    var_0 = level.charactercount;

    if(getdvarint("#x3cbd4846245c3637d", 0) > 0) {
      var_0 = getdvarint("#x3cbd4846245c3637d");
      level.charactercount = var_0;
    }

    if(var_0 >= 8) {
      level._id_306B adjust_cam_to_tank_v2("char_lobby_7");
    } else {
      level._id_306B adjust_cam_to_tank_v2("char_lobby_" + scripts\engine\utility::_id_EA52(var_0));
    }

    teleport_cam_instantly(level._id_306B._id_22B1, level._id_306B._id_A370);
    wait(getdvarfloat("#x31f7dbb0cf037a846", 7.0));

    while(getdvarint("#x31fa0a437ac5f6c68", 0)) {
      wait 1;
    }
  }
}

teleport_cam_instantly(var_0, var_1) {
  _func_032A(var_1, 0);
  level._id_2FF9 dontinterpolate();
  level._id_2FF9.origin = var_0.origin;
  level._id_2FF9.angles = var_0.angles;
  var_2 = var_0._id_47FB;
  self _meth_8660(var_2[0], var_2[1], 20, 20);
}

adjust_cam_to_tank_v2(var_0, var_1) {
  var_2 = getent("tank_scene_frontend_s4", "targetname");
  var_3 = 1;
  var_4 = ["a", "b", "c"];

  if(!isDefined(var_1)) {
    if(!isDefined(level.currentframe)) {
      level.currentframe = 0;
    }

    var_3 = level.currentframe;
  } else
    var_3 = var_1;

  var_5 = get_offset_transform_from_position_table(var_0 + var_4[var_3]);
  self._id_22B1 adjust_ent_with_table_data(var_2.origin, var_5);
  self._id_A370 = var_5["fov"];
  self._id_22B1._id_47FB = [var_5["fStop"], var_5["fDist"]];
}

set_lobby_cam_initial_pos() {
  var_0 = level.charactercount;

  if(!isDefined(var_0)) {
    adjust_cam_to_tank_v2("char_lobby_1", 0);
  } else {
    if(var_0 >= 8) {
      level._id_306B adjust_cam_to_tank_v2("char_lobby_7");
      return;
    }

    level._id_306B adjust_cam_to_tank_v2("char_lobby_" + scripts\engine\utility::_id_EA52(var_0));
  }
}

_id_FB85() {}

_id_FBA1() {
  var_0 = getent("charroom_char_west_b", "targetname");
  level.characters[0].origin = var_0.origin;
  level.characters[0].angles = var_0.angles;
  var_0 = getent("charroom_char_west_b_dog", "targetname");
  level.characters[8].origin = var_0.origin;
  level.characters[8].angles = var_0.angles;
}

_id_FBA0() {
  var_0 = getent("charroom_char_east_a", "targetname");
  level.characters[1].origin = var_0.origin;
  level.characters[1].angles = var_0.angles;
  level.characters[9].origin = var_0.origin;
  level.characters[9].angles = var_0.angles;
}

_id_C041(var_0) {
  switch (var_0) {
    case "small":
      foreach(var_2 in level._id_F90A) {
        var_2.origin = level._id_C044.origin;
      }

      break;
    case "medium":
      foreach(var_2 in level._id_F90A) {
        var_2.origin = level._id_C043.origin;
      }

      break;
    case "large":
      foreach(var_2 in level._id_F90A) {
        var_2.origin = level._id_C042.origin;
      }

      break;
    case "watch":
      foreach(var_2 in level._id_F90A) {
        var_2.origin = level._id_C045.origin;
      }

      break;
  }
}

_id_81D9() {
  var_0 = [];
  var_0["loadout_showcase"] = [];
  var_0["loadout_showcase"]["default"] = [];
  var_0["loadout_showcase"]["default"]["transition"] = ::_id_5FD9;
  var_0["loadout_showcase"]["default"]["callback"] = ::_id_FB67;
  var_0["loadout_showcase"]["default"]["fov"] = 36;
  var_1 = [];
  var_1["transition"] = ::_id_5FD7;
  var_1["callback"] = ::_id_FB41;
  var_1["speed"] = 200;
  var_0["loadout_showcase"]["weapon_showcase"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_overview"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_p"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_p_large"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_o"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_o_large"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_shield_p"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_shield_o"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_s"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_l"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_t"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_perks"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_x"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_y"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_z"] = var_1;
  var_0["loadout_showcase"]["loadout_showcase_watch"] = var_1;
  var_2 = [];
  var_2["transition"] = ::_id_5FD7;
  var_2["callback"] = ::_id_FB67;
  var_2["speed"] = 200;
  var_2["fov"] = 36;
  var_3 = [];
  var_3["transition"] = ::_id_5FD9;
  var_3["callback"] = ::_id_FB67;
  var_3["fadeOutTime"] = 0.05;
  var_3["fadeInTime"] = 0.05;
  var_3["fov"] = 36;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_barrel"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt3"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt4"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt5"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt6"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_gunperk"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_laser"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_laser_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_laser_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_large_laser"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt3"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt4"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt5"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt6"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt7"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt8"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt9"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt10"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_muzzle"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_muzzle_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_muzzle_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_muzzle_alt3"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_optic"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_optic_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_optic_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_optic_alt3"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_optic_alt4"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_reargrip"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_reargrip_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_reargrip_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_reargrip_alt3"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_stock"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_stock_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_stock_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_stock_alt3"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_stock_alt4"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_large_stock_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_underbarrel"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_underbarrel_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_underbarrel_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_underbarrel_alt3"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_underbarrel_alt4"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_underbarrel_alt5"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_charm"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt3"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt4"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_sticker"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt1"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt2"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt3"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt4"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt5"] = var_2;
  var_0["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt6"] = var_2;
  var_0["loadout_showcase_preview_barrel"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt3"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt4"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt5"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt6"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_gunperk"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_laser"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_laser_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_laser_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_large_laser"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt3"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt4"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt5"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt6"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt7"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt8"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt9"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt10"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_muzzle"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_muzzle_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_muzzle_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_muzzle_alt3"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_optic"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_optic_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_optic_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_optic_alt3"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_optic_alt4"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_reargrip"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_reargrip_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_reargrip_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_reargrip_alt3"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_stock"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_stock_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_stock_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_stock_alt3"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_stock_alt4"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_large_stock_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_underbarrel"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt3"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt4"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt5"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_charm"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_charm_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_charm_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_charm_alt3"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_charm_alt4"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_sticker"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt1"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt2"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt3"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt4"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt5"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt6"]["loadout_showcase_preview"] = var_2;
  var_0["loadout_showcase_preview_barrel"]["default"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt4"]["default"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt5"]["default"] = var_2;
  var_0["loadout_showcase_preview_barrel_alt6"]["default"] = var_2;
  var_0["loadout_showcase_preview_gunperk"]["default"] = var_2;
  var_0["loadout_showcase_preview_laser"]["default"] = var_2;
  var_0["loadout_showcase_preview_laser_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_laser_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_laser"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt4"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt5"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt6"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt7"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt8"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt9"]["default"] = var_2;
  var_0["loadout_showcase_preview_magazine_alt10"]["default"] = var_2;
  var_0["loadout_showcase_preview_muzzle"]["default"] = var_2;
  var_0["loadout_showcase_preview_muzzle_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_muzzle_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_muzzle_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_optic"]["default"] = var_2;
  var_0["loadout_showcase_preview_optic_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_optic_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_optic_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_optic_alt4"]["default"] = var_2;
  var_0["loadout_showcase_preview_reargrip"]["default"] = var_2;
  var_0["loadout_showcase_preview_reargrip_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_reargrip_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_reargrip_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_stock"]["default"] = var_2;
  var_0["loadout_showcase_preview_stock_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_stock_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_stock_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_stock_alt4"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_stock_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_underbarrel"]["default"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt4"]["default"] = var_2;
  var_0["loadout_showcase_preview_underbarrel_alt5"]["default"] = var_2;
  var_0["loadout_showcase_preview_charm"]["default"] = var_2;
  var_0["loadout_showcase_preview_charm_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_charm_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_charm_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_charm_alt4"]["default"] = var_2;
  var_0["loadout_showcase_preview_sticker"]["default"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt4"]["default"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt5"]["default"] = var_2;
  var_0["loadout_showcase_preview_sticker_alt6"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_barrel"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_barrel_alt1"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_gunperk"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_laser"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_laser"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_magazine"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt1"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt2"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt3"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt4"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt5"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_muzzle"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_muzzle_alt1"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_optic"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_optic_alt1"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_reargrip"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_reargrip_alt1"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_reargrip_alt2"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_stock"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_stock_alt1"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_underbarrel"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_underbarrel_alt1"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_underbarrel_alt2"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_underbarrel_alt3"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_charm"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_charm_alt1"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_charm_alt2"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_sticker"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_sticker_alt1"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_sticker_alt2"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large_sticker_alt3"]["loadout_showcase_preview_large"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_barrel"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_barrel_alt1"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_gunperk"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_laser"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_laser"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine_alt1"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine_alt2"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine_alt3"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine_alt4"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine_alt5"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_muzzle"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_muzzle_alt1"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_optic"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_optic_alt1"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_reargrip"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_reargrip_alt1"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_reargrip_alt2"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_stock"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_stock_alt1"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_underbarrel"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_underbarrel_alt1"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_underbarrel_alt2"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_underbarrel_alt3"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_charm"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_charm_alt1"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_charm_alt2"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker_alt1"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker_alt2"] = var_2;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker_alt3"] = var_2;
  var_0["loadout_showcase_preview_large_barrel"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_barrel_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_gunperk"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_laser"]["default"] = var_2;
  var_0["loadout_showcase_preview_laser"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_magazine"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt4"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_magazine_alt5"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_muzzle"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_muzzle_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_optic"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_optic_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_reargrip"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_reargrip_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_reargrip_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_stock"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_stock_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_underbarrel"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_underbarrel_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_underbarrel_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_underbarrel_alt3"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_charm"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_charm_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_charm_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_sticker"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_sticker_alt1"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_sticker_alt2"]["default"] = var_2;
  var_0["loadout_showcase_preview_large_sticker_alt3"]["default"] = var_2;
  var_0["loadout_showcase_overview"]["default"]["transition"] = ::_id_5FD9;
  var_0["loadout_showcase_overview"]["default"]["callback"] = ::_id_FB67;
  var_0["loadout_showcase_overview"]["default"]["fov"] = 36;
  var_0["loadout_showcase_overview"]["loadout_showcase"]["transition"] = ::_id_5FD7;
  var_0["loadout_showcase_overview"]["loadout_showcase"]["callback"] = ::_id_FB41;
  var_0["loadout_showcase_overview"]["loadout_showcase"]["speed"] = 200;
  var_0["loadout_showcase_overview"]["loadout_showcase"]["fov"] = 36;
  var_0["loadout_showcase_overview"]["loadout_showcase_watch"]["transition"] = ::_id_5FD7;
  var_0["loadout_showcase_overview"]["loadout_showcase_watch"]["callback"] = ::_id_FB41;
  var_0["loadout_showcase_overview"]["loadout_showcase_watch"]["speed"] = 200;
  var_0["loadout_showcase_overview"]["loadout_showcase_watch"]["fov"] = 36;
  var_0["loadout_showcase_preview"]["default"]["transition"] = ::_id_5FD9;
  var_0["loadout_showcase_preview"]["default"]["callback"] = ::_id_FB67;
  var_0["loadout_showcase_preview"]["loadout_showcase_p"] = var_3;
  var_0["loadout_showcase_preview"]["loadout_showcase_o"] = var_3;
  var_0["loadout_showcase_preview_large"]["default"]["transition"] = ::_id_5FD9;
  var_0["loadout_showcase_preview_large"]["default"]["callback"] = ::_id_FB67;
  var_0["loadout_showcase_preview_large"]["loadout_showcase_p_large"] = var_3;
  var_0["loadout_showcase_preview"]["loadout_showcase_o_large"] = var_3;
  var_0["loadout_showcase_preview_small"]["default"]["transition"] = ::_id_5FD9;
  var_0["loadout_showcase_preview_small"]["default"]["callback"] = ::_id_FB67;
  var_0["loadout_showcase_preview_small"]["loadout_showcase_s"] = var_3;
  var_0["loadout_showcase_preview_riot"]["default"]["transition"] = ::_id_5FD9;
  var_0["loadout_showcase_preview_riot"]["default"]["callback"] = ::_id_FB67;
  var_0["loadout_showcase_preview_riot"]["loadout_showcase_shield_p"] = var_3;
  var_0["loadout_showcase_preview_riot"]["loadout_showcase_shield_o"] = var_3;
  var_0["loadout_showcase_preview_watch"]["default"]["transition"] = ::_id_5FD9;
  var_0["loadout_showcase_preview_watch"]["default"]["callback"] = ::_id_FB67;
  var_0["loadout_showcase_preview_watch"]["loadout_showcase_watch"] = var_3;
  var_4["transition"] = ::_id_5FD9;
  var_4["callback"] = ::_id_FB67;
  var_4["fadeOutTime"] = 0.05;
  var_4["fadeInTime"] = 0.05;
  var_4["fov"] = 36;
  var_5 = [];
  var_5["transition"] = ::_id_5FD7;
  var_5["callback"] = ::_id_FB41;
  var_5["speed"] = 200;
  var_5["accelScalar"] = 0.9;
  var_5["moveTime"] = 0.5;
  var_5["decelScalar"] = 0.1;
  var_0["loadout_showcase_p"]["default"] = var_4;
  var_0["loadout_showcase_p"]["loadout_showcase"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_overview"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_preview"] = var_4;
  var_0["loadout_showcase_p"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_p"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_p_large"]["default"] = var_4;
  var_0["loadout_showcase_p_large"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_preview_large"] = var_4;
  var_0["loadout_showcase_p_large"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_p_large"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_s"]["default"] = var_4;
  var_0["loadout_showcase_s"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_preview_small"] = var_4;
  var_0["loadout_showcase_s"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_s"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_o"]["default"] = var_4;
  var_0["loadout_showcase_o"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_preview"] = var_4;
  var_0["loadout_showcase_o"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_o"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_o_large"]["default"] = var_4;
  var_0["loadout_showcase_o_large"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_preview_large"] = var_4;
  var_0["loadout_showcase_o_large"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_o_large"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_shield_p"]["default"] = var_4;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_overview"] = var_5;
  var_0["loadout_showcase_shield_p"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_shield_o"]["default"] = var_4;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_overview"] = var_5;
  var_0["loadout_showcase_shield_o"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_l"]["default"] = var_4;
  var_0["loadout_showcase_l"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_l"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_t"]["default"] = var_4;
  var_0["loadout_showcase_t"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_t"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_perks"]["default"] = var_4;
  var_0["loadout_showcase_perks"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_perks"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_x"]["default"] = var_4;
  var_0["loadout_showcase_x"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_specialist"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_x"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_y"]["default"] = var_4;
  var_0["loadout_showcase_y"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_specialist"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_y"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_z"]["default"] = var_4;
  var_0["loadout_showcase_z"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_specialist"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_z"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_specialist"]["default"] = var_4;
  var_0["loadout_showcase_specialist"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_watch"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_specialist"]["loadout_showcase_shield_o"] = var_5;
  var_0["loadout_showcase_watch"]["default"] = var_4;
  var_0["loadout_showcase_watch"]["loadout_showcase_p"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_p_large"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_s"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_o"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_o_large"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_l"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_t"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_perks"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_x"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_y"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_z"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_overview"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_shield_p"] = var_5;
  var_0["loadout_showcase_watch"]["loadout_showcase_shield_o"] = var_5;
  var_0["character_tango"]["default"]["transition"] = ::_id_5FD9;
  var_0["character_tango"]["default"]["callback"] = ::_id_FB67;
  var_0["character_tango"]["default"]["fov"] = level._id_3006._id_A370;
  var_0["character_faction_select"]["default"]["transition"] = ::_id_5FD9;
  var_0["character_faction_select"]["default"]["callback"] = ::_id_FB67;
  var_0["character_faction_select"]["default"]["fov"] = level.camera_character_faction_select._id_A370;
  var_0["character_faction_select"]["character_faction_select_detail"]["transition"] = ::_id_5FD9;
  var_0["character_faction_select"]["character_faction_select_detail"]["fov"] = level.camera_character_faction_select_detail._id_A370;
  var_0["character_faction_select"]["squad_lobby_detail"]["transition"] = ::_id_5FD9;
  var_0["character_faction_select"]["squad_lobby_detail"]["fadeOutTime"] = 0;
  var_0["character_faction_select"]["squad_lobby_detail"]["fov"] = 36;
  var_0["character_faction_select_detail"]["default"]["transition"] = ::_id_5FD9;
  var_0["character_faction_select_detail"]["default"]["callback"] = ::_id_FB67;
  var_0["character_faction_select_detail"]["default"]["fov"] = level.camera_character_faction_select_detail._id_A370;
  var_0["character_faction_select_detail"]["character_faction_select"]["transition"] = ::_id_5FD9;
  var_0["character_faction_select_detail"]["character_faction_select"]["fov"] = level.camera_character_faction_select._id_A370;
  var_0["character_faction_select_detail"]["character_faction_select_quips"]["transition"] = ::frontend_camera_no_move;
  var_0["character_faction_select_detail"]["character_faction_select_quips"]["fadeOutTime"] = 0;
  var_0["character_faction_select_detail"]["character_faction_select_quips"]["fov"] = level.camera_character_faction_select_detail._id_A370;
  var_0["character_faction_select_quips"]["default"]["transition"] = ::_id_5FD9;
  var_0["character_faction_select_quips"]["default"]["callback"] = ::_id_FB67;
  var_0["character_faction_select_quips"]["default"]["fov"] = level.camera_character_faction_select_detail._id_A370;
  var_0["character_faction_select_quips"]["character_faction_select_detail"]["transition"] = ::frontend_camera_no_move;
  var_0["character_faction_select_quips"]["character_faction_select_detail"]["fadeOutTime"] = 0;
  var_0["character_faction_select_quips"]["character_faction_select_detail"]["fov"] = level.camera_character_faction_select_detail._id_A370;
  var_0["character_faction_select_quips"]["character_faction_select_animation_preview"]["transition"] = ::_id_5FD9;
  var_0["character_faction_select_quips"]["character_faction_select_animation_preview"]["fadeOutTime"] = 0;
  var_0["character_faction_select_quips"]["character_faction_select_animation_preview"]["fov"] = level.camera_character_faction_select_animation_preview._id_A370;
  var_0["character_faction_select_animation_preview"]["default"]["transition"] = ::frontend_camera_no_move;
  var_0["character_faction_select_animation_preview"]["default"]["callback"] = ::update_entities_and_not_camera;
  var_0["character_faction_select_animation_preview"]["default"]["fadeOutTime"] = 0;
  var_0["character_faction_select_animation_preview"]["default"]["fov"] = level.camera_character_faction_select_animation_preview._id_A370;
  var_0["character_preview_select"]["default"]["transition"] = ::_id_5FD9;
  var_0["character_preview_select"]["default"]["callback"] = ::_id_FB67;
  var_0["character_preview_select"]["default"]["fov"] = level.camera_character_faction_select._id_A370;
  var_0["character_preview_select"]["character_preview_select_detail"]["transition"] = ::_id_5FD7;
  var_0["character_preview_select"]["character_preview_select_detail"]["speed"] = 150;
  var_0["character_preview_select"]["character_preview_select_detail"]["fov"] = level.camera_character_faction_select_detail._id_A370;
  var_0["character_preview_select"]["character_preview_select_detail"]["use_bounce"] = 1;
  var_0["character_preview_select"]["character_preview_select"]["transition"] = ::_id_5FD9;
  var_0["character_preview_select_detail"]["default"]["transition"] = ::_id_5FD9;
  var_0["character_preview_select_detail"]["default"]["callback"] = ::_id_FB67;
  var_0["character_preview_select_detail"]["default"]["fov"] = level.camera_character_faction_select_detail._id_A370;
  var_0["character_preview_select_detail"]["character_preview_select"]["transition"] = ::_id_5FD7;
  var_0["character_preview_select_detail"]["character_preview_select"]["speed"] = 150;
  var_0["character_preview_select_detail"]["character_preview_select"]["fov"] = level.camera_character_faction_select._id_A370;
  var_0["character_preview_select_detail"]["character_preview_select"]["use_bounce"] = 1;
  var_0["character_faction_preview"]["default"]["transition"] = ::_id_5FD9;
  var_0["character_faction_preview"]["default"]["callback"] = ::_id_FB67;
  var_0["character_faction_preview"]["default"]["fov"] = level.camera_character_faction_select_preview._id_A370;
  var_0["character_faction_preview"]["character_faction_select_detail"]["transition"] = ::_id_5FD9;
  var_0["character_faction_preview"]["character_faction_select_detail"]["fadeOutTime"] = 0;
  var_0["character_faction_preview"]["character_faction_select_detail"]["fov"] = level.camera_character_faction_select_preview._id_A370;
  var_0["character_tournaments"]["default"]["transition"] = ::_id_5FD9;
  var_0["character_tournaments"]["default"]["callback"] = ::_id_FB67;
  var_0["character_tournaments"]["default"]["fov"] = 36;
  var_0["character_gamebattles"]["default"]["transition"] = ::_id_5FD9;
  var_0["character_gamebattles"]["default"]["callback"] = ::_id_FB67;
  var_0["character_gamebattles"]["default"]["fov"] = 36;
  var_0["store"]["default"]["transition"] = ::_id_5FD9;
  var_0["store"]["default"]["callback"] = ::_id_FB67;
  var_0["store"]["default"]["fov"] = 28;
  var_0["quartermaster"]["default"]["transition"] = ::_id_5FD9;
  var_0["quartermaster"]["default"]["callback"] = ::_id_FB67;
  var_0["quartermaster"]["default"]["fov"] = 28;
  var_0["quartermaster"]["default"]["fadeOutTime"] = 0;
  var_0["quartermaster"]["default"]["speed"] = 150;
  var_0["quartermaster"]["quartermaster_detail"]["transition"] = ::_id_5FD7;
  var_0["quartermaster"]["quartermaster_detail"]["speed"] = 150;
  var_0["quartermaster"]["quartermaster_detail"]["fov"] = level.camera_character_faction_select_detail._id_A370;
  var_0["quartermaster"]["quartermaster_detail"]["use_bounce"] = 1;
  var_0["quartermaster_detail"]["default"]["transition"] = ::_id_5FD9;
  var_0["quartermaster_detail"]["default"]["callback"] = ::_id_FB67;
  var_0["quartermaster_detail"]["default"]["fov"] = 28;
  var_0["quartermaster_detail"]["quartermaster"]["transition"] = ::_id_5FD7;
  var_0["quartermaster_detail"]["quartermaster"]["speed"] = 150;
  var_0["quartermaster_detail"]["quartermaster"]["fov"] = level.camera_character_faction_select._id_A370;
  var_0["quartermaster_detail"]["quartermaster"]["use_bounce"] = 1;
  var_0["blackcell"]["default"]["transition"] = ::_id_5FD9;
  var_0["blackcell"]["default"]["callback"] = ::_id_FB67;
  var_0["blackcell"]["default"]["fov"] = 28;
  var_0["blackcell"]["blackcell_detail"]["transition"] = ::_id_5FD7;
  var_0["blackcell"]["blackcell_detail"]["speed"] = 150;
  var_0["blackcell"]["blackcell_detail"]["fov"] = level.camera_character_faction_select_detail._id_A370;
  var_0["blackcell"]["blackcell_detail"]["use_bounce"] = 1;
  var_0["blackcell_detail"]["default"]["transition"] = ::_id_5FD9;
  var_0["blackcell_detail"]["default"]["callback"] = ::_id_FB67;
  var_0["blackcell_detail"]["default"]["fov"] = 28;
  var_0["blackcell_detail"]["blackcell"]["transition"] = ::_id_5FD7;
  var_0["blackcell_detail"]["blackcell"]["speed"] = 150;
  var_0["blackcell_detail"]["blackcell"]["fov"] = level.camera_character_faction_select._id_A370;
  var_0["blackcell_detail"]["blackcell"]["use_bounce"] = 1;
  var_0["squad_lobby"]["default"]["transition"] = ::_id_5FD9;
  var_0["squad_lobby"]["default"]["callback"] = ::_id_FB67;
  var_0["squad_lobby"]["default"]["fov"] = 36;
  var_0["squad_lobby"]["squad_lobby_detail"]["transition"] = ::_id_5FD9;
  var_0["squad_lobby"]["squad_lobby_detail"]["fov"] = 36;
  var_0["squad_lobby_detail"]["default"]["transition"] = ::_id_5FD9;
  var_0["squad_lobby_detail"]["default"]["callback"] = ::_id_FB67;
  var_0["squad_lobby_detail"]["default"]["fov"] = 36;
  var_0["squad_lobby_detail"]["squad_lobby"]["transition"] = ::_id_5FD9;
  var_0["squad_lobby_detail"]["squad_lobby"]["fov"] = 36;
  var_0["ui_bg_01"]["default"]["transition"] = ::_id_5FD9;
  var_0["ui_bg_01"]["default"]["callback"] = ::_id_FB67;
  var_0["ui_bg_01"]["default"]["fov"] = 28;
  var_0["worldmap"]["default"]["transition"] = ::_id_5FD9;
  var_0["worldmap"]["default"]["callback"] = ::_id_FB67;
  var_0["worldmap"]["default"]["fov"] = 28;
  var_0["weapon_showcase"] = [];
  var_0["weapon_showcase"]["default"] = [];
  var_0["weapon_showcase"]["default"]["transition"] = ::_id_5FD7;
  var_0["weapon_showcase"]["default"]["callback"] = ::_id_FB41;
  var_0["weapon_showcase"]["default"]["speed"] = 75;
  var_0["barracks"] = [];
  var_0["barracks"]["default"] = [];
  var_0["barracks"]["default"]["transition"] = ::_id_5FD7;
  var_0["barracks"]["default"]["callback"] = ::_id_FB41;
  var_0["barracks"]["default"]["speed"] = 100;
  var_0["barracks"]["weapon_showcase"]["speed"] = 5000;
  var_0["player_character_showcase"] = [];
  var_0["player_character_showcase"]["default"] = [];
  var_0["player_character_showcase"]["default"]["transition"] = ::_id_5FD9;
  var_0["player_character_showcase"]["default"]["callback"] = ::_id_FBAC;

  foreach(var_7 in level.frontend_transition_adds) {
    var_0[var_7.from][var_7.to][var_7.name] = var_7._id_6016;
  }

  level._id_F491 = var_0;
}

_id_6744(var_0) {
  var_1 = [];
  var_2 = !isDefined(level._id_0F2A) || level._id_F48A;

  switch (var_0.name) {
    case "mlg.tv":
      break;
    case "squad_lobby":
      var_1["scene"] = level._id_306B;
      var_1["camera"] = level._id_306B._id_22B1;
      break;
    case "squad_lobby_detail":
      var_1["scene"] = level._id_306C;
      var_1["camera"] = level._id_306C._id_22B1;
      break;
    case "character_tango":
      var_1["scene"] = level._id_3006;
      var_1["camera"] = level._id_3006._id_22B1;
      break;
    case "store":
      var_1["scene"] = level._id_307B;
      var_1["camera"] = level._id_307B._id_22B1;
      break;
    case "quartermaster":
      var_1["scene"] = level._id_3076;
      var_1["camera"] = level._id_3076._id_22B1;
      break;
    case "quartermaster_detail":
      var_1["scene"] = level._id_3077;
      var_1["camera"] = level._id_3077._id_22B1;
      break;
    case "character_faction_select":
      var_1["scene"] = level.camera_character_faction_select;
      var_1["camera"] = level.camera_character_faction_select._id_22B1;
      break;
    case "character_faction_preview":
      var_1["scene"] = level.camera_character_faction_select_preview;
      var_1["camera"] = level.camera_character_faction_select_preview._id_22B1;
      break;
    case "character_faction_select_quips":
    case "character_faction_select_detail":
      var_1["scene"] = level.camera_character_faction_select_detail;
      var_1["camera"] = level.camera_character_faction_select_detail._id_22B1;
      break;
    case "character_faction_select_animation_preview":
      var_1["scene"] = level.camera_character_faction_select_animation_preview;
      var_1["camera"] = level.camera_character_faction_select_animation_preview._id_22B1;
      break;
    case "character_preview_select":
      var_1["scene"] = level._id_3004;
      var_1["camera"] = level._id_3004._id_22B1;
      break;
    case "character_preview_select_detail":
      var_1["scene"] = level._id_3005;
      var_1["camera"] = level._id_3005._id_22B1;
      break;
    case "character_tournaments":
      var_1["scene"] = level._id_3007;
      var_1["camera"] = level._id_3007._id_22B1;
      break;
    case "character_gamebattles":
      var_1["scene"] = level._id_3003;
      var_1["camera"] = level._id_3003._id_22B1;
      break;
    case "loadout_showcase_overview":
      var_1["scene"] = level._id_301C;
      var_1["camera"] = level._id_301C._id_22B1;
      break;
    case "loadout_showcase_preview":
      var_1["scene"] = level._id_3020;
      var_1["camera"] = level._id_3020._id_22B1;
      _id_C041("medium");
      break;
    case "loadout_showcase_preview_large":
      var_1["scene"] = level._id_3029;
      var_1["camera"] = level._id_3029._id_22B1;
      _id_C041("large");
      break;
    case "loadout_showcase_preview_small":
      var_1["scene"] = level._id_304E;
      var_1["camera"] = level._id_304E._id_22B1;
      _id_C041("small");
      break;
    case "loadout_showcase_preview_riot":
      var_1["scene"] = level._id_304D;
      var_1["camera"] = level._id_304D._id_22B1;
      break;
    case "loadout_showcase_preview_watch":
      var_1["scene"] = level._id_3063;
      var_1["camera"] = level._id_3063._id_22B1;
      _id_C041("watch");
      break;
    case "loadout_showcase_preview_barrel":
      var_1["scene"] = level._id_3021;
      var_1["camera"] = level._id_3021._id_22B1;
      break;
    case "loadout_showcase_preview_barrel_alt1":
      var_1["scene"] = level._id_3022;
      var_1["camera"] = level._id_3022._id_22B1;
      break;
    case "loadout_showcase_preview_barrel_alt2":
      var_1["scene"] = level._id_3023;
      var_1["camera"] = level._id_3023._id_22B1;
      break;
    case "loadout_showcase_preview_barrel_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_barrel_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_barrel_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_barrel_alt4":
      var_1["scene"] = level.camera_loadout_showcase_preview_barrel_alt4;
      var_1["camera"] = level.camera_loadout_showcase_preview_barrel_alt4._id_22B1;
      break;
    case "loadout_showcase_preview_barrel_alt5":
      var_1["scene"] = level.camera_loadout_showcase_preview_barrel_alt5;
      var_1["camera"] = level.camera_loadout_showcase_preview_barrel_alt5._id_22B1;
      break;
    case "loadout_showcase_preview_barrel_alt6":
      var_1["scene"] = level.camera_loadout_showcase_preview_barrel_alt6;
      var_1["camera"] = level.camera_loadout_showcase_preview_barrel_alt6._id_22B1;
      break;
    case "loadout_showcase_preview_charm":
      var_1["scene"] = level._id_3024;
      var_1["camera"] = level._id_3024._id_22B1;
      break;
    case "loadout_showcase_preview_charm_alt1":
      var_1["scene"] = level._id_3025;
      var_1["camera"] = level._id_3025._id_22B1;
      break;
    case "loadout_showcase_preview_charm_alt2":
      var_1["scene"] = level._id_3026;
      var_1["camera"] = level._id_3026._id_22B1;
      break;
    case "loadout_showcase_preview_charm_alt3":
      var_1["scene"] = level._id_3027;
      var_1["camera"] = level._id_3027._id_22B1;
      break;
    case "loadout_showcase_preview_charm_alt4":
      var_1["scene"] = level._id_3028;
      var_1["camera"] = level._id_3028._id_22B1;
      break;
    case "loadout_showcase_preview_gunperk":
      var_1["scene"] = level.camera_loadout_showcase_preview_gunperk;
      var_1["camera"] = level.camera_loadout_showcase_preview_gunperk._id_22B1;
      break;
    case "loadout_showcase_preview_laser":
      var_1["scene"] = level._id_3040;
      var_1["camera"] = level._id_3040._id_22B1;
      break;
    case "loadout_showcase_preview_laser_alt1":
      var_1["scene"] = level._id_3041;
      var_1["camera"] = level._id_3041._id_22B1;
      break;
    case "loadout_showcase_preview_laser_alt2":
      var_1["scene"] = level._id_3042;
      var_1["camera"] = level._id_3042._id_22B1;
      break;
    case "loadout_showcase_preview_magazine":
      var_1["scene"] = level._id_3043;
      var_1["camera"] = level._id_3043._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt1":
      var_1["scene"] = level._id_3044;
      var_1["camera"] = level._id_3044._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt2":
      var_1["scene"] = level._id_3045;
      var_1["camera"] = level._id_3045._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_magazine_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_magazine_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt4":
      var_1["scene"] = level.camera_loadout_showcase_preview_magazine_alt4;
      var_1["camera"] = level.camera_loadout_showcase_preview_magazine_alt4._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt5":
      var_1["scene"] = level.camera_loadout_showcase_preview_magazine_alt5;
      var_1["camera"] = level.camera_loadout_showcase_preview_magazine_alt5._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt6":
      var_1["scene"] = level.camera_loadout_showcase_preview_magazine_alt6;
      var_1["camera"] = level.camera_loadout_showcase_preview_magazine_alt6._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt7":
      var_1["scene"] = level.camera_loadout_showcase_preview_magazine_alt7;
      var_1["camera"] = level.camera_loadout_showcase_preview_magazine_alt7._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt8":
      var_1["scene"] = level.camera_loadout_showcase_preview_magazine_alt8;
      var_1["camera"] = level.camera_loadout_showcase_preview_magazine_alt8._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt9":
      var_1["scene"] = level.camera_loadout_showcase_preview_magazine_alt9;
      var_1["camera"] = level.camera_loadout_showcase_preview_magazine_alt9._id_22B1;
      break;
    case "loadout_showcase_preview_magazine_alt10":
      var_1["scene"] = level.camera_loadout_showcase_preview_magazine_alt10;
      var_1["camera"] = level.camera_loadout_showcase_preview_magazine_alt10._id_22B1;
      break;
    case "loadout_showcase_preview_muzzle":
      var_1["scene"] = level._id_3046;
      var_1["camera"] = level._id_3046._id_22B1;
      break;
    case "loadout_showcase_preview_muzzle_alt1":
      var_1["scene"] = level._id_3047;
      var_1["camera"] = level._id_3047._id_22B1;
      break;
    case "loadout_showcase_preview_muzzle_alt2":
      var_1["scene"] = level.camera_loadout_showcase_preview_muzzle_alt2;
      var_1["camera"] = level.camera_loadout_showcase_preview_muzzle_alt2._id_22B1;
      break;
    case "loadout_showcase_preview_muzzle_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_muzzle_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_muzzle_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_optic":
      var_1["scene"] = level._id_3048;
      var_1["camera"] = level._id_3048._id_22B1;
      break;
    case "loadout_showcase_preview_optic_alt1":
      var_1["scene"] = level._id_3049;
      var_1["camera"] = level._id_3049._id_22B1;
      break;
    case "loadout_showcase_preview_optic_alt2":
      var_1["scene"] = level.camera_loadout_showcase_preview_optic_alt2;
      var_1["camera"] = level.camera_loadout_showcase_preview_optic_alt2._id_22B1;
      break;
    case "loadout_showcase_preview_optic_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_optic_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_optic_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_optic_alt4":
      var_1["scene"] = level.camera_loadout_showcase_preview_optic_alt4;
      var_1["camera"] = level.camera_loadout_showcase_preview_optic_alt4._id_22B1;
      break;
    case "loadout_showcase_preview_reargrip":
      var_1["scene"] = level._id_304A;
      var_1["camera"] = level._id_304A._id_22B1;
      break;
    case "loadout_showcase_preview_reargrip_alt1":
      var_1["scene"] = level._id_304B;
      var_1["camera"] = level._id_304B._id_22B1;
      break;
    case "loadout_showcase_preview_reargrip_alt2":
      var_1["scene"] = level._id_304C;
      var_1["camera"] = level._id_304C._id_22B1;
      break;
    case "loadout_showcase_preview_reargrip_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_reargrip_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_reargrip_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_sticker":
      var_1["scene"] = level._id_305A;
      var_1["camera"] = level._id_305A._id_22B1;
      break;
    case "loadout_showcase_preview_sticker_alt1":
      var_1["scene"] = level._id_305B;
      var_1["camera"] = level._id_305B._id_22B1;
      break;
    case "loadout_showcase_preview_sticker_alt2":
      var_1["scene"] = level._id_305C;
      var_1["camera"] = level._id_305C._id_22B1;
      break;
    case "loadout_showcase_preview_sticker_alt3":
      var_1["scene"] = level._id_305D;
      var_1["camera"] = level._id_305D._id_22B1;
      break;
    case "loadout_showcase_preview_sticker_alt4":
      var_1["scene"] = level._id_305E;
      var_1["camera"] = level._id_305E._id_22B1;
      break;
    case "loadout_showcase_preview_sticker_alt5":
      var_1["scene"] = level.camera_loadout_showcase_preview_sticker_alt5;
      var_1["camera"] = level.camera_loadout_showcase_preview_sticker_alt5._id_22B1;
      break;
    case "loadout_showcase_preview_sticker_alt6":
      var_1["scene"] = level.camera_loadout_showcase_preview_sticker_alt6;
      var_1["camera"] = level.camera_loadout_showcase_preview_sticker_alt6._id_22B1;
      break;
    case "loadout_showcase_preview_stock":
      var_1["scene"] = level._id_305F;
      var_1["camera"] = level._id_305F._id_22B1;
      break;
    case "loadout_showcase_preview_stock_alt1":
      var_1["scene"] = level._id_3060;
      var_1["camera"] = level._id_3060._id_22B1;
      break;
    case "loadout_showcase_preview_stock_alt2":
      var_1["scene"] = level._id_3061;
      var_1["camera"] = level._id_3061._id_22B1;
      break;
    case "loadout_showcase_preview_stock_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_stock_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_stock_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_stock_alt4":
      var_1["scene"] = level.camera_loadout_showcase_preview_stock_alt4;
      var_1["camera"] = level.camera_loadout_showcase_preview_stock_alt4._id_22B1;
      break;
    case "loadout_showcase_preview_underbarrel":
      var_1["scene"] = level._id_3062;
      var_1["camera"] = level._id_3062._id_22B1;
      break;
    case "loadout_showcase_preview_underbarrel_alt1":
      var_1["scene"] = level.camera_loadout_showcase_preview_underbarrel_alt1;
      var_1["camera"] = level.camera_loadout_showcase_preview_underbarrel_alt1._id_22B1;
      break;
    case "loadout_showcase_preview_underbarrel_alt2":
      var_1["scene"] = level.camera_loadout_showcase_preview_underbarrel_alt2;
      var_1["camera"] = level.camera_loadout_showcase_preview_underbarrel_alt2._id_22B1;
      break;
    case "loadout_showcase_preview_underbarrel_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_underbarrel_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_underbarrel_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_underbarrel_alt4":
      var_1["scene"] = level.camera_loadout_showcase_preview_underbarrel_alt4;
      var_1["camera"] = level.camera_loadout_showcase_preview_underbarrel_alt4._id_22B1;
      break;
    case "loadout_showcase_preview_underbarrel_alt5":
      var_1["scene"] = level.camera_loadout_showcase_preview_underbarrel_alt5;
      var_1["camera"] = level.camera_loadout_showcase_preview_underbarrel_alt5._id_22B1;
      break;
    case "loadout_showcase_preview_large_barrel":
      var_1["scene"] = level._id_302A;
      var_1["camera"] = level._id_302A._id_22B1;
      break;
    case "loadout_showcase_preview_large_barrel_alt1":
      var_1["scene"] = level._id_302B;
      var_1["camera"] = level._id_302B._id_22B1;
      break;
    case "loadout_showcase_preview_large_charm":
      var_1["scene"] = level._id_302C;
      var_1["camera"] = level._id_302C._id_22B1;
      break;
    case "loadout_showcase_preview_large_charm_alt1":
      var_1["scene"] = level._id_302D;
      var_1["camera"] = level._id_302D._id_22B1;
      break;
    case "loadout_showcase_preview_large_charm_alt2":
      var_1["scene"] = level._id_302E;
      var_1["camera"] = level._id_302E._id_22B1;
      break;
    case "loadout_showcase_preview_large_gunperk":
      var_1["scene"] = level.camera_loadout_showcase_preview_large_gunperk;
      var_1["camera"] = level.camera_loadout_showcase_preview_large_gunperk._id_22B1;
      break;
    case "loadout_showcase_preview_large_laser":
      var_1["scene"] = level._id_302F;
      var_1["camera"] = level._id_302F._id_22B1;
      break;
    case "loadout_showcase_preview_large_magazine":
      var_1["scene"] = level._id_3030;
      var_1["camera"] = level._id_3030._id_22B1;
      break;
    case "loadout_showcase_preview_large_magazine_alt1":
      var_1["scene"] = level._id_3031;
      var_1["camera"] = level._id_3031._id_22B1;
      break;
    case "loadout_showcase_preview_large_magazine_alt2":
      var_1["scene"] = level._id_3032;
      var_1["camera"] = level._id_3032._id_22B1;
      break;
    case "loadout_showcase_preview_large_magazine_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_large_magazine_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_large_magazine_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_large_magazine_alt4":
      var_1["scene"] = level.camera_loadout_showcase_preview_large_magazine_alt4;
      var_1["camera"] = level.camera_loadout_showcase_preview_large_magazine_alt4._id_22B1;
      break;
    case "loadout_showcase_preview_large_magazine_alt5":
      var_1["scene"] = level.camera_loadout_showcase_preview_large_magazine_alt5;
      var_1["camera"] = level.camera_loadout_showcase_preview_large_magazine_alt5._id_22B1;
      break;
    case "loadout_showcase_preview_large_muzzle":
      var_1["scene"] = level._id_3033;
      var_1["camera"] = level._id_3033._id_22B1;
      break;
    case "loadout_showcase_preview_large_muzzle_alt1":
      var_1["scene"] = level._id_3034;
      var_1["camera"] = level._id_3034._id_22B1;
      break;
    case "loadout_showcase_preview_large_optic":
      var_1["scene"] = level._id_3035;
      var_1["camera"] = level._id_3035._id_22B1;
      break;
    case "loadout_showcase_preview_large_optic_alt1":
      var_1["scene"] = level.camera_loadout_showcase_preview_large_optic_alt1;
      var_1["camera"] = level.camera_loadout_showcase_preview_large_optic_alt1._id_22B1;
      break;
    case "loadout_showcase_preview_large_reargrip":
      var_1["scene"] = level._id_3036;
      var_1["camera"] = level._id_3036._id_22B1;
      break;
    case "loadout_showcase_preview_large_reargrip_alt1":
      var_1["scene"] = level._id_3037;
      var_1["camera"] = level._id_3037._id_22B1;
      break;
    case "loadout_showcase_preview_large_reargrip_alt2":
      var_1["scene"] = level.camera_loadout_showcase_preview_large_reargrip_alt2;
      var_1["camera"] = level.camera_loadout_showcase_preview_large_reargrip_alt2._id_22B1;
      break;
    case "loadout_showcase_preview_large_sticker":
      var_1["scene"] = level._id_3038;
      var_1["camera"] = level._id_3038._id_22B1;
      break;
    case "loadout_showcase_preview_large_sticker_alt1":
      var_1["scene"] = level._id_3039;
      var_1["camera"] = level._id_3039._id_22B1;
      break;
    case "loadout_showcase_preview_large_sticker_alt2":
      var_1["scene"] = level._id_303A;
      var_1["camera"] = level._id_303A._id_22B1;
      break;
    case "loadout_showcase_preview_large_sticker_alt3":
      var_1["scene"] = level._id_303B;
      var_1["camera"] = level._id_303B._id_22B1;
      break;
    case "loadout_showcase_preview_large_stock":
      var_1["scene"] = level._id_303C;
      var_1["camera"] = level._id_303C._id_22B1;
      break;
    case "loadout_showcase_preview_large_stock_alt1":
      var_1["scene"] = level._id_303D;
      var_1["camera"] = level._id_303D._id_22B1;
      break;
    case "loadout_showcase_preview_large_underbarrel":
      var_1["scene"] = level._id_303E;
      var_1["camera"] = level._id_303E._id_22B1;
      break;
    case "loadout_showcase_preview_large_underbarrel_alt1":
      var_1["scene"] = level._id_303F;
      var_1["camera"] = level._id_303F._id_22B1;
      break;
    case "loadout_showcase_preview_large_underbarrel_alt2":
      var_1["scene"] = level.camera_loadout_showcase_preview_large_underbarrel_alt2;
      var_1["camera"] = level.camera_loadout_showcase_preview_large_underbarrel_alt2._id_22B1;
      break;
    case "loadout_showcase_preview_large_underbarrel_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_large_underbarrel_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_large_underbarrel_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_small_barrel":
      var_1["scene"] = level._id_304F;
      var_1["camera"] = level._id_304F._id_22B1;
      break;
    case "loadout_showcase_preview_small_barrel_alt1":
      var_1["scene"] = level.camera_loadout_showcase_preview_small_barrel_alt1;
      var_1["camera"] = level.camera_loadout_showcase_preview_small_barrel_alt1._id_22B1;
      break;
    case "loadout_showcase_preview_small_barrel_alt2":
      var_1["scene"] = level.camera_loadout_showcase_preview_small_barrel_alt2;
      var_1["camera"] = level.camera_loadout_showcase_preview_small_barrel_alt2._id_22B1;
      break;
    case "loadout_showcase_preview_small_charm":
      var_1["scene"] = level._id_3050;
      var_1["camera"] = level._id_3050._id_22B1;
      break;
    case "loadout_showcase_preview_small_gunperk":
      var_1["scene"] = level.camera_loadout_showcase_preview_small_gunperk;
      var_1["camera"] = level.camera_loadout_showcase_preview_small_gunperk._id_22B1;
      break;
    case "loadout_showcase_preview_small_laser":
      var_1["scene"] = level._id_3051;
      var_1["camera"] = level._id_3051._id_22B1;
      break;
    case "loadout_showcase_preview_small_magazine":
      var_1["scene"] = level._id_3052;
      var_1["camera"] = level._id_3052._id_22B1;
      break;
    case "loadout_showcase_preview_small_magazine_alt1":
      var_1["scene"] = level._id_3053;
      var_1["camera"] = level._id_3053._id_22B1;
      break;
    case "loadout_showcase_preview_small_magazine_alt2":
      var_1["scene"] = level.camera_loadout_showcase_preview_small_magazine_alt2;
      var_1["camera"] = level.camera_loadout_showcase_preview_small_magazine_alt2._id_22B1;
      break;
    case "loadout_showcase_preview_small_magazine_alt3":
      var_1["scene"] = level.camera_loadout_showcase_preview_small_magazine_alt3;
      var_1["camera"] = level.camera_loadout_showcase_preview_small_magazine_alt3._id_22B1;
      break;
    case "loadout_showcase_preview_small_magazine_alt4":
      var_1["scene"] = level.camera_loadout_showcase_preview_small_magazine_alt4;
      var_1["camera"] = level.camera_loadout_showcase_preview_small_magazine_alt4._id_22B1;
      break;
    case "loadout_showcase_preview_small_muzzle":
      var_1["scene"] = level._id_3054;
      var_1["camera"] = level._id_3054._id_22B1;
      break;
    case "loadout_showcase_preview_small_optic":
      var_1["scene"] = level._id_3055;
      var_1["camera"] = level._id_3055._id_22B1;
      break;
    case "loadout_showcase_preview_small_reargrip":
      var_1["scene"] = level._id_3056;
      var_1["camera"] = level._id_3056._id_22B1;
      break;
    case "loadout_showcase_preview_small_reargrip_alt1":
      var_1["scene"] = level.camera_loadout_showcase_preview_small_reargrip_alt1;
      var_1["camera"] = level.camera_loadout_showcase_preview_small_reargrip_alt1._id_22B1;
      break;
    case "loadout_showcase_preview_small_sticker":
      var_1["scene"] = level._id_3057;
      var_1["camera"] = level._id_3057._id_22B1;
      break;
    case "loadout_showcase_preview_small_stock":
      var_1["scene"] = level._id_3058;
      var_1["camera"] = level._id_3058._id_22B1;
      break;
    case "loadout_showcase_preview_small_trigger":
      var_1["scene"] = level._id_3059;
      var_1["camera"] = level._id_3059._id_22B1;
      break;
    case "loadout_showcase":
      var_1["scene"] = level._id_3017;
      var_1["camera"] = level._id_3017._id_22B1;
      break;
    case "loadout_showcase_armory":
      var_1["scene"] = level._id_3018;
      var_1["camera"] = level._id_3018._id_22B1;
      break;
    case "loadout_showcase_p":
      var_1["scene"] = level._id_301D;
      var_1["camera"] = level._id_301D._id_22B1;
      break;
    case "loadout_showcase_p_large":
      var_1["scene"] = level._id_301E;
      var_1["camera"] = level._id_301E._id_22B1;
      break;
    case "loadout_showcase_s":
      var_1["scene"] = level._id_3064;
      var_1["camera"] = level._id_3064._id_22B1;
      break;
    case "loadout_showcase_o":
      var_1["scene"] = level._id_301A;
      var_1["camera"] = level._id_301A._id_22B1;
      break;
    case "loadout_showcase_o_large":
      var_1["scene"] = level._id_301B;
      var_1["camera"] = level._id_301B._id_22B1;
      break;
    case "loadout_showcase_shield_p":
      var_1["scene"] = level.camera_loadout_showcase_shield_p;
      var_1["camera"] = level.camera_loadout_showcase_shield_p._id_22B1;
      break;
    case "loadout_showcase_shield_o":
      var_1["scene"] = level.camera_loadout_showcase_shield_o;
      var_1["camera"] = level.camera_loadout_showcase_shield_o._id_22B1;
      break;
    case "loadout_showcase_l":
      var_1["scene"] = level._id_3019;
      var_1["camera"] = level._id_3019._id_22B1;
      break;
    case "loadout_showcase_t":
      var_1["scene"] = level._id_3066;
      var_1["camera"] = level._id_3066._id_22B1;
      break;
    case "loadout_showcase_perks":
      var_1["scene"] = level._id_301F;
      var_1["camera"] = level._id_301F._id_22B1;
      break;
    case "loadout_showcase_x":
      var_1["scene"] = level._id_3068;
      var_1["camera"] = level._id_3068._id_22B1;
      break;
    case "loadout_showcase_y":
      var_1["scene"] = level._id_3069;
      var_1["camera"] = level._id_3069._id_22B1;
      break;
    case "loadout_showcase_z":
      var_1["scene"] = level._id_306A;
      var_1["camera"] = level._id_306A._id_22B1;
      break;
    case "loadout_showcase_specialist":
      var_1["scene"] = level._id_3065;
      var_1["camera"] = level._id_3065._id_22B1;
      break;
    case "loadout_showcase_watch":
      var_1["scene"] = level._id_3067;
      var_1["camera"] = level._id_3067._id_22B1;
      break;
    case "weapon_showcase":
      var_1["scene"] = level._id_307C;
      var_1["camera"] = level._id_307C._id_22B1;
      break;
    case "barracks":
      var_3 = scripts\engine\utility::ter_op(var_2, level._id_307C, level._id_0F2A);
      var_1["scene"] = level._id_307C;
      var_1["camera"] = level._id_307C._id_22B1;
      break;
    case "player_character_showcase":
      var_1["scene"] = level._id_307C;
      var_1["camera"] = level._id_307C._id_22B1;
      break;
    default:
      break;
  }

  return var_1;
}

_id_3EDF() {
  level._id_3017 = spawnStruct();
  level._id_3017._id_22B1 = getent("camera_mp_gunsmith_overview", "targetname");
  level._id_3017._id_22B1._id_47FB = [2, 100];
  level._id_3017._id_A370 = 36;
  level._id_3017._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_3017._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_3017._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3017._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_3017._id_E434 = 6;
  level._id_301C = spawnStruct();
  level._id_301C._id_22B1 = getent("camera_mp_gunsmith_overview", "targetname");
  level._id_301C._id_22B1._id_47FB = [3.5, 130];
  level._id_301C._id_A370 = 28;
  level._id_301C._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_301C._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_301C._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_301C._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_301C._id_E434 = 6;
  level._id_3020 = spawnStruct();
  level._id_3020._id_22B1 = getent("camera_mp_gunsmith_preview", "targetname");
  level._id_3020._id_22B1._id_47FB = [30, 75];
  level._id_3020._id_A370 = 36;
  level._id_3020._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3020._id_E434 = 6;
  level._id_3029 = spawnStruct();
  level._id_3029._id_22B1 = getent("camera_mp_gunsmith_preview_large", "targetname");
  level._id_3029._id_22B1._id_47FB = [30, 90];
  level._id_3029._id_A370 = 36;
  level._id_3029._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3029._id_E434 = 6;
  level._id_304E = spawnStruct();
  level._id_304E._id_22B1 = getent("camera_mp_gunsmith_preview_secondary", "targetname");
  level._id_304E._id_22B1._id_47FB = [30, 38];
  level._id_304E._id_A370 = 36;
  level._id_304E._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_304E._id_E434 = 6;
  level._id_3063 = spawnStruct();
  level._id_3063._id_22B1 = getent("camera_mp_gunsmith_preview_watch", "targetname");
  level._id_3063._id_22B1._id_47FB = [20, 16];
  level._id_3063._id_A370 = 36;
  level._id_3063._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3063._id_E434 = 6;
  level._id_3018 = spawnStruct();
  level._id_3018._id_22B1 = getent("camera_mp_gunsmith_armory", "targetname");
  level._id_3018._id_22B1._id_47FB = [7, 67];
  level._id_3018._id_A370 = 44;
  level._id_3018._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_3018._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_3018._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_3018._id_E434 = 6;
  level._id_301D = spawnStruct();
  level._id_301D._id_22B1 = getent("camera_mp_gunsmith_alt_p_large", "targetname");
  level._id_301D._id_22B1._id_47FB = [7, 35];
  level._id_301D._id_A370 = 55;
  level._id_301D._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_301D._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_301D._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_301D._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_301D._id_E434 = 6;
  level._id_301E = spawnStruct();
  level._id_301E._id_22B1 = getent("camera_mp_gunsmith_alt_p_large", "targetname");
  level._id_301E._id_22B1._id_47FB = [7, 100];
  level._id_301E._id_A370 = 55;
  level._id_301E._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_301E._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_301E._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_301E._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_301E._id_E434 = 6;
  level._id_3064 = spawnStruct();
  level._id_3064._id_22B1 = getent("camera_mp_gunsmith_alt_s", "targetname");
  level._id_3064._id_22B1._id_47FB = [4, 60];
  level._id_3064._id_A370 = 55;
  level._id_3064._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_3064._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_3064._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3064._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_3064._id_E434 = 6;
  level._id_301A = spawnStruct();
  level._id_301A._id_22B1 = getent("camera_mp_gunsmith_alt_o_large", "targetname");
  level._id_301A._id_22B1._id_47FB = [3.5, 105];
  level._id_301A._id_A370 = 55;
  level._id_301A._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_301A._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_301A._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_301A._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_301A._id_E434 = 6;
  level._id_301B = spawnStruct();
  level._id_301B._id_22B1 = getent("camera_mp_gunsmith_alt_o_large", "targetname");
  level._id_301B._id_22B1._id_47FB = [3.5, 105];
  level._id_301B._id_A370 = 55;
  level._id_301B._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_301B._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_301B._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_301B._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_301B._id_E434 = 6;
  level.camera_loadout_showcase_shield_p = spawnStruct();
  level.camera_loadout_showcase_shield_p._id_22B1 = getent("camera_mp_gunsmith_riot", "targetname");
  level.camera_loadout_showcase_shield_p._id_22B1._id_47FB = [3, 170];
  level.camera_loadout_showcase_shield_p._id_A370 = 55;
  level.camera_loadout_showcase_shield_p._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_shield_p._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_shield_p._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_shield_p._id_E434 = 6;
  level.camera_loadout_showcase_shield_o = spawnStruct();
  level.camera_loadout_showcase_shield_o._id_22B1 = getent("camera_mp_gunsmith_riot", "targetname");
  level.camera_loadout_showcase_shield_o._id_22B1._id_47FB = [3, 170];
  level.camera_loadout_showcase_shield_o._id_A370 = 55;
  level.camera_loadout_showcase_shield_o._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_shield_o._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_shield_o._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_shield_o._id_E434 = 6;
  level._id_3019 = spawnStruct();
  level._id_3019._id_22B1 = getent("camera_mp_gunsmith_alt_l", "targetname");
  level._id_3019._id_22B1._id_47FB = [14, 30];
  level._id_3019._id_A370 = 55;
  level._id_3019._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_3019._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_3019._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_3019._id_E434 = 6;
  level._id_3066 = spawnStruct();
  level._id_3066._id_22B1 = getent("camera_mp_gunsmith_alt_t", "targetname");
  level._id_3066._id_22B1._id_47FB = [14, 31];
  level._id_3066._id_A370 = 55;
  level._id_3066._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_3066._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_3066._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_3066._id_E434 = 6;
  level._id_301F = spawnStruct();
  level._id_301F._id_22B1 = getent("camera_mp_gunsmith_alt_perks", "targetname");
  level._id_301F._id_22B1._id_47FB = [3.5, 60];
  level._id_301F._id_A370 = 55;
  level._id_301F._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_301F._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_301F._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_301F._id_E434 = 6;
  level._id_3068 = spawnStruct();
  level._id_3068._id_22B1 = getent("camera_mp_gunsmith_alt_x", "targetname");
  level._id_3068._id_22B1._id_47FB = [3.5, 45];
  level._id_3068._id_A370 = 55;
  level._id_3068._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_3068._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_3068._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_3068._id_E434 = 6;
  level._id_3069 = spawnStruct();
  level._id_3069._id_22B1 = getent("camera_mp_gunsmith_alt_y", "targetname");
  level._id_3069._id_22B1._id_47FB = [3.5, 45];
  level._id_3069._id_A370 = 55;
  level._id_3069._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_3069._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_3069._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_3069._id_E434 = 6;
  level._id_306A = spawnStruct();
  level._id_306A._id_22B1 = getent("camera_mp_gunsmith_alt_z", "targetname");
  level._id_306A._id_22B1._id_47FB = [3.5, 45];
  level._id_306A._id_A370 = 55;
  level._id_306A._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_306A._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_306A._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_306A._id_E434 = 6;
  level._id_3065 = spawnStruct();
  level._id_3065._id_22B1 = getent("camera_mp_gunsmith_alt_specialist", "targetname");
  level._id_3065._id_22B1._id_47FB = [22, 16];
  level._id_3065._id_A370 = 55;
  level._id_3065._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_3065._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_3065._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_3065._id_E434 = 6;
  level._id_3067 = spawnStruct();
  level._id_3067._id_22B1 = getent("camera_mp_gunsmith_alt_watch", "targetname");
  level._id_3067._id_22B1._id_47FB = [22, 8];
  level._id_3067._id_A370 = 55;
  level._id_3067._id_10D06[0] = getent("weapon_loc_hq1", "targetname");
  level._id_3067._id_10D06[1] = getent("weapon_loc_hq2", "targetname");
  level._id_3067._id_10D06[3] = getent("weapon_loc_watch", "targetname");
  level._id_3067._id_E434 = 6;
  level._id_304D = spawnStruct();
  level._id_304D._id_22B1 = getent("camera_mp_gunsmith_preview_riot", "targetname");
  level._id_304D._id_22B1._id_47FB = [16, 152];
  level._id_304D._id_A370 = 36;
  level._id_304D._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_304D._id_E434 = 6;
  level._id_3021 = spawnStruct();
  level._id_3021._id_22B1 = getent("camera_mp_gunsmith_preview_barrel", "targetname");
  level._id_3021._id_22B1._id_47FB = [8, 34];
  level._id_3021._id_A370 = 36;
  level._id_3021._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3021._id_E434 = 6;
  level._id_3022 = spawnStruct();
  level._id_3022._id_22B1 = getent("camera_mp_gunsmith_preview_barrel_alt1", "targetname");
  level._id_3022._id_22B1._id_47FB = [8, 48];
  level._id_3022._id_A370 = 36;
  level._id_3022._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3022._id_E434 = 6;
  level._id_3023 = spawnStruct();
  level._id_3023._id_22B1 = getent("camera_mp_gunsmith_preview_barrel_alt2", "targetname");
  level._id_3023._id_22B1._id_47FB = [8, 75];
  level._id_3023._id_A370 = 36;
  level._id_3023._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3023._id_E434 = 6;
  level.camera_loadout_showcase_preview_barrel_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_barrel_alt3", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt3._id_22B1._id_47FB = [16, 54];
  level.camera_loadout_showcase_preview_barrel_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_barrel_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt3._id_E434 = 6;
  level.camera_loadout_showcase_preview_barrel_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt4._id_22B1 = getent("camera_mp_gunsmith_preview_barrel_alt4", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt4._id_22B1._id_47FB = [8, 54];
  level.camera_loadout_showcase_preview_barrel_alt4._id_A370 = 36;
  level.camera_loadout_showcase_preview_barrel_alt4._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt4._id_E434 = 6;
  level.camera_loadout_showcase_preview_barrel_alt5 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt5._id_22B1 = getent("camera_mp_gunsmith_preview_barrel_alt5", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt5._id_22B1._id_47FB = [8, 54];
  level.camera_loadout_showcase_preview_barrel_alt5._id_A370 = 36;
  level.camera_loadout_showcase_preview_barrel_alt5._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt5._id_E434 = 6;
  level.camera_loadout_showcase_preview_barrel_alt6 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt6._id_22B1 = getent("camera_mp_gunsmith_preview_barrel_alt6", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt6._id_22B1._id_47FB = [8, 54];
  level.camera_loadout_showcase_preview_barrel_alt6._id_A370 = 36;
  level.camera_loadout_showcase_preview_barrel_alt6._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt6._id_E434 = 6;
  level._id_3024 = spawnStruct();
  level._id_3024._id_22B1 = getent("camera_mp_gunsmith_preview_charm", "targetname");
  level._id_3024._id_22B1._id_47FB = [21, 16];
  level._id_3024._id_A370 = 36;
  level._id_3024._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3024._id_E434 = 6;
  level._id_3025 = spawnStruct();
  level._id_3025._id_22B1 = getent("camera_mp_gunsmith_preview_charm_alt1", "targetname");
  level._id_3025._id_22B1._id_47FB = [21, 16];
  level._id_3025._id_A370 = 36;
  level._id_3025._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3025._id_E434 = 6;
  level._id_3026 = spawnStruct();
  level._id_3026._id_22B1 = getent("camera_mp_gunsmith_preview_charm_alt2", "targetname");
  level._id_3026._id_22B1._id_47FB = [21, 16];
  level._id_3026._id_A370 = 36;
  level._id_3026._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3026._id_E434 = 6;
  level._id_3027 = spawnStruct();
  level._id_3027._id_22B1 = getent("camera_mp_gunsmith_preview_charm_alt3", "targetname");
  level._id_3027._id_22B1._id_47FB = [21, 16];
  level._id_3027._id_A370 = 36;
  level._id_3027._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3027._id_E434 = 6;
  level._id_3028 = spawnStruct();
  level._id_3028._id_22B1 = getent("camera_mp_gunsmith_preview_charm_alt4", "targetname");
  level._id_3028._id_22B1._id_47FB = [21, 18];
  level._id_3028._id_A370 = 36;
  level._id_3028._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3028._id_E434 = 6;
  level.camera_loadout_showcase_preview_gunperk = spawnStruct();
  level.camera_loadout_showcase_preview_gunperk._id_22B1 = getent("camera_mp_gunsmith_preview_gunperk", "targetname");
  level.camera_loadout_showcase_preview_gunperk._id_22B1._id_47FB = [30, 75];
  level.camera_loadout_showcase_preview_gunperk._id_A370 = 36;
  level.camera_loadout_showcase_preview_gunperk._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_gunperk._id_E434 = 6;
  level._id_3040 = spawnStruct();
  level._id_3040._id_22B1 = getent("camera_mp_gunsmith_preview_laser", "targetname");
  level._id_3040._id_22B1._id_47FB = [8, 25];
  level._id_3040._id_A370 = 36;
  level._id_3040._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3040._id_E434 = 6;
  level._id_3041 = spawnStruct();
  level._id_3041._id_22B1 = getent("camera_mp_gunsmith_preview_laser_alt1", "targetname");
  level._id_3041._id_22B1._id_47FB = [8, 25];
  level._id_3041._id_A370 = 36;
  level._id_3041._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3041._id_E434 = 6;
  level._id_3042 = spawnStruct();
  level._id_3042._id_22B1 = getent("camera_mp_gunsmith_preview_laser_alt2", "targetname");
  level._id_3042._id_22B1._id_47FB = [8, 25];
  level._id_3042._id_A370 = 36;
  level._id_3042._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3042._id_E434 = 6;
  level._id_3043 = spawnStruct();
  level._id_3043._id_22B1 = getent("camera_mp_gunsmith_preview_magazine", "targetname");
  level._id_3043._id_22B1._id_47FB = [8, 24];
  level._id_3043._id_A370 = 36;
  level._id_3043._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3043._id_E434 = 6;
  level._id_3044 = spawnStruct();
  level._id_3044._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt1", "targetname");
  level._id_3044._id_22B1._id_47FB = [8, 24];
  level._id_3044._id_A370 = 36;
  level._id_3044._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3044._id_E434 = 6;
  level._id_3045 = spawnStruct();
  level._id_3045._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt2", "targetname");
  level._id_3045._id_22B1._id_47FB = [8, 24];
  level._id_3045._id_A370 = 36;
  level._id_3045._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3045._id_E434 = 6;
  level.camera_loadout_showcase_preview_magazine_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt3", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt3._id_22B1._id_47FB = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_magazine_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt3._id_E434 = 6;
  level.camera_loadout_showcase_preview_magazine_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt4._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt4", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt4._id_22B1._id_47FB = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt4._id_A370 = 36;
  level.camera_loadout_showcase_preview_magazine_alt4._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt4._id_E434 = 6;
  level.camera_loadout_showcase_preview_magazine_alt5 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt5._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt5", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt5._id_22B1._id_47FB = [12, 24];
  level.camera_loadout_showcase_preview_magazine_alt5._id_A370 = 36;
  level.camera_loadout_showcase_preview_magazine_alt5._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt5._id_E434 = 6;
  level.camera_loadout_showcase_preview_magazine_alt6 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt6._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt6", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt6._id_22B1._id_47FB = [30, 30];
  level.camera_loadout_showcase_preview_magazine_alt6._id_A370 = 36;
  level.camera_loadout_showcase_preview_magazine_alt6._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt6._id_E434 = 6;
  level.camera_loadout_showcase_preview_magazine_alt7 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt7._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt7", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt7._id_22B1._id_47FB = [16, 25];
  level.camera_loadout_showcase_preview_magazine_alt7._id_A370 = 36;
  level.camera_loadout_showcase_preview_magazine_alt7._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt7._id_E434 = 6;
  level.camera_loadout_showcase_preview_magazine_alt8 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt8._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt8", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt8._id_22B1._id_47FB = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt8._id_A370 = 36;
  level.camera_loadout_showcase_preview_magazine_alt8._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt8._id_E434 = 6;
  level.camera_loadout_showcase_preview_magazine_alt9 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt9._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt9", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt9._id_22B1._id_47FB = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt9._id_A370 = 36;
  level.camera_loadout_showcase_preview_magazine_alt9._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt9._id_E434 = 6;
  level.camera_loadout_showcase_preview_magazine_alt10 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt10._id_22B1 = getent("camera_mp_gunsmith_preview_magazine_alt10", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt10._id_22B1._id_47FB = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt10._id_A370 = 36;
  level.camera_loadout_showcase_preview_magazine_alt10._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt10._id_E434 = 6;
  level._id_3046 = spawnStruct();
  level._id_3046._id_22B1 = getent("camera_mp_gunsmith_preview_muzzle", "targetname");
  level._id_3046._id_22B1._id_47FB = [12, 30];
  level._id_3046._id_A370 = 36;
  level._id_3046._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3046._id_E434 = 6;
  level._id_3047 = spawnStruct();
  level._id_3047._id_22B1 = getent("camera_mp_gunsmith_preview_muzzle_alt1", "targetname");
  level._id_3047._id_22B1._id_47FB = [18, 32];
  level._id_3047._id_A370 = 36;
  level._id_3047._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3047._id_E434 = 6;
  level.camera_loadout_showcase_preview_muzzle_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle_alt2._id_22B1 = getent("camera_mp_gunsmith_preview_muzzle_alt2", "targetname");
  level.camera_loadout_showcase_preview_muzzle_alt2._id_22B1._id_47FB = [18, 32];
  level.camera_loadout_showcase_preview_muzzle_alt2._id_A370 = 36;
  level.camera_loadout_showcase_preview_muzzle_alt2._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_muzzle_alt2._id_E434 = 6;
  level.camera_loadout_showcase_preview_muzzle_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_muzzle_alt3", "targetname");
  level.camera_loadout_showcase_preview_muzzle_alt3._id_22B1._id_47FB = [18, 32];
  level.camera_loadout_showcase_preview_muzzle_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_muzzle_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_muzzle_alt3._id_E434 = 6;
  level._id_3048 = spawnStruct();
  level._id_3048._id_22B1 = getent("camera_mp_gunsmith_preview_optic", "targetname");
  level._id_3048._id_22B1._id_47FB = [21.5, 17];
  level._id_3048._id_A370 = 36;
  level._id_3048._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3048._id_E434 = 6;
  level._id_3049 = spawnStruct();
  level._id_3049._id_22B1 = getent("camera_mp_gunsmith_preview_optic_alt1", "targetname");
  level._id_3049._id_22B1._id_47FB = [21.5, 17];
  level._id_3049._id_A370 = 36;
  level._id_3049._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3049._id_E434 = 6;
  level.camera_loadout_showcase_preview_optic_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_optic_alt2._id_22B1 = getent("camera_mp_gunsmith_preview_optic_alt2", "targetname");
  level.camera_loadout_showcase_preview_optic_alt2._id_22B1._id_47FB = [21.5, 17];
  level.camera_loadout_showcase_preview_optic_alt2._id_A370 = 36;
  level.camera_loadout_showcase_preview_optic_alt2._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_optic_alt2._id_E434 = 6;
  level.camera_loadout_showcase_preview_optic_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_optic_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_optic_alt3", "targetname");
  level.camera_loadout_showcase_preview_optic_alt3._id_22B1._id_47FB = [21.5, 36];
  level.camera_loadout_showcase_preview_optic_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_optic_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_optic_alt3._id_E434 = 6;
  level.camera_loadout_showcase_preview_optic_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_optic_alt4._id_22B1 = getent("camera_mp_gunsmith_preview_optic_alt4", "targetname");
  level.camera_loadout_showcase_preview_optic_alt4._id_22B1._id_47FB = [21.5, 36];
  level.camera_loadout_showcase_preview_optic_alt4._id_A370 = 36;
  level.camera_loadout_showcase_preview_optic_alt4._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_optic_alt4._id_E434 = 6;
  level._id_304A = spawnStruct();
  level._id_304A._id_22B1 = getent("camera_mp_gunsmith_preview_reargrip", "targetname");
  level._id_304A._id_22B1._id_47FB = [8, 20];
  level._id_304A._id_A370 = 36;
  level._id_304A._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_304A._id_E434 = 6;
  level._id_304B = spawnStruct();
  level._id_304B._id_22B1 = getent("camera_mp_gunsmith_preview_reargrip_alt1", "targetname");
  level._id_304B._id_22B1._id_47FB = [8, 20];
  level._id_304B._id_A370 = 36;
  level._id_304B._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_304B._id_E434 = 6;
  level._id_304C = spawnStruct();
  level._id_304C._id_22B1 = getent("camera_mp_gunsmith_preview_reargrip_alt2", "targetname");
  level._id_304C._id_22B1._id_47FB = [12, 22];
  level._id_304C._id_A370 = 36;
  level._id_304C._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_304C._id_E434 = 6;
  level.camera_loadout_showcase_preview_reargrip_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_reargrip_alt3", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt3._id_22B1._id_47FB = [12, 22];
  level.camera_loadout_showcase_preview_reargrip_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_reargrip_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt3._id_E434 = 6;
  level._id_305A = spawnStruct();
  level._id_305A._id_22B1 = getent("camera_mp_gunsmith_preview_sticker", "targetname");
  level._id_305A._id_22B1._id_47FB = [20, 32];
  level._id_305A._id_A370 = 36;
  level._id_305A._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_305A._id_E434 = 6;
  level._id_305B = spawnStruct();
  level._id_305B._id_22B1 = getent("camera_mp_gunsmith_preview_sticker_alt1", "targetname");
  level._id_305B._id_22B1._id_47FB = [20, 32];
  level._id_305B._id_A370 = 36;
  level._id_305B._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_305B._id_E434 = 6;
  level._id_305C = spawnStruct();
  level._id_305C._id_22B1 = getent("camera_mp_gunsmith_preview_sticker_alt2", "targetname");
  level._id_305C._id_22B1._id_47FB = [20, 34];
  level._id_305C._id_A370 = 36;
  level._id_305C._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_305C._id_E434 = 6;
  level._id_305D = spawnStruct();
  level._id_305D._id_22B1 = getent("camera_mp_gunsmith_preview_sticker_alt3", "targetname");
  level._id_305D._id_22B1._id_47FB = [20, 34];
  level._id_305D._id_A370 = 36;
  level._id_305D._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_305D._id_E434 = 6;
  level._id_305E = spawnStruct();
  level._id_305E._id_22B1 = getent("camera_mp_gunsmith_preview_sticker_alt4", "targetname");
  level._id_305E._id_22B1._id_47FB = [20, 34];
  level._id_305E._id_A370 = 36;
  level._id_305E._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_305E._id_E434 = 6;
  level.camera_loadout_showcase_preview_sticker_alt5 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt5._id_22B1 = getent("camera_mp_gunsmith_preview_sticker_alt5", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt5._id_22B1._id_47FB = [20, 34];
  level.camera_loadout_showcase_preview_sticker_alt5._id_A370 = 36;
  level.camera_loadout_showcase_preview_sticker_alt5._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt5._id_E434 = 6;
  level.camera_loadout_showcase_preview_sticker_alt6 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt6._id_22B1 = getent("camera_mp_gunsmith_preview_sticker_alt6", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt6._id_22B1._id_47FB = [20, 34];
  level.camera_loadout_showcase_preview_sticker_alt6._id_A370 = 36;
  level.camera_loadout_showcase_preview_sticker_alt6._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt6._id_E434 = 6;
  level._id_305F = spawnStruct();
  level._id_305F._id_22B1 = getent("camera_mp_gunsmith_preview_stock", "targetname");
  level._id_305F._id_22B1._id_47FB = [12, 40];
  level._id_305F._id_A370 = 36;
  level._id_305F._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_305F._id_E434 = 6;
  level._id_3060 = spawnStruct();
  level._id_3060._id_22B1 = getent("camera_mp_gunsmith_preview_stock_alt1", "targetname");
  level._id_3060._id_22B1._id_47FB = [12, 40];
  level._id_3060._id_A370 = 36;
  level._id_3060._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3060._id_E434 = 6;
  level._id_3061 = spawnStruct();
  level._id_3061._id_22B1 = getent("camera_mp_gunsmith_preview_stock_alt2", "targetname");
  level._id_3061._id_22B1._id_47FB = [16, 43];
  level._id_3061._id_A370 = 36;
  level._id_3061._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3061._id_E434 = 6;
  level.camera_loadout_showcase_preview_stock_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_stock_alt3", "targetname");
  level.camera_loadout_showcase_preview_stock_alt3._id_22B1._id_47FB = [10, 43];
  level.camera_loadout_showcase_preview_stock_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_stock_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_stock_alt3._id_E434 = 6;
  level.camera_loadout_showcase_preview_stock_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt4._id_22B1 = getent("camera_mp_gunsmith_preview_stock_alt4", "targetname");
  level.camera_loadout_showcase_preview_stock_alt4._id_22B1._id_47FB = [10, 43];
  level.camera_loadout_showcase_preview_stock_alt4._id_A370 = 36;
  level.camera_loadout_showcase_preview_stock_alt4._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_stock_alt4._id_E434 = 6;
  level._id_3062 = spawnStruct();
  level._id_3062._id_22B1 = getent("camera_mp_gunsmith_preview_underbarrel", "targetname");
  level._id_3062._id_22B1._id_47FB = [10, 34];
  level._id_3062._id_A370 = 36;
  level._id_3062._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3062._id_E434 = 6;
  level.camera_loadout_showcase_preview_underbarrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_underbarrel_alt1._id_22B1 = getent("camera_mp_gunsmith_preview_underbarrel_alt1", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt1._id_22B1._id_47FB = [10, 34];
  level.camera_loadout_showcase_preview_underbarrel_alt1._id_A370 = 36;
  level.camera_loadout_showcase_preview_underbarrel_alt1._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt1._id_E434 = 6;
  level.camera_loadout_showcase_preview_underbarrel_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_underbarrel_alt2._id_22B1 = getent("camera_mp_gunsmith_preview_underbarrel_alt2", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt2._id_22B1._id_47FB = [10, 43];
  level.camera_loadout_showcase_preview_underbarrel_alt2._id_A370 = 36;
  level.camera_loadout_showcase_preview_underbarrel_alt2._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt2._id_E434 = 6;
  level.camera_loadout_showcase_preview_underbarrel_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_underbarrel_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_underbarrel_alt3", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt3._id_22B1._id_47FB = [10, 45];
  level.camera_loadout_showcase_preview_underbarrel_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_underbarrel_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt3._id_E434 = 6;
  level.camera_loadout_showcase_preview_underbarrel_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_underbarrel_alt4._id_22B1 = getent("camera_mp_gunsmith_preview_underbarrel_alt4", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt4._id_22B1._id_47FB = [10, 45];
  level.camera_loadout_showcase_preview_underbarrel_alt4._id_A370 = 36;
  level.camera_loadout_showcase_preview_underbarrel_alt4._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt4._id_E434 = 6;
  level.camera_loadout_showcase_preview_underbarrel_alt5 = spawnStruct();
  level.camera_loadout_showcase_preview_underbarrel_alt5._id_22B1 = getent("camera_mp_gunsmith_preview_underbarrel_alt5", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt5._id_22B1._id_47FB = [10, 45];
  level.camera_loadout_showcase_preview_underbarrel_alt5._id_A370 = 36;
  level.camera_loadout_showcase_preview_underbarrel_alt5._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_underbarrel_alt5._id_E434 = 6;
  level._id_304F = spawnStruct();
  level._id_304F._id_22B1 = getent("camera_mp_gunsmith_preview_small_barrel", "targetname");
  level._id_304F._id_22B1._id_47FB = [12, 22.5];
  level._id_304F._id_A370 = 36;
  level._id_304F._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_304F._id_E434 = 6;
  level.camera_loadout_showcase_preview_small_barrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_small_barrel_alt1._id_22B1 = getent("camera_mp_gunsmith_preview_small_barrel_alt1", "targetname");
  level.camera_loadout_showcase_preview_small_barrel_alt1._id_22B1._id_47FB = [12, 22.5];
  level.camera_loadout_showcase_preview_small_barrel_alt1._id_A370 = 36;
  level.camera_loadout_showcase_preview_small_barrel_alt1._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_barrel_alt1._id_E434 = 6;
  level.camera_loadout_showcase_preview_small_barrel_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_small_barrel_alt2._id_22B1 = getent("camera_mp_gunsmith_preview_small_barrel_alt2", "targetname");
  level.camera_loadout_showcase_preview_small_barrel_alt2._id_22B1._id_47FB = [12, 22.5];
  level.camera_loadout_showcase_preview_small_barrel_alt2._id_A370 = 36;
  level.camera_loadout_showcase_preview_small_barrel_alt2._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_barrel_alt2._id_E434 = 6;
  level._id_3050 = spawnStruct();
  level._id_3050._id_22B1 = getent("camera_mp_gunsmith_preview_small_charm", "targetname");
  level._id_3050._id_22B1._id_47FB = [21, 15];
  level._id_3050._id_A370 = 36;
  level._id_3050._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3050._id_E434 = 6;
  level.camera_loadout_showcase_preview_small_gunperk = spawnStruct();
  level.camera_loadout_showcase_preview_small_gunperk._id_22B1 = getent("camera_mp_gunsmith_preview_small_gunperk", "targetname");
  level.camera_loadout_showcase_preview_small_gunperk._id_22B1._id_47FB = [30, 38];
  level.camera_loadout_showcase_preview_small_gunperk._id_A370 = 36;
  level.camera_loadout_showcase_preview_small_gunperk._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_gunperk._id_E434 = 6;
  level._id_3051 = spawnStruct();
  level._id_3051._id_22B1 = getent("camera_mp_gunsmith_preview_small_laser", "targetname");
  level._id_3051._id_22B1._id_47FB = [12, 19];
  level._id_3051._id_A370 = 36;
  level._id_3051._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3051._id_E434 = 6;
  level._id_3052 = spawnStruct();
  level._id_3052._id_22B1 = getent("camera_mp_gunsmith_preview_small_magazine", "targetname");
  level._id_3052._id_22B1._id_47FB = [12, 20];
  level._id_3052._id_A370 = 36;
  level._id_3052._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3052._id_E434 = 6;
  level._id_3053 = spawnStruct();
  level._id_3053._id_22B1 = getent("camera_mp_gunsmith_preview_small_magazine_alt1", "targetname");
  level._id_3053._id_22B1._id_47FB = [12, 20];
  level._id_3053._id_A370 = 36;
  level._id_3053._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3053._id_E434 = 6;
  level.camera_loadout_showcase_preview_small_magazine_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine_alt2._id_22B1 = getent("camera_mp_gunsmith_preview_small_magazine_alt2", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt2._id_22B1._id_47FB = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine_alt2._id_A370 = 36;
  level.camera_loadout_showcase_preview_small_magazine_alt2._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt2._id_E434 = 6;
  level.camera_loadout_showcase_preview_small_magazine_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_small_magazine_alt3", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt3._id_22B1._id_47FB = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_small_magazine_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt3._id_E434 = 6;
  level.camera_loadout_showcase_preview_small_magazine_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine_alt4._id_22B1 = getent("camera_mp_gunsmith_preview_small_magazine_alt4", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt4._id_22B1._id_47FB = [20, 38];
  level.camera_loadout_showcase_preview_small_magazine_alt4._id_A370 = 36;
  level.camera_loadout_showcase_preview_small_magazine_alt4._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt4._id_E434 = 6;
  level._id_3054 = spawnStruct();
  level._id_3054._id_22B1 = getent("camera_mp_gunsmith_preview_small_muzzle", "targetname");
  level._id_3054._id_22B1._id_47FB = [16, 25];
  level._id_3054._id_A370 = 36;
  level._id_3054._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3054._id_E434 = 6;
  level._id_3055 = spawnStruct();
  level._id_3055._id_22B1 = getent("camera_mp_gunsmith_preview_small_optic", "targetname");
  level._id_3055._id_22B1._id_47FB = [20, 15];
  level._id_3055._id_A370 = 36;
  level._id_3055._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3055._id_E434 = 6;
  level._id_3056 = spawnStruct();
  level._id_3056._id_22B1 = getent("camera_mp_gunsmith_preview_small_reargrip", "targetname");
  level._id_3056._id_22B1._id_47FB = [12, 20];
  level._id_3056._id_A370 = 36;
  level._id_3056._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3056._id_E434 = 6;
  level.camera_loadout_showcase_preview_small_reargrip_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_small_reargrip_alt1._id_22B1 = getent("camera_mp_gunsmith_preview_small_reargrip_alt1", "targetname");
  level.camera_loadout_showcase_preview_small_reargrip_alt1._id_22B1._id_47FB = [12, 20];
  level.camera_loadout_showcase_preview_small_reargrip_alt1._id_A370 = 36;
  level.camera_loadout_showcase_preview_small_reargrip_alt1._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_reargrip_alt1._id_E434 = 6;
  level._id_3057 = spawnStruct();
  level._id_3057._id_22B1 = getent("camera_mp_gunsmith_preview_small_sticker", "targetname");
  level._id_3057._id_22B1._id_47FB = [16, 22];
  level._id_3057._id_A370 = 36;
  level._id_3057._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3057._id_E434 = 6;
  level._id_3058 = spawnStruct();
  level._id_3058._id_22B1 = getent("camera_mp_gunsmith_preview_small_stock", "targetname");
  level._id_3058._id_22B1._id_47FB = [16, 36];
  level._id_3058._id_A370 = 36;
  level._id_3058._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3058._id_E434 = 6;
  level._id_3059 = spawnStruct();
  level._id_3059._id_22B1 = getent("camera_mp_gunsmith_preview_small_trigger", "targetname");
  level._id_3059._id_22B1._id_47FB = [21, 12];
  level._id_3059._id_A370 = 36;
  level._id_3059._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3059._id_E434 = 6;
  level._id_302A = spawnStruct();
  level._id_302A._id_22B1 = getent("camera_mp_gunsmith_preview_large_barrel", "targetname");
  level._id_302A._id_22B1._id_47FB = [12, 46];
  level._id_302A._id_A370 = 36;
  level._id_302A._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_302A._id_E434 = 6;
  level._id_302C = spawnStruct();
  level._id_302C._id_22B1 = getent("camera_mp_gunsmith_preview_large_charm", "targetname");
  level._id_302C._id_22B1._id_47FB = [21, 17];
  level._id_302C._id_A370 = 36;
  level._id_302C._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_302C._id_E434 = 6;
  level._id_302D = spawnStruct();
  level._id_302D._id_22B1 = getent("camera_mp_gunsmith_preview_large_charm_alt1", "targetname");
  level._id_302D._id_22B1._id_47FB = [21, 17];
  level._id_302D._id_A370 = 36;
  level._id_302D._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_302D._id_E434 = 6;
  level._id_302E = spawnStruct();
  level._id_302E._id_22B1 = getent("camera_mp_gunsmith_preview_large_charm_alt2", "targetname");
  level._id_302E._id_22B1._id_47FB = [21, 17];
  level._id_302E._id_A370 = 36;
  level._id_302E._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_302E._id_E434 = 6;
  level._id_302B = spawnStruct();
  level._id_302B._id_22B1 = getent("camera_mp_gunsmith_preview_large_barrel_alt1", "targetname");
  level._id_302B._id_22B1._id_47FB = [16, 52];
  level._id_302B._id_A370 = 36;
  level._id_302B._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_302B._id_E434 = 6;
  level.camera_loadout_showcase_preview_large_gunperk = spawnStruct();
  level.camera_loadout_showcase_preview_large_gunperk._id_22B1 = getent("camera_mp_gunsmith_preview_large_gunperk", "targetname");
  level.camera_loadout_showcase_preview_large_gunperk._id_22B1._id_47FB = [30, 90];
  level.camera_loadout_showcase_preview_large_gunperk._id_A370 = 36;
  level.camera_loadout_showcase_preview_large_gunperk._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_gunperk._id_E434 = 6;
  level._id_302F = spawnStruct();
  level._id_302F._id_22B1 = getent("camera_mp_gunsmith_preview_large_laser", "targetname");
  level._id_302F._id_22B1._id_47FB = [12, 26];
  level._id_302F._id_A370 = 36;
  level._id_302F._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_302F._id_E434 = 6;
  level._id_3030 = spawnStruct();
  level._id_3030._id_22B1 = getent("camera_mp_gunsmith_preview_large_magazine", "targetname");
  level._id_3030._id_22B1._id_47FB = [14, 32];
  level._id_3030._id_A370 = 36;
  level._id_3030._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3030._id_E434 = 6;
  level._id_3031 = spawnStruct();
  level._id_3031._id_22B1 = getent("camera_mp_gunsmith_preview_large_magazine_alt1", "targetname");
  level._id_3031._id_22B1._id_47FB = [14, 32];
  level._id_3031._id_A370 = 36;
  level._id_3031._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3031._id_E434 = 6;
  level._id_3032 = spawnStruct();
  level._id_3032._id_22B1 = getent("camera_mp_gunsmith_preview_large_magazine_alt2", "targetname");
  level._id_3032._id_22B1._id_47FB = [14, 32];
  level._id_3032._id_A370 = 36;
  level._id_3032._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3032._id_E434 = 6;
  level.camera_loadout_showcase_preview_large_magazine_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_large_magazine_alt3", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt3._id_22B1._id_47FB = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt3._id_E434 = 6;
  level.camera_loadout_showcase_preview_large_magazine_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt4._id_22B1 = getent("camera_mp_gunsmith_preview_large_magazine_alt4", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt4._id_22B1._id_47FB = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt4._id_A370 = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt4._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt4._id_E434 = 6;
  level.camera_loadout_showcase_preview_large_magazine_alt5 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt5._id_22B1 = getent("camera_mp_gunsmith_preview_large_magazine_alt5", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt5._id_22B1._id_47FB = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt5._id_A370 = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt5._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt5._id_E434 = 6;
  level._id_3033 = spawnStruct();
  level._id_3033._id_22B1 = getent("camera_mp_gunsmith_preview_large_muzzle", "targetname");
  level._id_3033._id_22B1._id_47FB = [12, 46];
  level._id_3033._id_A370 = 36;
  level._id_3033._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3033._id_E434 = 6;
  level._id_3034 = spawnStruct();
  level._id_3034._id_22B1 = getent("camera_mp_gunsmith_preview_large_muzzle_alt1", "targetname");
  level._id_3034._id_22B1._id_47FB = [21, 32];
  level._id_3034._id_A370 = 36;
  level._id_3034._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3034._id_E434 = 6;
  level._id_3035 = spawnStruct();
  level._id_3035._id_22B1 = getent("camera_mp_gunsmith_preview_large_optic", "targetname");
  level._id_3035._id_22B1._id_47FB = [21.5, 25];
  level._id_3035._id_A370 = 36;
  level._id_3035._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3035._id_E434 = 6;
  level.camera_loadout_showcase_preview_large_optic_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_optic_alt1._id_22B1 = getent("camera_mp_gunsmith_preview_large_optic_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_optic_alt1._id_22B1._id_47FB = [21.5, 25];
  level.camera_loadout_showcase_preview_large_optic_alt1._id_A370 = 36;
  level.camera_loadout_showcase_preview_large_optic_alt1._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_optic_alt1._id_E434 = 6;
  level._id_3036 = spawnStruct();
  level._id_3036._id_22B1 = getent("camera_mp_gunsmith_preview_large_reargrip", "targetname");
  level._id_3036._id_22B1._id_47FB = [12, 23];
  level._id_3036._id_A370 = 36;
  level._id_3036._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3036._id_E434 = 6;
  level._id_3037 = spawnStruct();
  level._id_3037._id_22B1 = getent("camera_mp_gunsmith_preview_large_reargrip_alt1", "targetname");
  level._id_3037._id_22B1._id_47FB = [12, 21];
  level._id_3037._id_A370 = 36;
  level._id_3037._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3037._id_E434 = 6;
  level.camera_loadout_showcase_preview_large_reargrip_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_reargrip_alt2._id_22B1 = getent("camera_mp_gunsmith_preview_large_reargrip_alt2", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip_alt2._id_22B1._id_47FB = [12, 21];
  level.camera_loadout_showcase_preview_large_reargrip_alt2._id_A370 = 36;
  level.camera_loadout_showcase_preview_large_reargrip_alt2._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip_alt2._id_E434 = 6;
  level._id_3038 = spawnStruct();
  level._id_3038._id_22B1 = getent("camera_mp_gunsmith_preview_large_sticker", "targetname");
  level._id_3038._id_22B1._id_47FB = [20, 32];
  level._id_3038._id_A370 = 36;
  level._id_3038._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3038._id_E434 = 6;
  level._id_3039 = spawnStruct();
  level._id_3039._id_22B1 = getent("camera_mp_gunsmith_preview_large_sticker_alt1", "targetname");
  level._id_3039._id_22B1._id_47FB = [20, 35];
  level._id_3039._id_A370 = 36;
  level._id_3039._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_3039._id_E434 = 6;
  level._id_303A = spawnStruct();
  level._id_303A._id_22B1 = getent("camera_mp_gunsmith_preview_large_sticker_alt2", "targetname");
  level._id_303A._id_22B1._id_47FB = [20, 32];
  level._id_303A._id_A370 = 36;
  level._id_303A._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_303A._id_E434 = 6;
  level._id_303B = spawnStruct();
  level._id_303B._id_22B1 = getent("camera_mp_gunsmith_preview_large_sticker_alt3", "targetname");
  level._id_303B._id_22B1._id_47FB = [20, 35];
  level._id_303B._id_A370 = 36;
  level._id_303B._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_303B._id_E434 = 6;
  level._id_303C = spawnStruct();
  level._id_303C._id_22B1 = getent("camera_mp_gunsmith_preview_large_stock", "targetname");
  level._id_303C._id_22B1._id_47FB = [16, 43];
  level._id_303C._id_A370 = 36;
  level._id_303C._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_303C._id_E434 = 6;
  level._id_303D = spawnStruct();
  level._id_303D._id_22B1 = getent("camera_mp_gunsmith_preview_large_stock_alt1", "targetname");
  level._id_303D._id_22B1._id_47FB = [16, 43];
  level._id_303D._id_A370 = 36;
  level._id_303D._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_303D._id_E434 = 6;
  level._id_303E = spawnStruct();
  level._id_303E._id_22B1 = getent("camera_mp_gunsmith_preview_large_underbarrel", "targetname");
  level._id_303E._id_22B1._id_47FB = [20, 35];
  level._id_303E._id_A370 = 36;
  level._id_303E._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_303E._id_E434 = 6;
  level._id_303F = spawnStruct();
  level._id_303F._id_22B1 = getent("camera_mp_gunsmith_preview_large_underbarrel_alt1", "targetname");
  level._id_303F._id_22B1._id_47FB = [20, 36];
  level._id_303F._id_A370 = 36;
  level._id_303F._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level._id_303F._id_E434 = 6;
  level.camera_loadout_showcase_preview_large_underbarrel_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel_alt2._id_22B1 = getent("camera_mp_gunsmith_preview_large_underbarrel_alt2", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel_alt2._id_22B1._id_47FB = [20, 36];
  level.camera_loadout_showcase_preview_large_underbarrel_alt2._id_A370 = 36;
  level.camera_loadout_showcase_preview_large_underbarrel_alt2._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel_alt2._id_E434 = 6;
  level.camera_loadout_showcase_preview_large_underbarrel_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel_alt3._id_22B1 = getent("camera_mp_gunsmith_preview_large_underbarrel_alt3", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel_alt3._id_22B1._id_47FB = [16, 50];
  level.camera_loadout_showcase_preview_large_underbarrel_alt3._id_A370 = 36;
  level.camera_loadout_showcase_preview_large_underbarrel_alt3._id_10D06[2] = getent("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel_alt3._id_E434 = 6;
  level._id_3006 = spawnStruct();
  level._id_3006._id_22B1 = getent("char_tango", "targetname");
  level._id_3006._id_22B1._id_47FB = [4.5, 125];
  level._id_3006._id_A370 = 30;
  level._id_3006._id_FB46 = ::_id_FB85;
  level._id_3006._id_E434 = 6;
  level._id_3006.update_lighting = level.frontend_lighting_operator_far;
  level.camera_character_faction_select = spawnStruct();
  level.camera_character_faction_select._id_22B1 = getent("char_west_b_detail", "targetname");
  level.camera_character_faction_select._id_22B1._id_47FB = [14, 75];
  level.camera_character_faction_select._id_A370 = 34;
  level.camera_character_faction_select._id_FB46 = ::_id_FBA1;
  level.camera_character_faction_select._id_E434 = 6;
  level.camera_character_faction_select.update_lighting = level.frontend_lighting_operator_far;
  level.camera_character_faction_select_preview = spawnStruct();
  level.camera_character_faction_select_preview._id_22B1 = getent("char_west_b_preview", "targetname");
  level.camera_character_faction_select_preview._id_22B1._id_47FB = [5, 130];
  level.camera_character_faction_select_preview._id_A370 = 34;
  level.camera_character_faction_select_preview._id_FB46 = ::_id_FBA1;
  level.camera_character_faction_select_preview._id_E434 = 6;
  level.camera_character_faction_select_preview.update_lighting = level.frontend_lighting_operator_close;
  level.camera_character_faction_select_detail = spawnStruct();
  level.camera_character_faction_select_detail._id_22B1 = getent("char_west_b", "targetname");
  level.camera_character_faction_select_detail._id_22B1._id_47FB = [4, 114];
  level.camera_character_faction_select_detail._id_A370 = 34;
  level.camera_character_faction_select_detail._id_FB46 = ::_id_FBA1;
  level.camera_character_faction_select_detail._id_E434 = 6;
  level.camera_character_faction_select_detail.update_lighting = level.frontend_lighting_operator_close;
  level.camera_character_faction_select_animation_preview = spawnStruct();
  level.camera_character_faction_select_animation_preview._id_22B1 = getent("char_west_b", "targetname");
  level.camera_character_faction_select_animation_preview._id_22B1._id_47FB = [4, 114];
  level.camera_character_faction_select_animation_preview._id_A370 = 34;
  level.camera_character_faction_select_animation_preview._id_FB46 = ::_id_FBA1;
  level.camera_character_faction_select_animation_preview._id_E434 = 6;
  level.camera_character_faction_select_animation_preview.update_lighting = level.frontend_lighting_operator_close;
  level._id_3004 = spawnStruct();
  level._id_3004._id_22B1 = getent("char_preview_detail", "targetname");
  level._id_3004._id_22B1._id_47FB = [22, 60];
  level._id_3004._id_A370 = 37;
  level._id_3004._id_33F6 = getent("charroom_char_preview", "targetname");
  level._id_3004._id_E434 = 6;
  level._id_3005 = spawnStruct();
  level._id_3005._id_22B1 = getent("char_preview", "targetname");
  level._id_3005._id_22B1._id_47FB = [22, 181];
  level._id_3005._id_A370 = 37;
  level._id_3005._id_33F6 = getent("charroom_char_preview", "targetname");
  level._id_3005._id_E434 = 6;
  level._id_307B = spawnStruct();
  level._id_307B._id_22B1 = getent("char_store", "targetname");
  level._id_307B._id_22B1._id_47FB = [16, 264];
  level._id_307B._id_A370 = 28;
  level._id_3076 = spawnStruct();
  level._id_3076._id_22B1 = getent("char_quartermaster", "targetname");
  level._id_3076._id_22B1._id_47FB = [16, 264];
  level._id_3076._id_A370 = 28;
  level._id_3077 = spawnStruct();
  level._id_3077._id_22B1 = getent("char_quartermaster_detail", "targetname");
  level._id_3077._id_22B1._id_47FB = [22, 264];
  level._id_3077._id_A370 = 28;
  level._id_306B = spawnStruct();
  level._id_306B._id_22B1 = getent("char_lobby", "targetname");
  level._id_306B._id_22B1._id_47FB = [3.5, 225];
  level._id_306B._id_FB46 = ::update_lobby_char_loc_v2;
  level._id_306B._id_E434 = 6;
  level._id_306B set_lobby_cam_initial_pos();
  level._id_306C = spawnStruct();
  level._id_306C._id_22B1 = getent("char_lobby_detail", "targetname");
  level._id_306C._id_22B1._id_47FB = [4, 55];
  level._id_306C._id_FB46 = ::_id_FB7F;
  level._id_306C._id_E434 = 6;
  level._id_306C adjust_cam_to_tank();
  level._id_3007 = spawnStruct();
  level._id_3007._id_22B1 = getent("char_tournament_overcam", "targetname");
  level._id_3007._id_22B1._id_47FB = [22, 256];
  level._id_3007._id_A370 = 36;
  level._id_3007._id_FB46 = ::_id_FB3A;
  level._id_3003 = spawnStruct();
  level._id_3003._id_22B1 = getent("char_tournament_overcam", "targetname");
  level._id_3003._id_22B1._id_47FB = [22, 256];
  level._id_3003._id_A370 = 36;
  level._id_3003._id_FB46 = ::_id_FB71;
  update_character_select_char_loc();
}

adjust_cam_to_tank() {
  var_0 = self._id_22B1._id_0481;
  var_1 = getent("tank_scene_frontend_s4", "targetname");
  var_2 = get_offset_transform_from_position_table(var_0);
  self._id_22B1 adjust_ent_with_table_data(var_1.origin, var_2);
  self._id_A370 = var_2["Fov"];
  self._id_22B1._id_47FB = [var_2["fStop"], var_2["fDist"]];
}

adjust_ent_with_table_data(var_0, var_1) {
  var_2["pos"] = (var_1["off_x"], var_1["off_y"], var_1["off_z"]);
  var_2["rotation"] = (var_1["off_Rx"], var_1["off_Ry"], var_1["off_Rz"]);
  self.origin = var_0 + var_2["pos"];
  self.angles = (-1 * (var_2["rotation"][0] - 90), var_2["rotation"][2] + 90, var_2["rotation"][1]);
}

get_offset_transform_from_position_table(var_0) {
  var_1 = [];
  var_1["off_x"] = get_frontend_position_data(var_0, 1);
  var_1["off_y"] = get_frontend_position_data(var_0, 2);
  var_1["off_z"] = get_frontend_position_data(var_0, 3);
  var_1["off_Rx"] = get_frontend_position_data(var_0, 4);
  var_1["off_Ry"] = get_frontend_position_data(var_0, 5);
  var_1["off_Rz"] = get_frontend_position_data(var_0, 6);
  var_1["fov"] = get_frontend_position_data(var_0, 7);
  var_1["fStop"] = get_frontend_position_data(var_0, 8);
  var_1["fDist"] = get_frontend_position_data(var_0, 9);
  return var_1;
}

get_frontend_position_data(var_0, var_1) {
  return int(_func_0222("frontEndSceneData/frontendCharacterPositionData.csv", 0, var_0, var_1));
}

_id_D7D1() {
  level.characters = [];

  for(var_0 = 0; var_0 < 8; var_0++) {
    var_1 = undefined;
    var_2 = var_0 + 1;

    if(var_2 < 10) {
      var_1 = getent("lobby_charslot_0" + var_2, "targetname");
    } else {
      var_1 = getent("lobby_charslot_" + var_2, "targetname");
    }

    level.characters[var_0] = spawn("script_character", var_1.origin, 0, 0, var_0, "MPClientCharacter");
  }

  level.characters[14] = spawn("script_character", level.characters[0].origin, 0, 0, 14, "MPClientCharacter");
  level.characters[14].angles = (0, 270, 0);

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_2 = var_3 + 1;
    var_0 = 8 + var_3;
    var_1 = getent("lobby_charslot_0" + var_2 + "_dog", "targetname");
    level.characters[var_0] = spawn("script_character", var_1.origin, 0, 0, var_0, "MPClientCharacter");
  }

  var_4 = getent("weapon_loc_hq1", "targetname");
  level.weapons = [];
  level.weapons[0] = spawn("script_weapon", var_4.origin, 0, 0, 0);
  level.weapons[0].angles = var_4.angles;
  level.weapons[1] = spawn("script_weapon", var_4.origin, 0, 0, 1);
  level.weapons[1].angles = var_4.angles;
  var_5 = getent("weapon_loc_preview", "targetname");
  level.weapons[2] = spawn("script_weapon", var_5.origin, 0, 0, 2);
  level.weapons[2].angles = var_5.angles;
  var_6 = getent("weapon_loc_watch", "targetname");
  level.weapons[3] = spawn("script_weapon", var_6.origin, 0, 0, 3);
  level.weapons[3].angles = var_6.angles;
  level.tankmodel = undefined;
  level._id_F88A = undefined;
  _id_5FD8(level._id_306C._id_22B1.origin, level._id_306C._id_22B1.angles);
}

show_tank_in_lobby_walks(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = getent("tank_scene_frontend_s4", "targetname");

  if(isDefined(var_2)) {
    level.tankmodel = spawn("script_model", var_2.origin);
    level.tankmodel setModel(var_0);
    level.tankmodel.angles = var_2.angles;
    var_3 = get_offset_transform_from_position_table("s4_mp_lobby_walk_tank_model");
    level.tankmodel.origin = level.tankmodel.origin + (var_3["off_x"], var_3["off_y"], var_3["off_z"]);
  }

  var_4 = getent("tank_scene_frontend_s4_turret", "targetname");

  if(isDefined(var_4)) {
    level._id_F88A = spawn("script_model", var_4.origin);
    level._id_F88A setModel(var_1);
    level._id_F88A.angles = var_4.angles;
    var_3 = get_offset_transform_from_position_table("s4_mp_lobby_walk_turret_model");
    level._id_F88A.origin = level._id_F88A.origin + (var_3["off_x"], var_3["off_y"], var_3["off_z"]);
  }
}

_id_6A87() {
  level._id_72A9 = getent("gunbench_bullets", "targetname");
}

_id_5541() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "taunt_started") {
      _id_07B8::_id_C69C();
      var_2 = _func_0222("mp/cac/taunts.csv", 0, var_1, 9);
      _id_07B8::_id_BD6B(var_2, -1, 0);
      continue;
    }

    if(var_0 == "taunt_reset") {
      _id_07B8::_id_C69C();
    }
  }
}

_id_48F0(var_0) {
  foreach(var_2 in level._id_F90A) {
    var_2 hide();
  }

  if(var_0 > 0 && var_0 <= level._id_F90A.size) {
    level._id_F90A[var_0] show();
  }
}

_id_990D() {
  self endon("disconnect");
  _id_6A87();
  level._id_41C2 = 0;

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "loadout_showcase_entered") {
      level._id_2D39 = 1;
      level._id_41C2 = 0;
      continue;
    }

    if(var_0 == "primary_weapon_changed") {
      var_2 = int(var_1);

      if(istrue(level._id_2D39)) {
        level._id_2D39 = 0;
        continue;
      }

      if(level._id_41C2 == 0) {} else {}

      level._id_41C2++;

      if(level._id_41C2 > 3) {
        level._id_41C2 = 1;
      }

      continue;
    }

    if(var_0 == "secondary_weapon_changed") {
      var_2 = int(var_1);
      continue;
    }

    if(var_0 == "set_ui_rarity_image") {
      var_3 = int(var_1);
      _id_48F0(var_3);
      continue;
    }

    if(var_0 == "operator_animation_preview_entered") {
      enter_operator_animation_scene();
      continue;
    }

    if(var_0 == "operator_animation_preview_exited") {
      exit_operator_animation_scene();
      continue;
    }

    if(var_0 == "operator_animation_preview_cancel") {
      stop_operator_animation(1);
      continue;
    }

    if(var_0 == "mvp_highlight_pose") {
      level.characters[0] thread play_operator_animation(var_0, var_1);
      continue;
    }

    if(var_0 == "mvp_highlight_preview") {
      level.characters[0] thread play_operator_animation(var_0, var_1);
      continue;
    }

    if(var_0 == "intro_pose") {
      level.characters[0] thread play_operator_animation(var_0, var_1);
      continue;
    }

    if(var_0 == "intro_preview") {
      level.characters[0] thread play_operator_animation(var_0, var_1);
      continue;
    }

    if(var_0 == "execution_pose") {
      level.characters[0] thread play_operator_animation(var_0, var_1);
      continue;
    }

    if(var_0 == "execution_preview") {
      level.characters[0] thread play_operator_animation(var_0, var_1);
      continue;
    }

    if(var_0 == "lethal_changed") {
      var_4 = int(var_1);
      continue;
    }

    if(var_0 == "tactical_changed") {
      var_5 = int(var_1);
      continue;
    }

    if(var_0 == "current_operator_count") {
      level.charactercount = max(int(var_1), 1);
      continue;
    }

    if(var_0 == "vision_set_override") {
      var_6 = int(var_1);

      switch (var_6) {
        case 0:
          level._id_B812 visionsetnakedforplayer("", 0.1);
          break;
        case 1:
          level._id_B812 visionsetnakedforplayer("mp_frontend_west_b_locked", 0.1);
          break;
      }

      continue;
    }

    if(var_0 == "vision_set_zombies") {}
  }
}

set_frontend_scene_zombies_mode() {
  var_0 = self;
  var_0 visionsetnakedforplayer("mp_frontend_lobby_s3_zombie", 0.1);
}

notifylualinkingiscomplete() {
  wait 1;
  level._id_B812 setclientomnvar("ui_op_anim_prev_enter_notify", 1);
}

enter_operator_animation_scene() {
  if(istrue(level.operatoranimationscene)) {
    return;
  }
  level.operatoranimationscene = 1;
  var_0 = level.characters[0];
  var_1 = level.characters[14];
  var_2 = getent("charroom_char_west_b_fatality", "targetname");
  var_3 = var_2.origin;
  var_4 = var_2.angles;
  level._id_B812 _meth_8863(var_3, (0, var_4[1], 0));

  if(isDefined(level._id_B812._id_3085)) {
    level._id_B812._id_3085 delete();
  }

  var_5 = scripts\mp\team_mvp_characters_util::create_client_character_camera(var_3, var_4, 1);
  level._id_B812._id_3085 = var_5;
  var_0 createlinkent();
  var_1 createlinkent();
  var_0.linkent.origin = var_3;
  var_1.linkent.origin = var_3;
  level.operatorprevieworigin = var_3;
  level.operatorpreviewangles = var_4;
  _func_0428("op_preview");
  _func_032A(65, 0);
  level._id_B812 scripts\mp\team_mvp_characters_util::attach_player_to_camera_view(var_5);
  thread notifylualinkingiscomplete();
}

exit_operator_animation_scene() {
  if(!istrue(level.operatoranimationscene)) {
    return;
  }
  level notify("exit_operator_animation");

  if(istrue(level.playingoperatoranimation)) {
    stop_operator_animation(0);
  }

  var_0 = level.characters[0];
  var_1 = level.characters[14];
  var_0 deletelinkent();
  var_1 deletelinkent();
  level._id_B812 _meth_8060();
  level._id_B812 cameralinkto(level._id_2FF9, "tag_origin");

  if(isDefined(level._id_B812._id_3085)) {
    if(isDefined(level._id_B812._id_3085._id_1792)) {
      level._id_B812._id_3085._id_1792 delete();
    }

    level._id_B812._id_3085 delete();
    level._id_B812._id_3085 = undefined;
  }

  if(isDefined(level.operatoranimationprops)) {
    cleanup_props();
  }

  _id_FBA1();
  _id_FB41();
  _func_01F0(1, 1, 0);
  _func_0428("reset");
  level.operatoranimationscene = 0;
}

stop_operator_animation(var_0) {
  if(!istrue(level.playingoperatoranimation)) {
    return;
  }
  self notify("run_anim_notetracks");
  var_1 = level.characters[0];
  var_2 = level.characters[14];

  if(istrue(var_0)) {
    _func_0130(var_1);
  }

  _func_0130(var_2);
  _func_01F0(1, 1, 0);

  if(isDefined(level.operatoranimationprops)) {
    cleanup_props();
  }

  level.playingoperatoranimation = 0;
}

create_props_and_animate(var_0, var_1, var_2, var_3) {
  if(isDefined(level.operatoranimationprops)) {
    cleanup_props();
  }

  var_4 = strtok(var_0, ",");
  var_5 = undefined;

  if(isDefined(var_1)) {
    var_5 = strtok(var_1, ",");
  }

  level.operatoranimationprops = [];

  foreach(var_9, var_7 in var_4) {
    var_8 = spawn("script_model", var_2);
    var_8 setModel(var_7);
    var_8.angles = var_3;

    if(isDefined(var_5[var_9]) && var_5[var_9] != "" && var_5[var_9] != "none") {
      var_8 _meth_82CC(var_5[var_9], "client_character_prop_anim");
    }

    level.operatoranimationprops = scripts\engine\utility::array_add(level.operatoranimationprops, var_8);
  }
}

cleanup_props() {
  if(isDefined(level.operatoranimationprops)) {
    foreach(var_1 in level.operatoranimationprops) {
      var_1 delete();
    }

    level.operatoranimationprops = undefined;
  }
}

run_delta_motion_on_client_character(var_0, var_1, var_2) {
  self.linkent _meth_82CA();
  self.linkent.origin = var_1;
  self.linkent.angles = var_2;
  self.linkent _meth_82CC(var_0, "clientCharacterAnim");
}

run_anim_notetracks(var_0) {
  self notify("run_anim_notetracks");
  self endon("run_anim_notetracks");
  self endon("entitydeleted");
  var_1 = 100;
  var_2 = 0.5;

  for(;;) {
    self waittill(var_0, var_3);

    if(!_func_0107(var_3)) {
      var_3 = [var_3];
    }

    foreach(var_5 in var_3) {
      if(scripts\engine\utility::is_equal(var_5, "end") || scripts\engine\utility::is_equal(var_5, "slow_stopanim")) {
        var_6 = 100.0 / max(1, var_1);
        _func_0329(0, var_2 / var_6);
        return;
      }

      if(issubstr(var_5, "slow_")) {
        var_7 = strtok(var_5, "_");
        var_8 = var_7[0];
        var_9 = var_7[1];
        var_10 = var_7[2];
        _func_01F0(var_1 / 100.0, int(var_9) / 100.0, float(var_10) / 1000);
        wait(float(var_10) / 1000);
        var_1 = int(var_9);
      }

      if(issubstr(var_5, "dof")) {
        var_7 = strtok(var_5, "_");
        var_8 = var_7[0];
        var_11 = float(var_7[1]);
        var_12 = float(var_7[2]);
        var_13 = 1.0;

        if(isDefined(var_7[3])) {
          var_13 = float(var_7[3]);
        }

        var_14 = 2.0;

        if(isDefined(var_7[4])) {
          var_14 = float(var_7[4]);
        }

        level._id_B812 _meth_8660(var_11, var_12, var_13, var_14);
      }

      if(issubstr(var_5, "change_fov")) {
        var_7 = strtok(var_5, ",");
        var_8 = var_7[0];
        var_15 = int(var_7[1]);
        var_16 = float(var_7[2]);
        _func_032A(var_15, var_16 / 1000);
      }
    }
  }
}

play_operator_animation(var_0, var_1) {
  if(!istrue(level.operatoranimationscene)) {
    enter_operator_animation_scene();
  }

  if(istrue(level.playingoperatoranimation)) {
    stop_operator_animation(0);
  }

  level notify("play_operator_animation");
  level endon("play_operator_animation");
  level endon("exit_operator_animation");
  waitframe();
  level.playingoperatoranimation = 1;
  var_2 = var_0 == "mvp_highlight_pose" || var_0 == "intro_pose" || var_0 == "execution_pose";
  var_3 = 0.0;
  var_4 = 0.2;

  if(var_2) {
    _func_0329(0, var_3);
    wait 0.05;
  }

  var_5 = (0, 0, 0);

  if(var_0 == "mvp_highlight_pose" || var_0 == "mvp_highlight_preview") {
    var_6 = "postMatchFlowAnimations.csv";
    var_5 = (0, 90, 0);
  } else if(var_0 == "intro_pose" || var_0 == "intro_preview")
    var_6 = "postMatchFlowAnimationsIntros.csv";
  else {
    var_6 = "mp_cp/executiontable.csv";
  }

  var_7 = level.characters[0];
  var_8 = level.characters[14];
  var_9 = level.operatorprevieworigin;
  var_10 = level.operatorpreviewangles + var_5;
  var_7.origin = var_9;
  var_7.angles = var_10;
  var_8.origin = var_9;
  var_8.angles = var_10;
  var_11 = (0, 0, 0);

  if(var_6 == "mp_cp/executiontable.csv") {
    var_12 = tablelookupbyrow(var_6, var_1, 1);
  } else {
    var_12 = tablelookupbyrow(var_6, var_1, 0);
  }

  if(var_6 == "mp_cp/executiontable.csv") {
    if(var_2) {
      var_13 = tablelookupbyrow(var_6, var_1, 25);
      var_14 = tablelookupbyrow(var_6, var_1, 26);
      var_15 = tablelookupbyrow(var_6, var_1, 27);
    } else {
      var_13 = tablelookupbyrow(var_6, var_1, 19);
      var_14 = tablelookupbyrow(var_6, var_1, 20);
      var_15 = tablelookupbyrow(var_6, var_1, 21);
    }
  } else if(var_2) {
    var_13 = tablelookupbyrow(var_6, var_1, 12);
    var_14 = tablelookupbyrow(var_6, var_1, 13);
    var_15 = tablelookupbyrow(var_6, var_1, 14);
  } else {
    var_13 = tablelookupbyrow(var_6, var_1, 2);
    var_14 = tablelookupbyrow(var_6, var_1, 3);
    var_15 = tablelookupbyrow(var_6, var_1, 4);
  }

  if(var_2) {
    if(var_6 == "mp_cp/executiontable.csv") {
      var_16 = float(tablelookupbyrow(var_6, var_1, 28));
      var_17 = float(tablelookupbyrow(var_6, var_1, 29));
      var_18 = float(tablelookupbyrow(var_6, var_1, 30));
    } else {
      var_16 = float(tablelookupbyrow(var_6, var_1, 15));
      var_17 = float(tablelookupbyrow(var_6, var_1, 16));
      var_18 = float(tablelookupbyrow(var_6, var_1, 17));
    }

    level._id_B812._id_3085._id_1792 unlink();
    level._id_B812._id_3085._id_1792 linkto(level._id_B812._id_3085, "tag_player", (var_16, var_17, var_18), (0, 90, 0));
  } else if(var_6 == "mp_cp/executiontable.csv" && var_15 == "none") {
    var_19 = getent("charroom_char_west_b_fatality", "targetname");
    _func_032A(65, 0);
    level._id_B812 _meth_8660(29, 22, 50, 50);
    level._id_B812._id_3085 _meth_82CA();
    level._id_B812._id_3085 dontinterpolate();
    level._id_B812._id_3085.origin = var_19.origin;
    level._id_B812._id_3085.angles = (0, var_19.angles[1], 0);
    level._id_B812._id_3085._id_1792 unlink();
    level._id_B812._id_3085._id_1792 linkto(level._id_B812._id_3085, "tag_player", (20, -100, 60), (20, 110, 0));
  } else {
    level._id_B812._id_3085._id_1792 unlink();
    level._id_B812._id_3085._id_1792 linkto(level._id_B812._id_3085, "tag_player", (0, 0, 0), (0, 90, 0));
  }

  if(var_6 == "mp_cp/executiontable.csv") {
    var_20 = "";
    var_21 = "";
  } else if(var_2) {
    var_20 = tablelookupbyrow(var_6, var_1, 18);
    var_21 = tablelookupbyrow(var_6, var_1, 19);
  } else {
    var_20 = tablelookupbyrow(var_6, var_1, 5);
    var_21 = tablelookupbyrow(var_6, var_1, 6);
  }

  if(var_2) {
    var_22 = 65;
    var_23 = 29.3;
    var_24 = 22.0;
    var_25 = scripts\mp\team_mvp_characters_util::get_camera_data_from_ref(var_13);

    if(isDefined(var_25)) {
      if(isDefined(var_25["fov"])) {
        var_22 = var_25["fov"];
      }

      if(isDefined(var_25["fdist"])) {
        var_23 = var_25["fdist"];
      }

      if(isDefined(var_25["fstop"])) {
        var_24 = var_25["fstop"];
      }
    }

    level thread set_mvp_pose_fov_safe(var_22, var_24, var_23, var_4);
  }

  if(var_13 != "" && var_13 != "none") {
    var_7 run_delta_motion_on_client_character(var_13, var_9, var_10);

    if(var_6 != "mp_cp/executiontable.csv") {
      var_7.linkent thread run_anim_notetracks("clientCharacterAnim");
    }
  }

  if(var_14 != "" && var_14 != "none") {
    var_8 run_delta_motion_on_client_character(var_14, var_9, var_10);
  }

  if(var_15 != "" && var_15 != "none") {
    scripts\mp\team_mvp_characters_util::_id_C9B1(level._id_B812._id_3085, var_15, var_9 + var_11, var_10);

    if(var_6 == "mp_cp/executiontable.csv") {
      level._id_B812._id_3085 thread run_anim_notetracks("clientCharacterAnim");
    }
  }

  if(var_20 != "" && var_20 != "none") {
    create_props_and_animate(var_20, var_21, var_9, var_10);
  }
}

set_mvp_pose_fov_safe(var_0, var_1, var_2, var_3) {
  level notify("set_mvp_pose_fov_safe");
  level endon("set_mvp_pose_fov_safe");

  while(scripts\engine\utility::is_equal(level._id_0F2C.name, "character_faction_select_detail")) {
    waitframe();
  }

  _func_032A(var_0, 0);
  level._id_B812 _meth_8660(var_1, var_2, 50, 50);
  _func_0329(1, var_3);
}

createlinkent() {
  deletelinkent();
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  self linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.linkent = var_0;
}

deletelinkent() {
  if(isDefined(self.linkent)) {
    self unlink();
    self.linkent delete();
    self.linkent = undefined;
  }
}

_id_D815() {
  level._id_F90A = [];
  level._id_F90A[1] = getent("weapRarity01", "targetname");
  level._id_F90A[2] = getent("weapRarity02", "targetname");
  level._id_F90A[3] = getent("weapRarity03", "targetname");
  level._id_F90A[4] = getent("weapRarity04", "targetname");
  level._id_F90A[5] = getent("weapRarity05", "targetname");
  level._id_F90A[6] = getent("weapRarity06", "targetname");
  level._id_F90A[7] = getent("weapRarity07", "targetname");
  level._id_C044 = scripts\engine\utility::getstruct("weapRaritySmall", "targetname");
  level._id_C043 = scripts\engine\utility::getstruct("weapRarityMedium", "targetname");
  level._id_C042 = scripts\engine\utility::getstruct("weapRarityLarge", "targetname");
  level._id_C045 = scripts\engine\utility::getstruct("weapRarityWatch", "targetname");
  _id_48F0(0);
}

ee_character_lobby() {
  if(!getdvarint("#x3fa9222871845d722", 0)) {
    return;
  }
  var_0 = getEntArray("ee_character_loc_floor_1", "script_noteworthy");
  var_1 = getEntArray("ee_character_loc_floor_2", "script_noteworthy");

  if(scripts\engine\utility::array_combine(var_0, var_1).size == 0) {
    return;
  }
  var_2 = 80;
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 setModel("c_s4_mp_vbear_01");
  var_4 = undefined;

  for(;;) {
    if(scripts\engine\utility::_id_5C00("floor1")) {
      scripts\engine\utility::_id_5C30("floor1");
    } else {
      scripts\engine\utility::_id_5C24("floor1");
    }

    if(randomint(100) > var_2) {
      continue;
    }
    if(scripts\engine\utility::_id_5C00("floor1")) {
      var_4 = scripts\engine\utility::random(var_1);
    } else {
      var_4 = scripts\engine\utility::random(var_0);
    }

    if(!isDefined(var_4)) {
      continue;
    }
    wait 0.1;
    var_3.origin = var_4.origin;
    var_3.angles = var_4.angles;
    var_3 linkto(var_4);
    var_3 show();
    var_3._id_8AFE = 1;
    var_3 _meth_82CB(var_4._id_1883, "ee_char_anim_notify");

    if(scripts\engine\utility::_id_5C00("floor1")) {
      scripts\engine\utility::_id_5C30("floor1");
      scripts\engine\utility::_id_5C24("floor1");
    } else {
      scripts\engine\utility::_id_5C24("floor1");
      scripts\engine\utility::_id_5C30("floor1");
    }

    if(istrue(var_3._id_8AFE)) {
      var_3 notify("stop_loop");
      var_3 unlink();
      var_3 hide();
      var_3._id_8AFE = 0;
    }
  }
}