/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_c36b776c6718540.gsc
***********************************************/

#using script_3072532951b5b4ae;
#using script_3dc93ca9902a9cda;
#using script_58524f08c3081cbb;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\snd;
#namespace namespace_8a404420;

function postload() {
  animation::add_notetrack_func("hms_util::set_flag_from_scene", &hms_util::function_e9f3f20);
  animation::add_notetrack_func("hms_util::clear_flag_from_scene", &hms_util::function_cafa23ec);
}

function function_7eb604b9() {
  s_scene = struct::get("scene_yam_1010_hel_intro");
  scene::add_scene_func("scene_yam_1010_hel_intro", &function_63264d28, "play");
  scene::add_scene_func("scene_yam_1010_hel_intro", &function_485aed5c, "takeoff");
  level scene::init("scene_yam_1010_hel_intro");
  level flag::wait_till("all_players_spawned");
  level.ai_woods sethighdetail(1);
  s_scene.scene_ents[# "belikov"] sethighdetail(1);
  level thread function_50989881(s_scene);
  level scene::play("scene_yam_1010_hel_intro", "play");
  level thread function_fbb0d73f();
  level.ai_woods sethighdetail(0);
}

function function_50989881(s_scene) {
  var_257cdc92 = getent("hms_cap", "targetname");
  var_257cdc92 setscale(1.25);
  var_257cdc92 linkto(s_scene.scene_ents[# "belikov"], "j_helmet", (2, 1, 0), (-140, -90, 0));
  var_257cdc92 hide();
  level waittill(#"hash_661c404db1017413");
  var_257cdc92 show();
  level flag::wait_till("flg_hel_intro_fly_away");

  if(isDefined(var_257cdc92)) {
    var_257cdc92 delete();
  }
}

function function_fbb0d73f() {
  collision_r_heli = getent("collision_r_heli", "targetname");
  collision_l_heli = getent("collision_l_heli", "targetname");
  collision_f_heli = getent("collision_f_heli", "targetname");
  var_58d24ca9 = [];

  if(!isDefined(var_58d24ca9)) {
    var_58d24ca9 = [];
  } else if(!isarray(var_58d24ca9)) {
    var_58d24ca9 = array(var_58d24ca9);
  }

  var_58d24ca9[var_58d24ca9.size] = collision_r_heli;

  if(!isDefined(var_58d24ca9)) {
    var_58d24ca9 = [];
  } else if(!isarray(var_58d24ca9)) {
    var_58d24ca9 = array(var_58d24ca9);
  }

  var_58d24ca9[var_58d24ca9.size] = collision_l_heli;

  if(!isDefined(var_58d24ca9)) {
    var_58d24ca9 = [];
  } else if(!isarray(var_58d24ca9)) {
    var_58d24ca9 = array(var_58d24ca9);
  }

  var_58d24ca9[var_58d24ca9.size] = collision_f_heli;
  level thread function_23320f08(0, var_58d24ca9);

  while(!level flag::get("flg_hel_intro_fly_away")) {
    level scene::play("scene_yam_1010_hel_intro", "idle_loop");
  }

  level flag::wait_till("flg_hel_intro_fly_away");
  var_4e73bdbd = getEntArray("e_helo_interior_item", "targetname");

  foreach(e_helo_interior_item in var_4e73bdbd) {
    e_helo_interior_item delete();
  }

  level thread scene::play("scene_yam_1010_hel_intro", "takeoff");
  level thread function_23320f08(1, var_58d24ca9);
}

function function_23320f08(b_condition, var_6c91f8cd) {
  if(b_condition) {
    foreach(ent in var_6c91f8cd) {
      ent moveto(ent.origin + (0, 0, -400), 5);
    }

    return;
  }

  var_6c91f8cd[0] moveto((-6796, -470, 3910), 5);
  var_6c91f8cd[1] moveto((-6629, -397, 3909), 5);
  var_6c91f8cd[2] moveto((-6840, -140, 3903), 5);
}

function function_63264d28(a_ents) {
  belikov = a_ents[# "belikov"];
  belikov.propername = # "hash_59ecd456f45762d4";
  belikov ai::gun_remove();
  level waittill(#"intro_dialog_done");
  level flag::set("flg_intro_dialog_done");
}

function function_485aed5c(a_ents) {
  var_3793dd70 = a_ents[# "belikov"];
  var_3f59f311 = a_ents[# "heli"];
  var_3793dd70 linkto(var_3f59f311);
}

function function_f21e84b4() {
  level.var_d596a87f endon(#"death");
  level flag::wait_till("flg_zipline_intro_zipliner_cross");

  if(level.var_d596a87f namespace_77fd5d41::stealth_enemy_getbsmstate() == "Stealth_Idle" && !level flag::get("flg_zipline_intro_engaging")) {
    level.var_d596a87f thread function_a973b3e9();
    level scene::play("scene_yam_2020_zip_cliffside_alt", "start");
    level flag::set("flg_zip_cliffside_alt_done");
  }
}

function function_a973b3e9() {
  self endon(#"death");
  level endon(#"flg_zip_cliffside_alt_done");
  self waittill(#"stealth_combat", #"stealth_investigate");
  level scene::stop("scene_yam_2020_zip_cliffside_alt");
}

function function_6240e40f() {
  level.var_a06bbe2a endon(#"death");
  level flag::wait_till("flg_zipline_intro_zipliner_cross");

  if(level.var_a06bbe2a namespace_77fd5d41::stealth_enemy_getbsmstate() == "Stealth_Idle" && !level flag::get("flg_zipline_intro_engaging")) {
    level scene::play("scene_yam_2020_zip_cliffside_alt_enemy2", "start2");
    level flag::set("flg_zip_cliffside_alt2_done");
  }

  if(level.var_a06bbe2a namespace_77fd5d41::stealth_enemy_getbsmstate() == "Stealth_Idle" && !level flag::get("flg_zipline_intro_engaging") && level flag::get("flg_zipline_intro_allow_stand_up")) {
    level thread scene::play("scene_yam_2020_zip_cliffside_alt_enemy2", "loop2");
  }
}

function function_517fe722() {
  var_6976e02a = getent("zipline_intro_bird_scare", "targetname");
  a_s_birds = struct::get_array(var_6976e02a.target, "targetname");
  level flag::wait_till("flg_satcom_birds_trigger");

  foreach(s_bird in a_s_birds) {
    s_bird thread scene::play("shot1");
  }
}

function function_d07cab65(woods) {
  var_a5fa7867 = struct::get("scene_zip_fall_woods_traverse", "targetname");
  var_a5fa7867 scene::play("play", woods);
}

function function_85bd6953() {
  level scene::function_27f5972e("scene_4020_yam_zip_fall_player_fall_bundle");
  level waittill(#"hash_3ede0d97e45af550");
  level thread namespace_7468806b::function_e15849a0();
  level namespace_5d7a2dac::music("5.11_fall");
  level thread namespace_b73b9191::function_54b7084f("f_zipline_fall_impact_scaffolding", undefined, 0.2);
  level thread namespace_b73b9191::function_54b7084f("f_zipline_fall_impact_ground", undefined, 0.6);
  level thread function_f18a8efc();
  level scene::play("scene_4020_yam_zip_fall_player_fall_bundle", "fall");
  level notify(#"hash_7abd2158f9add682");
  level scene::function_f81475ae("scene_4020_yam_zip_fall_player_fall_bundle");
}

function function_f18a8efc() {
  wait 7;
  var_f7a697d1 = struct::get("railing_piece_01", "targetname");
  createdynentandlaunch("p9_fxanim_yam_4020_catwalk_piece_01", var_f7a697d1.origin, var_f7a697d1.angles, var_f7a697d1.origin, (0, 0, 0));
  wait 0.1;
  var_49cd91d2 = struct::get("railing_piece_02", "targetname");
  createdynentandlaunch("p9_fxanim_yam_4020_catwalk_piece_02", var_49cd91d2.origin, var_49cd91d2.angles, var_49cd91d2.origin, (0, 0, 0));
  var_b3380801 = struct::get("railing_piece_03", "targetname");
  createdynentandlaunch("p9_fxanim_yam_4020_catwalk_piece_03", var_b3380801.origin, var_b3380801.angles, var_b3380801.origin, (0, 0, 0));
  var_7777091 = struct::get("railing_piece_04", "targetname");
  wait 0.2;
  createdynentandlaunch("p9_fxanim_yam_4020_catwalk_piece_04", var_7777091.origin, var_7777091.angles, var_7777091.origin, (0, 0, 0));
}

function function_6b1799c6() {
  level waittill(#"hash_33253c64ecacc7d9");
  trigger::use("t_bc_zipline_fall_3", "targetname", level.player, 0);
  level scene::play("p9_fxanim_cp_yamantau_zipl_platform_fall_02_bundle", "play");
}

function private start_timer(e_player) {
  level endon(#"hash_7abd2158f9add682");
  n_time = 0;

  while(true) {
    wait 0.05;
    n_time += 0.05;
  }
}

function function_876b3ae7() {
  var_8e4071be = doors::function_73f09315("bunker_icicle_door", "targetname");
  var_8e4071be waittill(#"door_opening");

  if(is_true(var_8e4071be.c_door.var_c4c3fa39)) {
    scene::init("p9_fxanim_cp_yamantau_icicle_vignette_scene");
    wait 1;
    level thread scene::play_from_time("p9_fxanim_cp_yamantau_icicle_vignette_scene", "play");
    snd::play("evt_yam_icicle_break", (5122, -2677, 836));
    return;
  }

  level thread scene::play_from_time("p9_fxanim_cp_yamantau_icicle_vignette_scene", "play");
  snd::play("evt_yam_icicle_break", (5122, -2677, 836));
  var_8e4071be.c_door waittill(#"door_fully_open");
}

function function_94b72d13() {
  level flag::wait_till("flg_woods_regroup_callover_start");
  level exploder::exploder("lgt_woodsReunion");

  if(!level flag::get_any(array("flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods"))) {
    level thread scene::play_from_time("scene_yam_6005_grp_ladder_walk_off", "Woods_callover_greet", undefined, 0.5, 0, 1);
    level.ai_woods hms_util::dialogue("vox_cp_ymnt_01900_wood_overhere_81");
    level thread scene::play("scene_yam_6005_grp_ladder_walk_off", "Woods_near_idle");
    level flag::wait_till_any_timeout(5, array("flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods"));

    if(!level flag::get_any(array("flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods"))) {
      level thread namespace_7468806b::function_117649d4();
      level thread scene::play("scene_yam_6005_grp_ladder_walk_off", "Woods_near_idle");
      level flag::wait_till_any_timeout(5, array("flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods"));

      if(!level flag::get_any(array("flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods"))) {
        level scene::play("scene_yam_6005_grp_ladder_walk_off", "Woods_nag");
        level thread scene::play("scene_yam_6005_grp_ladder_walk_off", "Woods_near_idle");
        level flag::wait_till_any_timeout(5, array("flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods"));
      }
    }
  }

  t_woods_bunker_ladder = getent("t_woods_bunker_ladder", "targetname");
  level flag::wait_till_any(array("flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods"));

  if(!level.player istouching(t_woods_bunker_ladder)) {
    level thread scene::play("scene_yam_6005_grp_ladder_walk_off", "Woods_near_idle");
    wait 2;
    level flag::wait_till("flg_bunker_ladder_reached");
  }

  t_woods_bunker_ladder delete();
  level flag::set("flg_woods_regroup_woods_exiting");
  level thread function_94f9b4a9();
}

function function_94f9b4a9() {
  if(!level flag::get("flg_bunker_stealth_fail") && !level flag::get("flg_woods_regroup_stealth_dialogue_complete")) {
    level scene::play("scene_yam_6005_grp_ladder_walk_off", "Woods_walk_off1");
    level.player notify(#"bunker_stealth_successful");
    level flag::set("flg_woods_regroup_stealth_dialogue_complete");
  } else if(!level flag::get("flg_woods_regroup_stealth_dialogue_complete") && level.player getcurrentweapon() == getweapon(#"knife_loadout")) {
    level scene::play("scene_yam_6005_grp_ladder_walk_off", "Woods_walk_off2");
    level flag::set("flg_woods_regroup_stealth_dialogue_complete");
  } else if(!level flag::get("flg_woods_regroup_stealth_dialogue_complete")) {
    level scene::play("scene_yam_6005_grp_ladder_walk_off", "Woods_walk_off3");
    level flag::set("flg_woods_regroup_stealth_dialogue_complete");
  }

  level flag::set("flg_start_regroup_dialog");
}

function function_901674ed() {
  level flag::wait_till("flg_survey_fade_in");
  level scene::stop("scene_yam_6010_grp_enter_react");
}

function scene_yam_6010_grp_enter_react() {
  level endon(#"flg_survey_fade_in");
  level flag::wait_till_any(array("flg_bunker_office_entered", "flg_bunker_office_seen"));
  level thread function_901674ed();
  level scene::play("scene_yam_6010_grp_enter_react", "woods_react_intro", array(level.ai_woods));
  level thread scene::play("scene_yam_6010_grp_enter_react", "woods_table_idle", array(level.ai_woods));
  level flag::wait_till("survey_equipment_completed");
  level scene::stop("scene_yam_6010_grp_enter_react");
  var_ae4df8ef = getnode("woods_office_exit", "targetname");

  if(!level flag::get("flg_excavation_survey_room_exited")) {
    level.ai_woods setgoal(var_ae4df8ef);
    level.ai_woods.goalradius = 32;
  }
}

function scene_yam_7010_exc_extraction() {
  level scene::init("scene_yam_7010_exc_extraction");
  level thread scene::play("scene_yam_7010_exc_extraction", "guy_loop");
  level flag::wait_till("flg_bunker_survey_interacted");
  level waittill(#"hash_39fbe9dbd19f01ae");
  level thread scene::play("scene_yam_7010_exc_extraction", "crane_start");
  level flag::wait_till("flg_excavation_alpha_crane_rotate");
  level thread scene::play("scene_yam_7010_exc_extraction", "stage1");
  level flag::wait_till("flg_excavation_charlie_approach");
  level thread scene::play("scene_yam_7010_exc_extraction", "stage2");
  level flag::wait_till("flg_excavation_charlie_exit_approach");
  level thread scene::play("scene_yam_7010_exc_extraction", "stage3");
}

function function_df4e7f42() {
  level thread scene::play("scene_yam_7010_exc_extraction", "guy_loop");
  level thread scene::play("scene_yam_7010_exc_extraction", "stage1");
  level flag::wait_till("flg_excavation_charlie_approach");
  level thread scene::play("scene_yam_7010_exc_extraction", "stage2");
  level flag::wait_till("flg_excavation_charlie_exit_approach");
  level thread scene::play("scene_yam_7010_exc_extraction", "stage3");
}

function function_164734e9() {
  level thread scene::play("scene_yam_7010_exc_extraction", "guy_loop");
  level thread scene::play("scene_yam_7010_exc_extraction", "stage2");
  level flag::wait_till("flg_excavation_charlie_exit_approach");
  level thread scene::play("scene_yam_7010_exc_extraction", "stage3");
}

function function_2468cb92() {
  level.var_c9b20243 = 1;
  level scene::init("scene_yam_7010_exc_truck_exit");
  level thread scene::play("scene_yam_7010_exc_scaffolding_smoking", "loop");
  level thread scene::play("scene_yam_7010_exc_scaffolding_observing", "loop");
  level thread scene::play("scene_yam_7010_exc_scaffolding_sitting", "loop");
  level thread scene::play("scene_yam_7010_exc_scaffolding_plans", "plans");
  level thread scene::play("scene_yam_7010_exc_scaffolding_rear", "break_idle");
  level thread scene_yam_7010_exc_extraction();
  level flag::wait_till("flg_bunker_office_entered");
  level thread scene::play("scene_yam_7010_exc_truck_exit", "truck_loop");
}

function function_e6604e8b() {
  level thread scene::play("scene_yam_7010_exc_scaffolding_smoking", "loop");
  level thread scene::play("scene_yam_7010_exc_scaffolding_observing", "loop");
  level thread scene::play("scene_yam_7010_exc_scaffolding_sitting", "loop");
  level thread scene::play("scene_yam_7010_exc_scaffolding_plans", "plans");
  level thread scene::play("scene_yam_7010_exc_scaffolding_rear", "break_idle");
}

function function_301a4927() {
  level scene::stop("scene_yam_7010_exc_truck_exit");
  level thread scene::play("scene_yam_7010_exc_truck_exit", "loading_enemy03");
  level thread scene::play("scene_yam_7010_exc_truck_exit", "loading_enemy04");
  level scene::play("scene_yam_7010_exc_truck_exit", "truck_enter");
  level scene::play("scene_yam_7010_exc_truck_exit", "truck_exit");
}

function function_879f456d() {
  level.var_c9b20243 = 0;
  level scene::stop("scene_yam_7010_exc_truck_exit");
  level scene::delete_scene_spawned_ents("scene_yam_7010_exc_scaffolding_smoking");
  level scene::delete_scene_spawned_ents("scene_yam_7010_exc_scaffolding_observing");
  level scene::delete_scene_spawned_ents("scene_yam_7010_exc_scaffolding_sitting");
  level scene::delete_scene_spawned_ents("scene_yam_7010_exc_truck_exit");
  level scene::delete_scene_spawned_ents("scene_yam_7010_exc_scaffolding_plans");
  level scene::delete_scene_spawned_ents("scene_yam_7010_exc_scaffolding_rear");
  level thread scene::init("scene_yam_7010_exc_scaffolding_plans");
}

function private function_bafa4855() {
  self endon(#"death");
  function_f05650bc("scene_yam_7010_exc_scaffolding_rear", "break_idle");
  function_f05650bc("scene_yam_7010_exc_scaffolding_rear", "break_idle");
  function_f05650bc("scene_yam_7010_exc_scaffolding_rear", "back_to_work");

  while(level.var_c9b20243) {
    var_689ecfec = randomint(3);

    switch (var_689ecfec) {
      case 1:
        function_f05650bc("scene_yam_7010_exc_scaffolding_rear", "move_boxes");
        break;
      case 2:
        function_f05650bc("scene_yam_7010_exc_scaffolding_rear", "move_boxes_fall");
        break;
    }
  }
}

function private function_f05650bc(str_scene, str_shot) {
  n_wait_time = scene::function_8582657c(str_scene, str_shot);
  level thread scene::play(str_scene, str_shot);
  wait n_wait_time;
}

function function_174832fd() {
  var_4e21c010 = # "flg_excavation_descent_started";
  level scene::play("scene_yam_7030_exc_vert_descend", "woods_enter");
  level thread scene::play("scene_yam_7030_exc_vert_descend", "woods_loop");
  var_9f249e8 = array("woods_nag1", "woods_nag2", "woods_nag3");
  level function_95dc818f("scene_yam_7030_exc_vert_descend", "woods_loop", var_9f249e8, var_4e21c010);
  level flag::wait_till("flg_excavation_descent_started");
  level.ai_woods animation::stop();
  level flag::wait_till("flg_excavation_woods_descend_start");
  level thread function_505de846();
  level scene::play("scene_yam_7030_exc_vert_descend", "woods_exit");

  if(!level flag::get("flg_woods_excavation_descend_skip")) {
    level flag::set("flg_excavation_woods_descend_done");
  }
}

function function_505de846() {
  level endoncallback(&function_b6eaec4e, #"hash_115ad0a3e7d7cc7b");
  level flag::wait_till("flg_woods_excavation_descend_skip");
  level.ai_woods animation::stop();
  level scene::play_from_time("scene_yam_7030_exc_vert_descend", "woods_exit", [level.woods], 4.2, 0, 1);
  trigger::use("tr_excavation_woods_post_descent", "targetname", level.player, 0);
  level flag::set("flg_excavation_woods_descend_done");
}

function function_b6eaec4e(str_notify) {
  trigger::use("tr_excavation_woods_post_descent", "targetname", level.player, 0);
}

function private function_41e6ebcc() {
  self endon(#"death");
  wait 1;
  self.var_e7ea517e = 1;
}

function scene_yam_7035_exc_vert_descend_guard(guy) {
  b_loop = 1;

  if(!level flag::get("flg_excavation_alpha_greeters_alerted_early")) {
    level thread scene::play("scene_yam_7035_exc_vert_descend_guard", "idle", guy);
    level flag::wait_till_any(array("flg_excav_player_descent_done", "flg_excavation_alpha_greeters_alerted_early"));

    if(level flag::get("flg_excav_player_descent_done") && !level flag::get("flg_excavation_alpha_greeters_alerted_early")) {
      b_loop = 0;
      level scene::stop("scene_yam_7035_exc_vert_descend_guard");
      wait 0.5;

      if(isalive(guy)) {
        guy namespace_979752dc::enable_stealth_for_ai(0);
        guy.var_e7ea517e = 0;
      }

      level scene::play("scene_yam_7035_exc_vert_descend_guard", "react", guy);

      if(isalive(guy)) {
        guy ai::set_behavior_attribute("demeanor", "combat");
        guy setgoal(guy.origin, 0, 16, 128);
      }

      waitframe(6);
      level flag::set("flg_excavation_alpha_greeter_1_move");

      if(isalive(guy)) {
        guy thread function_41e6ebcc();
        guy val::set("gauntlet_initial", "ignoreall");
      }

      wait 2;

      if(isalive(guy)) {
        guy val::reset("gauntlet_initial", "ignoreall");
      }

      return;
    }

    if(!level flag::get("flg_excav_player_descent_done") && level flag::get("flg_excavation_alpha_greeters_alerted_early")) {
      b_loop = 0;
      level scene::stop("scene_yam_7035_exc_vert_descend_guard");
    }
  }
}

function scene_yam_8001_srv_slide_approach() {
  level scene::play("scene_yam_8001_srv_slide_approach", "enter");

  if(!level flag::get("flg_server_reveal_jump_start")) {
    level thread scene::play("scene_yam_8001_srv_slide_approach", "loop");
  }
}

function function_6699b719(ai) {
  level flag::wait_till("flg_server_room_start");
  level thread namespace_7468806b::function_86c78d49();
  level thread scene::play("scene_yam_8005_srv_slide_landing_guards", "fall", ai);
  level scene::play("scene_yam_8005_srv_slide_landing", "play");
  level flag::set("flg_server_slide_complete");
}

function function_e0069c97() {
  level endon(#"flg_server_cable_attaching");
  wait 0.1;
  level scene::play("scene_yam_8010_sca_server_mount_attach", "woods_server_climb");
  level thread scene::play("scene_yam_8010_sca_server_mount_attach", "woods_server_idle");
}

function function_a8eb3579() {
  level flag::wait_till("flg_server_cable_attaching");
  level scene::stop("scene_yam_8010_sca_server_mount_attach");
  level.ai_woods stopsounds();
  level.e_server_cable thread function_7a78b143();
  level scene::play("scene_yam_8010_sca_server_mount_attach", "woods_server_descent", array(level.e_server_cable_simmed, level.e_server_cable, level.e_server_hook));
  level flag::set("flg_server_cable_attached");
}

function private function_7a78b143() {
  self waittill(#"hash_77529bc902051bf2");
  self hide();
  level.e_server_cable_simmed show();
  self waittill(#"hash_1e25067fe7bee87e");
  self show();
  level.e_server_cable_simmed hide();
}

function scene_yam_9010_out_heli_outro() {
  level thread scene::play("scene_yam_9010_out_heli_outro", "outro_scene");
}

function function_95dc818f(str_scene_name, var_2b490ed3, var_53f71e6a, var_4e21c010, n_wait_min = 10, n_wait_max = 15) {
  assert(isstring(str_scene_name));
  assert(isstring(var_2b490ed3));
  assert(isarray(var_53f71e6a));
  assert(isstring(var_4e21c010) || ishash(var_4e21c010));

  while(var_53f71e6a.size > 0 && !level flag::get(var_4e21c010)) {
    s_event = level waittilltimeout(randomfloatrange(n_wait_min, n_wait_max), var_4e21c010);

    if(s_event._notify === # "timeout") {
      level scene::play(str_scene_name, var_53f71e6a[0]);
      arrayremoveindex(var_53f71e6a, 0);
      level thread scene::play(str_scene_name, var_2b490ed3);
      continue;
    }

    break;
  }

  level flag::wait_till(var_4e21c010);
}