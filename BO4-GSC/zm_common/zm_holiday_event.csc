/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_holiday_event.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_holiday_event;

autoexec __init__system__() {
  system::register(#"zm_holiday_event", &__init__, undefined, undefined);
}

__init__() {
  if(getdvarint(#"zm_holiday_event", 0)) {
    clientfield::register("actor", "" + #"hash_59e8c30d5e28dad3", 14000, 1, "int", &function_b245ef9e, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_d260ef4191c5b3d", 14000, 1, "int", &function_9a20c93e, 0, 0);
  }
}

function_b245ef9e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_green", #"wz/fx8_zombie_eye_glow_green_wz");
    return;
  }

  self zm_utility::function_704f7c0e(localclientnum);
}

function_9a20c93e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_c9d177e8 = util::playFXOnTag(localclientnum, #"hash_286e0d228779181", self, "tag_origin");

    if(!isDefined(self.var_2a145797)) {
      self playSound(localclientnum, #"zmb_sq_souls_release");
      self.var_2a145797 = self playLoopSound(#"zmb_sq_souls_lp");
    }

    return;
  }

  if(isDefined(self.var_c9d177e8)) {
    killfx(localclientnum, self.var_c9d177e8);
    self.var_c9d177e8 = undefined;
  }

  if(isDefined(self.var_2a145797)) {
    self stoploopsound(self.var_2a145797);
    self.var_2a145797 = undefined;
  }
}