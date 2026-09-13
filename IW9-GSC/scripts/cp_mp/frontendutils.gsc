/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\frontendutils.gsc
***********************************************/

frontend_camera_setup(origin, angles) {
  level.camera_anchor = spawn("script_model", origin);
  level.camera_anchor setModel("tag_origin");
  level.camera_anchor.angles = angles;
  level._id_7FC91D1D11CD14DE = spawn("script_model", origin);
  level._id_7FC91D1D11CD14DE setModel("tag_origin");
  level._id_7FC91D1D11CD14DE.angles = angles;
  level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 0;
  _id_AFC6E0C85FA4B347();
  scripts\engine\utility::flag_init("started_mm");
  scripts\engine\utility::flag_init("lobby_member_increase");
  scripts\engine\utility::flag_init("zoom_triggered");
  scripts\engine\utility::flag_init("zoom_clear");
  scripts\engine\utility::flag_init("loadout_data_set");
  scripts\engine\utility::flag_init("force_weapon_update");
  level._id_7EE57B7672DB9BF5 = getdvarint("dvar_50F29EF95283DC5D", 0);
  level._id_9121F71B47A01026 = getdvarint("dvar_B704CDC607351CD6", 0);
  level._id_F993553728AF3E10 = getdvarint("dvar_FFC75510A2B66232", 0);
}

_id_AFC6E0C85FA4B347() {
  level._id_39E3BFC771325A76 = 0.3;
  level._id_0E4B914D2CF9018D = ["tag_silencer", "tag_barrel_attach_small", "tag_barrel_attach_large", "tag_grip_attach", "tag_mag_attach", "j_mag1", "tag_scope", "tag_reflex", "tag_pistolgrip_attach", "tag_stock_attach", "tag_stock_attach_small", "tag_rack_attach", "j_gun", "tag_bipod_attach", "ammo_display_origin"];
}

_id_467CFCE1AEF4BAE0() {
  _id_C5C698B5097E2FA6 = _func_32F4AA63012035BE();
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;

  if(_id_9FE1BC92EC9FB00F && _id_C5C698B5097E2FA6.name == "")
    _id_C5C698B5097E2FA6.name = "squad_lobby";

  return _id_C5C698B5097E2FA6;
}

frontend_camera_watcher(_id_7ED4CF9CE7CC3393) {
  level endon("game_ended");
  self endon("disconnect");
  self cameralinkTo(level.camera_anchor, "tag_origin");
  level.active_section = _id_467CFCE1AEF4BAE0();
  [[_id_7ED4CF9CE7CC3393]](level.active_section);
  waitframe();

  for(;;) {
    _id_4548A1D75690B91F = _id_467CFCE1AEF4BAE0();

    if(_id_4548A1D75690B91F.name == level.active_section.name && (isDefined(level._id_3417AD63B8B9976B) && !level._id_3417AD63B8B9976B)) {
      if(level.active_section.name == getDvar("lui_fe_transitioning_scene"))
        _func_D4CBB69D89D4F3F5();

      waitframe();
      continue;
    }

    level.active_section = _id_4548A1D75690B91F;
    level._id_3417AD63B8B9976B = 0;
    setomnvar("frontend_weapon_position_updated", 0);
    setomnvar("frontend_screen_black", 0);
    setomnvar("frontend_weapon_position_force_update", 0);
    [[_id_7ED4CF9CE7CC3393]](_id_4548A1D75690B91F);
  }
}

camera_section_change(_id_402BEAA866B682A2) {
  level notify("started_scene_change");

  if(_id_402BEAA866B682A2.name == "") {
    return;
  }
  _id_5251A242A4D3B765 = get_section_state(_id_402BEAA866B682A2);

  if(!isDefined(_id_5251A242A4D3B765["scene"]) || !isDefined(_id_5251A242A4D3B765["camera"])) {
    return;
  }
  set_active_camera(_id_5251A242A4D3B765["scene"], _id_5251A242A4D3B765["camera"]);
  execute_transition(_id_402BEAA866B682A2, level.currentsectionname);
  level.currentsectionname = _id_402BEAA866B682A2.name;
  level notify("finished_scene_change");
}

set_active_camera(scene, camera) {
  level.active_scene_data = scene;
  level.active_camera = camera;
}

execute_transition(_id_402BEAA866B682A2, _id_E81DDC7D78BB73C0) {
  _id_ACF68BB64D0400F8 = !isDefined(level.active_scene_data) || level.transition_interrupted;

  if(_id_ACF68BB64D0400F8)
    thread frontend_camera_teleport(level.active_camera, level.active_scene_data.myfov, level.active_scene_data.cinematic, 0, 0.2, ::update_entities_and_camera);

  transitionarray = level.transitionarray;
  speed = undefined;
  fov = undefined;
  callback = undefined;
  _id_C8AFEAED872F1486 = undefined;
  _id_C8FE6E3CA9715960 = undefined;
  _id_EE006CF398BCD8FD = undefined;
  _id_77398C562251DB39 = undefined;
  _id_9C93E41B9457295B = undefined;
  _id_75C120D4893A4AE6 = undefined;
  movetime = undefined;
  _id_4917DFA18081761D = undefined;

  if(isDefined(transitionarray[_id_402BEAA866B682A2.name])) {
    _id_84F57DB96A676F33 = transitionarray[_id_402BEAA866B682A2.name];
    _id_31115B29470E7171 = _id_84F57DB96A676F33["default"];

    if(isDefined(_id_E81DDC7D78BB73C0) && isDefined(_id_84F57DB96A676F33[_id_E81DDC7D78BB73C0])) {
      callback = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["callback"];
      fov = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["fov"];
      speed = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["speed"];
      _id_C8FE6E3CA9715960 = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["fadeOutTime"];
      _id_EE006CF398BCD8FD = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["fadeInTime"];
      _id_77398C562251DB39 = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["cinematicName"];
      _id_9C93E41B9457295B = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["accelScalar"];
      _id_75C120D4893A4AE6 = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["decelScalar"];
      movetime = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["moveTime"];
      _id_4917DFA18081761D = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["use_bounce"];

      if(isDefined(_id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["transition"]))
        _id_C8AFEAED872F1486 = _id_84F57DB96A676F33[_id_E81DDC7D78BB73C0]["transition"];
    }

    callback = scripts\engine\utility::ter_op(isDefined(callback), callback, _id_31115B29470E7171["callback"]);

    if(!isDefined(_id_C8AFEAED872F1486)) {
      _id_C8AFEAED872F1486 = scripts\engine\utility::ter_op(isDefined(fov), fov, _id_31115B29470E7171["transition"]);
      fov = scripts\engine\utility::ter_op(isDefined(fov), fov, _id_31115B29470E7171["fov"]);
      speed = scripts\engine\utility::ter_op(isDefined(speed), speed, _id_31115B29470E7171["speed"]);
      _id_C8FE6E3CA9715960 = scripts\engine\utility::ter_op(isDefined(_id_C8FE6E3CA9715960), callback, _id_31115B29470E7171["fadeOutTime"]);
      _id_EE006CF398BCD8FD = scripts\engine\utility::ter_op(isDefined(_id_EE006CF398BCD8FD), fov, _id_31115B29470E7171["fadeInTime"]);
      _id_77398C562251DB39 = scripts\engine\utility::ter_op(isDefined(_id_77398C562251DB39), _id_77398C562251DB39, _id_31115B29470E7171["cinematicName"]);
      _id_9C93E41B9457295B = scripts\engine\utility::ter_op(isDefined(_id_9C93E41B9457295B), _id_9C93E41B9457295B, _id_31115B29470E7171["accelScalar"]);
      _id_75C120D4893A4AE6 = scripts\engine\utility::ter_op(isDefined(_id_75C120D4893A4AE6), _id_75C120D4893A4AE6, _id_31115B29470E7171["decelScalar"]);
      movetime = scripts\engine\utility::ter_op(isDefined(movetime), movetime, _id_31115B29470E7171["moveTime"]);
      _id_4917DFA18081761D = scripts\engine\utility::ter_op(isDefined(_id_4917DFA18081761D), _id_4917DFA18081761D, _id_31115B29470E7171["use_bounce"]);
    }
  } else {
    _id_C8AFEAED872F1486 = ::frontend_camera_teleport;
    callback = ::update_camera_depth_of_field;
    tagname = _id_2D4A4197B801AD83(_id_402BEAA866B682A2.name);

    if(isDefined(tagname) && isDefined(level._id_D45FB3EE26047877[tagname]))
      callback = ::_id_A3721E529C3182FF;
  }

  if(_id_C8AFEAED872F1486 == ::frontend_camera_teleport) {
    fov = scripts\engine\utility::ter_op(isDefined(fov), fov, level.active_scene_data.myfov);
    _id_C8FE6E3CA9715960 = scripts\engine\utility::ter_op(isDefined(_id_C8FE6E3CA9715960), _id_C8FE6E3CA9715960, 0.2);
    _id_EE006CF398BCD8FD = scripts\engine\utility::ter_op(isDefined(_id_EE006CF398BCD8FD), _id_EE006CF398BCD8FD, 0.2);
    _id_77398C562251DB39 = scripts\engine\utility::ter_op(isDefined(_id_77398C562251DB39), _id_77398C562251DB39, level.active_scene_data.cinematic);
    [[_id_C8AFEAED872F1486]](level.active_camera, fov, _id_77398C562251DB39, _id_C8FE6E3CA9715960, _id_EE006CF398BCD8FD, callback);
  } else if(_id_C8AFEAED872F1486 == ::frontend_camera_move) {
    _id_9C93E41B9457295B = scripts\engine\utility::ter_op(isDefined(_id_9C93E41B9457295B), _id_9C93E41B9457295B, 0.1);
    _id_75C120D4893A4AE6 = scripts\engine\utility::ter_op(isDefined(_id_75C120D4893A4AE6), _id_75C120D4893A4AE6, 0.1);
    speed = scripts\engine\utility::ter_op(isDefined(speed), speed, 5000);
    _id_4917DFA18081761D = scripts\engine\utility::ter_op(isDefined(_id_4917DFA18081761D), _id_4917DFA18081761D, 0);
    movetime = scripts\engine\utility::ter_op(isDefined(movetime), movetime, 0);
    update_camera_depth_of_field();

    if(callback == ::update_camera_depth_of_field)
      callback = ::update_camera_depth_of_field_slowly;

    [[_id_C8AFEAED872F1486]](level.active_camera, speed, 0, 1, callback, _id_9C93E41B9457295B, _id_75C120D4893A4AE6, _id_4917DFA18081761D, movetime);
  } else {}

  if(isDefined(_id_402BEAA866B682A2.name) && isDefined(level._id_2F5D13D3887F56A5) && isDefined(level._id_2F5D13D3887F56A5[_id_402BEAA866B682A2.name]))
    [[level._id_2F5D13D3887F56A5[_id_402BEAA866B682A2.name]]](_id_E81DDC7D78BB73C0);

  if(isDefined(_id_E81DDC7D78BB73C0) && isDefined(level._id_B50F0A931C0A33A1) && isDefined(level._id_B50F0A931C0A33A1[_id_E81DDC7D78BB73C0]))
    [[level._id_B50F0A931C0A33A1[_id_E81DDC7D78BB73C0]]](_id_E81DDC7D78BB73C0);
}

camera_move_helper(moveto, movetime, _id_B73333FAEB7580E8, _id_9C93E41B9457295B, _id_75C120D4893A4AE6, _id_4917DFA18081761D) {
  level.playerviewowner _meth_BC667001F9DD3808(moveto.origin);

  if(movetime < 0.05)
    movetime = 0.05;

  _id_BDE1F6386A595274 = 0.0;
  _id_0A4F9D343B9EF425 = 0.0;

  if(_id_B73333FAEB7580E8) {
    _id_BDE1F6386A595274 = movetime * _id_9C93E41B9457295B;
    _id_0A4F9D343B9EF425 = movetime * _id_75C120D4893A4AE6;
  }

  if(_id_4917DFA18081761D) {
    _id_D9FE5C9E3F6FDF53 = 1.3;
    dir = vectorNormalize(moveto.origin - level.camera_anchor.origin);
    _id_B8FD646DCDCEAC2D = moveto.origin + dir * _id_D9FE5C9E3F6FDF53;
    _id_D403A99D81C01800 = movetime / 2.0;
    _id_CA3314E2DA30D3B3 = _id_D403A99D81C01800 * 0.0;
    _id_B03ED768DDD916AA = _id_D403A99D81C01800 * 0.5;
    _id_8E0A20DD79AF6458 = _id_D403A99D81C01800 * 0.5;
    _id_14ADDE5F19F82451 = _id_D403A99D81C01800 * 0.0;
    level.camera_anchor moveTo(_id_B8FD646DCDCEAC2D, _id_D403A99D81C01800, _id_CA3314E2DA30D3B3, _id_B03ED768DDD916AA);
    level.camera_anchor rotateTo(moveto.angles, _id_D403A99D81C01800, _id_CA3314E2DA30D3B3, _id_B03ED768DDD916AA);
    wait(_id_D403A99D81C01800);
    level.camera_anchor moveTo(moveto.origin, _id_D403A99D81C01800, _id_8E0A20DD79AF6458, _id_14ADDE5F19F82451);
    wait(_id_D403A99D81C01800);
  } else {
    level.camera_anchor.move_target = moveto;
    level.camera_anchor moveTo(moveto.origin, movetime, _id_BDE1F6386A595274, _id_0A4F9D343B9EF425);
    level.camera_anchor rotateTo(moveto.angles, movetime, _id_BDE1F6386A595274, _id_0A4F9D343B9EF425);
  }

  level.playerviewowner clearpredictedstreampos();
}

frontend_camera_move(_id_1D6E2F3EE504886B, speed, _id_68383F581AB73544, _id_B73333FAEB7580E8, _id_30A2C9209D42C54C, _id_9C93E41B9457295B, _id_75C120D4893A4AE6, _id_4917DFA18081761D, movetime) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.camera_anchor.move_target)) {
    level.camera_anchor.origin = level.camera_anchor.move_target.origin;
    level.camera_anchor.angles = level.camera_anchor.move_target.angles;
  }

  level notify("camera_move");
  level endon("camera_move");

  if(!isDefined(speed))
    speed = 900;

  _id_56C2D6D4F2EB3BB4 = _id_1D6E2F3EE504886B;

  if(movetime == 0) {
    dist = distance(level.camera_anchor.origin, _id_56C2D6D4F2EB3BB4.origin);
    movetime = dist / speed;
  }

  _id_D2C70BE14739A532 = undefined;

  if(isDefined(level.active_section.name)) {
    _id_D2C70BE14739A532 = level.active_section.name;

    if(!isDefined(level._id_D45FB3EE26047877[_id_D2C70BE14739A532]))
      _id_D2C70BE14739A532 = _id_2D4A4197B801AD83(_id_D2C70BE14739A532);
  }

  _id_CFE414A4D77DD796 = isDefined(_id_D2C70BE14739A532) && isDefined(level._id_D45FB3EE26047877[_id_D2C70BE14739A532]);

  if(_id_68383F581AB73544 || _id_CFE414A4D77DD796) {
    level.camera_anchor.origin = _id_56C2D6D4F2EB3BB4.origin;
    level.camera_anchor.angles = _id_56C2D6D4F2EB3BB4.angles;
  } else
    camera_move_helper(_id_56C2D6D4F2EB3BB4, movetime, _id_B73333FAEB7580E8, _id_9C93E41B9457295B, _id_75C120D4893A4AE6, _id_4917DFA18081761D);

  _id_119779A9A16F190E = _id_9C93E41B9457295B + _id_75C120D4893A4AE6;

  if(_id_119779A9A16F190E > 1.0) {
    _id_9C93E41B9457295B = _id_9C93E41B9457295B / _id_119779A9A16F190E;
    _id_75C120D4893A4AE6 = _id_75C120D4893A4AE6 / _id_119779A9A16F190E;
  }

  while(isDefined(_id_56C2D6D4F2EB3BB4.target) && !_id_CFE414A4D77DD796) {
    if(!isDefined(_id_56C2D6D4F2EB3BB4.target)) {
      return;
    }
    _id_56C2D6D4F2EB3BB4 = getEnt(_id_56C2D6D4F2EB3BB4.target, "targetname");
    camera_move_helper(_id_56C2D6D4F2EB3BB4, movetime, _id_B73333FAEB7580E8, _id_9C93E41B9457295B, _id_75C120D4893A4AE6, _id_4917DFA18081761D);
  }

  level.camera_anchor.move_target = undefined;

  if(isDefined(_id_30A2C9209D42C54C))
    self thread[[_id_30A2C9209D42C54C]]();

  _func_D4CBB69D89D4F3F5();
}

frontend_camera_teleport(camera, fov, _id_77398C562251DB39, _id_C8FE6E3CA9715960, _id_EE006CF398BCD8FD, _id_C22E6553D3F7E83E) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("camera_teleport");
  level endon("camera_teleport");
  level.playerviewowner _meth_BC667001F9DD3808(camera.origin);
  level.transition_interrupted = 1;
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;

  if(!_id_9FE1BC92EC9FB00F) {
    _func_6463A6E30478B456(0, _id_C8FE6E3CA9715960);
    wait(_id_C8FE6E3CA9715960 + 0.05);
    setomnvar("frontend_screen_black", 1);
  }

  _id_6C9750573F9A9742 = _func_CB66D1B49608D340();

  if(isDefined(_id_6C9750573F9A9742))
    _id_A2E4B36E61BB74E2();

  _func_A6797C0321D86B03(fov, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = camera.origin;
  level.camera_anchor.angles = camera.angles;
  level.camera_anchor.move_target = undefined;

  if(isDefined(_id_77398C562251DB39))
    _func_BC6579022C3816E5(_id_77398C562251DB39);

  wait 0.1;

  if(isDefined(level.currentsectionname) && _id_4A669B7AD22042AD(level.currentsectionname))
    update_weapon_loc();

  if(isDefined(_id_C22E6553D3F7E83E)) {
    _id_A589DBA63FBE1F28 = undefined;

    if(_id_C22E6553D3F7E83E == ::_id_A3721E529C3182FF)
      _id_A589DBA63FBE1F28 = 1;

    if(istrue(_id_A589DBA63FBE1F28))
      _id_A589DBA63FBE1F28 = [[_id_C22E6553D3F7E83E]]();
    else
      [[_id_C22E6553D3F7E83E]]();

    if(istrue(_id_A589DBA63FBE1F28)) {
      while(!isDefined(_func_CB66D1B49608D340()))
        waitframe();
    }
  }

  if(!_id_9FE1BC92EC9FB00F)
    _func_6463A6E30478B456(1, _id_EE006CF398BCD8FD);

  level.transition_interrupted = 0;
  _func_D4CBB69D89D4F3F5();

  if(!_id_9FE1BC92EC9FB00F)
    setomnvar("frontend_screen_black", 0);

  level.playerviewowner clearpredictedstreampos();
}

update_character_pos() {
  if(isDefined(level.active_scene_data.update_char_loc))
    [[level.active_scene_data.update_char_loc]]();
  else if(isDefined(level.active_scene_data.char_loc)) {
    _id_A2D54B92B23FA8BF = 0;

    if(isDefined(level.active_scene_data.char_index))
      _id_A2D54B92B23FA8BF = level.active_scene_data.char_index;

    level.characters[_id_A2D54B92B23FA8BF].origin = level.active_scene_data.char_loc.origin;
    level.characters[_id_A2D54B92B23FA8BF].angles = level.active_scene_data.char_loc.angles;
  }
}

update_player_character_showcase() {
  update_character_pos();
  update_weapon_loc();
  update_camera_depth_of_field();
  update_spot_limit();
}

update_camera_depth_of_field() {
  values = level.active_camera.depthoffieldvalues;
  self setphysicaldepthoffield(values[0], values[1], 20, 20);
}

update_camera_depth_of_field_slowly() {
  values = level.active_camera.depthoffieldvalues;
  self setphysicaldepthoffield(values[0], values[1], 3, 3);
}

update_entities_and_camera(_id_8485D21ED06C1DCC) {
  if(!isDefined(_id_8485D21ED06C1DCC))
    _id_A2E4B36E61BB74E2();
  else if(_id_F8448524349B24CE(_id_8485D21ED06C1DCC))
    _id_A2E4B36E61BB74E2();

  update_character_pos();

  if(isDefined(level.active_section)) {
    if(level.active_section.name == "loadout_showcase_p" || level.active_section.name == "loadout_showcase_s")
      _id_D77872B5CE5F1B8D();
  }

  update_weapon_loc();
  update_camera_depth_of_field();
  update_spot_limit();

  if(_id_32AB61259FD850EF() == "mp_frontend3" || _id_32AB61259FD850EF() == "mp_frontend6")
    _id_2898724F8CF4C78E();
}

update_spot_limit() {
  if(isDefined(level.active_scene_data.spotlimit))
    setDvar("sm_spotUpdateLimit", level.active_scene_data.spotlimit);
  else
    setDvar("sm_spotUpdateLimit", 2);
}

_id_B29A3BC01E5AA394() {
  level endon("game_ended");

  while(!isDefined(level._id_E35B63F3AC08DADA))
    waitframe();
}

_id_47F8406A4C96AF32(scene) {
  if(!isDefined(level._id_E35B63F3AC08DADA))
    _id_B29A3BC01E5AA394();

  if(isDefined(level._id_E35B63F3AC08DADA) && level._id_E35B63F3AC08DADA != scene) {
    _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;
    _id_90669DCD7727D79A = ::setlightintensity;

    if(_id_9FE1BC92EC9FB00F)
      _id_90669DCD7727D79A = ::_meth_9C10AC6AC01CE90A;

    foreach(light in level._id_36506DC78F9F6F3B)
    light call[[_id_90669DCD7727D79A]](0);

    switch (scene) {
      case "Lobby":
        foreach(light in level._id_D1511DCF3642E350)
        light call[[_id_90669DCD7727D79A]](light._id_86102E35E838B321);

        break;
      case "Gunbench":
        foreach(light in level._id_CE6333E67D961B48)
        light call[[_id_90669DCD7727D79A]](light._id_86102E35E838B321);

        break;
      case "Loadout":
        foreach(light in level._id_DBAE9946BA81CC58)
        light call[[_id_90669DCD7727D79A]](light._id_86102E35E838B321);

        break;
      case "Loadout_Equipment":
        foreach(light in level._id_9A65323E854A8ED0)
        light call[[_id_90669DCD7727D79A]](light._id_86102E35E838B321);

        break;
      case "Character":
        foreach(light in level._id_510F673442128057)
        light call[[_id_90669DCD7727D79A]](light._id_86102E35E838B321);

        break;
      case "Operator":
        foreach(light in level._id_BA2E65D151A5BA08)
        light call[[_id_90669DCD7727D79A]](light._id_86102E35E838B321);

        break;
    }
  }

  level._id_E35B63F3AC08DADA = scene;
}

move_weapon_to_loc(index) {
  level.weapons[index].origin = level.active_scene_data.weapon_locs[index].origin;
  level.weapons[index].angles = level.active_scene_data.weapon_locs[index].angles;
}

update_weapon_loc() {
  if(isDefined(level.active_scene_data.weapon_locs)) {
    if(isarray(level.active_scene_data.weapon_locs)) {
      for(locindex = 0; locindex <= 3; locindex++) {
        if(isDefined(level.active_scene_data.weapon_locs[locindex]))
          move_weapon_to_loc(locindex);
      }
    }
  }

  if(issubstr(level.active_section.name, "loadout_showcase_preview"))
    setomnvar("frontend_weapon_position_updated", 1);
}

update_arena_char_loc() {
  for(_id_A2D54B92B23FA8BF = 0; _id_A2D54B92B23FA8BF < 8; _id_A2D54B92B23FA8BF++) {
    if(_id_A2D54B92B23FA8BF < 4.0)
      _id_986A67076C51D869 = getEnt("tourroom_charslot_left_0" + (_id_A2D54B92B23FA8BF + 1), "targetname");
    else {
      _id_F205D8D7FFD0D421 = _id_A2D54B92B23FA8BF - 4.0;
      _id_986A67076C51D869 = getEnt("tourroom_charslot_right_0" + (_id_F205D8D7FFD0D421 + 1), "targetname");
    }

    level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
    level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
  }

  for(_id_C433F957A34A5776 = 0; _id_C433F957A34A5776 < 6; _id_C433F957A34A5776++) {
    index = _id_C433F957A34A5776 + 1;
    _id_A2D54B92B23FA8BF = 8 + _id_C433F957A34A5776;

    if(index <= 3.0)
      _id_986A67076C51D869 = getEnt("tourroom_charslot_left_0" + index + "_dog", "targetname");
    else {
      _id_A0C254418715D439 = index - 3.0;
      _id_986A67076C51D869 = getEnt("tourroom_charslot_right_0" + _id_A0C254418715D439 + "_dog", "targetname");
    }

    level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
    level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
  }
}

_id_E078E650B9311BAE() {
  _id_986A67076C51D869 = getEnt("social_charslot_01", "targetname");
  level.characters[0].origin = _id_986A67076C51D869.origin;
  level.characters[0].angles = _id_986A67076C51D869.angles;

  for(_id_A2D54B92B23FA8BF = 1; _id_A2D54B92B23FA8BF < 8; _id_A2D54B92B23FA8BF++) {
    index = _id_A2D54B92B23FA8BF + 1;

    if(index < 10)
      _id_986A67076C51D869 = getEnt("social_charslot_0" + index, "targetname");
    else
      _id_986A67076C51D869 = getEnt("social_charslot_" + index, "targetname");

    if(isDefined(_id_986A67076C51D869)) {
      level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
      level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
    }
  }

  for(_id_C433F957A34A5776 = 0; _id_C433F957A34A5776 < 6; _id_C433F957A34A5776++) {
    index = _id_C433F957A34A5776 + 1;
    _id_A2D54B92B23FA8BF = 8 + _id_C433F957A34A5776;
    _id_986A67076C51D869 = getEnt("social_charslot_0" + index + "_dog", "targetname");
    level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
    level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
  }
}

update_lobby_char_loc() {
  _id_986A67076C51D869 = getEnt("lobby_charslot_01", "targetname");
  level.characters[0].origin = _id_986A67076C51D869.origin;
  level.characters[0].angles = _id_986A67076C51D869.angles;
  _id_51D40164FA113D86();

  if(isDefined(level._id_21F36F18171D453D)) {
    level._id_21F36F18171D453D.origin = level._id_21F36F18171D453D._id_D6FECEE135A01715;
    level._id_21F36F18171D453D.angles = level._id_21F36F18171D453D.originalangles;

    if(isDefined(level._id_3C25518892193253)) {
      level._id_3C25518892193253.origin = level._id_21F36F18171D453D.origin;
      level._id_3C25518892193253.angles = level._id_21F36F18171D453D.angles;
    }

    if(isDefined(level._id_B0F545BE973A4A13))
      level._id_B0F545BE973A4A13.origin = level._id_B0F545BE973A4A13._id_D6FECEE135A01715;
  }

  for(_id_A2D54B92B23FA8BF = 1; _id_A2D54B92B23FA8BF < 8; _id_A2D54B92B23FA8BF++) {
    index = _id_A2D54B92B23FA8BF + 1;

    if(index < 10)
      _id_986A67076C51D869 = getEnt("lobby_charslot_0" + index, "targetname");
    else
      _id_986A67076C51D869 = getEnt("lobby_charslot_" + index, "targetname");

    if(isDefined(_id_986A67076C51D869)) {
      level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
      level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
    }
  }

  for(_id_C433F957A34A5776 = 0; _id_C433F957A34A5776 < 6; _id_C433F957A34A5776++) {
    index = _id_C433F957A34A5776 + 1;
    _id_A2D54B92B23FA8BF = 8 + _id_C433F957A34A5776;
    _id_986A67076C51D869 = getEnt("lobby_charslot_0" + index + "_dog", "targetname");

    if(isDefined(_id_986A67076C51D869)) {
      level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
      level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
    }
  }
}

_id_B65A48A89B1A2CC0() {
  _id_986A67076C51D869 = getEnt("lobby_br_charslot_01", "targetname");
  level.characters[0].origin = _id_986A67076C51D869.origin;
  level.characters[0].angles = _id_986A67076C51D869.angles;
  _id_3E0815128A89FF77();

  if(isDefined(level._id_21F36F18171D453D)) {
    level._id_21F36F18171D453D.origin = (-7035, 2700, 0);
    level._id_21F36F18171D453D.angles = (0, 90, 0);

    if(isDefined(level._id_3C25518892193253)) {
      level._id_3C25518892193253.origin = level._id_21F36F18171D453D.origin;
      level._id_3C25518892193253.angles = level._id_21F36F18171D453D.angles;
    }

    if(isDefined(level._id_B0F545BE973A4A13))
      level._id_B0F545BE973A4A13.origin = (0, 0, 10000);
  }

  for(_id_A2D54B92B23FA8BF = 1; _id_A2D54B92B23FA8BF < 8; _id_A2D54B92B23FA8BF++) {
    index = _id_A2D54B92B23FA8BF + 1;

    if(index < 10)
      _id_986A67076C51D869 = getEnt("lobby_br_charslot_0" + index, "targetname");
    else
      _id_986A67076C51D869 = getEnt("lobby_br_charslot_" + index, "targetname");

    if(isDefined(_id_986A67076C51D869)) {
      level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
      level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
    }
  }

  for(_id_C433F957A34A5776 = 0; _id_C433F957A34A5776 < 6; _id_C433F957A34A5776++) {
    index = _id_C433F957A34A5776 + 1;
    _id_A2D54B92B23FA8BF = 8 + _id_C433F957A34A5776;
    _id_986A67076C51D869 = getEnt("lobby_br_charslot_0" + index + "_dog", "targetname");

    if(isDefined(_id_986A67076C51D869)) {
      level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
      level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
    }
  }
}

_id_9C5A6E36E93EADD9() {
  _id_986A67076C51D869 = getEnt("lobby_dmz_charslot_01", "targetname");
  level.characters[0].origin = _id_986A67076C51D869.origin;
  level.characters[0].angles = _id_986A67076C51D869.angles;
  _id_312C21343259651C();

  for(_id_A2D54B92B23FA8BF = 1; _id_A2D54B92B23FA8BF < 8; _id_A2D54B92B23FA8BF++) {
    index = _id_A2D54B92B23FA8BF + 1;

    if(index < 10)
      _id_986A67076C51D869 = getEnt("lobby_dmz_charslot_0" + index, "targetname");
    else
      _id_986A67076C51D869 = getEnt("lobby_dmz_charslot_" + index, "targetname");

    if(isDefined(_id_986A67076C51D869)) {
      level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
      level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
    }
  }

  for(_id_C433F957A34A5776 = 0; _id_C433F957A34A5776 < 6; _id_C433F957A34A5776++) {
    index = _id_C433F957A34A5776 + 1;
    _id_A2D54B92B23FA8BF = 8 + _id_C433F957A34A5776;
    _id_986A67076C51D869 = getEnt("lobby_dmz_charslot_0" + index + "_dog", "targetname");

    if(isDefined(_id_986A67076C51D869)) {
      level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
      level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
    }
  }
}

_id_18D1A39CC5732FB1() {
  _id_986A67076C51D869 = getEnt("crib_dmz_charslot_01", "targetname");
  level.characters[0].origin = _id_986A67076C51D869.origin;
  level.characters[0].angles = _id_986A67076C51D869.angles;

  for(_id_A2D54B92B23FA8BF = 1; _id_A2D54B92B23FA8BF < 8; _id_A2D54B92B23FA8BF++) {
    index = _id_A2D54B92B23FA8BF + 1;

    if(index < 10)
      _id_986A67076C51D869 = getEnt("crib_dmz_charslot_0" + index, "targetname");
    else
      _id_986A67076C51D869 = getEnt("crib_dmz_charslot_" + index, "targetname");

    if(isDefined(_id_986A67076C51D869)) {
      level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
      level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
    }
  }

  for(_id_C433F957A34A5776 = 0; _id_C433F957A34A5776 < 6; _id_C433F957A34A5776++) {
    index = _id_C433F957A34A5776 + 1;
    _id_A2D54B92B23FA8BF = 8 + _id_C433F957A34A5776;
    _id_986A67076C51D869 = getEnt("crib_dmz_charslot_0" + index + "_dog", "targetname");

    if(isDefined(_id_986A67076C51D869)) {
      level.characters[_id_A2D54B92B23FA8BF].origin = _id_986A67076C51D869.origin;
      level.characters[_id_A2D54B92B23FA8BF].angles = _id_986A67076C51D869.angles;
    }
  }
}

update_main_menu_char_loc() {
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;
  _id_986A67076C51D869 = getEnt("charroom_char_tango_east", "targetname");
  _id_8B56F73126CE0C5A = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, (-5910.43, -3473.64, 0), (-5927.43, -3453.64, 0));
  level.characters[14].origin = _id_8B56F73126CE0C5A;
  level.characters[14].angles = (0, -139.143, 0);
  _id_986A67076C51D869 = getEnt("charroom_char_tango_west", "targetname");
  _id_98CCFA24EC062834 = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, (-5910.43, -3473.28, 0), (-5893.15, -3493.28, 0));
  level.characters[15].origin = _id_98CCFA24EC062834;
  level.characters[15].angles = (0, -139.143, 0);
  update_operator_west_char_loc();
  update_operator_east_char_loc();
}

update_operator_west_char_loc() {
  _id_986A67076C51D869 = getEnt("charroom_char_west_b_dog", "targetname");
  level.characters[8].origin = _id_986A67076C51D869.origin;
  level.characters[8].angles = _id_986A67076C51D869.angles;
}

update_operator_east_char_loc() {
  _id_986A67076C51D869 = getEnt("charroom_char_east_a_dog", "targetname");
  level.characters[9].origin = _id_986A67076C51D869.origin;
  level.characters[9].angles = _id_986A67076C51D869.angles;
}

_id_064A0F78F8CDFF3F() {
  _id_986A67076C51D869 = getEnt("char_gunbench", "targetname");
  level.characters[0].origin = _id_986A67076C51D869.origin;
  level.characters[0].angles = _id_986A67076C51D869.angles;
  _id_986A67076C51D869 = getEnt("char_gunbench_dog", "targetname");
  level.characters[8].origin = _id_986A67076C51D869.origin;
  level.characters[8].angles = _id_986A67076C51D869.angles;
}

raritycamera(camera) {
  switch (camera) {
    case "small":
      foreach(bg in level.ui_bg_images_2d)
      bg.origin = level.raritycamsmall.origin;

      break;
    case "medium":
      foreach(bg in level.ui_bg_images_2d)
      bg.origin = level.raritycammedium.origin;

      break;
    case "large":
      foreach(bg in level.ui_bg_images_2d)
      bg.origin = level.raritycamlarge.origin;

      break;
    case "watch":
      foreach(bg in level.ui_bg_images_2d)
      bg.origin = level.raritycamwatch.origin;

      break;
  }
}

_id_0430B4AAA7C17C4C(_id_0E25D1D189177A7C, waittime) {
  level notify("new_operator_xcam");
  level endon("game_ended");
  self endon("disconnect");
  level endon("xcam_transition");
  level endon("new_operator_xcam");
  wait(waittime / 1000);
  _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][4], 0, 0.05, level._id_7FC91D1D11CD14DE);
  level thread _id_D78721E281FF6EA7(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][4], level._id_7FC91D1D11CD14DE);
}

_id_E7571F41E1D6A427(_id_0E25D1D189177A7C, _id_756916B2AF9EBB9C, _id_8485D21ED06C1DCC) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 1;
  level._id_7FC91D1D11CD14DE.origin = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].origin;
  level._id_7FC91D1D11CD14DE.angles = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].angles;

  for(;;) {
    if(!isDefined(level._id_A5777679E8986406) || !isDefined(level._id_D5E742A25A53C1B3)) {
      if(!isDefined(_func_CB66D1B49608D340())) {
        _id_D180B535A33B044D = 0.0;

        if(isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"])) {
          _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"]["default"];

          if(isDefined(_id_8485D21ED06C1DCC) && isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][_id_8485D21ED06C1DCC]))
            _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][_id_8485D21ED06C1DCC];
        }

        _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][4], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);
        level thread _id_D78721E281FF6EA7(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][4], level._id_7FC91D1D11CD14DE);
      } else if(_func_CB66D1B49608D340().name == "iw9_fe_op_select_east_edit_in_xcam" || _func_CB66D1B49608D340().name == "iw9_fe_op_select_west_edit_in_xcam") {
        _id_D180B535A33B044D = 0.0;

        if(isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"])) {
          _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"]["default"];

          if(isDefined(_id_8485D21ED06C1DCC) && isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][_id_8485D21ED06C1DCC]))
            _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][_id_8485D21ED06C1DCC];
        }

        _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][4], 0, 0.35, level._id_7FC91D1D11CD14DE);
        level thread _id_D78721E281FF6EA7(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][4], level._id_7FC91D1D11CD14DE);
      }

      waitframe();
      continue;
    }

    _id_843AA33343742EF5 = level._id_A5777679E8986406;
    gender = level._id_D5E742A25A53C1B3;

    if(gender == 1)
      gender++;

    _id_05714A782151D7B6 = _id_843AA33343742EF5 + gender;
    level._id_A5777679E8986406 = undefined;
    level._id_D5E742A25A53C1B3 = undefined;
    level notify("new_operator_xcam");
    _id_D180B535A33B044D = 0.0;

    if(isDefined(_id_8485D21ED06C1DCC) && _id_8485D21ED06C1DCC != "" && isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"])) {
      _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"]["default"];

      if(isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][_id_8485D21ED06C1DCC]))
        _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][_id_8485D21ED06C1DCC];
    }

    _id_3F7DBE2B045A8D0D = 0;

    if(!istrue(level._id_F750BD5E9C449424)) {
      _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][_id_05714A782151D7B6], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);
      _id_3F7DBE2B045A8D0D = _func_074756A08469CA5E(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][_id_05714A782151D7B6]);
    }

    level._id_F750BD5E9C449424 = undefined;
    level thread _id_0430B4AAA7C17C4C(_id_0E25D1D189177A7C, _id_3F7DBE2B045A8D0D);
    _id_8485D21ED06C1DCC = "";
    waitframe();
  }
}

_id_E6B12E702BF34C5E(_id_0E25D1D189177A7C, _id_756916B2AF9EBB9C, _id_8485D21ED06C1DCC) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  level._id_7FC91D1D11CD14DE.origin = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].origin;
  level._id_7FC91D1D11CD14DE.angles = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].angles;
  _id_2B5E086B37BAD774 = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0];

  if(isDefined(level._id_01EED5555B61F170))
    _id_2B5E086B37BAD774 = level._id_01EED5555B61F170;

  _id_5AEA88C7C01479DB(_id_2B5E086B37BAD774, 0, 0.0, level._id_7FC91D1D11CD14DE);
  level._id_01EED5555B61F170 = _id_2B5E086B37BAD774;
  level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 1;
  thread _id_D78721E281FF6EA7(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0], level._id_7FC91D1D11CD14DE);
  waittime = undefined;
  waitframe();

  for(;;) {
    waitframe();
    scripts\engine\utility::_id_665D474FF040B446(_id_756916B2AF9EBB9C);

    if(isarray(_id_756916B2AF9EBB9C)) {
      foreach(_id_D3621E1DF5DD1157 in _id_756916B2AF9EBB9C)
      scripts\engine\utility::flag_clear(_id_D3621E1DF5DD1157);
    } else
      scripts\engine\utility::flag_clear(_id_756916B2AF9EBB9C);

    level notify("xcam_loop");
    _id_0CA318DD2DE5793D = _func_CB66D1B49608D340();
    _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"]["default"];

    if(level._id_A98D8246ED9C8B71 == "match_making") {
      _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"]["started_mm"];
      _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][2], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);
      waittime = max(_func_074756A08469CA5E(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][2]) - 1500, 0);
      break;
    }

    if(level._id_A98D8246ED9C8B71 == "lobby_member_increase" && level._id_013C94D72BBA10B4 == 1 && isDefined(_id_0CA318DD2DE5793D) && _id_0CA318DD2DE5793D.name != "fe_lobby_plow_cam_01_idle_01_xcam") {
      _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"]["lobby_member_increase"];
      _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);
      thread _id_D78721E281FF6EA7(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0], level._id_7FC91D1D11CD14DE);
      level._id_01EED5555B61F170 = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0];
      continue;
    }

    if(level._id_A98D8246ED9C8B71 == "lobby_member_increase" && level._id_013C94D72BBA10B4 > 1 && isDefined(_id_0CA318DD2DE5793D) && _id_0CA318DD2DE5793D.name != "fe_lobby_plow_cam_01_idle_squad_01_xcam") {
      _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"]["lobby_member_increase"];
      _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][1], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);
      thread _id_D78721E281FF6EA7(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0], level._id_7FC91D1D11CD14DE);
      level._id_01EED5555B61F170 = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][1];
    }
  }

  level._id_01EED5555B61F170 = undefined;

  if(isDefined(waittime) && waittime > 0)
    thread _id_1992C5CB2E5F21FE(waittime);

  level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 0;
}

_id_1992C5CB2E5F21FE(waittime) {
  level notify("matchmaking_fade");
  level endon("game_ended");
  level endon("matchmaking_fade");
  level endon("xcam_transition");
  level endon("disconnect");
  wait(waittime / 1000);
  _func_6463A6E30478B456(0, 1.5);
  thread _id_B73BCCCEEABFB757();
  wait 1.5;
  setomnvar("frontend_screen_black", 1);
}

_id_B73BCCCEEABFB757() {
  level endon("game_ended");
  level endon("disconnect");
  level endon("camera_teleport");
  level scripts\engine\utility::waittill_any_2("xcam_set", "finished_scene_change");
  _func_6463A6E30478B456(1, 0.2);
  setomnvar("frontend_screen_black", 0);
}

_id_701C8726C0B7FC47(_id_0E25D1D189177A7C, _id_756916B2AF9EBB9C) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("xcam_transition");
  scripts\engine\utility::flag_wait("zoom_clear");
  level thread _id_77004A3CA8EFDBBD(_id_0E25D1D189177A7C, _id_756916B2AF9EBB9C);
}

_id_77004A3CA8EFDBBD(_id_0E25D1D189177A7C, _id_756916B2AF9EBB9C, _id_8485D21ED06C1DCC) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 1;
  level._id_7FC91D1D11CD14DE.origin = level._id_D45FB3EE26047877["loadout_showcase_preview"]["xcam_data"].origin;
  level._id_7FC91D1D11CD14DE.angles = level._id_D45FB3EE26047877["loadout_showcase_preview"]["xcam_data"].angles;

  if(distancesquared(level._id_7FC91D1D11CD14DE.origin, (-5872.09, -3436.26, 0)) > 14000) {
    level._id_9C1886877F0E84A1 = undefined;
    scripts\engine\utility::flag_clear("force_weapon_update");
    update_weapon_loc();
    waitframe();
    setomnvar("frontend_weapon_position_force_update", 1);
    scripts\engine\utility::flag_wait("force_weapon_update");
    level._id_7FC91D1D11CD14DE.origin = level._id_D45FB3EE26047877["loadout_showcase_preview"]["xcam_data"].origin;
    level._id_7FC91D1D11CD14DE.angles = level._id_D45FB3EE26047877["loadout_showcase_preview"]["xcam_data"].angles;
  }

  _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0], 0, 0.0, level._id_7FC91D1D11CD14DE);
  scripts\engine\utility::flag_wait(_id_756916B2AF9EBB9C);
  scripts\engine\utility::flag_clear(_id_756916B2AF9EBB9C);
  index = 0;

  switch (level._id_EBFC572B07861F57) {
    case "frontpiece":
      index = 1;
      break;
    case "attach_rec":
      index = 0;
      break;
    case "extra":
      index = 2;
      break;
    case "reargrip":
      index = 3;
      break;
    case "magazine":
      index = 4;
      break;
    case "muzzle":
      index = 5;
      break;
    case "optic":
      index = 6;
      break;
    case "backpiece":
      index = 7;
      break;
    case "undermount":
      index = 8;
      break;
    case "gunperk":
      index = 9;
      break;
    case "receiver":
      index = 0;
      break;
  }

  while(level.active_section.name == _id_0E25D1D189177A7C) {
    scripts\engine\utility::flag_wait("zoom_triggered");
    scripts\engine\utility::flag_clear("zoom_triggered");
    level._id_7FC91D1D11CD14DE.origin = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].origin;
    level._id_7FC91D1D11CD14DE.angles = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].angles;
    _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][index], 0, level._id_39E3BFC771325A76, level._id_7FC91D1D11CD14DE);

    if(index == 0)
      level._id_39E3BFC771325A76 = 0.3;
  }

  level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 0;
}

_id_502EF984F5AD944E(_id_0E25D1D189177A7C, _id_756916B2AF9EBB9C, _id_8485D21ED06C1DCC) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"]["default"];

  if(isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][_id_8485D21ED06C1DCC]))
    _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][_id_8485D21ED06C1DCC];

  while(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0] == "")
    waitframe();

  level._id_7FC91D1D11CD14DE.origin = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].origin;
  level._id_7FC91D1D11CD14DE.angles = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].angles;
  _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);
}

_id_D78721E281FF6EA7(_id_6C9750573F9A9742, _id_7FC91D1D11CD14DE) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_loop");
  level endon("xcam_loop");
  level endon("xcam_transition");
  level endon("new_operator_xcam");

  for(;;) {
    _id_3F7DBE2B045A8D0D = _func_074756A08469CA5E(_id_6C9750573F9A9742);

    if(_id_3F7DBE2B045A8D0D <= 0) {
      waitframe();
      continue;
    } else
      wait(_id_3F7DBE2B045A8D0D / 1000);

    _id_5AEA88C7C01479DB(_id_6C9750573F9A9742, 0, 0.3, _id_7FC91D1D11CD14DE);
  }

  level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 0;
}

_id_77941E3B34187548(_id_0E25D1D189177A7C) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("xcam_transition");
  level endon("xcam_transition");
  _id_B2ED446C98547907 = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"].size;

  if(_id_B2ED446C98547907 == 0) {
    return;
  }
  if(isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["callback"]) && isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["flag_msg"]))
    level thread[[level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["callback"]]](_id_0E25D1D189177A7C, level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["flag_msg"], level.currentsectionname);
  else {
    _id_D180B535A33B044D = 0.0;

    if(isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"])) {
      _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"]["default"];

      if(isDefined(level.currentsectionname) && isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][level.currentsectionname]))
        _id_D180B535A33B044D = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["blend_time"][level.currentsectionname];
    }

    level._id_7FC91D1D11CD14DE.origin = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].origin;
    level._id_7FC91D1D11CD14DE.angles = level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["xcam_data"].angles;

    if(_id_B2ED446C98547907 == 1) {
      _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);
      level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 0;

      if(istrue(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["loop_last"]))
        level thread _id_D78721E281FF6EA7(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][0], level._id_7FC91D1D11CD14DE);

      return;
    }

    level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B2ED446C98547907; _id_AC0E594AC96AA3A8++) {
      _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][_id_AC0E594AC96AA3A8], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);

      if(_id_AC0E594AC96AA3A8 < _id_B2ED446C98547907 - 1) {
        _id_3F7DBE2B045A8D0D = _func_074756A08469CA5E(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][_id_AC0E594AC96AA3A8]);
        wait(_id_3F7DBE2B045A8D0D / 1000);
      }
    }

    if(istrue(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["loop_last"])) {
      level thread _id_D78721E281FF6EA7(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]["transitions"][_id_B2ED446C98547907 - 1], level._id_7FC91D1D11CD14DE);
      return;
    }

    level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 0;
  }
}

_id_5AEA88C7C01479DB(_id_6C9750573F9A9742, _id_72680B716AAEC0BA, _id_D180B535A33B044D, _id_7FC91D1D11CD14DE) {
  _id_7759863855FB5C13 = _id_7FC91D1D11CD14DE;

  if(isDefined(level._id_F8ADC014A1E45D3C))
    _id_7759863855FB5C13.origin = _id_7759863855FB5C13.origin + level._id_F8ADC014A1E45D3C;

  level._id_F8ADC014A1E45D3C = undefined;
  _func_55891D5A9DC7C19E(_id_6C9750573F9A9742, _id_72680B716AAEC0BA, _id_D180B535A33B044D, _id_7759863855FB5C13);
  level notify("xcam_set");
}

_id_A3721E529C3182FF() {
  update_entities_and_camera(level.currentsectionname);

  if(!isDefined(level._id_D45FB3EE26047877)) {
    return;
  }
  _id_0E25D1D189177A7C = level.active_section.name;

  if(!_id_80AC3E056BACBFCC(_id_0E25D1D189177A7C) && !_id_4A669B7AD22042AD(_id_0E25D1D189177A7C) && istrue(level._id_9C1886877F0E84A1))
    level._id_9C1886877F0E84A1 = undefined;

  if(_id_4A669B7AD22042AD(_id_0E25D1D189177A7C))
    _id_F1D45199114730A5();

  if(!isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C]))
    _id_0E25D1D189177A7C = _id_2D4A4197B801AD83(_id_0E25D1D189177A7C);

  if(isDefined(_id_0E25D1D189177A7C) && isDefined(level._id_D45FB3EE26047877[_id_0E25D1D189177A7C])) {
    if(_id_32AB61259FD850EF() == "mp_frontend3" || _id_32AB61259FD850EF() == "mp_frontend6")
      _id_64CA1EFA525C0BFA(_id_0E25D1D189177A7C);

    level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 0;
    level thread _id_77941E3B34187548(_id_0E25D1D189177A7C);
    return 1;
  }

  return 0;
}

_id_F8448524349B24CE(_id_8485D21ED06C1DCC) {
  _id_031C7D7F403A82F8 = _func_CB66D1B49608D340();
  _id_0E25D1D189177A7C = level.active_section.name;

  if(!isDefined(_id_031C7D7F403A82F8))
    return 0;

  if(!isDefined(level.transitionarray[_id_0E25D1D189177A7C]))
    return 1;

  _id_C8AFEAED872F1486 = undefined;

  if(isDefined(level.transitionarray[_id_0E25D1D189177A7C][_id_8485D21ED06C1DCC]) && isDefined(level.transitionarray[_id_0E25D1D189177A7C][_id_8485D21ED06C1DCC]["transition"]))
    _id_C8AFEAED872F1486 = level.transitionarray[_id_0E25D1D189177A7C][_id_8485D21ED06C1DCC]["transition"];
  else if(isDefined(level.transitionarray[_id_0E25D1D189177A7C]["default"]) && isDefined(level.transitionarray[_id_0E25D1D189177A7C]["default"]["transition"]))
    _id_C8AFEAED872F1486 = level.transitionarray[_id_0E25D1D189177A7C]["default"]["transition"];

  if(!isDefined(_id_C8AFEAED872F1486))
    return 1;

  if(_id_C8AFEAED872F1486 == ::frontend_camera_teleport)
    return 1;

  callback = undefined;

  if(isDefined(level.transitionarray[_id_0E25D1D189177A7C][_id_8485D21ED06C1DCC]) && isDefined(level.transitionarray[_id_0E25D1D189177A7C][_id_8485D21ED06C1DCC]["callback"]))
    callback = level.transitionarray[_id_0E25D1D189177A7C][_id_8485D21ED06C1DCC]["callback"];
  else if(isDefined(level.transitionarray[_id_0E25D1D189177A7C]["default"]) && isDefined(level.transitionarray[_id_0E25D1D189177A7C]["default"]["callback"]))
    callback = level.transitionarray[_id_0E25D1D189177A7C]["default"]["callback"];

  if(!isDefined(callback))
    return 1;

  if(_id_C8AFEAED872F1486 == ::frontend_camera_move && callback == ::_id_A3721E529C3182FF)
    return 0;

  return 1;
}

_id_A2E4B36E61BB74E2() {
  _func_B3EABE96F8B37124();
  level notify("xcam_transition");
  level._id_7FC91D1D11CD14DE._id_A5461AA8B8E146E1 = 0;
}

_id_E7F97D640F18B510() {
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;
  _id_D45FB3EE26047877 = [];
  _id_2B5E086B37BAD774 = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_lobby_01_xcam", "fe_lobby_plow_cam_01_idle_01_xcam");
  _id_44AD31F0962BAFDF = getEnt("lobby_charslot_01", "targetname");
  _id_D45FB3EE26047877["squad_lobby"] = [];
  _id_D45FB3EE26047877["squad_lobby"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["squad_lobby"]["xcam_data"].origin = _id_44AD31F0962BAFDF.origin;
  _id_D45FB3EE26047877["squad_lobby"]["xcam_data"].angles = _id_44AD31F0962BAFDF.angles;
  _id_D45FB3EE26047877["squad_lobby"]["transitions"] = [];
  _id_D45FB3EE26047877["squad_lobby"]["transitions"][0] = _id_2B5E086B37BAD774;

  if(!_id_9FE1BC92EC9FB00F) {
    _id_D45FB3EE26047877["squad_lobby"]["transitions"][1] = "fe_lobby_plow_cam_01_idle_squad_01_xcam";
    _id_D45FB3EE26047877["squad_lobby"]["transitions"][2] = "fe_lobby_plow_cam_01_mm_01_xcam";
    _id_D45FB3EE26047877["squad_lobby"]["callback"] = ::_id_E6B12E702BF34C5E;
    _id_D45FB3EE26047877["squad_lobby"]["flag_msg"] = ["lobby_member_increase", "started_mm"];
  }

  _id_D45FB3EE26047877["squad_lobby"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["squad_lobby"]["blend_time"]["lobby_member_increase"] = getdvarfloat("dvar_6C2FFD9E1138C485", 4.0);
  _id_D45FB3EE26047877["squad_lobby"]["blend_time"]["started_mm"] = getdvarfloat("dvar_ACEFEFC58946A4B7", 2.0);
  _id_2B5E086B37BAD774 = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_lobby_01_xcam", "fe_lobby_plow_cam_01_idle_01_xcam");

  if(istrue(level._id_70AEE737D4082DAF))
    _id_44AD31F0962BAFDF = getEnt("lobby_dmz_charslot_01", "targetname");

  _id_D45FB3EE26047877["squad_lobby_dmz"] = [];
  _id_D45FB3EE26047877["squad_lobby_dmz"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["squad_lobby_dmz"]["xcam_data"].origin = _id_44AD31F0962BAFDF.origin;
  _id_D45FB3EE26047877["squad_lobby_dmz"]["xcam_data"].angles = _id_44AD31F0962BAFDF.angles;
  _id_D45FB3EE26047877["squad_lobby_dmz"]["transitions"] = [];
  _id_D45FB3EE26047877["squad_lobby_dmz"]["transitions"][0] = _id_2B5E086B37BAD774;

  if(!_id_9FE1BC92EC9FB00F) {
    _id_D45FB3EE26047877["squad_lobby_dmz"]["transitions"][1] = "fe_lobby_plow_cam_01_idle_squad_01_xcam";
    _id_D45FB3EE26047877["squad_lobby_dmz"]["transitions"][2] = "fe_lobby_plow_cam_01_mm_01_xcam";
    _id_D45FB3EE26047877["squad_lobby_dmz"]["callback"] = ::_id_E6B12E702BF34C5E;
    _id_D45FB3EE26047877["squad_lobby_dmz"]["flag_msg"] = ["lobby_member_increase", "started_mm"];
  }

  _id_D45FB3EE26047877["squad_lobby_dmz"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["squad_lobby_dmz"]["blend_time"]["lobby_member_increase"] = getdvarfloat("dvar_6C2FFD9E1138C485", 4.0);
  _id_D45FB3EE26047877["squad_lobby_dmz"]["blend_time"]["started_mm"] = getdvarfloat("dvar_ACEFEFC58946A4B7", 2.0);
  _id_2B5E086B37BAD774 = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_lobby_01_xcam", "fe_lobby_plow_cam_01_idle_01_xcam");

  if(istrue(level._id_70AEE737D4082DAF))
    _id_44AD31F0962BAFDF = getEnt("lobby_br_charslot_01", "targetname");

  _id_D45FB3EE26047877["squad_lobby_br"] = [];
  _id_D45FB3EE26047877["squad_lobby_br"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["squad_lobby_br"]["xcam_data"].origin = _id_44AD31F0962BAFDF.origin;
  _id_D45FB3EE26047877["squad_lobby_br"]["xcam_data"].angles = _id_44AD31F0962BAFDF.angles;
  _id_D45FB3EE26047877["squad_lobby_br"]["transitions"] = [];
  _id_D45FB3EE26047877["squad_lobby_br"]["transitions"][0] = _id_2B5E086B37BAD774;

  if(!_id_9FE1BC92EC9FB00F) {
    _id_D45FB3EE26047877["squad_lobby_br"]["transitions"][1] = "fe_lobby_plow_cam_01_idle_squad_01_xcam";
    _id_D45FB3EE26047877["squad_lobby_br"]["transitions"][2] = "fe_lobby_plow_cam_01_mm_01_xcam";
    _id_D45FB3EE26047877["squad_lobby_br"]["callback"] = ::_id_E6B12E702BF34C5E;
    _id_D45FB3EE26047877["squad_lobby_br"]["flag_msg"] = ["lobby_member_increase", "started_mm"];
  }

  _id_D45FB3EE26047877["squad_lobby_br"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["squad_lobby_br"]["blend_time"]["lobby_member_increase"] = getdvarfloat("dvar_6C2FFD9E1138C485", 4.0);
  _id_D45FB3EE26047877["squad_lobby_br"]["blend_time"]["started_mm"] = getdvarfloat("dvar_ACEFEFC58946A4B7", 2.0);
  _id_D45FB3EE26047877["character_tango"] = [];
  _id_D45FB3EE26047877["character_tango"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["character_tango"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  _id_D45FB3EE26047877["character_tango"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["character_tango"]["transitions"] = [];
  _id_D45FB3EE26047877["character_tango"]["transitions"][0] = "iw9_fe_op_select_generic_male_west_intro_01_xcam";
  _id_D45FB3EE26047877["character_tango"]["transitions"][1] = "iw9_fe_op_select_generic_male_east_intro_01_xcam";
  _id_D45FB3EE26047877["character_tango"]["transitions"][2] = "iw9_fe_op_select_generic_female_west_intro_01_xcam";
  _id_D45FB3EE26047877["character_tango"]["transitions"][3] = "iw9_fe_op_select_generic_female_east_intro_01_xcam";
  _id_D45FB3EE26047877["character_tango"]["transitions"][4] = "iw9_fe_op_select_idle_01_xcam";
  _id_D45FB3EE26047877["character_tango"]["callback"] = ::_id_E7571F41E1D6A427;
  _id_D45FB3EE26047877["character_tango"]["flag_msg"] = "none";
  _id_D45FB3EE26047877["character_tango"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["character_tango"]["blend_time"]["character_faction_select_l_detail"] = 0.1;
  _id_D45FB3EE26047877["character_tango"]["blend_time"]["character_faction_select_r_detail"] = 0.1;
  _id_D45FB3EE26047877["character_faction_select_l"] = [];
  _id_D45FB3EE26047877["character_faction_select_l"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["character_faction_select_l"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  _id_D45FB3EE26047877["character_faction_select_l"]["xcam_data"].angles = (0, -133, 0);
  _id_D45FB3EE26047877["character_faction_select_l"]["transitions"] = [];
  _id_D45FB3EE26047877["character_faction_select_l"]["transitions"][0] = level._id_8A919D89CD6129AE + "fe_op_select_generic_male_east_intro_01_xcam";
  _id_D45FB3EE26047877["character_faction_select_l"]["transitions"][1] = level._id_8A919D89CD6129AE + "fe_op_select_idle_01_xcam";
  _id_D45FB3EE26047877["character_faction_select_l_clone"] = [];
  _id_D45FB3EE26047877["character_faction_select_l_clone"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["character_faction_select_l_clone"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  _id_D45FB3EE26047877["character_faction_select_l_clone"]["xcam_data"].angles = (0, -133, 0);
  _id_D45FB3EE26047877["character_faction_select_l_clone"]["transitions"] = [];
  _id_D45FB3EE26047877["character_faction_select_l_detail"] = [];
  _id_D45FB3EE26047877["character_faction_select_l_detail"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["character_faction_select_l_detail"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  _id_D45FB3EE26047877["character_faction_select_l_detail"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["character_faction_select_l_detail"]["transitions"] = [];
  _id_D45FB3EE26047877["character_faction_select_l_detail"]["transitions"][0] = "iw9_fe_op_select_west_edit_in_xcam";
  _id_D45FB3EE26047877["character_faction_select_r"] = [];
  _id_D45FB3EE26047877["character_faction_select_r"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["character_faction_select_r"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  _id_D45FB3EE26047877["character_faction_select_r"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["character_faction_select_r"]["transitions"] = [];
  _id_D45FB3EE26047877["character_faction_select_r"]["transitions"][0] = level._id_8A919D89CD6129AE + "fe_op_select_generic_male_east_intro_01_xcam";
  _id_D45FB3EE26047877["character_faction_select_r"]["transitions"][1] = level._id_8A919D89CD6129AE + "fe_op_select_idle_01_xcam";
  _id_D45FB3EE26047877["character_faction_select_r_detail"] = [];
  _id_D45FB3EE26047877["character_faction_select_r_detail"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["character_faction_select_r_detail"]["xcam_data"].origin = (-5910.26, -3473.5, 0);
  _id_D45FB3EE26047877["character_faction_select_r_detail"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["character_faction_select_r_detail"]["transitions"] = [];
  _id_D45FB3EE26047877["character_faction_select_r_detail"]["transitions"][0] = "iw9_fe_op_select_east_edit_in_xcam";
  _id_D45FB3EE26047877["loadout_showcase_overview"] = [];
  _id_D45FB3EE26047877["loadout_showcase_overview"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_overview"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  _id_D45FB3EE26047877["loadout_showcase_overview"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["loadout_showcase_overview"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_overview"]["transitions"][0] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_loadout_01_xcam";
  _id_D45FB3EE26047877["loadout_showcase_overview"]["blend_time"] = [];
  _id_D45FB3EE26047877["loadout_showcase_overview"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase_overview"]["blend_time"]["loadout_showcase"] = 0.3;
  _id_D45FB3EE26047877["loadout_showcase_overview"]["blend_time"]["loadout_showcase_overview"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase_overview"]["loop_last"] = 1;
  _id_D45FB3EE26047877["loadout_showcase"] = [];
  _id_D45FB3EE26047877["loadout_showcase"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  _id_D45FB3EE26047877["loadout_showcase"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["loadout_showcase"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase"]["transitions"][0] = "fe_op_crib_xcam_loadout_02_xcam";
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"] = [];
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"]["loadout_showcase_overview"] = 0.3;
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"]["loadout_showcase_perks"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"]["loadout_showcase_p"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"]["loadout_showcase_s"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"]["loadout_showcase_l"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"]["loadout_showcase_t"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase"]["blend_time"]["loadout_showcase_o"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase"]["loop_last"] = 1;
  _id_D45FB3EE26047877["loadout_showcase_preview_small"] = [];
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][0] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_01_xcam";
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][1] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_br_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][2] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_fg_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][3] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_gp_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][4] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_mg_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][5] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_mz_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][6] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_op_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][7] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_st_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][8] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_um_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][9] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_ammo_zoom";

  if(_id_9FE1BC92EC9FB00F)
    _id_D45FB3EE26047877["loadout_showcase_preview_small"]["transitions"][10] = "mgl_fe_op_crib_xcam_gunbench_01_topright_xcam";

  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["callback"] = ::_id_77004A3CA8EFDBBD;
  _id_D45FB3EE26047877["loadout_showcase_preview_small"]["flag_msg"] = "zoom_triggered";
  _id_D45FB3EE26047877["loadout_showcase_preview"] = [];
  _id_D45FB3EE26047877["loadout_showcase_preview"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_preview"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  _id_D45FB3EE26047877["loadout_showcase_preview"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][0] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_02_xcam";
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][1] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_br_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][2] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_fg_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][3] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_gp_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][4] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_mg_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][5] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_mz_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][6] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_op_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][7] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_st_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][8] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_um_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][9] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_ammo_zoom";

  if(_id_9FE1BC92EC9FB00F)
    _id_D45FB3EE26047877["loadout_showcase_preview"]["transitions"][10] = "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam";

  _id_D45FB3EE26047877["loadout_showcase_preview"]["callback"] = ::_id_77004A3CA8EFDBBD;
  _id_D45FB3EE26047877["loadout_showcase_preview"]["flag_msg"] = "zoom_triggered";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"] = [];
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][0] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_03_xcam";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][1] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_br_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][2] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_fg_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][3] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_gp_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][4] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_mg_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][5] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_mz_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][6] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_op_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][7] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_st_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][8] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_um_zoom";
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][9] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_ammo_zoom";

  if(_id_9FE1BC92EC9FB00F)
    _id_D45FB3EE26047877["loadout_showcase_preview_large"]["transitions"][10] = "mgl_fe_op_crib_xcam_gunbench_03_topright_xcam";

  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["callback"] = ::_id_77004A3CA8EFDBBD;
  _id_D45FB3EE26047877["loadout_showcase_preview_large"]["flag_msg"] = "zoom_triggered";
  _id_D45FB3EE26047877["loadout_showcase_perks"] = [];
  _id_D45FB3EE26047877["loadout_showcase_perks"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_perks"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  _id_D45FB3EE26047877["loadout_showcase_perks"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["loadout_showcase_perks"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_perks"]["transitions"][0] = "fe_op_crib_xcam_loadout_pkp_xcam";
  _id_D45FB3EE26047877["loadout_showcase_perks"]["blend_time"] = [];
  _id_D45FB3EE26047877["loadout_showcase_perks"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_p"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.25;
  _id_D45FB3EE26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_s"] = 0.25;
  _id_D45FB3EE26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_l"] = 0.25;
  _id_D45FB3EE26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_t"] = 0.25;
  _id_D45FB3EE26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase_o"] = 0.25;
  _id_D45FB3EE26047877["loadout_showcase_perks"]["blend_time"]["loadout_showcase"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_perks"]["callback"] = ::_id_502EF984F5AD944E;
  _id_D45FB3EE26047877["loadout_showcase_perks"]["flag_msg"] = "loadout_data_set";
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"] = [];
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["xcam_data"].origin = (-5872.09, -3436.26, 0);
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["xcam_data"].angles = (0, -139.143, 0);
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["transitions"][0] = "fe_op_crib_xcam_loadout_fu_xcam";
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["blend_time"] = [];
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_perks"] = 0.25;
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_t"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_p"] = 0.25;
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_s"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_l"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase_o"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["blend_time"]["loadout_showcase"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["callback"] = ::_id_502EF984F5AD944E;
  _id_D45FB3EE26047877["loadout_showcase_field_upgrade"]["flag_msg"] = "loadout_data_set";
  _id_D45FB3EE26047877["loadout_showcase_p"] = [];
  _id_D45FB3EE26047877["loadout_showcase_p"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_p"]["xcam_data"].origin = (-5905.82, -3649.48, 44.0002);
  _id_D45FB3EE26047877["loadout_showcase_p"]["xcam_data"].angles = (0, 270, 90);
  _id_D45FB3EE26047877["loadout_showcase_p"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_p"]["transitions"][0] = "";
  _id_D45FB3EE26047877["loadout_showcase_p"]["blend_time"] = [];
  _id_D45FB3EE26047877["loadout_showcase_p"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_s"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_o"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_perks"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_t"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase_l"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_p"]["blend_time"]["loadout_showcase"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_p"]["callback"] = ::_id_502EF984F5AD944E;
  _id_D45FB3EE26047877["loadout_showcase_p"]["flag_msg"] = "loadout_data_set";
  _id_D45FB3EE26047877["loadout_showcase_s"] = [];
  _id_D45FB3EE26047877["loadout_showcase_s"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_s"]["xcam_data"].origin = (-5897.97, -3658.72, 44.0002);
  _id_D45FB3EE26047877["loadout_showcase_s"]["xcam_data"].angles = (179.99, 270, 90);
  _id_D45FB3EE26047877["loadout_showcase_s"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_s"]["transitions"][0] = "";
  _id_D45FB3EE26047877["loadout_showcase_s"]["blend_time"] = [];
  _id_D45FB3EE26047877["loadout_showcase_s"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_p"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_o"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_perks"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_t"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase_l"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_s"]["blend_time"]["loadout_showcase"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_s"]["callback"] = ::_id_502EF984F5AD944E;
  _id_D45FB3EE26047877["loadout_showcase_s"]["flag_msg"] = "loadout_data_set";
  _id_D45FB3EE26047877["loadout_showcase_o"] = [];
  _id_D45FB3EE26047877["loadout_showcase_o"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_o"]["xcam_data"].origin = (-5897.97, -3658.72, 44.0002);
  _id_D45FB3EE26047877["loadout_showcase_o"]["xcam_data"].angles = (179.99, 270, 90);
  _id_D45FB3EE26047877["loadout_showcase_o"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_o"]["transitions"][0] = "";
  _id_D45FB3EE26047877["loadout_showcase_o"]["blend_time"] = [];
  _id_D45FB3EE26047877["loadout_showcase_o"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_s"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_p"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_perks"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_t"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase_l"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_o"]["blend_time"]["loadout_showcase"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_o"]["callback"] = ::_id_502EF984F5AD944E;
  _id_D45FB3EE26047877["loadout_showcase_o"]["flag_msg"] = "loadout_data_set";
  _id_D45FB3EE26047877["loadout_showcase_l"] = [];
  _id_D45FB3EE26047877["loadout_showcase_l"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_l"]["xcam_data"].origin = (-5879.75, -3642.25, 42.15);
  _id_D45FB3EE26047877["loadout_showcase_l"]["xcam_data"].angles = (0, 230, 0);
  _id_D45FB3EE26047877["loadout_showcase_l"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_l"]["transitions"][0] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_loadout_equip_xcam";
  _id_D45FB3EE26047877["loadout_showcase_l"]["blend_time"] = [];
  _id_D45FB3EE26047877["loadout_showcase_l"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_s"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_p"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_o"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_perks"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_t"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_l"]["blend_time"]["loadout_showcase"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_l"]["callback"] = ::_id_502EF984F5AD944E;
  _id_D45FB3EE26047877["loadout_showcase_l"]["flag_msg"] = "loadout_data_set";
  _id_D45FB3EE26047877["loadout_showcase_t"] = [];
  _id_D45FB3EE26047877["loadout_showcase_t"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["loadout_showcase_t"]["xcam_data"].origin = (-5880.75, -3659, 42.15);
  _id_D45FB3EE26047877["loadout_showcase_t"]["xcam_data"].angles = (0, 230, 0);
  _id_D45FB3EE26047877["loadout_showcase_t"]["transitions"] = [];
  _id_D45FB3EE26047877["loadout_showcase_t"]["transitions"][0] = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_loadout_equip_xcam";
  _id_D45FB3EE26047877["loadout_showcase_t"]["blend_time"] = [];
  _id_D45FB3EE26047877["loadout_showcase_t"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_s"] = 0.2;
  _id_D45FB3EE26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_p"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_o"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_perks"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_field_upgrade"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase_l"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_t"]["blend_time"]["loadout_showcase"] = 0.15;
  _id_D45FB3EE26047877["loadout_showcase_t"]["callback"] = ::_id_502EF984F5AD944E;
  _id_D45FB3EE26047877["loadout_showcase_t"]["flag_msg"] = "loadout_data_set";
  _id_D45FB3EE26047877["weapon_preview"] = [];
  _id_D45FB3EE26047877["weapon_preview"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["weapon_preview"]["xcam_data"].origin = (-3072, 3072, 0);
  _id_D45FB3EE26047877["weapon_preview"]["xcam_data"].angles = (0, 180, 0);
  _id_D45FB3EE26047877["weapon_preview"]["transitions"] = [];
  _id_D45FB3EE26047877["weapon_preview"]["transitions"][0] = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_02_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  _id_D45FB3EE26047877["weapon_preview"]["blend_time"] = [];
  _id_D45FB3EE26047877["weapon_preview"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["weapon_preview_small"] = [];
  _id_D45FB3EE26047877["weapon_preview_small"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["weapon_preview_small"]["xcam_data"].origin = (-3072, 3072, 0);
  _id_D45FB3EE26047877["weapon_preview_small"]["xcam_data"].angles = (0, 180, 0);
  _id_D45FB3EE26047877["weapon_preview_small"]["transitions"] = [];
  _id_D45FB3EE26047877["weapon_preview_small"]["transitions"][0] = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_01_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
  _id_D45FB3EE26047877["weapon_preview_small"]["blend_time"] = [];
  _id_D45FB3EE26047877["weapon_preview_small"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["weapon_preview_large"] = [];
  _id_D45FB3EE26047877["weapon_preview_large"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["weapon_preview_large"]["xcam_data"].origin = (-3072, 3072, 0);
  _id_D45FB3EE26047877["weapon_preview_large"]["xcam_data"].angles = (0, 180, 0);
  _id_D45FB3EE26047877["weapon_preview_large"]["transitions"] = [];
  _id_D45FB3EE26047877["weapon_preview_large"]["transitions"][0] = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_03_xcam", "fe_op_crib_xcam_gunbundle_03_xcam");
  _id_D45FB3EE26047877["weapon_preview_large"]["blend_time"] = [];
  _id_D45FB3EE26047877["weapon_preview_large"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["weapon_progression"] = [];
  _id_D45FB3EE26047877["weapon_progression"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["weapon_progression"]["xcam_data"].origin = (-3072, 3072, 0);
  _id_D45FB3EE26047877["weapon_progression"]["xcam_data"].angles = (0, 180, 0);
  _id_D45FB3EE26047877["weapon_progression"]["transitions"] = [];
  _id_D45FB3EE26047877["weapon_progression"]["transitions"][0] = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  _id_D45FB3EE26047877["weapon_progression"]["blend_time"] = [];
  _id_D45FB3EE26047877["weapon_progression"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["weapon_progression_small"] = [];
  _id_D45FB3EE26047877["weapon_progression_small"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["weapon_progression_small"]["xcam_data"].origin = (-3072, 3072, 0);
  _id_D45FB3EE26047877["weapon_progression_small"]["xcam_data"].angles = (0, 180, 0);
  _id_D45FB3EE26047877["weapon_progression_small"]["transitions"] = [];
  _id_D45FB3EE26047877["weapon_progression_small"]["transitions"][0] = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_01_topright_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
  _id_D45FB3EE26047877["weapon_progression_small"]["blend_time"] = [];
  _id_D45FB3EE26047877["weapon_progression_small"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["weapon_progression_large"] = [];
  _id_D45FB3EE26047877["weapon_progression_large"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["weapon_progression_large"]["xcam_data"].origin = (-3072, 3072, 0);
  _id_D45FB3EE26047877["weapon_progression_large"]["xcam_data"].angles = (0, 180, 0);
  _id_D45FB3EE26047877["weapon_progression_large"]["transitions"] = [];
  _id_D45FB3EE26047877["weapon_progression_large"]["transitions"][0] = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_03_topright_xcam", "fe_op_crib_xcam_gunbundle_03_xcam");
  _id_D45FB3EE26047877["weapon_progression_large"]["blend_time"] = [];
  _id_D45FB3EE26047877["weapon_progression_large"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["weapon_customize"] = [];
  _id_D45FB3EE26047877["weapon_customize"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["weapon_customize"]["xcam_data"].origin = (-3072, 3072, 0);
  _id_D45FB3EE26047877["weapon_customize"]["xcam_data"].angles = (0, 180, 0);
  _id_D45FB3EE26047877["weapon_customize"]["transitions"] = [];
  _id_D45FB3EE26047877["weapon_customize"]["transitions"][0] = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_02_top_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  _id_D45FB3EE26047877["weapon_customize"]["blend_time"] = [];
  _id_D45FB3EE26047877["weapon_customize"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["weapon_customize_small"] = [];
  _id_D45FB3EE26047877["weapon_customize_small"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["weapon_customize_small"]["xcam_data"].origin = (-3072, 3072, 0);
  _id_D45FB3EE26047877["weapon_customize_small"]["xcam_data"].angles = (0, 180, 0);
  _id_D45FB3EE26047877["weapon_customize_small"]["transitions"] = [];
  _id_D45FB3EE26047877["weapon_customize_small"]["transitions"][0] = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_01_top_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
  _id_D45FB3EE26047877["weapon_customize_small"]["blend_time"] = [];
  _id_D45FB3EE26047877["weapon_customize_small"]["blend_time"]["default"] = 0.0;
  _id_D45FB3EE26047877["weapon_customize_large"] = [];
  _id_D45FB3EE26047877["weapon_customize_large"]["xcam_data"] = spawnStruct();
  _id_D45FB3EE26047877["weapon_customize_large"]["xcam_data"].origin = (-3072, 3072, 0);
  _id_D45FB3EE26047877["weapon_customize_large"]["xcam_data"].angles = (0, 180, 0);
  _id_D45FB3EE26047877["weapon_customize_large"]["transitions"] = [];
  _id_D45FB3EE26047877["weapon_customize_large"]["transitions"][0] = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_03_top_xcam", "fe_op_crib_xcam_gunbundle_03_xcam");
  _id_D45FB3EE26047877["weapon_customize_large"]["blend_time"] = [];
  _id_D45FB3EE26047877["weapon_customize_large"]["blend_time"]["default"] = 0.0;
  level._id_8D5E9FC8DDEF81A2 = [];
  level._id_8D5E9FC8DDEF81A2[0] = "";
  level._id_8D5E9FC8DDEF81A2[1] = "";
  level._id_D45FB3EE26047877 = _id_D45FB3EE26047877;
}

_id_24EF280C015211C3(_id_C07ED7A11BAAC844) {
  _id_59D9E5C8A5788818 = _id_C07ED7A11BAAC844[1];

  if(!isDefined(_id_59D9E5C8A5788818))
    return undefined;

  return _id_59D9E5C8A5788818;
}

_id_AEA02750A3AFF7BF(_id_C07ED7A11BAAC844, _id_EA944D415288703F, _id_A8E40F99F797776E) {
  _id_77AC6953396FAFC9 = _id_D2E36762F0204DAD(_id_C07ED7A11BAAC844[2], _id_EA944D415288703F, _id_A8E40F99F797776E);

  if(!isDefined(_id_77AC6953396FAFC9))
    return undefined;

  _id_DDB42D4450CAFE26 = spawnStruct();
  _id_DDB42D4450CAFE26.name = _id_C07ED7A11BAAC844[2];
  _id_DDB42D4450CAFE26._id_6C9750573F9A9742 = _id_77AC6953396FAFC9;
  _id_DDB42D4450CAFE26.origin = (float(_id_C07ED7A11BAAC844[3]), float(_id_C07ED7A11BAAC844[4]), float(_id_C07ED7A11BAAC844[5]));
  _id_DDB42D4450CAFE26.angles = (float(_id_C07ED7A11BAAC844[6]), float(_id_C07ED7A11BAAC844[7]), float(_id_C07ED7A11BAAC844[8]));

  if(isDefined(_id_C07ED7A11BAAC844[9]))
    _id_DDB42D4450CAFE26.class = _id_C07ED7A11BAAC844[9];

  if(isDefined(_id_C07ED7A11BAAC844[10]))
    _id_DDB42D4450CAFE26.weaponname = _id_C07ED7A11BAAC844[10];

  return _id_DDB42D4450CAFE26;
}

_id_7273F375B5991C19(_id_C07ED7A11BAAC844) {
  _id_77AC6953396FAFC9 = _id_D2E36762F0204DAD(_id_C07ED7A11BAAC844[0]);

  if(!isDefined(_id_77AC6953396FAFC9))
    return undefined;

  _id_A1D1C00AD8134A7C = float(_id_C07ED7A11BAAC844[6]);

  if(_id_C07ED7A11BAAC844[0] == "tag_laser_attach")
    _id_A1D1C00AD8134A7C = 90.0;

  _id_DDB42D4450CAFE26 = spawnStruct();
  _id_DDB42D4450CAFE26.name = _id_C07ED7A11BAAC844[0];
  _id_DDB42D4450CAFE26._id_6C9750573F9A9742 = _id_77AC6953396FAFC9;
  _id_DDB42D4450CAFE26.origin = (float(_id_C07ED7A11BAAC844[1]), float(_id_C07ED7A11BAAC844[2]), float(_id_C07ED7A11BAAC844[3]));
  _id_DDB42D4450CAFE26.angles = (float(_id_C07ED7A11BAAC844[4]), float(_id_C07ED7A11BAAC844[5]), _id_A1D1C00AD8134A7C);
  return _id_DDB42D4450CAFE26;
}

_id_21FD6D79CF32E1AC(class) {
  if(!isDefined(class))
    return 0;

  return class == "weapon_projectile" || class == "weapon_classic_s" || class == "weapon_melee2" || class == "weapon_melee" || class == "weapon_classic_p";
}

_id_76228931203A6279(_id_A8E40F99F797776E) {
  if(!isDefined(_id_A8E40F99F797776E))
    return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_02_xcam";

  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;

  switch (_id_A8E40F99F797776E) {
    case "weapon_preview_small":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_01_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
    case "loadout_showcase_preview_small":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_01_xcam";
    case "weapon_customize_small":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_01_top_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
    case "weapon_preview":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_02_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
    case "loadout_showcase_preview":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_02_xcam";
    case "weapon_customize":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_02_top_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
    case "weapon_preview_large":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_03_xcam", "fe_op_crib_xcam_gunbundle_03_xcam");
    case "loadout_showcase_preview_large":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_03_xcam";
    case "weapon_customize_large":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_03_top_xcam", "fe_op_crib_xcam_gunbundle_03_xcam");
    default:
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_02_xcam";
  }
}

_id_65B27252EE6E8284(_id_A8E40F99F797776E) {
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;

  if(!isDefined(_id_A8E40F99F797776E))
    return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");

  switch (_id_A8E40F99F797776E) {
    case "weapon_progression_small":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_01_topright_xcam", "fe_op_crib_xcam_gunbundle_01_xcam");
    case "weapon_progression":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
    case "weapon_progression_large":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_03_topright_xcam", "fe_op_crib_xcam_gunbundle_03_xcam");
    default:
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_02_topright_xcam", "fe_op_crib_xcam_gunbundle_02_xcam");
  }
}

_id_D2E36762F0204DAD(tag, _id_EA944D415288703F, _id_A8E40F99F797776E) {
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;

  switch (tag) {
    case "j_gun":
    case "tag_origin":
      return _id_76228931203A6279(_id_A8E40F99F797776E);
    case "tag_progression":
      return _id_65B27252EE6E8284(_id_A8E40F99F797776E);
    case "tag_silencer":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_mz_xcam";
    case "tag_barrel_attach_small":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_br_pistol_xcam";
    case "tag_barrel_attach":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_br_xcam";
    case "tag_barrel_attach_large":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_br_sniper_xcam";
    case "tag_grip_attach":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_fg_xcam";
    case "tag_laser_attach":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_lz_xcam";
    case "tag_mag_attach":
    case "j_mag1":
      return "fe_op_crib_xcam_gunbench_mg_xcam";
    case "tag_reflex":
    case "tag_scope":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_op_xcam";
    case "tag_pistolgrip_attach":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_gp_xcam";
    case "tag_stock_attach":
      return scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "mgl_fe_op_crib_xcam_gunbench_st_xcam", "fe_op_crib_xcam_gunbench_st_pistol_xcam");
    case "tag_stock_attach_small":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_st_pistol_xcam";
    case "tag_rack_attach":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_st_xcam";
    case "tag_bipod_attach":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_um_xcam";
    case "ammo_display_origin":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_ammo";
    case "tag_cosmetic":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_ch_xcam";
    case "tag_cosdisplay":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_gs_xcam";
    case "tag_sticker":
      return level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_gunbench_stkrs_xcam";
    case "tag_sticker_shotgun":
      return "fe_op_crib_xcam_gunbench_stkrs_sh_xcam";
    default:
      return undefined;
  }
}

_id_2D4A4197B801AD83(_id_0E25D1D189177A7C) {
  switch (_id_0E25D1D189177A7C) {
    case "loadout_showcase_preview_large_muzzle":
    case "loadout_showcase_preview_small_muzzle":
    case "loadout_showcase_preview_muzzle_alt1":
    case "loadout_showcase_preview_muzzle":
      return "tag_silencer";
    case "loadout_showcase_preview_large_barrel_alt1":
    case "loadout_showcase_preview_large_barrel":
    case "loadout_showcase_preview_small_barrel":
    case "loadout_showcase_preview_barrel_alt2":
    case "loadout_showcase_preview_barrel_alt1":
    case "loadout_showcase_preview_barrel":
      return "tag_barrel_attach";
    case "loadout_showcase_preview_large_underbarrel_alt1":
    case "loadout_showcase_preview_large_underbarrel":
    case "loadout_showcase_preview_underbarrel":
      return "tag_grip_attach";
    case "loadout_showcase_preview_large_reargrip_alt1":
    case "loadout_showcase_preview_large_reargrip":
    case "loadout_showcase_preview_small_reargrip":
    case "loadout_showcase_preview_reargrip_alt2":
    case "loadout_showcase_preview_reargrip_alt1":
    case "loadout_showcase_preview_reargrip":
      return "tag_pistolgrip_attach";
    case "loadout_showcase_preview_small_laser":
    case "loadout_showcase_preview_large_laser":
    case "loadout_showcase_preview_laser_alt2":
    case "loadout_showcase_preview_laser_alt1":
    case "loadout_showcase_preview_laser":
      return "tag_laser_attach";
    case "loadout_showcase_preview_large_magazine_alt2":
    case "loadout_showcase_preview_large_magazine_alt1":
    case "loadout_showcase_preview_large_magazine":
    case "loadout_showcase_preview_small_magazine_alt1":
    case "loadout_showcase_preview_small_magazine":
    case "loadout_showcase_preview_magazine_alt2":
    case "loadout_showcase_preview_magazine_alt1":
    case "loadout_showcase_preview_magazine":
      return "j_mag1";
    case "loadout_showcase_preview_large_optic":
    case "loadout_showcase_preview_small_optic":
    case "loadout_showcase_preview_optic_alt1":
    case "loadout_showcase_preview_optic":
      return "tag_reflex";
    case "loadout_showcase_preview_large_stock_alt1":
    case "loadout_showcase_preview_large_stock":
    case "loadout_showcase_preview_small_stock":
    case "loadout_showcase_preview_stock_alt2":
    case "loadout_showcase_preview_stock_alt1":
    case "loadout_showcase_preview_stock":
      return "tag_stock_attach";
    case "loadout_showcase_preview_large_charm_alt2":
    case "loadout_showcase_preview_large_charm_alt1":
    case "loadout_showcase_preview_large_charm":
    case "loadout_showcase_preview_small_charm":
    case "loadout_showcase_preview_charm_alt4":
    case "loadout_showcase_preview_charm_alt3":
    case "loadout_showcase_preview_charm_alt1":
    case "loadout_showcase_preview_charm":
    case "loadout_showcase_preview":
      return "j_gun";
    default:
      return undefined;
  }
}

_id_3C8D38B326A9C64F(_id_C07ED7A11BAAC844) {
  _id_7D0D83A7D32C1036 = [];
  _id_E822AF60D979A676 = [];
  _id_0EAF845499EDE6D4 = [];
  _id_9F06AD7D9A74B7F5 = [];
  _id_21168AC0C3ED30C9 = [];
  _id_21168AC0C3ED30C9[2] = -5910;
  _id_21168AC0C3ED30C9[3] = -3650;
  _id_21168AC0C3ED30C9[4] = 45;
  _id_21168AC0C3ED30C9[5] = 0;
  _id_21168AC0C3ED30C9[6] = 270;
  _id_21168AC0C3ED30C9[7] = 90;
  _id_C254A3B1BFC94AE1 = [];
  _id_C254A3B1BFC94AE1[10] = -5894;
  _id_C254A3B1BFC94AE1[11] = -3658;
  _id_C254A3B1BFC94AE1[12] = 45;
  _id_C254A3B1BFC94AE1[13] = 360;
  _id_C254A3B1BFC94AE1[14] = 90;
  _id_C254A3B1BFC94AE1[15] = 90;
  _id_2DE0742488212FA1 = [];
  _id_2DE0742488212FA1[17] = -5878;
  _id_2DE0742488212FA1[18] = -3642;
  _id_2DE0742488212FA1[19] = 42;
  _id_2DE0742488212FA1[20] = 0;
  _id_2DE0742488212FA1[21] = 227;
  _id_2DE0742488212FA1[22] = 0;
  _id_0CF03C81CB9CFE7C = [];
  _id_0CF03C81CB9CFE7C[24] = -5879;
  _id_0CF03C81CB9CFE7C[25] = -3659;
  _id_0CF03C81CB9CFE7C[26] = 44;
  _id_0CF03C81CB9CFE7C[27] = 0;
  _id_0CF03C81CB9CFE7C[28] = 235;
  _id_0CF03C81CB9CFE7C[29] = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C07ED7A11BAAC844.size; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 > 7 && _id_AC0E594AC96AA3A8 < 16) {
      if(_id_C07ED7A11BAAC844[_id_AC0E594AC96AA3A8] != "none")
        _id_E822AF60D979A676[_id_E822AF60D979A676.size] = _id_C07ED7A11BAAC844[_id_AC0E594AC96AA3A8];
      else
        _id_E822AF60D979A676[_id_E822AF60D979A676.size] = _id_C254A3B1BFC94AE1[_id_AC0E594AC96AA3A8];

      continue;
    }

    if(_id_AC0E594AC96AA3A8 >= 16 && _id_AC0E594AC96AA3A8 < 23) {
      if(_id_C07ED7A11BAAC844[_id_AC0E594AC96AA3A8] != "none")
        _id_0EAF845499EDE6D4[_id_0EAF845499EDE6D4.size] = _id_C07ED7A11BAAC844[_id_AC0E594AC96AA3A8];
      else
        _id_0EAF845499EDE6D4[_id_0EAF845499EDE6D4.size] = _id_2DE0742488212FA1[_id_AC0E594AC96AA3A8];

      continue;
    }

    if(_id_AC0E594AC96AA3A8 >= 23) {
      if(_id_C07ED7A11BAAC844[_id_AC0E594AC96AA3A8] != "none")
        _id_9F06AD7D9A74B7F5[_id_9F06AD7D9A74B7F5.size] = _id_C07ED7A11BAAC844[_id_AC0E594AC96AA3A8];
      else
        _id_9F06AD7D9A74B7F5[_id_9F06AD7D9A74B7F5.size] = _id_0CF03C81CB9CFE7C[_id_AC0E594AC96AA3A8];

      continue;
    }

    if(_id_C07ED7A11BAAC844[_id_AC0E594AC96AA3A8] != "none") {
      _id_7D0D83A7D32C1036[_id_7D0D83A7D32C1036.size] = _id_C07ED7A11BAAC844[_id_AC0E594AC96AA3A8];
      continue;
    }

    _id_7D0D83A7D32C1036[_id_7D0D83A7D32C1036.size] = _id_21168AC0C3ED30C9[_id_AC0E594AC96AA3A8];
  }

  _id_F48B2F9265E216ED = _id_17CF8393E8359FEB(_id_7D0D83A7D32C1036[1]);
  _id_C870A7B5804FF26D = _id_0A2EFA6BB922DDCF(_id_E822AF60D979A676[1]);

  if(!isDefined(_id_F48B2F9265E216ED) || !isDefined(_id_C870A7B5804FF26D))
    return undefined;

  _id_6362D7A8BDF41F78 = spawnStruct();
  _id_6362D7A8BDF41F78.name = "loadout_showcase_p";
  _id_6362D7A8BDF41F78._id_6C9750573F9A9742 = _id_F48B2F9265E216ED;
  _id_6362D7A8BDF41F78.origin = (float(_id_7D0D83A7D32C1036[2]), float(_id_7D0D83A7D32C1036[3]), float(_id_7D0D83A7D32C1036[4]));
  _id_90B2927BF28547E8 = spawnStruct();
  _id_90B2927BF28547E8.name = _id_5B8B22B77B344D91(_id_E822AF60D979A676[1]);
  _id_90B2927BF28547E8._id_6C9750573F9A9742 = _id_C870A7B5804FF26D;
  _id_90B2927BF28547E8.origin = (float(_id_E822AF60D979A676[2]), float(_id_E822AF60D979A676[3]), float(_id_E822AF60D979A676[4]));
  level._id_D45FB3EE26047877["loadout_showcase_o"]["transitions"] = [];
  level._id_D45FB3EE26047877["loadout_showcase_o"]["transitions"][0] = _id_90B2927BF28547E8._id_6C9750573F9A9742;
  _id_8BB24F977B8C9FE0 = spawnStruct();
  _id_8BB24F977B8C9FE0.name = "loadout_showcase_l";
  _id_8BB24F977B8C9FE0._id_6C9750573F9A9742 = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_loadout_equip_xcam";
  _id_71BA24485168E2FB = spawnStruct();
  _id_71BA24485168E2FB.name = "loadout_showcase_t";
  _id_71BA24485168E2FB._id_6C9750573F9A9742 = level._id_9AA5B3137BD141B4 + "fe_op_crib_xcam_loadout_equip_xcam";
  return [_id_6362D7A8BDF41F78, _id_90B2927BF28547E8, _id_8BB24F977B8C9FE0, _id_71BA24485168E2FB];
}

_id_5B8B22B77B344D91(weaponname) {
  switch (weaponname) {
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_dmr":
    case "weapon_shotgun":
    case "weapon_battle":
    case "weapon_assault":
    case "weapon_smg":
    case "weapon_projectile":
      return "loadout_showcase_s";
    case "weapon_pistol":
    case "weapon_melee":
      return "loadout_showcase_s";
    default:
      return "loadout_showcase_s";
  }
}

_id_17CF8393E8359FEB(tag) {
  switch (tag) {
    case "weapon_smg":
    case "weapon_melee2":
      return "fe_op_crib_xcam_loadout_smg_xcam";
    case "weapon_dmr":
    case "weapon_shotgun":
    case "weapon_battle":
    case "weapon_assault":
      return "fe_op_crib_xcam_loadout_ar_xcam";
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_melee":
    case "weapon_projectile":
      return "fe_op_crib_xcam_loadout_sn_xcam";
    case "weapon_pistol":
      return "fe_op_crib_xcam_loadout_pi_xcam";
    default:
      return undefined;
  }
}

_id_0A2EFA6BB922DDCF(tag) {
  switch (tag) {
    case "weapon_smg":
    case "weapon_melee2":
      return "fe_op_crib_xcam_loadout_smg_xcam";
    case "weapon_dmr":
    case "weapon_shotgun":
    case "weapon_battle":
    case "weapon_assault":
      return "fe_op_crib_xcam_loadout_ar_xcam";
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_melee":
    case "weapon_projectile":
      return "fe_op_crib_xcam_loadout_sn_xcam";
    case "weapon_pistol":
      return "fe_op_crib_xcam_loadout_pi_xcam";
    default:
      return undefined;
  }
}

_id_F32739A3B45E91BA(_id_E81DDC7D78BB73C0) {
  if(getDvar("frontEndFastfileName") == "mp_frontend6")
    level.playerviewowner _meth_451319F93D30EBE5("hw_mp_frontend6_lobby_rt");
  else
    level.playerviewowner _meth_451319F93D30EBE5("hw_mp_frontend_lobby_rt");
}

_id_D5386639BF9FC14C(_id_E81DDC7D78BB73C0) {
  if(getDvar("frontEndFastfileName") == "mp_frontend6")
    level.playerviewowner _meth_0DF8FAD503896462("hw_mp_frontend6_lobby_rt");
  else
    level.playerviewowner _meth_0DF8FAD503896462("hw_mp_frontend_lobby_rt");
}

_id_B7807AB9EFBE2177() {
  level._id_2F5D13D3887F56A5 = [];
  level._id_2F5D13D3887F56A5["squad_lobby"] = ::_id_F32739A3B45E91BA;
  level._id_2F5D13D3887F56A5["squad_lobby_br"] = ::_id_F32739A3B45E91BA;
  level._id_2F5D13D3887F56A5["squad_lobby_dmz"] = ::_id_F32739A3B45E91BA;
  level._id_B50F0A931C0A33A1 = [];
  level._id_B50F0A931C0A33A1["squad_lobby"] = ::_id_D5386639BF9FC14C;
  level._id_B50F0A931C0A33A1["squad_lobby_br"] = ::_id_D5386639BF9FC14C;
  level._id_B50F0A931C0A33A1["squad_lobby_dmz"] = ::_id_D5386639BF9FC14C;
}

initialize_transition_array() {
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;
  transitionarray = [];
  transitionarray["loadout_showcase"] = [];
  transitionarray["loadout_showcase"]["default"] = [];
  transitionarray["loadout_showcase"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase"]["default"]["fov"] = 36;
  transitionarray["loadout_showcase"]["character_tango"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase"]["character_tango"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase"]["character_tango"]["fov"] = 36;
  transitionarray["loadout_showcase"]["character_tango"]["fadeOutTime"] = 0.2;
  transitionarray["loadout_showcase"]["character_tango"]["fadeInTime"] = 0.2;
  _id_1ADDD326036D635D = [];
  _id_1ADDD326036D635D["transition"] = ::frontend_camera_move;
  _id_1ADDD326036D635D["callback"] = ::_id_A3721E529C3182FF;
  _id_1ADDD326036D635D["speed"] = 200;
  transitionarray["loadout_showcase"]["weapon_showcase"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_overview"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_p"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_p_large"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_o"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_o_large"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_s"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_l"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_t"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_field_upgrade"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_perks"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_x"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_y"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_z"] = _id_1ADDD326036D635D;
  transitionarray["loadout_showcase"]["loadout_showcase_watch"] = _id_1ADDD326036D635D;
  _id_AAB752CABC872AC6 = [];
  _id_AAB752CABC872AC6["transition"] = ::frontend_camera_teleport;
  _id_AAB752CABC872AC6["callback"] = ::_id_A3721E529C3182FF;
  _id_AAB752CABC872AC6["fadeOutTime"] = 0.05;
  _id_AAB752CABC872AC6["fadeInTime"] = 0.05;
  _id_AAB752CABC872AC6["fov"] = 36;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_barrel"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_barrel_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_laser"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_laser_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_laser_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_large_laser"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_magazine"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_magazine_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_muzzle"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_muzzle_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_optic"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_optic_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_reargrip"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_reargrip_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_reargrip_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_stock"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_stock_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_stock_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_large_stock_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_underbarrel"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt3"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_charm_alt4"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt3"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_preview_sticker_alt4"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_barrel"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_laser"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_muzzle"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_optic"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_magazine"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_magazine_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_reargrip"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_stock"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_trigger"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_charm"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_preview_small_sticker"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_barrel"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_barrel_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_laser"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_laser"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_magazine_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_muzzle"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_optic"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_reargrip"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_reargrip_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_stock"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_stock_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_underbarrel"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_underbarrel_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_charm"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_charm_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_charm_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker_alt1"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker_alt2"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_preview_large_sticker_alt3"] = _id_AAB752CABC872AC6;
  transitionarray["loadout_showcase_overview"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_overview"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_overview"]["default"]["fov"] = 36;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["transition"] = ::frontend_camera_move;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["speed"] = 200;
  transitionarray["loadout_showcase_overview"]["loadout_showcase"]["fov"] = 36;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["transition"] = ::frontend_camera_move;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["speed"] = 200;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_p"]["fov"] = 36;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_watch"]["transition"] = ::frontend_camera_move;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_watch"]["callback"] = ::update_entities_and_camera;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_watch"]["speed"] = 200;
  transitionarray["loadout_showcase_overview"]["loadout_showcase_watch"]["fov"] = 36;
  transitionarray["loadout_showcase_overview"]["character_tango"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_overview"]["character_tango"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_overview"]["character_tango"]["fov"] = 36;
  transitionarray["loadout_showcase_overview"]["character_tango"]["fadeOutTime"] = 0.0;
  _id_10E019B79EB17404 = [];
  _id_10E019B79EB17404["transition"] = ::frontend_camera_teleport;
  _id_10E019B79EB17404["callback"] = ::_id_A3721E529C3182FF;
  _id_10E019B79EB17404["fadeOutTime"] = 0.2;
  _id_10E019B79EB17404["fadeInTime"] = 0.2;
  _id_10E019B79EB17404["fov"] = 36;
  transitionarray["loadout_showcase_preview"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_o"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview"]["weapon_progression"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview"]["weapon_progression_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview"]["weapon_progression_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview"]["weapon_customize"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_large"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_o_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_o"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["weapon_progression"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["weapon_progression_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["weapon_progression_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["weapon_customize_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large"]["weapon_customize_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_small"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_small"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_small"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_small"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_small"]["weapon_progression_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_small"]["weapon_progression"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_small"]["weapon_progression_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_small"]["weapon_customize_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_riot"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_riot"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_o"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_o_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_riot"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_riot"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_sticker"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt1"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt2"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt3"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_sticker_alt4"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_small_sticker"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_small_sticker"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_small_sticker"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large_sticker"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_large_sticker"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_large_sticker"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_charm"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt1"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm_alt1"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_charm_alt1"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt1"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt1"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt1"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt2"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm_alt2"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_charm_alt2"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt2"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt2"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt2"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt3"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm_alt3"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_charm_alt3"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt3"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt3"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt3"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt4"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_charm_alt4"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_charm_alt4"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt4"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt4"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_charm_alt4"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_small_charm"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_small_charm"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_small_charm"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["loadout_showcase_preview_large_charm"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_large_charm"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_large_charm"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_preview"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_preview"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview"]["loadout_showcase_o"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview"]["loadout_showcase_preview"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview"]["weapon_progression"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview"]["weapon_customize"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_large"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_preview_large"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_preview_large"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_large"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_large"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_large"]["loadout_showcase_preview_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_large"]["weapon_progression_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_large"]["weapon_customize_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_large"]["weapon_customize_riot"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_small"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_preview_small"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_preview_small"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_small"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_small"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_small"]["loadout_showcase_preview_small"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_small"]["weapon_progression_small"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_small"]["weapon_customize_small"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_riot"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_preview_riot"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_preview_riot"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_riot"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_preview_riot"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_progression"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_progression"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression"]["loadout_showcase_o"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression"]["loadout_showcase_preview"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression"]["weapon_customize"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_large"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_progression_large"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_progression_large"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_large"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_large"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_large"]["loadout_showcase_preview_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_large"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_large"]["weapon_customize_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_large"]["weapon_customize_riot"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_small"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_progression_small"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_progression_small"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_small"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_small"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_small"]["loadout_showcase_preview_small"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_small"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["weapon_progression_small"]["weapon_customize_small"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_customize"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_customize"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize"]["loadout_showcase_o"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize"]["loadout_showcase_preview"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize"]["weapon_preview"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize"]["weapon_progression"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_large"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_customize_large"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_customize_large"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_large"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_large"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_large"]["loadout_showcase_preview_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_large"]["weapon_preview_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_large"]["weapon_progression_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_small"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_customize_small"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_customize_small"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_small"]["loadout_showcase_p_large"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_small"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_small"]["loadout_showcase_preview_small"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_small"]["weapon_preview_small"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_small"]["weapon_progression_small"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_riot"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["weapon_customize_riot"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["weapon_customize_riot"]["loadout_showcase_p"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_riot"]["loadout_showcase_s"] = _id_10E019B79EB17404;
  transitionarray["weapon_customize_riot"]["weapon_preview_riot"] = _id_10E019B79EB17404;
  transitionarray["bundle_preview"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["bundle_preview"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["bundle_preview_large"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["bundle_preview_large"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["bundle_preview_small"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["bundle_preview_small"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["bundle_preview_riot"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["bundle_preview_riot"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_watch"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["loadout_showcase_preview_watch"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["loadout_showcase_preview_watch"]["loadout_showcase_watch"] = _id_10E019B79EB17404;
  _id_C82921AD71045243["transition"] = ::frontend_camera_teleport;
  _id_C82921AD71045243["callback"] = ::_id_A3721E529C3182FF;
  _id_C82921AD71045243["fadeOutTime"] = 0.2;
  _id_C82921AD71045243["fadeInTime"] = 0.2;
  _id_C82921AD71045243["fov"] = 36;
  _id_19E7D2726F0D24A5 = [];
  _id_19E7D2726F0D24A5["transition"] = ::frontend_camera_move;
  _id_19E7D2726F0D24A5["callback"] = ::_id_A3721E529C3182FF;
  _id_19E7D2726F0D24A5["speed"] = 200;
  _id_19E7D2726F0D24A5["accelScalar"] = 0.9;
  _id_19E7D2726F0D24A5["moveTime"] = 0.5;
  _id_19E7D2726F0D24A5["decelScalar"] = 0.1;
  transitionarray["loadout_showcase_p"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p"]["loadout_showcase"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p"]["loadout_showcase_overview"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p"]["loadout_showcase_preview"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p"]["weapon_preview"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p"]["weapon_preview_small"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p"]["weapon_preview_large"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p"]["weapon_preview_riot"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p_large"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["loadout_showcase_preview"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_p_large"]["weapon_preview"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p_large"]["weapon_preview_small"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p_large"]["weapon_preview_large"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_p_large"]["weapon_preview_riot"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_s"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_s"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["loadout_showcase_preview"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_s"]["weapon_preview"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_s"]["weapon_preview_small"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_s"]["weapon_preview_large"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_s"]["weapon_preview_riot"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["loadout_showcase_preview"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o"]["weapon_preview"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o"]["weapon_preview_small"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o"]["weapon_preview_large"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o"]["weapon_preview_riot"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o_large"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["loadout_showcase_preview"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_o_large"]["weapon_preview"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o_large"]["weapon_preview_small"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o_large"]["weapon_preview_large"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_o_large"]["weapon_preview_riot"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_l"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_l"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_l"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_t"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_t"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_field_upgrade"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_perks"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_x"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_specialist"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_x"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_y"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_specialist"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_y"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_z"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_specialist"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_z"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_specialist"]["loadout_showcase_watch"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["default"] = _id_C82921AD71045243;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_p"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_p_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_s"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_o"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_o_large"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_l"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_t"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_field_upgrade"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_perks"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_x"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_y"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_z"] = _id_19E7D2726F0D24A5;
  transitionarray["loadout_showcase_watch"]["loadout_showcase_overview"] = _id_19E7D2726F0D24A5;
  transitionarray["character_tango"]["default"]["transition"] = ::frontend_camera_move;
  transitionarray["character_tango"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["default"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["character_faction_select_l_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["character_tango"]["character_faction_select_l_detail"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["character_faction_select_l_detail"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["character_faction_select_r_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["character_tango"]["character_faction_select_r_detail"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["character_faction_select_r_detail"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["squad_lobby"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tango"]["squad_lobby"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["squad_lobby"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["squad_lobby_br"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tango"]["squad_lobby_br"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["squad_lobby_br"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["squad_lobby_dmz"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tango"]["squad_lobby_dmz"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["squad_lobby_dmz"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["black_screen"]["transition"] = ::frontend_camera_move;
  transitionarray["character_tango"]["black_screen"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["loadout_showcase"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tango"]["loadout_showcase"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["loadout_showcase"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["loadout_showcase"]["fadeOutTime"] = 0.2;
  transitionarray["character_tango"]["loadout_showcase"]["fadeInTime"] = 0.2;
  transitionarray["character_tango"]["loadout_showcase_overview"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tango"]["loadout_showcase_overview"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["loadout_showcase_overview"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["loadout_showcase_overview"]["fadeOutTime"] = 0.0;
  transitionarray["character_tango"]["battle_pass_character"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tango"]["battle_pass_character"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["battle_pass_character"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["battle_pass_weapon"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tango"]["battle_pass_weapon"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["battle_pass_weapon"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["battle_pass_items"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tango"]["battle_pass_items"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["battle_pass_items"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_tango"]["battle_pass_vehicle"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tango"]["battle_pass_vehicle"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_tango"]["battle_pass_vehicle"]["fov"] = level.camera_character_tango.myfov;
  transitionarray["character_faction_select_l"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_l"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l"]["default"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["speed"] = 150;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["use_bounce"] = 1;
  transitionarray["character_faction_select_l"]["character_faction_select_l_detail"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l"]["character_faction_select_r"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_l_clone"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_l_clone"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l_clone"]["default"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_faction_select_l_detail"]["default"]["transition"] = ::frontend_camera_move;
  transitionarray["character_faction_select_l_detail"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l_detail"]["default"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_r_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_r_detail"]["fov"] = level.camera_character_faction_select_r_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_r_detail"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["transition"] = ::frontend_camera_move;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["speed"] = 150;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["use_bounce"] = 1;
  transitionarray["character_faction_select_l_detail"]["character_faction_select_l"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l_detail"]["squad_lobby"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_l_detail"]["squad_lobby"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l_detail"]["squad_lobby"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_l_detail"]["squad_lobby_br"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l_detail"]["squad_lobby_br"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["squad_lobby_br"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["squad_lobby_dmz"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_l_detail"]["squad_lobby_dmz"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l_detail"]["squad_lobby_dmz"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["battle_pass_character_detail"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_l_detail"]["battle_pass_character_detail"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_l_detail"]["battle_pass_character_detail"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["battle_pass_character_detail"]["fadeOutTime"] = 0.3;
  transitionarray["character_faction_select_l_detail"]["battle_pass_character_detail"]["fadeInTime"] = 0.3;
  transitionarray["character_faction_select_l_detail"]["battle_pass_character"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_l_detail"]["battle_pass_character"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_l_detail"]["battle_pass_character"]["fadeOutTime"] = 0.3;
  transitionarray["character_faction_select_l_detail"]["battle_pass_character"]["fadeInTime"] = 0.3;
  transitionarray["character_faction_select_r"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_r"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_r"]["default"]["fov"] = level.camera_character_faction_select_r.myfov;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["speed"] = 150;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["fov"] = level.camera_character_faction_select_r_detail.myfov;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_r"]["character_faction_select_r_detail"]["use_bounce"] = 1;
  transitionarray["character_faction_select_r"]["character_faction_select_l"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_faction_select_r_detail"]["default"]["transition"] = ::frontend_camera_move;
  transitionarray["character_faction_select_r_detail"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_r_detail"]["default"]["fov"] = level.camera_character_faction_select_r_detail.myfov;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_l_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_l_detail"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_l_detail"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["transition"] = ::frontend_camera_move;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["speed"] = 150;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["fov"] = level.camera_character_faction_select_r.myfov;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["character_faction_select_r_detail"]["character_faction_select_r"]["use_bounce"] = 1;
  transitionarray["character_preview_select"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_preview_select"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["character_preview_select"]["default"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_preview_select"]["character_preview_select_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["character_preview_select"]["character_preview_select_detail"]["speed"] = 150;
  transitionarray["character_preview_select"]["character_preview_select_detail"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_preview_select"]["character_preview_select_detail"]["use_bounce"] = 1;
  transitionarray["character_preview_select"]["character_preview_select"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_preview_select_detail"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_preview_select_detail"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["character_preview_select_detail"]["default"]["fov"] = level.camera_character_faction_select_l_detail.myfov;
  transitionarray["character_preview_select_detail"]["character_preview_select_detail"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_preview_select_detail"]["character_preview_select_detail"]["fov"] = level.camera_character_faction_select_r_detail.myfov;
  transitionarray["character_preview_select_detail"]["character_preview_select"]["transition"] = ::frontend_camera_move;
  transitionarray["character_preview_select_detail"]["character_preview_select"]["speed"] = 150;
  transitionarray["character_preview_select_detail"]["character_preview_select"]["fov"] = level.camera_character_faction_select_l.myfov;
  transitionarray["character_preview_select_detail"]["character_preview_select"]["use_bounce"] = 1;
  transitionarray["character_tournaments"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["character_tournaments"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["character_tournaments"]["default"]["fov"] = 36;
  transitionarray["squad_lobby"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["squad_lobby"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["squad_lobby"]["default"]["fov"] = 36;
  transitionarray["squad_lobby"]["squad_lobby_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["squad_lobby"]["squad_lobby_detail"]["speed"] = 150;
  transitionarray["squad_lobby"]["squad_lobby_detail"]["fov"] = 36;
  transitionarray["squad_lobby"]["squad_lobby_detail"]["use_bounce"] = 1;
  transitionarray["squad_lobby"]["loadout_showcase_overview"]["transition"] = ::frontend_camera_teleport;
  transitionarray["squad_lobby"]["loadout_showcase_overview"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["squad_lobby"]["loadout_showcase_overview"]["fov"] = 36;
  transitionarray["squad_lobby"]["loadout_showcase_overview"]["fadeOutTime"] = 0.0;
  transitionarray["squad_lobby_dmz"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["squad_lobby_dmz"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["squad_lobby_dmz"]["default"]["fov"] = 36;
  transitionarray["squad_lobby_dmz"]["squad_lobby_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["squad_lobby_dmz"]["squad_lobby_detail"]["speed"] = 150;
  transitionarray["squad_lobby_dmz"]["squad_lobby_detail"]["fov"] = 36;
  transitionarray["squad_lobby_dmz"]["squad_lobby_detail"]["use_bounce"] = 1;
  transitionarray["squad_lobby_dmz"]["loadout_showcase_overview"]["transition"] = ::frontend_camera_teleport;
  transitionarray["squad_lobby_dmz"]["loadout_showcase_overview"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["squad_lobby_dmz"]["loadout_showcase_overview"]["fov"] = 36;
  transitionarray["squad_lobby_dmz"]["loadout_showcase_overview"]["fadeOutTime"] = 0.0;
  transitionarray["squad_lobby_br"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["squad_lobby_br"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["squad_lobby_br"]["default"]["fov"] = 36;
  transitionarray["squad_lobby_br"]["squad_lobby_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["squad_lobby_br"]["squad_lobby_detail"]["speed"] = 150;
  transitionarray["squad_lobby_br"]["squad_lobby_detail"]["fov"] = 36;
  transitionarray["squad_lobby_br"]["squad_lobby_detail"]["use_bounce"] = 1;
  transitionarray["squad_lobby_br"]["loadout_showcase_overview"]["transition"] = ::frontend_camera_teleport;
  transitionarray["squad_lobby_br"]["loadout_showcase_overview"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["squad_lobby_br"]["loadout_showcase_overview"]["fov"] = 36;
  transitionarray["squad_lobby_br"]["loadout_showcase_overview"]["fadeOutTime"] = 0.0;
  transitionarray["squad_lobby_detail"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["squad_lobby_detail"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["squad_lobby_detail"]["default"]["fov"] = 36;
  transitionarray["squad_lobby_detail"]["squad_lobby"]["transition"] = ::frontend_camera_move;
  transitionarray["squad_lobby_detail"]["squad_lobby"]["speed"] = 150;
  transitionarray["squad_lobby_detail"]["squad_lobby"]["fov"] = 36;
  transitionarray["squad_lobby_detail"]["squad_lobby"]["use_bounce"] = 1;
  transitionarray["squad_lobby_detail"]["squad_lobby_dmz"]["transition"] = ::frontend_camera_move;
  transitionarray["squad_lobby_detail"]["squad_lobby_dmz"]["speed"] = 150;
  transitionarray["squad_lobby_detail"]["squad_lobby_dmz"]["fov"] = 36;
  transitionarray["squad_lobby_detail"]["squad_lobby_dmz"]["use_bounce"] = 1;
  transitionarray["squad_lobby_detail"]["squad_lobby_br"]["transition"] = ::frontend_camera_move;
  transitionarray["squad_lobby_detail"]["squad_lobby_br"]["speed"] = 150;
  transitionarray["squad_lobby_detail"]["squad_lobby_br"]["fov"] = 36;
  transitionarray["squad_lobby_detail"]["squad_lobby_br"]["use_bounce"] = 1;
  transitionarray["social"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["social"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["social"]["default"]["fov"] = 36;
  transitionarray["social"]["social_detail"]["transition"] = ::frontend_camera_move;
  transitionarray["social"]["social_detail"]["speed"] = 150;
  transitionarray["social"]["social_detail"]["fov"] = 36;
  transitionarray["social"]["social_detail"]["use_bounce"] = 1;
  transitionarray["social_detail"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["social_detail"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["social_detail"]["default"]["fov"] = 36;
  transitionarray["social_detail"]["social"]["transition"] = ::frontend_camera_move;
  transitionarray["social_detail"]["social"]["speed"] = 150;
  transitionarray["social_detail"]["social"]["fov"] = 36;
  transitionarray["social_detail"]["social"]["use_bounce"] = 1;
  transitionarray["social_wide"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["social_wide"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["social_wide"]["default"]["fov"] = 36;
  transitionarray["social_showcase"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["social_showcase"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["social_showcase"]["default"]["fov"] = 36;
  transitionarray["showcase_operator"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["showcase_operator"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["showcase_operator"]["default"]["fov"] = 36;
  transitionarray["showcase_weapon"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["showcase_weapon"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["showcase_weapon"]["default"]["fov"] = 36;
  transitionarray["aar_performance"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["aar_performance"]["default"]["callback"] = ::_id_A3721E529C3182FF;
  transitionarray["aar_performance"]["default"]["fov"] = 36;
  transitionarray["ui_bg_01"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["ui_bg_01"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["ui_bg_01"]["default"]["fov"] = 28;
  transitionarray["weapon_showcase"] = [];
  transitionarray["weapon_showcase"]["default"] = [];
  transitionarray["weapon_showcase"]["default"]["transition"] = ::frontend_camera_move;
  transitionarray["weapon_showcase"]["default"]["callback"] = ::update_camera_depth_of_field;
  transitionarray["weapon_showcase"]["default"]["speed"] = 75;
  transitionarray["barracks"] = [];
  transitionarray["barracks"]["default"] = [];
  transitionarray["barracks"]["default"]["transition"] = ::frontend_camera_move;
  transitionarray["barracks"]["default"]["callback"] = ::update_camera_depth_of_field;
  transitionarray["barracks"]["default"]["speed"] = 100;
  transitionarray["barracks"]["weapon_showcase"]["speed"] = 5000;
  transitionarray["player_character_showcase"] = [];
  transitionarray["player_character_showcase"]["default"] = [];
  transitionarray["player_character_showcase"]["default"]["transition"] = ::frontend_camera_teleport;
  transitionarray["player_character_showcase"]["default"]["callback"] = ::update_player_character_showcase;
  _id_15614224C14E9EFD = [];
  _id_15614224C14E9EFD["transition"] = ::frontend_camera_teleport;
  _id_15614224C14E9EFD["fadeOutTime"] = 0.1;
  _id_15614224C14E9EFD["fadeInTime"] = 0.15;
  transitionarray["battle_pass_vehicle"]["default"] = _id_15614224C14E9EFD;
  transitionarray["battle_pass_vehicle"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["battle_pass_character"]["default"] = _id_15614224C14E9EFD;
  transitionarray["battle_pass_character"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["battle_pass_weapon"]["default"] = _id_15614224C14E9EFD;
  transitionarray["battle_pass_weapon"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["battle_pass_items"]["default"] = _id_15614224C14E9EFD;
  transitionarray["battle_pass_items"]["default"]["callback"] = ::update_entities_and_camera;
  transitionarray["battle_pass_vehicle"]["social"] = [];
  transitionarray["battle_pass_vehicle"]["social"]["transition"] = ::frontend_camera_teleport;
  transitionarray["battle_pass_vehicle"]["social"]["fadeOutTime"] = 0;
  transitionarray["battle_pass_vehicle"]["social"]["fadeInTime"] = 0;
  transitionarray["battle_pass_character"]["social"] = [];
  transitionarray["battle_pass_character"]["social"]["transition"] = ::frontend_camera_teleport;
  transitionarray["battle_pass_character"]["social"]["fadeOutTime"] = 0;
  transitionarray["battle_pass_character"]["social"]["fadeInTime"] = 0;
  transitionarray["battle_pass_weapon"]["social"] = [];
  transitionarray["battle_pass_weapon"]["social"]["transition"] = ::frontend_camera_teleport;
  transitionarray["battle_pass_weapon"]["social"]["fadeOutTime"] = 0;
  transitionarray["battle_pass_weapon"]["social"]["fadeInTime"] = 0;
  transitionarray["battle_pass_items"]["social"] = [];
  transitionarray["battle_pass_items"]["social"]["transition"] = ::frontend_camera_teleport;
  transitionarray["battle_pass_items"]["social"]["fadeOutTime"] = 0;
  transitionarray["battle_pass_items"]["social"]["fadeInTime"] = 0;
  transitionarray["firingrange"]["default"] = _id_15614224C14E9EFD;
  transitionarray["firingrange"]["default"]["callback"] = ::update_entities_and_camera;
  level.transitionarray = transitionarray;
}

get_section_state(_id_402BEAA866B682A2) {
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;
  _id_5251A242A4D3B765 = [];
  _id_ACF68BB64D0400F8 = !isDefined(level.active_scene_data) || level.transition_interrupted;
  level.playerviewowner visionsetnakedforplayer("", 0);

  switch (_id_402BEAA866B682A2.name) {
    case "mlg.tv":
      break;
    case "black_screen":
      _id_5251A242A4D3B765["scene"] = level._id_61F3469BFD32FC67;
      _id_5251A242A4D3B765["camera"] = level._id_61F3469BFD32FC67.basecam;
      break;
    case "squad_lobby":
      _id_5251A242A4D3B765["scene"] = level.camera_lobby;
      _id_5251A242A4D3B765["camera"] = level.camera_lobby.basecam;
      break;
    case "squad_lobby_detail":
      _id_5251A242A4D3B765["scene"] = level.camera_lobby_detail;
      _id_5251A242A4D3B765["camera"] = level.camera_lobby_detail.basecam;
      break;
    case "squad_lobby_dmz":
      if(istrue(level._id_70AEE737D4082DAF)) {
        _id_5251A242A4D3B765["scene"] = level._id_B78F085CE2B63F91;
        _id_5251A242A4D3B765["camera"] = level._id_B78F085CE2B63F91.basecam;
      } else {
        _id_5251A242A4D3B765["scene"] = level.camera_lobby_detail;
        _id_5251A242A4D3B765["camera"] = level.camera_lobby_detail.basecam;
      }

      break;
    case "squad_lobby_br":
      if(istrue(level._id_70AEE737D4082DAF)) {
        _id_5251A242A4D3B765["scene"] = level._id_0E679086C223BDFA;
        _id_5251A242A4D3B765["camera"] = level._id_0E679086C223BDFA.basecam;
      } else {
        _id_5251A242A4D3B765["scene"] = level.camera_lobby_detail;
        _id_5251A242A4D3B765["camera"] = level.camera_lobby_detail.basecam;
      }

      break;
    case "br_lobby":
      _id_5251A242A4D3B765["scene"] = level._id_0E679086C223BDFA;
      _id_5251A242A4D3B765["camera"] = level._id_0E679086C223BDFA.basecam;
      break;
    case "br_lobby_detail":
      _id_5251A242A4D3B765["scene"] = level._id_816F5B98CFE745FE;
      _id_5251A242A4D3B765["camera"] = level._id_816F5B98CFE745FE.basecam;
      break;
    case "dmz_lobby":
      _id_5251A242A4D3B765["scene"] = level._id_B78F085CE2B63F91;
      _id_5251A242A4D3B765["camera"] = level._id_B78F085CE2B63F91.basecam;
      break;
    case "dmz_lobby_detail":
      _id_5251A242A4D3B765["scene"] = level._id_837428C53BE309FB;
      _id_5251A242A4D3B765["camera"] = level._id_837428C53BE309FB.basecam;
      break;
    case "crib_dmz":
      _id_5251A242A4D3B765["scene"] = level._id_B0C5FFD7BAC552C5;
      _id_5251A242A4D3B765["camera"] = level._id_B0C5FFD7BAC552C5.basecam;
      break;
    case "crib_dmz_detail":
      _id_5251A242A4D3B765["scene"] = level._id_172FADDC8AEE05AF;
      _id_5251A242A4D3B765["camera"] = level._id_172FADDC8AEE05AF.basecam;
      break;
    case "social":
      _id_5251A242A4D3B765["scene"] = level._id_4EA67C4450821778;
      _id_5251A242A4D3B765["camera"] = level._id_4EA67C4450821778.basecam;
      break;
    case "social_wide":
      _id_5251A242A4D3B765["scene"] = level._id_B4D7482DCAFB066A;
      _id_5251A242A4D3B765["camera"] = level._id_B4D7482DCAFB066A.basecam;
      break;
    case "social_showcase":
      _id_5251A242A4D3B765["scene"] = level._id_3BFBE3641DFECFF0;
      _id_5251A242A4D3B765["camera"] = level._id_3BFBE3641DFECFF0.basecam;
      break;
    case "showcase_operator":
      _id_5251A242A4D3B765["scene"] = level._id_C0C7E6BE70482B73;
      _id_5251A242A4D3B765["camera"] = level._id_C0C7E6BE70482B73.basecam;
      break;
    case "showcase_weapon":
      _id_5251A242A4D3B765["scene"] = level._id_008302CD976FA0A3;
      _id_5251A242A4D3B765["camera"] = level._id_008302CD976FA0A3.basecam;
      break;
    case "aar_performance":
      _id_5251A242A4D3B765["scene"] = level._id_32D5BC10C9517A5C;
      _id_5251A242A4D3B765["camera"] = level._id_32D5BC10C9517A5C.basecam;
      break;
    case "character_tango":
      _id_5251A242A4D3B765["scene"] = level.camera_character_tango;
      _id_5251A242A4D3B765["camera"] = level.camera_character_tango.basecam;
      _id_47F8406A4C96AF32("Operator");
      break;
    case "battle_pass_character":
      _id_5251A242A4D3B765["scene"] = level._id_5215FA2603C0CD47;
      _id_5251A242A4D3B765["camera"] = level._id_5215FA2603C0CD47.basecam;
      break;
    case "battle_pass_character_detail":
      _id_5251A242A4D3B765["scene"] = level._id_6C5E13E5CADF25C9;
      _id_5251A242A4D3B765["camera"] = level._id_6C5E13E5CADF25C9.basecam;
      break;
    case "battle_pass_weapon":
      _id_5251A242A4D3B765["scene"] = level._id_EAD7DE7F41B832BC;
      _id_5251A242A4D3B765["camera"] = level._id_EAD7DE7F41B832BC.basecam;
      break;
    case "battle_pass_vehicle":
      _id_5251A242A4D3B765["scene"] = level._id_5DC4697427310378;
      _id_5251A242A4D3B765["camera"] = level._id_5DC4697427310378.basecam;
      break;
    case "battle_pass_items":
      _id_5251A242A4D3B765["scene"] = level._id_E671031110AF7F94;
      _id_5251A242A4D3B765["camera"] = level._id_E671031110AF7F94.basecam;
      break;
    case "bundle_preview":
      _id_5251A242A4D3B765["scene"] = level._id_AF794E04046D3D0C;
      _id_5251A242A4D3B765["camera"] = level._id_AF794E04046D3D0C.basecam;
      break;
    case "bundle_preview_large":
      _id_5251A242A4D3B765["scene"] = level._id_ED5ABB1B576FE118;
      _id_5251A242A4D3B765["camera"] = level._id_ED5ABB1B576FE118.basecam;
      break;
    case "bundle_preview_small":
      _id_5251A242A4D3B765["scene"] = level._id_BD4429CF96EDC040;
      _id_5251A242A4D3B765["camera"] = level._id_BD4429CF96EDC040.basecam;
      break;
    case "bundle_preview_riot":
      _id_5251A242A4D3B765["scene"] = level._id_215ED1C3599CD313;
      _id_5251A242A4D3B765["camera"] = level._id_215ED1C3599CD313.basecam;
      break;
    case "firingrange":
      _id_5251A242A4D3B765["scene"] = level._id_AEB531C63A3266D6;
      _id_5251A242A4D3B765["camera"] = level._id_AEB531C63A3266D6.basecam;
      break;
    case "character_faction_select_l":
      _id_5251A242A4D3B765["scene"] = level.camera_character_faction_select_l;
      _id_5251A242A4D3B765["camera"] = level.camera_character_faction_select_l.basecam;
      _id_47F8406A4C96AF32("Operator");
      break;
    case "character_faction_select_l_clone":
      _id_5251A242A4D3B765["scene"] = level.camera_character_faction_select_l;
      _id_5251A242A4D3B765["camera"] = level.camera_character_faction_select_l.basecam;
      _id_47F8406A4C96AF32("Operator");
      break;
    case "character_faction_select_l_detail":
      _id_5251A242A4D3B765["scene"] = level.camera_character_faction_select_l_detail;
      _id_5251A242A4D3B765["camera"] = level.camera_character_faction_select_l_detail.basecam;
      _id_47F8406A4C96AF32("Operator");
      break;
    case "character_preview_select":
      _id_5251A242A4D3B765["scene"] = level.camera_character_preview_select;
      _id_5251A242A4D3B765["camera"] = level.camera_character_preview_select.basecam;
      _id_47F8406A4C96AF32("Operator");
      break;
    case "character_preview_select_detail":
      _id_5251A242A4D3B765["scene"] = level.camera_character_preview_select_detail;
      _id_5251A242A4D3B765["camera"] = level.camera_character_preview_select_detail.basecam;
      _id_47F8406A4C96AF32("Operator");
      break;
    case "character_faction_select_r":
      _id_5251A242A4D3B765["scene"] = level.camera_character_faction_select_r;
      _id_5251A242A4D3B765["camera"] = level.camera_character_faction_select_r.basecam;
      _id_47F8406A4C96AF32("Operator");
      break;
    case "character_faction_select_r_detail":
      _id_5251A242A4D3B765["scene"] = level.camera_character_faction_select_r_detail;
      _id_5251A242A4D3B765["camera"] = level.camera_character_faction_select_r_detail.basecam;
      _id_47F8406A4C96AF32("Operator");
      break;
    case "character_tournaments":
      _id_5251A242A4D3B765["scene"] = level.camera_character_tournaments;
      _id_5251A242A4D3B765["camera"] = level.camera_character_tournaments.basecam;
      break;
    case "loadout_showcase_overview":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_overview;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_overview.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "weapon_preview":
      _id_5251A242A4D3B765["scene"] = level._id_7CF9581B3A0C8511;
      _id_5251A242A4D3B765["camera"] = level._id_7CF9581B3A0C8511.basecam;
      raritycamera("medium");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "weapon_preview_large":
      _id_5251A242A4D3B765["scene"] = level._id_823394CEAAC62E95;
      _id_5251A242A4D3B765["camera"] = level._id_823394CEAAC62E95.basecam;
      raritycamera("large");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "weapon_preview_small":
      _id_5251A242A4D3B765["scene"] = level._id_A31A266A6008F399;
      _id_5251A242A4D3B765["camera"] = level._id_A31A266A6008F399.basecam;
      raritycamera("small");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "weapon_preview_riot":
      _id_5251A242A4D3B765["scene"] = level._id_A5A822FFA6E52B60;
      _id_5251A242A4D3B765["camera"] = level._id_A5A822FFA6E52B60.basecam;

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      break;
    case "weapon_progression":
      _id_5251A242A4D3B765["scene"] = level._id_C62DAD9DD0CAC55E;
      _id_5251A242A4D3B765["camera"] = level._id_C62DAD9DD0CAC55E.basecam;
      raritycamera("medium");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "weapon_progression_large":
      _id_5251A242A4D3B765["scene"] = level._id_B8BF2AAA73B51A2E;
      _id_5251A242A4D3B765["camera"] = level._id_B8BF2AAA73B51A2E.basecam;
      raritycamera("large");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "weapon_progression_small":
      _id_5251A242A4D3B765["scene"] = level._id_1FC849FFB55CDA12;
      _id_5251A242A4D3B765["camera"] = level._id_1FC849FFB55CDA12.basecam;
      raritycamera("small");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "weapon_customize":
      _id_5251A242A4D3B765["scene"] = level._id_F6700E1227881EE6;
      _id_5251A242A4D3B765["camera"] = level._id_F6700E1227881EE6.basecam;
      raritycamera("medium");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "weapon_customize_large":
      _id_5251A242A4D3B765["scene"] = level._id_6C202B6758CE5A16;
      _id_5251A242A4D3B765["camera"] = level._id_6C202B6758CE5A16.basecam;
      raritycamera("large");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "weapon_customize_small":
      _id_5251A242A4D3B765["scene"] = level._id_593D9A9218690ADA;
      _id_5251A242A4D3B765["camera"] = level._id_593D9A9218690ADA.basecam;
      raritycamera("small");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "weapon_customize_riot":
      _id_5251A242A4D3B765["scene"] = level._id_BE74DC099F9C404D;
      _id_5251A242A4D3B765["camera"] = level._id_BE74DC099F9C404D.basecam;
      raritycamera("large");

      if(_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_gunsmith", 0);

      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "loadout_showcase_preview":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview.basecam;
      raritycamera("medium");
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "loadout_showcase_preview_large":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large.basecam;
      raritycamera("large");
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "loadout_showcase_preview_small":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small.basecam;
      raritycamera("small");
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      _id_47F8406A4C96AF32("Gunbench");
      break;
    case "loadout_showcase_preview_riot":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_riot;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_riot.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_watch":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_watch;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_watch.basecam;
      raritycamera("watch");
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_barrel":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_barrel;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_barrel.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_barrel_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_barrel_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_barrel_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_barrel_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_barrel_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_barrel_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_charm":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_charm;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_charm.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_charm_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_charm_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_charm_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_charm_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_charm_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_charm_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_charm_alt3":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_charm_alt3;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_charm_alt3.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_charm_alt4":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_charm_alt4;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_charm_alt4.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_laser":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_laser;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_laser.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_laser_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_laser_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_laser_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_laser_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_laser_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_laser_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_magazine":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_magazine;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_magazine.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_magazine_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_magazine_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_magazine_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_magazine_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_magazine_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_magazine_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_muzzle":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_muzzle;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_muzzle.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_muzzle_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_muzzle_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_muzzle_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_optic":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_optic;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_optic.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_optic_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_optic_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_optic_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_reargrip":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_reargrip;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_reargrip.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_reargrip_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_reargrip_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_reargrip_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_reargrip_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_reargrip_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_reargrip_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_sticker":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_sticker;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_sticker.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_sticker_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_sticker_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_sticker_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_sticker_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_sticker_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_sticker_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_sticker_alt3":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_sticker_alt3;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_sticker_alt3.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_sticker_alt4":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_sticker_alt4;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_sticker_alt4.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_stock":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_stock;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_stock.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_stock_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_stock_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_stock_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_stock_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_stock_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_stock_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_underbarrel":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_underbarrel;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_underbarrel.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_barrel":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_barrel;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_barrel.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_barrel_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_barrel_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_barrel_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_charm":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_charm;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_charm.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_charm_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_charm_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_charm_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_charm_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_charm_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_charm_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_laser":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_laser;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_laser.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_magazine":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_magazine;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_magazine.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_magazine_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_magazine_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_magazine_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_magazine_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_magazine_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_magazine_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_muzzle":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_muzzle;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_muzzle.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_muzzle_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_muzzle_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_optic":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_optic;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_optic.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_reargrip":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_reargrip;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_reargrip.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_reargrip_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_reargrip_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_sticker":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_sticker;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_sticker.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_sticker_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_sticker_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_sticker_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_sticker_alt2":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_sticker_alt2;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_sticker_alt2.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_sticker_alt3":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_sticker_alt3;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_sticker_alt3.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_stock":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_stock;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_stock.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_stock_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_stock_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_stock_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_underbarrel":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_underbarrel;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_underbarrel.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_large_underbarrel_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_large_underbarrel_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_barrel":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_barrel;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_barrel.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_charm":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_charm;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_charm.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_laser":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_laser;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_laser.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_magazine":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_magazine;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_magazine.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_magazine_alt1":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_magazine_alt1;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_magazine_alt1.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_muzzle":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_muzzle;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_muzzle.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_optic":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_optic;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_optic.basecam;

      if(!_id_9FE1BC92EC9FB00F)
        level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);

      break;
    case "loadout_showcase_preview_small_reargrip":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_reargrip;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_reargrip.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_sticker":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_sticker;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_sticker.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_stock":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_stock;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_stock.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase_preview_small_trigger":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_preview_small_trigger;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_preview_small_trigger.basecam;
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_9AA5B3137BD141B4 + "gunsmith", 0);
      break;
    case "loadout_showcase":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "loadout_showcase_armory":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_armory;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_armory.basecam;
      break;
    case "loadout_showcase_p":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_p;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_p.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "loadout_showcase_p_large":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_p_large;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_p_large.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "loadout_showcase_s":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_s;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_s.basecam;
      _id_47F8406A4C96AF32("Loadout");
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_8A919D89CD6129AE + "loadouts_2nd", 0);
      break;
    case "loadout_showcase_o":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_o;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_o.basecam;
      _id_47F8406A4C96AF32("Loadout");
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_8A919D89CD6129AE + "loadouts_2nd", 0);
      break;
    case "loadout_showcase_o_large":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_o_large;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_o_large.basecam;
      _id_47F8406A4C96AF32("Loadout");
      level.playerviewowner visionsetnakedforplayer("mp_frontend_" + level._id_8A919D89CD6129AE + "loadouts_2nd", 0);
      break;
    case "loadout_showcase_l":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_l;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_l.basecam;

      if(_id_9FE1BC92EC9FB00F) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_lethal", 0);
        _id_47F8406A4C96AF32("Loadout_Equipment");
      } else
        _id_47F8406A4C96AF32("Loadout");

      break;
    case "loadout_showcase_t":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_t;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_t.basecam;

      if(_id_9FE1BC92EC9FB00F) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_mgl_tactical", 0);
        _id_47F8406A4C96AF32("Loadout_Equipment");
      } else
        _id_47F8406A4C96AF32("Loadout");

      break;
    case "loadout_showcase_field_upgrade":
      _id_5251A242A4D3B765["scene"] = level._id_0D693F81E12DA320;
      _id_5251A242A4D3B765["camera"] = level._id_0D693F81E12DA320.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "loadout_showcase_perks":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_perks;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_perks.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "loadout_showcase_x":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_x;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_x.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "loadout_showcase_y":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_y;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_y.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "loadout_showcase_z":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_z;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_z.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "loadout_showcase_specialist":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_specialist;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_specialist.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "loadout_showcase_watch":
      _id_5251A242A4D3B765["scene"] = level.camera_loadout_showcase_watch;
      _id_5251A242A4D3B765["camera"] = level.camera_loadout_showcase_watch.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "weapon_showcase":
      _id_5251A242A4D3B765["scene"] = level.camera_ui_bg_01;
      _id_5251A242A4D3B765["camera"] = level.camera_ui_bg_01.basecam;
      _id_47F8406A4C96AF32("Loadout");
      break;
    case "barracks":
      _id_1C5105E69B7863CA = scripts\engine\utility::ter_op(_id_ACF68BB64D0400F8, level.camera_ui_bg_01, level.active_scene_data);
      _id_5251A242A4D3B765["scene"] = level.camera_ui_bg_01;
      _id_5251A242A4D3B765["camera"] = level.camera_ui_bg_01.basecam;
      break;
    case "player_character_showcase":
      _id_5251A242A4D3B765["scene"] = level.camera_ui_bg_01;
      _id_5251A242A4D3B765["camera"] = level.camera_ui_bg_01.basecam;
      break;
    case "mtx_preview":
      if(_id_9FE1BC92EC9FB00F) {
        _id_5251A242A4D3B765["scene"] = level._id_26D2D5FA7DFEE609;
        _id_5251A242A4D3B765["camera"] = level._id_26D2D5FA7DFEE609.basecam;
      }

      break;
    default:
      break;
  }

  return _id_5251A242A4D3B765;
}

create_camera_position_list() {
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;
  level.camera_loadout_showcase = spawnStruct();
  level.camera_loadout_showcase.basecam = getEnt("camera_mp_gunsmith", "targetname");
  level.camera_loadout_showcase.basecam.depthoffieldvalues = [6, 50];
  level.camera_loadout_showcase.myfov = 36;
  level.camera_loadout_showcase.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase.spotlimit = 6;
  level.camera_loadout_showcase_overview = spawnStruct();
  level.camera_loadout_showcase_overview.basecam = getEnt("camera_mp_gunsmith_overview", "targetname");
  level.camera_loadout_showcase_overview.basecam.depthoffieldvalues = [3, 85];
  level.camera_loadout_showcase_overview.myfov = 28;
  level.camera_loadout_showcase_overview.update_char_loc = ::_id_064A0F78F8CDFF3F;
  level.camera_loadout_showcase_overview.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_overview.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_overview.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_overview.spotlimit = 6;
  level.camera_loadout_showcase_preview = spawnStruct();
  level.camera_loadout_showcase_preview.basecam = getEnt("camera_mp_gunsmith_preview", "targetname");
  level.camera_loadout_showcase_preview.basecam.depthoffieldvalues = [22, 56];
  level.camera_loadout_showcase_preview.myfov = 36;
  level.camera_loadout_showcase_preview.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview.spotlimit = 6;
  level.camera_loadout_showcase_preview_large = spawnStruct();
  level.camera_loadout_showcase_preview_large.basecam = getEnt("camera_mp_gunsmith_preview_large", "targetname");
  level.camera_loadout_showcase_preview_large.basecam.depthoffieldvalues = [22, 64];
  level.camera_loadout_showcase_preview_large.myfov = 36;
  level.camera_loadout_showcase_preview_large.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large.spotlimit = 6;
  level.camera_loadout_showcase_preview_small = spawnStruct();
  level.camera_loadout_showcase_preview_small.basecam = getEnt("camera_mp_gunsmith_preview_secondary", "targetname");
  level.camera_loadout_showcase_preview_small.basecam.depthoffieldvalues = [22, 36];
  level.camera_loadout_showcase_preview_small.myfov = 36;
  level.camera_loadout_showcase_preview_small.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small.spotlimit = 6;
  level.camera_loadout_showcase_preview_watch = spawnStruct();
  level.camera_loadout_showcase_preview_watch.basecam = getEnt("camera_mp_gunsmith_preview_watch", "targetname");
  level.camera_loadout_showcase_preview_watch.basecam.depthoffieldvalues = [20, 16];
  level.camera_loadout_showcase_preview_watch.myfov = 36;
  level.camera_loadout_showcase_preview_watch.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_watch.spotlimit = 6;
  level.camera_loadout_showcase_armory = spawnStruct();
  level.camera_loadout_showcase_armory.basecam = getEnt("camera_mp_gunsmith_armory", "targetname");
  level.camera_loadout_showcase_armory.basecam.depthoffieldvalues = [7, 67];
  level.camera_loadout_showcase_armory.myfov = 44;
  level.camera_loadout_showcase_armory.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_armory.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_armory.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_armory.spotlimit = 6;
  level.camera_loadout_showcase_p = spawnStruct();
  level.camera_loadout_showcase_p.basecam = getEnt("camera_mp_gunsmith_alt_p_large", "targetname");
  level.camera_loadout_showcase_p.basecam.depthoffieldvalues = [7, 38];
  level.camera_loadout_showcase_p.myfov = 55;
  level.camera_loadout_showcase_p.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_p.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_p.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_p.spotlimit = 6;
  level.camera_loadout_showcase_p_large = spawnStruct();
  level.camera_loadout_showcase_p_large.basecam = getEnt("camera_mp_gunsmith_alt_p_large", "targetname");
  level.camera_loadout_showcase_p_large.basecam.depthoffieldvalues = [7, 64];
  level.camera_loadout_showcase_p_large.myfov = 55;
  level.camera_loadout_showcase_p_large.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_p_large.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_p_large.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_p_large.spotlimit = 6;
  level.camera_loadout_showcase_s = spawnStruct();
  level.camera_loadout_showcase_s.basecam = getEnt("camera_mp_gunsmith_alt_s", "targetname");
  level.camera_loadout_showcase_s.basecam.depthoffieldvalues = [5, 23];
  level.camera_loadout_showcase_s.myfov = 55;
  level.camera_loadout_showcase_s.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_s.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_s.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_s.spotlimit = 6;
  level.camera_loadout_showcase_o = spawnStruct();
  level.camera_loadout_showcase_o.basecam = getEnt("camera_mp_gunsmith_alt_o_large", "targetname");
  level.camera_loadout_showcase_o.basecam.depthoffieldvalues = [14, 38];
  level.camera_loadout_showcase_o.myfov = 55;
  level.camera_loadout_showcase_o.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_o.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_o.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_o.spotlimit = 6;
  level.camera_loadout_showcase_o_large = spawnStruct();
  level.camera_loadout_showcase_o_large.basecam = getEnt("camera_mp_gunsmith_alt_o_large", "targetname");
  level.camera_loadout_showcase_o_large.basecam.depthoffieldvalues = [14, 65];
  level.camera_loadout_showcase_o_large.myfov = 55;
  level.camera_loadout_showcase_o_large.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_o_large.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_o_large.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_o_large.spotlimit = 6;
  level.camera_loadout_showcase_l = spawnStruct();
  level.camera_loadout_showcase_l.basecam = getEnt("camera_mp_gunsmith_alt_l", "targetname");
  level.camera_loadout_showcase_l.basecam.depthoffieldvalues = [6, 36];
  level.camera_loadout_showcase_l.myfov = 55;
  level.camera_loadout_showcase_l.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_l.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_l.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_l.spotlimit = 6;
  level.camera_loadout_showcase_t = spawnStruct();
  level.camera_loadout_showcase_t.basecam = getEnt("camera_mp_gunsmith_alt_t", "targetname");
  level.camera_loadout_showcase_t.basecam.depthoffieldvalues = [6, 33];
  level.camera_loadout_showcase_t.myfov = 55;
  level.camera_loadout_showcase_t.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_t.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_t.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_t.spotlimit = 6;
  level._id_0D693F81E12DA320 = spawnStruct();
  level._id_0D693F81E12DA320.basecam = getEnt("camera_mp_gunsmith_field_upgrade", "targetname");
  level._id_0D693F81E12DA320.basecam.depthoffieldvalues = [6, 35];
  level._id_0D693F81E12DA320.myfov = 55;
  level._id_0D693F81E12DA320.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level._id_0D693F81E12DA320.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level._id_0D693F81E12DA320.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level._id_0D693F81E12DA320.spotlimit = 6;
  level.camera_loadout_showcase_perks = spawnStruct();
  level.camera_loadout_showcase_perks.basecam = getEnt("camera_mp_gunsmith_alt_perks", "targetname");
  level.camera_loadout_showcase_perks.basecam.depthoffieldvalues = [6, 45];
  level.camera_loadout_showcase_perks.myfov = 55;
  level.camera_loadout_showcase_perks.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_perks.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_perks.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_perks.spotlimit = 6;
  level.camera_loadout_showcase_x = spawnStruct();
  level.camera_loadout_showcase_x.basecam = getEnt("camera_mp_gunsmith_alt_x", "targetname");
  level.camera_loadout_showcase_x.basecam.depthoffieldvalues = [5, 20];
  level.camera_loadout_showcase_x.myfov = 55;
  level.camera_loadout_showcase_x.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_x.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_x.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_x.spotlimit = 6;
  level.camera_loadout_showcase_y = spawnStruct();
  level.camera_loadout_showcase_y.basecam = getEnt("camera_mp_gunsmith_alt_y", "targetname");
  level.camera_loadout_showcase_y.basecam.depthoffieldvalues = [4, 21];
  level.camera_loadout_showcase_y.myfov = 55;
  level.camera_loadout_showcase_y.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_y.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_y.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_y.spotlimit = 6;
  level.camera_loadout_showcase_z = spawnStruct();
  level.camera_loadout_showcase_z.basecam = getEnt("camera_mp_gunsmith_alt_z", "targetname");
  level.camera_loadout_showcase_z.basecam.depthoffieldvalues = [6, 20];
  level.camera_loadout_showcase_z.myfov = 55;
  level.camera_loadout_showcase_z.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_z.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_z.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_z.spotlimit = 6;
  level.camera_loadout_showcase_specialist = spawnStruct();
  level.camera_loadout_showcase_specialist.basecam = getEnt("camera_mp_gunsmith_alt_specialist", "targetname");
  level.camera_loadout_showcase_specialist.basecam.depthoffieldvalues = [22, 16];
  level.camera_loadout_showcase_specialist.myfov = 55;
  level.camera_loadout_showcase_specialist.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_specialist.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_specialist.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_specialist.spotlimit = 6;
  level.camera_loadout_showcase_watch = spawnStruct();
  level.camera_loadout_showcase_watch.basecam = getEnt("camera_mp_gunsmith_alt_watch", "targetname");
  level.camera_loadout_showcase_watch.basecam.depthoffieldvalues = [22, 8];
  level.camera_loadout_showcase_watch.myfov = 55;
  level.camera_loadout_showcase_watch.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_watch.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_watch.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_watch.spotlimit = 6;
  level.camera_loadout_showcase_preview_riot = spawnStruct();
  level.camera_loadout_showcase_preview_riot.basecam = getEnt("camera_mp_gunsmith_preview_riot", "targetname");
  level.camera_loadout_showcase_preview_riot.basecam.depthoffieldvalues = [16, 152];
  level.camera_loadout_showcase_preview_riot.myfov = 36;
  level.camera_loadout_showcase_preview_riot.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_riot.spotlimit = 6;
  level._id_7CF9581B3A0C8511 = spawnStruct();
  level._id_7CF9581B3A0C8511.basecam = getEnt("camera_mp_weapon_preview", "targetname");
  level._id_7CF9581B3A0C8511.basecam.depthoffieldvalues = [22, 56];
  level._id_7CF9581B3A0C8511.myfov = 36;
  level._id_7CF9581B3A0C8511.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level._id_7CF9581B3A0C8511.spotlimit = 6;
  level._id_823394CEAAC62E95 = spawnStruct();
  level._id_823394CEAAC62E95.basecam = getEnt("camera_mp_weapon_preview_large", "targetname");
  level._id_823394CEAAC62E95.basecam.depthoffieldvalues = [22, 64];
  level._id_823394CEAAC62E95.myfov = 36;
  level._id_823394CEAAC62E95.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level._id_823394CEAAC62E95.spotlimit = 6;
  level._id_A31A266A6008F399 = spawnStruct();
  level._id_A31A266A6008F399.basecam = getEnt("camera_mp_weapon_preview_secondary", "targetname");
  level._id_A31A266A6008F399.basecam.depthoffieldvalues = [22, 36];
  level._id_A31A266A6008F399.myfov = 36;
  level._id_A31A266A6008F399.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level._id_A31A266A6008F399.spotlimit = 6;
  level._id_A5A822FFA6E52B60 = spawnStruct();
  level._id_A5A822FFA6E52B60.basecam = getEnt("camera_mp_weapon_preview_riot", "targetname");
  level._id_A5A822FFA6E52B60.basecam.depthoffieldvalues = [16, 152];
  level._id_A5A822FFA6E52B60.myfov = 36;
  level._id_A5A822FFA6E52B60.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level._id_A5A822FFA6E52B60.spotlimit = 6;

  if(!_id_9FE1BC92EC9FB00F) {
    level._id_AF794E04046D3D0C = spawnStruct();
    level._id_AF794E04046D3D0C.basecam = getEnt("camera_mp_bundle_preview", "targetname");
    level._id_AF794E04046D3D0C.basecam.depthoffieldvalues = [22, 56];
    level._id_AF794E04046D3D0C.myfov = 36;
    level._id_AF794E04046D3D0C.weapon_locs[2] = getEnt("weapon_loc_bundle_preview", "targetname");
    level._id_AF794E04046D3D0C.spotlimit = 6;
    level._id_ED5ABB1B576FE118 = spawnStruct();
    level._id_ED5ABB1B576FE118.basecam = getEnt("camera_mp_bundle_preview_large", "targetname");
    level._id_ED5ABB1B576FE118.basecam.depthoffieldvalues = [22, 64];
    level._id_ED5ABB1B576FE118.myfov = 36;
    level._id_ED5ABB1B576FE118.weapon_locs[2] = getEnt("weapon_loc_bundle_preview", "targetname");
    level._id_ED5ABB1B576FE118.spotlimit = 6;
    level._id_BD4429CF96EDC040 = spawnStruct();
    level._id_BD4429CF96EDC040.basecam = getEnt("camera_mp_bundle_preview_secondary", "targetname");
    level._id_BD4429CF96EDC040.basecam.depthoffieldvalues = [22, 26];
    level._id_BD4429CF96EDC040.myfov = 36;
    level._id_BD4429CF96EDC040.weapon_locs[2] = getEnt("weapon_loc_bundle_preview", "targetname");
    level._id_BD4429CF96EDC040.spotlimit = 6;
    level._id_215ED1C3599CD313 = spawnStruct();
    level._id_215ED1C3599CD313.basecam = getEnt("camera_mp_bundle_preview_riot", "targetname");
    level._id_215ED1C3599CD313.basecam.depthoffieldvalues = [22, 152];
    level._id_215ED1C3599CD313.myfov = 36;
    level._id_215ED1C3599CD313.weapon_locs[2] = getEnt("weapon_loc_bundle_preview", "targetname");
    level._id_215ED1C3599CD313.spotlimit = 6;
  } else {
    level._id_C62DAD9DD0CAC55E = spawnStruct();
    level._id_C62DAD9DD0CAC55E.basecam = getEnt("camera_mp_weapon_preview", "targetname");
    level._id_C62DAD9DD0CAC55E.basecam.depthoffieldvalues = [22, 56];
    level._id_C62DAD9DD0CAC55E.myfov = 36;
    level._id_C62DAD9DD0CAC55E.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
    level._id_C62DAD9DD0CAC55E.spotlimit = 6;
    level._id_B8BF2AAA73B51A2E = spawnStruct();
    level._id_B8BF2AAA73B51A2E.basecam = getEnt("camera_mp_weapon_preview_large", "targetname");
    level._id_B8BF2AAA73B51A2E.basecam.depthoffieldvalues = [22, 64];
    level._id_B8BF2AAA73B51A2E.myfov = 36;
    level._id_B8BF2AAA73B51A2E.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
    level._id_B8BF2AAA73B51A2E.spotlimit = 6;
    level._id_1FC849FFB55CDA12 = spawnStruct();
    level._id_1FC849FFB55CDA12.basecam = getEnt("camera_mp_weapon_preview_secondary", "targetname");
    level._id_1FC849FFB55CDA12.basecam.depthoffieldvalues = [22, 36];
    level._id_1FC849FFB55CDA12.myfov = 36;
    level._id_1FC849FFB55CDA12.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
    level._id_1FC849FFB55CDA12.spotlimit = 6;
    level._id_F6700E1227881EE6 = spawnStruct();
    level._id_F6700E1227881EE6.basecam = getEnt("camera_mp_weapon_preview", "targetname");
    level._id_F6700E1227881EE6.basecam.depthoffieldvalues = [22, 56];
    level._id_F6700E1227881EE6.myfov = 36;
    level._id_F6700E1227881EE6.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
    level._id_F6700E1227881EE6.spotlimit = 6;
    level._id_6C202B6758CE5A16 = spawnStruct();
    level._id_6C202B6758CE5A16.basecam = getEnt("camera_mp_weapon_preview_large", "targetname");
    level._id_6C202B6758CE5A16.basecam.depthoffieldvalues = [22, 64];
    level._id_6C202B6758CE5A16.myfov = 36;
    level._id_6C202B6758CE5A16.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
    level._id_6C202B6758CE5A16.spotlimit = 6;
    level._id_593D9A9218690ADA = spawnStruct();
    level._id_593D9A9218690ADA.basecam = getEnt("camera_mp_weapon_preview_secondary", "targetname");
    level._id_593D9A9218690ADA.basecam.depthoffieldvalues = [22, 36];
    level._id_593D9A9218690ADA.myfov = 36;
    level._id_593D9A9218690ADA.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
    level._id_593D9A9218690ADA.spotlimit = 6;
    level._id_BE74DC099F9C404D = spawnStruct();
    level._id_BE74DC099F9C404D.basecam = getEnt("camera_mp_weapon_preview_riot", "targetname");
    level._id_BE74DC099F9C404D.basecam.depthoffieldvalues = [22, 64];
    level._id_BE74DC099F9C404D.myfov = 36;
    level._id_BE74DC099F9C404D.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
    level._id_BE74DC099F9C404D.spotlimit = 6;
  }

  level.camera_loadout_showcase_preview_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_barrel.basecam = getEnt("camera_mp_gunsmith_preview_barrel", "targetname");
  level.camera_loadout_showcase_preview_barrel.basecam.depthoffieldvalues = [8, 34];
  level.camera_loadout_showcase_preview_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_barrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_barrel.spotlimit = 6;
  level.camera_loadout_showcase_preview_barrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt1.basecam = getEnt("camera_mp_gunsmith_preview_barrel_alt1", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt1.basecam.depthoffieldvalues = [8, 48];
  level.camera_loadout_showcase_preview_barrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_barrel_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_barrel_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt2.basecam = getEnt("camera_mp_gunsmith_preview_barrel_alt2", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt2.basecam.depthoffieldvalues = [8, 54];
  level.camera_loadout_showcase_preview_barrel_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_barrel_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_charm = spawnStruct();
  level.camera_loadout_showcase_preview_charm.basecam = getEnt("camera_mp_gunsmith_preview_charm", "targetname");
  level.camera_loadout_showcase_preview_charm.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm.myfov = 36;
  level.camera_loadout_showcase_preview_charm.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_charm.spotlimit = 6;
  level.camera_loadout_showcase_preview_charm_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt1.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt1", "targetname");
  level.camera_loadout_showcase_preview_charm_alt1.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt1.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_charm_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_charm_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt2.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt2", "targetname");
  level.camera_loadout_showcase_preview_charm_alt2.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt2.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_charm_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_charm_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt3.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt3", "targetname");
  level.camera_loadout_showcase_preview_charm_alt3.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt3.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt3.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_charm_alt3.spotlimit = 6;
  level.camera_loadout_showcase_preview_charm_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt4.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt4", "targetname");
  level.camera_loadout_showcase_preview_charm_alt4.basecam.depthoffieldvalues = [21, 18];
  level.camera_loadout_showcase_preview_charm_alt4.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt4.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_charm_alt4.spotlimit = 6;
  level.camera_loadout_showcase_preview_laser = spawnStruct();
  level.camera_loadout_showcase_preview_laser.basecam = getEnt("camera_mp_gunsmith_preview_laser", "targetname");
  level.camera_loadout_showcase_preview_laser.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser.myfov = 36;
  level.camera_loadout_showcase_preview_laser.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_laser.spotlimit = 6;
  level.camera_loadout_showcase_preview_laser_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_laser_alt1.basecam = getEnt("camera_mp_gunsmith_preview_laser_alt1", "targetname");
  level.camera_loadout_showcase_preview_laser_alt1.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_laser_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_laser_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_laser_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_laser_alt2.basecam = getEnt("camera_mp_gunsmith_preview_laser_alt2", "targetname");
  level.camera_loadout_showcase_preview_laser_alt2.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_laser_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_laser_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_magazine.basecam = getEnt("camera_mp_gunsmith_preview_magazine", "targetname");
  level.camera_loadout_showcase_preview_magazine.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_magazine.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine.spotlimit = 6;
  level.camera_loadout_showcase_preview_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt1.basecam = getEnt("camera_mp_gunsmith_preview_magazine_alt1", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt1.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_magazine_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_magazine_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt2.basecam = getEnt("camera_mp_gunsmith_preview_magazine_alt2", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt2.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_magazine_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle.basecam = getEnt("camera_mp_gunsmith_preview_muzzle", "targetname");
  level.camera_loadout_showcase_preview_muzzle.basecam.depthoffieldvalues = [12, 30];
  level.camera_loadout_showcase_preview_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_muzzle.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_muzzle.spotlimit = 6;
  level.camera_loadout_showcase_preview_muzzle_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle_alt1.basecam = getEnt("camera_mp_gunsmith_preview_muzzle_alt1", "targetname");
  level.camera_loadout_showcase_preview_muzzle_alt1.basecam.depthoffieldvalues = [18, 32];
  level.camera_loadout_showcase_preview_muzzle_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_muzzle_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_muzzle_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_optic = spawnStruct();
  level.camera_loadout_showcase_preview_optic.basecam = getEnt("camera_mp_gunsmith_preview_optic", "targetname");
  level.camera_loadout_showcase_preview_optic.basecam.depthoffieldvalues = [21.5, 17];
  level.camera_loadout_showcase_preview_optic.myfov = 36;
  level.camera_loadout_showcase_preview_optic.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_optic.spotlimit = 6;
  level.camera_loadout_showcase_preview_optic_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_optic_alt1.basecam = getEnt("camera_mp_gunsmith_preview_optic_alt1", "targetname");
  level.camera_loadout_showcase_preview_optic_alt1.basecam.depthoffieldvalues = [21.5, 17];
  level.camera_loadout_showcase_preview_optic_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_optic_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_optic_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip.basecam = getEnt("camera_mp_gunsmith_preview_reargrip", "targetname");
  level.camera_loadout_showcase_preview_reargrip.basecam.depthoffieldvalues = [8, 20];
  level.camera_loadout_showcase_preview_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_reargrip.spotlimit = 6;
  level.camera_loadout_showcase_preview_reargrip_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip_alt1.basecam = getEnt("camera_mp_gunsmith_preview_reargrip_alt1", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt1.basecam.depthoffieldvalues = [8, 20];
  level.camera_loadout_showcase_preview_reargrip_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_reargrip_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip_alt2.basecam = getEnt("camera_mp_gunsmith_preview_reargrip_alt2", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt2.basecam.depthoffieldvalues = [12, 22];
  level.camera_loadout_showcase_preview_reargrip_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_sticker = spawnStruct();
  level.camera_loadout_showcase_preview_sticker.basecam = getEnt("camera_mp_gunsmith_preview_sticker", "targetname");
  level.camera_loadout_showcase_preview_sticker.basecam.depthoffieldvalues = [20, 32];
  level.camera_loadout_showcase_preview_sticker.myfov = 36;
  level.camera_loadout_showcase_preview_sticker.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_sticker.spotlimit = 6;
  level.camera_loadout_showcase_preview_sticker_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt1.basecam = getEnt("camera_mp_gunsmith_preview_sticker_alt1", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt1.basecam.depthoffieldvalues = [20, 32];
  level.camera_loadout_showcase_preview_sticker_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_sticker_alt1.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_sticker_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt2.basecam = getEnt("camera_mp_gunsmith_preview_sticker_alt2", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt2.basecam.depthoffieldvalues = [20, 34];
  level.camera_loadout_showcase_preview_sticker_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_sticker_alt2.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_sticker_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt3.basecam = getEnt("camera_mp_gunsmith_preview_sticker_alt3", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt3.basecam.depthoffieldvalues = [20, 34];
  level.camera_loadout_showcase_preview_sticker_alt3.myfov = 36;
  level.camera_loadout_showcase_preview_sticker_alt3.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt3.spotlimit = 6;
  level.camera_loadout_showcase_preview_sticker_alt4 = spawnStruct();
  level.camera_loadout_showcase_preview_sticker_alt4.basecam = getEnt("camera_mp_gunsmith_preview_sticker_alt4", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt4.basecam.depthoffieldvalues = [20, 34];
  level.camera_loadout_showcase_preview_sticker_alt4.myfov = 36;
  level.camera_loadout_showcase_preview_sticker_alt4.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_sticker_alt4.spotlimit = 6;
  level.camera_loadout_showcase_preview_stock = spawnStruct();
  level.camera_loadout_showcase_preview_stock.basecam = getEnt("camera_mp_gunsmith_preview_stock", "targetname");
  level.camera_loadout_showcase_preview_stock.basecam.depthoffieldvalues = [12, 40];
  level.camera_loadout_showcase_preview_stock.myfov = 36;
  level.camera_loadout_showcase_preview_stock.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_stock.spotlimit = 6;
  level.camera_loadout_showcase_preview_stock_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt1.basecam = getEnt("camera_mp_gunsmith_preview_stock_alt1", "targetname");
  level.camera_loadout_showcase_preview_stock_alt1.basecam.depthoffieldvalues = [12, 40];
  level.camera_loadout_showcase_preview_stock_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_stock_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_stock_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_stock_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt2.basecam = getEnt("camera_mp_gunsmith_preview_stock_alt2", "targetname");
  level.camera_loadout_showcase_preview_stock_alt2.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_stock_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_stock_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_stock_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_underbarrel = spawnStruct();
  level.camera_loadout_showcase_preview_underbarrel.basecam = getEnt("camera_mp_gunsmith_preview_underbarrel", "targetname");
  level.camera_loadout_showcase_preview_underbarrel.basecam.depthoffieldvalues = [10, 34];
  level.camera_loadout_showcase_preview_underbarrel.myfov = 36;
  level.camera_loadout_showcase_preview_underbarrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_underbarrel.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_small_barrel.basecam = getEnt("camera_mp_gunsmith_preview_small_barrel", "targetname");
  level.camera_loadout_showcase_preview_small_barrel.basecam.depthoffieldvalues = [12, 22.5];
  level.camera_loadout_showcase_preview_small_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_small_barrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_barrel.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_charm = spawnStruct();
  level.camera_loadout_showcase_preview_small_charm.basecam = getEnt("camera_mp_gunsmith_preview_small_charm", "targetname");
  level.camera_loadout_showcase_preview_small_charm.basecam.depthoffieldvalues = [21, 15];
  level.camera_loadout_showcase_preview_small_charm.myfov = 36;
  level.camera_loadout_showcase_preview_small_charm.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_small_charm.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_laser = spawnStruct();
  level.camera_loadout_showcase_preview_small_laser.basecam = getEnt("camera_mp_gunsmith_preview_small_laser", "targetname");
  level.camera_loadout_showcase_preview_small_laser.basecam.depthoffieldvalues = [12, 19];
  level.camera_loadout_showcase_preview_small_laser.myfov = 36;
  level.camera_loadout_showcase_preview_small_laser.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_laser.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine.basecam = getEnt("camera_mp_gunsmith_preview_small_magazine", "targetname");
  level.camera_loadout_showcase_preview_small_magazine.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_small_magazine.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_magazine.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine_alt1.basecam = getEnt("camera_mp_gunsmith_preview_small_magazine_alt1", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt1.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_small_magazine_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_small_muzzle.basecam = getEnt("camera_mp_gunsmith_preview_small_muzzle", "targetname");
  level.camera_loadout_showcase_preview_small_muzzle.basecam.depthoffieldvalues = [16, 25];
  level.camera_loadout_showcase_preview_small_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_small_muzzle.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_muzzle.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_optic = spawnStruct();
  level.camera_loadout_showcase_preview_small_optic.basecam = getEnt("camera_mp_gunsmith_preview_small_optic", "targetname");
  level.camera_loadout_showcase_preview_small_optic.basecam.depthoffieldvalues = [20, 15];
  level.camera_loadout_showcase_preview_small_optic.myfov = 36;
  level.camera_loadout_showcase_preview_small_optic.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_optic.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_small_reargrip.basecam = getEnt("camera_mp_gunsmith_preview_small_reargrip", "targetname");
  level.camera_loadout_showcase_preview_small_reargrip.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_small_reargrip.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_reargrip.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_sticker = spawnStruct();
  level.camera_loadout_showcase_preview_small_sticker.basecam = getEnt("camera_mp_gunsmith_preview_small_sticker", "targetname");
  level.camera_loadout_showcase_preview_small_sticker.basecam.depthoffieldvalues = [16, 22];
  level.camera_loadout_showcase_preview_small_sticker.myfov = 36;
  level.camera_loadout_showcase_preview_small_sticker.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_small_sticker.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_stock = spawnStruct();
  level.camera_loadout_showcase_preview_small_stock.basecam = getEnt("camera_mp_gunsmith_preview_small_stock", "targetname");
  level.camera_loadout_showcase_preview_small_stock.basecam.depthoffieldvalues = [16, 36];
  level.camera_loadout_showcase_preview_small_stock.myfov = 36;
  level.camera_loadout_showcase_preview_small_stock.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_stock.spotlimit = 6;
  level.camera_loadout_showcase_preview_small_trigger = spawnStruct();
  level.camera_loadout_showcase_preview_small_trigger.basecam = getEnt("camera_mp_gunsmith_preview_small_trigger", "targetname");
  level.camera_loadout_showcase_preview_small_trigger.basecam.depthoffieldvalues = [21, 12];
  level.camera_loadout_showcase_preview_small_trigger.myfov = 36;
  level.camera_loadout_showcase_preview_small_trigger.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_trigger.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_large_barrel.basecam = getEnt("camera_mp_gunsmith_preview_large_barrel", "targetname");
  level.camera_loadout_showcase_preview_large_barrel.basecam.depthoffieldvalues = [12, 46];
  level.camera_loadout_showcase_preview_large_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_large_barrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_barrel.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_charm = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm.basecam = getEnt("camera_mp_gunsmith_preview_large_charm", "targetname");
  level.camera_loadout_showcase_preview_large_charm.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_large_charm.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_charm_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_charm_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_charm_alt1.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm_alt1.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_large_charm_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_charm_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm_alt2.basecam = getEnt("camera_mp_gunsmith_preview_large_charm_alt2", "targetname");
  level.camera_loadout_showcase_preview_large_charm_alt2.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm_alt2.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_large_charm_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_barrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_barrel_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_barrel_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_barrel_alt1.basecam.depthoffieldvalues = [16, 52];
  level.camera_loadout_showcase_preview_large_barrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_barrel_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_barrel_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_laser = spawnStruct();
  level.camera_loadout_showcase_preview_large_laser.basecam = getEnt("camera_mp_gunsmith_preview_large_laser", "targetname");
  level.camera_loadout_showcase_preview_large_laser.basecam.depthoffieldvalues = [12, 26];
  level.camera_loadout_showcase_preview_large_laser.myfov = 36;
  level.camera_loadout_showcase_preview_large_laser.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_laser.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine.basecam = getEnt("camera_mp_gunsmith_preview_large_magazine", "targetname");
  level.camera_loadout_showcase_preview_large_magazine.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_magazine.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_magazine_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt1.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_magazine_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt2.basecam = getEnt("camera_mp_gunsmith_preview_large_magazine_alt2", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt2.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_large_muzzle.basecam = getEnt("camera_mp_gunsmith_preview_large_muzzle", "targetname");
  level.camera_loadout_showcase_preview_large_muzzle.basecam.depthoffieldvalues = [21, 34];
  level.camera_loadout_showcase_preview_large_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_large_muzzle.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_muzzle.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_muzzle_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_muzzle_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam.depthoffieldvalues = [21, 32];
  level.camera_loadout_showcase_preview_large_muzzle_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_muzzle_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_muzzle_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_optic = spawnStruct();
  level.camera_loadout_showcase_preview_large_optic.basecam = getEnt("camera_mp_gunsmith_preview_large_optic", "targetname");
  level.camera_loadout_showcase_preview_large_optic.basecam.depthoffieldvalues = [21.5, 25];
  level.camera_loadout_showcase_preview_large_optic.myfov = 36;
  level.camera_loadout_showcase_preview_large_optic.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_optic.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_large_reargrip.basecam = getEnt("camera_mp_gunsmith_preview_large_reargrip", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip.basecam.depthoffieldvalues = [12, 23];
  level.camera_loadout_showcase_preview_large_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_large_reargrip.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_reargrip_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_reargrip_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam.depthoffieldvalues = [12, 21];
  level.camera_loadout_showcase_preview_large_reargrip_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_reargrip_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_sticker = spawnStruct();
  level.camera_loadout_showcase_preview_large_sticker.basecam = getEnt("camera_mp_gunsmith_preview_large_sticker", "targetname");
  level.camera_loadout_showcase_preview_large_sticker.basecam.depthoffieldvalues = [20, 32];
  level.camera_loadout_showcase_preview_large_sticker.myfov = 36;
  level.camera_loadout_showcase_preview_large_sticker.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_large_sticker.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_sticker_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_sticker_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_sticker_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_sticker_alt1.basecam.depthoffieldvalues = [20, 35];
  level.camera_loadout_showcase_preview_large_sticker_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_sticker_alt1.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_large_sticker_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_sticker_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_sticker_alt2.basecam = getEnt("camera_mp_gunsmith_preview_large_sticker_alt2", "targetname");
  level.camera_loadout_showcase_preview_large_sticker_alt2.basecam.depthoffieldvalues = [20, 32];
  level.camera_loadout_showcase_preview_large_sticker_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_sticker_alt2.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_large_sticker_alt2.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_sticker_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_large_sticker_alt3.basecam = getEnt("camera_mp_gunsmith_preview_large_sticker_alt3", "targetname");
  level.camera_loadout_showcase_preview_large_sticker_alt3.basecam.depthoffieldvalues = [20, 35];
  level.camera_loadout_showcase_preview_large_sticker_alt3.myfov = 36;
  level.camera_loadout_showcase_preview_large_sticker_alt3.weapon_locs[2] = getEnt("weapon_loc_weapon_preview", "targetname");
  level.camera_loadout_showcase_preview_large_sticker_alt3.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_stock = spawnStruct();
  level.camera_loadout_showcase_preview_large_stock.basecam = getEnt("camera_mp_gunsmith_preview_large_stock", "targetname");
  level.camera_loadout_showcase_preview_large_stock.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_large_stock.myfov = 36;
  level.camera_loadout_showcase_preview_large_stock.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_stock.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_stock_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_stock_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_stock_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_stock_alt1.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_large_stock_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_stock_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_stock_alt1.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_underbarrel = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel.basecam = getEnt("camera_mp_gunsmith_preview_large_underbarrel", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel.basecam.depthoffieldvalues = [20, 35];
  level.camera_loadout_showcase_preview_large_underbarrel.myfov = 36;
  level.camera_loadout_showcase_preview_large_underbarrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel.spotlimit = 6;
  level.camera_loadout_showcase_preview_large_underbarrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_underbarrel_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam.depthoffieldvalues = [20, 36];
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.spotlimit = 6;
  level.camera_character_tango = spawnStruct();
  level.camera_character_tango.basecam = getEnt("char_tango", "targetname");
  level.camera_character_tango.basecam.depthoffieldvalues = [4.5, 125];
  level.camera_character_tango.myfov = 30;
  level.camera_character_tango.update_char_loc = ::update_main_menu_char_loc;
  level.camera_character_tango.spotlimit = 6;
  level.camera_character_faction_select_l = spawnStruct();
  level.camera_character_faction_select_l.basecam = getEnt("char_west_b_detail", "targetname");
  level.camera_character_faction_select_l.basecam.depthoffieldvalues = [22, 98];
  level.camera_character_faction_select_l.myfov = 37;
  level.camera_character_faction_select_l.update_char_loc = ::update_main_menu_char_loc;
  level.camera_character_faction_select_l.spotlimit = 6;
  level.camera_character_faction_select_l_detail = spawnStruct();
  level.camera_character_faction_select_l_detail.basecam = getEnt("char_west_b", "targetname");
  level.camera_character_faction_select_l_detail.basecam.depthoffieldvalues = [22, 181];
  level.camera_character_faction_select_l_detail.myfov = 37;
  level.camera_character_faction_select_l_detail.update_char_loc = ::update_main_menu_char_loc;
  level.camera_character_faction_select_l_detail.spotlimit = 6;
  level.camera_character_faction_select_r = spawnStruct();
  level.camera_character_faction_select_r.basecam = getEnt("char_east_a_detail", "targetname");
  level.camera_character_faction_select_r.basecam.depthoffieldvalues = [22, 98];
  level.camera_character_faction_select_r.myfov = 37;
  level.camera_character_faction_select_r.update_char_loc = ::update_main_menu_char_loc;
  level.camera_character_faction_select_r.char_index = 1;
  level.camera_character_faction_select_r.spotlimit = 6;
  level.camera_character_faction_select_r_detail = spawnStruct();
  level.camera_character_faction_select_r_detail.basecam = getEnt("char_east_a", "targetname");
  level.camera_character_faction_select_r_detail.basecam.depthoffieldvalues = [22, 181];
  level.camera_character_faction_select_r_detail.myfov = 37;
  level.camera_character_faction_select_r_detail.update_char_loc = ::update_main_menu_char_loc;
  level.camera_character_faction_select_r_detail.char_index = 1;
  level.camera_character_faction_select_r_detail.spotlimit = 6;
  level.camera_character_preview_select = spawnStruct();
  level.camera_character_preview_select.basecam = getEnt("char_preview_detail", "targetname");
  level.camera_character_preview_select.basecam.depthoffieldvalues = [22, 60];
  level.camera_character_preview_select.myfov = 37;
  level.camera_character_preview_select.char_loc = getEnt("charroom_char_preview", "targetname");
  level.camera_character_preview_select.spotlimit = 6;
  level.camera_character_preview_select_detail = spawnStruct();
  level.camera_character_preview_select_detail.basecam = getEnt("char_preview", "targetname");
  level.camera_character_preview_select_detail.basecam.depthoffieldvalues = [22, 181];
  level.camera_character_preview_select_detail.myfov = 37;
  level.camera_character_preview_select_detail.char_loc = getEnt("charroom_char_preview", "targetname");
  level.camera_character_preview_select_detail.spotlimit = 6;
  level.camera_lobby = spawnStruct();
  level.camera_lobby.basecam = getEnt("char_lobby", "targetname");
  level.camera_lobby.basecam.depthoffieldvalues = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, [22, 98], [3.5, 225]);
  level.camera_lobby.myfov = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, 37, 36);
  level.camera_lobby.update_char_loc = ::update_lobby_char_loc;
  level.camera_lobby.spotlimit = 6;
  level.camera_lobby_detail = spawnStruct();
  level.camera_lobby_detail.basecam = getEnt("char_lobby_detail", "targetname");
  level.camera_lobby_detail.basecam.depthoffieldvalues = [3, 100];
  level.camera_lobby_detail.myfov = 36;
  level.camera_lobby_detail.update_char_loc = ::update_lobby_char_loc;
  level.camera_lobby_detail.spotlimit = 6;

  if(istrue(level._id_70AEE737D4082DAF)) {
    level._id_B78F085CE2B63F91 = spawnStruct();
    level._id_B78F085CE2B63F91.basecam = getEnt("char_lobby_dmz", "targetname");
    level._id_B78F085CE2B63F91.basecam.depthoffieldvalues = [3.5, 225];
    level._id_B78F085CE2B63F91.myfov = 36;
    level._id_B78F085CE2B63F91.update_char_loc = ::_id_9C5A6E36E93EADD9;
    level._id_B78F085CE2B63F91.spotlimit = 6;
    level._id_837428C53BE309FB = spawnStruct();
    level._id_837428C53BE309FB.basecam = getEnt("char_lobby_dmz_detail", "targetname");
    level._id_837428C53BE309FB.basecam.depthoffieldvalues = [3, 100];
    level._id_837428C53BE309FB.myfov = 36;
    level._id_837428C53BE309FB.update_char_loc = ::_id_9C5A6E36E93EADD9;
    level._id_837428C53BE309FB.spotlimit = 6;
    level._id_0E679086C223BDFA = spawnStruct();
    level._id_0E679086C223BDFA.basecam = getEnt("char_lobby_br", "targetname");
    level._id_0E679086C223BDFA.basecam.depthoffieldvalues = [3.5, 225];
    level._id_0E679086C223BDFA.myfov = 36;
    level._id_0E679086C223BDFA.update_char_loc = ::_id_B65A48A89B1A2CC0;
    level._id_0E679086C223BDFA.spotlimit = 6;
    level._id_816F5B98CFE745FE = spawnStruct();
    level._id_816F5B98CFE745FE.basecam = getEnt("char_lobby_br_detail", "targetname");
    level._id_816F5B98CFE745FE.basecam.depthoffieldvalues = [3, 100];
    level._id_816F5B98CFE745FE.myfov = 36;
    level._id_816F5B98CFE745FE.update_char_loc = ::_id_B65A48A89B1A2CC0;
    level._id_816F5B98CFE745FE.spotlimit = 6;
  }

  if(_id_9FE1BC92EC9FB00F) {
    level._id_26D2D5FA7DFEE609 = spawnStruct();
    level._id_26D2D5FA7DFEE609.basecam = getEnt("camera_mtx_preview", "targetname");
    level._id_26D2D5FA7DFEE609.basecam.depthoffieldvalues = [22, 98];
    level._id_26D2D5FA7DFEE609.myfov = 37;
    level._id_26D2D5FA7DFEE609.spotlimit = 6;
  }

  level._id_B0C5FFD7BAC552C5 = spawnStruct();
  level._id_B0C5FFD7BAC552C5.basecam = getEnt("camera_crib_dmz", "targetname");
  level._id_B0C5FFD7BAC552C5.basecam.depthoffieldvalues = [3.5, 225];
  level._id_B0C5FFD7BAC552C5.myfov = 36;
  level._id_B0C5FFD7BAC552C5.update_char_loc = ::_id_18D1A39CC5732FB1;
  level._id_B0C5FFD7BAC552C5.spotlimit = 6;
  level._id_172FADDC8AEE05AF = spawnStruct();
  level._id_172FADDC8AEE05AF.basecam = getEnt("camera_crib_dmz_detail", "targetname");
  level._id_172FADDC8AEE05AF.basecam.depthoffieldvalues = [3, 100];
  level._id_172FADDC8AEE05AF.myfov = 36;
  level._id_172FADDC8AEE05AF.update_char_loc = ::_id_18D1A39CC5732FB1;
  level._id_172FADDC8AEE05AF.spotlimit = 6;
  level._id_4EA67C4450821778 = spawnStruct();
  level._id_4EA67C4450821778.basecam = getEnt("char_social", "targetname");
  level._id_4EA67C4450821778.basecam.depthoffieldvalues = [3, 150];
  level._id_4EA67C4450821778.myfov = 36;
  level._id_4EA67C4450821778.update_char_loc = ::_id_E078E650B9311BAE;
  level._id_4EA67C4450821778.spotlimit = 3;
  level._id_B4D7482DCAFB066A = spawnStruct();
  level._id_B4D7482DCAFB066A.basecam = getEnt("char_social_wide", "targetname");
  level._id_B4D7482DCAFB066A.basecam.depthoffieldvalues = [3, 325];
  level._id_B4D7482DCAFB066A.myfov = 36;
  level._id_B4D7482DCAFB066A.update_char_loc = ::_id_E078E650B9311BAE;
  level._id_B4D7482DCAFB066A.spotlimit = 3;
  level._id_32D5BC10C9517A5C = spawnStruct();
  level._id_32D5BC10C9517A5C.basecam = getEnt("char_social_alt", "targetname");
  level._id_32D5BC10C9517A5C.basecam.depthoffieldvalues = [3, 150];
  level._id_32D5BC10C9517A5C.myfov = 36;
  level._id_32D5BC10C9517A5C.update_char_loc = ::_id_E078E650B9311BAE;
  level._id_32D5BC10C9517A5C.spotlimit = 3;

  if(!_id_9FE1BC92EC9FB00F) {
    level._id_3BFBE3641DFECFF0 = spawnStruct();
    level._id_3BFBE3641DFECFF0.basecam = getEnt("char_social_showcase", "targetname");
    level._id_3BFBE3641DFECFF0.basecam.depthoffieldvalues = [3, 150];
    level._id_3BFBE3641DFECFF0.myfov = 36;
    level._id_3BFBE3641DFECFF0.update_char_loc = ::_id_E078E650B9311BAE;
    level._id_3BFBE3641DFECFF0.spotlimit = 3;
  }

  level._id_C0C7E6BE70482B73 = spawnStruct();
  level._id_C0C7E6BE70482B73.basecam = getEnt("social_showcase_character", "targetname");
  level._id_C0C7E6BE70482B73.basecam.depthoffieldvalues = [10, 100];
  level._id_C0C7E6BE70482B73.myfov = 36;
  level._id_C0C7E6BE70482B73.update_char_loc = ::_id_E078E650B9311BAE;
  level._id_C0C7E6BE70482B73.spotlimit = 6;
  level._id_008302CD976FA0A3 = spawnStruct();
  level._id_008302CD976FA0A3.basecam = getEnt("social_showcase_weapon", "targetname");
  level._id_008302CD976FA0A3.basecam.depthoffieldvalues = [10, 80];
  level._id_008302CD976FA0A3.myfov = 36;
  level._id_008302CD976FA0A3.update_char_loc = ::_id_E078E650B9311BAE;
  level._id_008302CD976FA0A3.spotlimit = 6;
  level.camera_character_tournaments = spawnStruct();
  level.camera_character_tournaments.basecam = getEnt("char_tournament_overcam", "targetname");
  level.camera_character_tournaments.basecam.depthoffieldvalues = [22, 256];
  level.camera_character_tournaments.myfov = 36;
  level.camera_character_tournaments.update_char_loc = ::update_arena_char_loc;
  level._id_AEB531C63A3266D6 = spawnStruct();
  level._id_AEB531C63A3266D6.basecam = getEnt("cam_firing_range", "targetname");
  level._id_AEB531C63A3266D6.basecam.depthoffieldvalues = [2, 256];
  level._id_AEB531C63A3266D6.myfov = 65;
  level._id_5215FA2603C0CD47 = spawnStruct();
  level._id_5215FA2603C0CD47.basecam = getEnt("cam_bp_character", "targetname");
  level._id_B76DAD29B681C12B = level._id_5215FA2603C0CD47.basecam.origin;
  level._id_9B2E06D9573D88A5 = level._id_5215FA2603C0CD47.basecam.angles;
  level._id_5215FA2603C0CD47.spotlimit = 3;

  if(isDefined(level._id_5215FA2603C0CD47.basecam)) {
    level._id_5215FA2603C0CD47.basecam.depthoffieldvalues = [20, 170];
    level._id_CEC4CE34318C0C9A = level._id_5215FA2603C0CD47.basecam.depthoffieldvalues;
    level._id_5215FA2603C0CD47.myfov = 45;
    level._id_5215FA2603C0CD47.char_loc = getEnt("bp_character_figurine_01", "targetname");
  }

  level._id_6C5E13E5CADF25C9 = spawnStruct();
  level._id_6C5E13E5CADF25C9.basecam = getEnt("cam_bp_character_detail", "targetname");
  level._id_6C5E13E5CADF25C9.spotlimit = 3;

  if(isDefined(level._id_6C5E13E5CADF25C9.basecam)) {
    level._id_6C5E13E5CADF25C9.basecam.depthoffieldvalues = [22, 100];
    level._id_6C5E13E5CADF25C9.myfov = 35;
    level._id_6C5E13E5CADF25C9.char_loc = getEnt("bp_character_figurine_01", "targetname");
  }

  level._id_EAD7DE7F41B832BC = spawnStruct();
  level._id_EAD7DE7F41B832BC.basecam = getEnt("cam_bp_weapon", "targetname");
  level._id_32991C40F6D4268A = level._id_EAD7DE7F41B832BC.basecam.origin;
  level._id_37125601A51470C8 = level._id_EAD7DE7F41B832BC.basecam.angles;
  level._id_EAD7DE7F41B832BC.spotlimit = 3;

  if(isDefined(level._id_EAD7DE7F41B832BC.basecam)) {
    level._id_EAD7DE7F41B832BC.basecam.depthoffieldvalues = [20, 80];
    level._id_CC2BB7C6E61990D5 = level._id_EAD7DE7F41B832BC.basecam.depthoffieldvalues;
    level._id_EAD7DE7F41B832BC.myfov = 35;
    level._id_EAD7DE7F41B832BC.weapon_locs[2] = getEnt("bp_weapon_figurine_01", "targetname");
  }

  level._id_5DC4697427310378 = spawnStruct();
  level._id_5DC4697427310378.basecam = getEnt("cam_bp_vehicle", "targetname");
  level._id_7526BC63841E8E7E = level._id_5DC4697427310378.basecam.origin;
  level._id_5B29F35C02A41E14 = level._id_5DC4697427310378.basecam.angles;
  level._id_5DC4697427310378.spotlimit = 3;

  if(isDefined(level._id_5DC4697427310378.basecam)) {
    level._id_5DC4697427310378.basecam.depthoffieldvalues = [20, 150];
    level._id_7FAE4A98502EA9B1 = level._id_5DC4697427310378.basecam.depthoffieldvalues;
    level._id_5DC4697427310378.myfov = 35;
    level._id_5DC4697427310378.char_loc = getEnt("bp_vehicle_figurine_01", "targetname");
  }

  _id_FC3A5EACE0F99101 = scripts\engine\utility::ter_op(_id_9FE1BC92EC9FB00F, "cam_bp_vehicle_detail", "cam_bp_items");
  level._id_E671031110AF7F94 = spawnStruct();
  level._id_E671031110AF7F94.basecam = getEnt(_id_FC3A5EACE0F99101, "targetname");
  level._id_0346A5A00F79C082 = level._id_E671031110AF7F94.basecam.origin;
  level._id_38BF9876723F7300 = level._id_E671031110AF7F94.basecam.angles;
  level._id_E671031110AF7F94.spotlimit = 3;

  if(isDefined(level._id_E671031110AF7F94.basecam)) {
    level._id_E671031110AF7F94.basecam.depthoffieldvalues = [10, 100];
    level._id_C039481874832D2D = level._id_E671031110AF7F94.basecam.depthoffieldvalues;
    level._id_E671031110AF7F94.myfov = 45;
    level._id_E671031110AF7F94.char_loc = getEnt("bp_vehicle_items", "targetname");
  }

  level._id_61F3469BFD32FC67 = spawnStruct();
  level._id_61F3469BFD32FC67.basecam = getEnt("camera_black", "targetname");
  level._id_61F3469BFD32FC67.basecam.depthoffieldvalues = [2, 256];
  level._id_61F3469BFD32FC67.myfov = 45;
}

_id_7A7465E3B2F21267() {
  wait 0.25;
  level._id_36506DC78F9F6F3B = getEntArray("lights", "targetname");
  level._id_D1511DCF3642E350 = [];
  level._id_CE6333E67D961B48 = [];
  level._id_DBAE9946BA81CC58 = [];
  level._id_9A65323E854A8ED0 = [];
  level._id_510F673442128057 = [];
  level._id_BA2E65D151A5BA08 = [];
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;

  foreach(light in level._id_36506DC78F9F6F3B) {
    if(isDefined(light.script_noteworthy)) {
      tags = strtok(light.script_noteworthy, "+");

      foreach(tag in tags) {
        switch (tag) {
          case "gun_bench":
            level._id_CE6333E67D961B48[level._id_CE6333E67D961B48.size] = light;
            break;
          case "loadout_table":
            level._id_DBAE9946BA81CC58[level._id_DBAE9946BA81CC58.size] = light;
            break;
          case "loadout_equipment":
            level._id_9A65323E854A8ED0[level._id_9A65323E854A8ED0.size] = light;
            break;
          case "character_select":
            level._id_510F673442128057[level._id_510F673442128057.size] = light;
            break;
          case "operators":
            level._id_BA2E65D151A5BA08[level._id_BA2E65D151A5BA08.size] = light;
            break;
          case "lobby":
            level._id_D1511DCF3642E350[level._id_D1511DCF3642E350.size] = light;
            break;
        }
      }
    }
  }

  level._id_E35B63F3AC08DADA = "DUNNO";
  waitframe();

  foreach(light in level._id_36506DC78F9F6F3B)
  light._id_86102E35E838B321 = light getlightintensity();

  if(!_id_9FE1BC92EC9FB00F)
    _id_47F8406A4C96AF32("Gunbench");
}

setup_initial_entities() {
  _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;
  level.characters = [];

  for(_id_A2D54B92B23FA8BF = 0; _id_A2D54B92B23FA8BF < 8; _id_A2D54B92B23FA8BF++) {
    _id_986A67076C51D869 = undefined;
    index = _id_A2D54B92B23FA8BF + 1;

    if(index < 10)
      _id_986A67076C51D869 = getEnt("lobby_charslot_0" + index, "targetname");
    else
      _id_986A67076C51D869 = getEnt("lobby_charslot_" + index, "targetname");

    level.characters[_id_A2D54B92B23FA8BF] = spawn("script_character", _id_986A67076C51D869.origin, 0, 0, _id_A2D54B92B23FA8BF, "MPClientCharacter");
  }

  level.characters[16] = spawn("script_character", level.characters[0].origin, 0, 0, 16, "MPClientCharacter");
  level.characters[16].angles = (0, 270, 0);

  for(_id_C433F957A34A5776 = 0; _id_C433F957A34A5776 < 6; _id_C433F957A34A5776++) {
    index = _id_C433F957A34A5776 + 1;
    _id_A2D54B92B23FA8BF = 8 + _id_C433F957A34A5776;
    _id_986A67076C51D869 = getEnt("lobby_charslot_0" + index + "_dog", "targetname");

    if(isDefined(_id_986A67076C51D869))
      level.characters[_id_A2D54B92B23FA8BF] = spawn("script_character", _id_986A67076C51D869.origin, 0, 0, _id_A2D54B92B23FA8BF, "MPClientCharacter");
  }

  _id_986A67076C51D869 = getEnt("charroom_char_tango_east", "targetname");
  level.characters[14] = spawn("script_character", _id_986A67076C51D869.origin, 0, 0, 14, "MPClientCharacter");
  _id_986A67076C51D869 = getEnt("charroom_char_tango_west", "targetname");
  level.characters[15] = spawn("script_character", _id_986A67076C51D869.origin, 0, 0, 15, "MPClientCharacter");
  _id_C932BA44E7ECDA70 = getEnt("weapon_loc_hq1", "targetname");
  level.weapons = [];
  level.weapons[0] = spawn("script_weapon", _id_C932BA44E7ECDA70.origin, 0, 0, 0);
  level.weapons[0].angles = _id_C932BA44E7ECDA70.angles;
  _id_6769E78A0DE3FF26 = getEnt("weapon_loc_hq2", "targetname");
  level.weapons[1] = spawn("script_weapon", _id_6769E78A0DE3FF26.origin, 0, 0, 1);
  level.weapons[1].angles = _id_6769E78A0DE3FF26.angles;
  _id_F4D841186B98CD95 = getEnt("weapon_loc_preview", "targetname");
  level.weapons[2] = spawn("script_weapon", _id_F4D841186B98CD95.origin, 0, 0, 2);
  level.weapons[2].angles = _id_F4D841186B98CD95.angles;
  _id_95FAB397FEFDB735 = getEnt("weapon_loc_watch", "targetname");
  level.weapons[3] = spawn("script_weapon", _id_95FAB397FEFDB735.origin, 0, 0, 3);
  level.weapons[3].angles = _id_95FAB397FEFDB735.angles;

  if(_id_9FE1BC92EC9FB00F) {
    _id_28AA9C2E44A1B027 = getEnt("character_mtx_preview", "targetname");
    level.characters[17] = spawn("script_character", _id_28AA9C2E44A1B027.origin, 0, 0, 17, "MPClientCharacter");
    _id_7FC1729C5EF6711C = getEnt("weapon_mtx_preview", "targetname");
    level.weapons[4] = spawn("script_weapon", _id_7FC1729C5EF6711C.origin, 0, 0, 4);
    level.weapons[4].angles = _id_7FC1729C5EF6711C.angles;
  }

  level._id_21F36F18171D453D = getEnt("br_cargoplane_exterior", "targetname");
  level._id_B0F545BE973A4A13 = getEnt("br_cargoplane_car", "targetname");
  level._id_29DD07D56F00E38D = getEntArray("br_cargoplane", "targetname");
  _id_9F03647D9D3B09A0();

  if(isDefined(level._id_21F36F18171D453D)) {
    if(isDefined(level._id_29DD07D56F00E38D)) {
      foreach(item in level._id_29DD07D56F00E38D)
      item linkTo(level._id_21F36F18171D453D);
    }

    level._id_21F36F18171D453D._id_D6FECEE135A01715 = level._id_21F36F18171D453D.origin;
    level._id_21F36F18171D453D.originalangles = level._id_21F36F18171D453D.angles;
  }

  if(isDefined(level._id_B0F545BE973A4A13))
    level._id_B0F545BE973A4A13._id_D6FECEE135A01715 = level._id_B0F545BE973A4A13.origin;

  if(_id_32AB61259FD850EF() == "mp_frontend3" || _id_32AB61259FD850EF() == "mp_frontend6")
    thread _id_7C7293562FD00957();

  frontend_camera_setup(level.camera_lobby_detail.basecam.origin, level.camera_lobby_detail.basecam.angles);
  thread _id_7A7465E3B2F21267();
}

_id_9F03647D9D3B09A0() {
  level._id_25A1031827460367 = getEntArray("br_lobby_only_lgt", "targetname");

  foreach(light in level._id_25A1031827460367)
  light.og_intensity = light getlightintensity();

  level._id_491D8E482BFFA33E = getEntArray("dmz_lobby_only_lgt", "targetname");

  foreach(light in level._id_491D8E482BFFA33E)
  light.og_intensity = light getlightintensity();

  level._id_DC46E2A7AC206D6C = getEntArray("core_lobby_only_lgt", "targetname");

  foreach(light in level._id_DC46E2A7AC206D6C)
  light.og_intensity = light getlightintensity();

  if(!isDefined(level._id_21F36F18171D453D)) {
    return;
  }
  level._id_3C25518892193253 = scripts\engine\utility::spawn_script_origin(level._id_21F36F18171D453D.origin, level._id_21F36F18171D453D.angles);
  _id_83D076584339CBE2 = getEntArray("cargo_plane_probe", "script_noteworthy");

  foreach(probe in _id_83D076584339CBE2)
  probe linkTo(level._id_3C25518892193253);
}

_id_34A94623842B0973(_id_06A49B47C2BC1134, state) {
  if(!isDefined(_id_06A49B47C2BC1134)) {
    return;
  }
  if(state == "on") {
    foreach(light in _id_06A49B47C2BC1134)
    light setlightintensity(light.og_intensity);
  } else if(state == "off") {
    foreach(light in _id_06A49B47C2BC1134)
    light setlightintensity(0.0);
  }
}

_id_51D40164FA113D86() {
  if(getDvar("frontEndFastfileName") == "mp_frontend6") {
    if(isDefined(level._id_1D5C7ACD0BC0EFC4))
      level._id_1D5C7ACD0BC0EFC4 delete();

    level._id_1D5C7ACD0BC0EFC4 = spawn("script_model", (-6751.56, 1905.79, 144.521));
    level._id_1D5C7ACD0BC0EFC4 setModel("vfx_iw9_frontend_lobby_s6_tag_origin_fx");
    level._id_1D5C7ACD0BC0EFC4.angles = (0, 0, 0);
    level._id_1D5C7ACD0BC0EFC4 setscriptablepartstate("lobby", "mp");
    level._id_1D5C7ACD0BC0EFC4 forcenetfieldhighlod(1);
  }

  _id_34A94623842B0973(level._id_DC46E2A7AC206D6C, "on");
  _id_34A94623842B0973(level._id_25A1031827460367, "off");
  _id_34A94623842B0973(level._id_491D8E482BFFA33E, "off");
  setsuncolorandintensity(0.99216, 1.0, 0.98431, 0.000574);
  setsundirection(anglesToForward((-29, 94, 0)));
}

_id_312C21343259651C() {
  _id_34A94623842B0973(level._id_DC46E2A7AC206D6C, "off");
  _id_34A94623842B0973(level._id_25A1031827460367, "off");
  _id_34A94623842B0973(level._id_491D8E482BFFA33E, "on");
  setsuncolorandintensity(0.85, 0.95, 1, 0.0037216);
  setsundirection(anglesToForward((-29, 60, 0)));
}

_id_3E0815128A89FF77() {
  if(getDvar("frontEndFastfileName") == "mp_frontend6") {
    if(isDefined(level._id_1D5C7ACD0BC0EFC4))
      level._id_1D5C7ACD0BC0EFC4 delete();

    level._id_1D5C7ACD0BC0EFC4 = spawn("script_model", (-7027.58, 2565.13, 171.399));
    level._id_1D5C7ACD0BC0EFC4 setModel("vfx_iw9_frontend_lobby_s6_tag_origin_fx");
    level._id_1D5C7ACD0BC0EFC4.angles = (0, 0, 0);
    level._id_1D5C7ACD0BC0EFC4 setscriptablepartstate("lobby", "br");
    level._id_1D5C7ACD0BC0EFC4 forcenetfieldhighlod(1);
  }

  _id_34A94623842B0973(level._id_DC46E2A7AC206D6C, "off");
  _id_34A94623842B0973(level._id_25A1031827460367, "on");
  _id_34A94623842B0973(level._id_491D8E482BFFA33E, "off");
  setsuncolorandintensity(1, 1, 1, 0.013);
  setsundirection(anglesToForward((-29, -35, 0)));
}

#using_animtree("client_character");

_id_7C7293562FD00957() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names))
    waitframe();

  if(istrue(level._id_9121F71B47A01026)) {
    _id_C940010FAF0828F0 = scripts\engine\utility::getStruct("fe_mil_base_anim_01", "targetname");
    level.vehicles[0] = spawn("script_model", _id_C940010FAF0828F0.origin);
    level.vehicles[0] setModel("veh9_mil_lnd_jltv_lobby");
    level.vehicles[0].animname = "vehicle";
    level.vehicles[0]._id_AC4C2BF73CF75667 = "jltv";
    level.vehicles[0] useanimtree(#animtree);
    level.vehicles[1] = spawn("script_model", _id_C940010FAF0828F0.origin);
    level.vehicles[1] setModel("veh9_mil_air_heli_medium_lobby");
    level.vehicles[1].animname = "vehicle";
    level.vehicles[1]._id_AC4C2BF73CF75667 = "small_bird";
    level.vehicles[1] useanimtree(#animtree);
  }

  if(istrue(level._id_7EE57B7672DB9BF5)) {
    _id_C940020FAF082B23 = scripts\engine\utility::getStruct("fe_mil_base_anim_02", "targetname");
    level.vehicles[2] = spawn("script_model", (-7161.34, 3702.8, 117.042));
    level.vehicles[2] setModel("veh9_mil_air_heli_blima_lobby");
    level.vehicles[2].animname = "vehicle";
    level.vehicles[2]._id_AC4C2BF73CF75667 = "medium_bird";
    level.vehicles[2] useanimtree(#animtree);
    _id_4AAA584C581B532E(level.vehicles[2]);
  }

  if(istrue(level._id_F993553728AF3E10)) {
    _id_C940030FAF082D56 = scripts\engine\utility::getStruct("fe_mil_base_anim_03", "targetname");
    level.vehicles[3] = spawn("script_model", _id_C940030FAF082D56.origin);
    level.vehicles[3] setModel("veh9_mil_lnd_cargo_truck_lobby");
    level.vehicles[3].animname = "vehicle";
    level.vehicles[3]._id_AC4C2BF73CF75667 = "cargo";
    level.vehicles[3] useanimtree(#animtree);
  }
}

_id_2898724F8CF4C78E() {
  if(istrue(level._id_9121F71B47A01026)) {
    _id_C940010FAF0828F0 = scripts\engine\utility::getStruct("fe_mil_base_anim_01", "targetname");
    level.vehicles[0].origin = _id_C940010FAF0828F0.origin;
    level.vehicles[1].origin = _id_C940010FAF0828F0.origin;
  }

  if(istrue(level._id_7EE57B7672DB9BF5)) {
    _id_C940020FAF082B23 = scripts\engine\utility::getStruct("fe_mil_base_anim_02", "targetname");
    level.vehicles[2].origin = (-7161.34, 3702.8, 117.042);
  }

  if(istrue(level._id_F993553728AF3E10)) {
    _id_C940030FAF082D56 = scripts\engine\utility::getStruct("fe_mil_base_anim_03", "targetname");
    level.vehicles[3].origin = _id_C940030FAF082D56.origin;
  }
}

_id_64CA1EFA525C0BFA(_id_0E25D1D189177A7C) {
  if(!isDefined(_id_0E25D1D189177A7C) || _id_0E25D1D189177A7C != "squad_lobby" || istrue(level._id_5B62E15F6487BAA0)) {
    return;
  }
  level._id_5B62E15F6487BAA0 = 1;

  if(istrue(level._id_9121F71B47A01026))
    thread _id_207D03D11D9A3FB0();

  if(istrue(level._id_7EE57B7672DB9BF5))
    thread _id_43F1A37A8330E1ED();

  if(istrue(level._id_F993553728AF3E10))
    thread _id_B0D1704CD233F5C6();
}

_id_207D03D11D9A3FB0() {
  level endon("game_ended");
  _id_9C0441671BABC880 = getdvarint("dvar_B453EC118B6F9C37", 30);
  _id_DE48FF618DCEA8A2 = getdvarint("dvar_B476FA118B9602B9", 180);

  for(;;) {
    _id_74B5B12BB6514385 = randomintrange(_id_9C0441671BABC880, _id_DE48FF618DCEA8A2);
    wait(_id_74B5B12BB6514385);
    _id_5E1777E704DBA360 = scripts\engine\utility::getStruct("fe_mil_base_anim_01", "targetname");
    level.vehicles[0] animScripted("iw9_fe_jltv_enter_01", _id_5E1777E704DBA360.origin, _id_5E1777E704DBA360.angles, %iw9_fe_jltv_enter_01);
    level.vehicles[1] animScripted("iw9_fe_small_bird_enter_01", _id_5E1777E704DBA360.origin, _id_5E1777E704DBA360.angles, %iw9_fe_small_bird_enter_01);
    wait(getanimlength(%iw9_fe_jltv_enter_01));
    level.vehicles[0] animScripted("iw9_fe_jltv_loop_01", _id_5E1777E704DBA360.origin, _id_5E1777E704DBA360.angles, %iw9_fe_jltv_loop_01);
    level.vehicles[1] animScripted("iw9_fe_small_bird_loop_01", _id_5E1777E704DBA360.origin, _id_5E1777E704DBA360.angles, %iw9_fe_small_bird_loop_01);
    wait(getdvarint("dvar_4BA87D948942D27E", 60));
    level.vehicles[0] animScripted("iw9_fe_jltv_exit_01", _id_5E1777E704DBA360.origin, _id_5E1777E704DBA360.angles, %iw9_fe_jltv_exit_01);
    level.vehicles[1] animScripted("iw9_fe_small_bird_exit_01", _id_5E1777E704DBA360.origin, _id_5E1777E704DBA360.angles, %iw9_fe_small_bird_exit_01);
  }
}

_id_43F1A37A8330E1ED() {
  level endon("game_ended");
  level.vehicles[2] scriptmodelplayanim("iw9_fe_medium_bird_loop_01");
}

_id_B0D1704CD233F5C6() {
  level endon("game_ended");
  _id_9C0441671BABC880 = getdvarint("dvar_7469506E01034889", 30);
  _id_DE48FF618DCEA8A2 = getdvarint("dvar_7446426E00DCE207", 180);

  for(;;) {
    _id_74B5B12BB6514385 = randomintrange(_id_9C0441671BABC880, _id_DE48FF618DCEA8A2);
    wait(_id_74B5B12BB6514385);
    _id_5E1777E704DBA360 = scripts\engine\utility::getStruct("fe_mil_base_anim_03", "targetname");
    level.vehicles[3] animScripted("iw9_fe_cargo_truck_enter_01", _id_5E1777E704DBA360.origin, _id_5E1777E704DBA360.angles, %iw9_fe_cargo_truck_enter_01);
    wait(getanimlength(%iw9_fe_cargo_truck_enter_01));
    level.vehicles[3] animScripted("iw9_fe_cargo_truck_loop_01", _id_5E1777E704DBA360.origin, _id_5E1777E704DBA360.angles, %iw9_fe_cargo_truck_loop_01);
    wait(getdvarint("dvar_61E0EF762C4AA27C", 60));
    level.vehicles[3] animScripted("iw9_fe_cargo_truck_exit_01", _id_5E1777E704DBA360.origin, _id_5E1777E704DBA360.angles, %iw9_fe_cargo_truck_exit_01);
  }
}

_id_4AAA584C581B532E(blima) {
  if(blima tagexists("TAG_TAIL_ROTOR_BLADE_01"))
    blima hidepart("TAG_TAIL_ROTOR_BLADE_01");

  if(blima tagexists("TAG_TAIL_ROTOR_BLADE_02"))
    blima hidepart("TAG_TAIL_ROTOR_BLADE_02");

  if(blima tagexists("TAG_TAIL_ROTOR_BLADE_03"))
    blima hidepart("TAG_TAIL_ROTOR_BLADE_03");

  if(blima tagexists("TAG_TAIL_ROTOR_BLADE_04"))
    blima hidepart("TAG_TAIL_ROTOR_BLADE_04");

  if(blima tagexists("TAG_MAIN_ROTOR_BLADE_01"))
    blima hidepart("TAG_MAIN_ROTOR_BLADE_01");

  if(blima tagexists("TAG_MAIN_ROTOR_BLADE_02"))
    blima hidepart("TAG_MAIN_ROTOR_BLADE_02");

  if(blima tagexists("TAG_MAIN_ROTOR_BLADE_03"))
    blima hidepart("TAG_MAIN_ROTOR_BLADE_03");

  if(blima tagexists("TAG_MAIN_ROTOR_BLADE_04"))
    blima hidepart("TAG_MAIN_ROTOR_BLADE_04");
}

_id_D77872B5CE5F1B8D() {
  _id_50C3825142856FA3 = getEnt("weapon_loc_preview", "targetname");
  level.weapons[2].origin = _id_50C3825142856FA3.origin;
  level.weapons[2].angles = _id_50C3825142856FA3.angles;
}

getgunbenchents() {
  level.gunbenchbulletent = getEnt("gunbench_bullets", "targetname");
}

epictauntlistener() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, _id_635CB55857199A8D);

    if(_id_7148C1A6F25491F8 == "taunt_started") {
      scripts\mp\broshot_utilities::respawnclientcharacter();
      _id_AA58C038AB33E912 = tablelookup("mp/cac/taunts.csv", 0, _id_635CB55857199A8D, 9);
      scripts\mp\broshot_utilities::processepictaunt(_id_AA58C038AB33E912, -1, 0);
      continue;
    }

    if(_id_7148C1A6F25491F8 == "taunt_reset")
      scripts\mp\broshot_utilities::respawnclientcharacter();
  }
}

devui_bg_swap(_id_6AB3A5D1F0919FB7) {
  foreach(bg in level.ui_bg_images_2d)
  bg hide();

  if(_id_6AB3A5D1F0919FB7 > 0 && _id_6AB3A5D1F0919FB7 <= level.ui_bg_images_2d.size)
    level.ui_bg_images_2d[_id_6AB3A5D1F0919FB7] show();
}

_id_9617358B4B6D2F49(_id_DFC6EA0731CE082D, basecam, _id_2923F0B76C922C05) {
  _id_421CC4AC3EA9F7BC = _id_DFC6EA0731CE082D._id_421CC4AC3EA9F7BC;
  _id_4157BFF8ABDFDFB5 = _id_DFC6EA0731CE082D._id_4157BFF8ABDFDFB5;

  if(!isDefined(_id_421CC4AC3EA9F7BC))
    _id_421CC4AC3EA9F7BC = _id_2923F0B76C922C05[0];

  if(!isDefined(_id_4157BFF8ABDFDFB5))
    _id_4157BFF8ABDFDFB5 = _id_2923F0B76C922C05[1];

  basecam.depthoffieldvalues = [_id_421CC4AC3EA9F7BC, _id_4157BFF8ABDFDFB5];
}

_id_EB177A9F98C3A1B2(_id_DFC6EA0731CE082D, _id_0D5453091B27B7D5, _id_CC5465D66266758A) {
  if(isDefined(_id_DFC6EA0731CE082D)) {
    level._id_12BF4D83235579C7 = (0, 0, 0);
    level._id_A9BCD2E89CE17E89 = (0, 0, 0);
    _id_009CF03DEAF22281 = _id_DFC6EA0731CE082D._id_009CF03DEAF22281;
    _id_67EDC3A38BAA8EC6 = _id_DFC6EA0731CE082D._id_67EDC3A38BAA8EC6;
    _id_07A784DA1DB11223 = _id_DFC6EA0731CE082D._id_07A784DA1DB11223;
    _id_C43193EC5074C3FE = _id_DFC6EA0731CE082D._id_C43193EC5074C3FE;

    if(!isDefined(_id_009CF03DEAF22281))
      _id_009CF03DEAF22281 = 0;

    if(!isDefined(_id_67EDC3A38BAA8EC6))
      _id_67EDC3A38BAA8EC6 = 0;

    if(!isDefined(_id_07A784DA1DB11223))
      _id_07A784DA1DB11223 = 0;

    if(!isDefined(_id_C43193EC5074C3FE))
      _id_C43193EC5074C3FE = 0;

    if(_id_0D5453091B27B7D5 == 1) {
      level._id_5215FA2603C0CD47.basecam.origin = level._id_B76DAD29B681C12B + (_id_009CF03DEAF22281, _id_67EDC3A38BAA8EC6, _id_07A784DA1DB11223);
      level._id_5215FA2603C0CD47.basecam.angles = level._id_9B2E06D9573D88A5 + (_id_C43193EC5074C3FE, 0, 0);
      level.currentcamera = getEnt("cam_bp_character", "targetname");

      if(level.active_section.name == "battle_pass_character")
        level._id_3417AD63B8B9976B = 1;

      _id_9617358B4B6D2F49(_id_DFC6EA0731CE082D, level._id_5215FA2603C0CD47.basecam, level._id_CEC4CE34318C0C9A);
    } else if(_id_0D5453091B27B7D5 == 2) {
      level._id_EAD7DE7F41B832BC.basecam.origin = level._id_32991C40F6D4268A + (_id_009CF03DEAF22281, _id_67EDC3A38BAA8EC6, _id_07A784DA1DB11223);
      level._id_EAD7DE7F41B832BC.basecam.angles = level._id_37125601A51470C8 + (_id_C43193EC5074C3FE, 0, 0);
      level.currentcamera = getEnt("cam_bp_weapon", "targetname");
      _id_9617358B4B6D2F49(_id_DFC6EA0731CE082D, level._id_EAD7DE7F41B832BC.basecam, level._id_CC2BB7C6E61990D5);
    } else if(_id_0D5453091B27B7D5 == 3) {
      level._id_5DC4697427310378.basecam.origin = level._id_7526BC63841E8E7E + (_id_009CF03DEAF22281, _id_67EDC3A38BAA8EC6, _id_07A784DA1DB11223);
      level._id_5DC4697427310378.basecam.angles = level._id_5B29F35C02A41E14 + (_id_C43193EC5074C3FE, 0, 0);
      level.currentcamera = getEnt("cam_bp_vehicle", "targetname");
      _id_9617358B4B6D2F49(_id_DFC6EA0731CE082D, level._id_5DC4697427310378.basecam, level._id_7FAE4A98502EA9B1);
    } else if(_id_0D5453091B27B7D5 == 4) {
      level._id_E671031110AF7F94.basecam.origin = level._id_0346A5A00F79C082 + (_id_009CF03DEAF22281, _id_67EDC3A38BAA8EC6, _id_07A784DA1DB11223);
      level._id_E671031110AF7F94.basecam.angles = level._id_38BF9876723F7300 + (_id_C43193EC5074C3FE, 0, 0);
      level.currentcamera = getEnt("cam_bp_items", "targetname");
      _id_9617358B4B6D2F49(_id_DFC6EA0731CE082D, level._id_E671031110AF7F94.basecam, level._id_C039481874832D2D);
    }

    if(isDefined(_id_CC5465D66266758A))
      level._id_3417AD63B8B9976B = 1;

    setomnvar("ui_battlepass_camera_changed", level._id_DC3CDB43DF6E6607);
  }
}

_id_84EFD6C7DC93B161(_id_402BEAA866B682A2, _id_DFC6EA0731CE082D, _id_0D5453091B27B7D5, _id_3417AD63B8B9976B) {
  level endon("clear_camera_thread");
  camera_section_change(_id_402BEAA866B682A2);
  _id_EB177A9F98C3A1B2(_id_DFC6EA0731CE082D, _id_0D5453091B27B7D5, _id_3417AD63B8B9976B);
  camera_section_change(_id_402BEAA866B682A2);
}

luinotifylistener() {
  self endon("disconnect");
  getgunbenchents();
  level.currentdropcount = 0;

  for(;;) {
    self waittill("luinotifyserver", msg, _id_8B461603A1F825D3);

    if(isDefined(level._effect["vfx_frontend_store_operator_motes_med"]) && !isDefined(level._id_9DDF81B1164374D1)) {
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (1548.76, 2986.94, -27));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (1518.69, 3474.11, -24));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (1534.24, 3259.83, -25));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (1533.78, 3162.83, -26));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (-3000, 3000, -27));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (-3000, 3000, -24));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (-3000, 3000, -25));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (-3000, 3000, -26));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (2828.76, 2986.94, -27));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (2828.76, 3474.11, -24));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (2828.76, 3259.83, -25));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (2828.76, 3162.83, -26));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (4108.76, 2986.94, -27));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (4108.76, 3474.11, -24));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (4108.76, 3259.83, -25));
      playFX(scripts\engine\utility::getfx("vfx_frontend_store_operator_motes_med"), (4108.76, 3162.83, -26));
      level._id_9DDF81B1164374D1 = 1;
    }

    if(msg == "loadout_showcase_entered") {
      level.bulletsinitialstate = 1;
      level.currentdropcount = 0;
      level._id_2179AABA15B2D35E.origin = level._id_5AF5EF2A9A52F0CA;
      level._id_2179AABA15B2D35E.angles = level._id_96B8921FE92408F1;
      continue;
    }

    if(msg == "primary_weapon_changed") {
      _id_0FF5D8E52A29D498 = int(_id_8B461603A1F825D3);

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

    if(msg == "set_ui_rarity_image") {
      _id_BDA559AFC5BA9B52 = int(_id_8B461603A1F825D3);
      devui_bg_swap(_id_BDA559AFC5BA9B52);
      continue;
    }

    if(msg == "entered_firing_range_after_target_settings") {
      _id_10FD8ED3FED0E0AE = int(_id_8B461603A1F825D3);
      thread _id_62C9635E42F2735A::_id_7086103BDF1F2C05(_id_10FD8ED3FED0E0AE);
      _id_A2E4B36E61BB74E2();
      thread _id_62C9635E42F2735A::_id_0AD45F79E3A9B4D2(1);
      continue;
    }

    if(msg == "entered_firing_range_after_pause") {
      _id_A2E4B36E61BB74E2();
      thread _id_62C9635E42F2735A::_id_0AD45F79E3A9B4D2(1);
      continue;
    }

    if(msg == "entered_firing_range_pause_menu") {
      thread _id_62C9635E42F2735A::_id_02BEF3A70387BED5();
      continue;
    }

    if(msg == "entered_firing_range") {
      _id_A2E4B36E61BB74E2();
      thread _id_62C9635E42F2735A::_id_CB993EBADDA105C7();
      continue;
    }

    if(msg == "force_exit_firing_range") {
      thread _id_62C9635E42F2735A::_id_31C28009668DE7EC();
      continue;
    }

    if(msg == "switch_loadouts") {
      if(getomnvar("ui_firing_range_has_started") && istrue(self._id_19300A2D63D79909)) {
        _id_A2E4B36E61BB74E2();
        thread _id_62C9635E42F2735A::_id_0AD45F79E3A9B4D2(0);
      }

      thread _id_62C9635E42F2735A::_id_0A0C6C9F9A16B236();
      continue;
    }

    if(msg == "exit_firing_range") {
      thread _id_62C9635E42F2735A::_id_6DDBFA779DCE4B5D();
      _id_A3721E529C3182FF();
      continue;
    }

    if(msg == "restart_xcam_in_firing_range") {
      thread _id_62C9635E42F2735A::_id_A52F1E6528800C39();
      _id_A3721E529C3182FF();
      continue;
    }

    if(msg == "pre_match_making") {
      scripts\engine\utility::flag_clear("started_mm");

      if(!isDefined(level.active_scene_data))
        level waittill("finished_scene_change");

      level._id_A98D8246ED9C8B71 = "pre_match_making";
      _id_A3721E529C3182FF();
      continue;
    }

    if(msg == "match_making") {
      level._id_24E98E32C755AA54 = _func_538E92208B641725().size;
      level._id_A98D8246ED9C8B71 = "match_making";
      scripts\engine\utility::flag_set("started_mm");
      continue;
    }

    if(msg == "lobby_members_changed") {
      if(!istrue(level._id_56F2F3DF881EB8C7))
        level._id_013C94D72BBA10B4 = _id_8B461603A1F825D3;

      level._id_A98D8246ED9C8B71 = "lobby_member_increase";
      scripts\engine\utility::flag_set("lobby_member_increase");
      _id_0CA318DD2DE5793D = _func_CB66D1B49608D340();

      if(isDefined(_id_0CA318DD2DE5793D) && isDefined(level._id_D45FB3EE26047877["squad_lobby"]) && _id_0CA318DD2DE5793D.name == level._id_D45FB3EE26047877["squad_lobby"]["transitions"][2])
        _id_A3721E529C3182FF();

      continue;
    }

    if(msg == "crib_op_intro_anim") {
      if(_id_8B461603A1F825D3 >> 3) {
        if((_id_8B461603A1F825D3 & 2) == 0)
          level.characters[14].angles = (0, -153, 0);
        else
          level.characters[14].angles = (0, -126, 0);
      } else {
        level.characters[14].angles = (0, -139.143, 0);
        level._id_A5777679E8986406 = _id_8B461603A1F825D3 & 2;
        level._id_D5E742A25A53C1B3 = _id_8B461603A1F825D3 & 1;
        level._id_F750BD5E9C449424 = (_id_8B461603A1F825D3 & 2) >> 1;
      }

      continue;
    }

    if(msg == "streak_select_trigger") {
      if(_id_8B461603A1F825D3 == 1)
        _id_5AEA88C7C01479DB("fe_op_crib_xcam_killstreak_01_in_xcam", 0, 0.05, level._id_7FC91D1D11CD14DE);
      else
        _id_5AEA88C7C01479DB("fe_op_crib_xcam_killstreak_01_out_xcam", 0, 0.05, level._id_7FC91D1D11CD14DE);

      continue;
    }

    if(msg == "operator_store_preview") {
      if(isDefined(level._id_3455211A7FD01921)) {
        level._id_3455211A7FD01921 setModel("bp_diorama_background_simple_s2_v0");
        level._id_3455211A7FD01921.origin = level._id_A41E68B26A527A29;
      }

      _id_C052BF187F34990C = getEnt("shop_character_01", "targetname");

      if(_id_8B461603A1F825D3 == "default_vision_set")
        _id_FC0043E95242D5CB = "";
      else
        _id_FC0043E95242D5CB = _id_8B461603A1F825D3;

      level.playerviewowner visionsetnakedforplayer(_id_FC0043E95242D5CB, 0);
      level.characters[0].angles = _id_C052BF187F34990C.angles;
      level.characters[0].origin = _id_C052BF187F34990C.origin;
      continue;
    }

    if(msg == "update_operator_crib_vision") {
      if(_id_8B461603A1F825D3 == "default_vision_set")
        _id_FC0043E95242D5CB = "";
      else
        _id_FC0043E95242D5CB = _id_8B461603A1F825D3;

      level.playerviewowner visionsetnakedforplayer(_id_FC0043E95242D5CB, 0);
      continue;
    }

    if(msg == "update_weapon_store_background") {
      _id_434809FD34BABEE0 = strtok(_id_8B461603A1F825D3, ",");
      xoffset = int(_id_434809FD34BABEE0[0]);
      _id_23F43530281513A2 = int(_id_434809FD34BABEE0[1]);
      _id_7438B486C4B4B686 = int(_id_434809FD34BABEE0[2]);
      _id_7A327F18FD3B7A74 = (4103.15, 3095.33, 2);

      if(_id_23F43530281513A2 == 1) {
        if(!isDefined(level._id_7928769F15745242))
          level._id_7928769F15745242 = spawnfx(scripts\engine\utility::getfx("vfx_frontend_weapon_protune_aura"), _id_7A327F18FD3B7A74, (1, 0, 0), (0, -1, 0));
        else {
          level._id_7928769F15745242 delete();
          level._id_7928769F15745242 = spawnfx(scripts\engine\utility::getfx("vfx_frontend_weapon_protune_aura"), _id_7A327F18FD3B7A74, (1, 0, 0), (0, -1, 0));
        }

        triggerfx(level._id_7928769F15745242);
      } else if(isDefined(level._id_7928769F15745242))
        level._id_7928769F15745242 delete();

      if(_id_7438B486C4B4B686 == 1) {} else {}

      level._id_2179AABA15B2D35E setModel("bp_diorama_background_simple_s2_v0");
      level._id_2179AABA15B2D35E.origin = level._id_5AF5EF2A9A52F0CA;
      level._id_2179AABA15B2D35E.angles = level._id_96B8921FE92408F1;
      continue;
    }

    if(msg == "update_gunscreen_store_background") {
      level._id_2179AABA15B2D35E setModel("bp_diorama_background_simple_s2_v0");
      level._id_2179AABA15B2D35E.origin = (-3072, 3072, -50);
      level._id_2179AABA15B2D35E.angles = (0, 70, 0);
      continue;
    }

    if(msg == "remove_protuned_weapon_vfx") {
      if(isDefined(level._id_7928769F15745242))
        level._id_7928769F15745242 delete();

      continue;
    }

    if(msg == "swap_gun_foam") {
      _id_8B461603A1F825D3 = int(_id_8B461603A1F825D3);
      _id_9FE1BC92EC9FB00F = getdvarint("mgl", 0) > 0;

      if(_id_9FE1BC92EC9FB00F || !isDefined(_id_8B461603A1F825D3)) {
        return;
      }
      level._id_28C306C65EF1895F = getEnt("foam_large", "targetname");
      level._id_D55766761A712C2F = getEnt("foam_med", "targetname");
      level._id_6C24151F9005D287 = getEnt("foam_small", "targetname");

      if(_id_8B461603A1F825D3 == 3) {
        level._id_28C306C65EF1895F show();
        level._id_D55766761A712C2F hide();
        level._id_6C24151F9005D287 hide();
      } else if(_id_8B461603A1F825D3 == 2) {
        level._id_28C306C65EF1895F hide();
        level._id_D55766761A712C2F show();
        level._id_6C24151F9005D287 hide();
      } else if(_id_8B461603A1F825D3 == 1) {
        level._id_28C306C65EF1895F hide();
        level._id_D55766761A712C2F hide();
        level._id_6C24151F9005D287 show();
      }

      continue;
    }

    if(msg == "battlemap_sector_update") {
      level notify("clear_camera_thread");
      _id_434809FD34BABEE0 = strtok(_id_8B461603A1F825D3, "+");
      _id_21F8B99332BEED7B = _id_434809FD34BABEE0[0];
      _id_0D5453091B27B7D5 = int(_id_434809FD34BABEE0[1]);
      level._id_DC3CDB43DF6E6607 = -1;

      if(isDefined(level._id_3455211A7FD01921))
        level._id_3455211A7FD01921.origin = level._id_3455211A7FD01921.origin + (0, 0, -1000);

      _id_DFC6EA0731CE082D = getscriptbundle(_func_2EF675C13CA1C4AF("enum_6E3AA7AE38B4C049", _id_21F8B99332BEED7B));

      if(isDefined(_id_434809FD34BABEE0[3]))
        level._id_DC3CDB43DF6E6607 = int(_id_434809FD34BABEE0[3]);

      if(isDefined(_id_434809FD34BABEE0[2]) && _id_434809FD34BABEE0[2] != "none") {
        _id_402BEAA866B682A2 = spawnStruct();
        _id_402BEAA866B682A2.name = _id_434809FD34BABEE0[2];
        _id_402BEAA866B682A2.index = 0;
        level.active_section = _id_402BEAA866B682A2;
        setomnvar("frontend_weapon_position_updated", 0);
        setomnvar("frontend_screen_black", 0);
        thread _id_84EFD6C7DC93B161(_id_402BEAA866B682A2, _id_DFC6EA0731CE082D, _id_0D5453091B27B7D5, _id_434809FD34BABEE0[4]);
      } else
        thread _id_EB177A9F98C3A1B2(_id_DFC6EA0731CE082D, _id_0D5453091B27B7D5, _id_434809FD34BABEE0[4]);

      continue;
    }

    if(msg == "battlemap_sector_update_camera") {
      _id_A2E4B36E61BB74E2();

      if(!isDefined(_id_8B461603A1F825D3)) {
        return;
      }
      if(!isDefined(level.currentcamera)) {
        return;
      }
      _id_8B461603A1F825D3 = int(_id_8B461603A1F825D3);

      if(_id_8B461603A1F825D3 == 1)
        level._id_12BF4D83235579C7 = level._id_12BF4D83235579C7 + (1, 0, 0);
      else if(_id_8B461603A1F825D3 == 2)
        level._id_12BF4D83235579C7 = level._id_12BF4D83235579C7 + (-1, 0, 0);
      else if(_id_8B461603A1F825D3 == 3)
        level._id_12BF4D83235579C7 = level._id_12BF4D83235579C7 + (0, 1, 0);
      else if(_id_8B461603A1F825D3 == 4)
        level._id_12BF4D83235579C7 = level._id_12BF4D83235579C7 + (0, -1, 0);
      else if(_id_8B461603A1F825D3 == 5)
        level._id_12BF4D83235579C7 = level._id_12BF4D83235579C7 + (0, 0, 1);
      else if(_id_8B461603A1F825D3 == 6)
        level._id_12BF4D83235579C7 = level._id_12BF4D83235579C7 + (0, 0, -1);
      else if(_id_8B461603A1F825D3 == 7)
        level._id_A9BCD2E89CE17E89 = level._id_A9BCD2E89CE17E89 + (2, 0, 0);
      else if(_id_8B461603A1F825D3 == 8)
        level._id_A9BCD2E89CE17E89 = level._id_A9BCD2E89CE17E89 + (-2, 0, 0);
      else if(_id_8B461603A1F825D3 == 9) {
        _id_CB2EB4E646DAEF26 = level.active_camera.depthoffieldvalues[0] + 1;

        if(_id_CB2EB4E646DAEF26 <= 0)
          _id_CB2EB4E646DAEF26 = 0;

        level.active_camera.depthoffieldvalues[0] = _id_CB2EB4E646DAEF26;
        update_camera_depth_of_field();
      } else if(_id_8B461603A1F825D3 == 10) {
        _id_CB2EB4E646DAEF26 = level.active_camera.depthoffieldvalues[0] - 1;

        if(_id_CB2EB4E646DAEF26 <= 0)
          _id_CB2EB4E646DAEF26 = 0;

        level.active_camera.depthoffieldvalues[0] = _id_CB2EB4E646DAEF26;
        update_camera_depth_of_field();
      } else if(_id_8B461603A1F825D3 == 11) {
        level.active_camera.depthoffieldvalues[1] = level.active_camera.depthoffieldvalues[1] + 2;
        update_camera_depth_of_field();
      } else if(_id_8B461603A1F825D3 == 12) {
        level.active_camera.depthoffieldvalues[1] = level.active_camera.depthoffieldvalues[1] - 2;
        update_camera_depth_of_field();
      }

      _id_1D6E2F3EE504886B = spawnStruct();
      _id_1D6E2F3EE504886B.origin = level.currentcamera.origin + level._id_12BF4D83235579C7;
      _id_1D6E2F3EE504886B.angles = level.currentcamera.angles + level._id_A9BCD2E89CE17E89;
      camera_move_helper(_id_1D6E2F3EE504886B, 0, 0, 0, 0, 0);
      continue;
    }

    if(msg == "pass_store_weapon_update") {
      scripts\engine\utility::flag_set("force_weapon_update");
      continue;
    }

    _id_C07ED7A11BAAC844 = strtok(msg, ",");
    _id_10CDDAD370988C77 = _id_C07ED7A11BAAC844.size > 7;
    _id_27AF6391B2C24E9B = _id_C07ED7A11BAAC844[0] == "attach_zoom";
    _id_29FBC2CBB6C941EF = _id_C07ED7A11BAAC844[0] == "weapon_preview";

    if(_id_27AF6391B2C24E9B || _id_29FBC2CBB6C941EF)
      _id_DDB42D4450CAFE26 = _id_AEA02750A3AFF7BF(_id_C07ED7A11BAAC844, _id_29FBC2CBB6C941EF, level.active_section.name);
    else if(_id_10CDDAD370988C77)
      _id_DDB42D4450CAFE26 = _id_3C8D38B326A9C64F(_id_C07ED7A11BAAC844);
    else
      _id_DDB42D4450CAFE26 = _id_7273F375B5991C19(_id_C07ED7A11BAAC844);

    if(!isDefined(_id_DDB42D4450CAFE26)) {
      continue;
    }
    if(!isarray(_id_DDB42D4450CAFE26))
      _id_DDB42D4450CAFE26 = [_id_DDB42D4450CAFE26];

    if(_id_29FBC2CBB6C941EF) {
      foreach(index, struct in _id_DDB42D4450CAFE26) {
        if(struct.name == "tag_cosmetic")
          struct.angles = (10, 190, 30);

        if(struct.name == "tag_sticker" || struct.name == "tag_sticker_shotgun")
          struct.angles = (10, 190, 42);

        if(_id_21FD6D79CF32E1AC(struct.class))
          struct.angles = (0, 180, 0);

        offset = (0, 0, 0);

        if(isDefined(struct.weaponname) && _id_21FD6D79CF32E1AC(struct.class) && issubstr(struct.weaponname, "sword")) {
          offset = (-10, 0, 0);
          level._id_F8ADC014A1E45D3C = offset;
        }

        level._id_D45FB3EE26047877[struct.name]["transitions"] = [];
        level._id_D45FB3EE26047877[struct.name]["transitions"][0] = struct._id_6C9750573F9A9742;
        level._id_D45FB3EE26047877[struct.name]["xcam_data"] = spawnStruct();
        level._id_D45FB3EE26047877[struct.name]["xcam_data"].origin = struct.origin + offset;
        level._id_D45FB3EE26047877[struct.name]["xcam_data"].angles = struct.angles;
        _id_D180B535A33B044D = getdvarfloat("dvar_4773A268CB735013", 0.2);

        if(distancesquared(struct.origin, (-3072, 3072, 0)) < 10000) {
          level._id_F8ADC014A1E45D3C = undefined;
          level._id_7FC91D1D11CD14DE.origin = struct.origin + offset;
          level._id_7FC91D1D11CD14DE.angles = struct.angles;
          _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[struct.name]["transitions"][0], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);
        }
      }
    } else if(!_id_27AF6391B2C24E9B) {
      foreach(index, struct in _id_DDB42D4450CAFE26) {
        if(!_id_10CDDAD370988C77) {
          level._id_D45FB3EE26047877[struct.name]["transitions"] = [];
          level._id_D45FB3EE26047877[struct.name]["transitions"][0] = struct._id_6C9750573F9A9742;
          level._id_D45FB3EE26047877[struct.name]["xcam_data"] = spawnStruct();
          level._id_D45FB3EE26047877[struct.name]["xcam_data"].origin = struct.origin;
          level._id_D45FB3EE26047877[struct.name]["xcam_data"].angles = struct.angles;
          level._id_E4D4DCEF31A14DDE = 1;
          level._id_7FC91D1D11CD14DE.origin = struct.origin;
          level._id_7FC91D1D11CD14DE.angles = struct.angles;
          _id_D180B535A33B044D = getdvarfloat("dvar_4773A268CB735013", 0.2);
          _id_5AEA88C7C01479DB(level._id_D45FB3EE26047877[struct.name]["transitions"][0], 0, _id_D180B535A33B044D, level._id_7FC91D1D11CD14DE);
          continue;
        }

        if(isDefined(level._id_8D5E9FC8DDEF81A2[index]) && struct._id_6C9750573F9A9742 != level._id_8D5E9FC8DDEF81A2[index]) {
          level._id_D45FB3EE26047877[struct.name]["transitions"][0] = struct._id_6C9750573F9A9742;
          level._id_D45FB3EE26047877[struct.name]["xcam_data"].origin = struct.origin;

          if(index == 1) {
            level._id_D45FB3EE26047877["loadout_showcase_o"]["transitions"][0] = struct._id_6C9750573F9A9742;
            level._id_D45FB3EE26047877["loadout_showcase_o"]["xcam_data"].origin = struct.origin;
          }

          continue;
        }

        if(isDefined(struct.origin) && struct.origin != level._id_D45FB3EE26047877[struct.name]["xcam_data"].origin) {
          level._id_D45FB3EE26047877[struct.name]["xcam_data"].origin = struct.origin;

          if(index == 1)
            level._id_D45FB3EE26047877["loadout_showcase_o"]["xcam_data"].origin = struct.origin;
        }
      }

      if(_id_10CDDAD370988C77) {
        level._id_8D5E9FC8DDEF81A2[0] = _id_DDB42D4450CAFE26[0]._id_6C9750573F9A9742;
        level._id_8D5E9FC8DDEF81A2[1] = _id_DDB42D4450CAFE26[1]._id_6C9750573F9A9742;
      }
    } else {
      _id_EBFC572B07861F57 = _id_24EF280C015211C3(_id_C07ED7A11BAAC844);

      if(_id_EBFC572B07861F57 != "receiver") {
        continue;
      }
      if(istrue(level._id_9C1886877F0E84A1)) {
        scripts\engine\utility::flag_set("zoom_triggered");
        level._id_EBFC572B07861F57 = _id_EBFC572B07861F57;
        continue;
      }

      foreach(struct in _id_DDB42D4450CAFE26) {
        level._id_D45FB3EE26047877["loadout_showcase_preview"]["xcam_data"].origin = struct.origin;
        level._id_D45FB3EE26047877["loadout_showcase_preview"]["xcam_data"].angles = struct.angles;
        level._id_D45FB3EE26047877["loadout_showcase_preview_small"]["xcam_data"].origin = struct.origin;
        level._id_D45FB3EE26047877["loadout_showcase_preview_small"]["xcam_data"].angles = struct.angles;
        level._id_D45FB3EE26047877["loadout_showcase_preview_large"]["xcam_data"].origin = struct.origin;
        level._id_D45FB3EE26047877["loadout_showcase_preview_large"]["xcam_data"].angles = struct.angles;
        level._id_9C1886877F0E84A1 = 1;
        scripts\engine\utility::flag_set("force_weapon_update");
      }

      level._id_EBFC572B07861F57 = _id_EBFC572B07861F57;
      scripts\engine\utility::flag_set("zoom_triggered");
    }
  }
}

_id_80AC3E056BACBFCC(_id_0E25D1D189177A7C) {
  if(!isDefined(_id_0E25D1D189177A7C))
    return 0;

  return isDefined(_id_2D4A4197B801AD83(_id_0E25D1D189177A7C));
}

_id_4A669B7AD22042AD(_id_0E25D1D189177A7C) {
  if(!isDefined(_id_0E25D1D189177A7C))
    return 0;

  return issubstr(_id_0E25D1D189177A7C, "weapon_preview");
}

_id_F1D45199114730A5() {
  level._id_39E3BFC771325A76 = 0.0;

  foreach(tag in level._id_0E4B914D2CF9018D) {
    if(isDefined(level._id_D45FB3EE26047877) && isDefined(level._id_D45FB3EE26047877[tag]))
      level._id_D45FB3EE26047877[tag] = undefined;
  }
}

loadandplayholoeffect() {
  if(!isDefined(level.holoeffect)) {
    level.holoeffect = loadfx("vfx/iw8_mp/watches/vfx_mp_holo_watch");
    wait 1;
  }

  level.watchfx = spawnfx(level.holoeffect, level.weapons[3].origin);
  level.watchfx.angles = (221, -34.753, 181.997);
  level.watchfx.origin = level.watchfx.origin + (1, -0.66, 0.98);
  waitframe();
  triggerfx(level.watchfx);
}

updaterotatedebug() {
  for(;;) {
    if(getdvarint("dvar_0097E86D4661A38D", -1) != -1) {
      val = getdvarint("dvar_0097E86D4661A38D");
      moveeffect(val);
    }

    waitframe();
  }
}

moveeffect(val) {
  _id_D399A34C3799119C = 0;
  _id_D399A44C379913CF = 0;
  _id_D399A54C37991602 = 0;

  if(val == 1)
    _id_D399A34C3799119C = 0.1;

  if(val == 2)
    _id_D399A34C3799119C = -0.1;

  if(val == 3)
    _id_D399A44C379913CF = 0.1;

  if(val == 4)
    _id_D399A44C379913CF = -0.1;

  if(val == 5)
    _id_D399A54C37991602 = 0.1;

  if(val == 6)
    _id_D399A54C37991602 = -0.1;

  angle = level.watchfx.angles;
  _id_6C53D859D582A421 = level.watchfx.origin + (_id_D399A34C3799119C, _id_D399A44C379913CF, _id_D399A54C37991602);
  level.watchfx delete();
  level.watchfx = spawnfx(level.holoeffect, _id_6C53D859D582A421);
  level.watchfx.angles = angle;
  triggerfx(level.watchfx);
}

rotateeffect(val) {
  _id_D399A34C3799119C = 0;
  _id_D399A44C379913CF = 0;
  _id_D399A54C37991602 = 0;

  if(val == 1)
    _id_D399A34C3799119C = 10;

  if(val == 2)
    _id_D399A34C3799119C = -10;

  if(val == 3)
    _id_D399A44C379913CF = 10;

  if(val == 4)
    _id_D399A44C379913CF = -10;

  if(val == 5)
    _id_D399A54C37991602 = 10;

  if(val == 6)
    _id_D399A54C37991602 = -10;

  _id_B98CF035C97EDEE9 = level.watchfx.angles + (_id_D399A34C3799119C, _id_D399A44C379913CF, _id_D399A54C37991602);
  level.watchfx delete();
  level.watchfx = spawnfx(level.holoeffect, level.weapons[3].origin + (1, -0.66, 1.1));
  level.watchfx.angles = _id_B98CF035C97EDEE9;
  triggerfx(level.watchfx);
}

setup_rarity_ui_images() {
  level.ui_bg_images_2d = [];
  level.ui_bg_images_2d[1] = getEnt("weapRarity01", "targetname");
  level.ui_bg_images_2d[2] = getEnt("weapRarity02", "targetname");
  level.ui_bg_images_2d[3] = getEnt("weapRarity03", "targetname");
  level.ui_bg_images_2d[4] = getEnt("weapRarity04", "targetname");
  level.ui_bg_images_2d[5] = getEnt("weapRarity05", "targetname");
  level.raritycamsmall = scripts\engine\utility::getStruct("weapRaritySmall", "targetname");
  level.raritycammedium = scripts\engine\utility::getStruct("weapRarityMedium", "targetname");
  level.raritycamlarge = scripts\engine\utility::getStruct("weapRarityLarge", "targetname");
  level.raritycamwatch = scripts\engine\utility::getStruct("weapRarityWatch", "targetname");
  devui_bg_swap(0);
}

_id_32AB61259FD850EF() {
  if(!isDefined(level._id_F55444A6FD47E796))
    level._id_F55444A6FD47E796 = getDvar("frontEndFastfileName", "");

  return level._id_F55444A6FD47E796;
}