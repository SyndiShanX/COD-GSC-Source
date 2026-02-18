/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5d2b67be820bed1a.gsc
***********************************************/

#using script_1351b3cdb6539f9b;
#using script_32a61480150c683;
#using script_61fee52bb750ac99;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\achievements;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\flashback_tv;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace namespace_1bc068e2;

function start(str_objective) {
  level.var_86d6c2ab = 1;
  level thread namespace_c6aa31df::function_886bcebf();
  level thread namespace_c6aa31df::function_d1fa28d3("rice_paddies");
}

function main(str_objective, var_50cc0d4f) {
  var_c79d614f = "jungle_path";
  level thread jungle_path();
  level flag::wait_till(var_c79d614f + "_complete");
  savegame::function_379f84b3();
  skipto::function_4e3ab877(var_50cc0d4f);
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_c26b0bc0() {
  level flag::init("flag_final_visit");
  level flag::init("jungle_path_complete");
  level flag::init("flag_jungle_path_has_idled");
  level flag::init("flag_jungle_path_has_idled_2x");
  level flag::init("flag_jungle_path_fork_left_on");
  level flag::init("flag_jungle_path_fork_right_on");
  level flag::init("flag_jungle_path_fork_left_hit");
}

function function_a08d5cab() {
  level flag::clear("flag_jungle_path_start_vo");
  level flag::clear("flag_jungle_path_fork");
  level flag::clear("jungle_path_complete");
  level flag::clear("flag_jungle_lab_rob");
  level flag::clear("flag_jungle_lab_rob2");
}

function jungle_path() {
  level endon(#"start_outro");
  var_c79d614f = "jungle_path";
  level thread function_6443d670(var_c79d614f);
}

function function_6443d670(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level flag::wait_till("flag_" + var_c79d614f);
  level.var_3f5c80c8 = "jungle_path";
  level.player districts::function_a7d79fcb(["middle_paths"]);
  var_22a36e7f = struct::get("struct_jungle_path_streamer_hint", "targetname");
  level util::create_streamer_hint(var_22a36e7f.origin, var_22a36e7f.angles, 0.5, 30);
  level thread function_cdf71e6f();

  if(level.var_731c10af.paths[var_c79d614f].count != 0) {
    level childthread function_cc9c7ae0();
  }

  if(level.var_731c10af.paths[var_c79d614f].count == 0) {
    function_d35c97af();
  } else if(level.var_731c10af.paths[var_c79d614f].count == 1) {
    function_df9f3034();
  } else if(level.var_731c10af.paths[var_c79d614f].count == 2) {
    function_fde06cb6();
  }

  level flag::wait_till("flag_jungle_path_start_vo");
  level.player districts::function_a7d79fcb(["village"]);
  level flag::wait_till("flag_jungle_path_fork");
  namespace_d9b153b9::function_e106e062(var_c79d614f);
  level flag::set(var_c79d614f + "_complete");
}

function function_d35c97af() {
  level thread namespace_d9b153b9::function_be6f6790("middle_paths_temple_parrots", "flag_fxanim_parrots_fly");
  thread namespace_b6fe1dbe::function_616b3f40();
  level thread function_a4d45cbd();
}

function function_a4d45cbd() {
  level scene::init("jungle_path_lizard_02");
  level flag::wait_till("flag_jungle_path_lizard_02");
  level thread scene::play("jungle_path_lizard_02");
  level flag::wait_till_timeout(2.5, "flag_jungle_path_lizard_02_delete");
  level thread scene::stop("jungle_path_lizard_02", 1);
}

function function_16ddfc8c() {
  level flag::set("flag_jungle_path_fork_left_on");
  childthread function_94da35e5();
  level flag::wait_till("flag_jungle_path_fork_left");
  level flag::clear("flag_jungle_path_fork_left_on");
  level flag::set("flag_jungle_path_fork_left_hit");
  level thread dialogue::radio("vox_cp_prsn_02000_adlr_nobellyourrepor_5b");
  wait 2.5;
  level notify(#"hash_56cb4021d1ecddc");
}

function function_94da35e5() {
  level endon(#"hash_56cb4021d1ecddc");
  a_str_vo = [];
  namespace_d9b153b9::function_47e52704("flag_jungle_path_fork_left", "struct_jungle_path_teleport", a_str_vo);
}

function function_df9f3034() {
  level thread namespace_b6fe1dbe::function_63e81473();
  level.player savegame::set_player_data(#"hash_12bd8292e3e6ebfe", 0);
  level.player thread flashback_tv::function_15eaa2db(undefined, "cp_shared_vietnam_brainwash", "flag_player_approached_flashback_TV", "flag_player_not_in_darkroom", "flashback_tv_lookat", undefined, undefined, #"hash_12bd8292e3e6ebfe");
}

function function_fde06cb6() {
  level thread namespace_b6fe1dbe::function_7e2d7c54();
  level thread function_c136094b();
  level thread namespace_d9b153b9::function_1e281213("model_jungle_lab", 4, "flag_jungle_lab_rob", "render_texture_switch", "flag_in_end_path", "flag_jungle_path_3_rob_sm");
  level thread namespace_b6fe1dbe::function_c17eddf0();
  level thread namespace_d9b153b9::function_58c94625("model_jungle_lab", "flag_jungle_path_3_rob_sm");
}

function function_c136094b() {}

function function_cc9c7ae0() {
  childthread function_cf9c910c();
  childthread function_c25af689();
}

function function_cf9c910c() {
  if(!isDefined(level.var_71cc355e) || isDefined(level.var_71cc355e) && !array::contains(level.var_71cc355e, "struct_ghost_convo1")) {
    namespace_d9b153b9::function_48926a5f("struct_ghost_convo1");
  }
}

function function_c25af689() {
  if(!isDefined(level.var_71cc355e) || isDefined(level.var_71cc355e) && !array::contains(level.var_71cc355e, "struct_ghost_convo2")) {
    namespace_d9b153b9::function_48926a5f("struct_ghost_convo2");
  }
}

function function_cdf71e6f() {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level endon(#"hash_48117f07e3e52886");
  level childthread function_5eeb6e27();
  level childthread namespace_d9b153b9::function_f6cbf7fd(&function_622a53eb, 1, 20);

  if(isDefined(level.var_731c10af.var_42659717) && (level.var_731c10af.var_42659717 == 0 || level.var_731c10af.var_42659717 == 1 || level.var_731c10af.var_42659717 == 2)) {
    level flag::wait_till("flag_jungle_path_start_vo");

    if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 0) {
      level flag::wait_till("flag_jungle_path_perseus_vo");
    }

    level flag::wait_till("flag_jungle_path_fork");
    level thread savegame::checkpoint_save();
    level thread function_41b7e43b();
  }
}

function function_41b7e43b() {
  if(level.var_baa7cf92 == "caves" || level.var_baa7cf92 == "rat_tunnels") {
    dialogue::radio("vox_cp_prsn_02000_adlr_thepathsplitnea_41");
    return;
  }

  if(level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook") {
    dialogue::radio("vox_cp_prsn_05000_adlr_thepathsplitnea_cd");
  }
}

function function_109ea983() {
  if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 == 3) {
    dialogue::radio("vox_cp_prsn_12000_adlr_thebunkerdoorwa_63");
    thread function_b9a049cb();
  }
}

function function_b9a049cb() {
  level endon(#"start_outro");
  wait 3;
  dialogue::radio("vox_cp_prsn_12200_adlr_bellgointothebu_18");
  wait 3;
  dialogue::radio("vox_cp_prsn_12200_adlr_bellopenthedoor_e0");
  wait 3;
  dialogue::radio("vox_cp_prsn_12200_adlr_tellmeaboutpers_f3");
  wait 3;
  dialogue::radio("vox_cp_prsn_12200_adlr_whathappenedint_02");
  wait 3;
  dialogue::radio("vox_cp_prsn_12200_adlr_bellperseussaid_6a");
  wait 3;
  dialogue::radio("vox_cp_prsn_12200_adlr_bellthedoorbeat_3b");
  var_e823bd96 = [];
  var_e823bd96[0] = "vox_cp_prsn_12200_adlr_bellgointothebu_18";
  var_e823bd96[1] = "vox_cp_prsn_12200_adlr_bellopenthedoor_e0";
  var_e823bd96[2] = "vox_cp_prsn_12200_adlr_tellmeaboutpers_f3";
  var_e823bd96[3] = "vox_cp_prsn_12200_adlr_whathappenedint_02";
  var_e823bd96[4] = "vox_cp_prsn_12200_adlr_bellperseussaid_6a";
  var_e823bd96[5] = "vox_cp_prsn_12200_adlr_bellthedoorbeat_3b";
  var_d84d4c40 = 10;

  while(true) {
    wait var_d84d4c40;
    var_d84d4c40 += var_d84d4c40 / 2;
    i_random = randomint(var_e823bd96.size);
    dialogue::radio(var_e823bd96[i_random]);
  }
}

function function_5eeb6e27() {
  level endon(#"hash_48117f07e3e52886");
  level flag::clear("flag_jungle_path_backtrack");
  level flag::wait_till("flag_jungle_path_backtrack");
  dialogue::radio("vox_cp_prsn_14100_adlr_comeonbellyoukn_8d");
}

function function_622a53eb() {
  level endon(#"hash_48117f07e3e52886");
  ran = randomint(4);

  if(ran == 0) {
    dialogue::radio("vox_cp_prsn_14100_adlr_soyoujusthungou_59");
  } else if(ran == 1) {
    if(level flag::get("flag_jungle_path_fork")) {
      if(level.var_baa7cf92 == "caves" || level.var_baa7cf92 == "rat_tunnels") {
        dialogue::radio("vox_cp_prsn_14100_adlr_belltellmeabout_43");
      } else if(level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook") {
        dialogue::radio("vox_cp_prsn_14100_adlr_ineedyoutotellm_75");
      }
    }
  } else if(ran == 2) {}

  wait 0.5;
  dialogue::radio("vox_cp_prsn_14100_adlr_bellcomeonweveg_d4");

  if(!level flag::get("flag_jungle_path_has_idled") && !level flag::get("flag_jungle_path_has_idled_2x")) {
    level childthread namespace_d9b153b9::function_f6cbf7fd(&function_53f2b77c, 1, 10);
    return;
  }

  if(!level flag::get("flag_jungle_path_has_idled_2x")) {
    level childthread namespace_d9b153b9::function_f6cbf7fd(&function_3cad88f2, 1, 10);
  }
}

function function_53f2b77c() {
  level endon(#"hash_48117f07e3e52886");
  dialogue::radio("vox_cp_prsn_14100_adlr_whatswrongwithb_09");
  namespace_d9b153b9::function_f76551eb("vox_cp_prsn_14100_park_imnotsure_2f", "vox_cp_prsn_14100_lazr_seemsokay_ff", "vox_cp_prsn_14100_sims_gotme_4a");
  wait 0.5;
  dialogue::radio("vox_cp_prsn_14100_adlr_iguesswelljustw_90");
  level flag::set("flag_jungle_path_has_idled");
}

function function_3cad88f2() {
  level endon(#"hash_48117f07e3e52886");
  dialogue::radio("vox_cp_prsn_14100_adlr_bellsstoppedtal_44");
  namespace_d9b153b9::function_f76551eb("vox_cp_prsn_14100_park_thismustbeveryc_7b", "vox_cp_prsn_14100_lazr_bellyouinthereb_eb", "vox_cp_prsn_14100_sims_probablymessedu_02");
  level flag::set("flag_jungle_path_has_idled_2x");
}

function function_edd24f34(var_c79d614f) {
  level endon(#"visit_restart");
  level endon(#"start_outro");
  level flag::wait_till("flag_" + var_c79d614f);

  if(level.var_731c10af.var_e15e5b51.size == 1) {
    function_41c69c26(var_c79d614f);
    return;
  }

  if(level.var_731c10af.var_e15e5b51.size == 2) {
    function_f83608f2(var_c79d614f);
    return;
  }

  if(level.var_731c10af.var_e15e5b51.size == 3) {
    function_9fbac7d(var_c79d614f);
  }
}

function function_41c69c26(var_c79d614f) {}

function function_f83608f2(var_c79d614f) {
  wait 3;
  brushmodels = getEntArray("brushmodel_jungle_lab", "targetname");
  models = getEntArray("model_jungle_lab", "targetname");
  level thread function_49ea981(brushmodels);
  level thread function_49ea981(models);
}

function function_9fbac7d(var_c79d614f) {
  level flag::clear("flag_waterfall_path");
  level flag::clear("flag_creek_path");
  wait 3;
  level endon(#"visit_restart");
  level endon(#"start_outro");
  brushmodels = getEntArray("brushmodel_jungle_lab2", "targetname");
  models = getEntArray("model_jungle_lab2", "targetname");
  level flag::set("flag_path_end_on");
  a_str_vo = [];
  thread namespace_d9b153b9::function_47e52704("flag_path_end", "struct_path_end_teleport", a_str_vo);
  level flag::wait_till_any(["flag_waterfall_path", "flag_creek_path"]);
  level flag::wait_till_timeout(30, "flag_path_end");
  level.player clientfield::set_to_player("lerp_fov", 0);

  if(!flag::get("flag_path_end")) {
    thread namespace_d9b153b9::function_c66297e0("", "struct_path_end_teleport");
  }

  clip_last_room_wall = getent("clip_last_room_wall", "targetname");
  clip_last_room_wall movez(256, 0.1);
  level flag::set("flag_last_room_wall");
  level.player achievements::give_achievement(#"cp_achievement_red_door");
  level thread savegame::checkpoint_save();
}

function function_49ea981(ents) {
  foreach(ent in ents) {
    ent movez(512, 0.5);
  }
}