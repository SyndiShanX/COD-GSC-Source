/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_newtonian_negation.gsc
********************************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_newtonian_negation;

autoexec __init__system__() {
  system::register(#"zm_bgb_newtonian_negation", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  clientfield::register("world", "newtonian_negation", 1, 1, "int");
  bgb::register(#"zm_bgb_newtonian_negation", "time", 1500, &enable, &disable, &validation);
}

validation() {
  if(isDefined(level.var_6bbb45f9) && level.var_6bbb45f9) {
    return false;
  }

  return true;
}

enable() {
  function_8622e664(1);
  self thread function_4712db36();
}

function_4712db36() {
  self endon(#"hash_429f79a1bdb91087");
  self waittill(#"disconnect");
  thread disable();
}

disable() {
  if(isDefined(self)) {
    self notify(#"hash_429f79a1bdb91087");
  }

  foreach(player in level.players) {
    if(player !== self && player bgb::is_enabled(#"zm_bgb_newtonian_negation")) {
      return;
    }
  }

  function_8622e664(0);
}

function_8622e664(var_b4666218) {
  level clientfield::set("newtonian_negation", var_b4666218);
}