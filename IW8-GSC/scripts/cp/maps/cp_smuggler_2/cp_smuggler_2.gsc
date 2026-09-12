/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_smuggler_2\cp_smuggler_2.gsc
***********************************************************/

function main() {
  level.default_player_spawns = "default_spawn_" + level.script;
  tank_west();
  scripts\cp\cp_compass::setupminimap("compass_map_cp_smuggler_2");
  scripts\cp\maps\cp_smuggler_2\cp_smuggler_2_precache::main();
  scripts\cp\maps\cp_smuggler_2\gen\cp_smuggler_2_art::main();
  scripts\cp\maps\cp_smuggler_2\cp_smuggler_2_fx::main();
  scripts\cp\maps\cp_smuggler_2\cp_smuggler_2_lighting::main();
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setdvarifuninitialized("scr_use_squads", 1);

  if(level.createfx_enabled) {
    return;
  }

  registerscriptedagents();
  scripts\cp_mp\tripwire::precache("tripwire_start", "equipment_wm_tripwire_ceiling");
  scripts\cp_mp\tripwire::precache("tripwire_start", "equipment_wm_tripwire_wall");
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
  scripts\cp\utility::coop_mode_enable();
  scripts\cp_mp\utility\game_utility::registerlargemap();
  create_level_funcs_tables_and_vars();
  init_global_systems();
  init_objectives();
  init_level_systems();
  scripts\cp\maps\cp_smuggler\cp_smuggler_checkpoints::ref_131ED();
  scripts\mp\brclientmatchdata::getquestrewardgroupindex();
  level.incorrectcodeentered = 1.5;
  scripts\mp\brclientmatchdata::getpresettruckspawns("tow_p1", &scripts\cp\maps\cp_smuggler\cp_smuggler_checkpoints::ref_11C58);
  scripts\mp\brclientmatchdata::getpresettruckspawns("convoy4_secure_tower", &scripts\cp\maps\cp_smuggler\cp_smuggler_checkpoints::ref_11C5B);
  var_0 = getDvar("restart_checkpoint", "");

  if(isDefined(var_0) && var_0 != "") {
    scripts\mp\brclientmatchdata::getnextprop(var_0);
    scripts\mp\brclientmatchdata::getnextrpgspawnmodule(var_0);
    level thread[[level.ref_12B19[var_0]]]();
  } else {
    var_1 = getDvar("cp_smuggler_start_obj", "convoy4_securearea");

    if(var_1 == "") {
      var_1 = "convoy4_securearea";
    }

    setDvar("cp_smuggler_start_obj", var_1);

    if(isDefined(var_1)) {
      thread rundebugstartobjective(level);
    }
  }

  scripts\engine\utility::flag_set("infil_complete");
  thread incrementalrespawnpunishmax();
}

function incrementalrespawnpunishmax() {
  wait 5;
  var_0 = spawn("sound_transient_soundbanks", (0, 0, 0));
  var_0 settransientsoundbank("cp_op_smuggler.all", 1);
}

function create_level_funcs_tables_and_vars() {
  level.objectivesfunc = &levelobjectives_init;
  level.map_interaction_func = &scripts\cp\maps\cp_smuggler_2\cp_smuggler_2_interactions::register_interactions;
  level.player_interaction_monitor = &scripts\cp\maps\cp_smuggler_2\cp_smuggler_2_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_smuggler_2\cp_smuggler_2_interactions::level_specific_wait_for_interaction_triggered;
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_smuggler_2/cp_smuggler_2_weaponrank_event.csv";
  level.disable_start_spawn_on_navmesh = 1;
  level.additional_laststand_weapon_exclusion = [];
  level.ambientgroupinit = &register_spawn_modules;
}

function init_objectives() {
  level thread scripts\cp\cp_objectives::objectives_init();
  thread setup_global_event_objectives();
  level thread scripts\cp\maps\cp_quarry2\cp_quarry2_objective_smuggler::main();
  level thread scripts\cp\maps\cp_suburbs11\cp_suburbs11_safehouse::main();
}

function levelobjectives_init() {
  level.objectives_table = "cp/cp_smuggler_2_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_donetsk_objectives_matrix.csv";
  level.objectiveregistration = &levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function init_global_systems() {
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_physics_mp", "techo_phys_convoy_cp", "script_vehicle_iw8_truck_techo_white_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_physics_mp", "techo_physics", "script_vehicle_iw8_truck_techo_white_physics");
  scripts\vehicle\mkilo23_ai_infil::main("veh8_mil_lnd_mkilo23_physics_mp", "mkilo_physics", "script_veh8_mil_lnd_mkilo23_physics_ai_infil");
  scripts\vehicle\empty_turret::main("cp_turret_body", "empty_turret", "script_vehicle_empty_turret");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel_east", "veh_pac_sentry_mp", "script_vehicle_mp_collmap_wheelson_east");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel", "veh_pac_sentry_mp", "script_vehicle_mp_collmap_wheelson_west");
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  setup_create_script();
  level thread scripts\cp\crate_drops\cp_crate_drops::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\cp_breach_c4::main();
  level thread scripts\cp\intel\cp_intel::intel_init();
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("smuggler2");
  scripts\cp\cp_gameskill::init_gameskill();
  level thread scripts\cp\cp_kidnapper::init_kidnapper_combat_loop();
  level thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
}

function init_level_systems() {
  thread setup_map_specific_devgui();
  thread wait_for_pre_game_period();
  thread heli_crash_path_loc_setup();
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_intel::init_intel_pieces();
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
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_obj_smugglercaches::register_smugglercache_objective();
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_obj_apprehension::register_apprehension_objective();

  if(isDefined(level.convoy4_objective_func)) {
    [[level.convoy4_objective_func]]();
  }

  if(isDefined(level.safehouse_s11_obj_func)) {
    level thread[[level.safehouse_s11_obj_func]]();
    return;
  }
}

function setup_global_event_objectives() {
  level endon("game_ended");
  scripts\cp\cp_objectives_events::init();
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
  register_cs_inits();
  scripts\cp\utility::register_create_script("cp_donetsk_smuggler_helicopters", "cp_donetsk_smuggler_helicopters", level.scripted_spawner_func.size, &scripts\cp\maps\cp_smuggler\cp_donetsk_smuggler_helicopters::main);
  scripts\cp\utility::register_create_script("cp_donetsk_spawn_parents", "cp_donetsk_spawn_parents", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_spawn_parents::main);
  scripts\cp\utility::register_create_script("cp_donetsk_intel_cs", "cp_donetsk_intel_cs", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_intel_cs::main);
  scripts\cp\utility::register_create_script("cp_smuggler_vehicle_cs", "cp_smuggler_vehicle_cs", level.scripted_spawner_func.size, &scripts\cp\maps\cp_smuggler\cp_smuggler_vehicle_cs::main);
  scripts\cp\utility::register_create_script("cp_crate_drops_cs", "cp_carepackage_crates_cs", level.scripted_spawner_func.size, &scripts\cp\crate_drops\cp_crate_drops_cs::main);
  scripts\cp\utility::register_create_script("cp_donetsk_safehouse_suburbs11_cs", "cp_donetsk_safehouse_suburbs11_cs", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_suburbs11_cs::main);
  scripts\cp\utility::register_create_script("cp_smugglercaches_north_create_script", "cp_smugglercaches_north_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_smugglercaches_north_create_script::main);
  scripts\cp\utility::register_create_script("cp_tugofwar_north_create_script", "cp_tugofwar_north_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_tugofwar_north_create_script::main);
  scripts\cp\cp_create_script_utility::register_cs_offsets("cp_quarry2_convoy4_create_script", (28911.3, 41021.8, 1040), (0, 300, 0));
  scripts\cp\utility::register_create_script("cp_quarry2_convoy4_create_script", "cp_quarry2_convoy4_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_quarry2\cp_quarry2_convoy4_create_script::main);
  scripts\cp\utility::register_create_script("cp_smuggler_safehouse_createscript", "cp_smuggler_safehouse_2_createscript", level.scripted_spawner_func.size, &scripts\cp\maps\cp_smuggler\cp_smuggler_safehouse_createscript::main);

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
    return;
  }
}

function register_cs_inits() {
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_intel_cs");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_crate_drops_cs");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_smuggler_vehicle_cs");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_smuggler_helicopters");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_spawn_parents");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_safehouse_downtown_cs");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("map_downtown_patrol_path");
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
  var_0 thread scripts\cp\coop_personal_ents::player_run_pent_updates(var_0);

  if(getdvarint("force_spawn_veh", 0) != 0) {
    var_1 = [(20120, -24623, 1000), (19554, -24184, 1000), (18935, -23685, 1000), (18319, -22907, 1000), (13692, 15239, 1000), (14316, 16296, 1000)];

    foreach(var_3 in var_1) {
      scripts\cp\vehicles\little_bird_cp::spawn_little_bird_at_location(var_3, (0, 0, 0), "allies");
    }

    return;
  }
}

function onplayerspawned() {}

function setup_map_specific_devgui() {}

function register_spawn_modules() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\cp\cp_modular_spawning::register_aitype_setup("tugofwar_civ", "actor_civilian_cp_tugofwar", undefined, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("cp_donetsk_heli_spawns", 0, 24, undefined, 0.1, undefined, "cp_donetsk_heli_spawns", &scripts\cp\cp_modular_spawning::init_wave_settings);
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

function tank_west() {
  level.incrementalrespawnpunish = [];
  level.incrementalrespawnpunish[0] = tank_westturret((22523.5, 29032, 1217.38));
  level.incrementalrespawnpunish[1] = tank_westturret((22472, 29032, 1217.38));
  level.incrementalrespawnpunish[2] = tank_westturret((22482, 29096, 1217.38));
  level.incrementalrespawnpunish[3] = tank_westturret((22526, 29096, 1217.38));
}

function tank_westturret(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_1.angles = (0, 90, 0);
  var_1.targetname = level.default_player_spawns;
  scripts\cp\cp_create_script_utility::initbunkeranims("targetname", var_1.targetname, var_1);
  return var_1;
}