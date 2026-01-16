/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_respin_cycle.csc
**************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;

#namespace zm_bgb_respin_cycle;

autoexec __init__system__() {
  system::register(#"zm_bgb_respin_cycle", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_respin_cycle", "activated");
  clientfield::register("zbarrier", "zm_bgb_respin_cycle", 1, 1, "counter", &function_d1018763, 0, 0);
  level._effect["zm_bgb_respin_cycle"] = "zombie/fx_bgb_respin_cycle_box_flash_zmb";
}

function_d1018763(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(localclientnum, level._effect["zm_bgb_respin_cycle"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
}