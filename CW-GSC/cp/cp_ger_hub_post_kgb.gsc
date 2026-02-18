/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_ger_hub_post_kgb.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_19971192452f4209;
#using script_4052585f7ae90f3a;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
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
#using scripts\cp_common\util;
#namespace hub_post_kgb;

function starting(var_d3440450) {}

function main(var_d3440450, var_50cc0d4f) {
  level namespace_31c67f6d::function_6194f34a("post_kgb", 1);
  level thread function_53ea6532();
  setlightingstate(3);
  level thread function_9a76d250();
  level thread namespace_31c67f6d::function_15231086("eboard_ready");
  var_a2279767 = getent("map_table", "targetname");
  var_a2279767 hide();
  var_475021af = getent("hub_mdl_car_01_clip", "targetname");
  var_475021af hide();
  s_player_start = struct::get("s_post_kgb_player_start", "targetname");
  level.player setorigin(s_player_start.origin);
  level.player setplayerangles(s_player_start.angles);
  level thread namespace_31c67f6d::function_29279de1("post_kgb");
  level thread namespace_31c67f6d::function_b0558ba2("6");
  level thread function_ae2b72b9();
  level thread namespace_31c67f6d::function_7fd3a4d8(undefined, undefined, 3, 1);
  level waittill(#"start_ambient");

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

function function_9a76d250() {
  level.woods thread function_2ed9170();
  level.hudson thread function_c350b5c7();
}

function function_2ed9170() {
  self thread function_22967a29();
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = [["vox_cp_sh6_06200_wood_lookaliveitsadl_25", 0.5, 1], ["vox_cp_sh6_06200_masn_agentbell_bc", 0, 0.5, level.mason]];
  self.var_ba1eee16.var_c5c9acca[1] = [["vox_cp_sh6_06200_masn_holdupdingusish_50", 1, 0.5, level.mason], ["vox_cp_sh6_06200_wood_laughwhatsupbel_93"]];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh6_06200_wood_yeah_c6", 0.5, 1];
  self.var_ba1eee16.var_c5c9acca[3] = ["vox_cp_sh6_06200_masn_agentbell_bc", 1, 1, level.mason];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh6_06200_wood_ithinkweredoneh_0d", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh6_06200_masn_goonovertothebo_14", 0.5, level.mason];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&function_d762b8f7, &function_937dad6a, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_18cd8df4f7d56ea5", undefined, "dt_1a", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_18cd8af4f7d5698c", undefined, "dt_1b", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_7aacdc411fa2adda", undefined, "dt_1b2", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_7aacdd411fa2af8d", undefined, "dt_1b3", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_18cd8bf4f7d56b3f", undefined, "dt_1c", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_7aafde411fa4e717", undefined, "dt_1c2", "waiting_idle", 1, undefined, undefined, &function_d67f91df);
  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "woods_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("woods_convo_exit", #"hash_7d30c89656f6b000", undefined, undefined, undefined, 1, undefined, "forever");
  level.var_d9ba130a = dialog_tree::new_tree(undefined, undefined, 1, 1, self.var_ba1eee16.var_f2190d3d);
  level.var_d9ba130a dialog_tree::add_option(#"hash_7aafdd411fa4e564", undefined, "dt_1c3", "waiting_idle", 1, undefined, undefined, &function_854a536d);
  level.var_d9ba130a dialog_tree::add_option(#"hash_7aafdc411fa4e3b1", undefined, "dt_1c4", "waiting_idle", 1, undefined, undefined, &function_854a536d);
  self.var_ba1eee16.str_location = "van";
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = 1;
  self.var_ba1eee16.var_142355f9 = array(240, 650);
  self.var_ba1eee16.var_9b7161e6 = array(240, 650);
  self.var_ba1eee16.var_e9797a7f = array(240, 650);
  self.var_ba1eee16.var_cbdef43f = array(240, 650);
  self.var_ba1eee16.var_89db7e3d = 1;
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_22967a29() {
  self waittill(#"dialog_ready");
  transient = savegame::function_6440b06b(#"transient");
  transient.var_16e4161b = 1;
  level thread savegame::function_7790f03();
}

function function_d762b8f7() {
  if(level flag::get("woods_sub_tree")) {
    level flag::clear("woods_sub_tree");
    return;
  }

  if(!level flag::get("alder_passing_by_woods")) {
    level.adler ghost();
    level.park ghost();
  }

  level.woods namespace_31c67f6d::function_282ccb63();
}

function function_937dad6a() {
  if(!level flag::get("woods_sub_tree")) {
    level flag::clear("alder_passing_by_woods");
    level.adler show();
    level.park show();
    level.woods namespace_31c67f6d::function_7b9b6d21();
  }
}

function function_d67f91df() {
  level.woods waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
  level flag::set("woods_sub_tree");
  level dialog_tree::function_21780fc5(level.var_d9ba130a, self.var_ba1eee16.var_30dc5656);
  level.var_d9ba130a thread dialog_tree::run(level.woods);
}

function function_854a536d() {
  level.woods waittill(#"hash_48ace2900075b6e8", #"hash_12324459eb2bc76d");
  level.woods.var_ba1eee16.s_tree thread dialog_tree::run(level.woods);
}

function function_c350b5c7() {
  self.var_ba1eee16 = spawnStruct();
  self.var_ba1eee16.var_c5c9acca[0] = ["vox_cp_sh6_06300_hdsn_makeitquickimbu_c8", 2.5];
  self.var_ba1eee16.var_c5c9acca[1] = ["vox_cp_sh6_06300_hdsn_whatisit_cc", 3];
  self.var_ba1eee16.var_c5c9acca[2] = ["vox_cp_sh6_06300_hdsn_agentbellprocee_ea", 2];
  self.var_ba1eee16.var_962cbf19[0] = ["vox_cp_sh6_06300_hdsn_wrapupanythinge_65", 0.5];
  self.var_ba1eee16.var_962cbf19[1] = ["vox_cp_sh6_06300_hdsn_readyupagent_83", 0.5];
  self.var_ba1eee16.var_f2190d3d = "scene_hub_" + (isDefined(level.var_f5552371) ? level.var_f5552371 : "") + "_dialog_" + self.animname;
  self.var_ba1eee16.s_tree = dialog_tree::new_tree(&namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 1, 1, self.var_ba1eee16.var_f2190d3d);
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_20f85c1191383760", undefined, "dt_1a", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_3e3bc3d9c2860056", undefined, "dt_1a2", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_20f85f1191383c79", undefined, "dt_1b", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::add_option(#"hash_20f85e1191383ac6", undefined, "dt_1c", "waiting_idle");
  self.var_ba1eee16.s_tree dialog_tree::function_9e36808(#"hash_3e42cbd9c28c2c9c", undefined, "dt_1c2", "waiting_idle");
  self.var_ba1eee16.var_cb67e512 = self.var_ba1eee16.s_tree dialog_tree::function_7fe78745(1, "hudson_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever");
  self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87("hudson_convo_exit", #"hash_52d822a2a38b7e4d", undefined, undefined, undefined, 1, undefined, "forever", &function_82af6494);
  self.var_fc9bb816 = ["vox_cp_sh6_06300_hdsn_carryon_2c", "vox_cp_sh6_06300_hdsn_goodluck_86"];
  self flag::set("flag_hudson_dialog_option1_unlocked");
  self.var_ba1eee16.str_location = "tv_table";
  self.var_ba1eee16.n_fov = undefined;
  self.var_ba1eee16.var_e1eebb0b = undefined;
  self.var_ba1eee16.var_142355f9 = undefined;
  self.var_ba1eee16.var_9b7161e6 = undefined;
  self.var_ba1eee16.var_e9797a7f = undefined;
  self.var_ba1eee16.var_cbdef43f = undefined;
  self.var_ba1eee16.var_89db7e3d = 1;
  self thread namespace_31c67f6d::function_7b0516d7();
}

function function_82af6494() {
  if(!isDefined(self.var_35893d9c)) {
    self.var_35893d9c = -1;
  }

  if(self.var_35893d9c == -1) {
    level scene::play(self.var_ba1eee16.var_f2190d3d, "dt_first_exit");
  } else {
    self thread dialogue::queue(self.var_fc9bb816[self.var_35893d9c]);
  }

  self.var_35893d9c++;

  if(self.var_35893d9c >= self.var_fc9bb816.size) {
    self.var_35893d9c = 0;
  }
}

function function_77e1542b() {
  var_5179bfff = "vox_cp_sh6_06300_hdsn_youavailable_3d";
  var_a57eb785 = "vox_cp_sh6_06300_hdsn_goon_e1";
  var_4cd38ab9 = ["vox_cp_sh6_06300_hdsn_yeah_b5", "vox_cp_sh6_06300_hdsn_goon_e1", "vox_cp_sh6_06300_hdsn_ofcourseitscuba_c6", "vox_cp_sh6_06300_hdsn_uhhuh_50", "vox_cp_sh6_06300_hdsn_youcanaskadlert_f5", "vox_cp_sh6_06300_hdsn_woodsyeah_2d", "vox_cp_sh6_06300_hdsn_mmm_55"];
  self dialogue::queue(var_5179bfff);
  wait 5;
  cur_line = 0;

  while(true) {
    if(!self flag::get("flag_in_dialog")) {
      if(!self flag::get("looking_away_from_phone")) {
        self dialogue::queue(var_4cd38ab9[cur_line]);
        cur_line++;

        if(cur_line >= var_4cd38ab9.size) {
          cur_line = 0;
        }
      }
    } else {
      self flag::wait_till_clear("flag_in_dialog");
      self dialogue::queue(var_a57eb785);
    }

    wait randomfloatrange(10, 25);
  }
}

function function_53ea6532() {
  level thread namespace_4ed3ce47::function_46f173b2();
  level thread namespace_4ed3ce47::function_2d62fc6f();
  level thread namespace_4ed3ce47::function_91962847();
}

function function_f50bc4b9() {
  flag::init("flag_post_kgb_complete");
  level thread exploder::exploder("exp_post_kgb_briefing");
}

function function_b58272a1(var_d3440450) {
  level namespace_31c67f6d::function_6194f34a("post_kgb");
  level thread function_53ea6532();
  setlightingstate(3);
  var_a2279767 = getent("map_table", "targetname");
  var_a2279767 hide();
  var_475021af = getent("hub_mdl_car_01_clip", "targetname");
  var_475021af hide();
  level notify(#"eboard_ready");
  level thread function_d51cce5a();
  level thread namespace_31c67f6d::function_29279de1("post_kgb");
  level thread namespace_31c67f6d::function_b0558ba2("6");
}

function function_d51cce5a() {
  level thread function_9a76d250();
  level namespace_31c67f6d::function_7fd3a4d8(1, undefined, 1);
  level thread scene::play("scene_hub_post_kgb_dialog_woods", "zone_idle");
  phone = getent("cellphone", "targetname");
  level thread scene::play("scene_hub_post_kgb_dialog_hudson", "zone_idle", [phone]);
  level.hudson util::delay_notify(0.5, "dialog_ready");
}

function function_223f05aa(var_d3440450, var_50cc0d4f) {
  level.hudson waittill(#"dialog_ready");
  level.hudson thread function_77e1542b();
  flag::wait_till("flag_post_kgb_complete");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }

  if(isDefined(level.var_d7d201ba) && isDefined(level.var_28c22d88)) {
    level.player flag::set(level.var_d7d201ba);
  }
}