/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_vapor_random.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_vapor_random;

autoexec __init__system__() {
  system::register(#"zm_vapor_random", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "random_vapor_altar_available", 1, 1, "int", &random_vapor_altar_available_fx, 0, 0);
  level._effect[#"random_vapor_altar_available"] = "zombie/fx_powerup_on_green_zmb";
}

random_vapor_altar_available_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isDefined(self.var_476bef54)) {
      self.var_476bef54 = util::playFXOnTag(localclientnum, level._effect[#"random_vapor_altar_available"], self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_476bef54)) {
    stopfx(localclientnum, self.var_476bef54);
  }
}