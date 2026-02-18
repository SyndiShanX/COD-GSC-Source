/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_ger_hub_post_yamantau.gsc
***********************************************/

#using script_19971192452f4209;
#using script_4052585f7ae90f3a;
#using script_5513c8efed5ff300;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\flashback_tv;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#namespace hub_post_yamantau;

function starting(var_d3440450) {}

function main(var_d3440450, var_50cc0d4f) {
  level namespace_31c67f6d::function_6194f34a("post_yamantau");
  level thread function_81c3adaf();
  setlightingstate(2);
  level thread function_4a614026();
  level thread namespace_31c67f6d::function_15231086("eboard_ready");
  level thread namespace_31c67f6d::function_29279de1("post_yamantau");
  level thread namespace_31c67f6d::function_b0558ba2("5");
  s_player_start = struct::get("s_post_yamantau_player_start", "targetname");
  level.player setorigin(s_player_start.origin);
  level.player setplayerangles(s_player_start.angles);
  level thread function_f84afd22();
  scene::init("scene_hub_post_yamantau_dialog_park");
  level thread function_cfce0b24();
  level namespace_31c67f6d::function_7fd3a4d8(undefined, undefined, 3, 1);

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_f84afd22() {
  level thread scene::play("scene_hub_env_reel_to_reel");
}

function function_cfce0b24() {
  clip = getent("clip_post_yamantau_briefing", "script_string");
  wait 46;
  clip delete();
  transient = savegame::function_6440b06b(#"transient");
  transient.var_16e4161b = 1;
  level thread savegame::function_7790f03();
}

function function_ae2b72b9() {}

function function_4a614026() {
  level.adler thread function_d16e71e6();
  level.park thread function_f5cec8cd();
  level.lazar thread function_db46f2d7();
  level.sims thread function_eb65bc98();
  level.hudson thread function_72ecde0e();
  level thread function_fa0444c9();
}

function function_d16e71e6() {
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh5_05300_adlr_whatsonyourmind_f5", 0.5, 0.5];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh5_05300_adlr_youreadytodothi_7f", 0.5, 0.5];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh5_05300_adlr_somethingelse_b6", 0.5, 0.5];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh5_05300_adlr_checkouttheboar_63", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh5_05300_adlr_finishuphereand_e9", 0.5];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&function_958c2188, &function_1bc95f5c, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_50b51e6e500b3071", undefined, "dt_1a", "waiting_idle", undefined, "adler_one_questioned");
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_50b1366e50077062", undefined, "dt_2a", "waiting_idle", 1, "adler_one_questioned", undefined, &function_91258c81);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_50ae126e5004fd5f", undefined, "dt_3a", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_1cc6be71f87aa037", undefined, "dt_3a_2", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_1cc6bd71f87a9e84", undefined, "dt_3a_3", "waiting_idle", undefined, "adler_one_questioned");

  switch (randomint(3)) {
    case 0:
      self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("adler_one_questioned", #"hash_50b51b6e500b2b58", undefined, ["dt_1b", "dt_1b_end1"], "waiting_idle");
      break;
    case 1:
      self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("adler_one_questioned", #"hash_50b51b6e500b2b58", undefined, ["dt_1b", "dt_1b_end2"], "waiting_idle");
      break;
    case 2:
      self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("adler_one_questioned", #"hash_50b51b6e500b2b58", undefined, ["dt_1b", "dt_1b_end3"], "waiting_idle");
      break;
  }

  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "adler_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("adler_convo_exit", #"hash_31876661817f34", ["vox_cp_sh5_05300_adlr_okay_c2", "vox_cp_sh5_05300_adlr_alright_f9"], undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
  level.var_7256f687 = dialog_tree::new_tree(undefined, undefined, 1, 1, self.var_ba1eee16.var_f2190d3d);
  level.var_7256f687 dialog_tree::add_option(#"hash_248fd071fca3dd09", undefined, "dt_2a_1", "waiting_idle", 1, undefined, undefined, &function_70185d79);
  level.var_7256f687 dialog_tree::add_option(#"hash_248fcd71fca3d7f0", undefined, "dt_2a_2", "waiting_idle", 1, undefined, undefined, &function_70185d79);
  self.var_ba1eee16.str_location = "tv_table";
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = 3;
  self.var_ba1eee16.var_142355f9 = array(240, 650);
  self.var_ba1eee16.var_9b7161e6 = array(1224, 650);
  self.var_ba1eee16.var_e9797a7f = array(240, 650);
  self.var_ba1eee16.var_cbdef43f = array(1224, 650);
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_958c2188() {
  if(level flag::get("adler_sub_tree")) {
    level flag::clear("adler_sub_tree");
    return;
  }

  level.adler namespace_31c67f6d::function_282ccb63();
}

function function_1bc95f5c() {
  if(!level flag::get("adler_sub_tree")) {
    level.adler namespace_31c67f6d::function_7b9b6d21();
  }
}

function function_91258c81() {
  level.adler waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
  level flag::set("adler_sub_tree");
  level dialog_tree::function_21780fc5(level.var_7256f687, self.var_ba1eee16.var_30dc5656);
  level.var_7256f687 thread dialog_tree::run(level.adler);
}

function function_70185d79() {
  level.adler waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
  level.adler.var_ba1eee16.s_tree thread dialog_tree::run(level.adler);
}

function function_f5cec8cd() {
  self setModel(#"c_t9_cp_eng_hero_park_safehouse_alt_body");
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh5_05300_park_bellididntexpec_6b", 0.5];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh5_05300_park_yes_70", 0.5];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh5_05300_park_somethingonyour_a1", 0.5];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh5_05300_park_staysafeoutther_3e", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh5_05300_park_comebacktousino_ed", 0.5];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&function_f09c19a, &function_62d9689d, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_93b9019659132a1", undefined, "dt_1a", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_41686e2795b8efc9", undefined, "dt_1a_2", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_41686d2795b8ee16", undefined, "dt_1a_3", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_93b8d1965912d88", undefined, "dt_1b", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_415e7c2795b0b30e", undefined, "dt_1b_2", "waiting_idle");

  if(int(level.player savegame::function_2ee66e93(#"hash_30b0b66be957c385", 0))) {
    self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_93b8e1965912f3b", undefined, "dt_1c_alt_adler", "waiting_idle", 1, "ask_about_parks_scar", undefined, &function_42091602);
  } else {
    self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_93b8e1965912f3b", undefined, "dt_1c", "waiting_idle", 1, "ask_about_parks_scar", undefined, &function_42091602);
  }

  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "park_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("park_convo_exit", #"hash_7e58f4ac9998f844", ["vox_cp_sh5_05300_park_illbehereifyoun_0f", "vox_cp_sh5_05300_park_verywell_a8"], undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
  level.var_b91aa91b = dialog_tree::new_tree(undefined, undefined, 1, 1, level.park.var_ba1eee16.var_f2190d3d);
  level.var_b91aa91b dialog_tree::add_option(#"hash_3991c627918429b9", undefined, "dt_2a_strength", "waiting_idle", 1, undefined, undefined, &function_93672bfc);
  level.var_b91aa91b dialog_tree::add_option(#"hash_3991c327918424a0", undefined, "dt_2a_beauty", "waiting_idle", 1, undefined, undefined, &function_93672bfc);
  level.var_b91aa91b dialog_tree::add_option(#"hash_3991c42791842653", undefined, "dt_2a_disgust", "waiting_idle", 1, undefined, undefined, &function_93672bfc);
  self.var_ba1eee16.str_location = "dark_room";
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = 3;
  self.var_ba1eee16.var_142355f9 = array(240, 650);
  self.var_ba1eee16.var_9b7161e6 = array(240, 650);
  self.var_ba1eee16.var_e9797a7f = array(240, 650);
  self.var_ba1eee16.var_cbdef43f = array(1224, 650);
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_f09c19a() {
  if(level.player namespace_78e9b80::function_e538e340("tv_flashback_safehouse_video")) {
    level flag::set("flag_player_approached_flashback_TV");
  }

  if(level flag::get("ask_about_parks_scar")) {
    level flag::clear("ask_about_parks_scar");
    return;
  }

  level.park namespace_31c67f6d::function_282ccb63();
}

function function_62d9689d() {
  if(!level flag::get("ask_about_parks_scar")) {
    level.park namespace_31c67f6d::function_7b9b6d21();
  }
}

function function_42091602() {
  level.park waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
  level flag::set("ask_about_parks_scar");
  level dialog_tree::function_21780fc5(level.var_b91aa91b, self.var_ba1eee16.var_30dc5656);
  level.var_b91aa91b thread dialog_tree::run(level.park);
}

function function_93672bfc() {
  level.park waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
  level.park.var_ba1eee16.s_tree thread dialog_tree::run(level.park);
}

function function_eb65bc98() {
  self setModel(#"c_t9_cp_usa_hero_sims_safehouse_body");
  namespace_31c67f6d::function_a0abc8d3(#"c_t9_usa_hero_sims_head1_safehouse_hair");
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh5_05300_sims_nope_c0", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh5_05400_sims_donttouchmylegs_d2", 0.5];
  self.var_ba1eee16.var_962cbf19[2] = ["vox_cp_sh5_05300_sims_youboredorwhat_7d", 0.5];
  self.var_ba1eee16.var_962cbf19[3] = ["vox_cp_sh5_05300_sims_guysbellslonely_aa", 0.5];
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.var_890ce7a8 = 1;
  self.var_ba1eee16.var_18674cfa = 0;
  self.var_ba1eee16.v_offset = (0, 0, 0);
  self flag::set("flag_dialog_exhausted");
  self flag::set("flag_speak_while_fidgeting");
  self thread namespace_31c67f6d::function_7b0516d7("j_knee_ri");
}

function function_db46f2d7() {
  self setModel(#"c_t9_cp_usa_hero_lazar_safehouse_alt_body1");
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh5_05300_lazr_timetobreakouty_1c_1", 0.5, 1];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh5_05300_lazr_yougonnakeepmak_3c_1", 0.5, 1];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh5_05300_lazr_andyoureback_41_1", 0.5, 1];
  self.var_ba1eee16.var_c5c9acca[3] = ["vox_cp_sh5_05300_lazr_yeah_c6_1", 0.5];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh5_05300_lazr_ithinkadlerwant_68_1", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh5_05300_lazr_welltalkmoreont_c6_1", 0.5];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&function_53d6abef, &function_bac07041, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_fae37590b46fe81", undefined, "dt_1a", "waiting_idle");

  if(level.player namespace_70eba6e6::function_b6a02677() != 3) {
    self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_fae34590b46f968", undefined, "dt_1b", "waiting_idle");
  } else {
    self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_fae34590b46f968", undefined, ["dt_1b", "dt_1b_if_kgb"], "waiting_idle", 1, "lazar_question", undefined, &function_708ca96d);
    level.var_ba909cc8 = dialog_tree::new_tree(undefined, undefined, 1, 1, level.lazar.var_ba1eee16.var_f2190d3d);
    level.var_ba909cc8 dialog_tree::add_option(#"hash_faa0f590b42d1b2", undefined, "dt_2a", "waiting_idle", 1, undefined, undefined, &function_67105bb3);
    level.var_ba909cc8 dialog_tree::add_option(#"hash_faa0e590b42cfff", undefined, "dt_2a", "waiting_idle", 1, undefined, undefined, &function_67105bb3);
  }

  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "lazar_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("lazar_convo_exit", #"hash_4aa1bc3224a18ea4", ["vox_cp_sh5_05300_lazr_yepitsalongwayt_32_1", "vox_cp_sh5_05300_lazr_bell_ad_1"], undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
  self.var_ba1eee16.str_location = "car";
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = 3;
  self.var_ba1eee16.var_89db7e3d = 1;
  self.var_ba1eee16.var_142355f9 = undefined;
  self.var_ba1eee16.var_9b7161e6 = undefined;
  self.var_ba1eee16.var_e9797a7f = undefined;
  self.var_ba1eee16.var_cbdef43f = undefined;
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_53d6abef() {
  if(is_true(level.var_cbf98853)) {
    level.var_cbf98853 = 0;
    return;
  }

  level.lazar namespace_31c67f6d::function_282ccb63();
}

function function_bac07041() {
  if(!is_true(level.var_cbf98853)) {
    level.lazar namespace_31c67f6d::function_7b9b6d21();
  }
}

function function_708ca96d() {
  level.var_cbf98853 = 1;
  level.lazar waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
  level dialog_tree::function_21780fc5(level.var_b91aa91b, self.var_ba1eee16.var_30dc5656);
  level.var_ba909cc8 thread dialog_tree::run(level.lazar);
}

function function_67105bb3() {
  level.lazar waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
  level.lazar.var_ba1eee16.s_tree thread dialog_tree::run(level.lazar);
}

function function_72ecde0e() {
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh5_05300_hdsn_haveyoucometoco_4e", 0.5];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh5_05300_hdsn_yeah_c6", 0.5];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh5_05300_hdsn_yougotsomething_f6", 0.5];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh5_05300_hdsn_isnttheresometh_ca", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh5_05300_hdsn_movealong_f6", 0.5];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "hudson_intro_over", 0, #"hash_527bd51edfa7c532", undefined, "dt_1a", "waiting_idle", undefined, "hudson_intro_over");
  self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "hudson_intro_over", 0, #"hash_527bd41edfa7c37f", undefined, "dt_1b", "waiting_idle", undefined, "hudson_intro_over");
  self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "hudson_intro_over", 0, #"hash_527bd31edfa7c1cc", undefined, "dt_1c", "waiting_idle", undefined, "hudson_intro_over");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("hudson_intro_over", #"hash_527ffd1edfabf201", undefined, "dt_2a", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("hudson_intro_over", #"hash_527ffa1edfabece8", undefined, "dt_2b", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("hudson_intro_over", #"hash_527ffb1edfabee9b", undefined, "dt_2c", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_5b665f7611268ade", undefined, "dt_2c_1", "waiting_idle");
  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "hudson_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("hudson_convo_exit", #"hash_2914a53aab8d4627", ["vox_cp_sh5_05300_hdsn_anexcellentprop_a7", "vox_cp_sh5_05300_hdsn_thankyou_a1", "vox_cp_sh5_05300_hdsn_godspeedsoldier_97"], undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
  self.var_ba1eee16.str_location = "clerk_desk";
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = 3;
  self.var_ba1eee16.var_142355f9 = array(1224, 650);
  self.var_ba1eee16.var_9b7161e6 = array(1224, 650);
  self.var_ba1eee16.var_e9797a7f = array(1224, 650);
  self.var_ba1eee16.var_cbdef43f = array(1224, 650);
  self.var_ba1eee16.var_89db7e3d = 1;
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_f50bc4b9() {
  flag::init("flag_post_yamantau_complete");
}

function function_6b03a78e(var_d3440450) {
  level namespace_31c67f6d::function_6194f34a("post_yamantau");
  level thread function_81c3adaf();
  setlightingstate(2);
  level notify(#"eboard_ready");
  clip = getent("clip_post_yamantau_briefing", "script_string");

  if(isDefined(clip)) {
    clip hide();
  }

  level thread namespace_31c67f6d::function_29279de1("post_yamantau");
  level thread namespace_31c67f6d::function_b0558ba2("5");
  level thread scene::play("scene_hub_env_reel_to_reel");
  level thread function_bbf2586d();
}

function function_81c3adaf() {
  level thread namespace_4ed3ce47::function_d89aa829();
  level thread namespace_4ed3ce47::function_938891c9();
  level thread namespace_4ed3ce47::function_d701d197();
}

function function_29390787(var_d3440450, var_50cc0d4f) {
  flag::wait_till("flag_post_yamantau_complete");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_bbf2586d() {
  level thread function_4a614026();
  level namespace_31c67f6d::function_7fd3a4d8(1);
  level thread scene::play("scene_hub_env_reel_to_reel");
  level thread scene::play("scene_hub_post_yamantau_dialog_adler", "zone_idle");
  level thread scene::play("scene_hub_post_yamantau_dialog_lazar", "zone_idle");
  level thread scene::play("scene_hub_post_yamantau_dialog_park", "zone_idle");
  level thread scene::play("scene_hub_post_yamantau_dialog_sims", "zone_idle");
  level thread scene::play("scene_hub_post_yamantau_dialog_hudson", "zone_idle");
}

function function_fa0444c9() {
  a_str_vo = spawnStruct();
  a_str_vo.sims = spawnStruct();
  a_str_vo.sims.dialog[0] = ["vox_cp_sh5_05300_sims_whistling_2a"];
  a_str_vo.sims.dialog[1] = ["vox_cp_sh5_05300_sims_goddammit_c4"];
  a_str_vo.sims.dialog[2] = ["vox_cp_sh5_05300_sims_therewego_18"];
  a_str_vo.sims.dialog[3] = ["vox_cp_sh5_05300_sims_whistling_2a_1"];
  a_str_vo.sims.dialog[5] = ["vox_cp_sh5_05300_sims_singlewhistle_f3"];
  level.sims thread namespace_31c67f6d::function_5bd9de0f(a_str_vo.sims.dialog, "notify_sims_speak", "flag_in_briefing", "flag_player_using_evidence_board");
}