/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_camp.gsc
*****************************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("player_water_breach");
  common_scripts\utility::flag_init("flag_camp_move_allies");
  common_scripts\utility::flag_init("flag_camp_front_retreat");
  common_scripts\utility::flag_init("flag_camp_mid_retreat");
  common_scripts\utility::flag_init("flag_camp_building_open");
  common_scripts\utility::flag_init("flag_bc_porch_runner_done");
  common_scripts\utility::flag_init("flag_camp_helo_retreat");
  common_scripts\utility::flag_init("flag_camp_helo_spawn");
  common_scripts\utility::flag_init("flag_camp_helo_ready");
  common_scripts\utility::flag_init("flag_camp_helo_unload");
  common_scripts\utility::flag_init("flag_camp_back_retreat");
  common_scripts\utility::flag_init("flag_camp_back_lmg_retreat");
  common_scripts\utility::flag_init("flag_camp_street_retreat");
  common_scripts\utility::flag_init("bc_flag_alarm_start");
  common_scripts\utility::flag_init("flag_camp_cleared");
  common_scripts\utility::flag_init("flag_allies_reached_ascend");
  common_scripts\utility::flag_init("bc_flag_spots_close");
  common_scripts\utility::flag_init("bc_flag_spots_off");
  common_scripts\utility::flag_init("flag_ascend_ready_alpha_0");
  common_scripts\utility::flag_init("flag_ascend_ready_alpha_1");
  common_scripts\utility::flag_init("flag_ascend_ready_bravo_0");
  common_scripts\utility::flag_init("flag_ascend_ready_bravo_1");
  common_scripts\utility::flag_init("flag_bravo_ascend_ready");
  common_scripts\utility::flag_init("flag_vision_campinteriors");
}

section_post_inits() {
  common_scripts\utility::array_call(getEntArray("opt_hide_camp", "script_noteworthy"), ::hide);
}

section_

start() {
  iprintln("Camp");
  maps\black_ice_util::player_start("player_start_camp");
  thread basecamp_dof();

  if(!isDefined(level._bravo) || level._bravo.size < 2) {
    maps\black_ice_util::spawn_bravo();
  }

  thread maps\black_ice_anim::swim_truck_surface_anim();
  level.breach_anim_node = common_scripts\utility::getstruct("breach_anim_node", "script_noteworthy");
  thread maps\black_ice_swim::create_persistent_ice_breach_props(1);
  thread maps\black_ice_swim::handle_ice_plugs();
  level.const_expected_num_swim_allies = 2;
  level._allies_swim = maps\black_ice_util::spawn_allies_swim();
  common_scripts\utility::array_call(level._allies_swim, ::attach, level.scr_model["ascend_launcher_non_anim"], "TAG_STOWED_BACK");
  level.allies_breach_anim_node = common_scripts\utility::getstruct("vignette_introbreach_allies", "script_noteworthy");

  for(var_0 = 0; var_0 < level._allies_swim.size; var_0++) {
    level._allies_swim[var_0].animname = "scuba_ally";
    level.allies_breach_anim_node thread maps\_anim::anim_loop_solo(level._allies_swim[var_0], "surface_ally" + (var_0 + 1) + "_idle");
  }

  level.player.hud_scubamask = level.player maps\_hud_util::create_client_overlay("scubamask_overlay_delta", 1, level.player);
  level.player.hud_scubamask.foreground = 0;
  level.player.hud_scubamask.sort = -99;
  level.player.hud_scubamask.enablehudlighting = 1;
  common_scripts\utility::flag_set("flag_player_breaching");
  level.player allowswim(1);
  thread maps\black_ice_swim::black_fade(0.0, 0.4, 0.0);
  maps\black_ice_swim::surface_breach();
  thread maps\black_ice_swim::player_post_swim();
}

main() {
  common_scripts\utility::array_call(getEntArray("opt_hide_camp", "script_noteworthy"), ::show);
  level.player setthreatbiasgroup("player");
  setup_spawners();
  thread maps\black_ice_audio::sfx_distant_oil_rig();
  thread camp_primary_light_switch();
  thread bc_intro();
  thread ascend_snow_fx();
  level bc_front();
  level bc_mid();
  level bc_back();
  level bc_helo_reinforce();
  level bc_street();
  level bc_ascend();
  level bc_end();
}

ascend_snow_fx() {
  level endon("notify_start_catwalks_snow");
  var_0 = 0;

  for(;;) {
    if(common_scripts\utility::flag("flag_ascend_snow_fx")) {
      if(var_0 == 0) {
        common_scripts\utility::exploder("ascend_snow_huge");
        var_0 = 1;
      }
    } else if(var_0 == 1) {
      maps\_utility::stop_exploder("ascend_snow_huge");
      var_0 = 0;
    }

    wait(level.timestep);
  }
}

bc_intro() {
  thread heli_spawn_and_path("bc_veh_intro_helo");
  maps\_utility::array_spawn_targetname("bc_opfor_crawl", 1, 1);
  maps\_utility::autosave_by_name("ice_surface");
  common_scripts\utility::flag_wait("flag_player_breaching");
  level._allies[0] thread maps\_utility::set_force_color("r");
  level._allies[1] thread maps\_utility::set_force_color("b");
  level._bravo[0] thread maps\_utility::set_force_color("b");
  level._bravo[1] thread maps\_utility::set_force_color("r");
  common_scripts\utility::flag_wait("player_water_breach");
  maps\_utility::autosave_by_name("camp_start");
  thread bc_amb_fx();
  thread bc_snow_tweaks();
  thread maps\black_ice_audio::sfx_truck_sinking();
  level waittill("bc_player_ready");
  common_scripts\utility::flag_wait_or_timeout("flag_camp_move_allies", 3);
  level._allies[0] maps\_utility::ent_flag_set("flag_camp_move_ally");
  level._bravo[0] maps\_utility::delaythread(0.5, maps\_utility::ent_flag_set, "flag_camp_move_ally");
  level._allies[1] maps\_utility::delaythread(5.75, maps\_utility::ent_flag_set, "flag_camp_move_ally");
  level._bravo[1] maps\_utility::delaythread(6.25, maps\_utility::ent_flag_set, "flag_camp_move_ally");
}

bc_snow_tweaks() {
  setsaveddvar("r_snowAmbientColor", (0.06, 0.08, 0.17));
}

bc_amb_fx() {
  common_scripts\utility::exploder("basecamp_snow");
  common_scripts\utility::exploder("basecamp_lights");
  thread maps\black_ice_fx::coldbreathfx();
}

bc_front() {
  common_scripts\utility::flag_wait("player_water_breach");
  maps\_utility::array_spawn_targetname("bc_opfor_run");
  maps\_utility::delaythread(1.5, maps\_utility::array_spawn_targetname, "bc_opfor_runback");
  level waittill("bc_player_ready");
  thread bc_front_fic();
  maps\black_ice_util::delay_retreat("bc_opfor", 90, 2, "flag_camp_front_retreat", "bc_color_mid", 1, "bc_start_mid_nag");
}

bc_mid() {
  maps\_utility::autosave_by_name("camp_mid");
  thread bc_mid_fic();
  common_scripts\utility::flag_wait("flag_camp_building_open");
  setthreatbias("axis", "player", 250);
  thread bc_rolling_door_open();
  var_0 = getent("trig_left_flank", "script_noteworthy");
  var_0 thread left_flank_spawn_proc();
  wait 1;
  maps\black_ice_util::delay_retreat("bc_opfor", 180, 4, "flag_camp_mid_retreat", "bc_color_back", 1);
}

bc_back() {
  thread bc_back_fic();
  var_0 = getEntArray("bc_opfor_back", "targetname");
  maps\_utility::flood_spawn(var_0);
  maps\_utility::delaythread(2.0, maps\_spawner::killspawner, 66);
  wait 1;
  maps\black_ice_util::delay_retreat("bc_opfor", 180, 5, "flag_camp_helo_retreat");
}

bc_helo_reinforce() {
  thread bc_helo_fic();
  var_0 = getent("bc_veh_reinforce_helo", "targetname");
  level.op_helo = var_0 maps\_utility::spawn_vehicle();
  level.op_helo.animname = "bc_reinforce_helo";
  var_1 = maps\_utility::array_spawn(getEntArray("bc_opfor_helo_rein", "targetname"), 1);
  var_2 = common_scripts\utility::getstruct("vignette_basecamp_heli", "script_noteworthy");
  level.op_helo thread maps\black_ice_audio::sfx_blackice_helo_flyby();
  var_2 maps\_anim::anim_first_frame_solo(level.op_helo, "arrive");

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isai(var_4) && isalive(var_4)) {
      var_2 thread maps\_anim::anim_single_solo(var_4, "arrive");
    }
  }

  var_2 maps\_anim::anim_single_solo(level.op_helo, "arrive");
  common_scripts\utility::flag_set("flag_camp_helo_unload");
  var_2 notify("stop_loop");
  var_2 thread maps\_anim::anim_single_solo(level.op_helo, "leave");

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isai(var_4) && isalive(var_4)) {
      var_4.allowdeath = 1;
      var_2 thread maps\_anim::anim_single_solo(var_4, "leave", undefined, 0.1);
    }
  }

  level.op_helo thread bc_helo_reinforce_kill();
  wait 1;
  maps\black_ice_util::delay_retreat("bc_opfor", 15, 7, "flag_camp_back_retreat", "bc_color_street", 1);
}

bc_street() {
  thread bc_street_fic();
  maps\_utility::array_spawn(getEntArray("bc_opfor_street", "targetname"), undefined, 1);
  thread maps\_spawner::killspawner(64);
  thread maps\_spawner::killspawner(65);
  thread maps\_spawner::killspawner(66);
  thread maps\_spawner::killspawner(67);
  thread maps\_spawner::killspawner(69);
  thread bc_street_cleanup();
  maps\_utility::delaythread(4, common_scripts\utility::flag_set, "flag_camp_back_lmg_retreat");
  setthreatbias("bc_lmg", "player", 250);
  wait 1;
  maps\black_ice_util::delay_retreat("bc_opfor", 180, 5, "flag_camp_street_retreat", "bc_color_ascend", 1);
  thread maps\_spawner::killspawner(68);
}

bc_street_cleanup() {
  wait 0.5;
  var_0 = common_scripts\utility::get_array_of_closest(level.player.origin, maps\_utility::get_ai_group_ai("bc_opfor"));
  var_1 = [];
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isalive(var_0[var_3]) && isDefined(var_0[var_3].goalpos) && var_0[var_3].goalpos[1] < 1900) {
      var_1[var_1.size] = var_0[var_3];
      continue;
    }

    if(!isDefined(var_0[var_3].script_startingposition)) {
      var_2[var_2.size] = var_0[var_3];
    }
  }

  for(var_3 = 4; var_3 < var_1.size; var_3++) {
    var_1[var_3].health = 1;
    var_1[var_3] setthreatbiasgroup("bc_killme");

    if(var_3 >= 6) {
      var_1[var_3] thread maps\_utility_code::kill_deathflag_proc(0.5);
    }
  }

  for(var_3 = 2; var_3 < var_2.size; var_3++) {
    if(!maps\_utility::player_can_see_ai(var_2[var_3]) && !var_2[var_3] cansee(level.player)) {
      var_2[var_3] thread maps\_utility_code::kill_deathflag_proc(0.5);
    }
  }
}

bc_ascend() {
  thread bc_ascend_fic();
  maps\black_ice_util::delay_retreat("bc_opfor", 30, 4, "bc_flag_alarm_start");
  thread maps\black_ice_audio::sfx_distant_alarm();
  thread fake_spot("cw_spotlight_2", "cw_spot_2_org");
  thread fake_spot("cw_spotlight_3", "cw_spot_3_org");
  maps\black_ice_util::delay_retreat("bc_opfor", 90, 1, "flag_camp_cleared");
  thread maps\black_ice_ascend::hanging_cargo_motion();
}

bc_end() {
  thread bc_end_fic();
  var_0 = maps\_utility::get_ai_group_ai("bc_opfor");
  common_scripts\utility::array_thread(var_0, maps\_utility_code::kill_deathflag_proc, 2.5);
  thread maps\_utility::clearthreatbias("player", "bc_lmg");
  thread maps\_utility::clearthreatbias("player", "axis");
  level.ascend_anim_node = getent("vignette_alpha_team_rigascend", "script_noteworthy");
  var_1 = getent("vignette_rigascend_runin_node", "script_noteworthy");
  level.ally1_ascend_launcher = maps\_utility::spawn_anim_model("ally1_ascend_launcher");
  level.ally1_ascend_launcher hide();
  level._allies[0].launcher = level.ally1_ascend_launcher;
  level.ally2_ascend_launcher = maps\_utility::spawn_anim_model("ally2_ascend_launcher");
  level.ally2_ascend_launcher hide();
  level._allies[1].launcher = level.ally2_ascend_launcher;
  level.bravo1_ascend_launcher = maps\_utility::spawn_anim_model("bravo1_ascend_launcher");
  level.bravo1_ascend_launcher hide();
  level._bravo[0].launcher = level.bravo1_ascend_launcher;
  level.bravo2_ascend_launcher = maps\_utility::spawn_anim_model("bravo2_ascend_launcher");
  level.bravo2_ascend_launcher hide();
  level._bravo[1].launcher = level.bravo2_ascend_launcher;

  foreach(var_4, var_3 in level._allies) {
    var_3 thread maps\black_ice_ascend::runin_to_ascend(var_1, "flag_ascend_ready_alpha_" + maps\_utility::string(var_4));
  }

  foreach(var_4, var_6 in level._bravo) {
    var_6 thread maps\black_ice_ascend::runin_to_ascend(var_1, "flag_ascend_ready_bravo_" + maps\_utility::string(var_4));
  }

  common_scripts\utility::flag_wait_all("flag_ascend_ready_alpha_0", "flag_ascend_ready_alpha_1");
  level.launchers_attached = 0;
}

debug_end() {
  for(;;) {
    iprintln(maps\_utility::get_ai_group_sentient_count("bc_opfor"));
    wait 0.1;
  }
}

bc_front_fic() {
  level endon("stop_front_fic");
  wait 1;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_letthemregroup");
}

bc_mid_fic() {
  level notify("stop_front_fic");
  level endon("stop_mid_fic");
  common_scripts\utility::flag_wait("flag_camp_building_open");
  wait 0.5;
  level._bravo[1] maps\_utility::smart_dialogue("blackice_grn_activityahead");
  wait 1.0;
  level._allies[0] maps\_utility::smart_dialogue("black_ice_bkr_takecovermultipletangos");
}

bc_back_fic() {
  level notify("stop_mid_fic");
  level endon("stop_back_fic");
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_fallingback");
}

bc_helo_fic() {
  level notify("stop_back_fic");
  level endon("stop_helo_fic");
  wait 2;
  level._bravo[0] maps\_utility::smart_dialogue("black_ice_diz_getreadyenemyhelo");
  common_scripts\utility::flag_wait("flag_camp_helo_unload");
  wait 1.0;
  level._bravo[0] maps\_utility::smart_dialogue("black_ice_bkr_helodroppingenemiesin");
}

bc_street_fic() {
  level endon("stop_street_fic");
  level._allies[1] maps\_utility::smart_dialogue("blackice_fnt_retreating");
  wait 1.5;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_gettocatwalks");
}

bc_ascend_fic() {
  level notify("stop_street_fic");
  level endon("stop_ascend_fic");
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_cleanemup");
  common_scripts\utility::flag_wait("bc_flag_alarm_start");
  wait 0.5;
  level._bravo[0] maps\_utility::smart_dialogue("blackice_diz_mobilizing");
}

bc_end_fic() {
  level notify("stop_ascend_fic");
  wait 1;
  level._allies[0] maps\_utility::smart_dialogue("blackice_bkr_movegetover");
  common_scripts\utility::flag_wait_all("flag_ascend_ready_alpha_0", "flag_ascend_ready_alpha_1");
  var_0 = ["blackice_bkr_ascendpoint", "blackice_bkr_movegetover", "blackice_bkr_settingup", "blackice_bkr_muchtime"];

  for(var_1 = 10; !common_scripts\utility::flag("flag_ascend_triggered"); var_1 = var_1 + 2) {
    level._allies[0] maps\_utility::smart_dialogue(var_0[randomint(var_0.size)]);
    wait(randomfloatrange(var_1, var_1 + 2.0));
  }
}

heli_spawn_and_path(var_0) {
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  level.op_helo = var_1;
  var_1 endon("death");
  var_1.fastropeoffset = 322;

  if(var_0 == "bc_veh_intro_helo") {
    var_1 vehicle_turnengineoff();
  }

  var_1 waittill("reached_dynamic_path_end");
  var_1 delete();
}

bc_rolling_door_open() {
  var_0 = getent("bc_rolling_door", "targetname");
  var_1 = getent("bc_rolling_door_close", "targetname");
  var_0 linkto(var_1);
  var_2 = getent("cw_clip_inside_building", "targetname");
  var_3 = getent("bc_rolling_door_clip", "targetname");
  var_3 delete_path_clip();
  thread maps\black_ice_audio::sfx_blackice_door_rollup(var_0);
  var_4 = 1.25;
  var_5 = getent("bc_rolling_door_open", "targetname");
  var_1 moveto(var_5.origin, var_4, 0.5, 0.25);
  var_1 rotateto(var_5.angles, var_4, 0.5, 0.25);
  level notify("bc_opening_rolling_door");
  wait(var_4);
  level notify("bc_rolling_door_open");
  var_2 delete_path_clip();
}

left_flank_spawn_proc() {
  level endon("flag_camp_back_retreat");
  self waittill("trigger");
  wait 1;

  while(level.mid_window_count > 0) {
    wait 0.1;
  }

  var_0 = getent("bc_opfor_flank_left", "targetname");

  if(isDefined(var_0) && var_0.count > 0) {
    var_0 maps\_utility::spawn_ai();
    var_0 delete();
  }
}

bc_helo_reinforce_kill() {
  self endon("death");
  self waittillmatch("single anim", "end");
  self delete();
}

setup_spawners() {
  level.mid_window_count = 2;
  maps\_utility::array_spawn_function_targetname("bc_opfor_crawl", ::opfor_crawl);
  maps\_utility::array_spawn_function_targetname("bc_opfor_run", ::opfor_run);
  maps\_utility::array_spawn_function_targetname("bc_opfor_runback", ::opfor_runback);
  maps\_utility::array_spawn_function_noteworthy("bc_opfor_mid_normal", ::opfor_mid_normal);
  maps\_utility::array_spawn_function_targetname("bc_opfor_mid_lmg", ::opfor_bc_lmg);
  maps\_utility::array_spawn_function_noteworthy("bc_opfor_kicker", ::opfor_kicker);
  maps\_utility::array_spawn_function_targetname("bc_opfor_mid_window", ::opfor_mid_window);
  maps\_utility::array_spawn_function_targetname("bc_opfor_flank_left", ::opfor_left_flank_run);
  maps\_utility::array_spawn_function_targetname("bc_opfor_helo_rein", ::opfor_helo_rein);
  var_0 = getEntArray("bc_opfor_flank_right", "targetname");

  foreach(var_3, var_2 in var_0) {
    if(randomint(3 - var_3) == 0) {
      var_2 delete();
    }
  }

  setthreatbias("bc_lmg", "player", 1000);
  setthreatbias("allies", "bc_killme", 10000);
}

opfor_crawl() {
  self endon("death");
  maps\_utility::force_crawling_death(0.0, randomintrange(2, 3), undefined, 1);
  maps\_utility::gun_remove();
  wait 0.05;
  level.player radiusdamage(self.origin, 32, self.health, self.health, level.player, "MOD_RIFLE_BULLET");
}

opfor_run() {
  self endon("death");
  self.animname = "generic";

  if(isDefined(self.script_parameters)) {
    var_0 = getent(self.script_parameters, "targetname");
    var_1 = 0.1;

    if(self.script_parameters == "camp_pain_short_1") {
      var_1 = 1;
    } else if(self.script_parameters == "camp_pain_tumble") {
      self.ragdoll_immediate = 1;
    }

    if(isDefined(self.script_noteworthy)) {
      thread maps\_utility::smart_dialogue(self.script_noteworthy);
    }

    self.allowdeath = 1;
    var_0 maps\_anim::anim_generic_first_frame(self, self.script_parameters);
    var_0 maps\_anim::anim_single_solo(self, self.script_parameters, undefined, var_1, "generic");

    if(self.script_parameters == "camp_pain_dead") {
      self kill();
    } else if(self.script_parameters == "camp_pain_tumble") {
      self.ragdoll_immediate = undefined;
    }
  }
}

opfor_runback() {
  self endon("death");
  self.animname = "generic";
  maps\_utility::gun_remove();
  maps\_utility::set_ignoreall(1);
  maps\_utility::set_generic_run_anim("unarmed_run", 1);
  var_0 = getent(self.target, "targetname");
  var_0 maps\_anim::anim_generic_reach(self, self.script_parameters);

  if(isDefined(self.script_noteworthy)) {
    thread maps\_utility::smart_dialogue(self.script_noteworthy);
  }

  self.allowdeath = 1;
  var_0 maps\_anim::anim_single_solo(self, self.script_parameters, undefined, 0.1, "generic");
  var_1 = getnode(self.target, "script_noteworthy");
  maps\_utility::follow_path(var_1);
  self waittill("goal");
  maps\_utility::gun_recall();
  maps\_utility::set_ignoreall(0);
  maps\_utility::clear_run_anim();
  var_0 = getnode("bc_node_front_right", "targetname");
  maps\_utility::follow_path(var_0);
}

opfor_mid_normal() {
  self endon("death");

  if(isDefined(self.script_parameters) && self.script_parameters == "porch_runner" && randomint(4) > 0) {
    thread opfor_porch_runner();
    return;
  }

  var_0 = getnode(self.target, "targetname");
  thread ignore_move_suppression("stop_suppression_workaround");
  thread maps\_utility::notify_delay("stop_suppression_workaround", 10);
  maps\_utility::delaythread(10.05, maps\_utility::set_ignoresuppression, 0);
  common_scripts\utility::flag_wait("flag_camp_mid_retreat");
  thread maps\_utility::follow_path(getnode(var_0.target, "targetname"));
}

opfor_porch_runner() {
  self endon("death");
  thread ignore_move_suppression("stop_suppression_workaround");
  thread maps\_utility::follow_path(getnode("bc_node_porch_start", "targetname"));
  common_scripts\utility::flag_wait("flag_bc_porch_runner_done");
  thread maps\_utility::notify_delay("stop_suppression_workaround", 5);
  maps\_utility::delaythread(5.05, maps\_utility::set_ignoresuppression, 0);
}

ignore_move_suppression(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    self endon(var_0);
  }

  for(;;) {
    if(self ismovesuppressed()) {
      maps\_utility::set_ignoresuppression(1);
      wait 4;
    } else if(isDefined(self.ignoresuppression) && self.ignoresuppression)
      maps\_utility::set_ignoresuppression(0);

    wait 0.25;
  }
}

opfor_bc_lmg() {
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
}

opfor_kicker() {
  self endon("death");
  var_0 = getnode("bc_node_door_kick_leave", "targetname");
  thread maps\_utility::follow_path(var_0);
}

opfor_mid_window() {
  self waittill("death");
  level.mid_window_count = level.mid_window_count - 1;
}

opfor_left_flank_run() {
  self endon("death");
  thread maps\_utility::follow_path(getnode("bc_node_windows", "targetname"));
  maps\_utility::set_ignoreall(1);
  var_0 = common_scripts\utility::getstruct("bc_left_flank_runaway", "targetname");

  while(distance2d(self.origin, var_0.origin) > 70) {
    wait 0.05;
  }

  if(level.mid_window_count < 1 && distance2d(level.player.origin, var_0.origin) > 300) {
    var_0 maps\_anim::anim_generic_reach(self, "run_180_1");
    self.allowdeath = 1;
    var_0 maps\_anim::anim_single_solo(self, "run_180_1", undefined, 0.5, "generic");
    thread maps\_utility::follow_path(getnode("bc_node_left_run", "targetname"));
    self waittill("goal");
  }

  maps\_utility::set_ignoreall(0);
}

opfor_helo_rein() {
  self endon("death");

  if(isDefined(self.script_parameters)) {
    self.animname = self.script_parameters;
  }

  wait 0.05;
  self.allowdeath = 1;
}

main_spot() {
  var_0 = getent("cw_spotlight_1", "targetname");
  var_1 = getEntArray("cw_spot_1_org", "targetname");
  var_2 = getent("cw_spot_1_start", "targetname");
  var_0.angles = vectortoangles(var_2.origin - var_0.origin);
  playFXOnTag(level._effect["catwalk_spot"], var_0, "spotlight_main");
  var_3 = var_2 common_scripts\utility::spawn_tag_origin();
  var_4 = (0, 0, 0);

  if(!common_scripts\utility::flag("bc_flag_spots_close")) {
    var_2 = getent("cw_spot_1_end", "targetname");
    var_5 = vectornormalize(var_2.origin - var_3.origin);
    var_4 = var_5;
    var_0.near_dist_sq = 100.0;
    var_0.lerp_rate = 0.065;
    var_0.velocity_factor = 200.0;
    maps\_utility::delaythread(5, common_scripts\utility::flag_set, "bc_flag_spots_close");
    thread spotlight_motion(var_3, var_2, var_4, var_0, var_1, "bc_flag_spots_close");
    level waittill("end_spotlight_motion", var_2, var_4);
  }

  var_1 = [];
  var_1[0] = level.player;
  var_1[1] = level._allies[0];
  var_1[2] = level._allies[1];
  var_1[3] = level._bravo[0];
  var_1[4] = level._bravo[1];
  var_2 = var_1[randomint(var_1.size)];
  var_5 = vectornormalize(var_2.origin - var_3.origin);
  var_4 = var_5;
  var_0.near_dist_sq = 32.0;
  var_0.lerp_rate = 0.2;
  var_0.velocity_factor = 100.0;
  thread spotlight_motion(var_3, var_2, var_4, var_0, var_1, "flag_ascend_start", 1);
  level waittill("end_spotlight_motion", var_2, var_4);

  while(!common_scripts\utility::flag("bc_flag_spots_off")) {
    var_6 = (randomfloatrange(-2, 2), randomfloatrange(-2, 2), 0);
    var_7 = vectortoangles(level.player.origin + var_6 - var_0.origin);
    var_0 rotateto(var_7, 0.3);
    wait 0.1;
  }

  var_0 notify("noise_off");
  stopFXOnTag(level._effect["catwalk_spot"], var_0, "spotlight_main");
}

fake_spot(var_0, var_1) {
  if(!common_scripts\utility::flag("bc_flag_spots_close")) {
    wait(randomfloatrange(0.6, 1.8));
  }

  var_2 = getent(var_0, "targetname");
  var_3 = getEntArray(var_1, "targetname");
  var_4 = var_3[randomint(var_3.size)];
  var_2.angles = vectortoangles(var_4.origin - var_2.origin);
  wait 0.05;
  playFXOnTag(level._effect["catwalk_spot_cheap"], var_2, "spotlight_main");
  var_5 = var_4 common_scripts\utility::spawn_tag_origin();
  var_4 = var_3[randomint(var_3.size)];
  var_6 = vectornormalize(var_4.origin - var_5.origin);
  var_7 = var_6;
  var_2.near_dist_sq = 100.0;
  var_2.lerp_rate = 0.065;
  var_2.velocity_factor = 200.0;
  spotlight_motion(var_5, var_4, var_7, var_2, var_3, "bc_flag_spots_off");
  var_2 notify("noise_off");
  stopFXOnTag(level._effect["catwalk_spot_cheap"], var_2, "spotlight_main");
  var_2.angles = (randomint(60), 270, 0);
}

spotlight_motion(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  while(!common_scripts\utility::flag(var_5)) {
    while(distancesquared(var_0.origin, var_1.origin) > var_3.near_dist_sq) {
      var_7 = vectornormalize(var_1.origin - var_0.origin);
      var_2 = var_2 + (var_7 - var_2) * var_3.lerp_rate;
      var_0.origin = var_0.origin + var_2 * var_3.velocity_factor * level.timestep;

      if(isDefined(var_6) && var_6) {
        var_0.origin = var_0.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1));
      }

      var_3.angles = vectortoangles(var_0.origin - var_3.origin);
      wait(level.timestep);
    }

    if(isDefined(var_6) && var_6) {
      var_8 = gettime();
      var_9 = randomfloatrange(1000, 3000);

      while(gettime() - var_8 < var_9) {
        var_0.origin = var_0.origin + (randomfloatrange(-2, 2), randomfloatrange(-2, 2), randomfloatrange(-2, 2));
        var_3.angles = vectortoangles(var_0.origin - var_3.origin);
        wait(level.timestep);
      }
    }

    var_10 = var_1;
    var_4 = common_scripts\utility::array_remove(var_4, var_10);
    var_11 = [];

    if(!isDefined(var_6) || isDefined(var_6) && !var_6) {
      var_12 = 1;

      foreach(var_14 in var_4) {
        var_15 = vectordot(vectornormalize(var_2), vectornormalize(var_14.origin - var_0.origin));

        if(var_15 < 0.25) {
          var_11[var_11.size] = var_14;
        }

        if(var_4.size == var_11.size) {
          var_12 = 0;
          break;
        }
      }

      if(var_12) {
        foreach(var_14 in var_11) {
          var_4 = common_scripts\utility::array_remove(var_4, var_14);
        }
      } else {
        var_19 = 3;

        if(var_4.size > var_19) {
          foreach(var_14 in var_4) {
            var_14.dist2d = distance2d(var_10.origin, var_14.origin);
          }

          var_4 = common_scripts\utility::array_sort_by_handler(var_4, ::target_dist_compare);
          var_11 = [];

          for(var_22 = 0; var_22 < var_19; var_22++) {
            var_11[var_22] = var_4[var_22];
            var_4 = common_scripts\utility::array_remove(var_4, var_11[var_22]);
          }
        }
      }
    }

    var_1 = var_4[randomint(var_4.size)];
    var_4[var_4.size] = var_10;

    foreach(var_14 in var_11) {
      var_4[var_4.size] = var_14;
    }

    wait(level.timestep);
  }

  level notify("end_spotlight_motion", var_1, var_2);
}

target_dist_compare() {
  return self.dist2d;
}

spot_noise() {
  self endon("noise_off");

  for(;;) {
    var_0 = (randomfloatrange(-0.25, 0.25), randomfloatrange(-0.25, 0.25), randomfloatrange(-0.25, 0.25));
    self rotateto(self.angles + var_0, 0.1);
    wait 0.1;
  }
}

basecamp_dof() {
  common_scripts\utility::flag_wait("player_water_breach");
  thread camp_mblur_changes();
  maps\_art::dof_enable_script(0, 100, 0.5, 5000, 7000, 0.4, 0);
  wait 2;
  maps\_art::dof_enable_script(0, 1, 1, 500, 7000, 3, 1);
  wait 3;
  maps\_art::dof_disable_script(1);
}

camp_mblur_changes() {
  wait 1;

  if(maps\_utility::is_gen4() && !level.ps4) {
    setsaveddvar("r_mbEnable", 0);
    setsaveddvar("r_mbCameraRotationInfluence", 0.07);
    setsaveddvar("r_mbCameraTranslationInfluence", 0.15);
    setsaveddvar("r_mbModelVelocityScalar", 0.06);
    setsaveddvar("r_mbStaticVelocityScalar", 0.01);
    setsaveddvar("r_mbViewModelEnable", 1);
    setsaveddvar("r_mbViewModelVelocityScalar", 0.004);
  }

  wait 2.25;

  if(maps\_utility::is_gen4()) {
    return;
  }
}

camp_primary_light_switch() {
  var_0 = getEntArray("light_infil_omni1", "targetname");

  if(maps\_utility::is_gen4()) {
    var_0[var_0.size] = getent("light_infil_script_top", "targetname");
    var_0[var_0.size] = getent("light_infil_script_top2", "targetname");
    var_0[var_0.size] = getent("light_infil_script_top3", "targetname");
  }

  foreach(var_2 in var_0) {
    var_2 setlightintensity(0);
  }

  var_4 = getEntArray("light_camp_tent1_spot", "targetname");
  var_5[0] = 0;

  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    var_5[var_6] = var_4[var_6] getlightintensity();
    var_4[var_6] setlightintensity(0);
  }

  maps\_utility::trigger_wait("show_tent_lights", "targetname");

  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    var_4[var_6] setlightintensity(var_5[var_6]);
  }
}

delete_path_clip() {
  self movez(-10000, 0.05);
  wait 0.05;
  self connectpaths();
  self delete();
}