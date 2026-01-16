/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_711f23e6ccc0babd.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace namespace_3417f8d2;

autoexec __init__system__() {
  system::register(#"hash_684e9a488b07947", &init, undefined, undefined);
}

init() {
  init_fx();
  init_clientfields();
}

init_fx() {
  level._effect[#"hash_5cd079f7090da957"] = #"hash_468f18455c9e9e0f";
}

init_clientfields() {
  clientfield::register("scriptmover", "" + #"hash_671ee63741834a25", 1, 1, "int", &function_c95aa114, 0, 0);
}

function_c95aa114(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.blinking_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_5cd079f7090da957"], self, "tag_light");
    return;
  }

  if(isDefined(self.blinking_fx)) {
    deletefx(localclientnum, self.blinking_fx);
  }
}