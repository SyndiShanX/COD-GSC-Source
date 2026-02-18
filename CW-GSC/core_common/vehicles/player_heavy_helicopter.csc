/************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_heavy_helicopter.csc
************************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_heavy_helicopter;

function private autoexec __init__system__() {
  system::register(#"player_heavy_helicopter", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit(localclientnum) {
  vehicle::add_vehicletype_callback("helicopter_heavy", &function_8220feb0);
  clientfield::register("toplayer", "hind_gunner_postfx_active", 1, 1, "int", &function_44ad5e3e, 0, 1);
  clientfield::register("vehicle", "hind_compass_icon", 1, 2, "int", &hind_compass_icon, 0, 1);
}

function private function_8220feb0(localclientnum) {
  self.var_7d3d0f72 = 2;
}

function function_44ad5e3e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!self postfx::function_556665f2(#"hash_4a4dfccbf3585bcc")) {
      self postfx::playpostfxbundle(#"hash_4a4dfccbf3585bcc");
    }

    return;
  }

  if(self postfx::function_556665f2(#"hash_4a4dfccbf3585bcc")) {
    self postfx::stoppostfxbundle(#"hash_4a4dfccbf3585bcc");
  }
}

function hind_compass_icon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.scriptvehicletype) || self.scriptvehicletype != "helicopter_heavy") {
    return;
  }

  switch (bwastimejump) {
    case 0:
      self setcompassicon(#"hash_238039183607226d");
      break;
    case 1:
      self setcompassicon(#"hash_a6a2a558ed7bec6");
      break;
    case 2:
      self setcompassicon("");
      break;
  }
}