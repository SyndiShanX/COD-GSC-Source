/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_fishing.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace wz_fishing;

autoexec __init__system__() {
  system::register(#"wz_fishing", &__init__, undefined, undefined);
}

autoexec __init() {}

__init__() {
  clientfield::register("scriptmover", "fishing_splash", 21000, 1, "int", &fishing_splash, 0, 0);
  clientfield::register("scriptmover", "fishing_buoy_splash", 21000, 1, "int", &fishing_splash, 0, 0);
  clientfield::register("toplayer", "player_fishing", 21000, 1, "int", &function_c06a890a, 0, 0);
}

function_c06a890a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), 0);
    return;
  }

  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), 1);
}

fishing_buoy_splash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    if(isDefined(self.var_85dbab0)) {
      stopfx(localclientnum, self.var_85dbab0);
    }

    return;
  }

  self.var_85dbab0 = playFX(localclientnum, "player/fx_plyr_water_splash_sm", self.origin);
  playSound(localclientnum, #"hash_7ff007fca6ac13d7", self.origin);
}

fishing_splash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    if(isDefined(self.var_85dbab0)) {
      stopfx(localclientnum, self.var_85dbab0);
    }

    return;
  }

  self.var_85dbab0 = playFX(localclientnum, "impacts/fx8_bul_impact_water_sm", self.origin);
  playSound(localclientnum, #"hash_4b98472de9aeb14b", self.origin);
}