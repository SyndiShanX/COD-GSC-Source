/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\dcburning.gsc
********************************************************/

#include maps\_utility;
#include maps\_vehicle;
#include maps\_anim;
#include maps\_hud_util;
#include common_scripts\utility;

main() {
  setDvarIfUninitialized("cheap_spot", "1");
  initPrecache();
  maps\dcburning_precache::main();

  level.c4_models = [];
  level.chattertrigsinterior = getEntArray("interior_bcs", "targetname");
  level.chattertrigsexteriror = getEntArray("exterior_bcs", "targetname");
  array_thread(level.chattertrigsexteriror, ::trigger_off);
  array_thread(level.chattertrigsinterior, ::trigger_off);
  level.monument_target = getent("monument_target", "targetname");
  level.sniperOrgs = getEntArray("humvee_spotlight_targets", "targetname");
  level.crowsArmor = [];
  level.snipeEnemies = 4;
  level.onHeli = false;
  level.CannonRange = 6000;
  level.CannonRangeSquared = level.CannonRange * level.CannonRange;

  level.firemagicRPGs = true;
  level.squadsize = 3;
  level.mortarDamageRadius = 100;
  level.goodFriendlyDistanceFromPlayerSquared = 300 * 300;
  level.friendliesCanHelpCrowsnest = false;
  level.canTalk = true;
  level.evacSitePercentDestroyed = 0;
  level.targetsScriptedJavStinger = [];
  level.tempDialogueTime = 3;
  level.evacSiteEnemies = [];
  level.evacSiteVehicles = [];
  level.evacSiteEnemyVehicles = [];
  setDvarIfUninitialized("bog_camerashake", "1");
  level.spawnerCallbackThread = ::AI_think;
  level.droneCallbackThread = ::AI_drone_think;
  level.stealthDistanceSquared = 512 * 512;
  setDvarIfUninitialized("dc_debug", "0");
  setDvarIfUninitialized("dc_dialog", "1");
  level.cosine["25"] = cos(25);
  level.cosine["35"] = cos(35);
  level.cosine["45"] = cos(45);
  level.cosine["60"] = cos(60);
  level.cosine["90"] = cos(90);
  level.cosine["180"] = cos(180);
  level.mortarWithinFOV = level.cosine["35"];
  trigs = getEntArray("trigger_multiple", "classname");
  level.aColornodeTriggers = [];
  foreach(trigger in trigs) {
    if((isDefined(trigger.script_noteworthy)) && (getsubstr(trigger.script_noteworthy, 0, 10) == "colornodes")) {
      level.aColornodeTriggers = array_add(level.aColornodeTriggers, trigger);
    }
  }

  disable_color_trigs();

  add_start("debug", ::start_debug, "debug");
  add_start("elevator_bottom", ::start_elevator_bottom, "elevator_bottom");
  add_start("elevator_top", ::start_elevator_top, "elevator_top");
  add_start("crows_nest", ::start_crows_nest, "crows_nest");
  add_start("crows_nest_armor", ::start_crows_nest_armor, "crows_nest_armor");
  add_start("barrett", ::start_barrett, "barrett");
  add_start("to_roof", ::start_to_roof, "to_roof");
  add_start("roof", ::start_roof, "roof");
  add_start("heliride2", ::start_heli_ride2, "heliride2");
  add_start("crash", ::start_crash, "crash");

  default_start(::start_default);

  maps\dc_crashsite::main();
  maps\_breach_hinges_left::main();
  maps\_breach::main();
  maps\_drone_ai::init();
  maps\createart\dcburning_fog::main();
  maps\dcburning_fx::main();
  maps\createfx\dcburning_audio::main();
  maps\_minigun::main();
  maps\_blackhawk_minigun::main("vehicle_blackhawk_minigun_hero");
  maps\_hiding_door_anims::main();
  maps\_c4::main();
  maps\_load::main();
  maps\_nightvision::main();
  maps\_javelin::init();
  maps\_stinger::init();
  thread maps\dcburning_amb::main();
  thread maps\_barrett::barrett_init();
  maps\dcburning_anim::main();
  thread maps\_mortar::bunker_style_mortar();
  thread maps\_mortar::bog_style_mortar();
  array_thread(getEntArray("animated_vehicle", "script_noteworthy"), ::vehicle_animated_think);

  array_thread(getvehiclenodearray("plane_bomb", "script_noteworthy"), maps\_mig29::plane_bomb_cluster);

  flag_init("slamraam_c4_detonated");
  flag_init("stop_elevator_doors");
  flag_init("difficulty_initialized");
  flag_init("can_talk");
  flag_set("can_talk");

  maps\_compass::setupMiniMap("compass_map_dcburning");

  flag_init("obj_follow_sgt_macey_given");
  flag_init("obj_follow_sgt_macey_complete");
  flag_init("obj_commerce_given");
  flag_init("obj_commerce_complete");
  flag_init("obj_commerce_defend_snipe_given");
  flag_init("obj_commerce_defend_snipe_complete");
  flag_init("obj_commerce_defend_crow_given");
  flag_init("obj_commerce_defend_crow_complete");
  flag_init("obj_commerce_defend_javelin_given");
  flag_init("obj_commerce_defend_javelin_complete");
  flag_init("obj_rooftop_given");
  flag_init("obj_rooftop_complete");
  flag_init("obj_heli_mount_given");
  flag_init("obj_heli_mount_complete");
  flag_init("obj_heli_ride_given");

  flag_init("bunker_door_closed");
  flag_init("delete_bunker_mortars");

  flag_init("seaknight_drones_loaded");
  flag_init("seaknight_drones2_loaded");
  flag_init("bradley_can_start_firing");
  flag_init("humvee_commerce_left_done_with_spotlight");
  flag_init("javelin_is_owning_fools");
  flag_init("second_abrams_killed");
  flag_init("commerce_rappelers_inserting");
  flag_init("commerce_rappelers_rappeling");
  flag_init("commerce_rappelers_done");
  flag_init("trenches_dialogue_done");
  flag_init("lav_is_suppressing");
  flag_init("leader_orders_everyone_across_street");

  flag_init("atrium_guys_at_end_of_anim");
  flag_init("commerce_first_floor_enemies_dead");
  flag_init("courtyard_has_been_cleared");
  flag_init("ask_bradley_to_stop_firing");
  flag_init("mezzanine_top_has_been_cleared");
  flag_init("floor_four_has_been_cleared");
  flag_init("player_shot_at_samsite_guys");
  flag_init("commerce_samsite_revealed");

  flag_init("fifth_floor_guys_damaged");
  flag_init("start_music_to_crowsnest");
  flag_init("macey_tells_you_to_move_to_crows");

  flag_init("player_shot_at_crowsnest_guys");
  flag_init("crowsnest_has_been_cleared");
  flag_init("make_seaknights_take_off");
  flag_init("can_start_crow_nags");
  flag_init("only_2_sniper_enemies_remaining");

  flag_init("player_killed_enough");
  flag_init("humvee_spotlight_deleted");
  flag_init("perimeter_enemies_have_retreated");

  flag_init("start_crow_armor_sequence");
  flag_init("only_1_javelin_enemies_remaining");
  flag_init("only_2_javelin_enemies_remaining");
  flag_init("monument_dummy_target_setup");
  flag_init("crowsnest_sequence_finished");
  flag_init("player_has_killed_at_least_one_javelin_target");

  flag_init("roof_breach_complete");
  flag_init("roof_littlebird_lifted_off");
  flag_init("player_heli_spawned");
  flag_init("player_heli_ready_to_take_off");
  flag_init("roof_heli_about_to_be_owned");
  flag_init("roof_heli_owned");
  flag_init("player_getting_on_minigun");
  flag_init("player_has_used_minigun");
  flag_init("blackhawk_landed");
  flag_init("rooftop_run_dialogue_finished");

  flag_init("littlebird_crash_path_end");
  flag_init("littlebird_crash_path_end2");

  flag_init("player_starting_fastrope");
  flag_init("player_fastroped_out");
  flag_init("player_facing_blackhawk");

  flag_init("player_crash_starting");

  setsaveddvar("sm_sunShadowScale", 0.5);

  add_hint_string("grenade_launcher", &"SCRIPT_LEARN_GRENADE_LAUNCHER", ::should_break_m203_hint);
  add_hint_string("javelin_pickup", &"DCBURNING_HINT_JAVELIN_PICKUP", ::should_break_javelin_pickup_hint);
  add_hint_string("javelin_switch", &"DCBURNING_HINT_JAVELIN_SWITCH", ::should_break_javelin_switch_hint);
  add_hint_string("javelin_shoot", &"DCBURNING_HINT_JAVELIN_FIRE", ::should_break_javelin_fire_hint);

  array_thread(getEntArray("destructible_trigger", "targetname"), ::destructible_trigger_think);
  thread AA_global();
  hideAll();
  fx_management();

  setsaveddvar("r_lightGridEnableTweaks", 0);
  setsaveddvar("r_lightGridIntensity", 1.2);
  setsaveddvar("r_lightGridContrast", 0);

  thread init_difficulty();
  thread lights();
  init_air_vehicle_flags();

  array_thread(getEntArray("ai_cleanup_trigger", "targetname"), ::ai_cleanup_trigger_think);
  array_thread(getEntArray("redshirt_trigger", "targetname"), ::redshirt_trigger_think);
  array_thread(getEntArray("rpg_targets", "targetname"), ::rpg_targets_think);
  array_thread(getEntArray("dest_cheap", "targetname"), ::cheap_destructibles_think);

  createthreatbiasgroup("player");
  createthreatbiasgroup("ignored");
  createthreatbiasgroup("oblivious");
  level.player setthreatbiasgroup("player");
  setignoremegroup("allies", "oblivious");
  setignoremegroup("axis", "oblivious");
  setignoremegroup("player", "oblivious");
  setignoremegroup("oblivious", "allies");
  setignoremegroup("oblivious", "axis");
  setignoremegroup("oblivious", "oblivious");

  aVehicleSpawners = maps\_vehicle::_getvehiclespawnerarray();
  array_thread(aVehicleSpawners, ::add_spawn_function, ::vehicle_think);
  array_thread(getEntArray("ai_ambient", "script_noteworthy"), ::add_spawn_function, ::ai_ambient_noprop_think);
  array_thread(getEntArray("ai_ambient_prop", "script_noteworthy"), ::add_spawn_function, ::ai_ambient_prop_think);

  array_spawn_function_noteworthy("door_breaker", ::AI_door_breaker_think);
  array_spawn_function_targetname("hostiles_commerce_samsite", ::AI_hostiles_commerce_samsite_think);
  array_spawn_function_targetname("commerce_sector_2_guys", ::AI_commerce_sector_2_guys_think);
  array_spawn_function_targetname("crowsnest_assault_guys_wave1", ::AI_crowsnest_assault_guys_wave1_think);
  array_spawn_function_targetname("commerce_flare_guys", ::AI_commerce_flare_guys_think);
  array_spawn_function_targetname("ww2_heli", ::vehicle_ww2_enemy_helis_think);
  array_spawn_function_noteworthy("no_suppress", ::ai_no_suppress_think);
  array_spawn_function_noteworthy("friendly_fodder", ::AI_friendly_fodder_think);
  array_spawn_function_noteworthy("enemy_spotter_prone", ::AI_jav_sting_spot_think);
  array_spawn_function_noteworthy("enemy_spotter_crouched", ::AI_jav_sting_spot_think);
  array_spawn_function_noteworthy("enemy_javelin", ::AI_jav_sting_spot_think);
  array_spawn_function_noteworthy("enemy_stinger", ::AI_jav_sting_spot_think);
  array_spawn_function_noteworthy("waittill_damaged_and_set_flag", ::AI_waittill_damaged_and_set_flag_think);
  array_spawn_function_noteworthy("invisible_patrol_fodder", ::AI_invisible_patrol_fodder_think);
  array_spawn_function_noteworthy("at4_friendly", ::AI_at4_friendly_think);
  array_spawn_function_noteworthy("player_seek", ::AI_player_seek);
  array_spawn_function_noteworthy("roof_escape_redshirts", ::AI_roof_escape_redshirts_think);
  array_spawn_function_noteworthy("redshirt", ::AI_redshirt_think);
  array_spawn_function_noteworthy("glass_building_enemies", ::AI_glass_building_enemies_think);
  array_spawn_function_noteworthy("ambush", ::AI_ambush_behavior);
  array_spawn_function_noteworthy("hummer_gunner", ::AI_hummer_gunner_think);
  array_spawn_function_targetname("commerce_rpg_upper", ::AI_commerce_rpg_upper_think);

  setsaveddvar("r_spotlightbrightness", "6");
  setsaveddvar("r_spotlightstartradius", "50");
  setsaveddvar("r_spotlightEndradius", "250");
  setsaveddvar("r_spotlightfovinnerfraction", "0");
  setsaveddvar("r_spotlightexponent", "2");
}

init_air_vehicle_flags() {
  array1 = getEntArray("script_origin", "classname");
  aAirNodes = array_merge(array1, level.struct);
  array_thread(aAirNodes, ::air_nodes_think);
}

air_nodes_think() {
  if(!isDefined(self.script_flag)) {
    return;
  }
  flag_init(self.script_flag);
  if(getDvar("dc_debug") == "1") {
    self thread debug_message(self.script_flag, self.origin, 9999);
  }
  self waittill("trigger");
  flag_set(self.script_flag);
  if(getDvar("dc_debug") == "1") {
    iPrintlnbold("flag: " + self.script_flag + " has been set");
  }
}

start_default() {
  AA_bunker_init();
}

start_debug() {
  initFriendlies("elevator_bottom");
}

start_elevator_bottom() {
  maps\_utility::vision_set_fog_changes("dcburning_commerce", 0);
  initFriendlies("elevator_bottom");
  thread obj_commerce();
  flag_set("obj_commerce_given");
  array_thread(level.squad, ::cqb_walk, "on");
  triggersEnable("colornodes_commerce_bot_to_top", "script_noteworthy", true);
  AA_elevator_bottom_init();
}

start_elevator_top() {
  maps\_utility::vision_set_fog_changes("dcburning_commerce", 0);
  initFriendlies("elevator_top");
  battlechatter_off("allies");
  array_thread(level.squad, ::cqb_walk, "on");
  flag_set("player_at_commerce_crows_floor");
  AA_elevator_top_init();
}

start_crows_nest() {
  maps\_utility::vision_set_fog_changes("dcburning_commerce", 0);
  initFriendlies("crows_nest");
  battlechatter_off("allies");
  array_thread(level.squad, ::cqb_walk, "on");
  flag_set("player_approaching_crowsnest");
  flag_set("player_approaching_crowsnest2");
  AA_crows_nest_snipe_init();
}

start_crows_nest_armor() {
  maps\_utility::vision_set_fog_changes("dcburning_commerce", 0);
  initFriendlies("crows_nest");
  battlechatter_off("allies");
  array_thread(level.squad, ::cqb_walk, "on");
  flag_set("start_crow_armor_sequence");
  flag_set("player_approaching_crowsnest");
  flag_set("player_approaching_crowsnest2");
  AA_crows_nest_armor_init();
}

start_barrett() {
  maps\_utility::vision_set_fog_changes("dcburning_commerce", 0);
  initFriendlies("crows_nest");
  battlechatter_off("allies");
  array_thread(level.squad, ::cqb_walk, "on");
}

start_to_roof() {
  maps\_utility::vision_set_fog_changes("dcburning_commerce", 0);
  initFriendlies("to_roof");
  battlechatter_on("allies");
  array_thread(level.squad, ::cqb_walk, "on");
  flag_set("only_2_javelin_enemies_remaining");
  flag_set("crowsnest_sequence_finished");
  thread AA_commerce_to_roof_init();
}

start_roof() {
  maps\_utility::vision_set_fog_changes("dcburning_commerce", 0);
  initFriendlies("Roof");
  array_thread(level.squad, ::cqb_walk, "off");
  flag_set("player_headed_to_roof");
  flag_set("player_approaching_outer_balcony");

  dummy_trigger("trigger_dummy_roof_colornode");
  AA_roof_init();
}

start_heli_ride2() {
  maps\_utility::vision_set_fog_changes("dcburning_heliride", 0);
  heliNode = getstruct("player_heli_ww2_end", "script_noteworthy");
  player_blackhawk_setup(heliNode);

  level.blackhawk.minigunUser = level.player;

  level.blackhawk thread maps\_minigun::minigun_think();

  thread AA_heli_ride2();
}

start_crash() {
  thread maps\dc_crashsite::AA_crash_site_init();
  wait(.1);
  flag_set("player_crash_done");
}

AA_bunker_init() {
  initFriendlies("Bunker");
  thread bunker_mortars();
  thread music_bunker();
  thread commerce_flyby();

  thread AAA_sequence_bunker_to_commerce();
  thread obj_follow_sgt_macey();
  thread obj_commerce();
  thread dialogue_bunker();
  thread dialogue_trenches();
  thread javelins_trench();
  thread humvee_commerce_left();
  thread humvee_commerce();
  thread bradley_commerce();
  thread humvee_convoy();
  thread helis_monument();
  thread helis_monument_ground();
  thread helis_monument_cargo();
  thread commerce_rappelers();
  thread capitol_trench();

  flag_wait("player_commerce_trench_02");
  thread AA_elevator_bottom_init();
}

music_bunker() {
  thread music_loop("dcburning_intropad", 87);
  flag_wait("player_bunker_walk_03");
  music_stop(5);
  wait(5.1);
  musicPlayWrapper("dcburning_intropeak");
}

commerce_flyby() {
  flag_wait("player_commerce_past_desks");
  level.vehicles_commerce_ambient = spawn_vehicles_from_targetname_and_drive("vehicles_commerce_ambient");
}

AAA_sequence_bunker_to_commerce() {
  if(getdvarint("r_dcburning_culldist") == 1) {
    setculldist(28500);
  }

  thread ignoreme_on_squad_and_player();

  flavorbursts_off("allies");
  battlechatter_off("allies");
  battlechatter_off("axis");

  level.teamLeader thread make_ambient_ai("bunker_radio_door_guy");
  level.friendly02 thread make_ambient_ai("gun_toss_guy2");
  level.friendly03 thread make_ambient_ai("gun_toss_guy1");

  bunker_laptop_guys = array_spawn(getEntArray("bunker_laptop_guys", "targetname"));
  thread bunker_radio_chatter();
  bunker_hallway_injured_guys = array_spawn(getEntArray("bunker_hallway_injured_guys", "targetname"));
  bunker_hallway_injured_guys2 = array_spawn(getEntArray("bunker_hallway_injured_guys2", "targetname"));
  bunker_sleeping_guys = array_spawn(getEntArray("bunker_sleeping_guys", "targetname"));
  bunker_doctor_and_patient = array_spawn(getEntArray("bunker_doctor_and_patient", "targetname"));
  spawner = getent("bunker_hallway_injured_carrier", "targetname");
  bunker_hallway_injured_carrier = spawner spawn_ai();
  bunker_sitting_guys = array_spawn(getEntArray("bunker_sitting_guys", "targetname"));

  flag_wait("introscreen_complete");

  flag_wait("player_bunker_comm_room");
  triggersEnable("colornodes_trenches", "script_noteworthy", true);

  flag_wait("player_approaching_bunker_exit_hall");

  drones_flood_monument = getEntArray("drones_flood_monument", "targetname");
  thread drone_flood_start(drones_flood_monument, "drones_flood_monument");
  thread drones_trenches();

  if(getdvarint("r_dcburning_culldist") != 1) {
    level.helis_ambient_trenches = spawn_vehicles_from_targetname_and_drive("helis_ambient_trenches");
    level.helis_ambient_capitol = spawn_vehicles_from_targetname_and_drive("helis_ambient_capitol");
  }
  delaythread(0, maps\_mortar::bog_style_mortar_on, 2);

  drone_warrior_hydrant = dronespawn(getent("drone_warrior_hydrant", "targetname"));
  drone_warrior_hydrant thread drone_warrior_hydrant_think();

  seaknight_loader_start = getent("seaknight_loader_start", "targetname");
  seaknight_loader_start notify("spawn");

  seaknight_loader_start2 = getent("seaknight_loader_start2", "targetname");
  seaknight_loader_start2 notify("spawn");

  littlebird_monument = spawn_vehicle_from_targetname_and_drive("littlebird_monument");
  littlebird_monument_riders_left = array_spawn(getEntArray("littlebird_monument_riders_left", "targetname"));
  array_thread(littlebird_monument_riders_left, ::AI_ignored_and_oblivious_on);
  array_thread(littlebird_monument_riders_left, ::magic_bullet_shield);
  littlebird_monument_riders_right = array_spawn(getEntArray("littlebird_monument_riders_right", "targetname"));
  array_thread(littlebird_monument_riders_right, ::AI_ignored_and_oblivious_on);
  array_thread(littlebird_monument_riders_right, ::magic_bullet_shield);

  pickup_node_before_stage_monument = getstruct("pickup_node_before_stage_monument", "script_noteworthy");
  littlebird_monument set_stage(pickup_node_before_stage_monument, littlebird_monument_riders_left, "left");
  littlebird_monument set_stage(pickup_node_before_stage_monument, littlebird_monument_riders_right, "right");

  aTrenchAIToDelete = [];
  spawners = getEntArray("monument_spotters", "targetname");
  monument_spotters = array_spawn(spawners, true);
  aTrenchAIToDelete = array_merge(aTrenchAIToDelete, monument_spotters);

  flag_wait("player_approaching_monument");

  spawner = getent("drones_seaknight", "targetname");
  thread seaknight_drone_loaders(spawner, "seaknight_drones_loaded", "player_exiting_start_trench2");

  spawner = getent("drones_seaknight2", "targetname");
  thread seaknight_drone_loaders(spawner, "seaknight_drones2_loaded", "player_exiting_start_trench");

  flag_wait("player_exiting_start_trench");

  seaknight_loader_start thread waittill_flag_then_notify("seaknight_drones_loaded", "load_riders");
  seaknight_loader_start thread waittill_notify_then_notify("riders_loaded", "play_anim");

  seaknight_loader_start2 thread waittill_flag_then_notify("seaknight_drones2_loaded", "load_riders");
  seaknight_loader_start2 thread waittill_notify_then_notify("riders_loaded", "play_anim");

  spot_targets = getEntArray("spot_targets", "script_noteworthy");
  array_thread(spot_targets, ::spot_targets_think);

  bunker_doorup = getent("bunker_door_up", "targetname");
  bunker_doorup hide_entity();
  bunker_door = getEntArray("bunker_door", "targetname");
  array_thread(bunker_door, ::show_entity);
  flag_set("bunker_door_closed");

  mortar_bunker = getStructArray("mortar_bunker", "targetname");
  mortar_bunker_radius_triggers = getEntArray("mortar_bunker", "targetname");
  array_call(mortar_bunker_radius_triggers, ::delete);
  thread struct_delete(mortar_bunker, "delete_bunker_mortars");
  bunker_radio_org_room2 = getent("bunker_radio_org_room2", "targetname");
  bunker_radio_org_room2 delete();
  volume_bunker = getent("volume_bunker", "targetname");
  aAI = volume_bunker get_ai_touching_volume_non_squad();
  aDrones = volume_bunker get_drones_touching_volume("allies");
  aAI = array_merge(aAI, aDrones);
  array_thread(aAI, ::AI_delete);
  array_thread(level.effects_bunker, ::pauseEffect);

  spawner = getent("monument_waver", "targetname");
  monument_waver = spawner spawn_ai(true);
  spawners = getEntArray("friendlies_commerce_street", "targetname");
  friendlies_commerce_street = [];
  foreach(spawner in spawners) {
    friendlies_commerce_street[friendlies_commerce_street.size] = spawner spawn_ai(true);
  }

  array_thread(friendlies_commerce_street, ::try_to_magic_bullet_shield);

  spawners = getEntArray("friendlies_commerce_wall", "targetname");
  friendlies_commerce_wall = [];
  foreach(spawner in spawners) {
    friendlies_commerce_wall[friendlies_commerce_wall.size] = spawner spawn_ai(true);
  }

  flag_wait("player_exiting_start_trench2");
  spawners = getEntArray("monument_mortarguys", "targetname");
  monument_mortarguy = array_spawn(spawners, true);

  flag_wait("commerce_enemy_javeling_failsafe");

  aTrenchAIToDelete = array_add(aTrenchAIToDelete, monument_waver);
  thread AI_delete_when_out_of_sight(aTrenchAIToDelete, 1024);

  littlebird_monument thread load_side("left", littlebird_monument_riders_left);
  littlebird_monument thread load_side("right", littlebird_monument_riders_right);
  littlebird_monument_path = getstruct("littlebird_monument_path", "targetname");
  littlebird_monument thread vehicle_littlebird_gopath_when_loaded_and_flag_set("player_exiting_start_trench", littlebird_monument_path);

  drones_flood_monument2 = getEntArray("drones_flood_monument2", "targetname");
  thread drone_flood_start(drones_flood_monument2, "drones_flood_monument2");

  flag_wait("player_trench_capitol_failsafe");

  heli_trench = spawn_vehicle_from_targetname_and_drive("heli_trench");
  heli_commerce_front = spawn_vehicle_from_targetname_and_drive("heli_commerce_front");

  flag_wait("player_commerce_trench_01");
  level.player.ignoreme = false;
  level.player set_threatbias(1500);

  flag_wait("player_commerce_trench_03");

  flag_wait_either("player_touching_commerce_wall_left", "player_touching_commerce_wall_right");
  thread autosave_by_name("commerce_wall");
  thread ignoreme_off_squad_and_player();

  level.bradley_commerce.fireAtDefaultTargets = false;

  array_thread(friendlies_commerce_street, ::stop_magic_bullet_shield);
  array_thread(friendlies_commerce_street, ::AI_redshirt_think);

  flag_wait_or_timeout("player_approaching_commerce", 5);
  triggersEnable("colornodes_commerce_approach", "script_noteworthy", true);
  colornodes_commerce_approach = getEntArray("colornodes_commerce_approach", "script_noteworthy");

  thread dialogue_nag_cross_the_street();

  flag_set("lav_is_suppressing");

  hostiles = getaiarray("axis");
  foreach(guy in hostiles) {
    if(!isDefined(guy)) {
      continue;
    }
    guy.ignoresuppression = false;
    guy.aggressivemode = false;
  }

  flag_wait_any("leader_orders_everyone_across_street", "player_entered_commerce_right", "player_entered_commerce_left");

  if(!flag("player_crossing_street")) {
    trig_colornode = getclosest(level.player.origin, colornodes_commerce_approach);
    trig_colornode notify("trigger", level.player);
  }

  level.squad = remove_dead_from_array(level.squad);
  array_thread(level.squad, ::AI_ignored_and_oblivious_on);

  flag_wait("player_entering_commerce");

  level.squad = remove_dead_from_array(level.squad);
  array_thread(level.squad, ::AI_ignored_and_oblivious_off);

  commerce_blocker_right = getent("commerce_blocker_right", "targetname");
  commerce_blocker_left = getent("commerce_blocker_left", "targetname");
  aBlockers = [];
  aBlockers[0] = commerce_blocker_right;
  aBlockers[1] = commerce_blocker_left;
  blocker = getfarthest(level.player.origin, aBlockers);
  blocker show();
  blocker solid();
  blocker disconnectpaths();

  flag_wait_either("player_entered_commerce_left", "player_entered_commerce_right");
  thread drone_flood_stop("drones_flood_monument");
  thread drone_flood_stop("drones_flood_monument2");

  array_thread(level.chattertrigsexteriror, ::trigger_off);
  array_thread(level.chattertrigsinterior, ::trigger_on);
  triggersEnable("colornodes_commerce_bot_to_top", "script_noteworthy", true);

  flag_clear("lav_is_suppressing");
  hostiles = getaiarray("axis");
  foreach(guy in hostiles) {
    if(!isDefined(guy)) {
      continue;
    }
    guy.ignoresuppression = true;
    guy.aggressivemode = true;
  }

  thread autosave_by_name("commerce_entered");

  flag_set("obj_follow_sgt_macey_complete");
  triggersEnable("colornodes_elevators", "script_noteworthy", true);

  thread AI_delete_when_out_of_sight(friendlies_commerce_street, 1024);

  thread dialogue_nag_get_to_elevator();

  volume_commerce_lobby_upper = getent("volume_commerce_lobby_upper", "targetname");
  upper_floor_enemies = volume_commerce_lobby_upper get_ai_touching_volume("axis");

  if((isDefined(upper_floor_enemies)) && (upper_floor_enemies.size > 0)) {
    level.bradleyPreferredTargets = upper_floor_enemies;
  }

  wait(1);
  thread commerce_first_floor_enemies_dead_monitor();

  level.bradley_commerce.firing = false;

  delaythread(4, ::m203_hint);

  flag_wait_either("commerce_first_floor_enemies_dead", "player_middle_commerce_first_floor");

  level.player reset_threatbias();

  if(!flag("player_middle_commerce_first_floor")) {
    trig_colornode = getent("colornodes_elevators", "script_noteworthy");
    trig_colornode notify("trigger", level.player);
  }

  flag_wait("player_heading_up_to_mezzanine");
  thread AI_drone_cleanup("all", 1024, true);
  level.bradleyPreferredTargets = undefined;
  level.bradley_commerce.fireAtDefaultTargets = true;
  level.bradley_commerce.firing = true;

  mezzanine_blockers = getEntArray("mezzanine_blockers", "targetname");
  array_thread(mezzanine_blockers, ::show_entity);

  flag_wait("ask_bradley_to_stop_firing");
  level.bradley_commerce.firing = false;

  flag_wait("player_entering_top_elevator_area");

  thread AI_cleanup_non_squad("all", 128);
}

AI_commerce_rpg_upper_think() {
  self endon("death");
  self.a.disableLongDeath = true;
  level endon("player_approaching_commerce");
  flag_wait("player_commerce_trench_03");

  aNodes = getnodearray("commerce_lobby_teleport_nodes", "targetname");
  eNode = getClosest(level.player.origin, aNodes);
  self forceTeleport(eNode.origin, eNode.angles);
  self setgoalpos(self.origin);
  self.attackeraccuracy = 0;
  volume_commerce_front = getent("volume_commerce_front", "targetname");
  self setgoalvolumeauto(volume_commerce_front);
  flag_wait_either("player_crossing_street", "leader_orders_everyone_across_street");
  wait(randomfloatrange(0, 1));
  thread ambient_mortar_explosion(self.origin);
  self kill();
}

m203_hint() {}

seaknight_drone_loaders(spawner, sFlagToSetWhenLoaded, sFlagToStop) {
  i = 1;
  while(!flag(sFlagToStop)) {
    dude = spawner dronespawn();

    wait(randomfloatrange(1, 2.5));
  }
  seaknight_drone_loaders = get_drones_with_targetname(spawner.targetname);
  seaknight_drone_loaders = remove_dead_from_array(seaknight_drone_loaders);
  waittill_dead(seaknight_drone_loaders);
  flag_set(sFlagToSetWhenLoaded);
}

vehicle_littlebird_gopath_when_loaded_and_flag_set(sFlag, pathStart) {
  while(self.riders.size < 6) {
    wait(.1);
  }

  flag_wait(sFlag);

  self thread vehicle_paths(pathStart);
  self setmaxpitchroll(20, 50);
  wait(2);
  self vehicle_ai_event("idle_alert_to_casual");
  self Vehicle_SetSpeed(25);
  self.script_vehicle_selfremove = 1;
  wait(5);
  array_thread(self.riders, ::stop_magic_bullet_shield);
  self thread vehicle_delete_when_out_of_sight();
}

drone_warrior_hydrant_think() {
  self endon("death");

  flag_wait("player_mid_trench");

  play_sound_in_space("mortar_incoming", self.origin);
  playFX(level._effect["mortar"]["dirt"], self.origin);
  earthquake(0.25, 0.75, self.origin, 1250);
  thread play_sound_in_space(level.scr_sound["mortar"]["dirt"], self.origin);
  self notify("stop_drone_fighting");
  thread play_sound_in_space("generic_death_american_1", self.origin);
  self.deathanim = level.scr_anim["generic"]["deathanim_mortar_00"];
  self kill();
}

spot_targets_think() {
  movetime = 2.4;
  moveDistVert = 50;
  moveDistHor = 50;

  wait(movetime);
  while(!flag("obj_commerce_defend_snipe_given")) {
    self moveTo(self.origin + (0, 0, moveDistVert), movetime, 1, 1);
    wait(movetime);

    self moveTo(self.origin + (moveDistHor, 0, 0), movetime, 1, 1);
    wait(movetime);

    self moveTo(self.origin + (0, 0, moveDistVert * (-1)), movetime, 1, 1);
    wait(movetime);

    self moveTo(self.origin + (moveDistHor * (-1), 0, 0), movetime, 1, 1);
    wait(movetime);
  }

  self delete();
}

bunker_mortars() {
  bunker_mortars = false;
  while(!flag("bunker_door_closed")) {
    if(!flag("player_inside_bunker")) {
      maps\_mortar::bunker_style_mortar_off_nowait(0);
      bunker_mortars = false;
    } else if(bunker_mortars == false) {
      maps\_mortar::bunker_style_mortar_on(0);
      bunker_mortars = true;
    }
    wait(3);
  }
  maps\_mortar::bunker_style_mortar_off_nowait(0);
  flag_set("delete_bunker_mortars");
}

bunker_radio_chatter() {
  level.bunker_radio_org = spawn("script_origin", level.player.origin);
  level.bunker_radio_org linkto(level.player);
  level.bunker_radio_org.linked = true;

  level endon("javelin_is_owning_fools");

  bunker_radio("dcburn_rm1_report1dash3");

  bunker_radio("dcburn_rm2_sendtraffic");

  bunker_radio("dcburn_rm1_40personnel");

  bunker_radio("dcburn_rm1_lineyankee");

  bunker_radio("dcburn_rm1_linezulu");

  bunker_radio("dcburn_rm1_linealpha");

  bunker_radio("dcburn_rm2_sayagain");

  bunker_radio("dcburn_rm1_sayagain");

  bunker_radio("dcburn_rm2_remarks");

  bunker_radio("dcburn_rm1_noremarks");

  bunker_radio("dcburn_rm2_needintel");

  bunker_radio("dcburn_rm3_engparatroop");

  bunker_radio("dcburn_rm4_footmobiles");

  bunker_radio("dcburn_rm5_thermlaws");

  bunker_radio("dcburn_rm4_whattarget");

  bunker_radio("dcburn_rm5_dropbuilding");

  bunker_radio("dcburn_rm4_fedresbuild");

  bunker_radio("dcburn_rm5_allover");

  bunker_radio("dcburn_rm4_checkin");

  bunker_radio("dcburn_rm5_roger");

  bunker_radio("dcburn_rm4_thermlaws");

  bunker_radio("dcburn_rm6_copiesall");

  bunker_radio("dcburn_rm4_stndingby");

  bunker_radio("dcburn_rm6_thermlawsauth");

  bunker_radio("dcburn_rm4_approved");

  bunker_radio("dcburn_rm5_solidcopy");

  bunker_radio("dcburn_rm5_apprengage");

  bunker_radio("dcburn_rm1_engagingtarg");

  bunker_radio("dcburn_rm1_targetsupp");

  bunker_radio("dcburn_rm4_saddleup");

  bunker_radio("dcburn_rm5_btr60");

  bunker_radio("dcburn_rm6_lawrocket");

  bunker_radio("dcburn_rm1_logancircpark");

  bunker_radio("dcburn_rm2_22isdown");

  bunker_radio("dcburn_rm3_airsupport");

  bunker_radio("dcburn_rm5_mark19down");

  bunker_radio("dcburn_rm4_retrograde");

  bunker_radio("dcburn_rm3_lowammo");

  bunker_radio("dcburn_rm3_5btr60s");

  bunker_radio("dcburn_rm2_callingitin");

  bunker_radio("dcburn_ra2_standingby");

  bunker_radio("dcburn_rm2_gridtomark");

  bunker_radio("dcburn_ra2_gridtosuppress");

  bunker_radio("dcburn_rm2_reqsplash");

  bunker_radio("dcburn_ra2_dangerclose");

  bunker_radio("dcburn_ra2_mess2ob");

  bunker_radio("dcburn_rm2_2gunseffect");

  bunker_radio("dcburn_ra2_shot");

  bunker_radio("dcburn_rm2_shot");

  bunker_radio("dcburn_rm2_splash");

  bunker_radio("dcburn_ra2_splash");

  bunker_radio("dcburn_rm3_takeitout");

  bunker_radio("dcburn_rm2_linkup");

  bunker_radio("dcburn_rm4_dugin");

  bunker_radio("dcburn_rm2_sitrep");

  bunker_radio("dcburn_rm4_brokenarrow");

  bunker_radio("dcburn_rm2_brokearrow");

  bunker_radio("dcburn_rm5_sitrep");

  bunker_radio("dcburn_rm6_kia");

  bunker_radio("dcburn_rm5_tacfreq");

  bunker_radio("dcburn_rm6_switching");

  bunker_radio("dcburn_rm1_12klicksnorth");

  bunker_radio("dcburn_rm2_contactleft");

  bunker_radio("dcburn_rm3_takingfire");

  bunker_radio("dcburn_rm4_tookahit");

  bunker_radio("dcburn_rm5_status");

  bunker_radio("dcburn_rm1_heavyfire");

  bunker_radio("dcburn_rm2_ambush");

  bunker_radio("dcburn_rm3_contactleft");

  bunker_radio("dcburn_rm4_rpg");

  bunker_radio("dcburn_rm5_coversector");

  bunker_radio("dcburn_rp1_tasking");

  bunker_radio("dcburn_fac_pushtoipbuick");

  bunker_radio("dcburn_rp1_mapgrid");

  bunker_radio("dcburn_fac_2a10s");

  bunker_radio("dcburn_rm2_stalkercopies");

  bunker_radio("dcburn_rm2_standby");

  bunker_radio("dcburn_rp1_stndingby");

  bunker_radio("dcburn_rm2_talktotarg");

  bunker_radio("dcburn_rp1_goahead");

  bunker_radio("dcburn_rm2_ovaltrack");

  bunker_radio("dcburn_rp1_contact");

  bunker_radio("dcburn_rm2_ewaxis");

  bunker_radio("dcburn_rp1_contact");

  bunker_radio("dcburn_rm2_logancircpark");

  bunker_radio("dcburn_rp1_contact");

  bunker_radio("dcburn_rm2_yourtarget");

  bunker_radio("dcburn_rp1_rollingin");

  bunker_radio("dcburn_rm2_bringrain");

  bunker_radio("dcburn_rp1_offsafe");

  bunker_radio("dcburn_rp1_guns");

  bunker_radio("dcburn_rp2_offsafe");

  bunker_radio("dcburn_rp1_ejecting");

  bunker_radio("dcburn_rp2_cantseeit");

  bunker_radio("dcburn_rm2_onechute");

  bunker_radio("dcburn_fac_southkstreet");
}

dialogue_bunker() {
  level endon("bunker_door_closed");
  flag_wait("player_bunker_walk_01");

  bunker_radio_org_room2 = getent("bunker_radio_org_room2", "targetname");
  bunker_radio_org_room1 = getstruct("bunker_radio_org_room1", "targetname");
  bunker_radio_org_room2 endon("death");
  bunker_radio_org_room1 endon("death");

  bunker_radio_org_room2play_sound_in_space("dcburn_gm5_gotwounded");
  wait(1);

  bunker_radio_org_room1 play_sound_in_space("dcburn_gm3_allyoursdoc");

  flag_wait("player_bunker_walk_01a");

  bunker_radio_org_room2 play_sound_in_space("dcburn_gm1_keepstill");

  bunker_radio_org_room2 play_sound_in_space("dcburn_gm1_wherescanteen");

  wait(1);

  bunker_radio_org_room2 play_sound_in_space("dcburn_gm2_righthere");

  wait(2);

  bunker_radio_org_room1 play_sound_in_space("dcburn_gm6_stablefornow");

  bunker_radio_org_room1 play_sound_in_space("dcburn_gm4_2stretchers");
}

bunker_radio(sLine) {
  if(!isDefined(level.bunker_radio_org)) {
    return;
  }
  if(isDefined(level.bunker_radio_org.deleteme)) {
    level.bunker_radio_org delete();
  }

  level.bunker_radio_org playSound(sLine, "done");
  level.bunker_radio_org waittill("done");
}

dialogue_nag_cross_the_street() {
  level endon("player_entered_commerce_right");
  level endon("player_entered_commerce_left");

  flag_wait("trenches_dialogue_done");

  while(true) {
    if(!flag("player_crossing_street")) {
      level.teamleader dialogue_execute("dcburn_mcy_humveesupp");
    }

    if(!flag("player_crossing_street")) {
      level.teamleader dialogue_execute("dcburn_mcy_ready");

      level.teamleader dialogue_execute("dcburn_mcy_gomoveup");
    }

    flag_set("leader_orders_everyone_across_street");

    wait(randomintrange(7, 11));
    if(flag("player_entering_commerce")) {
      break;
    }

    radio_dialogue("dcburn_mcy_lineoffire");

    wait(randomintrange(7, 11));
    if(flag("player_entering_commerce")) {
      break;
    }

    radio_dialogue("dcburn_mcy_movemove");

    wait(randomintrange(7, 11));
    if(flag("player_entering_commerce")) {
      break;
    }

    radio_dialogue("dcburn_mcy_50calsupp");

    wait(randomintrange(7, 11));
    if(flag("player_entering_commerce")) {
      break;
    }

    radio_dialogue("dcburn_mcy_sittingducks");

    wait(randomintrange(7, 11));
    if(flag("player_entering_commerce")) {
      break;
    }

    radio_dialogue("dcburn_mcy_blownoff");

    wait(randomintrange(7, 11));
    if(flag("player_entering_commerce")) {
      break;
    }

    radio_dialogue("dcburn_mcy_moveup");

    wait(randomintrange(7, 11));
    if(flag("player_entering_commerce")) {
      break;
    }

    radio_dialogue("dcburn_mcy_intotargbuilding");
  }
}

dialogue_nag_get_to_elevator() {
  grenadeHintGiven = false;

  level.teamleader dialogue_execute("dcburn_mcy_lobby_move_nag_00");
  flag_set("obj_commerce_given");

  level endon("player_approaching_bottom_elevators");

  while(!flag("player_approaching_bottom_elevators")) {
    wait(randomintrange(5, 8));

    if(flag("player_approaching_bottom_elevators")) {
      break;
    }

    if(grenadeHintGiven == false) {
      level.teamleader dialogue_execute("dcburn_mcy_grenadelaunch");
      grenadeHintGiven = true;
      wait(randomintrange(7, 11));
    }

    if(flag("player_approaching_bottom_elevators")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_lobby_move_nag_01");

    wait(randomintrange(7, 11));
    if(flag("player_approaching_bottom_elevators")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_lobby_move_nag_02");

    wait(randomintrange(7, 11));
    if(flag("player_approaching_bottom_elevators")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_lobby_move_nag_03");

    wait(randomintrange(7, 11));
    if(flag("player_approaching_bottom_elevators")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_lobby_move_nag_04");
    wait(randomintrange(7, 11));
  }
}

commerce_first_floor_enemies_dead_monitor() {
  volume_commerce_lobby_lower = getent("volume_commerce_lobby_lower", "targetname");
  enemies = volume_commerce_lobby_lower get_ai_touching_volume("axis");

  while(enemies.size > 0) {
    wait(.5);
    enemies = volume_commerce_lobby_lower get_ai_touching_volume("axis");
  }
  flag_set("commerce_first_floor_enemies_dead");
}

dialogue_trenches() {
  bunker_radio_org_room2 = getent("bunker_radio_org_room2", "targetname");

  flag_wait("player_bunker_walk_02");

  bunker_radio_org_room2 thread play_sound_on_entity("dcburn_hqr_ensureweapons");

  flag_wait("player_bunker_walk_03");

  level.friendly03 thread dialogue_execute("dcburn_gr1_onyourfeet");

  flag_wait("player_approaching_bunker_exit_hall");

  level.teamleader dialogue_execute("dcburn_mcy_rogerout");

  level.teamleader dialogue_execute("dcburn_mcy_evachithard");

  flag_set("obj_follow_sgt_macey_given");

  level.friendly03 thread play_sound_on_entity("dcburn_hoh_1");

  flag_wait("player_leaving_bunker");

  battlechatter_on("allies");
  battlechatter_on("axis");

  array_thread(level.chattertrigsexteriror, ::trigger_on);

  radio_dialogue("dcburn_hqr_uncoverengage");

  flag_wait("javelin_is_owning_fools");

  thread radio_dialogue("dcburn_cpd_opticsonus");

  flavorbursts_on("allies");
  level.bunker_radio_org.deleteme = true;

  wait(4);
  thread dialogue_random_incoming_javelins();

  wait(.75);

  level.teamleader dialogue_execute("dcburn_mcy_reqairstrike");

  radio_dialogue("dcburn_hqr_alongpotomac");

  thread autosave_by_name("trench_start");

  level.teamleader dialogue_execute("dcburn_mcy_buytime");

  flag_wait("player_trench_capitol_failsafe");

  level.teamleader dialogue_execute("dcburn_mcy_haulingpastus");

  wait(3);
  flag_set("bradley_can_start_firing");

  flag_wait("commerce_rappelers_inserting");
  wait(1);

  if(!flag("player_commerce_trench_03")) {
    radio_dialogue("dcburn_hqr_linkup");
  }

  if(!flag("player_commerce_trench_03")) {
    level.teamleader dialogue_execute("dcburn_mcy_firelow");
  }

  flag_set("trenches_dialogue_done");
}

javelins_trench() {
  flag_wait("player_approaching_bunker_exit");
  thread autosave_by_name("javelins_trench");

  m1a1_trench = spawn_vehicle_from_targetname("m1a1_trench");

  flag_wait("player_leaving_bunker");

  spawn_vehicles_from_targetname_and_drive("apache_01");

  javelin_source_org = getent("javelin_source_org", "targetname");
  monument_heli_owned = spawn_vehicle_from_targetname("monument_heli_owned");

  m1a1_owned = spawn_vehicle_from_targetname("m1a1_owned");
  m1a1_owned2 = spawn_vehicle_from_targetname("m1a1_owned2");
  m1a1_owned2 maps\_vehicle::godon();
  javelin_vehicle_targets = getEntArray("javelin_vehicle_targets", "targetname");
  array_thread(javelin_vehicle_targets, ::vehicles_cheap_waittill_destroyed_think);

  flag_wait("player_exiting_start_trench");

  spawn_vehicles_from_targetname_and_drive("jets_monument_01");

  wait(2);
  thread gopath(m1a1_owned);

  flag_wait_either("looking_commerce_enemy_javelin", "commerce_enemy_javeling_failsafe");

  spawner = getent("commerce_friendly_fodder", "targetname");
  spawner spawn_ai(true);

  newMissile = MagicBullet("javelin_noimpact", javelin_source_org.origin, monument_heli_owned.origin);
  playFX(getfx("javelin_muzzle"), javelin_source_org.origin);
  newMissile thread javelin_earthquake();
  newMissile Missile_SetTargetPos(monument_heli_owned.origin);
  newMissile Missile_SetFlightmodeTop();

  seaknight_monument_takeoff_01 = get_vehicle("seaknight_monument_takeoff_01", "script_noteworthy");
  heli_monument_path_01 = getstruct("heli_monument_path_01", "targetname");
  seaknight_monument_takeoff_01 thread vehicle_paths(heli_monument_path_01);

  thread flag_set_delayed("javelin_is_owning_fools", 1);
  wait(2.5);
  thread gopath(m1a1_owned2);
  m1a1_owned2 maps\_vehicle::godoff();

  m1a1_owned setturrettargetent(javelin_source_org);
  m1a1_owned thread vehicle_tank_fire_turret(javelin_source_org);
  m1a1_owned thread m1a1_owned_think();

  while(true) {
    monument_heli_owned waittill("damage", amount, attacker);
    if((isDefined(attacker)) && (!isPlayer(attacker))) {
      break;
    }
  }

  thread maps\dcburning_fx::monument_heli_destroyed(monument_heli_owned);

  wait(10);
  m1a1_owned2 setturrettargetent(javelin_source_org);
  m1a1_owned2 thread vehicle_tank_fire_turret(javelin_source_org);
  m1a1_owned2 delaythread(0, ::vehicle_owned_by_javelin, javelin_source_org);

  wait(8);
  m1a1_trench delaythread(0, ::vehicle_owned_by_javelin, javelin_source_org);

  flag_set("second_abrams_killed");
  wait(8);

  javelin_targets_trench = getStructArray("javelin_targets_trench", "targetname");
  javelin_vehicle_target_array = javelin_vehicle_targets;
  eTargetVehicle = undefined;
  eTargetTrenchOrg = undefined;
  toggle = 1;
  dummy = spawn("script_origin", (0, 0, 0));
  while(!flag("player_entering_top_elevator_area")) {
    wait(randomfloatrange(5, 8));

    iRand = randomint(javelin_targets_trench.size);
    eTargetTrenchOrg = javelin_targets_trench[iRand];
    dummy.origin = eTargetTrenchOrg.origin;
    newMissile = MagicBullet("javelin_dcburn", javelin_source_org.origin, dummy.origin);
    playFX(getfx("javelin_muzzle"), javelin_source_org.origin);
    newMissile thread javelin_earthquake();
    newMissile Missile_SetTargetEnt(dummy);
    newMissile Missile_SetFlightmodeTop();
    toggle = 1;

    wait(randomfloatrange(5, 10));
  }

  dummy delete();
}

m1a1_owned_think() {
  wait(2);
  eTarget = getent("javelin_source_org", "targetname");
  self setTurretTargetEnt(eTarget, (0, 0, -60));
  self waittill_notify_or_timeout("turret_rotate_stopped", 1.0);
  self notify("turret_fire");

  flag_wait_either("player_trench_capitol_failsafe", "blow_up_abrams");
  self thread radius_damage_m1a1_owned();
  self delaythread(0, ::vehicle_owned_by_javelin, eTarget);
}

radius_damage_m1a1_owned() {
  self waittill("death");
  if(distance(self.origin, level.player.origin) < 1024) {
    level.player DoDamage(50 / level.player.damageMultiplier, level.player.origin);
  }
}

apache_think() {}

vehicle_tank_fire_turret(eTarget) {
  self endon("death");
  tank_50cal = self.mgturret[0];
  while(isDefined(self)) {
    tank_50cal settargetentity(eTarget);
    iBurstNumber = randomfloatrange(1.5, 3);
    tank_50cal startfiring();
    wait(iBurstNumber);
    tank_50cal stopfiring();
    wait(randomfloatrange(3, 6));
  }
}

vehicle_heli_fire_turret(eTarget) {
  self endon("death");
  self notify("stop_firing_turret");
  self endon("stop_firing_turret");
  fireTime = .1;
  while(isDefined(self)) {
    burstsize = randomintrange(10, 20);
    if(!self.firingMissiles) {
      for(i = 0; i < burstsize; i++) {
        self setturrettargetent(eTarget, randomvector(50) + (0, 0, 32));
        self fireweapon();
        wait fireTime;
      }
    } else
      wait(.5);

    wait(randomfloatrange(2, 3));
  }
}

helis_monument() {
  flag_wait("player_leaving_bunker");
  helis_monument = spawn_vehicles_from_targetname("helisquad_monument");

  flag_wait("player_approaching_monument");
  array_call(helis_monument, ::Vehicle_SetSpeed, 100);
  array_thread(helis_monument, ::gopath);
}

helis_monument_ground() {
  flag_wait("player_leaving_bunker");
  helis_monument = spawn_vehicles_from_targetname("helisquad_monument_ground");

  array_thread(helis_monument, maps\_vehicle::godon);
}

helis_monument_cargo() {
  flag_wait("player_leaving_bunker");
  helis_monument_cargo = spawn_vehicles_from_targetname("helis_monument_cargo");
  helis_monument_cargo_noliftoff = spawn_vehicles_from_targetname("helis_monument_cargo_noliftoff");

  flag_wait("player_approaching_monument");
  array_thread(helis_monument_cargo, ::heli_cargo_liftoff_and_go);
  array_thread(helis_monument_cargo_noliftoff, ::gopath);
}

capitol_trench() {
  flag_wait_either("player_trench_looking_capitol", "player_trench_capitol_failsafe");
  jets = spawn_vehicles_from_targetname_and_drive("jets_capitol_01");
}

humvee_commerce_left() {
  flag_wait("player_approaching_bunker_exit");

  humvee_spotlight_left = spawn_vehicle_from_targetname("humvee_spotlight_left");

  humvee_spotlight_left humvee_spotlight_setup();

  flag_wait("javelin_is_owning_fools");

  aTargets = getEntArray("target_crowsnest", "targetname");
  humvee_spotlight_left.turret settargetentity(aTargets[randomint(aTargets.size)]);
  wait(1.5);
  playFXOnTag(getfx("_attack_heli_spotlight"), humvee_spotlight_left.turret, "tag_flash");
  while(!flag("second_abrams_killed")) {
    humvee_spotlight_left.turret settargetentity(aTargets[randomint(aTargets.size)]);
    wait(randomfloatrange(1.2, 3.4));
  }
  target_for_humvee_left = getent("target_for_humvee_left", "targetname");
  humvee_spotlight_left.turret settargetentity(target_for_humvee_left);
  wait(.5);
  humvee_spotlight_left.spotlight_org delete();
  humvee_spotlight_left.turret delete();

  flag_set("humvee_commerce_left_done_with_spotlight");
  humvee_spotlight_left thread gopath();
  humvee_spotlight_left waittill("reached_end_node");

  humvee_spotlight_left vehicle_delete();
}

humvee_commerce() {
  flag_wait("player_approaching_bunker_exit");
  humvee_spotlight = spawn_vehicle_from_targetname("humvee_spotlight");
  humvee_spotlight maps\_vehicle::godon();
  HummerTurret = humvee_spotlight.mgturret[0];

  humvee_spotlight humvee_spotlight_setup();

  flag_wait("humvee_commerce_left_done_with_spotlight");

  humvee_spotlight.turret thread humvee_spotlight_think(humvee_spotlight, HummerTurret);

  flag_wait("commerce_rappelers_rappeling");

  if(isDefined(level.commercerappelers)) {
    while(level.commercerappelers.size > 0) {
      wait(0.05);
      if(flag("commerce_rappelers_done")) {
        break;
      }
      iRand = randomint(level.commercerappelers.size);
      level.commercerappelers = remove_dead_from_array(level.commercerappelers);
      eTarget = level.commercerappelers[iRand];
      if(isDefined(eTarget)) {
        humvee_spotlight.eTarget = eTarget;
        wait(randomfloatrange(2.2, 4.4));
      }
    }
  }

  flag_wait("player_entering_top_elevator_area");

  flag_wait("player_in_crowsnest_room");

  humvee_spotlight.spotlight_org delete();
  humvee_spotlight.turret delete();
  aRiders = humvee_spotlight.riders;
  array_thread(aRiders, ::AI_delete);
  humvee_spotlight vehicle_delete();
  flag_set("humvee_spotlight_deleted");
}

bradley_commerce() {
  flag_wait("player_approaching_bunker_exit");
  level.bradley_commerce = spawn_vehicle_from_targetname("bradley_commerce");
  level.bradley_commerce maps\_vehicle::godon();
  flag_wait("bradley_can_start_firing");
  iFireTime = weaponfiretime("bradley_turret");
  aDefaultTargets = getEntArray("humvee_spotlight_targets", "targetname");
  targetLoc = undefined;
  level.bradley_commerce.weaponrange = 6000;
  bradleyDefaultTargets = getEntArray("bradley_default_targets", "targetname");
  level.bradley_commerce.fireAtDefaultTargets = true;
  level.bradley_commerce.firing = true;
  while(!flag("player_entering_top_elevator_area")) {
    wait(0.05);

    if(level.bradley_commerce.firing == false) {
      wait(1);
      continue;
    }

    if((isDefined(level.bradleyPreferredTargets)) && (level.bradleyPreferredTargets.size > 0)) {
      level.bradleyPreferredTargets = remove_dead_from_array(level.bradleyPreferredTargets);
      if(level.bradleyPreferredTargets.size == 0) {
        continue;
      }
      iRand = randomInt(level.bradleyPreferredTargets.size);
      eTarget = level.bradleyPreferredTargets[iRand];
      eTarget.health = 1;
    } else if(level.bradley_commerce.fireAtDefaultTargets) {
      iRand = randomInt(bradleyDefaultTargets.size);
      eTarget = bradleyDefaultTargets[iRand];
    } else
      eTarget = level.bradley_commerce vehicle_get_target();
    if(!isDefined(eTarget)) {
      wait(randomfloatrange(2, 4));
      continue;
    }

    level.bradley_commerce setturrettargetent(eTarget);
    level.bradley_commerce waittill_notify_or_timeout("turret_rotate_stopped", 1);
    iBurstNumber = randomfloatrange(2, 6);
    i = 0;
    while(i < iBurstNumber) {
      i++;
      iFireTime = weaponfiretime("bradley_turret");
      wait(iFireTime);
      level.bradley_commerce fireWeapon();
      earthquake(0.25, .13, level.bradley_commerce.origin, 1024);
    }
    wait(randomfloatrange(1.5, 5));
  }

  level.bradley_commerce vehicle_delete();
}

humvee_magically_kill_dude(eTarget) {
  eTarget endon("death");
  if((!isDefined(eTarget)) || (!isalive(eTarget))) {
    return;
  }
  targetTagOrigin = eTarget gettagorigin("tag_eye");
  magicbullet("m14_scoped", self.origin, targetTagOrigin);
  bullettracer(self.origin, targetTagOrigin, true);
  playFXOnTag(getfx("headshot"), eTarget, "tag_eye");
}

vehicle_get_target() {
  eTarget = undefined;
  switch (self.vehicletype) {
    case "zpu_antiair":
      eTarget = self.defaultTargets[randomint(self.defaultTargets.size)];
      break;
    case "bradley":

      eTarget = maps\_helicopter_globals::getEnemyTarget(self.weaponrange, level.cosine["180"], true, false, false, true);
      break;
    case "btr80":

      eTarget = maps\_helicopter_globals::getEnemyTarget(level.CannonRange, level.cosine["180"], true, true, false, true);
      break;
  }
  if(isDefined(eTarget)) {
    return eTarget;
  }
}

commerce_rappelers() {
  flag_wait("player_commerce_trench_01");
  if(getdvarint("r_dcburning_culldist") == 1) {
    flag_set("commerce_rappelers_inserting");
    flag_set("commerce_rappelers_rappeling");
    flag_set("commerce_rappelers_done");
  } else {
    blackhawk_commerce_rappel = spawn_vehicle_from_targetname_and_drive("blackhawk_commerce_rappel");
    level.commercerappelers = blackhawk_commerce_rappel.riders;
    array_thread(level.commercerappelers, ::commerce_rappelers_think);
    flag_set("commerce_rappelers_inserting");

    flag_wait("commerce_rappelers_rappeling");
    wait(6);
    flag_set("commerce_rappelers_done");
  }
}

commerce_rappelers_think() {
  self endon("death");
  self setthreatbiasgroup("oblivious");
  eAnimEnt = getent(self.target, "targetname");
  sRappelAnim = eAnimEnt.animation;
  self.eExploder = undefined;
  if(isDefined(eAnimEnt.target)) {
    aExploderArray = getEntArray(eAnimEnt.target, "targetname");
    foreach(exploderpiece in aExploderArray) {
      if(isDefined(exploderpiece.script_exploder)) {
        self.iExploderNum = exploderpiece.script_exploder;
        self.ExploderOrg = exploderpiece.origin;
        break;
      }
    }
  }
  self waittill("jumpedout");
  eAnimEnt anim_generic_first_frame(self, sRappelAnim);
  if(!flag("commerce_rappelers_rappeling")) {
    flag_set("commerce_rappelers_rappeling");
  }
  eAnimEnt anim_generic(self, sRappelAnim);
  self delete();
}

rappel_window_exploder(guy) {
  assertex(isDefined(guy.iExploderNum), "AI with export " + guy.export+" needs his target to target a window exploder");
  fxOrg = guy.ExploderOrg;
  exploder(guy.iExploderNum);
  thread play_sound_in_space("glass_break", fxOrg);
  playFX(getfx("commerce_window_shatter"), fxOrg);
}

humvee_spotlight_think(humvee, HummerTurret) {
  humvee endon("death");
  self endon("death");

  targets = getEntArray("humvee_spotlight_targets", "targetname");
  self.defaultTarget = targets[0];
  self thread humvee_default_targets_think(targets, self);

  self settargetentity(targets[0]);

  wait(.5);
  HummerTurret setmode("manual");
  HummerTurret StopFiring();
  HummerTurret SetTargetEntity(targets[0]);
  HummerTurret.dontshoot = true;

  if(getdvarint("sm_enable")) {
    playFXOnTag(getfx("_attack_heli_spotlight"), self, "tag_flash");
  }

  self thread spotlight_preferred_targets();

  offset = (0, 0, 32);
  while(isDefined(self)) {
    if(isDefined(self.spotlightPreferredTarget)) {
      self settargetentity(self.spotlightPreferredTarget, offset);
      if(isDefined(HummerTurret)) {
        HummerTurret SetTargetEntity(self.spotlightPreferredTarget, offset);
      }
    } else if(isDefined(humvee.eTarget)) {
      self settargetentity(humvee.eTarget, offset);
      if(isDefined(HummerTurret)) {
        HummerTurret SetTargetEntity(humvee.eTarget, offset);
      }
    } else {
      if(isDefined(self.defaultTarget)) {
        self settargetentity(self.defaultTarget);
        if(isDefined(HummerTurret)) {
          HummerTurret SetTargetEntity(self.defaultTarget);
        }
      }
    }

    wait(0.05);
  }
}

spotlight_preferred_targets() {
  self endon("death");
  self.spotlightPreferredTarget = undefined;
  self thread find_player_attacker_for_spotlight(self);

  flag_wait_either("player_touching_commerce_lobby_right", "player_touching_commerce_lobby_left");

  volume_commerce_lobby_lower = getent("volume_commerce_lobby_lower", "targetname");
  volume_commerce_lobby_upper = getent("volume_commerce_lobby_upper", "targetname");
  enemies1 = volume_commerce_lobby_lower get_ai_touching_volume("axis");
  enemies2 = volume_commerce_lobby_upper get_ai_touching_volume("axis");
  aAI = undefined;
  while((isDefined(self)) && (!flag("player_entering_top_elevator_area"))) {
    aAI = array_merge(enemies1, enemies2);
    aAI = remove_dead_from_array(aAI);
    if((isDefined(level.playerAttacker)) && (is_in_array(aAI, level.playerAttacker))) {
      self.spotlightPreferredTarget = level.playerAttacker;
    } else {
      if(aAI.size > 0) {
        self.spotlightPreferredTarget = getClosest(level.player.origin, aAI);
      }
    }

    if(isDefined(self.spotlightPreferredTarget)) {
      wait(randomfloatrange(3, 5));
    } else {
      wait(.5);
    }
    enemies1 = volume_commerce_lobby_lower get_ai_touching_volume("axis");
  }

  flag_wait("player_entering_top_elevator_area");
  humvee_spotlight_targets_upper = getEntArray("humvee_spotlight_targets_upper", "targetname");
  aAI = undefined;

  while(isDefined(self)) {
    wait(randomfloatrange(2, 4));

    self.spotlightPreferredTarget = humvee_spotlight_targets_upper[randomint(humvee_spotlight_targets_upper.size)];
  }
}

find_player_attacker_for_spotlight(spotlight_turret) {
  self endon("death");
  level.playerAttacker = undefined;
  while(isDefined(self)) {
    level.player waittill("damage", amount, attacker);
    if(!isDefined(attacker)) {
      continue;
    }
    if((isDefined(attacker.team)) && (attacker.team == "axis")) {
      level.playerAttacker = attacker;
      self waittill_death_or_timeout(4);
      if(level.playerAttacker == self) {
        level.playerAttacker = undefined;
      }
    }
  }
}

humvee_default_targets_think(targets, turret) {
  self endon("death");
  while(isDefined(turret)) {
    foreach(target in targets) {
      turret.defaultTarget = target;
      wait(randomfloatrange(3, 6));
    }
  }

  foreach(target in targets) {
    target delete();
  }
}

humvee_convoy() {
  flag_wait("player_approaching_bunker_exit");
  humvee_convoy_00 = getEntArray("humvee_convoy_00", "targetname");

  if(getdvarint("r_dcburning_culldist") == 1) {
    thread drone_vehicle_flood_start(humvee_convoy_00, "humvee_convoy_00", 7, 10, true);
  } else {
    thread drone_vehicle_flood_start(humvee_convoy_00, "humvee_convoy_00", 3.1, 4.8, true);
  }

  flag_wait("player_at_top_of_pavlovs_ramp");

  drone_vehicle_flood_stop("humvee_convoy_00");
}

AA_elevator_bottom_init() {
  thread atrium_guys();
  thread dialogue_elevator_bottom_to_top();
  thread samsite_flyby();
  thread AAA_sequence_elevator_bottom_to_top();
  flag_wait("player_entering_top_elevator_area");
  thread AA_elevator_top_init();
}

samsite_flyby() {
  level endon("player_entering_top_elevator_area");
  flag_wait("player_near_samsite");
  spawn_vehicles_from_targetname_and_drive("jets_samsite");
}

AAA_sequence_elevator_bottom_to_top() {
  flag_wait_either("player_touching_commerce_lobby_right", "player_touching_commerce_lobby_left");

  thread AI_squad_fixed_node_interior();

  aFodder_friendlies = [];
  aSpawners = undefined;
  if(flag("player_touching_commerce_lobby_left")) {
    aSpawners = getEntArray("friendlies_commerce_lobby_left", "targetname");
  } else {
    aSpawners = getEntArray("friendlies_commerce_lobby_right", "targetname");
  }

  foreach(spawner in aSpawners) {
    guy = spawner spawn_ai(true);
    if(isDefined(guy)) {
      aFodder_friendlies = array_add(aFodder_friendlies, guy);
    }
  }
  array_thread(aFodder_friendlies, ::AI_fixednode_off);
  array_thread(aFodder_friendlies, ::try_to_magic_bullet_shield);
  foreach(guy in aFodder_friendlies) {
    if(!isDefined(guy)) {
      continue;
    }
    guy.attackeraccuracy = 0;
  }

  thread elevator_start();

  flag_wait("player_approaching_bottom_elevators");
  thread autosave_by_name("bottom_elevators");
  array_thread(aFodder_friendlies, ::stop_magic_bullet_shield);
  foreach(guy in aFodder_friendlies) {
    if(!isDefined(guy)) {
      continue;
    }
    guy.attackeraccuracy = .1;
  }
  array_thread(aFodder_friendlies, ::AI_redshirt_think);

  flag_wait("player_entering_courtyard");

  if(getdvarint("r_dcburning_culldist") == 1) {
    setculldist(0);
  }

  thread AI_cleanup_volume("volume_commerce_lobby_upper", "axis");
  thread AI_cleanup_volume("volume_commerce_lobby_lower", "axis");

  flag_wait("player_headed_to_atrium_side_hall");
  aAI = getaiarray("axis");
  array_thread(aAI, ::AI_ambush_behavior);

  flag_wait("player_entering_commerce_side_hall");

  flag_set("stop_elevator_doors");

  wait(8);
  thread waittill_targetname_volume_dead_then_set_flag("volume_courtyard_windows", "courtyard_has_been_cleared");

  flag_wait("player_heading_up_to_mezzanine");

  flag_wait("player_entering_mezzanine_top");
  thread waittill_targetname_volume_dead_then_set_flag("volume_commerce_lobby_upper", "mezzanine_top_has_been_cleared");
  spawn_vehicles_from_targetname_and_drive("jets_mezz_01");

  flag_wait("player_approaching_pavlov_hole");
  delaythread(0, ::spawn_vehicles_from_targetname_and_drive, "helis_mezzanine");

  flag_wait("player_at_bottom_of_pavlovs_ramp");
  thread AI_cleanup("axis");

  thread samsite_enemy_chatter();

  battlechatter_off("allies");
  commerce_allied_fodder_4 = array_spawn(getEntArray("commerce_allied_fodder_4", "targetname"), true);
  hostiles_commerce_samsite = array_spawn(getEntArray("hostiles_commerce_samsite", "targetname"), true);
  samsite = samsite_setup("samsite_commerce_01", "player_at_top_of_pavlovs_ramp", "commerce_samsite_revealed");
  commerce_samsite_nodes = getnodearray("commerce_samsite_nodes", "targetname");
  eNode = getclosest(samsite.operator.origin, commerce_samsite_nodes);
  commerce_samsite_nodes = array_remove(commerce_samsite_nodes, eNode);
  samsite.operator thread samsite_ai_think(eNode);
  samsite.puller thread samsite_ai_think(commerce_samsite_nodes[0]);
  samsite.turret thread samsite_turret_think();
  samsite thread samsite_c4_think();

  flag_wait_any("player_entering_fourth_floor", "player_shot_at_samsite_guys", "player_gawking_at_fourth_floor_guys");
  flag_set("player_shot_at_samsite_guys");
  battlechatter_on("allies");

  if(!flag("player_entering_fourth_floor")) {
    thread dummy_trigger("dummy_colornodes_pavlov_end");
    activate_trigger("spawner_hostiles_commerce_floor4", "targetname", level.player);
  }

  array_thread(commerce_allied_fodder_4, ::AI_delete);

  wait(4);
  thread waittill_targetname_volume_dead_then_set_flag("volume_commerce_fourth_floor", "floor_four_has_been_cleared");
  flag_wait_either("floor_four_has_been_cleared", "player_headed_to_fifth_floor");

  flag_wait("player_headed_to_fifth_floor");
  battlechatter_off("allies");

  thread AI_cleanup_non_squad("all");
}

samsite_c4_think() {
  c4_locations = getStructArray("c4_slamraam", "script_noteworthy");
  foreach(c4_location in c4_locations) {
    level.c4_models[level.c4_models.size] = self.base maps\_c4::c4_location(undefined, undefined, undefined, c4_location.origin);
  }

  self.base waittill("c4_detonation");
  self.base notify("death");
  flag_set("slamraam_c4_detonated");

  self.base setModel("vehicle_slamraam_destroyed");

  playFX(getfx("large_vehicle_explosion"), self.base.origin);
  thread play_sound_in_space("exp_slamraam_destroyed", self.base.origin);
  self.turret delete();
  radiusDamage(self.base.origin + (0, 0, 96), 180, 1000, 50);
  fx = spawnFx(getFx("thin_black_smoke_L"), self.base.origin);
  triggerFx(fx);
  earthquake(0.6, 1.2, self.base.origin, 1600);
  if(distance(self.base.origin, level.player.origin) < 2048) {
    level.player PlayRumbleOnEntity("damage_heavy");
  }
  flag_wait("player_entering_top_elevator_area");
  fx delete();
}

atrium_guys() {
  flag_wait("player_approaching_bottom_elevators");
  spawners = getEntArray("atrium_guys", "targetname");
  atrium_guys = [];
  guy = undefined;
  puller = undefined;
  foreach(spawner in spawners) {
    guy = spawner dronespawn();
    guy setcontents(0);
    guy.noragdoll = true;
    guy.nocorpsedelete = true;
    guy.ignoreme = true;
    guy.reference = spawner;
    guy.dontDoNotetracks = true;
    guy.script_looping = 0;
    guy gun_remove();
    guy.deathanim = level.scr_anim["generic"][spawner.animation + "_death"];
    assert(isDefined(guy.deathanim));
    atrium_guys[atrium_guys.size] = guy;
    guy.puller = false;
    if(spawner.animation == "airport_civ_dying_groupB_pull") {
      puller = guy;
    }
    guy.animation = spawner.animation;
    guy.reference anim_generic_first_frame(guy, guy.animation);
  }

  flag_wait("player_entering_courtyard");

  atrium_guys[0].reference thread anim_generic(atrium_guys[0], atrium_guys[0].animation);
  atrium_guys[1].reference thread anim_generic(atrium_guys[1], atrium_guys[1].animation);
  wait(0.05);

  atrium_guys[0] setAnimTime(level.scr_anim["generic"][atrium_guys[0].animation], .5);
  atrium_guys[1] setAnimTime(level.scr_anim["generic"][atrium_guys[1].animation], .5);

  array_thread(atrium_guys, ::atrium_guys_end_of_anim);

  flag_wait_either("atrium_guys_at_end_of_anim", "player_entering_courtyard2");

  atrium_bullet = getent("atrium_bullet", "targetname");
  headOrigin = puller gettagorigin("tag_eye");
  vec = vectornormalize(headOrigin - atrium_bullet.origin);
  thread play_sound_in_space("weap_deserteagle_fire_npc", atrium_bullet.origin);
  playFX(getfx("headshot"), headOrigin, vec);
  magicbullet("m14_scoped", atrium_bullet.origin, headOrigin);
  bullettracer(atrium_bullet.origin, headOrigin, true);
  foreach(guy in atrium_guys) {
    guy kill();
  }
  atrium_drag_blocker = getent("atrium_drag_blocker", "targetname");
  atrium_drag_blocker hide_entity();
}

atrium_guys_end_of_anim() {
  level endon("player_entering_courtyard2");
  level endon("atrium_guys_at_end_of_anim");
  self waittillmatch("single anim", "end");
  flag_set("atrium_guys_at_end_of_anim");
}

samsite_enemy_chatter() {
  samsite_chater_org = getent("samsite_chater_org", "targetname");
  origin = samsite_chater_org.origin;
  sFlagToKillDialogue = "player_shot_at_samsite_guys";
  level endon(sFlagToKillDialogue);

  while(!flag(sFlagToKillDialogue)) {
    play_sound_then_kill_on_flag("dcburn_ra1_acquiredtwo", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra2_lockon", origin, sFlagToKillDialogue);

    wait(1);

    play_sound_then_kill_on_flag("dcburn_ra3_missilelocked", origin, sFlagToKillDialogue);

    wait(.5);

    play_sound_then_kill_on_flag("dcburn_ra1_2moresouthbound", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra2_firemissile", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra3_firingmissile", origin, sFlagToKillDialogue);

    wait(1.5);

    play_sound_then_kill_on_flag("dcburn_ra1_movingnorth", origin, sFlagToKillDialogue);

    wait(1);

    play_sound_then_kill_on_flag("dcburn_ra2_10degrees", origin, sFlagToKillDialogue);
  }
}

samsite_ai_think(eNode) {
  self endon("death");
  self.ignorerandombulletdamage = true;
  self thread AI_hostiles_commerce_samsite_think();

  self waittill_either("damage", "alerted");

  self anim_stopanimscripted();
  self.ignorerandombulletdamage = false;
  self.ignoreme = false;
  self.ignoreme = false;
  self notify("alerted");
  self setgoalnode(eNode);
}

samsite_turret_think() {
  self endon("death");
  flag_wait("commerce_samsite_revealed");
  time = 4.5;
  self rotateto(self.angles + (0, -50, 0), time, 2, 2);
  wait(time / 2);

  targetOrg = getent("slamraam_missile_target", "targetname");
  while(!flag("player_approaching_fourth_floor_sam")) {
    self detach("projectile_slamraam_missile", self.missileTags[0]);
    earthquake(.3, .5, self.origin, 1600);
    magicBullet("slamraam_missile_dcburning", self gettagorigin(self.missileTags[0]), targetOrg.origin);
    self.missileTags = array_remove(self.missileTags, self.missileTags[0]);
    if(self.missileTags.size < 1) {
      break;
    }
    wait(randomfloatrange(.3, 2));
  }
}

samsite_setup(targetname, sFlagToStart, sFlagToSetWhenDone) {
  aSamsiteComponents = getEntArray(targetname, "targetname");
  eSamsiteBase = undefined;
  eSamsiteTarp = undefined;
  eSamsiteTurret = undefined;
  aSpawners = [];
  foreach(thing in aSamsiteComponents) {
    if(isspawner(thing)) {
      aSpawners[aSpawners.size] = thing;
      continue;
    }
    if(thing.code_classname == "script_model") {
      switch (thing.model) {
        case "slamraam_tarp":
          eSamsiteTarp = thing;
          break;
        case "vehicle_slamraam_launcher_no_spike":
          eSamsiteTurret = thing;
          break;
        case "vehicle_slamraam_base":
          eSamsiteBase = thing;
          break;
      }
    }
  }

  aAI_samsite = array_spawn(aSpawners, true);
  foreach(guy in aAI_samsite) {
    guy.ignoreme = true;
    guy.ignoreall = true;
  }

  assertex(aAI_samsite.size == 2, "Need exactly 2 AI for the sam site");
  assert(isDefined(eSamsiteTarp));
  assert(isDefined(eSamsiteTurret));
  assert(isDefined(eSamsiteBase));

  eSamsiteTarp.animname = "tarp";
  eSamsiteTarp assign_animtree();
  aAI_samsite[0].animname = "operator";
  aAI_samsite[1].animname = "puller";
  aSamSiteActors = aAI_samsite;
  aSamSiteActors = array_add(aSamSiteActors, eSamsiteTarp);

  eSamsiteTurret.missileTags = [];
  eSamsiteTurret.missileTags[0] = "tag_missle1";
  eSamsiteTurret.missileTags[1] = "tag_missle2";
  eSamsiteTurret.missileTags[2] = "tag_missle3";
  eSamsiteTurret.missileTags[3] = "tag_missle4";
  eSamsiteTurret.missileTags[4] = "tag_missle5";
  eSamsiteTurret.missileTags[5] = "tag_missle6";
  eSamsiteTurret.missileTags[6] = "tag_missle7";
  eSamsiteTurret.missileTags[7] = "tag_missle8";

  foreach(tag in eSamsiteTurret.missileTags) {
    eSamsiteTurret Attach("projectile_slamraam_missile", tag, true);
  }

  samsite = spawnStruct();
  samsite.operator = aAI_samsite[0];
  samsite.puller = aAI_samsite[1];
  samsite.turret = eSamsiteTurret;
  samsite.base = eSamsiteBase;

  eSamsiteBase thread samsite_tarp_think(aSamSiteActors, sFlagToStart, sFlagToSetWhenDone);

  return samsite;
}

samsite_tarp_think(aSamSiteActors, sFlagToStart, sFlagToSetWhenDone) {
  self anim_first_frame(aSamSiteActors, "pulldown");
  flag_wait(sFlagToStart);
  self anim_single(aSamSiteActors, "pulldown");
  flag_set(sFlagToSetWhenDone);
}

AI_hostiles_commerce_samsite_think() {
  self endon("death");
  self.ignoreme = true;
  self.ignoreall = true;
  self.old_goalradius = self.goalradius;
  self.goalradius = 16;
  self thread AI_sneak_monitor("player_shot_at_samsite_guys");
  self thread AI_samsite_player_too_close();

  self waittill("alerted");

  self.goalradius = self.old_goalradius;
  self.combatMode = "ambush";
  self.ignoreall = false;
  self.ignoreme = false;
}

AI_samsite_player_too_close() {
  self endon("death");
  self endon("alerted");
  flag_wait_any("player_entering_fourth_floor", "player_shot_at_samsite_guys", "player_gawking_at_fourth_floor_guys");
  flag_set("player_shot_at_samsite_guys");
  self thread AI_become_alerted();
}

elevator_dude_think(spawner) {
  sLoop = "dcburning_elevator_corpse_idle_A";
  sNudge = "dcburning_elevator_corpse_bump_A";
  self.allowdeath = false;
  self.dontDoNotetracks = true;
  self.script_looping = 0;
  self gun_remove();
  self setcontents(0);
  self.ignoreme = true;
  self setlookattext("", &"");
  reference = spawner;
  iAnimSwitched = 0;
  elevator_clip = getent("elevator_clip", "targetname");
  elevator_clip.origin = elevator_clip.origin + (0, 0, 32);
  self stopanimscripted();
  while(!flag("stop_elevator_doors")) {
    reference thread anim_generic_loop(self, sLoop, "stop_idle");
    self waittill("doors_closing");
    reference notify("stop_idle");
    if((flag("player_looking_at_elevator")) && (isDefined(iAnimSwitched))) {
      iAnimSwitched = undefined;
      reference anim_generic(self, "dcburning_elevator_corpse_trans_A_2_B");

      sLoop = "dcburning_elevator_corpse_idle_B";
      sNudge = "dcburning_elevator_corpse_bump_B";
    }
    reference anim_generic(self, sNudge);
  }
  self delete();
}

elevator_start() {
  spawner = getent("elevator_dude", "targetname");
  elevator_dude = spawner dronespawn();
  elevator_dude thread elevator_dude_think(spawner);
  elevator_door_left = getent("elevator_door_left", "targetname");
  elevator_door_right = getent("elevator_door_right", "targetname");
  elevator_door_left.startPos = elevator_door_left.origin;
  elevator_door_right.startPos = elevator_door_right.origin;

  movedistLeft = 28;
  movedistRight = -28;
  movetime = 2;

  musak_org = getent("musak_org", "targetname");
  musak_org playLoopSound("elev_musak_loop");

  while(!flag("stop_elevator_doors")) {
    thread play_sound_in_space("elev_bell_ding", elevator_door_left.origin);
    thread play_sound_in_space("elev_door_close", elevator_door_left.origin);
    elevator_door_left movey(movedistLeft, movetime, movetime / 2);
    elevator_door_right movey(movedistRight, movetime, movetime / 2);

    wait(movetime - .25);
    elevator_dude notify("doors_closing");
    wait(.25);

    thread play_sound_in_space("elev_door_open", elevator_door_left.origin);
    elevator_door_left moveto(elevator_door_left.startPos, movetime, movetime / 2, movetime / 2);
    elevator_door_right moveto(elevator_door_right.startPos, movetime, movetime / 2, movetime / 2);

    wait(movetime);

    wait(1.25);
  }
  musak_org stoploopsound();
  musak_org delete();
}

dialogue_elevator_bottom_to_top() {
  flag_wait("player_approaching_bottom_elevators");

  radio_dialogue("dcburn_mcy_upperfloors");

  radio_dialogue("dcburn_hqr_copiesall");

  flag_wait_either("courtyard_has_been_cleared", "player_heading_up_to_mezzanine");

  if(flag("courtyard_has_been_cleared")) {
    radio_dialogue("dcburn_mcy_alldeadcourtyard");

    radio_dialogue("dcburn_hqr_solidcopy");
  }

  thread autosave_by_name("courtyard_has_been_cleared");

  flag_wait("player_heading_up_to_mezzanine");

  radio_dialogue("dcburn_mcy_tomezzanine");

  radio_dialogue("dcburn_hqr_goodhunt");
  flag_set("ask_bradley_to_stop_firing");

  flag_wait("player_entering_mezzanine_top");

  flag_wait_either("mezzanine_top_has_been_cleared", "player_at_bottom_of_pavlovs_ramp");
  if(flag("mezzanine_top_has_been_cleared")) {
    radio_dialogue("dcburn_mcy_alldeadmezzanine");

    radio_dialogue("dcburn_hqr_rogerthat");
  }
  flavorbursts_off("allies");

  level.player thread play_sound_on_entity("dcburn_ar1_lincolnmemorial");

  flavorbursts_on("allies");

  flag_wait("player_at_bottom_of_pavlovs_ramp");

  level.friendly02 dialogue_execute("dcburn_cpd_capitolbuild");

  radio_dialogue("dcburn_hqr_crownag");

  radio_dialogue("dcburn_mcy_omwtofifth");

  flag_wait("player_at_top_of_pavlovs_ramp");

  if(!flag("player_shot_at_samsite_guys")) {
    thread autosave_by_name("crow_sneak");

    radio_dialogue("dcburn_mcy_sby2engage");
  }

  flag_wait_either("floor_four_has_been_cleared", "player_headed_to_fifth_floor");
  if(flag("floor_four_has_been_cleared")) {
    radio_dialogue("dcburn_mcy_alldeadfourth");

    radio_dialogue("dcburn_hqr_copythat");
  }

  flavorbursts_off("allies");

  level.player play_sound_on_entity("dcburn_ar2_pullingout");

  level.player play_sound_on_entity("dcburn_ar3_pullback");

  flavorbursts_on("allies");
}

AA_global() {
  thread commerce_top_drone_flood();
}

commerce_top_drone_flood() {
  flag_wait("obj_commerce_defend_snipe_complete");

  bmp_flood_south = getEntArray("bmp_flood_south", "targetname");
  thread crows_nest_bmp_flood(bmp_flood_south);

  flag_wait("obj_commerce_defend_javelin_complete");
}

crows_nest_bmp_flood(aSpawners) {
  level endon("obj_commerce_defend_javelin_complete");
  while(true) {
    foreach(spawner in aSpawners) {
      thread crows_nest_bmp_flood_think(spawner);
    }
    wait(randomfloatrange(40, 41));
  }
}

crows_nest_bmp_flood_think(spawner) {
  if(!flag("obj_commerce_defend_javelin_complete")) {
    return;
  }
  level endon("obj_commerce_defend_javelin_complete");
  wait(randomfloatrange(40, 41));
  bmp = spawner spawn_vehicle_and_gopath();
  target_set(bmp, (0, 0, 0));
  target_setJavelinOnly(bmp, true);
  Target_SetAttackMode(bmp, "top");
  bmp thread obj_commerce_defend_javelin_enemies_think();
  bmp endon("death");

  bmp waittill("reached_end_node");
  bmp notify("deleted_through_script");
  bmp delete();
}

AA_elevator_top_init() {
  thread music_to_crowsnest();
  thread dialogue_to_crowsnest();
  thread AAA_sequence_elevator_top_2_crowsnest();
  flag_wait("player_approaching_crowsnest");
  thread AA_crows_nest_snipe_init();
}

music_to_crowsnest() {
  flag_wait("start_music_to_crowsnest");
  thread music_loop("dcburning_evilcrowsnest_approach", 198);
}

AAA_sequence_elevator_top_2_crowsnest() {
  flag_wait("player_at_commerce_crows_floor");
  triggersEnable("colornodes_commerce_to_crowsnest", "script_noteworthy", true);

  flag_wait("player_entering_top_elevator_area");
  thread autosave_by_name("elevator_top");
  thread AI_cleanup_non_squad("all");
  if(isDefined(level.helis_ambient_trenches)) {
    array_thread(level.helis_ambient_trenches, ::vehicle_delete);
  }
  if(isDefined(level.vehicles_commerce_ambient)) {
    array_thread(level.vehicles_commerce_ambient, ::vehicle_delete);
  }

  volume_commerce_sector_2 = getent("volume_commerce_sector_2", "targetname");
  volume_commerce_sector_3 = getent("volume_commerce_sector_3", "targetname");
  flare_dynamic_01 = getent("flare_dynamic_01", "targetname");
  dynamicLight = getent(flare_dynamic_01.target, "targetname");
  dynamicLight setLightIntensity(0);

  flag_wait_either("player_approaching_flare_moment", "player_looking_at_flare_moment");

  flare_dynamic_01 thread flare_burst_on_and_flicker(4, 4, 10);
  commerce_flare_guys = array_spawn(getEntArray("commerce_flare_guys", "targetname"), true);

  flag_wait("player_approaching_crowsnest");

  thread crows_nest_enemy_chatter();
  helis_ambient_crowsnest = spawn_vehicles_from_targetname_and_drive("helis_ambient_crowsnest");
  helis_crows_snipe = spawn_vehicles_from_targetname_and_drive("helis_crows_snipe");
  array_thread(helis_crows_snipe, ::helis_crows_snipe_think);
  if(isDefined(level.helis_ambient_capitol)) {
    array_thread(level.helis_ambient_capitol, ::helis_ambient_capitol_think);
  }
  thread AI_cleanup_non_squad("allies", 128);
}

helis_crows_snipe_think() {
  self endon("death");

  flag_wait("obj_commerce_defend_crow_given");
  self thread vehicle_delete_when_hit_script_noteworthy("start");

  flag_wait("obj_commerce_defend_javelin_given");
  self thread helis_crowsnest_think();
}

helis_ambient_capitol_think() {
  self endon("death");

  flag_wait("player_shot_at_crowsnest_guys");
  self thread vehicle_delete_when_hit_script_noteworthy("start");
}

crows_nest_enemy_chatter() {
  obj_commerce_sector_3 = getstruct("obj_commerce_sector_3", "targetname");
  origin = obj_commerce_sector_3.origin;
  sFlagToKillDialogue = "player_shot_at_crowsnest_guys";
  level endon(sFlagToKillDialogue);

  while(!flag(sFlagToKillDialogue)) {
    play_sound_then_kill_on_flag("dcburn_ra3_gridsquare", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra1_dontworry", origin, sFlagToKillDialogue);

    wait(.5);

    play_sound_then_kill_on_flag("dcburn_ra2_60kph", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra3_standbyforlaunch", origin, sFlagToKillDialogue);

    wait(.5);

    play_sound_then_kill_on_flag("dcburn_ra1_bygreencar", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra2_trackingitnow", origin, sFlagToKillDialogue);

    wait(.75);

    play_sound_then_kill_on_flag("dcburn_ra3_tooeasy", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra1_confirmhostile", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra2_25kph", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra3_range572meters", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra1_destroyit", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra2_clearedtoengage", origin, sFlagToKillDialogue);

    play_sound_then_kill_on_flag("dcburn_ra3_runfromus", origin, sFlagToKillDialogue);
  }
}

AI_commerce_sector_2_guys_think() {
  self endon("death");
  flag_wait("fifth_floor_guys_damaged");
  self.combatMode = "ambush";
}

dialogue_to_crowsnest() {
  flag_wait("player_entering_top_elevator_area");

  flag_set("start_music_to_crowsnest");

  radio_dialogue("dcburn_mcy_onfifth");

  if((flag("player_approaching_flare_moment")) || (flag("player_approaching_flare_moment"))) {} else {
    radio_dialogue("dcburn_hqr_copy21");
  }

  flag_wait_either("player_approaching_flare_moment", "player_looking_at_flare_moment");

  wait(.2);

  radio_dialogue("dcburn_cdn_movement");

  wait(1);

  if(!flag("fifth_floor_guys_damaged")) {
    radio_dialogue("dcburn_mcy_watchsectors");
  }
  wait(3);
  if(!flag("fifth_floor_guys_damaged")) {
    radio_dialogue("dcburn_mcy_checkcorners");
  }
  flag_wait("player_approaching_crowsnest2");

  radio_dialogue("dcburn_mcy_visoncrow");

  flavorbursts_off("allies");

  level.player play_sound_on_entity("dcburn_ar4_centcom");
  flavorbursts_on("allies");

  flag_set("macey_tells_you_to_move_to_crows");
  wait(.5);

  if(!flag("player_shot_at_crowsnest_guys")) {
    thread autosave_by_name("crow_sneak");

    radio_dialogue("dcburn_mcy_sby2engage");
  }

  flavorbursts_off("allies");

  level.player play_sound_on_entity("dcburn_ar1_fivemikes");

  level.player play_sound_on_entity("dcburn_ar2_outtathere");
  flavorbursts_on("allies");
}

AA_crows_nest_snipe_init() {
  thread AAA_sequence_crowsnest();
  thread AAA_sequence_crowsnest_snipe();
  thread obj_commerce_defend_snipe();
  thread obj_commerce_defend_crow();
  thread dialogue_crowsnest();
  flag_wait("start_crow_armor_sequence");
  thread AA_crows_nest_armor_init();
}

AAA_sequence_crowsnest() {
  triggersEnable("colornodes_crowsnest", "script_noteworthy", true);
  volume_crowsnest = getent("volume_crowsnest", "targetname");

  flag_wait("player_approaching_crowsnest");

  hostiles_crowsnest = array_spawn(getEntArray("hostiles_crowsnest", "targetname"), true);
  thread waittill_dead_then_set_flag(hostiles_crowsnest, "crowsnest_has_been_cleared");
  array_thread(hostiles_crowsnest, ::AI_sneak_monitor, "player_shot_at_crowsnest_guys");
  array_thread(hostiles_crowsnest, ::AI_crowsnest_player_too_close);

  array_thread(level.squad, ::crowsnest_friendlies_inside);

  flag_wait("player_shot_at_crowsnest_guys");

  tanks_crowsnest_wave1 = spawn_vehicles_from_targetname("tanks_crowsnest_wave1");
  thread tanks_crowsnest_wave1_gopath(tanks_crowsnest_wave1);
  array_thread(tanks_crowsnest_wave1, ::tanks_crowsnest_wave1_think);

  array_thread(level.squad, ::AI_awesome_accuracy_untill_flag, "crowsnest_has_been_cleared");

  flag_wait("crowsnest_has_been_cleared");

  thread flag_set_delayed("obj_commerce_complete", 1);

  colornodes_crowsnest = getent("colornodes_crowsnest", "script_noteworthy");
  colornodes_crowsnest notify("trigger", level.player);
  thread dummy_trigger("dummy_colornodes_crows1");
  thread dummy_trigger("dummy_colornodes_crows2");

  flag_wait("humvee_spotlight_deleted");

  flag_wait("obj_commerce_defend_snipe_given");
  jets_crow_01 = spawn_vehicles_from_targetname_and_drive("jets_crow_01");
}

crowsnest_friendlies_inside() {
  self endon("death");
  level endon("player_shot_at_crowsnest_guys");
  flag_wait("player_approaching_crowsnest_door");
  player_in_crowsnest_room = getent("player_in_crowsnest_room", "targetname");
  while(!flag("player_shot_at_crowsnest_guys")) {
    wait(.1);
    if(!isDefined(self)) {
      return;
    }
    if(self istouching(player_in_crowsnest_room)) {
      break;
    }
  }

  thread axis_not_ignored();
  flag_set("player_shot_at_crowsnest_guys");
}

axis_not_ignored() {
  ai = getaiarray("axis");
  foreach(guy in ai) {
    if(!isDefined(guy)) {
      continue;
    }
    guy.ignoreme = false;
  }
}

AAA_sequence_crowsnest_snipe() {
  flag_wait("player_approaching_crowsnest2");
  thread crowsnest_ambient_vehicles();

  model_barrett = getent("model_barrett", "targetname");
  model_barrett_glow = spawn("script_model", model_barrett.origin);
  model_barrett_glow setModel("weapon_m82_MG_Setup_obj");
  model_barrett_glow.origin = model_barrett.origin;
  model_barrett_glow.angles = model_barrett.angles;
  model_barrett_glow hide();

  level.evacSiteVehicles = getEntArray("vehicles_crowsnest_defend", "targetname");
  array_thread(level.evacSiteVehicles, ::vehicles_crowsnest_defend_think);
  thread crowsnest_defend_failure();

  level.evacSiteEnemies = array_spawn(getEntArray("hostiles_ww2_barret", "targetname"), true);
  array_thread(level.evacSiteEnemies, ::obj_commerce_defend_snipe_enemies_think);
  array_thread(level.evacSiteEnemies, ::AI_blood_spatter_when_sniped);
  array_thread(level.evacSiteEnemies, ::magic_bullet_shield);

  flag_wait("crowsnest_has_been_cleared");

  array_thread(level.evacSiteEnemies, ::stop_magic_bullet_shield);

  flag_wait("obj_commerce_defend_snipe_given");

  thread friendlies_shoot_at_crows_drones_start();

  thread crowsnest_barret_glow(model_barrett, model_barrett_glow);
  thread crowsnest_nags_snipe();

  flag_wait_or_timeout("player_is_on_turret", 5);

  thread evac_site_enemies_fire_live();

  flag_wait("only_2_sniper_enemies_remaining");

  thread player_fails_if_abandons_crowsnest();

  flag_clear("can_talk");
  radio_dialogue("dcburn_hqr_stayfrosty");
  flag_set("can_talk");

  flag_wait("obj_commerce_defend_snipe_complete");

  thread friendlies_shoot_at_crows_drones_stop();

  thread autosave_now(true);

  thread flag_set_delayed("obj_commerce_defend_crow_given", 3);
  array_thread(level.squad, ::AI_awesome_accuracy_untill_flag, "perimeter_enemies_have_retreated");

  battlechatter_on("allies");
  thread spawn_trigger_dummy("dummy_spawner_crowsnest_assault_guys_wave1");
  thread dialogue_nag_hostiles_at_crows();
  thread player_barrett_damage();
  level.guysKilled = 0;

  triggersEnable("colornodes_crowsnest_surrounded", "script_noteworthy", true);
  trig_colornode = getent("colornodes_crowsnest_surrounded", "script_noteworthy");
  trig_colornode notify("trigger", level.player);

  flag_wait("player_killed_enough");
  flag_set("start_crow_armor_sequence");

  flag_set("obj_commerce_defend_crow_complete");
  thread autosave_by_name("defend_crow_complete");
  killspawner(12);
  crowsnest_assault_guys_wave1 = getaiarray("axis");
  thread AI_delete_when_out_of_sight(crowsnest_assault_guys_wave1, 512);
  array_thread(crowsnest_assault_guys_wave1, ::retreat_to_elevators);
}

player_fails_if_abandons_crowsnest() {
  level endon("player_getting_on_minigun");
  flag_wait("player_abandoning_crowsnest");

  level notify("mission failed");
  maps\_utility::missionFailedWrapper();
}

player_barrett_damage() {
  wait(3);

  iLoveTaps = 0;
  while(flag("player_is_on_turret")) {
    level.player DoDamage(20 / level.player.damageMultiplier, level.player.origin);
    level.player viewkick(127, level.player.origin);
    wait(randomfloatrange(1, 2));
    iLoveTaps++;
    if(iLoveTaps > 3) {
      break;
    }
  }

  if(flag("player_is_on_turret")) {
    obj_commerce_defend_javelin = getstruct("obj_commerce_defend_javelin", "targetname");
    MagicGrenade("fraggrenade", obj_commerce_defend_javelin.origin + (0, 0, 144), obj_commerce_defend_javelin.origin + (0, 0, 32));
  }
}

retreat_to_elevators() {
  self endon("death");
  if(!isDefined(self)) {
    return;
  }
  self notify("stop_seeking");
  position = getstruct("obj_commerce_sector_1d", "targetname");
  self setgoalpos(position.origin);
}

AI_crowsnest_assault_guys_wave1_think() {
  level endon("player_killed_enough");
  if(!isalive(self)) {
    return;
  }
  while(isalive(self)) {
    self waittill("death", attacker);
    if((isDefined(attacker)) && (isPlayer(attacker))) {
      level.guysKilled++;
      if(level.guysKilled > 3) {
        flag_set("player_killed_enough");
      } else
        break;
    }
  }
}

friendlies_shoot_stingers_start() {
  aFriendlies = [];
  aFriendlies[0] = level.teamleader;
  aFriendlies[1] = level.friendly02;

  friendlies_crowsnest_stage = getEntArray("friendlies_crowsnest_stage", "targetname");
  aFriendlies[0] thread friendly_shoot_stingers_and_jav_think(friendlies_crowsnest_stage[0]);
  aFriendlies[1] thread friendly_shoot_stingers_and_jav_think(friendlies_crowsnest_stage[1]);
}

friendly_shoot_stingers_and_jav_think(stingerJavNode) {
  self.scriptedTargets = [];
  aDummyTargets = stingerJavNode get_linked_ents();
  aTargetHeliNodes = stingerJavNode get_linked_structs();
  array_thread(aTargetHeliNodes, ::friendly_stinger_target_nodes_think, self);
  isJavelin = false;

  while(!flag("only_1_javelin_enemies_remaining")) {
    wait(1);
    if(within_fov(level.player.origin, level.player.angles, stingerJavNode.origin + (0, 0, 32), level.cosine["90"])) {
      continue;
    }
    if(within_fov(level.player.origin, level.player.angles, self.origin + (0, 0, 32), level.cosine["90"])) {
      continue;
    }
    break;
  }
  self friendly_shoot_at_crows_drones_stop();

  if(flag("only_1_javelin_enemies_remaining")) {
    return;
  }

  playerBadPlace = undefined;
  self.reference = stingerJavNode;
  magicBulletType = "stinger";
  weapon = "weapon_stinger";
  muzzleFlash = "javelin_muzzle";
  if(stingerJavNode.animation == "stinger_idle") {
    playerBadPlace = getent("volume_stinger_safezone", "targetname");
    self get_stinger_anims();
  } else {
    playerBadPlace = getent("volume_javelin_safezone", "targetname");
    isJavelin = true;
    self.animation = stingerJavNode.animation;
    self get_javelin_anims();
    magicBulletType = "javelin_dcburn";
    muzzleFlash = "javelin_muzzle";
    weapon = "weapon_javelin_sp";
  }
  self hide();
  self.reference anim_generic_first_frame(self, self.sAnimIdleStart);
  self show();
  eTarget = undefined;
  newMissile = undefined;
  stinger_source_org = undefined;

  self attach(weapon, "TAG_INHAND", 1);

  randomWait = 8;

  self.ignoreme = true;
  while(!flag("only_1_javelin_enemies_remaining")) {
    randomWait = randomfloatrange(6, 9);
    self.reference thread anim_generic_loop(self, self.sAnimIdle, "stop_idle");
    self waittill_notify_or_timeout("new_target", randomWait);
    self.reference notify("stop_idle");
    self.reference thread anim_generic(self, self.sAnimFire);
    self waittillmatch("single anim", "fire_weapon");
    eTarget = self friendly_shoot_stingers_get_target(aDummyTargets);
    if((isDefined(eTarget)) && (!level.player istouching(playerBadPlace))) {
      stinger_source_org = self gettagorigin("tag_inhand");
      newMissile = MagicBullet(magicBulletType, stinger_source_org, eTarget.origin);
      newMissile Missile_SetTargetEnt(eTarget);
      if(isJavelin) {
        newMissile Missile_SetFlightmodeTop();
        playFX(getfx(muzzleFlash), stinger_source_org);
      }
    }
    self waittillmatch("single anim", "end");
    if((flag("only_1_javelin_enemies_remaining")) || (flag("obj_commerce_defend_javelin_complete"))) {
      break;
    }
  }
  self.ignoreme = false;
  self notify("stop_shooting_stingers_and_javs");
  self notify("stop_first_frame");
  self.reference notify("stop_idle");
  self anim_stopanimscripted();
  self detach(weapon, "TAG_INHAND");
  self.reference = undefined;
  self.scriptedTargets = undefined;
}

player_is_not_in_the_way(playerBadPlace) {
  if(distance(playerBadPlace, level.player.origin) > 64) {
    return true;
  } else {
    return false;
  }
}

friendly_shoot_stingers_stop() {}

friendly_shoot_stingers_get_target(aDummyTargets) {
  if(!isDefined(self.scriptedTargets)) {
    return aDummyTargets[randomint(aDummyTargets.size)];
  }

  if(self.scriptedTargets.size == 0) {
    return aDummyTargets[randomint(aDummyTargets.size)];
  }

  self.scriptedTargets = remove_dead_from_array(self.scriptedTargets);

  if((level.friendlyArmorTargets > 0) && (level.friendliesCanHelpCrowsnest) && (self.scriptedTargets.size > 0)) {
    return (self.scriptedTargets[0]);
  } else
    return aDummyTargets[randomint(aDummyTargets.size)];
}

friendly_stinger_target_nodes_think(guy) {
  level endon("obj_commerce_defend_javelin_complete");
  guy endon("stop_shooting_stingers_and_javs");
  self endon("death");

  while((!flag("only_1_javelin_enemies_remaining")) && (isDefined(guy.scriptedTargets))) {
    self waittill("trigger", heli);
    if(!isDefined(heli)) {
      break;
    }
    if(!isDefined(guy.scriptedTargets)) {
      break;
    }
    guy.scriptedTargets = array_add(guy.scriptedTargets, heli);
    guy notify("new_target");
    wait(2);
    if(isDefined(heli)) {
      guy.scriptedTargets = array_remove(guy.scriptedTargets, heli);
    }

    if((flag("only_1_javelin_enemies_remaining")) || (flag("obj_commerce_defend_javelin_complete"))) {
      break;
    }
  }
}

friendlies_shoot_at_crows_drones_start() {
  aNodes = getnodearray("crow_nodes_drone_fire", "targetname");
  spawner = getent("hostiles_fodder_crowsnest", "targetname");
  level.hostiles_fodder_crowsnest = spawner spawn_ai();
  aFriendlies = [];
  aFriendlies[0] = level.teamleader;
  aFriendlies[1] = level.friendly02;

  foreach(guy in aFriendlies) {
    guy disable_ai_color();
    eNode = getfarthest(level.player.origin, aNodes);
    aNodes = array_remove(aNodes, eNode);
    guy.fixednode = false;
    guy.goalradius = 16;
    guy setGoalNode(eNode);
  }
  array_thread(aFriendlies, ::friendlies_shoot_at_crows_drones_think);
}
friendlies_shoot_at_crows_drones_think() {
  self endon("stop_shooting_at_drones");
  while(true) {
    wait(randomfloatrange(3, 6));
    self.ignoreall = true;
    wait(randomfloatrange(3, 6));
    self.ignoreall = false;
  }
}

friendlies_shoot_at_crows_drones_stop() {
  if(isDefined(level.hostiles_fodder_crowsnest)) {
    level.hostiles_fodder_crowsnest AI_delete();
  }
  aFriendlies = [];
  aFriendlies[0] = level.teamleader;
  aFriendlies[1] = level.friendly02;
  array_thread(aFriendlies, ::friendly_shoot_at_crows_drones_stop);
}

friendly_shoot_at_crows_drones_stop() {
  self notify("stop_shooting_at_drones");
  wait(0.05);
  self enable_ai_color();
  self.fixednode = true;
  self.ignoreall = false;
}

dialogue_nag_hostiles_at_crows() {
  level endon("player_killed_enough");
  while(!flag("player_killed_enough")) {
    if(flag("player_killed_enough")) {
      break;
    }

    level.friendly02 dialogue_execute("dcburn_cpd_inperimeter");
    wait(randomfloatrange(8, 14));

    if(flag("player_killed_enough")) {
      break;
    }

    level.friendly02 dialogue_execute("dcburn_cpd_takingfire");
    wait(randomfloatrange(8, 14));

    if(flag("player_killed_enough")) {
      break;
    }

    level.friendly02 dialogue_execute("dcburn_cpd_hostatsix");
    wait(randomfloatrange(8, 14));
  }
}

AI_sneak_monitor(sFlagToSet) {
  self endon("alerted");
  self thread AI_player_gunshot_monitor();
  wait(.5);

  self waittill_any("damage", "death", "shot_at");
  flag_set(sFlagToSet);
  if(isDefined(self)) {
    self thread AI_become_alerted();
  }
}

AI_player_gunshot_monitor() {
  distSquared = 512 * 512;
  self endon("death");
  self endon("alerted");
  self addAIEventListener("grenade danger");
  self addAIEventListener("gunshot");
  self addAIEventListener("silenced_shot");
  self addAIEventListener("bulletwhizby");
  self addAIEventListener("projectile_impact");

  wait(.5);
  while(isalive(self)) {
    self waittill("ai_event", eventtype);
    if((eventtype == "grenade danger") || (eventtype == "damage") || (eventtype == "projectile_impact") || (eventtype == "explode")) {
      break;
    }
    if(distancesquared(self.origin, level.player.origin) > distSquared) {
      continue;
    }
    if((eventtype == "grenade danger") || (eventtype == "damage") || (eventtype == "gunshot") || (eventtype == "bulletwhizby") || (eventtype == "projectile_impact") || (eventtype == "explode")) {
      break;
    }
  }
  self notify("shot_at");
}

AI_crowsnest_player_too_close() {
  self endon("death");
  self endon("alerted");
  flag_wait_any("player_entering_wall_hole", "player_shot_at_crowsnest_guys", "player_gawking_at_crowsnest_guys");
  flag_set("player_shot_at_crowsnest_guys");
  self thread AI_become_alerted();
}

evac_site_enemies_fire_live() {
  level endon("obj_commerce_defend_snipe_complete");

  iRampInterval = 4;
  if((level.gameskill == 2) || (level.gameskill == 3)) {
    iRampInterval = 0.1;
  }

  foreach(guy in level.evacSiteEnemies) {
    if(isalive(guy)) {
      guy.fireAtLiveTargets = true;
      wait(iRampInterval);
    }
  }
}

crowsnest_nags_snipe() {
  volume_crowsnest = getent("volume_crowsnest", "targetname");
  level.lasttimePlayerKilledEnemy = getTime();

  barret_nag_number = 0;
  barret_nag_number_max = 2;

  stay_in_nest_nag_number = 0;
  stay_in_nest_nag_number_max = 2;

  barret_shoot_nag_number = 0;
  barret_shoot_nag_number_max = 1;
  wait(.5);

  while(!flag("obj_commerce_defend_snipe_complete")) {
    if(barret_nag_number > barret_nag_number_max) {
      barret_nag_number = 0;
    }
    if(stay_in_nest_nag_number > stay_in_nest_nag_number_max) {
      stay_in_nest_nag_number = 0;
    }
    if(barret_shoot_nag_number > barret_shoot_nag_number_max) {
      barret_shoot_nag_number = 0;
    }

    nag_wait();
    flag_wait("can_start_crow_nags");
    if(flag("obj_commerce_defend_snipe_complete")) {
      break;
    }

    if((!level.player istouching(volume_crowsnest)) && (flag("can_talk"))) {
      flag_clear("can_talk");
      level.teamleader dialogue_execute("stay_in_nest_nag_" + stay_in_nest_nag_number);
      stay_in_nest_nag_number++;
      flag_set("can_talk");
    } else if((!flag("player_is_on_turret")) && (flag("can_talk"))) {
      flag_clear("can_talk");
      level.teamleader dialogue_execute("barret_nag_" + barret_nag_number);
      barret_nag_number++;
      flag_set("can_talk");
    } else if((!player_killing_crow_targets_at_a_good_pace()) && (flag("can_talk"))) {
      flag_clear("can_talk");
      level.teamleader dialogue_execute("barret_shoot_nag_" + barret_shoot_nag_number);
      barret_shoot_nag_number++;
      flag_set("can_talk");
    }
  }
}

crowsnest_ambient_vehicles() {
  crowsnest_seaknight_01 = getent("crowsnest_seaknight_01", "targetname");
  crowsnest_seaknight_02 = getent("crowsnest_seaknight_02", "targetname");
  crowsnest_seaknight_01 notify("spawn");
  crowsnest_seaknight_02 notify("spawn");

  flag_wait("player_in_crowsnest_room");
  flag_wait("make_seaknights_take_off");

  crowsnest_seaknight_01 notify("play_anim");
  wait(3);
  crowsnest_seaknight_02 notify("play_anim");
}

crowsnest_defend_failure() {
  percentDestroyed = undefined;
  color = (1, 1, 0);

  level.evacSiteVehiclesStartNumber = level.evacSiteVehicles.size;
  HUDdefendStatus = createFontString("default", 1.5);
  HUDdefendStatus setPoint("TOP", undefined, -41, 30);
  HUDdefendStatus.color = color;
  HUDdefendStatus.alpha = 0;

  flag_wait("obj_commerce_defend_snipe_given");
  HUDdefendStatus setText(&"DCBURNING_INFO_EVAC_SITE_HEALTH");

  HUDpercentage = createFontString("default", 1.5);
  HUDpercentage setPoint("TOP", undefined, 45, 30);
  HUDpercentage.color = color;
  HUDpercentage.alpha = 0;

  if(getDvar("dc_debug") == "1") {
    HUDpercentage fadeOverTime(1);
    HUDdefendStatus fadeOverTime(1);
    HUDdefendStatus.alpha = 1;
    HUDpercentage.alpha = 1;
  }

  thread evac_site_damage_nags_snipe();

  while(!flag("obj_commerce_defend_snipe_complete")) {
    percentDestroyed = get_evac_site_percent_destroyed();
    if(flag("obj_commerce_defend_snipe_complete")) {
      break;
    }
    level waittill_either("evac_vehicle_owned", "obj_commerce_defend_snipe_complete");
    if(flag("obj_commerce_defend_snipe_complete")) {
      break;
    }
    if(level.evacSiteVehicles.size < 2) {
      thread crowsnest_failure_check();
    }
  }
  HUDdefendStatus fadeOverTime(1);
  HUDpercentage fadeOverTime(1);
  HUDdefendStatus.alpha = 0;
  HUDpercentage.alpha = 0;
  HUDdefendStatus destroyElem();
  HUDpercentage destroyElem();
}

evac_site_damage_nags_snipe() {
  percentDestoyedAtLeast = 0;

  flag_wait("can_start_crow_nags");
  while(!flag("obj_commerce_defend_snipe_complete")) {
    flag_wait("can_talk");
    level waittill("evac_vehicle_owned");
    if(level.evacSitePercentDestroyed == 100) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_fail");
      flag_set("can_talk");
      return;
    } else if((level.evacSitePercentDestroyed > 25) && (level.evacSitePercentDestroyed < 50) && (percentDestoyedAtLeast < 25)) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_00");
      percentDestoyedAtLeast = 25;
      flag_set("can_talk");
    } else if((level.evacSitePercentDestroyed > 50) && (level.evacSitePercentDestroyed < 75) && (percentDestoyedAtLeast < 50)) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_01");
      percentDestoyedAtLeast = 50;
      flag_set("can_talk");
    } else if((level.evacSitePercentDestroyed > 75) && (level.evacSitePercentDestroyed < 90) && (percentDestoyedAtLeast < 75)) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_02");
      percentDestoyedAtLeast = 75;
      flag_set("can_talk");
    } else if((level.evacSitePercentDestroyed > 90) && (level.evacSitePercentDestroyed < 100) && (percentDestoyedAtLeast < 90)) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_03");
      percentDestoyedAtLeast = 90;
      flag_set("can_talk");
    }
  }
}

crowsnest_failure_check() {
  level.evacSiteVehicles = remove_dead_from_array(level.evacSiteVehicles);
  if((level.evacSiteVehicles.size == 0) && (!flag("obj_commerce_defend_snipe_complete"))) {
    crowsnest_mission_fail_snipe();
  }
}

crowsnest_mission_fail_snipe() {
  setDvar("ui_deadquote", &"DCBURNING_MISSIONFAIL_CROWSNEST_SNIPE");
  level notify("mission failed");
  maps\_utility::missionFailedWrapper();
}

crowsnest_mission_fail_armor() {
  setDvar("ui_deadquote", &"DCBURNING_MISSIONFAIL_CROWSNEST_SNIPE");
  level notify("mission failed");
  maps\_utility::missionFailedWrapper();
}

get_evac_site_percent_destroyed() {
  fPercentRemaining = (level.evacSiteVehicles.size / level.evacSiteVehiclesStartNumber) * 100;
  fPercentRemaining = roundDecimalPlaces(fPercentRemaining, 0);
  fPercentDestroyed = 100 - fPercentRemaining;
  level.evacSitePercentDestroyed = fPercentDestroyed;
  sNumber = string(fPercentDestroyed) + " percent";
  return sNumber;
}

roundDecimalPlaces(value, places, style) {
  if(!isDefined(style)) {
    style = "nearest";
  }

  modifier = 1;
  for(i = 0; i < places; i++) {
    modifier *= 10;
  }

  newValue = value * modifier;

  if(style == "up") {
    roundedValue = ceil(newValue);
  } else if(style == "down") {
    roundedValue = floor(newValue);
  } else {
    roundedValue = newvalue + 0.5;
  }

  newvalue = Int(roundedValue);
  newvalue = newvalue / modifier;

  return newvalue;
}

crowsnest_barret_glow(model_barrett, model_barrett_glow) {
  if(!flag("player_is_on_turret")) {
    model_barrett hide();
    model_barrett_glow show();
  }
  flag_wait("player_is_on_turret");
  model_barrett_glow hide();
  flag_waitopen("player_is_on_turret");
  model_barrett show();
}

dialogue_crowsnest() {
  flag_wait("crowsnest_has_been_cleared");

  thread autosave_by_name("crowsnest_cleared");

  wait(1);
  flag_set("make_seaknights_take_off");

  level.teamleader dialogue_execute("dcburn_mcy_seccrowsnest");

  radio_dialogue("dcburn_hqr_canyousupport");

  level.teamleader dialogue_execute("dcburn_mcy_stockpile");

  if(!flag("player_is_on_turret")) {
    level.teamleader thread dialogue_execute("dcburn_mcy_sniperrifle");
  } else {
    level.teamleader thread dialogue_execute("dcburn_mcy_scanfortargets");
  }

  wait(2);
  flag_set("obj_commerce_defend_snipe_given");

  if(!flag("player_is_on_turret")) {
    wait(4);
  }

  radio_dialogue("dcburn_evc_glassedenemieswest");
  flag_set("can_start_crow_nags");
}

vehicles_crowsnest_defend_think() {
  level endon("obj_commerce_defend_snipe_complete");

  self setCanDamage(true);
  origin = self.origin;

  while(isDefined(self)) {
    self waittill("damage", amount, attacker, enemy_org, impact_org, type);
    if(!isDefined(type)) {
      continue;
    }
    if(!isDefined(attacker)) {
      continue;
    }
    if((isDefined(attacker.code_classname)) && (attacker.code_classname == "misc_turret")) {
      continue;
    }
    if(!isDefined(amount)) {
      continue;
    }
    if(isPlayer(attacker)) {
      continue;
    }
    if((isDefined(attacker.team)) && (attacker.team != "axis")) {
      continue;
    }
    if((type == "MOD_PROJECTILE") && (amount > 999)) {
      break;
    }
    if((type == "MOD_PROJECTILE_SPLASH") && (amount == 4000)) {
      break;
    }
  }

  if(is_in_array(level.evacSiteVehicles, self)) {
    level.evacSiteVehicles = array_remove(level.evacSiteVehicles, self);
  }
  if(is_in_array(level.targetsScriptedJavStinger, self)) {
    level.targetsScriptedJavStinger = array_remove(level.targetsScriptedJavStinger, self);
  }
  self.dead = true;
  level notify("evac_vehicle_owned");

  eDeathModel = undefined;
  effect = "large_vehicle_explosion";
  sound = "exp_tanker_vehicle";

  if(isDefined(self.script_linkTo)) {
    eDeathModel = getent(self.script_linkto, "script_linkname");
    eDeathModel show();
    self delete();
  } else {
    switch (self.model) {
      case "vehicle_hummer":
        eDeathModel = "vehicle_hummer_destroyed";
        sound = "exp_armor_vehicle";
        break;
      case "vehicle_bradley_static":
        eDeathModel = "vehicle_bradley_destroyed";
        sound = "exp_armor_vehicle";
        break;
      default:
        assertmsg("no destroyed model defined for " + self.model + " at " + self.origin);
    }

    self setModel(eDeathModel);
  }

  playFX(getfx(effect), origin);
  thread play_sound_in_space(sound, origin);
}

vehicles_cheap_waittill_destroyed_think() {
  self endon("death");

  self setCanDamage(true);

  while(isDefined(self)) {
    self waittill("damage", amount, attacker, enemy_org, impact_org, type);
    if(!isDefined(type)) {
      continue;
    }
    if(!isDefined(attacker)) {
      continue;
    }
    if(!isDefined(amount)) {
      continue;
    }
    if(isPlayer(attacker)) {
      continue;
    }
    if((type == "MOD_PROJECTILE") && (amount > 999)) {
      break;
    }
    if((type == "MOD_PROJECTILE_SPLASH") && (amount == 4000)) {
      break;
    }
  }

  eDeathModel = undefined;
  effect = "large_vehicle_explosion";
  sound = "exp_tanker_vehicle";
  fireFx = "tanker_fire";
  onFire = false;

  if(isDefined(self.script_linkTo)) {
    eDeathModel = getent(self.script_linkto, "script_linkname");
    eDeathModel show();
    self delete();
  } else {
    switch (self.model) {
      case "vehicle_hummer":
        eDeathModel = "vehicle_hummer_destroyed";
        sound = "exp_armor_vehicle";
        fireFx = undefined;
        break;
      case "vehicle_bradley":
        eDeathModel = "vehicle_bradley";
        sound = "exp_armor_vehicle";
        fireFx = undefined;
        break;
      case "vehicle_m1a1_abrams":
        eDeathModel = "vehicle_m1a1_abrams_dmg";
        sound = "exp_armor_vehicle";
        fireFx = undefined;
        break;
      default:
        assertmsg("no destroyed model defined for " + self.model + " at " + self.origin);
    }

    self setModel(eDeathModel);
  }

  playFX(getfx(effect), self.origin);
  self thread play_sound_in_space(sound);
  if(isDefined(fireFx)) {
    dummy = spawn("script_origin", self.origin + (0, 0, 0));
    dummy.angles = self.angles;
    fx = spawnFx(getFx(fireFx), dummy.origin);
    triggerFx(fx);
    flag_wait("player_heli_19");
    fx delete();
    dummy delete();
  }
}

AA_crows_nest_armor_init() {
  thread AAA_sequence_crowsnest_armor();
  thread javelin_hints();
  thread backup_enemies_for_javelin_sequence();
  thread music_crowsnest_armor();
  thread obj_commerce_defend_javelin();
  thread dialogue_crow_armor();
  flag_wait("crowsnest_sequence_finished");
  thread AA_commerce_to_roof_init();
}

javelin_hints() {
  flag_wait("obj_commerce_defend_javelin_given");

  wait(5);

  if(flag("player_has_killed_at_least_one_javelin_target")) {
    return;
  }
  while(!flag("player_has_killed_at_least_one_javelin_target")) {
    wait(20);

    if(player_has_javelin()) {
      wait(10);
    }

    if(flag("player_has_killed_at_least_one_javelin_target")) {
      return;
    }
    if(!player_has_javelin()) {
      level.player thread display_hint("javelin_pickup");
    } else if((player_has_javelin()) && (javelin_equipped())) {
      level.player thread display_hint("javelin_shoot");
    } else {
      level.player thread display_hint("javelin_switch");
    }
  }
}

should_break_javelin_fire_hint() {
  if(flag("player_has_killed_at_least_one_javelin_target")) {
    return true;
  }
  if(!player_has_javelin()) {
    return true;
  }
  if(!javelin_equipped()) {
    return true;
  }
  return maps\_javelin::PlayerJavelinAds();
}

should_break_javelin_switch_hint() {
  if(flag("player_has_killed_at_least_one_javelin_target")) {
    return true;
  }
  return javelin_equipped();
}

should_break_javelin_pickup_hint() {
  if(flag("player_has_killed_at_least_one_javelin_target")) {
    return true;
  }

  assert(isPlayer(self));

  if(javelin_equipped()) {
    return true;
  }

  weapons = level.player getweaponslistprimaries();
  has_javelin = false;

  return player_has_javelin();
}

player_has_javelin() {
  weapons = level.player GetWeaponsListAll();
  if(!isDefined(weapons)) {
    return false;
  }
  foreach(weapon in weapons) {
    if(IsSubStr(weapon, "javelin")) {
      return true;
    }
  }
  return false;
}

javelin_equipped() {
  weapon = level.player getCurrentWeapon();
  if(IsSubStr(weapon, "javelin")) {
    return true;
  } else {
    return false;
  }
}

music_crowsnest_armor() {
  flag_wait("obj_commerce_defend_javelin_given");
  music_stop();
  wait(.1);
  thread music_loop("dcburning_ordnance_and_run", 140);
}

backup_enemies_for_javelin_sequence() {
  flag_wait("obj_commerce_defend_javelin_given");

  thread player_invulnerable_till_one_javelin_target_killed();

  wait(1);

  if(level.crowsarmor.size < 5) {
    tanks_crowsnest_wave2 = spawn_vehicles_from_targetname_and_drive("tanks_crowsnest_wave2");
    array_thread(tanks_crowsnest_wave2, ::tanks_crowsnest_wave2_think);
  }
}

player_invulnerable_till_one_javelin_target_killed() {
  if(level.gameskill > 1) {
    return;
  }
  level.player enableinvulnerability();
  flag_wait("player_has_killed_at_least_one_javelin_target");
  level.player disableinvulnerability();
}

AAA_sequence_crowsnest_armor() {
  flag_wait("start_crow_armor_sequence");

  barrett_trigger = getent("barrett_trigger", "targetname");
  barrett_trigger.origin = barrett_trigger.origin + (0, 0, -20);
  barrett_trigger usetriggerrequirelookat();

  level.monument_target thread monument_target_think();
  helis_crowsnest = spawn_vehicles_from_targetname_and_drive("helis_crowsnest");
  helis_crowsnest_respawners = spawn_vehicles_from_targetname_and_drive("helis_crowsnest_respawners");
  array_thread(helis_crowsnest, ::helis_crowsnest_think);
  array_thread(helis_crowsnest_respawners, ::helis_crowsnest_think);

  thread make_friendlies_shoot_stingers_and_javs();

  volume = getent("perimeter_enemies", "targetname");
  thread flag_set_when_volume_cleared_of_bad_guys(volume, "perimeter_enemies_have_retreated");

  wait(25);
  level.friendliesCanHelpCrowsnest = true;

  flag_wait("only_2_javelin_enemies_remaining");

  flag_wait("obj_commerce_defend_javelin_complete");

  thread autosave_now();

  flag_set("crowsnest_sequence_finished");

  javelin_weapon_switch();
}

make_friendlies_shoot_stingers_and_javs() {
  flag_wait("perimeter_enemies_have_retreated");
  thread friendlies_shoot_at_crows_drones_start();
  thread friendlies_shoot_stingers_start();
}

javelin_weapon_switch() {
  if(!player_has_javelin()) {
    return;
  }
  hasGren = false;
  tookWeapon = false;
  weaponList = level.player GetWeaponsListPrimaries();
  tookMainWeapon = false;

  foreach(weapon in weaponList) {
    if(issubstr(weapon, "avelin")) {
      tookWeapon = true;
      if(issubstr(level.player GetCurrentWeapon(), "avelin")) {
        tookMainWeapon = true;
        level.player DisableWeapons();
        wait(1.5);
      }
      level.player takeweapon(weapon);
      continue;
    }

    if(weapon == "m4m203_eotech") {
      hasGren = true;
    }
  }

  if(!tookWeapon) {
    return;
  }

  level.player EnableWeapons();

  if(!hasGren) {
    level.player giveWeapon("m4m203_eotech");
  }

  if(tookMainWeapon) {
    level.player switchToWeapon("m4m203_eotech");
  }
}

dialogue_crow_armor() {
  flag_wait("start_crow_armor_sequence");

  radio_dialogue("dcburn_hqr_clearout");

  level.teamleader dialogue_execute("dcburn_mcy_negative");

  flag_set("obj_commerce_defend_javelin_given");

  level.teamleader dialogue_execute("dcburn_mcy_useordnance");

  thread crowsnest_nags_armor();
  thread evac_site_damage_nags_armor();
}

crowsnest_nags_armor() {
  volume_crowsnest = getent("volume_crowsnest", "targetname");
  level.lasttimePlayerKilledEnemy = getTime();

  rocket_nag_number = 0;
  rocket_nag_number_max = 3;

  stay_in_nest_nag_number = 0;
  stay_in_nest_nag_number_max = 2;

  rocket_shoot_nag_number = 0;
  rocket_shoot_nag_number_max = 2;
  wait(.5);

  while(!flag("obj_commerce_defend_javelin_complete")) {
    if(rocket_nag_number > rocket_nag_number_max) {
      rocket_nag_number = 0;
    }
    if(stay_in_nest_nag_number > stay_in_nest_nag_number_max) {
      stay_in_nest_nag_number = 0;
    }
    if(rocket_shoot_nag_number > rocket_shoot_nag_number_max) {
      rocket_shoot_nag_number = 0;
    }

    nag_wait();

    if(flag("obj_commerce_defend_javelin_complete")) {
      break;
    }

    if((!level.player istouching(volume_crowsnest)) && (flag("can_talk"))) {
      flag_clear("can_talk");
      level.teamleader dialogue_execute("stay_in_nest_nag_" + stay_in_nest_nag_number);
      stay_in_nest_nag_number++;
      flag_set("can_talk");
    } else if((!level.player player_using_missile()) && (flag("can_talk"))) {
      flag_clear("can_talk");
      level.teamleader dialogue_execute("rocket_nag_" + rocket_nag_number);
      rocket_nag_number++;
      flag_set("can_talk");
    } else if((!player_killing_crow_targets_at_a_good_pace()) && (flag("can_talk"))) {
      flag_clear("can_talk");
      level.teamleader dialogue_execute("rocket_shoot_nag_" + rocket_shoot_nag_number);
      rocket_shoot_nag_number++;
      flag_set("can_talk");
    }
  }
}

monument_target_think() {
  level.evacSitePercentDestroyed = 0;

  level endon("mission failed");
  level endon("missionfailed");
  self setCanDamage(true);

  self.hitpoints = undefined;
  switch (level.gameSkill) {
    case 0:
      self.hitpoints = 5000;
      break;
    case 1:
      self.hitpoints = 5000;
      break;
    case 2:
      self.hitpoints = 5000;
      break;
    case 3:
      self.hitpoints = 5000;
      break;
  }
  self.baseHitpoints = self.hitpoints;
  flag_set("monument_dummy_target_setup");
  while(!flag("obj_commerce_defend_javelin_complete")) {
    self waittill("damage", amount, attacker, enemy_org, impact_org, type);
    if(!isDefined(attacker)) {
      continue;
    }
    if(!isDefined(amount)) {
      continue;
    }
    if(isPlayer(attacker)) {
      continue;
    }
    if((isDefined(attacker.team)) && (attacker.team != "axis")) {
      continue;
    }
    if(!isDefined(type)) {
      continue;
    }
    if(type == "MOD_PROJECTILE") {
      self reduce_monument_hitpoints(100);
      if(self.hitpoints < 1) {
        break;
      }
    }

    if(type == "MOD_PROJECTILE_SPLASH") {
      self reduce_monument_hitpoints(50);
      if(self.hitpoints < 1) {
        break;
      }
    }
  }
  if(!flag("obj_commerce_defend_javelin_complete")) {
    thread crowsnest_mission_fail_armor();
  }
}

reduce_monument_hitpoints(hitpoints) {
  self.hitpoints = self.hitpoints - hitpoints;
  fPercentRemaining = (self.hitpoints / self.baseHitpoints) * 100;
  fPercentRemaining = roundDecimalPlaces(fPercentRemaining, 0);
  fPercentDestroyed = 100 - fPercentRemaining;
  level.evacSitePercentDestroyed = fPercentDestroyed;
  level notify("monument_dummy_hit");
  if(getDvar("dc_debug") == "1") {
    println("evac damage = " + level.evacSitePercentDestroyed);
  }
}

evac_site_damage_nags_armor() {
  flag_wait("monument_dummy_target_setup");
  percentDestoyedAtLeast = 0;
  baseHitpoints = level.monument_target.hitpoints;

  while(!flag("obj_commerce_defend_javelin_complete")) {
    flag_wait("can_talk");
    level waittill("monument_dummy_hit");
    if(level.evacSitePercentDestroyed == 100) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_fail");
      flag_set("can_talk");
      return;
    } else if((level.evacSitePercentDestroyed > 25) && (level.evacSitePercentDestroyed < 50) && (percentDestoyedAtLeast < 25)) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_00");
      percentDestoyedAtLeast = 25;
      flag_set("can_talk");
    } else if((level.evacSitePercentDestroyed > 50) && (level.evacSitePercentDestroyed < 75) && (percentDestoyedAtLeast < 50)) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_01");
      percentDestoyedAtLeast = 50;
      flag_set("can_talk");
    } else if((level.evacSitePercentDestroyed > 75) && (level.evacSitePercentDestroyed < 90) && (percentDestoyedAtLeast < 75)) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_02");
      percentDestoyedAtLeast = 75;
      flag_set("can_talk");
    } else if((level.evacSitePercentDestroyed > 90) && (level.evacSitePercentDestroyed < 100) && (percentDestoyedAtLeast < 90)) {
      flag_clear("can_talk");

      radio_dialogue("dcburn_evc_damage_03");
      percentDestoyedAtLeast = 90;
      flag_set("can_talk");
    }
  }
}

tanks_crowsnest_wave1_gopath(aTanks) {
  foreach(tank in aTanks) {
    wait(5);
    thread gopath(tank);
  }
}

helis_crowsnest_think() {
  self endon("death");
  self thread heli_crowsnest_respawn();
  self thread obj_commerce_defend_javelin_enemies_think();
  aPathNodes = vehicle_get_path_array();
  array_thread(aPathNodes, ::heli_pathnodes_think, self);
}

heli_crowsnest_respawn() {
  if((isDefined(self.script_noteworthy)) && (issubstr(self.script_noteworthy, "crow_heli_respawner_"))) {
    noteworthyName = self.script_noteworthy;
    self waittill("death");

    wait(1);
    spawner = getent(noteworthyName, "script_noteworthy");
    assert(isDefined(spawner));
    if(!flag("obj_commerce_defend_javelin_complete")) {
      heli = vehicle_spawn(spawner);
      thread gopath(heli);
      heli thread helis_crowsnest_think();
    }
  }
}

heli_pathnodes_think(heli) {
  heli endon("death");
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  eTarget = undefined;
  bGunTarget = undefined;
  switch (self.script_noteworthy) {
    case "target_nothing":
      eTarget = undefined;
      break;
    case "target_evac":
      eTarget = getent("monument_target", "targetname");
      bGunTarget = eTarget;
      break;
    case "target_crowsnest":
      eTarget = getent("javelin_source_org", "targetname");
      bGunTarget = level.player;
      break;
    default:
      return;
  }
  while(isDefined(heli)) {
    self waittill("trigger");
    if(!isDefined(eTarget)) {
      heli clearLookAtEnt();
    } else {
      heli SetLookAtEnt(eTarget);
    }
    if(isDefined(bGunTarget)) {
      heli thread vehicle_heli_fire_turret(bGunTarget);
    } else
      heli notify("stop_firing_turret");
  }
}

tanks_crowsnest_wave1_think() {
  self endon("death");
  self ent_flag_init("start_firing");
  selfent_flag_wait("start_firing");
  self thread tank_fire_at_evac_site();

  flag_wait("obj_commerce_defend_javelin_given");

  self thread obj_commerce_defend_javelin_enemies_think();
}

tanks_crowsnest_wave2_think() {
  self endon("death");
  self ent_flag_init("start_firing");
  flag_wait("obj_commerce_defend_javelin_given");
  self thread obj_commerce_defend_javelin_enemies_think();
  selfent_flag_wait("start_firing");
  self thread tank_fire_at_evac_site();
}

tank_fire_at_evac_site() {
  self endon("death");
  self vehicle_turret_scan_off();
  self thread vehicle_tank_fire_turret(level.monument_target);
  while(isDefined(self)) {
    self setTurretTargetEnt(level.monument_target);
    wait(randomfloatrange(3, 6));
    self fireWeapon();
  }
}

AA_commerce_to_roof_init() {
  thread AAA_sequence_get_to_roof();
  thread dialogue_get_to_roof();
  thread obj_rooftop();

  flag_wait("player_approaching_outer_balcony");
  thread AA_roof_init();
}

breach_double_door_swings_open() {
  flag_wait("roof_door_kicked");
  door_to_roof_swing = getent("door_to_roof_swing", "targetname");
  door_to_roof_swing.startingpos = self.origin;
  door_to_roof_swing.startingangles = self.angles;
  door_to_roof_swing rotateyaw(-170, 0.5);
  door_to_roof_swing moveto(door_to_roof_swing.origin + (11, 0, 0), 0.1);
  door_to_roof_swing connectpaths();
}

AI_breach_defenders_think() {
  self endon("death");
  self thread try_to_magic_bullet_shield();
  self.neverEnableCQB = true;

  self.goalradius = 16;
  self.baseaccuracy = 1000;
  self.attackeraccuracy = 0;

  flag_wait("player_roof_stairs_00");

  self.health = 1;
  self.baseaccuracy = .01;
  self.attackeraccuracy = 10;
  self thread stop_magic_bullet_shield();
}

AAA_sequence_get_to_roof() {
  flag_wait("only_2_javelin_enemies_remaining");

  trigger_volume_breach_stairwell = getent("trigger_volume_breach_stairwell", "targetname");
  trigger_volume_breach_stairwell trigger_off();
  volume_breach_stairwell = getent("volume_breach_stairwell", "targetname");
  thread roof_breach_monitor(volume_breach_stairwell);
  aBreachers = array_spawn(getEntArray("crowsnest_breachers", "targetname"));
  aBreachDefenders = array_spawn(getEntArray("friendlies_breach_defend", "targetname"));
  array_thread(aBreachDefenders, ::AI_breach_defenders_think);
  sBreachType = "shotgunhinges_breach_left";
  volume_breach_stairwell thread maps\_breach::breach_think(aBreachers, sBreachType);

  foreach(guy in aBreachers) {
    guy.eNode = getnode(guy.target, "targetname");
    guy thread AI_ignored_and_oblivious_on();
  }

  flag_wait("crowsnest_sequence_finished");
  triggersEnable("colornodes_start_to_roof", "script_noteworthy", true);
  trig_colornode = getent("colornodes_start_to_roof", "script_noteworthy");
  trig_colornode notify("trigger", level.player);
  level.squad = remove_dead_from_array(level.squad);

  thread breach_double_door_swings_open();
  trigger_volume_breach_stairwell trigger_on();

  delaythread(3, ::spawn_trigger_dummy, "dummy_spawner_roof_wave_01");

  flag_wait("obj_rooftop_given");

  if((isDefined(level.crowsArmor)) && (level.crowsArmor.size > 0)) {
    array_thread(level.crowsArmor, ::crows_armor_cleanup);
  }

  friendlies = getaiarray("allies");
  array_thread(friendlies, ::cqb_walk, "off");
  foreach(guy in friendlies) {
    guy.neverEnableCQB = true;
  }

  flag_wait("roof_breach_complete");

  foreach(guy in aBreachers) {
    guy setgoalnode(guy.eNode);

    guy.goalradius = 64;
  }

  triggersEnable("colornodes_to_roof", "script_noteworthy", true);

  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  foreach(guy in level.squad) {
    if(!isalive(guy)) {
      continue;
    }

    guy.a.disablePain = true;
    guy.ignoresuppression = true;
    guy.disableDamageShieldPain = true;
    guy.grenadeawareness = 0;
    guy.goalradius = 32;

    if((guy == level.teamleader) || (guy == level.friendly02)) {
      self.attackeraccuracy = .01;
      self.baseaccuracy = 1000;
    }
  }

  wait(2);
  array_thread(aBreachers, ::AI_roof_escape_redshirts_think);
  foreach(guy in aBreachers) {
    guy thread AI_ignored_and_oblivious_off();
  }

  spawn_trigger_dummy("dummy_spawner_roof_wave_02");

  if(!flag("player_roof_stairs_00")) {
    thread dummy_trigger("dummy_colornodes_to_roof");
  }

  flag_wait("player_roof_stairs_01");
  if((isDefined(level.evacSiteEnemies)) && (level.evacSiteEnemies.size > 0)) {
    array_thread(level.evacSiteEnemies, ::AI_delete);
  }
  thread drone_flood_stop("hostiles_drones_comm_south");
  thread vehicle_delete_all();
  thread AI_drone_cleanup("all", 1024, true);

  flag_wait("player_roof_stairs_02");
  jets_tenches_01 = spawn_vehicles_from_targetname_and_drive("jets_tenches_01");

  eNodeLeader = getnode("node_roof_leader", "targetname");
  eNodeFriendly02 = getnode("node_roof_friendly02", "targetname");
  level.teamleader thread try_to_teleport_friendlies_to_roof(eNodeLeader);
  level.friendly02 thread try_to_teleport_friendlies_to_roof(eNodeFriendly02);

  flag_wait("player_top_floor_commerce");
  jets_tenches_02 = spawn_vehicles_from_targetname_and_drive("jets_tenches_02");

  flag_wait("player_outer_balcony_top_commerce");
  eHeli = spawn_vehicle_from_targetname("heli_deck2");
  thread maps\_vehicle::gopath(eHeli);

  eHeli thread heli_balcony_think();

  flag_wait("player_at_commerce_rooftop");

  if(isDefined(eHeli)) {
    eHeli delete();
  }

  flag_set("obj_rooftop_complete");

  thread kill_timer();
  thread autosave_by_name("rooftop");
}

heli_balcony_think() {
  self endon("death");
  self SetLookAtEnt(level.player);
  flag_wait("balcony_heli_raised_up");
  self ClearLookAtEnt();
  flag_wait("player_at_commerce_rooftop");
  if(isDefined(self)) {
    self delete();
  }
}

crows_armor_cleanup() {
  self endon("death");
  flag_wait("player_roof_stairs_01");
  if(isDefined(self)) {
    self vehicle_delete();
  }
}

AI_roof_escape_redshirts_think() {
  self endon("death");
  self.neverEnableCQB = true;
  self.health = 1;

  self.goalradius = 32;
  self.baseaccuracy = .01;
}

dummy_trigger(dummyName) {
  dummy = getent(dummyName, "targetname");
  trigger = getEnt(dummy.script_LinkTo, "script_linkname");
  if(isDefined(trigger)) {
    trigger notify("trigger", level.player);
  }
}

roof_breach_monitor(eVoloume) {
  eVoloume waittill("breach_complete");
  flag_set("roof_breach_complete");
}

dialogue_get_to_roof() {
  flag_wait("crowsnest_sequence_finished");

  radio_dialogue("dcburn_hqr_roofasap");

  flag_set("obj_rooftop_given");

  level.teamleader dialogue_execute("dcburn_mcy_rooftop");

  thread escape_timer(90);

  radio_dialogue("dcburn_hqr_urgentsurgicals");

  while(!flag("roof_breach_complete")) {
    level.teamleader dialogue_execute("dcburn_mcy_rvwithseals");

    wait(randomfloatrange(8, 12));
    if(flag("roof_breach_complete")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_crawlin");

    wait(randomfloatrange(8, 12));
    if(flag("roof_breach_complete")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_letsmoveout");

    wait(randomfloatrange(8, 12));
    if(flag("roof_breach_complete")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_gettoroofnow");

    wait(randomfloatrange(8, 12));
    if(flag("roof_breach_complete")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_overrunningpos");

    wait(randomfloatrange(8, 12));
    if(flag("roof_breach_complete")) {
      break;
    }
  }

  radio_dialogue("dcburn_ar5_triplea");

  radio_dialogue("dcburn_ar2_backinseats");

  while(!flag("player_roof_stairs_00")) {
    level.teamleader dialogue_execute("dcburn_mcy_outnumbered");

    wait(randomfloatrange(8, 12));
    if(flag("player_roof_stairs_00")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_upthestairsgo");

    wait(randomfloatrange(8, 12));
    if(flag("player_roof_stairs_00")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_waitallday");

    wait(randomfloatrange(8, 12));
    if(flag("player_roof_stairs_00")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_gettingoverrun");
  }

  wait(2);

  level.teamleader dialogue_execute("dcburn_mcy_outoftimego");
  wait(2);

  level.friendly02 dialogue_execute("dcburn_cpd_closingin");

  flag_wait("player_roof_stairs_02");

  level.teamleader dialogue_execute("dcburn_mcy_lobby_move_nag_00");

  flavorbursts_off("allies");

  level.player play_sound_on_entity("dcburn_ar3_gottatouchdown");
  flavorbursts_on("allies");

  flag_wait("player_outer_balcony_top_commerce");

  while(!flag("player_headed_to_roof")) {
    level.teamleader dialogue_execute("dcburn_mcy_lobby_move_nag_02");
    wait(2);

    level.teamleader dialogue_execute("dcburn_mcy_notime");

    if(flag("player_headed_to_roof")) {
      break;
    }

    wait(2);

    if(flag("player_headed_to_roof")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_keepmoving");
    wait(2);
  }

  flag_wait("player_headed_to_roof");
  radio_dialogue("dcburn_bhp_whatsyourstatus");

  level.teamleader dialogue_execute("dcburn_mcy_hostilesclose");

  while(!flag("player_at_commerce_rooftop")) {
    wait(1);

    if(flag("player_at_commerce_rooftop")) {
      break;
    }

    wait(1);

    if(flag("player_at_commerce_rooftop")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_overrun");

    wait(1);

    if(flag("player_at_commerce_rooftop")) {
      break;
    }

    wait(1);

    if(flag("player_at_commerce_rooftop")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_lobby_move_nag_00");

    wait(1);

    if(flag("player_at_commerce_rooftop")) {
      break;
    }

    wait(1);

    if(flag("player_at_commerce_rooftop")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_outoftimego");

    wait(1);

    if(flag("player_at_commerce_rooftop")) {
      break;
    }

    wait(1);

    if(flag("player_at_commerce_rooftop")) {
      break;
    }

    level.teamleader dialogue_execute("dcburn_mcy_outnumbered");
  }
  flag_set("rooftop_run_dialogue_finished");
}

AA_roof_init() {
  thread obj_heli_mount();
  thread dialogue_roof();
  thread music_heli_ride();
  thread heli_at4_sequence();
  thread AAA_sequence_heli_ride();
  thread littlebird_wingman_02_think();
  thread littlebird_wingman_armed_think();
  thread obj_heli_ride();

  flag_wait("player_heli_18");
  AA_heli_ride2();
}

music_heli_ride() {
  flag_wait("roof_heli_about_to_be_owned");
  flag_wait_or_timeout("roof_heli_owned", 1.65);
  MusicPlayWrapper("dcburning_heli_ride3");
}

dialogue_roof() {
  flag_wait("player_at_commerce_rooftop");

  flag_wait("blackhawk_landed");

  flag_set("obj_heli_mount_given");
  thread dialogue_nag_minigun();

  flag_wait("player_getting_on_minigun");

  level.player SetActionSlot(1, "");
  level.player NightVisionForceOff();

  while(!flag("can_talk")) {
    wait(.5);
  }

  radio_dialogue("dcburn_mcy_bunkerevac");

  radio_dialogue("dcburn_hqr_stillpinned");

  radio_dialogue("dcburn_mcy_fromtheair");

  flag_set("obj_heli_ride_given");
  thread autosave_now(true);

  thread radio_dialogue("dcburn_hqr_firstwave");

  flag_wait("player_heli_05");

  radio_dialogue_overlap("dcburn_lbp1_breakleftbreakleft");

  flag_wait("player_heli_07");

  radio_dialogue("dcburn_mcy_hitgoingdown");

  flag_wait("player_heli_09");
  wait(1);

  radio_dialogue("dcburn_bhp_dontgetup");

  radio_dialogue("dcburn_hqr_fallbacknow");

  flag_set("player_has_used_minigun");
  if(!flag("player_has_used_minigun")) {
    radio_dialogue("dcburn_mcy_spinherup");
  }

  flag_wait("player_heli_10c");

  radio_dialogue("dcburn_lbp1_gunshipliftingoff");

  radio_dialogue("dcburn_ar2_leavebehind");

  flag_wait("player_heli_14");

  radio_dialogue("dcburn_evc_mainroad");

  radio_dialogue("dcburn_hqr_orderirene");

  radio_dialogue("dcburn_ar1_weareleaving");

  radio_dialogue("dcburn_ar4_wearegoingdown");
}

dialogue_nag_minigun() {
  flag_wait("rooftop_run_dialogue_finished");

  flag_set("can_talk");

  while(!flag("player_getting_on_minigun")) {
    flag_clear("can_talk");
    level.teamleader dialogue_execute("dcburn_mcy_moveminigun");
    flag_set("can_talk");

    if(flag("player_getting_on_minigun")) {
      break;
    }

    wait(30);

    if(flag("player_getting_on_minigun")) {
      break;
    }

    flag_clear("can_talk");

    level.teamleader dialogue_execute("dcburn_mcy_getonminigun");
    flag_set("can_talk");

    if(flag("player_getting_on_minigun")) {
      break;
    }

    wait(30);

    if(flag("player_getting_on_minigun")) {
      break;
    }

    flag_clear("can_talk");

    level.teamleader dialogue_execute("dcburn_mcy_getinchopper");
    flag_set("can_talk");

    if(flag("player_getting_on_minigun")) {
      break;
    }

    wait(30);

    if(flag("player_getting_on_minigun")) {
      break;
    }

    flag_clear("can_talk");

    level.teamleader dialogue_execute("dcburn_mcy_wayoutnumbered");
    flag_set("can_talk");

    if(flag("player_getting_on_minigun")) {
      break;
    }

    wait(30);

    if(flag("player_getting_on_minigun")) {
      break;
    }

    flag_clear("can_talk");

    level.teamleader dialogue_execute("dcburn_mcy_forgetaboutit");
    flag_set("can_talk");

    if(flag("player_getting_on_minigun")) {
      break;
    }

    wait(30);

    if(flag("player_getting_on_minigun")) {
      break;
    }

    flag_clear("can_talk");

    level.teamleader dialogue_execute("dcburn_mcy_brassontitanic");
    flag_set("can_talk");

    if(flag("player_getting_on_minigun")) {
      break;
    }

    wait(30);

    if(flag("player_getting_on_minigun")) {
      break;
    }
  }
}

AI_awesome_accuracy_untill_flag(sFlag) {
  self endon("death");
  if(!isDefined(self)) {
    return;
  }
  self.old_baseaccuracy = self.baseaccuracy;
  self.baseaccuracy = 1000;

  flag_wait(sFlag);

  if(isDefined(self)) {
    self.baseaccuracy = self.old_baseaccuracy;
  }
}

AI_roof_defenders_think() {
  self endon("death");
  self thread try_to_magic_bullet_shield();
  self.neverEnableCQB = true;

  self.goalradius = 16;
  self.baseaccuracy = 1000;
  self.attackeraccuracy = 0;

  flag_wait("player_getting_on_minigun");

  self.health = 1;
  self.baseaccuracy = .01;
  self.attackeraccuracy = 10;
  self thread stop_magic_bullet_shield();
}

AAA_sequence_heli_ride() {
  flag_wait("player_headed_to_roof");

  level.AIdeleteExcluders = [];
  spawner = getent("rooftop_helirider", "targetname");
  rooftop_helirider = spawner spawn_ai();
  if(isDefined(rooftop_helirider)) {
    rooftop_helirider thread AI_rooftop_helirider_think();
  }

  spawner = getent("rooftop_defender", "targetname");
  defender = spawner spawn_ai();
  if(isDefined(defender)) {
    defender thread AI_roof_defenders_think();
  }

  turret2 = getent("turret2", "targetname");
  if(isDefined(turret2)) {
    turret2 delete();
  }

  triggersEnable("colornodes_roof", "script_noteworthy", true);

  allied_drones_heliride_01 = getEntArray("allied_drones_heliride_01", "targetname");
  allied_drones_heliride_02 = getEntArray("allied_drones_heliride_02", "targetname");
  allied_drones_heliride_03 = getEntArray("allied_drones_heliride_03", "targetname");
  allied_drones_heliride_03 = getEntArray("allied_drones_heliride_04", "targetname");
  thread drone_flood_start(allied_drones_heliride_01, "allied_drones_heliride_01");
  thread drone_flood_start(allied_drones_heliride_02, "allied_drones_heliride_02");
  thread drone_flood_start(allied_drones_heliride_03, "allied_drones_heliride_03");
  thread drone_flood_start(allied_drones_heliride_03, "allied_drones_heliride_04");

  player_blackhawk_setup();
  level.blackhawk Vehicle_SetSpeed(5);
  heli_roof_approach_01_end = getent("heli_roof_approach_01_end", "targetname");
  level.blackhawk SetLookAtEnt(heli_roof_approach_01_end);

  flag_wait("roof_littlebird_lifted_off");
  level.blackhawk clearlookatent();
  heli_roof_approach_01 = getent("heli_roof_approach_01", "targetname");
  level.blackhawk thread vehicle_paths(heli_roof_approach_01);
  level.blackhawk Vehicle_SetSpeed(100);
  level.blackhawk thread vehicle_heli_land(getent("heli_roof_land_01", "script_noteworthy"));
  level.blackhawk waittill("landed");
  flag_set("blackhawk_landed");

  trigger_origin = level.blackhawk gettagorigin("tag_player");
  trigger_radius = 160;
  trigger_height = 100;
  trigger_spawnflags = 0;
  triggerApproach = spawn("trigger_radius", trigger_origin, trigger_spawnflags, trigger_radius, trigger_height);
  thread team_leader_gets_on_blackhawk(triggerApproach);

  trigger_origin = level.blackhawk gettagorigin("tag_player");
  trigger_radius = 40;
  trigger_height = 100;
  trigger_spawnflags = 0;
  level.blackhawk.trigger = spawn("trigger_radius", trigger_origin, trigger_spawnflags, trigger_radius, trigger_height);

  balackHawkOrigin = level.blackhawk gettagorigin("TAG_ORIGIN");
  while(true) {
    level.blackhawk.trigger waittill("trigger");
    if(within_fov(level.player getEye(), level.player getPlayerAngles(), balackHawkOrigin, level.cosine["90"])) {
      break;
    }
  }

  flag_set("player_getting_on_minigun");

  if(getdvarint("r_dcburning_culldist") == 1) {
    setculldist(20000);
  }

  flag_set("obj_heli_mount_complete");

  thread player_blackhawk_health_tweaks();

  maps\_friendlyfire::TurnOff();
  level.disable_destructible_bad_places = true;

  killSpawner(7);
  killSpawner(8);
  killSpawner(10);

  volume_roof = getent("volume_roof", "targetname");
  aAI_to_delete = volume_roof get_ai_touching_volume("axis");
  array_thread(aAI_to_delete, ::AI_delete);
  delaythread(1.5, ::delete_squad);

  roof_seaknight_01 = getent("roof_seaknight_01", "targetname");
  roof_seaknight_02 = getent("roof_seaknight_02", "targetname");
  roof_seaknight_01 notify("spawn");
  roof_seaknight_02 notify("spawn");

  roof_seaknight_01 thread notify_delay("play_anim", 1);
  roof_seaknight_02 thread notify_delay("play_anim", 1);

  player_lerped_onto_minigun();
  music_stop(5);
  flag_wait("roof_heli_about_to_be_owned");
  flag_set("player_heli_ready_to_take_off");

  thread autosave_by_name("heli_ride_01");

  ww2_heli = spawn_vehicle_from_targetname("ww2_heli");

  path_player_heli = getstruct("path_player_heli", "targetname");
  level.blackhawk vehicle_liftoff(76);
  level.blackhawk player_blackhawk_default_params();
  level.blackhawk thread player_blackhawk_default_params();
  level.blackhawk thread vehicle_paths(path_player_heli);

  abrams_street = getent("abrams_street", "targetname");
  abrams_street delete();
  m1a1_heliride_01 = spawn_vehicle_from_targetname_and_drive("m1a1_heliride_01");
  m1a1_heliride_02 = spawn_vehicle_from_targetname_and_drive("m1a1_heliride_02");
  javelin_source_org = getent(m1a1_heliride_01.script_linkto, "script_linkname");
  newMissile = MagicBullet("javelin_dcburn", javelin_source_org.origin, m1a1_heliride_01.origin);
  newMissile thread javelin_earthquake();
  newMissile Missile_SetTargetEnt(m1a1_heliride_01);
  newMissile Missile_SetFlightmodeTop();

  humvee_heliride_01 = spawn_vehicle_from_targetname("humvee_heliride_01");

  flag_wait("player_heli_02");
  level.blackhawk Vehicle_SetSpeed(75);
  level.littlebird_wingman_02 vehicle_setSpeed(70);

  array_thread(level.effects_commerce, ::pauseEffect);
  array_thread(level.effects_bunker, ::pauseEffect);

  eNode = getstruct("helipath_to_ww2_littlebird_wingman_armed", "targetname");
  sSpawnerTargetname = "littlebird_wingman_armed";
  level.littlebird_wingman_armed = level.littlebird_wingman_armed heli_teleport_to_newpath(sSpawnerTargetname, eNode);
  level.littlebird_wingman_armed Vehicle_SetSpeed(100);

  level.littlebird_wingman_02 vehicle_delete();
  level.littlebird_wingman_02 = spawn_vehicle_from_targetname_and_drive("littlebird_wingman_02_drone_roof");

  eNode = getstruct("helipath_to_ww2_littlebird_wingman_01", "targetname");
  sSpawnerTargetname = "littlebird_wingman_01";
  level.littlebird_wingman_01 = level.littlebird_wingman_01 heli_teleport_to_newpath(sSpawnerTargetname, eNode);
  level.littlebird_wingman_01 Vehicle_SetSpeed(55);

  axis_ww2_drones_01 = getEntArray("axis_ww2_drones_01", "targetname");
  axis_ww2_drones_02 = getEntArray("axis_ww2_drones_02", "targetname");
  axis_ww2_drones_03 = getEntArray("axis_ww2_drones_03", "targetname");
  axis_ww2_drones_04 = getEntArray("axis_ww2_drones_04", "targetname");
  thread drone_flood_start(axis_ww2_drones_01, "axis_ww2_drones_01");
  thread drone_flood_start(axis_ww2_drones_02, "axis_ww2_drones_02");
  thread drone_flood_start(axis_ww2_drones_03, "axis_ww2_drones_03");
  thread drone_flood_start(axis_ww2_drones_04, "axis_ww2_drones_04");

  waittillframeend;
  aAI = getaiarray();
  assertex(level.littlebird_wingman_02.riders.size > 0, "the riders for level.littlebird_wingman_02 are not in level.littlebird_wingman_02.riders");
  excluders = level.littlebird_wingman_02.riders;
  array_thread(aAI, ::AI_delete, excluders);

  activate_trigger("spawner_ww2_guys", "targetname", level.player);
  spawn_trigger_dummy("dummy_spawner_ww2_street_guys");

  level.noMaxMortarDist = true;
  level.playerMortarFovOffset = (0, 40, 0);
  level._effect["mortar"]["dirt"] = loadfx("explosions/artilleryExp_dirt_brown_2");
  delaythread(3, maps\_mortar::bog_style_mortar_on, 2);

  flag_wait("player_heli_03a");
  newMissile = MagicBullet("javelin_dcburn", javelin_source_org.origin, humvee_heliride_01.origin);
  newMissile thread javelin_earthquake();
  newMissile Missile_SetTargetEnt(humvee_heliride_01);
  newMissile Missile_SetFlightmodeTop();

  sam_launch_ww2 = getstruct("sam_launch_ww2", "targetname");
  delaythread(1.5, ::sam_launch, 8, sam_launch_ww2, level.littlebird_wingman_02);

  flag_wait("player_heli_05");
  level.blackhawk Vehicle_SetSpeed(90);
  thread gopath(humvee_heliride_01);
  level.littlebird_wingman_01 Vehicle_SetSpeed(100);
  level.littlebird_wingman_02 Vehicle_SetSpeed(100);

  level.littlebird_wingman_armed Vehicle_SetSpeed(150);

  javelin_littlebird_monument = getstruct("javelin_littlebird_monument", "targetname");
  newMissile2 = MagicBullet("javelin_dcburn", javelin_littlebird_monument.origin, level.littlebird_wingman_02.origin);
  newMissile2 Missile_SetTargetEnt(level.littlebird_wingman_02);
  littlebird_monument_crash = getstruct("littlebird_monument_crash", "targetname");
  level.littlebird_wingman_02 thread maps\dcburning_fx::littlebird_monument_crash(littlebird_monument_crash);

  eNode = getstruct("helipath_to_ww2_strafing_littlebird_wingman_armed", "targetname");
  sSpawnerTargetname = "littlebird_wingman_armed";
  level.littlebird_wingman_armed = level.littlebird_wingman_armed heli_teleport_to_newpath(sSpawnerTargetname, eNode);
  level.littlebird_wingman_armed Vehicle_SetSpeed(90);

  flag_wait("player_heli_06");
  thread drone_flood_stop("allied_drones_heliride_01");
  thread drone_flood_stop("allied_drones_heliride_02");
  thread drone_flood_stop("allied_drones_heliride_03");
  thread drone_flood_stop("allied_drones_heliride_04");

  flag_wait("player_heli_10");
  level.player.ignoreme = true;
  level.blackhawk Vehicle_SetSpeed(25);
  activate_trigger("spawner_ww2_guys_middle", "targetname", level.player);
  level.littlebird_wingman_armed Vehicle_SetSpeed(120);

  flag_wait("player_heli_10a");
  level.createRpgRepulsors = false;

  bmps_heli_ride_ww2_02 = spawn_vehicles_from_targetname_and_drive("bmps_heli_ride_ww2_02");
  activate_trigger("spawner_ww2_guys_end", "targetname", level.player);

  flag_wait("player_heli_10b");

  level.player.ignoreme = false;

  flag_wait("player_heli_10c");

  array_thread(level.effects_trenches, ::pauseEffect);

  if(isDefined(ww2_heli)) {
    ww2_heli thread notify_delay("liftoff", 3);
  }

  flag_wait("player_heli_14");

  wait(.5);
  level.blackhawk Vehicle_SetSpeed(50);

  crows_nest_bmps = get_vehicle_array("crows_nest_bmps", "script_noteworthy");
  foreach(vehicle in crows_nest_bmps) {
    if(isDefined(vehicle)) {
      vehicle maps\_vehicle::godoff();
      vehicle vehicle_delete();
    }
  }

  flag_wait("player_heli_15");
  level.blackhawk Vehicle_SetSpeed(30);
  killspawner(11);
  thread drone_flood_stop("axis_ww2_drones_01");
  thread drone_flood_stop("axis_ww2_drones_02");
  thread drone_flood_stop("axis_ww2_drones_03");
  thread drone_flood_stop("axis_ww2_drones_04");

  flag_wait("player_heli_16");
  level.blackhawk Vehicle_SetSpeed(20);
}

sam_launch(iNum, sourceEnt, destEnt) {
  destEnt endon("death");
  targetOffset = (0, 0, 250);
  targetOrg = spawn("script_origin", destEnt.origin);
  destEnt thread delete_on_death(targetOrg);
  targetOrg.origin = destEnt.origin;
  targetOrg.angles = destEnt.angles;
  targetOrg linkTo(destEnt, "tag_origin", targetOffset, (0, 0, 0));
  targetOrg thread ent_cleanup(destEnt);
  attractor = Missile_CreateAttractorEnt(targetOrg, 8000, 3000);

  while(iNum > 0) {
    magicBullet("slamraam_missile_dcburning", sourceEnt.origin, destEnt.origin);
    wait(.25);
    iNum--;
  }

  if(isDefined(targetOrg)) {
    targetOrg delete();
  }
}

delete_squad() {
  array_thread(level.squad, ::AI_delete);
}

team_leader_gets_on_blackhawk(triggerApproach) {
  level.teamleader endon("death");
  wait(2);
  animEnt = spawn("script_origin", level.blackhawk.origin);
  animEnt.origin = level.blackhawk.origin;
  animEnt.angles = level.blackhawk.angles;

  ent = spawnStruct();
  ent.entity = animEnt;
  ent.up = -100;
  ent.right = -72;
  ent.forward = -50;
  ent.yaw = 180;
  ent translate_local();
  animEnt linkto(level.blackhawk);

  level.teamleader notify("stop_teleport_hack");

  animEnt anim_generic_reach(level.teamleader, "leader_blackhawk_getin");
  level.teamleader setGoalPos(level.teamleader.origin);
  level.teamleader.goalradius = 16;

  triggerApproach waittill("trigger");

  animEnt anim_generic_reach(level.teamleader, "leader_blackhawk_getin");
  level.teamleader linkto(animEnt);
  animEnt anim_generic(level.teamleader, "leader_blackhawk_getin");
  animEnt thread anim_generic_loop(level.teamleader, "leader_blackhawk_idle", "stop_idle");
}

AI_rooftop_helirider_think() {
  self endon("death");

  self thread try_to_magic_bullet_shield();
  self.neverEnableCQB = true;

  self.goalradius = 16;
  self.baseaccuracy = 1000;
  self.attackeraccuracy = 0;

  flag_wait("blackhawk_landed");

  wait(1);
  animEnt = spawn("script_origin", level.blackhawk.origin);
  animEnt.origin = level.blackhawk.origin;
  animEnt.angles = level.blackhawk.angles;

  ent = spawnStruct();
  ent.entity = animEnt;
  ent.up = -100;
  ent.right = 78;
  ent.forward = 21;

  ent translate_local();
  animEnt linkto(level.blackhawk);

  animEnt anim_generic_reach(self, "redshirt_blackhawk_getin");
  self linkto(animEnt);
  animEnt anim_generic(self, "redshirt_blackhawk_getin");
  animEnt thread anim_generic_loop(self, "redshirt_blackhawk_idle", "stop_idle");
}

player_lerped_onto_minigun(nolerp) {
  level.player allowcrouch(false);
  level.player allowprone(false);
  level.player allowsprint(false);
  level.player allowjump(false);
  level.blackhawk maps\_blackhawk_minigun::player_mount_blackhawk_gun(nolerp);
  level.onHeli = true;
}

try_to_teleport_friendlies_to_roof(eNode) {
  assert(isDefined(eNode));

  level endon("player_getting_on_minigun");
  self endon("death");
  self endon("stop_teleport_hack");
  fDistSquared = 300 * 300;
  while(isDefined(self)) {
    wait(.1);
    if(distancesquared(level.player.origin, self.origin) < fDistSquared) {
      continue;
    }
    playerEye = level.player getEye();
    if(within_fov(playerEye, level.player.angles, self.origin + (0, 0, 32), level.cosine["90"])) {
      continue;
    } else {
      break;
    }
  }
  self forceTeleport(eNode.origin, eNode.angles);
  self notify("end_melee");
  self disable_ai_color();
  self setgoalnode(eNode);
}

player_blackhawk_setup(heliNode) {
  level.blackhawk = spawn_vehicle_from_targetname_and_drive("heli_player");
  level.blackhawk thread player_blackhawk_think();
  if(isDefined(heliNode)) {
    level.blackhawk Vehicle_Teleport(heliNode.origin, heliNode.angles);
    level.blackhawk thread vehicle_paths(heliNode);

    level.blackhawk useby(level.player);
    level.blackhawk player_blackhawk_default_params();
  }
}

player_blackhawk_default_params() {
  level.blackhawk cleargoalyaw();
  level.blackhawk Vehicle_SetSpeed(30);
  level.blackhawk sethoverparams(32, 10, 3);
  level.blackhawk setmaxpitchroll(5, 10);
}

vehicle_ww2_enemy_helis_think() {
  self endon("death");

  aCrashLocations = maps\_vehicle::get_unused_crash_locations();
  eCrashLoc = getClosest(self.origin, aCrashLocations);
  eCrashLoc.origin = self.origin;
  self.perferred_crash_location = eCrashLoc;

  self waittill("liftoff");
  self thread ground_heli_kill_player();
  ePath = getstruct(self.script_Linkto, "script_linkname");
  dist = distance(self.origin, ePath.origin);
  self Vehicle_SetSpeed(10);
  self vehicle_liftoff(dist);
  self Vehicle_SetSpeed(50);
  self thread vehicle_paths(ePath);
}

ground_heli_kill_player() {
  self endon("death");
  level.player endon("death");
  self ent_flag_init("stop_firing");
  while((isalive(self)) && (!ent_flag("stop_firing"))) {
    wait(.5);
    self SetLookAtEnt(level.player);
    if(!within_fov(self.origin, self.angles, level.player.origin + (0, 0, 32), level.cosine["35"])) {
      self notify("stop_firing_turret");
      continue;
    }

    self thread vehicle_heli_fire_turret(level.player);
  }
  self notify("stop_firing_turret");
  self clearLookAtEnt();
}

heli_at4_sequence() {
  flag_wait("player_getting_on_minigun");

  spawner = getent("roof_rocket_guy", "targetname");
  roof_rocket_guy = spawner spawn_ai(true);
  roof_rocket_guy thread AI_ignored_and_oblivious_on();
  roof_rocket_guy thread try_to_magic_bullet_shield();
  reference = spawner;
  reference anim_generic_first_frame(roof_rocket_guy, roof_rocket_guy.animation);
  roof_rocket_guy attach("weapon_stinger", "TAG_INHAND");
  reference thread anim_generic(roof_rocket_guy, roof_rocket_guy.animation);
  roof_rocket_guy setAnimTime(level.scr_anim["generic"][roof_rocket_guy.animation], .6);

  heli_roof = spawn_vehicle_from_targetname_and_drive("heli_roof");
  heli_roof thread heli_roof_think();
  heli_roof SetLookAtEnt(level.player);
  org = spawn("script_origin", heli_roof.origin + (0, 0, -20));
  org linkto(heli_roof);
  org thread ent_cleanup(heli_roof);
  attractor = Missile_CreateAttractorEnt(org, 2000, 10000, roof_rocket_guy);

  roof_rocket_guy waittillmatch("single anim", "fire");
  earthquake(.3, .5, level.player.origin, 1600);
  org_hand = roof_rocket_guy gettagorigin("TAG_INHAND");
  magicbullet("stinger", org_hand, org.origin);
  flag_set("roof_heli_about_to_be_owned");
  heli_roof thread heli_roof_death_failsafe();

  roof_rocket_guy waittillmatch("single anim", "end");
  org_hand = roof_rocket_guy gettagorigin("TAG_INHAND");
  angles_hand = roof_rocket_guy gettagangles("TAG_INHAND");
  roof_rocket_guy detach("weapon_stinger", "TAG_INHAND");
  model_at4 = spawn("script_model", org_hand);
  model_at4 setModel("weapon_stinger");
  roof_rocket_guy thread delete_on_death(model_at4);
  model_at4.angles = angles_hand;

  eNode = getnode("at4_guy_retreat", "targetname");
  roof_rocket_guy setgoalnode(eNode);
  roof_rocket_guy thread stop_magic_bullet_shield();
  roof_rocket_guy thread AI_ignored_and_oblivious_off();
  roof_rocket_guy.health = 1;
}

heli_roof_think() {
  self.immuneToBlackhawk = true;
  self waittill("death");
  flag_set("roof_heli_owned");
  earthquake(0.6, 1.2, level.player.origin, 1600);
  level.player PlayRumbleOnEntity("damage_heavy");
}

heli_roof_death_failsafe() {
  self endon("death");
  wait(1.8);
  self notify("damage", 5000, level.player, undefined, undefined, "MOD_PROJECTILE");
}

player_blackhawk_think() {
  flag_set("player_heli_spawned");
  self maps\_vehicle::godon();
}

littlebird_wingman_02_think() {
  flag_wait("player_approaching_outer_balcony");

  aRoof_riders_left = array_spawn(getEntArray("littlebird_roof_riders_left", "targetname"));
  array_thread(aRoof_riders_left, ::AI_ignored_and_oblivious_on);
  array_thread(aRoof_riders_left, ::magic_bullet_shield);
  aRoof_riders_right = array_spawn(getEntArray("littlebird_roof_riders_right", "targetname"));
  array_thread(aRoof_riders_right, ::AI_ignored_and_oblivious_on);
  array_thread(aRoof_riders_right, ::magic_bullet_shield);
  level.littlebird_wingman_02 = spawn_vehicle_from_targetname("littlebird_wingman_02");
  level.littlebird_wingman_02 thread gopath();

  pickup_node_before_stage = getstruct("pickup_node_before_stage", "script_noteworthy");
  level.littlebird_wingman_02 set_stage(pickup_node_before_stage, aRoof_riders_left, "left");
  level.littlebird_wingman_02 set_stage(pickup_node_before_stage, aRoof_riders_right, "right");

  level.littlebird_wingman_02 waittill("touch_down");

  level.littlebird_wingman_02 thread load_side("left", aRoof_riders_left);
  level.littlebird_wingman_02 thread load_side("right", aRoof_riders_right);

  flag_wait("player_approach_commerce_roof_01");
  level.littlebird_wingman_01 = spawn_vehicle_from_targetname("littlebird_wingman_01");
  level.littlebird_wingman_01 thread vehicle_ai_event("idle_alert_to_casual");
  thread gopath(level.littlebird_wingman_01);

  while(level.littlebird_wingman_02.riders.size < 6) {
    wait(.1);
  }

  thread flag_set("roof_littlebird_lifted_off");

  level.littlebird_wingman_02 thread vehicle_liftoff(3);

  heli_roof_loop_01 = getstruct("heli_roof_loop_01", "targetname");
  wait(1);
  level.littlebird_wingman_02 thread vehicle_paths(heli_roof_loop_01);
  level.littlebird_wingman_02 setmaxpitchroll(20, 50);
  wait(2);
  level.littlebird_wingman_02 vehicle_ai_event("idle_alert_to_casual");
  level.littlebird_wingman_02 Vehicle_SetSpeed(25);
}

littlebird_wingman_armed_think() {
  flag_wait("player_approach_commerce_roof_02");

  level.littlebird_wingman_armed = spawn_vehicle_from_targetname_and_drive("littlebird_wingman_armed");
  level.littlebird_wingman_armed Vehicle_SetSpeed(25);

  wingman_roof_node_01 = getstruct("wingman_roof_node_01", "script_noteworthy");
  wingman_roof_node_01 waittill("trigger");

  roof_target_for_helis = getent("roof_target_for_helis", "targetname");
  level.littlebird_wingman_armed SetLookAtEnt(roof_target_for_helis);
  level.littlebird_wingman_armed Vehicle_SetSpeed(10);

  waittillframeend;
  foreach(turret in level.littlebird_wingman_armed.mgturret) {
    turret SetMode("auto_nonai");
  }

  flag_wait("player_getting_on_minigun");

  foreach(turret in level.littlebird_wingman_armed.mgturret) {
    turret SetMode("manual");
    turret StopFiring();
  }
}

AA_heli_ride2() {
  thread AAA_sequence_heli_ride2();
  thread dialogue_heli_ride2();

  flag_wait("player_crash_starting");
  thread maps\dc_crashsite::AA_crash_site_init();

  flag_wait("player_crash_done");
  level.player setViewmodel("viewhands_us_army_dmg");
}

dialogue_heli_ride2() {
  flag_wait("player_heli_18a");

  radio_dialogue_overlap("dcburn_bhp_incoming");

  flag_wait("player_heli_18d");

  radio_dialogue("dcburn_mcy_stillintheair");

  flag_wait("player_heli_19");

  radio_dialogue("dcburn_bhp_attitudecontrol");

  radio_dialogue("dcburn_mcy_takeusup");

  flag_wait("player_heli_20");

  radio_dialogue("dcburn_lbp1_samlaunch");

  flag_wait("player_crash_starting");
  wait(.3);

  soundOrg = spawn_tag_origin();
  soundOrg linkTo(level.player);
  soundOrg thread play_sound_on_tag_endon_death("dcburn_lbp1_maydaymayday", "tag_origin");

  flag_wait("player_heli_crash");
  soundOrg notify("death");
  soundOrg delete();
}

AAA_sequence_heli_ride2() {
  flag_wait("player_heli_18");
  thread autosave_now();

  level.blackhawk Vehicle_SetSpeed(70);

  if(isDefined(level.littlebird_wingman_armed)) {
    level.littlebird_wingman_armed vehicle_delete();
  }
  if(isDefined(level.littlebird_wingman_01)) {
    level.littlebird_wingman_01 vehicle_delete();
  }
  if(isDefined(level.littlebird_wingman_02)) {
    level.littlebird_wingman_02 vehicle_delete();
  }

  vehicles_to_delete = getEntArray("vehicles_crowsnest_defend", "targetname");
  foreach(vehicle in vehicles_to_delete) {
    if(isDefined(vehicle)) {
      vehicle delete();
    }
  }

  littlebird_wingman_02_drone_crash = spawn_vehicle_from_targetname_and_drive("littlebird_wingman_02_drone_crash");
  littlebird_wingman_02_drone_crash Vehicle_SetSpeed(70);

  targetOffset = (0, 0, 250);
  targetOrg = spawn("script_origin", littlebird_wingman_02_drone_crash.origin);
  targetOrg.origin = littlebird_wingman_02_drone_crash.origin;
  targetOrg.angles = littlebird_wingman_02_drone_crash.angles;
  targetOrg linkTo(littlebird_wingman_02_drone_crash, "tag_origin", targetOffset, (0, 0, 0));
  targetOrg thread ent_cleanup(littlebird_wingman_02_drone_crash);
  attractor = Missile_CreateAttractorEnt(targetOrg, 8000, 3000);

  missile_org_lincoln = getent("missile_org_lincoln", "targetname");

  eMissile1 = magicBullet("slamraam_missile_dcburning", missile_org_lincoln.origin, targetOrg.origin);
  wait(.5);
  eMissile2 = magicBullet("slamraam_missile_dcburning", missile_org_lincoln.origin, targetOrg.origin);
  wait(.5);
  eMissile3 = magicBullet("slamraam_missile_dcburning", missile_org_lincoln.origin, targetOrg.origin);
  wait(.5);
  eMissile4 = magicBullet("slamraam_missile_dcburning", missile_org_lincoln.origin, targetOrg.origin);
  wait(.5);
  eMissile5 = magicBullet("slamraam_missile_dcburning", missile_org_lincoln.origin, targetOrg.origin);

  newMissile2 = MagicBullet("javelin_dcburn", missile_org_lincoln.origin, littlebird_wingman_02_drone_crash.origin);
  newMissile2 Missile_SetTargetEnt(littlebird_wingman_02_drone_crash);
  littlebird_crash_ww2 = getstruct("littlebird_crash_ww2", "targetname");
  littlebird_wingman_02_drone_crash thread maps\dcburning_fx::littlebird_monument_crash(littlebird_crash_ww2);

  flag_wait("player_heli_18b");
  wait(2);
  earthquake(.5, 1.5, level.player.origin, 1600);

  level.blackhawk thread play_sound_in_space("blackhawk_down_missile_impact");
  level.player thread play_sound_in_space("blackhawk_helicopter_secondary_exp");
  playFX(level._effect["player_death_explosion"], level.player.origin + (0, 0, 50));
  level.player PlayRumbleOnEntity("damage_heavy");
  level.player dodamage(10, level.player.origin);
  thread player_heli_damaged_think();
  thread player_heli_damaged_earthquake();
  level.player thread play_loop_sound_on_entity("dcburning_heli_alarm");

  SetBlur(3, .1);
  level.blackhawk thread blackhawk_smoke_fx();
  wait(.5);

  SetBlur(1, .6);

  flag_wait("player_heli_18d");
  level.blackhawk Vehicle_SetSpeed(25, 60, 60);
  array_thread(level.effects_ww2, ::pauseEffect);
  thread AI_drone_cleanup("axis", undefined, true);
  thread AI_cleanup("axis", undefined, true);

  aSpawners = getEntArray("axis_window_drones_01", "targetname");
  thread drone_flood_start(aSpawners, "axis_window_drones_01");
  aSpawners = getEntArray("axis_window_drones_02", "targetname");
  thread drone_flood_start(aSpawners, "axis_window_drones_02");
  activate_trigger("spawner_enemies_glass_02", "targetname", level.player);
  activate_trigger("spawner_enemies_glass_03", "targetname", level.player);

  aSpawners = getEntArray("axis_lincoln_drones_01", "targetname");
  thread drone_flood_start(aSpawners, "axis_lincoln_drones_01");
  aSpawners = getEntArray("axis_lincoln_drones_02", "targetname");
  thread drone_flood_start(aSpawners, "axis_lincoln_drones_02");
  aSpawners = getEntArray("axis_lincoln_drones_03", "targetname");
  thread drone_flood_start(aSpawners, "axis_lincoln_drones_03");
  aSpawners = getEntArray("axis_lincoln_drones_04", "targetname");
  thread drone_flood_start(aSpawners, "axis_lincoln_drones_04");

  flag_wait("player_heli_19a");
  vehicle_delete_non_squad();
  thread AI_cleanup_volume("volume_enemies_glass_02", "axis");
  thread drone_flood_stop("axis_window_drones_01");
  activate_trigger("spawner_enemies_glass_04", "targetname", level.player);

  flag_wait("player_heli_19b");
  thread AI_cleanup_volume("volume_enemies_glass_03", "axis");

  flag_wait("player_heli_19c");

  littlebird_wingman_armed_lincoln = spawn_vehicle_from_targetname_and_drive("littlebird_wingman_armed_lincoln");
  littlebird_wingman_armed_lincoln Vehicle_SetSpeed(90);

  thread AI_cleanup_volume("volume_enemies_glass_04a", "axis");
  thread AI_cleanup_volume("volume_enemies_glass_04", "axis");
  activate_trigger("spawner_enemies_balcony_01", "targetname", level.player);
  slamraam_lincoln = spawn_vehicles_from_targetname("slamraam_lincoln");
  activate_trigger("spawner_axis_lincoln_01", "targetname", level.player);

  flag_wait("player_heli_19d");
  level.blackhawk Vehicle_SetSpeed(80, 20, 20);

  flag_wait("player_heli_20");
  slamraam_lincoln = get_array_of_closest(level.player.origin, slamraam_lincoln);
  delay = 0;
  foreach(slamraam in slamraam_lincoln) {
    if(isDefined(slamraam)) {
      slamraam thread notify_delay("fire", delay);
      delay = delay + .25;
    }
  }

  flag_wait("player_heli_21");
  slamraam_lincoln = get_array_of_closest(level.player.origin, slamraam_lincoln);
  delay = 0;
  foreach(slamraam in slamraam_lincoln) {
    if(isDefined(slamraam)) {
      slamraam thread notify_delay("fire", delay);
      delay = delay + .25;
    }
  }

  flag_wait("player_heli_22");
  drone_flood_stop("axis_lincoln_drones_01");
  drone_flood_stop("axis_lincoln_drones_02");
  drone_flood_stop("axis_lincoln_drones_03");
  drone_flood_stop("axis_lincoln_drones_04");

  flag_set("player_crash_starting");
  level.blackhawk thread play_sound_in_space("blackhawk_down_missile_impact");
  level.player thread play_sound_in_space("blackhawk_helicopter_hit");
  level.blackhawk Vehicle_TurnEngineOff();
  level.blackhawk thread play_loop_sound_on_entity("blackhawk_helicopter_dying_loop");

  level.blackhawk Vehicle_SetSpeed(150, 50, 50);
  playFX(level._effect["player_death_explosion"], level.player.origin);
  level.player PlayRumbleOnEntity("damage_heavy");
  level.blackhawk useby(level.player);
  level.player unlink();
  level.player disableWeapons();
  level.blackhawk MakeUnusable();
  flag_clear("player_on_minigun");
  flag_set("player_off_minigun");
  level notify("player_off_blackhawk_gun");

  level.player playerLinkToBlend(level.blackhawk, "tag_player", .5);

  level.player playerlinkToDelta(level.blackhawk, "tag_player", 1, 20, 20, 10, 10);
  SetBlur(3, .1);
  level.blackhawk thread player_crash_fx();
  earthquake(.7, 2.5, level.player.origin, 1600);
  level.blackhawk thread player_spinout();
  wait 1;

  flavorbursts_off("allies");
  SetBlur(0, .5);

  thread AI_cleanup("all", undefined, true);
  thread AI_drone_cleanup("axis", undefined, true);

  flag_wait("player_heli_crash");

  earthquake(.7, 2.5, level.player.origin, 1600);
  playFX(level._effect["player_death_explosion"], level.player.origin);
  level.player PlayRumbleOnEntity("damage_heavy");
  level.player notify("stop sound" + "dcburning_heli_alarm");
  level.blackhawk notify("stop sound" + "blackhawk_helicopter_dying_loop");
  wait(.1);
  level.player thread play_sound_on_entity("blackhawk_helicopter_crash");
  littlebird_wingman_armed_lincoln vehicle_delete();
  wait(.3);
  music_stop();
  SetBlur(3, .1);
  level.black_overlay = create_client_overlay("black", 1);
  level.player unlink();
  wait(.1);
  level.blackhawk vehicle_delete();

  wait(2);

  SetBlur(0, .5);
  flag_set("player_crash_done");
  level.player SetActionSlot(1, "nightvision");

  if(GetDvarInt("sm_enable") && getDvar("r_zfeather") != "0") {
    level._effect["_attack_heli_spotlight"] = LoadFX("misc/hunted_spotlight_model_dim");
  } else {
    level._effect["_attack_heli_spotlight"] = LoadFX("misc/spotlight_large");
  }
}

player_heli_damaged_think() {
  dummy = spawn_tag_origin();
  dummy linkto(level.blackhawk, "tag_guy5", (0, 0, 0), (0, 0, 0));
  while(!flag("player_crash_done")) {
    playFXOnTag(getfx("dlight_red"), dummy, "tag_origin");
    wait(1);
    stopFXOnTag(getfx("dlight_red"), dummy, "tag_origin");
    wait(.5);
  }
  dummy unlink();
  dummy delete();
}

player_heli_damaged_earthquake() {
  while(!flag("player_crash_starting")) {
    earthquake(.1, .05, level.player.origin, 80000);
    wait(.05);
  }
}

blackhawk_smoke_fx() {
  self endon("death");
  for(;;) {
    playFXOnTag(getfx("smoke_trail_black_heli"), level.blackhawk, "tag_gun_r");

    wait .05;
  }
}

player_crash_fx() {
  while(!flag("player_heli_crash")) {
    playFXOnTag(getfx("heat_shimmer_door"), self, "tag_player");
    wait(.1);
  }
}

player_spinout() {
  self SetMaxPitchRoll(50, 100);
  self setturningability(1);
  yawspeed = 1400;
  yawaccel = 200;
  targetyaw = undefined;

  while(isDefined(self)) {
    targetyaw = self.angles[1] + 100;
    self setyawspeed(yawspeed, yawaccel);
    self settargetyaw(targetyaw);
    wait 0.1;
  }
}

AI_ambush_behavior() {
  if(!issentient(self)) {
    return;
  }
  self.combatMode = "ambush";
}

AI_hummer_gunner_think() {
  self endon("death");
  self thread magic_bullet_shield();
  self.ignoreme = true;
  self.ignoreall = true;
  self.maxsightdistsqrd = 0;

  wait(0.2);
}

AI_glass_building_enemies_think() {
  self.interval = 0;
  self.neverEnableCQB = true;
  self.grenadeawareness = 0;
  self.ignoresuppression = true;
  self.aggressivemode = true;
}

obj_follow_sgt_macey() {
  flag_wait("obj_follow_sgt_macey_given");
  objective_number = 1;
  obj_position = level.teamleader;
  objective_add(objective_number, "active", &"DCBURNING_OBJ_FOLLOW_SGT_MACEY");
  objective_current(objective_number);
  Objective_OnEntity(objective_number, level.teamleader, (0, 0, 70));
  flag_wait("obj_follow_sgt_macey_complete");
  objective_state(objective_number, "done");
}

obj_commerce() {
  flag_wait("obj_commerce_given");
  objective_number = 2;
  obj_position = getstruct("obj_commerce_sector_1", "targetname");

  objective_add(objective_number, "active", &"DCBURNING_OBJ_COMMERCE");
  objective_current(objective_number);
  Objective_OnEntity(objective_number, level.teamleader, (0, 0, 70));

  flag_wait("player_around_corner_to_crows_nest");

  objective_position(objective_number, (0, 0, 0));
  obj_position = getstruct("obj_commerce_sector_3", "targetname");
  Objective_Position(objective_number, obj_position.origin);

  flag_wait("obj_commerce_complete");

  objective_state(objective_number, "done");
}

obj_commerce_defend_snipe() {
  flag_wait("obj_commerce_defend_snipe_given");
  objective_number = 3;
  obj_position = getstruct("obj_commerce_defend_snipe", "targetname");

  objective_add(objective_number, "active", &"DCBURNING_OBJ_COMMERCE_DEFEND_SNIPE", obj_position.origin);
  objective_current(objective_number);

  flag_wait("obj_commerce_defend_snipe_complete");

  objective_state(objective_number, "done");
}

obj_commerce_defend_snipe_enemies_think() {
  level endon("obj_commerce_defend_snipe_complete");
  self waittill("death");
  level.lasttimePlayerKilledEnemy = getTime();

  level.snipeEnemies = (level.snipeEnemies - 1);

  if(level.snipeEnemies < 3) {
    flag_set("only_2_sniper_enemies_remaining");
  }
  if(level.snipeEnemies == 0) {
    flag_set("obj_commerce_defend_snipe_complete");
  }
}

obj_commerce_defend_crow() {
  flag_wait("obj_commerce_defend_crow_given");
  objective_number = 4;

  objective_add(objective_number, "invisible", &"DCBURNING_OBJ_COMMERCE_DEFEND_CROW");
  crow_defend_obj1 = getent("crow_defend_obj1", "targetname");
  crow_defend_obj2 = getent("crow_defend_obj2", "targetname");
  objective_additionalposition(objective_number, 0, crow_defend_obj1.origin);
  objective_additionalposition(objective_number, 1, crow_defend_obj2.origin);
  Objective_SetPointerTextOverride(objective_number, &"DCBURNING_OBJ_TEXT_DEFEND");
  objective_state(objective_number, "current");

  flag_wait("obj_commerce_defend_crow_complete");

  objective_state(objective_number, "done");
}

obj_commerce_defend_javelin() {
  flag_wait("obj_commerce_defend_javelin_given");
  wait(.5);
  objective_number = 5;
  obj_position = getstruct("obj_jav_defend2", "targetname");

  objective_add(objective_number, "active", &"DCBURNING_OBJ_COMMERCE_DEFEND_JAVELIN");
  objective_current(objective_number);

  flag_wait("obj_commerce_defend_javelin_complete");

  objective_state(objective_number, "done");
}

obj_commerce_defend_javelin_enemies_think() {
  level endon("obj_commerce_defend_javelin_complete");
  self endon("deleted_through_script");
  self endon("killed_by_friendly");
  self endon("deleted_through_script");

  flag_wait("obj_commerce_defend_javelin_given");

  level.crowsArmor = array_add(level.crowsArmor, self);
  self waittill("death", attacker);

  if((isDefined(attacker)) && (isPlayer(attacker))) {
    level.lasttimePlayerKilledEnemy = getTime();

    if(!flag("player_has_killed_at_least_one_javelin_target")) {
      flag_set("player_has_killed_at_least_one_javelin_target");
    }

    level.requiredJavTargets = level.requiredJavTargets - 1;

    if(level.requiredJavTargets < 3) {
      flag_set("only_2_javelin_enemies_remaining");
    }
    if(level.requiredJavTargets < 2) {
      flag_set("only_1_javelin_enemies_remaining");
    }
    if(level.requiredJavTargets == 0) {
      flag_set("obj_commerce_defend_javelin_complete");
    }
  }
  level.crowsArmor = array_remove(level.crowsArmor, self);
  level.crowsArmor = remove_dead_from_array(level.crowsArmor);
}

obj_rooftop() {
  flag_wait("obj_rooftop_given");
  objective_number = 6;

  obj_position = getstruct("obj_commerce_roof", "targetname");

  objective_add(objective_number, "active", &"DCBURNING_OBJ_ROOFTOP", obj_position.origin);
  objective_current(objective_number);

  flag_wait("player_roof_stairs_00");
  obj_position = getstruct("obj_commerce_roof02", "targetname");
  Objective_Position(objective_number, obj_position.origin);

  flag_wait("player_roof_stairs_01");
  obj_position = getstruct("obj_commerce_roof03", "targetname");
  Objective_Position(objective_number, obj_position.origin);

  flag_wait("player_roof_stairs_02");
  obj_position = getstruct("obj_commerce_roof03a", "targetname");
  Objective_Position(objective_number, obj_position.origin);

  flag_wait("player_outer_balcony_top_commerce");
  obj_position = getstruct("obj_commerce_roof03b", "targetname");
  Objective_Position(objective_number, obj_position.origin);

  flag_wait("player_headed_to_roof");
  obj_position = getstruct("obj_commerce_roof03c", "targetname");
  Objective_Position(objective_number, obj_position.origin);

  flag_wait("player_approach_commerce_roof_01");
  obj_position = getstruct("obj_commerce_roof03d", "targetname");
  Objective_Position(objective_number, obj_position.origin);

  flag_wait("player_approach_commerce_roof_02");
  obj_position = getstruct("obj_commerce_roof04", "targetname");
  Objective_Position(objective_number, obj_position.origin);

  flag_wait("obj_rooftop_complete");

  objective_state(objective_number, "done");
}

obj_heli_mount() {
  flag_wait("obj_rooftop_complete");
  objective_number = 7;

  obj_org = spawn("script_origin", (0, 0, 0));
  obj_org.origin = level.blackhawk gettagorigin("tag_player");
  obj_org linkto(level.blackhawk, "tag_player", (0, 0, 25), (0, 0, 0));
  objective_add(objective_number, "active", &"DCBURNING_OBJ_HELI_MOUNT", obj_org.origin);
  objective_current(objective_number);

  while(!flag("blackhawk_landed")) {
    objective_position(objective_number, obj_org.origin);
    wait(0.05);
  }
  objective_position(objective_number, obj_org.origin);

  flag_wait("obj_heli_mount_complete");

  objective_state(objective_number, "done");
}

obj_heli_ride() {
  flag_wait("obj_heli_ride_given");
  objective_number = 8;

  objective_add(objective_number, "active", &"DCBURNING_OBJ_HELI_RIDE", level.player.origin);
  objective_current(objective_number);

  flag_wait("obj_heli_ride_complete");
}

AA_music_init() {}

AA_utility() {}

AI_think(guy) {
  if(guy.team == "axis") {
    guy thread AI_axis_think();
  }

  if(guy.team == "allies") {
    guy thread AI_allies_think();
  }
}

AI_allies_think() {}

AI_axis_think() {}

AI_blood_spatter_when_sniped() {
  while(isalive(self)) {
    self waittill("damage", amount, attacker, direction_vec, impact_org);

    if((isDefined(attacker)) && (isDefined(attacker.classname) && (attacker.classname == "misc_turret"))) {
      if(!isDefined(impact_org)) {
        break;
      }
      if(!isDefined(direction_vec)) {
        direction_vec = (0, 0, 1);
      }

      playFX(getfx("thermal_body_gib"), impact_org);
    }
  }
}

ai_no_suppress_think() {
  self endon("death");
  if(flag("lav_is_suppressing")) {
    return;
  }
  self.ignoresuppression = true;
  self.aggressivemode = true;
}

AI_redshirt_think() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  self thread try_to_magic_bullet_shield(true);
  self.baseaccuracy = .01;
  self.attackeraccuracy = 10;
  self.aggressivemode = true;

  attacker = undefined;
  impact_org = undefined;

  while(isalive(self)) {
    self waittill("damage", amount, attacker, enemy_org, impact_org, type, modelName);
    if((isDefined(attacker)) && (isPlayer(attacker))) {
      continue;
    }
    if(within_fov(level.player.origin, level.player.angles, self.origin + (0, 0, 32), level.cosine["90"])) {
      break;
    }
  }
  if(isDefined(self.magic_bullet_shield)) {
    self stop_magic_bullet_shield();
  }
  self kill(impact_org, attacker);
}

try_to_magic_bullet_shield(no_death_detection) {
  self endon("death");

  while(isDefined(self.melee)) {
    wait(.1);
  }
  self thread magic_bullet_shield(no_death_detection);
}

AI_ignored_and_oblivious_on() {
  self endon("death");
  if(!isDefined(self)) {
    return;
  }
  if((isDefined(self.code_classname)) && (self.code_classname == "script_model")) {
    return;
  }
  self setFlashbangImmunity(true);
  self.ignoreme = true;
  self.ignoreall = true;
  self.grenadeawareness = 0;
  self setthreatbiasgroup("oblivious");
}

AI_ignored_and_oblivious_off() {
  if(!isDefined(self)) {
    return;
  }
  if((isDefined(self.code_classname)) && (self.code_classname == "script_model")) {
    return;
  }
  self endon("death");
  self setFlashbangImmunity(false);
  self.ignoreme = false;
  self.ignoreall = false;
  self.grenadeawareness = 1;
  self setthreatbiasgroup("allies");
}

AI_fixednode_off() {
  if(!isDefined(self)) {
    return;
  }
  self.fixednode = false;
}

AI_fixednode_on() {
  if(!isDefined(self)) {
    return;
  }
  self.fixednode = true;
}
AI_commerce_flare_guys_think() {
  self endon("death");
  self.ignoreme = true;
  self.disableexits = true;

  self cqb_walk("on");
  eNode = getnode(self.target, "targetname");
  self.goalradius = 16;
  self setgoalnode(eNode);
  wait(1);
  self waittill_either("goal", "damage");

  self.ignoreme = false;
  self.disableexits = false;
  self thread AI_ambush_behavior();
  temp = [];
  temp[0] = self;
  thread AI_delete_when_out_of_sight(temp, 512);
}

AI_jav_sting_spot_think() {
  self endon("death");
  self.allowdeath = true;
  self.ignoreme = true;
  self.reference = self.spawner;
  self.sAnimIdleStart = undefined;
  self.sAnimIdle = undefined;
  self.sAnimFire = undefined;
  self.sAnimFireConceal = undefined;
  self.sAnimReload = undefined;
  self.sAnimReact = undefined;
  self.fireAtLiveTargets = false;
  self.iTargetToggle = 0;
  self.fireNodes = undefined;
  self.old_goalradius = self.goalradius;
  self.goalradius = 16;
  aTargets = undefined;
  nextNode = undefined;

  if(isDefined(self.target)) {
    self.grenadeawareness = 0;
    self.ignoreall = true;
    self.fireNodes = [];
    self.fireNodes[0] = getnode(self.target, "targetname");
    assertex(isDefined(self.fireNodes[0]), "Javelin enemy with export " + self.export+" needs to be targeting a node.");
    aTargets = self.fireNodes[0] get_linked_ents();
    assertex(isDefined(aTargets), "Javelin enemy with export " + self.export+" needs to have its first targeted node linked to targets to fire at.");
    iCounter = 1;
    while(true) {
      if(isDefined(self.fireNodes[iCounter - 1].target)) {
        nextNode = getnode(self.fireNodes[iCounter - 1].target, "targetname");
        self.fireNodes[iCounter] = nextNode;
        iCounter++;
      } else
        break;
    }
    assertex(self.fireNodes.size >= 3, "Javelin enemy with export " + self.export+" needs to be targeting a chain of at least 3 cover nodes.");
  } else {
    aTargets = self get_linked_ents();
    assertex(isDefined(aTargets), "Javelin enemy with export " + self.export+" needs to be linked to targets to fire at.");
  }
  self.targetsScripted = aTargets;
  self.targetsDefault = [];
  foreach(target in aTargets) {
    if(target.code_classname == "script_origin") {
      self.targetsScripted = array_remove(self.targetsScripted, target);
      self.targetsDefault = array_add(self.targetsDefault, target);
    }
  }

  if(self.targetsScripted.size > 0) {
    level.targetsScriptedJavStinger = array_merge(level.targetsScriptedJavStinger, self.targetsScripted);
  }

  switch (self.script_noteworthy) {
    case "enemy_javelin":
      self gun_remove();
      self get_javelin_anims();
      self thread AI_javelin_think();
      break;
    case "enemy_stinger":
      self get_stinger_anims();
      self thread AI_stinger_think();
      break;
    case "enemy_spotter_prone":
      self gun_remove();
      self.sAnimIdle = "enemy_spotter_prone_idle";
      self.sAnimReact = "enemy_spotter_prone_react";

      self thread AI_spotter_think();
      break;
    case "enemy_spotter_crouched":
      self gun_remove();
      self.sAnimIdle = "enemy_spotter_crouched_idle";
      self.sAnimReact = "enemy_spotter_crouched_react";

      self thread AI_spotter_think();
      break;
  }
}

get_stinger_anims() {
  self.sAnimIdleStart = "stinger_idle_start";
  self.sAnimIdle = "stinger_idle";
  self.sAnimFire = "stinger_fire";
  self.sAnimReact = "stinger_react_stand";
}

get_javelin_anims() {
  variation = "";
  if(self.animation == "javelin_idle_B") {
    variation = "2";
  }
  self.sAnimIdleStart = "javelin_idle_start" + variation;
  self.sAnimIdle = "javelin_idle" + variation;
  self.sAnimFire = "javelin_fire" + variation;
  self.sAnimReact = "javelin_react" + variation;

  self.deathanimIdle = level.scr_anim["generic"]["javelin_death" + variation];
  self.deathanimReload = level.scr_anim["generic"]["javelin_death_reloading" + variation];

  if(isDefined(self.firenodes)) {
    self.sAnimFire = "javelin_fire_short";
    self.deathanimIdle = level.scr_anim["generic"]["javelin_death_barrett"];
    self.deathanimReload = level.scr_anim["generic"]["javelin_death_barrett"];
  }
}

AI_stinger_think() {
  self endon("death");
  self thread AI_jav_sting_spot_react();
  self thread AI_jav_sting_spot_death();
  self endon("alerted");
  self.reference anim_generic_first_frame(self, self.sAnimIdleStart);
  eTarget = undefined;
  newMissile = undefined;
  stinger_source_org = undefined;
  self attach("weapon_stinger", "TAG_INHAND", 1);
  self.stinger = true;

  while(isalive(self)) {
    self.reference thread anim_generic_loop(self, self.sAnimIdle, "stop_idle");
    wait(randomfloatrange(2, 5));
    self.reference notify("stop_idle");
    self.reference thread anim_generic(self, self.sAnimFire);
    self waittillmatch("single anim", "fire_weapon");
    eTarget = self AI_jav_sting_get_target();
    if(isDefined(eTarget)) {
      stinger_source_org = self gettagorigin("tag_inhand");
      newMissile = MagicBullet("stinger", stinger_source_org, eTarget.origin);
      newMissile Missile_SetTargetEnt(eTarget);
    }
    self waittillmatch("single anim", "end");
  }
}

AI_jav_sting_spot_death() {
  self waittill("death");
  self endon("weapon_detached");
  if((isDefined(self.javelin)) && (!isDefined(self.dk))) {
    self waittill_match_or_timeout("deathanim", "end", 4);
  }
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.stinger)) {
    if(isDefined(self)) {
      self detach("weapon_stinger", "TAG_INHAND");
      self.stinger = undefined;
    }
  } else if(isDefined(self.javelin)) {
    if(isDefined(self)) {
      self detach("weapon_javelin_sp", "TAG_INHAND");
      self.javelin = undefined;
    }
  }
}

AI_javelin_think() {
  self endon("death");
  self thread AI_jav_sting_spot_react();
  self thread AI_jav_sting_spot_death();
  self endon("alerted");
  javelin_death_nodes = getnodearray("javelin_death_node", "targetname");
  if(!isDefined(self.firenodes)) {
    self.reference anim_generic_first_frame(self, self.sAnimIdleStart);
  }
  eTarget = undefined;
  newMissile = undefined;
  self attach("weapon_javelin_sp", "TAG_INHAND", 1);
  self.javelin = true;
  iFireNodeCounter = 0;

  while(isalive(self)) {
    if(isDefined(self.firenodes)) {
      self.deathanim = undefined;
      if(iFireNodeCounter + 1 > self.firenodes.size) {
        iFireNodeCounter = 0;
      }
      self.goalradius = 16;

      if((flag("obj_commerce_defend_snipe_complete")) && (!isDefined(self.script_parameters))) {
        eNode = getClosest(self.origin, javelin_death_nodes);
        self setgoalnode(eNode);
        self waittill("goal");
        self delete();
        return;
      }
      self setgoalnode(self.firenodes[iFireNodeCounter]);
      self.reference = self.firenodes[iFireNodeCounter];
      iFireNodeCounter++;
      self waittill("goal");
    }
    if((flag("obj_commerce_defend_snipe_complete")) && (isDefined(self.script_parameters))) {
      array = [];
      array[0] = self;
      thread AI_delete_when_out_of_sight(array, 512);
    }
    self.reference thread anim_generic_loop(self, self.sAnimIdle, "stop_idle");
    self.deathanim = self.deathanimIdle;
    if(isDefined(self.firenodes)) {
      wait(.25);
    } else {
      wait(randomfloatrange(2, 7));
    }
    self.reference notify("stop_idle");
    self thread anim_generic(self, self.sAnimFire);
    self waittillmatch("single anim", "fire_weapon");
    eTarget = self AI_jav_sting_get_target();
    if(isDefined(eTarget)) {
      newMissile = MagicBullet("javelin_dcburn", self gettagorigin("tag_inhand"), eTarget.origin);
      playFXOnTag(getfx("javelin_muzzle"), self, "TAG_FLASH");
      newMissile Missile_SetTargetEnt(eTarget);
      newMissile Missile_SetFlightmodeTop();
    }
    self waittillmatch("single anim", "end");
  }
}

AI_jav_sting_get_target() {
  self endon("death");
  self endon("alerted");

  self.targetsScripted = remove_dead_targets_from_array(self.targetsScripted);
  level.targetsScriptedJavStinger = remove_dead_targets_from_array(level.targetsScriptedJavStinger);

  eTarget = undefined;

  if((self.iTargetToggle == 1) && (self.fireAtLiveTargets == true)) {
    if(self.targetsScripted.size > 0) {
      eTarget = self.targetsScripted[randomint(self.targetsScripted.size)];
    } else if(level.targetsScriptedJavStinger.size > 0) {
      eTarget = level.targetsScriptedJavStinger[randomint(level.targetsScriptedJavStinger.size)];
    } else {
      eTarget = self.targetsDefault[randomint(self.targetsDefault.size)];
    }
    self.iTargetToggle = 0;
  } else {
    eTarget = self.targetsDefault[randomint(self.targetsDefault.size)];
    self.iTargetToggle = 1;
  }

  return eTarget;
}

AI_spotter_think() {
  self endon("death");
  self thread AI_jav_sting_spot_react();
  self endon("alerted");
  self.reference anim_generic_loop(self, self.sAnimIdle, "stop_idle");
}

AI_jav_sting_spot_react() {
  if((isDefined(self.team)) && (self.team == "allies")) {
    return;
  }
  self endon("death");
  self waittill("alerted");
  self.goalradius = self.old_goalradius;

  if(isDefined(self.stinger)) {
    if((isDefined(self.a.pose)) && (self.a.pose == "crouch")) {
      self.sAnimReact = "stinger_react_crouch";
    }
  }
  if(isDefined(self.reference)) {
    self.reference notify("stop_idle");
  }
  self notify("stop_idle");
  self anim_stopanimscripted();
  anim_generic(self, self.sAnimReact);
  self.deathanim = undefined;

  if(isDefined(self.stinger)) {
    self detach("weapon_stinger", "TAG_INHAND");
    self notify("weapon_detached");
    self.stinger = undefined;
  } else if(isDefined(self.javelin)) {
    self detach("weapon_javelin_sp", "TAG_INHAND");
    self notify("weapon_detached");
    self.javelin = undefined;
  }
  self gun_recall();
}

AI_become_alerted() {
  self endon("death");
  if((isDefined(self)) && (isalive(self)) && (!isDefined(self.scriptedDying))) {
    self notify("alerted");
    wait(1);
    self.ignoreme = false;
  }
}

AI_waittill_damaged_and_set_flag_think() {
  self endon("death");
  level endon(self.script_flag);
  if(!flag_exist(self.script_flag)) {
    flag_init(self.script_flag);
  }
  while(isalive(self)) {
    if(flag(self.script_flag)) {
      break;
    }
    self waittill("damage");
    if(!flag(self.script_flag)) {
      flag_set(self.script_flag);
      break;
    }
  }
}

AI_drone_think() {
  self endon("death");
  self thread AI_ragdoll(true);
  self endon("stop_default_drone_mi");

  if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "drone_warrior_fodder")) {
    self.nocorpsedelete = true;
  }

  if(isDefined(self.nocorpsedelete)) {
    self thread AI_drone_corpse_delete();
  }

  if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "ai_ambient")) {
    self.dontDoNotetracks = true;
    self.script_looping = 0;
  }

  self waittill("goal");
  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "death_by_mortar":
        self thread AI_drone_mortar_death();
        break;
      case "drone_warrior":
        self thread AI_drone_warrior_think();
        break;
      case "drone_warrior_fodder":
        self thread AI_drone_warrior_fodder_think();
        break;
      default:
        self delete();
    }
  } else
    self delete();
}

AI_drone_corpse_delete() {
  if(!isDefined(self)) {
    return;
  }
  self thread maps\_drone::drone_drop_real_weapon_on_death();
  self waittill("death");

  wait(10);

  while(isDefined(self)) {
    if(!within_fov(level.player getEye(), level.player getPlayerAngles(), self.origin, level.cosine["90"])) {
      break;
    }
    wait(5);
  }

  if(isDefined(self)) {
    self delete();
  }
}

AI_drone_warrior_think() {}

AI_drone_warrior_fodder_think() {
  self endon("death");
  trigger_origin = self.origin;
  trigger_height = 100;
  trigger_spawnflags = 0;
  trigger = undefined;
  if(cointoss()) {
    trigger_radius = 720;
    trigger = spawn("trigger_radius", trigger_origin, trigger_spawnflags, trigger_radius, trigger_height);
    self thread AI_drone_mortar_death(trigger);
  } else {
    trigger_radius = randomintrange(400, 512);
    trigger = spawn("trigger_radius", trigger_origin, trigger_spawnflags, trigger_radius, trigger_height);
    self thread AI_drone_headshot_death(trigger);
  }
}

AI_drone_headshot_death(trigger) {
  self endon("death");

  if(isDefined(trigger)) {
    trigger waittill("trigger");
  }

  origin = random(level.sniperOrgs).origin;

  thread play_sound_in_space("weap_deserteagle_fire_npc", self.origin);
  thread play_sound_in_space("bullet_large_flesh", self.origin);
  headOrigin = self gettagorigin("tag_eye");
  vec = vectornormalize(headOrigin - origin);
  playFX(getfx("headshot"), headOrigin, vec);
  playFXOnTag(getfx("bodyshot"), self, "tag_eye");

  self notify("stop_drone_fighting");
  if(cointoss()) {
    thread play_sound_in_space("generic_death_american_1", self.origin);
  }
  self kill();
}

AI_drone_mortar_death(trigger) {
  self endon("death");

  if(isDefined(trigger)) {
    trigger waittill("trigger");
  }

  if(!level.onHeli) {
    play_sound_in_space("mortar_incoming", self.origin);
  }
  thread ambient_mortar_explosion(self.origin);
  self notify("stop_drone_fighting");
  if(cointoss()) {
    thread play_sound_in_space("generic_death_american_1", self.origin);
  }

  if(!isDefined(self.animset)) {
    sAnim = level.scr_anim["generic"]["deathanim_mortar_0" + randomint(2)];
  } else if((isSubStr(self.animset, "stand")) || (isSubStr(self.animset, "crouch"))) {
    sAnim = level.scr_anim["generic"]["deathanim_mortar_01"];
  } else {
    sAnim = level.scr_anim["generic"]["deathanim_mortar_0" + randomint(2)];
  }

  if(isDefined(self.deathanim)) {
    if(cointoss()) {
      sAnim = self.deathanim;
    }
  }

  self.deathanim = sAnim;
  self kill();
}

AI_ragdoll(bIsDrone) {
  self waittill("death", attacker, cause);

  if(!isDefined(attacker)) {
    return;
  }
  if((isDefined(attacker.targetname)) && (attacker.targetname == "heli_player") && (flag("player_on_minigun"))) {
    self.skipDeathAnim = true;
    if((isDefined(bIsDrone)) && (bIsDrone == true)) {
      arcadeMode_kill(self.origin, "explosive", 50);
    }
  }
}

AI_ambient_combat_think() {
  self.ignoreme = true;
  self.goalradius = 16;
  self thread magic_bullet_shield();
  self.battlechatter = true;
}

initPrecache() {
  precacherumble("crash_heli_rumble");
  PreCacheItem("missile_attackheli_dcburn");
  PreCacheModel("viewhands_us_army_dmg");
  PreCacheItem("slamraam_missile_dcburning");
  precacheModel("vehicle_slamraam_destroyed");
  precacheModel("vehicle_bradley_destroyed");
  precacheModel("mil_mre_chocolate01");
  precacheModel("weapon_binocular");
  PreCacheItem("slamraam_missile_dcburning");
  precacheModel("weapon_bullet_02");
  precacheModel("weapon_m82_MG_Setup_obj");
  preCacheModel("projectile_cbu97_clusterbomb");
  preCacheModel("weapon_m4m203_acog");
  precacheModel("weapon_stinger");
  precacheModel("weapon_javelin_sp");

  precacheshader("splatter");

  precacheModel("com_blackhawk_spotlight_on_mg_setup");
  precachestring(&"DCBURNING_INFO_EVAC_SITE_HEALTH");
  precachestring(&"DCBURNING_OBJ_COMMERCE");
  precachestring(&"DCBURNING_OBJ_ROOFTOP");
  precachestring(&"DCBURNING_OBJ_HELI_RIDE");
  precachestring(&"DCBURNING_OBJ_LINCOLN");
  precachestring(&"DCBURNINGINFO_EVAC_SITE_HEALTH");
  precachestring(&"DCBURNING_MISSIONFAIL_LEFT_CHOPPER");

  precachestring(&"DCBURNING_RAN_OUT_OF_TIME");
  precachestring(&"DCBURNING_TIME_REMAINING");

  precachemodel("adrenaline_syringe_animated");
  precachemodel("clotting_powder_animated");
  precachemodel("com_folding_chair");
  precachemodel("com_laptop_rugged_open");
  precachemodel("vehicle_mack_truck_short_destroy");
  precachemodel("vehicle_uaz_fabric_dsr");
  precachemodel("vehicle_luxurysedan_2008_destroy");
  precachemodel("vehicle_pickup_technical_destroyed");
  precacheItem("javelin_dcburn");
  precacheItem("javelin_noimpact");
  PreCacheItem("stinger");
}

init_difficulty() {
  level.friendlyArmorTargets = undefined;
  level.requiredJavTargets = undefined;
  switch (level.gameSkill) {
    case 0:
      level.requiredJavTargets = 3;
      level.friendlyArmorTargets = 1;
      break;
    case 1:
      level.requiredJavTargets = 4;
      level.friendlyArmorTargets = 1;
      break;
    case 2:
      level.requiredJavTargets = 4;
      level.friendlyArmorTargets = 1;
      break;
    case 3:
      level.requiredJavTargets = 4;
      level.friendlyArmorTargets = 1;
      break;
  }
  flag_set("difficulty_initialized");
}

disable_color_trigs() {
  array_thread(level.aColornodeTriggers, ::trigger_off);
}

fluorescentFlicker() {
  for(;;) {
    wait(randomfloatrange(.05, .1));

    self setLightIntensity(randomfloatrange(1, 1.5));
  }
}

fluorescentFlickerBig() {
  for(;;) {
    wait(randomfloatrange(.05, .1));

    self setLightIntensity(randomfloatrange(0.8, 1.1));
  }
}

emergencyStrobe() {
  for(;;) {
    self setLightIntensity(0);

    wait 1;

    self setLightIntensity(1.4);

    wait .1;
  }
}

lights() {
  fires = getEntArray("firelight_flicker", "targetname");
  array_thread(fires, ::flicker_fire);

  flares = getEntArray("flickerlight1", "targetname");
  foreach(flare in flares) {
    flare thread flareFlicker();
  }

  fluorescents = getEntArray("fluorescentFlicker", "targetname");
  foreach(fluorescent in fluorescents) {
    fluorescent thread fluorescentFlicker();
  }

  fluorescents = getEntArray("fluorescentFlickerBig", "targetname");
  foreach(fluorescent in fluorescents) {
    fluorescent thread fluorescentFlickerBig();
  }

  strobes = getEntArray("strobe1", "targetname");
  foreach(strobe in strobes) {
    strobe thread emergencyStrobe();
  }
}

initFriendlies(sStartPoint, bDontSpawnFriendlies, bWarpPlayer) {
  if(!isDefined(bWarpPlayer)) {
    bWarpPlayer = true;
  }

  if(!isDefined(bDontSpawnFriendlies)) {
    bDontSpawnFriendlies = false;
  }

  waittillframeend;
  assert(isDefined(sStartPoint));

  if((isDefined(bDontSpawnFriendlies)) && (bDontSpawnFriendlies != true)) {
    level.squad = [];
    level.teamleader = spawn_targetname("teamLeader");
    level.friendly02 = spawn_targetname("friendly02");
    level.friendly03 = spawn_targetname("friendly03");
    level.squad[0] = level.teamleader;
    level.squad[1] = level.friendly02;
    level.squad[2] = level.friendly03;
    array_thread(level.squad, ::friendly_squad_think);
    level.excludedAi = [];
    level.excludedAi[0] = level.teamleader;
  }

  level.mortarExcluders = level.squad;

  if(sStartPoint == "Bunker") {
    return;
  }

  if((isDefined(bWarpPlayer)) && (bWarpPlayer == true)) {
    aPlayerNodes = getnodearray("playerStart" + sStartPoint, "targetname");
    teleport_players(aPlayerNodes);
  }

  aFriendlies = level.squad;
  warpNodes = getnodearray("friendlyStart" + sStartPoint, "targetname");
  assertEx(warpNodes.size == 3, "Need exactly 3 nodes with targetname: nodeStart" + sStartPoint);
  while(aFriendlies.size > 0) {
    wait(0.05);
    for(i = 0; i < warpNodes.size; i++) {
      if(isDefined(warpNodes[i].script_noteworthy)) {
        switch (warpNodes[i].script_noteworthy) {
          case "nodeLeader":
            level.teamleader teleport_ai(warpNodes[i]);
            aFriendlies = array_remove(aFriendlies, level.teamleader);
            warpNodes = array_remove(warpNodes, warpNodes[i]);
            break;
          case "nodeFriendly02":
            level.friendly02 teleport_ai(warpNodes[i]);
            aFriendlies = array_remove(aFriendlies, level.friendly02);
            warpNodes = array_remove(warpNodes, warpNodes[i]);
            break;
          case "nodeFriendly03":
            level.friendly03 teleport_ai(warpNodes[i]);
            aFriendlies = array_remove(aFriendlies, level.friendly03);
            warpNodes = array_remove(warpNodes, warpNodes[i]);
            break;
          default:
            assertmsg("node has invalid name for initFriendlies() function: " + warpNodes[i].script_noteworthy);
            break;
        }
      }
    }
  }
}

friendly_squad_think() {
  self.animname = "generic";
  if((self == level.teamleader) || (self == level.friendly02)) {
    self thread magic_bullet_shield();
    self setFlashbangImmunity(true);
  }
}

AI_squad_fixed_node_interior() {
  level.fixednodesaferadius_default = 128;
  foreach(guy in level.squad) {
    if(isDefined(self)) {
      self.fixedNodeSafeRadius = level.fixednodesaferadius_default;
    }
  }
}

AI_squad_fixed_node_default() {
  level.fixednodesaferadius_default = undefined;
  foreach(guy in level.squad) {
    if(isDefined(self)) {
      self.fixedNodeSafeRadius = 64;
    }
  }
}

vehicle_heli_land(eNode) {
  self endon("death");
  eNode waittill("trigger");
  self notify("landing");
  self vehicle_detachfrompath();
  self setgoalyaw(eNode.angles[1]);
  vehicle_land_beneath_node(undefined, eNode);
  self notify("landed");
}

heli_cargo_liftoff_and_go() {
  assertex(isDefined(self.script_noteworthy), "Heli at " + self.origin + " needs to have a script_noteworthy that matches the script_noteworthy of the path you will attach it to.");
  ePath = getstruct(self.script_noteworthy, "script_noteworthy");
  assertex(isDefined(ePath), "Heli at " + self.origin + " needs to have a script_noteworthy that matches the script_noteworthy of the path you will attach it to.");
  dist = distance(self.origin, ePath.origin);
  self vehicle_liftoff(dist);

  self thread vehicle_paths(ePath);
}

heli_teleport_to_newpath(sSpawnerTargetname, eNode) {
  self vehicle_delete();
  assertex(isDefined(eNode.targetname), "The node you are respawning the heli at needs to have a targetname.");
  spawner = getvehiclespawner(sSpawnerTargetname);
  assertex(isDefined(spawner), "No helicopter spawner with the targetname: " + sSpawnerTargetname);
  spawner.target = eNode.targetname;
  spawner.origin = eNode.origin;
  if(isDefined(eNode.angles)) {
    spawner.angles = (eNode.angles[0], eNode.angles[1], spawner.angles[2]);
  }
  eHeli = spawn_vehicle_from_targetname(sSpawnerTargetname);
  eHeli thread vehicle_paths(eNode);
  eHeli vehicle_ai_event("idle_alert_to_casual");
  return eHeli;
}

vehicle_think() {
  if((getDvar("dc_debug") == "1") && (isDefined(self.spawner.targetname))) {
    self thread debug_message(self.spawner.targetname, self.origin, 9999, self);
  }

  if(self maps\_vehicle::isCheap()) {
    self thread maps\_vehicle::friendlyfire_shield();
  }

  switch (self.vehicletype) {
    case "humvee":
    case "hummer_minigun":
    case "hummer":
      self thread vehicle_humvee_think();
      break;
    case "mi17":
      self thread vehicle_mi17_think();
      break;
    case "littlebird":
      self thread vehicle_littlebird_think();
      break;
    case "m1a1":
      self thread vehicle_m1a1_think();
      break;
    case "btr80":
      self thread vehicle_btr80_think();
      break;
    case "cobra":
      self thread vehicle_cobra_think();
      break;
    case "mi28":
      self thread vehicle_mi28_think();
      break;
    case "slamraam":
      self thread vehicle_slamraam_think();
      break;
  }
}

vehicle_slamraam_think() {
  self endon("death");
  self setturrettargetent(level.player);
  foreach(tag in self.missileTags) {
    self attach(self.missileModel, tag);
  }
  self.hitsRemaining = 3;
  self thread vehicle_damage_think();
  eMissile = undefined;
  tag = undefined;
  targetOrg = level.player;
  while((isDefined(self)) && (self.missileTags.size > 0)) {
    self waittill("fire");
    tag = random(self.missileTags);
    self.missileTags = array_remove(self.missileTags, tag);
    self detach(self.missileModel, tag);
    eMissile = magicBullet("slamraam_missile_dcburning", self gettagorigin(tag), targetOrg.origin);
    if(self.missileTags.size < 1) {
      break;
    }
  }
  self clearturrettarget();
}

custom_rumble() {
  org = spawn("script_origin", self.origin + (0, 0, 0));
  org linkto(self);
  while(isDefined(self)) {
    org PlayRumbleOnEntity("crash_heli_rumble");
    wait(.4);
  }
  org delete();
}

vehicle_mi28_think() {
  self setmaxpitchroll(20, 40);
  if((isDefined(self.script_parameters)) && (self.script_parameters == "custom_rumble")) {
    self thread custom_rumble();
  }
  if((isDefined(self.targetname)) && (isSubStr(self.targetname, "ambient"))) {
    self thread vehicle_ambient_heli_think();
    return;
  }
  self.firingMissiles = false;
  self.enableRocketDeath = true;
  self.defaultWeapon = "havoc_turret";
  self.hitsRemaining = 3;
  self thread maps\_attack_heli::heli_default_missiles_on("missile_attackheli_dcburn");
  if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "ambient")) {} else if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "ambient_attacker")) {} else {
    target_set(self, (0, 0, -80));
    target_setJavelinOnly(self, true);
  }

  if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "regular")) {
    return;
  }
  self thread vehicle_damage_think();
}

vehicle_ambient_heli_think() {
  self.firingMissiles = false;
  self.defaultWeapon = "havoc_turret";
  self thread maps\_attack_heli::heli_default_missiles_on("missile_attackheli_dcburn");
}

vehicle_humvee_think() {
  self endon("death");
}

vehicle_mi17_think() {
  self endon("death");
}

vehicle_littlebird_think() {
  self endon("death");
  self maps\_vehicle::godon();
  if(self.classname == "script_vehicle_littlebird_armed") {
    self thread maps\_attack_heli::heli_default_missiles_on("missile_attackheli_dcburn");
    waittillframeend;
    foreach(turret in self.mgturret) {
      turret SetMode("manual");
      turret StopFiring();
    }
  }
}

vehicle_delete() {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");

  if((isDefined(self.riders)) && (self.riders.size)) {
    array_thread(self.riders, ::AI_delete);
  }

  if(isDefined(self.mgturret)) {
    foreach(turret in self.mgturret) {
      if(isDefined(turret)) {
        turret delete();
      }
    }
  }
  self maps\_vehicle::godoff();
  self delete();
}

vehicle_m1a1_think() {
  self endon("death");
}

vehicle_btr80_think() {
  if((isDefined(self.targetname)) && (self.targetname == "btr80s_end")) {
    return;
  }
  self.hitsRemaining = 3;

  target_set(self, (0, 0, 0));
  target_setJavelinOnly(self, true);
  Target_SetAttackMode(self, "top");
  self thread vehicle_damage_think();
  if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "no_ai")) {
    return;
  }
  if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "crows_nest_bmps")) {
    return;
  }
  if(!level.onHeli) {
    return;
  } else {
    self thread vehicle_turret_think();
  }
}

vehicle_cobra_think() {
  self endon("death");
}

vehicle_bm21_troops_think() {
  self endon("death");
}

vehicle_damage_think() {
  self endon("death");
  self maps\_vehicle::godon();
  attacker = undefined;
  killedByPlayerJavelin = undefined;
  while(isDefined(self)) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    if(!isDefined(attacker)) {
      continue;
    }
    if(IsString(attacker)) {
      continue;
    }
    if((isDefined(attacker.code_classname)) && (attacker.code_classname == "misc_turret")) {
      continue;
    }
    if((isDefined(attacker.script_team)) && (attacker.script_team == "axis")) {
      continue;
    }
    if((isDefined(attacker.team)) && (attacker.team == "axis")) {
      continue;
    }
    if((isDefined(level.blackhawk)) && (attacker == level.blackhawk)) {
      if(isDefined(self.immuneToBlackhawk)) {
        continue;
      }
      assertex(isDefined(self.hitsRemaining), "Need to have 'self.hitsRemaining' defined for vehicles for heli ride!");
      self.hitsRemaining--;
      if(self.hitsRemaining <= 0) {
        break;
      } else
        continue;
    }
    if(!isDefined(type)) {
      continue;
    }
    if((type == "MOD_PROJECTILE") && (amount > 399)) {
      if(isPlayer(attacker)) {
        killedByPlayerJavelin = true;
      }
      break;
    }
  }

  if((isDefined(level.blackhawk)) && (attacker == level.blackhawk)) {} else if(!isPlayer(attacker)) {
    self notify("killed_by_friendly");
    if(getDvar("dc_debug") == "1") {
      iprintlnbold("friendly just owned a vehicle");
    }
    level.friendlyArmorTargets--;

    thread friendly_crows_help_cooldown();
  }

  self thread vehicle_death(killedByPlayerJavelin);
}

vehicle_turret_think() {
  self endon("death");
  self thread maps\_vehicle::mgoff();
  self.turretFiring = false;
  eTarget = undefined;
  while(isDefined(self)) {
    if(level.player.ignoreme) {
      wait(1);
      continue;
    }
    wait(0.05);

    if(distancesquared(level.player.origin, self.origin) > level.CannonRangeSquared) {
      eTarget = undefined;
    } else {
      eTarget = level.player;
    }

    if((isDefined(eTarget)) && (isPlayer(eTarget))) {
      sightTracePassed = false;
      sightTracePassed = sighttracepassed(self.origin, level.player.origin + (0, 0, 0), false, self);

      if(!sightTracePassed) {
        eTarget = undefined;
      }
    }

    if(!isDefined(eTarget)) {
      eTarget = self vehicle_get_target();
    }

    if((isDefined(eTarget)) && (isalive(eTarget))) {
      targetLoc = eTarget.origin + (0, 0, 32);
      self setTurretTargetVec(targetLoc);
      fRand = (randomfloatrange(2, 3));
      self waittill_notify_or_timeout("turret_rotate_stopped", fRand);

      if((isDefined(eTarget)) && (isPlayer(eTarget))) {
        playerEye = level.player getEye();
        bInFOV = within_fov(playerEye, level.blackhawk.angles + (0, -90, 0), self.origin, level.cosine["45"]);
        if(bInFOV) {
          if(!self.turretFiring) {
            self thread vehicle_fire_main_cannon();
          }
        }
      }
      if((isDefined(eTarget)) && (!isPlayer(eTarget))) {
        if(!self.turretFiring) {
          self thread vehicle_fire_main_cannon();
        }
      }
    }
  }
}

vehicle_fire_main_cannon() {
  self endon("death");
  iFireTime = undefined;
  iBurstNumber = undefined;

  switch (self.vehicletype) {
    case "btr80":
      iFireTime = .5;

      iBurstNumber = randomintrange(3, 6);
      break;
    default:
      assertmsg("need to define a case statement for " + self.vehicletype);
  }

  assert(isDefined(iFireTime));
  self.turretFiring = true;
  i = 0;
  while(i < iBurstNumber) {
    i++;
    wait(iFireTime);
    self fireWeapon();
  }
  self.turretFiring = false;
}

friendly_crows_help_cooldown() {
  if(flag("obj_commerce_defend_javelin_complete")) {
    level.friendliesCanHelpCrowsnest = undefined;
    return;
  }

  self notify("cooldown_started");
  self endon("cooldown_started");
  level.friendliesCanHelpCrowsnest = false;
  wait(10);
  level.friendliesCanHelpCrowsnest = true;
}

vehicle_death(killedByPlayerJavelin) {
  if(!level.onHeli) {
    if(Target_IsTarget(self)) {
      Target_Remove(self);
    }
  }

  self maps\_vehicle::godoff();
  self notify("death", level.player, "MOD_PROJECTILE");
  if(isDefined(killedByPlayerJavelin)) {
    earthquake(0.25, 0.75, level.player.origin, 1250);
    level.player PlayRumbleOnEntity("damage_light");
  }
}

ai_ambient_prop_think() {
  self endon("death");
  eProp = getent(self.target, "targetname");
  self thread delete_on_death(eProp);
  sAnim = self.animation;
  assert(isDefined(eProp));
  assert(isDefined(sAnim));
  self.eAnimEnt = spawn("script_origin", eProp.origin);
  self thread delete_on_death(self.eAnimEnt);
  sFailSafeFlag = undefined;

  switch (eProp.model) {
    case "com_folding_table":
      if(isDefined(self.script_parameters)) {
        self.eAnimEnt.origin = self.eAnimEnt.origin + (0, -40, 0);
      }
      self.eAnimEnt.angles = eProp.angles + (0, 0, 0);
      self.eAnimEnt anim_generic_first_frame(self, sAnim + "_start");
      laptop = spawn("script_model", self.origin);
      laptop setModel("weapon_uav_control_unit");
      self thread delete_on_death(laptop);
      laptop.angles = self.angles + (0, 0, 0);
      ent = spawnStruct();
      ent.entity = laptop;
      ent.forward = 23;
      ent.up = 33.5;
      ent.right = 1;
      ent.yaw = 0;
      ent translate_local();
      chair = spawn("script_model", self.origin);
      chair setModel("com_folding_chair");
      chair.angles = self.angles + (0, 0, 0);
      self thread delete_on_death(chair);
      ent = spawnStruct();
      ent.entity = chair;
      ent.forward = -5;
      ent translate_local();
      if(sAnim == "laptop_officer_idle") {
        chair delete();
        laptop delete();
      }
      break;
    case "mil_bunker_bed2":
      self gun_remove();
      self.eAnimEnt.angles = eProp.angles + (0, 90, 0);
      ent = spawnStruct();
      ent.entity = self.eAnimEnt;
      ent.up = 28;
      ent translate_local();
      self.eAnimEnt anim_generic_first_frame(self, sAnim + "_start");
      break;
    case "bc_cot":
      self gun_remove();
      ent = spawnStruct();
      ent.entity = self.eAnimEnt;
      if((sAnim == "cargoship_sleeping_guy_idle_1") || (sAnim == "cargoship_sleeping_guy_idle_2")) {
        ent.up = 22;
        ent.yaw = 180;
        ent.forward = 4;
        ent translate_local();
      } else if(sAnim == "afgan_caves_sleeping_guard_idle") {
        ent.yaw = 180;

        ent translate_local();
      } else if((sAnim == "DC_Burning_CPR_wounded") || (sAnim == "DC_Burning_CPR_medic")) {
        sFailSafeFlag = "player_bunker_walk_01";
        ent.yaw = 195;
        ent translate_local();
      } else {
        ent.yaw = 90;
        ent translate_local();
      }
      break;
    case "stretcher_animated":
      self gun_remove();
      self.eAnimEnt.angles = eProp.angles + (0, 90, 0);
      ent = spawnStruct();
      ent.entity = self.eAnimEnt;
      ent.up = -1;
      ent translate_local();
      self.eAnimEnt anim_generic_first_frame(self, sAnim + "_start");
      break;
    case "bc_stretcher":
      self gun_remove();
      self.eAnimEnt.angles = eProp.angles + (0, 0, 0);
      if(sAnim == "afgan_caves_sleeping_guard_idle") {
        ent = spawnStruct();
        ent.entity = self.eAnimEnt;
        ent.up = -12;

        ent.right = 2;
        ent translate_local();
      } else {
        ent = spawnStruct();
        ent.entity = self.eAnimEnt;
        ent.up = 8;
        ent translate_local();
      }
      self.eAnimEnt anim_generic_first_frame(self, sAnim + "_start");
      break;
    default:
      self gun_remove();
      self.eAnimEnt.angles = eProp.angles;
      break;
  }

  self thread ai_ambient_think(sAnim, sFailSafeFlag);
}

ai_ambient_cleanup() {
  self waittill("death");
  if((isDefined(self.eAnimEnt)) && (!isspawner(self.eAnimEnt))) {
    self.eAnimEnt delete();
  }
}

make_ambient_ai(targetname) {
  spawner = getent(targetname, "targetname");
  self.script_flag = spawner.script_flag;
  self.animation = spawner.animation;
  self.eAnimEnt = spawner;
  self.target = spawner.target;
  sAnim = self.animation;
  sFailSafeFlag = undefined;
  self thread ai_ambient_think(sAnim, sFailSafeFlag);
}

ai_ambient_noprop_think() {
  self endon("death");
  assert(isDefined(self.animation));
  sAnim = self.animation;
  bSpecial = false;
  if(!isDefined(self.eAnimEnt)) {
    self.eAnimEnt = self.spawner;
  }

  sFailSafeFlag = undefined;

  switch (sAnim) {
    case "death_explosion_run_F_v1":
    case "civilian_run_2_crawldeath":
      self gun_remove();
      self.skipDeathAnim = true;
      self.noragdoll = true;
      break;
    case "DC_Burning_artillery_reaction_v1_idle":
    case "DC_Burning_artillery_reaction_v2_idle":
    case "DC_Burning_artillery_reaction_v3_idle":
    case "DC_Burning_artillery_reaction_v4_idle":
    case "DC_Burning_bunker_stumble":
    case "training_humvee_wounded":
    case "training_humvee_soldier":
      sFailSafeFlag = "player_bunker_walk_01";
      self gun_remove();
      break;
    case "bunker_toss_idle_guy1":
      self cqb_walk("on");
      break;
    case "unarmed_panickedrun_loop_V2":
      self set_generic_run_anim("unarmed_panickedrun_loop_V2");
      self gun_remove();
      self.disablearrivals = true;
      self.disableexits = true;
      self.goalradius = 16;
      self waittill("goal");
      self clear_run_anim();
      wait(1);
      self gun_recall();
      bSpecial = true;
      return;
    case "wounded_carry_fastwalk_carrier":
      spawner = getent(self.target, "targetname");
      eBuddy = spawner spawn_ai();
      self.eAnimEnt anim_generic_first_frame(self, sAnim);
      self.eAnimEnt anim_generic_first_frame(eBuddy, "wounded_carry_fastwalk_wounded");

      eBuddy gun_remove();
      bSpecial = true;
      eEndOrg = getent(self.script_Linkto, "script_linkname");
      if(isDefined(self.script_flag)) {
        flag_wait(self.script_flag);
      }

      while(distance(eEndOrg.origin, self.origin) > 128) {
        thread anim_generic(self, sAnim);
        anim_generic(eBuddy, "wounded_carry_fastwalk_wounded");
      }
      self.eAnimEnt = spawn("script_origin", (0, 0, 0));
      self.eAnimEnt.origin = self.origin;
      self.eAnimEnt.angles = self.angles;
      self.eAnimEnt thread ent_cleanup(self);
      self.eAnimEnt thread anim_generic(self, "DC_Burning_wounded_carry_putdown_carrier");
      self.eAnimEnt anim_generic(eBuddy, "DC_Burning_wounded_carry_putdown_wounded");
      self thread anim_sound_loop("scn_dcburn_carry_wounded_loop");
      self.eAnimEnt thread anim_generic_loop(eBuddy, "DC_Burning_wounded_carry_idle_wounded");
      self.eAnimEnt thread anim_generic_loop(self, "DC_Burning_wounded_carry_idle_carrier");
      return;
    case "roadkill_cover_radio_soldier2":
      break;
    case "roadkill_cover_spotter":
      self attach("weapon_binocular", "TAG_INHAND", 1);
      break;
    case "roadkill_cover_radio_soldier3":
      self.eAnimEnt.origin = self.eAnimEnt.origin + (0, 0, 8);
      self attach("mil_mre_chocolate01", "TAG_INHAND", 1);
      break;
    case "favela_run_and_wave":
      break;
    default:
      self gun_remove();
      break;
  }

  self thread ai_ambient_think(sAnim, sFailSafeFlag);
}

anim_sound_loop(alias) {
  self endon("death");
  while(true) {
    self thread play_sound_in_space(alias);
    self waittillmatch("looping anim", "end");
  }
}

ai_ambient_think(sAnim, sFailSafeFlag) {
  self endon("death");
  self AI_ignored_and_oblivious_on();
  eGoal = undefined;
  sAnimGo = undefined;
  looping = false;

  if(isDefined(self.target)) {
    eGoal = getnode(self.target, "targetname");
  }

  self thread ai_ambient_cleanup();

  if(isarray(level.scr_anim["generic"][sAnim])) {
    looping = true;
    self.eAnimEnt thread anim_generic_loop(self, sAnim, "stop_idle");
    sAnimGo = sAnim + "_go";
    if(anim_exists(sAnimGo)) {
      sAnim = sAnimGo;
    } else {
      sAnimGo = undefined;
    }
  } else
    self.eAnimEnt anim_generic_first_frame(self, sAnim);

  if(isDefined(self.script_flag)) {
    if(isDefined(sFailSafeFlag)) {
      flag_wait_either(self.script_flag, sFailSafeFlag);
    } else {
      flag_wait(self.script_flag);
    }
  }

  switch (sAnim) {
    case "death_explosion_run_F_v1":
    case "civilian_run_2_crawldeath":
      thread ambient_mortar_explosion(self.origin);
      break;
  }

  if(isDefined(eGoal)) {
    self.disablearrivals = true;
    self.disableexits = true;
  }

  if(!looping) {
    self.eAnimEnt anim_generic(self, sAnim);
  }

  if(isDefined(sAnimGo)) {
    self.eAnimEnt notify("stop_idle");
    self.eAnimEnt anim_generic(self, sAnimGo);
  }

  switch (sAnim) {
    case "civilian_run_2_crawldeath":
      self kill();
      break;
  }

  if(isDefined(eGoal)) {
    self setgoalnode(eGoal);
    wait(1);
    self.disablearrivals = false;
    self.disableexits = false;
    self waittill("goal");
    if(isDefined(self.cqbwalking) && self.cqbwalking) {
      self cqb_walk("off");
    }
  } else if(isDefined(level.scr_anim["generic"][sAnim + "_idle"]))
    self.eAnimEnt thread anim_generic_loop(self, sAnim + "_idle", "stop_idle");

  if(anim_exists(sAnim + "_react")) {
    if(!looping) {
      sAnim = sAnim + "_idle";
    }
    sAnimReact = sAnim + "_react";

    if(anim_exists(sAnim + "_react2")) {
      sAnimReact2 = sAnim + "_react2";
    } else {
      sAnimReact2 = sAnimReact;
    }
    while(isDefined(self)) {
      level waittill("mortar_hit");
      self.eAnimEnt notify("stop_idle");
      self notify("stop_idle");
      waittillframeend;
      if(RandomInt(100) > 50) {
        self.eAnimEnt anim_generic(self, sAnimReact);
      } else {
        self.eAnimEnt anim_generic(self, sAnimReact2);
      }
      self.eAnimEnt thread anim_generic_loop(self, sAnim, "stop_idle");
    }
  }
}

ambient_mortar_explosion(org) {
  playFX(level._effect["mortar"]["dirt"], org);
  thread play_sound_in_space(level.scr_sound["mortar"]["dirt"], org);
  earthquake(0.25, 0.75, org, 1250);
}

dialogue_random_incoming_javelins() {
  iRand = randomint(2);
  dialouge_random_friendly("dcburn_javelins_incoming_0" + iRand);
}

javelin_earthquake() {
  dummy = spawn("script_origin", self.origin);
  dummy linkto(self);
  self waittill("death");
  earthquake(1.2, 1.5, dummy.origin, 1600);
  wait(0.05);
  dummy delete();
}

vehicle_owned_by_javelin(javelin_source_org) {
  newMissile = MagicBullet("javelin_noimpact", javelin_source_org.origin, self.origin);
  playFX(getfx("javelin_muzzle"), javelin_source_org.origin);
  newMissile thread javelin_earthquake();
  newMissile Missile_SetTargetEnt(self);
  newMissile Missile_SetFlightmodeTop();
  while(true) {
    self waittill("damage", amount, attacker, enemy_org, impact_org, type);
    if((isDefined(attacker.classname)) && (attacker.classname == "worldspawn") && (isDefined(amount)) && (amount > 24)) {
      break;
    }
  }
  if(isDefined(self)) {
    self notify("death");
  }
}

ignoreme_on_squad_and_player() {
  level.player.ignoreme = true;
  level.squad = remove_dead_from_array(level.squad);
  for(i = 0; i < level.squad.size; i++) {
    if(!isDefined(level.squad[i])) {
      continue;
    }
    level.squad[i].ignoreme = true;
    level.squad[i] setthreatbiasgroup("oblivious");
  }
}

ignoreme_off_squad_and_player() {
  level.player.ignoreme = false;
  level.squad = remove_dead_from_array(level.squad);
  for(i = 0; i < level.squad.size; i++) {
    if(!isDefined(level.squad[i])) {
      continue;
    }
    level.squad[i].ignoreme = false;
    level.squad[i] setthreatbiasgroup("allies");
  }
}

AI_friendly_fodder_think() {
  self thread try_to_magic_bullet_shield();
  self setFlashbangImmunity(true);
  self.baseaccuracy = .1;
  self.ignoreall = true;
  eGoal = getnode(self.target, "targetname");
  if(isDefined(eGoal)) {
    self setgoalnode(eGoal);
    self.goalradius = 16;
  }
}

flareFlicker() {
  while(isDefined(self)) {
    wait(randomfloatrange(.05, .1));
    self setLightIntensity(randomfloatrange(0.6, 1.8));
  }
}

flicker_fire() {
  while(isDefined(self)) {
    wait(randomfloatrange(.05, .1));
    self setLightIntensity(randomfloatrange(1.2, 2.2));
  }
}

flare_burst_on_and_flicker(rampUpTime, rampDownTime, intensity) {
  assertex(self.classname == "script_model", "This function can only be called on a script_model. Preferably mil_emergency_flare");
  dynamicLight = getent(self.target, "targetname");
  assertex(maps\_lights::is_light_entity(dynamicLight), "The flare script_model must be targeting a scriptable primary light");

  playFXOnTag(getfx("flare_ambient"), self, "TAG_FIRE_FX");
  thread play_sound_in_space("flare_ignite", self.origin);
  dynamicLight flare_ramp_up(rampUpTime, intensity);

  dynamicLight flare_ramp_down(rampDownTime);

  self thread flare_flicker();
}

flare_ramp_up(transitionTime, intensity) {
  self setLightIntensity(0);
  curr = 0;
  increment_on = (intensity - 0) / (transitionTime / .05);

  time = 0;
  randomFlicker = undefined;
  while(time < transitionTime) {
    curr += increment_on;
    randomFlicker = randomfloatrange(-.05, .05);
    curr = curr + randomFlicker;
    if(curr < 0) {
      break;
    }
    self setLightIntensity(curr);
    time += .05;
    wait(.05);
  }
}

flare_ramp_down(transitionTime) {
  curr = self getLightIntensity();
  increment = (curr - 0) / (transitionTime / .05);

  time = 0;
  randomFlicker = undefined;
  while(time < transitionTime) {
    curr -= increment;
    randomFlicker = randomfloatrange(-.05, .05);
    curr = curr + randomFlicker;
    if(curr < 2) {
      break;
    }
    self setLightIntensity(curr);
    time += .05;
    wait(.05);
  }
}

flare_flicker(minIntensity, maxIntensity) {
  assertex(self.classname == "script_model", "This function can only be called on a script_model. Preferably mil_emergency_flare");
  dynamicLight = getent(self.target, "targetname");
  assertex(maps\_lights::is_light_entity(dynamicLight), "The flare script_model must be targeting a scriptable primary light");

  if(!isDefined(minIntensity)) {
    minIntensity = 0.6;
  }
  if(!isDefined(maxIntensity)) {
    maxIntensity = 1.8;
  }

  self thread play_loop_sound_on_entity("flare_burn_loop");

  while(isDefined(self)) {
    wait(randomfloatrange(.05, .1));
    dynamicLight setLightIntensity(randomfloatrange(minIntensity, maxIntensity));
  }
}

anim_exists(sAnim, animname) {
  if(!isDefined(animname)) {
    animname = "generic";
  }
  if(isDefined(level.scr_anim[animname][sAnim])) {
    return true;
  } else {
    return false;
  }
}

dialouge_random_friendly(sLine) {
  guy = get_closest_ai_exclude(level.player.origin, "allies", level.excludedAi);
  if(isDefined(guy)) {
    guy play_sound_in_space(level.scr_sound[sLine]);
  } else {
    iprintln("unable to play random friendly dialogue " + sLine + " because couldn't find an AI");
  }
}

triggersEnable(triggerName, noteworthyOrTargetname, bool) {
  assertEX(isDefined(bool), "Must specify true/false parameter for triggersEnable() function");
  aTriggers = getEntArray(triggername, noteworthyOrTargetname);
  assertEx(isDefined(aTriggers), triggerName + " does not exist");
  if(bool == true) {
    array_thread(aTriggers, ::trigger_on);
  } else {
    array_thread(aTriggers, ::trigger_off);
  }
}

hideAll(stuffToHide) {
  if(!isDefined(stuffToHide)) {
    stuffToHide = getEntArray("hide", "script_noteworthy");
  }
  array_thread(stuffToHide, ::hide_entity);
}

AI_delete(excluders) {
  self endon("death");
  if(!isDefined(self)) {
    return;
  }
  if((isDefined(excluders)) && (excluders.size > 0)) {
    if(is_in_array(excluders, self)) {
      return;
    }
  }
  if(isDefined(self.magic_bullet_shield)) {
    self stop_magic_bullet_shield();
  }
  if(!isSentient(self)) {}

  self delete();
}

set_threatbias(iValue) {
  self.oldthreatbias = level.player.threatbias;
  self.threatbias = iValue;
}

reset_threatbias() {
  if(isDefined(self.oldthreatbias)) {
    self.threatbias = self.oldthreatbias;
  }
}

humvee_spotlight_setup() {
  self.spotlight_org = spawn("script_origin", self.origin);
  self.spotlight_org.angles = self.angles;
  self.spotlight_org.origin = self gettagorigin("tag_walker3");
  self.spotlight_org.origin = self.spotlight_org.origin + (0, 0, 0);
  ent = spawnStruct();
  ent.entity = self.spotlight_org;
  ent.forward = 0;
  ent.up = 30;
  ent.right = 0;
  ent translate_local();
  self.turret = spawnturret("misc_turret", self.spotlight_org.origin, "heli_spotlight");
  self.turret.angles = self.spotlight_org.angles;
  self.turret setmode("manual");
  self.turret setModel("com_blackhawk_spotlight_on_mg_setup");
}

waittill_dead_then_set_flag(aGuys, sFlag) {
  waittill_dead_or_dying(aGuys);
  flag_set(sFlag);
}

dialogue_execute(sLineToExecute) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self dialogue_queue(sLineToExecute);
}

play_sound_on_entity_temp(sLineToExecute) {
  if(getDvar("dc_dialog") == "1") {
    hint_temp(level.scr_sound[sLineToExecute], level.tempDialogueTime);
  }
}

hint_temp(string, timeOut) {
  hintfade = 0.5;

  level endon("clearing_hints");

  if(isDefined(level.tempHint)) {
    level.tempHint destroyElem();
  }

  level.tempHint = createFontString("default", 1.5);
  level.tempHint setPoint("BOTTOM", undefined, 0, -40);
  level.tempHint.color = (1, 1, 1);
  level.tempHint setText(string);
  level.tempHint.alpha = 0;
  level.tempHint fadeOverTime(0.5);
  level.tempHint.alpha = 1;
  level.tempHint.sort = 1;
  wait(0.5);
  level.tempHint endon("death");

  if(isDefined(timeOut)) {
    wait(timeOut);
  } else {
    return;
  }

  level.tempHint fadeOverTime(hintfade);
  level.tempHint.alpha = 0;
  wait(hintfade);

  level.tempHint destroyElem();
}

vehicle_animated_think() {
  self hide();
  aRideSpawners = undefined;
  if(isDefined(self.target)) {
    aRideSpawners = getEntArray(self.target, "targetname");
  }
  reference = spawn("script_origin", self.origin);
  self thread delete_on_death(reference);
  reference.origin = self.origin;
  reference.angles = self.angles;
  attachedEffects = undefined;
  sAnimIdle = self.animation + "_idle";
  eOrgFx = spawn("script_origin", self.origin);
  reference thread ent_cleanup(self);
  eOrgFx thread ent_cleanup(self);
  loop = undefined;
  groundFx = undefined;
  bHasRotors = false;
  switch (self.animation) {
    case "sniper_escape_ch46_take_off":
      self.animname = "seaknight";
      loop = "seaknight_idle_high";
      groundFx = "heli_dust_default";
      bHasRotors = true;
      break;
  }
  self assign_animtree(self.animname);
  reference anim_first_frame_solo(self, self.animation);

  self waittill("spawn");
  if(isDefined(aRideSpawners)) {
    aRiders = [];
    foreach(spawner in aRideSpawners) {
      aRiders[aRiders.size] = thread dronespawn(spawner);
    }
    self delaythread(.05, ::animated_seaknight_riders_think, aRiders);
  }

  self show();
  if(anim_exists(sAnimIdle, self.animname)) {
    reference thread anim_loop_solo(self, sAnimIdle, "stop_idle");
  }
  if(bHasRotors) {
    self thread vehicle_animated_rotors();
  }
  if(isDefined(loop)) {
    self thread play_loop_sound_on_entity(loop);
  }
  if(isDefined(groundFx)) {
    self thread vehicle_animated_ground_fx(eOrgFx, groundFx);
  }
  self waittill("play_anim");
  self notify_delay("taking_off", 4);
  reference notify("stop_idle");
  if((isDefined(self.targetname)) && (self.targetname == "seaknight_loader_start2")) {
    self linkTo(reference);
    reference thread hack_height_for_seaknight();
  }

  reference anim_single_solo(self, self.animation);
  self delete();
}
hack_height_for_seaknight() {
  wait(5);
  self moveto(self.origin + (0, 0, 550), 10);
}

animated_seaknight_riders_think(aRiders) {
  i = 0;
  foreach(rider in aRiders) {
    i++;
    rider.dontDoNotetracks = true;
    rider.anim_variation = i;
    self anim_generic_first_frame(rider, "ch46_load_" + rider.anim_variation, "tag_detach");
  }

  assertex(i < 5, "Too many riders...can't have more than 4");

  self waittill("load_riders");

  lastAnimPlayed = undefined;

  self notify("stop_rider_idle");
  foreach(rider in aRiders) {
    self thread anim_generic(rider, "ch46_load_" + rider.anim_variation, "tag_detach");
    rider thread delete_at_end_of_anim();
    lastAnimPlayed = "ch46_load_" + rider.anim_variation;
  }
  time = getanimlength(level.scr_anim["generic"][lastAnimPlayed]);
  wait(time - 2);
  self notify("riders_loaded");
}

delete_at_end_of_anim() {
  self endon("death");
  self waittillmatch("single anim", "end");
  self AI_delete();
}

vehicle_animated_ground_fx(eOrgFx, groundFx) {
  self endon("death");
  self endon("taking_off");
  while(isDefined(eOrgFx)) {
    playFX(getfx(groundFx), eOrgFx.origin);
    wait(0.1);
  }
}

vehicle_animated_rotors() {
  self endon("death");
  xanim = self getanim("rotors");
  length = getanimlength(xanim);

  while(true) {
    if(!isDefined(self)) {
      break;
    }
    self setanim(xanim);
    wait length;
  }
}

waittill_death_or_timeout(timeout) {
  self endon("death");
  wait(timeout);
}

AI_cleanup(sTeam, dist, bImmediate) {
  aAI_to_delete = undefined;
  if(sTeam == "all") {
    aAI_to_delete = getaiarray();
  } else {
    aAI_to_delete = getaiarray(sTeam);
  }
  if(isDefined(bImmediate)) {
    array_thread(aAI_to_delete, ::AI_delete);
  } else {
    if(!isDefined(dist)) {
      dist = 1024;
    }
    thread AI_delete_when_out_of_sight(aAI_to_delete, dist);
  }
}

AI_drone_cleanup(sTeam, dist, bImmediate) {
  if(!isDefined(sTeam)) {
    sTeam = "all";
  }

  aDrones = [];
  if(sTeam == "all") {
    aDrones = array_merge(level.drones["allies"].array, level.drones["axis"].array);
    aDrones = array_merge(aDrones, level.drones["neutral"].array);
  } else
    aDrones = level.drones[sTeam].array;

  if(isDefined(bImmediate)) {
    array_thread(aDrones, ::AI_delete);
  } else {
    if(!isDefined(dist)) {
      dist = 1024;
    }
    thread AI_delete_when_out_of_sight(aDrones, dist);
  }
}

AI_door_breaker_think() {
  self endon("death");
  self thread magic_bullet_shield();
  self setgoalpos(self.origin);
  door_actors = getEntArray("roof_door", "targetname");
  trigger = undefined;
  org = undefined;
  door = undefined;
  eNode = getnode(self.target, "targetname");

  foreach(ent in door_actors) {
    if(ent.code_classname == "script_origin") {
      org = ent;
      continue;
    } else if(ent.code_classname == "trigger_multiple") {
      trigger = ent;
      continue;
    } else if(ent.code_classname == "script_brushmodel") {
      door = ent;
      continue;
    } else
      eNode = ent;
  }

  while(true) {
    wait(0.05);
    if(level.player istouching(trigger)) {
      continue;
    }
    if(flag("door_being_blocked")) {
      continue;
    }
    break;
  }

  door thread door_fall_over(org);

  self thread stop_magic_bullet_shield();

  self.goalradius = 16;
  self setgoalnode(eNode);

  wait(4);
  self thread AI_player_seek();
}

door_fall_over(org) {
  forward = anglesToForward(org.angles);
  self thread play_sound_in_space("door_wood_double_kick");
  playFX(getfx("door_kick_dust"), org.origin, forward);
  earthquake(.2, .75, self.origin, 1024);
  self connectpaths();
  self notsolid();
  self moveto(self.origin + (0, 0, 2), .5, 0, .5);
  self rotatepitch(-90, 0.45, 0.40);
  wait 0.449;
  self rotateroll(4, 0.2, 0, 0.2);
  wait 0.2;
  self rotateroll(-4, 0.15, 0.15);
}

AI_player_seek() {
  self endon("death");
  self endon("stop_seeking");
  self enable_danger_react(3);

  self.neverEnableCQB = true;
  self.grenadeawareness = 0;
  self.ignoresuppression = true;
  self.goalheight = 100;
  self.aggressivemode = true;
  newGoalRadius = distance(self.origin, level.player.origin);
  while(isalive(self)) {
    wait 1;
    self.goalradius = newGoalRadius;

    self setgoalentity(level.player);

    newGoalRadius -= 175;
    if(newGoalRadius < 512) {
      newGoalRadius = 512;
      return;
    }
  }
}

AI_cleanup_non_squad(sTeam, dist) {
  if(!isDefined(dist)) {
    dist = 1024;
  }
  if(sTeam == "all") {
    aAI = getaiarray();
  } else {
    aAI = getaiarray(sTeam);
  }
  if((sTeam == "allies") || (sTeam == "all")) {
    foreach(guy in level.squad) {
      if(is_in_array(aAI, guy)) {
        aAI = array_remove(aAI, guy);
      }
    }
  }

  thread AI_delete_when_out_of_sight(aAI, dist);
}

AI_cleanup_volume(sVolume, sTeam, dist) {
  if(!isDefined(dist)) {
    dist = 1024;
  }
  eVolume = getent(sVolume, "targetname");
  aAI_to_delete = eVolume get_ai_touching_volume(sTeam);

  if(sTeam != "axis") {
    level.squad = remove_dead_from_array(level.squad);
    foreach(guy in level.squad) {
      if(is_in_array(aAI_to_delete, guy)) {
        aAI_to_delete = array_remove(aAI_to_delete, guy);
      }
    }
  }
  thread AI_delete_when_out_of_sight(aAI_to_delete, dist);
}

ent_cleanup(owner) {
  owner waittill("death");
  owner endon("death");
  if(isDefined(self)) {
    self delete();
  }
}

nag_wait() {
  wait(randomfloatrange(13, 19));
}

player_killing_crow_targets_at_a_good_pace() {
  currentTime = getTime();
  timeElapsed = currentTime - level.lasttimePlayerKilledEnemy;
  if(currentTime == level.lasttimePlayerKilledEnemy) {
    return true;
  } else if(timeElapsed > 10000) {
    return false;
  } else {
    return true;
  }
}

drone_flood_start(aSpawners, groupName) {
  level endon("stop_drone_flood" + groupName);
  while(true) {
    foreach(spawner in aSpawners) {
      delaythread(randomfloatrange(5, 6), ::dronespawn, spawner);
    }
    wait(randomfloatrange(5, 6));
  }
}

drone_flood_stop(groupName) {
  level notify("stop_drone_flood" + groupName);
}

drone_vehicle_flood_start(aSpawners, groupName, minWait, maxWait, noSound) {
  level endon("stop_drone_vehicle_flood" + groupName);
  vehicle = undefined;
  while(true) {
    foreach(spawner in aSpawners) {
      vehicle = spawner thread spawn_vehicle_and_gopath();

      vehicle = undefined;
      wait(randomfloatrange(minWait, maxWait));
    }
    aSpawners = array_randomize(aSpawners);
  }
}

drone_vehicle_flood_stop(groupName) {
  level notify("stop_drone_vehicle_flood" + groupName);
}

AI_invisible_patrol_fodder_think() {
  self endon("death");
  self hide();
  self thread magic_bullet_shield();
  self.a.disablePain = true;
  self.ignoreall = true;

  self.walkdist = 1000;
  self.disablearrivals = true;
  self clearEnemy();
  wait(0.1);
  self thread maps\_patrol::patrol();
}

AI_at4_friendly_think() {}

spawn_trigger_dummy(sDummyTargetname) {
  ent = getent(sDummyTargetname, "targetname");
  assert(isDefined(ent));
  assert(isDefined(ent.script_linkTo));
  trig = getent(ent.script_linkTo, "script_linkname");
  assert(isDefined(trig));
  trig notify("trigger", level.player);
}

friendly_speed_adjustment_on() {
  level.squad = remove_dead_from_array(level.squad);
  array_thread(level.squad, ::friendly_adjust_movement_speed);
}

friendly_speed_adjustment_off() {
  level.squad = remove_dead_from_array(level.squad);
  foreach(guy in level.squad) {
    guy notify("stop_adjust_movement_speed");
    guy.moveplaybackrate = 1.0;
  }
}

friendly_adjust_movement_speed() {
  self notify("stop_adjust_movement_speed");
  self endon("death");
  self endon("stop_adjust_movement_speed");

  while(isalive(self)) {
    wait randomfloatrange(.5, 1.5);

    while(friendly_should_speed_up()) {
      self.moveplaybackrate = 3.5;
      wait 0.05;
    }

    self.moveplaybackrate = 1.0;
  }
}

friendly_should_speed_up() {
  self endon("death");
  prof_begin("friendly_movement_rate_math");

  if(!isDefined(self.goalpos)) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  if(distanceSquared(self.origin, self.goalpos) <= level.goodFriendlyDistanceFromPlayerSquared) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  if(within_fov(level.player.origin, level.player getPlayerAngles(), self.origin, level.cosine["90"])) {
    prof_end("friendly_movement_rate_math");
    return false;
  }

  prof_end("friendly_movement_rate_math");

  return true;
}

get_ai_touching_volume_non_squad() {
  aAI = self get_ai_touching_volume();
  foreach(guy in level.squad) {
    if(is_in_array(aAI, guy)) {
      aAI = array_remove(aAI, guy);
    }
  }
  return aAI;
}

ai_cleanup_trigger_think() {
  aLinkedVolumes = get_linked_ents();
  self waittill("trigger");
  aAI = undefined;
  foreach(volume in aLinkedVolumes) {
    aAI = volume get_ai_touching_volume("axis");
    if(!aAI.size) {
      continue;
    }
    array_call(aAI, ::delete);
  }
  self delete();
}

redshirt_trigger_think() {
  while(true) {
    self waittill("trigger");
    iRedshirtsToSpawn = undefined;
    aSpawners = undefined;
    level.squad = remove_dead_from_array(level.squad);
    guy = undefined;
    if(level.squad.size < level.squadsize) {
      aSpawners = getEntArray(self.target, "targetname");
      assertex(aSpawners.size > 1, "Redshirt_trigger at " + self.origin + " needs to target at least 2 spawners");
      iRedshirtsToSpawn = (level.squadsize - level.squad.size);
      for(i = 0; i < iRedshirtsToSpawn; i++) {
        guy = aSpawners[i] spawn_ai();
        if(isDefined(guy)) {
          guy set_force_color("p");
          level.squad = array_add(level.squad, guy);
          guy thread friendly_squad_think();
        }
      }
    }
    wait(10);
  }
}

killSpawner(num) {
  thread maps\_spawner::kill_spawnerNum(num);
}

rpg_targets_think() {
  eTrigger = getent(self.script_Linkto, "script_linkname");
  eRPGsource = getent(self.target, "targetname");
  sFlagToEnd = self.script_flag;
  level endon(sFlagToEnd);
  assert(isDefined(eTrigger));
  assert(isDefined(eRPGsource));
  while(!flag(sFlagToEnd)) {
    eTrigger waittill("trigger");
    if(level.firemagicRPGs == false) {
      wait(1);
    } else if(within_fov(level.player getEye(), level.player getPlayerAngles(), self.origin, level.cosine["60"])) {
      MagicBullet("rpg", eRPGsource.origin, self.origin);
      level.firemagicRPGs = false;
      wait(4);
      level.firemagicRPGs = true;
      break;
    } else
      wait(1);
  }
}

fx_management() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  level.effects_commerce = [];
  level.effects_trenches = [];
  level.effects_bunker = [];
  level.effects_ww2 = [];
  level.effects_lincoln = [];

  triggered_fx_volumes = getEntArray("triggered_fx_volumes", "targetname");
  foreach(volume in triggered_fx_volumes) {
    volume.fx = [];
  }

  effects_commerce = getent("effects_commerce", "script_noteworthy");
  effects_trenches = getent("effects_trenches", "script_noteworthy");
  effects_bunker = getent("effects_bunker", "script_noteworthy");
  effects_ww2 = getent("effects_ww2", "script_noteworthy");
  effects_lincoln = getent("effects_lincoln", "script_noteworthy");

  dummy = spawn("script_origin", (0, 0, 0));
  for(i = 0; i < level.createfxent.size; i++) {
    EntFx = level.createfxent[i];
    dummy.origin = EntFx.v["origin"];

    foreach(volume in triggered_fx_volumes) {
      if(dummy istouching(volume)) {
        volume.fx[volume.fx.size] = EntFx;
      }
    }

    if(dummy istouching(effects_commerce)) {
      level.effects_commerce[level.effects_commerce.size] = EntFx;
      continue;
    }
    if(dummy istouching(effects_trenches)) {
      level.effects_trenches[level.effects_trenches.size] = EntFx;
      continue;
    }
    if(dummy istouching(effects_bunker)) {
      level.effects_bunker[level.effects_bunker.size] = EntFx;
      continue;
    }
    if(dummy istouching(effects_ww2)) {
      level.effects_ww2[level.effects_ww2.size] = EntFx;
      continue;
    }
    if(dummy istouching(effects_lincoln)) {
      level.effects_lincoln[level.effects_lincoln.size] = EntFx;
      continue;
    }
  }

  dummy delete();

  foreach(volume in triggered_fx_volumes) {
    triggers = getEntArray(volume.target, "targetname");
    assertex(triggers.size == 2, "Volume at " + volume.origin + "needs to target 2 triggers");
    if(triggers[0].script_noteworthy == "stopFx") {
      triggers[0] thread fx_trigger_off_think(volume);
      triggers[1] thread fx_trigger_on_think(volume);
    } else {
      triggers[1] thread fx_trigger_off_think(volume);
      triggers[0] thread fx_trigger_on_think(volume);
    }
  }
}

fx_trigger_on_think(volume) {
  while(true) {
    self waittill("trigger");
    array_thread(volume.fx, ::restartEffect);
    wait(1);
  }
}

fx_trigger_off_think(volume) {
  wait(1);
  array_thread(volume.fx, ::pauseEffect);

  while(true) {
    self waittill("trigger");
    array_thread(volume.fx, ::pauseEffect);
    wait(1);
  }
}

cheap_destructibles_think() {
  flag_wait("player_heli_10a");

  self setCanDamage(true);

  hitsRemaining = 5;

  effect = "cheap_vehicle_explosion";
  destroyedModel = undefined;
  bEarthquake = false;
  sound = "car_explode";
  fireFx = undefined;
  fireOffset = (0, 0, 0);
  onFire = false;
  switch (self.model) {
    case "vehicle_mack_truck_short_green":
      hitsRemaining = 10;
      destroyedModel = "vehicle_mack_truck_short_destroy";
      effect = "cheap_mack_truck_explosion";

      sound = "exp_tanker_vehicle";
      fireFx = "tanker_fire";
      fireOffset = (0, 0, 110);
      bEarthquake = true;
      break;
    case "vehicle_uaz_fabric_static":
      destroyedModel = "vehicle_uaz_fabric_dsr";
      break;
    case "vehicle_luxurysedan_2008_destructible":
      destroyedModel = "vehicle_luxurysedan_2008_destroy";
      break;
    case "vehicle_pickup_technical":
      destroyedModel = "vehicle_pickup_technical_destroyed";
      break;
  }

  while(true) {
    self waittill("damage", damage, attacker);

    if(!isDefined(attacker)) {
      continue;
    }
    if((isDefined(level.blackhawk)) && (attacker != level.blackhawk)) {
      continue;
    }
    hitsRemaining--;

    if(hitsRemaining <= 0) {
      break;
    }
  }

  playFX(getfx(effect), self.origin);
  self thread play_sound_in_space(sound);
  if(bEarthquake) {
    earthquake(.4, 1.53, self.origin, 1024);
  }

  if(isDefined(destroyedModel)) {
    self setModel(destroyedModel);
  } else {
    self delete();
  }

  if(isDefined(fireFx)) {
    dummy = spawn("script_origin", self.origin + fireOffset);
    dummy.angles = self.angles;
    fx = spawnFx(getFx(fireFx), dummy.origin);
    triggerFx(fx);
    flag_wait("player_heli_19");
    fx delete();
    dummy delete();
  }
}

vehicle_delete_non_squad() {
  vehicles_to_delete1 = level.vehicles["axis"];
  vehicles_to_delete2 = level.vehicles["allies"];
  vehicles_to_delete2 = array_remove(vehicles_to_delete2, level.blackhawk);
  foreach(vehicle in vehicles_to_delete2) {
    if(!isDefined(vehicle)) {
      continue;
    }
    if((isDefined(vehicle.vehicletype)) && (GetSubStr(vehicle.vehicletype, 0) == "littlebird")) {
      vehicles_to_delete2 = array_remove(vehicles_to_delete2, vehicle);
    }
  }
  vehicles_to_delete = array_merge(vehicles_to_delete1, vehicles_to_delete2);
  vehicles_to_delete = remove_dead_from_array(vehicles_to_delete);
  foreach(vehicle in vehicles_to_delete) {
    if(!isDefined(vehicle)) {
      continue;
    }
    vehicle maps\_vehicle::godoff();
    vehicle delete();
  }
}

vehicle_delete_all() {
  vehicles_to_delete1 = level.vehicles["axis"];
  vehicles_to_delete2 = level.vehicles["allies"];
  vehicles_to_delete = array_merge(vehicles_to_delete1, vehicles_to_delete2);
  foreach(vehicle in vehicles_to_delete) {
    if(!isDefined(vehicle)) {
      continue;
    }
    vehicle maps\_vehicle::godoff();
    vehicle vehicle_delete();
  }
}

vehicle_delete_all_axis() {
  vehicles_to_delete = level.vehicles["axis"];
  foreach(vehicle in vehicles_to_delete) {
    if(!isDefined(vehicle)) {
      continue;
    }
    vehicle maps\_vehicle::godoff();
    vehicle vehicle_delete();
  }
}

should_break_m203_hint(nothing) {
  player = get_player_from_self();
  assert(isPlayer(player));

  if(gettime() > level.grenadeHint_timeout) {
    return true;
  }

  weapon = player getcurrentweapon();
  prefix = getsubstr(weapon, 0, 4);
  if(prefix == "m203") {
    return true;
  }

  heldweapons = player GetWeaponsListAll();
  foreach(weapon in heldweapons) {
    prefix = getsubstr(weapon, 0, 4);
    if(prefix != "m203") {
      continue;
    }
    ammo = player getWeaponAmmoClip(weapon);
    if(ammo > 0) {
      return false;
    }
  }

  return true;
}

drones_trenches() {
  drone_warriors_trenches = getEntArray("drone_warriors_trenches", "targetname");
  foreach(drone in drone_warriors_trenches) {
    thread dronespawn(drone);
  }
}

struct_delete(array, sFlag) {
  flag_wait(sFlag);
  foreach(member in array) {
    member = undefined;
  }
}

play_sound_then_kill_on_flag(sLine, origin, sFlag) {
  soundOrg = spawn_tag_origin();
  soundOrg.origin = origin;
  soundOrg thread kill_me_on_flag(sFlag);
  soundOrg play_sound_on_tag_endon_death(sLine, "tag_origin");
  if(isDefined(soundOrg)) {
    soundOrg delete();
  }
}

kill_me_on_flag(sFlag) {
  self endon("death");
  flag_wait(sFlag);
  if(isDefined(self)) {
    self delete();
  }
}

remove_dead_targets_from_array(array) {
  newArray = [];
  foreach(ent in array) {
    if(!isDefined(ent)) {
      continue;
    }
    if(!isDefined(ent.dead)) {
      newArray[newArray.size] = ent;
    }
  }
  return newArray;
}

destructible_trigger_think() {
  self waittill("trigger");

  playFX(level._effect["mortar"]["dirt"], self.origin);
  earthquake(0.25, 0.75, self.origin, 1250);
  thread play_sound_in_space(level.scr_sound["mortar"]["dirt"], self.origin);
  radiusDamage(self.origin, self.fixedNodeSafeRadius, 1000, 1000);
}

escape_timer(iSeconds) {
  level endon("obj_rooftop_complete");
  level endon("kill_timer");

  level.hudTimerIndex = 20;
  level.timer = maps\_hud_util::get_countdown_hud();
  level.timer SetPulseFX(30, 900000, 700);

  level.timer.label = &"DCBURNING_TIME_REMAINING";
  level.timer settenthstimer(iSeconds);

  thread timer_tick();
  wait(iSeconds);
  level.timer destroy();
  level thread mission_failed_out_of_time();
}

timer_tick() {
  level endon("obj_rooftop_complete");
  level endon("kill_timer");
  while(true) {
    wait(1);
    level.player thread play_sound_on_entity("countdown_beep");
  }
}

mission_failed_out_of_time() {
  level.player endon("death");
  level endon("kill_timer");
  level notify("mission failed");
  musicstop(1);

  setDvar("ui_deadquote", &"DCBURNING_RAN_OUT_OF_TIME");
  maps\_utility::missionFailedWrapper();
  level notify("kill_timer");
}

kill_timer() {
  level notify("kill_timer");
  if(isDefined(level.timer)) {
    level.timer destroy();
  }
}

vehicle_delete_when_hit_script_noteworthy(script_noteworthy) {
  self endon("death");
  aPathNodes = vehicle_get_path_array();
  deleteNode = undefined;
  foreach(node in aPathNodes) {
    if((isDefined(node.script_noteworthy)) && (node.script_noteworthy == script_noteworthy)) {
      deleteNode = node;
      break;
    }
  }
  assertex(isDefined(deleteNode), "Vehicle at " + self.origin + " has no node in its chain with the script_noteworthy: " + script_noteworthy);
  deleteNode waittill("trigger");
  self notify("deleted_through_script");
  wait(0.05);
  self thread vehicle_delete();
}

vehicle_delete_when_out_of_sight() {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  while(isDefined(self)) {
    wait(2);
    if(within_fov(level.player.origin, level.player.angles, self.origin, level.cosine["90"])) {
      continue;
    }
    break;
  }
  self thread vehicle_delete();
}

waittill_notify_then_notify(notifyToWaitFor, notifyToNotify) {
  self endon("death");
  self waittill(notifyToWaitFor);
  self notify(notifyToNotify);
}

waittill_flag_then_notify(flagToWaitFor, notifyToNotify) {
  self endon("death");
  flag_wait(flagToWaitFor);
  self notify(notifyToNotify);
}

player_blackhawk_health_tweaks() {
  level.player enableinvulnerability();
}

flag_set_when_volume_cleared_of_bad_guys(volume, sFlagToSet) {
  while(true) {
    wait(1);
    ai = volume get_ai_touching_volume("axis");
    if(!isDefined(ai)) {
      break;
    }
    if(ai.size) {
      continue;
    } else {
      break;
    }
  }
  flag_set(sFlagToSet);
}