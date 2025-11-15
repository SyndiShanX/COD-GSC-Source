/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_talkin_bout_regeneration.gsc
**************************************************************/

#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_talkin_bout_regeneration;

autoexec __init__system__() {
  system::register(#"zm_bgb_talkin_bout_regeneration", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_talkin_bout_regeneration", "time", 240, &enable, &disable, undefined, undefined);
  bgb::function_e1f37ce7(#"zm_bgb_talkin_bout_regeneration");
}

enable() {
  self thread function_c0c85fe();
}

disable() {
  self notify(#"hash_fcaa137035db4e");
  val::reset(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay");
}

function_c0c85fe() {
  self endon(#"death", #"hash_fcaa137035db4e");
  var_47624402 = 0;

  while(true) {
    var_197c85d1 = self getvelocity();
    var_9b7f7d9b = length(var_197c85d1);

    if(var_9b7f7d9b > 0 && !self laststand::player_is_in_laststand() && (var_197c85d1[0] != 0 || var_197c85d1[1] != 0)) {
      if(!var_47624402) {
        var_47624402 = 1;
        self val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 1);
      }
    } else if(var_47624402) {
      var_47624402 = 0;
      self val::reset(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay");
    }

    waitframe(1);
  }
}