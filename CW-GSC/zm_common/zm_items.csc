/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_items.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace zm_items;

function private autoexec __init__system__() {
  system::register(#"zm_items", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("item", "highlight_item", 1, 2, "int", &function_39e7c9dd, 0, 0);
  level thread function_f88c74e1();
}

function private function_f88c74e1() {
  while(isDefined(self)) {
    wait_result = level waittill(#"inventory_pickup");
    function_c79ecd60(wait_result.param1, wait_result.param2, undefined, undefined, wait_result.param3, undefined, undefined, undefined, undefined);
  }
}

function function_39e7c9dd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrenderoverridebundle("rob_sonar_set_friendly");
    return;
  }

  self stoprenderoverridebundle("rob_sonar_set_friendly");
}