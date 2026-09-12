/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_estate\cp_so_estate.gsc
*********************************************************/

function main() {
  init_flags();
  select_bridge_one_spawners();
  setdvarifuninitialized("scr_use_squads", 1);
  setdvarifuninitialized("scr_squad_max", 4);
  setdvarifuninitialized("scr_squad_leader_max", 2);
  setdvarifuninitialized("scr_ai_squad_move_type", "1");
  setdvarifuninitialized("scr_smoketest", "0");
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\cp\maps\cp_so_estate\cp_so_estate_precache::main();
  scripts\cp\maps\cp_so_estate\gen\cp_so_estate_art::main();
  scripts\cp\maps\cp_so_estate\cp_so_estate_fx::main();
  scripts\engine\utility::flag_init("scriptables_ready");
  scripts\vehicle\decho::main("veh8_civ_lnd_decho_dirty_tan_physics", "decho_physics_sp_minimap", "script_vehicle_iw8_decho_tandirty_physics");
  scripts\vehicle\mindia8::main("veh8_mil_air_mindia8_barkov", "mindia8_minimap", "script_vehicle_iw8_mindia8_east");
  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);

  if(level.createfx_enabled) {
    return;
  }

  scripts\cp\vehicle::init_vehicles();
  scripts\common\vehicle::init_vehicles();
  level.objectivesfunc = &levelobjectives_init;
  level thread scripts\cp\cp_objectives::objectives_init();
  level scripts\cp\cp_hud_message::init_cp_hud_message();
  level.ref_12177 = 1;
  level.hostdamagefactorlow = 0;
  level.ref_133ba = 1;
  level.map_interaction_func = &scripts\cp\maps\cp_so_estate\cp_so_estate_interactions::register_interactions;
  level.custom_onspawnplayer_func = &ref_124f3;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_so_estate/cp_so_estate_weaponrank_event.csv";
  level.player_interaction_monitor = &scripts\cp\maps\cp_so_estate\cp_so_estate_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_so_estate\cp_so_estate_interactions::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = &interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = &ref_1247b;

  if(!scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_init("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  thread wait_for_pre_game_period();
  thread wait_for_strike_init_complete();
  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];
  thread setup_map_specific_devgui();
  setup_create_script();
  level.devgui_setup_func = &onplayerspawneddevguisetup;
  scripts\cp\laser_traps\cp_laser_traps::ref_131f6();

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_init("infil_complete");
  }

  var_0 = getDvar("cp_so_estate_start_obj", "");

  if(isDefined(var_0) && var_0 != "") {
    thread rundebugstartobjective(level);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_cp_so_estate");
  scripts\engine\utility::flag_set("infil_complete");
  thread ref_1369f();
  thread ref_12daa();
  thread light_tank_gunnerdamagemodignorefunc();
  level.waittill_wave_spawned_or_timeout = gettime();
  level.shouldgodirectlytospectatefunc = &ref_11e55;
}

function ref_11e55(var_0) {
  return false;
}

function select_bridge_one_spawners() {
  level.trial_fobs_cleared = 0;
}

function init_flags() {
  scripts\engine\utility::flag_init("game_started");
  scripts\engine\utility::flag_init("vehicle_spawned");
  scripts\engine\utility::flag_init("spawning_ready");
  scripts\engine\utility::flag_init("intel_collected");
  scripts\engine\utility::flag_init("intel_being_carried");
  scripts\engine\utility::flag_init("left_objective_radius");
  scripts\engine\utility::flag_init("intel_captured_courtyard");
  scripts\engine\utility::flag_init("intel_captured_trucks");
  scripts\engine\utility::flag_init("intel_captured_sidehouse");
  scripts\engine\utility::flag_init("intel_captured_church");
  scripts\engine\utility::flag_init("intel_captured_mainhouse");
  scripts\engine\utility::flag_init("gate_closed");
}

function levelobjectives_init() {
  level.objectives_table = "cp/cp_so_estate_objectives.csv";
  level.objectiveregistration = &levelregisterobjectives;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function levelregisterobjectives() {}

function ref_124f3() {
  scripts\cp\gametypes\cp_specops::givedefaultloadout();
  self clearaccessory();
  self takeallweapons();
  self setsuit("iw8_suit_cp");
  var_0 = "iw8_ar_mike4_mp";
  var_1 = scripts\cp\cp_weapon::buildweapon(var_0, ["selectsemi", "laserir", "xmags_mike4", "barcust2_mike4", "glincendiary", "flashhider", "stocks_mike4"], "none", "none", 1);
  self giveweapon(var_1);
  self setweaponammoclip(var_1, weaponclipsize(var_1));
  self setweaponammostock(var_1, weaponmaxammo(var_1));
  self switchtoweapon(var_1);
  self.last_stand_pistol = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911_mp", [], "none", "none", -1);
  self giveweapon(self.last_stand_pistol);
  self setweaponammoclip(self.last_stand_pistol, weaponclipsize(self.last_stand_pistol));
  self setweaponammostock(self.last_stand_pistol, weaponmaxammo(self.last_stand_pistol));
  thread scripts\cp\cp_powers::givepower("power_frag", "primary", undefined, undefined, undefined, undefined, 1, 4);
  thread scripts\cp\cp_powers::givepower("power_snapshotGrenade", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  self.weaponlist = self getweaponslistprimaries();
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0])) {
    self.primaryweaponobj = self.weaponlist[0];
  }

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1])) {
    self.secondaryweaponobj = self.weaponlist[1];
  }

  var_2 = self;
  var_2.loadoutaccessoryweapon = var_2 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var_2.loadoutaccessorydata = var_2 scripts\cp\cp_loadout::cac_getaccessorydata();
  var_2.loadoutaccessorylogic = var_2 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var_2.loadoutaccessorydata) && isDefined(var_2.loadoutaccessoryweapon) && var_2.loadoutaccessoryweapon != "none") {
    var_2 scripts\cp\cp_accessories::giveplayeraccessory(var_2.loadoutaccessorydata, var_2.loadoutaccessoryweapon, var_2.loadoutaccessorylogic);
  }

  self setclientomnvar("ui_hide_minimap", 0);
  self.ref_12544 = [];
  level.hostdamagefactorlow++;

  if(!scripts\engine\utility::flag("game_started")) {
    self allowmovement(0);
  }

  thread scripts\cp\laser_traps\cp_laser_traps::mountain_three_death_func();
}

function ref_1247b(var_0) {}

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
  scripts\cp\cp_objectives::registerobjective("map_restart", undefined, undefined, undefined, undefined, undefined);
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
  register_create_script_arrays("cp_so_estate_create_script", "cp_so_estate_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_so_estate\cp_so_estate_create_script::main);
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

function ref_12daa() {
  while(level.hostdamagefactorlow < 1) {
    waitframe();
  }

  var_0 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(scripts\engine\utility::getStruct("start_tarp_loc1", "script_noteworthy").origin, scripts\engine\utility::getStruct("start_tarp_loc2", "script_noteworthy").angles);
  setheadiconsnaptoedges(var_0.headiconid, 400);
  var_1 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(scripts\engine\utility::getStruct("start_tarp_loc2", "script_noteworthy").origin, scripts\engine\utility::getStruct("start_tarp_loc3", "script_noteworthy").angles);
  setheadiconsnaptoedges(var_1.headiconid, 400);
  var_2 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime(scripts\engine\utility::getStruct("start_tarp_loc3", "script_noteworthy").origin, scripts\engine\utility::getStruct("start_tarp_loc2", "script_noteworthy").angles);
  setheadiconsnaptoedges(var_2.headiconid, 400);
  var_3 = scripts\cp\laser_traps\cp_laser_traps::ref_13433(scripts\engine\utility::getStruct("start_tarp_loc4", "script_noteworthy").origin, scripts\engine\utility::getStruct("start_tarp_loc3", "script_noteworthy").angles);
  setheadiconsnaptoedges(var_3.headiconid, 400);
  var_4 = [["box_spawn_1", "ammo", 1], ["box_spawn_2", "frag", 1], ["box_spawn_3", "ammo", 1], ["box_spawn_4", "frag", 1], ["box_spawn_5", "snapshot", 1], ["box_spawn_6", "molotov", 1], ["box_spawn_7", "ammo", 1], ["box_spawn_8", "frag", 1], ["box_spawn_9", "snapshot", 1], ["box_spawn_10", "ammo", 1], ["box_spawn_11", "ammo", 1], ["box_spawn_12", "gas", 1], ["box_spawn_13", "ammo", 1], ["box_spawn_14", "frag", 1], ["box_spawn_15", "stim", 1], ["box_spawn_16", "snapshot", 1], ["box_spawn_17", "stim", 1], ["box_spawn_18", "gas", 1], ["box_spawn_19", "c4", 1], ["box_spawn_20", "c4", 1], ["box_spawn_21", "stim", 1], ["box_spawn_22", "molotov", 1], ["box_spawn_23", "stim", 1]];
  ref_13513(var_4);
  thread ref_135b4();
  scripts\engine\utility::flag_wait("vehicle_spawned");
  scripts\cp\laser_traps\cp_laser_traps::ref_1437a();
  scripts\engine\utility::flag_set("game_started");

  foreach(var_6 in level.players) {
    var_6 allowmovement(1);
  }

  scripts\cp\laser_traps\cp_laser_traps::ref_13067();
  thread ref_13523("mainhouse_mine_spawn");
  level.brclosealldoors = 0;
  level.audio_jugg_death = [];
  intro();
  incendiary_pickup_watcher();
  ref_13df5();
  ref_1338e();
  ref_11a71();
  oil_puddles();
}

function intro() {
  var_0 = [[[4, "ar"]], [[6, "ar"]], [[8, "ar"]], [[10, "ar"]]];
  ref_1321a("courtyard_chopper_target", var_0, 0);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SO_ESTATE/MISSION_INSTRUCTIONS", "allies", 10);
  thread ref_12758("dx_cps_kama_mobile_heist_nag_find_phones_20");
  scripts\engine\utility::flag_wait("spawning_ready");
  ref_122f7();
  var_1 = scripts\common\utility::getvehiclespawner("courtyard_chopper_1", "targetname");
  var_2 = var_1 scripts\common\utility::spawn_vehicle();
  var_2.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_2);
  thread ref_14352(var_2);
  thread heli_crash_on_pilot_death();
  thread heli_death_thread();
  var_3 = scripts\common\utility::getvehiclespawner("intro1_chopper_1", "targetname");
  var_4 = var_3 scripts\common\utility::spawn_vehicle();
  var_4.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_4);
  thread heli_death_thread();
  var_5 = scripts\common\utility::getvehiclespawner("intro2_chopper_1", "targetname");
  var_6 = var_5 scripts\common\utility::spawn_vehicle();
  var_6.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_6);
  thread heli_death_thread();
  wait 6;
}

function ref_122f7() {}

function incendiary_pickup_watcher() {
  thread ref_12758("dx_mpa_ustl_order_attack");
  ref_131f3(0);
  var_0 = [["es_courtyard_front_1", "ar", 1], ["es_courtyard_front_2", "ar", 1], ["es_courtyard_front_3", "ar", 1, undefined, ["close", 1000]], ["es_courtyard_front_4", "ar", 2], ["es_courtyard_front_5", "ar", 2], ["es_courtyard_front_6", "ar", 3], ["es_courtyard_front_7", "ar", 4, undefined, ["close", 1000]], ["es_courtyard_side_1", "ar", 1, undefined, ["close", 1000]], ["es_courtyard_side_2", "ar", 2, undefined, ["close", 1000]], ["es_courtyard_side_3", "ar", 3, undefined, ["close", 1000]], ["es_courtyard_upper_mid", "smg", 1, undefined, ["close", 800]], ["es_courtyard_upper_left_1", "ar", 3], ["es_courtyard_upper_left_2", "ar", 2], ["es_courtyard_upper_left_3", "shotgun", 1, undefined, ["close", 600]], ["es_courtyard_upper_left_4", "shotgun", 4], ["es_courtyard_upper_right_1", "ar", 3], ["es_courtyard_upper_right_2", "ar", 2], ["es_courtyard_upper_right_3", "shotgun", 1, undefined, ["close", 600]], ["es_courtyard_upper_right_4", "shotgun", 4], ["es_courtyard_lower_mid", "ar", 1], ["es_courtyard_lower_left_1", "ar", 3], ["es_courtyard_lower_left_2", "ar", 3], ["es_courtyard_lower_left_3", "ar", 4], ["es_courtyard_lower_left_4", "shotgun", 4, undefined, ["close", 600]], ["es_courtyard_lower_right_1", "ar", 3], ["es_courtyard_lower_right_2", "ar", 3], ["es_courtyard_lower_right_3", "ar", 4], ["es_courtyard_lower_right_4", "shotgun", 4, undefined, ["close", 600]]];
  thread ref_134ed(var_0, 0);
  var_1 = [[[[1, "smg"], [1, "ar"]], [[2, "smg"], [1, "ar"]], [[3, "smg"], [1, "ar"]], [[4, "smg"], [2, "ar"]]]];
  var_2 = ["courtyard_right", "courtyard_rear"];
  var_3 = ["pool", "greenhouse", "sidehouse"];
  thread player_sees_hvt_leaving_vo("intel_collected", "courtyard_all", var_2, var_3, var_1);
  scripts\engine\utility::flag_wait("intel_collected");
  var_1 = [[[[1, "shotgun"], [2, "ar"]], [[1, "shotgun"], [4, "ar"]], [[1, "shotgun"], [6, "ar"]], [[2, "shotgun"], [6, "ar"]]], [[[2, "smg"], [1, "ar"]], [[2, "smg"], [2, "ar"]], [[4, "smg"], [3, "ar"]], [[4, "smg"], [4, "ar"]]]];
  var_2 = ["greenhouse", "sidehouse", "church"];
  var_3 = ["pool", "center"];
  thread player_sees_hvt_leaving_vo("intel_captured_courtyard", undefined, var_2, var_3, var_1);
  scripts\engine\utility::flag_wait_either("intel_captured_courtyard", "left_objective_radius");
}

function ref_13df5() {
  thread ref_14344();
  var_0 = [["es_trucks_defend_1", "ar", 1], ["es_trucks_defend_2", "ar", 1, undefined, ["close", 600]], ["es_trucks_defend_3", "lmg", 2], ["es_trucks_defend_4", "ar", 1], ["es_trucks_defend_5", "ar", 2], ["es_trucks_defend_6", "ar", 2], ["es_trucks_defend_7", "ar", 3], ["es_trucks_defend_8", "lmg", 3], ["es_trucks_defend_9", "ar", 4], ["es_trucks_defend_10", "ar", 4]];
  thread ref_134ed(var_0, 1);
  thread ref_14347();
  scripts\engine\utility::flag_wait("intel_captured_courtyard");
  ref_131f3(1);
  thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(10000, 10000, (0, 90, 0), scripts\engine\utility::getStruct("carepackage_center", "targetname").origin, "precision_airstrike", &ref_1249a);
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpo_usop_airdrop_use");
  var_1 = [[[[1, "smg"], [1, "ar"]], [[2, "smg"], [1, "ar"]], [[3, "smg"], [1, "ar"]], [[4, "smg"], [2, "ar"]]]];
  var_2 = ["shed_wall"];
  var_3 = ["shed_wall"];
  thread player_sees_hvt_leaving_vo("intel_collected", "shed_all", var_2, var_3, var_1);

  if(!scripts\engine\utility::flag("intel_collected")) {
    var_4 = getEnt("garden_defend", "targetname");

    while(!trial_turret_thread_func(var_4)) {
      waitframe();
    }
  }

  var_2 = ["pool", "main_lower"];
  var_3 = ["monument", "church", "sidehouse"];
  var_5 = [["es_trucks_window_front", "sniper", 2], ["es_sniper_balcony_1", "sniper", 1], ["es_sniper_balcony_2", "sniper", 3], ["es_sniper_balcony_3", "sniper", 3], ["es_trucks_window_side_1", "sniper", 1], ["es_trucks_window_side_2", "sniper", 4]];
  thread ref_134ed(var_5, 1);
  var_6 = [[[4, "ar"]], [[6, "ar"]], [[8, "ar"]], [[10, "ar"]]];
  ref_1321a("garden_chopper_target", var_6, 1);
  var_7 = scripts\common\utility::getvehiclespawner("garden_chopper_1", "targetname");
  var_8 = var_7 scripts\common\utility::spawn_vehicle();
  var_8.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_8);
  thread heli_crash_on_pilot_death();
  thread heli_death_thread();
  thread ref_14352(var_8);
  scripts\engine\utility::flag_wait("intel_collected");
  var_1 = [[[[1, "smg"], [2, "ar"]], [[1, "smg"], [4, "ar"]], [[1, "smg"], [6, "ar"]], [[2, "smg"], [6, "ar"]]], [[[1, "smg"], [2, "ar"]], [[2, "smg"], [2, "ar"], [1, "lmg"]], [[2, "smg"], [4, "ar"], [1, "lmg"]], [[3, "smg"], [4, "ar"], [2, "lmg"]]], [[[1, "smg"], [2, "ar"]], [[2, "smg"], [2, "ar"], [1, "shotgun"]], [[2, "smg"], [4, "ar"], [1, "shotgun"]], [[2, "smg"], [5, "ar"], [1, "shotgun"]]]];
  var_2 = ["pool", "main_lower"];
  var_3 = ["monument", "church", "sidehouse"];
  thread player_sees_hvt_leaving_vo("intel_captured_trucks", undefined, var_2, var_3, var_1);
  scripts\engine\utility::flag_wait_either("intel_captured_trucks", "left_objective_radius");
}

function ref_1338e() {
  var_0 = [["es_sidehouse_defend_front_1", "ar", 1, undefined, ["close", 600]], ["es_sidehouse_defend_front_2", "ar", 1, undefined, ["close", 600]], ["es_sidehouse_defend_front_3", "ar", 2]];
  thread ref_134ed(var_0, 2);
  var_1 = getEnt("map_left_side", "targetname");
  thread ref_14346(var_1);
  scripts\engine\utility::flag_wait("intel_captured_trucks");
  ref_131f3(2);
  thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(10000, 10000, (0, 90, 0), scripts\engine\utility::getStruct("carepackage_greenhouse", "targetname").origin, "sentry", &ref_1249b);
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpo_usop_airdrop_use");

  while(callback_subscribe(var_1)) {
    waitframe();
  }

  thread ref_12758("dx_mpa_ustl_hint_killall");
  var_2 = [[[[1, "smg"], [1, "ar"]], [[2, "smg"], [1, "ar"]], [[3, "smg"], [1, "ar"]], [[4, "smg"], [2, "ar"]]]];
  var_3 = ["greenhouse", "courtyard_lower"];
  var_4 = ["greenhouse_back", "garden", "main_lower"];
  thread player_sees_hvt_leaving_vo("intel_collected", "sidehouse_all", var_3, var_4, var_2);
  var_5 = [["es_sidehouse_defend_interior_1", "ar", 1, "molotov", ["close", 800]], ["es_sidehouse_defend_interior_2", "ar", 2, "flash"], ["es_sidehouse_defend_interior_3", "ar", 2, "molotov"], ["es_sidehouse_defend_interior_4", "shotgun", 1, "molotov", ["close", 600]], ["es_sidehouse_defend_interior_5", "ar", 3, "flash"], ["es_sidehouse_defend_interior_6", "ar", 1, "flash"], ["es_sidehouse_defend_interior_7", "smg", 4, "flash"], ["es_sidehouse_defend_courtyard_1", "shotgun", 1, "flash", ["advance", 800]], ["es_sidehouse_defend_courtyard_2", "ar", 2, "molotov"], ["es_sidehouse_defend_courtyard_3", "ar", 3, "molotov"], ["es_sidehouse_defend_pool_1", "smg", 1, "molotov"], ["es_sidehouse_defend_pool_2", "ar", 1, "flash"], ["es_sidehouse_defend_pool_3", "ar", 2, "flash"], ["es_sidehouse_defend_pool_4", "juggernaut", 3, "flash", ["close", 800]], ["es_sidehouse_defend_pool_5", "ar", 1, "molotov"], ["es_sidehouse_defend_pool_6", "ar", 3, "molotov"], ["es_sidehouse_defend_pool_7", "smg", 4, "molotov", ["close", 800]], ["es_sidehouse_defend_pool_roof_1", "rpg", 1, "flash"], ["es_sidehouse_defend_pool_roof_2", "sniper", 2, "molotov"], ["es_sidehouse_defend_pool_roof_3", "rpg", 3, "flash"], ["es_sidehouse_defend_pool_roof_4", "sniper", 4, "flash"]];
  thread ref_134ed(var_5, 2);
  scripts\engine\utility::flag_wait("intel_collected");
  var_2 = [[[[1, "shotgun"], [2, "ar"]], [[1, "shotgun"], [4, "ar"]], [[1, "shotgun"], [6, "ar"]], [[2, "shotgun"], [6, "ar"]]], [[[2, "smg"], [1, "ar"]], [[2, "smg"], [2, "ar"]], [[4, "smg"], [3, "ar"]], [[4, "smg"], [4, "ar"]]], [[[2, "smg"], [1, "lmg"], [1, "shotgun"]], [[2, "smg"], [2, "lmg"], [2, "shotgun"]], [[4, "smg"], [2, "lmg"], [3, "shotgun"]], [[4, "smg"], [3, "lmg"], [4, "shotgun"]]]];
  var_3 = ["greenhouse", "courtyard_lower"];
  var_4 = ["greenhouse_back", "garden", "main_lower"];
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_cps_lass_callout_enemy_squad_spawning_30");
  thread player_sees_hvt_leaving_vo("intel_captured_sidehouse", undefined, var_3, var_4, var_2);
  var_6 = [[[4, "ar"]], [[6, "ar"]], [[8, "ar"]], [[10, "ar"]]];
  ref_1321a("center_chopper_target", var_6, 3);
  var_7 = scripts\common\utility::getvehiclespawner("center_chopper_1", "targetname");
  var_8 = var_7 scripts\common\utility::spawn_vehicle();
  var_8.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_8);
  thread heli_crash_on_pilot_death();
  thread heli_death_thread();
  thread ref_14352(var_8);
  scripts\engine\utility::flag_wait_either("intel_captured_sidehouse", "left_objective_radius");
}

function ref_11a71() {
  scripts\engine\utility::flag_wait("intel_captured_sidehouse");
  thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(10000, 10000, (0, 90, 0), scripts\engine\utility::getStruct("carepackage_church", "targetname").origin, "sentry", &ref_1249b);
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpo_usop_airdrop_use");
  var_0 = [["es_mainhouse_churchroof_1", "rpg", 1], ["es_mainhouse_churchroof_2", "rpg", 3], ["es_main_defend_lower_1", "ar", 1], ["es_main_defend_lower_2", "smg", 2, undefined, ["close", 800]], ["es_main_defend_lower_3", "ar", 2], ["es_main_defend_lower_4", "ar", 3], ["es_main_defend_lower_5", "shotgun", 1, undefined, ["close", 600]], ["es_main_defend_lower_6", "shotgun", 3], ["es_main_defend_lower_7", "lmg", 1], ["es_main_defend_lower_8", "smg", 4], ["es_main_defend_lower_9", "juggernaut", 3], ["es_main_defend_mid_2", "ar", 1], ["es_main_defend_mid_3", "shotgun", 2, undefined, ["close", 800]], ["es_main_defend_mid_4", "smg", 1], ["es_main_defend_mid_5", "smg", 2], ["es_main_defend_mid_6", "ar", 3, undefined, ["close", 800]], ["es_main_defend_mid_7", "ar", 3], ["es_main_defend_mid_8", "lmg", 4]];
  thread ref_134ed(var_0, 3);
  var_1 = [[[[1, "smg"], [1, "ar"]], [[2, "smg"], [1, "ar"]], [[3, "smg"], [1, "ar"]], [[4, "smg"], [2, "ar"]]]];
  var_2 = ["garden", "shed"];
  var_3 = ["monument", "courtyard_lower", "sidehouse"];
  thread player_sees_hvt_leaving_vo("intel_collected", "mainhouse_all", var_2, var_3, var_1);
  ref_131f3(3);
  thread ref_1431b();
  thread ref_14345();
  scripts\engine\utility::flag_wait("intel_collected");
  var_4 = [[[2, "ar"], [2, "lmg"]], [[4, "ar"], [2, "lmg"]], [[5, "ar"], [3, "lmg"]], [[6, "ar"], [4, "lmg"]]];
  ref_1321a("center_chopper_2_target", var_4, 4);
  thread ref_12758("dx_cps_lass_bank_enemy_reinforcements_10");
  var_5 = scripts\common\utility::getvehiclespawner("center_chopper_2", "targetname");
  var_6 = var_5 scripts\common\utility::spawn_vehicle();
  var_6.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var_6);
  thread heli_crash_on_pilot_death();
  thread ref_14353();
  thread heli_death_thread();
  ref_1321a("garden_chopper_2_target", var_4, 4);
  var_7 = scripts\common\utility::getvehiclespawner("garden_chopper_2", "targetname");
  var_8 = var_7 scripts\common\utility::spawn_vehicle();
  thread scripts\common\vehicle_paths::gopath(var_8);
  thread heli_crash_on_pilot_death();
  thread ref_14353();
  thread heli_death_thread();
  var_1 = [[[[2, "smg"], [1, "ar"], [1, "shotgun"]], [[2, "smg"], [2, "ar"], [1, "shotgun"]], [[4, "smg"], [3, "ar"], [2, "shotgun"]], [[4, "smg"], [4, "ar"], [2, "shotgun"]]], [[[2, "shotgun"], [1, "ar"], [1, "lmg"]], [[2, "shotgun"], [2, "ar"], [1, "lmg"]], [[4, "shotgun"], [3, "ar"], [2, "lmg"]], [[4, "shotgun"], [4, "ar"], [2, "lmg"]]]];
  var_2 = ["garden", "sidehouse"];
  var_3 = ["monument", "courtyard_lower", "shed"];
  thread player_sees_hvt_leaving_vo("intel_captured_mainhouse", undefined, var_2, var_3, var_1);
  scripts\engine\utility::flag_wait("intel_captured_mainhouse");
}

function oil_puddles() {
  var_0 = [["es_exfil_1", "lmg", 1], ["es_exfil_2", "ar", 1], ["es_exfil_3", "shotgun", 1, undefined, ["close", 800]], ["es_exfil_4", "ar", 2], ["es_exfil_5", "ar", 3], ["es_exfil_6", "shotgun", 3, undefined, ["close", 800]], ["es_exfil_7", "ar", 4]];
  thread ref_134ed(var_0, 4);
  thread ref_140e4();
  thread pointinsquare();
  wait 2;
  var_1 = scripts\cp\cp_objectives::requestworldid("exfil", 10);
  objective_setdescription(var_1, &"CP_SO_ESTATE/PROCEED_TO_EXFIL");
  objective_setlabel(var_1, &"CP_SO_ESTATE/EXFIL");
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 0);
  objective_position(var_1, scripts\engine\utility::getStruct("exfil_objective", "targetname").origin);
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_state(var_1, "current");
  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_1_index", 6);
  var_2 = getEnt("exfil_volume", "targetname");
  var_3 = 1;

  while(var_3) {
    if(isDefined(level.playervehicle) && ispointinvolume(level.playervehicle.origin, var_2) && !level.playervehicle.isempty) {
      var_3 = 0;
    }

    waitframe();
  }

  if(isDefined(level.playervehicle)) {
    scripts\engine\utility::flag_wait("gate_closed");
    thread poke_the_player_after_faux_death();
    objective_state(4, "done");
    setomnvar("cp_objective_index", 0);
    thread ref_12758("dx_mpa_rutl_gamestate_win");
    level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
    return;
  }
}

function ref_140e4() {
  var_0 = getEnt("van_collision", "targetname");
  var_0 notsolid();
  var_1 = getEnt("van_blocker", "targetname");
  var_1 notsolid();
  var_2 = scripts\engine\utility::getStruct("van_move_1", "targetname");
  var_3 = scripts\engine\utility::getStruct("van_move_2", "targetname");
  var_4 = scripts\engine\utility::getStruct("van_move_3", "targetname");
  var_5 = scripts\engine\utility::getStruct("van_move_4", "targetname");
  var_6 = scripts\engine\utility::getStruct("van_move_5", "targetname");
  var_7 = scripts\engine\utility::getStruct("van_move_6", "targetname");
  var_8 = scripts\engine\utility::getStruct("van_move_7", "targetname");
  var_1 moveTo(var_2.origin, 2, 1.5, 0);
  var_1 rotateTo(var_2.angles, 2, 1.5, 0);
  wait 2;
  var_1 moveTo(var_3.origin, 1);
  var_1 rotateTo(var_3.angles, 1);
  wait 1;
  var_1 moveTo(var_4.origin, 2);
  var_1 rotateTo(var_4.angles, 2);
  wait 2;
  var_1 moveTo(var_5.origin, 3, 1, 0);
  var_1 rotateTo(var_5.angles, 3, 1, 0);
  wait 3;
  var_1 moveTo(var_6.origin, 3, 1, 0);
  var_1 rotateTo(var_6.angles, 3, 1, 0);
  wait 3;
  var_1 moveTo(var_7.origin, 3, 1, 0);
  var_1 rotateTo(var_7.angles, 3, 1, 0);
  wait 3;
  var_1 moveTo(var_8.origin, 3, 1, 0);
  var_1 rotateTo(var_8.angles, 3, 1, 0);
}

function pointinsquare() {
  var_0 = getEnt("exit_gate_left", "targetname");
  var_1 = scripts\engine\utility::getStruct("exit_gate_left_closed", "targetname");
  var_0 moveTo(var_1.origin, 4, 3, 1);
  var_0 rotateTo(var_1.angles, 4, 2, 1);
  var_2 = getEnt("exit_gate_right", "targetname");
  var_3 = scripts\engine\utility::getStruct("exit_gate_right_closed", "targetname");
  var_2 moveTo(var_3.origin, 4.5, 3.5, 1);
  var_2 rotateTo(var_3.angles, 4.5, 3.5, 1);
  scripts\engine\utility::flag_set("gate_closed");
}

function poke_the_player_after_faux_death() {
  var_0 = 2;
  var_1 = 0.2;
  var_2 = 1;
  var_3 = 2;
  var_4 = 0.2;
  var_5 = 1.1;

  if(isDefined(level.playervehicle) && length(level.playervehicle vehicle_getvelocity()) > 200) {
    var_0 = 0.5;
    var_1 = 0;
    var_2 = 0.4;
    var_3 = 0.5;
    var_4 = 0;
    var_5 = 0.35;
  }

  var_6 = getEnt("exit_gate_left", "targetname");
  var_7 = scripts\engine\utility::getStruct("exit_gate_left_open", "targetname");
  var_6 moveTo(var_7.origin, var_0, var_1, var_2);
  var_6 rotateTo(var_7.angles, var_0, var_1, var_2);
  var_8 = getEnt("exit_gate_right", "targetname");
  var_9 = scripts\engine\utility::getStruct("exit_gate_right_open", "targetname");
  var_8 moveTo(var_9.origin, var_3, var_4, var_5);
  var_8 rotateTo(var_9.angles, var_3, var_4, var_5);
}

function ref_131f3(var_0) {
  wait 2;
  scripts\engine\utility::flag_clear("intel_collected");
  scripts\engine\utility::flag_clear("left_objective_radius");
  waitframe();
  level.initvo = scripts\cp\cp_objectives::requestworldid("intel_" + var_0, 10);
  level.initusage = "";
  var_1 = "";
  var_2 = [];
  level.ref_11f90 = undefined;
  level.ref_11f88 = "";
  level.ref_12bbf = "";
  level.useeventamount = 0;
  var_3 = 0;

  switch (var_0) {
    case 0:
      level.ref_11f90 = scripts\engine\utility::getStruct("objective_courtyard", "targetname");
      level.initvehicles = "intel_captured_courtyard";
      var_1 = "icon_waypoint_dom_a";
      var_2 = scripts\engine\utility::getStructArray("intel_courtyard", "targetname");
      level.ref_11f88 = &"CP_SO_ESTATE/SEARCH_CLOCKTOWER_BUILDING";
      level.initusage = "dx_cps_kama_safehouse_intel_gathered_10";
      var_3 = 2;
      break;
    case 1:
      level.ref_11f90 = scripts\engine\utility::getStruct("objective_trucks", "targetname");
      level.initvehicles = "intel_captured_trucks";
      var_1 = "icon_waypoint_dom_b";
      var_2 = scripts\engine\utility::getStructArray("intel_trucks", "targetname");
      level.ref_11f88 = &"CP_SO_ESTATE/SEARCH_TRUCKS";
      level.initusage = "dx_cps_kama_safehouse_intel_gathered_20";
      var_3 = 3;
      break;
    case 2:
      level.ref_11f90 = scripts\engine\utility::getStruct("objective_sidehouse", "targetname");
      level.initvehicles = "intel_captured_sidehouse";
      var_1 = "icon_waypoint_dom_c";
      var_2 = scripts\engine\utility::getStructArray("intel_sidehouse", "targetname");
      level.ref_11f88 = &"CP_SO_ESTATE/SEARCH_POOL_AND_SERVICE";
      level.initusage = "dx_cps_kama_safehouse_intel_gathered_10";
      level.ref_12bbf = &"CP_SO_ESTATE/SEARCH_POOL_AND_SERVICE";
      level.useeventamount = 1;
      var_3 = 4;
      break;
    case 3:
      level.ref_11f90 = scripts\engine\utility::getStruct("objective_mainhouse", "targetname");
      level.initvehicles = "intel_captured_mainhouse";
      var_1 = "icon_waypoint_dom_d";
      var_2 = scripts\engine\utility::getStructArray("intel_mainhouse", "targetname");
      level.ref_11f88 = &"CP_SO_ESTATE/SEARCH_MAIN_HOUSE";
      level.initusage = "dx_mpa_rutl_exfillosing_start_losingteam";
      var_3 = 5;
      break;
  }

  var_4 = scripts\engine\utility::random(var_2);
  var_5 = scripts\cp\laser_traps\cp_laser_traps::trial_active_fob(var_4.origin, var_4.angles, &train_elements_disable);
  scripts\cp\cp_outline_utility::outlineenableforall(var_5, "outline_depth_white", "equipment");
  objective_setdescription(level.initvo, level.ref_11f88);
  objective_setlabel(level.initvo, &"CP_SO_ESTATE/OBJ_FIND_INTEL");
  objective_setplayintro(level.initvo, 1);
  objective_setplayoutro(level.initvo, 0);

  if(level.useeventamount) {
    objective_setlocation(level.initvo, 0, scripts\engine\utility::getStruct("objective_pool", "targetname").origin);
    objective_setlocation(level.initvo, 1, scripts\engine\utility::getStruct("objective_service", "targetname").origin);
  } else {
    objective_position(level.initvo, level.ref_11f90.origin);
  }

  objective_icon(level.initvo, var_1);
  objective_setshowoncompass(level.initvo, 1);
  objective_state(level.initvo, "current");
  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_1_index", var_3);
}

function train_elements_disable(var_0, var_1) {
  level.audio_jugg_death = [];

  foreach(var_3 in getaiarray("axis")) {
    var_4 = 0;

    if(istrue(var_3.matchdata_logkillstreakevent)) {
      var_4 = 1;
    }

    if(isDefined(var_3.ridingvehicle)) {
      var_4 = 1;
    }

    if(!var_4) {
      level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var_3);
    }
  }

  if(!scripts\engine\utility::flag("intel_collected") && level.useeventamount) {
    objective_unsetlocation(level.initvo, 0);
    objective_unsetlocation(level.initvo, 1);
  }

  scripts\engine\utility::flag_set("intel_collected");
  scripts\engine\utility::flag_set("intel_being_carried");
  setomnvar("cp_objective_sub_1_index", 7);
  objective_onentity(level.initvo, level.playervehicle);
  objective_setlabel(level.initvo, &"CP_SO_ESTATE/RETURN_INTEL_TO_VEHICLE");
  objective_setdescription(level.initvo, &"CP_SO_ESTATE/RETURN_INTEL_TO_VEHICLE");
  objective_setzoffset(level.initvo, 92);
  var_0 notify("clear_tutorial_messages");
  var_0 clearhudtutorialmessage(1);
  var_0 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SO_ESTATE/CARRYING_INTEL", 5);
  var_6 = deleteheadicon(var_0);
  var_0.headicon = var_6;
  setheadiconenemyimage(var_6, "hud_icon_sng_intel");
  setheadiconzoffset(var_6, 1);
  addclienttoheadiconmask(var_6, 10);

  foreach(var_8 in level.players) {
    var_8 playlocalsound("cp_intel_pickup");

    if(var_8 != var_0) {
      var_8 notify("clear_tutorial_messages");
      var_8 clearhudtutorialmessage(1);
      var_8 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SO_ESTATE/DEFEND_INTEL", 5);
    }
  }

  thread getcirclerangemin(var_0, var_1.objid);
}

function getcirclerangemin(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = var_0.angles;

  while(isDefined(var_0) && !scripts\cp\cp_laststand::player_in_laststand(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && !scripts\engine\utility::flag(level.initvehicles)) {
    var_2 = var_0.origin;
    var_3 = var_0.angles;

    if(isDefined(level.playervehicle) && distance(var_0.origin, level.playervehicle.origin) <= 128) {
      scripts\engine\utility::flag_set(level.initvehicles);
    }

    if(distance2d(var_0.origin, level.ref_11f90.origin) > level.ref_11f90.radius) {
      scripts\engine\utility::flag_set("left_objective_radius");
    }

    waitframe();
  }

  scripts\engine\utility::flag_clear("intel_being_carried");

  if(!scripts\engine\utility::flag(level.initvehicles)) {
    var_4 = scripts\cp\laser_traps\cp_laser_traps::trial_active_fob(var_2, var_3, &train_elements_disable);
    objective_position(level.initvo, var_2 + (0, 0, 12));
    objective_setlabel(level.initvo, &"CP_SO_ESTATE/OBJ_RECOVER_INTEL");
    objective_setdescription(level.initvo, &"CP_SO_ESTATE/OBJ_RECOVER_INTEL");

    if(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      setheadiconimage(var_0.headicon);
    }

    foreach(var_6 in level.players) {
      var_6 playlocalsound("cp_intel_drop");
    }

    return;
  }

  objective_state(level.initvo, "done");
  setomnvar("cp_objective_index", 0);

  foreach(var_6 in level.players) {
    var_6 playlocalsound("cp_intel_complete");
    var_6 notify("clear_tutorial_messages");
    var_6 clearhudtutorialmessage(1);
  }

  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SO_ESTATE/INTEL_RECOVERED", "allies", 7);
  thread ref_12758(level.initusage);

  if(isDefined(var_1) && var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
    setheadiconimage(var_1.headicon);
  }

  wait 5;
}

function ref_13517(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var_2.origin, var_2.angles);
  var_4 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(var_3);
  var_5 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(var_3);
  thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var_3, var_4, var_5, var_1);
}

function ref_135b4() {
  var_0 = scripts\engine\utility::getStruct("player_vehicle_spawner", "targetname");

  while(!isDefined(var_0)) {
    var_0 = scripts\engine\utility::getStruct("player_vehicle_spawner", "targetname");
    waitframe();
  }

  var_0.team = "allies";
  level.playervehicle = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_0);
  level.playervehicle scripts\engine\utility::set_ai_number();
  level.playervehicle thread scripts\common\vehicle_code::vehicle_ai_avoidance_logic();
  level.playervehicle scripts\common\vehicle::godon();
  level.playervehicle setCanDamage(0);
  scripts\engine\utility::flag_set("vehicle_spawned");
  level.playervehicle.headicon = deleteheadicon(level.playervehicle);
  setheadiconenemyimage(level.playervehicle.headicon, "hud_icon_vehicle_tac_rover");
  addclienttoheadiconmask(level.playervehicle.headicon, 80);
  setheadiconzoffset(level.playervehicle.headicon, 1);
  setheadiconsnaptoedges(level.playervehicle.headicon, 31999);
  setheadiconmaxdistance(level.playervehicle.headicon, 31999);
  setheadicondrawthroughgeo(level.playervehicle.headicon, 1);
  setheadiconowner(level.playervehicle.headicon, "allies");
  hideheadiconfromplayersinmask(level.playervehicle.headicon);
  scripts\engine\utility::flag_wait("game_started");
  var_1 = level.players;
  level.ref_14255 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupantsandreserving(level.playervehicle);

  foreach(var_3 in level.ref_14255) {
    var_1 = scripts\engine\utility::array_remove(var_1, var_3);
  }

  foreach(var_3 in var_1) {
    addteamtoheadiconmask(level.playervehicle.headicon, var_3);
  }

  var_7 = 0;

  while(isDefined(level.playervehicle)) {
    level.ref_14255 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupantsandreserving(level.playervehicle);

    if(scripts\cp\cp_endgame::gamealreadyended()) {
      foreach(var_3 in var_1) {
        removeteamfromheadiconmask(level.playervehicle.headicon, var_3);
        return 1;
      }
    }

    if(scripts\engine\utility::flag("intel_being_carried")) {
      var_7 = 1;

      foreach(var_3 in var_1) {
        removeteamfromheadiconmask(level.playervehicle.headicon, var_3);
      }
    } else {
      if(var_7) {
        foreach(var_3 in var_1) {
          addteamtoheadiconmask(level.playervehicle.headicon, var_3);
        }

        var_7 = 0;
      }

      foreach(var_3 in var_1) {
        if(scripts\engine\utility::array_contains(level.ref_14255, var_3)) {
          var_1 = scripts\engine\utility::array_remove(var_1, var_3);
          removeteamfromheadiconmask(level.playervehicle.headicon, var_3);
        }
      }

      foreach(var_3 in level.players) {
        if(!scripts\engine\utility::array_contains(var_1, var_3) && !scripts\engine\utility::array_contains(level.ref_14255, var_3)) {
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
          addteamtoheadiconmask(level.playervehicle.headicon, var_3);
        }
      }
    }

    waitframe();
  }

  level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
}

function ref_13513(var_0) {
  foreach(var_2 in var_0) {
    if(level.players.size >= var_2[2]) {
      var_3 = scripts\engine\utility::getStruct(var_2[1], "targetname");
      var_4 = undefined;

      switch (var_2[1]) {
        case "ammo":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
        case "frag":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
        case "flash":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
        case "molotov":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::ref_11cb8(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
        case "claymore":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
        case "snapshot":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::ref_13433(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
        case "stim":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
        case "c4":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
        case "gas":
          var_4 = scripts\cp\laser_traps\cp_laser_traps::plunderfxondropthreashold(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
        default:
          var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(scripts\engine\utility::getStruct(var_2[0], "targetname").origin, scripts\engine\utility::getStruct(var_2[0], "targetname").angles);
          break;
      }

      if(isDefined(var_4)) {
        setheadiconsnaptoedges(var_4.headiconid, 1000);
      }
    }
  }
}

function ref_135f7(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    if(int(var_5.script_parameters) <= level.players.size) {
      ref_135f5(var_5, var_1, var_2);
    }
  }
}

function ref_135f5(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_weapon::buildweapon(var_1, var_2);
  var_4 = "weapon_" + var_1;

  foreach(var_6 in var_2) {
    var_4 += "+" + var_6;
  }

  var_8 = spawn(var_4, var_0.origin, 1);
  var_8.angles = var_0.angles;
  var_8 scripts\anim\shared::setscriptammo(var_1, var_0);
}

function ref_1369f() {
  wait 4;
  level.ref_13690 = [];
  var_0 = getEntArray("spawn_region", "script_noteworthy");

  foreach(var_2 in var_0) {
    level.ref_13690[var_2.script_parameters] = var_2;
  }

  var_4 = scripts\engine\utility::getStructArray("spawn_region", "script_noteworthy");

  foreach(var_6 in var_4) {
    level.ref_13690[var_6.script_parameters] = var_6;
  }

  scripts\engine\utility::flag_wait("game_started");
  scripts\engine\utility::flag_set("spawning_ready");
}

function ref_1321a(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");
  level.initteamdatafields = var_2;
  var_4 = [];

  foreach(var_6 in var_3) {
    if(isDefined(var_6.script_demeanor)) {
      if(!isDefined(var_6.script_startingposition)) {
        var_4 = scripts\engine\utility::array_add(var_4, var_6);
      }
    }
  }

  var_8 = var_1[level.players.size - 1];

  foreach(var_10 in var_8) {
    for(var_11 = 0; var_11 < int(var_10[0]); var_11++) {
      var_12 = 1;
      var_13 = getaiarray("axis");

      if(getaiarray("axis").size >= 40) {
        var_12 = velnumdatapoints(var_13);
      }

      if(var_12) {
        var_6 = var_4[0];
        ref_131eb(var_6, var_10[1]);
        var_4 = scripts\engine\utility::array_remove(var_4, var_6);
      }
    }
  }

  foreach(var_6 in var_4) {
    scripts\engine\utility::deletestruct_ref(var_6);
  }
}

function player_sees_hvt_leaving_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_0);
  var_6 = 25;
  var_7 = 90;
  var_8 = gettime();
  var_9 = gettime();
  var_10 = 0;

  if(var_0 != "intel_collected") {
    level endon("left_objective_radius");
  }

  if(isDefined(var_1)) {
    var_11 = getEnt(var_1, "targetname");

    while(!trial_turret_thread_func(var_11)) {
      waitframe();
    }
  }

  if(!isDefined(var_5)) {
    var_5 = [2, 4, 5, 6];
  }

  var_12 = var_5[level.players.size - 1];
  var_13 = 0;

  for(;;) {
    var_14 = [];

    foreach(var_16 in level.audio_jugg_death) {
      if(isDefined(var_16) && isalive(var_16)) {
        var_14 = scripts\engine\utility::array_add(var_14, var_16);
      }
    }

    level.audio_jugg_death = var_14;

    foreach(var_19 in level.players) {
      var_20 = [];

      if(isDefined(var_19.ref_12544)) {
        foreach(var_16 in var_19.ref_12544) {
          if(isDefined(var_16) && isalive(var_16)) {
            var_20 = scripts\engine\utility::array_add(var_20, var_16);
          }
        }
      }

      var_19.ref_12544 = var_20;
    }

    var_24 = 0;

    if(scripts\engine\utility::flag("intel_collected")) {
      if(level.audio_jugg_death.size > 0) {
        var_24 = 1;
      }
    } else if(level.audio_jugg_death.size > var_12) {
      var_24 = 1;
    }

    if(var_24) {
      var_25 = level.players[0];

      foreach(var_19 in level.players) {
        if(var_19.ref_12544.size < var_25.ref_12544.size) {
          var_25 = var_19;
        }
      }

      if(var_25.ref_12544.size <= var_12 / level.players.size && scripts\engine\utility::time_has_passed(var_9, var_10)) {
        var_16 = scripts\engine\utility::getclosest(var_25.origin, level.audio_jugg_death);
        level.audio_jugg_death = scripts\engine\utility::array_remove(level.audio_jugg_death, var_16);

        if(isDefined(var_16.select_lobby_patrol_spawners)) {
          var_16.goalradius = var_16.select_lobby_patrol_spawners;
        } else {
          var_16.goalradius = 600;
        }

        var_16 cleargoalvolume();
        var_16 setgoalentity(var_25);
        var_9 = gettime();
        var_25.ref_12544 = scripts\engine\utility::array_add(var_25.ref_12544, var_16);

        if(scripts\engine\utility::flag("intel_collected")) {
          var_10 = 6 - level.players.size;
        } else {
          var_10 = 10 - level.players.size;
        }
      }
    } else if(scripts\engine\utility::time_has_passed(var_8, var_6) && getaiarray("axis").size < var_12 && level.brclosealldoors <= 0) {
      ref_13560(ref_12a02(var_2, var_3), var_4[var_13]);
      var_8 = gettime();
      var_13++;

      if(var_13 >= var_4.size) {
        var_13 = 0;
      }

      if(brdownedbyairstriketime()) {
        var_6 += 45;
      } else {
        var_6 += 10;
      }

      if(var_6 > var_7) {
        var_6 = var_7;
      }
    }

    wait 0.1;
  }
}

function brdownedbyairstriketime() {
  if(level.players.size > 1) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
        var_0++;
      }
    }

    if(var_0 == level.players.size - 1) {
      return true;
    }
  }

  return false;
}

function ref_13560(var_0, var_1, var_2) {
  var_3 = var_1[level.players.size - 1];
  var_4 = 0;

  foreach(var_6 in var_0) {
    if(var_4) {
      break;
    }

    var_7 = level.ref_13690[var_6];

    if(trial_turret_thread_func(var_7) == 0) {
      var_4 = 1;
      var_8 = scripts\engine\utility::getStructArray("enemy_spawner_" + var_6, "targetname");

      foreach(var_10 in var_3) {
        for(var_11 = 0; var_11 < var_10[0]; var_11++) {
          var_12 = 0;

          if(isDefined(var_10[2]) && var_10[2]) {
            var_12 = 1;
          }

          var_13 = getaiarray("axis");

          if(var_12 && getaiarray("axis").size >= 40) {
            velnumdatapoints(var_13);
          }

          if(getaiarray("axis").size < 40) {
            var_14 = level.players[0];

            foreach(var_16 in level.players) {
              if(var_16.ref_12544.size < var_14.ref_12544.size) {
                var_14 = var_16;
              }
            }

            var_18 = 600;

            if((var_12 || var_14.ref_12544.size < 3) && var_8.size > 0) {
              var_19 = scripts\engine\utility::random(var_8);
              var_8 = scripts\engine\utility::array_remove(var_8, var_19);
              var_19.count = 1;
              ref_131eb(var_19, var_10[1]);
              var_20 = var_19 scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var_19.script_type, var_19.origin, var_19.angles, 1, 1);

              if(isDefined(var_2)) {
                var_20 setgoalvolumeauto(getEnt(var_2, "targetname"));
                level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var_20);
              } else {
                var_20.select_lobby_patrol_spawners = var_19.select_lobby_patrol_spawners;
                var_20.goalradius = var_19.select_lobby_patrol_spawners;
                var_20 setgoalentity(var_14);
                var_14.ref_12544 = scripts\engine\utility::array_add(var_14.ref_12544, var_20);
              }

              var_21 = var_20 scripts\cp\laser_traps\cp_laser_traps::print_spawner_score_for_factor();
              var_20 scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy(0);
              var_20 scripts\engine\utility::delaythread(5.5, &scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy, var_21);
            }

            waitframe();
          }
        }
      }
    }
  }
}

function ref_134ed(var_0, var_1) {
  level.ref_14071 = [];
  level.initteamdatafields = var_1;

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3[0], "targetname");

    if(level.players.size >= var_3[2]) {
      var_5 = 0;

      while(!var_5) {
        var_6 = 1;
        var_7 = getaiarray("axis");

        if(getaiarray("axis").size >= 40) {
          var_6 = velnumdatapoints(var_7);
        }

        if(var_6) {
          ref_134ee(var_4, var_3, var_1);
          var_5 = 1;
        }

        waitframe();
      }
    }
  }
}

function ref_134ee(var_0, var_1, var_2, var_3) {
  var_4 = var_0.script_parameters;
  var_5 = getEnt(var_0.script_parameters, "targetname");

  if(trial_turret_thread_func(var_5) && !istrue(var_3)) {
    var_6 = [];

    foreach(var_8 in level.ref_13690) {
      if(!trial_turret_thread_func(var_8)) {
        var_6 = scripts\engine\utility::array_add(var_6, var_8);
      }
    }

    var_10 = scripts\engine\utility::getclosest(var_0.origin, var_6);
    var_11 = [];
    var_12 = scripts\engine\utility::getStructArray("enemy_spawner_" + var_10.targetname, "targetname");

    foreach(var_14 in var_12) {
      if(!scripts\engine\utility::array_contains(level.ref_14071, var_14)) {
        var_0 = var_14;
        level.ref_14071 = scripts\engine\utility::array_add(level.ref_14071, var_0);
        break;
      }
    }
  }

  ref_131eb(var_0, var_1[1]);
  var_16 = var_0 scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var_0.script_type, var_0.origin, var_0.angles, 1, 1);

  if(var_0.script_type != "actor_enemy_cp_rus_juggernaut") {
    var_16 setgoalvolumeauto(var_5);
  }

  var_16.script_parameters = var_4;
  var_16.set_level_weapons_free = var_2;

  if(var_0.script_type == "actor_enemy_cp_rus_desert_sniper_nvg") {
    var_16 laseron();
    var_16.matchdata_logkillstreakevent = 1;
  } else if(var_0.script_type == "actor_enemy_cp_rus_desert_rpg_nvg") {
    var_16.matchdata_logkillstreakevent = 1;
  } else if(var_0.script_type == "actor_enemy_cp_rus_juggernaut") {
    var_16.matchdata_logkillstreakevent = 1;
    thread bomber_death_watcher();
    var_16.goalheight = 3000;
  }

  if(isDefined(var_1[3])) {
    switch (var_1[3]) {
      case "molotov":
        bomber_disable_movement_for_time(var_16);
        break;
      case "flash":
        bomb_case_explode_vfx_sequence(var_16);
        break;
    }
  }

  if(isDefined(var_1[4])) {
    switch (var_1[4][0]) {
      case "close":
        thread ref_1434a(var_16);
        break;
      case "advance":
        thread ref_14349(var_16);
        break;
    }

    return;
  }
}

function ref_14345() {
  var_0 = getEnt("main_mid_upper", "targetname");

  while(!trial_turret_thread_func(var_0)) {
    waitframe();
  }

  var_1 = getEnt("main_upper", "targetname");

  if(trial_turret_thread_func(var_1)) {
    while(trial_turret_thread_func(var_1)) {
      waitframe();
    }
  }

  var_2 = scripts\engine\utility::getStruct("es_main_defend_mid_2", "targetname");
  var_3 = 0;

  while(!var_3) {
    var_4 = 1;
    var_5 = getaiarray("axis");

    if(getaiarray("axis").size >= 40) {
      var_4 = velnumdatapoints(var_5);
    }

    if(var_4) {
      ref_134ee(var_2, ["es_main_defend_mid_2", "juggernaut", 1], 3, 1);
      var_3 = 1;
    }

    waitframe();
  }
}

function ref_1434a(var_0) {
  var_1 = getEnt(self.script_parameters, "targetname");
  var_2 = 1;
  var_3 = undefined;

  while(var_2) {
    var_4 = scripts\engine\utility::array_removeundefined(level.players);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !isDefined(var_6.origin)) {
        continue;
      }

      if(ispointinvolume(var_6.origin, var_1)) {
        if(distance(var_6.origin, self.origin) <= var_0) {
          var_3 = var_6;
          var_2 = 0;
          break;
        }
      }

      wait 0.1;
    }
  }

  if(isDefined(self.select_lobby_patrol_spawners)) {
    self.goalradius = self.select_lobby_patrol_spawners;
  } else {
    self.goalradius = 600;
  }

  var_3.ref_12544 = scripts\engine\utility::array_add(var_3.ref_12544, self);
  self cleargoalvolume();
  self setgoalentity(var_3);
}

function ref_14349(var_0) {
  var_1 = 1;
  var_2 = undefined;

  while(var_1) {
    foreach(var_4 in level.players) {
      if(distance(var_4.origin, self.origin) <= var_0) {
        var_2 = var_4;
        var_1 = 0;
        break;
      }

      wait 0.1;
    }
  }

  if(isDefined(self.select_lobby_patrol_spawners)) {
    self.goalradius = self.select_lobby_patrol_spawners;
  } else {
    self.goalradius = 600;
  }

  var_2.ref_12544 = scripts\engine\utility::array_add(var_2.ref_12544, self);
  self cleargoalvolume();
  self setgoalentity(var_2);
}

function ref_131eb(var_0, var_1) {
  var_2 = 600;

  switch (var_1) {
    case "dmr":
      var_0.script_type = "actor_enemy_cp_rus_desert_ar_nvg";
      break;
    case "lmg":
      var_0.script_type = "actor_enemy_cp_rus_desert_lmg_nvg";
      break;
    case "juggernaut":
      var_0.script_type = "actor_enemy_cp_rus_juggernaut";
      level.brclosealldoors++;
      var_2 = 300;
      break;
    case "rpg":
      var_0.script_type = "actor_enemy_cp_rus_desert_rpg_nvg";
      break;
    case "shotgun":
      var_0.script_type = "actor_enemy_cp_rus_desert_shotgun_nvg";
      var_2 = 100;
      break;
    case "smg":
      var_0.script_type = "actor_enemy_cp_rus_desert_smg_nvg";
      var_2 = 500;
      break;
    case "sniper":
      var_0.script_type = "actor_enemy_cp_rus_desert_sniper_nvg";
      var_2 = 10000;
      break;
    default:
      var_0.script_type = "actor_enemy_cp_rus_desert_ar_nvg";
      break;
  }

  var_0.select_lobby_patrol_spawners = var_2;
}

function ref_14344() {
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_cps_lass_bank_enemies_vehicle_10");
  var_0 = getEnt("map_far_right_side", "targetname");

  while(callback_subscribe(var_0)) {
    waitframe();
  }

  var_1 = getEnt("view_truck_maingate", "targetname");

  if(!trial_turret_thread_func(var_1)) {
    var_2 = [[[2, "ar"]], [[3, "ar"]], [[4, "ar"]], [[4, "ar"]]];
    ref_1321a("jeep_maingate_target", var_2, 1);
    var_3 = scripts\common\utility::getvehiclespawner("jeep_maingate", "targetname");
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var_4);
    thread ref_14354(var_4);
    var_5 = [[[2, "ar"]], [[2, "ar"]], [[3, "ar"]], [[4, "ar"]]];
    ref_1321a("jeep_maingate2_target", var_5, 1);
    var_6 = scripts\common\utility::getvehiclespawner("jeep_maingate2", "targetname");
    var_7 = var_6 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var_7);
    thread ref_14354(var_7);
    return;
  }
}

function ref_14346(var_0) {
  while(callback_subscribe(var_0)) {
    waitframe();
  }

  var_1 = getEnt("view_truck_church", "targetname");

  if(!trial_turret_thread_func(var_1)) {
    var_2 = [[[2, "ar"]], [[3, "ar"]], [[4, "ar"]], [[4, "ar"]]];
    ref_1321a("jeep_church_target", var_2, 1);
    var_3 = scripts\common\utility::getvehiclespawner("jeep_church", "targetname");
    var_4 = var_3 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var_4);
    thread ref_14354(var_4);
  }

  var_5 = getEnt("view_truck_sidegate", "targetname");

  if(!trial_turret_thread_func(var_5)) {
    var_6 = [[[2, "ar"]], [[3, "ar"]], [[4, "ar"]], [[4, "ar"]]];
    ref_1321a("jeep_sidegate_target", var_6, 1);
    var_7 = scripts\common\utility::getvehiclespawner("jeep_sidegate", "targetname");
    var_8 = var_7 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var_8);
    thread ref_14354(var_8);
    return;
  }
}

function ref_12a02(var_0, var_1) {
  var_2 = [];
  var_3 = var_0;
  var_4 = var_1;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = scripts\engine\utility::random(var_3);
    var_3 = scripts\engine\utility::array_remove(var_3, var_6);
    var_2 = scripts\engine\utility::array_add(var_2, var_6);
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = scripts\engine\utility::random(var_4);
    var_4 = scripts\engine\utility::array_remove(var_4, var_6);
    var_2 = scripts\engine\utility::array_add(var_2, var_6);
  }

  return var_2;
}

function trial_turret_thread_func() {
  var_0 = 1;

  if(isstruct(self)) {
    var_0 = 0;
  }

  foreach(var_2 in level.players) {
    if(var_0) {
      if(ispointinvolume(var_2.origin, self)) {
        return true;
      }

      continue;
    }

    if(distance2d(self.origin, var_2.origin) <= self.radius) {
      return true;
    }
  }

  return false;
}

function callback_subscribe() {
  var_0 = 1;

  if(isstruct(self)) {
    var_0 = 0;
  }

  foreach(var_2 in level.players) {
    if(var_0) {
      if(!ispointinvolume(var_2.origin, self)) {
        return false;
      }

      continue;
    }

    if(!distance2d(self.origin, var_2.origin) <= self.radius) {
      return false;
    }
  }

  return true;
}

function velnumdatapoints(var_0) {
  var_1 = 0;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_5 = 0;

    foreach(var_7 in level.players) {
      var_5 += distance(var_7.origin, var_4.origin);
    }

    if(var_5 > var_1) {
      if(!isDefined(var_4.set_level_weapons_free) || isDefined(var_4.set_level_weapons_free) && var_4.set_level_weapons_free < level.initteamdatafields) {
        var_1 = var_5;
        var_2 = var_4;
      }
    }
  }

  if(isDefined(var_2)) {
    var_2 kill();
    return true;
  }

  return false;
}

function ref_14354(var_0) {
  self waittill("unloading");
  var_1 = 0;

  foreach(var_3 in self.riders) {
    var_3 setgoalvolumeauto(getEnt(var_0[var_1], "targetname"));
    var_1++;

    if(var_1 >= var_0.size) {
      var_1 = 0;
    }

    level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var_3);
  }
}

function ref_14352(var_0) {
  self endon("death");
  self waittill("unloading");
  var_1 = 0;

  foreach(var_3 in self.riders) {
    if(var_3 != self.driver) {
      var_3 setgoalvolumeauto(getEnt(var_0[var_1], "targetname"));
      var_1++;

      if(var_1 >= var_0.size) {
        var_1 = 0;
      }

      level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var_3);
    }
  }
}

function ref_14353() {
  self waittill("unloading");

  foreach(var_1 in self.riders) {
    if(var_1 != self.driver) {
      nextareanags(var_1);
    }
  }
}

function nextareanags() {
  if(isDefined(self.select_lobby_patrol_spawners)) {
    self.goalradius = self.select_lobby_patrol_spawners;
  } else {
    self.goalradius = 600;
  }

  var_0 = level.players[0];

  foreach(var_2 in level.players) {
    if(var_2.ref_12544.size < var_0.ref_12544.size) {
      var_0 = var_2;
    }
  }

  var_0.ref_12544 = scripts\engine\utility::array_add(var_0.ref_12544);
  self setgoalentity(var_0);
}

function bomber_disable_movement_for_time() {
  self.grenadeweapon = getcompleteweaponname("molotov_mp");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
}

function bomb_case_explode_vfx_sequence() {
  self.grenadeweapon = getcompleteweaponname("flash_mp");
  self.grenadeammo = 255;
  self.grenadesafedist = 400;
  self.grenadeweapon.ammo = 255;
}

function ref_14347() {
  var_0 = getEnt("garden_defend", "targetname");

  while(!trial_turret_thread_func(var_0)) {
    waitframe();
  }

  var_1 = scripts\engine\utility::getStructArray("trucks_grenade_throw", "targetname");

  foreach(var_3 in var_1) {
    var_4 = magicgrenademanual("smoke_grenade_mp", var_3.origin, anglesToForward(var_3.angles) * 800, 3, level.player);
    wait randomfloatrange(0.7, 1.5);
  }

  var_0 = getEnt("sidehouse_defend_front", "targetname");

  while(!trial_turret_thread_func(var_0)) {
    waitframe();
  }
}

function ref_1431b() {
  var_0 = getEnt("main_mid", "targetname");
  var_1 = getEnt("main_house_mid_center", "targetname");
  var_2 = getEnt("main_upper", "targetname");
  var_3 = getEnt("main_house_stairs_approach", "targetname");
  var_4 = getEnt("mainhouse_lower_right", "targetname");
  var_5 = getEnt("mainhouse_parkinglot", "targetname");

  while(!trial_turret_thread_func(var_3) && !trial_turret_thread_func(var_0)) {
    waitframe();
  }

  if(!trial_turret_thread_func(var_0)) {
    thread player_maxhealth("mainhouse_grenade_throw_1");

    while(!trial_turret_thread_func(var_0)) {
      waitframe();
    }

    if(!trial_turret_thread_func(var_2)) {
      thread player_maxhealth("mainhouse_grenade_throw_2");
    }
  }

  while(!scripts\engine\utility::flag("intel_collected") && !trial_turret_thread_func(var_1)) {
    waitframe();
  }

  if(!trial_turret_thread_func(var_2)) {
    thread player_maxhealth("mainhouse_grenade_throw_3");
  }

  scripts\engine\utility::flag_wait("intel_collected");

  while(!scripts\engine\utility::flag("intel_captured_mainhouse") && !trial_turret_thread_func(var_4) && !trial_turret_thread_func(var_5)) {
    waitframe();
  }

  if(!scripts\engine\utility::flag("intel_captured_mainhouse")) {
    var_6 = scripts\engine\utility::getStructArray("mainhouse_smokescreen", "targetname");

    foreach(var_8 in var_6) {
      magicgrenademanual("smoke_grenade_mp", var_8.origin + (0, 0, 5), (0, 0, 0), 1, level.player);
      wait randomfloatrange(0.7, 1.5);
    }

    return;
  }
}

function player_maxhealth(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = 1000;
    magicgrenademanual("flash_grenade_mp", var_3.origin, anglesToForward(var_3.angles) * var_4, 3, level.players[0]);
    wait randomfloatrange(0.7, 1.5);
  }
}

function weapon_xp_iw8_sm_smgolf45(var_0, var_1) {
  while(var_0 > 0) {
    if(istrue(var_1)) {
      foreach(var_3 in level.players) {
        var_3 playlocalsound("match_start_tick");
        var_3 setclientomnvar("ui_match_start_countdown", var_0);
        var_3 setclientomnvar("ui_match_in_progress", 0);
      }
    }

    var_0--;
    wait 1;
  }
}

function ref_12758(var_0) {
  level.light_tank_removegunnerdamagemod = scripts\engine\utility::array_add(level.light_tank_removegunnerdamagemod, var_0);
}

function light_tank_gunnerdamagemodignorefunc() {
  level.light_tank_removegunnerdamagemod = [];

  for(;;) {
    while(level.light_tank_removegunnerdamagemod.size == 0) {
      waitframe();
    }

    var_0 = level.light_tank_removegunnerdamagemod[0];
    level.light_tank_removegunnerdamagemod = scripts\engine\utility::array_remove_index(level.light_tank_removegunnerdamagemod, 0);

    if(!isDefined(level.ref_121a7)) {
      level.ref_121a7 = spawn("script_origin", (0, 0, 0));
    }

    level.ref_121a7 stopsounds();
    var_1 = lookupsoundlength(var_0) * 0.001;
    level.ref_121a7 playSound(var_0);
    wait var_1;
    level.waittill_wave_spawned_or_timeout = gettime();
    wait 1;
  }
}

function bomber_death_watcher() {
  self endon("death");
  thread vehicle_mp_createlate();
  GscBinSkip4(0x35);
}

function ref_1333a() {
  self.objindex = scripts\cp\cp_objectives::requestworldid("obj_" + self getentitynumber(), 5);
  objective_setplayintro(self.objindex, 0);
  objective_setplayoutro(self.objindex, 0);
  objective_setownerteam(self.objindex, "axis");
  objective_state(self.objindex, "active");
  objective_icon(self.objindex, "icon_minimap_juggernaut");
  objective_setlocation(self.objindex, 0, self);
  thread laser_sights(self.objindex, "obj_" + self getentitynumber());
}

function laser_sights(var_0, var_1) {
  self waittill("death");
  scripts\cp\cp_objectives::freeworldid(var_1);
  objective_state(var_0, "done");
}

function ref_14342() {
  var_0 = 1;

  while(var_0) {
    wait 0.2;

    foreach(var_2 in level.players) {
      if(distance(var_2.origin, self.origin) <= 2048) {
        var_0 = 0;
      }
    }
  }

  setmusicstate("cp_juggernaut_intro");
  scripts\engine\utility::delaythread(2, &ref_12758, "dx_mpa_rutl_juggernaut_enemy_use");
}

function vehicle_mp_createlate() {
  self waittill("death");
  level.brclosealldoors--;
}

function vehicle_mp_deletenextframelate() {
  for(;;) {
    var_0 = scripts\engine\utility::ref_143ad("damage", "flashbang");

    if(var_0 == "damage") {
      if(!self.stuncooldown && ref_1459d()) {
        self.stuncooldown = 1;
        GscBinSkip4(0x35);
      }

      if(!ref_11ca4()) {
        continue;
      }
    }

    self.allowpain = 1;
    wait 0.05;
    self.minpaindamage = 0;
    self dodamage(10, self.damagepoint, self.is_specops_gametype);
    self.minpaindamage = self.minpainvalue;
    wait 0.05;
    self.allowpain = 0;
  }
}

function ref_1459d() {
  if(!isDefined(self.damageweapon)) {
    return false;
  }

  var_0 = scripts\cp\utility::getbaseweaponname(self.damageweapon);

  if(var_0 == "iw8_sn_alpha50" || var_0 == "iw8_sh_oscar12") {
    return true;
  }

  return false;
}

function ref_11ca4() {
  if(!isDefined(self.damagemod)) {
    return false;
  }

  if(self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH") {
    return true;
  }

  return false;
}

function juggernaut_pain_cooldown() {
  self notify("start_new_cooldown");
  self endon("start_new_cooldown");
  wait 7;
  self.stuncooldown = 0;
}

function ref_13523(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    thread scripts\cp\laser_traps\cp_laser_traps::ref_13542(var_3.origin, var_3.angles);
  }
}

function ref_1249b(var_0, var_1, var_2) {
  thread ref_12758("dx_mpa_rutl_sentry_gun_achieve");
}

function ref_1249a(var_0, var_1, var_2) {
  thread ref_12758("dx_mpa_rutl_precision_airstrike_achieve");
}

function heli_crash_on_pilot_death() {
  self endon("death");

  while(!isDefined(self.driver)) {
    wait 0.1;
  }

  self.driver.health += 100;
  self.driver waittill("death");

  if(scripts\common\vehicle::vehicle_is_crashing()) {
    return;
  }

  self dodamage(self.health - self.healthbuffer + 1, self.origin);
}

function heli_death_thread() {
  self waittill("vehicle_crashDone");
  var_0 = self.origin;

  foreach(var_2 in self.riders) {
    var_2 kill();
  }

  self stopsounds();
  thread scripts\engine\utility::play_sound_in_space("hind_helicopter_crash", var_0);
  playFX(scripts\engine\utility::getfx("vfx_helo_explode"), var_0);
  waitframe();
  self delete();
}