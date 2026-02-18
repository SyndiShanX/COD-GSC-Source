/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_ger_hub_post_armada.gsc
***********************************************/

#using script_19971192452f4209;
#using script_4052585f7ae90f3a;
#using script_5513c8efed5ff300;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#namespace hub_post_armada;

function starting(var_d3440450) {}

function main(var_d3440450, var_50cc0d4f) {
  level namespace_31c67f6d::function_6194f34a("post_armada");
  level thread function_f856db57();
  setlightingstate(1);
  level thread exploder::exploder("exp_fx_post_armada");
  level thread function_35e99044();
  level thread namespace_31c67f6d::function_15231086("eboard_ready");
  s_player_start = struct::get("s_post_armada_player_start", "targetname");
  level.player setorigin(s_player_start.origin);
  level.player setplayerangles(s_player_start.angles);
  level thread namespace_31c67f6d::function_29279de1("post_armada");
  level thread namespace_31c67f6d::function_b0558ba2("2");
  scene::init("scene_hub_post_armada_dialog_lazar");
  scene::init("scene_hub_post_armada_dialog_sims");
  level thread scene::play("scene_hub_env_reel_to_reel");
  level thread function_ae2b72b9();
  level namespace_31c67f6d::function_7fd3a4d8(undefined, undefined, 3, 1);

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_ae2b72b9() {
  wait 1;
  level.player val::set(#"hash_1758bde589c2e32c", "freezecontrols", 1);
  wait 4;
  level.player val::set(#"hash_1758bde589c2e32c", "freezecontrols", 0);
  level notify(#"hash_6b714d5d8d203c49");
}

function function_35e99044() {
  level.adler function_e568e0d4();
  level.park function_650cdcc9();
  level.sims function_5312ebff();
  level.lazar function_ae2b7b0f();
}

function function_e568e0d4() {
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh2_02175_adlr_niceworkproduci_d8", 0.4, 0.5];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh2_02175_adlr_kid_46", 0.4, 0.5];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh2_02175_adlr_whatsup_46", 0.7, 0.5];
  self.var_ba1eee16.var_c5c9acca[3] = ["vox_cp_sh2_02175_adlr_bell_ad", 0.8, 0.5];
  self.var_ba1eee16.var_c5c9acca[4] = ["vox_cp_sh2_02175_adlr_whatsonyourmind_f5", 0.4, 0.5];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh2_02175_adlr_headonovertothe_05", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh2_02175_adlr_timetogetreadyb_20", 0.5];
  self.var_ba1eee16.var_962cbf19[2] = ["vox_cp_sh2_02175_adlr_checkouttheboar_0d", 0.5];
  level thread function_b81255af();
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  level.var_9727ef13[0] = self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_67f2099c8ca17a13", undefined, ["dt_1a_part1", "dt_1a_part2"], "waiting_idle", 0, "adler_option3", undefined, &function_882e253f);
  level.var_9727ef13[1] = self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_67f20a9c8ca17bc6", undefined, "dt_1b", "waiting_idle", 0, "adler_option3", undefined, &function_882e253f);
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("post_armada_busted_evesdropping", #"hash_67fc399c8caa2028", undefined, "dt_1c", "waiting_idle");

  if(randomint(2) > 0) {
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("post_armada_not_busted_evesdropping", #"hash_67fc399c8caa2028", undefined, "dt_1c_alt_1", "waiting_idle");
  } else {
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("post_armada_not_busted_evesdropping", #"hash_67fc399c8caa2028", undefined, "dt_1c_alt_2", "waiting_idle");
  }

  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "exit_adler_convo", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("exit_adler_convo", #"hash_5ddc0f17824e186", ["vox_cp_sh2_02175_adlr_wellleavewithin_dc", "vox_cp_sh2_02175_adlr_checkouttheboar_63"], undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
  self.var_ba1eee16.var_85ed2b41 = undefined;
  self.var_ba1eee16.str_location = "map_table";
  self.var_ba1eee16.v_offset = (0, 0, 0);
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = undefined;
  self.var_ba1eee16.var_142355f9 = array(240, 650);
  self.var_ba1eee16.var_9b7161e6 = undefined;
  self.var_ba1eee16.var_e9797a7f = undefined;
  self.var_ba1eee16.var_cbdef43f = array(240, 650);
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_b81255af() {
  level flag::wait_till("post_armada_phone_call_happening");
  level thread function_be5b3167();
  level flag::wait_till_any(["flag_post_armada_eavesdropped_timeout", "post_armada_evesdropped"]);

  if(level flag::get("post_armada_evesdropped")) {
    level flag::set("post_armada_busted_evesdropping");
    level flag::clear("post_armada_not_busted_evesdropping");
    level.sims lookatentity(level.player, 1);
    wait 1;
    level.sims dialogue::queue("vox_cp_sh2_02200_sims_whatyouthinkeve_b9");
    wait 1;
    level.sims lookatentity();
    return;
  }

  level flag::clear("post_armada_busted_evesdropping");
  level flag::set("post_armada_not_busted_evesdropping");
}

function function_be5b3167() {
  wait 80;
  level flag::set("flag_post_armada_eavesdropped_timeout");
}

function function_650cdcc9() {
  self setModel(#"c_t9_eng_hero_park_undercover_berlin_body1");
  namespace_31c67f6d::function_a0abc8d3(#"c_t9_cp_eng_hero_park_head_undcvr_stakeout");
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh2p_00500_park_thatintelyoufou_db", 0.8, 0.5];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh2p_00500_park_bell_be", 0.9, 0.5];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh2p_00500_park_yes_70", 1, 0.5];
  self.var_ba1eee16.var_c5c9acca[3] = ["vox_cp_sh2p_00500_park_yeswhatisit_69", 1.2, 0.5];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh2p_00500_park_ireallyneedtoco_6a", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh2p_00500_park_welltalkmoreano_3c", 0.5];
  self.var_ba1eee16.var_962cbf19[2] = ["vox_cp_sh2p_00500_park_ineedsometimeto_e4", 0.5];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_4ac1c40d7b52e213", undefined, "dt_1a", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_5a2243e88dd63e13", undefined, ["dt_1a_2_part1", "dt_1a_2_part2"], "waiting_idle");
  var_169ba887 = undefined;

  if(level.player namespace_70eba6e6::function_33bf99f8(1) == 2) {
    var_169ba887 = self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_4ac1c50d7b52e3c6", undefined, ["dt_1b", "dt_1b_alt_fem"], "waiting_idle");
  } else {
    var_169ba887 = self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_4ac1c50d7b52e3c6", undefined, "dt_1b", "waiting_idle");
  }

  self.var_ba1eee16.s_tree dialog_tree::function_ad98a815(var_169ba887, #"hash_5a25c9e88dd9579c", undefined, "dt_1b_2", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_5a25cae88dd9594f", undefined, "dt_1b_3", "waiting_idle", undefined, undefined, undefined, &function_d675c2b1);
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_5a25c7e88dd95436", undefined, "dt_1b_4", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_4ac1c60d7b52e579", undefined, ["dt_1c_part1", "dt_1c_part2"], "waiting_idle");
  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "park_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, ["flag_dialog_nevermind", "flag_adler_dialog_option2_unlocked", "adler_tkdn_dlg_nvm"], "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("park_convo_exit", #"hash_68ad7b6266d64986", ["vox_cp_sh2p_00500_park_mypleasure_75", "vox_cp_sh2p_00500_park_bell_ad", "vox_cp_sh2p_00500_park_ofcourse_94"], undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
  self.var_ba1eee16.str_location = "comms";
  self.var_ba1eee16.v_offset = (0, 0, -2);
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = 3;
  self.var_ba1eee16.var_142355f9 = undefined;
  self.var_ba1eee16.var_9b7161e6 = undefined;
  self.var_ba1eee16.var_e9797a7f = undefined;
  self.var_ba1eee16.var_cbdef43f = undefined;
  self.var_ba1eee16.var_89db7e3d = 1;
  level thread function_7b83d7d();
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_d675c2b1() {
  level.player savegame::set_player_data(#"hash_30b0b66be957c385", 1);
}

function function_7b83d7d() {
  thread scene::play("scene_hub_post_armada_dialog_mixer", "stop_playing");

  while(true) {
    var_c564fe97 = level waittill(#"nagra_play", #"nagra_rew", #"nagra_stop", #"nagra_ff");
    thread scene::stop();

    switch (var_c564fe97._notify) {
      case # "nagra_play":
        namespace_4ed3ce47::function_8f4b8ec9();
        thread scene::play("scene_hub_post_armada_dialog_mixer", "playing");
        break;
      case # "nagra_rew":
        namespace_4ed3ce47::function_12b07b90();
        thread scene::play("scene_hub_post_armada_dialog_mixer", "rewind");
        break;
      case # "nagra_stop":
        namespace_4ed3ce47::function_a6bc28c4();
        thread scene::play("scene_hub_post_armada_dialog_mixer", "stop_playing");
        break;
      case # "nagra_ff":
        namespace_4ed3ce47::function_326eae5c();
        break;
    }
  }
}

function function_5312ebff() {
  self setModel(#"c_t9_cp_usa_hero_sims_berlin_undercover_body1");
  namespace_31c67f6d::function_a0abc8d3(#"c_t9_usa_hero_sims_head1_berlin");
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh2_02200_sims_heretoentertain_a2", 0.5];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh2_02200_sims_hello_22", 0.5];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh2_02200_sims_yeahwhatsup_39", 0.5];
  self.var_ba1eee16.var_c5c9acca[3] = ["vox_cp_sh2_02200_sims_bell_ad", 0.5];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh2_02200_sims_mightwanttohead_1e", 0.2];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh2_02200_sims_maybelater_54", 0.2];
  self.var_ba1eee16.var_962cbf19[2] = ["vox_cp_sh2_02200_sims_ivegotsomeworkt_2f", 0.2];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_41faec541b6b39bf", undefined, ["dt_1a_part1", "dt_1a_part2", "dt_1a_part3"], "waiting_idle", 0, "unlock_sims_options", "unlock_sims_options");
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_41faed541b6b3b72", undefined, ["dt_1b_part1", "dt_1b_part2", "dt_1b_part3"], "waiting_idle", 0, "unlock_sims_options", "unlock_sims_options");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("unlock_sims_options", #"hash_42051c541b73dfd4", undefined, ["dt_2a_part1", "dt_2a_part2", "dt_2a_part3", "dt_2a_part4"], "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_228f07eaa5e5721f", undefined, "dt_2a_2", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_228f08eaa5e573d2", undefined, "dt_2a_3", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_228f09eaa5e57585", undefined, ["dt_2a_4_part1", "dt_2a_4_part2"], "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_228f02eaa5e569a0", undefined, ["dt_2a_5_part1", "dt_2a_5_part2", "dt_2a_5_part3"], "waiting_idle", 0, undefined, undefined, &function_3a2c335c);
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("unlock_sims_options", #"hash_42051f541b73e4ed", undefined, ["dt_2b_part1", "dt_2b_part2"], "waiting_idle", 0, undefined, undefined, &function_3a2c335c);

  if(level.player namespace_70eba6e6::function_b6a02677() == 1) {
    level.var_9727ef13[2] = self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("unlock_sims_options", #"hash_42051e541b73e33a", undefined, ["dt_2c_cia_part1", "dt_2c_cia_part2"], "waiting_idle", 0, undefined, undefined, &function_3a2c335c);
  }

  if(level.player namespace_70eba6e6::function_b6a02677() == 2) {
    level.var_9727ef13[2] = self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("unlock_sims_options", #"hash_42051e541b73e33a", undefined, ["dt_2c_mi6_part1", "dt_2c_mi6_part2"], "waiting_idle", 0, undefined, undefined, &function_3a2c335c);
  }

  if(level.player namespace_70eba6e6::function_b6a02677() == 3) {
    level.var_9727ef13[2] = self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("unlock_sims_options", #"hash_42051e541b73e33a", undefined, ["dt_2c_kgb_part1", "dt_2c_kgb_part2"], "waiting_idle", 0, undefined, undefined, &function_3a2c335c);
  }

  if(level.player namespace_70eba6e6::function_b6a02677() == 0) {
    level.var_9727ef13[2] = self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("unlock_sims_options", #"hash_42051e541b73e33a", undefined, ["dt_2c_classified_part1", "dt_2c_classified_part2"], "waiting_idle", 0, undefined, undefined, &function_3a2c335c);
  }

  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "sims_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, ["flag_dialog_nevermind", "flag_adler_dialog_option2_unlocked", "adler_tkdn_dlg_nvm"], "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("sims_convo_exit", #"hash_76eebb9381390c1a", ["vox_cp_sh2_02200_sims_comeagain_d2", "vox_cp_sh2_02200_sims_yep_5c", "vox_cp_sh2_02200_sims_yougotit_d2"], undefined, "waiting_idle", 1, undefined, "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
  self.var_ba1eee16.str_location = "clerk_desk";
  self.var_ba1eee16.v_offset = (0, 0, 0);
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = undefined;
  self.var_ba1eee16.var_142355f9 = undefined;
  self.var_ba1eee16.var_9b7161e6 = undefined;
  self.var_ba1eee16.var_e9797a7f = undefined;
  self.var_ba1eee16.var_cbdef43f = array(240, 650);
  self.var_ba1eee16.var_89db7e3d = 1;
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_ae2b7b0f() {
  self thread function_4d1189ac();
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh2_02250_lazr_welltalkonthedr_ec", 0.25];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh2_02250_lazr_holdthatthought_a9", 0.25];
  self.var_ba1eee16.var_962cbf19[2] = ["vox_cp_sh2_02250_lazr_yeahyeah_a8", 0.25];
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "lazar_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, ["flag_dialog_nevermind"], "forever");
  self.var_ba1eee16.var_890ce7a8 = 1;
  self.var_ba1eee16.var_18674cfa = 0;
  self.var_ba1eee16.var_89db7e3d = 1;
  self flag::set("flag_dialog_exhausted");
  self flag::set("flag_speak_while_fidgeting");
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_4d1189ac() {
  self waittill(#"dialog_ready");
  transient = savegame::function_6440b06b(#"transient");
  transient.var_16e4161b = 1;
  level thread savegame::function_7790f03();
}

function function_f856db57() {
  level thread namespace_4ed3ce47::function_4aa573e7();
  level thread namespace_4ed3ce47::function_ef676505();
  level thread namespace_4ed3ce47::function_3c39b015();
}

function function_f50bc4b9() {
  level flag::init("flag_post_armada_complete");
  level flag::init("flag_post_armada_ambient_scene_started");
  level flag::init("flag_post_armada_eavesdropped_timeout");
}

function function_7e4e7cf4(var_d3440450) {
  level namespace_31c67f6d::function_6194f34a("post_armada");
  level thread function_f856db57();
  setlightingstate(1);
  level thread exploder::exploder("exp_fx_post_armada");
  level notify(#"eboard_ready");
  level thread namespace_31c67f6d::function_29279de1("post_armada");
  level thread namespace_31c67f6d::function_b0558ba2("2");
  level thread function_14d4099c();
}

function function_428d9889(var_d3440450, var_50cc0d4f) {
  level flag::wait_till("flag_post_armada_ambient_scene_started");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_14d4099c() {
  level thread function_35e99044();
  level namespace_31c67f6d::function_7fd3a4d8(1);
  level thread scene::play("scene_hub_env_reel_to_reel");
  level thread scene::play("scene_hub_post_armada_dialog_adler", "zone_idle");
  level thread scene::play("scene_hub_post_armada_dialog_park", "zone_idle");
  level thread scene::play("scene_hub_post_armada_dialog_sims", "zone_idle");
}

function function_a5ab8d3f() {
  level.adler.var_ba1eee16.s_tree dialog_tree::function_6cbfa3d2(level.var_9727ef13[0], 0);
  level.adler.var_ba1eee16.s_tree dialog_tree::function_6cbfa3d2(level.var_9727ef13[1], 0);
  level.sims.var_ba1eee16.s_tree dialog_tree::function_6cbfa3d2(level.var_9727ef13[2], 0);
}

function function_882e253f() {
  if(!level flag::get("flag_adler_telephone_scene")) {
    level flag::set("flag_adler_telephone_scene");
    self.end_dialog = 1;
    level flag::clear("flag_player_in_dialog");
    self flag::clear("flag_in_dialog");
    thread function_6a63db65();
  }
}

function function_3a2c335c() {
  if(!level flag::get("flag_adler_telephone_scene")) {
    self.end_dialog = 1;
    level flag::set("flag_adler_telephone_scene");
    level.sims waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
    level flag::clear("flag_player_in_dialog");
    self flag::clear("flag_in_dialog");
    self.var_ba1eee16.var_6edf22e1 = 1;
    thread function_88338e2d();
  }
}

function function_6a63db65() {
  var_8ed19362 = 9;
  self.var_ba1eee16.var_6edf22e1 = 1;
  self flag::set("flag_in_scene");
  level.sims flag::set("flag_in_scene");
  level.sims notify(#"kill_dialog");
  level.sims thread function_c8bbb8b0("scene_hub_ambient_back_room_phone_call_sims", "enter_from_adler", "scene_hub_post_armada_dialog_sims");
  level util::delay(var_8ed19362, undefined, &flag::set, "adler_take_call");
  level.adler waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
  waitframe(1);
  level.adler lookatentity();
  level flag::wait_till("adler_take_call");

  switch (level.var_4d1402c5) {
    case # "player_in_front":
      level.adler scene::play_from_time("scene_hub_post_armada_dialog_adler", "Amb_enter_front", undefined, var_8ed19362, 0, 1);
      break;
    case # "player_in_back":
      level.adler scene::play_from_time("scene_hub_post_armada_dialog_adler", "Amb_enter_behind", undefined, var_8ed19362, 0, 1);
      break;
    case # "player_to_left":
      level.adler scene::play_from_time("scene_hub_post_armada_dialog_adler", "Amb_enter_left", undefined, var_8ed19362, 0, 1);
      break;
    case # "player_to_right":
      level.adler scene::play_from_time("scene_hub_post_armada_dialog_adler", "Amb_enter_right", undefined, var_8ed19362, 0, 1);
      break;
  }

  level util::delay(10.5, undefined, &flag::set, "post_armada_phone_call_happening");
  setDvar(#"hash_6b57212fd4fcdd3a", 225);
  level.adler function_c8bbb8b0("scene_hub_ambient_back_room_phone_call_adler", "main", "scene_hub_post_armada_dialog_adler");
  level flag::clear("post_armada_phone_call_happening");
  self.var_ba1eee16.var_6edf22e1 = 0;
}

function function_88338e2d() {
  self.var_ba1eee16.var_6edf22e1 = 1;
  self flag::set("flag_in_scene");
  thread function_13b55e88();
  waitframe(1);

  switch (level.var_4d1402c5) {
    case # "player_in_front":
      level thread scene::play("scene_hub_post_armada_dialog_sims", "Amb_enter_front");
      break;
    case # "player_to_left":
      level thread scene::play("scene_hub_post_armada_dialog_sims", "Amb_enter_left");
      break;
    case # "player_to_right":
      level thread scene::play("scene_hub_post_armada_dialog_sims", "Amb_enter_right");
      break;
  }

  waitframe(1);
  level.sims waittill(#"hash_1fadbef7ae98fb21");
  self flag::clear("flag_in_scene");
  level thread scene::play("scene_hub_post_armada_dialog_sims", "zone_idle");
  self.var_ba1eee16.var_6edf22e1 = 0;
}

function function_13b55e88() {
  level.adler flag::set("flag_in_scene");
  level.adler notify(#"kill_dialog");
  level.adler notify(#"hash_7d22c6f32f3a3cdb");
  level scene::play("scene_hub_post_armada_dialog_adler", "Amb_enter_front");
  level util::delay(10.5, undefined, &flag::set, "post_armada_phone_call_happening");
  level.adler function_c8bbb8b0("scene_hub_ambient_back_room_phone_call_adler", "main", "scene_hub_post_armada_dialog_adler");
  level flag::clear("post_armada_phone_call_happening");
}

function function_c8bbb8b0(var_6b68fbe2, var_da5872f1, idle_scene) {
  self notify(#"hash_7d22c6f32f3a3cdb");
  self flag::set("flag_in_scene");
  level scene::play(var_6b68fbe2, var_da5872f1);
  self flag::clear("flag_in_scene");
  level thread scene::play(idle_scene, "zone_idle");
}

function function_5ae6f952(var_d3440450) {
  level namespace_31c67f6d::function_6194f34a("post_armada");
  level thread function_f856db57();
  setlightingstate(1);
  level thread exploder::exploder("exp_post_armada_gun_table");
  level thread exploder::exploder("exp_fx_post_armada");
  level thread namespace_31c67f6d::function_29279de1("post_armada");
  level thread namespace_31c67f6d::function_b0558ba2("2");
  level thread function_9ff4321a();
}

function function_d3875afa(var_d3440450, var_50cc0d4f) {
  flag::wait_till("flag_post_armada_complete");
}

function function_9ff4321a() {
  level.adler thread function_e568e0d4();
  level.park thread function_650cdcc9();
  level.sims thread function_5312ebff();
  level namespace_31c67f6d::function_7fd3a4d8(1);
  level.lazar delete();
  var_f3c7854c = getent("lazar_food", "targetname");
  var_f3c7854c delete();
  var_a3eb66a5 = getent("lazar_fork", "targetname");
  var_a3eb66a5 delete();
}