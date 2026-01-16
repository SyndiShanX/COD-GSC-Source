/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_reset_points.gsc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_reset_points;

autoexec __init__system__() {
  system::register(#"zm_trial_reset_points", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"reset_points", &on_begin, &on_end);
}

private on_begin(var_899c6d17) {
  if(isDefined(var_899c6d17)) {
    var_899c6d17 = zm_trial::function_5769f26a(var_899c6d17);
  } else {
    var_899c6d17 = 0;
  }

  wait 6;

  foreach(player in getplayers()) {
    player thread reset_points(var_899c6d17);
  }
}

private reset_points(var_899c6d17) {
  if(self bgb::is_enabled(#"zm_bgb_shopping_free")) {
    self bgb::do_one_shot_use();
    self playsoundtoplayer(#"zmb_bgb_shoppingfree_coinreturn", self);
    return;
  }

  self.score = var_899c6d17;
  self.pers[#"score"] = var_899c6d17;
}

private on_end(round_reset) {}