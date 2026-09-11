/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_ter.gsc
****************************************************/

function init() {
  level.deletetimedrunhud = spawnStruct();
  level.deletetimedrunhud.autotarget = 0;
  level.deletetimedrunhud.waittillplayerlanded = -1;
  level.deletetimedrunhud.watchflashgrenadeexplode = [];
  level.deletetimedrunhud.teams = ["allies", "axis"];
  level.deletetimedrunhud.ref_12169 = getdvarint("scr_br_ter_outpost_sequential", 1);
  level.deletetimedrunhud.ref_12c45 = getdvarint("scr_br_ter_require_all_outpost", 1);
  level.deletetimedrunhud.brjugg_watchgasdamage = getdvarfloat("scr_br_ter_allow_repair", 1);
  level.deletetimedrunhud.is_main_pilot = getdvarint("scr_br_ter_damageable_repair_plunder", 2);
  level.deletetimedrunhud.is_greater_than_equal_to = getdvarint("scr_br_ter_damageable_destroy_plunder", 2);
  level.deletetimedrunhud.is_in_kill_zone_or_under_bridge_zone = getdvarint("scr_br_ter_damageable_destroy_spawns", 4);
  level.deletetimedrunhud.is_inflictor_a_carepackage = getdvarint("scr_br_ter_damageable_destroy_spawns_max", 6);
  level.deletetimedrunhud.is_in_gas = getdvarint("scr_br_ter_damageable_destroy_spawn_plunder", 3);
  level.deletetimedrunhud.is_helicopter_player_occupied = getdvarint("scr_br_ter_damageable_destroy_spawn_ammo", 4);
  level.deletetimedrunhud.is_hostage_oob = getdvarint("scr_br_ter_damageable_destroy_spawn_armor", 1);
  level.deletetimedrunhud.is_killstreak_valid_for_swat = ["brloot_plunder_cash_common_1", "brloot_plunder_cash_uncommon_1", "brloot_plunder_cash_uncommon_2"];
  level.deletetimedrunhud.is_kidnapping_player = ["brloot_armor_plate"];
  level.deletetimedrunhud.is_instant_use_munition = ["brloot_ammo_12g", "brloot_ammo_50cal", "brloot_ammo_762", "brloot_ammo_919", "brloot_ammo_rocket"];
  level.deletetimedrunhud.ref_141c4 = ["veh_a10fd", "cargo_truck", "jeep", "tac_rover", "atv", "motorcycle"];
  level.deletetimedrunhud.ref_1420a = getdvarfloat("scr_br_ter_vehicle_respawn_delay", 5);
  level.deletetimedrunhud.types = [];
  level.phonesringing_code = getdvarint("scr_br_ter_fd_disable_alt_turret", 1);
  level.phonesringing_singlemorse = getdvarint("scr_br_ter_fd_disable_hud", 1);
  teleport_to_track_start();
  teleport_to_silo_airlock();
  timeoutradialunfill();
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("circle");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("waitLoadoutDone");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("playerCountLandmarks");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("placedKiosks");
  scripts\mp\gametypes\br_gametypes::ref_12b11("spawnInitialVehicles", &spawninitialvehicles);
  scripts\mp\gametypes\br_gametypes::ref_12b11("infilSequence", &manage_fakebody_hides);
  scripts\mp\gametypes\br_gametypes::ref_12b11("skipInfilSequence", &ref_133d6);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerKilledSpawn", &playerrespawn);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
  level.dialog_wait_ready_civ = 6;
  br_circleradiizero();
  br_circleshowdelaydanger();
  thread testclient_run_funcs();
}

function testclient_run_funcs() {
  waittillframeend();
  scripts\mp\flags::gameflaginit("ter_vehicle_spawn", 0);
  scripts\mp\flags::gameflaginit("ter_agent_spawn", 0);
  scripts\mp\flags::gameflaginit("ter_layout_spawned", 0);
  scripts\mp\flags::gameflaginit("infil_complete", 0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", &vehicle_spawn_mp_gamemodesupportsrespawn);
  level.ref_12888 = &emp_drone_proximity_explode;
  level.ref_11c76 = &dyn_door;
  scripts\engine\scriptable::ref_12f5b("ter_damageable", &is_riding_heli);
  level.spawnprotectiontimer = getdvarfloat("scr_br_ter_spawnProtectionTimer", 5);
  level.deletetimedrunhud.ref_12ca1 = getdvarint("scr_br_ter_spawn_delay", 0);
  thread ref_1452d("allies");
  thread ref_1452d("axis");
  tracegroundheightexfil();
  initstructs();
  timed_laser_trap_trigger_array();
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = getDvar("scr_br_ter_layout_name", "default");
  var_1 = level.deletetimedrunhud.watchflashgrenadeexplode[var_0];
  watchfor_pain_or_nearby(var_1);
  scripts\mp\flags::gameflagset("ter_layout_spawned");
  scripts\mp\flags::gameflagset("ter_agent_spawn");
  watchdumpsterplayerexit(var_1);
}

function tracegroundheightexfil() {
  level.deletetimedrunhud.vo = spawnStruct();
  level.deletetimedrunhud.vo.ref_13b72 = [];

  foreach(var_1 in level.deletetimedrunhud.teams) {
    level.deletetimedrunhud.vo.ref_13b7d[var_1] = [];
  }

  var_3 = getdvarint("scr_br_ter_dialog_all_debounce_losing", 5000);
  var_4 = getdvarint("scr_br_ter_dialog_all_debounce_securing", 5000);
  traceresultisValid("objective", "boost_groundwar");
  traceresultisValid("securing_default", "flag_securing", var_4);
  traceresultisValid("securing_base", "hq_securing", var_4);
  traceresultisValid("securing_a", "securing_a", var_4);
  traceresultisValid("securing_b", "securing_b", var_4);
  traceresultisValid("securing_c", "securing_c", var_4);
  traceresultisValid("securing_d", "securing_d", var_4);
  traceresultisValid("securing_e", "securing_e", var_4);
  traceresultisValid("secured_default", "flag_secured");
  traceresultisValid("secured_base", "hq_secured");
  traceresultisValid("secured_a", "secured_a");
  traceresultisValid("secured_b", "secured_b");
  traceresultisValid("secured_c", "secured_c");
  traceresultisValid("secured_d", "secured_d");
  traceresultisValid("secured_e", "secured_e");
  traceresultisValid("losing_default", "flag_losing", var_3);
  traceresultisValid("losing_base", "hq_capturing_enemy", var_3);
  traceresultisValid("losing_a", "losing_a", var_3);
  traceresultisValid("losing_b", "losing_b", var_3);
  traceresultisValid("losing_c", "losing_c", var_3);
  traceresultisValid("losing_d", "losing_d", var_3);
  traceresultisValid("losing_e", "losing_e", var_3);
  traceresultisValid("lost_default", "flag_lost");
  traceresultisValid("lost_base", "hq_disabled");
  traceresultisValid("lost_a", "lost_a");
  traceresultisValid("lost_b", "lost_b");
  traceresultisValid("lost_c", "lost_c");
  traceresultisValid("lost_d", "lost_d");
  traceresultisValid("lost_e", "lost_e");
}

function traceresultisValid(var_0, var_1, var_2) {
  game["dialog"][var_0] = var_1;

  if(isDefined(var_2)) {
    ref_13286(var_0, var_2);
    return;
  }
}

function teleport_to_track_start() {
  level.deletetimedrunhud.is_goal_crowded = [];
  level.deletetimedrunhud.is_lower = ["br_ter_damageable_server", "generator", "oil_drum", "server", "tape_server", "ac_unit", "propane_tank_large", "jugg_agent", "aa_turret"];
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[0]] = init_relic_focus_fire("scriptable");
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[1]] = init_relic_focus_fire("script_model", "br_ter_ent_damageable_generator", 525, "br_ter_ent_damageable_generator_destroyed", 90);
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[2]] = init_relic_focus_fire("script_model", "br_ter_ent_damageable_oil_drum", 375, "br_ter_ent_damageable_oil_drum_destroyed");
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[3]] = init_relic_focus_fire("script_model", "br_ter_ent_damageable_server", 675, "br_ter_ent_damageable_server_destroyed", 0, (12, 12, 0));
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[4]] = init_relic_focus_fire("script_model", "br_ter_ent_damageable_tape_server", 600, "br_ter_ent_damageable_tape_server_destroyed", 180);
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[5]] = init_relic_focus_fire("script_model", "br_ter_ent_damageable_ac_unit", 450, "br_ter_ent_damageable_ac_unit_destroyed", -90, (12, 0, 0));
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[6]] = init_relic_focus_fire("script_model", "br_ter_ent_propane_tank_large", 2200, "br_ter_ent_propane_tank_large_destroyed");
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[7]] = init_relic_focus_fire("jugg_agent");
  level.deletetimedrunhud.is_goal_crowded[level.deletetimedrunhud.is_lower[8]] = init_relic_focus_fire("aa_turret");
}

function init_relic_focus_fire(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.is_minimap_forcedisabled = var_0;

  if(var_0 == "script_model") {
    if(!isDefined(var_4)) {
      var_4 = 0;
    }

    if(!isDefined(var_5)) {
      var_5 = (0, 0, 0);
    }

    var_6.model = var_1;
    var_6.health = var_2;
    var_6.modeldestroyed = var_3;
    var_6.ref_11a49 = var_4;
    var_6.ref_11a3f = var_5;
  } else if(var_0 == "jugg_agent" || var_0 == "aa_turret") {
    if(!isDefined(var_4)) {
      var_4 = 0;
    }

    if(!isDefined(var_5)) {
      var_5 = (0, 0, 0);
    }

    var_6.ref_11a49 = var_4;
    var_6.ref_11a3f = var_5;
  }

  var_6.ref_12c46 = !(var_0 == "aa_turret" && !getdvarint("scr_br_ter_aa_guns_required", 1));
  return var_6;
}

function teleport_to_silo_airlock() {
  var_0 = ["means_of_death", "weapon_type", "weapon_class_name", "weapon_base_name"];

  foreach(var_2 in var_0) {
    level.deletetimedrunhud.is_position_open[var_2] = [];
    level.deletetimedrunhud.is_raid_gamemode[var_2] = [];
  }

  level.deletetimedrunhud.is_raid_gamemode["means_of_death"]["mod_melee"] = 0.1;
  level.deletetimedrunhud.is_raid_gamemode["weapon_class_name"]["spread"] = 0.25;
  level.deletetimedrunhud.is_same_combat_action = getdvarint("scr_br_damageable_vehicle_damage", 50);
  level.deletetimedrunhud.is_scriptable_healthy = getdvarint("scr_br_damageable_vehicle_damage_debounce_ms", 500);
  level.deletetimedrunhud.is_so_stars_enabled = getdvarfloat("scr_br_damageable_vehicle_min_speed", 5);
}

function timeoutradialunfill() {
  level.deletetimedrunhud.ref_1196c = [];
  level.deletetimedrunhud.ref_1196c["default"] = init_server("ui_mp_br_mapmenu_icon_tower", "ui_icon_br_ter_default", &"BR_TER/LOC_NAME_DEFAULT", "default");
  level.deletetimedrunhud.ref_1196c["a"] = init_server("icon_waypoint_dom_a", "ui_icon_br_ter_a", &"BR_TER/LOC_NAME_A", "a");
  level.deletetimedrunhud.ref_1196c["b"] = init_server("icon_waypoint_dom_b", "ui_icon_br_ter_b", &"BR_TER/LOC_NAME_B", "b");
  level.deletetimedrunhud.ref_1196c["c"] = init_server("icon_waypoint_dom_c", "ui_icon_br_ter_c", &"BR_TER/LOC_NAME_C", "c");
  level.deletetimedrunhud.ref_1196c["d"] = init_server("icon_waypoint_dom_d", "ui_icon_br_ter_d", &"BR_TER/LOC_NAME_D", "d");
  level.deletetimedrunhud.ref_1196c["e"] = init_server("icon_waypoint_dom_e", "ui_icon_br_ter_e", &"BR_TER/LOC_NAME_E", "e");

  foreach(var_1 in level.deletetimedrunhud.teams) {
    level.deletetimedrunhud.ref_1196c[var_1] = init_server("ui_mp_br_mapmenu_icon_obstacle", "ui_icon_br_ter_base", &"BR_TER/LOC_NAME_BASE", "base");
  }
}

function init_server(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.ref_11f89 = var_0;
  var_4.hudicon = var_1;
  var_4.locname = var_2;
  var_4.ref_14308 = "_" + var_3;
  return var_4;
}

function initstructs() {
  if(isDefined(level.tower_ground_mortar)) {
    [[level.tower_ground_mortar]]();
    return;
  }
}

function timed_laser_trap_trigger_array() {
  var_0 = scripts\engine\utility::getStructArray("ter_layout", "targetname");

  foreach(var_2 in var_0) {
    var_2.ref_13a8f = "layout";
    var_2.name = var_2.script_noteworthy;
    var_2.script_noteworthy = undefined;
    level.deletetimedrunhud.watchflashgrenadeexplode[var_2.name] = var_2;
  }

  foreach(var_2 in level.deletetimedrunhud.watchflashgrenadeexplode) {
    ref_13a83(var_2);
  }
}

function ref_13a83() {
  self.targets = [];

  if(!isDefined(self.target)) {
    return;
  }

  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  self.target = undefined;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "pass" && isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

      foreach(var_5 in var_3) {
        var_0 = var_5;
      }
    }
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "pass") {
      continue;
    }

    if(!ref_13a90(var_2.script_noteworthy) || !is_riding_hel(var_2.script_parameters) || !ref_14270(var_2.script_parameters)) {
      continue;
    }

    if(!istrue(var_2.ref_128a9)) {
      var_2.ref_13a8f = var_2.script_noteworthy;
      var_2.script_noteworthy = undefined;
      var_2.name = var_2.script_parameters;
      var_2.script_parameters = undefined;

      if(!isDefined(var_2.angles)) {
        var_2.angles = (0, 0, 0);
      }

      var_2.ref_128a9 = 1;
      ref_13a83(var_2);
    }

    if(!isDefined(self.targets[var_2.ref_13a8f])) {
      self.targets[var_2.ref_13a8f] = [];
    }

    var_8 = self.targets[var_2.ref_13a8f].size;
    self.targets[var_2.ref_13a8f][var_8] = var_2;

    if(!isDefined(var_2.ref_13a82)) {
      var_2.ref_13a82 = [];
    }

    var_2.ref_13a82[var_2.ref_13a82.size] = self;
  }
}

function watchfor_pain_or_nearby() {
  allow_br_loot_to_br_marked();

  if(getdvarint("scr_br_auto_gen_plane_start_spawns", 0)) {
    foreach(var_1 in level.deletetimedrunhud.types["base"]) {
      chuckerlogic(var_1);
    }
  }

  level.deletetimedrunhud.types["location"] = scripts\engine\utility::array_combine(level.deletetimedrunhud.types["base"], level.deletetimedrunhud.types["outpost"]);
}

function chuckerlogic() {
  var_0 = undefined;

  foreach(var_2 in self.targets["outpost"]) {
    var_0 = var_2;
    break;
  }

  if(!isDefined(var_0)) {
    return;
  }

  self.targets["spawn_start_plane"] = [];

  if(!isDefined(level.deletetimedrunhud.types["spawn_start_plane"])) {
    level.deletetimedrunhud.types["spawn_start_plane"] = [];
  }

  var_4 = var_0.origin - self.origin;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = vectorNormalize(var_4);
  var_5 = vectortoangles(var_4);
  var_6 = getdvarfloat("scr_br_auto_gen_plane_start_spawns_height", 6000);
  var_7 = getdvarfloat("scr_br_auto_gen_plane_start_spawns_forward", -2000);
  var_8 = getdvarfloat("scr_br_auto_gen_plane_start_spawns_spacing", 800);
  var_9 = getdvarint("scr_br_auto_gen_plane_start_spawns_count", 20);
  var_10 = vectorcross(var_4, (0, 0, 1));
  var_11 = var_10 * var_9 / 2 * var_8 + self.origin + (0, 0, var_6) + var_4 * var_7;

  for(var_12 = 0; var_12 < var_9; var_12++) {
    var_13 = spawnStruct();
    var_13.origin = var_11 - var_10 * var_12 * var_8;
    var_13.angles = var_5;
    var_13.ref_13a8f = "spawn_start_plane";
    var_13.targets = [];
    var_14 = self.targets["spawn_start_plane"].size;
    self.targets["spawn_start_plane"][var_14] = var_13;
    var_14 = level.deletetimedrunhud.types["spawn_start_plane"].size;
    level.deletetimedrunhud.types["spawn_start_plane"][var_14] = var_13;
  }
}

function allow_br_loot_to_br_marked() {
  if(istrue(self.spawned)) {
    return;
  }

  self.spawned = 1;
  var_0 = self.ref_13a8f;

  if(!isDefined(level.deletetimedrunhud.types[var_0])) {
    level.deletetimedrunhud.types[var_0] = [];
  }

  var_1 = level.deletetimedrunhud.types[var_0].size;
  level.deletetimedrunhud.types[var_0][var_1] = self;

  foreach(var_0, var_3 in self.targets) {
    foreach(var_5 in var_3) {
      ref_13a8b(var_5);
      allow_br_loot_to_br_marked(var_5);
    }
  }
}

function ref_13a8b() {
  switch (self.ref_13a8f) {
    case "damageable":
      self.team = self.ref_13a82[0].team;
      thread is_relic_swat_active();
      break;
    case "agent":
      self.team = self.ref_13a82[0].team;
      thread bintheplane();
      break;
    case "vehicle_current":
    case "vehicle_not_destroyed":
    case "vehicle_destroyed":
    case "vehicle":
      thread ref_14262();
      break;
    case "base":
      self.team = self.name;
      target_in_range_and_fov("outpost");
      break;
    case "outpost":
      self.team = self.ref_13a82[0].team;

      if(!isDefined(self.name)) {
        self.name = "default";
      }

      target_in_range_and_fov("outpost");
      break;
    case "kiosk":
      thread wait_for_garage_open();
      break;
    default:
      break;
  }
}

function ref_13a90(var_0) {
  var_1 = "scr_br_ter_disable_";

  if(!isDefined(var_0)) {
    return true;
  }

  switch (var_0) {
    case "agent":
      var_1 += "agent";
      break;
    case "vehicle_current":
    case "vehicle_not_destroyed":
    case "vehicle_destroyed":
    case "vehicle":
      var_1 += "vehicle";
      break;
    case "kiosk":
      var_1 += "kiosk";
      break;
    default:
      return true;
  }

  if(var_1 == "scr_br_ter_disable_") {
    return true;
  }

  if(getdvarint(var_1, 0) != 0) {
    return false;
  }

  return true;
}

function is_relic_swat_active() {
  var_0 = undefined;
  var_1 = level.deletetimedrunhud.is_goal_crowded[self.name];

  switch (var_1.is_minimap_forcedisabled) {
    case "scriptable":
      var_0 = easepower(self.name, self.origin, self.angles);
      break;
    case "script_model":
      var_0 = spawn("script_model", self.origin);
      var_0.angles = self.angles;
      var_0 setModel(var_1.model);
      var_0 solid();
      break;
    case "aa_turret":
      if(isDefined(level.arenaflag_setenabled)) {
        var_0 = self[[level.arenaflag_setenabled]]();
      }

      break;
    default:
      break;
  }

  self.is_minimap_forcedisabled = var_1.is_minimap_forcedisabled;
  self.ref_12c46 = var_1.ref_12c46;
  self.ent = var_0;
  self.ent.ref_13a85 = self;
}

function is_riding_hel(var_0) {
  var_1 = "scr_br_ter_disable_";

  if(!isDefined(var_0)) {
    return true;
  }

  if(var_0 == "aa_turret" && !getdvarint("aa_turrets_enabled", 0)) {
    return false;
  }

  foreach(var_3 in level.deletetimedrunhud.is_lower) {
    if(var_0 == var_3) {
      var_1 += var_3;
      break;
    }
  }

  if(var_1 == "scr_br_ter_disable_") {
    return true;
  }

  if(getdvarint(var_1, 0) != 0) {
    return false;
  }

  return true;
}

function bintheplane() {
  self.state = "init";
  var_0 = level.deletetimedrunhud.is_goal_crowded[self.name];
  self.is_minimap_forcedisabled = var_0.is_minimap_forcedisabled;
}

function ref_14262() {
  self.state = "init";
}

function ref_14270(var_0) {
  var_1 = "scr_br_ter_disable_";

  if(!isDefined(var_0)) {
    return true;
  }

  foreach(var_3 in level.deletetimedrunhud.ref_141c4) {
    if(var_0 == var_3) {
      var_1 += var_3;
      break;
    }
  }

  if(var_1 == "scr_br_ter_disable_") {
    return true;
  }

  if(getdvarint(var_1, 0) != 0) {
    return false;
  }

  return true;
}

function watchdumpsterplayerexit() {
  watchdangerresetaction();

  foreach(var_1 in self.targets["base"]) {
    circle(var_1);
    thread ref_11987(var_1);
  }

  self waittillmatch("child_changed_state", "destroyed");
  var_3 = [];

  foreach(var_1 in self.targets["base"]) {
    if(var_1.state == "destroyed") {
      var_3 = var_1.team;
    }
  }

  if(var_3.size == 1) {
    var_6 = var_3[0];
  } else {
    var_6 = scripts\engine\utility::random(level.deletetimedrunhud.teams);
  }

  var_7 = respawn_flare_used(var_6);
  var_8 = "objective_completed";
  thread scripts\mp\gametypes\br::ref_1209b(var_6, 2, undefined, 1, 1, 1);
  thread scripts\mp\gametypes\br::brendgame(var_7, game["end_reason"][var_8], 0);
}

function ref_11987(var_0) {
  if(isDefined(self.state)) {
    return;
  }

  self endon("destroyed");
  ref_11981(var_0);

  foreach(var_2 in self.targets["outpost"]) {
    thread ref_11987(var_2);
  }

  thread ref_11988();

  if(level.deletetimedrunhud.ref_12169) {
    ref_1198b("protected");
  } else {
    ref_1198b("active");
  }

  if(level.deletetimedrunhud.ref_12c45) {
    ref_11998();
  } else {
    ref_11999();
  }

  ref_1198b("current");
}

function ref_11988() {
  self endon("destroyed");
  ref_11997();
  thread ref_1198b("destroyed");
}

function circle() {}

function ref_11981(var_0) {
  foreach(var_2 in self.targets["damageable"]) {
    sub_civtarget(var_2);
  }

  self.state = "";
  ref_11982(var_0);
  ref_1198b("hidden");
  var_4 = ["spawn_def", "spawn_att", "spawn_start", "spawn_plane", "spawn_start_plane"];

  foreach(var_6 in var_4) {
    if(!isDefined(self.targets[var_6])) {
      continue;
    }

    self.ref_11e85[var_6] = 0;
    self.targets[var_6] = scripts\engine\utility::array_randomize(self.targets[var_6]);
  }
}

function sub_civtarget() {
  self.state = "";
  is_relic_collat_dmg_active("protected");
}

function ref_1198b(var_0, var_1) {
  if(self.state == var_0) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self.state = var_0;

  switch (self.state) {
    case "hidden":
      ref_11989(0);
      ref_1198a("done", 1, 0, 0);
      ref_11990(0);
      break;
    case "protected":
      ref_11989(0);
      ref_1198a("active", 1, 1, 0);
      ref_11990(0.5);
      ref_11971("vehicle");
      ref_11971("vehicle_not_destroyed");
      break;
    case "active":
      ref_11989(1);
      ref_1198a("active", 1, 0, 0);
      ref_11990(1);
      ref_11971("vehicle");
      ref_11971("vehicle_not_destroyed");
      break;
    case "current":
      ref_11989(1);
      ref_1198a("current", 4, 0, 1);
      ref_11990(1);
      ref_11971("vehicle_not_destroyed");
      ref_11971("vehicle_current");
      ref_1196f("agent");
      break;
    case "destroyed":
      foreach(var_3 in self.targets["outpost"]) {
        ref_1198b(var_3, "destroyed", 1);
      }

      ref_11989(0);
      ref_1198a("done", 1, 0, 0);
      ref_11993();
      ref_11971("vehicle_destroyed");
      ref_11979("vehicle_not_destroyed");
      ref_11979("vehicle_current");
      ref_11978("agent");

      if(!var_1) {
        level thread scripts\mp\hud_message::notifyteam("br_ter_outpost_lost", "br_ter_outpost_captured", self.team);
        dmztutendgame(ref_1197e(), respawn_flare_used(self.team));
        dmztutendgame(ref_1197d(), self.team);
      }

      break;
    default:
      break;
  }

  self notify(self.state);

  foreach(var_6 in self.ref_13a82) {
    var_6 notify("child_changed_state", self.state);
  }
}

function ref_11982(var_0) {
  self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid();

  if(self.objidnum != -1) {
    var_1 = ref_1197a();
    scripts\mp\objidpoolmanager::objective_add_objective(self.objidnum, "invisible", self.origin);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, 0);
    scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, var_1.ref_11f89);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, var_0.team);
    objective_setfriendlylabel(self.objidnum, "BR_TER/OBJ_DEFEND");
    objective_setenemylabel(self.objidnum, "BR_TER/OBJ_DESTROY");
    function_0421(self.objidnum, 1);
    return;
  }
}

function brc130airdropcratecapturecallback(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::drop_to_ground(var_0, 128);
  var_3 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_lw_br_juggernaut_ter", var_0, var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_3.team = var_2;

  if(isDefined(level.teamnamelist) && !scripts\engine\utility::array_contains(level.teamnamelist, var_3.team)) {
    level.teamnamelist = scripts\engine\utility::array_add(level.teamnamelist, var_3.team);
  }

  var_4 = getdvarint("scr_br_ter_jugg_health", 3500);
  var_3.loadout_giveweaponobj = 1;
  var_3.maxhealth = var_4;
  var_3.health = var_4;
  var_3.agentdamagefeedback = 0;
  var_3.eliminate_drone_minigun_speed = 10000;
  var_3.eliminate_drone_internal = 2;
  return var_3;
}

function bot_custom_classes_allowed() {
  if(isDefined(self)) {
    self kill();
    return;
  }
}

function br_circleshowdelaydanger() {
  level.agent_funcs["actor_enemy_lw_br_juggernaut_ter"]["on_damaged"] = &frontend5lobby;
  level.agent_funcs["actor_enemy_lw_br_juggernaut_ter"]["gametype_on_damage_finished"] = &scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["actor_enemy_lw_br_juggernaut_ter"]["gametype_on_killed"] = &scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypekilled;
}

function br_circleradiizero() {
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\engine\scriptable::scriptable_setinitcallback(&brc130airdropcrateactivatecallback);
}

function brc130airdropcrateactivatecallback() {
  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  scripts\engine\utility::flag_set("scriptables_ready");
}

function frontend5lobby(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(getdvarint("scr_br_ter_one_shot_kill", 0)) {
    var_2 = 99999;
  }

  scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

function spawninitialvehicles() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\gametypes\br_vehicles::spawninitialvehicles();
    return;
  }

  scripts\mp\flags::gameflagset("ter_vehicle_spawn");
}

function vehicle_spawn_mp_gamemodesupportsrespawn() {
  return false;
}

function onplayerkilled(var_0) {
  var_1 = var_0.victim;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(isDefined(var_1)) {
    if(!istrue(var_1.br_infilstarted)) {
      return;
    }

    ref_126d9(var_1);
    return;
  }
}

function ref_126d9(var_0) {
  if(!istrue(var_0)) {
    if(isDefined(self.ref_136a6)) {
      var_1 = getdvarfloat("scr_br_ter_player_spawn_type_min_sec", 8);
      var_2 = var_1 * 1000;
      var_3 = gettime() - self.ref_136a6;

      if(var_3 < var_2) {
        return;
      }
    }
  }

  var_4 = undefined;
  var_5 = undefined;

  foreach(var_7 in level.deletetimedrunhud.types["location"]) {
    if(var_7.state == "current") {
      var_8 = distance(var_7.origin, self.origin);

      if(!isDefined(var_5) || var_8 < var_5) {
        var_5 = var_8;
        var_4 = var_7;
      }
    }
  }

  if(isDefined(var_4)) {
    var_10 = 1;
    var_11 = ref_1257d();

    if(var_11 == "base") {
      var_12 = ref_12565();
      var_13 = distance(var_12.origin, self.origin);

      if(var_13 < var_5) {
        var_10 = 0;
      }
    }

    if(var_10) {
      if(var_4.team == self.team) {
        ref_12678(var_4);
        return;
      }

      ref_1266e(var_4);
      return;
    }

    return;
  }
}

function manage_fakebody_hides(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1);
  }

  ref_143f7();

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = level.players[var_1];

    if(!isDefined(var_2)) {
      continue;
    }

    if(!isalive(var_2)) {
      var_2 scripts\mp\playerlogic::spawnplayer(0);
    }

    if(istrue(var_2.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13f21(var_2);
    }

    var_2 setclientomnvar("ui_br_infil_started", 1);
    var_2 setclientomnvar("ui_br_infiled", 1);
    var_2.br_infilstarted = 1;

    if(!var_0) {
      var_2 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    }

    thread ref_1255f();
  }

  if(!var_0) {
    wait 2;
  }

  level.disable_super_in_turret.ref_13916 = 0;

  foreach(var_2 in level.players) {
    thread ref_1255c();
    LOC_000000f6:
  }

  scripts\mp\flags::gameflagset("prematch_fade_done");
  ref_143f8(10);

  if(!var_0) {
    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        var_2 scripts\mp\gametypes\br_gulag::gulagfadefromblack();
      }
    }
  }

  waitframe();

  foreach(var_2 in level.players) {
    ref_1255e(var_2);
  }

  scripts\mp\flags::gameflagset("infil_complete");
  dmzwincost("objective");
}

function ref_143f7() {
  var_0 = gettime() + 10000;

  while(gettime() < var_0 && getactiveclientcount() != level.players.size) {
    waitframe();
  }
}

function ref_133d6() {
  manage_fakebody_hides(1);
}

function ref_1255f() {
  ref_1268b("base");
  self.player_enemy = ref_1257c();
  scripts\mp\gametypes\br_gulag::ref_1263e(self.player_enemy);
}

function ref_1255c() {
  self endon("disconnect");
  scripts\mp\gametypes\br_public::ref_1264c();
  self.forcespawnorigin = self.player_enemy.origin;
  self.forcespawnangles = self.player_enemy.angles;
  self.ref_12ca8 = 1;
  self.plotarmor = 1;
  scripts\mp\playerlogic::spawnplayer();

  if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
    scripts\mp\gametypes\br::ref_13f21(self);
  }

  waitframe();
  self.player_enemy = undefined;
  self.plotarmor = undefined;
  self.ref_12ca8 = undefined;
  self.thrust_fx_model = undefined;
  self freezecontrols(1);
  self playerhide();
  scripts\mp\gametypes\br_public::ref_126ed();

  if(ref_13875()) {
    ref_12613();
  }

  level.disable_super_in_turret.ref_13916++;
}

function ref_1255e() {
  self cameraunlink();
  self freezecontrols(0);
  self playershow();
  ref_1255b();
}

function ref_143f8(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1 && level.disable_super_in_turret.ref_13916 < level.players.size) {
    waitframe();
  }
}

function dyn_door(var_0) {
  return true;
}

function playerrespawn(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");

  if(!scripts\mp\flags::gameflag("prematch_done") || !istrue(self.br_infilstarted)) {
    return false;
  }

  thread ref_126a4(var_0);
  return true;
}

function ref_126a4(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  level endon("sudden_death_started");

  if(!istrue(level.debug_safehouse_regroup_start)) {
    self.class = scripts\mp\gametypes\br::ref_1234a();
  }

  var_1 = level.teamdata[self.team]["nextRespawn"];
  var_2 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(var_2 > 1) {
    thread scripts\mp\gametypes\br_spectate::spawnspectator(var_0, undefined, 1);
  }

  self.waitingtospawn = 1;
  emp_drone_proximity_explode(0, var_1);
  self.waitingtospawn = 0;
  thread scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self freezecontrols(1);

  while(!isalive(self)) {
    waitframe();
  }

  waitframe();

  if(getdvarint("scr_br_ter_spawn_attack_dauntless", 0) == 1 && ref_1257d() == "attacker") {
    ref_12613();
  }

  ref_1255b();
  var_3 = !self calloutmarkerping_getEnt();
  var_4 = gettime();

  if(var_3) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(var_4 + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);
  scripts\mp\gametypes\br::ref_13f21(self);
}

function ref_1255b() {
  if(getdvarint("scr_br_ter_last_stand", 0) != 0) {
    scripts\mp\gametypes\br::scriptednode(self);
  }

  scripts\mp\gametypes\br_armor::searchcirclesize(1);
  var_0 = getdvarint("scr_br_ter_start_ammo", 1);

  if(var_0 == -2) {
    foreach(var_2 in [self.primaryweapon, self.secondaryweapon]) {
      if(isDefined(var_2)) {
        var_3 = weaponclipsize(var_2);
        self setweaponammoclip(var_2, var_3);
        self givemaxammo(var_2);
      }
    }

    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  } else if(var_0 == -1) {
    scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  } else if(var_0 > 0) {
    foreach(var_6 in [self.primaryweapon, self.secondaryweapon]) {
      if(isDefined(var_6)) {
        var_3 = weaponclipsize(var_6);
        self setweaponammoclip(var_6, var_3);
        var_2 = asmdevgetallstates(var_6);
        var_7 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_2);

        if(isDefined(var_7)) {
          scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, var_7, var_3 * var_0);
        }
      }
    }

    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  }

  thread scripts\mp\gametypes\br::defend_wave_2();
}

function ref_12613() {
  self skydive_interrupt();
  scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  self.br_contractxpearned = spawn("script_model", self.origin);
  self.br_contractxpearned setModel("tag_origin");
  self.br_contractxpearned unmarkkeyframedmover(1);
  self playerlinkTo(self.br_contractxpearned);
  self playerlinkedoffsetenable();
  allowvipdamage();
  self.br_contractxpearned delete();
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1);
}

function allowvipdamage() {
  self endon("disconnect");
  wait 1;
  var_0 = self.origin;
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1.owner = self;
  var_1.spawntype = "GAME_MODE";
  var_1.cannotbesuspended = 1;
  var_1.modelname = "veh_s4_mil_air_dalpha_wz";
  var_1.vehicletype = "a10_warthog_fd";
  var_2 = spawnStruct();
  var_3 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_1, var_2);

  if(isDefined(var_3)) {
    wait 2;

    while(!isDefined(var_3.vehiclename)) {
      var_3 endon("death");
      waitframe();
    }

    self unlink();
    var_4 = "pilot";
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_3, var_4, self);
    return;
  }
}

function emp_drone_proximity_explode(var_0, var_1) {
  var_2 = 4;
  var_3 = 3;
  var_4 = var_2 + var_3;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\gametypes\br::emp_drone_proximity_explode(var_0);
    return;
  }

  if(self calloutmarkerping_getEnt()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  foreach(var_6 in level.players) {
    var_6 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 1);
  }

  thread scripts\mp\gametypes\br::emp_drone_should_take_damage();

  if(!isDefined(self.thrust_fx_model)) {
    var_8 = runkilltriger(self.team, var_1);
    var_9 = var_8 > 0;
    var_10 = undefined;
    var_11 = max(var_8 - var_4, 0);

    if(var_9) {
      var_10 = ai_spawn_intel_extras(var_8);
      var_12 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

      if(var_12 == 1) {
        self setclientomnvar("ui_show_spectateHud", self getentitynumber());
        scripts\mp\gametypes\br_spectate::ref_1252a();
        scripts\mp\gametypes\br::spawnintermission(self.origin + (0, 0, 100), self.angles);
        scripts\mp\spectating::setdisabled();
        scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_10));
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_10));
      var_13 = ref_12669(var_10);

      if(isDefined(var_13) && var_13 == "select_defender") {
        ref_12561("defender");
      } else if(isDefined(var_13) && var_13 == "select_attacker") {
        ref_12561("attacker");
      }
    }

    self.ref_1286f = ref_1257c();

    if(isDefined(self.ref_1286f)) {
      self.ref_1286f.index = -1;
    }

    var_14 = scripts\mp\gametypes\br_public::ref_126b8(self.ref_1286f.origin, self.ref_1286f.height);
    var_15 = getdvarint("scr_br_drop_prespawn_timeout_ms", 9000);
    scripts\mp\gametypes\br_public::ref_126b9(var_14, var_15, 1, 0, var_10);

    if(var_9) {
      var_16 = 1;
      var_17 = 0.25;
      var_18 = var_16 - var_17;
      thread scripts\mp\gametypes\br_gulag::fadeoutin(var_16);
      wait var_18;
      scripts\mp\gametypes\br_spectate::ref_1252a();
      scripts\mp\gametypes\br::spawnintermission(var_14, self.ref_1286f.angles);
      scripts\mp\spectating::setdisabled();
      scripts\mp\gametypes\br::ending_fade_in(var_14[0], var_14[1], level.juggheli_spawner_jammer5_3);
      self setclientomnvar("ui_br_transition_type", 2);
      wait var_17;
      var_19 = max(var_8 - var_11 - var_16, 0);
      wait var_19;
      scripts\mp\gametypes\br_public::ref_1252b();
      self setclientomnvar("ui_show_spectateHud", -1);
    } else {
      var_20 = 0.5;
      scripts\mp\gametypes\br::ending_fade_in(var_14[0], var_14[1], level.juggheli_spawner_jammer5_3);
      self setclientomnvar("ui_br_transition_type", 4);
      wait var_20;
      scripts\mp\gametypes\br::spawnintermission(var_14, self.ref_1286f.angles);
      scripts\mp\spectating::setdisabled();
      scripts\mp\gametypes\br_public::ref_126ed();
    }
  } else {
    self.thrust_fx_model = undefined;
    scripts\mp\gametypes\br_public::ref_126ed();
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self freezecontrols(0);
}

function ai_spawn_intel_extras(var_0) {
  if(getdvarint("scr_br_ter_enable_wave_respawn", 1) != 0) {
    return (var_0 * 1000);
  }

  return level.deletetimedrunhud.ref_12ca1 * 1000;
}

function ref_12669(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("scr_br_ter_enable_respawn_skip", 0) == 1) {
    self.ref_14391 = scripts\mp\hud_util::createfontstring("default", 1.5);
    self.ref_14391 scripts\mp\hud_util::setpoint("center", "middle", 0, 50);
    self.ref_14391.label = &"BR_TER/RESPAWN";
    var_1 = gettime() + var_0;
    var_2 = gettime();

    while(gettime() < var_1) {
      var_3 = 1000;
      var_4 = gettime() - var_2;

      if(self useButtonPressed() && var_4 > var_3) {
        self.ref_14391 destroy();
        return "select_defender";
      }

      waitframe();
    }

    if(getdvarint("scr_br_ter_wait_to_attack", 0) == 1) {
      self.ref_14391 destroy();
      return "select_attacker";
    }

    self.ref_14391 destroy();
  } else {
    wait var_0 / 1000;
  }

  return "timeout";
}

function ref_1257c(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = self.team;
  var_2 = ref_1257d();
  var_3 = [];

  if(var_2 != "base") {
    foreach(var_5 in level.deletetimedrunhud.types["location"]) {
      var_6 = var_2 == "defender" && var_5.team == self.team || var_2 == "attacker" && var_5.team != self.team;

      if(var_6 && var_5.state == "current") {
        var_3 = var_5;
      }
    }
  }

  if(!var_3.size) {
    foreach(var_9 in level.deletetimedrunhud.types["base"]) {
      if(var_9.team == self.team) {
        var_3 = var_9;
      }
    }
  }

  var_5 = undefined;
  var_11 = undefined;

  if(usestartspawns()) {
    var_9 = ref_12565();

    if(isDefined(var_9.targets["spawn_start"])) {
      var_11 = "spawn_start";
      var_5 = var_9;
    }

    if(ref_13875()) {
      if(isDefined(var_5.targets["spawn_start_plane"])) {
        var_11 = "spawn_start_plane";
      } else {
        var_11 = "spawn_plane";
      }
    }
  }

  if(!isDefined(var_11)) {
    if(var_2 == "attacker") {
      var_11 = "spawn_att";
    } else {
      var_11 = "spawn_def";
    }

    if(canspawnVehicle() && getdvarint("scr_br_ter_spawn_attack_dauntless", 0) == 1 && var_2 == "attacker") {
      var_11 = "spawn_plane";
    }

    if(isDefined(self.ref_1366e)) {
      foreach(var_13 in var_3) {
        if(self.ref_1366e == var_13) {
          var_5 = var_13;
          break;
        }
      }
    }

    if(!isDefined(var_5)) {
      var_5 = scripts\engine\utility::random(var_3);
      self.ref_1366e = var_5;
    }
  }

  var_15 = var_5.targets[var_11][var_5.ref_11e85[var_11]];

  if(!var_0) {
    var_5.ref_11e85[var_11]++;

    if(var_5.ref_11e85[var_11] >= var_5.targets[var_11].size) {
      var_5.ref_11e85[var_11] = 0;
    }
  }

  var_15.height = 0;
  return var_15;
}

function ref_1452d(var_0) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("infil_complete");
  level.teamdata[var_0]["nextRespawn"] = 0;

  if(level.deletetimedrunhud.ref_12ca1 == 0) {
    return;
  }

  for(;;) {
    level.teamdata[var_0]["nextRespawn"] = gettime() + level.deletetimedrunhud.ref_12ca1 * 1000;
    wait level.deletetimedrunhud.ref_12ca1;
  }
}

function runkilltriger(var_0, var_1) {
  if(level.deletetimedrunhud.ref_12ca1 == 0) {
    return 0;
  }

  if(!isDefined(var_1)) {
    var_1 = level.teamdata[var_0]["nextRespawn"];
  }

  var_2 = max(var_1 - gettime(), 0);
  var_3 = int(var_2 / 1000);
  return var_3;
}

function ref_1266e(var_0) {
  ref_1268b("attacker", var_0);
}

function ref_12678(var_0) {
  ref_1268b("defender", var_0);
}

function ref_12561(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.deletetimedrunhud.types["location"]) {
    if(var_3.state == "current" && var_3.team == self.team) {
      var_1 = var_3;
      break;
    }
  }

  if(isDefined(var_1)) {
    ref_1268b(var_0, var_1);
    return;
  }

  var_5 = ref_12565();
  ref_1268b(var_0, var_5);
}

function ref_1268b(var_0, var_1) {
  self.ref_136a6 = gettime();
  self.spawntype = var_0;
  self.ref_1366e = var_1;
}

function ref_1257d() {
  if(!isDefined(self.spawntype)) {
    return "base";
  }

  return self.spawntype;
}

function ref_1198a(var_0, var_1, var_2, var_3) {
  scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, var_0);
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, var_1);
  function_042c(self.objidnum, var_2);
  objective_setshowprogress(self.objidnum, var_3);
}

function ref_11984() {
  self notify("objective_hot");
  self endon("objective_hot");
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 0);
  wait 0.1;
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
  wait 0.5;
  scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 0);
}

function ref_11991() {
  if(level.deletetimedrunhud.spawnaccesscards.ref_14291 == 1) {
    ref_11994("icon", (1, 0.760784, 0.0823529), 1);
    return;
  }

  ref_11994("label_bg", (1, 0.760784, 0.0823529), 1);
}

function ref_11992() {
  thread ref_11995("bar", (1, 0.341176, 0.341176));
  thread ref_11984();
}

function ref_11995(var_0, var_1) {
  if(isDefined(self.spawnanglemax)) {
    foreach(var_3 in level.deletetimedrunhud.teams) {
      var_4 = self.spawnanglemax.monitor_hack_prox[var_3][var_0];

      if(isDefined(var_4)) {
        thread spawn_wheelson_blinking_lights(var_4);
      }
    }

    return;
  }
}

function ref_11994(var_0, var_1, var_2) {
  if(isDefined(self.spawnanglemax)) {
    foreach(var_4 in level.deletetimedrunhud.teams) {
      var_5 = self.spawnanglemax.monitor_hack_prox[var_4][var_0];

      if(isDefined(var_5)) {
        thread spawn_weapon_box_cache(var_5, var_1);
      }
    }

    return;
  }
}

function ref_11990(var_0) {
  if(isDefined(self.spawnanglemax)) {
    foreach(var_2 in level.deletetimedrunhud.teams) {
      foreach(var_4 in self.spawnanglemax.monitor_hack_prox[var_2]) {
        if(!isDefined(var_4)) {
          continue;
        }

        var_4.alpha = var_0;
      }
    }

    return;
  }
}

function ref_11993() {
  if(isDefined(self.spawnanglemax)) {
    foreach(var_1 in level.deletetimedrunhud.teams) {
      foreach(var_4, var_3 in self.spawnanglemax.monitor_hack_prox[var_1]) {
        if(!isDefined(var_3)) {
          continue;
        }

        if(var_4 == "label_bg") {
          if(var_1 == self.team) {
            spawn_weapons_by_player_count(var_3);
            spawndistancemin(var_3, (1, 0.341176, 0.341176));
          } else {
            spawn_weapons_by_player_count(var_3);
            spawndistancemin(var_3, (0.337255, 0.690196, 0.929412));
          }

          continue;
        }

        if(var_4 == "label") {
          if(var_1 == self.team) {
            spawn_weapons_by_player_count(var_3);
            spawndistancemin(var_3, (1, 0.341176, 0.341176));
          } else {
            spawn_weapons_by_player_count(var_3);
            spawndistancemin(var_3, (0.337255, 0.690196, 0.929412));
          }

          continue;
        }

        if(var_4 == "icon") {
          if(var_1 == self.team) {
            var_3 setshader("ui_icon_br_ter_secured", 15, 15);

            if(level.deletetimedrunhud.spawnaccesscards.ref_14291 == 1) {
              spawn_weapons_by_player_count(var_3);
              spawndistancemin(var_3, (1, 0.341176, 0.341176));
            }
          } else {
            var_3 setshader("ui_icon_br_ter_lost", 15, 15);

            if(level.deletetimedrunhud.spawnaccesscards.ref_14291 == 1) {
              spawn_weapons_by_player_count(var_3);
              spawndistancemin(var_3, (0.337255, 0.690196, 0.929412));
            }
          }

          continue;
        }

        if(var_4 == "bar") {
          var_3.alpha = 0;
          continue;
        }

        if(var_4 == "count") {
          var_3 destroy();
        }
      }
    }

    return;
  }
}

function allow_deleteme_on_path(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(istrue(var_3.ref_12c46)) {
      var_1++;
    }
  }

  return var_1;
}

function ref_11996() {
  var_0 = isDefined(self.targets["damageable"]);
  var_1 = isDefined(self.targets["agent"]);
  var_2 = 0;
  var_3 = 0;

  if(var_0) {
    var_3 += allow_deleteme_on_path(self.targets["damageable"]);
  }

  if(var_1) {
    var_3 += allow_deleteme_on_path(self.targets["agent"]);
  }

  if(var_0) {
    foreach(var_5 in self.targets["damageable"]) {
      if(var_5.state == "destroyed" && istrue(var_5.ref_12c46)) {
        var_2++;
      }
    }
  }

  if(var_1) {
    foreach(var_8 in self.targets["agent"]) {
      if(var_8.state == "destroyed" && istrue(var_8.ref_12c46)) {
        var_2++;
      }
    }
  }

  var_10 = var_2 / var_3;
  objective_setprogress(self.objidnum, var_10);

  if(isDefined(self.spawnanglemax)) {
    foreach(var_12 in level.deletetimedrunhud.teams) {
      var_13 = self.spawnanglemax.monitor_hack_prox[var_12]["bar"];

      if(isDefined(var_13)) {
        var_13 setshader("progress_bar_fill", int((1 - var_10) * level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand), 15);
      }

      var_14 = self.spawnanglemax.monitor_hack_prox[var_12]["count"];

      if(isDefined(var_14)) {
        var_14 setvalue(var_3 - var_2);
      }
    }

    return;
  }
}

function ref_11989(var_0) {
  foreach(var_2 in self.targets["damageable"]) {
    if(var_0) {
      if(var_2.state == "protected") {
        is_relic_collat_dmg_active(var_2, "undamaged");
      }

      continue;
    }

    is_relic_collat_dmg_active(var_2, "protected");
  }
}

function ref_11999() {
  for(;;) {
    if(ref_11974()) {
      break;
    }

    self waittillmatch("child_changed_state", "destroyed");
  }
}

function ref_11974() {
  if(!isDefined(self.targets["outpost"])) {
    return true;
  }

  if(!self.targets["outpost"].size) {
    return true;
  }

  foreach(var_1 in self.targets["outpost"]) {
    if(var_1.state == "destroyed") {
      return true;
    }
  }

  return false;
}

function ref_11998() {
  for(;;) {
    if(ref_11973()) {
      break;
    }

    self waittillmatch("child_changed_state", "destroyed");
  }
}

function ref_11973() {
  if(!isDefined(self.targets["outpost"])) {
    return true;
  }

  foreach(var_1 in self.targets["outpost"]) {
    if(var_1.state != "destroyed") {
      return false;
    }
  }

  return true;
}

function ref_11997() {
  for(;;) {
    ref_11996();

    if(ref_11972()) {
      break;
    }

    self waittill("damageable_state_change");
  }
}

function ref_11972() {
  var_0 = isDefined(self.targets["damageable"]);
  var_1 = isDefined(self.targets["agent"]);

  if(!var_0 && !var_1) {
    return true;
  }

  if(var_0) {
    foreach(var_3 in self.targets["damageable"]) {
      if(var_3.state != "destroyed") {
        return false;
      }
    }
  }

  if(var_1) {
    foreach(var_6 in self.targets["agent"]) {
      if(var_6.state != "destroyed") {
        return false;
      }
    }
  }

  return true;
}

function ref_11971(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }

  foreach(var_2 in self.targets[var_0]) {
    thread ref_14229();
  }
}

function ref_14229() {
  if(self.state == "activated") {
    return;
  }

  self.state = "activated";
  self notify("activated");
  scripts\mp\flags::gameflagwait("ter_vehicle_spawn");
  ref_1435d();

  if(!canspawnVehicle()) {
    return;
  }

  thread ref_14269();
}

function ref_14269() {
  self endon("deactivated");
  var_0 = spawnStruct();

  for(;;) {
    var_1 = scripts\mp\gametypes\br_vehicles::tryspawnavehicle(self.name, self, "ter_spawns", var_0);

    if(!isDefined(var_1)) {
      return;
    }

    self.ent = var_1;
    self.ent.ref_13a85 = self;

    if(level.deletetimedrunhud.ref_1420a < 0) {
      return;
    }

    var_1 waittill("death");
    wait level.deletetimedrunhud.ref_1420a;
  }
}

function ref_11970(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }

  foreach(var_2 in self.targets[var_0]) {
    thread ref_1422a();
  }
}

function ref_1422a() {
  ref_14229();
  ref_1423d();
}

function ref_11979(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }

  foreach(var_2 in self.targets[var_0]) {
    thread ref_1423d();
  }
}

function ref_1423d() {
  if(self.state == "deactivated") {
    return;
  }

  self.state = "deactivated";
  self notify("deactivated");
}

function ref_1196f(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }

  foreach(var_2 in self.targets[var_0]) {
    thread binoculars_used();
  }
}

function binoculars_used() {
  if(self.state == "active") {
    return;
  }

  scripts\mp\flags::gameflagwait("ter_agent_spawn");
  ref_1435d();
  thread birds_in_square_monitor();
}

function birds_in_square_monitor() {
  self endon("destroyed");
  var_0 = spawnStruct();

  for(;;) {
    var_1 = brc130airdropcratecapturecallback(self.origin, self.angles, self.team);

    if(!isDefined(var_1)) {
      waitframe();
      continue;
    }

    self.ent = var_1;
    self.ent.ref_13a85 = self;
    is_relic_collat_dmg_active("active");
    var_1 waittill("death", var_2);
    binoculars_watchracedeath(var_2);
    is_relic_collat_dmg_active("destroyed");
    return;
  }
}

function ref_11978(var_0) {
  if(!isDefined(self.targets[var_0])) {
    return;
  }

  foreach(var_2 in self.targets[var_0]) {
    thread binoculars_watchraceadson();
  }
}

function binoculars_watchraceadson() {
  if(self.state == "destroyed") {
    return;
  }

  bot_custom_classes_allowed(self.ent);
  is_relic_collat_dmg_active("destroyed");
}

function ref_1197a() {
  var_0 = self.name;

  if(!isDefined(level.deletetimedrunhud.ref_1196c[self.name])) {
    var_0 = "default";
  }

  return level.deletetimedrunhud.ref_1196c[var_0];
}

function ref_1197f() {
  return ref_1197b("securing");
}

function ref_1197e() {
  return ref_1197b("secured");
}

function ref_1197c() {
  return ref_1197b("losing");
}

function ref_1197d() {
  return ref_1197b("lost");
}

function ref_1197b(var_0) {
  var_1 = ref_1197a();
  return var_0 + var_1.ref_14308;
}

function ref_12565() {
  foreach(var_1 in level.deletetimedrunhud.types["base"]) {
    if(var_1.team == self.team) {
      return var_1;
    }
  }

  return undefined;
}

function ref_125b7(var_0) {
  var_1 = spawnStruct();
  var_1.ref_133e4 = 1;
  scripts\mp\gametypes\br_plunder::playersetplundercount(self.plundercount + var_0, var_1);
}

function respawn_flare_used(var_0) {
  if(var_0 == "allies") {
    return "axis";
  }

  return "allies";
}

function request_crate_drop(var_0) {
  return relic_nobulletdamage_modifyplayerdamage("means_of_death", var_0);
}

function safecheckweapon(var_0) {
  return relic_nobulletdamage_modifyplayerdamage("weapon_type", var_0);
}

function runpain(var_0) {
  return relic_nobulletdamage_modifyplayerdamage("weapon_class_name", var_0);
}

function runlogicbasedoncircuitbreaker(var_0) {
  return relic_nobulletdamage_modifyplayerdamage("weapon_base_name", var_0);
}

function relic_nobulletdamage_modifyplayerdamage(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 1;
  }

  var_1 = tolower(var_1);
  var_2 = level.deletetimedrunhud.is_position_open[var_0][var_1];

  if(!isDefined(var_2)) {
    var_3 = level.deletetimedrunhud.is_raid_gamemode[var_0][var_1];

    if(!isDefined(var_3)) {
      var_3 = 1;
    }

    var_2 = getdvarfloat("scr_br_damage_scale_" + var_0 + "_" + var_1, var_3);
    level.deletetimedrunhud.is_position_open[var_0][var_1] = var_2;
  }

  return var_2;
}

function dmzwincost(var_0) {
  foreach(var_2 in level.deletetimedrunhud.teams) {
    dmztutendgame(var_0, var_2);
  }
}

function dmztutendgame(var_0, var_1) {
  if(unfreezeplayercontrols(var_0, var_1)) {
    return;
  }

  level thread scripts\mp\utility\dialog::leaderdialog(var_0, var_1);
  ref_13287(var_0, var_1);
}

function unfreezeplayercontrols(var_0, var_1) {
  var_2 = rungwperif_tracers(var_0);

  if(!isDefined(var_2) || var_2 == 0) {
    return false;
  }

  var_3 = rungwperifeffets(var_0, var_1);

  if(!isDefined(var_3)) {
    return false;
  }

  return gettime() < var_3 + var_2;
}

function ref_13287(var_0, var_1) {
  if(isDefined(var_1)) {
    level.deletetimedrunhud.vo.ref_13b7d[var_1][var_0] = gettime();
    return;
  }

  foreach(var_1 in level.deletetimedrunhud.teams) {
    ref_13287(var_0, var_1);
  }
}

function rungwperifeffets(var_0, var_1) {
  if(isDefined(var_1)) {
    return level.deletetimedrunhud.vo.ref_13b7d[var_1][var_0];
  }

  var_2 = undefined;

  foreach(var_1 in level.deletetimedrunhud.teams) {
    var_4 = rungwperifeffets(var_0, var_1);

    if(isDefined(var_2)) {
      if(isDefined(var_4) && var_4 < var_2) {
        var_2 = var_4;
      }

      continue;
    }

    var_2 = var_4;
  }
}

function ref_13286(var_0, var_1) {
  var_2 = getdvarint("scr_br_ter_dialog_debounce_" + var_0, var_1);
  level.deletetimedrunhud.vo.ref_13b72[var_0] = var_2;
}

function rungwperif_tracers(var_0) {
  if(!isDefined(level.deletetimedrunhud.vo.ref_13b72[var_0])) {
    ref_13286(var_0, 0);
  }

  return level.deletetimedrunhud.vo.ref_13b72[var_0];
}

function ref_1435d() {
  while(level.deletetimedrunhud.waittillplayerlanded == gettime()) {
    waitframe();
  }

  level.deletetimedrunhud.waittillplayerlanded = gettime();
}

function usestartspawns() {
  return !scripts\mp\flags::gameflag("infil_complete");
}

function is_module_active(var_0) {
  var_1 = self.ref_13a85;

  if(isDefined(var_0.attacker)) {
    if(istrue(var_1.ref_12c46)) {
      var_0.attacker thread scripts\mp\rank::scoreeventpopup("br_ter_obj_destroyed");
      scripts\mp\utility\sound::playsoundonplayers("mp_bodycount_tick_positive", respawn_flare_used(var_1.team));
      scripts\mp\utility\sound::playsoundonplayers("mp_bodycount_tick_negative", var_1.team);
      ref_125b7(var_0.attacker, level.deletetimedrunhud.is_greater_than_equal_to);
    }

    is_moving_platform_train(var_1, var_0);
  }

  is_relic_collat_dmg_active(var_1, "destroyed");
}

function is_moving_platform_train(var_0) {
  if(level.deletetimedrunhud.is_in_kill_zone_or_under_bridge_zone > 0) {
    var_1 = level.deletetimedrunhud.is_in_kill_zone_or_under_bridge_zone;

    if(level.deletetimedrunhud.is_inflictor_a_carepackage > var_1) {
      var_1 = randomintrange(var_1, level.deletetimedrunhud.is_inflictor_a_carepackage);
    }

    var_2 = [];

    for(var_3 = 0; var_3 < level.deletetimedrunhud.is_in_gas; var_3++) {
      var_2 = scripts\engine\utility::random(level.deletetimedrunhud.is_killstreak_valid_for_swat);
    }

    for(var_3 = 0; var_3 < level.deletetimedrunhud.is_hostage_oob; var_3++) {
      var_2 = scripts\engine\utility::random(level.deletetimedrunhud.is_kidnapping_player);
    }

    var_4 = 0;

    if(level.deletetimedrunhud.is_helicopter_player_occupied && isDefined(var_0.objweapon)) {
      var_5 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_0.objweapon);

      if(isDefined(var_5)) {
        var_2 = var_5;
        var_4 = 1;
      }
    }

    for(var_3 = 0; var_3 < level.deletetimedrunhud.is_helicopter_player_occupied - var_4; var_3++) {
      var_2 = scripts\engine\utility::random(level.deletetimedrunhud.is_instant_use_munition);
    }

    var_2 = scripts\engine\utility::array_randomize(var_2);
    var_6 = min(var_1, var_2.size);
    var_7 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var_8 = level.deletetimedrunhud.is_goal_crowded[self.name];

    for(var_3 = 0; var_3 < var_6; var_3++) {
      var_9 = var_2[var_3];
      var_10 = self.origin + rotatevector(var_8.ref_11a3f, self.angles);
      var_11 = self.angles + (0, var_8.ref_11a49, 0);
      scripts\mp\gametypes\br_lootcache::ref_11a41(var_9, var_7, var_10, var_11, 1, 0);
    }

    return;
  }
}

function is_on(var_0) {
  var_1 = var_0.damage;
  var_2 = self.ref_13a85;
  var_3 = getdvarint("scr_br_ter_allow_friendly_damage", 0);

  if(isDefined(var_0.attacker) && var_2.team == var_0.attacker.team && !var_3) {
    var_1 = 0;
  } else if(getdvarint("scr_br_ter_one_shot_kill", 0)) {
    var_1 = 99999;
  } else if(isDefined(var_0.inflictor) && var_0.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(var_0.inflictor vehicle_getspeed() < level.deletetimedrunhud.is_so_stars_enabled) {
      var_1 = 0;
    } else if(isDefined(var_2.ref_11e89) && gettime() < var_2.ref_11e89) {
      var_1 = 0;
    } else {
      var_1 = level.deletetimedrunhud.is_same_combat_action;
      var_2.ref_11e89 = gettime() + level.deletetimedrunhud.is_scriptable_healthy;
    }
  } else {
    var_1 *= request_crate_drop(var_0.meansofdeath);

    if(isDefined(var_0.objweapon)) {
      var_1 *= safecheckweapon(var_0.objweapon.type);
      var_1 *= runpain(var_0.objweapon.classname);
      var_1 *= runlogicbasedoncircuitbreaker(var_0.objweapon.basename);
    }

    var_1 = int(ceil(var_1));
  }

  if(var_1 > 0 && istrue(var_2.ref_12c46)) {
    if(isDefined(var_0.attacker)) {
      ref_1266e(var_0.attacker, var_2.ref_13a82[0]);
    }

    is_relic_collat_dmg_active(var_2, "damaged");
    var_4 = is_object_allowed_in_gametype(var_2);
    dmztutendgame(ref_1197f(var_4), respawn_flare_used(var_4.team));
    dmztutendgame(ref_1197c(var_4), var_4.team);
    ref_11991(var_4);
  }

  return var_1;
}

function binoculars_watchracedeath(var_0) {
  var_1 = self.ent;

  if(isDefined(var_0) && istrue(var_1.ref_12c46)) {
    var_0 thread scripts\mp\rank::scoreeventpopup("br_ter_obj_destroyed");
    scripts\mp\utility\sound::playsoundonplayers("mp_bodycount_tick_positive", respawn_flare_used(self.team));
    scripts\mp\utility\sound::playsoundonplayers("mp_bodycount_tick_negative", var_1.team);
    ref_125b7(var_0, level.deletetimedrunhud.is_greater_than_equal_to);
  }

  is_relic_collat_dmg_active("destroyed");
}

function binoculars_watchraceadsoff(var_0, var_1) {
  var_2 = self.ent;
  var_3 = var_0;

  if(var_3 > 0 && istrue(var_2.ref_12c46)) {
    if(isDefined(var_1)) {
      ref_1266e(var_1, self.ref_13a82[0]);
    }

    is_relic_collat_dmg_active("damaged");
    var_4 = is_object_allowed_in_gametype();
    dmztutendgame(ref_1197f(var_4), respawn_flare_used(var_4.team));
    dmztutendgame(ref_1197c(var_4), var_4.team);
    ref_11991(var_4);
    return;
  }
}

function arenaloadouts_getoverrideweaponswithgroup(var_0, var_1) {
  var_2 = self.ent;
  var_3 = var_0;

  if(var_3 > 0 && istrue(var_2.ref_12c46)) {
    if(isDefined(var_1)) {
      ref_1266e(var_1, self.ref_13a82[0]);
    }

    is_relic_collat_dmg_active("damaged");
    var_4 = is_object_allowed_in_gametype();
    dmztutendgame(ref_1197f(var_4), respawn_flare_used(var_4.team));
    dmztutendgame(ref_1197c(var_4), var_4.team);
    ref_11991(var_4);
    return;
  }
}

function is_one_player_near_point2d() {
  if(self.is_minimap_forcedisabled == "scriptable") {
    thread is_playing_vo();
    return;
  }

  if(self.is_minimap_forcedisabled == "script_model") {
    thread is_point_in_cylinder();
    return;
  }

  if(self.is_minimap_forcedisabled == "jugg_agent") {
    thread is_operations_gametype();
    return;
  }

  if(self.is_minimap_forcedisabled == "aa_turret") {
    thread is_opened();
    return;
  }
}

function is_playing_vo() {
  self endon("monitorDamageEnd");
  self.ent setscriptablepartstate("base", "unprotected");

  while(self.ent getscriptablepartstate("base") != "destroyed") {
    waitframe();
  }

  is_relic_collat_dmg_active("destroyed");
}

function is_point_in_cylinder() {
  var_0 = level.deletetimedrunhud.is_goal_crowded[self.name];
  self.ent scripts\mp\damage::monitordamage(var_0.health, "hitequip", &is_module_active, &is_on);
}

function is_operations_gametype() {
  self endon("monitorDamageEnd");
  self.ent endon("death");

  for(;;) {
    self.ent waittill("damage", var_0, var_1);
    binoculars_watchraceadsoff(var_0, var_1);
  }
}

function is_opened() {
  self endon("monitorDamageEnd");
  self.ent endon("death");

  for(;;) {
    self.ent waittill("damage", var_0, var_1);
    arenaloadouts_getoverrideweaponswithgroup(var_0, var_1);
  }
}

function is_player_damage_disabled() {
  if(self.is_minimap_forcedisabled == "scriptable") {
    thread is_player_part_exposed_to_chopper_boss();
    return;
  }

  if(self.is_minimap_forcedisabled == "script_model") {
    thread is_player_valid_for_team_proximity();
    return;
  }

  if(self.is_minimap_forcedisabled == "jugg_agent") {
    thread is_player_in_focus_fire_attacker_list();
    return;
  }

  if(self.is_minimap_forcedisabled == "aa_turret") {
    thread is_player_in_aggro();
    return;
  }
}

function is_player_part_exposed_to_chopper_boss() {
  self.ent setscriptablepartstate("base", "protected");
  self notify("monitorDamageEnd");
}

function is_player_valid_for_team_proximity() {
  self.ent scripts\mp\damage::monitordamageend();
}

function is_player_in_focus_fire_attacker_list() {
  bot_custom_classes_allowed(self.ent);
  self notify("monitorDamageEnd");
}

function is_player_in_aggro() {
  self notify("monitorDamageEnd");
}

function is_relic_collat_dmg_active(var_0) {
  if(var_0 == self.state) {
    return;
  }

  if(self.is_minimap_forcedisabled == "script_model") {
    switch (var_0) {
      case "protected":
        is_relic_active(var_0);
        is_player_damage_disabled();
        break;
      case "undamaged":
        if(isDefined(self.ent.damagetaken)) {
          self.ent.damagetaken = 0;
        }

        is_relic_active(var_0);
        self.ent setscriptablepartstate("ter_damageable", "default");
        is_one_player_near_point2d();
        break;
      case "damaged":
        is_relic_active(var_0);
        self.ent setscriptablepartstate("ter_damageable", "damaged");
        var_1 = getdvarint("scr_br_ter_allow_enemy_repair", 0);

        foreach(var_3 in level.players) {
          if(!level.deletetimedrunhud.brjugg_watchgasdamage) {
            self.ent disablescriptableplayeruse(var_3);
            continue;
          }

          if(var_1 || var_3.team == self.team) {
            self.ent enablescriptableplayeruse(var_3);
            continue;
          }

          self.ent disablescriptableplayeruse(var_3);
        }

        break;
      case "destroyed":
        is_relic_active(var_0);
        var_5 = level.deletetimedrunhud.is_goal_crowded[self.name];
        self.ent setModel(var_5.modeldestroyed);
        self.ent setscriptablepartstate("ter_damageable", "destroyed");
        is_player_damage_disabled();
        var_6 = is_object_allowed_in_gametype();
        ref_11992(var_6);
        break;
      default:
        break;
    }
  } else if(self.is_minimap_forcedisabled == "jugg_agent" || self.is_minimap_forcedisabled == "aa_turret") {
    switch (var_0) {
      case "undamaged":
      case "active":
        is_relic_active(var_0);
        is_one_player_near_point2d();
        break;
      case "damaged":
        is_relic_active(var_0);
        break;
      case "destroyed":
        is_relic_active(var_0);
        is_player_damage_disabled();
        var_6 = is_object_allowed_in_gametype();
        ref_11992(var_6);
        break;
      case "protected":
        is_relic_active(var_0);
        break;
      default:
        break;
    }
  }

  self.state = var_0;

  foreach(var_8 in self.ref_13a82) {
    var_8 notify("damageable_state_change", self);
  }
}

function is_riding_heli(var_0, var_1, var_2, var_3, var_4) {
  ref_12678(var_3, var_0.entity.ref_13a85.ref_13a82[0]);
  var_3 thread scripts\mp\rank::scoreeventpopup("br_ter_obj_repaired");
  var_3 playlocalsound("mp_bodycount_tick_positive");
  ref_125b7(var_3, level.deletetimedrunhud.is_main_pilot);
  is_relic_collat_dmg_active(var_0.entity.ref_13a85, "undamaged");
}

function is_relic_active(var_0) {
  var_1 = self;
  var_2 = self.team;
  var_3 = respawn_flare_used(self.team);

  if(!istrue(var_1.ref_12c46)) {
    var_1.ent hudoutlinedisable();
    return;
  }

  var_4 = getdvarint("scr_br_ter_outline_destroyed_destructables", 0);

  switch (var_0) {
    case "undamaged":
    case "active":
      spawnc130pathstructnewinternal(var_1.ent, var_2, "outline_depth_friendly");
      spawnc130pathstructnewinternal(var_1.ent, var_3, "outline_depth_enemy");
      break;
    case "damaged":
      spawnc130pathstructnewinternal(var_1.ent, var_2, "outline_depth_friendly_damaged");
      spawnc130pathstructnewinternal(var_1.ent, var_3, "outline_depth_enemy_damaged");
      break;
    case "destroyed":
      if(var_4) {
        spawnc130pathstructnewinternal(var_1.ent, var_2, "outline_depth_friendly_destroyed");
        spawnc130pathstructnewinternal(var_1.ent, var_3, "outline_depth_enemy_destroyed");
      } else {
        var_1.ent hudoutlinedisable();
      }

      break;
    case "protected":
      var_1.ent hudoutlinedisable();
      break;
    default:
      break;
  }
}

function is_object_allowed_in_gametype() {
  return self.ref_13a82[0];
}

function wait_for_garage_open() {
  ref_1435d();
  self.ent = easepower("br_plunder_box", self.origin, self.angles);
  self.ent.ref_13a85 = self;
  level.br_armory_kiosk.scriptables[level.br_armory_kiosk.scriptables.size] = self.ent;
  self.ent setscriptablepartstate("br_plunder_box", "visible");
  self.ent.visible = 1;
}

function watchdangerresetaction() {
  level.deletetimedrunhud.spawnaccesscards = spawnStruct();
  level.deletetimedrunhud.spawnaccesscards.ref_13bde = getdvarint("scr_br_hud_top_offset", 40);
  level.deletetimedrunhud.spawnaccesscards.ref_14291 = getdvarint("scr_br_ter_hud_version", 0);
  level.deletetimedrunhud.spawnaccesscards.watchcratetimeout = getdvarint("scr_br_ter_hud_layout", 1);
  level.deletetimedrunhud.spawnaccesscards.ref_13347 = getdvarint("scr_br_ter_hud_show_counts", 1);
  level.deletetimedrunhud.spawnaccesscards.enabled = getdvarint("scr_br_ter_hud_enabled", 1);

  if(!level.deletetimedrunhud.spawnaccesscards.enabled) {
    return;
  }

  level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand = 45;

  if(level.deletetimedrunhud.spawnaccesscards.watchcratetimeout == 1) {
    level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand *= 2;
  }

  level.deletetimedrunhud.spawnaccesscards.temp = spawnStruct();
  level.deletetimedrunhud.spawnaccesscards.temp.ref_11b59 = [];
  level.deletetimedrunhud.spawnaccesscards.temp.ref_11b55 = [];
  level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto = [];

  foreach(var_1 in level.deletetimedrunhud.teams) {
    level.deletetimedrunhud.spawnaccesscards.temp.ref_11b59[var_1] = 0;
    level.deletetimedrunhud.spawnaccesscards.temp.ref_11b55[var_1] = 0;
    level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[var_1] = [];
  }

  foreach(var_4 in self.targets["base"]) {
    ref_11986(var_4, 0);
  }

  foreach(var_4 in self.targets["base"]) {
    ref_11977(var_4);
  }

  level.deletetimedrunhud.spawnaccesscards.temp = undefined;
}

function ref_11986(var_0) {
  if(isDefined(self.spawnanglemax)) {
    return;
  }

  self.spawnanglemax = spawnStruct();
  self.spawnanglemax.temp = spawnStruct();

  if(isDefined(level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0])) {
    level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0]++;
  } else {
    level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0] = 0;
  }

  var_1 = level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0];
  level.deletetimedrunhud.spawnaccesscards.temp.ref_11b55[self.team] = max(level.deletetimedrunhud.spawnaccesscards.temp.ref_11b55[self.team], var_1);
  level.deletetimedrunhud.spawnaccesscards.temp.ref_11b59[self.team] = max(level.deletetimedrunhud.spawnaccesscards.temp.ref_11b59[self.team], var_0);
  self.spawnanglemax.temp.lasttimespawngroupcalled = var_0;
  self.spawnanglemax.temp.disable_ignore_if_near_player = level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var_0];

  foreach(var_3 in self.targets["outpost"]) {
    ref_11986(var_3, var_0 + 1);
  }
}

function ref_11977() {
  if(isDefined(self.spawnanglemax.monitor_hack_prox)) {
    return;
  }

  var_0 = ref_1197a();
  self.spawnanglemax.monitor_hack_prox = [];

  foreach(var_2 in level.deletetimedrunhud.teams) {
    if(!isDefined(self.spawnanglemax.monitor_hack_prox[var_2])) {
      self.spawnanglemax.monitor_hack_prox[var_2] = [];
    }

    var_3 = level.deletetimedrunhud.spawnaccesscards.temp.ref_11b59[self.team];
    var_4 = 5;
    var_5 = level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand + var_4;
    var_5 += (15 + level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand) * (var_3 - self.spawnanglemax.temp.lasttimespawngroupcalled);

    if(level.deletetimedrunhud.spawnaccesscards.watchcratetimeout == 1) {
      var_5 -= int((var_3 + 1) * (15 + level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand) * 0.5);
      var_6 = 2;
    } else {
      var_6 = 4;
    }

    var_7 = 7.5;
    var_7 += level.deletetimedrunhud.spawnaccesscards.ref_13bde;
    var_7 += (15 + var_6) * self.spawnanglemax.temp.disable_ignore_if_near_player;
    var_8 = level.deletetimedrunhud.spawnaccesscards.temp.ref_11b55[self.team];
    var_9 = level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][self.spawnanglemax.temp.lasttimespawngroupcalled];

    if(var_8 > 0 && var_9 < var_8) {
      var_10 = var_6 + 15;
      var_10 *= (var_8 - var_9) / var_8;
      var_7 += var_10;
    }

    var_11 = var_5;

    if(level.deletetimedrunhud.spawnaccesscards.ref_14291 != 1) {
      var_11 += 15;
    }

    var_12 = var_7;

    if(self.team == var_2) {
      var_5 *= -1;
      var_11 *= -1;
      var_13 = "LEFT";
    } else if(level.deletetimedrunhud.spawnaccesscards.watchcratetimeout == 1) {
      var_7 += (15 + var_6) * (var_8 + 1);
      var_12 += (15 + var_6) * (var_8 + 1);
      var_5 *= -1;
      var_11 *= -1;
      var_13 = "LEFT";
    } else {
      var_13 = "RIGHT";
    }

    var_14 = var_2;
    var_15 = scripts\engine\utility::ter_op(self.team == var_2, (0.337255, 0.690196, 0.929412), (1, 0.341176, 0.341176));
    var_16 = scripts\engine\utility::ter_op(level.deletetimedrunhud.spawnaccesscards.ref_14291 == 1, var_15, (1, 1, 1));
    var_17 = hudicon(var_14, var_0.hudicon, var_16);
    var_17 scripts\mp\hud_util::setpoint(var_13, "CENTERTOP", var_11, var_12);
    self.spawnanglemax.monitor_hack_prox[var_2]["icon"] = var_17;

    if(level.deletetimedrunhud.spawnaccesscards.ref_14291 != 1) {
      var_18 = spawnboardroom_gasmask(var_14, var_15);
      var_18 scripts\mp\hud_util::setpoint(var_13, "CENTERTOP", var_11, var_12);
      self.spawnanglemax.monitor_hack_prox[var_2]["label_bg"] = var_18;
    }

    var_19 = spawn_transition_camera(var_14);
    var_19 scripts\mp\hud_util::setpoint(var_13, "CENTERTOP", var_5, var_7);
    self.spawnanglemax.monitor_hack_prox[var_2]["bar"] = var_19;
    thread ref_11976(var_2, var_14, var_13, var_11 + 15, var_12);
  }

  foreach(var_22 in self.targets["outpost"]) {
    ref_11977(var_22);
  }

  self.spawnanglemax.temp = undefined;
}

function ref_11976(var_0, var_1, var_2, var_3, var_4) {
  if(level.deletetimedrunhud.spawnaccesscards.ref_13347 == 0) {
    return;
  }

  if(level.deletetimedrunhud.spawnaccesscards.ref_13347 == 1) {
    self waittill("current");
  }

  var_5 = spawn_tut_loot(var_1);
  var_5 scripts\mp\hud_util::setpoint(var_2, "CENTERTOP", var_3, var_4);
  self.spawnanglemax.monitor_hack_prox[var_0]["count"] = var_5;
}

function hudicon(var_0, var_1, var_2) {
  var_3 = newteamhudelem(var_0);
  var_3.archived = 0;
  var_3.elemtype = "";
  var_3.width = 15;
  var_3.height = 15;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3.sort = 0;
  spawndistancemin(var_3, var_2);
  var_3.alpha = 1;
  var_3 scripts\mp\hud_util::setparent(level.uiparent);
  var_3 setshader(var_1, 15, 15);
  var_3.hidden = 0;
  return var_3;
}

function spawnboardroom_auav(var_0, var_1) {
  var_2 = 15 / level.fontheight;
  var_3 = newteamhudelem(var_0);
  var_3.archived = 0;
  var_3.elemtype = "font";
  var_3.font = "default";
  var_3.fontscale = var_2;
  var_3.basefontscale = var_2;
  var_3.sort = 0;
  var_3.width = 11;
  var_3.height = 15;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 scripts\mp\hud_util::setparent(level.uiparent);
  var_3.hidden = 0;
  var_3.label = var_1;
  spawndistancemin(var_3, (1, 1, 1));
  return var_3;
}

function spawnboardroom_gasmask(var_0, var_1) {
  var_2 = newteamhudelem(var_0);
  var_2.archived = 0;
  var_2.elemtype = "";
  var_2.width = 15;
  var_2.height = 15;
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2.sort = -1;
  spawndistancemin(var_2, var_1);
  var_2.alpha = 1;
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2 setshader("progress_bar_fill", 15, 15);
  var_2.hidden = 0;
  return var_2;
}

function spawn_transition_camera(var_0) {
  var_1 = newteamhudelem(var_0);
  var_1.archived = 0;
  var_1.elemtype = "";
  var_1.width = level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand;
  var_1.height = 15;
  var_1.xoffset = 0;
  var_1.yoffset = 0;
  var_1.children = [];
  var_1.sort = -3;
  spawndistancemin(var_1, (1, 1, 1));
  var_1.alpha = 1;
  var_1 scripts\mp\hud_util::setparent(level.uiparent);
  var_1 setshader("progress_bar_fill", level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand, 15);
  var_1.hidden = 0;
  return var_1;
}

function spawn_tut_loot(var_0) {
  var_1 = 15 / level.fontheight;
  var_2 = newteamhudelem(var_0);
  var_2.archived = 0;
  var_2.elemtype = "font";
  var_2.font = "default";
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.sort = 0;
  var_2.width = 15;
  var_2.height = 15;
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  spawndistancemin(var_2, (1, 1, 0));
  return var_2;
}

function spawndistancemin(var_0) {
  self.color = var_0;
  self.juggernauts_spawned = var_0;
}

function spawn_wheelson_blinking_lights(var_0) {
  self endon("death");
  self notify("end_flash");
  self endon("end_flash");
  self.color = var_0;
  wait 0.2;
  self.color = self.juggernauts_spawned;
}

function spawn_weapon_box_cache(var_0, var_1) {
  self endon("death");
  self endon("end_flashing");
  self.player_onspawn = var_0;

  if(isDefined(self.player_origin_inside_front_zone)) {
    var_2 = gettime() + var_1 * 1000;

    if(var_2 > self.player_origin_inside_front_zone) {
      self.player_origin_inside_front_zone = var_2;
    }

    return;
  } else {
    self.player_origin_inside_front_zone = gettime() + var_2 * 1000;
  }

  while(gettime() < self.player_origin_inside_front_zone) {
    self.color = self.player_onspawn;
    wait 0.1;
    self.color = self.juggernauts_spawned;
    wait 0.1;
  }

  spawn_weapons_by_player_count();
}

function spawn_weapons_by_player_count() {
  self.color = self.juggernauts_spawned;
  self.player_onspawn = undefined;
  self.player_origin_inside_front_zone = undefined;
  self notify("end_flashing");
}

function target_in_range_and_fov(var_0) {
  if(!isDefined(self.targets)) {
    self.targets = [];
  }

  if(!isDefined(self.targets[var_0])) {
    self.targets[var_0] = [];
    return;
  }
}

function hide_bomb_case_timer(var_0, var_1) {
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = var_0[2];
  return ((1 - var_2) * var_1 + var_2, (1 - var_3) * var_1 + var_3, (1 - var_4) * var_1 + var_4);
}

function spawnc130pathstructnewinternal(var_0, var_1) {
  if(level.teamdata[var_0]["players"].size) {
    self hudoutlineenableforclients(level.teamdata[var_0]["players"], var_1);
    return;
  }
}

function canspawnVehicle() {
  return level.vehiclecount < getdvarint("scr_br_ter_max_vehicle_count", 120);
}

function ref_13875() {
  return canspawnVehicle() && getdvarint("scr_br_ter_start_in_planes", 0);
}