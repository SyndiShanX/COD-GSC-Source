/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\panama_house.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\panama_utility;
#include maps\_vehicle;
#include maps\_objectives;
#include maps\_music;
#include maps\createart\panama_art;
#include maps\_audio;

skipto_house() {
  skipto_setup();
  skipto_teleport_players("player_skipto_house");
}

panama_wind_settings() {
  setsaveddvar("wind_global_vector", "246.366 0 0");
  setsaveddvar("wind_global_low_altitude", 0);
  setsaveddvar("wind_global_hi_altitude", 5000);
  setsaveddvar("wind_global_low_strength_percent", 0.5);
}

main() {
  level thread house_ik_headtracking_limits();
  level thread blackscreen(0, 2, 0);
  level thread maps\createart\panama_art::house();
  level.player_interactive_model = "c_usa_woods_panama_casual_viewbody";
  house_intro_setup();
  level.hummersoundent = spawn("script_origin", (24315, -20231, 111));
  level.hummersoundent playloopsound("evt_mason_vehicle_idle_loop", 3);
  level.player allowcrouch(0);
  level.player allowprone(0);
  player_exits_hummer();
  level.player thread street_fail_condition();
  house_events();
  level.player_interactive_model = "c_usa_woods_panama_viewbody";
  level thread old_man_woods("panama_int_1");
  level thread house_clean_up_and_reset();
  level thread restore_ik_headtracking_limits();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level waittill("movie_done");
  screen_fade_out(0.05);
  flag_set("house_event_end");
}

house_ik_headtracking_limits() {
  setsaveddvar("ik_pitch_limit_thresh", 20);
  setsaveddvar("ik_pitch_limit_max", 70);
  setsaveddvar("ik_roll_limit_thresh", 40);
  setsaveddvar("ik_roll_limit_max", 100);
  setsaveddvar("ik_yaw_limit_thresh", 20);
  setsaveddvar("ik_yaw_limit_max", 90);
}

house_intro_setup() {
  level.ai_mason_casual = simple_spawn_single("ai_mason_casual", ::init_casual_hero);
  level.ai_mason_casual.animname = "mason";
  level clientnotify("sscig");
  run_scene_first_frame("house_front_door");
  run_scene_first_frame("front_gate");
  run_scene_first_frame("get_bag_door");
  run_scene_first_frame("outro_back_gate");
  level thread run_scene("civ_idle_1");
  level thread run_scene("civ_idle_2");
  level thread run_scene("civ_idle_3");
  level thread run_scene("civ_idle_4");
  level thread run_scene("civ_idle_5");
  m_gringo_graffiti = getent("m_gringo_graffiti", "targetname");
  m_gringo_graffiti hide();
  level.player init_player();
  exploder(1001);
  level thread get_skinner_ai();
}

get_skinner_ai() {
  flag_wait("mason_greets_mcknight_started");
  level.ai_skinner_casual = getent("skinner_ai", "targetname");
}

init_player() {
  self allowjump(0);
  self allowsprint(0);
  self hide_hud();
  setsaveddvar("vehicle_riding", "0");
  self thread take_and_giveback_weapons("house_event_end");
  self thread player_walk_speed_adjustment(level.ai_mason_casual, "player_outro_started", 128, 256, 0.3, 0.65);
}

init_casual_hero() {
  self endon("death");
  self make_hero();
  self gun_remove();
  self.ignoreme = 1;
  self.ignoreall = 1;
}

street_fail_condition() {
  level endon("player_opened_shed");
  t_fail_player = getent("fail_player", "targetname");

  while(true) {
    if(!self istouching(t_fail_player))
      missionfailedwrapper();

    wait 0.05;
  }
}

house_warn_player_logic() {
  level endon("player_opened_shed");

  while(true) {
    if(!level.player istouching(self)) {
      screen_message_create(&"PANAMA_STREET_WARNING");
      wait 3;
      screen_message_delete();
    }

    wait 0.05;
  }
}

house_clean_up_and_reset() {
  level notify("hat_off");
  a_house_vehicles = getentarray("house_vehicles", "script_noteworthy");

  foreach(vehicle in a_house_vehicles) {
    if(isDefined(vehicle)) {
      vehicle.delete_on_death = 1;
      vehicle notify("death");

      if(!isalive(vehicle))
        vehicle delete();
    }
  }

  a_ai = getaiarray();

  foreach(ai in a_ai)
  ai delete();

  a_house_triggers = getentarray("house_trigger", "script_noteworthy");

  foreach(t_house in a_house_triggers)
  t_house delete();

  flag_wait("house_event_end");
  level.player setmovespeedscale(1);
  level.player allowsprint(1);
  level.player allowjump(1);
  level.player show_hud();
  level.player notify("house_event_end");
}

player_exits_hummer() {
  vh_player_hummer = getent("vh_player_humvee", "targetname");
  vh_player_hummer veh_toggle_tread_fx(0);
  vh_player_hummer veh_toggle_exhaust_fx(0);
  vh_player_hummer attach("veh_iw_hummer_win_xcam", "front_door_left_jnt");
  wait 0.3;
  turn_on_reflection_cam("extra_cam_humvee");
  level thread house_drive_by();
  level thread run_scene("player_exits_hummer_xcam");
  level thread run_scene("mason_sits_hummer");
  m_nocap_hair = get_model_or_models_from_scene("player_exits_hummer_xcam", "reflection_woods");
  m_nocap_hair attach("c_usa_milcas_woods_hair", "J_HEAD");
  level thread run_scene("player_exits_hummer");
  wait 6;
  m_nocap_hair detach("c_usa_milcas_woods_hair", "J_HEAD");
  m_nocap_hair attach("c_usa_milcas_woods_hair_cap", "J_HEAD");
  scene_wait("player_exits_hummer");
  vh_player_hummer detach("veh_iw_hummer_win_xcam", "front_door_left_jnt");
  turn_off_reflection_cam("extra_cam_humvee");
}

house_drive_by() {
  wait 5.5;
  vh_hatch = spawn_vehicle_from_targetname("pan_truck");
  vh_hatch setmovingplatformenabled(1);
  vh_hatch hidepart("tag_glass_left_front");
  vh_hatch thread go_path(getvehiclenode("drive_by_path", "targetname"));
  vh_hatch thread truck_play_music();
  level thread run_scene("gringo_driveby");
  wait 3;
  vh_truck_driveway = getent("truck_driveway", "targetname");
  vh_truck_driveway thread go_path(getvehiclenode("start_driveway", "targetname"));
  wait 13;
  level thread ambient_neighborhood_vehicles();
}

truck_play_music() {
  music_ent = spawn("script_origin", self.origin);
  music_ent playloopsound("mus_intro_truck");
  music_ent linkto(self);
}

ambient_neighborhood_vehicles() {
  level endon("player_at_front_gate");

  while(true) {
    if(randomint(3) == 0)
      vh_ambient = "pan_hatchback";
    else if(randomint(3) == 1)
      vh_ambient = "pan_van";
    else
      vh_ambient = "pan_truck";

    if(randomint(4) == 0)
      nd_start = getvehiclenode("start_sideroad_1", "targetname");
    else if(randomint(4) == 1)
      nd_start = getvehiclenode("start_sideroad_2", "targetname");
    else if(randomint(4) == 2)
      nd_start = getvehiclenode("start_sideroad_3", "targetname");
    else
      nd_start = getvehiclenode("start_sideroad_4", "targetname");

    vh_car = spawn_vehicle_from_targetname(vh_ambient);
    vh_car thread go_path(nd_start);
    wait(randomfloatrange(2.5, 4.5));
  }
}

house_events() {
  flag_set("house_meet_mason");
  autosave_by_name("house_start");
  house_event_front();
  house_event_walk_to_shed();
  house_event_backyard();
  house_event_exit();
}

house_event_front() {
  vh_mason_hummer = getent("mason_hummer", "targetname");
  vh_mason_hummer thread turn_off_mason_hummer();
  level thread start_mcknight_arguing_vo();
  trigger_wait("trig_mason_greet");
  flag_set("house_follow_mason");
  level thread after_meeting_mason_driveby();
  level thread house_frontyard_obj();
  stop_exploder(1001);
  wait 0.05;
  exploder(1002);
  level thread run_scene("mason_greets_mcknight");
  level.player say_dialog("mason_002", 2);
  level.player say_dialog("you_too_alex_004", 4.5);
  scene_wait("mason_greets_mcknight");
  level thread mason_front_gate_nag();
  level thread run_scene("mason_wait_gate");
}

after_meeting_mason_driveby() {
  wait 8;
  pickup = spawn_vehicle_from_targetname("pickup_drive_by_after_mason");
  pickup setmovingplatformenabled(1);
  pickup thread go_path(getvehiclenode("start_drive_by_after_mason", "targetname"));
}

house_event_walk_to_shed() {
  trigger_wait("trig_front_gate");
  flag_set("player_at_front_gate");
  m_front_gate_clip = getent("m_front_gate_clip", "targetname");
  m_front_gate_clip moveto(m_front_gate_clip.origin - vectorscale((0, 0, 1), 128.0), 0.05);
  level thread run_scene("squad_to_backyard");
  level thread run_scene("front_gate");
  level thread open_front_gate_clip();
  level.mason = get_ais_from_scene("squad_to_backyard", "mason");
  level.mason attach("p6_anim_beer_can", "tag_weapon_left");
  level.mcknight attach("p6_anim_beer_can", "tag_weapon_left");
  m_front_gate_clip thread front_gate_close_wait();
  level thread shed_door_wait();
  level.player thread say_dialog("maso_hey_mcknight_you_g_0", 8);
  stop_exploder(1002);
  wait 0.05;
  exploder(1003);
}

open_front_gate_clip() {
  wait 1.5;
  front_gate_clip = getent("backyard_gate_clip", "targetname");
  front_gate_clip rotateyaw(110, 1.2);
  level waittill("player_opened_shed");
  front_gate_clip delete();
}

increase_player_speed_after_dog_leaves() {
  wait 16;
  iprintlnbold("done");
  level.player.n_speed_scale_min = 0.35;
  level.player.n_speed_scale_max = 0.65;
}

house_event_backyard() {
  trigger_wait("trig_use_shed_door");
  stop_exploder(1002);
  level thread maps\_audio::switch_music_wait("PANAMA_INTRO", 17);
  flag_set("player_opened_shed");
  turn_on_reflection_cam("reflection_cam");
  m_shed_door_extra = getent("m_mirrored_shed_door", "targetname");
  m_shed_door_extra delete();
  level thread run_scene("reflection_woods_grabs_bag");
  level thread run_scene("reflection_woods_grabs_bag_door");
  level thread run_scene("get_bag_door");
  level thread run_scene("get_bag");
  wait 5;
  turn_off_reflection_cam("reflection_cam");
  scene_wait("get_bag");
  flag_set("player_frontyard_obj");
  run_scene_first_frame("get_bag_door");
  level thread paint_spray();
  level thread run_scene("leave_table");
  level.mason detach("p6_anim_beer_can", "tag_weapon_left");
  level thread run_scene("masons_beer_loop");
  level thread mason_mcknight_wait_at_gate();
  level thread gringo_spraypaint_vo();
}

mason_mcknight_wait_at_gate() {
  level endon("house_player_at_exit");
  scene_wait("leave_table");
  run_scene("leave_table_wait_VO");
  level thread run_scene("leave_table_wait");
}

house_event_exit() {
  trigger_wait("trig_exit_gate");
  flag_set("house_player_at_exit");
  setmusicstate("PANAMA_GATE_OPENED");
  m_gringo_graffiti = getent("m_gringo_graffiti", "targetname");
  m_gringo_graffiti show();
  delay_thread(6, ::flag_set, "show_introscreen_title");
  level thread house_end_flag();
  level thread run_scene_and_delete("outro_back_gate", 1);
  level notify("stop_painting");
  level.player startcameratween(1);
  level thread run_scene_and_delete("player_outro", 1);
  level thread hide_beer_can();
  flag_wait("player_outro_started");
  ai_tagger = getent("gringo_tagger_ai", "targetname");
  ai_tagger attach("p_glo_spray_can", "tag_weapon_left");
  level thread fade_out_house_end();
  scene_wait("player_outro");
  run_scene_first_frame("zodiac_approach_player");
  run_scene_first_frame("zodiac_approach_mason");
  run_scene_first_frame("zodiac_approach_seals");
  run_scene_first_frame("zodiac_approach_seals2");
  run_scene_first_frame("zodiac_approach_boat");
}

hide_beer_can() {
  level waittill("player_outro_started");
  beer_can = get_model_or_models_from_scene("player_outro", "beer");
  beer_can hide();
}

#using_animtree("player");

fade_out_house_end() {
  anim_length = getanimlength( % ch_pan_01_07_gringos_player);
  wait(anim_length - 2.1);
  level notify("hat_off");
  level thread screen_fade_out(2);
  flag_wait("movie_started");
  wait 1.5;
  screen_fade_in(1);
}

turn_off_mason_hummer() {
  trigger_wait("trig_turn_off_mason_car");
  level.hummersoundent stoploopsound(0.25);
  level.hummersoundent playsound("evt_mason_vehicle_idle_stop");
  self veh_toggle_tread_fx(0);
  self veh_toggle_exhaust_fx(0);
  wait 4;
  level.hummersoundent delete();
}

front_gate_close_wait() {
  trigger_wait("trig_use_shed_door");
  run_scene_first_frame("front_gate");
  m_front_door_open_clip = getent("front_gate_open", "targetname");
  m_front_door_open_clip delete();
  self moveto(self.origin + vectorscale((0, 0, 1), 128.0), 0.05);
}

shed_door_wait() {
  level endon("player_opened_shed");
  scene_wait("squad_to_backyard");
  run_scene("wait_table_nag");
  level thread run_scene("wait_table");
}

house_end_flag() {
  flag_wait("player_outro_started");
  run_scene_first_frame("house_end_flag");
  level waittill("start_flag");
  run_scene("house_end_flag");
}

turn_on_reflection_cam(str_extra_cam) {
  setsaveddvar("r_extracam_custom_aspectratio", 1.38636);
  sm_cam_ent = getent(str_extra_cam, "targetname");
  level.e_tag_origin = spawn("script_model", sm_cam_ent.origin);
  level.e_tag_origin setmodel("tag_origin");
  level.e_tag_origin.angles = sm_cam_ent.angles;
  level.e_tag_origin setclientflag(1);
}

turn_off_reflection_cam(str_extra_cam) {
  sm_cam_ent = getent(str_extra_cam, "targetname");
  level.e_tag_origin clearclientflag(1);
  level.e_tag_origin delay_thread(2, ::self_delete);
  sm_cam_ent delay_thread(2, ::self_delete);
}

skinner_wave_us_back(ai_mason) {
  end_scene("skinner_jane_argue_loop");
  level thread house_frontyard_obj();
  level thread run_scene("house_front_door");
  run_scene("skinner_waves_us_back");
}

house_frontyard_obj() {
  wait 10;
  flag_set("house_front_door_obj_done");
  wait 6;
  flag_set("house_front_gate_obj");
}

mason_front_gate_nag() {
  level endon("player_at_front_gate");
  add_vo_to_nag_group("front_gate_nag", level.ai_mason_casual, "we_should_make_thi_007");
  add_vo_to_nag_group("front_gate_nag", level.ai_mason_casual, "for_the_sake_of_sk_008");
  add_vo_to_nag_group("front_gate_nag", level.ai_mason_casual, "maso_come_on_frank_0");
  wait 5;
  level thread start_vo_nag_group_flag("front_gate_nag", "player_at_front_gate", 8);
}

shed_door_nag() {
  level endon("player_opened_shed");
  add_vo_to_nag_group("shed_door_nag", level.ai_skinner_casual, "come_on_woods__w_017");
  level thread start_vo_nag_group_flag("shed_door_nag", "player_opened_shed", 16, 3, 0, 3);
}

exit_gate_nag() {
  level endon("house_player_at_exit");
  add_vo_to_nag_group("exit_gate_nag", level.ai_skinner_casual, "hey_woods__what_a_029");
  add_vo_to_nag_group("exit_gate_nag", level.ai_skinner_casual, "come_on_030");
  level thread start_vo_nag_group_flag("exit_gate_nag", "house_player_at_exit", 16, 3, 0, 3);
}

toggle_hat_overlay() {
  overlay = newclienthudelem(level.player);
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("ballcap_panama_overlay", 640, 480);
  overlay.splatter = 1;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.foreground = 0;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  level waittill("hat_off");
  overlay destroy();
}

player_woods_dialog() {
  level.player thread say_dialog("mason_002");
}

paint_spray() {
  paintent = spawn("script_origin", (24362, -20164, 56));
  paintent playloopsound("evt_spray_paint_loop");
  level waittill("stop_painting");
  paintent stoploopsound(0.5);
  paintent delete();
}

start_mcknight_arguing_vo() {
  spawner = getent("skinner", "targetname");
  level.mcknight = simple_spawn_single("skinner");
  level.mcknight.animname = "skinner";
  level.mcknight forceteleport(spawner.origin, spawner.angles);
  skinner_vo = getent("skinner_vo", "targetname");
  skinner_vo say_dialog("mckn_honey_you_need_to_0", 0, 1);
  skinner_vo say_dialog("jane_i_am_calm_0", 0, 1);
  flag_wait("house_follow_mason");
  wait 5;
  skinner_vo playsound("fly_pan_house_start");
  skinner_vo say_dialog("jane_five_years_mark_w_0", 0, 1);
}

mcknight_close_the_door_argument_vo(guy) {
  skinner_vo = getent("skinner_vo", "targetname");
  skinner_vo say_dialog("mckn_family_i_thought_th_0", 0, 1);
  skinner_vo say_dialog("jane_it_s_about_everythin_0", 0, 1);
  skinner_vo playsound("fly_pan_house_end");
  skinner_vo say_dialog("jane_i_need_something_mor_0", 0, 1);
  skinner_vo say_dialog("jane_it_s_not_enough_mar_0", 0, 1);
}

#using_animtree("generic_human");

gringo_spraypaint_vo() {
  level endon("player_outro_started");
  time = getanimlength( % ch_pan_01_06_intro_backyard_leave_mason);
  wait(time - 10);
  m_gringo_graffiti = getent("m_gringo_graffiti", "targetname");
  m_gringo_graffiti say_dialog("tee1_hurry_it_up_0", 3, 1);
  m_gringo_graffiti say_dialog("tee2_okay_okay_0", 2, 1);
  m_gringo_graffiti say_dialog("tee1_that_s_good_come_0", 2, 1);
  m_gringo_graffiti say_dialog("tee2_go_go_go_0", 1, 1);
}