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

function ref_13868(var0, var1) {
  if(!scripts\engine\utility::flag_exist("payload_tanks_killed")) {
    scripts\engine\utility::flag_init("payload_tanks_killed");
  }

  scripts\engine\utility::flag_wait("payload_tanks_killed");
  thread scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function initpayloadobj(var0, var1) {
  setDvar("QOSTSKSTO", 0);
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
  var0.apcwid = scripts\cp\cp_objectives::requestworldid("apc_obj_wid");
  var2 = scripts\engine\utility::getStruct("payload_obj_start_01", "targetname");
  objective_setplayintro(var0.apcwid, 1);
  objective_state(var0.apcwid, "current");
  objective_icon(var0.apcwid, "icon_waypoint_objective_general");
  objective_setzoffset(var0.apcwid, 64);
  objective_position(var0.apcwid, var2.origin);
  objective_setlabel(var0.apcwid, &"CP_OBJ_PAYLOAD/ESCORT");
  objective_sethot(var0.apcwid, 0);
  var0.ispayloadstunned = 0;
  var0.apc_destroyed = 0;
  thread spawnapc(level);
  var0 waittill("apc_spawned");
  scripts\cp\cp_objectives::ref_11f80(var0.apcwid);
  var0.timesapchitbymine = 0;
  var0.rpgambusherskilled = 0;
  var0.usepingsystem = 0;

  if(getdvarint("scr_payload_no_mines", 0) <= 0) {
    spawnatmines(var0);
    return;
  }
}

function select_top_roof_spawners(var0) {
  thread aigroundturret_shouldbegindismountturret();
}

function aigroundturret_shouldbegindismountturret() {
  self endon("death");
  scripts\engine\utility::waittill_notify_or_timeout("goal", 5);
  wait 1;
  self.goalradius = 512;
  self.goalheight = 48;
}

function ref_12dc2(var0) {
  if(isDefined(self.spawnpoint.script_noteworthy) && self.spawnpoint.script_noteworthy == "rpg") {
    thread ref_132af();
    return;
  }
}

function ref_132af(var0) {
  self endon("death");

  while(!isDefined(level.apc)) {
    wait 1;
  }

  var1 = 122500;
  self waittill("goal");
  self setentitytarget(level.apc);
  self.a.rockets = 100;

  for(;;) {
    var2 = 0;

    foreach(var4 in level.players) {
      if(distancesquared(var4.origin, self.origin) < var1) {
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

function startpayloadobj(var0, var1) {
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
  thread watchatminehitonpayload(var0.apc);
  thread watchforminewarning(var0.apc);
  thread ref_144bb();
  thread watchforpayloadongoal(var0.apc);
  thread ref_144b3(var0.apc, "payload_first_crate");
  thread ref_144b3(var0.apc, "payload_second_crate");
  level waittill("payload_reached_first_cache");
}

function completepayloadobj(var0) {
  scripts\cp\cp_objectives::freeworldid("apc_obj_wid");

  if(istrue(var0.pathdist)) {
    return;
  }

  if(!istrue(var0.apc_destroyed)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_pilot_outro_tank_alive_10", "allies");
  }

  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_apc_done");
}

function ref_13865(var0) {
  if(!istrue(scripts\engine\utility::flag_exist("cp_armsrace_cs_completed"))) {
    scripts\engine\utility::flag_init("cp_armsrace_cs_completed");
  }

  scripts\engine\utility::flag_set("cp_armsrace_cs");
  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  thread ref_1364e();
  level waittill("heli_trip_took_off");
}

function hint_obj_name(var0) {
  wait 4;

  foreach(var2 in level.players) {
    var2 thread scripts\cp_mp\xmike109::screenent_d("paladin");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var2 thread scripts\cp_mp\xmike109::scriptable_callback("paladin_mod");
        continue;
      }

      var2 thread scripts\cp_mp\xmike109::scriptable_callback("paladin_mod_vet");
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
  foreach(var1 in level.players) {
    var1 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var1 in level.players) {
    if(!istrue(var1.try_to_punish_with_jugg)) {
      var1.invulnerable = 1;
      var1 allowmovement(0);
    }

    var4 = scripts\engine\utility::getStruct("cp_payload_endgame_cam", "targetname");
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

function managejumpmasterinfodisplay() {
  level endon("game_ended");
  level scripts\engine\utility::waittill_notify_or_timeout("morales_outro_vo_done", 5);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_seen_10", "allies");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_status_10", "allies");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_status_20", "allies");
}

function ref_13846(var0) {
  level endon("game_ended");
  wait var0;
  scripts\cp\cp_modular_spawning::run_spawn_module("payload_heli_4");
}

function toggle_player_pos_memory(var0, var1) {
  if(!istrue(scripts\engine\utility::flag("cp_payloadobjective_cs"))) {
    scripts\engine\utility::flag_set("cp_payloadobjective_cs");
  }

  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  scripts\engine\utility::flag_wait("payload_spawn_functions_registered");
  scripts\engine\utility::flag_init("payload_punish_completed");
}

function ref_13866(var0, var1) {
  scripts\cp\cp_modular_spawning::run_spawn_module("payload_holdout_left");
  wait 30;
  thread maxplunder();
  wait 40;
  thread ref_13609();
  scripts\engine\utility::flag_set("payload_punish_completed");
  wait 20;
}

function hint_outline_target_think(var0) {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_apc_pilot_outro_tank_dead_10", "allies");
  scripts\cp\cp_objectives::overridenextstep(var0, "obj_armsrace_approach");
  wait 2;
}

function maxplunder() {
  level endon("game_ended");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_helo_apc_pilot_status_15", "allies");
  wait 30;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_helo_apc_pilot_status_25", "allies");
}

function mark_as_bomb_vest_controller_holder(var0) {
  level endon("game_ended");
  wait var0;
  var1 = scripts\engine\utility::getStruct("payload_ai_exfil", "script_noteworthy");
  var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var4 in var2) {
    thread ref_12cd0(var4);
  }
}

function ref_12cd0(var0) {
  level endon("game_ended");
  self endon("death");
  self.goalradius = 64;
  self setgoalpos(var0);
  scripts\engine\utility::waittill_notify_or_timeout("goal", 60);
  self dodamage(self.health + 100, self.origin);
}

function watchforminewarning(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = scripts\engine\utility::getStruct(var0, "script_noteworthy");

  for(;;) {
    if(distance2d(var1.origin, self.origin) <= 200) {
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
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
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

function brclampdamage(var0) {
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(!isDefined(var1.watch_for_players_entering_area_earlier)) {
    var1.watch_for_players_entering_area_earlier = -9999;
  }

  if(gettime() - var1.watch_for_players_entering_area_earlier < 15000) {
    return;
  }

  var2 = "dx_cps_taco_apc_callout_";
  var3 = "";

  switch (var0.group_name) {
    case "payload_stop1_left":
      var3 = "south_";
      break;
    case "payload_stop1_right":
      var3 = "north_";
      break;
    case "payload_stop2_left":
      var3 = "south_";
      break;
    case "payload_stop2_right":
      var3 = "north_";
      break;
    case "payload_stop3_left":
      var3 = "west_";
      break;
    case "payload_stop3_right":
      var3 = "east_";
      break;
    case "payload_stop4_left":
      var3 = "west_";
      break;
    case "payload_stop4_right":
      var3 = "east_";
      break;
    default:
      break;
  }

  var4 = scripts\engine\utility::string(randomintrange(1, 4)) + "0";
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var2 + var3 + var4, "allies");
  var1.watch_for_players_entering_area_earlier = gettime();
}

function getnexthelispawnmodule(var0) {
  level endon("game_ended");
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var1.usepingsystem)) {
    return undefined;
  }

  for(var2 = getaiarray("axis").size; var2 >= 24; var2 = getaiarray("axis").size) {
    wait 6;
  }

  var3 = strtok(var0.group_name, "_");
  var4 = int(var3[var3.size - 1]);
  var4++;

  if(var4 > 8) {
    var4 = 1;
  }

  return "payload_heli_" + var4;
}

function reset_restock_flag(var0) {
  level endon("game_ended");
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var1.usepingsystem)) {
    return undefined;
  }

  wait 5;

  for(var2 = getaiarray("axis").size; var2 > 18; var2 = getaiarray("axis").size) {
    wait 1;
  }

  var3 = strtok(var0.group_name, "_");
  var4 = scripts\engine\utility::ter_op(var3[var3.size - 1] == "left", "right", "left");
  var5 = "";

  for(var6 = 0; var6 <= var3.size - 2; var6++) {
    var5 = var5 + var3[var6] + "_";
  }

  var5 += var4;
  return var5;
}

function reset_target_group(var0) {
  level endon("game_ended");
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var1.usepingsystem)) {
    return undefined;
  }

  for(var2 = 0; var2 <= 5; var2++) {
    wait 1;
  }

  var3 = undefined;

  if(!isDefined(level.ref_11f6a)) {
    level.ref_11f6a = 0;
  }

  switch (var0.group_name) {
    case "payload_rpg_1":
      if(level.ref_11f6a == 1) {
        var3 = "payload_rpg_1";
      }

      break;
    case "payload_rpg_2":
      if(level.ref_11f6a == 2) {
        var3 = "payload_rpg_2";
      }

      break;
    case "payload_rpg_3":
      if(level.ref_11f6a >= 3) {
        var3 = "payload_rpg_3";
      }

      break;
    default:
      var3 = undefined;
      break;
  }

  return var3;
}

function getnextholdoutspawnmodule(var0) {
  if(scripts\engine\utility::flag_exist("payload_punish_completed") && scripts\engine\utility::flag("payload_punish_completed")) {
    return undefined;
  }

  var1 = 0;

  for(var2 = getaiarray("axis").size; var2 > 15 || var1 <= 5; var2 = getaiarray("axis").size) {
    wait 1;
    var1++;
  }

  var3 = undefined;

  switch (var0.group_name) {
    case "payload_holdout_left":
      var3 = "payload_holdout_right";
      break;
    case "payload_holdout_right":
      var3 = "payload_holdout_left";
      break;
    default:
      var3 = undefined;
      break;
  }

  return var3;
}

function ref_1293d(var0) {
  level endon("game_ended");
  self endon("death");
  wait 4;
  thread scripts\cp\cp_modular_spawning::set_script_origin_other_to_center_of_players();
}

function ref_12dcc(var0) {
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var2 = var1.apc;

  if(isDefined(var2)) {
    thread ref_12dcd(var2);
    return;
  }
}

function ref_12dcd(var0) {
  self endon("death");
  var0 endon("death");
  var1 = self;
  var1.goalradius = 1024;
  var1 setgoalpos(var0.origin);
  var1 waittill("goal");
  var1 setentitytarget(var0, 1);
}

function _ambush_rpg_after_spawn(var0) {
  thread ambush_rpg_after_spawn(var0);
  thread watch_for_ambush_rpg_death();
}

function watch_for_ambush_rpg_death() {
  level endon("game_ended");
  var0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  self waittill("death");
  var0.rpgambusherskilled++;
}

function ambush_rpg_after_spawn(var0) {
  level endon("game_ended");
  self endon("death");
  wait 1;

  if(isDefined(self.spawnpoint.target)) {
    var1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
    self.goalradius = 40;

    if(isDefined(var1)) {
      self.ignoreall = 1;
      self setgoalpos(var1.origin);
      self waittill("goal");
      self.ignoreall = 0;
      return;
    }

    return;
  }
}

function _rpg_skit_after_spawn(var0) {
  thread rpg_skit_after_spawn(var0);
}

function rpg_skit_after_spawn(var0) {
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
  var1 = scripts\engine\utility::getStruct("payload_rpg_skit_goto", "script_noteworthy").origin;
  self setgoalpos(var1);

  while(scripts\engine\utility::distance_2d_squared(self.origin, var1) >= 4096) {
    wait 0.5;
  }

  thread watchtofirerocketatpayload(self);
}

function watchtofirerocketatpayload(var0) {
  var0 endon("death");
  var0.rpg_fire_pos = scripts\engine\utility::getStruct("payload_rocket_start", "script_noteworthy").origin;
  fire_rpg_to_payload(var0.rpg_fire_pos, 1);
  var0.dontevershoot = 0;
  var0.ignoreall = 0;
  var0 animmode("normal");
  var0.scripted_mode = 0;
  var0.health = 100;
  var0.maxhealth = 100;
}

function fire_rpg_to_payload(var0, var1, var2) {
  var3 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var4 = var3.apc;

  if(isDefined(var4)) {
    var5 = anglesToForward(var4.angles);
    var6 = var4 vehicle_getspeed();
    var7 = var4.origin + (0, 0, 40) + var5 * var6 * get_forward_scalar(var0, var4, var6);

    if(!var1) {
      if(!isDefined(var2)) {
        var2 = (0, 0, 0);
      }

      var7 += var2;
    }

    var8 = magicbullet("rpg_missile_cp", var0, var7);

    if(var1) {
      var8 missile_settargetEnt(var4);
      var8 missile_setflightmodedirect();
    }

    thread watchforrpgimpact(var8);
    return;
  }
}

function watchforrpgimpact(var0) {
  level endon("game_ended");
  self waittill("death");
  playFXOnTag(level._effect["vfx_payload_dest"], var0, "tag_origin");
  var0 playSound("rocket_explode");
  level notify("apc_hit_by_rpg");
}

function get_forward_scalar(var0, var1, var2) {
  var3 = 1600;
  var4 = 0.47;
  var5 = distance(var0, var1.origin);
  var6 = var5 / var3;
  return var2 * var6 * var4;
}

function watchforambushend() {
  level endon("game_ended");
  var0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var1 = gettime();
  var2 = 0;
  var3 = 30000;

  while(!istrue(var2) && gettime() - var1 <= var3) {
    if(var0.rpgambusherskilled >= 4) {
      var2 = 1;
    }

    wait 0.5;
  }

  level notify("payload_rpg_ambush_killed");
}

function spawnapc(var0) {
  level.convoy_speed_override = 12;
  var1 = scripts\engine\utility::getStruct("payload_obj_start_01", "targetname");
  var2 = "apc-payload-type";
  var3 = "apc_payload";
  var4 = spawnStruct();
  var4.origin = var1.origin;
  var4.angles = var1.angles;
  var4.owner = level.players[0];
  var4.team = var0.currentteam;
  var4.cannotbesuspended = 1;
  var5 = scripts\cp_mp\vehicles\apc_rus::apc_rus_create(var4);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(var5);
  level.apc = var5;
  wait 2;
  var0.apc = var5;
  var6 = var1;
  var5.pathing_array = [];
  var5.pathing_array[0] = var6.origin;
  ref_12c39(var5);
  thread c4_crate_use();

  while(isDefined(var6.target)) {
    var6 = scripts\engine\utility::getStruct(var6.target, "targetname");
    var5.pathing_array[var5.pathing_array.size] = var6.origin;
  }

  var5.health = 30000;
  var5.ref_13bf2 = 30000;
  var5.ref_11e7d = 80;
  var5.little_bird_mg_enterend = 1;
  var7 = [];
  var8 = var5.pathing_array.size;
  var9 = undefined;
  var10 = var1.origin;
  var5.intro_safehouse_loot = scripts\engine\utility::ter_op(getdvarfloat("scr_payload_speed", 0) > 0, getdvarfloat("scr_payload_speed", 0), 2);

  for(var11 = 0; var11 < var8; var11++) {
    if(isDefined(var5.pathing_array[var11 + 1])) {
      var9 = var5.pathing_array[var11 + 1];
    }

    var12 = scripts\cp\cp_vehicles::get_duration_between_points(var10, var9, var5.intro_safehouse_loot, 1);
    var7 = min(var12, 20);
    var10 = var9;
  }

  var5 setlookaheadtime(0.2);
  var5 startpathnodes(var5.pathing_array, var7);
  var5.veh_pathtype = "constrained";
  var0 notify("apc_spawned");
  thread ref_144ac();
  thread watchforapcdeath();
  thread ref_144be();
  thread ref_1446e(var5);
  objective_setplayintro(var0.apcwid, 0);
  objective_state(var0.apcwid, "current");
  objective_icon(var0.apcwid, "icon_waypoint_objective_general");
  objective_setzoffset(var0.apcwid, 64);
  objective_onentity(var0.apcwid, var5);
  apcstop(var5);
}

function ref_144be() {
  level endon("game_ended");
  self endon("death");
  self endon("apc_reached_goal");
  var0 = self;

  for(;;) {
    wait 2;
    var0 connectpaths();
    waitframe();
    var0 disconnectPaths();
  }
}

function ref_144ac() {
  level endon("game_ended");
  self endon("death");
  var0 = self;

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15);

    if(isDefined(var10) && isDefined(var10.basename) && var10.basename == "tur_apc_rus_ai_cp") {
      self.health += var1;
      continue;
    }

    var1 = setup_soldier_stealth(var10, var5, var1);
    thread losqueuelow(var0);
    var16 = var0.health / var0.ref_13bf2 * 100;

    if(var16 <= 75) {
      var17 = 1;

      if(var16 <= 50) {
        var17 = 2;
      }

      if(var16 <= 25) {
        var17 = 3;
      }

      thread setdamagestate(var0);
    }
  }
}

function setup_soldier_stealth(var0, var1, var2) {
  var3 = var2;

  if(!isDefined(var0)) {
    return var2;
  }

  switch (var0.basename) {
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "ac130_25mm_mp":
      var3 /= 4;
      break;
  }

  return var3;
}

function losqueuelow(var0) {
  var1 = self;

  if(!isDefined(self.watch_for_players_activating_juggmaze_map)) {
    var1.watch_for_players_activating_juggmaze_map = -9999;
  }

  if(gettime() - var1.watch_for_players_activating_juggmaze_map < 15000) {
    return;
  }

  var2 = var1.health / var1.ref_13bf2 * 100;

  if(var2 <= var1.ref_11e7d) {
    if(var1.ref_11e7d >= 60) {
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_health_" + var1.ref_11e7d + "_10", "allies");
    } else if(var1.ref_11e7d <= 0) {
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_status_00_10", "allies");
    } else {
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_status_" + var1.ref_11e7d + "_10", "allies");
    }

    if(!isDefined(var1)) {
      return;
    }

    var1.ref_11e7d = max(var1.ref_11e7d - 20, 0);
    self.watch_for_players_activating_juggmaze_map = gettime();
    return;
  }

  if(isDefined(var0) && var0.classname == "rocketlauncher") {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_rpg_hit_" + randomintrange(1, 4) + "0", "allies");
    self.watch_for_players_activating_juggmaze_map = gettime();
    return;
  }
}

function watchforplayerproximity(var0, var1) {
  level endon("game_ended");
  var1 endon("payload_apc_destroyed");
  var2 = var1.apc;
  var2 endon("payload_reached_goal");
  var2 endon("death");
  var3 = "stopped";
  var4 = "";

  while(!istrue(var1.apc_destroyed)) {
    if(istrue(var1.ispayloadstunned) || istrue(var1.updatebotpersonalitybasedonweapon) || istrue(var1.turret_objective_think)) {
      var4 = "";
      wait 2;
      continue;
    }

    var5 = scripts\cp\utility::getplayersinteam(var0);
    var6 = 0;

    foreach(var8 in var5) {
      if(distance(var8.origin, var2.origin) <= 512) {
        var6++;
      }
    }

    if(var6 > 0 || istrue(var1.updateassassinationthreatlevel)) {
      var3 = "moving";
    } else {
      var3 = "stopped";
    }

    if(var3 != var4) {
      var4 = var3;

      if(var3 == "moving") {
        thread apcstart(level);
      } else {
        thread apcstop(level);
      }
    }

    wait 1;
  }
}

function ref_14462(var0) {
  level endon("game_ended");
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var2 = scripts\engine\utility::getStruct("payload_do_cache_1", "script_noteworthy");

  if(getdvarint("scr_skip_to_cache", 0) <= 0) {
    while(isDefined(var0) && distance(var0.origin, var2.origin) > 100) {
      wait 0.5;
    }
  }

  if(istrue(var1.apc_destroyed)) {
    return;
  }

  var1.shot_by_player = 1;
  var1.updatebotpersonalitybasedonweapon = 1;
  apcstop(var0);
  thread ref_13bad(0);
  var3 = getdvarint("scr_skip_to_cache", 0);
  level notify("payload_reached_first_cache");

  if(var3 <= 1) {
    level scripts\cp\maps\cp_armsrace\armsrace_objective\cp_armsrace_objective::docache1();
  }

  wait 1;

  if(!istrue(var1.apc_destroyed)) {
    thread ref_11d90(var0);
  }

  if(var3 <= 2) {
    level scripts\cp\maps\cp_armsrace\armsrace_objective\cp_armsrace_objective::docache2();
  }

  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("apc_escort_3");

  if(var3 <= 3) {
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

function ref_11d90(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = scripts\engine\utility::getStruct("payload_goal_while_cache2", "script_noteworthy").origin;
  level waittill("armsrace_cache2_activated");
  self notify("apc_stop_shooting");
  var0.updateassassinationthreatlevel = 1;
  var0.updatebotpersonalitybasedonweapon = 0;

  while(distance(self.origin, var1) > 100) {
    wait 0.5;
  }

  var0.updateassassinationthreatlevel = 0;
  apcstop(self);
}

function watchforpayloadspawngroup(var0, var1, var2) {
  level endon("game_ended");
  self endon("death");
  var3 = scripts\engine\utility::getStruct(var0, "script_noteworthy").origin;

  while(distance(self.origin, var3) > 100) {
    wait 0.5;
  }

  if(var0 == "payload_paratroopers") {
    thread ref_13589();
  }

  if(isDefined(var1)) {
    if(isarray(var1)) {
      foreach(var5 in var1) {
        scripts\cp\cp_modular_spawning::run_spawn_module(var5);
        waitframe();
      }
    } else {
      scripts\cp\cp_modular_spawning::run_spawn_module(var1);
    }
  }

  if(isDefined(var2)) {
    if(isarray(var2)) {
      foreach(var8 in var2) {
        scripts\cp\cp_modular_spawning::stop_module_by_groupname(var8);
        waitframe();
      }

      return;
    }

    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var2);
    return;
  }
}

function ref_144c8(var0, var1) {
  level endon("game_ended");
  self endon("death");
  var2 = scripts\engine\utility::getStruct(var0, "script_noteworthy").origin;

  while(distance(self.origin, var2) > 100) {
    wait 0.5;
  }

  level thread scripts\cp\cp_wave_spawning::killstreaks(0.5, var1);
}

function watchforpayloadconvoygroup(var0, var1, var2, var3) {
  level endon("game_ended");
  self endon("death");
  var4 = scripts\engine\utility::getStruct(var0, "script_noteworthy").origin;

  while(distance(self.origin, var4) > 100) {
    wait 0.5;
  }

  start_convoy(var1, var2, var3);
}

function ref_144c7(var0, var1, var2, var3) {
  level endon("game_ended");
  self endon("death");
  var4 = scripts\engine\utility::getStruct(var0, "script_noteworthy").origin;
  var5 = scripts\engine\utility::getStruct(var1, "script_noteworthy").origin;
  var6 = scripts\engine\utility::getStruct(var2, "script_noteworthy").origin;
  var7 = scripts\engine\utility::getStruct(var3, "script_noteworthy").origin;
  level.ref_11f6a = 0;

  while(distance(self.origin, var4) > 100) {
    wait 0.5;
  }

  level.ref_11f6a = 1;

  while(distance(self.origin, var5) > 100) {
    wait 0.5;
  }

  level.ref_11f6a = 2;

  while(distance(self.origin, var6) > 100) {
    wait 0.5;
  }

  level.ref_11f6a = 3;

  while(distance(self.origin, var7) > 100) {
    wait 0.5;
  }

  level.ref_11f6a = 4;
}

function watchforrpgambush(var0, var1, var2) {
  level endon("game_ended");
  self endon("death");
  self endon("payload_reached_goal");
  var3 = scripts\engine\utility::getStruct(var0, "script_noteworthy").origin;

  while(distance(self.origin, var3) > 100) {
    wait 0.5;
  }

  var2.ispayloadstunned = 1;
  apcstop(self);
  scripts\cp\cp_modular_spawning::run_spawn_module(var1);
  scripts\cp\cp_modular_spawning::run_spawn_module("payload_ambush_spawners");
  thread maxpools();
  thread watchforambushend();
  level scripts\engine\utility::waittill_notify_or_timeout_return("payload_rpg_ambush_killed", 30);
  scripts\cp\cp_modular_spawning::stop_module_by_id("payload_ambush_spawners");
  var2.ispayloadstunned = 0;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_near_goal_10", "allies");
}

function maxpools() {
  level endon("game_ended");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_ambush_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_clear_rpg_30", "allies");
  var0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));

  if(isDefined(var0)) {
    wait scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_sitrep_wave_start");
    return;
  }
}

function start_convoy(var0, var1, var2) {
  var3 = scripts\engine\utility::getStruct(var1, "targetname");
  var4 = var2;
  thread set_convoy_settings(level, var0, var4);
}

function set_convoy_settings(var0, var1, var2) {
  level endon("game_ended");
  var3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var4 = level[[var3]](var0, var1, var2);
  wait 1;
  var4 notify("able_to_deposit_driver");
  var4 scripts\cp\cp_convoy_manager::ref_1307d(0);
  level waittill("despawn_" + var0);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);

  if(var0 == "payload_convoy_1") {
    thread vehomn_fadeoutcontrols();
    return;
  }
}

function vehomn_fadeoutcontrols() {
  level endon("game_ended");
  self waittill("death");
  level thread scripts\cp\utility::ref_123fe("");
}

function watchforpayloadongoal(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = scripts\engine\utility::getStruct(var0, "script_noteworthy").origin;

  while(distance(self.origin, var1) > 100) {
    wait 0.5;
  }

  var2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var2.updateassassinationthreatlevel = 0;
  var2.usepingsystem = 1;
  self notify("payload_reached_goal");
  waitframe();
  thread apcstop(var2);
  var2 notify("payload_objective_done");
  var3 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam(var2.currentteam));

  if(isDefined(var3)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var3, "flavor_closecall");
    return;
  }
}

function ref_144b3(var0, var1) {
  level endon("game_ended");
  self endon("death");
  var2 = scripts\engine\utility::getStruct(var0, "script_noteworthy").origin;

  while(distance(self.origin, var2) > 100) {
    wait 0.5;
  }

  scripts\cp\crate_drops\cp_crate_drops::ref_12c40(var1);
}

function ref_144bb() {
  level endon("game_ended");
  self endon("death");
  var0 = scripts\engine\utility::getStruct("payload_heli_VO1", "script_noteworthy");
  var1 = scripts\engine\utility::getStruct("payload_heli_VO2", "script_noteworthy");
  var2 = scripts\engine\utility::getStruct("payload_heli_VO3", "script_noteworthy");

  if(!isDefined(var0) || !isDefined(var1) || !isDefined(var2)) {
    return;
  }

  while(distance(self.origin, var0.origin) > 100) {
    wait 0.5;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_apc_pilot_inbound_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_pilot_inbound_20", "allies");

  while(distance(self.origin, var1.origin) > 100) {
    wait 0.5;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_helo_apc_pilot_status_10", "allies");

  while(distance(self.origin, var2.origin) > 100) {
    wait 0.5;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_helo_apc_pilot_status_20", "allies");
}

function watchforapcdeath() {
  level endon("game_ended");
  self endon("payload_reached_goal");
  self waittill("death");
  var0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
  var0.apc_destroyed = 1;
  self playSound("scn_cp_apc_death_exp");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_tank_death_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_apc_mission_failed_10", "allies");
  var0 notify("payload_apc_destroyed");
  var0 notify("payload_objective_done");
  var1 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam(var0.currentteam));

  if(isDefined(var1)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "flavor_negative");
  }

  if(!isDefined(level.camper_damage_thread)) {
    level.camper_damage_thread = 0;
  }

  if(level.camper_damage_thread <= 0) {
    scripts\cp\cp_objectives::ref_12868("obj_payload_fail_destroyed");
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    var0.pathdist = 1;
    return;
  }
}

function apcstop(var0) {
  var1 = getdvarfloat("scr_apc_speed", var0.intro_safehouse_loot);
  var0 vehicle_setspeedimmediate(0, var1, var1);
}

function apcstart(var0) {
  var1 = getdvarfloat("scr_apc_speed", var0.intro_safehouse_loot);
  var0 resumespeed(var1);

  if(!istrue(var0.should_enter_combat_after_checking_throwingknife)) {
    var0.should_enter_combat_after_checking_throwingknife = 1;
    level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_apc_escort");
    return;
  }
}

function spawnatmines(var0) {
  var1 = scripts\engine\utility::getStructArray("payload_mine_loc", "script_noteworthy");
  var0.atmines = [];

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = "at_mine_mp";
    var4 = magicgrenademanual(var3, var1[var2].origin + (0, 0, 5), (0, 0, 10));
    var4.owner = var4;
    var4.owner.team = "axis";
    var4.team = "axis";
    var0.atmines[var0.atmines.size] = var4;
    thread scripts\cp\equipment\cp_at_mine::at_mine_plant(var4);
    thread watchatminedetonation(var4);
    thread watchforapctrigger(var4);
    thread ref_144ad();
    waitframe();
  }
}

function ref_144ad() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  var0 = [(0, 0, 0), (22, 0, 0), (-22, 0, 0)];
  var1 = 96;
  var2 = var1 * var1;
  var3 = 15;

  for(;;) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.instances) && isDefined(level.vehicle.instances["atv"])) {
      foreach(var5 in level.vehicle.instances["atv"]) {
        if(!isDefined(var5)) {
          continue;
        }

        if(level.teambased) {
          if(var5.team == self.owner.team) {
            continue;
          }
        } else if(isDefined(var5.owner) && var5.owner == self.owner) {
          continue;
        }

        var6 = anglestoaxis(var5.angles);

        foreach(var8 in var0) {
          var9 = var5.origin;
          var9 += var6["right"] * var8[0];
          var9 += var6["forward"] * var8[1];
          var9 += var6["up"] * var8[2];
          var10 = self.origin - var9;
          var11 = vectordot(var10, var6["up"]);

          if(abs(var11) > var3) {
            continue;
          }

          var12 = var10 - var6["up"] * var11;

          if(lengthsquared(var12) > var2) {
            continue;
          }

          thread scripts\cp\equipment\cp_at_mine::at_mine_vehicle_trigger(var5);
          return;
        }
      }
    }

    waitframe();
  }
}

function watchforapctrigger(var0) {
  level endon("game_ended");
  level endon("obj_payload_completed");
  self endon("death");
  var0 endon("death");

  for(;;) {
    if(distance(self.origin, var0.origin) <= 150) {
      thread scripts\cp\equipment\cp_at_mine::at_mine_watch_flight();
      self notify("mine_triggered");
      return;
    }

    wait 1;
  }
}

function watchatminedetonation(var0) {
  level endon("game_ended");
  level endon("obj_payload_completed");
  var1 = var0.apc;
  var1 endon("death");
  var2 = scripts\engine\utility::ref_143ad("detonateExplosive", "mine_triggered");
  var0.atmines = scripts\engine\utility::array_remove(var0.atmines, self);

  if(!isDefined(var2)) {
    return;
  }

  if(isDefined(self.topmodel)) {
    self.topmodel delete();
  }

  if(isDefined(var2) && var2 == "mine_triggered") {
    wait 1;
  }

  if(distance(self.origin, var1.origin) <= 300) {
    var1 notify("payload_hit_by_atmine");
    return;
  }
}

function watchatminehitonpayload(var0) {
  level endon("game_ended");
  level endon("obj_payload_completed");
  self endon("death");

  for(;;) {
    self waittill("payload_hit_by_atmine");
    var0.timesapchitbymine++;
    self dodamage(self.maxhealth / 6, (0, 0, 0), undefined, undefined);
    var0.ispayloadstunned = 1;
    apcstop(self);
    scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_mine_hit_" + randomintrange(1, 4) + "0", "allies");
    thread mayconsiderplayerdead(self);
    wait 2;
    thread waittoresumemovement();
  }
}

function mayconsiderplayerdead(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("resume_movement_after_mine");

  while(isapctooclosetomine()) {
    scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_clear_mines_" + randomintrange(1, 4) + "0", "allies");
    wait 10;
  }
}

function setdamagestate(var0) {
  if(isDefined(self.isattachmentvariantinvalid) && self.isattachmentvariantinvalid == var0) {
    return;
  }

  self.isattachmentvariantinvalid = var0;

  if(!isDefined(self.ref_119e4)) {
    self.ref_119e4 = spawn("script_model", self.origin);
    self.ref_119e4 linkTo(self, "tag_origin");
  }

  switch (var0) {
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
  var0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(!isapctooclosetomine()) {
    var0.ispayloadstunned = 0;
    self notify("resume_movement_after_mine");
    return;
  }

  while(isapctooclosetomine()) {
    wait 2;
  }

  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_taco_apc_engage_" + randomintrange(1, 6) + "0", "allies");
  var0.ispayloadstunned = 0;
  self notify("resume_movement_after_mine");
}

function isapctooclosetomine() {
  var0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(!isDefined(var0.atmines) || var0.atmines.size <= 0) {
    return false;
  }

  var1 = scripts\engine\utility::getclosest(var0.apc.origin, var0.atmines, 1000);

  if(!isDefined(var1)) {
    return false;
  }

  return distance(var1.origin, var0.apc.origin) <= 500;
}

function debugpayloadobjectivesstart(var0) {
  scripts\engine\utility::flag_set("cp_payloadobjective_cs");
  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "cp_payload_player_start");
}

function isteamplacementsbmmmode(var0) {
  scripts\engine\utility::flag_set("cp_payloadobjective_cs");
  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_set("cp_morales_cs");
  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "morales_debug_start_loc");
  var1 = scripts\engine\utility::getStruct("morales_slow_heli_B", "targetname");
  var0.exfilstruct = var1;
  var2 = scripts\engine\utility::getStruct("morales_heli_spawn", "targetname");
  var3 = scripts\engine\utility::getStruct("morales_heli_trip_start", "targetname");
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var2, var0.exfilstruct, var3, 0);
  level waittill("heli_trip_took_off");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("escort_intro_rpg");
  wait 3;
}

function waitforanyplayersnearpoint(var0, var1) {
  level endon("game_ended");

  for(;;) {
    foreach(var3 in level.players) {
      if(distance(var3.origin, var0) <= var1) {
        return;
      }
    }

    wait 0.5;
  }
}

function watchforhelideletion(var0) {
  level endon("game_ended");
  var0 endon("death");
  var1 = 0;
  var2 = 10000;

  while(!istrue(var1)) {
    var1 = 1;

    foreach(var4 in level.players) {
      if(distance(var4.origin, var0.origin) <= var2) {
        var1 = 0;
      }
    }

    wait 3;
  }

  level notify("payload_delete_heli");
}

function ref_1364e() {
  level endon("game_ended");
  var0 = scripts\engine\utility::getStruct("payload_heli_spawn", "targetname");
  var1 = scripts\engine\utility::getStruct("payload_heli_landing", "targetname");
  var2 = scripts\engine\utility::getStruct("payload_armsrace_heli_trip_start", "targetname");
  var0.script_modelname = "veh8_mil_air_blima_cp";
  var0.classname_mp = "script_vehicle_iw8_blima";
  var0.vehicletype = "blima_cp";
  var0.script_model = "veh8_mil_air_blima";
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var0, var1, var2, 0);
  wait 3;

  if(!isDefined(level.heli_trip_vehicle)) {
    return;
  }

  level.heli_trip_vehicle waittill("started_boarding");
  var3 = level.heli_trip_vehicle;
  var4 = scripts\cp\cp_objectives::requestworldid("payload_exfil");
  objective_state(var4, "current");
  objective_onentity(var4, var3);
  objective_icon(var4, "icon_waypoint_objective_general");
  objective_setlabel(var4, &"CP_ARMSDEALER/EXFIL_HEADER");
  objective_setshowoncompass(var4, 1);
  objective_setminimapiconsize(var4, "icon_regular");
  scripts\cp\cp_objectives::ref_11f80(var4);
  var3 waittill("heli_taking_off");
  objective_delete(var4);
  scripts\cp\cp_objectives::freeworldid("payload_exfil");
}

function spawn_chopper(var0, var1) {
  var2 = scripts\common\vehicle::vehicle_spawn(var0);
  var2.vehicle_skipdeathmodel = 1;
  var2.script_disconnectpaths = 0;
  var2.death_fx_on_self = 1;
  var2.exfil_struct = var1;
  var1.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var1.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var2);
  var2 scripts\cp\infilexfil\blima_exfil::heli_mg_create();
  var2.godmode = 1;
  var2.health = 10000;
  var2.maxhealth = 10000;
  var2 scripts\cp\maps\cp_donetsk\cp_donetsk_obj_helidown::spawnhelihvtexfilactors();

  if(isDefined(var2.wmexfilally)) {
    if(!isDefined(var2.actors)) {
      var2.actors = [];
    }

    var2.actors[var2.actors.size] = var2.wmexfilally;
  }

  return var2;
}

function ref_13609() {
  level endon("game_ended");
  var0 = scripts\engine\utility::getStruct("payload_heli_spawn", "targetname");
  var1 = scripts\engine\utility::getStruct("payload_heli_landing", "targetname");
  var0.classname_mp = "script_vehicle_apache_east";
  var0.script_modelname = "veh8_mil_air_ahotel64_ks_east_mp";
  var0.vehicletype = "veh_apache_cp";
  var2 = scripts\common\vehicle::vehicle_spawn(var0);
  var2.death_fx_on_self = 1;
  var2.circle_radius = 2500;
  var2 scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
  var2.isheli = 1;
  var2.health = 50000;
  var2.maxhealth = 50000;
  var2.team = "allies";
  var2 setvehicleteam("allies");
  var2 setmaxpitchroll(15, 15);
  var2.health_remaining = 2250;
  var2 sethoverparams(25, 15, 10);
  var2 setCanDamage(0);
  var2.exfil_struct = var1;
  var2.headicon = deleteheadicon(var2);
  setheadiconfriendlyimage(var2.headicon, "hud_icon_head_equipment_friendly");
  setheadiconsnaptoedges(var2.headicon, 12000);
  setheadiconmaxdistance(var2.headicon, 1500);
  addclienttoheadiconmask(var2.headicon, 10);
  setheadicondrawthroughgeo(var2.headicon, 1);

  if(!isDefined(var2.exfil_struct.angles)) {
    var2.exfil_struct.angles = (0, 0, 0);
  }

  var2.going_to_exfil = 1;
  var2 vehicle_setspeed(90, 30);
  var2 setvehgoalpos(var2.exfil_struct.origin + (0, 0, 800), 1);
  var2 waittill("goal");
  var2 vehicle_setspeed(15, 10);
  thread mark_as_bomb_vest_controller_holder(10);
  heli_cleanup_exfil_area(var2);
  thread skip_player_pos_memory();
  thread watchforhelideletion(level);
  level waittill("payload_delete_heli");
  var2.minigun makeunusable();
  var2.minigun maketurretinoperable();

  if(isDefined(var2.vip)) {
    var2.vip scripts\cp\cp_pickup_hostage::deletepickuphostage();
  }

  if(isDefined(var2.minigun)) {
    var2.minigun delete();
  }

  setheadiconimage(var2.headicon);
  var2 delete();
}

function heli_cleanup_exfil_area(var0) {
  var0 endon("death");
  level notify("starting_cleanup");
  var0.minigun setturretteam("allies");
  var0.minigun setmode("manual");
  var1 = gettime();
  var2 = 0;

  for(;;) {
    var3 = get_nearby_enemy(var0, var0.exfil_struct.origin + (0, 0, -150));

    if(!isDefined(var3)) {
      var0.minigun cleartargetentity();
      wait 1;
      var2++;

      if(var2 >= 5) {
        return;
      }

      continue;
    }

    var2 = 0;
    var4 = var3.origin + (0, 0, 1100);
    var0.minigun settargetentity(var3);

    if(distance(var4, var0.origin) > 500) {
      var0 setvehgoalpos(var4, 1);
    }

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

function skip_player_pos_memory() {
  self endon("death");
  var0 = scripts\engine\utility::getStruct("payload_apache_exfil_point", "script_noteworthy");
  var1 = self;
  var1 vehicle_setspeed(90, 30);
  var1 setvehgoalpos(var0.origin, 1);
}

function get_nearby_enemy(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 25000000;
  }

  var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
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

function init_range_targets(var0) {
  var1 = spawnturret("misc_turret", var0 gettagorigin("tag_turret"), "tur_apc_rus_mp", 0);
  var1.angles = var0 gettagangles("tag_turret");
  var1 linkTo(var0, "tag_turret", (0, 0, 0), (0, 0, 0));
  var1 setModel("veh8_mil_lnd_vindia_a1_turret_mp");
  var1 setmode("sentry_offline");
  var1 setsentryowner(undefined);
  var1 makeunusable();
  var1 setdefaultdroppitch(0);
  var1 setturretmodechangewait(1);
  var2 = getcompleteweaponname("tur_apc_rus_mp");
  var1.objweapon = var2;
  var1.apc = var0;
  var0.intro_spawn_enemies = var1;
  thread tr_removequestinstance();
  return var1;
}

function tr_removequestinstance() {
  var0 = self.origin + (0, 0, 120);
  thread init_bomb_sites(var0, &"CP_OBJ_PAYLOAD/FIRE_TURRET", self);
}

function init_bomb_sites(var0, var1, var2) {
  var3 = spawn("script_model", var0);
  var3 setModel("tag_origin");
  var3 linkTo(var2);
  var3 setHintString(var1);
  var3 setCursorHint("HINT_BUTTON");
  var3 sethintdisplayrange(200);
  var3 sethintdisplayfov(90);
  var3 setuserange(72);
  var3 setusefov(90);
  var3 sethintonobstruction("show");
  var3 setuseholdduration("duration_short");
  var2.intro_spawn_enemies.interaction = var3;
  thread trial_map(var3, var2.intro_spawn_enemies);
  thread interaction_disable_on_exit(var3);
}

function trial_map(var0, var1) {
  level endon("game_ended");
  var1 endon("death");
  var1 endon("payload_reached_goal");

  for(;;) {
    self makeusable();
    self waittill("trigger", var2);
    self makeunusable();
    var0 setotherent(var2);
    var0 setentityowner(var2);
    var0 setsentryowner(var2);
    var2 remotecontrolturret(var0);
    var2 playerhide();
    var2 thread scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
    var0.playerowner = var2;
    var2.currentturret = var0;
    thread ref_12b49(var0);
    thread endturretusewatch(var2, var0);
    thread new_angles(var2, var0);
    self waittill("payload_end_turret_use");
    monitor_fronttruck_death(var2, var0);
  }
}

function ref_12b49(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("payload_end_turret_use");

  for(;;) {
    self waittill("missile_fire");
    self turretfiredisable();
    wait var0;
    self turretfireenable();
  }
}

function endturretusewatch(var0, var1) {
  var0 endon("death");
  var0 endon("last_stand");
  var0 endon("disconnect");
  self endon("payload_end_turret_use");

  while(var0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var0 useButtonPressed()) {
      self notify("payload_end_turret_use");
      break;
    }

    waitframe();
  }
}

function new_angles(var0, var1) {
  var0 scripts\engine\utility::ref_143a6("death", "disconnect", "last_stand");
  self notify("payload_end_turret_use");
}

function monitor_fronttruck_death(var0, var1) {
  var0 remotecontrolturretoff(var1);

  if(isDefined(var0)) {
    var2 = scripts\cp\utility::get_point_in_local_ent_space(var1, (-20, 0, 10));
    var0 setOrigin(var2);
    var0 setplayerangles(scripts\engine\utility::ter_op(isDefined(var1.angles), var1.angles, (0, 0, 0)));
    var0 thread scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
    var0 playershow();
    var0 controlsunlink();
    var0.currentturret = undefined;
    var1 setturretdismountorg(var0.origin);
  }

  var1.playerowner = undefined;
  var1 setotherent(undefined);
  var1 setentityowner(undefined);
  var1 setsentryowner(undefined);
}

function interaction_disable_on_exit(var0) {
  level endon("game_ended");
  var0 scripts\engine\utility::ref_143a5("death", "payload_reached_goal");
  self makeunusable();
}

function ref_14377() {
  level endon("game_ended");
  var0 = level.players[0];

  for(;;) {
    var0 waittill("entered_vehicle");
    var0 controlsunlink();
  }
}

function ref_13535(var0) {
  var1 = scripts\engine\utility::getStruct("convoy_start_payload_01", "targetname");
  var2 = "double-techo-cargo";
  var3 = "convoy_01";
  thread spawn_convoy(level, var3, var2);
}

function ref_135d1(var0) {
  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  var2 = "single-techo-cargo";
  var3 = var0;
  thread spawn_convoy(level, var3, var2);
}

function spawn_convoy(var0, var1, var2) {
  var3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var4 = level[[var3]](var0, var1, var2);
  thread select_bunker_server_one_spawners();
  thread allow_driver_exit(level);
  var4 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  level waittill("despawn_" + var0);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

function allow_driver_exit(var0) {
  wait 1;
  var0 notify("able_to_deposit_driver");
  var0 scripts\cp\cp_convoy_manager::ref_1307d(0);
}

function select_bunker_server_one_spawners() {
  self.spawned_vehicles[0] endon("death");
  wait 5;
  self.spawned_vehicles[0] waittill("unload_guys");

  foreach(var1 in self.spawned_vehicles[0].riders) {
    var1.goalradius = 2048;
  }
}

function ref_138c7() {
  var0 = getEntArray("trigger_stop_module", "targetname");

  foreach(var2 in var0) {
    thread anim_override();
  }
}

function ref_1380b() {
  var0 = getEntArray("trigger_start_module", "targetname");

  foreach(var2 in var0) {
    thread angvels();
  }
}

function anim_override() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  var1 = strtok(self.script_noteworthy, ",");

  foreach(var3 in var1) {
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var3);
  }

  self delete();
}

function angvels() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  var1 = strtok(self.script_noteworthy, ",");

  if(var1[0] == "convoy") {
    ref_135d1(var1[1]);
  } else if(var1[0] == "wave") {
    level thread scripts\cp\cp_wave_spawning::killstreaks(0, var1[1]);
  } else {
    foreach(var3 in var1) {
      scripts\cp\cp_modular_spawning::run_spawn_module(var3);
    }
  }

  self delete();
}

function ref_1446e(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  for(;;) {
    var2 = scripts\cp\utility::get_point_in_local_ent_space(var0, (128, 0, 0));

    if(trial_time_remaining(var2, 64)) {
      var1.turret_objective_think = 1;
      getbankedplunder(var1.apcwid, 1);
      apcstop(var0);
    } else {
      var1.turret_objective_think = 0;
      getbankedplunder(var1.apcwid, 0);
    }

    wait 1;
  }
}

function trial_time_remaining(var0, var1) {
  foreach(var3 in level.players) {
    if(distance(var3.origin, var0) <= var1) {
      return true;
    }
  }

  return false;
}

function ref_1445c(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = scripts\engine\utility::getStruct(var0, "script_noteworthy");

  for(;;) {
    if(distance(self.origin, var1.origin) <= 150) {
      scripts\cp\cp_modular_spawning::run_spawn_module("payload_lasttrek_rpg");
      scripts\cp\cp_modular_spawning::run_spawn_module("payload_lasttrek_sniper");
      level thread scripts\cp\cp_wave_spawning::killstreaks(1, "payload_alleyside");
      break;
    }

    wait 1;
  }
}

function getbankedplunder(var0, var1) {
  var2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var2.shot_by_player)) {
    return;
  }

  if(istrue(var1)) {
    objective_setlabel(var0, &"CP_OBJ_PAYLOAD/BLOCKED");
    return;
  }

  objective_setlabel(var0, &"CP_OBJ_PAYLOAD/ESCORT");
}

function ref_13bad(var0) {
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");

  if(istrue(var1.apc_destroyed)) {
    return;
  }

  if(var0) {
    objective_setplayintro(var1.apcwid, 0);
    objective_state(var1.apcwid, "current");
    objective_icon(var1.apcwid, "icon_waypoint_objective_general");
    objective_setzoffset(var1.apcwid, 64);
    objective_onentity(var1.apcwid, var1.apc);
    scripts\cp\cp_objectives::ref_11f80(var1.apcwid);
    return;
  }

  objective_delete(var1.apcwid);
}

function c4_crate_use() {
  self endon("death");
  self endon("apc_stop_shooting");
  wait 1;
  var0 = scripts\cp_mp\vehicles\vehicle::ref_14192(self, "tur_apc_rus_mp");
  var1 = cos(65);
  var0.shotsleft = 100000;

  for(;;) {
    var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var2 = sortbydistance(var2, self.origin);

    foreach(var4 in var2) {
      if(!isDefined(var4)) {
        continue;
      }

      if(!scripts\engine\utility::within_fov(self.origin, self.angles, var4.origin, var1)) {
        continue;
      }

      if(var0 turretcantarget(var4.origin)) {
        var0 settargetentity(var4, (0, 0, 40));
      }

      thread c4_crate_update_hint_logic_alt(var0);
      wait randomfloatrange(1, 3);
      break;
    }

    var0 cleartargetentity();
    wait 1;
  }
}

function c4_crate_update_hint_logic_alt(var0) {
  self endon("death");
  var0 endon("death");
  var1 = 1;
  var2 = getcompleteweaponname("tur_apc_rus_mp");
  var3 = weaponfiretime(var2);

  for(var4 = 0; var4 < var1; var4++) {
    var0 shootturret();
    wait var3;
  }
}

function ref_12c39(var0) {
  wait 1;
  var0.turrets["tur_apc_rus_mp"] delete();
  var1 = spawnturret("misc_turret", var0 gettagorigin("tag_turret"), "tur_apc_rus_ai_cp", 0);
  var1.angles = var0 gettagangles("tag_turret");
  var1 linkTo(var0, "tag_turret", (0, 0, 0), (0, 0, 0));
  var1 setModel("veh8_mil_lnd_vindia_a1_turret_mp");
  var1 setmode("sentry_offline");
  var1 setsentryowner(undefined);
  var1.team = "allies";
  var1 setturretteam("allies");
  var1 makeunusable();
  var1 setdefaultdroppitch(0);
  var1 setturretmodechangewait(1);
  var1.vehicle = var0;
  var0.turrets["tur_apc_rus_mp"] = var1;
}

function spawn_enemy_tanks() {
  var0 = scripts\engine\utility::getStructArray("super_tanks", "targetname");
  level.altgunnerturret = "sentry_minigun_mp";
  level.enemy_tanks = [];

  foreach(var2 in var0) {
    thread ref_142db();
    thread spawn_enemy_tank(level);
    wait 60;
  }
}

function spawn_enemy_tank(var0) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var1 = spawnStruct();
  var2 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.spawntype = "GAME_MODE";
  var1.owner = undefined;
  var1.team = "axis";
  var1.faceawayfromowner = 0;
  var1.cancapture = 0;
  var1.cancaptureimmediately = 0;
  var1.spawnmethod = "airdrop_at_position_unsafe";
  var1.activateimmediately = 1;
  var1.cantimeout = 0;
  var1.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var1);
  var3 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var1, var2);

  if(!isDefined(var3)) {
    return;
  }

  level notify("enemy_tank", var3);
  wait 10;
  level.enemy_tanks[level.enemy_tanks.size] = var3;
  thread tank_waittill_death();
  var3 endon("death");
  var3 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var4 = scripts\engine\utility::getStructArray("enemy_tank_path", "targetname");
  var5 = sortbydistance(var4, var3.origin)[0];
  var6 = build_tank_path(var5);
  var7 = build_tank_duration(var5);
  var3 startpathnodes(var6, var7);
  setheadiconsnaptoedges(var3.headicon, 8088);
  var8 = scripts\cp_mp\vehicles\vehicle::ref_14192(var3, "tur_bradley_mp");
  var9 = scripts\cp_mp\vehicles\vehicle::ref_14192(var3, "tur_gun_lighttank_mp");

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var3);

  for(;;) {
    var10 = var3 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var10)) {
      wait 1;
      continue;
    }

    if(istrue(var10.binvehicle) && isDefined(var10.vehicle)) {
      if(var8 turretcantarget(var10.vehicle.origin + (0, 0, 50))) {
        var8 settargetentity(var10.vehicle, (0, 0, 50));
      }

      if(var9 turretcantarget(var10.vehicle.origin + (0, 0, 50))) {
        var9 settargetentity(var10.vehicle, (0, 0, 50));
      }
    } else {
      var8 settargetentity(var10);
      var9 settargetentity(var10);
    }

    thread tank_shoot_at_target(var3, var9);
    thread tank_shoot_at_target(var3);
    wait randomfloatrange(3, 5);
  }
}

function tank_shoot_at_target(var0, var1) {
  self endon("death");
  var0 endon("death");
  var2 = 1;
  var3 = getcompleteweaponname("tur_bradley_mp");

  if(istrue(var1)) {
    var2 = randomintrange(15, 25);
    var3 = getcompleteweaponname("tur_gun_lighttank_mp");
  }

  var4 = weaponfiretime(var3);

  for(var5 = 0; var5 < var2; var5++) {
    var0 shootturret();
    wait var4;
  }
}

function build_tank_path(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = var2.origin; isDefined(var2) && isDefined(var2.target); var1 = var2.origin) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function build_tank_duration(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = 10; isDefined(var2) && isDefined(var2.target); var1 = 10) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");

    if(isDefined(var2.duration)) {
      var1 = int(var2.duration);
      continue;
    }
  }

  return var1;
}

function tank_waittill_death() {
  self waittill("death");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
  }

  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
}

function ref_142db() {
  var0 = ["dx_cps_kama_callout_tank_spawning_10", "dx_cps_kama_callout_tank_spawning_20", "dx_cps_lass_callout_tank_spawning_10", "dx_cps_lass_callout_tank_spawning_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var0), "allies");
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
  var0 = ["super_paratroopers_1", "super_paratroopers_2", "super_paratroopers_3"];

  for(;;) {
    while(level.spawned_ai.size >= 12) {
      wait 1;
    }

    var1 = scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(var0), undefined, (-11539.5, -14462, -221.5));

    if(isDefined(var1) && var1.size > 0) {
      thread ref_142ec();
    }

    wait randomintrange(15, 30);
  }
}

function ref_11d33() {
  var0 = spawn("script_model", (-14046.5, 18827.5, -300));
  var0 setModel("misc_wm_mortar");
  var1 = scripts\engine\utility::getStructArray("super_mortar_impact_spots", "targetname");
  var2 = 0;

  for(;;) {
    var3 = scripts\engine\utility::array_randomize(var1);

    foreach(var5 in var3) {
      var0 thread scripts\cp\maps\cp_donetsk\milbase\ai_flare::launch_mortar(undefined, var5.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 0));
      wait randomfloatrange(0.3, 0.75);
    }

    var2++;

    if(var2 > 2) {
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

  var0 = ["dx_cps_kama_callout_paratrooper_spawning_10", "dx_cps_kama_callout_paratrooper_spawning_20", "dx_cps_lass_callout_paratrooper_spawning_10", "dx_cps_lass_callout_paratrooper_spawning_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var0), "allies");
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
  var0 = undefined;

  for(var1 = 0;; var1++) {
    level waittill("enemy_tank", var2);

    if(!isDefined(var0)) {
      var0 = scripts\cp\cp_objectives::requestworldid("enemy_tanks", 15);
      objective_icon(var0, "icon_waypoint_objective_general");
      objective_setplayintro(var0, 1);
      objective_setlabel(var0, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS_OBJ");
    }

    objective_setlocation(var0, var1, var2);
    objective_state(var0, "current");
    objective_setshowoncompass(var0, 1);
    objective_setminimapiconsize(var0, "icon_regular");
    scripts\cp\cp_objectives::ref_11f80(var0);
    thread ref_1433c(var2, var0);
  }
}

function ref_1433c(var0, var1) {
  level endon("game_ended");
  self waittill("death");
  objective_unsetlocation(var0, var1);

  if(!isDefined(level.ref_13a5a)) {
    level.ref_13a5a = 0;
  }

  level.ref_13a5a++;

  if(level.ref_13a5a >= 2) {
    scripts\engine\utility::flag_set("payload_tanks_killed");
    objective_delete(var0);
    scripts\cp\cp_objectives::freeworldid("enemy_tanks");
    return;
  }
}