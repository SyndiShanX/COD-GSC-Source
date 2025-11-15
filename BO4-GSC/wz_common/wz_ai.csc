/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ai.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace wz_ai;

autoexec __init__system__() {
  system::register(#"wz_ai", &__init__, undefined, undefined);
}

private __init__() {
  clientfield::register("vehicle", "enable_on_radar", 1, 1, "int", &function_c85f904d, 1, 1);
  clientfield::register("actor", "enable_on_radar", 1, 1, "int", &function_c85f904d, 1, 1);
}

function_c85f904d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self enableonradar();
}