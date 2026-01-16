/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape_catwalk_event.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_escape_catwalk_event;

init_fx() {
  level._effect[#"hash_46085f7d2bcd82c5"] = #"hash_404575a78667befd";
}

init_clientfields() {
  clientfield::register("scriptmover", "" + #"hash_144c7c2895ed95c", 1, 1, "int", &function_a3874ae0, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_48f1f50c412d80c7", 1, 1, "counter", &function_1fe913e0, 0, 0);
}

function_a3874ae0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.n_fx_id)) {
    killfx(localclientnum, self.n_fx_id);
  }

  if(newval) {
    self.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"hash_46085f7d2bcd82c5"], self, "tag_origin");
  }
}

function_1fe913e0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self playrumbleonentity(localclientnum, #"zm_escape_catwalk_door");
}