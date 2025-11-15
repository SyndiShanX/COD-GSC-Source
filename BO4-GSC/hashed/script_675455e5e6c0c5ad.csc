/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_675455e5e6c0c5ad.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace namespace_1063645;

init_clientfields() {
  clientfield::register("scriptmover", "" + #"hash_3e57db9b106dff0a", 1, 1, "int", &function_10675d52, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_4ccf2ce25e0dc836", 1, 1, "int", &function_c6b07c39, 0, 0);
  level._effect[#"hash_62343c2144d3f8d1"] = #"hash_e567a706dafea31";
}

function_10675d52(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"powerup_on_solo"], self, "tag_origin");
    return;
  }

  if(isDefined(self.n_fx_id)) {
    stopfx(localclientnum, self.n_fx_id);
  }
}

function_c6b07c39(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_3c43a180 = util::playFXOnTag(localclientnum, level._effect[#"hash_62343c2144d3f8d1"], self, "tag_animate");
    forcestreamxmodel(#"p8_zm_esc_nixie_tubes");
    forcestreamxmodel(#"p8_zm_esc_nixie_tubes_on");
    return;
  }

  if(isDefined(self.var_3c43a180)) {
    stopfx(localclientnum, self.var_3c43a180);
  }

  stopforcestreamingxmodel(#"p8_zm_esc_nixie_tubes");
  stopforcestreamingxmodel(#"p8_zm_esc_nixie_tubes_on");
}