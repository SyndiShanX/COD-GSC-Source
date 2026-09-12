/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1.gsc
**********************************************************************/

function main(var_0) {
  level.mlp1_obj_func = &register_ml_p1_objectives;
  scripts\engine\utility::flag_init("ml_p1_objective_done");
  scripts\engine\utility::flag_init("ml_p1_spawn_functions_registered");
  scripts\engine\utility::flag_init("reinforce_1_ready");
  scripts\engine\utility::flag_init("reinforce_2_ready");
  scripts\engine\utility::flag_init("reinforce_3_ready");
}

function register_ml_p1_objectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(!istrue(level.ml_p1_objectives_registered)) {
    level.ml_p1_objectives_registered = 1;
  } else {
    return;
  }

  scripts\cp\cp_objectives::registerobjective("ml_p1_intel", &init_ml_p1_intel, &start_ml_p1_intel, &end_ml_p1_intel, &debugbeatobjective, &debug_m1_p1_obj_start);
  thread register_spawn_functions();
  thread spawn_player_vehicles();
  thread ref_12BC3();
  thread fire_rpg_to_target();
  level.stack_patch_waittill_leaf = ["p1_intel_truck_group"];
  level.waittill_any_timeout_no_endon_death_5 = 0;
}

function debugbeatobjective(var_0) {}

function register_spawn_functions() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_ml_p1_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_ml_p1_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p1_create_script_completed");
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  var_1 = ["tower_spawner", "museum_spawner", "construction_spawner", "parliment_spawner"];
  [[var_0]]("p1_intel_group", 8, 8, 8, 0.1, undefined, var_1);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_group", &p1_intel_after_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_group", &scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_group", &give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_group", &scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_group", &alert_when_see_player);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_group", &getbattlepassxpultipliertotal);
  [[var_0]]("p1_intel_heli_group", 6, 6, 6, 0.1, undefined, "p1_intel_heli_group");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_heli_group", &p1_intel_after_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_heli_group", &scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_heli_group", &give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_heli_group", &scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  [[var_0]]("p1_intel_truck_group", 6, 6, 6, 0.1, undefined, &proplist);
  [[var_0]]("p1_intel_perch", 4, 4, 4, 0.1, undefined, "intel_perch");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_perch", &p1_intel_after_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_perch", &scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_perch", &give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_perch", &scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_perch", &alert_when_see_player);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_perch", &getbattlepassxpultipliertotal);
  [[var_0]]("p1_intel_ambient", 10, 10, 10, 0.1, undefined, "intel_ambient");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_ambient", &p1_intel_after_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_ambient", &scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_ambient", &give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_ambient", &scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_ambient", &alert_when_see_player);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("p1_intel_ambient", &getbattlepassxpultipliertotal);
  [[var_0]]("p1_intel_museum_truck", 4, 4, 4, 0.1, undefined, "intel_11");
  [[var_0]]("p1_intel_tower_truck", 4, 4, 4, 0.1, undefined, "bank_6");
  [[var_0]]("p1_intel_bomber", 0, 2, undefined, 3, undefined, "p1_bomber");

  if(!scripts\engine\utility::flag_exist("init_spawn_volumes_done")) {
    scripts\engine\utility::flag_init("init_spawn_volumes_done");
  }

  scripts\engine\utility::flag_set("init_spawn_volumes_done");
  scripts\engine\utility::flag_set("ml_p1_spawn_functions_registered");
}

function spawn_player_vehicles() {
  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_ml_p1_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_ml_p1_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p1_create_script_completed");
  var_0 = scripts\engine\utility::getStructArray("player_vehicle", "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    var_2.team = "allies";

    if(!isDefined(var_2.script_noteworthy)) {
      var_2.script_noteworthy = "technical";
    }

    var_3 = getdvarint("scr_dwn_twn_veh_test", 0);

    if(!var_3) {
      var_2.script_noteworthy = "technical";
    }

    var_3 = getDvar("scr_dwn_twn_veh_test_force", "");

    if(var_3 != "") {
      var_2.script_noteworthy = var_3;
    }

    switch (var_2.script_noteworthy) {
      case "atv":
        scripts\cp_mp\vehicles\atv::atv_create(var_2);
        break;
      case "decho":
        scripts\cp_mp\vehicles\jeep::jeep_create(var_2);
        break;
      case "mkilo":
        scripts\cp_mp\vehicles\cargo_truck::cargo_truck_create(var_2);
        break;
      case "technical":
        scripts\cp_mp\vehicles\technical::technical_create(var_2);
        break;
      case "tromeo":
        scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_2);
        break;
      case "hindia":
        scripts\cp_mp\vehicles\technical::technical_create(var_2);
        break;
      case "skilo":
        scripts\cp_mp\vehicles\cop_car::cop_car_create(var_2);
        break;
      case "pindia":
        scripts\cp_mp\vehicles\hoopty::hoopty_create(var_2);
        break;
      case "techo":
        scripts\cp_mp\vehicles\pickup_truck::pickup_truck_create(var_2);
        break;
      case "zuniform":
        scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_create(var_2);
        break;
      default:
        scripts\cp_mp\vehicles\technical::technical_create(var_2);
        break;
    }

    wait 0.5;
  }
}

function ref_13590() {
  var_0 = scripts\engine\utility::getStructArray("enemy_sentry", "targetname");

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0) {
    thread ref_1353B(var_2);
  }
}

function ref_1353B(var_0) {
  var_1 = scripts\mp\carriable::ref_131EA(var_0);
  var_1.matchdata_logaward = 1;
}

function fire_rpg_to_target() {
  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_ml_p1_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_ml_p1_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p1_create_script_completed");
  level.ref_13644 = [];
  var_0 = ["intel_1", "intel_2", "intel_3", "intel_4", "intel_5", "intel_6", "intel_7", "intel_8", "intel_9", "intel_10", "intel_11", "intel_12", "intel_13", "bank_1", "bank_2", "bank_3", "bank_4", "bank_5", "bank_6", "police_1", "police_2", "hack_1", "hack_2"];

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStruct(var_2, "targetname");

    if(isDefined(var_3)) {
      var_4 = var_3;

      while(isDefined(var_4) && isDefined(var_4.script_linkto)) {
        var_4 = scripts\engine\utility::getStruct(var_4.script_linkto, "script_linkname");

        if(isDefined(var_4) && isDefined(var_4.script_unload)) {
          var_5 = spawnStruct();
          var_5.modelpart = var_4;

          if(!isDefined(var_3.angles)) {
            var_3.angles = (0, 0, 0);
          }

          var_5.spawner = var_3;
          var_5.origin = var_4.origin;
          level.ref_13644[level.ref_13644.size] = var_5;
          break;
        }
      }
    }
  }

  var_7 = 1;
}

function proplist(var_0) {
  if(!isDefined(level.modemayconsiderplayerdead)) {
    var_1 = level.ml_p1_obj_loc;
    var_2 = 4000;
    var_3 = scripts\engine\utility::get_array_of_closest(var_1.origin, level.ref_13644, undefined, undefined, var_2);

    if(var_3.size > 0) {
      var_4 = min(3, var_3.size);
      var_4 = randomint(int(var_4));
      var_5 = var_3[var_4];
    } else {
      var_4 = randomint(level.ref_13644.size);
      var_5 = level.ref_13644[var_4];
    }

    level.modemayconsiderplayerdead = var_5.spawner;
  }

  return [level.modemayconsiderplayerdead];
}

function ref_12BC3() {
  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_ml_p1_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_ml_p1_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p1_create_script_completed");
  var_0 = scripts\engine\utility::getStructArray("bank_roof_munition_remove", "targetname");

  foreach(var_2 in var_0) {
    level thread scripts\cp\cp_munitions::ref_12BE1(var_2.origin, 200);
  }
}

function give_guy_pacifist_override(var_0) {
  self.pacifist_override = 1;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 250000);
  thread kicknullmusicondeath(self);
}

function kicknullmusicondeath(var_0) {
  var_0 endon("death");
  waitframe();
  var_0 notify("basic_combat");
}

function spawn_per_player(var_0, var_1, var_2, var_3) {
  var_4 = max(var_1, var_2 * level.players.size);
  var_4 = min(var_4, 24);
  return var_4;
}

function getbattlepassxpultipliertotal(var_0) {
  var_1 = self;
  thread getbeingrevivedinternal(var_1);
}

function getbeingrevivedinternal(var_0) {
  level endon("game_ended");
  var_0 endon("death");

  if(!self.group scripts\engine\utility::ent_flag("weapons_free")) {
    level waittill("weapons_free");
  }

  var_0.goalradius = int(propwaitminigamecleanup(var_0));
}

function propwaitminigamecleanup(var_0) {
  if(isDefined(self.spawnpoint.spawnflags) && self.spawnpoint.spawnflags & 512) {
    return self.goalradius;
  }

  var_1 = scripts\engine\utility::getStructArray("ambient_intel_radius", "targetname");
  var_2 = scripts\engine\utility::getclosest(self.spawnpoint.origin, var_1, 1000);

  if(isDefined(var_2)) {
    return var_2.radius;
  }

  return self.goalradius;
}

function alert_when_see_player(var_0) {
  level endon("game_ended");
  self endon("death");
  return_when_cansee_player();

  foreach(var_2 in var_0.ai_spawned) {
    var_2 notify("bulletwhizby");
  }
}

function return_when_cansee_player() {
  self endon("mission_compromised");
  self endon("enter_combat");

  for(;;) {
    var_0 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, undefined, 1024);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(self cansee(level.players[var_1])) {
        return;
      }
    }

    wait 0.25;
  }
}

function init_spawn_radius_check_for_modules() {}

function ref_11F7F(var_0, var_1) {
  scripts\cp\utility::objective_update("ml_p1_intel", undefined, undefined, undefined, undefined, level.intel_level);
  thread ref_13590();
  scripts\cp\cp_modular_spawning::run_spawn_module("p1_intel_group");
  scripts\cp\cp_modular_spawning::run_spawn_module("p1_intel_perch");
  scripts\cp\cp_modular_spawning::run_spawn_module("p1_intel_ambient");
  scripts\cp\cp_modular_spawning::run_spawn_module("p1_intel_bomber");
  thread ref_1243C(level);
  thread ref_1243C(level);
  thread ref_1243C(level);
  thread ref_1243C(level);
  thread start_mortars();
  thread ref_1311E();
  thread ref_135EA(level, "museum_spawner", 2000);
  thread ref_135EA(level, "tower_spawner", 3000);
  scripts\cp\cp_modular_spawning::set_wave_ref_OVERRIDE("va_init_veh");
  thread ref_13095();

  while(level.intel_level < var_1) {
    wait 0.5;
  }

  var_2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_spawning");

  foreach(var_4 in var_2) {
    var_4 scripts\cp\cp_modular_spawning::clear_wave_ref_OVERRIDE();
  }

  mark_group_as_killable("p1_intel_group");
  remove_force_drop_on_group("p1_intel_group");
  mark_group_as_killable("p1_intel_perch");
  remove_force_drop_on_group("p1_intel_perch");
  mark_group_as_killable("p1_intel_ambient");
  remove_force_drop_on_group("p1_intel_ambient");
}

function ref_1311E() {
  level waittill("weapons_free");
  scripts\cp\cp_modular_spawning::set_wave_ref_OVERRIDE("va_init_veh");
}

function ref_13095() {
  level.vehicle.spawn_callback_thread = &ref_130A4;
}

function ref_130A4(var_0) {
  var_0.ref_11E98 = 1;
  var_0.vehicle_skipdeathcrash = 1;
}

function ref_135EA(var_0, var_1, var_2) {
  level endon("end_p1_spawn_loops");
  level endon("game_ended");
  var_3 = scripts\engine\utility::getStructArray("ambient_intel_radius", "targetname");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6.target == var_0) {
      var_4 = var_6;
      break;
    }
  }

  if(!isDefined(var_4)) {
    return;
  }

  var_8 = var_1 * var_1;
  var_9 = 0;

  while(!var_9) {
    foreach(var_11 in level.players) {
      if(distancesquared(var_11.origin, var_4.origin) < var_8) {
        var_9 = 1;
        break;
      }
    }

    wait 0.25;
  }

  var_13 = scripts\cp\cp_modular_spawning::run_spawn_module(var_2);
}

function ref_1243C(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("ml_p1_marker_" + var_0);
  var_3 = scripts\engine\utility::getStructArray("ambient_intel_radius", "targetname");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6.target == var_0) {
      var_4 = var_6;
      break;
    }
  }

  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_setbackground(var_2, 1);
  objective_state(var_2, "current");
  objective_icon(var_2, "icon_waypoint_objective_general");
  objective_position(var_2, var_4.origin);
  objective_setshowdistance(var_2, 1);
  var_8 = questtimerset(var_0);

  if(isDefined(var_8)) {
    objective_setlabel(var_2, var_8);
  }

  thread ref_1294A(var_4);

  for(;;) {
    level waittill("ml_p1_intel_dropped", var_9);

    if(var_0 == var_9.traincar_wait_until_shown) {
      var_10 = var_9.origin;
      var_4 notify("intel_dropped");
      thread ref_11D8F(level, var_2, var_10);
      goto LOC_000000f5;
    }
  }

  for(;;) {
    level waittill("ml_p1_intel_found", var_11);

    if(var_0 == var_11) {
      level notify(var_0 + "_intel_found");
      scripts\cp\utility::objective_update("ml_p1_intel", undefined, undefined, undefined, undefined, level.intel_level);
      play_intel_pickup_vo();
      break;
    }
  }

  objective_state(var_2, "done");
  scripts\cp\cp_objectives::freeworldid("ml_p1_marker_" + var_0);
}

function questtimerset(var_0) {
  switch (var_0) {
    case "construction_spawner":
      return "CP_DWN_TWN_OBJECTIVES/CONSTRUCT";
    case "tower_spawner":
      return "CP_DWN_TWN_OBJECTIVES/TV";
    case "museum_spawner":
      return "CP_DWN_TWN_OBJECTIVES/MUSEUM";
    case "parliment_spawner":
      return "CP_DWN_TWN_OBJECTIVES/PARLIAMENT";
    default:
      break;
  }
}

function ref_1294A(var_0) {
  self endon("intel_dropped");
  var_1 = 1500;
  var_2 = var_1 * var_1;
  var_3 = 0;

  while(!var_3) {
    foreach(var_5 in level.players) {
      if(distancesquared(var_5.origin, self.origin) < var_2) {
        var_3 = 1;
        break;
      }
    }

    waitframe();
  }

  var_7 = level.train_start_from_struct[self.target];

  if(isalive(var_7)) {
    objective_onentity(var_0, var_7);
    objective_setzoffset(var_0, 90);
    return;
  }
}

function ref_11D8F(var_0, var_1, var_2) {
  level endon(var_2 + "_intel_found");
  objective_icon(var_0, "icon_waypoint_objective_general");
  objective_position(var_0, var_1);
  wait 2;
  objective_state(var_0, "invisible");
}

function move_objective_spot_around(var_0, var_1) {
  level endon("end_p1_spawn_loops");
  level.ml_p1_intel_locs = [];
  level.intel_drop_chance_inc = 0;
  level.ml_p1_intel_area = 1;
  level.ref_12325 = 0;
  scripts\cp\utility::objective_update("ml_p1_intel", undefined, undefined, undefined, undefined, level.intel_level);
  scripts\cp\cp_modular_spawning::run_spawn_module("p1_intel_group");
  scripts\cp\cp_modular_spawning::run_spawn_module("p1_intel_perch");
  scripts\cp\cp_modular_spawning::run_spawn_module("p1_intel_ambient");

  while(level.intel_level < var_1) {
    var_2 = get_intel_loc();

    if(isDefined(var_2)) {
      level.ml_p1_intel_locs = scripts\engine\utility::array_remove(level.ml_p1_intel_locs, var_2);
      level.ml_p1_obj_loc = var_2;
      level.ml_p1_intel_drop = 1;
      var_3 = var_0.objectiveindex;
      objective_setplayintro(var_3, 1);
      objective_setplayoutro(var_3, 0);
      objective_setbackground(var_3, 0);
      objective_state(var_3, "current");
      objective_icon(var_3, "icon_waypoint_objective_general");
      objective_position(var_3, var_2.origin);
      objective_setshowdistance(var_3, 1);
      scripts\cp\cp_objectives::ref_1317E(var_0, var_2.origin);

      if(isDefined(level.ml_p1_obj_spawners)) {
        for(var_4 = 0; var_4 < level.ml_p1_obj_spawners.size; var_4++) {
          level.ml_p1_obj_spawners[var_4] = undefined;
        }
      }

      level.ml_p1_obj_spawners = undefined;
      level.trial_combo_died = undefined;
      level.modemayconsiderplayerdead = undefined;
      var_5 = ["ml_p1_intel_found", "ml_p1_intel_timed_out", "ml_p1_intel_prox_remove"];
      var_6 = level scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_5);
      level.ml_p1_intel_drop = undefined;
      level.ref_12325 = 0;
      mark_group_as_killable("p1_intel_group");
      remove_force_drop_on_group("p1_intel_group");

      if(var_6 == "ml_p1_intel_found") {
        if(level.intel_level >= var_1) {
          level.should_drop_intel_func = undefined;
        }

        objective_state(var_3, "invisible");
        scripts\cp\utility::objective_update("ml_p1_intel", undefined, undefined, undefined, undefined, level.intel_level);
        play_intel_pickup_vo();
      } else {
        scripts\cp\cp_dialogue::play_vo_to_all(proxy_trigger());
      }

      level scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_2.origin);
      continue;
    }

    wait 0.5;
  }

  level notify("stop_monitor_dropped_phones");
}

function ref_11CDA() {
  level endon("stop_monitor_dropped_phones");

  for(;;) {
    if(isDefined(level.intel_drops) && level.intel_drops.size > 1) {
      level.intel_drops[1] scripts\cp\intel\cp_intel::remove_intel_piece();
    }

    waitframe();
  }
}

function ref_12117() {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(6, "p1_intel_truck_group");
  wait 1;

  if(isDefined(level.ml_p1_obj_loc)) {
    var_0 = scripts\cp\cp_modular_spawning::run_spawn_module("p1_intel_truck_group");
    return;
  }
}

function test_intel_loc() {
  var_0 = level.ml_p1_intel_locs[0];
  return var_0;
}

function get_intel_loc() {
  level.ml_p1_intel_locs = scripts\engine\utility::getStructArray("ambient_intel_radius", "targetname");
  var_1 = level.ml_p1_intel_locs;
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy)) {
      if(int(var_4.script_noteworthy) == level.ml_p1_intel_area) {
        var_2 = var_4;
      }
    }
  }

  var_6 = undefined;

  if(var_2.size > 0) {
    var_2 = scripts\engine\utility::array_randomize(var_2);
    var_7 = 1500;
    var_8 = var_7 * var_7;

    if(level.intel_level == 0) {
      var_6 = var_2[0];
    } else {
      var_9 = [];

      foreach(var_4 in var_2) {
        if(level.ml_p1_obj_loc != var_4) {
          if(distance2dsquared(var_4.origin, level.ml_p1_obj_loc.origin) > var_8) {
            var_9 = var_4;
          }
        }
      }

      var_12 = [];

      foreach(var_4 in var_9) {
        var_14 = 0;

        foreach(var_16 in level.players) {
          var_17 = var_16 getEye();
          var_18 = spawnsighttrace(undefined, var_4.origin + (0, 0, 56), var_17);

          if(var_18 > 0) {
            var_14 = 1;
          }
        }

        if(!var_14) {
          var_12 = var_4;
        }
      }

      if(var_12.size > 0) {
        if(isDefined(level.ml_p1_obj_loc)) {
          var_12 = sortbydistance(var_12, level.ml_p1_obj_loc.origin);
        }

        var_6 = var_12[0];
      } else if(var_9.size > 0) {
        var_6 = var_9[0];
      } else if(level.ml_p1_obj_loc != var_2[0]) {
        var_6 = var_2[0];
      } else {
        var_6 = var_2[1];
      }
    }
  }

  level.ml_p1_intel_area++;

  if(level.ml_p1_intel_area > 4) {
    level.ml_p1_intel_area = 1;
  }

  return var_6;
}

function ref_11CF6(var_0) {
  for(;;) {
    wait 1;
  }
}

function ref_11C59(var_0) {
  switch (level.intel_level) {
    case 0:
      ref_123CB("obj_collect_first", var_0);
      break;
    case 1:
      ref_123CB("obj_collect_another", var_0);
      break;
    case 2:
      ref_123CB("obj_collect_generic", var_0);
      break;
    case 3:
      ref_123CB("obj_collect_another", var_0);
      break;
    case 4:
      ref_123CB("inform_collect_complete", var_0);
      break;
    default:
      ref_123CB("obj_collect_generic", var_0);
      break;
  }
}

function play_intel_pickup_vo() {
  switch (level.intel_level) {
    case 0:
      scripts\cp\cp_dialogue::play_vo_to_all(publiceventsenabled(0));
      break;
    case 1:
      scripts\engine\utility::flag_set("reinforce_1_ready");
      scripts\cp\cp_dialogue::play_vo_to_all(publiceventsenabled(1));
      break;
    case 2:
      scripts\engine\utility::flag_set("reinforce_2_ready");
      scripts\cp\cp_dialogue::play_vo_to_all(publiceventsenabled(2));
      break;
    case 3:
      scripts\cp\utility::ref_123FE("mus_cp_money_final_intel");
      scripts\cp\cp_dialogue::play_vo_to_all(publiceventsenabled(4));
      break;
    case 4:
      break;
    case 5:
      break;
    default:
      break;
  }
}

function publiceventsenabled(var_0) {
  if(!isDefined(level.traincolignorelist)) {
    level.traincolignorelist = ["dx_cps_kama_mobile_heist_need_more_intel_10", "dx_cps_kama_mobile_heist_getting_somewhere_10", "dx_cps_kama_mobile_heist_narrowing_list_10", "dx_cps_kama_mobile_heist_potential_leads_10", "dx_cps_kama_mobile_heist_one_more_contacts_10"];
  }

  return level.traincolignorelist[var_0];
}

function proxy_trigger() {
  if(!isDefined(level.transient_world_proxy_cull_playspace_proxies) || level.transient_world_proxy_cull_playspace_proxies.size == 0) {
    level.transient_world_proxy_cull_playspace_proxies = ["dx_cps_lass_mobile_heist_squad_spotted_10", "dx_cps_lass_mobile_heist_squad_spotted_20", "dx_cps_lass_mobile_heist_squad_spotted_30", "dx_cps_lass_mobile_heist_squad_spotted_40", "dx_cps_lass_mobile_heist_squad_spotted_50"];
  }

  var_0 = scripts\engine\utility::random(level.transient_world_proxy_cull_playspace_proxies);
  level.transient_world_proxy_cull_playspace_proxies = scripts\engine\utility::array_remove(level.transient_world_proxy_cull_playspace_proxies, var_0);
  return var_0;
}

function end_p1_spawn_loop(var_0) {
  level waittill("end_p1_spawn_loops");
  level notify("stop_" + var_0 + "_loop");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);
}

function watch_for_spawn_min_required(var_0, var_1, var_2, var_3) {
  if(isDefined(level.active_spawn_module_structs) && level.active_spawn_module_structs.size > 1) {
    return 0;
  }

  var_4 = var_2 - scripts\cp\cp_modular_spawning::get_requested_spawn_count(var_0.moduleid);
  var_4 = clamp(var_4, 0, var_2);

  if(var_4 <= 0) {
    return 0;
  }

  var_5 = int(min(clamp(var_1, 0, var_4), var_1));
  return var_5;
}

function debug_m1_p1_obj_start(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "safehouse_1_playerstart");
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse::ref_12118();
}

function debug_trigger_objective_events(var_0) {
  scripts\engine\utility::flag_set("cp_dwn_twn_ml_p1_create_script");

  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_ml_p1_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_ml_p1_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p1_create_script_completed");
  scripts\engine\utility::flag_wait("objectives_registered");

  switch (var_0.ref) {
    case "vault_assault_rooftop":
      break;
    case "vault_assault_crypto":
      break;
    default:
      break;
  }
}

function short_and_long_delay(var_0, var_1, var_2, var_3) {
  if(istrue(var_0.longer_spawn_delay)) {
    return var_2;
  }

  return var_1;
}

function make_enemies_ignore_you() {
  scripts\cp\utility::allow_player_ignore_me(1);
  self waittill("stop_remote_sequence");
  scripts\cp\utility::allow_player_ignore_me(0);
  self.drone_strike_dir_override = undefined;
}

function init_ml_p1_intel(var_0, var_1) {
  scripts\engine\utility::flag_set("cp_dwn_twn_ml_p1_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p1_create_script_completed");
  scripts\engine\utility::flag_wait("ml_p1_spawn_functions_registered");

  if(getdvarint("scr_use_pre_wave_spawning", 1)) {
    if(scripts\engine\utility::flag_exist("cover_spawners_initialized")) {
      scripts\engine\utility::flag_wait("cover_spawners_initialized");
    }

    var_2 = scripts\cp\cp_modular_spawning::run_spawn_module("pre_wave_spawning_dwn_twn");
  }

  var_3 = var_0.objectiveindex;
  objective_state(var_3, "empty");
  scripts\cp\utility::objective_update("ml_p1_intel", undefined, undefined, undefined, undefined, 0);
  level.max_agents_override = 30;
  level.initlethalmaxoffsetmap = "ml_p1_intel";
  scripts\cp\utility::skydivestreamhintdvars("ml_p1");
  level.initlethalmaxoffsetmap = "vault_assault";
  level.initlocationcircle = "vault_assault";

  if(!isDefined(level.player_heli)) {
    scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_ml_p2::ref_13591();
    return;
  }
}

function start_ml_p1_intel(var_0, var_1) {
  if(!isDefined(level.intel_level)) {
    level.intel_level = 0;
  }

  var_2 = getdvarint("scr_num_p1_intel");

  if(var_2 == 0) {
    var_2 = 4;
  }

  if(!getdvarint("scr_use_pre_wave_spawning", 1)) {
    var_3 = scripts\cp\cp_modular_spawning::run_spawn_module("wave_spawning");
  }

  thread ref_123FD();
  thread play_vo_on_intel_drop();
  scripts\cp\utility::ref_123FE("mus_cp_money_start");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_mobile_heist_brief_10");

  if(getDvar("cp_dwn_twn_2_start_obj", "") != "ml_p1_intel") {
    level notify("allow_safehouse_door");
    level waittill("safehouse_door_open");
  }

  ref_11F7F(var_0, var_2);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("p1_intel_bomber");
  wait 5;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_mobile_heist_squad_spotted_10");
  wait 3;
  level.ref_139B5 = 0;
  scripts\engine\utility::flag_set("reinforce_1_ready");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_mobile_heist_jackpot_10");
  wait 0.5;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_mobile_heist_jackpot_20");
  wait 0.1;
}

function end_ml_p1_intel(var_0, var_1) {
  setDvar("scr_cover_node_spawning", 0);
  setDvar("scr_only_passive_spawning", 0);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("ambient_p1_intel");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("cover_node_spawning");
  level notify("end_p1_spawn_loops");
  level.no_intel_drops = 1;
  level.should_drop_intel_func = undefined;
  level.max_agents_override = undefined;
  level.vehicle.spawn_callback_thread = undefined;
  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p2_get_heli");
}

function ref_123CB(var_0, var_1) {
  var_2 = var_1;

  if(!isDefined(var_1)) {
    var_2 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
  }

  var_3 = level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, var_0);

  if(isfloat(var_3)) {
    wait var_3;
    return;
  }
}

function play_vo_on_intel_drop() {
  level endon("end_p1_spawn_loops");
  level.train_delay_handler = &ref_11C59;
  level waittill("ml_p1_intel_dropped");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_mobile_heist_first_phone_dropped_10");
}

function create_spawn_structs_in_radius(var_0) {
  if(isDefined(level.ml_p1_obj_spawners)) {
    return level.ml_p1_obj_spawners;
  }

  var_1 = level.ml_p1_obj_loc;
  var_2 = [];
  var_3 = 6;
  var_4 = 100;
  var_5 = randomint(2);
  var_6 = [];
  var_7 = ["smoking", "cell_phone"];

  for(var_8 = 0; var_8 < var_5; var_8++) {
    var_6 = randomint(var_3);
  }

  if(isDefined(var_1.target)) {
    var_2 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

    foreach(var_10 in var_2) {
      var_10.script_origin_other = var_1.origin;
      var_10.script_demeanor = "casual_gun";
    }
  }

  if(var_2.size < 6) {
    for(var_8 = -1; var_8 < 2; var_8++) {
      for(var_12 = -1; var_12 < 2; var_12++) {
        var_13 = (var_8 * var_4, var_12 * var_4, 0);
        var_10 = spawnStruct();
        var_14 = getclosestpointonnavmesh(var_1.origin + var_13);
        var_15 = (var_14[0], var_14[1], var_1.origin[2]);
        var_16 = scripts\engine\utility::drop_to_ground(var_15 + var_13, 100, -1000);

        if(abs(var_15[2] - var_16[2]) > 100) {
          continue;
        }

        var_10.origin = var_14;
        var_10.angles = (0, 0, 0);
        var_10.script_forcespawn = 1;
        var_10.script_origin_other = var_15;

        if(isDefined(var_1.radius)) {
          var_10.script_radius = var_1.radius;
        } else {
          var_10.script_radius = 512;
        }

        var_10.script_demeanor = "casual_gun";

        if(isDefined(var_6[var_2.size])) {
          var_10.script_animation_type = scripts\engine\utility::random(var_7);
        }

        var_2 = var_10;
      }
    }
  }

  level.ml_p1_obj_spawners = var_2;
  return level.ml_p1_obj_spawners;
}

function test_spawn_locations() {
  var_0 = scripts\engine\utility::getStructArray("ambient_intel_radius", "targetname");

  foreach(var_2 in var_0) {
    level.ml_p1_obj_loc = var_2;
    create_spawn_structs_in_radius();
    wait 0.1;
  }
}

function get_p1_intel_group_spawner(var_0) {
  if(!isDefined(level.trial_combo_died)) {
    level.trial_combo_died = 1;
    thread ref_11B02(level);
  }

  return create_spawn_structs_in_radius(var_0);
}

function p1_intel_after_spawn_func(var_0) {
  self.never_kill_off = 1;
  self.ref_11E50 = 1;
  self.a.disablelongdeath = 1;
  thread little_bird_mg_cp_onentervehicle();
  var_1 = scripts\engine\utility::getStructArray("ambient_intel_radius", "targetname");
  var_2 = scripts\engine\utility::getclosest(self.origin, var_1, 1000);

  if(isDefined(var_2)) {
    if(!issubstr(var_0.group_name, "ambient")) {
      self.script_origin_other = var_2.origin;
    }

    self.traincar_wait_until_shown = var_2.target;
    self.goal_radius = var_2.radius;
  }

  if(isDefined(self.spawnpoint.script_animation_type)) {
    if(self.spawnpoint.script_animation_type == "cell_phone") {
      level.train_start_from_struct[self.spawnpoint.targetname] = self;
      thread mine_launch_vfx();
      return;
    }

    return;
  }
}

function mine_launch_vfx() {
  self endon("dropping_intel");
  level endon("end_p1_spawn_loops");
  var_0 = self.traincar_wait_until_shown;
  self waittill("death");
  var_1 = self.origin;
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin");
  var_2.traincar_wait_until_shown = var_0;
  var_2.angles = (0, 0, 0);
  var_2 thread scripts\cp\intel\cp_intel::drop_intel_piece();
  var_2 scripts\engine\utility::delaycall(0.25, &delete);
}

function little_bird_mg_cp_onentervehicle() {
  scripts\engine\utility::waittill_any_ents_return(level, "weapons_free", self, "enter_combat");
  waitframe();
  self.a.disablelongdeath = 1;
}

function ref_11B02(var_0) {
  thread ref_12326(level);
  level waittill("spawn_module_" + var_0.moduleid + "_completed");
  level.ref_12325 = 1;
  var_1 = [];

  foreach(var_3 in var_0.ai_spawned) {
    if(isalive(var_3)) {
      var_1 = var_3;
    }
  }

  var_5 = scripts\engine\utility::random(var_1);
  var_5.force_intel_drop = 1;
  var_5.force_drop = "intel";
  level notify("phone_group_spawned");
}

function ref_12326(var_0) {
  level endon("ml_p1_intel_found");
  level endon("ml_p1_intel_timed_out");
  level endon("ml_p1_intel_prox_remove");
  level endon("phone_group_spawned");
  wait var_0;
  level.ref_12325 = 1;
}

function mark_group_as_killable(var_0) {
  var_1 = level.spawn_module_structs_memory[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      foreach(var_5 in var_3.ai_spawned) {
        var_5.never_kill_off = undefined;
      }
    }

    return;
  }
}

function remove_force_drop_on_group(var_0) {
  var_1 = level.spawn_module_structs_memory[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      foreach(var_5 in var_3.ai_spawned) {
        var_5.force_drop = undefined;
      }
    }

    return;
  }
}

function get_new_intel_dropper() {
  self.force_intel_drop = 1;
  self waittill("death");
  level.intel_dropper = undefined;
}

function should_drop_intel(var_0) {
  if(!istrue(level.ml_p1_intel_drop)) {
    return false;
  }

  if(!istrue(level.ref_12325)) {
    return false;
  }

  if(isDefined(level.intel_drops) && level.intel_drops.size > 0) {
    return false;
  }

  var_1 = 0;

  foreach(var_3 in level.spawned_enemies) {
    if(isalive(var_3)) {
      if(isDefined(var_3.force_drop) && var_3.force_drop == "intel") {
        var_1 = 1;
      }
    }
  }

  if(!var_1) {
    if(!self isonground()) {
      return false;
    }

    if(isDefined(self.ridingvehicle)) {
      return false;
    }

    if(gettime() - level.waittill_any_timeout_no_endon_death_5 > 5000) {
      level.waittill_any_timeout_no_endon_death_5 = gettime();
      return true;
    }
  }

  if(istrue(self.force_intel_drop)) {
    level.waittill_any_timeout_no_endon_death_5 = gettime();
    return true;
  }

  return false;
}

function start_mortars() {
  level.get_mortar_impact_pos = &get_mortar_impact_spot;
  mortar_launch_think();
}

function get_mortar_impact_spot(var_0) {
  if(!isDefined(var_0.targets)) {
    return undefined;
  }

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0);
  var_3 = scripts\engine\trace::ray_trace(var_2 + (0, 0, 500), var_2);
  return var_3["position"];
}

function mortar_launch_think() {
  level.ref_13C0B = getEnt("tower_ground_mortar", "targetname");
  level.ref_13C0B hidepart("j_mortar_shell", "misc_wm_mortar");
  level.ref_13C0C = getEnt("tower_ground_mortar_2", "targetname");
  level.ref_13C0C hidepart("j_mortar_shell", "misc_wm_mortar");
  level waittill("weapons_free");
  thread mortar_think();
  thread mortar_think();
}

function mortar_think() {
  level endon("end_p1_spawn_loops");
  self.targets = undefined;

  for(;;) {
    var_0 = race_countdown_update();

    if(var_0.size) {
      self.targets = var_0;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_mortar(self, 1, 500);
      self.targets = undefined;
      wait randomintrange(10, 20);
      continue;
    }

    wait 1;
  }
}

function race_countdown_update() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStruct(self.target, "targetname");
  self.ref_12A0A = var_1;
  var_2 = self.ref_12A0A.radius;
  var_3 = var_2 * var_2;

  foreach(var_5 in level.players) {
    if(var_5 isparachuting()) {
      continue;
    }

    if(!var_5 isonground()) {
      continue;
    }

    if(distancesquared(var_5.origin, self.ref_12A0A.origin) < var_3) {
      var_0 = var_5;
    }
  }

  return var_0;
}

function ref_123FD() {
  level endon("game_ended");
  level endon("stop_rein_music");

  for(;;) {
    if(istrue(level.wave_cooldown_active)) {
      if(scripts\engine\utility::flag("reinforce_1_ready")) {
        scripts\engine\utility::flag_clear("reinforce_1_ready");
        scripts\cp\utility::ref_123FE("mus_cp_money_reinforce_1");
      }

      if(scripts\engine\utility::flag("reinforce_2_ready")) {
        scripts\engine\utility::flag_clear("reinforce_2_ready");
        scripts\cp\utility::ref_123FE("mus_cp_money_reinforce_2");
      }

      if(scripts\engine\utility::flag("reinforce_3_ready")) {
        scripts\engine\utility::flag_clear("reinforce_3_ready");
        scripts\cp\utility::ref_123FE("mus_cp_money_reinforce_3");
      }
    }

    waitframe();
  }
}