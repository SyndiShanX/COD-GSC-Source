/************************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_armsrace\armsrace_objective\cp_armsrace_objective.gsc
************************************************************************************/

function ref_12B0E() {
  level._effect["vfx_armsrace_smoke"] = loadfx("vfx/iw8_cp/vfx_cp_smoke_gren_loop.vfx");
}

function registerobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(!scripts\engine\utility::flag_exist("armsrace_spawn_functions_registered")) {
    scripts\engine\utility::flag_init("armsrace_spawn_functions_registered");
  }

  if(!scripts\engine\utility::flag_exist("armsrace_interactions_initted")) {
    scripts\engine\utility::flag_init("armsrace_interactions_initted");
  }

  scripts\cp\cp_remote_tank::init_remote_tank();
  scripts\cp\cp_objectives::registerobjective("obj_armsrace_approach", undefined, &ref_13832, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj_armsrace", &initarmsraceobj, &startarmsraceobj, &completearmsraceobj, undefined, &debugarmsraceobjectivestart);
  scripts\cp\cp_objectives::registerobjective("obj_armsrace_defend1", undefined, &ref_13833, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj_armsrace_defend2", undefined, &ref_13834, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj_armsrace_defend3", undefined, &ref_13835, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj_armsrace_defend4", undefined, &ref_13836, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj_armsrace_open_crate", undefined, &ref_13837, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("obj_payload_return", undefined, &ref_13867, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("obj_armsrace_defend1", &force_kill_off_other_ai);
  thread registerinteractions();
  initobjspawners();
}

function force_kill_off_other_ai(var_0) {
  self endon("death");
  level endon("game_ended");
  self.goalradius = 512;
}

function registerinteractions() {
  level endon("game_ended");

  if(!istrue(scripts\engine\utility::flag_exist("cp_armsrace_cs_completed"))) {
    scripts\engine\utility::flag_init("cp_armsrace_cs_completed");
  }

  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  thread initarms1();
  thread initarms2();
  thread initnuke();
  scripts\engine\utility::flag_set("armsrace_interactions_initted");
}

function prevcallback(var_0) {
  return scripts\engine\utility::getStruct("armsrace_interaction_" + var_0, "script_noteworthy").origin;
}

function managejumpmasterinfodisplay() {
  level endon("game_ended");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_brief_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_brief_20", "allies");
  var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));

  if(isDefined(var_0)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "conv_generic_affirm");
    return;
  }
}

function ref_13832(var_0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_intro_10", "allies");
  thread losqueuelowindex();
  var_1 = scripts\engine\utility::getStruct("armsrace_cache_1", "script_noteworthy").origin;
  waitforoneplayernearpoint(var_1, 25000);
  start_convoy("convoy_start_beginning_1", "convoy_start_beginning_1", "single-empty");
  start_convoy("convoy_start_beginning_2", "convoy_start_beginning_2", "single-empty");
  level notify("entered_armsrace_area");
  waitforoneplayernearpoint(var_1, 5000);
  scripts\cp\cp_objectives::overridenextstep(var_0, "obj_armsrace");
}

function ref_13867(var_0) {
  level waittill("returned_to_payload");
}

function ref_13833(var_0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  level waittill("armsrace_cache_secured");
}

function ref_13834(var_0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  level waittill("armsrace_cache_secured");
}

function ref_13835(var_0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  level waittill("armsrace_cache_secured");
}

function ref_13836(var_0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  level waittill("armsrace_cache_secured");
}

function ref_13837(var_0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  level waittill("armsrace_cache_opened");
}

function initarmsraceobj(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("cp_armsrace_cs"))) {
    scripts\engine\utility::flag_set("cp_armsrace_cs");
  }

  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\utility::skydivestreamhintdvars("armsrace");
  teamhasfreshsquadleadercandidate();
  var_0.cachewid = scripts\cp\cp_objectives::requestworldid("armsrace_cacheWID");
}

function startarmsraceobj(var_0, var_1) {
  scripts\cp\utility::objective_update("obj_armsrace", undefined, undefined, undefined, undefined, 0);
  setnewarmsracecacheloc(1);
  managejumpmasterinfodisplay();
  waitforoneplayernearpoint(var_0.curcachelocation, 1000);
  scripts\cp\cp_objectives::overridenextstep(var_0, "safehouse_armsdealer_return");
}

function docache1() {
  if(!istrue(scripts\engine\utility::flag("cp_armsrace_cs"))) {
    scripts\engine\utility::flag_set("cp_armsrace_cs");
  }

  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");

  if(!isDefined(level.camper_damage_thread)) {
    level.camper_damage_thread = 0;
  }

  var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));

  if(isDefined(var_0)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_sitrep_wave_start");
  }

  level notify("armsrace_activate_interaction_1");
  thread scripts\cp\cp_objectives::run_objective("obj_armsrace_defend1");
  waitforoneplayernearpoint(prevcallback(1), 500);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_1st_obj_10", "allies");
  level thread scripts\cp\utility::ref_123FE("mus_cp_armsrace_cache_1");
  level waittill("armsrace_cache1_activated");
  thread loothide(level);
  thread mp_m_overunder_patch(level);
  thread start_convoy("convoy_01", "convoy_start_01");
  wait 1;
  level thread scripts\cp\utility::ref_123FE("mus_cp_armsrace_reinforcements_1");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_1st_obj_defend_10", "allies");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase1");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase1_sniper");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase1_sniper_2");
  level thread scripts\cp\cp_wave_spawning::killstreaks(2, "armsrace_cache1");
  level thread scripts\cp\cp_wave_spawning::killstreaks(60, "armsrace_cache1_2");
  thread camera_loadout_showcase_preview_sticker_alt4("armsrace_c4_planter_parking", 3, "obj_armsrace_defend1_timer_complete");
  level thread scripts\cp\utility::objective_update("obj_armsrace_defend1", 120, 30, 10, 1);
  wait 60;
  thread dosmokecurtains(level, "armsrace_smoke_bomb_1");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase1_lasers");
  level waittill("obj_armsrace_defend1_timer_complete");
  level thread scripts\cp\utility::objective_update("obj_armsrace_defend1");
  wait 1;
  level notify("armsrace_cache_secured");
  level.camper_damage_thread++;
  level notify("stop_armsrace_smoke");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_1st_obj_complete_10", "allies");
  level thread scripts\cp\utility::ref_123FE("mus_cp_armsrace_cache_2");
}

function mp_m_overunder_patch(var_0) {
  level endon("game_ended");
  var_1 = 5;
  var_2 = max(var_1, 120 - var_0);
  wait var_2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
}

function loothide(var_0) {
  level endon("game_ended");
  var_1 = 10;
  var_2 = max(var_1, 120 - var_0);
  level scripts\engine\utility::ref_143BA(var_2, "obj_armsrace_defend1_timer_complete", "armsrace_cache_secured");
  var_3 = getEnt("super_store_trig", "targetname");
  thread ref_1447E();
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase_hold");
  level waittill("armsrace_player_entering_super");
  thread set_guy_to_specific_pos(level);
  level waittill("armsrace_cache2_activated");
  thread scripts\cp\cp_modular_spawning::stop_module_by_groupname("armsrace_phase_hold");
}

function ref_1447E() {
  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0) && isPlayer(var_0)) {
      break;
    }
  }

  level notify("armsrace_player_entering_super");
}

function docache2() {
  if(!istrue(scripts\engine\utility::flag("cp_armsrace_cs"))) {
    scripts\engine\utility::flag_set("cp_armsrace_cs");
  }

  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");

  if(!isDefined(level.camper_damage_thread)) {
    level.camper_damage_thread = 0;
  }

  level notify("armsrace_activate_interaction_2");
  thread scripts\cp\cp_objectives::run_objective("obj_armsrace_defend2");
  waitforoneplayernearpoint(prevcallback(2), 500);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_2nd_obj_10", "allies");
  level waittill("armsrace_cache2_activated");
  wait 1;
  thread dosmokecurtains(level, "armsrace_smoke_bomb_2");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_2nd_obj_defend_10", "allies");
  level thread scripts\cp\utility::ref_123FE("mus_cp_armsrace_reinforcements_2");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase2");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase2_lasers");
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("wave_spawning", undefined, 20000, 30000);
  level thread scripts\cp\cp_wave_spawning::killstreaks(2, "armsrace_cache2");
  level thread scripts\cp\cp_wave_spawning::killstreaks(60, "armsrace_cache2_2");
  thread camera_loadout_showcase_preview_sticker_alt4("armsrace_c4_planter_super", 3, "obj_armsrace_defend2_timer_complete");
  level thread scripts\cp\utility::objective_update("obj_armsrace_defend2", 120, 30, 10, 1);
  level waittill("obj_armsrace_defend2_timer_complete");
  level thread scripts\cp\utility::objective_update("obj_armsrace_defend2");
  wait 1;
  level notify("armsrace_cache_secured");
  level.camper_damage_thread++;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
  level notify("stop_armsrace_smoke");
  level thread scripts\cp\utility::ref_123FE("mus_cp_armsrace_cache_3");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_2nd_obj_complete_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_2nd_obj_complete_20", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_2nd_obj_complete_30", "allies");
}

function camera_loadout_showcase_preview_sticker_alt4(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    level endon(var_2);
  }

  if(!isDefined(var_1)) {
    var_1 = 3;
  }

  var_3 = 120 / (var_1 + 1);

  for(;;) {
    thread scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
    wait var_3;
  }
}

function docache3(var_0) {
  var_1 = dropcarepackage();
  setnewarmsracecacheloc(3);
  var_1 waittill("createNavObstacle");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0.interaction3);
  var_0.interaction3.crate = var_1;
  var_0.interaction3.active = 1;
  waitforoneplayernearpoint(var_0.curcachelocation, 500);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_3rd_obj_10", var_0.currentteam);
  start_convoy("convoy_03", "convoy_start_03");
  level waittill("armsrace_cache3_activated");
  thread scripts\cp\cp_objectives::run_objective("obj_armsrace_defend3");
  wait 1;
  level thread scripts\cp\utility::ref_123FE("mus_cp_armsrace_reinforcements_3");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_heli_1");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_heli_2");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase3");
  level thread scripts\cp\utility::objective_update("obj_armsrace_defend3", 120, 30, 10, 1);
  thread dosmokecurtains(level, "armsrace_smoke_bomb_3");
  level waittill("obj_armsrace_defend3_timer_complete");
  level thread scripts\cp\utility::objective_update("obj_armsrace_defend3");
  wait 1;
  level notify("armsrace_cache_secured");
  var_0.interaction3.active = 0;
  level notify("stop_armsrace_smoke");
  level thread scripts\cp\utility::ref_123FE("mus_cp_armsrace_cache_4");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_3rd_obj_complete_10", var_0.currentteam);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_3rd_obj_complete_20", var_0.currentteam);
}

function docache4(var_0) {
  if(!istrue(scripts\engine\utility::flag("cp_armsrace_cs"))) {
    scripts\engine\utility::flag_set("cp_armsrace_cs");
  }

  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");

  if(!isDefined(level.camper_damage_thread)) {
    level.camper_damage_thread = 0;
  }

  level notify("armsrace_activate_interaction_4");
  thread scripts\cp\cp_objectives::run_objective("obj_armsrace_defend4");
  waitforoneplayernearpoint(prevcallback(4), 500);
  level notify("start_super_end_defend");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_4th_obj_10", "allies");
  level waittill("armsrace_nuke_activated");
  start_convoy("convoy_02", "convoy_start_02");
  wait 1;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_4th_obj_defend_10", "allies");
  level thread scripts\cp\utility::ref_123FE("mus_cp_armsrace_reinforcements_4");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase4");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_jugg");
  level thread scripts\cp\cp_wave_spawning::killstreaks(2, "armsrace_cache4");
  level thread scripts\cp\cp_wave_spawning::killstreaks(60, "armsrace_cache4_2");
  thread camera_loadout_showcase_preview_sticker_alt4("armsrace_c4_planter_backlot", 3, "obj_armsrace_defend4_timer_complete");
  thread lower_airlock();
  level thread scripts\cp\utility::objective_update("obj_armsrace_defend4", 120, 30, 10, 1);
  wait 40;
  thread dosmokecurtains(level, "armsrace_smoke_bomb_3");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase4_lasers");
  wait 40;
  level notify("armsrace_cache4_almost_finished");
  level waittill("obj_armsrace_defend4_timer_complete");
  wait 1;
  level notify("armsrace_cache_secured");
  wait 1;
  level.camper_damage_thread++;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
  thread scripts\cp\cp_objectives::run_objective("obj_armsrace_open_crate");
  level notify("armsrace_activate_nuke_open");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_4th_obj_complete_10", "allies");
  level notify("stop_armsrace_smoke");
  thread lossendgame();
  level waittill("armsrace_cache_opened");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_4th_obj_open_10", "allies");
  level thread scripts\cp\utility::ref_123FE("mus_cp_armsrace_warhead_secured");
}

function lower_airlock() {
  level endon("game_ended");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_3rd_obj_jugg_enemy_10", "allies");
  wait 15;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_3rd_obj_jugg_dead_10", "allies");
}

function completearmsraceobj(var_0) {
  var_0.cachewid = undefined;
  scripts\cp\cp_objectives::freeworldid("armsrace_cacheWID");
  scripts\mp\brclientmatchdata::getprophealth("arms_race_p1");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_outro_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_outro_50", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_outro_60", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_go_to_safehouse_10", "allies");
  wait 4;
}

function losqueuehigh() {
  level endon("game_ended");
  var_0 = scripts\cp\cp_modular_spawning::run_spawn_module("wave_spawning");
  level waittill("player_entered_safehouse_vol");
  var_0 = scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
}

function lossendgame() {
  level endon("game_ended");
  level endon("armsrace_cache_opened");

  for(;;) {
    wait 10;

    switch (randomintrange(1, 4)) {
      case 1:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_4th_obj_open_nag_10", "allies");
        break;
      case 2:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_4th_obj_open_nag_20", "allies");
        break;
      case 3:
      default:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_4th_obj_open_nag_30", "allies");
        break;
    }
  }
}

function losqueuelowindex() {
  level endon("game_ended");
  level endon("entered_armsrace_area");

  for(;;) {
    wait 20;

    switch (randomintrange(1, 4)) {
      case 1:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_hangar_nag_10", "allies");
        break;
      case 2:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_hangar_nag_20", "allies");
        break;
      case 3:
      default:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_hangar_nag_30", "allies");
        break;
    }
  }
}

function ref_13338(var_0) {
  var_1 = scripts\engine\utility::getStruct("armsrace_label_" + var_0, "script_noteworthy");
  var_2 = spawn("script_model", var_1.origin);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0));
  var_2 setModel(var_1.targetname);
  return var_2;
}

function initnuke() {
  var_0 = scripts\engine\utility::getStruct("armsrace_interaction_4", "script_noteworthy");
  thread init_silo_thrust_obj(var_0);
  ref_13338(4);
  thread ref_13515();
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1.trial_target_enemy_killed_func = var_0;
  var_1 setHintString(&"CP_OBJ_ARMSRACE/SECURE_BOMB");
  var_1 setCursorHint("HINT_BUTTON");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(90);
  var_1 setuserange(72);
  var_1 setusefov(90);
  var_1 sethintonobstruction("hide");
  var_1 setuseholdduration("duration_short");
  thread camera_loadout_showcase_preview_small_sticker();
}

function init_silo_thrust_obj(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  teamhasfreshsquadleadercandidate();
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = spawn("script_model", var_1.origin);

  if(isDefined(var_1.angles)) {
    var_2.angles = var_1.angles;
  }

  var_2 setModel(var_0.script_modelname);
  var_0.cratemodel = var_2;
  var_0.cratemodel solid();
  var_0.cratemodel disconnectPaths();
  heli_leaving_monitor(var_2);
}

function camera_loadout_showcase_preview_small_sticker() {
  level endon("game_ended");
  level waittill("armsrace_activate_interaction_4");
  self.ref_11F94 = scripts\engine\utility::getStruct("armsrace_cache_4", "script_noteworthy").origin;
  self.objid = scripts\cp\cp_objectives::requestworldid("armsrace_cache4WID");
  objective_state(self.objid, "current");
  objective_setlocation(self.objid, 0, self.ref_11F94);
  objective_icon(self.objid, "icon_waypoint_objective_general");
  objective_setlabel(self.objid, &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE");
  self makeusable();
  self.secured = 0;

  for(;;) {
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread activationnuke(self, var_0);
    level waittill("armsrace_activate_nuke_open");
    self makeusable();
    self setHintString(&"CP_OBJ_ARMSRACE/TAG_BOMB");
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread activationnuke(self, var_0);
    level waittill("armsrace_cache_opened");
    objective_delete(self.objid);
    scripts\cp\cp_objectives::freeworldid("armsrace_cache4WID");
    break;
  }
}

function hintnuke(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");

  if(istrue(var_2.nukeinteraction.active)) {
    if(istrue(var_2.nukeinteraction.secured)) {
      return &"CP_OBJ_ARMSRACE/TAG_BOMB";
    }

    return &"CP_OBJ_ARMSRACE/SECURE_BOMB";
  }

  return "";
}

function activationnuke(var_0, var_1) {
  if(!istrue(var_0.secured)) {
    level notify("armsrace_nuke_activated");
    var_0.secured = 1;
    return;
  }

  thread ref_1212A(var_0.trial_target_enemy_killed_func.cratemodel);
}

function initarms1() {
  var_0 = scripts\engine\utility::getStruct("armsrace_interaction_1", "script_noteworthy");
  scripts\cp\cp_interaction::spawninteractionmodel(var_0, scripts\engine\utility::getStruct(var_0.target, "targetname"));
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  ref_13338(1);
  var_1 setHintString(&"CP_OBJ_ARMSRACE/SECURE_CACHE");
  var_1 setCursorHint("HINT_BUTTON");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(90);
  var_1 setuserange(72);
  var_1 setusefov(90);
  var_1 sethintonobstruction("hide");
  var_1 setuseholdduration("duration_short");
  thread camera_loadout_showcase_preview_large_sticker_alt3();
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace_defend1");
  var_2.interaction = var_1;
}

function camera_loadout_showcase_preview_large_sticker_alt3() {
  level endon("game_ended");
  level waittill("armsrace_activate_interaction_1");
  self.ref_11F94 = scripts\engine\utility::getStruct("armsrace_cache_1", "script_noteworthy").origin;
  self.objid = scripts\cp\cp_objectives::requestworldid("armsrace_cache1WID");
  objective_state(self.objid, "current");
  objective_setplayintro(self.objid, 1);
  objective_setplayoutro(self.objid, 1);
  objective_setlocation(self.objid, 0, self.ref_11F94);
  objective_icon(self.objid, "icon_waypoint_objective_general");
  objective_setlabel(self.objid, &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE");
  self makeusable();

  for(;;) {
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread activationarms1(self, var_0);
    level waittill("armsrace_cache_secured");
    objective_delete(self.objid);
    scripts\cp\cp_objectives::freeworldid("armsrace_cache1WID");
    break;
  }
}

function activationarms1(var_0, var_1) {
  if(play_takephoto_anim(var_1)) {
    level notify("armsrace_cache1_activated");
    return;
  }
}

function initarms2() {
  var_0 = scripts\engine\utility::getStruct("armsrace_interaction_2", "script_noteworthy");
  scripts\cp\cp_interaction::spawninteractionmodel(var_0, scripts\engine\utility::getStruct(var_0.target, "targetname"));
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  ref_13338(2);
  var_1 setHintString(&"CP_OBJ_ARMSRACE/SECURE_CACHE");
  var_1 setCursorHint("HINT_BUTTON");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(90);
  var_1 setuserange(72);
  var_1 setusefov(90);
  var_1 sethintonobstruction("hide");
  var_1 setuseholdduration("duration_short");
  thread camera_loadout_showcase_preview_large_stock_alt1();
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace_defend2");
  var_2.interaction = var_1;
}

function camera_loadout_showcase_preview_large_stock_alt1() {
  level endon("game_ended");
  level waittill("armsrace_activate_interaction_2");
  self.ref_11F94 = scripts\engine\utility::getStruct("armsrace_cache_2", "script_noteworthy").origin;
  self.objid = scripts\cp\cp_objectives::requestworldid("armsrace_cache2WID");
  objective_state(self.objid, "current");
  objective_setlocation(self.objid, 0, self.ref_11F94);
  objective_icon(self.objid, "icon_waypoint_objective_general");
  objective_setlabel(self.objid, &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE");
  self makeusable();

  for(;;) {
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread activationarms2(self, var_0);
    level waittill("armsrace_cache_secured");
    objective_delete(self.objid);
    scripts\cp\cp_objectives::freeworldid("armsrace_cache2WID");
    break;
  }
}

function activationarms2(var_0, var_1) {
  if(play_takephoto_anim(var_1)) {
    level notify("armsrace_cache2_activated");
    return;
  }
}

function initarms3(var_0) {
  if(var_0.size > 0) {
    var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");
    var_1.interaction3 = var_0[0];
    var_1.interaction3.active = 0;
    var_1.interaction3.secured = 0;
    scripts\cp\cp_interaction::spawninteractionmodel(var_0[0], scripts\engine\utility::getStruct(var_0[0].target, "targetname"));
    return;
  }
}

function hintarms3(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");

  if(istrue(var_2.interaction3.active)) {
    if(istrue(var_2.interaction3.secured)) {
      return &"CP_OBJ_ARMSRACE/TAG_CACHE";
    }

    return &"CP_OBJ_ARMSRACE/SECURE_CACHE";
  }

  return "";
}

function activationarms3(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");

  if(!istrue(var_2.interaction3.active)) {
    return;
  }

  if(play_takephoto_anim(var_1)) {
    level notify("armsrace_cache3_activated");
    var_2.interaction3.active = 0;

    if(isDefined(var_0.crate)) {
      var_3 = ref_13338(3);
      var_3.angles = scripts\engine\utility::ter_op(isDefined(var_0.crate.angles), var_0.crate.angles, (0, 0, 0));
      waitframe();
      var_3.origin = scripts\cp\utility::get_point_in_local_ent_space(var_0.crate, (-17.61, -24.7, 49.332));
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    return;
  }
}

function initobjspawners() {
  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_wait("interactions_initialized");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("cp_armsrace_cs_completed")) {
    scripts\engine\utility::flag_init("cp_armsrace_cs_completed");
  }

  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("armsrace_phase1", 0, 16, 200, 0.5, undefined, "armsrace_phase1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("armsrace_phase2", 4, 6, 100, [ &waitbetweenspawnwaveswithtimeout, 0.1, 5], undefined, "armsrace_phase2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("armsrace_phase2_lasers", 4, 8, 100, 0.25, undefined, "armsrace_phase2_lasers", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_phase2_lasers", &infectedairdroppositions);
  [[var_0]]("armsrace_phase_hold", 8, 12, 100, 0.25, undefined, "armsrace_phase_hold", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_phase_hold", &camsetorbit);
  [[var_0]]("armsrace_phase3", 10, 10, 200, [ &waitbetweenspawnwaveswithtimeout, 0.1, 10], undefined, "armsrace_phase3", &watchforstopwaves, undefined, undefined);
  [[var_0]]("armsrace_phase4", 0, 6, 200, [ &waitbetweenspawnwaveswithtimeout, 0.1, 10], undefined, "armsrace_phase4", &watchforstopwaves, undefined, undefined);
  [[var_0]]("armsrace_phase5", 15, 15, 200, [ &waitbetweenspawnwaveswithtimeout, 0.1, 10], undefined, "armsrace_phase5", &watchforstopwaves, undefined, undefined);
  [[var_0]]("armsrace_jugg", 0, 2, 2, 0.5, undefined, "armsrace_jugg", &watchforstopwaves, undefined, undefined);
  [[var_0]]("armsrace_phase5_sniper", 2, 2, 2, 0.5, undefined, "armsrace_phase5_sniper", &watchforstopwaves, undefined, undefined);
  [[var_0]]("armsrace_phase1_lasers", 6, 6, 6, 0.5, undefined, "armsrace_phase1_lasers");
  [[var_0]]("armsrace_phase4_lasers", 3, 3, 3, 0.5, undefined, "armsrace_phase4_lasers");
  [[var_0]]("armsrace_phase1_sniper", 1, 1, 1, 0.5, undefined, "armsrace_phase1_sniper", &watchforstopwaves, &ref_1445E);
  [[var_0]]("armsrace_phase1_sniper_2", 1, 1, 1, 0.5, undefined, "armsrace_phase1_sniper_2", &watchforstopwaves, &ref_1445E);
  [[var_0]]("armsrace_trucks_4", 6, 6, 6, [ &waitbetweenspawnwaveswithtimeout, 0.1, 5], undefined, "techo_phys_armsrace1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("armsrace_trucks_5", 6, 6, 6, [ &waitbetweenspawnwaveswithtimeout, 0.1, 5], undefined, "techo_phys_armsrace2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("payload_lasttrek_sniper", 2, 2, 2, 0.5, undefined, "payload_lasttrek_sniper");
  [[var_0]]("payload_lasttrek_rpg", 2, 2, 2, 0.5, undefined, "payload_lasttrek_sniper");
  [[var_0]]("payload_armsrace_molotov_chucker", 1, 1, 1, 0.5, undefined, "payload_armsrace_molotov_chucker");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("payload_armsrace_molotov_chucker", &grenade_structs);
  [[var_0]]("armsrace_c4_planter_parking", 1, 1, 1, 0.5, undefined, "armsrace_c4_planter_super");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_c4_planter_parking", &camoname);
  [[var_0]]("armsrace_c4_planter_super", 1, 1, 1, 0.5, undefined, "armsrace_c4_planter_super");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_c4_planter_super", &camoset);
  [[var_0]]("armsrace_c4_planter_backlot", 1, 1, 1, 0.5, undefined, "armsrace_c4_planter_super");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_c4_planter_backlot", &cameraentlinktag);

  if(!scripts\engine\utility::flag_exist("armsrace_spawn_functions_registered")) {
    scripts\engine\utility::flag_init("armsrace_spawn_functions_registered");
  }

  scripts\engine\utility::flag_set("armsrace_spawn_functions_registered");
}

function infectedairdroppositions(var_0) {
  infecteddisablenvg();
}

function infecteddisablenvg() {
  level endon("game_ended");
  self endon("death");
  wait 1;
  var_0 = 1000;
  self.maxfaceenemydist = var_0;
  scripts\cp\cp_modular_spawning::set_goal_radius(var_0 * 0.65);

  for(;;) {
    var_1 = var_0;
    var_2 = scripts\cp\utility::get_closest_living_player(36000000);

    if(isDefined(var_2)) {
      var_1 = distance(self.origin, var_2.origin);
    }

    if(var_1 < var_0) {
      scripts\common\utility::demeanor_override("cqb");
      self.maxfaceenemydist = var_0;
    } else {
      scripts\common\utility::demeanor_override("sprint");
    }

    wait 2;
  }
}

function waittill_any_return_1() {
  level endon("game_ended");
  self endon("death");
  GscBinSkip1(0x45, 0, "tag_laser_show");
}

function camsetorbit(var_0) {
  self.never_kill_off = 1;
  thread can_activate_battle_station(var_0);
}

function can_activate_battle_station(var_0) {
  if(isDefined(var_0.group_name)) {
    var_1 = var_0.group_name;
  } else if(isDefined(self.enemy_group)) {
    var_1 = self.enemy_group;
  } else {
    var_1 = "default";
  }

  if(!isDefined(level.bomb_vest_timer_remaining_time_ms) || !istrue(level.bomb_vest_timer_remaining_time_ms[var_1])) {
    thread bomb_vest_timer_remaining_num_of_frame(scripts\engine\utility::getStructArray("super_goal", "targetname"), 400, 0, 200);
    return;
  }

  self.never_kill_off = 0;
  scripts\cp\cp_modular_spawning::set_goal_radius(300);
}

function bomb_vest_timer_remaining_num_of_frame(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = 400;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  thread bomb_vest_explodes(var_0, var_2, var_3);
  thread bomb_vest_timer_yellow_starting_frame(var_1, var_2);
  thread bomb_vest_timer_total_num_of_frame(var_4);
}

function bomb_vest_success_fail_think(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    thread bomb_vest_timer_frozen(level, var_4, var_1);
  }
}

function bomb_vest_timer_frozen(var_0, var_1, var_2) {
  level endon("end_hold_behavior");
  var_0 notify("ai_hold_debug");
  var_0 endon("ai_hold_debug");
  var_3 = pressure_overload_threshold(var_0, var_2);

  for(;;) {
    var_4 = var_0.origin;

    if(isDefined(var_0.radius)) {
      var_5 = var_0.radius;
    } else {
      var_5 = 600;
    }

    level thread scripts\engine\utility::draw_circle(var_4, var_5, (1, 1, 0), 0.5, 0, 20);

    if(isDefined(var_0.ref_127EA) && var_0.ref_127EA.size) {
      foreach(var_7 in var_0.ref_127EA) {
        if(isDefined(var_7) && isai(var_7) && isalive(var_7)) {
          var_8 = var_7 getentitynumber();

          if(!isDefined(var_8)) {
            var_8 = "agent";
          }
        }
      }
    }

    wait 1;
  }
}

function bomb_vest_explodes(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("end_hold_behavior");
  self endon("end_hold_behavior");
  self endon("death");
  var_3 = undefined;

  for(;;) {
    var_3 = printdata(var_0, var_2);
    ref_13F8A(self, var_3);
    var_4 = var_3.origin;

    if(isDefined(var_3.radius)) {
      var_5 = var_3.radius;
    } else {
      var_5 = 600;
    }

    self.script_origin_other = var_4;
    scripts\cp\cp_modular_spawning::set_goal_pos(var_4);
    scripts\cp\cp_modular_spawning::set_goal_radius(var_5);
    scripts\common\utility::demeanor_override("sprint");
    wait 15;
  }
}

function printdata(var_0, var_1) {
  var_2 = printcodeentered(var_0);
  var_3 = var_2.origin;
  var_0 = sortbydistance(var_0, var_3);

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!triggeregg(var_0[var_4], var_1)) {
      return var_0[var_4];
    }
  }

  return protect_obj_a(var_0);
}

function printcodeentered(var_0) {
  var_1 = var_0[0];
  var_2 = 1000000;

  foreach(var_4 in var_0) {
    var_5 = var_4 scripts\cp\utility::get_closest_living_player(36000000);

    if(!isDefined(var_5)) {
      return scripts\engine\utility::random(var_0);
    }

    var_6 = distance(var_5.origin, var_4.origin);

    if(var_6 < var_2) {
      var_2 = var_6;
      var_1 = var_4;
    }
  }

  return var_1;
}

function protect_obj_a(var_0) {
  var_1 = var_0[0];

  if(isDefined(var_1.script_priority)) {
    var_2 = int(var_1.script_priority);
  } else {
    var_2 = 0;
  }

  for(var_3 = 1; var_3 < var_1.size; var_3++) {
    if(isDefined(var_1[var_3].script_priority)) {
      if(!isDefined(var_1[var_3 - 1].script_priority) || var_2 < int(var_1[var_3].script_priority)) {
        var_2 = int(var_1[var_3].script_priority);
        var_2 = var_1[var_3];
      }
    }
  }

  return var_2;
}

function ref_134D1(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    for(var_2 = var_1 + 1; var_2 < var_0.size; var_2++) {
      var_3 = 0;

      if(isDefined(var_0[var_2].script_priority)) {
        var_3 = int(var_0[var_2].script_priority);
      }

      var_4 = 0;

      if(isDefined(var_0[var_1].script_priority)) {
        var_4 = int(var_0[var_1].script_priority);
      }

      if(var_3 < var_4) {
        var_5 = var_0[var_2];
        var_0 = var_0[var_1];
        var_0 = var_5;
      }
    }
  }
}

function quickdropfinditemincache(var_0) {
  var_1 = prematchplayedwelcomevo();
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = 1000000;

  foreach(var_5 in var_0) {
    var_6 = var_5 scripts\cp\utility::get_closest_living_player(36000000);

    if(!isDefined(var_6)) {
      continue;
    }

    var_7 = distance(var_6.origin, var_5.origin);

    if(var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_6;
    }
  }

  return var_2;
}

function prematchplayedwelcomevo() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isalive(var_2) && !scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function ref_13F8A(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_1.ref_127EA, var_0)) {
    return false;
  }

  if(isDefined(var_0.initheadlessoperatorcustomization) && var_0.initheadlessoperatorcustomization == var_1) {
    return false;
  }

  if(isDefined(var_0.initheadlessoperatorcustomization) && scripts\engine\utility::array_contains(var_0.initheadlessoperatorcustomization.ref_127EA, var_0)) {
    var_0.initheadlessoperatorcustomization.ref_127EA = scripts\engine\utility::array_remove(var_0.initheadlessoperatorcustomization.ref_127EA, var_0);
  }

  var_0.initheadlessoperatorcustomization = var_1;
  var_1.ref_127EA[var_1.ref_127EA.size] = var_0;
  return true;
}

function triggeregg(var_0, var_1) {
  if(!isDefined(var_0.ref_127EA)) {
    var_0.ref_127EA = [];
    return false;
  }

  var_2 = pressure_overload_threshold(var_0, var_1);
  var_3 = [];

  foreach(var_5 in var_0.ref_127EA) {
    if(!isDefined(var_5) || !isalive(var_5)) {
      continue;
    }

    var_6 = 1;

    foreach(var_8 in var_3) {
      if(var_5 == var_8) {
        var_6 = 0;
        break;
      }
    }

    if(var_6) {
      var_3 = var_5;
    }
  }

  var_0.ref_127EA = var_3;
  var_11 = var_0.ref_127EA.size;
  return var_11 >= var_2;
}

function pressure_overload_threshold(var_0, var_1) {
  if(var_1 < 1) {
    var_1 = 1;
  }

  if(!isDefined(var_0.radius)) {
    var_2 = 600;
  } else {
    var_2 = int(var_1.radius);
  }

  return int(max(1, var_2 / var_2));
}

function bomb_vest_timer_yellow_starting_frame(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_0)) {
    var_0 = 400;
  }

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, var_0 * var_0)) {
      break;
    }

    wait 0.25;
  }

  if(istrue(var_1)) {
    var_2 = "default";

    if(isDefined(self.enemy_group)) {
      var_2 = self.enemy_group;
    }

    set_guy_to_specific_pos(var_2);
    return;
  }

  bomb_vest_timer_red_starting_frame();
}

function bomb_vest_timer_red_starting_frame() {
  self notify("end_hold_behavior");
}

function set_guy_to_specific_pos(var_0) {
  if(!isDefined(level.bomb_vest_timer_remaining_time_ms)) {
    level.bomb_vest_timer_remaining_time_ms = [];
  }

  level.bomb_vest_timer_remaining_time_ms[var_0] = 1;
  level notify("end_hold_behavior");
}

function bomb_vest_timer_total_num_of_frame(var_0) {
  self endon("death");
  level endon("game_ended");
  level scripts\cp\utility::add_wait(&scripts\cp\utility::waittill_msg, "end_hold_behavior");
  scripts\cp\utility::add_wait(&scripts\cp\utility::waittill_msg, "end_hold_behavior");
  scripts\cp\utility::do_wait_any();
  scripts\common\utility::demeanor_override("combat");
  self.never_kill_off = 0;
  self.script_origin_other = undefined;

  if(isDefined(var_0)) {
    self thread[[var_0]]();
    return;
  }

  var_1 = 300;
  scripts\cp\cp_modular_spawning::set_goal_radius(var_1);
  thread scripts\cp\cp_modular_spawning::get_enemy_info_loop();
}

function ref_13515() {
  wait 1;
  var_0 = scripts\engine\utility::getStructArray("payload_rpg_pickups", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\cp_weapon::buildweapon(var_2.script_noteworthy, [], "none", "none", -1);
    var_4 = createheadicon(var_3);
    var_5 = spawn("weapon_" + var_4, var_2.origin);

    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    var_5.angles = var_2.angles;
    var_5 itemweaponsetammo(weaponclipsize(var_3), weaponmaxammo(var_3));
  }
}

function waitbetweenspawnwaveswithtimeout(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = gettime();
  var_5 = var_4 + var_2 * 1000;

  for(var_6 = getaiarray("axis").size; var_6 >= 18; var_6 = getaiarray("axis").size) {
    wait 1;
  }

  return var_1;
}

function ref_1445E(var_0) {
  level endon("game_ended");
  wait 4;

  while(var_0.activecount > 0) {
    wait 1;
  }

  wait 5;
  return var_0.group_name;
}

function watchforstopwaves(var_0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var_0) {
  level endon("game_ended");
  level waittill("armsrace_cache_secured");
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function remove_group_from_combined_module_counters(var_0, var_1) {
  level endon("game_ended");
  level endon("armsrace_cache_secured");
  wait var_1;

  for(var_2 = getaiarray("axis").size; var_2 >= 18; var_2 = getaiarray("axis").size) {
    wait 4;
  }

  return var_0.group_name;
}

function grenade_structs(var_0) {
  self endon("death");
  self.scripted_mode = 1;
  self.ignoreall = 1;
  self.goalradius = 64;
  self setgoalpos(scripts\engine\utility::getStruct(self.target, "targetname").origin);
  scripts\engine\utility::ref_143A5("goal", "near_goal");
  var_1 = scripts\engine\utility::getStruct("payload_molotov_origin", "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  thread throw_molotov(var_1, var_2);
  self.ignoreall = 0;
  self.goalradius = 1024;
  self.scripted_mode = 0;
}

function camoname(var_0) {
  var_1 = &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE";
  thread cameraentmoving(var_0, "armsrace_interaction_1", "obj_armsrace_defend1", var_1);
}

function camoset(var_0) {
  var_1 = &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE";
  thread cameraentmoving(var_0, "armsrace_interaction_2", "obj_armsrace_defend2", var_1);
}

function cameraentlinktag(var_0) {
  var_1 = &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE";
  thread cameraentmoving(var_0, "armsrace_interaction_4", "obj_armsrace_defend4", var_1);
}

function cameraentmoving(var_0, var_1, var_2, var_3) {
  self endon("death");
  scripts\common\utility::demeanor_override("sprint");
  self notify("basic_combat");
  wait 1;

  if(isDefined(var_2) && !scripts\cp\cp_objectives::is_objective_active(var_2)) {
    return;
  }

  var_4 = scripts\engine\utility::getStructArray("c4_interact", "targetname");
  var_5 = 350;
  var_6 = scripts\engine\utility::getStruct(var_1, "script_noteworthy");
  var_7 = [];
  var_8 = [];

  foreach(var_10 in var_4) {
    if(isDefined(var_10) && scripts\engine\utility::distance_2d_squared(var_6.origin, var_10.origin) < var_5 * var_5) {
      if(!istrue(var_10.planted)) {
        var_8 = var_10;
      }

      var_7 = var_10;
    }
  }

  if(var_8.size == 0) {
    var_8 = var_7;
  }

  var_12 = scripts\engine\utility::random(var_8);
  var_12.planted = 1;
  thread camera_loadout_showcase_preview_sticker_alt3(var_12);

  if(!isDefined(var_12.model)) {
    var_12.model = spawn("script_model", scripts\engine\utility::getStruct(var_12.target, "targetname").origin);
    var_12.model setModel("tag_origin");
    var_12.model.angles = scripts\engine\utility::getStruct(var_12.target, "targetname").angles;
  }

  scripts\cp\maps\cp_donetsk\milbase\ai_flare::run_to_and_plant_bomb(var_12.model);
  thread camera_loadout_showcase_preview_sticker_alt2(level, var_2, var_12, self);
}

function camera_loadout_showcase_preview_sticker_alt3(var_0) {
  self endon("bomb_planted");
  self waittill("death");

  if(isDefined(var_0) && istrue(var_0.planted)) {
    var_0.planted = undefined;
    return;
  }
}

function camera_loadout_showcase_preview_sticker_alt2(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(!isDefined(var_1) || !isDefined(var_1.model) || !isDefined(var_1.model.charge)) {
    return;
  }

  var_4 = "armsrace_c4" + var_2.entity_number;
  var_5 = scripts\cp\cp_objectives::requestworldid(var_4, 15);
  var_6 = var_1.model.charge;
  var_6.leave_pool_behind_after_deactivation = 25;
  follow_players_when_close(var_6, var_5);
  thread camera_loadout_showcase_preview_sticker_alt1(var_6, var_0, var_1, var_3);
  var_7 = &"CP_STRIKE/DEFUSE";
  var_6 scripts\cp\utility::create_cursor_hint("tag_origin", undefined, var_7, 180, 256, 64, 0, undefined, undefined, undefined, "duration_medium");
  var_6 endon("detonated");
  var_6 endon("death");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_ARMSDEALER/DEFUSE_BOMB", "allies", 5);
  var_6.outlineid = scripts\cp\cp_outline_utility::outlineenableforall(var_6, "outline_depth_red", "level_script");

  for(;;) {
    var_6 waittill("trigger", var_8);
  }

  LOC_000000f6:
    var_6 notify("defused");

  if(isDefined(var_1.planted)) {
    var_1.planted = undefined;
  }

  if(isDefined(var_6.outlineid)) {
    scripts\cp\cp_outline_utility::outlinedisable(var_6.outlineid, var_6);
  }

  footprint_mask_clipheight(var_5, var_4);
  var_6 delete();
}

function follow_players_when_close(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  scripts\cp\cp_objectives::objective_set_play_intro(var_0, 1);
  objective_setlabel(var_0, "CP_ARMSDEALER/DEFUSE_BOMB");
  objective_setshowprogress(var_0, 1);
  objective_icon(var_0, "icon_waypoint_cyber_bombsite");
  objective_position(var_0, self.origin + (0, 0, 15));
  objective_setprogress(var_0, 1);
  objective_state(var_0, "current");
  objective_setownerteam(var_0, "axis");
}

function footprint_mask_clipheight(var_0, var_1) {
  if(isDefined(var_0)) {
    objective_delete(var_0);
    scripts\cp\cp_objectives::freeworldid(var_1);
    return;
  }
}

function camera_loadout_showcase_preview_sticker_alt1(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("defused");
  level endon("game_ended");
  var_4 = self.leave_pool_behind_after_deactivation;
  var_5 = var_4;
  var_6 = var_4;

  while(var_6 > 0) {
    var_6--;
    objective_setprogress(var_3, var_6 / var_5);

    if(soundexists("breach_warning_beep_05")) {
      foreach(var_8 in level.players) {
        var_8 playSound("breach_warning_beep_05");
      }
    }

    wait 1;
  }

  var_10 = "frag";
  var_11 = 0.1;
  var_12 = magicgrenademanual(var_10, self.origin + (0, 0, 6), (0, 0, 0), var_11);
  var_12.angles = self.angles;
  self notify("detonated");

  if(isDefined(var_1.planted)) {
    var_1.planted = undefined;
  }

  if(isDefined(self.outlineid)) {
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);
  }

  playFX(level._effect["vfx_payload_rpg_hit"], self.origin);
  self playSound("rocket_explode");
  footprint_mask_clipheight(var_3);
  wait 1;

  if(isDefined(var_0) && scripts\cp\cp_objectives::is_objective_active(var_0)) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    var_13 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
    var_13.pathdist = 1;
  }

  self delete();
}

function debugarmsraceobjectivestart(var_0) {
  scripts\engine\utility::flag_set("cp_armsrace_cs");
  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "armsrace_debug_start_loc");
}

function waitforoneplayernearpoint(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0) <= var_1) {
        var_2 = 1;
      }
    }

    if(var_2) {
      return;
    }

    waitframe();
  }
}

function setnewarmsracecacheloc(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0 > 4 || var_0 < 1) {
    var_0 = 1;
  }

  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");
  var_1.curcache = var_0;
  var_1.curcachelocation = scripts\engine\utility::getStruct("armsrace_cache_" + var_0, "script_noteworthy").origin;
  objective_state(var_1.cachewid, "current");
  objective_setlocation(var_1.cachewid, 0, var_1.curcachelocation);
  objective_icon(var_1.cachewid, "icon_waypoint_objective_general");
  objective_setlabel(var_1.cachewid, &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE");
}

function dropcarepackage() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStruct("armsrace_crate_drop", "script_noteworthy");
  var_1 = scripts\engine\utility::drop_to_ground(var_0.origin, 50, -200, (0, 0, 1));
  var_1 += (0, 0, 1);
  var_2 = dropcratefrommanualheli(var_1);
  thread oncratedrop(var_2, var_1);
  return var_2;
}

function dropcratefrommanualheli(var_0) {
  var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "attachment", "munition"));
  var_2 = scripts\cp_mp\killstreaks\airdrop::dropcratefrommanualheli(undefined, "allies", "cp_armsrace_crate", var_0, (0, randomfloat(360), 0), 30000, 30000, var_0, scripts\cp\killstreaks\airdrop_cp::getcpcratedatabytype("cp_loadout"));

  if(!isDefined(var_2)) {
    return undefined;
  } else if(!isDefined(var_2.crate)) {
    return undefined;
  }

  return var_2.crate;
}

function oncratedrop(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("offhand_wm_grenade_smoke");
  var_2.angles = (0, 90, 90);
  var_3 = spawn("script_model", var_0);
  var_3 setModel("ks_crate_marker_mp");
  var_3 setscriptablepartstate("smoke", "on", 0);
  thread watchforcratecapture(var_2);
  thread watchforcratecapture(var_3);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(600);

  if(isDefined(var_1.script_linkname) && isDefined(level.crates_active_at_location[var_1.script_linkname])) {
    level.crates_active_at_location[var_1.script_linkname] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }

  if(isDefined(var_2)) {
    var_2 delete();
    return;
  }
}

function watchforcratecapture(var_0) {
  self endon("death");
  var_0 waittill("death");
  self delete();
}

function start_convoy(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_1, "targetname");

  if(!isDefined(var_2)) {
    var_2 = "single-techo-cargo";
  }

  thread set_convoy_settings(level, var_0, var_2);
}

function set_convoy_settings(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  var_4 thread scripts\cp\maps\cp_payload\cp_objs_payload::select_bunker_server_one_spawners();
  level thread scripts\cp\maps\cp_payload\cp_objs_payload::allow_driver_exit(var_4);
  var_4 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  level waittill("despawn_" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

function play_takephoto_anim() {
  var_0 = "intel_take_photo";
  var_1 = self getcurrentweapon();
  var_2 = getcompleteweaponname(var_0);
  thread freeze_until_phototaken();
  scripts\cp\utility::_giveweapon(var_2);
  self switchtoweapon(var_2);
  self setclientomnvar("ui_tablet_usb", 7);
  var_3 = 3;
  wait var_3;

  if(isPlayer(self)) {
    self takeweapon(var_2);
    self switchtoweapon(var_1);
    self setclientomnvar("ui_tablet_usb", 0);
    return true;
  }

  return false;
}

function freeze_until_phototaken() {
  togglecellphoneallows(1);
  var_0 = 1.3;
  wait var_0;
  togglecellphoneallows(0);
}

function togglecellphoneallows(var_0) {
  scripts\cp\utility::_freezelookcontrols(var_0);
  scripts\common\utility::allow_movement(!var_0);
  scripts\common\utility::allow_jump(!var_0);
  scripts\common\utility::allow_usability(!var_0);
  scripts\common\utility::allow_melee(!var_0);
  scripts\common\utility::allow_offhand_weapons(!var_0);
  scripts\common\utility::allow_weapon_switch(!var_0);
}

function dosmokecurtains(var_0, var_1) {
  level endon("game_ended");
  level endon("armsrace_cache_secured");
  wait var_1;
  var_2 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  var_3 = 8;

  foreach(var_5 in var_2) {
    var_6 = randomfloat(2);
    thread ref_14403(var_5, var_6);
    waitframe();
  }
}

function ref_14403(var_0, var_1) {
  level endon("game_ended");
  wait var_1;
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("tag_origin");
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  waitframe();
  playFXOnTag(level._effect["vfx_armsrace_smoke"], var_2, "tag_origin");
  var_2 playLoopSound("smoke_grenade_smoke_lp");
  level waittill("stop_armsrace_smoke");
  var_3 = randomfloat(0.5);
  var_2 scripts\engine\utility::delaycall(var_3, &playsound, "smoke_grenade_smoke_tail");
  stopFXOnTag(level._effect["vfx_armsrace_smoke"], var_2, "tag_origin");
  wait 0.25;
  var_2 stoploopsound();
  wait 4.25;
  var_2 delete();
}

function spawn_atvs() {
  if(!isDefined(level.atvs)) {
    level.atvs = [];
  }

  var_0 = scripts\engine\utility::getStructArray("armsrace_atv_spawn", "script_noteworthy");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
  var_1 = scripts\cp\cp_objectives::requestworldid("armsrace_atvs");
  var_2 = scripts\engine\utility::getStruct("armsrace_vehicle_marker", "script_noteworthy").origin;
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_state(var_1, "current");
  objective_setlabel(var_1, &"CP_ARMSDEALER/ARMSRACE_ATVS");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_setbackground(var_1, 1);
  objective_setshowoncompass(var_1, 1);
  objective_position(var_1, var_2);
  thread ref_144D8(level);
}

function ref_144D8(var_0) {
  level endon("game_ended");
  var_1 = scripts\cp\utility::array_merge(level.players, [level]);
  level scripts\engine\utility::waittill_any_ents_array(var_1, "entered_vehicle", "player_entered_safehouse_vol");
  objective_delete(var_0);
}

#using_animtree("script_model");

function heli_leaving_monitor(var_0) {
  var_0 useanimtree(#animtree);
  var_0.animname = "nuke";
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_0, "nuke_open");
}

#using_animtree("");

function ref_1212A(var_0) {
  if(!isDefined(var_0)) {
    scripts\cp\utility::debugprintline("no crate defined");
    level notify("armsrace_cache_opened");
    return;
  }

  var_0 useanimtree(#animtree);
  var_0.animname = "nuke";
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "nuke_open");
  wait getanimlength(level.scr_anim["nuke"]["nuke_open"]);
  level notify("armsrace_cache_opened");
}

function teamhasfreshsquadleadercandidate() {
  level.scr_animtree["nuke"] = #animtree;
  level.scr_anim["nuke"]["nuke_open"] = % cp_prop_nuclear_warhead_open;
  level.scr_animname["nuke"]["nuke_open"] = "cp_prop_nuclear_warhead_open";
}

function ref_11CE4(var_0) {
  level endon("game_ended");
  level endon("armsrace_cache_secured");
  var_1 = scripts\engine\utility::getStructArray("molotov_origin", "targetname");
  var_2 = 0;

  for(;;) {
    var_3 = randomint(var_1.size);
    var_4 = scripts\engine\utility::getStruct(var_1[var_3].target, "targetname");

    if(throw_molotov(var_1[var_3], var_4)) {
      var_2++;

      if(isDefined(var_0) && var_2 >= var_0) {
        break;
      }

      wait 3;
      continue;
    }

    wait 2;
  }
}

function throw_molotov(var_0, var_1) {
  if(isDefined(getaiarray("axis")[0])) {
    var_2 = getaiarray("axis")[0];
  } else {
    return false;
  }

  var_3 = var_0.angles;
  var_4 = anglesToForward(var_3) * 450;

  if(isDefined(var_1)) {
    var_5 = var_0.origin;
    var_6 = (var_1.origin[0], var_1.origin[1], var_1.origin[2]);
    var_7 = var_6 - var_5;
    var_7 = vectorNormalize(var_7);
    var_4 = var_7 * 600;
  }

  var_8 = var_2 launchgrenade("molotov_mp", var_0.origin, var_4);
  var_8.owner = var_2;
  var_2 thread scripts\cp\powers\coop_molotov::molotov_used(var_8);
  return true;
}

function trial_time_remaining(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance2d(var_3.origin, var_0) <= var_1) {
      return true;
    }
  }

  return false;
}