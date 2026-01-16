/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_mansion_billiards.gsc
***********************************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\bgbs\zm_bgb_newtonian_negation;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_bgb_pack;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_mansion_billiards;

autoexec __init__system__() {
  system::register(#"zm_trial_mansion_billiards", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"mansion_billiards", &on_begin, &on_end);
}

private on_begin() {
  level thread function_b7bc0616();
}

private on_end(round_reset) {
  zm_trial_util::function_f3dbeda7();

  if(!round_reset && !level flag::get(#"hash_4207012c64662b4d")) {
    zm_trial::fail(#"hash_2c061f4e3509c0f4");
  }

  enable_newtonian_negation();
}

private function_b7bc0616() {
  level endon(#"hash_7646638df88a3656", #"end_game");
  zm_trial_util::function_7d32b7d0(0);
  function_f5ad51bd();
  level flag::wait_till(#"hash_4207012c64662b4d");
  waitframe(1);
  zm_trial_util::function_7d32b7d0(1);
  enable_newtonian_negation();
}

private function_f5ad51bd() {
  foreach(player in getplayers()) {
    if(player bgb::is_enabled(#"zm_bgb_newtonian_negation")) {
      player.var_30ee603f = 1;
      player.var_4b0fb2fb = 1;
    }

    player bgb_pack::function_59004002(#"zm_bgb_newtonian_negation", 1);
  }

  level.var_6bbb45f9 = 1;
  zm_bgb_newtonian_negation::function_8622e664(0);
}

private enable_newtonian_negation() {
  foreach(player in getplayers()) {
    if(isDefined(player.var_30ee603f) && player.var_30ee603f) {
      zm_bgb_newtonian_negation::function_8622e664(1);
      player.var_30ee603f = undefined;
      player.var_4b0fb2fb = undefined;
    }

    player bgb_pack::function_59004002(#"zm_bgb_newtonian_negation", 0);
  }

  level.var_6bbb45f9 = undefined;
}