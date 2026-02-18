/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\hazard.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace hazard;

function private autoexec __init__system__() {
  system::register(#"hazard", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "hazard_gas", 1, 1, "int", &hazard_gas, 0, 0);
  clientfield::register("toplayer", "hazard_gas_with_mask", 1, 1, "int", &hazard_gas_with_mask, 0, 0);
  level._effect[# "hash_667f50f096a9a290"] = "fire/fx_fire_ai_human_head_loop";
}

function hazard_gas(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    setblurbylocalclientnum(fieldname, 16, 1);
    return;
  }

  if(isDefined(self.var_bca8cc88)) {
    stopfx(fieldname, self.var_bca8cc88);
    self.var_bca8cc88 = undefined;
  }

  setblurbylocalclientnum(fieldname, 0, 3);
}

function hazard_gas_with_mask(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != fieldname) {
    if(bwastimejump) {
      setblurbylocalclientnum(binitialsnap, 2, 3);
      self thread function_f5b6d619();
      return;
    }

    setblurbylocalclientnum(binitialsnap, 0, 1);
    self notify(#"hash_452ba9cb2df33d3f");
    self postfx::exitpostfxbundle("pstfx_water_t_out");
  }
}

function function_f5b6d619() {
  self notify(#"hash_452ba9cb2df33d3f");
  self endon(#"death", #"hash_452ba9cb2df33d3f");

  while(true) {
    self postfx::playpostfxbundle("pstfx_water_t_out");
    wait 2.4;
  }
}