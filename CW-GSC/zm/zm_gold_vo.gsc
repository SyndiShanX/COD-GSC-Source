/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_gold_vo.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_gold_main_quest;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_gold_vo;

function init() {
  level thread function_303e39b2();
  level thread function_e23b5b30();
  level thread function_543f9e02();
  level thread function_a6c9ee49();
  level thread function_d50a530();
  level callback::on_actor_killed(&on_actor_killed);
  level callback::on_ai_spawned(&on_ai_spawned);
  callback::on_spawned(&on_player_spawn);
  level.var_df07292e = 1.75;
  level.var_b0f33564 = 0;
}

function on_player_spawn() {
  self endoncallback(&function_b5b9317a, #"death");

  while(true) {
    s_waitresult = self waittill(#"hash_360ecb13f668ae0f", #"killstreak_give");

    if(s_waitresult._notify === # "hash_360ecb13f668ae0f") {
      self.var_9c1a4644 = # "cdp_taacom";

      while(true) {
        s_waitresult = self waittill(#"hash_360ecb13f668ae0f", #"killstreak_give", #"killstreak_done");

        if(s_waitresult._notify === # "hash_360ecb13f668ae0f") {
          continue;
        }

        if(s_waitresult._notify === # "killstreak_done") {
          if(is_true(s_waitresult.is_successful)) {
            s_waitresult = self waittilltimeout(20, #"hash_360ecb13f668ae0f", #"killstreak_give");
          }

          if(s_waitresult._notify !== # "hash_360ecb13f668ae0f") {
            break;
          }

          continue;
        }

        break;
      }

      self.var_9c1a4644 = undefined;
    }
  }
}

function function_b5b9317a(str_notify) {
  self.var_9c1a4644 = undefined;
}

function function_43655604() {
  level endon(#"end_game", #"hash_43393d6e22873fc4", #"hash_6bd174fa0d5006f4");

  switch (self.script_int) {
    case 1:
      str_vo_alias = # "hash_39131a3f57995b19";
      var_88c20a4 = # "zone_hillside_road_defend";
      break;
    case 2:
      str_vo_alias = # "hash_39131a3f57995b19";
      var_88c20a4 = # "zone_burnt_forest_defend";
      break;
    case 3:
      str_vo_alias = # "hash_6ee5ba966ea32498";
      var_88c20a4 = # "zone_rocky_slope_defend";
      break;
    default:
      return;
  }

  while(true) {
    var_ebf4f229 = 0;

    foreach(player in function_a1ef346b()) {
      if(player.cached_zone_name === var_88c20a4) {
        var_ebf4f229 = 1;
        break;
      }
    }

    if(var_ebf4f229) {
      break;
    }

    waitframe(1);
  }

  level thread function_78cc0d39(str_vo_alias);
}

function private function_303e39b2() {
  level flag::wait_till("initial_blackscreen_passed");

  switch (randomintrange(0, 3)) {
    case 0:
      level zm_vo::function_7622cb70("fbz_gs_infil_s", 5);
      level.var_85422c0e = "strauss";
      break;
    case 1:
      level zm_vo::function_7622cb70("fbs_gs_infil_c", 5);
      level.var_85422c0e = "carver";
      break;
    case 2:
      level zm_vo::function_7622cb70("fbs_gs_infil_g", 5);
      level.var_85422c0e = "grey";
      break;
  }

  level flag::wait_till(#"intro_scene_done");
  var_d0767760 = array::random([#"hash_6650ecafb63fe3fc", #"hash_6650efafb63fe915", #"hash_6650eeafb63fe762", #"hash_6650e9afb63fdee3", #"hash_6650e8afb63fdd30"]);
  level zm_vo::function_7622cb70(var_d0767760);
  level flag::set("match_start_vo_done");
}

function function_81971b17() {
  level endon(#"hash_2815bf32fb443bc3", #"hash_a88cb65d3952bc4", #"hash_4210e12176f5ee6c");

  while(true) {
    level waittill(#"drain_start");
    level thread zm_vo::function_7622cb70("orda_weakpoint_warning");
  }
}

function function_e23b5b30() {
  level endon(#"end_game", #"pap_quest_completed");
  var_a2bc7f20 = array::random([#"hash_23c8a602a3fb55a9", #"hash_23c8a302a3fb5090", #"hash_23c8a402a3fb5243", #"hash_23c8a902a3fb5ac2", #"hash_23c8aa02a3fb5c75"]);
  var_c08d39 = array::random([#"hash_7e78bbc835a04048", #"hash_7e78bec835a04561", #"hash_7e78bdc835a043ae", #"hash_7e78c0c835a048c7", #"hash_7e78bfc835a04714"]);
  level waittill(#"enable_firebase_zone", #"fasttravel_bought");
  zm_vo::function_3c173d37();

  for(var_dbe98535 = 1; var_dbe98535 <= 5; var_dbe98535++) {
    level scene::stop("aib_t9_zm_vign_cust_frbz_rav_vignette_01_alt_0" + var_dbe98535);
  }

  if(isDefined(level.ravenov)) {
    level.ravenov stopsounds();
  }

  level flag::wait_till(#"enable_firebase_zone");
  level zm_vo::function_7622cb70(var_a2bc7f20, 0.5);
  level thread function_4fd64e07();
  level thread zm_vo::function_7622cb70(var_c08d39, 1);
}

function function_fe881426(str_notify) {
  var_23d9277f = struct::get("trg_pk");
  zm_unitrigger::unregister_unitrigger(var_23d9277f.s_unitrigger);
}

function function_4fd64e07() {
  if(!isDefined(level.var_9a81036b)) {
    return;
  }

  level endoncallback(&function_fe881426, #"pap_quest_completed", #"power_on");
  level.var_9a81036b endoncallback(&function_fe881426, #"death");
  var_23d9277f = struct::get("trg_pk");

  level thread function_51e0aa02(var_23d9277f);

  level.var_9a81036b.var_c92e501c = "interrupt_p4";
  level.var_9a81036b childthread function_20df51b5();
  var_23d9277f zm_unitrigger::function_fac87205(#"hash_8907bffd7ded28e", 100);
  function_e8d13d70(0);
  level.var_9a81036b zm_vo::function_d6f8bbd9(#"hash_79c5ba88b52935a0");
  function_98b949fc();
  wait 5;
  var_23d9277f zm_unitrigger::function_fac87205(#"hash_8907bffd7ded28e", 100);
  function_e8d13d70(0);
  level.var_9a81036b zm_vo::function_d6f8bbd9(#"hash_3f58afeef123e8fb");
  function_98b949fc();
  wait 5;
  var_23d9277f zm_unitrigger::function_fac87205(#"hash_8907bffd7ded28e", 100);
  function_e8d13d70(0);
  level.var_9a81036b zm_vo::function_d6f8bbd9(#"hash_5c08c3611f1462f6");
  function_98b949fc();
  wait 5;
  var_23d9277f zm_unitrigger::function_fac87205(#"hash_8907bffd7ded28e", 100);
  function_e8d13d70(0);
  level.var_9a81036b zm_vo::function_d6f8bbd9(#"hash_476f0f690366f9d1");
  function_98b949fc();
  wait 5;
  var_23d9277f zm_unitrigger::function_fac87205(#"hash_8907bffd7ded28e", 100);
  function_e8d13d70(0);
  level.var_9a81036b zm_vo::function_d6f8bbd9(#"hash_387e898f9aab686c");
  function_98b949fc();
}

function function_e8d13d70(var_9e5d6843 = 1) {
  level endon(#"hash_108827cca89515e");
  level flag::set("peck_interact_vo_playing");
  level scene::stop(level.var_9a81036b.current_scene);

  if(isDefined(level.var_9a81036b.var_c92e501c)) {}

  level thread function_b384d73c(var_9e5d6843);
  wait 0.5;
}

function function_b384d73c(var_9e5d6843 = 1) {
  level endon(#"hash_108827cca89515e");

  if(var_9e5d6843) {
    level scene::play(#"aib_t9_zm_vign_peck_seated_01", "into_convo", level.var_96689f39);
  }

  level thread scene::play(#"aib_t9_zm_vign_peck_seated_01", "convo_loop", level.var_96689f39);
}

function function_20df51b5() {
  self endon(#"death");
  self notify("4691fb805f755f3f");
  self endon("4691fb805f755f3f");

  while(true) {
    s_waitresult = self waittill(#"hash_5db01607981fb0ea", #"hash_5db01507981faf37", #"hash_5db01407981fad84", #"hash_5db01307981fabd1");

    switch (s_waitresult._notify) {
      case # "hash_5db01607981fb0ea":
        self.var_c92e501c = "interrupt_p1";
        break;
      case # "hash_5db01507981faf37":
        self.var_c92e501c = "interrupt_p2";
        break;
      case # "hash_5db01407981fad84":
        self.var_c92e501c = "interrupt_p3";
        break;
      case # "hash_5db01307981fabd1":
      default:
        self.var_c92e501c = "interrupt_p4";
        break;
    }
  }
}

function function_98b949fc() {
  level notify(#"hash_108827cca89515e");
  level flag::clear("ravenov_interact_vo_playing");
  level scene::stop(level.var_9a81036b.current_scene);
  level scene::play(#"aib_t9_zm_vign_peck_seated_01", "out_of_convo", level.var_96689f39);
  level thread scene::play(#"aib_t9_zm_vign_peck_seated_01", "seated_loop", level.var_96689f39);
}

function function_e0948550() {
  level endon(#"hash_7ed70ad1c9bb59e2");
  level flag::set("ravenov_interact_vo_playing");
  level scene::stop(level.ravenov.current_scene);
  level scene::play(#"aib_t9_zm_vign_rav_seated_01", "into_convo", level.var_3ebc9062);
  level thread scene::play(#"aib_t9_zm_vign_rav_seated_01", "convo_loop", level.var_3ebc9062);
}

function function_767d8cf3() {
  level notify(#"hash_7ed70ad1c9bb59e2");
  level flag::clear("ravenov_interact_vo_playing");
  level scene::stop(level.ravenov.current_scene);
  level scene::play(#"aib_t9_zm_vign_rav_seated_01", "out_of_convo", level.var_3ebc9062);
  level thread scene::play(#"aib_t9_zm_vign_rav_seated_01", "seated_loop_1", level.var_3ebc9062);
}

function function_51e0aa02(var_23d9277f) {
  level endon(#"pap_quest_completed");

  while(true) {
    if(getdvarint(#"zm_debug_ee", 0)) {
      circle(var_23d9277f.origin, 8, (0, 1, 0));
      print3d(var_23d9277f.origin, "<dev string:x38>", (0, 1, 0), undefined, 0.15);
    }

    waitframe(1);
  }
}

function function_a99c18d7() {
  self notify("352d8006dd0ad7bb");
  self endon("352d8006dd0ad7bb");
  level endon(#"end_game");

  while(true) {
    var_6450afa8 = 0;

    foreach(player in function_a1ef346b()) {
      if(player.cached_zone_name === # "zone_napalm_strike2") {
        var_6450afa8 = 1;
        break;
      }
    }

    if(var_6450afa8) {
      break;
    }

    waitframe(1);
  }

  level thread zm_vo::function_7622cb70(#"hash_69ccee7bbff01e4");
}

function function_df0c6e4e() {
  self notify("a4b0affc6b06b7c");
  self endon("a4b0affc6b06b7c");

  if(is_true(level.var_95f26c94)) {
    return;
  }

  while(true) {
    var_30f24311 = 0;

    foreach(player in function_a1ef346b()) {
      var_cf81848f = distance2d(player.origin, level.var_9674d6e2.origin);

      if(var_cf81848f <= 450) {
        var_30f24311 = 1;
      }
    }

    if(var_30f24311) {
      break;
    }

    wait 0.5;
  }

  var_bd78bbd3 = 0;

  foreach(control_point in level.var_cc43b632) {
    if(control_point.var_269ad176 === 0) {
      var_bd78bbd3++;
    }
  }

  if(var_bd78bbd3 > 0) {
    level.var_95f26c94 = 1;
    str_vo_alias = array::random([#"hash_3a7acc934b1f6ecb", #"hash_4d40668d67dbdd5c", #"hash_1745cd3e306dda05"]);
    level.ravenov thread zm_vo::function_d6f8bbd9(str_vo_alias);
  }
}

function function_891da57a() {
  if(isDefined(level.var_dda99941) || is_true(level.var_f925c697) || zm_utility::function_c4b020f8()) {
    return;
  }

  switch (self.script_int) {
    case 1:
      level function_78cc0d39(#"hash_3e585004a27f59ce");
      break;
    case 2:
      level function_78cc0d39(#"hash_2b6773cacd83207");
      break;
    case 3:
      level function_78cc0d39(#"hash_628725c2bb754829");
      break;
    default:
      break;
  }

  if(!is_true(level.var_c52dc4d4)) {
    level.var_c52dc4d4 = 1;
    var_d0767760 = array::random([#"hash_a3e6449ce5efb6e", #"hash_a3e6349ce5ef9bb", #"hash_a3e6249ce5ef808", #"hash_a3e6949ce5f03ed", #"hash_a3e6849ce5f023a"]);
    level zm_vo::function_7622cb70(var_d0767760, 1);
  }

  if(level flag::get_all(["captured_control_point1", "captured_control_point2", "captured_control_point3"])) {
    level.var_dda99941 = level.round_number;
    level function_78cc0d39(#"hash_223f84579096023b");
    level thread zm_vo::function_7622cb70(#"hash_399464c7667b8dfb");
    level waittill(#"end_of_round");
    wait 2;
    var_d0767760 = array::random([#"hash_b4026459c0ce1d4", #"hash_b4029459c0ce6ed", #"hash_b4028459c0ce53a", #"hash_b4023459c0cdcbb", #"hash_b4022459c0cdb08"]);
    level zm_vo::function_7622cb70(var_d0767760);
    wait 2;
    level thread function_a99c18d7();
  }
}

function function_65937665() {
  level endon(#"end_game");

  switch (level.var_85422c0e) {
    case # "strauss":
      var_d0767760 = # "hash_359dc466218eb0ff";
      break;
    case # "carver":
      var_d0767760 = # "hash_359dd466218ecc2f";
      break;
    case # "grey":
      var_d0767760 = # "hash_359dd066218ec563";
      break;
    default:
      var_d0767760 = array::random([#"hash_359dc466218eb0ff", #"hash_359dd466218ecc2f", #"hash_359dd066218ec563"]);
      break;
  }

  level zm_vo::function_7622cb70(var_d0767760);

  if(level flag::get(#"hash_5c438c30435a20f3")) {
    return;
  }

  wait 2;
  var_b3b54a4 = array::random([#"hash_4e1dbaa19aa92b93", #"hash_4e1dbba19aa92d46", #"hash_4e1dbca19aa92ef9"]);
  level zm_vo::function_7622cb70(var_b3b54a4);
}

function function_84947a87() {
  level endon(#"end_game");
  b_play = 0;
  var_778b20f3 = "zone_tents";

  while(!b_play) {
    foreach(player in function_a1ef346b()) {
      player_zone = player zm_zonemgr::get_player_zone();

      if(isDefined(player_zone) && player_zone == var_778b20f3) {
        level zm_gold_main_quest::function_b9a3fa11(#"hash_467a44d6adea637a", #"hash_467a34d6adea484a", #"hash_467a30d6adea417e");
        b_play = 1;
      }
    }

    wait 1;
  }
}

function function_f83c329c(var_56f5a757) {
  level endon(#"end_game");

  if(isarray(var_56f5a757)) {
    var_d0767760 = array::random(var_56f5a757);
    level zm_vo::function_7622cb70(var_d0767760);
  }
}

function function_78cc0d39(str_vo_alias, b_wait_if_busy = 1) {
  self zm_vo::function_d6f8bbd9(str_vo_alias, undefined, function_a1ef346b(), b_wait_if_busy);
}

function private function_543f9e02() {
  level endon(#"end_game");

  while(true) {
    s_waitresult = level waittill(#"hash_6d7ff9f9ff07619c");

    switch (level.var_85422c0e) {
      case # "strauss":
        var_b3b54a4 = # "hash_66dcd6a30312f825";
        break;
      case # "carver":
        var_b3b54a4 = # "hash_5b02401fdc592601";
        break;
      case # "grey":
        var_b3b54a4 = # "hash_4c3eea3dc6d2104a";
        break;
      default:
        var_b3b54a4 = # "hash_66dcd6a30312f825";
        break;
    }

    var_a74e1ff8 = 1;

    foreach(player in function_a1ef346b()) {
      if(!is_true(player.var_e0059718)) {
        var_a74e1ff8 = 0;
        s_waitresult.ai_mimic thread function_9a419851(player, var_b3b54a4);
      }
    }

    if(var_a74e1ff8) {
      return;
    }
  }
}

function private function_9a419851(player, var_b3b54a4) {
  self endon(#"death");
  player endon(#"death");

  while(true) {
    if(player util::is_player_looking_at(self getcentroid())) {
      break;
    }

    waitframe(1);
  }

  if(!is_true(player.var_e0059718)) {
    player.var_e0059718 = 1;
    player thread zm_vo::function_7622cb70(var_b3b54a4, 1, 0);
  }
}

function private function_a6c9ee49() {
  level endon(#"end_game");
  level waittill(#"hash_3eb4c19472384f5b");

  switch (level.var_85422c0e) {
    case # "strauss":
      var_4b8c1ea7 = # "hash_4271010934d7ff16";
      break;
    case # "carver":
      var_4b8c1ea7 = # "hash_7e3a0e811e6347d2";
      break;
    case # "grey":
      var_4b8c1ea7 = # "hash_5688a462847552b9";
      break;
    default:
      var_4b8c1ea7 = # "hash_4271010934d7ff16";
      break;
  }

  var_ca46ac46 = # "hash_33a906eca69357b6";
  level zm_vo::function_7622cb70(var_4b8c1ea7);
  level thread zm_vo::function_7622cb70(var_ca46ac46);
}

function private on_actor_killed(params) {
  if(self.archetype === # "mimic" && self.team === level.zombie_team) {
    switch (level.var_85422c0e) {
      case # "strauss":
        var_b3b54a4 = # "hash_74270a8581b4849a";
        break;
      case # "carver":
        var_b3b54a4 = # "hash_12a4b90943442c86";
        break;
      case # "grey":
        var_b3b54a4 = # "hash_3f74c72c2033c1c5";
        break;
      default:
        var_b3b54a4 = # "hash_74270a8581b4849a";
        break;
    }

    level thread zm_vo::function_7622cb70(var_b3b54a4, 1.25, 0);
    level callback::remove_on_actor_killed(&on_actor_killed);
  }
}

function on_ai_spawned() {
  self endon(#"death");
  level endon(#"end_game");

  if(self.archetype === # "raz" && self.team === level.zombie_team) {
    switch (level.var_85422c0e) {
      case # "strauss":
        var_b3b54a4 = # "hash_62001c8ac133172a";
        break;
      case # "carver":
        var_b3b54a4 = # "hash_6cc8aa06ce7cc5d6";
        break;
      case # "grey":
        var_b3b54a4 = # "hash_32dd8255ea06555";
        break;
      default:
        var_b3b54a4 = # "hash_62001c8ac133172a";
        break;
    }

    var_3a0dcf4c = 1;

    foreach(player in function_a1ef346b()) {
      if(!is_true(player.var_138d17d5)) {
        var_3a0dcf4c = 0;
        self thread function_886e25dc(player, var_b3b54a4);
      }
    }

    if(var_3a0dcf4c) {
      level callback::remove_on_ai_spawned(&on_ai_spawned);
    }
  }
}

function function_886e25dc(player, var_b3b54a4) {
  self endon(#"death");
  player endon(#"death", #"hash_1a917d3ddd4fab73");

  while(true) {
    if(player util::is_player_looking_at(self getcentroid())) {
      break;
    }

    waitframe(1);
  }

  if(!is_true(player.var_138d17d5)) {
    player.var_138d17d5 = 1;
    player thread zm_vo::function_7622cb70(var_b3b54a4);
  }
}

function function_421f7a59() {
  level zm_vo::function_7622cb70(#"hash_172f226477a8163");
  wait 0.75;

  switch (level.var_85422c0e) {
    case # "strauss":
      var_b3b54a4 = array::random([#"hash_4b1d5badb2764a84", #"hash_4b1d5eadb2764f9d", #"hash_4b1d5dadb2764dea"]);
      break;
    case # "carver":
      var_b3b54a4 = array::random([#"hash_4b53dbadb2a4b374", #"hash_4b53deadb2a4b88d", #"hash_4b53ddadb2a4b6da"]);
      break;
    case # "grey":
      var_b3b54a4 = array::random([#"hash_4b4643adb29926d0", #"hash_4b4646adb2992be9", #"hash_4b4645adb2992a36"]);
      break;
    default:
      var_b3b54a4 = array::random([#"hash_4b1d5badb2764a84", #"hash_4b1d5eadb2764f9d", #"hash_4b1d5dadb2764dea"]);
      break;
  }

  level thread zm_vo::function_7622cb70(var_b3b54a4);
}

function function_f314c888() {
  switch (level.var_85422c0e) {
    case # "strauss":
      var_b3b54a4 = # "hash_e353adc2878fc33";
      break;
    case # "carver":
      var_b3b54a4 = # "hash_e354adc28791763";
      break;
    case # "grey":
      var_b3b54a4 = # "hash_e354edc28791e2f";
      break;
    default:
      var_b3b54a4 = # "hash_e353adc2878fc33";
      break;
  }

  level zm_vo::function_7622cb70(var_b3b54a4);
  level thread function_1de1e6b4();
}

function function_1de1e6b4() {
  level endon(#"end_game");
  waitframe(1);
  level.var_9674d6e2 zm_unitrigger::unregister_unitrigger(level.var_9674d6e2.s_unitrigger);
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_1cebc7a22041890");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_1cebd7a22041a43");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_22a8a913a347b9af");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_22a8a813a347b7fc");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
  level flag::wait_till_clear(#"hash_7b872eebd26623c5");
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_7a0bc62112b2e716");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_20e45efab9284bd5");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_20e45dfab9284a22");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_6427ba6c6908d42c");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_6427bb6c6908d5df");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_1cb9b8ab0038e9b");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_1cb9a8ab0038ce8");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_72e6e8c4c447af2");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_72e6f8c4c447ca5");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_7d020bf3da1a57f1");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_7d020af3da1a563e");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_7a28a080860d8fb8");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_7a28a180860d916b");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
  level.var_9674d6e2 zm_unitrigger::function_fac87205(&function_c732de82, 64);
  level flag::set(#"ravenov_interact_vo_playing");
  level.ravenov zm_vo::function_d6f8bbd9(#"hash_39fcf62269d363ac");
  wait 0.5;
  level flag::clear(#"ravenov_interact_vo_playing");
  wait 10;
}

function function_c732de82(e_player) {
  if(is_true(level.ravenov.isspeaking)) {
    return false;
  }

  self sethintstring(#"hash_78573012d7272fae");
  return true;
}

function function_68c6149e() {
  switch (level.var_85422c0e) {
    case # "strauss":
      var_b3b54a4 = array::random([#"hash_1b5b23733cdc4178", #"hash_1b5b26733cdc4691", #"hash_1b5b25733cdc44de"]);
      break;
    case # "carver":
      var_b3b54a4 = array::random([#"hash_1b91a3733d0aaa68", #"hash_1b91a6733d0aaf81", #"hash_1b91a5733d0aadce"]);
      break;
    case # "grey":
      var_b3b54a4 = array::random([#"hash_1b9f1b733d1600ac", #"hash_1b9f1e733d1605c5", #"hash_1b9f1d733d160412"]);
      break;
    default:
      var_b3b54a4 = array::random([#"hash_1b5b23733cdc4178", #"hash_1b5b26733cdc4691", #"hash_1b5b25733cdc44de"]);
      break;
  }

  level thread zm_vo::function_7622cb70(var_b3b54a4);
}

function function_a71f7322() {
  switch (level.var_85422c0e) {
    case # "strauss":
      var_b3b54a4 = # "hash_4a84679c88de5a62";
      break;
    case # "carver":
      var_b3b54a4 = # "hash_4a84579c88de3f32";
      break;
    case # "grey":
      var_b3b54a4 = # "hash_4a84539c88de3866";
      break;
    default:
      var_b3b54a4 = # "hash_4a84679c88de5a62";
      break;
  }

  level thread zm_vo::function_7622cb70(var_b3b54a4);
}

function private function_d50a530() {
  level flag::wait_till_all([#"hash_1dc3d47b1604d916", #"hash_2651a51980ef57ee"]);

  switch (level.var_85422c0e) {
    case # "strauss":
      var_b3b54a4 = # "hash_4b8ddfd962701e2e";
      break;
    case # "carver":
      var_b3b54a4 = # "hash_4b8dcfd9627002fe";
      break;
    case # "grey":
      var_b3b54a4 = # "hash_4b8dd3d9627009ca";
      break;
    default:
      var_b3b54a4 = # "hash_4b8ddfd962701e2e";
      break;
  }

  level thread zm_vo::function_7622cb70(var_b3b54a4);
}

function function_7930927d() {
  switch (level.var_85422c0e) {
    case # "strauss":
      var_b3b54a4 = # "hash_7c4c4f063a9db5b8";
      break;
    case # "carver":
      var_b3b54a4 = # "hash_7c4c5f063a9dd0e8";
      break;
    case # "grey":
      var_b3b54a4 = # "hash_7c4c63063a9dd7b4";
      break;
    default:
      var_b3b54a4 = # "hash_7c4c4f063a9db5b8";
      break;
  }

  level thread zm_vo::function_7622cb70(var_b3b54a4);
}

function function_3c870e42() {
  level function_78cc0d39(#"hash_3329c0be8481aad4");
  level thread zm_vo::function_7622cb70(#"hash_60628311a3a18ac4");
}

function function_8cc97115() {
  switch (level.var_85422c0e) {
    case # "strauss":
      var_3e86fd2e = # "hash_6dc5d7d4efbfbfa9";
      break;
    case # "carver":
      var_3e86fd2e = # "hash_6dfc97d4efee9559";
      break;
    case # "grey":
      var_3e86fd2e = # "hash_6dee97d4efe257fd";
      break;
    default:
      var_3e86fd2e = # "hash_6dc5d7d4efbfbfa9";
      break;
  }

  if(level.var_b0f33564 < 5) {
    level zm_vo::function_7622cb70(var_3e86fd2e + level.var_b0f33564);
    level.var_b0f33564++;
  }
}

function function_ed7aab5b(var_75fb47b3, var_5566fac5, n_cooldown = 120) {
  if(!self flag::get(var_5566fac5)) {
    self flag::set(var_5566fac5);
    self thread zm_vo::function_7622cb70(var_75fb47b3);

    if(isPlayer(self)) {
      var_318863c = "disconnect";
    } else {
      var_318863c = "end_game";
    }

    self util::delay(n_cooldown, var_318863c, &flag::clear, var_5566fac5);
  }
}