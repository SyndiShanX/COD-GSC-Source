/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dog_drive.gsc
*****************************************************/

dog_drive_indirect(var_0) {
  default_dof(0.1);
  maps\_utility::player_speed_percent(0, 0.01);
  var_0 enabledogavoidance(0);
  var_0 setviewmodeldepth(1);
  level.old_ai_eventdistdeath = getdvarint("ai_eventDistDeath");
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("mantle_enable", 0);
  setsaveddvar("ragdoll_max_life", 1500);
  setsaveddvar("ai_eventDistDeath", 200);

  if(level.xenon)
    setsaveddvar("r_texFilterProbeBilinear", 1);

  var_0.oldname = var_0.name;
  var_0.name = "";
  level.see_enemy_dot = 0.85;
  level.see_enemy_dot_close = 0.95;
  self.dog_track_range = 300;
  self.dog_attack_range = 85;
  var_0 maps\_utility::disable_ai_color();
  level.dog_flush_functions["jumpup"] = ::dog_jumpup;

  if(var_0 maps\_utility::ent_flag_exist("pause_dog_command"))
    var_0 maps\_utility::ent_flag_set("pause_dog_command");

  if(!var_0 maps\_utility::ent_flag_exist("dogcam_acquire_targets"))
    var_0 maps\_utility::ent_flag_init("dogcam_acquire_targets");

  var_0 maps\_utility::ent_flag_set("dogcam_acquire_targets");
  var_0.controlling_dog = 1;
  var_0 maps\_utility_dogs::dog_lower_camera(0.1);
  self.controlled_dog = var_0;
  setsaveddvar("cg_fov", 90);
  self enableslowaim(0.3, 0.3);
  self disableweapons();
  self allowcrouch(0);
  self allowstand(1);
  self allowprone(1);
  self allowsprint(0);
  self.ignoreme = 1;
  self enableinvulnerability();
  var_1 = 0;

  if(getdvarint("pete_mccabe", 0) == 1)
    var_1 = 1;

  self.overlays = [];

  if(!var_1) {
    self.overlays[self.overlays.size] = maps\_hud_util::create_client_overlay("dogcam_edge", 1, self);
    self.overlays[self.overlays.size - 1].foreground = 0;
    self.overlays[self.overlays.size] = maps\_hud_util::create_client_overlay("dogcam_dirt", 1, self);
    self.overlays[self.overlays.size - 1].foreground = 0;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_targeting_circle", 150, 150);
    var_2 maps\_hud_util::setpoint("CENTER", undefined, 1, -5, 0);
    var_2.color = (1, 0, 0);
    var_2.alpha = 0;
    self.hud_target_lock = var_2;
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_center", 600, 300);
    var_2 maps\_hud_util::setpoint("CENTER", undefined, 0, 0, 0);
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_compass", 250, 35);
    var_2 maps\_hud_util::setpoint("TOP", "TOP", 0, 10, 0);
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_battery", 100, 12);
    var_2 maps\_hud_util::setpoint("RIGHT TOP", "RIGHT TOP", 0, 25, 0);
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_frame_top", 600, 40);
    var_2 maps\_hud_util::setpoint("TOP", "TOP", 0, -20, 0);
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_frame_bot", 600, 80);
    var_2 maps\_hud_util::setpoint("BOTTOM", "BOTTOM", 0, 32, 0);
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_timestamp", 200, 50);
    var_2 maps\_hud_util::setpoint("LEFT BOTTOM", "LEFT BOTTOM", 14, -25, 0);
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_rec", 50, 50);
    var_2 maps\_hud_util::setpoint("LEFT BOTTOM", "LEFT BOTTOM", 0, -11.5, 0);
    var_2 thread rec_blink();
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_vision_off", 180, 50);
    var_2 maps\_hud_util::setpoint("RIGHT BOTTOM", "RIGHT BOTTOM", 0, -25, 0);
    self.attack_indicator_off = var_2;
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_vision_on", 180, 50);
    var_2 maps\_hud_util::setpoint("RIGHT BOTTOM", "RIGHT BOTTOM", 0, -25, 0);
    self.overlays[self.overlays.size] = var_2;
    self.attack_indicator_on = var_2;
    var_2.alpha = 0;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_bracket_r", 60, 400);
    var_2 maps\_hud_util::setpoint("RIGHT", "RIGHT", 0, 0, 0);
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_bracket_l", 69, 400);
    var_2 maps\_hud_util::setpoint("LEFT", "LEFT", 0, 0, 0);
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclienticon("dogcam_scanline", 1600, 75);
    var_2 maps\_hud_util::setpoint("CENTER", undefined, 0, 0, 0);
    var_2 thread scanline_move();
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclientfontstring("default", 0.8);
    var_2 maps\_hud_util::setpoint("RIGHT BOTTOM", "LEFT BOTTOM", 188.5, -51, 0);
    var_2 settext("00 : 00 00");
    var_2.alpha = 0.4;
    var_2 thread time_countup();
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclientfontstring("default", 0.7);
    var_2 maps\_hud_util::setpoint("CENTER", "CENTER", 0, 55, 0);
    var_2 settext("");
    var_2.alpha = 0.5;
    self.hud_enemy_tracker = var_2;
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclientfontstring("default", 0.7);
    var_2 maps\_hud_util::setpoint("CENTER", "CENTER", -15, 55, 0);
    var_2 settext(&"NML_DOGCAM_TARGET");
    var_2.alpha = 0.5;
    self.hud_enemy_tracker_pre = var_2;
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclientfontstring("default", 0.7);
    var_2 maps\_hud_util::setpoint("CENTER", "CENTER", 10, 55, 0);
    var_2 settext(&"NML_DOGCAM_METERS");
    var_2.alpha = 0.5;
    self.hud_enemy_tracker_post = var_2;
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclientfontstring("default", 0.8);
    var_2 maps\_hud_util::setpoint("CENTER", "RIGHT BOTTOM", -75, -66, 0);
    var_2 settext("");
    var_2.alpha = 0.5;
    self.hud_enemy_tracker_range = var_2;
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclientfontstring("default", 0.8);
    var_2 maps\_hud_util::setpoint("CENTER", "TOP", -70, 35, 0);
    var_2 settext("12345");
    var_2.alpha = 0.5;
    self.lat_tracker = var_2;
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclientfontstring("default", 0.8);
    var_2 maps\_hud_util::setpoint("CENTER", "TOP", 70, 35, 0);
    var_2 settext("12345");
    var_2.alpha = 0.5;
    self.long_tracker = var_2;
    self.overlays[self.overlays.size] = var_2;
    var_2 = level.player maps\_hud_util::createclientfontstring("default", 0.8);
    var_2 maps\_hud_util::setpoint("CENTER", "TOP", 0, 55, 0);
    var_2 settext(&"NML_DOGCAM_NORTH");
    var_2.alpha = 0.5;
    self.compass_tracker = var_2;
    self.overlays[self.overlays.size] = var_2;
    thread nearby_enemy_tracking(var_0);
    thread lattitude_and_longitude(var_0);
    thread compass_update(var_0);
  }

  var_0 thermaldrawdisable();
  var_0.turnrate = 0.15;
  setsaveddvar("r_znear", 4);
  setsaveddvar("hud_showstance", 0);
  var_0 maps\_utility::walkdist_zero();
  var_0.dontchangepushplayer = 1;
  var_0 pushplayer(1);
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 setModel("tag_player");
  var_3 linkto(var_0, "tag_camera", (0, 0, 0), (0, 0, 0));
  var_0.camera_tag = var_3;

  if(!var_1)
    spawn_model_fx((0, 0, 0), (0, 0, 0), (0, 0, 0));

  self playerlinkweaponviewtodelta(var_0, "tag_player", 0, 180, 180, 35, 35, 1);
  self playerlinkedsetviewznear(0);
  self shellshock("dog_cam", 999999);
  var_0 setdogcommand("driven");
  var_0 setdogmaxdrivespeed(80);
  var_0 setdogautoattackwhendriven(0);
  var_3 playLoopSound("ambient_dog_camera");
  var_4 = var_0 common_scripts\utility::spawn_tag_origin();
  var_4 linkto(var_0, "tag_camera", (0, 0, 0), (0, 0, 0));
  var_0.cam_sound_sources = [];
  var_0.cam_sound_sources = common_scripts\utility::array_add(var_0.cam_sound_sources, var_4);
  thread dog_wait_for_attack(var_0);
  thread sound_on_stick_movement(var_0, var_4);
  thread lerp_on_attack(var_0);
  thread detect_sprint_click(var_0);
  thread dog_bark_think(var_0);
  thread camera_zoom(var_0);
  thread screen_blood(var_0);
}

screen_blood(var_0) {
  self endon("stop_dog_drive");
  var_0 endon("death");

  if(getdvarint("dog_no_blood", 0)) {
    return;
  }
  for(;;) {
    var_0 waittill("screen_blood", var_1);

    if(isDefined(self.screen_glitch_org))
      playFXOnTag(common_scripts\utility::getfx("vfx_dog_screenblood"), self.screen_glitch_org, "tag_origin");
  }
}

default_dof(var_0) {
  if(maps\_utility::is_gen4()) {
    maps\_art::dof_enable_script(1, 80, 6, 1500, 4500, 3, var_0);
    self setviewmodeldepthoffield(0, 40);
    self enableforceviewmodeldof();
  } else
    maps\_art::dof_disable_script(var_0);
}

camera_zoom(var_0) {
  self endon("disable_zoom");
  self endon("stop_dog_drive");
  var_0 endon("death");
  self notifyonplayercommand("zoom_camera", "+melee");
  self notifyonplayercommand("zoom_camera", "+melee_breath");
  self notifyonplayercommand("zoom_camera", "+melee_zoom");
  childthread zoom_out_on_left_stick_movement();
  var_0.zoomed = 0;

  for(;;) {
    self waittill("zoom_camera");
    var_0.zoomed = 1;
    zoom_fov();
    common_scripts\utility::waittill_either("zoom_camera", "dog_moved");
    var_0.zoomed = 0;
    default_fov();
  }
}

zoom_out_on_left_stick_movement() {
  for(;;) {
    var_0 = self getnormalizedmovement();

    if(var_0[0] > 0.4 || var_0[1] > 0.4)
      self notify("dog_moved");

    wait 0.05;
  }
}

default_fov() {
  delete_model_fx();
  spawn_model_fx((0, 0, 0), (0, 0, 0), (0, 0, 0));
  self setblurforplayer(3, 0.05);
  earthquake(0.4, 0.3, self.origin, 1000);
  self lerpfov(90, 0.2);
  common_scripts\utility::delaycall(0.1, ::setblurforplayer, 0, 0.5);
  wait 0.1;
}

zoom_fov() {
  delete_model_fx();
  spawn_model_fx((15, 0, 0), (125, 0, 0), (400, 0, 0));
  self setblurforplayer(3, 0.05);
  earthquake(0.4, 0.3, self.origin, 1000);
  common_scripts\utility::delaycall(0.1, ::setblurforplayer, 0, 0.5);
  self lerpfov(12, 0.2);
  wait 0.1;
}

nearby_enemy_tracking(var_0) {
  self.hud_enemy_tracker endon("death");
  self endon("stop_dog_drive");
  var_0 endon("death");
  var_1 = 0;
  var_2 = 0;
  var_3 = &"NML_DOGCAM_TARGET";
  var_4 = &"NML_DOGCAM_METERS";

  for(;;) {
    var_5 = self getplayerangles();
    var_6 = undefined;

    if(isDefined(var_0.closest_enemy_in_range))
      var_6 = var_0.closest_enemy_in_range;

    var_7 = find_nearby_enemy(self.dog_track_range, var_5);
    var_0.closest_enemy_in_range = var_7;

    if(isDefined(var_6)) {
      if(!isDefined(var_7) || var_7 != var_6)
        var_6 thread hud_outlineenable(0);
    }

    self.attack_indicator_off.alpha = 1;
    self.attack_indicator_on.alpha = 0;

    if(isDefined(var_7)) {
      var_8 = distance2d(var_0.origin, var_7.origin);
      var_9 = var_8 * 0.0254;
      var_7.dist_to_dog = var_8;
      var_10 = strtok(var_9 + "", ".");
      var_11 = "0";

      if(var_10.size > 1)
        var_11 = var_10[1][0];

      self.hud_enemy_tracker_pre settext(var_3);
      self.hud_enemy_tracker_post settext(var_4);
      self.hud_enemy_tracker settext(var_10[0] + "." + var_11);

      if(var_8 <= self.dog_attack_range && maps\_dog_control::test_trace(maps\_dog_control::get_eye(), var_7 getEye(), self.controlled_dog)) {
        if(var_0 maps\_utility::ent_flag("dogcam_acquire_targets")) {
          self.hud_enemy_tracker_range settext(&"NML_DOGCAM_TARGETINRANGE");
          self.hud_target_lock.alpha = 1;
          self.hud_target_lock.color = (1, 0, 0);

          if(!var_1) {
            self notify("dogcam_acquired_target");
            thread maps\_utility::play_sound_on_entity("scn_nml_camera_enemy_in_range");
            var_7 thread hud_outlineenable(4);
          }

          var_2 = 0;
          var_1 = 1;
          self.attack_indicator_off.alpha = 0;
          self.attack_indicator_on.alpha = 1;
        }
      } else if(var_0 maps\_utility::ent_flag("dogcam_acquire_targets")) {
        self.hud_target_lock.alpha = 1;
        self.hud_target_lock.color = (0.2, 0, 0);
        self.hud_enemy_tracker_range settext(&"NML_DOGCAM_OUTOFRANGE");
        var_1 = 0;

        if(!var_2)
          thread maps\_utility::play_sound_on_entity("scn_nml_camera_enemy_contact_on");

        var_2 = 1;
        var_7 thread hud_outlineenable(0);
      }
    } else {
      self.hud_target_lock.alpha = 0;
      self.hud_enemy_tracker_pre settext("");
      self.hud_enemy_tracker_post settext("");
      self.hud_enemy_tracker settext("");
      self.hud_enemy_tracker settext("");
      self.hud_enemy_tracker_range settext("");

      if(var_2)
        thread maps\_utility::play_sound_on_entity("scn_nml_camera_enemy_contact_off");

      var_1 = 0;
      var_2 = 0;
    }

    if(!var_2) {}

    wait 0.05;
  }
}

lattitude_and_longitude(var_0) {
  self.lat_tracker endon("death");
  self.long_tracker endon("death");
  self endon("stop_dog_drive");
  var_0 endon("death");

  if(!isDefined(level.lat))
    level.lat = [32.8695, -117.102];

  for(;;) {
    var_1 = inches_to_lattitude(var_0.origin[0]) * 10;
    var_2 = inches_to_lattitude(var_0.origin[1]) * 10;
    self.lat_tracker settext(trim_decimal_points(var_1 + level.lat[0], 4));
    self.long_tracker settext(trim_decimal_points(var_2 + level.lat[1], 4));
    wait 0.05;
  }
}

compass_update(var_0) {
  self.compass_tracker endon("death");
  self endon("stop_dog_drive");
  var_0 endon("death");

  for(;;) {
    var_1 = self getplayerangles();
    self.compass_tracker settext(getdirectioncompass(var_1[1]));
    wait 0.05;
  }
}

spawn_model_fx(var_0, var_1, var_2) {
  if(getdvarint("pete_mccabe", 0) == 0) {
    self.crt_plane = spawn("script_model", (0, 0, 0));
    self.crt_plane setModel("torpedo_crtplane");
    self.crt_plane linktoplayerview(self, "tag_origin", (2, 0, 0) + var_0, (0, -90, 0), 1);
    self.screen_glitch_org = spawn("script_model", (0, 0, 0));
    self.screen_glitch_org setModel("tag_origin");
    self.screen_glitch_org.origin = level.player.origin;
    self.screen_glitch_org linktoplayerview(level.player, "tag_origin", (25, 0, 0) + var_1, (0, 180, 0), 1);
    thread screen_glitches();
  }
}

delete_model_fx() {
  if(getdvarint("pete_mccabe", 0) == 0) {
    self.crt_plane delete();
    self.screen_glitch_org delete();
  }
}

scanline_move() {
  self endon("death");
  childthread scanline_flicker();
  self moveovertime(8);
  self.y = 400;
  wait 8;

  for(;;) {
    wait 0.05;
    self.y = -400;
    wait 0.05;
    self moveovertime(16);
    self.y = 400;
    wait 16;
  }
}

rec_blink() {
  self endon("death");

  for(;;) {
    self.alpha = 0;
    wait 0.75;
    self.alpha = 1;
    wait 0.75;
  }
}

time_countup() {
  self endon("death");
  var_0 = gettime();

  for(;;) {
    var_1 = "";
    var_2 = "";
    var_3 = "";
    var_4 = gettime();
    var_5 = int(var_4 / 60000);
    var_4 = var_4 - var_5 * 60000;

    if(var_5 < 10)
      var_1 = "0";

    var_6 = int(var_4 / 1000);
    var_4 = var_4 - var_6 * 1000;

    if(var_6 < 10)
      var_2 = "0";

    var_7 = int(var_4 / 10);

    if(var_7 < 10)
      var_3 = "0";

    self settext(var_1 + var_5 + " : " + var_2 + var_6 + " " + var_3 + var_7);
    wait 0.05;
  }
}

scanline_flicker() {
  for(;;) {
    self fadeovertime(2);
    self.alpha = 0.3;
    wait 2;
    self fadeovertime(2);
    self.alpha = 1;
    wait 2;
  }
}

screen_glitches() {
  self.screen_glitch_org endon("death");
  self endon("disable_screen_glitch");

  for(;;) {
    if(isDefined(level._effect["screen_glitch"]) && isDefined(self.screen_glitch_org))
      playFXOnTag(common_scripts\utility::getfx("screen_glitch"), self.screen_glitch_org, "tag_origin");

    level.player thread maps\_utility::play_sound_on_entity("scn_nml_camera_flicker_short");
    common_scripts\utility::waittill_notify_or_timeout("do_screen_glitch", randomfloatrange(5, 8));
  }
}

constant_screen_glitches() {
  if(isDefined(self.screen_glitch_org))
    self.screen_glitch_org endon("death");

  self endon("stop_constant_glitch");

  for(;;) {
    if(isDefined(level._effect["screen_glitch"]) && isDefined(self.screen_glitch_org))
      playFXOnTag(common_scripts\utility::getfx("screen_glitch"), self.screen_glitch_org, "tag_origin");

    common_scripts\utility::waittill_notify_or_timeout("do_screen_glitch", 0.05);
  }
}

dog_drive_indirect_disable(var_0) {
  setsaveddvar("ai_eventDistDeath", level.old_ai_eventdistdeath);

  if(level.xenon)
    setsaveddvar("r_texFilterProbeBilinear", 0);

  var_0 enabledogavoidance(1);
  var_0 setviewmodeldepth(0);
  maps\_art::dof_disable_script(0.75);
  self setviewmodeldepthoffield(0, 0);
  self disableforceviewmodeldof();
  maps\_audio::clear_filter();
  maps\_utility::player_speed_percent(100, 0.01);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("mantle_enable", 1);
  setsaveddvar("ragdoll_max_life", 4500);
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1)
  var_3 hudoutlinedisable();

  var_0 setdogcommand("attack");
  var_0.controlling_dog = undefined;
  var_0.name = var_0.oldname;

  if(var_0 maps\_utility::ent_flag_exist("pause_dog_command"))
    var_0 maps\_utility::ent_flag_clear("pause_dog_command");

  self notify("stop_dog_drive");
  self stopshellshock();
  self unlink();
  self enableweapons();
  self disableinvulnerability();
  self.ignoreme = 0;
  setsaveddvar("cg_fov", 65);
  self disableslowaim();
  self allowcrouch(1);
  self allowstand(1);
  self allowprone(1);
  self allowsprint(1);

  foreach(var_6 in self.overlays)
  var_6 destroy();

  if(isDefined(self.crt_plane))
    self.crt_plane delete();

  if(isDefined(self.screen_glitch_org))
    self.screen_glitch_org delete();

  setsaveddvar("r_znear", 4);
  setsaveddvar("compass", 1);
  setsaveddvar("hud_showstance", 1);
  var_0 maps\_utility::walkdist_reset();
  var_0.turnrate = 0.2;
  var_0.ignoreall = 0;
  var_0.ignoreme = 0;
  var_0.camera_tag stoploopsound();
  self cameraunlink(var_0.camera_tag);

  foreach(var_9 in var_0.cam_sound_sources) {
    var_9 stoploopsound();
    common_scripts\utility::waitframe();
    var_9 delete();
  }

  var_0.camera_tag delete();
}

detect_sprint_click(var_0) {
  self endon("stop_dog_drive");
  var_0 endon("death");
  self notifyonplayercommand("clicked_sprint", "+sprint");
  self notifyonplayercommand("clicked_sprint", "+sprint_zoom");
  self notifyonplayercommand("clicked_sprint", "+breath_sprint");
  var_0.sprint = 0;

  for(;;) {
    self waittill("clicked_sprint");

    if(var_0 isdogbeingdriven()) {
      var_1 = self getnormalizedmovement();

      if(sprint_check(var_1) && !var_0 dog_is_in_combat()) {
        self lerpviewangleclamp(0.3, 0, 0.2, 90.0, 90.0, 0, 0);
        var_0 thread maps\_utility::play_sound_on_entity("anml_dog_run_start");
        var_0.sprint = 1;
        var_0.moveanimtype = "run";
        var_0 setdogmaxdrivespeed(400);
        var_0 setdogautoattackwhendriven(1);
        wait 0.1;
        thread dog_sprint_disable(var_0);
        wait 0.5;
      }
    }
  }
}

sprint_check(var_0) {
  var_1 = getsticksconfig();

  if(self usinggamepad() && var_1 == "thumbstick_legacy")
    return var_0[0] >= 0.3;
  else
    return var_0[0] >= 0.98;
}

dog_sprint_disable(var_0) {
  self endon("stop_dog_drive");
  var_0 endon("death");

  for(;;) {
    var_1 = self getnormalizedmovement();

    if(!sprint_check(var_1) || var_0 dog_is_in_combat()) {
      var_0.sprint = 0;
      var_0 setdogmaxdrivespeed(80);

      if(getdvarint("jimmy", 0) == 0)
        var_0 setdogautoattackwhendriven(0);

      var_0.moveanimtype = "walk";

      if(!var_0 dog_is_in_combat())
        default_dog_limits();

      return;
    }

    wait 0.05;
  }
}

dog_is_in_combat() {
  return self.script == "dog_combat";
}

default_dog_limits() {
  self lerpviewangleclamp(0.3, 0.1, 0.1, 180, 180, 35, 35);
}

sound_on_stick_movement(var_0, var_1) {
  self endon("stop_dog_drive");
  var_0 endon("death");
  var_2 = 0;
  var_3 = 1;

  for(;;) {
    var_4 = 0;
    var_5 = self getnormalizedcameramovement();
    var_6 = anglesToForward(self getplayerangles());
    var_7 = anglesToForward(var_0 gettagangles("TAG_CAMERA"));
    var_8 = vectordot(var_6, var_7);

    if(distance2d(var_5, (0, 0, 0)) > 0.1 && abs(var_3 - var_8) > 0.0)
      var_4 = 1;

    var_3 = var_8;

    if(var_4 != var_2) {
      if(var_4)
        var_1 playLoopSound("dog_cam_mvmnt");
      else
        var_1 stoploopsound("dog_cam_mvmnt");

      var_2 = var_4;
      wait 0.1;
    }

    wait 0.05;
  }
}

dog_wait_for_attack(var_0) {
  self endon("stop_dog_drive");
  var_0 endon("death");
  self notifyonplayercommand("attack_command", "+attack");
  self notifyonplayercommand("attack_command", "+frag");
  self notifyonplayercommand("attack_command", "+smoke");
  self notifyonplayercommand("attack_command", "+toggleads_throw");
  self notifyonplayercommand("attack_command", "+speed_throw");
  self notifyonplayercommand("attack_command", "+speed");
  self notifyonplayercommand("attack_command", "+ads_akimbo_accessible");

  if(getdvarint("jimmy", 0)) {
    var_0 setdogautoattackwhendriven(1);
    return;
  }

  for(;;) {
    self waittill("attack_command");

    if(isDefined(var_0.closest_enemy_in_range)) {
      if(isDefined(var_0.closest_enemy_in_range.dist_to_dog) && var_0.closest_enemy_in_range.dist_to_dog <= self.dog_attack_range)
        thread dog_attack_command_internal(var_0);
    }

    wait 0.5;
    var_0 setdogautoattackwhendriven(0);
  }
}

dog_attack_command_internal(var_0) {
  self notify("dog_attack_internal");
  self endon("dog_attack_internal");
  var_1 = var_0.closest_enemy_in_range;
  var_0 setdogautoattackwhendriven(1);
  wait_for_damage_or_attack(var_1);
  var_0 setdogautoattackwhendriven(0);
}

wait_for_damage_or_attack(var_0) {
  self endon("damage");
  var_0 common_scripts\utility::waittill_either("dog_attacks_ai", "death");
}

dog_command_attack(var_0, var_1) {
  var_0.ignoreme = 0;
  var_0 setthreatbiasgroup("dog_targets");
  var_0 thread restore_ignoreme(self);
  self.favoriteenemy = var_0;
  self.ignoreall = 0;
  self getenemyinfo(var_0);
  self setgoalentity(var_0);
  var_2 = var_0 common_scripts\utility::waittill_any_return("dog_attacks_ai", "death");
}

lerp_on_attack(var_0) {
  self endon("stop_dog_drive");
  self endon("death");
  var_0 endon("death");

  for(;;) {
    level waittill("dog_attacks_ai", var_1, var_2);

    if(var_1 == var_0) {
      if(maps\_utility::is_gen4())
        maps\_art::dof_enable_script(1, 1, 10, 50, 180, 3, 0.2);

      thread constant_screen_glitches();
      self lerpviewangleclamp(0.3, 0, 0.2, 0, 0, 0, 0);
      wait 0.8;
      self notify("stop_constant_glitch");
      var_2 common_scripts\utility::waittill_notify_or_timeout("death", 6);
      default_dof(1.25);
      var_1 setgoalpos(var_1.origin);
      default_dog_limits();
    }
  }
}

restore_ignoreme(var_0) {
  self endon("death");
  self endon("dog_attacks_ai");
  var_0 waittill("cancel_attack");
  self setthreatbiasgroup("axis");
}

dog_indirect_control_input(var_0) {
  self endon("stop_dog_drive");
  var_0 endon("death");

  if(!var_0 maps\_utility::ent_flag_exist("dog_busy"))
    var_0 maps\_utility::ent_flag_init("dog_busy");

  if(!var_0 maps\_utility::ent_flag_exist("running_command"))
    var_0 maps\_utility::ent_flag_init("running_command");

  var_0 maps\_utility::ent_flag_clear("dog_busy");
  var_0 maps\_utility::ent_flag_clear("running_command");
  var_0.last_command = [];
  var_0.last_command["position"] = undefined;
  var_0.last_command["volume"] = undefined;

  for(;;) {
    var_0 maps\_utility::ent_flag_waitopen("dog_busy");
    var_1 = self getnormalizedmovement();
    var_2 = vectortoangles(var_1);

    if(var_2[1] >= 180 || var_2[1] <= 180) {
      var_3 = distance2d((0, 0, 0), var_1);
      var_4 = max(abs(var_1[0]), abs(var_1[1]));

      if(var_1[0] < 0.8)
        var_0.sprint = 0;

      if(abs(var_3 > 0.1)) {
        var_5 = var_4 / var_3;
        var_1 = var_1 * var_5;
        var_6 = distance((0, 0, 0), var_1);

        if(self attackButtonPressed() || var_0.sprint)
          var_7 = 1.5;
        else
          var_7 = 1;

        thread do_goto_trace(var_0, var_6 * var_6 * var_7 + 0.05, var_1);
      } else if(var_0.script == "dog_move") {}
    } else if(var_0.script == "dog_move") {}

    wait 0.05;
  }
}

dog_attack_internal(var_0, var_1) {
  var_0 endon("cancel_attack");
  self notify("new_goto");
  var_0.moveplaybackrate = 1;
  var_0 dog_command_attack(var_1, self);
}

check_for_enemies(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2);
  var_4 = self getplayerangles();
  var_5 = (var_0.angles[0], var_4[1] - var_3[1], 0);

  if(isDefined(var_0.enemy)) {
    if(isDefined(var_0.enemy.syncedmeleetarget))
      return 1;
  }

  var_6 = find_nearby_enemy(100 * var_1 + 50, var_5);

  if(isDefined(var_6)) {
    if(!isDefined(var_0.favoriteenemy) || var_0.favoriteenemy != var_6) {
      var_0 notify("cancel_attack");
      thread dog_attack_internal(var_0, var_6);
    }

    return 1;
  }

  if(isDefined(var_0.favoriteenemy)) {
    var_7 = anglesToForward(var_5);
    var_8 = vectornormalize(var_0.favoriteenemy.origin - var_0.origin);
    var_9 = vectordot(var_7, var_8);

    if(var_9 > 0.8 || distance(var_0.origin, var_0.favoriteenemy.origin) < 64) {
      var_0.favoriteenemy.ignoreme = 0;
      var_0.ignoreall = 0;
      return 1;
    }
  }

  return 0;
}

do_goto_trace(var_0, var_1, var_2, var_3) {
  self notify("new_goto");
  self endon("new_goto");
  var_4 = maps\_dog_control::get_eye();
  var_5 = vectortoangles(var_2);
  var_6 = self getplayerangles();
  var_7 = (var_0.angles[0], var_6[1] - var_5[1], 0);
  var_8 = var_4 + anglesToForward(var_7) * (100 * var_1 + 32);

  if(!isDefined(var_3)) {
    if(check_for_enemies(var_0, var_1, var_2))
      return;
  }

  var_0.moveplaybackrate = var_1 * 1;
  var_0 notify("cancel_attack");
  var_0.ignoreall = 1;
  var_0.favoriteenemy = undefined;
  default_dog_limits();
  var_9 = bulletTrace(var_4, var_8, 0, var_0);
  var_9["start"] = var_4;
  var_9["end"] = var_8;
  var_10 = var_9["position"];
  var_11 = maps\_dog_control::get_flush_volume(var_10);

  if(isDefined(var_11)) {
    if(!isDefined(var_0.last_command["volume"]) || var_0.last_command["volume"] != var_11) {
      var_0 maps\_utility::ent_flag_set("running_command");
      var_0.last_command["position"] = var_10;
      var_0.last_command["volume"] = var_11;
      var_0.moveplaybackrate = 1;
      var_0 dog_command_flush(var_11, var_9);
      var_0 maps\_utility::ent_flag_clear("running_command");
    }
  } else if(!isDefined(var_0.last_command["position"]) || var_0.last_command["position"] != var_10) {
    var_0 maps\_utility::ent_flag_set("running_command");
    var_0.last_command["position"] = var_10;
    var_0.last_command["volume"] = undefined;
    var_0 dog_command_goto(var_9);
    var_0 maps\_utility::ent_flag_clear("running_command");
  }
}

get_reflected_point(var_0, var_1) {
  var_2 = var_0["start"];
  var_3 = var_0["position"];
  var_4 = var_0["normal"];
  var_5 = var_2 - var_3;

  if(var_5 == (0, 0, 0))
    return var_2;

  var_6 = vectordot(var_5, var_4);
  var_7 = var_1 / var_6;
  var_8 = var_6 * var_4;
  var_9 = var_2 - var_8;
  var_10 = var_9 - var_3;
  var_11 = var_4 * var_1;
  var_12 = length(var_10);
  var_13 = var_10 / var_12;
  var_14 = var_13 * (var_7 * var_12);
  var_15 = var_3 - var_14;
  var_16 = var_15 + var_11;
  var_16 = (var_16[0], var_16[1], var_3[2]);
  return var_16;
}

dog_command_goto(var_0) {
  self.goalheight = 16;
  self.goalradius = 16;
  var_1 = var_0["position"];
  var_2 = var_0["normal"];

  if(abs(var_2[2]) < 0.2 && var_0["fraction"] < 1)
    var_1 = get_reflected_point(var_0, 24);

  var_3 = var_1;
  var_4 = var_1 - (0, 0, 9000);
  var_0 = self aiphysicstrace(var_3, var_4, undefined, undefined, 1, 1);
  var_1 = var_0["position"];
  self setgoalpos(var_1);
  wait 0.2;

  if(isDefined(self.pathgoalpos))
    return;
  else if(distance2d(self.origin, var_1) > self.goalradius) {
    var_5 = getnodesinradius(var_1, 96, 0, 96);
    var_5 = sortbydistance(var_5, self.origin);

    if(var_5.size > 0) {
      var_6 = var_5[0];
      self setgoalpos(var_6.origin);
      self waittill("goal");
    }
  }
}

dog_command_flush(var_0, var_1) {
  var_2 = var_1["position"];
  var_3 = level.dog_flush_functions[var_0.script_noteworthy];
  self thread[[var_3]](var_0, var_1);
  level waittill("dog_flush_started");
  var_0.done_flushing = 1;
  level waittill("dog_flush_done");
}

dog_jumpup(var_0, var_1) {
  level notify("dog_flush_started");
  waittillframeend;
  var_0.done_flushing = undefined;
  thread dog_jumpup_goto(var_1);
  common_scripts\utility::waitframe();
  var_0.done_flushing = undefined;
  var_2 = var_0 common_scripts\utility::get_target_ent();
  thread dog_jumpup_wait(var_2);
  self waittill("command_goto_done");
  level notify("dog_flush_done");
}

dog_jumpup_goto(var_0) {
  self endon("stop_goto");
  dog_command_goto(var_0);
  self notify("command_goto_done");
}

dog_jumpup_wait(var_0) {
  self endon("command_goto_done");
  var_0 waittill("trigger");
  self notify("stop_goto");
  var_1 = var_0 common_scripts\utility::get_target_ent();
  self setgoalpos(var_1.origin);
  self waittill("goal");
  self notify("command_goto_done");
}

#using_animtree("dog");

dog_drive_animscript(var_0) {
  var_0 useanimtree(#animtree);
  var_0 setanimknoball(%german_shepherd_look_forward, %german_shepherd_look, 1, 0.3, 1);
  var_0 setanimlimited(%german_shepherd_look, 1, 0.3, 1);
  var_0 setanimlimited(%german_shepherd_look_left, 1, 0.3, 1);
  var_0 setanimlimited(%german_shepherd_look_right, 1, 0.3, 1);
  var_0 setanimlimited(%german_shepherd_stationaryrun, 1, 0.3, 1);
  var_0 setanimlimited(%german_shepherd_stationaryrun_lean_l, 0, 0.3, 1);
  var_0 setanimlimited(%german_shepherd_stationaryrun_lean_r, 0, 0.3, 1);
  thread track_right_stick(var_0);
  thread track_left_stick(var_0);
}

track_left_stick(var_0) {
  for(;;) {
    var_1 = self getnormalizedmovement();
    var_2 = var_1[0];

    if(var_2 > 0) {
      var_3 = var_2;
      var_0 setanim(%german_shepherd_runinplace, var_3, 0.2, var_3);
      var_0 setanim(%german_shepherd_look, 0, 0.2, 1);
    } else {
      var_0 setanim(%german_shepherd_look, 1, 0.2, 1);
      var_0 setanim(%german_shepherd_runinplace, 0, 0.2, 1);
    }

    var_4 = self getnormalizedcameramovement();
    var_5 = var_4[1];
    var_6 = [];
    var_6["center"] = 0;
    var_6["left"] = 0;
    var_6["right"] = 0;

    if(var_5 > 0) {
      var_6["left"] = 0;
      var_6["right"] = var_5;
      var_6["center"] = 1 - var_6["right"];
    } else if(var_5 < 0) {
      var_6["right"] = 0;
      var_6["left"] = -1 * var_5;
      var_6["center"] = 1 - var_6["left"];
    } else {
      var_6["left"] = 0;
      var_6["right"] = 0;
      var_6["center"] = 1;
    }

    var_0 setanimlimited(%german_shepherd_stationaryrun, var_6["center"], 0.5, 1);
    var_0 setanimlimited(%german_shepherd_stationaryrun_lean_l, var_6["left"], 0.5, 1);
    var_0 setanimlimited(%german_shepherd_stationaryrun_lean_r, var_6["right"], 0.5, 1);
    wait 0.05;
  }
}

track_right_stick(var_0) {
  var_1 = 0.0;
  var_2 = 0.0;

  for(;;) {
    var_3 = self getnormalizedcameramovement();
    var_2 = var_3[1] * 0.85;

    if(var_2 < 0) {
      var_4 = -1 * var_2;
      var_0 setanimlimited(%german_shepherd_look_4, var_4, 0.2, 1);
      var_0 setanimlimited(%german_shepherd_look_6, 0, 0.2, 1);
    } else {
      var_0 setanimlimited(%german_shepherd_look_6, var_2, 0.2, 1);
      var_0 setanimlimited(%german_shepherd_look_4, 0, 0.2, 1);
    }

    wait 0.05;
  }
}

find_nearby_enemy(var_0, var_1) {
  var_2 = undefined;
  var_3 = getaiarray("axis");
  var_4 = [];
  var_5 = level.see_enemy_dot;
  var_6 = level.see_enemy_dot_close;
  var_7 = self;
  var_8 = var_7 maps\_dog_control::get_eye();
  var_3 = sortbydistance(var_3, var_7.controlled_dog.origin);

  foreach(var_10 in var_3) {
    if(!isDefined(var_10.do_not_acquire) && distance(var_10.origin, var_7.controlled_dog.origin) < 64)
      return var_10;
    else
      break;
  }

  foreach(var_10 in var_3) {
    var_13 = (var_8[0], var_8[1], var_10.origin[2]);
    var_14 = vectortoangles(var_10.origin - var_13);
    var_15 = anglesToForward(var_14);
    var_16 = var_1;
    var_17 = anglesToForward(var_16);
    var_18 = vectordot(var_15, var_17);

    if(var_18 > var_6)
      var_4 = common_scripts\utility::array_add(var_4, var_10);
  }

  if(var_4.size > 0) {
    var_4 = sortbydistance(var_4, var_8);

    foreach(var_10 in var_4) {
      if(!isDefined(var_10.do_not_acquire) && maps\_dog_control::test_trace(var_10 getEye(), var_8, var_7.controlled_dog) && (!isDefined(var_0) || distance2d(var_8, var_10.origin) <= var_0))
        return var_10;
    }
  }

  if(!isDefined(var_2)) {
    var_5 = level.see_enemy_dot;

    foreach(var_10 in var_3) {
      var_14 = vectortoangles(var_10.origin - var_8);
      var_15 = anglesToForward(var_14);
      var_16 = var_1;
      var_17 = anglesToForward(var_16);
      var_18 = vectordot(var_15, var_17);

      if(!isDefined(var_10.do_not_acquire) && var_18 > var_5 && maps\_dog_control::test_trace(var_10 getEye(), var_8, var_7.controlled_dog) && (!isDefined(var_0) || distance2d(var_8, var_10.origin) <= var_0)) {
        var_2 = var_10;
        var_5 = var_18;
      }
    }
  }

  return var_2;
}

hud_outlineenable(var_0) {
  if(!isDefined(self.no_more_outlines))
    self hudoutlineenable(var_0, 0);
}

dog_bark_think(var_0) {
  self endon("stop_dog_drive");
  self endon("stop_dog_bark");
  var_0 endon("death");
  self notifyonplayercommand("LISTEN_ads_button_pressed", "+usereload");
  self notifyonplayercommand("LISTEN_ads_button_pressed", "+activate");

  for(;;) {
    self waittill("LISTEN_ads_button_pressed");

    if(!var_0 dog_is_in_combat() && var_0 isdogbeingdriven()) {
      var_0 thread maps\_utility::play_sound_on_entity("anml_dog_bark_attention");
      var_0 maps\_anim::anim_generic(var_0, "dog_bark");
      level notify("dog_barked", var_0);

      if(!common_scripts\utility::flag("_stealth_spotted"))
        var_0 attract_guys_to_dog();
    }

    wait 1;
  }
}

attract_guys_to_dog() {
  var_0 = getaiarray("axis");
  var_0 = sortbydistance(var_0, self.origin);

  foreach(var_2 in var_0) {
    if(isDefined(var_2._stealth)) {
      var_3 = distance(var_2.origin, self.origin);

      if(var_3 < 1000) {
        var_2 maps\_stealth_visibility_enemy::enemy_event_awareness_notify("dog_bark", self);

        if(var_3 < 200)
          var_2 getenemyinfo(level.dog);

        if(var_3 > 300) {
          break;
        }
      } else
        break;
    }
  }
}

inches_to_lattitude(var_0) {
  var_1 = var_0 / 63360.0;
  var_2 = var_1 / 69.0;
  return var_2;
}

trim_decimal_points(var_0, var_1) {
  var_0 = var_0 + "";
  var_2 = strtok(var_0, ".");

  if(var_2.size > 1) {
    if(var_2[1].size > var_1) {
      var_3 = var_2[1];
      var_2[1] = "";

      for(var_4 = 0; var_4 < var_1; var_4++)
        var_2[1] = var_2[1] + var_3[var_4];

      var_1 = 0;
    } else
      var_1 = var_1 - var_2[1].size;
  } else
    var_2[1] = "";

  for(var_4 = 0; var_4 < var_1; var_4++)
    var_2[1] = var_2[1] + "0";

  return var_2[0] + "." + var_2[1];
}

getdirectioncompass(var_0) {
  var_1 = getnorthyaw();
  var_0 = var_0 - var_1;

  if(var_0 < 0)
    var_0 = var_0 + 360;
  else if(var_0 > 360)
    var_0 = var_0 - 360;

  if(var_0 < 22.5 || var_0 > 337.5)
    var_2 = &"NML_DOGCAM_NORTH";
  else if(var_0 < 67.5)
    var_2 = &"NML_DOGCAM_NORTHWEST";
  else if(var_0 < 112.5)
    var_2 = &"NML_DOGCAM_WEST";
  else if(var_0 < 157.5)
    var_2 = &"NML_DOGCAM_SOUTHWEST";
  else if(var_0 < 202.5)
    var_2 = &"NML_DOGCAM_SOUTH";
  else if(var_0 < 247.5)
    var_2 = &"NML_DOGCAM_SOUTHEAST";
  else if(var_0 < 292.5)
    var_2 = &"NML_DOGCAM_EAST";
  else if(var_0 < 337.5)
    var_2 = &"NML_DOGCAM_NORTHEAST";
  else
    var_2 = "";

  return var_2;
}