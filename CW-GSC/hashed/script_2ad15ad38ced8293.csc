/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2ad15ad38ced8293.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace namespace_2d7ccca3;

function private autoexec __init__system__() {
  system::register(#"hash_3dcfc06bf6bfc5f5", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("hudItems.ammoCooldowns.fieldUpgrade", #"hud_items", [#"hash_2f126bd99a74de8b", #"fieldupgrade"], 1, 5, "float", undefined, 0, 0);
  clientfield::register("missile", "fieldUpgradeActive", 1, 1, "int", &function_5fbd38e2, 0, 0);
}

function private function_5fbd38e2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self function_1f0c7136(1);
  }
}