/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_debris_buys.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace zm_white_debris_buys;

autoexec __init__system__() {
  system::register(#"zm_white_debris_buys", &init, undefined, undefined);
}

init() {
  clientfield::register("zbarrier", "" + #"hash_7e15d8abc4d6c79a", 1, 1, "int", &function_32f95e3f, 0, 0);
}

function_32f95e3f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    for(i = 0; i < self getnumzbarrierpieces(); i++) {
      var_a6b8d2c2 = self zbarriergetpiece(i);
      var_a6b8d2c2 playrenderoverridebundle("rob_zm_white_crate_clear");
    }

    return;
  }

  for(i = 0; i < self getnumzbarrierpieces(); i++) {
    var_a6b8d2c2 = self zbarriergetpiece(i);
    var_a6b8d2c2 stoprenderoverridebundle("rob_zm_white_crate_clear");
  }
}