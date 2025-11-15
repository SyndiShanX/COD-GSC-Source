/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\deer_hunt.gsc
*****************************************************/

main() {
  maps\_utility::template_level("deer_hunt");
  maps\createart\deer_hunt_art::main();
  maps\deer_hunt_fx::main();
  maps\deer_hunt_anim::main();
  maps\deer_hunt_precache::main();
  precache_stuff();
  level.current_speed_percent = 1;
  maps\_utility::add_start("intro", maps\deer_hunt_intro::intro_setup, "Intro", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("lobby", ::lobby_entrance, "Lobby Entrance", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("outside", ::outside_start, "Theater Exit", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("street", ::street_start, "Promenade Exit", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("encounter1", ::encounter1_start, "First Encounter", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("encounter2", ::encounter2_start, "Gas Station", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("lariver", ::lariver_start, "L.A. River", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("lariver_defend", ::lariver_defend_start, "L.A. River defend", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("lariver_chopper", ::lariver_nogame_start, "L.A. River - choppers", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("lariver_exit", ::lariver_exit, "LA River exit", undefined, "deer_hunt_intro_tr");
  maps\_utility::add_start("ride", ::ride_start, "Jeep Ride", undefined, "deer_hunt_beach_tr");
  maps\_utility::add_start("house", ::house_start, "Elias' House", undefined, "deer_hunt_beach_tr");
  maps\_utility::set_default_start("intro");
  setup_flags();
  maps\_utility::transient_init("deer_hunt_intro_tr");
  maps\_utility::transient_init("deer_hunt_beach_tr");
  maps\_utility::intro_screen_create(&"DEER_HUNT_INTROSCREEN_LINE_4", & "DEER_HUNT_INTROSCREEN_LINE_2", & "DEER_HUNT_INTROSCREEN_LINE_5");
  maps\_utility::intro_screen_custom_func(::custom_intro_screen_func);
  maps\_utility::intro_screen_custom_timing(0.05, 3);
  level.actionbinds = [];
  maps\deer_hunt_util::registeractionbinding("matv_enter", "+activate", & "DEER_HUNT_MATV_HINT");
  maps\deer_hunt_util::registeractionbinding("matv_enter", "+usereload", & "DEER_HUNT_MATV_HINT_RELOAD");
  maps\deer_hunt_util::registeractionbinding("slide", "+gocrouch", & "DEER_HUNT_SLIDE_CROUCH");
  maps\deer_hunt_util::registeractionbinding("slide", "+stance", & "DEER_HUNT_SLIDE_CROUCH_STANCE");
  maps\deer_hunt_util::registeractionbinding("slide", "+togglecrouch", & "DEER_HUNT_SLIDE_CROUCH_TOGGLE");
  maps\deer_hunt_util::registeractionbinding("slide", "+movedown", & "DEER_HUNT_SLIDE_CROUCH_HOLD");
  maps\deer_hunt_util::registeractionbinding("crouch", "+gocrouch", & "DEER_HUNT_CROUCH");
  maps\deer_hunt_util::registeractionbinding("crouch", "+stance", & "DEER_HUNT_CROUCH_STANCE");
  maps\deer_hunt_util::registeractionbinding("crouch", "+togglecrouch", & "DEER_HUNT_CROUCH_TOGGLE");
  maps\deer_hunt_util::registeractionbinding("crouch", "+movedown", & "DEER_HUNT_CROUCH_HOLD");
  var_0 = maps\deer_hunt_util::getactionbind("slide");
  maps\_utility::add_hint_string("slide_hint", var_0.hint, ::player_slide_check);
  var_1 = maps\deer_hunt_util::getactionbind("crouch");
  maps\_utility::add_hint_string("crouch_hint", var_1.hint, ::player_crouch_check);
  maps\_utility::add_hint_string("laser_hint", & "DEER_HUNT_LASER_HINT", maps\deer_hunt_util::player_is_using_missile_launcher);
  maps\_load::main();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  setup_motion_blur();

  if(!maps\_utility::is_gen4())
    setsaveddvar("sm_sunshadowscale", 0.7);

  maps\deer_hunt_audio::main();
  maps\_drone_deer::init();
  maps\_load::set_player_viewhand_model("viewhands_player_us_rangers");
  maps\_patrol_anims_creepwalk::main();
  maps\_drone_ai::init();
  maps\_patrol_anims_creepwalk::init_creepwalk_archetype();
  setdvarifuninitialized("steve", 0);
  setdvarifuninitialized("ai_debug_count", 0);
  setsaveddvar("r_HudOutlineEnable", 1);
  var_2 = (-13868.7, 13216.9, -466.8);
  badplace_cylinder("axis", 0, var_2, 300, 100, "axis");
  maps\_utility::add_global_spawn_function("axis", ::gun_inventory);
  maps\_utility::add_global_spawn_function("allies", ::gun_inventory);
  thread objectives();

  if(maps\_utility::is_gen4())
    setsaveddvar("r_HudOutlineWidth", 3);
  else
    setsaveddvar("r_HudOutlineWidth", 2);

  thread level_music();
  maps\deer_hunt_util::drone_civs_init();
  thread maps\deer_hunt_intro::player_control();
}

setup_motion_blur() {
  if(maps\_utility::is_gen4()) {
    if(maps\deer_hunt_util::game_is_pc()) {
      return;
    }
    setsaveddvar("r_mbEnable", 0);
  }
}

custom_intro_screen_func() {
  maps\_hud_util::start_overlay("black");
  thread maps\_utility::stylized_center_text(&"DEER_HUNT_INTROSCREEN_YEARSLATER", 3.5);
  maps\_utility::delaythread(2, ::custom_intro_radio_sequence);
  wait 4;
  common_scripts\utility::flag_wait("intro_radio_complete");
  common_scripts\utility::flag_set("start_intro_scene");
  thread maps\_introscreen::introscreen(0, 4);
  maps\deer_hunt_util::flag_set_delayed(3, "introscreen_complete");
}

custom_intro_radio_sequence() {
  var_0 = ["deerhunt_us1_vikingsixyouthere", "deerhunt_hsh_uhhcopyyeahwerehere", "deerhunt_us1_reportsarecomingin", "deerhunt_hsh_ahhshitanysurvivors", "deerhunt_us1_negative"];

  foreach(var_2 in var_0) {
    maps\deer_hunt_util::vo_wait();
    level.player maps\_utility::play_sound_on_entity(var_2);
  }

  common_scripts\utility::flag_set("intro_radio_complete");
}

player_slide_check() {
  return level.player issprintsliding();
}

player_crouch_check() {
  return level.player getstance() == "crouch";
}

gun_inventory() {
  if(self.type == "dog") {
    return;
  }
  maps\_utility::disable_surprise();

  if(!isDefined(level.possible_guns))
    level.possible_guns = [];

  if(!maps\_utility::is_in_array(level.possible_guns, self.weapon))
    level.possible_guns = common_scripts\utility::add_to_array(level.possible_guns, self.weapon);
}

precache_stuff() {
  precachemodel("accessories_sack_coffee_animated");
  precachemodel("hjk_tablet_01");
  precacheturret("hind_turret_oilrocks_quick");
  precachemodel("angel_flare_rig");
  precachemodel("lv_redchair_dust");
  precacheitem("mk14");
  precacheitem("noweapon_deer_hunt");
  precacheitem("maaws");
  precachemodel("weapon_parabolic_knife");
  precachemodel("vehicle_matv_ramp_obj");
  precachemodel("weapon_maaws_obj");
  precacheitem("zippy_rockets");
  precachemodel("tag_laser");
  precachemodel("fastrope_80ft_ri");
  precachestring(&"DEER_HUNT_INTROSCREEN_LINE_1");
  precachestring(&"DEER_HUNT_INTROSCREEN_LINE_2");
  precachestring(&"DEER_HUNT_INTROSCREEN_LINE_3");
  precachestring(&"DEER_HUNT_INTROSCREEN_LINE_4");
  precachestring(&"DEER_HUNT_INTROSCREEN_LINE_5");
  precachestring(&"DEER_HUNT_FINISH_PATROL");
  precachestring(&"DEER_HUNT_MEET_CHARLIE_TEAM");
  precachestring(&"DEER_HUNT_BACKUP_LARIVER");
  precachestring(&"DEER_HUNT_BACK_MATV");
  precachestring(&"DEER_HUNT_MISSION_BRIEF");
  precachestring(&"DEER_HUNT_REPORT_TO_ELIAS");
  precachestring(&"DEER_HUNT_MATV_HINT");
  precachestring(&"DEER_HUNT_MATV_HINT_RELOAD");
  precachestring(&"DEER_HUNT_DEFEND_OBJ");
  precachestring(&"DEER_HUNT_JEEP_INTROLINE_1");
  precachestring(&"DEER_HUNT_JEEP_INTROLINE_2");
  precachestring(&"DEER_HUNT_JEEP_INTROLINE_3");
  precacherumble("deer_hunt_earthquake");
  precacherumble("vegas_drag");
  maps\_utility_dogs::init_dog_pc("b");
}

objectives() {
  switch (level.start_point) {
    case "intro":
    case "default":
      common_scripts\utility::flag_wait("player_up");
      objective_add(maps\_utility::obj("finish_sweep"), "current", & "DEER_HUNT_FINISH_PATROL");
    case "outside":
    case "lobby":
      common_scripts\utility::flag_wait("lobby_exit");
      thread maps\deer_hunt_util::try_slide_hint("lobby_exit", "promenade_exit_halfway");
      wait 15;
      objective_add(maps\_utility::obj("meet_charlie"), "current", & "DEER_HUNT_MEET_CHARLIE_TEAM");
    case "street":
      common_scripts\utility::flag_wait("road_chasm_approach");
      maps\_utility::objective_complete(maps\_utility::obj("meet_charlie"));
      common_scripts\utility::flag_wait("hesh_to_shop_door");
    case "encounter1":
      common_scripts\utility::flag_wait("dog_attack_enemies_dead");
      thread maps\deer_hunt_util::try_slide_hint("dog_attack_enemies_dead", "gasstation_front_approach");
    case "encounter2":
      thread fill_mk14_ammo();
      common_scripts\utility::flag_wait_any("to_pipe", "player_rushed_lariver", "pipe_exit");
      wait 15;
      maps\_utility::objective_complete(maps\_utility::obj("finish_sweep"));
      wait 2;
      objective_add(maps\_utility::obj("la_river"), "current", & "DEER_HUNT_BACKUP_LARIVER");
      common_scripts\utility::flag_wait("pipe_enter");

      if(!common_scripts\utility::flag("did_slide_hint"))
        thread maps\_utility::display_hint_timeout("slide_hint", 7);
    case "lariver_defend":
    case "lariver":
      common_scripts\utility::flag_wait("drag_complete");
      wait 4;
      objective_string(maps\_utility::obj("la_river"), & "DEER_HUNT_DEFEND_OBJ");
      common_scripts\utility::flag_wait("defend_chopp2_dead");
      maps\_utility::objective_complete(maps\_utility::obj("la_river"));
      common_scripts\utility::flag_wait("load_matv");
      wait 2;
      maps\_utility::objective_complete(maps\_utility::obj("finish_sweep"));
      wait 2;
      objective_add(maps\_utility::obj("go_to_base"), "current", & "DEER_HUNT_MISSION_BRIEF");
      wait 2;
      objective_add(maps\_utility::obj("matv"), "current", & "DEER_HUNT_BACK_MATV");
      common_scripts\utility::flag_wait("matv_loaded");
      maps\_utility::objective_complete(maps\_utility::obj("matv"));
    case "ride":
    case "lariver_exit":
      common_scripts\utility::flag_wait("player_exited_jeep");
      maps\_utility::objective_complete(maps\_utility::obj("go_to_base"));
      wait 2;
    case "house":
      objective_add(maps\_utility::obj("elias"), "current", & "DEER_HUNT_REPORT_TO_ELIAS");
      common_scripts\utility::flag_wait("2nd_floor_start");
      maps\_utility::objective_complete(maps\_utility::obj("elias"));
    default:
      break;
  }
}

fill_mk14_ammo() {
  for(;;) {
    level.player waittill("weapon_change");
    wait 0.05;
    var_0 = level.player getcurrentweapon();

    if(var_0 == "mk14+scopemk14_sp") {
      level.player givemaxammo(var_0);
      return;
    }
  }
}

setup_flags() {
  common_scripts\utility::flag_init("start_intro_scene");
  common_scripts\utility::flag_init("flare_down");
  common_scripts\utility::flag_init("to_theater_exit");
  common_scripts\utility::flag_init("deer_runs");
  common_scripts\utility::flag_init("shadow_guy_dead");
  common_scripts\utility::flag_init("shadow_chasers_hot");
  common_scripts\utility::flag_init("roof_guy_dead");
  common_scripts\utility::flag_init("gasstation_guys_engaged");
  common_scripts\utility::flag_init("level.gasstation_guys");
  common_scripts\utility::flag_init("send_dog_to_roof");
  common_scripts\utility::flag_init("jeep_ai_spawned");
  common_scripts\utility::flag_init("jeep_arrived");
  common_scripts\utility::flag_init("player_in_jeep");
  common_scripts\utility::flag_init("friendlies_in_jeep");
  common_scripts\utility::flag_init("lariver_finished");
  common_scripts\utility::flag_init("exit_theater");
  common_scripts\utility::flag_init("deer_moved_away");
  common_scripts\utility::flag_init("hesh_to_shop_door");
  common_scripts\utility::flag_init("gas_station_open_fire");
  common_scripts\utility::flag_init("intro_vo_done");
  common_scripts\utility::flag_init("intro_takedown_aborted");
  common_scripts\utility::flag_init("intro_takedown_started");
  common_scripts\utility::flag_init("intro_takedown_done");
  common_scripts\utility::flag_init("intro_takedown_ready");
  common_scripts\utility::flag_init("friendlies_spawned");
  common_scripts\utility::flag_init("dog_kill_started");
  common_scripts\utility::flag_init("dog_kill_aborted");
  common_scripts\utility::flag_init("dog_kill_ended");
  common_scripts\utility::flag_init("execution_start");
  common_scripts\utility::flag_init("civilians_shot");
  common_scripts\utility::flag_init("la_river_complete");
  common_scripts\utility::flag_init("player_in_defend_area");
  common_scripts\utility::flag_init("spawn_defend_choppers");
  common_scripts\utility::flag_init("spawn_defend_chopper1");
  common_scripts\utility::flag_init("spawn_defend_chopper2");
  common_scripts\utility::flag_init("defend_chopp1_dead");
  common_scripts\utility::flag_init("defend_chopp2_dead");
  common_scripts\utility::flag_init("choppers_dead");
  common_scripts\utility::flag_init("intro_scene_complete");
  common_scripts\utility::flag_init("intro_fade_in");
  common_scripts\utility::flag_init("player_up");
  common_scripts\utility::flag_init("spawn_close_guys");
  common_scripts\utility::flag_init("bully_kick_aborted");
  common_scripts\utility::flag_init("bully_kick_complete");
  common_scripts\utility::flag_init("bully_kick_victim_dead");
  common_scripts\utility::flag_init("lobby_entrance");
  common_scripts\utility::flag_init("load_matv");
  common_scripts\utility::flag_init("matv_loaded");
  common_scripts\utility::flag_init("player_exited_jeep");
  common_scripts\utility::flag_init("chopper_fight_start");
  common_scripts\utility::flag_init("player_killed_defend_aa72x");
  common_scripts\utility::flag_init("player_picked_up_launcher");
  common_scripts\utility::flag_init("curtain_cut");
  common_scripts\utility::flag_init("ambient_chopper_shoots_wall");
  common_scripts\utility::flag_init("hesh_moves_from_encounter1");
  common_scripts\utility::flag_init("squad_to_defend");
  common_scripts\utility::flag_init("drag_complete");
  common_scripts\utility::flag_init("lariver_defend_bridge_clear");
  common_scripts\utility::flag_init("elias_convo_start");
  common_scripts\utility::flag_init("elias_convo_to_balcony");
  common_scripts\utility::flag_init("garage_affection_done");
  common_scripts\utility::flag_init("player_in_matv");
  common_scripts\utility::flag_init("player_fired_outside_coffee_shop");
  common_scripts\utility::flag_init("meetup_started");
  common_scripts\utility::flag_init("meetup_completed");
  common_scripts\utility::flag_init("did_slide_hint");
  common_scripts\utility::flag_init("start_cut");
  common_scripts\utility::flag_init("2nd_floor_start");
  common_scripts\utility::flag_init("2nd_floor_end");
  common_scripts\utility::flag_init("3rd_floor_start");
  common_scripts\utility::flag_init("hesh_in_3rd_floor_position");
  common_scripts\utility::flag_init("elias_in_3rd_floor_position");
  common_scripts\utility::flag_init("intro_ruckus");
  common_scripts\utility::flag_init("encounter1_affection_started");
  common_scripts\utility::flag_init("encounter1_affection_done");
  common_scripts\utility::flag_init("dog_in_affection_position");
  common_scripts\utility::flag_init("gate_opening");
  common_scripts\utility::flag_init("open_gate");
  common_scripts\utility::flag_init("player_rushed_gas_station");
  common_scripts\utility::flag_init("player_rushed_lariver");
  common_scripts\utility::flag_init("gasstation_enemies_dead");
  common_scripts\utility::flag_init("jeep_ride_message_displayed");
  common_scripts\utility::flag_init("fade_in_jeep_ride");
  common_scripts\utility::flag_init("intro_radio_complete");
  common_scripts\utility::flag_init("outside_360_complete");
  flag_trigs();
}

flag_trigs() {
  if(getdvarint("r_reflectionProbeGenerate") == 1) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "lobby_entrance";
  var_0[var_0.size] = "lobby_exit_approach";
  var_0[var_0.size] = "lobby_exit";
  var_0[var_0.size] = "screen_arrive";
  var_0[var_0.size] = "promenade_exit_halfway";
  var_0[var_0.size] = "promenade_exit";
  var_0[var_0.size] = "color_line_3";
  var_0[var_0.size] = "shop_exit";
  var_0[var_0.size] = "player_at_shop_door";
  var_0[var_0.size] = "player_at_encounter1";
  var_0[var_0.size] = "dog_distracts";
  var_0[var_0.size] = "hill_pos1";
  var_0[var_0.size] = "hill_pos2";
  var_0[var_0.size] = "dog_on_roof";
  var_0[var_0.size] = "player_to_roof";
  var_0[var_0.size] = "gasstation_clear";
  var_0[var_0.size] = "gate_approach";
  var_0[var_0.size] = "pipe_halfway";
  var_0[var_0.size] = "pipe_exit";
  var_0[var_0.size] = "pipe_enter";
  var_0[var_0.size] = "through_screen";
  var_0[var_0.size] = "hallway_halfway";
  var_0[var_0.size] = "to_lobby_entrance";
  var_0[var_0.size] = "dog_to_shadow_guy";
  var_0[var_0.size] = "road_chasm_approach";
  var_0[var_0.size] = "hesh_attacks_shadow_guys";
  var_0[var_0.size] = "theater_exit";
  var_0[var_0.size] = "dropdown_arrive";
  var_0[var_0.size] = "gas_station_enter";
  var_0[var_0.size] = "to_pipe";
  var_0[var_0.size] = "player_under_bridge";
  var_0[var_0.size] = "lariver_final_position";
  var_0[var_0.size] = "hesh_to_lookout";
  var_0[var_0.size] = "encounter1_approach";
  var_0[var_0.size] = "player_on_bus";
  var_0[var_0.size] = "player_out_of_chasm";
  var_0[var_0.size] = "back_enemies_fight_begin";
  var_0[var_0.size] = "gate_clear";
  var_0[var_0.size] = "lariver_turn";
  var_0[var_0.size] = "player_in_house";
  var_0[var_0.size] = "3rd_floor_player";
  var_0[var_0.size] = "balcony_player";
  var_0[var_0.size] = "hesh_elias_to_3rd";
  var_0[var_0.size] = "hesh_elias_to_balcony";
  var_0[var_0.size] = "hesh_elias_to_2nd";
  var_0[var_0.size] = "player_approaching_stage";
  var_0[var_0.size] = "player_on_upper_level";
  var_0[var_0.size] = "player_entered_coffee_shop";
  var_0[var_0.size] = "color_line_2";
  var_1 = [];
  var_1[var_1.size] = "player_dropped_down";

  foreach(var_3 in var_0)
  init_flag_and_set_on_targetname_trigger(var_3);

  foreach(var_3 in var_1)
  thread maps\deer_hunt_util::set_flag_on_targetname_trigger_by_player(var_3);
}

init_flag_and_set_on_targetname_trigger(var_0) {
  common_scripts\utility::flag_init(var_0);
  thread maps\_utility::set_flag_on_targetname_trigger(var_0);
}

level_music() {
  switch (level.start_point) {
    case "intro":
    case "default":
      maps\deer_hunt_util::music_on_flag("screen_arrive", "mus_deer_curtain_call");
    case "lobby":
      maps\deer_hunt_util::music_on_flag("lobby_exit", "mus_deer_fountain_reveal");
    case "street":
      maps\deer_hunt_util::music_on_flag("promenade_exit", "mus_deer_libery_wall", 0.5);
    case "encounter1":
      common_scripts\utility::flag_wait("player_at_shop_door");
      maps\_utility::music_stop(30);
    case "lariver":
    case "encounter2":
      maps\deer_hunt_util::music_on_flag("pipe_exit", "mus_deer_river_fight");
    case "lariver_defend":
      maps\deer_hunt_util::music_on_flag("chopper_fight_start", "mus_deer_chopper_battle", 5);
      common_scripts\utility::flag_wait("defend_chopp2_dead");
      maps\_utility::music_stop(30);
    case "ride":
  }
}

spawn_all_friendlies() {
  maps\deer_hunt_intro::spawn_hesh_and_dog();
  maps\deer_hunt_intro::spawn_team2();
}

lobby_entrance() {
  thread maps\deer_hunt_intro::move_player_to_start("lobby_entrance_player");
  thread maps\deer_hunt_intro::deer_init();
  thread maps\deer_hunt_intro::spawn_hesh_and_dog();
  thread maps\deer_hunt_intro::team2_nav_logic();
  thread maps\deer_hunt_intro::lobby_ruckus();
  thread maps\deer_hunt_intro::intro_enemies();
  common_scripts\utility::flag_wait("friendlies_spawned");
  thread maps\deer_hunt_intro::intro_vo();
  thread maps\deer_hunt_intro::intro_fx();
  thread maps\deer_hunt_util::play_loop_sound_in_space_stop_on_flag("scn_deer_ruckus_loop", (-8951, 12053, -138), "lobby_entrance");
  level.hesh maps\_utility::set_force_color("red");
  level.dog maps\_utility::set_force_color("blue");
  var_0 = common_scripts\utility::getstructarray("lobby_entrance_ai", "targetname");

  foreach(var_3, var_2 in level.squad) {
    var_2 maps\_utility::enable_ai_color();
    var_2 forceteleport(var_0[var_3].origin, var_0[var_3].angles);
  }

  level.hesh maps\_utility::set_force_color("red");
  level.dog maps\_utility::set_force_color("blue");
  maps\_utility::activate_trigger_with_targetname("theater_exit");
  maps\_utility::activate_trigger_with_targetname("to_lobby_entrance");
  common_scripts\utility::flag_wait("pipe_enter");
  thread maps\deer_hunt_intro::lariver_global_setup();
}

outside_start() {
  thread maps\deer_hunt_intro::move_player_to_start("outside_start_player");
  thread maps\deer_hunt_intro::intro_enemies();
  thread maps\deer_hunt_intro::spawn_hesh_and_dog();
  thread maps\deer_hunt_intro::team2_nav_logic();
  thread maps\deer_hunt_intro::intro_vo();
  thread maps\deer_hunt_intro::intro_fx();
  common_scripts\utility::flag_wait("friendlies_spawned");
  level.hesh maps\_utility::set_force_color("red");
  level.dog maps\_utility::set_force_color("blue");
  maps\_utility::activate_trigger_with_targetname("lobby_exit_approach");
  var_0 = common_scripts\utility::getstructarray("outside_start_ai", "targetname");

  foreach(var_3, var_2 in level.squad) {
    var_2 maps\_utility::enable_ai_color();
    var_2 forceteleport(var_0[var_3].origin, var_0[var_3].angles);
  }

  var_4 = getEntArray("promenade_exit_deer", "targetname");

  foreach(var_3, var_6 in var_4) {
    var_7[var_3] = maps\_drone_deer::deer_dronespawn(var_6);
    var_7[var_3] thread maps\deer_hunt_intro::deer_detects_when_to_run();
  }

  common_scripts\utility::flag_wait("pipe_enter");
  thread maps\deer_hunt_intro::lariver_global_setup();
}

street_start() {
  common_scripts\utility::flag_set("outside_360_complete");
  thread maps\deer_hunt_intro::move_player_to_start("street_start_player");
  thread maps\deer_hunt_intro::intro_enemies();
  thread maps\deer_hunt_intro::spawn_hesh_and_dog();
  thread maps\deer_hunt_intro::team2_nav_logic();
  thread maps\deer_hunt_intro::intro_vo();
  thread maps\deer_hunt_intro::intro_fx();
  common_scripts\utility::flag_wait("friendlies_spawned");
  level.hesh maps\_utility::set_force_color("red");
  level.dog maps\_utility::set_force_color("blue");
  var_0 = common_scripts\utility::getstructarray("street_start_ai", "targetname");

  foreach(var_3, var_2 in level.squad) {
    var_2 maps\_utility::enable_ai_color();
    var_2 forceteleport(var_0[var_3].origin, var_0[var_3].angles);
  }

  level.hesh maps\_utility::enable_cqbwalk();
  common_scripts\utility::flag_wait("pipe_enter");
  thread maps\deer_hunt_intro::lariver_global_setup();
}

encounter1_start() {
  thread maps\deer_hunt_intro::move_player_to_start("encounter1_player");
  thread maps\deer_hunt_intro::intro_enemies();
  spawn_all_friendlies();
  thread maps\deer_hunt_intro::intro_vo();
  thread maps\deer_hunt_intro::intro_fx();
  common_scripts\utility::flag_wait("friendlies_spawned");
  level.hesh maps\_utility::set_force_color("red");
  level.dog maps\_utility::set_force_color("blue");
  var_0 = common_scripts\utility::getstructarray("encounter1_ai", "targetname");

  foreach(var_3, var_2 in level.squad) {
    var_2 maps\deer_hunt_util::ignore_me_ignore_all();
    var_2 forceteleport(var_0[var_3].origin, var_0[var_3].angles);
  }

  level.hesh maps\_utility::disable_ai_color();
  level.hesh maps\_utility::enable_cqbwalk();
  var_4 = common_scripts\utility::getstructarray("team2_encounter1", "targetname");

  while(!isDefined(level.team2))
    wait 0.25;

  foreach(var_3, var_6 in var_4)
  level.team2[var_3] forceteleport(var_6.origin, var_6.angles);

  maps\_utility::activate_trigger_with_targetname("dropdown_arrive");
  maps\_utility::activate_trigger_with_targetname("player_on_bus");
  common_scripts\utility::flag_set("meetup_completed");
  common_scripts\utility::array_thread(level.team2, maps\deer_hunt_util::cqb_off_sprint_on);
  common_scripts\utility::flag_wait("pipe_enter");
  thread maps\deer_hunt_intro::lariver_global_setup();
}

encounter2_start() {
  thread maps\deer_hunt_intro::move_player_to_start("gasstation_start_player");
  spawn_all_friendlies();
  thread maps\deer_hunt_intro::intro_enemies();
  thread maps\deer_hunt_intro::intro_vo();
  thread maps\deer_hunt_intro::intro_fx();
  common_scripts\utility::flag_wait("friendlies_spawned");
  level.hesh maps\_utility::set_force_color("red");
  level.dog maps\_utility::set_force_color("blue");
  var_0 = common_scripts\utility::getstructarray("gasstation_start_ai", "targetname");

  foreach(var_3, var_2 in level.squad) {
    var_2 maps\_utility::delaythread(1, maps\_utility::enable_ai_color);
    var_2 forceteleport(var_0[var_3].origin, var_0[var_3].angles);
  }

  var_4 = common_scripts\utility::getstructarray("team2_encounter2", "targetname");

  while(!isDefined(level.team2))
    wait 0.25;

  foreach(var_3, var_6 in var_4)
  level.team2[var_3] forceteleport(var_6.origin, var_6.angles);

  maps\_utility::activate_trigger_with_targetname("encounter1_approach");
  maps\_utility::activate_trigger_with_targetname("hesh_to_dropdown");
  common_scripts\utility::flag_wait("pipe_enter");
  thread maps\deer_hunt_intro::lariver_global_setup();
}

lariver_start() {
  thread maps\deer_hunt_intro::move_player_to_start("la_river_player");
  spawn_all_friendlies();
  thread maps\deer_hunt_intro::intro_vo();
  thread maps\deer_hunt_intro::intro_fx();
  common_scripts\utility::flag_wait("friendlies_spawned");
  level.hesh maps\_utility::set_force_color("red");
  level.dog maps\_utility::set_force_color("blue");
  var_0 = common_scripts\utility::getstructarray("la_river_ai", "targetname");

  foreach(var_3, var_2 in level.squad) {
    var_2 maps\_utility::enable_ai_color();
    var_2 forceteleport(var_0[var_3].origin, var_0[var_3].angles);
  }

  var_4 = common_scripts\utility::getstructarray("team2_lariver", "targetname");

  foreach(var_3, var_6 in var_4)
  level.team2[var_3] forceteleport(var_6.origin, var_6.angles);

  thread maps\deer_hunt_intro::lariver_global_setup();
  thread maps\deer_hunt_intro::lariver_spawn_wall_battle_guys_early();
  wait 1;
  common_scripts\utility::array_thread(getaiarray("allies"), maps\deer_hunt_util::ignore_me_ignore_all_off);
  level.dog maps\_utility::enable_ai_color();
  thread fill_mk14_ammo();
}

spawn_lariver_defend_balcony_guys() {
  maps\_utility::array_spawn_function_targetname("rpg_guys", maps\deer_hunt_intro::lariver_balcony_friendly_logic, 1);
  level.balcony_friendlies = maps\_utility::array_spawn_targetname("rpg_guys", 1);

  foreach(var_1 in level.balcony_friendlies)
  var_1.spawner = common_scripts\utility::random(getEntArray("rpg_guys", "targetname"));
}

lariver_defend_start() {
  thread maps\deer_hunt_intro::move_player_to_start("la_river_defend_player");
  spawn_all_friendlies();
  spawn_lariver_defend_balcony_guys();
  thread maps\deer_hunt_intro::intro_vo();
  thread maps\deer_hunt_intro::intro_fx();
  common_scripts\utility::flag_wait("friendlies_spawned");
  level.hesh maps\_utility::set_force_color("red");
  level.dog maps\_utility::set_force_color("blue");
  var_0 = common_scripts\utility::getstructarray("la_river_defend_ai", "targetname");

  foreach(var_3, var_2 in level.squad) {
    var_2 maps\_utility::enable_ai_color();
    var_2 forceteleport(var_0[var_3].origin, var_0[var_3].angles);
  }

  thread maps\deer_hunt_intro::chopper_sounds_for_defend();
  level.matv = maps\_vehicle::spawn_vehicle_from_targetname("gate_matv");
  level.matv hidepart("ramp_jnt");
  level.matv.obj_ent = getent("obj_ramp", "targetname");
  level.matv.obj_ent linkto(level.matv);
  var_4 = getvehiclenode("matv_start", "targetname");
  level.matv attachpath(var_4);
  var_5 = common_scripts\utility::getstructarray("la_river_defend_team2", "targetname");

  foreach(var_3, var_7 in var_5)
  level.team2[var_3] forceteleport(var_7.origin, var_7.angles);

  level.lariver_early_ai = level.balcony_friendlies;
  thread maps\deer_hunt_intro::lariver_defend_globals(1);
  level.dog maps\_utility::enable_ai_color();
  common_scripts\utility::flag_set("lariver_final_position");
  wait 1;
  thread maps\deer_hunt_intro::la_river_defend_weapons_spawn();
}

lariver_nogame_start() {
  common_scripts\utility::trigger_off("trigger_multiple", "classname");
  common_scripts\utility::trigger_off("trigger_radius", "classname");
  common_scripts\utility::trigger_off("trigger_multiple_spawn", "classname");
  level.player_is_stunned = 0;
  thread maps\deer_hunt_intro::move_player_to_start("la_river_defend_player");
  level.matv = maps\_vehicle::spawn_vehicle_from_targetname("gate_matv");
  level.matv hidepart("ramp_jnt");
  level.matv.obj_ent = getent("obj_ramp", "targetname");
  level.matv.obj_ent linkto(level.matv);
  var_0 = getvehiclenode("matv_start", "targetname");
  level.matv attachpath(var_0);
  level.player thread maps\deer_hunt_intro::lariver_defend_guided_missile_setup();
  thread maps\deer_hunt_intro::lariver_setup_launchers();
  level thread maps\deer_hunt_intro::lariver_defend_spawn_choppers();
  level thread maps\deer_hunt_intro::lariver_defend_destructible_cover();
  wait 1;
  thread maps\deer_hunt_intro::la_river_defend_weapons_spawn();
  common_scripts\utility::flag_set("spawn_defend_choppers");
  common_scripts\utility::flag_set("defend_chopp1_dead");
  common_scripts\utility::flag_set("player_in_defend_area");
  common_scripts\utility::flag_set("spawn_defend_chopper2");
  common_scripts\utility::flag_set("chopper_fight_start");
}

ride_start() {
  level thread maps\deer_hunt_intro::sniff_system_init();
  thread maps\deer_hunt_ride::jeep_ride_setup();
  setsaveddvar("ammocounterHide", "1");
}

lariver_exit() {
  thread maps\deer_hunt_intro::move_player_to_start("la_river_defend_player");
  thread maps\deer_hunt_intro::lariver_matv_ride();
  level.dog = maps\_utility::spawn_targetname("dog", 1);
  common_scripts\utility::flag_set("load_matv");
  level.matv = maps\_vehicle::spawn_vehicle_from_targetname("gate_matv");
  var_0 = getvehiclenode("matv_start", "targetname");
  level.matv hidepart("ramp_jnt");
  level.matv.obj_ent = getent("obj_ramp", "targetname");
  level.matv.obj_ent linkto(level.matv);
  level.matv attachpath(var_0);
  thread maps\deer_hunt_intro::wall_ride_cilivians();
  maps\deer_hunt_intro::player_gets_in_matv();
  common_scripts\utility::flag_set("matv_loaded");
  thread maps\deer_hunt_intro::lariver_transition_to_beach();
}

house_start() {
  common_scripts\utility::flag_set("introscreen_complete");
  getent("dog", "targetname") maps\_utility::add_spawn_function(maps\deer_hunt_intro::dog_logic);
  level.hesh = maps\_utility::spawn_targetname("hesh", 1);
  level.dog = maps\_utility::spawn_targetname("dog", 1);
  level.squad = [level.hesh, level.dog];
  thread maps\deer_hunt_intro::move_player_to_start("house_player");
  thread maps\deer_hunt_ride::setup_house();
  var_0 = common_scripts\utility::getstruct("house_ai", "targetname");
  var_1 = (26432.5, 8072.2, -145);
  level.hesh forceteleport(var_0.origin, var_0.angles);
  level.dog forceteleport(var_1, var_0.angles);
  level.hesh thread maps\deer_hunt_ride::hesh_navigation_logic();
  level.dog thread maps\deer_hunt_ride::dog_navigation_logic();
  setsaveddvar("ammocounterHide", "1");
  level.player takeallweapons();
  level.player giveweapon("noweapon_deer_hunt");
  level.player switchtoweapon("noweapon_deer_hunt");
  level.player allowmelee(0);
  common_scripts\utility::flag_set("player_exited_jeep");
  level.dog pushplayer(1);
  maps\_utility::battlechatter_off();
  maps\_utility::flavorbursts_off();
}

elias_start() {
  common_scripts\utility::flag_set("player_in_house");
  level.hesh = maps\_utility::spawn_targetname("hesh", 1);
  level.squad = [level.hesh];
  thread maps\deer_hunt_intro::move_player_to_start("elias_start_player");
  var_0 = common_scripts\utility::getstructarray("elias_start_ai", "targetname");
  var_1 = undefined;

  foreach(var_4, var_3 in level.squad) {
    var_3 forceteleport(var_0[var_4].origin, var_0[var_4].angles);
    var_1 = common_scripts\utility::getstruct(var_0[var_4].target, "targetname");
  }

  level.hesh maps\_utility::set_force_color("r");
  level.hesh maps\_utility::disable_ai_color();
  level.hesh.goalradius = 60;
  level.hesh thread maps\_utility::follow_path_and_animate(var_1, 350);
  maps\_utility::activate_trigger_with_targetname("3rd_floor_player");
  level.hesh waittill("path_end_reached");
  common_scripts\utility::flag_set("elias_convo_start");
}

set_default_mb_values() {
  setsaveddvar("r_mbEnable", 2);
  setsaveddvar("r_mbCameraRotationInfluence", 0.25);
  setsaveddvar("r_mbCameraTranslationInfluence", 0.01);
  setsaveddvar("r_mbModelVelocityScalar", 0);
  setsaveddvar("r_mbStaticVelocityScalar", 0.2);
  setsaveddvar("r_mbViewModelEnable", 0);
}