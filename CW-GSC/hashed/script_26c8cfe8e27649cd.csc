/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_26c8cfe8e27649cd.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#namespace namespace_379d0dc2;

function private autoexec __init__system__() {
  system::register(#"exfil", &_preload, undefined, undefined, undefined);
}

function private _preload() {
  clientfield::register("toplayer", "skyhook_speedblur", 1, 1, "int", &function_f343c90c, 0, 0);
}

function private function_f343c90c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump == 1) {
    if(self postfx::function_556665f2("pstfx_cp_skyhook_speedblur")) {
      self postfx::stoppostfxbundle("pstfx_cp_skyhook_speedblur");
    }

    self postfx::playpostfxbundle("pstfx_cp_skyhook_speedblur");
    return;
  }

  if(self postfx::function_556665f2("pstfx_cp_skyhook_speedblur")) {
    self postfx::exitpostfxbundle("pstfx_cp_skyhook_speedblur");
  }
}