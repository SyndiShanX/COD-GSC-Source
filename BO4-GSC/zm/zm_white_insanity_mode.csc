/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_insanity_mode.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;
#namespace zm_white_insanity_mode;

init_clientfields() {
  clientfield::register("vehicle", "fx8_insanity_wisp", 18000, 1, "int", &function_4b104fc5, 0, 0);
}

init_fx() {
  level._effect[#"fx8_insanity_wisp"] = #"hash_75046ca8114af653";
}

function_4b104fc5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self.fx = util::playFXOnTag(localclientnum, level._effect[#"fx8_insanity_wisp"], self, "tag_origin");

    if(!isDefined(self.sfx)) {
      self playSound(0, #"zmb_wisp_appear");
      self.sfx = self playLoopSound(#"zmb_wisp_close_lp");
    }

    return;
  }

  stopfx(localclientnum, self.fx);

  if(isDefined(self.sfx)) {
    self playSound(0, #"zmb_wisp_disappear");
    self stoploopsound(self.sfx);
    self.sfx = undefined;
  }
}