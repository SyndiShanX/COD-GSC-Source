/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_depth_charge.gsc
*****************************************/

depth_charge_init() {
  precacherumble("minigun_rumble");
  precacheshader("crr_dpad_osprey_active");
  precacheshader("crr_dpad_osprey_inactive");
  precacheshader("crr_hud_osprey_overlay_01");
  precacheshader("crr_hud_osprey_overlay_02");
  precacheitem("remote_tablet_osprey");
  precacheitem("osprey_missile");
  precachemodel("weapon_osprey_turret");
  precacheturret("osprey_minigun");
  precachestring(&"SCRIPT_X");
  precachestring(&"CARRIER_HUD_PERIOD");
  precachestring(&"CARRIER_RNDS");
  precacheshader("hud_dpad");
  precacheshader("hud_arrow_up");
  precacheshader("ac130_overlay_grain");
  precachestring(&"CARRIER_OSPREY_HUD_MG");
  precachestring(&"CARRIER_OSPREY_HUD_MISSILE");
  precachestring(&"CARRIER_DEPTH_CHARGE_HINT");
  precachestring(&"CARRIER_DEPTH_CHARGE_MISSILE_HINT");
  precachestring(&"CARRIER_DEPTH_CHARGE_MG_HINT");
  precachestring(&"CARRIER_DEPTH_CHARGE_MG_PC_HINT");
  common_scripts\utility::flag_init("defend_osprey_ready");
  level.osprey_hit_zodiacs = 0;
  level.osprey_hit_gunboats = 0;
  level.osprey_hit_fake_targets = 0;
  level.osprey_total_hits = 0;
  level.depth_charge_max_fov = 65;
  level.depth_charge_min_fov = 50;
  level.depth_charge_min_slow_aim_yaw = 0.25;
  level.depth_charge_max_slow_aim_yaw = 0.3;
  level.depth_charge_min_slow_aim_pitch = 0.25;
  level.depth_charge_max_slow_aim_pitch = 0.35;
  level.depth_charge_current_slow_yaw = 0.3;
  level.depth_charge_current_slow_pitch = 0.5;
  level.depth_charge_firing_slow_aim_modifier = 0.0;
  level.depth_charge_current_fov = level.depth_charge_max_fov;
  level.fov_range = level.depth_charge_max_fov - level.depth_charge_min_fov;
  level.slow_aim_yaw_range = level.depth_charge_max_slow_aim_yaw - level.depth_charge_min_slow_aim_yaw;
  level.slow_aim_pitch_range = level.depth_charge_max_slow_aim_pitch - level.depth_charge_min_slow_aim_pitch;
  level.fake_targets = [];
  level.first_time_depth_charge = 1;
  level.depth_charge_friendly_fire_kills_to_fail = 2;
  level.depth_charge_friendly_fire_kills = 0;
}

depth_charge_give_device() {
  self setweaponhudiconoverride("actionslot1", "crr_dpad_osprey_inactive");
  refreshhudammocounter();
}

depth_charge_give_control() {
  self endon("depth_charge_remove_control");
  self endon("death");

  if(!isalive(level.player)) {
    return;
  }
  self notifyonplayercommand("use_depth_charge", "+actionslot 1");
  self setweaponhudiconoverride("actionslot1", "crr_dpad_osprey_active");
  refreshhudammocounter();
  self.osprey_control = 1;
  self notify("defend_osprey_ready");
  thread depth_charge_hint();

  for(;;) {
    self waittill("use_depth_charge");

    if(!self isonground() || self isthrowinggrenade() || self ismeleeing()) {
      continue;
    }
    thread depth_charge_use();
    break;
  }

  self waittill("depth_charge_run_finished");
  thread depth_charge_replay();
  thread depth_charge_exit();
}

depth_charge_remove_control(var_0) {
  self notify("depth_charge_remove_control");
  self.osprey_control = 0;

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(self.using_depth_charge) && self.using_depth_charge) {
    depth_charge_exit();
  }

  if(var_0) {
    self setweaponhudiconoverride("actionslot1", "crr_dpad_osprey_inactive");
  }
  else {
    self setweaponhudiconoverride("actionslot1", "none");
  }

  self notifyonplayercommand("", "+actionslot 1");
  refreshhudammocounter();
}

#using_animtree("vehicles");

depth_charge_use() {
  self endon("depth_charge_exit");
  self endon("death");
  self notify("start_using_depth_charge");
  self.using_depth_charge = 1;

  if(self getstance() == "prone") {
    self setstance("crouch");
  }

  self setmovespeedscale(0);
  self allowjump(0);
  depth_charge_control_up();
  self.in_osprey = 1;
  level.old_player_origin = self.origin;
  level.old_player_angles = self.angles;
  self.prev_stance = self getstance();
  level.osprey_hit_zodiacs = 0;
  level.osprey_hit_gunboats = 0;
  level.osprey_hit_fake_targets = 0;
  level.osprey_total_hits = 0;
  self hide();
  self enabledeathshield(1);
  self enableinvulnerability();
  self.rain = 0;
  maps\_utility::store_players_weapons("depth_charge");
  self takeallweapons();
  self allowads(0);
  self allowmelee(0);
  self allowcrouch(0);
  self allowprone(0);

  if(isDefined(level.defend_zodiac_osprey)) {
    level.defend_zodiac_osprey delete();
  }

  level.defend_zodiac_osprey = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("defend_zodiac_osprey");
  level.defend_zodiac_osprey useanimtree(#animtree);
  level.defend_zodiac_osprey setanim( % v22_osprey_flying_idle);
  level.defend_zodiac_osprey.godmode = 1;
  level.defend_zodiac_osprey setmaxpitchroll(3, 18);
  level.depth_charge_default_pitch = 30;
  level.depth_charge_pitch_up_allowance = 25;
  level.depth_charge_pitch_down_allowance = 25;
  self setorigin(level.defend_zodiac_osprey gettagorigin("tag_ground") - anglestoup(level.defend_zodiac_osprey.angles) * 60);
  self setplayerangles((level.depth_charge_default_pitch, level.defend_zodiac_osprey.angles[1], level.defend_zodiac_osprey.angles[2]));
  self enableslowaim(0.25, 0.25);
  thread depth_charge_linkto();
  self.osprey_turret = spawnturret("misc_turret", level.defend_zodiac_osprey gettagorigin("tag_player"), "osprey_minigun");
  self.osprey_turret.angles = self getplayerangles();
  self.osprey_turret maketurretinoperable();
  self.osprey_turret setCanDamage(0);
  self.osprey_turret setModel("weapon_osprey_turret");
  self.osprey_turret setturretteam("allies");
  self.osprey_turret setmode("manual");
  self.osprey_turret.weaponinfo = "osprey_minigun";
  self.osprey_turret.weaponname = "osprey_minigun";
  self.osprey_turret.turret_target = common_scripts\utility::spawn_tag_origin();
  self.osprey_turret.turret_target.origin = self getEye() + anglesToForward(self getplayerangles()) * 2000;
  self.osprey_turret settargetentity(self.osprey_turret.turret_target);
  self.osprey_turret linkto(level.defend_zodiac_osprey);

  if(!isDefined(self.osprey_minigun_ammo)) {
    self.osprey_minigun_ammo = 9999;
  }

  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("cg_fov", 65);
  setsaveddvar("compassHideSansObjectivePointer", 1);
  level.depth_charge_current_fov = level.depth_charge_max_fov;
  level.depth_charge_start_time = gettime();
  level.depth_charges = [];
  level.defend_zodiac_osprey.old_contents = level.defend_zodiac_osprey setcontents(0);
  thread maps\carrier_audio::aud_carr_osprey_zone_on();
  thread depth_charge_run_finished();
  self notify("using_depth_charge");
  depth_charge_hud();
  thread setup_fake_destroyer_targets();
  thread depth_charge_mark_friendlies();
  thread depth_charge_update_target_location();
  thread depth_charge_drop_hint();
  thread depth_charge_minigun_hint();
  thread depth_charge_turn();
  thread depth_charge_monitor_drop();
  thread monitor_machine_gun();
  thread depth_charge_handle_zoom();
  thread depth_charge_monitor_wet();
}

depth_charge_linkto() {
  self playerlinktodelta(level.defend_zodiac_osprey, "tag_ground", 0.85, 70, 70, level.depth_charge_pitch_up_allowance, level.depth_charge_pitch_down_allowance, 0);
  self playerlinkedoffsetenable();
}

depth_charge_turn() {
  self endon("death");
  common_scripts\utility::flag_wait("defend_zodiac_osprey_turn");
  level.player notify("teleport_zodiacs");
  common_scripts\utility::flag_wait("defend_zodiac_osprey_end_turn");
  common_scripts\utility::flag_clear("defend_zodiac_osprey_turn");
  common_scripts\utility::flag_clear("defend_zodiac_osprey_turn_spawn");
}

depth_charge_run_finished() {
  self endon("death");
  common_scripts\utility::flag_clear("defend_zodiac_osprey_pre_finished");
  common_scripts\utility::flag_wait("defend_zodiac_osprey_pre_finished");
  self playersetstreamorigin(level.old_player_origin);
  maps\_utility::delaythread(0.7, ::fade_from_black);
  depth_charge_check_failure();
  common_scripts\utility::flag_clear("defend_zodiac_osprey_finished");
  common_scripts\utility::flag_wait("defend_zodiac_osprey_finished");
  clear_target_array();
  self notify("depth_charge_run_finished");
}

fade_from_black() {
  if(isDefined(level.black_overlay)) {
    level.black_overlay.alpha = 0;
    level.black_overlay fadeovertime(0.25);
    level.black_overlay.alpha = 1;
    wait 0.35;
    level.black_overlay fadeovertime(0.25);
    level.black_overlay.alpha = 0;
  }
}

clear_target_array() {
  var_0 = 0;

  while(target_getarray().size > 0) {
    var_1 = target_getarray();

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(var_0 > 15) {
        wait 0.05;
        var_0 = 0;
      }

      if(target_istarget(var_3)) {
        target_remove(var_3);
        var_0++;
      }
    }
  }
}

depth_charge_exit() {
  self notify("depth_charge_exit");
  self endon("death");
  self.using_depth_charge = 0;
  self.in_osprey = 0;
  maps\_utility::vision_set_fog_changes("carrier", 0);
  thread depth_charge_clear_hud();
  thread maps\carrier_audio::aud_carr_osprey_zone_off();

  if(isDefined(level.defend_zodiac_osprey)) {
    level.defend_zodiac_osprey stoploopsound("scn_carr_osprey_gun_loop");
  }

  self unlink();

  if(isDefined(self.osprey_turret)) {
    self.osprey_turret.turret_target delete();
    self.osprey_turret delete();
  }

  self setstance(self.prev_stance);
  self setorigin(level.old_player_origin);
  self setplayerangles(level.old_player_angles);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("compassHideSansObjectivePointer", 0);
  setsaveddvar("cg_fov", 65);
  depth_charge_control_down();
  self enableweaponswitch();
  self enableoffhandweapons();
  self show();
  self disableslowaim();
  self allowads(1);
  self allowmelee(1);
  self allowcrouch(1);
  self allowprone(1);
  self setmovespeedscale(1);
  self allowjump(1);
  self enabledeathshield(0);
  self disableinvulnerability();
  self notify("cleanup_depth_charges");
  level.depth_charges = [];

  if(isDefined(level.defend_zodiac_osprey)) {
    level.defend_zodiac_osprey setcontents(level.defend_zodiac_osprey.old_contents);
  }

  if(isDefined(level.depth_charge_target)) {
    level.depth_charge_target delete();
    level.depth_charge_target = undefined;
  }

  self setweaponhudiconoverride("actionslot1", "crr_dpad_osprey_inactive");
  refreshhudammocounter();
  wait 0.05;
  setsaveddvar("cg_fov", 65);
}

depth_charge_hud() {
  self.depth_charge_hud_elements = [];
  self.depth_charge_hud_elements["screen_overlay"] = newclienthudelem(self);
  self.depth_charge_hud_elements["screen_overlay"].x = 0;
  self.depth_charge_hud_elements["screen_overlay"].y = 0;
  self.depth_charge_hud_elements["screen_overlay"].alignx = "left";
  self.depth_charge_hud_elements["screen_overlay"].aligny = "top";
  self.depth_charge_hud_elements["screen_overlay"].horzalign = "fullscreen";
  self.depth_charge_hud_elements["screen_overlay"].vertalign = "fullscreen";
  self.depth_charge_hud_elements["screen_overlay"].alpha = 1;
  self.depth_charge_hud_elements["screen_overlay"] setshader("crr_hud_osprey_overlay_01", 640, 480);
  self.depth_charge_hud_elements["screen_vignette"] = newclienthudelem(self);
  self.depth_charge_hud_elements["screen_vignette"].x = 0;
  self.depth_charge_hud_elements["screen_vignette"].y = 0;
  self.depth_charge_hud_elements["screen_vignette"].alignx = "left";
  self.depth_charge_hud_elements["screen_vignette"].aligny = "top";
  self.depth_charge_hud_elements["screen_vignette"].horzalign = "fullscreen";
  self.depth_charge_hud_elements["screen_vignette"].vertalign = "fullscreen";
  self.depth_charge_hud_elements["screen_vignette"].alpha = 1;
  self.depth_charge_hud_elements["screen_vignette"] setshader("crr_hud_osprey_overlay_02", 640, 480);
  self.depth_charge_hud_elements["grain_overlay"] = newclienthudelem(self);
  self.depth_charge_hud_elements["grain_overlay"].x = 0;
  self.depth_charge_hud_elements["grain_overlay"].y = 0;
  self.depth_charge_hud_elements["grain_overlay"].alignx = "left";
  self.depth_charge_hud_elements["grain_overlay"].aligny = "top";
  self.depth_charge_hud_elements["grain_overlay"].horzalign = "fullscreen";
  self.depth_charge_hud_elements["grain_overlay"].vertalign = "fullscreen";
  self.depth_charge_hud_elements["grain_overlay"].alpha = 0.25;
  self.depth_charge_hud_elements["grain_overlay"] setshader("ac130_overlay_grain", 640, 480);
  self.depth_charge_hud_elements["mg_text"] = maps\_hud_util::createfontstring("hudsmall", 1);
  self.depth_charge_hud_elements["mg_text"].x = -140;

  if(!common_scripts\utility::is_player_gamepad_enabled()) {
    self.depth_charge_hud_elements["mg_text"].x = 140;
  }

  self.depth_charge_hud_elements["mg_text"].y = -5;
  self.depth_charge_hud_elements["mg_text"].alignx = "center";
  self.depth_charge_hud_elements["mg_text"].aligny = "top";
  self.depth_charge_hud_elements["mg_text"].horzalign = "center";
  self.depth_charge_hud_elements["mg_text"].vertalign = "top";
  self.depth_charge_hud_elements["mg_text"].alpha = 0.7;
  self.depth_charge_hud_elements["mg_text"].sort = 1;
  self.depth_charge_hud_elements["mg_text"] settext(&"CARRIER_OSPREY_HUD_MG");
  create_box("mg_text_bg", self.depth_charge_hud_elements["mg_text"].x, self.depth_charge_hud_elements["mg_text"].y, 165, 25, (1, 1, 1), 0);
  self.depth_charge_hud_elements["missile_text"] = maps\_hud_util::createfontstring("hudsmall", 1);
  self.depth_charge_hud_elements["missile_text"].x = 140;

  if(!common_scripts\utility::is_player_gamepad_enabled()) {
    self.depth_charge_hud_elements["missile_text"].x = -140;
  }

  self.depth_charge_hud_elements["missile_text"].y = -5;
  self.depth_charge_hud_elements["missile_text"].alignx = "center";
  self.depth_charge_hud_elements["missile_text"].aligny = "top";
  self.depth_charge_hud_elements["missile_text"].horzalign = "center";
  self.depth_charge_hud_elements["missile_text"].vertalign = "top";
  self.depth_charge_hud_elements["missile_text"].alpha = 0.7;
  self.depth_charge_hud_elements["missile_text"].sort = 1;
  self.depth_charge_hud_elements["missile_text"] settext(&"CARRIER_OSPREY_HUD_MISSILE");
  create_box("missile_text_bg", self.depth_charge_hud_elements["missile_text"].x, self.depth_charge_hud_elements["missile_text"].y, 165, 25, (1, 1, 1), 0);
  var_0 = 10;
  var_1 = 20;
  self.depth_charge_hud_elements["crosshair_vertical"] = maps\_hud_util::createicon("white", 1, 5000);
  self.depth_charge_hud_elements["crosshair_vertical"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_vertical"].alpha = 0.25;
  self.depth_charge_hud_elements["crosshair_horizontal"] = maps\_hud_util::createicon("white", 5000, 1);
  self.depth_charge_hud_elements["crosshair_horizontal"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_horizontal"].alpha = 0.25;
  self.depth_charge_hud_elements["crosshair_top_left_vertical"] = maps\_hud_util::createicon("white", 1, var_0);
  self.depth_charge_hud_elements["crosshair_top_left_vertical"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_top_left_vertical"].alignx = "left";
  self.depth_charge_hud_elements["crosshair_top_left_vertical"].aligny = "top";
  self.depth_charge_hud_elements["crosshair_top_left_vertical"].x = 0 - var_1;
  self.depth_charge_hud_elements["crosshair_top_left_vertical"].y = 0 - var_1;
  self.depth_charge_hud_elements["crosshair_top_left_vertical"].original_width = self.depth_charge_hud_elements["crosshair_top_left_vertical"].width;
  self.depth_charge_hud_elements["crosshair_top_left_vertical"].original_height = self.depth_charge_hud_elements["crosshair_top_left_vertical"].height;
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"] = maps\_hud_util::createicon("white", var_0, 1);
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"].alignx = "left";
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"].aligny = "top";
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"].x = 0 - var_1;
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"].y = 0 - var_1;
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"].original_width = self.depth_charge_hud_elements["crosshair_top_left_horizontal"].width;
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"].original_height = self.depth_charge_hud_elements["crosshair_top_left_horizontal"].height;
  self.depth_charge_hud_elements["crosshair_top_right_vertical"] = maps\_hud_util::createicon("white", 1, var_0);
  self.depth_charge_hud_elements["crosshair_top_right_vertical"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_top_right_vertical"].alignx = "right";
  self.depth_charge_hud_elements["crosshair_top_right_vertical"].aligny = "top";
  self.depth_charge_hud_elements["crosshair_top_right_vertical"].x = var_1;
  self.depth_charge_hud_elements["crosshair_top_right_vertical"].y = 0 - var_1;
  self.depth_charge_hud_elements["crosshair_top_right_vertical"].original_width = self.depth_charge_hud_elements["crosshair_top_right_vertical"].width;
  self.depth_charge_hud_elements["crosshair_top_right_vertical"].original_height = self.depth_charge_hud_elements["crosshair_top_right_vertical"].height;
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"] = maps\_hud_util::createicon("white", var_0, 1);
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"].alignx = "right";
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"].aligny = "top";
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"].x = var_1;
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"].y = 0 - var_1;
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"].original_width = self.depth_charge_hud_elements["crosshair_top_right_horizontal"].width;
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"].original_height = self.depth_charge_hud_elements["crosshair_top_right_horizontal"].height;
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"] = maps\_hud_util::createicon("white", 1, var_0);
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].alignx = "left";
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].aligny = "bottom";
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].x = 0 - var_1;
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].y = var_1;
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].original_width = self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].width;
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].original_height = self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].height;
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"] = maps\_hud_util::createicon("white", var_0, 1);
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].alignx = "left";
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].aligny = "bottom";
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].x = 0 - var_1;
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].y = var_1;
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].original_width = self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].width;
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].original_height = self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].height;
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"] = maps\_hud_util::createicon("white", 1, var_0);
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].alignx = "right";
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].aligny = "bottom";
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].x = var_1;
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].y = var_1;
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].original_width = self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].width;
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].original_height = self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].height;
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"] = maps\_hud_util::createicon("white", var_0, 1);
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"] set_default_hud_parameters();
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].alignx = "right";
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].aligny = "bottom";
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].x = var_1;
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].y = var_1;
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].original_width = self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].width;
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].original_height = self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].height;
  self.depth_charge_hud_elements["zoom_x"] = maps\_hud_util::createclientfontstring("hudsmall", 0.75);
  self.depth_charge_hud_elements["zoom_x"] set_default_hud_parameters();
  self.depth_charge_hud_elements["zoom_x"].alignx = "right";
  self.depth_charge_hud_elements["zoom_x"].aligny = "top";
  self.depth_charge_hud_elements["zoom_x"].horzalign = "left";
  self.depth_charge_hud_elements["zoom_x"].vertalign = "middle";
  self.depth_charge_hud_elements["zoom_x"].x = 5;
  self.depth_charge_hud_elements["zoom_x"].y = 5;
  self.depth_charge_hud_elements["zoom_x"] settext(&"SCRIPT_X");
  self.depth_charge_hud_elements["zoom_decimal"] = maps\_hud_util::createclientfontstring("hudsmall", 0.75);
  self.depth_charge_hud_elements["zoom_decimal"] set_default_hud_parameters();
  self.depth_charge_hud_elements["zoom_decimal"].point = "TOPRIGHT";
  self.depth_charge_hud_elements["zoom_decimal"].relativepoint = "TOPLEFT";
  self.depth_charge_hud_elements["zoom_decimal"].xoffset = -8;
  self.depth_charge_hud_elements["zoom_decimal"] maps\_hud_util::setparent(self.depth_charge_hud_elements["zoom_x"]);
  self.depth_charge_hud_elements["zoom_decimal"] setvalue(0);
  self.depth_charge_hud_elements["zoom_decimal_point"] = maps\_hud_util::createclientfontstring("hudsmall", 0.75);
  self.depth_charge_hud_elements["zoom_decimal_point"] set_default_hud_parameters();
  self.depth_charge_hud_elements["zoom_decimal_point"].point = "TOPRIGHT";
  self.depth_charge_hud_elements["zoom_decimal_point"].relativepoint = "TOPLEFT";
  self.depth_charge_hud_elements["zoom_decimal_point"].xoffset = -8;
  self.depth_charge_hud_elements["zoom_decimal_point"] maps\_hud_util::setparent(self.depth_charge_hud_elements["zoom_decimal"]);
  self.depth_charge_hud_elements["zoom_decimal_point"] settext(&"CARRIER_HUD_PERIOD");
  self.depth_charge_hud_elements["zoom_int"] = maps\_hud_util::createclientfontstring("hudsmall", 0.75);
  self.depth_charge_hud_elements["zoom_int"] set_default_hud_parameters();
  self.depth_charge_hud_elements["zoom_int"].point = "TOPRIGHT";
  self.depth_charge_hud_elements["zoom_int"].relativepoint = "TOPLEFT";
  self.depth_charge_hud_elements["zoom_int"].xoffset = -4.5;
  self.depth_charge_hud_elements["zoom_int"] maps\_hud_util::setparent(self.depth_charge_hud_elements["zoom_decimal_point"]);
  self.depth_charge_hud_elements["zoom_int"] setvalue(1);
  self.depth_charge_hud_elements["RNDS"] = maps\_hud_util::createclientfontstring("hudsmall", 0.75);
  self.depth_charge_hud_elements["RNDS"] set_default_hud_parameters();
  self.depth_charge_hud_elements["RNDS"].alignx = "left";
  self.depth_charge_hud_elements["RNDS"].aligny = "top";
  self.depth_charge_hud_elements["RNDS"].horzalign = "left";
  self.depth_charge_hud_elements["RNDS"].vertalign = "top";
  self.depth_charge_hud_elements["RNDS"].x = -20;
  self.depth_charge_hud_elements["RNDS"].y = 34;
  self.depth_charge_hud_elements["RNDS"] settext(&"CARRIER_RNDS");
  self.depth_charge_hud_elements["ammo"] = maps\_hud_util::createclientfontstring("hudsmall", 0.75);
  self.depth_charge_hud_elements["ammo"] set_default_hud_parameters();
  self.depth_charge_hud_elements["ammo"].alignx = "left";
  self.depth_charge_hud_elements["ammo"].aligny = "top";
  self.depth_charge_hud_elements["ammo"].horzalign = "left";
  self.depth_charge_hud_elements["ammo"].vertalign = "top";
  self.depth_charge_hud_elements["ammo"].x = -20;
  self.depth_charge_hud_elements["ammo"].y = 44;
  self.depth_charge_hud_elements["ammo"] setvalue(self.osprey_minigun_ammo);
}

depth_charge_weapon_hit() {
  self endon("depth_charge_exit");
  self notify("depth_charge_weapon_hit");
  self endon("depth_charge_weapon_hit");

  if(!isDefined(self.depth_charge_hud_elements)) {
    return;
  }
  self.depth_charge_hud_elements["crosshair_top_left_vertical"] setshader("white", self.depth_charge_hud_elements["crosshair_top_left_vertical"].width + 2, self.depth_charge_hud_elements["crosshair_top_left_vertical"].height + 2);
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"] setshader("white", self.depth_charge_hud_elements["crosshair_top_left_horizontal"].width + 2, self.depth_charge_hud_elements["crosshair_top_left_horizontal"].height + 2);
  self.depth_charge_hud_elements["crosshair_top_right_vertical"] setshader("white", self.depth_charge_hud_elements["crosshair_top_right_vertical"].width + 2, self.depth_charge_hud_elements["crosshair_top_right_vertical"].height + 2);
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"] setshader("white", self.depth_charge_hud_elements["crosshair_top_right_horizontal"].width + 2, self.depth_charge_hud_elements["crosshair_top_right_horizontal"].height + 2);
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"] setshader("white", self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].width + 2, self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].height + 2);
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"] setshader("white", self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].width + 2, self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].height + 2);
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"] setshader("white", self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].width + 2, self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].height + 2);
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"] setshader("white", self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].width + 2, self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].height + 2);
  wait 0.25;
  self.depth_charge_hud_elements["crosshair_top_left_vertical"] scaleovertime(0.25, self.depth_charge_hud_elements["crosshair_top_left_vertical"].original_width, self.depth_charge_hud_elements["crosshair_top_left_vertical"].original_height);
  self.depth_charge_hud_elements["crosshair_top_left_horizontal"] scaleovertime(0.25, self.depth_charge_hud_elements["crosshair_top_left_horizontal"].original_width, self.depth_charge_hud_elements["crosshair_top_left_horizontal"].original_height);
  self.depth_charge_hud_elements["crosshair_top_right_vertical"] scaleovertime(0.25, self.depth_charge_hud_elements["crosshair_top_right_vertical"].original_width, self.depth_charge_hud_elements["crosshair_top_right_vertical"].original_height);
  self.depth_charge_hud_elements["crosshair_top_right_horizontal"] scaleovertime(0.25, self.depth_charge_hud_elements["crosshair_top_right_horizontal"].original_width, self.depth_charge_hud_elements["crosshair_top_right_horizontal"].original_height);
  self.depth_charge_hud_elements["crosshair_bottom_left_vertical"] scaleovertime(0.25, self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].original_width, self.depth_charge_hud_elements["crosshair_bottom_left_vertical"].original_height);
  self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"] scaleovertime(0.25, self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].original_width, self.depth_charge_hud_elements["crosshair_bottom_left_horizontal"].original_height);
  self.depth_charge_hud_elements["crosshair_bottom_right_vertical"] scaleovertime(0.25, self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].original_width, self.depth_charge_hud_elements["crosshair_bottom_right_vertical"].original_height);
  self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"] scaleovertime(0.25, self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].original_width, self.depth_charge_hud_elements["crosshair_bottom_right_horizontal"].original_height);
}

create_box(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_1;
  var_8 = var_2 - 5;
  self.depth_charge_hud_elements[var_0] = maps\_hud_util::createicon("white", var_3, var_4);
  self.depth_charge_hud_elements[var_0] set_default_hud_parameters();
  self.depth_charge_hud_elements[var_0].x = var_7;
  self.depth_charge_hud_elements[var_0].y = var_8;
  self.depth_charge_hud_elements[var_0].alignx = "center";
  self.depth_charge_hud_elements[var_0].aligny = "top";
  self.depth_charge_hud_elements[var_0].horzalign = "center";
  self.depth_charge_hud_elements[var_0].vertalign = "top";
  self.depth_charge_hud_elements[var_0].alpha = var_6;
  self.depth_charge_hud_elements[var_0].color = var_5;
  self.depth_charge_hud_elements[var_0].sort = 0;
  create_line(var_0 + "_top", var_7, var_8, var_3, 1, var_5);
  create_line(var_0 + "_right", var_7 + var_3 / 2, var_8, 1, var_4, var_5);
  create_line(var_0 + "_bottom", var_7, var_8 + var_4 - 1, var_3, 1, var_5);
  create_line(var_0 + "_left", var_7 - var_3 / 2, var_8, 1, var_4, var_5);
}

create_line(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.depth_charge_hud_elements[var_0] = maps\_hud_util::createicon("white", var_3, var_4);
  self.depth_charge_hud_elements[var_0] set_default_hud_parameters();
  self.depth_charge_hud_elements[var_0].x = var_1;
  self.depth_charge_hud_elements[var_0].y = var_2;
  self.depth_charge_hud_elements[var_0].alignx = "center";
  self.depth_charge_hud_elements[var_0].aligny = "top";
  self.depth_charge_hud_elements[var_0].horzalign = "center";
  self.depth_charge_hud_elements[var_0].vertalign = "top";
  self.depth_charge_hud_elements[var_0].alpha = 1;
  self.depth_charge_hud_elements[var_0].color = var_5;
}

set_box(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self.depth_charge_hud_elements[var_0] fadeovertime(var_3);
  }

  self.depth_charge_hud_elements[var_0].alpha = var_1;
  self.depth_charge_hud_elements[var_0].color = var_2;
  set_line(var_0 + "_top", 1, var_2, var_3);
  set_line(var_0 + "_right", 1, var_2, var_3);
  set_line(var_0 + "_bottom", 1, var_2, var_3);
  set_line(var_0 + "_left", 1, var_2, var_3);
}

set_line(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self.depth_charge_hud_elements[var_0] fadeovertime(var_3);
  }

  self.depth_charge_hud_elements[var_0].alpha = var_1;
  self.depth_charge_hud_elements[var_0].color = var_2;
}

hud_mg_active() {
  self.depth_charge_hud_elements["mg_text"].color = (1, 0, 0);
  self.depth_charge_hud_elements["mg_text"].alpha = 1;
  set_box("mg_text_bg", 0.2, (1, 0, 0));
}

hud_mg_inactive() {
  self.depth_charge_hud_elements["mg_text"].color = (1, 1, 1);
  self.depth_charge_hud_elements["mg_text"].alpha = 0.7;
  set_box("mg_text_bg", 0, (1, 1, 1));
}

hud_missile_active() {
  var_0 = 0.5;
  self.depth_charge_hud_elements["missile_text"].color = (1, 0, 0);
  self.depth_charge_hud_elements["missile_text"].alpha = 1;
  self.depth_charge_hud_elements["missile_text"] fadeovertime(var_0);
  self.depth_charge_hud_elements["missile_text"].color = (1, 1, 1);
  self.depth_charge_hud_elements["missile_text"].alpha = 0.7;
  set_box("missile_text_bg", 0.2, (1, 0, 0));
  set_box("missile_text_bg", 0, (1, 1, 1), var_0);
}

depth_charge_clear_hud() {
  if(!isDefined(self.depth_charge_hud_elements)) {
    return;
  }
  var_0 = getarraykeys(self.depth_charge_hud_elements);

  foreach(var_2 in var_0) {
    if(isarray(self.depth_charge_hud_elements[var_2])) {
      foreach(var_5, var_4 in self.depth_charge_hud_elements[var_2]) {
        var_4 destroy();
        var_4 = undefined;
      }

      self.depth_charge_hud_elements[var_2] = [];
      continue;
    }

    self.depth_charge_hud_elements[var_2] destroy();
    self.depth_charge_hud_elements[var_2] = undefined;
  }

  self.depth_charge_hud_elements = undefined;
}

depth_charge_update_target_location() {
  self endon("depth_charge_exit");
  self endon("death");
  level.depth_charge_target = spawn("script_origin", level.defend_zodiac_osprey.origin);

  for(;;) {
    var_0 = (self getEye()[2] - level.water_level) / cos(90 - self getplayerangles()[0]);

    if(var_0 <= 0) {
      var_0 = 100000;
    }

    level.depth_charge_target.origin = self getEye() + anglesToForward(self getplayerangles()) * var_0;
    wait 0.05;
  }
}

depth_charge_monitor_drop() {
  self endon("depth_charge_remove_control");
  self endon("depth_charge_run_finished");
  self endon("death");
  self notifyonplayercommand("drop_depth_charge", "+attack");
  self notifyonplayercommand("drop_depth_charge", "+attack_akimbo_accessible");

  while(self.using_depth_charge) {
    self waittill("drop_depth_charge");
    thread depth_charge_drop();
    wait 0.75;
  }
}

depth_charge_drop() {
  self endon("death");

  if(!isDefined(level.osprey_missile_side_left)) {
    level.osprey_missile_side_left = 1;
  }

  var_0 = anglesToForward(level.defend_zodiac_osprey.angles) * 200;
  var_1 = magicbullet("osprey_missile", level.defend_zodiac_osprey gettagorigin(common_scripts\utility::ter_op(level.osprey_missile_side_left, "tag_light_l_wing1", "tag_light_r_wing1")) + anglesToForward(level.defend_zodiac_osprey.angles) * 100 - anglestoup(level.defend_zodiac_osprey.angles) * 50 + anglestoright(level.defend_zodiac_osprey.angles) * common_scripts\utility::ter_op(level.osprey_missile_side_left, -200, 200), level.depth_charge_target.origin + var_0, self);
  self playrumbleonentity("heavy_1s");
  thread maps\carrier_audio::aud_osprey_fire();
  thread hud_missile_active();
  var_1 thread depth_charge_lockon_to_target();
  var_2 = spawnStruct();
  var_2.impact_loc = maps\_utility::set_z(level.depth_charge_target.origin, level.water_level);

  if(distance2d(var_2.impact_loc, level.old_player_origin) <= 1500) {
    self.rain = 1;
  }

  var_2.time = gettime();
  level.depth_charges[level.depth_charges.size] = var_2;
  level.osprey_missile_side_left = !level.osprey_missile_side_left;
}

depth_charge_lockon_to_target() {
  level.player endon("death");
  var_0 = (level.player getEye()[2] - level.water_level) / cos(90 - level.player getplayerangles()[0]);
  var_1 = spawn("script_origin", level.player getEye() + anglesToForward(level.player getplayerangles()) * var_0);
  wait 0.25;

  if(isvalidmissile(self) && var_0 > 0) {
    self missile_settargetent(var_1);
  }

  while(isDefined(self) && isvalidmissile(self) && self.origin[2] > level.water_level) {
    wait 0.05;
  }

  if(isDefined(self)) {
    var_2 = 0;

    if(self.origin[2] < level.water_level + 32) {
      var_2 = 1;
    }

    var_3 = undefined;

    if(self istouching(level.osprey_carrier_vol)) {
      var_3 = level._effect["vfx_ac130_105mm_impact"];
    }

    thread depth_charge_explode(self.origin, var_2, var_3);

    if(isvalidmissile(self)) {
      self missile_cleartarget();
    }
  }

  var_1 delete();
}

depth_charge_explode(var_0, var_1, var_2) {
  level.player endon("death");
  var_0 = maps\_utility::set_z(var_0, level.water_level - 52);
  var_3 = level._effect["depth_charge_explosion"];

  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  if(var_1) {
    playFX(var_3, var_0);
    thread common_scripts\utility::play_sound_in_space("scn_carr_osprey_charge_exp", var_0);
  }

  thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_exp", var_0);
  var_4 = gettime();
  wait 0.1;
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5.origin = var_0;
  var_5 screenshakeonentity(4.5, 2, 3.5, 3, 0, 3, 25000, 5, 2, 7, 2.6);
  level.player playrumbleonentity("heavy_2s");
  maps\_utility::delaythread(0.25, maps\carrier_code_zodiac::explode_zodiacs, var_0, 1300, 200);
  maps\_utility::delaythread(0.1, maps\carrier_code::explode_gunboats, var_0, 1000, 200);
  maps\_utility::delaythread(0.1, ::explode_fake_targets, var_0, 1000);
  maps\_utility::delaythread(0.1, ::check_friendly_fire, var_0, 1000, 2000);
  level.player waittill("cleanup_depth_charges");

  if(var_1 && var_4 + 3000 < gettime() && common_scripts\utility::distance_2d_squared(level.player.origin, var_0) < 12960000) {
    thread common_scripts\utility::play_sound_in_space("scn_carr_water_plume", var_0);
  }

  var_5 delete();
}

depth_charge_replay() {
  var_0 = common_scripts\utility::getstruct("defend_zodiac_osprey_replay", "targetname");
  level.defend_zodiac_osprey vehicle_teleport(var_0.origin, var_0.angles);
  level.defend_zodiac_osprey thread maps\_vehicle::vehicle_paths(var_0);
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = level.defend_zodiac_osprey.origin;
  var_1 linkto(level.defend_zodiac_osprey);
  var_1 screenshakeonentity(0.2, 0.17, 0.1, 5, 1, 2, 5000, 12, 8, 5);

  if(maps\carrier_code::eval(self.rain)) {
    thread maps\carrier_code::rain_overlay_alpha(12, 0);
  }

  level.first_time_depth_charge = 0;
  common_scripts\utility::waitframe();
  var_1 delete();
}

depth_charge_monitor_wet() {
  self endon("depth_charge_remove_control");
  self endon("depth_charge_run_finished");
  self endon("depth_charge_exit");
  self endon("death");
  var_0 = 7000;
  var_1 = 1000000;

  for(;;) {
    var_2 = gettime();

    foreach(var_4 in level.depth_charges) {
      if(isDefined(var_4) && isDefined(var_4.time) && var_2 <= var_4.time + var_0 && distance2dsquared(level.player.origin, var_4.impact_loc) <= var_1) {
        thread maps\carrier_code::rain_overlay_alpha(4, 0);
        wait 2;
        break;
      }
    }

    wait 1;
  }
}

set_default_hud_parameters() {
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.hidewhendead = 0;
  self.hidewheninmenu = 0;
  self.sort = 205;
  self.foreground = 1;
  self.alpha = 1;
}

depth_charge_hint() {
  var_0 = 1.0;
  var_1 = 0.75;
  var_2 = 0.95;
  var_3 = 0.4;

  if(level.first_time_depth_charge) {
    level.iconelem2 = maps\_hud_util::createicon("crr_dpad_osprey_active", 32, 32);
    level.iconelem2.hidewheninmenu = 1;
    level.iconelem2 maps\_hud_util::setpoint("TOP", undefined, 0, 125);
    level.iconelem2.alpha = 0;
    level.iconelem2 fadeovertime(var_0);
    level.iconelem2.alpha = 1;
  }

  var_4 = maps\_hud_util::createfontstring("default", 1.75);
  var_4.horzalign = "center";
  var_4.vertalign = "middle";
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.x = 0;
  var_4.y = common_scripts\utility::ter_op(level.first_time_depth_charge, -30, 90);
  var_4 settext(&"CARRIER_DEPTH_CHARGE_HINT");
  var_4.alpha = 1;
  var_4.sort = 0.5;
  var_4.foreground = 1;
  var_4.hidewheninmenu = 1;
  var_4.alpha = 0;
  var_4 fadeovertime(var_0);
  var_4.alpha = var_2;
  thread hint_pulse_alpha(var_4, var_1, var_2, var_3);
  common_scripts\utility::waittill_any("using_depth_charge", "depth_charge_remove_control", "death");
  var_4 notify("stop_pulse");
  var_4 destroy();
  var_4 = undefined;

  if(level.first_time_depth_charge) {
    if(isDefined(level.iconelem)) {
      level.iconelem destroy();
    }

    if(isDefined(level.iconelem2)) {
      level.iconelem2 destroy();
    }

    if(isDefined(level.iconelem3)) {
      level.iconelem3 destroy();
    }
  }
}

depth_charge_drop_hint() {
  self endon("depth_charge_run_finished");
  self endon("depth_charge_remove_control");

  if(!isDefined(level.first_time_depth_charge_drop_hint)) {
    level.first_time_depth_charge_drop_hint = 1;
  }
  else {
    level.first_time_depth_charge_drop_hint = 0;
  }

  var_0 = maps\_hud_util::createfontstring("default", 1.75);
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.x = 120;
  var_0.y = common_scripts\utility::ter_op(level.first_time_depth_charge_drop_hint, -40, 130);
  var_0 settext(&"CARRIER_DEPTH_CHARGE_MISSILE_HINT");
  var_0.alpha = 1;
  var_0.sort = 0.5;
  var_0.foreground = 1;
  var_0.hidewheninmenu = 1;

  if(!common_scripts\utility::is_player_gamepad_enabled()) {
    var_0.fontscale = 1.25;
    var_0.x = var_0.x * -1;
  }

  var_1 = 1.0;
  var_2 = 0.75;
  var_3 = 0.95;
  var_4 = 0.4;
  var_0.alpha = 0;
  var_0 fadeovertime(var_1);
  var_0.alpha = var_3;
  thread hint_pulse_alpha(var_0, var_2, var_3, var_4);
  thread cleanup_weapon_hint(var_0);
  common_scripts\utility::waittill_any("drop_depth_charge", "fire_mg");
  wait 1;
  var_0.y = 130;
}

depth_charge_minigun_hint() {
  self endon("depth_charge_run_finished");
  self endon("depth_charge_remove_control");

  if(!isDefined(level.first_time_depth_charge_minigun_hint)) {
    level.first_time_depth_charge_minigun_hint = 1;
  }
  else {
    level.first_time_depth_charge_minigun_hint = 0;
  }

  var_0 = maps\_hud_util::createfontstring("default", 1.75);
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.x = -120;
  var_0.y = common_scripts\utility::ter_op(level.first_time_depth_charge_minigun_hint, -40, 130);
  var_1 = getkeybinding("+speed_throw");
  var_2 = isDefined(var_1) && var_1["count"] != 0;
  var_1 = getkeybinding("+ads_akimbo_accessible");
  var_3 = isDefined(var_1) && var_1["count"] != 0;

  if(var_2) {
    var_0 settext(&"CARRIER_DEPTH_CHARGE_MG_HINT");
  }
  else if(var_3) {
    var_0 settext(&"CARRIER_DEPTH_CHARGE_MG_NOMAD_HINT");
  }
  else {
    var_0 settext(&"CARRIER_DEPTH_CHARGE_MG_PC_HINT");
  }

  var_0.alpha = 1;
  var_0.sort = 0.5;
  var_0.foreground = 1;
  var_0.hidewheninmenu = 1;

  if(!common_scripts\utility::is_player_gamepad_enabled()) {
    var_0.fontscale = 1.25;
    var_0.x = var_0.x * -1;
  }

  var_4 = 1.0;
  var_5 = 0.75;
  var_6 = 0.95;
  var_7 = 0.4;
  var_0.alpha = 0;
  var_0 fadeovertime(var_4);
  var_0.alpha = var_6;
  thread hint_pulse_alpha(var_0, var_5, var_6, var_7);
  thread cleanup_weapon_hint(var_0);
  common_scripts\utility::waittill_any("drop_depth_charge", "fire_mg");
  wait 1;
  var_0.y = 130;
}

cleanup_weapon_hint(var_0) {
  common_scripts\utility::waittill_any("depth_charge_run_finished", "depth_charge_remove_control");
  var_0 notify("stop_pulse");
  var_0 destroy();
  var_0 = undefined;
}

hint_pulse_alpha(var_0, var_1, var_2, var_3) {
  var_0 endon("stop_pulse");

  for(;;) {
    var_0 fadeovertime(var_1);
    var_0.alpha = var_3;
    wait(var_1);
    var_0 fadeovertime(var_1);
    var_0.alpha = var_2;
    wait(var_1);
  }
}

depth_charge_control_up() {
  self.last_weapon = self getcurrentweapon();
  self giveweapon("remote_tablet_osprey");
  self switchtoweapon("remote_tablet_osprey");
  thread maps\carrier_audio::aud_osprey_controller_on();
  wait 1.65;
  level.black_overlay = maps\_hud_util::create_client_overlay("black", 0, self);
  level.black_overlay.sort = 999;
  level.black_overlay fadeovertime(0.25);
  level.black_overlay.alpha = 1;
  wait 0.25;
  level.black_overlay fadeovertime(0.25);
  level.black_overlay.alpha = 0;
}

depth_charge_control_down() {
  maps\_utility::restore_players_weapons("depth_charge");
  self enableslowaim(0.15, 0.15);
  wait 0.05;
  self switchtoweapon(self.last_weapon);
  wait 0.9;
  self takeweapon("remote_tablet_osprey");
  thread maps\carrier_audio::aud_osprey_controller_off();
  self disableslowaim();
}

monitor_machine_gun() {
  self endon("depth_charge_remove_control");
  self endon("depth_charge_run_finished");
  self endon("death");
  self notifyonplayercommand("fire_mg", "+speed_throw");
  self notifyonplayercommand("fire_mg", "+toggleads_throw");
  self notifyonplayercommand("fire_mg", "+ads_akimbo_accessible");
  var_0 = 0;

  while(self.using_depth_charge) {
    var_1 = (self getEye()[2] - level.water_level) / cos(90 - self getplayerangles()[0]);

    if(var_1 <= 0) {
      var_1 = 100000;
    }

    self.osprey_turret.turret_target.origin = self getEye() + anglesToForward(self getplayerangles()) * var_1;

    if(self adsbuttonpressed(1)) {
      if(!var_0) {
        level.player playSound("scn_carr_osprey_gun_start");
        self.osprey_turret startfiring();
      }

      thread hud_mg_active();
      level.defend_zodiac_osprey playLoopSound("scn_carr_osprey_gun_loop");
      self playrumbleonentity("minigun_rumble");
      self.osprey_turret shootturret();
      var_2 = 250;
      var_3 = bulletTrace(self getEye(), self.osprey_turret.turret_target.origin, 0);
      var_4 = var_3["position"];
      maps\_utility::delaythread(0.05, maps\carrier_code_zodiac::explode_zodiacs, var_4, var_2, 0);
      maps\_utility::delaythread(0.05, ::explode_fake_targets, var_4, var_2);
      maps\_utility::delaythread(0.05, ::check_friendly_fire, var_4, var_2, 65);
      var_0 = 1;
      self.osprey_minigun_ammo = self.osprey_minigun_ammo - 3;
      self.depth_charge_hud_elements["ammo"] setvalue(self.osprey_minigun_ammo);
    } else {
      if(var_0) {
        level.defend_zodiac_osprey playSound("scn_carr_osprey_gun_stop");
        self.osprey_turret stopfiring();
      }

      thread hud_mg_inactive();
      level.defend_zodiac_osprey stoploopsound("scn_carr_osprey_gun_loop");
      var_0 = 0;
    }

    wait 0.05;
  }
}

depth_charge_handle_zoom() {
  self endon("depth_charge_remove_control");
  self endon("depth_charge_run_finished");
  self endon("depth_charge_exit");
  self endon("death");
  var_0 = 0;
  level.depth_charge_firing_slow_aim_modifier = 0.0;

  for(;;) {
    var_1 = self getnormalizedmovement();

    if(var_1[0] == 0) {
      wait 0.05;
      var_0 = 0;
      continue;
    }

    if(var_0 <= 0 && var_1[0] > 0 && level.depth_charge_current_fov > level.depth_charge_min_fov || var_0 >= 0 && var_1[0] < 0 && level.depth_charge_current_fov < level.depth_charge_max_fov) {
      thread depth_charge_lerp_dof();
    }

    var_0 = var_1[0];
    var_2 = level.depth_charge_current_fov / 20.0;
    var_2 = min(3, var_2);
    var_2 = max(0.5, var_2);
    level.depth_charge_current_fov = level.depth_charge_current_fov - var_1[0] * var_2;

    if(level.depth_charge_current_fov < level.depth_charge_min_fov) {
      level.depth_charge_current_fov = level.depth_charge_min_fov;
    }
    else if(level.depth_charge_current_fov > level.depth_charge_max_fov) {
      level.depth_charge_current_fov = level.depth_charge_max_fov;
    }

    self lerpfov(level.depth_charge_current_fov, 0.05);
    depth_charge_set_slow_aim();
    var_3 = 1.0 + (level.depth_charge_max_fov - getdvarfloat("cg_fov")) / (level.depth_charge_max_fov - level.depth_charge_min_fov) * 3.0;
    var_4 = int(var_3);
    var_5 = int((var_3 - int(var_3)) * 10);

    if(isDefined(self.depth_charge_hud_elements["zoom_int"])) {
      self.depth_charge_hud_elements["zoom_int"] setvalue(var_4);
      self.depth_charge_hud_elements["zoom_decimal"] setvalue(var_5);
    }

    wait 0.05;
  }
}

depth_charge_set_slow_aim() {
  var_0 = (level.fov_range - (level.depth_charge_max_fov - level.depth_charge_current_fov)) / level.fov_range;
  level.depth_charge_current_slow_yaw = level.depth_charge_min_slow_aim_yaw + level.slow_aim_yaw_range * var_0 + level.depth_charge_firing_slow_aim_modifier;
  level.depth_charge_current_slow_pitch = level.depth_charge_min_slow_aim_pitch + level.slow_aim_pitch_range * var_0 + level.depth_charge_firing_slow_aim_modifier;
  self enableslowaim(level.depth_charge_current_slow_pitch, level.depth_charge_current_slow_yaw);
}

depth_charge_lerp_dof(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  self notify("depth_charge_lerp_dof");
  self endon("depth_charge_lerp_dof");
  maps\_art::dof_enable_script(50, 100, 10, 100, 200, 6, 0.0);
  maps\_art::dof_disable_script(var_0);
}

depth_charge_mark_friendlies() {
  foreach(var_1 in getaiarray()) {
    if(var_1.team == "allies") {
      var_1 thread maps\carrier_code::setup_target_on_vehicle();
    }
  }

  foreach(var_4 in level.drones["allies"].array) {
  var_4 thread maps\carrier_code::setup_target_on_vehicle();
  }
}

setup_fake_destroyer_targets() {
  level.fake_targets = common_scripts\utility::array_removeundefined(level.fake_targets);

  foreach(var_1 in level.fake_targets) {
    if(isDefined(var_1)) {
      var_1 thread maps\carrier_code::setup_target_on_vehicle();
      wait 0.05;
    }
  }
}

explode_fake_targets(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.fake_targets) {
    if(isDefined(var_4)) {
      var_5 = distancesquared(var_4.origin, var_0);

      if(var_5 <= var_2) {
        level.osprey_hit_fake_targets++;
        level.osprey_total_hits++;
        var_4 thread explode_single_fake_target(var_0);
        level.player thread depth_charge_weapon_hit();
        wait 0.05;
      }
    }
  }
}

explode_single_fake_target(var_0) {
  self notify("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "big") {
    playFX(common_scripts\utility::getfx("vfx_destroyer_vert_missile_impact"), self.origin);
    screenshake(self.origin, 3.5, 2, 2.5, 2, 0, 2, 10000, 5, 2, 7, 2.6);
    level.player playrumbleonentity("heavy_1s");
    thread common_scripts\utility::play_sound_in_space("exp_armor_vehicle", self.origin);
    level notify("stop_fed_destroyer_guns");
    common_scripts\utility::flag_set("destroyed_fed_destroyer_guns");
    self delete();
  } else if(isDefined(self.model) && issubstr(self.model, "zodiac"))
    maps\carrier_code_zodiac::explode_single_zodiac(0.5, var_0);
  else if(maps\_vehicle::isvehicle() && maps\_vehicle::ishelicopter()) {
    self kill();
  }
}

check_friendly_fire(var_0, var_1, var_2) {
  var_3 = 1300;

  if(var_0[2] > var_3) {
    radiusdamage(var_0, var_1, var_2, var_2 / 2, level.player);
  }
}

depth_charge_check_failure() {
  var_0 = level.difficultysettings["osprey_hitsToSucceed"][maps\_gameskill::get_skill_from_index(level.gameskill)];

  if(var_0 <= 0) {
    return;
  }
  if(level.osprey_total_hits < var_0) {
    setdvar("ui_deadquote", &"CARRIER_FAIL_FAR_AWAY");
    maps\_utility::missionfailedwrapper();
  }
}