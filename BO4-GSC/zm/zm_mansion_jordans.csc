/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_jordans.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\load;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_utility;

#namespace mansion_jordans;

init() {
  clientfield::register("scriptmover", "" + #"hash_54cceab249a41cde", 8000, 1, "int", &function_5869f09a, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_336942eaf5fcd809", 8000, 1, "int", &function_c51132ba, 0, 0);

  clientfield::register("<dev string:x38>", "<dev string:x46>" + #"hash_3efe70d8ad68a07d", 8000, 4, "<dev string:x49>", &function_230ff6dc, 0, 0);
  clientfield::register("<dev string:x38>", "<dev string:x46>" + #"hash_4d30672cd0a2ef31", 8000, 1, "<dev string:x49>", &function_bb6fcc6a, 0, 0);

}

function_5869f09a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_5d1596c4)) {
    killfx(localclientnum, self.var_5d1596c4);
    self.var_5d1596c4 = undefined;
    playSound(localclientnum, #"hash_3c3c2809ce13808", self.origin);
    self.var_5d1596c4 = undefined;
  }

  if(newval) {
    self.var_5d1596c4 = playFX(localclientnum, level._effect[#"candle_light"], self.origin + (0, 0, 6), anglesToForward(self.angles), anglestoup(self.angles));
    playSound(localclientnum, #"hash_6ab53d808ef366d5", self.origin);
  }
}

function_c51132ba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self playrenderoverridebundle(#"hash_429426f01ad84c8b");
}

function_bb6fcc6a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_a0a8631e)) {
    stopfx(localclientnum, self.var_a0a8631e);
    self.var_a0a8631e = undefined;
  }

  if(newval) {
    self.var_a0a8631e = util::playFXOnTag(localclientnum, level._effect[#"pap_projectile"], self, "<dev string:x4f>");
  }
}

function_230ff6dc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  while(true) {
    print3d(self.origin, newval, (1, 1, 0), 1, 0.4, 15);
    wait 0.2;
  }
}

