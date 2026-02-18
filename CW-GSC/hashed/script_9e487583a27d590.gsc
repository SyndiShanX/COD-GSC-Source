/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_9e487583a27d590.gsc
***********************************************/

#using script_19971192452f4209;
#using script_4052585f7ae90f3a;
#using script_5513c8efed5ff300;
#using scripts\core_common\array_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace hub_post_takedown;

function function_f50bc4b9() {
  level flag::init("flag_post_takedown_complete");
  level flag::init("flag_post_takedown_ambient_scene_started");
  level flag::init("flag_post_takedown_post_briefing_scene_started");
}

function starting(var_d3440450) {}

function main(var_d3440450, var_50cc0d4f) {
  level thread function_24092391();
  level namespace_31c67f6d::function_6194f34a("post_takedown", undefined, 5);
  level thread function_21727b7c();
  level thread function_ce65b08f();
  level thread function_5ad45a0();
  level thread namespace_31c67f6d::function_15231086("eboard_ready");
  level thread namespace_31c67f6d::function_29279de1("post_takedown");
  level thread namespace_31c67f6d::function_b0558ba2("1");
  level thread namespace_31c67f6d::function_652d1850();
  level.adler thread namespace_31c67f6d::function_63de26a4();
  level thread function_a18b30d();
  level thread function_5a121cbf();
  level namespace_31c67f6d::function_7fd3a4d8(undefined, undefined, 7, 5);

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_ce65b08f() {
  while(!isDefined(level.adler)) {
    waitframe(1);
  }

  level.adler waittill(#"dialog_ready");
  transient = savegame::function_6440b06b(#"transient");
  transient.var_16e4161b = 1;
  level thread savegame::function_7790f03();
}

function function_a18b30d() {
  level thread scene::play("scene_hub_env_reel_to_reel");
}

function function_26282537() {
  level waittill(#"ambient_ext_override");
  level thread namespace_4ed3ce47::ambient_ext_override();
}

function function_d2e1f6b8() {
  level waittill(#"ambient_override_return_to_normal");
  level thread namespace_4ed3ce47::ambient_override_return_to_normal();
}

function function_5a121cbf() {
  thread function_26282537();
  thread function_d2e1f6b8();
  level thread exploder::exploder("exp_fx_post_takedown");
  level.park waittill(#"dialog_ready");
  wait 10;

  while(true) {
    while(!level flag::get("flag_player_in_dialog") && !level.park flag::get("flag_fidgeting") && !level flag::get("flag_player_using_evidence_board")) {
      level.park notify(#"kill_dialog");
      level.park flag::set("flag_in_scene");
      level.sims notify(#"kill_dialog");
      level.sims flag::set("flag_in_scene");
      wait 4;
      level flag::set("flag_post_takedown_post_briefing_scene_started");
      level.sims thread namespace_31c67f6d::function_ac8d8290("scene_hub_ambient_old_negatives", "scene_hub_post_takedown_dialog_sims", "zone_idle");
      level.park thread namespace_31c67f6d::function_ac8d8290("scene_hub_ambient_old_negatives", "scene_hub_post_takedown_dialog_park", "zone_idle");
      level scene::play("scene_hub_ambient_old_negatives");
      return;
    }

    waitframe(1);
  }
}

function function_5ad45a0() {
  level.adler thread function_119e27a3();
  level.park thread function_1c60d4db();
  level.lazar thread function_183e5d08();
  level.sims thread function_bfdc7939();
}

function function_119e27a3() {
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh1a_00500_adlr_aa4f16bd14fc4ceb", 0.1, 0.3];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh1a_00500_adlr_DBA366B9DE5D484F", 0.4, 0.5];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh1a_00500_adlr_538872883F5F48F0", 0.7, 0.5];
  self.var_ba1eee16.var_c5c9acca[3] = ["vox_cp_sh1a_00500_adlr_65706DCC469B4344", 0.8, 0.5];
  self.var_ba1eee16.var_c5c9acca[4] = ["vox_cp_sh1a_00500_adlr_0A2DDFCEADAC4544", 0.4, 0.5];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh1a_00500_adlr_6EFCE60B7DA9426A", 0.2];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh1a_00500_adlr_DA02E7BA917F4EFE", 0.5];
  self.var_ba1eee16.var_962cbf19[2] = ["vox_cp_sh1a_00500_adlr_50CE6BF6A1F34791", 0.5];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, undefined, 0, #"hash_5223fd277e6bb082", undefined, "dt_03", "waiting_idle", 0, "flag_adler_dialog_option2_unlocked", "adler_tkdn_dlg_nvm", &function_12e71d53);
  self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, undefined, 0, #"hash_5223fc277e6baecf", undefined, "dt_04", "waiting_idle", 0, "flag_adler_dialog_option2_unlocked", "adler_tkdn_dlg_nvm", &function_4ae640f1);
  self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, undefined, 0, #"hash_5223fb277e6bad1c", undefined, "dt_05", "waiting_idle", 0, undefined, "adler_tkdn_dlg_nvm");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_7ed0f21bd0f7452a", undefined, "dt_06", "waiting_idle", 0, "flag_adler_dialog_option2_unlocked");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("flag_adler_dialog_option2_unlocked", #"hash_5226e5277e6dbd91", undefined, "dt_07", "waiting_idle", 0, "flag_adler_dialog_option3_unlocked");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("flag_adler_dialog_option2_unlocked", #"hash_5226e2277e6db878", undefined, "dt_08", "waiting_idle", 0, "flag_adler_dialog_option3_unlocked");

  if(level.player namespace_70eba6e6::function_b6a02677() == 2) {
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("flag_adler_dialog_option2_unlocked", #"hash_5226e3277e6dba2b", undefined, ["dt_12_alt_mi6", "dt_12"], "waiting_idle", 0, "flag_adler_dialog_option3_unlocked");
  } else {
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("flag_adler_dialog_option2_unlocked", #"hash_5226e3277e6dba2b", undefined, ["dt_09", "dt_11", "dt_12"], "waiting_idle", 0, "flag_adler_dialog_option3_unlocked");
  }

  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("flag_adler_dialog_option3_unlocked", #"hash_522a09277e703094", undefined, "dt_13", "waiting_idle", 0, "flag_lazar_dialog_option1_unlocked");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_d9e341bd8a2aa12", undefined, "dt_14", "waiting_idle", 0);
  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "adler_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, ["flag_dialog_nevermind", "flag_adler_dialog_option2_unlocked", "adler_tkdn_dlg_nvm"], "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("adler_convo_exit", #"hash_4d99d18c82903f97", ["vox_cp_sh1a_00500_adlr_5B42DE8BA64E4E60", "vox_cp_sh1a_00500_adlr_5E9CE8A4219F42CA", "vox_cp_sh1a_00500_adlr_754989DE042B47CF", "vox_cp_sh1a_00500_adlr_B3EB7A6EF972428A"], undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
  self.var_ba1eee16.str_location = "map_table";
  self.var_ba1eee16.v_offset = (0, 0, 0);
  self.var_ba1eee16.n_fov = undefined;
  self.var_49c9cf55 = undefined;
  self.var_ba1eee16.var_142355f9 = undefined;
  self.var_ba1eee16.var_9b7161e6 = undefined;
  self.var_ba1eee16.var_e9797a7f = undefined;
  self.var_ba1eee16.var_cbdef43f = undefined;
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_12e71d53() {
  self waittill(#"hash_12324459eb2bc76d");

  if(level.lazar flag::get("flag_in_scene")) {
    level.lazar thread dialogue::queue("vox_cp_sh1a_00500_lazr_311393DEBB08452B");
    return;
  }

  level.lazar thread dialogue::queue("vox_cp_sh1a_00500_lazr_E3DA29536D02434E");
}

function function_4ae640f1() {
  self waittill(#"hash_12324459eb2bc76d");
  level thread scene::play(self.var_ba1eee16.var_f2190d3d, "waiting_idle");
  level.sims thread dialogue::queue("vox_cp_sh1a_00500_sims_8CCF752E1BF74BAF");
}

function function_1c60d4db() {
  self setModel(#"c_t9_cp_eng_hero_park_safehouse_body_intro");
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh1p_00500_park_howarethingsbel_3d", 0.5];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh1p_00500_park_somethingelse_b6", 0.5];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh1p_00500_park_yesbell_3b", 0.5];
  self.var_ba1eee16.var_c5c9acca[3] = ["vox_cp_sh1p_00500_park_mmhmm_4a", 0.5];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh1p_00500_park_iwouldntkeepadl_c1", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh1p_00500_park_dontforgetabout_8c", 0.5];
  self.var_ba1eee16.var_962cbf19[2] = ["vox_cp_sh1p_00500_park_bell_ad", 0.5];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_19a3f35edaae0f8c", undefined, "dt_01", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_3fa6482d95c4bfda", undefined, "dt_02", "waiting_idle");

  if(level.player namespace_70eba6e6::function_b6a02677() == 2) {
    self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_19a3f65edaae14a5", undefined, "dt_03_alt_mi6", "waiting_idle");
  } else {
    self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_19a3f65edaae14a5", undefined, "dt_03", "waiting_idle");
  }

  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_19a3f55edaae12f2", undefined, "dt_04", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_3facb02d95c9dc40", undefined, "dt_05", "waiting_idle");
  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "exit_park_convo", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("exit_park_convo", #"hash_55906a2b07502f11", ["vox_cp_sh1p_00500_park_welltalkagainso_88", "vox_cp_sh1p_00500_park_laterbell_f1", "vox_cp_sh1p_00500_park_cheerio_ed", "vox_cp_sh1p_00500_park_mmmhm_4a"], undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
  self.var_ba1eee16.str_location = "comms_l";
  self.var_ba1eee16.v_offset = (0, 0, 0);
  self.var_ba1eee16.n_fov = 6;
  self.var_ba1eee16.var_e1eebb0b = 3;
  self.var_ba1eee16.var_142355f9 = array(240, 650);
  self.var_ba1eee16.var_9b7161e6 = undefined;
  self.var_ba1eee16.var_e9797a7f = array(240, 650);
  self.var_ba1eee16.var_cbdef43f = array(240, 650);
  self.var_ba1eee16.var_82a12581 = 1;
  self.var_ba1eee16.var_d0816878 = 1.5;
  self.var_ba1eee16.var_89db7e3d = 1;
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_183e5d08() {
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh1z_00500_lazr_bell_ad", 0.5];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh1z_00500_lazr_yeah_c6", 0.5];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh1z_00500_lazr_whatsup_46", 0.5];
  self.var_ba1eee16.var_c5c9acca[3] = ["vox_cp_sh1z_00500_lazr_uhhuh_50", 0.5];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&function_53d6abef, &function_bac07041, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_fb13d71f36cb2d6", undefined, ["dt_01", "dt_02"], "waiting_idle", 0, undefined, undefined, &function_7367c08f);
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_16de4ca0a1b3f96c", undefined, ["dt_03", "dt_04"], "waiting_idle", 0, undefined, undefined, &function_7367c08f);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_fb13c71f36cb123", undefined, "dt_05", "waiting_idle", 0, undefined, undefined, &function_7367c08f);
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("flag_lazar_dialog_option1_unlocked", #"hash_fb42571f36ebfe5", undefined, "dt_06", "waiting_idle", 0, undefined, undefined, &function_7367c08f);
  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "exit_lazar_convo", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("exit_lazar_convo", #"hash_2f64cfbbf513db93", undefined, undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.str_location = "gun_table";
  self.var_ba1eee16.v_offset = (0, 0, 2);
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = 3;
  self.var_ba1eee16.var_142355f9 = undefined;
  self.var_ba1eee16.var_9b7161e6 = undefined;
  self.var_ba1eee16.var_e9797a7f = array(1224, 650);
  self.var_ba1eee16.var_cbdef43f = array(240, 650);
  self.var_ba1eee16.var_82a12581 = 3;
  self.var_ba1eee16.var_d0816878 = 2;
  self.var_ba1eee16.var_6edf22e1 = 0;
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_53d6abef() {
  level.sims flag::set("flag_in_dialog");
  self namespace_31c67f6d::function_282ccb63();
}

function function_bac07041() {
  level.sims flag::clear("flag_in_dialog");
  self namespace_31c67f6d::function_7b9b6d21();
}

function function_7367c08f() {
  self.var_ba1eee16.var_6edf22e1 = 1;
  level flag::set("talked_to_lazar_post_takedown");
}

function function_bfdc7939() {
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh1_00101_sims_alotofthisstuff_7f", 0.25];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh1_00101_sims_itsgonnatakeali_65", 0.25];
  self.var_ba1eee16.var_962cbf19[2] = ["vox_cp_sh1_00101_sims_bell_ad", 0.25];
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "sims_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, ["flag_dialog_nevermind"], "forever");
  self.var_ba1eee16.var_890ce7a8 = 1;
  self.var_ba1eee16.var_18674cfa = 0;
  self.var_ba1eee16.var_89db7e3d = 1;
  self flag::set("flag_dialog_exhausted");
  self flag::set("flag_speak_while_fidgeting");
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_24092391() {
  level thread namespace_4ed3ce47::function_44ce38f6();
}

function function_21727b7c() {
  level thread namespace_4ed3ce47::function_e043da15();
  level thread namespace_4ed3ce47::function_c7f31c4b();
  level thread namespace_4ed3ce47::function_e81e970a();
}

function function_e937a9b(var_d3440450) {
  level namespace_31c67f6d::function_6194f34a("post_takedown");
  level thread function_21727b7c();
  level notify(#"hash_30a43574a5dc7eaf");
  level notify(#"eboard_ready");
  level thread namespace_31c67f6d::function_29279de1("post_takedown");
  level thread namespace_31c67f6d::function_b0558ba2("1");
  level thread namespace_31c67f6d::function_652d1850();
  level.adler thread namespace_31c67f6d::function_63de26a4();
  level thread function_a7c58081();
}

function function_e695c6d4(var_d3440450, var_50cc0d4f) {
  level thread function_c151a47e();
  level flag::wait_till("flag_post_takedown_ambient_scene_started");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_a7c58081() {
  level thread function_5ad45a0();
  level namespace_31c67f6d::function_7fd3a4d8(1, undefined, 1);
  level thread exploder::stop_exploder("exp_post_takedown_briefing_intro");
  level thread exploder::exploder("exp_post_takedown_park_bounce");
  level thread exploder::exploder("exp_post_takedown_adler_afterbrief");
  level thread scene::play("scene_hub_env_reel_to_reel");
  level thread scene::play("scene_hub_post_takedown_dialog_adler", "zone_idle");
  level thread scene::play("scene_hub_post_takedown_dialog_lazar", "zone_idle");
  level thread scene::play("scene_hub_post_takedown_dialog_park", "zone_idle");
  level thread scene::play("scene_hub_post_takedown_dialog_sims", "zone_idle");
}

function function_c151a47e() {
  level.adler thread function_4dde8d1b();

  while(true) {
    level.lazar waittill(#"dialog_active");
    level.lazar waittill(#"dialog_tree_end");

    if(level flag::get("talked_to_lazar_post_takedown")) {
      level.sims thread namespace_31c67f6d::function_7cccaccb();
      level.lazar notify(#"kill_dialog");
      thread function_6ad219dd();
      level util::delay(3, undefined, &flag::clear, "flag_player_in_dialog");
      break;
    }
  }
}

function function_6ad219dd() {
  wait 0.5;
  thread function_2288aa67();
  level.sims thread function_8d7194d8();
  level.lazar thread function_89f6dfa8();
  level thread function_7040e7b1();
}

function function_8d7194d8() {
  self flag::set("flag_in_scene");
  level.sims notify(#"kill_dialog");
  level scene::play("scene_hub_post_takedown_dialog_sims", "amb_enter");
}

function function_2288aa67() {
  level waittill(#"hash_2f155d3aad417a6c");
  thread namespace_4ed3ce47::function_dc08e48d();
}

function function_89f6dfa8() {
  self flag::set("flag_in_scene");

  switch (level.var_4d1402c5) {
    case # "player_in_front":
      level scene::play("scene_hub_post_takedown_dialog_lazar", "amb_enter_front");
      break;
    case # "player_in_back":
      level scene::play("scene_hub_post_takedown_dialog_lazar", "amb_enter_behind");
      break;
    case # "player_to_left":
      level scene::play("scene_hub_post_takedown_dialog_lazar", "amb_enter_left");
      break;
    case # "player_to_right":
      level scene::play("scene_hub_post_takedown_dialog_lazar", "amb_enter_right");
      break;
  }

  level scene::play("scene_hub_ambient_work_the_heavy_bag", "main");
  level thread scene::play("scene_hub_ambient_work_the_heavy_bag", "loop");
}

function function_7040e7b1() {
  a_str_vo = spawnStruct();
  a_str_vo.lazar = spawnStruct();
  a_str_vo.lazar.dialog[0] = ["vox_cp_sh1_00101_lazr_ineedtomovealit_3c"];
  a_str_vo.lazar.dialog[1] = ["vox_cp_sh1_00101_lazr_bag_38"];
  a_str_vo.lazar.dialog[2] = ["vox_cp_sh1_00101_lazr_motherfucker_1d"];
  a_str_vo.lazar.dialog[3] = ["vox_cp_sh1_00101_lazr_allgood_21"];
  a_str_vo.lazar.dialog[4] = ["vox_cp_sh1_00101_lazr_afewmore_b5"];
  a_str_vo.lazar.dialog[5] = ["vox_cp_sh1_00101_lazr_mindgrabbinit_b4"];
  a_str_vo.lazar.dialog[6] = ["vox_cp_sh1_00101_lazr_youmind_44"];
  level.lazar thread namespace_31c67f6d::function_5bd9de0f(a_str_vo.lazar.dialog, "notify_lazar_speak", "forever");
  a_str_vo.lazar.grunt[0] = ["vox_cp_sh1_00101_lazr_oomph_31"];
  a_str_vo.lazar.grunt[1] = ["vox_cp_sh1_00101_lazr_nmph_b4"];
  a_str_vo.lazar.grunt[2] = ["vox_cp_sh1_00101_lazr_uhhuhgood_27"];
  a_str_vo.lazar.grunt[3] = ["vox_cp_sh1_00101_lazr_ungh_c0"];
  a_str_vo.lazar.grunt[4] = ["vox_cp_sh1_00101_lazr_another_ff"];
  a_str_vo.lazar.grunt[5] = ["vox_cp_sh1_00101_lazr_again_0e"];
  a_str_vo.lazar.grunt[6] = ["vox_cp_sh1_00101_lazr_takeit_a3"];
  a_str_vo.lazar.grunt[7] = ["vox_cp_sh1_00101_lazr_exertionsound_08"];
  a_str_vo.lazar.grunt[8] = ["vox_cp_sh1_00101_lazr_exertionsound_08_1"];
  a_str_vo.lazar.grunt[9] = ["vox_cp_sh1_00101_lazr_exertionsound_08_2"];
  a_str_vo.lazar.grunt[10] = ["vox_cp_sh1_00101_lazr_exertionsound_08_3"];
  level.lazar thread namespace_31c67f6d::function_5bd9de0f(a_str_vo.lazar.grunt, "notify_lazar_grunt", "forever");
  a_str_vo.sims = [];
  a_str_vo.sims[0] = ["vox_cp_sh1_00101_sims_pretendlikeitsw_08"];
  a_str_vo.sims[1] = ["vox_cp_sh1_00101_sims_comeonbaby_99"];
  a_str_vo.sims[2] = ["vox_cp_sh1_00101_sims_howstheshoulder_c2"];
  a_str_vo.sims[3] = ["vox_cp_sh1_00101_sims_allyou_c4"];
  a_str_vo.sims[4] = ["vox_cp_sh1_00101_sims_howmuchyougot_21"];
  a_str_vo.sims[5] = ["vox_cp_sh1_00101_sims_hipshipsgetting_4d"];
  a_str_vo.sims[6] = ["vox_cp_sh1_00101_sims_pushthroughit_ec"];
  a_str_vo.sims[7] = ["vox_cp_sh1_00101_sims_keepthepace_57"];
  a_str_vo.sims[8] = ["vox_cp_sh1_00101_sims_push_ce"];
  a_str_vo.sims[9] = ["vox_cp_sh1_00101_sims_thereyougo_99"];
  a_str_vo.sims[10] = ["vox_cp_sh1_00101_sims_yeah_b5"];
  a_str_vo.sims[11] = ["vox_cp_sh1_00101_sims_notbad_a6"];
  a_str_vo.sims[12] = ["vox_cp_sh1_00101_sims_good_b7"];
  a_str_vo.sims[13] = ["vox_cp_sh1_00101_sims_holdup_ba"];
  a_str_vo.sims[14] = ["vox_cp_sh1_00101_sims_yougotthis_ad"];
  level.sims thread namespace_31c67f6d::function_5bd9de0f(a_str_vo.sims, "notify_sims_speak", "forever");
}

function function_4dde8d1b() {
  var_9057efea = getent("volume_adler_check_back_corner", "targetname");
  var_e698e973 = struct::get("struct_adler_check_back_corner", "targetname");
  var_d3a1e64d = getent("volume_adler_check_front_hall", "targetname");
  var_f9dcfdfc = struct::get("struct_adler_check_front_hall", "targetname");

  while(true) {
    level function_a3e12ec8(var_9057efea, var_e698e973, "back_corner");
    level function_a3e12ec8(var_d3a1e64d, var_f9dcfdfc, "front_hall");
    wait 0.25;
  }
}

function function_a3e12ec8(volume, struct, str_shot) {
  while(isDefined(volume) && level.player istouching(volume)) {
    while(level.adler flag::get("flag_fidgeting")) {
      level.adler flag::clear("flag_fidget_interrupt_start");
      waitframe(1);
    }

    if(!(isDefined(volume) && level.player istouching(volume))) {
      continue;
    }

    if(level.player util::point_in_fov(struct.origin + (0, 0, 32), 0, 1) && !level.player util::point_in_fov(struct.origin + (0, 0, 32), 0.71, 1)) {
      level.adler flag::set("flag_in_scene");
      level.adler notify(#"kill_dialog");
      wait 0.1;
      level scene::play("scene_hub_ambient_check_on_bell", str_shot);
      level thread scene::play(level.adler.var_ba1eee16.var_f2190d3d, "zone_idle");
      level.adler util::delay(0.1, undefined, &flag::clear, "flag_in_dialog");
      level.adler util::delay(0.1, undefined, &flag::clear, "flag_in_scene");
      wait 1;
    }

    waitframe(1);
  }
}

function function_c6fd7841(var_d3440450) {
  level namespace_31c67f6d::function_6194f34a("post_takedown");
  level thread function_21727b7c();
  level notify(#"hash_30a43574a5dc7eaf");
  level thread exploder::exploder("exp_scene_work_the_heavy_bag");
  level thread exploder::stop_exploder("exp_post_takedown_briefing_intro");
  level thread exploder::exploder("exp_post_takedown_park_bounce");
  level thread exploder::exploder("exp_post_takedown_adler_afterbrief");
  level notify(#"eboard_ready");
  level thread namespace_31c67f6d::function_29279de1("post_takedown");
  level thread namespace_31c67f6d::function_b0558ba2("1");
  level thread namespace_31c67f6d::function_652d1850();
  level.adler thread namespace_31c67f6d::function_63de26a4();
  level thread function_a74a977e();
}

function function_7fb12c66(var_d3440450, var_50cc0d4f) {
  flag::wait_till("flag_post_takedown_complete");
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_a74a977e() {
  level thread function_5ad45a0();
  level namespace_31c67f6d::function_7fd3a4d8(1, undefined, 1);
  level thread scene::play("scene_hub_env_reel_to_reel");
  level thread scene::play("scene_hub_post_takedown_dialog_adler", "zone_idle");
  level thread scene::play("scene_hub_post_takedown_dialog_park", "zone_idle");
  level.lazar flag::set("flag_in_scene");
  level.lazar notify(#"kill_dialog");
  level.sims flag::set("flag_in_scene");
  level.sims notify(#"kill_dialog");
  level thread scene::play("scene_hub_ambient_work_the_heavy_bag", "loop");
  level thread function_7040e7b1();
}