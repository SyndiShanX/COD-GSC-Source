/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_nic_revolucion_fx.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace cp_nic_revolucion_fx;

function preload() {
  clientfield::register("toplayer", "cctv_cam_swap", 1, 1, "counter", &function_80614586, 0, 0);
  clientfield::register("toplayer", "cctv_cam_static", 1, 2, "int", &function_653d42c1, 0, 0);
  clientfield::register("vehicle", "ac130_runner", 1, 1, "int", &function_bf0e01f7, 0, 0);
}

function function_80614586(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    self postfx::stoppostfxbundle(#"hash_73422bbb830f0e2d");
    self postfx::playpostfxbundle(#"hash_73422bbb830f0e2d");
  }
}

function function_653d42c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    self postfx::stoppostfxbundle(#"hash_61c82b9155df8f6b");
    self postfx::stoppostfxbundle(#"hash_4428330acc3d3af0");
  }

  if(bwastimejump == 1) {
    self postfx::playpostfxbundle(#"hash_61c82b9155df8f6b");
  }

  if(bwastimejump == 2) {
    self postfx::playpostfxbundle(#"hash_4428330acc3d3af0");
  }
}

function function_bf0e01f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump > 0) {
    util::playFXOnTag(fieldname, "maps/cp_nic_revolucion/fx9_veh_gunship_exhausts_runner", self, "tag_origin");
  }
}