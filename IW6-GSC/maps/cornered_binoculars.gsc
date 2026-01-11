/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_binoculars.gsc
****************************************/

binoculars_init(var_0) {
  precacheshader("cnd_face_recog_border_01");
  precacheshader("cnd_binocs_hud_photo_001");
  precacheshader("cnd_binocs_hud_photo_002");
  precacheshader("cnd_binocs_hud_photo_003");
  precacheshader("cnd_binocs_hud_photo_004");
  precacheshader("cnd_binocs_hud_photo_005");
  precacheshader("cnd_binocs_hud_photo_006");
  precacheshader("cnd_binocs_hud_photo_007");
  precacheshader("cnd_binocs_hud_photo_008");
  precacheshader("cnd_binocs_hud_photo_009");
  precacheshader("cnd_binocs_hud_photo_010");
  precacheshader("cnd_binocs_hud_photo_011");
  precacheshader("cnd_binocs_hud_photo_012");
  precacheshader("overlay_static");
  precacheshader("white");
  precacheshader("red_block");
  precacheshader("cnd_face_recog_reticle_01");
  precacheshader("cnd_face_recog_reticle_02");
  precacheshader("cnd_face_recog_reticle_03");
  precacheshader("cnd_face_recog_reticle_03a");
  precacheshader("cnd_face_recog_reticle_data_base");
  precacheshader("cnd_face_recog_reticle_id");
  precacheshader("cnd_face_recog_frame_01");
  precachemodel("soccer_ball_static");
  precachemodel("tag_turret");
  precachemodel("cnd_facial_rcg_01");
  precachemodel("cnd_facial_rcg_02");
  precachemodel("cnd_facial_rcg_03");
  precachemodel("cnd_facial_rcg_01_non_hvt");
  precachemodel("cnd_facial_rcg_02_non_hvt");
  precachemodel("cnd_facial_rcg_03_non_hvt");
  precacheturret("player_view_controller_binoculars");
  precacheitem("binoculars_tech");
  precacheshader("hud_icon_scan_binocs");
  precacheshader("pip_scene_overlay");
  precachestring(&"CORNERED_READY");
  precachestring(&"CORNERED_NO");
  precachestring(&"CORNERED_MATCH");
  precachestring(&"CORNERED_DATA");
  precachestring(&"CORNERED_SCANNING_DOT");
  precachestring(&"CORNERED_SCANNING_DOT_DOT");
  precachestring(&"CORNERED_SCANNING_DOT_DOT_DOT");
  precachestring(&"CORNERED_IDENTIFIED");
  common_scripts\utility::flag_init("scan_target_not_facing");
  common_scripts\utility::flag_init("hvt_confirmed");
  level.default_visionset = var_0;
  self.binocular_profile_materials = [];
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_001";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_002";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_003";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_004";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_005";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_006";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_007";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_008";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_009";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_010";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_011";
  self.binocular_profile_materials[self.binocular_profile_materials.size] = "cnd_binocs_hud_photo_012";
  self.binocular_body_features_left = [];
  self.binocular_body_features_left[self.binocular_body_features_left.size] = "J_Hip_LE";
  self.binocular_body_features_left[self.binocular_body_features_left.size] = "J_Wrist_LE";
  self.binocular_body_features_left[self.binocular_body_features_left.size] = "J_Elbow_LE";
  self.binocular_body_features_right = [];
  self.binocular_body_features_right[self.binocular_body_features_right.size] = "J_Hip_RI";
  self.binocular_body_features_right[self.binocular_body_features_right.size] = "J_Wrist_RI";
  self.binocular_body_features_right[self.binocular_body_features_right.size] = "J_Elbow_RI";
  self.binoculars_linked_to_target = 0;
  binoculars_pip_init();
}

give_binoculars() {
  if(isDefined(self.has_binoculars) && self.has_binoculars) {
    return;
  }
  self.has_binoculars = 1;
  self.binoculars_active = 0;
  self.show_binoc_scan_hint = 1;
  self.default_fov = getdvarint("cg_fov");
  binoculars_set_default_zoom_level(0);
  binoculars_set_vision_set("cornered_binoculars");
  thread binoculars_hud();
}

take_binoculars() {
  if(isDefined(self.has_binoculars) && !self.has_binoculars) {
    return;
  }
  self.has_binoculars = 0;
  self.show_binoc_scan_hint = undefined;

  while(isDefined(self.binoculars_clearing_hud) && self.binoculars_clearing_hud) {
    wait 0.05;
  }

  self notify("stop_using_binoculars");
  self notify("take_binoculars");

  if(isDefined(self.binoculars_active) && self.binoculars_active) {
    if(self hasweapon("binoculars_tech")) {
      self takeweapon("binoculars_tech");
    }

    binoculars_clear_hud();
  }

  self setweaponhudiconoverride("actionslot1", "none");
}

binoculars_set_default_zoom_level(var_0) {
  self.binoculars_default_zoom_level = var_0;
}

binoculars_set_vision_set(var_0) {
  self.binoculars_vision_set = var_0;

  if(isDefined(self.binoculars_active) && self.binoculars_active) {
    self visionsetnakedforplayer(self.binoculars_vision_set, 5.0);
  }
}

binoculars_hud() {
  self endon("take_binoculars");
  self notifyonplayercommand("use_binoculars", "+actionslot 1");
  self notifyonplayercommand("binocular_zoom", "+sprint_zoom");
  self notifyonplayercommand("binocular_zoom", "+melee_zoom");
  self setweaponhudiconoverride("actionslot1", "hud_icon_scan_binocs");
  self.binoculars_hud_item = [];

  for(;;) {
    self waittill("use_binoculars");
    self.last_weapon = self getcurrentprimaryweapon();
    self giveweapon("binoculars_tech");
    self switchtoweapon("binoculars_tech");
    common_scripts\utility::_disableweaponswitch();
    self playSound("item_nightvision_on");
    binoculars_init_hud();
    wait 0.9;
    common_scripts\utility::_disableweapon();
    self takeweapon("binoculars_tech");
    common_scripts\utility::waittill_either("use_binoculars", "stop_using_binoculars");

    if(isDefined(self.binoculars_zooming) && self.binoculars_zooming) {
      self waittill("binoculars_done_zooming");
    }

    self notify("stop_using_binoculars");
    level notify("stop_allies_kill_tagged_enemies_without_player_watcher");
    level notify("stop_allies_kill_tagged_enemies_watcher");
    binoculars_clear_hud();
  }
}

binoculars_init_hud() {
  self endon("take_binoculars");
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("hud_showStance", "0");
  setsaveddvar("cg_drawCrosshair", 0);
  self notify("binoculars_init_hud");
  self allowmelee(0);
  self.binocular_target = spawn("script_model", self getorigin());
  self.binocular_target setModel("soccer_ball_static");
  self.binocular_target hide();
  self.binocular_target notsolid();
  target_set(self.binocular_target);
  target_hidefromplayer(self.binocular_target, self);
  self.binoculars_active = 1;
  thread zoom_lerp_dof();
  self.binoculars_hud_item["binocular_border"] = maps\_hud_util::create_client_overlay("cnd_face_recog_border_01", 1, self);
  self.binoculars_hud_item["binocular_frame"] = maps\_hud_util::create_client_overlay("cnd_face_recog_frame_01", 0.66, self);
  self.binoculars_hud_item["reticle"] = maps\_hud_util::createicon("cnd_face_recog_reticle_01", 16, 16);
  self.binoculars_hud_item["reticle"] set_default_hud_parameters();
  self.binoculars_hud_item["reticle"].alignx = "center";
  self.binoculars_hud_item["reticle"].aligny = "middle";
  self.binoculars_hud_item["reticle"].alpha = 0.66;
  self.binoculars_hud_item["reticle_targetting"] = maps\_hud_util::createicon("cnd_face_recog_reticle_02", 60, 60);
  self.binoculars_hud_item["reticle_targetting"] set_default_hud_parameters();
  self.binoculars_hud_item["reticle_targetting"].alignx = "center";
  self.binoculars_hud_item["reticle_targetting"].aligny = "middle";
  self.binoculars_hud_item["reticle_targetting"].alpha = 0.0;
  self.binocular_reticle_target = spawn("script_origin", self.origin);
  self.binoculars_hud_item["reticle_targetting"] settargetent(self.binocular_reticle_target);
  self.binoculars_hud_item["reticle_targetting"] setwaypoint(1, 0);
  self.binoculars_hud_item["reticle_scanning"] = maps\_hud_util::createicon("cnd_face_recog_reticle_03", 300, 300);
  self.binoculars_hud_item["reticle_scanning"] set_default_hud_parameters();
  self.binoculars_hud_item["reticle_scanning"].alignx = "center";
  self.binoculars_hud_item["reticle_scanning"].aligny = "middle";
  self.binoculars_hud_item["reticle_scanning"].alpha = 0.0;
  self.binoculars_hud_item["reticle_scanning_frame"] = maps\_hud_util::createicon("cnd_face_recog_reticle_03a", 300, 300);
  self.binoculars_hud_item["reticle_scanning_frame"] set_default_hud_parameters();
  self.binoculars_hud_item["reticle_scanning_frame"].alignx = "left";
  self.binoculars_hud_item["reticle_scanning_frame"].aligny = "middle";
  self.binoculars_hud_item["reticle_scanning_frame"].x = -2;
  self.binoculars_hud_item["reticle_scanning_frame"].y = -40;
  self.binoculars_hud_item["reticle_scanning_frame"].alpha = 0.0;
  self.binoculars_hud_item["reticle_scanning_status"] = maps\_hud_util::createclientfontstring("small", 1.3);
  self.binoculars_hud_item["reticle_scanning_status"].x = 9;
  self.binoculars_hud_item["reticle_scanning_status"].y = -150;
  self.binoculars_hud_item["reticle_scanning_status"].alignx = "left";
  self.binoculars_hud_item["reticle_scanning_status"].aligny = "middle";
  self.binoculars_hud_item["reticle_scanning_status"].horzalign = "center";
  self.binoculars_hud_item["reticle_scanning_status"].vertalign = "middle";
  self.binoculars_hud_item["reticle_scanning_status"].color = (1, 1, 1);
  self.binoculars_hud_item["reticle_scanning_status"].alpha = 0.0;
  self.binoculars_hud_item["reticle_scanning_status"].sort = self.binoculars_hud_item["reticle_scanning_frame"].sort + 10;
  self.binoculars_hud_item["reticle_scanning_status"] settext(&"CORNERED_READY");

  if(isDefined(self.binoculars_vision_set)) {
    self visionsetnakedforplayer(self.binoculars_vision_set, 0.0);
  }

  thread maps\cornered_audio::aud_binoculars("on");
  thread maps\cornered_audio::aud_binoculars("bg_loop");
  thread binoculars_calculate_range();
  thread static_overlay();
  thread monitor_binoculars_zoom();
  thread binoculars_angles_display();
  thread binocular_reticle_target_reaction();
  thread binoculars_scan_for_targets();
  thread binoculars_zoom_display();
  thread binoculars_monitor_scanning();
}

binoculars_clear_hud() {
  if(isDefined(self.binoculars_zooming) && self.binoculars_zooming) {
    self waittill("binoculars_done_zooming");
  }

  thread maps\cornered_audio::aud_binoculars("off");
  self notify("stop_binocular_bg_loop_sound");
  self.binoculars_clearing_hud = 1;
  binoculars_unlock_from_target();
  self.binoculars_active = 0;
  self playSound("item_nightvision_off");
  static_overlay();
  self allowmelee(1);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("hud_showStance", "1");
  setsaveddvar("cg_drawCrosshair", 1);
  common_scripts\utility::_enableweapon();
  common_scripts\utility::_enableweaponswitch();
  self switchtoweapon(self.last_weapon);
  var_0 = getarraykeys(self.binoculars_hud_item);

  foreach(var_2 in var_0) {
    self.binoculars_hud_item[var_2] destroy();
    self.binoculars_hud_item[var_2] = undefined;
  }

  if(isDefined(self.binoculars_face_scanning_models)) {
    foreach(var_5 in self.binoculars_face_scanning_models) {
      foreach(var_7 in var_5) {
        var_7 delete();
      }
    }

    self.binoculars_face_scanning_models = undefined;
  }

  foreach(var_11 in target_getarray()) {
    target_remove(var_11);
  }

  self.binocular_target delete();
  self.binocular_target = undefined;
  self.blend_struct = undefined;
  maps\_art::dof_disable_script(0.0);
  setsaveddvar("cg_fov", self.default_fov);
  self disableslowaim();

  if(isDefined(self.binoculars_vision_set)) {
    self visionsetnakedforplayer(level.default_visionset, 0.0);
  }

  self.binoculars_clearing_hud = 0;
}

binoculars_scan_for_targets() {
  self endon("stop_using_binoculars");
  self endon("binoculars_hud_off");
  self endon("take_binoculars");
  var_0 = 0;
  self.binoculars_scan_target = undefined;

  for(;;) {
    if(self.current_binocular_zoom_level == 1 && !self.binocular_zooming && !self.binoculars_linked_to_target) {
      if(isDefined(self.binoculars_trace["entity"]) && isai(self.binoculars_trace["entity"]) && self.binoculars_trace["entity"] isbadguy() && bullettracepassed(self getEye(), self.binoculars_trace["entity"] gettagorigin("J_Head"), 0, undefined)) {
        var_0 = 1;

        if(!isDefined(self.binoculars_scan_target) || self.binoculars_scan_target != self.binoculars_trace["entity"]) {
          thread binoculars_scan_target_points(self.binoculars_trace["entity"]);
        }
      }
    }

    if(!var_0) {
      self.binoculars_scan_target = undefined;
      self notify("end_scan_target_points");
      self.binoculars_hud_item["reticle_targetting"].alpha = 0.0;

      if(self.binocular_reticle_target islinked()) {
        self.binocular_reticle_target unlink();
      }

      self enableslowaim(0.5, 0.3);
    }

    var_0 = 0;
    wait 0.05;
  }
}

binoculars_scan_target_points(var_0) {
  self endon("stop_using_binoculars");
  self endon("binoculars_hud_off");
  self endon("take_binoculars");
  self notify("end_scan_target_points");
  self endon("end_scan_target_points");
  self enableslowaim(0.35, 0.1);
  self.binoculars_scan_target = var_0;

  if(self.binocular_reticle_target islinked()) {
    self.binocular_reticle_target unlink();
  }

  thread maps\cornered_audio::aud_binoculars("seeker_on");
  self.binocular_reticle_target.origin = var_0 gettagorigin("J_Head") - (0, 0, 7);
  self.binocular_reticle_target linkto(var_0, "J_Head");
  setsaveddvar("waypointIconHeight", 36);
  setsaveddvar("waypointIconWidth", 36);
  wait 0.05;
  self.binoculars_hud_item["reticle_targetting"].alpha = 1.0;
}

binoculars_reticle_lerp_to_tag(var_0, var_1, var_2) {
  self endon("stop_using_binoculars");
  self endon("binoculars_hud_off");
  self endon("take_binoculars");
  var_3 = var_2 / 0.05;
  var_4 = self.binocular_reticle_target.origin;

  for(var_5 = 1; var_5 <= var_3; var_5++) {
    self.binocular_reticle_target.origin = var_4 + (var_0 gettagorigin(var_1) - var_4 - (0, 0, 7)) * (var_5 / var_3);
    wait 0.05;
  }
}

binoculars_calculate_range() {
  self endon("stop_using_binoculars");
  self endon("binoculars_hud_off");
  self endon("take_binoculars");
  self.binoculars_hud_item["range"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.binoculars_hud_item["range"].x = 75;
  self.binoculars_hud_item["range"].y = -25;
  self.binoculars_hud_item["range"].alignx = "right";
  self.binoculars_hud_item["range"].aligny = "top";
  self.binoculars_hud_item["range"].horzalign = "center";
  self.binoculars_hud_item["range"].vertalign = "top";
  self.binoculars_hud_item["range"].color = (1, 1, 1);
  self.binoculars_hud_item["range"].alpha = 1.0;
  self.binoculars_hud_item["range"].glowcolor = (1, 1, 1);
  self.binoculars_hud_item["range"].glowalpha = 0.0;

  for(;;) {
    var_0 = anglesToForward(self getplayerangles());

    if(self islinked() && isDefined(self.linked_world_space_forward)) {
      var_0 = self.linked_world_space_forward;
    }

    self.binoculars_trace = bulletTrace(self getEye(), self getEye() + var_0 * 50000, 1, self, 1, 1);
    var_1 = distance(self getEye(), self.binoculars_trace["position"]);
    var_1 = var_1 * 0.0254;
    var_1 = int(var_1 * 100) * 0.01;

    if(var_1 > 1000.0) {
      self.binoculars_hud_item["range"] settext("1000+ M");
    } else if(var_1 - int(var_1) == 0.0) {
      self.binoculars_hud_item["range"] settext(var_1 + ".00 M");
    } else if(var_1 * 10 - int(var_1 * 10) == 0.0) {
      self.binoculars_hud_item["range"] settext(var_1 + "0 M");
    } else {
      self.binoculars_hud_item["range"] settext(var_1 + " M");
    }

    wait 0.05;
  }
}

binoculars_remove_target_on_death(var_0) {
  self notify("end_remove_target_on_death");
  self endon("end_remove_target_on_death");
  self endon("stop_using_binoculars");
  self endon("binoculars_hud_off");
  self endon("take_binoculars");
  var_0 waittill("death");

  if(isDefined(self.binocular_target) && target_istarget(self.binocular_target)) {
    target_hidefromplayer(self.binocular_target, self);
  }
}

binoculars_lock_to_target(var_0) {
  self endon("stop_using_binoculars");
  self endon("binoculars_hud_off");
  self endon("take_binoculars");

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
    self playerlinktoabsolute(self.player_view_controller, "tag_aim");
    self.player_view_controller settargetentity(self.binocular_target, self.origin - self getEye());
    self.binoculars_hud_item["reticle"].alpha = 0.0;
    self.binoculars_hud_item["reticle_targetting"].alpha = 0.0;
    self.binoculars_hud_item["reticle_scanning"].alpha = 1.0;
    self.binoculars_hud_item["reticle_scanning_frame"].alpha = 1.0;
    self.binoculars_hud_item["reticle_scanning_status"].alpha = 1.0;
    binoculars_pip_enable();
    var_1 = 0;

    while(self.binoculars_linked_to_target && var_1 < 0.5) {
      self.player_view_controller settargetentity(self.binocular_target, self.origin - self getEye());
      var_1 = var_1 + 0.05;
      wait 0.05;
    }
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

    self.binoculars_hud_item["reticle"].alpha = 0.66;
    self.binoculars_hud_item["reticle_targetting"].alpha = 0.0;
    self.binoculars_hud_item["reticle_scanning"].alpha = 0.0;
    self.binoculars_hud_item["reticle_scanning_frame"].alpha = 0.0;
    self.binoculars_hud_item["reticle_scanning_status"].alpha = 0.0;
    binoculars_pip_disable();
  }
}

binocular_status_update(var_0, var_1) {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self notify("binoculars_status_updated");
  self endon("binoculars_status_updated");

  if(isDefined(var_1) && var_1) {
    var_2 = 1;
    var_3 = 1;

    for(;;) {
      switch (var_2) {
        case 1:
          var_0 = &"CORNERED_SCANNING_DOT";
          break;
        case 2:
          var_0 = &"CORNERED_SCANNING_DOT_DOT";
          break;
        case 3:
          var_0 = &"CORNERED_SCANNING_DOT_DOT_DOT";
          break;
      }

      self.binoculars_hud_item["reticle_scanning_status"] settext(var_0);
      var_2 = var_2 + var_3;

      if(var_2 > 3 || var_2 < 1) {
        var_2 = 2;
        var_3 = var_3 * -1;
      }

      wait 0.15;
    }
  } else
    self.binoculars_hud_item["reticle_scanning_status"] settext(var_0);
}

binocular_face_scanning(var_0) {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self endon("stop_scanning");
  self endon("scanning_complete");
  self.binoculars_hud_item["profile"] = maps\_hud_util::createicon(self.binocular_profile_materials[0], 70, 70);
  self.binoculars_hud_item["profile"] set_default_hud_parameters();
  self.binoculars_hud_item["profile"].alignx = "left";
  self.binoculars_hud_item["profile"].aligny = "top";
  self.binoculars_hud_item["profile"].horzalign = "center";
  self.binoculars_hud_item["profile"].vertalign = "middle";
  self.binoculars_hud_item["profile"].x = 142;
  self.binoculars_hud_item["profile"].y = -137;
  self.binoculars_hud_item["profile"].alpha = 0.9;
  self.binoculars_hud_item["profile"].sort = self.binoculars_hud_item["reticle_scanning_frame"].sort + 1;
  self.binoculars_hud_item["no"] = maps\_hud_util::createclientfontstring("small", 1.3);
  self.binoculars_hud_item["no"].x = 178;
  self.binoculars_hud_item["no"].y = -107;
  self.binoculars_hud_item["no"].alignx = "center";
  self.binoculars_hud_item["no"].aligny = "middle";
  self.binoculars_hud_item["no"].horzalign = "center";
  self.binoculars_hud_item["no"].vertalign = "middle";
  self.binoculars_hud_item["no"].color = (1, 1, 1);
  self.binoculars_hud_item["no"].alpha = 0.0;
  self.binoculars_hud_item["no"].sort = self.binoculars_hud_item["reticle_scanning_frame"].sort + 10;
  self.binoculars_hud_item["no"] settext(&"CORNERED_NO");
  self.binoculars_hud_item["data"] = maps\_hud_util::createclientfontstring("small", 1.3);
  self.binoculars_hud_item["data"].x = 178;
  self.binoculars_hud_item["data"].y = -95;
  self.binoculars_hud_item["data"].alignx = "center";
  self.binoculars_hud_item["data"].aligny = "middle";
  self.binoculars_hud_item["data"].horzalign = "center";
  self.binoculars_hud_item["data"].vertalign = "middle";
  self.binoculars_hud_item["data"].color = (1, 1, 1);
  self.binoculars_hud_item["data"].alpha = 0.0;
  self.binoculars_hud_item["data"].sort = self.binoculars_hud_item["reticle_scanning_frame"].sort + 10;
  self.binoculars_hud_item["data"] settext(&"CORNERED_DATA");

  for(;;) {
    self.binocular_profile_materials = common_scripts\utility::array_randomize(self.binocular_profile_materials);

    foreach(var_2 in self.binocular_profile_materials) {
      if(!common_scripts\utility::flag("scan_target_not_facing")) {
        if(isDefined(var_0.binocular_facial_profile) && var_0.binocular_facial_profile == var_2) {
          continue;
        }
        self.binoculars_hud_item["profile"] setshader(var_2, self.binoculars_hud_item["profile"].width, self.binoculars_hud_item["profile"].height);
        self.binoculars_hud_item["no"].alpha = 0;
        self.binoculars_hud_item["data"].alpha = 0;
        self.binoculars_hud_item["profile"].alpha = 1;
        wait 0.05;
        continue;
      }

      self.binoculars_hud_item["no"].alpha = 1;
      self.binoculars_hud_item["data"].alpha = 1;
      self.binoculars_hud_item["profile"].alpha = 0;
      wait 0.05;
    }
  }
}

binocular_face_scanning_lines(var_0) {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self endon("stop_scanning");
  self endon("scanning_complete");
  self.binoculars_face_scanning_models = [];
  self.binoculars_face_scanning_models[0] = [];
  self.binoculars_face_scanning_models[1] = [];
  self.binoculars_face_scanning_models[0][0] = spawn("script_model", var_0 gettagorigin("J_Head"));
  self.binoculars_face_scanning_models[0][0].angles = var_0 gettagangles("J_Head");
  self.binoculars_face_scanning_models[0][0] setModel("cnd_facial_rcg_01_non_hvt");
  self.binoculars_face_scanning_models[0][0] linkto(var_0, "J_Head");
  self.binoculars_face_scanning_models[0][0] hideallparts();
  self.binoculars_face_scanning_models[0][1] = spawn("script_model", var_0 gettagorigin("J_Head"));
  self.binoculars_face_scanning_models[0][1].angles = var_0 gettagangles("J_Head");
  self.binoculars_face_scanning_models[0][1] setModel("cnd_facial_rcg_02_non_hvt");
  self.binoculars_face_scanning_models[0][1] linkto(var_0, "J_Head");
  self.binoculars_face_scanning_models[0][1] hideallparts();
  self.binoculars_face_scanning_models[0][2] = spawn("script_model", var_0 gettagorigin("J_Head"));
  self.binoculars_face_scanning_models[0][2].angles = var_0 gettagangles("J_Head");
  self.binoculars_face_scanning_models[0][2] setModel("cnd_facial_rcg_03_non_hvt");
  self.binoculars_face_scanning_models[0][2] linkto(var_0, "J_Head");
  self.binoculars_face_scanning_models[0][2] hideallparts();
  self.binoculars_face_scanning_models[1][0] = spawn("script_model", var_0 gettagorigin("J_Head"));
  self.binoculars_face_scanning_models[1][0].angles = var_0 gettagangles("J_Head");
  self.binoculars_face_scanning_models[1][0] setModel("cnd_facial_rcg_01");
  self.binoculars_face_scanning_models[1][0] linkto(var_0, "J_Head");
  self.binoculars_face_scanning_models[1][0] hideallparts();
  self.binoculars_face_scanning_models[1][1] = spawn("script_model", var_0 gettagorigin("J_Head"));
  self.binoculars_face_scanning_models[1][1].angles = var_0 gettagangles("J_Head");
  self.binoculars_face_scanning_models[1][1] setModel("cnd_facial_rcg_02");
  self.binoculars_face_scanning_models[1][1] linkto(var_0, "J_Head");
  self.binoculars_face_scanning_models[1][1] hideallparts();
  self.binoculars_face_scanning_models[1][2] = spawn("script_model", var_0 gettagorigin("J_Head"));
  self.binoculars_face_scanning_models[1][2].angles = var_0 gettagangles("J_Head");
  self.binoculars_face_scanning_models[1][2] setModel("cnd_facial_rcg_03");
  self.binoculars_face_scanning_models[1][2] linkto(var_0, "J_Head");
  self.binoculars_face_scanning_models[1][2] hideallparts();
  self.binoculars_hud_item["percentage"] = maps\_hud_util::createclientfontstring("small", 1.3);
  self.binoculars_hud_item["percentage"].x = 203;
  self.binoculars_hud_item["percentage"].y = -150;
  self.binoculars_hud_item["percentage"].alignx = "right";
  self.binoculars_hud_item["percentage"].aligny = "middle";
  self.binoculars_hud_item["percentage"].horzalign = "center";
  self.binoculars_hud_item["percentage"].vertalign = "middle";
  self.binoculars_hud_item["percentage"].color = (1, 1, 1);
  self.binoculars_hud_item["percentage"].alpha = 1.0;
  self.binoculars_hud_item["percentage"].sort = self.binoculars_hud_item["reticle_scanning_frame"].sort + 10;
  self.binoculars_hud_item["percentage_bar"] = maps\_hud_util::createicon("red_block", 1, 14);
  self.binoculars_hud_item["percentage_bar"] set_default_hud_parameters();
  self.binoculars_hud_item["percentage_bar"].alignx = "left";
  self.binoculars_hud_item["percentage_bar"].aligny = "bottom";
  self.binoculars_hud_item["percentage_bar"].horzalign = "center";
  self.binoculars_hud_item["percentage_bar"].vertalign = "middle";
  self.binoculars_hud_item["percentage_bar"].x = 6;
  self.binoculars_hud_item["percentage_bar"].y = -144;
  self.binoculars_hud_item["percentage_bar"].alpha = 0.0;
  self.binoculars_hud_item["percentage_bar"].sort = self.binoculars_hud_item["reticle_scanning_frame"].sort - 10;
  thread binocular_status_update(&"CORNERED_SCANNING_DOT", 1);
  var_1 = 0;

  if(isDefined(var_0.binocular_hvt) && var_0.binocular_hvt) {
    var_1 = 1;
  }

  var_2 = [];
  var_3 = getnumparts(self.binoculars_face_scanning_models[var_1][0].model);

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_2[var_4] = getpartname(self.binoculars_face_scanning_models[var_1][0].model, var_4);
  }

  var_5 = 8;
  var_6 = [];
  var_6[0] = 0;
  var_6[1] = 0;

  while(var_2.size > 0 && isDefined(var_0) && bullettracepassed(self getEye(), var_0 gettagorigin("J_Head"), 0, undefined)) {
    if(vectordot(anglesToForward(self getplayerangles()), anglesToForward(var_0 gettagangles("tag_eye"))) > 0.0) {
      if(!common_scripts\utility::flag("scan_target_not_facing")) {
        thread binocular_status_update(&"CORNERED_READY");
      }

      common_scripts\utility::flag_set("scan_target_not_facing");
      self notify("stop_binocular_scan_loop_sound");

      if(!isDefined(self.scan_loop_red_sound)) {
        thread maps\cornered_audio::aud_binoculars("scan_loop_red");
      }

      for(var_4 = 0; var_4 <= 1; var_4++) {
        self.binoculars_face_scanning_models[var_1][var_4 + 1] showpart(getpartname(self.binoculars_face_scanning_models[var_1][var_4 + 1].model, var_6[var_4]));

        if(var_6[var_4] >= var_5) {
          self.binoculars_face_scanning_models[var_1][var_4 + 1] hidepart(getpartname(self.binoculars_face_scanning_models[var_1][var_4 + 1].model, var_6[var_4] - var_5));
        } else {
          self.binoculars_face_scanning_models[var_1][var_4 + 1] hidepart(getpartname(self.binoculars_face_scanning_models[var_1][var_4 + 1].model, getnumparts(self.binoculars_face_scanning_models[var_1][var_4 + 1].model) + var_6[var_4] - var_5));
        }

        var_6[var_4]++;

        if(var_6[var_4] >= getnumparts(self.binoculars_face_scanning_models[var_1][var_4 + 1].model)) {
          var_6[var_4] = 0;
        }
      }

      wait 0.05;
      continue;
    }

    if(common_scripts\utility::flag("scan_target_not_facing")) {
      thread binocular_status_update(&"CORNERED_SCANNING_DOT", 1);
    }

    common_scripts\utility::flag_clear("scan_target_not_facing");

    if(!isDefined(self.scan_loop_sound)) {
      thread maps\cornered_audio::aud_binoculars("scan_loop");
    }

    self notify("stop_binocular_scan_loop_red_sound");
    var_7 = randomint(var_2.size);
    self.binoculars_face_scanning_models[var_1][0] showpart(var_2[var_7]);
    self.binoculars_face_scanning_models[var_1][1] hideallparts();
    self.binoculars_face_scanning_models[var_1][2] hideallparts();
    var_2 = maps\_utility::array_remove_index(var_2, var_7);
    self.binoculars_hud_item["percentage_bar"] setshader("red_block", int(201 * (1.0 - var_2.size / var_3)), self.binoculars_hud_item["percentage_bar"].height);
    self.binoculars_hud_item["percentage_bar"].alpha = 1.0;
    self.binoculars_hud_item["percentage"] settext(int(100 * (1.0 - var_2.size / var_3)));
    wait 0.1;
  }

  if(var_2.size == 0) {
    self notify("binoculars_facial_scan_finished");
    thread binocular_status_update(&"CORNERED_IDENTIFIED");
  } else
    self notify("stop_scanning");
}

binocular_face_scanning_lines_complete(var_0) {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self endon("stop_scanning");
  wait(var_0);
  thread maps\cornered_audio::aud_binoculars("seeker_move");

  if(isDefined(self.binoculars_face_scanning_models)) {
    foreach(var_2 in self.binoculars_face_scanning_models) {
      foreach(var_4 in var_2) {
        var_4 delete();
      }
    }

    self.binoculars_face_scanning_models = undefined;
  }
}

binocular_face_scanning_data() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self notify("face_scanning_data");
  self endon("face_scanning_data");
  var_0 = 35;
  var_1 = 1;
  var_2 = 0.75;

  for(var_3 = 0; var_3 < var_0; var_3++) {
    if(isDefined(self.binoculars_hud_item["profile_data_line_" + var_3])) {
      self.binoculars_hud_item["profile_data_line_" + var_3] destroy();
    }

    self.binoculars_hud_item["profile_data_line_" + var_3] = maps\_hud_util::createicon("white", 1, 64);
    self.binoculars_hud_item["profile_data_line_" + var_3] set_default_hud_parameters();
    self.binoculars_hud_item["profile_data_line_" + var_3].alignx = "center";
    self.binoculars_hud_item["profile_data_line_" + var_3].aligny = "bottom";
    self.binoculars_hud_item["profile_data_line_" + var_3].horzalign = "center";
    self.binoculars_hud_item["profile_data_line_" + var_3].vertalign = "middle";
    self.binoculars_hud_item["profile_data_line_" + var_3].x = 144 + var_3 * 2;
    self.binoculars_hud_item["profile_data_line_" + var_3].y = var_1;
    self.binoculars_hud_item["profile_data_line_" + var_3].color = (1, 1, 1);
    self.binoculars_hud_item["profile_data_line_" + var_3].alpha = var_2;
    self.binoculars_hud_item["profile_data_line_" + var_3].sort = self.binoculars_hud_item["reticle_scanning_frame"].sort - 1;
  }

  var_4 = randomfloatrange(-90.0, 90.0);
  var_5 = randomfloatrange(10.0, 25.0);

  while(!self.binoculars_scanning_complete && !self.binoculars_stop_scanning) {
    var_4 = var_4 + var_5 * 4;

    if(common_scripts\utility::flag("scan_target_not_facing")) {
      if(randomint(10) > 8) {
        var_5 = randomfloatrange(10.0, 25.0);
      }

      for(var_3 = 0; var_3 < var_0; var_3++) {
        self.binoculars_hud_item["profile_data_line_" + var_3].height = int(clamp(6 * (sin(var_4 - var_5 * (var_3 + 1)) + 1.0) + pow(randomfloatrange(0.0, 6.0), 2), 0, 64));
        self.binoculars_hud_item["profile_data_line_" + var_3] setshader("white", self.binoculars_hud_item["profile_data_line_" + var_3].width, self.binoculars_hud_item["profile_data_line_" + var_3].height);
      }
    } else {
      for(var_3 = 0; var_3 < var_0; var_3++) {
        self.binoculars_hud_item["profile_data_line_" + var_3].height = int(clamp((sin(var_4 - var_5 * (var_3 + 1)) + 1.0 + randomfloatrange(0.0, 0.1)) * 32, 0, 64));
        self.binoculars_hud_item["profile_data_line_" + var_3] setshader("white", self.binoculars_hud_item["profile_data_line_" + var_3].width, self.binoculars_hud_item["profile_data_line_" + var_3].height);
      }
    }

    wait 0.05;
  }

  while(!self.binoculars_stop_scanning) {
    for(var_3 = 0; var_3 < var_0; var_3++) {
      self.binoculars_hud_item["profile_data_line_" + var_3].height = self.binoculars_hud_item["profile_data_line_" + var_3].height * randomfloatrange(0.8, 0.95);

      if(self.binoculars_hud_item["profile_data_line_" + var_3].height < 1) {
        self.binoculars_hud_item["profile_data_line_" + var_3].alpha = 0.0;
        continue;
      }

      if(self.binoculars_hud_item["profile_data_line_" + var_3].y != var_1) {
        self.binoculars_hud_item["profile_data_line_" + var_3].y = var_1 + self.binoculars_hud_item["profile_data_line_" + var_3].height;
      }

      self.binoculars_hud_item["profile_data_line_" + var_3] setshader("white", self.binoculars_hud_item["profile_data_line_" + var_3].width, int(self.binoculars_hud_item["profile_data_line_" + var_3].height));
    }

    wait 0.05;
  }

  for(var_3 = 0; var_3 < var_0; var_3++) {
    self.binoculars_hud_item["profile_data_line_" + var_3] destroy();
    self.binoculars_hud_item["profile_data_line_" + var_3] = undefined;
  }
}

binoculars_monitor_scanning_button() {
  self.show_binoc_scan_hint = 1;

  for(;;) {
    while(!self attackbuttonpressed()) {
      common_scripts\utility::waitframe();
    }

    self notify("scanning");
    self.show_binoc_scan_hint = 0;

    while(self attackbuttonpressed()) {
      common_scripts\utility::waitframe();
    }

    self notify("stop_scanning");
    self.show_binoc_scan_hint = 1;
  }
}

binoculars_monitor_scanning() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  thread binoculars_monitor_scanning_button();

  for(;;) {
    while(!self attackbuttonpressed() || self.current_binocular_zoom_level == 0) {
      wait 0.05;
    }

    if(isDefined(self.binoculars_scan_target) && isDefined(self.binocular_target.linked_to_ent) && self.binocular_target.linked_to_ent == self.binoculars_scan_target) {
      var_0 = self.binoculars_scan_target;

      if(!bullettracepassed(self getEye(), var_0 gettagorigin("J_Head"), 0, undefined)) {
        wait 0.05;
        continue;
      }

      thread binoculars_lock_to_target(var_0);
      thread scan_blur();

      while(self attackbuttonpressed() && isDefined(var_0) && isDefined(self.binoculars_linked_to_target) && self.binoculars_linked_to_target && !target_isincircle(self.binocular_target, self, getdvarint("cg_fov"), 50) && bullettracepassed(self getEye(), var_0 gettagorigin("J_Head"), 0, undefined)) {
        wait 0.05;
      }

      if(!bullettracepassed(self getEye(), var_0 gettagorigin("J_Head"), 0, undefined)) {
        wait 0.05;
        var_0 = undefined;
      }

      if(!self attackbuttonpressed() || !isDefined(var_0)) {
        binoculars_unlock_from_target();
        self notify("stop_scanning");
        continue;
      }

      self notify("scanning_target");
      self.binoculars_scanning_complete = 0;
      self.binoculars_stop_scanning = 0;
      thread binocular_face_scanning(var_0);
      thread binocular_face_scanning_lines(var_0);
      thread binocular_face_scanning_data();
      var_1 = common_scripts\utility::waittill_any_return("binoculars_facial_scan_finished", "stop_scanning");
      self notify("stop_binocular_scan_loop_sound");
      self notify("stop_binocular_scan_loop_red_sound");
      var_2 = 0.0;

      if(var_1 == "binoculars_facial_scan_finished") {
        self notify("scanning_complete");
        self.binoculars_scanning_complete = 1;

        if(isDefined(var_0.binocular_facial_profile)) {
          self.binoculars_hud_item["profile"] setshader(var_0.binocular_facial_profile, self.binoculars_hud_item["profile"].width, self.binoculars_hud_item["profile"].height);
        } else {
          if(!isDefined(self.binoculars_hud_item["no"])) {
            self.binoculars_hud_item["no"] = maps\_hud_util::createclientfontstring("small", 1.3);
          }

          self.binoculars_hud_item["no"].x = 178;
          self.binoculars_hud_item["no"].y = -107;
          self.binoculars_hud_item["no"].alignx = "center";
          self.binoculars_hud_item["no"].aligny = "middle";
          self.binoculars_hud_item["no"].horzalign = "center";
          self.binoculars_hud_item["no"].vertalign = "middle";
          self.binoculars_hud_item["no"].color = (1, 1, 1);
          self.binoculars_hud_item["no"].alpha = 1.0;
          self.binoculars_hud_item["no"].sort = self.binoculars_hud_item["reticle_scanning_frame"].sort + 10;
          self.binoculars_hud_item["no"] settext(&"CORNERED_NO");
          self.binoculars_hud_item["match"] = maps\_hud_util::createclientfontstring("small", 1.3);
          self.binoculars_hud_item["match"].x = 178;
          self.binoculars_hud_item["match"].y = -95;
          self.binoculars_hud_item["match"].alignx = "center";
          self.binoculars_hud_item["match"].aligny = "middle";
          self.binoculars_hud_item["match"].horzalign = "center";
          self.binoculars_hud_item["match"].vertalign = "middle";
          self.binoculars_hud_item["match"].color = (1, 1, 1);
          self.binoculars_hud_item["match"].alpha = 1.0;
          self.binoculars_hud_item["match"].sort = self.binoculars_hud_item["reticle_scanning_frame"].sort + 10;
          self.binoculars_hud_item["match"] settext(&"CORNERED_MATCH");
          self.binoculars_hud_item["profile"].alpha = 0;
        }

        while(self attackbuttonpressed() && var_2 < 0.5) {
          var_2 = var_2 + 0.05;
          wait 0.05;
        }
      }

      if(var_2 >= 0.5) {
        self notify("scanning_upload_verified");

        if(isDefined(var_0.binocular_hvt) && var_0.binocular_hvt) {
          self notify("hvt_confirmed");
          common_scripts\utility::flag_set("hvt_confirmed");
          thread maps\cornered_audio::aud_binoculars("positive");
        } else
          thread maps\cornered_audio::aud_binoculars("negative");

        thread binocular_face_scanning_lines_complete(0.5);

        while(self attackbuttonpressed() && bullettracepassed(self getEye(), var_0 gettagorigin("J_Head"), 0, undefined)) {
          wait 0.05;
        }
      } else
        self notify("stop_scanning");

      if(isDefined(self.binoculars_face_scanning_models)) {
        foreach(var_4 in self.binoculars_face_scanning_models) {
          foreach(var_6 in var_4) {
            var_6 delete();
          }
        }

        self.binoculars_face_scanning_models = undefined;
      }

      self.binoculars_stop_scanning = 1;
      common_scripts\utility::flag_clear("scan_target_not_facing");
      self.binoculars_hud_item["profile"] destroy();
      self.binoculars_hud_item["profile"] = undefined;

      if(isDefined(self.binoculars_hud_item["no"])) {
        self.binoculars_hud_item["no"] destroy();
        self.binoculars_hud_item["no"] = undefined;
      }

      if(isDefined(self.binoculars_hud_item["match"])) {
        self.binoculars_hud_item["match"] destroy();
        self.binoculars_hud_item["match"] = undefined;
      }

      if(isDefined(self.binoculars_hud_item["data"])) {
        self.binoculars_hud_item["data"] destroy();
        self.binoculars_hud_item["data"] = undefined;
      }

      if(isDefined(self.binoculars_hud_item["percentage_bar"])) {
        self.binoculars_hud_item["percentage_bar"] destroy();
        self.binoculars_hud_item["percentage_bar"] = undefined;
      }

      if(isDefined(self.binoculars_hud_item["percentage"])) {
        self.binoculars_hud_item["percentage"] destroy();
        self.binoculars_hud_item["percentage"] = undefined;
      }

      binoculars_unlock_from_target();
      continue;
    }

    self waittill("stop_scanning");
  }
}

static_overlay() {
  self.binoculars_hud_item["static"] = newclienthudelem(self);
  self.binoculars_hud_item["static"].x = 0;
  self.binoculars_hud_item["static"].y = 0;
  self.binoculars_hud_item["static"].alignx = "left";
  self.binoculars_hud_item["static"].aligny = "top";
  self.binoculars_hud_item["static"].horzalign = "fullscreen";
  self.binoculars_hud_item["static"].vertalign = "fullscreen";
  self.binoculars_hud_item["static"] setshader("overlay_static", 640, 480);
  self.binoculars_hud_item["static"].alpha = 0.75;
  self.binoculars_hud_item["static"].sort = -3;
  self.binoculars_hud_item["static"] fadeovertime(0.05);
  self.binoculars_hud_item["static"].alpha = 0.9;
  wait 0.05;
  self.binoculars_hud_item["static"] fadeovertime(0.15);
  self.binoculars_hud_item["static"].alpha = 0.0;
  wait 0.15;
  self.binoculars_hud_item["static"] destroy();
  self.binoculars_hud_item["static"] = undefined;
}

monitor_binoculars_zoom() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self.current_binocular_zoom_level = self.binoculars_default_zoom_level;
  self.binocular_zoom_levels = 2;
  self.first_zoom_level_fov = 2;

  for(;;) {
    self waittill("binocular_zoom");

    if(!self attackbuttonpressed() || self.current_binocular_zoom_level == 0) {
      self.binocular_zooming = 1;

      if(self.current_binocular_zoom_level == 0) {
        self notify("binoculars_zoom_lerp");
        self enableslowaim(0.5, 0.3);
        thread maps\cornered_audio::aud_binoculars("zoom_in");
        thread zoom_blur(1.4);
        thread max_zoom_dof();
        self.binoculars_zooming = 1;
        self lerpfov(self.first_zoom_level_fov, 1.5);

        for(var_0 = 1; var_0 <= 30.0; var_0++) {
          self.binoculars_hud_item["zoom_level_1"] settext("" + (var_0 * 10 + 20));
          self.binoculars_hud_item["zoom_level_2"] settext("" + (var_0 * 10 + 10));
          self.binoculars_hud_item["zoom_level_3"] settext("" + var_0 * 10);
          self.binoculars_hud_item["zoom_level_4"] settext("" + common_scripts\utility::ter_op(var_0 * 10 - 10 >= 0, var_0 * 10 - 10, ""));
          self.binoculars_hud_item["zoom_level_5"] settext("" + common_scripts\utility::ter_op(var_0 * 10 - 20 >= 0, var_0 * 10 - 20, ""));
          wait 0.05;
        }

        self.binoculars_zooming = 0;
        self notify("binoculars_done_zooming");
      } else {
        maps\_art::dof_disable_script(0.0);
        self disableslowaim();
        thread maps\cornered_audio::aud_binoculars("zoom_out");
        setsaveddvar("cg_fov", 65);
      }

      self.current_binocular_zoom_level++;

      if(self.current_binocular_zoom_level >= self.binocular_zoom_levels) {
        self.current_binocular_zoom_level = 0;
        self.binoculars_hud_item["zoom_level_1"] settext("20");
        self.binoculars_hud_item["zoom_level_2"] settext("10");
        self.binoculars_hud_item["zoom_level_3"] settext("0");
        self.binoculars_hud_item["zoom_level_4"] settext("");
        self.binoculars_hud_item["zoom_level_5"] settext("");
      } else {
        self.binoculars_hud_item["zoom_level_1"] settext("320");
        self.binoculars_hud_item["zoom_level_2"] settext("310");
        self.binoculars_hud_item["zoom_level_3"] settext("300");
        self.binoculars_hud_item["zoom_level_4"] settext("290");
        self.binoculars_hud_item["zoom_level_5"] settext("280");
      }

      self.binocular_zooming = 0;
    }
  }
}

zoom_blur(var_0) {
  setblur(10, 0.1);
  wait 0.1;
  setblur(0, var_0);
}

scan_blur() {
  setblur(5, 0.0);
  common_scripts\utility::waittill_any("stop_scanning", "stop_using_binoculars", "take_binoculars", "binoculars_lerp_dof");
  setblur(0, 0.0);
}

zoom_lerp_dof() {
  self notify("binoculars_lerp_dof");
  self endon("binoculars_lerp_dof");
  maps\_art::dof_enable_script(50, 100, 10, 100, 200, 6, 0.0);
  maps\_art::dof_disable_script(0.5);
}

max_zoom_dof() {
  maps\_art::dof_enable_script(level.dof["base"]["current"]["nearStart"], level.dof["base"]["current"]["nearEnd"], 10, 11000, 12000, 10, 0.1);
}

binoculars_zoom_display() {
  self.binoculars_hud_item["zoom_level_1"] = maps\_hud_util::createclientfontstring("small", 0.8);
  self.binoculars_hud_item["zoom_level_1"].x = 63;
  self.binoculars_hud_item["zoom_level_1"].y = -223;
  self.binoculars_hud_item["zoom_level_1"].alignx = "right";
  self.binoculars_hud_item["zoom_level_1"].aligny = "middle";
  self.binoculars_hud_item["zoom_level_1"].horzalign = "left";
  self.binoculars_hud_item["zoom_level_1"].vertalign = "middle";
  self.binoculars_hud_item["zoom_level_1"].color = (1, 1, 1);
  self.binoculars_hud_item["zoom_level_1"].alpha = 0.5;
  self.binoculars_hud_item["zoom_level_1"] setvalue(20);
  self.binoculars_hud_item["zoom_level_2"] = maps\_hud_util::createclientfontstring("small", 0.9);
  self.binoculars_hud_item["zoom_level_2"].x = 63;
  self.binoculars_hud_item["zoom_level_2"].y = -112;
  self.binoculars_hud_item["zoom_level_2"].alignx = "right";
  self.binoculars_hud_item["zoom_level_2"].aligny = "middle";
  self.binoculars_hud_item["zoom_level_2"].horzalign = "left";
  self.binoculars_hud_item["zoom_level_2"].vertalign = "middle";
  self.binoculars_hud_item["zoom_level_2"].color = (1, 1, 1);
  self.binoculars_hud_item["zoom_level_2"].alpha = 0.5;
  self.binoculars_hud_item["zoom_level_2"] setvalue(10);
  self.binoculars_hud_item["zoom_level_3"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.binoculars_hud_item["zoom_level_3"].x = 64;
  self.binoculars_hud_item["zoom_level_3"].y = -1;
  self.binoculars_hud_item["zoom_level_3"].alignx = "right";
  self.binoculars_hud_item["zoom_level_3"].aligny = "middle";
  self.binoculars_hud_item["zoom_level_3"].horzalign = "left";
  self.binoculars_hud_item["zoom_level_3"].vertalign = "middle";
  self.binoculars_hud_item["zoom_level_3"].color = (1, 1, 1);
  self.binoculars_hud_item["zoom_level_3"].alpha = 1.0;
  self.binoculars_hud_item["zoom_level_3"] setvalue(0);
  self.binoculars_hud_item["zoom_level_4"] = maps\_hud_util::createclientfontstring("small", 0.9);
  self.binoculars_hud_item["zoom_level_4"].x = 63;
  self.binoculars_hud_item["zoom_level_4"].y = 109;
  self.binoculars_hud_item["zoom_level_4"].alignx = "right";
  self.binoculars_hud_item["zoom_level_4"].aligny = "middle";
  self.binoculars_hud_item["zoom_level_4"].horzalign = "left";
  self.binoculars_hud_item["zoom_level_4"].vertalign = "middle";
  self.binoculars_hud_item["zoom_level_4"].color = (1, 1, 1);
  self.binoculars_hud_item["zoom_level_4"].alpha = 0.5;
  self.binoculars_hud_item["zoom_level_4"] settext("");
  self.binoculars_hud_item["zoom_level_5"] = maps\_hud_util::createclientfontstring("small", 0.8);
  self.binoculars_hud_item["zoom_level_5"].x = 63;
  self.binoculars_hud_item["zoom_level_5"].y = 220;
  self.binoculars_hud_item["zoom_level_5"].alignx = "right";
  self.binoculars_hud_item["zoom_level_5"].aligny = "middle";
  self.binoculars_hud_item["zoom_level_5"].horzalign = "left";
  self.binoculars_hud_item["zoom_level_5"].vertalign = "middle";
  self.binoculars_hud_item["zoom_level_5"].color = (1, 1, 1);
  self.binoculars_hud_item["zoom_level_5"].alpha = 0.333;
  self.binoculars_hud_item["zoom_level_5"] settext("");
}

binoculars_angles_display() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  self.binoculars_hud_item["angles_seconds_symbol"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.binoculars_hud_item["angles_seconds_symbol"].x = -18;
  self.binoculars_hud_item["angles_seconds_symbol"].y = -25;
  self.binoculars_hud_item["angles_seconds_symbol"].alignx = "right";
  self.binoculars_hud_item["angles_seconds_symbol"].aligny = "top";
  self.binoculars_hud_item["angles_seconds_symbol"].horzalign = "center";
  self.binoculars_hud_item["angles_seconds_symbol"].vertalign = "top";
  self.binoculars_hud_item["angles_seconds_symbol"].color = (1, 1, 1);
  self.binoculars_hud_item["angles_seconds_symbol"].alpha = 1.0;
  self.binoculars_hud_item["angles_seconds_symbol"].glowcolor = (1, 1, 1);
  self.binoculars_hud_item["angles_seconds_symbol"].glowalpha = 0.0;
  self.binoculars_hud_item["angles_seconds_symbol"] settext("\"");
  self.binoculars_hud_item["angles_seconds"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.binoculars_hud_item["angles_seconds"].x = -23;
  self.binoculars_hud_item["angles_seconds"].y = -25;
  self.binoculars_hud_item["angles_seconds"].alignx = "right";
  self.binoculars_hud_item["angles_seconds"].aligny = "top";
  self.binoculars_hud_item["angles_seconds"].horzalign = "center";
  self.binoculars_hud_item["angles_seconds"].vertalign = "top";
  self.binoculars_hud_item["angles_seconds"].color = (1, 1, 1);
  self.binoculars_hud_item["angles_seconds"].alpha = 1.0;
  self.binoculars_hud_item["angles_seconds"].glowcolor = (1, 1, 1);
  self.binoculars_hud_item["angles_seconds"].glowalpha = 0.0;
  self.binoculars_hud_item["angles_minutes_symbol"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.binoculars_hud_item["angles_minutes_symbol"].x = -43;
  self.binoculars_hud_item["angles_minutes_symbol"].y = -25;
  self.binoculars_hud_item["angles_minutes_symbol"].alignx = "right";
  self.binoculars_hud_item["angles_minutes_symbol"].aligny = "top";
  self.binoculars_hud_item["angles_minutes_symbol"].horzalign = "center";
  self.binoculars_hud_item["angles_minutes_symbol"].vertalign = "top";
  self.binoculars_hud_item["angles_minutes_symbol"].color = (1, 1, 1);
  self.binoculars_hud_item["angles_minutes_symbol"].alpha = 1.0;
  self.binoculars_hud_item["angles_minutes_symbol"].glowcolor = (1, 1, 1);
  self.binoculars_hud_item["angles_minutes_symbol"].glowalpha = 0.0;
  self.binoculars_hud_item["angles_minutes_symbol"] settext("'");
  self.binoculars_hud_item["angles_minutes"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.binoculars_hud_item["angles_minutes"].x = -46;
  self.binoculars_hud_item["angles_minutes"].y = -25;
  self.binoculars_hud_item["angles_minutes"].alignx = "right";
  self.binoculars_hud_item["angles_minutes"].aligny = "top";
  self.binoculars_hud_item["angles_minutes"].horzalign = "center";
  self.binoculars_hud_item["angles_minutes"].vertalign = "top";
  self.binoculars_hud_item["angles_minutes"].color = (1, 1, 1);
  self.binoculars_hud_item["angles_minutes"].alpha = 1.0;
  self.binoculars_hud_item["angles_minutes"].glowcolor = (1, 1, 1);
  self.binoculars_hud_item["angles_minutes"].glowalpha = 0.0;
  self.binoculars_hud_item["angles_degree_symbol"] = maps\_hud_util::createclientfontstring("small", 1.3);
  self.binoculars_hud_item["angles_degree_symbol"].x = -67;
  self.binoculars_hud_item["angles_degree_symbol"].y = -27;
  self.binoculars_hud_item["angles_degree_symbol"].alignx = "center";
  self.binoculars_hud_item["angles_degree_symbol"].aligny = "top";
  self.binoculars_hud_item["angles_degree_symbol"].horzalign = "center";
  self.binoculars_hud_item["angles_degree_symbol"].vertalign = "top";
  self.binoculars_hud_item["angles_degree_symbol"].color = (1, 1, 1);
  self.binoculars_hud_item["angles_degree_symbol"].alpha = 1.0;
  self.binoculars_hud_item["angles_degree_symbol"].glowcolor = (1, 1, 1);
  self.binoculars_hud_item["angles_degree_symbol"].glowalpha = 0.0;
  self.binoculars_hud_item["angles_degree_symbol"] settext(&"CORNERED_BINOCULARS_DEGREE_SYMBOL");
  self.binoculars_hud_item["angles_degrees"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.binoculars_hud_item["angles_degrees"].x = -70;
  self.binoculars_hud_item["angles_degrees"].y = -25;
  self.binoculars_hud_item["angles_degrees"].alignx = "right";
  self.binoculars_hud_item["angles_degrees"].aligny = "top";
  self.binoculars_hud_item["angles_degrees"].horzalign = "center";
  self.binoculars_hud_item["angles_degrees"].vertalign = "top";
  self.binoculars_hud_item["angles_degrees"].color = (1, 1, 1);
  self.binoculars_hud_item["angles_degrees"].alpha = 1.0;
  self.binoculars_hud_item["angles_degrees"].glowcolor = (1, 1, 1);
  self.binoculars_hud_item["angles_degrees"].glowalpha = 0.0;
  self.binoculars_hud_item["heading"] = maps\_hud_util::createclientfontstring("small", 1.0);
  self.binoculars_hud_item["heading"].x = 0;
  self.binoculars_hud_item["heading"].y = -17;
  self.binoculars_hud_item["heading"].alignx = "center";
  self.binoculars_hud_item["heading"].aligny = "top";
  self.binoculars_hud_item["heading"].horzalign = "center";
  self.binoculars_hud_item["heading"].vertalign = "top";
  self.binoculars_hud_item["heading"].color = (1, 1, 1);
  self.binoculars_hud_item["heading"].alpha = 1.0;
  self.binoculars_hud_item["heading"].glowcolor = (1, 1, 1);
  self.binoculars_hud_item["heading"].glowalpha = 0.0;
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

    self.binoculars_hud_item["angles_seconds"] settext(var_5);
    self.binoculars_hud_item["angles_minutes"] settext(var_4);
    self.binoculars_hud_item["angles_degrees"] settext(int(var_1));

    if(var_1 > 337.5 || var_1 < 22.5) {
      self.binoculars_hud_item["heading"] settext("N");
    } else if(var_1 < 67.5) {
      self.binoculars_hud_item["heading"] settext("NE");
    } else if(var_1 < 112.5) {
      self.binoculars_hud_item["heading"] settext("E");
    } else if(var_1 < 157.5) {
      self.binoculars_hud_item["heading"] settext("SE");
    } else if(var_1 < 202.5) {
      self.binoculars_hud_item["heading"] settext("S");
    } else if(var_1 < 247.5) {
      self.binoculars_hud_item["heading"] settext("SW");
    } else if(var_1 < 292.5) {
      self.binoculars_hud_item["heading"] settext("W");
    } else {
      self.binoculars_hud_item["heading"] settext("NW");
    }

    wait 0.05;
  }
}

binocular_reticle_target_reaction() {
  self endon("stop_using_binoculars");
  self endon("take_binoculars");
  var_0 = 0;
  var_1 = 0;
  var_2 = 1;
  var_3 = 1;
  var_4 = 0;
  var_5 = undefined;

  for(;;) {
    if((!isDefined(self.binocular_zooming) || isDefined(self.binocular_zooming) && !self.binocular_zooming) && (!self.binocular_target islinked() || !self attackbuttonpressed())) {
      if(isDefined(self.binoculars_trace) && isDefined(self.binoculars_scan_target)) {
        if(!isDefined(var_5) || var_5 != self.binoculars_scan_target) {
          var_4 = 0;

          if(self.binocular_target islinked()) {
            self.binocular_target unlink();
          }

          self.binocular_target.origin = self.binoculars_scan_target gettagorigin("tag_eye") - (0, 0, 3);
          self.binocular_target.angles = self.binoculars_scan_target gettagangles("tag_eye");
          self.binocular_target linkto(self.binoculars_scan_target, "tag_eye");
          self.binocular_target.linked_to_ent = self.binoculars_scan_target;
          thread binoculars_remove_target_on_death(self.binoculars_scan_target);
          var_5 = self.binoculars_scan_target;
        }
      } else {
        var_4 = 1;
        var_5 = undefined;
      }
    }

    wait 0.05;
  }
}

binoculars_pip_init() {
  level.pip = level.player newpip();
  level.pip.enable = 0;
}

binoculars_pip_enable() {
  level.pip.enableshadows = 1;
  level.pip.tag = "tag_origin";
  level.pip.width = 194;
  level.pip.height = 193;
  level.pip.x = 320 - level.pip.width / 2;
  level.pip.y = 240 - level.pip.height / 2;

  if(maps\_utility::is_gen4()) {
    level.pip.rendertotexture = 1;
    self.binoculars_hud_item["pip"] = maps\_hud_util::createicon("pip_scene_overlay", int(level.pip.width), int(level.pip.height));
    self.binoculars_hud_item["pip"] set_default_hud_parameters();
    self.binoculars_hud_item["pip"].alignx = "center";
    self.binoculars_hud_item["pip"].aligny = "middle";
    self.binoculars_hud_item["pip"].alpha = 1;
    self.binoculars_hud_item["pip"].sort = self.binoculars_hud_item["pip"].sort - 200;
    self.binoculars_hud_item["pip"].foreground = 0;
  } else
    level.pip.rendertotexture = 0;

  if(isDefined(level.pip.entity)) {
    level.pip.entity delete();
    level.pip.entity = undefined;
  }

  level.pip.entity = spawn("script_model", self getEye());
  level.pip.entity setModel("tag_origin");
  level.pip.entity.angles = self getplayerangles();
  level.pip.entity linktoplayerview(self, "tag_origin", (distance(self.binocular_target.origin, self getEye()) - 300, 0, 0), (0, 0, 0), 0);
  level.pip.freecamera = 1;
  level.pip.tag = "tag_origin";
  level.pip.fov = 5;
  level.pip.enable = 1;
  thread binoculars_pip_update_position();
}

binoculars_pip_update_position() {
  level.pip endon("pip_disabled");

  while(isDefined(self.binocular_target)) {
    level.pip.entity delete();
    level.pip.entity = spawn("script_model", self getEye());
    level.pip.entity setModel("tag_origin");
    level.pip.entity.angles = self getplayerangles();
    level.pip.entity linktoplayerview(self, "tag_origin", (distance(self.binocular_target.origin, self getEye()) - 300, 0, 0), (0, 0, 0), 0);
    wait 0.05;
  }
}

binoculars_pip_disable() {
  level.pip notify("pip_disabled");
  level.pip.enable = 0;

  if(isDefined(self.binoculars_hud_item["pip"])) {
    self.binoculars_hud_item["pip"] destroy();
    self.binoculars_hud_item["pip"] = undefined;
  }

  if(isDefined(level.pip.entity)) {
    level.pip.entity delete();
    level.pip.entity = undefined;
  }
}

set_default_hud_parameters() {
  self.alignx = "left";
  self.aligny = "top";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.hidewhendead = 0;
  self.hidewheninmenu = 1;
  self.sort = 205;
  self.foreground = 1;
  self.alpha = 0.65;
}