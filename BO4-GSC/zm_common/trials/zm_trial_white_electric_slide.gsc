/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_white_electric_slide.gsc
**************************************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace zm_trial_white_electric_slide;

autoexec __init__system__() {
  system::register(#"zm_trial_white_electric_slide", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"electric_slide", &on_begin, &on_end);
}

private on_begin(var_b7088c5b, var_5bf91a8, var_d9f1b8f9, var_fc678144) {
  switch (getplayers().size) {
    case 1:
      level.var_795dfe46 = zm_trial::function_5769f26a(var_b7088c5b);
      break;
    case 2:
      level.var_795dfe46 = zm_trial::function_5769f26a(var_5bf91a8);
      break;
    case 3:
      level.var_795dfe46 = zm_trial::function_5769f26a(var_d9f1b8f9);
      break;
    case 4:
      level.var_795dfe46 = zm_trial::function_5769f26a(var_fc678144);
      break;
  }

  foreach(player in getplayers()) {
    player.var_795dfe46 = 0;
    player zm_trial_util::function_c2cd0cba(level.var_795dfe46);
    player zm_trial_util::function_2190356a(player.var_795dfe46);
    player thread function_729edb5f();
  }
}

private on_end(round_reset) {
  if(!round_reset) {
    var_696c3b4 = [];

    foreach(player in getplayers()) {
      if(player.var_795dfe46 < level.var_795dfe46) {
        if(!isDefined(var_696c3b4)) {
          var_696c3b4 = [];
        } else if(!isarray(var_696c3b4)) {
          var_696c3b4 = array(var_696c3b4);
        }

        var_696c3b4[var_696c3b4.size] = player;
      }
    }

    if(var_696c3b4.size) {
      zm_trial::fail(#"hash_5a354b422e429f71", var_696c3b4);
    }
  }

  foreach(player in getplayers()) {
    player zm_trial_util::function_f3aacffb();
  }

  level.var_795dfe46 = undefined;
}

private function_729edb5f() {
  level endon(#"hash_7646638df88a3656");

  while(self.var_795dfe46 < level.var_795dfe46) {
    self waittill(#"hash_15541419dbbe7e1a");
    self.var_795dfe46++;

    if(self.var_795dfe46 < level.var_795dfe46) {
      self zm_trial_util::function_c2cd0cba(level.var_795dfe46);
      self zm_trial_util::function_2190356a(self.var_795dfe46);
    }

    if(self.var_795dfe46 == level.var_795dfe46) {
      self zm_trial_util::function_63060af4(1);
    }
  }
}