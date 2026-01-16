/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_computer_system.csc
***********************************************/

#include scripts\core_common\clientfield_shared;

#namespace zm_white_computer_system;

preload() {
  init_clientfields();
}

init_clientfields() {
  clientfield::register("toplayer", "" + #"hash_33c373888aa78dc2", 20000, 1, "counter", &function_e67464c1, 0, 0);
}

function_e67464c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrumbleonentity(localclientnum, #"hash_38a12b73c9342fd9");
  }
}