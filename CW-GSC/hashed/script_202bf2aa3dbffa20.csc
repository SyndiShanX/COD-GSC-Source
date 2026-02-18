/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_202bf2aa3dbffa20.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_4faef43b;

function private autoexec __init__system__() {
  system::register(#"hash_3793eb4a6c52c66f", &__init__, undefined, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "" + # "hash_322ed89801938bb9", 1, 1, "counter", &function_40fcb7b0, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_6d9aa5215e695ca2", 1, 1, "counter", &function_65502dee, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_1f232116f775fa91", 1, 1, "counter", &function_de8dd244, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_4719ef7fda616f3a", 1, 1, "counter", &function_b6000359, 0, 0);
  clientfield::register_clientuimodel("hudItems.reinforcing", #"hud_items", #"reinforcing", 1, 1, "int", undefined, 0, 0);
}

function function_de8dd244(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    playFX(fieldname, "destruct/fx9_dmg_window_wood_wz", self.origin, anglesToForward(self.angles) + (0, 90, 0), anglestoup(self.angles));
  }
}

function function_b6000359(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    playFX(fieldname, "destruct/fx9_dest_window_wood_wz", self.origin, anglesToForward(self.angles) + (0, 90, 0), anglestoup(self.angles));
  }
}

function function_40fcb7b0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    playFX(fieldname, "destruct/fx9_dmg_door_metal_wz", self.origin, anglesToForward(self.angles) + (0, 90, 0), anglestoup(self.angles));
  }
}

function function_65502dee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    playFX(fieldname, "destruct/fx9_dest_door_metal_wz", self.origin, anglesToForward(self.angles) + (0, 90, 0), anglestoup(self.angles));
  }
}