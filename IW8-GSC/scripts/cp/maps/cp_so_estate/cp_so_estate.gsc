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
  setDvar("NPONLLLSPL", 1.25);
  setDvar("PKKMTTRQO", 4);
  setDvar("NKLMONNPNN", 2048);
  setDvar("MROOOROPKL", 8);
  setDvar("LTQMSPKRKO", 8);

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

  var0 = getDvar("cp_so_estate_start_obj", "");

  if(isDefined(var0) && var0 != "") {
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

function ref_11e55(var0) {
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
  var0 = "iw8_ar_mike4_mp";
  var1 = scripts\cp\cp_weapon::buildweapon(var0, ["selectsemi", "laserir", "xmags_mike4", "barcust2_mike4", "glincendiary", "flashhider", "stocks_mike4"], "none", "none", 1);
  self giveweapon(var1);
  self setweaponammoclip(var1, weaponclipsize(var1));
  self setweaponammostock(var1, weaponmaxammo(var1));
  self switchtoweapon(var1);
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

  var2 = self;
  var2.loadoutaccessoryweapon = var2 scripts\cp\cp_loadout::cac_getaccessoryweapon();
  var2.loadoutaccessorydata = var2 scripts\cp\cp_loadout::cac_getaccessorydata();
  var2.loadoutaccessorylogic = var2 scripts\cp\cp_loadout::force_interrupt_all_current_combat_actions();

  if(isDefined(var2.loadoutaccessorydata) && isDefined(var2.loadoutaccessoryweapon) && var2.loadoutaccessoryweapon != "none") {
    var2 scripts\cp\cp_accessories::giveplayeraccessory(var2.loadoutaccessorydata, var2.loadoutaccessoryweapon, var2.loadoutaccessorylogic);
  }

  self setclientomnvar("ui_hide_minimap", 0);
  self.ref_12544 = [];
  level.hostdamagefactorlow++;

  if(!scripts\engine\utility::flag("game_started")) {
    self allowmovement(0);
  }

  thread scripts\cp\laser_traps\cp_laser_traps::mountain_three_death_func();
}

function ref_1247b(var0) {}

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
  scripts\cp\cp_objectives::registerobjective("map_restart", undefined, undefined, undefined, undefined, undefined);
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
  register_create_script_arrays("cp_so_estate_create_script", "cp_so_estate_create_script", level.scripted_spawner_func.size, &scripts\cp\maps\cp_so_estate\cp_so_estate_create_script::main);
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

function ref_12daa() {
  while(level.hostdamagefactorlow < 1) {
    waitframe();
  }

  var0 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(scripts\engine\utility::getStruct("start_tarp_loc1", "script_noteworthy").origin, scripts\engine\utility::getStruct("start_tarp_loc2", "script_noteworthy").angles);
  setheadiconsnaptoedges(var0.headiconid, 400);
  var1 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(scripts\engine\utility::getStruct("start_tarp_loc2", "script_noteworthy").origin, scripts\engine\utility::getStruct("start_tarp_loc3", "script_noteworthy").angles);
  setheadiconsnaptoedges(var1.headiconid, 400);
  var2 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime(scripts\engine\utility::getStruct("start_tarp_loc3", "script_noteworthy").origin, scripts\engine\utility::getStruct("start_tarp_loc2", "script_noteworthy").angles);
  setheadiconsnaptoedges(var2.headiconid, 400);
  var3 = scripts\cp\laser_traps\cp_laser_traps::ref_13433(scripts\engine\utility::getStruct("start_tarp_loc4", "script_noteworthy").origin, scripts\engine\utility::getStruct("start_tarp_loc3", "script_noteworthy").angles);
  setheadiconsnaptoedges(var3.headiconid, 400);
  var4 = [["box_spawn_1", "ammo", 1], ["box_spawn_2", "frag", 1], ["box_spawn_3", "ammo", 1], ["box_spawn_4", "frag", 1], ["box_spawn_5", "snapshot", 1], ["box_spawn_6", "molotov", 1], ["box_spawn_7", "ammo", 1], ["box_spawn_8", "frag", 1], ["box_spawn_9", "snapshot", 1], ["box_spawn_10", "ammo", 1], ["box_spawn_11", "ammo", 1], ["box_spawn_12", "gas", 1], ["box_spawn_13", "ammo", 1], ["box_spawn_14", "frag", 1], ["box_spawn_15", "stim", 1], ["box_spawn_16", "snapshot", 1], ["box_spawn_17", "stim", 1], ["box_spawn_18", "gas", 1], ["box_spawn_19", "c4", 1], ["box_spawn_20", "c4", 1], ["box_spawn_21", "stim", 1], ["box_spawn_22", "molotov", 1], ["box_spawn_23", "stim", 1]];
  ref_13513(var4);
  thread ref_135b4();
  scripts\engine\utility::flag_wait("vehicle_spawned");
  scripts\cp\laser_traps\cp_laser_traps::ref_1437a();
  scripts\engine\utility::flag_set("game_started");

  foreach(var6 in level.players) {
    var6 allowmovement(1);
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
  var0 = [[[4, "ar"]], [[6, "ar"]], [[8, "ar"]], [[10, "ar"]]];
  ref_1321a("courtyard_chopper_target", var0, 0);
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SO_ESTATE/MISSION_INSTRUCTIONS", "allies", 10);
  thread ref_12758("dx_cps_kama_mobile_heist_nag_find_phones_20");
  scripts\engine\utility::flag_wait("spawning_ready");
  ref_122f7();
  var1 = scripts\common\utility::getvehiclespawner("courtyard_chopper_1", "targetname");
  var2 = var1 scripts\common\utility::spawn_vehicle();
  var2.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var2);
  thread ref_14352(var2);
  thread heli_crash_on_pilot_death();
  thread heli_death_thread();
  var3 = scripts\common\utility::getvehiclespawner("intro1_chopper_1", "targetname");
  var4 = var3 scripts\common\utility::spawn_vehicle();
  var4.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var4);
  thread heli_death_thread();
  var5 = scripts\common\utility::getvehiclespawner("intro2_chopper_1", "targetname");
  var6 = var5 scripts\common\utility::spawn_vehicle();
  var6.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var6);
  thread heli_death_thread();
  wait 6;
}

function ref_122f7() {}

function incendiary_pickup_watcher() {
  thread ref_12758("dx_mpa_ustl_order_attack");
  ref_131f3(0);
  var0 = [["es_courtyard_front_1", "ar", 1], ["es_courtyard_front_2", "ar", 1], ["es_courtyard_front_3", "ar", 1, undefined, ["close", 1000]], ["es_courtyard_front_4", "ar", 2], ["es_courtyard_front_5", "ar", 2], ["es_courtyard_front_6", "ar", 3], ["es_courtyard_front_7", "ar", 4, undefined, ["close", 1000]], ["es_courtyard_side_1", "ar", 1, undefined, ["close", 1000]], ["es_courtyard_side_2", "ar", 2, undefined, ["close", 1000]], ["es_courtyard_side_3", "ar", 3, undefined, ["close", 1000]], ["es_courtyard_upper_mid", "smg", 1, undefined, ["close", 800]], ["es_courtyard_upper_left_1", "ar", 3], ["es_courtyard_upper_left_2", "ar", 2], ["es_courtyard_upper_left_3", "shotgun", 1, undefined, ["close", 600]], ["es_courtyard_upper_left_4", "shotgun", 4], ["es_courtyard_upper_right_1", "ar", 3], ["es_courtyard_upper_right_2", "ar", 2], ["es_courtyard_upper_right_3", "shotgun", 1, undefined, ["close", 600]], ["es_courtyard_upper_right_4", "shotgun", 4], ["es_courtyard_lower_mid", "ar", 1], ["es_courtyard_lower_left_1", "ar", 3], ["es_courtyard_lower_left_2", "ar", 3], ["es_courtyard_lower_left_3", "ar", 4], ["es_courtyard_lower_left_4", "shotgun", 4, undefined, ["close", 600]], ["es_courtyard_lower_right_1", "ar", 3], ["es_courtyard_lower_right_2", "ar", 3], ["es_courtyard_lower_right_3", "ar", 4], ["es_courtyard_lower_right_4", "shotgun", 4, undefined, ["close", 600]]];
  thread ref_134ed(var0, 0);
  var1 = [[[[1, "smg"], [1, "ar"]], [[2, "smg"], [1, "ar"]], [[3, "smg"], [1, "ar"]], [[4, "smg"], [2, "ar"]]]];
  var2 = ["courtyard_right", "courtyard_rear"];
  var3 = ["pool", "greenhouse", "sidehouse"];
  thread player_sees_hvt_leaving_vo("intel_collected", "courtyard_all", var2, var3, var1);
  scripts\engine\utility::flag_wait("intel_collected");
  var1 = [[[[1, "shotgun"], [2, "ar"]], [[1, "shotgun"], [4, "ar"]], [[1, "shotgun"], [6, "ar"]], [[2, "shotgun"], [6, "ar"]]], [[[2, "smg"], [1, "ar"]], [[2, "smg"], [2, "ar"]], [[4, "smg"], [3, "ar"]], [[4, "smg"], [4, "ar"]]]];
  var2 = ["greenhouse", "sidehouse", "church"];
  var3 = ["pool", "center"];
  thread player_sees_hvt_leaving_vo("intel_captured_courtyard", undefined, var2, var3, var1);
  scripts\engine\utility::flag_wait_either("intel_captured_courtyard", "left_objective_radius");
}

function ref_13df5() {
  thread ref_14344();
  var0 = [["es_trucks_defend_1", "ar", 1], ["es_trucks_defend_2", "ar", 1, undefined, ["close", 600]], ["es_trucks_defend_3", "lmg", 2], ["es_trucks_defend_4", "ar", 1], ["es_trucks_defend_5", "ar", 2], ["es_trucks_defend_6", "ar", 2], ["es_trucks_defend_7", "ar", 3], ["es_trucks_defend_8", "lmg", 3], ["es_trucks_defend_9", "ar", 4], ["es_trucks_defend_10", "ar", 4]];
  thread ref_134ed(var0, 1);
  thread ref_14347();
  scripts\engine\utility::flag_wait("intel_captured_courtyard");
  ref_131f3(1);
  thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(10000, 10000, (0, 90, 0), scripts\engine\utility::getStruct("carepackage_center", "targetname").origin, "precision_airstrike", &ref_1249a);
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpo_usop_airdrop_use");
  var1 = [[[[1, "smg"], [1, "ar"]], [[2, "smg"], [1, "ar"]], [[3, "smg"], [1, "ar"]], [[4, "smg"], [2, "ar"]]]];
  var2 = ["shed_wall"];
  var3 = ["shed_wall"];
  thread player_sees_hvt_leaving_vo("intel_collected", "shed_all", var2, var3, var1);

  if(!scripts\engine\utility::flag("intel_collected")) {
    var4 = getEnt("garden_defend", "targetname");

    while(!trial_turret_thread_func(var4)) {
      waitframe();
    }
  }

  var2 = ["pool", "main_lower"];
  var3 = ["monument", "church", "sidehouse"];
  var5 = [["es_trucks_window_front", "sniper", 2], ["es_sniper_balcony_1", "sniper", 1], ["es_sniper_balcony_2", "sniper", 3], ["es_sniper_balcony_3", "sniper", 3], ["es_trucks_window_side_1", "sniper", 1], ["es_trucks_window_side_2", "sniper", 4]];
  thread ref_134ed(var5, 1);
  var6 = [[[4, "ar"]], [[6, "ar"]], [[8, "ar"]], [[10, "ar"]]];
  ref_1321a("garden_chopper_target", var6, 1);
  var7 = scripts\common\utility::getvehiclespawner("garden_chopper_1", "targetname");
  var8 = var7 scripts\common\utility::spawn_vehicle();
  var8.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var8);
  thread heli_crash_on_pilot_death();
  thread heli_death_thread();
  thread ref_14352(var8);
  scripts\engine\utility::flag_wait("intel_collected");
  var1 = [[[[1, "smg"], [2, "ar"]], [[1, "smg"], [4, "ar"]], [[1, "smg"], [6, "ar"]], [[2, "smg"], [6, "ar"]]], [[[1, "smg"], [2, "ar"]], [[2, "smg"], [2, "ar"], [1, "lmg"]], [[2, "smg"], [4, "ar"], [1, "lmg"]], [[3, "smg"], [4, "ar"], [2, "lmg"]]], [[[1, "smg"], [2, "ar"]], [[2, "smg"], [2, "ar"], [1, "shotgun"]], [[2, "smg"], [4, "ar"], [1, "shotgun"]], [[2, "smg"], [5, "ar"], [1, "shotgun"]]]];
  var2 = ["pool", "main_lower"];
  var3 = ["monument", "church", "sidehouse"];
  thread player_sees_hvt_leaving_vo("intel_captured_trucks", undefined, var2, var3, var1);
  scripts\engine\utility::flag_wait_either("intel_captured_trucks", "left_objective_radius");
}

function ref_1338e() {
  var0 = [["es_sidehouse_defend_front_1", "ar", 1, undefined, ["close", 600]], ["es_sidehouse_defend_front_2", "ar", 1, undefined, ["close", 600]], ["es_sidehouse_defend_front_3", "ar", 2]];
  thread ref_134ed(var0, 2);
  var1 = getEnt("map_left_side", "targetname");
  thread ref_14346(var1);
  scripts\engine\utility::flag_wait("intel_captured_trucks");
  ref_131f3(2);
  thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(10000, 10000, (0, 90, 0), scripts\engine\utility::getStruct("carepackage_greenhouse", "targetname").origin, "sentry", &ref_1249b);
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpo_usop_airdrop_use");

  while(callback_subscribe(var1)) {
    waitframe();
  }

  thread ref_12758("dx_mpa_ustl_hint_killall");
  var2 = [[[[1, "smg"], [1, "ar"]], [[2, "smg"], [1, "ar"]], [[3, "smg"], [1, "ar"]], [[4, "smg"], [2, "ar"]]]];
  var3 = ["greenhouse", "courtyard_lower"];
  var4 = ["greenhouse_back", "garden", "main_lower"];
  thread player_sees_hvt_leaving_vo("intel_collected", "sidehouse_all", var3, var4, var2);
  var5 = [["es_sidehouse_defend_interior_1", "ar", 1, "molotov", ["close", 800]], ["es_sidehouse_defend_interior_2", "ar", 2, "flash"], ["es_sidehouse_defend_interior_3", "ar", 2, "molotov"], ["es_sidehouse_defend_interior_4", "shotgun", 1, "molotov", ["close", 600]], ["es_sidehouse_defend_interior_5", "ar", 3, "flash"], ["es_sidehouse_defend_interior_6", "ar", 1, "flash"], ["es_sidehouse_defend_interior_7", "smg", 4, "flash"], ["es_sidehouse_defend_courtyard_1", "shotgun", 1, "flash", ["advance", 800]], ["es_sidehouse_defend_courtyard_2", "ar", 2, "molotov"], ["es_sidehouse_defend_courtyard_3", "ar", 3, "molotov"], ["es_sidehouse_defend_pool_1", "smg", 1, "molotov"], ["es_sidehouse_defend_pool_2", "ar", 1, "flash"], ["es_sidehouse_defend_pool_3", "ar", 2, "flash"], ["es_sidehouse_defend_pool_4", "juggernaut", 3, "flash", ["close", 800]], ["es_sidehouse_defend_pool_5", "ar", 1, "molotov"], ["es_sidehouse_defend_pool_6", "ar", 3, "molotov"], ["es_sidehouse_defend_pool_7", "smg", 4, "molotov", ["close", 800]], ["es_sidehouse_defend_pool_roof_1", "rpg", 1, "flash"], ["es_sidehouse_defend_pool_roof_2", "sniper", 2, "molotov"], ["es_sidehouse_defend_pool_roof_3", "rpg", 3, "flash"], ["es_sidehouse_defend_pool_roof_4", "sniper", 4, "flash"]];
  thread ref_134ed(var5, 2);
  scripts\engine\utility::flag_wait("intel_collected");
  var2 = [[[[1, "shotgun"], [2, "ar"]], [[1, "shotgun"], [4, "ar"]], [[1, "shotgun"], [6, "ar"]], [[2, "shotgun"], [6, "ar"]]], [[[2, "smg"], [1, "ar"]], [[2, "smg"], [2, "ar"]], [[4, "smg"], [3, "ar"]], [[4, "smg"], [4, "ar"]]], [[[2, "smg"], [1, "lmg"], [1, "shotgun"]], [[2, "smg"], [2, "lmg"], [2, "shotgun"]], [[4, "smg"], [2, "lmg"], [3, "shotgun"]], [[4, "smg"], [3, "lmg"], [4, "shotgun"]]]];
  var3 = ["greenhouse", "courtyard_lower"];
  var4 = ["greenhouse_back", "garden", "main_lower"];
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_cps_lass_callout_enemy_squad_spawning_30");
  thread player_sees_hvt_leaving_vo("intel_captured_sidehouse", undefined, var3, var4, var2);
  var6 = [[[4, "ar"]], [[6, "ar"]], [[8, "ar"]], [[10, "ar"]]];
  ref_1321a("center_chopper_target", var6, 3);
  var7 = scripts\common\utility::getvehiclespawner("center_chopper_1", "targetname");
  var8 = var7 scripts\common\utility::spawn_vehicle();
  var8.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var8);
  thread heli_crash_on_pilot_death();
  thread heli_death_thread();
  thread ref_14352(var8);
  scripts\engine\utility::flag_wait_either("intel_captured_sidehouse", "left_objective_radius");
}

function ref_11a71() {
  scripts\engine\utility::flag_wait("intel_captured_sidehouse");
  thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(10000, 10000, (0, 90, 0), scripts\engine\utility::getStruct("carepackage_church", "targetname").origin, "sentry", &ref_1249b);
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_mpo_usop_airdrop_use");
  var0 = [["es_mainhouse_churchroof_1", "rpg", 1], ["es_mainhouse_churchroof_2", "rpg", 3], ["es_main_defend_lower_1", "ar", 1], ["es_main_defend_lower_2", "smg", 2, undefined, ["close", 800]], ["es_main_defend_lower_3", "ar", 2], ["es_main_defend_lower_4", "ar", 3], ["es_main_defend_lower_5", "shotgun", 1, undefined, ["close", 600]], ["es_main_defend_lower_6", "shotgun", 3], ["es_main_defend_lower_7", "lmg", 1], ["es_main_defend_lower_8", "smg", 4], ["es_main_defend_lower_9", "juggernaut", 3], ["es_main_defend_mid_2", "ar", 1], ["es_main_defend_mid_3", "shotgun", 2, undefined, ["close", 800]], ["es_main_defend_mid_4", "smg", 1], ["es_main_defend_mid_5", "smg", 2], ["es_main_defend_mid_6", "ar", 3, undefined, ["close", 800]], ["es_main_defend_mid_7", "ar", 3], ["es_main_defend_mid_8", "lmg", 4]];
  thread ref_134ed(var0, 3);
  var1 = [[[[1, "smg"], [1, "ar"]], [[2, "smg"], [1, "ar"]], [[3, "smg"], [1, "ar"]], [[4, "smg"], [2, "ar"]]]];
  var2 = ["garden", "shed"];
  var3 = ["monument", "courtyard_lower", "sidehouse"];
  thread player_sees_hvt_leaving_vo("intel_collected", "mainhouse_all", var2, var3, var1);
  ref_131f3(3);
  thread ref_1431b();
  thread ref_14345();
  scripts\engine\utility::flag_wait("intel_collected");
  var4 = [[[2, "ar"], [2, "lmg"]], [[4, "ar"], [2, "lmg"]], [[5, "ar"], [3, "lmg"]], [[6, "ar"], [4, "lmg"]]];
  ref_1321a("center_chopper_2_target", var4, 4);
  thread ref_12758("dx_cps_lass_bank_enemy_reinforcements_10");
  var5 = scripts\common\utility::getvehiclespawner("center_chopper_2", "targetname");
  var6 = var5 scripts\common\utility::spawn_vehicle();
  var6.script_vehicle_selfremove = 1;
  thread scripts\common\vehicle_paths::gopath(var6);
  thread heli_crash_on_pilot_death();
  thread ref_14353();
  thread heli_death_thread();
  ref_1321a("garden_chopper_2_target", var4, 4);
  var7 = scripts\common\utility::getvehiclespawner("garden_chopper_2", "targetname");
  var8 = var7 scripts\common\utility::spawn_vehicle();
  thread scripts\common\vehicle_paths::gopath(var8);
  thread heli_crash_on_pilot_death();
  thread ref_14353();
  thread heli_death_thread();
  var1 = [[[[2, "smg"], [1, "ar"], [1, "shotgun"]], [[2, "smg"], [2, "ar"], [1, "shotgun"]], [[4, "smg"], [3, "ar"], [2, "shotgun"]], [[4, "smg"], [4, "ar"], [2, "shotgun"]]], [[[2, "shotgun"], [1, "ar"], [1, "lmg"]], [[2, "shotgun"], [2, "ar"], [1, "lmg"]], [[4, "shotgun"], [3, "ar"], [2, "lmg"]], [[4, "shotgun"], [4, "ar"], [2, "lmg"]]]];
  var2 = ["garden", "sidehouse"];
  var3 = ["monument", "courtyard_lower", "shed"];
  thread player_sees_hvt_leaving_vo("intel_captured_mainhouse", undefined, var2, var3, var1);
  scripts\engine\utility::flag_wait("intel_captured_mainhouse");
}

function oil_puddles() {
  var0 = [["es_exfil_1", "lmg", 1], ["es_exfil_2", "ar", 1], ["es_exfil_3", "shotgun", 1, undefined, ["close", 800]], ["es_exfil_4", "ar", 2], ["es_exfil_5", "ar", 3], ["es_exfil_6", "shotgun", 3, undefined, ["close", 800]], ["es_exfil_7", "ar", 4]];
  thread ref_134ed(var0, 4);
  thread ref_140e4();
  thread pointinsquare();
  wait 2;
  var1 = scripts\cp\cp_objectives::requestworldid("exfil", 10);
  objective_setdescription(var1, &"CP_SO_ESTATE/PROCEED_TO_EXFIL");
  objective_setlabel(var1, &"CP_SO_ESTATE/EXFIL");
  objective_setplayintro(var1, 1);
  objective_setplayoutro(var1, 0);
  objective_position(var1, scripts\engine\utility::getStruct("exfil_objective", "targetname").origin);
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_state(var1, "current");
  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_1_index", 6);
  var2 = getEnt("exfil_volume", "targetname");
  var3 = 1;

  while(var3) {
    if(isDefined(level.playervehicle) && ispointinvolume(level.playervehicle.origin, var2) && !level.playervehicle.isempty) {
      var3 = 0;
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
  var0 = getEnt("van_collision", "targetname");
  var0 notsolid();
  var1 = getEnt("van_blocker", "targetname");
  var1 notsolid();
  var2 = scripts\engine\utility::getStruct("van_move_1", "targetname");
  var3 = scripts\engine\utility::getStruct("van_move_2", "targetname");
  var4 = scripts\engine\utility::getStruct("van_move_3", "targetname");
  var5 = scripts\engine\utility::getStruct("van_move_4", "targetname");
  var6 = scripts\engine\utility::getStruct("van_move_5", "targetname");
  var7 = scripts\engine\utility::getStruct("van_move_6", "targetname");
  var8 = scripts\engine\utility::getStruct("van_move_7", "targetname");
  var1 moveTo(var2.origin, 2, 1.5, 0);
  var1 rotateTo(var2.angles, 2, 1.5, 0);
  wait 2;
  var1 moveTo(var3.origin, 1);
  var1 rotateTo(var3.angles, 1);
  wait 1;
  var1 moveTo(var4.origin, 2);
  var1 rotateTo(var4.angles, 2);
  wait 2;
  var1 moveTo(var5.origin, 3, 1, 0);
  var1 rotateTo(var5.angles, 3, 1, 0);
  wait 3;
  var1 moveTo(var6.origin, 3, 1, 0);
  var1 rotateTo(var6.angles, 3, 1, 0);
  wait 3;
  var1 moveTo(var7.origin, 3, 1, 0);
  var1 rotateTo(var7.angles, 3, 1, 0);
  wait 3;
  var1 moveTo(var8.origin, 3, 1, 0);
  var1 rotateTo(var8.angles, 3, 1, 0);
}

function pointinsquare() {
  var0 = getEnt("exit_gate_left", "targetname");
  var1 = scripts\engine\utility::getStruct("exit_gate_left_closed", "targetname");
  var0 moveTo(var1.origin, 4, 3, 1);
  var0 rotateTo(var1.angles, 4, 2, 1);
  var2 = getEnt("exit_gate_right", "targetname");
  var3 = scripts\engine\utility::getStruct("exit_gate_right_closed", "targetname");
  var2 moveTo(var3.origin, 4.5, 3.5, 1);
  var2 rotateTo(var3.angles, 4.5, 3.5, 1);
  scripts\engine\utility::flag_set("gate_closed");
}

function poke_the_player_after_faux_death() {
  var0 = 2;
  var1 = 0.2;
  var2 = 1;
  var3 = 2;
  var4 = 0.2;
  var5 = 1.1;

  if(isDefined(level.playervehicle) && length(level.playervehicle vehicle_getvelocity()) > 200) {
    var0 = 0.5;
    var1 = 0;
    var2 = 0.4;
    var3 = 0.5;
    var4 = 0;
    var5 = 0.35;
  }

  var6 = getEnt("exit_gate_left", "targetname");
  var7 = scripts\engine\utility::getStruct("exit_gate_left_open", "targetname");
  var6 moveTo(var7.origin, var0, var1, var2);
  var6 rotateTo(var7.angles, var0, var1, var2);
  var8 = getEnt("exit_gate_right", "targetname");
  var9 = scripts\engine\utility::getStruct("exit_gate_right_open", "targetname");
  var8 moveTo(var9.origin, var3, var4, var5);
  var8 rotateTo(var9.angles, var3, var4, var5);
}

function ref_131f3(var0) {
  wait 2;
  scripts\engine\utility::flag_clear("intel_collected");
  scripts\engine\utility::flag_clear("left_objective_radius");
  waitframe();
  level.initvo = scripts\cp\cp_objectives::requestworldid("intel_" + var0, 10);
  level.initusage = "";
  var1 = "";
  var2 = [];
  level.ref_11f90 = undefined;
  level.ref_11f88 = "";
  level.ref_12bbf = "";
  level.useeventamount = 0;
  var3 = 0;

  switch (var0) {
    case 0:
      level.ref_11f90 = scripts\engine\utility::getStruct("objective_courtyard", "targetname");
      level.initvehicles = "intel_captured_courtyard";
      var1 = "icon_waypoint_dom_a";
      var2 = scripts\engine\utility::getStructArray("intel_courtyard", "targetname");
      level.ref_11f88 = &"CP_SO_ESTATE/SEARCH_CLOCKTOWER_BUILDING";
      level.initusage = "dx_cps_kama_safehouse_intel_gathered_10";
      var3 = 2;
      break;
    case 1:
      level.ref_11f90 = scripts\engine\utility::getStruct("objective_trucks", "targetname");
      level.initvehicles = "intel_captured_trucks";
      var1 = "icon_waypoint_dom_b";
      var2 = scripts\engine\utility::getStructArray("intel_trucks", "targetname");
      level.ref_11f88 = &"CP_SO_ESTATE/SEARCH_TRUCKS";
      level.initusage = "dx_cps_kama_safehouse_intel_gathered_20";
      var3 = 3;
      break;
    case 2:
      level.ref_11f90 = scripts\engine\utility::getStruct("objective_sidehouse", "targetname");
      level.initvehicles = "intel_captured_sidehouse";
      var1 = "icon_waypoint_dom_c";
      var2 = scripts\engine\utility::getStructArray("intel_sidehouse", "targetname");
      level.ref_11f88 = &"CP_SO_ESTATE/SEARCH_POOL_AND_SERVICE";
      level.initusage = "dx_cps_kama_safehouse_intel_gathered_10";
      level.ref_12bbf = &"CP_SO_ESTATE/SEARCH_POOL_AND_SERVICE";
      level.useeventamount = 1;
      var3 = 4;
      break;
    case 3:
      level.ref_11f90 = scripts\engine\utility::getStruct("objective_mainhouse", "targetname");
      level.initvehicles = "intel_captured_mainhouse";
      var1 = "icon_waypoint_dom_d";
      var2 = scripts\engine\utility::getStructArray("intel_mainhouse", "targetname");
      level.ref_11f88 = &"CP_SO_ESTATE/SEARCH_MAIN_HOUSE";
      level.initusage = "dx_mpa_rutl_exfillosing_start_losingteam";
      var3 = 5;
      break;
  }

  var4 = scripts\engine\utility::random(var2);
  var5 = scripts\cp\laser_traps\cp_laser_traps::trial_active_fob(var4.origin, var4.angles, &train_elements_disable);
  scripts\cp\cp_outline_utility::outlineenableforall(var5, "outline_depth_white", "equipment");
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

  objective_icon(level.initvo, var1);
  objective_setshowoncompass(level.initvo, 1);
  objective_state(level.initvo, "current");
  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_1_index", var3);
}

function train_elements_disable(var0, var1) {
  level.audio_jugg_death = [];

  foreach(var3 in getaiarray("axis")) {
    var4 = 0;

    if(istrue(var3.matchdata_logkillstreakevent)) {
      var4 = 1;
    }

    if(isDefined(var3.ridingvehicle)) {
      var4 = 1;
    }

    if(!var4) {
      level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var3);
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
  var0 notify("clear_tutorial_messages");
  var0 clearhudtutorialmessage(1);
  var0 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SO_ESTATE/CARRYING_INTEL", 5);
  var6 = deleteheadicon(var0);
  var0.headicon = var6;
  setheadiconenemyimage(var6, "hud_icon_sng_intel");
  setheadiconzoffset(var6, 1);
  addclienttoheadiconmask(var6, 10);

  foreach(var8 in level.players) {
    var8 playlocalsound("cp_intel_pickup");

    if(var8 != var0) {
      var8 notify("clear_tutorial_messages");
      var8 clearhudtutorialmessage(1);
      var8 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SO_ESTATE/DEFEND_INTEL", 5);
    }
  }

  thread getcirclerangemin(var0, var1.objid);
}

function getcirclerangemin(var0, var1) {
  var2 = var0.origin;
  var3 = var0.angles;

  while(isDefined(var0) && !scripts\cp\cp_laststand::player_in_laststand(var0) && var0 scripts\cp_mp\utility\player_utility::_isalive() && !scripts\engine\utility::flag(level.initvehicles)) {
    var2 = var0.origin;
    var3 = var0.angles;

    if(isDefined(level.playervehicle) && distance(var0.origin, level.playervehicle.origin) <= 128) {
      scripts\engine\utility::flag_set(level.initvehicles);
    }

    if(distance2d(var0.origin, level.ref_11f90.origin) > level.ref_11f90.radius) {
      scripts\engine\utility::flag_set("left_objective_radius");
    }

    waitframe();
  }

  scripts\engine\utility::flag_clear("intel_being_carried");

  if(!scripts\engine\utility::flag(level.initvehicles)) {
    var4 = scripts\cp\laser_traps\cp_laser_traps::trial_active_fob(var2, var3, &train_elements_disable);
    objective_position(level.initvo, var2 + (0, 0, 12));
    objective_setlabel(level.initvo, &"CP_SO_ESTATE/OBJ_RECOVER_INTEL");
    objective_setdescription(level.initvo, &"CP_SO_ESTATE/OBJ_RECOVER_INTEL");

    if(isDefined(var0) && var0 scripts\cp_mp\utility\player_utility::_isalive()) {
      setheadiconimage(var0.headicon);
    }

    foreach(var6 in level.players) {
      var6 playlocalsound("cp_intel_drop");
    }

    return;
  }

  objective_state(level.initvo, "done");
  setomnvar("cp_objective_index", 0);

  foreach(var6 in level.players) {
    var6 playlocalsound("cp_intel_complete");
    var6 notify("clear_tutorial_messages");
    var6 clearhudtutorialmessage(1);
  }

  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SO_ESTATE/INTEL_RECOVERED", "allies", 7);
  thread ref_12758(level.initusage);

  if(isDefined(var1) && var1 scripts\cp_mp\utility\player_utility::_isalive()) {
    setheadiconimage(var1.headicon);
  }

  wait 5;
}

function ref_13517(var0, var1) {
  var2 = scripts\engine\utility::getStruct(var0, "targetname");
  var3 = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var2.origin, var2.angles);
  var4 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(var3);
  var5 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(var3);
  thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var3, var4, var5, var1);
}

function ref_135b4() {
  var0 = scripts\engine\utility::getStruct("player_vehicle_spawner", "targetname");

  while(!isDefined(var0)) {
    var0 = scripts\engine\utility::getStruct("player_vehicle_spawner", "targetname");
    waitframe();
  }

  var0.team = "allies";
  level.playervehicle = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var0);
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
  var1 = level.players;
  level.ref_14255 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupantsandreserving(level.playervehicle);

  foreach(var3 in level.ref_14255) {
    var1 = scripts\engine\utility::array_remove(var1, var3);
  }

  foreach(var3 in var1) {
    addteamtoheadiconmask(level.playervehicle.headicon, var3);
  }

  var7 = 0;

  while(isDefined(level.playervehicle)) {
    level.ref_14255 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupantsandreserving(level.playervehicle);

    if(scripts\cp\cp_endgame::gamealreadyended()) {
      foreach(var3 in var1) {
        removeteamfromheadiconmask(level.playervehicle.headicon, var3);
        return 1;
      }
    }

    if(scripts\engine\utility::flag("intel_being_carried")) {
      var7 = 1;

      foreach(var3 in var1) {
        removeteamfromheadiconmask(level.playervehicle.headicon, var3);
      }
    } else {
      if(var7) {
        foreach(var3 in var1) {
          addteamtoheadiconmask(level.playervehicle.headicon, var3);
        }

        var7 = 0;
      }

      foreach(var3 in var1) {
        if(scripts\engine\utility::array_contains(level.ref_14255, var3)) {
          var1 = scripts\engine\utility::array_remove(var1, var3);
          removeteamfromheadiconmask(level.playervehicle.headicon, var3);
        }
      }

      foreach(var3 in level.players) {
        if(!scripts\engine\utility::array_contains(var1, var3) && !scripts\engine\utility::array_contains(level.ref_14255, var3)) {
          var1 = scripts\engine\utility::array_add(var1, var3);
          addteamtoheadiconmask(level.playervehicle.headicon, var3);
        }
      }
    }

    waitframe();
  }

  level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
}

function ref_13513(var0) {
  foreach(var2 in var0) {
    if(level.players.size >= var2[2]) {
      var3 = scripts\engine\utility::getStruct(var2[1], "targetname");
      var4 = undefined;

      switch (var2[1]) {
        case "ammo":
          var4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
        case "frag":
          var4 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
        case "flash":
          var4 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
        case "molotov":
          var4 = scripts\cp\laser_traps\cp_laser_traps::ref_11cb8(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
        case "claymore":
          var4 = scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
        case "snapshot":
          var4 = scripts\cp\laser_traps\cp_laser_traps::ref_13433(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
        case "stim":
          var4 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
        case "c4":
          var4 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
        case "gas":
          var4 = scripts\cp\laser_traps\cp_laser_traps::plunderfxondropthreashold(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
        default:
          var4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(scripts\engine\utility::getStruct(var2[0], "targetname").origin, scripts\engine\utility::getStruct(var2[0], "targetname").angles);
          break;
      }

      if(isDefined(var4)) {
        setheadiconsnaptoedges(var4.headiconid, 1000);
      }
    }
  }
}

function ref_135f7(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var5 in var3) {
    if(int(var5.script_parameters) <= level.players.size) {
      ref_135f5(var5, var1, var2);
    }
  }
}

function ref_135f5(var0, var1, var2) {
  var3 = scripts\cp\cp_weapon::buildweapon(var1, var2);
  var4 = "weapon_" + var1;

  foreach(var6 in var2) {
    var4 += "+" + var6;
  }

  var8 = spawn(var4, var0.origin, 1);
  var8.angles = var0.angles;
  var8 scripts\anim\shared::setscriptammo(var1, var0);
}

function ref_1369f() {
  wait 4;
  level.ref_13690 = [];
  var0 = getEntArray("spawn_region", "script_noteworthy");

  foreach(var2 in var0) {
    level.ref_13690[var2.script_parameters] = var2;
  }

  var4 = scripts\engine\utility::getStructArray("spawn_region", "script_noteworthy");

  foreach(var6 in var4) {
    level.ref_13690[var6.script_parameters] = var6;
  }

  scripts\engine\utility::flag_wait("game_started");
  scripts\engine\utility::flag_set("spawning_ready");
}

function ref_1321a(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");
  level.initteamdatafields = var2;
  var4 = [];

  foreach(var6 in var3) {
    if(isDefined(var6.script_demeanor)) {
      if(!isDefined(var6.script_startingposition)) {
        var4 = scripts\engine\utility::array_add(var4, var6);
      }
    }
  }

  var8 = var1[level.players.size - 1];

  foreach(var10 in var8) {
    for(var11 = 0; var11 < int(var10[0]); var11++) {
      var12 = 1;
      var13 = getaiarray("axis");

      if(getaiarray("axis").size >= 40) {
        var12 = velnumdatapoints(var13);
      }

      if(var12) {
        var6 = var4[0];
        ref_131eb(var6, var10[1]);
        var4 = scripts\engine\utility::array_remove(var4, var6);
      }
    }
  }

  foreach(var6 in var4) {
    scripts\engine\utility::deletestruct_ref(var6);
  }
}

function player_sees_hvt_leaving_vo(var0, var1, var2, var3, var4, var5) {
  level endon(var0);
  var6 = 25;
  var7 = 90;
  var8 = gettime();
  var9 = gettime();
  var10 = 0;

  if(var0 != "intel_collected") {
    level endon("left_objective_radius");
  }

  if(isDefined(var1)) {
    var11 = getEnt(var1, "targetname");

    while(!trial_turret_thread_func(var11)) {
      waitframe();
    }
  }

  if(!isDefined(var5)) {
    var5 = [2, 4, 5, 6];
  }

  var12 = var5[level.players.size - 1];
  var13 = 0;

  for(;;) {
    var14 = [];

    foreach(var16 in level.audio_jugg_death) {
      if(isDefined(var16) && isalive(var16)) {
        var14 = scripts\engine\utility::array_add(var14, var16);
      }
    }

    level.audio_jugg_death = var14;

    foreach(var19 in level.players) {
      var20 = [];

      if(isDefined(var19.ref_12544)) {
        foreach(var16 in var19.ref_12544) {
          if(isDefined(var16) && isalive(var16)) {
            var20 = scripts\engine\utility::array_add(var20, var16);
          }
        }
      }

      var19.ref_12544 = var20;
    }

    var24 = 0;

    if(scripts\engine\utility::flag("intel_collected")) {
      if(level.audio_jugg_death.size > 0) {
        var24 = 1;
      }
    } else if(level.audio_jugg_death.size > var12) {
      var24 = 1;
    }

    if(var24) {
      var25 = level.players[0];

      foreach(var19 in level.players) {
        if(var19.ref_12544.size < var25.ref_12544.size) {
          var25 = var19;
        }
      }

      if(var25.ref_12544.size <= var12 / level.players.size && scripts\engine\utility::time_has_passed(var9, var10)) {
        var16 = scripts\engine\utility::getclosest(var25.origin, level.audio_jugg_death);
        level.audio_jugg_death = scripts\engine\utility::array_remove(level.audio_jugg_death, var16);

        if(isDefined(var16.select_lobby_patrol_spawners)) {
          var16.goalradius = var16.select_lobby_patrol_spawners;
        } else {
          var16.goalradius = 600;
        }

        var16 cleargoalvolume();
        var16 setgoalentity(var25);
        var9 = gettime();
        var25.ref_12544 = scripts\engine\utility::array_add(var25.ref_12544, var16);

        if(scripts\engine\utility::flag("intel_collected")) {
          var10 = 6 - level.players.size;
        } else {
          var10 = 10 - level.players.size;
        }
      }
    } else if(scripts\engine\utility::time_has_passed(var8, var6) && getaiarray("axis").size < var12 && level.brclosealldoors <= 0) {
      ref_13560(ref_12a02(var2, var3), var4[var13]);
      var8 = gettime();
      var13++;

      if(var13 >= var4.size) {
        var13 = 0;
      }

      if(brdownedbyairstriketime()) {
        var6 += 45;
      } else {
        var6 += 10;
      }

      if(var6 > var7) {
        var6 = var7;
      }
    }

    wait 0.1;
  }
}

function brdownedbyairstriketime() {
  if(level.players.size > 1) {
    var0 = 0;

    foreach(var2 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
        var0++;
      }
    }

    if(var0 == level.players.size - 1) {
      return true;
    }
  }

  return false;
}

function ref_13560(var0, var1, var2) {
  var3 = var1[level.players.size - 1];
  var4 = 0;

  foreach(var6 in var0) {
    if(var4) {
      break;
    }

    var7 = level.ref_13690[var6];

    if(trial_turret_thread_func(var7) == 0) {
      var4 = 1;
      var8 = scripts\engine\utility::getStructArray("enemy_spawner_" + var6, "targetname");

      foreach(var10 in var3) {
        for(var11 = 0; var11 < var10[0]; var11++) {
          var12 = 0;

          if(isDefined(var10[2]) && var10[2]) {
            var12 = 1;
          }

          var13 = getaiarray("axis");

          if(var12 && getaiarray("axis").size >= 40) {
            velnumdatapoints(var13);
          }

          if(getaiarray("axis").size < 40) {
            var14 = level.players[0];

            foreach(var16 in level.players) {
              if(var16.ref_12544.size < var14.ref_12544.size) {
                var14 = var16;
              }
            }

            var18 = 600;

            if((var12 || var14.ref_12544.size < 3) && var8.size > 0) {
              var19 = scripts\engine\utility::random(var8);
              var8 = scripts\engine\utility::array_remove(var8, var19);
              var19.count = 1;
              ref_131eb(var19, var10[1]);
              var20 = var19 scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var19.script_type, var19.origin, var19.angles, 1, 1);

              if(isDefined(var2)) {
                var20 setgoalvolumeauto(getEnt(var2, "targetname"));
                level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var20);
              } else {
                var20.select_lobby_patrol_spawners = var19.select_lobby_patrol_spawners;
                var20.goalradius = var19.select_lobby_patrol_spawners;
                var20 setgoalentity(var14);
                var14.ref_12544 = scripts\engine\utility::array_add(var14.ref_12544, var20);
              }

              var21 = var20 scripts\cp\laser_traps\cp_laser_traps::print_spawner_score_for_factor();
              var20 scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy(0);
              var20 scripts\engine\utility::delaythread(5.5, &scripts\cp\laser_traps\cp_laser_traps::set_baseaccuracy, var21);
            }

            waitframe();
          }
        }
      }
    }
  }
}

function ref_134ed(var0, var1) {
  level.ref_14071 = [];
  level.initteamdatafields = var1;

  foreach(var3 in var0) {
    var4 = scripts\engine\utility::getStruct(var3[0], "targetname");

    if(level.players.size >= var3[2]) {
      var5 = 0;

      while(!var5) {
        var6 = 1;
        var7 = getaiarray("axis");

        if(getaiarray("axis").size >= 40) {
          var6 = velnumdatapoints(var7);
        }

        if(var6) {
          ref_134ee(var4, var3, var1);
          var5 = 1;
        }

        waitframe();
      }
    }
  }
}

function ref_134ee(var0, var1, var2, var3) {
  var4 = var0.script_parameters;
  var5 = getEnt(var0.script_parameters, "targetname");

  if(trial_turret_thread_func(var5) && !istrue(var3)) {
    var6 = [];

    foreach(var8 in level.ref_13690) {
      if(!trial_turret_thread_func(var8)) {
        var6 = scripts\engine\utility::array_add(var6, var8);
      }
    }

    var10 = scripts\engine\utility::getclosest(var0.origin, var6);
    var11 = [];
    var12 = scripts\engine\utility::getStructArray("enemy_spawner_" + var10.targetname, "targetname");

    foreach(var14 in var12) {
      if(!scripts\engine\utility::array_contains(level.ref_14071, var14)) {
        var0 = var14;
        level.ref_14071 = scripts\engine\utility::array_add(level.ref_14071, var0);
        break;
      }
    }
  }

  ref_131eb(var0, var1[1]);
  var16 = var0 scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var0.script_type, var0.origin, var0.angles, 1, 1);

  if(var0.script_type != "actor_enemy_cp_rus_juggernaut") {
    var16 setgoalvolumeauto(var5);
  }

  var16.script_parameters = var4;
  var16.set_level_weapons_free = var2;

  if(var0.script_type == "actor_enemy_cp_rus_desert_sniper_nvg") {
    var16 laseron();
    var16.matchdata_logkillstreakevent = 1;
  } else if(var0.script_type == "actor_enemy_cp_rus_desert_rpg_nvg") {
    var16.matchdata_logkillstreakevent = 1;
  } else if(var0.script_type == "actor_enemy_cp_rus_juggernaut") {
    var16.matchdata_logkillstreakevent = 1;
    thread bomber_death_watcher();
    var16.goalheight = 3000;
  }

  if(isDefined(var1[3])) {
    switch (var1[3]) {
      case "molotov":
        bomber_disable_movement_for_time(var16);
        break;
      case "flash":
        bomb_case_explode_vfx_sequence(var16);
        break;
    }
  }

  if(isDefined(var1[4])) {
    switch (var1[4][0]) {
      case "close":
        thread ref_1434a(var16);
        break;
      case "advance":
        thread ref_14349(var16);
        break;
    }

    return;
  }
}

function ref_14345() {
  var0 = getEnt("main_mid_upper", "targetname");

  while(!trial_turret_thread_func(var0)) {
    waitframe();
  }

  var1 = getEnt("main_upper", "targetname");

  if(trial_turret_thread_func(var1)) {
    while(trial_turret_thread_func(var1)) {
      waitframe();
    }
  }

  var2 = scripts\engine\utility::getStruct("es_main_defend_mid_2", "targetname");
  var3 = 0;

  while(!var3) {
    var4 = 1;
    var5 = getaiarray("axis");

    if(getaiarray("axis").size >= 40) {
      var4 = velnumdatapoints(var5);
    }

    if(var4) {
      ref_134ee(var2, ["es_main_defend_mid_2", "juggernaut", 1], 3, 1);
      var3 = 1;
    }

    waitframe();
  }
}

function ref_1434a(var0) {
  var1 = getEnt(self.script_parameters, "targetname");
  var2 = 1;
  var3 = undefined;

  while(var2) {
    var4 = scripts\engine\utility::array_removeundefined(level.players);

    foreach(var6 in var4) {
      if(!isDefined(var6) || !isDefined(var6.origin)) {
        continue;
      }

      if(ispointinvolume(var6.origin, var1)) {
        if(distance(var6.origin, self.origin) <= var0) {
          var3 = var6;
          var2 = 0;
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

  var3.ref_12544 = scripts\engine\utility::array_add(var3.ref_12544, self);
  self cleargoalvolume();
  self setgoalentity(var3);
}

function ref_14349(var0) {
  var1 = 1;
  var2 = undefined;

  while(var1) {
    foreach(var4 in level.players) {
      if(distance(var4.origin, self.origin) <= var0) {
        var2 = var4;
        var1 = 0;
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

  var2.ref_12544 = scripts\engine\utility::array_add(var2.ref_12544, self);
  self cleargoalvolume();
  self setgoalentity(var2);
}

function ref_131eb(var0, var1) {
  var2 = 600;

  switch (var1) {
    case "dmr":
      var0.script_type = "actor_enemy_cp_rus_desert_ar_nvg";
      break;
    case "lmg":
      var0.script_type = "actor_enemy_cp_rus_desert_lmg_nvg";
      break;
    case "juggernaut":
      var0.script_type = "actor_enemy_cp_rus_juggernaut";
      level.brclosealldoors++;
      var2 = 300;
      break;
    case "rpg":
      var0.script_type = "actor_enemy_cp_rus_desert_rpg_nvg";
      break;
    case "shotgun":
      var0.script_type = "actor_enemy_cp_rus_desert_shotgun_nvg";
      var2 = 100;
      break;
    case "smg":
      var0.script_type = "actor_enemy_cp_rus_desert_smg_nvg";
      var2 = 500;
      break;
    case "sniper":
      var0.script_type = "actor_enemy_cp_rus_desert_sniper_nvg";
      var2 = 10000;
      break;
    default:
      var0.script_type = "actor_enemy_cp_rus_desert_ar_nvg";
      break;
  }

  var0.select_lobby_patrol_spawners = var2;
}

function ref_14344() {
  scripts\engine\utility::delaythread(1, &ref_12758, "dx_cps_lass_bank_enemies_vehicle_10");
  var0 = getEnt("map_far_right_side", "targetname");

  while(callback_subscribe(var0)) {
    waitframe();
  }

  var1 = getEnt("view_truck_maingate", "targetname");

  if(!trial_turret_thread_func(var1)) {
    var2 = [[[2, "ar"]], [[3, "ar"]], [[4, "ar"]], [[4, "ar"]]];
    ref_1321a("jeep_maingate_target", var2, 1);
    var3 = scripts\common\utility::getvehiclespawner("jeep_maingate", "targetname");
    var4 = var3 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var4);
    thread ref_14354(var4);
    var5 = [[[2, "ar"]], [[2, "ar"]], [[3, "ar"]], [[4, "ar"]]];
    ref_1321a("jeep_maingate2_target", var5, 1);
    var6 = scripts\common\utility::getvehiclespawner("jeep_maingate2", "targetname");
    var7 = var6 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var7);
    thread ref_14354(var7);
    return;
  }
}

function ref_14346(var0) {
  while(callback_subscribe(var0)) {
    waitframe();
  }

  var1 = getEnt("view_truck_church", "targetname");

  if(!trial_turret_thread_func(var1)) {
    var2 = [[[2, "ar"]], [[3, "ar"]], [[4, "ar"]], [[4, "ar"]]];
    ref_1321a("jeep_church_target", var2, 1);
    var3 = scripts\common\utility::getvehiclespawner("jeep_church", "targetname");
    var4 = var3 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var4);
    thread ref_14354(var4);
  }

  var5 = getEnt("view_truck_sidegate", "targetname");

  if(!trial_turret_thread_func(var5)) {
    var6 = [[[2, "ar"]], [[3, "ar"]], [[4, "ar"]], [[4, "ar"]]];
    ref_1321a("jeep_sidegate_target", var6, 1);
    var7 = scripts\common\utility::getvehiclespawner("jeep_sidegate", "targetname");
    var8 = var7 scripts\common\utility::spawn_vehicle();
    thread scripts\common\vehicle_paths::gopath(var8);
    thread ref_14354(var8);
    return;
  }
}

function ref_12a02(var0, var1) {
  var2 = [];
  var3 = var0;
  var4 = var1;

  for(var5 = 0; var5 < var0.size; var5++) {
    var6 = scripts\engine\utility::random(var3);
    var3 = scripts\engine\utility::array_remove(var3, var6);
    var2 = scripts\engine\utility::array_add(var2, var6);
  }

  for(var5 = 0; var5 < var4.size; var5++) {
    var6 = scripts\engine\utility::random(var4);
    var4 = scripts\engine\utility::array_remove(var4, var6);
    var2 = scripts\engine\utility::array_add(var2, var6);
  }

  return var2;
}

function trial_turret_thread_func() {
  var0 = 1;

  if(isstruct(self)) {
    var0 = 0;
  }

  foreach(var2 in level.players) {
    if(var0) {
      if(ispointinvolume(var2.origin, self)) {
        return true;
      }

      continue;
    }

    if(distance2d(self.origin, var2.origin) <= self.radius) {
      return true;
    }
  }

  return false;
}

function callback_subscribe() {
  var0 = 1;

  if(isstruct(self)) {
    var0 = 0;
  }

  foreach(var2 in level.players) {
    if(var0) {
      if(!ispointinvolume(var2.origin, self)) {
        return false;
      }

      continue;
    }

    if(!distance2d(self.origin, var2.origin) <= self.radius) {
      return false;
    }
  }

  return true;
}

function velnumdatapoints(var0) {
  var1 = 0;
  var2 = undefined;

  foreach(var4 in var0) {
    var5 = 0;

    foreach(var7 in level.players) {
      var5 += distance(var7.origin, var4.origin);
    }

    if(var5 > var1) {
      if(!isDefined(var4.set_level_weapons_free) || isDefined(var4.set_level_weapons_free) && var4.set_level_weapons_free < level.initteamdatafields) {
        var1 = var5;
        var2 = var4;
      }
    }
  }

  if(isDefined(var2)) {
    var2 kill();
    return true;
  }

  return false;
}

function ref_14354(var0) {
  self waittill("unloading");
  var1 = 0;

  foreach(var3 in self.riders) {
    var3 setgoalvolumeauto(getEnt(var0[var1], "targetname"));
    var1++;

    if(var1 >= var0.size) {
      var1 = 0;
    }

    level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var3);
  }
}

function ref_14352(var0) {
  self endon("death");
  self waittill("unloading");
  var1 = 0;

  foreach(var3 in self.riders) {
    if(var3 != self.driver) {
      var3 setgoalvolumeauto(getEnt(var0[var1], "targetname"));
      var1++;

      if(var1 >= var0.size) {
        var1 = 0;
      }

      level.audio_jugg_death = scripts\engine\utility::array_add(level.audio_jugg_death, var3);
    }
  }
}

function ref_14353() {
  self waittill("unloading");

  foreach(var1 in self.riders) {
    if(var1 != self.driver) {
      nextareanags(var1);
    }
  }
}

function nextareanags() {
  if(isDefined(self.select_lobby_patrol_spawners)) {
    self.goalradius = self.select_lobby_patrol_spawners;
  } else {
    self.goalradius = 600;
  }

  var0 = level.players[0];

  foreach(var2 in level.players) {
    if(var2.ref_12544.size < var0.ref_12544.size) {
      var0 = var2;
    }
  }

  var0.ref_12544 = scripts\engine\utility::array_add(var0.ref_12544);
  self setgoalentity(var0);
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
  var0 = getEnt("garden_defend", "targetname");

  while(!trial_turret_thread_func(var0)) {
    waitframe();
  }

  var1 = scripts\engine\utility::getStructArray("trucks_grenade_throw", "targetname");

  foreach(var3 in var1) {
    var4 = magicgrenademanual("smoke_grenade_mp", var3.origin, anglesToForward(var3.angles) * 800, 3, level.player);
    wait randomfloatrange(0.7, 1.5);
  }

  var0 = getEnt("sidehouse_defend_front", "targetname");

  while(!trial_turret_thread_func(var0)) {
    waitframe();
  }
}

function ref_1431b() {
  var0 = getEnt("main_mid", "targetname");
  var1 = getEnt("main_house_mid_center", "targetname");
  var2 = getEnt("main_upper", "targetname");
  var3 = getEnt("main_house_stairs_approach", "targetname");
  var4 = getEnt("mainhouse_lower_right", "targetname");
  var5 = getEnt("mainhouse_parkinglot", "targetname");

  while(!trial_turret_thread_func(var3) && !trial_turret_thread_func(var0)) {
    waitframe();
  }

  if(!trial_turret_thread_func(var0)) {
    thread player_maxhealth("mainhouse_grenade_throw_1");

    while(!trial_turret_thread_func(var0)) {
      waitframe();
    }

    if(!trial_turret_thread_func(var2)) {
      thread player_maxhealth("mainhouse_grenade_throw_2");
    }
  }

  while(!scripts\engine\utility::flag("intel_collected") && !trial_turret_thread_func(var1)) {
    waitframe();
  }

  if(!trial_turret_thread_func(var2)) {
    thread player_maxhealth("mainhouse_grenade_throw_3");
  }

  scripts\engine\utility::flag_wait("intel_collected");

  while(!scripts\engine\utility::flag("intel_captured_mainhouse") && !trial_turret_thread_func(var4) && !trial_turret_thread_func(var5)) {
    waitframe();
  }

  if(!scripts\engine\utility::flag("intel_captured_mainhouse")) {
    var6 = scripts\engine\utility::getStructArray("mainhouse_smokescreen", "targetname");

    foreach(var8 in var6) {
      magicgrenademanual("smoke_grenade_mp", var8.origin + (0, 0, 5), (0, 0, 0), 1, level.player);
      wait randomfloatrange(0.7, 1.5);
    }

    return;
  }
}

function player_maxhealth(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var3 in var1) {
    var4 = 1000;
    magicgrenademanual("flash_grenade_mp", var3.origin, anglesToForward(var3.angles) * var4, 3, level.players[0]);
    wait randomfloatrange(0.7, 1.5);
  }
}

function weapon_xp_iw8_sm_smgolf45(var0, var1) {
  while(var0 > 0) {
    if(istrue(var1)) {
      foreach(var3 in level.players) {
        var3 playlocalsound("match_start_tick");
        var3 setclientomnvar("ui_match_start_countdown", var0);
        var3 setclientomnvar("ui_match_in_progress", 0);
      }
    }

    var0--;
    wait 1;
  }
}

function ref_12758(var0) {
  level.light_tank_removegunnerdamagemod = scripts\engine\utility::array_add(level.light_tank_removegunnerdamagemod, var0);
}

function light_tank_gunnerdamagemodignorefunc() {
  level.light_tank_removegunnerdamagemod = [];

  for(;;) {
    while(level.light_tank_removegunnerdamagemod.size == 0) {
      waitframe();
    }

    var0 = level.light_tank_removegunnerdamagemod[0];
    level.light_tank_removegunnerdamagemod = scripts\engine\utility::array_remove_index(level.light_tank_removegunnerdamagemod, 0);

    if(!isDefined(level.ref_121a7)) {
      level.ref_121a7 = spawn("script_origin", (0, 0, 0));
    }

    level.ref_121a7 stopsounds();
    var1 = lookupsoundlength(var0) * 0.001;
    level.ref_121a7 playSound(var0);
    wait var1;
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

function laser_sights(var0, var1) {
  self waittill("death");
  scripts\cp\cp_objectives::freeworldid(var1);
  objective_state(var0, "done");
}

function ref_14342() {
  var0 = 1;

  while(var0) {
    wait 0.2;

    foreach(var2 in level.players) {
      if(distance(var2.origin, self.origin) <= 2048) {
        var0 = 0;
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
    var0 = scripts\engine\utility::ref_143ad("damage", "flashbang");

    if(var0 == "damage") {
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

  var0 = scripts\cp\utility::getbaseweaponname(self.damageweapon);

  if(var0 == "iw8_sn_alpha50" || var0 == "iw8_sh_oscar12") {
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

function ref_13523(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var3 in var1) {
    thread scripts\cp\laser_traps\cp_laser_traps::ref_13542(var3.origin, var3.angles);
  }
}

function ref_1249b(var0, var1, var2) {
  thread ref_12758("dx_mpa_rutl_sentry_gun_achieve");
}

function ref_1249a(var0, var1, var2) {
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
  var0 = self.origin;

  foreach(var2 in self.riders) {
    var2 kill();
  }

  self stopsounds();
  thread scripts\engine\utility::play_sound_in_space("hind_helicopter_crash", var0);
  playFX(scripts\engine\utility::getfx("vfx_helo_explode"), var0);
  waitframe();
  self delete();
}