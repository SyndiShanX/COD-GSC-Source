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

function debugbeatobjective(var0) {}

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

function questcomplete(var0) {
  if(scripts\engine\utility::flag("ml_p3_hack_done")) {
    return undefined;
  }

  for(var1 = getaiarray("axis").size; var1 > 24 - var0.max_size + 3; var1 = getaiarray("axis").size) {
    wait 1;
  }

  return var0.group_name;
}

function spawn_in_cover(var0) {
  var1 = self getnearestnode();

  if(isDefined(var1)) {
    var2 = var1.angles;
    var3 = var1.origin;

    if(!issubstr(var1.type, "Prone")) {
      if(issubstr(var1.type, "Left")) {
        var2 += (0, 90, 0);
      } else if(issubstr(var1.type, "Right") || issubstr(var1.type, "Cover Crouch") || issubstr(var1.type, "Conceal") || issubstr(var1.type, "Cover Stand")) {
        var2 -= (0, 90, 0);
      }
    }

    self forceteleport(var3, var2);
    self usecovernode(var1, 1);
    self setgoalnode(var1);
    self.goalradius = 8;
    self.script_radius = 8;
    self.script_origin_other = var3;
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
    return;
  }
}

function break_cover_after_breached(var0) {
  level waittill("ml_p3_building_breach");
  self.goalradius = 1024;
  self.fixednode = 0;
}

function notify_building_breach() {
  var0 = scripts\engine\utility::getStruct("building_center", "targetname");
  var1 = var0.radius;
  var2 = var1 * var1;
  var3 = 0;
  var4 = 1;

  while(!var3) {
    foreach(var6 in level.players) {
      if(istrue(var4)) {
        if(distance2dsquared(var6.origin, var0.origin) < var2) {
          var3 = 1;
        }

        continue;
      }

      if(distancesquared(var6.origin, var0.origin) < var2) {
        var3 = 1;
      }
    }

    wait 0.5;
  }

  level notify("ml_p3_building_breach");
}

function spawn_wave(var0, var1, var2, var3) {
  return scripts\cp\cp_modular_spawning::wave_reinforce(var0, var1, var2, var3);
}

function spawn_per_player(var0, var1, var2, var3) {
  var4 = max(var1, var2 * level.players.size);

  if(isDefined(var3)) {
    var4 = min(var4, var3);
  } else {
    var4 = min(var4, 24);
  }

  return var4;
}

function debug_m1_p3_obj_start(var0) {
  debug_trigger_objective_events(var0);
  thread safehouse_debug_func();
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "ml_p3_debug_start");
}

function debug_trigger_objective_events(var0) {
  scripts\engine\utility::flag_set("cp_dwn_twn_ml_p3_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_ml_p3_create_script_completed");
  scripts\engine\utility::flag_wait("objectives_registered");

  switch (var0.ref) {
    case "ml_p3_intel":
      break;
    case "ml_p3_intel_2":
      break;
    default:
      break;
  }
}

function safehouse_debug_func(var0) {
  while(!scripts\engine\utility::flag_exist("ml_p3_router_picked_up")) {
    wait 1;
  }

  scripts\engine\utility::flag_wait("ml_p3_router_picked_up");
  wait 7;
  scripts\engine\utility::flag_set("ml_p3_done");
}

function vfx_smoke() {
  level endon("game_ended");
  var0 = (25571, -12073.5, -180.25);

  while(!scripts\cp\utility::any_player_nearby(var0, squared(1500))) {
    wait 1;
  }

  scripts\cp\cp_modular_spawning::stop_all_groups();
}

function ref_11c5d() {
  var0 = getEntArray("mlp1_safehouse_intel", "targetname");

  foreach(var2 in var0) {
    var2 show();
  }

  thread scripts\cp\cp_objectives::run_objective("safehouse_return", "primary");
  thread vfx_smoke();
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/GOTO_SAFEHOUSE", "allies", 5);
}

function init_ml_p3_intel(var0, var1) {
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

  for(var2 = 0; var2 < level.final_hack_locations.size; var2++) {
    level.final_hack_locations[var2] = create_final_hack_spot_interaction(level.final_hack_locations[var2], var2);
  }

  level.final_hack_location = level.final_hack_locations[0];
  thread stop_intel_spawning_and_start_p3();
  scripts\cp\utility::skydivestreamhintdvars("ml_p3");
  level thread scripts\cp\cp_munitions::ref_12be1(level.final_hack_location.origin, 200);
  thread autorespawnwaittime();
  at_mine_test();
}

function autorespawnwaittime() {
  var0 = scripts\engine\utility::getStructArray("hack_fake_collision", "targetname");

  foreach(var2 in var0) {
    var3 = getEnt("clip32x32x32", "targetname");
    var4 = spawn("script_model", var2.origin);
    var4.angles = var2.angles;
    var4 clonebrushmodeltoscriptmodel(var3);
  }
}

function keep_players_from_using_ascender() {
  foreach(var1 in level.players) {
    var1.usingascender = 1;
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

function start_ml_p3_intel(var0, var1) {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_ml_p3_multihack_brief_10");
  wait 0.5;
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb("ping_response_affirm");
  var2 = scripts\engine\utility::getStruct("ml_p3_obj", "targetname");
  var3 = var2;
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var0.objectiveindex, var3.origin);
  objective_state(var0.objectiveindex, "current");

  if(isDefined(level.final_hack_location)) {
    level.final_hack = level.final_hack_location;
  }

  thread notify_building_breach();
  thread setup_test_computer(level);

  while(istrue(level.dialogue_playing)) {
    wait 0.25;
  }

  update_objective_marker_when_close(level, var0, var2);
  scripts\engine\utility::flag_set("hack_init");

  while(istrue(level.dialogue_playing)) {
    wait 0.25;
  }

  scripts\engine\utility::flag_wait("hacking_intro_vo_done");
}

function end_ml_p3_intel(var0, var1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("ml_p3_init");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("ml_p3_cover_init");
  scripts\cp\cp_objectives::overridenextstep(var0, "ml_p3_intel_2");
}

function update_objective_marker_when_close(var0, var1) {
  ref_14359(var1, 1200, 1);
  objective_state(var0.objectiveindex, "done");

  for(var2 = 0; var2 < level.final_hack_locations.size; var2++) {
    thread ref_13f8c(level);
    thread ref_13083(level);
  }

  scripts\engine\utility::flag_wait("ml_p3_hack_visual");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_ml_p3_multihack_connect_decrypt_10");
  wait 0.5;
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb("ping_response_affirm");
}

function ref_13083(var0) {
  play_vo_when_near("obj_visual", var0, 300, undefined, 1);
  scripts\engine\utility::flag_set("ml_p3_hack_visual");
}

function ref_13f8c(var0) {
  var1 = scripts\cp\cp_objectives::requestworldid("hack_marker_" + var0);
  var2 = level.final_hack_locations[var0];
  objective_setplayintro(var1, 1);
  objective_setplayoutro(var1, 0);
  objective_setbackground(var1, 1);
  objective_state(var1, "current");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_position(var1, var2.origin);
  level waittill("delete_hack_marker_" + var0);
  objective_state(var1, "done");
  scripts\cp\cp_objectives::freeworldid("hack_marker_" + var0);
}

function play_vo_when_near(var0, var1, var2, var3, var4) {
  ref_14359(var1, var2, var3);

  if(istrue(var4)) {
    scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb(var0);
    return;
  }

  scripts\cp\cp_dialogue::play_vo_to_all(var0);
}

function ref_14359(var0, var1, var2) {
  var3 = var1 * var1;
  var4 = 0;

  while(!var4) {
    foreach(var6 in level.players) {
      if(istrue(var2)) {
        if(distance2dsquared(var6.origin, var0.origin) < var3) {
          var4 = 1;
        }

        continue;
      }

      if(distancesquared(var6.origin, var0.origin) < var3) {
        var4 = 1;
      }
    }

    wait 0.5;
  }
}

function init_ml_p3_intel_2(var0, var1) {}

function start_ml_p3_intel_2(var0, var1) {
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

function end_ml_p3_intel_2(var0, var1) {
  if(isDefined(level.final_hack.model.boxiconid)) {
    thread scripts\cp\utility::ent_deleteheadicon(level.final_hack.model, level.final_hack.model.boxiconid);
  }

  scripts\cp\cp_objectives::overridenextstep(var0, "ml_p3_intel_3");
}

function ref_11cf1() {
  level endon("game_ended");
  level endon("cpu_hacking_done");
  var0 = 0.33;

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

function hacking_sfx(var0) {
  var1 = spawn("script_origin", var0.origin);
  wait 0.05;
  var1 playLoopSound("cp_hacking_struct_lp");
  level scripts\engine\utility::ref_143a5("cpu_hacking_done", "hacking_paused");
  var1 stoploopsound("cp_hacking_struct_lp");
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

function gettimetogulagclosed(var0) {
  var1 = scripts\engine\utility::random(var0);
  scripts\cp\cp_dialogue::play_vo_to_all(var1);
}

function is_any_player_in_region() {
  wait 1;
  var0 = ["dx_cps_cyph_cypher_hack_intro_10", "dx_cps_cyph_cypher_hack_intro_20", "dx_cps_cyph_cypher_hack_intro_30"];
  gettimetogulagclosed(var0);
  wait 1;
  var0 = ["dx_cps_cyph_cypher_connection_good_10", "dx_cps_cyph_cypher_connection_good_20", "dx_cps_cyph_cypher_connection_good_30"];
  gettimetogulagclosed(var0);
  scripts\engine\utility::flag_set("hacking_intro_vo_done");
}

function is_ambient(var0) {
  while(istrue(level.dialogue_playing)) {
    wait 0.1;
  }

  switch (var0) {
    case 1:
      var1 = "dx_cps_cyph_cypher_connection_stable_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var1);
      break;
    case 2:
      var1 = "dx_cps_cyph_cypher_connection_stable_20";
      scripts\cp\cp_dialogue::play_vo_to_all(var1);
      wait 0.5;
      var1 = "dx_cps_kama_cypher_connection_stable_30";
      scripts\cp\cp_dialogue::play_vo_to_all(var1);
      break;
    case 3:
      var1 = "dx_cps_cyph_cypher_connection_stable_40";
      scripts\cp\cp_dialogue::play_vo_to_all(var1);
      wait 0.5;
      var1 = "dx_cps_lass_cypher_connection_stable_50";
      scripts\cp\cp_dialogue::play_vo_to_all(var1);
      break;
    default:
      break;
  }
}

function is_ai_in_stealth() {
  scripts\cp\utility::ref_123fe("");
  var0 = ["dx_cps_cyph_cypher_connection_complete_shut_out_10", "dx_cps_cyph_cypher_connection_complete_shut_out_20", "dx_cps_cyph_cypher_connection_complete_shut_out_30"];
  gettimetogulagclosed(var0);
  wait 5;
  var0 = ["dx_cps_cyph_cypher_connection_complete_intel_10", "dx_cps_cyph_cypher_connection_complete_intel_20", "dx_cps_cyph_cypher_connection_complete_intel_30"];
  gettimetogulagclosed(var0);
  wait 5;
  var1 = "dx_cps_cyph_ml_p3_multihack_transfer_complete_10";
  scripts\cp\cp_dialogue::play_vo_to_all(var1);
  wait 1;
  var1 = "dx_cps_lass_ml_p3_multihack_transfer_complete_20";
  scripts\cp\cp_dialogue::play_vo_to_all(var1);
}

function is_ai_facing_point(var0) {
  switch (var0) {
    case 0:
      var1 = ["dx_cps_cyph_cypher_connection_lost_10", "dx_cps_cyph_cypher_connection_lost_20", "dx_cps_cyph_cypher_connection_lost_30"];
      gettimetogulagclosed(var1);
    case 1:
      var2 = "dx_cps_cyph_cypher_connection_1p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var2);
      break;
    case 2:
      var2 = "dx_cps_cyph_cypher_connection_2p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var2);
      break;
    case 3:
      var2 = "dx_cps_cyph_cypher_connection_3p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var2);
      break;
    case 4:
      var2 = "dx_cps_cyph_cypher_connection_4p_10";
      scripts\cp\cp_dialogue::play_vo_to_all(var2);
      break;
    default:
      break;
  }
}

function init_ml_p3_intel_3(var0, var1) {}

function start_ml_p3_intel_3(var0, var1) {
  var2 = level.final_hack_location.model;
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var0.objectiveindex, var2.origin);
  scripts\engine\utility::flag_wait("ml_p3_router_picked_up");
  level notify("update_hack_objective");
  var3 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_spawning");

  foreach(var5 in var3) {
    var5 scripts\cp\cp_modular_spawning::clear_wave_ref_override();
  }

  scripts\engine\utility::flag_set("ml_p3_vo_finished");
  scripts\engine\utility::flag_set("ml_p3_done");
}

function end_ml_p3_intel_3(var0, var1) {
  level.max_agents_override = undefined;
  scripts\cp\cp_objectives::overridenextstep(var0, "ml_p3_exfil");
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
  var0 = tablelookupgetnumrows("cp/computer_screen_search_results.csv");
  level.cpu_manifest1_idx = randomintrange(1, var0 + 1);
  setomnvar("cpu_manifest1_idx", level.cpu_manifest1_idx);
  level thread scripts\cp\cp_hacking::hacking_init();
  thread setup_test_computer("ml_p3_comp");
}

function setup_test_computer(var0) {
  var1 = getEnt(var0, "targetname");
  var1 delete();
}

function fake_world_structs_defend_download() {
  level.fake_structs = [];
  var0 = [(19487, -9593, 552)];

  foreach(var2 in var0) {
    var3 = spawnStruct();
    var3.origin = var2;
    var3.angles = (0, 0, 0);
    var3.script_noteworthy = "hack_defend_struct";
    level.fake_structs[level.fake_structs.size] = var3;
  }
}

function pause_hacking(var0) {
  level notify("mlp3_hack_pause");
  level endon("mlp3_hack_pause");
  level.hacking_paused = 1;
  level notify("hacking_paused");
  wait var0;
  level.hacking_paused = 0;
  thread hacking_sfx(level);
}

function remove_from_list_on_death() {
  self waittill("death");
  remove_from_hack_attackers_list(self);
}

function remove_from_hack_attackers_list(var0) {
  level.hack_attackers = scripts\engine\utility::array_remove(level.hack_attackers, var0);
}

function listen_to_hack_damage() {
  var0 = 0;
  self.hack_damage = 0;
  var1 = 100;

  while(!var0) {
    self waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);

    if(!isDefined(var3)) {
      continue;
    }

    if(!isDefined(var3.team)) {
      continue;
    }

    if(var3.team != "axis") {
      continue;
    }

    self.hack_damage += var2;

    if(self.hack_damage > var1) {
      var0 = 1;
    }
  }
}

function setup_headicon_on_jammer(var0, var1) {
  self.boxiconid = thread scripts\cp\utility::ent_createheadicon(self, var1, "allies", var0);
  setheadiconzoffset(self.boxiconid, 1);
  setheadiconsnaptoedges(self.boxiconid, 0);
}

function get_enemies_to_advance_on_players() {
  level endon("ml_p3_hack_done");
  level endon("game_ended");
  var0 = 1200;
  var1 = var0 * var0;
  var2 = scripts\engine\utility::getStruct("ml_p3_obj", "targetname");

  for(;;) {
    var3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    foreach(var5 in var3) {
      if(var5.origin[2] > 0) {
        continue;
      }

      if(distancesquared(var5.origin, var2.origin) > var1) {
        continue;
      }

      var5.combatmode = "no_cover";
      var5.goalradius = 32;
    }

    wait 30;
  }
}

function create_final_hack_spot_interaction(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0.origin;
  var2.targetname = "interaction";
  var2.script_noteworthy = "final_hack_spot";
  var2.requires_power = 0;
  var2.spend_type = "null";
  var2.setnewabilitycount = var1;
  var3 = scripts\engine\utility::getStructArray("router_spot", "targetname");
  var4 = scripts\engine\utility::getclosest(var2.origin, var3, 1000);
  var2.model = spawn("script_model", var4.origin);
  var2.model setModel("tag_origin");

  if(!isDefined(var4.angles)) {
    var5 = (0, 0, 0);
  } else {
    var5 = var5.angles;
  }

  var3.model.angles = var5;
  var3.cost = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var3);
  return var3;
}

function register_hack_spot_interaction() {
  scripts\cp\cp_interaction::register_interaction("final_hack_spot", "null", undefined, &final_hack_spot_hint, &final_hack_spot_activate, 0, 0, undefined);
}

function final_hack_spot_hint(var0, var1) {
  if(!scripts\engine\utility::flag("hack_init")) {
    return "";
  }

  if(scripts\engine\utility::flag("ml_p3_hack_visual")) {
    if(!istrue(var0.setnexthistorydestination)) {
      return &"CP_DWN_TWN_OBJECTIVES/ML_P3_COMP";
    }
  }

  if(scripts\engine\utility::flag("ml_p3_hack_done") && !scripts\engine\utility::flag("ml_p3_router_picked_up")) {
    return &"CP_DWN_TWN_OBJECTIVES/ML_P3_ROUTER";
  }

  return "";
}

function final_hack_spot_activate(var0, var1) {
  var1 endon("disconnect");

  if(!scripts\engine\utility::flag("hack_init")) {
    return;
  }

  if(scripts\engine\utility::flag("ml_p3_hack_visual")) {
    if(!istrue(var0.setnexthistorydestination)) {
      var0.setnexthistorydestination = 1;
      level.setovertimeomnvarprogress++;
      thread ref_135c2(level);
      scripts\cp\utility::objective_update("ml_p3_intel", undefined, undefined, undefined, undefined, level.setovertimeomnvarprogress);
      level notify("delete_hack_marker_" + var0.setnewabilitycount);

      if(level.setovertimeomnvarprogress >= level.setovertimeomnvarenabled) {
        scripts\engine\utility::flag_set("ml_p3_hack_started");
        thread lootleadermarkweaksize();
      }
    }
  }

  if(scripts\engine\utility::flag("ml_p3_hack_done") && !scripts\engine\utility::flag("ml_p3_router_picked_up")) {
    if(!istrue(var0.ref_12dbc)) {
      var0.ref_12dbc = 1;
      level.ref_12dc0++;
      scripts\cp\utility::objective_update("ml_p3_intel_3", undefined, undefined, undefined, undefined, level.ref_12dc0);
      var0.model delete();

      if(level.ref_12dc0 >= level.ref_12dbf) {
        scripts\engine\utility::flag_set("ml_p3_router_picked_up");
        scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "obj_device_pickup");
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

function ref_135c2(var0) {
  var0.model setModel("equipment_router_flat");
  setup_headicon_on_jammer(var0.model, "icon_waypoint_cyber_bombsite", 20);
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
  var0 = 250;
  var1 = var0 * var0;
  var2 = level.final_hack_locations;
  var3 = gettime() + 15000;

  for(;;) {
    var4 = 0;

    foreach(var6 in var2) {
      var6.ref_11f20 = 0;

      foreach(var8 in level.players) {
        if(distancesquared(var8.origin, var6.origin) < var1) {
          var4++;
          var6.ref_11f20++;
        }
      }
    }

    var11 = 0;

    foreach(var6 in var2) {
      if(var6.ref_11f20 == 0) {
        var11 = 1;
        break;
      }
    }

    setomnvar("cpu_hacking_signal", var4);
    level.hacking_paused = var11;
    level.hack_multiplier = 1 + var4 * 0.25;

    if(gettime() > var3) {
      var3 += 15000;
      var15 = int(max(0, var4 - 1));

      if(var4 == 0) {
        thread is_ai_facing_point(level);
      }
    }

    waitframe();
  }
}

function claymore_test() {
  var0 = scripts\engine\utility::getStructArray("claymore_test", "targetname");

  foreach(var2 in var0) {
    spawn_claymore(var2);
    wait 0.1;
  }
}

function spawn_claymore() {
  var0 = magicgrenademanual("claymore_mp", self.origin + (0, 0, 100), (0, 0, 10));
  var0.owner = var0;
  var0.team = "axis";
  var0 thread scripts\cp\cp_claymore::claymore_plant();
}

function at_mine_test() {
  var0 = scripts\engine\utility::getStructArray("at_mine_test", "targetname");

  foreach(var2 in var0) {
    spawn_at_mine(var2);
    wait 0.1;
  }
}

function spawn_at_mine() {
  var0 = magicgrenademanual("at_mine_mp", self.origin + (0, 0, 100), (0, 0, 10));
  var0.owner = var0;
  var0.team = "axis";
  thread scripts\cp\equipment\cp_at_mine::at_mine_plant(var0);
}

function get_rid_of_guys_blocking_path() {
  level endon("ml_p3_router_picked_up");

  for(;;) {
    foreach(var1 in level.spawned_enemies) {
      if(!isDefined(var1.listening_for_blocked_path)) {
        thread listen_for_blocked_path();
      }
    }

    wait 0.5;
  }
}

function listen_for_blocked_path() {
  self endon("death");
  self.listening_for_blocked_path = 1;
  var0 = self getentitynumber();

  for(;;) {
    self waittill("node_bad", var1, var2, var3);

    if(var1 != "path_blocked") {
      continue;
    }

    if(isDefined(var3) && var3 < 2000) {
      continue;
    }

    var4 = var2 getentitynumber();

    if(isalive(var2)) {
      if(isDefined(var2.enemy)) {
        thread send_guy_to_org(var2);
        continue;
      }

      foreach(var6 in level.players) {
        if(isDefined(var6) && isalive(var6)) {
          thread send_guy_to_org(var2);
        }
      }
    }
  }
}

function send_guy_to_org(var0) {
  self endon("death");
  self setgoalpos(var0);
  self.goalradius = 16;
  thread stop_ignoring_after_timer(5);
  var1 = scripts\engine\utility::ref_143ad("goal_reached", "goal");
  self.goalradius = 512;
}

function stop_ignoring_after_timer(var0) {
  self.ignoreall = 1;
  wait var0;
  self.ignoreall = 0;
}

function ref_13504() {
  level endon("game_ended");
  var0 = scripts\engine\utility::getStruct("ml_p3_heli_spawn", "targetname");
  var1 = scripts\engine\utility::getStruct("ml_p3_heli_stop1", "targetname");
  var2 = scripts\engine\utility::getStruct("ml_p3_heli_left", "targetname");
  var3 = scripts\engine\utility::getStruct("ml_p3_heli_center", "targetname");
  var4 = scripts\engine\utility::getStruct("ml_p3_heli_right", "targetname");
  var5 = spawn("script_model", level.final_hack_location.origin);
  var5 setModel("tag_origin");
  var6 = scripts\common\vehicle::vehicle_spawn(var0);
  var6.death_fx_on_self = 1;
  var6.circle_radius = 2500;
  var6 scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
  var6.isheli = 1;
  var6.health = 25000;
  var6.maxhealth = 25000;
  var6.team = "axis";
  var6 setvehicleteam("axis");
  var6 setmaxpitchroll(15, 15);
  var6.health_remaining = 25000;
  var6 sethoverparams(25, 15, 10);
  var6 setlookatent(var5);
  var6 vehicle_setspeed(90, 30);
  var6 setvehgoalpos(var1.origin, 1);
  var6 waittill("goal");
  var6 setvehgoalpos(var3.origin, 1);
  var6 waittill("goal");
  var6.instantbleedoutsquadwipe = "center";
  var6 vehicle_setspeed(15, 10);
  var6.ref_11e98 = 1;
  thread skip_navmesh_check(var6);
  thread skipburndownforvehicle(var6);
  thread ref_14454(level);

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var6);
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(var6);
  level waittill("ml_p3_delete_heli");
}

function skipburndownforvehicle(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 vehicle_setspeed(50, 30);
  var1 = scripts\engine\utility::getStruct("ml_p3_heli_left", "targetname");
  var2 = scripts\engine\utility::getStruct("ml_p3_heli_center", "targetname");
  var3 = scripts\engine\utility::getStruct("ml_p3_heli_right", "targetname");
  var4 = scripts\engine\utility::getStruct("ml_p3_heli_front", "targetname");
  var5 = [var1, var2, var3, var4];

  for(;;) {
    var5 = [var1, var2, var3, var4];
    var6 = var5;

    switch (var0.instantbleedoutsquadwipe) {
      case "center":
      default:
        var6 = scripts\engine\utility::array_remove(var5, var2);
        var7 = scripts\engine\utility::random(var6);
        break;
      case "left":
        var6 = scripts\engine\utility::array_remove(var5, var1);
        var7 = scripts\engine\utility::random(var6);
        break;
      case "right":
        var6 = scripts\engine\utility::array_remove(var5, var3);
        var7 = scripts\engine\utility::random(var6);
        break;
      case "front":
        var6 = scripts\engine\utility::array_remove(var5, var4);
        var7 = scripts\engine\utility::random(var6);
        break;
    }

    var0 setvehgoalpos(var7.origin, 1);
    var0 waittill("goal");
    var0.instantbleedoutsquadwipe = var7.script_noteworthy;
    wait 2;
  }
}

function skip_navmesh_check(var0) {
  var0 endon("death");
  level notify("starting_cleanup");
  var0.minigun setturretteam("axis");
  var0.minigun setmode("manual");
  var1 = gettime();
  var2 = 0;

  for(;;) {
    var3 = scripts\engine\utility::getStruct("tv_station_level", "targetname");
    var4 = quarry_wave_spawn_scoring(var0, var3.origin);

    if(!isDefined(var4)) {
      var0.minigun cleartargetentity();
      wait 0.2;
      continue;
    }

    var0.minigun settargetentity(var4);
    var5 = var0.minigun scripts\engine\utility::waittill_notify_or_timeout_return("turret_on_target", 3);

    if(var5 == "timeout") {
      var0.minigun cleartargetentity();
      continue;
    }

    if(gettime() > var1) {
      for(var6 = 0; var6 < 35; var6++) {
        var0.minigun shootturret();
        wait 0.1;
      }

      var1 = gettime() + 1000;
    }
  }
}

function quarry_wave_spawn_scoring(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 25000000;
  }

  var2 = level.players;
  var2 = sortbydistance(var2, self.origin);

  foreach(var4 in var2) {
    if(!isalive(var4)) {
      continue;
    }

    if(distancesquared(var4.origin, var0) < var1 && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), var4.origin + (0, 0, 100), var2)) {
      return var4;
    }
  }

  return undefined;
}

function ref_14454(var0) {
  level endon("game_ended");
  var0 waittill("death");
  playFX(level._effect["helidown_rpghit"], var0.origin);

  if(isDefined(var0.minigun)) {
    var0.minigun makeunusable();
    var0.minigun maketurretinoperable();
    var0.minigun delete();
  }

  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, var0);
  wait 1;

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function ref_137d4(var0) {
  thread ref_13547();
  thread lootleadermarksize();
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_DWN_TWN_OBJECTIVES/EXFIL_HEADER", "allies", 5);
  level waittill("heli_trip_took_off");
  wait 4;
}

function movingplatforment(var0) {
  wait 2;
  thread scripts\cp\cp_objectives::screenent_c("major_objective");
  thread mp_shipment_patch();
  wait 3;

  foreach(var2 in level.players) {
    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var2 thread scripts\cp_mp\xmike109::scriptable_callback("justreward_mod");
      } else {
        var2 thread scripts\cp_mp\xmike109::scriptable_callback("justreward_mod_vet");
      }
    }

    var2 scripts\cp_mp\xmike109::scriptable_callback("downtown_4");
  }

  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function mp_shipment_patch() {
  foreach(var1 in level.players) {
    var1 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var1 in level.players) {
    if(!istrue(var1.try_to_punish_with_jugg)) {
      var1.invulnerable = 1;
      var1 allowmovement(0);
    }

    var4 = scripts\engine\utility::getStruct("mlp3_camera_ending", "targetname");
    var5 = var4.origin;
    var6 = scripts\engine\utility::getStruct(var4.target, "targetname");
    var7 = spawn("script_model", var5);
    var7 setModel("tag_origin");
    var7.angles = var4.angles;
    var7 moveTo(var6.origin, 20, 1, 1);
    var1 playerhide();
    var1 allowfire(0);
    var1 disableoffhandweapons();
    var1 disableusability();
    var1 allowmovement(0);
    var1 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var1, var7);
    var1 lerpfovscalefactor(0, 0);
  }
}

function spawn_endgame_camera(var0) {
  self.ignoreme = 1;
  self cameralinkTo(var0, "tag_origin", 1);
  self setclientdvar("LQKPQMPRQN", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "50");
    return;
  }
}

function screen_fade_to_black(var0) {
  if(!isDefined(var0.kidnap_black_screen)) {
    var0.kidnap_black_screen = newclienthudelem(var0);
    var0.kidnap_black_screen.x = 0;
    var0.kidnap_black_screen.y = 0;
    var0.kidnap_black_screen setshader("black", 640, 480);
    var0.kidnap_black_screen.alignx = "left";
    var0.kidnap_black_screen.aligny = "top";
    var0.kidnap_black_screen.sort = 1;
    var0.kidnap_black_screen.horzalign = "fullscreen";
    var0.kidnap_black_screen.vertalign = "fullscreen";
    var0.kidnap_black_screen.foreground = 1;
  }

  var0.kidnap_black_screen.alpha = 0;
  var0.kidnap_black_screen fadeovertime(2);
  var0.kidnap_black_screen.alpha = 1;
}

function ref_13547() {
  level endon("game_ended");
  var0 = scripts\engine\utility::getStruct("ml_p3_exfil_heli_spawn", "targetname");
  var1 = scripts\engine\utility::getStruct("ml_p3_exfil_heli_lz", "targetname");
  var2 = scripts\engine\utility::getStruct("ml_p2_heli_trip_start", "targetname");
  var0.vehicletype = "blima_cp";
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var0, var1, var2, 0);
  wait 3;

  if(!isDefined(level.heli_trip_vehicle)) {
    return;
  }

  var3 = level.heli_trip_vehicle;
  var4 = scripts\cp\cp_objectives::requestworldid("ml_p3_exfil");
  objective_state(var4, "current");
  objective_position(var4, var1.origin);
  objective_icon(var4, "icon_waypoint_objective_general");
  objective_setlabel(var4, &"CP_DWN_TWN_OBJECTIVES/EXFIL_HEADER");
  objective_setshowoncompass(var4, 1);
  objective_setminimapiconsize(var4, "icon_regular");
  var3 waittill("started_boarding");
  scripts\cp\cp_objectives::ref_11f80(var4);
  var3 waittill("heli_taking_off");
  objective_delete(var4);
  scripts\cp\cp_objectives::freeworldid("ml_p3_exfil");
}