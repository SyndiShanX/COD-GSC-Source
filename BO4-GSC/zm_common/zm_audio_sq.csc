/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_audio_sq.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace zm_audio_sq;

init() {
  clientfield::register("scriptmover", "medallion_fx", 1, 1, "int", &function_6624b679, 0, 0);
  level._effect[#"medallion_exp"] = #"hash_4960d9278d639297";
}

function_6624b679(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    up = anglestoup(self.angles + (0, -90, -90));
    forward = anglesToForward(self.angles + (0, -90, -90));
    playFX(localclientnum, level._effect[#"medallion_exp"], self.origin, forward, up);
    playSound(localclientnum, #"hash_23ed06ab941bc579", self.origin);
  }
}