/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_717fd517896b8f30.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_randomize_perks;

autoexec __init__system__() {
  system::register(#"hash_24dadafee669bfbe", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"hash_45ef12aaa7c1d585", &on_begin, &on_end);
}

private on_begin(var_e38c7612, var_2d4ba9d4) {
  self.var_e38c7612 = zm_trial::function_5769f26a(var_e38c7612);
  self.var_2d4ba9d4 = isDefined(var_2d4ba9d4);

  foreach(player in getplayers()) {
    player thread function_e4c3443c(self);
  }
}

private on_end(round_reset) {
  if(!round_reset) {
    var_696c3b4 = [];

    foreach(player in getplayers()) {
      if(!(isDefined(player.var_167bc422) && player.var_167bc422)) {
        if(!isDefined(var_696c3b4)) {
          var_696c3b4 = [];
        } else if(!isarray(var_696c3b4)) {
          var_696c3b4 = array(var_696c3b4);
        }

        var_696c3b4[var_696c3b4.size] = player;
      }

      player.var_167bc422 = undefined;
      player zm_trial_util::function_f3aacffb();
    }

    if(var_696c3b4.size) {
      if(isDefined(self.var_2d4ba9d4) && self.var_2d4ba9d4) {
        var_ded5d2ed = #"hash_192dc062b9c5de31";
      } else {
        var_ded5d2ed = #"hash_26f44827b2b24825";
      }

      zm_trial::fail(var_ded5d2ed, var_696c3b4);
    }
  }
}

is_active(var_34f09024 = 0) {
  challenge = zm_trial::function_a36e8c38(#"hash_45ef12aaa7c1d585");
  return isDefined(challenge);
}

private function_e4c3443c(s_challenge) {
  level endon(#"hash_7646638df88a3656");
  self endon(#"disconnect");

  while(true) {
    if(isDefined(s_challenge.var_2d4ba9d4) && s_challenge.var_2d4ba9d4) {
      if(!(isDefined(self.var_167bc422) && self.var_167bc422) && self.score < s_challenge.var_e38c7612) {
        self zm_trial_util::function_63060af4(1);
        self.var_167bc422 = 1;
      } else if(isDefined(self.var_167bc422) && self.var_167bc422 && self.score >= s_challenge.var_e38c7612) {
        self zm_trial_util::function_63060af4(0);
        self.var_167bc422 = undefined;
      }
    } else if(!(isDefined(self.var_167bc422) && self.var_167bc422) && self.score >= s_challenge.var_e38c7612) {
      self zm_trial_util::function_63060af4(1);
      self.var_167bc422 = 1;
    } else if(isDefined(self.var_167bc422) && self.var_167bc422 && self.score < s_challenge.var_e38c7612) {
      self zm_trial_util::function_63060af4(0);
      self.var_167bc422 = undefined;
    }

    self waittill(#"earned_points", #"spent_points", #"reduced_points");
  }
}