/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\contingency.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_blizzard;
#include maps\_vehicle;
#include maps\_stealth_utility;
#include maps\_stealth_shared_utilities;
#include maps\contingency_anim;

main() {
  level.price_destroys_btr = false;
  setsaveddvar("sm_sunShadowScale", 0.5);
  setsaveddvar("r_lightGridEnableTweaks", 1);
  setsaveddvar("r_lightGridIntensity", 1.24);
  setsaveddvar("r_lightGridContrast", 0);

  level.min_btr_fighting_range = 400;
  level.explosion_dist_sense = 1500;
  level.default_goalradius = 7200;
  level.goodFriendlyDistanceFromPlayerSquared = 250 * 250;
  level.corpse_behavior_doesnt_require_player_sight = true;
  level.attackheliRange = 7000;
  level.min_time_between_uav_launches = 24 * 1000;
  level.dont_use_global_uav_kill_dialog = true;
  PreCacheItem("remote_missile_snow");
  level.remote_missile_snow = true;

  level.bcs_maxTalkingDistFromPlayer = 5000;

  level.visionThermalDefault = "contingency_thermal_inverted";
  level.VISION_UAV = "contingency_thermal_inverted";
  level.cosine["60"] = cos(60);
  level.cosine["70"] = cos(70);

  SetThermalBodyMaterial("thermalbody_snowlevel");
  level.friendly_thermal_Reflector_Effect = loadfx("misc/thermal_tapereflect");

  PreCacheRumble("tank_rumble");
  precacheItem("remote_missile_not_player");
  precacheModel("com_computer_keyboard_obj");
  PrecacheNightVisionCodeAssets();

  default_start(::start_start);
  add_start("start", ::start_start, "Start");

  add_start("slide", ::start_slide, "Slide");
  add_start("woods", ::start_woods, "Woods");
  add_start("midwoods", ::start_midwoods, "mid woods");
  add_start("ridge", ::start_ridge, "ridge");

  add_start("base", ::start_base, "Base");
  add_start("defend_sub", ::start_defend_sub, "defend_sub");

  maps\contingency_precache::main();
  maps\createart\contingency_fog::main();
  maps\contingency_fx::main();
  maps\contingency_anim::main_anim();

  maps\_attack_heli::preLoad();

  build_light_override("btr80", "vehicle_btr80", "spotlight", "TAG_FRONT_LIGHT_RIGHT", "misc/spotlight_btr80_daytime", "spotlight", 0.2);
  build_light_override("btr80", "vehicle_btr80", "spotlight_turret", "TAG_TURRET_LIGHT", "misc/spotlight_btr80_daytime", "spotlight_turret", 0.0);

  level.weaponClipModels = [];
  level.weaponClipModels[0] = "weapon_m16_clip";
  level.weaponClipModels[1] = "weapon_kriss_clip";
  level.weaponClipModels[2] = "weapon_ak47_tactical_clip";
  level.weaponClipModels[3] = "weapon_m4_clip";
  level.weaponClipModels[4] = "weapon_magpul_masada_clip";
  level.weaponClipModels[5] = "weapon_dragunov_clip";
  level.weaponClipModels[6] = "weapon_famas_clip";

  level.dead_vehicles = [];

  precacheString(&"CONTINGENCY_TIME_TO_ENTER_SUB");
  precacheString(&"CONTINGENCY_LINE1");
  precacheString(&"CONTINGENCY_LINE2");
  precacheString(&"CONTINGENCY_LINE3");
  precacheString(&"CONTINGENCY_LINE4");
  precacheString(&"CONTINGENCY_LINE5");

  precacheString(&"CONTINGENCY_OBJ_DEFEND_SUB");
  precacheString(&"CONTINGENCY_OBJ_ENTER_SUB");
  precacheString(&"CONTINGENCY_OBJ_CONTROL_SUB");
  precacheString(&"CONTINGENCY_OBJ_TURN_KEY");
  precacheString(&"CONTINGENCY_OBJ_EXIT_SUB");
  precacheString(&"CONTINGENCY_OBJ_DEFEND");
  precacheString(&"CONTINGENCY_SUB_TIMER_EXPIRED");
  precacheString(&"CONTINGENCY_OBJ_ENTER_BASE");
  precacheString(&"CONTINGENCY_OBJ_PRICE");
  precacheString(&"CONTINGENCY_USE_DRONE");
  precacheString(&"CONTINGENCY_TURN_KEY");
  precacheString(&"CONTINGENCY_DONT_LEAVE");
  precacheString(&"CONTINGENCY_DONT_LEAVE_FAILURE");

  maps\_load::main();
  maps\_load::set_player_viewhand_model("viewhands_player_arctic_wind");
  thread maps\contingency_amb::main();

  maps\createart\contingency_art::main();

  maps\_remotemissile::init();

  maps\_compass::setupMiniMap("compass_map_contingency");

  createThreatBiasGroup("bridge_guys");
  createThreatBiasGroup("truck_guys");
  createThreatBiasGroup("bridge_stealth_guys");
  createThreatBiasGroup("dogs");
  createThreatBiasGroup("price");
  createThreatBiasGroup("player");
  createThreatBiasGroup("end_patrol");
  level.player setthreatbiasgroup("player");

  SetIgnoreMeGroup("price", "dogs");

  setthreatbias("player", "bridge_stealth_guys", 1000);
  setthreatbias("player", "truck_guys", 1000);

  precacheItem("at4_straight");
  precacheItem("rpg_straight");
  precacheItem("zippy_rockets");
  precacheItem("zippy_rockets_inverted");
  precacheItem("semtex_grenade");
  precacheItem("facemask");

  flag_init("saying_base_on_alert");
  flag_init("said_second_uav_in_position");
  flag_init("everyone_set_green");
  flag_init("said_convoy_coming");
  flag_init("saying_patience");
  flag_init("stop_stealth_music");
  flag_init("price_starts_moving");

  flag_init("all_bridge_guys_dead");
  thread flag_when_all_bridge_guys_dead();
  thread flag_when_second_group_of_stragglers_are_dead();
  flag_init("second_group_of_stragglers_are_dead");
  flag_init("saying_contact");
  flag_init("said_follow_me");
  flag_init("someone_became_alert");
  flag_init("price_is_hiding");
  flag_init("truck_guys_alerted");
  flag_init("jeep_stopped");
  flag_init("convoy_hide_section_complete");

  flag_init("attach_rocket");
  flag_init("fire_rocket");
  flag_init("drop_rocket");

  flag_init("done_with_exploding_trees");

  flag_init("first_uav_spawned");
  flag_init("first_uav_destroyed");
  flag_init("second_uav_in_position");
  flag_init("rasta_and_bricktop_dialog_done");
  flag_init("player_turned_key");
  flag_init("player_in_uaz");

  flag_init("time_to_use_UAV");
  flag_init("both_gauntlets_destroyed");
  flag_init("time_to_race_to_submarine");
  flag_init("player_key_rdy");
  flag_init("close_sub_hatch");

  maps\_idle::idle_main();
  maps\_idle_coffee::main();
  maps\_idle_smoke::main();
  maps\_idle_lean_smoke::main();
  maps\_idle_phone::main();
  maps\_idle_sleep::main();
  maps\_idle_sit_load_ak::main();

  animscripts\dog\dog_init::initDogAnimations();
  maps\_patrol_anims::main();

  maps\_dynamic_run_speed::main();
  maps\_stealth::main();
  stealth_settings();
  thread stealth_music_control();

  thread dialog_we_are_spotted();
  thread dialog_stealth_recovery();
  thread dialog_price_kill();
  thread dialog_price_kill_dog();
  thread dialog_player_kill_master();
  thread dialog_enemy_saw_corpse();

  level.player.remotemissile_actionslot = 4;
  level.player thread maps\_remotemissile::RemoteMissileDetonatorNotify();

  level.player stealth_plugin_basic();
  level.player thread playerSnowFootsteps();
  player_speed_percent(90);

  destroyable_trees = getEntArray("trigger_tree_explosion", "targetname");
  foreach(trigger in destroyable_trees)
  trigger thread setup_destroyable_tree();

  truck_patrol_vehicles = getEntArray("truck_patrol", "targetname");
  array_thread(truck_patrol_vehicles, ::add_spawn_function, ::setup_bridge_trucks);
  truck_guys = getEntArray("truck_guys", "script_noteworthy");
  array_thread(truck_guys, ::add_spawn_function, ::base_truck_guys_think);

  rasta_spawners = getEntArray("rasta", "script_noteworthy");
  array_thread(rasta_spawners, ::add_spawn_function, ::setup_rasta);

  bricktop_spawners = getEntArray("bricktop", "script_noteworthy");
  array_thread(bricktop_spawners, ::add_spawn_function, ::setup_bricktop);

  village_redshirt = getEntArray("village_redshirt", "script_noteworthy");
  if(isDefined(village_redshirt))
    array_thread(village_redshirt, ::add_spawn_function, ::setup_village_redshirt);

  start_of_base_redshirt = getEntArray("start_of_base_redshirt", "script_noteworthy");
  if(isDefined(start_of_base_redshirt))
    array_thread(start_of_base_redshirt, ::add_spawn_function, ::setup_base_redshirt);

  level.village_defenders_dead = 0;
  village_defenders = getEntArray("village_defenders", "targetname");
  array_thread(village_defenders, ::add_spawn_function, ::setup_village_defenders);

  base_starting_guys = getEntArray("base_starting_guys", "script_noteworthy");
  array_thread(base_starting_guys, ::add_spawn_function, ::setup_base_starting_guys);

  base_vehicles = getEntArray("base_vehicles", "script_noteworthy");
  array_thread(base_vehicles, ::add_spawn_function, ::setup_base_vehicles);

  base_troop_transport1 = getent("base_troop_transport1", "targetname");
  base_troop_transport1 add_spawn_function(::unload_when_close_to_player);
  base_troop_transport1 add_spawn_function(::dialog_destroyed_vehicle, "cont_cmt_goodkilltruck");

  base_troop_transport2 = getent("base_troop_transport2", "targetname");
  base_troop_transport2 add_spawn_function(::unload_when_close_to_player);
  base_troop_transport2 add_spawn_function(::dialog_destroyed_vehicle, "cont_cmt_goodkilltruck");

  base_truck2 = getent("base_truck2", "targetname");
  base_truck2 add_spawn_function(::unload_when_close_to_player);
  base_truck2 add_spawn_function(::dialog_destroyed_vehicle, "cont_cmt_directhitjeep");

  price_spawner = getent("price", "script_noteworthy");
  price_spawner add_spawn_function(::setup_price);
  price_spawner add_spawn_function(::set_threatbias_group, "price");

  add_global_spawn_function("axis", ::setup_remote_missile_target_guy);

  add_global_spawn_function("axis", ::setup_count_predator_infantry_kills);

  thread dialog_handle_predator_infantry_kills();

  flag_init("base_troop_transport2_spawned");
  base_troop_transport2 = getent("base_troop_transport2", "targetname");
  base_troop_transport2 add_spawn_function(::flag_set, "base_troop_transport2_spawned");

  village_truck_guys = getEntArray("village_truck_guys", "script_noteworthy");
  array_thread(village_truck_guys, ::add_spawn_function, ::village_truck_guys_setup);

  sub_ladder = getent("sub_ladder", "targetname");
  sub_ladder.realOrigin = sub_ladder.origin;
  sub_ladder.origin += (0, 0, -10000);

  thread setup_sub_hatch();

  thread setup_dont_leave_failure();
  thread setup_dont_leave_hint();
  add_hint_string("hint_dont_leave_price", &"CONTINGENCY_DONT_LEAVE", ::should_break_dont_leave);
  add_hint_string("hint_predator_drone", &"HELLFIRE_USE_DRONE", ::should_break_use_drone);
  add_hint_string("hint_steer_drone", &"SCRIPT_PLATFORM_STEER_DRONE", ::should_break_steer_drone);

  thread objective_main();
}

tons_of_health() {
  self.health = 100000;
}

start_start() {
  thread handle_start();
}

start_base() {
  start = getstruct("base_start_player", "targetname");
  level.player setOrigin(start.origin);
  level.player setPlayerAngles(start.angles);

  friendlies = getEntArray("start_friendly", "targetname");
  friendlies2 = getEntArray("rasta_and_bricktop", "targetname");
  friendlies = array_combine(friendlies, friendlies2);

  friendly_starts = getStructArray("base_start_friendly", "targetname");

  for(i = 0; i < friendlies.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }
  wait .1;

  level.price.colornode_func = ::dialog_moving_to_new_position_in_village;
  level.price forceUseWeapon("aug_scope", "primary");

  thread spawn_second_uav();
  flag_set("player_on_ridge");
  flag_set("leaving_village");
  thread handle_base();
}

start_defend_sub() {
  start = getstruct("defend_sub_start_player", "targetname");
  level.player setOrigin(start.origin);
  level.player setPlayerAngles(start.angles);

  friendlies = getEntArray("start_friendly", "targetname");
  friendlies2 = getEntArray("rasta_and_bricktop", "targetname");
  friendlies = array_combine(friendlies, friendlies2);

  friendly_starts = getStructArray("defend_sub_start_friendly", "targetname");

  for(i = 0; i < friendlies.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }
  flag_set("stop_stealth_music");
  music_stop();

  level.player takeallweapons();
  level.player giveWeapon("aa12");
  level.player giveWeapon("m240_heartbeat_reflex_arctic");
  level.player switchToWeapon("m240_heartbeat_reflex_arctic");

  level.player giveWeapon("fraggrenade");
  level.player setOffhandSecondaryClass("flash");
  level.player giveWeapon("flash_grenade");

  wait .1;

  level.rasta set_force_color("g");
  level.rasta enable_ai_color();
  level.bricktop set_force_color("g");
  level.bricktop enable_ai_color();
  level.price set_force_color("g");
  level.price enable_ai_color();

  level.price forceUseWeapon("aug_scope", "primary");

  disable_stealth_system();

  friendlies = getaiarray("allies");
  foreach(g in friendlies)
  g thread turn_off_stealth_settings();

  thread spawn_second_uav();
  flag_set("player_on_ridge");
  flag_set("leaving_village");
  flag_set("base_alerted");

  thread base_arrival_music();

  thread handle_defend_sub();
}

dialog_i_cant_see_roach() {
  wait 4;

  thread radio_dialogue("cont_cmt_barelysee");
}

handle_start() {
  thread dialog_i_cant_see_roach();

  maps\_introscreen::contingency_black_screen_intro();

  price_spawner = getent("price", "script_noteworthy");
  price_spawner spawn_ai();

  thread cargo_choppers();
  thread price_intro_anim();

  thread dialog_lets_follow_quietly();

  flag_wait("start_first_patrol");

  autosave_by_name("start_first_patrol");
  first_patrol = getEntArray("first_patrol", "targetname");
  foreach(guy in first_patrol) {
    guy thread spawn_with_delays();
  }

  flag_wait("price_starts_moving");
  flag_wait("patrol_in_sight");

  thread hide_and_kill_first_stragglers();
  thread hide_and_kill_everyone();

  thread dialog_first_patrol_spotted();

  flag_wait("start_truck_patrol");

  if(!flag("cross_bridge_patrol_dead") && !flag("first_stragglers_dead") && !flag("rightside_patrol_dead"))
    thread autosave_stealth();

  level.price.ignoreall = true;

  thread spawn_vehicles_from_targetname_and_drive("truck_patrol");

  wait 1;

  thread dialog_convoy_coming();

  flag_wait_any("last_truck_left", "player_is_crossing_bridge", "all_bridge_guys_dead");

  level.price notify("stop_smart_path_following");
  price_rdy_vs_stragglers = getnode("price_rdy_vs_stragglers", "targetname");
  level.price thread price_smart_path_following(price_rdy_vs_stragglers);

  level.price thread friendly_adjust_movement_speed();

  flag_wait("price_slide_prep");

  level.price.ignoreall = false;
  thread handle_slide();
}

start_slide() {
  start = getstruct("slide_start_player", "targetname");
  level.player setOrigin(start.origin);
  level.player setPlayerAngles(start.angles);

  friendlies = getEntArray("start_friendly", "targetname");

  friendly_starts = getStructArray("slide_start_friendly", "targetname");

  for(i = 0; i < friendlies.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }
  wait .1;

  level.price enable_cqbwalk();

  thread handle_slide();
}

/using_animtree( "generic_human" );
handle_slide() {
  price_destroys_btr = level.price_destroys_btr;
  thread cargo_choppers2();

  level.price notify("stop_smart_path_following");

  price_pre_slide_node = getnode("price_fire_loc", "targetname");

  price_pre_slide_node thread Price_Caution_Stop();

  flag_wait("start_btr_slide");
  autosave_stealth();
  println("hit flag");
  println("anim starting");

  level.price notify("stop_adjust_movement_speed");

  thread setup_tree_destroyer();

  level.btr_slider = spawn_vehicle_from_targetname("btr_slider");
  level.btr_slider thread vehicle_lights_on("spotlight spotlight_turret");
  level.btr_sliderthread maps\_vehicle::damage_hints();

  level.btr_slider thread fake_treads();

  level.btr_slider.animname = "contingency_btr_slide";

  btr81_slide_node = getstruct("btr81_slide_node", "targetname");

  btr81_slide_node thread anim_single_solo(level.btr_slider, "contingency_btr_slide");
  level.btr_slider playSound("scn_con_bmp_skid");

  wait_to_hide = 2.8;
  wait wait_to_hide;

  level notify("run_to_woods");
  level.price anim_stopanimscripted();
  level.price thread dialogue_queue("cont_pri_incoming");

  thread stealth_ai_ignore_tree_explosions();

  thread dialog_into_the_woods();

  thread end_of_tree_explosions();

  level.price pushplayer(true);

  level.price thread disable_cqbwalk();

  level.price.sprint = true;
  level.price.moveplaybackrate = .9;
  level.price thread faster_price_if_player_close();
  price_into_the_woods_path = getnode("price_into_the_woods_path", "targetname");
  level.price thread follow_path(price_into_the_woods_path);

  thread handle_woods();
}

start_woods() {
  start = getstruct("woods_start_player", "targetname");
  level.player setOrigin(start.origin);
  level.player setPlayerAngles(start.angles);

  friendlies = getEntArray("start_friendly", "targetname");

  friendly_starts = getStructArray("woods_start_friendly", "targetname");

  for(i = 0; i < friendlies.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }
  wait .1;

  level.price thread disable_cqbwalk();
  level.price.moveplaybackrate = 1.2;
  level.price.goalradius = 64;
  level.price setgoalpos((-28257.9, -8877.1, 840.5));

  thread handle_woods();
}

start_midwoods() {
  start = getstruct("midwoods_start_player", "targetname");
  level.player setOrigin(start.origin);
  level.player setPlayerAngles(start.angles);

  friendlies = getEntArray("start_friendly", "targetname");

  friendly_starts = getStructArray("midwoods_start_friendly", "targetname");

  for(i = 0; i < friendlies.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }
  wait .1;

  flag_set("safe_from_btrs");
  level.price thread enable_cqbwalk();
  woods_stealth_path_start = getnode("price_overlook_stream", "targetname");
  level.price thread price_smart_path_following(woods_stealth_path_start);

  thread dialog_russians_looking_for_you();
  thread handle_midwoods();
}

handle_woods() {
  flag_wait("safe_from_btrs");

  thread monitor_player_returns_to_btrs();

  enemies = GetAISpeciesArray("axis", "all");
  foreach(guy in enemies) {
    if(distance(level.player.origin, guy.origin) > 1500)
      guy delete();
  }

  thread dialog_russians_looking_for_you();

  level.price notify("_utility::follow_path");
  level.price notify("stop_going_to_node");

  level.price.moveplaybackrate = 1;

  level.price pushplayer(true);
  sight_ranges_foggy_woods();
  level.price_maxsightdistsqrd_woods = 40 * 40;
  level.price.maxsightdistsqrd = level.price_maxsightdistsqrd_woods;

  level.price thread dialogue_queue("cont_pri_slowdown");

  autosave_stealth();

  level.price.sprint = undefined;
  level.price thread enable_cqbwalk();
  woods_stealth_path_start = getnode("price_woods_path_start", "targetname");
  level.price thread price_smart_path_following(woods_stealth_path_start);

  thread handle_midwoods();
}

handle_midwoods() {
  sight_ranges_foggy_woods();
  thread dialog_looking_for_us();
  thread dialog_woods_first_patrol();
  thread dialog_woods_first_dog_patrol();
  thread dialog_woods_second_dog_patrol();
  thread dialog_woods_first_stationary();
  thread dialog_woods_blocking_stationary();

  thread handle_ridge();
}

start_ridge() {
  start = getstruct("ridge_start_player", "targetname");
  level.player setOrigin(start.origin);
  level.player setPlayerAngles(start.angles);

  friendlies = getEntArray("start_friendly", "targetname");

  friendly_starts = getStructArray("ridge_start_friendly", "targetname");

  for(i = 0; i < friendlies.size; i++) {
    friendlies[i].origin = friendly_starts[i].origin;
    friendlies[i].angles = friendly_starts[i].angles;
    friendlies[i] spawn_ai();
  }
  wait .1;

  thread handle_ridge();
}

first_uav_sequence() {
  if((isalive(level.gauntlet_east)) && (isalive(level.gauntlet_west))) {
    flag_set("first_uav_spawned");
    thread dialog_approaching_ridge();

    level.uav = spawn_vehicle_from_targetname_and_drive("first_uav");
    level.uav playLoopSound("uav_engine_loop");
    level.uavRig = spawn("script_model", level.uav.origin);
    level.uavRig setModel("tag_origin");
    thread UAVRigAiming();
  }
  flag_wait("player_on_ridge");

  if(stealth_is_everything_normal()) {
    enemies = GetAISpeciesArray("axis", "all");
    foreach(mf in enemies) {
      if(!(mf cansee(level.player)))
        mf delete();
    }
    disable_stealth_system();
  } else {
    disable_stealth_system();
    enemies = GetAISpeciesArray("axis", "all");
    foreach(mf in enemies) {
      if(distance(mf.origin, level.player.origin) > 2300)
        mf delete();
      else
        mf thread setup_stealth_enemy_cleanup();
    }

    enemies = GetAISpeciesArray("axis", "all");
    level.stealth_enemies_remaining = enemies.size;
    while(level.stealth_enemies_remaining > 0)
      wait 1;
  }
  level.price thread disable_cqbwalk();

  flag_wait("price_on_ridge");

  if((isalive(level.gauntlet_east)) && (isalive(level.gauntlet_west))) {
    level.last_uav_launch_time = gettime();

    level.player.has_remote_detonator = true;
    level.player giveWeapon("remote_missile_detonator");
    level.player SetActionSlot(4, "weapon", "remote_missile_detonator");

    if(!flag("player_slid_down")) {
      level.price dialogue_queue("cont_pri_ridgeisperfect");

      level.price dialogue_queue("cont_pri_controluav");

      level.player thread display_hint("hint_predator_drone");
    }

    if(!flag("going_down_ridge"))
      wait 3;

    if(!flag("going_down_ridge") && (!isDefined(level.player.is_controlling_UAV)))
      wait 3;
  } else {
    level.last_uav_launch_time = gettime();
    level.player.has_remote_detonator = true;
    level.player giveWeapon("remote_missile_detonator");
    level.player SetActionSlot(4, "weapon", "remote_missile_detonator");
  }

  if((isalive(level.gauntlet_east)) && (isalive(level.gauntlet_west))) {
    flag_set("first_uav_destroyed");

    gauntlet_west = getent("gauntlet_west", "targetname");
    stinger_source = spawn("script_origin", gauntlet_west.origin + (0, 0, 220));

    fire_stinger_at_uav(stinger_source);

    dialog_gauntlet_surprise_reaction();
  }

  if(!flag("going_down_ridge")) {
    level.price thread dialogue_queue("cont_pri_roachletsgo");
  }

  flag_set("going_down_ridge");
}

handle_ridge() {
  rasta_spawners = getEntArray("rasta", "script_noteworthy");
  array_thread(rasta_spawners, ::add_spawn_function, ::setup_rasta_village);

  bricktop_spawners = getEntArray("bricktop", "script_noteworthy");
  array_thread(bricktop_spawners, ::add_spawn_function, ::setup_bricktop_village);

  thread price_slides_down_the_ridge();

  level.price thread enable_cqbwalk();

  flag_wait("approaching_ridge");

  level notify("stop_snow");

  level.gauntlet_east = spawn_vehicle_from_targetname("gauntlet_east");
  level.gauntlet_west = spawn_vehicle_from_targetname("gauntlet_west");

  level.price disable_ai_color();
  level.price notify("stop_smart_path_following");
  ridge_price_overlook = getnode("ridge_price_overlook", "targetname");
  level.price setgoalnode(ridge_price_overlook);
  level.price.goalradius = 64;
  level.price notify("stop_dynamic_run_speed");

  thread first_uav_sequence();

  flag_wait("player_slid_down");
  flag_set("stop_stealth_music");

  thread dialog_roach_change_guns();

  if(isalive(level.btr_slider))
    level.btr_slider delete();
  if(isalive(level.btr_tree_destroyer))
    level.btr_tree_destroyer delete();

  thread price_changes_weapons();

  autosave_by_name("village_fight");

  thread save_when_x_are_killed();

  first_villagers = getEntArray("first_villagers", "targetname");
  foreach(guy in first_villagers)
  guy spawn_ai();

  disable_stealth_system();
  flag_clear("_stealth_spotted");

  thread spawn_ghosts_team();

  if(isalive(level.gauntlet_east))
    level.gauntlet_east waittill("death");

  if(isalive(level.gauntlet_west))
    level.gauntlet_west waittill("death");

  flag_set("both_gauntlets_destroyed");

  add_wait(::flag_wait, "second_uav_in_position");
  add_func(::spawn_second_uav);
  thread do_wait();

  add_wait(::_wait, 30);
  add_func(::flag_set, "start_village_fight");
  thread do_wait();

  dialog_rasta_and_bricktop();

  flag_set("rasta_and_bricktop_dialog_done");
  flag_set("second_uav_in_position");
  flag_set("start_village_fight");

  autosave_by_name("village_fight2");

  wait 1;

  level.price thread turn_off_stealth_settings();

  village_defenders = getEntArray("village_defenders", "targetname");
  foreach(guy in village_defenders)
  guy spawn_ai();

  flag_wait("leaving_village");
  thread handle_base();
}

handle_base() {
  level.uav_radio_disabled = true;

  level.price thread dead_vehicle_blocking_path();
  level.rasta thread dead_vehicle_blocking_path();

  alive = 0;
  f_guys = getaiarray("allies");
  {
    foreach(f in f_guys) {
      if((f == level.rasta) || (f == level.price))
        continue;
      alive++;
      f thread replace_on_death();
    }
  }

  desired = 3 - alive;
  start_of_base_redshirt = getEntArray("start_of_base_redshirt", "targetname");
  for(i = 0; i < desired; i++) {
    start_of_base_redshirt[i] spawn_ai();
  }

  thread dialog_second_uav_in_position();

  thread base_autosave_logic();
  level notify("stop_snow");

  thread setup_friendlies_for_base();

  retreat_pos = getstruct("village_enemies_retreat_pos", "targetname").origin;
  enemies = getaiarray("axis");
  foreach(mf in enemies)
  mf thread village_enemies_setup_retreat(retreat_pos);

  sight_ranges_foggy_woods();

  base_starting_guys = getEntArray("base_starting_guys", "targetname");
  foreach(guy in base_starting_guys) {
    guy spawn_ai();
  }

  thread setup_base_idling_vehicles();
  thread nag_player_to_destroy_btr();

  add_wait(::waittill_base_alerted);
  add_func(::flag_set, "base_alerted");
  thread do_wait();

  thread dialog_sub_spotted();

  flag_wait("base_alerted");

  thread base_arrival_music();

  disable_stealth_system();

  thread base_alarm_sound();

  wait 1;

  thread dialog_base_on_alert();
  thread dialog_progress_through_base();
  activate_trigger_with_targetname("friendlies_enter_base");
  thread timer_start();

  friendlies = getaiarray("allies");
  foreach(g in friendlies)
  g thread turn_off_stealth_settings();

  if(isalive(level.base_btr2)) {
    end_if_cant_see = false;
    no_misses = false;
    level.base_btr2 thread bmp_turret_attack_player(end_if_cant_see, no_misses);
  }

  if(isalive(level.base_truck1)) {
    level.base_truck1 thread unload_base_truck();
  }

  wait 2;

  if(isalive(level.base_heli)) {
    thread gopath(level.base_heli);
    level.base_heli.circling = true;
    level.base_heli.no_attractor = true;
    level.base_heli = thread maps\_attack_heli::begin_attack_heli_behavior(level.base_heli);
  }

  thread handle_defend_sub();
}

handle_defend_sub() {
  flag_wait("price_splits_off");

  thread kill_helicopter_fail_safe();

  if(isalive(level.base_btr2)) {
    level.base_btr2 kill();
    wait 3;
  }

  flag_clear("respawn_friendlies");
  autosave_by_name("defend");

  thread setup_vehicle_gate("gate1");
  thread setup_vehicle_gate("gate2");

  level.price.colornode_func = undefined;

  killTimer();

  thread dialog_price_splits_off();

  level.price disable_ai_color();
  price_key_pos = getent("price_key_pos", "targetname");
  level.price setgoalpos(price_key_pos.origin);
  level.price.goalradius = 64;

  wait 4;

  greens = get_force_color_guys("allies", "g");
  array_thread(greens, ::set_force_color, "b");

  activate_trigger_with_targetname("friendlies_go_to_guardhouse");

  thread setup_defend_sub_vehicles();

  enemies = getaiarray("axis");
  foreach(guy in enemies) {
    guy.combatmode = "cover";
    guy setgoalpos(level.player.origin);
  }

  flag_wait("price_inside_sub");

  radio_dialogue("cont_pri_insidesub");

  flag_wait_or_timeout("defend_sub_vehicle_guys_dead", 50);
  flag_wait("player_on_guardhouse");

  flee_pos = getstruct("sub_obj_enemies_flee", "targetname").origin;
  enemies = getaiarray("axis");
  foreach(guy in enemies)
  guy thread enemies_flee(flee_pos);

  stinger_source = getent("defend_sub_stinger_source", "targetname");

  fire_stinger_at_uav(stinger_source);

  thread breakforsub_music();
  println("^3z:thread breakforsub_music(); ");

  wait 1;

  autosave_by_name("defend2");

  defend_sub_final_guys = getEntArray("defend_sub_final_guys", "targetname");
  foreach(guy in defend_sub_final_guys)
  guy spawn_ai();

  wait 5;
  activate_trigger_with_targetname("contacts_south");

  level.rasta dialogue_queue("cont_gst_nexttosub");

  flag_set("close_sub_hatch");

  battlechatter_off("allies");
  battlechatter_off("axis");

  wait 10;

  thread open_sub_missile_doors();

  wait 4;

  flee_pos = getstruct("contacts_south_flee_pos", "targetname").origin;
  enemies = getaiarray("axis");
  foreach(guy in enemies) {
    guy thread enemies_flee(flee_pos);
  }

  ai = getaiarray();
  foreach(guy in ai)
  guy.dontevershoot = true;

  level.rasta dialogue_queue("cont_gst_youthere");

  wait 2.4;

  level.rasta dialogue_queue("cont_gst_comein");

  wait 2;

  level.rasta dialogue_queue("cont_gst_doyoucopy");

  wait 1;

  radio_dialogue("cont_pri_good2");

  thread launch_nuke();

  level.rasta dialogue_queue("cont_gst_whatwait");

  wait 2;

  level.rasta dialogue_queue("cont_gst_codeblack");

  wait 1;

  nextmission();
}

base_arrival_music() {
  flag_set("stop_stealth_music");
  music_stop(.5);
  wait 1;

  level endon("stop_base_arrival_music");
  music_TIME = musicLength("contingency_base_arrival");

  while(1) {
    MusicPlayWrapper("contingency_base_arrival");
    wait music_TIME;
  }
}

breakforsub_music() {
  flag_set("stop_stealth_music");
  level notify("stop_base_arrival_music");
  music_stop(1);

  level.player playSound("contingency_breakforsub");
}

save_when_x_are_killed() {
  start_amount = level.enemies_killed;
  needed = 20 + start_amount;

  while(level.enemies_killed < needed)
    wait 1;

  autosave_by_name("x_killed");
}

magic_break_stealth() {
  flag_wait("magic_break_stealth");
  enemies = GetAISpeciesArray("axis", "all");
  if(enemies.size > 0)
    enemies[0].favoriteenemy = level.player;
}

dialog_roach_change_guns() {
  wait 4;
  weap = level.player getcurrentweapon();
  if((weap == level.starting_sidearm) || (weap == level.starting_rifle)) {
    level.price dialogue_queue("cont_pri_grabweapon");
  }
}

spawn_ghosts_team() {
  bricktop_spawner = getent("bricktop", "script_noteworthy");
  bricktop_spawner spawn_ai();
  rasta_spawner = getent("rasta", "script_noteworthy");
  rasta_spawner spawn_ai();

  if(isalive(level.gauntlet_east))
    level.gauntlet_east waittill("death");

  other_guys = getEntArray("village_redshirt", "script_noteworthy");
  foreach(guy in other_guys)
  guy spawn_ai();
}

dialog_second_uav_in_position() {
  level.price dialogue_queue("cont_pri_rastaandbricktop");

  radio_dialogue("cont_cmt_2nduav");

  flag_set("said_second_uav_in_position");
}

fake_treads() {
  self thread maps\_vehicle::tread("tag_wheel_back_left", "back_left", undefined, undefined, 25);
  self thread maps\_vehicle::tread("tag_wheel_back_right", "back_right", undefined, undefined, 25);
  wait 8;
  self notify("kill_treads_forever");
}

faster_price_if_player_close() {
  level.player endon("death");
  level endon("safe_from_btrs");
  while(1) {
    wait .1;

    if(distance(level.player.origin, level.price.origin) < 400) {
      level.price.moveplaybackrate = 1;
    } else {
      vec2 = VectorNormalize((level.player.origin - level.price.origin));
      vec = anglesToForward(level.price.angles);
      vecdot = vectordot(vec, vec2);

      if(vecdot > 0)
        level.price.moveplaybackrate = 1;
      else
        level.price.moveplaybackrate = .9;
    }
  }
}

dialog_price_splits_off() {
  level.price dialogue_queue("cont_pri_goingforsub");

  level.price dialogue_queue("cont_pri_coverme");

  level.rasta dialogue_queue("cont_gst_rogerthat");

  level.rasta dialogue_queue("cont_gst_guardhouse");

  while(!flag("player_on_guardhouse")) {
    wait 20;
    if(flag("player_on_guardhouse")) {
      return;
    }
    level.price dialogue_queue("cont_pri_coverme");

    wait 20;

    if(flag("player_on_guardhouse")) {
      return;
    }
    level.rasta dialogue_queue("cont_gst_guardhouse");
  }
}

setup_defend_sub_vehicles() {
  wait 24;

  level.defend_sub_truck2 = spawn_vehicle_from_targetname_and_drive("defend_sub_truck2");
  level.defend_sub_truck2 thread friendlies_shoot_at_truck_until_its_unloads();
  level.defend_sub_truck2 thread dialog_destroyed_vehicle("cont_cmt_goodkilltruck");
  wait 1;
  level.defend_sub_truck3 = spawn_vehicle_from_targetname_and_drive("defend_sub_truck3");
  level.defend_sub_truck3 thread friendlies_shoot_at_truck_until_its_unloads();
  level.defend_sub_truck3 thread dialog_destroyed_vehicle("cont_cmt_goodkilltruck");
  wait 3;

  level.rasta thread dialogue_queue("cont_gst_twotruckseast");

  wait 15;

  level.defend_sub_truck1 = spawn_vehicle_from_targetname_and_drive("defend_sub_truck1");
  level.defend_sub_truck1 thread friendlies_shoot_at_truck_until_its_unloads();
  level.defend_sub_truck1 thread dialog_destroyed_vehicle("cont_cmt_goodkilltruck");
  wait 2;
  level.defend_sub_jeep1 = spawn_vehicle_from_targetname_and_drive("defend_sub_jeep1");
  level.defend_sub_jeep1 thread friendlies_shoot_at_truck_until_its_unloads();
  level.defend_sub_jeep1 thread dialog_destroyed_vehicle("cont_cmt_goodkilltruck");

  wait 3;

  level.rasta thread dialogue_queue("cont_gst_morevehicleseast");
}

setup_vehicle_gate(stringname) {
  flag_wait(stringname);
  gates = getEntArray(stringname, "targetname");
  foreach(gate in gates) {
    dir = -160;
    if(gate.script_noteworthy == "left")
      dir = 160;

    gate movex(dir, 2, 1, 0);
  }

  while(1) {
    flag_clear(stringname);
    wait .2;
    if(!flag(stringname)) {
      break;
    }
  }

  foreach(gate in gates) {
    dir = 160;
    if(gate.script_noteworthy == "left")
      dir = -160;

    gate movex(dir, 2, 1, 0);
  }
}

setup_sub_hatch() {
  sub_hatch_th = getent("sub_hatch_th", "targetname");
  sub_hatch_th trigger_off();
  hatch_model = getent("hatch_model", "targetname");
  hatch_model_collision = getent("hatch_model_collision", "targetname");
  hatch_model_collision linkto(hatch_model);
  hatch_model rotatepitch(120, .05);

  flag_wait("close_sub_hatch");
  hatch_model rotatepitch(-120, 5);
  wait 2;
  sub_hatch_th trigger_on();
  wait 4;
  sub_hatch_th trigger_off();
}

open_sub_missile_doors() {
  sub_missile_doors = getEntArray("sub_missile_door", "targetname");

  current_side = "left";
  current_num = 1;
  open_time = 2;
  shake_time = .1;
  time_between_doors = 1.6;

  while(1) {
    foreach(door in sub_missile_doors) {
      if((door.script_noteworthy == current_side) && (int(door.script_namenumber) == current_num)) {
        door thread open_sub_missile_door_action(open_time, shake_time);

        if(current_side == "left") {
          current_side = "right";
        } else {
          current_side = "left";
          current_num++;
        }
        if(current_num > 4)
          return;
        wait time_between_doors;
        break;
      }
    }
  }
}

open_sub_missile_door_action(open_time, shake_time) {
  org = spawn("script_origin", (0, 0, 1));
  org.origin = self.origin;
  org playSound("missile_hatch_slams_open", "sounddone");

  door = self;
  if(door.script_noteworthy == "left")
    door rotateroll(-60, open_time, .2);
  else
    door rotateroll(60, open_time, .2);

  wait open_time;
  door rotateroll(-1, shake_time);
  wait shake_time;
  door rotateroll(1, shake_time);
  wait shake_time;

  wait 1;
  org stopsounds();
  wait 1;
  org delete();
}

dialog_looking_for_us() {
  flag_wait("first_patrol_cqb");
  first_patrol_cqb = getEntArray("first_patrol_cqb", "targetname");
  foreach(guy in first_patrol_cqb)
  guy spawn_ai();

  wait 6;

  radio_dialogue("cont_pri_searchingforus");
}

launch_nuke() {
  icbm_missile01 = getent("icbm_missile01", "targetname");
  missile01_start = getent("missile01_start", "targetname");
  missile01_end = getent("missile01_end", "targetname");

  earthquake(0.3, 12, icbm_missile01.origin, 8000);

  level.player PlayRumbleLoopOnEntity("tank_rumble");
  level.player delaycall(8.0, ::stopRumble, "tank_rumble");

  icbm_missile01 playSound("scn_con_icbm_ignition");

  icbm_missile01 linkto(missile01_start);

  missile01_start moveto(missile01_end.origin, 50, 10, 0);

  playFXOnTag(level._effect["smoke_geotrail_icbm"], icbm_missile01, "TAG_NOZZLE");
  exploder("icbm_launch");

  wait 1;

  if(distance(level.player.origin, missile01_start.origin) < 600)
    level.player dodamage((level.player.health + 1000), missile01_start.origin);

  icbm_missile01 playLoopSound("scn_con_icbm_rocket_loop");

  missile01_start waittill("movedone");
  icbm_missile01 delete();
}

uaz_control() {
  trigger = spawn("trigger_radius", self gettagorigin("tag_passenger") + (0, 0, -48), 0, 72, 72);
  trigger enablelinkto();
  trigger linkto(self);
  trigger waittill("trigger");

  level.player allowProne(false);
  level.player allowCrouch(false);
  level.player allowStand(true);

  enablePlayerWeapons(false);
  level.player.rig = spawn_anim_model("player_rig");
  level.player.rig hide();

  level.player.rig linkto(self, "tag_body");
  self thread anim_single_solo(level.player.rig, "boneyard_uaz_mount", "tag_body");
  self thread ride_uaz_door();

  level.player PlayerLinkToBlend(level.player.rig, "tag_player", 0.5);
  wait 0.5;
  level.player.rig show();
  level.player PlayerLinkToDelta(level.player.rig, "tag_player", 0.5, 180, 180, 75, 25, true);

  self waittill("boneyard_uaz_mount");

  level.player.rig hide();

  level.player LerpViewAngleClamp(0.5, 0.5, 0, 180, 180, 75, 35);

  flag_set("player_in_uaz");
}

spawn_sub_enemies() {
  level endon("stop_sub_enemies");
  sub_enemies = getEntArray("sub_enemies", "targetname");
  while(1) {
    desired = 1 + randomint(3);
    while(desired > 0) {
      sub_enemies[(desired - 1)] spawn_ai();
      desired--;
    }
    wait randomintrange(4, 14);
  }
}

sub_ladder() {
  flag_wait("player_on_sub");
  sub_ladder = getent("sub_ladder", "targetname");

  sub_ladder.realOrigin = sub_ladder.origin;
  sub_ladder.origin += (0, 0, -10000);

  flag_wait("player_turned_key");

  sub_ladder.origin = sub_ladder.realOrigin;
}

single_shots() {
  self.shootstyle = "single";
}

activate_players_key() {
  flag_set("player_key_rdy");
  players_key = getent("players_key", "targetname");
  players_key glow();

  players_key setCursorHint("HINT_NOICON");

  players_key setHintString(&"CONTINGENCY_TURN_KEY");
  players_key makeUsable();

  players_key waittill("trigger", player);

  flag_set("player_turned_key");
  players_key stopGlow();
  players_key makeUnusable();
}

dialog_turn_key_nags() {
  wait 10;
  first_line = true;
  while(!flag("player_turned_key")) {
    if(first_line) {
      level.price dialogue_queue("cont_pri_runningout");
      first_line = false;
    } else {
      level.price dialogue_queue("cont_pri_trustme");
      first_line = true;
    }
    wait 10;
  }
}

start_tear_gas_guys() {
  flag_wait("player_dropping_into_sub");
  tear_gas_nodes = getEntArray("tear_gas_nodes", "script_noteworthy");
  foreach(anode in tear_gas_nodes) {
    spawner = getent(anode.target, "targetname");
    anim_name = anode.script_animation;
    spawner add_spawn_function(::setup_tear_gas_guy, anim_name, anode);
    spawner spawn_ai();
  }
}

start_tear_gas_fx() {
  flag_wait("player_dropping_into_sub");
  exploder("tear_gas_submarine");
}

setup_tear_gas_guy(anim_name, anode) {
  self.health = 1;

  self.allowdeath = true;
  self.ragdoll_immediate = true;
  anode thread anim_generic(self, anim_name);
}

debug_timer() {
  time_past = 0;
  while(time_past < 70) {
    wait .05;
    time_past = time_past + .05;
    println("time past: " + time_past);
  }
}

put_on_player_gas_mask() {
  level.player disableweapons();

  level.player giveweapon("facemask");
  level.player switchtoWeapon("facemask");

  level.player ForceViewmodelAnimation("facemask", "nvg_down");
  wait(2.0);
  level.player thread play_loop_sound_on_tag("gas_mask_breath");
  SetSavedDvar("hud_gasMaskOverlay", 1);
  wait(2.5);
  level.player takeweapon("facemask");
  level.player enableweapons();
}

nag_player_to_destroy_btr() {
  level endon("base_btr2_dead");
  while(1) {
    flag_wait("nag_player_to_destroy_btr");

    level.price dialogue_queue("cont_pri_armoredvehicle");

    wait 10;
  }
}

unload_base_truck() {
  level.base_truck1 endon("death");
  level.base_truck1 Vehicle_SetSpeed(0, 15);

  level.base_truck1 maps\_vehicle::vehicle_unload();

  wait 1;

  if(isDefined(level.base_truck1.has_target_shader)) {
    level.base_truck1.has_target_shader = undefined;
    Target_Remove(level.base_truck1);
  }

  if(isDefined(level.remote_missile_targets))
    level.remote_missile_targets = array_remove(level.remote_missile_targets, level.base_truck1);
}

turn_off_stealth_settings() {
  self disable_stealth_for_ai();
  self.no_pistol_switch = undefined;
  self.ignoreall = false;
  self.fixednode = true;
  self thread set_battlechatter(true);
  self set_friendlyfire_warnings(true);
  self.dontEverShoot = undefined;
  self.grenadeammo = 3;
  self.ignoreme = false;
  self pushplayer(false);
  self.ignoresuppression = false;
}

base_alarm_sound() {
  dialog = [];

  dialog[dialog.size] = "cont_bpa_underattack";

  dialog[dialog.size] = "cont_bpa_prejudice";

  dialog[dialog.size] = "cont_bpa_2ndplatoon";

  dialog[dialog.size] = "cont_bpa_alert";

  dialog[dialog.size] = "cont_bpa_battlestations";
  current = 0;

  base_pa = getent("base_pa", "targetname");
  base_alarm_sound = getent("base_alarm_sound", "targetname");
  while(!flag("price_splits_off"))
    while(1) {
      base_alarm_sound playLoopSound("emt_alarm_base_alert");
      base_alarm_sound.playing = true;
      wait 8;
      base_alarm_sound StopLoopSound();
      base_alarm_sound.playing = undefined;

      wait 1;

      base_pa playSound(dialog[current]);
      current++;
      if(current >= dialog.size)
        current = 0;

      wait 12;
    }
  if(isDefined(base_alarm_sound.playing))
    base_alarm_sound StopLoopSound();
}

waittill_base_alerted() {
  level endon("base_alerted");
  level endon("_stealth_spotted");
  level.player waittill("projectile_impact", weaponName, position, radius);
}

setup_remote_missile_target_guy() {
  if(isDefined(self.ridingvehicle)) {
    self endon("death");
    self waittill("jumpedout");
  }
  self thread maps\_remotemissile::setup_remote_missile_target();
}

dialog_destroyed_vehicle(dialog) {
  self endon("unloaded");
  self waittill("death");

  wait .05;

  if(!isDefined(level.vehicles_killed))
    level.vehicles_killed = 1;
  else
    level.vehicles_killed++;

  level.veh_type = dialog;
}

setup_count_predator_infantry_kills() {
  self waittill("death");

  if(isDefined(self.ridingvehicle)) {
    return;
  }
  wait .05;

  if(!isDefined(level.enemies_killed))
    level.enemies_killed = 1;
  else
    level.enemies_killed++;
}

dialog_handle_predator_infantry_kills() {
  dialog = [];
  dialog[dialog.size] = "cont_cmt_mutlipleconfirmed";
  dialog[dialog.size] = "cont_cmt_3kills";
  dialog[dialog.size] = "cont_cmt_theyredown";

  last_line = 0;
  said_direct_hit = false;
  level.enemies_killed = 0;
  level.vehicles_killed = 0;
  said_good_effect = false;
  kills = 0;

  while(1) {
    level waittill("remote_missile_exploded");
    old_num = level.enemies_killed;
    old_veh_num = level.vehicles_killed;

    wait .3;

    veh_kills = level.vehicles_killed - old_veh_num;

    if(isDefined(level.uav_killstats["ai"]))
      kills = level.uav_killstats["ai"];

    wait 1.2;

    if(flag("saying_base_on_alert")) {
      continue;
    }
    if(veh_kills == 1) {
      radio_dialogue(level.veh_type);
      continue;
    }
    if(veh_kills > 1) {
      if(said_good_effect) {
        radio_dialogue("cont_cmt_goodhitvehicles");
        said_good_effect = false;
      } else {
        radio_dialogue("cont_cmt_goodeffectkia");
        said_good_effect = true;
      }
      continue;
    }

    if(kills == 0) {
      continue;
    }
    if(kills == 1) {
      if(said_direct_hit) {
        radio_dialogue("cont_cmt_hesdown");
        said_direct_hit = false;
      } else {
        radio_dialogue("cont_cmt_directhit");
        said_direct_hit = true;
      }
      continue;
    }
    if(kills > 5) {
      radio_dialogue("cont_cmt_fivepluskias");
      continue;
    } else {
      radio_dialogue(dialog[last_line]);
      last_line++;
      if(last_line >= dialog.size)
        last_line = 0;
      continue;
    }
  }
}

setup_base_vehicles() {
  self endon("death");
  self thread vehicle_death_paths();
  self thread unload_when_stuck();
  self thread maps\_remotemissile::setup_remote_missile_target();

  self waittill("unloaded");

  if(isDefined(self.has_target_shader)) {
    self.has_target_shader = undefined;
    Target_Remove(self);
  }

  level.remote_missile_targets = array_remove(level.remote_missile_targets, self);
}

dead_vehicle_blocking_path() {
  count = 0;
  last_bad_path_time = -10000;
  while(1) {
    self waittill("bad_path");

    if(GetTime() - last_bad_path_time < 5000) {
      count++;
    } else {
      count = 0;
      last_bad_path_time = GetTime();
    }

    if(count >= 9) {
      count = 0;
      foreach(vehicle in level.dead_vehicles) {
        if(isDefined(vehicle) && !IsAlive(vehicle) && DistanceSquared(vehicle.origin, self.origin) < 300 * 300) {
          vehicle thread dead_vehicle_enable_paths_thread();
        }
      }
    }
  }
}

dead_vehicle_enable_paths_thread() {
  self notify("stop_vehicle_enabled_paths");
  self endon("stop_vehicle_enabled_paths");

  self.dead_vehicle_enable_paths = true;
  self ConnectPaths();

  wait(5);

  self DisconnectPaths();
  self.dead_vehicle_enable_paths = undefined;
}

vehicle_death_paths() {
  self endon("delete");

  self waittill("kill_badplace_forever");

  level.dead_vehicles[level.dead_vehicles.size] = self;

  min_dist = 50 * 50;
  death_origin = self.origin;

  while(isDefined(self)) {
    if(isDefined(self.dead_vehicle_enable_paths)) {
      wait(0.5);
      continue;
    }

    if(DistanceSquared(self.origin, death_origin) > min_dist) {
      death_origin = self.origin;

      self ConnectPaths();

      while(1) {
        if(isDefined(self.dead_vehicle_enable_paths)) {
          wait(0.5);
          continue;
        }

        wait(0.05);
        if(!isDefined(self)) {
          return;
        }

        if(DistanceSquared(self.origin, death_origin) < 1) {
          break;
        }

        death_origin = self.origin;
      }

      self DisconnectPaths();
    }

    wait(0.05);
  }
}

unload_when_stuck() {
  self endon("unloading");
  self endon("death");
  while(1) {
    wait 2;
    if(self Vehicle_GetSpeed() < 2) {
      self Vehicle_SetSpeed(0, 15);
      self.dontunloadonend = true;
      self thread maps\_vehicle::vehicle_unload();
      return;
    }
  }
}

unload_when_close_to_player() {
  self endon("unloading");
  self endon("death");

  self waittill_entity_in_range(level.player, 1000);

  self Vehicle_SetSpeed(0, 15);
  self.dontunloadonend = true;
  self thread maps\_vehicle::vehicle_unload();
}

setup_base_idling_vehicles() {
  level.base_heli = spawn_vehicle_from_targetname("base_heli");
  level.base_heli.helicopter_predator_target_shader = true;
  level.base_heli.enableRocketDeath = true;
  level.base_heli thread maps\_remotemissile::setup_remote_missile_target();
  level.base_heli thread maps\_vehicle::damage_hint_bullet_only();
  level.base_heli thread dialog_destroyed_vehicle("cont_cmt_directhitshelo");

  level.base_btr2 = spawn_vehicle_from_targetname("base_btr2");
  level.base_btr2 thread maps\_remotemissile::setup_remote_missile_target();
  level.base_btr2 thread vehicle_lights_on("spotlight spotlight_turret");
  level.base_btr2 thread dialog_destroyed_vehicle("cont_cmt_btrdestroyed");

  level.base_truck1 = spawn_vehicle_from_targetname("base_truck1");
  level.base_truck1 thread maps\_remotemissile::setup_remote_missile_target();
  level.base_truck1 thread dialog_destroyed_vehicle("cont_cmt_directhitjeep");

  thread vehicles_move_when_player_can_see_them();
}

setup_friendlies_for_base() {
  friendlies = getaiarray("allies");
  foreach(guy in friendlies) {
    guy enable_ai_color();
    guy set_force_color("g");
    guy.pathrandompercent = 200;
    guy.dontevershoot = true;
    guy set_battlechatter(false);
    guy set_friendlyfire_warnings(false);
  }

  level.price set_force_color("r");

  flag_wait("obj_base_entrance");

  flag_set("everyone_set_green");
  level.price set_force_color("g");

  flag_wait("base_alerted");

  friendlies = getaiarray("allies");
  foreach(guy in friendlies) {
    guy.dontevershoot = undefined;
    guy set_battlechatter(true);
    guy set_friendlyfire_warnings(true);
  }
}

vehicles_move_when_player_can_see_them() {
  while((!isDefined(level.player.is_controlling_UAV)) && !flag("obj_base_entrance"))
    wait .05;

  thread gopath(level.base_btr2);
  thread gopath(level.base_truck1);
}

stealth_ai_ignore_tree_explosions() {
  ai_event["ai_eventDistExplosion"] = [];
  ai_event["ai_eventDistExplosion"]["spotted"] = 0;
  ai_event["ai_eventDistExplosion"]["hidden"] = 0;
  stealth_ai_event_dist_custom(ai_event);

  flag_wait("done_with_exploding_trees");
  wait 1;

  ai_event["ai_eventDistExplosion"] = [];
  ai_event["ai_eventDistExplosion"]["spotted"] = level.explosion_dist_sense;
  ai_event["ai_eventDistExplosion"]["hidden"] = level.explosion_dist_sense;
  stealth_ai_event_dist_custom(ai_event);
}

dialog_moving_to_new_position_in_village(p_node) {
  if(!isDefined(level.dialog_moving_to_new_position_time)) {
    level.dialog_moving_to_new_position_time = gettime();
  } else {
    if(gettime() < (level.dialog_moving_to_new_position_time + (15 * 1000)))
      return;
  }
  level.dialog_moving_to_new_position_time = gettime();

  friendlies = getaiarray("allies");

  friendlies[randomint(friendlies.size)] custom_battlechatter("order_move_combat");
}

enemies_flee(flee_pos) {
  self endon("death");

  self setgoalpos(flee_pos);

  self.ignoreme = true;
  self.goalradius = 96;
  self waittill("goal");
  while(self cansee(level.player))
    wait 1;
  self kill();
}

village_enemies_setup_retreat(retreat_pos) {
  self endon("death");
  flag_wait("leaving_village");

  self setgoalpos(retreat_pos);

  self.ignoreme = true;
  self.goalradius = 32;
  self waittill("goal");
  while(self cansee(level.player))
    wait 1;
  self kill();
}

smart_barney(end_flag, end_goal, end_volume) {
  self notify("stop_barney");
  self endon("stop_barney");
  self endon("death");
  self ClearGoalVolume();
  self thread friendly_adjust_movement_speed();
  self.goalheight = 200;
  self.goalradius = 300;

  self.fixednode = false;

  while(!flag(end_flag)) {
    player = level.player.origin;
    vec = VectorNormalize(end_goal - player);
    forward = vector_multiply(vec, 400);
    goal = forward + player;
    self setgoalpos(goal);

    wait .5;
  }
  self notify("stop_adjust_movement_speed");
  self.moveplaybackrate = 1.0;

  self setgoalpos(end_goal);
  if(isDefined(end_volume))
    self setgoalvolume(end_volume);
}

price_changes_weapons() {
  flag_wait("going_down_ridge");
  count = 3 * 20;
  base_time = count;
  dot = .9;
  dot_only = true;

  for(;;) {
    org = level.price getEye();

    if(!player_looking_at(org, dot, dot_only)) {
      count--;
      if(count <= 0) {
        break;
      }
    } else {
      count = base_time;
    }
    wait(0.05);
  }

  level.price forceUseWeapon("aug_scope", "primary");
}

village_enemies() {}

friendlies_shoot_at_truck_until_its_unloads() {
  self MakeEntitySentient("axis");
  self waittill_either("unloaded", "death");
  self.ignoreme = true;
}

handle_stealth_spotted() {
  level endon("price_starts_moving");
  flag_wait("_stealth_spotted");
  level.price anim_stopanimscripted();
}

price_intro_anim() {
  spot = getstruct("price_intro_talk_struct", "script_noteworthy");
  spot thread handle_stealth_spotted();
  spot anim_reach_solo(level.price, "intro");
  spot anim_single_solo(level.price, "intro");

  flag_set("price_starts_moving");

  level.price notify("_utility::follow_path");
  level.price notify("stop_going_to_node");
  level.price disable_ai_color();
  level.price thread enable_cqbwalk();
  price_smart_path_to_road = getnode("price_smart_path_to_road", "targetname");
  level.price thread price_smart_path_following(price_smart_path_to_road);
}

price_slides_down_the_ridge() {
  flag_wait("price_on_ridge");
  wait 3;
  flag_wait("going_down_ridge");

  buddy_slide_node = getent("ridge_price_overlook_org", "targetname");

  buddy_slide_node anim_single_solo(level.price, "slide");

  level.price thread disable_cqbwalk();
  if(!flag("everyone_set_green"))
    level.price set_force_color("r");
  level.price enable_ai_color();

  activate_trigger_with_targetname("price_in_village_start");
}

kill_helicopter_fail_safe() {
  flag_wait("price_splits_off");
  wait 2;
  if(!isalive(level.base_heli)) {
    return;
  }
  origin = (-13500.0, 876.0, 749.0);

  kill_heli_fail_safe = getstruct("kill_heli_fail_safe", "targetname");
  if(isDefined(kill_heli_fail_safe))
    origin = kill_heli_fail_safe.origin;
  newMissile = MagicBullet("zippy_rockets", origin, level.base_heli.origin);

  newMissile Missile_SetTargetEnt(level.base_heli);
}

fire_stinger(stinger_source) {
  forward = anglesToForward(level.uav.angles);
  forwardfar = vector_multiply(forward, 10000);
  end = forwardfar + level.uav.origin;

  if(isDefined(level.player.is_controlling_UAV)) {
    playFX(getfx("thermal_missle_flash_inverted"), stinger_source);
    newMissile = MagicBullet("zippy_rockets_inverted", stinger_source, end);
  } else {
    playFX(getfx("missle_flash"), stinger_source);
    newMissile = MagicBullet("zippy_rockets", stinger_source, end);
  }

  newMissile Missile_SetTargetEnt(level.uav);

  return newMissile;
}

setup_dont_leave_hint() {
  while(1) {
    flag_wait("player_leaving_map");

    display_hint_timeout("hint_dont_leave_price", 5);

    wait 5;
  }
}

setup_dont_leave_failure() {
  flag_wait("player_left_map");

  level notify("mission failed");
  setDvar("ui_deadquote", &"CONTINGENCY_DONT_LEAVE_FAILURE");
  maps\_utility::missionFailedWrapper();
}

flag_when_all_bridge_guys_dead() {
  flag_wait("truckguys_dead");
  flag_wait("cross_bridge_patrol_dead");
  flag_wait("first_stragglers_dead");
  flag_wait("rightside_patrol_dead");
  flag_set("all_bridge_guys_dead");
}

should_break_dont_leave() {
  if(flag("player_returning_to_map"))
    return true;
  else
    return false;
}

should_break_use_drone() {
  break_hint = false;
  if(isDefined(level.uav_is_destroyed))
    break_hint = true;
  if(!isalive(level.uav))
    break_hint = true;
  if(isDefined(level.player.is_flying_missile))
    break_hint = true;
  if(flag("base_alerted"))
    break_hint = true;
  if(level.player getCurrentWeapon() == "remote_missile_detonator")
    break_hint = true;

  return break_hint;
}

should_break_steer_drone() {
  break_hint = false;
  if(level.player getCurrentWeapon() == "remote_missile_detonator")
    break_hint = true;
  if((level.hint_steer_drone_time + 5000) < gettime())
    break_hint = true;

  return break_hint;
}

fire_stinger_at_uav(stinger_source) {
  level.uav maps\_vehicle::godoff();
  level.uav.health = 400;

  attractor = Missile_CreateAttractorEnt(level.uav, 100000, 60000);

  stinger_source playSound("gauntlet_fires");
  stinger_source playSound("gauntlet_ignition");

  newMissile = fire_stinger(stinger_source.origin);

  old_org = level.uav.origin;
  old_dist = 9999999999;
  while(isDefined(newMissile)) {
    if(!isalive(level.uav)) {
      break;
    }
    dist = Distance(newMissile.origin, level.uav.origin);
    if(dist <= 200) {
      break;
    }
    if(dist > old_dist) {
      break;
    }
    old_dist = dist;
    old_org = level.uav.origin;
    wait .05;
  }

  if(isDefined(newMissile))
    newMissile delete();
  playFX(getfx("uav_explosion"), old_org);
  level.uav thread play_sound_on_tag("uav_explode");
  level.uav_is_destroyed = true;
  level.player maps\_remotemissile::disable_uav(false, true);

  level notify("uav_destroyed");

  if(isDefined(level.uav))
    level.uav delete();
}

UAVRigAiming() {
  if(!isalive(level.uav))
    return;
  if(isDefined(level.uav_is_destroyed)) {
    return;
  }
  focus_points = getEntArray("uav_focus_point", "targetname");
  village_focus_point = getent("village_focus_point", "script_noteworthy");

  level endon("uav_destroyed");
  level.uav endon("death");
  for(;;) {
    if(flag("leaving_village")) {
      closest_focus = getclosest(level.player.origin, focus_points);
      targetPos = closest_focus.origin;
    } else {
      targetPos = village_focus_point.origin;
    }

    angles = VectorToAngles(targetPos - level.uav.origin);

    level.uavRig MoveTo(level.uav.origin, 0.10, 0, 0);
    level.uavRig RotateTo(ANGLES, 0.10, 0, 0);
    wait 0.05;
  }
}

spawn_second_uav() {
  level.uav_is_destroyed = undefined;
  level.player maps\_remotemissile::enable_uav(false, "remote_missile_detonator");

  restart_rig = false;
  if(!isalive(level.uav)) {
    restart_rig = true;
    level.uav = spawn_vehicle_from_targetname_and_drive("second_uav");
    level.uav playLoopSound("uav_engine_loop");
  }

  if(!isDefined(level.uavRig)) {
    level.uavRig = spawn("script_model", level.uav.origin);
    level.uavRig setModel("tag_origin");
  }

  if(restart_rig)
    thread UAVRigAiming();

  weapList = level.player GetWeaponsListAll();
  has_remote = false;
  foreach(weap in weapList)
  if(weap == "remote_missile_detonator")
    has_remote = true;

  if(!has_remote) {
    level.player giveWeapon("remote_missile_detonator");
    level.player SetActionSlot(4, "weapon", "remote_missile_detonator");
  }
}

dialog_russians_looking_for_you() {
  dialog = [];
  dialog[dialog.size] = "cont_ru0_woods";
  dialog[dialog.size] = "cont_ru1_woods";
  dialog[dialog.size] = "cont_ru2_woods";
  dialog[dialog.size] = "cont_ru3_woods";
  dialog[dialog.size] = "cont_ru4_woods";

  while(!flag("approaching_ridge")) {
    wait(randomfloatrange(2, 4));

    guys = getEntArray("cqb_patrol", "script_noteworthy");
    guys = array_randomize(guys);
    foreach(guy in guys) {
      if(isalive(guy)) {
        selection = dialog[randomint(dialog.size)];
        println("guy.export " + guy.export+" sound " + selection);
        guy playSound(selection);
        break;
      }
    }
  }
}

dialog_approaching_ridge() {
  if(!stealth_is_everything_normal())
    return;
  level endon("someone_became_alert");

  level.price dialogue_queue("cont_pri_airsupport");

  wait 1;

  radio_dialogue("cont_cmt_almostinpos");

  level.price dialogue_queue("cont_pri_rogerthat");
}

dialog_gauntlet_surprise_reaction() {
  level.uav_radio_disabled = true;

  wait 2;

  level.price dialogue_queue("cont_pri_bollocks");

  radio_dialogue("cont_cmt_whathappened");

  level.price dialogue_queue("cont_pri_mobilesaminvillage");

  level.price dialogue_queue("cont_pri_uavsharpish");

  level.uav_radio_disabled = undefined;
}

dialog_rasta_and_bricktop() {
  if(flag("start_village_fight"))
    return;
  level endon("start_village_fight");

  while(!isalive(level.rasta))
    wait 1;

  level.price waittill_entity_in_range(level.rasta, 300);
  level.price waittill_entity_in_range(level.player, 600);

  level.price dialogue_queue("cont_pri_nicework");

  level.rasta dialogue_queue("cont_rst_getmoving");
}

village_truck_guys_setup() {
  self endon("death");
  self waittill("jumpedout");
  self.goalradius = 8000;
}

price_smart_path_following(first_node) {
  self endon("stop_smart_path_following");
  self.smart_path_following_node = first_node;
  self setgoalnode(first_node);

  if(!isDefined(first_node.target)) {
    return;
  }
  next_node = getnode(first_node.target, "targetname");
  while(1) {
    trigger = undefined;
    volume = undefined;

    links = getEntArray(next_node.script_linkto, "script_linkname");

    foreach(link in links) {
      if(link.classname == "trigger_multiple_flag_set")
        trigger = link;
      if(link.classname == "info_volume")
        volume = link;
    }

    assert(isDefined(trigger));
    assert(isDefined(trigger.script_flag));
    assert(isDefined(volume));

    flag_wait(trigger.script_flag);

    volume waittill_volume_dead();

    level notify(next_node.targetname);

    if(flag("_stealth_spotted"))
      flag_waitopen("_stealth_spotted");

    self setgoalnode(next_node);
    self.smart_path_following_node = next_node;

    if(!isDefined(next_node.target)) {
      break;
    }

    next_node = getnode(next_node.target, "targetname");
  }
}

destroy_chain(start_ent) {
  current_target = start_ent;
  while(1) {
    if(isDefined(current_target.script_linkTo)) {
      tree = getent(current_target.script_linkTo, "script_linkname");
      tree notify("explode");
    }

    wait .2;

    if(isDefined(current_target.script_delay))
      wait current_target.script_delay;

    if(isDefined(current_target.target)) {
      next_target = getstruct(current_target.target, "targetname");
      assert(isDefined(next_target));
      current_target = next_target;
    } else
      break;
  }
}

setup_tree_destroyer() {
  wait 3;
  level.btr_tree_destroyer = spawn_vehicle_from_targetname_and_drive("btr_tree_destroyer");
  level.btr_tree_destroyer vehicle_lights_on("spotlight spotlight_turret");
  level.btr_tree_destroyer thread monitor_distance_player_vs_price();

  level.btr_tree_destroyerthread maps\_vehicle::damage_hints();
}

friendly_adjust_movement_speed() {
  self notify("stop_adjust_movement_speed");
  self endon("death");
  self endon("stop_adjust_movement_speed");

  for(;;) {
    wait randomfloatrange(.5, 1.5);

    while(friendly_should_speed_up()) {
      self.moveplaybackrate = 2.5;
      wait 0.05;
    }

    self.moveplaybackrate = 1.0;
  }
}

friendly_should_speed_up() {
  prof_begin("friendly_movement_rate_math");

  if(distanceSquared(self.origin, self.goalpos) <= level.goodFriendlyDistanceFromPlayerSquared) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  if(within_fov(level.player.origin, level.player getPlayerAngles(), self.origin, level.cosine["70"])) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  prof_end("friendly_movement_rate_math");

  return true;
}

monitor_player_returns_to_btrs() {
  level endon("player_slid_down");
  flag_wait("returning_to_btrs");

  level.btr_tree_destroyer setturrettargetent(level.player);

  shots = randomintrange(2, 5);
  for(i = 0; i < shots; i++) {
    level.btr_tree_destroyer fireWeapon();
    wait(0.35);
  }
  level.btr_slider setturrettargetent(level.player);
  wait(randomfloatrange(.2, .5));

  shots = randomintrange(2, 4);
  for(i = 0; i < shots; i++) {
    level.btr_slider fireWeapon();
    level.btr_tree_destroyer fireWeapon();
    wait(0.35);
  }
  level.player dodamage((level.player.health + 1000), level.btr_tree_destroyer.origin);
}

monitor_distance_player_vs_price() {
  wait 10;

  level endon("safe_from_btrs");

  while(1) {
    level.player waittill_entity_out_of_range(level.price, 1000);

    vec2 = VectorNormalize((level.player.origin - level.price.origin));

    vec = anglesToForward(level.price.angles);
    vecdot = vectordot(vec, vec2);

    if(vecdot < 0) {
      break;
    }

    wait .1;
  }

  level notify("shoot_at_player");

  self setturrettargetent(level.player);

  shots = randomintrange(2, 5);
  for(i = 0; i < shots; i++) {
    self fireWeapon();
    wait(0.35);
  }
  level.btr_slider setturrettargetent(level.player);
  wait(randomfloatrange(.2, .5));

  shots = randomintrange(2, 4);
  for(i = 0; i < shots; i++) {
    level.btr_slider fireWeapon();
    self fireWeapon();
    wait(0.35);
  }
  level.player dodamage((level.player.health + 1000), self.origin);
}

end_of_tree_explosions() {
  level endon("shoot_at_player");
  flag_wait("end_of_tree_explosions");
  wait 2;

  destroyable_trees = getEntArray("trigger_tree_explosion", "targetname");

  thread random_tree_impact_sounds(destroyable_trees);
  level.btr_tree_destroyer fireWeapon();
  wait .2;
  thread random_tree_impact_sounds(destroyable_trees);
  level.btr_tree_destroyer fireWeapon();
  wait .2;
  thread random_tree_impact_sounds(destroyable_trees);
  level.btr_tree_destroyer fireWeapon();

  wait 1;
  thread random_tree_impact_sounds(destroyable_trees);
  level.btr_tree_destroyer fireWeapon();
  wait .5;
  level.btr_tree_destroyer fireWeapon();

  wait 1;

  thread random_tree_impact_sounds(destroyable_trees);
  level.btr_tree_destroyer fireWeapon();
  wait .2;
  thread random_tree_impact_sounds(destroyable_trees);
  level.btr_tree_destroyer fireWeapon();
  wait .2;
  level.btr_tree_destroyer fireWeapon();

  wait .5;
  thread random_tree_impact_sounds(destroyable_trees);
  level.btr_tree_destroyer fireWeapon();
  wait .8;
  level.btr_tree_destroyer fireWeapon();

  wait 1;
  level.btr_tree_destroyer fireWeapon();

  wait 1;
  level.btr_tree_destroyer fireWeapon();

  wait 2;
  level.btr_tree_destroyer fireWeapon();

  flag_set("done_with_exploding_trees");
}

random_tree_impact_sounds(destroyable_trees) {
  loc = destroyable_trees[randomint(destroyable_trees.size)];
  loc playSound("contingency_tree_impact");
  loc playSound("contingency_tree_fall");
}

setup_destroyable_tree() {
  level endon("shoot_at_player");

  small_tree = false;
  tree_base = getent(self.target, "targetname");
  destroyed_top = undefined;
  clip_brush = undefined;
  if(tree_base.model == "foliage_tree_pine_snow_tall_b_broken_btm") {
    small_tree = true;
    tree_base.endmodel = tree_base.model;
    tree_base setModel("foliage_tree_pine_snow_tall_b");
  } else {
    tree_base.endmodel = tree_base.model;
    tree_base setModel("foliage_tree_pine_snow_tall_c");
  }
  parts = getEntArray(tree_base.target, "targetname");
  foreach(part in parts) {
    if(part.classname == "script_model")
      destroyed_top = part;
    if(part.classname == "script_brushmodel")
      clip_brush = part;
  }
  assert(isDefined(destroyed_top));
  destroyed_top.goalangles = destroyed_top.angles;

  destroyed_top.angles = tree_base.angles;
  destroyed_top hide();

  hits_ground = false;
  if((isDefined(destroyed_top.script_noteworthy)) && (destroyed_top.script_noteworthy == "hits_the_ground"))
    hits_ground = true;
  if(hits_ground)
    assert(isDefined(clip_brush));
  if(isDefined(clip_brush)) {
    assert(hits_ground);
    clip_brush notsolid();
  }

  self waittill("trigger");

  if(isalive(level.btr_slider)) {
    level.btr_slider setturrettargetvec(destroyed_top.origin);
    level.btr_slider fireWeapon();
  }

  if(isalive(level.btr_tree_destroyer)) {
    level.btr_tree_destroyer setturrettargetvec(destroyed_top.origin);
    level.btr_tree_destroyer fireWeapon();
  }

  destroyed_top playSound("contingency_tree_impact");
  tree_base playSound("contingency_tree_fall");

  tree_base setModel(tree_base.endmodel);
  forward = anglesToForward(destroyed_top.angles);
  up = AnglesToUp(destroyed_top.angles);
  if(small_tree) {
    playFX(getfx("tree_snow_dump_fast_small"), destroyed_top.origin, up, forward);
  } else {
    playFX(getfx("tree_snow_dump_fast"), destroyed_top.origin, up, forward);
  }

  destroyed_top show();

  pre_hit_fx_time = .25;

  if(small_tree) {
    pre_hit_fx_time = pre_hit_fx_time - .25;
  }

  drop_time = 2;

  accel_time = drop_time;

  destroyed_top RotateTo(destroyed_top.goalangles, drop_time, accel_time, 0);

  wait(drop_time - pre_hit_fx_time);

  if(hits_ground) {
    forward = anglesToForward(destroyed_top.angles);
    up = AnglesToUp(destroyed_top.angles);

    if(small_tree) {
      playFX(getfx("tree_snow_fallen_small"), destroyed_top.origin, up, forward);
    } else {
      playFX(getfx("tree_snow_fallen_heavy"), destroyed_top.origin, up, forward);
    }
  }
  wait pre_hit_fx_time;

  if(hits_ground) {
    if(level.player istouching(clip_brush))
      level.player kill();
    clip_brush solid();
  }

  if((hits_ground) && (!small_tree)) {
    if(level.player point_in_fov(destroyed_top.origin))
      Earthquake(0.3, .3, destroyed_top.origin, 2000);
    destroyed_top playSound("contingency_tree_ground");
  }

  if(!hits_ground) {
    forward = anglesToForward(destroyed_top.angles);
    up = AnglesToUp(destroyed_top.angles);

    if(small_tree) {
      playFX(getfx("tree_snow_fallen_small"), destroyed_top.origin, up, forward);
    } else {
      playFX(getfx("tree_snow_fallen"), destroyed_top.origin, up, forward);
    }
  }

  shake_time = .2;

  destroyed_top movez(4, shake_time, 0, shake_time);
  wait shake_time;

  destroyed_top movez(-3, shake_time, 0, shake_time);
  wait shake_time;

  destroyed_top movez(2, shake_time, 0, shake_time);
  wait shake_time;

  destroyed_top movez(-1, shake_time, 0, shake_time);
  wait shake_time;
}

dialog_enemy_saw_corpse() {
  first_line = true;

  while(1) {
    level waittill("_stealth_saw_corpse");

    wait 2;

    if(flag("_stealth_spotted"))
      continue;
  }

  if(first_line) {
    radio_dialogue("cont_pri_foundabody");
    first_line = false;
  } else {
    radio_dialogue("cont_pri_foundabody2");
    first_line = true;
  }

  if(flag("_stealth_spotted"))
    return;
  level endon("_stealth_spotted");
  wait 10;

  radio_dialogue("cont_pri_sametime");
}

dialog_player_kill() {
  if(flag("_stealth_spotted")) {
    return;
  }
  wait 3;

  if(!stealth_is_everything_normal())
    return;
  if(!isDefined(level.good_kill_dialog_time)) {
    level.good_kill_dialog_time = gettime();
  } else {
    if(gettime() < (level.good_kill_dialog_time + (15 * 1000)))
      return;
  }
  level.good_kill_dialog_time = gettime();

  level notify("player kill dialog");
}

dialog_player_kill_master() {
  dialog = [];

  dialog[dialog.size] = "cont_pri_good";

  dialog[dialog.size] = "cont_pri_beautiful";

  dialog[dialog.size] = "cont_pri_nicelydone";

  dialog[dialog.size] = "cont_pri_welldone";

  dialog[dialog.size] = "cont_pri_goodwork";

  dialog[dialog.size] = "cont_pri_impressive";

  line = 0;

  while(1) {
    level waittill("player kill dialog");

    radio_dialogue(dialog[line]);
    line++;
    if(line >= dialog.size)
      line = 0;
  }
}

dialog_price_kill() {
  current_line = 0;
  dialog = [];

  dialog[dialog.size] = "cont_pri_gotone";

  dialog[dialog.size] = "cont_pri_hesdown2";

  dialog[dialog.size] = "cont_pri_tangodown";

  dialog[dialog.size] = "cont_pri_goodnight";

  dialog[dialog.size] = "cont_pri_targeteliminated";

  dialog[dialog.size] = "cont_pri_targetdown";

  while(1) {
    level waittill("dialog_price_kill");

    wait 1.5;

    if(isDefined(level.dont_brag_when_following_your_own_orders_time)) {
      if(gettime() < (level.dont_brag_when_following_your_own_orders_time + (15 * 1000)))
        continue;
    }

    if(!isDefined(level.good_kill_dialog_time)) {
      level.good_kill_dialog_time = gettime();
    } else {
      if(gettime() < (level.good_kill_dialog_time + (3 * 1000)))
        continue;
    }
    level.good_kill_dialog_time = gettime();

    dialog_line = dialog[current_line];
    radio_dialogue(dialog_line);
    current_line++;
    if(current_line >= dialog.size)
      current_line = 0;
  }
}

dialog_price_kill_dog() {
  current_line = 0;

  dialog_dog = [];

  dialog_dog[dialog_dog.size] = "cont_pri_naptime";

  dialog_dog[dialog_dog.size] = "cont_pri_downboy";

  while(1) {
    level waittill("dialog_price_kill_dog");

    wait 1.5;

    if(isDefined(level.dont_brag_when_following_your_own_orders_time)) {
      if(gettime() < (level.dont_brag_when_following_your_own_orders_time + (15 * 1000)))
        continue;
    }

    if(!isDefined(level.good_kill_dialog_time)) {
      level.good_kill_dialog_time = gettime();
    } else {
      if(gettime() < (level.good_kill_dialog_time + (3 * 1000)))
        continue;
    }
    level.good_kill_dialog_time = gettime();

    dialog_line = dialog_dog[current_line];
    radio_dialogue(dialog_line);
    current_line++;
    if(current_line >= dialog_dog.size)
      current_line = 0;
  }
}

monitor_stealth_pain() {
  self waittill("damage", damage, attacker);

  if(!isDefined(attacker)) {
    return;
  }
  if((isPlayer(attacker)) && (isDefined(self.script_deathflag))) {
    if(self.script_deathflag != "blocking_stationary_dead")
      thread price_helps_kill_group(self.script_deathflag);
  }
}

monitor_stealth_kills() {
  self waittill("death", killer);

  if(!isDefined(killer)) {
    return;
  }
  if(isPlayer(killer)) {
    thread dialog_player_kill();
    return;
  }

  if((level.price == killer) && (!isDefined(self.no_price_kill_callout))) {
    if(self.type == "dog")
      level notify("dialog_price_kill_dog");
    else
      level notify("dialog_price_kill");
  }
}

dialog_stealth_recovery() {
  if(flag("player_on_ridge"))
    return;
  level endon("player_on_ridge");
  failure = [];

  failure[failure.size] = "cont_pri_giveawayposition";

  failure[failure.size] = "cont_pri_lowprofile";

  failure[failure.size] = "cont_pri_getuskilled";

  failure[failure.size] = "cont_pri_thewordstealth";

  line = 0;

  while(1) {
    flag_wait("_stealth_spotted");
    wait 1;
    flag_waitopen("_stealth_spotted");
    wait 1;

    radio_dialogue(failure[line]);
    line++;
    if(line >= failure.size)
      line = 0;
  }
}

dialog_we_are_spotted() {
  failure = [];

  failure[failure.size] = "cont_pri_goloud";

  failure[failure.size] = "cont_pri_ontous";

  failure[failure.size] = "cont_pri_werespotted";

  failure = array_randomize(failure);
  line = 0;

  while(1) {
    flag_wait("_stealth_spotted");

    radio_dialogue_stop();
    radio_dialogue(failure[line]);
    line++;
    if(line >= failure.size)
      line = 0;

    wait 1;
    flag_waitopen("_stealth_spotted");
    wait 1;
  }
}

dialog_first_patrol_spotted() {
  level.price thread disable_cqbwalk();
  level.price SetLookAtEntity();
  if(flag("someone_became_alert"))
    return;
  level endon("someone_became_alert");
  if(flag("saying_patience"))
    return;
  level endon("saying_patience");
  flag_set("saying_contact");

  radio_dialogue("cont_pri_30metersfront");

  wait 2;

  radio_dialogue("cont_pri_fivemen");

  wait .1;

  radio_dialogue("cont_cmt_hatedogs");

  wait .4;

  radio_dialogue("cont_pri_russiandogs");

  radio_dialogue("cont_cmt_haveyouback");

  radio_dialogue("cont_pri_rogerthat2");
  flag_clear("saying_contact");

  level.price thread enable_cqbwalk();
}

dialog_russians_have_sams() {
  wait 6;

  if(flag("_stealth_spotted"))
    return;
  if(flag("someone_became_alert"))
    return;
  level endon("someone_became_alert");

  level.price dialogue_queue("cont_pri_intelwasoff");

  radio_dialogue("cont_cmt_rogerthat");

  level.price dialogue_queue("cont_pri_foundtransport");

  radio_dialogue("cont_cmt_workingonit");
}

dialog_lets_follow_quietly() {
  level endon("_stealth_spotted");
  level endon("someone_became_alert");
  level waittill("price_starts_following");
  if(flag("saying_contact"))
    flag_waitopen("saying_contact");

  if(flag("said_convoy_coming")) {
    return;
  }

  radio_dialogue("cont_pri_pickoffstragglers");
}

flag_when_second_group_of_stragglers_are_dead() {
  flag_wait("cross_bridge_patrol_dead");
  flag_wait("rightside_patrol_dead");
  flag_set("second_group_of_stragglers_are_dead");
}

hide_and_kill_everyone() {
  if(flag("second_group_of_stragglers_are_dead"))
    return;
  level endon("second_group_of_stragglers_are_dead");

  level endon("_stealth_spotted");
  flag_wait("price_in_position_remaining_group");

  thread price_is_ready_vs_everyone();

  radio_dialogue("cont_pri_imready");

  if(flag("cross_bridge_patrol_dead") || flag("rightside_patrol_dead")) {
    return;
  }

  radio_dialogue("cont_pri_twoonleft");
}

spawn_with_delays() {
  if(isDefined(self.script_delay))
    wait self.script_delay;

  self spawn_ai();
}

hide_and_kill_first_stragglers() {
  if(flag("_stealth_spotted"))
    return;
  level endon("_stealth_spotted");

  flag_wait("patience");

  flag_set("saying_patience");
  level notify("saying_patience");
  level.price thread enable_cqbwalk();

  radio_dialogue("cont_pri_patience");
  wait .5;

  if(!flag("start_truck_patrol")) {
    radio_dialogue("cont_pri_sametime");
  }

  flag_wait("price_in_position_first_group");
  flag_wait("first_stragglers_stopped");
  flag_wait("last_truck_left");

  wait_till_every_thing_stealth_normal_for(1);

  autosave_by_name("first_stragglers");

  if(flag("someone_became_alert"))
    return;
  level endon("someone_became_alert");

  if(flag("first_stragglers_dead"))
    return;
  level endon("first_stragglers_dead");

  thread price_is_ready_vs_first_stragglers();

  wait 1;
  flag_wait("they_have_split_up");

  radio_dialogue("cont_pri_forasmoke");
}

price_is_ready_vs_everyone() {
  ai = GetAIspeciesArray("axis", "all");
  foreach(actor in ai) {
    if((isDefined(actor.script_noteworthy)) && (actor.script_noteworthy == "rightside_patrol"))
      actor.threatbias = 20000;
  }

  level.price.ignoreall = false;
  level.player waittill("weapon_fired");

  wait .2;

  level.price.dontevershoot = undefined;
  level.price.baseaccuracy = 5000000;

  ai = GetAIspeciesArray("axis", "all");
  foreach(actor in ai) {
    actor.no_price_kill_callout = true;
    actor.dontattackme = undefined;

    actor.health = 1;
  }

  flag_wait("second_group_of_stragglers_are_dead");

  bridge_reset_price_to_stealth();
}

price_is_ready_vs_first_stragglers() {
  level.price.ignoreall = false;
  level.player waittill("weapon_fired");

  wait .2;

  level.price.dontevershoot = undefined;
  level.price.baseaccuracy = 5000000;

  ai = GetAIspeciesArray("axis", "all");
  foreach(actor in ai) {
    if((isDefined(actor.script_noteworthy)) && (actor.script_noteworthy == "first_stragglers")) {
      actor.no_price_kill_callout = true;
      actor.dontattackme = undefined;
      level.price.favoriteenemy = actor;
      actor.health = 1;
    }
  }
  flag_wait("first_stragglers_dead");

  bridge_reset_price_to_stealth();
}

bridge_reset_price_to_stealth() {
  if(flag("_stealth_spotted"))
    return;
  level.price.dontevershoot = true;
  level.price.baseaccuracy = 1;
  level.price.ignoreall = true;
}

price_helps_kill_group(script_deathflag) {
  level endon("_stealth_spotted");
  level.price.maxsightdistsqrd = 8000 * 8000;
  wait .2;

  level.price.dontevershoot = undefined;
  level.price.baseaccuracy = 5000000;

  ai = GetAIspeciesArray("axis", "all");
  while(!flag(script_deathflag)) {
    foreach(actor in ai) {
      if(!isalive(actor))
        continue;
      if((isDefined(actor.script_deathflag)) && (actor.script_deathflag == script_deathflag)) {
        actor.dontattackme = undefined;
        actor.threatbias = 5000;
        if(!isalive(level.price.enemy))
          level.price.favoriteenemy = actor;
        actor.health = 1;
      }
    }
    wait .1;
  }

  woods_reset_price_to_stealth();
}

woods_reset_price_to_stealth() {
  if(flag("player_on_ridge"))
    return;
  if(flag("_stealth_spotted"))
    return;
  level.price.dontevershoot = true;
  level.price.baseaccuracy = 1;
  level.price.maxsightdistsqrd = level.price_maxsightdistsqrd_woods;
}

hide_from_bridge_convoy() {
  thread price_takes_next_path_if_stealth_is_broken();

  level.price.ignoreall = true;

  level endon("_stealth_spotted");

  flag_wait_or_timeout("last_jeep_arrived", 20);

  wait 4;

  wait_till_every_thing_stealth_normal_for(1);

  radio_dialogue("cont_pri_yourparachute");

  flag_set("convoy_hide_section_complete");
  autosave_stealth();

  thread dialog_lets_keep_moving();

  level.price.ignoreall = false;
  level.price thread enable_cqbwalk();
  price_goes_halfway_across_bridge = getnode("price_goes_halfway_across_bridge", "targetname");
  level.price thread price_smart_path_following(price_goes_halfway_across_bridge);
}

dialog_lets_keep_moving() {
  thread radio_dialogue("cont_pri_keepmoving");
}

price_takes_next_path_if_stealth_is_broken() {
  level endon("convoy_hide_section_complete");
  flag_wait("_stealth_spotted");
  wait 1;
  flag_waitopen("_stealth_spotted");
  wait 2;

  level.price thread enable_cqbwalk();
  price_goes_halfway_across_bridge = getnode("price_goes_halfway_across_bridge", "targetname");
  level.price thread price_smart_path_following(price_goes_halfway_across_bridge);
}

dialog_wait_for_me_to_get_into_position() {
  radio_dialogue("cont_pri_waitposition");
}

price_is_ready_vs_bridge_patrol() {
  level.player waittill("weapon_fired");

  wait .2;

  level.price.dontevershoot = undefined;
  level.price.baseaccuracy = 5000000;
  level.price.ignoreall = false;

  ai = GetAIspeciesArray("axis", "all");
  foreach(actor in ai) {
    if((isDefined(actor.script_noteworthy)) && (actor.script_noteworthy == "cross_bridge_patrol")) {
      actor.no_price_kill_callout = true;
      actor.dontattackme = undefined;
      level.price.favoriteenemy = actor;
      actor.health = 1;
    }
  }
}

dialog_woods_first_patrol() {
  level.player endon("weapon_fired");
  flag_wait("dialog_woods_first_patrol");

  if(flag("someone_became_alert")) {
    return;
  }

  level.price radio_dialogue("cont_pri_letpass");
}

dialog_woods_first_dog_patrol() {
  flag_wait("dialog_woods_first_dog_patrol");

  if(flag("someone_became_alert")) {
    return;
  }
  autosave_stealth();

  level.price radio_dialogue("cont_pri_dogpatrol");
}

dialog_woods_first_stationary() {
  flag_wait("dialog_woods_first_stationary");

  if(flag("someone_became_alert")) {
    return;
  }
  if(flag("first_stationary_dead")) {
    return;
  }
  autosave_stealth();
  level endon("someone_became_alert");

  level.price radio_dialogue("cont_pri_3manpatrol");

  weap = level.player getcurrentweapon();
  if((weap != level.starting_sidearm) && (weap != level.starting_rifle)) {
    level.price radio_dialogue("cont_pri_alertenemies");
  }

  level.price radio_dialogue("cont_pri_yourcall");

  level.dont_brag_when_following_your_own_orders_time = gettime();
}

price_is_ready_vs_blocking_stationary() {
  ai = GetAIspeciesArray("axis", "all");
  foreach(actor in ai) {
    if(!isDefined(actor.script_noteworthy))
      continue;
    if(actor.script_noteworthy == "blocking_group_left_two")
      actor.threatbias = 20000;
  }

  level.player waittill("weapon_fired");
  level.price.maxsightdistsqrd = 8000 * 8000;

  wait .2;

  level.price.dontevershoot = undefined;
  level.price.baseaccuracy = 5000000;

  ai = GetAIspeciesArray("axis", "all");
  while(!flag("blocking_stationary_dead")) {
    foreach(actor in ai) {
      if(!isalive(actor))
        continue;
      if(!isDefined(actor.script_noteworthy))
        continue;
      if(actor.script_noteworthy == "blocking_group_left_two") {
        if(!isalive(level.price.enemy))
          level.price.favoriteenemy = actor;

        actor.dontattackme = undefined;

        actor.health = 1;
      }
    }

    foreach(actor in ai) {
      if(!isalive(actor))
        continue;
      if(!isDefined(actor.script_noteworthy))
        continue;
      if(actor.script_noteworthy == "two_on_right") {
        actor.dontattackme = undefined;

        actor.health = 1;
      }
    }
    wait .1;
  }
  woods_reset_price_to_stealth();
}

dialog_woods_blocking_stationary() {
  flag_wait("dialog_woods_blocking_stationary");

  if(flag("someone_became_alert")) {
    return;
  }
  if(flag("blocking_stationary_dead")) {
    return;
  }
  autosave_stealth();
  level endon("someone_became_alert");

  thread price_is_ready_vs_blocking_stationary();

  level.price radio_dialogue("cont_pri_largepatrol12");

  level.price radio_dialogue("cont_pri_cantslipby");

  level.price radio_dialogue("cont_pri_twoonright");

  level.dont_brag_when_following_your_own_orders_time = gettime();
}

dialog_woods_second_dog_patrol() {
  flag_wait("dialog_woods_second_dog_patrol");

  if(flag("someone_became_alert")) {
    return;
  }
  autosave_stealth();

  end_patrol = getEntArray("end_patrol", "targetname");
  foreach(guy in end_patrol) {
    if(isalive(guy))
      guy.threatbias = 10000;
  }

  level.price radio_dialogue("cont_pri_anotherdogpatrol");

  level.price radio_dialogue("cont_pri_slippast");
}

dialog_convoy_coming() {
  level endon("_stealth_spotted");
  level endon("someone_became_alert");

  flag_set("said_convoy_coming");
  level notify("said_convoy_coming");

  level.price radio_dialogue("cont_pri_convoycoming");

  wait 2;

  level.price radio_dialogue("cont_pri_letthempass");
}

dialog_theyre_looking_for_you() {
  current_line = 0;
  dialog = [];

  dialog[dialog.size] = "cont_pri_hideinwoods";

  dialog[dialog.size] = "cont_pri_getintowoods";

  dialog[dialog.size] = "cont_pri_theyrealerted";

  while(1) {
    level waittill("dialog_someone_is_alert");

    dialog_line = dialog[current_line];
    radio_dialogue_clear_stack();
    radio_dialogue(dialog_line);
    if(current_line >= dialog.size)
      current_line = 0;
  }
}

monitor_price_hides_on_alerts() {
  while(1) {
    flag_wait("someone_became_alert");
    if(!flag("price_is_hiding")) {
      level.price.fixednode = true;
      level.price enable_ai_color();
      level.price set_force_color("y");

      flag_set("price_is_hiding");
    }
    flag_waitopen("someone_became_alert");
  }
}

monitor_someone_became_alert() {
  self endon("death");

  self ent_flag_waitopen("_stealth_normal");

  self.ignoreme = false;

  if(flag("someone_became_alert")) {
    return;
  }
  flag_set("someone_became_alert");
  thread monitor_waittill_stealth_normal();

  wait 1;

  if(flag("_stealth_spotted")) {
    return;
  }
  level notify("dialog_someone_is_alert");
}

monitor_waittill_stealth_normal() {
  wait_till_every_thing_stealth_normal_for(3);

  flag_clear("someone_became_alert");
}

wait_till_every_thing_stealth_normal_for(time) {
  while(1) {
    if(stealth_is_everything_normal()) {
      wait time;
      if(stealth_is_everything_normal())
        return;
    }
    wait 1;
  }
}

dialog_into_the_woods() {
  level.price dialogue_queue("cont_pri_followme");

  wait 2;

  level.price dialogue_queue("cont_pri_intothewoods");
}

dialog_sub_spotted() {
  level endon("base_alerted");
  flag_wait("said_second_uav_in_position");
  wait 1;

  flag_wait("obj_base_entrance");

  level.price dialogue_queue("cont_pri_belowcrane");

  level.price dialogue_queue("cont_pri_softendefenses");

  autosave_by_name("base");

  wait 1;

  level.player thread display_hint_timeout("hint_predator_drone", 6);

  level.price dialogue_queue("cont_pri_strobes");
}

dialog_base_on_alert() {
  flag_set("saying_base_on_alert");

  radio_dialogue("cont_cmt_gotattention");

  radio_dialogue("cont_cmt_baseonalert");

  radio_dialogue("cont_cmt_betterhurry");

  level.uav_radio_disabled = undefined;

  level.price dialogue_queue("cont_pri_weremoving");

  flag_clear("saying_base_on_alert");
}

dialog_progress_through_base() {
  flag_wait("player_is_halfway_to_sub");

  radio_dialogue("cont_cmt_halwaythere");

  if(isalive(level.base_heli)) {
    level.price dialogue_queue("cont_pri_takeoutheli");
    level.base_heli MakeEntitySentient("axis");
  }

  flag_wait("base_troop_transport2_spawned");

  wait 2;

  level.price dialogue_queue("cont_pri_usehellfire");
}

dialog_time_nags(total_time) {
  time_past = 0;

  dialog = [];

  dialog[dialog.size] = "cont_pri_subwontwait";

  dialog[dialog.size] = "cont_pri_gogogo";

  dialog[dialog.size] = "cont_pri_gettosub";
  dialog = array_randomize(dialog);
  current = 0;

  while(1) {
    wait 30;
    time_past = time_past + 30;
    time_remaining = total_time - time_past;

    if(time_remaining == 90) {
      radio_dialogue("cont_cmt_90secs");
      continue;
    }

    if(time_remaining == 60) {
      radio_dialogue("cont_cmt_60secs");
      continue;
    }

    if(time_remaining == 30) {
      radio_dialogue("cont_cmt_30secs");
      continue;
    }
    if(time_remaining == 0) {
      break;
    }
    if(cointoss()) {
      level.price dialogue_queue(dialog[current]);
      current++;
      if(current >= dialog.size)
        current = 0;
    }
  }
}

dialog_at_sub() {
  level.price dialogue_queue("cont_pri_reachedsub");

  radio_dialogue("cont_cmt_rogerthat2");
}

kill_btr_slider(newMissile) {
  fire_time = gettime();
  newMissile waittill("death");
  if(gettime() > fire_time + 2000) {
    return;
  }
  self setModel("vehicle_btr80_snow_d");
  playFX(getfx("btr_explosion"), self.origin);
  stopFXOnTag(getfx("btr_spotlight"), self, "TAG_FRONT_LIGHT_RIGHT");
  stopFXOnTag(getfx("btr_spotlight"), self, "TAG_TURRET_LIGHT");
}

dialog_intro() {
  level endon("saying_contact");

  level.price SetLookAtEntity(level.player);

  radio_dialogue("cont_cmt_barelysee");

  level.price SetLookAtEntity();

  level.price radio_dialogue("cont_pri_foundroach");

  level.price radio_dialogue("cont_pri_headnw");

  wait 1;

  radio_dialogue("cont_cmt_fareast");

  level.price radio_dialogue("cont_pri_proceed");

  wait 1;

  flag_set("said_follow_me");

  radio_dialogue("cont_pri_outofsight");
}

stealth_music_control() {
  if(flag("stop_stealth_music"))
    return;
  level endon("stop_stealth_music");

  while(1) {
    thread stealth_music_hidden_loop();

    flag_wait("_stealth_spotted");

    music_stop(.2);
    wait .5;
    thread stealth_music_busted_loop();

    flag_waitopen("_stealth_spotted");

    music_stop(3);
    wait 3.25;
  }
}

stealth_music_hidden_loop() {
  music_TIME = musicLength("contingency_stealth");

  level endon("_stealth_spotted");

  if(flag("stop_stealth_music"))
    return;
  level endon("stop_stealth_music");

  while(1) {
    MusicPlayWrapper("contingency_stealth");

    wait music_TIME;

    wait 10;
  }
}

stealth_music_busted_loop() {
  music_TIME = musicLength("contingency_stealth_busted");

  level endon("_stealth_spotted");
  if(flag("stop_stealth_music"))
    return;
  level endon("stop_stealth_music");
  while(1) {
    MusicPlayWrapper("contingency_stealth_busted");

    wait music_TIME;

    wait 3;
  }
}

cargo_choppers2() {
  cargo_heli_spawners = getEntArray("cargo_heli_group2", "targetname");
  foreach(spawner in cargo_heli_spawners) {
    Cargo_item_spawners = getEntArray(spawner.script_noteworthy, "targetname");
    foreach(ent in cargo_item_spawners)
    ent Hide();
    spawner.cargo_item_spawners = cargo_item_spawners;
  }

  flag_wait("cargo_choppers_2");

  thread dialog_russians_have_sams();

  current_spawner = 0;
  num_of_groups = 1;
  while(num_of_groups > 0) {
    group = cargo_heli_spawners.size;

    while(group > 0) {
      if(current_spawner >= cargo_heli_spawners.size)
        current_spawner = 0;
      thread spawn_cargo_chopper(cargo_heli_spawners[current_spawner]);
      current_spawner++;
      wait(randomfloatrange(1.3, 1.8));
      group--;
    }
    num_of_groups--;
  }
}

cargo_choppers() {
  cargo_heli_spawners = getEntArray("cargo_heli", "targetname");
  foreach(spawner in cargo_heli_spawners) {
    Cargo_item_spawners = getEntArray(spawner.script_noteworthy, "targetname");
    foreach(ent in cargo_item_spawners)
    ent Hide();
    spawner.cargo_item_spawners = cargo_item_spawners;
  }

  current_spawner = 0;
  num_of_groups = 1;
  while(num_of_groups > 0) {
    group = cargo_heli_spawners.size;

    while(group > 0) {
      if(current_spawner >= cargo_heli_spawners.size)
        current_spawner = 0;
      thread spawn_cargo_chopper(cargo_heli_spawners[current_spawner]);
      current_spawner++;
      wait(randomfloatrange(1.3, 1.8));
      group--;
    }
    num_of_groups--;
  }
}

spawn_cargo_chopper(cargo_heli_spawner) {
  cargo_heli = vehicle_spawn(cargo_heli_spawner);

  wait .1;
  cargo_item_spawners = cargo_heli_spawner.cargo_item_spawners;
  new_cargo = [];
  for(i = 0; i < cargo_item_spawners.size; i++) {
    new_cargo[i] = spawn(cargo_item_spawners[i].classname, cargo_item_spawners[i].origin);
    new_cargo[i].angles = cargo_item_spawners[i].angles;
    if(new_cargo[i].classname == "script_model")
      new_cargo[i] setModel(cargo_item_spawners[i].model);
    new_cargo[i] linkto(cargo_heli);
  }

  wait .1;

  thread gopath(cargo_heli);

  cargo_heli waittill("death");

  foreach(ent in new_cargo)
  ent Delete();
}

destroy_thing_with_at4(fire_pos_ent, thing, thing_offset, missile_func) {
  tag = "TAG_WEAPON_CHEST";
  guys = [];
  guys[guys.size] = self;

  fire_pos_ent anim_reach_and_plant(guys, "at4_fire");
  self.allowPain = false;
  self notify("finished_anim_reach");

  fire_pos_ent thread anim_custom_animmode(guys, "gravity", "at4_fire");

  self waittill("attach rocket");

  self place_weapon_on("at4", "chest");

  self waittill("fire rocket");

  gun = self gettagorigin(tag);
  newMissile = MagicBullet("at4_straight", gun, (thing.origin + thing_offset));

  self waittill("drop rocket");

  org_hand = self gettagorigin(tag);
  angles_hand = self gettagangles(tag);

  self place_weapon_on("at4", "none");

  model_at4 = spawn("script_model", org_hand);
  model_at4 setModel("weapon_at4");
  model_at4.angles = angles_hand;

  fire_pos_ent waittill("at4_fire");
  self.allowPain = true;
}

setup_village_defenders() {
  self waittill("death");
  level.village_defenders_dead++;
}

setup_bricktop() {
  level.bricktop = self;
  self.animname = "bricktop";
}

setup_base_redshirt() {
  self thread replace_on_death();
}

setup_village_redshirt() {}

setup_bricktop_village() {
  self thread magic_bullet_shield();

  if(isalive(level.gauntlet_east)) {
    self place_weapon_on("at4", "back");

    fire_pos_ent = getent(self.target, "targetname");
    thing = level.gauntlet_east;
    thing_offset = (0, 0, 64);
    self thread destroy_thing_with_at4(fire_pos_ent, thing, thing_offset);

    self waittill("finished_anim_reach");

    level.rasta dialogue_queue("cont_rst_standback");

    fire_pos_ent waittill("at4_fire");
  }
  self thread stop_magic_bullet_shield();

  self set_force_color("g");
  self enable_ai_color();
}

setup_rasta() {
  self.animname = "rasta";
  level.rasta = self;
  self thread magic_bullet_shield();
}

setup_rasta_village() {
  if(isalive(level.gauntlet_west)) {
    self place_weapon_on("at4", "back");

    fire_pos_ent = getent(self.target, "targetname");
    thing = level.gauntlet_west;
    thing_offset = (0, 0, 64);
    self thread destroy_thing_with_at4(fire_pos_ent, thing, thing_offset);

    self waittill("finished_anim_reach");

    level.rasta dialogue_queue("cont_rst_getback");

    fire_pos_ent waittill("at4_fire");
  }

  self set_force_color("g");
  self enable_ai_color();

  level.rasta dialogue_queue("cont_rst_checkfire");
}

setup_price() {
  level.price = self;
  level.price.animname = "price";

  if(level.price_destroys_btr)
    level.price place_weapon_on("at4", "back");

  level.price enable_ai_color();
  level.price.pathRandomPercent = 0;

  level.price thread magic_bullet_shield();

  level.price make_hero();
  level.price.allowdeath = false;

  self thread animscripts\utility::PersonalColdBreath();
}

stealth_settings() {
  stealth_set_default_stealth_function("bridge_area", ::stealth_bridge_area);
  stealth_set_default_stealth_function("woods", ::stealth_woods);
  stealth_set_default_stealth_function("base", ::stealth_base);

  ai_event = [];
  ai_event["ai_eventDistNewEnemy"] = [];
  ai_event["ai_eventDistNewEnemy"]["spotted"] = 512;
  ai_event["ai_eventDistNewEnemy"]["hidden"] = 256;

  ai_event["ai_eventDistExplosion"] = [];
  ai_event["ai_eventDistExplosion"]["spotted"] = level.explosion_dist_sense;
  ai_event["ai_eventDistExplosion"]["hidden"] = level.explosion_dist_sense;

  ai_event["ai_eventDistDeath"] = [];
  ai_event["ai_eventDistDeath"]["spotted"] = 512;
  ai_event["ai_eventDistDeath"]["hidden"] = 512;

  ai_event["ai_eventDistPain"] = [];
  ai_event["ai_eventDistPain"]["spotted"] = 256;
  ai_event["ai_eventDistPain"]["hidden"] = 256;

  ai_event["ai_eventDistBullet"] = [];
  ai_event["ai_eventDistBullet"]["spotted"] = 96;
  ai_event["ai_eventDistBullet"]["hidden"] = 96;

  ai_event["ai_eventDistFootstep"] = [];
  ai_event["ai_eventDistFootstep"]["spotted"] = 300;
  ai_event["ai_eventDistFootstep"]["hidden"] = 300;

  ai_event["ai_eventDistFootstepWalk"] = [];
  ai_event["ai_eventDistFootstepWalk"]["spotted"] = 300;
  ai_event["ai_eventDistFootstepWalk"]["hidden"] = 300;

  ai_event["ai_eventDistFootstepSprint"] = [];
  ai_event["ai_eventDistFootstepSprint"]["spotted"] = 400;
  ai_event["ai_eventDistFootstepSprint"]["hidden"] = 400;

  stealth_ai_event_dist_custom(ai_event);

  rangesHidden = [];
  rangesHidden["prone"] = 800;
  rangesHidden["crouch"] = 1200;
  rangesHidden["stand"] = 1600;

  rangesSpotted = [];
  rangesSpotted["prone"] = 8192;
  rangesSpotted["crouch"] = 8192;
  rangesSpotted["stand"] = 8192;

  stealth_detect_ranges_set(rangesHidden, rangesSpotted);

  stealth_alert_level_duration(0.5);

  stealth_ai_event_dist_custom(ai_event);

  array = [];
  array["sight_dist"] = 400;
  array["detect_dist"] = 200;
  stealth_corpse_ranges_custom(array);
}

sight_ranges_foggy_woods() {
  ai_event["ai_eventDistFootstep"] = [];
  ai_event["ai_eventDistFootstep"]["spotted"] = 120;
  ai_event["ai_eventDistFootstep"]["hidden"] = 120;

  ai_event["ai_eventDistFootstepWalk"] = [];
  ai_event["ai_eventDistFootstepWalk"]["spotted"] = 60;
  ai_event["ai_eventDistFootstepWalk"]["hidden"] = 60;

  ai_event["ai_eventDistFootstepSprint"] = [];
  ai_event["ai_eventDistFootstepSprint"]["spotted"] = 400;
  ai_event["ai_eventDistFootstepSprint"]["hidden"] = 400;

  stealth_ai_event_dist_custom(ai_event);

  rangesHidden = [];
  rangesHidden["prone"] = 250;
  rangesHidden["crouch"] = 450;
  rangesHidden["stand"] = 500;

  rangesSpotted = [];
  rangesSpotted["prone"] = 500;
  rangesSpotted["crouch"] = 500;
  rangesSpotted["stand"] = 600;

  stealth_detect_ranges_set(rangesHidden, rangesSpotted);

  alert_duration = [];
  alert_duration[0] = 1;
  alert_duration[1] = 1;
  alert_duration[2] = 1;
  alert_duration[3] = 0.75;

  stealth_alert_level_duration(alert_duration[level.gameskill]);
}

woods_prespotted_func() {
  wait 3;
}

stealth_woods() {
  self stealth_plugin_basic();

  if(isPlayer(self)) {
    return;
  }

  switch (self.team) {
    case "axis":
      if(self.type == "dog") {
        self thread dogs_have_small_fovs_when_stopped();
        self set_threatbias_group("dogs");
      } else {
        self thread attach_flashlight();
      }
      self.pathrandompercent = 0;
      self stealth_plugin_threat();
      self stealth_pre_spotted_function_custom(::woods_prespotted_func);

      threat_array["warning1"] = maps\_stealth_threat_enemy::enemy_alert_level_warning2;
      threat_array["attack"] = ::small_goal_attack_behavior;
      self stealth_threat_behavior_custom(threat_array);

      self stealth_enable_seek_player_on_spotted();
      self stealth_plugin_corpse();
      self stealth_plugin_event_all();
      self.baseaccuracy = 2;
      self.fovcosine = .5;
      self.fovcosinebusy = .1;

      self thread monitor_someone_became_alert();
      self thread monitor_stealth_kills();
      self thread monitor_stealth_pain();
      self init_cold_patrol_anims();

      if(isDefined(self.script_noteworthy) && (self.script_noteworthy == "cqb_patrol")) {
        if(isDefined(self.script_patroller)) {
          wait .05;
          self clear_run_anim();
        }
        self thread enable_cqbwalk();
        self.alertlevel = "alert";
        self.disablearrivals = undefined;
        self.disableexits = undefined;

        self.moveplaybackrate = .8;
        thread scan_when_idle();
      }

      break;

    case "allies":

  }
}

scan_when_idle() {
  self endon("death");
  while(1) {
    self set_generic_idle_anim("cqb_stand_idle_scan");

    self waittill("clearing_specialIdleAnim");
  }
}

stealth_bridge_area() {
  self stealth_plugin_basic();

  if(isPlayer(self)) {
    return;
  }
  switch (self.team) {
    case "axis":
      if(self.type == "dog") {
        self thread dogs_have_small_fovs_when_stopped();
        self set_threatbias_group("dogs");
      }

      if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "truck_guys"))
        self set_threatbias_group("truck_guys");
      else
        self set_threatbias_group("bridge_stealth_guys");

      self stealth_plugin_threat();

      self.pathrandompercent = 0;
      threat_array["warning1"] = maps\_stealth_threat_enemy::enemy_alert_level_warning2;
      threat_array["attack"] = ::small_goal_attack_behavior;
      self stealth_threat_behavior_custom(threat_array);
      self stealth_enable_seek_player_on_spotted();
      self stealth_plugin_corpse();
      self stealth_plugin_event_all();
      self.baseaccuracy = 3;
      self.fovcosine = .86;
      self.fovcosinebusy = .1;

      self thread monitor_stealth_kills();
      self thread monitor_someone_became_alert();

      if((isDefined(self.script_type)) && (self.script_type == "cold_patrol"))
        self init_cold_patrol_anims();
      break;

    case "allies":

      array = [];
      array["hidden"] = ::stealth_friendly_state_hidden;
      array["spotted"] = ::stealth_friendly_state_spotted;
      stealth_basic_states_custom(array);
  }
}

stealth_base() {
  self stealth_plugin_basic();

  if(isPlayer(self)) {
    return;
  }
  switch (self.team) {
    case "axis":

      self stealth_plugin_threat();

      self.pathrandompercent = 0;

      threat_array["attack"] = ::large_goal_ambush_attack_behavior;
      self stealth_threat_behavior_custom(threat_array);

      self stealth_plugin_event_all();

      self.fovcosine = .76;
      self.fovcosinebusy = .1;

      if((isDefined(self.script_type)) && (self.script_type == "cold_patrol"))
        self init_cold_patrol_anims();
      break;

    case "allies":

      array = [];
      array["hidden"] = ::stealth_friendly_state_hidden;
      array["spotted"] = ::stealth_friendly_state_spotted;
      stealth_basic_states_custom(array);
  }
}

price_dynamic_run_stop() {
  self endon("death");

  if(self ent_flag("dynamic_run_speed_stopped"))
    return;
  if(self ent_flag("dynamic_run_speed_stopping")) {
    return;
  }
  self endon("stop_dynamic_run_speed");

  self ent_flag_set("dynamic_run_speed_stopping");
  self ent_flag_set("dynamic_run_speed_stopped");

  stop = "DRS_run_2_stop";
  self maps\_anim::anim_generic_custom_animmode(self, "gravity", stop);
  self ent_flag_clear("dynamic_run_speed_stopping");

  if(!self ent_flag("dynamic_run_speed_stopped"))
    return;
  self endon("dynamic_run_speed_stopped");

  if(isDefined(self.loops) && self.loops > 0) {
    return;
  }
  while(self ent_flag("dynamic_run_speed_stopped")) {
    idle = "DRS_stop_idle";
    self thread maps\_anim::anim_generic_loop(self, idle);

    if(isDefined(level.scr_anim["generic"]["signal_go"]))
      self handsignal("go");

    wait RandomFloatRange(12, 20);

    if(self ent_flag_exist("_stealth_stance_handler"))
      self ent_flag_waitopen("_stealth_stance_handler");

    self notify("stop_loop");

    if(!self ent_flag("dynamic_run_speed_stopped")) {
      return;
    }
    if(isDefined(level.dynamic_run_speed_dialogue)) {
      string = random(level.dynamic_run_speed_dialogue);
      level thread radio_dialogue_queue(string);
    }

    if(isDefined(level.scr_anim["generic"]["signal_go"]))
      self handsignal("go");
  }
}

dogs_have_small_fovs_when_stopped() {
  self endon("death");

  while(1) {
    self waittill("master_reached_patrol_end");
    self.fovcosine = .99;
    self notify("end_patrol");

    self waittill("_stealth_normal");
    self.fovcosine = .76;
  }
}

setup_stealth_enemy_cleanup() {
  self.pathrandompercent = 200;
  self thread disable_cqbwalk();
  if(isDefined(self.script_stealthgroup))
    self thread maps\_stealth_shared_utilities::enemy_announce_spotted(self.origin);

  self.goalradius = 400;
  self.favoriteenemy = level.player;
  self setgoalentity(level.player);

  self waittill("death");
  level.stealth_enemies_remaining--;
}

Small_Goal_Attack_Behavior() {
  self.pathrandompercent = 200;
  self thread disable_cqbwalk();
  self thread maps\_stealth_shared_utilities::enemy_announce_spotted(self.origin);

  self.goalradius = 400;

  self endon("death");

  self ent_flag_set("_stealth_override_goalpos");

  while(isDefined(self.enemy) && self ent_flag("_stealth_enabled")) {
    self setgoalpos(self.enemy.origin);

    wait 4;
  }
}

setup_base_starting_guys() {
  self endon("death");
  self.ignoreme = true;
  self.maxsightdistsqrd = 600 * 600;

  flag_wait("base_alerted");

  self.ignoreme = false;
  self.maxsightdistsqrd = 8000 * 8000;

  self.favoriteenemy = level.player;

  wait 1;

  self.favoriteenemy = undefined;

  self.pathrandompercent = 200;
  self thread disable_cqbwalk();
  self.combatmode = "ambush";
  self setgoalpos(self.origin);
  self.goalradius = 4000;
  self.maxsightdistsqrd = 8000 * 8000;
}

large_goal_ambush_attack_behavior() {}

stealth_friendly_state_hidden() {
  flag_clear("price_is_hiding");
  self.no_pistol_switch = true;

  if((!flag("player_on_ridge")) && flag("safe_from_btrs"))
    self.maxsightdistsqrd = level.price_maxsightdistsqrd_woods;

  self.ignoreCloseFoliage = true;

  if(!flag("approaching_ridge")) {
    self disable_ai_color();

    if(isDefined(self.smart_path_following_node)) {
      self thread enable_cqbwalk();
      self thread price_smart_path_following(self.smart_path_following_node);
    }
  }

  self pushplayer(true);
  self.fixednode = true;

  self thread set_battlechatter(false);
  self set_friendlyfire_warnings(false);
  self.dontEverShoot = true;

  self.grenadeammo = 0;

  self.forceSideArm = undefined;

  self.ignoreme = true;

  self.ignoresuppression = true;
  setsaveddvar("ai_friendlyfireblockduration", 0);
  setsaveddvar("ai_friendlysuppression", 0);
}

stealth_friendly_state_spotted() {
  self notify("stop_dynamic_run_speed");
  self.no_pistol_switch = undefined;
  self.ignoreall = false;
  self.fixednode = true;
  self.ignoreCloseFoliage = true;

  if((!flag("approaching_ridge")) && !flag("safe_from_btrs")) {
    self enable_ai_color();
    self set_force_color("y");
  }

  self thread set_battlechatter(false);
  self set_friendlyfire_warnings(true);
  self.dontEverShoot = undefined;

  self.maxsightdistsqrd = 8000 * 8000;
  self.grenadeammo = 0;

  self.ignoreme = false;

  self pushplayer(false);

  self.ignoresuppression = false;
  setsaveddvar("ai_friendlyfireblockduration", 2000);
  setsaveddvar("ai_friendlysuppression", 1);
}

init_cold_patrol_anims() {
  if(!isDefined(level.lastColdPatrolAnimSetAssigned)) {
    level.lastColdPatrolAnimSetAssigned = "none";
  }

  if(level.lastColdPatrolAnimSetAssigned != "huddle") {
    self.patrol_walk_anim = "patrol_cold_huddle";
    self.patrol_walk_twitch = "patrol_twitch_weights";

    self.patrol_scriptedanim["pause"][0] = "patrol_cold_huddle_pause";
    self.patrol_stop["pause"] = "patrol_cold_huddle_stop";
    self.patrol_start["pause"] = "patrol_cold_huddle_start";

    self.patrol_stop["path_end_idle"] = "patrol_cold_huddle_stop";
    self.patrol_end_idle[0] = "patrol_cold_huddle_pause";

    level.lastColdPatrolAnimSetAssigned = "huddle";
  } else {
    self.patrol_walk_anim = "patrol_cold_crossed";
    self.patrol_walk_twitch = "patrol_twitch_weights";

    self.patrol_scriptedanim["pause"][0] = "patrol_cold_crossed_pause";
    self.patrol_stop["pause"] = "patrol_cold_crossed_stop";
    self.patrol_start["pause"] = "patrol_cold_crossed_start";

    self.patrol_stop["path_end_idle"] = "patrol_cold_crossed_stop";
    self.patrol_end_idle[0] = "patrol_cold_crossed_pause";

    level.lastColdPatrolAnimSetAssigned = "crossed";
  }
}

setup_bridge_trucks() {
  self endon("death");

  flag_wait("truck_guys_alerted");
  println("truck_guys_alerted");

  flag_wait("convoy_half_way_across_bridge");

  guys = get_living_ai_array("truck_guys", "script_noteworthy");

  if(guys.size == 0) {
    self Vehicle_SetSpeed(0, 15);
    return;
  }

  screamer = random(guys);
  screamer maps\_stealth_shared_utilities::enemy_announce_wtf();

  self Vehicle_SetSpeed(0, 15);
  wait 1;
  self maps\_vehicle::vehicle_unload();

  flag_set("jeep_stopped");
}

base_truck_guys_think() {
  self endon("death");

  level endon("_stealth_spotted");
  self endon("_stealth_attack");

  self ent_flag_init("jumped_out");
  self ent_flag_init("not_first_attack");
  self thread truck_guys_think_jumpout();

  self maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "wrapper", ::truck_animation_wrapper);

  alert_array = [];

  alert_array["attack"] = ::truck_alert_level_attack;
  self stealth_threat_behavior_custom(alert_array);

  awareness_array = [];
  awareness_array["explode"] = ::truck_guys_no_enemy_reaction_behavior;
  awareness_array["heard_scream"] = ::truck_guys_no_enemy_reaction_behavior;
  awareness_array["doFlashBanged"] = ::truck_guys_no_enemy_reaction_behavior;

  foreach(key, value in awareness_array)
  self maps\_stealth_event_enemy::stealth_event_mod(key, value);

  self ent_flag_set("_stealth_behavior_reaction_anim");
}

base_truck_guys_attacked_again() {
  self endon("death");
  self endon("_stealth_attack");
  level endon("_stealth_spotted");

  wait 2;

  self waittill("_stealth_bad_event_listener");

  self maps\_stealth_shared_utilities::enemy_reaction_state_alert();

  self ent_flag_set("not_first_attack");
}

truck_guys_base_search_behavior(node) {
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");
  self endon("death");
  self endon("pain_death");

  self thread base_truck_guys_attacked_again();

  self.disablearrivals = false;
  self.disableexits = false;

  distance = distance(node.origin, self.origin);

  self setgoalnode(node);
  self.goalradius = distance * .5;

  wait 0.05;
  self set_generic_run_anim("_stealth_patrol_cqb");
  self waittill("goal");

  self set_generic_run_anim("patrol_cold_gunup_search", true);

  self.disablearrivals = true;
  self.disableexits = true;
  self maps\_stealth_shared_utilities::enemy_runto_and_lookaround(node);
}

truck_guys_think_jumpout() {
  self endon("death");
  self endon("pain_death");

  while(1) {
    self waittill("jumpedout");
    self._stealth.behavior.last_spot = self.origin;

    self.got_off_truck_origin = self.origin;
    self ent_flag_set("jumped_out");

    self waittill("enteredvehicle");
    wait .15;
    self ent_flag_clear("jumped_out");
    self ent_flag_set("_stealth_behavior_reaction_anim");
  }
}

truck_animation_wrapper(type) {
  self endon("death");
  self endon("pain_death");

  flag_set("truck_guys_alerted");

  self ent_flag_wait("jumped_out");

  self maps\_stealth_shared_utilities::enemy_animation_wrapper(type);
}

truck_guys_reaction_behavior(type) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");

  flag_set("truck_guys_alerted");

  self ent_flag_wait("jumped_out");

  if(!flag("truck_guys_alerted"))
    return;
  if(flag_exist("truck_guys_not_going_back") && flag("truck_guys_not_going_back")) {
    return;
  }
  if(!flag("_stealth_spotted") && !self ent_flag("_stealth_attack")) {
    player = get_closest_player(self.origin);
    node = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(player.origin, 1500, 128);

    if(isDefined(node))
      self thread truck_guys_base_search_behavior(node);
  }

  spotted_flag = self group_get_flagname("_stealth_spotted");
  if(flag(spotted_flag))
    self flag_waitopen(spotted_flag);
  else
    self waittill("normal");
}

truck_guys_no_enemy_reaction_behavior(type) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");

  flag_set("truck_guys_alerted");

  self ent_flag_wait("jumped_out");

  if(!flag("truck_guys_alerted"))
    return;
  if(flag_exist("truck_guys_not_going_back") && flag("truck_guys_not_going_back")) {
    return;
  }
  if(!flag("_stealth_spotted") && !self ent_flag("_stealth_attack")) {
    origin = self._stealth.logic.event.awareness_param[type];

    node = self maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(origin, 300, 40);

    self thread maps\_stealth_shared_utilities::enemy_announce_wtf();

    if(isDefined(node))
      self thread truck_guys_base_search_behavior(node);
  }

  spotted_flag = self group_get_flagname("_stealth_spotted");
  if(flag(spotted_flag))
    self flag_waitopen(spotted_flag);
  else
    self waittill("normal");
}

truck_alert_level_attack(enemy) {
  self endon("death");
  self endon("pain_death");

  flag_set("truck_guys_alerted");
  self ent_flag_wait("jumped_out");

  self small_goal_attack_behavior();
}

setObjectiveWaypoint(objName, text) {
  objective = level.objectives[objName];
  if(isDefined(text))
    Objective_SetPointerTextOverride(objective.id, text);
  else
    Objective_SetPointerTextOverride(objective.id);
}

registerObjective(objName, objText, objOrigin) {
  flag_init(objName);
  if(!isDefined(level.objectives))
    level.objectives = [];
  objID = level.objectives.size;

  newObjective = spawnStruct();
  newObjective.name = objName;
  newObjective.id = objID;
  newObjective.state = "invisible";
  newObjective.text = objText;
  newObjective.origin = objOrigin;
  newObjective.added = false;

  level.objectives[objName] = newObjective;

  return newObjective;
}

setObjectiveState(objName, objState) {
  assert(isDefined(level.objectives[objName]));

  objective = level.objectives[objName];
  objective.state = objState;

  if(!objective.added) {
    objective_add(objective.id, objective.state, objective.text, objective.origin);
    objective.added = true;
  } else {
    objective_state(objective.id, objective.State);
  }

  if(objective.state == "done")
    flag_set(objName);
}

setObjectiveString(objName, objString) {
  objective = level.objectives[objName];
  objective.text = objString;

  objective_string(objective.id, objString);
}

setObjectiveLocation(objName, objLoc) {
  objective = level.objectives[objName];
  objective.loc = objLoc;

  objective_position(objective.id, objective.loc);
}

setObjectiveLocationMoving(objName, objEnt, offset) {
  level notify("moving " + objName);
  level endon("moving " + objName);
  objective = level.objectives[objName];

  Objective_OnEntity(objective.id, objEnt, offset);
}

setObjectiveRemaining(objName, objString, objRemaining) {
  assert(isDefined(level.objectives[objName]));

  objective = level.objectives[objName];

  if(!objRemaining)
    objective_string(objective.id, objString);
  else
    objective_string(objective.id, objString, objRemaining);
}

objective_main() {
  switch (level.start_point) {
    case "default":
    case "start":
      delay_first_obj();
    case "slide":
    case "woods":
    case "midwoods":
    case "ridge":
    case "village":

    case "base":
      objective_price();
      objective_get_to_sub();
    case "defend_sub":
      objective_defend_sub();
  }
}

delay_first_obj() {
  flag_wait("price_starts_moving");
}

objective_price() {
  while(!isDefined(level.price))
    wait .1;
  registerObjective("obj_price", &"CONTINGENCY_OBJ_PRICE", level.price.origin);
  setObjectiveState("obj_price", "current");
  thread setObjectiveLocationMoving("obj_price", level.price, (0, 0, 70));

  if(level.gameSkill > 1) {
    flag_wait("base_alerted");
  } else {
    flag_wait("price_splits_off");
  }

  setObjectiveState("obj_price", "done");
}

objective_get_to_sub() {
  if(level.gameSkill <= 1) {
    return;
  }
  origin = (-11742.0, 2368.0, 643.0);

  obj_reach_split_off = getstruct("obj_reach_split_off", "targetname");
  if(isDefined(obj_reach_split_off))
    origin = obj_reach_split_off.origin;
  registerObjective("obj_reach", &"CONTINGENCY_OBJ_ENTER_SUB", origin);
  setObjectiveState("obj_reach", "current");

  flag_wait("price_splits_off");

  setObjectiveState("obj_reach", "done");
}

objective_defend_sub() {
  flag_wait("price_splits_off");

  origin = getstruct("obj_guard_house", "targetname").origin;
  registerObjective("obj_sub", &"CONTINGENCY_OBJ_DEFEND_SUB", origin + (0, 0, 48));
  setObjectiveState("obj_sub", "current");
  setObjectiveWaypoint("obj_sub", &"CONTINGENCY_OBJ_DEFEND");

  flag_wait("close_sub_hatch");

  setObjectiveState("obj_sub", "done");
}

base_autosave_logic() {
  save = true;
  flag_wait("base_entrance");

  if(isDefined(level.timer_allowed_time)) {
    time_passed = (gettime() - level.timer_start_time) / 1000;
    println("time passed " + time_passed);
    time_left = level.timer_allowed_time - time_passed;
    println("time left " + time_left);
    if(time_left < 90)
      save = false;
    else
      save = true;
  }
  if(save)
    autosave_by_name("partway1");

  flag_wait("player_is_halfway_to_sub");

  if(isDefined(level.timer_allowed_time)) {
    time_passed = (gettime() - level.timer_start_time) / 1000;
    println("time passed " + time_passed);
    time_left = level.timer_allowed_time - time_passed;
    println("time left " + time_left);
    if(time_left < 80)
      save = false;
    else
      save = true;
  }
  if(save)
    autosave_by_name("partway2");

  flag_wait("base_ending");

  if(isDefined(level.timer_allowed_time)) {
    time_passed = (gettime() - level.timer_start_time) / 1000;
    println("time passed " + time_passed);
    time_left = level.timer_allowed_time - time_passed;
    println("time left " + time_left);
    if(time_left < 40)
      save = false;
    else
      save = true;
  }
  if(save)
    autosave_by_name("partway3");
}

timer_start() {
  if(getDvar("notimer") == "1")
    return;
  dialogue_line = undefined;
  level.timer_allowed_time = undefined;
  switch (level.gameSkill) {
    case 0:

      return;
    case 1:

      return;
    case 2:
      level.timer_allowed_time = 180;
      break;
    case 3:
      level.timer_allowed_time = 120;
      break;
  }
  assert(isDefined(level.timer_allowed_time));

  thread dialog_time_nags(level.timer_allowed_time);

  level thread timer_logic(level.timer_allowed_time, &"CONTINGENCY_TIME_TO_ENTER_SUB");
  level.timer_start_time = gettime();
}

timer_logic(iSeconds, sLabel, bUseTick) {
  if(getDvar("notimer") == "1") {
    return;
  }
  if(!isDefined(bUseTick))
    bUseTick = false;

  killTimer();
  level endon("kill_timer");

  level.hudTimerIndex = 20;
  level.timer = maps\_hud_util::get_countdown_hud(-250);
  level.timer SetPulseFX(30, 900000, 700);
  level.timer.label = sLabel;
  level.timer settenthstimer(iSeconds);
  level.start_time = gettime();

  if(bUseTick == true)
    thread timer_tick();
  wait(iSeconds);

  level.timer destroy();

  level thread mission_failed_out_of_time(&"CONTINGENCY_SUB_TIMER_EXPIRED");
}

killTimer() {
  level notify("kill_timer");
  if(isDefined(level.timer))
    level.timer destroy();
}

timer_tick() {
  level endon("stop_timer_tick");
  level endon("kill_timer");
  while(true) {
    wait(1);
    level.player thread play_sound_on_entity("countdown_beep");
    level notify("timer_tick");
  }
}

mission_failed_out_of_time(deadquote) {
  level.player endon("death");
  level endon("kill_timer");
  level notify("mission failed");
  level.player freezeControls(true);

  musicstop(1);
  setDvar("ui_deadquote", deadquote);
  maps\_utility::missionFailedWrapper();
  level notify("kill_timer");
}

set_threatbias_group(group) {
  assert(threatbiasgroupexists(group));
  self setthreatbiasgroup(group);
}

flashlight_when_alerted() {
  self endon("death");
  self ent_flag_waitopen("_stealth_normal");

  wait randomfloatrange(.2, .8);

  playFXOnTag(level._effect["flashlight"], self, "tag_flash");
  self.have_flashlight = true;
}

attach_flashlight() {
  playFXOnTag(level._effect["flashlight"], self, "tag_flash");
  self.have_flashlight = true;
}

bmp_turret_attack_player(end_if_cant_see, no_misses) {
  if(!isDefined(end_if_cant_see))
    end_if_cant_see = false;

  if(!isDefined(no_misses))
    no_misses = false;

  self endon("stop_shooting");
  self endon("death");
  while(1) {
    player = get_closest_player(self.origin);

    wait(randomfloatrange(0.8, 1.3));

    while(!can_see_player(player))
      wait(randomfloatrange(0.2, 0.6));

    if(!no_misses) {
      miss_player(player);
      wait(randomfloatrange(0.8, 2.4));

      miss_player(player);
      wait(randomfloatrange(0.8, 2.4));
    }

    while(can_see_player(player)) {
      fire_at_player(player);
      wait(randomfloatrange(2, 3));
    }

    if(end_if_cant_see) {
      if(!can_see_player(player)) {
        self clearturrettarget();
        self.turret_busy = false;

        self notify("stop_shooting");
      }
    }

  }
}

can_see_player(player) {
  if(distance(self.origin, level.player.origin) < level.min_btr_fighting_range)
    return false;

  tag_flash_loc = self getTagOrigin("tag_flash");

  player_eye = player getEye();
  if(SightTracePassed(tag_flash_loc, player_eye, false, self)) {
    if(isDefined(level.debug))
      line(tag_flash_loc, player_eye, (0.2, 0.5, 0.8), 0.5, false, 60);
    return true;
  } else {
    return false;
  }
}

fire_at_player(player) {
  burstsize = randomintrange(3, 5);

  fireTime = .2;
  for(i = 0; i < burstsize; i++) {
    self setturrettargetent(player, randomvector(20) + (0, 0, 32));
    self fireweapon();
    wait fireTime;
  }
}

miss_player(player) {
  forward = anglesToForward(level.player.angles);
  forwardfar = vector_multiply(forward, 100);
  miss_vec = forwardfar + randomvector(50);

  burstsize = randomintrange(4, 6);
  fireTime = .2;
  for(i = 0; i < burstsize; i++) {
    offset = randomvector(15) + miss_vec + (0, 0, 64);

    self setturrettargetent(player, offset);
    self fireweapon();
    wait fireTime;
  }
}