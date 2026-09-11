/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\plane_hijack\cp_plane_hijack.gsc
***********************************************************************/

function main() {
  load_fx();
  scripts\cp\maps\cp_donetsk\milbase\ai_flare::load_fx();
  level thread scripts\cp\cp_breach_c4::main();
  register_plane_hijack_objectives();
  scripts\engine\utility::flag_init("cp_plane_hijack_interactions_registered");

  if(!scripts\engine\utility::flag_exist("cp_plane_hijack_cs_completed")) {
    scripts\engine\utility::flag_init("cp_plane_hijack_cs_completed");
  }

  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  level.unload_fx_func = &smoke_up_landing_zone_for_enemy_ai;
  thread register_interactions();
  thread heli_crash_path_loc_setup();
  register_spawn_functions();
  claxon_light_init();
  thread spawn_and_start_c130();

  if(getdvarint("scr_phj_giveLoadout", 0) != 0) {
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&player_give_gg_loadout);
  }

  stealth_init();
  init_plane_anims();
  init_player_seating_anims();
  init_player_seated_anims();
  syncleadmarkers();
  swivel_dogtag_revive();
  init_alarm_system();
  thread global_weapons_free();
  thread load_scriptable_garage_door();
  level.stealth_soundaliases = ["ui_stealth_threat_low_lp", "ui_stealth_threat_med_lp", "ui_stealth_threat_high_lp"];
}

function load_scriptable_garage_door() {
  while(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    wait 1;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");
  level.garage_door = getEnt("garage_door", "script_noteworthy");
  level.garage_door.current_state = 0;
  level.garage_door.trial_moving_target_mover = getEnt("garage_button_indoors", "targetname");
  level.garage_door.trial_moving_target_mover setHintString(&"CP_FUBAR/OPEN_GARAGE");
  level.garage_door.trial_moving_target_mover setCursorHint("HINT_BUTTON");
  level.garage_door.trial_moving_target_mover sethintdisplayrange(50);
  level.garage_door.trial_moving_target_mover sethintdisplayfov(65);
  level.garage_door.trial_moving_target_mover setuserange(50);
  level.garage_door.trial_moving_target_mover setusefov(65);
  level.garage_door.trial_moving_target_mover sethintonobstruction("hide");
  level.garage_door.trial_moving_target_mover makeusable();
  level.garage_door.trial_moving_target_mover delete();
  level.garage_door.door_interaction = spawn("script_model", scripts\engine\utility::getStruct("garage_button_struct", "targetname").origin);
  level.garage_door.door_interaction makeusable();
  level.garage_door.door_interaction setHintString(&"CP_FUBAR/OPEN_GARAGE");
  level.garage_door.door_interaction setCursorHint("HINT_BUTTON");
  level.garage_door.door_interaction sethintdisplayrange(32);
  level.garage_door.door_interaction sethintdisplayfov(180);
  level.garage_door.door_interaction setuserange(32);
  level.garage_door.door_interaction setusefov(180);
  level.garage_door.door_interaction sethintonobstruction("hide");
  thread use_garage();
}

function load_fx() {
  level._effect["plane_explosion"] = loadfx("vfx/iw8_cp/vfx_cp_ac130_explode_fireball.vfx");
  level._effect["breach_explosion_plane"] = loadfx("vfx/iw8_cp/vfx_cp_plane_door_breach.vfx");
  level._effect["breach_jugg_smoke"] = loadfx("vfx/iw8_cp/vfx_cp_jug_reveal_smoke.vfx");
  level._effect["breach_jugg_explosion"] = loadfx("vfx/iw8_cp/vfx_cp_plane_door_breach_jug.vfx");
  level._effect["breach_scrn_fx"] = loadfx("vfx/iw8_cp/vfx_cp_plane_breach_wind.vfx");
  level._effect["end_breach_smoke_fx"] = loadfx("vfx/iw8_cp/cp_plane_post_breach.vfx");
  level._effect["plane_landing_fx"] = loadfx("vfx/iw8_cp/vfx_cp_ac130_landing.vfx");
  level._effect["smoke_door_fx"] = loadfx("vfx/iw8_cp/vfx_cp_plane_smoke_post_breach.vfx");
  level._effect["vfx_klaxon_flare2"] = loadfx("vfx/iw8/light/vfx_klaxon_flare2.vfx");
  level._effect["static_plane_lights"] = loadfx("vfx/iw8/light/vfx_klaxon_flare2.vfx");
}

function global_weapons_free() {
  self notify("global_weapons_free");
  self endon("global_weapons_free");

  if(!isDefined(level.global_stealth_tracker)) {
    level.global_stealth_tracker = [];
  }

  if(!isDefined(level.global_stealth_tracker["hack_rooftop"])) {
    level.global_stealth_tracker["hack_rooftop"] = 0;
  }

  if(!isDefined(level.global_stealth_tracker["hack_airport"])) {
    level.global_stealth_tracker["hack_airport"] = 0;
  }

  if(!isDefined(level.global_stealth_tracker["plane_patrol"])) {
    level.global_stealth_tracker["plane_patrol"] = 0;
  }

  level waittill("weapons_free");
  var0 = 5;

  if(scripts\cp\cp_objectives::is_objective_active("plant_jammers") && isDefined(level.hack_region) && level.hack_region == "parking_lot") {
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_airport");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop_guards");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop_skit");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop_sniper");
    level.global_stealth_tracker["hack_rooftop"] = 1;
    var0 = 15;
    thread spawn_waves_after_a_delay(level, var0, undefined);
    scripts\cp\crate_drops\cp_crate_drops::ref_12c40("hijack_1");
  }

  if(scripts\cp\cp_objectives::is_objective_active("plant_jammers") && isDefined(level.hack_region) && level.hack_region == "airport") {
    level.global_stealth_tracker["hack_airport"] = 1;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_airport");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop_guards");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop_skit");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop_sniper");
    var0 = 15;
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_spawning", [ &scripts\cp\cp_modular_spawning::ref_11cac, 750]);
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_spawning", [ &scripts\cp\cp_modular_spawning::ref_11cab, 64]);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
    scripts\cp\cp_modular_spawning::run_spawn_module("hack_airport_combat");
  }

  if(scripts\cp\cp_objectives::is_objective_active("infil_plane") || scripts\cp\cp_objectives::is_objective_active("equip_disguise")) {
    level.global_stealth_tracker["plane_patrol"] = 1;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("plane_jugg_guard");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("plane_patrol", 1);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_airport_combat");
    var0 = 2;
    thread spawn_waves_after_a_delay(level, var0, undefined);
    scripts\cp\crate_drops\cp_crate_drops::ref_12c40("hijack_2");
  }

  foreach(var2 in level.alarm_box_structs) {
    thread scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_alarm(var2, var2.alarm_box);
  }

  level scripts\engine\utility::waittill_notify_or_timeout("alarm_on", 30);

  foreach(var2 in level.alarm_box_structs) {
    var2 notify("stop_attracting");
  }

  foreach(var7 in getaiarray("axis")) {
    if(isDefined(var7.going_to_object)) {
      var7.going_to_object = undefined;
      var7.goalradius = 2048;
      var7 scripts\cp\maps\cp_donetsk\milbase\ai_flare::clear_custom_anim();
    }
  }
}

function spawn_waves_after_a_delay(var0, var1, var2) {
  level endon("game_ended");

  if(isDefined(var0)) {
    wait var0 / 2;

    if(istrue(var1)) {
      thread scripts\cp\cp_modular_spawning::run_spawn_module("techo_phys_boneyard1");
      thread scripts\cp\cp_modular_spawning::run_spawn_module("techo_phys_boneyard2");
      thread scripts\cp\cp_modular_spawning::run_spawn_module("techo_phys_boneyard3");
    }

    wait var0 / 2;
  }

  var3 = scripts\cp\cp_modular_spawning::set_wave_ref_override(var2);
  return var3;
}

function init_alarm_system() {
  level.alarm_box_structs = scripts\engine\utility::getStructArray("alarm_box", "targetname");

  foreach(var1 in level.alarm_box_structs) {
    scripts\cp\maps\cp_donetsk\milbase\ai_flare::initialize_alarm_box(var1);
    var1.alarm_box makeunusable();
  }
}

#using_animtree("");

function init_plane_anims() {
  level.scr_animtree["plane"] = #animtree;
  level.scr_model["plane"] = "veh8_mil_air_plima_animated";
  level.scr_anim["plane"]["open"] = $cp_scripted_plane_door_open;
  level.scr_animname["plane"]["open"] = "cp_scripted_plane_door_open";
  level.scr_eventanim["plane"]["open"] = "plane_door_open";
  level.scr_anim["plane"]["close"] = % cp_scripted_plane_door_close;
  level.scr_animname["plane"]["close"] = "cp_scripted_plane_door_close";
  level.scr_eventanim["plane"]["close"] = "plane_door_close";
  level.scr_anim["plane"]["landing"] = % cp_scripted_tacops_plane_land;
  level.scr_animname["plane"]["landing"] = "cp_scripted_tacops_plane_land";
  level.scr_eventanim["plane"]["landing"] = "tacops_plane_land";
  level.scr_anim["plane"]["idle"] = % cp_scripted_tacops_plane_idle;
  level.scr_animname["plane"]["idle"] = "cp_scripted_tacops_plane_idle";
  level.scr_eventanim["plane"]["idle"] = "tacops_plane_idle";
  level.scr_anim["plane"]["takeoff"] = % cp_scripted_tacops_plane_takeoff;
  level.scr_animname["plane"]["takeoff"] = "cp_scripted_tacops_plane_takeoff";
  level.scr_eventanim["plane"]["takeoff"] = "tacops_plane_takeoff";
}

function init_player_seating_anims() {
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["plane_sitting_in"] = % cp_scripted_plane_sit_in;
  level.scr_animname["player"]["plane_sitting_in"] = "cp_scripted_plane_sit_in";
  level.scr_eventanim["player"]["plane_sitting_in"] = "plane_sit_in";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["plane_sitting_exit"] = % cp_scripted_plane_sit_exit;
  level.scr_animname["player"]["plane_sitting_exit"] = "cp_scripted_plane_sit_exit";
  level.scr_eventanim["player"]["plane_sitting_exit"] = "plane_sit_exit";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["plane_sitting_loop_01"][0] = % cp_scripted_plane_sit_loop_01;
  level.scr_animname["player"]["plane_sitting_loop_01"] = "cp_scripted_plane_sit_loop_01";
  level.scr_eventanim["player"]["plane_sitting_loop_01"][0] = "plane_sit_loop_01";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["plane_sitting_loop_02"][0] = % cp_scripted_plane_sit_loop_02;
  level.scr_animname["player"]["plane_sitting_loop_02"] = "cp_scripted_plane_sit_loop_02";
  level.scr_eventanim["player"]["plane_sitting_loop_02"][0] = "plane_sit_loop_02";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["plane_sitting_loop_03"][0] = % cp_scripted_plane_sit_loop_03;
  level.scr_animname["player"]["plane_sitting_loop_03"] = "cp_scripted_plane_sit_loop_03";
  level.scr_eventanim["player"]["plane_sitting_loop_03"][0] = "plane_sit_loop_03";
}

function init_player_seated_anims() {
  if(!isDefined(level.c130_seat_idles)) {
    level.c130_seat_idles = ["seat1", "seat2", "seat3", "seat4"];
  }

  level.scr_animtree["garage_door"] = #animtree;
  level.scr_model["garage_door"] = "door_metal_roller_door";
  level.scr_anim["garage_door"]["garage_open"] = % cp_prop_garagedoor_open;
  level.scr_animname["garage_door"]["garage_open"] = "cp_prop_garagedoor_open";
  level.scr_anim["garage_door"]["garage_close"] = % cp_prop_garagedoor_close;
  level.scr_animname["garage_door"]["garage_close"] = "cp_prop_garagedoor_close";
}

function register_spawn_functions() {
  level.global_stealth_broken = 0;
  scripts\cp\cp_modular_spawning::registerambientgroup("hack_rooftop_skit", 1, 1, 1, 0.05, &call_wave_on_group_killed, "hack_rooftop_skit", &increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("hack_rooftop_skit", &standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("hack_rooftop", 19, 19, 19, 0.05, &call_wave_on_group_killed, "hack_rooftop", &increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("hack_rooftop", &standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("hack_rooftop_sniper", 3, 3, 3, 0.05, &call_wave_on_group_killed, "hack_rooftop_sniper", &increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("hack_rooftop_sniper", &sniper_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("hack_rooftop_guards", 3, 3, 3, 0.05, &call_wave_on_group_killed, "hack_rooftop_guards", &increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("hack_rooftop_guards", &sniper_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("jugg_patrol", 8, 8, 8, 0.05, &call_wave_on_group_killed, "jugg_patrol", &increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("jugg_patrol", &standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("jugg_guard", 2, 2, 2, 0.05, &call_wave_on_group_killed, "jugg_guard", &increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("jugg_guard", &jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("hack_airport", 0, 16, 16, 0.05, &call_wave_on_group_killed, "hack_airport", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("hack_airport", &standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("jugg_stairs_combat", 0, 1, 1, 0.05, &call_wave_on_group_killed, "jugg_stairs_combat", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("jugg_stairs_combat", &jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("hack_airport_jugg_disguise", 1, 1, 1, 0.05, &call_wave_on_group_killed, "hack_airport_jugg_disguise", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("hack_airport_jugg_disguise", &jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("jugg_disguise_combat", 0, 1, 1, 0.05, &call_wave_on_group_killed, "jugg_disguise_combat", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("jugg_disguise_combat", &jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("hack_airport_jugg_stairs", 1, 1, 1, 0.05, &call_wave_on_group_killed, "hack_airport_jugg_stairs", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("hack_airport_jugg_stairs", &jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("jugg_disguise_combat_only", 0, 1, 1, 0.05, &call_wave_on_group_killed, "hack_airport_jugg_stairs", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("jugg_disguise_combat_only", &jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("plane_patrol", 0, 42, 42, 0.05, &call_wave_on_group_killed, "plane_patrol", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("plane_patrol", &plane_patrol_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("tarmac_patrol_plane", 0, 4, 20, 0.05, &call_wave_on_group_killed, "tarmac_patrol_plane", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tarmac_patrol_plane", &plane_patrol_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("tarmac_patrol", 0, 3, 20, 0.05, &call_wave_on_group_killed, "tarmac_patrol", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tarmac_patrol", &plane_patrol_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("plane_jugg_guard", 2, 2, 2, 0.05, &call_wave_on_group_killed, "plane_jugg_guard", &increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("plane_jugg_guard", &jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("hack_airport_combat", 0, 16, undefined, 0.05, &call_wave_on_group_killed, "hack_airport_combat", &setmapcirclesize, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("hack_airport_combat", [ &scripts\cp\cp_modular_spawning::ref_11cab, 64]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("hack_airport_combat", [ &scripts\cp\cp_modular_spawning::ref_11cac, 750]);
  scripts\cp\cp_modular_spawning::registerambientgroup("smhc_spawners", 0, 12, undefined, 0.1, undefined, "smhc_spawners", &scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("smhc_spawners", &standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("paratroopers", 4, 4, undefined, 0.5, 0, "paratroopers", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("parachute_group_1", 4, 4, 4, 0.5, 0, "parachute_group_1");
  scripts\cp\cp_modular_spawning::registerambientgroup("parachute_group_2", 4, 4, 4, 0.5, 0, "parachute_group_2");
  scripts\cp\cp_modular_spawning::registerambientgroup("parachute_group_3", 4, 4, 4, 0.5, 0, "parachute_group_3");
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("hack_airport", &soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("hack_rooftop", &soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("hack_rooftop_sniper", &soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("hack_rooftop_guards", &soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("hack_rooftop_skit", &soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("plane_patrol", &soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("jugg_patrol", &soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("jugg_guard", &jugg_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("plane_jugg_guard", &jugg_death_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("garage_ai", 1, 1, 1, 0.1, undefined, "garage_ai");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("garage_ai", &play_ai_skit);
  scripts\cp\cp_modular_spawning::registerambientgroup("civ_killers", 1, 1, 1, 0.1, undefined, "civ_killers");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("civ_killers", &civ_killers_loop);
  scripts\cp\cp_modular_spawning::registerambientgroup("tunnel_spawners", 4, 4, 4, 0.1, 0, "tunnel_spawners", undefined, undefined, &progress_objective_on_group_killed);
  scripts\cp\cp_modular_spawning::registerambientgroup("tunnel_spawns", 10, 10, 10, 0.1, &call_wave_on_group_killed, "tunnel_spawns", undefined, undefined, &progress_objective_on_group_killed);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tunnel_spawns", &standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("tunnel_spawns", &soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("smoked_tunnel_spawners", 5, 5, 5, 0.1, 0, "smoked_tunnel_spawners", undefined, undefined, &progress_objective_on_group_killed);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("smoked_tunnel_spawners", &standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("smoked_tunnel_spawners", &soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("tunnel_veh_spawners", 4, 4, 4, 0.1, 0, "tunnel_veh_spawners", undefined, undefined, &progress_objective_on_veh_group_killed);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_juggy", 1, 1, 1, 0.1, 0, "mhc_juggy", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_spawn_stg_1", 24, 24, 24, 0.1, 0, "mhc_spawn_stg_1", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_spawn_stg_2", 24, 24, 24, 0.1, 0, "mhc_spawn_stg_2", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_spawn_stg_3", 24, 24, 24, 0.1, 0, "mhc_spawn_stg_3", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_spawn_stg_2_lmg", 4, 4, 4, 0.1, 0, "mhc_spawn_stg_2_lmg", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_spawn_stg_3_shotgun", 2, 2, 2, 0.1, 0, "mhc_spawn_stg_3_shotgun", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_stealth", 5, 5, 5, 0.05, undefined, "mhc_stealth", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mhc_stealth", &watch_for_plane_spawners);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_spawners", 40, 48, 48, 0.05, 0, "mhc_spawners", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_spawn_smokers", 2, 2, 2, 0.1, 0, "mhc_spawn_smokers", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("nuke_defenders", 1, 1, 1, 0.1, 0, "nuke_defenders", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mhc_spawners", &watch_for_players_mhc_spawners);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mhc_spawn_smokers", &watch_for_players_mhc_smokers);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_ll_spawners", 16, 16, 16, 0.1, 0, "mhc_ll_spawners", undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_ll_spawner_1", 4, 24, 24, 0.1, 0, "mhc_ll_spawner_1", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_ll_spawner_2", 5, 20, 24, 0.1, 0, "mhc_ll_spawner_2", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mhc_ll_spawner_3", 10, 20, 48, 0.1, 0, "mhc_ll_spawner_3", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("lower_level_jug", 2, 2, 2, 0.1, 0, "lower_level_jug", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("lower_level_jug", &lower_level_jugg_properties);
  scripts\cp\cp_modular_spawning::force_module_cqb_scoring("mhc_ll_spawner_1");
  scripts\cp\cp_modular_spawning::force_module_cqb_scoring("mhc_ll_spawner_2");
  scripts\cp\cp_modular_spawning::force_module_cqb_scoring("mhc_ll_spawner_3");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mhc_ll_spawners", &watch_for_players_mhc_spawners);
  scripts\cp\cp_modular_spawning::registerambientgroup("phj_heli_1", 0, 6, 6, 0.1, undefined, "phj_heli_1", &watchforstopwaves, [ &remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("phj_heli_2", 0, 6, 6, 0.1, undefined, "phj_heli_2", &watchforstopwaves, [ &remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("phj_heli_3", 0, 6, 6, 0.1, undefined, "phj_heli_3", &watchforstopwaves, [ &remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("phj_heli_4", 0, 6, 6, 0.1, undefined, "phj_heli_4", &watchforstopwaves, [ &remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("phj_heli_5", 0, 6, 6, 0.1, undefined, "phj_heli_5", &watchforstopwaves, [ &remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_tarmac1", 0, [ &ref_12ce1, 10], &scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "techo_phys_tarmac1", [ &ref_13a96, (-18120, 22629, -390), (-16761, 22629, -390)], "techo_phys_tarmac2", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_tarmac2", 0, [ &ref_12ce1, 10], &scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "techo_phys_tarmac2", [ &ref_13a95, (-16761, 22629, -390), (-15844, 22629, -390), "techo_phys_tarmac1"], "techo_phys_tarmac3", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_tarmac3", 0, [ &ref_12ce1, 10], &scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "techo_phys_tarmac3", [ &ref_13a95, (-15844, 22629, -390), (-15307, 22629, -390), "techo_phys_tarmac2"], "techo_phys_tarmac4", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_tarmac4", 0, [ &ref_12ce1, 10], &scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "techo_phys_tarmac4", [ &ref_13a95, (-15307, 22629, -390), (-14313, 22629, -390), "techo_phys_tarmac3"], "techo_phys_tarmac5", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_tarmac5", 0, [ &ref_12ce1, 10], &scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "techo_phys_tarmac5", [ &ref_13a95, (-14313, 22629, -390), (-13808, 22629, -390), "techo_phys_tarmac4"], "techo_phys_tarmac6", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_tarmac6", 0, [ &ref_12ce1, 10], &scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "techo_phys_tarmac6", [ &ref_13a95, (-13808, 22629, -390), (-13021, 22629, -390), "techo_phys_tarmac5"], "techo_phys_tarmac7", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_tarmac7", 0, [ &ref_12ce1, 10], &scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "techo_phys_tarmac7", [ &ref_13a95, (-13021, 22629, -390), (-12442, 22629, -390), "techo_phys_tarmac6"], "techo_phys_tarmac8", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_tarmac8", 0, [ &ref_12ce1, 10], &scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "techo_phys_tarmac8", [ &ref_13a95, (-12442, 22629, -390), undefined, "techo_phys_tarmac7"], "techo_phys_tarmac9", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_tarmac9", 0, [ &ref_12ce1, 10], &scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "techo_phys_tarmac9", [ &ref_13a95, (-12442, 22629, -390), undefined, "techo_phys_tarmac8"], undefined, undefined);
  scripts\cp\cp_vehicles::ref_12ae5("techo_phys_tarmac1", "techo_phys", [1, 2, 3]);
  scripts\cp\cp_vehicles::ref_12ae5("techo_phys_tarmac2", "techo_phys", [1, 2, 3]);
  scripts\cp\cp_vehicles::ref_12ae5("techo_phys_tarmac3", "techo_phys", [1, 2, 3]);
  scripts\cp\cp_vehicles::ref_12ae5("techo_phys_tarmac4", "techo_phys", [1, 2, 3]);
  scripts\cp\cp_vehicles::ref_12ae5("techo_phys_tarmac5", "techo_phys", [1, 2, 3]);
  scripts\cp\cp_vehicles::ref_12ae5("techo_phys_tarmac6", "techo_phys", [1, 2, 3]);
  scripts\cp\cp_vehicles::ref_12ae5("techo_phys_tarmac7", "techo_phys", [1, 2, 3]);
  scripts\cp\cp_vehicles::ref_12ae5("techo_phys_tarmac8", "techo_phys", [1, 2, 3]);
  scripts\cp\cp_vehicles::ref_12ae5("techo_phys_tarmac9", "techo_phys", [1, 2, 3]);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_boneyard1", 0, 6, 6, 0.1, undefined, "techo_phys_boneyard1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_boneyard2", 0, 6, 6, 0.1, undefined, "techo_phys_boneyard2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_boneyard3", 0, 6, 6, 0.1, undefined, "techo_phys_boneyard3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("runway_jugg", 1, 1, 1, 0.1, 0, "runway_jugg", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("exfil_snipers", 7, 7, 7, 0.1, 0, "exfil_snipers", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("exfil_rpgs", 10, 10, 10, 0.1, 0, "exfil_rpgs", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("exfil_lmgs", 7, 7, 7, 0.1, 0, "exfil_lmgs", undefined, undefined, undefined);
}

function setmapcirclesize(var0) {
  scripts\cp\coop_stealth::increase_script_maxdist(var0);
}

function ref_12bf6() {
  if(isDefined(self.spawnflags)) {
    if(self.spawnflags & 512) {
      self.spawnflags -= 512;
      return;
    }

    return;
  }
}

function ref_12ce1(var0, var1) {
  if(scripts\cp\cp_modular_spawning::shipfx(var0)) {
    mp_hideout_patch(var0);
    return undefined;
  }

  return var1;
}

function remove_group_from_combined_module_counters(var0, var1) {
  level endon("game_ended");
  level endon("all_players_teleported_to_plane");
  level endon("all_enemy_vehicles_leave");
  level endon("cleared_for_takeoff");
  wait var1;

  for(var2 = getaiarray("axis").size; var2 >= 27; var2 = getaiarray("axis").size) {
    wait 4;
  }

  return var0.group_name;
}

function ref_13a96(var0, var1, var2, var3) {
  ref_13a95(var0, var1, var2, var3);
  thread playerhumanhitground();
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("plane_jugg_guard");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("plane_patrol");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("tarmac_patrol");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("tarmac_patrol_plane");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_airport_combat");
}

function playerhumanhitground(var0) {
  var1 = getaiarray("axis");

  for(var2 = 0; var2 < var1.size; var2++) {
    var1[var2] thread scripts\cp\cp_modular_spawning::vehicle_preventplayercollisiondamagefortimeafterexit();
  }
}

function ref_13a95(var0, var1, var2, var3) {
  var0 endon("death");

  if(var0.group_name == "techo_phys_tarmac8") {
    while(!istrue(level.ref_123a3)) {
      waitframe();
    }
  }

  scripts\cp\cp_modular_spawning::ref_130f7(var0, 1);

  if(isDefined(var3)) {
    var0 scripts\cp\cp_modular_spawning::stop_module_by_groupname(var3);
  }

  thread watchforstopwaves(var0);
  var0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var0, (-18165, 21233, -390), (0, 90, 0));

  if(isDefined(var2)) {
    var0 thread scripts\cp\cp_modular_spawning::watch_for_players_beyond_point(var0, var2, (0, 0, 0), &mp_hideout_patch);
  }

  if(isDefined(var1)) {
    var0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var0, var1, (0, 0, 0));
    return;
  }
}

function mp_hideout_patch() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(self.group_name, 1);
}

function watchforstopwaves(var0) {
  thread _watchforstopwaves(var0);
}

function _watchforstopwaves(var0) {
  level endon("game_ended");
  level scripts\engine\utility::ref_143a6("all_enemy_vehicles_leave", "cleared_for_takeoff", "all_players_teleported_to_plane");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function increase_max_dist_and_watch_for_point_crossed(var0, var1, var2, var3) {
  var4 = scripts\cp\cp_modular_spawning::process_module_var(var0, var0.spawn_points);

  for(var5 = 0; var5 < var4.size; var5++) {
    var6 = var4[var5];
    var6.script_maxdist = 20000;
  }
}

function call_wave_on_group_killed(var0, var1, var2, var3) {
  thread call_wave_on_group_killed_interal(var0, var0, var1, var2);
}

function call_wave_on_group_killed_interal(var0, var1, var2, var3) {
  level endon("game_ended");

  if(istrue(level.global_stealth_broken)) {
    return;
  }
}

function watch_for_plane_spawners(var0) {
  self endon("death");
  self.group endon("weapons_free");
  scripts\common\ai::find_and_teleport_to_cover();
  self.fixednode = 1;
}

function watch_for_players_mhc_spawners(var0, var1, var2, var3) {
  self endon("death");

  if(self.agent_type == "actor_enemy_cp_rus_juggernaut") {
    self.juggernautdisablemovebehavior = 1;
    return;
  }

  scripts\common\ai::find_and_teleport_to_cover();
  self.fixednode = 1;
  self.dont_enter_combat = 1;
  self.neverforcesnipermissenemy = 1;
  self.sniperaccuracyset = 1;
  self.baseaccuracy = 1;
  self.combatmode = "ambush";
}

function watch_for_players_mhc_smokers(var0, var1, var2, var3) {
  self endon("death");
}

function watch_for_smokers(var0, var1, var2, var3, var4) {
  self endon("death");
  var1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var1, 562500);
  var2 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var2, 45);
  var4 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var4, 2.5);
  var5 = 0;

  for(;;) {
    self waittill("known_event", var6, var7, var8, var9);

    if(isDefined(var6) && isPlayer(var6)) {
      if(var6 scripts\cp\utility::is_valid_player() && !istrue(var6.ignoreme)) {
        var10 = distancesquared(self.origin, var6.origin);

        if(isDefined(var3)) {
          if(var10 <= var3) {
            self.group scripts\engine\utility::ent_flag_set("weapons_free");
          }
        } else if(var10 <= var1) {
          wait var4;
          self.group scripts\engine\utility::ent_flag_set("weapons_free");
        }
      }
    }
  }
}

function progress_objective_on_group_killed(var0, var1, var2, var3) {
  thread progress_objective_on_group_killed_interal(var0, var0, var1, var2);
}

function progress_objective_on_group_killed_interal(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 waittill("all_group_spawns_dead");
  level.clear_to_pick_disguise_up = 1;
}

function progress_objective_on_veh_group_killed(var0, var1, var2, var3) {
  thread progress_objective_on_veh_group_killed_interal(var0, var0, var1, var2);
}

function progress_objective_on_veh_group_killed_interal(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 waittill("all_group_spawns_dead");
  level.clear_to_pick_disguise_up_veh = 1;
}

function spawn_and_start_c130() {
  level.c130_parts = getEntArray("intro_sit_down_ac130", "targetname");
  var0 = [];
  var1 = [];
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in level.c130_parts) {
    switch (var5.classname) {
      case "script_model":
        if(issubstr(var5.model, "veh8_mil_air_plima")) {
          var5 setModel("veh8_mil_air_plima_animated");
          level.c130 = var5;

          if(!isDefined(level.c130.body)) {
            level.c130.body = [];
          }
        } else if(issubstr(var5.model, "ee_furniture_airplane_seat")) {
          var0 = scripts\engine\utility::array_add(var0, var5);
        } else {
          var1 = scripts\engine\utility::array_add(var1, var5);
        }

        break;
      case "script_brushmodel":
        if(var5.targetname == "rear_door_down") {
          var3 = scripts\engine\utility::array_add(var3, var5);
          break;
        }

        if(var5.targetname == "rear_door_up") {
          var2 = var5;
          break;
        }

        var1 = scripts\engine\utility::array_add(var1, var5);
        break;
    }
  }

  foreach(var8, var5 in var0) {
    var5 linkTo(level.c130);
  }

  foreach(var8, var5 in var1) {
    var5 linkTo(level.c130);
    level.c130.body = scripts\engine\utility::array_add(level.c130.body, var5);
  }

  level.c130_seat_refs = var0;
  level.c130_seat_refs = getEntArray("air_seats", "targetname");
  level.c130.plane_seats = level.c130_seat_refs;
  level.c130.seated_players = 0;
  var10 = getEntArray("plane_seats", "targetname");

  foreach(var8, var5 in level.c130.plane_seats) {
    var5 setModel("ee_furniture_airplane_seat");
    var5 linkTo(level.c130);
  }

  level.ref_12b45 = getEntArray("regroup_points", "targetname");

  foreach(var5 in level.ref_12b45) {
    var5 linkTo(level.c130);
  }

  level.ref_1341e = getEnt("smoke_door_fx", "targetname");
  level.ref_1341e linkTo(level.c130);
  level.ref_12b48 = getEnt("regroup_trigger", "targetname");
  level.ref_12b48 enablelinkTo(level.c130);
  level.ref_12b48 linkTo(level.c130);
  level.air_doors = getEntArray("air_door", "targetname");

  foreach(var5 in level.air_doors) {
    var5 linkTo(level.c130);
  }

  level.exit_parts = getEntArray("exit_breach_ac130", "targetname");

  foreach(var5 in level.exit_parts) {
    var5 linkTo(level.c130);

    if(!isDefined(var5.script_noteworthy)) {
      level.c130.exit_breach_area = var5;
      continue;
    }

    level.c130.exit_breach_door = var5;
  }

  if(isDefined(level.claxons) && isarray(level.claxons) && level.claxons.size > 0) {
    if(isDefined(level.claxons["scripted_plane"])) {
      foreach(var19 in level.claxons["scripted_plane"].models_on) {
        var19 linkTo(level.c130);

        foreach(var21 in var19.lights) {
          var21 linkTo(level.c130);
        }

        var19.model_off linkTo(level.c130);

        foreach(var24 in getEntArray(var19.target, "targetname")) {
          var24 linkTo(level.c130);
        }
      }
    }
  }

  var27 = getEntArray("rear_door_down_geo", "targetname");

  if(isDefined(var27[0])) {
    level.c130.lower_door_geo = var27[0];

    if(isDefined(var27[1])) {
      var27[1] delete();
    }

    level.c130.lower_door_geo linkTo(level.c130, "hatch_jnt");
    level.c130.lower_door_geo solid();
    level.c130.lower_door_geo delete();
  }

  var28 = getEntArray("rear_door_collision", "targetname");

  if(isDefined(var28) && isarray(var28) && var28.size > 0) {
    level.c130.ref_12a4e = var28;

    foreach(var30 in level.c130.ref_12a4e) {
      var30 delete();
    }
  }

  var32 = getEntArray("plane_door_vehicle_collision", "targetname");

  if(isDefined(var32) && isarray(var32) && var32.size > 0) {
    level.c130.ref_14107 = var32;

    foreach(var30 in level.c130.ref_14107) {
      var30 linkTo(level.c130, "hatch_jnt");
      var30 solid();
    }
  }

  var35 = getEnt("plane_collmap", "targetname");

  if(isDefined(var35)) {
    level.c130.ref_123a2 = var35;
    level.c130.ref_123a2 linkTo(level.c130);
    level.c130 notsolid();
  }

  var36 = getEnt("plane_collision_brush", "targetname");

  if(isDefined(var36)) {
    level.c130.ref_12a4f = var36;
    level.c130.ref_12a4f linkTo(level.c130, "hatch_jnt");
    level.c130.ref_12a4f solid();
  }

  var37 = getEntArray("breach_door_escape", "targetname");

  foreach(var39 in var37) {
    var39 linkTo(level.c130);
  }

  level.c130.air_reference = getEnt("c130_teleport_air", "targetname");
  level.c130.air_reference linkTo(level.c130);
  thread winindex();
  level.playerpostsetplunder = getEnt("freefall_anim_start", "script_noteworthy");

  if(isDefined(level.playerpostsetplunder)) {
    level.playerpostsetplunder linkTo(level.c130);
  }

  var41 = getEntArray("lower_door_collision", "targetname");

  if(isDefined(var41)) {
    foreach(var43 in var41) {
      if(!isDefined(level.c130.ref_11a57)) {
        level.c130.ref_11a57 = [];
      }

      var43 linkTo(level.c130, "hatch_jnt");
      var43 notsolid();
      level.c130.ref_11a57 = scripts\engine\utility::array_add(level.c130.ref_11a57, var43);
    }
  }

  var45 = getEnt("plane_shell", "targetname");

  if(isDefined(var45)) {
    level.c130.shell = var45;
    level.c130.shell linkTo(level.c130);

    foreach(var5 in level.c130.body) {
      if(var5.classname == "script_brushmodel") {
        var5 delete();
      }
    }
  }

  var47 = getEnt("upper_door_collision", "targetname");

  if(isDefined(var47)) {
    level.c130.ref_14038 = var47;
    level.c130.ref_14038 linkTo(level.c130, "hatch_upper_jnt");
    level.c130.ref_14038 notsolid();
  }

  var48 = randomint(360);
  var49 = 80000;

  if(level.script == "cp_static_747") {
    var49 /= 5;
  }

  var50 = cos(var48) * var49;
  var51 = sin(var48) * var49;
  var52 = 20000;

  if(level.script == "cp_static_747") {
    var52 /= 4;
  }

  var53 = vectorNormalize((var50, var51, var52));
  var53 = var53 * var49 + (0, 0, var52);
  var54 = level.mapcenter * (1, 1, 0) + (0, 0, var52);
  thread handlemovingplatforms(level.c130);
  var55 = getEntArray("ground_plane_seats", "targetname");
  level.ground_plane_seats = [];

  foreach(var57 in var55) {
    if(!scripts\engine\utility::array_contains(level.ground_plane_seats, var57)) {
      level.ground_plane_seats = scripts\engine\utility::array_add(level.ground_plane_seats, var57);
    }
  }
}

function handlemovingplatforms(var0) {
  scripts\cp\cp_movers::stop_handling_moving_platforms();
  var1 = spawnStruct();

  if(isDefined(var0)) {
    if(isarray(var0)) {
      var1.linkparents = var0;

      foreach(var3 in var1.linkparents) {
        if(self != var1.linkparent) {
          scripts\cp\cp_movers::handle_moving_platforms(var1);
        }
      }

      return;
    }

    var1.linkparent = var0;

    if(self != var1.linkparent) {
      scripts\cp\cp_movers::handle_moving_platforms(var1);
      return;
    }

    return;
  }
}

function debugmovingplatformview(var0) {
  self endon("death");

  for(;;) {
    waitframe();
  }
}

function use_seat(var0) {
  self endon("death");
  self notify("use_seat");
  self endon("use_seat");

  for(;;) {
    var0 waittill("trigger", var1);

    if(!isPlayer(var1)) {
      continue;
    }

    if(isDefined(var0.current_player)) {
      continue;
    }

    if(!isDefined(level.players_inside_plane)) {
      level.players_inside_plane = [];
    }

    seat_player(var0, var1);
  }
}

function seat_player(var0, var1) {
  var0 makeunusable();
  thread play_seating_anim(var0, var1);
  level.players_inside_plane = scripts\engine\utility::array_add(level.players_inside_plane, var1);
  level.c130.seated_players++;
  var0.current_player = var1;
  level.players_in_c130++;
  var1.binseat = 1;

  if(isDefined(var0.headiconid)) {
    var0 thread scripts\cp\utility::ent_deleteheadicon(var0, var0.headiconid);
  }

  thread get_up_from_seat_after_teleporting(var1, var1);

  if(level.c130.seated_players == level.players.size) {
    level notify("cleared_for_takeoff");
    return;
  }
}

function play_seating_anim(var0, var1) {
  var2 = 0.2;
  var1 allowfire(0);
  var1 scripts\cp\cp_disguise::enter_demeanor_relaxed();
  var3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var1, "player", 1, 0, 0);
  var0 scripts\cp_mp\anim_scene::anim_scene([var3], "plane_sitting_in", 1, 0, undefined, var2);
  var1.actorplayer = var3;
  var3 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  thread play_sitting_loop(var0, var3);
  wait_for_any_button_press(var1, var0);
  var0 scripts\cp_mp\anim_scene::anim_scene([var3], "plane_sitting_exit", 0, 1, undefined, var2);
  var1 allowfire(1);
  var1 scripts\cp\cp_disguise::enter_demeanor_normal();
}

function play_sitting_loop(var0, var1) {
  var1 endon("exit_seat");

  for(;;) {
    thread scripts\cp_mp\anim_scene::anim_scene_loop([var0], "plane_sitting_loop_01", 0, 0, undefined, 0.2);
    wait getanimlength(level.scr_anim["player"]["plane_sitting_loop_01"][0]);
    scripts\cp_mp\anim_scene::anim_scene_stop();
    thread scripts\cp_mp\anim_scene::anim_scene_loop([var0], "plane_sitting_loop_02", 0, 0, undefined, 0.2);
    wait getanimlength(level.scr_anim["player"]["plane_sitting_loop_02"][0]);
    scripts\cp_mp\anim_scene::anim_scene_stop();
    thread scripts\cp_mp\anim_scene::anim_scene_loop([var0], "plane_sitting_loop_03", 0, 0, undefined, 0.2);
    wait getanimlength(level.scr_anim["player"]["plane_sitting_loop_03"][0]);
    scripts\cp_mp\anim_scene::anim_scene_stop();
  }
}

function wait_for_any_button_press(var0, var1) {
  var0 notify("wait_for_any_button_press");
  var0 endon("wait_for_any_button_press");
  var0 endon("disconnect");
  wait 2;

  for(;;) {
    if(istrue(var0.exit_seat)) {
      var1 scripts\cp_mp\anim_scene::anim_scene_stop(1);
      var0 notify("exit_seat");
      return 1;
    }

    waitframe();
  }
}

function do_seated_anim(var0, var1) {
  if(!isDefined(var0.c130_idle)) {
    var2 = "seat2";
    level.c130_seat_idles = scripts\engine\utility::array_remove(level.c130_seat_idles, var2);
    var0.c130_idle = var2;
  }

  var0 thread scripts\cp\cp_destruction::create_player_rig(var0, "player_seated_c130");
  var3 = spawn("script_model", var1.origin + (0, 0, -8));
  var3.angles = anglestoleft(var1.angles);

  if(var1.struct.name == "seat_1" || var1.struct.name == "seat_2") {
    var3.angles += (0, 180, 0);
  }

  var3 linkTo(level.c130);
  var0.player_rig linkTo(var3);
  var0 lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 10, 60);
  var0 waittill("exit_seat");
  var0 notify("remove_rig");
  var0 setstance("stand");

  if(level.c130.seated_players == level.players.size) {
    close_plane_doors();
    return;
  }
}

function cornerline_height(var0) {
  return var0.intro_offset * 20 - 122;
}

function introscreen_corner_line(var0, var1) {
  if(!isDefined(self.intro_offset)) {
    self.intro_offset = 0;
  } else {
    self.intro_offset++;
  }

  var2 = cornerline_height(self);
  var3 = 1.6;

  if(level.splitscreen) {
    var3 = 2;
  }

  var4 = newclienthudelem(self);
  var4.x = 20;
  var4.y = var2;
  var4.alignx = "left";
  var4.aligny = "bottom";
  var4.horzalign = "left";
  var4.vertalign = "bottom";
  var4.sort = 3;
  var4.foreground = 1;
  var4 settext(var0);
  var4.alpha = 1;
  var4.hidewheninmenu = 1;
  var4.fontscale = var3;
  var4.color = (0.8, 1, 0.8);
  var4.font = "default";
  var4.glowcolor = (0.3, 0.6, 0.3);
  var4.glowalpha = 1;
  return var4;
}

function teleport_text(var0) {
  wait 2;
  var1 = introscreen_corner_line(var0, &"CP_FUBAR/TELEPORT_LINE_1", 1);
  wait 1;
  var2 = introscreen_corner_line(var0, &"CP_FUBAR/TELEPORT_LINE_2", 2);
  wait 1;
  var3 = introscreen_corner_line(var0, &"CP_FUBAR/TELEPORT_LINE_3", 3);
  wait 1;
  var4 = introscreen_corner_line(var0, &"CP_FUBAR/TELEPORT_LINE_4", 4);
  wait 3;
  var1 fadeovertime(3);
  var2 fadeovertime(3);
  var3 fadeovertime(3);
  var4 fadeovertime(3);
  var1.alpha = 0;
  var2.alpha = 0;
  var3.alpha = 0;
  var4.alpha = 0;
  var1 destroy();
  var2 destroy();
  var3 destroy();
  var4 destroy();
}

function get_up_from_seat_after_teleporting(var0, var1) {
  var0 notify("get_up_from_seat");
  var0 endon("get_up_from_seat");
  var0 endon("disconnect");
  var0 endon("remove_get_up_thread");
  level waittill("take_off_done");
  exit_seat(var0, 0, var1, 1);

  foreach(var3 in level.ground_plane_seats) {
    if(var3.struct.name == var1.struct.name) {
      var0 notify("kill_thread");
      thread teleport_black_overlay(var0);
      thread teleport_text(var0);
      var0 unlink();
      var0.exit_seat = 1;
      set_player_angles_inside_plane(var0, var3, var1);
      thread play_seating_anim_and_exit(var3, var0);
    }
  }

  var0 notify("delete_disguise_threads_on_player");
  var1 makeusable();
  level.c130.seated_players--;
  var0.binc130 = 1;
  var1.current_player = undefined;
  var0.binseat = undefined;
}

function take_off_loop(var0) {
  var1 = level scripts\engine\utility::ref_143ad(var0.ref + "_timer_complete", "cleared_for_takeoff");
  level notify("end_current_nags");

  foreach(var3 in level.c130.plane_seats) {
    if(isDefined(var3.headiconid)) {
      var3 thread scripts\cp\utility::ent_deleteheadicon(var3, var3.headiconid);
    }
  }

  level thread scripts\cp\utility::ref_123fe("");
  level notify("all_enemy_vehicles_leave");
  level.ref_12213 = 1;
  level.ref_12b46 = 1;

  if(var1 == "cleared_for_takeoff") {
    thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_FUBAR/REGROUP_PLANE", "allies", 3.75);
    ref_14472();
    close_plane_doors();
    scripts\cp\cp_modular_spawning::stop_all_groups();

    foreach(var6 in getaiarray("axis")) {
      var6 scripts\cp\cp_modular_spawning::script_kill_ai();
    }

    c130_take_off_sequence(1);
  } else if(callback_frontendplayeractive()) {
    thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_FUBAR/REGROUP_PLANE", "allies", 3.75);
    ref_14472();
    close_plane_doors();
    scripts\cp\cp_modular_spawning::stop_all_groups();

    foreach(var6 in getaiarray("axis")) {
      var6 scripts\cp\cp_modular_spawning::script_kill_ai();
    }

    c130_take_off_sequence(1);
  } else {
    thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_FUBAR/REGROUP_PLANE", "allies", 3.75);
    ref_14472();
    close_plane_doors();
  }

  thread ref_12407();
  level notify("infil_plane_completed");
  scripts\cp\cp_objectives::reset_objective_timers();
  level.c130 unlink();
  level.c130.bpaused = 1;
  scripts\cp\cp_modular_spawning::stop_all_groups();

  if(isDefined(level.enemy_tanks) && isarray(level.enemy_tanks)) {
    scripts\cp\utility::array_notify(level.enemy_tanks, "death");
  }

  level notify("all_enemy_vehicles_leave");

  foreach(var6 in getaiarray("axis")) {
    var6 scripts\cp\cp_modular_spawning::script_kill_ai();
  }

  var12 = scripts\engine\utility::getStructArray("teleport_start_points", "targetname");
  level notify("cp_force_killstreak_exit");

  foreach(var14 in level.players) {
    if(istrue(var14.binseat)) {
      continue;
    }

    var14 notify("killstreakExit");

    if(isDefined(level.players_inside_plane)) {
      if(scripts\engine\utility::array_contains(level.players_inside_plane, var14)) {
        continue;
      }
    }

    var14 notify("kill_thread");
    var15 = scripts\engine\utility::random(var12);
    var12 = scripts\engine\utility::array_remove(var12, var15);
    var16 = var14 scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(var16)) {
      var17 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var16, var14);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var16, var17, var14, undefined, 1);
    }

    thread start_nonstealth_teleport_sequence(var14);
  }

  thread upper_level_plane_combat_start();
  level notify("end_current_nags");
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_plane_attack");
}

function ref_14472() {
  var0 = 0;
  var1 = 0;

  for(;;) {
    var2 = scripts\mp\vehicles\vehicle_damage_mp::raid_seq3_objectives_func();

    if(var2.size == 0) {
      scripts\cp\utility::objective_update("infil_plane", 6, 3, 1, 1, undefined, 1);
      var2 = scripts\mp\vehicles\vehicle_damage_mp::raid_seq3_objectives_func();

      if(var2.size == 0) {
        break;
      }
    }

    waitframe();
  }
}

function ref_13bbb(var0) {
  level.disable_hotjoin_via_ac130 = var0;
}

function ref_12407() {
  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_boarded_10", 2);

  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_boarded_20", 2);

  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_boarded_30", 2);
}

function ref_12b43(var0) {
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_FUBAR/REGROUP_PLANE", "allies", 3.75);
  scripts\cp\utility::objective_update("infil_plane", 6, 3, 1, 1, undefined, 1);

  foreach(var2 in scripts\cp\utility::getplayersinteam("allies")) {
    var2 notify("killstreakExit");
    var3 = 0;

    if(scripts\cp\cp_laststand::player_in_laststand(var2) || var2 isspectatingplayer()) {
      var3 = 1;
    }

    var2 thread scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_armsdealer::player_regroup(level.ref_12b45, var4, var3, "all_players_teleported_to_plane", "collect_nuclear_core");
  }

  wait 3;
  level notify("all_players_teleported_to_plane");
}

function start_nonstealth_teleport_sequence(var0) {
  self endon("disconnect");
  self.respawn_forcespawnorigin = var0.origin;
  self.respawn_forcespawnangles = var0.angles;
  self.forcespawnorigin = self.respawn_forcespawnorigin;
  self.forcespawnangles = self.respawn_forcespawnangles;

  if(istrue(self.isreviving)) {
    self.can_revive = 0;
    self.ref_12d13 = self.forcespawnorigin;
    self notify("revive_done");
  }

  if(istrue(self.inlaststand)) {
    if(istrue(self.run_kill_watcher)) {
      self.ref_11b09 = 1;
    }

    if(istrue(self.being_revived)) {
      self notify("revive_done");
      self.being_revived = 0;
      self.ref_11b09 = 1;
    } else {
      self notify("force_bleed_out");
      self.binc130 = 1;

      if(isDefined(level.disguised_players)) {
        if(scripts\engine\utility::array_contains(level.disguised_players, self)) {
          remove_disguise(self);
        }
      }

      return;
    }
  }

  level notify("cp_force_killstreak_exit");

  if(isDefined(level.choppergunners)) {
    foreach(var2 in level.choppergunners) {
      var2 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
    }
  }

  if(isDefined(self.helperdrone)) {
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);
  }

  if(isDefined(self.currentturret)) {
    self.currentturret notify("kill_turret", 0, 0);
    waitframe();
  }

  self.ref_132ea = 1;

  if(self istouching(level.ref_12b48) || self istouching(level.c130.ref_12a4f)) {
    self.ref_132ea = undefined;
  }

  if(istrue(self.ref_132ea)) {
    foreach(var5 in level.c130.body) {
      if(isDefined(var5)) {
        if(self istouching(var5)) {
          self.ref_132ea = undefined;
          break;
        }

        self.ref_132ea = 1;
      }
    }
  }

  if(istrue(self.ref_132ea)) {
    foreach(var8 in level.c130.plane_seats) {
      if(self istouching(var8)) {
        self.ref_132ea = undefined;
        break;
      }

      self.ref_132ea = 1;
    }
  }

  if(istrue(self.ref_132ea)) {
    if(isDefined(level.c130.shell)) {
      if(self istouching(level.c130.shell)) {
        self.ref_132ea = undefined;
      }
    }
  }

  if(istrue(self.ref_132ea)) {
    if(self istouching(level.c130)) {
      self.ref_132ea = undefined;
    }
  }

  if(istrue(self.ref_132ea) && !istrue(self.ref_11b09)) {
    if(istrue(self.isjuggernaut)) {
      self notify("juggernaut_end_damage");
      waitframe();
    }

    self notify("ended_blackout");
    self.shouldskiplaststand = 1;
    self.shouldskipdeathsshield = 1;
    scripts\cp\cp_objectives::ref_12868("infil_plane");
    self dodamage(self.maxhealth + 100000, self.origin);
    wait 1;
    self notify("force_bleed_out");
    self.binc130 = 1;

    if(isDefined(level.disguised_players)) {
      if(scripts\engine\utility::array_contains(level.disguised_players, self)) {
        remove_disguise(self);
      }
    }

    return;
  }

  if(istrue(self isparachuting()) || istrue(self isskydiving())) {
    self skydive_interrupt();
  }

  var10 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var10)) {
    var11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var10, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var10, var11, self, undefined, 1);
  }

  if(istrue(self.ref_11b09)) {
    self.ref_11b09 = undefined;

    if(istrue(self.run_kill_watcher)) {
      thread ref_14338(var0);
    } else {
      thread scripts\cp\cp_laststand::instant_revive(self);
      self waittill("revive");
      self setclientomnvar("ui_hide_bigmap", 1);
      self skydive_setbasejumpingstatus(0);
      self skydive_setdeploymentstatus(0);
      thread teleport_black_overlay(self);
      thread ref_13ae2();

      if(self.class == "engineer" || self.class == "hunter") {
        self.disable_super = 1;
      }

      self setmlgdamagedone();
      self setOrigin(var0.origin, 1);
      thread start_turbulence_sequence();
      thread delay_set_plane_specific_vars(self, 3);

      if(!isDefined(var0.angles)) {
        var0.angles = (0, 0, 0);
      }

      self setplayerangles(var0.angles);
      self.binc130 = 1;
    }
  } else {
    self setclientomnvar("ui_hide_bigmap", 1);
    self skydive_setbasejumpingstatus(0);
    self skydive_setdeploymentstatus(0);
    thread teleport_black_overlay(self);
    thread ref_13ae2();

    if(self.class == "engineer" || self.class == "hunter") {
      self.disable_super = 1;
    }

    self setmlgdamagedone();
    self setOrigin(var0.origin, 1);
    thread start_turbulence_sequence();
    thread delay_set_plane_specific_vars(self, 3);

    if(!isDefined(var0.angles)) {
      var0.angles = (0, 0, 0);
    }

    self setplayerangles(var0.angles);
    self.binc130 = 1;
  }

  wait 3;
  level notify("spawn_enemies_in_plane");
  scripts\cp\utility::brjugg_setconfig(1);
  wait 2;
  self.can_revive = 1;

  if(isDefined(level.disguised_players)) {
    if(scripts\engine\utility::array_contains(level.disguised_players, self)) {
      remove_disguise(self);
      return;
    }

    return;
  }
}

function ref_14338(var0) {
  self endon("disconnect");

  while(istrue(self.run_kill_watcher)) {
    waitframe();
  }

  if(istrue(self.binc130)) {
    return;
  }

  self setclientomnvar("ui_hide_bigmap", 1);
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  thread teleport_black_overlay(self);
  thread ref_13ae2();

  if(self.class == "engineer" || self.class == "hunter") {
    self.disable_super = 1;
  }

  self setmlgdamagedone();
  self setOrigin(var0.origin, 1);
  thread start_turbulence_sequence();
  thread delay_set_plane_specific_vars(self, 3);

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  self setplayerangles(var0.angles);
  self.binc130 = 1;
}

function ref_13ae2() {
  scripts\mp\vehicles\vehicle_damage_mp::ref_1333e("collect_nuclear_core");
  wait 5;
  self setclientomnvar("ui_chyron_on", 0);
  self setclientomnvar("ui_chyron_mission_index", 0);
}

function play_seating_anim_and_exit(var0, var1) {
  var1 waittill("ended_blackout");
  var2 = 0.2;
  var1 allowfire(0);
  var1 scripts\cp\cp_disguise::enter_demeanor_relaxed();
  var3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var1, "player", 1, 0, 0);
  var1.actorplayer = var3;
  var3 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var0 thread scripts\cp_mp\anim_scene::anim_scene_loop([var3], "plane_sitting_loop_01", 1, 0, undefined, 0.2);
  wait getanimlength(level.scr_anim["player"]["plane_sitting_loop_01"][0]);
  var0 scripts\cp_mp\anim_scene::anim_scene_stop(1);
  var0 scripts\cp_mp\anim_scene::anim_scene([var3], "plane_sitting_exit", 0, 1, undefined, var2);
  level notify("spawn_enemies_in_plane");
  var1 unlink();
  var1 allowfire(1);
  var1 scripts\cp\cp_disguise::enter_demeanor_normal();
  thread start_turbulence_sequence();
  thread delay_set_plane_specific_vars(var1, var1);
}

function delay_set_plane_specific_vars(var0, var1) {
  wait var1;
  var0.no_outline = 1;
  var0.no_team_outlines = 1;
  var0 scripts\cp\utility::giveperk("specialty_spygame");
  var0 scripts\cp\utility::giveperk("specialty_coldblooded");
  var0 scripts\cp\utility::giveperk("specialty_noscopeoutline");
  var0 scripts\cp\utility::giveperk("specialty_heartbreaker");
  var0.attackeraccuracy = 6;
}

function register_interactions() {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("cp_plane_hijack_cs_completed")) {
    scripts\engine\utility::flag_init("cp_plane_hijack_cs_completed");
  }

  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\cp\cp_interaction::registerinteraction("radar_struct", &hack_radar_hint, &hack_radar_activate, &init_radar_activate, 0, "duration_long");
  scripts\engine\utility::flag_set("cp_plane_hijack_interactions_registered");
}

function hack_radar_hint(var0, var1) {
  if(level.hack_region != var0.name) {
    return "";
  }

  if(istrue(var0.binprogress)) {
    return "";
  }

  return &"CP_FUBAR/PLANT_JAMMERS";
}

function hack_radar_activate(var0, var1) {
  if(level.hack_region != var0.name) {
    return;
  }

  if(istrue(var0.binprogress)) {
    return;
  }

  if(level.hacks_done == scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers").radar_structs.size) {}

  level notify("end_current_nags");
  var2 = getdvarint("scr_hack_time_override", 0);

  if(var2 != 0) {
    level.hack_duration = var2;
  }

  if(level.hack_region == "parking_lot") {
    if(istrue(level.global_stealth_broken)) {
      scripts\cp\crate_drops\cp_crate_drops::ref_12c40("hijack_1");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_airport");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop_guards");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop_skit");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_rooftop_sniper");
      level.global_stealth_tracker["hack_rooftop"] = 1;
      var3 = 2;
      thread spawn_waves_after_a_delay(level, var3, undefined);
    }

    level.hack_duration = 240;
  } else {
    level.hack_duration = 300;
  }

  if(!istrue(level.global_stealth_broken)) {
    level.hack_duration /= 4;
  }

  level thread scripts\cp\cp_objective_mechanics::starthackingdefense(scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers"), var0.origin + (-25, -15, 45), level.hack_duration, "cpu_hacking_done", 1024);
  var1 playlocalsound("cp_generic_placement");
  var0.router setModel("equipment_router_flat_invisi");
  var0.router setscriptablepartstate("transfer", "start");
  var0.binprogress = 1;
  var0.model setscriptablepartstate("main", "on");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
  level waittill("cpu_hacking_done");
  scripts\cp\cp_objectives::screenent_c("minor_objective");

  if(level.hack_region != "parking_lot") {
    objective_unsetlocation(scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers").objectiveindex, var0.model.index);
  } else {
    objective_setlocation(scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers").objectiveindex, var0.model.index, (-22823.7, 18783.8, -148.12));
    objective_state(scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers").objectiveindex, "current");
    objective_setlabel(scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers").objectiveindex, &"CP_FUBAR/DISRUPT_COMMS");
  }

  if(level.hacks_done == 1) {
    level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_files_copied_2");
  } else if(level.hacks_done == 2) {
    level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_files_copied_3");
  }

  var0.router setscriptablepartstate("transfer", "finish");

  if(level.hack_region == "parking_lot") {
    level.hack_region = "airport";
    scripts\cp\utility::objective_update("plant_jammers_2", undefined, undefined, undefined, 1, undefined, 1);
    thread ref_12418();
    thread ref_12403(level, ["dx_cps_lass_plane_airport_nag_10", "dx_cps_kama_plane_airport_nag_20"]);
  } else {
    thread ref_123c1();
  }

  foreach(var5 in level.radar_models) {
    var5.index = var6;

    if(var5.region == "airport") {
      objective_setlocation(scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers").objectiveindex, var5.index, (-22823.7, 18783.8, -148.12));
      objective_state(scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers").objectiveindex, "current");
      objective_setlabel(scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers").objectiveindex, &"CP_FUBAR/DISRUPT_COMMS");

      if(istrue(level.global_stealth_broken)) {
        scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_airport");

        if(istrue(level.wave_cooldown_active)) {}

        thread vehicle_occupancy_clearforceweaponswitchallowed();
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_spawning", [ &scripts\cp\cp_modular_spawning::ref_11cac, 750]);
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("wave_spawning", [ &scripts\cp\cp_modular_spawning::ref_11cab, 64]);
        scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
        scripts\cp\cp_modular_spawning::run_spawn_module("tarmac_patrol");
        scripts\cp\cp_modular_spawning::run_spawn_module("tarmac_patrol_plane");
        scripts\cp\cp_modular_spawning::run_spawn_module("hack_airport_combat");
        continue;
      }

      thread vehicle_occupancy_clearforceweaponswitchallowed();
    }
  }

  var0.model setscriptablepartstate("main", "on");
  var0.binprogress = undefined;
  level.hacks_done++;
  level thread scripts\cp\utility::ref_123fe("");

  if(level.hacks_done == scripts\cp\cp_objectives::getobjectivestructfromref("plant_jammers").radar_structs.size) {
    level notify("destroyed_all_jammers");
    return;
  }
}

function vehicle_occupancy_clearforceweaponswitchallowed() {
  wait 45;
  scripts\cp\cp_modular_spawning::run_spawn_module("hack_airport_jugg_disguise");
}

function ref_12418() {
  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_rooftop_hack_success_10");

  if(!istrue(level.global_stealth_broken)) {
    while(istrue(level.dialogue_playing)) {
      wait 1;
    }

    scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_rooftop_hack_success_20", 1);
  }

  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_airport_intro_10", 1);
}

function ref_123c1() {
  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_airport_hack_success_10");

  if(!istrue(level.global_stealth_broken)) {
    return;
  }
}

function init_radar_activate(var0) {
  level.hacks_done = 0;
  level thread scripts\cp\cp_hacking::hacking_init();
  level.radar_models = [];

  if(var0.size > 0) {
    foreach(var2 in var0) {
      var2.model = spawn("script_model", var2.origin);
      var2.model setModel("military_hq_crate_01_proxy_cp_spawnable");

      if(!isDefined(var2.angles)) {
        var2.angles = (0, 0, 0);
      }

      var2.model.angles = var2.angles;
      var2.model.region = var2.name;
      var2.router = spawn("script_model", scripts\engine\utility::getStruct(var2.target, "targetname").origin);
      var2.router setModel("tag_origin");

      if(!isDefined(scripts\engine\utility::getStruct(var2.target, "targetname").angles)) {
        var2.angles = (0, 0, 0);
      }

      var2.router.angles = scripts\engine\utility::getStruct(var2.target, "targetname").angles;
      var2.router.region = var2.name;
      var2.model.router = var2.router;
      level.radar_models = scripts\engine\utility::array_add(level.radar_models, var2.model);
      var2.origin = var2.router.origin;
      var2.angles = var2.router.angles;
      scripts\cp\cp_interaction::add_to_current_interaction_list(var2);
    }

    return;
  }
}

function register_plane_hijack_objectives() {
  scripts\cp\cp_objectives::registerobjective("plant_jammers", &init_plant_jammers, &start_plant_jammers, &end_plant_jammers, &scripts\cp\cp_objectives::debugbeatobjective, &debugplantjammers);
  scripts\cp\cp_objectives::registerobjective("kill_tunnel_spawns", &init_kill_tunnel_spawns, &start_kill_tunnel_spawns, &end_kill_tunnel_spawns, &scripts\cp\cp_objectives::debugbeatobjective, &debugkill_tunnel_spawns);
  scripts\cp\cp_objectives::registerobjective("equip_disguise", &init_equip_disguise, &start_equip_disguise, &end_equip_disguise, &scripts\cp\cp_objectives::debugbeatobjective, &debugequip_disguise);
  scripts\cp\cp_objectives::registerobjective("infil_plane", &init_infil_plane, &start_infil_plane, &end_infil_plane, &scripts\cp\cp_objectives::debugbeatobjective, &debuginfil_plane);
  scripts\cp\cp_objectives::registerobjective("destroy_c130", &init_destroy_c130, &start_destroy_c130, &end_destroy_c130, &scripts\cp\cp_objectives::debugbeatobjective, &debugstartdestroyc130);
  scripts\cp\cp_objectives::registerobjective("collect_nuclear_core", &init_collect_nuclear_core, &start_collect_nuclear_core, &end_collect_nuclear_core, &scripts\cp\cp_objectives::debugbeatobjective, &debugstartc130objective);
  scripts\cp\cp_objectives::registerobjective("exfil_plane", &init_exfil_plane, &start_exfil_plane, &end_exfil_plane, &scripts\cp\cp_objectives::debugbeatobjective, &debugexfilc130objective);
  scripts\cp\cp_objectives::registerobjective("land_at_lz", &init_land_at_lz, &start_land_at_lz, &end_land_at_lz, &scripts\cp\cp_objectives::debugbeatobjective, &debuglandatlz);
  scripts\cp\cp_objectives::registerobjective("holdout", &init_holdout, &start_holdout, &end_holdout, &scripts\cp\cp_objectives::debugbeatobjective, &debugholdout);
  scripts\cp\cp_objectives::registerobjective("extract_lz", &init_extract_lz, &start_extract_lz, &end_extract_lz, &scripts\cp\cp_objectives::debugbeatobjective, &debugextractlz);
  scripts\cp\cp_objectives::registerobjective("recover_nuclear_core", &init_recover_nuclear_core, &start_recover_nuclear_core, &end_recover_nuclear_core, &scripts\cp\cp_objectives::debugbeatobjective, &debugrecover_nuclear_core);
}

function init_plant_jammers(var0, var1) {
  scripts\engine\utility::flag_wait("cp_plane_hijack_interactions_registered");
  scripts\cp\utility::skydivestreamhintdvars("plane_hijack_airport");
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  scripts\cp\cp_modular_spawning::stop_all_groups();
  level.phj_spawners_trigger = getEnt("phj_spawners", "targetname");
  objective_setlocation(var0.objectiveindex, 0, level.phj_spawners_trigger.origin);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_rooftop_intro_10");
  level notify("safehouse_demeanor_off");
  level.battlechatterenabled = 0;
  level.ref_139b5 = 1;
  thread watch_for_phj_spawners_triggered();
  thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_rooftop_hack_10", 1);
  thread ref_12403(level, ["dx_cps_kama_plane_rooftop_nag_10", "dx_cps_kama_plane_rooftop_nag_20", "dx_cps_lass_plane_rooftop_nag_30"]);
  level.hack_region = "parking_lot";
  var0.radar_structs = scripts\engine\utility::getStructArray("radar_struct", "script_noteworthy");
  scripts\cp\cp_objectives::ref_1317e(var0, [var0.radar_structs[0].origin, (-22823.7, 18783.8, -148.12)]);
  objective_state(var0.objectiveindex, "current");

  foreach(var3 in level.radar_models) {
    var3.index = var4;

    if(var3.region == "parking_lot") {
      objective_setlocation(var0.objectiveindex, var3.index, var3.router.origin);
      objective_state(var0.objectiveindex, "current");
    }
  }

  foreach(var6 in scripts\engine\utility::getStructArray("airport_veh_spawners", "targetname")) {
    switch (var6.script_noteworthy) {
      case "technical":
        scripts\cp\vehicles\technical_cp::spawn_technical_at_location(var6.origin, var6.angles, "allies", 1);
        break;
      case "atv":
        var7 = spawnStruct();
        var7.origin = var6.origin;
        var7.angles = var6.angles;
        var7.team = "allies";
        var8 = scripts\cp_mp\vehicles\atv::atv_create(var7);

        if(!isDefined(level.atvs)) {
          level.atvs = [];
        }

        level.atvs = scripts\engine\utility::array_add(level.atvs, var8);
        break;
    }
  }
}

function ref_12403(var0, var1) {
  level notify("play_nags_from_array");
  level endon("play_nags_from_array");
  level endon("end_rooftop_nags");
  level endon("end_airport_nags");
  level endon("end_runway_nags");
  level endon("end_heli_nags");
  level endon("end_exit_nags");
  level endon("end_current_nags");

  for(var2 = 0;; var2 = 0) {
    if(istrue(level.dialogue_playing)) {
      wait 3;
      continue;
    }

    scripts\cp\cp_dialogue::play_vo_to_all(var0[var2], var1);
    var2++;

    if(var2 >= var0.size) {}
  }
}

function watch_for_phj_spawners_triggered() {
  level endon("weapons_free");
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      waitframe();
      continue;
    }

    break;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("jugg_patrol");
  scripts\cp\cp_modular_spawning::run_spawn_module("jugg_guard");
  scripts\cp\cp_modular_spawning::run_spawn_module("hack_rooftop");
  scripts\cp\cp_modular_spawning::run_spawn_module("hack_rooftop_guards");
  scripts\cp\cp_modular_spawning::run_spawn_module("hack_rooftop_skit");
  scripts\cp\cp_modular_spawning::run_spawn_module("hack_rooftop_sniper");
  level.phj_spawners_trigger delete();
}

function watch_for_spawner_triggered() {
  level endon("weapons_free");
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      waitframe();
      continue;
    }

    players_reached_airport();
    self delete();
  }
}

function start_plant_jammers(var0, var1) {
  level endon("game_ended");
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_enemy_comms");
  level notify("objective_initialized");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/HACK_LAPTOP");
  level.airport_spawners_trigger = getEnt("airport_spawn_trigger", "targetname");
  thread watch_for_spawner_triggered();
  level waittill("destroyed_all_jammers");
  level.hack_region = undefined;

  if(istrue(level.global_stealth_broken)) {
    thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_stealth_broken_early_10");
    scripts\cp\cp_objectives::overridenextstep(var0, "infil_plane");
    return;
  }
}

function end_plant_jammers(var0, var1) {}

function debugplantjammers(var0, var1) {
  scripts\engine\utility::flag_set("cp_plane_hijack_cs");
  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "hack_start_points", 1);
}

function player_give_gg_loadout() {
  thread give_stealth_loadout();
}

function give_stealth_loadout() {
  wait 3;
  var0 = self getcurrentweapon();
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    switch (weaponclass(var3)) {
      case "smg":
        var4 = scripts\cp\cp_weapon::addattachmenttoweapon(var3, "silencer", "xmags", "gripvert", "acog");
        self takeweapon(var3);
        break;
      case "rifle":
        var4 = scripts\cp\cp_weapon::addattachmenttoweapon(var3, "silencer", "xmags", "gripvert", "hybrid");
        self takeweapon(var3);
        break;
      case "sniper":
        var4 = scripts\cp\cp_weapon::addattachmenttoweapon(var3, "silencer", "xmags", "thermal");
        self takeweapon(var3);
        break;
      case "mg":
        var4 = scripts\cp\cp_weapon::addattachmenttoweapon(var3, "silencer", "xmags", "gripvert", "hybrid");
        self takeweapon(var3);
        break;
      case "spread":
        var4 = scripts\cp\cp_weapon::addattachmenttoweapon(var3, "silencer2", "laserir", "pistolgrip03");
        self takeweapon(var3);
        break;
      case "rocketlauncher":
        break;
      case "pistol":
        var4 = scripts\cp\cp_weapon::addattachmenttoweapon(var3, "silencer", "xmags", "laser", "acog");
        break;
      default:
        break;
    }
  }

  thread scripts\cp\cp_powers::givepower("power_snapshotGrenade", "secondary", undefined, undefined, undefined, undefined, 1, 10);
}

function init_kill_tunnel_spawns(var0, var1) {}

function start_kill_tunnel_spawns(var0, var1) {
  level endon("game_ended");
  scripts\cp\cp_modular_spawning::run_spawn_module("tunnel_spawners");
  scripts\cp\cp_modular_spawning::run_spawn_module("tunnel_veh_spawners");

  while(!istrue(level.clear_to_pick_disguise_up) || !istrue(level.clear_to_pick_disguise_up_veh)) {
    waitframe();
  }
}

function end_kill_tunnel_spawns(var0, var1) {
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function debugkill_tunnel_spawns(var0) {
  scripts\engine\utility::flag_set("cp_plane_hijack_cs");
  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
}

function spawn_ai_giving_disguise() {
  scripts\cp\cp_modular_spawning::run_spawn_module("garage_ai");
}

function play_ai_skit(var0, var1) {
  thread skit_logic();
}

function ally_death() {
  self dodamage(self.health + 100, self.origin);
  scripts\cp\cp_skits::reset_guy(self);
}

function skit_logic() {
  self.maxhealth = 69;
  self.health = 69;
  self.goal_ent = spawn("script_model", self.origin);

  while(!istrue(level.show_garage_waypoint) && !istrue(level.global_stealth_broken)) {
    wait 0.1;
  }

  if(istrue(level.global_stealth_broken) && !istrue(level.show_garage_waypoint)) {
    ally_death();
    return;
  }

  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_FUBAR/DISGUISE_CIV");

  while(level.disguised_players.size < level.players.size && !istrue(level.global_stealth_broken)) {
    wait 0.1;
  }

  run_and_die();
}

function run_and_die() {
  self notify("stop_going_to_node");
  scripts\cp\cp_modular_spawning::set_goal_radius(256);
  scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("combat");
  thread move_goal_ent(self.goal_ent);
}

function civ_killers_loop(var0, var1, var2, var3) {
  self.scripted_mode = 1;
  level.fight_enemy = self;
}

function move_goal_ent(var0) {
  var0 endon("death");
  self setgoalentity(self.goal_ent, 250);
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_FUBAR/CIV_RUN");

  foreach(var2 in level.players) {
    var2 scripts\cp\utility::allow_player_ignore_me(1);
  }

  var4 = scripts\engine\utility::getStruct("civ_death_spot", "targetname").origin;
  var0 moveTo(var4, 2);
  self setgoalpos(var4);
  scripts\engine\utility::ref_143ba(5, "goal", "goal_reached");
  thread spawnapc();
  scripts\cp\cp_modular_spawning::run_spawn_module("civ_killers");
  self.ignoreme = 0;
  ally_death();

  foreach(var2 in level.players) {
    var2 scripts\cp\utility::allow_player_ignore_me(0);
  }

  level.fight_enemy kill();

  if(soundexists("breach_c4_expl_trans")) {
    playsoundatpos(var4, "breach_c4_expl_trans");
  }

  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_FUBAR/TEMP_DEATH");
  var0 delete();
}

function init_equip_disguise(var0, var1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);

  if(istrue(level.global_stealth_broken)) {
    thread spawn_waves_after_a_delay(level, undefined, undefined);
  } else {
    thread start_tunnel_sequence();
  }

  thread ref_123dc();
  level.disguised_players = [];
  objective_onentity(var0.objectiveindex, level.garage_door.door_interaction);
  objective_state(var0.objectiveindex, "current");
  objective_setlabel(var0.objectiveindex, &"MP/DOOR_USE_OPEN");
  level.can_open_door = 1;
  level.disguise_ent = getEnt("disguise_ent", "targetname");
}

function ref_123dc() {
  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_need_disguise_10", 4);
}

function watch_for_disguise_vehicle_death(var0) {
  self waittill("death");

  if(istrue(level.global_stealth_broken)) {
    scripts\cp\cp_objectives::overridenextstep(var0, "infil_plane");
    return;
  }

  level.disguise_ent = getEnt("disguise_ent", "targetname");
  objective_onentity(var0.objectiveindex, level.disguise_ent);
  level.disguise_ent setHintString(&"CP_FUBAR/EQUIP_DISGUISE_BACKUP");
  level.disguise_ent sethintdisplayrange(200);
  level.disguise_ent sethintdisplayfov(120);
  level.disguise_ent setusefov(120);
  level.disguise_ent setuserange(72);
  level.disguise_ent sethintonobstruction("show");
  level.disguise_ent makeusable();
  thread grab_disguise();
}

function grab_disguise() {
  self notify("grab_disguise");
  self endon("grab_disguise");
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(level.disguised_players, var0)) {
      continue;
    }

    thread give_disguise_via_clothes(var0);
    thread ref_1240c(var0);
  }
}

function ref_1240c(var0) {
  while(istrue(var0.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_player(var0, "dx_cps_kama_plane_disguise_found_10");
  var1 = lookupsoundlength("dx_cps_kama_plane_disguise_found_10") / 1000;
  wait var1 + 1;

  while(istrue(var0.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_player(var0, "dx_cps_lass_plane_disguise_found_20");
}

function give_disguise_via_clothes(var0) {
  disguise_player(var0);
  level notify("disguise_grabbed");
}

function start_equip_disguise(var0, var1) {
  while(!istrue(level.show_garage_waypoint) && !istrue(level.global_stealth_broken)) {
    wait 0.1;
  }

  var2 = scripts\engine\utility::getStruct("technical_spawners", "targetname");
  level.disguise_technical = scripts\cp\vehicles\technical_cp::spawn_technical_at_location(var2.origin, var2.angles, "allies", 1);
  level.disguise_ent setCursorHint("HINT_BUTTON");
  level.disguise_ent setHintString(&"CP_FUBAR/EQUIP_DISGUISE_BACKUP");
  level.disguise_ent sethintdisplayrange(200);
  level.disguise_ent sethintdisplayfov(120);
  level.disguise_ent setusefov(120);
  level.disguise_ent setuserange(72);
  level.disguise_ent sethintonobstruction("show");
  level.disguise_ent makeusable();
  thread grab_disguise();

  if(!istrue(level.global_stealth_broken)) {
    thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_grab_disguise_10");
  } else {
    scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_stealth_broken_late_10");
  }

  objective_onentity(var0.objectiveindex, level.disguise_ent);
  objective_setlabel(var0.objectiveindex, &"CP_FUBAR/DISGUISE_LABEL");
  objective_state(var0.objectiveindex, "current");
  thread ref_12429();

  while(level.disguised_players.size < level.players.size && !istrue(level.global_stealth_broken)) {
    wait 0.1;
  }

  level notify("all_players_have_disguises");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&givedisguiseonspawn);
  objective_unsetlocation(var0.objectiveindex, 0);
}

function ref_12429() {
  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_disguise_room_10");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_disguise_room_20", 1);
}

function givedisguiseonspawn() {
  thread wait_for_spawn_loop_to_finish();
}

function wait_for_spawn_loop_to_finish() {
  self waittill("spawned_player");
  disguise_player(self);
  level notify("disguise_grabbed");
}

function end_equip_disguise(var0, var1) {
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function debugequip_disguise(var0) {
  scripts\engine\utility::flag_set("cp_plane_hijack_cs");
  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 10;
  thread global_weapons_free();
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "disguise_start_points", 1);
}

function disguise_player(var0, var1) {
  var0 endon("disconnect");

  if(isDefined(var1)) {
    if(istrue(var1)) {
      var0 playSound("plr_cloth_switch");
      var0.disguise_overlay = scripts\cp\utility::create_client_overlay("ui_scarf_overlay", 1, var0);
    }
  }

  var0 playSound("plr_cloth_switch");
  var0 scripts\cp_mp\gasmask::createoverlay();
  var0 setcustomization("body_mp_eastern_fireteam_east_ar_3_lod1", "head_mp_eastern_fireteam_east_ar_4");
  var2 = var0 getcustomizationbody();
  var3 = var0 getcustomizationhead();
  var4 = var0 getcustomizationviewmodel();
  var0 scripts\cp\survival\survival_loadout::setcharactermodels("body_mp_eastern_fireteam_east_ar_3_lod1", "head_mp_eastern_fireteam_east_ar_4", "viewhands_mp_base_iw8");
  var5 = "kreuger_eastern";
  var6 = spawnStruct();
  var6.operatorref = var5;
  var6.skinref = 1;
  var6.body = var2;
  var6.head = var3;
  var6.vm = var4;
  var6.gender = scripts\cp\survival\survival_loadout::getoperatorgender(var5);
  var6.voice = scripts\cp\survival\survival_loadout::getoperatorvoice(var5);
  var6.superfaction = scripts\cp\survival\survival_loadout::getoperatorsuperfaction(var5);
  var0.operatorcustomization = var6;
  var0.disguised = 1;

  if(isDefined(var1)) {
    if(istrue(var1)) {}
  }

  if(!isDefined(level.disguised_players)) {
    level.disguised_players = [];
  }

  if(!scripts\engine\utility::array_contains(level.disguised_players, var0)) {
    level.disguised_players = scripts\engine\utility::array_add(level.disguised_players, var0);
  }

  thread watch_for_disguised_player_disconnect();
  thread watch_for_disguised_player_death();
  level notify("disguise_grabbed");
}

function watch_for_disguised_player_death() {
  self notify("watch_for_disguised_player_disconnect");
  self endon("watch_for_disguised_player_disconnect");
  self endon("delete_disguise_threads_on_player");
  self waittill("death");
  scripts\cp_mp\gasmask::destroyoverlay();

  if(istrue(self.disguised)) {
    self.disguised = undefined;
  }

  if(scripts\engine\utility::array_contains(level.disguised_players, self)) {
    level.disguised_players = scripts\engine\utility::array_remove(level.disguised_players, self);
    return;
  }
}

function watch_for_disguised_player_disconnect() {
  self notify("watch_for_disguised_player_disconnect");
  self endon("watch_for_disguised_player_disconnect");
  self endon("delete_disguise_threads_on_player");
  self waittill("disconnect");

  if(istrue(self.disguised)) {
    self.disguised = undefined;
  }

  if(scripts\engine\utility::array_contains(level.disguised_players, self)) {
    level.disguised_players = scripts\engine\utility::array_remove(level.disguised_players, self);
    return;
  }
}

function watch_for_disguised_player_last_stand() {
  self notify("watch_for_disguised_player_last_stand");
  self endon("watch_for_disguised_player_last_stand");
  self endon("delete_disguise_threads_on_player");
  self waittill("last_stand");

  if(istrue(self.disguised)) {
    self.disguised = undefined;
  }

  if(scripts\engine\utility::array_contains(level.disguised_players, self)) {
    level.disguised_players = scripts\engine\utility::array_remove(level.disguised_players, self);
    return;
  }
}

function remove_disguise(var0, var1) {
  if(!nullweapon(var0 getcurrentweapon())) {
    var2 = var0 forceplaygestureviewmodel("ges_visor_up");
    var0 notify("entering_new_demeanor");
    wait 0.5;
  }

  scripts\cp_mp\gasmask::destroyoverlay();
  var3 = var0 scripts\cp\survival\survival_loadout::get_player_character_num();
  var0 thread scripts\cp\survival\survival_loadout::setmodelfromcustomization(var3);
  var4 = scripts\cp\survival\survival_loadout::getplayermodelindex();
  var5 = var0 scripts\cp\survival\survival_loadout::getplayerfoleytype(var4);
  var0.disguised = undefined;

  if(scripts\engine\utility::array_contains(level.disguised_players, var0)) {
    level.disguised_players = scripts\engine\utility::array_remove(level.disguised_players, var0);
  }

  delete_player_overlay(var0);

  if(!istrue(var1)) {
    reenable_ai_for_player(var0);
    return;
  }
}

function reenable_ai_on_player_fire_or_kill(var0) {
  var0 notify("reenable_ai_on_player_fire_or_kill");
  var0 endon("reenable_ai_on_player_fire_or_kill");
  var0 endon("delete_disguise_threads_on_player");

  for(;;) {
    var0 waittill("weapon_fired");
    reenable_ai_for_player(var0);
    break;
  }
}

function reenable_ai_for_player(var0) {}

function delete_player_overlay(var0) {
  if(isDefined(var0.disguise_overlay)) {
    var0.disguise_overlay destroy();
    return;
  }
}

function watch_for_disguised_player_enter_vehicle() {
  self notify("watch_for_disguised_player_enter_vehicle");
  self endon("watch_for_disguised_player_enter_vehicle");
  self endon("delete_disguise_threads_on_player");

  for(;;) {
    var0 = scripts\engine\utility::ref_143af("technical_enterEnd", "technical_exitEnd", "entered_vehicle", "exited_vehicle");

    if(var0 == "entered_vehicle" || var0 == "player_enter_vehicle") {
      if(!istrue(self.first_time_enter_vehicle) && var0 == "entered_vehicle") {
        self.first_time_enter_vehicle = 1;
        disguise_player(self);
        level notify("disguise_grabbed");
      }

      self.gasmaskoverlay.alpha = 0;
      continue;
    }

    if(var0 == "exited_vehicle" || var0 == "player_exit_vehicle") {
      self.gasmaskoverlay fadeovertime(0.1);
      self.gasmaskoverlay.alpha = 1;
    }
  }
}

function init_infil_plane(var0, var1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  level.players_in_c130 = 0;
  scripts\cp\cp_objectives::ref_1317e(var0, scripts\engine\utility::getStruct("plane_objective", "targetname").origin);
  objective_state(var0.objectiveindex, "current");

  if(istrue(level.global_stealth_broken)) {
    scripts\cp\crate_drops\cp_crate_drops::ref_12c40("hijack_2");
  }

  thread ref_1445d();
  level.players_in_plane = [];

  foreach(var3 in level.players) {
    thread watch_for_players_in_plane();
  }

  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&watch_for_players_in_plane);

  if(getdvarint("scr_takeoff_test", 0) != 0) {
    wait 10;
  } else if(getdvarint("scr_landing_test", 0) != 0) {
    wait 10;
  } else {
    thread spawn_convoys_as_players_get_closer();
  }

  if(getdvarint("scr_door_sequence", 0) != 0) {
    level.c130.origin = (-5904.63, 24812.8, -453.349);
    level.c130.angles += (0, 180, 0);
    level.c130 playLoopSound("scn_cp_747_engine_ext_lp");

    foreach(var6 in level.flytime) {
      if(var6.classname == "light_spot" || var6.classname == "light_omni") {
        var6 setlightintensity(10);
      }
    }

    var8 = scripts\cp_mp\anim_scene::anim_scene_create_actor(level.c130, "plane");
    var9 = level.c130 scripts\cp_mp\anim_scene::anim_scene([var8], "open", 0, 0);
    level.intro_fadeup = &intro_fadeup;

    if(isDefined(level.claxons["scripted_plane"])) {
      claxon_lights_on("scripted_plane");
    }
  } else {
    start_landing_sequence(var0);
  }

  level.bad_obstacle_id = createnavbadplacebyent(level.c130);
}

function ref_1445d() {
  var0 = 1;
  var1 = scripts\engine\utility::getStruct("plane_objective", "targetname").origin;

  while(var0) {
    var0 = 1;

    foreach(var3 in level.players) {
      if(distance2dsquared(var3.origin, var1) >= 268435456) {
        var0 = 1;
        continue;
      }

      var0 = 0;
      break;
    }

    wait 0.5;
  }

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("tarmac_patrol");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("tarmac_patrol_plane");
  spawn_convoys_as_players_get_closer();
}

function dosmokecurtains(var0, var1) {
  level endon("game_ended");
  level endon("all_players_teleported_to_plane");
  level endon("all_enemy_vehicles_leave");
  level endon("cleared_for_takeoff");
  wait var1;
  var2 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");
  var3 = 8;

  foreach(var5 in var2) {
    var6 = randomfloat(2);
    thread ref_14403(var5, var6);
    waitframe();
  }
}

function ref_14403(var0, var1) {
  level endon("game_ended");
  wait var1;
  var2 = spawn("script_model", var0.origin);
  var2.angles = scripts\engine\utility::ter_op(isDefined(var0.angles), var0.angles, (0, 0, 0));
  waitframe();
  var3 = spawnfx(level._effect["vfx_armsrace_smoke"], var2.origin, anglesToForward(var2.angles), anglestoup(var2.angles));
  triggerfx(var3);
  level scripts\engine\utility::ref_143a6("all_enemy_vehicles_leave", "cleared_for_takeoff", "all_players_teleported_to_plane");
  var3 delete();
  var2 delete();
}

function ref_1446f() {}

function watch_for_players_in_plane() {
  self endon("disconnect");
  self endon("kill_thread");
  self notify("watch_for_players_in_plane");
  self endon("watch_for_players_in_plane");

  if(!isDefined(level.players_in_plane)) {
    level.players_in_plane = [];
  }

  for(;;) {
    if(istrue(self.inlaststand)) {
      wait 3;
      continue;
    }

    if(self istouching(level.ref_12b48)) {
      if(!scripts\engine\utility::array_contains(level.players_in_plane, self)) {
        level.players_in_plane = scripts\engine\utility::array_add(level.players_in_plane, self);
      }
    } else if(scripts\engine\utility::array_contains(level.players_in_plane, self)) {
      level.players_in_plane = scripts\engine\utility::array_remove(level.players_in_plane, self);
    }

    if(level.players_in_plane.size >= brdoesloadoutoptiongivecustomweaponsimmediately()) {
      level notify("cleared_for_takeoff");
      break;
    }

    wait 1;
  }
}

function callback_frontendplayeractive() {
  foreach(var1 in brdoesloadoutoptiongivestandardloadoutimmediately()) {
    if(!var1 istouching(level.ref_12b48)) {
      return false;
    }
  }

  return true;
}

function start_infil_plane(var0, var1) {
  thread stop_clear_players_from_door_way_think();
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_c130_approach");

  if(getdvarint("scr_takeoff_test", 0) != 0) {
    close_plane_doors();
    thread c130_take_off_sequence();

    for(;;) {
      start_landing_sequence(var0);
      wait 5;
      close_plane_doors();
      thread c130_take_off_sequence();
      level waittill("plane_taken_off");
    }
  }

  if(getdvarint("scr_landing_test", 0) != 0) {
    level waittill("infinite");
  }

  var2 = scripts\engine\utility::ter_op(getdvarint("scr_c130_land_time", 0) != 0, getdvarint("scr_c130_land_time", 0), 300);
  thread scripts\cp\utility::objective_update(var0.ref, int(var2), int(var2 / 2), int(var2 / 3), 1);

  foreach(var4 in getaiarray("axis")) {
    var5 = scripts\engine\utility::random(brdoesloadoutoptiongivestandardloadoutimmediately());
    var4 setgoalentity(var5);
    thread ref_11cdb(var4);
  }

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("plane_jugg_guard");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("plane_patrol");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("tarmac_patrol");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("tarmac_patrol_plane");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("hack_airport_combat");
  objective_setlocation(var0.objectiveindex, 0, level.ref_12b48.origin);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_1317e(var0, level.ref_12b48.origin);
  objective_setzoffset(var0.objectiveindex, 90);
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setplayoutro(var0.objectiveindex, 1);
  objective_setshowdistance(var0.objectiveindex, 1);
  objective_setfadedisabled(var0.objectiveindex, 1);
  thread little_bird_initdamage(var2 / 2);
  objective_setlabel(var0.objectiveindex, &"CP_FUBAR/REACH_PLANE");
  take_off_loop(var0);
}

function ref_11cdb(var0) {
  self notify("monitor_enemy_death");
  self endon("monitor_enemy_death");
  self endon("death");
  self endon("death");
  var0 waittill("death");
  var1 = scripts\engine\utility::random(brdoesloadoutoptiongivestandardloadoutimmediately());

  if(isDefined(var1)) {
    self setgoalentity(var1);
    return;
  }
}

function little_bird_initdamage(var0) {
  wait var0;
  ref_138bb();
}

function ref_138bb() {
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  ref_13bbb(1);
}

function brjugg_oncrateactivate() {
  setnojipscore(0, 1);
  setnojiptime(0, 1);
  ref_13bbb(undefined);
}

function stop_clear_players_from_door_way_think() {
  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_approach_10", 3);
  thread ref_12403(level, ["dx_cps_lass_plane_board_nag_10", "dx_cps_kama_plane_board_nag_20"]);
}

function ref_11ee4(var0) {
  level endon("breached_upper_door");
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = 0;

  while(var0 > 0) {
    if(istrue(level.dialogue_playing)) {
      wait 1;
      continue;
    }

    if(var0 >= 120 && var0 <= 140 && (!istrue(var1) || !istrue(var1))) {
      if(!istrue(var1)) {
        scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_on_plane_10");
        var1 = 1;
      } else {
        scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_on_plane_2min_10");
        var2 = 1;
      }
    } else if(var0 >= 60 && var0 <= 69 && !istrue(var3)) {
      scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_on_plane_1min_10");
      var3 = 1;
    } else if(var0 >= 30 && var0 <= 35 && !istrue(var4)) {
      scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_on_plane_30sec_10");
      var4 = 1;
    }

    var0--;
    wait 1;
  }
}

function spawn_convoys_as_players_get_closer() {
  thread spawn_intro_choppers();
  wait 5;

  if(!istrue(level.spawned_convoys)) {
    thread spawn_convoys();
    level.spawned_convoys = 1;
    return;
  }
}

function spawn_convoys() {
  level endon("game_ended");

  while(!istrue(level.global_stealth_broken)) {
    wait 1;
  }

  wait 2;
  thread scripts\cp\cp_modular_spawning::run_spawn_module("techo_phys_tarmac1");
  wait 10;
}

function spawn_pavelows() {
  var0 = scripts\engine\utility::random(level.players);
  scripts\cp\killstreaks\chopper_support_cp::chopper_support_create_enemy_chopper(var0);
}

function spawn_intro_choppers() {
  wait 5;
  var0 = scripts\engine\utility::getStructArray("intro_heli_spawn", "targetname");

  foreach(var2 in var0) {
    var2.classname_mp = "script_vehicle_iw8_mindia8";
    var2.script_modelname = "veh8_mil_air_mindia8";
    var2.vehicletype = "mindia8_cp";
    var3 = scripts\common\vehicle::vehicle_spawn(var2);
    thread setup_pilot();
    var3.isheli = 1;
    var3.health = 50000;
    var3.maxhealth = 50000;
    var3.team = "axis";
    var3 setvehicleteam(var3.team);
    var3 setmaxpitchroll(15, 15);
    var3 sethoverparams(25, 15, 10);
    thread intro_chopper();
    wait 2;
  }
}

function intro_chopper() {
  self endon("death");
  self vehicle_setspeed(20, 15, 15);
  self setvehgoalpos(self.origin + (0, 0, 1200), 1);
  scripts\engine\utility::ref_143bb(10, "goal", "goal_reached", "near_goal");
  var0 = scripts\engine\utility::getStruct("intro_chopper_delete", "targetname");
  self vehicle_setspeed(90, 30, 30);
  self setvehgoalpos(var0.origin, 1);
  scripts\engine\utility::ref_143a6("goal", "goal_reached", "near_goal");
  self.pilot delete();
  self delete();
}

function start_convoy(var0, var1, var2) {
  if(!isDefined(level.runway_convoys)) {
    level.runway_convoys = [];
  }

  var3 = scripts\engine\utility::getStruct(var1, "targetname");

  if(!isDefined(var2)) {
    var2 = "double-techo-turret";
  }

  thread set_convoy_settings(level, var0, var2);
}

function set_convoy_settings(var0, var1, var2) {
  level endon("game_ended");
  var3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var4 = level[[var3]](var0, var1, var2);
  thread respawn_on_death(var4, var0, var1);
  level.runway_convoys = scripts\engine\utility::array_add(level.runway_convoys, var4);
  level waittill("despawn_" + var0);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

function respawn_on_death(var0, var1, var2) {
  level endon("despawn_" + var0);
  self waittill("death");

  if(scripts\engine\utility::array_contains(level.runway_convoys, self)) {
    level.runway_convoys = scripts\engine\utility::array_remove(level.runway_convoys, self);
  }

  set_convoy_settings(var0, var1, var2);
}

function reduce_timer_on_breaking_stealth(var0, var1) {
  level endon("cleared_for_takeoff");
  level endon(var0.ref + "_timer_complete");
  level waittill("weapons_free");
  var1 /= 2;
  thread scripts\cp\utility::objective_update(var0.ref, int(var1), int(var1 / 2), int(var1 / 3), 1);
}

function open_plane_doors_anim() {
  var0 = getanimlength(level.scr_anim["plane"]["open"]);
  var1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "plane");
  var2 = scripts\cp_mp\anim_scene::anim_scene([var1], "open");
}

function close_plane_doors_anim() {
  var0 = getanimlength(level.scr_anim["plane"]["close"]);
  var1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "plane");
  level.c130.ref_12a4f playsoundonmovingent("scn_cp_plane_hijack_cargo_door_close");
  var1 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "close", 1);
  var2 = scripts\cp_mp\anim_scene::anim_scene([var1], "close");
  wait var0;
}

function open_plane_doors() {
  level.c130.lower_door unlink();
  level.c130.lower_door rotatepitch(-35, 3);
  wait 3;
  level.c130.lower_door.origin -= (0, 0, 110);
}

function close_plane_doors() {
  level.ref_127f4 = &playerincrementscoreboardkills;
  close_plane_doors_anim(level.c130);
  level.ref_127f4 = undefined;
  level.intro_fadeup = undefined;
}

function playerincrementscoreboardkills() {
  self endon("disconnect");
  level endon("game_ended");

  while(istrue(self.run_kill_watcher)) {
    waitframe();
  }

  if(istrue(self.binc130)) {
    return;
  }

  self.combo_progression = 0;
  self.get_vehicle_node_to_wait_for_lbravo_based_on_group = self.name + "^5 - player isn't in the plane! ";

  if(self istouching(level.ref_12b48) || self istouching(level.c130.ref_12a4f)) {
    self.combo_progression = 1;
    self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "touched regroup trigger OR the rear door";
  }

  if(!istrue(self.combo_progression)) {
    foreach(var1 in level.c130.body) {
      if(isDefined(var1)) {
        if(self istouching(var1)) {
          self.combo_progression = 1;
          self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "touched the Plane interior geo";
          break;
        }
      }
    }
  }

  if(!istrue(self.combo_progression)) {
    foreach(var4 in level.c130.plane_seats) {
      if(self istouching(var4)) {
        self.combo_progression = 1;
        self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "touched the Plane seat";
        break;
      }
    }
  }

  if(!istrue(self.combo_progression)) {
    if(isDefined(level.c130.shell)) {
      if(self istouching(level.c130.shell)) {
        self.combo_progression = 1;
        self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "touched the Plane body (level.c130) ";
      }
    }
  }

  if(!istrue(self.combo_progression)) {
    if(self istouching(level.c130)) {
      self.combo_progression = 1;
      self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "touched the Plane body (level.c130) ";
    }
  }

  if(istrue(self.combo_progression)) {
    if(!istrue(self.binc130)) {
      playerinitpersstats();
      return;
    }

    return;
  }

  if(!istrue(self.binc130)) {
    playerinitpersstats();
    return;
  }
}

function c130_take_off_sequence(var0, var1) {
  if(istrue(var0)) {
    setDvar("scr_pause_crate_drops", 1);

    if(!istrue(var1)) {
      thread play_turbulence_fx();
      return;
    }

    return;
  }

  level notify("take_off_sequence");
}

function play_turbulence_fx() {
  foreach(var1 in level.players) {
    thread takeoff_turbulence();
  }

  thread check_for_solo();
}

function takeoff_turbulence() {
  self endon("ended_blackout");

  for(;;) {
    if(istrue(self.pause_turbulence)) {
      waitframe();
      continue;
    }

    var0 = randomfloatrange(0.4, 0.6);
    var1 = randomfloatrange(2.5, 5);
    earthquake(var0, var1, self.origin, 64);
    var2 = 3.75;

    if(var1 < var2) {
      self playRumbleOnEntity("tank_rumble");
    } else {
      self playRumbleOnEntity("plr_rumble_4_mp");
    }

    wait randomfloatrange(1, 2);
  }
}

function check_for_solo() {
  waitframe();
  playsoundatpos((-15423, 29040, -3958), "scn_cp_747_takeoff_int");
  level.ref_134e1 = spawn("script_origin", (-15333, 29036, -3976));
  level.ref_134e1 playLoopSound("amb_mp_747_flight_int_lr_script");
}

function end_infil_plane(var0, var1) {
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function move_plane(var0) {
  self notify("move_plane");
  self endon("move_plane");
  self endon("stop_ambient_movement");
  self endon("death");
  var0 endon("death");

  for(;;) {
    var1 = vectortoangles(anglesToForward(var0.angles));
    var0 rotateTo(var1, 1);
    wait 1;
  }
}

function debuginfil_plane(var0) {
  scripts\engine\utility::flag_set("cp_plane_hijack_cs");
  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 10;

  if(getdvarint("scr_takeoff_test", 0) != 0) {
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "door_test_start_points", 1);
  } else if(getdvarint("scr_landing_test", 0) != 0) {
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "door_test_start_points", 1);
  } else if(getdvarint("scr_door_sequence", 0) != 0) {
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "door_test_start_points", 1);
  } else {
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "disguise_start_points", 1);
  }

  if(getdvarint("scr_landing_test", 0) == 0 && getdvarint("scr_takeoff_test", 0) == 0) {
    if(!istrue(level.global_stealth_broken)) {
      thread global_weapons_free();
      scripts\cp\cp_modular_spawning::run_spawn_module("plane_patrol");
      scripts\cp\cp_modular_spawning::run_spawn_module("plane_jugg_guard");
      return;
    }

    return;
  }
}

function start_landing_sequence(var0) {
  level.c130 playsoundonmovingent("scn_cp_747_landing_ext_dist");
  wait 5;
  level.c130 playsoundonmovingent("scn_cp_747_landing_ext");
  level.c130 unlink();
  level.c130.scenenode = scripts\engine\utility::getStruct("plane_landing_scenenode", "targetname");
  thread ref_123a4();
  land_at_airport(level.c130);
}

function ref_123a4() {
  var0 = ["tag_wheels_front", "tag_wheels_middle", "tag_wheels_rear"];
  self.ref_145ac = [];

  foreach(var2 in var0) {
    if(self tagexists(var2)) {
      self.ref_145ac[var2] = spawnfx(level._effect["plane_landing_fx"], self gettagorigin(var2));
    }
  }

  wait 1;

  foreach(var5 in self.ref_145ac) {
    triggerfx(var5);
  }
}

function land_at_airport() {
  self playLoopSound("scn_cp_747_engine_ext_lp");
  var0 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "plane");
  var1 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var0], "landing", 1, 0);
  plane_landed_idle(var0);
}

function plane_landed_idle(var0) {
  var1 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var0], "idle", 0, 0);
  level.c130.ref_12a4f playsoundonmovingent("scn_cp_plane_hijack_cargo_door_open");
  level.intro_fadeup = &intro_fadeup;
  var1 = scripts\cp_mp\anim_scene::anim_scene([var0], "open", 0, 0);
  level.fly_to_node = createnavbadplacebyent(level.c130.ref_12a4f);

  foreach(var3 in level.flytime) {
    if(var3.classname == "light_spot" || var3.classname == "light_omni") {
      var3 setlightintensity(10);
    }

    if(var3.classname == "reflection_probe") {
      var3 show();
    }
  }

  level.ref_123a3 = 1;

  if(isDefined(level.claxons["scripted_plane"])) {
    claxon_lights_on("scripted_plane");
  }

  thread plane_takeoff_from_airport(var0);
}

function intro_fadeup(var0) {
  var1 = var0.origin;
  var2 = var1 + (0, 0, -1000);
  var3 = physics_createcontents(["physicscontents_solid", "physicscontents_item", "physicscontents_ainoshoot", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var4 = scripts\engine\trace::ray_trace(var1, var2, var0, var3);
  var5 = var4["position"];
  var6 = getclosestpointonnavmesh(var5);
  var7 = length(var6 - var5);

  if(var7 > 150) {
    var8 = scripts\engine\utility::drop_to_ground(var1, 5, -1500);
    var8 = getclosestpointonnavmesh(var8);
    var0 setOrigin(var8);
    return;
  }

  var0 setOrigin(var5);
}

function door_open_close_loop() {
  var0 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "plane");

  for(;;) {
    var0 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "open", 1);
    var1 = scripts\cp_mp\anim_scene::anim_scene([var0], "open");
    wait 15;
    var0 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "close", 1);
    var1 = scripts\cp_mp\anim_scene::anim_scene([var0], "close");
    wait 15;
  }
}

function plane_takeoff_from_airport(var0) {
  level waittill("take_off_sequence");
  level.c130 playsoundonmovingent("scn_cp_747_takeoff_ext");
  wait 4;
  var1 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var0], "takeoff", 0, 1);
  level notify("plane_taken_off");
}

function build_path(var0) {
  var1 = [];
  var2 = scripts\engine\utility::getStruct(var0, "targetname");

  for(var1 = var2; isDefined(var2) && isDefined(var2.target); var1 = var2) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function init_collect_nuclear_core(var0, var1) {
  level.chopper_death_callback = scripts\engine\utility::getStructArray("backup_teleport_start_points", "targetname");
  level.ref_127f6 = &getdefaultweaponbasename;

  foreach(var3 in level.players) {
    var3 setclientomnvar("ui_cp_mission_fail_index", 0);
  }

  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);

  if(scripts\engine\utility::array_contains(level.onplayerspawncallbacks, &watch_for_players_in_plane)) {
    level.onplayerspawncallbacks = scripts\engine\utility::array_remove(level.onplayerspawncallbacks, &watch_for_players_in_plane);
  }

  if(scripts\engine\utility::array_contains(level.onplayerspawncallbacks, &givedisguiseonspawn)) {
    level.onplayerspawncallbacks = scripts\engine\utility::array_remove(level.onplayerspawncallbacks, &givedisguiseonspawn);
  }

  if(!scripts\engine\utility::flag_exist("disable_death_shield")) {
    scripts\engine\utility::flag_init("disable_death_shield");
  }

  init_gas_masks();
  setup_aisettings_on_plane();
  thread watch_for_timer_on_plane(level);
  scripts\cp\cp_modular_spawning::stop_all_groups();

  foreach(var6 in getaiarray("axis")) {
    var6 scripts\cp\cp_modular_spawning::script_kill_ai();
  }

  scripts\cp\cp_modular_spawning::kill_off_enemies(undefined, level.spawned_enemies.size, 1);
  waitframe();
  level notify("spawn_ai_now");
  script_model_anims();
  scripts\mp\playeractions::registeractionset("nuke_core", ["weapon_pickup", "offhand_weapons", "weapon_switch", "gesture", "ads", "reload", "autoreload", "sprint", "crouch", "prone", "fire", "melee", "mantle"]);
  scripts\mp\playeractions::registeractionset("nuke_core_exfil", ["sprint", "crouch", "prone"]);
  var0.c4_nuke = scripts\cp\cp_breach_c4::setup_c4(scripts\engine\utility::getStruct("c4_interact_nuke", "targetname"));
  thread watch_for_nuke_planted();
  level.nuclear_core_interaction = &give_nuclear_core_from_parachute;
}

function init_gas_masks() {
  level.gas_masks_middle = [];
  level.gas_masks_side = [];
  var0 = getscriptablearray("air_masks_middle", "targetname");

  foreach(var2 in var0) {
    level.gas_masks_middle[level.gas_masks_middle.size] = var2;
  }

  var0 = getscriptablearray("air_masks_side", "targetname");

  foreach(var2 in var0) {
    level.gas_masks_side[level.gas_masks_side.size] = var2;
  }

  if(isDefined(level.gas_masks_middle)) {
    foreach(var7 in level.gas_masks_middle) {
      var7 setscriptablepartstate("base", "show_pristine");
    }
  }

  if(isDefined(level.gas_masks_side)) {
    foreach(var7 in level.gas_masks_side) {
      var7 setscriptablepartstate("base", "show_b_pristine");
    }

    return;
  }
}

function trigger_nearest_gasmasks() {
  self endon("death");
  self endon("disconnect");
  var0 = self;

  if(!isDefined(level.gas_masks_middle) && !isDefined(level.gas_masks_side)) {
    return;
  }

  var1 = scripts\engine\utility::get_array_of_closest(var0.origin, level.gas_masks_middle, undefined, 5, 1000);
  var2 = scripts\engine\utility::get_array_of_closest(var0.origin, level.gas_masks_side, undefined, 5, 1000);

  if(isDefined(var1) && var1.size > 0) {
    foreach(var4 in var1) {
      if(istrue(var4.triggered)) {
        if(randomint(100) > 50) {
          var4 setscriptablepartstate("base", "show_hectic");
        } else {
          var4 setscriptablepartstate("base", "show_mellow");
        }

        continue;
      }

      var4 setscriptablepartstate("base", "show_fall");
      var4.triggered = 1;
    }
  }

  if(isDefined(var2) && var2.size > 0) {
    foreach(var4 in var2) {
      if(istrue(var4.triggered)) {
        if(randomint(100) > 50) {
          var4 setscriptablepartstate("base", "show_b_hectic");
        } else {
          var4 setscriptablepartstate("base", "show_b_mellow");
        }

        continue;
      }

      var4 setscriptablepartstate("base", "show_b_fall");
      var4.triggered = 1;
    }

    return;
  }
}

function watch_for_timer_on_plane(var0) {
  level endon("timer_in_plane_ended");
  level waittill(var0 + "_timer_complete");

  if(!isDefined(level.nuclear_core_carrier)) {
    foreach(var2 in level.players) {
      thread screen_fade_to_black(var2, 3);
    }

    thread ref_123e2();
    scripts\cp\cp_objectives::ref_12868(var0);
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    return;
  }
}

function setup_aisettings_on_plane() {}

function reset_aisettings_on_plane() {}

function give_nuclear_core_from_parachute() {}

function start_smoke_show() {
  wait 0.5;
  var0 = "smoke_grenade_mp";

  foreach(var2 in scripts\engine\utility::getStructArray("mhc_smoke_point", "script_noteworthy")) {
    playFX(level._effect["breach_jugg_smoke"], var2.origin);
  }
}

function script_model_anims() {
  level.scr_animtree["nuke"] = #animtree;
  level.scr_anim["nuke"]["nuke_open"] = % cp_prop_nuclear_warhead_open;
  level.scr_animname["nuke"]["nuke_open"] = "cp_prop_nuclear_warhead_open";
}

function watch_for_nuke_planted() {
  scripts\engine\utility::ent_flag_wait("c4_exploded");
  playFX(level._effect["breach_jugg_explosion"], self.origin);
  scripts\engine\utility::array_call(getEntArray("breach_door_nuke", "targetname"), &delete);
  start_smoke_show();
  thread start_spawners_after_time();
  thread ref_13811();
  level notify("breached_upper_door");
}

function start_spawners_after_time() {
  wait 0.3;
  scripts\cp\cp_modular_spawning::run_spawn_module("nuke_defenders");
}

function watch_for_escape_door_breached() {
  scripts\engine\utility::ent_flag_wait("c4_exploded");
  level.ref_13e39 = 2;
  playFX(level._effect["breach_explosion_plane"], self.origin);
  playsoundatpos(self.origin, "scn_cp_747_breach_exp");
  playsoundatpos(self.origin, "breach_c4_expl_trans");

  foreach(var1 in level.c4_escape_array) {
    if(isDefined(var1)) {
      var1 delete();
    }
  }

  waitframe();
  var3 = getEntArray("escape_collision", "script_noteworthy")[0];
  var3 playLoopSound("scn_cp_747_engine_ext_lp");
  level notify("breached_exit");
  thread check_for_nearby_packages();

  foreach(var5 in getEntArray("breach_door_escape_stationary", "targetname")) {
    if(isDefined(var5.model) && var5.model == "veh8_civ_air_airplane_exterior_door_01" || var5 != var3) {
      var5 delete();
    }
  }

  ref_137a8();
  thread labels(var3, 20);
}

function labels(var0, var1) {
  wait var1;
  var0 stoploopsound();
  var0 delete();
}

function check_for_nearby_packages() {
  var0 = spawn("script_origin", (-14784, 28800, -3958));
  var0 playLoopSound("scn_cp_747_c4_breach_wind_lp");
  wait 20;
  var0 stoploopsound();
  waitframe();
  var0 delete();
}

function ref_137a8() {
  level.movement_vector = scripts\engine\utility::getStructArray("end_breach_smoke_fx", "targetname");

  foreach(var1 in level.movement_vector) {
    var1.fx = spawnfx(level._effect[var1.targetname], var1.origin);
    waitframe();
  }

  waitframe();

  foreach(var1 in level.movement_vector) {
    triggerfx(var1.fx);
    waitframe();
  }
}

function ref_138b7() {
  foreach(var1 in level.movement_vector) {
    var1.fx delete();
  }
}

function ref_12404() {
  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_on_plane_15");
}

function getdefaultweaponbasename() {
  level endon("game_ended");

  if(istrue(self.binc130)) {
    return;
  }

  if(istrue(self.run_kill_watcher)) {
    playerincrementscoreboardkills();
    return;
  }

  thread playerinitpersstats();
}

function playerinitpersstats() {
  var0 = self;
  var0 endon("disconnect");

  while(istrue(var0.being_revived)) {
    waitframe();
  }

  while(istrue(var0.run_kill_watcher)) {
    waitframe();
  }

  while(istrue(var0.isreviving)) {
    var0.can_revive = 0;
    var0.ref_12d13 = self.forcespawnorigin;
    var0 notify("revive_done");
    waitframe();
  }

  var0 notify("killstreakExit");
  var0 notify("kill_thread");

  if(!isDefined(level.chopper_death_callback)) {
    level.chopper_death_callback = scripts\engine\utility::getStructArray("backup_teleport_start_points", "targetname");
  } else if(level.chopper_death_callback.size == 0) {
    level.chopper_death_callback = scripts\engine\utility::getStructArray("backup_teleport_start_points", "targetname");
  }

  var1 = scripts\engine\utility::random(level.chopper_death_callback);
  level.chopper_death_callback = scripts\engine\utility::array_remove(level.chopper_death_callback, var1);
  var0.respawn_forcespawnorigin = var1.origin;
  var0.respawn_forcespawnangles = var1.angles;
  var0.forcespawnorigin = var0.respawn_forcespawnorigin;
  var0.forcespawnangles = var0.respawn_forcespawnangles;

  if(istrue(var0.isreviving)) {
    var0.can_revive = 0;
    var0.ref_12d13 = var0.forcespawnorigin;
    var0 notify("revive_done");
  }

  if(istrue(var0.inlaststand)) {
    if(istrue(var0.being_revived)) {
      var0 notify("revive_done");
      var0.being_revived = 0;
    } else {
      var0 notify("force_bleed_out");
      var0.binc130 = 1;

      if(isDefined(level.disguised_players)) {
        if(scripts\engine\utility::array_contains(level.disguised_players, var0)) {
          remove_disguise(var0);
        }
      }

      return;
    }
  }

  level notify("cp_force_killstreak_exit");

  if(isDefined(level.choppergunners)) {
    foreach(var3 in level.choppergunners) {
      var3 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
    }
  }

  if(isDefined(var0.helperdrone)) {
    var0.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);
  }

  if(isDefined(var0.currentturret)) {
    var0.currentturret notify("kill_turret", 0, 0);
    waitframe();
  }

  if(istrue(var0 isparachuting()) || istrue(var0 isskydiving())) {
    var0 skydive_interrupt();
  }

  var5 = var0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var5)) {
    var6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var5, var0);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var5, var6, var0, undefined, 1);
  }

  var0 setclientomnvar("ui_hide_bigmap", 1);
  var0 skydive_setbasejumpingstatus(0);
  var0 skydive_setdeploymentstatus(0);
  thread teleport_black_overlay(var0);
  thread ref_13ae2();

  if(var0.class == "engineer" || var0.class == "hunter") {
    var0.disable_super = 1;
  }

  var0 setmlgdamagedone();
  var0 setOrigin(var1.origin, 1);
  thread start_turbulence_sequence();
  thread delay_set_plane_specific_vars(var0, var0);

  if(!isDefined(var1.angles)) {
    var1.angles = (0, 0, 0);
  }

  var0 setplayerangles(var1.angles);
  var0.binc130 = 1;
  level notify("spawn_enemies_in_plane");
  var0 scripts\cp\utility::brjugg_setconfig(1);
  var0.can_revive = 1;

  if(isDefined(level.disguised_players)) {
    if(scripts\engine\utility::array_contains(level.disguised_players, var0)) {
      remove_disguise(var0);
      return;
    }

    return;
  }
}

function ref_12c8f() {
  level endon("game_ended");
  wait 8;

  foreach(var1 in level.players) {
    if(istrue(var1.binc130)) {
      continue;
    }

    if(!scripts\cp\utility\player::isreallyalive(var1)) {
      continue;
    }

    thread playerinitpersstats();
  }

  level.ref_127f6 = undefined;
}

function start_collect_nuclear_core(var0, var1) {
  var2 = getEntArray("final_breach_collision", "targetname");

  foreach(var4 in var2) {
    var4 disconnectPaths();
    var4 solid();
  }

  thread ref_12404();
  thread ref_11ee4(180);
  thread ref_12c8f();
  level waittill("breached_upper_door");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_on_plane_20");

  if(isDefined(var0)) {
    var0.nuke_interactions = getEntArray("nuclear_core_model", "targetname");

    foreach(var7 in var0.nuke_interactions) {
      var7 setHintString(&"CP_FUBAR/OPEN_NUKE");
      var7 sethintdisplayrange(200);
      var7 sethintdisplayfov(120);
      var7 setusefov(120);
      var7 setuserange(128);
      var7 sethintonobstruction("show");
      var7 sethinticon("splash_icon_nuke");
      var7 makeusable();
      thread use_nuclear_core(var7);
      objective_setlocation(var0.objectiveindex, 0, var7.origin);
      objective_setlabel(var0.objectiveindex, &"CP_FUBAR/NUCLEAR_CORE_LABEL");
    }
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("mhc_ll_spawners");
  level waittill("collected_core");

  foreach(var10 in level.players) {
    var10 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("assist");
  }

  thread lowpopcheck();
}

function lowpopcheck() {
  level endon("game_ended");
  level thread scripts\cp\utility::ref_123fe("");
  wait 7.33;
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_c130_exfil");
}

function ref_138cd(var0, var1) {
  wait var0 - var1;
  level notify("clean_turbulence_threads");
}

function switch_to_ac130_if_plane_blows_up() {
  foreach(var1 in level.players) {
    if(isDefined(var1.last_stand_state)) {
      if(var1.last_stand_state == "bleed_out") {
        thread revive_player_inside_c130(var1);
      }
    }
  }
}

function revive_player_inside_c130(var0) {
  var0.binc130 = undefined;

  if(isDefined(var0.reviveent)) {
    var0.reviveent delete();
  }

  if(isDefined(var0.reviveiconent)) {
    var0.reviveiconent delete();
  }

  var0 notify("revive_success");
  thread screen_fade_to_black(var0);
}

function end_collect_nuclear_core(var0, var1) {
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function debugstartc130objective(var0) {
  scripts\engine\utility::flag_set("cp_plane_hijack_cs");
  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 10;
  var1 = getEntArray("ground_plane_seats", "targetname");
  level.ground_plane_seats = [];

  foreach(var3 in var1) {
    level.ground_plane_seats = scripts\engine\utility::array_add(level.ground_plane_seats, var3);
  }

  waitframe();

  if(!isDefined(level.disguised_players)) {
    level.disguised_players = [];
  }

  var5 = level.ground_plane_seats;
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "teleport_start_points", 1);
  thread play_turbulence_fx();

  foreach(var7 in level.players) {
    var7 setclientomnvar("ui_hide_bigmap", 1);
    level.disguised_players = scripts\engine\utility::array_add(level.disguised_players, var7);
    var7.binc130 = 1;
    thread start_turbulence_sequence();
  }

  wait 2;
  thread upper_level_plane_combat_start(1);
}

function debugexfilc130objective(var0) {
  scripts\engine\utility::flag_set("cp_plane_hijack_cs");
  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 10;
  ref_13811();
  scripts\mp\playeractions::registeractionset("nuke_core", ["offhand_weapons", "weapon_switch", "gesture", "ads", "reload", "autoreload", "sprint", "crouch", "prone", "fire", "melee", "mantle"]);
  var1 = getEntArray("ground_plane_seats", "targetname");
  level.ground_plane_seats = [];

  foreach(var3 in var1) {
    level.ground_plane_seats = scripts\engine\utility::array_add(level.ground_plane_seats, var3);
  }

  waitframe();
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "teleport_player_start", 1);
  wait 2;
  var5 = scripts\engine\utility::random(level.players);
  thread give_nuclear_core();
  wait 3;
}

function upper_level_plane_combat_start(var0) {
  if(!istrue(var0)) {
    level waittill("spawn_enemies_in_plane");
  } else {
    level waittill("spawn_ai_now");
  }

  level.c130 stoploopsound("scn_cp_747_engine_ext_lp");
  scripts\cp\cp_modular_spawning::run_spawn_module("mhc_spawners");
  scripts\cp\cp_modular_spawning::run_spawn_module("mhc_spawn_smokers");
  level.ref_12213 = undefined;
  level.ref_12b46 = undefined;
}

function debug_teleport_to_c130(var0, var1) {
  var2 = scripts\engine\utility::random(var1);
  var1 = scripts\engine\utility::array_remove(var1, var2);
  var0 unlink();
  thread teleport_black_overlay(var0);
  var0 setseatedanimconditional("seat", 0);
  set_player_angles_inside_plane(var0, var2, undefined, 1);
  var0 setseatedanimconditional("seat", 1);
  var0 playerlinkTo(var2);
  delay_relax_view_arc(var0, var2);
  exit_seat(var0, 1, var2);
  return var1;
}

function set_player_angles_inside_plane(var0, var1, var2, var3) {
  var4 = (0, 0, 0);

  if(isDefined(var2)) {
    var4 = vectortoangles(anglestoleft(var2.angles));
    var5 = var0.origin - var1.origin;
    var6 = rotatevectorinverted(var5, var4);
    var7 = var0.angles - var4;
  } else {
    var4 = vectortoangles(anglestoleft(var1.angles));
  }

  var5 = var0.origin - var1.origin;
  var6 = rotatevectorinverted(var5, var4);
  var7 = var0.angles - var4;
  var5 = var0.origin - var1.origin;
  var6 = rotatevectorinverted(var5, var4);
  var7 = var0.angles - var4;
  var8 = vectortoangles(anglestoleft(var1.angles));
  var9 = rotatevector(var6, var8);
  var0 setplayerangles(var8 + var7);
}

function delay_relax_view_arc(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("player_exit_vehicle");
  waitframe();
  var0 playerlinktodelta(var1, "tag_origin", 0, 180, 180, 180, 180, 1);
}

function exit_seat(var0, var1, var2, var3) {
  if(istrue(var3)) {
    var0 notify("exit_seat");
    var0.exit_seat = 1;
    return;
  }

  if(istrue(var1)) {
    var0 unlink();
    var0 setseatedanimconditional("seat", 0);
    var0 setstance("stand");
    return;
  }
}

function teleport_black_overlay(var0) {
  var0 endon("diconnect");
  var0 setclientomnvar("ui_hide_hud", 1);
  var0 scripts\cp\utility::freezecontrolswrapper(1);
  var1 = newclienthudelem(var0);
  var1.x = 0;
  var1.y = 0;
  var1.alignx = "left";
  var1.aligny = "top";
  var1.sort = 1;
  var1.horzalign = "fullscreen";
  var1.vertalign = "fullscreen";
  var1.alpha = 1;
  var1.foreground = 1;
  var1 setshader("black", 640, 480);
  wait 4;
  var0 notify("ended_blackout");
  var1 fadeovertime(5);
  var1.alpha = 0;
  wait 6;
  var0 setclientomnvar("ui_hide_hud", 0);
  var0 scripts\cp\utility::freezecontrolswrapper(0);
  var1 destroy();
}

function teleport_after_time(var0) {
  wait var0;
  level notify("take_off_done");
}

function use_nuclear_core(var0) {
  self endon("death");
  self notify("use_nuclear_core");
  self endon("use_nuclear_core");

  for(;;) {
    var0 waittill("trigger", var1);

    if(!isPlayer(var1)) {
      continue;
    }

    if(var1 meleeButtonPressed()) {
      continue;
    }

    if(istrue(self.occupied)) {
      continue;
    }

    self.occupied = 1;

    if(!istrue(self.first_press)) {
      self makeunusable();
      self useanimtree(#animtree);
      self.animname = "nuke";
      thread scripts\common\anim::anim_single_solo(self, "nuke_open");
      playFX(level._effect["nuke_core_vapor"], self.origin);
      wait getanimlength(level.scr_anim["nuke"]["nuke_open"]);
      self.occupied = undefined;
      self.first_press = 1;
      thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_nuclear_core_10");
      self setHintString(&"CP_BR_SYRK_OBJECTIVES/EXTRACT_CORE");
      self makeusable();
      thread use_nuclear_core(self);
      return;
    }

    if(var1 hasweapon("iw8_lm_dblmg_mp")) {
      self.occupied = undefined;
      var1 thread scripts\cp\utility::hint_prompt("cant_pick_jugg", 1, 2);
      continue;
    }

    thread play_breach_dialogues();
    thread give_nuclear_core(var1);
    var0 setModel("military_nuke_crate_base_w_nuke_coreless");
    var0 makeunusable();
  }
}

function play_breach_dialogues() {
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/GRAB_CORE");
  wait 3;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/BREACH_PLANE");
}

function give_nuclear_core(var0) {
  if(isDefined(level.nuclear_core)) {
    level.nuclear_core delete();
  }

  level.nuclear_core_carrier = self;

  if(isDefined(var0)) {
    if(isDefined(var0.headiconid)) {
      var0 thread scripts\cp\utility::ent_deleteheadicon(var0, var0.headiconid);
    }
  }

  self.previousweaponbeforenukein747 = self getcurrentweapon();
  var1 = getcompleteweaponname("iw8_nukecore_mp");
  scripts\cp\utility::_giveweapon(var1);
  self switchtoweaponimmediate(var1);
  scripts\mp\playeractions::allowactionset("nuke_core", 0);
  self allowmountside(0);
  self allowmounttop(0);
  self allowjog(0);
  self.headicon = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(race_dogtag_init(), "cp_tac_hud_icon_nuke", 30, 1, 29000, 29000, undefined, 1, 0, undefined, 1);
  scripts\cp\respawn\cp_respawn::watchnukeweaponenduse(var1, self.previousweaponbeforenukein747);
  self notify("stop_marker");
  level notify("collected_core");
}

function race_dogtag_init() {
  var0 = [];

  foreach(var2 in level.players) {
    if(scripts\cp\utility\player::isreallyalive(var2)) {
      if(istrue(var2.binc130)) {
        var0 = scripts\engine\utility::array_add(var0, var2);
      }
    }
  }

  return var0;
}

function watcher_for_core_pickup() {
  self endon("dropped_core");

  for(;;) {
    self waittill("finish_pickup_of_weapon", var0, var1);

    if(var0 != "iw8_nukecore_mp") {
      continue;
    }

    var2 = undefined;

    foreach(var4 in self getweaponslistprimaries()) {
      if(var4.basename == var0) {
        var2 = var4;
        break;
      }
    }

    self allowmountside(0);
    self allowmounttop(0);
    self allowjog(0);
    level.nuclear_core_carrier = self;
    scripts\mp\playeractions::allowactionset("nuke_core", 0);
    scripts\cp\respawn\cp_respawn::watchnukeweaponenduse(var2, var1);
  }
}

function disable_features_for_core_carrier(var0) {}

function lower_level_plane_combat_start() {
  level.c4_escape_array = [];
  var0 = scripts\engine\utility::getStructArray("c4_interact_escape", "targetname");
  level.brmini_createc130pathstruct = &ref_123ce;

  foreach(var2 in var0) {
    var3 = scripts\cp\cp_breach_c4::setup_c4(var2);
    var3 setHintString(&"CP_FUBAR/EXFIL_C130");
    var3.bskipplantsequence = 1;
    level.c4_escape_array = scripts\engine\utility::array_add(level.c4_escape_array, var3);
    thread watch_for_escape_door_breached();
  }
}

function start_turbulence_sequence() {
  self notify("clean_turbulence_threads");
  self endon("clean_turbulence_threads");
  level endon("clean_turbulence_threads");
  self endon("death");
  self endon("disconnect");
  thread ref_137e4();

  for(;;) {
    var0 = randomfloatrange(6, 10);
    self earthquakeforplayer(0.1, var0 + 1.5, self.origin, 150);
    thread stumble_ai();
    thread stumble_player();
    thread trigger_nearest_gasmasks();
    playsoundatpos((0, 0, 0), "scn_cp_747_turbulence_int");
    wait var0;
  }
}

function ref_137e4() {
  self notify("clean_turbulence_threads");
  self endon("clean_turbulence_threads");
  level endon("clean_turbulence_threads");
  self endon("death");
  self endon("disconnect");
  level.ref_13e39 = 1;

  for(;;) {
    self earthquakeforplayer(0.169 * level.ref_13e39, 10, self.origin, 150);
    wait 5;
  }
}

function stumble_ai() {
  if(istrue(level.ai_stumbling)) {
    return;
  }

  level.ai_stumbling = 1;

  foreach(var1 in getaiarray("axis")) {
    if(isDefined(var1)) {
      if(isDefined(var1.agent_type) && var1.agent_type == "actor_enemy_cp_rus_juggernaut") {
        continue;
      }

      var2 = scripts\engine\utility::random(["left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot"]);
      var1 dodamage(1, var1.origin, undefined, undefined, "MOD_RIFLE_BULLET", undefined, var2);
    }

    wait randomfloatrange(0.05, 0.1);
  }

  level notify("engage_gasmasks");
  wait randomfloatrange(15, 20);
  level.ai_stumbling = undefined;
}

function player_munition_slots_full(var0) {
  var0 endon("death");
  var0 childthread scripts\anim\combat_utility::flashbangstart(2.5);
}

function stumble_player() {
  self endon("death");
  self endon("disconnect");

  if(istrue(self.pause_turbulence)) {
    return;
  }

  if(istrue(self.ref_140ae)) {
    return;
  }

  if(istrue(self.playing_stumble) || istrue(self.shouldplaystumble)) {
    return;
  }

  if(self getcurrentweapon().basename == "none") {
    return;
  }

  self.playing_stumble = 1;
  var0 = randomfloatrange(0.6, 1.2);
  var1 = randomfloatrange(1.25, 2.5);
  earthquake(var0, var1, self.origin, 64);
  var2 = 1.875;

  if(var1 < var2) {
    self playRumbleOnEntity("tank_rumble");
  } else {
    self playRumbleOnEntity("plr_rumble_4_mp");
  }

  if(scripts\engine\utility::cointoss()) {
    self forceplaygestureviewmodel("ges_stumble_1", undefined, 0.5, 0, 1);
    wait randomfloatrange(0.6, 1.2);
    self stopgestureviewmodel("ges_stumble_1", 0.5, 1);
  } else {
    self forceplaygestureviewmodel("ges_stumble_2", undefined, 0.5, 0, 1);
    wait randomfloatrange(0.6, 1.2);
    self stopgestureviewmodel("ges_stumble_2", 0.5, 1);
  }

  self.playing_stumble = undefined;
}

function rotate_plane_randomly() {
  level endon("clean_turbulence_threads");

  for(;;) {
    wait 0.5;
    var0 = randomintrange(-20, 20);
    self.og_rotation = var0 * -1;
    self rotateroll(var0, 1, 0.5);
    level notify("turbulence_event_start");
    wait 2;
    self rotateroll(self.og_rotation, 1, 0.5);
    level notify("turbulence_event_end");
    wait randomintrange(5, 10);
  }
}

function init_exfil_plane(var0, var1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  level.teleport_geo = getEntArray("teleport_geo", "targetname");
  level.teleport_trigger = getEnt("teleport_trigger", "script_noteworthy");
  level.ref_13ae7 = getEnt("teleport_room", "script_noteworthy");
  objective_setlocation(var0.objectiveindex, 0, level.ref_13ae7.origin);
  objective_state(var0.objectiveindex, "current");
  objective_setlabel(var0.objectiveindex, &"CP_FUBAR/EXIT_ROOM_LABEL");
  thread lower_level_plane_combat_start();
}

function brdoesloadoutoptiongivestandardloadoutimmediately() {
  var0 = 0;
  level.brdoesloadoutoptionrequireclassselection = [];

  foreach(var2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
      continue;
    }

    level.brdoesloadoutoptionrequireclassselection = scripts\engine\utility::array_add(level.brdoesloadoutoptionrequireclassselection, var2);
  }

  return level.brdoesloadoutoptionrequireclassselection;
}

function brdoesloadoutoptiongivecustomweaponsimmediately() {
  var0 = 0;

  foreach(var2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
      var0++;
    }
  }

  level.brdoesloadoutoptiongivecustomweaponsimmediately = abs(level.players.size - var0);
  return level.brdoesloadoutoptiongivecustomweaponsimmediately;
}

function start_exfil_plane(var0, var1) {
  level.c130.origin = (-20547, 12615, 12000);
  level.c130.mp_cave_am_patch = (-2160.06, -3585.91, 12000);
  level.c130.mp_crash2 = (80648.1, 28300.1, 3333);
  level.c130.angles = (0, 15, 0);
  thread watch_for_objective_failure(level);
  level.ref_13e39 = 2;

  if(!isDefined(level.landed_players)) {
    level.landed_players = [];
  }

  thread delay_plane_explosion();
  thread ref_123e1();
  var2 = level scripts\engine\utility::ref_143ad("breached_exit", "breached_exit_timer");
  objective_unsetlocation(var0.objectiveindex, 0);

  if(var2 == "breached_exit") {
    level.ref_13ae7 delete();
    thread ref_13805();
    level.ref_13ae8 = getEnt("teleport_trigger", "targetname");
    thread ref_13ade();
    thread ref_14324(level, var0);

    while(!istrue(level.ref_128b8)) {
      waitframe();
    }

    foreach(var4 in getaiarray("axis")) {
      var4 scripts\cp\cp_modular_spawning::script_kill_ai();
    }

    level notify("clean_turbulence_threads");
    return;
  }
}

function ref_123e1() {
  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_success_10");
}

function ref_13805() {
  self endon("death");
  playFXOnTag(level._effect["smoke_door_fx"], self, "tag_origin");
}

function ref_14324(var0, var1) {
  thread scripts\cp\utility::objective_update(var0.ref, var1, int(var1 / 2), int(var1 / 3), 1);
  level waittill(var0.ref + "_timer_complete");
  level notify("enable_respawns");

  if(isDefined(level.ref_134e1)) {
    level.ref_134e1 delete();
  }

  if(isDefined(level.c130)) {
    level.c130 notify("airstrikes_done");
  }

  if(istrue(level.ref_11eda)) {
    foreach(var3 in level.players) {
      if(scripts\engine\utility::array_contains(level.landed_players, var3)) {
        continue;
      }

      if(istrue(var3.inlaststand)) {
        var3 notify("force_bleed_out");
        continue;
      }

      level notify("enable_respawns");
      var3.shouldskiplaststand = 1;
      var3.shouldskipdeathsshield = 1;

      if(var3.class == "engineer" || var3.class == "hunter") {
        var3.disable_super = undefined;
      }

      thread screen_fade_to_black(var3);
      var3 dodamage(var3.maxhealth + 100000, var3.origin);
    }

    level.ref_128b8 = 1;
    return;
  }

  thread ref_123e2();
  scripts\cp\cp_objectives::ref_12868(var3.ref);
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function ref_123e2(var0) {
  level.ref_13e39 = 5;
  playsoundatpos((0, 0, 0), "scn_cp_747_turbulence_int");

  foreach(var2 in level.players) {
    if(!istrue(var2.inlaststand)) {
      thread ref_137e4();
    }
  }

  var4 = scripts\engine\utility::getStructArray("c4_interact_escape", "targetname");
  var5 = getEntArray("escape_collision", "script_noteworthy")[0];

  if(istrue(var0)) {
    var4 = level.c4_escape_array;
  }

  foreach(var7 in var4) {
    if(isDefined(var7)) {
      playFX(level._effect["breach_explosion_plane"], var7.origin);
      playFX(level._effect["breach_jugg_smoke"], var7.origin);
      var5 playLoopSound("scn_cp_747_engine_ext_lp");

      foreach(var9 in getEntArray("breach_door_escape_stationary", "targetname")) {
        if(isDefined(var9.model) && var9.model == "veh8_civ_air_airplane_exterior_door_01") {
          var9 delete();
        }
      }

      playsoundatpos(var5.origin, "scn_cp_747_breach_exp");
      playsoundatpos(var5.origin, "breach_c4_expl_trans");
      thread check_for_nearby_packages();
      ref_137a8();
    }
  }

  wait 5;

  if(isDefined(var5)) {
    var5 stoploopsound();
    return;
  }
}

function kill_players(var0) {
  if(istrue(self.bteleported)) {
    return;
  }

  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self) {
    scripts\cp\cp_objectives::overridenextstep(var0, "recover_nuclear_core");
  }

  self.shouldskiplaststand = 1;
  self.shouldskipdeathsshield = 1;
  self.binc130 = undefined;
  thread screen_fade_to_black(3);
  self dodamage(self.maxhealth + 100000, self.origin);
}

function screen_fade_to_black(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  var2 = self;

  if(istrue(var1)) {
    var2 setclientomnvar("ui_hide_hud", 1);
    var2 scripts\cp\utility::freezecontrolswrapper(1);
  }

  if(!isDefined(var2.black_screen)) {
    var2.black_screen = newclienthudelem(var2);
    var2.black_screen.x = 0;
    var2.black_screen.y = 0;
    var2.black_screen setshader("black", 640, 480);
    var2.black_screen.alignx = "left";
    var2.black_screen.aligny = "top";
    var2.black_screen.sort = 1;
    var2.black_screen.horzalign = "fullscreen";
    var2.black_screen.vertalign = "fullscreen";
    var2.black_screen.foreground = 1;
  }

  var2.black_screen.alpha = 0;

  if(istrue(var1)) {
    var2 waittill("infinite");
  }

  var2.black_screen fadeovertime(var0);
  var2.black_screen.alpha = 1;
  wait var0;

  if(isDefined(var2.black_screen)) {
    var2.black_screen destroy();
    return;
  }
}

function watch_for_objective_failure(var0) {
  level endon("breached_exit");
  level waittill(var0 + "_timer_complete");

  if(!istrue(level.ref_13844)) {
    thread ref_123e2();
    scripts\cp\cp_objectives::ref_12868(var0);
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    return;
  }
}

function record_teleport_data_and_teleport(var0, var1) {
  if(istrue(var1)) {
    var2 = [(16424, -10046.4, 16000), (16484, -10046.4, 32000), (16384, -10046.4, 32000), (16534, -10046.4, 32000)];
    var0 shellshock("flashbang_mp", 0.5);
    waitframe();
    var3 = scripts\engine\utility::random(var2);
    var0 setplayerangles((0, -45.0869, 0));
    var0 setOrigin(var3, 1);
  } else {
    var4 = getEnt("c130_teleport_ground", "targetname");
    var5 = level.c130.air_reference;
    var6 = var0.origin - var4.origin;
    var7 = rotatevectorinverted(var6, var4.angles);
    var8 = var0.angles - var4.angles;
    var9 = rotatevector(var7, var5.angles);
    waitframe();
    var0 setOrigin(var5.origin + var9);
    var0 setplayerangles(var5.angles + var8);
  }

  var0 visionsetnakedforplayer("mp_donetsk");
  var0 notify("switched_from_core");
  var0.weaponlist = var0 getweaponslistprimaries();
  var0.primaryweaponobj = var0.weaponlist[0];
  var0.secondaryweaponobj = var0.weaponlist[1];
  var0.binc130 = undefined;
  var0 setclientomnvar("ui_hide_bigmap", 0);
  playFX(level._effect["breach_scrn_fx"], var0 getEye());
  waitframe();
  thread parachute();
}

function start_parachute_sequence() {
  self notify("start_parachute_sequence");
  self endon("start_parachute_sequence");
  var0 = 1200;
  var1 = (0, 0, 0);
  var2 = anglesToForward(var1) * var0 * -1;

  for(;;) {
    var3 = self getvelocity();

    if(!isDefined(level.c130)) {
      break;
    }

    if(istrue(self isonground() || self istouching(level.c130))) {
      waitframe();
      continue;
    }

    if(istrue(self.inlaststand)) {
      break;
    }

    if(var3[2] < -300) {
      break;
    }

    waitframe();
  }

  thread parachute();
}

function parachute() {
  var0 = self getplayerangles();
  self unlink();
  self setplayerangles(var0);
  self.weaponlist = self.primaryweapons;
  self.primaryweaponobj = self.weaponlist[0];
  self.secondaryweaponobj = self.weaponlist[1];
  thread scripts\cp_mp\parachute::startfreefall(1, 0);
  self weaponswitchbuttonPressed();
  self skydive_cutautodeployoff();

  foreach(var2 in level.players) {
    var2.no_outline = 0;
    var2.no_team_outlines = 0;
    var2 scripts\cp\utility::_unsetperk("specialty_spygame");
    var2 scripts\cp\utility::_unsetperk("specialty_coldblooded");
    var2 scripts\cp\utility::_unsetperk("specialty_noscopeoutline");
    var2 scripts\cp\utility::_unsetperk("specialty_heartbreaker");
  }
}

function spawn_lz_spawners_on_landing(var0) {
  var0 endon("disconnect");
  var0 notify("spawn_lz_spawners_on_landing");
  var0 endon("spawn_lz_spawners_on_landing");
  var0 scripts\engine\utility::ref_143a6("parachute_complete", "parachute_landed", "skydive_end");

  if(level.landed_players.size < 1) {
    level notify("end_wave_fubar_spawners");
    waitframe();
  }

  level.landed_players = scripts\engine\utility::array_add(level.landed_players, var0);
}

function end_exfil_plane(var0, var1) {
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function init_land_at_lz(var0, var1) {
  level.initlocationcircle = "land_at_lz";
  level.initlethalmaxoffsetmap = "land_at_lz";
  scripts\cp\cp_modular_spawning::stop_all_groups();
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  var0.lz_struct = scripts\engine\utility::random(scripts\engine\utility::getStructArray("lz_point", "script_noteworthy"));
  objective_setlocation(var0.objectiveindex, 0, var0.lz_struct.origin);
  objective_state(var0.objectiveindex, "current");
  brjugg_oncrateactivate();
  scripts\cp\utility::skydivestreamhintdvars("plane_hijack_boneyard");
  thread ref_135c3();
}

function ref_135c3() {
  var0 = scripts\engine\utility::getStructArray("rpg_interaction", "script_noteworthy");
  var1 = ["iw8_la_rpapa7_mp", "iw8_la_gromeo_mp", "iw8_la_kgolf_mp", "iw8_la_mike32"];

  foreach(var3 in var0) {
    var3.angles = (0, 0, 0);
    var4 = scripts\cp\cp_weapon::spawn_script_weapon(scripts\engine\utility::random(var1), [], var3.origin + (0, 0, 64), var3.angles);
    var4 thread scripts\cp\cp_weapon::watchweaponpickup();
  }
}

function start_land_at_lz(var0, var1) {
  setDvar("scr_pause_crate_drops", 0);
  thread ref_123fb();
  level thread scripts\cp\utility::ref_123fe("");
  thread ref_1446d(level, scripts\engine\utility::getStruct("exfil_location", "targetname").origin);

  foreach(var3 in level.littlebirds) {
    var4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var3.vehiclename);

    if(isDefined(var4.destroycallback)) {
      var3 thread[[var4.destroycallback]]();
    }
  }

  thread playericontriggerexit();
  thread start_exfil_spawn_sequence();
  ref_14375(var0, 3333);

  foreach(var7 in level.players) {
    var7 vehiclepinonminimap(0);
    var7 scripts\cp\utility::brjugg_setconfig(0);
    var7 scripts\cp\utility::hideminimap(1);

    if(isDefined(level.nuclear_core_carrier)) {
      if(var7 == level.nuclear_core_carrier) {
        if(!isDefined(var7.headicon)) {
          var7.headicon = var7 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "cp_tac_hud_icon_nuke", 30, 1, 29000, 29000, undefined, 1, 0, undefined, 1);
        } else {
          scripts\cp_mp\entityheadicons::ref_1315d(level.nuclear_core_carrier.headicon, var7);
        }

        continue;
      }

      scripts\cp_mp\entityheadicons::ref_1315d(level.nuclear_core_carrier.headicon, var7);
    }
  }

  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("hijack_3");
}

function playericontriggerexit() {
  wait 5;

  foreach(var1 in level.players) {
    if(istrue(var1.inlaststand)) {
      var1 notify("ended_blackout");
      var1.binc130 = undefined;
      var1 notify("auto_respawn");
    }
  }

  level notify("auto_respawn");
}

function ref_123fb() {
  while(istrue(level.dialogue_playing)) {
    wait 1;
  }

  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_plane_final_stand_10", 10);
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_final_stand_20", 1);
}

function start_exfil_after_timeout(var0, var1) {
  var2 = var0;
  thread scripts\cp\utility::objective_update(var1.ref, var2, int(var2 / 2), int(var2 / 3), 1);
  objective_setlabel(var1.objectiveindex, &"CP_FUBAR/EXTRACT_LZ");
  objective_setdescription(var1.objectiveindex, &"CP_FUBAR/EXTRACT_LZ");
  objective_setlocation(var1.objectiveindex, 0, scripts\engine\utility::getStruct("exfil_location", "targetname").origin);
  objective_setshowdistance(var1.objectiveindex, 1);
  level waittill(var1.ref + "_timer_complete");
  objective_unsetlocation(var1.objectiveindex, 0);
  thread listen_for_exfil_heli_ready_to_land(level);
  level notify("call_exfil", var1.lz_struct.origin, 1);
}

function listen_for_exfil_heli_ready_to_land(var0) {
  while(!isDefined(level.exfil_heli)) {
    wait 0.1;
  }

  level.exfil_heli waittill("goal");
  level notify("end_current_nags");
  thread ref_12403(level, ["dx_cps_lass_plane_exfil_land_nag_10", "dx_cps_lass_plane_exfil_land_nag_20"]);
  level notify("successful exfil");
}

function ref_14375(var0, var1) {
  for(;;) {
    if(!isDefined(level.nuclear_core_carrier)) {
      waitframe();
      continue;
    }

    if(distance(level.nuclear_core_carrier.origin, var0.lz_struct.origin) <= var1) {
      break;
    }

    waitframe();
  }
}

function ref_14376(var0, var1) {
  for(;;) {
    var2 = 0;

    foreach(var4 in level.players) {
      if(!var4 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(distance2dsquared(var4.origin, var0.lz_struct.origin) <= squared(var1)) {
        var2 = 1;
        break;
      }
    }

    if(var2) {
      break;
    }

    if(isDefined(level.helis) && level.helis.size == 0) {
      break;
    }

    wait 0.5;
  }
}

function waitforallplayersnearlz(var0, var1) {
  var2 = 0;

  while(!var2) {
    var2 = 1;

    foreach(var4 in level.players) {
      if(distance(var4.origin, var0.lz_struct.origin) > var1) {
        var2 = 0;
        continue;
      }

      var2 = 1;
    }

    wait 0.5;
  }
}

function end_land_at_lz(var0, var1) {
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function debuglandatlz(var0) {
  scripts\engine\utility::flag_set("cp_plane_hijack_cs");
  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "lz_point", 1);
  scripts\mp\playeractions::registeractionset("nuke_core", ["offhand_weapons", "weapon_switch", "gesture", "ads", "reload", "autoreload", "sprint", "crouch", "prone", "fire", "melee", "mantle"]);
  wait 15;

  foreach(var2 in level.players) {
    thread players_waittill_loadout_given_parachute(var2);
  }

  var4 = scripts\engine\utility::random(level.players);
  thread give_loadout_and_core();
}

function give_loadout_and_core() {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  thread give_nuclear_core();
}

function players_waittill_loadout_given_parachute(var0) {
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  var1 = scripts\engine\utility::random(scripts\engine\utility::getStructArray("lz_point", "script_noteworthy"));
  var2 = getrandomnavpoint(var1.origin, 5000);
  var3 = self;
  wait 5;
  var3 setOrigin(var2 + (0, 0, 16000), 1);
  var3 thread scripts\cp_mp\parachute::startfreefall(1, 0);

  if(!isDefined(level.called_wave_spawning)) {
    level.called_wave_spawning = 1;
    return;
  }
}

function players_waittill_loadout_given() {
  self waittill("loadout_given");
  level.safe_to_start_objective = 1;
}

function stealth_init() {
  scripts\cp\coop_stealth::register_stealth_state_funcs();
}

function jugg_death_func() {
  var0 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self) {
    level.ai_going_to_alarm = undefined;
  }

  var0 scripts\cp\coop_stealth::leave_corpse_for_others_to_see();
  var0 scripts\cp\coop_stealth::delete_stealth_meter(var0);
  var0 scripts\cp\coop_stealth::delete_combat_icon(var0);
  var0.juggernautdisablemovebehavior = undefined;
  var0.juggernautforcewalk = undefined;
}

function soldier_enemy_death_func() {
  var0 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self) {
    level.ai_going_to_alarm = undefined;
  }

  var0 scripts\cp\coop_stealth::leave_corpse_for_others_to_see();
  var0 scripts\cp\coop_stealth::delete_stealth_meter(var0);
  var0 scripts\cp\coop_stealth::delete_combat_icon(var0);
}

function jugg_enemy_watcher(var0) {
  var1 = self;

  if(istrue(level.global_stealth_broken)) {
    thread jugg_death_watcher_internal(var1);
    thread jugg_damage_watcher_internal(var1);
    return;
  }

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self) {
    level.ai_going_to_alarm = undefined;
  }

  var1.sightmaxdistance = 2200;
  thread jugg_death_watcher_internal(var1);
  thread jugg_damage_watcher_internal(var1);
  var1 thread scripts\cp\coop_stealth::run_common_functions(var1, 0, 0);
}

function ref_13f60() {
  self endon("death");
  level waittill("weapons_free");
  ref_12bf6();
}

function sniper_enemy_watcher(var0) {
  var1 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self) {
    level.ai_going_to_alarm = undefined;
  }

  var1.sightmaxdistance = 2700;
  var1 thread scripts\cp\coop_stealth::run_common_functions(var1, 0, 0, 70, 250000);
}

function standard_soldier_watcher(var0) {
  var1 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self) {
    level.ai_going_to_alarm = undefined;
  }

  if(istrue(level.global_stealth_broken)) {
    var1.script_radius = 2048;
    return;
  }

  var1.sightmaxdistance = 2200;
  var1 thread scripts\cp\coop_stealth::run_common_functions(var1, 1, 1, 60, 250000);
}

function players_reached_airport() {
  if(istrue(level.global_stealth_broken)) {
    return;
  }

  if(!istrue(level.global_stealth_broken)) {
    scripts\cp\cp_modular_spawning::stop_all_groups();
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("hack_airport");
}

function plane_patrol_watcher(var0) {
  var1 = self;
  var1.sightmaxdistance = 1100;
  var1 thread scripts\cp\coop_stealth::run_common_functions(var1, 1, 1, 60, 110889);
}

function init_destroy_c130(var0, var1) {
  if(level.players_in_c130 != level.players.size) {
    foreach(var3 in level.players) {
      thread screen_fade_to_black(var3, 3);
    }

    thread ref_123e2();
    scripts\cp\cp_objectives::ref_12868("infil_plane");
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    return;
  }
}

function start_destroy_c130(var0, var1) {
  waitforc130destroyed();
  scripts\cp\cp_objectives::overridenextstep(var0, "land_at_lz");
}

function end_destroy_c130(var0, var1) {
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function debugstartdestroyc130(var0) {}

function waitforc130destroyed() {
  level.c130 setCanDamage(1);

  foreach(var1 in level.c130.body) {
    var1 setCanDamage(1);
    var1.health = 200 * level.players.size;
    var1.maxhealth = 200 * level.players.size;
    thread damage_watcher_for_c130();
  }

  foreach(var1 in level.c130_parts) {
    var1 setCanDamage(1);
    var1.health = 200 * level.players.size;
    var1.maxhealth = 200 * level.players.size;
    thread damage_watcher_for_c130();
  }

  foreach(var1 in level.exit_parts) {
    var1 setCanDamage(1);
    var1.health = 200 * level.players.size;
    var1.maxhealth = 200 * level.players.size;
    thread damage_watcher_for_c130();
  }

  level.c130.upper_door setCanDamage(1);
  level.c130.upper_door.health = 200 * level.players.size;
  level.c130.upper_door.maxhealth = 200 * level.players.size;
  thread damage_watcher_for_c130();
  level.c130.lower_door setCanDamage(1);
  level.c130.lower_door.health = 200 * level.players.size;
  level.c130.lower_door.maxhealth = 200 * level.players.size;
  thread damage_watcher_for_c130();
  level.c130 waittill("death");
}

function damage_watcher_for_c130() {
  self notify("damage_watcher_for_c130");
  self endon("damage_watcher_for_c130");
  self endon("stop_damage_watcher");
  self.time_hit = gettime();

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);

    if(!isPlayer(var1)) {
      continue;
    }

    if(gettime() > self.time_hit) {
      if(self == level.c130) {
        playFX(level._effect["plane_explosion"], var3);
      }

      if(self.health - var0 <= 0) {
        thread delay_plane_explosion();
        level.c130 notify("stop_damage_watcher");
      }

      level.c130.health -= var0;
      var1 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
      self.time_hit = gettime() + 200;
      continue;
    }

    var1 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("hitjuggernaut");
    self.health += var0;
  }
}

function c130_crash_sequence(var0) {
  var0 endon("death");
  var1 = scripts\engine\utility::random(scripts\engine\utility::getStructArray("c130_crash_site", "script_noteworthy")).origin;
  var2 = vectorNormalize(anglesToForward(var0.angles));
  var3 = vectorNormalize(var1 - var0.origin);
  var4 = vectortoangles(var3);
  var2 = anglesToForward(vectortoangles(var3));
  var0 rotateTo(vectortoangles(var2), 1);
  var5 = anglelerpquatfrac(var0.angles, var4, 1);
  var6 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var7 = (0, 0, 0);
  var8 = (100, 30, -360);
  var9 = 15;
  var10 = 10;
  var11 = 0;
  thread kill_all_c130_links();

  while(var10 > 0) {
    var12 = var7 * level.framedurationseconds;
    var13 = var0.origin + var12;
    var14 = var13 + var2 * var9;
    var0 moveTo(var14, level.framedurationseconds, level.framedurationseconds);
    var11 -= -0.5;
    var15 = clamp(var11, -70, 0);

    if(var15 <= -70) {
      var0 rotatepitch(-0.5, level.framedurationseconds);
    }

    var10 -= level.framedurationseconds;
    var9 += var9 * level.framedurationseconds;

    if(var9 >= 150) {
      var9 = 150;
    }

    var7 -= (0, 0, 1);

    if(var7[2] <= -50) {
      var7 = (0, 0, -50);
    }

    waitframe();
  }

  LOC_0000017d:
    playFX(level._effect["plane_explosion"], level.c130.origin);
  var2 = vectorNormalize(anglesToForward(var0.angles)) * 1000;
  var12 = var7 * 2;
  var13 = var0.origin + var12;
  var9 = 10000;
  var14 = var13 + var2 * var9;
  var0 moveTo(var14, 4);
  playFX(level._effect["plane_explosion"], level.c130.origin);
  var4 = vectortoangles(var2);
  var0 rotateTo(var0.angles, 1);
  wait 2;
  playFX(level._effect["plane_explosion"], level.c130.origin);
  level.c130 delete();
}

function kill_all_c130_links() {
  level.c130 endon("death");

  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_hide_bigmap", 0);
    var1.binc130 = undefined;
    var1 vehiclepinonminimap(0);
  }

  stopFXOnTag(level._effect["plane_explosion"], level.c130, "tag_origin");
  level.c130 playsoundonmovingent("scn_cp_plane_hijack_c130_expl_tonal");
  var3 = level.c130 getlinkedchildren(1);

  if(isDefined(var3)) {
    foreach(var6, var5 in var3) {
      if(isPlayer(var5)) {
        continue;
      }

      if(isDefined(var5)) {
        var5 delete();
      }
    }
  }

  level.c130 delete();

  if(true) {
    return;
  }

  level.c130.plane_seats = level.c130_seat_refs;

  foreach(var6, var8 in level.c130.body) {
    var8 delete();
  }

  if(isDefined(level.c130_parts)) {
    foreach(var8 in level.c130_parts) {
      if(isDefined(var8) && var8 != level.c130) {
        var8 delete();
      }
    }
  }

  if(isDefined(level.c130.air_reference)) {
    level.c130.air_reference delete();
  }

  wait 1;

  if(isDefined(level.c130.plane_seats)) {
    foreach(var8 in level.c130.plane_seats) {
      var8 delete();
    }
  }

  if(isDefined(level.exit_parts)) {
    foreach(var8 in level.exit_parts) {
      var8 delete();
    }
  }

  var13 = getEnt("rear_door_down_model", "targetname");

  if(isDefined(var13)) {
    var13 delete();
  }

  var14 = getEnt("rear_door_down_geo", "targetname");

  if(isDefined(var14)) {
    var14 delete();
  }

  var15 = getEnt("rear_door_up_model", "targetname");

  if(isDefined(var15)) {
    var15 delete();
  }

  var16 = getEnt("rear_door_up_geo", "targetname");

  if(isDefined(var16)) {
    var16 delete();
  }

  var17 = getEntArray("air_door", "targetname");

  if(isDefined(var17)) {
    foreach(var8 in var17) {
      if(isDefined(var8)) {
        var8 delete();
      }
    }
  }

  if(isDefined(level.c130_seat_refs)) {
    foreach(var8 in level.c130_seat_refs) {
      if(isDefined(var8)) {
        var8 delete();
      }
    }
  }

  var22 = getEnt("air_door", "targetname");

  if(isDefined(var22)) {
    var22 delete();
  }

  if(isDefined(level.c130.upper_door)) {
    level.c130.upper_door delete();
  }

  if(isDefined(level.c130.lower_door)) {
    level.c130.lower_door delete();
  }

  if(isDefined(level.c130.lower_door_geo)) {
    level.c130.lower_door_geo delete();
  }

  if(isDefined(level.c130.upper_door_geo)) {
    level.c130.upper_door_geo delete();
  }

  var23 = getEntArray("breach_door_escape", "targetname");

  foreach(var25 in var23) {
    if(isDefined(var25)) {
      var25 delete();
    }
  }

  foreach(var8 in level.mhc_escape_ents_array) {
    if(isDefined(var8)) {
      var8 delete();
    }
  }

  level.c130 delete();
}

function delay_plane_explosion() {
  c130_final_crash_sequence(level.c130);
}

function use_garage() {
  self endon("death");
  self notify("use_garage");
  self endon("use_garage");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(level.garage_door.current_state == 666) {
      continue;
    }

    if(!istrue(level.can_open_door)) {
      continue;
    }

    operate_garage(var0);
  }
}

function any_ai_around_player(var0) {
  var1 = 0;
  var2 = 10;
  var3 = 2500;
  var4 = gettime();

  foreach(var6 in getaiarray("axis")) {
    if(distancesquared(var0.origin, var6.origin) <= 100000000) {
      if(var6 seerecently(var0, var2)) {
        var6.killofftime = var4 + var3;
        var1 = 1;
        break;
      }

      if(scripts\engine\utility::can_trace_to_ai(var0 getEye(), var6, level.characters)) {
        var6.killofftime = var4 + var3;
        var1 = 1;
        break;
      }
    }
  }

  if(istrue(var1)) {
    return 1;
  }

  return 0;
}

function pulse_ai() {
  foreach(var1 in getaiarray("axis")) {
    thread wave_outline(var1);
  }
}

function wave_outline(var0) {
  var1 = scripts\cp\cp_outline_utility::outlineenableforall(var0, "red", 0, 1, 0, "equipment");
  wait 2.5;
  scripts\cp\cp_outline_utility::outlinedisable(var1, var0);
}

function operate_garage(var0) {
  var0 endon("disconnect");

  if(level.garage_door.current_state == 0) {
    level.garage_door.current_state = 666;
    level.garage_door setscriptablepartstate("base", "opening");
    wait getanimlength(level.scr_anim["garage_door"]["garage_open"]);
    level.garage_door.current_state = 1;
    level.garage_door.door_interaction setHintString(&"CP_FUBAR/CLOSE_GARAGE");
    level.show_garage_waypoint = 1;
    level.garage_door.door_interaction delete();
    return;
  }
}

function lower_level_jugg_properties(var0) {
  var1 = self;
  thread jugg_death_watcher_internal(var1);
  thread jugg_damage_watcher_internal(var1);
}

function jugg_death_watcher_internal(var0) {
  var0 waittill("death");
  var0.juggernautforcewalk = undefined;
}

function jugg_damage_watcher_internal(var0) {
  var0 endon("death");
  var0 waittill("damage");
}

function start_tunnel_sequence() {
  if(istrue(level.global_stealth_broken)) {
    return;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("plane_patrol");
  scripts\cp\cp_modular_spawning::run_spawn_module("tunnel_spawns");
}

function spawn_fake_ai_vehicles() {}

function spawnapc() {
  level.convoy_speed_override = 12;
  var0 = scripts\engine\utility::getStruct("vehicle_start", "targetname");
  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.owner = level.players[0];
  var1.disableusabilityatspawn = 1;
  var1.team = "axis";
  var1.cannotbesuspended = 1;
  var2 = scripts\cp_mp\vehicles\apc_rus::apc_rus_create(var1);
  wait 2;
  var3 = var2;
  var3 setCanDamage(1);
  var4 = var0;
  var3.pathing_array = [];
  var3.pathing_array[var3.pathing_array.size] = var4;
  var4.pathing_index = var3.pathing_array.size;

  while(isDefined(var4.target)) {
    var4 = scripts\engine\utility::getStruct(var4.target, "targetname");
    var4.pathing_index = var3.pathing_array.size;
    var3.pathing_array[var3.pathing_array.size] = var4;
  }

  if(var3.pathing_array.size > 27) {
    var3 scripts\cp\cp_vehicles::split_large_pathing_array();
  }

  var3.cp_speed = 50;
  var3 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var3.pathing_array);
  var3.health = 50000;
  var3.angles = var0.angles;
  thread watchforvehiclesuspendedstate(var3);
  thread watchforplayersgettingclose();
  thread watchforapcdeath();
  thread watchforpayloadongoal(var3);
}

function watchforplayersgettingclose() {}

function watchforvehiclesuspendedstate(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("payload_reached_goal");

  for(;;) {
    if(var0 issuspendedvehicle()) {
      var0 wakeupvehicle();
    }

    wait 0.1;
  }
}

function watchforapcdeath() {
  level endon("game_ended");
  self waittill("death");
  var0 = spawn("script_model", self.origin);
  var0.angles = self.angles;
  var0 setModel("veh8_mil_lnd_stango_static_dst");
}

function watchforpayloadongoal(var0) {
  level endon("game_ended");
  var1 = scripts\engine\utility::getStruct(var0, "script_noteworthy").origin;

  while(distance(self.origin, var1) > 100) {
    wait 0.5;
  }

  waitframe();
  thread apcstop(self);
}

function apcstop(var0) {
  if(var0 issuspendedvehicle()) {
    var0 wakeupvehicle();
  }

  var0 vehicle_setspeedimmediate(0, 0.002, 0.002);
  var1 = "smoke_grenade_mp";

  foreach(var3 in scripts\engine\utility::getStruct("smoked_tunnel_spawners", "targetname")) {
    magicgrenademanual(var1, var3.origin, (0, 0, 5), 0.05);
  }

  scripts\engine\utility::delaythread(1, &scripts\cp\cp_modular_spawning::run_spawn_module, "smoked_tunnel_spawners");
}

function apcstart(var0) {
  if(var0 issuspendedvehicle()) {
    var0 wakeupvehicle();
  }

  var0 resumespeed(0.002);
}

function cansee_detailed(var0, var1, var2) {
  var3 = distance(var0.origin, var1.origin);
  var4 = var3 <= var2;
  var5 = var0 getEye();
  var6 = var1 getEye();
  var7 = anglesToForward(var0.angles);
  var8 = vectorNormalize(var6 - var5);
  var9 = vectordot(var8, var7);

  if(var4) {
    var10 = 0.34202;
  } else {
    var10 = 0.819152;
  }

  var11 = var10 >= var10;

  if(!var11) {
    var12 = 0;
    return var12;
  }

  var12 = var2 cansee(var3) && var2 canshootenemy();

  if(var12) {
    var13 = angleclamp180(vectortopitch(var3.origin - var2.origin));

    if(var13 < var2.upaimlimit || var13 > var2.downaimlimit) {
      var12 = 0;
    }
  }

  var14 = sighttracepassed(var7, var8, 0, var3, 1);

  if(!var14) {
    var12 = 0;
    return var12;
  }

  return var12;
}

function c130_final_crash_sequence(var0) {
  var0 endon("death");
  var0 unlink();
  var0 waittill("players_viewing_crash");
  playFXOnTag(level._effect["plane_explosion"], level.c130, "tag_origin");
  level.c130 playsoundonmovingent("scn_cp_plane_hijack_c130_expl_tonal");

  if(getdvarint("scr_phj_ship_exp", 0) != 0) {
    wait 1.5;
  } else {
    wait 2;
  }

  level.c130 moveTo(level.c130.mp_crash2, 560);
  wait 120;
  thread kill_all_c130_links();
}

function throw_players_out() {
  foreach(var1 in level.players) {
    if(istrue(var1.binc130)) {}
  }
}

function start_exfil_spawn_sequence() {
  scripts\engine\utility::flag_init("boss_heli");
  thread spawn_enemy_chopper();
}

function init_holdout(var0, var1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  var0.lz_struct = scripts\engine\utility::getStruct("exfil_location", "targetname");
}

function start_holdout(var0, var1) {
  if(level.helis.size > 0) {} else {
    objective_setlabel(var0.objectiveindex, &"CP_FUBAR/EXFIL_LABEL");
    objective_setdescription(var0.objectiveindex, &"CP_FUBAR/EXFIL_LABEL");
    objective_setlocation(var0.objectiveindex, 0, var0.lz_struct.origin);
    objective_state(var0.objectiveindex, "current");
    objective_setshowdistance(var0.objectiveindex, 1);
  }

  ref_14376(var0, 7000);
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("hijack_4");
}

function end_holdout(var0, var1) {}

function debugholdout(var0) {
  scripts\engine\utility::flag_set("cp_plane_hijack_cs");
  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "lz_point", 1);

  foreach(var2 in level.players) {
    thread players_waittill_loadout_given_parachute(var2);
  }
}

function spawn_enemy_chopper() {
  if(scripts\engine\utility::flag_exist("boss_heli")) {
    scripts\engine\utility::flag_set("boss_heli");
  }

  level.helis = [];
  level.skip_basic_combat = 0;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_MILBASE_DIALOGUE/HELI_INBOUND");
  var0 = scripts\engine\utility::getStruct("boss_heli_spawn", "targetname");
  var0.classname_mp = "script_vehicle_apache_east";
  var0.script_modelname = "veh8_mil_air_ahotel64_ks_east_mp";
  var0.vehicletype = "veh_apache_cp";

  for(var1 = 0; var1 < 1; var1++) {
    level.helis[var1] = ref_1356a(var0, level.skip_basic_combat);
    thread watch_for_death(level.helis[var1]);
    wait 10;
  }
}

function watch_for_death(var0) {
  self waittill("vehicle_deathComplete");

  if(scripts\engine\utility::array_contains(level.helis, self)) {
    level.helis = scripts\engine\utility::array_remove(level.helis, self);
  }

  level.skip_basic_combat++;

  if(level.skip_basic_combat >= 1) {
    level.skip_basic_combat = 0;
    level notify("both_bosses_dead");
    thread scripts\cp\utility::objective_update("extract_lz", undefined, undefined, undefined, 1, undefined, 1);
    thread listen_for_exfil_heli_ready_to_land();
    level notify("call_exfil", scripts\engine\utility::getStructArray("lz_point", "script_noteworthy")[0].origin, 1);
    return;
  }
}

function ref_1356a(var0, var1) {
  var2 = undefined;

  if(var1 != 0) {
    var2 = "heli_search_alt";
  }

  var3 = scripts\common\vehicle::vehicle_spawn(var0);
  var3.death_fx_on_self = 1;
  var3 scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
  thread setup_pilot(var3);
  var3.isheli = 1;
  var3.health = 50000;
  var3.maxhealth = 50000;
  var3 = ref_13f91(var3);
  var3.team = "axis";
  var3 setvehicleteam(var3.team);
  var3 thread scripts\cp\cp_vehicles::is_done_speaking();
  level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(var3);
  var3 thread scripts\cp\cp_vehicles::smoke_wheelson_chosen_spawn();
  var3.headicon = deleteheadicon(var3);
  setheadiconfriendlyimage(var3.headicon, "hud_icon_head_equipment_enemy");
  setheadiconsnaptoedges(var3.headicon, 12000);
  setheadiconmaxdistance(var3.headicon, 1500);
  addclienttoheadiconmask(var3.headicon, 10);
  setheadicondrawthroughgeo(var3.headicon, 1);
  var3 setmaxpitchroll(15, 15);
  var3.health_remaining = 2500;

  if(var1 != 0) {
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(var3, undefined, "heli_search_alt");
  } else {
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(var3);
  }

  var3 sethoverparams(25, 15, 10);
  return var3;
}

function ref_13f91(var0) {
  var1 = 1;

  if(scripts\cp\cp_relics::calldropbag()) {
    var1 = 5;
  }

  var0.health *= var1;
  var0.maxhealth *= var1;
  return var0;
}

function setup_pilot(var0) {
  var1 = "tag_pilot";

  if(!self tagexists(var1)) {
    var1 = "tag_pilot1";
  }

  self.pilot = spawn("script_model", self gettagorigin(var1));
  self.pilot setModel("aq_pilot_fullbody_1");
  self.pilot linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  self.pilot scriptmodelplayanimdeltamotion("vh_mindia8_pilot_idle");

  if(istrue(var0)) {
    thread ref_14455();
    thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor();
    return;
  }
}

function kill_chopper_hint(var0) {
  var0 endon("death");

  for(;;) {
    level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_FUBAR/KILL_BOSS_HINT");
    wait 30;
  }
}

function ref_14455() {
  self endon("kill_this_thread_for_heli");
  self waittill("vehicle_deathComplete", var0, var1);

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
    self.headicon = undefined;
  }

  playFX(level._effect["vfx_blima_explosion"], var0 + (0, 0, -100));
  playsoundatpos(var0, "cp_br_syrk_chopper_crash");
  self stoploopsound();
  wait 0.05;
  earthquake(0.45, 3, var0 + (0, 0, -100), 1024);
  wait 0.05;
  radiusdamage(var0 + (0, 0, -100), 1024, 500, 50);
  wait 0.05;

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function init_extract_lz(var0, var1) {
  thread ref_13561();
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  var2 = 0;
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("exfil_location", var2, &intro_safehouse_edit_loadout);

  if(level.helis.size > 0) {
    thread scripts\cp\utility::objective_update("shoot_boss", undefined, undefined, undefined, 1, undefined, 1);
  } else {
    thread scripts\cp\utility::objective_update("extract_lz", undefined, undefined, undefined, 1, undefined, 1);
  }

  thread ref_14456();
  scripts\cp\cp_objectives::ref_1317e(var0, [scripts\engine\utility::getStruct("exfil_location", "targetname").origin]);
  objective_state(var0.objectiveindex, "current");
  var0.lz_struct = scripts\engine\utility::random(scripts\engine\utility::getStructArray("lz_point", "script_noteworthy"));
}

function ref_14456() {
  level endon("both_bosses_dead");

  for(;;) {
    if(level.helis.size > 0) {
      waitframe();
      continue;
    }

    level notify("call_exfil", scripts\engine\utility::getStructArray("lz_point", "script_noteworthy")[0].origin, 1);
    level notify("both_bosses_dead");
  }
}

function ref_1446d(var0, var1) {
  level endon("game_ended");
  jumpiftrue(isDefined(var1)) LOC_00000014;
  var1 = 4096;

  for(;;) {
    var2 = 0;

    foreach(var4 in level.players) {
      if(!var4 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(distance2dsquared(var4.origin, var0) <= squared(var1)) {
        var2 = 1;
        break;
      }
    }

    if(var2) {
      break;
    }

    wait 0.5;
  }

  thread ref_13561();
}

function ref_13561() {
  if(istrue(level.onenterbattlechatter)) {
    return;
  }

  level.onenterbattlechatter = 1;
  scripts\cp\cp_modular_spawning::run_spawn_module("exfil_snipers");
  scripts\cp\cp_modular_spawning::run_spawn_module("exfil_rpgs");
  scripts\cp\cp_modular_spawning::run_spawn_module("exfil_lmgs");
  wait 30;
  thread spawn_waves_after_a_delay(level, 1, undefined);
}

function ref_14453() {
  level endon("both_bosses_dead");

  for(;;) {
    if(level.helis.size > 0) {
      waitframe();
      continue;
    }

    level notify("both_bosses_dead");
  }
}

function playerhealthomnvarwatcher() {
  if(level.helis.size == 0) {
    thread listen_for_exfil_heli_ready_to_land();
    level notify("call_exfil", scripts\engine\utility::getStructArray("lz_point", "script_noteworthy")[0].origin, 1);
    return;
  }
}

function start_extract_lz(var0, var1) {
  scripts\engine\utility::flag_init("endgame_delay");
  thread playerhealthomnvarwatcher();
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_endmission");

  foreach(var3 in level.players) {
    var3 setsoundsubmix("cp_matchend_music", 5);
  }

  thread ref_12403(level, ["dx_cps_lass_plane_exfil_approach_10", "dx_cps_lass_plane_exfil_approach_20", "dx_cps_lass_plane_exfil_approach_30"]);
  level waittill("ready_to_exfil");
  thread ref_130a8(level.heli_trip_vehicle);
  level notify("end_current_nags");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_plane_outro_10");

  foreach(var3 in level.players) {
    if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == var3) {
      var3 scripts\cp\utility::hint_prompt("drop_core", 0);
      var3 notify("end_nuke_threads");
      var6 = var3 getcurrentweapon();
      var3 takeweapon(var6);
    }

    scripts\cp\cp_outofbounds::enableoobimmunity(var3);
    var3 thread scripts\cp_mp\xmike109::screenent_d("crosswind");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var3 thread scripts\cp_mp\xmike109::scriptable_callback("crosswind_mod");
        continue;
      }

      var3 thread scripts\cp_mp\xmike109::scriptable_callback("crosswind_mod_vet");
    }
  }

  scripts\cp\cp_achievement::update_achievement_all_players("ARMED", 1);
  scripts\cp\cp_achievement::update_achievement_all_players("PICKLES", 1);
  level thread scripts\cp\utility::ref_123fe("");
  scripts\engine\utility::flag_set("endgame_delay");
}

function end_extract_lz(var0, var1) {
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function debugextractlz(var0) {
  scripts\engine\utility::flag_set("cp_plane_hijack_cs");
  scripts\engine\utility::flag_wait("cp_plane_hijack_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "lz_point", 1);

  foreach(var2 in level.players) {
    thread players_waittill_loadout_given_parachute(var2);
  }
}

function intro_safehouse_edit_loadout() {
  level endon("game_ended");
  self solid();
  self disconnectPaths();
  startplayerboarding();
}

function startplayerboarding() {
  thread wait_for_all_players_ready(level);
  var0 = self;
  var0.animname = "exfil_chopper";
  var0 scripts\cp\vehicles\cp_heli_trip::init_interactions(&ref_14080);
}

function wait_for_all_players_ready(var0) {
  for(;;) {
    if(scripts\cp\infilexfil\blima_exfil::all_alive_players_in_chopper() && istrue(level.ref_11edb)) {
      var0 notify("all_players_on_board");
      return;
    }

    wait 0.1;
  }
}

function ref_14080(var0, var1) {
  level endon("game_ended");
  var0 endon("heli_taking_off");
  self makeusable();

  for(;;) {
    self waittill("trigger", var2);

    if(!var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!istrue(level.ref_11edb)) {
      if(!isDefined(level.nuclear_core_carrier)) {
        thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_FUBAR/PICK_CORE_WARNING", "allies", 3.75);
        continue;
      } else if(var2 == level.nuclear_core_carrier) {
        var2 takeweapon("iw8_nukecore_mp");

        if(istrue(var2.hasriotshield)) {
          if(isDefined(var2.primaryweaponobj) && var2.primaryweaponobj.basename == "iw8_me_riotshield_mp") {
            if(isDefined(var2.secondaryweaponobj)) {
              var2 switchtoweaponimmediate(var2.secondaryweaponobj);
            } else {
              var3 = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911", [], "none", "none", -1);
              var2 scripts\cp\utility::_giveweapon(var3);
              var2 switchtoweaponimmediate(var3);
            }
          } else if(isDefined(var2.secondaryweaponobj) && var2.secondaryweaponobj.basename == "iw8_me_riotshield_mp") {
            if(isDefined(var2.primaryweaponobj)) {
              var2 switchtoweaponimmediate(var2.primaryweaponobj);
            } else {
              var3 = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911", [], "none", "none", -1);
              var2 scripts\cp\utility::_giveweapon(var3);
              var2 switchtoweaponimmediate(var3);
            }
          }
        } else {
          var4 = var2.default_starting_pistol;

          if(isDefined(var2.primaryweaponobj)) {
            var4 = var2.primaryweaponobj;
          } else if(isDefined(var2.secondaryweaponobj)) {
            var4 = var2.secondaryweaponobj;
          }

          var2 scripts\cp_mp\utility\inventory_utility::_giveweapon(var4, undefined, undefined, 1);
          var2 switchtoweaponimmediate(var4);
        }

        var2 scripts\cp\utility::hint_prompt("drop_core", 0);
        var2 notify("end_nuke_threads");
        level.ref_11edb = 1;
      } else {
        thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_FUBAR/PICK_CORE_WARNING", "allies", 3.75);
        continue;
      }
    }

    self makeunusable();
    var2 thread scripts\cp\vehicles\cp_heli_trip::playerpassengerthink(var1);
    break;
  }
}

function garage_door_anim() {
  while(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    wait 1;
  }

  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getEnt("test_garage_door", "script_noteworthy");
  var1 = spawn("script_model", var0.origin);
  var1 makeusable();
  var1 setHintString(&"CP_FUBAR/OPEN_GARAGE");
  var1 setCursorHint("HINT_BUTTON");
  var1 sethintdisplayrange(128);
  var1 sethintdisplayfov(65);
  var1 setuserange(128);
  var1 setusefov(65);
  var1 sethintonobstruction("show");

  for(;;) {
    var1 waittill("trigger");
    var0 setscriptablepartstate("base", "opening");
    var1 makeunusable();
    wait 10;
    var1.origin += (0, 0, 80);
    var1 dontinterpolate();
    var1 setHintString(&"MP/DOOR_USE_CLOSE");
    var1 makeusable();
    var1 waittill("trigger");
    var0 setscriptablepartstate("base", "closing");
    var1 makeunusable();
    wait 10;
    var1.origin -= (0, 0, 80);
    var1 dontinterpolate();
    var1 setHintString(&"MP/DOOR_USE_OPEN");
    var1 makeusable();
  }
}

function math_pointoncircle(var0, var1) {
  var2 = var0 * cos(var1);
  var3 = var0 * sin(var1);
  return (var2, var3, 0);
}

function math_pointonellipse(var0, var1) {
  var2 = var0 * cos(var1);
  var3 = var0 * sin(var1) * 0.5;
  return (var2, var3, 0);
}

function math_pointonlemniscate(var0, var1) {
  var2 = var0 * sqrt(2) * cos(var1) / (squared(sin(var1)) + 1);
  var3 = var0 * sqrt(2) * cos(var1) * sin(var1) / (squared(sin(var1)) + 1);
  return (var2, var3, 0);
}

function init_recover_nuclear_core(var0, var1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  scripts\mp\playeractions::registeractionset("nuke_core", ["offhand_weapons", "weapon_switch", "gesture", "ads", "reload", "autoreload", "sprint", "crouch", "prone", "fire", "melee", "mantle"]);
  var0.crashed_nuke_interaction = getEnt("nuclear_core_crashed", "targetname");
  objective_onentity(var0.objectiveindex, var0.crashed_nuke_interaction);
  var0.crashed_nuke_interaction.origin += (0, 0, 6669);
  var0.crashed_nuke_interaction physicslaunchserver(var0.crashed_nuke_interaction.origin, (0, 0, -1));
  var2 = var0.crashed_nuke_interaction physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var2, (0, 0, -1));
  var0.crashed_nuke_interaction physics_registerforcollisioncallback();
  thread watchnukeimpact();
  level waittill("interactions_start");

  if(isDefined(var0.crashed_nuke_interaction)) {
    var0.crashed_nuke_interaction setHintString(&"CP_FUBAR/PICKUP_CORE");
    var0.crashed_nuke_interaction sethintdisplayrange(200);
    var0.crashed_nuke_interaction sethintdisplayfov(120);
    var0.crashed_nuke_interaction setusefov(120);
    var0.crashed_nuke_interaction setuserange(72);
    var0.crashed_nuke_interaction sethintonobstruction("show");
    var0.crashed_nuke_interaction sethinticon("splash_icon_nuke");
    var0.crashed_nuke_interaction makeusable();
    thread give_core(var0.crashed_nuke_interaction);
    return;
  }
}

function watchnukeimpact() {
  level endon("endthis");
  var0 = 1;

  for(;;) {
    self waittill("collision", var1, var2, var3, var4, var5, var6, var7, var8);
    var9 = "airdrop_crate_impact";
    var10 = gettime();
    self notify("current_impact_time", var10);

    if(var7 < 100) {} else if(var7 < 200) {} else if(var7 < 300) {} else if(var7 < 400) {} else if(var7 > 400) {}

    if(istrue(var0)) {
      var0 = 0;
    } else {
      self waittill("play_impact_fx");
    }

    playFX(scripts\engine\utility::getfx(var9), var5, var6);
    level notify("interactions_start");
    level notify("endthis");
  }
}

function give_core(var0) {
  var0 endon("delete");

  for(;;) {
    self waittill("trigger", var1);

    if(var1 hasweapon("iw8_lm_dblmg_mp")) {
      var1 thread scripts\cp\utility::hint_prompt("cant_pick_jugg", 1, 2);
      continue;
    }

    if(isDefined(level.nuclear_core)) {
      level.nuclear_core delete();
    }

    level.nuclear_core_carrier = var1;

    if(isDefined(var0)) {
      if(isDefined(var0.headiconid)) {
        var0 thread scripts\cp\utility::ent_deleteheadicon(var0, var0.headiconid);
      }
    }

    var2 = var1 getcurrentweapon();
    var3 = getcompleteweaponname("iw8_nukecore_mp");
    var1 scripts\cp\utility::_giveweapon(var3);
    var1 switchtoweapon(var3);
    var1 scripts\mp\playeractions::allowactionset("nuke_core", 0);
    var1 allowmountside(0);
    var1 allowmounttop(0);
    var1 allowjog(0);
    var1 scripts\cp\respawn\cp_respawn::watchnukeweaponenduse(var3, var2);
    thread watcher_for_core_pickup();
    level notify("collected_core");
    var0 delete();
  }
}

function start_recover_nuclear_core(var0, var1) {
  level waittill("collected_core");
}

function end_recover_nuclear_core(var0, var1) {
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function debugrecover_nuclear_core(var0) {}

function smoke_up_landing_zone_for_enemy_ai(var0) {
  magicgrenademanual("smoke_grenade_mp", var0.origin, (0, 0, 0), 0.3);
}

function spawn_enemy_tanks() {
  wait 15;

  while(!isDefined(level.players) || level.players.size < 1) {
    wait 1;
  }

  scripts\engine\utility::flag_init("remove_tanks");
  var0 = scripts\engine\utility::getStructArray("runway_enemy_tank", "targetname");
  level.altgunnerturret = "sentry_minigun_mp";
  level.enemy_tanks = [];

  foreach(var2 in var0) {
    thread spawn_enemy_tank(level);
  }
}

function spawn_enemy_tank(var0) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.spawnmethod = "game_mode";
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var1);
  var1.owner = level.players[0];
  var1.team = "axis";
  var1.faceawayfromowner = 0;
  var1.cancapture = 0;
  var1.cancaptureimmediately = 0;
  var1.spawnmethod = "place_at_position";
  var1.activateimmediately = 1;
  var1.cantimeout = 0;
  var2 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var1);

  if(!isDefined(var2)) {
    return;
  }

  level.enemy_tanks[level.enemy_tanks.size] = var2;
  thread tank_waittill_death();
  var2 endon("death");
  var2 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var3 = scripts\engine\utility::getStructArray("enemy_tank_path", "targetname");
  var4 = sortbydistance(var3, var2.origin)[0];
  var5 = build_tank_path(var4);
  var6 = build_tank_duration(var4);
  var2 startpathnodes(var5, var6);
  setheadiconsnaptoedges(var2.headicon, 8088);
  var7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var2, "tur_bradley_mp");
  var8 = scripts\cp_mp\vehicles\vehicle::ref_14192(var2, "tur_gun_lighttank_mp");

  for(;;) {
    if(!isDefined(level.players)) {
      wait 1;
      continue;
    }

    if(scripts\engine\utility::flag("remove_tanks")) {
      return;
    }

    var9 = var2 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var9) || !istrue(level.global_stealth_broken)) {
      wait 1;
      continue;
    }

    if(istrue(var9.binvehicle) && isDefined(var9.vehicle)) {
      if(var7 turretcantarget(var9.vehicle.origin + (0, 0, 50))) {
        var7 settargetentity(var9.vehicle);
      }

      if(var8 turretcantarget(var9.vehicle.origin + (0, 0, 50))) {
        var8 settargetentity(var9.vehicle);
      }
    } else {
      var7 settargetentity(var9);
      var8 settargetentity(var9);
    }

    thread tank_shoot_at_target(var2, var8);
    thread tank_shoot_at_target(var2);
    wait randomfloatrange(4, 8);
  }
}

function tank_shoot_at_target(var0, var1) {
  var2 = 1;
  var3 = getcompleteweaponname("tur_bradley_mp");

  if(istrue(var1)) {
    var2 = randomintrange(15, 25);
    var3 = getcompleteweaponname("tur_gun_lighttank_mp");
  }

  var4 = weaponfiretime(var3);

  for(var5 = 0; var5 < var2; var5++) {
    if(scripts\engine\utility::flag("remove_tanks")) {
      return;
    }

    var0 shootturret();
    wait var4;
  }
}

function build_tank_path(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = var2.origin; isDefined(var2) && isDefined(var2.target); var1 = var2.origin) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function build_tank_duration(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = 4; isDefined(var2) && isDefined(var2.target); var1 = 4) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function tank_waittill_death() {
  self waittill("death");
  thread scripts\cp_mp\vehicles\light_tank::light_tank_explode();
  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
}

function syncleadmarkers() {
  level.scr_animtree["breach_player"] = #animtree;
  level.scr_anim["breach_player"]["end_breach"] = % cp_scripted_747_ending_breach_plr;
  level.scr_animname["breach_player"]["end_breach"] = "cp_scripted_747_ending_breach_plr";
  level.scr_eventanim["breach_player"]["end_breach"] = "ending_breach_c4";
  level.scr_animtree["breach_c4"] = #animtree;
  level.scr_model["breach_c4"] = "offhand_wm_c4_cp";
  level.scr_anim["breach_c4"]["end_breach"] = % cp_scripted_747_ending_breach_c4;
  level.scr_animname["breach_c4"]["end_breach"] = "cp_scripted_747_ending_breach_c4";
}

function swivel_dogtag_revive() {
  level.scr_animtree["player_falling"] = #animtree;
  level.scr_anim["player_falling"]["player_1"] = % cp_scripted_747_ending_jump_plr1;
  level.scr_animname["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr1";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr1";
  level.scr_eventanim["player_falling"]["player_1"] = "end_jump_plr1";
  level.scr_anim["player_falling"]["player_2"] = % cp_scripted_747_ending_jump_plr2;
  level.scr_animname["player_falling"]["player_2"] = "cp_scripted_747_ending_jump_plr2";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr2";
  level.scr_eventanim["player_falling"]["player_2"] = "end_jump_plr2";
  level.scr_anim["player_falling"]["player_3"] = % cp_scripted_747_ending_jump_plr3;
  level.scr_animname["player_falling"]["player_3"] = "cp_scripted_747_ending_jump_plr3";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr3";
  level.scr_eventanim["player_falling"]["player_3"] = "end_jump_plr3";
  level.scr_anim["player_falling"]["player_4"] = % cp_scripted_747_ending_jump_plr4;
  level.scr_animname["player_falling"]["player_4"] = "cp_scripted_747_ending_jump_plr4";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_jump_plr4";
  level.scr_eventanim["player_falling"]["player_4"] = "end_jump_plr4";
  level.scr_anim["player_falling"]["player_1_end"] = % cp_scripted_747_ending_exit_plr1;
  level.scr_animname["player_falling"]["player_1_end"] = "cp_scripted_747_ending_exit_plr1";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_exit_plr1";
  level.scr_eventanim["player_falling"]["player_1_end"] = "end_exit_plr1";
  level.scr_anim["player_falling"]["player_2_end"] = % cp_scripted_747_ending_exit_plr2;
  level.scr_animname["player_falling"]["player_2_end"] = "cp_scripted_747_ending_exit_plr2";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_exit_plr2";
  level.scr_eventanim["player_falling"]["player_2_end"] = "end_exit_plr2";
  level.scr_anim["player_falling"]["player_3_end"] = % cp_scripted_747_ending_exit_plr3;
  level.scr_animname["player_falling"]["player_3_end"] = "cp_scripted_747_ending_exit_plr3";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_exit_plr3";
  level.scr_eventanim["player_falling"]["player_3_end"] = "end_exit_plr3";
  level.scr_anim["player_falling"]["player_4_end"] = % cp_scripted_747_ending_exit_plr4;
  level.scr_animname["player_falling"]["player_4_end"] = "cp_scripted_747_ending_exit_plr4";
  level.scr_viewmodelanim["player_falling"]["player_1"] = "cp_scripted_747_ending_exit_plr4";
  level.scr_eventanim["player_falling"]["player_4_end"] = "end_exit_plr4";
}

function ref_123ce(var0) {
  self.scenenode = getEnt("end_breach_sceneNode", "targetname");
  level.ref_13844 = 1;
  var1 = spawn("script_model", self.scenenode.origin);
  var1.angles = self.scenenode.angles;
  var1 setModel("offhand_wm_c4_cp");
  var2 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var0, "breach_player", 1, 1);
  var3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var1, "breach_c4");

  if(istrue(var0.isjuggernaut)) {
    var4 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var2, var3], "end_breach", undefined, undefined, undefined, 0.5, undefined, 1);
  } else {
    var4 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var3, var4], "end_breach", undefined, undefined, undefined, 0.5);
  }

  scripts\engine\utility::ent_flag_set("c4_planted");
  level thread scripts\cp\cp_breach_c4::force_ai_to_drop_thermites(var1);
  level thread scripts\cp\cp_breach_c4::c4_explode(self, var2);
  thread scripts\engine\utility::delete_on_death(var2);

  if(var4) {
    return;
  }
}

function check_for_trexremoval() {
  wait 0.5;
  wait 0.4;
  self playSound("breach_c4_plant_01");
  wait 0.4;
  self playSound("breach_c4_plant_02");
  wait 0.73;
  self playSound("breach_c4_plant_03");
  wait 1.2;
  self playSound("breach_c4_plant_04");
  wait 0.5;
  self playSound("breach_c4_plant_05");
}

function ref_1240d() {
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  self disableweapons();
  self setadditionalstreampos(level.c130.origin, 1);
  self setOrigin(level.c130.origin, 1);
  self setplayerangles(level.c130.angles);
  level.c130 playsoundonmovingent("scn_cp_747_engine_ext_dying");
  self playerlinkTo(level.c130);
  self.binc130 = undefined;
  self setclientomnvar("ui_hide_bigmap", 0);
  waitframe();
  self playlocalsound("scn_cp_747_exfil_jump_main_plr");
  self playlocalsound("scn_cp_747_exfil_freefall_main_plr");
  var0 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "player_falling", 1, 1, 0);
  var1 = "player_1";
  waitframe();
  level.c130 notify("players_viewing_crash");
  level.c130 scripts\cp_mp\anim_scene::anim_scene([var0], var1 + "_end", 1, 1);
  self unlink();
  self skydive_beginfreefall();
  self enableweapons();
  self skydive_setbasejumpingstatus(1);
  self skydive_setdeploymentstatus(1);
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  thread parachute();
}

function ref_123c2() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("multi_airstrike", self);
  var1 = level.scr_anim[var0.streakname]["airstrike_flyby"];
  var2 = getanimlength(var1);
  var3 = 0;

  while(var3 <= 4) {
    thread scripts\cp_mp\killstreaks\airstrike::finishairstrikeusage(level.c130.origin, level.c130.angles[1], undefined, var0, var1);
    thread ref_14315(var3, var2);
    var3++;
    wait 1;
  }
}

function ref_14315(var0, var1) {
  if(var0 > 1) {
    return;
  }

  wait 6;
  level.c130 notify("airstrikes_done");
}

function vehicle_remove_invulnerability_onenter() {
  self endon("death");
  level.c130 endon("death");
  jumpiftrue(isDefined(self.cameraent)) LOC_00000053;
  var0 = spawn("script_model", self getEye());
  var0 setModel("tag_origin");
  var0.angles = self.angles;
  self.cameraent = var0;
  self playerlinkTo(self.cameraent);

  for(;;) {
    var1 = level.c130.origin;
    var2 = vectorNormalize(var1 - self getEye());
    var3 = scripts\cp\utility::vectortoanglessafe(var2, (0, 0, 1));
    self setplayerangles(var3);
    waitframe();
  }
}

function ref_13ade() {
  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(scripts\engine\utility::array_contains(level.landed_players, var0)) {
      continue;
    }

    thread playerhastrock(var0);

    if(scripts\cp\cp_weapon::ref_124ad(var0)) {
      scripts\cp\cp_weapon::minigamefinishcount(var0);
    }

    thread ref_123ea(var0);
  }
}

function playerhastrock(var0) {
  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == var0) {
    foreach(var2 in level.players) {
      if(istrue(var2.inlaststand)) {
        var2 notify("force_bleed_out");
      }
    }

    return;
  }
}

function ref_123ea(var0) {
  if(isDefined(level.ref_134e1)) {
    level.ref_134e1 delete();
  }

  if(!scripts\engine\utility::array_contains(level.landed_players, var0)) {
    level.landed_players = scripts\engine\utility::array_add(level.landed_players, var0);
  }

  if(isDefined(level.nuclear_core_carrier)) {
    if(var0 == level.nuclear_core_carrier) {
      level.ref_11eda = 1;

      foreach(var2 in level.players) {
        if(istrue(var2.binc130)) {
          scripts\cp_mp\entityheadicons::ref_1315e(level.nuclear_core_carrier.headicon, var2);
          continue;
        }

        thread scripts\cp\respawn\cp_respawn::autofeeder(var2, 4);
      }
    } else if(istrue(level.ref_11eda)) {
      if(isDefined(level.nuclear_core_carrier)) {
        thread scripts\cp\respawn\cp_respawn::autofeeder(var0, 4);
      }
    } else if(isDefined(level.nuclear_core_carrier)) {
      scripts\cp_mp\entityheadicons::ref_1315e(level.nuclear_core_carrier.headicon, var0);
    }
  }

  if(istrue(var0.isjuggernaut)) {
    var0.fly_to_end_point = 1;
    var0 scripts\cp\cp_juggernaut::jugg_removejuggernaut();
  }

  var0 vehiclepinonminimap(1);
  var0 notify("clean_turbulence_threads");
  var0 notify("end_nuke_threads");
  var0 disableweapons();

  if(var0.class == "engineer" || var0.class == "hunter") {
    var0.mousetraplocs = 1;
  }

  scripts\cp\cp_outofbounds::enableoobimmunity(var0);
  var4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var0, "player_falling", 1, 1, 0);
  var0.vehicle_occupancy_mp_giveriotshield = getEnt("end_breach_sceneNode", "targetname");
  var0.vehicle_occupancy_mp_giveriotshield scripts\cp_mp\anim_scene::anim_scene([var4], "player_1", 1, 1);
  var0 thread scripts\cp\respawn\cp_respawn::ref_12768(0, 1.2, 0.3, "white");
  thread ref_1240d();
  level notify("enable_respawns");
}

function ref_13811() {
  claxon_lights_on("lower_region_plane");
}

function claxon_light_init() {
  level.claxons = [];
  var0 = getEntArray("claxon_model_on", "targetname");

  foreach(var2 in var0) {
    var2 useanimtree(#animtree);
    var2.lights = [];
    var3 = getEntArray(var2.target, "targetname");

    foreach(var5 in var3) {
      if(var5.script_namenumber == "light") {
        var5 linkTo(var2, "j_spin");
        var2.lights[var2.lights.size] = var5;
      }

      if(var5.script_namenumber == "model_off") {
        var2.model_off = var5;
      }
    }

    if(!isDefined(level.claxons[var2.script_noteworthy])) {
      level.claxons[var2.script_noteworthy] = spawnStruct();
      level.claxons[var2.script_noteworthy].models_on = [];
    }

    var7 = level.claxons[var2.script_noteworthy].models_on;
    var7 = var2;
    level.claxons[var2.script_noteworthy].models_on = var7;
  }

  var9 = getarraykeys(level.claxons);

  foreach(var11 in var9) {
    thread claxon_lights_off(level, var11);
  }
}

function claxon_lights_on(var0) {
  foreach(var2 in level.claxons[var0].models_on) {
    var2 show();
    var2.model_off hide();

    if(isDefined(var2.script_fxid)) {
      playFXOnTag(scripts\engine\utility::getfx(var2.script_fxid), var2, "j_spin");
    }

    foreach(var4 in var2.lights) {
      thread lerp_intensity(var4, 1);
      var4 setlightcolor((1, 0.085294, 0.03137));
    }

    var2 scriptmodelplayanim("claxon_spin_loop");
    wait 0.3;
  }
}

function claxon_lights_off(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  foreach(var3 in level.claxons[var0].models_on) {
    thread claxon_stop_spin(var3);
  }
}

function claxon_stop_spin(var0) {
  self clearanim(%claxon_spin_loop, 0.5);

  if(var0) {
    wait 0.5;
  }

  foreach(var2 in self.lights) {
    thread lerp_intensity(var2, 0);
  }

  if(isDefined(self.script_fxid)) {
    killfxontag(scripts\engine\utility::getfx(self.script_fxid), self, "j_spin");
    return;
  }
}

function lerp_intensity(var0, var1) {
  var2 = int(var1 * 20);
  var3 = self getlightintensity();
  var4 = (var0 - var3) / var2;

  for(var5 = 0; var5 < var2; var5++) {
    thread handle_linked_ents(var0);
    self setlightintensity(var3 + var5 * var4);
    wait 0.05;
  }

  GscBinSkip1(0x45, 0, self);
}

function handle_linked_ents(var0) {
  if(isDefined(self.script_threshold)) {
    var1 = var0 > self.script_threshold;

    foreach(var3 in self.lit_models) {
      if(var1 && !var3.visible) {
        var3.visible = var1;
        var3 show();

        if(isDefined(var3.effect)) {
          thread restarteffect();
        }

        continue;
      }

      if(!var1 && var3.visible) {
        var3.visible = var1;
        var3 hide();

        if(isDefined(var3.effect)) {
          var3.effect thread scripts\engine\utility::pauseeffect();
        }
      }
    }

    foreach(var3 in self.unlit_models) {
      if(!var1 && !var3.visible) {
        var3.visible = 1;
        var3 show();
        continue;
      }

      if(var1 && var3.visible) {
        var3.visible = 0;
        var3 hide();
      }
    }

    return;
  }
}

function restarteffect() {
  scripts\common\createfx::restart_fx_looper();
}

function heli_crash_path_loc_setup() {
  wait 2;
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("helicopter_crash_location", "targetname"));
}

function winindex() {
  level.flytime = [];
  var0 = ["plane_mover_probe_stair", "plane_mover_probe_back", "lgt_dyn_plane"];

  foreach(var2 in var0) {
    var3 = getEntArray(var2, "targetname");

    foreach(var5 in var3) {
      if(var5.classname == "reflection_probe") {
        if(isDefined(var5.target)) {
          var5.spotlight = getEnt(var5.target, "targetname");

          if(isDefined(var5.spotlight)) {
            var5.spotlight setlightintensity(25);
            var5.spotlight linkTo(var5);
          }
        }

        var5 hide();
        var5 linkTo(level.c130);
        level.flytime = scripts\engine\utility::array_add(level.flytime, var5);
      }

      if((var5.classname == "light_spot" || var5.classname == "light_omni") && var5.targetname == var2) {
        var5.og_intensity = var5 getlightintensity();
        var5 setlightintensity(0);
        var5.spotlight = getEnt(var5.target, "targetname");

        if(issubstr(var5.target, "auto267")) {
          var5.spotlight = getEnt("auto267", "targetname");
        } else if(issubstr(var5.target, "auto268")) {
          var5.spotlight = getEnt("auto268", "targetname");
        }

        if(isDefined(var5.spotlight)) {
          var5.spotlight setlightintensity(25);
          var5.spotlight linkTo(var5);
        }

        level.flytime = scripts\engine\utility::array_add(level.flytime, var5);
      }
    }
  }
}

function ref_130a8(var0) {
  var1 = scripts\engine\utility::getStruct("cp_plane_hijack_endgame_cam", "targetname");
  var2 = var1.origin;
  var3 = scripts\engine\utility::ter_op(isDefined(var1.angles), var1.angles, (0, 0, 0));
  var4 = scripts\engine\utility::getStruct(var1.target, "targetname");

  foreach(var6 in level.players) {
    var6 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var6 in level.players) {
    var9 = spawn("script_model", var2);
    var9 setModel("tag_origin");
    var9.angles = var3;
    var9 moveTo(var4.origin, 20, 1, 1);
    var6 allowfire(0);
    var6 disableoffhandweapons();
    var6 disableusability();
    var6 allowmovement(0);
    var6 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var6, var9);
    var6 lerpfovscalefactor(0, 0);
  }
}

function spawn_endgame_camera(var0) {
  self.ignoreme = 1;
  self cameralinkTo(var0, "tag_origin", 1);
  self setclientdvar("LQKPQMPRQN", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "50");
    return;
  }
}