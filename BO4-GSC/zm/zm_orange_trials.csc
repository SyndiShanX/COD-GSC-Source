/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_trials.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_trials;

preload() {
  level._effect[#"trials_lighthouse_beam"] = #"hash_7249b8c6a93aa3a3";
  clientfield::register("scriptmover", "" + #"hash_71906a124221219", 24000, 1, "int", &function_8532d13f, 0, 0);
  clientfield::register("scriptmover", "" + #"trials_lighthouse_beam", 24000, 1, "int", &function_804015d2, 0, 0);
}

function_8532d13f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_573d289)) {
    self stoploopsound(self.var_573d289);
    self.var_573d289 = undefined;
  }

  if(newval == 1) {
    self util::waittill_dobj(localclientnum);
    self.buff_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_69e92b9c52f7fe12"], self, "tag_origin");
    self.var_573d289 = self playLoopSound(#"hash_218e114cfa2b9a4");
    return;
  }

  if(isDefined(self.buff_fx)) {
    stopfx(localclientnum, self.buff_fx);
  }
}

function_804015d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self.fx = util::playFXOnTag(localclientnum, level._effect[#"trials_lighthouse_beam"], self, "tag_origin");
    return;
  }

  stopfx(localclientnum, self.fx);
}