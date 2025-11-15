/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_buoy_stash.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace wz_buoy_stash;

autoexec __init__system__() {
  system::register(#"wz_buoy_stash", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "buoy_light_fx_changed", 1, 2, "int", &function_a99ec0bc, 0, 0);
}

function_a99ec0bc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.fx_id)) {
    stopfx(0, self.fx_id);
  }

  switch (newval) {
    case 1:
      self.fx_id = util::playFXOnTag(localclientnum, #"hash_212c7fc08851dc9", self, "tag_light_buoy03_jnt");
      break;
    case 2:
      self.fx_id = util::playFXOnTag(localclientnum, #"hash_77d0b79144a0734d", self, "tag_light_buoy03_jnt");
      break;
  }
}