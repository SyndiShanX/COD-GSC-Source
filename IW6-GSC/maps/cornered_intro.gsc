/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_intro.gsc
*****************************************************/

cornered_intro_pre_load() {
  common_scripts\utility::flag_init("player_falling");
  common_scripts\utility::flag_init("intro_id_scan");
  common_scripts\utility::flag_init("fade_in_done");
  common_scripts\utility::flag_init("start_introtext");
  common_scripts\utility::flag_init("swap_ally_intro_gun");
  common_scripts\utility::flag_init("helicopter_spawned");
  common_scripts\utility::flag_init("introscreen_done");
  common_scripts\utility::flag_init("intro_vo_begin");
  common_scripts\utility::flag_init("intro_baker_move");
  common_scripts\utility::flag_init("vip_heli_approach");
  common_scripts\utility::flag_init("intro_heli_landed");
  common_scripts\utility::flag_init("looking_at_roof");
  common_scripts\utility::flag_init("zipline_launcher_setup");
  common_scripts\utility::flag_init("player_fired_zipline");
  common_scripts\utility::flag_init("intro_baker_done");
  common_scripts\utility::flag_init("intro_rorke_done");
  common_scripts\utility::flag_init("start_hvt_scene");
  common_scripts\utility::flag_init("hvt_greeter_meet");
  common_scripts\utility::flag_init("hvt_chopper_leave");
  common_scripts\utility::flag_init("give_player_binoculars");
  common_scripts\utility::flag_init("give_binocular_hint_if_needed");
  common_scripts\utility::flag_init("player_using_binoculars");
  common_scripts\utility::flag_init("rorke_launcher_aim_loop_start");
  common_scripts\utility::flag_init("baker_launcher_aim_loop_start");
  common_scripts\utility::flag_init("player_setting_turret");
  common_scripts\utility::flag_init("player_on_turret");
  common_scripts\utility::flag_init("player_can_use_zipline");
  common_scripts\utility::flag_init("player_is_starting_zipline");
  common_scripts\utility::flag_init("player_is_ziplining");
  common_scripts\utility::flag_init("fx_screen_raindrops");
  common_scripts\utility::flag_init("player_detach");
  common_scripts\utility::flag_init("do_specular_sun_lerp");
  common_scripts\utility::flag_init("intro_finished");
  common_scripts\utility::flag_init("zipline_finished");
  common_scripts\utility::flag_init("rorke_ready_to_setup_zipline");
  common_scripts\utility::flag_init("baker_ready_to_setup_zipline");
  precachemodel("generic_prop_raven");
  precachemodel("head_cnd_test_goggles_glow");
  precachemodel("cnd_briefcase_01_shell");
  precachemodel("weapon_imbel_ia2");
  precachemodel("weapon_silencer_01");
  precachemodel("vehicle_nh90_interior_only");
  precachemodel("cnd_rappel_device");
  precachemodel("cnd_rappel_device_obj");
  precachemodel("cnd_zipline_rope");
  precachemodel("cnd_rappel_tele_rope_noclip");
  precachemodel("cnd_rappel_window_frame_obj");
  precachemodel("weapon_zipline_rope_launcher_alt_obj");
  precachemodel("head_keegan_cornered_xb");
  precachemodel("head_keegan_cornered_xx");
  precachemodel("head_keegan_cornered_x");
  precacherumble("light_1s");
  precacherumble("heavy_2s");
  precacherumble("chopper_flyover");
  precacherumble("light_in_out_2s");
  precacherumble("subtle_tank_rumble");
  precacheshader("reticle_center_cross");
  precacheturret("player_view_controller_binoculars_slow");
  precachestring(&"CORNERED_BINOCULARS_USE_HINT");
  precachestring(&"CORNERED_BINOCULARS_ZOOM_HINT");
  precachestring(&"CORNERED_BINOCULARS_SCAN_HINT");
  precachestring(&"CORNERED_BINOCULARS_RANGE_HINT");
  precachestring(&"CORNERED_BINOCULARS_FAIL");
  precachestring(&"CORNERED_BINOCULARS_REMOVE_HINT");
  precachestring(&"CORNERED_DEPLOY_ZIPLINE_TURRET");
  precachestring(&"CORNERED_DEPLOY_ZIPLINE_TURRET_CONSOLE");
  precachestring(&"CORNERED_START_ZIPLINE");
  precachestring(&"CORNERED_START_ZIPLINE_CONSOLE");
  maps\_utility::add_hint_string("binoc_use", &"CORNERED_BINOCULARS_USE_HINT");
  maps\_utility::add_hint_string("binoc_zoom", &"CORNERED_BINOCULARS_ZOOM_HINT", ::binoculars_hide_hint);
  maps\_utility::add_hint_string("binoc_scan", &"CORNERED_BINOCULARS_SCAN_HINT", ::scan_hide_hint);
  maps\_utility::add_hint_string("binoc_range", &"CORNERED_BINOCULARS_RANGE_HINT");
  maps\_utility::add_hint_string("binoc_deactivate", &"CORNERED_BINOCULARS_REMOVE_HINT", ::binoculars_hide_deactive_hint);
  maps\_utility::add_hint_string("fire_zipline", &"CORNERED_ZIPLINE_FIRE");
  level.cornered_player_arms = maps\_utility::spawn_anim_model("cornered_player_arms");
  level.cornered_player_arms maps\cornered_code::player_flap_sleeves_setup(1);
  maps\cornered_code::hide_player_arms();
  level.cornered_player_legs = maps\_utility::spawn_anim_model("cornered_player_legs");
  level.cornered_player_legs hide();
  level.arms_and_legs = [];
  level.arms_and_legs = common_scripts\utility::add_to_array(level.arms_and_legs, level.cornered_player_arms);
  level.arms_and_legs = common_scripts\utility::add_to_array(level.arms_and_legs, level.cornered_player_legs);
  level.zipline_trolley_obj = getent("zipline_trolley_obj", "targetname");
  level.zipline_trolley_obj hide();
  level.rappel_window_frame_obj = getent("rappel_window_frame_obj", "targetname");
  level.rappel_window_frame_obj hide();
  level.zipline_window_player_hit = getent("zipline_window_player_hit", "targetname");
  level.zipline_window_player_hit hide();
  level.reflection_window_inverted = getent("reflection_window", "targetname");
  level.reflection_window_inverted hide();
  level.large_outside_lights_on = getEntArray("large_outside_lights_on", "targetname");
  level.large_outside_lights_off = getEntArray("large_outside_lights_off", "targetname");

  foreach(var_1 in level.large_outside_lights_off) {
  var_1 hide();
  }
}

setup_intro() {
  setdvar("e3", "0");
  setup_intro_internal();
}

setup_intro_internal() {
  level.start_point = "intro";
  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_audio::aud_check("intro");
  thread maps\cornered_lighting::lerp_dof();
}

setup_zipline() {
  level.zipline_startpoint = 1;
  maps\cornered_code::setup_player();
  maps\cornered_code::spawn_allies();
  thread zipline_setup();
  thread maps\cornered_code::handle_intro_fx();
  thread maps\cornered_audio::aud_check("zipline");
  thread maps\cornered_lighting::fireworks_intro_post();
  thread maps\cornered_code::set_emissive_window_brushes_visible(0);
  common_scripts\utility::flag_set("rorke_ready_to_setup_zipline");
  common_scripts\utility::flag_set("fx_screen_raindrops");
  thread maps\cornered_fx::fx_screen_raindrops();
}

begin_intro() {
  level.intro_black = thread maps\_introscreen::introscreen_generic_black_fade_in(8);
  maps\_utility::delaythread(7, common_scripts\utility::flag_set, "fade_in_done");
  maps\_utility::delaythread(1, common_scripts\utility::flag_set, "start_introtext");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\cornered_code::take_away_offhands();
  thread intro_save_check("intro_done", "intro_finished");
  thread intro();
  thread maps\cornered_lighting::fireworks_intro();
  thread maps\cornered_code::set_emissive_window_brushes_visible(0);
  common_scripts\utility::flag_set("fx_screen_raindrops");
  thread maps\cornered_fx::fx_screen_raindrops();
  thread intro_handle_ps4_ssao();
  common_scripts\utility::flag_wait("intro_finished");
}

begin_zipline() {
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\cornered_code::take_away_offhands();
  common_scripts\utility::flag_wait("rorke_ready_to_setup_zipline");
  thread zipline();
  common_scripts\utility::flag_wait("zipline_finished");

  if(maps\cornered_code::is_e3()) {
    thread maps\_utility::autosave_by_name_silent("zipline");
  }
  else {
    thread maps\_utility::autosave_tactical();
  }
}

intro() {
  thread introscreen_display();
  thread intro_handler();
  thread intro_allies_vo();
  thread zipline_setup();
}

intro_handle_ps4_ssao() {
  if(!level.ps4) {
    return;
  }
  setsaveddvar("r_ssaoScriptScale", 0);
  level.player waittill("binoculars_init_hud");
  setsaveddvar("r_ssaoScriptScale", 1);
}

introscreen_display() {
  maps\_utility::intro_screen_create(&"CORNERED_INTROSCREEN_LINE_1", &"CORNERED_INTROSCREEN_LINE_2", &"CORNERED_INTROSCREEN_LINE_5", &"CORNERED_INTROSCREEN_LINE_3");
  common_scripts\utility::flag_wait("start_introtext");
  level maps\_introscreen::introscreen(1);
}

intro_handler() {
  level endon("intro_fail");
  level endon("player_falling");
  level thread intro_chopper_fx();

  if(!maps\cornered_code::is_e3()) {
    thread intro_enemy_scene();
  }

  var_0 = getent("start_building_fall_volume", "targetname");
  var_0 thread maps\cornered_code::cornered_falling_death();
  level.intro_struct = common_scripts\utility::getstruct("stealth_intro_struct", "targetname");
  thread intro_player();
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname("vip_heli");
  level.vip_heli = maps\_utility::get_vehicle("vip_heli", "script_noteworthy");
  level.vip_heli thread intro_prep_vip_heli();
  wait 6;
  level.allies[level.const_rorke].animname = "rorke";
  level.allies[level.const_baker].animname = "baker";
  level.allies[level.const_rorke] thread intro_rorke();
  wait 0.2;
  thread intro_rorke_gun();
  thread intro_baker();

  if(getdvar("intro_mask") == "0") {
    wait 8.5;
  }
  else {
    wait 11.5;
  }

  if(!maps\cornered_code::is_e3()) {
    level.vip_heli thread maps\_vehicle_code::animate_drive_idle();
    var_2 = common_scripts\utility::getstruct("vip_start_node", "targetname");
    level.vip_heli thread maps\_vehicle::vehicle_paths(var_2);
    var_1 maps\_vehicle::godon();
    var_1 vehicle_turnengineoff();
  }

  var_3 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("intro_helis");
  common_scripts\utility::flag_set("helicopter_spawned");

  foreach(var_5 in var_3) {
    var_5 maps\_vehicle::godon();
    var_5 vehicle_turnengineoff();
  }

  common_scripts\utility::array_thread(var_3, maps\_vehicle::vehicle_lights_on, "running");

  if(!maps\cornered_code::is_e3()) {
    level.vip_heli thread intro_heli_land();
  }

  wait 1.2;
  common_scripts\utility::flag_set("intro_vo_begin");
  wait 2.5;
  level.player playrumbleonentity("chopper_flyover");
  earthquake(0.25, 9, level.vip_heli.origin, 6000);

  if(!maps\cornered_code::is_e3()) {
    common_scripts\utility::flag_wait("intro_heli_landed");
    wait 1.75;
    intro_binocular_scene();
  }

  wait 0.5;
  common_scripts\utility::flag_set("intro_finished");
}

intro_player() {
  level endon("player_falling");
  level.player freezecontrols(1);
  level.player common_scripts\utility::_disableweapon();
  wait 0.2;
  level.player setstance("crouch");
  thread intro_player_stand();
  var_0 = level.player common_scripts\utility::spawn_tag_origin();
  var_0.origin = var_0.origin + (0, 0, 0.3);
  var_0.angles = level.player.angles + (-8, 0, 0);
  waittillframeend;
  level.player playerlinktoabsolute(var_0, "tag_origin");
  common_scripts\utility::flag_wait("fade_in_done");
  wait 1.5;
  level.player unlink();
  level.player freezecontrols(0);
  var_0 delete();

  if(!maps\cornered_code::is_e3()) {
    common_scripts\utility::flag_wait("give_player_binoculars");
    level.player maps\cornered_binoculars::give_binoculars();
    wait 0.25;
    level.player thread intro_binocs_check_look_target();
    level.player thread intro_binocs_check_look_target_for_render();
    level.player thread handle_binocular_zoom_magnet();
    thread intro_binocular_monitor();
    wait 0.5;
    thread intro_binocs_not_target_vo();
    thread intro_binocs_oracle_scanning_vo();
    common_scripts\utility::flag_wait("hvt_confirmed");
    level.player common_scripts\utility::_enableweapon();
  } else
    common_scripts\utility::flag_set("hvt_confirmed");
}

handle_binocular_zoom_magnet() {
  self endon("take_binoculars");
  var_0 = common_scripts\utility::getstruct("binoculars_zone_bottom_left", "targetname").origin;
  var_1 = common_scripts\utility::getstruct("binoculars_zone_top_right", "targetname").origin;

  for(;;) {
    self waittill("binoculars_zoom_lerp");
    var_2 = self getplayerangles()[1];
    var_3 = self getplayerangles()[0];
    var_4 = vectortoyaw(var_0 - self getEye());
    var_5 = vectortoyaw(var_1 - self getEye());
    var_6 = vectortoangles(var_0 - self getEye())[0];
    var_7 = vectortoangles(var_1 - self getEye())[0];

    if(angleclamp180(var_2 - var_4) <= 0 && angleclamp180(var_2 - var_5) >= 0) {
      var_8 = vectornormalize(vectorcross((0, 0, 1), var_1 - var_0));
      var_9 = vectordot(var_0 - self getEye(), var_8) / vectordot(anglesToForward(self getplayerangles()), var_8);
      var_10 = self getEye() + anglesToForward(self getplayerangles()) * var_9;

      if(var_10[2] > var_1[2] && var_10[2] - var_1[2] < 500) {
        var_11 = (var_0[0], var_0[1], var_1[2]);
        var_12 = vectornormalize(var_0 - var_1);
        var_13 = var_1 + var_12 * vectordot(var_12, var_10 - var_1);
        adjust_player_view(var_10, var_13);
      } else if(var_10[2] < var_0[2] && var_0[2] - var_10[2] < 500) {
        var_11 = (var_1[0], var_1[1], var_0[2]);
        var_12 = vectornormalize(var_1 - var_0);
        var_13 = var_0 + var_12 * vectordot(var_12, var_10 - var_0);
        adjust_player_view(var_10, var_13);
      }
    }
  }
}

adjust_player_view(var_0, var_1) {
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("tag_origin");
  var_2.origin = self.origin;
  var_2.angles = self getplayerangles();
  var_3 = maps\_utility::get_player_view_controller(var_2, "tag_origin", (0, 0, 0), "player_view_controller_binoculars_slow");
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_origin");
  var_3 snaptotargetentity(var_4);
  var_5 = self.origin;
  var_6 = spawn("script_model", var_1);
  var_6 setModel("tag_origin");
  self playerlinktoabsolute(var_3, "tag_aim");
  var_3 settargetentity(var_6, self.origin - self getEye());
  wait 1;
  self unlink();
  self setorigin(var_5);
  var_3 delete();
  var_2 delete();
  var_4 delete();
  var_6 delete();
}

intro_player_stand() {
  common_scripts\utility::flag_wait("player_stand");

  if(level.player getstance() == "crouch" || level.player getstance() == "prone") {
    level.player setstance("stand");
  }
}

rorke_jump_vision_change() {
  if(!maps\_utility::is_gen4()) {
    return;
  }
  wait 10.7;
  level.player maps\_utility::vision_set_changes("cornered_0.4", 3);
}

merrick_handle_name_when_scanning() {
  level endon("done_with_binoculars");

  for(;;) {
    var_0 = isDefined(level.player.binoculars_active) && level.player.binoculars_active;
    var_1 = isDefined(level.player.current_binocular_zoom_level) && level.player.current_binocular_zoom_level > 0;

    if(var_0 && var_1) {
      self.name = "";
    }
    else {
      self.name = "Keegan";
    }

    common_scripts\utility::waitframe();
  }
}

#using_animtree("generic_human");

intro_rorke() {
  var_0 = getent("rorke_fake_collision", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }

  level.intro_hidetaglist = getweaponhidetags(self.weapon);
  wait 0.2;
  level.intro_struct thread maps\_anim::anim_single_solo(self, "cornered_intro_rorke_2_start");
  common_scripts\utility::waitframe();
  var_1 = undefined;

  if(getdvar("intro_mask") != "0") {
    self setanim( % cornered_level_intro_merrick_start_mask, 1, 0.1);
  }

  thread maps\cornered_audio::aud_intro("r_jump");
  thread rorke_jump_vision_change();
  wait 0.1;
  maps\_utility::gun_remove();
  self waittillmatch("single anim", "anim_gunhand = \"right\"");
  common_scripts\utility::flag_set("swap_ally_intro_gun");
  maps\_utility::gun_recall();

  if(getdvar("intro_mask") != "0") {
    wait 2.2;
    thread maps\_utility::play_sound_on_entity("crnd_intro_mask");
  }

  self waittillmatch("single anim", "end");

  if(getdvar("intro_mask") != "0") {
    self clearanim( % cornered_level_intro_merrick_start_mask, 0);
    thread maps\cornered_code::head_swap("head_keegan_cornered_xb");
  }

  if(!maps\cornered_code::is_e3()) {
    if(getdvar("intro_mask") == "0") {
      level.intro_struct maps\_anim::anim_first_frame_solo(self, "cornered_intro_rorke_2_end");
    }
    else {
      level.intro_struct thread maps\_anim::anim_loop_solo(self, "cornered_level_intro_merrick_loop", "stop_loop");
    }

    thread keegan_swap_head_to_goggles();
    thread merrick_handle_name_when_scanning();
    common_scripts\utility::flag_wait("hvt_confirmed");

    if(isDefined(level.player.binoculars_active) && level.player.binoculars_active) {
      level.player waittill("stop_using_binoculars");

      if(!isDefined(level.goggle_head_keegan)) {
        thread maps\cornered_code::head_swap("head_keegan_cornered_xx");
      }
    }

    level notify("done_with_binoculars");
  }

  level.intro_struct notify("stop_loop");
  level.intro_struct thread maps\_anim::anim_single_solo(self, "cornered_intro_rorke_2_end");

  if(!maps\cornered_code::is_e3()) {
    level.allies[level.const_rorke] thread maps\cornered_code::char_dialog_add_and_go("cornered_rke_hardcopyoracleblack");
  }

  common_scripts\utility::waitframe();
  self.name = "Keegan";
  self waittillmatch("single anim", "visor_on");
  thread maps\cornered_audio::aud_intro("r_goggles");

  if(maps\cornered_code::is_e3()) {
    wait 2;
    level.player common_scripts\utility::_enableweapon();
  }

  self waittillmatch("single anim", "end");
  thread maps\cornered_code::head_swap("head_keegan_cornered_x");
  common_scripts\utility::flag_set("rorke_ready_to_setup_zipline");
}

keegan_swap_head_to_goggles() {
  level notify("done_with_binoculars");
  level.goggle_head_keegan = undefined;

  for(;;) {
    var_0 = isDefined(level.player.binoculars_active) && level.player.binoculars_active;
    var_1 = isDefined(level.player.current_binocular_zoom_level) && level.player.current_binocular_zoom_level > 0;

    if(var_0) {
      if(var_1) {
        if(!maps\_utility::within_fov_2d(level.player.origin, level.player.angles, self gettagorigin("j_head_end"), cos(8))) {
          thread maps\cornered_code::head_swap("head_keegan_cornered_xx");
          level.goggle_head_keegan = 1;
          break;
        }
      } else if(!maps\_utility::within_fov_2d(level.player.origin, level.player.angles, self gettagorigin("j_head_end"), cos(50))) {
        thread maps\cornered_code::head_swap("head_keegan_cornered_xx");
        level.goggle_head_keegan = 1;
        break;
      }
    }

    wait 0.05;
  }
}

intro_rorke_gun() {
  var_0 = maps\_utility::spawn_anim_model("intro_gun");
  level.intro_struct thread maps\_anim::anim_first_frame_solo(var_0, "cornered_intro_rorke_gun");
  var_1 = var_0 gettagorigin("J_prop_1");
  var_2 = var_0 gettagangles("J_prop_1");
  var_3 = spawn("script_model", var_1);
  var_3 setModel("weapon_imbel_ia2");
  var_3 attach("weapon_silencer_01", "");
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_3 linkto(var_0, "J_prop_1");
  level.intro_struct thread maps\_anim::anim_single_solo(var_0, "cornered_intro_rorke_gun");
  common_scripts\utility::flag_wait("swap_ally_intro_gun");
  var_3 unlink();
  var_3 delete();
  var_0 delete();
}

start_baker(var_0) {
  common_scripts\utility::flag_set("intro_baker_move");
}

intro_baker() {
  level.intro_struct thread maps\_anim::anim_loop_solo(level.allies[level.const_baker], "cornered_intro_baker_loop1", "stop_baker_intro_loop");
  common_scripts\utility::flag_wait("intro_baker_move");
  level.intro_struct notify("stop_baker_intro_loop");
  waittillframeend;
  level.intro_struct thread maps\_anim::anim_single_solo(level.allies[level.const_baker], "cornered_intro_baker");
  level.allies[level.const_baker] waittillmatch("single anim", "visor_on");
  level.allies[level.const_baker] waittillmatch("single anim", "end");
  level.intro_struct thread maps\_anim::anim_loop_solo(level.allies[level.const_baker], "cornered_intro_baker_loop2", "stop_baker_intro_loop");
  common_scripts\utility::flag_set("baker_ready_to_setup_zipline");
}

intro_chopper_fx() {
  common_scripts\utility::exploder(7389);
  level thread bird_fx();
  common_scripts\utility::flag_wait("vip_heli_approach");
  wait 0.5;
  maps\_utility::stop_exploder(7389);
}

bird_fx() {
  wait 0.7;
  common_scripts\utility::exploder(22271);
}

intro_prep_vip_heli() {
  self.path_gobbler = 1;
  self.animname = "nh90";
  self setmaxpitchroll(10, 10);
  thread maps\_vehicle::vehicle_lights_on("running");
  thread maps\_vehicle::vehicle_lights_on("interior");
  var_0 = getent("vip_heli_window_block", "targetname");
  var_1 = getent("vip_heli_right_door_block", "targetname");
  var_2 = getent("vip_heli_left_door_block", "targetname");
  var_0 linkto(self, "tag_origin");
  var_1 linkto(self, "door_r");
  var_2 linkto(self, "door_l");
  var_3 = self gettagorigin("tag_origin");
  var_4 = self gettagangles("tag_origin");
  var_5 = spawn("script_model", var_3);
  var_5.angles = (0, 90, 0);
  var_5 linkto(self, "tag_origin", (27, 1, -54), (0, 0, 0));
  var_5 setModel("vehicle_nh90_interior_only");
  var_5 setcontents(0);
  var_5 notsolid();
  var_0 setcontents(0);
  var_0 notsolid();
  var_1 setcontents(0);
  var_1 notsolid();
  var_2 setcontents(0);
  var_2 notsolid();
  common_scripts\utility::flag_wait("vip_heli_delete_blockers");
  var_5 delete();
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

intro_heli_land() {
  common_scripts\utility::flag_wait("vip_heli_move_to_anim");
  maps\_utility::vehicle_detachfrompath();
  common_scripts\utility::flag_set("vip_heli_approach");
  var_0 = common_scripts\utility::getstruct("intro_hvt_roof_animnode", "targetname");
  var_0 maps\_anim::anim_single_solo(self, "cornered_roof_arrival_land_nh90");
  common_scripts\utility::flag_set("intro_heli_landed");
  self setgoalyaw(self.angles[1]);
  self settargetyaw(self.angles[1]);
  self sethoverparams(0, 0, 0);
  self setvehgoalpos(self.origin, 1);

  if(!common_scripts\utility::flag("looking_at_roof")) {
    var_0 thread maps\_anim::anim_loop_solo(self, "cornered_roof_arrival_wait_nh90", "stop_loop");
  }

  if(!maps\cornered_code::is_e3()) {
    common_scripts\utility::flag_wait("looking_at_roof");
  }

  var_0 notify("stop_loop");
  var_0 maps\_anim::anim_single_solo(self, "cornered_roof_arrival");
  var_0 thread maps\_anim::anim_loop_solo(self, "cornered_roof_arrival_wait_nh90", "stop_loop");
  common_scripts\utility::flag_wait("hvt_chopper_leave");
  var_0 notify("stop_loop");
  waittillframeend;
  thread maps\_vehicle_code::animate_drive_idle();
  self setmaxpitchroll(10, 35);
  var_1 = common_scripts\utility::getstruct("vip_heli_exit_path", "targetname");
  thread maps\_vehicle::vehicle_paths(var_1);
}

intro_enemy_setup() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  maps\_utility::magic_bullet_shield(1);
  thread random_talk();

  if(self.script_noteworthy == "intro_hvt") {
    level.intro_hvt = self;
    self.animname = "hvt";
    common_scripts\utility::waitframe();
    self.binocular_facial_profile = "cnd_binocs_hud_photo_001";
    self.binocular_hvt = 1;
    self.script_startingposition = 2;
    maps\_utility::gun_remove();
    var_0 = self gettagangles("tag_weapon_left");
    level.briefcase = spawn("script_model", self gettagorigin("tag_weapon_left"));
    level.briefcase setModel("cnd_briefcase_01_shell");
    level.briefcase.angles = var_0;
    level.briefcase linkto(self, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
  } else {
    switch (self.headmodel) {
      case "head_fed_basic_a":
        self.binocular_facial_profile = "cnd_binocs_hud_photo_004";
        break;
      case "head_fed_basic_b":
        self.binocular_facial_profile = "cnd_binocs_hud_photo_003";
        break;
      case "head_fed_basic_c":
        self.binocular_facial_profile = "cnd_binocs_hud_photo_005";
        break;
      case "head_fed_basic_d":
        self.binocular_facial_profile = "cnd_binocs_hud_photo_002";
        break;
    }
  }

  if(self.script_noteworthy == "intro_cmdr") {
    level.intro_cmdr = self;
    self.animname = "cmdr";
    maps\_utility::gun_remove();
    thread debug_death();
  }

  if(self.script_noteworthy == "intro_agent") {
    level.intro_agent = self;
    self.animname = "agent";
    maps\_utility::gun_remove();
  }

  if(self.script_noteworthy == "intro_enemy2") {
    level.intro_enemy2 = self;
    self.animname = "enemy2";
    self.script_startingposition = 3;
  }

  if(self.script_noteworthy == "intro_enemy3") {
    level.intro_enemy3 = self;
    self.animname = "enemy3";
    self.script_startingposition = 4;
  }

  if(self.script_noteworthy == "intro_enemy5") {
    level.intro_enemy5 = self;
    self.animname = "enemy5";
  }

  if(self.script_noteworthy == "intro_enemy7") {
    level.intro_enemy7 = self;
    self.animname = "enemy7";
  }

  if(self.script_noteworthy == "intro_enemy8") {
    level.intro_enemy8 = self;
    self.animname = "enemy8";
  }

  if(self.script_noteworthy == "intro_enemy9") {
    level.intro_enemy9 = self;
    self.animname = "enemy9";
  }

  if(self.script_noteworthy == "intro_enemy10") {
    level.intro_enemy10 = self;
    self.animname = "enemy10";
  }

  if(self.script_noteworthy == "intro_enemy11") {
    level.intro_enemy11 = self;
    self.animname = "enemy11";
  }

  if(self.script_noteworthy == "intro_enemy12") {
    level.intro_enemy12 = self;
    self.animname = "enemy12";
    self.script_startingposition = 5;
  }
}

random_talk() {
  self endon("death");
  self endon("end_talking");

  if(self.script_noteworthy == "intro_cmdr") {
    common_scripts\utility::flag_wait_all("intro_heli_landed", "looking_at_roof");
    wait 11;
  }

  if(self.script_noteworthy == "intro_enemy5") {
    thread stop_random_talk();
  }

  if(self.script_noteworthy == "intro_enemy12") {
    return;
  }
  for(;;) {
    wait(randomfloatrange(2.5, 6.0));
    thread maps\_anim::anim_facialfiller("stop_lip_flap");
    wait(randomfloatrange(0.75, 2.0));
    self notify("stop_lip_flap");
  }
}

stop_random_talk() {
  self endon("death");
  common_scripts\utility::flag_wait_all("intro_heli_landed", "looking_at_roof");
  wait 16;
  self notify("end_talking");
  self notify("stop_lip_flap");
}

debug_death() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);
}

intro_enemy_scene() {
  level.intro_roof_node = common_scripts\utility::getstruct("intro_hvt_roof_animnode", "targetname");
  thread intro_roof_door2();
  var_0 = maps\_utility::array_spawn_function_targetname("intro_roof_guys_0", ::intro_enemy_setup);
  var_1 = maps\_utility::array_spawn_function_targetname("intro_roof_guys_1", ::intro_enemy_setup);
  var_2 = maps\_utility::array_spawn_function_targetname("intro_roof_guys_2", ::intro_enemy_setup);
  var_3 = maps\_utility::array_spawn_function_targetname("intro_roof_guys_3", ::intro_enemy_setup);
  var_3 = maps\_utility::array_spawn_function_targetname("intro_roof_guys_4", ::intro_enemy_setup);
  var_0 = maps\_utility::array_spawn_targetname("intro_roof_guys_0", 1);
  var_1 = maps\_utility::array_spawn_targetname("intro_roof_guys_1", 1);
  var_4 = [];
  var_4[0] = level.intro_agent;
  var_4[1] = level.intro_cmdr;
  var_4[2] = level.intro_enemy5;
  var_5 = [];
  var_5[0] = level.intro_enemy7;
  var_5[1] = level.intro_enemy8;

  foreach(var_7 in var_4) {
  level.intro_roof_node thread maps\_anim::anim_loop_solo(var_7, "cornered_roof_arrival_wait", "stop_loop");
  }

  foreach(var_7 in var_5) {
  level.intro_roof_node thread maps\_anim::anim_loop_solo(var_7, "cornered_roof_arrival_wait", "stop_loop_guys_loop");
  }

  common_scripts\utility::flag_wait_all("intro_heli_landed", "looking_at_roof");
  level.intro_roof_node notify("stop_loop");
  var_2 = maps\_utility::array_spawn_targetname("intro_roof_guys_2", 1);
  var_4[3] = level.intro_hvt;
  var_4[4] = level.intro_enemy2;
  var_4[5] = level.intro_enemy3;
  var_4[6] = level.intro_enemy12;
  level.intro_roof_node thread maps\_anim::anim_single(var_4, "cornered_roof_arrival");
  level.intro_hvt waittillmatch("single anim", "nh90_takeoff");
  common_scripts\utility::flag_set("hvt_chopper_leave");
  level.intro_hvt waittillmatch("single anim", "start_enemy9_and_10");
  var_11 = maps\_utility::array_spawn_targetname("intro_roof_guys_3", 1);
  common_scripts\utility::waitframe();
  var_12 = [];
  var_12[0] = level.intro_enemy9;
  var_12[1] = level.intro_enemy10;
  level.intro_roof_node thread maps\_anim::anim_single(var_12, "cornered_roof_arrival_mid");
  level.intro_enemy2 waittillmatch("single anim", "end");
  level.intro_roof_node thread maps\_anim::anim_loop_solo(var_4[2], "cornered_roof_end_loop", "stop_loop");
  level.intro_roof_node thread maps\_anim::anim_loop_solo(var_4[4], "cornered_roof_end_loop", "stop_loop");
  level.intro_roof_node thread maps\_anim::anim_loop_solo(var_4[5], "cornered_roof_end_loop", "stop_loop");
  level.intro_hvt waittillmatch("single anim", "start_enemy11");
  var_11 = maps\_utility::array_spawn_targetname("intro_roof_guys_4", 1);
  common_scripts\utility::waitframe();
  var_13 = [];
  var_13[0] = level.intro_enemy11;
  level.intro_roof_node thread maps\_anim::anim_single(var_13, "cornered_roof_arrival_late");
  level.intro_hvt waittillmatch("single anim", "end");

  if(!common_scripts\utility::flag("hvt_confirmed")) {
    level notify("scanning_failed");
  }

  common_scripts\utility::waitframe();
  level.briefcase delete();
  var_4 = common_scripts\utility::array_remove(var_4, level.intro_enemy5);
  var_4 = common_scripts\utility::array_remove(var_4, level.intro_enemy2);
  var_4 = common_scripts\utility::array_remove(var_4, level.intro_enemy3);
  wait 0.05;
  maps\_utility::array_delete(var_4);
  level.intro_enemy11 waittillmatch("single anim", "end");
  maps\_utility::array_delete(var_13);
  common_scripts\utility::flag_wait("zipline_finished");
  level.intro_roof_node notify("stop_loop");
  waittillframeend;
  maps\_utility::array_delete(var_12);
  maps\_utility::array_delete(var_5);
  level.intro_enemy2 delete();
  level.intro_enemy3 delete();
  level.intro_enemy5 delete();
}

intro_binocular_scene() {
  level endon("intro_fail");
  level endon("player_falling");
  thread intro_target_monitor();
  level.player waittill("hvt_confirmed");
  common_scripts\utility::flag_set("obj_confirm_id_complete");
  maps\cornered_code::radio_dialog_add_and_go("cornered_orc_missionisago");
  level notify("intro_succeed");
}

intro_binocular_monitor() {
  level endon("intro_fail");
  level endon("player_falling");
  intro_check_binocular_activate();
  level.player waittill("hvt_confirmed");
  intro_check_binocular_deactivate();
}

look_at_roof_nag() {
  if(common_scripts\utility::flag("looking_at_roof")) {
    return;
  }
  level endon("looking_at_roof");
  level thread look_at_roof_nag_vo();
  level waittill("last_binoc_nag");
  objective_onentity(1, level.vip_heli, (0, 0, -50));
  objective_setpointertextoverride(1, &"CORNERED_OBJ_DOT_TARGET");
  thread look_at_roof_nag_cleanup();
  var_0 = 1;
}

look_at_roof_nag_vo() {
  level endon("looking_at_roof");
  var_0 = 3;
  level waittill("ready_look_nag");
  var_1 = 1;

  for(;;) {
    wait(var_0);

    if(var_1 && level.player.binoculars_active) {
      var_1 = 0;
      var_0 = 4;
      level.allies[level.const_rorke] maps\cornered_code::char_dialog_add_and_go("cornered_mrk_ourtargetsonthe");
      continue;
    }

    if(level.player.binoculars_active) {
      level.allies[level.const_rorke] maps\cornered_code::char_dialog_add_and_go("cornered_mrk_focusonthechopper");
      level notify("last_binoc_nag");
      var_0 = 10;
    }
  }
}

clear_chopper_target_pointer() {
  objective_additionalposition(1, 0, (0, 0, 0));
  objective_setpointertextoverride(1, "");
}

look_at_roof_nag_cleanup() {
  common_scripts\utility::flag_wait("looking_at_roof");
  clear_chopper_target_pointer();
}

player_looking_at_hvt() {
  var_0 = level.binoc_target.origin;
  var_1 = 300;

  if(level.binoc_target == level.vip_heli) {
    var_0 = var_0 + (0, 0, -50);
  }
  else {
    var_1 = 1000;
  }

  if(self.current_binocular_zoom_level == 1) {
    return self worldpointinreticle_circle(var_0, 2, var_1);
  }
  else {
    return self worldpointinreticle_circle(var_0, 65, 100);
  }
}

intro_binocs_check_look_target() {
  level endon("binoculars_deactivated");
  level childthread look_at_roof_nag();
  var_0 = common_scripts\utility::getstruct("intro_hvt_roof_animnode", "targetname");
  level.binoc_target = level.vip_heli;

  while(!isDefined(self.current_binocular_zoom_level)) {
    common_scripts\utility::waitframe();
  }

  thread intro_check_binocular_zoom();

  while(level.player.current_binocular_zoom_level == 0 || !level.player player_looking_at_hvt()) {
    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("looking_at_roof");
  thread set_binoc_target_to_hvt();
  intro_check_binocular_scan();
  thread intro_check_binocular_range();
  level.binoc_target = undefined;
}

set_binoc_target_to_hvt() {
  while(!isDefined(level.intro_hvt)) {
    common_scripts\utility::waitframe();
  }

  level.binoc_target = level.intro_hvt;
}

intro_binocs_check_look_target_for_render() {
  level endon("binoculars_deactivated");
  var_0 = common_scripts\utility::getstruct("intro_hvt_roof_animnode", "targetname");
  var_1 = common_scripts\utility::getstruct("intro_binoc_target", "targetname");

  while(!isDefined(self.current_binocular_zoom_level)) {
    wait 0.05;
  }

  for(;;) {
    if(level.player worldpointinreticle_circle(var_1.origin, 2, 3500) && self.current_binocular_zoom_level != 0) {
      level.player playersetstreamorigin(var_0.origin + (0, 256, 64));
      setsaveddvar("sm_sunShadowCenter", var_0.origin);

      if(isDefined(level.ps3) && level.ps3) {
        setsaveddvar("r_znear", 40.0);
      }
    } else {
      level.player playerclearstreamorigin();
      setsaveddvar("sm_sunShadowCenter", (0, 0, 0));

      if(isDefined(level.ps3) && level.ps3) {
        setsaveddvar("r_znear", 4.0);
      }
    }

    wait 0.05;
  }
}

intro_check_binocular_activate() {
  level endon("intro_fail");
  level endon("player_falling");

  if(!level.player.binoculars_active) {
    thread intro_binoculars_use_hint(0.25, "binoc_use", "give_binocular_hint_if_needed", "binoculars_used");
    level.player waittill("use_binoculars");
  }

  level notify("binoculars_used");
  common_scripts\utility::flag_set("player_using_binoculars");
}

intro_check_binocular_zoom() {
  level endon("intro_fail");
  level endon("player_falling");
  thread intro_binoculars_hint(0, "binoc_zoom", undefined, "binoculars_zoomed");
  common_scripts\utility::flag_wait("looking_at_roof");
  level notify("binoculars_zoomed");
}

binoculars_hide_hint() {
  if(!level.player.binoculars_active) {
    return 1;
  }

  if(level.player.current_binocular_zoom_level > 0) {
    return 1;
  }

  if(!isDefined(level.binoc_target) || !level.player player_looking_at_hvt()) {
    return 1;
  }

  return 0;
}

binoculars_hide_deactive_hint() {
  if(isDefined(level.player.binoculars_linked_to_target) && level.player.binoculars_linked_to_target) {
    return 1;
  }

  if(!isDefined(level.player.has_binoculars) || !level.player.has_binoculars) {
    return 1;
  }

  return 0;
}

intro_check_binocular_scan() {
  level endon("intro_fail");
  level endon("player_falling");
  thread intro_binoculars_hint(2, "binoc_scan", undefined, "binoculars_scanned");
  common_scripts\utility::flag_wait("hvt_confirmed");
  level notify("binoculars_scanned");
}

scan_hide_hint() {
  if(!level.player.binoculars_active) {
    return 1;
  }

  if(level.player.current_binocular_zoom_level == 0) {
    return 1;
  }

  if(!isDefined(level.binoc_target) || !level.player player_looking_at_hvt()) {
    return 1;
  }

  if(!isDefined(level.player.binoculars_scan_target)) {
    return 1;
  }

  if(!isDefined(level.player.show_binoc_scan_hint) || !level.player.show_binoc_scan_hint) {
    return 1;
  }

  if(level.missionfailed) {
    return 1;
  }

  return 0;
}

intro_check_binocular_range() {
  level endon("intro_fail");
  level endon("intro_succeed");
  level endon("player_falling");

  for(;;) {
    while(level.player.binoculars_active == 0) {
      common_scripts\utility::waitframe();
    }

    level.player waittill("scanning_complete");

    if(level.player.current_binocular_zoom_level != level.player.binocular_zoom_levels - 1) {
      level.player thread maps\_utility::display_hint("binoc_range");
      wait 4;
    }

    wait 0.05;
  }
}

intro_check_binocular_deactivate() {
  level endon("intro_fail");
  level endon("player_falling");

  if(level.player.binoculars_active) {
    thread intro_binoculars_deactiveate_hint();
  }

  level.player waittill("stop_using_binoculars");
  level notify("binoculars_deactivated");
  level.player playerclearstreamorigin();
  setsaveddvar("sm_sunShadowCenter", (0, 0, 0));

  if(isDefined(level.ps3) && level.ps3) {
    setsaveddvar("r_znear", 4.0);
  }

  level.player maps\cornered_binoculars::take_binoculars();
  common_scripts\utility::waitframe();

  if(!common_scripts\utility::flag("zipline_launcher_setup")) {
    level.player switchtoweapon("imbel+acog_sp+silencer_sp");
  }
}

intro_binoculars_deactiveate_hint() {
  level endon("binoculars_deactivated");

  while(isDefined(level.player.binoculars_linked_to_target) && level.player.binoculars_linked_to_target) {
    common_scripts\utility::waitframe();
  }

  wait 2;

  for(;;) {
    level.player maps\_utility::ent_flag_waitopen("global_hint_in_use");
    common_scripts\utility::waitframe();
    level.player thread maps\_utility::display_hint("binoc_deactivate");
  }
}

intro_binoculars_use_hint(var_0, var_1, var_2, var_3) {
  level endon("player_falling");
  level endon(var_3);

  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
  }

  wait(var_0);

  for(;;) {
    level.player thread maps\_utility::display_hint(var_1);
    wait 7.0;
  }
}

intro_binoculars_hint(var_0, var_1, var_2, var_3) {
  level endon(var_3);
  level.player endon("death");

  if(!isDefined(level.player) || !isalive(level.player)) {
    return;
  }
  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
  }

  wait(var_0);
  waittill_binoculars_active();

  for(;;) {
    level.player maps\_utility::ent_flag_waitopen("global_hint_in_use");
    waittill_binoculars_active();
    common_scripts\utility::waitframe();
    level.player thread maps\_utility::display_hint(var_1);
  }
}

waittill_binoculars_active() {
  while(!level.player.binoculars_active) {
    common_scripts\utility::waitframe();
  }
}

intro_roof_door2() {
  var_0 = getent("roof_door2_l", "targetname");
  var_1 = getent("roof_door2_r", "targetname");
  var_0 rotateyaw(95, 0.05);
  var_1 rotateyaw(-95, 0.05);
  wait 0.35;
  var_0 connectpaths();
  var_1 connectpaths();
}

intro_target_monitor() {
  level.player endon("hvt_confirmed");
  level endon("player_falling");
  level waittill("scanning_failed");
  setdvar("ui_deadquote", &"CORNERED_BINOCULARS_FAIL");
  maps\_utility::missionfailedwrapper();
}

intro_building_check() {
  level endon("player_falling");
  level endon("player_is_starting_zipline");
  var_0 = getent("off_building_vol", "targetname");

  for(;;) {
    if(!level.player istouching(var_0)) {
      common_scripts\utility::flag_clear("off_start_building");
    }

    wait 0.05;
  }
}

intro_save_check(var_0, var_1) {
  level endon("stop_save_attempt");
  common_scripts\utility::flag_wait(var_1);

  for(var_2 = 0; var_2 < 10; var_2++) {
    if(!common_scripts\utility::flag("off_start_building")) {
      if(maps\cornered_code::is_e3()) {
        thread maps\_utility::autosave_by_name_silent(var_0);
      }
      else {
        thread maps\_utility::autosave_by_name(var_0);
      }

      level notify("stop_save_attempt");
    }

    wait 0.1;
  }
}

intro_allies_vo() {
  level endon("player_falling");
  thread intro_building_check();
  thread intro_save_check("intro_scanning_seq", "intro_id_scan");
  common_scripts\utility::flag_wait("intro_vo_begin");

  if(getdvar("intro_mask") == "0") {
    level.allies[level.const_rorke] maps\cornered_code::char_dialog_add_and_go("cornered_rke_heretheycomestay");
  }

  common_scripts\utility::flag_wait("vip_heli_approach");
  wait 0.5;

  if(!maps\cornered_code::is_e3()) {
    thread maps\cornered::obj_confirm_id();
    common_scripts\utility::flag_set("give_player_binoculars");
    common_scripts\utility::flag_set("give_binocular_hint_if_needed");
  }

  if(maps\cornered_code::is_e3()) {
    wait 3;
  }

  level.allies[level.const_baker] maps\cornered_code::char_dialog_add_and_go("cornered_bkr_ourtarget");

  if(maps\cornered_code::is_e3()) {
    return;
  }
  common_scripts\utility::flag_set("intro_id_scan");
  wait 0.75;
  level.allies[level.const_rorke] maps\cornered_code::char_dialog_add_and_go("cornered_rke_confirmvisual");
  wait 0.35;
  level.allies[level.const_rorke] maps\cornered_code::char_dialog_add_and_go("cornered_rke_preparetoreceive");
  maps\cornered_code::radio_dialog_add_and_go("cornered_orc_copyblackknight");

  while(level.player.binoculars_active == 0) {
    common_scripts\utility::waitframe();
  }

  wait 0.5;
  maps\cornered_code::radio_dialog_add_and_go("cornered_orc_receivingtransmissionup");
  thread intro_binocs_inactive_nag_vo();
  level notify("ready_look_nag");
}

intro_binocs_inactive_nag_vo() {
  level endon("intro_succeed");
  level endon("intro_fail");
  level.player endon("hvt_confirmed");
  level endon("kill_binoc_nags");
  level endon("player_falling");
  var_0 = maps\_utility::make_array("cornered_orc_wevelostthefeed", "cornered_orc_signalisnotactive");
  var_1 = -1;

  for(;;) {
    var_2 = randomint(var_0.size);

    if(var_2 == var_1) {
      var_2++;

      if(var_2 >= var_0.size) {
        var_2 = 0;
      }
    }

    var_3 = var_0[var_2];

    if(level.player.binoculars_active == 0) {
      maps\cornered_code::radio_dialog_add_and_go_interrupt(var_3);
      wait 3.0;
    }

    var_1 = var_2;
    common_scripts\utility::waitframe();
  }
}

intro_binocs_not_target_vo() {
  level endon("intro_fail");
  level endon("player_falling");
  var_0 = maps\_utility::make_array("cornered_orc_negativethatisnot", "cornered_orc_negativeid", "cornered_orc_incorrecttarget");
  var_1 = -1;

  for(;;) {
    while(!isDefined(level.player.current_binocular_zoom_level) && !isDefined(level.player.binocular_zoom_levels)) {
      wait 0.05;
    }

    if(level.player.current_binocular_zoom_level == level.player.binocular_zoom_levels - 1) {
      level.player waittill("scanning_upload_verified");
      var_2 = randomint(var_0.size);

      if(var_2 == var_1) {
        var_2++;

        if(var_2 >= var_0.size) {
          var_2 = 0;
        }
      }

      var_3 = var_0[var_2];
      wait 0.55;

      if(!common_scripts\utility::flag("hvt_confirmed")) {
        maps\cornered_code::radio_dialog_add_and_go_interrupt(var_3);
      }

      var_1 = var_2;
    }

    if(common_scripts\utility::flag("hvt_confirmed")) {
      break;
    }

    common_scripts\utility::waitframe();
  }
}

intro_binocs_oracle_scanning_vo() {
  level endon("intro_succeed");
  level endon("intro_fail");
  level.player endon("hvt_confirmed");
  level endon("kill_binoc_nags");
  level endon("player_falling");
  var_0 = maps\_utility::make_array("cornered_orc_receivingdata", "cornered_orc_receivinguplink", "cornered_orc_uploadingimage");
  var_1 = -1;
  var_2 = maps\_utility::make_array("cornered_pri_nogoodneeda", "cornered_pri_negativeidwaituntil");
  var_3 = -1;

  for(;;) {
    while(!isDefined(level.player.current_binocular_zoom_level) && !isDefined(level.player.binocular_zoom_levels)) {
      wait 0.05;
    }

    if(!level.player attackbuttonpressed()) {
      level.player waittill("scanning_target");
    }

    if(level.player.current_binocular_zoom_level == level.player.binocular_zoom_levels - 1) {
      wait 0.05;

      if(level.player attackbuttonpressed() && common_scripts\utility::flag("scan_target_not_facing")) {
        var_4 = randomint(var_2.size);

        if(var_4 == var_3) {
          var_4++;

          if(var_4 >= var_2.size) {
            var_4 = 0;
          }
        }

        var_5 = var_2[var_4];
        maps\cornered_code::radio_dialog_add_and_go_interrupt(var_5);
        var_3 = var_4;
      } else {
        var_6 = randomint(var_0.size);

        if(var_6 == var_1) {
          var_6++;

          if(var_6 >= var_0.size) {
            var_6 = 0;
          }
        }

        var_7 = var_0[var_6];
        maps\cornered_code::radio_dialog_add_and_go_interrupt(var_7);
        var_1 = var_6;
      }

      while(level.player attackbuttonpressed()) {
        wait 0.05;
      }
    }

    common_scripts\utility::waitframe();
  }
}

zipline_setup() {
  level.zipline_anim_struct = common_scripts\utility::getstruct("zipline_anim_struct", "targetname");
  level.zipline_launcher_player = getent("zipline_launcher_player", "targetname");
  level.zipline_launcher_player setdefaultdroppitch(-10);
  level.zipline_launcher_player maketurretinoperable();
  level.zipline_launcher_player makeunusable();
  level.zipline_launcher_player hide();
  level.fake_turret = spawn("script_model", level.zipline_launcher_player.origin);
  level.fake_turret setModel(level.zipline_launcher_player.model);
  level.fake_turret.angles = level.zipline_launcher_player.angles;
  level.fake_turret.animname = "zipline_launcher";
  level.fake_turret.targetname = "zipline_launcher_player";
  level.fake_turret maps\_anim::setanimtree();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.fake_turret, "zipline_launcher_setup_player");
  level.zipline_launcher_rorke = getent("zipline_launcher_rorke", "targetname");
  level.zipline_launcher_rorke.animname = "zipline_launcher";
  level.zipline_launcher_rorke maps\_anim::setanimtree();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.zipline_launcher_rorke, "zipline_launcher_setup_rorke");
  level.zipline_launcher_baker = getent("zipline_launcher_baker", "targetname");
  level.zipline_launcher_baker.animname = "zipline_launcher";
  level.zipline_launcher_baker maps\_anim::setanimtree();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.zipline_launcher_baker, "zipline_launcher_setup_baker");
  level.zipline_rope = maps\_utility::spawn_anim_model("cnd_zipline_rope");
  level.zipline_rope hide();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.zipline_rope, "cornered_zipline_playerline_launched");
  level.detach_rope_player = maps\_utility::spawn_anim_model("cnd_zipline_rope");
  level.detach_rope_player hide();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.detach_rope_player, "cornered_zipline_player");
  level.zipline_rope_rorke = maps\_utility::spawn_anim_model("cnd_zipline_rope");
  level.zipline_rope_rorke hide();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.zipline_rope_rorke, "cornered_zipline_rorkeline_launched");
  level.detach_rope_rorke = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope_noclip");
  level.detach_rope_rorke hide();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.detach_rope_rorke, "zipline_rorke");
  level.zipline_rope_baker = maps\_utility::spawn_anim_model("cnd_zipline_rope");
  level.zipline_rope_baker hide();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.zipline_rope_baker, "cornered_zipline_bakerline_launched");
  level.detach_rope_baker = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope_noclip");
  level.detach_rope_baker hide();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.detach_rope_baker, "zipline_baker");
  level.zipline_trolley_player = maps\_utility::spawn_anim_model("cnd_rappel_device");
  level.zipline_trolley_player hide();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.zipline_trolley_player, "cornered_zipline_trolley_player");
  level.zipline_trolley_rorke = maps\_utility::spawn_anim_model("cnd_rappel_device");
  level.zipline_trolley_rorke hide();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.zipline_trolley_rorke, "zipline_trolley_fire_rorke");
  level.zipline_trolley_baker = maps\_utility::spawn_anim_model("cnd_rappel_device");
  level.zipline_trolley_baker hide();
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(level.zipline_trolley_baker, "zipline_trolley_fire_baker");
}

zipline() {
  thread maps\cornered::obj_fire_zipline();
  level.player thread maps\cornered_zipline_turret::player_handle_zipline_turret(level.zipline_launcher_player);
  thread zipline_allies_vo();
  thread zipline_allies_anims();
  thread zipline_player_anims();
  thread zipline_equipment_anims();
}

ally_zipline_nag(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::flag(var_1)) {
    return;
  }
  var_5 = -1;

  while(!common_scripts\utility::flag(var_1)) {
    var_6 = randomfloatrange(var_2, var_3);
    wait(var_6);
    var_7 = randomint(var_0.size);

    if(var_7 == var_5) {
      var_7++;

      if(var_7 >= var_0.size) {
        var_7 = 0;
      }
    }

    var_8 = var_0[var_7];

    if(common_scripts\utility::flag(var_1)) {
      break;
    }

    if(isDefined(level.player.binoculars_active) && level.player.binoculars_active) {
      continue;
    }
    thread maps\cornered_code::char_dialog_add_and_go(var_8);
    var_5 = var_7;
    var_2 = var_2 + var_4;
    var_3 = var_3 + var_4;
  }
}

zipline_allies_vo() {
  if(!isDefined(level.zipline_startpoint)) {
    if(!maps\cornered_code::is_e3()) {
      wait 1.5;

      if(isDefined(level.player.binoculars_active) && level.player.binoculars_active) {
        level.player waittill("stop_using_binoculars");
      }

      wait 0.5;
    }

    common_scripts\utility::flag_wait("rorke_ready_to_setup_zipline");
  }

  if(!common_scripts\utility::flag("zipline_launcher_setup")) {
    level.allies[level.const_rorke] maps\cornered_code::char_dialog_add_and_go("cornered_mrk_setupyourlaunchers");
    var_0 = maps\_utility::make_array("cornered_mrk_setupyourlaunchers", "cornered_mrk_adamgetyourzipline");
    level.allies[level.const_rorke] thread ally_zipline_nag(var_0, "zipline_launcher_setup", 10, 15, 5);
  }

  common_scripts\utility::flag_wait("zipline_launcher_setup");
  wait 7;
  level.allies[level.const_rorke] maps\cornered_code::char_dialog_add_and_go("cornered_mrk_firethelineadam");
  common_scripts\utility::flag_wait("player_fired_zipline");
  thread maps\cornered_audio::aud_zipline("intro_hookup_hesh");
  wait 5;
  level.allies[level.const_rorke] maps\cornered_code::char_dialog_add_and_go("cornered_rke_everyonehook");
  thread maps\cornered_audio::aud_zipline("intro_hookup_merrick");
  wait 3.0;
  var_0 = maps\_utility::make_array("cornered_mrk_linessetwereclear", "cornered_mrk_letsgohookup");
  level.allies[level.const_rorke] thread ally_zipline_nag(var_0, "player_is_starting_zipline", 10, 15, 5);
}

zipline_allies_anims() {
  level.zipline_launcher_baker_count = 0;
  level.allies[level.const_baker].animname = "baker";
  level.allies[level.const_baker] thread zipline_baker_anims();
  level.zipline_launcher_rorke_count = 0;
  level.allies[level.const_rorke].animname = "rorke";
  level.allies[level.const_rorke] thread zipline_rorke_anims();
}

zipline_rorke_anims() {
  if(!isDefined(level.zipline_startpoint)) {
    if(isDefined(level.player.binoculars_active) && level.player.binoculars_active) {
      level.player waittill("stop_using_binoculars");
    }

    common_scripts\utility::flag_wait("rorke_ready_to_setup_zipline");
    waittillframeend;
    level.intro_struct notify("stop_rorke_intro_loop");
  }

  var_0 = [];
  var_0[0] = self;
  var_0[1] = level.zipline_launcher_rorke;
  zipline_launcher_setup_anims("zipline_launcher_setup_rorke");

  if(common_scripts\utility::flag("player_setting_turret")) {
    self stopanimscripted();
    level.zipline_launcher_rorke_count++;

    while(level.zipline_launcher_rorke_count < 2) {
      wait 0.05;
    }

    level.zipline_launcher_rorke_count = 0;
  }

  zipline_launcher_aim_anims(var_0);
  common_scripts\utility::flag_wait("player_fired_zipline");
  level.zipline_anim_struct notify("stop_launcher_loop_rorke");
  zipline_launcher_fire_anims(var_0);

  if(common_scripts\utility::flag("player_is_starting_zipline")) {
    foreach(var_2 in var_0) {
    var_2 stopanimscripted();
    }

    if(isDefined(level.zipline_trolley_rorke.is_out)) {} else
      level.zipline_trolley_rorke show();
  }

  var_0[1] = level.zipline_trolley_rorke;
  var_0[2] = level.zipline_rope_rorke;
  var_0[3] = level.detach_rope_rorke;
  zipline_wait_anims(var_0);
  common_scripts\utility::flag_wait("player_is_starting_zipline");
  level.zipline_anim_struct notify("stop_zipline_wait_loop_rorke");
  level.zipline_anim_struct notify("stop_cornered_zipline_rorkeline_at_rest_loop");
  thread maps\cornered_code::head_swap("head_keegan_cornered_xx");
  self.zipline = 1;
  zipline_anims(var_0);
  self.zipline = 0;
}

zipline_rope_swap_ally(var_0) {
  if(var_0.animname == "rorke") {
    level.detach_rope_rorke delete();
  }
  else {
    level.detach_rope_baker delete();
  }

  var_0 maps\cornered_code_rappel_allies::ally_rappel_start_rope("stealth");
}

setup_launcher_rorke(var_0) {
  thread maps\cornered_audio::aud_zipline("unfold3", (-29040, -4710, 27232));
  level.zipline_launcher_rorke zipline_launcher_setup_anims("zipline_launcher_setup_rorke");

  if(common_scripts\utility::flag("player_setting_turret")) {
    level.zipline_launcher_rorke stopanimscripted();
    level.zipline_launcher_rorke_count++;
  }
}

zipline_baker_anims() {
  if(!isDefined(level.zipline_startpoint)) {
    if(isDefined(level.player.binoculars_active) && level.player.binoculars_active) {
      if(!maps\cornered_code::is_e3()) {
        level.player waittill("stop_using_binoculars");
      }
    }

    common_scripts\utility::flag_wait("baker_ready_to_setup_zipline");
    waittillframeend;
    level.intro_struct notify("stop_baker_intro_loop");
  }

  var_0 = [];
  var_0[0] = self;
  var_0[1] = level.zipline_launcher_baker;
  thread setup_launcher_baker();
  zipline_launcher_setup_anims("zipline_launcher_setup_baker");

  if(common_scripts\utility::flag("player_setting_turret")) {
    self stopanimscripted();
    level.zipline_launcher_baker_count++;

    while(level.zipline_launcher_baker_count < 2) {
      wait 0.05;
    }

    level.zipline_launcher_baker_count = 0;
  }

  zipline_launcher_aim_anims(var_0);
  common_scripts\utility::flag_wait("player_fired_zipline");
  level.zipline_anim_struct notify("stop_launcher_loop_baker");
  zipline_launcher_fire_anims(var_0);

  if(common_scripts\utility::flag("player_is_starting_zipline")) {
    foreach(var_2 in var_0) {
    var_2 stopanimscripted();
    }

    if(isDefined(level.zipline_trolley_baker.is_out)) {} else
      level.zipline_trolley_baker show();
  }

  var_0[1] = level.zipline_trolley_baker;
  var_0[2] = level.zipline_rope_baker;
  var_0[3] = level.detach_rope_baker;
  zipline_wait_anims(var_0);
  common_scripts\utility::flag_wait("player_is_starting_zipline");
  level.zipline_anim_struct notify("stop_zipline_wait_loop_baker");
  level.zipline_anim_struct notify("stop_cornered_zipline_bakerline_at_rest_loop");
  self.zipline = 1;
  zipline_anims(var_0);
  self.zipline = 0;
}

setup_launcher_baker() {
  thread maps\cornered_audio::aud_zipline("unfold2", (-29203, -4622, 27232));
  level.zipline_launcher_baker zipline_launcher_setup_anims("zipline_launcher_setup_baker");

  if(common_scripts\utility::flag("player_setting_turret")) {
    level.zipline_launcher_baker stopanimscripted();
    level.zipline_launcher_baker_count++;
  }
}

front_left_anchor_impact(var_0) {
  if(var_0.targetname == "zipline_launcher_rorke") {
    common_scripts\utility::exploder("launcher_foot_R1");
  }
  else if(var_0.targetname == "zipline_launcher_baker") {
    common_scripts\utility::exploder("launcher_foot_L1");
  }
  else if(var_0.targetname == "zipline_launcher_player") {
    common_scripts\utility::exploder("launcher_foot_C1");
  }
}

front_right_anchor_impact(var_0) {
  if(var_0.targetname == "zipline_launcher_rorke") {
    common_scripts\utility::exploder("launcher_foot_R2");
  }
  else if(var_0.targetname == "zipline_launcher_baker") {
    common_scripts\utility::exploder("launcher_foot_L2");
  }
  else if(self.targetname == "zipline_launcher_player") {
    common_scripts\utility::exploder("launcher_foot_C2");
  }
}

rear_left_anchor_impact(var_0) {
  if(var_0.targetname == "zipline_launcher_rorke") {
    common_scripts\utility::exploder("launcher_foot_R3");
  }
  else if(var_0.targetname == "zipline_launcher_baker") {
    common_scripts\utility::exploder("launcher_foot_L3");
  }
  else if(self.targetname == "zipline_launcher_player") {
    common_scripts\utility::exploder("launcher_foot_C3");
  }
}

rear_right_anchor_impact(var_0) {
  if(var_0.targetname == "zipline_launcher_rorke") {
    common_scripts\utility::exploder("launcher_foot_R4");
  }
  else if(var_0.targetname == "zipline_launcher_baker") {
    common_scripts\utility::exploder("launcher_foot_L4");
  }
  else if(var_0.targetname == "zipline_launcher_player") {
    common_scripts\utility::exploder("launcher_foot_C4");
  }
}

anchor_line_impact(var_0) {
  if(var_0.targetname == "zipline_launcher_rorke") {
    common_scripts\utility::exploder("launcher_anchor_R");
  }
  else if(var_0.targetname == "zipline_launcher_baker") {
    common_scripts\utility::exploder("launcher_anchor_L");
  }
  else if(var_0.targetname == "zipline_launcher_player") {
    common_scripts\utility::exploder("launcher_anchor_C");
  }
}

zipline_launcher_setup_anims(var_0) {
  level endon("player_setting_turret");
  level.zipline_anim_struct maps\_anim::anim_single_solo(self, var_0);
}

zipline_launcher_aim_anims(var_0) {
  level.zipline_anim_struct thread maps\_anim::anim_loop(var_0, "zipline_launcher_aim_loop_" + self.animname, "stop_launcher_loop_" + self.animname);
}

zipline_launcher_fire_anims(var_0, var_1) {
  level endon("player_is_starting_zipline");

  if(isDefined(var_0)) {
    if(self.animname == "rorke") {
      level.zipline_anim_struct thread maps\_anim::anim_single_solo(var_0[1], "zipline_launcher_fire_" + self.animname);
      level.zipline_anim_struct maps\_anim::anim_single_solo(var_0[0], "zipline_launcher_fire_" + self.animname);
    } else {
      level.zipline_anim_struct thread maps\_anim::anim_single_solo(var_0[1], "zipline_launcher_fire_" + self.animname);
      level.zipline_anim_struct thread maps\_anim::anim_single_solo(var_0[0], "zipline_launcher_fire_" + self.animname);
      wait 0.1;
      maps\_anim::anim_self_set_time("zipline_launcher_fire_" + self.animname, 0.3);
      self waittillmatch("single anim", "end");
    }
  } else
    level.zipline_anim_struct maps\_anim::anim_single_solo(self, var_1);
}

zipline_wait_anims(var_0) {
  level.zipline_anim_struct thread maps\_anim::anim_loop(var_0, "zipline_wait_loop_" + self.animname, "stop_zipline_wait_loop_" + self.animname);
}

zipline_anims(var_0) {
  level.zipline_anim_struct thread maps\_anim::anim_single_solo(var_0[1], "zipline_" + self.animname);
  level.zipline_anim_struct thread maps\_anim::anim_first_frame_solo(var_0[2], "zipline_" + self.animname);
  level.zipline_anim_struct thread maps\_anim::anim_single_solo(var_0[2], "zipline_" + self.animname);
  level.zipline_anim_struct thread maps\_anim::anim_single_solo(var_0[3], "zipline_" + self.animname);
  level.zipline_anim_struct maps\_anim::anim_single_solo(var_0[0], "zipline_" + self.animname);
}

spawn_trolley_ally(var_0) {
  if(var_0.animname == "rorke") {
    level.zipline_trolley_rorke.is_out = 1;
    level.zipline_trolley_rorke show();

    if(!common_scripts\utility::flag("player_is_starting_zipline")) {
      level.zipline_trolley_rorke zipline_launcher_fire_anims(undefined, "zipline_trolley_fire_rorke");
    }
  } else {
    level.zipline_trolley_baker.is_out = 1;
    level.zipline_trolley_baker show();

    if(!common_scripts\utility::flag("player_is_starting_zipline")) {
      level.zipline_trolley_baker zipline_launcher_fire_anims(undefined, "zipline_trolley_fire_baker");
    }
  }
}

delete_trolley_ally(var_0) {
  if(var_0.animname == "rorke") {
    level.zipline_trolley_rorke delete();
  }
  else {
    level.zipline_trolley_baker delete();
  }
}

detach_rope_ally(var_0) {
  if(var_0.animname == "rorke") {
    level.detach_rope_rorke show();
  }
  else {
    level.detach_rope_baker show();
  }
}

zipline_player_anims() {
  common_scripts\utility::flag_wait("player_can_use_zipline");
  level.zipline_trolley_obj show();
  level.zipline_trolley_obj maps\_utility::glow();
  var_0 = getent("zipline_trigger", "targetname");

  if(!maps\cornered_code::is_e3()) {
    if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
      var_0 sethintstring(&"CORNERED_START_ZIPLINE_CONSOLE");
    }
    else {
      var_0 sethintstring(&"CORNERED_START_ZIPLINE");
    }
  }

  var_1 = common_scripts\utility::getstruct("zipline_lookat", "targetname");
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_0, var_1, cos(40), 0, 1);
  level.zipline_trolley_obj maps\_utility::stopglow();
  level.zipline_trolley_obj delete();
  thread maps\cornered_audio::aud_zipline("start");

  if(level.player getstance() != "stand") {
    level.player setstance("stand");
  }

  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player common_scripts\utility::_disableweaponswitch();
  level.player common_scripts\utility::_disableweapon();
  level.zipline_gunup_count = 1;
  level.constrict_view_count = 1;
  level.release_view_count = 1;

  if(isDefined(level.player.binoculars_active) && level.player.binoculars_active) {
    level.player notify("use_binoculars");
  }

  level.zipline_anim_struct thread maps\_anim::anim_first_frame(level.arms_and_legs, "cornered_zipline_player");
  level.player playerlinktoblend(level.cornered_player_arms, "tag_player", 0.5);
  wait 0.5;
  maps\cornered_code::show_player_arms();
  level.cornered_player_legs show();
  level.cornered_player_arms maps\cornered_code::player_flap_sleeves();
  common_scripts\utility::flag_set("player_is_starting_zipline");
  level notify("player_is_starting_zipline");
  level.zipline_anim_struct thread maps\_anim::anim_single(level.arms_and_legs, "cornered_zipline_player");
  level.zipline_anim_struct thread maps\_anim::anim_single_solo(level.detach_rope_player, "cornered_zipline_player");
  level.player playerlinktodelta(level.cornered_player_arms, "tag_player", 1, 0, 0, 60, 50);
  wait 3.0;
  common_scripts\utility::flag_set("player_is_ziplining");
  var_2 = getent("start_building_fall_volume", "targetname");
  var_2 delete();
  wait 1.0;
  thread maps\cornered_audio::aud_zipline("detach");
  wait 1.5;
  maps\cornered_code::hide_player_arms();
  level.player lerpviewangleclamp(0.5, 0, 0, 70, 70, 60, 50);
  level.player playrumblelooponentity("subtle_tank_rumble");
  level.cornered_player_arms waittillmatch("single anim", "end");
  thread maps\cornered_infil::rappel_stealth();
  level.player common_scripts\utility::_enableweaponswitch();
  maps\cornered_code::hide_player_arms();
  level.cornered_player_legs hide();
  level.cornered_player_arms maps\cornered_code::player_stop_flap_sleeves();
  common_scripts\utility::flag_set("zipline_finished");
}

zipline_gun_up(var_0) {
  if(level.zipline_gunup_count == 2) {
    level.player common_scripts\utility::_enableweapon();
    common_scripts\utility::flag_clear("player_is_ziplining");
  }

  level.zipline_gunup_count++;
}

constrict_view(var_0) {
  level.player lerpviewangleclamp(0.5, 0, 0, 5, 5, 5, 0);

  if(level.constrict_view_count == 1) {
    wait 1;
    thread maps\cornered_code::delete_window_reflectors();
    thread maps\cornered_code::set_emissive_window_brushes_visible(1);
  }

  level.constrict_view_count++;
}

rope_detach(var_0) {
  level.player stoprumble("subtle_tank_rumble");
  maps\cornered_lighting::do_specular_sun_lerp(1);
  common_scripts\utility::flag_set("player_detach");
  level.detach_rope_player show();
  level.player lerpfov(80, 1);
  level.detach_rope_player waittillmatch("single anim", "end");
  level.detach_rope_player delete();
}

gun_down(var_0) {
  maps\cornered_code::show_player_arms();
}

release_view(var_0) {
  if(level.release_view_count == 1) {
    level.player lerpviewangleclamp(0.5, 0, 0, 70, 40, 60, 50);
    level.release_view_count++;
  }
}

glass_impact(var_0) {
  earthquake(0.25, 1, level.player.origin, 800);
  level.player playrumbleonentity("heavy_2s");
  level.zipline_window_player_hit show();
  var_1 = getent("zipline_window_player", "targetname");
  var_1 delete();
  thread maps\cornered_audio::aud_zipline("landing");
  maps\_utility::stop_exploder(67);
  level.player lerpfov(65, 1);
  level.player lerpviewangleclamp(0.5, 0, 0, 0, 0, 0, 0);
  level.player freezecontrols(1);
  wait 0.5;
  level.player playerlinktoabsolute(level.cornered_player_arms, "tag_player");
  wait 0.5;
  level.player freezecontrols(0);
}

zipline_equipment_anims() {
  common_scripts\utility::flag_wait("player_fired_zipline");
  thread maps\cornered::obj_capture_hvt();
  common_scripts\utility::flag_wait("player_is_starting_zipline");
  level.zipline_trolley_player show();
  level.zipline_anim_struct thread maps\_anim::anim_single_solo(level.zipline_trolley_player, "cornered_zipline_trolley_player");
  level.zipline_trolley_player waittillmatch("single anim", "end");
  level.zipline_trolley_player delete();
}

launch_rope_ally(var_0) {
  if(var_0.targetname == "zipline_launcher_rorke") {
    thread maps\cornered_audio::aud_zipline("rope_shot_ally", (-29056, -4719, 27276));
    level.zipline_rope_rorke show();
    playFXOnTag(level._effect["zipline_shot"], var_0, "tag_flash");
    playFXOnTag(level._effect["vfx_zipline_tracer"], level.zipline_rope_rorke, "J_zip_1");
    maps\cornered_code::launch_rope(level.zipline_anim_struct, level.zipline_rope_rorke, "cornered_zipline_rorkeline_launched", "cornered_zipline_rorkeline_at_rest_loop");
  } else {
    thread maps\cornered_audio::aud_zipline("rope_shot_verb", (-29204, -4620, 27276));
    level.zipline_rope_baker show();
    playFXOnTag(level._effect["zipline_shot"], var_0, "tag_flash");
    playFXOnTag(level._effect["vfx_zipline_tracer"], level.zipline_rope_baker, "J_zip_1");
    maps\cornered_code::launch_rope(level.zipline_anim_struct, level.zipline_rope_baker, "cornered_zipline_bakerline_launched", "cornered_zipline_bakerline_at_rest_loop");
  }
}