/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\frontend.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\war_room_util;
#include maps\frontend_util;
#include maps\_music;
#include maps\frontend_fx;
#include maps\_load;
#include maps\frontend_amb;
#include maps\frontend_anim;
#include maps\_patrol;
#include maps\createart\frontend_art;
#include maps\_objectives;
#include maps\_endmission;

main() {
  maps\frontend_fx::main();
  frontend_precache();
  maps\_load::main();
  maps\frontend_amb::main();
  maps\frontend_anim::main();
  maps\_patrol::patrol_init();
  level thread maps\createart\frontend_art::main();
  frontend_init_common();
  frontend_flag_init();
  setup_objectives();
  fade_out(0);
  hide_holo_table_props();
  show_holotable_fuzz(1);
  level thread watch_for_lockout_screen();
  level thread frontend_run_scene();
  level thread frontend_watch_resume();
  wait_for_first_player();
  level thread level_player_init();
}

setup_objectives() {
  level.obj_war_room = register_objective(&"FRONTEND_REPORT_TO_WAR_ROOM");
  level thread maps\_objectives::objectives();
}

frontend_flag_init() {
  flag_init("lockout_screen_passed");
  flag_init("bootup_sequence_done_first_time");
  flag_init("lockout_screen_skipped");
  flag_init("lockout_screen_skipped_freeroam");
  flag_init("strikeforce_stats_loaded");
  flag_init("frontend_scene_ready");
  flag_init("briefing_active");
  flag_init("save_complete");
}

frontend_precache() {
  precacheshader("webm_720p");
  precachemodel("p6_anim_sf_tablet");
  precachemodel("p6_hologram_so_base_map");
  precachemodel("p6_hologram_so_target_bldg_01");
  precachemodel("p6_hologram_so_target_bldg_02");
  precachemodel("p6_hologram_so_target_bldg_03");
  precachemodel("p6_hologram_so_target_bldg_04");
  precachemodel("p6_hologram_so_target_bldg_05");
  precachemodel("p6_hologram_so_target_rock_01");
  precachemodel("p6_hologram_so_enter_path");
  precachemodel("p6_hologram_so_exit_path");
  precachemodel("p6_anim_hologram_vtol_combined");
  precachemodel("p6_anim_resume");
  precachemodel("p6_sunglasses");
  precachemodel("p6_hologram_av_combined");
  precachemodel("p6_hologram_av2_combined");
  precachemodel("p6_hologram_hack_device");
  precachemodel("p6_hologram_missile");
  precachemodel("p6_hologram_af_base_map");
  precachemodel("p6_hologram_af_path_arrow");
  precachemodel("p6_hologram_quadrotor_combined");
  precachemodel("p6_hologram_vtol_combined");
  precachemodel("p6_hologram_asd_combined");
  precachemodel("p6_hologram_cougar_combined");
  precachemodel("p6_hologram_zhao_bust");
  precachemodel("p6_hologram_zhao_text_01");
  precachemodel("p6_hologram_zhao_text_02");
  precachemodel("p6_hologram_world_map_globe");
  precachemodel("p6_hologram_dr_base_map");
  precachemodel("p6_hologram_dr_computer");
  precachemodel("p6_hologram_dr_dish");
  precachemodel("p6_hologram_dr_roof");
  precachemodel("p6_hologram_dr_tank");
  precachemodel("p6_hologram_dr_transformer");
  precachemodel("c_usa_cia_frnd_viewbody_vson");
  precachemodel("c_usa_cia_masonjr_viewbody_vson_ui3d");
  precachemodel("c_usa_cia_frnd_viewbody_vsoff");
  precachestring(&"frontend_screen");
  precachestring(&"toggle_glasses");
  precachestring(&"start_credits");
  precachestring(&"stop_credits");
  precachestring(&"frontend_restore");
  precachestring(&"frontend_restore2");
  precachestring(&"leave_campaign2");
  precachestring(&"intro_complete");
  precachestring(&"frontend_player_connected");
  precachestring(&"show_skip_prompt");
  precachestring(&"cm_activate");
  precachemenu("lockout");
  precachemenu("menu_close");
  precachemenu("campaign_state");
  precachemenu("luisystem");
  precachemenu("launchlevel");
}

do_stats() {
  flag_wait_any("lockout_screen_passed", "lockout_screen_skipped", "lockout_screen_skipped_freeroam");
  level_index = 1;
  max_index = int(tablelookup("sp/levelLookup.csv", 0, "map_count", 1));

  while(level_index < max_index) {
    levelname = tablelookup("sp/levelLookup.csv", 0, level_index, 1);
    level thread maps\_endmission::check_for_achievements_frontend(levelname);
    level_index++;
  }

  player = level.player;

  if(isDefined(player) && player hascompletedallgamechallenges())
    player giveachievement_wrapper("SP_ALL_CHALLENGES_IN_GAME");
}

level_player_init() {
  on_player_connect();
  level.player freezecontrols(1);
  wait_network_frame();
  wait_network_frame();
  setfirstmusicstate();
  level thread do_stats();

  if(frontend_just_finished_rts()) {
    setdvarint("ui_dofrontendsave", 1);
    level thread turn_on_glasses(0);
  } else
    level thread turn_on_glasses(1);

  level.player thread listen_for_campaign_state_change();
  level.player thread listen_for_luisystem_messages();
  level.player thread listen_for_launchlevel_messages();
  visionsetnaked("sp_frontend_bridge", 0.0);

  if(level.ps3) {
    if(getdvar(#"ui_mapname") != "credits")
      frontend_do_save();
  } else
    frontend_do_save();

  load_gump("frontend_gump_sf_a");

  frontend_setup_devgui();
}

setfirstmusicstate() {
  if(!flag("lockout_screen_skipped") && !flag("lockout_screen_skipped_freeroam") && !flag("lockout_screen_passed"))
    setmusicstate("FRONT_END_START");
  else
    setmusicstate("FRONT_END_MAIN");
}

frontend_init_common() {
  get_level_era();
  holo_table_system_init();
  level.e_player_align = getent("player_align_node", "targetname");
  level.m_rts_warmap_offset = [];
  level.m_rts_warmap_offset["so_rts_mp_dockside"] = (0.0, -0.3, 1.0);
  level.m_rts_warmap_offset["so_rts_afghanistan"] = (0.0, -0.3, 1.0);
  level.m_rts_warmap_offset["so_rts_mp_drone"] = (0.0, -0.3, 1.0);
  level.m_rts_territory = [];
  level.m_rts_territory["so_rts_mp_dockside"] = "iran";
  level.m_rts_territory["so_rts_afghanistan"] = "afghanistan";
  level.m_rts_territory["so_rts_mp_drone"] = "india";
  level.m_rts_map_id = [];
  level.m_rts_map_id["so_rts_mp_dockside"] = 2;
  level.m_rts_map_id["so_rts_afghanistan"] = 0;
  level.m_rts_map_id["so_rts_mp_drone"] = 1;
  level.m_rts_city_tag = [];
  level.m_rts_city_tag["so_rts_mp_dockside"] = "tag_fx_keppel";
  level.m_rts_city_tag["so_rts_afghanistan"] = "tag_fx_kabul";
  level.m_rts_city_tag["so_rts_mp_drone"] = "tag_fx_pradesh";
  level.m_rts_city_tag["so_rts_mp_socotra"] = "tag_fx_socotra";
  level.m_rts_city_tag["so_rts_mp_overflow"] = "tag_fx_pakistan";
  add_global_spawn_function("axis", ::no_grenade_bag_drop);
  trigger_off("table_interact_trigger");
  table_trig = getent("table_interact_trigger", "targetname");
  table_trig sethintstring(&"FRONTEND_USE_STRIKEFORCE");
  level.m_drone_collision = getentarray("drone_collision", "targetname");
  level thread frontend_init_shaders();
  globe = build_globe();
  float_pos = getent("holo_table_floating", "targetname");
  globe.origin = float_pos.origin;
}

frontend_init_shaders() {
  wait_for_first_player();
  clock_list = getentarray("world_clock", "targetname");

  foreach(clock in clock_list) {
    clock ignorecheapentityflag(1);
    clock setclientflag(12);
  }

  monitor_list = getentarray("world_map", "targetname");

  foreach(monitor in monitor_list) {
    monitor ignorecheapentityflag(1);
    monitor setclientflag(13);
  }

  wait_network_frame();
  refresh_war_map_shader();
}

on_player_connect() {
  wait_network_frame();
  luinotifyevent(&"frontend_player_connected");
  level.player takeallweapons();
  level.player disableweapons();
  level.player allowpickupweapons(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player init_viewarm();
  level.m_rts_stats = [];
  level.m_rts_stats["so_rts_mp_dockside"] = "SO_WAR_SINGAPORE_SUCCESS";
  level.m_rts_stats["so_rts_afghanistan"] = "SO_WAR_AFGHANISTAN_SUCCESS";
  level.m_rts_stats["so_rts_mp_drone"] = "SO_WAR_DRONE_SUCCESS";
  level.m_rts_stats["so_rts_mp_socotra"] = "SO_WAR_SOCOTRA_SUCCESS";
  level.m_rts_stats["so_rts_mp_overflow"] = "SO_WAR_PAKISTAN_SUCCESS";
  level.m_phase_stats[1] = "SO_WAR_HUB_ONE_INTRO";
  level.m_phase_stats[2] = "SO_WAR_HUB_TWO_INTRO";
  level.m_phase_stats[3] = "SO_WAR_HUB_THREE_INTRO";
  level.m_phase_stats[4] = "SO_WAR_PAKISTAN_INTRO";
  flag_set("strikeforce_stats_loaded");
}

no_grenade_bag_drop() {
  level.nextgrenadedrop = 100000;
}