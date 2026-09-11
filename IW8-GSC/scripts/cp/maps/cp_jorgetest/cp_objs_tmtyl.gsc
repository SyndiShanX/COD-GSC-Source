/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_jorgetest\cp_objs_tmtyl.gsc
**********************************************************/

function registertmtylobjective() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_init("tmtyl_finalleader_surrendered");
  init_anims();
  thread registersquadspawners();
  scripts\cp\cp_objectives::registerobjective("obj_tmtyl", &inittmtylobj, &starttmtylobj, &completetmtylobj, undefined, &debugtmtylobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("obj_tmtyl_0", &tr_circletick, &ref_1387a, undefined, undefined, &debugtmtylobjectivesstart);
  scripts\cp\cp_modular_spawning::register_aitype_setup("tmtyl_leader", "actor_enemy_cp_alq_desert_tmtyl_leader", undefined, undefined, undefined, undefined);
}

function registersquadspawners() {
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(!scripts\engine\utility::flag_exist("cp_tmtyl_script_completed")) {
    scripts\engine\utility::flag_init("cp_tmtyl_script_completed");
  }

  if(!scripts\engine\utility::flag_exist("tmtyl_spawn_functions_registered")) {
    scripts\engine\utility::flag_init("tmtyl_spawn_functions_registered");
  }

  scripts\engine\utility::flag_wait("cp_tmtyl_script_completed");
  scripts\cp\coop_stealth::coop_stealth_init();
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("tmtyl_squad_1_leader", 1, 1, 1, 0.5, undefined, "tmtylsquad_1_leader", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_1", 0, 8, 8, 0.5, undefined, "tmtylsquad_1", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_2_leader", 1, 1, 1, 0.5, undefined, "tmtylsquad_2_leader", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_2", 0, 8, 8, 0.5, undefined, "tmtylsquad_2", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_3_leader", 1, 1, 1, 0.5, undefined, "tmtylsquad_3_leader", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_3", 0, 8, 8, 0.5, undefined, "tmtylsquad_3", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_4_leader", 1, 1, 1, 0.5, undefined, "tmtylsquad_4_leader", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_4", 0, 8, 8, 0.5, undefined, "tmtylsquad_4", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_5_leader", 1, 1, 1, 0.5, undefined, "tmtylsquad_5_leader", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_5", 0, 8, 8, 0.5, undefined, "tmtylsquad_5", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_6_leader", 1, 1, 1, 0.5, undefined, "tmtylsquad_6_leader", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_6", 0, 8, 8, 0.5, undefined, "tmtylsquad_6", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_3_bombers", 2, 2, 2, 0.5, undefined, "tmtylsquad_3_bombers", undefined, undefined, undefined);
  [[var_0]]("tmtyl_ambient_6", 0, 7, 10, 0.5, undefined, "tmtyl_ambient_6", &watchforstopambient6waves, &getnextholdoutspawnmodule, undefined);
  [[var_0]]("tmtyl_ambient", 0, 6, 6, 0.5, undefined, "tmtyl_ambient", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("tmtyl_ambient", 750, 2000, 5000, 1);
  [[var_0]]("tmtyl_bldg_rpg", 0, 1, 3, 10, undefined, "tmtyl_bldg_rpg", undefined, undefined, undefined);
  [[var_0]]("tmtyl_bldg_snipers", 0, 2, 4, 8, undefined, "tmtyl_bldg_snipers", undefined, undefined, undefined);
  [[var_0]]("tmtyl_outlook_sniper", 0, 1, 1, 0.5, undefined, "tmtyl_outlook_sniper", undefined, undefined, undefined);
  [[var_0]]("tmtyl_squad_6_heli_leader", 1, 1, 1, 0.5, undefined, "tmtyl_heli_leader");
  [[var_0]]("tmtyl_veh_01", 0, 3, 3, 0.5, undefined, "tmtyl_veh_01");
  [[var_0]]("tmtyl_veh_02", 0, 3, 3, 0.5, undefined, "tmtyl_veh_02");
  [[var_0]]("tmtyl_veh_03", 0, 3, 3, 0.5, undefined, "tmtyl_veh_03");
  [[var_0]]("tmtyl_veh_04", 0, 3, 3, 0.5, undefined, "tmtyl_veh_04");
  [[var_0]]("tmtyl_veh_05", 0, 3, 3, 0.5, undefined, "tmtyl_veh_05");
  [[var_0]]("tmtyl_squad_1_jugg", 1, 1, 1, 0.5, undefined, "tmtyl_squad_1_jugg");
  [[var_0]]("tmtyl_squad_2_jugg", 1, 1, 1, 0.5, undefined, "tmtyl_squad_2_jugg");
  [[var_0]]("tmtyl_squad_3_jugg", 1, 1, 1, 0.5, undefined, "tmtyl_squad_3_jugg");
  [[var_0]]("tmtyl_squad_4_jugg", 1, 1, 1, 0.5, undefined, "tmtyl_squad_4_jugg");
  [[var_0]]("tmtyl_squad_5_jugg", 1, 1, 1, 0.5, undefined, "tmtyl_squad_5_jugg");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_1_leader", &_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_2_leader", &_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_3_leader", &_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_4_leader", &_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_5_leader", &_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_6_leader", &_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_6_heli_leader", &_leaderafterspawnfunc);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_1", &any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_2", &any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_3", &any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_4", &any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_5", &any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_6", &any_enemy_nearby);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_squad_3_bombers", &ref_13ba2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_bldg_snipers", &playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("tmtyl_bldg_snipers", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("tmtyl_bldg_rpg", &playergetspectatingplayer);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("tmtyl_bldg_rpg", undefined, 20000, 30000);
  [[var_0]]("pre_tmtyl_spawning", 0, 24, undefined, 0.1, &unset_pre_wave_spawning, "dwn_twn_patrol_structs_tmtyl", &init_pre_wave_spawning, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("pre_tmtyl_spawning", &scripts\cp\cp_modular_spawning::set_pre_wave_spawning_spawn_funcs);
  scripts\engine\utility::flag_set("tmtyl_spawn_functions_registered");
}

function playergetspectatingplayer(var_0, var_1) {
  self endon("death");
  self.sightmaxdistance = 2200;
  self.is_on_platform = 1;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  var_2 = 500;
  var_3 = 500;

  for(;;) {
    jumpiftrue(istrue(self.entered_combat)) LOC_00000043;
    waitframe();
  }

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(!var_6 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(distancesquared(var_6.origin, self.origin) < var_2 * var_2) {
        var_4 = 1;
      }

      wait 0.5;
    }

    if(var_4) {
      break;
    }

    wait 0.5;
  }

  scripts\cp\cp_modular_spawning::set_goal_radius(var_3);
  self.goalheight = 64;

  for(;;) {
    self.script_origin_other = scripts\cp\utility::get_center_point_of_array(level.players);

    if(istrue(self.entered_combat)) {
      wait 15;
      continue;
    }

    wait 5;
  }
}

function init_pre_wave_spawning(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::stay_passive_if_not_weapons_free);
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::set_aggro_flag_on_enter_combat);
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::watch_for_players, undefined, 1000000, 45);
}

function unset_pre_wave_spawning(var_0) {
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::stay_passive_if_not_weapons_free);
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::set_aggro_flag_on_enter_combat);
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::watch_for_players);
}

function watchforstopambient6waves(var_0) {
  level endon("game_ended");
  thread _watchforstopambient6waves(level);
}

function _watchforstopambient6waves(var_0) {
  level endon("game_ended");
  level waittill("tmtyl_squad_6_complete");
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function getnextholdoutspawnmodule(var_0) {
  if(scripts\engine\utility::flag("tmtyl_finalleader_surrendered")) {
    return undefined;
  }

  for(var_1 = 0; var_0.activecount > 3 && var_1 <= 6; var_1++) {
    wait 1;
  }

  return "tmtyl_ambient_6";
}

function inittmtylinterrogate(var_0) {
  var_1 = spawn("script_model", var_0 gettagorigin("j_chest"));
  var_1 setModel("tag_origin");
  var_1 linkTo(var_0);
  var_1 setHintString(&"CP_OBJ_TMTYL_DIALOGUE/INTERROGATE");
  var_1 setCursorHint("HINT_BUTTON");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(90);
  var_1 setuserange(72);
  var_1 setusefov(90);
  var_1 sethintonobstruction("show");
  var_1 setuseholdduration("duration_none");
  level.ref_13ba3[var_0.leader_index] = var_1;
  var_0.isplayerindanger_think = "spawned";
  thread watchwindowplayerexit();
}

function watchwindowplayerexit() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level.ref_13ba3[self.leader_index] waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player() || istrue(var_0.isjuggernaut)) {
      continue;
    }

    level.ref_13ba3[self.leader_index] makeunusable();

    if(istrue(var_0.has_gl)) {
      var_0 thread scripts\cp\coop_super::remove_launcher_after_timeout(0);
      var_0 waittill("weapon_removed");
    }

    self.isplayerindanger_think = "disabled by interaction think";
    self.isremotekillstreaktabletweapon = "final surrendered";
    self notify("player_started_interaction");
    thread managedropbags(level);
    lastplundereventtype(self.leader_index);
    var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_tmtyl");
    thread doleaderfinalsurrender(level, var_0);
    level thread scripts\cp\utility::ref_123fe("mus_cp_landlord_subdue_" + var_1.numleadersinterrogated);
    var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_tmtyl");
    var_1.leadersinterrogated[self.leader_index] = 1;

    if(var_1.numleadersinterrogated >= 6) {
      scripts\engine\utility::flag_set("tmtyl_finalleader_surrendered");
    }

    break;
  }
}

function managedropbags(var_0) {
  level endon("game_ended");
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_target_interrogate");
}

function tr_circletick(var_0) {
  var_0.customwaypointid = scripts\cp\cp_objectives::requestworldid("tmtylapproach_worldid", 15);
  level thread scripts\cp\utility::ref_123fe("mus_cp_landlord_mission_start");
  objective_setplayintro(var_0.customwaypointid, 0);
  objective_setplayoutro(var_0.customwaypointid, 0);
  objective_state(var_0.customwaypointid, "current");
  objective_setlabel(var_0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/STORE_FRONT");
  objective_icon(var_0.customwaypointid, "cp_tac_waypoint_dont_shoot");
  objective_setbackground(var_0.customwaypointid, 1);
  objective_setshowoncompass(var_0.customwaypointid, 1);
  var_1 = scripts\engine\utility::getStruct("tmtyl_squad_marker_1", "script_noteworthy");
  objective_setlocation(var_0.customwaypointid, 0, var_1.origin);
  var_0 scripts\cp\cp_objectives::ref_1317e(var_0, var_1.origin);
  scripts\cp\cp_objectives::ref_11f80(var_0.customwaypointid);
  scripts\cp\utility::skydivestreamhintdvars("tmtyl");
  level.little_bird_mg_handleflarerecharge = 1;
}

function ref_1387a(var_0) {
  if(!istrue(scripts\engine\utility::flag("cp_tmtyl_script"))) {
    scripts\engine\utility::flag_set("cp_tmtyl_script");
  }

  scripts\engine\utility::flag_wait("tmtyl_spawn_functions_registered");
  var_1 = scripts\engine\utility::getStruct("tmtyl_squad_marker_1", "script_noteworthy");
  scripts\cp\cp_modular_spawning::run_spawn_module("tmtyl_outlook_sniper");
  scripts\cp\cp_objectives::overridenextstep(var_0, "obj_tmtyl");
  scripts\cp\cp_modular_spawning::run_spawn_module("pre_tmtyl_spawning");
  var_2 = 15000;

  if(getdvarint("enable_landlord_player_infil", 0) > 0) {
    var_2 = 10000;
  }

  waitforanyplayersnearpoint(var_1.origin, var_2);
  scripts\cp\cp_objectives::freeworldid("tmtylapproach_worldid");
}

function inittmtylobj(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("cp_tmtyl_script"))) {
    scripts\engine\utility::flag_set("cp_tmtyl_script");
  }

  scripts\engine\utility::flag_wait("cp_tmtyl_script_completed");
  scripts\engine\utility::flag_wait("tmtyl_spawn_functions_registered");
  scripts\engine\utility::flag_set("cp_landlord_create_script");
  scripts\engine\utility::flag_wait("cp_landlord_create_script_completed");
  level.initlocationcircle = "obj_tmtyl";
  level.initlethalmaxoffsetmap = "obj_tmtyl";
  level.tmtyl_vips = [];
  level.ref_13ba4 = [];
  level.ref_13ba3 = [];

  for(var_2 = 1; var_2 <= 6; var_2++) {
    level.ref_13ba4[var_2] = scripts\cp\cp_objectives::requestworldid("tmtyl_vip_objective_" + var_2);
  }

  var_0.customwaypointid = scripts\cp\cp_objectives::requestworldid("tmtyl_worldid", 15);
  var_0.numleadersinterrogated = 0;
  var_0.leadersinterrogated = [];
  var_0.leaderskilledprematurely = 0;

  for(var_2 = 1; var_2 <= 5; var_2++) {
    var_0.leadersinterrogated[var_2] = 0;
  }

  level.tmtyl_customworldid = var_0.customwaypointid;
  objective_setplayintro(var_0.customwaypointid, 0);
  objective_setplayoutro(var_0.customwaypointid, 0);
  objective_state(var_0.customwaypointid, "current");
  objective_setlabel(var_0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/STORE_FRONT");
  objective_icon(var_0.customwaypointid, "icon_waypoint_objective_general");
  objective_setbackground(var_0.customwaypointid, 1);
  objective_setshowoncompass(var_0.customwaypointid, 1);
  scripts\cp\cp_objectives::ref_11f80(var_0.customwaypointid);
  setobjectivemarkerpos(var_0);
}

function starttmtylobj(var_0, var_1) {
  thread ref_1434b();
  scripts\cp\cp_modular_spawning::run_spawn_module("tmtyl_bldg_snipers");
  scripts\cp\cp_modular_spawning::run_spawn_module("tmtyl_bldg_rpg");
  ref_13f67(var_0);
  thread maxxpcap(var_0, 1);
  waitframe();
  thread maxxpcap(var_0, 4);
  thread ref_14351(8);
  level scripts\engine\utility::waittill_all_in_array(["tmtyl_squad_1_complete", "tmtyl_squad_4_complete"]);
  wait 4;
  thread maxxpcap(var_0, 2);
  waitframe();
  thread maxxpcap(var_0, 3);
  level scripts\engine\utility::waittill_all_in_array(["tmtyl_squad_2_complete", "tmtyl_squad_3_complete"]);
  wait 4;
  thread maxxpcap(var_0, 5);
  waitframe();
  thread maxxpcap(var_0, 6);
  level scripts\engine\utility::waittill_all_in_array(["tmtyl_squad_5_complete", "tmtyl_squad_6_complete"]);
  wait 4;

  while(istrue(level.tryweaponswitchnag)) {
    wait 0.5;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_land_tmtyl_leader_capture_5th_10", "allies");
  wait 1;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_leader_capture_5th_20", "allies");
  wait 1;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_tmtyl_leader_capture_5th_30", "allies");
}

function completetmtylobj(var_0) {
  scripts\cp\cp_objectives::freeworldid("tmtyl_worldid");

  for(var_1 = 1; var_1 <= 6; var_1++) {
    scripts\cp\cp_objectives::freeworldid("tmtyl_vip_objective_" + var_1);
  }

  level.tmtyl_vips = undefined;
  level.ref_13ba4 = undefined;
  level.ref_13ba3 = undefined;
  wait 3;
  scripts\mp\brclientmatchdata::getprophealth("tmtyl_p1");
  scripts\cp\cp_objectives::overridenextstep(var_0, "obj_overwatch");
  thread scripts\cp\cp_objectives::screenent_c("major_objective");
  level.little_bird_mg_handleflarerecharge = 0;
}

function ref_1434b() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStruct("tmtyl_squad_marker_1", "script_noteworthy").origin;
  waitforanyplayersnearpoint(var_0, 3000);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_neighborhood_approach_10", "allies");
  var_1 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
  wait level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "ping_response_copy");
}

function maxxpcap(var_0, var_1) {
  thread spawnsquads(var_1);
  level waittill("tmtyl_squad_" + var_1 + "_complete");
}

function ref_14351(var_0) {
  level endon("game_ended");
  wait var_0;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("pre_tmtyl_spawning", 1);
}

function setobjectivemarkerpos(var_0) {
  var_1 = scripts\engine\utility::getStruct("tmtyl_squad_1_leader", "targetname");

  if(isDefined(var_1)) {
    objective_setlocation(var_0.customwaypointid, 0, var_1.origin);
    var_0 scripts\cp\cp_objectives::ref_1317e(var_0, var_1.origin);
    return;
  }
}

function ref_13f67(var_0) {
  objective_delete(var_0.customwaypointid);
}

function any_enemy_nearby(var_0) {
  thread ref_13ba5(var_0);
}

function ref_13ba5(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = self;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  var_1.script_goal_radius = 20;
  self waittill("enter_combat");
  var_1.script_goal_radius = 2000;
  var_1.script_origin_other = var_1.origin;
  var_2 = var_0.group_name[12];
  level waittill("tmtyl_squad_" + var_2 + "_complete");
  var_1.script_origin_other = undefined;
  var_1.script_goal_radius = 512;
  var_1 thread scripts\cp\cp_modular_spawning::set_script_origin_other_to_center_of_players();
}

function _leaderafterspawnfunc(var_0) {
  thread leaderafterspawnfunc(var_0);
}

function leaderafterspawnfunc(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leader_final_surrender");
  var_1 = self;
  var_1.leader_index = int(var_1.enemy_group[12]);
  level.tmtyl_vips[var_1.leader_index] = var_1;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  objective_setplayintro(level.ref_13ba4[var_1.leader_index], 0);
  objective_setplayoutro(level.ref_13ba4[var_1.leader_index], 0);
  objective_state(level.ref_13ba4[var_1.leader_index], "current");
  objective_setlabel(level.ref_13ba4[var_1.leader_index], &"CP_BR_SYRK_OBJECTIVES/STORE_FRONT");
  objective_icon(level.ref_13ba4[var_1.leader_index], "icon_waypoint_objective_general");
  objective_setbackground(level.ref_13ba4[var_1.leader_index], 1);
  objective_setshowoncompass(level.ref_13ba4[var_1.leader_index], 1);
  var_2 = scripts\engine\utility::getStruct("tmtyl_squad_marker_1", "script_noteworthy");
  objective_onentity(level.ref_13ba4[var_1.leader_index], var_1);
  objective_setzoffset(level.ref_13ba4[var_1.leader_index], 70);
  scripts\cp\cp_objectives::ref_11f80(level.ref_13ba4[var_1.leader_index]);
  var_1.a.disablelongdeath = 1;
  var_1.never_kill_off = 1;

  if(isDefined(var_1.unittype) && var_1.unittype != "juggernaut") {
    var_1.maxhealth = 250;
    var_1.health = var_1.maxhealth;
  }

  var_1 scripts\cp\cp_modular_spawning::give_soldier_armor();
  var_1 scripts\cp\cp_modular_spawning::give_soldier_helmet();
  var_1.script_goal_radius = 2000;
  var_1.script_origin_other = var_1.origin;
  var_1.isremotekillstreaktabletweapon = "spawned";
  var_1 thread scripts\cp\cp_squadmanager::removefromsquad();
  thread watchforvipdeath(var_1);

  if(var_1.leader_index == 5) {
    thread ref_14452(var_1);
  }

  if(var_1.leader_index == 3) {
    thread createkillchallengeevent();
    return;
  }
}

function ref_13e07(var_0) {
  var_1 = scripts\engine\utility::getStruct("tmtylsquad_" + var_0 + "_leader", "targetname");

  if(isDefined(var_1)) {
    if(istrue(calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias2d(var_1.origin))) {
      level thread scripts\cp\cp_modular_spawning::run_spawn_module("tmtyl_squad_" + var_0 + "_jugg");
      return;
    }

    return;
  }
}

function ref_14452(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_1 = getEnt("tmtyl_flash_grenade", "targetname");

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    magicgrenademanual("flash_grenade_mp", var_1.origin, (0, 0, 0), 0.2, var_0);
    break;
  }
}

function createkillchallengeevent() {
  level endon("game_ended");
  self endon("death");
  level endon("tmtyl_squad_3_complete");
  self.suicidebomberchants = 0;
  self.ignoreall = 1;
  self.dontevershoot = 1;
  self.scripted_mode = 1;
  waitforanyplayersnearpoint(self.origin, 500, 1);
  self.suicidebomberchants = 1;
  thread scripts\aitypes\suicidebomber\combat::dochants();
  self.ignoreall = 0;
  self.dontevershoot = 0;
  self.scripted_mode = 0;
}

function ref_13ba2(var_0) {
  thread any_alive_player_in_kill_zone_or_under_bridge_zone(var_0);
}

function any_alive_player_in_kill_zone_or_under_bridge_zone(var_0) {
  level endon("game_ended");
  self endon("death");
  self.suicidebomberchants = 0;
  self.ignoreall = 1;
  self.dontevershoot = 1;
  self.scripted_mode = 1;
  waitforanyplayersnearpoint(self.origin, 300, 1);
  self.suicidebomberchants = 1;
  thread scripts\aitypes\suicidebomber\combat::dochants();
  self.ignoreall = 0;
  self.dontevershoot = 0;
  self.scripted_mode = 0;
}

function changeheadicontext(var_0, var_1) {
  switch (var_1) {
    case "melee":
      objective_setlabel(level.ref_13ba4[var_0], "CP_OBJ_TMTYL_DIALOGUE/MELEE");
      break;
    case "incapacitate":
      objective_setlabel(level.ref_13ba4[var_0], "CP_OBJ_TMTYL_DIALOGUE/TIE_DOWN");
      break;
    case "nokill":
    default:
      objective_setlabel(level.ref_13ba4[var_0], "CP_OBJ_TMTYL_DIALOGUE/DONT_KILL");
      break;
  }
}

function lastplundereventtype(var_0) {
  objective_delete(level.ref_13ba4[var_0]);
}

function doleadersurrender(var_0, var_1, var_2) {
  if(isalive(var_2)) {
    var_2.isremotekillstreaktabletweapon = "surrendered";
    var_2 notify("surrendered");
    var_2.scripted_mode = 0;
    var_2.ignoreall = 1;
    var_2.dropweapon = 1;
    var_2 scripts\asm\shared\mp\utility::burndowntime("vip_cp_surrender");
    thread manageparachute(var_2, var_2);
    thread changeheadicontext(var_0, "incapacitate");
    level.ref_13ba3[var_0] makeusable();
    var_2.isplayerindanger_think = "enabled";
    thread loopidlesurrenderanimation(var_2);
    waitframe();
    thread watchfornearfriendliesandrevive();
    return;
  }
}

function manageparachute(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("leader_returned_to_combat");
  var_0 endon("leader_final_surrender");
  wait level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "obj_target_interrogate");

  for(;;) {
    var_2 = scripts\engine\utility::ter_op(randomint(2) > 0, "dx_cps_kama_tmtyl_leader_search_nag_10", "dx_cps_kama_tmtyl_leader_search_nag_20");
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_2, "allies");
    wait 15;
  }
}

function doleaderstun(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1.isremotekillstreaktabletweapon = "stunned";
  var_1.scripted_mode = 0;
  var_1.ignoreall = 1;
  var_1 scripts\asm\shared\mp\utility::burndowntime("vip_cp_melee_stun");
  wait 0.1;
  thread doleaderreturntocombat();
}

function ref_136b9(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("zip_tie_handcuffs_wm");
  var_1.angles = var_0.angles;
  var_0.ziptie = var_1;
  return var_1;
}

#using_animtree("");

function doleaderfinalsurrender(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(level.tmtyl_vips[var_1]) && isalive(level.tmtyl_vips[var_1])) {
    var_2 = level.tmtyl_vips[var_1];
  } else {
    return;
  }

  var_2 endon("death");
  var_2 notify("leader_final_surrender");
  var_2 takeweapon(var_2.weapon);
  var_2.invulnerable = 1;
  var_0.ability_invulnerable = 1;
  var_0.restoreweapon = var_0 getcurrentweapon();
  var_3 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3, undefined, undefined, 1);
  var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 0);
  var_0.gunlessweapon = var_3;
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 setstance("stand");
  var_5 = var_0.angles;
  var_6 = var_0.origin;
  var_0 cameraset("camera_custom_orbit_2_cp");
  var_0 scripts\engine\utility::ref_143b9(1, "weapon_change");
  ref_12da0(var_2, var_0);
  waitframe();
  var_2 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_7 = var_2 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "vip_cp_surrender_end");
  var_8 = var_2 scripts\asm\asm::asm_getxanim("animscripted", var_7);
  thread create_player_rig(var_0, var_0);
  var_2 scripts\common\anim::anim_first_frame_solo(var_0.player_rig, "interrogate");
  link_player_to_rig(var_0);
  var_0.player_rig hide();
  var_9 = getanimlength(%cp_scripted_interrogation_grab_player);
  var_2.scripted_mode = 1;
  var_2.ignoreall = 1;
  var_10 = ref_136b9(var_2);
  var_10 useanimtree($);
  var_10.animname = "ziptie";
  var_11 = spawn("script_origin", var_2.origin);
  var_11.origin = var_2.origin;
  var_11.angles = var_2.angles;
  var_12 = getstartorigin(var_11.origin, var_11.angles, var_8);
  var_13 = getstartangles(var_11.origin, var_11.angles, var_8);
  var_2 dontinterpolate();
  var_2 forceteleport(var_12, var_13);
  var_0 setplayerangles(var_13);
  var_0 setOrigin(var_12);
  var_10.origin = var_12;
  var_10.angles = var_13;
  waitframe();
  thread ref_13bcb(var_0, var_0);
  var_11 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "interrogate");
  var_11 thread scripts\common\anim::anim_single_solo(var_10, "interrogate");
  var_2 aisetanim("animscripted", var_7);
  wait var_9;
  var_0 notify("remove_rig");
  var_0 cameradefault();
  var_0 setplayerangles(var_5);
  var_0 setOrigin(var_6);
  thread ref_13bcb(var_0, var_0);
  var_0 scripts\cp\cp_weapons::_takeweapon(var_3);
  var_0 switchtoweapon(var_0.restoreweapon);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0.ability_invulnerable = undefined;
  thread give_surrendered_intel(level);
  var_2.angles += (0, 180, 0);
  thread loopidlesurrenderanimation(var_2, "vip_cp_surrender_end_idle");
  thread viphud_setupvisibility(var_2);
  thread midtruck();
  level notify("tmtyl_squad_" + var_1 + "_complete");
  var_11 delete();
}

function ref_13bcb(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = spawn("script_model", var_0 gettagorigin("tag_accessory_right"));
    var_2 setModel("electronics_usb_thumb_drive");
    var_2 linkTo(var_0, "tag_accessory_right");
    var_0.ref_14044 = var_2;
    return;
  }

  if(isDefined(var_0.ref_14044)) {
    var_0.ref_14044 delete();
    return;
  }
}

function ref_12da0(var_0, var_1) {
  var_2 = spawn("script_origin", var_0.origin);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_0 linkTo(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_4 = vectortoangles(var_3);
  var_2 rotateTo(var_4, 0.4);
  wait 0.4;
  var_0 unlink();
  var_0 dontinterpolate();
  var_0 forceteleport(var_0.origin, var_4);
  var_2 delete();
}

function viphud_setupvisibility(var_0) {
  level endon("game_ended");
  wait var_0;

  if(isDefined(self.ziptie)) {
    self.ziptie delete();
  }

  if(isalive(self)) {
    self kill();
    return;
  }
}

function give_surrendered_intel(var_0) {
  var_0 endon("death");
  wait 1;
  var_0 scripts\cp\intel\cp_intel::give_intel_weapon("intel_put_usb_in_tablet");
}

function doleaderreturntocombat() {
  scripts\asm\shared\mp\utility::bunkercounteruav();
  self.ignoreall = 0;
  self.entered_combat = 1;
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_tmtyl");
  thread changeheadicontext(self.leader_index, "nokill");
  thread leaderwaitformelee(self.leader_index);
  thread ref_144e4(self.leader_index);
  self notify("leader_returned_to_combat");
  self.isremotekillstreaktabletweapon = "leader_returned_to_combat";
}

function midtruck() {
  level endon("game_ended");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_tmtyl");
  var_0.numleadersinterrogated++;
  var_1 = var_0.numleadersinterrogated;

  while(istrue(level.tryweaponswitchnag) || istrue(level.announcer_vo_playing)) {
    wait 1;
  }

  level.tryweaponswitchnag = 1;

  switch (var_1) {
    case 1:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_leader_capture_1st_10", "allies");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_aqlie_tmtyl_leader_capture_1st_20", "allies");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_leader_capture_1st_30", "allies");
      break;
    case 2:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_aqlie_tmtyl_leader_capture_2nd_10", "allies");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_leader_capture_2nd_20", "allies");
      break;
    case 3:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_aqlie_tmtyl_leader_capture_2nd_10", "allies");
      break;
    case 4:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_leader_capture_2nd_20", "allies");
      break;
    case 5:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_land_tmtyl_leader_capture_3rd_10", "allies");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_leader_capture_3rd_20", "allies");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_tmtyl_leader_capture_3rd_30", "allies");
      break;
    case 6:
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_land_tmtyl_leader_capture_4th_10", "allies");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_tmtyl_leader_capture_4th_20", "allies");
      wait 1;
      level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_tmtyl_leader_capture_4th_30", "allies");
      break;
  }

  level.tryweaponswitchnag = 0;
}

function loopidlesurrenderanimation(var_0, var_1) {
  self endon("death");
  self endon("leader_returned_to_combat");
  self endon("leader_final_surrender");
  var_2 = self;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = scripts\engine\utility::ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
  var_2 scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_3 = var_2 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_0);
  var_4 = var_2 scripts\asm\asm::asm_getxanim("animscripted", var_3);
  var_5 = getanimlength(var_4);
  var_6 = spawn("script_origin", var_2.origin);
  var_6.angles = var_2.angles;
  var_7 = getstartorigin(var_6.origin, var_6.angles, var_4);
  var_8 = getstartangles(var_6.origin, var_6.angles, var_4);
  var_2.anchor.origin = var_7;
  var_2.anchor.angles = var_8;
  var_2 dontinterpolate();
  var_2 forceteleport(var_7, var_8);
  var_2 linkTo(self.anchor);
  var_2.scripted_mode = 0;
  var_2.ignoreall = 1;
  thread ref_144b5();

  for(;;) {
    if(istrue(var_1) && isDefined(var_2.ziptie)) {
      var_9 = var_7;
      var_10 = var_8;
      var_6 thread scripts\common\anim::anim_single_solo(var_2.ziptie, "idle");
    }

    var_2 aisetanim("animscripted", var_3);
    wait var_5;
  }
}

function ref_144b5() {
  level endon("game_ended");
  scripts\engine\utility::ref_143a6("leader_final_surrender", "death", "leader_returned_to_combat");

  if(isDefined(self.anchor)) {
    self.anchor delete();
    return;
  }
}

function watchfornearfriendliesandrevive() {
  self endon("death");
  self endon("leader_returned_to_combat");
  self endon("player_started_interaction");
  self endon("leader_final_surrender");

  for(;;) {
    if(arefriendliesnear()) {
      level.ref_13ba3[self.leader_index] makeunusable();
      self.isplayerindanger_think = "disabled by nearby friendlies";
      doleaderreturntocombat();
    }

    wait 2;
  }
}

function arefriendliesnear() {
  var_0 = 0;
  var_1 = getaiarrayinradius(self.origin, 300, "axis");
  var_1 = scripts\engine\utility::array_remove(var_1, self);

  if(var_1.size > 0) {
    var_0 = 1;
  }

  return var_0;
}

function calloutmarkerpingvo_getfulloperatorvoaliasfromsimplealias2d(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(distance2d(var_3.origin, var_0) <= 400) {
      return true;
    }
  }

  return false;
}

function watchforvipdeath(var_0) {
  level endon("game_ended");
  self endon("leader_final_surrender");
  self waittill("death", var_1);

  if(isDefined(level.tmtyl_customworldid)) {
    objective_unsetlocation(level.tmtyl_customworldid, var_0);
  }

  level.tmtyl_vips[var_0] = undefined;
  level notify("leader_" + var_0 + "_killed");
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_tmtyl");

  if(isDefined(level.ref_13ba3[var_0])) {
    level.ref_13ba3[var_0] makeunusable();
    level.ref_13ba3[var_0] delete();
  }

  lastplundereventtype(var_0);
  thread minigun_tag(var_0);
}

function waittoshameplayer(var_0) {
  level endon("game_ended");
  wait 3;
}

function ref_135f1(var_0) {
  level endon("game_ended");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("tmtyl_veh_0" + var_0);
}

function spawnsquads(var_0) {
  level endon("game_ended");

  if(var_0 == 3) {
    scripts\cp\cp_modular_spawning::run_spawn_module("tmtyl_squad_3_bombers");
  }

  thread ref_13e07(var_0);

  if(var_0 < 6) {
    scripts\cp\cp_modular_spawning::run_spawn_module("tmtyl_veh_0" + var_0);
  }

  wait 1;
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("tmtyl_squad_" + var_0);
  wait 1;
  var_2 = scripts\cp\cp_modular_spawning::run_spawn_module("tmtyl_squad_" + var_0 + "_leader");
}

function ref_144e4(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("surrendered");
  self endon("leader_final_surrender");

  for(;;) {
    if(arefriendliesnear()) {
      thread changeheadicontext(var_0, "nokill");
    } else {
      thread changeheadicontext(var_0, "melee");
    }

    wait 0.5;
  }
}

function leaderwaitformelee(var_0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("melee_hit_on_melee_immune", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(!arefriendliesnear()) {
      thread doleadersurrender(level, var_0, var_1);
      return;
    }

    thread doleaderstun(var_0);
    return;
  }
}

function waitforanyplayersnearpoint(var_0, var_1, var_2) {
  level endon("game_ended");
  jumpiftrue(isDefined(var_2)) LOC_00000013;
  var_2 = 0;

  for(;;) {
    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0) <= var_1) {
        if(istrue(var_2)) {
          if(abs(var_4.origin[2] - var_0[2]) <= 100) {
            return;
          }

          continue;
        }

        return;
      }
    }

    wait 0.5;
  }
}

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  watch_remove_rig(var_0);
  remove_player_rig(var_0);
}

function watch_remove_rig(var_0) {
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setOrigin(var_1);
  } else {
    var_0 setOrigin(var_0.origin + (0, 0, 100));
  }

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function link_player_to_rig(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  var_0 playerlinktoblend(var_0.player_rig, "tag_player", var_1, 0.25, 0.25);
  wait var_1;
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
}

function init_anims() {
  level.scr_animtree["player_interrogator"] = #animtree;
  level.scr_anim["player_interrogator"]["interrogate"] = % cp_scripted_interrogation_grab_player;
  level.scr_eventanim["player_interrogator"]["interrogate"] = "cp_player_interrogate";
  level.scr_animtree["ziptie"] = #animtree;
  level.scr_anim["ziptie"]["interrogate"] = % cp_scripted_interrogation_grab_zip_tag;
  level.scr_animname["ziptie"]["interrogate"] = "cp_scripted_interrogation_grab_zip_tag";
  level.scr_anim["ziptie"]["idle"] = % cp_scripted_interrogation_tied_idle_ziptag;
  level.scr_animname["ziptie"]["idle"] = "cp_scripted_interrogation_tied_idle_ziptag";
}

function debugtmtylobjectivesstart(var_0) {
  scripts\engine\utility::flag_set("cp_tmtyl_script");
  scripts\engine\utility::flag_wait("cp_tmtyl_script_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "obj_tmtyl_debug_start");
}

function istrialslevel(var_0) {
  level endon("game_ended");
  var_0 endon("death");

  for(;;) {
    waitframe();
  }
}

function minigun_tag(var_0) {
  var_1 = spawn("script_model", self.origin + (0, 0, 5));
  var_1 setModel("electronics_usb_thumb_drive");
  var_1.index = var_0;
  waitframe();
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_tmtyl");
  ref_11a99(var_1);
  ref_13a24(var_1);
}

function ref_11a99(var_0) {
  var_1 = &"CP_OBJ_TMTYL_DIALOGUE/INTERROGATE";
  var_0 setHintString(var_1);
  var_0 setCursorHint("HINT_BUTTON");
  var_0 sethintdisplayrange(500);
  var_0 sethintdisplayfov(90);
  var_0 setuserange(128);
  var_0 setusefov(90);
  var_0 sethintonobstruction("hide");
  var_0 setuseholdduration("duration_none");
  var_0 makeusable();
  thread use_think();
  thread ref_11ce8();
  return var_0;
}

function use_think() {
  level endon("game_ended");
  self endon("death");
  self endon("auto_picked_up");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0)) {
      if(!var_0 scripts\cp\utility::is_valid_player() || istrue(var_0.isjuggernaut)) {
        continue;
      }

      if(scripts\cp\cp_weapon::ref_124ad(var_0)) {
        scripts\cp\cp_weapon::minigamefinishcount(var_0);
        continue;
      }

      thread give_surrendered_intel(level);
      thread midtruck();
      level notify("tmtyl_squad_" + self.index + "_complete");
      remove_intel_piece();
    }
  }
}

function ref_11ce8() {
  level endon("game_ended");
  self endon("death");
  self endon("trigger");
  var_0 = 5;
  self.heli_yaw = undefined;

  for(var_1 = 0;; var_1 = 0.5) {
    var_2 = scripts\cp\utility::give_closest_player_nearby(self.origin, 16384, "allies");

    if(!isDefined(var_2) || istrue(var_2.isjuggernaut)) {
      var_1 = 0;
      wait 1;
      continue;
    }

    if(isDefined(self.heli_yaw) && self.heli_yaw == var_2) {
      wait 0.5;
      var_1 += 0.5;

      if(var_1 >= var_0) {
        self notify("auto_picked_up");
        thread give_surrendered_intel(level);
        thread midtruck();
        level notify("tmtyl_squad_" + self.index + "_complete");
        remove_intel_piece();
      }

      continue;
    }

    self.heli_yaw = var_2;
    wait 0.5;
  }
}

function ref_13a24(var_0) {
  var_0.head_icon = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_0.head_icon, "hud_icon_hardpoint_diamond");
  setheadiconsnaptoedges(var_0.head_icon, 0);
  setheadicondrawthroughgeo(var_0.head_icon, 1);
}

function remove_intel_piece() {
  playFX(level._effect["equipment_smoke"], self.origin);

  if(isDefined(self.head_icon)) {
    setheadiconimage(self.head_icon);
  }

  self delete();
}