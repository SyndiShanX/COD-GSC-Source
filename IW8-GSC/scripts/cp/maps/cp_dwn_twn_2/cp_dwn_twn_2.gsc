/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2.gsc
*********************************************************/

function main() {
  scripts\cp\cp_compass::setupminimap("compass_map_cp_dwn_twn_2");
  scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_precache::main();
  scripts\cp\maps\cp_dwn_twn_2\gen\cp_dwn_twn_2_art::main();
  scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_fx::main();
  scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_lighting::main();
  level.default_player_spawns = "default_spawn_" + level.script;
  setDvar("PKKMTTRQO", 8);
  setDvar("NSSMQLPRNT", 0.01);
  setdvarifuninitialized("scr_use_squads", 1);

  if(level.createfx_enabled) {
    return;
  }

  registerscriptedagents();
  level.objectivesfunc = &levelobjectives_init;
  scripts\cp_mp\tripwire::precache("tripwire_start", "equipment_wm_tripwire_ceiling");
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_intel_cs");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_crate_drops_cs");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_launderer_helicopters");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_spawn_parents");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_safehouse_downtown_cs");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("map_downtown_patrol_path");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_helidown_cs");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_dwn_twn_convoys_script_spawners");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_dwn_twn_vehicle_paths_create_script");
  scripts\cp\utility::coop_mode_enable();
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_physics_mp", "techo_phys_convoy_cp", "script_vehicle_iw8_truck_techo_white_physics");
  scripts\vehicle\mkilo23_ai_infil::main("veh8_mil_lnd_mkilo23_physics_mp", "mkilo_physics", "script_veh8_mil_lnd_mkilo23_physics_ai_infil");
  scripts\vehicle\empty_turret::main("cp_turret_body", "empty_turret", "script_vehicle_empty_turret");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel_east", "veh_pac_sentry_mp", "script_vehicle_mp_collmap_wheelson_east");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel", "veh_pac_sentry_mp", "script_vehicle_mp_collmap_wheelson_west");
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  level.incorrectcodeentered = 1.5;
  level.disable_start_spawn_on_navmesh = 1;
  level.map_interaction_func = &scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_interactions::register_interactions;
  level.player_interaction_monitor = &scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_interactions::level_specific_wait_for_interaction_triggered;
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_dwn_twn_2/cp_dwn_twn_2_weaponrank_event.csv";
  level.additional_laststand_weapon_exclusion = [];
  level.ambientgroupinit = &register_spawn_modules;
  level.init_personal_ent_zones = &scripts\cp\coop_personal_ents::init_personal_ent_zones;

  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_init("infil_complete");
  }

  if(!scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_init("introscreen_over");
  }

  thread setup_map_specific_devgui();
  thread wait_for_pre_game_period();
  thread wait_for_strike_init_complete();
  thread setup_create_script();

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
  }

  level thread scripts\cp\cp_objectives::objectives_init();
  thread setup_global_event_objectives();
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_vault_assault::main();
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::main();
  level thread scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_ml_p2::main();
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p3::main();
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse::main();
  level thread scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_objectives::levelregisterobjectives();
  level thread scripts\cp\crate_drops\cp_crate_drops::main();
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_bb_recovery::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\cp_breach_c4::main();
  level thread scripts\cp\intel\cp_intel::intel_init();
  level thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
  scripts\cp\cp_gameskill::init_gameskill();
  thread heli_crash_path_loc_setup();
  thread spawn_technicals_for_players();
  level thread scripts\cp\cp_kidnapper::init_kidnapper_combat_loop();
  scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_checkpoints::ref_131ed();
  scripts\mp\brclientmatchdata::getquestrewardgroupindex();
  scripts\mp\brclientmatchdata::getpresettruckspawns("ml_p1", &scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_checkpoints::ref_11c58);
  scripts\mp\brclientmatchdata::getpresettruckspawns("ml_p2", &scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_checkpoints::ref_11c5b);
  scripts\mp\brclientmatchdata::getpresettruckspawns("ml_p3", &scripts\cp\maps\cp_dwn_twn_2\cp_dwn_twn_2_checkpoints::ref_11c5c);
  var_0 = getDvar("restart_checkpoint", "");

  if(isDefined(var_0) && var_0 != "") {
    scripts\mp\brclientmatchdata::getnextprop(var_0);
    scripts\mp\brclientmatchdata::getnextrpgspawnmodule(var_0);
    level thread[[level.ref_12b19[var_0]]]();
  } else {
    var_1 = getDvar("cp_dwn_twn_2_start_obj", "safehouse");

    if(var_1 == "") {
      if(getdvarint("scr_cp_map_part2") >= 1) {
        var_1 = "safehouse_gunshop";
      } else {
        var_1 = "safehouse";
      }
    }

    setDvar("cp_dwn_twn_2_start_obj", var_1);

    if(isDefined(var_1)) {
      thread rundebugstartobjective(level);
    }
  }

  scripts\engine\utility::flag_set("infil_complete");
  thread increase_sequence_tier();
}

function increase_sequence_tier() {
  wait 5;
  var_0 = spawn("sound_transient_soundbanks", (0, 0, 0));
  var_0 settransientsoundbank("cp_op_money_launderer.all", 1);
}

function levelobjectives_init() {
  level.objectives_table = "cp/cp_dwn_twn_2_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_donetsk_objectives_matrix.csv";
  level.objectiveregistration = &levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function spawn_technicals_for_players() {
  wait 10;
  var_0 = spawnStruct();
  var_0.origin = (29647.5, -9049.5, -424);
  var_0.angles = (0, 120, 0);
  var_0.team = "allies";
  scripts\cp_mp\vehicles\technical::technical_create(var_0);
  var_0 = spawnStruct();
  var_0.origin = (17811.5, -22229.5, -210.101);
  var_0.angles = (0, 135, 0);
  var_0.team = "allies";
  scripts\cp_mp\vehicles\technical::technical_create(var_0);
}

function heli_crash_path_loc_setup() {
  wait 2;
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("helicopter_crash_location", "targetname"));
}

function rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_wait("strike_init_done");

  if(isDefined(level.objectivestabledata[var_0])) {
    var_1 = level.objectivestabledata[var_0];

    if(isDefined(var_1.csdependency)) {
      if(!scripts\engine\utility::flag_exist(var_1.csdependency)) {
        scripts\engine\utility::flag_init(var_1.csdependency);
      }

      scripts\engine\utility::flag_set(var_1.csdependency);

      if(!scripts\engine\utility::flag_exist(var_1.csdependency + "_completed")) {
        scripts\engine\utility::flag_init(var_1.csdependency + "_completed");
      }

      scripts\engine\utility::flag_wait(var_1.csdependency + "_completed");
    }

    if(isDefined(var_1.ondebugstartfunc)) {
      [[var_1.ondebugstartfunc]](var_1);
    }

    thread scripts\cp\cp_objectives::run_objective(var_1.objname, var_1.questtype);
    return;
  }
}

function levelregisterobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\maps\cp_donetsk\cp_donetsk_obj_helidown::register_helidown_objective();
  thread register_attack_heli_objective();

  if(isDefined(level.vault_assault_objective_func)) {
    [[level.vault_assault_objective_func]]();
  }

  if(isDefined(level.mlp1_obj_func)) {
    [[level.mlp1_obj_func]]();
  }

  if(isDefined(level.mlp3_obj_func)) {
    [[level.mlp3_obj_func]]();
  }

  if(isDefined(level.rooftop_obj_func)) {
    [[level.rooftop_obj_func]]();
  }

  if(isDefined(level.mlp2_obj_func)) {
    [[level.mlp2_obj_func]]();
  }

  if(isDefined(level.safehouse_obj_func)) {
    [[level.safehouse_obj_func]]();
  }

  if(isDefined(level.obj_bb_recovery)) {
    [[level.obj_bb_recovery]]();
    return;
  }
}

function register_attack_heli_objective() {
  scripts\cp\cp_objectives::registerobjective("attack_heli_test", undefined, &emptyfunc, undefined, undefined, &debug_attack_heli_test_start);
}

function debug_attack_heli_test_start(var_0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "safehouse_1_playerstart");
}

function emptyfunc(var_0) {
  level thread scripts\cp\cp_modular_spawning::run_spawn_module("attack_heli_test");
  level waittill("forever");
}

function setup_global_event_objectives() {
  level endon("game_ended");
  scripts\cp\cp_objectives_events::init();
  scripts\cp\cp_objectives_events::register_event("objective_heli_down_start", &scripts\cp\maps\cp_donetsk\cp_donetsk_obj_helidown::objective_heli_down_start, undefined, &scripts\cp\maps\cp_donetsk\cp_donetsk_obj_helidown::heli_down_init);
  level thread scripts\cp\cp_objectives_events::run("scripts/cp/maps/cp_donetsk/cp_donetsk_objectives_events.csv");
}

function setup_create_script() {
  level.threadedscriptspawners = 1;
  level.create_script_file_ids = [];
  level.cs_scripted_spawners = [];
  level.scripted_spawners = [];
  level.cs_scripted_spawners_triggers = [];
  level.scripted_spawners_triggers = [];
  level.cs_scripted_spawners_models = [];
  level.scripted_spawners_models = [];
  level.createscriptfilesinitialized = 0;
  level.scripted_spawner_func_strings = [];
  level.scripted_spawner_map_strings = [];
  level.scripted_spawner_func = [];
  register_create_script_arrays("cp_dwn_twn_create_script", "cp_dwn_twn_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_create_script::main);
  register_create_script_arrays("cp_donetsk_launderer_helicopters", "cp_donetsk_launderer_helicopters", level.scripted_spawner_func.size, &scripts\cp\maps\cp_dwn_twn_2\cp_donetsk_launderer_helicopters::main);
  register_create_script_arrays("cp_donetsk_veh_ground_paths", "cp_donetsk_veh_ground_paths", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_veh_ground_paths::main);
  register_create_script_arrays("cp_donetsk_helidown_cs", "cp_donetsk_helidown_cs", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_helidown_cs::main);
  register_create_script_arrays("cp_donetsk_safehouse_downtown_cs", "cp_donetsk_safehouse", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_downtown_cs::main);
  register_create_script_arrays("cp_donetsk_spawn_parents", "cp_donetsk_spawn_parents", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_spawn_parents::main);
  register_create_script_arrays("cp_donetsk_intel_cs", "cp_donetsk_intel_cs", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_intel_cs::main);
  register_create_script_arrays("cp_crate_drops_cs", "cp_carepackage_crates_cs", level.scripted_spawner_func.size, &scripts\cp\crate_drops\cp_crate_drops_cs::main);
  register_create_script_arrays("cp_dwn_twn_ml_p1_create_script", "cp_dwn_twn_ml_p1_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_ml_p1_create_script::main);
  register_create_script_arrays("cp_dwn_twn_vehicle_paths_create_script", "cp_dwn_twn_vehicle_paths_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_vehicle_paths_create_script::main);
  register_create_script_arrays("dwn_twn_mlp2_script", "dwn_twn_mlp2_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_dwn_twn\dwn_twn_mlp2_script::main);
  register_create_script_arrays("cp_dwn_twn_ml_p3_create_script", "cp_dwn_twn_ml_p3_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_ml_p3_create_script::main);
  register_create_script_arrays("cp_dwn_twn_bank_vehicle_create_script", "cp_dwn_twn_bank_vehicle_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_bank_vehicle_create_script::main);
  register_create_script_arrays("map_downtown_patrol_path", "map_downtown_patrol_path", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\map_downtown_patrol_path::main);
}

function register_create_script_arrays(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;
  }

  if(isDefined(var_1)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;
  }

  if(isDefined(var_2)) {
    level.create_script_file_ids[var_0] = "cs" + var_2;
  }

  if(isDefined(var_3)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_3;
    return;
  }
}

function onplayerspawneddevguisetup(var_0) {
  var_1 = var_0.name;
  var_2 = undefined;

  foreach(var_4 in level.players) {
    if(var_4 == var_0) {
      var_2 = int(var_5);
      break;
    }
  }

  if(isDefined(var_2)) {
    thread setupdevguientries(var_0, var_0, var_1);
    return;
  }
}

function setupdevguientries(var_0, var_1, var_2) {}

function wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  wait 0.2;
  scripts\cp\cp_objectives::registerobjective("map_restart", undefined, undefined, undefined, undefined, undefined);
}

function registerscriptedagents() {
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

function onplayerconnect(var_0) {
  var_0.gameskill = scripts\cp\cp_gameskill::get_gameskill();
  var_0 scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();

  if(getdvarint("force_spawn_veh", 0) != 0) {
    var_1 = [(20120, -24623, 1000), (19554, -24184, 1000), (18935, -23685, 1000), (18319, -22907, 1000), (13692, 15239, 1000), (14316, 16296, 1000)];

    foreach(var_3 in var_1) {
      scripts\cp\vehicles\little_bird_cp::spawn_little_bird_at_location(var_3, (0, 0, 0), "allies");
    }

    return;
  }
}

function onplayerspawned() {}

function wait_for_strike_init_complete() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("personal_ent_zones_initialized");

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
    var_0 = getDvar("scr_strike_name");
    var_1 = undefined;

    switch (var_0) {
      case "putnewstrikehere":
        break;
      default:
        break;
    }

    return;
  }
}

function setup_map_specific_devgui() {}

function register_spawn_modules() {
  level endon("game_ended");
  level.ambientgroups = [];
  level.active_spawn_modules = [];

  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_wait("interactions_initialized");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  scripts\cp\cp_modular_spawning::registerambientgroup("cp_donetsk_heli_spawns", 0, 24, undefined, 0.1, undefined, "cp_donetsk_heli_spawns", &scripts\cp\cp_modular_spawning::init_wave_settings);
  scripts\cp\cp_modular_spawning::registerambientgroup("ai_ground_veh_spawner", 0, 24, undefined, 0.1, undefined, "ai_ground_veh_spawner", &set_vehicle_settings_on_spawners);
  scripts\cp\cp_modular_spawning::registerambientgroup("cp_donetsk_heli_spawns_test", 0, 6, undefined, 0.1, undefined, "cp_donetsk_heli_spawns");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("cp_donetsk_heli_spawns", &scripts\cp\cp_modular_spawning::toggle_teleport_enemy_info_loop);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("cp_donetsk_heli_spawns_test", &scripts\cp\cp_modular_spawning::toggle_teleport_enemy_info_loop);
  scripts\cp\cp_modular_spawning::register_module_as_passive("cp_donetsk_heli_spawns_test");
  scripts\cp\cp_modular_spawning::register_module_as_passive("cp_donetsk_heli_spawns");
}

function set_vehicle_settings_on_spawners(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::process_module_var(var_0, var_0.spawn_points);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2] scripts\cp\cp_modular_spawning::initialize_as_veh_spawner();
  }
}