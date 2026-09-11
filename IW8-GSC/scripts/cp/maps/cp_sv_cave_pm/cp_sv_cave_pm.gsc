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
  setDvar("LKOLRONRNQ", 500);
  setDvar("PKKMTTRQO", 8);
  setDvar("NKLMONNPNN", 1024);
  setDvar("NOSQLKNSQO", 45);
  setDvar("MRNRKKOPLN", 2);
  setDvar("MQPQKNPQOK", 5);
  setDvar("NQNQPRLRQM", 2);
  setDvar("NSSMQLPRNT", 0.01);
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

  var0 = getDvar("cp_sv_cave_pm_start_obj", "");

  if(isDefined(var0) && var0 != "") {
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

function rundebugstartobjective(var0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("objective_table_parsed");

  if(isDefined(level.objectivestabledata[var0])) {
    var1 = level.objectivestabledata[var0];

    if(isDefined(var1.ondebugstartfunc)) {
      [[var1.ondebugstartfunc]](var1);
    }

    thread scripts\cp\cp_objectives::run_objective(var1.objname, var1.questtype);
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
}

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

function registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

function onplayerconnect(var0) {
  thread bug_test_move_startpoint();
}

function onplayerspawned() {
  thread scripts\cp\equipment\nvg::ref_13830();
}

function bug_test_move_startpoint() {
  if(getdvarint("scr_linkto_test", 0)) {
    var0 = scripts\engine\utility::getStructArray("default_player_start", "targetname");

    foreach(var2 in var0) {
      var2.origin = (3743, -1008, 384);
      var2.angles = (6, 265, 0);
    }

    return;
  }
}

function should_run_event(var0) {
  return false;
}

function setup_map_specific_devgui() {}

function interaction_trigger_properties(var0, var1, var2) {
  switch (var1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var1.useduration)) {
        self.interaction_trigger setuseholdduration(var1.useduration);
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

function destructibletrucksetup(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  wait 5;
  var5 = getscriptablearray(var0, "targetname");
  var6 = getEnt(var2, "targetname");
  var7 = getEnt(var3, "targetname");
  var8 = getEntArray(var1, "targetname");
  var7 hide();
  scripts\engine\utility::exploder(var4);

  if(isDefined(var5) && isDefined(var5[0])) {
    var9 = var5[0];
    var10 = 1;

    while(var10) {
      var9 waittill("scriptableNotification", var11, var12);

      switch (var11) {
        case "vehicle_death":
        case "onfire":
        case "flareup":
          trucklightsoff(var8);
          var10 = 0;
          scripts\engine\utility::kill_exploder(var4);
          var7 show();
          var6 hide();
          return;
        case "anim_explosion":
          trucklightsoff(var8);
          var10 = 0;
          scripts\engine\utility::kill_exploder(var4);
          var7 show();
          var6 hide();
          return;
      }
    }

    return;
  }
}

function trucklightsoff(var0) {
  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }
}

function player_fired_gun_monitor() {
  var0 = spawn("script_model", (1592, 561, 176));
  var0 setModel("me_construction_plank_bridge_a_11");
  var0.angles = (85.3, 326, -11);
  var1 = spawn("script_model", (-1034, 844, 92));
  var1 setModel("me_construction_plank_bridge_a_11");
  var1.angles = (0, 275, -90);
  var2 = spawn("script_model", (3715, 1658.5, 262));
  var2 setModel("me_construction_plank_bridge_a_11");
  var2.angles = (272, 145, -90);
  var3 = spawn("script_model", (-1061, 917.5, 112));
  var3 setModel("hardware_plywood_bare_01_24_dirty");
  var3.angles = (270, 0, 0);
  var4 = getEnt("tactical_cover_col", "targetname");
  var5 = spawn("script_model", (1768, 2128, 80));
  var5.angles = (0, 255, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var4 = getEnt("clip32x32x32", "targetname");
  var5 = spawn("script_model", (3781.5, 2369, 45));
  var5.angles = (358.097, 255.001, -0.026);
  var5 clonebrushmodeltoscriptmodel(var4);
  var4 = getEnt("clip32x32x32", "targetname");
  var5 = spawn("script_model", (3773, 2338.5, 46));
  var5.angles = (358.097, 255.001, -0.026);
  var5 clonebrushmodeltoscriptmodel(var4);
  var4 = getEnt("clip32x32x32", "targetname");
  var5 = spawn("script_model", (3820, 2358.5, 45));
  var5.angles = (358.097, 255.001, -0.026);
  var5 clonebrushmodeltoscriptmodel(var4);
  var4 = getEnt("clip32x32x32", "targetname");
  var5 = spawn("script_model", (3811.5, 2328, 46));
  var5.angles = (358.097, 255.001, -0.026);
  var5 clonebrushmodeltoscriptmodel(var4);
  var4 = getEnt("clip64x64x256", "targetname");
  var5 = spawn("script_model", (1480.32, -650.161, 191.671));
  var5.angles = (0, 14.679, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var4 = getEnt("clip64x64x256", "targetname");
  var5 = spawn("script_model", (1418.32, -666.661, 191.671));
  var5.angles = (0, 14.679, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var4 = getEnt("clip64x64x64", "targetname");
  var5 = spawn("script_model", (-896.647, 1289.06, 58.5));
  var5.angles = (0, 205, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
  var4 = getEnt("clip64x64x64", "targetname");
  var5 = spawn("script_model", (-958.647, 1260.06, 58.5));
  var5.angles = (0, 205, 0);
  var5 clonebrushmodeltoscriptmodel(var4);
}