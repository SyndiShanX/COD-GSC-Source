/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2e2951db45188d3b.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_4ea0b0e1;

function private autoexec __init__system__() {
  system::register(#"hash_3092c343f49326ae", &_preload, undefined, undefined, undefined);
}

function private _preload() {
  function_bc948200();
}

function function_bc948200() {
  clientfield::register("toplayer", "return_to_combat_postfx", 1, 1, "int", &function_f343c90c, 0, 0);
}

function private function_f343c90c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump == 1) {
    if(self postfx::function_556665f2("pstfx_t9_cp_sepia")) {
      self postfx::stoppostfxbundle("pstfx_t9_cp_sepia");
    }

    self postfx::playpostfxbundle("pstfx_t9_cp_sepia");
    return;
  }

  if(self postfx::function_556665f2("pstfx_t9_cp_sepia")) {
    self postfx::stoppostfxbundle("pstfx_t9_cp_sepia");
  }
}