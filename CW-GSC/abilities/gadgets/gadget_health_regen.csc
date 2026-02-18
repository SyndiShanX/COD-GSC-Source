/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_health_regen.csc
*****************************************************/

#using script_6e0a2f806b25fee3;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace gadget_health_regen;

function private autoexec __init__system__() {
  system::register(#"gadget_health_regen", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "healthregen", 1, 1, "int", &function_31f57700, 0, 1);
  clientfield::register_clientuimodel("hudItems.healingActive", #"hud_items", #"healingactive", 1, 1, "int", undefined, 0, 1);
  clientfield::register_clientuimodel("hudItems.numHealthPickups", #"hud_items", #"numhealthpickups", 1, 2, "int", undefined, 0, 1);
}

function function_31f57700(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame() || sessionmodeiscampaigngame()) {
    if(bwastimejump) {
      if(!is_true(self.var_b072e263)) {
        self.var_b072e263 = 1;
      }

      return;
    }

    if(is_true(self.var_b072e263)) {
      self.var_b072e263 = undefined;
    }
  }
}