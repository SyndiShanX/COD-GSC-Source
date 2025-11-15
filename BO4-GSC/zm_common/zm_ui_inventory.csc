/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_ui_inventory.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_inventory;

#namespace zm_ui_inventory;

autoexec __init__system__() {
  system::register(#"zm_ui_inventory", &__init__, undefined, undefined);
}

private __init__() {
  clientfield::register_bgcache("clientuimodel", "string", "hudItems.zmFeatureDescription", 1, undefined, 0, 0);
  zm_inventory::function_c7c05a13();
  registeredfields = [];

  foreach(mapping in level.var_a16c38d9) {
    if(!isDefined(registeredfields[mapping.var_cd35dfb2])) {
      registeredfields[mapping.var_cd35dfb2] = 1;
      var_9cf9ba9 = "worlduimodel";

      if(isDefined(mapping.ispersonal)) {
        var_9cf9ba9 = "clientuimodel";
      }

      clientfield::register(var_9cf9ba9, mapping.var_cd35dfb2, 1, mapping.numbits, "int", undefined, 0, 0);
    }
  }
}