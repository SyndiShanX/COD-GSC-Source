/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_security.gsc
**************************************/

#include common_scripts\utility;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\_utility;
#include maps\_music;
#include maps\blackout_defend;
#include maps\blackout_util;
#include maps\blackout_anim;
#include maps\blackout_bridge;
#include maps\createart\blackout_art;

skipto_mason_lower_level() {
  maps\blackout_anim::scene_security_level();
  skipto_teleport_players("player_skipto_mason_lower_level");
  level thread breadcrumb_and_flag("security_breadcrumb", level.obj_restore_control, "at_defend_objective");
  level thread lower_level_entry_battle();
  level thread maps\blackout_bridge::scene_ziptied_pmcs();
}

skipto_mason_security() {
  maps\blackout_anim::scene_security_level();
  skipto_teleport_players("player_skipto_mason_security");
  level thread break_sensitive_windows();
  level thread breadcrumb_and_flag("cctv_breadcrumb", level.obj_restore_control, "player_at_cctv_room");
}

skipto_mason_cctv() {
  skipto_teleport_players("player_skipto_mason_cctv");
  spawn_manager_kill("sm_cctv_guards");
}

run_mason_lower_level() {
  level thread ai_push_player_on_double_stairs();
  add_spawn_function_veh("security_turret", ::security_turret_think);
  level thread security_ambience();
  level thread dialog_lower_level_start();
  flag_set("distant_explosions_on");
  level thread scene_window_throw();
  trigger_wait("double_stairs_mid");
  end_sea_cowbell();
  end_bridge_launchers();
  trigger_wait("double_stairs_bottom");
  flag_set("reached_lower_stairs_bottom");
  autosave_by_name("security_offices");
  level thread harper_takeover_turret();
  level thread moment_stair_shoot();
  level thread set_flag_on_ai_group_clear("lower_decks_wave_2_start", "lower_decks_wave_1");
  level thread use_trigger_on_flag("trigger_stair_shoot", "lower_decks_wave_2_start");
  level thread break_sensitive_windows();
  level thread dialog_lower_level_turret_hallway();
  flag_wait("at_defend_objective");
  level thread breadcrumb_and_flag("cctv_breadcrumb", level.obj_restore_control, "player_at_cctv_room");
  clean_up_mason_lower_level();
}

ai_push_player_on_double_stairs() {
  level endon("at_defend_objective");
  t_push = get_ent("lower_deck_double_stairs_push_trigger", "targetname");

  while(isDefined(t_push)) {
    t_push waittill("trigger");

    while(level.player istouching(t_push)) {
      toggle_friendly_push(1);
      wait 3;
    }

    toggle_friendly_push(0);
  }
}

toggle_friendly_push(b_can_push) {
  a_guys = getaiarray("allies");

  foreach(guy in a_guys)
  guy pushplayer(b_can_push);
}

clean_up_mason_lower_level() {
  delete_emergency_light("cic_turret_room_light");
  a_to_delete = array("familiar_face_door", "familiar_face_door_clip", "war_holo_table", "P6_hologram_city_buildings", "bridge_turret_box", "bridge_console_bink", "bridge_console_dark", "lower_deck_double_stairs_push_trigger");
  level thread clean_up_ent_array(a_to_delete);
}

dialog_lower_level_start() {
  a_generic_enemy = [];
  a_generic_enemy[a_generic_enemy.size] = "cub2_get_in_there_0";
  a_generic_enemy[a_generic_enemy.size] = "cub1_stay_behind_the_pipe_0";
  a_generic_enemy[a_generic_enemy.size] = "cub0_cut_them_down_0";
  level thread start_combat_vo_group_enemy(a_generic_enemy, "reached_lower_stairs_bottom");
}

dialog_lower_level_turret_hallway() {
  a_generic_enemy = [];
  a_generic_enemy[a_generic_enemy.size] = "cub0_i_hear_movement_0";
  a_generic_enemy[a_generic_enemy.size] = "cub1_they_re_pushing_thro_0";
  a_generic_enemy[a_generic_enemy.size] = "cub2_hit_them_now_0";
  a_conditional_enemy = [];
  a_conditional_enemy[a_conditional_enemy.size] = "cub1_stay_in_cover_let_0";
  level thread start_combat_vo_group_enemy(a_generic_enemy, "mason_security_started", a_conditional_enemy, "security_turret_disabled");
  flag_wait("security_turret_disabled");
  queue_dialog_enemy("cub0_turret_s_down_retu_0", 0);

  if(flag("security_turret_hacked")) {
    a_enemy_react = [];
    a_enemy_react[a_enemy_react.size] = "cub0_watch_the_auto_gun_0";
    a_enemy_react[a_enemy_react.size] = "cub2_taking_fire_0";
    a_enemy_react[a_enemy_react.size] = "cub1_get_out_of_there_0";
    a_enemy_react[a_enemy_react.size] = "cub3_destroy_the_turret_0";
    a_enemy_react[a_enemy_react.size] = "cub0_where_the_hell_is_he_0";
    level thread start_combat_vo_group_enemy(a_enemy_react, "mason_security_started");
  }
}

break_sensitive_windows() {
  flag_wait("start_sensitive_room");
  autosave_by_name("start_sensitive_room");
  a_s_bullets = getstructarray("sensitive_magic_bullet", "targetname");

  foreach(s_bullet in a_s_bullets) {
    s_bullet_end = getstruct(s_bullet.target, "targetname");

    for(i = 0; i < 5; i++) {
      magicbullet("xm8_sp", s_bullet.origin, s_bullet_end.origin);
      wait 0.05;
    }
  }

  s_extinguisher = getstruct("sensitive_fire_extinguisher", "targetname");
  radiusdamage(s_extinguisher.origin, 32, 200, 100);
}

multipath_trigger_cleanup(str_trigger_name, str_key) {
  if(!isDefined(str_key))
    str_key = "targetname";

  trigger_wait(str_trigger_name, str_key);
  wait 0.5;
  triggers = getentarray(str_trigger_name, str_key);

  foreach(trigger in triggers)
  trigger trigger_off();
}

run_mason_security() {
  level thread sensitive_room_pipes_show();
  level thread maps\blackout_defend::init_doors();
  level thread init_doors();
  level thread func_on_ai_group_cleared("lower_deck_hack_turret_group", ::traversal_turn_off_roll_over_44);
  level thread add_posed_corpses("sensitive_room_corpses", "player_in_cctv_room");
  add_spawn_function_veh("defend_turret", ::sensitive_turret_hacked);
  level thread hackable_turret_enable("defend_turret");
  flag_set("distant_explosions_on");
  trigger_wait("trigger_sensitive_room");
  flag_set("mason_security_started");
  level thread dialog_sensitive_room();
  level thread ambience_sensitive_room();
  maps\createart\blackout_art::vision_set_sensitive_room();
  level thread door_breach_left();
  level thread door_breach_right();
  level thread sm_sensitive_room_start_think();
  level thread sensitive_room_combat_start();
  delay_thread(20, ::flag_set, "sensitive_door_breach_left");
}

traversal_turn_off_roll_over_44() {
  nd_traversal = getnode("roll_over_cover_traversal", "targetname");
  setenablenode(nd_traversal, 0);
}

security_turret_think() {
  self waittill("death");
  flag_set("security_turret_disabled");
  flag_set("security_turret_dead");
}

sensitive_room_combat_start() {
  waittill_ai_group_amount_killed("sensitive_room_start_room_guys", 3);
  flag_set("sensitive_door_breach_left");
}

sm_sensitive_room_start_think() {
  flag_wait("sensitive_door_breach_left");
  spawn_manager_enable("sm_sensitive_room_start");
}

ambience_sensitive_room() {
  set_light_flicker_fx_area(70600);
  flag_wait("player_in_sensitive_room");
  set_light_flicker_fx_area(70700);
}

dialog_sensitive_room() {
  level.player queue_dialog("brig_section_we_re_out_0");
  level.player queue_dialog("brig_our_only_chance_is_t_0");
  level.player queue_dialog("sect_that_s_suicide_0");
  level.player queue_dialog("brig_section_do_you_cop_0", 0.5);
  level.player queue_dialog("sect_admiral_briggs_1", 0.5);
  level.player queue_dialog("sect_dammit_comms_are_do_0", 0.75);
  dialog_combat_sensitive_room();
}

dialog_combat_sensitive_room() {
  a_generic_friendly = [];
  a_generic_friendly[a_generic_friendly.size] = "nav1_return_fire_0";
  a_generic_friendly[a_generic_friendly.size] = "nav3_stay_in_cover_0";
  a_generic_friendly[a_generic_friendly.size] = "nav0_we_re_outnumbered_0";
  a_generic_friendly[a_generic_friendly.size] = "nav1_secure_this_deck_0";
  a_generic_friendly[a_generic_friendly.size] = "nav2_don_t_let_them_reach_0";
  a_generic_friendly[a_generic_friendly.size] = "nav3_seal_off_the_hallway_0";
  a_conditional_friendly = [];
  a_conditional_friendly[a_conditional_friendly.size] = "nav0_take_out_that_turret_0";
  level thread start_combat_vo_group_friendly(a_generic_friendly, "player_at_cctv_room", a_conditional_friendly, "sensitive_turret_disabled");
  a_generic_enemy = [];
  a_generic_enemy[a_generic_enemy.size] = "cub0_more_americans_comin_0";
  a_generic_enemy[a_generic_enemy.size] = "cub1_we_need_to_hold_them_0";
  a_generic_enemy[a_generic_enemy.size] = "cub2_hold_the_stairs_0";
  a_generic_enemy[a_generic_enemy.size] = "cub3_don_t_let_them_push_0";
  a_generic_enemy[a_generic_enemy.size] = "cub2_secure_this_deck_0";
  level thread start_combat_vo_group_enemy(a_generic_enemy, "player_at_cctv_room");
  level thread queue_dialog_enemy("cub2_they_re_coming_down_0", 0, "sensitive_room_upstairs_past_turret", "cctv_stairs_approach", 1);
  level thread queue_dialog_ally("nav2_taking_fire_from_the_0", 0, "sensitive_room_stairs_approach", "cctv_stairs_approach", 1);
  level thread queue_dialog_enemy("cub0_they_re_above_us_0", 0, "sensitive_room_upstairs_looking_down", "cctv_stairs_approach", 1);
  level thread queue_dialog_enemy("cub1_fire_through_the_gra_0", 0, "sensitive_room_upstairs_looking_down", "cctv_stairs_approach", 1);
  flag_wait("player_at_cctv_room");
  queue_dialog_enemy("cub3_get_the_security_roo_0", 0);
  queue_dialog_enemy("cub0_it_s_sealed_from_the_0", 1);
}

sensitive_turret_hacked() {
  self endon("death");
  self waittill("turret_hacked");
  flag_set("sensitive_turret_hacked");
  flag_set("sensitive_turret_disabled");
  wait 3;
  spawn_manager_enable("sm_sensitive_turret");
}

run_mason_cctv() {
  maps\blackout_anim::torch_wall_scene();
  maps\blackout_anim::scene_menendez_cctv();
  maps\blackout_anim::mason_arrives_at_cctv_room();
  run_scene_first_frame("torch_wall_panel_first_frame");
  run_scene_first_frame("cctv_security_room_door_opens");
  level thread run_scene_and_delete("cctv_access_computer_guy_loop");
  hackable_turret_enable("defend_turret");
  flag_set("distant_explosions_on");
  set_light_flicker_fx_area(70800);
  retrieve_story_stats();
  checkpoint_respawn_safe_spot_set("player_skipto_mason_security");
  autosave_by_name("goto_cctv_room");
  flag_wait("player_at_cctv_room");
  set_objective(level.obj_restore_control, getent("cctv_door", "targetname").origin);
  waittill_ai_group_ai_count("aigroup_cctv_room", 0);
  level thread cctv_room_door_opens_and_gates_player();
  set_objective(level.obj_restore_control, undefined, "done");
  cctv_trigger = getent("mason_security_feed_trigger", "targetname");
  cctv_trigger trigger_on();
  s_objective_marker = get_struct("objective_marker_cctv_anim_start", "targetname", 1);
  set_objective(level.obj_cctv, s_objective_marker.origin, "");
  trigger_wait("cctv_play_mason_dialog");
  level.player thread queue_dialog("sect_where_are_we_on_the_0");
  cctv_trigger waittill("trigger");
  checkpoint_respawn_safe_spot_clear();
  autosave_now();
  set_objective(level.obj_cctv, s_objective_marker, "delete");
  s_objective_marker structdelete();
  cctv_trigger delete();
  level.player delay_thread(0.1, ::menendez_weapons, "give_menendez_guns");
  level thread briggs_pip_playbackrate();
  level thread run_scene_and_delete("soldier_starts_cutting_vent");
  level.player startcameratween(1);
  level thread run_scene_and_delete("mason_watches_menendez_in_server_room", 1);
  scene_wait("mason_watches_menendez_in_server_room");
  level.extra_cam_surfaces["cctv_left"] hide();
  delete_everyone_not_in_server_room();
  hackable_turret_disable("defend_turret");
  level.player notify("give_menendez_guns");
  cctv_console_bink_stop_cctv();
  clean_up_mason_cctv();
}

clean_up_mason_cctv() {
  delete_emergency_light("staircase_light");
  delete_emergency_light("engine_room_light");
  level thread kill_spawnernum(3);
  level thread kill_spawnernum(4);
  a_to_delete = array("sensitive_room_door_breach_left_clip", "sensitive_room_door_breach_right_clip", "defend_door_right", "defend_door_left", "catwalk_door", "catwalk_door_collision", "defend_turret_box");
  level thread clean_up_ent_array(a_to_delete);
}

cctv_console_bink_stop_playback(b_hide_console) {
  if(!isDefined(b_hide_console))
    b_hide_console = 1;

  m_console_bink = get_ent("khan_screen_bink", "targetname", 1);
  m_console = get_ent("khan_screen_blank", "targetname", 1);
  m_console show();
  m_console_bink show();

  if(isDefined(m_console_bink.n_bink_id))
    stop3dcinematic(m_console_bink.n_bink_id);
}

cctv_console_bink_toggle() {
  m_console_bink = get_ent("khan_screen_bink", "targetname", 1);
  m_console = get_ent("khan_screen_blank", "targetname", 1);
  m_console_bink show();
  m_console hide();
  m_console_bink.n_bink_id_1 = play_movie_on_surface_async("blackout_virus", 1, 0, undefined, undefined, undefined, 1);
  m_console_bink.n_bink_id_2 = play_movie_on_surface_async("blackout_cctv", 1, 0, undefined, undefined, undefined, 1);
}

cctv_console_bink_play_cctv() {
  m_console_bink = get_ent("khan_screen_bink", "targetname", 1);
  stop3dcinematic(m_console_bink.n_bink_id_1);
}

cctv_console_bink_stop_cctv() {
  m_console_bink = get_ent("khan_screen_bink", "targetname", 1);
  stop3dcinematic(m_console_bink.n_bink_id_2);
  onsaverestored_callbackremove(::save_restored_cctv_bink);
}

save_restored_cctv_bink() {
  m_console_bink = get_ent("khan_screen_bink", "targetname", 1);
  m_console = get_ent("khan_screen_blank", "targetname", 1);
  m_console hide();
  m_console_bink show();

  if(!isDefined(level.streaming_binks_restored))
    level.streaming_binks_restored = 0;

  if(!level.streaming_binks_restored) {
    level.streaming_binks_restored = 1;

    if(isDefined(m_console_bink.n_bink_id_1)) {
      stop3dcinematic(m_console_bink.n_bink_id_1);
      wait 0.1;
      m_console_bink.n_bink_id_1 = play_movie_on_surface_async("blackout_virus", 1, 0, undefined, undefined, undefined, 1);
    }

    if(isDefined(m_console_bink.n_bink_id_2)) {
      stop3dcinematic(m_console_bink.n_bink_id_2);
      wait 0.1;
      m_console_bink.n_bink_id_2 = play_movie_on_surface_async("blackout_cctv", 1, 0, undefined, undefined, undefined, 1);
    }

    wait 2;
    level.streaming_binks_restored = undefined;
  }
}

cctv_room_door_opens_and_gates_player() {
  m_origin = get_model_or_models_from_scene("cctv_security_room_door_opens", "cctv_room_door");
  m_door = getent("cctv_door", "targetname");
  m_door.v_original_position = m_door.origin;
  m_door.v_original_angles = m_door.angles;
  m_door linkto(m_origin, "origin_animate_jnt");
  m_door_clip = getent("cctv_door_clip", "targetname");
  flag_wait("player_outside_cctv_room");
  m_door_clip rotateyaw(-110, 1, 0.2, 0.2);
  run_scene_and_delete("cctv_security_room_door_opens");
  level thread turn_on_cctv();
  checkpoint_respawn_safe_spot_clear();
  level thread run_scene_and_delete("cctv_security_room_door_waits");
  flag_wait("player_in_cctv_room");
  setmusicstate("BLACKOUT_PRE_MENENDEZ");
  stop_exploder(1111);
  level.player thread queue_dialog("sect_seal_the_door_0");
  m_door_clip rotateyaw(110, 0.1);
  run_scene_and_delete("cctv_security_room_door_closes");
  m_door.origin = m_door.v_original_position;
  m_door.angles = m_door.v_original_angles;
}

turn_on_cctv() {
  cctv_console_bink_toggle();
  onsaverestored_callback(::save_restored_cctv_bink);
}

dialog_harper_turret() {
  level.player queue_dialog("sect_harper_i_m_pinned_1");
  level.player queue_dialog("sect_hack_the_relay_termi_0");
  level.player queue_dialog("harp_you_got_it_1", 0.6);
}

harper_takeover_turret() {
  if(level.is_harper_alive) {
    trigger_wait("trigger_harper_turret_hack");
    dialog_harper_turret();
    turret = getent("security_turret", "targetname");

    if(isDefined(turret) && isalive(turret)) {
      turret turret_set_team("allies");
      flag_set("security_turret_hacked");
      turret delay_thread(15, ::weaken_ai);
    }

    flag_set("security_turret_disabled");
  }
}

notetrack_server_room_door_guy_torch_fx_start(m_torch) {
  m_torch play_fx("laser_cutter_sparking", undefined, undefined, "stop_torch_fx", 1, "tag_fx");
  m_torch play_fx("fx_laser_cutter_on", undefined, undefined, "stop_torch_fx", 1, "tag_fx");
}

notetrack_server_room_door_guy_torch_fx_stop(m_torch) {
  m_torch notify("stop_torch_fx");
}

notetrack_fade_to_menendez_section(m_player_body) {
  level.player playsound("evt_cctv_transition_in");
  rpc("clientscripts/blackout_amb", "setMenTransSnap");
  screen_fade_out(1);
  wait 2;
  end_scene("mason_watches_menendez_in_server_room");
}

cctv_turn_on_left_screen(m_player_body) {
  scene_security_reboot();
}

cctv_turn_on_right_screen(m_player_body) {
  scene_cctv_taunt_mason();
}

notetrack_cctv_bink_start(m_player_body) {
  cctv_console_bink_play_cctv();
}

delete_everyone_not_in_server_room() {
  everyone = getaiarray("axis", "allies");

  foreach(ai in everyone) {
    if(ai.targetname == "briggs_ai") {
      continue;
    }
    if(ai.targetname == "farid_ai") {
      continue;
    }
    if(ai.targetname == "server_worker_ai") {
      continue;
    }
    if(ai.targetname == "defalco_ai") {
      continue;
    }
    if(ai.targetname == "defalco_standin_ai") {
      continue;
    }
    ai delete();
  }
}

window_throw_glass_break(unfortunate_schlub) {
  ai_thrower = get_ent("window_throw_sailor_ai", "targetname");
  ai_thrower thread say_dialog("nav1_die_you_son_of_a_bi_0");
  window_break_pos = unfortunate_schlub gettagorigin("J_SpineLower");
  radiusdamage(window_break_pos, 64.0, 1000, 800);
  level notify("guy_thrown_out_window");
}

notetrack_window_throw_attach_gun(ai_pmc) {
  ai_pmc gun_switchto(ai_pmc.primaryweapon, "right");
  ai_pmc.temp_weapon = spawn("weapon_" + ai_pmc.primaryweapon, ai_pmc gettagorigin("tag_weapon_right"));
  ai_pmc.temp_weapon.angles = ai_pmc gettagangles("tag_weapon_right");
  ai_pmc.temp_weapon linkto(ai_pmc, "tag_weapon_right");
  ai_pmc gun_switchto(ai_pmc.primaryweapon, "none");
}

notetrack_window_throw_drop_gun(ai_pmc) {
  ai_pmc.temp_weapon unlink();
  ai_pmc.temp_weapon = undefined;
}

scene_window_throw() {
  level thread run_scene_and_delete("window_throw_loop");
  trigger_wait("window_throw_trigger");
  level thread run_scene_and_delete("window_throw");
}

scene_torchcutters() {
  level thread run_scene_and_delete("torchcutters_start");
  wait_network_frame();
  torch_guy = get_ais_from_scene("torchcutters_start")[0];
  torch_guy endon("death");
  torch_guy waittill("goal");
  wait_network_frame();
  torch_guy attach("t6_wpn_laser_cutter_prop", "TAG_WEAPON_LEFT");
  torch_guy thread welding_fx("cctv_mason_after_exit");
  scene_wait("torchcutters_start");
  level thread run_scene_and_delete("torchcutters");
  scene_wait("mason_watches_menendez_in_server_room");
  torch_guy delete();
}

scene_cctv_taunt_mason() {
  origin = getstruct("menendez_start_extracam", "targetname");
  sm_cam_ent = spawn_model("tag_origin", origin.origin, origin.angles);
  sm_cam_ent.targetname = origin.targetname + "_cam_ent";
  level.extra_cam_surfaces["cctv_right"] show();
  sm_cam_ent setclientflag(14);
  level thread system_offline_messages();
  level thread set_force_no_cull_on_actors_during_scene("cctv_third_person");
  level notify("menendez_pip_started");
  run_scene_and_delete("cctv_third_person");
  sm_cam_ent clearclientflag(14);
  level.extra_cam_surfaces["cctv_right"] hide();
  clientnotify("stop_multi_extracam");
}

lower_level_entry_battle() {
  add_spawn_function_group("lower_decks_cqb_guys", "script_noteworthy", ::change_movemode, "cqb_run");
  flag_wait("zipties_scene_started");
  spawn_manager_enable("sm_lower_level_start");
  trigger_wait("lower_level_entry_stairs_trigger");
  level thread maps\blackout_bridge::open_catwalk_door(0);
}

moment_stair_shoot() {
  flag_wait("lower_decks_wave_2_start");
  pmc = simple_spawn_single("stair_shoot_pmc");
  pmc endon("death");
  node = getnode(pmc.target, "targetname");
  pmc.fixednode = 1;
  pmc.ignoreme = 1;
  pmc.dontmelee = 1;
  pmc.attackeraccuracy = 0.0;
  pmc force_goal(node);
  pmc magic_bullet_shield();

  do
    pmc waittill("damage", amount, attacker);
  while(!isDefined(attacker) || !isplayer(attacker));

  pmc stop_magic_bullet_shield();
  run_scene_and_delete("stair_shoot");
}

system_offline_messages() {
  add_visor_text("BLACKOUT_VISOR_REBOOT_1");
  wait 2;
  add_visor_text("BLACKOUT_VISOR_REBOOT_2");
  wait 2;
  add_visor_text("BLACKOUT_VISOR_REBOOT_3");
  wait 2;
  add_visor_text("BLACKOUT_VISOR_REBOOT_4");
}

setup_briggs() {
  self.team = "axis";
  self.ignoreme = 1;
  self.ignoreall = 1;
}

spawn_briggs() {
  briggs_spawner = getent("briggs", "targetname");
  briggs_spawner add_spawn_function(::setup_briggs);
  level.briggs = init_hero_startstruct("briggs", "briggs_meat_shield_start");
  level.briggs gun_switchto(level.briggs.sidearm, "right");
  level.briggs.team = "axis";
}

scene_security_reboot() {
  setsaveddvar("r_extracam_custom_aspectratio", 1.33333);
  clientnotify("start_multi_extracam");
  spawn_briggs();
  level thread run_scene("briggs_pip");
  level thread set_force_no_cull_on_actors_during_scene("briggs_pip", "mason_watches_menendez_in_server_room_done");
  origin = getstruct("pip_glasses_pos", "targetname");
  sm_cam_ent = spawn_model("tag_origin", origin.origin, origin.angles);
  sm_cam_ent.targetname = origin.targetname + "_cam_ent";
  sm_cam_ent setclientflag(11);
  level.extra_cam_surfaces["cctv_left"] show();
  scene_wait("mason_watches_menendez_in_server_room");
  sm_cam_ent clearclientflag(11);
  level.extra_cam_surfaces["cctv_left"] hide();
  a_actors = [];
  a_actors[a_actors.size] = get_model_or_models_from_scene("briggs_pip", "briggs");
  a_actors[a_actors.size] = get_model_or_models_from_scene("briggs_pip", "server_worker");
  array_delete(a_actors);
  delete_scene("briggs_pip");
}

briggs_pip_playbackrate() {
  n_time_player_anim_started = gettime();
  flag_wait("briggs_pip_started");
  a_actors = get_model_or_models_from_scene("briggs_pip");
  anim_briggs = level.scr_anim["briggs"]["briggs_pip"];
  anim_player = level.scr_anim["player_body"]["mason_watches_menendez_in_server_room"];
  n_time_briggs_started = gettime();
  n_briggs_anim_length = getanimlength(anim_briggs);
  n_player_anim_length = getanimlength(anim_player);
  n_notetrack_fade_time = getnotetracktimes(anim_player, "fade")[0] * n_player_anim_length;
  level waittill("menendez_pip_started");
  n_time_menendez_started = gettime();
  n_time_since_player_anim_started = (n_time_menendez_started - n_time_player_anim_started) / 1000;
  n_time_left_until_fade = n_notetrack_fade_time - n_time_since_player_anim_started;
  n_time_left_on_briggs_anim = n_briggs_anim_length - (n_time_menendez_started - n_time_briggs_started) / 1000;
  n_playback_rate = n_time_left_on_briggs_anim / n_time_left_until_fade;

  foreach(actor in a_actors)
  actor setanim(level.scr_anim[actor.animname]["briggs_pip"], 1, 0, n_playback_rate);
}

init_doors() {
}

init_flags() {
  flag_init("start_sensitive_room");
  flag_init("at_defend_objective");
  flag_init("defend_objective_complete");
  flag_init("sensitive_door_breach_left");
  flag_init("player_at_cctv_room");
  flag_init("at_cctv_room");
  flag_init("left_breach_saved");
  flag_init("security_turret_disabled");
  flag_init("security_turret_hacked");
  flag_init("security_turret_dead");
  flag_init("sensitive_turret_disabled");
  flag_init("sensitive_turret_hacked");
  flag_init("mason_security_started");
  flag_init("reached_lower_stairs_bottom");
}

security_ambience() {
  set_light_flicker_fx_area(70400);
  flag_wait("reached_lower_stairs_bottom");
  set_light_flicker_fx_area(70500);
  maps\blackout_util::kill_ambient_models();
  maps\blackout_util::kill_ambient_vehicles();
}