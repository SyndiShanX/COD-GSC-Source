/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_armsdealer_2\cp_armsdealer_2.gsc
***************************************************************/

function main() {
  level.default_player_spawns = "default_spawn_cp_arms_dealer";
  scripts\cp\cp_compass::setupminimap("compass_map_cp_armsdealer_2");
  scripts\cp\maps\cp_armsdealer_2\cp_armsdealer_2_precache::main();
  scripts\cp\maps\cp_armsdealer_2\gen\cp_armsdealer_2_art::main();
  scripts\cp\maps\cp_armsdealer_2\cp_armsdealer_2_fx::main();
  scripts\cp\maps\cp_armsdealer_2\cp_armsdealer_2_lighting::main();
  setDvar("PKKMTTRQO", 8);
  setDvar("SRQLQNLMK", 1);
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
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_arms_dealer_helicopters");
  scripts\cp\cp_create_script_utility::set_cs_file_dvar("cp_donetsk_spawn_parents");
  scripts\cp\utility::coop_mode_enable();
  level.incorrectcodeentered = 1.5;
  scripts\cp_mp\utility\game_utility::registerlargemap();
  level.disable_start_spawn_on_navmesh = 1;
  level.interaction_trigger_properties_func = &set_interaction_trigger_properties;
  level.map_interaction_func = &scripts\cp\maps\cp_armsdealer_2\cp_armsdealer_2_interactions::register_interactions;
  level.player_interaction_monitor = &scripts\cp\maps\cp_armsdealer_2\cp_armsdealer_2_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_armsdealer_2\cp_armsdealer_2_interactions::level_specific_wait_for_interaction_triggered;
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_armsdealer_2/cp_armsdealer_2_weaponrank_event.csv";
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

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
  }

  level thread scripts\cp\cp_objectives::objectives_init();
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_intel::init_intel_pieces();
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  thread heli_crash_path_loc_setup();
  init_global_systems();
  thread spawn_technicals_for_players();
  visionsetnaked("mp_donetsk");
  scripts\cp\maps\cp_arms_dealer\cp_arms_dealer_checkpoints::ref_131ed();
  scripts\mp\brclientmatchdata::getquestrewardgroupindex();
  scripts\mp\brclientmatchdata::getpresettruckspawns("apce_p1", &scripts\cp\maps\cp_arms_dealer\cp_arms_dealer_checkpoints::c4_obj_and_progress);
  scripts\mp\brclientmatchdata::getpresettruckspawns("arms_race_p1", &scripts\cp\maps\cp_arms_dealer\cp_arms_dealer_checkpoints::camera_loadout_showcase_preview_large_sticker_alt2);
  var0 = getDvar("restart_checkpoint", "");

  if(isDefined(var0) && var0 != "") {
    scripts\mp\brclientmatchdata::getnextprop(var0);
    scripts\mp\brclientmatchdata::getnextrpgspawnmodule(var0);
    level thread[[level.ref_12b19[var0]]]();
  } else {
    var1 = getDvar("cp_armsdealer_2_start_obj", "safehouse_armsdealer_return");

    if(var1 == "") {
      var1 = "safehouse_armsdealer_return";
    }

    setDvar("cp_armsdealer_2_start_obj", var1);

    if(isDefined(var1)) {
      thread rundebugstartobjective(level);
    }
  }

  thread increase_hp_from_relic_mythic();
  scripts\engine\utility::flag_set("infil_complete");
}

function init_global_systems() {
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_physics_mp", "techo_phys_convoy_cp", "script_vehicle_iw8_truck_techo_white_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_physics_mp", "techo_physics", "script_vehicle_iw8_truck_techo_white_physics");
  scripts\vehicle\mkilo23_ai_infil::main("veh8_mil_lnd_mkilo23_physics_mp", "mkilo_physics", "script_veh8_mil_lnd_mkilo23_physics_ai_infil");
  scripts\vehicle\empty_turret::main("cp_turret_body", "empty_turret", "script_vehicle_empty_turret");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel_east", "veh_pac_sentry_mp", "script_vehicle_mp_collmap_wheelson_east");
  scripts\cp\cp_remote_tank::main("veh8_mil_lnd_whotel", "veh_pac_sentry_mp", "script_vehicle_mp_collmap_wheelson_west");
  scripts\vehicle\decho::main("veh8_civ_lnd_decho_rebel_2", "techo_physics", "script_vehicle_iw8_decho_white");
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  setup_create_script();
  level thread scripts\cp\crate_drops\cp_crate_drops::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level thread scripts\cp\cp_breach_c4::main();
  level thread scripts\cp\intel\cp_intel::intel_init();
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("dealer2");
  scripts\cp\cp_gameskill::init_gameskill();
  level thread scripts\cp\cp_kidnapper::init_kidnapper_combat_loop();
  level thread scripts\cp\cp_battlechatter::manualinitbattlechatter();
}

function levelobjectives_init() {
  level.objectives_table = "cp/cp_armsdealer_2_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_armsdealer_2_objectives_matrix.csv";
  level.objectiveregistration = &levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function spawn_technicals_for_players() {
  wait 10;
  var0 = spawnStruct();
  var0.origin = (29647.5, -9049.5, -424);
  var0.angles = (0, 120, 0);
  var0.team = "allies";
  scripts\cp_mp\vehicles\technical::technical_create(var0);
  var0 = spawnStruct();
  var0.origin = (17811.5, -22229.5, -210.101);
  var0.angles = (0, 135, 0);
  var0.team = "allies";
  scripts\cp_mp\vehicles\technical::technical_create(var0);
}

function heli_crash_path_loc_setup() {
  wait 2;
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("helicopter_crash_location", "targetname"));
}

function rundebugstartobjective(var0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_wait("strike_init_done");

  if(isDefined(level.objectivestabledata[var0])) {
    var1 = level.objectivestabledata[var0];

    if(isDefined(var1.csdependency)) {
      if(!scripts\engine\utility::flag_exist(var1.csdependency)) {
        scripts\engine\utility::flag_init(var1.csdependency);
      }

      scripts\engine\utility::flag_set(var1.csdependency);

      if(!scripts\engine\utility::flag_exist(var1.csdependency + "_completed")) {
        scripts\engine\utility::flag_init(var1.csdependency + "_completed");
      }

      scripts\engine\utility::flag_wait(var1.csdependency + "_completed");
    }

    if(isDefined(var1.ondebugstartfunc)) {
      [[var1.ondebugstartfunc]](var1);
    }

    thread scripts\cp\cp_objectives::run_objective(var1.objname, var1.questtype);
    return;
  }
}

function levelregisterobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  scripts\engine\utility::flag_wait("interactions_initialized");
  level thread scripts\cp\maps\cp_donetsk\plane_hijack\cp_plane_hijack::main();
  level thread scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_armsdealer::registersafehouse();
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
  register_create_script_arrays("cp_donetsk_arms_dealer_helicopters", "cp_donetsk_arms_dealer_helicopters", level.scripted_spawner_func.size, &scripts\cp\maps\cp_arms_dealer\cp_donetsk_arms_dealer_helicopters::main);
  register_create_script_arrays("cp_donetsk_veh_ground_paths", "cp_donetsk_veh_ground_paths", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_veh_ground_paths::main);
  register_create_script_arrays("cp_donetsk_spawn_parents", "cp_donetsk_spawn_parents", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_spawn_parents::main);
  register_create_script_arrays("cp_donetsk_intel_cs", "cp_donetsk_intel_cs", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_intel_cs::main);
  register_create_script_arrays("cp_crate_drops_cs", "cp_carepackage_crates_cs", level.scripted_spawner_func.size, &scripts\cp\crate_drops\cp_crate_drops_cs::main);
  register_create_script_arrays("cp_plane_hijack_cs", "cp_plane_hijack_cs", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\plane_hijack\cp_plane_hijack_cs::main);
  register_create_script_arrays("cp_donetsk_safehouse_armsdealer_cs", "cp_donetsk_safehouse_armsdealer_cs", level.scripted_spawner_func.size, &scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_armsdealer_cs::main);
}

function register_create_script_arrays(var0, var1, var2, var3) {
  if(isDefined(var0)) {
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var0;
  }

  if(isDefined(var1)) {
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var1;
  }

  if(isDefined(var2)) {
    level.create_script_file_ids[var0] = "cs" + var2;
  }

  if(isDefined(var3)) {
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var3;
    return;
  }
}

function onplayerspawneddevguisetup(var0) {
  var1 = var0.name;
  var2 = undefined;

  foreach(var4 in level.players) {
    if(var4 == var0) {
      var2 = int(var5);
      break;
    }
  }

  if(isDefined(var2)) {
    thread setupdevguientries(var0, var0, var1);
    return;
  }
}

function setupdevguientries(var0, var1, var2) {}

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

function onplayerconnect(var0) {
  var0.gameskill = scripts\cp\cp_gameskill::get_gameskill();
  var0 scripts\cp\cp_gameskill::set_difficulty_from_locked_settings();

  if(getdvarint("force_spawn_veh", 0) != 0) {
    var1 = [(20120, -24623, 1000), (19554, -24184, 1000), (18935, -23685, 1000), (18319, -22907, 1000), (13692, 15239, 1000), (14316, 16296, 1000)];

    foreach(var3 in var1) {
      scripts\cp\vehicles\little_bird_cp::spawn_little_bird_at_location(var3, (0, 0, 0), "allies");
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
    var0 = getDvar("scr_strike_name");
    var1 = undefined;

    switch (var0) {
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

function set_vehicle_settings_on_spawners(var0) {
  var1 = scripts\cp\cp_modular_spawning::process_module_var(var0, var0.spawn_points);

  for(var2 = 0; var2 < var1.size; var2++) {
    var1[var2] scripts\cp\cp_modular_spawning::initialize_as_veh_spawner();
  }
}

function set_interaction_trigger_properties(var0, var1, var2) {
  if(!isDefined(var1.script_noteworthy)) {
    return;
  }

  switch (var1.script_noteworthy) {
    case "radar_struct":
      self.interaction_trigger setusefov(360);
      self.interaction_trigger setuserange(300);
      self.interaction_trigger setCursorHint("HINT_BUTTON");
      self.interaction_trigger sethintdisplayrange(300);
      self.interaction_trigger sethintdisplayfov(90);
      self.interaction_trigger sethintonobstruction("show");
      self.interaction_trigger sethintrequiresholding(0);
      break;
  }
}

function increase_hp_from_relic_mythic() {
  wait 5;
  var0 = spawn("sound_transient_soundbanks", (0, 0, 0));
  var0 settransientsoundbank("cp_op_arms_dealer.all", 1);
}