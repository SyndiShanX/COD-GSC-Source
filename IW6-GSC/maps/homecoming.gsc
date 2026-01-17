/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming.gsc
*****************************************************/

main() {
  precachestuff();
  maps\_utility::template_level("homecoming");
  maps\createart\homecoming_art::main();
  maps\homecoming_fx::main();
  maps\_utility::set_default_start("street");
  maps\_utility::add_start("street", ::start_street_sequence, "street", maps\homecoming_intro::intro_sequence_street, "homecoming_transient_intro_tr");
  maps\_utility::add_start("bunker", ::start_bunker_sequence, "bunker", maps\homecoming_beach::beach_sequence_bunker_new, "homecoming_transient_intro_tr");
  maps\_utility::add_start("trench", ::start_trenches_sequence, "trenches", maps\homecoming_trench::beach_sequence_trenches, "homecoming_transient_beach_tr");
  maps\_utility::add_start("trench2", ::start_trenches2_sequence, "trenches2", maps\homecoming_trench::beach_trenches_combat_part2, "homecoming_transient_beach_tr");
  maps\_utility::add_start("retreat", ::start_tower_retreat, "tower retreat", maps\homecoming_retreat::tower_retreat_sequence, "homecoming_transient_beach_tr");
  maps\_utility::add_start("elias_street", ::start_elias_street, "elias street", maps\homecoming_retreat::elias_street_sequence, "homecoming_transient_beach_tr");
  maps\_utility::add_start("elias_house", ::start_elias_house, "elias house", maps\homecoming_retreat::elias_house_sequence, "homecoming_transient_beach_tr");
  maps\_utility::add_start("elias_house_attack", ::start_elias_house_attack, "elias house attack", maps\homecoming_retreat::elias_house_attack, "homecoming_transient_beach_tr");
  maps\_utility::add_start("recruits", ::start_recruit_scene, "recruit", maps\homecoming_recruits::recruit_scene, "homecoming_transient_recruits_tr");
  maps\_utility::add_start("balcony_fall", ::start_balcony_fall, undefined, undefined, "homecoming_transient_intro_tr");
  maps\_utility::add_start("tower_explosion", ::start_tower_explosion_test, undefined, undefined, "homecoming_transient_beach_tr");
  maps\_utility::add_start("dog_reunite", ::start_dog_reunite, undefined, undefined);
  maps\_utility::add_start("artillery_test", ::start_artillery_test, undefined, undefined);
  maps\_utility::add_start("hind_test", ::start_hind_test, undefined, undefined, "homecoming_transient_intro_tr");
  maps\_utility::add_start("knife_test", ::start_knife_test, undefined, undefined);
  maps\_utility::add_start("a10_bunker", ::start_a10_showcase, undefined, undefined);
  maps\_utility::add_start("a10_trench", ::start_a10_showcase, undefined, undefined);
  maps\_utility::add_start("a10_tower", ::start_a10_showcase, undefined, undefined);
  maps\_utility::intro_screen_create(&"HOMECOMING_INTROSCREEN_LINE_1", &"HOMECOMING_INTROSCREEN_LINE_2", &"HOMECOMING_INTROSCREEN_LINE_5");
  maps\_utility::intro_screen_custom_func(::homecoming_introscreen);
  maps\_utility::add_hint_string("hind_prone_hint", &"HOMECOMING_HINT_HIND", ::prone_hint_off);
  maps\_utility::add_hint_string("hind_prone_hint_hold", &"HOMECOMING_HINT_HIND_STANCE", ::prone_hint_off);
  maps\_utility::add_hint_string("hind_prone_hint_toggle", &"HOMECOMING_HINT_HIND_TOGGLE", ::prone_hint_off);
  maps\_utility::add_hint_string("prone_hint", &"HOMECOMING_HINT_PRONE", ::prone_hint_off);
  maps\_utility::add_hint_string("prone_hint_hold", &"HOMECOMING_HINT_PRONE_STANCE", ::prone_hint_off);
  maps\_utility::add_hint_string("prone_hint_toggle", &"HOMECOMING_HINT_PRONE_TOGGLE", ::prone_hint_off);
  init_level_flags();
  maps\_utility::transient_init("homecoming_transient_intro_tr");
  maps\_utility::transient_init("homecoming_transient_beach_tr");
  maps\_utility::transient_init("homecoming_transient_recruits_tr");
  maps\homecoming_precache::main();
  maps\_load::main();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 5);
  setup_motion_blur();
  maps\homecoming_audio::main();
  maps\homecoming_anim::main();
  maps\homecoming_a10::init_a10();
  maps\_drone_ai::init();
  level.chaingun_viewmodel = "viewhands_player_us_rangers";
  level.chaingun_shelleject_fx = "chaingun_shellEject";
  maps\_chaingun_player::init_chaingun_player();
  thread setup_turrets();
  level.drone_lookahead_value = 75;
  global_spawn_functions();
  init_mainai();
  init_levelvariables();
  init_biasgroups();
  thread homecoming_objectives();
  thread maps\homecoming_util::player_embers();
  thread maps\homecoming_util::init_ambient_distant_battlechatter();
  setsaveddvar("ai_friendlysuppression", 0);
  setsaveddvar("ai_friendlyfireblockduration", 0);
  setdvarifuninitialized("balcony_hind_killed_player", 0);
  setdvarifuninitialized("daniel", 0);

  if(maps\_utility::is_gen4())
    maps\_art::disable_ssao_over_time(0);

  if(maps\_utility::game_is_current_gen())
    setsaveddvar("fx_alphathreshold", 10);

  level.tower_courtyard_mortars = common_scripts\utility::getstructarray("courtyard_mortar_spots", "script_noteworthy");
  level.mortarexcluders = [];
  level.nomaxmortardist = 1;
  level.mortarearthquakeradius = 3000;
  level.mortarwithinfov = cos(65);
  level.mortarmininterval = 3;
  level.mortarmaxinterval = 5;
  setdvarifuninitialized("bog_camerashake", "1");
  maps\_mortar::bog_style_mortar();
  maps\_utility::set_team_bcvoice("allies", "delta");
  maps\_utility::flavorbursts_on("allies");
  common_scripts\utility::flag_set("load_setup_complete");
}

precachestuff() {
  character\character_elite_pmc_assault_a_black::precache();
  precachemodel("projectile_slamraam_missile");
  precachemodel("angel_flare_rig");
  precachemodel("pose_fed_army_stand_idle");
  precachemodel("weapon_cz_805_bren");
  precachemodel("ac_prs_imp_mil_sandbag_desert_single_flat");
  precachemodel("ac_prs_imp_mil_sandbag_desert_single_bent");
  precachemodel("weapon_parabolic_knife");
  precachemodel("prop_uav_radio");
  precachemodel("machinery_welder_handle");
  precachemodel("cliffhanger_rope_100ft");
  precachemodel("adrenaline_syringe_animated");
  precachemodel("weapon_mts_255_small");
  precachemodel("mil_ammo_case_2");
  precachemodel("com_fire_extinguisher_anim");
  precachemodel("projectile_slamraam_missile");
  precachemodel("ls_aid_crate_02");
  precachemodel("com_plasticcase_black_big_tagged_iw6");
  precachemodel("sandbag01_iw6");
  precachemodel("com_ammo_pallet");
  precachemodel("com_barrel_black");
  precachemodel("bc_military_tire05_big");
  precachemodel("merrick_head_halfmask");
  precachemodel("palm_tree01_iw6");
  precacheshader("dogcam_edge");
  precacheitem("hovercraft_missile_guided");
  precacheitem("hind_turret_oilrocks");
  precacheitem("missile_attackheli_no_explode");
  precacheitem("sc2010");
  precacheitem("honeybadger");
  precacheitem("missile_attackheli");
  precacheitem("smoke_grenade_signal");
  precacheitem("sparrow_missile");
  precacheshellshock("homecoming_bunker");
  precacheshellshock("homecoming_balcony_fall");
  precacheshellshock("homecoming_artillery");
  precacheshellshock("homecoming_artillery_far");
  precacheshellshock("homecoming_artillery_close");
  precacheshellshock("homecoming_attack");
  precacheshellshock("nosound");
  precacherumble("steady_rumble");
  precacherumble("chopper_ride_rumble");
  precacherumble("artillery_rumble");
  precacherumble("hind_flyover");
  precacherumble("damage_light");
  precacherumble("damage_heavy");
  maps\_utility_dogs::init_dog_pc("a");
}

init_level_flags() {
  common_scripts\utility::flag_init("load_setup_complete");
  common_scripts\utility::flag_init("FLAG_bunker_turrets_setup");
  common_scripts\utility::flag_init("FLAG_intro_start_scenes");
  common_scripts\utility::flag_init("FLAG_player_out_of_nh90");
  common_scripts\utility::flag_init("FLAG_intro_rangers_start");
  common_scripts\utility::flag_init("FLAG_intro_passoff_start");
  common_scripts\utility::flag_init("FLAG_intro_hesh_start");
  common_scripts\utility::flag_init("FLAG_intro_handler_start");
  common_scripts\utility::flag_init("FLAG_intro_dog_start");
  common_scripts\utility::flag_init("FLAG_intro_tent_runner");
  common_scripts\utility::flag_init("FLAG_intro_rangers_move");
  common_scripts\utility::flag_init("FLAG_waver_through_wire");
  common_scripts\utility::flag_init("FLAG_start_bunker_turret_fire");
  common_scripts\utility::flag_init("FLAG_nh90_ranger_dialog_done");
  common_scripts\utility::flag_init("FLAG_turn_off_abrams_player_check");
  common_scripts\utility::flag_init("FLAG_stop_intro_drone_runners");
  common_scripts\utility::flag_init("FLAG_hesh_in_bunker_house");
  common_scripts\utility::flag_init("FLAG_ranger1_in_backyard");
  common_scripts\utility::flag_init("FLAG_ranger2_in_backyard");
  common_scripts\utility::flag_init("FLAG_start_bunker");
  common_scripts\utility::flag_init("FLAG_bunker_hallway_explosion");
  common_scripts\utility::flag_init("FLAG_balcony_gunner_hit");
  common_scripts\utility::flag_init("FLAG_balcony_secondary_gunner_point");
  common_scripts\utility::flag_init("FLAG_hesh_in_bunker_house");
  common_scripts\utility::flag_init("FLAG_ranger1_in_bunker_house");
  common_scripts\utility::flag_init("FLAG_ranger2_in_bunker_house");
  common_scripts\utility::flag_init("FLAG_bunker_balcony_blocker_set");
  common_scripts\utility::flag_init("FLAG_wave1_right_helicopter");
  common_scripts\utility::flag_init("FLAG_start_artillery_sequence");
  common_scripts\utility::flag_init("bunker_hovercraft_rocket_g1_done");
  common_scripts\utility::flag_init("bunker_hovercraft_rocket_g2_done");
  common_scripts\utility::flag_init("bunker_hovercraft_rocket_g3_done");
  common_scripts\utility::flag_init("FLAG_stop_trench_drones");
  common_scripts\utility::flag_init("FLAG_stop_wave1_loops");
  common_scripts\utility::flag_init("FLAG_stop_wave1_trench_loops");
  common_scripts\utility::flag_init("FLAG_start_wave1_retreat");
  common_scripts\utility::flag_init("FLAG_first_hovercraft_missile_hit");
  common_scripts\utility::flag_init("FLAG_artillery_sequence_done");
  common_scripts\utility::flag_init("FLAG_beach_start_wave_2");
  common_scripts\utility::flag_init("FLAG_wave2_hinds");
  common_scripts\utility::flag_init("FLAG_playerhind_targeting");
  common_scripts\utility::flag_init("FLAG_allow_hind_to_target_player");
  common_scripts\utility::flag_init("FLAG_hind_is_targeting_player");
  common_scripts\utility::flag_init("FLAG_playerhind_destroy_mg");
  common_scripts\utility::flag_init("FLAG_beach_start_wave_3");
  common_scripts\utility::flag_init("FLAG_start_wave3_tanks");
  common_scripts\utility::flag_init("FLAG_start_balcony_collapse");
  common_scripts\utility::flag_init("FLAG_balcony_fall_done");
  common_scripts\utility::flag_init("FLAG_balcony_getup_done");
  common_scripts\utility::flag_init("NODEFLAG_first_hovercraft_arrived");
  common_scripts\utility::flag_init("NODEFLAG_wave1_final_hovercraft_goal");
  common_scripts\utility::flag_init("FLAG_a10_return_flybys");
  common_scripts\utility::flag_init("FLAG_enable_bunker_a10_mechanic");
  common_scripts\utility::flag_init("FLAG_balcony_strafe");
  common_scripts\utility::flag_init("FLAG_hesh_balcony_wave");
  common_scripts\utility::flag_init("FLAG_start_trenches");
  common_scripts\utility::flag_init("FLAG_trench_stop_beach_stuff");
  common_scripts\utility::flag_init("FLAG_stop_trench_beach_runners");
  common_scripts\utility::flag_init("FLAG_trench_respawner_1");
  common_scripts\utility::flag_init("FLAG_trench_respawner_2");
  common_scripts\utility::flag_init("FLAG_trench_first_strafe_done");
  common_scripts\utility::flag_init("FLAG_trench_a10_mechanic");
  common_scripts\utility::flag_init("FLAG_trenches_hovercraft_spawned");
  common_scripts\utility::flag_init("FLAG_start_trench_hovercraft_tank");
  common_scripts\utility::flag_init("FLAG_trench_tank_unload_complete");
  common_scripts\utility::flag_init("FLAG_trench_tank_destroyed");
  common_scripts\utility::flag_init("FLAG_halfway_through_trenches");
  common_scripts\utility::flag_init("FLAG_stop_over_trench_fx");
  common_scripts\utility::flag_init("FLAG_over_trench_hovercraft_gone");
  common_scripts\utility::flag_init("FLAG_allow_tower_a10");
  common_scripts\utility::flag_init("FLAG_player_a10_lockon");
  common_scripts\utility::flag_init("FLAG_tower_hind_destroyed");
  common_scripts\utility::flag_init("FLAG_start_tower_hind");
  common_scripts\utility::flag_init("FLAG_start_tower_explosion");
  common_scripts\utility::flag_init("FLAG_tower_explosion_done");
  common_scripts\utility::flag_init("FLAG_tower_entrance_stumbles");
  common_scripts\utility::flag_init("FLAG_tower_entrance_stumbles_done");
  common_scripts\utility::flag_init("FLAG_start_tower_sequence");
  common_scripts\utility::flag_init("FLAG_allow_garage_door_close");
  common_scripts\utility::flag_init("FLAG_start_retreat_friendly_movement");
  common_scripts\utility::flag_init("FLAG_hesh_inside_tower");
  common_scripts\utility::flag_init("FLAG_hesh_retreat_wave_dialog");
  common_scripts\utility::flag_init("FLAG_hesh_move_through_tower");
  common_scripts\utility::flag_init("FLAG_start_tower_retreat");
  common_scripts\utility::flag_init("FLAG_start_retreat_paths");
  common_scripts\utility::flag_init("FLAG_player_leaving_tower");
  common_scripts\utility::flag_init("FLAG_start_elias_street");
  common_scripts\utility::flag_init("FLAG_player_at_elias_street");
  common_scripts\utility::flag_init("FLAG_stop_elias_street_ambient_retreaters");
  common_scripts\utility::flag_init("FLAG_dog_reunite_started");
  common_scripts\utility::flag_init("FLAG_hesh_at_riley");
  common_scripts\utility::flag_init("FLAG_dog_reunite_done");
  common_scripts\utility::flag_init("FLAG_elias_street_ground_enemies");
  common_scripts\utility::flag_init("FLAG_cairo_reunite_complete");
  common_scripts\utility::flag_init("FLAG_elias_street_cairo_attack");
  common_scripts\utility::flag_init("FLAG_start_elias_house");
  common_scripts\utility::flag_init("FLAG_allow_dog_scratch");
  common_scripts\utility::flag_init("FLAG_dont_allow_dog_scratch");
  common_scripts\utility::flag_init("FLAG_garage_door_open");
  common_scripts\utility::flag_init("FLAG_garage_door_closed");
  common_scripts\utility::flag_init("FLAG_garage_dialoge_done");
  common_scripts\utility::flag_init("FLAG_dog_allow_teleport");
  common_scripts\utility::flag_init("FLAG_dog_garage_end_goal");
  common_scripts\utility::flag_init("FLAG_hesh_inside_elias_house");
  common_scripts\utility::flag_init("FLAG_rubble_scene_started");
  common_scripts\utility::flag_init("FLAG_player_went_prone");
  common_scripts\utility::flag_init("FLAG_hesh_dropped_beam");
  common_scripts\utility::flag_init("FLAG_start_elias_house_attack");
  common_scripts\utility::flag_init("FLAG_elias_house_attack_began");
  common_scripts\utility::flag_init("FLAG_first_resist_press");
  common_scripts\utility::flag_init("FLAG_attack_fail_kill_player");
  common_scripts\utility::flag_init("FLAG_house_attack_through_wall");
  common_scripts\utility::flag_init("FLAG_attacker_killing_player");
  common_scripts\utility::flag_init("FLAG_stop_house_attack_slowmo");
  common_scripts\utility::flag_init("FLAG_house_attack_heli_over");
  common_scripts\utility::flag_init("FLAG_house_attack_hesh_enter");
  common_scripts\utility::flag_init("FLAG_house_attack_ghosts_enter");
  common_scripts\utility::flag_init("FLAG_start_recruit_scene");
  common_scripts\utility::flag_init("FLAG_outro_recruit_part1");
  common_scripts\utility::flag_init("FLAG_outro_recruit_part2");
  common_scripts\utility::flag_init("FLAG_outro_recruit_part3");
}

init_levelvariables() {
  level.objnum = 0;
  level.aiarray = [];
  level.lastbullethint = 0;
  level.drone_death_handler = maps\homecoming_drones::drone_death_handler;
  level.drone_runner_group = [];
  level.javelintargets = [];
  level.deletabledrones = [];
  level.bunker_beach_ai = [];
  level.bunker_beach_vehicles = [];
  level.beachfrontguys = [];
  level.tower_retreaters = [];
  level.a10_strafe_groups = [];
}

global_spawn_functions() {
  maps\_utility::array_spawn_function_noteworthy("magic_bullet_shield", maps\_utility::magic_bullet_shield);
  maps\_utility::array_spawn_function_noteworthy("delete_on_goal", maps\homecoming_util::waittill_goal, 56, 1);
  maps\_utility::array_spawn_function_noteworthy("set_ai_array", maps\homecoming_util::set_ai_array);
  maps\_utility::array_spawn_function_noteworthy("default_mg_guy", maps\homecoming_util::default_mg_guy);
  maps\_utility::array_spawn_function_noteworthy("follow_path_and_animate", maps\homecoming_util::set_follow_path_and_animate);
  maps\_utility::array_spawn_function_noteworthy("vehicle_path_notifications", maps\homecoming_util::vehicle_path_notifications);
  maps\_utility::array_spawn_function_noteworthy("vehicle_set_parameters", maps\homecoming_util::vehicle_set_parameters);
  maps\homecoming_intro::intro_spawn_functions();
  maps\homecoming_beach::beach_spawn_functions();
  maps\homecoming_trench::trench_spawn_functions();
  maps\homecoming_retreat::retreat_spawn_functions();
  maps\homecoming_drones::drones_request_init();
  common_scripts\utility::array_thread(getEntArray("hide_on_load", "script_noteworthy"), maps\_utility::hide_entity);
  common_scripts\utility::array_thread(getEntArray("trigger_off", "script_noteworthy"), common_scripts\utility::trigger_off);
  common_scripts\utility::array_thread(getEntArray("smoke_trigger", "script_noteworthy"), maps\homecoming_util::smoke_trigger);
  common_scripts\utility::array_thread(getEntArray("smoke_stop_trigger", "script_noteworthy"), maps\homecoming_util::smoke_stop_trigger);
  common_scripts\utility::array_thread(getEntArray("move_up_watcher", "targetname"), maps\homecoming_util::move_up_when_clear);
  common_scripts\utility::array_thread(getEntArray("player_accessable_turret", "script_noteworthy"), maps\_chaingun_player::chaingun_turret_init, 1);
}

init_biasgroups() {
  createthreatbiasgroup("bunker_allies");
  createthreatbiasgroup("beach_enemies");
  setignoremegroup("bunker_allies", "beach_enemies");
  createthreatbiasgroup("balcony_fall_allies");
  createthreatbiasgroup("balcony_fall_enemies");
  setthreatbias("balcony_fall_allies", "balcony_fall_enemies", 10000);
  setthreatbias("balcony_fall_enemies", "balcony_fall_allies", 10000);
  createthreatbiasgroup("tower_top_marines");
  createthreatbiasgroup("trench_player_squad");
  createthreatbiasgroup("tower_ground_enemies_1");
  createthreatbiasgroup("tower_ground_enemies_2");
  setthreatbias("tower_ground_enemies_1", "tower_top_marines", 10000);
  setthreatbias("tower_top_marines", "tower_ground_enemies_1", 10000);
  setthreatbias("tower_ground_enemies_2", "trench_player_squad", 10000);
  setthreatbias("trench_player_squad", "tower_ground_enemies_2", 10000);
  setignoremegroup("trench_player_squad", "tower_ground_enemies_1");
  setignoremegroup("tower_top_marines", "tower_ground_enemies_2");
  setignoremegroup("tower_ground_enemies_2", "tower_top_marines");
}

homecoming_introscreen() {
  common_scripts\utility::flag_wait("load_setup_complete");
  maps\_introscreen::introscreen(1);
}

homecoming_objectives() {
  thread objective_start_flags();
  common_scripts\utility::flag_wait_any("TRIGFLAG_player_going_through_tent", "FLAG_nh90_ranger_dialog_done");
  objective_add(level.objnum, "active", &"HOMECOMING_OBJ_FRONTLINES");
  objective_state_nomessage(level.objnum, "current");
  common_scripts\utility::flag_wait("TRIGFLAG_player_at_balcony");
  objective_state(level.objnum, "done");
  level.objnum++;
  wait 0.1;
  objective_add(level.objnum, "active", &"HOMECOMING_OBJ_DEFEND_BEACH");
  objective_state_nomessage(level.objnum, "current");
  var_0 = level.objnum;
  common_scripts\utility::flag_wait("FLAG_balcony_fall_done");
  objective_state_nomessage(level.objnum, "active");
  level.objnum++;
  common_scripts\utility::flag_wait("FLAG_balcony_getup_done");
  objective_add(level.objnum, "active", &"HOMECOMING_OBJ_TRENCHES");
  objective_state_nomessage(level.objnum, "current");
  common_scripts\utility::flag_wait("FLAG_tower_explosion_done");
  objective_state(level.objnum, "done");
  level.objnum++;
  wait 0.1;
  objective_add(level.objnum, "active", &"HOMECOMING_OBJ_RETREAT");
  objective_state_nomessage(level.objnum, "current");
  objective_state_nomessage(var_0, "failed");
  common_scripts\utility::flag_wait("FLAG_start_elias_street");
  objective_state(level.objnum, "done");
  level.objnum++;
  wait 0.1;
  objective_add(level.objnum, "active", &"HOMECOMING_OBJ_ELIAS_HOUSE");
  objective_state_nomessage(level.objnum, "current");
  common_scripts\utility::flag_wait("FLAG_start_recruit_scene");
  objective_state_nomessage(level.objnum, "done");
}

objective_start_flags() {
  switch (level.start_point) {
    case "bunker":
      common_scripts\utility::flag_set("FLAG_nh90_ranger_dialog_done");
      break;
    case "trench":
      break;
    case "tower_retreat":
      break;
  }
}

setup_turrets() {
  var_0 = getent("bunker_turret", "targetname");
  var_1 = getent("bunker_turret_pole", "targetname");
  var_0.base = var_1;
  var_0.base linkto(var_0);
  var_0 setleftarc(65);
  var_0 setrightarc(65);
  var_0 setbottomarc(15);
  var_0 settoparc(25);
  level.balcony_turret = var_0;
  var_0 = getent("trench_turret", "targetname");
  var_1 = getent("trench_turret_pole", "targetname");
  var_0.base = var_1;
  var_0.base linkto(var_0);
  var_0 setbottomarc(15);
  var_0 setleftarc(45);
  var_0 setrightarc(45);
  var_0 settoparc(38);
  level.ground_turret = var_0;
}

start_street_sequence() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  maps\homecoming_util::alliesteletostartspot("start_osprey");
  level.player setstance("crouch");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
}

start_bunker_sequence() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  maps\homecoming_util::alliesteletostartspot("start_bunker");
  iprintlnbold("THIS START POINT DOES NOT WORK, PLEASE DO NOT SEND ME BUGS USING IT!");
  getent("start_beach_ai", "targetname") maps\_utility::notify_delay("trigger", 0.05);
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
  var_1 = getnode("movespot_bunker_entrance", "targetname");
  level.hesh setgoalnode(var_1);
  common_scripts\utility::flag_wait("FLAG_start_bunker");
  level.hesh thread maps\_utility::follow_path_and_animate(common_scripts\utility::getstruct("intro_street_hesh_path_4", "targetname"), 999999);
}

start_bunker_artillery_sequence() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  maps\homecoming_util::alliesteletostartspot("start_inside_bunker");
  common_scripts\utility::flag_set("FLAG_start_artillery_sequence");
  var_1 = getnode("movespot_bunker", "targetname");
  level.hesh setgoalnode(var_1);
  maps\_utility::disable_trigger_with_targetname("player_top_bunker_trig");
  maps\_utility::disable_trigger_with_targetname("player_inside_bunker");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
}

start_bunker_wave2_sequence() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  maps\homecoming_util::alliesteletostartspot("start_inside_bunker");
  common_scripts\utility::flag_set("FLAG_start_artillery_sequence");
  var_1 = getnode("movespot_bunker", "targetname");
  level.hesh setgoalnode(var_1);
  common_scripts\utility::flag_set("FLAG_artillery_sequence_done");
  var_2 = getent("bunker_turret", "targetname");
  var_3 = getent("bunker_mg_nonbroken", "targetname");
  var_4 = getent("bunker_mg_broken", "targetname");
  var_3 delete();
  var_4 show();
  var_2 notify("stop_using_built_in_burst_fire");
  var_2 notify("stopfiring");
  var_2 delete();
  var_3 = getent("bunker_roof_nonbroken", "targetname");
  var_4 = getent("bunker_roof_broken", "targetname");
  var_4 show();
  var_3 delete();
  maps\_utility::disable_trigger_with_targetname("player_top_bunker_trig");
  maps\_utility::disable_trigger_with_targetname("player_inside_bunker");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
}

start_beach_ambient() {
  maps\homecoming_util::alliesteletostartspot("start_inside_bunker");
  thread maps\homecoming_beach_ambient::init_beach_ambient();
}

start_trenches_sequence() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  maps\homecoming_util::alliesteletostartspot("start_trenches");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
  thread maps\homecoming_util::player_kill_quad((-2056, 3952, -20), (-1652, 4132, 88), "tower_garage_door_closed");
  common_scripts\utility::flag_set("FLAG_hesh_balcony_wave");
  thread maps\homecoming_util::set_mortar_on(1);
  level.hesh maps\_utility::set_force_color("r");
  maps\_vehicle::spawn_vehicle_from_targetname("trench_artemis");
  thread maps\homecoming_util::a10_vista_strafe_group("vista_pier_a10s");
  thread maps\homecoming_util::a10_vista_strafe_group("vista_ship_a10s");
  common_scripts\utility::flag_set("FLAG_start_trenches");
}

start_trenches2_sequence() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  maps\homecoming_util::alliesteletostartspot("start_trenches_part2");
  level.player setthreatbiasgroup("trench_player_squad");
  level.hesh setthreatbiasgroup("trench_player_squad");
  level.hesh maps\_utility::set_force_color("r");
  level.hesh maps\homecoming_util::set_ai_array("trench_main_friendlies");
  thread maps\homecoming_trench::beach_trenches_part2_dialogue();
  thread maps\homecoming_util::a10_vista_strafe_group("vista_pier_a10s");
  maps\_utility::activate_trigger("trenches_moveup_trig4", "targetname");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
}

start_tower_retreat() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  common_scripts\utility::flag_set("FLAG_start_tower_retreat");
  common_scripts\utility::flag_set("FLAG_tower_explosion_done");
  common_scripts\utility::flag_set("FLAG_trench_respawner_2");
  var_1 = getEntArray("retreat_start_friendlies", "targetname");

  foreach(var_3 in var_1)
  var_3 maps\_utility::add_spawn_function(maps\homecoming_trench::trench_main_friendlies);

  maps\_utility::array_spawn(var_1);
  level.hesh maps\_utility::set_force_color("r");
  maps\homecoming_util::alliesteletostartspot("start_tower_retreat");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
}

start_elias_street() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  common_scripts\utility::flag_set("FLAG_start_elias_street");
  common_scripts\utility::flag_set("TRIGFLAG_player_leaving_tower_parking_area");
  maps\homecoming_util::alliesteletostartspot("start_elias_street");
  level.heroes thread maps\homecoming_util::heroes_move("movespot_elias_street_1");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
}

start_elias_house() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  common_scripts\utility::flag_set("FLAG_start_elias_house");
  level.dog = maps\homecoming_util::dog_spawn();
  level.heroes = common_scripts\utility::array_add(level.heroes, level.dog);
  common_scripts\utility::exploder("elias_entrance_smoke_start");
  maps\homecoming_util::alliesteletostartspot("start_elias_house");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
}

start_elias_house_attack() {
  var_0 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  common_scripts\utility::flag_set("FLAG_start_elias_house_attack");
  maps\homecoming_util::alliesteletostartspot("start_elias_house_attack");
  var_0 thread maps\_hud_util::fade_over_time(0, 1);
  maps\_utility::delaythread(1, maps\_utility::flavorbursts_off);
}

start_recruit_scene() {
  level.black_overlay = maps\_hud_util::create_client_overlay("black", 1, level.player);
  thread maps\homecoming_recruits::recruits_dog_spawn();
  common_scripts\utility::flag_set("FLAG_start_recruit_scene");
}

start_tower_explosion_test() {
  wait 1;
  var_0 = getEntArray("trench_tower_pieces", "targetname");

  for(;;) {
    maps\homecoming_trench::trench_tower_explosion_scene();
    wait 10;
    var_1 = getEntArray("guard_tower_intact", "targetname");
    var_2 = getEntArray("guard_tower_base", "targetname");
    common_scripts\utility::array_thread(var_1, maps\_utility::show_entity);
    common_scripts\utility::array_thread(var_2, maps\_utility::show_entity);
    common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
    common_scripts\utility::array_thread(var_0, maps\_utility::anim_stopanimscripted);
    maps\_utility::stop_exploder("tower_exp");
    wait 2;
  }
}

start_a10_showcase() {
  level.strafecooldown = 0;

  switch (level.start_point) {
    case "a10_bunker":
      thread maps\homecoming_a10::a10_strafe_mechanic("bunker_player_a10_strafe_1");
      break;
    case "a10_trench":
      thread maps\homecoming_a10::a10_strafe_mechanic("player_a10_trench_area_3");
      break;
    case "a10_tower":
      thread maps\homecoming_a10::a10_strafe_mechanic("tower_player_a10_strafe");
      break;
  }
}

start_a10_test() {
  maps\homecoming_util::alliesteletostartspot("start_inside_bunker");
  var_0 = getEntArray("beach_frontline_drones", "targetname");
  common_scripts\utility::array_thread(var_0, maps\homecoming_drones::drone_spawn);
  common_scripts\utility::array_thread(getnodearray("beach_front_nodes", "targetname"), maps\homecoming_beach::beach_front_nodes_think);
  var_1 = getEntArray("beach_front_attackers", "targetname");
  common_scripts\utility::array_thread(var_1, maps\homecoming_beach::bunker_beach_attackers);
  var_0 = getEntArray("bunker_enemy_cover_drones", "targetname");
  common_scripts\utility::array_thread(var_0, maps\homecoming_beach::bunker_enemy_cover_drones);
  var_2 = getEntArray("beach_front_runners", "targetname");

  foreach(var_4 in var_2) {
    var_5 = 0;

    if(isDefined(var_4.script_wait))
      var_5 = var_4.script_wait;

    var_4 maps\_utility::delaythread(var_5, maps\homecoming_drones::beach_path_drones);
  }

  var_7 = common_scripts\utility::getstructarray("hovercraft_drone_fightspots_reference", "targetname");

  foreach(var_9 in var_7) {
    var_10 = var_9 maps\_utility::get_linked_structs();
    common_scripts\utility::array_thread(var_10, maps\homecoming_drones::hovercraft_drone_fightspots);
  }

  thread maps\homecoming_beach_ambient::beach_ambient_helicopters();
}

start_balcony_fall() {
  maps\homecoming_util::alliesteletostartspot("start_inside_bunker");
  level.balcony = maps\homecoming_beach::bunker_balcony_setup();
  maps\homecoming_beach::bunker_balcony_damage_state(level.balcony);
  var_0 = getglassarray("balcony_glass");

  foreach(var_2 in var_0)
  deleteglass(var_2);

  maps\homecoming_beach::player_fall_off_balcony();
  common_scripts\utility::flag_wait("FLAG_balcony_getup_done");
  common_scripts\utility::flag_set("FLAG_start_trenches");
  maps\homecoming_trench::beach_sequence_trenches();
}

start_dog_reunite() {
  maps\homecoming_util::alliesteletostartspot("start_elias_street");
  maps\homecoming_retreat::dog_reunite();
}

start_artillery_test() {
  maps\homecoming_util::alliesteletostartspot("start_inside_bunker");
  maps\homecoming_beach::bunker_balcony_setup();
  level.balconystumblers = [];
  var_0 = getEntArray("balcony_artillery_stumble_testers", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_utility::spawn_ai();
    var_3 maps\_utility::magic_bullet_shield();
    var_3.animname = var_2.script_noteworthy;
    var_4 = getnode(var_2.script_linkto, "script_linkname");
    var_5 = spawn("script_origin", var_4.origin);
    var_5.angles = var_4.angles;
    var_5.script_noteworthy = var_4.script_noteworthy;
    var_5 linkto(level.balcony[var_4.script_noteworthy]);
    var_3.balconyent = var_5;
    level.balconystumblers = common_scripts\utility::array_add(level.balconystumblers, var_3);
  }

  maps\homecoming_beach::wave1_hovercraft_missile_barrage();
}

start_hind_test() {
  maps\homecoming_util::alliesteletostartspot("start_inside_bunker");
  level.balconystumblers = [];
  var_0 = getEntArray("balcony_artillery_stumble_testers", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_utility::spawn_ai();
    var_3 maps\_utility::magic_bullet_shield();
    var_3.animname = var_2.script_noteworthy;
    var_4 = getnode(var_2.script_linkto, "script_linkname");
    var_5 = spawn("script_origin", var_4.origin);
    var_5.angles = var_4.angles;
    var_5.script_noteworthy = var_4.script_noteworthy;
    var_3.balconyent = var_5;
    level.balconystumblers = common_scripts\utility::array_add(level.balconystumblers, var_3);
  }

  maps\homecoming_beach::beach_wave2_inithinds();
}

#using_animtree("generic_human");

start_knife_test() {
  var_0 = common_scripts\utility::getstruct("elias_house_attack_sequence", "targetname");
  var_1 = spawn("script_model", level.player.origin);
  var_1 character\character_elite_pmc_assault_a_black::main();
  var_1 useanimtree(#animtree);
  var_1.animname = "elite";
  level.knife = spawn("script_model", var_1.origin);
  level.knife setModel("weapon_parabolic_knife");
  level.knife linkto(var_1, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  maps\homecoming_util::cinematicmode_on(1);
  level.player playerlinktoabsolute(var_2, "tag_player");
  var_3 = [var_2, var_1];
  var_0 thread maps\_anim::anim_single(var_3, "house_attack_grab");
  wait 9;
  maps\homecoming_retreat::elias_house_attack_knife_think(var_0, var_3);
}

init_mainai() {
  level.heroes = [];
  var_0 = getEntArray("main_ai", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_utility::spawn_ai(1, 1);
    var_3 maps\_utility::make_hero();
    var_3.animname = var_2.script_noteworthy;
    var_3.script_noteworthy = var_2.script_noteworthy;

    if(var_2.script_noteworthy == "hesh") {
      level.hesh = var_3;
      var_3 thread maps\_utility::set_ai_bcvoice("delta");
      var_3.name = "Hesh";
      var_3 attach("weapon_mts_255_small", "tag_stowed_back");
      var_3 animscripts\init::initweapon("r5rgp+eotech_sp+grip_sp");
      var_3 animscripts\shared::placeweaponon("r5rgp+eotech_sp+grip_sp", "right");
    }

    level.heroes[level.heroes.size] = var_3;
  }
}

setup_motion_blur() {
  if(maps\_utility::is_gen4()) {
    if(!isDefined(level.console) || !level.console) {
      return;
    }
    setsaveddvar("r_mbEnable", 0);
  }
}

set_default_mb_values() {
  setsaveddvar("r_mbEnable", 2);
  setsaveddvar("r_mbCameraRotationInfluence", 0.25);
  setsaveddvar("r_mbCameraTranslationInfluence", 0.01);
  setsaveddvar("r_mbModelVelocityScalar", 0.1);
  setsaveddvar("r_mbStaticVelocityScalar", 0.2);
  setsaveddvar("r_mbViewModelEnable", 0);
}

prone_hint_off() {
  if(common_scripts\utility::flag("FLAG_player_went_prone"))
    return 1;

  if(common_scripts\utility::flag("TRIGFLAG_player_through_beam_blocker"))
    return 1;

  if(!common_scripts\utility::flag("player_not_doing_strafe"))
    return 1;

  if(!common_scripts\utility::flag("FLAG_start_trenches") && !common_scripts\utility::flag("FLAG_hind_is_targeting_player"))
    return 1;

  var_0 = level.player getstance();

  if(var_0 == "prone") {
    common_scripts\utility::flag_set("FLAG_player_went_prone");
    return 1;
  }

  return 0;
}