/************************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_armsrace\armsrace_objective\cp_armsrace_objective.gsc
************************************************************************************/

function ref_12b0e() {
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

function force_kill_off_other_ai(var0) {
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

function prevcallback(var0) {
  return scripts\engine\utility::getStruct("armsrace_interaction_" + var0, "script_noteworthy").origin;
}

function managejumpmasterinfodisplay() {
  level endon("game_ended");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_brief_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_brief_20", "allies");
  var0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));

  if(isDefined(var0)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "conv_generic_affirm");
    return;
  }
}

function ref_13832(var0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_intro_10", "allies");
  thread losqueuelowindex();
  var1 = scripts\engine\utility::getStruct("armsrace_cache_1", "script_noteworthy").origin;
  waitforoneplayernearpoint(var1, 25000);
  start_convoy("convoy_start_beginning_1", "convoy_start_beginning_1", "single-empty");
  start_convoy("convoy_start_beginning_2", "convoy_start_beginning_2", "single-empty");
  level notify("entered_armsrace_area");
  waitforoneplayernearpoint(var1, 5000);
  scripts\cp\cp_objectives::overridenextstep(var0, "obj_armsrace");
}

function ref_13867(var0) {
  level waittill("returned_to_payload");
}

function ref_13833(var0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  level waittill("armsrace_cache_secured");
}

function ref_13834(var0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  level waittill("armsrace_cache_secured");
}

function ref_13835(var0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  level waittill("armsrace_cache_secured");
}

function ref_13836(var0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  level waittill("armsrace_cache_secured");
}

function ref_13837(var0) {
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  level waittill("armsrace_cache_opened");
}

function initarmsraceobj(var0, var1) {
  if(!istrue(scripts\engine\utility::flag("cp_armsrace_cs"))) {
    scripts\engine\utility::flag_set("cp_armsrace_cs");
  }

  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  scripts\engine\utility::flag_wait("armsrace_spawn_functions_registered");
  scripts\cp\utility::skydivestreamhintdvars("armsrace");
  teamhasfreshsquadleadercandidate();
  var0.cachewid = scripts\cp\cp_objectives::requestworldid("armsrace_cacheWID");
}

function startarmsraceobj(var0, var1) {
  scripts\cp\utility::objective_update("obj_armsrace", undefined, undefined, undefined, undefined, 0);
  setnewarmsracecacheloc(1);
  managejumpmasterinfodisplay();
  waitforoneplayernearpoint(var0.curcachelocation, 1000);
  scripts\cp\cp_objectives::overridenextstep(var0, "safehouse_armsdealer_return");
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

  var0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));

  if(isDefined(var0)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_sitrep_wave_start");
  }

  level notify("armsrace_activate_interaction_1");
  thread scripts\cp\cp_objectives::run_objective("obj_armsrace_defend1");
  waitforoneplayernearpoint(prevcallback(1), 500);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_1st_obj_10", "allies");
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_cache_1");
  level waittill("armsrace_cache1_activated");
  thread loothide(level);
  thread mp_m_overunder_patch(level);
  thread start_convoy("convoy_01", "convoy_start_01");
  wait 1;
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_reinforcements_1");
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
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_cache_2");
}

function mp_m_overunder_patch(var0) {
  level endon("game_ended");
  var1 = 5;
  var2 = max(var1, 120 - var0);
  wait var2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
}

function loothide(var0) {
  level endon("game_ended");
  var1 = 10;
  var2 = max(var1, 120 - var0);
  level scripts\engine\utility::ref_143ba(var2, "obj_armsrace_defend1_timer_complete", "armsrace_cache_secured");
  var3 = getEnt("super_store_trig", "targetname");
  thread ref_1447e();
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase_hold");
  level waittill("armsrace_player_entering_super");
  thread set_guy_to_specific_pos(level);
  level waittill("armsrace_cache2_activated");
  thread scripts\cp\cp_modular_spawning::stop_module_by_groupname("armsrace_phase_hold");
}

function ref_1447e() {
  for(;;) {
    self waittill("trigger", var0);

    if(isDefined(var0) && isPlayer(var0)) {
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
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_reinforcements_2");
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
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_cache_3");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_2nd_obj_complete_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_2nd_obj_complete_20", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_2nd_obj_complete_30", "allies");
}

function camera_loadout_showcase_preview_sticker_alt4(var0, var1, var2) {
  if(isDefined(var2)) {
    level endon(var2);
  }

  if(!isDefined(var1)) {
    var1 = 3;
  }

  var3 = 120 / (var1 + 1);

  for(;;) {
    thread scripts\cp\cp_modular_spawning::run_spawn_module(var0);
    wait var3;
  }
}

function docache3(var0) {
  var1 = dropcarepackage();
  setnewarmsracecacheloc(3);
  var1 waittill("createNavObstacle");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var0.interaction3);
  var0.interaction3.crate = var1;
  var0.interaction3.active = 1;
  waitforoneplayernearpoint(var0.curcachelocation, 500);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_3rd_obj_10", var0.currentteam);
  start_convoy("convoy_03", "convoy_start_03");
  level waittill("armsrace_cache3_activated");
  thread scripts\cp\cp_objectives::run_objective("obj_armsrace_defend3");
  wait 1;
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_reinforcements_3");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_heli_1");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_heli_2");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("armsrace_phase3");
  level thread scripts\cp\utility::objective_update("obj_armsrace_defend3", 120, 30, 10, 1);
  thread dosmokecurtains(level, "armsrace_smoke_bomb_3");
  level waittill("obj_armsrace_defend3_timer_complete");
  level thread scripts\cp\utility::objective_update("obj_armsrace_defend3");
  wait 1;
  level notify("armsrace_cache_secured");
  var0.interaction3.active = 0;
  level notify("stop_armsrace_smoke");
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_cache_4");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_3rd_obj_complete_10", var0.currentteam);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_armsrace_objective_3rd_obj_complete_20", var0.currentteam);
}

function docache4(var0) {
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
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_reinforcements_4");
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
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_warhead_secured");
}

function lower_airlock() {
  level endon("game_ended");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_3rd_obj_jugg_enemy_10", "allies");
  wait 15;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_armsrace_objective_3rd_obj_jugg_dead_10", "allies");
}

function completearmsraceobj(var0) {
  var0.cachewid = undefined;
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
  var0 = scripts\cp\cp_modular_spawning::run_spawn_module("wave_spawning");
  level waittill("player_entered_safehouse_vol");
  var0 = scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
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

function ref_13338(var0) {
  var1 = scripts\engine\utility::getStruct("armsrace_label_" + var0, "script_noteworthy");
  var2 = spawn("script_model", var1.origin);
  var2.angles = scripts\engine\utility::ter_op(isDefined(var1.angles), var1.angles, (0, 0, 0));
  var2 setModel(var1.targetname);
  return var2;
}

function initnuke() {
  var0 = scripts\engine\utility::getStruct("armsrace_interaction_4", "script_noteworthy");
  thread init_silo_thrust_obj(var0);
  ref_13338(4);
  thread ref_13515();
  var1 = spawn("script_model", var0.origin);
  var1 setModel("tag_origin");
  var1.trial_target_enemy_killed_func = var0;
  var1 setHintString(&"CP_OBJ_ARMSRACE/SECURE_BOMB");
  var1 setCursorHint("HINT_BUTTON");
  var1 sethintdisplayrange(200);
  var1 sethintdisplayfov(90);
  var1 setuserange(72);
  var1 setusefov(90);
  var1 sethintonobstruction("hide");
  var1 setuseholdduration("duration_short");
  thread camera_loadout_showcase_preview_small_sticker();
}

function init_silo_thrust_obj(var0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  teamhasfreshsquadleadercandidate();
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = spawn("script_model", var1.origin);

  if(isDefined(var1.angles)) {
    var2.angles = var1.angles;
  }

  var2 setModel(var0.script_modelname);
  var0.cratemodel = var2;
  var0.cratemodel solid();
  var0.cratemodel disconnectPaths();
  heli_leaving_monitor(var2);
}

function camera_loadout_showcase_preview_small_sticker() {
  level endon("game_ended");
  level waittill("armsrace_activate_interaction_4");
  self.ref_11f94 = scripts\engine\utility::getStruct("armsrace_cache_4", "script_noteworthy").origin;
  self.objid = scripts\cp\cp_objectives::requestworldid("armsrace_cache4WID");
  objective_state(self.objid, "current");
  objective_setlocation(self.objid, 0, self.ref_11f94);
  objective_icon(self.objid, "icon_waypoint_objective_general");
  objective_setlabel(self.objid, &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE");
  self makeusable();
  self.secured = 0;

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread activationnuke(self, var0);
    level waittill("armsrace_activate_nuke_open");
    self makeusable();
    self setHintString(&"CP_OBJ_ARMSRACE/TAG_BOMB");
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread activationnuke(self, var0);
    level waittill("armsrace_cache_opened");
    objective_delete(self.objid);
    scripts\cp\cp_objectives::freeworldid("armsrace_cache4WID");
    break;
  }
}

function hintnuke(var0, var1) {
  var2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");

  if(istrue(var2.nukeinteraction.active)) {
    if(istrue(var2.nukeinteraction.secured)) {
      return &"CP_OBJ_ARMSRACE/TAG_BOMB";
    }

    return &"CP_OBJ_ARMSRACE/SECURE_BOMB";
  }

  return "";
}

function activationnuke(var0, var1) {
  if(!istrue(var0.secured)) {
    level notify("armsrace_nuke_activated");
    var0.secured = 1;
    return;
  }

  thread ref_1212a(var0.trial_target_enemy_killed_func.cratemodel);
}

function initarms1() {
  var0 = scripts\engine\utility::getStruct("armsrace_interaction_1", "script_noteworthy");
  scripts\cp\cp_interaction::spawninteractionmodel(var0, scripts\engine\utility::getStruct(var0.target, "targetname"));
  var1 = spawn("script_model", var0.origin);
  var1 setModel("tag_origin");
  ref_13338(1);
  var1 setHintString(&"CP_OBJ_ARMSRACE/SECURE_CACHE");
  var1 setCursorHint("HINT_BUTTON");
  var1 sethintdisplayrange(200);
  var1 sethintdisplayfov(90);
  var1 setuserange(72);
  var1 setusefov(90);
  var1 sethintonobstruction("hide");
  var1 setuseholdduration("duration_short");
  thread camera_loadout_showcase_preview_large_sticker_alt3();
  var2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace_defend1");
  var2.interaction = var1;
}

function camera_loadout_showcase_preview_large_sticker_alt3() {
  level endon("game_ended");
  level waittill("armsrace_activate_interaction_1");
  self.ref_11f94 = scripts\engine\utility::getStruct("armsrace_cache_1", "script_noteworthy").origin;
  self.objid = scripts\cp\cp_objectives::requestworldid("armsrace_cache1WID");
  objective_state(self.objid, "current");
  objective_setplayintro(self.objid, 1);
  objective_setplayoutro(self.objid, 1);
  objective_setlocation(self.objid, 0, self.ref_11f94);
  objective_icon(self.objid, "icon_waypoint_objective_general");
  objective_setlabel(self.objid, &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE");
  self makeusable();

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread activationarms1(self, var0);
    level waittill("armsrace_cache_secured");
    objective_delete(self.objid);
    scripts\cp\cp_objectives::freeworldid("armsrace_cache1WID");
    break;
  }
}

function activationarms1(var0, var1) {
  if(play_takephoto_anim(var1)) {
    level notify("armsrace_cache1_activated");
    return;
  }
}

function initarms2() {
  var0 = scripts\engine\utility::getStruct("armsrace_interaction_2", "script_noteworthy");
  scripts\cp\cp_interaction::spawninteractionmodel(var0, scripts\engine\utility::getStruct(var0.target, "targetname"));
  var1 = spawn("script_model", var0.origin);
  var1 setModel("tag_origin");
  ref_13338(2);
  var1 setHintString(&"CP_OBJ_ARMSRACE/SECURE_CACHE");
  var1 setCursorHint("HINT_BUTTON");
  var1 sethintdisplayrange(200);
  var1 sethintdisplayfov(90);
  var1 setuserange(72);
  var1 setusefov(90);
  var1 sethintonobstruction("hide");
  var1 setuseholdduration("duration_short");
  thread camera_loadout_showcase_preview_large_stock_alt1();
  var2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace_defend2");
  var2.interaction = var1;
}

function camera_loadout_showcase_preview_large_stock_alt1() {
  level endon("game_ended");
  level waittill("armsrace_activate_interaction_2");
  self.ref_11f94 = scripts\engine\utility::getStruct("armsrace_cache_2", "script_noteworthy").origin;
  self.objid = scripts\cp\cp_objectives::requestworldid("armsrace_cache2WID");
  objective_state(self.objid, "current");
  objective_setlocation(self.objid, 0, self.ref_11f94);
  objective_icon(self.objid, "icon_waypoint_objective_general");
  objective_setlabel(self.objid, &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE");
  self makeusable();

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread activationarms2(self, var0);
    level waittill("armsrace_cache_secured");
    objective_delete(self.objid);
    scripts\cp\cp_objectives::freeworldid("armsrace_cache2WID");
    break;
  }
}

function activationarms2(var0, var1) {
  if(play_takephoto_anim(var1)) {
    level notify("armsrace_cache2_activated");
    return;
  }
}

function initarms3(var0) {
  if(var0.size > 0) {
    var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");
    var1.interaction3 = var0[0];
    var1.interaction3.active = 0;
    var1.interaction3.secured = 0;
    scripts\cp\cp_interaction::spawninteractionmodel(var0[0], scripts\engine\utility::getStruct(var0[0].target, "targetname"));
    return;
  }
}

function hintarms3(var0, var1) {
  var2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");

  if(istrue(var2.interaction3.active)) {
    if(istrue(var2.interaction3.secured)) {
      return &"CP_OBJ_ARMSRACE/TAG_CACHE";
    }

    return &"CP_OBJ_ARMSRACE/SECURE_CACHE";
  }

  return "";
}

function activationarms3(var0, var1) {
  var2 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");

  if(!istrue(var2.interaction3.active)) {
    return;
  }

  if(play_takephoto_anim(var1)) {
    level notify("armsrace_cache3_activated");
    var2.interaction3.active = 0;

    if(isDefined(var0.crate)) {
      var3 = ref_13338(3);
      var3.angles = scripts\engine\utility::ter_op(isDefined(var0.crate.angles), var0.crate.angles, (0, 0, 0));
      waitframe();
      var3.origin = scripts\cp\utility::get_point_in_local_ent_space(var0.crate, (-17.61, -24.7, 49.332));
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
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
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var0]]("armsrace_phase1", 0, 16, 200, 0.5, undefined, "armsrace_phase1", &watchforstopwaves, undefined, undefined);
  [[var0]]("armsrace_phase2", 4, 6, 100, [ &waitbetweenspawnwaveswithtimeout, 0.1, 5], undefined, "armsrace_phase2", &watchforstopwaves, undefined, undefined);
  [[var0]]("armsrace_phase2_lasers", 4, 8, 100, 0.25, undefined, "armsrace_phase2_lasers", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_phase2_lasers", &infectedairdroppositions);
  [[var0]]("armsrace_phase_hold", 8, 12, 100, 0.25, undefined, "armsrace_phase_hold", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_phase_hold", &camsetorbit);
  [[var0]]("armsrace_phase3", 10, 10, 200, [ &waitbetweenspawnwaveswithtimeout, 0.1, 10], undefined, "armsrace_phase3", &watchforstopwaves, undefined, undefined);
  [[var0]]("armsrace_phase4", 0, 6, 200, [ &waitbetweenspawnwaveswithtimeout, 0.1, 10], undefined, "armsrace_phase4", &watchforstopwaves, undefined, undefined);
  [[var0]]("armsrace_phase5", 15, 15, 200, [ &waitbetweenspawnwaveswithtimeout, 0.1, 10], undefined, "armsrace_phase5", &watchforstopwaves, undefined, undefined);
  [[var0]]("armsrace_jugg", 0, 2, 2, 0.5, undefined, "armsrace_jugg", &watchforstopwaves, undefined, undefined);
  [[var0]]("armsrace_phase5_sniper", 2, 2, 2, 0.5, undefined, "armsrace_phase5_sniper", &watchforstopwaves, undefined, undefined);
  [[var0]]("armsrace_phase1_lasers", 6, 6, 6, 0.5, undefined, "armsrace_phase1_lasers");
  [[var0]]("armsrace_phase4_lasers", 3, 3, 3, 0.5, undefined, "armsrace_phase4_lasers");
  [[var0]]("armsrace_phase1_sniper", 1, 1, 1, 0.5, undefined, "armsrace_phase1_sniper", &watchforstopwaves, &ref_1445e);
  [[var0]]("armsrace_phase1_sniper_2", 1, 1, 1, 0.5, undefined, "armsrace_phase1_sniper_2", &watchforstopwaves, &ref_1445e);
  [[var0]]("armsrace_trucks_4", 6, 6, 6, [ &waitbetweenspawnwaveswithtimeout, 0.1, 5], undefined, "techo_phys_armsrace1", &watchforstopwaves, undefined, undefined);
  [[var0]]("armsrace_trucks_5", 6, 6, 6, [ &waitbetweenspawnwaveswithtimeout, 0.1, 5], undefined, "techo_phys_armsrace2", &watchforstopwaves, undefined, undefined);
  [[var0]]("payload_lasttrek_sniper", 2, 2, 2, 0.5, undefined, "payload_lasttrek_sniper");
  [[var0]]("payload_lasttrek_rpg", 2, 2, 2, 0.5, undefined, "payload_lasttrek_sniper");
  [[var0]]("payload_armsrace_molotov_chucker", 1, 1, 1, 0.5, undefined, "payload_armsrace_molotov_chucker");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("payload_armsrace_molotov_chucker", &grenade_structs);
  [[var0]]("armsrace_c4_planter_parking", 1, 1, 1, 0.5, undefined, "armsrace_c4_planter_super");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_c4_planter_parking", &camoname);
  [[var0]]("armsrace_c4_planter_super", 1, 1, 1, 0.5, undefined, "armsrace_c4_planter_super");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_c4_planter_super", &camoset);
  [[var0]]("armsrace_c4_planter_backlot", 1, 1, 1, 0.5, undefined, "armsrace_c4_planter_super");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("armsrace_c4_planter_backlot", &cameraentlinktag);

  if(!scripts\engine\utility::flag_exist("armsrace_spawn_functions_registered")) {
    scripts\engine\utility::flag_init("armsrace_spawn_functions_registered");
  }

  scripts\engine\utility::flag_set("armsrace_spawn_functions_registered");
}

function infectedairdroppositions(var0) {
  infecteddisablenvg();
}

function infecteddisablenvg() {
  level endon("game_ended");
  self endon("death");
  wait 1;
  var0 = 1000;
  self.maxfaceenemydist = var0;
  scripts\cp\cp_modular_spawning::set_goal_radius(var0 * 0.65);

  for(;;) {
    var1 = var0;
    var2 = scripts\cp\utility::get_closest_living_player(36000000);

    if(isDefined(var2)) {
      var1 = distance(self.origin, var2.origin);
    }

    if(var1 < var0) {
      scripts\common\utility::demeanor_override("cqb");
      self.maxfaceenemydist = var0;
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

function camsetorbit(var0) {
  self.never_kill_off = 1;
  thread can_activate_battle_station(var0);
}

function can_activate_battle_station(var0) {
  if(isDefined(var0.group_name)) {
    var1 = var0.group_name;
  } else if(isDefined(self.enemy_group)) {
    var1 = self.enemy_group;
  } else {
    var1 = "default";
  }

  if(!isDefined(level.bomb_vest_timer_remaining_time_ms) || !istrue(level.bomb_vest_timer_remaining_time_ms[var1])) {
    thread bomb_vest_timer_remaining_num_of_frame(scripts\engine\utility::getStructArray("super_goal", "targetname"), 400, 0, 200);
    return;
  }

  self.never_kill_off = 0;
  scripts\cp\cp_modular_spawning::set_goal_radius(300);
}

function bomb_vest_timer_remaining_num_of_frame(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    var1 = 400;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  thread bomb_vest_explodes(var0, var2, var3);
  thread bomb_vest_timer_yellow_starting_frame(var1, var2);
  thread bomb_vest_timer_total_num_of_frame(var4);
}

function bomb_vest_success_fail_think(var0, var1, var2) {
  foreach(var4 in var0) {
    thread bomb_vest_timer_frozen(level, var4, var1);
  }
}

function bomb_vest_timer_frozen(var0, var1, var2) {
  level endon("end_hold_behavior");
  var0 notify("ai_hold_debug");
  var0 endon("ai_hold_debug");
  var3 = pressure_overload_threshold(var0, var2);

  for(;;) {
    var4 = var0.origin;

    if(isDefined(var0.radius)) {
      var5 = var0.radius;
    } else {
      var5 = 600;
    }

    level thread scripts\engine\utility::draw_circle(var4, var5, (1, 1, 0), 0.5, 0, 20);

    if(isDefined(var0.ref_127ea) && var0.ref_127ea.size) {
      foreach(var7 in var0.ref_127ea) {
        if(isDefined(var7) && isai(var7) && isalive(var7)) {
          var8 = var7 getentitynumber();

          if(!isDefined(var8)) {
            var8 = "agent";
          }
        }
      }
    }

    wait 1;
  }
}

function bomb_vest_explodes(var0, var1, var2) {
  level endon("game_ended");
  level endon("end_hold_behavior");
  self endon("end_hold_behavior");
  self endon("death");
  var3 = undefined;

  for(;;) {
    var3 = printdata(var0, var2);
    ref_13f8a(self, var3);
    var4 = var3.origin;

    if(isDefined(var3.radius)) {
      var5 = var3.radius;
    } else {
      var5 = 600;
    }

    self.script_origin_other = var4;
    scripts\cp\cp_modular_spawning::set_goal_pos(var4);
    scripts\cp\cp_modular_spawning::set_goal_radius(var5);
    scripts\common\utility::demeanor_override("sprint");
    wait 15;
  }
}

function printdata(var0, var1) {
  var2 = printcodeentered(var0);
  var3 = var2.origin;
  var0 = sortbydistance(var0, var3);

  for(var4 = 0; var4 < var0.size; var4++) {
    if(!triggeregg(var0[var4], var1)) {
      return var0[var4];
    }
  }

  return protect_obj_a(var0);
}

function printcodeentered(var0) {
  var1 = var0[0];
  var2 = 1000000;

  foreach(var4 in var0) {
    var5 = var4 scripts\cp\utility::get_closest_living_player(36000000);

    if(!isDefined(var5)) {
      return scripts\engine\utility::random(var0);
    }

    var6 = distance(var5.origin, var4.origin);

    if(var6 < var2) {
      var2 = var6;
      var1 = var4;
    }
  }

  return var1;
}

function protect_obj_a(var0) {
  var1 = var0[0];

  if(isDefined(var1.script_priority)) {
    var2 = int(var1.script_priority);
  } else {
    var2 = 0;
  }

  for(var3 = 1; var3 < var1.size; var3++) {
    if(isDefined(var1[var3].script_priority)) {
      if(!isDefined(var1[var3 - 1].script_priority) || var2 < int(var1[var3].script_priority)) {
        var2 = int(var1[var3].script_priority);
        var2 = var1[var3];
      }
    }
  }

  return var2;
}

function ref_134d1(var0) {
  for(var1 = 0; var1 < var0.size - 1; var1++) {
    for(var2 = var1 + 1; var2 < var0.size; var2++) {
      var3 = 0;

      if(isDefined(var0[var2].script_priority)) {
        var3 = int(var0[var2].script_priority);
      }

      var4 = 0;

      if(isDefined(var0[var1].script_priority)) {
        var4 = int(var0[var1].script_priority);
      }

      if(var3 < var4) {
        var5 = var0[var2];
        var0 = var0[var1];
        var0 = var5;
      }
    }
  }
}

function quickdropfinditemincache(var0) {
  var1 = prematchplayedwelcomevo();
  var2 = scripts\engine\utility::random(var1);
  var3 = 1000000;

  foreach(var5 in var0) {
    var6 = var5 scripts\cp\utility::get_closest_living_player(36000000);

    if(!isDefined(var6)) {
      continue;
    }

    var7 = distance(var6.origin, var5.origin);

    if(var7 < var3) {
      var3 = var7;
      var2 = var6;
    }
  }

  return var2;
}

function prematchplayedwelcomevo() {
  var0 = [];

  foreach(var2 in level.players) {
    if(isDefined(var2) && isalive(var2) && !scripts\cp\cp_laststand::player_in_laststand(var2)) {
      var0 = var2;
    }
  }

  return var0;
}

function ref_13f8a(var0, var1) {
  if(scripts\engine\utility::array_contains(var1.ref_127ea, var0)) {
    return false;
  }

  if(isDefined(var0.initheadlessoperatorcustomization) && var0.initheadlessoperatorcustomization == var1) {
    return false;
  }

  if(isDefined(var0.initheadlessoperatorcustomization) && scripts\engine\utility::array_contains(var0.initheadlessoperatorcustomization.ref_127ea, var0)) {
    var0.initheadlessoperatorcustomization.ref_127ea = scripts\engine\utility::array_remove(var0.initheadlessoperatorcustomization.ref_127ea, var0);
  }

  var0.initheadlessoperatorcustomization = var1;
  var1.ref_127ea[var1.ref_127ea.size] = var0;
  return true;
}

function triggeregg(var0, var1) {
  if(!isDefined(var0.ref_127ea)) {
    var0.ref_127ea = [];
    return false;
  }

  var2 = pressure_overload_threshold(var0, var1);
  var3 = [];

  foreach(var5 in var0.ref_127ea) {
    if(!isDefined(var5) || !isalive(var5)) {
      continue;
    }

    var6 = 1;

    foreach(var8 in var3) {
      if(var5 == var8) {
        var6 = 0;
        break;
      }
    }

    if(var6) {
      var3 = var5;
    }
  }

  var0.ref_127ea = var3;
  var11 = var0.ref_127ea.size;
  return var11 >= var2;
}

function pressure_overload_threshold(var0, var1) {
  if(var1 < 1) {
    var1 = 1;
  }

  if(!isDefined(var0.radius)) {
    var2 = 600;
  } else {
    var2 = int(var1.radius);
  }

  return int(max(1, var2 / var2));
}

function bomb_vest_timer_yellow_starting_frame(var0, var1) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var0)) {
    var0 = 400;
  }

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, var0 * var0)) {
      break;
    }

    wait 0.25;
  }

  if(istrue(var1)) {
    var2 = "default";

    if(isDefined(self.enemy_group)) {
      var2 = self.enemy_group;
    }

    set_guy_to_specific_pos(var2);
    return;
  }

  bomb_vest_timer_red_starting_frame();
}

function bomb_vest_timer_red_starting_frame() {
  self notify("end_hold_behavior");
}

function set_guy_to_specific_pos(var0) {
  if(!isDefined(level.bomb_vest_timer_remaining_time_ms)) {
    level.bomb_vest_timer_remaining_time_ms = [];
  }

  level.bomb_vest_timer_remaining_time_ms[var0] = 1;
  level notify("end_hold_behavior");
}

function bomb_vest_timer_total_num_of_frame(var0) {
  self endon("death");
  level endon("game_ended");
  level scripts\cp\utility::add_wait(&scripts\cp\utility::waittill_msg, "end_hold_behavior");
  scripts\cp\utility::add_wait(&scripts\cp\utility::waittill_msg, "end_hold_behavior");
  scripts\cp\utility::do_wait_any();
  scripts\common\utility::demeanor_override("combat");
  self.never_kill_off = 0;
  self.script_origin_other = undefined;

  if(isDefined(var0)) {
    self thread[[var0]]();
    return;
  }

  var1 = 300;
  scripts\cp\cp_modular_spawning::set_goal_radius(var1);
  thread scripts\cp\cp_modular_spawning::get_enemy_info_loop();
}

function ref_13515() {
  wait 1;
  var0 = scripts\engine\utility::getStructArray("payload_rpg_pickups", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\cp\cp_weapon::buildweapon(var2.script_noteworthy, [], "none", "none", -1);
    var4 = createheadicon(var3);
    var5 = spawn("weapon_" + var4, var2.origin);

    if(!isDefined(var2.angles)) {
      var2.angles = (0, 0, 0);
    }

    var5.angles = var2.angles;
    var5 itemweaponsetammo(weaponclipsize(var3), weaponmaxammo(var3));
  }
}

function waitbetweenspawnwaveswithtimeout(var0, var1, var2, var3) {
  level endon("game_ended");
  var4 = gettime();
  var5 = var4 + var2 * 1000;

  for(var6 = getaiarray("axis").size; var6 >= 18; var6 = getaiarray("axis").size) {
    wait 1;
  }

  return var1;
}

function ref_1445e(var0) {
  level endon("game_ended");
  wait 4;

  while(var0.activecount > 0) {
    wait 1;
  }

  wait 5;
  return var0.group_name;
}

function watchforstopwaves(var0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var0) {
  level endon("game_ended");
  level waittill("armsrace_cache_secured");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function remove_group_from_combined_module_counters(var0, var1) {
  level endon("game_ended");
  level endon("armsrace_cache_secured");
  wait var1;

  for(var2 = getaiarray("axis").size; var2 >= 18; var2 = getaiarray("axis").size) {
    wait 4;
  }

  return var0.group_name;
}

function grenade_structs(var0) {
  self endon("death");
  self.scripted_mode = 1;
  self.ignoreall = 1;
  self.goalradius = 64;
  self setgoalpos(scripts\engine\utility::getStruct(self.target, "targetname").origin);
  scripts\engine\utility::ref_143a5("goal", "near_goal");
  var1 = scripts\engine\utility::getStruct("payload_molotov_origin", "targetname");
  var2 = scripts\engine\utility::getStruct(var1.target, "targetname");
  thread throw_molotov(var1, var2);
  self.ignoreall = 0;
  self.goalradius = 1024;
  self.scripted_mode = 0;
}

function camoname(var0) {
  var1 = &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE";
  thread cameraentmoving(var0, "armsrace_interaction_1", "obj_armsrace_defend1", var1);
}

function camoset(var0) {
  var1 = &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE";
  thread cameraentmoving(var0, "armsrace_interaction_2", "obj_armsrace_defend2", var1);
}

function cameraentlinktag(var0) {
  var1 = &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE";
  thread cameraentmoving(var0, "armsrace_interaction_4", "obj_armsrace_defend4", var1);
}

function cameraentmoving(var0, var1, var2, var3) {
  self endon("death");
  scripts\common\utility::demeanor_override("sprint");
  self notify("basic_combat");
  wait 1;

  if(isDefined(var2) && !scripts\cp\cp_objectives::is_objective_active(var2)) {
    return;
  }

  var4 = scripts\engine\utility::getStructArray("c4_interact", "targetname");
  var5 = 350;
  var6 = scripts\engine\utility::getStruct(var1, "script_noteworthy");
  var7 = [];
  var8 = [];

  foreach(var10 in var4) {
    if(isDefined(var10) && scripts\engine\utility::distance_2d_squared(var6.origin, var10.origin) < var5 * var5) {
      if(!istrue(var10.planted)) {
        var8 = var10;
      }

      var7 = var10;
    }
  }

  if(var8.size == 0) {
    var8 = var7;
  }

  var12 = scripts\engine\utility::random(var8);
  var12.planted = 1;
  thread camera_loadout_showcase_preview_sticker_alt3(var12);

  if(!isDefined(var12.model)) {
    var12.model = spawn("script_model", scripts\engine\utility::getStruct(var12.target, "targetname").origin);
    var12.model setModel("tag_origin");
    var12.model.angles = scripts\engine\utility::getStruct(var12.target, "targetname").angles;
  }

  scripts\cp\maps\cp_donetsk\milbase\ai_flare::run_to_and_plant_bomb(var12.model);
  thread camera_loadout_showcase_preview_sticker_alt2(level, var2, var12, self);
}

function camera_loadout_showcase_preview_sticker_alt3(var0) {
  self endon("bomb_planted");
  self waittill("death");

  if(isDefined(var0) && istrue(var0.planted)) {
    var0.planted = undefined;
    return;
  }
}

function camera_loadout_showcase_preview_sticker_alt2(var0, var1, var2, var3) {
  level endon("game_ended");

  if(!isDefined(var1) || !isDefined(var1.model) || !isDefined(var1.model.charge)) {
    return;
  }

  var4 = "armsrace_c4" + var2.entity_number;
  var5 = scripts\cp\cp_objectives::requestworldid(var4, 15);
  var6 = var1.model.charge;
  var6.leave_pool_behind_after_deactivation = 25;
  follow_players_when_close(var6, var5);
  thread camera_loadout_showcase_preview_sticker_alt1(var6, var0, var1, var3);
  var7 = &"CP_STRIKE/DEFUSE";
  var6 scripts\cp\utility::create_cursor_hint("tag_origin", undefined, var7, 180, 256, 64, 0, undefined, undefined, undefined, "duration_medium");
  var6 endon("detonated");
  var6 endon("death");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_ARMSDEALER/DEFUSE_BOMB", "allies", 5);
  var6.outlineid = scripts\cp\cp_outline_utility::outlineenableforall(var6, "outline_depth_red", "level_script");

  for(;;) {
    var6 waittill("trigger", var8);
  }

  LOC_000000f6:
    var6 notify("defused");

  if(isDefined(var1.planted)) {
    var1.planted = undefined;
  }

  if(isDefined(var6.outlineid)) {
    scripts\cp\cp_outline_utility::outlinedisable(var6.outlineid, var6);
  }

  footprint_mask_clipheight(var5, var4);
  var6 delete();
}

function follow_players_when_close(var0) {
  if(!isDefined(var0)) {
    return;
  }

  scripts\cp\cp_objectives::objective_set_play_intro(var0, 1);
  objective_setlabel(var0, "CP_ARMSDEALER/DEFUSE_BOMB");
  objective_setshowprogress(var0, 1);
  objective_icon(var0, "icon_waypoint_cyber_bombsite");
  objective_position(var0, self.origin + (0, 0, 15));
  objective_setprogress(var0, 1);
  objective_state(var0, "current");
  objective_setownerteam(var0, "axis");
}

function footprint_mask_clipheight(var0, var1) {
  if(isDefined(var0)) {
    objective_delete(var0);
    scripts\cp\cp_objectives::freeworldid(var1);
    return;
  }
}

function camera_loadout_showcase_preview_sticker_alt1(var0, var1, var2, var3) {
  self endon("death");
  self endon("defused");
  level endon("game_ended");
  var4 = self.leave_pool_behind_after_deactivation;
  var5 = var4;
  var6 = var4;

  while(var6 > 0) {
    var6--;
    objective_setprogress(var3, var6 / var5);

    if(soundexists("breach_warning_beep_05")) {
      foreach(var8 in level.players) {
        var8 playSound("breach_warning_beep_05");
      }
    }

    wait 1;
  }

  var10 = "frag";
  var11 = 0.1;
  var12 = magicgrenademanual(var10, self.origin + (0, 0, 6), (0, 0, 0), var11);
  var12.angles = self.angles;
  self notify("detonated");

  if(isDefined(var1.planted)) {
    var1.planted = undefined;
  }

  if(isDefined(self.outlineid)) {
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);
  }

  playFX(level._effect["vfx_payload_rpg_hit"], self.origin);
  self playSound("rocket_explode");
  footprint_mask_clipheight(var3);
  wait 1;

  if(isDefined(var0) && scripts\cp\cp_objectives::is_objective_active(var0)) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    var13 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_payload");
    var13.pathdist = 1;
  }

  self delete();
}

function debugarmsraceobjectivestart(var0) {
  scripts\engine\utility::flag_set("cp_armsrace_cs");
  scripts\engine\utility::flag_wait("cp_armsrace_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "armsrace_debug_start_loc");
}

function waitforoneplayernearpoint(var0, var1) {
  level endon("game_ended");

  for(;;) {
    var2 = 0;

    foreach(var4 in level.players) {
      if(distance(var4.origin, var0) <= var1) {
        var2 = 1;
      }
    }

    if(var2) {
      return;
    }

    waitframe();
  }
}

function setnewarmsracecacheloc(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(var0 > 4 || var0 < 1) {
    var0 = 1;
  }

  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("obj_armsrace");
  var1.curcache = var0;
  var1.curcachelocation = scripts\engine\utility::getStruct("armsrace_cache_" + var0, "script_noteworthy").origin;
  objective_state(var1.cachewid, "current");
  objective_setlocation(var1.cachewid, 0, var1.curcachelocation);
  objective_icon(var1.cachewid, "icon_waypoint_objective_general");
  objective_setlabel(var1.cachewid, &"CP_BR_SYRK_OBJECTIVES/ARMSRACE_CACHE");
}

function dropcarepackage() {
  level endon("game_ended");
  var0 = scripts\engine\utility::getStruct("armsrace_crate_drop", "script_noteworthy");
  var1 = scripts\engine\utility::drop_to_ground(var0.origin, 50, -200, (0, 0, 1));
  var1 += (0, 0, 1);
  var2 = dropcratefrommanualheli(var1);
  thread oncratedrop(var2, var1);
  return var2;
}

function dropcratefrommanualheli(var0) {
  var1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "attachment", "munition"));
  var2 = scripts\cp_mp\killstreaks\airdrop::dropcratefrommanualheli(undefined, "allies", "cp_armsrace_crate", var0, (0, randomfloat(360), 0), 30000, 30000, var0, scripts\cp\killstreaks\airdrop_cp::getcpcratedatabytype("cp_loadout"));

  if(!isDefined(var2)) {
    return undefined;
  } else if(!isDefined(var2.crate)) {
    return undefined;
  }

  return var2.crate;
}

function oncratedrop(var0, var1) {
  var2 = spawn("script_model", var0);
  var2 setModel("offhand_wm_grenade_smoke");
  var2.angles = (0, 90, 90);
  var3 = spawn("script_model", var0);
  var3 setModel("ks_crate_marker_mp");
  var3 setscriptablepartstate("smoke", "on", 0);
  thread watchforcratecapture(var2);
  thread watchforcratecapture(var3);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(600);

  if(isDefined(var1.script_linkname) && isDefined(level.crates_active_at_location[var1.script_linkname])) {
    level.crates_active_at_location[var1.script_linkname] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }

  if(isDefined(var3)) {
    var3 delete();
  }

  if(isDefined(var2)) {
    var2 delete();
    return;
  }
}

function watchforcratecapture(var0) {
  self endon("death");
  var0 waittill("death");
  self delete();
}

function start_convoy(var0, var1, var2) {
  var3 = scripts\engine\utility::getStruct(var1, "targetname");

  if(!isDefined(var2)) {
    var2 = "single-techo-cargo";
  }

  thread set_convoy_settings(level, var0, var2);
}

function set_convoy_settings(var0, var1, var2) {
  level endon("game_ended");
  var3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var4 = level[[var3]](var0, var1, var2);
  var4 thread scripts\cp\maps\cp_payload\cp_objs_payload::select_bunker_server_one_spawners();
  level thread scripts\cp\maps\cp_payload\cp_objs_payload::allow_driver_exit(var4);
  var4 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  level waittill("despawn_" + var0);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

function play_takephoto_anim() {
  var0 = "intel_take_photo";
  var1 = self getcurrentweapon();
  var2 = getcompleteweaponname(var0);
  thread freeze_until_phototaken();
  scripts\cp\utility::_giveweapon(var2);
  self switchtoweapon(var2);
  self setclientomnvar("ui_tablet_usb", 7);
  var3 = 3;
  wait var3;

  if(isPlayer(self)) {
    self takeweapon(var2);
    self switchtoweapon(var1);
    self setclientomnvar("ui_tablet_usb", 0);
    return true;
  }

  return false;
}

function freeze_until_phototaken() {
  togglecellphoneallows(1);
  var0 = 1.3;
  wait var0;
  togglecellphoneallows(0);
}

function togglecellphoneallows(var0) {
  scripts\cp\utility::_freezelookcontrols(var0);
  scripts\common\utility::allow_movement(!var0);
  scripts\common\utility::allow_jump(!var0);
  scripts\common\utility::allow_usability(!var0);
  scripts\common\utility::allow_melee(!var0);
  scripts\common\utility::allow_offhand_weapons(!var0);
  scripts\common\utility::allow_weapon_switch(!var0);
}

function dosmokecurtains(var0, var1) {
  level endon("game_ended");
  level endon("armsrace_cache_secured");
  wait var1;
  var2 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");
  var3 = 8;

  foreach(var5 in var2) {
    var6 = randomfloat(2);
    thread ref_14403(var5, var6);
    waitframe();
  }
}

function ref_14403(var0, var1) {
  level endon("game_ended");
  wait var1;
  var2 = spawn("script_model", var0.origin);
  var2 setModel("tag_origin");
  var2.angles = scripts\engine\utility::ter_op(isDefined(var0.angles), var0.angles, (0, 0, 0));
  waitframe();
  playFXOnTag(level._effect["vfx_armsrace_smoke"], var2, "tag_origin");
  var2 playLoopSound("smoke_grenade_smoke_lp");
  level waittill("stop_armsrace_smoke");
  var3 = randomfloat(0.5);
  var2 scripts\engine\utility::delaycall(var3, &playsound, "smoke_grenade_smoke_tail");
  stopFXOnTag(level._effect["vfx_armsrace_smoke"], var2, "tag_origin");
  wait 0.25;
  var2 stoploopsound();
  wait 4.25;
  var2 delete();
}

function spawn_atvs() {
  if(!isDefined(level.atvs)) {
    level.atvs = [];
  }

  var0 = scripts\engine\utility::getStructArray("armsrace_atv_spawn", "script_noteworthy");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var0, 1);
  var1 = scripts\cp\cp_objectives::requestworldid("armsrace_atvs");
  var2 = scripts\engine\utility::getStruct("armsrace_vehicle_marker", "script_noteworthy").origin;
  objective_setplayintro(var1, 0);
  objective_setplayoutro(var1, 0);
  objective_state(var1, "current");
  objective_setlabel(var1, &"CP_ARMSDEALER/ARMSRACE_ATVS");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_setbackground(var1, 1);
  objective_setshowoncompass(var1, 1);
  objective_position(var1, var2);
  thread ref_144d8(level);
}

function ref_144d8(var0) {
  level endon("game_ended");
  var1 = scripts\cp\utility::array_merge(level.players, [level]);
  level scripts\engine\utility::waittill_any_ents_array(var1, "entered_vehicle", "player_entered_safehouse_vol");
  objective_delete(var0);
}

#using_animtree("script_model");

function heli_leaving_monitor(var0) {
  var0 useanimtree(#animtree);
  var0.animname = "nuke";
  var0 thread scripts\common\anim::anim_first_frame_solo(var0, "nuke_open");
}

#using_animtree("");

function ref_1212a(var0) {
  if(!isDefined(var0)) {
    scripts\cp\utility::debugprintline("no crate defined");
    level notify("armsrace_cache_opened");
    return;
  }

  var0 useanimtree(#animtree);
  var0.animname = "nuke";
  var0 thread scripts\common\anim::anim_single_solo(var0, "nuke_open");
  wait getanimlength(level.scr_anim["nuke"]["nuke_open"]);
  level notify("armsrace_cache_opened");
}

function teamhasfreshsquadleadercandidate() {
  level.scr_animtree["nuke"] = #animtree;
  level.scr_anim["nuke"]["nuke_open"] = % cp_prop_nuclear_warhead_open;
  level.scr_animname["nuke"]["nuke_open"] = "cp_prop_nuclear_warhead_open";
}

function ref_11ce4(var0) {
  level endon("game_ended");
  level endon("armsrace_cache_secured");
  var1 = scripts\engine\utility::getStructArray("molotov_origin", "targetname");
  var2 = 0;

  for(;;) {
    var3 = randomint(var1.size);
    var4 = scripts\engine\utility::getStruct(var1[var3].target, "targetname");

    if(throw_molotov(var1[var3], var4)) {
      var2++;

      if(isDefined(var0) && var2 >= var0) {
        break;
      }

      wait 3;
      continue;
    }

    wait 2;
  }
}

function throw_molotov(var0, var1) {
  if(isDefined(getaiarray("axis")[0])) {
    var2 = getaiarray("axis")[0];
  } else {
    return false;
  }

  var3 = var0.angles;
  var4 = anglesToForward(var3) * 450;

  if(isDefined(var1)) {
    var5 = var0.origin;
    var6 = (var1.origin[0], var1.origin[1], var1.origin[2]);
    var7 = var6 - var5;
    var7 = vectorNormalize(var7);
    var4 = var7 * 600;
  }

  var8 = var2 launchgrenade("molotov_mp", var0.origin, var4);
  var8.owner = var2;
  var2 thread scripts\cp\powers\coop_molotov::molotov_used(var8);
  return true;
}

function trial_time_remaining(var0, var1) {
  foreach(var3 in level.players) {
    if(distance2d(var3.origin, var0) <= var1) {
      return true;
    }
  }

  return false;
}