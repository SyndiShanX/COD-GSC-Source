/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\cctv.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#namespace cctv;

function private autoexec __init__system__() {
  system::register(#"cctv", &_preload, undefined, undefined, undefined);
}

function private _preload() {
  function_bc948200();
}

function function_bc948200() {
  clientfield::register("toplayer", "cctv_postfx", 1, 1, "int", &function_3a6306b1, 0, 1);
  clientfield::register("toplayer", "cull_outside_nuke_room", 1, 1, "int", &function_e9459dfe, 0, 1);
}

function private function_3a6306b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(fieldname == 1) {
    if(self postfx::function_556665f2("pstfx_t9_cp_nic_revolucion_crt_on_fx")) {
      self postfx::stoppostfxbundle("pstfx_t9_cp_nic_revolucion_crt_on_fx");
    }

    self postfx::playpostfxbundle("pstfx_t9_cp_nic_revolucion_crt_on_fx");

    if(self function_d2cb869e("pstfx_t9_cp_crt_camera_fx")) {
      codestoppostfxbundlelocal(binitialsnap, "pstfx_t9_cp_crt_camera_fx");
    }

    function_a837926b(binitialsnap, "pstfx_t9_cp_crt_camera_fx");

    if(self function_d2cb869e("pstfx_t9_cp_crt_camera_fx")) {
      codestoppostfxbundlelocal(binitialsnap, "pstfx_t9_cp_crt_camera_fx");
    }

    function_a837926b(binitialsnap, "pstfx_t9_cp_crt_camera_fx");

    if(self function_d2cb869e("pstfx_t9_cp_crt_camera_fx")) {
      function_4238734d(binitialsnap, "pstfx_t9_cp_crt_camera_fx", "Cubic Distortion", 0.5);
      function_4238734d(binitialsnap, "pstfx_t9_cp_crt_camera_fx", "Lens Scale", 0.875);
    }

    return;
  }

  if(self function_d2cb869e("pstfx_t9_cp_crt_camera_fx")) {
    codestoppostfxbundlelocal(binitialsnap, "pstfx_t9_cp_crt_camera_fx");

    if(!bwastimejump) {
      if(self postfx::function_556665f2("pstfx_t9_cp_nic_revolucion_crt_off_fx")) {
        self postfx::stoppostfxbundle("pstfx_t9_cp_nic_revolucion_crt_off_fx");
      }

      self postfx::playpostfxbundle("pstfx_t9_cp_nic_revolucion_crt_off_fx");
    }
  }
}

function private function_e9459dfe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    function_93620041(fieldname, "cull_outside_nuke_room");
    return;
  }

  function_9362afb8(fieldname, "cull_outside_nuke_room");
}