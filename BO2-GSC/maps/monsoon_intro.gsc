/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\monsoon_intro.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\monsoon_util;
#include maps\_scene;
#include maps\_anim;
#include maps\_dialog;
#include maps\_vehicle;
#include maps\_music;
#include maps\_glasses;
#include maps\monsoon_amb;
#include maps\createart\monsoon_art;
#include maps\_audio;
#include maps\monsoon_wingsuit;
#include maps\_stealth_logic;
#include maps\_patrol;

skipto_intro() {
  skipto_teleport_players("player_skipto_intro");
}

skipto_harper_reveal() {
  skipto_teleport_players("player_skipto_intro");
}

skipto_rock_swing() {
  skipto_teleport_players("wingsuit_start_spot");
}

skipto_suit_jump() {
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  level thread run_scene("squirrel_intro_idle_harper");
  level thread run_scene("squirrel_intro_idle_salazar");
  level thread run_scene("squirrel_intro_idle_crosby");
  level.harper thread wingsuit_ai_setup("c_usa_seal6_ass_sqrl_haper_wt_fb", level.harper.model);
  level.salazar thread wingsuit_ai_setup("c_usa_seal6_ass_sqrl_salazar_wt_fb", level.salazar.model);
  level.crosby thread wingsuit_ai_setup("c_usa_seal6_assault_squirrel_wt_fb", level.crosby.model);
  skipto_teleport_players("wingsuit_start_spot");
}

init_intro_flags() {
  flag_init("goggles_started");
  flag_init("intro_lift_down");
  flag_init("intro_start_ambient_activity");
  flag_init("goggles_done");
  flag_init("intro_goggles_off");
  flag_init("vertigo_started");
  flag_init("player_equipped_suit");
  flag_init("squad_equipped_suits");
  flag_init("leap_of_faith_started");
  flag_init("cliff_hands_up");
  flag_init("cliff_swing_fail_checked");
  flag_init("cliff_crosby_ready");
  flag_init("cliff_salazar_ready");
  flag_init("cliff_salazar_helps");
  flag_init("cliff_cut_rope");
  flag_init("start_level_objectives");
}

main() {
  eagle_eye_setup();

  switch (level.skipto_point) {
    case "intro":
      eagle_eye_far_flung();
    case "harper_reveal":
      eagle_eye_vertigo();
      eagle_eye_surface_link();
    case "rock_swing":
      eagle_eye_swing();
      eagle_eye_rough_landing();
    case "suit_jump":
      eagle_eye_leap_of_faith();
  }
}

eagle_eye_setup() {
  level.player player_disable_weapons();
  level.player_interactive_model = "c_usa_seal6_monsoon_armlaunch_viewbody_on";
  set_rain_level(5);
  level.weather_wind_shake = 0;
  exploder(33);
  exploder(34);
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
}

wingsuit_ai_setup(str_model, str_orig_model) {
  self gun_switchto("none", "right");

  if(self != level.crosby)
    self attach("c_usa_seal6_helmet_prop", "J_Head");

  self setmodel(str_model);
  flag_wait("wingsuit_landing_started");
  wait 5;
  self setmodel(str_orig_model);

  if(self != level.crosby)
    self detach("c_usa_seal6_helmet_prop", "J_Head");

  self gun_switchto(self.primaryweapon, "right");
}

eagle_eye_far_flung() {
  delay_thread(30, ::flag_set, "show_introscreen_title");
  setmusicstate("MONSOON_INTRO");
  level thread eagle_eye_vo();
  setup_goggles();
  level.player allowcrouch(0);
  level.player turn_on_goggles_vision();
  intro_start_ambient_activity();
  level.player thread goggles_controls();
  flag_set("goggles_started");
  level clientnotify("sndFakeAmb");
  flag_set("intro_start_ambient_activity");
  luinotifyevent(&"hud_update_vehicle_custom", 2, 1, & "goggles_hud");
  wait 20;
  flag_set("goggles_done");
  wait 1;
  level.player notify("stop_input_detection");
  level.player zoom_out_to_cliff();
  screen_fade_out(0.2, undefined, 1);
  run_scene_first_frame("remove_binoculars");
  luinotifyevent(&"hud_update_vehicle_custom", 1, 0);
  level.player turn_off_goggles_vision();
  flag_set("intro_goggles_off");
  screen_fade_in(0.2, undefined, 1);
  level thread eagle_eye_extra_arms();
  level clientnotify("sndFakeAmbEnd");
  playsoundatposition("evt_binocs_hud_pwr_down", (0, 0, 0));
  level.player allowcrouch(1);
  luinotifyevent(&"hud_update_vehicle_custom", 1, 0);
  level thread eagle_eye_start_glasses();
}

eagle_eye_extra_arms() {
  level thread run_scene("remove_binoculars");
  wait 0.5;
  end_scene("remove_binoculars");
}

eagle_eye_start_glasses() {
  maps\_glasses::perform_visor_wipe();
  wait 5;
  luinotifyevent(&"hud_shrink_ammo", 0);
  flag_set("start_level_objectives");
}

eagle_eye_vo() {
  wait 2;
  level.harper say_dialog("harp_what_s_the_story_se_1");
  wait 0.7;
  level.player say_dialog("sect_base_is_2_klicks_sou_0");
  wait 1.1;
  level.harper say_dialog("harp_defensive_strength_0");
  wait 0.8;
  level.player say_dialog("sect_light_guard_detail_p_0");
  wait 1.5;
  level.harper say_dialog("harp_guess_menendez_weal_0");
  wait 1.4;
  level.player say_dialog("sect_they_re_the_best_of_0");
}

eagle_eye_vertigo() {
  flag_set("vertigo_started");
  o_player_start = getent("intro_far_flung_player_spot_org", "targetname");
  a_m_fx_models = getentarray("enemy_marker_model", "targetname");
  o_player_start delete();
  array_delete(a_m_fx_models);
}

eagle_eye_surface_link() {
  level.harper play_fx("harper_drips", undefined, undefined, 15, 1, "J_wrist_RI");
  level.harper play_fx("harper_drips", undefined, undefined, 15, 1, "J_shoulder_RI");
  level.harper play_fx("harper_drips", undefined, undefined, 15, 1, "J_hip_RI");
  level.player delay_thread(0.2, ::switch_player_scene_to_delta);
  run_scene("cliff_intro");
}

eagle_eye_swing() {
  level.missionfailsndspecial = maps\monsoon_amb::missionfailsndspecial;
  cliff_swing(&"MONSOON_PROMPT_HARPER_FALL", "ltrig", "cliff_swing_1_idle", "cliff_swing_1", "input_lstick_detected");
  cliff_swing(&"MONSOON_PROMPT_PLAYER_FALL", "jump_button", "cliff_swing_2_idle", "cliff_swing_2", "input_trigs_detected");
  cliff_swing(&"MONSOON_PROMPT_HARPER_FALL", "ltrig", "cliff_swing_3_idle", "cliff_swing_3", "input_lstick_detected");
  cliff_swing(&"MONSOON_PROMPT_PLAYER_FALL", "jump_button", "cliff_swing_4_idle", "cliff_swing_4", "input_trigs_detected");
  cliff_swing(&"MONSOON_PROMPT_HARPER_FALL", "ltrig", "cliff_swing_5_idle", "cliff_swing_5", "input_lstick_detected");
  level.salazar = init_hero("salazar");
  level.player thread cliff_swing_6_rumble();
  cliff_swing(&"MONSOON_PROMPT_PLAYER_FALL", "jump_button", "cliff_swing_6_idle", "cliff_swing_6", "input_lstick_detected", "cliff_swing_6_player");
  level.missionfailsndspecial = undefined;
}

eagle_eye_rough_landing() {
  level thread run_scene("squirrel_intro_idle_harper");
  flag_wait_all("cliff_crosby_ready", "cliff_salazar_ready");
  flag_set("squad_equipped_suits");
}

eagle_eye_leap_of_faith() {
  flag_wait("player_equipped_suit");
  level.player.vh_wingsuit = level.player init_driveable_wingsuit();
  level thread eagle_eye_squad_waits();
  level.crosby thread eagle_eye_crosby_jumps();
  level waittill("uncage_player");
  array_delete(getentarray("wingsuit_launch_blocker", "targetname"));
  level.player thread jump_fail_check();
  flag_set("jet_stream_launch_obj");
  flag_wait("leap_of_faith_started");
  level thread maps\createart\monsoon_art::suit_fly_vision();
  level thread maps\_audio::switch_music_wait("MONSOON_FLIGHT", 0.1);
  flag_set("jet_stream_launch_obj_complete");
  setsaveddvar("player_standingViewHeight", 60);
}

eagle_eye_squad_waits() {
  run_scene_and_delete("crosby_jumps_squad");

  if(!flag("jet_stream_launch_obj_complete")) {
    level thread eagle_eye_harper_nag();
    level thread run_scene_and_delete("wait_player_jump_salazar");
    flag_wait("jet_stream_launch_obj_complete");
    end_scene("wait_player_jump_salazar");
  }
}

eagle_eye_harper_nag() {
  level thread run_scene_and_delete("wait_player_jump_harper_nag");
  flag_wait_either("wait_player_jump_harper_nag_done", "jet_stream_launch_obj_complete");

  if(flag("wait_player_jump_harper_nag_done")) {
    level thread run_scene_and_delete("wait_player_jump_harper");
    flag_wait("jet_stream_launch_obj_complete");
    end_scene("wait_player_jump_harper");
  } else
    end_scene("wait_player_jump_harper_nag");
}

eagle_eye_crosby_jumps() {
  run_scene_and_delete("crosby_jumps");
  level notify("uncage_player");
  self.vh_wingsuit = spawn_vehicle_from_targetname("vh_wingsuit_spawner");
  self.vh_wingsuit hide();
  self.vh_wingsuit.origin = self.origin;
  self.vh_wingsuit setphysangles(self.angles);
  self linkto(self.vh_wingsuit, "tag_driver");
  self thread maps\monsoon_wingsuit::do_flight_anims("fwd_idle");
  nd_start = getvehiclenode("path_wingsuit_crosby", "targetname");
  self.vh_wingsuit go_path(nd_start);
  self hide();
}

player_equip_suit() {
  setsaveddvar("player_standingViewHeight", 64);
  self allowsprint(0);
  self allowjump(0);
  self setmovespeedscale(0.5);
  flag_wait("cliff_swing_6_player_done");
  level.player_interactive_model = "c_usa_seal6_monsn_sqrl_armlnch_viewbody";
  autosave_by_name("all_swings_done");
  flag_wait("squad_equipped_suits");
  level.weather_wind_shake = 1;
  self waittill_input(&"MONSOON_PROMPT_WINGS", "ltrig_rtrig");
  anchor = spawn("script_origin", self.origin);
  anchor.angles = self.angles;
  anchor.targetname = "equip_suit";
  flag_set("player_equipped_suit");
  run_scene("player_equip_suit");
  autosave_by_name("player_ready_to_jump");
  anchor delete();
  self allowsprint(1);
  self allowjump(1);
  self setmovespeedscale(1);
  level.player_interactive_model = "c_usa_seal6_monsoon_armlaunch_viewbody";
}

squad_equip_suits(m_player_body) {
  level.harper thread wingsuit_ai_setup("c_usa_seal6_ass_sqrl_haper_wt_fb", level.harper.model);
  level.salazar thread wingsuit_ai_setup("c_usa_seal6_ass_sqrl_salazar_wt_fb", level.salazar.model);
  level.crosby thread wingsuit_ai_setup("c_usa_seal6_assault_squirrel_wt_fb", level.crosby.model);
}

jump_fail_check() {
  level endon("leap_of_faith_started");
  e_volume = getent("wingsuit_leap_fail_volume", "targetname");

  while(true) {
    if(self istouching(e_volume)) {
      missionfailedwrapper(&"MONSOON_JUMP_FAIL");
      return;
    }

    wait 0.05;
  }
}

setup_goggles() {
  o_player_start = getent("intro_far_flung_player_spot_org", "targetname");
  level.player setplayerangles(o_player_start.angles);
  level.player.origin = o_player_start.origin;
  level.player playerlinktodelta(o_player_start, undefined, 1, 30, 30, 50, 0);
}

turn_on_goggles_vision() {
  level notify("_rain_drops");
  self clearclientflag(6);
  self setclientflag(8);
  level thread maps\createart\monsoon_art::intro_vision();
  self setplayerviewratescale(10);
}

turn_off_goggles_vision() {
  level thread maps\monsoon_util::_rain_drops();
  self clearclientflag(8);
  self setclientflag(6);
  level thread maps\createart\monsoon_art::harper_reveal_vision();
  self resetplayerviewratescale();
}

goggles_controls() {
  self thread lerp_fov_overtime(0.3, 28);
}

goggles_zoom(b_zoom) {
  if(!isDefined(b_zoom))
    b_zoom = 1;

  if(b_zoom == 0) {
    level thread goggles_zoom_sound("out");
    self set_zoom(10, 0.3, 0.3, 28);
    luinotifyevent(&"hud_goggles_update_zoom", 1, 1000);

    if(isDefined(level.fullscreen_cin_hud)) {
      level.fullscreen_cin_hud fadeovertime(0.3);
      level.fullscreen_cin_hud.alpha = 0;
    }
  } else {
    level thread goggles_zoom_sound("in");
    self set_zoom(10, 0.3, 0.3, 16);
    luinotifyevent(&"hud_goggles_update_zoom", 1, 1025);

    if(isDefined(level.fullscreen_cin_hud)) {
      level.fullscreen_cin_hud fadeovertime(0.3);
      level.fullscreen_cin_hud.alpha = 1;
    } else
      level.cin_id = play_movie_async("mon_nocs_hud", 1, 1, undefined, 0, undefined, undefined, 0, 1, 0, 0);
  }
}

goggles_zoom_sound(str_direction) {
  e_binoc = spawn("script_origin", level.player.origin);

  if(str_direction == "in")
    e_binoc playsound("evt_binocs_hud_zoom_out");
  else
    e_binoc playsound("evt_binocs_hud_zoom_in");

  e_binoc delete();
}

set_zoom(n_fade_blur, n_blur_time, n_lerp, n_fov) {
  self startfadingblur(n_fade_blur, n_blur_time);
  self lerp_fov_overtime(n_lerp, n_fov);
}

zoom_out_to_cliff() {
  station_pos_x = 15666;
  station_pos_y = 38847;
  station_pos_z = 9378;
  self set_zoom(10, 0.1, 0.3, 55);
  wait 3;
  luinotifyevent(&"hud_goggles_clear_all_poi");
  wait_network_frame();
  luinotifyevent(&"hud_goggles_add_poi", 5, -1, 0, station_pos_x, station_pos_y, station_pos_z);
  luinotifyevent(&"hud_goggles_update_zoom", 1, 10);
  level thread goggles_zoom_sound("out");
  self thread set_zoom(10, 0.5, 0.3, 65);
  run_scene_first_frame("cliff_intro");
  self delay_thread(0.2, ::switch_player_scene_to_delta);
  wait 2;
}

intro_start_ambient_activity() {
  level thread ambient_guards();
  level thread ambient_heli();
  level thread lift_control();
  level thread ambient_poi_zoom();
}

ambient_guards() {
  sp_intro = getent("intro_vig_spawner", "targetname");
  sp_intro add_spawn_function(::ambient_guard_think);
  add_spawn_function_veh("intro_turret", ::ambient_turret_think);

  for(i = 1; i < 5; i++)
    level thread run_scene_and_delete("intro_vig_" + i);

  wait 0.3;
  s_align = getstruct("camo_battle_intro", "targetname");

  for(i = 1; i < 5; i++) {
    loop_guard = sp_intro spawn_ai(1);
    s_align thread maps\_stealth_logic::stealth_ai_idle_and_react(loop_guard, "camo_stealth_loop_" + i, "camo_stealth_react_" + i);
  }

  ai_lift_guard = sp_intro spawn_ai(1);
  ai_lift_guard maps\_patrol::patrol("lift_patrol_goal");
  level notify("move_lift_down");
  flag_wait("vertigo_started");
  sp_intro delete();
  array_delete(getaiarray("axis"));
}

ambient_guard_think() {
  self set_ignoreme(1);
  self set_ignoreall(1);
  self.patrol_dont_claim_node = 1;
  self.target = "defined";
  self.goalradius = 32;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.disableturns = 1;
  self setclientflag(11);
  luinotifyevent(&"hud_goggles_add_poi", 1, self getentitynumber());
  flag_wait("goggles_started");
  self set_generic_run_anim("patrol_walk", 1);
  self setgoalpos(getnode("intro_vig_goal", "targetname").origin);
}

ambient_turret_think() {
  self setclientflag(11);
  luinotifyevent(&"hud_goggles_add_poi", 1, self getentitynumber());
}

ambient_heli() {
  vh_heli = spawn_vehicle_from_targetname("heli_goggles_intro");
  vh_heli setclientflag(11);
  vh_heli setspeed(10, 5, 5);
  vh_heli setneargoalnotifydist(400);
  vh_heli sethoverparams(50);
  vh_heli setdefaultpitch(15);
  vh_heli setlookatent(getent("lift_ruins", "targetname"));
  vh_heli setvehgoalpos(getstruct("intro_heli_goal_1", "targetname").origin);
  luinotifyevent(&"hud_goggles_add_poi", 2, vh_heli getentitynumber(), -50);
  flag_wait("vertigo_started");
  vh_heli.delete_on_death = 1;
  vh_heli notify("death");

  if(!isalive(vh_heli))
    vh_heli delete();
}

lift_control() {
  level waittill("intro_start_ambient_activity");
  m_lift = getent("lift_ruins", "targetname");
  m_lift setclientflag(11);
  level waittill("move_lift_down");
  outside_lift_move_down();
  wait 10;
  outside_lift_move_up();
  m_lift clearclientflag(11);
}

ambient_poi_zoom() {
  wait 1;
  level.intro_poi = getstructarray("intro_poi", "targetname");
  level.intro_poi = add_to_array(level.intro_poi, getent("lift_ruins", "targetname"), 0);
  level.intro_poi = add_to_array(level.intro_poi, getent("heli_goggles_intro", "targetname"), 0);
  str_poi = undefined;
  b_zoom = 0;

  while(!flag("goggles_done")) {
    if(isDefined(b_zoom) && !b_zoom) {
      str_poi = looking_at_poi();

      if(isDefined(str_poi)) {
        add_visor_text("MONSOON_POI_SCANNING", 0, "orange", "medium");
        add_visor_text(str_poi, 0, "default", "medium");
        level.player goggles_zoom(1);
        b_zoom = 1;
      }
    } else if(isDefined(b_zoom) && b_zoom && !isDefined(looking_at_poi())) {
      remove_visor_text("MONSOON_POI_SCANNING");
      remove_visor_text(str_poi);
      level.player goggles_zoom(0);
      b_zoom = 0;
      str_poi = undefined;
      wait 1;
    }

    wait 0.05;
  }

  if(isDefined(level.cin_id))
    stop3dcinematic(level.cin_id);

  if(isDefined(str_poi)) {
    remove_visor_text("MONSOON_POI_SCANNING");
    remove_visor_text(str_poi);
  }

  level.player goggles_zoom(0);
}

looking_at_poi() {
  foreach(poi in level.intro_poi) {
    if(level.player is_looking_at(poi.origin, 0.995))
      return poi.script_noteworthy;
  }

  return undefined;
}

cliff_intro_harper_intro(guy) {
  level thread maps\createart\monsoon_art::lightning_strike();
}

cliff_swing_success_window_assist_start(guy) {
  level.player thread player_camera_shake_loop(0.15, 0.5, level.player.origin, 1000);
  cliff_swing_success_window_harper(0.3, 0.2, "monsoon_gloves_impact", & "MONSOON_PROMPT_SWING", "lstick", "left");
}

cliff_swing_success_window_grab_start(guy) {
  level.player thread player_camera_shake_loop(0.25, 0.5, level.player.origin, 1000);
  cliff_swing_success_window_player(0.6, 0.2, "monsoon_gloves_impact", & "MONSOON_PROMPT_GLOVES_ON", "ltrig_rtrig");
}

cliff_swing_6_landing(guy) {
}

cliff_swing_flying_rumble(guy) {
  level.player playrumblelooponentity("monsoon_player_swing");
  wait 1.8;
  level.player stoprumble("monsoon_player_swing");
}

cliff_swing_assist_rumble(guy) {
  level.player playrumbleonentity("monsoon_harper_swing");
}

nanoglove_impact(guy) {
  level.player playrumbleonentity("monsoon_gloves_impact");
}

single_rumble(guy) {
  level.player playrumbleonentity("monsoon_gloves_impact");
}

cliff_swing_harper_1_fail(player) {
  cliff_swing_fail("input_lstick_detected", "cliff_swing_1_fail");
}

cliff_swing_player_1_fail(player) {
  cliff_swing_fail("cliff_hands_up", "cliff_swing_2_fail");
}

cliff_swing_harper_2_fail(player) {
  cliff_swing_fail("input_lstick_detected", "cliff_swing_3_fail");
}

cliff_swing_player_2_fail(player) {
  cliff_swing_fail("cliff_hands_up", "cliff_swing_4_fail");
}

cliff_swing_harper_3_fail(player) {
  cliff_swing_fail("input_lstick_detected", "cliff_swing_5_fail");
}

cliff_swing_fail(str_flag, str_scene) {
  flag_set("cliff_swing_fail_checked");
  screen_message_delete();
  level.player playrumbleonentity("monsoon_gloves_impact");
  level thread timescale_tween(1.8, 1.0, 0.5);

  if(!flag(str_flag)) {
    if(str_flag == "input_lstick_detected")
      delay_thread(0.75, ::missionfailedwrapper);
    else if(str_flag == "cliff_hands_up")
      delay_thread(0.75, ::missionfailedwrapper);

    run_scene(str_scene);
  }
}

player_camera_shake_loop(n_intensity, n_time, v_org, n_radius) {
  level endon("cliff_swing_fail_checked");

  while(true) {
    earthquake(n_intensity, n_time, v_org, n_radius, self);
    wait 0.05;
  }
}

#using_animtree("player");

cliff_swing_6_rumble() {
  wait(getanimlength( % p_mon_01_01_cliffswing6_player) - 3);
  level notify("cliff_swing_6_done");
}

cliff_swing(str_prompt, str_button, str_idle_anim, str_swing_anim, str_flag, str_swing_anim_thread) {
  level thread cliff_swing_nag_vo();
  scene_idle_waittill_input(str_prompt, str_button, str_idle_anim);
  level notify("bpgm");
  level notify("stop_cliff_nag");

  if(isDefined(str_swing_anim_thread)) {
    level thread run_scene(str_swing_anim_thread);
    level.player thread player_equip_suit();
    level thread cliff_swing_salazar();
    level thread cliff_swing_crosby();
  }

  if(str_button == "jump_button")
    level.player thread cliff_swing_player_fx();

  if(str_swing_anim == "cliff_swing_2")
    level.harper thread say_dialog("harp_surface_is_a_little_0", 0.5);

  level thread cliff_swing_rope(str_swing_anim);
  run_scene(str_swing_anim);
  flag_clear(str_flag);
  flag_clear("cliff_swing_fail_checked");
}

cliff_swing_rope(str_swing_anim) {
  run_scene_and_delete(str_swing_anim + "_rope");
  run_scene_and_delete(str_swing_anim + "_rope_b");
}

cliff_swing_player_fx() {
  self endon("death");
  wait 1;
  m_player_body = getent("player_body", "targetname");

  for(i = 0; i < 10; i++) {
    playfxontag(getfx("fx_water_rope_swing"), m_player_body, "tag_camera");
    wait 0.2;
  }
}

cliff_swing_nag_vo() {
  level endon("stop_cliff_nag");

  if(!isDefined(level.a_cliff_nag)) {
    level.a_cliff_nag[0] = "harp_waitin_on_you_suga_0";
    level.a_cliff_nag[1] = "harp_come_on_brother_w_0";
    level.a_cliff_nag[2] = "harp_come_on_let_s_get_t_0";
    level.a_cliff_nag[3] = "harp_we_gotta_move_secti_0";
    level.a_cliff_nag[4] = "harp_hurry_up_brother_0";
    level.a_cliff_nag[5] = "harp_let_s_get_going_1";
    level.a_cliff_nag[6] = "harp_what_are_you_waiting_0";
    level.a_cliff_nag[7] = "harp_let_s_do_it_section_0";
    level.a_cliff_nag = array_randomize(level.a_cliff_nag);
  }

  n_nag = 0;

  for(i = 0; i < level.a_cliff_nag.size; i++) {
    if(level.a_cliff_nag[i] == "played") {
      continue;
    }
    wait(randomfloatrange(7, 9));
    level.harper say_dialog(level.a_cliff_nag[i]);
    level.a_cliff_nag[i] = "played";
    n_nag++;

    if(n_nag >= 3)
      return;
  }
}

cliff_swing_salazar() {
  run_scene("cliff_swing_6_salazar");
  flag_set("cliff_salazar_ready");
  level thread run_scene("squirrel_intro_idle_salazar");
}

cliff_swing_crosby() {
  run_scene("cliff_swing_6_crosby");
  flag_set("cliff_crosby_ready");
  level thread run_scene("squirrel_intro_idle_crosby");
}

scene_idle_waittill_input(str_prompt, str_button, str_scenename) {
  level thread run_scene(str_scenename);

  if(str_button == "ltrig")
    autosave_now();

  level.player waittill_input(str_prompt, str_button);
}

set_time_scale_for_time(n_scale, n_time) {
  settimescale(n_scale);
  wait(n_time);
  settimescale(1);
}

cliff_swing_success_window_player(n_time_scale, n_scale_timer, str_rumble, str_prompt, str_button, str_direction) {
  level thread timescale_tween(1.0, n_time_scale, 0.2);
  level.player playrumbleonentity(str_rumble);
  level.player waittill_input(str_prompt, str_button, str_direction);
  level thread timescale_tween(n_time_scale, 1.0, 0.2);
  level.player playrumbleonentity(str_rumble);

  if(!flag("cliff_swing_fail_checked")) {
    flag_set("cliff_hands_up");
    run_scene("cliff_impact_raise");

    if(!flag("cliff_swing_fail_checked"))
      level thread run_scene("cliff_impact_ready");
    else {
      m_body_double = get_model_or_models_from_scene("cliff_impact_raise", "player_body_double");

      if(isDefined(m_body_double))
        m_body_double delete();
    }
  }
}

real_body_hide(player_body) {
  player_body hide();
}

real_body_show(player_body) {
  fake_player_body = getent("player_body_double", "targetname");

  if(isDefined(fake_player_body))
    fake_player_body delete();

  player_body show();
  flag_clear("cliff_hands_up");
}

cliff_swing_success_window_harper(n_time_scale, n_scale_timer, str_rumble, str_prompt, str_button, str_direction) {
  level.harper setclientflag(14);
  level.harper thread cliff_swing_stop_trail();
  level thread timescale_tween(1.0, n_time_scale, 0.1);
  level.player waittill_input(str_prompt, str_button, str_direction);
  level thread timescale_tween(n_time_scale, 1.8, 0.3);
  level.player thread cliff_swing_success_rumble();
}

cliff_swing_stop_trail() {
  wait 2;
  level.harper clearclientflag(14);
}

cliff_swing_success_rumble() {
  level.player playrumblelooponentity("monsoon_player_swing");

  while(!flag("cliff_swing_fail_checked")) {
    earthquake(0.4, 0.1, self.origin, 1000, self);
    wait 0.1;
  }

  wait 1;
  level.player stoprumble("monsoon_player_swing");
}

cliff_swing_tree_fall(m_player_body) {
  exploder(166);
  level notify("fxanim_lightning_tree_start");
  wait 1.5;
  level.player playerlinktodelta(getent("player_body", "targetname"), "tag_player", 1, 25, 5, 30, 0);
  wait 1;
  stop_exploder(166);
  level thread maps\createart\monsoon_art::lightning_strike();
  level.player playrumbleonentity("artillery_rumble");
  earthquake(0.75, 1, level.player.origin, 200, level.player);
  wait 2.5;
  setmusicstate("MONSOON_TREE_FALL");
  earthquake(1, 1, level.player.origin, 200, level.player);
}

cliff_swing_tree_fall_rumble(m_player_body) {
  level.player playrumblelooponentity("monsoon_player_swing");

  while(!flag("cliff_salazar_helps")) {
    earthquake(0.3, 0.05, level.player.origin, 200, level.player);
    wait 0.05;
  }

  level.player stoprumble("monsoon_player_swing");
  level.player playrumblelooponentity("tank_rumble");

  while(!flag("cliff_cut_rope")) {
    earthquake(0.15, 0.05, level.player.origin, 200, level.player);
    wait 0.05;
  }

  level.player stoprumble("tank_rumble");
}

nano_glove_left_on(m_player_body) {
  playfxontag(getfx("nanoglove_impact"), m_player_body, "j_index_le_1");
  m_player_body ignorecheapentityflag(1);
  m_player_body setclientflag(2);
}

nano_glove_left_off(m_player_body) {
  m_player_body ignorecheapentityflag(1);
  m_player_body clearclientflag(2);
}

nano_glove_right_on(m_player_body) {
  playfxontag(getfx("nanoglove_impact"), m_player_body, "j_index_ri_1");
  m_player_body ignorecheapentityflag(1);
  m_player_body setclientflag(1);
}

nano_glove_right_off(m_player_body) {
  m_player_body ignorecheapentityflag(1);
  m_player_body clearclientflag(1);
}

nano_gloves_off(m_player_body) {
  nano_glove_left_off(m_player_body);
  nano_glove_right_off(m_player_body);
}

cliff_swing_impact_player(m_player_body) {
  playfxontag(getfx("nanoglove_impact_cheap"), m_player_body, "j_index_le_1");
  playfxontag(getfx("nanoglove_impact_cheap"), m_player_body, "j_index_ri_1");
}