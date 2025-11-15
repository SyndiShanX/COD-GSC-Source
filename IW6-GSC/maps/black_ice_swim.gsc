/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_swim.gsc
*****************************************************/

start() {
  maps\black_ice_util::player_start("player_start_swim");
  level.player setclienttriggeraudiozone("blackice_camera", 0);
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  thread underwater_sfx();
  thread maps\black_ice_audio::sfx_camera_intro();
  thread swim_godrays();
  maps\_utility::music_play("mus_blackice_intro");
  level.const_expected_num_swim_allies = 2;
  level._allies_swim = maps\black_ice_util::spawn_allies_swim();

  foreach(var_1 in level._allies)
  var_1 hide();
}

main() {
  level.g_friendlynamedist_old = getdvarint("g_friendlyNameDist");
  setsaveddvar("g_friendlyNameDist", 0);
  level.breach_anim_node = common_scripts\utility::getstruct("breach_anim_node", "script_noteworthy");
  level.allies_breach_anim_node = common_scripts\utility::getstruct("vignette_introbreach_allies", "script_noteworthy");
  level.snake_cam_anim_node = common_scripts\utility::getstruct("Intro_Snake", "script_noteworthy");
  ally_setup();
  player_setup();
  enemy_setup();
  props_setup();
  snake_cam_logic();
  thread swim_godrays();
  player_swim_setup();
  enemy_swim_setup();
  thread maps\black_ice_anim::swim_intro_anims();
  swim_detonate_logic();
}

section_post_inits() {
  common_scripts\utility::array_call(getEntArray("opt_hide_swim", "script_noteworthy"), ::hide);
}

swim_check_node_distance() {
  var_0 = 10000;
  var_1 = cos(45);

  while(!common_scripts\utility::flag("flag_swim_player_drop_tank")) {
    var_2 = distancesquared(level.player getEye(), level.breach_pos);

    if(var_2 < var_0) {
      if(maps\_utility::within_fov_2d(level.player getEye(), level.player.angles, level.breach_pos, var_1)) {
        common_scripts\utility::flag_set("flag_swim_player_drop_tank");
        level notify("notify_begin_camp_logic");
      }
    }

    wait(level.timestep);
  }
}

section_flag_inits() {
  common_scripts\utility::flag_init("flag_detonate_fail");
  common_scripts\utility::flag_init("flag_underwater_sfx");
  common_scripts\utility::flag_init("flag_outofwater_sfx");
  common_scripts\utility::flag_init("flag_swim_player_drop_tank");
  common_scripts\utility::flag_init("flag_swim_breach_detonate");
  common_scripts\utility::flag_init("flag_all_enemies_dead");
  common_scripts\utility::flag_init("flag_player_breaching");
  common_scripts\utility::flag_init("flag_player_clear_to_breach");
  common_scripts\utility::flag_init("flag_intro_above_ice");
  common_scripts\utility::flag_init("flag_snake_cam_below_water");
}

section_precache() {
  maps\_utility::add_hint_string("detonate_string", & "BLACK_ICE_SWIM_DETONATE", ::detonate_string_func);
  precacheshader("dogcam_frame_bot");
  precacheshader("dogcam_frame_top");
  precacheshader("dogcam_bracket_l");
  precacheshader("dogcam_bracket_r_nd");
  precacheshader("dogcam_center");
  precacheshader("dogcam_timestamp_no_record");
  precacheshader("scubamask_overlay_delta");
  precacheshader("black");
}

ally_setup() {
  for(var_0 = 0; var_0 < level.const_expected_num_swim_allies; var_0++) {
    level._allies_swim[var_0].animname = "scuba_ally";
    level._allies_swim[var_0] thread maps\_underwater::friendly_bubbles();
    level._allies_swim[var_0] thread maps\black_ice_fx::fx_intro_friendly_glowsticks();
    level._allies_swim[var_0].launcher = maps\_utility::spawn_anim_model("ascend_launcher_non_anim");
    level._allies_swim[var_0].launcher linkto(level._allies_swim[var_0], "TAG_STOWED_BACK", (0, 1, 5), (0, 0, 30));
  }
}

enemy_setup() {
  var_0 = getEntArray("snake_cam_enemy", "script_noteworthy");
  var_1 = maps\_utility::array_spawn(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_3 maps\_utility::set_battlechatter(0);
    var_3.combatmode = "no_cover";
    var_3.ignoreall = 1;
    var_3.ignoreme = 1;
    var_3.newenemyreactiondistsq_old = self.newenemyreactiondistsq;
    var_3.newenemyreactiondistsq = 0;
    var_3.grenadeammo = 0;
    var_3.animname = "snake_cam_enemy";
  }

  level.snake_cam_enemies = var_1;
}

player_setup() {
  level.snake_cam_dummy = getent("snake_terrain_cam", "targetname");
  level.snake_cam_dummy.animname = "snake_cam";
  level.snake_cam_dummy maps\_anim::setanimtree();
  maps\black_ice_util::player_animated_sequence_restrictions();
  level.player playerlinkweaponviewtodelta(level.snake_cam_dummy, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player playerlinkedsetviewznear(0);
  level.player thread snake_cam_hud();
  thread maps\black_ice_fx::snake_cam_fx();
  thread snake_cam_vision_flicker();
  level.player lerpfov(45, level.timestep);
}

snake_cam_hud() {
  maps\black_ice_util::black_ice_hide_hud();
  level.player takeweapon("fraggrenade");
  level.player takeweapon("flash_grenade");
  self.hud_elements = [];
  var_0 = maps\_hud_util::create_client_overlay("nightvision_overlay_goggles", 0.3);
  self.hud_elements[self.hud_elements.size] = var_0;
  var_0 = maps\_hud_util::createclienticon("dogcam_center", 600, 300);
  var_0 maps\_hud_util::setpoint("CENTER", undefined, 0, 0, 0);
  self.hud_elements[self.hud_elements.size] = var_0;
  var_0 = level.player maps\_hud_util::createclienticon("dogcam_frame_top", 600, 40);
  var_0 maps\_hud_util::setpoint("TOP", "TOP", 0, -20, 0);
  self.hud_elements[self.hud_elements.size] = var_0;
  var_0 = level.player maps\_hud_util::createclienticon("dogcam_frame_bot", 600, 80);
  var_0 maps\_hud_util::setpoint("BOTTOM", "BOTTOM", 0, 32, 0);
  self.hud_elements[self.hud_elements.size] = var_0;
  var_0 = level.player maps\_hud_util::createclienticon("dogcam_bracket_r_nd", 60, 400);
  var_0 maps\_hud_util::setpoint("RIGHT", "RIGHT", 0, 0, 0);
  self.hud_elements[self.hud_elements.size] = var_0;
  var_0 = level.player maps\_hud_util::createclienticon("dogcam_bracket_l", 69, 400);
  var_0 maps\_hud_util::setpoint("LEFT", "LEFT", 0, 0, 0);
  self.hud_elements[self.hud_elements.size] = var_0;
  var_0 = level.player maps\_hud_util::createclienticon("dogcam_timestamp_no_record", 200, 25);
  var_0 maps\_hud_util::setpoint("LEFT BOTTOM", "LEFT BOTTOM", 14, -25, 0);
  self.hud_elements[self.hud_elements.size] = var_0;
  var_0 = level.player maps\_hud_util::createclientfontstring("default", 0.8);
  var_0 maps\_hud_util::setpoint("RIGHT BOTTOM", "LEFT BOTTOM", 188.5, -34, 0);
  var_0 settext("00 : 00 00");
  var_0.alpha = 0.4;
  var_0 thread snake_cam_time_countup();
  self.hud_elements[self.hud_elements.size] = var_0;
}

snake_cam_time_countup() {
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
    wait(level.timestep);
  }
}

snake_cam_hud_cleanup() {
  foreach(var_1 in level.player.hud_elements) {
    var_1 destroy();
    var_1 = undefined;
  }

  level.player.hud_elements = undefined;
}

snake_cam_vision_flicker() {
  var_0 = 0.06;
  var_1 = 0;
  level.player maps\_utility::vision_set_fog_changes("black_ice_snakecam", 0);

  while(!common_scripts\utility::flag("flag_snake_cam_below_water")) {
    if(!common_scripts\utility::flag("flag_snake_cam_below_water")) {
      if(var_1) {
        level.player maps\_utility::vision_set_fog_changes("black_ice_snakecam", var_0);
        var_1 = 0;
      } else {
        level.player maps\_utility::vision_set_fog_changes("black_ice_snakecam_dark", var_0);
        var_1 = 1;
      }
    }

    wait(var_0);
  }

  level.player maps\_utility::vision_set_fog_changes("black_ice_infil_dark", 0.2);
}

snake_cam_logic() {
  thread set_snakecam_dof();
  thread black_fade(0, 7, 0.1, 1);
  wait 1;
  thread maps\_utility::smart_radio_dialogue("black_ice_mrk_wereinposition");
  wait 2;
  thread maps\_utility::smart_radio_dialogue("black_ice_hsh_rogeractual");
  wait 3;
  thread maps\_utility::smart_radio_dialogue("black_ice_mrk_eyescomingup");
  wait 1;
  thread snake_cam_dialogue();
  thread swim_intro_dialogue();
  thread maps\black_ice_anim::snake_cam_enemy_anims();
  thread maps\black_ice_anim::swim_props_first_frame_anims();
  thread maps\black_ice_anim::swim_vehicles_snake_cam_anims();
  thread snake_cam_shake_rumble();
  thread snake_cam_input_logic();
  level waittill("notify_underwater_transition");
  snake_cam_transition_to_underwater();
}

snake_cam_dialogue() {
  level waittill("notify_snake_cam_dialogue_line2_1");
  thread maps\_utility::smart_radio_dialogue("black_ice_hsh_lastpatrolisinbound");
  level waittill("notify_snake_cam_dialogue_line2_2");
  maps\_utility::smart_radio_dialogue("black_ice_mrk_copybravo");
  thread maps\_utility::smart_radio_dialogue("black_ice_mrk_isthatallof");
  level waittill("notify_snake_cam_dialogue_line2_3");
  maps\_utility::smart_radio_dialogue("black_ice_hsh_rogeritsafullhouse");
  thread maps\_utility::smart_radio_dialogue("black_ice_hsh_seeyoutopside");
  level waittill("notify_snake_cam_dialogue_line2_4");
  thread maps\_utility::smart_radio_dialogue("black_ice_mrk_adamletsgo");
}

swim_intro_dialogue() {
  level waittill("notify_snake_cam_dialogue_line3_1");
  maps\_utility::smart_radio_dialogue("black_ice_mrk_chargesaresetand");
  thread maps\_utility::smart_radio_dialogue("black_ice_mrk_letsintroduceourselveson");
  level waittill("notify_swim_dialog5_1");
  thread maps\_utility::smart_radio_dialogue("blackice_bkr_markdropthem");
  wait 1;

  if(!common_scripts\utility::flag("flag_swim_breach_detonate"))
    maps\_utility::display_hint("detonate_string");

  wait 3.0;
  var_0 = 2.0;

  if(!common_scripts\utility::flag("flag_swim_breach_detonate"))
    maps\_utility::smart_radio_dialogue("blackice_bkr_dropthemrook");

  wait(var_0);

  if(!common_scripts\utility::flag("flag_swim_breach_detonate"))
    maps\_utility::smart_radio_dialogue("blackice_bkr_setoffcharges");

  wait(var_0);

  if(!common_scripts\utility::flag("flag_swim_breach_detonate"))
    maps\_utility::smart_radio_dialogue("blackice_bkr_windowsclosing");

  wait(var_0);

  if(!common_scripts\utility::flag("flag_swim_breach_detonate"))
    maps\_utility::smart_radio_dialogue("blackice_bkr_theyremoving");

  wait(var_0);

  if(!common_scripts\utility::flag("flag_swim_breach_detonate")) {
    setdvar("ui_deadquote", & "BLACK_ICE_SWIM_DETONATE_FAIL");
    common_scripts\utility::flag_set("flag_detonate_fail");
    maps\_utility::missionfailedwrapper();
  }
}

snake_cam_shake_rumble() {
  level.player_rumble_ent = maps\black_ice_util::get_rumble_ent_linked(level.snake_cam_dummy);
  wait 0.05;
  level.player_rumble_ent.intensity = 0;
  level waittill("notify_rumble_snowmobile_1");
  thread player_rumble_bump(0.08, 0.0, 0.2, 0, 0.5);
  level waittill("notify_rumble_snowmobile_2");
  thread player_rumble_bump(0.13, 0.0, 0.2, 0, 0.5);
  level waittill("notify_rumble_truck_1");
  thread player_rumble_bump(0.18, 0.0, 0.2, 0, 1.15);
  level waittill("notify_rumble_truck_2");
  thread player_rumble_bump(0.6, 0.0, 0.3, 0, 0.75);
  level waittill("notify_rumble_truck_3");
  thread player_rumble_bump(0.6, 0.0, 0.6, 0, 1.25);
  level waittill("notify_rumble_truck_off");
  thread player_rumble_bump(0.0, 0.0, 0.75, 0, 0.01);
  level waittill("notify_rumble_cam_1");
  thread player_rumble_bump(0.22, 0.0, 0.01, 0, 0.3);
  level waittill("notify_rumble_cam_2");
  thread player_rumble_bump(0.21, 0.0, 0.1, 0, 0.4);
  level waittill("notify_rumble_cam_3");
  thread player_rumble_bump(0.18, 0.0, 0.1, 0, 0.55);
  level waittill("notify_rumble_cam_4");
  thread player_rumble_bump(0.21, 0.0, 0.1, 0, 0.75);
  wait 4;
  level.player_rumble_ent delete();
}

player_rumble_bump(var_0, var_1, var_2, var_3, var_4) {
  level notify("notify_new_rumble_bump");
  level endon("notify_new_rumble_bump");
  level.player_rumble_ent maps\_utility::rumble_ramp_to(var_0, var_2);
  wait(var_2 + var_3);
  level.player_rumble_ent maps\_utility::rumble_ramp_to(var_1, var_4);
}

snake_cam_noise(var_0) {
  level endon("notify_underwater_transition");
  level notify("snake_cam_noise");
  var_1 = level.snake_cam_dummy.noise_amplitude;
  var_2 = 0.1;
  var_3 = 150;
  var_4 = gettime();

  while(gettime() - var_4 < var_3) {
    var_5 = (randomfloatrange(-1 * var_1, var_1), randomfloatrange(-1 * var_1, var_1), randomfloatrange(-1 * var_1, var_1));
    level.snake_cam_dummy.angles = level.snake_cam_dummy.angles + var_5;
    wait(var_2);
  }

  thread snake_cam_noise_falloff(var_1);
}

snake_cam_noise_falloff(var_0) {
  level endon("notify_underwater_transition");
  level endon("snake_cam_noise");
  var_1 = level.snake_cam_dummy.noise_min_amplitude;
  var_2 = 0.1;
  var_3 = 100;
  var_4 = 0.75;

  for(;;) {
    var_5 = gettime();

    while(gettime() - var_5 < var_3) {
      var_6 = (randomfloatrange(-1 * var_0, var_0), randomfloatrange(-1 * var_0, var_0), randomfloatrange(-1 * var_0, var_0));
      level.snake_cam_dummy.angles = level.snake_cam_dummy.angles + var_6;
      wait(var_2);
    }

    var_0 = var_0 * var_4;

    if(var_0 < var_1)
      var_0 = var_1;
  }
}

snake_cam_input_logic() {
  level endon("notify_underwater_transition");
  var_0 = 0;
  var_1 = level.snake_cam_dummy.angles;
  var_2 = 45;
  var_3 = var_1[1] - var_2;
  var_4 = var_1[1] + var_2;
  var_5 = 12;
  var_6 = var_1[0] - var_5;
  var_7 = var_1[0] + var_5 / 2;
  var_8 = var_1[1];
  var_9 = var_1[1];
  var_10 = var_1[0];
  var_11 = var_1[0];
  var_12 = 0.075;
  var_13 = var_12 * (var_2 / var_5);
  var_14 = 0;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 1000;
  var_19 = undefined;
  var_20 = 0.6;
  var_21 = 0.48;
  level.snake_cam_dummy.noise_min_amplitude = 0.09;
  level.snake_cam_dummy.noise_amplitude = level.snake_cam_dummy.noise_min_amplitude;
  thread snake_cam_noise(level.snake_cam_dummy.angles);

  if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
    level.player enablemousesteer(1);

  for(;;) {
    var_22 = level.player getnormalizedcameramovement();

    if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
      var_22 = (var_22[0], var_22[1] * -1, var_22[2]);

    if(var_22[1] || var_22[0]) {
      var_14 = common_scripts\utility::ter_op(var_22[1] > 0, 1, -1);
      var_16 = common_scripts\utility::ter_op(var_22[0] > 0, 1, -1);

      if(!var_0 || var_14 != var_15 || var_16 != var_17) {
        if(!isDefined(var_19) || gettime() - var_19 > var_18) {
          var_19 = gettime();
          level.snake_cam_dummy.noise_amplitude = var_20;
        } else
          level.snake_cam_dummy.noise_amplitude = var_21;

        var_0 = 1;
        thread snake_cam_noise(level.snake_cam_dummy.angles);
        thread maps\black_ice_audio::sfx_camera_mvmt();
      }

      var_9 = common_scripts\utility::ter_op(var_22[1] > 0, var_3, var_4);
      var_11 = common_scripts\utility::ter_op(var_22[0] > 0, var_6, var_7);
      var_8 = var_8 + (var_9 - var_8) * var_12 * abs(var_22[1]);
      var_10 = var_10 + (var_11 - var_10) * var_13 * abs(var_22[0]);
      level.snake_cam_dummy.angles = (var_10, var_8, var_1[2]);
      var_15 = var_14;
      var_17 = var_16;
    } else {
      var_15 = 0;
      var_17 = 0;
      var_0 = 0;
    }

    wait(level.timestep);
  }
}

snake_cam_transition_to_underwater() {
  var_0 = 0.5;
  var_1 = 0;
  var_2 = 1.0;
  thread black_fade(var_0, var_1, var_2);
  wait(var_0);
  thread snake_cam_hud_cleanup();
  level.player visionsetnakedforplayer("", 0);
  level.player lerpfov(60, level.timestep);
  level.player unlink();
  thread borescope_pip();
  level notify("snake_cam_transition_to_underwater_complete");
}

black_fade(var_0, var_1, var_2, var_3) {
  var_4 = maps\_hud_util::create_client_overlay("black", 0, level.player);

  if(var_0 > 0)
    var_4 fadeovertime(var_0);

  var_4.alpha = 1;

  if(isDefined(var_3))
    var_4.foreground = 0;

  wait(var_0);
  wait(var_1);
  level notify("notify_snakecam_on");

  if(var_2 > 0)
    var_4 fadeovertime(var_2);

  var_4.alpha = 0;
  wait(var_2);
  var_4 destroy();
}

borescope_pip() {
  level.pip = level.player newpip();
  level.pip.rendertotexture = 1;
  level.pip.entity = spawn("script_model", level.borescope gettagorigin("tag_camera"));
  level.pip.entity setModel("tag_origin");
  level.pip.entity.origin = level.borescope gettagorigin("tag_camera");
  level.pip.entity.angles = level.borescope gettagangles("tag_camera");
  level.pip.visionsetnaked = "black_ice_snakecam";
  level.pip.entity linkto(level.borescope, "tag_camera", (0, 0, 5), (0, 0, 0));
  wait(level.timestep);
  level.pip.tag = "tag_origin";
  level.pip.fov = 45;
  level.pip.freecamera = 1;
  level.pip.enableshadows = 0;
  level.pip.x = 300;
  level.pip.y = 240;
  level.pip.width = 240;
  level.pip.height = 135;
  level.pip.enable = 1;
  level.borescope waittill("death");
  level.pip.enable = 0;
  level.pip.entity delete();
  level.pip = undefined;
}

player_swim_setup() {
  level.spring_cam_max_clamp = 30;
  level.spring_cam_min_clamp = 20;
  level.breach_pt = common_scripts\utility::getstruct("breach_point", "script_noteworthy");
  level.breach_pos = level.breach_pt.origin + (0, 0, 0);
  maps\black_ice_util::setup_player_for_animated_sequence(0, undefined, undefined, level.player.angles, 0);
  var_0 = maps\_utility::spawn_anim_model("player_scuba", level.player_rig.origin);
  level.player_scuba = var_0;
  level.player allowswim(1);
  level.player enableslowaim(0.5, 0.5);
  setsaveddvar("player_swimSpeed", 0.0);
  setsaveddvar("player_swimVerticalSpeed", 0.0);
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player.hud_scubamask = level.player maps\_hud_util::create_client_overlay("scubamask_overlay_delta", 1, level.player);
  level.player.hud_scubamask.foreground = 0;
  level.player.hud_scubamask.sort = -99;
  level.player.hud_scubamask.enablehudlighting = 1;
  level.player thread maps\_underwater::player_scuba();
  level.player maps\_underwater::underwater_hud_enable(1);
  init_swim_vars();
  init_swim();
  thread player_weapon_hack();
  maps\black_ice_util::player_animated_sequence_restrictions();
  wait(level.timestep);
  level.player lerpviewangleclamp(0, 0, 0, level.spring_cam_min_clamp, level.spring_cam_min_clamp, level.spring_cam_min_clamp, level.spring_cam_min_clamp);
}

player_weapon_hack() {
  level.player giveweapon("test_detonator_black_ice");
  level.player setweaponammoclip("test_detonator_black_ice", 0);
  level.player giveweapon("aps_underwater+swim");
  level.player switchtoweapon("aps_underwater+swim");
  wait 1.3;
  level.player switchtoweapon("test_detonator_black_ice");
}

player_swim_rubberband() {
  level endon("notify_swim_end");
  var_0 = 80.0;
  var_1 = 40.0;
  var_2 = 130000.0;
  var_3 = 35000.0;
  var_4 = 500000.0;
  var_5 = 0.0;
  var_6 = 0.0;
  var_7 = 0.0;

  for(;;) {
    if(isDefined(level._allies_swim[0].origin)) {
      var_6 = distancesquared(level._allies_swim[0].origin, level.breach_pos);
      var_7 = distancesquared(level.player getEye(), level.breach_pos);
      var_5 = var_7 - var_6;

      if(var_5 > var_4) {
        setdvar("ui_deadquote", & "BLACK_ICE_SWIM_FAIL_DISTANCE");
        maps\_utility::missionfailedwrapper();
      }
    }

    var_8 = maps\black_ice_util::normalize_value(var_3, var_2, var_5);
    var_9 = maps\black_ice_util::factor_value_min_max(var_1, var_0, var_8);
    level.player.target_swim_speed = var_9;
    wait(level.timestep);
  }
}

player_swim_water_current_logic() {
  level endon("notify_swim_end");
  var_0 = [];
  var_0[0] = [-200.0, 4400];
  var_0[1] = [-150.0, 3200];
  var_0[2] = [-100.0, 2000];

  for(;;) {
    if(level.player.origin[2] < var_0[0][0]) {
      level.player.target_water_current = (0, 0, 1) * var_0[0][1];
      level.player.water_current_delta = 0.2;
    } else if(level.player.origin[2] < var_0[1][0]) {
      level.player.target_water_current = (0, 0, 1) * var_0[1][1];
      level.player.water_current_delta = 0.2;
    } else if(level.player.origin[2] < var_0[2][0]) {
      level.player.target_water_current = (0, 0, 1) * var_0[2][1];
      level.player.water_current_delta = 0.2;
    } else {
      level.player.target_water_current = (0, 0, 0);
      level.player.water_current_delta = 0.1;
    }

    wait(level.timestep);
  }
}

init_swim_vars() {
  level.player.target_swim_speed = 0.0;
  level.player.swim_speed_delta = 0.03;
  level.player.target_water_current = (0, 0, 0);
  level.player.water_current_delta = 0.1;
}

init_swim() {
  common_scripts\utility::flag_set("flag_underwater_sfx");
  maps\_utility::vision_set_fog_changes("black_ice_infil", 0);
  setsaveddvar("r_snowAmbientColor", (0.035, 0.04, 0.04));
  thread infil_lights_and_vision();
  common_scripts\utility::exploder("underwater_amb");
  level.player.hint_active = 0;
  thread swim_check_node_distance();
}

player_lerp_swim_vars() {
  level endon("notify_swim_end");
  var_0 = self.target_swim_speed;
  var_1 = self.target_water_current;

  for(;;) {
    var_0 = var_0 + (self.target_swim_speed - var_0) * self.swim_speed_delta;
    setsaveddvar("player_swimSpeed", var_0);
    var_1 = var_1 + (self.target_water_current - var_1) * self.water_current_delta;
    setsaveddvar("player_swimWaterCurrent", var_1);
    wait(level.timestep);
  }
}

enemy_swim_setup() {
  level.ice_breach_enemies = [];
  var_0 = getEntArray("ice_breach_enemy", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = var_2 dospawn();
    var_3.swimmer = 1;
    var_3.noragdoll = 1;
    var_3.deathfunction = maps\black_ice_anim::swim_enemy_death_anim_override;
    var_3 maps\_utility::set_battlechatter(0);
    var_3.combatmode = "no_cover";
    var_3.ignoreall = 1;
    var_3.ignoreme = 1;
    var_3.nodrop = 1;
    var_3.disablearrivals = 1;
    var_3.newenemyreactiondistsq_old = self.newenemyreactiondistsq;
    var_3.newenemyreactiondistsq = 0;
    var_3.grenadeammo = 0;
    var_3 allowedstances("stand", "crouch");
    var_3 hidepart_allinstances("tag_weapon");
    var_3 hidepart_allinstances("tag_clip");
    var_3 maps\_utility::disable_pain();
    var_3 thread maps\_utility::magic_bullet_shield();
    var_3.animname = "ice_breach_enemy";
    level.ice_breach_enemies[level.ice_breach_enemies.size] = var_3;
  }

  thread maps\_swim_ai_common::override_water_footsteps();
  maps\black_ice_anim::swim_enemies_first_frame_anims();
}

props_setup() {
  level.breach_props = [];
  create_persistent_ice_breach_props();
  level.breach_vehicles["gaz71"] = maps\_utility::spawn_anim_model("gaz71");
  level.breach_vehicles["gaztiger"] = maps\_utility::spawn_anim_model("gaztiger");
  level.breach_vehicles["bm21_2"] = maps\_utility::spawn_anim_model("bm21_2");
  level.vehicles_no_breach["bm21_3"] = maps\_utility::spawn_anim_model("bm21_3");
  level.vehicles_no_breach["gaztiger_2"] = maps\_utility::spawn_anim_model("gaztiger_2");
  level.vehicles_no_breach["snowmobile_1"] = maps\_utility::spawn_anim_model("snowmobile_1");
  level.vehicles_no_breach["snowmobile_2"] = maps\_utility::spawn_anim_model("snowmobile_2");
  thread maps\black_ice_fx::intro_turn_on_vehicle_drive_in_treadfx();
  level.breach_mines = getEntArray("limpet_mine", "targetname");
  level.borescope = maps\_utility::spawn_anim_model("borescope");
  thread mine_blink_fx();
  level.breach_props["ice_chunks1"] hide();
  level.breach_props["ice_chunks2"] hide();
  level.breach_props["breach_water"] hide();
}

prop_attach_coll() {
  var_0 = getent(self.coll, "targetname");

  if(isDefined(var_0)) {
    var_1 = (0, 0, 0);

    switch (self.model) {
      case "ch_crate64x64":
        var_1 = (0, 0, 36);
        break;
      case "com_ammo_pallet":
        var_1 = (0, 0, 28);
        break;
      case "oil_barrel":
        var_1 = (0, 0, 22);
        break;
      case "bi_basecamp_tire":
        break;
      case "com_plasticcase_green_big_idf_iw6":
        var_1 = (0, 0, 16);
        break;
      case "com_pallet_2_snow":
        var_1 = (0, 0, 4);
        break;
    }

    var_0.origin = self.origin + var_1;
    var_0.angles = self.angles;
    var_0 linkto(self);
  }
}

create_persistent_ice_breach_props(var_0) {
  if(!isDefined(level.breach_props))
    level.breach_props = [];

  if(!isDefined(level.tag_anim_rig_models))
    level.tag_anim_rig_models = [];

  var_1 = maps\black_ice_util::setup_tag_anim_rig("introbreach_props", "introbreach_props", 4, 1);

  for(var_2 = 0; var_2 < level.tag_anim_rig_models.size; var_2++) {
    if(isDefined(level.tag_anim_rig_models[var_2].coll))
      level.tag_anim_rig_models[var_2] prop_attach_coll();
  }

  level.breach_props["introbreach_props"] = var_1;
  level.breach_props["ice_chunks1"] = getent("ice_chunks1", "targetname");
  level.breach_props["ice_chunks1"].animname = "ice_chunks1";
  level.breach_props["ice_chunks1"] maps\_utility::assign_animtree();
  level.breach_props["ice_chunks2"] = getent("ice_chunks2", "targetname");
  level.breach_props["ice_chunks2"].animname = "ice_chunks2";
  level.breach_props["ice_chunks2"] maps\_utility::assign_animtree();
  level.breach_props["breach_water"] = maps\_utility::spawn_anim_model("breach_water");
  level.breach_props["breach_water"] thread retarget_breach_water();
  level.breach_vehicles = [];
  level.breach_vehicles["bm21_1"] = maps\_utility::spawn_anim_model("bm21_1");

  if(isDefined(var_0) && var_0) {
    level.breach_anim_node thread maps\_anim::anim_loop_solo(level.breach_props["ice_chunks1"], "intro_breach_loop", "stop_loop");
    level.breach_anim_node maps\_anim::anim_last_frame_solo(level.breach_props["introbreach_props"], "intro_breach");
    level.breach_anim_node maps\_anim::anim_last_frame_solo(level.breach_props["breach_water"], "intro_breach");
    level.breach_anim_node maps\_anim::anim_last_frame_solo(level.breach_vehicles["bm21_1"], "intro_breach");
  }
}

mine_blink_fx() {
  foreach(var_1 in level.breach_mines) {
    wait(level.timestep);
    playFXOnTag(common_scripts\utility::getfx("mine_light"), var_1, "tag_fx");
    wait 0.1;
  }
}

destroy_breach_mines_and_fx() {
  foreach(var_1 in level.breach_mines) {
    wait(level.timestep);
    stopFXOnTag(common_scripts\utility::getfx("mine_light"), var_1, "tag_fx");
    var_1 delete();
  }
}

swim_detonate_logic() {
  level waittill("notify_pullout_detonator");
  level.player enableweapons();
  level.player switchtoweapon("test_detonator_black_ice");
  level.player allowfire(0);
  wait 2.0;
  swim_wait_for_detonate();
  thread swim_player_start_breach();
  wait 0.5;
  thread swim_breach_dialog();
  ice_breach_logic();
}

swim_breach_dialog() {
  wait 0.2;
  maps\_utility::radio_dialogue_stop();

  if(common_scripts\utility::flag("flag_player_clear_to_breach")) {
    wait 0.4;
    thread maps\_utility::smart_radio_dialogue("blackice_bkr_takeemout");
  } else {
    wait 0.1;
    thread maps\_utility::smart_radio_dialogue("blackice_bkr_toosoon");
  }
}

swim_player_start_breach() {
  var_0 = weaponfiretime("test_detonator_black_ice");
  wait(var_0);
  level.player switchtoweapon("aps_underwater+swim");
  setsaveddvar("player_swimCombatTimer", 5000);
  setsaveddvar("g_friendlyNameDist", level.g_friendlynamedist_old);
  level.g_friendlynamedist_old = undefined;
  wait 1.4;
  level.player takeweapon("test_detonator_black_ice");

  if(isDefined(level.black_ice_hud_ammocounterhide))
    setsaveddvar("ammoCounterHide", level.black_ice_hud_ammocounterhide);

  level.player allowfire(1);
}

swim_surface_dialog() {
  thread maps\_utility::smart_radio_dialogue("blackice_bkr_wereclear");
  wait 2.0;
  level waittill("notify_swim_dialog7_1");
  thread maps\_utility::smart_radio_dialogue("black_ice_mrk_dropyourtanksand");
  wait 5.0;

  if(!common_scripts\utility::flag("flag_swim_player_drop_tank"))
    thread maps\_utility::smart_radio_dialogue("black_ice_mrk_doubletimeit");

  wait 2.5;

  if(!common_scripts\utility::flag("flag_swim_player_drop_tank"))
    thread maps\_utility::smart_radio_dialogue("black_ice_hsh_takingfire");

  wait 3.5;

  if(!common_scripts\utility::flag("flag_swim_player_drop_tank"))
    thread maps\_utility::smart_radio_dialogue("black_ice_hsh_getuphere");

  wait 5;

  if(!common_scripts\utility::flag("flag_swim_player_drop_tank"))
    thread maps\_utility::smart_radio_dialogue("black_ice_hsh_whereareyoualpha");

  wait 6;
  var_0 = [ & "BLACK_ICE_HESH_KILLED", & "BLACK_ICE_KEEGAN_KILLED"];

  if(!common_scripts\utility::flag("flag_swim_player_drop_tank")) {
    setdvar("ui_deadquote", var_0[randomint(var_0.size - 1)]);
    maps\_utility::missionfailedwrapper();
  }
}

swim_wait_for_detonate() {
  level.player allowfire(1);

  while(!level.player attackbuttonpressed())
    wait(level.timestep);

  level.player allowfire(0);
  thread maps\black_ice_audio::sfx_breach_detonate();
  common_scripts\utility::flag_set("flag_swim_breach_detonate");
}

detonate_string_func() {
  return common_scripts\utility::ter_op(level.player attackbuttonpressed() || common_scripts\utility::flag("flag_detonate_fail"), 1, 0);
}

ice_breach_logic() {
  thread maps\black_ice_fx::intro_detonation_sequence_fx();
  earthquake(0.6, 1.5, level.player.origin, 100);
  level.player shellshock("default_nosound", 1.5);
  wait 0.75;
  handle_ice_plugs();
  thread destroy_breach_mines_and_fx();
  level.breach_props["ice_chunks1"] show();
  level.breach_props["breach_water"] show();
  level.breach_props["introbreach_props"] thread ice_breach_process_prop_fx();
  thread maps\black_ice_anim::swim_breach_anims();
  thread props_cleanup();

  for(var_0 = 0; var_0 < level.ice_breach_enemies.size; var_0++) {
    level.ice_breach_enemies[var_0] thread ice_breach_process_enemy(var_0);
    wait(level.timestep);
    level.ice_breach_enemies[var_0] thread ice_breach_process_enemy_fx();
  }

  wait_till_breach_end_conditions();
  maps\_utility::autosave_by_name("swim_forward");
  thread maps\black_ice_anim::swim_allies_swim_forward();
  thread player_surface_logic();
  thread swim_surface_dialog();
  thread scuba_ally_swap();
  level waittill("notify_begin_camp_logic");
}

handle_ice_plugs() {
  var_0 = getEntArray("ice_plug", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 delete();
  }

  common_scripts\utility::array_call(getEntArray("opt_hide_swim", "script_noteworthy"), ::show);
  level notify("icehole_open");
}

ice_breach_process_prop_fx() {
  wait 1.0;
  var_0 = self.model;
  var_1 = getnumparts(var_0);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = getpartname(var_0, var_2);

    switch (var_3) {
      case "tag_origin_new_props":
        break;
      case "mdl_ch_crate64x64_snow_001":
        break;
      default:
        wait(level.timestep);
        playFXOnTag(level._effect["water_bubble_cloud_descent_med"], self, var_3);
        break;
    }
  }
}

ice_breach_process_enemy_fx() {
  wait 0.25;
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], self, "j_mainroot");
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], self, "J_Ankle_ri");
  playFXOnTag(level._effect["water_bubble_cloud_descent_med"], self, "J_Ankle_LE");
}

infil_lights_and_vision() {
  common_scripts\utility::flag_wait("flag_swim_breach_detonate");

  if(maps\_utility::is_gen4() && !level.ps4)
    setsaveddvar("r_mbEnable", 2);

  wait 1;
  maps\_utility::vision_set_fog_changes("black_ice_infil_bright", 1.3);
  var_0 = getEntArray("light_infil_script_top", "targetname");

  foreach(var_2 in var_0)
  thread light_brighten(var_2, 0.7);

  var_4 = getEntArray("light_infil_script_top2", "targetname");

  foreach(var_2 in var_4)
  thread light_brighten(var_2, 0.4);

  level waittill("notify_icehole_godrays");
  common_scripts\utility::exploder("intro_icehole_godray");
  level waittill("player_water_breach");
  maps\_utility::stop_exploder("intro_icehole_godray");
}

light_brighten(var_0, var_1) {
  var_2 = var_0 getlightintensity();
  var_3 = var_1;
  var_4 = 0.12;

  while(var_2 < var_3) {
    var_2 = var_2 + var_4;
    var_0 setlightintensity(var_2);
    wait(level.timestep);
  }
}

player_surface_logic() {
  level waittill("notify_swim_allow_movement");
  level.player.target_swim_speed = 40;
  setsaveddvar("player_swimVerticalSpeed", 40.0);
  level.player thread player_lerp_swim_vars();
  thread player_swim_rubberband();
  thread player_swim_water_current_logic();
  thread maps\black_ice_anim::swim_truck_surface_anim();

  while(!common_scripts\utility::flag("flag_swim_player_drop_tank"))
    wait(level.timestep);

  common_scripts\utility::flag_set("flag_player_breaching");

  if(!isDefined(level._bravo) || level._bravo.size < 2)
    maps\black_ice_util::spawn_bravo();

  surface_breach();
  common_scripts\utility::flag_clear("flag_underwater_sfx");
  common_scripts\utility::flag_set("flag_outofwater_sfx");
  thread player_post_swim();

  if(isDefined(level.breach_anim_node))
    level.breach_anim_node notify("stop_loop");

  if(isDefined(level.allies_breach_anim_node))
    level.allies_breach_anim_node notify("stop_loop");
}

surface_breach() {
  thread maps\black_ice_anim::swim_ally_surface_anim();
  level.player.disablereload = 1;
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player disableweaponswitch();
  level.player.hint_active = undefined;
  level notify("notify_swim_end");
  thread player_water_breach_moment();
  thread maps\black_ice_audio::sfx_player_exits_water();
  thread maps\black_ice_audio::sfx_heli_over();
  maps\black_ice_anim::swim_player_surface_anim();
}

scuba_ally_swap() {
  level waittill("notify_ally_swim_surface_anims_done");
  level.launchers_attached = 1;

  if(isDefined(level._allies_swim)) {
    level._allies_swim = [];
    maps\_utility::array_delete(level._allies_swim);
  }
}

scuba_surface(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3.animname;
  var_3.animname = "scuba_ally";
  var_3 maps\_utility::ent_flag_init("flag_camp_move_ally");
  wait(var_0);
  thread maps\_anim::anim_single_solo(var_1, var_2);
  common_scripts\utility::flag_wait("player_water_breach");
  var_3 forceteleport(var_1.origin, var_1.angles);
  var_3 attach(level.scr_model["ascend_launcher_non_anim"], "TAG_STOWED_BACK");
  var_6 = var_1 getanimtime(var_1 maps\_utility::getanim(var_2));

  if(isDefined(var_1.launcher)) {
    var_1.launcher unlink();
    var_1.launcher delete();
  }

  var_1 delete();
  var_3 show();
  thread maps\_anim::anim_single_solo(var_3, var_2, undefined, 0.1);
  wait 0.05;
  var_3 setanimtime(var_3 maps\_utility::getanim(var_2), var_6);
  wait(getanimlength(var_3 maps\_utility::getanim(var_2)) * (1.0 - var_6));
  var_3.animname = var_5;

  if(!isDefined(var_4) || var_3 maps\_utility::ent_flag("flag_camp_move_ally")) {
    return;
  }
  var_7 = var_3.newenemyreactiondistsq;
  var_3.newenemyreactiondistsq = 0;
  var_3 maps\_utility::disable_ai_color();
  var_3 thread maps\_utility::follow_path(getnode(var_4, "targetname"));
  var_3 maps\_utility::ent_flag_wait("flag_camp_move_ally");
  var_3 notify("stop_going_to_node");
  var_3 maps\_utility::enable_ai_color();

  for(;;) {
    var_8 = maps\_utility::get_closest_ai(var_3.origin, "axis");

    if(isDefined(var_8)) {
      var_9 = distancesquared(var_3.origin, var_8.origin);

      if(var_9 > var_7) {
        var_3.newenemyreactiondistsq = var_7;
        break;
      }
    }

    wait 0.1;
  }
}

bravo_post_snake_cam(var_0, var_1, var_2, var_3) {
  var_1 maps\_utility::ent_flag_init("flag_camp_move_ally");
  wait(var_0);
  var_4 = getnode(var_2, "targetname");
  var_1 forceteleport(var_4.origin, var_4.angles);
  var_1 attach(level.scr_model["ascend_launcher_non_anim"], "TAG_STOWED_BACK");
  var_1 show();

  if(isDefined(var_3)) {
    var_5 = var_1.animname;
    var_1.animname = "scuba_ally";
    thread maps\_anim::anim_single_solo(var_1, var_3);
    wait(getanimlength(var_1 maps\_utility::getanim(var_3)));
    var_1.animname = var_5;
  }

  if(!isDefined(var_2) || var_1 maps\_utility::ent_flag("flag_camp_move_ally")) {
    return;
  }
  var_6 = var_1.newenemyreactiondistsq;
  var_1.newenemyreactiondistsq = 0;
  var_1 maps\_utility::disable_ai_color();
  var_1 thread maps\_utility::follow_path(var_4);
  var_1 maps\_utility::ent_flag_wait("flag_camp_move_ally");
  var_1 notify("stop_going_to_node");
  var_1 maps\_utility::enable_ai_color();

  for(;;) {
    var_7 = maps\_utility::get_closest_ai(var_1.origin, "axis");

    if(isDefined(var_7)) {
      var_8 = distancesquared(var_1.origin, var_7.origin);

      if(var_8 > var_6) {
        var_1.newenemyreactiondistsq = var_6;
        break;
      }
    }

    wait 0.1;
  }
}

wait_till_breach_end_conditions() {
  level waittill("notify_swim_end_breach");
}

player_water_breach_moment() {
  while(!common_scripts\utility::flag("player_water_breach"))
    wait(level.timestep);
}

player_post_swim() {
  maps\black_ice_util::player_animated_sequence_cleanup();
  level.player allowswim(0);
  level.player disableslowaim();

  if(isDefined(level.player_scuba)) {
    level.player_scuba delete();
    level.player_scuba = undefined;
  }
}

ice_breach_process_enemy(var_0) {
  thread ice_breach_process_enemy_anim(var_0);
  thread ice_breach_process_enemy_dmg(var_0);
}

ice_breach_process_enemy_anim(var_0) {
  self endon("death");

  while(!maps\black_ice_util::check_anim_time(self.animname, "introbreach_opfor" + var_0, 1.0))
    wait(level.timestep);

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    maps\_utility::stop_magic_bullet_shield();

  self.allowdeath = 1;
  self kill();
}

ice_breach_process_enemy_dmg(var_0) {
  self endon("death");
  self waittill("damage", var_1, var_2, var_3, var_4, var_5);

  if(var_5 != "MOD_EXPLOSIVE") {
    if(var_3 != (0, 0, 0))
      playFX(common_scripts\utility::getfx("swim_ai_blood_impact"), var_4, var_3);
  }

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    maps\_utility::stop_magic_bullet_shield();

  self.allowdeath = 1;
  self kill();
}

props_cleanup() {
  level.breach_vehicles["gaztiger"] thread prop_destroy(level.breach_anim_node, "intro_breach", maps\black_ice_fx::turn_off_gaztiger_underwater_lights_fx);
  level.breach_vehicles["bm21_2"] thread prop_destroy(level.breach_anim_node, "intro_breach", maps\black_ice_fx::turn_off_bm21_2_underwater_lights_fx);
}

prop_destroy(var_0, var_1, var_2) {
  var_0 waittill(var_1);

  if(isDefined(var_2))
    [[var_2]]();

  self delete();
}

destroy_persistent_ice_breach_props() {
  if(isDefined(level.tag_anim_rig_models)) {
    for(var_0 = 0; var_0 < level.tag_anim_rig_models.size; var_0++)
      level.tag_anim_rig_models[var_0] delete();
  }

  if(isDefined(level.breach_props)) {
    if(isDefined(level.breach_props["introbreach_props"]))
      level.breach_props["introbreach_props"] delete();
  }

  if(isDefined(level.breach_vehicles)) {
    if(isDefined(level.breach_vehicles["bm21_1"]))
      level.breach_vehicles["bm21_1"] delete();
  }

  if(isDefined(level.surface_truck))
    maps\black_ice_anim::swim_truck_surface_destroy();
}

underwater_sfx() {
  wait 1;
  common_scripts\utility::flag_wait("flag_outofwater_sfx");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
}

player_heartbeat() {
  level endon("stop_player_heartbeat");

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    wait 0.5;
  }
}

check_analog_movement() {
  var_0 = level.player getnormalizedmovement();

  if(var_0[0] == 0 && var_0[1] == 0)
    return 0;
  else
    return 1;
}

retarget_breach_water() {
  self retargetscriptmodellighting(getent("infil_lighttarget", "targetname"));
}

set_snakecam_dof() {
  maps\_art::dof_enable_script(0, 211.65, 8, 10000, 30000, 0.3, 2.0);
  level waittill("flag_snake_cam_below_water");

  if(maps\_utility::is_gen4())
    setsaveddvar("r_mbEnable", 0);

  maps\_art::dof_disable_script(1);
  common_scripts\utility::flag_wait("player_water_breach");
  thread maps\black_ice_camp::camp_mblur_changes();
  maps\_art::dof_enable_script(0, 100, 3, 5000, 7000, 0.4, 0);
  wait 2;
  maps\_art::dof_enable_script(0, 1, 1, 500, 7000, 10, 1);
  wait 3;
  maps\_art::dof_disable_script(1);
}

swim_godrays() {
  var_0 = getent("swim_gr_origin", "targetname");

  if(maps\_utility::is_gen4())
    maps\black_ice_util::god_rays_from_world_location(var_0.origin, "flag_swim_breach_detonate", "player_water_breach", undefined, undefined);
}