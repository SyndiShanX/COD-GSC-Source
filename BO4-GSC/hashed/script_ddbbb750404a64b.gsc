/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_ddbbb750404a64b.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace namespace_287e05a2;

autoexec __init__system__() {
  system::register(#"hash_73d9e3978f860555", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"round_ending_zone", &on_begin, &on_end);
}

private on_begin(str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9, var_a7a5a6ef, var_11ec7b7b, var_cac66d30) {
  if(str_zone1 == #"hash_13aa327bb61b59de") {
    if(str_zone2 == #"zm_red_dark_side") {
      level.var_da1e5199 = array(#"zone_river_upper", #"zone_river_lower", #"zone_serpent_pass_upper", #"zone_serpent_pass_center", #"zone_serpent_pass_lower", #"zone_serpent_pass_bridge", #"zone_drakaina_arena", #"zone_cliff_tombs_upper", #"zone_cliff_tombs_forge", #"zone_cliff_tombs_center", #"zone_cliff_tombs_lower", #"zone_cliff_tombs_bridge", #"zone_ww_quest_death", #"zone_ww_quest_air");
    }
  } else {
    level.var_da1e5199 = array(str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9, var_a7a5a6ef, var_11ec7b7b, var_cac66d30);
    arrayremovevalue(level.var_da1e5199, undefined);
  }

  foreach(player in getplayers()) {
    player thread function_c465c67f();
  }
}

private on_end(round_reset) {
  if(!round_reset) {
    var_696c3b4 = [];

    foreach(player in getplayers()) {
      if(!player.b_in_zone) {
        if(!isDefined(var_696c3b4)) {
          var_696c3b4 = [];
        } else if(!isarray(var_696c3b4)) {
          var_696c3b4 = array(var_696c3b4);
        }

        var_696c3b4[var_696c3b4.size] = player;
      }
    }

    if(var_696c3b4.size) {
      zm_trial::fail(#"hash_10a895033b20c705", var_696c3b4);
    }
  }

  foreach(player in getplayers()) {
    player.b_in_zone = undefined;
    player zm_trial_util::function_f3aacffb();
  }

  level.var_da1e5199 = undefined;
}

private function_c465c67f() {
  self endon(#"disconnect");
  level endon(#"hash_7646638df88a3656");
  self.b_in_zone = 0;
  self zm_trial_util::function_63060af4(0);

  while(true) {
    if(!self.b_in_zone && self zm_zonemgr::is_player_in_zone(level.var_da1e5199)) {
      self zm_trial_util::function_63060af4(1);
      self.b_in_zone = 1;
    } else if(self.b_in_zone && !self zm_zonemgr::is_player_in_zone(level.var_da1e5199)) {
      self zm_trial_util::function_63060af4(0);
      self.b_in_zone = 0;
    }

    waitframe(1);
  }
}