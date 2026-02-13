/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2078.gsc
*************************************************/

_id_C9B6(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_0828::_id_6865();

  if(var_2[8] != "") {
    var_7 = strtok(var_2[8], ",");
  } else {
    var_7 = [];
  }

  var_8 = var_2[7];
  var_9 = scripts\mp\class::buildweapon(var_8, var_7, "none", "none");
  var_10 = getcompleteweaponname(var_9);
  var_11 = "none";

  if(scripts\engine\utility::is_equal(var_0, "teamMVP")) {
    var_12 = var_2[9];

    if(var_12 != "none") {
      var_13 = scripts\mp\class::buildweapon(var_12, [], "none", "none");
      var_11 = getcompleteweaponname(var_13);
    }
  }

  var_14 = var_2[21];

  foreach(var_16 in level._id_EF6A[var_1]["players"]) {
    if(scripts\engine\utility::is_equal(var_0, "teamMVP")) {
      var_16 setclientomnvar("ui_wc_anim_type", 0);
    } else {
      var_16 setclientomnvar("ui_wc_anim_type", 1);
    }

    var_16 setclientomnvar("ui_wc_anim_select", var_14);
  }

  if(scripts\engine\utility::is_equal(var_0, "teamMVP")) {
    var_18 = var_6.origin;
    var_19 = var_6.angles + (0, 90, 0);
    var_20 = [var_18, var_18];
    var_21 = [var_19, var_19];
    _id_E0FA(var_1, var_20, var_21, var_0);
    level thread scripts\mp\team_mvp_characters_util::_id_C9B1(level._id_BA33["podium"][var_1], var_2[4], var_6.origin, var_19);
    var_22 = scripts\mp\team_mvp_characters_util::spawn_props_and_animate(var_2, var_6.origin, var_19);
  } else {
    var_20 = [var_6.origin];
    var_21 = [var_6.angles];
    _id_E0FA(var_1, var_20, var_21, var_0);
    level thread scripts\mp\team_mvp_characters_util::_id_C9B1(level._id_BA33["podium"][var_1], var_2[4], var_6.origin, var_6.angles);
    var_22 = scripts\mp\team_mvp_characters_util::spawn_props_and_animate(var_2, var_6.origin, var_6.angles);
  }

  var_23 = undefined;

  for(var_24 = 0; var_24 < level.wcclientcharacters[var_1].size; var_24++) {
    var_25 = var_24 == 0;

    if(var_25) {
      var_26 = var_2[2];
    } else {
      var_26 = var_2[3];
    }

    var_27 = level.wcclientcharacters[var_1][var_24];

    if(scripts\engine\utility::is_equal(var_0, "teamMVP")) {
      var_28 = var_27 scripts\mp\team_mvp_characters_util::run_delta_motion_on_client_character(var_26, var_6.origin, var_6.angles + (0, 90, 0));
    } else {
      var_28 = var_27 scripts\mp\team_mvp_characters_util::run_delta_motion_on_client_character(var_26, var_6.origin, var_6.angles);
    }

    var_28 thread _id_0828::_id_C9CF("clientCharacterAnim", var_1);

    if(var_25) {
      var_23 = var_28;
    }
  }

  var_29 = var_3;

  if(scripts\engine\utility::is_equal(var_0, "teamMVP")) {
    var_30 = [var_29, var_29];
  } else {
    var_30 = [var_29];
  }

  var_31 = 0;

  if(scripts\engine\utility::is_equal(var_0, "teamMVP")) {
    var_31 = level._id_00E9[var_1];
  }

  var_32 = _id_65BF(var_30, var_2, var_10, var_11, var_31);

  if(isDefined(var_29)) {
    foreach(var_16 in level._id_EF6A[var_1]["players"]) {
      var_16 _id_0828::_id_10E57("podium");
      _func_033B(var_16 getentitynumber(), var_32);
    }
  }

  if(isDefined(var_23)) {
    var_23 wait_for_mvp_animation_end();
  }

  if(isDefined(var_4) && !scripts\engine\utility::is_equal(var_0, "pom")) {
    waittillframeend;

    if(getdvarint("#x3cf45e1400e99033b", 1)) {
      for(var_39 = 0; var_39 < int(var_2[20]); var_39++) {
        waitframe();
      }
    }

    var_40 = float(1 / var_5);
    _id_0828::_id_ED9B(var_1, var_4 + 1, var_40, 0.5);

    for(var_39 = 0; var_39 < getdvarint("#x36a652b1014c62f26", 3); var_39++) {
      waitframe();
    }
  } else if(scripts\engine\utility::is_equal(var_0, "pom"))
    level notify("team_mvp_pom_continue");

  foreach(var_27 in level.wcclientcharacters[var_1]) {
    if(scripts\engine\utility::is_equal(var_0, "pom") && !istrue(level.debug_team_mvp_run_all_animations)) {
      var_27 scripts\engine\utility::delaythread(0.5, ::clientcharacterdelaydelete, var_22);
      continue;
    }

    cleanup_mvp_props(var_22);
    var_27 delete();
  }

  level.wcclientcharacters[var_1] = [];
  return var_32;
}

clientcharacterdelaydelete(var_0) {
  if(isDefined(var_0)) {
    cleanup_mvp_props(var_0);
  }

  if(isDefined(self)) {
    self delete();
  }
}

cleanup_mvp_props(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!_func_0458(var_2)) {
      var_2 delete();
    }
  }
}

get_client_character_scene_mvp_weapons(var_0, var_1, var_2) {
  if(var_2[8] != "") {
    var_3 = strtok(var_2[8], ",");
  } else {
    var_3 = [];
  }

  var_4 = var_2[7];
  var_5 = scripts\mp\class::buildweapon(var_4, var_3, "none", "none");
  var_6 = getcompleteweaponname(var_5);

  if(scripts\engine\utility::is_equal(var_0, "teamMVP")) {
    var_7 = var_2[9];

    if(var_7 != "none") {
      var_8 = scripts\mp\class::buildweapon(var_7, [], "none", "none");
      var_9 = getcompleteweaponname(var_8);
      return [var_6, var_9];
    }
  }

  return [var_6];
}

wait_for_mvp_animation_end() {
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

setup_client_characters(var_0) {
  if(!isDefined(level.wcclientcharacters)) {
    level.wcclientcharacters = [];
  }

  if(!isDefined(level.wcclientcharacters[var_0])) {
    level.wcclientcharacters[var_0] = [];
  }

  foreach(var_2 in level.wcclientcharacters[var_0]) {
    var_2 delete();
  }

  level.wcclientcharacters[var_0] = [];

  if(!isDefined(level._id_00E9)) {
    level._id_00E9 = [];
  }

  if(!isDefined(level._id_00E9[var_0])) {
    level._id_00E9[var_0] = 0;
  }
}

_id_E0FA(var_0, var_1, var_2, var_3) {
  setup_client_characters(var_0);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = 0;

    if(scripts\engine\utility::is_equal(var_3, "teamMVP")) {
      level._id_00E9[var_0]++;

      if(level._id_00E9[var_0] >= 20) {
        level._id_00E9[var_0] = 0;
      }

      var_5 = level._id_00E9[var_0];
    }

    var_6 = spawn("script_character", var_1[var_4], 0, 0, var_5, "MPClientCharacter");
    var_6.angles = var_2[var_4];
    level.wcclientcharacters[var_0][level.wcclientcharacters[var_0].size] = var_6;

    foreach(var_8 in level.players) {
      if(!scripts\engine\utility::is_equal(var_0, var_8.pers["team"])) {
        var_6 hidefromplayer(var_8);
      }
    }
  }
}

_id_65BF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_6 == 0;
    var_8 = var_0.size == 2;
    var_9 = var_0[var_6];
    var_10 = spawnStruct();

    if(var_8) {
      var_11 = "teamMVP";
    } else {
      var_11 = "pom";
    }

    if(var_7 && getDvar(debuggetoperatoroverridedvarname(var_11), "") != "") {
      var_12 = getDvar(debuggetoperatoroverridedvarname(var_11), "");
      [var_10._id_009D, var_10._id_0218] = get_customization_indicies_from_skin(var_12);
    } else if(var_7)
      [var_10._id_009D, var_10._id_0218] = get_indicies_from_customization(var_9._id_AC3D);
    else {
      [var_10._id_009D, var_10._id_0218] = get_customization_indicies_from_skin(var_1[10], 1);
    }

    if(var_7 && var_8) {
      var_10._id_00E9 = var_4 - 1;
    } else {
      var_10._id_00E9 = var_4;
    }

    if(var_6 == 0) {
      var_10._id_04FE = var_2;
    } else if(isDefined(var_3)) {
      if(var_3 != "none") {
        var_10._id_04FE = var_3;
      } else {
        var_10._id_04FE = "s4_me_fists_mp";
      }
    }

    var_10._id_00E7 = var_9 _meth_8587();
    var_10.name = var_9.name;
    var_10._id_0509 = var_9 getxuid();
    var_10._id_39A3 = var_9 getentitynumber();
    var_10._id_B991 = var_5.size;
    var_5[var_5.size] = var_10;
  }

  return var_5;
}

get_customization_indicies_from_skin(var_0, var_1) {
  [var_3, var_4] = get_models_for_skin(var_0);
  var_5 = int(_func_0222("mp/cac/bodies.csv", 1, var_3, 0));
  var_6 = int(_func_0222("mp/cac/heads.csv", 1, var_4, 0));
  return [var_5, var_6];
}

get_indicies_from_customization(var_0) {
  var_1 = var_0._id_75DA;
  var_2 = var_0._id_25CA;
  var_3 = int(_func_0222("mp/cac/bodies.csv", 1, var_2, 0));
  var_4 = int(_func_0222("mp/cac/heads.csv", 1, var_1, 0));
  return [var_3, var_4];
}

get_models_for_skin(var_0) {
  if(getdvarint("#x3d26e55a89fd9c8fd", 1)) {
    var_1 = _func_0222("loot/operator_skin_ids.csv", 1, var_0, 13);
    var_2 = _func_0222("loot/operator_skin_ids.csv", 1, var_0, 12);
  } else {
    var_1 = _func_0222("operatorskins.csv", 1, var_0, 4);
    var_2 = _func_0222("operatorskins.csv", 1, var_0, 5);
  }

  return [var_1, var_2];
}

skipplayerbotfinalkillcam(var_0) {
  return isbot(var_0) && !getdvarint("#x32b3a6dafd5d6b2bd", 0);
}

debuggetoperatoroverridedvarname(var_0) {
  return _func_0483("#x3e97e21b5b6b442a1", var_0);
}