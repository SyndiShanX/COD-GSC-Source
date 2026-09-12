/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_raid\cp_sv_raid.gsc
*****************************************************/

function main() {
  setdvarifuninitialized("scr_use_squads", 1);
  setdvarifuninitialized("scr_squad_max", 4);
  setdvarifuninitialized("scr_squad_leader_max", 2);
  setdvarifuninitialized("scr_ai_squad_move_type", "1");
  setdvarifuninitialized("scr_smoketest", "0");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\cp\maps\cp_sv_raid\cp_sv_raid_precache::main();
  scripts\cp\maps\cp_sv_raid\gen\cp_sv_raid_art::main();
  scripts\cp\maps\cp_sv_raid\cp_sv_raid_fx::main();
  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);

  if(level.createfx_enabled) {
    return;
  }

  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  level.map_interaction_func = &scripts\cp\maps\cp_sv_raid\cp_sv_raid_interactions::register_interactions;
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_sv_raid/cp_sv_raid_weaponrank_event.csv";
  level.player_interaction_monitor = &scripts\cp\maps\cp_sv_raid\cp_sv_raid_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_sv_raid\cp_sv_raid_interactions::level_specific_wait_for_interaction_triggered;
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

  var_0 = getDvar("cp_sv_raid_start_obj", "");

  if(isDefined(var_0) && var_0 != "") {
    thread rundebugstartobjective(level);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_mp_raid");
  scripts\engine\utility::flag_set("infil_complete");
  thread player_exfil_struct();
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

function onplayerspawned() {}

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
  register_create_script_arrays("cp_sv_raid_create_script", "cp_sv_raid_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_sv_raid\cp_sv_raid_create_script::main);
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

function player_exfil_struct() {
  var_0 = getEntArray("clip32x32x32", "targetname")[0];
  var_1 = spawn("script_model", (-2958, 224, 292));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEntArray("clip32x32x32", "targetname")[0];
  var_3 = spawn("script_model", (-2958, 256, 292));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEntArray("clip128x128x256", "targetname")[0];
  var_5 = spawn("script_model", (-732.75, 1859.25, 268.25));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEntArray("clip32x32x32", "targetname")[0];
  var_7 = spawn("script_model", (-2133, 1986, 400.5));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEntArray("nosight128x128x8", "targetname")[0];
  var_9 = spawn("script_model", (-2974, 2202, 304));
  var_9.angles = (270, 358, -66);
  var_9 clonebrushmodeltoscriptmodel(var_8);
}