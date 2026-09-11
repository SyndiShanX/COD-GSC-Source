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
  var0 = getDvar("scr_br_ter_layout_name", "default");
  var1 = level.deletetimedrunhud.watchflashgrenadeexplode[var0];
  watchfor_pain_or_nearby(var1);
  scripts\mp\flags::gameflagset("ter_layout_spawned");
  scripts\mp\flags::gameflagset("ter_agent_spawn");
  watchdumpsterplayerexit(var1);
}

function tracegroundheightexfil() {
  level.deletetimedrunhud.vo = spawnStruct();
  level.deletetimedrunhud.vo.ref_13b72 = [];

  foreach(var1 in level.deletetimedrunhud.teams) {
    level.deletetimedrunhud.vo.ref_13b7d[var1] = [];
  }

  var3 = getdvarint("scr_br_ter_dialog_all_debounce_losing", 5000);
  var4 = getdvarint("scr_br_ter_dialog_all_debounce_securing", 5000);
  traceresultisValid("objective", "boost_groundwar");
  traceresultisValid("securing_default", "flag_securing", var4);
  traceresultisValid("securing_base", "hq_securing", var4);
  traceresultisValid("securing_a", "securing_a", var4);
  traceresultisValid("securing_b", "securing_b", var4);
  traceresultisValid("securing_c", "securing_c", var4);
  traceresultisValid("securing_d", "securing_d", var4);
  traceresultisValid("securing_e", "securing_e", var4);
  traceresultisValid("secured_default", "flag_secured");
  traceresultisValid("secured_base", "hq_secured");
  traceresultisValid("secured_a", "secured_a");
  traceresultisValid("secured_b", "secured_b");
  traceresultisValid("secured_c", "secured_c");
  traceresultisValid("secured_d", "secured_d");
  traceresultisValid("secured_e", "secured_e");
  traceresultisValid("losing_default", "flag_losing", var3);
  traceresultisValid("losing_base", "hq_capturing_enemy", var3);
  traceresultisValid("losing_a", "losing_a", var3);
  traceresultisValid("losing_b", "losing_b", var3);
  traceresultisValid("losing_c", "losing_c", var3);
  traceresultisValid("losing_d", "losing_d", var3);
  traceresultisValid("losing_e", "losing_e", var3);
  traceresultisValid("lost_default", "flag_lost");
  traceresultisValid("lost_base", "hq_disabled");
  traceresultisValid("lost_a", "lost_a");
  traceresultisValid("lost_b", "lost_b");
  traceresultisValid("lost_c", "lost_c");
  traceresultisValid("lost_d", "lost_d");
  traceresultisValid("lost_e", "lost_e");
}

function traceresultisValid(var0, var1, var2) {
  game["dialog"][var0] = var1;

  if(isDefined(var2)) {
    ref_13286(var0, var2);
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

function init_relic_focus_fire(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();
  var6.is_minimap_forcedisabled = var0;

  if(var0 == "script_model") {
    if(!isDefined(var4)) {
      var4 = 0;
    }

    if(!isDefined(var5)) {
      var5 = (0, 0, 0);
    }

    var6.model = var1;
    var6.health = var2;
    var6.modeldestroyed = var3;
    var6.ref_11a49 = var4;
    var6.ref_11a3f = var5;
  } else if(var0 == "jugg_agent" || var0 == "aa_turret") {
    if(!isDefined(var4)) {
      var4 = 0;
    }

    if(!isDefined(var5)) {
      var5 = (0, 0, 0);
    }

    var6.ref_11a49 = var4;
    var6.ref_11a3f = var5;
  }

  var6.ref_12c46 = !(var0 == "aa_turret" && !getdvarint("scr_br_ter_aa_guns_required", 1));
  return var6;
}

function teleport_to_silo_airlock() {
  var0 = ["means_of_death", "weapon_type", "weapon_class_name", "weapon_base_name"];

  foreach(var2 in var0) {
    level.deletetimedrunhud.is_position_open[var2] = [];
    level.deletetimedrunhud.is_raid_gamemode[var2] = [];
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

  foreach(var1 in level.deletetimedrunhud.teams) {
    level.deletetimedrunhud.ref_1196c[var1] = init_server("ui_mp_br_mapmenu_icon_obstacle", "ui_icon_br_ter_base", &"BR_TER/LOC_NAME_BASE", "base");
  }
}

function init_server(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.ref_11f89 = var0;
  var4.hudicon = var1;
  var4.locname = var2;
  var4.ref_14308 = "_" + var3;
  return var4;
}

function initstructs() {
  if(isDefined(level.tower_ground_mortar)) {
    [[level.tower_ground_mortar]]();
    return;
  }
}

function timed_laser_trap_trigger_array() {
  var0 = scripts\engine\utility::getStructArray("ter_layout", "targetname");

  foreach(var2 in var0) {
    var2.ref_13a8f = "layout";
    var2.name = var2.script_noteworthy;
    var2.script_noteworthy = undefined;
    level.deletetimedrunhud.watchflashgrenadeexplode[var2.name] = var2;
  }

  foreach(var2 in level.deletetimedrunhud.watchflashgrenadeexplode) {
    ref_13a83(var2);
  }
}

function ref_13a83() {
  self.targets = [];

  if(!isDefined(self.target)) {
    return;
  }

  var0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  self.target = undefined;

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "pass" && isDefined(var2.target)) {
      var3 = scripts\engine\utility::getStructArray(var2.target, "targetname");

      foreach(var5 in var3) {
        var0 = var5;
      }
    }
  }

  foreach(var2 in var0) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "pass") {
      continue;
    }

    if(!ref_13a90(var2.script_noteworthy) || !is_riding_hel(var2.script_parameters) || !ref_14270(var2.script_parameters)) {
      continue;
    }

    if(!istrue(var2.ref_128a9)) {
      var2.ref_13a8f = var2.script_noteworthy;
      var2.script_noteworthy = undefined;
      var2.name = var2.script_parameters;
      var2.script_parameters = undefined;

      if(!isDefined(var2.angles)) {
        var2.angles = (0, 0, 0);
      }

      var2.ref_128a9 = 1;
      ref_13a83(var2);
    }

    if(!isDefined(self.targets[var2.ref_13a8f])) {
      self.targets[var2.ref_13a8f] = [];
    }

    var8 = self.targets[var2.ref_13a8f].size;
    self.targets[var2.ref_13a8f][var8] = var2;

    if(!isDefined(var2.ref_13a82)) {
      var2.ref_13a82 = [];
    }

    var2.ref_13a82[var2.ref_13a82.size] = self;
  }
}

function watchfor_pain_or_nearby() {
  allow_br_loot_to_br_marked();

  if(getdvarint("scr_br_auto_gen_plane_start_spawns", 0)) {
    foreach(var1 in level.deletetimedrunhud.types["base"]) {
      chuckerlogic(var1);
    }
  }

  level.deletetimedrunhud.types["location"] = scripts\engine\utility::array_combine(level.deletetimedrunhud.types["base"], level.deletetimedrunhud.types["outpost"]);
}

function chuckerlogic() {
  var0 = undefined;

  foreach(var2 in self.targets["outpost"]) {
    var0 = var2;
    break;
  }

  if(!isDefined(var0)) {
    return;
  }

  self.targets["spawn_start_plane"] = [];

  if(!isDefined(level.deletetimedrunhud.types["spawn_start_plane"])) {
    level.deletetimedrunhud.types["spawn_start_plane"] = [];
  }

  var4 = var0.origin - self.origin;
  var4 = (var4[0], var4[1], 0);
  var4 = vectorNormalize(var4);
  var5 = vectortoangles(var4);
  var6 = getdvarfloat("scr_br_auto_gen_plane_start_spawns_height", 6000);
  var7 = getdvarfloat("scr_br_auto_gen_plane_start_spawns_forward", -2000);
  var8 = getdvarfloat("scr_br_auto_gen_plane_start_spawns_spacing", 800);
  var9 = getdvarint("scr_br_auto_gen_plane_start_spawns_count", 20);
  var10 = vectorcross(var4, (0, 0, 1));
  var11 = var10 * var9 / 2 * var8 + self.origin + (0, 0, var6) + var4 * var7;

  for(var12 = 0; var12 < var9; var12++) {
    var13 = spawnStruct();
    var13.origin = var11 - var10 * var12 * var8;
    var13.angles = var5;
    var13.ref_13a8f = "spawn_start_plane";
    var13.targets = [];
    var14 = self.targets["spawn_start_plane"].size;
    self.targets["spawn_start_plane"][var14] = var13;
    var14 = level.deletetimedrunhud.types["spawn_start_plane"].size;
    level.deletetimedrunhud.types["spawn_start_plane"][var14] = var13;
  }
}

function allow_br_loot_to_br_marked() {
  if(istrue(self.spawned)) {
    return;
  }

  self.spawned = 1;
  var0 = self.ref_13a8f;

  if(!isDefined(level.deletetimedrunhud.types[var0])) {
    level.deletetimedrunhud.types[var0] = [];
  }

  var1 = level.deletetimedrunhud.types[var0].size;
  level.deletetimedrunhud.types[var0][var1] = self;

  foreach(var0, var3 in self.targets) {
    foreach(var5 in var3) {
      ref_13a8b(var5);
      allow_br_loot_to_br_marked(var5);
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

function ref_13a90(var0) {
  var1 = "scr_br_ter_disable_";

  if(!isDefined(var0)) {
    return true;
  }

  switch (var0) {
    case "agent":
      var1 += "agent";
      break;
    case "vehicle_current":
    case "vehicle_not_destroyed":
    case "vehicle_destroyed":
    case "vehicle":
      var1 += "vehicle";
      break;
    case "kiosk":
      var1 += "kiosk";
      break;
    default:
      return true;
  }

  if(var1 == "scr_br_ter_disable_") {
    return true;
  }

  if(getdvarint(var1, 0) != 0) {
    return false;
  }

  return true;
}

function is_relic_swat_active() {
  var0 = undefined;
  var1 = level.deletetimedrunhud.is_goal_crowded[self.name];

  switch (var1.is_minimap_forcedisabled) {
    case "scriptable":
      var0 = easepower(self.name, self.origin, self.angles);
      break;
    case "script_model":
      var0 = spawn("script_model", self.origin);
      var0.angles = self.angles;
      var0 setModel(var1.model);
      var0 solid();
      break;
    case "aa_turret":
      if(isDefined(level.arenaflag_setenabled)) {
        var0 = self[[level.arenaflag_setenabled]]();
      }

      break;
    default:
      break;
  }

  self.is_minimap_forcedisabled = var1.is_minimap_forcedisabled;
  self.ref_12c46 = var1.ref_12c46;
  self.ent = var0;
  self.ent.ref_13a85 = self;
}

function is_riding_hel(var0) {
  var1 = "scr_br_ter_disable_";

  if(!isDefined(var0)) {
    return true;
  }

  if(var0 == "aa_turret" && !getdvarint("aa_turrets_enabled", 0)) {
    return false;
  }

  foreach(var3 in level.deletetimedrunhud.is_lower) {
    if(var0 == var3) {
      var1 += var3;
      break;
    }
  }

  if(var1 == "scr_br_ter_disable_") {
    return true;
  }

  if(getdvarint(var1, 0) != 0) {
    return false;
  }

  return true;
}

function bintheplane() {
  self.state = "init";
  var0 = level.deletetimedrunhud.is_goal_crowded[self.name];
  self.is_minimap_forcedisabled = var0.is_minimap_forcedisabled;
}

function ref_14262() {
  self.state = "init";
}

function ref_14270(var0) {
  var1 = "scr_br_ter_disable_";

  if(!isDefined(var0)) {
    return true;
  }

  foreach(var3 in level.deletetimedrunhud.ref_141c4) {
    if(var0 == var3) {
      var1 += var3;
      break;
    }
  }

  if(var1 == "scr_br_ter_disable_") {
    return true;
  }

  if(getdvarint(var1, 0) != 0) {
    return false;
  }

  return true;
}

function watchdumpsterplayerexit() {
  watchdangerresetaction();

  foreach(var1 in self.targets["base"]) {
    circle(var1);
    thread ref_11987(var1);
  }

  self waittillmatch("child_changed_state", "destroyed");
  var3 = [];

  foreach(var1 in self.targets["base"]) {
    if(var1.state == "destroyed") {
      var3 = var1.team;
    }
  }

  if(var3.size == 1) {
    var6 = var3[0];
  } else {
    var6 = scripts\engine\utility::random(level.deletetimedrunhud.teams);
  }

  var7 = respawn_flare_used(var6);
  var8 = "objective_completed";
  thread scripts\mp\gametypes\br::ref_1209b(var6, 2, undefined, 1, 1, 1);
  thread scripts\mp\gametypes\br::brendgame(var7, game["end_reason"][var8], 0);
}

function ref_11987(var0) {
  if(isDefined(self.state)) {
    return;
  }

  self endon("destroyed");
  ref_11981(var0);

  foreach(var2 in self.targets["outpost"]) {
    thread ref_11987(var2);
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

function ref_11981(var0) {
  foreach(var2 in self.targets["damageable"]) {
    sub_civtarget(var2);
  }

  self.state = "";
  ref_11982(var0);
  ref_1198b("hidden");
  var4 = ["spawn_def", "spawn_att", "spawn_start", "spawn_plane", "spawn_start_plane"];

  foreach(var6 in var4) {
    if(!isDefined(self.targets[var6])) {
      continue;
    }

    self.ref_11e85[var6] = 0;
    self.targets[var6] = scripts\engine\utility::array_randomize(self.targets[var6]);
  }
}

function sub_civtarget() {
  self.state = "";
  is_relic_collat_dmg_active("protected");
}

function ref_1198b(var0, var1) {
  if(self.state == var0) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  self.state = var0;

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
      foreach(var3 in self.targets["outpost"]) {
        ref_1198b(var3, "destroyed", 1);
      }

      ref_11989(0);
      ref_1198a("done", 1, 0, 0);
      ref_11993();
      ref_11971("vehicle_destroyed");
      ref_11979("vehicle_not_destroyed");
      ref_11979("vehicle_current");
      ref_11978("agent");

      if(!var1) {
        level thread scripts\mp\hud_message::notifyteam("br_ter_outpost_lost", "br_ter_outpost_captured", self.team);
        dmztutendgame(ref_1197e(), respawn_flare_used(self.team));
        dmztutendgame(ref_1197d(), self.team);
      }

      break;
    default:
      break;
  }

  self notify(self.state);

  foreach(var6 in self.ref_13a82) {
    var6 notify("child_changed_state", self.state);
  }
}

function ref_11982(var0) {
  self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid();

  if(self.objidnum != -1) {
    var1 = ref_1197a();
    scripts\mp\objidpoolmanager::objective_add_objective(self.objidnum, "invisible", self.origin);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, 0);
    scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, var1.ref_11f89);
    scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, var0.team);
    objective_setfriendlylabel(self.objidnum, "BR_TER/OBJ_DEFEND");
    objective_setenemylabel(self.objidnum, "BR_TER/OBJ_DESTROY");
    function_0421(self.objidnum, 1);
    return;
  }
}

function brc130airdropcratecapturecallback(var0, var1, var2) {
  var0 = scripts\engine\utility::drop_to_ground(var0, 128);
  var3 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_lw_br_juggernaut_ter", var0, var1);

  if(!isDefined(var3)) {
    return undefined;
  }

  var3.team = var2;

  if(isDefined(level.teamnamelist) && !scripts\engine\utility::array_contains(level.teamnamelist, var3.team)) {
    level.teamnamelist = scripts\engine\utility::array_add(level.teamnamelist, var3.team);
  }

  var4 = getdvarint("scr_br_ter_jugg_health", 3500);
  var3.loadout_giveweaponobj = 1;
  var3.maxhealth = var4;
  var3.health = var4;
  var3.agentdamagefeedback = 0;
  var3.eliminate_drone_minigun_speed = 10000;
  var3.eliminate_drone_internal = 2;
  return var3;
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

function frontend5lobby(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  if(getdvarint("scr_br_ter_one_shot_kill", 0)) {
    var2 = 99999;
  }

  scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentdamaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
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

function onplayerkilled(var0) {
  var1 = var0.victim;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(isDefined(var1)) {
    if(!istrue(var1.br_infilstarted)) {
      return;
    }

    ref_126d9(var1);
    return;
  }
}

function ref_126d9(var0) {
  if(!istrue(var0)) {
    if(isDefined(self.ref_136a6)) {
      var1 = getdvarfloat("scr_br_ter_player_spawn_type_min_sec", 8);
      var2 = var1 * 1000;
      var3 = gettime() - self.ref_136a6;

      if(var3 < var2) {
        return;
      }
    }
  }

  var4 = undefined;
  var5 = undefined;

  foreach(var7 in level.deletetimedrunhud.types["location"]) {
    if(var7.state == "current") {
      var8 = distance(var7.origin, self.origin);

      if(!isDefined(var5) || var8 < var5) {
        var5 = var8;
        var4 = var7;
      }
    }
  }

  if(isDefined(var4)) {
    var10 = 1;
    var11 = ref_1257d();

    if(var11 == "base") {
      var12 = ref_12565();
      var13 = distance(var12.origin, self.origin);

      if(var13 < var5) {
        var10 = 0;
      }
    }

    if(var10) {
      if(var4.team == self.team) {
        ref_12678(var4);
        return;
      }

      ref_1266e(var4);
      return;
    }

    return;
  }
}

function manage_fakebody_hides(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1);
  }

  ref_143f7();

  for(var1 = 0; var1 < level.players.size; var1++) {
    var2 = level.players[var1];

    if(!isDefined(var2)) {
      continue;
    }

    if(!isalive(var2)) {
      var2 scripts\mp\playerlogic::spawnplayer(0);
    }

    if(istrue(var2.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br::ref_13f21(var2);
    }

    var2 setclientomnvar("ui_br_infil_started", 1);
    var2 setclientomnvar("ui_br_infiled", 1);
    var2.br_infilstarted = 1;

    if(!var0) {
      var2 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    }

    thread ref_1255f();
  }

  if(!var0) {
    wait 2;
  }

  level.disable_super_in_turret.ref_13916 = 0;

  foreach(var2 in level.players) {
    thread ref_1255c();
    LOC_000000f6:
  }

  scripts\mp\flags::gameflagset("prematch_fade_done");
  ref_143f8(10);

  if(!var0) {
    foreach(var2 in level.players) {
      if(isDefined(var2)) {
        var2 scripts\mp\gametypes\br_gulag::gulagfadefromblack();
      }
    }
  }

  waitframe();

  foreach(var2 in level.players) {
    ref_1255e(var2);
  }

  scripts\mp\flags::gameflagset("infil_complete");
  dmzwincost("objective");
}

function ref_143f7() {
  var0 = gettime() + 10000;

  while(gettime() < var0 && getactiveclientcount() != level.players.size) {
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

function ref_143f8(var0) {
  var1 = gettime() + var0 * 1000;

  while(gettime() < var1 && level.disable_super_in_turret.ref_13916 < level.players.size) {
    waitframe();
  }
}

function dyn_door(var0) {
  return true;
}

function playerrespawn(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");

  if(!scripts\mp\flags::gameflag("prematch_done") || !istrue(self.br_infilstarted)) {
    return false;
  }

  thread ref_126a4(var0);
  return true;
}

function ref_126a4(var0) {
  level endon("game_ended");
  self endon("disconnect");
  level endon("sudden_death_started");

  if(!istrue(level.debug_safehouse_regroup_start)) {
    self.class = scripts\mp\gametypes\br::ref_1234a();
  }

  var1 = level.teamdata[self.team]["nextRespawn"];
  var2 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(var2 > 1) {
    thread scripts\mp\gametypes\br_spectate::spawnspectator(var0, undefined, 1);
  }

  self.waitingtospawn = 1;
  emp_drone_proximity_explode(0, var1);
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
  var3 = !self calloutmarkerping_getEnt();
  var4 = gettime();

  if(var3) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(var4 + 3000 < gettime()) {
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
  var0 = getdvarint("scr_br_ter_start_ammo", 1);

  if(var0 == -2) {
    foreach(var2 in [self.primaryweapon, self.secondaryweapon]) {
      if(isDefined(var2)) {
        var3 = weaponclipsize(var2);
        self setweaponammoclip(var2, var3);
        self givemaxammo(var2);
      }
    }

    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  } else if(var0 == -1) {
    scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  } else if(var0 > 0) {
    foreach(var6 in [self.primaryweapon, self.secondaryweapon]) {
      if(isDefined(var6)) {
        var3 = weaponclipsize(var6);
        self setweaponammoclip(var6, var3);
        var2 = asmdevgetallstates(var6);
        var7 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var2);

        if(isDefined(var7)) {
          scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, var7, var3 * var0);
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
  var0 = self.origin;
  var1 = spawnStruct();
  var1.origin = self.origin;
  var1.angles = self.angles;
  var1.owner = self;
  var1.spawntype = "GAME_MODE";
  var1.cannotbesuspended = 1;
  var1.modelname = "veh_s4_mil_air_dalpha_wz";
  var1.vehicletype = "a10_warthog_fd";
  var2 = spawnStruct();
  var3 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var1, var2);

  if(isDefined(var3)) {
    wait 2;

    while(!isDefined(var3.vehiclename)) {
      var3 endon("death");
      waitframe();
    }

    self unlink();
    var4 = "pilot";
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var3, var4, self);
    return;
  }
}

function emp_drone_proximity_explode(var0, var1) {
  var2 = 4;
  var3 = 3;
  var4 = var2 + var3;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\gametypes\br::emp_drone_proximity_explode(var0);
    return;
  }

  if(self calloutmarkerping_getEnt()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  foreach(var6 in level.players) {
    var6 clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 1);
  }

  thread scripts\mp\gametypes\br::emp_drone_should_take_damage();

  if(!isDefined(self.thrust_fx_model)) {
    var8 = runkilltriger(self.team, var1);
    var9 = var8 > 0;
    var10 = undefined;
    var11 = max(var8 - var4, 0);

    if(var9) {
      var10 = ai_spawn_intel_extras(var8);
      var12 = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

      if(var12 == 1) {
        self setclientomnvar("ui_show_spectateHud", self getentitynumber());
        scripts\mp\gametypes\br_spectate::ref_1252a();
        scripts\mp\gametypes\br::spawnintermission(self.origin + (0, 0, 100), self.angles);
        scripts\mp\spectating::setdisabled();
        scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var10));
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var10));
      var13 = ref_12669(var10);

      if(isDefined(var13) && var13 == "select_defender") {
        ref_12561("defender");
      } else if(isDefined(var13) && var13 == "select_attacker") {
        ref_12561("attacker");
      }
    }

    self.ref_1286f = ref_1257c();

    if(isDefined(self.ref_1286f)) {
      self.ref_1286f.index = -1;
    }

    var14 = scripts\mp\gametypes\br_public::ref_126b8(self.ref_1286f.origin, self.ref_1286f.height);
    var15 = getdvarint("scr_br_drop_prespawn_timeout_ms", 9000);
    scripts\mp\gametypes\br_public::ref_126b9(var14, var15, 1, 0, var10);

    if(var9) {
      var16 = 1;
      var17 = 0.25;
      var18 = var16 - var17;
      thread scripts\mp\gametypes\br_gulag::fadeoutin(var16);
      wait var18;
      scripts\mp\gametypes\br_spectate::ref_1252a();
      scripts\mp\gametypes\br::spawnintermission(var14, self.ref_1286f.angles);
      scripts\mp\spectating::setdisabled();
      scripts\mp\gametypes\br::ending_fade_in(var14[0], var14[1], level.juggheli_spawner_jammer5_3);
      self setclientomnvar("ui_br_transition_type", 2);
      wait var17;
      var19 = max(var8 - var11 - var16, 0);
      wait var19;
      scripts\mp\gametypes\br_public::ref_1252b();
      self setclientomnvar("ui_show_spectateHud", -1);
    } else {
      var20 = 0.5;
      scripts\mp\gametypes\br::ending_fade_in(var14[0], var14[1], level.juggheli_spawner_jammer5_3);
      self setclientomnvar("ui_br_transition_type", 4);
      wait var20;
      scripts\mp\gametypes\br::spawnintermission(var14, self.ref_1286f.angles);
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

function ai_spawn_intel_extras(var0) {
  if(getdvarint("scr_br_ter_enable_wave_respawn", 1) != 0) {
    return (var0 * 1000);
  }

  return level.deletetimedrunhud.ref_12ca1 * 1000;
}

function ref_12669(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("scr_br_ter_enable_respawn_skip", 0) == 1) {
    self.ref_14391 = scripts\mp\hud_util::createfontstring("default", 1.5);
    self.ref_14391 scripts\mp\hud_util::setpoint("center", "middle", 0, 50);
    self.ref_14391.label = &"BR_TER/RESPAWN";
    var1 = gettime() + var0;
    var2 = gettime();

    while(gettime() < var1) {
      var3 = 1000;
      var4 = gettime() - var2;

      if(self useButtonPressed() && var4 > var3) {
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
    wait var0 / 1000;
  }

  return "timeout";
}

function ref_1257c(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = self.team;
  var2 = ref_1257d();
  var3 = [];

  if(var2 != "base") {
    foreach(var5 in level.deletetimedrunhud.types["location"]) {
      var6 = var2 == "defender" && var5.team == self.team || var2 == "attacker" && var5.team != self.team;

      if(var6 && var5.state == "current") {
        var3 = var5;
      }
    }
  }

  if(!var3.size) {
    foreach(var9 in level.deletetimedrunhud.types["base"]) {
      if(var9.team == self.team) {
        var3 = var9;
      }
    }
  }

  var5 = undefined;
  var11 = undefined;

  if(usestartspawns()) {
    var9 = ref_12565();

    if(isDefined(var9.targets["spawn_start"])) {
      var11 = "spawn_start";
      var5 = var9;
    }

    if(ref_13875()) {
      if(isDefined(var5.targets["spawn_start_plane"])) {
        var11 = "spawn_start_plane";
      } else {
        var11 = "spawn_plane";
      }
    }
  }

  if(!isDefined(var11)) {
    if(var2 == "attacker") {
      var11 = "spawn_att";
    } else {
      var11 = "spawn_def";
    }

    if(canspawnVehicle() && getdvarint("scr_br_ter_spawn_attack_dauntless", 0) == 1 && var2 == "attacker") {
      var11 = "spawn_plane";
    }

    if(isDefined(self.ref_1366e)) {
      foreach(var13 in var3) {
        if(self.ref_1366e == var13) {
          var5 = var13;
          break;
        }
      }
    }

    if(!isDefined(var5)) {
      var5 = scripts\engine\utility::random(var3);
      self.ref_1366e = var5;
    }
  }

  var15 = var5.targets[var11][var5.ref_11e85[var11]];

  if(!var0) {
    var5.ref_11e85[var11]++;

    if(var5.ref_11e85[var11] >= var5.targets[var11].size) {
      var5.ref_11e85[var11] = 0;
    }
  }

  var15.height = 0;
  return var15;
}

function ref_1452d(var0) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("infil_complete");
  level.teamdata[var0]["nextRespawn"] = 0;

  if(level.deletetimedrunhud.ref_12ca1 == 0) {
    return;
  }

  for(;;) {
    level.teamdata[var0]["nextRespawn"] = gettime() + level.deletetimedrunhud.ref_12ca1 * 1000;
    wait level.deletetimedrunhud.ref_12ca1;
  }
}

function runkilltriger(var0, var1) {
  if(level.deletetimedrunhud.ref_12ca1 == 0) {
    return 0;
  }

  if(!isDefined(var1)) {
    var1 = level.teamdata[var0]["nextRespawn"];
  }

  var2 = max(var1 - gettime(), 0);
  var3 = int(var2 / 1000);
  return var3;
}

function ref_1266e(var0) {
  ref_1268b("attacker", var0);
}

function ref_12678(var0) {
  ref_1268b("defender", var0);
}

function ref_12561(var0) {
  var1 = undefined;

  foreach(var3 in level.deletetimedrunhud.types["location"]) {
    if(var3.state == "current" && var3.team == self.team) {
      var1 = var3;
      break;
    }
  }

  if(isDefined(var1)) {
    ref_1268b(var0, var1);
    return;
  }

  var5 = ref_12565();
  ref_1268b(var0, var5);
}

function ref_1268b(var0, var1) {
  self.ref_136a6 = gettime();
  self.spawntype = var0;
  self.ref_1366e = var1;
}

function ref_1257d() {
  if(!isDefined(self.spawntype)) {
    return "base";
  }

  return self.spawntype;
}

function ref_1198a(var0, var1, var2, var3) {
  scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, var0);
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, var1);
  function_042c(self.objidnum, var2);
  objective_setshowprogress(self.objidnum, var3);
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

function ref_11995(var0, var1) {
  if(isDefined(self.spawnanglemax)) {
    foreach(var3 in level.deletetimedrunhud.teams) {
      var4 = self.spawnanglemax.monitor_hack_prox[var3][var0];

      if(isDefined(var4)) {
        thread spawn_wheelson_blinking_lights(var4);
      }
    }

    return;
  }
}

function ref_11994(var0, var1, var2) {
  if(isDefined(self.spawnanglemax)) {
    foreach(var4 in level.deletetimedrunhud.teams) {
      var5 = self.spawnanglemax.monitor_hack_prox[var4][var0];

      if(isDefined(var5)) {
        thread spawn_weapon_box_cache(var5, var1);
      }
    }

    return;
  }
}

function ref_11990(var0) {
  if(isDefined(self.spawnanglemax)) {
    foreach(var2 in level.deletetimedrunhud.teams) {
      foreach(var4 in self.spawnanglemax.monitor_hack_prox[var2]) {
        if(!isDefined(var4)) {
          continue;
        }

        var4.alpha = var0;
      }
    }

    return;
  }
}

function ref_11993() {
  if(isDefined(self.spawnanglemax)) {
    foreach(var1 in level.deletetimedrunhud.teams) {
      foreach(var4, var3 in self.spawnanglemax.monitor_hack_prox[var1]) {
        if(!isDefined(var3)) {
          continue;
        }

        if(var4 == "label_bg") {
          if(var1 == self.team) {
            spawn_weapons_by_player_count(var3);
            spawndistancemin(var3, (1, 0.341176, 0.341176));
          } else {
            spawn_weapons_by_player_count(var3);
            spawndistancemin(var3, (0.337255, 0.690196, 0.929412));
          }

          continue;
        }

        if(var4 == "label") {
          if(var1 == self.team) {
            spawn_weapons_by_player_count(var3);
            spawndistancemin(var3, (1, 0.341176, 0.341176));
          } else {
            spawn_weapons_by_player_count(var3);
            spawndistancemin(var3, (0.337255, 0.690196, 0.929412));
          }

          continue;
        }

        if(var4 == "icon") {
          if(var1 == self.team) {
            var3 setshader("ui_icon_br_ter_secured", 15, 15);

            if(level.deletetimedrunhud.spawnaccesscards.ref_14291 == 1) {
              spawn_weapons_by_player_count(var3);
              spawndistancemin(var3, (1, 0.341176, 0.341176));
            }
          } else {
            var3 setshader("ui_icon_br_ter_lost", 15, 15);

            if(level.deletetimedrunhud.spawnaccesscards.ref_14291 == 1) {
              spawn_weapons_by_player_count(var3);
              spawndistancemin(var3, (0.337255, 0.690196, 0.929412));
            }
          }

          continue;
        }

        if(var4 == "bar") {
          var3.alpha = 0;
          continue;
        }

        if(var4 == "count") {
          var3 destroy();
        }
      }
    }

    return;
  }
}

function allow_deleteme_on_path(var0) {
  var1 = 0;

  foreach(var3 in var0) {
    if(istrue(var3.ref_12c46)) {
      var1++;
    }
  }

  return var1;
}

function ref_11996() {
  var0 = isDefined(self.targets["damageable"]);
  var1 = isDefined(self.targets["agent"]);
  var2 = 0;
  var3 = 0;

  if(var0) {
    var3 += allow_deleteme_on_path(self.targets["damageable"]);
  }

  if(var1) {
    var3 += allow_deleteme_on_path(self.targets["agent"]);
  }

  if(var0) {
    foreach(var5 in self.targets["damageable"]) {
      if(var5.state == "destroyed" && istrue(var5.ref_12c46)) {
        var2++;
      }
    }
  }

  if(var1) {
    foreach(var8 in self.targets["agent"]) {
      if(var8.state == "destroyed" && istrue(var8.ref_12c46)) {
        var2++;
      }
    }
  }

  var10 = var2 / var3;
  objective_setprogress(self.objidnum, var10);

  if(isDefined(self.spawnanglemax)) {
    foreach(var12 in level.deletetimedrunhud.teams) {
      var13 = self.spawnanglemax.monitor_hack_prox[var12]["bar"];

      if(isDefined(var13)) {
        var13 setshader("progress_bar_fill", int((1 - var10) * level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand), 15);
      }

      var14 = self.spawnanglemax.monitor_hack_prox[var12]["count"];

      if(isDefined(var14)) {
        var14 setvalue(var3 - var2);
      }
    }

    return;
  }
}

function ref_11989(var0) {
  foreach(var2 in self.targets["damageable"]) {
    if(var0) {
      if(var2.state == "protected") {
        is_relic_collat_dmg_active(var2, "undamaged");
      }

      continue;
    }

    is_relic_collat_dmg_active(var2, "protected");
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

  foreach(var1 in self.targets["outpost"]) {
    if(var1.state == "destroyed") {
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

  foreach(var1 in self.targets["outpost"]) {
    if(var1.state != "destroyed") {
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
  var0 = isDefined(self.targets["damageable"]);
  var1 = isDefined(self.targets["agent"]);

  if(!var0 && !var1) {
    return true;
  }

  if(var0) {
    foreach(var3 in self.targets["damageable"]) {
      if(var3.state != "destroyed") {
        return false;
      }
    }
  }

  if(var1) {
    foreach(var6 in self.targets["agent"]) {
      if(var6.state != "destroyed") {
        return false;
      }
    }
  }

  return true;
}

function ref_11971(var0) {
  if(!isDefined(self.targets[var0])) {
    return;
  }

  foreach(var2 in self.targets[var0]) {
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
  var0 = spawnStruct();

  for(;;) {
    var1 = scripts\mp\gametypes\br_vehicles::tryspawnavehicle(self.name, self, "ter_spawns", var0);

    if(!isDefined(var1)) {
      return;
    }

    self.ent = var1;
    self.ent.ref_13a85 = self;

    if(level.deletetimedrunhud.ref_1420a < 0) {
      return;
    }

    var1 waittill("death");
    wait level.deletetimedrunhud.ref_1420a;
  }
}

function ref_11970(var0) {
  if(!isDefined(self.targets[var0])) {
    return;
  }

  foreach(var2 in self.targets[var0]) {
    thread ref_1422a();
  }
}

function ref_1422a() {
  ref_14229();
  ref_1423d();
}

function ref_11979(var0) {
  if(!isDefined(self.targets[var0])) {
    return;
  }

  foreach(var2 in self.targets[var0]) {
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

function ref_1196f(var0) {
  if(!isDefined(self.targets[var0])) {
    return;
  }

  foreach(var2 in self.targets[var0]) {
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
  var0 = spawnStruct();

  for(;;) {
    var1 = brc130airdropcratecapturecallback(self.origin, self.angles, self.team);

    if(!isDefined(var1)) {
      waitframe();
      continue;
    }

    self.ent = var1;
    self.ent.ref_13a85 = self;
    is_relic_collat_dmg_active("active");
    var1 waittill("death", var2);
    binoculars_watchracedeath(var2);
    is_relic_collat_dmg_active("destroyed");
    return;
  }
}

function ref_11978(var0) {
  if(!isDefined(self.targets[var0])) {
    return;
  }

  foreach(var2 in self.targets[var0]) {
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
  var0 = self.name;

  if(!isDefined(level.deletetimedrunhud.ref_1196c[self.name])) {
    var0 = "default";
  }

  return level.deletetimedrunhud.ref_1196c[var0];
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

function ref_1197b(var0) {
  var1 = ref_1197a();
  return var0 + var1.ref_14308;
}

function ref_12565() {
  foreach(var1 in level.deletetimedrunhud.types["base"]) {
    if(var1.team == self.team) {
      return var1;
    }
  }

  return undefined;
}

function ref_125b7(var0) {
  var1 = spawnStruct();
  var1.ref_133e4 = 1;
  scripts\mp\gametypes\br_plunder::playersetplundercount(self.plundercount + var0, var1);
}

function respawn_flare_used(var0) {
  if(var0 == "allies") {
    return "axis";
  }

  return "allies";
}

function request_crate_drop(var0) {
  return relic_nobulletdamage_modifyplayerdamage("means_of_death", var0);
}

function safecheckweapon(var0) {
  return relic_nobulletdamage_modifyplayerdamage("weapon_type", var0);
}

function runpain(var0) {
  return relic_nobulletdamage_modifyplayerdamage("weapon_class_name", var0);
}

function runlogicbasedoncircuitbreaker(var0) {
  return relic_nobulletdamage_modifyplayerdamage("weapon_base_name", var0);
}

function relic_nobulletdamage_modifyplayerdamage(var0, var1) {
  if(!isDefined(var1)) {
    return 1;
  }

  var1 = tolower(var1);
  var2 = level.deletetimedrunhud.is_position_open[var0][var1];

  if(!isDefined(var2)) {
    var3 = level.deletetimedrunhud.is_raid_gamemode[var0][var1];

    if(!isDefined(var3)) {
      var3 = 1;
    }

    var2 = getdvarfloat("scr_br_damage_scale_" + var0 + "_" + var1, var3);
    level.deletetimedrunhud.is_position_open[var0][var1] = var2;
  }

  return var2;
}

function dmzwincost(var0) {
  foreach(var2 in level.deletetimedrunhud.teams) {
    dmztutendgame(var0, var2);
  }
}

function dmztutendgame(var0, var1) {
  if(unfreezeplayercontrols(var0, var1)) {
    return;
  }

  level thread scripts\mp\utility\dialog::leaderdialog(var0, var1);
  ref_13287(var0, var1);
}

function unfreezeplayercontrols(var0, var1) {
  var2 = rungwperif_tracers(var0);

  if(!isDefined(var2) || var2 == 0) {
    return false;
  }

  var3 = rungwperifeffets(var0, var1);

  if(!isDefined(var3)) {
    return false;
  }

  return gettime() < var3 + var2;
}

function ref_13287(var0, var1) {
  if(isDefined(var1)) {
    level.deletetimedrunhud.vo.ref_13b7d[var1][var0] = gettime();
    return;
  }

  foreach(var1 in level.deletetimedrunhud.teams) {
    ref_13287(var0, var1);
  }
}

function rungwperifeffets(var0, var1) {
  if(isDefined(var1)) {
    return level.deletetimedrunhud.vo.ref_13b7d[var1][var0];
  }

  var2 = undefined;

  foreach(var1 in level.deletetimedrunhud.teams) {
    var4 = rungwperifeffets(var0, var1);

    if(isDefined(var2)) {
      if(isDefined(var4) && var4 < var2) {
        var2 = var4;
      }

      continue;
    }

    var2 = var4;
  }
}

function ref_13286(var0, var1) {
  var2 = getdvarint("scr_br_ter_dialog_debounce_" + var0, var1);
  level.deletetimedrunhud.vo.ref_13b72[var0] = var2;
}

function rungwperif_tracers(var0) {
  if(!isDefined(level.deletetimedrunhud.vo.ref_13b72[var0])) {
    ref_13286(var0, 0);
  }

  return level.deletetimedrunhud.vo.ref_13b72[var0];
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

function is_module_active(var0) {
  var1 = self.ref_13a85;

  if(isDefined(var0.attacker)) {
    if(istrue(var1.ref_12c46)) {
      var0.attacker thread scripts\mp\rank::scoreeventpopup("br_ter_obj_destroyed");
      scripts\mp\utility\sound::playsoundonplayers("mp_bodycount_tick_positive", respawn_flare_used(var1.team));
      scripts\mp\utility\sound::playsoundonplayers("mp_bodycount_tick_negative", var1.team);
      ref_125b7(var0.attacker, level.deletetimedrunhud.is_greater_than_equal_to);
    }

    is_moving_platform_train(var1, var0);
  }

  is_relic_collat_dmg_active(var1, "destroyed");
}

function is_moving_platform_train(var0) {
  if(level.deletetimedrunhud.is_in_kill_zone_or_under_bridge_zone > 0) {
    var1 = level.deletetimedrunhud.is_in_kill_zone_or_under_bridge_zone;

    if(level.deletetimedrunhud.is_inflictor_a_carepackage > var1) {
      var1 = randomintrange(var1, level.deletetimedrunhud.is_inflictor_a_carepackage);
    }

    var2 = [];

    for(var3 = 0; var3 < level.deletetimedrunhud.is_in_gas; var3++) {
      var2 = scripts\engine\utility::random(level.deletetimedrunhud.is_killstreak_valid_for_swat);
    }

    for(var3 = 0; var3 < level.deletetimedrunhud.is_hostage_oob; var3++) {
      var2 = scripts\engine\utility::random(level.deletetimedrunhud.is_kidnapping_player);
    }

    var4 = 0;

    if(level.deletetimedrunhud.is_helicopter_player_occupied && isDefined(var0.objweapon)) {
      var5 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var0.objweapon);

      if(isDefined(var5)) {
        var2 = var5;
        var4 = 1;
      }
    }

    for(var3 = 0; var3 < level.deletetimedrunhud.is_helicopter_player_occupied - var4; var3++) {
      var2 = scripts\engine\utility::random(level.deletetimedrunhud.is_instant_use_munition);
    }

    var2 = scripts\engine\utility::array_randomize(var2);
    var6 = min(var1, var2.size);
    var7 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var8 = level.deletetimedrunhud.is_goal_crowded[self.name];

    for(var3 = 0; var3 < var6; var3++) {
      var9 = var2[var3];
      var10 = self.origin + rotatevector(var8.ref_11a3f, self.angles);
      var11 = self.angles + (0, var8.ref_11a49, 0);
      scripts\mp\gametypes\br_lootcache::ref_11a41(var9, var7, var10, var11, 1, 0);
    }

    return;
  }
}

function is_on(var0) {
  var1 = var0.damage;
  var2 = self.ref_13a85;
  var3 = getdvarint("scr_br_ter_allow_friendly_damage", 0);

  if(isDefined(var0.attacker) && var2.team == var0.attacker.team && !var3) {
    var1 = 0;
  } else if(getdvarint("scr_br_ter_one_shot_kill", 0)) {
    var1 = 99999;
  } else if(isDefined(var0.inflictor) && var0.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(var0.inflictor vehicle_getspeed() < level.deletetimedrunhud.is_so_stars_enabled) {
      var1 = 0;
    } else if(isDefined(var2.ref_11e89) && gettime() < var2.ref_11e89) {
      var1 = 0;
    } else {
      var1 = level.deletetimedrunhud.is_same_combat_action;
      var2.ref_11e89 = gettime() + level.deletetimedrunhud.is_scriptable_healthy;
    }
  } else {
    var1 *= request_crate_drop(var0.meansofdeath);

    if(isDefined(var0.objweapon)) {
      var1 *= safecheckweapon(var0.objweapon.type);
      var1 *= runpain(var0.objweapon.classname);
      var1 *= runlogicbasedoncircuitbreaker(var0.objweapon.basename);
    }

    var1 = int(ceil(var1));
  }

  if(var1 > 0 && istrue(var2.ref_12c46)) {
    if(isDefined(var0.attacker)) {
      ref_1266e(var0.attacker, var2.ref_13a82[0]);
    }

    is_relic_collat_dmg_active(var2, "damaged");
    var4 = is_object_allowed_in_gametype(var2);
    dmztutendgame(ref_1197f(var4), respawn_flare_used(var4.team));
    dmztutendgame(ref_1197c(var4), var4.team);
    ref_11991(var4);
  }

  return var1;
}

function binoculars_watchracedeath(var0) {
  var1 = self.ent;

  if(isDefined(var0) && istrue(var1.ref_12c46)) {
    var0 thread scripts\mp\rank::scoreeventpopup("br_ter_obj_destroyed");
    scripts\mp\utility\sound::playsoundonplayers("mp_bodycount_tick_positive", respawn_flare_used(self.team));
    scripts\mp\utility\sound::playsoundonplayers("mp_bodycount_tick_negative", var1.team);
    ref_125b7(var0, level.deletetimedrunhud.is_greater_than_equal_to);
  }

  is_relic_collat_dmg_active("destroyed");
}

function binoculars_watchraceadsoff(var0, var1) {
  var2 = self.ent;
  var3 = var0;

  if(var3 > 0 && istrue(var2.ref_12c46)) {
    if(isDefined(var1)) {
      ref_1266e(var1, self.ref_13a82[0]);
    }

    is_relic_collat_dmg_active("damaged");
    var4 = is_object_allowed_in_gametype();
    dmztutendgame(ref_1197f(var4), respawn_flare_used(var4.team));
    dmztutendgame(ref_1197c(var4), var4.team);
    ref_11991(var4);
    return;
  }
}

function arenaloadouts_getoverrideweaponswithgroup(var0, var1) {
  var2 = self.ent;
  var3 = var0;

  if(var3 > 0 && istrue(var2.ref_12c46)) {
    if(isDefined(var1)) {
      ref_1266e(var1, self.ref_13a82[0]);
    }

    is_relic_collat_dmg_active("damaged");
    var4 = is_object_allowed_in_gametype();
    dmztutendgame(ref_1197f(var4), respawn_flare_used(var4.team));
    dmztutendgame(ref_1197c(var4), var4.team);
    ref_11991(var4);
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
  var0 = level.deletetimedrunhud.is_goal_crowded[self.name];
  self.ent scripts\mp\damage::monitordamage(var0.health, "hitequip", &is_module_active, &is_on);
}

function is_operations_gametype() {
  self endon("monitorDamageEnd");
  self.ent endon("death");

  for(;;) {
    self.ent waittill("damage", var0, var1);
    binoculars_watchraceadsoff(var0, var1);
  }
}

function is_opened() {
  self endon("monitorDamageEnd");
  self.ent endon("death");

  for(;;) {
    self.ent waittill("damage", var0, var1);
    arenaloadouts_getoverrideweaponswithgroup(var0, var1);
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

function is_relic_collat_dmg_active(var0) {
  if(var0 == self.state) {
    return;
  }

  if(self.is_minimap_forcedisabled == "script_model") {
    switch (var0) {
      case "protected":
        is_relic_active(var0);
        is_player_damage_disabled();
        break;
      case "undamaged":
        if(isDefined(self.ent.damagetaken)) {
          self.ent.damagetaken = 0;
        }

        is_relic_active(var0);
        self.ent setscriptablepartstate("ter_damageable", "default");
        is_one_player_near_point2d();
        break;
      case "damaged":
        is_relic_active(var0);
        self.ent setscriptablepartstate("ter_damageable", "damaged");
        var1 = getdvarint("scr_br_ter_allow_enemy_repair", 0);

        foreach(var3 in level.players) {
          if(!level.deletetimedrunhud.brjugg_watchgasdamage) {
            self.ent disablescriptableplayeruse(var3);
            continue;
          }

          if(var1 || var3.team == self.team) {
            self.ent enablescriptableplayeruse(var3);
            continue;
          }

          self.ent disablescriptableplayeruse(var3);
        }

        break;
      case "destroyed":
        is_relic_active(var0);
        var5 = level.deletetimedrunhud.is_goal_crowded[self.name];
        self.ent setModel(var5.modeldestroyed);
        self.ent setscriptablepartstate("ter_damageable", "destroyed");
        is_player_damage_disabled();
        var6 = is_object_allowed_in_gametype();
        ref_11992(var6);
        break;
      default:
        break;
    }
  } else if(self.is_minimap_forcedisabled == "jugg_agent" || self.is_minimap_forcedisabled == "aa_turret") {
    switch (var0) {
      case "undamaged":
      case "active":
        is_relic_active(var0);
        is_one_player_near_point2d();
        break;
      case "damaged":
        is_relic_active(var0);
        break;
      case "destroyed":
        is_relic_active(var0);
        is_player_damage_disabled();
        var6 = is_object_allowed_in_gametype();
        ref_11992(var6);
        break;
      case "protected":
        is_relic_active(var0);
        break;
      default:
        break;
    }
  }

  self.state = var0;

  foreach(var8 in self.ref_13a82) {
    var8 notify("damageable_state_change", self);
  }
}

function is_riding_heli(var0, var1, var2, var3, var4) {
  ref_12678(var3, var0.entity.ref_13a85.ref_13a82[0]);
  var3 thread scripts\mp\rank::scoreeventpopup("br_ter_obj_repaired");
  var3 playlocalsound("mp_bodycount_tick_positive");
  ref_125b7(var3, level.deletetimedrunhud.is_main_pilot);
  is_relic_collat_dmg_active(var0.entity.ref_13a85, "undamaged");
}

function is_relic_active(var0) {
  var1 = self;
  var2 = self.team;
  var3 = respawn_flare_used(self.team);

  if(!istrue(var1.ref_12c46)) {
    var1.ent hudoutlinedisable();
    return;
  }

  var4 = getdvarint("scr_br_ter_outline_destroyed_destructables", 0);

  switch (var0) {
    case "undamaged":
    case "active":
      spawnc130pathstructnewinternal(var1.ent, var2, "outline_depth_friendly");
      spawnc130pathstructnewinternal(var1.ent, var3, "outline_depth_enemy");
      break;
    case "damaged":
      spawnc130pathstructnewinternal(var1.ent, var2, "outline_depth_friendly_damaged");
      spawnc130pathstructnewinternal(var1.ent, var3, "outline_depth_enemy_damaged");
      break;
    case "destroyed":
      if(var4) {
        spawnc130pathstructnewinternal(var1.ent, var2, "outline_depth_friendly_destroyed");
        spawnc130pathstructnewinternal(var1.ent, var3, "outline_depth_enemy_destroyed");
      } else {
        var1.ent hudoutlinedisable();
      }

      break;
    case "protected":
      var1.ent hudoutlinedisable();
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

  foreach(var1 in level.deletetimedrunhud.teams) {
    level.deletetimedrunhud.spawnaccesscards.temp.ref_11b59[var1] = 0;
    level.deletetimedrunhud.spawnaccesscards.temp.ref_11b55[var1] = 0;
    level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[var1] = [];
  }

  foreach(var4 in self.targets["base"]) {
    ref_11986(var4, 0);
  }

  foreach(var4 in self.targets["base"]) {
    ref_11977(var4);
  }

  level.deletetimedrunhud.spawnaccesscards.temp = undefined;
}

function ref_11986(var0) {
  if(isDefined(self.spawnanglemax)) {
    return;
  }

  self.spawnanglemax = spawnStruct();
  self.spawnanglemax.temp = spawnStruct();

  if(isDefined(level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var0])) {
    level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var0]++;
  } else {
    level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var0] = 0;
  }

  var1 = level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var0];
  level.deletetimedrunhud.spawnaccesscards.temp.ref_11b55[self.team] = max(level.deletetimedrunhud.spawnaccesscards.temp.ref_11b55[self.team], var1);
  level.deletetimedrunhud.spawnaccesscards.temp.ref_11b59[self.team] = max(level.deletetimedrunhud.spawnaccesscards.temp.ref_11b59[self.team], var0);
  self.spawnanglemax.temp.lasttimespawngroupcalled = var0;
  self.spawnanglemax.temp.disable_ignore_if_near_player = level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][var0];

  foreach(var3 in self.targets["outpost"]) {
    ref_11986(var3, var0 + 1);
  }
}

function ref_11977() {
  if(isDefined(self.spawnanglemax.monitor_hack_prox)) {
    return;
  }

  var0 = ref_1197a();
  self.spawnanglemax.monitor_hack_prox = [];

  foreach(var2 in level.deletetimedrunhud.teams) {
    if(!isDefined(self.spawnanglemax.monitor_hack_prox[var2])) {
      self.spawnanglemax.monitor_hack_prox[var2] = [];
    }

    var3 = level.deletetimedrunhud.spawnaccesscards.temp.ref_11b59[self.team];
    var4 = 5;
    var5 = level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand + var4;
    var5 += (15 + level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand) * (var3 - self.spawnanglemax.temp.lasttimespawngroupcalled);

    if(level.deletetimedrunhud.spawnaccesscards.watchcratetimeout == 1) {
      var5 -= int((var3 + 1) * (15 + level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand) * 0.5);
      var6 = 2;
    } else {
      var6 = 4;
    }

    var7 = 7.5;
    var7 += level.deletetimedrunhud.spawnaccesscards.ref_13bde;
    var7 += (15 + var6) * self.spawnanglemax.temp.disable_ignore_if_near_player;
    var8 = level.deletetimedrunhud.spawnaccesscards.temp.ref_11b55[self.team];
    var9 = level.deletetimedrunhud.spawnaccesscards.temp.disable_ignore_on_getto[self.team][self.spawnanglemax.temp.lasttimespawngroupcalled];

    if(var8 > 0 && var9 < var8) {
      var10 = var6 + 15;
      var10 *= (var8 - var9) / var8;
      var7 += var10;
    }

    var11 = var5;

    if(level.deletetimedrunhud.spawnaccesscards.ref_14291 != 1) {
      var11 += 15;
    }

    var12 = var7;

    if(self.team == var2) {
      var5 *= -1;
      var11 *= -1;
      var13 = "LEFT";
    } else if(level.deletetimedrunhud.spawnaccesscards.watchcratetimeout == 1) {
      var7 += (15 + var6) * (var8 + 1);
      var12 += (15 + var6) * (var8 + 1);
      var5 *= -1;
      var11 *= -1;
      var13 = "LEFT";
    } else {
      var13 = "RIGHT";
    }

    var14 = var2;
    var15 = scripts\engine\utility::ter_op(self.team == var2, (0.337255, 0.690196, 0.929412), (1, 0.341176, 0.341176));
    var16 = scripts\engine\utility::ter_op(level.deletetimedrunhud.spawnaccesscards.ref_14291 == 1, var15, (1, 1, 1));
    var17 = hudicon(var14, var0.hudicon, var16);
    var17 scripts\mp\hud_util::setpoint(var13, "CENTERTOP", var11, var12);
    self.spawnanglemax.monitor_hack_prox[var2]["icon"] = var17;

    if(level.deletetimedrunhud.spawnaccesscards.ref_14291 != 1) {
      var18 = spawnboardroom_gasmask(var14, var15);
      var18 scripts\mp\hud_util::setpoint(var13, "CENTERTOP", var11, var12);
      self.spawnanglemax.monitor_hack_prox[var2]["label_bg"] = var18;
    }

    var19 = spawn_transition_camera(var14);
    var19 scripts\mp\hud_util::setpoint(var13, "CENTERTOP", var5, var7);
    self.spawnanglemax.monitor_hack_prox[var2]["bar"] = var19;
    thread ref_11976(var2, var14, var13, var11 + 15, var12);
  }

  foreach(var22 in self.targets["outpost"]) {
    ref_11977(var22);
  }

  self.spawnanglemax.temp = undefined;
}

function ref_11976(var0, var1, var2, var3, var4) {
  if(level.deletetimedrunhud.spawnaccesscards.ref_13347 == 0) {
    return;
  }

  if(level.deletetimedrunhud.spawnaccesscards.ref_13347 == 1) {
    self waittill("current");
  }

  var5 = spawn_tut_loot(var1);
  var5 scripts\mp\hud_util::setpoint(var2, "CENTERTOP", var3, var4);
  self.spawnanglemax.monitor_hack_prox[var0]["count"] = var5;
}

function hudicon(var0, var1, var2) {
  var3 = newteamhudelem(var0);
  var3.archived = 0;
  var3.elemtype = "";
  var3.width = 15;
  var3.height = 15;
  var3.xoffset = 0;
  var3.yoffset = 0;
  var3.children = [];
  var3.sort = 0;
  spawndistancemin(var3, var2);
  var3.alpha = 1;
  var3 scripts\mp\hud_util::setparent(level.uiparent);
  var3 setshader(var1, 15, 15);
  var3.hidden = 0;
  return var3;
}

function spawnboardroom_auav(var0, var1) {
  var2 = 15 / level.fontheight;
  var3 = newteamhudelem(var0);
  var3.archived = 0;
  var3.elemtype = "font";
  var3.font = "default";
  var3.fontscale = var2;
  var3.basefontscale = var2;
  var3.sort = 0;
  var3.width = 11;
  var3.height = 15;
  var3.xoffset = 0;
  var3.yoffset = 0;
  var3.children = [];
  var3 scripts\mp\hud_util::setparent(level.uiparent);
  var3.hidden = 0;
  var3.label = var1;
  spawndistancemin(var3, (1, 1, 1));
  return var3;
}

function spawnboardroom_gasmask(var0, var1) {
  var2 = newteamhudelem(var0);
  var2.archived = 0;
  var2.elemtype = "";
  var2.width = 15;
  var2.height = 15;
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  var2.sort = -1;
  spawndistancemin(var2, var1);
  var2.alpha = 1;
  var2 scripts\mp\hud_util::setparent(level.uiparent);
  var2 setshader("progress_bar_fill", 15, 15);
  var2.hidden = 0;
  return var2;
}

function spawn_transition_camera(var0) {
  var1 = newteamhudelem(var0);
  var1.archived = 0;
  var1.elemtype = "";
  var1.width = level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand;
  var1.height = 15;
  var1.xoffset = 0;
  var1.yoffset = 0;
  var1.children = [];
  var1.sort = -3;
  spawndistancemin(var1, (1, 1, 1));
  var1.alpha = 1;
  var1 scripts\mp\hud_util::setparent(level.uiparent);
  var1 setshader("progress_bar_fill", level.deletetimedrunhud.spawnaccesscards.choppersupport_watchforlaststand, 15);
  var1.hidden = 0;
  return var1;
}

function spawn_tut_loot(var0) {
  var1 = 15 / level.fontheight;
  var2 = newteamhudelem(var0);
  var2.archived = 0;
  var2.elemtype = "font";
  var2.font = "default";
  var2.fontscale = var1;
  var2.basefontscale = var1;
  var2.sort = 0;
  var2.width = 15;
  var2.height = 15;
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  var2 scripts\mp\hud_util::setparent(level.uiparent);
  var2.hidden = 0;
  spawndistancemin(var2, (1, 1, 0));
  return var2;
}

function spawndistancemin(var0) {
  self.color = var0;
  self.juggernauts_spawned = var0;
}

function spawn_wheelson_blinking_lights(var0) {
  self endon("death");
  self notify("end_flash");
  self endon("end_flash");
  self.color = var0;
  wait 0.2;
  self.color = self.juggernauts_spawned;
}

function spawn_weapon_box_cache(var0, var1) {
  self endon("death");
  self endon("end_flashing");
  self.player_onspawn = var0;

  if(isDefined(self.player_origin_inside_front_zone)) {
    var2 = gettime() + var1 * 1000;

    if(var2 > self.player_origin_inside_front_zone) {
      self.player_origin_inside_front_zone = var2;
    }

    return;
  } else {
    self.player_origin_inside_front_zone = gettime() + var2 * 1000;
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

function target_in_range_and_fov(var0) {
  if(!isDefined(self.targets)) {
    self.targets = [];
  }

  if(!isDefined(self.targets[var0])) {
    self.targets[var0] = [];
    return;
  }
}

function hide_bomb_case_timer(var0, var1) {
  var2 = var0[0];
  var3 = var0[1];
  var4 = var0[2];
  return ((1 - var2) * var1 + var2, (1 - var3) * var1 + var3, (1 - var4) * var1 + var4);
}

function spawnc130pathstructnewinternal(var0, var1) {
  if(level.teamdata[var0]["players"].size) {
    self hudoutlineenableforclients(level.teamdata[var0]["players"], var1);
    return;
  }
}

function canspawnVehicle() {
  return level.vehiclecount < getdvarint("scr_br_ter_max_vehicle_count", 120);
}

function ref_13875() {
  return canspawnVehicle() && getdvarint("scr_br_ter_start_in_planes", 0);
}