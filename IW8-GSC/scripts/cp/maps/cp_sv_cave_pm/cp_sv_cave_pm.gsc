/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_cave_pm\cp_sv_cave_pm.gsc
***********************************************************/

function main() {
  setdvarifuninitialized("scr_use_squads", 1);
  setdvarifuninitialized("scr_squad_max", 4);
  setdvarifuninitialized("scr_squad_leader_max", 2);
  setdvarifuninitialized("scr_ai_squad_move_type", "1");
  setdvarifuninitialized("scr_smoketest", "0");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\cp\maps\cp_sv_cave_pm\cp_sv_cave_pm_precache::main();
  scripts\cp\maps\cp_sv_cave_pm\gen\cp_sv_cave_pm_art::main();
  scripts\cp\maps\cp_sv_cave_pm\cp_sv_cave_pm_fx::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\cp\utility\player::overridevisionsetnightforlevel("nvg_base_mp_cave");
  level.disable_nvg = undefined;
  scripts\cp\survival\survival_loadout::initnightvisionheadoverrides();
  setDvar("sm_spotDistCull", 500);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 1024);
  setDvar("r_tessellationFactor", 45);
  setDvar("cg_defaultWindFrequencyScale", 2);
  setDvar("cg_defaultWindAmplitudeScale", 5);
  setDvar("fx_lights_intensity_scale", 2);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  thread destructibletrucksetup("destructibleTruck01", "truckHeadlights01", "destructibleTruck01_edges", "destructibleTruck01_edges_dst", 51);
  thread destructibletrucksetup("destructibleTruck02", "truckHeadlights02", "destructibleTruck02_edges", "destructibleTruck02_edges_dst", 52);
  thread player_fired_gun_monitor();

  if(level.createfx_enabled) {
    return;
  }

  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  level.map_interaction_func = &scripts\cp\maps\cp_sv_cave_pm\cp_sv_cave_pm_interactions::register_interactions;
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_sv_cave_pm/cp_sv_cave_pm_weaponrank_event.csv";
  level.player_interaction_monitor = &scripts\cp\maps\cp_sv_cave_pm\cp_sv_cave_pm_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_sv_cave_pm\cp_sv_cave_pm_interactions::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = &interaction_trigger_properties;

  if(!scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_init("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  scripts\cp\cp_gameskill::init_gameskill();
  thread wait_for_pre_game_period();
  thread wait_for_strike_init_complete();
  level thread scripts\cp\cp_objectives::objectives_init();
  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];
  thread setup_map_specific_devgui();
  setup_create_script();
  level.devgui_setup_func = &onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_init("infil_complete");
  }

  var_0 = getDvar("cp_sv_cave_pm_start_obj", "");

  if(isDefined(var_0) && var_0 != "") {
    thread rundebugstartobjective(level);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_mp_cave");

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    visionsetpain("pain_mp_night", 0);
  } else {
    visionsetpain("pain_mp", 0);
  }

  scripts\engine\utility::flag_set("infil_complete");
}

function rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("objective_table_parsed");

  if(isDefined(level.objectivestabledata[var_0])) {
    var_1 = level.objectivestabledata[var_0];

    if(isDefined(var_1.ondebugstartfunc)) {
      [[var_1.ondebugstartfunc]](var_1);
    }

    thread scripts\cp\cp_objectives::run_objective(var_1.objname, var_1.questtype);
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
}

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

function registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

function onplayerconnect(var_0) {
  thread bug_test_move_startpoint();
}

function onplayerspawned() {
  thread scripts\cp\equipment\nvg::ref_13830();
}

function bug_test_move_startpoint() {
  if(getdvarint("scr_linkto_test", 0)) {
    var_0 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

    foreach(var_2 in var_0) {
      var_2.origin = (3743, -1008, 384);
      var_2.angles = (6, 265, 0);
    }

    return;
  }
}

function should_run_event(var_0) {
  return false;
}

function setup_map_specific_devgui() {}

function interaction_trigger_properties(var_0, var_1, var_2) {
  switch (var_1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var_1.useduration)) {
        self.interaction_trigger setuseholdduration(var_1.useduration);
      }

      break;
  }
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
  register_create_script_arrays("cp_sv_cave_pm_create_script", "cp_sv_cave_pm_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_sv_cave_pm\cp_sv_cave_pm_create_script::main);
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

function destructibletrucksetup(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  wait 5;
  var_5 = getscriptablearray(var_0, "targetname");
  var_6 = getEnt(var_2, "targetname");
  var_7 = getEnt(var_3, "targetname");
  var_8 = getEntArray(var_1, "targetname");
  var_7 hide();
  scripts\engine\utility::exploder(var_4);

  if(isDefined(var_5) && isDefined(var_5[0])) {
    var_9 = var_5[0];
    var_10 = 1;

    while(var_10) {
      var_9 waittill("scriptableNotification", var_11, var_12);

      switch (var_11) {
        case "vehicle_death":
        case "onfire":
        case "flareup":
          trucklightsoff(var_8);
          var_10 = 0;
          scripts\engine\utility::kill_exploder(var_4);
          var_7 show();
          var_6 hide();
          return;
        case "anim_explosion":
          trucklightsoff(var_8);
          var_10 = 0;
          scripts\engine\utility::kill_exploder(var_4);
          var_7 show();
          var_6 hide();
          return;
      }
    }

    return;
  }
}

function trucklightsoff(var_0) {
  foreach(var_2 in var_0) {
    var_2 setlightintensity(0);
  }
}

function player_fired_gun_monitor() {
  var_0 = spawn("script_model", (1592, 561, 176));
  var_0 setModel("me_construction_plank_bridge_a_11");
  var_0.angles = (85.3, 326, -11);
  var_1 = spawn("script_model", (-1034, 844, 92));
  var_1 setModel("me_construction_plank_bridge_a_11");
  var_1.angles = (0, 275, -90);
  var_2 = spawn("script_model", (3715, 1658.5, 262));
  var_2 setModel("me_construction_plank_bridge_a_11");
  var_2.angles = (272, 145, -90);
  var_3 = spawn("script_model", (-1061, 917.5, 112));
  var_3 setModel("hardware_plywood_bare_01_24_dirty");
  var_3.angles = (270, 0, 0);
  var_4 = getEnt("tactical_cover_col", "targetname");
  var_5 = spawn("script_model", (1768, 2128, 80));
  var_5.angles = (0, 255, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("clip32x32x32", "targetname");
  var_5 = spawn("script_model", (3781.5, 2369, 45));
  var_5.angles = (358.097, 255.001, -0.026);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("clip32x32x32", "targetname");
  var_5 = spawn("script_model", (3773, 2338.5, 46));
  var_5.angles = (358.097, 255.001, -0.026);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("clip32x32x32", "targetname");
  var_5 = spawn("script_model", (3820, 2358.5, 45));
  var_5.angles = (358.097, 255.001, -0.026);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("clip32x32x32", "targetname");
  var_5 = spawn("script_model", (3811.5, 2328, 46));
  var_5.angles = (358.097, 255.001, -0.026);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("clip64x64x256", "targetname");
  var_5 = spawn("script_model", (1480.32, -650.161, 191.671));
  var_5.angles = (0, 14.679, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("clip64x64x256", "targetname");
  var_5 = spawn("script_model", (1418.32, -666.661, 191.671));
  var_5.angles = (0, 14.679, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("clip64x64x64", "targetname");
  var_5 = spawn("script_model", (-896.647, 1289.06, 58.5));
  var_5.angles = (0, 205, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_4 = getEnt("clip64x64x64", "targetname");
  var_5 = spawn("script_model", (-958.647, 1260.06, 58.5));
  var_5.angles = (0, 205, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
}