/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_audiologs.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_audiologs;

preload() {
  level._effect[#"sam_orb"] = #"hash_445f04139d92c61b";
  clientfield::register("scriptmover", "" + #"hash_4a18e1ea1950215d", 24000, 1, "int", &function_db7a9c9d, 0, 0);
}

function_db7a9c9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    self.var_af793e2d = util::playFXOnTag(localclientnum, level._effect[#"sam_orb"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_af793e2d)) {
    stopfx(localclientnum, self.var_af793e2d);
  }
}