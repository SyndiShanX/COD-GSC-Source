/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_aftertaste.gsc
************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_stats;

#namespace zm_bgb_aftertaste;

autoexec __init__system__() {
  system::register(#"zm_bgb_aftertaste", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_aftertaste", "event", &event, undefined, undefined, undefined);
  bgb::register_lost_perk_override(#"zm_bgb_aftertaste", &lost_perk_override, 0);
  bgb::function_1fee6b3(#"zm_bgb_aftertaste", 3);
}

lost_perk_override(perk, var_a83ac70f = undefined, var_6c1b825d = undefined) {
  if(isDefined(var_a83ac70f) && isDefined(var_6c1b825d) && var_a83ac70f == var_6c1b825d) {
    var_a83ac70f zm_stats::increment_challenge_stat(#"hash_19d6a97f1553f96f");
    return 1;
  }

  return 0;
}

event() {
  self endon(#"disconnect", #"bled_out", #"bgb_update");
  self thread bgb::run_timer(300);
  self waittilltimeout(300, #"player_revived");
  self bgb::do_one_shot_use(1);
}