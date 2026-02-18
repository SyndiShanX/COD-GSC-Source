/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7d8e141380aa3f06.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_fa39a5c3;

function private autoexec __init__system__() {
  system::register(#"hash_5a3be2f74ac4fe03", &preinit, undefined, undefined, undefined);
}

function preinit() {
  clientfield::register("toplayer", "" + # "hash_69dc133e22a2769f", 16000, 1, "int", &function_6b66a9a3, 0, 0);
}

function function_2376fab8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    util::playFXOnTag(fieldname, #"hash_48761360bb67e8a9", self, "tag_origin");
    self.var_a3b04735 = self playLoopSound(#"hash_722697efdfb3562f");
  }
}

function function_6b66a9a3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    forcestreamxmodel(#"p9_fxp_zm_teleport_tunnel");
    forcestreamxmodel(#"p9_fxp_zm_teleport_tunnel_edge");
    function_3385d776(#"zombie/fx9_aether_tear_portal_tunnel_1p");
    return;
  }

  stopforcestreamingxmodel(#"p9_fxp_zm_teleport_tunnel");
  stopforcestreamingxmodel(#"p9_fxp_zm_teleport_tunnel_edge");
  function_c22a1ca2(#"zombie/fx9_aether_tear_portal_tunnel_1p");
}