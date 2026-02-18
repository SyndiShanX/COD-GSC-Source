/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_ui_inventory.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_inventory;
#namespace zm_ui_inventory;

function private autoexec __init__system__() {
  system::register(#"zm_ui_inventory", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::function_91cd7763("string", "hudItems.zmFeatureDescription", #"hud_items", #"zmfeaturedescription", 1, undefined, 0, 0);
  zm_inventory::function_c7c05a13();
  registeredfields = [];

  foreach(mapping in level.var_a16c38d9) {
    if(!isDefined(registeredfields[mapping.var_cd35dfb2])) {
      registeredfields[mapping.var_cd35dfb2] = 1;

      if(is_true(mapping.ispersonal)) {
        clientfield::register_clientuimodel(mapping.var_cd35dfb2, mapping.var_a88efd0b, mapping.var_2972a1c0, 1, mapping.numbits, "int", undefined, 0, 0);
        continue;
      }

      clientfield::function_5b7d846d(mapping.var_cd35dfb2, mapping.var_a88efd0b, mapping.var_2972a1c0, 1, mapping.numbits, "int", undefined, 0, 0);
    }
  }
}