/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_items.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_items;

autoexec __init__system__() {
  system::register(#"zm_items", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("item", "highlight_item", 1, 2, "int", &function_39e7c9dd, 0, 0);
}

function_39e7c9dd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrenderoverridebundle("rob_sonar_set_friendly");
    return;
  }

  self stoprenderoverridebundle("rob_sonar_set_friendly");
}