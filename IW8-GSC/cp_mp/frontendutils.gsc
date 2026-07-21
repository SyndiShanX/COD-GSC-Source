/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\frontendutils.gsc
***********************************************/

_id_131E2() {
  level._id_13370 = getdvarint("_encstr_B1D10A35D3275A4141058A25", 0);
  level.playerwaitilllongholdmelee = ::juggernaut_kills_tracker;
  level.playerwaittillspectatecycle = ::juggernaut_shouldexecute;
  level.playerwaittillcinematiccomplete = ::juggernaut_logic;
}

juggernaut_kills_tracker() {
  wait 0.1;
  waittillframeend;
  level.player_setsunshadowsforzoom = getEnt("_encstr_A1F8123568DF805F20E352879A59606A8AA6EA57", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.player_setsunshadowsforzoom.helidrivableenablesiteondeath = getEntArray("_encstr_93CC11D574CD68367707DB1EDA536D68A3D545", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.player_setsunshadowsforzoom.lights = getEntArray("_encstr_A30F10A0C9308D88AE308271D940E74258C7", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.player_standing_in_doorway = getEnt("_encstr_99F812AD077D1B7B9889F2F599D8EDDE39BE818C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.player_standing_in_doorway.helidrivableenablesiteondeath = getEntArray("_encstr_AB2511E64990C7EACFEA47A9489163E3ABA57A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.player_standing_in_doorway.lights = getEntArray("_encstr_8A8C10ADD392D0F82F7A3B6E95F1989BFB07", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(level.player_setsunshadowsforzoom.helidrivableenablesiteondeath.size)
    scripts\engine\utility::array_call(level.player_setsunshadowsforzoom.helidrivableenablesiteondeath, ::linkto, level.player_setsunshadowsforzoom);

  if(level.player_standing_in_doorway.helidrivableenablesiteondeath.size)
    scripts\engine\utility::array_call(level.player_standing_in_doorway.helidrivableenablesiteondeath, ::linkto, level.player_standing_in_doorway);

  var_0 = scripts\engine\utility::array_combine(level.player_setsunshadowsforzoom.lights, level.player_standing_in_doorway.lights);

  foreach(var_2 in var_0)
  var_2.originalpos = var_2.origin;

  var_4 = level.player_setsunshadowsforzoom.origin;
  var_5 = level.player_standing_in_doorway.origin;
  var_6 = distance(var_4, var_5);
  var_7 = 36.96;
  var_8 = var_6 / var_7;
  var_9 = var_4 + vectorNormalize(var_4 - var_5) * var_6;
  var_10 = vectorNormalize(var_4 - var_5) * var_6;
  var_11 = 1;

  for(;;) {
    if(var_11) {
      var_12 = level.player_standing_in_doorway;
      var_13 = level.player_setsunshadowsforzoom;
    } else {
      var_12 = level.player_setsunshadowsforzoom;
      var_13 = level.player_standing_in_doorway;
    }

    var_14 = (0, 0, -1000);
    var_12 hide();
    var_12.origin = var_12.origin + var_14;
    waitframe();

    if(var_11) {
      foreach(var_2 in var_12.lights)
      var_2.origin = var_2.originalpos;
    } else {
      foreach(var_2 in var_12.lights)
      var_2.origin = var_2.origin + var_10 * -2;
    }

    var_12.origin = var_5 + var_14;
    waitframe();
    var_12.origin = var_5;
    var_12 show();
    var_12 moveTo(var_4, var_8);

    foreach(var_2 in var_12.lights)
    var_2 moveTo(var_2.origin + var_10, var_8);

    var_13 moveTo(var_9, var_8);

    foreach(var_2 in var_13.lights)
    var_2 moveTo(var_2.origin + var_10, var_8);

    var_11 = !var_11;
    wait(var_8);
  }
}

juggernaut_shouldexecute() {
  if(level._id_13370) {
    var_0 = getscriptablearray("_encstr_832918C03B9F2001B245E5605BDA414EEB07E8209B3C19E5CAAF", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(!var_0.size)
      var_0 = getentitylessscriptablearrayinradius("_encstr_832918C03B9F2001B245E5605BDA414EEB07E8209B3C19E5CAAF", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    var_1 = "_encstr_8A6C08B6E0C6DE89C42F";
    var_2 = "_encstr_B1C5099B2BC2CDF6370B1B";

    if(var_0.size) {
      foreach(var_4 in var_0) {
        if(var_4 getscriptablehaspart(var_1)) {
          if(var_4 getscriptableparthasstate(var_1, var_2))
            var_4 setscriptablepartstate(var_1, var_2);
        }
      }
    }

    var_6 = getEntArray("_encstr_A93F0C737B739BCA85DCBD9B1636", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(var_6.size) {
      foreach(var_8 in var_6)
      var_8 hide();

      return;
    }
  } else {
    var_10 = getEntArray("_encstr_B1C5099B2BC2CDF6370B1B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(var_10.size) {
      foreach(var_12 in var_10)
      var_12 hide();
    }
  }
}

juggernaut_logic() {
  var_0 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
  var_1 = "_encstr_974C0246";
  var_2 = "_encstr_B1C5099B2BC2CDF6370B1B";
  var_3 = "_encstr_A93F0C737B739BCA85DCBD9B1636";
  var_4 = [];
  var_4[var_4.size] = getEnt("_encstr_A1F8123568DF805F20E352879A59606A8AA6EA57", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4[var_4.size] = getEnt("_encstr_99F812AD077D1B7B9889F2F599D8EDDE39BE818C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_11DBC = [];
  var_5 = scripts\engine\utility::getStructArray("_encstr_AF070EF92867508823EF8D971F9A4EB8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_5.size) {
    foreach(var_7 in var_5) {
      var_8 = 0;

      if(isDefined(var_7.script_noteworthy)) {
        var_9 = strtok(var_7.script_noteworthy, var_1);

        if(var_9.size == 1)
          var_8 = 1;
        else if(level._id_13370) {
          if(!scripts\engine\utility::array_contains(var_9, var_3))
            var_8 = 1;
        } else if(!scripts\engine\utility::array_contains(var_9, var_2))
          var_8 = 1;

        if(scripts\engine\utility::array_contains_key(level._effect, var_9[0])) {
          if(!var_8) {
            continue;
          }
          var_10 = level._id_11DBC.size;
          level._id_11DBC[var_10] = scripts\engine\utility::spawn_tag_origin();
          level._id_11DBC[var_10].origin = var_7.origin;

          if(isDefined(var_7.angles))
            level._id_11DBC[var_10].angles = var_7.angles;

          level._id_11DBC[var_10].fxname = var_9[0];
          level._id_11DBC[var_10] show();

          if(isDefined(var_7.script_label) && var_7.script_label == "_encstr_93720BF03FEE96A382F3D3688F") {
            continue;
          }
          var_11 = scripts\engine\utility::getclosest(var_7.origin, var_4);
          level._id_11DBC[var_10] linkTo(var_11);
        } else
          iprintln("_encstr_8AC0158CFD5E601842BACDF9D26B5DE0F55613A9E6A4E2" + var_7.origin + "_encstr_BD5F37C243693B4E8DE056BADE9D12E013510377784177E2CD054C3097414AB138B097EB4891CC2A4197466D2D25A24C88813F43389113E39B");

        continue;
      }

      iprintln("_encstr_8AC0158CFD5E601842BACDF9D26B5DE0F55613A9E6A4E2" + var_7.origin + "_encstr_BD5F37C243693B4E8DE056BADE9D12E013510377784177E2CD054C3097414AB138B097EB4891CC2A4197466D2D25A24C88813F43389113E39B");
    }
  }

  var_13 = 0.2;
  wait(var_13);

  if(level._id_11DBC.size) {
    foreach(var_15 in level._id_11DBC) {
      playFXOnTag(scripts\engine\utility::getfx(var_15.fxname), var_15, var_0);
      wait(var_13);
    }
  }
}

playersetisbecomingzombie() {
  level thread[[level.playerwaitilllongholdmelee]]();
}

playersetiszombie() {
  level thread[[level.playerwaittillspectatecycle]]();
}

playersetispropgameextrainfo() {
  level thread[[level.playerwaittillcinematiccomplete]]();
}

frontend_camera_setup(var_0, var_1) {
  level.camera_anchor = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  level.camera_anchor setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.camera_anchor.angles = var_1;
}

frontend_camera_watcher(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self cameralinkTo(level.camera_anchor, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.active_section = frontendscenegetactivesection();
  [[var_0]](level.active_section);
  waitframe();

  for(;;) {
    var_1 = frontendscenegetactivesection();

    if(var_1.name == level.active_section.name && var_1.index == level.active_section.index) {
      if(level.active_section.name == getDvar("_encstr_B68B0B9325629615A425A62DB4"))
        stopclientexploder();

      waitframe();
      continue;
    }

    level.active_section = var_1;
    [[var_0]](var_1);
  }
}

camera_section_change(var_0) {
  if(var_0.name == "_encstr_B40101") {
    return;
  }
  var_1 = get_section_state(var_0);

  if(!isDefined(var_1["_encstr_99FB066E36959B2B"]) || !isDefined(var_1["_encstr_8B92075E3753DAE2B9"])) {
    return;
  }
  set_active_camera(var_1["_encstr_99FB066E36959B2B"], var_1["_encstr_8B92075E3753DAE2B9"]);
  execute_transition(var_0, level.currentsectionname);
  level.currentsectionname = var_0.name;
}

set_active_camera(var_0, var_1) {
  level.active_scene_data = var_0;
  level.active_camera = var_1;
}

execute_transition(var_0, var_1) {
  var_2 = !isDefined(level.active_scene_data) || level.transition_interrupted;

  if(var_2)
    thread frontend_camera_teleport(level.active_camera, level.active_scene_data.myfov, level.active_scene_data.cinematic, 0, 0.2, ::update_entities_and_camera);

  var_3 = level.transitionarray;
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

  if(isDefined(var_3[var_0.name])) {
    var_15 = var_3[var_0.name];
    var_16 = var_15["_encstr_8B1608EC43B8D647A113"];

    if(isDefined(var_1) && isDefined(var_15[var_1])) {
      var_6 = var_15[var_1]["_encstr_A7AA09C616D81B26586CB5"];
      var_5 = var_15[var_1]["_encstr_A918040DAF23"];
      var_4 = var_15[var_1]["_encstr_928A060723B255C8"];
      var_8 = var_15[var_1]["_encstr_A2060C84D92B115F9B8B719032B7"];
      var_9 = var_15[var_1]["_encstr_81F90B66C3205F2F389F8AF281"];
      var_10 = var_15[var_1]["_encstr_BACB0E88A4A86AEA0860F05BB01E71D5"];
      var_11 = var_15[var_1]["_encstr_8A920C99AB4948AA893B77886203"];
      var_12 = var_15[var_1]["_encstr_B2B20C8591A8C7F4EE968734EE3D"];
      var_13 = var_15[var_1]["_encstr_A6BE09418F7C50B1873207"];
      var_14 = var_15[var_1]["_encstr_B41C0BABCD2BBE13BD5D738D56"];

      if(isDefined(var_15[var_1]["_encstr_8F5B0B6405C72BFB53CB58E790"]))
        var_7 = var_15[var_1]["_encstr_8F5B0B6405C72BFB53CB58E790"];
    }

    var_6 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, var_16["_encstr_A7AA09C616D81B26586CB5"]);

    if(!isDefined(var_7)) {
      var_7 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, var_16["_encstr_8F5B0B6405C72BFB53CB58E790"]);
      var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, var_16["_encstr_A918040DAF23"]);
      var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, var_16["_encstr_928A060723B255C8"]);
      var_8 = scripts\engine\utility::ter_op(isDefined(var_8), var_6, var_16["_encstr_A2060C84D92B115F9B8B719032B7"]);
      var_9 = scripts\engine\utility::ter_op(isDefined(var_9), var_5, var_16["_encstr_81F90B66C3205F2F389F8AF281"]);
      var_10 = scripts\engine\utility::ter_op(isDefined(var_10), var_10, var_16["_encstr_BACB0E88A4A86AEA0860F05BB01E71D5"]);
      var_11 = scripts\engine\utility::ter_op(isDefined(var_11), var_11, var_16["_encstr_8A920C99AB4948AA893B77886203"]);
      var_12 = scripts\engine\utility::ter_op(isDefined(var_12), var_12, var_16["_encstr_B2B20C8591A8C7F4EE968734EE3D"]);
      var_13 = scripts\engine\utility::ter_op(isDefined(var_13), var_13, var_16["_encstr_A6BE09418F7C50B1873207"]);
      var_14 = scripts\engine\utility::ter_op(isDefined(var_14), var_14, var_16["_encstr_B41C0BABCD2BBE13BD5D738D56"]);
    }
  } else {
    var_7 = ::frontend_camera_teleport;
    var_6 = ::update_camera_depth_of_field;
  }

  if(var_7 == ::frontend_camera_teleport) {
    var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, level.active_scene_data.myfov);
    var_8 = scripts\engine\utility::ter_op(isDefined(var_8), var_8, 0.2);
    var_9 = scripts\engine\utility::ter_op(isDefined(var_9), var_9, 0.2);
    var_10 = scripts\engine\utility::ter_op(isDefined(var_10), var_10, level.active_scene_data.cinematic);
    [[var_7]](level.active_camera, var_5, var_10, var_8, var_9, var_6);
  } else if(var_7 == ::frontend_camera_move) {
    var_11 = scripts\engine\utility::ter_op(isDefined(var_11), var_11, 0.1);
    var_12 = scripts\engine\utility::ter_op(isDefined(var_12), var_12, 0.1);
    var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, 5000);
    var_14 = scripts\engine\utility::ter_op(isDefined(var_14), var_14, 0);
    var_13 = scripts\engine\utility::ter_op(isDefined(var_13), var_13, 0);
    update_camera_depth_of_field();

    if(var_6 == ::update_camera_depth_of_field && !level.playerviewowner usinggamepad())
      var_6 = ::update_camera_depth_of_field_slowly;

    [[var_7]](level.active_camera, var_4, 0, 1, var_6, var_11, var_12, var_14, var_13);
  } else {}
}

camera_move_helper(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.playerviewowner predictstreampos(var_0.origin);

  if(var_1 < 0.05)
    var_1 = 0.05;

  var_6 = 0.0;
  var_7 = 0.0;

  if(var_2) {
    var_6 = var_1 * var_3;
    var_7 = var_1 * var_4;
  }

  if(var_5) {
    var_8 = 1.3;
    var_9 = vectorNormalize(var_0.origin - level.camera_anchor.origin);
    var_10 = var_0.origin + var_9 * var_8;
    var_11 = var_1 / 2.0;
    var_12 = var_11 * 0.0;
    var_13 = var_11 * 0.5;
    var_14 = var_11 * 0.5;
    var_15 = var_11 * 0.0;
    level.camera_anchor moveTo(var_10, var_11, var_12, var_13);
    level.camera_anchor rotateTo(var_0.angles, var_11, var_12, var_13);
    wait(var_11);
    level.camera_anchor moveTo(var_0.origin, var_11, var_14, var_15);
    wait(var_11);
  } else {
    level.camera_anchor.move_target = var_0;
    level.camera_anchor moveTo(var_0.origin, var_1, var_6, var_7);
    level.camera_anchor rotateTo(var_0.angles, var_1, var_6, var_7);

    if(level.playerviewowner usinggamepad())
      wait(var_1);
  }
}

frontend_camera_move(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.camera_anchor.move_target)) {
    level.camera_anchor.origin = level.camera_anchor.move_target.origin;
    level.camera_anchor.angles = level.camera_anchor.move_target.angles;
  }

  level notify("_encstr_AF7A0CE04345DDE3A16715FF2C50");
  level endon("_encstr_AF7A0CE04345DDE3A16715FF2C50");

  if(!isDefined(var_1))
    var_1 = 900;

  var_9 = var_0;

  if(var_8 == 0 || level.playerviewowner usinggamepad()) {
    var_10 = distance(level.camera_anchor.origin, var_9.origin);
    var_8 = var_10 / var_1;
  }

  if(var_2) {
    level.camera_anchor.origin = var_9.origin;
    level.camera_anchor.angles = var_9.angles;
  } else
    camera_move_helper(var_9, var_8, var_3, var_5, var_6, var_7);

  var_11 = var_5 + var_6;

  if(var_11 > 1.0) {
    var_5 = var_5 / var_11;
    var_6 = var_6 / var_11;
  }

  while(isDefined(var_9.target)) {
    if(!isDefined(var_9.target)) {
      return;
    }
    var_9 = getEnt(var_9.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    camera_move_helper(var_9, var_8, var_3, var_5, var_6, var_7);
  }

  level.camera_anchor.move_target = undefined;

  if(isDefined(var_4))
    self thread[[var_4]]();

  stopclientexploder();
}

frontend_camera_teleport(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level notify("_encstr_9B2A104B9788B782DBE94B52983BFA678385");
  level endon("_encstr_9B2A104B9788B782DBE94B52983BFA678385");
  level.playerviewowner predictstreampos(var_0.origin);
  level.transition_interrupted = 1;
  frontendscenecamerafade(0, var_3);
  wait(var_3 + 0.05);
  frontendscenecamerafov(var_1, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_0.origin;
  level.camera_anchor.angles = var_0.angles;
  level.camera_anchor.move_target = undefined;

  if(isDefined(var_2))
    frontendscenecameracinematic(var_2);

  wait 0.1;

  if(isDefined(var_5))
    [[var_5]]();

  frontendscenecamerafade(1, var_4);
  level.transition_interrupted = 0;
  stopclientexploder();
}

update_character_pos() {
  if(isDefined(level.active_scene_data.update_char_loc))
    [[level.active_scene_data.update_char_loc]]();
  else if(isDefined(level.active_scene_data.char_loc)) {
    var_0 = 0;

    if(isDefined(level.active_scene_data.char_index))
      var_0 = level.active_scene_data.char_index;

    level.characters[var_0].origin = level.active_scene_data.char_loc.origin;
    level.characters[var_0].angles = level.active_scene_data.char_loc.angles;
  }
}

update_player_character_showcase() {
  update_character_pos();
  update_weapon_loc();
  update_camera_depth_of_field();
  _id_13FB2();
}

update_camera_depth_of_field() {
  var_0 = level.active_camera.depthoffieldvalues;
  self setphysicaldepthoffield(var_0[0], var_0[1], 20, 20);
}

update_camera_depth_of_field_slowly() {
  var_0 = level.active_camera.depthoffieldvalues;
  self setphysicaldepthoffield(var_0[0], var_0[1], 3, 3);
}

update_entities_and_camera() {
  update_character_pos();
  update_weapon_loc();
  update_camera_depth_of_field();
  _id_13FB2();
  _id_13FB3();
}

_id_13FB2() {
  if(isDefined(level.active_scene_data._id_1370F))
    setDvar("_encstr_BE360B89A215A69A0AD229B47A", level.active_scene_data._id_1370F);
  else
    setDvar("_encstr_BE360B89A215A69A0AD229B47A", 8);
}

_id_13FB3() {
  if(isDefined(level.active_scene_data._id_13710))
    setDvar("_encstr_951B0A09D411091BCB9B5129", level.active_scene_data._id_13710);
  else
    setDvar("_encstr_951B0A09D411091BCB9B5129", 6);
}

move_weapon_to_loc(var_0) {
  level.weapons[var_0].origin = level.active_scene_data.weapon_locs[var_0].origin;
  level.weapons[var_0].angles = level.active_scene_data.weapon_locs[var_0].angles;
}

update_weapon_loc() {
  if(isDefined(level.active_scene_data.weapon_locs)) {
    if(isarray(level.active_scene_data.weapon_locs)) {
      for(var_0 = 0; var_0 <= 3; var_0++) {
        if(isDefined(level.active_scene_data.weapon_locs[var_0]))
          move_weapon_to_loc(var_0);
      }
    }
  }
}

update_arena_char_loc() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    if(var_0 < 4.0)
      var_1 = getEnt("_encstr_AF4819A37B5DE49CF6BDADFA8D345893CDD8F68ED76395998ED718" + (var_0 + 1), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else {
      var_2 = var_0 - 4.0;
      var_1 = getEnt("_encstr_8AC61A0CA7D0E24B30604269C99B3F5A48399F74AFB06CD76BFB79A7" + (var_2 + 1), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    }

    level.characters[var_0].origin = var_1.origin;
    level.characters[var_0].angles = var_1.angles;
  }

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = var_3 + 1;
    var_0 = 8 + var_3;

    if(var_4 <= 2.0)
      var_1 = getEnt("_encstr_AF4819A37B5DE49CF6BDADFA8D345893CDD8F68ED76395998ED718" + var_4 + "_encstr_9A4305D962FDE7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else {
      var_5 = var_4 - 2.0;
      var_1 = getEnt("_encstr_8AC61A0CA7D0E24B30604269C99B3F5A48399F74AFB06CD76BFB79A7" + var_5 + "_encstr_9A4305D962FDE7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    }

    level.characters[var_0].origin = var_1.origin;
    level.characters[var_0].angles = var_1.angles;
  }
}

_id_13F87() {
  for(var_0 = 0; var_0 < 12; var_0++) {
    if(var_0 < 6.0)
      var_1 = getEnt("_encstr_AF4819A37B5DE49CF6BDADFA8D345893CDD8F68ED76395998ED718" + (var_0 + 1), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else {
      var_2 = var_0 - 6.0;
      var_1 = getEnt("_encstr_8AC61A0CA7D0E24B30604269C99B3F5A48399F74AFB06CD76BFB79A7" + (var_2 + 1), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    }

    level.characters[var_0].origin = var_1.origin;
    level.characters[var_0].angles = var_1.angles;
  }
}

update_lobby_char_loc() {
  var_0 = getEnt("_encstr_879D12D520D8AA53107F132F452E4AEFD08E5A0A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.characters[0].origin = var_0.origin;
  level.characters[0].angles = var_0.angles;

  for(var_1 = 1; var_1 < 8; var_1++) {
    var_2 = var_1 + 1;

    if(var_2 < 10)
      var_0 = getEnt("_encstr_8C1611BBD73622790199F4BE9348A44A951F52" + var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else
      var_0 = getEnt("_encstr_A36810B460995B9077D83AA238478D37F3C0" + var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_0)) {
      level.characters[var_1].origin = var_0.origin;
      level.characters[var_1].angles = var_0.angles;
    }
  }

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_2 = var_3 + 1;
    var_1 = 8 + var_3;
    var_0 = getEnt("_encstr_8C1611BBD73622790199F4BE9348A44A951F52" + var_2 + "_encstr_9A4305D962FDE7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.characters[var_1].origin = var_0.origin;
    level.characters[var_1].angles = var_0.angles;
  }
}

update_main_menu_char_loc() {
  var_0 = getEnt("_encstr_8BE7191773C2EE488F3D401E26601826D9EB8B85F78A2088D9126B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.characters[12].origin = var_0.origin;
  level.characters[12].angles = var_0.angles;
  var_0 = getEnt("_encstr_845D19413451A00ECAFF93EFD7E2DFE8D78B89781FB7114442E7A9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.characters[13].origin = var_0.origin;
  level.characters[13].angles = var_0.angles;
}

_id_13FA5() {
  var_0 = getEnt("_encstr_8BC21503B168FAA3D898AA71E1A327324127BD9B11F186", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.characters[0].origin = var_0.origin;
  level.characters[0].angles = var_0.angles;
  level.characters[8].origin = var_0.origin;
  level.characters[8].angles = var_0.angles;
}

_id_13FA4() {
  var_0 = getEnt("_encstr_8A421578730B5ABB484F786976530F4A17ED16AFBB4731", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.characters[1].origin = var_0.origin;
  level.characters[1].angles = var_0.angles;
  level.characters[9].origin = var_0.origin;
  level.characters[9].angles = var_0.angles;
}

_id_12A0D(var_0) {
  switch (var_0) {
    case "_encstr_A972062F7FDAF9B0":
      foreach(var_2 in level.ui_bg_images_2d)
      var_2.origin = level._id_12A10.origin;

      break;
    case "_encstr_AB5E07609A5B7368E5":
      foreach(var_2 in level.ui_bg_images_2d)
      var_2.origin = level._id_12A0F.origin;

      break;
    case "_encstr_8DEC06B1E943615B":
      foreach(var_2 in level.ui_bg_images_2d)
      var_2.origin = level._id_12A0E.origin;

      break;
    case "_encstr_BD4C06DB81953FAC":
      foreach(var_2 in level.ui_bg_images_2d)
      var_2.origin = level._id_12A11.origin;

      break;
  }
}

initialize_transition_array() {
  var_0 = [];
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"] = [];
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_8B1608EC43B8D647A113"] = [];
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = 36;
  var_1 = [];
  var_1["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_1["_encstr_A7AA09C616D81B26586CB5"] = ::update_camera_depth_of_field;
  var_1["_encstr_928A060723B255C8"] = 200;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_839F10EFFB9F2B4750F6CA14E84093F26E03"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_1;
  var_0["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_1;
  var_2 = [];
  var_2["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_2["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_2["_encstr_A2060C84D92B115F9B8B719032B7"] = 0.05;
  var_2["_encstr_81F90B66C3205F2F389F8AF281"] = 0.05;
  var_2["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_A143208965AA7158C57B599B33E793B7728AF5983A33CB23B1571069F3010BCD5AF5"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_BDCD2536BDC2C8ED5D47FAB91A7BBB1B0BB9957D0793593BA5CAEEF54C5893C9ACD8FAC2C61D62"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_87CD25B1BDC223F6AE8ED7B943DE77C6B0B956FA0EE495CED256DDFA13C29339951BBEB0C64791"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_A3901F8BAF615A3F1B99E7E3793068F241B8CB5F6F4033A3F43AFBD7ED6EEB30E5"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_A57E246DC0BB3AEF2B28EF57E040CFF21366B72937C5623E705857DFD8F9835ACDE83E9D9DAB"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_837E24CD38D8B43A7D29C77F7928E3EB7003079933B87D635B131FD749C76B25B0EEBEDD2B12"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_93EA251BD081D44253851112E33F9B9B2988B74FC01B0D1B43156301D9CB0327F1812B3F405152"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_85DD2A4268371B553871FFDB61C01B5F6F83AAF91316D7CB204BEFEF11E8628785BEB282DB6533C948B1E489"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_87AF22D042EE715017BC606E88571BC7562B2BC14BC2BB4B3FD57C709597C18BF812D0E8"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8A242736DB588CEDBAD1EB37A1DB771B16DC95EB079C2B9DA559777DDA58B3584F96B9ACEBC21B1D26"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_9724278C3FE8FF57557B09330DA0FFF630AF3D379918C76B737183F9888FC72E4063BE95AF384DAB86"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8E9F20B1DB58467BAB1DFA6E1ADE77B1C2E656EB1CC92BD94BB2BB7DB5573DA7B159"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_A1CC251BDE1691EDBA8EFAB943EDBBB1166E59BE8339CA3BD2B2DDAFB5BAF4F4C62BD72C363A89"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_A39F1F386DD99808931B6F3F431A4C1871C281D6521258BC0A27275F4713154B0B"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_B48724036F1FEAC708134152887B0752E7AFAF57F93EA2968019435180D04C8A4E5F471369C7"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_AD24227A1A7FBB256BC3D143B3EFA7A2A14B1F7797C86153140293B70585CF6A0F13F8F7"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8D2A276C183FB5ED7D037FEF712F1C2F2AC6FF1FDF6EEB34A8AFD778B3D75913ACDBB8FFA74FDC64CE"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8C2A274B786765FF6B0B391F7B6F4319E1B7C9C1D33A32BCC3B078C6387F8BA397963AE1C9DB0190E2"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_888A1FD8DBC2917BABD17D3734BDEED885B995AF83C9CAB32DB2DDFAB98EDE6CD6"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_93A7242DD83854DA9DC967DFD948838BD0A3E77993181D03FBF3FF7717ED4AC3D88E1E3D8B6A"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_A3A7241BED8523B7ABD1EBCD1A7B7736C2DC95AF0E392BECD2CAEED79B1DBDB1B5D785B11D19"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_A23F2A41AD62B9801DB3A1C8EB2FDBEF0AD24D40C2EB736BF9EFD8B18379B32F92713E5D9D12D736D923C8CA"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_AACF25D8BDC223DBAB1DEBDC0DBDBB1B2C37567DC1C92BB3B4ACEED7ABB91995933158E4C92BB1"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8E4C1FA9CF272977F3F341584A0D0F817F7BA5884883F19DDCCA0831D2E4DB7BE7"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_BEE8248348195CCAAB7D998A6BB703E3A19B3FC748939563CB9D9B89C641BABA48F9A7F3C0A3"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_BDE824106A1FA5E8D3FC3F9F18BDE0FEC70389FE033B6D78ECC567CF3B24283E5F39818D2B82"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_82E82436F68546DBD547EBCD437BBB36C26E2B7D0E9C95B32DACDD7D36A10BE46BFAB0B1A366"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_ACE824DD22D19AE80D98B11B68E753CFC1C39FF7417A90E35A41AB574EF9EF53D02ECF90250A"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_91E82436EDC291F6AE8EFADCD0EDBBD8C237B2FA1C4EAC674B59EEFA6C0D2CE4DAF52CC6A3D4"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8EE824601A6FD59883AC6F2FA86D102E17B3D98E538B9DA85C95377FCB94786E8FE9D150FB42"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_A6B62103C899DC4A2BFD190AEB3783632180BF47C81315E34B1D1B094EF9BA2B08A86B"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_950426D8DE16C87BAEA3AFCD43DEBBC6C26EACFA1C4E563B5A2BBBAFE6474BC6DA59E4AF0BC6E889"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_BA0426B1DE0B19BDBA1DBEB943F6BB36163756FA1C9CCA674BCABBEBE6472DB15B59E4EBB0D83A46"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_B10426D520C0AC320551CF677120FBE3780B0F913BB0759B531B67DF6F55C25B40514269B1182C07"] = var_2;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8C0426D87BC232BDEA3A7DB934DEBBD8586ECAAFC1E4B2674BB2DDD76EA35AD8DA2B39FA0BD84768"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_95E4268DDBC291F6AB1DEBB986B7BBB12C6EB27D1CC9B2CED22B77FAB96B0BD8C6AF4C2C279C591B"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_9717258DB70B19BD5D8ED737A1B7EE8D2CE6ACD71CE42BD94BACEEBEE6D6B063C6D71BB0CD954E"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_9B8C2A21CD02D9E07DD301684B8F3B0FAA722D20624B938B598FB8111FD5B159A29111B73A9245963983A86A"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_AD722639D51AC1E8752B097043B72307A27A25286A439BF34187401907DDB9A19AE9A945401B41D9"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_833325D935FA2108950B295063D74367825AC5C84A63FBD36167603967FD5981FAC948E7A30ABF"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_82FC28D2F8A78BC588C16F4B91308BEFDF13DA69A386477BB0DB5F1FBF18D61BF10ED232A9D763F4A033"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_A6682D089A36B998AFF42836F01F437F9EE3C809038AE3F3F70DC438C37FC9D905C93070EAE615289335D82FA4233B"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_A56728F3F8F7591FEDB536586C0DD89E13235779FB831AF5CC0A63F8BB3AF713599783DDE743D7937CA7"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_8B012D78C0CBA8F7FBFBE11650500BDFDF6BA72E5B3B273C9F4F0CBF9BF8F0CDF29FE357B605206BAB49870B1C931F"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_A9D02536F62C91DEEA1DAF9B86DEEE360BE6B2EB0E93563BB4ACEEF56EB58563C6AFDC47DB36B6"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_950C2781576A69306FFB48BA68AFE7E363588FF93320C07D94D03FA9AB68E86978695BC6B18F3F5ABB"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_B4A125F915DA0128B56B493003F7634762BAE5E82A03DB338147BB59471D79E1DA296E8BC65B83"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_87532A731F0FFAD71823714298F0F742D7BFDF47C92E528690697341130829EA394F5F1353569A770850ABC2"] = var_2;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_A12527980AA6C9E8DF64B8A6408FD38F0E535879933A7303479DB48833EF5949B53970A8BA96A73973"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_B28C26367B2C91BDBAE8EBE60DBDBB6C163759FAC1E456B3D295EEAFC6B04EEC2BBE982CC94E5636"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_822C2B397F9799C74363D1A8BA9DBF31EF0B3538D873610DAC5A98C192366D4957BFCEAF32AB297119E278E07F"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_93EA251BD081D44253851112E33F9B9B2988B74FC01B0D1B43156301D9CB0327F1812B3F405152"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_A3901F8BAF615A3F1B99E7E3793068F241B8CB5F6F4033A3F43AFBD7ED6EEB30E5"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_821D2819F53AE1C855CBE990A3970327C21A05088AA3BB9321A7A0F95BB1FB572A8989AF27CA4DB81EDF"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_85922D9D304BCAFF3B38DF67F050BFE22356A7D927D5122E40A847CFA8C9726AF3F82DCE041B5B498840EF3F808309"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_AA922D8DB7C2197BAE3ABECD1ADB771B58CDCAD7E09C56674B56EEEB365839B359F5D616B358F45ADC59FA0B1B8E64"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_874E26731F0FFAD71823714298F0F742D7BFDF47C92E528690697341F0683A5ABD4F676765528A4D"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_8E06250157BFB19F1B0BA9C0E2B597E917D31D10A02B59E54462F099BACE55217F57907F1C2FC1"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_8D612AFC4F988F27252B5983B0700F06E01F6D47C9A817BBC321D349585FC3FF68DFEFD029A8DE57FFF8DBD7"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_AF612AA288D7FBB5D891DFFB41E07B3F0FA38A19F336B7AB4BAB0FCF71C84267A5DEA2731B035729289104AA"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_8378288C3FE8FF57557B09330DA0FFF630AF3D379918C76B737183F9A88F93AFB80FA295D3A08FB32BCB"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_A3122D2AF06952328DC3FFDBC09AB3E1AFF38B8EB70B47F30BE8481FFD20E6B0F06102C7C1D83CA0ABE00F8A55F3EF"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_B88B25F882F75D103B14E7B720E588969F3B5106DB030510D41D8FF75C4E686C5751EBEBB2AF4A"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_A23F2A41AD62B9801DB3A1C8EB2FDBEF0AD24D40C2EB736BF9EFD8B18379B32F92713E5D9D12D736D923C8CA"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_B6962BB1DE1646F6ABE8AF3743BDDD36C237567DE0C956CE5A59EEBE8DB0933B2BFA57DC91AC2798C2274ECAC6"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_8D7430BCEF3647C803BD39E3D8F0D3AF79384979C8023F8B6399EB2E936878A2F71FE30DFDAFCB310AA38BAA0881D05AA9DF"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_A7B9250A207F430D7009B7832978D397975B12A16B4E1F03F80397A7C920DAFFCD768A5AD126F7"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_9A6E2AFC38A11B5D6BD8815B208793CF199E7D57CFAB47237BB80B9128F38A677110C3E8EF73AF2113C8C34F"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_A56E2AF1973A1D484D23AE234C0FD0C6925F6B0F03F35548797FD3BE75E9300C8A87DFE9DF5B29398915BB1B"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_8D6E2A63D7AFDDCD4BBB07FF5BC06F5749CB07898AABA54681888077F07303E4E8F0EE2B7F9290061F9AD3C2"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_BA6E2AC278C3E7475BD5B793E3201F6E6B9BDA89E8BD1FEB30B58787898943B79BC92272D855D51769298CE4"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_B16E2A6590701C82D5811F9781F04B53287B5F21EB40A5CB234BB72FE1AF238FE046567461B865110F41A39E"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_8C6E2A158871F11F2B23A03631A8373A109B8A875F22E0FBE0A88370F3FFB80CED21C7F043EA30389299D392"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_A3542731678F81CF4B5BD9B0B2E5A739E703CD20D07B6935B452A0C98A3E65712F874E2D51D7106B5A"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_AFB22CC67B2C8CDEEAE8FAB943BDDDC6B037ACD7389CB2D9D29577AF8D0B399D56D73747D2D8B62B39FAB01B4798"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_86B22C881AB639182F74A8B6709FC3FF1E634889830A6373778D44B85CCF2B4FC74940588AE6B729638F47293CBA"] = var_2;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_A5B22C4DB85834BAFDA947FFF9A8636BF0838719B338FDE3DB939F57C947FBA7886EBA5B08188BEAAECFCF931156"] = var_2;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_camera_depth_of_field;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_928A060723B255C8"] = 200;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"]["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_camera_depth_of_field;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_928A060723B255C8"] = 200;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_camera_depth_of_field;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_928A060723B255C8"] = 200;
  var_0["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_A918040DAF23"] = 36;
  var_3 = [];
  var_3["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_3["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_3["_encstr_A2060C84D92B115F9B8B719032B7"] = 0.05;
  var_3["_encstr_81F90B66C3205F2F389F8AF281"] = 0.05;
  var_3["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_3;
  var_0["_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_3;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_3;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_3;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_3;
  var_0["_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_3;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_3;
  var_0["_encstr_8FD31E6D90CABC90235BEF0348A02776716398E972754DB0BB8F5BF78B78F8D5"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_8FD31E6D90CABC90235BEF0348A02776716398E972754DB0BB8F5BF78B78F8D5"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_8FD31E6D90CABC90235BEF0348A02776716398E972754DB0BB8F5BF78B78F8D5"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_3;
  var_0["_encstr_8FD31E6D90CABC90235BEF0348A02776716398E972754DB0BB8F5BF78B78F8D5"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_3;
  var_0["_encstr_8FD31E6D90CABC90235BEF0348A02776716398E972754DB0BB8F5BF78B78F8D5"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_3;
  var_0["_encstr_8FD31E6D90CABC90235BEF0348A02776716398E972754DB0BB8F5BF78B78F8D5"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_3;
  var_0["_encstr_82781F36ED16C8F6EA477DB91ABD778D16CDB2FAE09C5667B4CAEEAFEE581DD8A1"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_82781F36ED16C8F6EA477DB91ABD778D16CDB2FAE09C5667B4CAEEAFEE581DD8A1"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_82781F36ED16C8F6EA477DB91ABD778D16CDB2FAE09C5667B4CAEEAFEE581DD8A1"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_3;
  var_4["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_4["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_4["_encstr_A2060C84D92B115F9B8B719032B7"] = 0.05;
  var_4["_encstr_81F90B66C3205F2F389F8AF281"] = 0.05;
  var_4["_encstr_A918040DAF23"] = 36;
  var_5 = [];
  var_5["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_5["_encstr_A7AA09C616D81B26586CB5"] = ::update_camera_depth_of_field;
  var_5["_encstr_928A060723B255C8"] = 200;
  var_5["_encstr_8A920C99AB4948AA893B77886203"] = 0.9;
  var_5["_encstr_A6BE09418F7C50B1873207"] = 0.5;
  var_5["_encstr_B2B20C8591A8C7F4EE968734EE3D"] = 0.1;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"]["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"] = var_5;
  var_0["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"] = var_5;
  var_0["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"] = var_5;
  var_0["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9"]["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_8B1608EC43B8D647A113"] = var_4;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_8B45130A207F430D7009B7832978D397975B12A14A"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B"] = var_5;
  var_0["_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20"]["_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37"] = var_5;
  var_0["_encstr_AC181057F8D618370F3BD923918BFF30EF47"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_AC181057F8D618370F3BD923918BFF30EF47"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_AC181057F8D618370F3BD923918BFF30EF47"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = level.camera_character_tango.myfov;
  var_0["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l.myfov;
  var_0["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l_detail.myfov;
  var_0["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l_detail.myfov;
  var_0["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_r_detail.myfov;
  var_0["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l.myfov;
  var_0["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_r.myfov;
  var_0["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_r_detail.myfov;
  var_0["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_r_detail.myfov;
  var_0["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l_detail.myfov;
  var_0["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_r.myfov;
  var_0["_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED"]["_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l.myfov;
  var_0["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l_detail.myfov;
  var_0["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l_detail.myfov;
  var_0["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_r_detail.myfov;
  var_0["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l.myfov;
  var_0["_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781"]["_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_AD6216C38B2223EAC3B8452DD7B16D4BCDA05E9D7BE0A8D6"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_AD6216C38B2223EAC3B8452DD7B16D4BCDA05E9D7BE0A8D6"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_AD6216C38B2223EAC3B8452DD7B16D4BCDA05E9D7BE0A8D6"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_88CC1637738B3AA18FFCA55E372AC6C8BB9E4FBBF30CB39F"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_88CC1637738B3AA18FFCA55E372AC6C8BB9E4FBBF30CB39F"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_88CC1637738B3AA18FFCA55E372AC6C8BB9E4FBBF30CB39F"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = 28;
  var_0["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l_detail.myfov;
  var_0["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = 28;
  var_0["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_A918040DAF23"] = level.camera_character_faction_select_l.myfov;
  var_0["_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D"]["_encstr_8DA70EB857B09347CA27B6C2CDE8B24E"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_928A060723B255C8"] = 150;
  var_0["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_A918040DAF23"] = 36;
  var_0["_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236"]["_encstr_92240CF7277B5104374B0FCE6219"]["_encstr_B41C0BABCD2BBE13BD5D738D56"] = 1;
  var_0["_encstr_B445096364C7ED1FC148FB"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_B445096364C7ED1FC148FB"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_entities_and_camera;
  var_0["_encstr_B445096364C7ED1FC148FB"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A918040DAF23"] = 28;
  var_0["_encstr_839F10EFFB9F2B4750F6CA14E84093F26E03"] = [];
  var_0["_encstr_839F10EFFB9F2B4750F6CA14E84093F26E03"]["_encstr_8B1608EC43B8D647A113"] = [];
  var_0["_encstr_839F10EFFB9F2B4750F6CA14E84093F26E03"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_839F10EFFB9F2B4750F6CA14E84093F26E03"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_camera_depth_of_field;
  var_0["_encstr_839F10EFFB9F2B4750F6CA14E84093F26E03"]["_encstr_8B1608EC43B8D647A113"]["_encstr_928A060723B255C8"] = 75;
  var_0["_encstr_ABD9091A11068B1E50872B"] = [];
  var_0["_encstr_ABD9091A11068B1E50872B"]["_encstr_8B1608EC43B8D647A113"] = [];
  var_0["_encstr_ABD9091A11068B1E50872B"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_move;
  var_0["_encstr_ABD9091A11068B1E50872B"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_camera_depth_of_field;
  var_0["_encstr_ABD9091A11068B1E50872B"]["_encstr_8B1608EC43B8D647A113"]["_encstr_928A060723B255C8"] = 100;
  var_0["_encstr_ABD9091A11068B1E50872B"]["_encstr_839F10EFFB9F2B4750F6CA14E84093F26E03"]["_encstr_928A060723B255C8"] = 5000;
  var_0["_encstr_88341AB74842775ACB091EA2013BA68FE8A1A2EF9B43AD28FF81FFF7"] = [];
  var_0["_encstr_88341AB74842775ACB091EA2013BA68FE8A1A2EF9B43AD28FF81FFF7"]["_encstr_8B1608EC43B8D647A113"] = [];
  var_0["_encstr_88341AB74842775ACB091EA2013BA68FE8A1A2EF9B43AD28FF81FFF7"]["_encstr_8B1608EC43B8D647A113"]["_encstr_8F5B0B6405C72BFB53CB58E790"] = ::frontend_camera_teleport;
  var_0["_encstr_88341AB74842775ACB091EA2013BA68FE8A1A2EF9B43AD28FF81FFF7"]["_encstr_8B1608EC43B8D647A113"]["_encstr_A7AA09C616D81B26586CB5"] = ::update_player_character_showcase;
  level.transitionarray = var_0;
}

get_section_state(var_0) {
  var_1 = [];
  var_2 = !isDefined(level.active_scene_data) || level.transition_interrupted;
  level.playerviewowner visionsetnakedforplayer("_encstr_B40101", 0);
  level._id_13B60 = 0;

  switch (var_0.name) {
    case "_encstr_8BE4070B63A2C07896":
      break;
    case "_encstr_92240CF7277B5104374B0FCE6219":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_lobby;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_lobby.basecam;

      if(level._id_13370 && isDefined(level.playersetomnvarattraction))
        level.playerviewowner visionsetnakedforplayer("_encstr_AA66191F2846D6936788DB97E0291994E813ABD7B93B5C894B13A7", 0);

      if(level._id_13370 && isDefined(level.playershooting))
        level.playerviewowner visionsetnakedforplayer("_encstr_8C9C1620135F9E98754A705BED322729CA90A9B871A3198D", 0);

      if(level._id_13370 && isDefined(level.playershowskippromptcinematic))
        level.playerviewowner visionsetnakedforplayer("_encstr_BD4A197AA3AF2B2AC01DBCB505C0394BB05902A3AEEE8EA9A077A7", 0);

      if(level._id_13370 && isDefined(level.playersetkeypadstateindex))
        level.playerviewowner visionsetnakedforplayer("_encstr_88B3188823BF113D2255FD0D2DEAC3D3D7DB6038FB57CBDBAA7D", 0);

      if(level._id_13370 && isDefined(level.playersleftloop))
        level.playerviewowner visionsetnakedforplayer("_encstr_B6D71E02506F57032888CCD590111F4A9FE2A98A40ED8EE706E3AFC43BF9DF60", 0);

      if(isDefined(level.playersetomnvarkeypad))
        level._id_13B60 = 1;

      break;
    case "_encstr_86DB13B92EEA1623F5D8BD3189F2AF192BE8C2D236":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_lobby_detail;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_lobby_detail.basecam;

      if(level._id_13370 && isDefined(level.playersetomnvarattraction))
        level.playerviewowner visionsetnakedforplayer("_encstr_AA66191F2846D6936788DB97E0291994E813ABD7B93B5C894B13A7", 0);

      if(level._id_13370 && isDefined(level.playershooting))
        level.playerviewowner visionsetnakedforplayer("_encstr_8C9C1620135F9E98754A705BED322729CA90A9B871A3198D", 0);

      if(level._id_13370 && isDefined(level.playershowskippromptcinematic))
        level.playerviewowner visionsetnakedforplayer("_encstr_BD4A197AA3AF2B2AC01DBCB505C0394BB05902A3AEEE8EA9A077A7", 0);

      if(level._id_13370 && isDefined(level.playersetkeypadstateindex))
        level.playerviewowner visionsetnakedforplayer("_encstr_88B3188823BF113D2255FD0D2DEAC3D3D7DB6038FB57CBDBAA7D", 0);

      if(level._id_13370 && isDefined(level.playersleftloop))
        level.playerviewowner visionsetnakedforplayer("_encstr_B6D71E02506F57032888CCD590111F4A9FE2A98A40ED8EE706E3AFC43BF9DF60", 0);

      if(isDefined(level.playersetomnvarkeypad))
        level._id_13B60 = 1;

      break;
    case "_encstr_AC181057F8D618370F3BD923918BFF30EF47":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_character_tango;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_character_tango.basecam;
      break;
    case "_encstr_8DA70EB857B09347CA27B6C2CDE8B24E":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_quartermaster;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_quartermaster.basecam;
      break;
    case "_encstr_9BD715099370E25335C3428ACB952F5A29299574D3682D":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_quartermaster_detail;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_quartermaster_detail.basecam;
      break;
    case "_encstr_91C41BE872AE1DD18F7CBD2E7FB3198753CA100879427B484F933DB054":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_character_faction_select_l;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_character_faction_select_l.basecam;
      break;
    case "_encstr_8D4222EFB8BF22BA678BE825A6D667717392725AE063FF75E5AF2B5133983A9334BFD399":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_character_faction_select_l_detail;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_character_faction_select_l_detail.basecam;
      break;
    case "_encstr_8463194B1309EB46DFB05A2301117A4F030BD5D72013FF4D8B3053":
      var_1["_encstr_99FB066E36959B2B"] = level.gamemodemolotovfunc;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gamemodemolotovfunc.basecam;
      break;
    case "_encstr_A30720876368DE5E301BAD6E476B2E12BBB7C79CB93EE96DF14753BF992B18889781":
      var_1["_encstr_99FB066E36959B2B"] = level.gamemodeoverridemeleeviewkickscale;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gamemodeoverridemeleeviewkickscale.basecam;
      break;
    case "_encstr_88C41BF2C8770396C831859A4FC85E9F252DCAAAB6D6178D8007ACAFED":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_character_faction_select_r;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_character_faction_select_r.basecam;
      break;
    case "_encstr_9A102250DB363589E68B6FA5D664A1497508CDC0419F98146D6B4BAFC2167439F33390ED":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_character_faction_select_r_detail;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_character_faction_select_r_detail.basecam;
      break;
    case "_encstr_AD6216C38B2223EAC3B8452DD7B16D4BCDA05E9D7BE0A8D6":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_character_tournaments;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_character_tournaments.basecam;

      if(level._id_13370 && isDefined(level.playersetomnvarattraction))
        level.playerviewowner visionsetnakedforplayer("_encstr_AA66191F2846D6936788DB97E0291994E813ABD7B93B5C894B13A7", 0);

      if(isDefined(level.playersetomnvarkeypad))
        level._id_13B60 = 1;

      break;
    case "_encstr_88CC1637738B3AA18FFCA55E372AC6C8BB9E4FBBF30CB39F":
      var_1["_encstr_99FB066E36959B2B"] = level.gameisending;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gameisending.basecam;

      if(level._id_13370 && isDefined(level.playersetomnvarattraction))
        level.playerviewowner visionsetnakedforplayer("_encstr_AA66191F2846D6936788DB97E0291994E813ABD7B93B5C894B13A7", 0);

      if(isDefined(level.playersetomnvarkeypad))
        level._id_13B60 = 1;

      break;
    case "_encstr_84ED1AD2F8A78BC588C16F4B91308BEFDF13DA694084477A48C34D37":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_overview;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_overview.basecam;
      break;
    case "_encstr_93D319204FBF4B78A8B8E60398384437A0DB07A14B352764D8799B":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview.basecam;
      _id_12A0D("_encstr_AB5E07609A5B7368E5");
      break;
    case "_encstr_A5901F324001EA2FD0B3D19383382FA97A3B89484BF6FDC577079CE748BB937059":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large.basecam;
      _id_12A0D("_encstr_8DEC06B1E943615B");
      break;
    case "_encstr_BA5B1FC6DE0BC8BDBAA37D9B1AB7DDD82C37B2D7839395B3B4B2BBAF37AD0BC6C6":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small.basecam;
      _id_12A0D("_encstr_A972062F7FDAF9B0");
      break;
    case "_encstr_8FD31E6D90CABC90235BEF0348A02776716398E972754DB0BB8F5BF78B78F8D5":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_riot;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_riot.basecam;
      break;
    case "_encstr_82781F36ED16C8F6EA477DB91ABD778D16CDB2FAE09C5667B4CAEEAFEE581DD8A1":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_watch;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_watch.basecam;
      _id_12A0D("_encstr_BD4C06DB81953FAC");
      break;
    case "_encstr_A143208965AA7158C57B599B33E793B7728AF5983A33CB23B1571069F3010BCD5AF5":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_barrel;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_barrel.basecam;
      break;
    case "_encstr_BDCD2536BDC2C8ED5D47FAB91A7BBB1B0BB9957D0793593BA5CAEEF54C5893C9ACD8FAC2C61D62":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_barrel_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_barrel_alt1.basecam;
      break;
    case "_encstr_87CD25B1BDC223F6AE8ED7B943DE77C6B0B956FA0EE495CED256DDFA13C29339951BBEB0C64791":
      var_1["_encstr_99FB066E36959B2B"] = level.gameplay_main;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gameplay_main.basecam;
      break;
    case "_encstr_8E4C1FA9CF272977F3F341584A0D0F817F7BA5884883F19DDCCA0831D2E4DB7BE7":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_charm;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_charm.basecam;
      break;
    case "_encstr_BEE8248348195CCAAB7D998A6BB703E3A19B3FC748939563CB9D9B89C641BABA48F9A7F3C0A3":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_charm_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_charm_alt1.basecam;
      break;
    case "_encstr_BDE824106A1FA5E8D3FC3F9F18BDE0FEC70389FE033B6D78ECC567CF3B24283E5F39818D2B82":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_charm_alt2;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_charm_alt2.basecam;
      break;
    case "_encstr_82E82436F68546DBD547EBCD437BBB36C26E2B7D0E9C95B32DACDD7D36A10BE46BFAB0B1A366":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_charm_alt3;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_charm_alt3.basecam;
      break;
    case "_encstr_ACE824DD22D19AE80D98B11B68E753CFC1C39FF7417A90E35A41AB574EF9EF53D02ECF90250A":
      var_1["_encstr_99FB066E36959B2B"] = level.gameskill_init;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gameskill_init.basecam;
      break;
    case "_encstr_91E82436EDC291F6AE8EFADCD0EDBBD8C237B2FA1C4EAC674B59EEFA6C0D2CE4DAF52CC6A3D4":
      var_1["_encstr_99FB066E36959B2B"] = level.gameskill_set_player;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gameskill_set_player.basecam;
      break;
    case "_encstr_8EE824601A6FD59883AC6F2FA86D102E17B3D98E538B9DA85C95377FCB94786E8FE9D150FB42":
      var_1["_encstr_99FB066E36959B2B"] = level.gamestatedisplaymonitor;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gamestatedisplaymonitor.basecam;
      break;
    case "_encstr_87532A731F0FFAD71823714298F0F742D7BFDF47C92E528690697341130829EA394F5F1353569A770850ABC2":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_badplace;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_badplace.basecam;
      break;
    case "_encstr_A3901F8BAF615A3F1B99E7E3793068F241B8CB5F6F4033A3F43AFBD7ED6EEB30E5":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_laser;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_laser.basecam;
      break;
    case "_encstr_A57E246DC0BB3AEF2B28EF57E040CFF21366B72937C5623E705857DFD8F9835ACDE83E9D9DAB":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_laser_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_laser_alt1.basecam;
      break;
    case "_encstr_837E24CD38D8B43A7D29C77F7928E3EB7003079933B87D635B131FD749C76B25B0EEBEDD2B12":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_laser_alt2;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_laser_alt2.basecam;
      break;
    case "_encstr_87AF22D042EE715017BC606E88571BC7562B2BC14BC2BB4B3FD57C709597C18BF812D0E8":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_magazine;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_magazine.basecam;
      break;
    case "_encstr_8A242736DB588CEDBAD1EB37A1DB771B16DC95EB079C2B9DA559777DDA58B3584F96B9ACEBC21B1D26":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_magazine_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_magazine_alt1.basecam;
      break;
    case "_encstr_9724278C3FE8FF57557B09330DA0FFF630AF3D379918C76B737183F9888FC72E4063BE95AF384DAB86":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_magazine_alt2;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_magazine_alt2.basecam;
      break;
    case "_encstr_8E9F20B1DB58467BAB1DFA6E1ADE77B1C2E656EB1CC92BD94BB2BB7DB5573DA7B159":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_muzzle;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_muzzle.basecam;
      break;
    case "_encstr_A1CC251BDE1691EDBA8EFAB943EDBBB1166E59BE8339CA3BD2B2DDAFB5BAF4F4C62BD72C363A89":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_muzzle_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_muzzle_alt1.basecam;
      break;
    case "_encstr_A39F1F386DD99808931B6F3F431A4C1871C281D6521258BC0A27275F4713154B0B":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_optic;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_optic.basecam;
      break;
    case "_encstr_B48724036F1FEAC708134152887B0752E7AFAF57F93EA2968019435180D04C8A4E5F471369C7":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_optic_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_optic_alt1.basecam;
      break;
    case "_encstr_AD24227A1A7FBB256BC3D143B3EFA7A2A14B1F7797C86153140293B70585CF6A0F13F8F7":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_reargrip;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_reargrip.basecam;
      break;
    case "_encstr_8D2A276C183FB5ED7D037FEF712F1C2F2AC6FF1FDF6EEB34A8AFD778B3D75913ACDBB8FFA74FDC64CE":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_reargrip_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_reargrip_alt1.basecam;
      break;
    case "_encstr_8C2A274B786765FF6B0B391F7B6F4319E1B7C9C1D33A32BCC3B078C6387F8BA397963AE1C9DB0190E2":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_reargrip_alt2;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_reargrip_alt2.basecam;
      break;
    case "_encstr_A6B62103C899DC4A2BFD190AEB3783632180BF47C81315E34B1D1B094EF9BA2B08A86B":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_fx;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_fx.basecam;
      break;
    case "_encstr_950426D8DE16C87BAEA3AFCD43DEBBC6C26EACFA1C4E563B5A2BBBAFE6474BC6DA59E4AF0BC6E889":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_linger_large_vfx;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_linger_large_vfx.basecam;
      break;
    case "_encstr_BA0426B1DE0B19BDBA1DBEB943F6BB36163756FA1C9CCA674BCABBEBE6472DB15B59E4EBB0D83A46":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_linger_vfx;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_linger_vfx.basecam;
      break;
    case "_encstr_B10426D520C0AC320551CF677120FBE3780B0F913BB0759B531B67DF6F55C25B40514269B1182C07":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_payloads;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_payloads.basecam;
      break;
    case "_encstr_8C0426D87BC232BDEA3A7DB934DEBBD8586ECAAFC1E4B2674BB2DDD76EA35AD8DA2B39FA0BD84768":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_sequence_activated;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_sequence_activated.basecam;
      break;
    case "_encstr_888A1FD8DBC2917BABD17D3734BDEED885B995AF83C9CAB32DB2DDFAB98EDE6CD6":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_stock;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_stock.basecam;
      break;
    case "_encstr_93A7242DD83854DA9DC967DFD948838BD0A3E77993181D03FBF3FF7717ED4AC3D88E1E3D8B6A":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_stock_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_stock_alt1.basecam;
      break;
    case "_encstr_A3A7241BED8523B7ABD1EBCD1A7B7736C2DC95AF0E392BECD2CAEED79B1DBDB1B5D785B11D19":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_stock_alt2;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_stock_alt2.basecam;
      break;
    case "_encstr_AACF25D8BDC223DBAB1DEBDC0DBDBB1B2C37567DC1C92BB3B4ACEED7ABB91995933158E4C92BB1":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_underbarrel;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_underbarrel.basecam;
      break;
    case "_encstr_B28C26367B2C91BDBAE8EBE60DBDBB6C163759FAC1E456B3D295EEAFC6B04EEC2BBE982CC94E5636":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_barrel;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_barrel.basecam;
      break;
    case "_encstr_822C2B397F9799C74363D1A8BA9DBF31EF0B3538D873610DAC5A98C192366D4957BFCEAF32AB297119E278E07F":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_barrel_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_barrel_alt1.basecam;
      break;
    case "_encstr_A7B9250A207F430D7009B7832978D397975B12A16B4E1F03F80397A7C920DAFFCD768A5AD126F7":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_charm;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_charm.basecam;
      break;
    case "_encstr_9A6E2AFC38A11B5D6BD8815B208793CF199E7D57CFAB47237BB80B9128F38A677110C3E8EF73AF2113C8C34F":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_charm_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_charm_alt1.basecam;
      break;
    case "_encstr_A56E2AF1973A1D484D23AE234C0FD0C6925F6B0F03F35548797FD3BE75E9300C8A87DFE9DF5B29398915BB1B":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_charm_alt2;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_charm_alt2.basecam;
      break;
    case "_encstr_8D6E2A63D7AFDDCD4BBB07FF5BC06F5749CB07898AABA54681888077F07303E4E8F0EE2B7F9290061F9AD3C2":
      var_1["_encstr_99FB066E36959B2B"] = level.gametypefilter;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gametypefilter.basecam;
      break;
    case "_encstr_BA6E2AC278C3E7475BD5B793E3201F6E6B9BDA89E8BD1FEB30B58787898943B79BC92272D855D51769298CE4":
      var_1["_encstr_99FB066E36959B2B"] = level.gametypekillsperhouravg;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gametypekillsperhouravg.basecam;
      break;
    case "_encstr_B16E2A6590701C82D5811F9781F04B53287B5F21EB40A5CB234BB72FE1AF238FE046567461B865110F41A39E":
      var_1["_encstr_99FB066E36959B2B"] = level.gametypekillspermatchmax;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gametypekillspermatchmax.basecam;
      break;
    case "_encstr_8C6E2A158871F11F2B23A03631A8373A109B8A875F22E0FBE0A88370F3FFB80CED21C7F043EA30389299D392":
      var_1["_encstr_99FB066E36959B2B"] = level.gametypeoverrideassassinsearchparams;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gametypeoverrideassassinsearchparams.basecam;
      break;
    case "_encstr_93EA251BD081D44253851112E33F9B9B2988B74FC01B0D1B43156301D9CB0327F1812B3F405152":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_laser;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_laser.basecam;
      break;
    case "_encstr_85DD2A4268371B553871FFDB61C01B5F6F83AAF91316D7CB204BEFEF11E8628785BEB282DB6533C948B1E489":
      var_1["_encstr_99FB066E36959B2B"] = level.gametypeoverridedomsearchparams;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gametypeoverridedomsearchparams.basecam;
      break;
    case "_encstr_821D2819F53AE1C855CBE990A3970327C21A05088AA3BB9321A7A0F95BB1FB572A8989AF27CA4DB81EDF":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_magazine;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_magazine.basecam;
      break;
    case "_encstr_85922D9D304BCAFF3B38DF67F050BFE22356A7D927D5122E40A847CFA8C9726AF3F82DCE041B5B498840EF3F808309":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_magazine_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_magazine_alt1.basecam;
      break;
    case "_encstr_AA922D8DB7C2197BAE3ABECD1ADB771B58CDCAD7E09C56674B56EEEB365839B359F5D616B358F45ADC59FA0B1B8E64":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_magazine_alt2;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_magazine_alt2.basecam;
      break;
    case "_encstr_874E26731F0FFAD71823714298F0F742D7BFDF47C92E528690697341F0683A5ABD4F676765528A4D":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_muzzle;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_muzzle.basecam;
      break;
    case "_encstr_B4392B63DEB08CDBD5D1FA6E1ADEDDD8589B56FA389356B3B459DDF563B09C76ACD7B6BAE9D3B1ACAFC2D81D98":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_muzzle_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam;
      break;
    case "_encstr_8E06250157BFB19F1B0BA9C0E2B597E917D31D10A02B59E54462F099BACE55217F57907F1C2FC1":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_optic;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_optic.basecam;
      break;
    case "_encstr_8D612AFC4F988F27252B5983B0700F06E01F6D47C9A817BBC321D349585FC3FF68DFEFD029A8DE57FFF8DBD7":
      var_1["_encstr_99FB066E36959B2B"] = level.gametypeoverridescavsearchparams;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gametypeoverridescavsearchparams.basecam;
      break;
    case "_encstr_AF612AA288D7FBB5D891DFFB41E07B3F0FA38A19F336B7AB4BAB0FCF71C84267A5DEA2731B035729289104AA":
      var_1["_encstr_99FB066E36959B2B"] = level.gametyperoundendscoresetomnvar;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gametyperoundendscoresetomnvar.basecam;
      break;
    case "_encstr_8378288C3FE8FF57557B09330DA0FFF630AF3D379918C76B737183F9A88F93AFB80FA295D3A08FB32BCB":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_reargrip;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_reargrip.basecam;
      break;
    case "_encstr_A3122D2AF06952328DC3FFDBC09AB3E1AFF38B8EB70B47F30BE8481FFD20E6B0F06102C7C1D83CA0ABE00F8A55F3EF":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_reargrip_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam;
      break;
    case "_encstr_A3542731678F81CF4B5BD9B0B2E5A739E703CD20D07B6935B452A0C98A3E65712F874E2D51D7106B5A":
      var_1["_encstr_99FB066E36959B2B"] = level.gametypeweaponxpmodifier;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gametypeweaponxpmodifier.basecam;
      break;
    case "_encstr_AFB22CC67B2C8CDEEAE8FAB943BDDDC6B037ACD7389CB2D9D29577AF8D0B399D56D73747D2D8B62B39FAB01B4798":
      var_1["_encstr_99FB066E36959B2B"] = level.garbage_bin_clip;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.garbage_bin_clip.basecam;
      break;
    case "_encstr_86B22C881AB639182F74A8B6709FC3FF1E634889830A6373778D44B85CCF2B4FC74940588AE6B729638F47293CBA":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_at_computer;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_at_computer.basecam;
      break;
    case "_encstr_A5B22C4DB85834BAFDA947FFF9A8636BF0838719B338FDE3DB939F57C947FBA7886EBA5B08188BEAAECFCF931156":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_attack;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_attack.basecam;
      break;
    case "_encstr_B88B25F882F75D103B14E7B720E588969F3B5106DB030510D41D8FF75C4E686C5751EBEBB2AF4A":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_stock;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_stock.basecam;
      break;
    case "_encstr_A23F2A41AD62B9801DB3A1C8EB2FDBEF0AD24D40C2EB736BF9EFD8B18379B32F92713E5D9D12D736D923C8CA":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_attack_deploy;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_attack_deploy.basecam;
      break;
    case "_encstr_B6962BB1DE1646F6ABE8AF3743BDDD36C237567DE0C956CE5A59EEBE8DB0933B2BFA57DC91AC2798C2274ECAC6":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_underbarrel;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_underbarrel.basecam;
      break;
    case "_encstr_8D7430BCEF3647C803BD39E3D8F0D3AF79384979C8023F8B6399EB2E936878A2F71FE30DFDAFCB310AA38BAA0881D05AA9DF":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_large_underbarrel_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam;
      break;
    case "_encstr_95E4268DDBC291F6AB1DEBB986B7BBB12C6EB27D1CC9B2CED22B77FAB96B0BD8C6AF4C2C279C591B":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_barrel;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_barrel.basecam;
      break;
    case "_encstr_B4A125F915DA0128B56B493003F7634762BAE5E82A03DB338147BB59471D79E1DA296E8BC65B83":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_charm;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_charm.basecam;
      break;
    case "_encstr_9717258DB70B19BD5D8ED737A1B7EE8D2CE6ACD71CE42BD94BACEEBEE6D6B063C6D71BB0CD954E":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_laser;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_laser.basecam;
      break;
    case "_encstr_9B8C2A21CD02D9E07DD301684B8F3B0FAA722D20624B938B598FB8111FD5B159A29111B73A9245963983A86A":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_cloud_vfx;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_cloud_vfx.basecam;
      break;
    case "_encstr_82FC28D2F8A78BC588C16F4B91308BEFDF13DA69A386477BB0DB5F1FBF18D61BF10ED232A9D763F4A033":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_magazine;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_magazine.basecam;
      break;
    case "_encstr_A6682D089A36B998AFF42836F01F437F9EE3C809038AE3F3F70DC438C37FC9D905C93070EAE615289335D82FA4233B":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_magazine_alt1;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_magazine_alt1.basecam;
      break;
    case "_encstr_AD722639D51AC1E8752B097043B72307A27A25286A439BF34187401907DDB9A19AE9A945401B41D9":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_muzzle;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_muzzle.basecam;
      break;
    case "_encstr_833325D935FA2108950B295063D74367825AC5C84A63FBD36167603967FD5981FAC948E7A30ABF":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_optic;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_optic.basecam;
      break;
    case "_encstr_A56728F3F8F7591FEDB536586C0DD89E13235779FB831AF5CC0A63F8BB3AF713599783DDE743D7937CA7":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_reargrip;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_reargrip.basecam;
      break;
    case "_encstr_8B012D78C0CBA8F7FBFBE11650500BDFDF6BA72E5B3B273C9F4F0CBF9BF8F0CDF29FE357B605206BAB49870B1C931F":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_emit_vfx;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_emit_vfx.basecam;
      break;
    case "_encstr_A12527980AA6C9E8DF64B8A6408FD38F0E535879933A7303479DB48833EF5949B53970A8BA96A73973":
      var_1["_encstr_99FB066E36959B2B"] = level.gas_flyby_plane;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gas_flyby_plane.basecam;
      break;
    case "_encstr_A9D02536F62C91DEEA1DAF9B86DEEE360BE6B2EB0E93563BB4ACEEF56EB58563C6AFDC47DB36B6":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_stock;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_stock.basecam;
      break;
    case "_encstr_950C2781576A69306FFB48BA68AFE7E363588FF93320C07D94D03FA9AB68E86978695BC6B18F3F5ABB":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_preview_small_trigger;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_preview_small_trigger.basecam;
      break;
    case "_encstr_A704111CF85BBB97531B0958C8B7DB0B4B032D":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase.basecam;
      break;
    case "_encstr_84F618904F916137B3C37876DC4A5FC9F9475091DF3A98FF2BA8":
      var_1["_encstr_99FB066E36959B2B"] = level.gamemodespawnprotectedcallback;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.gamemodespawnprotectedcallback.basecam;
      break;
    case "_encstr_8F4513F23DAB818F5DCC480A34508F494B1B024790":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_p;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_p.basecam;
      break;
    case "_encstr_A5451945B0B14F80A8CBB70F847708E8A94BAF46500752D0F29F13":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_p_large;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_p_large.basecam;
      break;
    case "_encstr_914513E1EF8A19B27533598749278FDF6376FDBF30":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_s;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_s.basecam;
      break;
    case "_encstr_854513CC7FA8BF17153B49F3C0603F36F0EF7D77E7":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_o;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_o.basecam;
      break;
    case "_encstr_81CE19C6BD2C91BDAE8E7DDC347BBB6C2CB9CAF5BDD7630BC9EC95":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_o_large;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_o_large.basecam;
      break;
    case "_encstr_AD4513B4583959B0AFFCC77B4A1063FE21F8CD4F71":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_l;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_l.basecam;
      break;
    case "_encstr_A7451381BA12D338C3E15F3B307070ABFBDB17FFD1":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_t;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_t.basecam;
      break;
    case "_encstr_AF3E172137F910A89D41F988B16F4F9B41730701F0D07EEA23":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_perks;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_perks.basecam;
      break;
    case "_encstr_8345136D8FABD9CFBBF9799BC4AF6BCFD857706F30":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_x;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_x.basecam;
      break;
    case "_encstr_8B45130A207F430D7009B7832978D397975B12A14A":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_y;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_y.basecam;
      break;
    case "_encstr_994513D82D6331B8B86B770708D83BE3E2172BB63B":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_z;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_z.basecam;
      break;
    case "_encstr_87ED1C13D889CC5A5B8D691AFB079393D1908F57A04305425B2FAD945EE9":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_specialist;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_specialist.basecam;
      break;
    case "_encstr_BED0175DF08B0A3FFBF81FA73090FFA26316E7196433437B20":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_loadout_showcase_watch;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_loadout_showcase_watch.basecam;
      break;
    case "_encstr_839F10EFFB9F2B4750F6CA14E84093F26E03":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_ui_bg_01;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_ui_bg_01.basecam;
      break;
    case "_encstr_ABD9091A11068B1E50872B":
      var_3 = scripts\engine\utility::ter_op(var_2, level.camera_ui_bg_01, level.active_scene_data);
      var_1["_encstr_99FB066E36959B2B"] = level.camera_ui_bg_01;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_ui_bg_01.basecam;
      break;
    case "_encstr_88341AB74842775ACB091EA2013BA68FE8A1A2EF9B43AD28FF81FFF7":
      var_1["_encstr_99FB066E36959B2B"] = level.camera_ui_bg_01;
      var_1["_encstr_8B92075E3753DAE2B9"] = level.camera_ui_bg_01.basecam;
      break;
    default:
      break;
  }

  return var_1;
}

create_camera_position_list() {
  level.camera_loadout_showcase = spawnStruct();
  level.camera_loadout_showcase.basecam = getEnt("_encstr_862913616E27DD0B2AF1207B7F89ABC86E4D14C34B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase.basecam.depthoffieldvalues = [2, 100];
  level.camera_loadout_showcase.myfov = 36;
  level.camera_loadout_showcase.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase._id_1370F = 6;
  level.camera_loadout_showcase_overview = spawnStruct();
  level.camera_loadout_showcase_overview.basecam = getEnt("_encstr_86C11CAEDE108A0E3FE95B5BA79C47C65B58F4BCE34FDF4D382A56905DF4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_overview.basecam.depthoffieldvalues = [3, 85];
  level.camera_loadout_showcase_overview.myfov = 28;
  level.camera_loadout_showcase_overview.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_overview.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_overview.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_overview._id_1370F = 6;
  level.camera_loadout_showcase_preview = spawnStruct();
  level.camera_loadout_showcase_preview.basecam = getEnt("_encstr_A6051BD05980FF9607A1D5F3166AEBE82710D03B6879D832471BEBAF67", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview.basecam.depthoffieldvalues = [22, 56];
  level.camera_loadout_showcase_preview.myfov = 36;
  level.camera_loadout_showcase_preview.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview._id_1370F = 6;
  level.camera_loadout_showcase_preview_large = spawnStruct();
  level.camera_loadout_showcase_preview_large.basecam = getEnt("_encstr_91AE213EC98885FB676F7F03071CF3F610D0344340C158334D05772F4F28AA31A0F9AF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large.basecam.depthoffieldvalues = [22, 64];
  level.camera_loadout_showcase_preview_large.myfov = 36;
  level.camera_loadout_showcase_preview_large.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large._id_1370F = 6;
  level.camera_loadout_showcase_preview_small = spawnStruct();
  level.camera_loadout_showcase_preview_small.basecam = getEnt("_encstr_87AA256BCB6057DBA7F6F22BDE8C9FCDF8ABE9E47149DA135DCB8A62A3C84FC7A007967CFBC820", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small.basecam.depthoffieldvalues = [22, 36];
  level.camera_loadout_showcase_preview_small.myfov = 36;
  level.camera_loadout_showcase_preview_small.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small._id_1370F = 6;
  level.camera_loadout_showcase_preview_watch = spawnStruct();
  level.camera_loadout_showcase_preview_watch.basecam = getEnt("_encstr_8776218DC2DAAC4EC2FAB51C7DB35D37DC5BB4E843AF0E272BD94BACBBBEEEB0E8D834", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_watch.basecam.depthoffieldvalues = [20, 16];
  level.camera_loadout_showcase_preview_watch.myfov = 36;
  level.camera_loadout_showcase_preview_watch.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_watch._id_1370F = 6;
  level.gamemodespawnprotectedcallback = spawnStruct();
  level.gamemodespawnprotectedcallback.basecam = getEnt("_encstr_A3891A91A66D283E1A6FC3C1574285382B3D580B8CF7B0F63247F5DB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamemodespawnprotectedcallback.basecam.depthoffieldvalues = [7, 67];
  level.gamemodespawnprotectedcallback.myfov = 44;
  level.gamemodespawnprotectedcallback.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamemodespawnprotectedcallback.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamemodespawnprotectedcallback.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamemodespawnprotectedcallback._id_1370F = 6;
  level.camera_loadout_showcase_p = spawnStruct();
  level.camera_loadout_showcase_p.basecam = getEnt("_encstr_A5371F8FC349AA8AF806BDC23EF0B5521E432FABB9F8525CB8EEF20130A8FA1AFD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_p.basecam.depthoffieldvalues = [7, 38];
  level.camera_loadout_showcase_p.myfov = 55;
  level.camera_loadout_showcase_p.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_p.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_p.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_p._id_1370F = 6;
  level.camera_loadout_showcase_p_large = spawnStruct();
  level.camera_loadout_showcase_p_large.basecam = getEnt("_encstr_A5371F8FC349AA8AF806BDC23EF0B5521E432FABB9F8525CB8EEF20130A8FA1AFD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_p_large.basecam.depthoffieldvalues = [7, 64];
  level.camera_loadout_showcase_p_large.myfov = 55;
  level.camera_loadout_showcase_p_large.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_p_large.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_p_large.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_p_large._id_1370F = 6;
  level.camera_loadout_showcase_s = spawnStruct();
  level.camera_loadout_showcase_s.basecam = getEnt("_encstr_AA15196C16B5B2930BD76B1CAF76AB9BCDDAA53AA1AF2CC6D17D37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_s.basecam.depthoffieldvalues = [12, 22];
  level.camera_loadout_showcase_s.myfov = 55;
  level.camera_loadout_showcase_s.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_s.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_s.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_s._id_1370F = 6;
  level.camera_loadout_showcase_o = spawnStruct();
  level.camera_loadout_showcase_o.basecam = getEnt("_encstr_8AC91F1BBB10274B3766429B4E1C6F5D483B9974C1D96EFB659E7A5130673BD72B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_o.basecam.depthoffieldvalues = [14, 38];
  level.camera_loadout_showcase_o.myfov = 55;
  level.camera_loadout_showcase_o.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_o.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_o.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_o._id_1370F = 6;
  level.camera_loadout_showcase_o_large = spawnStruct();
  level.camera_loadout_showcase_o_large.basecam = getEnt("_encstr_8AC91F1BBB10274B3766429B4E1C6F5D483B9974C1D96EFB659E7A5130673BD72B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_o_large.basecam.depthoffieldvalues = [14, 65];
  level.camera_loadout_showcase_o_large.myfov = 55;
  level.camera_loadout_showcase_o_large.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_o_large.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_o_large.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_o_large._id_1370F = 6;
  level.camera_loadout_showcase_l = spawnStruct();
  level.camera_loadout_showcase_l.basecam = getEnt("_encstr_86151939E95257ED408791D8918AF385FACAE1C4D290C925AD77D9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_l.basecam.depthoffieldvalues = [9, 23];
  level.camera_loadout_showcase_l.myfov = 55;
  level.camera_loadout_showcase_l.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_l.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_l.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_l._id_1370F = 6;
  level.camera_loadout_showcase_t = spawnStruct();
  level.camera_loadout_showcase_t.basecam = getEnt("_encstr_9715196CB06B59C958EB5B077DB3AEB96EDA2D1D1ABE0BB1A3EB8E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_t.basecam.depthoffieldvalues = [13, 18];
  level.camera_loadout_showcase_t.myfov = 55;
  level.camera_loadout_showcase_t.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_t.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_t.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_t._id_1370F = 6;
  level.camera_loadout_showcase_perks = spawnStruct();
  level.camera_loadout_showcase_perks.basecam = getEnt("_encstr_95B91D07DA7BF8635F21738A5097F0400880E36341AFA90838B7711FC82BA7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_perks.basecam.depthoffieldvalues = [14, 25];
  level.camera_loadout_showcase_perks.myfov = 55;
  level.camera_loadout_showcase_perks.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_perks.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_perks.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_perks._id_1370F = 6;
  level.camera_loadout_showcase_x = spawnStruct();
  level.camera_loadout_showcase_x.basecam = getEnt("_encstr_AC1519DB7BD0E70B772602DB0E5C2F9D88FB593481992E3BA55E4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_x.basecam.depthoffieldvalues = [16, 16];
  level.camera_loadout_showcase_x.myfov = 55;
  level.camera_loadout_showcase_x.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_x.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_x.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_x._id_1370F = 6;
  level.camera_loadout_showcase_y = spawnStruct();
  level.camera_loadout_showcase_y.basecam = getEnt("_encstr_B8151943D748229B737E47F987608F5B53CB94FB54069F2B7BF1BB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_y.basecam.depthoffieldvalues = [16, 16];
  level.camera_loadout_showcase_y.myfov = 55;
  level.camera_loadout_showcase_y.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_y.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_y.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_y._id_1370F = 6;
  level.camera_loadout_showcase_z = spawnStruct();
  level.camera_loadout_showcase_z.basecam = getEnt("_encstr_8E15196912B74D68AEAF330187176880674AA0F3EA27F750035705", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_z.basecam.depthoffieldvalues = [16, 16];
  level.camera_loadout_showcase_z.myfov = 55;
  level.camera_loadout_showcase_z.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_z.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_z.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_z._id_1370F = 6;
  level.camera_loadout_showcase_specialist = spawnStruct();
  level.camera_loadout_showcase_specialist.basecam = getEnt("_encstr_A9D422FF57489DD85EF13DC1C6DA6D65936D531170AFCBF1ACBF9B437F0F623FE468EB28", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_specialist.basecam.depthoffieldvalues = [22, 16];
  level.camera_loadout_showcase_specialist.myfov = 55;
  level.camera_loadout_showcase_specialist.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_specialist.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_specialist.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_specialist._id_1370F = 6;
  level.camera_loadout_showcase_watch = spawnStruct();
  level.camera_loadout_showcase_watch.basecam = getEnt("_encstr_A6FF1D07311080336A87E0C7A6C78B1D47EB1A8303D9418328C9D7FF35EA73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_watch.basecam.depthoffieldvalues = [22, 8];
  level.camera_loadout_showcase_watch.myfov = 55;
  level.camera_loadout_showcase_watch.weapon_locs[0] = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_watch.weapon_locs[1] = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_watch.weapon_locs[3] = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_watch._id_1370F = 6;
  level.camera_loadout_showcase_preview_riot = spawnStruct();
  level.camera_loadout_showcase_preview_riot.basecam = getEnt("_encstr_BE0C20FFBFEA8DD02999F853B117D0B0A31763297311CF9845AB60C9A3C7207B1ADB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_riot.basecam.depthoffieldvalues = [16, 152];
  level.camera_loadout_showcase_preview_riot.myfov = 36;
  level.camera_loadout_showcase_preview_riot.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_riot._id_1370F = 6;
  level.camera_loadout_showcase_preview_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_barrel.basecam = getEnt("_encstr_ACEE22DF93F91A3A48D66D32CE2065E24E337F1B690893F2409B647FE309BAAAA665F7F3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_barrel.basecam.depthoffieldvalues = [8, 34];
  level.camera_loadout_showcase_preview_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_barrel.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_barrel._id_1370F = 6;
  level.camera_loadout_showcase_preview_barrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt1.basecam = getEnt("_encstr_93BC277A61F9C7CA50DF0570C7B8D3231E185293E858CB8218A5091D7F515E67C6536A9A962F73FB82", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_barrel_alt1.basecam.depthoffieldvalues = [8, 48];
  level.camera_loadout_showcase_preview_barrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_barrel_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_barrel_alt1._id_1370F = 6;
  level.gameplay_main = spawnStruct();
  level.gameplay_main.basecam = getEnt("_encstr_91BC27B1C25B953916D7B6C1D7CEEADC6EB62DD11AFAE03956EC4BACBBFAC458C9275963EBB0631D19", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gameplay_main.basecam.depthoffieldvalues = [8, 54];
  level.gameplay_main.myfov = 36;
  level.gameplay_main.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gameplay_main._id_1370F = 6;
  level.camera_loadout_showcase_preview_charm = spawnStruct();
  level.camera_loadout_showcase_preview_charm.basecam = getEnt("_encstr_92BD21C0CA852BAB6FAF41C7578FB3F5EA9218C0F25179E357AE5BB5574739A1D68BA0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_charm.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm.myfov = 36;
  level.camera_loadout_showcase_preview_charm.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_charm._id_1370F = 6;
  level.camera_loadout_showcase_preview_charm_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt1.basecam = getEnt("_encstr_8696262ED99895CB575F6F13770CE3C69B20247350B14803BD15475F5F384A08486B5D31E9C0F44F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_charm_alt1.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_charm_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_charm_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt2.basecam = getEnt("_encstr_AF96269E19EA1D0D613970A07FA29B1060454983B467ABDD0FB85942A3A94EC45FA821979A657097", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_charm_alt2.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt2.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_charm_alt2._id_1370F = 6;
  level.camera_loadout_showcase_preview_charm_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt3.basecam = getEnt("_encstr_8D9626AE067F901DB1F130599F67885AB73829530841E3062B3B63C85C77DE439E73139FF3081BCB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_charm_alt3.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt3.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt3.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_charm_alt3._id_1370F = 6;
  level.gameskill_init = spawnStruct();
  level.gameskill_init.basecam = getEnt("_encstr_8C9626360BB6569C0BF55BE0BEEC5D9BE66B4BE8D0BE8327CAEC2D59DDEB3686169C6BAFC2B14743", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gameskill_init.basecam.depthoffieldvalues = [21, 18];
  level.gameskill_init.myfov = 36;
  level.gameskill_init.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gameskill_init._id_1370F = 6;
  level.gameskill_set_player = spawnStruct();
  level.gameskill_set_player.basecam = getEnt("_encstr_9A96265F631D97B5B66045D9990FAB08A3C8D1505097A29B20506B20234057718FDB625736EBA3DD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gameskill_set_player.basecam.depthoffieldvalues = [22, 18];
  level.gameskill_set_player.myfov = 36;
  level.gameskill_set_player.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gameskill_set_player._id_1370F = 6;
  level.gamestatedisplaymonitor = spawnStruct();
  level.gamestatedisplaymonitor.basecam = getEnt("_encstr_BA96262FFFB82533F92188035F40A3B23312AB84D227CAC223F8C98DA7F962E1E8C6C7BF17B1A112", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamestatedisplaymonitor.basecam.depthoffieldvalues = [21, 16];
  level.gamestatedisplaymonitor.myfov = 36;
  level.gamestatedisplaymonitor.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamestatedisplaymonitor._id_1370F = 6;
  level.camera_loadout_showcase_preview_laser = spawnStruct();
  level.camera_loadout_showcase_preview_laser.basecam = getEnt("_encstr_85AE21EE1958550B979FAFD3B74CA3864060E4B390710843FDD5879F1F787AC118C9DA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_laser.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser.myfov = 36;
  level.camera_loadout_showcase_preview_laser.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_laser._id_1370F = 6;
  level.camera_loadout_showcase_preview_laser_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_laser_alt1.basecam = getEnt("_encstr_A2F226AFEFBADDE019A9288341C7AB80F3673319A3E11FA835FB50397397804F2BAFBDC71F7AE58A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_laser_alt1.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_laser_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_laser_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_laser_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_laser_alt2.basecam = getEnt("_encstr_B6F2268B5E9F87CA688119DB4E81E3EADFEF28F18B21D77D4A935141136FD05720BF0631B3B59446", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_laser_alt2.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_laser_alt2.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_laser_alt2._id_1370F = 6;
  level.camera_loadout_showcase_preview_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_magazine.basecam = getEnt("_encstr_8820249E76FAE36B416778887F9F433DE39D039D8C7191132DEB5028378F185B0A0602AB658A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_magazine.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_magazine.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_magazine._id_1370F = 6;
  level.camera_loadout_showcase_preview_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt1.basecam = getEnt("_encstr_AD7029B158D62B27C2BEB538FACE5D3737B596D1A1FA3839ACEC2D2BBBD7B558EC2CF4D2DCB27DB01B3A98", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_magazine_alt1.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_magazine_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_magazine_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_magazine_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt2.basecam = getEnt("_encstr_9770291B2CB52B39B07DAD0ED7ECBA37CDB6D2D143AF079C56CEB4B2DDFAD6C27616F4B473ACAFC2631DC8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_magazine_alt2.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_magazine_alt2.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_magazine_alt2._id_1370F = 6;
  level.camera_loadout_showcase_preview_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle.basecam = getEnt("_encstr_9187221B2CB6B239C27DDA387DECEAB9B9B5B4E843D7833995D9B42BEEAFD6D59EF43656", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_muzzle.basecam.depthoffieldvalues = [12, 30];
  level.camera_loadout_showcase_preview_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_muzzle.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_muzzle._id_1370F = 6;
  level.camera_loadout_showcase_preview_muzzle_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle_alt1.basecam = getEnt("_encstr_A57E27AEC7A32AF2A971275B5941CD223769B4E33B9F333AF1C02F37BB3E9D5BDD7A7DDF080B2A6413", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_muzzle_alt1.basecam.depthoffieldvalues = [18, 32];
  level.camera_loadout_showcase_preview_muzzle_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_muzzle_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_muzzle_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_optic = spawnStruct();
  level.camera_loadout_showcase_preview_optic.basecam = getEnt("_encstr_93BF217A61F9C7CA50DF0570C7B8D3231E185293E858CB8218A5091D7F511D23C5300A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_optic.basecam.depthoffieldvalues = [21.5, 17];
  level.camera_loadout_showcase_preview_optic.myfov = 36;
  level.camera_loadout_showcase_preview_optic.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_optic._id_1370F = 6;
  level.camera_loadout_showcase_preview_optic_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_optic_alt1.basecam = getEnt("_encstr_99AA26C32F300F0A5371527B89A703EB2B81416C331E235273101A22E0FFFDCB637BD3CFDFC0FB4A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_optic_alt1.basecam.depthoffieldvalues = [21.5, 17];
  level.camera_loadout_showcase_preview_optic_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_optic_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_optic_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip.basecam = getEnt("_encstr_B8EC24179030C5836BAFEDA2681F8B869B68B7F370AE284B4BACF49F6447335561F8176380E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_reargrip.basecam.depthoffieldvalues = [8, 20];
  level.camera_loadout_showcase_preview_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_reargrip._id_1370F = 6;
  level.camera_loadout_showcase_preview_reargrip_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip_alt1.basecam = getEnt("_encstr_9939296C0BB5B24E58FA5B38BEB3EACDE6ADB48E34FA0EC9B267B4B2EEAFE42B853976C9D20EBE58B13A89", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_reargrip_alt1.basecam.depthoffieldvalues = [8, 20];
  level.camera_loadout_showcase_preview_reargrip_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_reargrip_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_reargrip_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip_alt2.basecam = getEnt("_encstr_9B39292EC64A53DBF1F7E8F80F0FF38D736D932D1C010183DD7BC058871F6BC3FA521CB6344B97298C6B02", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_reargrip_alt2.basecam.depthoffieldvalues = [12, 22];
  level.camera_loadout_showcase_preview_reargrip_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip_alt2.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_reargrip_alt2._id_1370F = 6;
  level.gas_fx = spawnStruct();
  level.gas_fx.basecam = getEnt("_encstr_876E239FDF8AEDF009B9D87351F730908377030953F12FB825CB402943E748D59AA79FA343", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_fx.basecam.depthoffieldvalues = [20, 32];
  level.gas_fx.myfov = 36;
  level.gas_fx.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_fx._id_1370F = 6;
  level.gas_linger_large_vfx = spawnStruct();
  level.gas_linger_large_vfx.basecam = getEnt("_encstr_B6EA289289113F32B807ADB86FE0BB4B46A08A6B30E0A3EAA04DD1B507F9C2EBE31922E29B589F25C0EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_linger_large_vfx.basecam.depthoffieldvalues = [20, 32];
  level.gas_linger_large_vfx.myfov = 36;
  level.gas_linger_large_vfx.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_linger_large_vfx._id_1370F = 6;
  level.gas_linger_vfx = spawnStruct();
  level.gas_linger_vfx.basecam = getEnt("_encstr_84EA282239A18F8228975D48FF700BDBD6D01ADBA010137AD0FD4125B789527B7389B2720BC80FB5709D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_linger_vfx.basecam.depthoffieldvalues = [20, 34];
  level.gas_linger_vfx.myfov = 36;
  level.gas_linger_vfx.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_linger_vfx._id_1370F = 6;
  level.gas_payloads = spawnStruct();
  level.gas_payloads.basecam = getEnt("_encstr_B2EA28B2885B27B359C00510F8A197ADCF709ABBA867DA7B31BC193D84CEC7F303A82222C08F565B4B06", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_payloads.basecam.depthoffieldvalues = [20, 34];
  level.gas_payloads.myfov = 36;
  level.gas_payloads.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_payloads._id_1370F = 6;
  level.gas_sequence_activated = spawnStruct();
  level.gas_sequence_activated.basecam = getEnt("_encstr_A2EA28A837DD014DB24921B7510A9BA82BFF7088BB57FB059A2B2B35B3A1DF93696F98884B3F11C1B3C3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_sequence_activated.basecam.depthoffieldvalues = [20, 34];
  level.gas_sequence_activated.myfov = 36;
  level.gas_sequence_activated.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_sequence_activated._id_1370F = 6;
  level.camera_loadout_showcase_preview_stock = spawnStruct();
  level.camera_loadout_showcase_preview_stock.basecam = getEnt("_encstr_BA4321B827CD317D82593147A11A8B983B8F60B8ABA7EB35EA3B3BC583B1CF839F5FE8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_stock.basecam.depthoffieldvalues = [12, 40];
  level.camera_loadout_showcase_preview_stock.myfov = 36;
  level.camera_loadout_showcase_preview_stock.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_stock._id_1370F = 6;
  level.camera_loadout_showcase_preview_stock_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt1.basecam = getEnt("_encstr_824426B6BF3BAD6899962D09BF2F3B256AE8808D804F18885B54A0A7E761B66C1027AC7188BABBA7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_stock_alt1.basecam.depthoffieldvalues = [12, 40];
  level.camera_loadout_showcase_preview_stock_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_stock_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_stock_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_stock_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt2.basecam = getEnt("_encstr_924426E74145302E97F9A8F3017765A01AD57B71E0A1E076AF432059ABBF1E28B533E7AF91D5089E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_stock_alt2.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_stock_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_stock_alt2.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_stock_alt2._id_1370F = 6;
  level.camera_loadout_showcase_preview_underbarrel = spawnStruct();
  level.camera_loadout_showcase_preview_underbarrel.basecam = getEnt("_encstr_9A3227808AC56BEB2FEF0187974F73352AD25880B291B92317EE1B759787BBED573A18B8DA72F599EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_underbarrel.basecam.depthoffieldvalues = [10, 34];
  level.camera_loadout_showcase_preview_underbarrel.myfov = 36;
  level.camera_loadout_showcase_preview_underbarrel.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_underbarrel._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_small_barrel.basecam = getEnt("_encstr_8A7D28DEAB288D90A036803BC1EF5545EF308AC39B79E0C6E7C01B48F3CE03C871382167690FB3BE5734", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_barrel.basecam.depthoffieldvalues = [12, 22.5];
  level.camera_loadout_showcase_preview_small_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_small_barrel.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_barrel._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_charm = spawnStruct();
  level.camera_loadout_showcase_preview_small_charm.basecam = getEnt("_encstr_BD1927DB7BD0E70B772602DB0E5C2F9D88FB593481996A432D7B5AB213B8FF156051C4972F48769BC1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_charm.basecam.depthoffieldvalues = [21, 15];
  level.camera_loadout_showcase_preview_small_charm.myfov = 36;
  level.camera_loadout_showcase_preview_small_charm.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_charm._id_1370F = 6;
  level.gas_badplace = spawnStruct();
  level.gas_badplace.basecam = getEnt("_encstr_AC132CDB7BD0E70B772602DB0E5C2F9D88FB593481996A432D7B5AB213B8FF156051C4972F48769BC176D22A9BA7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_badplace.basecam.depthoffieldvalues = [25, 19];
  level.gas_badplace.myfov = 36;
  level.gas_badplace.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_badplace._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_laser = spawnStruct();
  level.camera_loadout_showcase_preview_small_laser.basecam = getEnt("_encstr_8DE2276C165B2B9385AFD683EB9DEACDE6DAA5D1D0AF0793569DA556EED7DCB60BB11BF5360B37599C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_laser.basecam.depthoffieldvalues = [12, 19];
  level.camera_loadout_showcase_preview_small_laser.myfov = 36;
  level.camera_loadout_showcase_preview_small_laser.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_laser._id_1370F = 6;
  level.gas_cloud_vfx = spawnStruct();
  level.gas_cloud_vfx.basecam = getEnt("_encstr_82372C07A1E5908E375908936117C573BA359BD140C180D64FA380390B1FFE40569C090FFC36D095CB29998D23FE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_cloud_vfx.basecam.depthoffieldvalues = [8, 25];
  level.gas_cloud_vfx.myfov = 36;
  level.gas_cloud_vfx.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_cloud_vfx._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine.basecam = getEnt("_encstr_82E72AB116B5569C85F5ADC1FA3BBAE6E6AD4BD10DD7C193ACCEA595777D9BDA0B63367D6BC2CE2CA7A5CD95", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_magazine.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_small_magazine.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_magazine._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine_alt1.basecam = getEnt("_encstr_95902FB997C1BB035A48A56AA7CFC3930392F1D95B59416D02A35F2BBBBFF78A2A39CB374D76389F08CC20272197A0BCAE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_magazine_alt1.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_small_magazine_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_magazine_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_small_muzzle.basecam = getEnt("_encstr_ABC728362C5B2B27C2BEB6C17DD9AB37CDDAA51D0D7DE039B2CE2DAC777DB95B2CC68DAFB657E9A7D8B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_muzzle.basecam.depthoffieldvalues = [16, 25];
  level.camera_loadout_showcase_preview_small_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_small_muzzle.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_muzzle._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_optic = spawnStruct();
  level.camera_loadout_showcase_preview_small_optic.basecam = getEnt("_encstr_9761271BBB10274B3766429B4E1C6F5D483B9974C1D92A83EDBB1AF253783F55209104D77748F3B786", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_optic.basecam.depthoffieldvalues = [20, 15];
  level.camera_loadout_showcase_preview_small_optic.myfov = 36;
  level.camera_loadout_showcase_preview_small_optic.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_optic._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_small_reargrip.basecam = getEnt("_encstr_AAB22A017ADFD5F006078BA91FEF8028DFD2D86B52BF9708DF068B8B5FD968613F5AF0B61B8F474077FAB3D9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_reargrip.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_small_reargrip.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_reargrip._id_1370F = 6;
  level.gas_emit_vfx = spawnStruct();
  level.gas_emit_vfx.basecam = getEnt("_encstr_92032F9FDF8AEDF009B9D87351F730908377030953F12FB825CB402943E748591A9B91D743FA7F607FA248836181680D77", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_emit_vfx.basecam.depthoffieldvalues = [12, 20];
  level.gas_emit_vfx.myfov = 36;
  level.gas_emit_vfx.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_emit_vfx._id_1370F = 6;
  level.gas_flyby_plane = spawnStruct();
  level.gas_flyby_plane.basecam = getEnt("_encstr_BE452933FFE0DFDA83C1E22BD9D753BB9B51B1BC834E53E2A3E0AA72B04F0A0FB1490C1FA6737F6E474063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_flyby_plane.basecam.depthoffieldvalues = [16, 22];
  level.gas_flyby_plane.myfov = 36;
  level.gas_flyby_plane.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_flyby_plane._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_stock = spawnStruct();
  level.camera_loadout_showcase_preview_small_stock.basecam = getEnt("_encstr_B16D27A651101D53DFD7D79BEFF46B5EB8B85CEBE829B08B256DCFC7D7B03385C02095B9238867D20A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_stock.basecam.depthoffieldvalues = [16, 36];
  level.camera_loadout_showcase_preview_small_stock.myfov = 36;
  level.camera_loadout_showcase_preview_small_stock.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_stock._id_1370F = 6;
  level.camera_loadout_showcase_preview_small_trigger = spawnStruct();
  level.camera_loadout_showcase_preview_small_trigger.basecam = getEnt("_encstr_8EE92981FA5F557086870B299F6FABA85F5258EBD23F17885F860B0BDF59E8E1BFDA7036FB53C368F76D05", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_trigger.basecam.depthoffieldvalues = [21, 12];
  level.camera_loadout_showcase_preview_small_trigger.myfov = 36;
  level.camera_loadout_showcase_preview_small_trigger.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_small_trigger._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_large_barrel.basecam = getEnt("_encstr_BE70286CB06BCA270BF5DAE0FA76AB9B6EB6A547D0EB1CE4AC67962B77AFB1C239CEACFA89C2C9C959B1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_barrel.basecam.depthoffieldvalues = [12, 46];
  level.camera_loadout_showcase_preview_large_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_large_barrel.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_barrel._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_charm = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm.basecam = getEnt("_encstr_99992746B1F0FDB33F3737BBCFD40B3ED8987C0B080990EB054D2FE7B790E2697821F7590108492369", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_charm.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_charm._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_charm_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm_alt1.basecam = getEnt("_encstr_91E82CB12CDA95272CEB6B1CBEECBA9BE6D6B4A31AEB0E272B9DD22BEEEB8DC2E476ACF51BA12C395BF52CB18E98", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_charm_alt1.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_charm_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_charm_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm_alt2.basecam = getEnt("_encstr_93E82C634F506F6A331132DB2907E30BCB21E10C53BE83B2D3B07A82BB1F9DEF039C75AF7EA00FFA9BE1E20AA31D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_charm_alt2.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm_alt2.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_charm_alt2._id_1370F = 6;
  level.gametypefilter = spawnStruct();
  level.gametypefilter.basecam = getEnt("_encstr_A3E82C5B58909ABE29C67050CF9C90B82EA8DBEBCC89FB63FDDD24C3EB08752FDA77A38116E822DE403E58A18B33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypefilter.basecam.depthoffieldvalues = [25, 19];
  level.gametypefilter.myfov = 36;
  level.gametypefilter.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypefilter._id_1370F = 6;
  level.gametypekillsperhouravg = spawnStruct();
  level.gametypekillsperhouravg.basecam = getEnt("_encstr_8EE82C81FA5F557086870B299F6FABA85F5258EBD23F17885F860B0BDF5910E7F36A51368A3BC7C075572361E46B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypekillsperhouravg.basecam.depthoffieldvalues = [21, 16];
  level.gametypekillsperhouravg.myfov = 36;
  level.gametypekillsperhouravg.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypekillsperhouravg._id_1370F = 6;
  level.gametypekillspermatchmax = spawnStruct();
  level.gametypekillspermatchmax.basecam = getEnt("_encstr_BEE82CBF38985D1B83E8154AF0A723EEE3F00F6B88368023D3141C07CC2F6AA9AB38B73F7888C9EB2BB8667DB5D3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypekillspermatchmax.basecam.depthoffieldvalues = [21, 17];
  level.gametypekillspermatchmax.myfov = 36;
  level.gametypekillspermatchmax.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypekillspermatchmax._id_1370F = 6;
  level.gametypeoverrideassassinsearchparams = spawnStruct();
  level.gametypeoverrideassassinsearchparams.basecam = getEnt("_encstr_ACE82C1EC2508A9307C1207B37C773D5D3DDAF5B713138639A232C234B9769313329DF09AEE8D29697A1165B54B3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypeoverrideassassinsearchparams.basecam.depthoffieldvalues = [21, 17];
  level.gametypeoverrideassassinsearchparams.myfov = 36;
  level.gametypeoverrideassassinsearchparams.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypeoverrideassassinsearchparams._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_barrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_barrel_alt1.basecam = getEnt("_encstr_BD7F2DA99EA5E0F6C2A73B098F8ABD60537510C3442F83AEFA1B0B3BD7D109500A4F193E6E79A866D21B6F3B930BEF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_barrel_alt1.basecam.depthoffieldvalues = [16, 52];
  level.camera_loadout_showcase_preview_large_barrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_barrel_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_barrel_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_laser = spawnStruct();
  level.camera_loadout_showcase_preview_large_laser.basecam = getEnt("_encstr_83B827EAD0038F1BE168ADC8AF494F156718F213438F02C359E4A1D52C96D31ECD30BA39C84BBAD753", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_laser.basecam.depthoffieldvalues = [12, 26];
  level.camera_loadout_showcase_preview_large_laser.myfov = 36;
  level.camera_loadout_showcase_preview_large_laser.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_laser._id_1370F = 6;
  level.gametypeoverridedomsearchparams = spawnStruct();
  level.gametypeoverridedomsearchparams.basecam = getEnt("_encstr_83012C8D586B59C958BEB507AFB35DE637DAD2A3A1FAC1272B67D256DD7D360B933BB27D1B2CCDB24EBE588D1D13", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypeoverridedomsearchparams.basecam.depthoffieldvalues = [12, 26];
  level.gametypeoverridedomsearchparams.myfov = 36;
  level.gametypeoverridedomsearchparams.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypeoverridedomsearchparams._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine.basecam = getEnt("_encstr_84542AAEEFB2BD306797B59A4F0425A0ABC9E3DBC1279B1B7D2333CFD316151F262FD02791A9373A888F305A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_magazine.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_magazine._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt1.basecam = getEnt("_encstr_8E862FCAF023AF3BC1488DA860296F3547F8123320EF22E3B9C481B50C76333EAD105A19A06B5FE772A39EAD3059FB0393", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_magazine_alt1.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_magazine_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_magazine_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt2.basecam = getEnt("_encstr_B8862F120991BFB238872D38EF603BCBC6200AEBB060236A20CD51358779853FEE1942C1F8C707E630DB5E3D3FA0CDD336", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_magazine_alt2.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt2.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_magazine_alt2._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_large_muzzle.basecam = getEnt("_encstr_834F2876728A6D2AB1FFD263A7C85B151F49D07B789989638F5348FFEFE7957B9ADFC7AFC205D380FB3F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_muzzle.basecam.depthoffieldvalues = [21, 34];
  level.camera_loadout_showcase_preview_large_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_large_muzzle.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_muzzle._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_muzzle_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam = getEnt("_encstr_ABBB2DB185D6AC2758F5AD1CFA76AB379BD62DD1867D83C9ACB32DB2DDEB36169CECCAEBB6EA9E4FB12BD7161BE84C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam.depthoffieldvalues = [21, 32];
  level.camera_loadout_showcase_preview_large_muzzle_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_muzzle_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_muzzle_alt1._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_optic = spawnStruct();
  level.camera_loadout_showcase_preview_large_optic.basecam = getEnt("_encstr_931F27AE46CAD35B717768788F8F730DF3ED13AD9C8181035DFB40D8079F284B4B979DA035CB41A803", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_optic.basecam.depthoffieldvalues = [21.5, 25];
  level.camera_loadout_showcase_preview_large_optic.myfov = 36;
  level.camera_loadout_showcase_preview_large_optic.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_optic._id_1370F = 6;
  level.gametypeoverridescavsearchparams = spawnStruct();
  level.gametypeoverridescavsearchparams.basecam = getEnt("_encstr_9BD62C1BBB10274B3766429B4E1C6F5D483B9974C1D92A83EDBB1AF253784356B8870DD77748F3B786B6926A5B67", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypeoverridescavsearchparams.basecam.depthoffieldvalues = [21.5, 25];
  level.gametypeoverridescavsearchparams.myfov = 36;
  level.gametypeoverridescavsearchparams.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypeoverridescavsearchparams._id_1370F = 6;
  level.gametyperoundendscoresetomnvar = spawnStruct();
  level.gametyperoundendscoresetomnvar.basecam = getEnt("_encstr_99D62CC3FED9F852A1DFD8C8C9BAFD533810BBC574C05F161243B81F6F97C2D2A317ED0737CF64A49F911F1B542A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametyperoundendscoresetomnvar.basecam.depthoffieldvalues = [21.5, 25];
  level.gametyperoundendscoresetomnvar.myfov = 36;
  level.gametyperoundendscoresetomnvar.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametyperoundendscoresetomnvar._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_large_reargrip.basecam = getEnt("_encstr_95342AC6C25B959C0BEBAD83AFCEBA376EDAD2471ABE38C9ACECA5B2BBEBD8589C3B56AF9C56164EEC279607", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_reargrip.basecam.depthoffieldvalues = [12, 23];
  level.camera_loadout_showcase_preview_large_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_large_reargrip.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_reargrip._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_reargrip_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam = getEnt("_encstr_96662FB1868DC8DEFA8F23E17762A5584B1D78EB6CD71896920323C3FFC96178E27761069255584EEA0B3BF14772B918D9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam.depthoffieldvalues = [12, 21];
  level.camera_loadout_showcase_preview_large_reargrip_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_reargrip_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_reargrip_alt1._id_1370F = 6;
  level.gametypeweaponxpmodifier = spawnStruct();
  level.gametypeweaponxpmodifier.basecam = getEnt("_encstr_A66829707A35BB3BFFDF31B7C73F03651A02A85082C1C973C71ECB25C7B768C3824A7081ABA3336987354E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypeweaponxpmodifier.basecam.depthoffieldvalues = [20, 32];
  level.gametypeweaponxpmodifier.myfov = 36;
  level.gametypeweaponxpmodifier.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gametypeweaponxpmodifier._id_1370F = 6;
  level.garbage_bin_clip = spawnStruct();
  level.garbage_bin_clip.basecam = getEnt("_encstr_87022EA9D2770D28EEEF7341C7572840A78A60B3AA673F6087BE6353F7B1289FDB82795EA3A3FB30DC855D2F0925B07F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.garbage_bin_clip.basecam.depthoffieldvalues = [20, 35];
  level.garbage_bin_clip.myfov = 36;
  level.garbage_bin_clip.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.garbage_bin_clip._id_1370F = 6;
  level.gas_at_computer = spawnStruct();
  level.gas_at_computer.basecam = getEnt("_encstr_92022E9FDF8AEDF009B9D87351F730908377030953F12FB825CB402943E7B05F2BB783D747EB7BE873672B66EE8CA82E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_at_computer.basecam.depthoffieldvalues = [20, 32];
  level.gas_at_computer.myfov = 36;
  level.gas_at_computer.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_at_computer._id_1370F = 6;
  level.gas_attack = spawnStruct();
  level.gas_attack.basecam = getEnt("_encstr_82022E5F5158ABB3C1E1A9CFF6A7855D6BEB4FACA1A9289B1F7C4878DF49F49AB3C47ACF03AB0901DB17D6594A082B76", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_attack.basecam.depthoffieldvalues = [20, 35];
  level.gas_attack.myfov = 36;
  level.gas_attack.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_attack._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_stock = spawnStruct();
  level.camera_loadout_showcase_preview_large_stock.basecam = getEnt("_encstr_9B1227E68F9B123A61A9EFA39199F56A7F11ECDBE357FB628988F7FF3876D4C215BC7799D67942BB90", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_stock.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_large_stock.myfov = 36;
  level.camera_loadout_showcase_preview_large_stock.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_stock._id_1370F = 6;
  level.gas_attack_deploy = spawnStruct();
  level.gas_attack_deploy.basecam = getEnt("_encstr_A7772CE760C01553BBD0DD92386FFBD6ABB8472340FE581B9B5C24CF14772261533BCF079B338F32FFE02E85FD93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_attack_deploy.basecam.depthoffieldvalues = [16, 43];
  level.gas_attack_deploy.myfov = 36;
  level.gas_attack_deploy.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gas_attack_deploy._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_underbarrel = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel.basecam = getEnt("_encstr_87482D5A60B33FAB71F83D3890D9FF85F76862A3907FB253295431259CE6438E5DA02AA990C5EF47E3B6014A36490B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_underbarrel.basecam.depthoffieldvalues = [20, 35];
  level.camera_loadout_showcase_preview_large_underbarrel.myfov = 36;
  level.camera_loadout_showcase_preview_large_underbarrel.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_underbarrel._id_1370F = 6;
  level.camera_loadout_showcase_preview_large_underbarrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam = getEnt("_encstr_8BC43203A3083FA3DF9EAA83662477352013B19C29F102FBF593E2DA4B106BAE80FF352F7BC0CF6F26097AB3F355A3E96041BCC9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam.depthoffieldvalues = [20, 36];
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.weapon_locs[2] = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_loadout_showcase_preview_large_underbarrel_alt1._id_1370F = 6;
  level.camera_character_tango = spawnStruct();
  level.camera_character_tango.basecam = getEnt("_encstr_AC550BB2C043E207FBDF0607E0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_character_tango.basecam.depthoffieldvalues = [4.5, 125];
  level.camera_character_tango.myfov = 30;
  level.camera_character_tango.update_char_loc = ::update_main_menu_char_loc;
  level.camera_character_tango._id_1370F = 6;
  level.camera_character_faction_select_l = spawnStruct();
  level.camera_character_faction_select_l.basecam = getEnt("_encstr_8A9A1346D35E28164719CBCBB07277A7AFEDF2D728", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_character_faction_select_l.basecam.depthoffieldvalues = [22, 98];
  level.camera_character_faction_select_l.myfov = 37;
  level.camera_character_faction_select_l.update_char_loc = ::_id_13FA5;
  level.camera_character_faction_select_l._id_1370F = 6;
  level.camera_character_faction_select_l_detail = spawnStruct();
  level.camera_character_faction_select_l_detail.basecam = getEnt("_encstr_8C740CE630304AC194E3EFCBAF36", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_character_faction_select_l_detail.basecam.depthoffieldvalues = [22, 181];
  level.camera_character_faction_select_l_detail.myfov = 37;
  level.camera_character_faction_select_l_detail.update_char_loc = ::_id_13FA5;
  level.camera_character_faction_select_l_detail._id_1370F = 6;
  level.camera_character_faction_select_r = spawnStruct();
  level.camera_character_faction_select_r.basecam = getEnt("_encstr_979513A70806C8F8C75A2BB3C1AFB0305F8C2B0BA4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_character_faction_select_r.basecam.depthoffieldvalues = [22, 98];
  level.camera_character_faction_select_r.myfov = 37;
  level.camera_character_faction_select_r.update_char_loc = ::_id_13FA4;
  level.camera_character_faction_select_r.char_index = 1;
  level.camera_character_faction_select_r._id_1370F = 6;
  level.camera_character_faction_select_r_detail = spawnStruct();
  level.camera_character_faction_select_r_detail.basecam = getEnt("_encstr_85BA0C5A28ABFA1FF1E7233C9019", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_character_faction_select_r_detail.basecam.depthoffieldvalues = [22, 181];
  level.camera_character_faction_select_r_detail.myfov = 37;
  level.camera_character_faction_select_r_detail.update_char_loc = ::_id_13FA4;
  level.camera_character_faction_select_r_detail.char_index = 1;
  level.camera_character_faction_select_r_detail._id_1370F = 6;
  level.gamemodemolotovfunc = spawnStruct();
  level.gamemodemolotovfunc.basecam = getEnt("_encstr_8B6E1420C33133C7502B086BFBF5EF67893BFBAAFBB8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamemodemolotovfunc.basecam.depthoffieldvalues = [22, 60];
  level.gamemodemolotovfunc.myfov = 37;
  level.gamemodemolotovfunc.char_loc = getEnt("_encstr_8B8616AA40337BE30D2068E1DE617E4E10790EEF6B2735E7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamemodemolotovfunc._id_1370F = 6;
  level.gamemodeoverridemeleeviewkickscale = spawnStruct();
  level.gamemodeoverridemeleeviewkickscale.basecam = getEnt("_encstr_9AF10D1B3458397D83935967B4CADD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamemodeoverridemeleeviewkickscale.basecam.depthoffieldvalues = [22, 181];
  level.gamemodeoverridemeleeviewkickscale.myfov = 37;
  level.gamemodeoverridemeleeviewkickscale.char_loc = getEnt("_encstr_8B8616AA40337BE30D2068E1DE617E4E10790EEF6B2735E7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gamemodeoverridemeleeviewkickscale._id_1370F = 6;
  level.camera_quartermaster = spawnStruct();
  level.camera_quartermaster.basecam = getEnt("_encstr_A67213EE08E72BD732237010CBCF45AD3FBBED558A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_quartermaster.basecam.depthoffieldvalues = [16, 264];
  level.camera_quartermaster.myfov = 28;
  level.camera_quartermaster_detail = spawnStruct();
  level.camera_quartermaster_detail.basecam = getEnt("_encstr_8D161AA03AE6252E0FA567E69C67B3D34E13906873B1B12173D97BD1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_quartermaster_detail.basecam.depthoffieldvalues = [22, 264];
  level.camera_quartermaster_detail.myfov = 28;
  level.camera_lobby = spawnStruct();
  level.camera_lobby.basecam = getEnt("_encstr_B8A40B4004FEE08961A84BFA8A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_lobby.basecam.depthoffieldvalues = [3.5, 225];
  level.camera_lobby.myfov = 36;
  level.camera_lobby.update_char_loc = ::update_lobby_char_loc;

  if(isDefined(level.playersetomnvargulag) && level.playersetomnvargulag == 1)
    level.camera_lobby._id_1370F = 5;

  if(isDefined(level.playersetwasingulag) && level.playersetwasingulag == 1 || isDefined(level.playersetplunderomnvar) && level.playersetplunderomnvar == 1)
    level.camera_lobby._id_1370F = 8;

  if(isDefined(level.playersetwasingulag) && level.playersetwasingulag == 1 || isDefined(level.playersetplunderomnvar) && level.playersetplunderomnvar == 1)
    level.camera_lobby._id_13710 = 6;

  if(isDefined(level.playershooting) && level.playershooting == 1)
    level.camera_lobby._id_1370F = 8;

  if(isDefined(level.playershooting) && level.playershooting == 1)
    level.camera_lobby._id_13710 = 6;

  if(isDefined(level.playershowarenastartobjectivetext) && level.playershowarenastartobjectivetext == 1)
    level.camera_lobby._id_1370F = 8;

  if(isDefined(level.playershowarenastartobjectivetext) && level.playershowarenastartobjectivetext == 1) {
    level.camera_lobby._id_13710 = 6;
    level.camera_lobby.basecam.depthoffieldvalues = [3.1, 200];
  }

  if(isDefined(level.playerspawn) && level.playerspawn == 1)
    level.camera_lobby._id_1370F = 8;

  if(isDefined(level.playerspawn) && level.playerspawn == 1)
    level.camera_lobby._id_13710 = 6;

  level.camera_lobby_detail = spawnStruct();
  level.camera_lobby_detail.basecam = getEnt("_encstr_B87112F75876B88893EA59419387DDC8CBA96B71", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_lobby_detail.basecam.depthoffieldvalues = [3, 100];
  level.camera_lobby_detail.myfov = 36;
  level.camera_lobby_detail.update_char_loc = ::update_lobby_char_loc;

  if(isDefined(level.playersetomnvargulag) && level.playersetomnvargulag == 1)
    level.camera_lobby_detail._id_1370F = 5;

  if(isDefined(level.playersetwasingulag) && level.playersetwasingulag == 1 || isDefined(level.playersetplunderomnvar) && level.playersetplunderomnvar == 1)
    level.camera_lobby_detail._id_1370F = 8;

  if(isDefined(level.playersetwasingulag) && level.playersetwasingulag == 1 || isDefined(level.playersetplunderomnvar) && level.playersetplunderomnvar == 1)
    level.camera_lobby_detail._id_13710 = 6;

  if(isDefined(level.playershooting) && level.playershooting == 1)
    level.camera_lobby_detail._id_1370F = 8;

  if(isDefined(level.playershooting) && level.playershooting == 1)
    level.camera_lobby_detail._id_13710 = 6;

  if(isDefined(level.playershowarenastartobjectivetext) && level.playershowarenastartobjectivetext == 1)
    level.camera_lobby_detail._id_1370F = 8;

  if(isDefined(level.playershowarenastartobjectivetext) && level.playershowarenastartobjectivetext == 1)
    level.camera_lobby_detail._id_13710 = 6;

  if(isDefined(level.playerspawn) && level.playerspawn == 1)
    level.camera_lobby_detail._id_1370F = 8;

  if(isDefined(level.playerspawn) && level.playerspawn == 1)
    level.camera_lobby_detail._id_13710 = 6;

  level.camera_character_tournaments = spawnStruct();
  level.camera_character_tournaments.basecam = getEnt("_encstr_AC3A18D80DC2C9F547F6AB9C9BC26B5937A3FABDD9954EC616D6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.camera_character_tournaments.basecam.depthoffieldvalues = [22, 256];
  level.camera_character_tournaments.myfov = 36;
  level.camera_character_tournaments.update_char_loc = ::update_arena_char_loc;
  level.gameisending = spawnStruct();
  level.gameisending.basecam = getEnt("_encstr_AC3A18D80DC2C9F547F6AB9C9BC26B5937A3FABDD9954EC616D6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gameisending.basecam.depthoffieldvalues = [22, 256];
  level.gameisending.myfov = 36;
  level.gameisending.update_char_loc = ::_id_13F87;
}

setup_initial_entities() {
  level.characters = [];

  for(var_0 = 0; var_0 < 8; var_0++) {
    var_1 = undefined;
    var_2 = var_0 + 1;

    if(var_2 < 10)
      var_1 = getEnt("_encstr_8C1611BBD73622790199F4BE9348A44A951F52" + var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else
      var_1 = getEnt("_encstr_A36810B460995B9077D83AA238478D37F3C0" + var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    level.characters[var_0] = spawn("_encstr_8B211183A693105B187E973892C8933B9B5F38", var_1.origin, 0, 0, var_0, "_encstr_A78C12A94168635A569B8E34A11627856C1D959C");
  }

  level.characters[14] = spawn("_encstr_8B211183A693105B187E973892C8933B9B5F38", level.characters[0].origin, 0, 0, 14, "_encstr_A78C12A94168635A569B8E34A11627856C1D959C");
  level.characters[14].angles = (0, 270, 0);

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_2 = var_3 + 1;
    var_0 = 8 + var_3;
    var_1 = getEnt("_encstr_8C1611BBD73622790199F4BE9348A44A951F52" + var_2 + "_encstr_9A4305D962FDE7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.characters[var_0] = spawn("_encstr_8B211183A693105B187E973892C8933B9B5F38", var_1.origin, 0, 0, var_0, "_encstr_A78C12A94168635A569B8E34A11627856C1D959C");
    level.characters[var_0].update_focus_fire_heahicon = 1;
  }

  var_1 = getEnt("_encstr_8BE7191773C2EE488F3D401E26601826D9EB8B85F78A2088D9126B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.characters[12] = spawn("_encstr_8B211183A693105B187E973892C8933B9B5F38", var_1.origin, 0, 0, 12, "_encstr_A78C12A94168635A569B8E34A11627856C1D959C");
  var_1 = getEnt("_encstr_845D19413451A00ECAFF93EFD7E2DFE8D78B89781FB7114442E7A9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.characters[13] = spawn("_encstr_8B211183A693105B187E973892C8933B9B5F38", var_1.origin, 0, 0, 13, "_encstr_A78C12A94168635A569B8E34A11627856C1D959C");
  var_4 = getEnt("_encstr_88C30FB369770B15A0678C8737011CD787", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.weapons = [];
  level.weapons[0] = spawn("_encstr_97BA0EB936935AC11D7DDDAC0B07B79B", var_4.origin, 0, 0, 0);
  level.weapons[0].angles = var_4.angles;
  var_5 = getEnt("_encstr_97C30F3CED0F834F0D69C0D0826919FB2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.weapons[1] = spawn("_encstr_97BA0EB936935AC11D7DDDAC0B07B79B", var_5.origin, 0, 0, 1);
  level.weapons[1].angles = var_5.angles;
  var_6 = getEnt("_encstr_8D2F1377483FBFED66AFB39F674F9F6B6A44CF255C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.weapons[2] = spawn("_encstr_97BA0EB936935AC11D7DDDAC0B07B79B", var_6.origin, 0, 0, 2);
  level.weapons[2].angles = var_6.angles;
  var_7 = getEnt("_encstr_B67C11DDAC16C1F69BAF1B7B1BAFEEC28E6CD0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.weapons[3] = spawn("_encstr_97BA0EB936935AC11D7DDDAC0B07B79B", var_7.origin, 0, 0, 3);
  level.weapons[3].angles = var_7.angles;
  frontend_camera_setup(level.camera_lobby_detail.basecam.origin, level.camera_lobby_detail.basecam.angles);
}

getgunbenchents() {
  level.gunbenchbulletent = getEnt("_encstr_8D7A11A847FEC14362A643C0FE0B89C85DFB80", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

epictauntlistener() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_9A3A0EC9C73B7A43B1DA233FEA9560C3") {
      scripts\mp\broshot_utilities::respawnclientcharacter();
      var_2 = tablelookup("_encstr_972B12B607978D0BC65EA3B05DCDA36EB8B1CDCE", 0, var_1, 9);
      scripts\mp\broshot_utilities::processepictaunt(var_2, -1, 0);
      continue;
    }

    if(var_0 == "_encstr_916A0CE8B0579B1DAF4ECADC56A3")
      scripts\mp\broshot_utilities::respawnclientcharacter();
  }
}

devui_bg_swap(var_0) {
  foreach(var_2 in level.ui_bg_images_2d)
  var_2 hide();

  if(var_0 > 0 && var_0 <= level.ui_bg_images_2d.size)
    level.ui_bg_images_2d[var_0] show();
}

luinotifylistener() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  getgunbenchents();
  level.currentdropcount = 0;

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_9B6D191BB7168CF6BA477D9BA1B7EE36B037ACF5AC371D56E49591") {
      level.bulletsinitialstate = 1;
      level.currentdropcount = 0;
      continue;
    }

    if(var_0 == "_encstr_8F3317B7121A53A9F29F89D0F739439FD2F1A633AE021F11CC") {
      var_2 = int(var_1);

      if(istrue(level.bulletsinitialstate)) {
        level.bulletsinitialstate = 0;
        continue;
      }

      if(level.currentdropcount == 0) {} else {}

      level.currentdropcount++;

      if(level.currentdropcount > 3)
        level.currentdropcount = 1;

      continue;
    }

    if(var_0 == "_encstr_A1721423B92D674368974259A54B4B87C0505A8A410D") {
      var_3 = int(var_1);
      devui_bg_swap(var_3);
    }
  }
}

zombiepowerscooldown() {
  if(!isDefined(level.spawn_maint_wave_1)) {
    level.spawn_maint_wave_1 = loadfx("_encstr_8BB325EC331E79D2EEE07DADE0BCDD16A33643566ECBEC99F0F5ADC1F5437B1BB7EBDDC2E81B86");
    wait 1;
  }

  level._id_144DB = spawnfx(level.spawn_maint_wave_1, level.weapons[3].origin);
  level._id_144DB.angles = (221, -34.753, 181.997);
  level._id_144DB.origin = level._id_144DB.origin + (1, -0.66, 0.98);
  waitframe();
  triggerfx(level._id_144DB);
}

_id_14014() {
  for(;;) {
    if(getdvarint("_encstr_A9041B87EF43C86013AED1EB52F73013491B130F2BF9243330893B60BB", -1) != -1) {
      var_0 = getdvarint("_encstr_A9041B87EF43C86013AED1EB52F73013491B130F2BF9243330893B60BB");
      _id_11D9F(var_0);
    }

    waitframe();
  }
}

_id_11D9F(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(var_0 == 1)
    var_1 = 0.1;

  if(var_0 == 2)
    var_1 = -0.1;

  if(var_0 == 3)
    var_2 = 0.1;

  if(var_0 == 4)
    var_2 = -0.1;

  if(var_0 == 5)
    var_3 = 0.1;

  if(var_0 == 6)
    var_3 = -0.1;

  var_4 = level._id_144DB.angles;
  var_5 = level._id_144DB.origin + (var_1, var_2, var_3);
  level._id_144DB delete();
  level._id_144DB = spawnfx(level.spawn_maint_wave_1, var_5);
  level._id_144DB.angles = var_4;
  triggerfx(level._id_144DB);
}

_id_12D9A(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(var_0 == 1)
    var_1 = 10;

  if(var_0 == 2)
    var_1 = -10;

  if(var_0 == 3)
    var_2 = 10;

  if(var_0 == 4)
    var_2 = -10;

  if(var_0 == 5)
    var_3 = 10;

  if(var_0 == 6)
    var_3 = -10;

  var_4 = level._id_144DB.angles + (var_1, var_2, var_3);
  level._id_144DB delete();
  level._id_144DB = spawnfx(level.spawn_maint_wave_1, level.weapons[3].origin + (1, -0.66, 1.1));
  level._id_144DB.angles = var_4;
  triggerfx(level._id_144DB);
}

_id_13205() {
  level.ui_bg_images_2d = [];
  level.ui_bg_images_2d[1] = getEnt("_encstr_99A60DDDB2C238A4169CB48EBC81C4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ui_bg_images_2d[2] = getEnt("_encstr_8BA60D37CAC1730A4842D9FBA76A3A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ui_bg_images_2d[3] = getEnt("_encstr_83A60DBB56C2384A0B934B1DE56099", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ui_bg_images_2d[4] = getEnt("_encstr_A5A60DDB3B4E0786017A684373C7E1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ui_bg_images_2d[5] = getEnt("_encstr_86A60DD309176B3AB85DA9BC235AAB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12A10 = scripts\engine\utility::getStruct("_encstr_82EC1097EDA739B168454BBB196E5B3714B3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12A0F = scripts\engine\utility::getStruct("_encstr_8D0A11EE95850E4A16E4B43ACB35AC324B575B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12A0E = scripts\engine\utility::getStruct("_encstr_827810BBAC16E025C227A53A5E3116C97695", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12A11 = scripts\engine\utility::getStruct("_encstr_AA6010EE56858392859CD2D15ED5C2A31B0D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  devui_bg_swap(0);
}