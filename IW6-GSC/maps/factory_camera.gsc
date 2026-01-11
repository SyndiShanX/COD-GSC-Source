/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_camera.gsc
*****************************************************/

sat_room_camera() {
  common_scripts\utility::flag_wait("start_camera_moment");
  level.player give_camera();
  thread sat_camera_monitor();
}

sat_camera_monitor() {
  thread maps\_utility::display_hint("camera_use");
  thread sat_nag_camera("camera_used");
  common_scripts\utility::flag_wait("player_using_camera");
  level notify("camera_used");
  setup_camera_feedback_system();
  common_scripts\utility::flag_wait("sat_begin_looking_for_B");
  level.player thread camera_disabled_nag();
  var_0 = getent("sat_target_B", "targetname");
  level.sat_current_target = var_0;
  level.player thread sat_camera_proximity_scan(var_0);
  level.player thread sat_camera_feedback(var_0);
  level.player sat_camera_found_target(var_0);
  common_scripts\utility::flag_set("cam_B_confirmed");
  level notify("stop_nag");
  wait 8.0;
  level.sat_current_target = undefined;
}

setup_camera_feedback_system() {
  level.sat_feedback_right = ["factory_hqr_abitmoreto", "factory_hqr_overtotheright"];
  level.sat_feedback_right_down = ["factory_hqr_itsdownandto", "factory_hqr_downandalittle"];
  level.sat_feedback_right_up = ["factory_hqr_lookupanda", "factory_hqr_upandright"];
  level.sat_feedback_left = ["factory_hqr_itstoyourleft", "factory_hqr_moretoyourleft"];
  level.sat_feedback_left_down = ["factory_hqr_lookalittlelower", "factory_hqr_belowthattothe"];
  level.sat_feedback_left_up = ["factory_hqr_itstoyourleft_2", "factory_hqr_leftandabovethat"];
  level.sat_feedback_down = ["factory_hqr_yourelookingtoohigh", "factory_hqr_downlower"];
  level.sat_feedback_up = ["factory_hqr_upabithigher", "factory_hqr_abovethat"];
  level.sat_feedback_behind = ["factory_hqr_turnarounditsbehind", "factory_hqr_icantseeit"];
  level.sat_feedback_rods = ["factory_hqr_lookfortherods", "factory_hqr_getoneofthe"];
  level.sat_feedback_found = ["factory_hqr_bingo", "factory_hqr_righttherethatsit"];
}

sat_camera_proximity_scan(var_0) {
  level endon("found_sat_target");

  for(;;) {
    var_1 = level.player getEye();
    var_2 = level.player getplayerangles();
    var_3 = vectornormalize(var_0.origin - var_1);
    var_4 = anglestoup(var_2);
    var_5 = anglestoright(level.player.angles);
    var_6 = anglesToForward(level.player.angles);
    self.cam_offsetright = vectordot(var_3, var_5);
    self.cam_offsetup = vectordot(var_3, var_4);
    self.cam_offsetforward = vectordot(var_3, var_6);
    wait 0.1;
  }
}

sat_camera_feedback(var_0) {
  level endon("found_sat_target");
  level.camera_feedback_active = 1;
  var_1 = 0.15;

  for(;;) {
    while(self.binoculars_active == 0) {
      wait 0.1;
    }

    if(self.cam_offsetforward <= -0.5) {
      sat_give_feedback(level.sat_feedback_behind);
    }
    else if(self.cam_offsetright >= var_1) {
      if(self.cam_offsetup <= -1 * var_1) {
        sat_give_feedback(level.sat_feedback_right_down);
      }
      else if(self.cam_offsetup >= var_1) {
        sat_give_feedback(level.sat_feedback_right_up);
      }
      else {
        sat_give_feedback(level.sat_feedback_right);
      }
    } else if(self.cam_offsetright <= -1 * var_1) {
      if(self.cam_offsetup <= -1 * var_1) {
        sat_give_feedback(level.sat_feedback_left_down);
      }
      else if(self.cam_offsetup >= var_1) {
        sat_give_feedback(level.sat_feedback_left_up);
      }
      else {
        sat_give_feedback(level.sat_feedback_left);
      }
    } else if(self.cam_offsetup <= -1 * var_1)
      sat_give_feedback(level.sat_feedback_down);
    else if(self.cam_offsetup >= var_1) {
      sat_give_feedback(level.sat_feedback_up);
    }

    wait(randomfloatrange(2.5, 4.0));
  }
}

sat_give_feedback(var_0) {
  var_1 = [];

  if(!common_scripts\utility::flag("cam_B_confirmed")) {
    var_1 = common_scripts\utility::array_combine(var_0, level.sat_feedback_rods);
    var_1 = common_scripts\utility::array_combine(var_0, var_1);
  }

  thread maps\_utility::smart_radio_dialogue(var_1[randomint(var_1.size)]);
}

sat_camera_found_target(var_0) {
  for(;;) {
    while(self.binoculars_active == 0) {
      wait 0.1;
    }

    var_1 = anglesToForward(self getplayerangles());
    self.binoculars_trace = bulletTrace(self getEye(), self getEye() + var_1 * 50000, 1, self, 1);

    if(isDefined(self.binoculars_trace["entity"]) && isDefined(self.binoculars_trace["entity"].targetname) && self.binoculars_trace["entity"].targetname == var_0.target) {
      thread maps\factory_audio::aud_binoculars_on_target();
      wait 0.75;

      if(!common_scripts\utility::flag("cam_B_confirmed")) {
        thread maps\_utility::smart_radio_dialogue_interrupt("factory_hqr_righttherethatsit");
      }

      level notify("found_sat_target");
      level.camera_feedback_active = 0;
      return;
    }

    wait 0.1;
  }
}

camera_activate_hint(var_0, var_1, var_2) {
  level endon("camera_used");

  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
  }

  wait(var_0);
  level.player thread maps\_utility::display_hint(var_1);

  for(;;) {
    wait 5.0;
    level.player thread maps\_utility::display_hint(var_1);
  }
}

intro_binoculars_hint(var_0, var_1, var_2, var_3) {
  level endon(var_3);

  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
  }

  wait(var_0);

  while(level.player.binoculars_active == 0) {
    common_scripts\utility::waitframe();
  }

  level.player thread maps\_utility::display_hint(var_1);

  for(;;) {
    wait 7.0;

    while(level.player.binoculars_active == 0) {
      common_scripts\utility::waitframe();
    }

    level.player thread maps\_utility::display_hint(var_1);
  }
}

camera_disabled_nag() {
  level endon("stop_nag");
  var_0 = 0;
  level.camera_feedback_active = 0;

  for(;;) {
    if(!self.binoculars_active && level.camera_feedback_active) {
      if(!var_0) {
        var_0 = 1;
        thread sat_nag_camera("player_using_camera");
        thread maps\_utility::display_hint("camera_use");
        wait 0.25;
      }
    }

    wait 0.1;
  }
}

sat_nag_camera(var_0) {
  var_1 = ["factory_mrk_adamuseyourcamera", "factory_mrk_adamgetanupload", "factory_mrk_adamwereona"];
  level.squad["ALLY_ALPHA"] thread maps\factory_util::nag_line_generator(var_1, var_0, undefined, 7);
}

binoculars_init(var_0) {
  precacheshader("cnd_binoculars_hud_id_box");
  precacheshader("overlay_static");
  precachemodel("tag_turret");
  precacheturret("player_view_controller_binoculars");
  precacheshader("fac_gfx_laser");
  precacheshader("fac_gfx_laser_light");
  precacheshader("fac_dpad_camera");
  precacheshader("fac_headcam_hud_center_01");
  precacheshader("fac_headcam_hud_corner_01");
  precacheshader("fac_headcam_hud_corner_02");
  precacheshader("fac_headcam_hud_corner_03");
  precacheshader("fac_headcam_hud_corner_04");
  precacheshader("fac_headcam_hud_focus_guides_01");
  precacheshader("fac_headcam_hud_focus_guides_02");
  precacheshader("fac_headcam_hud_rec_dot_01");
  level.default_visionset = var_0;
  precachestring(&"FACTORY_CAMERA_USE_HINT");
  precachestring(&"FACTORY_CAMERA_REMOVE_HINT");
  maps\_utility::add_hint_string("camera_use", &"FACTORY_CAMERA_USE_HINT", ::hint_camera_use_should_break);
  maps\_utility::add_hint_string("camera_deactivate", &"FACTORY_CAMERA_REMOVE_HINT");
}

hint_camera_use_should_break() {
  if(common_scripts\utility::flag("player_using_camera")) {
    return 1;
  }

  return 0;
}

give_camera() {
  if(!isDefined(self.has_binoculars) || !self.has_binoculars) {
    self.has_binoculars = 1;
    self.binoculars_active = 0;
    level.sat_lock_target = "sat_target_A";
    level.sat_current_target = undefined;
    self.default_fov = getdvarint("cg_fov");
    binoculars_set_default_zoom_level(0);
    binoculars_enable_zoom(1);
    thread binoculars_hud();
  }
}

take_binoculars() {
  self notify("stop_using_binoculars");
  self notify("take_binoculars");

  if(isDefined(self.binoculars_active) && self.binoculars_active) {
    binoculars_clear_hud();
  }

  self.has_binoculars = 0;
  common_scripts\utility::flag_clear("player_using_camera");
  self setmovespeedscale(1.0);
  self setweaponhudiconoverride("actionslot1", "none");
}

disable_camera() {
  level.player take_binoculars();
  self notify("stop_using_binoculars");
  common_scripts\utility::flag_clear("player_using_camera");
}

binoculars_set_default_zoom_level(var_0) {
  self.binoculars_default_zoom_level = var_0;
}

binoculars_set_vision_set(var_0) {
  self.binoculars_vision_set = var_0;

  if(isDefined(self.binoculars_active) && self.binoculars_active) {
    self visionsetnightforplayer(self.binoculars_vision_set, 5.0);
  }
}

binoculars_enable_zoom(var_0) {
  self.binoculars_zoom_enabled = var_0;

  if(isDefined(self.binoculars_active) && self.binoculars_active) {
    self.current_binocular_zoom_level = 0;
    binoculars_zoom();
  }
}

binoculars_hud() {
  self endon("take_binoculars");
  self setweaponhudiconoverride("actionslot1", "fac_dpad_camera");
  self notifyonplayercommand("use_binoculars", "+actionslot 1");
  self notifyonplayercommand("binocular_zoom", "+sprint_zoom");
  self notifyonplayercommand("binocular_zoom", "+melee_zoom");
  self notifyonplayercommand("fired_laser", "+frag");
  self.camera_hud_item = [];

  for(;;) {
    for(;;) {
      self waittill("use_binoculars", var_0);

      if(self isonground() && !self.active_anim || isDefined(var_0)) {
        break;
      }

      wait 0.1;
    }

    common_scripts\utility::flag_set("player_using_camera");
    binoculars_init_hud();
    wait 1.5;

    for(;;) {
      common_scripts\utility::waittill_either("use_binoculars", "stop_using_binoculars");

      if(!self.active_anim) {
        break;
      }

      wait 0.1;
    }

    self notify("stop_using_binoculars");
    common_scripts\utility::flag_clear("player_using_camera");
    binoculars_clear_hud();
    wait 1.5;
  }
}

binoculars_init_hud() {
  self endon("take_binoculars");
  self.binoculars_active = 1;
  common_scripts\utility::_disableoffhandweapons();
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("compass", 0);
  setsaveddvar("cg_drawCrosshair", 0);
  common_scripts\utility::_disableweapon();
  self allowmelee(0);
  thread zoom_lerp_dof();
  self.camera_hud_item["binocular_goggles"] = maps\_hud_util::create_client_overlay("nightvision_overlay_goggles", 1.0, self);
  self.camera_hud_item["hud_center"] = maps\_hud_util::createicon("fac_headcam_hud_center_01", 256, 256);
  self.camera_hud_item["hud_center"] set_default_hud_parameters();
  self.camera_hud_item["hud_center"].alignx = "center";
  self.camera_hud_item["hud_center"].aligny = "middle";
  self.camera_hud_item["hud_center"].alpha = 1.0;
  self.camera_hud_item["hud_rec_dot"] = maps\_hud_util::createicon("fac_headcam_hud_rec_dot_01", 32, 32);
  self.camera_hud_item["hud_rec_dot"] set_default_hud_parameters();
  self.camera_hud_item["hud_rec_dot"].alignx = "center";
  self.camera_hud_item["hud_rec_dot"].aligny = "middle";
  self.camera_hud_item["hud_rec_dot"].horzalign = "left";
  self.camera_hud_item["hud_rec_dot"].vertalign = "bottom";
  self.camera_hud_item["hud_rec_dot"].x = 24;
  self.camera_hud_item["hud_rec_dot"].y = -20;
  self.camera_hud_item["hud_rec_dot"].alpha = 1.0;
  self.camera_hud_item["hud_rec_dot"] thread sat_camera_rec_dot_flash(0.66);
  self.camera_hud_item["hud_corner_01"] = maps\_hud_util::createicon("fac_headcam_hud_corner_01", 128, 128);
  self.camera_hud_item["hud_corner_01"] set_default_hud_parameters();
  self.camera_hud_item["hud_corner_01"].alignx = "left";
  self.camera_hud_item["hud_corner_01"].aligny = "top";
  self.camera_hud_item["hud_corner_01"].horzalign = "left";
  self.camera_hud_item["hud_corner_01"].vertalign = "top";
  self.camera_hud_item["hud_corner_01"].alpha = 1.0;
  self.camera_hud_item["hud_corner_02"] = maps\_hud_util::createicon("fac_headcam_hud_corner_02", 128, 128);
  self.camera_hud_item["hud_corner_02"] set_default_hud_parameters();
  self.camera_hud_item["hud_corner_02"].alignx = "right";
  self.camera_hud_item["hud_corner_02"].aligny = "top";
  self.camera_hud_item["hud_corner_02"].horzalign = "right";
  self.camera_hud_item["hud_corner_02"].vertalign = "top";
  self.camera_hud_item["hud_corner_02"].alpha = 1.0;
  self.camera_hud_item["hud_corner_03"] = maps\_hud_util::createicon("fac_headcam_hud_corner_03", 128, 128);
  self.camera_hud_item["hud_corner_03"] set_default_hud_parameters();
  self.camera_hud_item["hud_corner_03"].alignx = "left";
  self.camera_hud_item["hud_corner_03"].aligny = "bottom";
  self.camera_hud_item["hud_corner_03"].horzalign = "left";
  self.camera_hud_item["hud_corner_03"].vertalign = "bottom";
  self.camera_hud_item["hud_corner_03"].alpha = 1.0;
  self.camera_hud_item["hud_corner_04"] = maps\_hud_util::createicon("fac_headcam_hud_corner_04", 128, 128);
  self.camera_hud_item["hud_corner_04"] set_default_hud_parameters();
  self.camera_hud_item["hud_corner_04"].alignx = "right";
  self.camera_hud_item["hud_corner_04"].aligny = "bottom";
  self.camera_hud_item["hud_corner_04"].horzalign = "right";
  self.camera_hud_item["hud_corner_04"].vertalign = "bottom";
  self.camera_hud_item["hud_corner_04"].alpha = 1.0;
  self.camera_hud_item["hud_focus_01"] = maps\_hud_util::createicon("fac_headcam_hud_focus_guides_02", 48, 48);
  self.camera_hud_item["hud_focus_01"] set_default_hud_parameters();
  self.camera_hud_item["hud_focus_01"].alignx = "center";
  self.camera_hud_item["hud_focus_01"].aligny = "middle";
  self.camera_hud_item["hud_focus_01"].x = 0;
  self.camera_hud_item["hud_focus_01"].y = 80;
  self.camera_hud_item["hud_focus_01"].alpha = 1.0;
  self.camera_hud_item["hud_focus_02"] = maps\_hud_util::createicon("fac_headcam_hud_focus_guides_02", 48, 48);
  self.camera_hud_item["hud_focus_02"] set_default_hud_parameters();
  self.camera_hud_item["hud_focus_02"].alignx = "center";
  self.camera_hud_item["hud_focus_02"].aligny = "middle";
  self.camera_hud_item["hud_focus_02"].x = 0;
  self.camera_hud_item["hud_focus_02"].y = -80;
  self.camera_hud_item["hud_focus_02"].alpha = 1.0;
  self.camera_hud_item["hud_focus_03"] = maps\_hud_util::createicon("fac_headcam_hud_focus_guides_01", 48, 48);
  self.camera_hud_item["hud_focus_03"] set_default_hud_parameters();
  self.camera_hud_item["hud_focus_03"].alignx = "center";
  self.camera_hud_item["hud_focus_03"].aligny = "middle";
  self.camera_hud_item["hud_focus_03"].x = 160;
  self.camera_hud_item["hud_focus_03"].y = 0;
  self.camera_hud_item["hud_focus_03"].alpha = 1.0;
  self.camera_hud_item["hud_focus_04"] = maps\_hud_util::createicon("fac_headcam_hud_focus_guides_01", 48, 48);
  self.camera_hud_item["hud_focus_04"] set_default_hud_parameters();
  self.camera_hud_item["hud_focus_04"].alignx = "center";
  self.camera_hud_item["hud_focus_04"].aligny = "middle";
  self.camera_hud_item["hud_focus_04"].x = -160;
  self.camera_hud_item["hud_focus_04"].y = 0;
  self.camera_hud_item["hud_focus_04"].alpha = 1.0;
  self.camera_hud_item["hud_focus_05"] = maps\_hud_util::createicon("fac_headcam_hud_focus_guides_01", 48, 48);
  self.camera_hud_item["hud_focus_05"] set_default_hud_parameters();
  self.camera_hud_item["hud_focus_05"].alignx = "center";
  self.camera_hud_item["hud_focus_05"].aligny = "middle";
  self.camera_hud_item["hud_focus_05"].x = 80;
  self.camera_hud_item["hud_focus_05"].y = 40;
  self.camera_hud_item["hud_focus_05"].alpha = 1.0;
  self.camera_hud_item["hud_focus_06"] = maps\_hud_util::createicon("fac_headcam_hud_focus_guides_01", 48, 48);
  self.camera_hud_item["hud_focus_06"] set_default_hud_parameters();
  self.camera_hud_item["hud_focus_06"].alignx = "center";
  self.camera_hud_item["hud_focus_06"].aligny = "middle";
  self.camera_hud_item["hud_focus_06"].x = -80;
  self.camera_hud_item["hud_focus_06"].y = 40;
  self.camera_hud_item["hud_focus_06"].alpha = 1.0;
  self.camera_hud_item["hud_focus_07"] = maps\_hud_util::createicon("fac_headcam_hud_focus_guides_01", 48, 48);
  self.camera_hud_item["hud_focus_07"] set_default_hud_parameters();
  self.camera_hud_item["hud_focus_07"].alignx = "center";
  self.camera_hud_item["hud_focus_07"].aligny = "middle";
  self.camera_hud_item["hud_focus_07"].x = 80;
  self.camera_hud_item["hud_focus_07"].y = -40;
  self.camera_hud_item["hud_focus_07"].alpha = 1.0;
  self.camera_hud_item["hud_focus_08"] = maps\_hud_util::createicon("fac_headcam_hud_focus_guides_01", 48, 48);
  self.camera_hud_item["hud_focus_08"] set_default_hud_parameters();
  self.camera_hud_item["hud_focus_08"].alignx = "center";
  self.camera_hud_item["hud_focus_08"].aligny = "middle";
  self.camera_hud_item["hud_focus_08"].x = -80;
  self.camera_hud_item["hud_focus_08"].y = -40;
  self.camera_hud_item["hud_focus_08"].alpha = 1.0;
  self.camera_hud_item["reticle_line_top"] = maps\_hud_util::createicon("white", 1, 8);
  self.camera_hud_item["reticle_line_top"].target_width = 1;
  self.camera_hud_item["reticle_line_top"].no_target_width = 1;
  self.camera_hud_item["reticle_line_top"].target_height = 32;
  self.camera_hud_item["reticle_line_top"].no_target_height = 32;
  self.camera_hud_item["reticle_line_top"].target_x = 0;
  self.camera_hud_item["reticle_line_top"].no_target_x = 0;
  self.camera_hud_item["reticle_line_top"].target_y = -16;
  self.camera_hud_item["reticle_line_top"].no_target_y = -16;
  self.camera_hud_item["reticle_line_top"] set_default_hud_parameters();
  self.camera_hud_item["reticle_line_top"].aligny = "bottom";
  self.camera_hud_item["reticle_line_top"].alpha = 0.0;
  self.camera_hud_item["reticle_line_top"].y = -27;
  self.camera_hud_item["reticle_line_bottom"] = maps\_hud_util::createicon("white", 1, 8);
  self.camera_hud_item["reticle_line_bottom"].target_width = 1;
  self.camera_hud_item["reticle_line_bottom"].no_target_width = 1;
  self.camera_hud_item["reticle_line_bottom"].target_height = 32;
  self.camera_hud_item["reticle_line_bottom"].no_target_height = 32;
  self.camera_hud_item["reticle_line_bottom"].target_x = 0;
  self.camera_hud_item["reticle_line_bottom"].no_target_x = 0;
  self.camera_hud_item["reticle_line_bottom"].target_y = 16;
  self.camera_hud_item["reticle_line_bottom"].no_target_y = 16;
  self.camera_hud_item["reticle_line_bottom"] set_default_hud_parameters();
  self.camera_hud_item["reticle_line_bottom"].aligny = "top";
  self.camera_hud_item["reticle_line_bottom"].alpha = 0.0;
  self.camera_hud_item["reticle_line_bottom"].y = 27;
  self.camera_hud_item["reticle_line_left"] = maps\_hud_util::createicon("white", 8, 1);
  self.camera_hud_item["reticle_line_left"].target_width = 32;
  self.camera_hud_item["reticle_line_left"].no_target_width = 32;
  self.camera_hud_item["reticle_line_left"].target_height = 1;
  self.camera_hud_item["reticle_line_left"].no_target_height = 1;
  self.camera_hud_item["reticle_line_left"].target_x = -16;
  self.camera_hud_item["reticle_line_left"].no_target_x = -50;
  self.camera_hud_item["reticle_line_left"].target_y = 0;
  self.camera_hud_item["reticle_line_left"].no_target_y = 0;
  self.camera_hud_item["reticle_line_left"] set_default_hud_parameters();
  self.camera_hud_item["reticle_line_left"].alignx = "right";
  self.camera_hud_item["reticle_line_left"].alpha = 0.0;
  self.camera_hud_item["reticle_line_left"].x = -27;
  self.camera_hud_item["reticle_line_right"] = maps\_hud_util::createicon("white", 8, 1);
  self.camera_hud_item["reticle_line_right"].target_width = 32;
  self.camera_hud_item["reticle_line_right"].no_target_width = 32;
  self.camera_hud_item["reticle_line_right"].target_height = 1;
  self.camera_hud_item["reticle_line_right"].no_target_height = 1;
  self.camera_hud_item["reticle_line_right"].target_x = 16;
  self.camera_hud_item["reticle_line_right"].no_target_x = 50;
  self.camera_hud_item["reticle_line_right"].target_y = 0;
  self.camera_hud_item["reticle_line_right"].no_target_y = 0;
  self.camera_hud_item["reticle_line_right"] set_default_hud_parameters();
  self.camera_hud_item["reticle_line_right"].alignx = "left";
  self.camera_hud_item["reticle_line_right"].alpha = 0.0;
  self.camera_hud_item["reticle_line_right"].x = 27;
  self.binocular_reticle_pieces = [];
  self.binocular_reticle_pieces[self.binocular_reticle_pieces.size] = self.camera_hud_item["reticle_line_top"];
  self.binocular_reticle_pieces[self.binocular_reticle_pieces.size] = self.camera_hud_item["reticle_line_bottom"];
  self.binocular_reticle_pieces[self.binocular_reticle_pieces.size] = self.camera_hud_item["reticle_line_left"];
  self.binocular_reticle_pieces[self.binocular_reticle_pieces.size] = self.camera_hud_item["reticle_line_right"];
  var_0 = -10;
  self.camera_hud_item["zoom_level_1"] = maps\_hud_util::createclientfontstring("default", 1.0);
  self.camera_hud_item["zoom_level_1"] set_default_hud_parameters();
  self.camera_hud_item["zoom_level_1"].alignx = "left";
  self.camera_hud_item["zoom_level_1"].aligny = "top";
  self.camera_hud_item["zoom_level_1"].horzalign = "right";
  self.camera_hud_item["zoom_level_1"].alpha = 1;
  self.camera_hud_item["zoom_level_1"].x = var_0 - 18;
  self.camera_hud_item["zoom_level_1"].y = -28;
  self.camera_hud_item["zoom_level_1"] settext("x1.0");
  self.camera_hud_item["zoom_level_15"] = maps\_hud_util::createclientfontstring("default", 1.0);
  self.camera_hud_item["zoom_level_15"] set_default_hud_parameters();
  self.camera_hud_item["zoom_level_15"].alignx = "left";
  self.camera_hud_item["zoom_level_15"].aligny = "top";
  self.camera_hud_item["zoom_level_15"].horzalign = "right";
  self.camera_hud_item["zoom_level_15"].alpha = 0.25;
  self.camera_hud_item["zoom_level_15"].x = var_0 - 18;
  self.camera_hud_item["zoom_level_15"].y = -5;
  self.camera_hud_item["zoom_level_15"] settext("x1.5");
  self.camera_hud_item["zoom_level_24"] = maps\_hud_util::createclientfontstring("default", 1.0);
  self.camera_hud_item["zoom_level_24"] set_default_hud_parameters();
  self.camera_hud_item["zoom_level_24"].alignx = "left";
  self.camera_hud_item["zoom_level_24"].aligny = "top";
  self.camera_hud_item["zoom_level_24"].horzalign = "right";
  self.camera_hud_item["zoom_level_24"].alpha = 0.25;
  self.camera_hud_item["zoom_level_24"].x = var_0 - 18;
  self.camera_hud_item["zoom_level_24"].y = 18;
  self.camera_hud_item["zoom_level_24"] settext("x2.4");
  self.camera_hud_item["zoom_level_background"] = maps\_hud_util::createicon("white", 20, self.camera_hud_item["zoom_level_24"].height * 5);
  self.camera_hud_item["zoom_level_background"] set_default_hud_parameters();
  self.camera_hud_item["zoom_level_background"].alignx = "left";
  self.camera_hud_item["zoom_level_background"].aligny = "middle";
  self.camera_hud_item["zoom_level_background"].horzalign = "right";
  self.camera_hud_item["zoom_level_background"].alpha = 0.1;
  self.camera_hud_item["zoom_level_background"].x = var_0 - self.camera_hud_item["zoom_level_background"].width;
  self.camera_hud_item["zoom_level_background"].sort = self.camera_hud_item["zoom_level_24"].sort - 1;
  self.camera_hud_item["top_bar"] = maps\_hud_util::createicon("white", 100, 16);
  self.camera_hud_item["top_bar"] set_default_hud_parameters();
  self.camera_hud_item["top_bar"].alignx = "center";
  self.camera_hud_item["top_bar"].aligny = "top";
  self.camera_hud_item["top_bar"].horzalign = "center";
  self.camera_hud_item["top_bar"].vertalign = "top";
  self.camera_hud_item["top_bar"].alpha = 0.1;
  self.camera_hud_item["top_bar"].sort = self.camera_hud_item["zoom_level_background"].sort - 1;
  maps\_utility::vision_set_fog_changes("factory_weapon_camera", 0.25);
  thread maps\factory_audio::aud_binoculars_vision_on();
  thread maps\factory_audio::aud_binoculars_bg_loop();
  thread binoculars_calculate_range();
  thread static_overlay();
  thread binoculars_monitor_scanning();
  thread monitor_binoculars_variable_zoom();
  thread binoculars_angles_display();
  thread setup_tagged_entities();
  thread sat_camera_reticule();
}

sat_camera_rec_dot_flash(var_0) {
  self endon("death");

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    self.alpha = 0.0;
    wait(var_0);

    if(!isDefined(self)) {
      return;
    }
    self.alpha = 1.0;
    wait(var_0);
  }
}

binoculars_clear_hud() {
  self.binoculars_active = 0;
  thread maps\factory_audio::aud_binoculars_vision_off();
  self notify("stop_binocular_bg_loop_sound");
  self notify("cancel_laser");
  thread static_overlay_off();
  thread zoom_lerp_dof();
  maps\_utility::vision_set_fog_changes("", 0.25);
  self allowmelee(1);
  common_scripts\utility::_enableoffhandweapons();
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("hud_showStance", 1);
  setsaveddvar("compass", 1);
  setsaveddvar("cg_drawCrosshair", 1);
  common_scripts\utility::_enableweapon();
  var_0 = getarraykeys(self.camera_hud_item);

  foreach(var_2 in var_0) {
    self.camera_hud_item[var_2] destroy();
    self.camera_hud_item[var_2] = undefined;
  }

  thread remove_tagged_entities();
  maps\_art::dof_disable_script(0.0);
  setsaveddvar("cg_fov", self.default_fov);
  self nightvisionviewoff();
}

binoculars_calculate_range() {
  self endon("stop_using_binoculars");
  self endon("binoculars_hud_off");
  self endon("take_binoculars");

  for(;;) {
    var_0 = anglesToForward(self getplayerangles());

    if(self islinked() && isDefined(self.linked_world_space_forward)) {
      var_0 = self.linked_world_space_forward;
    }

    for(self.binoculars_trace = bulletTrace(self getEye(), self getEye() + var_0 * 50000, 1, self, 1); isDefined(self.binoculars_trace["surfacetype"]) && self.binoculars_trace["surfacetype"] == "glass"; self.binoculars_trace = bulletTrace(self.binoculars_trace["position"] + var_0 * 20, self.binoculars_trace["position"] + var_0 * 50000, 1, self)) {}

    var_1 = distance(self getEye(), self.binoculars_trace["position"]);
    var_1 = var_1 * 0.0254;
    var_1 = int(var_1 * 100) * 0.01;
    wait 0.05;
  }
}

binoculars_lock_to_target(var_0) {
  if(!self islinked()) {
    self.binoculars_linked_to_target = 1;

    if(!isDefined(self.player_view_controller_model)) {
      self.player_view_controller_model = spawn("script_model", self.origin);
      self.player_view_controller_model setModel("tag_origin");
    }

    self.player_view_controller_model.origin = self.origin;
    self.player_view_controller_model.angles = self getplayerangles();

    if(!isDefined(self.player_view_controller)) {
      self.player_view_controller = maps\_utility::get_player_view_controller(self.player_view_controller_model, "tag_origin", (0, 0, 0), "player_view_controller_binoculars");
    }

    if(!isDefined(self.turret_look_at_ent)) {
      self.turret_look_at_ent = spawn("script_model", self.origin);
      self.turret_look_at_ent setModel("tag_origin");
    }

    self.turret_look_at_ent.origin = self.origin + anglesToForward(self getplayerangles()) * 1000;
    self.player_view_controller snaptotargetentity(self.turret_look_at_ent);
    self.prev_origin = self.origin;
    self playerlinktodelta(self.player_view_controller, "tag_aim", 0.0, 0, 0, 0, 0, 1);
    self.player_view_controller settargetentity(var_0, self.origin - self getEye());
  }
}

binoculars_unlock_from_target() {
  if(isDefined(self.binoculars_linked_to_target) && self.binoculars_linked_to_target) {
    self unlink();
    self.binoculars_linked_to_target = 0;

    if(isDefined(self.prev_origin)) {
      self setorigin(self.prev_origin);
      self.prev_origin = undefined;
    }

    if(isDefined(self.player_view_controller)) {
      self.player_view_controller delete();
      self.player_view_controller = undefined;
    }

    if(isDefined(self.player_view_controller_model)) {
      self.player_view_controller_model delete();
      self.player_view_controller_model = undefined;
    }

    if(isDefined(self.turret_look_at_ent)) {
      self.turret_look_at_ent delete();
      self.turret_look_at_ent = undefined;
    }
  }
}

binocular_face_scanning(var_0) {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self endon("stop_scanning");
  self endon("scanning_complete");
  self.camera_hud_item["profile"] = maps\_hud_util::createicon("white", 128, 128);
  self.camera_hud_item["profile"] set_default_hud_parameters();
  self.camera_hud_item["profile"].alignx = "left";
  self.camera_hud_item["profile"].aligny = "middle";
  self.camera_hud_item["profile"].horzalign = "left";
  self.camera_hud_item["profile"].vertalign = "middle";
  self.camera_hud_item["profile"].x = 0;
  self.camera_hud_item["profile"].y = 50;
  self.camera_hud_item["profile"].alpha = 0.9;
}

binocular_face_scanning_data() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self.camera_hud_item["profile_data_line_1"] = maps\_hud_util::createicon("white", self.camera_hud_item["profile"].width, 10);
  self.camera_hud_item["profile_data_line_1"] set_default_hud_parameters();
  self.camera_hud_item["profile_data_line_1"].alignx = "left";
  self.camera_hud_item["profile_data_line_1"].horzalign = "left";
  self.camera_hud_item["profile_data_line_1"].x = 0;
  self.camera_hud_item["profile_data_line_1"].y = 10 + self.camera_hud_item["profile"].y + self.camera_hud_item["profile"].height * 0.5;
  self.camera_hud_item["profile_data_line_1"].alpha = 0.25;
  self.camera_hud_item["profile_data_line_2"] = maps\_hud_util::createicon("white", self.camera_hud_item["profile"].width, 10);
  self.camera_hud_item["profile_data_line_2"] set_default_hud_parameters();
  self.camera_hud_item["profile_data_line_2"].alignx = "left";
  self.camera_hud_item["profile_data_line_2"].horzalign = "left";
  self.camera_hud_item["profile_data_line_2"].x = 0;
  self.camera_hud_item["profile_data_line_2"].y = self.camera_hud_item["profile_data_line_1"].y + self.camera_hud_item["profile_data_line_1"].height;
  self.camera_hud_item["profile_data_line_2"].alpha = 0.15;
  self.camera_hud_item["profile_data_line_3"] = maps\_hud_util::createicon("white", self.camera_hud_item["profile"].width, 10);
  self.camera_hud_item["profile_data_line_3"] set_default_hud_parameters();
  self.camera_hud_item["profile_data_line_3"].alignx = "left";
  self.camera_hud_item["profile_data_line_3"].horzalign = "left";
  self.camera_hud_item["profile_data_line_3"].x = 0;
  self.camera_hud_item["profile_data_line_3"].y = self.camera_hud_item["profile_data_line_2"].y + self.camera_hud_item["profile_data_line_2"].height;
  self.camera_hud_item["profile_data_line_3"].alpha = 0.25;
  self.camera_hud_item["profile_data_feed_1"] = maps\_hud_util::createclientfontstring("default", 0.6);
  self.camera_hud_item["profile_data_feed_1"] set_default_hud_parameters();
  self.camera_hud_item["profile_data_feed_1"].horzalign = "left";
  self.camera_hud_item["profile_data_feed_1"].x = self.camera_hud_item["profile_data_line_1"].x + 1;
  self.camera_hud_item["profile_data_feed_1"].y = self.camera_hud_item["profile_data_line_1"].y;
  self.camera_hud_item["profile_data_feed_1"].alpha = 0.75;
  self.camera_hud_item["profile_data_feed_1"].defaulttext = "FEED " + randomintrange(10, 99) + " -- ";
  self.camera_hud_item["profile_data_feed_2"] = maps\_hud_util::createclientfontstring("default", 0.6);
  self.camera_hud_item["profile_data_feed_2"] set_default_hud_parameters();
  self.camera_hud_item["profile_data_feed_2"].horzalign = "left";
  self.camera_hud_item["profile_data_feed_2"].x = int(self.camera_hud_item["profile_data_line_1"].width / 2) + 1;
  self.camera_hud_item["profile_data_feed_2"].y = self.camera_hud_item["profile_data_line_1"].y;
  self.camera_hud_item["profile_data_feed_2"].alpha = 0.75;
  self.camera_hud_item["profile_data_feed_2"].defaulttext = " FEED " + randomintrange(10, 99) + " -- ";
  self.camera_hud_item["profile_data_feed_3"] = maps\_hud_util::createclientfontstring("default", 0.6);
  self.camera_hud_item["profile_data_feed_3"] set_default_hud_parameters();
  self.camera_hud_item["profile_data_feed_3"].horzalign = "left";
  self.camera_hud_item["profile_data_feed_3"].x = self.camera_hud_item["profile_data_line_2"].x + 1;
  self.camera_hud_item["profile_data_feed_3"].y = self.camera_hud_item["profile_data_line_2"].y;
  self.camera_hud_item["profile_data_feed_3"].alpha = 0.75;
  self.camera_hud_item["profile_data_feed_3"].defaulttext = "FEED " + randomintrange(10, 99) + " -- ";
  self.camera_hud_item["profile_data_feed_4"] = maps\_hud_util::createclientfontstring("default", 0.6);
  self.camera_hud_item["profile_data_feed_4"] set_default_hud_parameters();
  self.camera_hud_item["profile_data_feed_4"].horzalign = "left";
  self.camera_hud_item["profile_data_feed_4"].x = int(self.camera_hud_item["profile_data_line_2"].width / 2) + 1;
  self.camera_hud_item["profile_data_feed_4"].y = self.camera_hud_item["profile_data_line_2"].y;
  self.camera_hud_item["profile_data_feed_4"].alpha = 0.75;
  self.camera_hud_item["profile_data_feed_4"].defaulttext = " FEED " + randomintrange(10, 99) + " -- ";
  self.camera_hud_item["profile_data_feed_5"] = maps\_hud_util::createclientfontstring("default", 0.6);
  self.camera_hud_item["profile_data_feed_5"] set_default_hud_parameters();
  self.camera_hud_item["profile_data_feed_5"].horzalign = "left";
  self.camera_hud_item["profile_data_feed_5"].x = self.camera_hud_item["profile_data_line_3"].x + 1;
  self.camera_hud_item["profile_data_feed_5"].y = self.camera_hud_item["profile_data_line_3"].y;
  self.camera_hud_item["profile_data_feed_5"].alpha = 0.75;
  self.camera_hud_item["profile_data_feed_5"].defaulttext = "FEED " + randomintrange(1, 100) + " -- ";
  self.camera_hud_item["profile_data_feed_6"] = maps\_hud_util::createclientfontstring("default", 0.6);
  self.camera_hud_item["profile_data_feed_6"] set_default_hud_parameters();
  self.camera_hud_item["profile_data_feed_6"].horzalign = "left";
  self.camera_hud_item["profile_data_feed_6"].x = int(self.camera_hud_item["profile_data_line_3"].width / 2) + 1;
  self.camera_hud_item["profile_data_feed_6"].y = self.camera_hud_item["profile_data_line_3"].y;
  self.camera_hud_item["profile_data_feed_6"].alpha = 0.75;
  self.camera_hud_item["profile_data_feed_6"].defaulttext = "FEED " + randomintrange(1, 100) + " -- ";
  self.camera_hud_item["upload_ellipsis_1"] = maps\_hud_util::createclientfontstring("default", 1.5);
  self.camera_hud_item["upload_ellipsis_1"] set_default_hud_parameters();
  self.camera_hud_item["upload_ellipsis_1"].alignx = "left";
  self.camera_hud_item["upload_ellipsis_1"].aligny = "bottom";
  self.camera_hud_item["upload_ellipsis_1"].horzalign = "left";
  self.camera_hud_item["upload_ellipsis_1"].x = 0;
  self.camera_hud_item["upload_ellipsis_1"].y = (self.camera_hud_item["profile"].height / 2 - self.camera_hud_item["profile"].y + 2) * -1;
  self.camera_hud_item["upload_ellipsis_1"].alpha = 0.9;
  self.camera_hud_item["upload_ellipsis_1"] settext(".");
  self.camera_hud_item["upload_ellipsis_2"] = maps\_hud_util::createclientfontstring("default", 1.5);
  self.camera_hud_item["upload_ellipsis_2"] set_default_hud_parameters();
  self.camera_hud_item["upload_ellipsis_2"].alignx = "left";
  self.camera_hud_item["upload_ellipsis_2"].aligny = "bottom";
  self.camera_hud_item["upload_ellipsis_2"].horzalign = "left";
  self.camera_hud_item["upload_ellipsis_2"].x = 0;
  self.camera_hud_item["upload_ellipsis_2"].y = (self.camera_hud_item["profile"].height / 2 - self.camera_hud_item["profile"].y + 2) * -1;
  self.camera_hud_item["upload_ellipsis_2"].alpha = 0.3;
  self.camera_hud_item["upload_ellipsis_2"] settext(".");
  self.camera_hud_item["upload_ellipsis_3"] = maps\_hud_util::createclientfontstring("default", 1.5);
  self.camera_hud_item["upload_ellipsis_3"] set_default_hud_parameters();
  self.camera_hud_item["upload_ellipsis_3"].alignx = "left";
  self.camera_hud_item["upload_ellipsis_3"].aligny = "bottom";
  self.camera_hud_item["upload_ellipsis_3"].horzalign = "left";
  self.camera_hud_item["upload_ellipsis_3"].x = 0;
  self.camera_hud_item["upload_ellipsis_3"].y = (self.camera_hud_item["profile"].height / 2 - self.camera_hud_item["profile"].y + 2) * -1;
  self.camera_hud_item["upload_ellipsis_3"].alpha = 0.6;
  self.camera_hud_item["upload_ellipsis_3"] settext(".");
  self.camera_hud_item["secure"] = maps\_hud_util::createclientfontstring("default", 1.0);
  self.camera_hud_item["secure"] set_default_hud_parameters();
  self.camera_hud_item["secure"].horzalign = "left";
  self.camera_hud_item["secure"].x = 0;
  self.camera_hud_item["secure"].y = self.camera_hud_item["profile_data_line_3"].y + self.camera_hud_item["profile_data_line_3"].height;
  self.camera_hud_item["secure"].alpha = 0.75;
  self.camera_hud_item["secure"] settext("SECURE");
  var_0 = 1;
  var_1 = 0;
  var_2 = self.binoculars_scan_time / 5;
  var_3 = 0.0;
  var_4 = [];
  var_4[var_4.size] = self.camera_hud_item["profile_data_feed_1"];
  var_4[var_4.size] = self.camera_hud_item["profile_data_feed_2"];
  var_4[var_4.size] = self.camera_hud_item["profile_data_feed_3"];
  var_4[var_4.size] = self.camera_hud_item["profile_data_feed_4"];
  var_4[var_4.size] = self.camera_hud_item["profile_data_feed_5"];

  for(var_4[var_4.size] = self.camera_hud_item["profile_data_feed_6"]; !self.binoculars_scanning_complete && !self.binoculars_stop_scanning; var_1 = !var_1) {
    if(var_1) {
      var_0 = var_0 + 1;

      if(var_0 > 3) {
        var_0 = 1;
      }

      switch (var_0) {
        case 1:
          self.camera_hud_item["upload_ellipsis_1"].alpha = 0.9;
          self.camera_hud_item["upload_ellipsis_2"].alpha = 0.3;
          self.camera_hud_item["upload_ellipsis_3"].alpha = 0.6;
          break;
        case 2:
          self.camera_hud_item["upload_ellipsis_1"].alpha = 0.6;
          self.camera_hud_item["upload_ellipsis_2"].alpha = 0.9;
          self.camera_hud_item["upload_ellipsis_3"].alpha = 0.3;
          break;
        case 3:
          self.camera_hud_item["upload_ellipsis_1"].alpha = 0.3;
          self.camera_hud_item["upload_ellipsis_2"].alpha = 0.6;
          self.camera_hud_item["upload_ellipsis_3"].alpha = 0.9;
          break;
      }
    }

    if(var_3 > var_2 && var_4.size > 1) {
      var_3 = 0.0;
      var_4[0].alpha = 1.0;
      var_4 = maps\_utility::array_remove_index(var_4, 0);
    }

    foreach(var_6 in var_4) {
    var_6 settext(var_6.defaulttext + int(randomfloatrange(0.0, 10000) * 100000) / 100000);
    }

    wait 0.05;
    var_3 = var_3 + 0.05;
  }

  if(!self.binoculars_stop_scanning) {
    self.camera_hud_item["upload_ellipsis_1"].alpha = 0.0;
    self.camera_hud_item["upload_ellipsis_2"].alpha = 0.0;
    self.camera_hud_item["upload_ellipsis_3"].alpha = 0.0;
    self waittill("stop_scanning");
  }

  self.camera_hud_item["profile_data_line_1"] destroy();
  self.camera_hud_item["profile_data_line_1"] = undefined;
  self.camera_hud_item["profile_data_line_2"] destroy();
  self.camera_hud_item["profile_data_line_2"] = undefined;
  self.camera_hud_item["profile_data_line_3"] destroy();
  self.camera_hud_item["profile_data_line_3"] = undefined;
  self.camera_hud_item["profile_data_feed_1"] destroy();
  self.camera_hud_item["profile_data_feed_1"] = undefined;
  self.camera_hud_item["profile_data_feed_2"] destroy();
  self.camera_hud_item["profile_data_feed_2"] = undefined;
  self.camera_hud_item["profile_data_feed_3"] destroy();
  self.camera_hud_item["profile_data_feed_3"] = undefined;
  self.camera_hud_item["profile_data_feed_4"] destroy();
  self.camera_hud_item["profile_data_feed_4"] = undefined;
  self.camera_hud_item["profile_data_feed_5"] destroy();
  self.camera_hud_item["profile_data_feed_5"] = undefined;
  self.camera_hud_item["profile_data_feed_6"] destroy();
  self.camera_hud_item["profile_data_feed_6"] = undefined;
  self.camera_hud_item["upload_ellipsis_1"] destroy();
  self.camera_hud_item["upload_ellipsis_1"] = undefined;
  self.camera_hud_item["upload_ellipsis_2"] destroy();
  self.camera_hud_item["upload_ellipsis_2"] = undefined;
  self.camera_hud_item["upload_ellipsis_3"] destroy();
  self.camera_hud_item["upload_ellipsis_3"] = undefined;
  self.camera_hud_item["secure"] destroy();
  self.camera_hud_item["secure"] = undefined;
}

binoculars_monitor_scanning() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self notifyonplayercommand("scanning", "+attack");
  self notifyonplayercommand("stop_scanning", "-attack");

  for(;;) {
    self waittill("scanning");
    var_0 = 1;

    if(var_0 && common_scripts\utility::flag("sat_allow_scan")) {
      var_1 = getent(level.sat_lock_target, "targetname");
      thread binoculars_lock_to_target(var_1);
      self notify("scanning_target");

      if(!self attackbuttonpressed()) {
        self notify("stop_binocular_flash");
        binoculars_unlock_from_target();
        continue;
      }

      self.binoculars_scanning_complete = 0;
      self.binoculars_stop_scanning = 0;
      thread maps\factory_audio::aud_binoculars_scan_loop();
      thread binocular_face_scanning(var_1);
      self.camera_hud_item["uploading_bar"] = maps\_hud_util::createicon("white", 1, 8);
      self.camera_hud_item["uploading_bar"] set_default_hud_parameters();
      self.camera_hud_item["uploading_bar"].aligny = "bottom";
      self.camera_hud_item["uploading_bar"].horzalign = "left";
      self.camera_hud_item["uploading_bar"].x = 0;
      self.camera_hud_item["uploading_bar"].y = self.camera_hud_item["profile"].height - 5;
      self.camera_hud_item["uploading_bar"].alpha = 0.9;
      self.binoculars_scan_time = 2.0;
      thread binocular_face_scanning_data();
      self.camera_hud_item["recognition_system"].alpha = 1.0;
      var_2 = 0.0;

      while(self attackbuttonpressed() && var_2 < self.binoculars_scan_time) {
        var_2 = var_2 + 0.05;
        wait 0.05;
        self.camera_hud_item["uploading_bar"] setshader("white", int(var_2 / 2.0 * (self.camera_hud_item["profile"].width - 3)), 8);
      }

      if(var_2 >= 1.0) {
        self notify("scanning_complete");
        self.binoculars_scanning_complete = 1;

        while(self attackbuttonpressed() && var_2 < 1.5) {
          var_2 = var_2 + 0.05;
          wait 0.05;
        }
      }

      self notify("stop_binocular_scan_loop_sound");

      if(var_2 >= 1.5) {
        switch (level.sat_lock_target) {
          case "sat_target_A":
            common_scripts\utility::flag_set("cam_A_scanned");
            level.sat_lock_target = "sat_target_B";
            break;
          case "sat_target_B":
            level notify("stop_nag");
            common_scripts\utility::flag_set("cam_B_scanned");
            break;
          default:
            break;
        }

        thread maps\factory_audio::aud_binoculars_scan_positive();
        self.camera_hud_item["id_confirmed"] = maps\_hud_util::createclientfontstring("default", 1.25);
        self.camera_hud_item["id_confirmed"] set_default_hud_parameters();
        self.camera_hud_item["id_confirmed"].aligny = "middle";
        self.camera_hud_item["id_confirmed"].horzalign = "left";
        self.camera_hud_item["id_confirmed"].x = self.camera_hud_item["profile"].x + self.camera_hud_item["profile"].width + 1;
        self.camera_hud_item["id_confirmed"].y = self.camera_hud_item["profile"].y;
        self.camera_hud_item["id_confirmed"].alpha = 0.9;
        self.camera_hud_item["id_confirmed"] settext("Payload Confirmed");
        self notify("stop_binocular_flash");

        while(self attackbuttonpressed()) {
          wait 0.05;
        }

        if(isDefined(self.camera_hud_item["id_confirmed"])) {
          self.camera_hud_item["id_confirmed"] destroy();
          self.camera_hud_item["id_confirmed"] = undefined;
        }

        if(isDefined(self.camera_hud_item["incomplete_data"])) {
          self.camera_hud_item["incomplete_data"] destroy();
          self.camera_hud_item["incomplete_data"] = undefined;
        }

        if(isDefined(self.camera_hud_item["unknown"])) {
          self.camera_hud_item["unknown"] destroy();
          self.camera_hud_item["unknown"] = undefined;
        }

        if(isDefined(self.camera_hud_item["match_percent"])) {
          self.camera_hud_item["match_percent"] destroy();
          self.camera_hud_item["match_percent"] = undefined;
        }
      } else
        thread maps\factory_audio::aud_binoculars_scan_negative();

      self.binoculars_stop_scanning = 1;
      self.camera_hud_item["recognition_system"].alpha = 0.25;
      self.camera_hud_item["uploading_bar"] destroy();
      self.camera_hud_item["uploading_bar"] = undefined;
      self.camera_hud_item["profile"] destroy();
      self.camera_hud_item["profile"] = undefined;
      binoculars_unlock_from_target();
      wait 0.2;
    }
  }
}

static_overlay() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self.camera_hud_item["static"] = newclienthudelem(self);
  self.camera_hud_item["static"].x = 0;
  self.camera_hud_item["static"].y = 0;
  self.camera_hud_item["static"].alignx = "left";
  self.camera_hud_item["static"].aligny = "top";
  self.camera_hud_item["static"].horzalign = "fullscreen";
  self.camera_hud_item["static"].vertalign = "fullscreen";
  self.camera_hud_item["static"] setshader("overlay_static", 640, 480);
  self.camera_hud_item["static"].alpha = 0.75;
  self.camera_hud_item["static"].sort = -3;
  self.camera_hud_item["static"] fadeovertime(0.05);
  self.camera_hud_item["static"].alpha = 0.9;
  wait 0.05;
  self.camera_hud_item["static"] fadeovertime(0.15);
  self.camera_hud_item["static"].alpha = 0.0;
  wait 0.15;
  self.camera_hud_item["static"] destroy();
  self.camera_hud_item["static"] = undefined;
}

static_overlay_off() {
  self endon("player_using_camera");
  self.static_overlay = newclienthudelem(self);
  self.static_overlay.x = 0;
  self.static_overlay.y = 0;
  self.static_overlay.alignx = "left";
  self.static_overlay.aligny = "top";
  self.static_overlay.horzalign = "fullscreen";
  self.static_overlay.vertalign = "fullscreen";
  self.static_overlay setshader("overlay_static", 640, 480);
  self.static_overlay.alpha = 0.75;
  self.static_overlay.sort = -3;
  self.static_overlay fadeovertime(0.05);
  self.static_overlay.alpha = 0.9;
  wait 0.05;
  self.static_overlay fadeovertime(0.05);
  self.static_overlay.alpha = 0.0;
  wait 0.05;
  self.static_overlay destroy();
  self.static_overlay = undefined;
}

monitor_binoculars_variable_zoom() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self.current_binocular_zoom_level = self.binoculars_default_zoom_level;
  self.binocular_zoom_levels = 3;
  self.first_zoom_level_fov = 4;
  binoculars_zoom();

  for(;;) {
    self waittill("binocular_zoom");
    level notify("binocular_zoom");

    if(self.binoculars_zoom_enabled && !self attackbuttonpressed()) {
      self.binocular_zooming = 1;
      self.current_binocular_zoom_level++;

      if(self.current_binocular_zoom_level >= self.binocular_zoom_levels) {
        self.current_binocular_zoom_level = 0;
        thread maps\factory_audio::aud_binoculars_zoom_out();
      } else
        thread maps\factory_audio::aud_binoculars_zoom_in();

      foreach(var_1 in self.binocular_reticle_pieces) {
      var_1.alpha = 1.0;
      }

      wait 0.15;
      binoculars_zoom();

      if(self.current_binocular_zoom_level < 3) {
        thread zoom_lerp_dof();
      }

      if(isDefined(self.binoculars_trace["entity"]) && isai(self.binoculars_trace["entity"]) && self.binoculars_trace["entity"] isbadguy()) {
        foreach(var_1 in self.binocular_reticle_pieces) {
        var_1.alpha = 1.0;
        }
      } else {
        foreach(var_1 in self.binocular_reticle_pieces) {
        var_1.alpha = 0.0;
        }
      }

      wait 0.1;
      self.binocular_zooming = 0;
    }
  }
}

binoculars_zoom() {
  switch (self.current_binocular_zoom_level) {
    case 0:
      self.camera_hud_item["zoom_level_1"].alpha = 1.0;
      self.camera_hud_item["zoom_level_24"].alpha = 0.25;
      break;
    case 1:
      self.camera_hud_item["zoom_level_15"].alpha = 1.0;
      self.camera_hud_item["zoom_level_1"].alpha = 0.25;
      break;
    case 2:
      self.camera_hud_item["zoom_level_24"].alpha = 1.0;
      self.camera_hud_item["zoom_level_15"].alpha = 0.25;
      break;
  }

  if(self.current_binocular_zoom_level == 0) {
    setsaveddvar("cg_fov", 65);
  }
  else if(self.current_binocular_zoom_level == 1) {
    setsaveddvar("cg_fov", 43);
  }
  else if(self.current_binocular_zoom_level == 2) {
    setsaveddvar("cg_fov", 27);
  }
}

zoom_lerp_dof() {
  self notify("binoculars_lerp_dof");
  self endon("binoculars_lerp_dof");
  maps\_art::dof_enable_script(50, 100, 10, 100, 200, 6, 0.0);
  maps\_art::dof_disable_script(0.5);
}

binoculars_angles_display() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self.camera_hud_item["angles"] = maps\_hud_util::createclientfontstring("default", 1.25);
  self.camera_hud_item["angles"].x = 0;
  self.camera_hud_item["angles"].y = 0;
  self.camera_hud_item["angles"].alignx = "center";
  self.camera_hud_item["angles"].aligny = "top";
  self.camera_hud_item["angles"].horzalign = "center";
  self.camera_hud_item["angles"].vertalign = "top";
  self.camera_hud_item["angles"].color = (1, 1, 1);
  self.camera_hud_item["angles"].alpha = 1.0;
  self.camera_hud_item["heading"] = maps\_hud_util::createclientfontstring("default", 1.25);
  self.camera_hud_item["heading"].x = 0;
  self.camera_hud_item["heading"].y = self.camera_hud_item["angles"].height * 1.1;
  self.camera_hud_item["heading"].alignx = "center";
  self.camera_hud_item["heading"].aligny = "top";
  self.camera_hud_item["heading"].horzalign = "center";
  self.camera_hud_item["heading"].vertalign = "top";
  self.camera_hud_item["heading"].color = (1, 1, 1);
  self.camera_hud_item["heading"].alpha = 1.0;
  var_0 = getnorthyaw();

  for(;;) {
    var_1 = abs(angleclamp(0 - self getplayerangles()[1]) - var_0);
    var_2 = (var_1 - int(var_1)) * 60.0;
    var_3 = (var_2 - int(var_2)) * 60.0;
    var_4 = "" + int(var_2);

    if(var_2 < 10) {
      var_4 = "0" + int(var_2);
    }

    var_5 = "" + int(var_3);

    if(var_3 < 10) {
      var_5 = "0" + int(var_3);
    }

    self.camera_hud_item["angles"] settext(int(var_1) + "" + var_4 + "' " + var_5 + "\"");

    if(var_1 > 337.5 || var_1 < 22.5) {
      self.camera_hud_item["heading"] settext("N");
    }
    else if(var_1 < 67.5) {
      self.camera_hud_item["heading"] settext("NE");
    }
    else if(var_1 < 112.5) {
      self.camera_hud_item["heading"] settext("E");
    }
    else if(var_1 < 157.5) {
      self.camera_hud_item["heading"] settext("SE");
    }
    else if(var_1 < 202.5) {
      self.camera_hud_item["heading"] settext("S");
    }
    else if(var_1 < 247.5) {
      self.camera_hud_item["heading"] settext("SW");
    }
    else if(var_1 < 292.5) {
      self.camera_hud_item["heading"] settext("W");
    }
    else {
      self.camera_hud_item["heading"] settext("NW");
    }

    wait 0.05;
  }
}

sat_camera_reticule() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  var_0 = 0;

  while(!common_scripts\utility::flag("cam_B_confirmed")) {
    if(isDefined(level.sat_current_target)) {
      if(isDefined(self.binoculars_trace["entity"]) && isDefined(self.binoculars_trace["entity"].targetname) && self.binoculars_trace["entity"].targetname == level.sat_current_target.target) {
        var_0 = 1;
      }
      else {
        var_0 = 0;
      }
    } else
      var_0 = 0;

    wait 0.1;
  }
}

setup_tagged_entities() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  level.tag_nodes = [];
  var_0 = [];

  if(!common_scripts\utility::flag("cam_B_confirmed")) {
    level waittill("found_sat_target");
    var_0 = [];
    var_0[var_0.size] = getent("satellite_ROG_01", "targetname");
    var_0[var_0.size] = getent("satellite_ROG_02", "targetname");
    var_0[var_0.size] = getent("satellite_ROG_03", "targetname");
    var_0[var_0.size] = getent("satellite_ROG_04", "targetname");
    var_0[var_0.size] = getent("satellite_ROG_05", "targetname");
    var_0[var_0.size] = getent("satellite_ROG_06", "targetname");

    foreach(var_3, var_2 in var_0) {
      var_2 thread add_tag(35);
      wait(randomfloatrange(0.01, 0.22));
    }
  }
}

add_tag(var_0) {
  setsaveddvar("r_hudoutlineenable", 1);
  self hudoutlineenable(5, 0);
  level.tag_nodes = common_scripts\utility::array_add(level.tag_nodes, self);
}

remove_tagged_entities() {
  self hudoutlinedisable();
  setsaveddvar("r_hudoutlineenable", 0);

  if(isDefined(level.tag_nodes) && level.tag_nodes.size != 0) {
    foreach(var_1 in level.tag_nodes) {
      if(target_istarget(var_1)) {
        target_remove(var_1);
      }
    }
  }
}

set_default_hud_parameters() {
  self.alignx = "left";
  self.aligny = "top";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.hidewhendead = 0;
  self.hidewheninmenu = 0;
  self.sort = 205;
  self.foreground = 1;
  self.alpha = 0.65;
}

game_is_pc() {
  if(level.xenon) {
    return 0;
  }

  if(level.ps3) {
    return 0;
  }

  if(level.ps4) {
    return 0;
  }

  if(level.xb3) {
    return 0;
  }

  return 1;
}