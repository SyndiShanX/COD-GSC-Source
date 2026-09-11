/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p3.gsc
**********************************************************************/

function main() {
  level.mlp3_obj_func = &register_ml_p3_objectives;
  scripts\engine\utility::flag_init("ml_p3_hack_done");
  scripts\engine\utility::flag_init("ml_p3_router_picked_up");
  scripts\engine\utility::flag_init("ml_p3_crypto_files_found");
  scripts\engine\utility::flag_init("ml_p3_spawn_functions_registered");
  scripts\engine\utility::flag_init("ml_p3_vo_finished");
  scripts\engine\utility::flag_init("ml_p3_hack_started");
  scripts\engine\utility::flag_init("hack_init");
  scripts\engine\utility::flag_init("reinforce_vo_done");
  scripts\engine\utility::flag_init("hacking_intro_vo_done");
  scripts\engine\utility::flag_init("ml_p3_hack_visual");
}

function register_ml_p3_objectives() {
  if(!istrue(level.ml_p3_objectives_registered)) {
    level.ml_p3_objectives_registered = 1;
  } else {
    return;
  }

  scripts\cp\cp_objectives::registerobjective("ml_p3_intel", &init_ml_p3_intel, &start_ml_p3_intel, &end_ml_p3_intel, &debugbeatobjective, &debug_m1_p3_obj_start);
  scripts\cp\cp_objectives::registerobjective("ml_p3_intel_2", &init_ml_p3_intel_2, &start_ml_p3_intel_2, &end_ml_p3_intel_2, &debugbeatobjective, &debug_m1_p3_obj_start);
  scripts\cp\cp_objectives::registerobjective("ml_p3_intel_3", &init_ml_p3_intel_3, &start_ml_p3_intel_3, &end_ml_p3_intel_3, &debugbeatobjective, &debug_m1_p3_obj_start);
  scripts\cp\cp_objectives::registerobjective("ml_p3_exfil", undefined, &ref_137d4, &movingplatforment, &debugbeatobjective, &debug_m1_p3_obj_start);
  scripts\cp\cp_pickup_hostage::registerhvtscriptmodels();
  thread init_cs_ents();
  thread register_spawn_functions();
}

function debugbeatobjective(var_0) {}

function init_cs_ents() {
  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_ml_p3_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_ml_p3_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p3_create_script_completed");
  register_hack_spot_interaction();
}

function register_spawn_functions() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_wait("interactions_initialized");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_ml_p3_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_ml_p3_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p3_create_script_completed");
  scripts\cp\cp_modular_spawning::registerambientgroup("no_spawns", 0, 0, 0, 0.05, 0, undefined, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("ml_p3_init", 6, 6, 6, 0.1, undefined, "ml_p3_init", &scripts\cp\cp_modular_spawning::disable_kill_off, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ml_p3_init", &spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ml_p3_init", &break_cover_after_breached);
  scripts\cp\cp_modular_spawning::registerambientgroup("ml_p3_cover_init", 6, 6, 6, 0.1, undefined, "ml_p3_cover_init", &scripts\cp\cp_modular_spawning::disable_kill_off, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ml_p3_cover_init", &spawn_in_cover);
  scripts\cp\cp_modular_spawning::registerambientgroup("ml_p3_init_transition", 0, 9, 9, 0.1, undefined, "ml_p3_init_transition", &scripts\cp\cp_modular_spawning::disable_kill_off, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("ml_p3_rein", 3, 15, 15, 0.1, undefined, "ml_p3_rein", &scripts\cp\cp_modular_spawning::disable_kill_off, &questcomplete);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ml_p3_rein", undefined, 5000, 7500, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("ml_p3_rein_rpg", 2, 2, 4, 0.1, undefined, "ml_p3_rein_rpg", &scripts\cp\cp_modular_spawning::disable_kill_off, &questcomplete);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ml_p3_rein_rpg", undefined, 5000, 7500, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("ml_p3_heli", 0, 6, 120, [ &spawn_wave, 0.1, 45], undefined, "ml_p3_heli", &scripts\cp\cp_modular_spawning::disable_kill_off, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("ml_p3_bombers", 4, 8, 8, 0.1, undefined, "ml_p3_bombers");
  scripts\cp\cp_modular_spawning::registerambientgroup("ml_p3_juggs", 2, 2, 2, 0.1, undefined, "ml_p3_juggs");
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_ml_p3a", 0, 5, 5, 0.5, undefined, "techo_phys_ml_p3a");
  scripts\cp\cp_modular_spawning::registerambientgroup("techo_phys_ml_p3b", 0, 5, 5, 0.5, undefined, "techo_phys_ml_p3b");

  if(!scripts\engine\utility::flag_exist("init_spawn_volumes_done")) {
    scripts\engine\utility::flag_init("init_spawn_volumes_done");
  }

  scripts\engine\utility::flag_set("init_spawn_volumes_done");
  scripts\engine\utility::flag_set("ml_p3_spawn_functions_registered");
}

function questcomplete(var_0) {
  if(scripts\engine\utility::flag("ml_p3_hack_done")) {
    return undefined;
  }

  for(var_1 = getaiarray("axis").size; var_1 > 24 - var_0.max_size + 3; var_1 = getaiarray("axis").size) {
    wait 1;
  }

  return var_0.group_name;
}

function spawn_in_cover(var_0) {
  var_1 = self getnearestnode();

  if(isDefined(var_1)) {
    var_2 = var_1.angles;
    var_3 = var_1.origin;

    if(!issubstr(var_1.type, "Prone")) {
      if(issubstr(var_1.type, "Left")) {
        var_2 += (0, 90, 0);
      } else if(issubstr(var_1.type, "Right") || issubstr(var_1.type, "Cover Crouch") || issubstr(var_1.type, "Conceal") || issubstr(var_1.type, "Cover Stand")) {
        var_2 -= (0, 90, 0);
      }
    }

    self forceteleport(var_3, var_2);
    self usecovernode(var_1, 1);
    self setgoalnode(var_1);
    self.goalradius = 8;
    self.script_radius = 8;
    self.script_origin_other = var_3;
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
    return;
  }
}

function break_cover_after_breached(var_0) {
  level waittill("ml_p3_building_breach");
  self.goalradius = 1024;
  self.fixednode = 0;
}

function notify_building_breach() {
  var_0 = scripts\engine\utility::getStruct("building_center", "targetname");
  var_1 = var_0.radius;
  var_2 = var_1 * var_1;
  var_3 = 0;
  var_4 = 1;

  while(!var_3) {
    foreach(var_6 in level.players) {
      if(istrue(var_4)) {
        if(distance2dsquared(var_6.origin, var_0.origin) < var_2) {
          var_3 = 1;
        }

        continue;
      }

      if(distancesquared(var_6.origin, var_0.origin) < var_2) {
        var_3 = 1;
      }
    }

    wait 0.5;
  }

  level notify("ml_p3_building_breach");
}

function spawn_wave(var_0, var_1, var_2, var_3) {
  return scripts\cp\cp_modular_spawning::wave_reinforce(var_0, var_1, var_2, var_3);
}

function spawn_per_player(var_0, var_1, var_2, var_3) {
  var_4 = max(var_1, var_2 * level.players.size);

  if(isDefined(var_3)) {
    var_4 = min(var_4, var_3);
  } else {
    var_4 = min(var_4, 24);
  }

  return var_4;
}

function debug_m1_p3_obj_start(var_0) {
  debug_trigger_objective_events(var_0);
  thread safehouse_debug_func();
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "ml_p3_debug_start");
}

function debug_trigger_objective_events(var_0) {
  scripts\engine\utility::flag_set("cp_dwn_twn_ml_p3_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p3_create_script_completed");
  scripts\engine\utility::flag_wait("objectives_registered");

  switch (var_0.ref) {
    case "ml_p3_intel":
      break;
    case "ml_p3_intel_2":
      break;
    default:
      break;
  }
}

function safehouse_debug_func(var_0) {
  while(!scripts\engine\utility::flag_exist("ml_p3_router_picked_up")) {
    wait 1;
  }

  scripts\engine\utility::flag_wait("ml_p3_router_picked_up");
  wait 7;
  scripts\engine\utility::flag_set("ml_p3_done");
}

function vfx_smoke() {
  level endon("game_ended");
  var_0 = (25571, -12073.5, -180.25);

  while(!scripts\cp\utility::any_player_nearby(var_0, squared(1500))) {
    wait 1;
  }

  scripts\cp\cp_modular_spawning::stop_all_groups();
}

function ref_11c5d() {
  var_0 = getEntArray("mlp1_safehouse_intel", "targetname");

  foreach(var_2 in var_0) {
    var_2 show();
  }

  thread scripts\cp\cp_objectives::run_objective("safehouse_return", "primary");
  thread vfx_smoke();
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/GOTO_SAFEHOUSE", "allies", 5);
}

function init_ml_p3_intel(var_0, var_1) {
  scripts\engine\utility::flag_set("cp_dwn_twn_ml_p3_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p3_create_script_completed");
  scripts\engine\utility::flag_wait("ml_p3_spawn_functions_registered");
  level.initlethalmaxoffsetmap = "ml_p3_intel";
  scripts\cp\cp_create_script_utility::cleanup_cs_file_objects("cp_dwn_twn_ml_p1_create_script");
  scripts\mp\brclientmatchdata::getprophealth("ml_p3");
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("ml_p3");
  level.setovertimeomnvarprogress = 0;
  level.setovertimeomnvarenabled = 2;
  level.ref_12dc0 = 0;
  level.ref_12dbf = 2;
  scripts\cp\utility::objective_update("ml_p3_intel", undefined, undefined, undefined, undefined, 0);
  level.final_hack_locations = scripts\engine\utility::getStructArray("comp_interact", "targetname");

  for(var_2 = 0; var_2 < level.final_hack_locations.size; var_2++) {
    level.final_hack_locations[var_2] = create_final_hack_spot_interaction(level.final_hack_locations[var_2], var_2);
  }

  level.final_hack_location = level.final_hack_locations[0];
  thread stop_intel_spawning_and_start_p3();
  scripts\cp\utility::skydivestreamhintdvars("ml_p3");
  level thread scripts\cp\cp_munitions::ref_12be1(level.final_hack_location.origin, 200);
  thread autorespawnwaittime();
  at_mine_test();
}

function autorespawnwaittime() {
  var_0 = scripts\engine\utility::getStructArray("hack_fake_collision", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEnt("clip32x32x32", "targetname");
    var_4 = spawn("script_model", var_2.origin);
    var_4.angles = var_2.angles;
    var_4 clonebrushmodeltoscriptmodel(var_3);
  }
}

function keep_players_from_using_ascender() {
  foreach(var_1 in level.players) {
    var_1.usingascender = 1;
  }
}

function stop_intel_spawning_and_start_p3() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("mlp2_vip_spawns");
  wait 5;
  level notify("end_p1_spawn_loops");
  scripts\cp\cp_modular_spawning::run_spawn_module("ml_p3_init");
  scripts\cp\cp_modular_spawning::run_spawn_module("ml_p3_cover_init");
  scripts\cp\cp_modular_spawning::run_spawn_module("ml_p3_init_transition");
}

function start_ml_p3_intel(var_0, var_1) {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_ml_p3_multihack_brief_10");
  wait 0.5;
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb("ping_response_affirm");
  var_2 = scripts\engine\utility::getStruct("ml_p3_obj", "targetname");
  var_3 = var_2;
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var_0.objectiveindex, var_3.origin);
  objective_state(var_0.objectiveindex, "current");

  if(isDefined(level.final_hack_location)) {
    level.final_hack = level.final_hack_location;
  }

  thread notify_building_breach();
  thread setup_test_computer(level);

  while(istrue(level.dialogue_playing)) {
    wait 0.25;
  }

  update_objective_marker_when_close(level, var_0, var_2);
  scripts\engine\utility::flag_set("hack_init");

  while(istrue(level.dialogue_playing)) {
    wait 0.25;
  }

  scripts\engine\utility::flag_wait("hacking_intro_vo_done");
}

function end_ml_p3_intel(var_0, var_1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("ml_p3_init");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("ml_p3_cover_init");
  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p3_intel_2");
}

function update_objective_marker_when_close(var_0, var_1) {
  ref_14359(var_1, 1200, 1);
  objective_state(var_0.objectiveindex, "done");

  for(var_2 = 0; var_2 < level.final_hack_locations.size; var_2++) {
    thread ref_13f8c(level);
    thread ref_13083(level);
  }

  scripts\engine\utility::flag_wait("ml_p3_hack_visual");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_ml_p3_multihack_connect_decrypt_10");
  wait 0.5;
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb("ping_response_affirm");
}

function ref_13083(var_0) {
  play_vo_when_near("obj_visual", var_0, 300, undefined, 1);
  scripts\engine\utility::flag_set("ml_p3_hack_visual");
}

function ref_13f8c(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("hack_marker_" + var_0);
  var_2 = level.final_hack_locations[var_0];
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_state(var_1, "current");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_position(var_1, var_2.origin);
  level waittill("delete_hack_marker_" + var_0);
  objective_state(var_1, "done");
  scripts\cp\cp_objectives::freeworldid("hack_marker_" + var_0);
}

function play_vo_when_near(var_0, var_1, var_2, var_3, var_4) {
  ref_14359(var_1, var_2, var_3);

  if(istrue(var_4)) {
    scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb(var_0);
    return;
  }

  scripts\cp\cp_dialogue::play_vo_to_all(var_0);
}

function ref_14359(var_0, var_1, var_2) {
  var_3 = var_1 * var_1;
  var_4 = 0;

  while(!var_4) {
    foreach(var_6 in level.players) {
      if(istrue(var_2)) {
        if(distance2dsquared(var_6.origin, var_0.origin) < var_3) {
          var_4 = 1;
        }

        continue;
      }

      if(distancesquared(var_6.origin, var_0.origin) < var_3) {
        var_4 = 1;
      }
    }

    wait 0.5;
  }
}

function init_ml_p3_intel_2(var_0, var_1) {}

function start_ml_p3_intel_2(var_0, var_1) {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_enemy_reinforcements_10");
  wait 0.5;
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb("ping_response_copy");
  scripts\engine\utility::flag_set("reinforce_vo_done");
  thread get_enemies_to_advance_on_players();
  thread scripts\cp\cp_modular_spawning::run_spawn_module("ml_p3_rein");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("ml_p3_rein_rpg");
  scripts\cp\cp_modular_spawning::set_wave_ref_override("ml_p3");
  thread get_rid_of_guys_blocking_path();
  scripts\cp\utility::ref_123fe("mus_cp_money_files_copied_1");
  thread hacking_sfx(level);
  thread setobjectivetypesomvarbit();
  thread ref_11cf1();
  level waittill("cpu_hacking_done");
  level notify("mlp3_hack_pause");
  is_ai_in_stealth();
  scripts\engine\utility::flag_set("ml_p3_hack_done");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("ml_p3_rein");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("ml_p3_heli");
  level notify("spawn_module_spawn_download_defenders_completed");
}

function end_ml_p3_intel_2(var_0, var_1) {
  if(isDefined(level.final_hack.model.boxiconid)) {
    thread scripts\cp\utility::ent_deleteheadicon(level.final_hack.model, level.final_hack.model.boxiconid);
  }

  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p3_intel_3");
}

function ref_11cf1() {
  level endon("game_ended");
  level endon("cpu_hacking_done");
  var_0 = 0.33;

  while(!isDefined(level.hack_progress)) {
    wait 0.1;
  }

  while(istrue(level.dialogue_playing)) {
    wait 0.1;
  }

  while(level.hack_progress < 0.1) {
    wait 0.1;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("ml_p3_bombers");

  while(level.hack_progress < 0.3) {
    wait 0.1;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("techo_phys_ml_p3a");

  while(level.hack_progress < 0.3) {
    wait 0.1;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("techo_phys_ml_p3b");

  while(level.hack_progress < 0.5) {
    wait 0.1;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("ml_p3_juggs");

  while(level.hack_progress < 0.7) {
    wait 0.1;
  }

  thread ref_13504();
}

function hacking_sfx(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  wait 0.05;
  var_1 playLoopSound("cp_hacking_struct_lp");
  level scripts\engine\utility::ref_143a5("cpu_hacking_done", "hacking_paused");
  var_1 stoploopsound("cp_hacking_struct_lp");
}

function setobjectivetypesomvarbit() {
  level endon("game_ended");

  while(!isDefined(level.hack_progress)) {
    wait 0.1;
  }

  while(istrue(level.dialogue_playing)) {
    wait 0.1;
  }

  while(level.hack_progress < 0.4) {
    wait 0.1;
  }

  is_ambient(1);

  while(level.hack_progress < 0.6) {
    wait 0.1;
  }

  is_ambient(2);

  while(level.hack_progress < 0.8) {
    wait 0.1;
  }

  is_ambient(3);
}

function gettimetogulagclosed(var_0) {
  var_1 = scripts\engine\utility::random(var_0);
  scripts\cp\cp_dialogue::play_vo_to_all(var_1);
}

function is_any_player_in_region() {
  wait 1;
  var_0 = ["dx_cps_cyph_cypher_hack_intro_10", "dx_cps_cyph_cypher_hack_intro_20", "dx_cps_cyph_cypher_hack_intro_30"];
  gettimetogulagclosed(var_0);
  wait 1;
  var_0 = ["dx_cps_cyph_cypher_connection_good_10", "dx_cps_cyph_cypher_connection_good_20", "dx_cps_cyph_cypher_connection_good_30"];
  gettimetogulagclosed(var_0);
  scripts\engine\utility::flag_set("hacking_intro_vo_done");
}

function is_ambient(var_0) {
  while(istrue(level.dialogue_playing)) {
    wait 0.1;
  }

  switch (var_0) {
    case 1:
      var_1 = "dx_cps_cyph_cypher_connection_stable_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      break;
    case 2:
      var_1 = "dx_cps_cyph_cypher_connection_stable_20";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      wait 0.5;
      var_1 = "dx_cps_kama_cypher_connection_stable_30";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      break;
    case 3:
      var_1 = "dx_cps_cyph_cypher_connection_stable_40";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      wait 0.5;
      var_1 = "dx_cps_lass_cypher_connection_stable_50";
      scripts\cp\cp_dialogue::play_vo_to_all(var_1);
      break;
    default:
      break;
  }
}

function is_ai_in_stealth() {
  scripts\cp\utility::ref_123fe("");
  var_0 = ["dx_cps_cyph_cypher_connection_complete_shut_out_10", "dx_cps_cyph_cypher_connection_complete_shut_out_20", "dx_cps_cyph_cypher_connection_complete_shut_out_30"];
  gettimetogulagclosed(var_0);
  wait 5;
  var_0 = ["dx_cps_cyph_cypher_connection_complete_intel_10", "dx_cps_cyph_cypher_connection_complete_intel_20", "dx_cps_cyph_cypher_connection_complete_intel_30"];
  gettimetogulagclosed(var_0);
  wait 5;
  var_1 = "dx_cps_cyph_ml_p3_multihack_transfer_complete_10";
  scripts\cp\cp_dialogue::play_vo_to_all(var_1);
  wait 1;
  var_1 = "dx_cps_lass_ml_p3_multihack_transfer_complete_20";
  scripts\cp\cp_dialogue::play_vo_to_all(var_1);
}

function is_ai_facing_point(var_0) {
  switch (var_0) {
    case 0:
      var_1 = ["dx_cps_cyph_cypher_connection_lost_10", "dx_cps_cyph_cypher_connection_lost_20", "dx_cps_cyph_cypher_connection_lost_30"];
      gettimetogulagclosed(var_1);
    case 1:
      var_2 = "dx_cps_cyph_cypher_connection_1p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var_2);
      break;
    case 2:
      var_2 = "dx_cps_cyph_cypher_connection_2p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var_2);
      break;
    case 3:
      var_2 = "dx_cps_cyph_cypher_connection_3p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var_2);
      break;
    case 4:
      var_2 = "dx_cps_cyph_cypher_connection_4p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var_2);
      break;
    default:
      break;
  }
}

function init_ml_p3_intel_3(var_0, var_1) {}

function start_ml_p3_intel_3(var_0, var_1) {
  var_2 = level.final_hack_location.model;
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var_0.objectiveindex, var_2.origin);
  scripts\engine\utility::flag_wait("ml_p3_router_picked_up");
  level notify("update_hack_objective");
  var_3 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_spawning");

  foreach(var_5 in var_3) {
    var_5 scripts\cp\cp_modular_spawning::clear_wave_ref_override();
  }

  scripts\engine\utility::flag_set("ml_p3_vo_finished");
  scripts\engine\utility::flag_set("ml_p3_done");
}

function end_ml_p3_intel_3(var_0, var_1) {
  level.max_agents_override = undefined;
  scripts\cp\cp_objectives::overridenextstep(var_0, "ml_p3_exfil");
}

function lootleadermarksize() {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_ml_p3_multihack_multihack_success_10");
  wait 0.5;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_ml_p3_multihack_go_to_safehouse_10");
  wait 0.5;
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb("ping_response_affirm");
}

function computer_test() {
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = tablelookupgetnumrows("cp/computer_screen_search_results.csv");
  level.cpu_manifest1_idx = randomintrange(1, var_0 + 1);
  setomnvar("cpu_manifest1_idx", level.cpu_manifest1_idx);
  level thread scripts\cp\cp_hacking::hacking_init();
  thread setup_test_computer("ml_p3_comp");
}

function setup_test_computer(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 delete();
}

function fake_world_structs_defend_download() {
  level.fake_structs = [];
  var_0 = [(19487, -9593, 552)];

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    var_3.origin = var_2;
    var_3.angles = (0, 0, 0);
    var_3.script_noteworthy = "hack_defend_struct";
    level.fake_structs[level.fake_structs.size] = var_3;
  }
}

function pause_hacking(var_0) {
  level notify("mlp3_hack_pause");
  level endon("mlp3_hack_pause");
  level.hacking_paused = 1;
  level notify("hacking_paused");
  wait var_0;
  level.hacking_paused = 0;
  thread hacking_sfx(level);
}

function remove_from_list_on_death() {
  self waittill("death");
  remove_from_hack_attackers_list(self);
}

function remove_from_hack_attackers_list(var_0) {
  level.hack_attackers = scripts\engine\utility::array_remove(level.hack_attackers, var_0);
}

function listen_to_hack_damage() {
  var_0 = 0;
  self.hack_damage = 0;
  var_1 = 100;

  while(!var_0) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(!isDefined(var_3)) {
      continue;
    }

    if(!isDefined(var_3.team)) {
      continue;
    }

    if(var_3.team != "axis") {
      continue;
    }

    self.hack_damage += var_2;

    if(self.hack_damage > var_1) {
      var_0 = 1;
    }
  }
}

function setup_headicon_on_jammer(var_0, var_1) {
  self.boxiconid = thread scripts\cp\utility::ent_createheadicon(self, var_1, "allies", var_0);
  setheadiconzoffset(self.boxiconid, 1);
  setheadiconsnaptoedges(self.boxiconid, 0);
}

function get_enemies_to_advance_on_players() {
  level endon("ml_p3_hack_done");
  level endon("game_ended");
  var_0 = 1200;
  var_1 = var_0 * var_0;
  var_2 = scripts\engine\utility::getStruct("ml_p3_obj", "targetname");

  for(;;) {
    var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    foreach(var_5 in var_3) {
      if(var_5.origin[2] > 0) {
        continue;
      }

      if(distancesquared(var_5.origin, var_2.origin) > var_1) {
        continue;
      }

      var_5.combatmode = "no_cover";
      var_5.goalradius = 32;
    }

    wait 30;
  }
}

function create_final_hack_spot_interaction(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.targetname = "interaction";
  var_2.script_noteworthy = "final_hack_spot";
  var_2.requires_power = 0;
  var_2.spend_type = "null";
  var_2.setnewabilitycount = var_1;
  var_3 = scripts\engine\utility::getStructArray("router_spot", "targetname");
  var_4 = scripts\engine\utility::getclosest(var_2.origin, var_3, 1000);
  var_2.model = spawn("script_model", var_4.origin);
  var_2.model setModel("tag_origin");

  if(!isDefined(var_4.angles)) {
    var_5 = (0, 0, 0);
  } else {
    var_5 = var_5.angles;
  }

  var_3.model.angles = var_5;
  var_3.cost = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
  return var_3;
}

function register_hack_spot_interaction() {
  scripts\cp\cp_interaction::register_interaction("final_hack_spot", "null", undefined, &final_hack_spot_hint, &final_hack_spot_activate, 0, 0, undefined);
}

function final_hack_spot_hint(var_0, var_1) {
  if(!scripts\engine\utility::flag("hack_init")) {
    return "";
  }

  if(scripts\engine\utility::flag("ml_p3_hack_visual")) {
    if(!istrue(var_0.setnexthistorydestination)) {
      return &"CP_DWN_TWN_OBJECTIVES/ML_P3_COMP";
    }
  }

  if(scripts\engine\utility::flag("ml_p3_hack_done") && !scripts\engine\utility::flag("ml_p3_router_picked_up")) {
    return &"CP_DWN_TWN_OBJECTIVES/ML_P3_ROUTER";
  }

  return "";
}

function final_hack_spot_activate(var_0, var_1) {
  var_1 endon("disconnect");

  if(!scripts\engine\utility::flag("hack_init")) {
    return;
  }

  if(scripts\engine\utility::flag("ml_p3_hack_visual")) {
    if(!istrue(var_0.setnexthistorydestination)) {
      var_0.setnexthistorydestination = 1;
      level.setovertimeomnvarprogress++;
      thread ref_135c2(level);
      scripts\cp\utility::objective_update("ml_p3_intel", undefined, undefined, undefined, undefined, level.setovertimeomnvarprogress);
      level notify("delete_hack_marker_" + var_0.setnewabilitycount);

      if(level.setovertimeomnvarprogress >= level.setovertimeomnvarenabled) {
        scripts\engine\utility::flag_set("ml_p3_hack_started");
        thread lootleadermarkweaksize();
      }
    }
  }

  if(scripts\engine\utility::flag("ml_p3_hack_done") && !scripts\engine\utility::flag("ml_p3_router_picked_up")) {
    if(!istrue(var_0.ref_12dbc)) {
      var_0.ref_12dbc = 1;
      level.ref_12dc0++;
      scripts\cp\utility::objective_update("ml_p3_intel_3", undefined, undefined, undefined, undefined, level.ref_12dc0);
      var_0.model delete();

      if(level.ref_12dc0 >= level.ref_12dbf) {
        scripts\engine\utility::flag_set("ml_p3_router_picked_up");
        scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "obj_device_pickup");
        return;
      }

      return;
    }

    return;
  }
}

function lootleadermarkweaksize() {
  ref_123f7();
  ref_137bc();
}

function ref_135c2(var_0) {
  var_0.model setModel("equipment_router_flat");
  setup_headicon_on_jammer(var_0.model, "icon_waypoint_cyber_bombsite", 20);
}

function ref_123f7() {
  is_any_player_in_region();
}

function init_hacking_table() {
  scripts\cp\cp_hacking::parsehackingtable("cp/cp_quarry_hacking_objective.csv");
}

function ref_137bc() {
  level.hackingfunc = &init_hacking_table;
  level.hack_duration = 300;
  thread ref_11ce1();
  level thread scripts\cp\cp_hacking::hacking_init();
  level thread scripts\cp\cp_hacking::hacking_objective_time();
}

function ref_11ce1() {
  level endon("game_ended");
  level endon("ml_p3_hack_done");
  level endon("cpu_hacking_done");
  var_0 = 250;
  var_1 = var_0 * var_0;
  var_2 = level.final_hack_locations;
  var_3 = gettime() + 15000;

  for(;;) {
    var_4 = 0;

    foreach(var_6 in var_2) {
      var_6.ref_11f20 = 0;

      foreach(var_8 in level.players) {
        if(distancesquared(var_8.origin, var_6.origin) < var_1) {
          var_4++;
          var_6.ref_11f20++;
        }
      }
    }

    var_11 = 0;

    foreach(var_6 in var_2) {
      if(var_6.ref_11f20 == 0) {
        var_11 = 1;
        break;
      }
    }

    setomnvar("cpu_hacking_signal", var_4);
    level.hacking_paused = var_11;
    level.hack_multiplier = 1 + var_4 * 0.25;

    if(gettime() > var_3) {
      var_3 += 15000;
      var_15 = int(max(0, var_4 - 1));

      if(var_4 == 0) {
        thread is_ai_facing_point(level);
      }
    }

    waitframe();
  }
}

function claymore_test() {
  var_0 = scripts\engine\utility::getStructArray("claymore_test", "targetname");

  foreach(var_2 in var_0) {
    spawn_claymore(var_2);
    wait 0.1;
  }
}

function spawn_claymore() {
  var_0 = magicgrenademanual("claymore_mp", self.origin + (0, 0, 100), (0, 0, 10));
  var_0.owner = var_0;
  var_0.team = "axis";
  var_0 thread scripts\cp\cp_claymore::claymore_plant();
}

function at_mine_test() {
  var_0 = scripts\engine\utility::getStructArray("at_mine_test", "targetname");

  foreach(var_2 in var_0) {
    spawn_at_mine(var_2);
    wait 0.1;
  }
}

function spawn_at_mine() {
  var_0 = magicgrenademanual("at_mine_mp", self.origin + (0, 0, 100), (0, 0, 10));
  var_0.owner = var_0;
  var_0.team = "axis";
  thread scripts\cp\equipment\cp_at_mine::at_mine_plant(var_0);
}

function get_rid_of_guys_blocking_path() {
  level endon("ml_p3_router_picked_up");

  for(;;) {
    foreach(var_1 in level.spawned_enemies) {
      if(!isDefined(var_1.listening_for_blocked_path)) {
        thread listen_for_blocked_path();
      }
    }

    wait 0.5;
  }
}

function listen_for_blocked_path() {
  self endon("death");
  self.listening_for_blocked_path = 1;
  var_0 = self getentitynumber();

  for(;;) {
    self waittill("node_bad", var_1, var_2, var_3);

    if(var_1 != "path_blocked") {
      continue;
    }

    if(isDefined(var_3) && var_3 < 2000) {
      continue;
    }

    var_4 = var_2 getentitynumber();

    if(isalive(var_2)) {
      if(isDefined(var_2.enemy)) {
        thread send_guy_to_org(var_2);
        continue;
      }

      foreach(var_6 in level.players) {
        if(isDefined(var_6) && isalive(var_6)) {
          thread send_guy_to_org(var_2);
        }
      }
    }
  }
}

function send_guy_to_org(var_0) {
  self endon("death");
  self setgoalpos(var_0);
  self.goalradius = 16;
  thread stop_ignoring_after_timer(5);
  var_1 = scripts\engine\utility::ref_143ad("goal_reached", "goal");
  self.goalradius = 512;
}

function stop_ignoring_after_timer(var_0) {
  self.ignoreall = 1;
  wait var_0;
  self.ignoreall = 0;
}

function ref_13504() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStruct("ml_p3_heli_spawn", "targetname");
  var_1 = scripts\engine\utility::getStruct("ml_p3_heli_stop1", "targetname");
  var_2 = scripts\engine\utility::getStruct("ml_p3_heli_left", "targetname");
  var_3 = scripts\engine\utility::getStruct("ml_p3_heli_center", "targetname");
  var_4 = scripts\engine\utility::getStruct("ml_p3_heli_right", "targetname");
  var_5 = spawn("script_model", level.final_hack_location.origin);
  var_5 setModel("tag_origin");
  var_6 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_6.death_fx_on_self = 1;
  var_6.circle_radius = 2500;
  var_6 scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
  var_6.isheli = 1;
  var_6.health = 25000;
  var_6.maxhealth = 25000;
  var_6.team = "axis";
  var_6 setvehicleteam("axis");
  var_6 setmaxpitchroll(15, 15);
  var_6.health_remaining = 25000;
  var_6 sethoverparams(25, 15, 10);
  var_6 setlookatent(var_5);
  var_6 vehicle_setspeed(90, 30);
  var_6 setvehgoalpos(var_1.origin, 1);
  var_6 waittill("goal");
  var_6 setvehgoalpos(var_3.origin, 1);
  var_6 waittill("goal");
  var_6.instantbleedoutsquadwipe = "center";
  var_6 vehicle_setspeed(15, 10);
  var_6.ref_11e98 = 1;
  thread skip_navmesh_check(var_6);
  thread skipburndownforvehicle(var_6);
  thread ref_14454(level);

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var_6);
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(var_6);
  level waittill("ml_p3_delete_heli");
}

function skipburndownforvehicle(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 vehicle_setspeed(50, 30);
  var_1 = scripts\engine\utility::getStruct("ml_p3_heli_left", "targetname");
  var_2 = scripts\engine\utility::getStruct("ml_p3_heli_center", "targetname");
  var_3 = scripts\engine\utility::getStruct("ml_p3_heli_right", "targetname");
  var_4 = scripts\engine\utility::getStruct("ml_p3_heli_front", "targetname");
  var_5 = [var_1, var_2, var_3, var_4];

  for(;;) {
    var_5 = [var_1, var_2, var_3, var_4];
    var_6 = var_5;

    switch (var_0.instantbleedoutsquadwipe) {
      case "center":
      default:
        var_6 = scripts\engine\utility::array_remove(var_5, var_2);
        var_7 = scripts\engine\utility::random(var_6);
        break;
      case "left":
        var_6 = scripts\engine\utility::array_remove(var_5, var_1);
        var_7 = scripts\engine\utility::random(var_6);
        break;
      case "right":
        var_6 = scripts\engine\utility::array_remove(var_5, var_3);
        var_7 = scripts\engine\utility::random(var_6);
        break;
      case "front":
        var_6 = scripts\engine\utility::array_remove(var_5, var_4);
        var_7 = scripts\engine\utility::random(var_6);
        break;
    }

    var_0 setvehgoalpos(var_7.origin, 1);
    var_0 waittill("goal");
    var_0.instantbleedoutsquadwipe = var_7.script_noteworthy;
    wait 2;
  }
}

function skip_navmesh_check(var_0) {
  var_0 endon("death");
  level notify("starting_cleanup");
  var_0.minigun setturretteam("axis");
  var_0.minigun setmode("manual");
  var_1 = gettime();
  var_2 = 0;

  for(;;) {
    var_3 = scripts\engine\utility::getStruct("tv_station_level", "targetname");
    var_4 = quarry_wave_spawn_scoring(var_0, var_3.origin);

    if(!isDefined(var_4)) {
      var_0.minigun cleartargetentity();
      wait 0.2;
      continue;
    }

    var_0.minigun settargetentity(var_4);
    var_5 = var_0.minigun scripts\engine\utility::waittill_notify_or_timeout_return("turret_on_target", 3);

    if(var_5 == "timeout") {
      var_0.minigun cleartargetentity();
      continue;
    }

    if(gettime() > var_1) {
      for(var_6 = 0; var_6 < 35; var_6++) {
        var_0.minigun shootturret();
        wait 0.1;
      }

      var_1 = gettime() + 1000;
    }
  }
}

function quarry_wave_spawn_scoring(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 25000000;
  }

  var_2 = level.players;
  var_2 = sortbydistance(var_2, self.origin);

  foreach(var_4 in var_2) {
    if(!isalive(var_4)) {
      continue;
    }

    if(distancesquared(var_4.origin, var_0) < var_1 && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), var_4.origin + (0, 0, 100), var_2)) {
      return var_4;
    }
  }

  return undefined;
}

function ref_14454(var_0) {
  level endon("game_ended");
  var_0 waittill("death");
  playFX(level._effect["helidown_rpghit"], var_0.origin);

  if(isDefined(var_0.minigun)) {
    var_0.minigun makeunusable();
    var_0.minigun maketurretinoperable();
    var_0.minigun delete();
  }

  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, var_0);
  wait 1;

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function ref_137d4(var_0) {
  thread ref_13547();
  thread lootleadermarksize();
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/EXFIL_HEADER", "allies", 5);
  level waittill("heli_trip_took_off");
  wait 4;
}

function movingplatforment(var_0) {
  wait 2;
  thread scripts\cp\cp_objectives::screenent_c("major_objective");
  thread mp_shipment_patch();
  wait 3;

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_2 thread scripts\cp_mp\xmike109::scriptable_callback("justreward_mod");
      } else {
        var_2 thread scripts\cp_mp\xmike109::scriptable_callback("justreward_mod_vet");
      }
    }

    var_2 scripts\cp_mp\xmike109::scriptable_callback("downtown_4");
  }

  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function mp_shipment_patch() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var_1 in level.players) {
    if(!istrue(var_1.try_to_punish_with_jugg)) {
      var_1.invulnerable = 1;
      var_1 allowmovement(0);
    }

    var_4 = scripts\engine\utility::getStruct("mlp3_camera_ending", "targetname");
    var_5 = var_4.origin;
    var_6 = scripts\engine\utility::getStruct(var_4.target, "targetname");
    var_7 = spawn("script_model", var_5);
    var_7 setModel("tag_origin");
    var_7.angles = var_4.angles;
    var_7 moveTo(var_6.origin, 20, 1, 1);
    var_1 playerhide();
    var_1 allowfire(0);
    var_1 disableoffhandweapons();
    var_1 disableusability();
    var_1 allowmovement(0);
    var_1 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var_1, var_7);
    var_1 lerpfovscalefactor(0, 0);
  }
}

function spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "tag_origin", 1);
  self setclientdvar("LQKPQMPRQN", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "50");
    return;
  }
}

function screen_fade_to_black(var_0) {
  if(!isDefined(var_0.kidnap_black_screen)) {
    var_0.kidnap_black_screen = newclienthudelem(var_0);
    var_0.kidnap_black_screen.x = 0;
    var_0.kidnap_black_screen.y = 0;
    var_0.kidnap_black_screen setshader("black", 640, 480);
    var_0.kidnap_black_screen.alignx = "left";
    var_0.kidnap_black_screen.aligny = "top";
    var_0.kidnap_black_screen.sort = 1;
    var_0.kidnap_black_screen.horzalign = "fullscreen";
    var_0.kidnap_black_screen.vertalign = "fullscreen";
    var_0.kidnap_black_screen.foreground = 1;
  }

  var_0.kidnap_black_screen.alpha = 0;
  var_0.kidnap_black_screen fadeovertime(2);
  var_0.kidnap_black_screen.alpha = 1;
}

function ref_13547() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStruct("ml_p3_exfil_heli_spawn", "targetname");
  var_1 = scripts\engine\utility::getStruct("ml_p3_exfil_heli_lz", "targetname");
  var_2 = scripts\engine\utility::getStruct("ml_p2_heli_trip_start", "targetname");
  var_0.vehicletype = "blima_cp";
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var_0, var_1, var_2, 0);
  wait 3;

  if(!isDefined(level.heli_trip_vehicle)) {
    return;
  }

  var_3 = level.heli_trip_vehicle;
  var_4 = scripts\cp\cp_objectives::requestworldid("ml_p3_exfil");
  objective_state(var_4, "current");
  objective_position(var_4, var_1.origin);
  objective_icon(var_4, "icon_waypoint_objective_general");
  objective_setlabel(var_4, &"CP_DWN_TWN_OBJECTIVES/EXFIL_HEADER");
  objective_setshowoncompass(var_4, 1);
  objective_setminimapiconsize(var_4, "icon_regular");
  var_3 waittill("started_boarding");
  scripts\cp\cp_objectives::ref_11f80(var_4);
  var_3 waittill("heli_taking_off");
  objective_delete(var_4);
  scripts\cp\cp_objectives::freeworldid("ml_p3_exfil");
}