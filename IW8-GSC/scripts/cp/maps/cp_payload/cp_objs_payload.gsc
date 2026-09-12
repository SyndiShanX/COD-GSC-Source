/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_payload\cp_objs_payload.gsc
**********************************************************/

function registerpayloadvfx() {
  level._effect["vfx_payload_dmg_1"] = loadfx("vfx/iw8/veh/stango/vfx_apc_body_damage_1.vfx");
  level._effect["vfx_payload_dmg_2"] = loadfx("vfx/iw8/veh/stango/vfx_apc_body_damage_2.vfx");
  level._effect["vfx_payload_dmg_3"] = loadfx("vfx/iw8/veh/stango/vfx_apc_body_damage_3.vfx");
  level._effect["vfx_payload_dest"] = loadfx("vfx/iw8/veh/stango/vfx_apc_death.vfx");
  level._effect["vfx_payload_rpg_hit"] = loadfx("vfx/iw8_mp/killstreak/vfx_ahotel64_rocket_explosion.vfx");
}

function registerpayloadobjective() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  thread registersquadspawners();
  scripts\cp\cp_objectives::registerobjective("obj_payload", &initpayloadobj, &startpayloadobj, &completepayloadobj, undefined, &debugpayloadobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("payload_destroy_tanks", undefined, &ref_13868, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("payload_exfil", undefined, &ref_13865, &hint_obj_name, undefined);
  scripts\cp\cp_objectives::registerobjective("obj_payload_fail_destroyed", undefined, undefined, undefined, undefined);
}

function ref_13868(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist("payload_tanks_killed")) {
    scripts\engine\utility::flag_init("payload_tanks_killed");
  }

  scripts\engine\utility::flag_wait("payload_tanks_killed");
  thread scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function initpayloadobj(var_0, var_1) {
  setDvar("bg_pathFollowerMinLookaheadDist", 0);
  level.initlocationcircle = "obj_payload";
  level.initlethalmaxoffsetmap = "obj_payload";
  scripts\engine\utility::flag_init("payload_tanks_killed");
  scripts\engine\utility::flag_init("armsrace_cache_opened");

  if(!istrue(scripts\engine\utility::flag("cp_payloadobjective_cs"))) {
    scripts\engine\utility::flag_set("cp_payloadobjective_cs");
  }

  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  scripts\engine\utility::flag_wait("payload_spawn_functions_registered");
  scripts\cp\utility::skydivestreamhintdvars("payload");
  var_0.apcwid = scripts\cp\cp_objectives::requestworldid("apc_obj_wid");
  var_2 = scripts\engine\utility::getStruct("payload_obj_start_01", "targetname");
  objective_setplayintro(var_0.apcwid, 1);
  objective_state(var_0.apcwid, "current");
  objective_icon(var_0.apcwid, "icon_waypoint_objective_general");
  objective_setzoffset(var_0.apcwid, 64);
  objective_position(var_0.apcwid, var_2.origin);
  objective_setlabel(var_0.apcwid, &"CP_OBJ_PAYLOAD/ESCORT");
  objective_sethot(var_0.apcwid, 0);
  var_0.ispayloadstunned = 0;
  var_0.apc_destroyed = 0;
  thread spawnapc(level);
  var_0 waittill("apc_spawned");
  scripts\cp\cp_objectives::ref_11f80(var_0.apcwid);
  var_0.timesapchitbymine = 0;
  var_0.rpgambusherskilled = 0;
  var_0.usepingsystem = 0;

  if(getdvarint("scr_payload_no_mines", 0) <= 0) {
    spawnatmines(var_0);
    return;
  }
}

function select_top_roof_spawners(var_0) {
  thread aigroundturret_shouldbegindismountturret();
}

function aigroundturret_shouldbegindismountturret() {
  self endon("death");
  scripts\engine\utility::waittill_notify_or_timeout("goal", 5);
  wait 1;
  self.goalradius = 512;
  self.goalheight = 48;
}

function ref_12dc2(var_0) {
  if(isDefined(self.spawnpoint.script_noteworthy) && self.spawnpoint.script_noteworthy == "rpg") {
    thread ref_132af();
    return;
  }
}

function ref_132af(var_0) {
  self endon("death");

  while(!isDefined(level.apc)) {
    wait 1;
  }

  var_1 = 122500;
  self waittill("goal");
  self setentitytarget(level.apc);
  self.a.rockets = 100;

  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(distancesquared(var_4.origin, self.origin) < var_1) {
        self clearentitytarget();
        self allowedstances("crouch", "stand", "prone");
        self.script_origin_other = undefined;
        self.goalradius = 2048;
        return;
      }
    }

    wait 0.1;
  }
}

function startpayloadobj(var_0, var_1) {
  scripts\engine\utility::flag_set("cp_armsrace_cs");
  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  scripts\engine\utility::flag_wait("armsrace_interactions_initted");
  thread ref_138c7();
  thread ref_1380b();
  thread ref_13976();
  scripts\cp\cp_create_script_utility::ref_13529("payload_section_1_nodes");
  wait 2;
  thread watchforplayerproximity(level, "allies");
  thread ref_14462(level);
  scripts\cp\cp_modular_spawning::run_spawn_module("payload_1_left");
  level.computer_debugtestloop = undefined;
  thread ref_144ab();
  thread watchatminehitonpayload(var_0.apc);
  thread watchforminewarning(var_0.apc);
  thread ref_144bb();
  thread watchforpayloadongoal(var_0.apc);
  thread ref_144b3(var_0.apc, "payload_first_crate");
  thread ref_144b3(var_0.apc, "payload_second_crate");
  level waittill("payload_reached_first_cache");
}

function completepayloadobj(var_0) {
  scripts\cp\cp_objectives::freeworldid("apc_obj_wid");

  if(istrue(var_0.pathdist)) {
    return;
  }

  if(!istrue(var_0.apc_destroyed)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_pilot_outro_tank_alive_10", "allies");
  }

  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_apc_done");
}

function ref_13865(var_0) {
  if(!istrue(scripts\engine\utility::flag_exist("cp_armsrace_cs_completed"))) {
    scripts\engine\utility::flag_init("cp_armsrace_cs_completed");
  }

  scripts\engine\utility::flag_set("cp_armsrace_cs");
  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  thread ref_1364e();
  level waittill("heli_trip_took_off");
}

function hint_obj_name(var_0) {
  wait 4;

  foreach(var_2 in level.players) {
    var_2 thread scripts\cp_mp\xmike109::screenent_d("paladin");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_2 thread scripts\cp_mp\xmike109::scriptable_callback("paladin_mod");
        continue;
      }

      var_2 thread scripts\cp_mp\xmike109::scriptable_callback("paladin_mod_vet");
    }
  }

  scripts\cp\cp_achievement::update_achievement_all_players("LAUNDERED", 1);
  scripts\cp\cp_achievement::update_achievement_all_players("PICKLES", 1);
  thread scripts\cp\cp_objectives::screenent_c("major_objective");
  thread mp_shipment_patch();
  wait 3;
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

    var_4 = scripts\engine\utility::getStruct("cp_payload_endgame_cam", "targetname");
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
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("cg_fov", "50");
    return;
  }
}

function managejumpmasterinfodisplay() {
  level endon("game_ended");
  level scripts\engine\utility::waittill_notify_or_timeout("morales_outro_vo_done", 5);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_seen_10", "allies");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_status_10", "allies");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_status_20", "allies");
}

function ref_13846(var_0) {
  level endon("game_ended");
  wait var_0;
  scripts\cp\cp_modular_spawning::run_spawn_module("payload_heli_4");
}

function toggle_player_pos_memory(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("cp_payloadobjective_cs"))) {
    scripts\engine\utility::flag_set("cp_payloadobjective_cs");
  }

  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  scripts\engine\utility::flag_wait("payload_spawn_functions_registered");
  scripts\engine\utility::flag_init("payload_punish_completed");
}

function ref_13866(var_0, var_1) {
  scripts\cp\cp_modular_spawning::run_spawn_module("payload_holdout_left");
  wait 30;
  thread maxplunder();
  wait 40;
  thread ref_13609();
  scripts\engine\utility::flag_set("payload_punish_completed");
  wait 20;
}

function hint_outline_target_think(var_0) {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_apc_pilot_outro_tank_dead_10", "allies");
  scripts\cp\cp_objectives::overridenextstep(var_0, "obj_armsrace_approach");
  wait 2;
}

function maxplunder() {
  level endon("game_ended");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_helo_apc_pilot_status_15", "allies");
  wait 30;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_helo_apc_pilot_status_25", "allies");
}

function mark_as_bomb_vest_controller_holder(var_0) {
  level endon("game_ended");
  wait var_0;
  var_1 = scripts\engine\utility::getStruct("payload_ai_exfil", "script_noteworthy");
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var_4 in var_2) {
    thread ref_12cd0(var_4);
  }
}

function ref_12cd0(var_0) {
  level endon("game_ended");
  self endon("death");
  self.goalradius = 64;
  self setgoalpos(var_0);
  scripts\engine\utility::waittill_notify_or_timeout("goal", 60);
  self dodamage(self.health + 100, self.origin);
}

function watchforminewarning(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");

  for(;;) {
    if(distance2d(var_1.origin, self.origin) <= 200) {
      break;
    }

    wait 1;
  }

  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_mine_seen_10", "allies");
}

function ref_144ab() {
  thread watchforpayloadspawngroup("payload_1", ["rpg_group1", "rooftop_snipers_1", "payload_section_1"]);
  thread watchforpayloadspawngroup("payload_2", "payload_rooftop_group1", "payload_apc_heli_1");
  thread watchforpayloadspawngroup("payload_3", "payload_rooftop_group1_b");
  thread watchforpayloadspawngroup("payload_apc_heli", "payload_apc_heli_2");
  thread watchforpayloadspawngroup("payload_paratroopers");
}

function registersquadspawners() {
  if(!scripts\engine\utility::flag_exist("payload_spawn_functions_registered")) {
    scripts\engine\utility::flag_init("payload_spawn_functions_registered");
  }

  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_wait("interactions_initialized");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("cp_payloadobjective_cs_completed")) {
    scripts\engine\utility::flag_init("cp_payloadobjective_cs_completed");
  }

  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  scripts\cp\cp_modular_spawning::registerambientgroup("escort_intro_rpg", 2, 2, 2, 0.1, undefined, "escort_intro_rpg");
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_apc_heli_1", 0, 6, 6, 0.1, undefined, "payload_apc_heli_1", undefined, undefined, 40);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_apc_heli_2", 0, 6, 6, 0.1, undefined, "payload_apc_heli_2", undefined, undefined, 40);
  scripts\cp\cp_modular_spawning::registerambientgroup("street_paratroopers", 4, 4, 4, 0.1, undefined, "street_paratroopers", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("lot_paratroopers_1", 4, 4, 4, 0.1, undefined, "lot_paratroopers_1", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("lot_paratroopers_2", 4, 4, 4, 0.1, undefined, "lot_paratroopers_2", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("lot_paratroopers_3", 4, 4, 4, 0.1, undefined, "lot_paratroopers_3", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("super_paratroopers_1", 4, 4, 4, 0.1, undefined, "super_paratroopers_1", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("super_paratroopers_2", 4, 4, 4, 0.1, undefined, "super_paratroopers_2", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("super_paratroopers_3", 4, 4, 4, 0.1, undefined, "super_paratroopers_3", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_section_1", 0, 6, 6, 0.1, 6, "payload_section_1", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("rpg_group1", 0, 3, 3, 0.1, undefined, "rpg_group1", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("rooftop_snipers_1", 0, 2, 2, 0.1, undefined, "rooftop_snipers_1", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_rooftop_group1", 0, 3, 6, 0.1, undefined, "payload_rooftop_group1", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_rooftop_group1_b", 0, 3, 6, 0.1, undefined, "payload_rooftop_group1_b", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_1_left", 0, 7, 14, 0.1, undefined, "payload_1_left", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_2_left", 0, 5, 12, 0.1, undefined, "payload_2_left", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_super_sniper", 0, 1, 2, 0.1, undefined, "payload_super_sniper", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_super_rpg", 0, 1, 3, 0.1, undefined, "payload_super_rpg", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_parkinglot_guards", 4, 4, 4, 0.1, undefined, "payload_parkinglot_guards", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_ihop", 0, 5, 6, 0.1, undefined, "payload_ihop", undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_aptBldg", 2, 2, 6, 0.1, undefined, "payload_aptBldg", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("aptBldg_rpg", 2, 2, 4, 0.1, undefined, "aptBldg_rpg", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_dealership", 0, 8, 10, 0.1, undefined, "payload_dealership", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("payload_super", 10, 12, 18, 0.1, undefined, "payload_super", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("rpg_alley_1", 0, 3, 3, 0.1, undefined, "rpg_alley_1", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("rpg_alley_2", 0, 3, 3, 0.1, undefined, "rpg_alley_2", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("rpg_alley_1", &ref_12dc2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("rpg_alley_2", &ref_12dc2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("rpg_group1", &ref_12dc2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("aptBldg_rpg", &ref_12dc2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("escort_intro_rpg", &ref_12dc2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("rooftop_snipers_1", &select_top_roof_spawners);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("payload_rooftop_group1", &ref_12dc2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("payload_rooftop_group1_b", &ref_12dc2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("payload_super_rpg", &ref_12dc2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("payload_super_sniper", &select_top_roof_spawners);
  scripts\engine\utility::flag_set("payload_spawn_functions_registered");
}

function brclampdamage(var_0) {
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(!isDefined(var_1.watch_for_players_entering_area_earlier)) {
    var_1.watch_for_players_entering_area_earlier = -9999;
  }

  if(gettime() - var_1.watch_for_players_entering_area_earlier < 15000) {
    return;
  }

  var_2 = "dx_cps_taco_apc_callout_";
  var_3 = "";

  switch (var_0.group_name) {
    case "payload_stop1_left":
      var_3 = "south_";
      break;
    case "payload_stop1_right":
      var_3 = "north_";
      break;
    case "payload_stop2_left":
      var_3 = "south_";
      break;
    case "payload_stop2_right":
      var_3 = "north_";
      break;
    case "payload_stop3_left":
      var_3 = "west_";
      break;
    case "payload_stop3_right":
      var_3 = "east_";
      break;
    case "payload_stop4_left":
      var_3 = "west_";
      break;
    case "payload_stop4_right":
      var_3 = "east_";
      break;
    default:
      break;
  }

  var_4 = scripts\engine\utility::string(randomintrange(1, 4)) + "0";
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_2 + var_3 + var_4, "allies");
  var_1.watch_for_players_entering_area_earlier = gettime();
}

function getnexthelispawnmodule(var_0) {
  level endon("game_ended");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var_1.usepingsystem)) {
    return undefined;
  }

  for(var_2 = getaiarray("axis").size; var_2 >= 24; var_2 = getaiarray("axis").size) {
    wait 6;
  }

  var_3 = strtok(var_0.group_name, "_");
  var_4 = int(var_3[var_3.size - 1]);
  var_4++;

  if(var_4 > 8) {
    var_4 = 1;
  }

  return "payload_heli_" + var_4;
}

function reset_restock_flag(var_0) {
  level endon("game_ended");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var_1.usepingsystem)) {
    return undefined;
  }

  wait 5;

  for(var_2 = getaiarray("axis").size; var_2 > 18; var_2 = getaiarray("axis").size) {
    wait 1;
  }

  var_3 = strtok(var_0.group_name, "_");
  var_4 = scripts\engine\utility::ter_op(var_3[var_3.size - 1] == "left", "right", "left");
  var_5 = "";

  for(var_6 = 0; var_6 <= var_3.size - 2; var_6++) {
    var_5 = var_5 + var_3[var_6] + "_";
  }

  var_5 += var_4;
  return var_5;
}

function reset_target_group(var_0) {
  level endon("game_ended");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var_1.usepingsystem)) {
    return undefined;
  }

  for(var_2 = 0; var_2 <= 5; var_2++) {
    wait 1;
  }

  var_3 = undefined;

  if(!isDefined(level.ref_11f6a)) {
    level.ref_11f6a = 0;
  }

  switch (var_0.group_name) {
    case "payload_rpg_1":
      if(level.ref_11f6a == 1) {
        var_3 = "payload_rpg_1";
      }

      break;
    case "payload_rpg_2":
      if(level.ref_11f6a == 2) {
        var_3 = "payload_rpg_2";
      }

      break;
    case "payload_rpg_3":
      if(level.ref_11f6a >= 3) {
        var_3 = "payload_rpg_3";
      }

      break;
    default:
      var_3 = undefined;
      break;
  }

  return var_3;
}

function getnextholdoutspawnmodule(var_0) {
  if(scripts\engine\utility::flag_exist("payload_punish_completed") && scripts\engine\utility::flag("payload_punish_completed")) {
    return undefined;
  }

  var_1 = 0;

  for(var_2 = getaiarray("axis").size; var_2 > 15 || var_1 <= 5; var_2 = getaiarray("axis").size) {
    wait 1;
    var_1++;
  }

  var_3 = undefined;

  switch (var_0.group_name) {
    case "payload_holdout_left":
      var_3 = "payload_holdout_right";
      break;
    case "payload_holdout_right":
      var_3 = "payload_holdout_left";
      break;
    default:
      var_3 = undefined;
      break;
  }

  return var_3;
}

function ref_1293d(var_0) {
  level endon("game_ended");
  self endon("death");
  wait 4;
  thread scripts\cp\cp_modular_spawning::set_script_origin_other_to_center_of_players();
}

function ref_12dcc(var_0) {
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var_2 = var_1.apc;

  if(isDefined(var_2)) {
    thread ref_12dcd(var_2);
    return;
  }
}

function ref_12dcd(var_0) {
  self endon("death");
  var_0 endon("death");
  var_1 = self;
  var_1.goalradius = 1024;
  var_1 setgoalpos(var_0.origin);
  var_1 waittill("goal");
  var_1 setentitytarget(var_0, 1);
}

function _ambush_rpg_after_spawn(var_0) {
  thread ambush_rpg_after_spawn(var_0);
  thread watch_for_ambush_rpg_death();
}

function watch_for_ambush_rpg_death() {
  level endon("game_ended");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  self waittill("death");
  var_0.rpgambusherskilled++;
}

function ambush_rpg_after_spawn(var_0) {
  level endon("game_ended");
  self endon("death");
  wait 1;

  if(isDefined(self.spawnpoint.target)) {
    var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
    self.goalradius = 40;

    if(isDefined(var_1)) {
      self.ignoreall = 1;
      self setgoalpos(var_1.origin);
      self waittill("goal");
      self.ignoreall = 0;
      return;
    }

    return;
  }
}

function _rpg_skit_after_spawn(var_0) {
  thread rpg_skit_after_spawn(var_0);
}

function rpg_skit_after_spawn(var_0) {
  level endon("game_ended");
  self endon("death");
  waitframe();
  self.maxfaceenemydist = 768;
  self.dontevershoot = 1;
  self.ignoreall = 1;
  self.maxhealth = 99999;
  self.health = self.maxhealth;
  self.wearing_armor = 1;
  self.dontevershoot = 1;
  self.goalradius = 40;
  var_1 = scripts\engine\utility::getStruct("payload_rpg_skit_goto", "script_noteworthy").origin;
  self setgoalpos(var_1);

  while(scripts\engine\utility::distance_2d_squared(self.origin, var_1) >= 4096) {
    wait 0.5;
  }

  thread watchtofirerocketatpayload(self);
}

function watchtofirerocketatpayload(var_0) {
  var_0 endon("death");
  var_0.rpg_fire_pos = scripts\engine\utility::getStruct("payload_rocket_start", "script_noteworthy").origin;
  fire_rpg_to_payload(var_0.rpg_fire_pos, 1);
  var_0.dontevershoot = 0;
  var_0.ignoreall = 0;
  var_0 animmode("normal");
  var_0.scripted_mode = 0;
  var_0.health = 100;
  var_0.maxhealth = 100;
}

function fire_rpg_to_payload(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var_4 = var_3.apc;

  if(isDefined(var_4)) {
    var_5 = anglesToForward(var_4.angles);
    var_6 = var_4 vehicle_getspeed();
    var_7 = var_4.origin + (0, 0, 40) + var_5 * var_6 * get_forward_scalar(var_0, var_4, var_6);

    if(!var_1) {
      if(!isDefined(var_2)) {
        var_2 = (0, 0, 0);
      }

      var_7 += var_2;
    }

    var_8 = magicbullet("rpg_missile_cp", var_0, var_7);

    if(var_1) {
      var_8 missile_settargetEnt(var_4);
      var_8 missile_setflightmodedirect();
    }

    thread watchforrpgimpact(var_8);
    return;
  }
}

function watchforrpgimpact(var_0) {
  level endon("game_ended");
  self waittill("death");
  playFXOnTag(level._effect["vfx_payload_dest"], var_0, "tag_origin");
  var_0 playSound("rocket_explode");
  level notify("apc_hit_by_rpg");
}

function get_forward_scalar(var_0, var_1, var_2) {
  var_3 = 1600;
  var_4 = 0.47;
  var_5 = distance(var_0, var_1.origin);
  var_6 = var_5 / var_3;
  return var_2 * var_6 * var_4;
}

function watchforambushend() {
  level endon("game_ended");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var_1 = gettime();
  var_2 = 0;
  var_3 = 30000;

  while(!istrue(var_2) && gettime() - var_1 <= var_3) {
    if(var_0.rpgambusherskilled >= 4) {
      var_2 = 1;
    }

    wait 0.5;
  }

  level notify("payload_rpg_ambush_killed");
}

function spawnapc(var_0) {
  level.convoy_speed_override = 12;
  var_1 = scripts\engine\utility::getStruct("payload_obj_start_01", "targetname");
  var_2 = "apc-payload-type";
  var_3 = "apc_payload";
  var_4 = spawnStruct();
  var_4.origin = var_1.origin;
  var_4.angles = var_1.angles;
  var_4.owner = level.players[0];
  var_4.team = var_0.currentteam;
  var_4.cannotbesuspended = 1;
  var_5 = scripts\cp_mp\vehicles\apc_rus::apc_rus_create(var_4);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(var_5);
  level.apc = var_5;
  wait 2;
  var_0.apc = var_5;
  var_6 = var_1;
  var_5.pathing_array = [];
  var_5.pathing_array[0] = var_6.origin;
  ref_12c39(var_5);
  thread c4_crate_use();

  while(isDefined(var_6.target)) {
    var_6 = scripts\engine\utility::getStruct(var_6.target, "targetname");
    var_5.pathing_array[var_5.pathing_array.size] = var_6.origin;
  }

  var_5.health = 30000;
  var_5.ref_13bf2 = 30000;
  var_5.ref_11e7d = 80;
  var_5.little_bird_mg_enterend = 1;
  var_7 = [];
  var_8 = var_5.pathing_array.size;
  var_9 = undefined;
  var_10 = var_1.origin;
  var_5.intro_safehouse_loot = scripts\engine\utility::ter_op(getdvarfloat("scr_payload_speed", 0) > 0, getdvarfloat("scr_payload_speed", 0), 2);

  for(var_11 = 0; var_11 < var_8; var_11++) {
    if(isDefined(var_5.pathing_array[var_11 + 1])) {
      var_9 = var_5.pathing_array[var_11 + 1];
    }

    var_12 = scripts\cp\cp_vehicles::get_duration_between_points(var_10, var_9, var_5.intro_safehouse_loot, 1);
    var_7 = min(var_12, 20);
    var_10 = var_9;
  }

  var_5 setlookaheadtime(0.2);
  var_5 startpathnodes(var_5.pathing_array, var_7);
  var_5.veh_pathtype = "constrained";
  var_0 notify("apc_spawned");
  thread ref_144ac();
  thread watchforapcdeath();
  thread ref_144be();
  thread ref_1446e(var_5);
  objective_setplayintro(var_0.apcwid, 0);
  objective_state(var_0.apcwid, "current");
  objective_icon(var_0.apcwid, "icon_waypoint_objective_general");
  objective_setzoffset(var_0.apcwid, 64);
  objective_onentity(var_0.apcwid, var_5);
  apcstop(var_5);
}

function ref_144be() {
  level endon("game_ended");
  self endon("death");
  self endon("apc_reached_goal");
  var_0 = self;

  for(;;) {
    wait 2;
    var_0 connectpaths();
    waitframe();
    var_0 disconnectPaths();
  }
}

function ref_144ac() {
  level endon("game_ended");
  self endon("death");
  var_0 = self;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

    if(isDefined(var_10) && isDefined(var_10.basename) && var_10.basename == "tur_apc_rus_ai_cp") {
      self.health += var_1;
      continue;
    }

    var_1 = setup_soldier_stealth(var_10, var_5, var_1);
    thread losqueuelow(var_0);
    var_16 = var_0.health / var_0.ref_13bf2 * 100;

    if(var_16 <= 75) {
      var_17 = 1;

      if(var_16 <= 50) {
        var_17 = 2;
      }

      if(var_16 <= 25) {
        var_17 = 3;
      }

      thread setdamagestate(var_0);
    }
  }
}

function setup_soldier_stealth(var_0, var_1, var_2) {
  var_3 = var_2;

  if(!isDefined(var_0)) {
    return var_2;
  }

  switch (var_0.basename) {
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "ac130_25mm_mp":
      var_3 /= 4;
      break;
  }

  return var_3;
}

function losqueuelow(var_0) {
  var_1 = self;

  if(!isDefined(self.watch_for_players_activating_juggmaze_map)) {
    var_1.watch_for_players_activating_juggmaze_map = -9999;
  }

  if(gettime() - var_1.watch_for_players_activating_juggmaze_map < 15000) {
    return;
  }

  var_2 = var_1.health / var_1.ref_13bf2 * 100;

  if(var_2 <= var_1.ref_11e7d) {
    if(var_1.ref_11e7d >= 60) {
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_health_" + var_1.ref_11e7d + "_10", "allies");
    } else if(var_1.ref_11e7d <= 0) {
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_status_00_10", "allies");
    } else {
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_status_" + var_1.ref_11e7d + "_10", "allies");
    }

    if(!isDefined(var_1)) {
      return;
    }

    var_1.ref_11e7d = max(var_1.ref_11e7d - 20, 0);
    self.watch_for_players_activating_juggmaze_map = gettime();
    return;
  }

  if(isDefined(var_0) && var_0.classname == "rocketlauncher") {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_rpg_hit_" + randomintrange(1, 4) + "0", "allies");
    self.watch_for_players_activating_juggmaze_map = gettime();
    return;
  }
}

function watchforplayerproximity(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("payload_apc_destroyed");
  var_2 = var_1.apc;
  var_2 endon("payload_reached_goal");
  var_2 endon("death");
  var_3 = "stopped";
  var_4 = "";

  while(!istrue(var_1.apc_destroyed)) {
    if(istrue(var_1.ispayloadstunned) || istrue(var_1.updatebotpersonalitybasedonweapon) || istrue(var_1.turret_objective_think)) {
      var_4 = "";
      wait 2;
      continue;
    }

    var_5 = scripts\cp\utility::getplayersinteam(var_0);
    var_6 = 0;

    foreach(var_8 in var_5) {
      if(distance(var_8.origin, var_2.origin) <= 512) {
        var_6++;
      }
    }

    if(var_6 > 0 || istrue(var_1.updateassassinationthreatlevel)) {
      var_3 = "moving";
    } else {
      var_3 = "stopped";
    }

    if(var_3 != var_4) {
      var_4 = var_3;

      if(var_3 == "moving") {
        thread apcstart(level);
      } else {
        thread apcstop(level);
      }
    }

    wait 1;
  }
}

function ref_14462(var_0) {
  level endon("game_ended");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var_2 = scripts\engine\utility::getStruct("payload_do_cache_1", "script_noteworthy");

  if(getdvarint("scr_skip_to_cache", 0) <= 0) {
    while(isDefined(var_0) && distance(var_0.origin, var_2.origin) > 100) {
      wait 0.5;
    }
  }

  if(istrue(var_1.apc_destroyed)) {
    return;
  }

  var_1.shot_by_player = 1;
  var_1.updatebotpersonalitybasedonweapon = 1;
  apcstop(var_0);
  thread ref_13bad(0);
  var_3 = getdvarint("scr_skip_to_cache", 0);
  level notify("payload_reached_first_cache");

  if(var_3 <= 1) {
    level scripts\cp\maps\cp_armsrace\armsrace_objective\cp_armsrace_objective::docache1();
  }

  wait 1;

  if(!istrue(var_1.apc_destroyed)) {
    thread ref_11d90(var_0);
  }

  if(var_3 <= 2) {
    level scripts\cp\maps\cp_armsrace\armsrace_objective\cp_armsrace_objective::docache2();
  }

  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("apc_escort_3");

  if(var_3 <= 3) {
    level thread scripts\cp\maps\cp_armsrace\armsrace_objective\cp_armsrace_objective::docache4();
  }

  thread ref_1434f();
  level waittill("armsrace_cache4_almost_finished");
  thread ref_13609();
  level waittill("armsrace_cache_opened");
  scripts\engine\utility::flag_set("armsrace_cache_opened");
}

function ref_1434f() {
  scripts\engine\utility::flag_wait("payload_tanks_killed");
  scripts\engine\utility::flag_wait("armsrace_cache_opened");
  scripts\cp\cp_objectives::run_objective("payload_exfil");
}

function ref_11d90(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = scripts\engine\utility::getStruct("payload_goal_while_cache2", "script_noteworthy").origin;
  level waittill("armsrace_cache2_activated");
  self notify("apc_stop_shooting");
  var_0.updateassassinationthreatlevel = 1;
  var_0.updatebotpersonalitybasedonweapon = 0;

  while(distance(self.origin, var_1) > 100) {
    wait 0.5;
  }

  var_0.updateassassinationthreatlevel = 0;
  apcstop(self);
}

function watchforpayloadspawngroup(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death");
  var_3 = scripts\engine\utility::getStruct(var_0, "script_noteworthy").origin;

  while(distance(self.origin, var_3) > 100) {
    wait 0.5;
  }

  if(var_0 == "payload_paratroopers") {
    thread ref_13589();
  }

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_5 in var_1) {
        scripts\cp\cp_modular_spawning::run_spawn_module(var_5);
        waitframe();
      }
    } else {
      scripts\cp\cp_modular_spawning::run_spawn_module(var_1);
    }
  }

  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      foreach(var_8 in var_2) {
        scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_8);
        waitframe();
      }

      return;
    }

    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_2);
    return;
  }
}

function ref_144c8(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  var_2 = scripts\engine\utility::getStruct(var_0, "script_noteworthy").origin;

  while(distance(self.origin, var_2) > 100) {
    wait 0.5;
  }

  level thread scripts\cp\cp_wave_spawning::killstreaks(0.5, var_1);
}

function watchforpayloadconvoygroup(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("death");
  var_4 = scripts\engine\utility::getStruct(var_0, "script_noteworthy").origin;

  while(distance(self.origin, var_4) > 100) {
    wait 0.5;
  }

  start_convoy(var_1, var_2, var_3);
}

function ref_144c7(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("death");
  var_4 = scripts\engine\utility::getStruct(var_0, "script_noteworthy").origin;
  var_5 = scripts\engine\utility::getStruct(var_1, "script_noteworthy").origin;
  var_6 = scripts\engine\utility::getStruct(var_2, "script_noteworthy").origin;
  var_7 = scripts\engine\utility::getStruct(var_3, "script_noteworthy").origin;
  level.ref_11f6a = 0;

  while(distance(self.origin, var_4) > 100) {
    wait 0.5;
  }

  level.ref_11f6a = 1;

  while(distance(self.origin, var_5) > 100) {
    wait 0.5;
  }

  level.ref_11f6a = 2;

  while(distance(self.origin, var_6) > 100) {
    wait 0.5;
  }

  level.ref_11f6a = 3;

  while(distance(self.origin, var_7) > 100) {
    wait 0.5;
  }

  level.ref_11f6a = 4;
}

function watchforrpgambush(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death");
  self endon("payload_reached_goal");
  var_3 = scripts\engine\utility::getStruct(var_0, "script_noteworthy").origin;

  while(distance(self.origin, var_3) > 100) {
    wait 0.5;
  }

  var_2.ispayloadstunned = 1;
  apcstop(self);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_1);
  scripts\cp\cp_modular_spawning::run_spawn_module("payload_ambush_spawners");
  thread maxpools();
  thread watchforambushend();
  level scripts\engine\utility::waittill_notify_or_timeout_return("payload_rpg_ambush_killed", 30);
  scripts\cp\cp_modular_spawning::stop_module_by_id("payload_ambush_spawners");
  var_2.ispayloadstunned = 0;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_near_goal_10", "allies");
}

function maxpools() {
  level endon("game_ended");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_ambush_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_clear_rpg_30", "allies");
  var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));

  if(isDefined(var_0)) {
    wait scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_sitrep_wave_start");
    return;
  }
}

function start_convoy(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_4 = var_2;
  thread set_convoy_settings(level, var_0, var_4);
}

function set_convoy_settings(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  wait 1;
  var_4 notify("able_to_deposit_driver");
  var_4 scripts\cp\cp_convoy_manager::ref_1307d(0);
  level waittill("despawn_" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);

  if(var_0 == "payload_convoy_1") {
    thread vehomn_fadeoutcontrols();
    return;
  }
}

function vehomn_fadeoutcontrols() {
  level endon("game_ended");
  self waittill("death");
  level thread scripts\cp\utility::ref_123fe("");
}

function watchforpayloadongoal(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = scripts\engine\utility::getStruct(var_0, "script_noteworthy").origin;

  while(distance(self.origin, var_1) > 100) {
    wait 0.5;
  }

  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var_2.updateassassinationthreatlevel = 0;
  var_2.usepingsystem = 1;
  self notify("payload_reached_goal");
  waitframe();
  thread apcstop(var_2);
  var_2 notify("payload_objective_done");
  var_3 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam(var_2.currentteam));

  if(isDefined(var_3)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_3, "flavor_closecall");
    return;
  }
}

function ref_144b3(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  var_2 = scripts\engine\utility::getStruct(var_0, "script_noteworthy").origin;

  while(distance(self.origin, var_2) > 100) {
    wait 0.5;
  }

  scripts\cp\crate_drops\cp_crate_drops::ref_12c40(var_1);
}

function ref_144bb() {
  level endon("game_ended");
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("payload_heli_VO1", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("payload_heli_VO2", "script_noteworthy");
  var_2 = scripts\engine\utility::getStruct("payload_heli_VO3", "script_noteworthy");

  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    return;
  }

  while(distance(self.origin, var_0.origin) > 100) {
    wait 0.5;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_apc_pilot_inbound_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_pilot_inbound_20", "allies");

  while(distance(self.origin, var_1.origin) > 100) {
    wait 0.5;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_helo_apc_pilot_status_10", "allies");

  while(distance(self.origin, var_2.origin) > 100) {
    wait 0.5;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_helo_apc_pilot_status_20", "allies");
}

function watchforapcdeath() {
  level endon("game_ended");
  self endon("payload_reached_goal");
  self waittill("death");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var_0.apc_destroyed = 1;
  self playSound("scn_cp_apc_death_exp");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_death_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_apc_mission_failed_10", "allies");
  var_0 notify("payload_apc_destroyed");
  var_0 notify("payload_objective_done");
  var_1 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam(var_0.currentteam));

  if(isDefined(var_1)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "flavor_negative");
  }

  if(!isDefined(level.camper_damage_thread)) {
    level.camper_damage_thread = 0;
  }

  if(level.camper_damage_thread <= 0) {
    scripts\cp\cp_objectives::ref_12868("obj_payload_fail_destroyed");
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    var_0.pathdist = 1;
    return;
  }
}

function apcstop(var_0) {
  var_1 = getdvarfloat("scr_apc_speed", var_0.intro_safehouse_loot);
  var_0 vehicle_setspeedimmediate(0, var_1, var_1);
}

function apcstart(var_0) {
  var_1 = getdvarfloat("scr_apc_speed", var_0.intro_safehouse_loot);
  var_0 resumespeed(var_1);

  if(!istrue(var_0.should_enter_combat_after_checking_throwingknife)) {
    var_0.should_enter_combat_after_checking_throwingknife = 1;
    level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_apc_escort");
    return;
  }
}

function spawnatmines(var_0) {
  var_1 = scripts\engine\utility::getStructArray("payload_mine_loc", "script_noteworthy");
  var_0.atmines = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = "at_mine_mp";
    var_4 = magicgrenademanual(var_3, var_1[var_2].origin + (0, 0, 5), (0, 0, 10));
    var_4.owner = var_4;
    var_4.owner.team = "axis";
    var_4.team = "axis";
    var_0.atmines[var_0.atmines.size] = var_4;
    thread scripts\cp\equipment\cp_at_mine::at_mine_plant(var_4);
    thread watchatminedetonation(var_4);
    thread watchforapctrigger(var_4);
    thread ref_144ad();
    waitframe();
  }
}

function ref_144ad() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  var_0 = [(0, 0, 0), (22, 0, 0), (-22, 0, 0)];
  var_1 = 96;
  var_2 = var_1 * var_1;
  var_3 = 15;

  for(;;) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.instances) && isDefined(level.vehicle.instances["atv"])) {
      foreach(var_5 in level.vehicle.instances["atv"]) {
        if(!isDefined(var_5)) {
          continue;
        }

        if(level.teambased) {
          if(var_5.team == self.owner.team) {
            continue;
          }
        } else if(isDefined(var_5.owner) && var_5.owner == self.owner) {
          continue;
        }

        var_6 = anglestoaxis(var_5.angles);

        foreach(var_8 in var_0) {
          var_9 = var_5.origin;
          var_9 += var_6["right"] * var_8[0];
          var_9 += var_6["forward"] * var_8[1];
          var_9 += var_6["up"] * var_8[2];
          var_10 = self.origin - var_9;
          var_11 = vectordot(var_10, var_6["up"]);

          if(abs(var_11) > var_3) {
            continue;
          }

          var_12 = var_10 - var_6["up"] * var_11;

          if(lengthsquared(var_12) > var_2) {
            continue;
          }

          thread scripts\cp\equipment\cp_at_mine::at_mine_vehicle_trigger(var_5);
          return;
        }
      }
    }

    waitframe();
  }
}

function watchforapctrigger(var_0) {
  level endon("game_ended");
  level endon("obj_payload_completed");
  self endon("death");
  var_0 endon("death");

  for(;;) {
    if(distance(self.origin, var_0.origin) <= 150) {
      thread scripts\cp\equipment\cp_at_mine::at_mine_watch_flight();
      self notify("mine_triggered");
      return;
    }

    wait 1;
  }
}

function watchatminedetonation(var_0) {
  level endon("game_ended");
  level endon("obj_payload_completed");
  var_1 = var_0.apc;
  var_1 endon("death");
  var_2 = scripts\engine\utility::ref_143ad("detonateExplosive", "mine_triggered");
  var_0.atmines = scripts\engine\utility::array_remove(var_0.atmines, self);

  if(!isDefined(var_2)) {
    return;
  }

  if(isDefined(self.topmodel)) {
    self.topmodel delete();
  }

  if(isDefined(var_2) && var_2 == "mine_triggered") {
    wait 1;
  }

  if(distance(self.origin, var_1.origin) <= 300) {
    var_1 notify("payload_hit_by_atmine");
    return;
  }
}

function watchatminehitonpayload(var_0) {
  level endon("game_ended");
  level endon("obj_payload_completed");
  self endon("death");

  for(;;) {
    self waittill("payload_hit_by_atmine");
    var_0.timesapchitbymine++;
    self dodamage(self.maxhealth / 6, (0, 0, 0), undefined, undefined);
    var_0.ispayloadstunned = 1;
    apcstop(self);
    scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_mine_hit_" + randomintrange(1, 4) + "0", "allies");
    thread mayconsiderplayerdead(self);
    wait 2;
    thread waittoresumemovement();
  }
}

function mayconsiderplayerdead(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("resume_movement_after_mine");

  while(isapctooclosetomine()) {
    scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_clear_mines_" + randomintrange(1, 4) + "0", "allies");
    wait 10;
  }
}

function setdamagestate(var_0) {
  if(isDefined(self.isattachmentvariantinvalid) && self.isattachmentvariantinvalid == var_0) {
    return;
  }

  self.isattachmentvariantinvalid = var_0;

  if(!isDefined(self.ref_119e4)) {
    self.ref_119e4 = spawn("script_model", self.origin);
    self.ref_119e4 linkTo(self, "tag_origin");
  }

  switch (var_0) {
    case 1:
    default:
      playFXOnTag(level._effect["vfx_payload_dmg_1"], self, "tag_origin");
      self.ref_119e4 playLoopSound("scn_cp_apc_damage_01_lp");
      break;
    case 2:
      stopFXOnTag(level._effect["vfx_payload_dmg_1"], self, "tag_origin");
      self.ref_119e4 stoploopsound();
      playFXOnTag(level._effect["vfx_payload_dmg_2"], self, "tag_origin");
      self.ref_119e4 playLoopSound("scn_cp_apc_damage_02_lp");
      break;
    case 3:
      stopFXOnTag(level._effect["vfx_payload_dmg_2"], self, "tag_origin");
      self.ref_119e4 stoploopsound();
      playFXOnTag(level._effect["vfx_payload_dmg_3"], self, "tag_origin");
      self.ref_119e4 playLoopSound("scn_cp_apc_damage_03_lp");
      break;
  }
}

function waittoresumemovement() {
  level endon("game_ended");
  self endon("death");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(!isapctooclosetomine()) {
    var_0.ispayloadstunned = 0;
    self notify("resume_movement_after_mine");
    return;
  }

  while(isapctooclosetomine()) {
    wait 2;
  }

  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_engage_" + randomintrange(1, 6) + "0", "allies");
  var_0.ispayloadstunned = 0;
  self notify("resume_movement_after_mine");
}

function isapctooclosetomine() {
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(!isDefined(var_0.atmines) || var_0.atmines.size <= 0) {
    return false;
  }

  var_1 = scripts\engine\utility::getclosest(var_0.apc.origin, var_0.atmines, 1000);

  if(!isDefined(var_1)) {
    return false;
  }

  return distance(var_1.origin, var_0.apc.origin) <= 500;
}

function debugpayloadobjectivesstart(var_0) {
  scripts\engine\utility::flag_set("cp_payloadobjective_cs");
  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "cp_payload_player_start");
}

function isteamplacementsbmmmode(var_0) {
  scripts\engine\utility::flag_set("cp_payloadobjective_cs");
  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_set("cp_morales_cs");
  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "morales_debug_start_loc");
  var_1 = scripts\engine\utility::getStruct("morales_slow_heli_B", "targetname");
  var_0.exfilstruct = var_1;
  var_2 = scripts\engine\utility::getStruct("morales_heli_spawn", "targetname");
  var_3 = scripts\engine\utility::getStruct("morales_heli_trip_start", "targetname");
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var_2, var_0.exfilstruct, var_3, 0);
  level waittill("heli_trip_took_off");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("escort_intro_rpg");
  wait 3;
}

function waitforanyplayersnearpoint(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    foreach(var_3 in level.players) {
      if(distance(var_3.origin, var_0) <= var_1) {
        return;
      }
    }

    wait 0.5;
  }
}

function watchforhelideletion(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_1 = 0;
  var_2 = 10000;

  while(!istrue(var_1)) {
    var_1 = 1;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0.origin) <= var_2) {
        var_1 = 0;
      }
    }

    wait 3;
  }

  level notify("payload_delete_heli");
}

function ref_1364e() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStruct("payload_heli_spawn", "targetname");
  var_1 = scripts\engine\utility::getStruct("payload_heli_landing", "targetname");
  var_2 = scripts\engine\utility::getStruct("payload_armsrace_heli_trip_start", "targetname");
  var_0.script_modelname = "veh8_mil_air_blima_cp";
  var_0.classname_mp = "script_vehicle_iw8_blima";
  var_0.vehicletype = "blima_cp";
  var_0.script_model = "veh8_mil_air_blima";
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var_0, var_1, var_2, 0);
  wait 3;

  if(!isDefined(level.heli_trip_vehicle)) {
    return;
  }

  level.heli_trip_vehicle waittill("started_boarding");
  var_3 = level.heli_trip_vehicle;
  var_4 = scripts\cp\cp_objectives::requestworldid("payload_exfil");
  objective_state(var_4, "current");
  objective_onentity(var_4, var_3);
  objective_icon(var_4, "icon_waypoint_objective_general");
  objective_setlabel(var_4, &"CP_ARMSDEALER/EXFIL_HEADER");
  objective_setshowoncompass(var_4, 1);
  objective_setminimapiconsize(var_4, "icon_regular");
  scripts\cp\cp_objectives::ref_11f80(var_4);
  var_3 waittill("heli_taking_off");
  objective_delete(var_4);
  scripts\cp\cp_objectives::freeworldid("payload_exfil");
}

function spawn_chopper(var_0, var_1) {
  var_2 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.script_disconnectpaths = 0;
  var_2.death_fx_on_self = 1;
  var_2.exfil_struct = var_1;
  var_1.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_1.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_2);
  var_2 scripts\cp\infilexfil\blima_exfil::heli_mg_create();
  var_2.godmode = 1;
  var_2.health = 10000;
  var_2.maxhealth = 10000;
  var_2 scripts\cp\maps\cp_donetsk\cp_donetsk_obj_helidown::spawnhelihvtexfilactors();

  if(isDefined(var_2.wmexfilally)) {
    if(!isDefined(var_2.actors)) {
      var_2.actors = [];
    }

    var_2.actors[var_2.actors.size] = var_2.wmexfilally;
  }

  return var_2;
}

function ref_13609() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStruct("payload_heli_spawn", "targetname");
  var_1 = scripts\engine\utility::getStruct("payload_heli_landing", "targetname");
  var_0.classname_mp = "script_vehicle_apache_east";
  var_0.script_modelname = "veh8_mil_air_ahotel64_ks_east_mp";
  var_0.vehicletype = "veh_apache_cp";
  var_2 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_2.death_fx_on_self = 1;
  var_2.circle_radius = 2500;
  var_2 scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
  var_2.isheli = 1;
  var_2.health = 50000;
  var_2.maxhealth = 50000;
  var_2.team = "allies";
  var_2 setvehicleteam("allies");
  var_2 setmaxpitchroll(15, 15);
  var_2.health_remaining = 2250;
  var_2 sethoverparams(25, 15, 10);
  var_2 setCanDamage(0);
  var_2.exfil_struct = var_1;
  var_2.headicon = deleteheadicon(var_2);
  setheadiconfriendlyimage(var_2.headicon, "hud_icon_head_equipment_friendly");
  setheadiconsnaptoedges(var_2.headicon, 12000);
  setheadiconmaxdistance(var_2.headicon, 1500);
  addclienttoheadiconmask(var_2.headicon, 10);
  setheadicondrawthroughgeo(var_2.headicon, 1);

  if(!isDefined(var_2.exfil_struct.angles)) {
    var_2.exfil_struct.angles = (0, 0, 0);
  }

  var_2.going_to_exfil = 1;
  var_2 vehicle_setspeed(90, 30);
  var_2 setvehgoalpos(var_2.exfil_struct.origin + (0, 0, 800), 1);
  var_2 waittill("goal");
  var_2 vehicle_setspeed(15, 10);
  thread mark_as_bomb_vest_controller_holder(10);
  heli_cleanup_exfil_area(var_2);
  thread skip_player_pos_memory();
  thread watchforhelideletion(level);
  level waittill("payload_delete_heli");
  var_2.minigun makeunusable();
  var_2.minigun maketurretinoperable();

  if(isDefined(var_2.vip)) {
    var_2.vip scripts\cp\cp_pickup_hostage::deletepickuphostage();
  }

  if(isDefined(var_2.minigun)) {
    var_2.minigun delete();
  }

  setheadiconimage(var_2.headicon);
  var_2 delete();
}

function heli_cleanup_exfil_area(var_0) {
  var_0 endon("death");
  level notify("starting_cleanup");
  var_0.minigun setturretteam("allies");
  var_0.minigun setmode("manual");
  var_1 = gettime();
  var_2 = 0;

  for(;;) {
    var_3 = get_nearby_enemy(var_0, var_0.exfil_struct.origin + (0, 0, -150));

    if(!isDefined(var_3)) {
      var_0.minigun cleartargetentity();
      wait 1;
      var_2++;

      if(var_2 >= 5) {
        return;
      }

      continue;
    }

    var_2 = 0;
    var_4 = var_3.origin + (0, 0, 1100);
    var_0.minigun settargetentity(var_3);

    if(distance(var_4, var_0.origin) > 500) {
      var_0 setvehgoalpos(var_4, 1);
    }

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

function skip_player_pos_memory() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("payload_apache_exfil_point", "script_noteworthy");
  var_1 = self;
  var_1 vehicle_setspeed(90, 30);
  var_1 setvehgoalpos(var_0.origin, 1);
}

function get_nearby_enemy(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 25000000;
  }

  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
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

function init_range_targets(var_0) {
  var_1 = spawnturret("misc_turret", var_0 gettagorigin("tag_turret"), "tur_apc_rus_mp", 0);
  var_1.angles = var_0 gettagangles("tag_turret");
  var_1 linkTo(var_0, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_1 setModel("veh8_mil_lnd_vindia_a1_turret_mp");
  var_1 setmode("sentry_offline");
  var_1 setsentryowner(undefined);
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1 setturretmodechangewait(1);
  var_2 = getcompleteweaponname("tur_apc_rus_mp");
  var_1.objweapon = var_2;
  var_1.apc = var_0;
  var_0.intro_spawn_enemies = var_1;
  thread tr_removequestinstance();
  return var_1;
}

function tr_removequestinstance() {
  var_0 = self.origin + (0, 0, 120);
  thread init_bomb_sites(var_0, &"CP_OBJ_PAYLOAD/FIRE_TURRET", self);
}

function init_bomb_sites(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3 setModel("tag_origin");
  var_3 linkTo(var_2);
  var_3 setHintString(var_1);
  var_3 setCursorHint("HINT_BUTTON");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(90);
  var_3 setuserange(72);
  var_3 setusefov(90);
  var_3 sethintonobstruction("show");
  var_3 setuseholdduration("duration_short");
  var_2.intro_spawn_enemies.interaction = var_3;
  thread trial_map(var_3, var_2.intro_spawn_enemies);
  thread interaction_disable_on_exit(var_3);
}

function trial_map(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 endon("payload_reached_goal");

  for(;;) {
    self makeusable();
    self waittill("trigger", var_2);
    self makeunusable();
    var_0 setotherent(var_2);
    var_0 setentityowner(var_2);
    var_0 setsentryowner(var_2);
    var_2 remotecontrolturret(var_0);
    var_2 playerhide();
    var_2 thread scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
    var_0.playerowner = var_2;
    var_2.currentturret = var_0;
    thread ref_12b49(var_0);
    thread endturretusewatch(var_2, var_0);
    thread new_angles(var_2, var_0);
    self waittill("payload_end_turret_use");
    monitor_fronttruck_death(var_2, var_0);
  }
}

function ref_12b49(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("payload_end_turret_use");

  for(;;) {
    self waittill("missile_fire");
    self turretfiredisable();
    wait var_0;
    self turretfireenable();
  }
}

function endturretusewatch(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  self endon("payload_end_turret_use");

  while(var_0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var_0 useButtonPressed()) {
      self notify("payload_end_turret_use");
      break;
    }

    waitframe();
  }
}

function new_angles(var_0, var_1) {
  var_0 scripts\engine\utility::ref_143a6("death", "disconnect", "last_stand");
  self notify("payload_end_turret_use");
}

function monitor_fronttruck_death(var_0, var_1) {
  var_0 remotecontrolturretoff(var_1);

  if(isDefined(var_0)) {
    var_2 = scripts\cp\utility::get_point_in_local_ent_space(var_1, (-20, 0, 10));
    var_0 setOrigin(var_2);
    var_0 setplayerangles(scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0)));
    var_0 thread scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
    var_0 playershow();
    var_0 controlsunlink();
    var_0.currentturret = undefined;
    var_1 setturretdismountorg(var_0.origin);
  }

  var_1.playerowner = undefined;
  var_1 setotherent(undefined);
  var_1 setentityowner(undefined);
  var_1 setsentryowner(undefined);
}

function interaction_disable_on_exit(var_0) {
  level endon("game_ended");
  var_0 scripts\engine\utility::ref_143a5("death", "payload_reached_goal");
  self makeunusable();
}

function ref_14377() {
  level endon("game_ended");
  var_0 = level.players[0];

  for(;;) {
    var_0 waittill("entered_vehicle");
    var_0 controlsunlink();
  }
}

function ref_13535(var_0) {
  var_1 = scripts\engine\utility::getStruct("convoy_start_payload_01", "targetname");
  var_2 = "double-techo-cargo";
  var_3 = "convoy_01";
  thread spawn_convoy(level, var_3, var_2);
}

function ref_135d1(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = "single-techo-cargo";
  var_3 = var_0;
  thread spawn_convoy(level, var_3, var_2);
}

function spawn_convoy(var_0, var_1, var_2) {
  var_3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  thread select_bunker_server_one_spawners();
  thread allow_driver_exit(level);
  var_4 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  level waittill("despawn_" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

function allow_driver_exit(var_0) {
  wait 1;
  var_0 notify("able_to_deposit_driver");
  var_0 scripts\cp\cp_convoy_manager::ref_1307d(0);
}

function select_bunker_server_one_spawners() {
  self.spawned_vehicles[0] endon("death");
  wait 5;
  self.spawned_vehicles[0] waittill("unload_guys");

  foreach(var_1 in self.spawned_vehicles[0].riders) {
    var_1.goalradius = 2048;
  }
}

function ref_138c7() {
  var_0 = getEntArray("trigger_stop_module", "targetname");

  foreach(var_2 in var_0) {
    thread anim_override();
  }
}

function ref_1380b() {
  var_0 = getEntArray("trigger_start_module", "targetname");

  foreach(var_2 in var_0) {
    thread angvels();
  }
}

function anim_override() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  var_1 = strtok(self.script_noteworthy, ",");

  foreach(var_3 in var_1) {
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_3);
  }

  self delete();
}

function angvels() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  var_1 = strtok(self.script_noteworthy, ",");

  if(var_1[0] == "convoy") {
    ref_135d1(var_1[1]);
  } else if(var_1[0] == "wave") {
    level thread scripts\cp\cp_wave_spawning::killstreaks(0, var_1[1]);
  } else {
    foreach(var_3 in var_1) {
      scripts\cp\cp_modular_spawning::run_spawn_module(var_3);
    }
  }

  self delete();
}

function ref_1446e(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  for(;;) {
    var_2 = scripts\cp\utility::get_point_in_local_ent_space(var_0, (128, 0, 0));

    if(trial_time_remaining(var_2, 64)) {
      var_1.turret_objective_think = 1;
      getbankedplunder(var_1.apcwid, 1);
      apcstop(var_0);
    } else {
      var_1.turret_objective_think = 0;
      getbankedplunder(var_1.apcwid, 0);
    }

    wait 1;
  }
}

function trial_time_remaining(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance(var_3.origin, var_0) <= var_1) {
      return true;
    }
  }

  return false;
}

function ref_1445c(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");

  for(;;) {
    if(distance(self.origin, var_1.origin) <= 150) {
      scripts\cp\cp_modular_spawning::run_spawn_module("payload_lasttrek_rpg");
      scripts\cp\cp_modular_spawning::run_spawn_module("payload_lasttrek_sniper");
      level thread scripts\cp\cp_wave_spawning::killstreaks(1, "payload_alleyside");
      break;
    }

    wait 1;
  }
}

function getbankedplunder(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var_2.shot_by_player)) {
    return;
  }

  if(istrue(var_1)) {
    objective_setlabel(var_0, &"CP_OBJ_PAYLOAD/BLOCKED");
    return;
  }

  objective_setlabel(var_0, &"CP_OBJ_PAYLOAD/ESCORT");
}

function ref_13bad(var_0) {
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var_1.apc_destroyed)) {
    return;
  }

  if(var_0) {
    objective_setplayintro(var_1.apcwid, 0);
    objective_state(var_1.apcwid, "current");
    objective_icon(var_1.apcwid, "icon_waypoint_objective_general");
    objective_setzoffset(var_1.apcwid, 64);
    objective_onentity(var_1.apcwid, var_1.apc);
    scripts\cp\cp_objectives::ref_11f80(var_1.apcwid);
    return;
  }

  objective_delete(var_1.apcwid);
}

function c4_crate_use() {
  self endon("death");
  self endon("apc_stop_shooting");
  wait 1;
  var_0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
  var_1 = cos(65);
  var_0.shotsleft = 100000;

  for(;;) {
    var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_2 = sortbydistance(var_2, self.origin);

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }

      if(!scripts\engine\utility::within_fov(self.origin, self.angles, var_4.origin, var_1)) {
        continue;
      }

      if(var_0 turretcantarget(var_4.origin)) {
        var_0 settargetentity(var_4, (0, 0, 40));
      }

      thread c4_crate_update_hint_logic_alt(var_0);
      wait randomfloatrange(1, 3);
      break;
    }

    var_0 cleartargetentity();
    wait 1;
  }
}

function c4_crate_update_hint_logic_alt(var_0) {
  self endon("death");
  var_0 endon("death");
  var_1 = 1;
  var_2 = getcompleteweaponname("tur_apc_rus_mp");
  var_3 = weaponfiretime(var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_0 shootturret();
    wait var_3;
  }
}

function ref_12c39(var_0) {
  wait 1;
  var_0.turrets["tur_apc_rus_mp"] delete();
  var_1 = spawnturret("misc_turret", var_0 gettagorigin("tag_turret"), "tur_apc_rus_ai_cp", 0);
  var_1.angles = var_0 gettagangles("tag_turret");
  var_1 linkTo(var_0, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_1 setModel("veh8_mil_lnd_vindia_a1_turret_mp");
  var_1 setmode("sentry_offline");
  var_1 setsentryowner(undefined);
  var_1.team = "allies";
  var_1 setturretteam("allies");
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1 setturretmodechangewait(1);
  var_1.vehicle = var_0;
  var_0.turrets["tur_apc_rus_mp"] = var_1;
}

function spawn_enemy_tanks() {
  var_0 = scripts\engine\utility::getStructArray("super_tanks", "targetname");
  level.altgunnerturret = "sentry_minigun_mp";
  level.enemy_tanks = [];

  foreach(var_2 in var_0) {
    thread ref_142db();
    thread spawn_enemy_tank(level);
    wait 60;
  }
}

function spawn_enemy_tank(var_0) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_1 = spawnStruct();
  var_2 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "GAME_MODE";
  var_1.owner = undefined;
  var_1.team = "axis";
  var_1.faceawayfromowner = 0;
  var_1.cancapture = 0;
  var_1.cancaptureimmediately = 0;
  var_1.spawnmethod = "airdrop_at_position_unsafe";
  var_1.activateimmediately = 1;
  var_1.cantimeout = 0;
  var_1.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_1);
  var_3 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }

  level notify("enemy_tank", var_3);
  wait 10;
  level.enemy_tanks[level.enemy_tanks.size] = var_3;
  thread tank_waittill_death();
  var_3 endon("death");
  var_3 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_4 = scripts\engine\utility::getStructArray("enemy_tank_path", "targetname");
  var_5 = sortbydistance(var_4, var_3.origin)[0];
  var_6 = build_tank_path(var_5);
  var_7 = build_tank_duration(var_5);
  var_3 startpathnodes(var_6, var_7);
  setheadiconsnaptoedges(var_3.headicon, 8088);
  var_8 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_3, "tur_bradley_mp");
  var_9 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_3, "tur_gun_lighttank_mp");

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var_3);

  for(;;) {
    var_10 = var_3 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var_10)) {
      wait 1;
      continue;
    }

    if(istrue(var_10.binvehicle) && isDefined(var_10.vehicle)) {
      if(var_8 turretcantarget(var_10.vehicle.origin + (0, 0, 50))) {
        var_8 settargetentity(var_10.vehicle, (0, 0, 50));
      }

      if(var_9 turretcantarget(var_10.vehicle.origin + (0, 0, 50))) {
        var_9 settargetentity(var_10.vehicle, (0, 0, 50));
      }
    } else {
      var_8 settargetentity(var_10);
      var_9 settargetentity(var_10);
    }

    thread tank_shoot_at_target(var_3, var_9);
    thread tank_shoot_at_target(var_3);
    wait randomfloatrange(3, 5);
  }
}

function tank_shoot_at_target(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = 1;
  var_3 = getcompleteweaponname("tur_bradley_mp");

  if(istrue(var_1)) {
    var_2 = randomintrange(15, 25);
    var_3 = getcompleteweaponname("tur_gun_lighttank_mp");
  }

  var_4 = weaponfiretime(var_3);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_0 shootturret();
    wait var_4;
  }
}

function build_tank_path(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;

  for(var_1 = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1 = var_2.origin) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }

  return var_1;
}

function build_tank_duration(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;

  for(var_1 = 10; isDefined(var_2) && isDefined(var_2.target); var_1 = 10) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");

    if(isDefined(var_2.duration)) {
      var_1 = int(var_2.duration);
      continue;
    }
  }

  return var_1;
}

function tank_waittill_death() {
  self waittill("death");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
  }

  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
}

function ref_142db() {
  var_0 = ["dx_cps_kama_callout_tank_spawning_10", "dx_cps_kama_callout_tank_spawning_20", "dx_cps_lass_callout_tank_spawning_10", "dx_cps_lass_callout_tank_spawning_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "allies");
}

function ref_13589() {
  thread scripts\cp\cp_aiparachute::request_paratroopers("street_paratroopers", undefined, (-11539.5, -14462, -221.5));
  wait 5;
  scripts\cp\cp_aiparachute::request_paratroopers("lot_paratroopers_1", undefined, (-11539.5, -14462, -221.5));
  thread scripts\cp\cp_aiparachute::request_paratroopers("lot_paratroopers_2", undefined, (-11539.5, -14462, -221.5));
  wait 5;
  scripts\cp\cp_aiparachute::request_paratroopers("lot_paratroopers_3", undefined, (-11539.5, -14462, -221.5));
}

function ref_13979() {
  level endon("stop_paratroopers");
  var_0 = ["super_paratroopers_1", "super_paratroopers_2", "super_paratroopers_3"];

  for(;;) {
    while(level.spawned_ai.size >= 12) {
      wait 1;
    }

    var_1 = scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(var_0), undefined, (-11539.5, -14462, -221.5));

    if(isDefined(var_1) && var_1.size > 0) {
      thread ref_142ec();
    }

    wait randomintrange(15, 30);
  }
}

function ref_11d33() {
  var_0 = spawn("script_model", (-14046.5, 18827.5, -300));
  var_0 setModel("misc_wm_mortar");
  var_1 = scripts\engine\utility::getStructArray("super_mortar_impact_spots", "targetname");
  var_2 = 0;

  for(;;) {
    var_3 = scripts\engine\utility::array_randomize(var_1);

    foreach(var_5 in var_3) {
      var_0 thread scripts\cp\maps\cp_donetsk\milbase\ai_flare::launch_mortar(undefined, var_5.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 0));
      wait randomfloatrange(0.3, 0.75);
    }

    var_2++;

    if(var_2 > 2) {
      break;
    }

    wait randomfloatrange(2, 4);
  }
}

function ref_142ec() {
  if(!isDefined(level.ref_121d5)) {
    level.ref_121d5 = gettime() - 1000;
  }

  if(level.ref_121d5 > gettime()) {
    return;
  }

  var_0 = ["dx_cps_kama_callout_paratrooper_spawning_10", "dx_cps_kama_callout_paratrooper_spawning_20", "dx_cps_lass_callout_paratrooper_spawning_10", "dx_cps_lass_callout_paratrooper_spawning_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "allies");
  level.ref_121d5 = gettime() + 30000;
}

function ref_13976() {
  level waittill("start_super_end_defend");
  thread ref_11f5a();
  thread scripts\cp\cp_objectives::run_objective("payload_destroy_tanks");
  wait 5;
  thread spawn_enemy_tanks();
  wait 30;
  thread ref_11d33();
  thread ref_13979();
}

function ref_11f5a() {
  level endon("game_ended");
  var_0 = undefined;

  for(var_1 = 0;; var_1++) {
    level waittill("enemy_tank", var_2);

    if(!isDefined(var_0)) {
      var_0 = scripts\cp\cp_objectives::requestworldid("enemy_tanks", 15);
      objective_icon(var_0, "icon_waypoint_objective_general");
      objective_setplayintro(var_0, 1);
      objective_setlabel(var_0, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS_OBJ");
    }

    objective_setlocation(var_0, var_1, var_2);
    objective_state(var_0, "current");
    objective_setshowoncompass(var_0, 1);
    objective_setminimapiconsize(var_0, "icon_regular");
    scripts\cp\cp_objectives::ref_11f80(var_0);
    thread ref_1433c(var_2, var_0);
  }
}

function ref_1433c(var_0, var_1) {
  level endon("game_ended");
  self waittill("death");
  objective_unsetlocation(var_0, var_1);

  if(!isDefined(level.ref_13a5a)) {
    level.ref_13a5a = 0;
  }

  level.ref_13a5a++;

  if(level.ref_13a5a >= 2) {
    scripts\engine\utility::flag_set("payload_tanks_killed");
    objective_delete(var_0);
    scripts\cp\cp_objectives::freeworldid("enemy_tanks");
    return;
  }
}