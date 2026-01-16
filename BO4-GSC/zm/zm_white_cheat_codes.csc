/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_cheat_codes.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_white_cheat_codes;

init() {
  init_clientfields();
  init_fx();
}

init_clientfields() {
  clientfield::register("scriptmover", "" + #"hash_7876f33937c8a764", 20000, 1, "int", &vomit, 0, 0);
}

init_fx() {
  level._effect[#"fx8_blightfather_vomit_object"] = "zm_ai/fx8_blightfather_vomit_object";
}

vomit(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_39c21153)) {
    stopfx(localclientnum, self.var_39c21153);
    self.var_39c21153 = undefined;
  }

  if(newval) {
    self.var_39c21153 = util::playFXOnTag(localclientnum, level._effect[#"fx8_blightfather_vomit_object"], self, "tag_origin");
  }
}