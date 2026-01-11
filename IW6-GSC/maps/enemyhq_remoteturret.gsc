/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_remoteturret.gsc
*****************************************/

remote_turret_init(var_0) {
  precachemodel("tag_turret");
  precacheturret(var_0);
  precacheshader("gunship_overlay_tow");
  precacheshader("remote_sniper_overlay");
  precacheshader("overlay_static");
  precacheshader("ugv_screen_overlay");
  precacheshader("m1a1_tank_sabot_scanline");
  precacheshader("remote_sniper_compass_bracket_left");
  precacheshader("remote_sniper_compass_bracket_right");
  precacheshader("remote_sniper_compass_pointer_down");
  precacheshader("remote_sniper_compass_pointer_up");
  precacheshader("remote_sniper_incline_mark_left");
  precacheshader("remote_sniper_incline_mark_left_red");
  precacheshader("remote_sniper_incline_mark_right");
  precacheshader("remote_sniper_incline_mark_right_red");
  precacheshader("remote_sniper_label_box_bg_left");
  precacheshader("remote_sniper_label_box_bg_right");
  precacheshader("remote_sniper_reticle");
  precacheshader("remote_sniper_reticle_red");
  precacheshader("remote_sniper_wind_direction");
  precacheshader("red_block");
  precacheshader("green_block");
  precacheshader("m1a1_tank_weapon_progress_bar");
  precachestring(&"ENEMY_HQ_AIR_TEMPERATURE");
  precachestring(&"ENEMY_HQ_DIRECTION");
  precachestring(&"ENEMY_HQ_FIRING");
  precachestring(&"ENEMY_HQ_HUMIDITY");
  precachestring(&"ENEMY_HQ_INCL");
  precachestring(&"ENEMY_HQ_RANGE");
  precachestring(&"ENEMY_HQ_RELOADING");
  precachestring(&"ENEMY_HQ_TARGETING");
  precachestring(&"ENEMY_HQ_REMOTE_SNIPER_WEAPON");
  precachestring(&"ENEMY_HQ_WIND");
  precachestring(&"ENEMY_HQ_NORTH");
  precachestring(&"ENEMY_HQ_SOUTH");
  precachestring(&"ENEMY_HQ_EAST");
  precachestring(&"ENEMY_HQ_WEST");
  precachestring(&"ENEMY_HQ_NORTHWEST");
  precachestring(&"ENEMY_HQ_SOUTHWEST");
  precachestring(&"ENEMY_HQ_SOUTHEAST");
  precachestring(&"ENEMY_HQ_NORTHEAST");
  precachestring(&"ENEMY_HQ_NORTH_BY_NORTHWEST");
  precachestring(&"ENEMY_HQ_WEST_BY_NORTHWEST");
  precachestring(&"ENEMY_HQ_WEST_BY_SOUTHWEST");
  precachestring(&"ENEMY_HQ_SOUTH_BY_SOUTHWEST");
  precachestring(&"ENEMY_HQ_SOUTH_BY_SOUTHEAST");
  precachestring(&"ENEMY_HQ_EAST_BY_SOUTHEAST");
  precachestring(&"ENEMY_HQ_EAST_BY_NORTHEAST");
  precachestring(&"ENEMY_HQ_NORTH_BY_NORTHEAST");
  precachestring(&"ENEMY_HQ_TIMES");
  precachestring(&"ENEMY_HQ_OUT_OF_RANGE");
  common_scripts\utility::flag_init("remote_sniper_ready");
  level.remote_turret_type = var_0;
  level.remote_turret_max_fov = 65;
  level.remote_turret_min_fov = 4;
  level.remote_turret_min_slow_aim_yaw = 0.16;
  level.remote_turret_max_slow_aim_yaw = 0.22;
  level.remote_turret_min_slow_aim_pitch = 0.25;
  level.remote_turret_max_slow_aim_pitch = 0.4;
  level.remote_turret_current_slow_yaw = 0.15;
  level.remote_turret_current_slow_pitch = 0.25;
  level.remote_turret_firing_slow_aim_modifier = 0.0;
  level.remote_turret_current_fov = level.remote_turret_max_fov;
  level.fov_range = level.remote_turret_max_fov - level.remote_turret_min_fov;
  level.slow_aim_yaw_range = level.remote_turret_max_slow_aim_yaw - level.remote_turret_min_slow_aim_yaw;
  level.slow_aim_pitch_range = level.remote_turret_max_slow_aim_pitch - level.remote_turret_min_slow_aim_pitch;
  setdvar("debug_sniper_mode", 1);
  thread remove_remote_turret_targets();
}

remote_turret_activate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  while(maps\_utility::issliding()) {
    wait 0.05;
  }

  if(!isDefined(level.remote_sniper_return_struct)) {
    level.old_player_origin = self.origin;
    level.old_player_angles = self getplayerangles();
    self.prev_stance = self getstance();
  } else {
    level.old_player_origin = level.remote_sniper_return_struct.origin;
    level.old_player_angles = level.remote_sniper_return_struct.angles;
    self.prev_stance = "stand";
    level.remote_sniper_return_struct = undefined;
  }

  level.pre_sniping_weapon = self getcurrentweapon();
  maps\_utility::store_players_weapons("remote_turret");
  self takeallweapons();
  self giveweapon(var_0);
  self switchtoweaponimmediate(var_0);
  self disableweaponswitch();
  self hide();
  self enableinvulnerability();
  self allowads(0);
  self allowmelee(0);
  self allowcrouch(0);
  self allowprone(0);
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("cg_fov", level.remote_turret_current_fov);
  setsaveddvar("hud_showStance", 0);
  self setorigin(var_1);
  self setplayerangles(var_2);

  if(!isDefined(self.player_view_controller_model)) {
    self.player_view_controller_model = spawn("script_model", var_1);
    self.player_view_controller_model setModel("tag_origin");
  }

  self.player_view_controller_model.origin = var_1;
  self.player_view_controller_model.angles = var_2;

  if(!isDefined(self.player_view_controller)) {
    self.player_view_controller = maps\_utility::get_player_view_controller(self.player_view_controller_model, "tag_origin", (0, 0, 0), level.remote_turret_type);
  }

  if(!isDefined(self.turret_look_at_ent)) {
    self.turret_look_at_ent = spawn("script_model", var_1);
    self.turret_look_at_ent setModel("tag_origin");
  }

  self.turret_look_at_ent.origin = var_1 + anglesToForward(var_2) * 6000;
  self.player_view_controller snaptotargetentity(self.turret_look_at_ent);

  switch (getdvarint("debug_sniper_mode", 1)) {
    case 2:
    case 1:
    case 0:
      self playerlinktodelta(self.player_view_controller, "tag_aim", 1.0, var_3, var_4, var_5, var_6);
      break;
    case 4:
    case 3:
      self playerlinktodelta(self.player_view_controller, "tag_aim", 1.0, 0, 0, 0, 0);
      break;
  }

  if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
    self enablemousesteer(1);
  }

  if(isDefined(level.sniper_vision_override)) {
    self visionsetnakedforplayer(level.sniper_vision_override, 0.25);
  } else {
    self visionsetnakedforplayer("enemyhq_sniper_view", 0.25);
  }

  thread remote_turret_handle_zoom();
  thread set_slow_aim();

  if(!isDefined(self.allow_dry_fire) || self.allow_dry_fire == 0) {
    thread remote_turret_monitor_ammo(var_0);
  } else {
    self setweaponammoclip(var_0, 0);
    thread remote_turret_monitor_dryfire(var_0);
  }

  thread update_remote_turret_targets();
  thread remote_turret_hud();
  thread remote_turret_update_player_position();
  common_scripts\utility::flag_set("remote_sniper_ready");
}

restore_weapons_no_first_raise(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(self.stored_weapons) || !isDefined(self.stored_weapons[var_0])) {
    return;
  }
  self takeallweapons();

  foreach(var_3, var_2 in self.stored_weapons[var_0]["inventory"]) {
    if(weaponinventorytype(var_3) != "altmode") {
      self giveweapon(var_3, 0, 0, 0, 1);
    }

    self setweaponammoclip(var_3, var_2["clip_left"], "left");
    self setweaponammoclip(var_3, var_2["clip_right"], "right");
    self setweaponammostock(var_3, var_2["stock"]);
  }

  var_4 = self.stored_weapons[var_0]["current_weapon"];

  if(var_4 != "none") {
    self switchtoweapon(var_4);
  }
}

remote_turret_deactivate() {
  self notify("remote_turret_deactivate");
  common_scripts\utility::flag_clear("remote_sniper_ready");
  remote_turret_clear_hud();
  self disableslowaim();
  self unlink();
  self setstance(self.prev_stance);
  self setorigin(level.old_player_origin);
  self setplayerangles(level.old_player_angles);
  self freezecontrols(1);
  restore_weapons_no_first_raise("remote_turret");
  self visionsetnakedforplayer("", 0.25);
  self allowads(1);
  self allowmelee(1);
  self allowcrouch(1);
  self allowprone(1);

  if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
    self enablemousesteer(0);
  }

  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("cg_fov", 65);
  setsaveddvar("hud_showStance", 1);
  self.player_view_controller delete();
  self.player_view_controller = undefined;
  self.player_view_controller_model delete();
  self.player_view_controller_model = undefined;
  self.turret_look_at_ent delete();
  self.turret_look_at_ent = undefined;

  if(isDefined(level.sniper_wait_extra_black)) {
    wait(level.sniper_wait_extra_black);
    level.sniper_wait_extra_black = undefined;
  } else
    setsaveddvar("ammoCounterHide", "0");

  thread maps\enemyhq_audio::aud_end_sniper();
  self enableweaponswitch();
  self switchtoweaponimmediate(level.pre_sniping_weapon);
  self takeweapon("remote_sniper");
  self enableoffhandweapons();
  self show();
  wait 1.25;
  self freezecontrols(0);
  self disableinvulnerability();
}

remote_turret_hud() {
  level.remote_turret_hud = [];

  if(!isDefined(level.remote_turret_fade_in)) {
    level.remote_turret_fade_in = 1;
  }

  var_0 = 100;
  var_1 = 25;
  var_2 = 72.5;
  var_3 = var_2 - 12.5;
  var_4 = 1.0;
  level.remote_turret_hud["device_overlay"] = maps\_hud_util::create_client_overlay("remote_sniper_overlay", 1);
  level.remote_turret_hud["device_overlay"].foreground = 0;
  level.remote_turret_hud["reticle"] = maps\_hud_util::createclienticon("remote_sniper_reticle", 620, 310);
  level.remote_turret_hud["reticle"] set_default_hud_parameters();
  level.remote_turret_hud["reticle"].alignx = "center";
  level.remote_turret_hud["reticle"].aligny = "middle";
  level.remote_turret_hud["reticle"].sort = level.remote_turret_hud["reticle"].sort - 15;
  level.remote_turret_hud["reticle_red"] = maps\_hud_util::createclienticon("remote_sniper_reticle_red", 620, 310);
  level.remote_turret_hud["reticle_red"] set_default_hud_parameters();
  level.remote_turret_hud["reticle_red"].alignx = "center";
  level.remote_turret_hud["reticle_red"].aligny = "middle";
  level.remote_turret_hud["reticle_red"].alpha = 0;
  level.remote_turret_hud["reticle_red"].sort = level.remote_turret_hud["reticle_red"].sort - 15;
  level.remote_turret_hud["hash_bkg_left"] = maps\_hud_util::createclienticon("white", 40, 320);
  level.remote_turret_hud["hash_bkg_left"] set_default_hud_parameters();
  level.remote_turret_hud["hash_bkg_left"].alignx = "right";
  level.remote_turret_hud["hash_bkg_left"].aligny = "middle";
  level.remote_turret_hud["hash_bkg_left"].horzalign = "left";
  level.remote_turret_hud["hash_bkg_left"].vertalign = "middle";
  level.remote_turret_hud["hash_bkg_left"].x = var_2;
  level.remote_turret_hud["hash_bkg_left"].y = 0;
  level.remote_turret_hud["hash_bkg_left"].alpha = 0.0;
  level.remote_turret_hud["range_bkg"] = maps\_hud_util::createclienticon("remote_sniper_label_box_bg_left", var_0, var_1);
  level.remote_turret_hud["range_bkg"] set_default_hud_parameters();
  level.remote_turret_hud["range_bkg"].alignx = "right";
  level.remote_turret_hud["range_bkg"].aligny = "middle";
  level.remote_turret_hud["range_bkg"].horzalign = "left";
  level.remote_turret_hud["range_bkg"].vertalign = "middle";
  level.remote_turret_hud["range_bkg"].x = var_2;
  level.remote_turret_hud["range_bkg"].y = -180;
  level.remote_turret_hud["range_bkg"].sort = level.remote_turret_hud["range_bkg"].sort - 1;
  level.remote_turret_hud["range_txt"] = maps\_hud_util::createclientfontstring("small", var_4);
  level.remote_turret_hud["range_txt"] set_default_hud_parameters();
  level.remote_turret_hud["range_txt"].alignx = "right";
  level.remote_turret_hud["range_txt"].aligny = "middle";
  level.remote_turret_hud["range_txt"].horzalign = "left";
  level.remote_turret_hud["range_txt"].vertalign = "middle";
  level.remote_turret_hud["range_txt"].x = var_3;
  level.remote_turret_hud["range_txt"].y = level.remote_turret_hud["range_bkg"].y;
  level.remote_turret_hud["range_txt"] settext(&"ENEMY_HQ_RANGE");
  level.remote_turret_hud["range_val"] = maps\_hud_util::createclientfontstring("small", 1.6);
  level.remote_turret_hud["range_val"] set_default_hud_parameters();
  level.remote_turret_hud["range_val"].alignx = "right";
  level.remote_turret_hud["range_val"].aligny = "top";
  level.remote_turret_hud["range_val"].horzalign = "left";
  level.remote_turret_hud["range_val"].vertalign = "middle";
  level.remote_turret_hud["range_val"].x = var_3 - 10;
  level.remote_turret_hud["range_val"].y = level.remote_turret_hud["range_bkg"].y + var_1 * 0.75;
  level.remote_turret_hud["range_val"] thread remote_turret_update_range();
  level.remote_turret_hud["incl_left_bkg"] = maps\_hud_util::createclienticon("remote_sniper_label_box_bg_left", var_0, var_1);
  level.remote_turret_hud["incl_left_bkg"] set_default_hud_parameters();
  level.remote_turret_hud["incl_left_bkg"].alignx = "right";
  level.remote_turret_hud["incl_left_bkg"].aligny = "middle";
  level.remote_turret_hud["incl_left_bkg"].horzalign = "left";
  level.remote_turret_hud["incl_left_bkg"].vertalign = "middle";
  level.remote_turret_hud["incl_left_bkg"].x = var_2;
  level.remote_turret_hud["incl_left_bkg"].y = level.remote_turret_hud["hash_bkg_left"].height * -0.333;
  level.remote_turret_hud["incl_left_bkg"].sort = level.remote_turret_hud["incl_left_bkg"].sort - 1;
  level.remote_turret_hud["incl_left_txt"] = maps\_hud_util::createclientfontstring("small", var_4);
  level.remote_turret_hud["incl_left_txt"] set_default_hud_parameters();
  level.remote_turret_hud["incl_left_txt"].alignx = "right";
  level.remote_turret_hud["incl_left_txt"].aligny = "middle";
  level.remote_turret_hud["incl_left_txt"].horzalign = "left";
  level.remote_turret_hud["incl_left_txt"].vertalign = "middle";
  level.remote_turret_hud["incl_left_txt"].x = var_3;
  level.remote_turret_hud["incl_left_txt"].y = level.remote_turret_hud["incl_left_bkg"].y;
  level.remote_turret_hud["incl_left_txt"] settext(&"ENEMY_HQ_INCL");
  level.remote_turret_hud["incl_mark_left"] = maps\_hud_util::createclienticon("remote_sniper_incline_mark_left", 80, 10);
  level.remote_turret_hud["incl_mark_left"] set_default_hud_parameters();
  level.remote_turret_hud["incl_mark_left"].alignx = "right";
  level.remote_turret_hud["incl_mark_left"].aligny = "middle";
  level.remote_turret_hud["incl_mark_left"].horzalign = "left";
  level.remote_turret_hud["incl_mark_left"].vertalign = "middle";
  level.remote_turret_hud["incl_mark_left"].x = var_2 - level.remote_turret_hud["hash_bkg_left"].width * 0.5;
  level.remote_turret_hud["incl_mark_left"].y = 0;
  level.remote_turret_hud["incl_mark_left_red"] = maps\_hud_util::createclienticon("remote_sniper_incline_mark_left_red", 80, 10);
  level.remote_turret_hud["incl_mark_left_red"] set_default_hud_parameters();
  level.remote_turret_hud["incl_mark_left_red"].alignx = "right";
  level.remote_turret_hud["incl_mark_left_red"].aligny = "middle";
  level.remote_turret_hud["incl_mark_left_red"].horzalign = "left";
  level.remote_turret_hud["incl_mark_left_red"].vertalign = "middle";
  level.remote_turret_hud["incl_mark_left_red"].x = var_2 - level.remote_turret_hud["hash_bkg_left"].width * 0.5;
  level.remote_turret_hud["incl_mark_left_red"].y = 0;
  level.remote_turret_hud["incl_mark_left_red"].alpha = 0;
  level.remote_turret_hud["wind_bkg"] = maps\_hud_util::createclienticon("remote_sniper_label_box_bg_left", var_0, var_1);
  level.remote_turret_hud["wind_bkg"] set_default_hud_parameters();
  level.remote_turret_hud["wind_bkg"].alignx = "right";
  level.remote_turret_hud["wind_bkg"].aligny = "middle";
  level.remote_turret_hud["wind_bkg"].horzalign = "left";
  level.remote_turret_hud["wind_bkg"].vertalign = "middle";
  level.remote_turret_hud["wind_bkg"].x = var_2;
  level.remote_turret_hud["wind_bkg"].y = level.remote_turret_hud["hash_bkg_left"].height * 0.4;
  level.remote_turret_hud["wind_bkg"].sort = level.remote_turret_hud["wind_bkg"].sort - 1;
  level.remote_turret_hud["wind_txt"] = maps\_hud_util::createclientfontstring("small", var_4);
  level.remote_turret_hud["wind_txt"] set_default_hud_parameters();
  level.remote_turret_hud["wind_txt"].alignx = "right";
  level.remote_turret_hud["wind_txt"].aligny = "middle";
  level.remote_turret_hud["wind_txt"].horzalign = "left";
  level.remote_turret_hud["wind_txt"].vertalign = "middle";
  level.remote_turret_hud["wind_txt"].x = var_3;
  level.remote_turret_hud["wind_txt"].y = level.remote_turret_hud["wind_bkg"].y;
  level.remote_turret_hud["wind_txt"] settext(&"ENEMY_HQ_WIND");
  level.remote_turret_hud["wind_val"] = maps\_hud_util::createclientfontstring("small", 1.6);
  level.remote_turret_hud["wind_val"] set_default_hud_parameters();
  level.remote_turret_hud["wind_val"].alignx = "right";
  level.remote_turret_hud["wind_val"].aligny = "top";
  level.remote_turret_hud["wind_val"].horzalign = "left";
  level.remote_turret_hud["wind_val"].vertalign = "middle";
  level.remote_turret_hud["wind_val"].x = var_3 - 10;
  level.remote_turret_hud["wind_val"].y = level.remote_turret_hud["wind_bkg"].y + var_1;
  level.remote_turret_hud["wind_val"] thread remote_turret_update_wind();
  level.remote_turret_hud["wind_dir"] = maps\_hud_util::createclienticon("remote_sniper_wind_direction", int(var_1 * 0.75), int(var_1 * 0.75 * 0.5));
  level.remote_turret_hud["wind_dir"] set_default_hud_parameters();
  level.remote_turret_hud["wind_dir"].alignx = "right";
  level.remote_turret_hud["wind_dir"].aligny = "top";
  level.remote_turret_hud["wind_dir"].horzalign = "left";
  level.remote_turret_hud["wind_dir"].vertalign = "middle";
  level.remote_turret_hud["wind_dir"].x = var_2;
  level.remote_turret_hud["wind_dir"].y = level.remote_turret_hud["wind_val"].y;
  level.remote_turret_hud["wind_dir_txt"] = maps\_hud_util::createclientfontstring("small", 0.8);
  level.remote_turret_hud["wind_dir_txt"] set_default_hud_parameters();
  level.remote_turret_hud["wind_dir_txt"].alignx = "right";
  level.remote_turret_hud["wind_dir_txt"].aligny = "top";
  level.remote_turret_hud["wind_dir_txt"].horzalign = "left";
  level.remote_turret_hud["wind_dir_txt"].vertalign = "middle";
  level.remote_turret_hud["wind_dir_txt"].x = var_2 - 4;
  level.remote_turret_hud["wind_dir_txt"].y = level.remote_turret_hud["wind_dir"].y + level.remote_turret_hud["wind_dir"].height;
  level.remote_turret_hud["wind_dir_txt"] settext(&"ENEMY_HQ_DIRECTION");
  level.remote_turret_hud["hash_bkg_right"] = maps\_hud_util::createclienticon("white", 40, 320);
  level.remote_turret_hud["hash_bkg_right"] set_default_hud_parameters();
  level.remote_turret_hud["hash_bkg_right"].alignx = "left";
  level.remote_turret_hud["hash_bkg_right"].aligny = "middle";
  level.remote_turret_hud["hash_bkg_right"].horzalign = "right";
  level.remote_turret_hud["hash_bkg_right"].vertalign = "middle";
  level.remote_turret_hud["hash_bkg_right"].x = 0 - var_2;
  level.remote_turret_hud["hash_bkg_right"].y = 0;
  level.remote_turret_hud["hash_bkg_right"].alpha = 0.0;
  level.remote_turret_hud["air_temp_bkg"] = maps\_hud_util::createclienticon("remote_sniper_label_box_bg_right", var_0, var_1);
  level.remote_turret_hud["air_temp_bkg"] set_default_hud_parameters();
  level.remote_turret_hud["air_temp_bkg"].alignx = "left";
  level.remote_turret_hud["air_temp_bkg"].aligny = "middle";
  level.remote_turret_hud["air_temp_bkg"].horzalign = "right";
  level.remote_turret_hud["air_temp_bkg"].vertalign = "middle";
  level.remote_turret_hud["air_temp_bkg"].x = 0 - var_2;
  level.remote_turret_hud["air_temp_bkg"].y = -180;
  level.remote_turret_hud["air_temp_bkg"].sort = level.remote_turret_hud["air_temp_bkg"].sort - 1;
  level.remote_turret_hud["air_temp_txt"] = maps\_hud_util::createclientfontstring("small", var_4);
  level.remote_turret_hud["air_temp_txt"] set_default_hud_parameters();
  level.remote_turret_hud["air_temp_txt"].alignx = "left";
  level.remote_turret_hud["air_temp_txt"].aligny = "middle";
  level.remote_turret_hud["air_temp_txt"].horzalign = "right";
  level.remote_turret_hud["air_temp_txt"].vertalign = "middle";
  level.remote_turret_hud["air_temp_txt"].x = 0 - var_3;
  level.remote_turret_hud["air_temp_txt"].y = level.remote_turret_hud["air_temp_bkg"].y;
  level.remote_turret_hud["air_temp_txt"] settext(&"ENEMY_HQ_AIR_TEMPERATURE");
  level.remote_turret_hud["air_temp_val"] = maps\_hud_util::createclientfontstring("small", 1.6);
  level.remote_turret_hud["air_temp_val"] set_default_hud_parameters();
  level.remote_turret_hud["air_temp_val"].alignx = "left";
  level.remote_turret_hud["air_temp_val"].aligny = "top";
  level.remote_turret_hud["air_temp_val"].horzalign = "right";
  level.remote_turret_hud["air_temp_val"].vertalign = "middle";
  level.remote_turret_hud["air_temp_val"].x = 0 - var_3 + 10;
  level.remote_turret_hud["air_temp_val"].y = level.remote_turret_hud["air_temp_bkg"].y + var_1 * 0.75;
  level.remote_turret_hud["air_temp_val"] thread remote_turret_update_air_temp();
  level.remote_turret_hud["incl_right_bkg"] = maps\_hud_util::createclienticon("remote_sniper_label_box_bg_right", var_0, var_1);
  level.remote_turret_hud["incl_right_bkg"] set_default_hud_parameters();
  level.remote_turret_hud["incl_right_bkg"].alignx = "left";
  level.remote_turret_hud["incl_right_bkg"].aligny = "middle";
  level.remote_turret_hud["incl_right_bkg"].horzalign = "right";
  level.remote_turret_hud["incl_right_bkg"].vertalign = "middle";
  level.remote_turret_hud["incl_right_bkg"].x = 0 - var_2;
  level.remote_turret_hud["incl_right_bkg"].y = level.remote_turret_hud["hash_bkg_right"].height * -0.333;
  level.remote_turret_hud["incl_right_bkg"].sort = level.remote_turret_hud["incl_right_bkg"].sort - 1;
  level.remote_turret_hud["incl_right_txt"] = maps\_hud_util::createclientfontstring("small", var_4);
  level.remote_turret_hud["incl_right_txt"] set_default_hud_parameters();
  level.remote_turret_hud["incl_right_txt"].alignx = "left";
  level.remote_turret_hud["incl_right_txt"].aligny = "middle";
  level.remote_turret_hud["incl_right_txt"].horzalign = "right";
  level.remote_turret_hud["incl_right_txt"].vertalign = "middle";
  level.remote_turret_hud["incl_right_txt"].x = 0 - var_3;
  level.remote_turret_hud["incl_right_txt"].y = level.remote_turret_hud["incl_right_bkg"].y;
  level.remote_turret_hud["incl_right_txt"] settext(&"ENEMY_HQ_INCL");
  level.remote_turret_hud["incl_mark_right"] = maps\_hud_util::createclienticon("remote_sniper_incline_mark_right", 80, 10);
  level.remote_turret_hud["incl_mark_right"] set_default_hud_parameters();
  level.remote_turret_hud["incl_mark_right"].alignx = "left";
  level.remote_turret_hud["incl_mark_right"].aligny = "middle";
  level.remote_turret_hud["incl_mark_right"].horzalign = "right";
  level.remote_turret_hud["incl_mark_right"].vertalign = "middle";
  level.remote_turret_hud["incl_mark_right"].x = 0 - var_2 + level.remote_turret_hud["hash_bkg_right"].width * 0.5;
  level.remote_turret_hud["incl_mark_right"].y = 0;
  level.remote_turret_hud["incl_mark_right_red"] = maps\_hud_util::createclienticon("remote_sniper_incline_mark_right_red", 80, 10);
  level.remote_turret_hud["incl_mark_right_red"] set_default_hud_parameters();
  level.remote_turret_hud["incl_mark_right_red"].alignx = "left";
  level.remote_turret_hud["incl_mark_right_red"].aligny = "middle";
  level.remote_turret_hud["incl_mark_right_red"].horzalign = "right";
  level.remote_turret_hud["incl_mark_right_red"].vertalign = "middle";
  level.remote_turret_hud["incl_mark_right_red"].x = 0 - var_2 + level.remote_turret_hud["hash_bkg_right"].width * 0.5;
  level.remote_turret_hud["incl_mark_right_red"].y = 0;
  level.remote_turret_hud["incl_mark_right_red"].alpha = 0;
  level.remote_turret_hud["humidity_bkg"] = maps\_hud_util::createclienticon("remote_sniper_label_box_bg_right", var_0, var_1);
  level.remote_turret_hud["humidity_bkg"] set_default_hud_parameters();
  level.remote_turret_hud["humidity_bkg"].alignx = "left";
  level.remote_turret_hud["humidity_bkg"].aligny = "middle";
  level.remote_turret_hud["humidity_bkg"].horzalign = "right";
  level.remote_turret_hud["humidity_bkg"].vertalign = "middle";
  level.remote_turret_hud["humidity_bkg"].x = 0 - var_2;
  level.remote_turret_hud["humidity_bkg"].y = level.remote_turret_hud["hash_bkg_right"].height * 0.4;
  level.remote_turret_hud["humidity_bkg"].sort = level.remote_turret_hud["humidity_bkg"].sort - 1;
  level.remote_turret_hud["humidity_txt"] = maps\_hud_util::createclientfontstring("small", var_4);
  level.remote_turret_hud["humidity_txt"] set_default_hud_parameters();
  level.remote_turret_hud["humidity_txt"].alignx = "left";
  level.remote_turret_hud["humidity_txt"].aligny = "middle";
  level.remote_turret_hud["humidity_txt"].horzalign = "right";
  level.remote_turret_hud["humidity_txt"].vertalign = "middle";
  level.remote_turret_hud["humidity_txt"].x = 0 - var_3;
  level.remote_turret_hud["humidity_txt"].y = level.remote_turret_hud["humidity_bkg"].y;
  level.remote_turret_hud["humidity_txt"] settext(&"ENEMY_HQ_HUMIDITY");
  level.remote_turret_hud["humidity_val"] = maps\_hud_util::createclientfontstring("small", 1.6);
  level.remote_turret_hud["humidity_val"] set_default_hud_parameters();
  level.remote_turret_hud["humidity_val"].alignx = "left";
  level.remote_turret_hud["humidity_val"].aligny = "top";
  level.remote_turret_hud["humidity_val"].horzalign = "right";
  level.remote_turret_hud["humidity_val"].vertalign = "middle";
  level.remote_turret_hud["humidity_val"].x = 0 - var_3 + 10;
  level.remote_turret_hud["humidity_val"].y = level.remote_turret_hud["humidity_bkg"].y + var_1;
  level.remote_turret_hud["humidity_val"] thread remote_turret_update_humidity();
  level.remote_turret_hud["compass_bracket_left"] = maps\_hud_util::createclienticon("remote_sniper_compass_bracket_left", int(var_1 / 4), var_1);
  level.remote_turret_hud["compass_bracket_left"] set_default_hud_parameters();
  level.remote_turret_hud["compass_bracket_left"].alignx = "right";
  level.remote_turret_hud["compass_bracket_left"].aligny = "middle";
  level.remote_turret_hud["compass_bracket_left"].horzalign = "center";
  level.remote_turret_hud["compass_bracket_left"].vertalign = "top";
  level.remote_turret_hud["compass_bracket_left"].x = -160;
  level.remote_turret_hud["compass_bracket_left"].y = 25;
  level.remote_turret_hud["compass_bracket_right"] = maps\_hud_util::createclienticon("remote_sniper_compass_bracket_right", int(var_1 / 4), var_1);
  level.remote_turret_hud["compass_bracket_right"] set_default_hud_parameters();
  level.remote_turret_hud["compass_bracket_right"].alignx = "left";
  level.remote_turret_hud["compass_bracket_right"].aligny = "middle";
  level.remote_turret_hud["compass_bracket_right"].horzalign = "center";
  level.remote_turret_hud["compass_bracket_right"].vertalign = "top";
  level.remote_turret_hud["compass_bracket_right"].x = 160;
  level.remote_turret_hud["compass_bracket_right"].y = 25;
  level.remote_turret_hud["compass_arrow_up"] = maps\_hud_util::createclienticon("remote_sniper_compass_pointer_up", level.remote_turret_hud["compass_bracket_left"].width, level.remote_turret_hud["compass_bracket_left"].width);
  level.remote_turret_hud["compass_arrow_up"] set_default_hud_parameters();
  level.remote_turret_hud["compass_arrow_up"].alignx = "center";
  level.remote_turret_hud["compass_arrow_up"].aligny = "top";
  level.remote_turret_hud["compass_arrow_up"].horzalign = "center";
  level.remote_turret_hud["compass_arrow_up"].vertalign = "top";
  level.remote_turret_hud["compass_arrow_up"].x = 0;
  level.remote_turret_hud["compass_arrow_up"].y = level.remote_turret_hud["compass_bracket_left"].y + level.remote_turret_hud["compass_bracket_left"].height * 0.5;
  level.remote_turret_hud["compass_arrow_down"] = maps\_hud_util::createclienticon("remote_sniper_compass_pointer_down", level.remote_turret_hud["compass_bracket_left"].width, level.remote_turret_hud["compass_bracket_left"].width);
  level.remote_turret_hud["compass_arrow_down"] set_default_hud_parameters();
  level.remote_turret_hud["compass_arrow_down"].alignx = "center";
  level.remote_turret_hud["compass_arrow_down"].aligny = "bottom";
  level.remote_turret_hud["compass_arrow_down"].horzalign = "center";
  level.remote_turret_hud["compass_arrow_down"].vertalign = "top";
  level.remote_turret_hud["compass_arrow_down"].x = 0;
  level.remote_turret_hud["compass_arrow_down"].y = level.remote_turret_hud["compass_bracket_left"].y - level.remote_turret_hud["compass_bracket_left"].height * 0.5;
  level.remote_turret_hud["compass_heading"] = maps\_hud_util::createclientfontstring("small", 0.8);
  level.remote_turret_hud["compass_heading"] set_default_hud_parameters();
  level.remote_turret_hud["compass_heading"].alignx = "center";
  level.remote_turret_hud["compass_heading"].aligny = "top";
  level.remote_turret_hud["compass_heading"].horzalign = "center";
  level.remote_turret_hud["compass_heading"].vertalign = "top";
  level.remote_turret_hud["compass_heading"].x = 0;
  level.remote_turret_hud["compass_heading"].y = level.remote_turret_hud["compass_arrow_up"].y + level.remote_turret_hud["compass_arrow_up"].height * 0.75;
  level.remote_turret_hud["weapon_status_bg"] = maps\_hud_util::createclienticon("black", 75, 18);
  level.remote_turret_hud["weapon_status_bg"] set_default_hud_parameters();
  level.remote_turret_hud["weapon_status_bg"].alignx = "right";
  level.remote_turret_hud["weapon_status_bg"].aligny = "middle";
  level.remote_turret_hud["weapon_status_bg"].horzalign = "right";
  level.remote_turret_hud["weapon_status_bg"].vertalign = "bottom";
  level.remote_turret_hud["weapon_status_bg"].x = 0 - var_2 - (var_2 - var_3);
  level.remote_turret_hud["weapon_status_bg"].y = -51;
  level.remote_turret_hud["weapon_status_bg"].sort = level.remote_turret_hud["weapon_status_bg"].sort - 1;
  level.remote_turret_hud["weapon_status_bg"].alpha = 0.333;
  level.remote_turret_hud["weapon_status_txt"] = maps\_hud_util::createclientfontstring("small", 1.1);
  level.remote_turret_hud["weapon_status_txt"] set_default_hud_parameters();
  level.remote_turret_hud["weapon_status_txt"].alignx = "center";
  level.remote_turret_hud["weapon_status_txt"].aligny = "middle";
  level.remote_turret_hud["weapon_status_txt"].horzalign = "right";
  level.remote_turret_hud["weapon_status_txt"].vertalign = "bottom";
  level.remote_turret_hud["weapon_status_txt"].x = 0 - var_2 - (var_2 - var_3) - level.remote_turret_hud["weapon_status_bg"].width / 2;
  level.remote_turret_hud["weapon_status_txt"].y = level.remote_turret_hud["weapon_status_bg"].y;
  level.remote_turret_hud["weapon_status_txt"].alpha = 0.666;
  level.remote_turret_hud["weapon_name_bg"] = maps\_hud_util::createclienticon("black", 75, 20);
  level.remote_turret_hud["weapon_name_bg"] set_default_hud_parameters();
  level.remote_turret_hud["weapon_name_bg"].alignx = "right";
  level.remote_turret_hud["weapon_name_bg"].aligny = "top";
  level.remote_turret_hud["weapon_name_bg"].horzalign = "right";
  level.remote_turret_hud["weapon_name_bg"].vertalign = "bottom";
  level.remote_turret_hud["weapon_name_bg"].x = 0 - var_2 - (var_2 - var_3);
  level.remote_turret_hud["weapon_name_bg"].y = level.remote_turret_hud["weapon_status_bg"].y + level.remote_turret_hud["weapon_status_bg"].height / 2 + 1;
  level.remote_turret_hud["weapon_name_bg"].sort = level.remote_turret_hud["weapon_name_bg"].sort - 1;
  level.remote_turret_hud["weapon_name_bg"].alpha = 0.333;
  level.remote_turret_hud["weapon_name_txt"] = maps\_hud_util::createclientfontstring("small", 0.8);
  level.remote_turret_hud["weapon_name_txt"] set_default_hud_parameters();
  level.remote_turret_hud["weapon_name_txt"].alignx = "center";
  level.remote_turret_hud["weapon_name_txt"].aligny = "top";
  level.remote_turret_hud["weapon_name_txt"].horzalign = "right";
  level.remote_turret_hud["weapon_name_txt"].vertalign = "bottom";
  level.remote_turret_hud["weapon_name_txt"].x = 0 - var_2 - (var_2 - var_3) - level.remote_turret_hud["weapon_name_bg"].width / 2;
  level.remote_turret_hud["weapon_name_txt"].y = level.remote_turret_hud["weapon_name_bg"].y + 1;
  level.remote_turret_hud["weapon_name_txt"].alpha = 0.75;
  level.remote_turret_hud["weapon_name_txt"] settext(&"ENEMY_HQ_REMOTE_SNIPER_WEAPON");
  level.remote_turret_hud["weapon_name_bar_bg"] = maps\_hud_util::createclienticon("m1a1_tank_weapon_progress_bar", 104, 13);
  level.remote_turret_hud["weapon_name_bar_bg"] set_default_hud_parameters();
  level.remote_turret_hud["weapon_name_bar_bg"].alignx = "center";
  level.remote_turret_hud["weapon_name_bar_bg"].aligny = "top";
  level.remote_turret_hud["weapon_name_bar_bg"].horzalign = "right";
  level.remote_turret_hud["weapon_name_bar_bg"].vertalign = "bottom";
  level.remote_turret_hud["weapon_name_bar_bg"].x = level.remote_turret_hud["weapon_name_txt"].x;
  level.remote_turret_hud["weapon_name_bar_bg"].y = level.remote_turret_hud["weapon_name_txt"].y + level.remote_turret_hud["weapon_name_bg"].height * 0.4;
  level.remote_turret_hud["weapon_name_bar"] = maps\_hud_util::createclienticon("green_block", int(level.remote_turret_hud["weapon_name_bar_bg"].width * 0.6), int(level.remote_turret_hud["weapon_name_bar_bg"].height * 0.5));
  level.remote_turret_hud["weapon_name_bar"] set_default_hud_parameters();
  level.remote_turret_hud["weapon_name_bar"].alignx = "left";
  level.remote_turret_hud["weapon_name_bar"].aligny = "top";
  level.remote_turret_hud["weapon_name_bar"].horzalign = "right";
  level.remote_turret_hud["weapon_name_bar"].vertalign = "bottom";
  level.remote_turret_hud["weapon_name_bar"].x = level.remote_turret_hud["weapon_name_bar_bg"].x - level.remote_turret_hud["weapon_name_bar"].width / 2;
  level.remote_turret_hud["weapon_name_bar"].y = level.remote_turret_hud["weapon_name_bar_bg"].y + int(level.remote_turret_hud["weapon_name_bar_bg"].height * 0.25);
  level.remote_turret_hud["weapon_name_bar"].sort = level.remote_turret_hud["weapon_name_bar"].sort + 1;

  if(isDefined(level.player.allow_dry_fire) && level.player.allow_dry_fire) {
    level.remote_turret_hud["weapon_name_bar"].alpha = 0;
  } else {
    level.remote_turret_hud["weapon_name_bar"].alpha = 0.5;
  }

  level.remote_turret_hud["zoom_txt"] = maps\_hud_util::createclientfontstring("small", 1.2);
  level.remote_turret_hud["zoom_txt"] set_default_hud_parameters();
  level.remote_turret_hud["zoom_txt"].alignx = "center";
  level.remote_turret_hud["zoom_txt"].aligny = "middle";
  level.remote_turret_hud["zoom_txt"].horzalign = "center";
  level.remote_turret_hud["zoom_txt"].vertalign = "bottom";
  level.remote_turret_hud["zoom_txt"].x = 0;
  level.remote_turret_hud["zoom_txt"].y = -15;
  level.remote_turret_compass_lines = [];

  for(var_5 = 0; var_5 < 9; var_5++) {
    level.remote_turret_compass_lines[var_5] = maps\_hud_util::createclienticon("white", 1, int(var_1 * 0.8));
    level.remote_turret_compass_lines[var_5] set_default_hud_parameters();
    level.remote_turret_compass_lines[var_5].alignx = "center";
    level.remote_turret_compass_lines[var_5].aligny = "middle";
    level.remote_turret_compass_lines[var_5].horzalign = "center";
    level.remote_turret_compass_lines[var_5].vertalign = "top";
    level.remote_turret_compass_lines[var_5].y = level.remote_turret_hud["compass_bracket_left"].y;
    level.remote_turret_compass_lines[var_5] thread remote_turret_delay_fade_in(level.remote_turret_compass_lines[var_5].alpha, 0.5, 0.5);
  }

  level.remote_turret_compass_numbers = [];

  for(var_5 = 0; var_5 < level.remote_turret_compass_lines.size; var_5++) {
    level.remote_turret_compass_numbers[var_5] = maps\_hud_util::createclientfontstring("small", var_4);
    level.remote_turret_compass_numbers[var_5] set_default_hud_parameters();
    level.remote_turret_compass_numbers[var_5].alignx = "center";
    level.remote_turret_compass_numbers[var_5].aligny = "middle";
    level.remote_turret_compass_numbers[var_5].horzalign = "center";
    level.remote_turret_compass_numbers[var_5].vertalign = "top";
    level.remote_turret_compass_numbers[var_5].y = level.remote_turret_hud["compass_bracket_left"].y;
    level.remote_turret_compass_numbers[var_5] thread remote_turret_delay_fade_in(level.remote_turret_compass_numbers[var_5].alpha, 0.5, 0.5);
  }

  level.remote_turret_pitch_lines_left = [];

  for(var_5 = 0; var_5 < 11; var_5++) {
    level.remote_turret_pitch_lines_left[var_5] = maps\_hud_util::createclienticon("white", int(level.remote_turret_hud["hash_bkg_left"].width * 0.5), 1);
    level.remote_turret_pitch_lines_left[var_5] set_default_hud_parameters();
    level.remote_turret_pitch_lines_left[var_5].alignx = "right";
    level.remote_turret_pitch_lines_left[var_5].aligny = "middle";
    level.remote_turret_pitch_lines_left[var_5].horzalign = "left";
    level.remote_turret_pitch_lines_left[var_5].vertalign = "middle";
    level.remote_turret_pitch_lines_left[var_5].x = var_2;
    level.remote_turret_pitch_lines_left[var_5].sort = level.remote_turret_pitch_lines_left[var_5].sort + 1;
    level.remote_turret_pitch_lines_left[var_5] thread remote_turret_delay_fade_in(level.remote_turret_pitch_lines_left[var_5].alpha, 0.5, 0.5);
  }

  level.remote_turret_pitch_lines_mini_left = [];

  for(var_5 = 0; var_5 < level.remote_turret_pitch_lines_left.size; var_5++) {
    level.remote_turret_pitch_lines_mini_left[var_5] = maps\_hud_util::createclienticon("white", int(level.remote_turret_pitch_lines_left[var_5].width * 0.5), 1);
    level.remote_turret_pitch_lines_mini_left[var_5] set_default_hud_parameters();
    level.remote_turret_pitch_lines_mini_left[var_5].alignx = "right";
    level.remote_turret_pitch_lines_mini_left[var_5].aligny = "middle";
    level.remote_turret_pitch_lines_mini_left[var_5].horzalign = "left";
    level.remote_turret_pitch_lines_mini_left[var_5].vertalign = "middle";
    level.remote_turret_pitch_lines_mini_left[var_5].x = var_2;
    level.remote_turret_pitch_lines_mini_left[var_5].sort = level.remote_turret_pitch_lines_mini_left[var_5].sort + 1;
    level.remote_turret_pitch_lines_mini_left[var_5] thread remote_turret_delay_fade_in(level.remote_turret_pitch_lines_mini_left[var_5].alpha, 0.5, 0.5);
  }

  level.remote_turret_pitch_numbers_left = [];

  for(var_5 = 0; var_5 < level.remote_turret_pitch_lines_left.size; var_5++) {
    level.remote_turret_pitch_numbers_left[var_5] = maps\_hud_util::createclientfontstring("small", 0.8);
    level.remote_turret_pitch_numbers_left[var_5] set_default_hud_parameters();
    level.remote_turret_pitch_numbers_left[var_5].alignx = "right";
    level.remote_turret_pitch_numbers_left[var_5].aligny = "middle";
    level.remote_turret_pitch_numbers_left[var_5].horzalign = "left";
    level.remote_turret_pitch_numbers_left[var_5].vertalign = "middle";
    level.remote_turret_pitch_numbers_left[var_5].x = level.remote_turret_hud["incl_mark_left"].x - 10;
    level.remote_turret_pitch_numbers_left[var_5].sort = level.remote_turret_pitch_numbers_left[var_5].sort - 1;
    level.remote_turret_pitch_numbers_left[var_5] thread remote_turret_delay_fade_in(level.remote_turret_pitch_numbers_left[var_5].alpha, 0.5, 0.5);
  }

  level.remote_turret_pitch_lines_right = [];

  for(var_5 = 0; var_5 < 11; var_5++) {
    level.remote_turret_pitch_lines_right[var_5] = maps\_hud_util::createclienticon("white", int(level.remote_turret_hud["hash_bkg_right"].width * 0.5), 1);
    level.remote_turret_pitch_lines_right[var_5] set_default_hud_parameters();
    level.remote_turret_pitch_lines_right[var_5].alignx = "left";
    level.remote_turret_pitch_lines_right[var_5].aligny = "middle";
    level.remote_turret_pitch_lines_right[var_5].horzalign = "right";
    level.remote_turret_pitch_lines_right[var_5].vertalign = "middle";
    level.remote_turret_pitch_lines_right[var_5].x = 0 - var_2;
    level.remote_turret_pitch_lines_right[var_5].sort = level.remote_turret_pitch_lines_right[var_5].sort + 1;
    level.remote_turret_pitch_lines_right[var_5] thread remote_turret_delay_fade_in(level.remote_turret_pitch_lines_right[var_5].alpha, 0.5, 0.5);
  }

  level.remote_turret_pitch_lines_mini_right = [];

  for(var_5 = 0; var_5 < level.remote_turret_pitch_lines_right.size; var_5++) {
    level.remote_turret_pitch_lines_mini_right[var_5] = maps\_hud_util::createclienticon("white", int(level.remote_turret_pitch_lines_right[var_5].width * 0.5), 1);
    level.remote_turret_pitch_lines_mini_right[var_5] set_default_hud_parameters();
    level.remote_turret_pitch_lines_mini_right[var_5].alignx = "left";
    level.remote_turret_pitch_lines_mini_right[var_5].aligny = "middle";
    level.remote_turret_pitch_lines_mini_right[var_5].horzalign = "right";
    level.remote_turret_pitch_lines_mini_right[var_5].vertalign = "middle";
    level.remote_turret_pitch_lines_mini_right[var_5].x = 0 - var_2;
    level.remote_turret_pitch_lines_mini_right[var_5].sort = level.remote_turret_pitch_lines_mini_right[var_5].sort + 1;
    level.remote_turret_pitch_lines_mini_right[var_5] thread remote_turret_delay_fade_in(level.remote_turret_pitch_lines_mini_right[var_5].alpha, 0.5, 0.5);
  }

  level.remote_turret_pitch_numbers_right = [];

  for(var_5 = 0; var_5 < level.remote_turret_pitch_lines_right.size; var_5++) {
    level.remote_turret_pitch_numbers_right[var_5] = maps\_hud_util::createclientfontstring("small", 0.8);
    level.remote_turret_pitch_numbers_right[var_5] set_default_hud_parameters();
    level.remote_turret_pitch_numbers_right[var_5].alignx = "left";
    level.remote_turret_pitch_numbers_right[var_5].aligny = "middle";
    level.remote_turret_pitch_numbers_right[var_5].horzalign = "right";
    level.remote_turret_pitch_numbers_right[var_5].vertalign = "middle";
    level.remote_turret_pitch_numbers_right[var_5].x = level.remote_turret_hud["incl_mark_right"].x + 10;
    level.remote_turret_pitch_numbers_right[var_5].sort = level.remote_turret_pitch_numbers_right[var_5].sort - 1;
    level.remote_turret_pitch_numbers_right[var_5] thread remote_turret_delay_fade_in(level.remote_turret_pitch_numbers_right[var_5].alpha, 0.5, 0.5);
  }

  if(level.remote_turret_fade_in) {
    level.remote_turret_hud["reticle"] thread remote_turret_delay_fade_in(level.remote_turret_hud["reticle"].alpha, 0.5, 0.5);
    level.remote_turret_hud["range_bkg"] thread remote_turret_delay_fade_in(level.remote_turret_hud["range_txt"].alpha, 1, 7.5);
    level.remote_turret_hud["range_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["range_txt"].alpha, 1, 8.0);
    level.remote_turret_hud["range_val"] thread remote_turret_delay_fade_in(level.remote_turret_hud["range_val"].alpha, 1, 8.5);
    level.remote_turret_hud["incl_left_bkg"] thread remote_turret_delay_fade_in(level.remote_turret_hud["incl_left_bkg"].alpha, 0.5, 0.5);
    level.remote_turret_hud["incl_left_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["incl_left_txt"].alpha, 0.5, 0.5);
    level.remote_turret_hud["incl_mark_left"] thread remote_turret_delay_fade_in(level.remote_turret_hud["incl_mark_left"].alpha, 0.5, 0.5);
    level.remote_turret_hud["incl_right_bkg"] thread remote_turret_delay_fade_in(level.remote_turret_hud["incl_right_bkg"].alpha, 0.5, 0.5);
    level.remote_turret_hud["incl_right_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["incl_right_txt"].alpha, 0.5, 0.5);
    level.remote_turret_hud["incl_mark_right"] thread remote_turret_delay_fade_in(level.remote_turret_hud["incl_mark_right"].alpha, 0.5, 0.5);
    level.remote_turret_hud["air_temp_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["air_temp_txt"].alpha, 0.5, 0.5);
    level.remote_turret_hud["air_temp_val"] thread remote_turret_delay_fade_in(level.remote_turret_hud["air_temp_val"].alpha, 0.5, 2.0);
    level.remote_turret_hud["humidity_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["humidity_txt"].alpha, 0.5, 0.5);
    level.remote_turret_hud["humidity_val"] thread remote_turret_delay_fade_in(level.remote_turret_hud["humidity_val"].alpha, 0.5, 2.5);
    level.remote_turret_hud["compass_bracket_left"] thread remote_turret_delay_fade_in(level.remote_turret_hud["compass_bracket_left"].alpha, 0.5, 0.5);
    level.remote_turret_hud["compass_bracket_right"] thread remote_turret_delay_fade_in(level.remote_turret_hud["compass_bracket_right"].alpha, 0.5, 0.5);
    level.remote_turret_hud["compass_arrow_up"] thread remote_turret_delay_fade_in(level.remote_turret_hud["compass_arrow_up"].alpha, 0.5, 0.5);
    level.remote_turret_hud["compass_arrow_down"] thread remote_turret_delay_fade_in(level.remote_turret_hud["compass_arrow_down"].alpha, 0.5, 0.5);
    level.remote_turret_hud["compass_heading"] thread remote_turret_delay_fade_in(level.remote_turret_hud["compass_heading"].alpha, 0.5, 0.5);
    level.remote_turret_hud["weapon_status_bg"] thread remote_turret_delay_fade_in(level.remote_turret_hud["weapon_status_bg"].alpha, 0.5, 0.5);
    level.remote_turret_hud["weapon_status_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["weapon_status_txt"].alpha, 0.5, 0.75);
    level.remote_turret_hud["weapon_name_bg"] thread remote_turret_delay_fade_in(level.remote_turret_hud["weapon_name_bg"].alpha, 0.5, 0.5);
    level.remote_turret_hud["weapon_name_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["weapon_name_txt"].alpha, 0.5, 0.75);
    level.remote_turret_hud["zoom_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["zoom_txt"].alpha, 0.5, 0.5);
    level.remote_turret_hud["wind_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["wind_txt"].alpha, 1, 4);
    level.remote_turret_hud["wind_val"] thread remote_turret_delay_fade_in(level.remote_turret_hud["wind_val"].alpha, 1, 4);
    level.remote_turret_hud["wind_dir"] thread remote_turret_delay_fade_in(level.remote_turret_hud["wind_dir"].alpha, 1, 4);
    level.remote_turret_hud["wind_dir_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["wind_dir_txt"].alpha, 1, 4);
    level.remote_turret_hud["wind_bkg"] thread remote_turret_delay_fade_in(level.remote_turret_hud["wind_bkg"].alpha, 1, 4);
  }

  thread remote_turret_update_status();
  thread remote_turret_update_reticle();
  thread remote_turret_update_compass();
  thread remote_turret_update_pitch();
  thread remote_turret_update_zoom();
  thread remote_turret_static_overlay();
  level.remote_turret_fade_in = 0;
}

remote_turret_clear_hud() {
  var_0 = getarraykeys(level.remote_turret_hud);

  foreach(var_2 in var_0) {
    level.remote_turret_hud[var_2] destroy();
    level.remote_turret_hud[var_2] = undefined;
  }

  var_0 = getarraykeys(level.remote_turret_compass_lines);

  foreach(var_2 in var_0) {
    level.remote_turret_compass_lines[var_2] destroy();
    level.remote_turret_compass_lines[var_2] = undefined;
  }

  var_0 = getarraykeys(level.remote_turret_compass_numbers);

  foreach(var_2 in var_0) {
    level.remote_turret_compass_numbers[var_2] destroy();
    level.remote_turret_compass_numbers[var_2] = undefined;
  }

  var_0 = getarraykeys(level.remote_turret_pitch_lines_left);

  foreach(var_2 in var_0) {
    level.remote_turret_pitch_lines_left[var_2] destroy();
    level.remote_turret_pitch_lines_left[var_2] = undefined;
  }

  var_0 = getarraykeys(level.remote_turret_pitch_lines_mini_left);

  foreach(var_2 in var_0) {
    level.remote_turret_pitch_lines_mini_left[var_2] destroy();
    level.remote_turret_pitch_lines_mini_left[var_2] = undefined;
  }

  var_0 = getarraykeys(level.remote_turret_pitch_numbers_left);

  foreach(var_2 in var_0) {
    level.remote_turret_pitch_numbers_left[var_2] destroy();
    level.remote_turret_pitch_numbers_left[var_2] = undefined;
  }

  var_0 = getarraykeys(level.remote_turret_pitch_lines_right);

  foreach(var_2 in var_0) {
    level.remote_turret_pitch_lines_right[var_2] destroy();
    level.remote_turret_pitch_lines_right[var_2] = undefined;
  }

  var_0 = getarraykeys(level.remote_turret_pitch_lines_mini_right);

  foreach(var_2 in var_0) {
    level.remote_turret_pitch_lines_mini_right[var_2] destroy();
    level.remote_turret_pitch_lines_mini_right[var_2] = undefined;
  }

  var_0 = getarraykeys(level.remote_turret_pitch_numbers_right);

  foreach(var_2 in var_0) {
    level.remote_turret_pitch_numbers_right[var_2] destroy();
    level.remote_turret_pitch_numbers_right[var_2] = undefined;
  }
}

remote_turret_delay_fade_in(var_0, var_1, var_2) {
  self.alpha = 0;
  wait(var_2);

  if(isDefined(self)) {
    self fadeovertime(var_1);
    self.alpha = var_0;
  }
}

remote_turret_update_status() {
  self endon("remote_turret_deactivate");
  self notifyonplayercommand("firing", "+attack");

  for(;;) {
    if(self getcurrentweaponclipammo() <= 0 || self isreloading()) {
      level.remote_turret_hud["weapon_status_txt"] settext(&"ENEMY_HQ_RELOADING");
      level.remote_turret_hud["weapon_status_txt"].alpha = 0.5;
      level.remote_turret_hud["weapon_status_bg"].alpha = 0.25;
      var_0 = 0;

      while(self getcurrentweaponclipammo() <= 0 || self isreloading()) {
        if(var_0 == 0) {
          level.remote_turret_hud["weapon_status_txt"] fadeovertime(0.2);

          if(level.remote_turret_hud["weapon_status_txt"].alpha > 0.0) {
            level.remote_turret_hud["weapon_status_txt"].alpha = 0.0;
          } else {
            level.remote_turret_hud["weapon_status_txt"].alpha = 0.5;
          }
        }

        wait 0.05;
        var_0 = var_0 + 0.05;

        if(var_0 > 0.2) {
          var_0 = 0;
        }
      }
    }

    level.remote_turret_hud["weapon_status_txt"] settext(&"ENEMY_HQ_TARGETING");
    level.remote_turret_hud["weapon_status_txt"].alpha = 1;
    level.remote_turret_hud["weapon_status_bg"].alpha = 0.5;
    self waittill("firing");
    level.remote_turret_hud["weapon_status_txt"] settext(&"ENEMY_HQ_FIRING");
    level.remote_turret_hud["weapon_status_txt"].alpha = 1;
    level.remote_turret_hud["weapon_status_bg"].alpha = 0.5;
    level.remote_turret_hud["weapon_status_bg"] setshader("red_block", level.remote_turret_hud["weapon_status_bg"].width, level.remote_turret_hud["weapon_status_bg"].height);
    var_1 = self getcurrentweaponclipammo() / weaponclipsize(self getcurrentweapon());
    level.remote_turret_hud["weapon_name_bar"] setshader("green_block", int(max(1, var_1 * level.remote_turret_hud["weapon_name_bar_bg"].width * 0.6)), level.remote_turret_hud["weapon_name_bar"].height);

    if(var_1 == 0) {
      level.remote_turret_hud["weapon_name_bar"].alpha = 0;
    } else {
      level.remote_turret_hud["weapon_name_bar"].alpha = 0.5;
    }

    wait 0.25;
    level.remote_turret_hud["weapon_status_bg"] setshader("black", level.remote_turret_hud["weapon_status_bg"].width, level.remote_turret_hud["weapon_status_bg"].height);
  }
}

remote_turret_update_reticle() {
  self endon("remote_turret_deactivate");

  for(;;) {
    var_0 = level.remote_turret_trace["entity"];

    if(isDefined(var_0) && (isai(var_0) && var_0 isbadguy() || isDefined(var_0.script_team) && var_0.script_team == "axis" && var_0.health > 0)) {
      if(level.remote_turret_hud["reticle_red"].alpha == 0) {
        level.remote_turret_hud["reticle_red"].alpha = level.remote_turret_hud["reticle"].alpha;
        level.remote_turret_hud["reticle"].alpha = 0;
        level.remote_turret_hud["incl_mark_left_red"].alpha = level.remote_turret_hud["incl_mark_left"].alpha;
        level.remote_turret_hud["incl_mark_left"].alpha = 0;
        level.remote_turret_hud["incl_mark_right_red"].alpha = level.remote_turret_hud["incl_mark_right"].alpha;
        level.remote_turret_hud["incl_mark_right"].alpha = 0;
      }
    } else if(level.remote_turret_hud["reticle"].alpha == 0) {
      level.remote_turret_hud["reticle"].alpha = level.remote_turret_hud["reticle_red"].alpha;
      level.remote_turret_hud["reticle_red"].alpha = 0;
      level.remote_turret_hud["incl_mark_left"].alpha = level.remote_turret_hud["incl_mark_left_red"].alpha;
      level.remote_turret_hud["incl_mark_left_red"].alpha = 0;
      level.remote_turret_hud["incl_mark_right"].alpha = level.remote_turret_hud["incl_mark_right_red"].alpha;
      level.remote_turret_hud["incl_mark_right_red"].alpha = 0;
    }

    wait 0.05;
  }
}

remote_turret_update_range() {
  level.player endon("remote_turret_deactivate");

  for(;;) {
    level.remote_turret_trace = bulletTrace(level.player getEye(), level.player getEye() + anglesToForward(level.player getplayerangles()) * 36000, 1, level.player, 1, 1, 1);
    var_0 = int(distance(level.player getEye(), level.remote_turret_trace["position"]) / 36);
    self settext(var_0 + common_scripts\utility::ter_op(level.remote_turret_trace["fraction"] == 1.0, "+", ""));
    wait 0.05;
  }
}

remote_turret_update_wind() {
  level.player endon("remote_turret_deactivate");
  var_0 = randomfloatrange(0, 20);

  for(;;) {
    switch (randomint(50)) {
      case 0:
        var_0 = var_0 + randomfloatrange(2, 5);
        break;
      case 1:
        var_0 = var_0 - randomfloatrange(2, 5);
        break;
      default:
        var_0 = var_0 + randomfloatrange(-0.5, 0.5);
        break;
    }

    var_0 = clamp(var_0, 0, 20);
    self settext(int(var_0 * 10) / 10 + common_scripts\utility::ter_op(modulus(int(var_0 * 10), 10) == 0, ".0", ""));
    wait(randomfloatrange(0.5, 1));
  }
}

remote_turret_update_air_temp() {
  level.player endon("remote_turret_deactivate");
  var_0 = randomfloatrange(70, 85);

  for(;;) {
    switch (randomint(10)) {
      case 1:
      case 0:
        var_0 = var_0 - randomfloatrange(0.05, 0.1);
        break;
      default:
        var_0 = var_0 + randomfloatrange(0.025, 0.075);
        break;
    }

    var_0 = clamp(var_0, 70, 85);
    self settext(int(var_0 * 10) / 10 + common_scripts\utility::ter_op(modulus(int(var_0 * 10), 10) == 0, ".0", ""));
    wait(randomfloatrange(5, 10));
  }
}

remote_turret_update_humidity() {
  level.player endon("remote_turret_deactivate");
  var_0 = randomfloatrange(45, 95);

  for(;;) {
    var_0 = var_0 + randomfloatrange(-0.1, 0.1);
    var_0 = clamp(var_0, 45, 95);
    self settext(int(var_0 * 100) / 100 + common_scripts\utility::ter_op(modulus(int(var_0 * 100), 10) == 0, "0", ""));
    wait(randomfloatrange(1, 3));
  }
}

remote_turret_update_compass() {
  self endon("remote_turret_deactivate");
  var_0 = getnorthyaw();
  var_1 = level.remote_turret_hud["compass_bracket_left"].x + 10;
  var_2 = level.remote_turret_hud["compass_bracket_right"].x - 10;
  var_3 = 1;
  var_4 = (var_2 - var_1) / level.remote_turret_compass_numbers.size;

  for(;;) {
    var_5 = angleclamp(self getplayerangles()[1] - var_0);

    if(var_5 < 11.25 || var_5 > 348.75) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_NORTH");
    } else if(var_5 < 33.75) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_NORTH_BY_NORTHEAST");
    } else if(var_5 < 56.25) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_NORTHEAST");
    } else if(var_5 < 78.75) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_EAST_BY_NORTHEAST");
    } else if(var_5 < 101.25) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_EAST");
    } else if(var_5 < 123.75) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_EAST_BY_SOUTHEAST");
    } else if(var_5 < 146.25) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_SOUTHEAST");
    } else if(var_5 < 168.75) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_SOUTH_BY_SOUTHEAST");
    } else if(var_5 < 191.25) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_SOUTH");
    } else if(var_5 < 213.75) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_SOUTH_BY_SOUTHWEST");
    } else if(var_5 < 236.25) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_SOUTHWEST");
    } else if(var_5 < 258.75) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_WEST_BY_SOUTHWEST");
    } else if(var_5 < 281.25) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_WEST");
    } else if(var_5 < 303.75) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_WEST_BY_NORTHWEST");
    } else if(var_5 < 326.25) {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_NORTHWEST");
    } else {
      level.remote_turret_hud["compass_heading"] settext(&"ENEMY_HQ_NORTH_BY_NORTHWEST");
    }

    var_6 = var_1 + (1.0 - modulus(abs(var_5), var_3) / var_3) * var_4;
    var_7 = int(var_5 / var_3) * var_3 - var_3 * (int(level.remote_turret_compass_numbers.size / 2) - common_scripts\utility::ter_op(modulus(abs(var_5), var_3) < var_3 / 2, 0, 1));

    if(var_7 < 0) {
      var_7 = var_7 + 360;
    }

    for(var_8 = 0; var_8 < level.remote_turret_compass_numbers.size; var_8++) {
      level.remote_turret_compass_lines[var_8].x = var_6 + var_8 * var_4;
      level.remote_turret_compass_numbers[var_8].x = var_6 + (var_8 + 0.5) * var_4;
      level.remote_turret_compass_numbers[var_8] settext(int(var_7));

      if(modulus(abs(var_5), var_3) < var_3 / 2) {
        level.remote_turret_compass_numbers[var_8].x = level.remote_turret_compass_numbers[var_8].x - var_4;
      }

      var_7 = var_7 + var_3;

      if(var_7 > 360) {
        var_7 = var_7 - 360;
      }
    }

    wait 0.05;
  }
}

remote_turret_update_pitch() {
  self endon("remote_turret_deactivate");
  var_0 = level.remote_turret_hud["hash_bkg_left"].y - level.remote_turret_hud["hash_bkg_left"].height * 0.28;
  var_1 = level.remote_turret_hud["hash_bkg_left"].y + level.remote_turret_hud["hash_bkg_left"].height * 0.28;
  var_2 = 2;
  var_3 = (var_1 - var_0) / level.remote_turret_pitch_numbers_left.size;
  var_4 = 0.5;
  var_5 = (var_1 - var_0) * 0.25;

  for(;;) {
    var_6 = angleclamp(self getplayerangles()[0]);
    var_7 = var_0 + (1.0 - modulus(var_6, var_2) / var_2) * var_3;
    var_8 = 0 - int(angleclamp180(var_6) / var_2) * var_2 + var_2 * (int(level.remote_turret_pitch_numbers_left.size / 2) - common_scripts\utility::ter_op(modulus(var_6, var_2) < var_2 / 2, 0, 1) + common_scripts\utility::ter_op(var_6 > 180, 1, 0));

    for(var_9 = 0; var_9 < level.remote_turret_pitch_numbers_left.size; var_9++) {
      level.remote_turret_pitch_lines_left[var_9].y = var_7 + (var_9 + common_scripts\utility::ter_op(modulus(var_6, var_2) < var_2 / 2, -0.5, 0.5)) * var_3;
      level.remote_turret_pitch_lines_left[var_9].alpha = var_4 * clamp(abs(common_scripts\utility::ter_op(var_9 < level.remote_turret_pitch_numbers_left.size / 2, var_0, var_1) - level.remote_turret_pitch_lines_left[var_9].y) / var_5, 0.0, 1.0);
      level.remote_turret_pitch_lines_mini_left[var_9].y = var_7 + var_9 * var_3;
      level.remote_turret_pitch_lines_mini_left[var_9].alpha = var_4 * clamp(abs(common_scripts\utility::ter_op(var_9 < level.remote_turret_pitch_numbers_left.size / 2, var_0, var_1) - level.remote_turret_pitch_lines_mini_left[var_9].y) / var_5, 0.0, 1.0);
      level.remote_turret_pitch_numbers_left[var_9].y = level.remote_turret_pitch_lines_left[var_9].y;
      level.remote_turret_pitch_numbers_left[var_9].alpha = clamp(abs(common_scripts\utility::ter_op(var_9 < level.remote_turret_pitch_numbers_left.size / 2, var_0, var_1) - level.remote_turret_pitch_numbers_left[var_9].y) / var_5, 0.0, 1.0);
      level.remote_turret_pitch_numbers_left[var_9] settext(int(var_8));
      level.remote_turret_pitch_lines_right[var_9].y = level.remote_turret_pitch_lines_left[var_9].y;
      level.remote_turret_pitch_lines_right[var_9].alpha = level.remote_turret_pitch_lines_left[var_9].alpha;
      level.remote_turret_pitch_lines_mini_right[var_9].y = level.remote_turret_pitch_lines_mini_left[var_9].y;
      level.remote_turret_pitch_lines_mini_right[var_9].alpha = level.remote_turret_pitch_lines_mini_left[var_9].alpha;
      level.remote_turret_pitch_numbers_right[var_9].y = level.remote_turret_pitch_numbers_left[var_9].y;
      level.remote_turret_pitch_numbers_right[var_9].alpha = level.remote_turret_pitch_numbers_left[var_9].alpha;
      level.remote_turret_pitch_numbers_right[var_9] settext(int(var_8));
      var_8 = var_8 - var_2;
    }

    wait 0.05;
  }
}

remote_turret_update_zoom() {
  self endon("remote_turret_deactivate");

  for(;;) {
    var_0 = 65 / getdvarfloat("cg_fov");
    var_0 = int(var_0 * 10) / 10;
    var_1 = "" + var_0 + common_scripts\utility::ter_op(modulus(var_0, 10) == 0, ".0 ", " ");
    level.remote_turret_hud["zoom_txt"] settext(var_1);
    wait 0.05;
  }
}

remote_turret_update_scanline() {
  level.player endon("remote_turret_deactivate");

  for(;;) {
    self.y = -400;
    self moveovertime(2);
    self.y = 400;
    wait 2;
  }
}

create_outofrange_hud() {
  var_0 = 0;
  var_1 = -100;
  level.remote_turret_hud["out_range_bg"] = maps\_hud_util::createclienticon("black", 300, 25);
  level.remote_turret_hud["out_range_bg"] set_default_hud_parameters();
  level.remote_turret_hud["out_range_bg"].alignx = "center";
  level.remote_turret_hud["out_range_bg"].aligny = "middle";
  level.remote_turret_hud["out_range_bg"].horzalign = "center";
  level.remote_turret_hud["out_range_bg"].vertalign = "middle";
  level.remote_turret_hud["out_range_bg"].x = var_0;
  level.remote_turret_hud["out_range_bg"].y = var_1;
  level.remote_turret_hud["out_range_bg"].sort = level.remote_turret_hud["out_range_bg"].sort - 1;
  level.remote_turret_hud["out_range_bg"].alpha = 0.4;
  level.remote_turret_hud["out_range_txt"] = maps\_hud_util::createclientfontstring("small", 2);
  level.remote_turret_hud["out_range_txt"] set_default_hud_parameters();
  level.remote_turret_hud["out_range_txt"].alignx = "center";
  level.remote_turret_hud["out_range_txt"].aligny = "middle";
  level.remote_turret_hud["out_range_txt"].horzalign = "center";
  level.remote_turret_hud["out_range_txt"].vertalign = "middle";
  level.remote_turret_hud["out_range_txt"].y = var_1;
  level.remote_turret_hud["out_range_txt"].alpha = 0.666;
  level.remote_turret_hud["out_range_txt"] thread remote_turret_delay_fade_in(level.remote_turret_hud["out_range_txt"].alpha, 0.5, 0.5);
  level.remote_turret_hud["out_range_bg"] thread remote_turret_delay_fade_in(level.remote_turret_hud["out_range_bg"].alpha, 0.5, 0.5);
  level.remote_turret_hud["out_range_txt"] settext(&"ENEMY_HQ_OUT_OF_RANGE");
  wait 0.5;
  level.remote_turret_hud["out_range_txt"].alpha = 0.5;
  level.remote_turret_hud["out_range_bg"].alpha = 0.4;
  level.remote_turret_hud["out_range_bg"] setshader("red_block", level.remote_turret_hud["out_range_bg"].width, level.remote_turret_hud["out_range_bg"].height);

  if(!isDefined(level.remote_turret_shot_missed) || !level.remote_turret_shot_missed) {
    maps\_utility::player_giveachievement_wrapper("LEVEL_4A");
  }

  var_2 = 0;

  for(;;) {
    if(var_2 == 0) {
      level.remote_turret_hud["out_range_txt"] fadeovertime(0.2);

      if(level.remote_turret_hud["out_range_txt"].alpha > 0.0) {
        level.remote_turret_hud["out_range_txt"].alpha = 0.0;
      } else {
        level.remote_turret_hud["out_range_txt"].alpha = 0.5;
      }
    }

    wait 0.05;
    var_2 = var_2 + 0.05;

    if(var_2 > 0.2) {
      var_2 = 0;
    }
  }
}

remote_turret_static_overlay() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0 setshader("overlay_static", 640, 480);
  var_0.alpha = 0.0;
  var_0.sort = -3;
  var_1 = common_scripts\utility::waittill_any_return("remote_turret_deactivate", "fadeup_static_finale");

  if(var_1 == "fadeup_static_finale") {
    thread create_outofrange_hud();
    var_2 = 0;

    while(var_2 < 1.0) {
      var_2 = var_2 + 0.05;
      wait 0.25;
    }

    self notify("finished_static_fadeup");
    self waittill("remote_turret_deactivate");
  }

  var_0 destroy();
}

remote_turret_handle_zoom() {
  self endon("remote_turret_deactivate");
  self endon("remote_turret_nozoom");
  var_0 = 0;
  level.remote_turret_firing_slow_aim_modifier = 0.0;

  for(;;) {
    var_1 = self getnormalizedmovement();

    if(var_1[0] == 0) {
      wait 0.05;
      var_0 = 0;
      thread maps\enemyhq_audio::aud_sniper_stop_zoom();
      continue;
    }

    if(var_0 <= 0 && var_1[0] > 0 && level.remote_turret_current_fov > level.remote_turret_min_fov || var_0 >= 0 && var_1[0] < 0 && level.remote_turret_current_fov < level.remote_turret_max_fov) {
      thread remote_turret_lerp_dof();
      thread maps\enemyhq_audio::aud_sniper_start_zoom(var_1[0]);
    }

    var_0 = var_1[0];
    var_2 = level.remote_turret_current_fov / 20.0;
    var_2 = min(3, var_2);
    var_3 = max(0.5, var_2);
    level.remote_turret_current_fov = level.remote_turret_current_fov - var_1[0] * var_2;

    if(level.remote_turret_current_fov < level.remote_turret_min_fov) {
      level.remote_turret_current_fov = level.remote_turret_min_fov;
      thread maps\enemyhq_audio::aud_sniper_stop_zoom();
    } else if(level.remote_turret_current_fov > level.remote_turret_max_fov) {
      level.remote_turret_current_fov = level.remote_turret_max_fov;
      thread maps\enemyhq_audio::aud_sniper_stop_zoom();
    }

    self lerpfov(level.remote_turret_current_fov, 0.05);
    set_slow_aim();
    wait 0.05;
  }
}

set_slow_aim() {
  if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
    return;
  }
  var_0 = (level.fov_range - (level.remote_turret_max_fov - level.remote_turret_current_fov)) / level.fov_range;
  level.remote_turret_current_slow_yaw = level.remote_turret_min_slow_aim_yaw + level.slow_aim_yaw_range * var_0 + level.remote_turret_firing_slow_aim_modifier;
  level.remote_turret_current_slow_pitch = level.remote_turret_min_slow_aim_pitch + level.slow_aim_pitch_range * var_0 + level.remote_turret_firing_slow_aim_modifier;
  self enableslowaim(level.remote_turret_current_slow_pitch, level.remote_turret_current_slow_yaw);
}

remote_turret_lerp_dof(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  self notify("remote_turret_lerp_dof");
  self endon("remote_turret_lerp_dof");
  maps\_art::dof_enable_script(50, 100, 10, 100, 200, 6, 0.0);
  maps\_art::dof_disable_script(var_0);
}

remote_turret_monitor_dryfire(var_0) {
  self notifyonplayercommand("attack", "+attack");
  self waittill("attack");

  if(self getcurrentweapon() == var_0) {
    common_scripts\utility::flag_set("checkit_dryfire");
    thread maps\enemyhq_audio::aud_dry_fire();
  }
}

remote_turret_monitor_ammo(var_0) {
  self notifyonplayercommand("attack", "+attack");

  for(;;) {
    self waittill("weapon_fired");
    var_1 = 0.5;
    var_2 = 200;

    if(self getcurrentweapon() != var_0) {
      return;
    }
    if(level.remote_turret_hud["reticle_red"].alpha == 0 && (!isDefined(level.remote_turret_last_kill_time) || gettime() > level.remote_turret_last_kill_time)) {
      level.remote_turret_shot_missed = 1;
    }

    earthquake(0.1, 0.3, self.origin, 100);
    level.player playrumbleonentity("heavygun_fire");

    if(self getammocount(var_0) <= 0) {
      if(!isDefined(self.remote_canreload) || self.remote_canreload == 0) {
        self notify("use_remote_turret");
        return;
      } else {
        wait 0.6;
        self setweaponammoclip(var_0, 10);
      }
    }
  }
}

update_remote_turret_targets() {
  self endon("remote_turret_deactivate");

  for(;;) {
    var_0 = common_scripts\utility::array_combine(level.drones["axis"].array, getaiarray());

    foreach(var_2 in var_0) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(var_2.team == "axis" && (!isDefined(var_2.monitoring_sniper_damage) || !var_2.monitoring_sniper_damage)) {
        var_2 thread monitor_sniper_damage();
      }
    }

    wait 0.05;
  }
}

remove_remote_turret_target_on_death() {
  self endon("hud_outline_disabled");
  common_scripts\utility::waittill_any("death", "remove_sniper_outline");

  if(isDefined(self)) {
    self hudoutlinedisable();
  }
}

remove_remote_turret_targets() {
  for(;;) {
    level.player waittill("remote_turret_deactivate");
    var_0 = common_scripts\utility::array_combine(level.drones["axis"].array, getaiarray());

    foreach(var_2 in var_0) {
      var_2 hudoutlinedisable();
      var_2 notify("hud_outline_disabled");
      var_2.has_target_shader = undefined;
    }

    if(isDefined(level.dog)) {
      level.dog hudoutlinedisable();
      level.dog.has_target_shader = undefined;
    }
  }
}

remote_turret_update_player_position() {
  self endon("remote_turret_deactivate");
  var_0 = self.player_view_controller_model.origin;
  var_1 = self getplayerangles();
  var_2 = 4000;
  var_3 = self.turret_look_at_ent.origin - self.player_view_controller_model.origin;
  var_4 = 0;
  var_5 = 0;
  var_6 = getdvarint("debug_sniper_mode", 1);

  for(;;) {
    switch (getdvarint("debug_sniper_mode", 1)) {
      case 0:
        if(var_6 >= 3) {
          self playerlinktodelta(self.player_view_controller, "tag_aim", 1.0, level.remote_turret_right_arc, level.remote_turret_left_arc, level.remote_turret_top_arc, level.remote_turret_bottom_arc);
        }

        if(var_6 != 0) {
          self.player_view_controller_model.origin = var_0 + anglesToForward(var_1) * var_2;
          self.turret_look_at_ent.origin = self.player_view_controller_model.origin + var_3;
        }

        break;
      case 1:
        if(var_6 >= 3) {
          self playerlinktodelta(self.player_view_controller, "tag_aim", 1.0, level.remote_turret_right_arc, level.remote_turret_left_arc, level.remote_turret_top_arc, level.remote_turret_bottom_arc);
        }

        if(var_6 != 1) {
          self.player_view_controller_model.origin = var_0;
          self.turret_look_at_ent.origin = self.player_view_controller_model.origin + var_3;
        }

        break;
      case 2:
        if(var_6 >= 3) {
          self playerlinktodelta(self.player_view_controller, "tag_aim", 1.0, level.remote_turret_right_arc, level.remote_turret_left_arc, level.remote_turret_top_arc, level.remote_turret_bottom_arc);
          self.player_view_controller settargetentity(self.turret_look_at_ent);
        }

        var_7 = self getplayerangles();
        self.player_view_controller_model.origin = var_0 + anglesToForward(self getplayerangles()) * var_2;
        self.turret_look_at_ent.origin = self.player_view_controller_model.origin + var_3;
        break;
      case 3:
        if(var_6 != 3) {
          self playerlinktodelta(self.player_view_controller, "tag_aim", 1.0, 0, 0, 0, 0);
          var_4 = 0;
          var_5 = 0;
        }

        var_8 = var_2 * tan(level.remote_turret_right_arc);
        var_9 = var_2 * tan(level.remote_turret_left_arc);
        var_10 = var_2 * tan(level.remote_turret_top_arc);
        var_11 = var_2 * tan(level.remote_turret_bottom_arc);
        var_12 = self getnormalizedcameramovement();

        if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
          var_12 = (var_12[0], var_12[1] * -1, 0);
        }

        var_4 = var_4 + var_12[1] * min(25.0, 25.0 * getdvarfloat("cg_fov") / 10);
        var_5 = var_5 + var_12[0] * min(25.0, 25.0 * getdvarfloat("cg_fov") / 10);
        var_4 = clamp(var_4, 0 - var_9, var_8);
        var_5 = clamp(var_5, 0 - var_11, var_10);
        self.player_view_controller_model.origin = var_0 + anglesToForward(var_1) * var_2 + anglestoright(var_1) * var_4 + (0, 0, var_5);
        self.turret_look_at_ent.origin = self.player_view_controller_model.origin + var_3;
        break;
      case 4:
        if(var_6 != 4) {
          self playerlinktodelta(self.player_view_controller, "tag_aim", 1.0, 0, 0, 0, 0);
          var_4 = 0;
          var_5 = 0;
        }

        var_8 = var_2 * tan(level.remote_turret_right_arc);
        var_9 = var_2 * tan(level.remote_turret_left_arc);
        var_10 = var_2 * tan(level.remote_turret_top_arc);
        var_11 = var_2 * tan(level.remote_turret_bottom_arc);
        var_12 = self getnormalizedcameramovement();

        if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
          var_12 = (var_12[0], var_12[1] * -1, 0);
        }

        if(!level.console && !common_scripts\utility::is_player_gamepad_enabled()) {
          var_4 = var_4 + var_12[1] * 75;
          var_5 = var_5 + var_12[0] * 100;
        } else {
          var_4 = var_4 + var_12[1] * min(35, 50 * getdvarfloat("cg_fov") / 65);
          var_5 = var_5 + var_12[0] * min(35, 50 * getdvarfloat("cg_fov") / 65);
        }

        var_4 = clamp(var_4, var_9, var_8);
        var_5 = clamp(var_5, var_11, var_10);
        level.sniper_degx = atan(var_4 / var_2);
        level.sniper_degy = atan(var_5 / var_2);
        self.player_view_controller_model.origin = var_0 + anglesToForward(var_1) * var_2 + anglestoright(var_1) * var_4 + (0, 0, var_5);
        self.turret_look_at_ent.origin = self.player_view_controller_model.origin + (self.player_view_controller_model.origin - var_0) * 16000;
        self.player_view_controller snaptotargetentity(self.turret_look_at_ent);
        break;
    }

    var_6 = getdvarint("debug_sniper_mode");
    wait 0.05;
  }
}

monitor_sniper_damage() {
  self notify("monitoring_sniper_damage");
  self endon("monitoring_sniper_damage");
  level.player endon("remote_turret_deactivate");
  self.monitoring_sniper_damage = 1;

  while(isalive(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_1 == level.player) {
      level.remote_turret_last_kill_time = gettime();
      playFX(common_scripts\utility::getfx("remote_sniper_blood"), var_3 - var_2 * 20, (0, 0, 0) - var_2, (0, 0, 1));
      playFX(common_scripts\utility::getfx("remote_sniper_blood_exit"), var_3 + var_2 * 20, var_2, (0, 0, 1));
      return;
    }
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
  self.alpha = 1;
}

modulus(var_0, var_1) {
  var_2 = int(var_0 / var_1);
  return var_0 - var_2 * var_1;
}