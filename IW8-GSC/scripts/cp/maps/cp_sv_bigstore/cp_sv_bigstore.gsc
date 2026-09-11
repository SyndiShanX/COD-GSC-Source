/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sv_bigstore\cp_sv_bigstore.gsc
*************************************************************/

function main() {
  setdvarifuninitialized("scr_use_squads", 1);
  setdvarifuninitialized("scr_squad_max", 4);
  setdvarifuninitialized("scr_squad_leader_max", 2);
  setdvarifuninitialized("scr_ai_squad_move_type", "1");
  setdvarifuninitialized("scr_smoketest", "0");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\cp\maps\cp_sv_bigstore\cp_sv_bigstore_precache::main();
  scripts\cp\maps\cp_sv_bigstore\gen\cp_sv_bigstore_art::main();
  scripts\cp\maps\cp_sv_bigstore\cp_sv_bigstore_fx::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  setDvar("NPONLLLSPL", 0.4);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 2);
  setDvar("TMNTMTQRM", 0);
  setDvar("LKOLRONRNQ", 1000);
  setDvar("LTQMSPKRKO", 6);
  setDvar("MROOOROPKL", 8);
  setDvar("PKKMTTRQO", 8);

  if(level.createfx_enabled) {
    return;
  }

  scripts\cp\cp_modular_spawning::mousetrapsfound();
  scripts\common\vehicle::init_vehicles();
  scripts\cp\vehicle::init_vehicles();
  level.map_interaction_func = &scripts\cp\maps\cp_sv_bigstore\cp_sv_bigstore_interactions::register_interactions;
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_sv_bigstore/cp_sv_bigstore_weaponrank_event.csv";
  level.player_interaction_monitor = &scripts\cp\maps\cp_sv_bigstore\cp_sv_bigstore_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_sv_bigstore\cp_sv_bigstore_interactions::level_specific_wait_for_interaction_triggered;
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

  var0 = getDvar("cp_sv_bigstore_start_obj", "");

  if(isDefined(var0) && var0 != "") {
    thread rundebugstartobjective(level);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_mp_emporium");
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

function onplayerspawned() {}

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
  register_create_script_arrays("cp_sv_bigstore_create_script", "cp_sv_bigstore_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_sv_bigstore\cp_sv_bigstore_create_script::main);
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